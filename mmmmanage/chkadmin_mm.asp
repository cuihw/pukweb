<% 

	sql="select * from siteman where sessionId='" & Request.ServerVariables("sessionId") & "' "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
 '   if rs.RecordCount<1 then
 '       response.write "<script language=javascript> alert('您的IP不允许进行管理'); parent.location.href='manage.asp'; </script>"
 '   end if

    if rs.RecordCount < 1 then
	    response.write "Error: not login, Please login"
    end if
 %>