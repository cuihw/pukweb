<%@ Language=VBScript %>
<!--#include file="database1.asp"-->

<html>
<head>
<title>�Լ���ѯϵͳ</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body topmargin="15">
<h5 align="center"><font face="����" size="5"> �Լ���ѯϵͳ</font></h5>

<form "frm_sch" action="searchre.asp" method="POST">
<table align=center cellspacing="0" border="0" width="721" cellpadding="0">

<tr>
    <td width=184>
      <p align="right"><b><font size="2">�����ֶΣ�</font></b></p>
    </td>
    <td width=529> <font size="2"> <input type="Text" name="text" size=54 ></font>
    </td>
</tr>
<tr><td align=center colspan="2" width="717" >
<input type="Hidden" name="action" value= "newsave" >
    <p align="left" style="margin-top: 2; margin-bottom: 2">
<font size="2" face="����_GB2312">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
���������Լ���¼�е��κ��ֶμ��ɡ���</font></p>
    <p style="margin-top: 2; margin-bottom: 2">
<input type="Submit" name="editsave" value="����"></p>
  	</td></tr>  
</table>

</form>

<% 
dim curaction,rs,text1
dim sql
curaction = request("action")
set rs = server.createobject("adodb.recordset")
if curaction = "newsave" then
text1 = request("text")
	if text1 = "" then
		response.write "����������ַ���"
	else
		sql = "SELECT * FROM reagent WHERE cname like '%" + text1 + "%'"
		sql = sql + "OR ename LIKE '%" + text1 + "%'"
		sql = sql + "OR casno LIKE '%" + text1 + "%'"
		sql = sql + "OR mformula LIKE '%" + text1 + "%'"
		sql = sql + "OR mweight LIKE '%" + text1 + "%'" 
		sql = sql + "OR place LIKE '%" + text1 + "%'" 
		sql = sql + "OR buyer LIKE '%" + text1 + "%'"
		sql = sql + "OR other LIKE '%" + text1 + "%'"
		rs.open sql,conn,1,1
			if err.number <> 0 then
				response.write "���ݿ����"
			else
			response.write "<table align=center>"
				if rs.bof and rs.eof then
					rs.close
					response.write "<tr><td>û����Ҫ���ҵ��Լ���¼�������²���</td></tr></table>"
				else
					rs.MoveFirst
	response.write "<table align=center border=5 bodercolor=#ffaa00 frame=box><tr><th><font size=2>ID</font></th><th><font size=2>������</font></th><th><font size=2>Ӣ����</font></th><th><font size=2>CAS-No</font></th><th><font size=2>����ʽ</font></th><th><font size=2>������</font></th><th><font size=2>��ŵص�</font></th><th><font size=2>������</font></th><th><font size=2>��ע</font></th></tr>"
	do while Not rs.eof
		response.write "<td><font size=2>" + cstr(rs("ID")) + "</font></td>"
		if rs("cname") <> "" then
			response.write "<td><font size=2>" + rs("cname") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if cstr(rs("ename")) <> "" then
			response.write "<td align=right><font size=2>"  + rs("ename") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("casno") <> "" then
			response.write "<td><font size=2>" + rs("casno") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("mformula") <> "" then
			response.write "<td><font size=2>" + rs("mformula") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("mweight") <> "" then
			response.write "<td><font size=2>" + rs("mweight") + "</font></td>"
		else
			response.write "<td>" + "   " + "</td>"
		end if
		if rs("place") <> "" then
			response.write "<td><font size=2 color=red>" + rs("place") + "</font></td>"
		else
			response.write "<td><font size=2>" + " " + "</td>"
		end if
		if rs("buyer") <> "" then
			response.write "<td><font size=2 color=red>" + rs("buyer") + "</font></td>"
		else
			response.write "<td>" + " " + "</td>"
		end if
		if rs("other") <> "" then
			response.write "<td><font size=2>" + rs("other") + "</font></td></tr>"
		else
			response.write "<td>" + " " + "</td></tr>"
		end if
					rs.MoveNext
					loop
					response.write "</table>"
				end if
			end if
	end if
end if
%>
 
<%
set rs = nothing
call endconnection()
%>
<p>��</p>

</body>
</html>
