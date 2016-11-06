
package Eshop::Upload;
use base 'Eshop';
use utf8;

use Obalky::Media;
use Obalky::BibInfo;

# Interni "eShop" -- data nahrana na obalkyknih.cz

use DB; 
# tento zdroj vyuziva nasi databazi jako primarni zdroj dat!
# FIX: presun upload do nejake slozky/fronty.. (insert/, backup/)

#sub restore? { }

__PACKAGE__->register(license => 'free', czech => 1, display => 0,
	title => 'obalky-legacy', test => '9788072038848' );

1;
