<%@ Language=VBScript %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="Crypto.Class.asp" -->
<!--#include file ="jsonObject.class.asp" -->

<% 
' check the session was legal.
' check the id was right.
' check the data format was correctly.
' update the data item.

dim sql
dim JSON
set JSON = New JSONobject

    ' check the user sessionId was legal
    dim sessionId, isLogin , message, ret
    sessionId = request("sessionId")
    isLogin = verifySessionId(sessionId)
    
    if isLogin = False then
        ret = "error"
        message = "user was not login"
    else
        '========================================
        ' modify data
        dim cname, ename,casno,mformula,mweight, place, buyer, other ,  id

        cname = request("cname")
        ename = request("ename")
        casno = request("casno")
        mformula = request("mformula")
        mweight = request("mweight")
        place = request("place")
        buyer = request("buyer")
        other = request("other")
        id = Request("ID")

        sql = "UPDATE reagent SET cname='" + cname + "',"
        sql = sql + "'" + ename + "',"
        sql = sql + "'" + casno + "',"
        sql = sql + "'" + mformula + "',"
        sql = sql + "'" + mweight + "',"
        sql = sql + "'" + place + "',"
        sql = sql + "'" + buyer + "',"
        sql = sql + "'" + other + "'"
	    sql = sql + "WHERE ID=" + id

	    conn.execute sql
        if err.number <> 0 then
            ret = "error"
            message = "update data failed."
        else 
            ret = "ok"
            message = "update data sucessed."
        end if
    end if

    JSON.add "ret", ret
    JSON.add "message", message
    set sql = nothing

    call endconnection()

    response.write JSON.write()
%>










































