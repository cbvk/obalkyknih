#!/usr/bin/perl -w

use Data::Dumper;

# mysql -e 'SELECT id,ean13 FROM book;' > books.txt
# ./tips.pl < results > mysql

# naparsuj tabulku id,ean13 z #book

my %histo;

my %book; # ean12 -> id
my %ean13; # ean12 -> ean13

open(BOOKS,"<","books.txt") or die;
while(<BOOKS>) {
	$book{$2} = $1 if(/^(\d+)\t(\d{12})(\d)$/);
	$ean13{$2} = $2.$3 if(/^(\d+)\t(\d{12})(\d)$/);
}
close(BOOKS);

while(<STDIN>) {
	chomp;
	#978807038011:	978802450638(60)
	my($main,$list) = (/^(\d+)\:\s*(.*)/) or next;
	next unless($book{$main});

	my @list;
	foreach(split(/\s/,$list)) {
		my($ean,$count)  = (/^(\d+)\((\d+)\)/) or next;
		next if($count < 50);
		push @list, [ $ean, $count ] if($book{$ean});
		$histo{$count}++;
	}
	@list = sort { $b->[1] <=> $a->[1] } @list;
	@list = @list[0..10] if(scalar(@list) > 10);
#	next unless(@list >= 5);
#	map $histo{$_->[1]}++ @list;

	my $tips = join(" ",map { $book{$_->[0]} } @list);
	print "UPDATE book SET tips = '$tips' WHERE id = ".$book{$main}.";\n";
#	warn $ean13{$main}." $tips\n";

	# 
	# dohledej like v ean13
}

foreach(sort keys %histo) {
	warn "$_ -> ".$histo{$_}."\n";
}
