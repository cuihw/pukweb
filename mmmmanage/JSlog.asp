<%
public Function Log(ByVal msg) 
  response.write "<script language=javascript> console.log('" & msg & "') </script>"
end Function
%>
<script type="text/javascript" language="javascript" runat="server">
    function jslog(logs){
        console.log(logs)
    }
</script>