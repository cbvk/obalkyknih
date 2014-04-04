
package Eshop::SimpleURL;
use base 'Eshop';
use utf8;

use Obalky::Media;
use Obalky::BibInfo;

use Data::Dumper;

sub harvest {
	my($self,$bibinfo,$dir) = @_;
	my($isbn,$ean,$isbn10,$isbn13) = $bibinfo->isbn_forms;
	return (undef) unless($isbn); # SimpleURL umi jenom pres ISBN
	foreach my $url ($self->url) {
		$url =~ s/9780123456789/$isbn13/;
		$url =~ s/0123456789/$isbn10/ if($isbn10);
		my $filename = Eshop->fetch_image($isbn13,$url,$dir);
    	my $bibinfo = Obalky::BibInfo->new_from_ean($ean); # zname jen EAN
		my $media = Obalky::Media->new_from_info({ cover_url => $url, 
					cover_tmpfile => $dir."/".$filename }) if($filename);
		return ($bibinfo,$media);
	}
	return (undef);
}

#package Eshop::AmazonImg;
#use base 'Eshop::SimpleURL';
#sub url { "http://ec2.images-amazon.com/images/P/0123456789.01.L.jpg" }
#__PACKAGE__->register(harvest => 1, license => 'licensed',
#					  test => '9781442140035' );

#package Eshop::LibraryThing;
#use base 'Eshop::SimpleURL';
#sub url {  # napr. http://www.librarything.com/work/965852 odkazuje na Amazon
#	"http://covers.librarything.com/devkey/33504605/large/isbn/0123456789" }
#__PACKAGE__->register(harvest => 1, license => 'licensed',
#					  test => '9780615174389');

package Eshop::Kanzelsberger;
use base 'Eshop::SimpleURL';
sub url { ("http://www.kanzelsberger.cz/knihy/9780123456789.jpg",
	       "http://www.kanzelsberger.cz/knihy/9780123456789.gif") }
__PACKAGE__->register(harvest => 0, license => 'licensed', czech => 1,
	title => 'Kanzelsberger', test => '9788071789222');

#package Eshop::Kosmas1;
#use base 'Eshop::SimpleURL';
#sub url { "http://www.kosmas.cz/images/isbn/orig/0123456789.gif" }
#__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
#					  test => '9788072943210');

#package Eshop::SCKN;
#use base 'Eshop::SimpleURL';
#sub url { ( "http://www.sckn.cz/ceskeknihy/images/covers/9780123456789.jpg",
#			"http://www.sckn.cz/ceskeknihy/images/covers_Orig/9780123456789.jpg" ) }
#__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
#					  test => '9788072983919');

1;
