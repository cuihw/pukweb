<% 

	sql="select * from allow_ip where ip='" & Request.ServerVariables("REMOTE_ADDR") & "' "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
 '   if rs.RecordCount<1 then
 '       response.write "<script language=javascript> alert('����IP��������й���'); parent.location.href='manage.asp'; </script>"
 '   end if

    if session("adminOK") <> "true" then
	    response.write "<script language=javascript> alert('��û�е�¼'); parent.location.href='manage.asp'; </script>"
    end if
 %>