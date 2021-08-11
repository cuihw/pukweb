
<%@ Language=VBScript CODEPAGE="936" %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->

<html>

<% 
dim rs, rs1, sql, sql1, sql2, sql3, sql4
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM reagent "
rs.open sql, conn, 1, 1

    dim JSON
    set JSON = New JSONobject
    JSON.LoadRecordset rs
      
    JSON.write 
    set rs = nothing
call endconnection()
%>
</body>
</HTML>