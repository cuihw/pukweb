<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="change.inc"-->
<!--#include file="chkadmin.asp"-->
<% 
dim rs, sql
set rs = server.createobject("adodb.recordset")
 %>
<html>
<head>
<title>页面管理</title>
<meta HTTP-EQUIV="Content-topic" content="text/html; charset=gb2312">
<base target="content">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>
<div align="center" style="width: 80; height: 529"> 
  <p align="left">　</p>
  <p align="left">
  <font class="HIGH"><b><font face="楷体_GB2312">用户：</font></b><% =session("uid")%></font>
  </p>
  <p style="line-height: 200%"><font color="#FF0000">
          <a href="logout.asp"><font face="幼圆" color="#FF0000">注销登录</font></a><br>
  </font>
  </p>
  <div align="center" >
  <table width="80" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><center><b><font class="HIGH" face="楷体_GB2312">管理用户属性</font></b><br>
        </center>
        <p style="line-height: 200%" align="center"><font color="#008000">
          <a href="adminpwd.asp"><font face="幼圆" color="#008000">管理密码</font></a><br>
        </p>
        </font>
        <p><center><b><font class="HIGH" face="楷体_GB2312">管理试剂记录</font></b>
        </center>
        </p>
        <font color="#008000">
        <p style="line-height: 200%" align="center">
        <a href="searchre.asp"><font face="幼圆" color="#008000">查询记录</font></a><br>
        <a href="add.asp"><font face="幼圆" color="#008000">添加记录</font></a><br>
        <a href="revise.asp"><font face="幼圆" color="#008000">修改记录</font></a><br>
          <a href="delete.asp"><font face="幼圆" color="#008000">删除记录</font></a>
        </p>
        </font>
      </td>
    </tr>
  </table>
  </div>
  </div>
　</body>
</html>