<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="chkadmin.asp"-->

<html>
<head>
<title>����Զ�̹���</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body topmargin="30">

<% 
dim curaction,rs
dim sql
curaction = request("action")

if curaction = "newsave" then
  		sql = "DELETE FROM reagent WHERE ID=" + Request("ID")
     if IsNumeric(request("ID")) then
		conn.execute sql
		if err.number <> 0 then
			response.write "<script language=javascript> alert('�޷�ɾ��,���ݿ��������'); history.back(); </script>"
		else
		   Response.write "<script language=javascript> alert('��¼�Ѿ�ɾ����'); </script>"
		end if
	else
		response.write "<script language=javascript> alert('������������ID��'); history.back(); </script>"
   end if
end if

%>

<form action="delete.asp" method="POST">
<p align=center style="line-height: 0.8"><font size="4"><b><font class=big_title face="�����������" color="#800080">&nbsp;&nbsp;&nbsp;   
ɾ����¼</font></b>&nbsp;&nbsp;&nbsp;<b><font class="big_title" size="4" face="�����������" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="�����������">ɾ����ˢ��</font></a><font face="�����������">&nbsp;</font></font></p>
<table align=center cellspacing="0" cellpadding="0" border="0" width="609">

<tr>
    <td width=200 align="left"><p align="center"><b><font size="2">Ҫɾ���ļ�¼ID��</font></b></p>
    </td>
    <td width=405 align="left"> <input type="Text" name="ID" size=37 ></td>
</tr>
<tr><td align=center colspan="2" width="570" >
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="ȷ��ɾ��">
<input type="Reset" value="������д"></td></tr>                  
</table>

</form>

<% 
set rs = nothing
call endconnection()
 %>

<p>��</p>

</body>

























































