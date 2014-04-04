#!/usr/bin/perl -w

use DBI;

# Zazalohuje obsah tabulky #fileblob
# 
# zalohuje pouze soubory, ktere jsou odkazovane z tabulky #cover
# zalohuje to vse do jednoho adresare

# todo: obnovit

my($io,$what,$dir) = @ARGV;
die "\nusage: $0 [import|export] [tables|files] dir/\n\n" unless($dir);

my $dbh = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");

if($io eq 'export') {
	if($what eq 'tables') {
		export_tables($dir);
	} elsif($what eq 'files') {
		export_files($dir);
	} else {
		die;
	}
} elsif($io eq 'import') {
	if($what eq 'tables') {
		import_tables($dir);
	} elsif($what eq 'files') {
		import_files($dir);
	} else {
		die;
	}
} else {
	die;
}

sub export_tables {
	my($dir) = @_;
	my @tables = qw/abuse book cover eshop library marc product
			review seanse tag tip toc upload user visitor work/;
	for my $table (@tables) {
		warn "Exporting $dir/$table.sql\n";
		system("mysqldump -r $dir/$table.sql obalky $table") and die;
	}
}

sub import_tables {
	my($dir) = @_;
	for my $sql (glob("$dir/*.sql")) {
		my($table) = ($sql =~ /([\/]+)\.sql$/) or die;
		warn "Importing table $table\n";
		system("mysql < $sql");
	}
}

sub import_files {
	my($dir) = @_;
	my $sth = $dbh->prepare("INSERT INTO fileblob (id,medium,mime,content) ".
							" VALUES (?,?,?,?)");
	opendir(DIR,$dir) or die;
	while(my $file = readdir DIR) {
		next if($file =~ /^\./);
		my($id,$medium,$mime) = ($file =~ /^(\d+)\-(.*)\.(.*)$/) or die $file;
		warn "Fileblob $id ($medium)\n" unless($id % 100_000);
		open(FILE,"<bytes",$file); 
		my $content = join("",<FILE>);
		close(FILE);
		$sth->execute($id,$medium,$mime,$content) or die;
	}
	$sth->finish;
	closedir(DIR);
}

sub export_files {
	my($dir) = @_;
	my %used;

	my $cover_sth = $dbh->prepare(
		"SELECT id,file_thumb,file_icon,file_medium,file_orig FROM cover");
	$cover_sth->execute();

	while( my @row = $cover_sth->fetchrow_array ) {
		my($id,$old_thumb,$old_icon,$old_medium,$old_orig) = @row;
		warn "Cover $id\n" unless($id % 100_000);
		$used{$old_thumb}++;
		$used{$old_icon}++;
		$used{$old_medium}++;
		$used{$old_orig}++;
	}
	
	warn "Used: ",scalar(%used),"\n";
	
	my($min,$max) = $dbh->selectrow_array(
			"SELECT MIN(id),MAX(id) FROM fileblob");
	my $file_sth = $dbh->prepare("SELECT id,mime,medium,content ".
			"FROM fileblob WHERE id >= ? AND id < ?");
	for(my $i=$min;$i<$max;$i+=10_000) {
		$file_sth->execute($i,$i+10_000);
		while( my @row = $file_sth->fetchrow_array ) {
			my($id,$mime,$medium,$content) = @row;
			warn "File $id $mime $medium\n" if(($id % 10_000) == 0);
			if($used{$id}) {
				open(OUT,">bytes","$dir/$id-$medium.$mime") or die;
				print OUT $content;
				close(OUT) or die;
			} else {
#				print "DELETE FROM fileblob WHERE id = ".$id."\n";
			}
		}
	}
}
