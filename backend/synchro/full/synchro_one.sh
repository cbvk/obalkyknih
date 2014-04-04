  xtable=$1
  maxid=$(mysql -s --execute="select max(id) from obalky.$xtable;"|cut -f1)
  echo "$xtable" "$maxid"
  if [ $maxid = "NULL" ]
  then
  mysqldump --host=195.113.155.13 --compress --complete-insert --lock-all-tables --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  obalky $xtable  >/var/lib/mysql/tmp/$xtable.sql
  else 
  mysqldump --host=195.113.155.13 --max_allowed_packet=512M --compress --complete-insert --lock-all-tables --no-create-db --no-create-info --extended-insert=FALSE --password=$mzk_user_pwd  --user=$mzk_user  --where="id > $maxid" obalky $xtable  >/var/lib/mysql/tmp/$xtable.sql
  fi