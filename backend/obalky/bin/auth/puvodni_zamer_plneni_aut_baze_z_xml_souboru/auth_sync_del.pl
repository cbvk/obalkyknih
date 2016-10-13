#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use Data::Dumper;

use strict;
use XML::Simple;

use Fcntl qw(:flock);

#kontrola parametrov
my $arguments = $#ARGV + 1;

if($arguments != 1){
	warn Dumper('Nezadal si 1 parameter (subor)');
	exit;
}

#kontrola subora
if(!(-e $ARGV[0])){
	warn Dumper('Zadany subor neexistuje');
	exit;
} 

my $filename = $ARGV[0];
my $errors = 0;

#Vylucny beh crawleru
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}


open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";


my $count = 0;
my $data = {};
while (my $row = <$fh>) {
  $count = $count + 1;
  
  #zmaze znaky z konca
  chomp $row;
  substr($row, -1) = '';
  
  my @words = split /   /, $row;
  
  #vytiahnutie dat
  if($words[0] ~~ ['001','901']) {
  	if($words[0] == '901'){
  		$data->{$words[0]} = substr $words[1], 3;
  	}
  	else {
  		$data->{$words[0]} = $words[1];	
  	}
  	
  }
 
  #kazdy 4. riadok
  if($count == 4){
  	#oznaci sa za vymazane
  	if(defined $data->{'001'} && defined $data->{'901'}){
  		
  			#najdi podla id
    		my $found = DB->resultset('Auth')->find($data->{'001'});
    		
    		#ak sa nasiel
    		if(defined $found){
    			
    			my $update = {};
    			$update->{'T901a'} = $data->{'901'};
				$found->update($update);
				
			}
			#ak sa nenasiel
			else {
				warn Dumper('Nasledovny zaznam sa nenasiel, preto ho nebolo mozne oznacit za zmazany:');
				warn Dumper($data);
				$errors = $errors + 1;
			}
  	
  	} else {
  		warn Dumper('Nasledovny zaznam sa nemal definovane 001 alebo 901, preto ho nebolo mozne oznacit za zmazany:');
		warn Dumper($data);
		$errors = $errors + 1;
  	}
  	
  	
  	$data = {};
  	$count = 0;
  }	
}



warn Dumper('Pocet chyb');
warn Dumper($errors);
