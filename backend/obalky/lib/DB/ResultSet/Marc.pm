
package DB::ResultSet::Marc;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub get_book_record {
	my($pkg,$library,$permalink,$bibinfo) = @_;

	# ignoruj permalink (a nedelej zaznam), pokud odkazuje do Alephu ale
	# bez zadane baze. Jinak to delalo problem, ze vracelo spatne obalky
	# pro knihu se stejnym sysno, ale v jine bazi knihovny, napr.:
# https://aleph.mzk.cz:443/F?func=direct&doc_number=000907247&local_base=MZK01&format=999
# https://aleph.mzk.cz:443/F?func=direct&doc_number=000907247&local_base=MZK03&format=999
	$permalink = undef if($permalink !~ /local_base\=/ and
			$permalink =~ /aleph.mzk.*\?func\=find-c&ccl_term\=sys/);

	# najdi dle permalinku, ale jen pokud je bibinfo porad stejne
    my $record = $permalink ? DB->resultset('Marc')->find({ 
									permalink => $permalink }) : undef;
	my $book = $record ? $record->book : undef;
	if($book) {
		unless($bibinfo->differs($book->bibinfo)) {
			return ($book,$record);
		} else {
#			$record->delete; #?
		}
	}

	# jinak vytvor novy knihovni record
	$book = DB->resultset('Book')->find_by_bibinfo_or_create($bibinfo);
	die "no book??" unless($book); # FIX: remove sanity check
	my $hash = {
		library   => $library,
		book      => $book,
		permalink => $permalink,
	};
	$bibinfo->save_to_hash($hash);

	my $marc = eval { $pkg->find_or_create($hash,
						{ key => 'marc_library_book' }) };
	unless($marc) {
		$marc = $pkg->find({ permalink => $permalink }) if($permalink);
	}
	# die "no record??" unless($marc); # FIX: remove sanity check
	return ($book,$marc);
}


1;
