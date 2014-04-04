#!/usr/bin/perl -w

sub resize {
	my($maxw,$maxh,$w,$h) = @_;
	return ($maxw,$maxh) unless($w or $h);
	return ($h*$maxw/$w > $maxh) ? 
			(int($w*$maxh/$h),$maxh) : 
			($maxw,int($h*$maxw/$w));
}


open(LIST,"find ../www/file -name original.\\* |");
while(my $file = <LIST>) {
	chomp($file);
	my($id) = ($file =~ /\/(\d{7})\//) or die;

##	print "$id $file\n";

    my $size = `/usr/bin/identify -format '%wx%h' '$file'`;
	my($width,$height) = ($size =~ /^(\d+)x(\d+)$/); # or die!!!
	next unless($width and $height);

	print "UPDATE object SET cover_width = $width, cover_height = $height ".
				"WHERE id = $id;\n";

	my($cover,$thumbnail) = ($1."/cover.jpg",$1."/thumbnail.jpg")
								 	if($file =~ /^(.*\/)/);
	
	my($cw,$ch) = resize(180,240,$width,$height);
	my($tw,$th) = resize(27,36,$width,$height);
	# cover.jpg
	system("convert","-resize",$cw."x".$ch,$file,$cover);
	# thumbnail.jpg
	system("convert","-resize",$tw."x".$th,$file,$thumbnail);
}

