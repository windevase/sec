OldDate = DateAdd("d", Date, -180)
DateCode = Month(OldDate) & "/" & Day(OldDate) & "/" & Year(OldDate)
WScript.Echo DateCode