
package Obalky::Controller::Doc;

use strict;
use warnings;
use base 'Catalyst::Controller';

sub index : Local {
	my($self,$c) = @_;
#	$c->stash->{books} = DB::Book->model->count;
#	$c->stash->{recent} = DB::Book->model->recent(3,3);

	$c->stash->{covers} = DB->resultset('Cover')->count;
	$c->stash->{tocs} = DB->resultset('Toc')->count; 
	$c->stash->{recent} = DB->resultset('Cover')->recent(3,3);
	$c->stash->{menu} = "index";

	$c->stash->{menu} = "doc";
}


#sub end : ActionClass('RenderView') {
sub end : Private {
	my($self,$c) = @_;
    return 1 if $c->response->status =~ /^3\d\d$/;
    return 1 if $c->response->body;
    unless ( $c->response->content_type ) {
        $c->response->content_type('text/html; charset=utf-8');
    }

    if($c->stash->{menu}) {
        my $menu = "menu_".$c->stash->{menu};
        $c->stash->{$menu} = "menu_selected";
    }
	$c->forward('Obalky::View::TT');	

}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

1;
