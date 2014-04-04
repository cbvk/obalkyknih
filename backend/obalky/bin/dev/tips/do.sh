#!/bin/sh

LOG=$1

./pair.pl $1 | sort | uniq -c | grep -v '^  *1 ' | ./table.pl

