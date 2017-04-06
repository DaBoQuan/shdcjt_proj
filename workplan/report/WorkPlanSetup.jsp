<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel="STYLESHEET">
<SCRIPT language="javascript" src="/js/weaver.js"></SCRIPT>
</HEAD>

<%
String reportType = Util.null2String(request.getParameter("type"));
String userId = String.valueOf(user.getUID());
int recCount = 20;			//Ĭ��Ϊ20��
rs.executeSql("SELECT recCount FROM WorkPlanSetup WHERE userId = " + userId + " AND reportType = " + reportType);
if (rs.next())
	recCount = Util.getIntValue(rs.getString("recCount"), 20);

if (reportType.equals(""))				//1:�ձ�, 2:�ܱ�, 3:�±�, 4:����, 5:�걨
	reportType = "1";

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(17488, user.getLanguage()) + ":&nbsp;";

if (reportType.equals("1"))
	titlename += SystemEnv.getHtmlLabelName(16428,user.getLanguage());
else if (reportType.equals("2"))
	titlename += SystemEnv.getHtmlLabelName(16429,user.getLanguage());
else if (reportType.equals("3"))
	titlename += SystemEnv.getHtmlLabelName(16430,user.getLanguage());
else if (reportType.equals("4"))
	titlename += SystemEnv.getHtmlLabelName(16431,user.getLanguage());
else if (reportType.equals("5"))
	titlename += SystemEnv.getHtmlLabelName(16432,user.getLanguage());
else
	titlename += SystemEnv.getHtmlLabelName(400,user.getLanguage());
	
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:doSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;


RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:goBack(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<COLGROUP>
<COL width="10">
<COL width="">
<COL width="10">
<TR>
	<TD height="10" colspan="3"></TD>
</TR>
<TR>
	<TD></TD>
	<TD valign="top">
		<TABLE class="Shadow">
		<TR>
		<TD valign="top">

			<FORM id="frmmain" name="frmmain" method="post" action="WorkPlanSetupHandler.jsp">
			  <INPUT type="hidden" name="reporttype" value="<%=reportType%>">
			  <TABLE class="ViewForm">
				<COLGROUP>
                <COL width="15%">
                <COL width="85%">
                <TBODY>

                <TR>
				  <TD><%=SystemEnv.getHtmlLabelName(17491,user.getLanguage())%></TD>
				  <TD class="Field">
					<INPUT name="reccount" size="5" maxlength="5" onchange='checkinput("reccount","reccountspan")' onKeyPress="ItemCount_KeyPress()" class="InputStyle" value="<%=recCount%>">
					<SPAN id="reccountspan"></SPAN> </TD>
				</TR>
				<TR><TD class="Line" colSpan="2"></TD></TR>				
				</TBODY>
			  </TABLE></FORM>
		</TD>
		</TR>
		</TABLE>
	</TD>
	<TD></TD>
</TR>
<TR>
	<TD height="10" colspan="3"></TD>
</TR>
</TABLE>
<SCRIPT language="JavaScript">
function doSubmit(){
	if (check_form(document.frmmain,"reccount"))
		document.frmmain.submit();
}

function goBack() {
	document.location.href = "WorkPlanReport.jsp?type=<%=reportType%>";
}
</SCRIPT>
</BODY>
</HTML>