<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="chkadmin.asp"-->
<html>
<head>
<title>IP����</title>
<script language="javascript">
function confirmDel(id){
if ( confirm("��ȷ��Ҫɾ����")) {
window.location.href = "ip.asp?action=delete&id=" + id
  }
}
</script>
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>

<% 
dim curaction, curid, bedit
dim sql


curaction = request("action")
curid = request("id")
bedit = false
if curaction = "edit" then
	bedit = true
end if


'ɾ��IP
if curaction = "delete" then
	sql = "DELETE FROM allow_ip WHERE id=" + cstr(curid)
	conn.execute sql
	if err.number <> 0 then
		response.write "<script language=javascript> alert('�޷�����,���ݿ��������'); history.back(); </script>"
		err.clear
	else
		response.write "<script language=javascript> alert('IP��¼�Ѿ�ɾ����'); </script>"
	end if
	
end if

'���IP
if curaction = "newsave" then
	if trim(request("ip")) = "" then
		response.write "<script language=javascript> alert('������IP��'); history.back(); </script>"
	end if
	sql = "INSERT INTO allow_ip(ip) VALUES('"
	sql = sql + cstr(request("ip")) + "')"
	conn.execute sql
	if err.number <> 0 then
	    response.write "<script language=javascript> alert('�޷�����,���ݿ��������'); history.back(); </script>"
	    err.clear
	else
		response.write "<script language=javascript> alert('IP�Ѿ���ӵ����ݿ⡣'); location.herf='ip.asp?action='; </script>"
	end if
	
end if

'�����¼
if curaction = "editsave" then
	if trim(request("ip")) = "" then
		response.write "<script language=javascript> alert('������IP��'); history.back(); </script>"
	end if
	
	sql = "UPDATE allow_ip SET "
	sql = sql + "ip='" + trim(request("ip")) + "'"
	sql = sql + " WHERE id = " + cstr(curid)
	conn.execute sql
	if err.number <> 0 then
		response.write "<script language=javascript> alert('�޷�����,���ݿ��������'); history.back(); </script>"
		err.clear
	else
		response.write "<script language=javascript> alert('IP�Ѿ����µ����ݿ⡣'); </script>"
	end if

end if


dim rs
set rs = server.createobject("adodb.recordset")
sql = "SELECT * FROM allow_ip"
rs.open sql, conn, 1, 1
if err.number <> 0 then
	response.write "<script language=javascript> alert('���ݿ����ʧ�ܡ�'); history.back(); </script>"
else
	if rs.eof and rs.bof then
		response.write "û��IP��¼"
	else
%>
<table width="369" align=center border="0" cellspacing="0" align="CENTER" cellpadding="0" bgcolor="#CCCC99" height="49">
		<tr bgcolor=<%= THCOLOR %>>
		<td align=center width="323" height="16"><b><font size="2" >���</font></b></td>
		<td align=center width="100" height="16"><b><font size="2" >����</font></b></td></tr>
		<% do while not rs.eof 
			dim tdcolor
			tdcolor = TDCOLORL
			if bedit then
				if clng(rs("id")) = clng(curid) then
					tdcolor = TDCOLORD
				end if
			end if
			response.Write "<tr bgcolor=" & tdcolor & ">"
			Response.Write "<td align=center ><font size=2>"& rs("ip") &"</font></td>"
			Response.Write "<td align=center ><font size=2><a href='ip.asp?action=edit&id=" & cstr(rs("id")) & "'>�༭</a>"
			Response.Write "  <a href='javascript:confirmDel( "& rs("id") &")'>ɾ��</a></font></td></tr>"
			                
			rs.movenext
		loop 
		Response.Write "</table>"
	End If
	rs.close
	
end if
if bedit then
	sql = "SELECT * FROM allow_ip WHERE id = " + cstr(curid)
	rs.open sql, conn, 1, 1
end if
 %>
<form action="ip.asp" method="POST">
        <tr>
          <td valign="middle" height="23" width="323">
<p align=center style="line-height: 100%"><b><font class=big_title size="2"><% If bedit then %>�༭IP��<% Else  %>���IP��<% End If %></font></b></p>
            <table width="305" cellspacing="0" cellpadding="0" border="0" bgcolor="#CCCC99" align="center" height="17">
<tr>
    <td width="29" bgcolor=<%= TDCOLORD %> height="7">
      <p style="line-height: 100%"><b><font size="2">IP��</font></b></p>
    </td>
    <td width="272" bgcolor=<%= TDCOLORL %> height="7"><font size="2">
<input type="Text" name="ip" size="44" value='<% If bedit then response.write rs("ip")

 %>'></font></td>
</tr>
<tr><td align=center colspan="2" bgcolor=<%= TDCOLORD %> width="303" height="10"><font size="2">
<input type="Hidden" name="action" value='<% If bedit then%>editsave<% Else  %>newsave<% End If %>'>
<% If bedit then %>
<input type="Hidden" name="id" value='<%= cstr(curid) %>'>
<% End If %>
<input type="Submit" name="btnsave" value="�����޸�">&nbsp;&nbsp; <input type="Reset" value="������д"></font></td></tr>                        
</table>
</form>
<% 
set rs = nothing
call endconnection()
 %>
          </table>
</body>
