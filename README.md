# TODO

- [ ] Dodać Autoruns
- [ ] Dodać TaskSchedulerView 

# PowerShell 

Spradzenie wersji PowerShell: `Get-Host`

![](img/gethost.gif)

Poniższe polecenia wymagają PowerShell w wersji 3 lub wyższej (polecenie `Invoke-WebRequest` i `Invoke-RestMethod`). 
Dla windows poniżej 10 mogą wymagać doinstalowania PowerShell5.
http://www.pajcomp.pl/pub/?dir=Windows/PowerShell51

Instalacja PowerShell 5.1 (wymaga .Net 4.5 lub wyższej)
http://www.pajcomp.pl/pub/?dir=Windows/dotNet48

# Instalacja programów

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
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/brave/brave-browser/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name -eq "BraveBrowserStandaloneSetup.exe" } | Select-Object -ExpandProperty browser_download_url
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\BraveBrowserStandaloneSetup.exe"
$ProgressPreference = 'Continue'
Start-Process -Wait -FilePath "$($env:TEMP)\BraveBrowserStandaloneSetup.exe"








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


# Posnet
# NPS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "C:\Programy\NPS.zip"
Expand-Archive 'C:\Programy\NPS.zip' -DestinationPath 'C:\Programy'
Rename-Item 'C:\Programy\NPS' 'Posnet-NPS'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\PosnetNPS.lnk")
$shortcut.TargetPath = "C:\Programy\Posnet-NPS\NPS.exe"
$shortcut.Save()

# OPS
New-Item -Path "C:\Programy\Posnet-OPS\" -ItemType Directory -Force | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "C:\Programy\posnet-ops-setup-11.30.80.exe" 
$ProgressPreference = 'Continue'
Start-Process -Wait -FilePath "C:\Programy\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=c:\Programy\Posnet-OPS"

# Elzab
# Program serwisowy Eureka (dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
# Program przeznaczony jest do obsługi K10/Sigma/kas ONLINE:
# .net 4

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "C:\Programy\eureka.zip"
Expand-Archive 'C:\Programy\eureka.zip' -DestinationPath 'C:\Programy\Elzab-Eureka'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Eureka.lnk")
$shortcut.TargetPath = "C:\Programy\Elzab-Eureka\bez instalatora\Eureka!.exe"
$shortcut.Save()

# Program serwisowy Stampa dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "C:\Programy\stampa.zip"
Expand-Archive 'C:\Programy\stampa.zip' -DestinationPath 'C:\Programy\Elzab-Stampa'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Stampa.lnk")
$shortcut.TargetPath = "C:\Programy\Elzab-Stampa\bez instalatora\Stampa.exe"
$shortcut.Save()

# Funkcje komunikacyjne
# Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane są w instrukcji programisty. 
# Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
# przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.

New-Item -Path "C:\Programy\Elzab-winexe\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "C:\Programy\winexe.zip"
Expand-Archive 'C:\Programy\winexe.zip' -DestinationPath 'C:\Programy\Elzab-winexe'

```

