#!/usr/bin/perl -w

use Time::Local;

# 20080909T163238 3UL6LJ8VYQUEBITQ98LFDDVYV9DXV6GQSNXC9QIXIBX1T8ED9Y 
# 978808642957 muni
#


my %ids = ();

sub day_change {
	my($a,$b) = @_;
	$a =~ s/T.*//;
	$b =~ s/T.*//;
	print "$a - $b\n";
	return $a - $b;

#	$a =~ s/T//; $a =~ s/^20.//;
#	$b =~ s/T//; $b =~ s/^20.//;
#	return $a - $b; # moc se s tim nestvat..
}


sub hour_change {
	my($a,$b) = @_;
#	print "$a - $b\n";
	$a =~ s/T//;
	$b =~ s/T//;
#	print "$a - $b\n";
	return $a - $b;

#	$a =~ s/T//; $a =~ s/^20.//;
#	$b =~ s/T//; $b =~ s/^20.//;
#	return $a - $b; # moc se s tim nestvat..
}



sub genpairs {
	my($id,$list) = @_;
	my %uniq; $uniq{$_}++ foreach(@$list);
	my @list = sort keys %uniq;
	for(my $i=0;$i<@list;$i++) {
		for(my $j=0;$j<$i;$j++) {
			print $list[$i]." ".$list[$j]."\n";
			print $list[$j]." ".$list[$i]."\n";
		}
	}
}

my %session;
my $count = 1_000_000;
my $i = 0;
while(<>) {
	my($time,$session_id,$ean,$lib) = split(/\s/);
	my $session = $session{$session_id};	
#	if(not $session or time_diff($session->{start_time},$time) > 60*60) {
	unless($session) {
		$session = $session{$session_id} = {
			start_time => $time,
			id => $count,
			viewed => [],
		};
	}
	$ids{$ean} = $i++ unless($ids{$ean});
	my $id = $ids{$ean}; 
#	my $id = $ean; 
	push @{$session->{viewed}}, $id;
#   print "$count\t".$count % 100_000 ."\n";
=out
	unless(++$count % 1_000) {
		warn "$count: Sessions: ".scalar(keys %session)."\n";
		foreach(keys %session) {
			if(day_change($time, $session{$_}->{start_time})) {
				genpairs($session{$_}->{id},$session{$_}->{viewed});
				delete $session{$_};
			}
		}
	}
=cut
	if(hour_change($time, $session{$session_id}->{start_time})>60*60){
		foreach(keys %session) {
#	        if(day_change($time, $session{$_}->{start_time})) {
	       		genpairs($session{$_}->{id},$session{$_}->{viewed});
	    	    delete $session{$_};
#		    }
	    }
	}

}

open(ID, ">id");
foreach(keys %ids) {
	print ID "$_ ".$ids{$_}."\n";
}
close(ID);
