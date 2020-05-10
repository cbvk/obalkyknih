
/* dbicx-autodoc -Ilib --schema=Obalky::Schema::DB --output=./docs */
/* dbicdeploy -Ilib Obalky::Schema::ObalkyDB ~ GraphViz */

/* CREATE DATABASE obalky; 
   GRANT ALL PRIVILEGES ON obalky.* TO 'obalky'@'localhost' 
         IDENTIFIED BY 'visk2009'; */ 

/* SET STORAGE_ENGINE = InnoDb; */

DROP DATABASE obalky; 
CREATE DATABASE obalky; 
USE obalky;

DROP TABLE IF EXISTS library;
CREATE TABLE library (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	code		VARCHAR(16) NOT NULL,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	name		VARCHAR(255) NOT NULL,

	address		VARCHAR(255) NOT NULL, /* postovni adresa */
	city		VARCHAR(64) NOT NULL, /* mesto i zvlast */
	emailboss	VARCHAR(64) NOT NULL, /* email */
	emailads	VARCHAR(64) NOT NULL,
	skipmember	BOOLEAN, /* null - stare registrace */

	webopac		VARCHAR(255) NOT NULL /* url */
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE library AUTO_INCREMENT = 50001;
CREATE UNIQUE INDEX library_code ON library(code);
INSERT INTO library (id,code,name,webopac) VALUES 
	(50000,"none","none","http://www.obalkyknih.cz");
INSERT INTO library (id,code,name,webopac) VALUES 
	(50001,"obalky","obalky-dev","http://www.obalkyknih.cz");
INSERT INTO library (id,code,name,webopac) VALUES 
	(50002,"muni","MUNI","http://aleph.muni.cz");
INSERT INTO library (id,code,name,webopac) VALUES 
	(50003,"mzk","MZK","http://aleph.mzk.cz");

DROP TABLE IF EXISTS eshop;
CREATE TABLE eshop (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	name		VARCHAR(16), /* class Name.pm */
	fullname	VARCHAR(64),

	try_count	INTEGER DEFAULT 0,
	hit_count	INTEGER DEFAULT 0,

	logo_url	VARCHAR(255),
	xmlfeed_url	VARCHAR(255),
	web_url		VARCHAR(255) NOT NULL/* NOT NULL, UNIQUE? */

	/* ostatni veci jsou metody Eshop::* trid (jsou staticke) */
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eshop_weburl ON eshop(web_url);
ALTER TABLE eshop AUTO_INCREMENT = 101;
/* staticka implicitni databaze? */
/* harvest skript taky jako eshop? */

DROP TABLE IF EXISTS user;
CREATE TABLE user (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	login		VARCHAR(64), /* email */
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fullname	VARCHAR(64) NOT NULL,
	password	VARCHAR(32) NOT NULL,
	library		INTEGER, /* jen knihovnici */
	FOREIGN KEY (library) REFERENCES library(id),
	eshop		INTEGER, /* jen nakladatele */
	FOREIGN KEY (eshop) REFERENCES eshop(id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE user AUTO_INCREMENT = 60001;
CREATE UNIQUE INDEX user_login ON user(login);
INSERT INTO user (id,login,fullname,password,library) VALUES 
	(60001,"martin@sarfy.cz","Martin Sarfy","heslo123",50001);

DROP TABLE IF EXISTS seanse;
CREATE TABLE seanse (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	library		INTEGER NOT NULL,
	FOREIGN KEY (library) REFERENCES library(id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE seanse AUTO_INCREMENT = 400000001;

DROP TABLE IF EXISTS visitor;
CREATE TABLE visitor (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	library		INTEGER NOT NULL,
	FOREIGN KEY (library) REFERENCES library(id),
	first_ip	CHAR(16) NOT NULL,
	first_time	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	last_ip     CHAR(16) NOT NULL,
	last_time   DATETIME NOT NULL,
	name		CHAR(16) NOT NULL, /* z nejakeho jeho review */
	count		INTEGER DEFAULT 1
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE visitor AUTO_INCREMENT = 550000001;

DROP TABLE IF EXISTS seance;
CREATE TABLE seance (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	library		INTEGER NOT NULL,
	FOREIGN KEY (library) REFERENCES library(id),
	visitor		INTEGER NOT NULL,
	FOREIGN KEY (visitor) REFERENCES visitor(id),
	start_time	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	last_time	DATETIME,
	count		INTEGER DEFAULT 1
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE seance AUTO_INCREMENT = 530000001;

DROP TABLE IF EXISTS lastrequests;
CREATE TABLE lastrequests (
	id				INTEGER PRIMARY KEY AUTO_INCREMENT,
	library			INTEGER NOT NULL,
	book			INTEGER NOT NULL,
	visitor			INTEGER NOT NULL,
	marc			INTEGER NOT NULL,
	session_info	CHAR(40),
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE lastrequests AUTO_INCREMENT = 730000001;

DROP TABLE IF EXISTS fileblob;
CREATE TABLE fileblob (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	mime		VARCHAR(64) NOT NULL,
	medium		VARCHAR(64) NOT NULL,
	content		MEDIUMBLOB NOT NULL /* file content, max 16MB */
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE fileblob AUTO_INCREMENT = 120000001;

DROP TABLE IF EXISTS cover;
CREATE TABLE cover (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	product		INTEGER NOT NULL,
/*  klic definovan pomoci ALTER -- cyklicka vazba */
/*	FOREIGN KEY (product) REFERENCES product(id), */
	book		INTEGER NOT NULL,
/*  klic definovan pomoci ALTER -- cyklicka vazba */
/*	FOREIGN KEY (book) REFERENCES book(id)*/

	file_icon	INTEGER NOT NULL,
	FOREIGN KEY (file_icon) REFERENCES fileblob(id),
	file_thumb	INTEGER NOT NULL,
	FOREIGN KEY (file_thumb) REFERENCES fileblob(id),
	file_medium	INTEGER NOT NULL,
	FOREIGN KEY (file_medium) REFERENCES fileblob(id),
	file_orig	INTEGER NOT NULL,
	orig_width	INTEGER,
	orig_height	INTEGER,
	checksum	VARCHAR(32) NOT NULL, /* file_orig checksum */
	FOREIGN KEY (file_orig) REFERENCES fileblob(id),

	orig_url	VARCHAR(255) NOT NULL,

	used_last	DATETIME, /* used_first je cca jako created */
	used_count	INTEGER DEFAULT 0
) ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT = 210000001;
ALTER TABLE cover AUTO_INCREMENT = 210000001;
CREATE UNIQUE INDEX cover_checksum ON cover(checksum);
CREATE INDEX cover_book ON cover(book); /* ? */
CREATE INDEX cover_created ON cover(created); /* pro ->recent() */
CREATE UNIQUE INDEX cover_product ON cover(product); /* 1:0 vazba */
CREATE INDEX cover_recent ON cover(created);

DROP TABLE IF EXISTS toc;
CREATE TABLE toc ( /* rozdelit na PDF a TXT? */
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	product		INTEGER NOT NULL,
/*  klic definovan pomoci ALTER -- cyklicka vazba */
/*	FOREIGN KEY (product) REFERENCES product(id), */
	book		INTEGER NOT NULL,
/*	FOREIGN KEY (book) REFERENCES book(id), */

	pdf_url		VARCHAR(255),
	pdf_file	MEDIUMBLOB, /* file content, max 16MB */
	pdf_thumbnail  MEDIUMBLOB,

	full_text	TEXT
) ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT = 220000001;
ALTER TABLE toc AUTO_INCREMENT = 220000001;
CREATE UNIQUE INDEX toc_product ON toc(product); /* 1:0 vazba */

DROP TABLE IF EXISTS work;
CREATE TABLE work (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE work AUTO_INCREMENT = 40000001;

DROP TABLE IF EXISTS book;
CREATE TABLE book (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	/* blok identifikatoru */
	ean13		CHAR(13),
	oclc		VARCHAR(32),
	nbn			VARCHAR(32), /* v podstate rozbyty identifier */
	authors		VARCHAR(255),
	title		VARCHAR(255),
	year		INTEGER,

	search_count INTEGER DEFAULT 0,
	harvest_max_eshop	INTEGER, /* nebo resit binarni mapou? */
	harvest_last_time	DATETIME,

	cover	 	INTEGER,
	FOREIGN KEY (cover) REFERENCES cover(id),
	toc			INTEGER,
	FOREIGN KEY (toc) REFERENCES toc(id),
	review		INTEGER, /* nase anotace */
/*	FOREIGN KEY (review) REFERENCES review(id), */

	cached_rating_sum	INTEGER, /* nase hodnoceni */
	cached_rating_count	INTEGER, /* z #product a z #ratings */

	work		INTEGER,
	FOREIGN KEY (work) REFERENCES work(id),
	citation	VARCHAR(255),
	
	tips		VARCHAR(255) /* mezerou oddeleny seznam jinych book id */
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX book_work ON book(work); /* pro dohledani del */
CREATE INDEX book_author ON book(authors);
CREATE INDEX book_title ON book(title);
CREATE INDEX book_year ON book(year);
CREATE INDEX book_ean13 ON book(ean13);
CREATE INDEX book_nbn ON book(nbn);
CREATE INDEX book_oclc ON book(oclc);
CREATE INDEX book_cover ON book(cover);
CREATE INDEX book_review ON book(review);
ALTER TABLE book AUTO_INCREMENT = 110000001;

/* cannot be defined earlier -- circular dependency... */
/*ALTER TABLE media ADD FOREIGN KEY (book) REFERENCES book(id);*/
ALTER TABLE cover ADD FOREIGN KEY (book) REFERENCES book(id);
ALTER TABLE toc ADD FOREIGN KEY (book) REFERENCES book(id);

DROP TABLE IF EXISTS product;
CREATE TABLE product (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	eshop	 	INTEGER NOT NULL,
	FOREIGN KEY (eshop) REFERENCES eshop(id),
	book	 	INTEGER NOT NULL,
	FOREIGN KEY (book) REFERENCES book(id),

	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	modified	DATETIME NOT NULL, /* opetovne stazeni */

	/* blok identifikatoru */
	ean13		CHAR(13),
	oclc		VARCHAR(32),
	nbn			VARCHAR(32), /* v podstate rozbyty identifier */
	authors		VARCHAR(255),
	title		VARCHAR(255),
	year		INTEGER,

	price_vat	DECIMAL(5,2), /* vcetne dane */
	price_cur   CHAR(3), /* CZK, EUR, USD,... */

	/* cover, toc, reviews[] */
	cover	 	INTEGER,
	FOREIGN KEY (cover) REFERENCES cover(id),
	cover_url	VARCHAR(255),

	toc			INTEGER,
	FOREIGN KEY (toc) REFERENCES toc(id),
/*	rating		INTEGER, */ /* 0..100 or NULL */

	product_url	VARCHAR(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX product_eshop_book ON product(eshop,book);
CREATE UNIQUE INDEX product_product_url ON product(product_url);
ALTER TABLE product AUTO_INCREMENT = 600000001;

ALTER TABLE cover  ADD FOREIGN KEY (product) REFERENCES product(id);
ALTER TABLE toc    ADD FOREIGN KEY (product) REFERENCES product(id);

DROP TABLE IF EXISTS review; /* ze zdroje nebo nas */
CREATE TABLE review (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	book		INTEGER NOT NULL,
	FOREIGN KEY (book) REFERENCES book(id),

	impact		INTEGER NOT NULL, /* 0 - anotace, 1 - review, 9 - komentar */

	product		INTEGER,
	FOREIGN KEY (product) REFERENCES product(id),

	library		INTEGER,
	FOREIGN KEY (library) REFERENCES library(id),
	visitor		INTEGER, /* bud visitor nebo product */
	FOREIGN KEY (visitor) REFERENCES visitor(id),
	visitor_name	CHAR(16), /* jmeno ctenare */
	visitor_ip		CHAR(16),

	approved	INTEGER, /* NULL nebo user id. zobrazujeme vsak vsechny */

	rating		INTEGER, /* 0..100 or NULL */

	html_text	TEXT /* NULL pokud je to jen rating */
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX review_rating ON review(rating);
CREATE INDEX review_book ON review(book);
ALTER TABLE review AUTO_INCREMENT = 230000001;

ALTER TABLE book  ADD FOREIGN KEY (review) REFERENCES review(id);

/* much better name is 'record', but DBIx::Class complains... */
DROP TABLE IF EXISTS marc; 
CREATE TABLE marc (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	book	 	INTEGER NOT NULL,
	FOREIGN KEY (book) REFERENCES book(id),
	library		INTEGER NOT NULL,
	FOREIGN KEY (library) REFERENCES library(id),

	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	/* blok identifikatoru */
	ean13		CHAR(13),
	oclc		VARCHAR(32),
	nbn			VARCHAR(32), /* v podstate rozbyty identifier */
	authors		VARCHAR(255),
	title		VARCHAR(255),
	year		INTEGER,
	/* pages	INTEGER, ? */

	permalink	VARCHAR(255) NOT NULL /* unique id */

) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX marc_permalink ON marc(permalink);
CREATE UNIQUE INDEX marc_library_book ON marc(library,book);
ALTER TABLE marc AUTO_INCREMENT = 700000001;

/*DROP TABLE IF EXISTS viewed;
CREATE TABLE viewed (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	seance		INTEGER NOT NULL,
	FOREIGN KEY (seance) REFERENCES seance(id),
	book		INTEGER NOT NULL,
	FOREIGN KEY (book) REFERENCES book(id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;*/

DROP TABLE IF EXISTS tip;
CREATE TABLE tip (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	book1		INTEGER NOT NULL,
	FOREIGN KEY (book1) REFERENCES book(id),
	book2		INTEGER NOT NULL,
	FOREIGN KEY (book2) REFERENCES book(id),
	weight		INTEGER
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX tip_book1 ON tip(book1);
CREATE INDEX tip_book1_book2 ON tip(book1,book2);
ALTER TABLE tip AUTO_INCREMENT = 1500000001;


DROP TABLE IF EXISTS tag;
CREATE TABLE tag (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	value		VARCHAR(64),
	book		INTEGER NOT NULL, /* nebo to nejak vazat na marc ? */
	FOREIGN KEY (book) REFERENCES book(id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX tag_value ON tag(value);
CREATE INDEX tag_book ON tag(book);
ALTER TABLE tag AUTO_INCREMENT = 1710000001;

/* Tabulka #upload nema pravo na existenci! Jsou v ni primarni data */
DROP TABLE IF EXISTS upload;
CREATE TABLE upload (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	user		INTEGER,
	FOREIGN KEY (user) REFERENCES user(id),
	product		INTEGER,
	FOREIGN KEY (product) REFERENCES product(id),
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	batch		VARCHAR(32) NOT NULL,
/*	identifier	VARCHAR(32), */
	origname	VARCHAR(128) NOT NULL,
	orig_url	VARCHAR(255), /* NULL kdyz byl soubor uploadovan */

	filename	VARCHAR(255) NOT NULL,
	checksum	VARCHAR(32) NOT NULL,

	/* blok identifikatoru */
	ean13		CHAR(13),
	oclc		VARCHAR(32),
	nbn			VARCHAR(32),
	authors		VARCHAR(255),
	title		VARCHAR(255),
	year		VARCHAR(32)

) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX upload_batch ON upload(batch);
ALTER TABLE upload AUTO_INCREMENT = 30000001;

/* mozna neni potrebne? */
DROP TABLE IF EXISTS request;
CREATE TABLE request (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

/*	referer		VARCHAR(128), */
	library		INTEGER NOT NULL,
	FOREIGN KEY (library) REFERENCES library(id),
	client_ip	VARCHAR(64) NOT NULL,
	visitor_id	INTEGER NOT NULL, /* pro urychleni to neni FK */
/*	visitor		INTEGER NOT NULL,
	FOREIGN KEY (visitor) REFERENCES visitor(id),*/
	seance_id	INTEGER NOT NULL, /* pro urychleni to neni FK */
/*	seance	INTEGER NOT NULL,
	FOREIGN KEY (seance) REFERENCES seance(id),*/

	method		VARCHAR(16) NOT NULL,
	returning	VARCHAR(16) NOT NULL,

    /* blok identifikatoru */
    ean13       CHAR(13),
    oclc        VARCHAR(32),
    nbn         VARCHAR(32), /* v podstate rozbyty identifier */
	authors		VARCHAR(255),
	title		VARCHAR(255),
	year		INTEGER,

	format		VARCHAR(16) NOT NULL,

	cover		INTEGER, /* NULL kdyz nenalezeno */
	FOREIGN KEY (cover) REFERENCES cover(id),

	result		VARCHAR(64) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE request AUTO_INCREMENT = 800000001;
/* CREATE INDEX request_library ON request(library); -- je potreba?? */

DROP TABLE IF EXISTS abuse;
CREATE TABLE abuse (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	note		VARCHAR(255),

	cover		INTEGER NOT NULL, /* only covers? or media-s? */
	FOREIGN KEY (cover) REFERENCES cover(id),
	book		INTEGER NOT NULL,
	FOREIGN KEY (book) REFERENCES book(id),
	client_ip	VARCHAR(16) NOT NULL,
	referer		VARCHAR(255) NOT NULL,

	approved_by VARCHAR(255),
	approved 	TIMESTAMP

) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE abuse AUTO_INCREMENT = 50000001;


DROP TABLE IF EXISTS cache;
CREATE TABLE cache (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	bookid		INTEGER,
	request		VARCHAR(255),
	response	VARCHAR(255)

) ENGINE = InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE cache AUTO_INCREMENT = 60000001;
CREATE UNIQUE INDEX cache_request ON cache(request);
CREATE INDEX cache_created ON cache(created);
CREATE INDEX cache_bookid ON cache(bookid);


