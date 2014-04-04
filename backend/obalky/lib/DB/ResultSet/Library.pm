
package DB::ResultSet::Library;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub find_by_code {
	my($pkg,$code) = @_;
	return DB->resultset('Library')->find({ code => $code });
}

sub find_none { shift->find_by_code('none') }

sub normalize_url {
	my($pkg,$url) = @_;
	$url =~ s/^https?\:\/\///; $url =~ s/^www\.//;
	return $url;
}

my %g_libraries;
my $g_lib_time;

sub do_search {
	my($pkg,$referer) = @_;
    foreach(keys %g_libraries) {
		my $url = $g_libraries{$_}->{url} or next;
		if(substr($referer,0,length($url)) eq $url) {
			return $g_libraries{$_}->{library};
		}
	}
	return undef;
}

sub find_by_referer {
	my($pkg,$referer) = @_;

	# co 10 minut nacachuj seznam knihoven
	$pkg->load_libraries() if(not $g_lib_time or (time - $g_lib_time > 600));

	return $g_libraries{'obalky'}->{library} unless($referer);
	my $library = $pkg->do_search($pkg->normalize_url($referer));
	return $library ? $library : $g_libraries{'obalky'}->{library};
}

sub load_libraries {
	my($pkg) = @_;
	#warn "DB::Library -> loading libraries (time ".time.")\n";
	foreach($pkg->all) {
		$g_libraries{$_->code} = {
			url => $pkg->normalize_url($_->webopac),
			library => $_
		}
	}
	die "'obalky' library missing" unless($g_libraries{'obalky'});
	$g_lib_time = time;
}

1;
