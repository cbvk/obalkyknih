
package DB::Result::Upload_find;
use File::Find;

package DB::ResultSet::Upload;
use base 'DBIx::Class::ResultSet';

use Obalky::BibInfo;
use Obalky::Config;

use strict;
use Data::Dumper;
use File::Copy;
use MD5;
use utf8;
#use ZOOM;
#use MARC::Record;

use LWP::UserAgent;
use Business::ISBN;

my @g_upload_images; # fix: global var!

sub upload_find {
	my $name = $File::Find::name;
	my $type = __PACKAGE__->filetype($name);
	push @g_upload_images,$name 
			if($type and ($type ne 'zip' and $type ne 'tar'));
}

sub filetype {
	my($pkg,$filename) = @_;
	return lc($1) if($filename =~ /\.(tar|zip|jpe?g|gif|png|tiff?|bmp)$/i);

	my $type = `file '$filename'`;
	return 'tar' if($type =~ /POSIX tar archive/);
	return 'tar' if($type =~ /gzip compressed/); # hope it's tar.gz
	return 'zip' if($type =~ /Zip archive data/);
	return lc($1) if($type =~ /\b(.+)\b image/);
	return undef;
}

sub upload {
	my($pkg,$api,$id,$info) = @_;
	my $filename;

    if($info->{file} and $info->{url}) {
        die <<END;
Musí být zadáno jedno z:
<ul><li>Jméno souboru s obrázkem nebo ZIP archivem obrázků
    <li>URL adresa, odkud se má obrázek či ZIP archiv stáhnout</ul>
END
    }

	$api->write("url: ".$info->{url}."\n") if($api);

	unless(-d "/tmp/.obalky") {
		mkdir "/tmp/.obalky" or die "Interní chyba: $!";
		#chmod '0755', "/tmp/.obalky";
	}

	# fix: delat id nejak inteligentneji, citacem v db,...
	my $batch = MD5->hexhash($$."-".$info->{login}.
					"-".(int(rand(1000000))+1)."-".time);

	#my @all = __PACKAGE__->retrieve_all; 
	#my $batch = MD5->hexhash($$."-".$login."-".(scalar(@all)+1));

	my $upload = $Obalky::Config::WWW_DIR."/upload/$batch";
	my $original = $Obalky::Config::WWW_DIR."/original/$batch";
#	die "Interní chyba: dávka $batch už existuje" if(-d $original);
	system("rm -rf '$upload'"); # shouldn't happen
	mkdir($upload) or die "Interní chyba: $upload: $!";
	mkdir($original) or die "Interní chyba: $original: $!";

	if($info->{url}) {
		my $url = $info->{url};
		# download url
		$url =~ s/[\'\\]//g; # a bit of sanity check..
		($filename) = ($url =~ /([^\/]+)$/);
		die "Nelze určit jméno souboru z URL\n" unless($filename);

		$api->write("wget -O '$original/$filename'\n") if($api);

		system("wget","-q",$url,"-O",$original."/".$filename);# == 0
		die "Ze zadaného URL <a href=\"$url\">$url</a> se nepovedlo ".
			"stáhnout požadovaný soubor.\n"
				unless(-s $original."/".$filename);
	} else {
		my $file = $info->{file};
		# uploaded file
		$filename = $file->basename;
		my $tempname = $file->tempname;
		# FIXME: toto copy() muze shodit obalky_server -d
		copy($tempname,$original."/".$filename) 
			or die "Interní chyba: $!: $original/$filename";
	}
	$api->write(`ls -lh '$original/$filename'\n`) if($api);

	my $filetype = __PACKAGE__->filetype($original."/".$filename);
	if($filetype eq "zip") {
		# unzip archive
		system("unzip -qq '$original/$filename' -d '$upload' >/dev/null");
# fix: blbne	and die "Nepovedlo se rozbalit archiv: neznámá chyba\n";
	} elsif($filetype eq 'tar') {
		system("tar xf '$original/$filename' -C '$upload' >/dev/null");
	} else {
		# single image
		copy($original."/".$filename,$upload."/".$filename);
	}
	# unlink($prefix."-".$filename); # original si nechame!

	@g_upload_images = ();
	DB::Result::Upload_find::find(
		\&DB::ResultSet::Upload::upload_find, $upload);

	$api->write("uploaded ".scalar(@g_upload_images)." files\n") if($api);

	my $count = 0;
	foreach(sort @g_upload_images) {
		if(__PACKAGE__->process($api,$batch,$upload,$id,$info,$_)) {
			$count++;
			# $list{$ean13} = $cover->id if($api);
		}
	}
	die "Chybný importní soubor -- nebyly nalezeny žádné správně ".
			"pojmenované obrázky.\n" unless($count);#{$upload_id});

	if($api) {
		# ponechavame jen rucne vlozene davky a originaly
		system("rm -rf '$upload' '$original'") if($api);
#		$api->write("ean13 $_ inserted as cover ".$list{$_}."\n") 
#				foreach(sort keys %list);
		$api->write("processed $count covers.\n");
	}

	return $batch; #$count{$upload_id}; ?
}

sub process {
	my($pkg,$api,$batch,$dir,$bibinfo,$info,$filepath) = @_;

	my $filename = substr($filepath,length($dir)+1);
	my $type = __PACKAGE__->filetype($filepath);

	my $file_id;
	if (not defined $info->{'file_id'}) {
		# pouzijeme jako ID nazev souboru (v pripade knih se toto pouzije vzdy, v pripade autorit a zpusobem standardniho uploadu taky)
		$file_id = $filepath =~ /^.*?([^\/]+?)(\..+)?$/ ? $1 : $filepath;
	} else {
		# nazev souboru je explicitne definovan v kontextu uploadu (napr. u uploadu obrazky autority ze stranky detailu autority)
		$file_id = $info->{'file_id'};
	}

	my $resAuth = DB->resultset('Auth')->find($file_id);
	$bibinfo = Obalky::BibInfo->new_from_string($file_id)
					unless ($resAuth or $bibinfo);

	my $authinfo;
	$authinfo = Obalky::AuthInfo->new_from_id($file_id)
					if ($resAuth);

	return unless($bibinfo or $authinfo);

	my $user = DB->resultset('User')->find_by_email($info->{login});

	my $upload = DB->resultset('Upload')->create({
		batch => $batch, 		user => $user,
		origname => $filename, 	orig_url => $info->{orig_url},
		filename => $filename
	});
	$upload->orig_url($info->{url}) unless($info->{orig_url});
	$bibinfo->save_to($upload) if ($bibinfo);
	$authinfo->save_to($upload) if ($authinfo);

	my $md5 = `md5sum $filepath | head -c 32`;
	$upload->checksum($md5);
	$upload->update;
	
	if ($authinfo) {
		my $upload_info = {};
		my $auth = DB->resultset('Auth')->find($authinfo->{auth_id});
		$upload_info->{title} = $auth->get_column('auth_biography');
		$upload_info->{authors} = $auth->get_column('auth_name');
		$upload_info->{year} = $auth->get_column('auth_date');
		$upload->update($upload_info);
	}

	if($api and DB->resultset('Cover')->has_same_cover($bibinfo,$md5)) {
		$api->write("Cover already in database, ignoring..\n");
		return;
	}

#	eval {
#		my $conn = new ZOOM::Connection("z3950.loc.gov", 7090,
#								databaseName => "voyager");
#		$conn->option(preferredRecordSyntax => "usmarc");
#		my $rs = $conn->search_pqf('@attr 1=7 '.$isbn);
#		my $rec = $rs->record(0);
#		if($rec) {
#			my $raw = $rec->raw();
#			my $marc = new_from_usmarc MARC::Record($raw);
#			$upload->title($marc->title());
#			$upload->author($marc->author());
#			$upload->year($marc->publication_date());
#		}
#	};

#	if ($@) {
#		print "Error ", $@->code(), ": ", $@->message(), "\n";
#	}

	# yaz-client aleph.muni.cz:9991/mub01
	# Z> f @attr 1=4 "XML pro" 
	# Z> show 1
	# yaz-client z3950.loc.gov:7090/voyager
	# Z> find @attr 1=7 0898215978
	# Z> show 1
	# kosek: 8071698601

	if($api) {
		my($book,$object);

		eval { ($book,$object) = DB->resultset('Book')->upload($upload) };
		$book->invalidate;

		$api->write("error: $@\n") if($@);
		warn("ERROR: $@\n") if($@);

		$api->write("SUCCESS: ".$upload->to_some_id." -> BOOK ".
			$book->id.", OBJECT ".$object->id."\n") unless($@);
	}

	return $upload;
}

sub images {
	my($pkg,$batch) = @_;
	return $pkg->search({ batch => $batch });
}

sub do_import {
	my($pkg,$batch,$list) = @_;

    foreach(sort { $a <=> $b } keys %$list) {
		my $hash = $list->{$_};
        next if(not $hash->{check} or $hash->{check} ne 'on');
		my $upload = DB->resultset('Upload')->find($hash->{id});
        next unless($upload); # FIX: we should die!
        
        my $media = Obalky::Media->new_from_info({
						cover_url => $upload->cover_url, 
						cover_tmpfile => $upload->cover_tmpfile });

		if ($hash->{type} eq 'book') {
			$upload->authors($hash->{authors}) if($hash->{authors});
			$upload->title($hash->{title})     if($hash->{title});
			$upload->year($hash->{year})       if($hash->{year});
			$upload->update;

			my $bibinfo = Obalky::BibInfo->new($upload);
	
			# pridej do Upload e-shopu product, mozna vypropaguje obalku do book
			my $upload_eshop = DB->resultset('Eshop')->get_upload_eshop;
			my $product_url = $Obalky::Config::WWW_URL."/view?".$bibinfo->to_some_param;
			my $product = $upload_eshop->add_product($bibinfo,$media,$product_url);
			$upload->update({ product => $product });
		}
		
		if ($hash->{type} eq 'auth') {
			my $auth_id = $upload->get_column('auth_id');
			my $auth = DB->resultset('Auth')->find($auth_id);			
			$auth->add_cover($media);
			#######my $product = $upload_eshop->add_product($bibinfo,$media,$product_url);
		}
	}
###	system("rm -rf ".$Obalky::Config::WWW_DIR."/upload/".$batch) if($batch);
}

1;
