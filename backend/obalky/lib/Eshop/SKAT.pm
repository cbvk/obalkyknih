
package Eshop::OAI;
use base 'Eshop';
use utf8;

use DateTime;
use Data::Dumper;
use Net::OAI::Harvester;
use UniMARC;

#$Net::OAI::Harvester::DEBUG = 1;

use Obalky::BibInfo;
use Storable;

sub crawl {
	my($self,$storable,$from,$to) = @_;	
	
##    # store already uploaded ids to /tmp file
##    my $seenfile = '/tmp/.obalky-skat';
###	  my $seenfile = '/tmp/.obalky-skat-'.$from->strftime('%F');
##    my $seen = eval { retrieve($seenfile) } || {}; # cache..

	my $oai = Net::OAI::Harvester->new(baseURL => $self->baseURL);

	my $records = $oai->listAllRecords(
					metadataPrefix => $self->metadataPrefix,
					metadataHandler => $self->metadataHandler, 
					set => $self->recordSet,
					from => $from->ymd, 'until' => $to->ymd);
	my @list;

	while ( my $record = $records->next() ) {
        my $meta = $record->metadata();
		## print $meta->{id}.":".$meta->{x00}."\n";
		$meta->{url} = $1 if($meta->{x00} =~ /(http\S+)/);
		# pokud odkazuji na zmenseninu, oprav na plnou velikost
		$meta->{url} =~ s/^(.*kanzelsberger.*)(\/m\/m\_)/$1\//;
		warn $meta->{id}.": cover URL missing\n" 
						if($meta->{id} and not $meta->{url});
		next unless($meta->{id} and $meta->{url});
##		next if($seen->{$meta->{id}}++);

		my $url = $self->fixurl($meta->{id},$meta->{url});
		next unless $url;

		my $bibinfo = Obalky::BibInfo->new_from_params(
						{ isbn => $meta->{isbn} });
		next unless($bibinfo);

		my $media = Obalky::Media->new_from_info({ cover_url => $url });

		push @list, [$bibinfo,$media];
	}
##    store $seen, $seenfile;

	return @list;
}

package Eshop::SKAT;
use base 'Eshop::OAI';

__PACKAGE__->register(crawl => 0, license => 'licensed', title => 'SKAT' );

sub baseURL { 'http://www.vkta.cz/obalky/l.dll' }
sub metadataPrefix { 'unimarc' }
sub metadataHandler { 'UniMARC' }
sub recordSet { 'OBA' }

sub fixurl {
	my($self,$id,$naweb) = @_;
	my($prefix) = ($id =~ /^..(\d{5})/) or return $naweb;
	my($http,$path) = ($naweb =~ /^(https?\:\/\/)(NAWEB\/.+)$/i) 
			or return $naweb;
	my %fix = (
		"31710" => "http://www.vkta.cz/clavius/",
		"31830" => "http://www.okpb.cz/clavius/",
		"31520" => "http://www.ok-litomerice.cz/clavius/",
		"31990" => "http://www.knihovna.cz:1111/clavius/",
		"31160" => "http://katalog.knihovnabbb.cz/",
		"32520" => "http://lanius.kmp.plzen-city.cz/",
		"31700" => "http://www.kkvysociny.cz/clavius/",
		"31480" => "http://katalog.svkul.cz/",
	);
	return $fix{$prefix}.$path if($fix{$prefix});
	return undef;
}

# http://www.vkta.cz/obalky/l.dll?verb=ListRecords&from=2008-09-10&until=2008-09-30&metadataPrefix=unimarc&set=OBA

# http://www.vkta.cz/obalky/l.dll?verb=GetRecord&metadataPrefix=unimarc&identifier=ISXN9788024910543

1;
