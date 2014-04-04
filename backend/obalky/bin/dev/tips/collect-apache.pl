#!/usr/bin/perl -w

use Data::Dumper;

sub isbn_normalize {
	my($isbn) = @_;
	$isbn =~ s/\-//g;
	return "978".$1 if($isbn =~ /^(\d{9})[\dXx]$/);
	return $1       if($isbn =~ /^(\d{12})[\dXx]$/);
	return undef;
}

# 88.100.110.118 - - [09/Sep/2008:16:32:57 +0200] "GET /api/cover?isbn=9780240809212%20(pbk.%20:%20alk.%20paper)\xc2\xa00240809211%20(pbk.%20:%20alk.%20paper) HTTP/1.1" 302 237 "http://aleph.muni.cz/F/PID15HTRMTIV8K3J5BKG4JT9CY28CYAABFRXEVCXIVD65IYS7V-00721?func=find-b&request=reklama&find_code=WRD&local_base=MUB01&filter_code_2=WYR&filter_request_2=&filter_code_3=WYR&filter_request_3=&filter_code_1=WLN&filter_request_1=&filter_code_4=GNR&filter_request_4=&x=0&y=0" "Mozilla/4.0(compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322)"

my %months = ( "Jan" => 1, "Feb" => 2, "Mar" => 3, "Apr" => 4,
				"May" => 5, "Jun" => 6, "Jul" => 7, "Aug" => 8, 
				"Sep" => 9, "Oct" => 10, "Nov" => 11, "Dec" => 12 );

while(<>) {
	my($ip,$apache_time,$GET,$ref) = /^(\S+)\s\S+\s\S+\s\[([^\]]+)\]\s\"GET\s([^\"\s]+)[^\"]*\"\s\S+\s\S+\s\"([^\"]+)\"/ or next;
#	next unless($ref =~ /full-set/); # jen Aleph zaznamy...

	my @t = split(/\W/,$apache_time);
	my $time = sprintf("%04d%02d%02dT%02d%02d%02d",
				$t[2],$months{$t[1]},$t[0],$t[3],$t[4],$t[5]);

	my $session = $1 if($ref =~ /\/F\/(.*?)\-/);
	next unless($session);

	my $lib = $1 if($ref =~ /([^\.]+)\.cz/);
	next unless($lib);

#	my %id;
#	next unless($GET =~ /\/api\/cover\?(.*)/);
#	foreach(split(/\?/, $1)) {
#		$id{isbn} = isbn_normalize($1) if(/isbn=(.+)/);
#		$id{oclc} = $1 if(/oclc=(.+)/);
#	}
#	my $id = join("&", map { $_."=".$id{$_}  } grep $id{$_}, sort keys %id);

	next unless($GET =~ /\/api\/cover\?.*isbn\=([\d\-Xx]+)/);
	my $ean12 = isbn_normalize($1) or next;
#	next if($lib eq 'muni' or $lib eq 'mzk');

	print "$time $session $ean12 $lib\n";
	warn "Line $.\n" unless($. % 1_000_000);
}


