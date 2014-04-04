-- get_increment.sql
use "obalky";
SET FOREIGN_KEY_CHECKS=0;
\! echo imp abuse `${TIMESTAMP}`
source /var/lib/mysql/tmp/abuse.sql
\! echo imp eshop `${TIMESTAMP}`
source /var/lib/mysql/tmp/eshop.sql
\! echo imp fileblob `${TIMESTAMP}`
source /var/lib/mysql/tmp/fileblob.sql
\! echo imp library `${TIMESTAMP}`
source /var/lib/mysql/tmp/library.sql
\! echo imp review `${TIMESTAMP}`
source /var/lib/mysql/tmp/review.sql
\! echo imp toc `${TIMESTAMP}`
source /var/lib/mysql/tmp/toc.sql
\! echo imp upload `${TIMESTAMP}`
source /var/lib/mysql/tmp/upload.sql
\! echo imp user `${TIMESTAMP}`
source /var/lib/mysql/tmp/user.sql
\! echo imp marc `${TIMESTAMP}`
source /var/lib/mysql/tmp/marc.sql
\! echo imp product `${TIMESTAMP}`
source /var/lib/mysql/tmp/product.sql
\! echo imp book `${TIMESTAMP}`
source /var/lib/mysql/tmp/book.sql
\! echo imp cover `${TIMESTAMP}`
source /var/lib/mysql/tmp/cover.sql
\! echo patche 
\! echo patche cover `${TIMESTAMP}`
source /var/lib/mysql/tmp/cover_del.sql
\! echo patche product `${TIMESTAMP}`
source /var/lib/mysql/tmp/product_del.sql
\! echo patche book `${TIMESTAMP}`
source /var/lib/mysql/tmp/book_del.sql
\! echo patche marc `${TIMESTAMP}`
source /var/lib/mysql/tmp/marc_del.sql
\! echo patche insert new 
\! echo patche insert new cover `${TIMESTAMP}`
source /var/lib/mysql/tmp/cover_dif.sql
\! echo patche insert new product `${TIMESTAMP}`
source /var/lib/mysql/tmp/product_dif.sql
\! echo patche insert new book `${TIMESTAMP}`
source /var/lib/mysql/tmp/book_dif.sql
\! echo patche insert new marc `${TIMESTAMP}`
source /var/lib/mysql/tmp/marc_dif.sql
\! echo Konec
SET FOREIGN_KEY_CHECKS=1;
