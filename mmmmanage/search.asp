<%@ Language=VBScript %>
<!--#include file="database1.asp"-->

<html>
<head>
<title>�����ѯϵͳ</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="t">
</head>
<body><!--msnavigation--><table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td>

<p align="center"><font size="6"><strong></strong></font><br>
</p>
<p align="center">&nbsp;</p>

</td></tr><!--msnavigation--></table><!--msnavigation--><table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><!--msnavigation--><td valign="top">
<h5 align="center">��</h5>

<h5 align="center"><font face="����" size="6"> �����ѯϵͳ</font></h5>

<form "frm_sch" action="search.asp" method="POST">
<table align=center cellspacing="0" border="0" width="754" cellpadding="0">

<tr>
    <td width=215>
      <p align="right"><b><font size="2">�������ݣ�</font></b></p>
    </td>
    <td width=531> <font size="2"> <input type="Text" name="text" size=34 >�����������λ���κ��ֶν��в�ѯ��</font>
    </td>
</tr>
<tr><td align=center colspan="2" width="717" >
<input type="Hidden" name="action" value= "newsave" >
    <p>
<input type="Submit" name="editsave" value="����"></p>
  </td></tr>  
</table>
</form>
<%
dim curaction,rs,text1,tmp
dim sql
curaction = request("action")
set rs = server.createobject("adodb.recordset")
if curaction = "newsave" then
text1 = request("text")
	if text1 = "" then
		response.write "����������ַ���"
	else
		sql = "SELECT * FROM dxkx WHERE lkdw like '%" + text1 + "%'"
		sql = sql + "OR skdw LIKE '%" + text1 + "%'"
		sql = sql + "OR yongtu LIKE '%" + text1 + "%'" 
		rs.open sql,conn,1,1
			if err.number <> 0 then
				response.write "���ݿ����"
			else
			response.write "<table align=center>"
				if rs.bof and rs.eof then
					rs.close
					response.write "<tr><td>û����Ҫ���ҵ���У��������²���</td></tr></table>"
				else
					rs.MoveFirst
					response.write "<table align=center border=5 bodercolor=#ffaa00 frame=box><tr><th><font size=2>���λ</font></th><th><font size=2>���</font></th><th><font size=2>�տ�ʱ��</font></th><th><font size=2>�տλ</font></th><th><font size=2>��;</font></th><th><font size=2>���в�״̬</font></th><th><font size=2>����״̬</font></th></tr>"
					do while Not rs.eof
					if rs("kybstate") = "δ��" OR rs("cwbstate") = "δ��" then
					if rs("lkdw") <> "" then
			           tmp = rs("lkdw")
			           tmp = replace( tmp, text1, "<font color=Maroon ><b>"+text1+"</b></font>" )
			           response.write "<tr><td><font size=2>" + tmp + "</font></td>"
			        else
			           response.write "<tr><td>" + " " + "</td>"
		            end if
                    if cstr(rs("jine")) <> "" then
			           response.write "<td align=right><font size=2>" + cstr(FormatCurrency(rs("jine"),0)) + "</font></td>"
			        else
			           response.write "<td>" + " " + "</td>"
		            end if
		            if rs("sksj") <> "" then
			           response.write "<td><font size=2>" + rs("sksj") + "</font></td>"
		            else
			           response.write "<td>" + " " + "</td>"
		            end if
		    	   	if rs("skdw") <> "" then
			           tmp = rs("skdw")
			           tmp = replace( tmp, text1, "<font color=Maroon><b>"+text1+"</b></font>" )
			           response.write "<td><font size=2>" + tmp + "</font></td>"
		            else
			           response.write "<td>" + " " + "</td>"
		            end if
		            if rs("yongtu") <> "" then
			           tmp = rs("yongtu")
			           tmp = replace( tmp, text1, "<font color=Maroon><b>"+text1+"</b></font>" )
			           response.write "<td><font size=2>" + tmp + "</font></td>"
		            else
			           response.write "<td>" + "   " + "</td>"
		            end if
		            if rs("kybstate") <> "" then
				       	if rs("kybstate") = "�Ѳ�" then
					   	response.write "<td><font size=2 color=red>" + rs("kybstate") + "</font></td>"
				       	else
					   	response.write "<td><font size=2 color=black>" + rs("kybstate") + "</font></td>"
				 	   	end if
		         	else
			          	response.write "<td><font size=2>" + " " + "</td>"
		      		end if
					if rs("cwbstate") <> "" then
						if rs("cwbstate") = "�Ѳ�" then
						response.write "<td><font size=2 color=red>" + rs("cwbstate") + "</font></td>"
						else
						response.write "<td><font size=2 color=black>" + rs("cwbstate") + "</font></td>"
						end if
					else
						response.write "<td>" + " " + "</td></tr>"
					end if
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
<!--msnavigation--></td></tr><!--msnavigation--></table></body>
</html>
