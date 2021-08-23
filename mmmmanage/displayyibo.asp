<%@ Language=VBScript %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->

<html>
<head>
<title>显示来校款项</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>
<p align="right"><b><font face="楷体_GB2312" color="#800000" size="4">到校已拨款项列表</font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="楷体_GB2312">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</font><a href="displayup.asp"><font face="楷体_GB2312">返回未拨数据库</font></a></p>
 
<% 
dim rs, rs1, sql, sql1, sql2, sql3, sql4
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM dxkx "
rs.open sql, conn, 1, 1

	response.write "<table align=center border=5 bodercolor=#ffaa00 frame=box><tr><th><font size=2>ID</font></th><th><font size=2>来款单位</font></th><th><font size=2>金额</font></th><th><font size=2>收款时间</font></th><th><font size=2>收款单位</font></th><th><font size=2>用途</font></th><th><font size=2>科研部状态</font></th><th><font size=2>财务部状态</font></th><th><font size=2>备注</font></th></tr>"
	do while Not rs.eof
		if rs("kybstate") = "已拨" AND rs("cwbstate") = "已拨" then
		response.write "<td><font size=2>" + cstr(rs("ID")) + "</font></td>"
		if rs("lkdw") <> "" then   'department of money form
			response.write "<td><font size=2>" + rs("lkdw") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if cstr(rs("jine")) <> "" then   ' number of money
			response.write "<td align=right><font size=2>"  + cstr(FormatCurrency(rs("jine"),0)) + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("sksj") <> "" then       ' time of money arrived
			response.write "<td><font size=2>" + rs("sksj") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("skdw") <> "" then           'department of money to
			response.write "<td><font size=2>" + rs("skdw") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("yongtu") <> "" then            ' what is the usage.
			response.write "<td><font size=2>" + rs("yongtu") + "</font></td>"
		else
			response.write "<td>" + "   " + "</td>"
		end if
		if rs("kybstate") <> "" then            ' Research Department state.
				if rs("kybstate") = "已拨" then
					response.write "<td><font size=2 color=red>" + rs("kybstate") + "</font></td>"
				else
					response.write "<td><font size=2 color=black>" + rs("kybstate") + "</font></td>"
				end if
		else
			response.write "<td><font size=2>" + " " + "</td>"
		end if
		if rs("cwbstate") <> "" then          'Finance Department state.
			if rs("cwbstate") = "已拨" then
					response.write "<td><font size=2 color=red>" + rs("cwbstate") + "</font></td>"
				else
					response.write "<td><font size=2 color=black>" + rs("cwbstate") + "</font></td>"
				end if
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("other") <> "" then   'other comment
			response.write "<td><font size=2>" + rs("other") + "</font></td></tr>"
		else
			response.write "<td>" + " " + "</td></tr>"
		end if
		end if
		rs.MoveNext
		loop
response.write "</table>"
set rs = nothing
call endconnection()
%>
</body>
</HTML>