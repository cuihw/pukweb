
<%@ Language=VBScript CODEPAGE="936" %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->


<% 
dim rs, sql , message, ret
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM reagent "
rs.open sql, conn, 1, 1


if err.number <> 0 then
    ret = "error"
    message = "database error."
else
    ret = "ok"
    message = "show all item of database."
    dim JSON
    set JSON = New JSONobject
    JSON.LoadRecordset rs
end if

set rs = nothing

JSON.add "ret", ret
JSON.add "message", message
JSON.write
call endconnection()
%>