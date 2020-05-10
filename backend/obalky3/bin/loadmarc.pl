#!/usr/bin/perl -w

use DateTime::Format::MySQL;
use Data::Dumper;
use DateTime;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::BibInfo;
use Obalky::Tools;
use Eshop;
use DB;

my($libcode,$perma1,$perma2,$limit) = @ARGV;
die "\nusage: $0 library 'http://...' '...' [limit] < export.seq\n\n" 
		unless(defined $perma2);
# ./loadmarc.pl muni 'http://aleph.muni.cz/F?func=find-c&ccl_term=sys=' ''

my $library = DB->resultset('Library')->find($libcode) or die;

my %r = ( isbns => [] );

my $ahead = <STDIN>;
while(($_ = $ahead)) {
	my($sno,$fld,$line) = (/^(\d{9}) (...).. L (.*)$/);
	my $line_a = ($line =~ /\$\$a([^\$]*)/) ? $1 : '';

    $ahead = <STDIN>; # next if(not $sno and $ahead);

	print "SYSNO $sno\n" if($sno and $sno =~ /00000$/ and $fld eq 'FMT');
	last if($limit and $sno > $limit);

    if($fld eq '245') { # odrezat 800 $7 (id autority)
        $r{title} = ($line_a =~ /^([^\:\/]+)/) ? $1 : '';
    }
    if($fld eq '100') { # odrezat 800 $7 (id autority)
        $r{authors} = $line_a;
    }
	if(($fld eq '020') or ($fld eq '022') or ($fld eq '035') and $line_a) {
		$r{isbn} = $line_a if($fld eq '020' and not $r{isbn});
		push @{$r{isbns}}, $line_a;
	}

    if(not $ahead or $ahead !~ /^$sno/) {
		my $bibinfo = Obalky::BibInfo->new_from_params({
			isbn => $r{isbn}, title => $r{title}, authors => $r{authors},
		});
		my $permalink = $perma1.$sno.$perma2;

		if($bibinfo) {
			my($book,$record) = DB->resultset('Marc')->get_book_record(
					$library,$permalink,$bibinfo);
		}

		%r = ( isbns => [] );
	}
}

