<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%
if(!HrmUserVarify.checkUserRight("HrmDefaultScheduleEdit:Edit", user)){
    response.sendRedirect("/notice/noright.jsp") ; 
    return ; 
}
%>

<HTML>
<HEAD>
<title></title>
</HEAD>
  <FRAMESET ROWS="0%,100%"> 
    <FRAME SRC="HrmDataBackup.jsp" name="Frame2"> 
    <FRAME SRC="HrmDataCollect.jsp" name="Frame1" noresize> 
  </FRAMESET> 
</HTML>