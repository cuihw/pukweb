<%@ Language=VBScript %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->

<html>
<head>
<title>显示已有试剂</title>

<% 
dim rs, rs1, sql, sql1, sql2, sql3, sql4
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM reagent "
rs.open sql, conn, 1, 1

	response.write "<table align=center border=5 bodercolor=#ffaa00 frame=box><tr><th><font size=2>ID</font></th><th><font size=2>中文名</font></th><th><font size=2>英文名</font></th><th><font size=2>CAS-No</font></th><th><font size=2>分子式</font></th><th><font size=2>分子量</font></th><th><font size=2>存放地点</font></th><th><font size=2>购买人</font></th><th><font size=2>备注</font></th></tr>"
	do while Not rs.eof
		response.write "<td><font size=2>" + cstr(rs("ID")) + "</font></td>"
		if rs("cname") <> "" then
			response.write "<td><font size=2>" + rs("cname") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if cstr(rs("ename")) <> "" then
			response.write "<td align=right><font size=2>"  + rs("ename") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("casno") <> "" then
			response.write "<td><font size=2>" + rs("casno") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("mformula") <> "" then
			response.write "<td><font size=2>" + rs("mformula") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("mweight") <> "" then
			response.write "<td><font size=2>" + rs("mweight") + "</font></td>"
		else
			response.write "<td>" + "   " + "</td>"
		end if
		if rs("place") <> "" then
			response.write "<td><font size=2 color=red>" + rs("place") + "</font></td>"
		else
			response.write "<td><font size=2>" + " " + "</td>"
		end if
		if rs("buyer") <> "" then
			response.write "<td><font size=2 color=red>" + rs("buyer") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("other") <> "" then
			response.write "<td><font size=2>" + rs("other") + "</font></td></tr>"
		else
			response.write "<td>" + " " + "</td></tr>"
		end if
		rs.MoveNext
		loop
response.write "</table>"
set rs = nothing
call endconnection()
%>
</body>
</HTML>

