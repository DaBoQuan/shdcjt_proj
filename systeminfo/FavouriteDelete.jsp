<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String id=Util.null2String(request.getParameter("id"));
RecordSet.executeProc("SysFavourite_DeleteByID",id);
response.sendRedirect("/system/HomePage.jsp");
%>