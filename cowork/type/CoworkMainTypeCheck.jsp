<%@ page language="java" contentType="text/html; charset=GBK" %><%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" /><%
	
String coworkname = Util.null2String(java.net.URLDecoder.decode(request.getParameter("coworkname"),"UTF-8"));  //��ò���ҳ�洫�����Ĳ��� coworkname
String id = Util.null2String(request.getParameter("id"));

if (id != null && !"".equals(id))
		RecordSet.executeSql("select * from cowork_maintypes where typename='"+coworkname+"' and id != " + id); //�޸�״̬ʱ��id������й���
else
	  RecordSet.executeSql("select * from cowork_maintypes where typename='"+coworkname+"'");
	  	  
if (RecordSet.next()){
		out.print("exist--");
} else {
    out.print("unfind--");
}

%>