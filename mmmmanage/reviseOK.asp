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
<body topmargin="10">

<% 
dim curaction,rs,rs1
dim sql, sql1

curaction = request("action")

if curaction = "newsave" then
	sql = "UPDATE reagent SET cname='" + request("cname") + "',"
	sql = sql + "ename='" + request("ename") + "',"
	sql = sql + "casno='" + request("casno") + "',"
	sql = sql + "mformula='" + request("mformula") + "',"
	sql = sql + "mweight='" + request("mweight") + "',"
	sql = sql + "place='" + request("place") + "',"
	sql = sql + "buyer='" + request("buyer") + "',"
	sql = sql + "other='" + request("other") + "' " 
	sql = sql + "WHERE ID=" + Request("ID")
	conn.execute sql
	if err.number <> 0 then
		response.write "<script language=javascript> alert('�޷�����,���ݿ��������'); history.back(); </script>"
	else
		response.write "<script language=javascript> alert('��¼�Ѿ��޸ġ�'); </script>"
	end if
end if

%>

<%
dim tmpID, flag
	set rs1 = server.createobject("adodb.recordset")
    flag=0
if IsNumeric(request("IDW")) then
    if Request("IDW") <> 0 then
    tmpID=Request("IDW")
    sql1 = "SELECT * FROM reagent WHERE ID=" + tmpID 
	rs1.open sql1, conn, 1, 1
	else
	sql1 = "SELECT * FROM reagent WHERE ID=" + Request("ID")
	rs1.open sql1, conn, 1, 1
	end if
  else
  	response.write "<script language=javascript> alert('������������ID��'); history.back(); </script>"
  end if
%>

<form action="reviseOK.asp" method="POST">
<p align=left style="line-height: 0.2"><b><font class=big_title size="4" face="�����������" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
�޸ļ�¼</font></b>&nbsp;&nbsp;&nbsp;<b><font class="big_title" size="4" face="�����������" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="�����������">�޸ĺ�ˢ��</font></a></p>
<table align=center cellspacing="0" cellpadding="0" border="0" width="1172">
<tr>
    <td width="120" align="right" nowrap>
      <p align="left"><b><font size="2">��¼ID��</font></b></p>
    </td>
    <td width="1048"> 
      <p align="left"> <font size="2"> 
	<input type="Text" name="ID" size=78 value='<%=rs1("ID")%>' > </font></p>
    </td>
</tr>

</table><table align=center cellspacing="0" cellpadding="0" border="0" width="1172" height="217">

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">��������</font></b></p>
    </td>
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="cname" size=78 value='<%=rs1("cname")%>' >
      <font color="#FF0000">*</font></font>
      </p>
      </td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">Ӣ������</font></b></p>
    </td>
    <td width=1047>
      <p align="left"><font size="2"> <input type="Text" name="ename" size=78 value='<%=rs1("ename")%>' >  
      <font color="#FF0000">*</font></font></p>
    </td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">CAS-No��</font></b></p>
    </td>
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="casno" size=78 value='<%=rs1("casno")%>' >  </font></p>
    </td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">����ʽ��</font></b></p>
    </td>
    
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="mformular" size=78 value='<%=rs1("mformula")%>' > 
      <font color="#FF0000">*</font></font></p>
    </td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">��������</font></b></p>
    </td>
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="mweight" size=78 value='<%=rs1("mweight")%>' >  &nbsp;</font></p>
    </td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">��ŵص㣺</font></b></p>
    </td>
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="place" size=78 value='<%=rs1("place")%>' >  
      <font color="#FF0000">*</font></font></p>
	</td>
</tr>

<tr>
    <td width=121 align="right" height="23" nowrap>
      <p align="left"><b><font size="2">�����ˣ�</font></b></p>
    </td>
    <td width=1047 height="23"> 
      <p align="left"> <font size="2"> <input type="Text" name="buyer" size=78 value='<%=rs1("buyer")%>' > 
	</font>
      </p>
	</td>
</tr>

<tr>
    <td width=121 align="right" nowrap>
      <p align="left"><b><font size="2">��ע��</font></b></p>
    </td>
    <td width=1047> 
      <p align="left"> <font size="2"> <input type="Text" name="other" size=78 value='<%=rs1("other")%>' >
      </font>
      </p>
    </td>
</tr>

<tr><td align=center colspan="2" width="1170" >
<p align="center">
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="�޸�">
<input type="Reset" value="������д"></p> 
  </td></tr>              
</table>

</form>
<% 
set rs = nothing
set rs1 = nothing
call endconnection()
 %>
 
<p align="left"><font color="#FF0000" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
*</font>&nbsp; 
��ʾ������Ŀ�����п��ܣ�����Լ����ࣨ���࣬����ȣ��͹����������뱸ע���Ա�������</p>
 
</body>









































