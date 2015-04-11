;Installer for wiaaut.dll
[Setup]
PrivilegesRequired=admin
Uninstallable=no
OutputBaseFilename=wia_and_.NET_Installer
AppPublisher=Moravská Zemská Knihovna
AppPublisherURL=http://www.mzk.cz/
AppId=wiaInstaller
DisableDirPage=yes
DisableProgramGroupPage=yes
AppName=wia2.0
AppVersion=1.0
DefaultDirName={sys}\ObalkyKnih-scanner
DefaultGroupName=ObalkyKnih-scanner
UpdateUninstallLogAppName=no
CreateUninstallRegKey=no
Compression=lzma2
SolidCompression=yes
AllowNoIcons=no
;maximal resolution is 164x314, picture has 163x314, which creates 1 pixel border 
WizardImageFile=wizardImage.bmp
WizardImageStretch=no
;color which creates border
WizardImageBackColor=$A0A0A0
;max resolution 55x58 pixels
WizardSmallImageFile=wizardSmallImage.bmp

[Languages]
Name: "cz"; MessagesFile: "compiler:Languages\Czech.isl"

[Files]
Source: "dotNetFx40_Client_setup.exe"; Flags: dontcopy
Source: "..\ScannerClient-obalkyknih\WIA-DLL\wiaaut.dll"; DestDir: "{sys}"; Flags: onlyifdoesntexist 32bit

[Run]
Filename: "{sys}\regsvr32"; Parameters: "/s {sys}\wiaaut.dll"

[Code]
{Detect .NET version}
function IsDotNetDetected(version: string; service: cardinal): boolean;
// version -- Specify one of these strings for the required .NET Framework version:
//    'v1.1.4322'     .NET Framework 1.1
//    'v2.0.50727'    .NET Framework 2.0
//    'v3.0'          .NET Framework 3.0
//    'v3.5'          .NET Framework 3.5
//    'v4\Client'     .NET Framework 4.0 Client Profile
//    'v4\Full'       .NET Framework 4.0 Full Installation
//
// service -- Specify any non-negative integer for the required service pack level:
//    0               No service packs required
//    1, 2, etc.      Service pack 1, 2, etc. required
var
    key: string;
    install, serviceCount: cardinal;
    success: boolean;
begin
    key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\' + version;
    // .NET 3.0 uses value InstallSuccess in subkey Setup
    if Pos('v3.0', version) = 1 then begin
        success := RegQueryDWordValue(HKLM, key + '\Setup', 'InstallSuccess', install);
    end else begin
        success := RegQueryDWordValue(HKLM, key, 'Install', install);
    end;
    // .NET 4.0 uses value Servicing instead of SP
    if Pos('v4', version) = 1 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Servicing', serviceCount);
    end else begin
        success := success and RegQueryDWordValue(HKLM, key, 'SP', serviceCount);
    end;
    result := success and (install = 1) and (serviceCount >= service);
end;

procedure InitializeWizard();
var ResultCode:Integer;
begin
  {Check version of .NET, if not 4.0 or higher, install 4.0 Client Profile}
  if not IsDotNetDetected('v4\Client', 0) then begin
    MsgBox('Aplikace vyžaduje .NET Framework 4.0 Client Profile.'#13#13
            'Teï zaène jeho instalace.', mbInformation, MB_OK);
    ExtractTemporaryFile('dotNetFx40_Client_setup.exe');
    Exec(ExpandConstant('{tmp}\dotNetFx40_Client_setup.exe'),'',
         '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
    if not (ResultCode = 0) then
    begin
      MsgBox('Instalace se nezdaøila:' #13#13 'Nezdaøila se instalace .Net Framework 4.0 Client Profile. '
                 + 'Skuste ho nainstalovat ruènì.', mbError, MB_OK);
      Abort();
    end;
  end;
end;
