<%@ Language=VBScript %>
<html>

<head>
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb2312">
<title>MMM组试剂管理系统</title>
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none, default">
</head>

<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="33%">
  <tr> <form method="POST" action="chklogin.asp" name="frmLogin">
    <td width="100%" colspan="2">
      <p align="center">　</p>
      <p align="center"><font color="#800000" face="华文隶书" size="5">管理人员登录</font></p>
      <p align="center">
          <br></p>
    </td>
  </tr>
  <tr> 
    <td width="27%" nowrap align="center"><font face="汉鼎简隶变" color="#800080"><b>管理员名称：</b></font></td>
    <td width="73%" nowrap align="left"> 
      <p align="left"> 
      <input type="text" name="uid" size="15" class="smallInput">
      </p>
    </td>

  </tr>
  <tr> 
    <td width="27%" nowrap align="center"><font face="汉鼎简隶变" color="#800080"><b>管理员密码：</b></font></td>
          
  </center>
          
    <td width="73%" nowrap align="left"> 
      <p align="left"> 
      <input type="password" name="password" size="15" class="smallInput">
      </p>
  </td>
  </tr>
  <center>
  <tr height="20"> 
    <td width="100%" align="right" colspan="2"></td>
  </tr>
  <tr> 
    <td width="100%" align="center" colspan="2"> 
      <input type="submit" value="  确定登录  " name="cmdOk" class="buttonface">
    </td>
        </tr>
      </table>
  </center>
</div>
    </form>
<script type="" language="JavaScript">
	document.frmLogin.password.focus()
</script>
<p>
</html>
