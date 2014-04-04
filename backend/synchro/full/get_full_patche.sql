use "obalky";
SET FOREIGN_KEY_CHECKS=0;
\! echo delete request
truncate table obalky.request;
\! echo delete visitor
truncate table obalky.visitor;
--
\! echo delete abuse
truncate table obalky.abuse;
\! echo delete eshop
truncate table obalky.eshop;
\! echo delete review
truncate table obalky.review;
\! echo delete library
truncate table obalky.library;
\! echo delete upload
truncate table obalky.upload;
\! echo delete user
truncate table obalky.user;
--
\! echo delete book where = id > 112400157
truncate table obalky.book;
\! echo delete cover where = id > 765516
truncate table obalky.cover;
\! echo delete marc where = id > 703560256
truncate table obalky.marc;
\! echo delete product where = id > 600918723
truncate table obalky.product;
--
\! echo Import eshop
source /var/lib/mysql/tmp/eshop.sql;
\! echo Import library
source /var/lib/mysql/tmp/library.sql;
\! echo Import upload
source /var/lib/mysql/tmp/upload.sql;
\! echo Import user
source /var/lib/mysql/tmp/user.sql;
\! echo Import book
source /var/lib/mysql/tmp/book.sql;
\! echo Import product
source /var/lib/mysql/tmp/product.sql;
\! echo Import marc
source /var/lib/mysql/tmp/marc.sql;
\! echo Import cover
source /var/lib/mysql/tmp/cover.sql;
\! echo Import abuse
source /var/lib/mysql/tmp/abuse.sql;
\! echo Import review 
source /var/lib/mysql/tmp/review.sql;
\! echo Import toc
source /var/lib/mysql/tmp/toc.sql;
\! echo Import fileblob
source /var/lib/mysql/tmp/fileblob.sql;
\! echo Konec
SET FOREIGN_KEY_CHECKS=1;


