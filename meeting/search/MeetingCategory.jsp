<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="MeetingSearchComInfo" class="weaver.meeting.search.SearchComInfo" scope="session" />
<%
MeetingSearchComInfo.resetSearchInfo();
if(user.getLogintype().equals("1")){
	MeetingSearchComInfo.sethrmids(""+user.getUID());
}else{
	MeetingSearchComInfo.setcrmids(""+user.getUID());
}

response.sendRedirect("/meeting/search/SearchResult.jsp?start=1&perpage=10");
%>
