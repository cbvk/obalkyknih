#!/bin/bash

d=2015-01-05
while [ "$d" != 2015-01-06 ]; do 
  echo $d
  perl crawler-citation.pl period $d $d
  d=$(date -I -d "$d + 1 day")
done