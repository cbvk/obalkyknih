use utf8;
package DB;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-04-22 18:06:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AQeCCiXM6XEOiMnT9QTmCQ

use Data::Dumper;

sub dsn  { $ENV{OBALKY_DSN}  ||= '' }
sub user { $ENV{OBALKY_USER} ||= '' }
sub pass { $ENV{OBALKY_PASS} ||= '' }


__PACKAGE__->connection(
    __PACKAGE__->dsn, __PACKAGE__->user, __PACKAGE__->pass,
    { debug => $ENV{DBIC_TRACE} || 0,
		mysql_enable_utf8 => 1,
		loader_options => { use_namespaces => 1} });


=head2 pagination

DB helper pro strankovani DB vystupu.
Stavove promenne uklada do session tj. i po delsi dobe je mozne vratit se k puvodni poloze v katalogu.

param c Catalyst controller
param dbname Nazev DB resultsetu

=cut

sub pagination {
	my ($c, $dbname, $where, $group_by) = @_;
	my ($page,$order,$order_dir,$per_page,$filter_val,$filter_key) = (undef,undef,undef,undef,undef,undef,undef);
	
	# Naloaduj ulozenou strankovaci pozici
	my $saved_session = $c->request->cookie($dbname.'_paging');
	if ($saved_session) {
		my $admin_library_paging = $saved_session->{value};
    	my ($page,$order,$order_dir,$per_page) = @$admin_library_paging;
	}
    
    # Nastav strankovaci promenne
    $page = $c->req->param('p') || $page || 1;
    $order = $c->req->param('o') || $order || 'id';
    $order_dir = $c->req->param('od') || $order_dir || -1;
    $per_page = $c->req->param('pp') || $per_page || 50;
    $filter_val = $c->req->param('fv') if ($c->req->param('fv'));
    $filter_key = $c->req->param('fk') if ($c->req->param('fk'));
    $where->{$filter_key} = { "-like"=>"%$filter_val%"} if ($filter_key);
    my $total_count = __PACKAGE__->resultset($dbname)->search($where, $group_by)->count;
    my $max_page = int($total_count/$per_page)+1;
    $page = $max_page if ($page > $max_page);
	$c->response->cookies->{$dbname.'_paging'} = {value=>[$page,$order,$order_dir,$per_page]};
	# Vsechno co viewer potrebuje
	return($page, $max_page, $per_page, $order, $order_dir, $filter_val, $filter_key);
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
