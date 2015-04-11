--------------------------------------

SobekCM MARC Library (Version 1.2)

--------------------------------------

LICENSE AND COPYRIGHT

Copyright 2005-2012 Mark Sullivan ( Mark.V.Sullivan@gmail.com )

This library is released under the Lesser GNU Public License, which is 
included within the download.


PURPOSE

This is a C# library which contains classes for working in memory with
MARC records ( http://www.loc.gov/marc/ ).  This allows records to be
read from MarcXML and Marc21 formats.  Once in memory any field or subfield
can be edited, added, or deleted.  Then the record can be queried or 
saved again in either a MarcXML or Marc21 file format.


USE

This library has been developed over the last six years and is used in several
open-source projects and within the University of Florida Digital Library
Center workflow applications.  The term 'SobekCM' references the two 
open-source applications which have been previously released, but this 
library should be able to be used across many different applications.  I am 
releasing it as open-source here as we are planning on using this library 
more commonly in other upcoming projects the UF Libraries are involved in.


FUTURE PLANS

I would like to add a simple interface to the Marc record which allows you 
to query for simple dublin core values ( i.e., title, creator, etc.. ) without
a full understanding of the MARC record format.  


REQUIREMENTS

I find that this works best when working with either MarcXML or Marc21 that is 
encoded with Unicode character encoding (rather than Marc character encoding).


Z39.50

As of version 1.1, Z39.50 has been added to this library.  You can query
a Z39.50 endpoint for a record by primary identifier, or control number.
Demo4 in the demo app shows this.

For Z39.50 to work, you need to copy all the contents in the DLLs\Zoom.net 
folder directly into the bin folder.  Likewise, if you wish to distribute
an application with Z39.50 based on this library, all those files must also
be included in your release.



Mark Sullivan
Mark.V.Sullivan@gmail.com

    