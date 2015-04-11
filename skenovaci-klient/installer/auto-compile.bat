@echo off
REM If you have installed InnoSetup with ISPP and auto-compile doesn't start InnoSetup,
REM try running auto-compile.bat with path to you InnoSetup folder, e.g. auto-compile.bat "C:\Program Files\Inno Setup 5"

REM Check if parameter was passed
if "%~1" NEQ "" (
set InnoDir=%~1
goto:COMPILATION
)

REM CONFIGURATION OF INNO SETUP 5 REGKEY (shouldn't be needed to modify - didn't changed since 2005)
set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 5_is1"
set VALUE_NAME="Inno Setup: App Path"
REM find version of reg.exe
for /f "tokens=1-2" %%i in ('sigcheck.exe %WINDIR%\System32\reg.exe /accepteula') do ( if "%%i"=="Version:" set filever=%%j )
for /f "tokens=1,2 delims=." %%a in ("%filever%") do ( set filever=%%a.%%b )
if %filever% GTR 6 (
echo Compiling on Windows Vista or newer
set regskip=2
) else (
echo Compiling on Windows XP
set regskip=4
)
REM check if key exists or try WOW6432Node
reg query %KEY_NAME% 1>nul 2>nul
if %ERRORLEVEL% NEQ 0 (
set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 5_is1"
)
REM Get InnoSetup folder
FOR /F "usebackq skip=%regskip% tokens=4-5* " %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set InnoDir=%%C
)
REM Check that folder was found
if "%InnoDir%" == "" (
    @echo %KEY_NAME%\%VALUE_NAME% not found.
    echo YOU MUST INSTALL InnoSetup 5 unicode version with ISPP
    GOTO:EOF
)

:COMPILATION
echo using InnoSetup folder: %InnoDir%
REM Compile admin setup file
"%InnoDir%\Compil32.exe" /cc scannerClient_installer.iss
REM Compile NoAdmin setup file
"%InnoDir%\Compil32.exe" /cc scannerClient_installer_noAdmin.iss
REM count SHA256 of Admin installer
for /f "tokens=1 delims= " %%a in ('sha256deep.exe Output/ObalkyKnih-scanner_setup.exe') do @set hashAdmin=%%a
REM count SHA256 of NoAdmin installer
for /f "tokens=1 delims= " %%a in ('sha256deep.exe Output/ObalkyKnih-scanner_setupNoAdmin.exe') do @set hashNoAdmin=%%a
REM get Version
for /f "tokens=1-2" %%i in ('sigcheck.exe Output\ObalkyKnih-scanner_setup.exe /accepteula') do ( if "%%i"=="Version:" set filever=%%j )
for /f "tokens=1,2 delims=." %%a in ("%filever%") do (set majorVersion=%%a)
for /f "tokens=2 delims=." %%a in ("%filever%") do (set minorVersion=%%a)
REM create XML
>Output\output.txt echo		^<latest-version^>
>>Output\output.txt echo			^<!-- Admin version --^>
>>Output\output.txt echo			^<version type="Admin"^>
>>Output\output.txt echo				^<major^>%majorVersion%^</major^>
>>Output\output.txt echo				^<minor^>%minorVersion%^</minor^>
>>Output\output.txt echo				^<date^>%date:~3%^</date^>
>>Output\output.txt echo				^<checksum^>%hashAdmin%^</checksum^>
>>Output\output.txt echo				^<download^>https://obalkyknih.cz/obalkyknih-scanner/obalkyknih-scanner_setup.exe^</download^>
>>Output\output.txt echo			^</version^>
>>Output\output.txt echo			^<!-- NoAdmin version --^>
>>Output\output.txt echo			^<version type="User"^>
>>Output\output.txt echo				^<major^>%majorVersion%^</major^>
>>Output\output.txt echo				^<minor^>%minorVersion%^</minor^>
>>Output\output.txt echo				^<date^>%date:~3%^</date^>
>>Output\output.txt echo				^<checksum^>%hashNoAdmin%^</checksum^>
>>Output\output.txt echo				^<download^>https://obalkyknih.cz/obalkyknih-scanner/obalkyknih-scanner_setupNoAdmin.exe^</download^>
>>Output\output.txt echo			^</version^>
>>Output\output.txt echo		^</latest-version^>
REM inform all successfully done
echo *********All done*********