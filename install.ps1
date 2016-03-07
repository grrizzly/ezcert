$packageUri = "https://github.com/grrizzly/ezcert/archive/0.0.1.zip"
$outputFile = "$env:TEMP\ezcert-0.0.1.zip"
$installLocation = "$home\Documents\WindowsPowerShell\Modules\ezcert"

if (Test-Path $outputFile) {
  rm $outputFile
}

Invoke-WebRequest -Uri "file:///$env:USERPROFILE/Documents/Visual Studio 2015/Projects/ezcert/package.zip" -OutFile $outputFile

if (Test-Path $installLocation) {
  Write-Host "Removing previously installed version"
  rm -r -force $installLocation
}

Add-Type -A 'System.IO.Compression.FileSystem'
[IO.Compression.ZipFile]::ExtractToDirectory($outputFile, $installLocation)