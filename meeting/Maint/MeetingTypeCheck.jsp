<%@ page language="java" contentType="text/html; charset=GBK" %><%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" /><%
	
String roomtypename = Util.null2String(java.net.URLDecoder.decode(request.getParameter("typename"),"UTF-8"));  //��ò���ҳ��MeetingType_left.jsp�������Ĳ��� name
String id = Util.null2String(request.getParameter("id"));

if (id != null && !"".equals(id))
		RecordSet.executeSql("select * from meeting_type where name='"+roomtypename+"' and id != " + id); //�޸�״̬ʱ��id������й���
else
	  RecordSet.executeSql("select * from meeting_type where name='"+roomtypename+"'");
	  	  
if (RecordSet.next()){
		out.print("exist--");
} else {
    out.print("unfind--");
}

%>