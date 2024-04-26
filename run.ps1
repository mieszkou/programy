Add-Type -AssemblyName System.Windows.Forms
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
New-Item -Path "C:\Serwis" -ItemType Directory -Force | Out-Null

$jsonContent = @"
[
    {
        "nazwa": "Notepad 3",
        "polecenia": [
            '`$uri = Invoke-RestMethod -uri  https://api.github.com/repos/rizonesoft/Notepad3/releases/latest | Select-Object -ExpandProperty "assets" | ? { `$_.name.Contains("x64_Setup.exe")} | Select-Object -ExpandProperty browser_download_url',
            '`$installerPath = Join-Path `$env:TEMP (Split-Path `$uri -Leaf)',
            'Invoke-WebRequest -Uri `$uri -OutFile `$installerPath',
            'Start-Process -FilePath `$installerPath -Verb RunAs -Wait -ArgumentList "/SILENT /SP-"',
            'Remove-Item `$installerPath'
        ]
    },

    {
        "nazwa": "Double Commander",
        "polecenia": [
            '`$uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { `$_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url',
            'Invoke-WebRequest -Uri `$uri -OutFile "`$(`$env:TEMP)\\doublecmd.exe"',
            'Start-Process -Wait -FilePath "`$(`$env:TEMP)\\doublecmd.exe" -ArgumentList "/SILENT /SP-"',
            'New-Item -Path "`$(`$env:APPDATA)\\doublecmd" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\\Program Files\\Double Commander\\doublecmd.xml"',
            'Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "`$(`$env:APPDATA)\\doublecmd\\doublecmd.xml"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Double Commander.lnk")',
            '`$shortcut.TargetPath = "C:\\Program Files\\Double Commander\\doublecmd.exe"',
            '`$shortcut.Save()'
        ]
    },

    {
        "nazwa": "7-zip",
        "polecenia": [
            "`$uri = 'https://7-zip.org/' + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/' | Select-Object -ExpandProperty Links | Where-Object {(`$_.outerHTML -match 'Download')-and (`$_.href -like 'a/*') -and (`$_.href -like '*-x64.exe')} | Select-Object -First 1 | Select-Object -ExpandProperty href)",
            '`$installerPath = Join-Path `$env:TEMP (Split-Path `$uri -Leaf)',
            'Invoke-WebRequest `$uri -OutFile `$installerPath',
            'Start-Process -FilePath `$installerPath -Args "/S" -Verb RunAs -Wait',
            'Remove-Item `$installerPath'
        ]
    },

    {
        "nazwa": "PowerShell 7",
        "polecenia": [
            '`$uri = Invoke-RestMethod -uri  https://api.github.com/repos/PowerShell/PowerShell/releases/latest | Select-Object -ExpandProperty "assets" | ? { `$_.name.Contains("win-x64.msi")} | Select-Object -ExpandProperty browser_download_url',
            'Invoke-WebRequest -Uri `$uri -OutFile "`$(`$env:TEMP)\\ps7.msi"',
            'Start-Process -Wait -FilePath "`$(`$env:TEMP)\\ps7.msi" -ArgumentList "/qb-! REBOOT=ReallySuppress"'
        ]
    },

    {
        "nazwa": "Bginfo",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile "C:\\Programy\\Sysinternals\\Bginfo.exe"',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "C:\\Programy\\Sysinternals\\bginfo.bgi"',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.txt" -OutFile "C:\\Programy\\Sysinternals\\bginfo.txt"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$env:APPDATA\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\BgInfo.lnk")',
            '`$shortcut.Arguments = "c:\\Programy\\Sysinternals\\bginfo.bgi /timer:0 /nolicprompt"',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\Bginfo.exe"',
            '`$shortcut.Save()',
            'Invoke-Item "`$env:APPDATA\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\BgInfo.lnk"'
        ]
    },

    {
        "nazwa": "Process Monitor",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/Procmon.exe" -OutFile "C:\\Programy\\Sysinternals\\Procmon.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Procmon.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\Procmon.exe"',
            '`$shortcut.Save()'
        ]
    },

    {
        "nazwa": "Process Explorer",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/procexp.exe" -OutFile "C:\\Programy\\Sysinternals\\procexp.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Procexp.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\procexp.exe"',
            '`$shortcut.Save()'
        ]
    },
    {
        "nazwa": "Autologon",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/Autologon.exe" -OutFile "C:\\Programy\\Sysinternals\\Autologon.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Autologon.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\Autologon.exe"',
            '`$shortcut.Save()'
        ]
    },
    {
        "nazwa": "Autoruns",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/autoruns.exe" -OutFile "C:\\Programy\\Sysinternals\\autoruns.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Autoruns.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\autoruns.exe"',
            '`$shortcut.Save()'
        ]
    },
    
    {
        "nazwa": "ZoomIt",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Sysinternals\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://live.sysinternals.com/ZoomIt.exe" -OutFile "C:\\Programy\\Sysinternals\\ZoomIt.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\ZoomIt.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Sysinternals\\ZoomIt.exe"',
            '`$shortcut.Save()'
        ]
    },
    
    {
        "nazwa": "Key-n-Stroke",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Key-n-Stroke\\" -ItemType Directory -Force | Out-Null',
            'New-Item -Path "`$(`$env:LOCALAPPDATA)\\Key-n-Stroke" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Key-n-Stroke/Key-n-Stroke.exe" -OutFile "C:\\Programy\\Key-n-Stroke\\Key-n-Stroke.exe"',
            'Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/Key-n-Stroke/settings.json" -OutFile "`$(`$env:LOCALAPPDATA)\\Key-n-Stroke\\settings.json"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\Key-n-Stroke.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Key-n-Stroke\\Key-n-Stroke.exe"',
            '`$shortcut.Save()'
        ]
    },
    

    {
        "nazwa": "Posnet NPS",
        "polecenia": [
            'New-Item -Path "C:\\Programy" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-NPS/NPS.ZIP" -OutFile "C:\\Programy\\NPS.zip"',
            'Expand-Archive "C:\\Programy\\NPS.zip" -DestinationPath "C:\\Programy"',
            'Rename-Item "C:\\Programy\\NPS" "Posnet-NPS"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\PosnetNPS.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Posnet-NPS\\NPS.exe"',
            '`$shortcut.Save()'
        ]
    },
    
  
    {
        "nazwa": "Posnet OPS",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Posnet-OPS\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.30.80.exe" -OutFile "C:\\Programy\\posnet-ops-setup-11.30.80.exe"', 
            'Start-Process -Wait -FilePath "C:\\Programy\\posnet-ops-setup-11.30.80.exe" -ArgumentList "/D=c:\\Programy\\Posnet-OPS"'
        ]
    },
    {
        "nazwa": "Elzab Eureka",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Elzab-Eureka\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/eureka.zip" -OutFile "C:\\Programy\\eureka.zip"',
            'Expand-Archive "C:\\Programy\\eureka.zip" -DestinationPath "C:\\Programy\\Elzab-Eureka"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\ELZAB Eureka.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Elzab-Eureka\\bez instalatora\\Eureka!.exe"',
            '`$shortcut.Save()'
        ]
    },
    

    {
        "nazwa": "Elzab Stampa",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Elzab-Stampa\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/stampa.zip" -OutFile "C:\\Programy\\stampa.zip"',
            'Expand-Archive "C:\\Programy\\stampa.zip" -DestinationPath "C:\\Programy\\Elzab-Stampa"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\ELZAB Stampa.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\Elzab-Stampa\\bez instalatora\\Stampa.exe"',
            '`$shortcut.Save()'
        ]
    },
    
   
    {
        "nazwa": "Elzab - programy  komunikacyjne",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\Elzab-winexe\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/Elzab/winexe.zip" -OutFile "C:\\Programy\\winexe.zip"',
            'Expand-Archive "C:\\Programy\\winexe.zip" -DestinationPath "C:\\Programy\\Elzab-winexe"'
        ]
    },
  
    {
        "nazwa": "AdminSQL",
        "polecenia": [
            'New-Item -Path "C:\\Programy\\AdminSQL\\" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "C:\\Programy\\AdminSQL\\AdminSQL.exe"',
            '`$WshShell = New-Object -ComObject WScript.Shell',
            '`$shortcut = `$WshShell.CreateShortcut("`$HOME\\Desktop\\AdminSQL.lnk")',
            '`$shortcut.TargetPath = "C:\\Programy\\AdminSQL\\AdminSQL.exe"',
            '`$shortcut.Save()'
        ]
    },
   
    {
        "nazwa": "HeidiSQL",
        "polecenia": [
            '`$uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri "https://www.heidisql.com/download.php" | Select-Object -ExpandProperty Links | Where-Object {(`$_.href -like "/installers/*") -and (`$_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)',
            '`$installerPath = Join-Path `$env:TEMP (Split-Path `$uri -Leaf)',
            'Invoke-WebRequest `$uri -OutFile `$installerPath',
            'Start-Process -FilePath `$installerPath -Args "/S" -Verb RunAs -Wait',
            'Remove-Item `$installerPath'
        ]
    },
        
    {
        "nazwa": "SQL Server Management Studio",
        "polecenia": [
            'winget install -e --id Microsoft.SQLServerManagementStudio --accept-package-agreements'
        ]
    },
        
    {
        "nazwa": "MS SQL 2022 Express",
        "polecenia": [
            '`$sqlver=2022',
            'New-Item -Path "`$(`$env:TEMP)\\sql`$(`$sqlver)" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql`$(`$sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "`$(`$env:TEMP)\\sql`$(`$sqlver)\\SQLEXPR_x64_ENU.exe"',
            'Start-Process -Wait -FilePath "`$(`$env:TEMP)\\sql`$(`$sqlver)\\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL`$(`$sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"',
            'Set-ItemProperty -Path "HKLM:\\software\\microsoft\\microsoft sql server\\mssql16.SQL`$(`$sqlver)\\mssqlserver\\supersocketnetlib\\tcp\\ipall" -Name TcpDynamicPorts -Value ""',
            'Set-ItemProperty -Path "HKLM:\\software\\microsoft\\microsoft sql server\\mssql16.SQL`$(`$sqlver)\\mssqlserver\\supersocketnetlib\\tcp\\ipall" -Name tcpport -Value "5`$(`$sqlver)"',
            'New-NetFirewallRule -DisplayName "SQL`$(`$sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5`$(`$sqlver)"'
        ]
    },    
    {
        "nazwa": "MS SQL 2019 Express",
        "polecenia": [
            '`$sqlver=2019',
            'New-Item -Path "`$(`$env:TEMP)\\sql`$(`$sqlver)" -ItemType Directory -Force | Out-Null',
            'Invoke-WebRequest -Uri "https://pajcomp.pl/pub/MSSQL/sql`$(`$sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "`$(`$env:TEMP)\\sql`$(`$sqlver)\\SQLEXPR_x64_ENU.exe"',
            'Start-Process -Wait -FilePath "`$(`$env:TEMP)\\sql`$(`$sqlver)\\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL`$(`$sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"',
            'Set-ItemProperty -Path "HKLM:\\software\\microsoft\\microsoft sql server\\mssql15.SQL`$(`$sqlver)\\mssqlserver\\supersocketnetlib\\tcp\\ipall" -Name TcpDynamicPorts -Value ""',
            'Set-ItemProperty -Path "HKLM:\\software\\microsoft\\microsoft sql server\\mssql15.SQL`$(`$sqlver)\\mssqlserver\\supersocketnetlib\\tcp\\ipall" -Name tcpport -Value "5`$(`$sqlver)"',
            'New-NetFirewallRule -DisplayName "SQL`$(`$sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5`$(`$sqlver)"'
        ]
    },
    
        
    {
        "nazwa": "Insoft PCM",
        "polecenia": [
            '`$uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"',
            '`$installerPath = Join-Path `$env:TEMP (Split-Path `$uri -Leaf)',
            'Invoke-WebRequest -Uri `$uri -OutFile `$installerPath',
            'Start-Process -FilePath `$installerPath -Verb RunAs -Wait',
            'Remove-Item `$installerPath'
        ]
    }    


]
"@



# Funkcja do obsługi przycisku "Wykonaj"
function ExecuteSelectedCommands {
    # Pętla po wszystkich checkboxach, aby wykonać zaznaczone polecenia
    foreach ($checkbox in $checkboxes) {
        if ($checkbox.Checked) {
            $index = $checkbox.Tag
            $commands = $json[$index].polecenia
            $textbox.Text += "`n" + $json[$index].nazwa
            foreach ($command in $commands) {
                Invoke-Expression $command
                $textbox.Text += "`n" + $command
            }
        }
    }
}

# Konwersja treści JSON na obiekt PowerShell
$json = ConvertFrom-Json $jsonContent

# Utworzenie formularza
$form = New-Object System.Windows.Forms.Form
$form.Text = "Wybierz zestawy poleceń do wykonania"
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = "CenterScreen"

# Pole TextBox do wyświetlania aktualnie wykonywanego polecenia
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(10, 10)
$textbox.Size = New-Object System.Drawing.Size(580, 50)
$textbox.Multiline = $true
$form.Controls.Add($textbox)

# Przycisk "Wykonaj"
$executeButton = New-Object System.Windows.Forms.Button
$executeButton.Location = New-Object System.Drawing.Point(10, 70)
$executeButton.Size = New-Object System.Drawing.Size(100, 30)
$executeButton.Text = "Wykonaj"
$executeButton.Add_Click({ ExecuteSelectedCommands })
$form.Controls.Add($executeButton)

# Generowanie checkboxów dla każdego zestawu poleceń
$checkboxes = @()
for ($i=0; $i -lt $json.Count; $i++) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Location = New-Object System.Drawing.Point(10, (110 + $i*30))
    $checkbox.Size = New-Object System.Drawing.Size(300,20)
    $checkbox.Text = $json[$i].nazwa
    $checkbox.Tag = $i
    $checkbox.Checked = $false
    $checkboxes += $checkbox
    $form.Controls.Add($checkbox)
}

# Uruchomienie formularza
$form.ShowDialog() | Out-Null