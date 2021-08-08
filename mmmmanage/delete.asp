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
			response.write "<script language=javascript> alert('无法删除,数据库操作出错。'); history.back(); </script>"
		else
		   Response.write "<script language=javascript> alert('记录已经删除。'); </script>"
		end if
	else
		response.write "<script language=javascript> alert('请输入整数型ID！'); history.back(); </script>"
   end if
end if

%>

<form action="delete.asp" method="POST">
<p align=center style="line-height: 0.8"><font size="4"><b><font class=big_title face="方正隶变简体" color="#800080">&nbsp;&nbsp;&nbsp;   
删除记录</font></b>&nbsp;&nbsp;&nbsp;<b><font class="big_title" size="4" face="方正隶变简体" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="方正隶变简体">删除后刷新</font></a><font face="方正隶变简体">&nbsp;</font></font></p>
<table align=center cellspacing="0" cellpadding="0" border="0" width="609">

<tr>
    <td width=200 align="left"><p align="center"><b><font size="2">要删除的记录ID：</font></b></p>
    </td>
    <td width=405 align="left"> <input type="Text" name="ID" size=37 ></td>
</tr>
<tr><td align=center colspan="2" width="570" >
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="确认删除">
<input type="Reset" value="重新填写"></td></tr>                  
</table>

</form>

<% 
set rs = nothing
call endconnection()
 %>

<p>　</p>

</body>

























































