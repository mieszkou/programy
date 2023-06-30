# Winget

Instalacja Winget 

```
$progressPreference = 'silentlyContinue'
$latestWingetMsixBundleUri = $(Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest).assets.browser_download_url | Where-Object {$_.EndsWith(".msixbundle")}
$latestWingetMsixBundle = $latestWingetMsixBundleUri.Split("/")[-1]
Write-Information "Downloading winget to artifacts directory..."
Invoke-WebRequest -Uri $latestWingetMsixBundleUri -OutFile "./$latestWingetMsixBundle"
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri ""https://raw.githubusercontent.com/mieszkou/programy/master/WinGet/Microsoft.UI.Xaml.2.7.appx" -OutFile Microsoft.UI.Xaml.2.7.appx
Add-AppxPackage Microsoft.UI.Xaml.2.7.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage $latestWingetMsixBundle
```

# Double Commander

Polecenia wykonaj w oknie PowerShell uruchomionym z uprawnieniami administratora.

```
winget install -e --id notepad3 --accept-package-agreements

winget install -e --id doublecmd --accept-package-agreements
New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\Double Commander.lnk")
$shortcut.TargetPath = "C:\Program Files\Double Commander\doublecmd.exe"
$shortcut.Save()

# system
## BgInfo
New-Item -Path "C:\Programy\BgInfo\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile "C:\Programy\BgInfo\Bginfo.exe"
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/BgInfo/bginfo.bgi" -OutFile "C:\Programy\BgInfo\bginfo.bgi"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk")
$shortcut.Arguments = "c:\Programy\BgInfo\bginfo.bgi /timer:0 /nolicprompt"
$shortcut.TargetPath = "C:\Programy\BgInfo\Bginfo.exe"
$shortcut.Save()
Invoke-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\BgInfo.lnk"

# programy biurowe
winget install -e --id  libreoffice --accept-package-agreements
winget install -e --id  TrackerSoftware.PDF-XChangeEditor --accept-package-agreements
winget install -e --id  foxitpdfreader --accept-package-agreements
winget install -e --id  7zip.7zip --accept-package-agreements

# sql
## AdminSQL
New-Item -Path "C:\Programy\AdminSQL\" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/mieszkou/programy/raw/master/AdminSQL/AdminSQL.exe" -OutFile "C:\Programy\AdminSQL\AdminSQL.exe"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$HOME\Desktop\AdminSQL.lnk")
$shortcut.TargetPath = "C:\Programy\AdminSQL\AdminSQL.exe"
$shortcut.Save()

winget install -e --id heidisql.heidisql --accept-package-agreements
winget install -e --id Microsoft.SQLServerManagementStudio --accept-package-agreements

# zdalny dostęp
## Instalacja TeamViewer
winget install -e --id TeamViewer.TeamViewer.Host --accept-package-agreements
winget install -e --id TeamViewer.TeamViewer --accept-package-agreements

## Skroty na pulpicie


# przegladarki
winget install -e --id brave.brave --accept-package-agreements
winget install -e --id Mozilla.Firefox --accept-package-agreements
winget install -e --id Opera.opera --accept-package-agreements
winget install -e --id Google.Chrome --accept-package-agreements
winget install -e --id vivalditechnologies.vivaldi --accept-package-agreements

winget install -e --id  Mozilla.Thunderbird --accept-package-agreements


# programy graficzne
winget install -e --id  Icons8.Lunacy --accept-package-agreements
winget install -e --id  Inkscape.Inkscape --accept-package-agreements
winget install -e --id  KDE.Krita --accept-package-agreements
```

