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

'WScript.Echo "* LogType�� 0�̸� ���� ���� ����, 1�̸� Log ���� ����"
WScript.Echo ""

'If Result = 1 Then
'	WScript.Echo "�ڡڡ� Vulnerable-4.2-FTP(1) - ���͸� ���ٱ��� ����"
'Else
'	WScript.Echo "�ڡڡ� Good-4.2-FTP(1) - ���͸� ���ٱ��� ����"
'End If
