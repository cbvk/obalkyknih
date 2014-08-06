#!/usr/bin/perl -w

# Script je spousten pravidelne kazdy tyden a posila email spravcum knihoven
# o jejich nove pridanych komentarich.
# Spravci OKCZ je zasilan kompletni souhrn vsech knihoven.

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use Data::Dumper;
use DateTime::Format::MySQL;

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}


our $REPORT_DAYS = 7;  # pocet dnu v reportu
our $ADMIN_EMAIL = 'info@obalkyknih.cz';


# vyber knihoven, ktere maji nove komentare za poslednich $days dnu
my $dt = DateTime->now(time_zone=>'local');
$dt->subtract(days => $REPORT_DAYS);
my $lib = DB->resultset('Review')->search({ created=>{'>='=>$dt->datetime()} }, { group_by => 'library' });

my @adminEmail = undef;
foreach ($lib->all) {
	
	### SESKLADEJ EMAIL PRO SPRAVCE KNIHOVNY ###
	# vyber komentare konkretni knihovny
	my $revData = DB->resultset('Review')->search({
			'me.created' => { '>='=>$dt->datetime() }, 
			library => $_->get_column('library')
		}, {
			join => 'book',
			'+select' => ['book.title', 'book.authors', 'book.ean13', 'book.nbn', 'book.oclc'],
			'+as' => ['title', 'authors', 'ean13', 'nbn', 'oclc']
		});
	my @libEmail = undef;
	foreach ($revData->all) {
		my $tmpLink = '';
		$tmpLink = 'http://www.obalkyknih.cz/view?isbn='.$_->get_column('ean13') if ($_->get_column('ean13'));
		$tmpLink = 'http://www.obalkyknih.cz/view?nbn='.$_->get_column('nbn') if ($_->get_column('nbn') && $tmpLink eq '');
		$tmpLink = 'http://www.obalkyknih.cz/view?oclc='.$_->get_column('oclc') if ($_->get_column('oclc') && $tmpLink eq '');
		push @libEmail, substr($_->get_column('html_text'), 0, 200).(length($_->get_column('html_text'))>200 ? '...' : '').'

'.$_->get_column('created').'
'.$tmpLink.'
'.($_->get_column('authors') ne '' ? $_->get_column('authors').' - ' : '').$_->get_column('title');
	}
	
	
	### POSLI EMAIL SPRAVCI KNIHOVNY ###
	if ($_->get_column('library')) {
		my $libEmail = join("\n\n---\n\n", @libEmail);
		my $libAddr = DB->resultset('User')->search({
			library => $_->get_column('library'),
			flag_library_admin => 1,
			flag_review_report => 1
		});
		if ($libAddr->count) {
			my @libAdminEmails;
			foreach ($libAddr->all) {
				push @libAdminEmails, $_->get_column('login');
			}
			
			#warn Dumper(join(',',@libAdminEmails));
			open(MUTT,"|mutt -b '$ADMIN_EMAIL' -s 'obalkyknih.cz - prehled novych prispevku z Vasi knihovny' '".'lubo.orsag@gmail.com'."'");
			print MUTT <<EOF;

Toto je prehled novych prispevku - komentaru z Vaseho knihovniho IS za predchozich 7 dnu.
Kterykoliv z techto prispevku muzete vymazat po prihlaseni do administrace na www.obalkyknih.cz.


$libEmail


Pokud si neprejete tento informacni email nadale odebirat, prosim odhlaste se z odberu v administraci na www.obalkyknih.cz.

Hezky den,
obalkyknih.cz
EOF
			close(MUTT);
		}
	}
	
	
	### SESKLADEJ EMAIL PRO SPRAVCE OKCZ ###
	# email knihovny pridej k emailu pro administratora
	if ($_->get_column('library')) {
		my $libData = DB->resultset('Library')->find($_->get_column('library'));
		push @adminEmail, '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
=
=  Knihovna: '.$libData->get_column('name').' ('.$libData->get_column('code').')
=  '.$revData->count.' nových komentářů
=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='.$libEmail;
	}
	
	
	# komentare z robotu taky pripoj do reportu pro spravce
	push @adminEmail, '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
=
=  Komentáře z jiných zdrojů
=
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='.$libEmail unless ($_->get_column('library'));
	
	my $adminEmailText = join("\n\n\n", @adminEmail);
	
	
	### POSLI EMAIL SPRAVCI OKCZ ###
	open(MUTT,"|mutt -b '$ADMIN_EMAIL' -s 'obalkyknih.cz - tydenni prehled novych komentaru' '".'lubo.orsag@gmail.com'."'");
	print MUTT <<EOF;

$adminEmailText
EOF
	close(MUTT);
}
