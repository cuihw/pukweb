   <%
   dim conn  
   dim connstr
   
   'on error resume next
   call conn_init()

   sub conn_init()
       on error resume next
       connstr="DBQ="+server.mappath("redatas.mdb")+";DRIVER={Microsoft Access Driver (*.mdb)};"       
       set conn=server.createobject("ADODB.CONNECTION")
       if err.number<>0 then 
           err.clear
           set conn=nothing
		   response.write "数据库连接出错！"
		   Response.End
       else
           conn.open connstr
           if err then 
              err.clear
              set conn=nothing
			  response.write "数据库连接出错！"
              Response.End 
           end if
       end if   
    end sub
	
  sub endConnection()
      conn.close
      set conn=nothing
  end sub
  
  public Function updateSessionIdsql(ByVal sessionId, ByVal name)
       dim sql
       sql = "UPDATE siteman SET sessionId='"+ sessionId +  "'  " + "WHERE uid='" + name + "'"
	   conn.execute sql
       '函数的返回值是通过函数名来返回的
       updateSessionIdsql = err.number
  end Function

  public Function verifySessionId(ByVal sessionId) 
       verifySessionId = False
       dim sql, rs
       sql = "SELECT * FROM siteman WHERE sessionId='"+ sessionId +  "'"
       set rs=server.createobject("adodb.recordset")
       rs.open sql,conn,1,1
       if rs.RecordCount > 0 then
	       verifySessionId = true
       end if
  end Function

%>