<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%@ page import="weaver.general.Util" %>
<%
String id = Util.null2String(request.getParameter("userid"));
RecordSet.executeProc("HrmResource_SelectByID",id);
RecordSet.next();
String lastname = RecordSet.getString("lastname") ;/*����*/
String loginid = RecordSet.getString("loginid"); ;/*��¼��*/
out.print(lastname+","+loginid);
%>