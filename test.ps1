$file = "C:\Serwis\Sysinternals\bginfo_programy.bgi"  # ścieżka do pliku binarnego
$filenew = "C:\Serwis\Sysinternals\bginfo.bgi"  # ścieżka do pliku binarnego
$newpath = "C:\Serwis"  # nowa ścieżka, która zastąpi "C:\Programy"


try {
    # Wczytaj plik binarny jako bajty
    $bytes = [System.IO.File]::ReadAllBytes($file)

    $endIndex = 0x0502
    $startIndex = 0x50C
    $newPathBytes = [System.Text.Encoding]::UTF8.GetBytes($newpath)
    $newBytes = $bytes[0..($endIndex-1)] + $newPathBytes + $bytes[($startIndex-1)..($bytes.Length - 1)]
    

    [System.IO.File]::WriteAllBytes($filenew, $newBytes)

} catch {
    Write-Host "Wystąpił błąd: $_"
}