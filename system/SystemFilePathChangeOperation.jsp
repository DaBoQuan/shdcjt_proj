<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
User user = HrmUserVarify.getUser(request,response);
if(user == null)  return ;
%>

<%
    String srcPath = Util.null2String(request.getParameter("srcPath"));
    String targetPath = Util.null2String(request.getParameter("targetPath"));
    String strSql = "";
    String strSqlMoudle = "";
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<BODY>
<%
    out.println("&nbsp;&nbsp;����ִ�и���,���Ժ�...");
    if(RecordSet.getDBType().equals("oracle")){
         strSql = "update imagefile set filerealpath = REPLACE(filerealpath,'" + srcPath + "','" + targetPath +"')";
         strSqlMoudle = "update DocMouldFile set mouldpath = REPLACE(mouldpath,'" + srcPath + "','" + targetPath +"')";
    } else {
         strSql = "update imagefile set filerealpath = REPLACE(filerealpath,'" + srcPath + "','" + targetPath +"')";
         strSqlMoudle = "update DocMouldFile set mouldpath = REPLACE(mouldpath,'" + srcPath + "','" + targetPath +"')";
    }
    System.out.println("Execute update imagefile is "+strSql);
    System.out.println("Execute update DocMouldFile is "+strSqlMoudle);
    if (RecordSet.executeSql(strSql)&&RecordSet.executeSql(strSqlMoudle)){
        out.println("<br>&nbsp;&nbsp;�������!����������<a href=SystemFilePathChange.jsp>����</a>,�������ϵͳ���<a href=/index.htm>����</a>.");        
    } else {
        out.println("<br>&nbsp;&nbsp;<font color='red'>����ִ�в��ɹ�,����ϵͳ!</font>");
        System.out.println("ִ�����: "+ strSql +"   ���ɹ�");
    }
%>

</BODY>
</HTML>