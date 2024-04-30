$installPath = "C:\Serwis"

$jsonContent = @"
[   
    { "nazwa": "Podstawowe" },
    { "nazwa": "Notepad 3",                         "polecenia": [ "InstallNotepad3" ] },
    { "nazwa": "Double Commander",                  "polecenia": [ "InstallDoubleCmd" ] },
    { "nazwa": "7-zip",                             "polecenia": [ "Install7Zip" ] },
    { "nazwa": "Zdalna pomoc" },
    { "nazwa": "TeamViewer QS (paj24.pl)",          "polecenia": [ "InstallTeamViewerQS" ] },
    { "nazwa": "TeamViewer Host (paj24.pl)",        "polecenia": [ "InstallTeamViewerHost" ] },
    { "nazwa": "Narzêdzia SQL" },
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
    { "nazwa": "Do urz±dzeñ fiskalnych" },
    { "nazwa": "Posnet NPS",                        "polecenia": [ "InstallPosnetNps" ] },
    { "nazwa": "Posnet OPS",                        "polecenia": [ "InstallPosnetOps" ] },
    { "nazwa": "Elzab Eureka",                      "polecenia": [ "InstallElzabEureka" ] },
    { "nazwa": "Elzab Stampa",                      "polecenia": [ "InstallElzabStampa" ] },
    { "nazwa": "Elzab - programy  komunikacyjne",   "polecenia": [ "InstallElzabWinexe" ] },
        { "nazwa": "Silnik bazy danych SQL" },
    { "nazwa": "MS SQL 2022 Express",               "polecenia": [ "InstallSql2022" ], 
    "opis": "Pobieranie i instalacja SQL Server Express z w³±czonym TCP, logowaniem SQL, has³o sa to `Wapro3000`. \nPort TCP jest ustawiany na `520xx` gdzie xx to koñcówka wersji SQL (np dla 2022 jest 52022)\nOstatnie polecenie otwiera odpowiedni port w firewall-u windows." },
    
    { "nazwa": "MS SQL 2019 Express",               "polecenia": [ "InstallSql2019" ], 
    "opis": "Pobieranie i instalacja SQL Server Express z w³±czonym TCP, logowaniem SQL, has³o sa to `Wapro3000`. \nPort TCP jest ustawiany na `520xx` gdzie xx to koñcówka wersji SQL (np dla 2022 jest 52022)\nOstatnie polecenie otwiera odpowiedni port w firewall-u windows." },

    { "nazwa": "Programy" },
    { "nazwa": "Insoft PCM",                        "polecenia": [ "InstallPcm" ] },
    { "nazwa": "Insoft PC-POS",                     "polecenia": [ "InstallPcPos" ] }
]
"@

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
    Invoke-WebRequest -Uri $uri -OutFile $installerPath 
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"
    Remove-Item $installerPath
}


function InstallDoubleCmd {
    $uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
    Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
    New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
    try {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
    }
    catch {

    }
    try {
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
    }
    catch {
        
    }
    
    
    CreateDesktopShortcut -ShortcutName "Double Commander" -File "C:\Program Files\Double Commander\doublecmd.exe"
}

function InstallTeamViewerQS {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewerQS_paj24.exe"
    
    try {
        Invoke-WebRequest $uri -OutFile "$([Environment]::GetFolderPath('CommonDesktopDirectory'))\TeamViewerQS.exe"
    } Catch {
        Invoke-WebRequest $uri -OutFile "$([Environment]::GetFolderPath('DesktopDirectory'))\TeamViewerQS.exe"
    }
}


function InstallTeamViewerHost {
    $uri = "https://www.pajcomp.pl/pub/TeamViewer/TeamViewer_Host_x64.msi"
    $uri_conf = "https://www.pajcomp.pl/pub/TeamViewer/.tv_paj.tvopt"
    
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    $confPath = Join-Path $env:TEMP (Split-Path $uri_conf -Leaf)

    Invoke-WebRequest $uri -OutFile $installerPath
    Invoke-WebRequest $uri_conf -OutFile $confPath

    #-Wait -FilePath "$($env:TEMP)\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"
    Start-Process -Wait -FilePath $installerPath  -ArgumentList "/passive CUSTOMCONFIGID=639wciv SETTINGSFILE=$confPath"
}


# msiexec.exe /i TeamViewer_Host_x64.msi /passive CUSTOMCONFIGID=639wciv


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
    
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\$fileName.exe"
}

function InstallBginfo {
    InstallSysInternals -fileName "Bginfo" 
    CreateDesktopShortcut -ShortcutName $fileName -File "$installPath\Sysinternals\Bginfo.exe" -Arguments  "$installPath\Sysinternals\bginfo.bgi /timer:0 /nolicprompt"

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
    
    CreateDesktopShortcut -ShortcutName "Key-n-Stroke" -File "$installPath\Key-n-Stroke\Key-n-Stroke.exe"
}


function InstallPosnetNps {
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "$installPath\NPS.zip"
    Expand-Archive "$installPath\NPS.zip" -DestinationPath "$installPath"
    Rename-Item "$installPath\NPS" "Posnet-NPS"

    CreateDesktopShortcut -ShortcutName "PosnetNPS" -File "$installPath\Posnet-NPS\NPS.exe"
}

function InstallPosnetOps {
    New-Item -Path "$installPath\Posnet-OPS\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "$installPath\posnet-ops-setup-11.30.80.exe" 
    Start-Process -Wait -FilePath "$installPath\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=$installPath\Posnet-OPS"
}

# (dla systemu Windows XP/2000/VISTA/7/8/8.1/10)
# Program przeznaczony jest do obs³ugi K10/Sigma/kas ONLINE: .net 4
function InstallElzabEureka {
    New-Item -Path "$installPath\Elzab-Eureka\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "$installPath\eureka.zip"
    Expand-Archive "$installPath\eureka.zip" -DestinationPath "$installPath\Elzab-Eureka"

    CreateDesktopShortcut -ShortcutName "ELZAB Eureka" -File "$installPath\Elzab-Eureka\bez instalatora\Eureka!.exe"
}

# dla Windows XP/2000/VISTA/7/8/8.1/10
# Program przeznaczony jest do obs³ugi drukarek fiskalnych Zeta,D10,MERA, nowszych w tym ONLINE
# .net 4.5
function InstallElzabStampa {
    New-Item -Path "$installPath\Elzab-Stampa\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "$installPath\stampa.zip"
    Expand-Archive "$installPath\stampa.zip" -DestinationPath "$installPath\Elzab-Stampa"

    CreateDesktopShortcut -ShortcutName "ELZAB Stampa" -File "$installPath\Elzab-Stampa\bez instalatora\Stampa.exe"
}

# Do komunikacji z kas± (lub systemem kas) s³u¿y zestaw funkcji komunikacyjnych. 
# Funkcje komunikacyjne opisane s± w instrukcji programisty. 
# Funkcje komunikacyjne przyjmuj± i zwracaj± dane w formie #plików tekstowych, 
# przez co nie ma konieczno¶ci obs³ugi kas przez program magazynowy (lub inn± aplikacjê) na poziomie sekwencji steruj±cych.
function InstallElzabWinexe {
    New-Item -Path "$installPath\Elzab-winexe\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "$installPath\winexe.zip"
    Expand-Archive "$installPath\winexe.zip" -DestinationPath "$installPath\Elzab-winexe"
}

function InstallAdminSql {
    New-Item -Path "$installPath\AdminSQL\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "$installPath\AdminSQL\AdminSQL.exe"
    
    CreateDesktopShortcut -ShortcutName "AdminSQL" -File "$installPath\AdminSQL\AdminSQL.exe"
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




# Funkcja do obs³ugi przycisku "Wykonaj"
function ExecuteSelectedCommands {
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $ProgressPreference = 'SilentlyContinue'
    
    New-Item -Path $installPath -ItemType Directory -Force | Out-Null

    # Pêtla po wszystkich checkboxach, aby wykonaæ zaznaczone polecenia
    foreach ($checkbox in $checkboxes) {
        if ($checkbox.IsChecked) {
            $index = $checkbox.Tag
            $commands = $json[$index].polecenia
            $textbox.Text += $json[$index].nazwa + ": "
            
            foreach ($command in $commands) {
                Invoke-Expression $command
                $textbox.Text += $command + "`r`n"
                $textbox.SelectionStart = $textbox.Text.Length
                $textbox.ScrollToEnd()
            }
            $textbox.Text += "-----------------------------------------" + "`r`n"
        }
    }
    $textbox.Text += "ZAKOÑCZONO`r`n-----------------------------------------" + "`r`n"
}

# Konwersja tre¶ci JSON na obiekt PowerShell
$json = ConvertFrom-Json $jsonContent

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" x:Name="runApp"
        Title="PAJ-COMP - Instalator aplikacji" Height="650" Width="650"
        MinWidth="640" MinHeight="660" MaxWidth="900" MaxHeight="750" Icon="https://paj24.pl/favicon.ico"  WindowStyle="ThreeDBorderWindow" WindowStartupLocation="CenterScreen" ResizeMode="CanResizeWithGrip">
    <StackPanel x:Name="stackPanel"  Orientation="Vertical" MinWidth="10">
        <Image x:Name="logo" Height="70" Source="https://paj24.pl/img/Pajcomp_green_slogan.png" HorizontalAlignment="Left"/>

        <TextBox Name="textbox" Margin="10,0,10,0" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto" Height="100" MinHeight="100" MaxHeight="100" FontFamily="Consolas" FontSize="14" Text="Instalator aplikacji" Focusable="False" IsTabStop="False" Padding="5,5,5,5" />
        <Button Name="executeButton" Content="Zainstaluj wybrane programy/wykonaj wybrane akcje" Margin="10,10,10,10" Height="30"/>
        <Grid Name="checkboxGrid" Margin="10,10,10,10" />
    </StackPanel>
</Window>
"@

$reader=(New-Object System.Xml.XmlNodeReader $XAML)
$Window=[Windows.Markup.XamlReader]::Load( $reader )

$checkboxGrid = $window.FindName("checkboxGrid")

# Generowanie checkboxów dla ka¿dego zestawu poleceñ
$checkboxes = @()

# Oblicz liczbê wierszy i kolumn na podstawie liczby checkboxów
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
                # Utwórz nag³ówek
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


# Pobierz referencje do elementów interfejsu u¿ytkownika
$textbox = $Window.FindName("textbox")
$executeButton = $Window.FindName("executeButton")

$executeButton.Add_Click({ ExecuteSelectedCommands })

# Uruchomienie formularza
$Window.ShowDialog() | Out-Null
