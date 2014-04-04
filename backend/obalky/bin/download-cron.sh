#!/bin/sh

# pousteno z cronu, stahne data za aktualni mesic

#for year in 2006 2007 2008 2009 2010 2011 ; do
now=`date +%Y%m`
cd /opt/obalky/bin
DIR=download-log/$now
mkdir -p $DIR

for base in MZK NKC SVK VSE ; do
	echo "$now $base"
	./download-tocnkp.pl $now $base covers \
		> $DIR/$base-covers.log 2>$DIR/$base-covers.err
	./download-tocnkp.pl $now $base contents \
		> $DIR/$base-covers.log 2>$DIR/$base-contents.err
done

