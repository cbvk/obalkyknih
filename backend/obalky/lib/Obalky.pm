package Obalky;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

use Carp;

use Obalky::BibInfo;
use Obalky::Tools;
use DateTime;
use utf8;

# FIX: move to Obalky::Config
our $ROOT_DIR = "/opt/obalky"; # je v obojim..
our $WWW_DIR = "$ROOT_DIR/www"; # je v obojim..
our $DEBUG = -e "$ROOT_DIR/debug" ? 1 : 0;
our $WWW_DOMAIN = "www.obalkyknih.cz"; # je v obojim..
$WWW_DOMAIN = "iris.mzk.cz:3000" if $DEBUG;
our $ADMIN_EMAIL = 'info@obalkyknih.cz';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a YAML file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

#		StackTrace
#		-Debug
use Catalyst qw/
		Unicode
		ConfigLoader 
		Static::Simple
		Authentication 
		Session 
		Session::Store::FastMmap 
		Session::State::Cookie
		/;

our $VERSION = '2.00';

# Configure the application. 
#
# Note that settings in Obalky.yml (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'Obalky',
    root => __PACKAGE__->path_to('www'),
    'View::TT' => {
	        TEMPLATE_EXTENSION => '.html',
		    ENCODING     => 'utf-8',
			render_die => 1,
	},
	'Plugin::Static::Simple' => {
		dirs => [ '/obalkyknih-scanner', ],
	},
    'session' => {
        expires => 3600,
        storage => "/tmp/.obalky-session",
    },
	'authentication' => {  
		use_session => 1,
		default_realm => 'members',
		realms => {
			members => {
				credential => { # ...
					class => 'Password',
					password_field => 'password',
					password_type => 'clear',
				},
				store => {
					class => 'DBIx::Class',
					user_class => 'DB::User',
					id_field => 'login',
					use_userdata_from_session => 1,          
				}
			}
		}
	},
);

### Authorization::ACL Rules
##__PACKAGE__->deny_access_unless(
##        "/books/form_create",
##        [qw/admin/],
##    );


sub visit { # kam s tim??
	my($pkg,$c) = @_;
	my $library = DB->resultset('Library')->find_by_referer(
		$c->req->referer || $c->req->param('referer'));

	my $cookie_visitor = $c->request->cookie('visitor_id');
	my $visitor = DB->resultset('Visitor')->get_visitor( $c->request->address,
		$cookie_visitor, $library);# if($library or $cookie);

	$c->response->cookies->{'visitor_id'} = {
		value => $visitor->id,
		path => '/',
		domain => $Obalky::WWW_DOMAIN,
		expires => '+100d',
	} if($visitor and not $cookie_visitor);

	my $session_info = $c->request->cookie('session_info');
	eval { $session_info = $session_info->value }; # ie/ff?

	unless($session_info) {
		$session_info = sprintf("%08d_%s_%06d",$visitor->id,
					DateTime->now(),int(rand(999999)));
		$c->response->cookies->{'session_info'} = {
			value => $session_info,
			path => '/',
			domain => $Obalky::WWW_DOMAIN,
		};
	}

	return($library,$session_info,$visitor);
}
# api/cover - knihovna+visitor, book, obalka, request 
# api/books - knihovna+visitor, [ obalka, request ]+



# Start the application
__PACKAGE__->setup;


=head1 NAME

Obalky - Catalyst based application

=head1 SYNOPSIS

    script/obalky_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Obalky::Controller::Root>, L<Catalyst>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
