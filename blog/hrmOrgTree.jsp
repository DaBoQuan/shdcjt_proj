<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.blog.HrmOrgTree"%>
<%
HrmOrgTree hrmOrg=new HrmOrgTree(request,response);
String root = Util.null2String(request.getParameter("root"));
response.setContentType("application/x-json; charset=UTF-8");
PrintWriter outPrint = response.getWriter();
outPrint.println(hrmOrg.getTreeData(root));
%>

