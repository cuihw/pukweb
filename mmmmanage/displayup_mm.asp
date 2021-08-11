<%@ Language=VBScript %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->

<html>
<head>
<title>отй╬ряспйт╪а</title>

<% 
dim rs, rs1, sql, sql1, sql2, sql3, sql4
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM reagent "
rs.open sql, conn, 1, 1

			

    response.write "</table>"
    set rs = nothing
call endconnection()
%>
</body>
</HTML>

