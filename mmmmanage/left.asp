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
<title>ҳ�����</title>
<meta HTTP-EQUIV="Content-topic" content="text/html; charset=gb2312">
<base target="content">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>
<div align="center" style="width: 80; height: 529"> 
  <p align="left">��</p>
  <p align="left">
  <font class="HIGH"><b><font face="����_GB2312">�û���</font></b><% =session("uid")%></font>
  </p>
  <p style="line-height: 200%"><font color="#FF0000">
          <a href="logout.asp"><font face="��Բ" color="#FF0000">ע����¼</font></a><br>
  </font>
  </p>
  <div align="center" >
  <table width="80" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><center><b><font class="HIGH" face="����_GB2312">�����û�����</font></b><br>
        </center>
        <p style="line-height: 200%" align="center"><font color="#008000">
          <a href="adminpwd.asp"><font face="��Բ" color="#008000">��������</font></a><br>
        </p>
        </font>
        <p><center><b><font class="HIGH" face="����_GB2312">�����Լ���¼</font></b>
        </center>
        </p>
        <font color="#008000">
        <p style="line-height: 200%" align="center">
        <a href="searchre.asp"><font face="��Բ" color="#008000">��ѯ��¼</font></a><br>
        <a href="add.asp"><font face="��Բ" color="#008000">��Ӽ�¼</font></a><br>
        <a href="revise.asp"><font face="��Բ" color="#008000">�޸ļ�¼</font></a><br>
          <a href="delete.asp"><font face="��Բ" color="#008000">ɾ����¼</font></a>
        </p>
        </font>
      </td>
    </tr>
  </table>
  </div>
  </div>
��</body>
</html>