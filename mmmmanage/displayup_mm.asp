<%@ Language=VBScript  %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->


<% 
' SELECT COUNT(column_name) FROM table_name

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
    rs.Close
end if

dim countrs ,iTotalRecords
sql = "SELECT COUNT('ID') FROM reagent "
set countrs = conn.execute(sql)
    
if not countrs.Eof then
  iTotalRecords = countrs.Fields("Expr1000")
  'JSON.LoadRecordset countrs
else
  iTotalRecords = 0
end if

    Set rsscroll = Server.CreateObject("ADODB.Recordset")
    Dim strSQLscroll, rsscroll, intRow
    sql = "SELECT COUNT('ID') FROM reagent "
    rsscroll.open sql, conn

    'JSON.LoadRecordset rsscroll

JSON.add "count",  iTotalRecords

set rs = nothing
    

JSON.add "ret", ret
JSON.add "message", message
JSON.write
call endconnection()
%>