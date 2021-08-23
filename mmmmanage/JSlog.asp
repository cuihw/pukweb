<%
public Function Log(ByVal msg) 
  response.write "<script language=javascript> console.log('" & msg & "') </script>"
end Function
%>
