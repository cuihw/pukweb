<%@ Language=VBScript CODEPAGE="936" %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="jsonObject.class.asp" -->


<% 
'chang password please contact the network admin.
    private function updateDatabase(ByVal name, ByVal newPassword)
        dim sql

        'sql = "UPDATE siteman SET pwd='mmm123' WHERE uid='wangbw' "

        'sql = "UPDATE siteman SET pwd=" & newPassword & " WHERE uid= " & name
    
        sql = "UPDATE siteman SET pwd='"+ newPassword +"'" +  " WHERE uid='"& name + "' "

        conn.execute sql

        JSON.add "err.number",  err.number
        if not err.number<>0 then 
			updateDatabase=True
		else 
		    updateDatabase=False
		end if
    end function

    dim OldPassword  
    dim newPassword  
    dim newPassword1, uid
    
    dim JSON
    set JSON = New JSONobject

    oldPassword=request("oldpasswd")
    newPassword=request("newpasswd")
    newPassword1=request("newpasswd1")
    uid=request("uid")

    dim sessionId, isLogin, message
    sessionId = request("sessionId")
    isLogin = verifySessionId(sessionId)

    if isLogin = True then
        if newPassword="" or len(newPassword)>10 then
            message = "New password not allow empty or the length was too long(large than 10)"
        elseif newPassword <> newPassword1 then
            message = "The two new password was not same"
        elseif oldPassword = newPassword then
            message = "New password was same as old password"
        else
            dim ret
            ret = updateDatabase(uid, newPassword)
            if ret then
                JSON.add "ret",  "ok"
                message = "Update password successfully"
            else
                JSON.add "ret",  "error"
                message = "Update password failed"
            end if 
    
        end if
    else
        message = "Please login."
    end if 
    JSON.add "message",  message

    response.write JSON.write()
    
call endconnection()
%>