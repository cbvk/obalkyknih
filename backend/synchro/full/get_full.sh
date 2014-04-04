#get_full
#
LOGFILE="/var/lib/mysql/tmp/synchro.log"
TIMESTAMP="date +%Y%m%d_%H%M%S_%N"
echo "`${TIMESTAMP}` Export Begin" >> $LOGFILE
#
echo "`${TIMESTAMP}` Table cover" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky cover >/var/lib/mysql/tmp/cover.sql
echo "`${TIMESTAMP}` Table marc" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky marc >/var/lib/mysql/tmp/marc.sql
echo "`${TIMESTAMP}` Table product" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky product >/var/lib/mysql/tmp/product.sql
echo "`${TIMESTAMP}` Table book" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky book  >/var/lib/mysql/tmp/book.sql
#
echo "`${TIMESTAMP}` Table abuse" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky abuse >/var/lib/mysql/tmp/abuse.sql
echo "`${TIMESTAMP}` Table eshop" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky eshop >/var/lib/mysql/tmp/eshop.sql
echo "`${TIMESTAMP}` Table review" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky review >/var/lib/mysql/tmp/review.sql
echo "`${TIMESTAMP}` Table library" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky library >/var/lib/mysql/tmp/library.sql
echo "`${TIMESTAMP}` Table upload" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky upload >/var/lib/mysql/tmp/upload.sql
echo "`${TIMESTAMP}` Table user" >> $LOGFILE
mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky user >/var/lib/mysql/tmp/user.sql
#
#mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky request >/var/lib/mysql/tmp/request.sql
#mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky visitor >/var/lib/mysql/tmp/visitor.sql
#
echo "`${TIMESTAMP}` Table toc" >> $LOGFILE
./synchro_one.sh toc
#mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="id > 71952 " obalky toc >/var/lib/mysql/tmp/toc.sql
echo "`${TIMESTAMP}` Table fileblob" >> $LOGFILE
#mysqldump --host=195.113.155.13 --single-transaction --max_allowed_packet=512M --compress --complete-insert --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="id > 137781580 " obalky fileblob >/var/lib/mysql/tmp/fileblob.sql
./synchro_one.sh fileblob
echo "`${TIMESTAMP}` Export End" >> $LOGFILE
