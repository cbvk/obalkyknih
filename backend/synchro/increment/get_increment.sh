#get_increment.sh
if [ -f /root/work.lst ]
then
    echo wait for finishing last operation >>get_increment.log
else
  export mzk_user=!!!USERNAME!!!!
  export mzk_user_pwd=!!!HESLO!!!
  #
  echo work >/root/work.lst
  #
  export LOGFILE="/var/lib/mysql/tmp/synchro.log"
  export TIMESTAMP="date +%Y%m%d_%H%M%S_%N"
  #
  echo "`${TIMESTAMP}` Sync BE->FE Begin" >> $LOGFILE
  ./get_full_checksum_and_sync.sh
  echo "`${TIMESTAMP}` Sync BE->FE End" >> $LOGFILE
  #
  echo "`${TIMESTAMP}` Export Begin" >> $LOGFILE
  #
  echo "`${TIMESTAMP}` Table abuse" >> $LOGFILE
  ./synchro_one.sh abuse
  echo "`${TIMESTAMP}` Table eshop" >> $LOGFILE
  ./synchro_one.sh eshop
  echo "`${TIMESTAMP}` Table review" >> $LOGFILE
  ./synchro_one.sh review
  echo "`${TIMESTAMP}` Table library" >> $LOGFILE
  ./synchro_one.sh library
  echo "`${TIMESTAMP}` Table upload" >> $LOGFILE
  ./synchro_one.sh upload
  echo "`${TIMESTAMP}` Table user" >> $LOGFILE
  ./synchro_one.sh user
  
  echo "`${TIMESTAMP}` Table cover" >> $LOGFILE
  ./synchro_one.sh cover
  echo "`${TIMESTAMP}` Table marc" >> $LOGFILE
  ./synchro_one.sh marc
  echo "`${TIMESTAMP}` Table product" >> $LOGFILE
  ./synchro_one.sh product
  echo "`${TIMESTAMP}` Table book" >> $LOGFILE
  ./synchro_one.sh book 
  #
  mysql -s --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="select concat('delete from obalky.cover where id=',id,';') from obalky.cover where created > CURDATE();" >/var/lib/mysql/tmp/cover_del.sql
  mysql -s --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="select concat('delete from obalky.product where id=',id,';') from obalky.product where book in (SELECT book FROM obalky.cover where created > CURDATE());" >/var/lib/mysql/tmp/product_del.sql
  mysql -s --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="select concat('delete from obalky.book where id=',id,';') from obalky.book where id in (SELECT book FROM obalky.cover where created > CURDATE())" >/var/lib/mysql/tmp/book_del.sql
  mysql -s --host=195.113.155.13 --max_allowed_packet=512M --compress --password=$mzk_user_pwd  --user=$mzk_user  --execute="select concat('delete from obalky.marc where id=',id,';') from obalky.marc where book in (SELECT book FROM obalky.cover where created > CURDATE());" >/var/lib/mysql/tmp/marc_del.sql
  #
  mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="created > CURDATE()" obalky cover >/var/lib/mysql/tmp/cover_dif.sql
  mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="book in (SELECT book FROM obalky.cover where created > CURDATE())" obalky product >/var/lib/mysql/tmp/product_dif.sql
  mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="id in (SELECT book FROM obalky.cover where created > CURDATE())" obalky book >/var/lib/mysql/tmp/book_dif.sql
  mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="book in (SELECT book FROM obalky.cover where created > CURDATE())" obalky marc >/var/lib/mysql/tmp/marc_dif.sql
  #
  echo "`${TIMESTAMP}` Table toc" >> $LOGFILE
  ./synchro_one.sh toc
  echo "`${TIMESTAMP}` Table fileblob" >> $LOGFILE
  ./synchro_one.sh fileblob
  echo "`${TIMESTAMP}` Import to local" >> $LOGFILE
  mysql --force obalky  <get_increment.sql
  echo "`${TIMESTAMP}` Export End" >> $LOGFILE
  rm /root/work.lst
fi
