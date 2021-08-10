<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="chkadmin.asp"-->

<html>
<head>
<title>数据远程管理</title>
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
		response.write "<script language=javascript> alert('无法保存,数据库操作出错。'); history.back(); </script>"
	else
		response.write "<script language=javascript> alert('记录已经修改。'); </script>"
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
  	response.write "<script language=javascript> alert('请输入整数型ID！'); history.back(); </script>"
  end if
%>

<form action="reviseOK.asp" method="POST">
<p align=right style="line-height: 0.2"><b><font class=big_title size="4" face="方正隶变简体" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
修改记录</font></b>&nbsp;&nbsp;&nbsp;<b><font class="big_title" size="4" face="方正隶变简体" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="方正隶变简体">修改后刷新</font></a></p>
<table align=center cellspacing="0" cellpadding="0" border="0" width="90%">
<tr>
    <td width="89" align="right" nowrap><b><font size="2">记录ID：</font></b></td>
    <td width="824"> <font size="2"> 
	<input type="Text" name="ID" size=78 value='<%=rs1("ID")%>' > （必填）</font></td>
</tr>

</table><table align=center cellspacing="0" cellpadding="0" border="0" width="90%" height="217">

<tr>
    <td width=89 align="right" nowrap><b><font size="2">试剂中文名：</font></b></td>
    <td width=824> <font size="2"> <input type="Text" name="cname" size=78 >
      （必填）</font>
      </td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">试剂英文名：</font></b></td>
    <td width=824><font size="2"> <input type="Text" name="ename" size=78 > （必填）</font>
    </td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">CAS-No：</font></b></td>
    <td width=824> <font size="2"> <input type="Text" name="casno" size=78 >  </font></td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">分子式：</font></b></td>
    
    <td width=824> <font size="2"> <input type="Text" name="mformular" size=78 > （必填）
      </font>
    </td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">分子量：</font></b></td>
    <td width=824> <font size="2"> <input type="Text" name="mweight" size=78 >  （正实数，必填）  
    </font>
    </td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">存放地点：</font></b></td>
    <td width=824> <font size="2"> <input type="Text" name="place" size=78 > （必填）
	</font>
	</td>
</tr>

<tr>
    <td width=89 align="right" height="23" nowrap><b><font size="2">购买人：</font></b></td>
    <td width=824 height="23"> <font size="2"> <input type="Text" name="buyer" size=78 > 
	</font>
	</td>
</tr>

<tr>
    <td width=89 align="right" nowrap><b><font size="2">备注：</font></b></td>
    <td width=824> <font size="2"> <input type="Text" name="other" size=78 >
      </font>
    </td>
</tr>

<tr><td align=center colspan="2" width="717" >
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="修改">
<input type="Reset" value="重新填写"></td></tr>              
</table>

</form>
<% 
set rs = nothing
set rs1 = nothing
call endconnection()
 %>
 
</body>









































