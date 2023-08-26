Dim Result
Dim IISObj
Set IISObj = GetObject("IIS://localhost/SmtpSvc") 

for each IISSite in IISObj 
if (IISSite.Class = "IIsSmtpServer") Then

	IIsObjectPath = "IIS://localhost/SmtpSvc/" & IISSite.Name
	Set IIsObject = GetObject(IIsObjectPath)

	IIsSchemaPath = IIsObject.Schema
	Set IIsSchemaObject = GetObject(IIsSchemaPath)

	ReDim PropertyListSet(1)
	PropertyListSet(0) = IIsSchemaObject.MandatoryProperties
	PropertyListSet(1) = IIsSchemaObject.OptionalProperties

	If (Not EnumPathsOnly) Then
	For Each PropertyList In PropertyListSet

			For Each PropertyName In PropertyList
				If Err <> 0 Then
					Exit For
				End If
				
				'��� ù �׸��� ""�ε� �̶� Get ValuseList�ϸ� ���� �߻��̶� ���� ó����.
				If PropertyName <> "" Then
					ValueList = ""
					If PropertyName = "RelayForAuth" Then
						ValueList = IIsObject.Get(PropertyName)
						WScript.Echo "Name: " & IISSite.Name & ", " & PropertyName & ": " & ValueList
					End If
				End If
			Next
	Next
	End If ' End if (Not EnumPathsOnly)

End If
Next

