@echo off
echo ----------------------------------------------------
echo Uruchamiam program kasowy, prosze czekac
choice /C NS /N /T 3 /D N /M "Aby pominac odliczanie nacisnij [S] "

if errorlevel 2 (
GOTO START
)

echo 3 ...	
Ping 127.0.0.1 > nul
echo 2 ...
Ping 127.0.0.1 > nul
echo 1 ...	
Ping 127.0.0.1 > nul

:START
echo ----------------------------------------------------
echo Start PC-POS
c:
cd "C:\Program Files\Insoft\pcpos7\"
"C:\Program Files\Insoft\pcpos7\Java\jre-x64\bin\javaw.exe" -Xmx600M -jar "C:\Program Files\Insoft\pcpos7\pcpos7.jar" .\pcpos7.conf /path="C:\Program Files\Insoft\pcpos7" 

echo ----------------------------------------------------
echo Koniec PC-POS
echo ----------------------------------------------------
echo Restart systemu, prosze czekac
echo 5 ...
Ping 127.0.0.1 > nul
echo 4 ...	
Ping 127.0.0.1 > nul
echo 3 ...	
Ping 127.0.0.1 > nul
echo 2 ...
Ping 127.0.0.1 > nul
echo 1 ...	
Ping 127.0.0.1 > nul
shutdown -r