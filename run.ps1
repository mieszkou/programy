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
    CreateDesktopShortcut("Double Commander", "C:\Program Files\Double Commander\doublecmd.exe")
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
[System.Windows.Forms.Application]::EnableVisualStyles()

# Utworzenie formularza
$form = New-Object System.Windows.Forms.Form
$form.Text = "PAJ-COMP"
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = "CenterScreen"

# This base64 string holds the bytes that make up the orange 'G' icon (just an example for a 32x32 pixel image)
$iconBase64      = 'data:image/x-icon;base64,AAABAAMAEBAAAAEAIABoBAAANgAAACAgAAABACAAKBEAAJ4EAAAwMAAAAQAgAGgmAADGFQAAKAAAABAAAAAgAAAAAQAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIxMHGSNTRzyjk4c/5BPHf+RUB3/l1ko//7+/v///////////6t0Sf+XUx7/l1Me/5dTHv+XUx7/l1Me8pZSH2SJSxvyikwc/4xNHP+NTRz/jk4c/6h1Tv////////////38/P+YVyX/llIe/5dTHv+XUx7/l1Me/5dTHv+XUx7yhkob/4hLG/+JSxv/ikwc/4xNHP+6lHb////////////t49v/klAd/5NRHf+VUh7/llIe/5dTHv+XUx7/l1Me/4RJGv+FSRv/hkob/4hLG/+JSxv/zbKe////////////2cSz/5BPHf+RUB3/klAd/5NRHf+VUh7/llIe/5dTHv+BRxr/g0ga/4RJGv+FSRv/hkob/+HSxv///////////9S9q/+ZYDT/jk4c/5BPHf+RUB3/klAd/5NRHf+VUh7/f0YZ/4BGGv+BRxr/g0ga/4RJGv/28e7///////////////////////fy7//fzb//s4dl/5BPHf+RUB3/klAd/3xEGf99RRn/f0YZ/4BGGv+OWjH////////////////////////////////////////////Jq5P/jk4c/5BPHf95Qxj/e0QZ/3xEGf99RRn/onlZ////////////+ff1/5ZfNP+vgV3/176r/////////////v7+/6BsQ/+NTRz/d0IY/3hCGP95Qxj/e0QZ/7eZgv///////////+LXzv9+RRn/hUka/4xNHP/r39b///////////+/nYP/ikwc/3RAF/92QRj/d0IY/3hCGP/Ouar////////////Htab/cj8X/3lCGP+FTSL/9O7q////////////vZyC/4hLG/9yPxf/cz8X/3RAF/92QRj/5drS/////////////v7+/+7o5P/e0sj/7+nl/////////////v7+/5pqRP+FSRv/bz0W/3A+F/9yPxf/c0AX/97SyP/69/b//////////////////////////////////////8Ookv+BRxr/g0ga/2w8Fv9uPRb/bz0W/3A+F/9yPxf/dEEZ/4hcOf+ifmL/u6CL/9PBtP/h1cz/1cS3/6V+Yf99RRn/f0YZ/4BGGv9qOxX/azsW/2w8Fv9uPRb/bz0W/3A+F/9yPxf/cz8X/3RAF/92QRj/d0IY/3hCGP95Qxj/e0QZ/3xEGf99RRn/ZzkV8mk6Ff9qOxX/azsW/2w8Fv9uPRb/bz0W/3A+F/9yPxf/cz8X/3RAF/92QRj/d0IY/3hCGP95Qxj/ekMY8mY4FGRmORTyZzkV/2k6Ff9qOxX/azsW/2w8Fv9uPRb/bz0W/3A+F/9yPxf/cz8X/3RAF/92QRj/d0EY8nhCF2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKAAAACAAAABAAAAAAQAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACNTBxKjU4czo9OHPyPThz/j08d/5BPHf+RUB3/kVAd/5JQHf+SUR3/llUi//37+v///////////////////////////8ilif+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx38l1MezpRTH0oAAAAAikwcSoxNHPyMTRz/jU0c/41OHP+OThz/j04c/49PHf+QTx3/kVAd/5FQHf+lb0X/////////////////////////////////toZh/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/JRTH0qJTBvOikwc/4tMHP+LTRz/jE0c/41NHP+NThz/jk4c/49OHP+PTx3/kE8d/7eNbf////////////////////////////////+iZzr/llIe/5ZTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1MezolLG/yJSxv/iUwb/4pMHP+LTBz/i00c/4xNHP+NTRz/jU4c/45OHP+PThz/yqyU////////////////////////////+fXy/5RSHv+UUh7/lVIe/5ZSHv+WUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx38h0ob/4dLG/+ISxv/iUsb/4lMG/+KTBz/i0wc/4tNHP+MTRz/jU0c/41OHP/ey7z////////////////////////////m18v/klEd/5NRHf+UUR3/lFIe/5VSHv+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+FShv/hkob/4dKG/+HSxv/iEsb/4lLG/+JTBv/ikwc/4tMHP+LTRz/jE0c//Hq5P///////////////////////////9K4o/+RUB3/klAd/5JRHf+TUR3/lFEd/5RSHv+VUh7/llIe/5ZTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/4RJGv+FSRv/hUob/4ZKG/+HShv/h0sb/4hLG/+JSxv/iUwb/4pMHP+SVyr///7+////////////////////////////vpl8/5BPHf+RUB3/kVAd/5JQHf+SUR3/k1Ed/5RRHf+UUh7/lVIe/5ZSHv+WUx7/l1Me/5dTHv+XUx7/g0ga/4RJGv+ESRr/hUkb/4VKG/+GShv/h0ob/4dLG/+ISxv/iUsb/6V2UP////////////////////////////////+qeVP/j04c/49PHf+QTx3/kVAd/5FQHf+SUB3/klEd/5NRHf+UUR3/lFIe/5VSHv+WUh7/llMe/5dTHv+CRxr/gkga/4NIGv+ESRr/hEka/4VJG/+FShv/hkob/4dKG/+HSxv/uZV4/////////////////////////////////5RZLP+NThz/jk4c/49OHP+PTx3/kE8d/5FQHf+RUB3/klAd/5JRHf+TUR3/lFEd/5RSHv+VUh7/llIe/4BHGv+BRxr/gkca/4JIGv+DSBr/hEka/4RJGv+FSRv/hUob/4ZKG//NtKH////////////////////////////8+vn/wqGH/66CYP+bZDj/jk4d/45OHP+PThz/j08d/5BPHf+RUB3/kVAd/5JQHf+SUR3/k1Ed/5RRHf+UUh7/gEYZ/4BGGv+ARxr/gUca/4JHGv+CSBr/g0ga/4RJGv+ESRr/hUkb/+LUyf/////////////////////////////////////////////////59fL/5dfL/8+0nv+wgl//kVIh/49PHf+QTx3/kVAd/5FQHf+SUB3/klEd/5NRHf9+RRn/fkYZ/4BGGf+ARhr/gEca/4FHGv+CRxr/gkga/4NIGv+ESRr/9/Pw///////////////////////////////////////////////////////////////////////z7Of/uI9v/49OHP+PTx3/kE8d/5FQHf+RUB3/klAd/3xFGf99RRn/fkUZ/35GGf+ARhn/gEYa/4BHGv+BRxr/gkca/5FdNP//////////////////////////////////////////////////////////////////////////////////////0rml/49PHf+PThz/j08d/5BPHf+RUB3/e0QZ/3xEGf98RRn/fUUZ/35FGf9+Rhn/gEYZ/4BGGv+ARxr/pn1d////////////////////////////////////////////////////////////////////////////////////////////xaWM/41OHP+OThz/j04c/49PHf96Qxj/ekQZ/3tEGf98RBn/fEUZ/31FGf9+RRn/fkYZ/4BGGf+7nYX////////////////////////////9/Pv/nGY9/7CDX//Foof/28Wz//jz8P/////////////////////////////////8+/r/nGU7/41NHP+NThz/jk4c/3hDGP95Qxj/ekMY/3pEGf97RBn/fEQZ/3xFGf99RRn/fkUZ/9G9rf///////////////////////////+vh2v+FSRv/iUsb/4xNHP+QTx3/l1gl/8+wmf/////////////////////////////////MsJv/i00c/4xNHP+NTRz/d0IY/3hCGP94Qxj/eUMY/3pDGP96RBn/e0QZ/3xEGf98RRn/6N7W////////////////////////////08Cx/4BGGf+DSBr/hkob/4pMG/+NThz/kVAd/+PSxP///////////////////////////+zj2/+KTBz/i0wc/4tNHP92QRj/d0IY/3dCGP94Qhj/eEMY/3lDGP96Qxj/ekQZ/35IHv/8+/r///////////////////////////+5noj/eUMY/31FGf+ARxr/hEka/4dKG/+LTBz/yqyV/////////////////////////////Pr5/4lLG/+JTBv/ikwc/3VAF/91QRj/dkEY/3dCGP93Qhj/eEIY/3hDGP95Qxj/kWRA/////////////////////////////////516Xv9zQBf/d0IY/3pDGP9+RRn/gkca/4VJGv/XwrL////////////////////////////7+vj/h0sb/4hLG/+JSxv/c0AX/3RAF/91QBf/dUEY/3ZBGP93Qhj/d0IY/3hCGP+ohGn/////////////////////////////////g1s8/208Fv9xPhf/dEAX/3hCGP97RBn/kmI7//r49////////////////////////////+vi2v+GShv/h0ob/4dLG/9yPxf/cz8X/3NAF/90QBf/dUAX/3VBGP92QRj/d0IY/7+lkv/////////////////////////////////9/f3/6eLd/9HCtv+/qZf/u6GN/8q1pf/28/D/////////////////////////////////yrCd/4VJG/+FShv/hkob/3E+F/9xPxf/cj8X/3M/F/9zQBf/dEAX/3VAF/91QRj/1sa6//////////////////////////////////////////////////////////////////////////////////////////////////38/P+XZT//hEka/4RJGv+FSRv/bz4W/3A+F/9xPhf/cT8X/3I/F/9zPxf/c0AX/3RAF//u6OP/////////////////////////////////////////////////////////////////////////////////////////////////wqWP/4JHGv+CSBr/g0ga/4RJGv9uPRb/bz0W/28+Fv9wPhf/cT4X/3E/F/9yPxf/c0AY/7mfiv/SwbT/6+Pd//79/f///////////////////////////////////////////////////////////////////////////8uzof+BSBv/gEca/4FHGv+CRxr/gkga/208Fv9tPRb/bj0W/289Fv9vPhb/cD4X/3E+F/9xPxf/cj8X/3M/F/9zQBf/eUgg/5FoR/+qinD/wquZ/9vNwv/z7uv///////////////////////////////////////Dp5P+qhmr/fkUZ/35GGf+ARhn/gEYa/4BHGv+BRxr/azwW/2w8Fv9tPBb/bT0W/249Fv9vPRb/bz4W/3A+F/9xPhf/cT8X/3I/F/9zPxf/c0AX/3RAF/91QBf/dUEY/3ZBGP+DUiz/m3RV/7KUfP/CqZb/xa6b/7mdh/+ddVb/fUcd/3xEGf98RRn/fUUZ/35FGf9+Rhn/gEYZ/4BGGv9qOxX/azsW/2s8Fv9sPBb/bTwW/209Fv9uPRb/bz0W/28+Fv9wPhf/cT4X/3E/F/9yPxf/cz8X/3NAF/90QBf/dUAX/3VBGP92QRj/d0IY/3dCGP94Qhj/eEMY/3lDGP96Qxj/ekQZ/3tEGf98RBn/fEUZ/31FGf9+RRn/fkYZ/2k6Ff9qOxX/ajsV/2s7Fv9rPBb/bDwW/208Fv9tPRb/bj0W/289Fv9vPhb/cD4X/3E+F/9xPxf/cj8X/3M/F/9zQBf/dEAX/3VAF/91QRj/dkEY/3dCGP93Qhj/eEIY/3hDGP95Qxj/ekMY/3pEGf97RBn/fEQZ/3xFGf99RRn/ZzoV/Gg6Ff9pOhX/ajsV/2o7Ff9rOxb/azwW/2w8Fv9tPBb/bT0W/249Fv9vPRb/bz4W/3A+F/9xPhf/cT8X/3I/F/9zPxf/c0AX/3RAF/91QBf/dUEY/3ZBGP93Qhj/d0IY/3hCGP94Qxj/eUMY/3pDGP96RBn/e0QZ/3tEGfxnORXOZzkV/2g5Ff9oOhX/aToV/2o7Ff9qOxX/azsW/2s8Fv9sPBb/bTwW/209Fv9uPRb/bz0W/28+Fv9wPhf/cT4X/3E/F/9yPxf/cz8X/3NAF/90QBf/dUAX/3VBGP92QRj/d0IY/3dCGP94Qhj/eEMY/3lDGP96Qxj/e0MZzmQ3FUpmORT8ZjkV/2c5Ff9oORX/aDoV/2k6Ff9qOxX/ajsV/2s7Fv9rPBb/bDwW/208Fv9tPRb/bj0W/289Fv9vPhb/cD4X/3E+F/9xPxf/cj8X/3M/F/9zQBf/dEAX/3VAF/91QRj/dkEY/3dCGP93Qhj/eEIY/3hDGPx5QRhKAAAAAGQ3FUpmOBTOZjkU/GY5Ff9nORX/aDkV/2g6Ff9pOhX/ajsV/2o7Ff9rOxb/azwW/2w8Fv9tPBb/bT0W/249Fv9vPRb/bz4W/3A+F/9xPhf/cT8X/3I/F/9zPxf/c0AX/3RAF/91QBf/dUEY/3VBGPx3QhjOeUEYSgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKAAAADAAAABgAAAAAQAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACZMzMFj1EZKY5OHZePThzjj04c/Y9PHP+PTx3/kE8d/5BPHf+RUB3/kVAd/5FQHf+SUB3/klEd/5NRHf+TUR3/lVMg//n18f///////////////////////////////////////////+zf1f+ZViP/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv2XUx3jllMel5tRHymZZjMFAAAAAJkzMwWLTBxajU0c4Y1NHP+NThz/jU4c/45OHP+OThz/j04c/49PHf+QTx3/kE8d/5FQHf+RUB3/kVAd/5JQHf+SUB3/o2s+/////////////////////////////////////////////////9rCsP+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5hTH+GWUh9amWYzBY9RGSmLTRzhi00c/4xNHP+MTRz/jU0c/41OHP+OThz/jk4c/45OHP+PTxz/j08d/5BPHf+QTx3/kVAd/5FQHf+RUB3/t41r/////////////////////////////////////////////////8Wgg/+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+YUx/hm1EfKYpMG5eKTBz/i0wc/4tNHP+LTRz/jE0c/4xNHP+NTRz/jU4c/45OHP+OThz/j04c/49PHP+PTx3/kE8d/5BPHf+RUB3/zK6X/////////////////////////////////////////////////7B+WP+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/llMel4lLG+OJSxv/iUwb/4pMHP+KTBz/i0wc/4tNHP+MTRz/jE0c/41NHP+NThz/jU4c/45OHP+OThz/j04c/49PHf+QTx3/4dDC/////////////////////////////////////////////v38/5xeLv+VUh7/lVIe/5ZSHv+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Md44hLG/2ISxv/iUsb/4lLG/+KTBv/ikwc/4pMHP+LTRz/i00c/4xNHP+MTRz/jU0c/41OHP+OThz/jk4c/45OHP+WWir/7uTc////////////////////////////////////////////8Ofg/5NRHv+UUR3/lFIe/5VSHv+VUh7/llIe/5ZSHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/YdKG/+HSxv/iEsb/4hLG/+JSxv/iUwb/4pMG/+KTBz/i0wc/4tNHP+LTRz/jE0c/4xNHP+NTRz/jU4c/45OHP+ibUT/8+zm////////////////////////////////////////////28W0/5NRHf+TUR3/lFEd/5RRHf+UUh7/lVIe/5VSHv+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/4ZKG/+GShv/h0ob/4dLG/+ISxv/iEsb/4lLG/+JSxv/iUwb/4pMHP+KTBz/i0wc/4tNHP+MTRz/jE0c/41NHP+ugl//9/Pv////////////////////////////////////////////xqOI/5JQHf+SUB3/klEd/5NRHf+TUR3/lFEd/5RSHv+VUh7/lVIe/5ZSHv+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/4VJG/+GShv/hkob/4ZKG/+HShv/h0sb/4hLG/+ISxv/iUsb/4lLG/+KTBv/ikwc/4pMHP+LTRz/i00c/4xNHP+7lnr//Pr4////////////////////////////////////////////r4Fc/5FQHf+RUB3/klAd/5JQHf+TUR3/k1Ed/5NRHf+UUR3/lFIe/5VSHv+VUh7/llIe/5ZSHv+XUx7/l1Me/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/4RJGv+FSRv/hUob/4ZKG/+GShv/h0ob/4dKG/+HSxv/iEsb/4hLG/+JSxv/iUwb/4pMG/+KTBz/i0wc/4xPH//Jq5T////////////////////////////////////////////59vT/oWo//5BPHf+RUB3/kVAd/5FQHf+SUB3/klEd/5NRHf+TUR3/lFEd/5RRHf+UUh7/lVIe/5VSHv+WUh7/llMe/5dTHv+XUx7/l1Me/5dTHv+XUx7/l1Me/4RJGv+ESRr/hEka/4VJG/+FSRv/hUob/4ZKG/+GShv/h0ob/4dLG/+ISxv/iEsb/4lLG/+JSxv/iUwb/5BVJ//WwK/////////////////////////////////////////////s4dn/m2I2/49PHf+QTx3/kE8d/5FQHf+RUB3/kVAd/5JQHf+SUB3/klEd/5NRHf+TUR3/lFEd/5RSHv+VUh7/lVIe/5ZSHv+WUh7/llMe/5dTHv+XUx7/l1Me/4NIGv+DSBr/hEka/4RJGv+ESRr/hUkb/4VJG/+GShv/hkob/4ZKG/+HShv/h0sb/4hLG/+ISxv/iUsb/5RbL//j1cn////////////////////////////////////////////fzb7/llss/45OHP+PTxz/j08d/5BPHf+QTx3/kVAd/5FQHf+RUB3/klAd/5JQHf+TUR3/k1Ed/5NRHf+UUR3/lFIe/5VSHv+VUh7/llIe/5ZSHv+XUx7/l1Me/4JIGv+CSBr/g0ga/4NIGv+ESRr/hEka/4RJGv+FSRv/hUob/4ZKG/+GShv/h0ob/4dKG/+HSxv/iEsb/5diOP/x6uT////////////////////////////////////////////Rt6T/kVQj/45OHP+OThz/j04c/49PHP+PTx3/kE8d/5BPHf+RUB3/kVAd/5FQHf+SUB3/klEd/5NRHf+TUR3/lFEd/5RRHf+UUh7/lVIe/5VSHv+WUh7/llMe/4FHGv+BRxr/gkca/4JIGv+DSBr/g0ga/4RJGv+ESRr/hEka/4VJG/+FSRv/hUob/4ZKG/+GShv/h0ob/59uSP/8+/r///////////////////////////////////////79/f/FpY3/jU4e/41NHP+NThz/jU4c/45OHP+OThz/j04c/49PHf+QTx3/kE8d/5FQHf+RUB3/kVAd/5JQHf+SUB3/klEd/5NRHf+TUR3/lFEd/5RSHv+VUh7/lVIe/4BHGv+BRxr/gUca/4FHGv+CSBr/gkga/4NIGv+DSBr/hEka/4RJGv+ESRr/hUkb/4VJG/+GShv/hkob/7KLbv/////////////////////////////////////////////+/v/07+r/4dDD/8uumP+1jGz/n2pA/49PHv+OThz/jk4c/45OHP+PTxz/j08d/5BPHf+QTx3/kVAd/5FQHf+RUB3/klAd/5JQHf+TUR3/k1Ed/5NRHf+UUR3/lFIe/4BGGf+ARhr/gEca/4FHGv+BRxr/gkca/4JIGv+CSBr/g0ga/4NIGv+ESRr/hEka/4RJGv+FSRv/hUob/8mvmv////////////////////////////////////////////////////////////////////////////r39P/k1sv/z7Se/7eNbf+hbEL/mFwv/5BRH/+PTx3/kE8d/5BPHf+RUB3/kVAd/5FQHf+SUB3/klEd/5NRHf+TUR3/lFEd/35GGf9/Rhn/gEYZ/4BGGv+ARxr/gEca/4FHGv+BRxr/gkca/4JIGv+DSBr/g0ga/4RJGv+ESRr/hEka/+HSxv/////////////////////////////////////////////////////////////////////////////////////////////////38/D/4tHF/8aljP+ibUT/kFAe/49PHf+QTx3/kE8d/5FQHf+RUB3/kVAd/5JQHf+SUB3/klEd/31FGf9+Rhn/fkYZ/39GGf+ARhn/gEYa/4BHGv+BRxr/gUca/4FHGv+CSBr/gkga/4NIGv+DSBr/hUob//j08f////////////////////////////////////////////////////////////////////////////////////////////////////////////38/P/w6OH/vpl8/45OHP+PTxz/j08d/5BPHf+QTx3/kVAd/5FQHf+RUB3/klAd/31FGf99RRn/fkUZ/35GGf9+Rhn/f0YZ/4BGGf+ARhr/gEca/4FHGv+BRxr/gkca/4JIGv+CSBr/lWI7/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////9S7qf+WWy3/j04c/49PHP+PTx3/kE8d/5BPHf+RUB3/kVAd/3xEGf98RBn/fEUZ/31FGf99RRn/fkUZ/35GGf9/Rhn/gEYZ/4BGGv+ARxr/gEca/4FHGv+BRxr/rIZo//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////z7+v/RuKT/lFgp/45OHP+OThz/j04c/49PHf+QTx3/kE8d/3tEGf97RBn/fEQZ/3xEGf99RRn/fUUZ/31FGf9+Rhn/fkYZ/39GGf+ARhn/gEYa/4BHGv+BRxr/xaqV///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////7+vj/upR2/41OHP+OThz/jk4c/45OHP+PTxz/j08d/3pDGP96RBn/e0QZ/3tEGf98RBn/fEUZ/31FGf99RRn/fkUZ/35GGf9+Rhn/f0YZ/4BGGf+ARxv/3M3A/////////////////////////////////////////////v39/6VzTv+1i2v/zK6X/+HQwv/v5d3/9O7p//v59///////////////////////////////////////////////////////9/Pw/5hfNP+NTRz/jU4c/45OHP+OThz/j04c/3lDGP95Qxj/ekMY/3pEGf97RBn/e0QZ/3xEGf98RBn/fEUZ/31FGf99RRn/fkUZ/35GGf+GUSb/7OPc////////////////////////////////////////////8Onj/4hLG/+KTBv/jU0c/49PHf+YWyv/qXVL/8CYeP/gzL3//Pr5/////////////////////////////////////////////////8+1of+MTh3/jE0c/41NHP+NThz/jU4c/3hCGP95Qxj/eUMY/3lDGP96Qxj/ekQZ/3tEGf97RBn/fEQZ/3xEGf99RRn/fUUZ/31FGf+VZkH/8evm////////////////////////////////////////////2MW2/4RJGv+HShv/iUsb/4tNHP+NThz/kE8d/5JRHv+cXi3/y6mP/////////////////////////////////////////////////+/n4P+aYzn/i00c/4xNHP+MTRz/jU0c/3dCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pDGP96RBn/e0QZ/3tEGf98RBn/fEUZ/31FGf+je1z/9vLv////////////////////////////////////////////vaCJ/4FHGv+DSBr/hUkb/4dLG/+JSxv/jE0c/45OHP+QTx3/k1Ee/97Kuv////////////////////////////////////////////fz8P+ug2L/i0wc/4tNHP+LTRz/jE0c/3dCGP93Qhj/d0IY/3hCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pEGf97RBn/e0QZ/3xEGf+ykXf/+/n4////////////////////////////////////////////oXtc/3xFGf9/RRn/gUcZ/4NIGv+FSRr/iEsb/4pMG/+MTRz/j04c/7KFYv////////////////////////////////////////////z7+f+7mHz/iUwb/4pMHP+KTBz/i0wc/3ZBGP92QRj/d0IY/3dCGP93Qhj/eEIY/3hCGP95Qxj/eUMY/3lDGP96Qxj/ekQZ/31GHP/Bp5L////+///////////////////////////////////////49vT/jGA9/3hCGP97RBn/fUUZ/39GGf+BSBr/hEga/4ZKG/+JSxv/ikwc/6Z1Tv////////////////////////////////////////////7+/v/Coor/iUsb/4lLG/+KTBv/ikwc/3VBF/91QRj/dkEY/3ZBGP93Qhj/d0IY/3dCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/4BMI//Qva3////////////////////////////////////////////o4Nr/glUx/3RAF/92QRj/eUMY/3tEGf99RRn/gEYa/4JIGv+ESRr/hkob/7SOb/////////////////////////////////////////////7+/v/Boon/iEsb/4hLG/+JSxv/iUwb/3RAF/90QBf/dUAX/3VBGP92QRj/dkEY/3dCGP93Qhj/d0IY/3hCGP94Qhj/eEMY/4VULP/f0sj////////////////////////////////////////////WyL7/eUsn/3A+Fv9yPxf/dUAX/3dCGP95Qxj/e0QY/35FGf+ARhn/hEoc/9zLvv////////////////////////////////////////////z6+f+5lnv/h0ob/4dLG/+ISxv/iEsb/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/3ZBGP92QRj/d0IY/3dCGP93Qhj/eEIY/4laNf/v6OP////////////////////////////////////////////Lu67/c0cj/2w8Fv9vPRb/cD4X/3NAF/92QRj/d0IY/3pDGP99RRn/spB1//z7+v////////////////////////////////////////////fz8P+rgWD/hkob/4ZKG/+HShv/h0sb/3I/F/9zPxf/c0AX/3RAF/90QBf/dUAX/3VBF/91QRj/dkEY/3ZBGP93Qhj/d0IY/5FlQ//9/Pv/////////////////////////////////////////////////+/n5/+LZ0f/GtKX/rZJ8/5l0WP+OZUX/jmNC/596XP/Lt6b/+vj3/////////////////////////////////////////////////+/n4f+VYTn/hUob/4ZKG/+GShv/h0ob/3E/F/9yPxf/cj8X/3M/F/9zQBf/c0AX/3RAF/90QBf/dUAX/3VBGP92QRj/dkEY/6eGa////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////9C6qf+FShz/hEka/4VJG/+FSRv/hUob/3A+F/9xPxf/cT8X/3I/F/9yPxf/cz8X/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/8GqmP//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+vj2/5RhOv+DSBr/hEka/4RJGv+ESRr/hUkb/3A+Fv9wPhf/cT4X/3E/F/9xPxf/cj8X/3I/F/9zPxf/c0AX/3RAF/90QBf/dUAX/9zPxf/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////7+vj/uZd+/4JIGv+CSBr/g0ga/4NIGv+ESRr/hEka/289Fv9vPRb/bz4W/3A+F/9wPhf/cT4X/3E/F/9yPxf/cj8X/3M/F/9zQBf/dUEZ//Dr5v////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////z7+f/MtaP/iFEn/4FHGv+BRxr/gkca/4JIGv+DSBr/g0ga/249Fv9uPRb/bz0W/289Fv9wPhb/cD4X/3A+F/9xPxf/cT8X/3I/F/9yPxf/c0AY/4pgPv+gfGD/u6GO/9bHvP/x7Oj//v7+/////////////////////////////////////////////////////////////////////////////////////////////////////////////////8u0ov+JVCr/gEYa/4BHGv+BRxr/gUca/4FHGv+CSBr/gkga/208Fv9tPRb/bj0W/249Fv9vPRb/bz4W/3A+Fv9wPhf/cT4X/3E/F/9xPxf/cj8X/3I/F/9zPxf/c0AX/3RAF/90QRj/g1Qw/555W/+4non/1MO2/+ng2f/v6OT/9PDt//r49v/+/v3///////////////////////////////////////////////////////38+//t5d//sI5z/35GGf9+Rhn/f0YZ/4BGGf+ARhr/gEca/4FHGv+BRxr/gkca/2w8Fv9sPBb/bTwW/209Fv9uPRb/bj0W/289Fv9vPRb/bz4W/3A+F/9wPhf/cT4X/3E/F/9yPxf/cj8X/3M/F/9zQBf/c0AX/3RAF/90QBf/dUAX/3pHH/+KXTr/mnNV/6uKcP+7oIz/y7en/9vNwv/r493/+ff2//////////////////79/P/w6uX/2sq+/7qdh/+SZD//fkYb/31FGf99RRn/fkUZ/35GGf9/Rhn/gEYZ/4BGGv+ARxr/gEca/2s7Fv9sPBb/bDwW/2w8Fv9tPBb/bT0W/249Fv9uPRb/bz0W/289Fv9wPhb/cD4X/3A+F/9xPxf/cT8X/3I/F/9yPxf/cz8X/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/3ZBGP93Qxr/fEkh/4JRKv+HWDP/jV88/5dtTf+eeFn/nXZX/5NnRP+LXDb/hFIq/3xGG/97RBn/fEQZ/3xEGf99RRn/fUUZ/31FGf9+Rhn/fkYZ/39GGf+ARhn/gEYa/2o7Ff9rOxb/azwW/2w8Fv9sPBb/bTwW/208Fv9tPRb/bj0W/249Fv9vPRb/bz4W/3A+Fv9wPhf/cT4X/3E/F/9xPxf/cj8X/3I/F/9zPxf/c0AX/3RAF/90QBf/dUAX/3VBF/91QRj/dkEY/3ZBGP93Qhj/d0IY/3dCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pDGP96RBn/e0QZ/3tEGf98RBn/fEUZ/31FGf99RRn/fkUZ/35GGf9+Rhn/f0YZ/2o7Ff9qOxX/ajsV/2s7Fv9rOxb/azwW/2w8Fv9sPBb/bTwW/209Fv9uPRb/bj0W/289Fv9vPRb/bz4W/3A+F/9wPhf/cT4X/3E/F/9yPxf/cj8X/3M/F/9zQBf/c0AX/3RAF/90QBf/dUAX/3VBGP92QRj/dkEY/3dCGP93Qhj/d0IY/3hCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pEGf97RBn/e0QZ/3xEGf98RBn/fEUZ/31FGf99RRn/fkUZ/2k6Ff9pOhX/ajsV/2o7Ff9qOxX/azsW/2s7Fv9sPBb/bDwW/2w8Fv9tPBb/bT0W/249Fv9uPRb/bz0W/289Fv9wPhb/cD4X/3A+F/9xPxf/cT8X/3I/F/9yPxf/cz8X/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/3ZBGP92QRj/d0IY/3dCGP93Qhj/eEIY/3hCGP95Qxj/eUMY/3lDGP96Qxj/ekQZ/3tEGf97RBn/fEQZ/3xEGf99RRn/fUUZ/2g5Ff1oOhX/aToV/2k6Ff9qOxX/ajsV/2o7Ff9rOxb/azwW/2w8Fv9sPBb/bTwW/208Fv9tPRb/bj0W/249Fv9vPRb/bz4W/3A+Fv9wPhf/cT4X/3E/F/9xPxf/cj8X/3I/F/9zPxf/c0AX/3RAF/90QBf/dUAX/3VBF/91QRj/dkEY/3ZBGP93Qhj/d0IY/3dCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pDGP96RBn/e0QZ/3tEGf98RBn/fEUZ/WY4FeNnORX/aDkV/2g6Ff9pOhX/aToV/2o7Ff9qOxX/ajsV/2s7Fv9rOxb/azwW/2w8Fv9sPBb/bTwW/209Fv9uPRb/bj0W/289Fv9vPRb/bz4W/3A+F/9wPhf/cT4X/3E/F/9yPxf/cj8X/3M/F/9zQBf/c0AX/3RAF/90QBf/dUAX/3VBGP92QRj/dkEY/3dCGP93Qhj/d0IY/3hCGP94Qhj/eEMY/3lDGP95Qxj/ekMY/3pEGf97RBn/fEUZ42U5FJdnORX/ZzkV/2c5Ff9oOhX/aDoV/2k6Ff9pOhX/ajsV/2o7Ff9qOxX/azsW/2s7Fv9sPBb/bDwW/2w8Fv9tPBb/bT0W/249Fv9uPRb/bz0W/289Fv9wPhb/cD4X/3A+F/9xPxf/cT8X/3I/F/9yPxf/cz8X/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/3ZBGP92QRj/d0IY/3dCGP93Qhj/eEIY/3hCGP95Qxj/eUMY/3lDGP96Qxj/e0IYl2o4EylmORThZjkV/2c5Ff9nORX/aDkV/2g6Ff9oOhX/aToV/2k6Ff9qOxX/ajsV/2o7Ff9rOxb/azwW/2w8Fv9sPBb/bTwW/208Fv9tPRb/bj0W/249Fv9vPRb/bz4W/3A+Fv9wPhf/cT4X/3E/F/9xPxf/cj8X/3I/F/9zPxf/c0AX/3RAF/90QBf/dUAX/3VBF/91QRj/dkEY/3ZBGP93Qhj/d0IY/3dCGP94Qhj/eEMY/3lDGP95QxjhfEQZKWYzAAVjNhRaZTgU4WY4Ff9mORX/ZjkV/2c5Ff9nORX/aDkV/2g6Ff9pOhX/aToV/2o7Ff9qOxX/ajsV/2s7Fv9rOxb/azwW/2w8Fv9sPBb/bTwW/209Fv9uPRb/bj0W/289Fv9vPRb/bz4W/3A+F/9wPhf/cT4X/3E/F/9yPxf/cj8X/3M/F/9zQBf/c0AX/3RAF/90QBf/dUAX/3VBGP92QRj/dkEY/3dCGP93Qhj/d0IY/3hCGOF3QRdaZjMABQAAAABmMwAFajgTKWU4FJdlOBTjZjgV/WY5Ff9nORX/ZzkV/2c5Ff9oOhX/aDoV/2k6Ff9pOhX/ajsV/2o7Ff9qOxX/azsW/2s7Fv9sPBb/bDwW/2w8Fv9tPBb/bT0W/249Fv9uPRb/bz0W/289Fv9wPhb/cD4X/3A+F/9xPxf/cT8X/3I/F/9yPxf/cz8X/3NAF/90QBf/dEAX/3RAF/91QRf/dUEY/3VCGP12QRjjdkIYl3xEGSlmMwAFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=='
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
$textbox.Size = New-Object System.Drawing.Size(560, 100) # Zmieniony rozmiar pola TextBox
$textbox.Multiline = $true
$textbox.Anchor = 'top,right,left'
$textbox.ScrollBars = "Vertical" # Dodane paski przewijania
$textbox.AutoScrollOffset = 1
$form.Controls.Add($textbox)

# Przycisk "Wykonaj"
$executeButton = New-Object System.Windows.Forms.Button
$executeButton.Location = New-Object System.Drawing.Point(10, 120)
$executeButton.Size = New-Object System.Drawing.Size(560, 30)
$executeButton.Anchor = 'top,right,left'
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