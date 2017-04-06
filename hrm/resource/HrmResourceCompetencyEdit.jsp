<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CompetencyComInfo" class="weaver.hrm.job.CompetencyComInfo" scope="page"/>
<HTML><HEAD>
<% if(!HrmUserVarify.checkUserRight("HrmResourceCompetencyEdit:Edit",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+": "+ SystemEnv.getHtmlLabelName(408,user.getLanguage());
String needfav ="1";
String needhelp ="";
String resourceid = Util.null2String(request.getParameter("resourceid"));
String jobactivity = Util.null2String(request.getParameter("jobactivity"));
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">

<FORM id=competencyadd action=HrmResourceCompetencyOperation.jsp method=post>
<input type=hidden name="operation" value="editcompetency">
<input type=hidden name="resourceid" value="<%=resourceid%>">
<TABLE class=viewFORM>
  <COLGROUP>
  <COL width="30%">
  <COL width="70%">
  <TBODY>
  <TR class=title>
      <TH colSpan=2><%=SystemEnv.getHtmlLabelName(87,user.getLanguage())%></TH>
    </TR>
  <TR class=spacing>
    <TD class=line1 colSpan=2></TD></TR>
  <TR>
      <TD><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></TD>
      <TD class=Field><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
<%
ArrayList  competencyids = new ArrayList();
ArrayList  currentgrades = new ArrayList();

RecordSet.executeProc("HrmActivitiesCompetency_Select",jobactivity);
while(RecordSet.next()) {
competencyids.add(RecordSet.getString("competencyid"));
currentgrades.add("");
}

RecordSet.executeProc("HrmResourceCompetency_SByID",resourceid);
while(RecordSet.next())  {
	String competencyid = RecordSet.getString("competencyid");
	float currentgradefloat = Util.getFloatValue(RecordSet.getString("currentgrade"),-1);
	String currentgrade =  (currentgradefloat== -1)?"":""+currentgradefloat;
	int indexid = competencyids.indexOf(competencyid) ;
	if(indexid!=-1) currentgrades.set(indexid,""+currentgrade);
}
for(int j=0 ; j<competencyids.size();j++) {
String competencyid = (String)competencyids.get(j);
%>
  <TR>
    <TD><%=Util.toScreen(CompetencyComInfo.getCompetencyname(competencyid),user.getLanguage())%></TD>
    <TD class=FIELD><INPUT class=inputstyle 
      maxLength=6 size=10
      name="<%=competencyid%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("<%=competencyid%>")' 
	  value="<%=(String)currentgrades.get(j)%>"></TD></TR>
<%}%>
</TBODY>
</TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
</BODY>
</HTML>
