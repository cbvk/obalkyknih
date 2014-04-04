
package Obalky::Controller::Util;

use strict;
use warnings;
use base 'Catalyst::Controller';

sub import_dir : Local {
    my($self,$c) = @_;
    $c->response->body('Matched Obalky::Controller::Main in Main.');
}

1;
