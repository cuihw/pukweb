<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="database1.asp"-->

<html>
<head>
<title>管理密码</title>
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>

<% 
if request("action") = "修改密码" then

dim rs, sql
dim OldPassword  
dim newPassword  
dim newPassword1

oldPassword=request("oldpasswd")
newPassword=request("newpasswd")
newPassword1=request("newpasswd1")
  
if newPassword="" or len(newPassword)>10 then
	response.write "<script language=javascript> alert('新的密码不能为空并且长度不能大于10。'); history.back(); </script>"
else
	if newPassword<>newPassword1 then
		response.write "<script language=javascript> alert('两次输入的密码不符。'); history.back(); </script>"
	else
        set rs=server.createobject("adodb.recordset")
        sql="select * from siteman where uid='" & session("uid") & "' and pwd ='"&OldPassword&"'"
        rs.open sql,conn,1,1
        if err.number<>0 then 
	        response.write "<script language=javascript> alert('数据库操作失败。'); history.back(); </script>"
        else
	        if rs.bof and rs.eof then
		        response.write "<script language=javascript> alert('旧的密码错误。'); history.back(); </script>"
	        else
		        sql = "UPDATE siteman SET pwd = '" + newPassword + "' where uid='" & session("uid") & "' "
		        conn.execute sql
		        if not err.number<>0 then 
			        response.write "<script language=javascript> alert('密码修改成功。'); history.back(); </script>"
		        else 
		            response.write "<script language=javascript> alert('数据库操作失败，请以后再试。'); history.back(); </script>"
		        end if
	        end if		
        end if
	end if
end if

end if
 %>
<form method="POST" name="frmChangePass" action="adminpwd.asp">
  <p align="center"><font class=big_title><b>更改你的密码</b></font></p>
  <p align="center">
  旧的密码: <input  name="oldpasswd" size="10" maxlength="10" type="password" value><br>   
  新的密码: <input  name="newpasswd" size="10" maxlength="10" type="password" value><br>   
  密码校验: <input  name="newpasswd1" size="10" maxlength="10" type="password" value><br>   
  <br>
  <input type="submit" value="修改密码" name="action">
  <input type="reset" value="重写填写" name="action">   
</form>

<p>　</p>
</body>
</html>


