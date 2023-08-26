Dim Result
Dim IISObj
Set IISObj = GetObject("IIS://localhost/MSFTPSVC") 

for each IISSite in IISObj 
if (IISSite.Class = "IIsFtpServer") Then

	IIsObjectPath = "IIS://localhost/MSFTPSVC/" & IISSite.Name & "/ROOT"
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
					If PropertyName = "AccessWrite" Then
						ValueList = IIsObject.Get(PropertyName)
						WScript.Echo "Name: " & IISSite.ServerComment & ", " & PropertyName & ": " & ValueList
					End If
				End If
			Next
	Next
	End If ' End if (Not EnumPathsOnly)

End If
Next

