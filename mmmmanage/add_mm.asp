<%@ Language=VBScript  %>
<% option explicit %>
<!--#include file="database1.asp"-->
<!--#include file="Jslog.asp"-->
<!--#include file ="jsonObject.class.asp" -->

<% 
    dim JSON
    set JSON = New JSONobject

    ' check the user sessionId was legal
    dim sessionId, isLogin, ret,message
    sessionId = request("sessionId")
    isLogin = verifySessionId(sessionId)

    if isLogin = False then
        ret = "error"
        message = "user was not login"
    else
        '========================================
        'Ìí¼Ó¼ÇÂ¼
        dim curaction, rs , sql
        dim cname, ename,casno,mformula,mweight, place, buyer, other
        cname = request("cname")
        ename = request("ename")
        casno = request("casno")
        mformula = request("mformula")
        mweight = request("mweight")
        place = request("place")
        buyer = request("buyer")
        other = request("other")
    
        if  trim(cname) ="" or trim(ename) ="" or trim(mweight) ="" or trim(place) =""  then
            message = "cname£¬ ename, mweitht, plase can not be empty string. "
        elseif  IsNumeric(mweight) = True then
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
                message = "can not add a record, database error"
                ret = "error"
	        else
                message = "Data was added successfully."
                ret = "ok"
	        end if
        else 
             message = "mweight was not numberic"
        end if 
        set rs = nothing
        call endconnection()
    end if

    JSON.add "ret",  ret
    JSON.add "message", message

    response.write JSON.write()
 %>
