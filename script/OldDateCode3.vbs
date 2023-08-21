OldDate = DateAdd("d", Date, -2)
DateCode = Year(OldDate) & Right("0" & Month(OldDate), 2) & Right("0" & Day(OldDate), 2)
WScript.Echo DateCode