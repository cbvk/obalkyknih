use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Obalky' }
BEGIN { use_ok 'Obalky::Controller::Root' }

ok( request('/index')->is_success, 'Request should succeed' );


