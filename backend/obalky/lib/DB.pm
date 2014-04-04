package DB;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use namespace::autoclean;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 06:34:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Lp5njuBXZpUWDE4pPtYn8g

#sub dsn  { $ENV{OBALKY_DSN}  ||= 'dbi:mysql:database=obalky;host=iris.mzk.cz' }
sub dsn  { $ENV{OBALKY_DSN}  ||= 'dbi:mysql:obalky' }
sub user { $ENV{OBALKY_USER} ||= 'obalky' }
#sub dsn  { $ENV{OBALKY_DSN}  ||= 'dbi:mysql:database=obalky_legacy' }
#sub user { $ENV{OBALKY_USER} ||= 'obalky_legacy' }
sub pass { $ENV{OBALKY_PASS} ||= 'visk2009' }


__PACKAGE__->connection(
    __PACKAGE__->dsn, __PACKAGE__->user, __PACKAGE__->pass,
    { debug => $ENV{DBIC_TRACE} || 0,
		mysql_enable_utf8 => 1,
		loader_options => { use_namespaces => 1} });


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
