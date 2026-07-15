$path = Join-Path $PSScriptRoot 'run.ps1'
$tokens = $null
$errors = $null

[System.Management.Automation.Language.Parser]::ParseFile($path, [ref]$tokens, [ref]$errors) | Out-Null

if ($errors) {
    $errors | ForEach-Object {
        '{0}:{1} {2}' -f $_.Extent.StartLineNumber, $_.Extent.StartColumnNumber, $_.Message
    }
    exit 1
}

Write-Host 'Parse OK'