<%@ page language="java" contentType="text/html; charset=GBK" %><%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" /><%

		String roomname = Util.null2String(java.net.URLDecoder.decode(request.getParameter("roomname"),"UTF-8"));  //��ò���ҳ��MeetingRoom_left.jsp�������Ĳ��� name		
		String id = Util.null2String(request.getParameter("id"));
		if (id != null && !"".equals(id))
				RecordSet.executeSql("select * from MeetingRoom where name='"+roomname+"' and id != " + id);  //�޸�״̬ʱ��id������й���
		else
			  RecordSet.executeSql("select * from MeetingRoom where name='"+roomname+"'");
		
		if (RecordSet.next()){
				out.print("exist--");
		} else {
		    out.print("unfind--");
		}
%>