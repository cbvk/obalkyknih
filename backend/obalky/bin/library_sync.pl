use FindBin;
use lib "$FindBin::Bin/../lib";
use Fcntl qw(:flock);

use Data::Dumper;
use XML::Simple;
use DB;

warn "\n-----------[ START ]----------";

my $feed_url = 'http://www.vkta.cz/clavius/l.dll?xOKuz2';
#my $feed_url = 'http://www.obalkyknih.cz/_lib.xml';
warn "\n--[ Lanius ]-- ($feed_url)\n";
crawl($feed_url);

warn "\n-----------[ DONE ]----------\n";

sub crawl {
	my($feed_url) = @_;
	my $tmp_dir = '/tmp';

	return [] unless($feed_url);

	# stazeni seznamu opravneni
	system("wget -q $feed_url -O $tmp_dir/library_sync_feed.xml") and die "$tmp_dir: $!";
	warn "Got xml feed\n" if($ENV{DEBUG});

	# parsovani XML
	my $xml = eval { XMLin("$tmp_dir/library_sync_feed.xml", SuppressEmpty => 1, ForceArray => ['x'], KeyAttr => []); };
	if($@) {
		warn "$feed_url: $@";
		return ();
	}

	# zatim prochazime pouze XML elementy <x> pouziva Lanius
	my @xml_items = @{$xml->{x}};
	my $total_count = scalar @xml_items;
	warn 'XML contains '.$total_count.' items';
	
	# inicializace promennych
	my ($libName,$libAddress,$libCity,$libId,$libCode,$codeNTK) = (undef,undef,undef,undef,undef,undef);
	my ($libNtkRes,$libNtk,$libRes,$regData) = (undef,undef,undef,undef);
	my ($permsAll,$urlHttp,$urlHttps) = (undef,undef,undef);
	my (%permsAuto,@permsNew);
	
	my $i = 1;
	foreach my $item (@xml_items) {
		
		# pokus o nalezeni SIGLy; pokud se nenajde pouzijeme 5 mistny identifikator pridelovany NTK
		$libCode = '!'.$item->{prefix};
		$libName = $item->{nazev};
		$libAddress = $libCity = '';
		
		$codeNTK = $item->{prefix}; $codeNTK =~ s/0+$//g;
		$libNtkRes = DB->resultset('Knihovny')->search({ 'code' => $codeNTK });
		if ($libNtkRes->count == 1) {
			$libNtk = $libNtkRes->next;
			if ($libNtk->get_column('sigla') ne '') {
				$libCode = $libNtk->get_column('sigla');
				$libName = $libNtk->get_column('name');
				$libAddress = $libNtk->get_column('street');
				$libCity = $libNtk->get_column('city');
			}
		}
		
		$libRes = DB->resultset('Library')->search({ 'code' => $libCode });
		warn "[".$i.'/'.$total_count.']  '.$libCode;
		
		# knihovna uz zaznam ma
		if ($libRes->count) {
			$lib = $libRes->next;
		}
		# knihovna zaznam nema; zakladame
		else {
			$regData = { 'code' => $libCode, 'name' => $item->{nazev}, 'webopac' => $item->{url}, 'purpose_description' => 'Import Lanius '.$feed_url, 'flag_active' => 1 };
			if ($libName) {
				$regData->{name} = $libName;
				$regData->{address} = $libAddress;
				$regData->{city} = $libCity;
			}
			$lib = DB->resultset('Library')->create($regData);
		}
		
		$libId = $lib->get_column('id');
		
		# nacteni seznamu opravneni
		$permsAll = ''; # tady se seskladaji vsechna opravneni do jednoho retezce oddeleneho #
		# seznam opravneni vytvorenych automaticky (napr. timto scriptem)
		%permsAuto = ();
		# seznam opravneni ziskanych z XML
		@permsNew = ();
		foreach my $perm (DB->resultset('LibraryPerm')->search({ 'library' => $libId })->all) {
			next unless (defined $perm->get_column('ref'));
			$permsAll = $permsAll.'#'.$perm->get_column('ref');
			$permsAuto{$perm->get_column('ref')} = $perm->id if ($perm->get_column('auto_generated') == 1);
		}
		
		push @permsNew, $item->{url};
		push @permsNew, $item->{url2} if $item->{url2};
		
		foreach my $permInput (@permsNew) {
			# budeme chtit rovnou https variantu webu
			$urlHttp = $permInput;
			$urlHttps = $urlHttp;
			$urlHttps =~ s/http\:\/\//https\:\/\//g;
			
			if (index($permsAll, $permInput) != -1) {
				delete $permsAuto{$urlHttp};
				delete $permsAuto{$urlHttps};
			} else {
				# opravneni nemame; pridame do DB a posleme do FEsync fronty aby se o novem opravneni dovedeli i frontendy
				warn "[MISSING] ".$permInput;
				DB->resultset('LibraryPerm')->create({ 'library' => $libId, 'ref' => $urlHttp, 'auto_generated' => 1 });
				DB->resultset('LibraryPerm')->create({ 'library' => $libId, 'ref' => $urlHttps, 'auto_generated' => 1 }) if ($urlHttp ne $urlHttps);
				DB->resultset('FeSync')->request_sync_perm('ref', $urlHttp, $lib);
				DB->resultset('FeSync')->request_sync_perm('ref', $urlHttps, $lib) if ($urlHttp ne $urlHttps);
			}
		}
		
		foreach my $permDel (keys %permsAuto) {
			warn "[REMOVING] ".$permDel;
			DB->resultset('LibraryPerm')->find($permsAuto{$permDel})->delete;
		}
		
		$i++;
	}
}