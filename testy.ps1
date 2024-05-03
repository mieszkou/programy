$installPath = "C:\Serwis"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

function InstallDrivers {
    $uri = "https://www.pajcomp.pl/pub/?zip=Sterowniki"
    $installerPath = Join-Path $env:TEMP "Sterowniki.zip"
    $destinationPath = "$installPath\Sterowniki\"

    Invoke-WebRequest $uri -OutFile $installerPath
    
    New-Item -Path $destinationPath -ItemType Directory -Force | Out-Null
    Expand-Archive $installerPath -DestinationPath $destinationPath
    Remove-Item $installerPath

# Pobranie listy plików zip
$plikiZip = Get-ChildItem -Path $destinationPath -File -Recurse | Where-Object { ($_.Name -like "*.zip") -OR ( $_.Name -like "*.exe") }

# Dla każdego pliku zip
foreach ($plik in $plikiZip) {
    try {
        $nazwaKatalogu = $plik.BaseName
        Expand-Archive -Path $plik.FullName -DestinationPath "$($plik.DirectoryName)\$nazwaKatalogu" -Force
    } catch {
        
    }
    
}

}


