<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
String resourceid = Util.null2String(request.getParameter("resourceid")) ;
char separator = Util.getSeparator() ;

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+"-"+SystemEnv.getHtmlLabelName(813,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%
if(msgid!=-1){
%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
</font>
</DIV>
<%}%>
<DIV class=HdrProps></DIV>
<% if(HrmUserVarify.checkUserRight("HrmResourceEducationInfoAdd:Add",user)){ %>
<BUTTON class=Btn id=button1 accessKey=A 
onclick='location.href="HrmResourceEducationInfoAdd.jsp?resourceid=<%=resourceid%>"' name=button1><U>A</U>-<%=SystemEnv.getHtmlLabelName(365,user.getLanguage())%></BUTTON>
<% } %>

<TABLE class=ListShort>
  <TBODY> 
  <TR class=Section> 
    <TH colSpan=5><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%> <a href="HrmResource.jsp?id=<%=resourceid%>"><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></a></TH>
  </TR>
  <TR class=Separator> 
    <TD class=Sep1 colSpan=5></TD>
  </TR>
  <TR class=Header> 
    <TD width="20%"><%=SystemEnv.getHtmlLabelName(742,user.getLanguage())%></TD>
    <TD width="20%"><%=SystemEnv.getHtmlLabelName(743,user.getLanguage())%></TD>
    <TD width="50%"><%=SystemEnv.getHtmlLabelName(1850,user.getLanguage())%></TD>
	<TD width="10%"></TD>
  </TR>
<%
int i=0;
RecordSet.executeProc("HrmEducationInfo_SByResourceID",resourceid);

while(RecordSet.next()){
String id = RecordSet.getString("id");
String startdate = RecordSet.getString("startdate");
String enddate = RecordSet.getString("enddate");
String school = RecordSet.getString("school");
if(i==0){
		i=1;
%>
<TR class=DataLight>
<%
	}else{
		i=0;
%>
<TR class=DataDark>
<%
}
%>
	<td><%=Util.toScreen(startdate,user.getLanguage())%></td>
    <td><%=Util.toScreen(enddate,user.getLanguage())%></td>
    <td><%=Util.toScreen(school,user.getLanguage())%></td>
    <td><a href="HrmResourceEducationInfoEdit.jsp?paraid=<%=id%>"><%=SystemEnv.getHtmlLabelName(361,user.getLanguage())%></a></td>
</TR>
<%}
%>
  </TBODY> 
</TABLE>

</BODY></HTML>