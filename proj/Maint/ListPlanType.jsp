<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	RecordSet.executeProc("Prj_PlanType_SelectAll","");
	if(RecordSet.getFlag()!=1)
	{
		response.sendRedirect("/proj/DBError.jsp?type=FindData");
		return;
	}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(320,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(407,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<DIV class=HdrProps></DIV>
<%
if(HrmUserVarify.checkUserRight("AddPlanType:Add", user)){
%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",/proj/Maint/AddPlanType.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<%}
%>
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
<TABLE class=liststyle cellspacing=1 >
  <COLGROUP>
  <COL width="30%">
  <COL width="70%">
  <TBODY>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></th>
  </tr>
  <tr><th class="Line1"></th><th class="Line1"></th></tr>
<%
boolean isLight = false;
	while(RecordSet.next())
	{
		if(isLight = !isLight)
		{%>	
	<TR CLASS=DataLight>
<%		}else{%>
	<TR CLASS=DataDark>
<%		}%>
		<TD><a href="/proj/Maint/EditPlanType.jsp?id=<%=Util.toScreen(RecordSet.getString(1),user.getLanguage())%>"><%=Util.toScreen(RecordSet.getString(2),user.getLanguage())%></a></TD>
		<TD><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%></TD>
	</TR>
<%
	}
%>
 </TABLE>
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

<script language="javascript">
function submitData()
{
	if (check_form(weaver,'type,desc'))
		weaver.submit();
}
</script>
</BODY>
</HTML>
