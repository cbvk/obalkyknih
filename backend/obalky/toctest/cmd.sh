#!/bin/sh

curl -F "login=martin@sarfy.cz" -F "password=heslo123" \
	 -F "isbn=9789992226609" \
	 -F "cover=@cover9.jpg" \
	 -F "toc_page_1=@toc_page_1.jpg" -F "toc_page_2=@toc_page_2.jpg" \
	 -F "meta=@metadata.txt" \
	 http://localhost/api/import

#	 https://obalkyknih.cz/api/import
#	 https://obalkyknih.cz/api/import
