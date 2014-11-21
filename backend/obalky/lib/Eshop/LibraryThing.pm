package Eshop::LibraryThing;
use base 'Eshop';
use utf8;

use LWP::UserAgent;
use Data::Dumper;
use JSON;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

__PACKAGE__->register(harvest => 1,	title => 'LibraryThing', test => '9780007874415');

my $LT_KEY = '3621e794dde9f64d84834ce78e319fb7';

sub harvest {
	my($self,$search,$dir) = @_;
	my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;
	
	return unless ($isbn13);
	my $url_cover = 'http://covers.librarything.com/devkey/'.$LT_KEY.'/large/isbn/'.$isbn13;
	
	# nacti aktualni knihu; bude pouzita pro rozhodovani, jestli nahrat obalku, ...
	my $origBook;
	my $resOrigBook = DB->resultset('Book')->search({ ean13 => $search->{ean13} });
	$origBook = $resOrigBook->next if ($resOrigBook);
	
	# neposilej dotaz na LIBRARY THING API pokud uz existuje obalka
	return () if ($origBook->get_column('cover'));
	
	# dotaz na GOOGLE BOOKS API
warn Dumper($url_cover);
    my $ua = LWP::UserAgent->new;
	$ua->timeout(10);
	my $request;
	$request = HTTP::Request->new(GET => $url_cover);
	my $response = $ua->request($request);
	return(undef,undef,$url_cover) if ($response->header('content-length')<100); # GIF placeholder = LibraryThing nema obrazek
	
	# vytvor bibinfo
	my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $isbn13 });
	
	# obalka
	my $media_info;
	$media_info->{cover_url} = $url_cover;
	
	my $media = Obalky::Media->new_from_info( $media_info );
	
	return ($bibinfo,$media,$url_cover);
}

1;
