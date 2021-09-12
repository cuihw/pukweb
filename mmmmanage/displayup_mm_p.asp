<%@ Language=VBScript  %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->


<% 
'String sql="select top 30 * from reagent where ID not in "
'			+ "(select top "+(page-1)*30+" ID from reagent order by ID Desc) "
'					+ "order by ID Desc";

dim rs, sql , message, ret, page, page_start, pagesize
dim JSON
set JSON = New JSONobject
set rs = server.createobject("adodb.recordset")

pagesize = 30

page = request("page")
if page = "" then page = 1

page_start = (page-1) * pagesize

JSON.add "page", page
JSON.add "page_start", page_start

'sql = "SELECT * FROM reagent "
 'sql="select top 30 * from reagent where ID not in (select top " + page_start + "  ID from reagent order by ID Desc) " + "order by ID Desc"
  'sql="select top 6 * from reagent where ID not in (select top 2 ID from reagent order by ID Desc) order by ID Desc"
if page_start = 0 then
    sql = "select top "&pagesize&" * from reagent order by ID Desc"
else 
    sql = "select top "&pagesize&" * from reagent where ID not in (select top " & page_start & " ID from reagent order by ID Desc) order by ID Desc"
end if 

Log sql

rs.open sql, conn, 1, 1


if err.number <> 0 then
    ret = "error"
    message = "database error."
else
    ret = "ok"
    message = "show all item of database."

    JSON.LoadRecordset rs
    rs.Close
end if

dim countrs ,iTotalRecords
sql = "SELECT COUNT('ID') FROM reagent "
set countrs = conn.execute(sql)
    
if not countrs.Eof then
  iTotalRecords = countrs.Fields("Expr1000")
else
  iTotalRecords = 0
end if

Set rsscroll = Server.CreateObject("ADODB.Recordset")
Dim strSQLscroll, rsscroll, intRow
sql = "SELECT COUNT('ID') FROM reagent "
rsscroll.open sql, conn

'JSON.LoadRecordset rsscroll

JSON.add "total",  iTotalRecords

set rs = nothing

JSON.add "ret", ret
JSON.add "message", message
JSON.write

call endconnection()
%>