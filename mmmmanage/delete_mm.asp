<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->


<% 
dim curaction, rs, sql, id
dim JSON , ret , message, isLogin, sessionId
set JSON = New JSONobject

id =  Cint(Request("ID"))
JSON.add "id", id

sessionId = request("sessionId")
isLogin = verifySessionId(sessionId)

if isLogin = False then
    ret = "error"
    message = "User was not login"
else
    sql = "DELETE FROM reagent WHERE ID=" + CStr(id)

    conn.execute sql
    if err.number <> 0 then
        ret = "error"
        message = "Database error, can not delete this data"
    else 
        ret = "ok"
        message = "id = " & id & " data has been deleted."
    end if
end if     
    
JSON.add "ret", ret
JSON.add "message", message
JSON.write
call endconnection()
%>

























































