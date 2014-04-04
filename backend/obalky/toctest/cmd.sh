#!/bin/sh

curl -F "login=martin@sarfy.cz" -F "password=heslo123" \
	 -F "isbn=80-7169-860-1" -F "nbn=000963469" -F "oclc=85001122" \
	 -F "cover=@cover.jpg" \
	 -F "toc_page_1=@toc_page_1.jpg" -F "toc_page_2=@toc_page_2.jpg" \
	 -F "meta=@metadata.txt" \
	 http://localhost:4000/api/import

#	 https://obalkyknih.cz/api/import
