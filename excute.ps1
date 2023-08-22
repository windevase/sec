$batFilePath = "C:\JOYSEC\23-Windows_v2.0.1.bat"
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c echo y | $batFilePath" -Verb RunAs -PassThru

while (!$process.HasExited) {
    Start-Sleep -Seconds 1
}
