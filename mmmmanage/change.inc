<% 
dim THCOLOR, TDCOLORD, TDCOLORL, TBCOLOR, BGCOLOR,HBARCOR
dim homepage
HBARCOR="#ddeedd"
THCOLOR = "#ffffff"		'表头颜色
TDCOLORD = "#ffffff"	'深色表格单元格颜色
TDCOLORL = "#ffffff"	'浅色表格单元格颜色
TBCOLOR = "#ffffff"		'表格边框颜色
BGCOLOR = "#ffffff"		'背景色


dim FIRSTNO, PERPAGE
FIRSTNO = 6	'首页显示新闻个数
PERPAGE = 10	'每页显示记录数

function htmlencode(str)
	htmlencode=replace( str,"'","''")
end function
%>