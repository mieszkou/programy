$installPath = "C:\Serwis"

$jsonContent = @"
[   
    { "nazwa": "Podstawowe" },
    { "nazwa": "💾 Notepad 3",                         "polecenia": [ "InstallNotepad3" ] },
    { "nazwa": "💾😎 Double Commander",                  "polecenia": [ "InstallDoubleCmd" ] },
    { "nazwa": "💾 7-zip",                             "polecenia": [ "Install7Zip" ] },
    { "nazwa": "💾 LibreOffice.org",                   "polecenia": [ "InstallLibreOffice" ]},
    { "nazwa": "Zdalna pomoc" },
    { "nazwa": "📦 TeamViewerQS (kopiuj na pulpit)",          "polecenia": [ "InstallTeamViewerQS" ] },
    { "nazwa": "💾😎 TeamViewer Host (instaluj)",        "polecenia": [ "InstallTeamViewerHost" ] },
    { "nazwa": "Narzędzia SQL" },
    { "nazwa": "📦 AdminSQL",                          "polecenia": [ "InstallAdminSql" ] },
    { "nazwa": "💾 HeidiSQL",                          "polecenia": [ "InstallHeidiSql" ] },
    { "nazwa": "💾 SQL Server Management Studio",      "polecenia": [ "InstallSSMS" ] },
    { "nazwa": "Systemowe" },
    { "nazwa": "💾 PowerShell 7",                      "polecenia": [ "InstallPowerShell7" ] },
    { "nazwa": "📦😎 Bginfo",                            "polecenia": [ "InstallBginfo" ] },
    { "nazwa": "📦 Process Monitor",                   "polecenia": [ "InstallSysInternals -fileName 'Procmon'" ] },
    { "nazwa": "📦 Process Explorer",                  "polecenia": [ "InstallSysInternals -fileName 'procexp'" ] },
    { "nazwa": "📦 Autologon",                         "polecenia": [ "InstallSysInternals -fileName 'Autologon'" ] },
    { "nazwa": "📦 Autoruns",                          "polecenia": [ "InstallSysInternals -fileName 'autoruns'" ] },
    { "nazwa": "📦 ZoomIt",                            "polecenia": [ "InstallSysInternals -fileName 'ZoomIt'" ] },
    { "nazwa": "📦😎 Key-n-Stroke",                      "polecenia": [ "InstallKeyNStroke" ] },
    { "nazwa": "Nirsoft" },
    { "nazwa": "📦☠️ WirelessKeyView",             "polecenia": [ "InstallWirelessKeyView" ] },
    { "nazwa": "📦 WirelessNetworkWatcher (Netscan)",  "polecenia": [ "InstallWirelessNetworkWatcher" ] },
    { "nazwa": "📦 WirelessNetView",                   "polecenia": [ "InstallWirelessNetView" ] },
    { "nazwa": "📦☠️ Mail PassView (AV!)",               "polecenia": [ "InstallMailPassView" ] },
    { "nazwa": "📦☠️ Network Password Recovery (AV!)",   "polecenia": [ "InstallNetworkPasswordRecovery" ] },
    { "nazwa": "📦 TaskSchedulerView ",                   "polecenia": [ "InstallTaskSchedulerView " ] },


    { "nazwa": "Do urządzeń fiskalnych" },
    { "nazwa": "📦 Posnet NPS",                        "polecenia": [ "InstallPosnetNps" ] },
    { "nazwa": "💾 Posnet OPS",                        "polecenia": [ "InstallPosnetOps" ] },
    { "nazwa": "📦 Elzab Eureka",                      "polecenia": [ "InstallElzabEureka" ] },
    { "nazwa": "📦 Elzab Stampa",                      "polecenia": [ "InstallElzabStampa" ] },
    { "nazwa": "📦 Elzab - programy  komunikacyjne",   "polecenia": [ "InstallElzabWinexe" ] },
    { "nazwa": "📦 Sterowniki do urządzeń",            "polecenia": [ "InstallDrivers" ], "opis": "Wszystkie sterowniki z https://pajcomp.pl/pub/?dir=Sterowniki" },

    { "nazwa": "Silnik bazy danych SQL" },
    { "nazwa": "💾😎🛠️ MS SQL 2022 Express",               "polecenia": [ "InstallSql2022" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2022\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52022`\n- Otwarcie tego portu w firewall-u windows (!!)." },
    
    { "nazwa": "💾😎🛠️ MS SQL 2019 Express",               "polecenia": [ "InstallSql2019" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2019\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52022`\n- Otwarcie tego portu w firewall-u windows (!!)." },
    
    { "nazwa": "Programy" },
    { "nazwa": "💾 Insoft PCM",                        "polecenia": [ "InstallPcm" ] },
    { "nazwa": "💾 Insoft PC-POS",                     "polecenia": [ "InstallPcPos" ] },
    { "nazwa": "💾 WAPRO (wszystkie, aktualizacja)",   "polecenia": [ "InstallWapro" ] }
]
"@

# Funkcja do zapisu komunikatu do pliku logu
function Write-Log { 
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy-MM-dd HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $logFile -value $LogMessage

    $textbox.Text += $LogMessage + "`r`n"
    $textbox.ScrollToEnd()

    Write-Host $LogString
}

# Funkcja wyświetla w konsoli informację dla użytkownika i zapisuje ją do pliku logu z sygnatura czasową
function Write-HostAndLog { 
    param (
        [Parameter(Mandatory = $true)]
        [string]$LogString
    )

    Write-Log -LogString $LogString
    Write-Host $LogString
}

function CreateDesktopShortcut {
    param (
        [string]$ShortcutName,
        [string]$File, 
        [string]$Arguments
    )
    $WshShell = New-Object -ComObject WScript.Shell
    try {
        $shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('CommonDesktopDirectory'))\$ShortcutName.lnk")
        $shortcut.TargetPath = $File
        $shortcut.Arguments = $Arguments
        $shortcut.Save()
    
    } Catch {
        $shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('DesktopDirectory'))\$ShortcutName.lnk")
        $shortcut.TargetPath = $File
        $shortcut.Arguments = $Arguments
        $shortcut.Save()
    
    }   
    
}

function InstallNotepad3 {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath 
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
    Remove-Item $installerPath
}


function InstallDoubleCmd {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
    New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
    try {
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
    }
    catch {

    }
    try {
        Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
    }
    catch {
        
    }
    
    
    CreateDesktopShortcut -ShortcutName "Double Commander" -File "C:\Program Files\Double Commander\doublecmd.exe"
}

function InstallLibreOffice {
    $DownloadUri = "https://download.documentfoundation.org/libreoffice/stable/"
    $r = Invoke-WebRequest -UseBasicParsing -Uri "$DownloadUri/"
    $versions = ($r.Links | Where-Object { $_.href -match "(\d{2}\.\d+\.\d+\/)" }).href -replace "/", ""
    $Version = $versions | Sort-Object -Descending | Select-Object -First 1
    $uri = $($DownloadUri + $Version + "/win/x86_64/") + (Invoke-WebRequest -UseBasicParsing -Uri $($DownloadUri + $Version + "/win/x86_64/") | Select-Object -ExpandProperty Links | Where-Object {($_.href -like '*_x86-64.msi')} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath 
    Start-Process -Wait -FilePath $installerPath -ArgumentList "/passive ProductLanguage=1045"
    Remove-Item $installerPath
}


function InstallTeamViewerQS {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewerQS_paj24.exe"
    
    try {
        Invoke-WebRequest -UseBasicParsing $uri -OutFile "$([Environment]::GetFolderPath('CommonDesktopDirectory'))\TeamViewerQS.exe"
    } Catch {
        Invoke-WebRequest -UseBasicParsing $uri -OutFile "$([Environment]::GetFolderPath('DesktopDirectory'))\TeamViewerQS.exe"
    }
}


function InstallTeamViewerHost {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewer_Host_x64.msi"
    $uri_conf = "https://www.pajcomp.pl/pub/TeamViewer/.tv_paj.tvopt"
    
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $confPath = Join-Path $env:TEMP (Split-Path $uri_conf -Leaf)

    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    Invoke-WebRequest -UseBasicParsing $uri_conf -OutFile $confPath

    #-Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
    Start-Process -Wait -FilePath $installerPath  -ArgumentList "/passive CUSTOMCONFIGID=639wciv SETTINGSFILE=$confPath"
}


# msiexec.exe /i TeamViewer_Host_x64.msi /passive CUSTOMCONFIGID=639wciv


function Install7Zip {
    $uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like 'a/*') -and ($_.href -like '*-x64.exe')} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallPowerShell7 {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile "$($env:TEMP)\ps7.msi"
    Start-Process -Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
}


function InstallSysInternals {
    param( 
        [string]$fileName
    )
    New-Item -Path "$installPath\Sysinternals\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://live.sysinternals.com/$fileName.exe" -OutFile "$installPath\Sysinternals\$fileName.exe"
    
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\$fileName.exe"
}

function InstallBginfo {
    $fileName = "Bginfo"
    InstallSysInternals -fileName $fileName
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\Bginfo.exe" -Arguments  "$installPath\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
    CreateDesktopShortcut -ShortcutName "$fileName - edytuj info" -File "$installPath\Sysinternals\bginfo.txt"

    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "$installPath\Sysinternals\bginfo.bgi"
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.txt" -OutFile "$installPath\Sysinternals\bginfo.txt"
    
    $WshShell = New-Object -ComObject WScript.Shell
    
    $shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk")
    $shortcut.Arguments = "$installPath\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
    $shortcut.TargetPath = "$installPath\Sysinternals\Bginfo.exe"
    $shortcut.Save()

    # Wczytaj plik binarny
    $file = "$installPath\Sysinternals\bginfo.bgi"
    $filenew = $file
    $newpath = $installPath


    try {
        # Wczytaj plik binarny jako bajty
        $bytes = [System.IO.File]::ReadAllBytes($file)
    
        $endIndex = 0x0502
        $startIndex = 0x50C
        $newPathBytes = [System.Text.Encoding]::UTF8.GetBytes($newpath)
        $bytes[0x04fd] = ("$installPath\Sysinternals\bginfo.txt").Length+2
        $newBytes = $bytes[0..($endIndex-1)] + $newPathBytes + $bytes[($startIndex+1)..($bytes.Length - 1)]
        
    
        [System.IO.File]::WriteAllBytes($filenew, $newBytes)
    
    } catch {
        Write-Host "Wystąpił błąd: $_"
    }
    Invoke-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk"
}

function InstallKeyNStroke {
    New-Item -Path "$installPath\Key-n-Stroke\" -ItemType Directory -Force | Out-Null
    New-Item -Path "$($env:LOCALAPPDATA)\Key-n-Stroke" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "$($env:LOCALAPPDATA)\Key-n-Stroke\settings.json"
    
    CreateDesktopShortcut -ShortcutName "Key-n-Stroke" -File "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
}
function InstallWirelessKeyView {
    $uri = "https://www.nirsoft.net/toolsdownload/wirelesskeyview.zip"
    $uri7zip = "https://www.pajcomp.pl/pub/%21Misc/7z.exe"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_key.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $7zipPath = Join-Path $env:TEMP (Split-Path $uri7zip -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    Invoke-WebRequest -UseBasicParsing $uri7zip -OutFile $7zipPath
    
    Start-Process -Wait -FilePath $7zipPath -ArgumentList "e $installerPath -o$installPath\Nirsoft\ * -p`"WKey4567#`" -y" -NoNewWindow
    CreateDesktopShortcut -ShortcutName "WirelessKeyView" -File "$installPath\Nirsoft\WirelessKeyView.exe"
    Remove-Item $installerPath
}

function InstallWirelessNetworkWatcher {
    $uri = "https://www.nirsoft.net/utils/wnetwatcher-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_network_watcher.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "Wireless Network Watcher" -File "$installPath\Nirsoft\WNetWatcher.exe"
    Remove-Item $installerPath
}

function InstallWirelessNetView {
    $uri = "https://www.nirsoft.net/utils/wirelessnetview.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_network_view.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "WirelessNetView" -File "$installPath\Nirsoft\WirelessNetView.exe"
    Remove-Item $installerPath
}


function InstallMailPassView {
    $uri = "https://www.nirsoft.net/toolsdownload/mailpv.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/mailpv.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "MailPassView" -File "$installPath\Nirsoft\mailpv.exe"
    Remove-Item $installerPath
}

function InstallNetworkPasswordRecovery {
    $uri = "https://www.nirsoft.net/toolsdownload/netpass-x64.zip"
    $uri7zip = "https://www.pajcomp.pl/pub/%21Misc/7z.exe"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/network_password_recovery.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $7zipPath = Join-Path $env:TEMP (Split-Path $uri7zip -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    Invoke-WebRequest -UseBasicParsing $uri7zip -OutFile $7zipPath
    
    Start-Process -Wait -FilePath $7zipPath -ArgumentList "e $installerPath -o$installPath\Nirsoft\ * -p`"ntps5291#`" -y" -NoNewWindow
    CreateDesktopShortcut -ShortcutName "Network Password Recovery" -File "$installPath\Nirsoft\netpass.exe"
    Remove-Item $installerPath
}

function InstallTaskSchedulerView {
    $uri = "https://www.nirsoft.net/utils/taskschedulerview-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/task_scheduler_view.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "TaskSchedulerView " -File "$installPath\Nirsoft\TaskSchedulerView.exe"
    Remove-Item $installerPath
}

function InstallPosnetNps {
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "$installPath\NPS.zip"
    Expand-Archive "$installPath\NPS.zip" -DestinationPath "$installPath"
    Rename-Item "$installPath\NPS" "Posnet-NPS"

    CreateDesktopShortcut -ShortcutName "PosnetNPS" -File "$installPath\Posnet-NPS\NPS.exe"
}

function InstallPosnetOps {
    New-Item -Path "$installPath\Posnet-OPS\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "$installPath\posnet-ops-setup-11.30.80.exe" 
    Start-Process -Wait -FilePath "$installPath\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=$installPath\Posnet-OPS"
}

# (dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
# Program przeznaczony jest do obsługi K10/Sigma/kas ONLINE: .net 4
function InstallElzabEureka {
    New-Item -Path "$installPath\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "$installPath\eureka.zip"
    Expand-Archive "$installPath\eureka.zip" -DestinationPath "$installPath\Elzab-Eureka"

    CreateDesktopShortcut -ShortcutName "ELZAB Eureka" -File "$installPath\Elzab-Eureka\bez instalatora\Eureka!.exe"
}

# dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5

function InstallElzabStampa {
    New-Item -Path "$installPath\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "$installPath\stampa.zip"
    Expand-Archive "$installPath\stampa.zip" -DestinationPath "$installPath\Elzab-Stampa"

    CreateDesktopShortcut -ShortcutName "ELZAB Stampa" -File "$installPath\Elzab-Stampa\bez instalatora\Stampa.exe"
}

# Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane są w instrukcji programisty. 
# Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
# przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.
function InstallElzabWinexe {
    New-Item -Path "$installPath\Elzab-winexe\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "$installPath\winexe.zip"
    Expand-Archive "$installPath\winexe.zip" -DestinationPath "$installPath\Elzab-winexe"
}

function InstallDrivers {
    $uri = "https://www.pajcomp.pl/pub/?zip=Sterowniki"
    
    $installerPath = Join-Path $env:TEMP "Sterowniki.zip"
    $destinationPath = "$installPath\Sterowniki\"

    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    
    New-Item -Path $destinationPath -ItemType Directory -Force | Out-Null
    Expand-Archive $installerPath -DestinationPath $destinationPath -Force
    Remove-Item $installerPath

    # Pobranie listy plików zip
    $plikiZip = Get-ChildItem -Path $destinationPath -File -Recurse | Where-Object { ($_.Name -like "*.zip") -OR ( $_.Name -like "*.exe") }

    # Dla każdego pliku zip
    foreach ($plik in $plikiZip) {
    try {
        $nazwaKatalogu = $plik.BaseName
        Expand-Archive -Path $plik.FullName -DestinationPath "$($plik.DirectoryName)\$nazwaKatalogu" -Force
    } catch {
        Remove-Item -Path "$($plik.DirectoryName)\$nazwaKatalogu" -Force
    }
    

}
}



function InstallAdminSql {
    New-Item -Path "$installPath\AdminSQL\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "$installPath\AdminSQL\AdminSQL.exe"
    
    CreateDesktopShortcut -ShortcutName "AdminSQL" -File "$installPath\AdminSQL\AdminSQL.exe"
}

function InstallHeidiSql {
    $uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/ALLUSERS /silent" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallSSMS {
    $uri = "https://aka.ms/ssmsfullsetup"
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile "$($env:TEMP)\ssmsfullsetup.exe"
    Start-Process -FilePath "$($env:TEMP)\ssmsfullsetup.exe" -Args "/passive" -Verb RunAs -Wait
}


function InstallSql2022 {
    $sqlver=2022
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
}

function InstallSql2019 {
    $sqlver=2019
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
}


function InstallPcm {
    $uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}

function InstallPcPos {
    $uri = "https://pobierz.insoft.com.pl/PC-POS7/Wersja_aktualna/pcpos7_x64_install.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}

function InstallWapro {
    $uri = "https://storage.wapro.pl/storage/InstalatorWAPRO/InstalatorWAPRO.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}


# Funkcja do obsługi przycisku "Wykonaj"
function ExecuteSelectedCommands {

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $ProgressPreference = 'SilentlyContinue'

    $installPath = $installPathTextBox.Text
    $logFile = $installPath + "\setup.log"
    
    New-Item -Path $installPath -ItemType Directory -Force | Out-Null

    Write-Log "-----------------------------------------"
    # Pętla po wszystkich checkboxach, aby wykonać zaznaczone polecenia
    foreach ($checkbox in $checkboxes) {
        if ($checkbox.IsChecked) {
            $checkbox.IsChecked = $false
            # $checkbox.IsEnabled = $false
            $checkbox.Background = "#cccccc"
            $index = $checkbox.Tag
            $commands = $json[$index].polecenia
            Write-Log $json[$index].nazwa + " : start"
            
            foreach ($command in $commands) {
                Invoke-Expression $command
                Write-Log "- $command"
            }
        }
    }
    Write-Log "-----------------------------------------"
    Write-Log "ZAKOŃCZONO"
    Write-Log "-----------------------------------------"
}

# Konwersja treści JSON na obiekt PowerShell
$json = ConvertFrom-Json $jsonContent

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" x:Name="runApp"
        Title="PAJ-COMP - Instalator aplikacji" Height="650" Width="750"
        MinWidth="750" MinHeight="660" MaxWidth="900" MaxHeight="750" Icon="https://paj24.pl/favicon.ico"  WindowStyle="ThreeDBorderWindow" WindowStartupLocation="CenterScreen" ResizeMode="CanResizeWithGrip"
        >
    <StackPanel x:Name="stackPanel"  Orientation="Vertical" MinWidth="10">
        <Image x:Name="logo" Height="70" Source="https://paj24.pl/img/Pajcomp_green_slogan.png" HorizontalAlignment="Left"/>

        <TextBox Text="💾 - Pobiera instalator najnowszej wersji i go uruchamia&#x0a;📦 - Pobiera plik zip i jedynie rozpakowuje go w wybranym folderze&#x0a;😎 - Dodatkowe ustawienia aplikacji (info w opisie)&#x0a;🛠️ - Zmienia ustawienia systemu (!!)&#x0a;☠️ - Wymaga wyłączenia antywirusa (!!)&#x0a;" Name="textbox" Margin="10,0,10,0" TextWrapping="Wrap"  VerticalScrollBarVisibility="Auto" Height="100" MinHeight="100" MaxHeight="100" FontFamily="Consolas" FontSize="14" Focusable="False" IsTabStop="False" Padding="5,5,5,5"  AcceptsReturn="True" />
        <Grid Height="50">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="8*"/>
            </Grid.ColumnDefinitions>
            <TextBox x:Name="installPathTextBox" TextWrapping="Wrap" Text="$installPath" Margin="10,24,0,6" FontFamily="Consolas" Background="Yellow" FontWeight="Bold" FontSize="14" Padding="0,0,0,0"/>
            <Button Name="executeButton" Content="Zainstaluj wybrane programy/wykonaj wybrane akcje" Margin="10,4,10,6" Grid.Column="1" FontWeight="Bold" UseLayoutRounding="False"/>
            <Label Content="Katalog dla aplikacji z plików ZIP 📦:" HorizontalAlignment="Left" Margin="10,-1,0,0" VerticalAlignment="Top" Width="240"/>
        </Grid>
        <Grid Name="checkboxGrid" Margin="10,10,10,10" />

    </StackPanel>
</Window>
"@

$reader=(New-Object System.Xml.XmlNodeReader $XAML)
$Window=[Windows.Markup.XamlReader]::Load( $reader )

$checkboxGrid = $window.FindName("checkboxGrid")

# Generowanie checkboxów dla każdego zestawu poleceń
$checkboxes = @()

# Oblicz liczbę wierszy i kolumn na podstawie liczby checkboxów
$numberOfRows = [math]::Ceiling($json.Count / 3)
$numberOfColumns = 3

# Dodajemy kolumny do siatki
for ($i = 0; $i -lt $numberOfColumns; $i++) {
    $columnDefinition = New-Object System.Windows.Controls.ColumnDefinition
    $columnDefinition.MinWidth = 200
    $checkboxGrid.ColumnDefinitions.Add($columnDefinition)
}

# Dodajemy wiersze do siatki
for ($i = 0; $i -lt $numberOfRows; $i++) {
    $rowDefinition = New-Object System.Windows.Controls.RowDefinition
    $rowDefinition.Height = 25
    $checkboxGrid.RowDefinitions.Add($rowDefinition)
}

for ($row = 0; $row -lt $numberOfRows; $row++) {
    for ($col = 0; $col -lt $numberOfColumns; $col++) {
        $index = $row + $col * $numberOfRows
        if ($index -lt $json.Count) {
            if($json[$index].polecenia) {
                 $checkbox = New-Object System.Windows.Controls.CheckBox
                $checkbox.Content = $json[$index].nazwa
                $checkbox.Tag = $index
                $checkbox.IsChecked = $false

                if( $json[$index].opis ) {
                    $tooltip = New-Object System.Windows.Controls.ToolTip
                    $tooltip.Content = $json[$index].opis
                    $checkbox.ToolTip = $tooltip
                }
                $checkboxes += $checkbox
                $checkbox.SetValue([System.Windows.Controls.Grid]::ColumnProperty, $col)
                $checkbox.SetValue([System.Windows.Controls.Grid]::RowProperty, $row)
                $checkboxGrid.Children.Add($checkbox) | Out-Null
            } else {
                # Utwórz nagłówek
                $label = New-Object System.Windows.Controls.Label
                $label.Content = $json[$index].nazwa
                $label.FontSize = 14
                $label.FontWeight = "Bold"
                $label.Margin = "-5,-6,0,0"
                $label.SetValue([System.Windows.Controls.Grid]::ColumnProperty, $col)
                $label.SetValue([System.Windows.Controls.Grid]::RowProperty, $row)
                $checkboxGrid.Children.Add($label) | Out-Null
            }
        }
    }
}


# Pobierz referencje do elementów interfejsu użytkownika
$textbox = $Window.FindName("textbox")
$installPathTextBox = $Window.FindName("installPathTextBox")
$executeButton = $Window.FindName("executeButton")

$executeButton.Add_Click({ ExecuteSelectedCommands })

# Uruchomienie formularza
$Window.ShowDialog() | Out-Null

