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
our $TOC_DIR = "/opt/toc_export";

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

1;
