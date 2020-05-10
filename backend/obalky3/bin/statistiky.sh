#!/bin/sh


DATUM=`date +%Y%m%d --date "1 days ago"`

mysql obalky -e "ALTER TABLE visitor RENAME TO visitor_$DATUM"
mysql obalky -e "create table visitor like visitor_$DATUM"
mysql obalky -e "ALTER TABLE request RENAME TO request_$DATUM"
mysql obalky -e "create table request like request_$DATUM"

