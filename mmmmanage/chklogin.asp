<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<%
	dim sql
	dim rs
	
	set rs=server.createobject("adodb.recordset")
	sql="select * from siteman where uid='" & request("uid") & "' and pwd='" & request("password") & "' "
    rs.open sql,conn,1,1
    if err.number<>0 then 
		response.write "���ݿ����ʧ�ܣ�"&err.description
    else
		if rs.bof and rs.eof then
			response.write "<script language=javascript> alert('�Բ�����������ȷ���û����Ϳ��'); history.back(); </script>"
   			rs.close
	    else
			if rs.RecordCount<1 then
		        response.write "<script language=javascript> alert('�Բ�����������ȷ���û����Ϳ��'); history.back(); </script>"
			    rs.close		    
			else
				session("adminOK")="true"
				session("uid") = rs("uid")
				rs.Close
				set rs=nothing
				call endConnection()
				Response.Redirect "main.html"
			end if
		end if
	end if
	set rs=nothing
	
	call endConnection()	
%>