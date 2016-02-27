package Obalky::Config;

use strict;
use warnings;


our $ROOT_DIR = "/opt/obalky"; # je v obojim..
our $WWW_DIR = "$ROOT_DIR/www"; # je v obojim..
our $DEBUG = -e "$ROOT_DIR/debug" ? 1 : 0;
our $WWW_DOMAIN = `hostname` =~ /think/ ? 
	"localhost:3000" : "www.obalkyknih.cz"; # je v obojim..
$WWW_DOMAIN = "iris.mzk.cz:3000" if $DEBUG;
our $WWW_URL = "http://$WWW_DOMAIN"; # jen tady..
our $HTTPS_URL = "https://$WWW_DOMAIN"; # jen tady..
our $LEGACY_URL = $WWW_URL; # jen tady.. (bez pripadneho debug)

our $SPACER_HTTPS_URL = $HTTPS_URL."/img/spacer.gif"; # jen tady
our $SPACER_HTTP_URL  =  $WWW_URL."/img/spacer.gif"; # jen tady

our $FRAME_IMG = $WWW_DIR."/img/frame.gif";

our $FILEBLOB_DIR = "/opt/store/fileblob_export";
our $PREVIEW510_DIR = "/opt/store/fileblob_preview510";
our $TOC_DIR = "/opt/toc_export";

our $RECAPTCHA_SECRET = '6LdFDxgTAAAAAIBauakFDUUq7hI5qbGiWACci-YU';
our $RECAPTCHA_SITEKEY = '6LdFDxgTAAAAAHQKFJBlrT351_ALAeQbq62dQLj6';

our $ICON_WIDTH = 54;
our $ICON_HEIGHT = 68;

our $THUMB_WIDTH = 27;
our $THUMB_HEIGHT = 36;

our $MEDIUM_WIDTH = 170;
our $MEDIUM_HEIGHT = 240;

sub url {
    my($pkg,$secure) = @_;
    return $secure ? "https://".$WWW_DOMAIN : "http://".$WWW_DOMAIN;
}

our %replace_punctation = (
    "\x{011b}" => "e",
    "\x{0161}" => "s",
    "\x{010d}" => "c",
    "\x{0159}" => "r",
    "\x{017e}" => "z",
    "\x{00fd}" => "y",
    "\x{00e1}" => "a",
    "\x{00ed}" => "i",
    "\x{00e9}" => "e",
    "\x{00fa}" => "u",
    "\x{016f}" => "u",
    "\x{0148}" => "n",
    "\x{013e}" => "l",
    "\x{013a}" => "l",
    "\x{00f4}" => "o",
    "\x{00e4}" => "a",
    "\x{011a}" => "e",
    "\x{0160}" => "s",
    "\x{010c}" => "c",
    "\x{0158}" => "r",
    "\x{017d}" => "z",
    "\x{00dd}" => "y",
    "\x{00c1}" => "a",
    "\x{00cd}" => "i",
    "\x{00c9}" => "e",
    "\x{00da}" => "u",
    "\x{016e}" => "u",
    "\x{0147}" => "n",
    "\x{013d}" => "l",
    "\x{0139}" => "l",
    "\x{00d4}" => "o",
    "\x{00c4}" => "a"
);

our %replace_months = (
	"leden" => "1",
	"unor" => "2",
	"brezen" => "3",
	"duben" => "4",
	"kveten" => "5",
	"cerven" => "6",
	"cervenec" => "7",
	"srpen" => "8",
	"zari" => "9",
	"rijen" => "10",
	"listopad" => "11",
	"prosinec" => "12"
);

1;
