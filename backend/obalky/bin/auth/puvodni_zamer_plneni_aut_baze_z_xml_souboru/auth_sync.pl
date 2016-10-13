#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../../lib";

use DB;
use Data::Dumper;

use strict;
use XML::Simple;

use Fcntl qw(:flock);

my @data_description = (
    ['fmt', 'content', [['controlfield', 'tag','FMT']] ],
    ['id', 'content', [['controlfield', 'tag','001']] ],
    ['timestamp', 'content', [['controlfield', 'tag','005']] ],
    ['auth_name', 'content', [['datafield', 'tag','100'],['subfield', 'code','a']] ],
    ['auth_date', 'content', [['datafield', 'tag','100'],['subfield', 'code','d']] ]
);

my @conditions = (
	['id', '___najde___'],
	['fmt', 'JA'],
);

my @destroy_after_conditions_check = (
	'fmt'
);

#kontrola parametrov
my $arguments = $#ARGV + 1;

if($arguments != 2){
	warn Dumper('Nezadal si 2 parametre (-uloz/-akt) a (subor)');
	exit;
}

#kontrola prepinaca
if(!($ARGV[0] ~~ ['-uloz', '-akt'])){
	warn Dumper('Nezadal si 1. parameter -uloz alebo -akt');
	exit;
}

#kontrola subora
if(!(-e $ARGV[1])){
	warn Dumper('Subor zadany ako 2. parameter neexistuje');
	exit;
} 


my $type = $ARGV[0];
my $filename = $ARGV[1];
my $errors = 0;

#Vylucny beh crawleru
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

my $xml = XMLin($filename, ForceArray=>['record','controlfield','datafield', 'subfield']);


#pre kazdy zaznam
foreach my $record (@{$xml->{record}}) {
	 ###warn Dumper("+++++++++++");
	 
	 my $row = {};
	 
	 #pre kazdy zadefinovany riadok
	 foreach my $data_description_row (@data_description) {
		
		my $tree = $data_description_row->[2];
		
		my $data = $record; 
		
		my $levels = scalar @$tree;
		
		my $level = 0;
		
		#prejdi stromom zadefinovaneho riadku
		foreach my $x (@$tree){
			
			$level = $level + 1;
					
			my $tags = $data->{$x->[0]};
			
			#pre kazdy vonkajsi tag z dat
			foreach my $tag (@$tags){
				
				# ak vyhovuje, vyber ho a oznac ho za koren dat
				if($tag->{$x->[1]} eq ($x->[2])){
					
					$data = $tag;
					
					#ak je to list, vyber zadefinovanu hodnotu
					if($level == $levels){
						$row->{ $data_description_row->[0] } = $data->{$data_description_row->[1]};
					}
					
					last;
				}
			}
		}
		
		
	}
	 
	 
	###warn Dumper($row);
    
    my $conditions_met = 1;
    
    foreach my $cond (@conditions) {
    	
    	#kontrola, ci dany stlpec existuje
    	if($cond->[1] eq "___najde___"){
    		
    		#ak neexistuje
    		if(!exists $row->{$cond->[0]}){
    			###warn Dumper('testujem najdene --- bad');
    			$conditions_met = 0;
    		} 
    		#ak existuje
    		else {
    			###warn Dumper('testujem najdene --- ok');
    		}
    		
    	}
    	#kontrola, ci dany stlpec obsahuje danu hodnotu 
    	else { 
    		
    		#ak neexistuje, tak podmienka nie je splnena
    		if(!exists $row->{$cond->[0]}){
    			$conditions_met = 0;
    		} 
    		#ak existuje
    		else {
    			
    			#ak dany stlpec obsahuje danu hodnotu  
    			if($row->{$cond->[0]} eq $cond->[1]){
    				###warn Dumper('testujem hodnotu --- ok');
    			} 
    			#ak neobsahuje ocakavanu hodnotu
    			else {
    				$conditions_met = 0;
    				###warn Dumper('testujem hodnotu --- bad');
    			}
    		}
    		
    	}
    }
    
    #ak boli podmienky splnene
    if($conditions_met == 1){
    	
    	#po skontrolovani podmienok sa zmazu vsetky vybrane stlpce
	    foreach my $dest (@destroy_after_conditions_check) {
	    	if(exists $row->{$dest}){
	    			delete $row->{$dest};
	    	}
	    }
    	
    	#ak zaznamy ukladame
    	if($type eq "-uloz"){
    		
    		DB->resultset('Auth')->create($row);
    		
    	}
    	#ak zaznamy aktualizujeme
    	else {
    		
    		#najdi podla id
    		my $found = DB->resultset('Auth')->find($row->{'id'});
    		
    		#ak sa nasiel
    		if(defined $found){
    			
				$found->update($row);
				
			}
			#ak sa nenasiel
			else {
				warn Dumper('Nasledovny zaznam sa nenasiel, preto ho nebolo mozne aktualizovat:');
				warn Dumper($row->{'id'});
				$errors = $errors + 1;
			}
    		
    		
    	}
	} else {
		warn Dumper('Nasledujuci zaznam nesplnil niektoru podmienku:');
		warn Dumper($row);
		$errors = $errors + 1;
	}
	 
}

warn Dumper('Pocet zaznamov, ktore nepresli podmienkami alebo nebolo mozne aktualizovat, lebo ich id sa nenaslo:');
warn Dumper($errors);