# TODO

- [ ] Dodać Autoruns
- [ ] Dodać TaskSchedulerView 

# PowerShell 

Poniższe polecenia wymagają PowerShell w wersji 3 lub wyższej (polecenie `Invoke-WebRequest` i `Invoke-RestMethod`)
http://www.pajcomp.pl/pub/?dir=Windows/PowerShell51
Instalacja PowerShell 5.1 (wymaga .Net 4.5 lub wyższej)
http://www.pajcomp.pl/pub/?dir=Windows/dotNet48

# Double Commander

Polecenia wykonaj w oknie PowerShell uruchomionym z uprawnieniami administratora.

```powershell
# notepad3
# winget install -e --id Rizonesoft.Notepad3 --accept-package-agreements
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\notepad3.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\notepad3.exe" -ArgumentList "/SILENT /SP-"

# Double Commander
# winget install -e --id alexx2000.DoubleCommander --accept-package-agreements
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"

New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Double Commander.lnk")
$shortcut.TargetPath = "C:\Program Files\Double Commander\doublecmd.exe"
$shortcut.Save()

# system
# PowerShell
# winget install -e --id Microsoft.PowerShell --accept-package-agreements
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\ps7.msi"
Start-Process -Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"

## BgInfo
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile "C:\Programy\Sysinternals\Bginfo.exe"
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "C:\Programy\Sysinternals\bginfo.bgi"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk")
$shortcut.Arguments = "c:\Programy\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
$shortcut.TargetPath = "C:\Programy\Sysinternals\Bginfo.exe"
$shortcut.Save()
Invoke-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk"

## Process Monitor
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/Procmon.exe" -OutFile "C:\Programy\Sysinternals\Procmon.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Procmon.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\Procmon.exe"
$shortcut.Save()

## Process Explorer
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/procexp.exe" -OutFile "C:\Programy\Sysinternals\procexp.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Procexp.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\procexp.exe"
$shortcut.Save()

# sql
## AdminSQL
New-Item -Path "C:\Programy\AdminSQL\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "C:\Programy\AdminSQL\AdminSQL.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\AdminSQL.lnk")
$shortcut.TargetPath = "C:\Programy\AdminSQL\AdminSQL.exe"
$shortcut.Save()

winget install -e --id heidisql.heidisql --accept-package-agreements
winget install -e --id Microsoft.SQLServerManagementStudio --accept-package-agreements




# programy biurowe
winget install -e --id  TheDocumentFoundation.LibreOffice --accept-package-agreements
winget install -e --id  TrackerSoftware.PDF-XChangeEditor --accept-package-agreements
winget install -e --id  Foxit.FoxitReader --accept-package-agreements
winget install -e --id  7zip.7zip --accept-package-agreements



# zdalny dostęp
## Instalacja TeamViewer
winget install -e --id TeamViewer.TeamViewer.Host --accept-package-agreements
winget install -e --id TeamViewer.TeamViewer --accept-package-agreements

## Skroty na pulpicie



# Prezentacje
## ZoomIt
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/ZoomIt.exe" -OutFile "C:\Programy\Sysinternals\ZoomIt.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ZoomIt.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\ZoomIt.exe"
$shortcut.Save()

## Key-n-Stroke
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Key-n-Stroke\" -ItemType Directory -Force | Out-Null
New-Item -Path "$($env:LOCALAPPDATA)\Key-n-Stroke" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "C:\Programy\Key-n-Stroke\Key-n-Stroke.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "$($env:LOCALAPPDATA)\Key-n-Stroke\settings.json"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Key-n-Stroke.lnk")
$shortcut.TargetPath = "C:\Programy\Key-n-Stroke\Key-n-Stroke.exe"
$shortcut.Save()


# Pobieranie z githuba plików :)
# Invoke-WebRequest -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} |  |  Select-Object -ExpandProperty browser_download_url



# przegladarki
winget install -e --id brave.brave --accept-package-agreements
winget install -e --id Mozilla.Firefox --accept-package-agreements
winget install -e --id Opera.opera --accept-package-agreements
winget install -e --id Google.Chrome --accept-package-agreements
winget install -e --id vivalditechnologies.vivaldi --accept-package-agreements

winget install -e --id  Mozilla.Thunderbird --accept-package-agreements


# programy graficzne
winget install -e --id  Icons8.Lunacy --accept-package-agreements
winget install -e --id  Inkscape.Inkscape --accept-package-agreements
winget install -e --id  KDE.Krita --accept-package-agreements


# NPS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Posnet-NPS\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "C:\Programy\NPS.zip"
Expand-Archive 'C:\Programy\NPS.zip' -DestinationPath 'C:\Programy'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\PosnetNPS.lnk")
$shortcut.TargetPath = "C:\Programy\NPS\NPS.exe"
$shortcut.Save()

# OPS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
New-Item -Path "C:\Programy\Posnet-OPS\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.zip" -OutFile "C:\Programy\posnet-ops-setup-11.30.80.zip" 
$ProgressPreference = 'Continue'
Expand-Archive 'C:\Programy\posnet-ops-setup-11.30.80.zip' -DestinationPath 'C:\Programy\Posnet-OPS'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\PosnetOPS.lnk")
$shortcut.TargetPath = "C:\Programy\Posnet-OPS\Posnet OPS.exe"
$shortcut.Save()




$acl = Get-Acl "C:\Programy\NPS_"
New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","Allow")
$acl.SetAccessRule($accessRule)
Get-ChildItem -Path "C:\Programy\NPS_" -Force | Set-Acl -AclObject $acl 


# Get the security descriptor for the file using Get-ACL
$newACL = Get-ACL D:\exported_ua.cer
# Use the Get-ChildItem to recusively to apply security descriptor using set-acl
Get-ChildItem -Path "D:\Certificates" -Recurse -Include "*.cer" -Force | Set-Acl -AclObject $newAcl


```

