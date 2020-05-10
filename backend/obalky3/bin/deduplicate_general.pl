#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use Data::Dumper;
use URI::Escape;

no warnings qw(uninitialized);

use Fcntl qw(:flock);
#Vylucny beh scriptu
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
	sleep 3600;
	last;
}

# id_from - od tohoto ID zaznamu v tablke book
# id_to   - do tohoto ID zaznamu v tablke book
my($mode,$id_from,$id_to) = @ARGV;
die "\nusage: DEBUG=100 $0 [test|production book_id_start book_id_end]\n\n"
		unless($mode);

# ak nie je definovane, doplni ID mojho testovacieho prostredia
$id_from = 110746616 unless($id_from);
$id_to = 127501000 unless($id_to);

my $search_params;
$search_params = {
	'id' => {'>=', $id_from},
	'id' => {'<=', $id_to},
	'cover' => {'!=', undef}
};

my $books = DB->resultset('Book')->search($search_params);

foreach ($books->all) {
	my $book_master = $_;
	print 'book_id: '.$book_master->id."\n";
	print 'ean13: '.$book_master->get_column('ean13').' | nbn: '.$book_master->get_column('nbn').' | oclc: '.$book_master->get_column('oclc')."\n";
	print 'titul: '.$book_master->get_column('title').' | autor: '.$book_master->get_column('authors')."\n";
	
	###
	# vyhladaj zaznamy k deduplikacii podla << ISBN >>
	###
	if ($book_master->get_column('ean13')) {
		my $search_params_slave = {
			'ean13' => $book_master->get_column('ean13')
		};
		my $res_slave = DB->resultset('Book')->search($search_params_slave);
		foreach ($res_slave->all) {
			my $book_slave = $_;
			next if ($book_master->id == $book_slave->id); # ten isty zaznam preskakujeme
			next if ($book_slave->get_column('part_type')); # nespracuvame periodika
			print "\n".'     podle EAN13 > '.$book_slave->id.' | '.$book_slave->get_column('title')."\n";
			
			# porovnaj master a slave zaznam
			my $diff = compare_book('ean13', $book_master, $book_slave);
			next if $diff == -1; # kolizia
			print "\n     NOVE HODNOTY MASTER ZAZNAMU:\n" if ($diff);
			print "\n     SLAVE ZAZNAM NEMA PRO MASTER ZAZNAMU NIC NOVE\n" unless ($diff);
			warn Dumper($diff);
			next if ($mode eq 'test');
			
			# merge zaznamov
			merge_book($book_master, $book_slave, $diff);
		}
	}
	
	###
	# vyhladaj zaznamy k deduplikacii podla << NBN >>
	###
	if ($book_master->get_column('nbn')) {
		my $search_params_slave = {
			'nbn' => $book_master->get_column('nbn')
		};
		my $res_slave = DB->resultset('Book')->search($search_params_slave);
		foreach ($res_slave->all) {
			my $book_slave = $_;
			next if ($book_master->id == $book_slave->id); # ten isty zaznam preskakujeme
			next if ($book_slave->get_column('part_type')); # nespracuvame periodika
			print "\n".'     podle NBN > '.$book_slave->id.' | '.$book_slave->get_column('title')."\n";
			
			# porovnaj master a slave zaznam
			my $diff = compare_book('nbn', $book_master, $book_slave);
			next if $diff == -1; # kolizia
			print "\n     NOVE HODNOTY MASTER ZAZNAMU:\n" if ($diff);
			print "\n     SLAVE ZAZNAM NEMA PRO MASTER ZAZNAMU NIC NOVE\n" unless ($diff);
			warn Dumper($diff);
			next if ($mode eq 'test');
			
			# merge zaznamov
			merge_book($book_master, $book_slave, $diff);
		}
	}
	
	###
	# vyhladaj zaznamy k deduplikacii podla << OCLC >>
	###
	if ($book_master->get_column('oclc')) {
		my $search_params_slave = {
			'oclc' => $book_master->get_column('oclc')
		};
		my $res_slave = DB->resultset('Book')->search($search_params_slave);
		foreach ($res_slave->all) {
			my $book_slave = $_;
			next if ($book_master->id == $book_slave->id); # ten isty zaznam preskakujeme
			next if ($book_slave->get_column('part_type')); # nespracuvame periodika
			print "\n".'     podle OCLC > '.$book_slave->id.' | '.$book_slave->get_column('title')."\n";
			
			# porovnaj master a slave zaznam
			my $diff = compare_book('oclc', $book_master, $book_slave);
			next if $diff == -1; # kolizia
			print "\n     NOVE HODNOTY MASTER ZAZNAMU:\n" if ($diff);
			print "\n     SLAVE ZAZNAM NEMA PRO MASTER ZAZNAMU NIC NOVE\n" unless ($diff);
			warn Dumper($diff);
			next if ($mode eq 'test');
			
			# merge zaznamov
			merge_book($book_master, $book_slave, $diff);
		}
	}
	
	print "\n------------------\n";
}



#######################################################################
# POROVNAJ 2 TITULY A ROZHODNI, CO ZO SLAVE PRENIEST NA MASTER ZAZNAM
#######################################################################

sub compare_book {
	my($searched_param,$book_master,$book_slave) = @_;
	my $diff;
	
	my $ean13_match = (($book_master->get_column('ean13') eq $book_slave->get_column('ean13')) or (not $book_master->get_column('ean13')) or (not $book_slave->get_column('ean13')));
	my $nbn_match   = (($book_master->get_column('nbn') eq $book_slave->get_column('nbn')) or (not $book_master->get_column('nbn')) or (not $book_slave->get_column('nbn')));
	my $oclc_match  = (($book_master->get_column('oclc') eq $book_slave->get_column('oclc')) or (not $book_master->get_column('oclc')) or (not $book_slave->get_column('oclc')));
	
	# kolizie identifikatorov
	if ((not $ean13_match) or (not $nbn_match) or (not $oclc_match)) {
		warn ' !!! KOLIZIA !!!   '.$book_master->get_column('ean13').'|'.$book_master->get_column('nbn').'|'.$book_master->get_column('oclc').'   x   '.$book_slave->get_column('ean13').'|'.$book_slave->get_column('nbn').'|'.$book_slave->get_column('oclc');
		return -1;
	}
	
	# dopln identifikatory 
	$diff->{'ean13'} = $book_slave->get_column('ean13') if ($book_master->get_column('ean13') ne $book_slave->get_column('ean13') and not $book_master->get_column('ean13'));
	$diff->{'nbn'} = $book_slave->get_column('nbn') if ($book_master->get_column('nbn') ne $book_slave->get_column('nbn') and not $book_master->get_column('nbn'));
	$diff->{'oclc'} = $book_slave->get_column('oclc') if ($book_master->get_column('oclc') ne $book_slave->get_column('oclc') and not $book_master->get_column('oclc'));
	$diff->{'ismn'} = $book_slave->get_column('ismn') if ($book_master->get_column('ismn') ne $book_slave->get_column('ismn') and not $book_master->get_column('ismn'));
	
	# dopln autora a titul
	$diff->{'authors'} = $book_slave->get_column('authors') if ($book_master->get_column('authors') ne $book_slave->get_column('authors') and not $book_master->get_column('authors'));
	$diff->{'title'} = $book_slave->get_column('title') if ($book_master->get_column('title') ne $book_slave->get_column('title') and not $book_master->get_column('title'));
	
	# obalka s vyssim rozlisenim
	# master zaznam obalku musi mat, je to v podmienke master selektu
	if ($book_master->cover and $book_slave->cover) {
		my $master_resolution = $book_master->cover->get_column('orig_width') * $book_master->cover->get_column('orig_height');
		my $slave_resolution = $book_slave->cover->get_column('orig_width') * $book_slave->cover->get_column('orig_height');
		$diff->{'cover'} = $book_slave->cover->id if ($master_resolution < $slave_resolution);
	}
	
	# dopln toc
	$diff->{'toc'} = $book_slave->get_column('toc') if ($book_slave->get_column('toc') and not $book_master->get_column('toc'));
	
	# anotacia
	$diff->{'review'} = $book_slave->get_column('review') if ($book_slave->get_column('review') and not $book_master->get_column('review'));
	
	# hodnotenie
	if ($book_slave->get_column('cached_rating_count')) {
		$diff->{'cached_rating_count'} = $book_master->get_column('cached_rating_count') + $diff->{'cached_rating_count'};
		$diff->{'cached_rating_sum'} = $book_master->get_column('cached_rating_sum') + $diff->{'cached_rating_sum'};
	}
	
	# citacia
	if ($book_slave->get_column('citation') and not $book_master->get_column('citation')) {
		$diff->{'citation'} = $book_slave->get_column('citation');
		$diff->{'citation_time'} = $book_slave->get_column('citation_time');
		$diff->{'citation_source'} = $book_slave->get_column('citation_source');
	}
	
	return $diff;
}



#######################################################################
# MERGUJ 2 TITULY
#######################################################################

sub merge_book {
	my($book_master,$book_slave,$diff) = @_;
	my $id_master = $book_master->id;
	my $id_slave = $book_slave->id;
	
	# cover
	$book_master->update({ cover => $diff->{'cover'} }) if ($diff->{'cover'});
	
	# toc
	$book_master->update({ toc => $diff->{'toc'} }) if ($diff->{'toc'});
	
	# anotacia
	$book_master->update({ review => $diff->{'review'} }) if ($diff->{'review'});
	
	# citacia
	$book_master->update({
		citation => $diff->{'citation'},
		citation_time => $diff->{'citation_time'},
		citation_source => $diff->{'citation_source'}
	}) if ($diff->{'review'});
	
	# identifikatory a nazvy
	$book_master->update({ ean13 => $diff->{'ean13'} }) if ($diff->{'ean13'});
	$book_master->update({ nbn => $diff->{'nbn'} }) if ($diff->{'nbn'});
	$book_master->update({ ismn => $diff->{'ismn'} }) if ($diff->{'ismn'});
	$book_master->update({ oclc => $diff->{'oclc'} }) if ($diff->{'oclc'});
	$book_master->update({ title => $diff->{'title'} }) if ($diff->{'title'});
	$book_master->update({ authors => $diff->{'authors'} }) if ($diff->{'authors'});
	
	###
	# VYMAZ SLAVE
	###
	
	DB->resultset('FeSync')->book_sync_remove($book_slave->id, undef, 1);
	
 	my $dbh = DBI->connect(DB->dsn,DB->user,DB->pass);
 	my $sth = $dbh->prepare("SET FOREIGN_KEY_CHECKS=0"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM product WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM cover WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM toc WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM review WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM tip WHERE book1 = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM tip WHERE book2 = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM tag WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM book_relation WHERE book_parent = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM book_relation WHERE book_relation = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM abuse WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("DELETE FROM product_params WHERE book = $id_slave"); $sth->execute();
 	$sth = $dbh->prepare("SET FOREIGN_KEY_CHECKS=1"); $sth->execute();
	$sth->finish();
	$dbh->disconnect();
	
	$book_slave->delete();
	
	$book_master->recalc_rating;
	$book_master->recalc_review;
	$book_master->invalidate(1);
}