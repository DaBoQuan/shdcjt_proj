<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.docs.docs.*" %>
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;
try{
    //DocOfficeServer dos = new DocOfficeServer(request,response);
    DocServer dos = new DocDbServer(request,response);
    out.clear() ;
    dos.doCommand();
}catch(Exception ex){
    throw ex;
}
%>