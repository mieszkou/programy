# Winget

Instalacja Winget 

```
$progressPreference = 'silentlyContinue'
$latestWingetMsixBundleUri = $(Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest).assets.browser_download_url | Where-Object {$_.EndsWith(".msixbundle")}
$latestWingetMsixBundle = $latestWingetMsixBundleUri.Split("/")[-1]
Write-Information "Downloading winget to artifacts directory..."
Invoke-WebRequest -Uri $latestWingetMsixBundleUri -OutFile "./$latestWingetMsixBundle"
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage $latestWingetMsixBundle
```

# Double Commander

Polecenia wykonaj w oknie PowerShell uruchomionym z uprawnieniami administratora.

```
winget install notepad3 --accept-package-agreements
winget install doublecmd --accept-package-agreements
New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "$($env:APPDATA)\doublecmd\doublecmd.xml"

# programy biurowe
winget install libreoffice --accept-package-agreements
winget install foxitpdfreader --accept-package-agreements
winget install 7zip.7zip --accept-package-agreements

# sql
# AdminSQL

winget install heidisql.heidisql --accept-package-agreements

# przegladarki
winget install brave.brave --accept-package-agreements
winget install Opera.opera --accept-package-agreements
winget install Google.Chrome --accept-package-agreements
winget install vivalditechnologies.vivaldi --accept-package-agreements

# programy graficzne
winget install Icons8.Lunacy --accept-package-agreements
winget install Inkscape.Inkscape --accept-package-agreements
winget install KDE.Krita --accept-package-agreements
```

