#!/bin/bash

#export mzk_user=cosmotron
#export mzk_user_pwd=cosmotron_password

# extract data from MZK
mysql obalky --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="SELECT id, book, checksum FROM cover;" > /var/lib/mysql/tmp/cover_checksum.sql
mysql obalky --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="SELECT id, cover FROM book;" > /var/lib/mysql/tmp/be2fe_book.sql
# load data into CBVK
mysql obalky --execute="TRUNCATE TABLE cover_checksum;"
mysql obalky --execute="TRUNCATE TABLE be2fe_book;"
mysql obalky --execute="LOAD DATA INFILE '/var/lib/mysql/tmp/cover_checksum.sql' INTO TABLE cover_checksum;"
mysql obalky --execute="LOAD DATA INFILE '/var/lib/mysql/tmp/be2fe_book.sql' INTO TABLE be2fe_book;"
# make sync events based on checksum changes
# script is stored in mysql procedure
mysql obalky --execute="CALL sync_cover_checksum()"
mysql obalky --execute="CALL sync_be2fe_book()"
# then wait for sync execution, every cca 15min
