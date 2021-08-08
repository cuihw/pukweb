<%
    session("adminOK") = "false"
    session("uid") = ""
    session("category") = -1
    
    response.write "<script language=javascript> alert('×¢Ïú³É¹¦£¡'); top.location.href='manage.asp' </script>"
%>