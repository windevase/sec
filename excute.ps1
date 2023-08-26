$directoryPath = "C:\JOYSEC"
$batFileName = Get-ChildItem -Path $directoryPath -Filter "*-Windows_*.bat" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$batFilePath = Join-Path -Path $directoryPath -ChildPath $batFileName

$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c echo y | $batFilePath" -Verb RunAs -PassThru

while (!$process.HasExited) {
    Start-Sleep -Seconds 1
}
