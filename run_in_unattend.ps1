$installPath = "C:\Serwis"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'



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

InstallNotepad3

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
    
    
    # CreateDesktopShortcut -ShortcutName "Double Commander" -File "C:\Program Files\Double Commander\doublecmd.exe"
}

InstallDoubleCmd

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

InstallTeamViewerHost

function InstallPosnetOps {
    New-Item -Path "$installPath\Posnet-OPS\" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/mieszkou/programy/raw/master/Posnet-OPS/posnet-ops-setup-11.44.89.exe" -OutFile "$installPath\posnet-ops-setup-11.30.80.exe" 
    # Start-Process -Wait -FilePath "$installPath\posnet-ops-setup-11.44.89.exe" -ArgumentList "/D=$installPath\Posnet-OPS"
}

InstallPosnetOps

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

InstallDrivers

function InstallAdminSql {
    $uri = "https://pajcomp.pl/pub/SQL-tools/AdminSQL.zip"
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
       
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    Expand-Archive $installerPath -DestinationPath "$installPath\AdminSQL" -Force
    # CreateDesktopShortcut -ShortcutName "AdminSQL" -File "$installPath\AdminSQL\AdminSQL.exe"
    Remove-Item $installerPath 
}

InstallAdminSql

function InstallHeidiSql {
    $uri = "https://www.heidisql.com" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.heidisql.com/download.php' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/installers/*") -and ($_.href -like "*_Setup.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/ALLUSERS /silent" -Verb RunAs -Wait
    Remove-Item $installerPath
}

InstallHeidiSql

function InstallSql2022 {
    $sqlver=2022
    New-Item -Path "$($env:TEMP)\sql$($sqlver)" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://pajcomp.pl/pub/MSSQL/sql$($sqlver)/SQLEXPR_x64_ENU.exe" -OutFile "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe"
    Start-Process -Wait -FilePath "$($env:TEMP)\sql$($sqlver)\SQLEXPR_x64_ENU.exe" -ArgumentList "/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=""install"" /FEATURES=SQL /INSTANCENAME=SQL$($sqlver) /SECURITYMODE=SQL /SAPWD=Wapro3000 /TCPENABLED=1"
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name TcpDynamicPorts -Value ''
    Set-ItemProperty -Path "HKLM:\software\microsoft\microsoft sql server\mssql16.SQL$($sqlver)\mssqlserver\supersocketnetlib\tcp\ipall" -Name tcpport -Value "5$($sqlver)"
    New-NetFirewallRule -DisplayName "SQL$($sqlver)" -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort "5$($sqlver)"
    net stop MSSQL`$SQL$sqlver
    net start MSSQL`$SQL$sqlver
}

# InstallSql2022

function InstallPcm {
    $uri = "https://pobierz.insoft.com.pl/PC-Market7/Wersja_aktualna/InstallPCM_x64.exe"
    $installerPath = Join-Path $installPath (Split-Path $uri -Leaf)
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath
    Start-Process -FilePath $installerPath -Verb RunAs -Wait -ArgumentList "--mode unattended --unattendedmodeui minimalWithDialogs --installer-language pl --db 0  --template 0 --killall 1 --enable-components installPcm,AktualizacjaShoper"
    # Remove-Item $installerPath    
}

# InstallPcm

# Poprawski z Sophia Script

