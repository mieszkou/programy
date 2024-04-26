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
    }
]
"@



# Funkcja do wyświetlania aktualnego polecenia w polu TextBox
function ShowCurrentCommand {
    # $currentCommand = $textbox.Tag
    $textbox.Text = $command
}

# Funkcja do obsługi przycisku "Wykonaj"
f# Funkcja do obsługi przycisku "Wykonaj"
function ExecuteSelectedCommands {
    # Pętla po wszystkich checkboxach, aby wykonać zaznaczone polecenia
    foreach ($checkbox in $checkboxes) {
        if ($checkbox.Checked) {
            $index = $checkbox.Tag
            $commands = $json[$index].polecenia
            foreach ($command in $commands) {
                Invoke-Expression $command
                ShowCurrentCommand
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