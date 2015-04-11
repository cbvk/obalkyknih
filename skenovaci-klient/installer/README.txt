Requirements:

1. Visual C# Express 2010 or newer or Visual Studio 2010 or newer
   <http://www.microsoft.com/visualstudio/eng/products/visual-studio-2010-express>
2. InnoSetup 5 unicode version installed with ISPP <http://www.jrsoftware.org/>
--------------------------------------------------------------------------------------------------

3 steps of creating and publishing of a new version:

1. you need to open ScannerClient-obalkyknih.sln in Visual C#,
INCREMENT ASSEMBLY VERSION (Properties->Application->Assembly Information->Assembly version)
and build the project (File Version will be synced automatically with Assembly version).
You may increment Assembly versions for other projects, if significant changes were done,
however, it is not needed, their build and revision numbers are incremented during every build.

2. run auto-compile.bat from command line

3. copy all executable files (.exe) from Output into folder obalkyknih-scanner on server
and edit update-info.xml on server by replacing latest-version tag with the text generated
in output.txt file.

Done
=================================================================================================
�ESKY********************************************************************************************
=================================================================================================
Po�adavky:

1. Visual C# Express 2010 nebo nov�j��, nebo Visual Studio 2010 nebo nov�j�� 
   <http://www.microsoft.com/visualstudio/cze/products/visual-studio-2010-express>
2. InnoSetup 5 unicode verze instalovan� s ISPP <http://www.jrsoftware.org/>
--------------------------------------------------------------------------------------------------

3 kroky vytvo�en� a vyd�n� nov� verze:

1. Mus�te otev��t ScannerClient-obalkyknih.sln ve Visual C #,
ZV݊IT ASSEMBLY VERSION (Properties->Application->Assembly information->Assembly version)
a skompilovat projekt.
Pokud byli v�znamn� zm�ny i v jin�ch projektech, tak m��ete zv��it jejich assembly version taky,
ale nen� to nutn�, nakolik p�i ka�d� kompilaci sa nav��� revision a build number.

2. Spus�te auto-compile.bat z p��kazov� ��dky

3. Zkop�rujte v�echny spustiteln� soubory (.exe) ze slo�ky Output  na server obalkyknih.cz 
do slo�ky obalkyknih-skener a upravte update-Info.xml na serveru nahrazen�m latest-version tagu
textem generovan�m v Output.txt.

Hotovo