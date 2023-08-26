Dim Result
Dim IISObj
Set IISObj = GetObject("IIS://localhost/MSFTPSVC") 

Result = 0
for each IISSite in IISObj 
if (IISSite.Class = "IIsFtpServer") Then
	If ( IISSite.LogType = 0 ) Then
		Result = 1
	End If
	WScript.Echo "ServerComment = " & IISSite.ServerComment & ", LogType = " & IISSite.LogType
End If
Next

'WScript.Echo "* LogType이 0이면 설정 해제 상태, 1이면 Log 설정 상태"
WScript.Echo ""

'If Result = 1 Then
'	WScript.Echo "★★★ Vulnerable-4.2-FTP(1) - 디렉터리 접근권한 설정"
'Else
'	WScript.Echo "★★★ Good-4.2-FTP(1) - 디렉터리 접근권한 설정"
'End If
