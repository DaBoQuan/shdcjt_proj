<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String meetingid=Util.fromScreen(request.getParameter("meetingid"),user.getLanguage()) ;
String othersremark=Util.fromScreen2(request.getParameter("othersremark"),user.getLanguage()) ;
String updatesql = "update meeting set othersremark='"+othersremark+"' where id="+meetingid;
RecordSet.executeSql(updatesql) ;
%>
<script language=VBS>
     window.parent.returnvalue = Array("","")
     window.parent.close
</script>