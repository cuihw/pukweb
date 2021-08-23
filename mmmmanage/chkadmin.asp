<% 

	sql="select * from allow_ip where ip='" & Request.ServerVariables("REMOTE_ADDR") & "' "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
 '   if rs.RecordCount<1 then
 '       response.write "<script language=javascript> alert('您的IP不允许进行管理'); parent.location.href='manage.asp'; </script>"
 '   end if

    if session("adminOK") <> "true" then
	    response.write "<script language=javascript> alert('你没有登录'); parent.location.href='manage.asp'; </script>"
    end if
 %>