<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.SessionOper" %>
<%@ page import="weaver.hrm.performance.*" %>
<%@ page import="weaver.worktask.worktask.*" %>
<STYLE TYPE="text/css">
/*��ʽ��δ����*/
.btn_RequestSubmitList {BORDER-RIGHT: #7b9ebd 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7b9ebd 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde); BORDER-LEFT: #7b9ebd 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7b9ebd 1px solid 
} 
</STYLE>
<%@ page import="weaver.general.*" %> 
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<script language="javascript">
function openFullWindowHaveBarTmp(url){
	var redirectUrl = url ;
	var width = screen.width ;
	var height = screen.height ;
	var szFeatures = "top=100," ; 
	szFeatures +="left=400," ;
	szFeatures +="width="+width/2+"," ;
	szFeatures +="height="+height/2+"," ; 
	szFeatures +="directories=no," ;
	szFeatures +="status=yes," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ; //channelmode
	if(typeof(window.dialogArguments) == "object"){
		openobj =  window.dialogArguments;
		openobj.open(redirectUrl,"",szFeatures);
	}else{
		window.open(redirectUrl,"",szFeatures);
	}
}
</script>
<%
int wtid = Util.getIntValue(request.getParameter("wtid"), 0);
boolean hasSuchWT = false;
String worktaskName = "";
String hasCanCreateTasks = "false";
WTRequestManager wtRequestManager = new WTRequestManager(wtid);
wtRequestManager.setLanguageID(user.getLanguage());
wtRequestManager.setUserID(user.getUID());
Hashtable canCreateTasks_hs = wtRequestManager.getCanCreateTasks();
hasCanCreateTasks = (String)canCreateTasks_hs.get("hasCanCreateTasks");
String tasksSelectStr = (String)canCreateTasks_hs.get("tasksSelectStr");
if("true".equals(hasCanCreateTasks)){
	out.println("<script>window.location.href=\"/worktask/request/AddWorktask.jsp?isRefash=1&wtid="+wtid+"\";</script>"); 
	return;
}
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">
<script language=javascript src="/js/weaver.js"></script>
<script language=javascript src="/js/xmlextras.js"></script>
</HEAD>
<%
String needfav ="1";
String needhelp ="";
String titlename = SystemEnv.getHtmlLabelName(82, user.getLanguage()) + SystemEnv.getHtmlLabelName(16539, user.getLanguage());
String imagefilename = "/images/hdHRM.gif";
%>

<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(86, user.getLanguage())+",javaScript:OnSave(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(15143, user.getLanguage())+",javaScript:OnSubmit(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<form name="taskform" method="post" action="AddWorktaskFrame.jsp">
<input type="hidden" name="wtid" id="wtid" value="<%=wtid%>">
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
	<tr>
		<td height="10" colspan="3">
			<br>
			<div align="center">
				<font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(18214, user.getLanguage())+SystemEnv.getHtmlLabelName(16539, user.getLanguage())+SystemEnv.getHtmlLabelName(63, user.getLanguage())%></font>
			</div>
		</td>
	</tr>
	<tr>
		<td></td>
		<td valign="top">
		<TABLE class="Shadow">
		<tr>
			<td valign="top">
			<table class="ViewForm">
			<colgroup>
			<col width="20%">
			<col width="80%">
				<tr style="height: 1px;"><td class=Line2 colSpan=2></td></tr>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(18177, user.getLanguage())%></td>
					<td class="Field">
						<%=tasksSelectStr%>
					</td>
				</tr>
				<tr style="height: 1px;"><td class=Line2 colSpan=2></td></tr>
			</table>
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
</form>
<script language="javascript">
function doChangeWorktask(obj){
	var wtid = obj.value;
	if(document.taskform.selectWorktask.value != "0"){
		//openFullWindowForXtable("/worktask/request/AddWorktask.jsp?wtid="+wtid);
		openFullWindowHaveBarTmp("/worktask/request/AddWorktask.jsp?isRefash=1&wtid="+wtid);
		//location.href="/worktask/request/Addworktask.jsp?wtid="+wtid;
		//window.parent.close();
	}
}
</script>
</BODY>
</HTML>