#!/bin/sh

# 20130528 (pred VSE) 745009 obálek a 68119 obsahů 

#for year in 2006 2007 2008 2009 2010 2011 ; do
for year in 2013 2012 2011  ; do
	for month in 01 02 03 04 05 06 07 08 09 10 11 12 ; do
		DIR=download-log/$year$month
		mkdir -p $DIR
		#for base in MZK NKC SVK VSE ; do
		for base in VSE ; do
			echo "$year$month $base"
			./download-tocnkp.pl $year$month $base covers \
				> $DIR/$base-covers.log 2>$DIR/$base-covers.err
			./download-tocnkp.pl $year$month $base contents \
				> $DIR/$base-covers.log 2>$DIR/$base-contents.err
		done
	done
done

