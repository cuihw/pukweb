<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="database1.asp"-->

<html>
<head>
<title>��������</title>
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body>

<% 
if request("action") = "�޸�����" then

dim rs, sql
dim OldPassword  
dim newPassword  
dim newPassword1

oldPassword=request("oldpasswd")
newPassword=request("newpasswd")
newPassword1=request("newpasswd1")
  
if newPassword="" or len(newPassword)>10 then
	response.write "<script language=javascript> alert('�µ����벻��Ϊ�ղ��ҳ��Ȳ��ܴ���10��'); history.back(); </script>"
else
	if newPassword<>newPassword1 then
		response.write "<script language=javascript> alert('������������벻����'); history.back(); </script>"
	else
        set rs=server.createobject("adodb.recordset")
        sql="select * from siteman where uid='" & session("uid") & "' and pwd ='"&OldPassword&"'"
        rs.open sql,conn,1,1
        if err.number<>0 then 
	        response.write "<script language=javascript> alert('���ݿ����ʧ�ܡ�'); history.back(); </script>"
        else
	        if rs.bof and rs.eof then
		        response.write "<script language=javascript> alert('�ɵ��������'); history.back(); </script>"
	        else
		        sql = "UPDATE siteman SET pwd = '" + newPassword + "' where uid='" & session("uid") & "' "
		        conn.execute sql
		        if not err.number<>0 then 
			        response.write "<script language=javascript> alert('�����޸ĳɹ���'); history.back(); </script>"
		        else 
		            response.write "<script language=javascript> alert('���ݿ����ʧ�ܣ����Ժ����ԡ�'); history.back(); </script>"
		        end if
	        end if		
        end if
	end if
end if

end if
 %>
<form method="POST" name="frmChangePass" action="adminpwd.asp">
  <p align="center"><font class=big_title><b>�����������</b></font></p>
  <p align="center">
  �ɵ�����: <input  name="oldpasswd" size="10" maxlength="10" type="password" value><br>   
  �µ�����: <input  name="newpasswd" size="10" maxlength="10" type="password" value><br>   
  ����У��: <input  name="newpasswd1" size="10" maxlength="10" type="password" value><br>   
  <br>
  <input type="submit" value="�޸�����" name="action">
  <input type="reset" value="��д��д" name="action">   
</form>

<p>��</p>
</body>
</html>


