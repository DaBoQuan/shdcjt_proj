<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />


<%
	String toPage="/hrm/report/HrmRp.jsp?reporttype=H";
	if(software.equals("CRM")) toPage="/CRM/CRMReport.jsp?reporttype=C";
	else if(software.equals("KM")) toPage="/docs/report/DocRp.jsp?reporttype=D";
	response.sendRedirect(toPage);
%>