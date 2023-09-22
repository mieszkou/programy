# Wprowadzenie

Polecenia wykonaj w oknie PowerShell uruchomionym z uprawnieniami administratora.

Poniższe polecenia wymagają PowerShell w wersji 3 lub wyższej (polecenie `Invoke-WebRequest` i `Invoke-RestMethod`). 
Dla windows poniżej 10 mogą wymagać doinstalowania PowerShell5.
http://www.pajcomp.pl/pub/?dir=Windows/PowerShell51

Sprawdzenie wersji PowerShell: `Get-Host`

Instalacja PowerShell 5.1 (wymaga .Net 4.5 lub wyższej)
http://www.pajcomp.pl/pub/?dir=Windows/dotNet48

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
New-Item -Path "C:\Serwis" -ItemType Directory -Force | Out-Null

# notepad3
# =======================================================
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest -Uri $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
Remove-Item $installerPath

# Double Commander
# =======================================================
$uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest -Uri $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
Remove-Item $installerPath

New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"

$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("C:\Serwis\Double Commander.lnk")
$shortcut.TargetPath = "C:\Program Files\Double Commander\doublecmd.exe"
$shortcut.Save()

# 7-zip
# =======================================================
$uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like "a/*") -and ($_.href -like "*-x64.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath

## Process Monitor
# =======================================================
Invoke-WebRequest -Uri "https://live.sysinternals.com/Procmon.exe" -OutFile "C:\Serwis\Procmon.exe"

## Process Explorer
# =======================================================
Invoke-WebRequest -Uri "https://live.sysinternals.com/procexp.exe" -OutFile "C:\Serwis\procexp.exe"

## Posnet NPS
# =======================================================
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "C:\Serwis\NPS.zip"
Expand-Archive 'C:\Serwis\NPS.zip' -DestinationPath 'C:\Serwis'
Rename-Item 'C:\Serwis\NPS' 'Posnet-NPS'

## Posnet OPS
New-Item -Path "C:\Serwis\Posnet-OPS\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "C:\Serwis\posnet-ops-setup-11.30.80.exe" 
Start-Process -Wait -FilePath "C:\Serwis\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=c:\Serwis\Posnet-OPS"

## Elzab Stampa 
# =======================================================
# dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5

New-Item -Path "C:\Serwis\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "C:\Serwis\stampa.zip"
Expand-Archive 'C:\Serwis\stampa.zip' -DestinationPath 'C:\Serwis\Elzab-Stampa'

## Elzab - programy  komunikacyjne
# =======================================================
# Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane są w instrukcji programisty. 
# Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
# przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.

New-Item -Path "C:\Serwis\Elzab-winexe\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "C:\Serwis\winexe.zip"
Expand-Archive 'C:\Serwis\winexe.zip' -DestinationPath 'C:\Serwis\Elzab-winexe'

## AdminSQL
# =======================================================
New-Item -Path "C:\Serwis\AdminSQL\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "C:\Serwis\AdminSQL\AdminSQL.exe"

## HeidiSQL
# =======================================================

$uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
Invoke-WebRequest $uri -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/VERYSILENT /NORESTART /MERGETASKS=!activate_updatechecks /MERGETASKS=!desktopicon" -Verb RunAs -Wait
Remove-Item $installerPath

# SQL - silnik bazy danych (SQL Server Express)
## SQL 2019
# =======================================================
$sqlver=2019
New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"

# Insoft 
# =======================================================
# pobieranie najnowszych wersji PCM i PCPOS

$uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"
$installerPath = Join-Path "C:\Serwis" (Split-Path $uri -Leaf)
Invoke-WebRequest -Uri $uri -OutFile $installerPath

$uri = "https://pobierz.insoft.com.pl/PC-POS7/Wersja_aktualna/pcpos7_x64_install.exe"
$installerPath = Join-Path "C:\Serwis" (Split-Path $uri -Leaf)
Invoke-WebRequest -Uri $uri -OutFile $installerPath

Start-Process c:\Serwis
```