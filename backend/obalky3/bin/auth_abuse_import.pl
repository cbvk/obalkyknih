use FindBin;
use lib "$FindBin::Bin/../lib";
use Fcntl qw(:flock);

use Data::Dumper;
use DB;

open(CSV, '<', '/var/www/okcz/backend/obalky/bin/auth/no_portrait_autori_auth_data.csv');
while(<CSV>) {
	my $line = $_;
	$line =~ s/"([^"]+)"//g;
	my($id,$oai_identifier,$oai_datestamp,$auth_name,$auth_date,$auth_activity,$auth_occupation,$auth_biography,$auth_datestamp,$nkp_aut_url,$cover,$ts,$harvest_max_eshop,$harvest_last_time,$viafID) = split(/,/, $line);
	next if ($id eq 'id');
	warn Dumper($id);
	warn Dumper($cover);
	
	DB->resultset('Abuse')->create({
		auth => $id,
		cover => $cover,
		client_ip => '127.0.0.1',
		note => 'silueta'
	});
}


print "\n\n-----------[ DONE ]----------\n";