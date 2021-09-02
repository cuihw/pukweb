<%@ Language=VBScript%>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->
<!--#include file ="class_md5.asp" -->

<%
	dim sql,  rs
    dim name , sessionId
    name = request("uid")
	sessionId = request("sessionId")

	set rs=server.createobject("adodb.recordset")
	sql="select * from siteman where uid='" & name & "' and sessionID='" & sessionId & "' "
    rs.open sql,conn,1,1

    dim JSON
    set JSON = New JSONobject

    if err.number<>0 then 
		JSON.add "ret", "error"
        JSON.add "message", "database error£º" & err.description
    else
		if rs.bof and rs.eof then
            JSON.add "ret","error"
		    JSON.add "message" "Please input correctly username and password."
	    else
			if rs.RecordCount<1 then
		       JSON.add "ret","error"
		       JSON.add "message" "Please input correctly username and password."
			else
		       JSON.add "ret","ok"
		       JSON.add "message" "adminOK."
			end if
		end if
        rs.close
        set rs=nothing
	end if

    JSON.write 
	call endConnection()
%>

