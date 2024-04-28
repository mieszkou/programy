$installPath = "C:\Serwis"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$jsonContent = @"
[   
    { "nazwa": "Podstawowe" },
    { "nazwa": "Notepad 3",                         "polecenia": [ "InstallNotepad3" ] },
    { "nazwa": "Double Commander",                  "polecenia": [ "InstallDoubleCmd" ] },
    { "nazwa": "7-zip",                             "polecenia": [ "Install7Zip" ] },
    { "nazwa": "Narzędzia SQL" },
    { "nazwa": "AdminSQL",                          "polecenia": [ "InstallAdminSql" ] },
    { "nazwa": "HeidiSQL",                          "polecenia": [ "InstallHeidiSql" ] },
    { "nazwa": "SQL Server Management Studio",      "polecenia": [ "InstallSSMS" ] },
    { "nazwa": "Systemowe" },
    { "nazwa": "PowerShell 7",                      "polecenia": [ "InstallPowerShell7" ] },
    { "nazwa": "Bginfo",                            "polecenia": [ "InstallBginfo" ] },
    { "nazwa": "Process Monitor",                   "polecenia": [ "InstallSysInternals -fileName 'Procmon'" ] },
    { "nazwa": "Process Explorer",                  "polecenia": [ "InstallSysInternals -fileName 'procexp'" ] },
    { "nazwa": "Autologon",                         "polecenia": [ "InstallSysInternals -fileName 'Autologon'" ] },
    { "nazwa": "Autoruns",                          "polecenia": [ "InstallSysInternals -fileName 'autoruns'" ] },
    { "nazwa": "ZoomIt",                            "polecenia": [ "InstallSysInternals -fileName 'ZoomIt'" ] },
    { "nazwa": "Key-n-Stroke",                      "polecenia": [ "InstallKeyNStroke" ] },
    { "nazwa": "Do urządzeń fiskalnych" },
    { "nazwa": "Posnet NPS",                        "polecenia": [ "InstallPosnetNps" ] },
    { "nazwa": "Posnet OPS",                        "polecenia": [ "InstallPosnetOps" ] },
    { "nazwa": "Elzab Eureka",                      "polecenia": [ "InstallElzabEureka" ] },
    { "nazwa": "Elzab Stampa",                      "polecenia": [ "InstallElzabStampa" ] },
    { "nazwa": "Elzab - programy  komunikacyjne",   "polecenia": [ "InstallElzabWinexe" ] },
        { "nazwa": "Silnik bazy danych SQL" },
    { "nazwa": "MS SQL 2022 Express",               "polecenia": [ "InstallSql2022" ], 
    "opis": "Pobieranie i instalacja SQL Server Express z włączonym TCP, logowaniem SQL, hasło sa to `Wapro3000`. \nPort TCP jest ustawiany na `520xx` gdzie xx to końcówka wersji SQL (np dla 2022 jest 52022)\nOstatnie polecenie otwiera odpowiedni port w firewall-u windows." },
    
    { "nazwa": "MS SQL 2019 Express",               "polecenia": [ "InstallSql2019" ], 
    "opis": "Pobieranie i instalacja SQL Server Express z włączonym TCP, logowaniem SQL, hasło sa to `Wapro3000`. \nPort TCP jest ustawiany na `520xx` gdzie xx to końcówka wersji SQL (np dla 2022 jest 52022)\nOstatnie polecenie otwiera odpowiedni port w firewall-u windows." },

    { "nazwa": "Programy" },
    { "nazwa": "Insoft PCM",                        "polecenia": [ "InstallPcm" ] },
    { "nazwa": "Insoft PC-POS",                     "polecenia": [ "InstallPcPos" ] }
]
"@

function CreateDesktopShortcut {
    param (
        [string]$ShortcutName,
        [string]$File
    )
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('CommonDesktopDirectory'))\$ShortcutName.lnk")
    $shortcut.TargetPath = $File
    $shortcut.Save()
    
}

function InstallNotepad3 {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -Uri $uri -OutFile $installerPath 
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
    Remove-Item $installerPath
}


function InstallDoubleCmd {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
    Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
    New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
    CreateDesktopShortcut -ShortcutName "Double Commander" -File "C:\Program Files\Double Commander\doublecmd.exe"
}

function Install7Zip {
    $uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match 'Download')-and ($_.href -like 'a/*') -and ($_.href -like '*-x64.exe')} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallPowerShell7 {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url
    Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\ps7.msi"
    Start-Process -Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
}


function InstallSysInternals {
    param( 
        [string]$fileName
    )
    New-Item -Path "$installPath\Sysinternals\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://live.sysinternals.com/$fileName.exe" -OutFile "$installPath\Sysinternals\$fileName.exe"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\$fileName.lnk")
    $shortcut.TargetPath = "$installPath\Sysinternals\$fileName.exe"
    $shortcut.Save()
}

function InstallBginfo {
    InstallSysInternals -fileName "Bginfo" 
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "$installPath\Sysinternals\bginfo.bgi"
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.txt" -OutFile "$installPath\Sysinternals\bginfo.txt"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk")
    $shortcut.Arguments = "$installPath\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"
    $shortcut.TargetPath = "$installPath\Sysinternals\Bginfo.exe"
    $shortcut.Save()
    Invoke-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk"
}

function InstallKeyNStroke {
    New-Item -Path "$installPath\Key-n-Stroke\" -ItemType Directory -Force | Out-Null
    New-Item -Path "$($env:LOCALAPPDATA)\Key-n-Stroke" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "$($env:LOCALAPPDATA)\Key-n-Stroke\settings.json"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Key-n-Stroke.lnk")
    $shortcut.TargetPath = "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
    $shortcut.Save()    
}


function InstallPosnetNps {
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "$installPath\NPS.zip"
    Expand-Archive "$installPath\NPS.zip" -DestinationPath "$installPath"
    Rename-Item "$installPath\NPS" "Posnet-NPS"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\PosnetNPS.lnk")
    $shortcut.TargetPath = "$installPath\Posnet-NPS\NPS.exe"
    $shortcut.Save()
}

function InstallPosnetOps {
    New-Item -Path "$installPath\Posnet-OPS\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "$installPath\posnet-ops-setup-11.30.80.exe" 
    Start-Process -Wait -FilePath "$installPath\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=$installPath\Posnet-OPS"
}

# (dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
# Program przeznaczony jest do obsługi K10/Sigma/kas ONLINE: .net 4
function InstallElzabEureka {
    New-Item -Path "$installPath\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "$installPath\eureka.zip"
    Expand-Archive "$installPath\eureka.zip" -DestinationPath "$installPath\Elzab-Eureka"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Eureka.lnk")
    $shortcut.TargetPath = "$installPath\Elzab-Eureka\bez instalatora\Eureka!.exe"
    $shortcut.Save()
}

# dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obsługi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5
function InstallElzabStampa {
    New-Item -Path "$installPath\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "$installPath\stampa.zip"
    Expand-Archive "$installPath\stampa.zip" -DestinationPath "$installPath\Elzab-Stampa"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\ELZAB Stampa.lnk")
    $shortcut.TargetPath = "$installPath\Elzab-Stampa\bez instalatora\Stampa.exe"
    $shortcut.Save()
}

# Do komunikacji z kasą (lub systemem kas) służy zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane są w instrukcji programisty. 
# Funkcje komunikacyjne przyjmują i zwracają dane w formie #plików tekstowych, 
# przez co nie ma konieczności obsługi kas przez program magazynowy (lub inną aplikację) na poziomie sekwencji sterujących.
function InstallElzabWinexe {
    New-Item -Path "$installPath\Elzab-winexe\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "$installPath\winexe.zip"
    Expand-Archive "$installPath\winexe.zip" -DestinationPath "$installPath\Elzab-winexe"
}

function InstallAdminSql {
    New-Item -Path "$installPath\AdminSQL\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "$installPath\AdminSQL\AdminSQL.exe"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\AdminSQL.lnk")
    $shortcut.TargetPath = "$installPath\AdminSQL\AdminSQL.exe"
    $shortcut.Save()
}

function InstallHeidiSql {
    $uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/ALLUSERS /silent" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallSSMS {
    $uri = "https://aka.ms/ssmsfullsetup"
    Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\ssmsfullsetup.exe"
    Start-Process -FilePath "$($env:TEMP)\ssmsfullsetup.exe" -Args "/passive" -Verb RunAs -Wait
}


function InstallSql2022 {
    $sqlver=2022
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
}

function InstallSql2019 {
    $sqlver=2019
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql15.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
}


function InstallPcm {
    $uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    Remove-Item $installerPath    
}

function InstallPcPos {
    $uri = "https://pobierz.insoft.com.pl/PC-POS7/Wersja_aktualna/pcpos7_x64_install.exe"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait
    Remove-Item $installerPath    
}




# Funkcja do obsługi przycisku "Wykonaj"
function ExecuteSelectedCommands {
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $ProgressPreference = 'SilentlyContinue'
    
    New-Item -Path $installPath -ItemType Directory -Force | Out-Null

    # Pętla po wszystkich checkboxach, aby wykonać zaznaczone polecenia
    foreach ($checkbox in $checkboxes) {
        if ($checkbox.Checked) {
            $index = $checkbox.Tag
            $commands = $json[$index].polecenia
            $textbox.Text += $json[$index].nazwa + ": "
            
            foreach ($command in $commands) {
                Invoke-Expression $command
                $textbox.Text += $command + "`r`n"
                $textbox.SelectionStart = $textbox.Text.Length
                $textbox.ScrollToCaret()
            }
            $textbox.Text += "-----------------------------------------" + "`r`n"
        }
    }
}

# Konwersja treści JSON na obiekt PowerShell
$json = ConvertFrom-Json $jsonContent

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Utworzenie formularza
$form = New-Object System.Windows.Forms.Form
$form.Text = "PAJ-COMP - Instalator przydatnych aplikacji"
$form.Size = New-Object System.Drawing.Size(660,600)
$form.StartPosition = "CenterScreen"

# This base64 string holds the bytes that make up the orange 'G' icon (just an example for a 32x32 pixel image)
$iconBase64      = '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'
$iconBytes       = [Convert]::FromBase64String($iconBase64)
# initialize a Memory stream holding the bytes
$stream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$form.Icon       = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

# PowerShell versions older than 5.0 use this:
# $stream        = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
# $Form.Icon     = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

# $form.icon = "img/favicon.ico"

# Pole TextBox do wyświetlania aktualnie wykonywanego polecenia
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(10, 10)
$textbox.Size = New-Object System.Drawing.Size(620, 100) # Zmieniony rozmiar pola TextBox
$textbox.Multiline = $true
$textbox.Anchor = 'top,right,left'
$textbox.ScrollBars = "Vertical" # Dodane paski przewijania
$textbox.AutoScrollOffset = 1
$textbox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle # Pozioma linia

$form.Controls.Add($textbox)

# Przycisk "Wykonaj"
$executeButton = New-Object System.Windows.Forms.Button
$executeButton.Location = New-Object System.Drawing.Point(10, 120)
$executeButton.Size = New-Object System.Drawing.Size(620, 30)
$executeButton.Anchor = 'top,right,left'
$executeButton.Text = "Zainstaluj wybrane programy/wykonaj wybrane akcje"
$executeButton.Add_Click({ ExecuteSelectedCommands })
$form.Controls.Add($executeButton)

# Generowanie checkboxów dla każdego zestawu poleceń
$checkboxes = @()

# Oblicz liczbę wierszy i kolumn na podstawie liczby checkboxów
$numberOfRows = [math]::Ceiling($json.Count / 3)
$numberOfColumns = 3

for ($row = 0; $row -lt $numberOfRows; $row++) {
    for ($col = 0; $col -lt $numberOfColumns; $col++) {
        $index = $row + $col * $numberOfRows
        if ($index -lt $json.Count) {
            if($json[$index].polecenia) {
                $checkbox = New-Object System.Windows.Forms.CheckBox
                $checkbox.Location = New-Object System.Drawing.Point((20 + $col * 200), (180 + $row * 30))
                $checkbox.Size = New-Object System.Drawing.Size(180, 30)
                $checkbox.Text = $json[$index].nazwa
                $checkbox.Tag = $index
                $checkbox.Checked = $false

                if( $json[$index].opis ) {
                    $tooltip = New-Object System.Windows.Forms.ToolTip
                    $tooltip.SetToolTip($checkbox, $json[$index].opis)
                }
                $checkboxes += $checkbox
                $form.Controls.Add($checkbox)
            } else {
                # Utwórz nagłówek
                $label = New-Object System.Windows.Forms.Label
                $label.Text = $json[$index].nazwa
                $label.AutoSize = $true
                $label.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold) # Pogrubiona czcionka
                $label.Location = New-Object System.Drawing.Point((15 + $col * 200), (180 + $row * 30))
                $label.Size = New-Object System.Drawing.Size(180, 30)
                $form.Controls.Add($label)
            }
        }
    }
}

# Uruchomienie formularza
$form.ShowDialog() | Out-Null