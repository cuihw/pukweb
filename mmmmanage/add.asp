<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="chkadmin.asp"-->

<html>
<head>
<title>数据远程更新管理</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body topmargin="20">

<% 
dim curaction,rs
dim sql
curaction = request("action")

'添加记录
if curaction = "newsave" then
  	if trim(request("cname")) = "" then
		response.write "<script language=javascript> alert('请输入试剂中文名！'); history.back(); </script>"
	end if
	if trim(request("ename")) = "" then
		response.write "<script language=javascript> alert('请输入试剂英文名'); history.back(); </script>"
	end if
	if trim(request("mweight")) = "" then
		response.write "<script language=javascript> alert('请输入分子量！'); history.back(); </script>"
	end if
	if trim(request("place")) = "" then
		response.write "<script language=javascript> alert('请输入存放地点！'); history.back(); </script>"
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
		response.write "<script language=javascript> alert('无法保存,数据库操作出错。'); history.back(); </script>"
	else
		response.write "<script language=javascript> alert('记录已经添加到数据库。'); </script>"
	end if
  else
    response.write "<script language=javascript> alert('分子量请输入正有理数'); history.back(); </script>"
  end if
end if
%>


<form action="add.asp" method="POST">
<p align=center style="line-height: 0.8"><font size="4"><b><font class=big_title face="方正隶变简体" color="#800080">添加记录</font></b>&nbsp;&nbsp;<b><font class="big_title" size="4" face="方正隶变简体" color="#800080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b><a href="displayup.asp" target="display"><font face="方正隶变简体">添加后刷新</font></a><font face="方正隶变简体">&nbsp;&nbsp;</font></font></p>
<table align=center cellspacing="0" border="0" width="913" cellpadding="0">

<tr>
    <td width=99 align="right"><b><font size="2">中文名：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="cname" size=78 >
      <font color="#FF0000">*</font></font>
      </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">英文名：</font></b></td>
    <td width=814><font size="2"> <input type="Text" name="ename" size=78 >  <font color="#FF0000">*</font></font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">CAS-No：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="casno" size=78 >  </font></td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">分子式：</font></b></td>
    
    <td width=814> <font size="2"> <input type="Text" name="mformular" size=78 >  
      <font color="#FF0000">*</font>
      </font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">分子量：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="mweight" size=78 >  &nbsp;  
    </font>
    </td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">存放地点：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="place" size=78 >  <font color="#FF0000">*</font>
	</font>
	</td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">购买人：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="buyer" size=78 > 
	</font>
	</td>
</tr>

<tr>
    <td width=99 align="right"><b><font size="2">备注：</font></b></td>
    <td width=814> <font size="2"> <input type="Text" name="other" size=78 >
      </font>
    </td>
</tr>

<tr><td align=center colspan="2" width="772" >
<input type="Hidden" name="action" value= "newsave" >
<input type="Submit" name="editsave" value="添加">
<input type="Reset" value="重新填写"></td></tr>                      
</table>

</form>
<% 
set rs = nothing
call endconnection()
 %>

<p>　</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<font size="2"><font color="#FF0000">*</font></font>&nbsp; 
表示必填项目，如有可能，请把试剂种类（酸类，醇类等）和购买日期填入备注，以便于搜索</p>
</body>
