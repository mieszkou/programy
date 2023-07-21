# Wprowadzenie

Polecenia wykonaj w oknie PowerShell uruchomionym z uprawnieniami administratora.

Poniższe polecenia wymagają PowerShell w wersji 3 lub wyższej (polecenie `Invoke-WebRequest` i `Invoke-RestMethod`). 
Dla windows poniżej 10 mogą wymagać doinstalowania PowerShell5.
http://www.pajcomp.pl/pub/?dir=Windows/PowerShell51

Sprawdzenie wersji PowerShell: `Get-Host`

![](img/gethost.gif)

Instalacja PowerShell 5.1 (wymaga .Net 4.5 lub wyższej)
http://www.pajcomp.pl/pub/?dir=Windows/dotNet48

- `$ProgressPreference = 'SilentlyContinue'` - to polecenie "przyspiesza" pobieranie przez `Invoke-WebRequest` (x razy !) - wyłącza pasek postępu 
- `$ProgressPreference = 'Continue'` - to włącza go ponownie w danej sesji
- `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12` - dzięki temu starsze windowsy pobierają pliki przez SSL (na nowych jest to zbędne)

## Notepad3

```powershell
# notepad3
# =======================================================
# winget install -e --id Rizonesoft.Notepad3 --accept-package-agreements
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\notepad3.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\notepad3.exe" -ArgumentList "/SILENT /SP-"
```

## Double Commander

Tu poza instalacją dogrywana jest "moja" propozycja konfiguracji.

```powershell
# Double Commander
# =======================================================
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
```

## 7-zip

```powershell
# 7-zip
# https://gist.github.com/dansmith65/7dd950f183af5f5deaf9650f2ad3226c
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like "a/*") -and ($_.href -like "*-x64.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath
```
# System

## PowerShell 7

```powershell
# PowerShell
# =======================================================
# winget install -e --id Microsoft.PowerShell --accept-package-agreements
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\ps7.msi"
Start-Process -Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
```

## Bginfo

Dodaje do autostartu + mój konfig.

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile "C:\Programy\Sysinternals\Bginfo.exe"
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "C:\Programy\Sysinternals\bginfo.bgi"
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.txt" -OutFile "C:\Programy\Sysinternals\bginfo.txt"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk")
$shortcut.Arguments = "c:\Programy\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
$shortcut.TargetPath = "C:\Programy\Sysinternals\Bginfo.exe"
$shortcut.Save()
Invoke-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk"
```

## Process Monitor

```powershell
## Process Monitor
# =======================================================
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/Procmon.exe" -OutFile "C:\Programy\Sysinternals\Procmon.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Procmon.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\Procmon.exe"
$shortcut.Save()

## Process Explorer
# =======================================================
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/procexp.exe" -OutFile "C:\Programy\Sysinternals\procexp.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Procexp.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\procexp.exe"
$shortcut.Save()
```

# Prezentacje/screen casty

## ZoomIt

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Sysinternals\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/ZoomIt.exe" -OutFile "C:\Programy\Sysinternals\ZoomIt.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ZoomIt.lnk")
$shortcut.TargetPath = "C:\Programy\Sysinternals\ZoomIt.exe"
$shortcut.Save()
```

## Key-n-Stroke

Program wyświetla wciskane klawisze na ekranie + mój konfig

```powershell
# =======================================================
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Key-n-Stroke\" -ItemType Directory -Force | Out-Null
New-Item -Path "$($env:LOCALAPPDATA)\Key-n-Stroke" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "C:\Programy\Key-n-Stroke\Key-n-Stroke.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "$($env:LOCALAPPDATA)\Key-n-Stroke\settings.json"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Key-n-Stroke.lnk")
$shortcut.TargetPath = "C:\Programy\Key-n-Stroke\Key-n-Stroke.exe"
$shortcut.Save()
```


## Brave

Awaryjna instalacja przeglądarki (to może nie działać, lepiej to robić przez winget)

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/brave/brave-browser/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name -eq "BraveBrowserStandaloneSetup.exe" } | Select-Object -ExpandProperty browser_download_url
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\BraveBrowserStandaloneSetup.exe"
$ProgressPreference = 'Continue'
Start-Process -Wait -FilePath "$($env:TEMP)\BraveBrowserStandaloneSetup.exe"
```

# Programy serwisowe do kas fiskalnych

## Posnet NPS

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "C:\Programy\NPS.zip"
Expand-Archive 'C:\Programy\NPS.zip' -DestinationPath 'C:\Programy'
Rename-Item 'C:\Programy\NPS' 'Posnet-NPS'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\PosnetNPS.lnk")
$shortcut.TargetPath = "C:\Programy\Posnet-NPS\NPS.exe"
$shortcut.Save()
```

## Posnet OPS

```powershell
New-Item -Path "C:\Programy\Posnet-OPS\" -ItemType Directory -Force | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "C:\Programy\posnet-ops-setup-11.30.80.exe" 
$ProgressPreference = 'Continue'
Start-Process -Wait -FilePath "C:\Programy\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=c:\Programy\Posnet-OPS"
```

## Elzab Eureka 

(dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
Program przeznaczony jest do obsługi K10/Sigma/kas ONLINE: .net 4

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "C:\Programy\eureka.zip"
Expand-Archive 'C:\Programy\eureka.zip' -DestinationPath 'C:\Programy\Elzab-Eureka'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Eureka.lnk")
$shortcut.TargetPath = "C:\Programy\Elzab-Eureka\bez instalatora\Eureka!.exe"
$shortcut.Save()
```

## Elzab Stampa 

dla Windows XP/2000/VISTA/7/8/8.1/10
Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
.net 4.5

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
New-Item -Path "C:\Programy\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "C:\Programy\stampa.zip"
Expand-Archive 'C:\Programy\stampa.zip' -DestinationPath 'C:\Programy\Elzab-Stampa'
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Stampa.lnk")
$shortcut.TargetPath = "C:\Programy\Elzab-Stampa\bez instalatora\Stampa.exe"
$shortcut.Save()
```

## Elzab - programy  komunikacyjne

Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
Funkcje komunikacyjne opisane są w instrukcji programisty. 
Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.

```powershell
New-Item -Path "C:\Programy\Elzab-winexe\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "C:\Programy\winexe.zip"
Expand-Archive 'C:\Programy\winexe.zip' -DestinationPath 'C:\Programy\Elzab-winexe'
```

# SQL - narzędzia

## AdminSQL

Narzędzie firmy Insoft upraszaczające niektóre czynności przy bazie danych.

```powershell
New-Item -Path "C:\Programy\AdminSQL\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "C:\Programy\AdminSQL\AdminSQL.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\AdminSQL.lnk")
$shortcut.TargetPath = "C:\Programy\AdminSQL\AdminSQL.exe"
$shortcut.Save()
```

## HeidiSQL

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath
```

## SQL Server Management Studio

```
winget install -e --id Microsoft.SQLServerManagementStudio --accept-package-agreements
```


# SQL - silnik bazy danych (SQL Server Express)

Pobieranie i instalacja SQL Server Express z włączonym TCP, logowaniem SQL, hasło sa to `Wapro3000`.
Port TCP jest ustawiany na `520xx` gdzie xx to końcówka wersji SQL (np dla 2022 jest 52022)
Ostatnie polecenie otwiera odpowiedni port w firewall-u windows.

## SQL 2022

Uwaga! SQL 2022 startuje automatycznie, ale z opóźnieniem.

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2022
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```


## SQL 2019

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2019
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```

## SQL 2017

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2017
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql14.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql14.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```

## SQL 2016 sp3

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2016
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql13.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql13.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```

## SQL 2014 sp2(?)

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2014
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/Q /X:$($env:TEMP)\SQLEXPR_$($sqlver)"
Start-Process -Wait -FilePath "$($env:TEMP)\SQLEXPR_$($sqlver)\setup.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql12.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql12.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```

## SQL 2012

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sqlver=2012
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql11.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql11.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
```

# TODO

- [ ] Dodać Autoruns
- [ ] Dodać Autostart
- [ ] Dodać TaskSchedulerView 

# Zestaw poleceń `winget`

```powershell
# =======================================================

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

# SQL Tools
# =======================================================
winget install -e --id heidisql.heidisql --accept-package-agreements
winget install -e --id Microsoft.SQLServerManagementStudio --accept-package-agreements

# programy biurowe
# =======================================================
winget install -e --id  TheDocumentFoundation.LibreOffice --accept-package-agreements
winget install -e --id  TrackerSoftware.PDF-XChangeEditor --accept-package-agreements
winget install -e --id  Foxit.FoxitReader --accept-package-agreements
winget install -e --id  7zip.7zip --accept-package-agreements

# zdalny dostęp
## Instalacja TeamViewer
winget install -e --id TeamViewer.TeamViewer.Host --accept-package-agreements
winget install -e --id TeamViewer.TeamViewer --accept-package-agreements

## Skroty na pulpicie

```


# Materiały, źródła, etc

- https://learn.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-ver16
- https://dba.stackexchange.com/questions/242337/unattended-install-to-listen-on-specified-interface
- https://winaero.com/open-port-windows-firewall-windows-10/

