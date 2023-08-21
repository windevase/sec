

Dim CXMLDATA
'Dim objArgs
'Set objArgs = WScript.Arguments
'WScript.Echo WScript.Arguments(0)

CXMLDATA = WScript.Arguments(0)

Dim oDoc
Dim oItems
Dim oItem
Dim oTag
Dim Result

Set oDoc = WScript.CreateObject("MSXML2.DOMDocument")
Result = 0

If oDoc.Load (CXMLDATA) Then
	Set oItems = oDoc.DocumentElement.SelectNodes("/XMLOut/Check/Detail/UpdateData")
	If (0 < oItems.Length) Then
		For Each oItem In oItems
			If (oItem.GetAttribute("IsInstalled") = "false") Then
				Set oTag = oItem.SelectSingleNode("Title")
				WScript.Echo "Title: " & oTag.Text & ", " & "IsInstalled: " & oItem.GetAttribute("IsInstalled")
			End If
		Next
	End If
End If

Set oDoc = Nothing
oDoc = Null
