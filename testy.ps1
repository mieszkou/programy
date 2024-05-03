$DownloadUri = "https://download.documentfoundation.org/libreoffice/stable/"
$r = Invoke-WebRequest -Uri "$DownloadUri/"
$versions = ($r.Links | Where-Object { $_.href -match "(\d{2}\.\d+\.\d+\/)" }).href -replace "/", ""
$Version = $versions | Sort-Object -Descending | Select-Object -First 1
$uri = $($DownloadUri + $Version + "/win/x86_64/") + (Invoke-WebRequest -UseBasicParsing -Uri $($DownloadUri + $Version + "/win/x86_64/") | Select-Object -ExpandProperty Links | Where-Object {($_.href -like '*_x86-64.msi')} | Select-Object -First 1 | Select-Object -ExpandProperty href)



# $uri = Invoke-RestMethod -uri  $uri = Invoke-RestMethod -uri  https://api.github.com/repos/doublecmd/doublecmd/releases/latest | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
#     Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
#     Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
#     New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
#     try {
#     Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
#     }
#     catch { | Select-Object -ExpandProperty "assets" | ? { $_.name.Contains("win64.exe")} | Select-Object -ExpandProperty browser_download_url
#     Invoke-WebRequest -Uri $uri -OutFile "$($env:TEMP)\doublecmd.exe"
#     Start-Process -Wait -FilePath "$($env:TEMP)\doublecmd.exe" -ArgumentList "/SILENT /SP-"
#     New-Item -Path "$($env:APPDATA)\doublecmd" -ItemType Directory -Force | Out-Null
#     try {
#     Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mieszkou/programy/master/doublecmd/doublecmd.xml" -OutFile "C:\Program Files\Double Commander\doublecmd.xml"
#     }
#     catch {


# # Query the LibreOffice update API
#     foreach ($item in $res.Get.Update.UserAgent.GetEnumerator()) {
#         $params = @{
#             Uri                  = $res.Get.Update.Uri
#             UserAgent            = $res.Get.Update.UserAgent[$item.Key]
#             ContentType          = $res.Get.Update.ContentType
#             SkipCertificateCheck = $True
#         }
#         $Update = Invoke-EvergreenRestMethod @params
#         if ($null -ne $Update) {

#             if ($null -eq $Update.description.version) {
#                 Write-Warning "$($MyInvocation.MyCommand): failed to return a version number for release $($item.Name) from: $($res.Get.Update.Uri)."
#             }
#             else {
#                 Write-Verbose "$($MyInvocation.MyCommand): $($res.Get.Update.Uri) returned version: $($Update.description.version)."

#                 # Get downloads for each platform for the latest version
#                 foreach ($platform in $res.Get.Download.Platforms.GetEnumerator()) {

#                     Write-Verbose "$($MyInvocation.MyCommand): parsing: $($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/."
#                     $params = @{
#                         Uri          = "$($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/"
#                         ReturnObject = "All"
#                     }
#                     $PlatformList = Invoke-EvergreenWebRequest @params

#                     if ($null -eq $PlatformList) {
#                         Write-Warning "$($MyInvocation.MyCommand): Check that the following URL is valid: $($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/."
#                     }
#                     else {
#                         $Architectures = ($PlatformList.Links | Where-Object { $_.href -match $res.Get.Download.MatchArchitectures }).href -replace "/", ""
#                         foreach ($arch in $Architectures) {

#                             # Get downloads for each architecture for the latest version/platform
#                             Write-Verbose "$($MyInvocation.MyCommand): parsing: $($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/$arch/."
#                             $params = @{
#                                 Uri          = "$($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/$arch/"
#                                 ReturnObject = "All"
#                             }
#                             $ArchitectureList = Invoke-EvergreenWebRequest @params

#                             if ($null -eq $ArchitectureList) {
#                                 Write-Warning "$($MyInvocation.MyCommand): Check that the following URL is valid: $($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/$arch/."
#                             }
#                             else {
#                                 $Files = ($ArchitectureList.Links | Where-Object { $_.href -match $res.Get.Download.MatchExtensions }).href -replace "/", ""
#                                 foreach ($file in ($Files | Where-Object { $_ -notlike "*sdk*" })) {

#                                     # Match language string
#                                     Remove-Variable -Name "Language", "match" -ErrorAction "SilentlyContinue"
#                                     $match = $file | Select-String -Pattern $res.Get.Download.MatchLanguage
#                                     if ($null -ne $match) {
#                                         $Language = $match.Matches.Groups[1].Value
#                                     }
#                                     else {
#                                         $Language = $res.Get.Download.NoLanguage
#                                     }

#                                     # Construct the output; Return the custom object to the pipeline
#                                     $PSObject = [PSCustomObject] @{
#                                         Version      = $($Update.description.version)
#                                         Architecture = $arch
#                                         Release      = $item.Name
#                                         Language     = $Language
#                                         URI          = $("$($res.Get.Download.Uri)/$($Update.description.version)/$($platform.Name)/$arch/$file")
#                                     }
#                                     Write-Output -InputObject $PSObject
#                                 }
#                             }
#                         }
#                     }
#                 }
#             }
#         }
#     }
# }

# Get-LibreOffice