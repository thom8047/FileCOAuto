' Depre

Dim RowInfo As New ArrayList
RowInfo.Add "proj_num"
RowInfo.Add instance_id
RowInfo.Add carrier

For i = 0 To RowInfo.Count - 1
    Cells(Rows.Count, 1).End(xlUp).Offset((i + 1), 0).Select
    ActiveCell.Value = RowInfo(i)
Next

Dim proj_num As String
Dim instance_id As String
Dim carrier As String
Dim st As String
Dim county As String
Dim tech As String
Dim due As String
Dim rtg_type As String
Dim sector_num As String
Dim psap_num As String
Dim formatting As String
Dim assumable As String
Dim map As String
Dim action_date As String
Dim status As String
Dim notes As String


proj_num = CreateObject("WScript.Shell").Environment("process").Item("projNum")
instance_id = CreateObject("WScript.Shell").Environment("process").Item("id")
carrier = CreateObject("WScript.Shell").Environment("process").Item("carrier")
st = CreateObject("WScript.Shell").Environment("process").Item("state")
county = CreateObject("WScript.Shell").Environment("process").Item("county")
tech = CreateObject("WScript.Shell").Environment("process").Item("tech")
due = CreateObject("WScript.Shell").Environment("process").Item("due_date")
rtg_type = CreateObject("WScript.Shell").Environment("process").Item("routing_type")
sector_num = CreateObject("WScript.Shell").Environment("process").Item("sector_num")
psap_num = CreateObject("WScript.Shell").Environment("process").Item("psap_num")
formatting = CreateObject("WScript.Shell").Environment("process").Item("formatting")
assumable = CreateObject("WScript.Shell").Environment("process").Item("assumable")
bool_map = CreateObject("WScript.Shell").Environment("process").Item("map")
action_date = CreateObject("WScript.Shell").Environment("process").Item("action_date")
status = CreateObject("WScript.Shell").Environment("process").Item("status")
notes = CreateObject("WScript.Shell").Environment("process").Item("notes")

RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("projNum")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("id")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("carrier")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("state")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("county")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("tech")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("due_date")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("routing_type")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("sector_num")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("psap_num")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("formatting")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("assumable")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("map")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("action_date")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("status")
RowInfo.Add = CreateObject("WScript.Shell").Environment("process").Item("notes")