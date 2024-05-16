$installPath = "C:\Serwis"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

function Install {
    # https://sourceforge.net/projects/crystaldiskinfo/files/



    $DownloadUri = "https://sourceforge.net/projects/crystaldiskinfo/files/"
    $r = Invoke-WebRequest -UseBasicParsing -Uri "$DownloadUri/"

    # Wybieramy tylko linki w tagach td o klasie "pliki"
    $versions = ($r.ParsedHtml.getElementsByTagName("tr") | Where-Object { $_.class -eq "folder" }).getElementsByTagName("a").href -replace "/", ""

    $versions | Out-GridView


    # Wyświetlamy tylko linki w tagach td o klasie "pliki"
    $r.ParsedHtml.getElementsByTagName("td") | Where-Object { $_.className -eq "pliki" } | ForEach-Object { $_.getElementsByTagName("a") } | ForEach-Object { $_.href } | Out-GridView




    # $versions = ($r.Links | Where-Object { $_.href -match "(\d{2}\.\d+\.\d+\/)" }).href -replace "/", ""
    # $r.Links | Where-Object { $_.class -match "folder" } | Out-GridView
    # $Version = $versions | Sort-Object -Descending | Select-Object -First 1
    # $uri = $($DownloadUri + $Version + "/win/x86_64/") + (Invoke-WebRequest -UseBasicParsing -Uri $($DownloadUri + $Version + "/win/x86_64/") | Select-Object -ExpandProperty Links | Where-Object {($_.href -like '*_x86-64.msi')} | Select-Object -First 1 | Select-Object -ExpandProperty href)
    # $installerPath = Join-Path $env:TEMP (Split-Path $uri -Leaf)
    # Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $installerPath 
    # Start-Process -Wait -FilePath $installerPath -ArgumentList "/passive ProductLanguage=1045"
    # Remove-Item $installerPath

}

Install
