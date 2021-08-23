<%@ Language=VBScript %>
<!--#include file="database1.asp"-->

<html>
<head>
<title>来款查询系统</title>
<meta HTTP-EQUIV="Content-type" content="text/html; charset=gb2312">
<meta name="Microsoft Theme" content="none, default">
<meta name="Microsoft Border" content="none">
</head>
<body topmargin="15">
<h5 align="center"><font face="隶书" size="5"> 来款查询系统</font></h5>

<form "frm_sch" action="searchsuper.asp" method="POST">
<table align=center cellspacing="0" border="0" width="721" cellpadding="0">

<tr>
    <td width=184>
      <p align="right"><b><font size="2">检索字段：</font></b></p>
    </td>
    <td width=529> <font size="2"> <input type="Text" name="text" size=54 ></font>
    </td>
</tr>
<tr><td align=center colspan="2" width="717" >
<input type="Hidden" name="action" value= "newsave" >
    <p align="left" style="margin-top: 2; margin-bottom: 2">
<font size="2" face="楷体_GB2312">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
（请输入来款记录中的任何字段即可。）</font></p>
    <p style="margin-top: 2; margin-bottom: 2">
<input type="Submit" name="editsave" value="检索"></p>
  </td></tr>  
</table>

</form>

<% 
dim curaction,rs,text1
dim sql
curaction = request("action")
set rs = server.createobject("adodb.recordset")
if curaction = "newsave" then
text1 = request("text")
	if text1 = "" then
		response.write "请输入检索字符串"
	else
		sql = "SELECT * FROM dxkx WHERE lkdw like '%" + text1 + "%'"
		sql = sql + "OR jine LIKE '%" + text1 + "%'"
		sql = sql + "OR sksj LIKE '%" + text1 + "%'"
		sql = sql + "OR skdw LIKE '%" + text1 + "%'"
		sql = sql + "OR yongtu LIKE '%" + text1 + "%'" 
		sql = sql + "OR kybstate LIKE '%" + text1 + "%'" 
		sql = sql + "OR cwbstate LIKE '%" + text1 + "%'"
		sql = sql + "OR other LIKE '%" + text1 + "%'"
		rs.open sql,conn,1,1
			if err.number <> 0 then
				response.write "数据库出错"
			else
			response.write "<table align=center>"
				if rs.bof and rs.eof then
					rs.close
					response.write "<tr><td>没有您要查找的来校款项，请重新查找</td></tr></table>"
				else
					rs.MoveFirst
					response.write "<table align=center border=5 bodercolor=#ffaa00 frame=box><tr><th><font size=2>ID</font></th><th><font size=2>来款单位</font></th><th><font size=2>金额</font></th><th><font size=2>收款时间</font></th><th><font size=2>收款单位</font></th><th><font size=2>用途</font></th><th><font size=2>科研部状态</font></th><th><font size=2>财务部状态</font></th><th><font size=2>备注</font></th></tr>"
					do while Not rs.eof
					   response.write "</tr><td><font size=2>" + cstr(rs("ID")) + "</font></td>"
					if rs("lkdw") <> "" then
			           tmp = rs("lkdw")
			           tmp = replace( tmp, text1, "<font color=red><b>"+text1+"</b></font>" )
			           response.write "<td><font size=2>" + tmp + "</font></td>"
			        else
			           response.write "<td>" + " " + "</td>"
		            end if
                    if cstr(rs("jine")) <> "" then
			           response.write "<td align=right><font size=2>" + cstr(FormatCurrency(rs("jine"),0)) + "</font></td>"
		            else
			           response.write "<td>" + " " + "</td>"
		            end if
		            if rs("sksj") <> "" then
			           response.write "<td><font size=2>" + rs("sksj") + "</font></td>"
		            else
			           response.write "<td>" + " " + "</td>"
		            end if
		    	   	if rs("skdw") <> "" then
			           response.write "<td><font size=2>" + rs("skdw") + "</font></td>"
		            else
			           response.write "<td>" + " " + "</td>"
		            end if
		            if rs("yongtu") <> "" then
			           response.write "<td><font size=2>" + rs("yongtu") + "</font></td>"
		            else
			           response.write "<td>" + "   " + "</td>"
		            end if
		            if rs("kybstate") <> "" then
				       	if rs("kybstate") = "已拨" then
					   	response.write "<td><font size=2 color=red>" + rs("kybstate") + "</font></td>"
				       	else
					   	response.write "<td><font size=2 color=black>" + rs("kybstate") + "</font></td>"
				 	   	end if
		         	else
			          	response.write "<td><font size=2>" + " " + "</td>"
		      		end if
					if rs("cwbstate") <> "" then
						if rs("cwbstate") = "已拨" then
						response.write "<td><font size=2 color=red>" + rs("cwbstate") + "</font></td>"
						else
						response.write "<td><font size=2 color=black>" + rs("cwbstate") + "</font></td>"
						end if
					else
						response.write "<td>" + " " + "</td></tr>"
					end if
					if rs("other") <> "" then
			           response.write "<td><font size=2>" + rs("other") + "</font></td>"
			        else
			           response.write "<td>" + " " + "</td>"
		            end if
					rs.MoveNext
					loop
					response.write "</table>"
				end if
			end if
	end if
end if
%>
 
<%
set rs = nothing
call endconnection()
%>
<p>　</p>
</body>
</html>
