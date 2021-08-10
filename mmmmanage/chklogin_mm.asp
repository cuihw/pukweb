<%@ Language=VBScript %>

<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file = "Crypto.Class.asp" -->


<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<%
	dim sql
	dim rs

    dim name
    name = request("uid")
    dim password
	password = request("password")
	
	public Function Jslog(ByVal msg) 
	response.write "<script language=javascript> console.log('" & msg & "') </script>"
	end Function

	set rs=server.createobject("adodb.recordset")
	sql="select * from siteman where uid='" & name & "' and pwd='" & password & "' "
    rs.open sql,conn,1,1

    private Function  updateSessionId(ByVal name, ByVal password)
        call Log("make md5 crypto string: " & name & ", " & password)

        dim crypt
        set crypt = new crypto

        dim salt
        salt = password & Now
        call Log("salt: " & salt)

        dim md5Result
        md5Result = crypt.hashPassword(password, "MD5", "b64")
        call Log("md5 crypto: " & md5Result)

        call updateSessionIdsql(md5Result, name)

        set crypt = nothing
        updateSessionId = md5Result
	end Function

    Public Function  loginSuccessfully(ByVal  isLogin , ByVal  message)
        if isLogin then
            dim passport

            passport = updateSessionId(name, password)
            response.write "ret: OK "  + ", message: " + message + ", passport: " + passport
        else
            response.write "login Failed! "& message
	    end if
    end Function

    if err.number<>0 then 
		call loginSuccessfully (False, "数据库操作失败："&err.description)
    else
		if rs.bof and rs.eof then
		call loginSuccessfully (False, "对不起，请输入正确的用户名和口令。")
	    else
			if rs.RecordCount<1 then
		        call loginSuccessfully (False, "对不起，请输入正确的用户名和口令。")
			else
    		    call loginSuccessfully (True, "adminOK")
			end if
		end if
        rs.close
        set rs=nothing
	end if

	call endConnection()
%>