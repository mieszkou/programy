$installPath = "C:\Serwis"

$jsonContent = @"
[
    { "nazwa": "Notepad 3",                         "polecenia": [ "InstallNotepad3" ] },
    { "nazwa": "Double Commander",                  "polecenia": [ "InstallDoubleCmd" ] },
    { "nazwa": "7-zip",                             "polecenia": [ "Install7Zip" ] },
    { "nazwa": "PowerShell 7",                      "polecenia": [ "InstallPowerShell7" ] },
    { "nazwa": "Bginfo",                            "polecenia": [ "InstallBginfo" ] },
    { "nazwa": "Process Monitor",                   "polecenia": [ "InstallSysInternals -fileName 'Procmon'" ] },
    { "nazwa": "Process Explorer",                  "polecenia": [ "InstallSysInternals -fileName 'procexp'" ] },
    { "nazwa": "Autologon",                         "polecenia": [ "InstallSysInternals -fileName 'Autologon'" ] },
    { "nazwa": "Autoruns",                          "polecenia": [ "InstallSysInternals -fileName 'autoruns'" ] },
    { "nazwa": "ZoomIt",                            "polecenia": [ "InstallSysInternals -fileName 'ZoomIt'" ] },
    { "nazwa": "Key-n-Stroke",                      "polecenia": [ "InstallKeyNStroke" ] },
    { "nazwa": "Posnet NPS",                        "polecenia": [ "InstallPosnetNps" ] },
    { "nazwa": "Posnet OPS",                        "polecenia": [ "InstallPosnetOps" ] },
    { "nazwa": "Elzab Eureka",                      "polecenia": [ "InstallElzabEureka" ] },
    { "nazwa": "Elzab Stampa",                      "polecenia": [ "InstallElzabStampa" ] },
    { "nazwa": "Elzab - programy  komunikacyjne",   "polecenia": [ "InstallElzabWinexe" ] },
    { "nazwa": "AdminSQL",                          "polecenia": [ "InstallAdminSql" ] },
    { "nazwa": "HeidiSQL",                          "polecenia": [ "InstallHeidiSql" ] },
    { "nazwa": "SQL Server Management Studio",      "polecenia": [ "InstallSSMS" ] },
    { "nazwa": "MS SQL 2022 Express",               "polecenia": [ "InstallSql2022" ] },
    { "nazwa": "MS SQL 2019 Express",               "polecenia": [ "InstallSql2019" ] },
    { "nazwa": "Insoft PCM",                        "polecenia": [ "InstallPcm" ] },
    { "nazwa": "Insoft PC-POS",                     "polecenia": [ "InstallPcPos" ] }
]
"@

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
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Double Commander.lnk")
    $shortcut.TargetPath = "C:\Program Files\Double Commander\doublecmd.exe"
    $shortcut.Save()
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
    Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
    Remove-Item $installerPath
}

function InstallSSMS {
    # TODO: do poprawy 
    # https://aka.ms/ssmsfullsetup
    # 
}

# Pobieranie i instalacja SQL Server Express z włączonym TCP, logowaniem SQL, hasło sa to `Wapro3000`.
# Port TCP jest ustawiany na `520xx` gdzie xx to końcówka wersji SQL (np dla 2022 jest 52022)
# Ostatnie polecenie otwiera odpowiedni port w firewall-u windows.
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

# Utworzenie formularza
$form = New-Object System.Windows.Forms.Form
$form.Text = "Wybierz zestawy poleceń do wykonania"
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = "CenterScreen"

# Pole TextBox do wyświetlania aktualnie wykonywanego polecenia
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(10, 10)
$textbox.Size = New-Object System.Drawing.Size(580, 100) # Zmieniony rozmiar pola TextBox
$textbox.Multiline = $true
$textbox.ScrollBars = "Vertical" # Dodane paski przewijania
$textbox.AutoScrollOffset = 1
$form.Controls.Add($textbox)

# Przycisk "Wykonaj"
$executeButton = New-Object System.Windows.Forms.Button
$executeButton.Location = New-Object System.Drawing.Point(10, 120)
$executeButton.Size = New-Object System.Drawing.Size(100, 30)
$executeButton.Text = "Wykonaj"
$executeButton.Add_Click({ ExecuteSelectedCommands })
$form.Controls.Add($executeButton)

# Generowanie checkboxów dla każdego zestawu poleceń
$checkboxes = @()
for ($i=0; $i -lt $json.Count; $i++) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Location = New-Object System.Drawing.Point(10, (160 + $i*30))
    $checkbox.Size = New-Object System.Drawing.Size(300,20)
    $checkbox.Text = $json[$i].nazwa
    $checkbox.Tag = $i
    $checkbox.Checked = $false
    $checkboxes += $checkbox
    $form.Controls.Add($checkbox)
}

# Uruchomienie formularza
$form.ShowDialog() | Out-Null