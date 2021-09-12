<%@ Language=VBScript%>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->
<!--#include file ="class_md5.asp" -->

<%
	dim sql,  rs
    dim name , sessionId, ret, message
    name = request("uid")
	sessionId = request("sessionId")

	set rs=server.createobject("adodb.recordset")
	sql="select * from siteman where uid='" & name & "' and sessionID='" & sessionId & "' "
    rs.open sql,conn,1,1

    Log sql

    dim JSON
    set JSON = New JSONobject

    if err.number<>0 then 
		ret = "error"
        message = "database error£º" & err.description
    else
		if rs.bof and rs.eof then
            ret = "error"
		    message = "Not logged in."
	    else
			if rs.RecordCount<1 then
		       ret = "error"
		       message = "Not found user."
			else
		       ret = "ok"
		       message = "adminOK."
			end if
		end if
        rs.close
        set rs=nothing
	end if

    JSON.add "ret", ret
    JSON.add "message", message 
    JSON.write 
	call endConnection()
%>

