<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="chkadmin.asp"-->

<html>
<head>
<title>����Զ�̸��¹���</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body topmargin="20">

<% 
dim curaction,rs
dim sql
curaction = request("action")

'��Ӽ�¼
if curaction = "newsave" then
  	if trim(request("cname")) = "" then
		response.write "<script language=javascript> alert('�������Լ���������'); history.back(); </script>"
	end if
	if trim(request("ename")) = "" then
		response.write "<script language=javascript> alert('�������Լ�Ӣ����'); history.back(); </script>"
	end if
	if trim(request("mweight")) = "" then
		response.write "<script language=javascript> alert('�������������'); history.back(); </script>"
	end if
	if trim(request("place")) = "" then
		response.write "<script language=javascript> alert('�������ŵص㣡'); history.back(); </script>"
	end if
  if IsNumeric(request("mweight")) then
	sql = "INSERT INTO reagent(cname,ename,casno,mformula,mweight,place,buyer,other) VALUES("
	sql = sql + "'" + request("cname") + "',"
	sql = sql + "'" + request("ename") + "',"
	sql = sql + "'" + request("casno") + "',"
	sql = sql + "'" + request("mformula") + "',"
	sql = sql + "'" + request("mweight") + "',"
	sql = sql + "'" + request("place") + "',"
	sql = sql + "'" + request("buyer") + "',"
	sql = sql + "'" + request("other") + "')"
	conn.execute(sql)
	if err.number <> 0 then
		response.write "<script language=javascript> alert('�޷�����,���ݿ��������'); history.back(); </script>"
	else
		response.write "<script language=javascript> alert('��¼�Ѿ���ӵ����ݿ⡣'); </script>"
	end if
  else
    response.write "<script language=javascript> alert('��������������������'); history.back(); </script>"
  end if
end if
%>


<form action="add.asp" method="POST">
<p align=center style="line-height: 0.8"><font size="4"><b><font class=big_title face="�����������" color="#800080">��Ӽ�¼</font></b>&nbsp;&nbsp;<b><font class="big_title" size="4" face="�����������" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="�����������">��Ӻ�ˢ��</font></a><font face="�����������">&nbsp;&nbsp;</font></font></p>
<table align=center cellspacing="0" border="0" width="913" cellpadding="0">

<tr>
    <td width=99 align="right"><b><font size="2">��������</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="cname" size=78 >
      <font color="#FF0000">*</font></font>
      </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">Ӣ������</font></b></td>
    <td width=814><font size="2"> <input type="Text" name="ename" size=78 >  <font color="#FF0000">*</font></font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">CAS-No��</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="casno" size=78 >  </font></td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">����ʽ��</font></b></td>
    
    <td width=814> <font size="2"> <input type="Text" name="mformular" size=78 >  
      <font color="#FF0000">*</font>
      </font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">��������</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="mweight" size=78 >  &nbsp;  
    </font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">��ŵص㣺</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="place" size=78 >  <font color="#FF0000">*</font>
	</font>
	</td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">�����ˣ�</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="buyer" size=78 > 
	</font>
	</td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">��ע��</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="other" size=78 >
      </font>
    </td>
</tr>

<tr><td align=center colspan="2" width="772" >
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="���">
<input type="Reset" value="������д"></td></tr>                      
</table>

</form>
<% 
set rs = nothing
call endconnection()
 %>

<p>��</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<font size="2"><font color="#FF0000">*</font></font>&nbsp; 
��ʾ������Ŀ�����п��ܣ�����Լ����ࣨ���࣬����ȣ��͹����������뱸ע���Ա�������</p>
</body>
