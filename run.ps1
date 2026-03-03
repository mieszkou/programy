$version = "1.0.1.20260303"
# 0.x.x - zmiany działania aplikacji, dodanie nowych funkcji
# x.0.x - zmiany w interfejsie, poprawki błędów
# x.x.0 - dodawanie nowych aplikacji, zmiany kosmetyczne
# ----
# 1.0.1 - pierwsze wydanie z oznaczeniem wersji, poprawki dla HeidiSQL
# 1.0.1.20260227 - aktualizacja linków do instalatorów, dodanie DBeaver
# 1.0.1.20260303 - aktualizacja linków do instalatorów, dodanie SQLiteStudio

$installPath = "C:\Serwis"

$jsonContent = @"
[  

    { "nazwa": "Diagnostyczne" },
    { "nazwa": "💾 CPU-Z 2.10", "polecenia": [ "InstallCpuZ" ] },
    { "nazwa": "💾 Crystal DiskInfo 9.3.2", "polecenia": [ "InstallCrystalDiskInfo" ] },
    { "nazwa": "💾 Crystal DiskMark", "polecenia": [ "InstallCrystalDiskMark" ] },
    { "nazwa": "📦 Disk Genius", "polecenia": [ "InstallDiskGenius" ] },
    { "nazwa": "💾 HD Sentinel", "polecenia": [ "InstallHDSentinel" ] },
    { "nazwa": "💾 hwiNFO", "polecenia": [ "InstallHwinfo" ] },
    { "nazwa": "💾 HWMonitor PRO", "polecenia": [ "InstallHwmonitor" ] },
    { "nazwa": "📦 miniTool Partition Wizard", "polecenia": [ "InstallMiniTool" ] },
    { "nazwa": "💾 OCCT", "polecenia": [ "InstallOcct" ] },
    { "nazwa": "💾 SSD-Z", "polecenia": [ "InstallSsdZ" ] },
    { "nazwa": "💾 Throttle Stop", "polecenia": [ "InstallThrottleStop" ] },


    { "nazwa": "Podstawowe" },
    { "nazwa": "📦😎 Total Commander",                 "polecenia": [ "InstallTotalCommander" ] },
    { "nazwa": "📦 Total Commander (tylko exe)",       "polecenia": [ "InstallTotalCommanderExe" ] },
    { "nazwa": "💾 Notepad 3",                         "polecenia": [ "InstallNotepad3" ] },
    { "nazwa": "💾😎 Double Commander",                "polecenia": [ "InstallDoubleCmd" ] },
    { "nazwa": "💾 7-zip",                             "polecenia": [ "Install7Zip" ] },
    { "nazwa": "💾 LibreOffice.org",                   "polecenia": [ "InstallLibreOffice" ]},
     { "nazwa": "Systemowe" },
    { "nazwa": "💾 PowerShell 7",                      "polecenia": [ "InstallPowerShell7" ] },

    { "nazwa": "Zdalna pomoc" },
    { "nazwa": "📦 AnyDesk (kopiuj na pulpit)",         "polecenia": [ "InstallAnyDesk" ] },
    { "nazwa": "📦 TeamViewerQS (kopiuj na pulpit)",    "polecenia": [ "InstallTeamViewerQS" ] },
    { "nazwa": "💾😎 TeamViewer Host (instaluj)",      "polecenia": [ "InstallTeamViewerHost" ] },
    { "nazwa": "Narzędzia SQL" },
    { "nazwa": "📦 AdminSQL",                          "polecenia": [ "InstallAdminSql" ] },
    { "nazwa": "💾 HeidiSQL",                          "polecenia": [ "InstallHeidiSql" ] },
    { "nazwa": "📦 SQLiteStudio",                      "polecenia": [ "InstallSQLiteStudio" ] },
    { "nazwa": "📦 DBeaver",                          "polecenia": [ "InstallDBeaver" ] },
    { "nazwa": "💾 SQL Server Management Studio",      "polecenia": [ "InstallSSMS" ] },
    { "nazwa": "💾 SQL Backup Master",                 "polecenia": [ "InstallSQLBackupMaster" ] },
     { "nazwa": "SysInternals" },
    { "nazwa": "📦😎 Bginfo",                          "polecenia": [ "InstallBginfo" ] },
    { "nazwa": "📦 Autologon",                         "polecenia": [ "InstallSysInternals -fileName 'Autologon'" ] },
    { "nazwa": "📦 Autoruns",                          "polecenia": [ "InstallSysInternals -fileName 'autoruns'" ] },
    { "nazwa": "📦 Disk2vhd",                          "polecenia": [ "InstallDisk2vhd" ] },
    { "nazwa": "📦 Process Explorer",                  "polecenia": [ "InstallSysInternals -fileName 'procexp'" ] },
    { "nazwa": "📦 Process Monitor",                   "polecenia": [ "InstallSysInternals -fileName 'Procmon'" ] },
    { "nazwa": "📦 Tcpview",                           "polecenia": [ "InstallSysInternals -fileName 'Tcpview'" ] },
    { "nazwa": "📦 ZoomIt",                            "polecenia": [ "InstallSysInternals -fileName 'ZoomIt'" ] },
    
    { "nazwa": " " },    
     { "nazwa": "Nirsoft" },
    { "nazwa": "📦 DHCPLogView",                       "polecenia": [ "InstallDHCPLogView " ] },
    { "nazwa": "📦 LANIPScanner",                      "polecenia": [ "InstallLANIPScanner" ] },
    { "nazwa": "📦 Mail PassView (AV!) ☠️",            "polecenia": [ "InstallMailPassView" ] },
    { "nazwa": "📦 Network Password Recovery (AV!) ☠️","polecenia": [ "InstallNetworkPasswordRecovery" ] },
    { "nazwa": "📦 NirCmd",                             "polecenia": [ "InstallNirCmd" ] },
    { "nazwa": "📦 ProcessTCPSummary ",                 "polecenia": [ "InstallProcessTCPSummary " ] },
    { "nazwa": "📦 TaskSchedulerView ",                 "polecenia": [ "InstallTaskSchedulerView " ] },
    { "nazwa": "📦 WinUpdatesView",                     "polecenia": [ "InstallWinUpdatesView" ] },
    { "nazwa": "📦 WirelessKeyView ☠️",                 "polecenia": [ "InstallWirelessKeyView" ] },
    { "nazwa": "📦 WirelessNetView",                    "polecenia": [ "InstallWirelessNetView" ] },
    { "nazwa": "📦 WirelessNetworkWatcher (Netscan)",   "polecenia": [ "InstallWirelessNetworkWatcher" ] },


    

    { "nazwa": "Do urządzeń fiskalnych" },
    { "nazwa": "📦 Posnet NPS",                        "polecenia": [ "InstallPosnetNps" ] },
    { "nazwa": "💾 Posnet OPS",                        "polecenia": [ "InstallPosnetOps" ] },
    { "nazwa": "📦 Elzab Eureka",                      "polecenia": [ "InstallElzabEureka" ] },
    { "nazwa": "📦 Elzab Stampa",                      "polecenia": [ "InstallElzabStampa" ] },
    { "nazwa": "📦 Elzab - programy  komunikacyjne",   "polecenia": [ "InstallElzabWinexe" ] },
    { "nazwa": "📦 Sterowniki do urządzeń",            "polecenia": [ "InstallDrivers" ], "opis": "Wszystkie sterowniki z https://pajcomp.pl/pub/?dir=Sterowniki" },

    { "nazwa": "Silnik bazy danych SQL" },
    { "nazwa": "💾😎🛠️ MS SQL 2025 Express",               "polecenia": [ "InstallSql2025" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2025\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52025`\n- Otwarcie tego portu w firewall-u windows (!!)." },
 
    { "nazwa": "💾😎🛠️ MS SQL 2022 Express",               "polecenia": [ "InstallSql2022" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2022\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52022`\n- Otwarcie tego portu w firewall-u windows (!!)." },
    
    { "nazwa": "💾😎🛠️ MS SQL 2019 Express",               "polecenia": [ "InstallSql2019" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2019\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52019`\n- Otwarcie tego portu w firewall-u windows (!!)." },

    { "nazwa": "💾😎🛠️ MS SQL 2017 Express",               "polecenia": [ "InstallSql2017" ], 
    "opis": "Instalacja SQL Server Express z włączonym TCP, logowaniem SQL\n- Instancja .\\SQL2017\n- Hasło sa to `Wapro3000`\n- Port TCP jest ustawiany na `52017`\n- Otwarcie tego portu w firewall-u windows (!!)." },
    
    { "nazwa": "Programy" },
    { "nazwa": "💾 Insoft PCM", "polecenia": [ "InstallPcm" ] },
    { "nazwa": "💾 Insoft PcKSeF (usługa)", "polecenia": [ "InstallPcKSeF" ] },
    { "nazwa": "💾 Insoft PC-POS", "polecenia": [ "InstallPcPos" ] },
    { "nazwa": "💾 Insoft SCServer", "polecenia": [ "InstallScserver" ] },
    { "nazwa": "💾 Insoft Impex", "polecenia": [ "InstallImpex" ] },
    { "nazwa": "💾 WAPRO (wszystkie, aktualizacja)", "polecenia": [ "InstallWapro" ] },

    { "nazwa": "Narzędzia" },
    { "nazwa": "📦 OpenVPN Community (klient)", "polecenia": [ "InstallOpenVPN" ] },
    { "nazwa": "📦 WireGuard (klient)", "polecenia": [ "InstallWireGuard" ] },
    { "nazwa": "💾 Netscan", "polecenia": [ "InstallNetscan" ] },
    { "nazwa": "💾 Putty", "polecenia": [ "InstallPutty" ] },
    { "nazwa": "💾 Winbox", "polecenia": [ "InstallWinbox" ] },
    { "nazwa": "📦😎 Key-n-Stroke", "polecenia": [ "InstallKeyNStroke" ] },
    
    { "nazwa": "Pajcomp/Specjalne" },
    { "nazwa": "☠️ Uruchom zdefiniowane polecenia PS", "polecenia": [ "RunPSFromPajcomp" ] }
    ]
"@

# Funkcja do pobierania pliku z internetu z paskiem postępu
# chatgpt 20250219

function Get-File {
    param (
        [Alias("Url", "Uri", "Link", "Address")]
        [string]$Source,

        [Alias("OutFile", "Path", "Destination")]
        [string]$ParOutFile,

        [Alias("Headers")]
        [hashtable]$CustomHeaders
    )

    # Pobranie nazwy pliku z URL
    $fileName = [System.IO.Path]::GetFileName($Source)

    # Jeśli OutFile nie jest podane, zapisujemy do domyślnego folderu Pobrane
    if (-not $ParOutFile) {
        $ParOutFile = "$env:USERPROFILE\Downloads\$fileName"
    }

    # Sprawdzanie wersji PowerShella
    $psVersion = $PSVersionTable.PSVersion.Major
    if ($psVersion -lt 6) {
        Write-Log "⚠️ Stary PowerShell wykryty (v$psVersion) – używanie Invoke-WebRequest..."
        
        # Przygotowanie parametrów do Invoke-WebRequest
        $invokeParams = @{
            Uri = $Source
            OutFile = $ParOutFile
            UseBasicParsing = $true
        }

        if ($CustomHeaders) {
            $invokeParams["Headers"] = $CustomHeaders
        }
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest @invokeParams

        Write-Log "✅ Pobieranie zakończone! Plik zapisano jako: $ParOutFile"
        return
    }

    # Jeśli mamy nowszego PowerShella, używamy HttpClient
    Write-Log "🚀 Nowy PowerShell wykryty (v$psVersion) – używanie HttpClient..."

    $httpClient = [System.Net.Http.HttpClient]::new()

    # Dodawanie nagłówków jeśli podano
    if ($CustomHeaders) {
        foreach ($key in $CustomHeaders.Keys) {
            $httpClient.DefaultRequestHeaders.Add($key, $CustomHeaders[$key])
        }
    }

    # Pobieranie pliku
    $response = $httpClient.GetAsync($Source, [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead).Result

    if (-not $response.IsSuccessStatusCode) {
        Write-Error "❌ Błąd pobierania: $($response.StatusCode)"
        return
    }

    # Pobranie rozmiaru pliku
    $totalBytes = $response.Content.Headers.ContentLength
    if (-not $totalBytes) {
        Write-Log "⚠️ Brak informacji o rozmiarze pliku – pasek postępu może nie działać poprawnie."
    } else {
        Write-Log "📦 Pobieranie: $fileName | Rozmiar: $([math]::Round($totalBytes / 1MB, 2)) MB"
    }

    # Otwieranie strumienia
    $stream = $response.Content.ReadAsStreamAsync().Result
    $fileStream = [System.IO.File]::Create($ParOutFile)

    try {
        $buffer = New-Object byte[] 8192
        $totalRead = 0
        $lastReported = -1
        $startTime = Get-Date

        while (($read = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $fileStream.Write($buffer, 0, $read)
            $totalRead += $read

            # Obliczanie prędkości pobierania
            $elapsedTime = (Get-Date) - $startTime
            $speed = if ($elapsedTime.TotalSeconds -gt 0) { $totalRead / $elapsedTime.TotalSeconds } else { 0 }

            # Aktualizacja paska postępu
            if ($totalBytes -and ($percent = [math]::Round(($totalRead / $totalBytes) * 100)) -ne $lastReported) {
                $lastReported = $percent
                Write-Progress -Activity "Pobieranie: $fileName" `
                               -Status "$percent% | Pobieranie: $([math]::Round($totalRead / 1MB, 2)) MB z $([math]::Round($totalBytes / 1MB, 2)) MB | Prędkość: $([math]::Round($speed / 1KB, 2)) KB/s" `
                               -PercentComplete $percent
            }
        }
    } finally {
        $fileStream.Close()
        $stream.Close()
    }

    Write-Log "✅ Pobieranie zakończone! Plik zapisano jako: $ParOutFile"
}





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

function InstallCpuZ {
        $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/cpu-z_2.10-en.zip"

        $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
        Get-File -Url $uri -OutFile $installerPath
        Expand-Archive $installerPath -DestinationPath "$installPath\Diag\CPU-Z\" -Force
        CreateDesktopShortcut -ShortcutName "CPU-Z x64" -File "$installPath\Diag\CPU-Z\cpuz_x64.exe"
        CreateDesktopShortcut -ShortcutName "CPU-Z x32" -File "$installPath\Diag\CPU-Z\cpuz_x32.exe"
        Remove-Item $installerPath 
}

function InstallCrystalDiskInfo {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/crystalDiskInfo_9_3_2.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\DiskInfo\" -Force
    CreateDesktopShortcut -ShortcutName "Crystal DiskInfo x64" -File "$installPath\Diag\DiskInfo\DiskInfo64.exe"
    CreateDesktopShortcut -ShortcutName "Crystal DiskInfo x32" -File "$installPath\Diag\DiskInfo\DiskInfo32.exe"
    Remove-Item $installerPath 
}


function InstallCrystalDiskMark {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/crystalDiskMark.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\DiskMark\" -Force
    CreateDesktopShortcut -ShortcutName "Crystal DiskMark x64" -File "$installPath\Diag\DiskMark\DiskMark64.exe"
    CreateDesktopShortcut -ShortcutName "Crystal DiskMark x32" -File "$installPath\Diag\DiskMark\DiskMark32.exe"
    Remove-Item $installerPath 
}


function InstallDiskGenius {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/diskgenius_DGEngSetup5601565.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT"
    Remove-Item $installerPath    
}

function InstallHDSentinel {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/hdsentinel_pro_portable.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\HDSentinel\" -Force
    CreateDesktopShortcut -ShortcutName "HDSentinel" -File "$installPath\Diag\HDSentinel\HDSentinel.exe"
    Remove-Item $installerPath 
}

function InstallHwinfo {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/hwiNFO_hwi_806.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\HWiNFO\" -Force
    CreateDesktopShortcut -ShortcutName "HWiNFO x64" -File "$installPath\Diag\HWiNFO\HWiNFO64.exe"
    CreateDesktopShortcut -ShortcutName "HWiNFO x32" -File "$installPath\Diag\HWiNFO\HWiNFO32.exe"
    Remove-Item $installerPath 
}

function InstallHwmonitor {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/hwmonitor-pro_1.53.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\HWMonitorPro\" -Force
    CreateDesktopShortcut -ShortcutName "HWMonitorPro x64" -File "$installPath\Diag\HWMonitorPro\HWMonitorPro_x64.exe"
    CreateDesktopShortcut -ShortcutName "HWMonitorPro x32" -File "$installPath\Diag\HWMonitorPro\HWMonitorPro_x32.exe"
    Remove-Item $installerPath 
}

function InstallMiniTool {
    # instalator uruchamia się bez -Wait i nie jest kasowany
    # po instalacji uruchamia kilka procesów i zatrzymuje instalację kolejnych aplikacji

    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/miniTool_Partition_Wizard_pw-free-online.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -ArgumentList "/SILENT /SP-"
    # Remove-Item $installerPath
}

function InstallOcct {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/occt.exe"

    $installerPath = Join-Path "$installPath\Diag\OCCT\" (Split-Path $uri -Leaf)
    New-Item -Path "$installPath\Diag\OCCT\" -ItemType Directory -Force | Out-Null
    Get-File -Url $uri -OutFile $installerPath
    CreateDesktopShortcut -ShortcutName "OCCT" -File "$installPath\Diag\OCCT\occt.exe"
}


function InstallSsdZ {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/ssd-z_16.09.09wip.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\SSD-Z\" -Force
    CreateDesktopShortcut -ShortcutName "SSD-Z" -File "$installPath\Diag\SSD-Z\SSD-Z.exe"
    Remove-Item $installerPath 
}

function InstallThrottleStop {
    $uri = "https://www.pajcomp.pl/pub/!Misc/Diag/throttleStop_9.6.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Diag\ThrottleStop\" -Force
    CreateDesktopShortcut -ShortcutName "ThrottleStop" -File "$installPath\Diag\ThrottleStop\ThrottleStop.exe"
    Remove-Item $installerPath 
}


function InstallTotalCommander {
        $uri = "https://raw.githubusercontent.com/mieszkou/programy/master/totalcmd/totalcmd.zip"

        $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
        Get-File -Url $uri -OutFile $installerPath
        Expand-Archive $installerPath -DestinationPath "$installPath\Totalcmd\" -Force
        CreateDesktopShortcut -ShortcutName "Total Commander x64" -File "$installPath\Totalcmd\TotalCmd64.exe"
        Remove-Item $installerPath 
}

function InstallTotalCommanderExe {
        $uri = "https://raw.githubusercontent.com/mieszkou/programy/master/totalcmd/totalcmdexe.zip"

        $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
        Get-File -Url $uri -OutFile $installerPath
        Expand-Archive $installerPath -DestinationPath "$installPath" -Force
        CreateDesktopShortcut -ShortcutName "Total Commander x64 - tylko exe" -File "$installPath\TotalCmd64.exe"
        Remove-Item $installerPath 
}


function InstallNotepad3 {
    $uri = Invoke-RestMethod -uri https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath 
    # Wylaczam cicha instalacje - nie dziala w najnowszej wersji notepad3 - dodali instalator Opery którego nie da się pominąć automatycznie
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
    
    # Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/LOG /LANG=plk /SP-"

    New-Item -Path "$installPath\Notepad3" -ItemType Directory -Force | Out-Null
    Get-File -Url "https://raw.githubusercontent.com/mieszkou/programy/master/Notepad3/example.md" -OutFile "$installPath\Notepad3\example.md"
    Get-File -Url "https://raw.githubusercontent.com/mieszkou/programy/master/Notepad3/prezentacja.ini" -OutFile "$installPath\Notepad3\prezentacja.ini"
    
    CreateDesktopShortcut -ShortcutName "Notepad3 do prezentacji" -File "C:\Program Files\Notepad3\Notepad3.exe" -Arguments "/f $installPath\Notepad3\prezentacja.ini /t Show $installPath\Notepad3\example.md"

    Remove-Item $installerPath
}


function InstallDoubleCmd {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
    Get-File -Url $uri -OutFile "$($env:TEMP)\doublecmd.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
    New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
    try {
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/libeay32.dll" -OutFile "C:\Program Files\Double Commander\libeay32.dll"
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/ssleay32.dll" -OutFile "C:\Program Files\Double Commander\ssleay32.dll"
    }
    catch {

    }
    try {
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/libeay32.dll" -OutFile "$($env:APPDATA)\doublecmd\libeay32.dll"
        Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/ssleay32.dll" -OutFile "$($env:APPDATA)\doublecmd\ssleay32.dll"
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
    Get-File -Uri $uri -OutFile $installerPath 
    Start-Process -Wait -FilePath $installerPath -ArgumentList "/passive ProductLanguage=1045"
    Remove-Item $installerPath
}

function InstallAnyDesk {
    $uri = "https://download.anydesk.com/AnyDesk.exe"
    
    try {
        Get-File -Url $uri -OutFile "$([Environment]::GetFolderPath('CommonDesktopDirectory'))\AnyDesk.exe"
    } Catch {
        Get-File -Url $uri -OutFile "$([Environment]::GetFolderPath('DesktopDirectory'))\AnyDesk.exe"
    }
}


function InstallTeamViewerQS {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewerQS_paj24.exe"
    
    try {
        Get-File -Url $uri -OutFile "$([Environment]::GetFolderPath('CommonDesktopDirectory'))\TeamViewerQS.exe"
    } Catch {
        Get-File -Url $uri -OutFile "$([Environment]::GetFolderPath('DesktopDirectory'))\TeamViewerQS.exe"
    }
}


function InstallTeamViewerHost {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewer_Host_x64.msi"
    $uri_conf = "https://www.pajcomp.pl/pub/TeamViewer/.tv_paj.tvopt"
    
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $confPath = Join-Path $env:TEMP (Split-Path $uri_conf -Leaf)

    Get-File -Url $uri -OutFile $installerPath
    Get-File -Url $uri_conf -OutFile $confPath

    #-Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
    Start-Process -Wait -FilePath $installerPath  -ArgumentList "/passive CUSTOMCONFIGID=639wciv SETTINGSFILE=$confPath"
}


# msiexec.exe /i TeamViewer_Host_x64.msi /passive CUSTOMCONFIGID=639wciv


function Install7Zip {
    $uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like 'a/*') -and ($_.href -like '*-x64.exe')} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallPowerShell7 {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url
    Get-File -Uri $uri -OutFile "$($env:TEMP)\ps7.msi"
    Start-Process -Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
}


function InstallSysInternals {
    param( 
        [string]$fileName
    )
    New-Item -Path "$installPath\Sysinternals\" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://live.sysinternals.com/$fileName.exe" -OutFile "$installPath\Sysinternals\$fileName.exe"
    
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\$fileName.exe"
}

function InstallDisk2vhd {
    $uri = "https://download.sysinternals.com/files/Disk2vhd.zip"

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\Sysinternals\Disk2vhd\" -Force
    CreateDesktopShortcut -ShortcutName "Disk2vhd x64" -File "$installPath\Sysinternals\Disk2vhd\disk2vhd64.exe"
    CreateDesktopShortcut -ShortcutName "Disk2vhd x32" -File "$installPath\Sysinternals\Disk2vhd\disk2vhd.exe"
    Remove-Item $installerPath 
}

function InstallBginfo {
    $fileName = "Bginfo"
    InstallSysInternals -fileName $fileName
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\Bginfo.exe" -Arguments  "$installPath\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
    CreateDesktopShortcut -ShortcutName "$fileName - edytuj info" -File "$installPath\Sysinternals\bginfo.txt"

    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "$installPath\Sysinternals\bginfo.bgi"
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.txt" -OutFile "$installPath\Sysinternals\bginfo.txt"
    
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
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
    Get-File -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "$($env:LOCALAPPDATA)\Key-n-Stroke\settings.json"
    
    CreateDesktopShortcut -ShortcutName "Key-n-Stroke" -File "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
}

function InstallDHCPLogView {
    $uri = "https://www.nirsoft.net/utils/dhcplogview-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/dhcp_log_view.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "DHCPLogView" -File "$installPath\Nirsoft\DHCPLogView.exe"
    Remove-Item $installerPath
}

function InstallLANIPScanner {
    $uri = "https://www.nirsoft.net/utils/lanipscanner.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/lan_ip_scanner.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "LANIPScanner" -File "$installPath\Nirsoft\LANIPScanner.exe"
    Remove-Item $installerPath
}



function InstallNirCmd {
    $uri = "https://www.nirsoft.net/utils/nircmd-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/nircmd.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "NirCmd - pomoc" -File "$installPath\Nirsoft\NirCmd.chm"
    Remove-Item $installerPath
}



function InstallWirelessKeyView {
    $uri = "https://www.nirsoft.net/toolsdownload/wirelesskeyview.zip"
    $uri7zip = "https://www.pajcomp.pl/pub/%21Misc/7z.exe"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_key.html"}

    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $7zipPath = Join-Path $env:TEMP (Split-Path $uri7zip -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    Get-File -Url $uri7zip -OutFile $7zipPath
    
    Start-Process -Wait -FilePath $7zipPath -ArgumentList "e $installerPath -o$installPath\Nirsoft\ * -p`"WKey4567#`" -y" -NoNewWindow
    CreateDesktopShortcut -ShortcutName "WirelessKeyView" -File "$installPath\Nirsoft\WirelessKeyView.exe"
    Remove-Item $installerPath
}

function InstallWirelessNetworkWatcher {
    $uri = "https://www.nirsoft.net/utils/wnetwatcher-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_network_watcher.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "Wireless Network Watcher" -File "$installPath\Nirsoft\WNetWatcher.exe"
    Remove-Item $installerPath
}

function InstallWirelessNetView {
    $uri = "https://www.nirsoft.net/utils/wirelessnetview.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/wireless_network_view.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "WirelessNetView" -File "$installPath\Nirsoft\WirelessNetView.exe"
    Remove-Item $installerPath
}


function InstallMailPassView {
    $uri = "https://www.nirsoft.net/toolsdownload/mailpv.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/mailpv.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
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
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    Get-File -Url $uri7zip -OutFile $7zipPath
    
    Start-Process -Wait -FilePath $7zipPath -ArgumentList "e $installerPath -o$installPath\Nirsoft\ * -p`"ntps5291#`" -y" -NoNewWindow
    CreateDesktopShortcut -ShortcutName "Network Password Recovery" -File "$installPath\Nirsoft\netpass.exe"
    Remove-Item $installerPath
}

function InstallTaskSchedulerView {
    $uri = "https://www.nirsoft.net/utils/taskschedulerview-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/task_scheduler_view.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "TaskSchedulerView " -File "$installPath\Nirsoft\TaskSchedulerView.exe"
    Remove-Item $installerPath
}

function InstallProcessTCPSummary {
    $uri = "https://www.nirsoft.net/utils/processtcpsummary-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/process_tcp_summary.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "ProcessTCPSummary " -File "$installPath\Nirsoft\ProcessTCPSummary.exe"
    Remove-Item $installerPath
}

function InstallWinUpdatesView {
    $uri = "https://www.nirsoft.net/utils/winupdatesview-x64.zip"
    $nirsoftHeaders = @{"Referer"="https://www.nirsoft.net/utils/windows_updates_history_viewer.html"}
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    
    Get-File -Url $uri -OutFile $installerPath -Headers $nirsoftHeaders
    
    Expand-Archive $installerPath -DestinationPath "$installPath\Nirsoft\" -Force
    CreateDesktopShortcut -ShortcutName "WinUpdatesView" -File "$installPath\Nirsoft\WinUpdatesView.exe"
    Remove-Item $installerPath
}


function InstallPosnetNps {
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "$installPath\NPS.zip"
    Expand-Archive "$installPath\NPS.zip" -DestinationPath "$installPath" -Force
    Rename-Item "$installPath\NPS" "Posnet-NPS"

    CreateDesktopShortcut -ShortcutName "PosnetNPS" -File "$installPath\Posnet-NPS\NPS.exe"
}

function InstallPosnetOps {
    $uri = "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/Posnet_OPS_Setup_11.50.98.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Wait -ArgumentList "/S /D=$installPath\Posnet-OPS"
}

# (dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
# Program przeznaczony jest do obsługi K10/Sigma/kas ONLINE: .net 4
function InstallElzabEureka {
    New-Item -Path "$installPath\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "$installPath\eureka.zip"
    Expand-Archive "$installPath\eureka.zip" -DestinationPath "$installPath\Elzab-Eureka" -Force

    CreateDesktopShortcut -ShortcutName "ELZAB Eureka" -File "$installPath\Elzab-Eureka\bez instalatora\Eureka!.exe"
}

# dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5

function InstallElzabStampa {
    New-Item -Path "$installPath\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "$installPath\stampa.zip"
    Expand-Archive "$installPath\stampa.zip" -DestinationPath "$installPath\Elzab-Stampa" -Force

    CreateDesktopShortcut -ShortcutName "ELZAB Stampa" -File "$installPath\Elzab-Stampa\bez instalatora\Stampa.exe"
}

# Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane są w instrukcji programisty. 
# Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
# przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.
function InstallElzabWinexe {
    New-Item -Path "$installPath\Elzab-winexe\" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "$installPath\winexe.zip"
    Expand-Archive "$installPath\winexe.zip" -DestinationPath "$installPath\Elzab-winexe" -Force
}

function InstallDrivers {
    $uri = "https://www.pajcomp.pl/pub/?zip=Sterowniki"
    
    $installerPath = Join-Path $env:TEMP "Sterowniki.zip"
    $destinationPath = "$installPath\Sterowniki\"

    Get-File -Url $uri -OutFile $installerPath
    
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
    $uri = "https://pajcomp.pl/pub/SQL-tools/AdminSQL.zip"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
       
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\AdminSQL" -Force
    CreateDesktopShortcut -ShortcutName "AdminSQL" -File "$installPath\AdminSQL\AdminSQL.exe"
    Remove-Item $installerPath 
}

function InstallHeidiSql {
    $uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php?download=installer' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/ALLUSERS /silent" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallSQLiteStudio {
    $uri = Invoke-RestMethod -uri https://api.github.com/repos/pawelsalawa/sqlitestudio/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("-windows-x64.zip")} | Select-Object -ExpandProperty browser_download_url
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath 
    
    Expand-Archive $installerPath -DestinationPath "$installPath\" -Force
    CreateDesktopShortcut -ShortcutName "SQLiteStudio" -File "$installPath\SQLiteStudio\SQLiteStudio.exe"
    Remove-Item $installerPath     
}


function InstallDBeaver {
    $uri = "https://dbeaver.io/files/dbeaver-ce-latest-win32.win32.x86_64.zip"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
       
    Get-File -Url $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath" -Force
    CreateDesktopShortcut -ShortcutName "DBeaver" -File "$installPath\dbeaver\dbeaver.exe"
    Remove-Item $installerPath 
}


function InstallSSMS {
    $uri = "https://aka.ms/ssmsfullsetup"
    Get-File -Uri $uri -OutFile "$($env:TEMP)\ssmsfullsetup.exe"
    Start-Process -FilePath "$($env:TEMP)\ssmsfullsetup.exe" -Args "/passive" -Verb RunAs -Wait
}

function InstallSQLBackupMaster {
    $uri = "https://www.sqlbackupmaster.com/Content/download/sbm-setup.exe"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
}


function InstallSql2025 {
    $sqlver=2025
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /SQLSVCSTARTUPTYPE=""Automatic"" /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql17.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql17.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MSSQL`$SQL$sqlver" -Name DelayedAutoStart -Value 0
    net stop MSSQL`$SQL$sqlver
    net start MSSQL`$SQL$sqlver
}


function InstallSql2022 {
    $sqlver=2022
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /SQLSVCSTARTUPTYPE=""Automatic"" /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MSSQL`$SQL$sqlver" -Name DelayedAutoStart -Value 0
    net stop MSSQL`$SQL$sqlver
    net start MSSQL`$SQL$sqlver
}

function InstallSql2019 {
    $sqlver=2019
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
    net stop MSSQL`$SQL$sqlver
    net start MSSQL`$SQL$sqlver
}

function InstallSql2017 {
    $sqlver=2017
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Get-File -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql14.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql14.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
    net stop MSSQL`$SQL$sqlver
    net start MSSQL`$SQL$sqlver
}


function InstallPcm {
    $uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "--mode unattended --unattendedmodeui minimalWithDialogs --installer-language pl --db 0  --template 0 --killall 1 --enable-components installPcm,AktualizacjaShoper"
    # Remove-Item $installerPath    
}

function InstallPcKSeF {
    $uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/pcksef-x64.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "--installer-language pl"
    # Remove-Item $installerPath    
}


function InstallPcPos {
    $uri = "https://pobierz.insoft.com.pl/PC-POS7/Wersja_aktualna/pcpos7_x64_install.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "--mode unattended --unattendedmodeui minimalWithDialogs --enable-components nativeclient2022,POSY --installer-language pl --TYPDBINSTALL 1 --TYPDRUK SpoofFiscalPrinter"
    # Remove-Item $installerPath    
}

function InstallScserver {
    $uri = "https://pobierz.insoft.com.pl/Scserver/Wersja_aktualna/Scserver-x64.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}

function InstallImpex {
    $uri = "https://pajcomp.pl/pub/Insoft/ImpEx/ImpEx.zip"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\" -Force
    CreateDesktopShortcut -ShortcutName "ImpEx" -File "$installPath\Impex\ImpEx.exe"
    # Remove-Item $installerPath    
}





function InstallWapro {
    $uri = "https://storage.wapro.pl/storage/InstalatorWAPRO/InstalatorWAPRO.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}


function InstallNetscan {
    $uri = "https://www.pajcomp.pl/pub/!Misc/netscan.exe"
    $installerPath = "$(Join-Path $installPath (Split-Path $uri -Leaf))"
    Get-File -Uri $uri -OutFile $installerPath
    CreateDesktopShortcut -ShortcutName "Netscan" -File $installerPath
}



function InstallPutty {
    $uri = "https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
    $installerPath = "$(Join-Path $installPath (Split-Path $uri -Leaf))"
    Get-File -Uri $uri -OutFile $installerPath
    CreateDesktopShortcut -ShortcutName "Putty" -File $installerPath
}


function InstallWinbox {
    $uri = "https://download.mikrotik.com/routeros/winbox/3.41/winbox64.exe"
    $installerPath = "$(Join-Path $installPath (Split-Path $uri -Leaf))"
    Get-File -Uri $uri -OutFile $installerPath
    CreateDesktopShortcut -ShortcutName "Winbox" -File $installerPath
}

function InstallOpenVPN {
    $uri = (Invoke-WebRequest -UseBasicParsing -Uri 'https://openvpn.net/community/' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*/releases/*") -and ($_.href -like "*amd64.msi")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Get-File -Url $uri -OutFile $installerPath
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /norestart" -Verb RunAs -Wait
    Remove-Item $installerPath
}


function InstallWireGuard {
    $uri = "https://download.wireguard.com/windows-client/wireguard-installer.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Get-File -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    # Remove-Item $installerPath    
}



function RunPSFromPajcomp {
    # Pobierz stronę z linkami do plików .ps1
    $uri = "https://pajcomp.pl/pub/?dir=%21Misc/PS-Snippets"
    $response = Invoke-WebRequest -Uri $uri -UseBasicParsing
    $links = $response.Links | Where-Object { $_.href -like "*.ps1" } | Select-Object -ExpandProperty href

    if (-not $links) {
        Write-Host "Brak plików .ps1 do pobrania."
        return
    }

    # Wyświetl menu z linkami do wyboru
    $selectedIndex = 0
    $linksCount = $links.Count

    function ShowMenu {
        Clear-Host
        Write-Host "Wybierz plik .ps1 do uruchomienia:"
        for ($i = 0; $i -lt $linksCount; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host "-> $((Split-Path $links[$i] -Leaf))" -ForegroundColor Yellow  -BackgroundColor DarkBlue
            } else {
                Write-Host "   $((Split-Path $links[$i] -Leaf))"
            }
        }
    }

    ShowMenu

    # Obsługa klawiszy strzałek i entera
    while ($true) {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        switch ($key.VirtualKeyCode) {
            38 { # Strzałka w górę
                $selectedIndex = ($selectedIndex - 1) % $linksCount
                if ($selectedIndex -lt 0) { $selectedIndex = $linksCount - 1 }
                ShowMenu
            }
            40 { # Strzałka w dół
                $selectedIndex = ($selectedIndex + 1) % $linksCount
                ShowMenu
            }
            13 { # Enter
                $selectedLink = $links[$selectedIndex]
                Write-Host "Pobieranie pliku: https://pajcomp.pl/pub/$selectedLink"
                Invoke-Expression(Invoke-RestMethod -Uri "https://pajcomp.pl/pub/$selectedLink")
                return
            }
        }
    }


    # Pobierz i uruchom wybrany plik .ps1
    # $selectedLink = $links[$selectedIndex]
    # $scriptContent = Invoke-WebRequest -Uri $selectedLink -UseBasicParsing | Select-Object -ExpandProperty Content
    # Invoke-Expression $scriptContent
}


# Funkcja do obsługi przycisku "Wykonaj"
function ExecuteSelectedCommands {
    $Window.Hide()

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
            Write-Log "___________________________________"
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

    $Window.ShowDialog()
}

# Konwersja treści JSON na obiekt PowerShell
$json = ConvertFrom-Json $jsonContent

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" x:Name="runApp"
        Title="PAJ-COMP - Instalator aplikacji | $version" Height="740" Width="970"
        MinWidth="750" MinHeight="660" Icon="https://paj24.pl/favicon.ico"  WindowStyle="ThreeDBorderWindow" WindowStartupLocation="CenterScreen" ResizeMode="CanResizeWithGrip"
        >
    <StackPanel x:Name="stackPanel"  Orientation="Vertical" MinWidth="10">
        <Image x:Name="logo" Height="70" Source="https://paj24.pl/img/Pajcomp_green_slogan.png" HorizontalAlignment="Left"/>

        <TextBox Text="💾 - Pobiera instalator najnowszej wersji i go uruchamia&#x0a;📦 - Pobiera plik zip i jedynie rozpakowuje go w wybranym folderze&#x0a;😎 - Dodatkowe ustawienia aplikacji (info w opisie)&#x0a;🛠️ - Zmienia ustawienia systemu (!!)&#x0a;☠️ - Wymaga wyłączenia antywirusa (!!)&#x0a;" Name="textbox" Margin="10,0,10,0" TextWrapping="Wrap"  VerticalScrollBarVisibility="Auto" Height="30" MinHeight="20" MaxHeight="100" FontFamily="Consolas" FontSize="14" Focusable="False" IsTabStop="False" Padding="5,5,5,5"  AcceptsReturn="True" />
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
$numberOfRows = [math]::Ceiling($json.Count / 4)
$numberOfColumns = 4

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

