#!/usr/bin/perl -w

use Math::MatrixSparse;
use Data::Dumper;

my($bookstxt) = @ARGV;
die "\nusage: zcat *-request.sql.gz | $0 /tmp/books-mzk.txt\n\n"
	unless($bookstxt);
# usage zcat *-request.sql.gz | $0

my %known; # zname eany -- napr. jen v mzk apod..
open(EANS,$bookstxt) or die;
while(<EANS>) {
	$known{$1} = $2 if(/^(\d{13})\s(.*)/);
}
close(EANS);

my $sim = new Math::MatrixSparse;

# prochazej to pro kazdou desitku minut separatne
# v desitce eviduj ke kazdemu visitoru jeho eany
# setrizene skupinky eanu pote vyplivni

my $slice; # time slice
my %group; # visitor -> ean++
my %histo; # grade -> count

sub similar {
	my(@ean) = @_;
	for(my $i=1;$i<@ean;$i++) {
		for(my $j=0;$j<$i;$j++) {
			my $grade = $sim->element($ean[$i],$ean[$j]);
			if($grade) { 
				$histo{$grade}--;
				delete $histo{$grade} unless($histo{$grade});
			}
			$grade = $grade ? $grade + 1 : 1;
			$histo{$grade}++;
			$sim->assign($ean[$i],$ean[$j] => $grade);
		}
	}
}

# $matrix->count
# $matrix->threshold($thresh)
# 	-- Returns a copy of $matrix with any elements with absolute 
# 	   value less than $thresh removed.
# foreach my $key ($matrix->elements()) { my ($i,$j) = &splitkey($key); ... }

sub recommend {
#	$sim->writematrixmarket("/tmp/rec.txt");
	print Dumper(\%histo);
	foreach my $key ($sim->elements()) { 
		my($i,$j) = Math::MatrixSparse::splitkey($key);
		my $grade = $sim->element($i,$j);
		if($grade > 100) {
			print "- $i ".$known{$i}."\n"."  $j ".$known{$j}."\n";
		}
	}
}

sub parse {
	my($vals) = @_;
	while($vals =~ s/\((.*?)\)\,//) {
		my @ary = split(/\,/,$1,17);
		my($created,$visitor,$ean) = @ary[1,3,8];
		next unless($ean =~ s/\'//g);
		next unless($known{$ean}); # omez...
		next unless($created =~ 
s/^\'(\d{4})\-(\d\d)\-(\d\d) (\d\d)\:(\d)\d\:\d\d\'$/$1$2$3T$4$5/g);
		if($slice and $slice eq $created) {
			$group{$visitor}->{$ean}++;
		} else {
			if($slice) {
				warn "$slice ".$sim->count."\n";
				foreach my $eans (values %group) {
					my @eans = keys %$eans;
					next if(scalar(@eans) < 2);
					# print join(" ",sort @eans),"\n";
					similar(@eans);
				}
			}
			%group = ();
			$slice = $created;
			if($sim->count > 1000000) {
				recommend();
				exit;
			}
		}
	}
}

while(<STDIN>) {
	if(/INSERT INTO \S+ VALUES (.*)/) {
		parse($1);
		while(<STDIN>) {
			last if(/^UNLOCK/);
			parse($_);
		}
	}
}

