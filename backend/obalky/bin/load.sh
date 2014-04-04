#!/bin/sh

HOME=/opt/obalky

mysql < $HOME/doc/model.sql

$HOME/bin/loadmarc.pl muni \
	'http://aleph.muni.cz/F?func=find-c&ccl_term=sys=' \
	'' < $HOME/doc/mub01.seq &
$HOME/bin/loadmarc.pl mzk \
	'http://aleph.mzk.cz/F?func=find-c&ccl_term=sys=' \
	'&local_base=MZK01' < $HOME/doc/mzk01.seq &
$HOME/bin/loadisbns.pl < $HOME/doc/isbns.txt

wait
