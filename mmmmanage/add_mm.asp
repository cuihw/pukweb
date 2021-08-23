<%@ Language=VBScript CODEPAGE="936" %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="jsonObject.class.asp" -->

<% 
    dim JSON
    set JSON = New JSONobject

    ' check the user sessionId was legal
    dim sessionId, isLogin
    sessionId = request("sessionId")
    isLogin = verifySessionId(sessionId)

    if isLogin = False then
        JSON.add "ret",  "error"
        Log "user was not login"
        message = "user was not login"
    else
        '========================================
        '添加记录
        dim curaction, rs , sql
        dim cname, ename,casno,mformula,mweight, place, buyer, other , message
        cname = request("cname")
        ename = request("ename")
        casno = request("casno")
        mformula = request("mformula")
        mweight = request("mweight")
        place = request("place")
        buyer = request("buyer")
        other = request("other")
    
        Log "ready to write database."
        Log "mweight: "& mweight
        if  trim(cname) ="" or trim(ename) ="" or trim(mweight) ="" or trim(place) =""  then
            message = "cname， ename, mweitht, plase can not be empty string. "
        elseif  IsNumeric(mweight) = True then
            Log "get sql statement."
            ' Mobile will check the varity cname, ename ,mweight, place and  IsNumeric mweight
            sql = "INSERT INTO reagent(cname,ename,casno,mformula,mweight,place,buyer,other) VALUES("
   	        sql = sql + "'" + cname + "',"
	        sql = sql + "'" + ename + "',"
	        sql = sql + "'" + casno + "',"
	        sql = sql + "'" + mformula + "',"
	        sql = sql + "'" + mweight + "',"
	        sql = sql + "'" + place + "',"
	        sql = sql + "'" + buyer + "',"
	        sql = sql + "'" + other + "')"
	        conn.execute(sql)

	        if err.number <> 0 then
                message = "无法保存,数据库操作出错"
                JSON.add "ret", "error"
                Log "database error"
	        else
                message = "记录已经添加到数据库"
                JSON.add "ret", "ok"
                Log "database OK"
	        end if
        else 
             message = "mweight was not numberic"
        end if 
        JSON.add "message", message
        set rs = nothing
        call endconnection()
    end if
    
    response.write JSON.write()

 %>
