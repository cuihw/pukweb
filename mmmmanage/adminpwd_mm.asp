<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="jsonObject.class.asp" -->


<% 
'chang password please contact the network admin.
    private function updateDatabase(ByVal name, ByVal newPassword)
        dim sql
        sql = "UPDATE siteman SET pwd='"+ newPassword +"'" +  " WHERE uid='"& name + "' "
        conn.execute sql

        JSON.add "error", "err.number: " &  err.number
        if not err.number<>0 then 
			updateDatabase=True
		else 
		    updateDatabase=False
		end if
    end function

    dim OldPassword
    dim newPassword,  uid
    
	dim sql,  rs

    dim JSON
    set JSON = New JSONobject

    dim ret

    oldPassword=request("oldwd")
    newPassword=request("newwd")
    uid=request("uid")

    dim sessionId, isLogin, message
    sessionId = request("sessionId")
    isLogin = verifySessionId(sessionId)

    if isLogin = True then
        if newPassword="" or len(newPassword)>10 then
            message = "New password not allow empty or the length was too long(large than 10)"
        else
            
        	set rs=server.createobject("adodb.recordset")
	        sql="select * from siteman where uid='" & name & "' and pwd='" & OldPassword & "' "
            rs.open sql,conn,1,1
  
            if err.number<>0 then 
                ret = "error"
                message = "database error"
            elseif  rs.RecordCount<1 then
		        ret = "error"
                message = "old password was not correctly"
            else
                dim  isUpdated
                isUpdated = updateDatabase(uid, newPassword, oldPassword)
                if isUpdated then
                    ret ="ok"
                    message = "Update password successfully"
                else
                    ret = "error"
                    message = "Update password failed"
                end if
            end
        end if
    else
        message = "Please login."
    end if 

    JSON.add "ret" ret
    JSON.add "message",  message

    response.write JSON.write()
    
call endconnection()
%>