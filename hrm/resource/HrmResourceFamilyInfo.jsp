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
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+"-"+SystemEnv.getHtmlLabelName(814,user.getLanguage());
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
<% if(HrmUserVarify.checkUserRight("HrmResourceFamilyInfoAdd:Add",user)){ %>
<BUTTON class=Btn id=button1 accessKey=A 
onclick='location.href="HrmResourceFamilyInfoAdd.jsp?resourceid=<%=resourceid%>"' name=button1><U>A</U>-<%=SystemEnv.getHtmlLabelName(365,user.getLanguage())%></BUTTON>
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
    <TD width="20%"><%=SystemEnv.getHtmlLabelName(1943,user.getLanguage())%></TD>
    <TD width="20%"><%=SystemEnv.getHtmlLabelName(1944,user.getLanguage())%></TD>
    <TD width="50%"><%=SystemEnv.getHtmlLabelName(1914,user.getLanguage())%></TD>
	<TD width="10%"></TD>
  </TR>
<%
int i=0;
RecordSet.executeProc("HrmFamilyInfo_SbyResourceID",resourceid);

while(RecordSet.next()){
String id = RecordSet.getString("id");
String member = RecordSet.getString("member");
String title = RecordSet.getString("title");
String company = RecordSet.getString("company");
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
	<td><%=Util.toScreen(member,user.getLanguage())%></td>
    <td><%=Util.toScreen(title,user.getLanguage())%></td>
    <td><%=Util.toScreen(company,user.getLanguage())%></td>
    <td><a href="HrmResourceFamilyInfoEdit.jsp?paraid=<%=id%>"><%=SystemEnv.getHtmlLabelName(361,user.getLanguage())%></a></td>
</TR>
<%}
%>
  </TBODY> 
</TABLE>

</BODY></HTML>