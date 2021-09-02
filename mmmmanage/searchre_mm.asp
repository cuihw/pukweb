<%@ Language=VBScript %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->

<% 
dim curaction,rs,text1 , sql

dim JSON
set JSON = New JSONobject

' check the user sessionId was legal
dim sessionId, isLogin , message, ret
sessionId = request("sessionId")
isLogin = verifySessionId(sessionId)

if isLogin = False then
    ret = "error"
    message = "User was not login"
else

    set rs = server.createobject("adodb.recordset")
    text1 = request("text")
    sql = "SELECT * FROM reagent WHERE cname like '%" + text1 + "%'"
	sql = sql + "OR ename LIKE '%" + text1 + "%'"
	sql = sql + "OR casno LIKE '%" + text1 + "%'"
	sql = sql + "OR mformula LIKE '%" + text1 + "%'"
	sql = sql + "OR mweight LIKE '%" + text1 + "%'"
	sql = sql + "OR place LIKE '%" + text1 + "%'"
	sql = sql + "OR buyer LIKE '%" + text1 + "%'"
	sql = sql + "OR other LIKE '%" + text1 + "%'"
	rs.open sql,conn,1,1
    if err.number <> 0 then
        ret = "error"
        message = "database error."
    else 
        ret = "OK"
        message = "database search ok."
        JSON.add "total" , rs.RecordCount
        JSON.LoadRecordset rs
        
    end if 
end if 

JSON.add "ret", ret
JSON.add "message", message
JSON.write 
set rs = nothing
call endconnection()


%>
 