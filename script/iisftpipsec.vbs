Dim Result
Dim IISObj
Set IISObj = GetObject("IIS://localhost/MSFTPSVC") 

for each IISSite in IISObj 
if (IISSite.Class = "IIsFtpServer") Then

	IIsObjectPath = "IIS://localhost/MSFTPSVC/" & IISSite.Name & "/ROOT"
	Set IIsObject = GetObject(IIsObjectPath)
	
	Set objIpSecurity = IIsObject.Get("IPSecurity")
	If objIpSecurity.GrantByDefault = TRUE Then
		WScript.Echo "Name: " & IISSite.ServerComment & ", Directory Security Configure : Default Access Allow"
	Else
		WScript.Echo "Name: " & IISSite.ServerComment & ", Directory Security Configure : Default Access Deny"
	End If
		
End If
Next
