#!/usr/bin/perl -w

use Time::HiRes qw( usleep gettimeofday tv_interval );

use DateTime::Format::MySQL;
use DateTime;
use Data::Dumper;
use JSON;
use Switch;
use Encode qw(encode_utf8); 
use Fcntl qw(:flock);

#Vylucny beh harvestu
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
    exit;
}

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use Obalky::BibInfo;

use Eshop;
use DB;
use Redis;
use MongoDB;

my $clientMarc = MongoDB->connect('mongodb://localhost:27017');
my $dbmarc = $clientMarc->ns('okczd.marc');

#my $marcRes = $dbmarc->find({'sysno'=>'000000104'});
#while (my $doc = $marcRes->next) {
#  warn $doc->{sysno};
#}

my $r = Redis->new( server => 'localhost:6379', encoding => 'UTF-8' );
my $res = $r->hkeys('ed');
my $i=0;
map {
    my $rel;
    my $relCount = 0;
    my $val = $r->hget('ed', $_);
    my @edArr = split(/#/, $val);

    map {
        my ($t001, $edText) = split(/\|/, $_);
        my $marcRes = $dbmarc->find({'fields.001'=>$t001},{'fields.015'=>1, 'fields.020'=>1, 'fields.022'=>1, 'fields.024'=>1, 'fields.035'=>1});
        my $rec = $marcRes->next;
        my $bibParams;
        map {
            my $tag = $_;
            map {
                my $tagno = $_;
                my $subf = $tag->{$_}->{'subfields'};
                my $idVal;
                map { $idVal = $_->{'a'} if ($_->{'a'}); } @{$subf};
                switch ($tagno) {
                    case '015' { $bibParams->{'nbn'} = $idVal; }
                    case '020' { $bibParams->{'ean13'} = $idVal; }
                    case '022' { $bibParams->{'ean13'} = $idVal unless ($bibParams->{'ean13'}); }
                    case '024' { $bibParams->{'ean13'} = $idVal unless ($bibParams->{'ean13'}); }
                    case '035' { $bibParams->{'oclc'} = $idVal; }
                }
            } keys %{$_};
        } @{$rec->{'fields'}};

        if ($bibParams) {
            $bibinfo = Obalky::BibInfo->new_from_params($bibParams);
            my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo);
            if ($book) {
                $rel->{$book->id} = $edText;
                $relCount++;
            }
        }
    } @edArr;

    # uloz vysledok
    if ($rel and $relCount gt 1) {
        # vymaz existujuce relacie
        map {
            my $delRes = DB->resultset('BookRelation')->search({
                'book_parent' => $_,
                'book_relation' => $_,
                'flag_auto_generated' => 1,
                'relation_type' => 3
            });
            foreach ($delRes->all) {
                $_->delete;
            }
        } keys %{$rel};
        # dopln nove relacie
        map {
            my $idParent = $_;
            my $edText = $rel->{$_};
            map {
                my $idRelation = $_;
                if (defined $idParent and defined $idRelation and $idParent != $idRelation) {
                    DB->resultset('BookRelation')->create({
                        'book_parent' => $idParent,
                        'book_relation' => $idRelation,
                        'relation_type' => 3,
                        'flag_auto_generated' => 1
                    });
                }
            } keys %{$rel};
            # dopln text edicie z tagu 250
            my $bookUpd = DB->resultset('Book')->find($idParent);
            $bookUpd->update({ 'edition' => $edText }) if ($bookUpd);
        } keys %{$rel};
    }

    $i++;
    print '  '.$i unless ($i%100);
} @{$res};
