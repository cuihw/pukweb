<%@ Language=VBScript%>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->
<!--#include file ="class_md5.asp" -->

<%
    'CODEPAGE="utf-8"
	dim sql,  rs
    dim name , password
    name = request("uid")
	password = request("password")

	set rs=server.createobject("adodb.recordset")
	sql="select * from siteman where uid='" & name & "' and pwd='" & password & "' "
    rs.open sql,conn,1,1

    dim JSON
    set JSON = New JSONobject

    private Function putJsonValue(ByVal key, ByVal value) 
        call JSON.Add( key, value)
        putJsonValue = JSON.Serialize() ' this will contain the string representation of the JSON object
    end Function
    '=======================
    private Function  updateSessionId(ByVal name, ByVal password)
        
        dim crypt, rets
        set crypt = new crypto

        dim salt, nowTime
        nowTime =  Now
        salt = password & nowTime

        Dim objMD5, md5Result
        Set objMD5 = New MD5
        objMD5.Text = password & nowTime
        md5Result = objMD5.HEXMD5

        call updateSessionIdsql(md5Result, name)

        set crypt = nothing
        rets = putJsonValue ("md5Result", md5Result)
        updateSessionId = putJsonValue( "nowTime",  nowTime)
	end Function

    Public Function  loginSuccessfully(ByVal  isLogin , ByVal  message)
        dim session, rets
        
        if isLogin then
            session = updateSessionId(name, password)
            rets = putJsonValue ("ret", "OK")
        else
            rets = putJsonValue ("ret", "error")
	    end if
        
        rets = putJsonValue ("message", message)
        response.write rets
    end Function

    if err.number<>0 then 
		call loginSuccessfully (False, "database error£º"&err.description)
    else
		if rs.bof and rs.eof then
		call loginSuccessfully (False, "Please input correctly username and password.")
	    else
			if rs.RecordCount<1 then
		        call loginSuccessfully (False, "Please input correctly username and password.")
			else
    		    call loginSuccessfully (True, "adminOK")
			end if
		end if
        rs.close
        set rs=nothing
	end if

	call endConnection()
%>

