use FindBin;
use lib "$FindBin::Bin/../lib";
use Fcntl qw(:flock);

use Data::Dumper;
use DB;

my $cnt = 0;
foreach (DB->resultset('AuthTmp')->search({ 'status' => 0 })->all) {
	next if ($_->get_column('nazev') eq '');
	
	my @words = split / /, $_->get_column('nazev');
	my $searchPhrase;
	
	# auth name
	$searchPhrase->{'-and'} = [ ];
	foreach (@words) {
		push $searchPhrase->{'-and'}, 'auth_name', { '-like' => '%'.$_.'%' };
	}
	
	#auth date
	push $searchPhrase->{'-and'}, 'auth_date', { '-like' => $_->get_column('datum').'%' } if ($_->get_column('datum') ne '' and $_->get_column('datum') ne '*');
	
	my $resAuth = DB->resultset('Auth')->search($searchPhrase);
	
	$cnt++;
	print '#' . $cnt . "\n";
	next if ($resAuth->count ne 1);
	
	my $auth = $resAuth->next;
	
	$_->update({ 'status' => 1, 'authID' => $auth->id, 'okczUrl' => 'http://www.obalkyknih.cz/view_auth?auth_id='.$auth->id });
	
	print '>>> ' . $auth->id . "\n";
}


print "\n\n-----------[ KONEC ]----------\n";