<%
    session("adminOK") = "false"
    session("uid") = ""
    session("category") = -1
    
    response.write "<script language=javascript> alert('ע���ɹ���'); top.location.href='manage.asp' </script>"
%>