#!/usr/bin/perl -w

use Data::Dumper;

# Vygeneruj doporucovaci tabulku
# Pametove znacne narocne...

my $rec = {}; # ean1 -> ean2 -> weight;
#my $test = 100;

while(<>) {
	my($weight,$ean1,$ean2) = (/^\s+(\d+)\s(\S+)\s(\S+)/) or next;
	die "Duplicitni parovani $ean1->$ean2\n" if(exists $rec->{$ean1}->{$ean2});
	die "Duplicitni parovani $ean2<-$ean1\n" if(exists $rec->{$ean2}->{$ean1});
	$rec->{$ean1}->{$ean2} = $weight;
	$rec->{$ean2}->{$ean1} = $weight;
#	last unless($test--);
}

my($count,$sum) = (0,0);
my %histo;
my($max_keys,$max_ean) = (0,0);

foreach my $ean (keys %$rec) {
	my $recs = $rec->{$ean};
	my $keys = scalar(keys %$recs); 
	if($max_keys < $keys) {
		$max_keys = $keys;
		$max_ean = $ean;
	}
	$keys = 10 if($keys > 9);
	$count++; $sum += $keys; $histo{$keys}++;
	print $ean." ".join(" ",sort { $recs->{$a} <=> $recs->{$b} } 
									keys %$recs)."\n";
}

warn "Count: $count, Average: ".$sum/$count.", Max: $max_keys (EAN $max_ean)\n";
warn Dumper(\%histo);


