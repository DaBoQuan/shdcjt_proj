<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.workspace.WorkSpaceInfo" %>
<%@ include file="/systeminfo/init.jsp" %>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel="STYLESHEET">
<SCRIPT language="JavaScript" src="/js/weaver.js"></SCRIPT>
</HEAD>

<%

String userId = String.valueOf(user.getUID());
String userType = user.getLogintype();
WorkSpaceInfo infoCollection = new WorkSpaceInfo(request);
int newsUnreadCount = infoCollection.getNewsUnreadCount();
int newsAmount = infoCollection.getNewsAmount();
int docsUnreadCount = infoCollection.getDocsUnreadCount();
int docsApproveCount = infoCollection.getDocsApproveCount();
//int docsSubscibeCount = infoCollection.getDocsSubscibeCount();
int docsAmount = infoCollection.getDocsAmount();
int docsCreatedCount = infoCollection.getDocsCreatedCount();
int projParticipantCount = infoCollection.getProjParticipantCount();
int projUnachievedCount = infoCollection.getProjUnachievedCount();
int projNewCount = infoCollection.getProjNewCount();
int projApproveCount = infoCollection.getProjApproveCount();
int crmManageCount = infoCollection.getCrmManageCount();
int crmNewCount = infoCollection.getCrmNewCount();
int crmContactCount = infoCollection.getCrmContactCount();
int crmApproveCount = infoCollection.getCrmApproveCount();
int meetAttendAmount = infoCollection.getMeetAttendAmount();
int meetNewCount = infoCollection.getMeetNewCount();
int meetApproveCount = infoCollection.getMeetApproveCount();
int reqPendingCount = infoCollection.getReqPendingCount();
int reqDefaultCount = infoCollection.getReqDefaultCount();
int reqPendingUnreadCount = infoCollection.getReqPendingUnreadCount();
int reqDefaultUnreadCount = infoCollection.getReqDefaultUnreadCount();
int myRequestAmount = infoCollection.getMyRequestAmount();
int myRequestFeedBackCount = infoCollection.getMyRequestFeedBackCount();
int myDefaultAmount = infoCollection.getMyDefaultAmount();
int myDefaultFeedBackCount = infoCollection.getMyDefaultFeedBackCount();

int myCoworkCount = infoCollection.getMyCoworkCount();//new add by xys 2005-08-03

int mailAmount = infoCollection.getMailAmount();
int planFeedbackCount = infoCollection.getPlanFeedbackCount();
int planApproveCount = infoCollection.getPlanApproveCount();
%>

<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#E3E3E3">
<COLGROUP>
<COL width="10">
<COL width="">
<COL width="15">
<TR>
	<TD height="6" colspan="3"></TD>
</TR>
<TR>
	<TD></TD>
	<TD valign="top">	
		<TABLE class="ViewForm" width="100%">
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(18124,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		��δ�Ķ�(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsUnreadCount%></A>)ƪ,
		ϵͳ����(<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsAmount%></A>)ƪ���Ź���.
		<%}else if(user.getLanguage()==8){%>
		(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsUnreadCount%></A>) are unread,
		totally (<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsAmount%></A>) news.
		<%}else if(user.getLanguage()==9){%>
		��δ��x(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsUnreadCount%></A>)ƪ, 
		ϵ�y�F��(<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>&docpublishtype=5" target="_parent"><%=newsAmount%></A>)ƪ������.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(2115,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		��δ�Ķ�(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>" target="_parent"><%=docsUnreadCount%></A>)ƪ,
		��(<A href="/docs/docs/ApproveDocList.jsp" target="_parent"><%=docsApproveCount%></A>)ƪ��Ҫ������,
		ϵͳ����(<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>" target="_parent"><%=docsAmount%></A>)ƪ�ĵ�,
		������(<A href="/docs/search/DocView.jsp?dspreply=0" target="_parent"><%=docsCreatedCount%></A>)ƪ�ĵ�.
		<%}else if(user.getLanguage()==8){%>
		(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>" target="_parent"><%=docsUnreadCount%></A>) are unread,
		and (<A href="/docs/docs/ApproveDocList.jsp" target="_parent"><%=docsApproveCount%></A>) should be approved,totally (<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>" target="_parent"><%=docsAmount%></A>) documents,
		and (<A href="/docs/search/DocView.jsp?dspreply=0" target="_parent"><%=docsCreatedCount%></A>) you created.
		<%}else if(user.getLanguage()==9){%>
		��δ��x(<A href="/docs/search/DocSearchTemp.jsp?list=all&isNew=yes&loginType=<%=userType%>" target="_parent"><%=docsUnreadCount%></A>)ƪ, 
		��(<A href="/docs/docs/ApproveDocList.jsp" target="_parent"><%=docsApproveCount%></A>)ƪ��Ҫ������, 
		ϵ�y�F��(<A href="/docs/search/DocSearchTemp.jsp?list=all&loginType=<%=userType%>" target="_parent"><%=docsAmount%></A>)ƪ�ęn, 
		������(<A href="/docs/search/DocView.jsp?dspreply=0" target="_parent"><%=docsCreatedCount%></A>)ƪ�ęn.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(2114,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		����������(<A href="/proj/data/MyProject.jsp" target="_parent"><%=projParticipantCount%></A>)����Ŀ,
		����(<A href="/proj/data/MyProject.jsp?ProjectStatus=12" target="_parent"><%=projUnachievedCount%></A>)����Ŀδ���,
		��(<A href="/proj/data/MyProject.jsp?unread=1" target="_parent"><%=projNewCount%></A>)������Ŀ����,
		��(<A href="/proj/data/ProjectApproval.jsp" target="_parent"><%=projApproveCount%></A>)����Ҫ����.
		<%}else if(user.getLanguage()==8){%>
		Joined (<A href="/proj/data/MyProject.jsp" target="_parent"><%=projParticipantCount%></A>) projects,
		and (<A href="/proj/data/MyProject.jsp?ProjectStatus=12" target="_parent"><%=projUnachievedCount%></A>) are not completed,
		(<A href="/proj/data/MyProject.jsp?unread=1" target="_parent"><%=projNewCount%></A>) will be distributed, (<A href="/proj/data/ProjectApproval.jsp" target="_parent"><%=projApproveCount%></A>) are to be approved.
		<%}else if(user.getLanguage()==9){%>
		�������c��(<A href="/proj/data/MyProject.jsp" target="_parent"><%=projParticipantCount%></A>)���Ŀ, 
		߀��(<A href="/proj/data/MyProject.jsp?ProjectStatus=12" target="_parent"><%=projUnachievedCount%></A>)���Ŀδ���, 
		��(<A href="/proj/data/MyProject.jsp?unread=1" target="_parent"><%=projNewCount%></A>)�����Ŀ����, 
		��(<A href="/proj/data/ProjectApproval.jsp" target="_parent"><%=projApproveCount%></A>)����Ҫ����.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(2113,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		����������(<A href="/CRM/search/SearchOperation.jsp?msg=report&settype=manager&id=<%=userId%>" target="_parent"><%=crmManageCount%></A>)���ͻ�,
		��(<A href="/CRM/data/NewCustomerList.jsp" target="_parent"><%=crmNewCount%></A>)���¿ͻ�����,
		��(<A href="/CRM/data/CRMContactRemind.jsp" target="_parent"><%=crmContactCount%></A>)����Ҫ��ϵ,
		��(<A href="/CRM/data/ApproveCustomerList.jsp" target="_parent"><%=crmApproveCount%></A>)����Ҫ����.
		<%}else if(user.getLanguage()==8){%>
		Managing (<A href="/CRM/search/SearchOperation.jsp?msg=report&settype=manager&id=<%=userId%>" target="_parent"><%=crmManageCount%></A>),
		(<A href="/CRM/data/NewCustomerList.jsp" target="_parent"><%=crmNewCount%></A>) should be distributed,
		(<A href="/CRM/data/CRMContactRemind.jsp" target="_parent"><%=crmContactCount%></A>) should be connected,
		(<A href="/CRM/data/ApproveCustomerList.jsp" target="_parent"><%=crmApproveCount%></A>) should be approved.
		<%}else if(user.getLanguage()==9){%>
		����������(<A href="/CRM/search/SearchOperation.jsp?msg=report&settype=manager&id=<%=userId%>" target="_parent"><%=crmManageCount%></A>)���͑�, 
		��(<A href="/CRM/data/NewCustomerList.jsp" target="_parent"><%=crmNewCount%></A>)���¿͑�����, 
		��(<A href="/CRM/data/CRMContactRemind.jsp" target="_parent"><%=crmContactCount%></A>)����Ҫ�M, 
		��(<A href="/CRM/data/ApproveCustomerList.jsp" target="_parent"><%=crmApproveCount%></A>)����Ҫ����.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(18442,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		�����μ���(<%if (userType.equals("1")) {%><A href="/meeting/search/SearchOperation.jsp?hrmids=<%=userId%>&meetingstatus=2" target="_parent"><%} else {%><A href="/meeting/search/SearchOperation.jsp?crmids=<%=userId%>" target="_parent"><%}%><%=meetAttendAmount%></A>)������,
		��(<A href="/meeting/data/NewMeetings.jsp" target="_parent"><%=meetNewCount%></A>)���»���Ҫ�μ�,
		��(<A href="/meeting/data/MeetingApproval.jsp" target="_parent"><%=meetApproveCount%></A>)��Ҫ����.
		<%}else if(user.getLanguage()==8){%>
		Attended (<%if (userType.equals("1")) {%><A href="/meeting/search/SearchOperation.jsp?hrmids=<%=userId%>&meetingstatus=2" target="_parent"><%} else {%><A href="/meeting/search/SearchOperation.jsp?crmids=<%=userId%>" target="_parent"><%}%><%=meetAttendAmount%></A>) meetings,
		(<A href="/meeting/data/NewMeetings.jsp" target="_parent"><%=meetNewCount%></A>) new meetings are for you to attend,
		(<A href="/meeting/data/MeetingApproval.jsp" target="_parent"><%=meetApproveCount%></A>) should be approved.
		<%}else if(user.getLanguage()==9){%>
		����������(<%if (userType.equals("1")) {%><A href="/meeting/search/SearchOperation.jsp?hrmids=<%=userId%>&meetingstatus=2" target=" _parent"><%} else {%><A href="/meeting/search/SearchOperation.jsp?crmids=<%=userId%>" target="_parent"><%}%><%=meetAttendAmount%> </A>)�����h, 
		��(<A href="/meeting/data/NewMeetings.jsp" target="_parent"><%=meetNewCount%></A>)�����hҪ����, 
		��(<A href="/meeting/data/MeetingApproval.jsp" target="_parent"><%=meetApproveCount%></A>)��Ҫ����.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(1207,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		������(<A href="WorkSpaceRequest.jsp?type=11" target="_parent"><%=reqPendingCount%></A>)�����칤������,
		��(<A href="WorkSpaceRequest.jsp?type=12" target="_parent"><%=reqDefaultCount%></A>)������Ĭ������,
		��(<A href="WorkSpaceRequest.jsp?type=13" target="_parent"><%=reqPendingUnreadCount%></A>)���´��칤������Ҫ����,
		��(<A href="WorkSpaceRequest.jsp?type=14" target="_parent"><%=reqDefaultUnreadCount%></A>)���´���Ĭ������.
		<%}else if(user.getLanguage()==8){%>
		You have (<A href="WorkSpaceRequest.jsp?type=11" target="_parent"><%=reqPendingCount%></A>) pending workflows,
		and (<A href="WorkSpaceRequest.jsp?type=12" target="_parent"><%=reqDefaultCount%></A>) default pending workflows,
		and (<A href="WorkSpaceRequest.jsp?type=13" target="_parent"><%=reqPendingUnreadCount%></A>) new pending workflows to do with,
		and (<A href="WorkSpaceRequest.jsp?type=14" target="_parent"><%=reqDefaultUnreadCount%></A>) new default pending workflows.
		<%}else if(user.getLanguage()==9){
		%>
		������(<A href="WorkSpaceRequest.jsp?type=11" target="_parent"><%=reqPendingCount%></A>)�����k��������, 
		��(<A href="WorkSpaceRequest.jsp?type=12" target="_parent"><%=reqDefaultCount%></A>)�����kĬ�J����, 
		��(<A href="WorkSpaceRequest.jsp?type=13" target="_parent"><%=reqPendingUnreadCount%></A>)���´��k��������Ҫ̎��, 
		��(<A href="WorkSpaceRequest.jsp?type=14" target="_parent"><%=reqDefaultUnreadCount%></A>)���´��kĬ�J����.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(1210,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		��������(<A href="WorkSpaceRequest.jsp?type=51" target="_parent"><%=myRequestAmount%></A>)������,
		��(<A href="WorkSpaceRequest.jsp?type=52" target="_parent"><%=myDefaultAmount%></A>)��Ĭ������,
		��(<A href="WorkSpaceRequest.jsp?type=53" target="_parent"><%=myRequestFeedBackCount%></A>)�����󱻷���,
		��(<A href="WorkSpaceRequest.jsp?type=54" target="_parent"><%=myDefaultFeedBackCount%></A>)��Ĭ�����󱻷���.
		<%}else if(user.getLanguage()==8){%>
		You have sent (<A href="WorkSpaceRequest.jsp?type=51" target="_parent"><%=myRequestAmount%></A>) requests,
		and (<A href="WorkSpaceRequest.jsp?type=52" target="_parent"><%=myDefaultAmount%></A>) default requests,
		and (<A href="WorkSpaceRequest.jsp?type=53" target="_parent"><%=myRequestFeedBackCount%></A>) requests are feeded back,
		and (<A href="WorkSpaceRequest.jsp?type=54" target="_parent"><%=myDefaultFeedBackCount%></A>) default requests are feeded back.
		<%}else if(user.getLanguage()==9){%>
		�����l��(<A href="WorkSpaceRequest.jsp?type=51" target="_parent"><%=myRequestAmount%></A>)��Ո��, 
		��(<A href="WorkSpaceRequest.jsp?type=52" target="_parent"><%=myDefaultAmount%></A>)��Ĭ�JՈ��, 
		��(<A href="WorkSpaceRequest.jsp?type=53" target="_parent"><%=myRequestFeedBackCount%></A>)��Ո�󱻷���, 
		��(<A href="WorkSpaceRequest.jsp?type=54" target="_parent"><%=myDefaultFeedBackCount%></A>)��Ĭ�JՈ�󱻷���.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(17716,user.getLanguage())%></B>:
		<%if(user.getLanguage()==7){%>
		������(<A href="/cowork/coworkview.jsp?type=new" target="_parent"><%=myCoworkCount%></A>)��δ�鿴Э��.
		<%}else if(user.getLanguage()==8){%>
		You have (<A href="/cowork/coworkview.jsp?type=new" target="_parent"><%=myCoworkCount%></A>) unread coworks.
		<%}else if(user.getLanguage()==9){%>
		������(<A href="/cowork/coworkview.jsp?type=new" target="_parent"><%=myCoworkCount%></A>)��δ�鿴�f��.
		<%}%>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(1213,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
			<%if (mailAmount == -1) {%>
			�ʼ�ϵͳδ<A href="/email/Weavermail.jsp" target="_parent">��½</A>.
			<%} else {%>
			�����ռ����й���(<A href="/email/Weavermail.jsp" target="_parent"><%=mailAmount%></A>)���ʼ�.
			<%}%>
		<%}else if(user.getLanguage()==8){%>
			<%if (mailAmount == -1) {%>
			You have not <A href="/email/Weavermail.jsp" target="_parent">Login</A> your mail system.
			<%} else {%>
			There are (<A href="/email/Weavermail.jsp" target="_parent"><%=mailAmount%></A>) mails in your folder.
			<%}%>			
		<%}else if(user.getLanguage()==9){
		%>
			<%if (mailAmount == -1) {%>
			�]��ϵ�yδ<A href="/email/Weavermail.jsp" target="_parent">���</A>. 
			<%} else {%> 
			�����ռ��A�й���(<A href="/email/Weavermail.jsp" target="_parent"><%=mailAmount%></A>)���]��.
			<%}%>	
		<%} %>
		</TD></TR>
		<TR style="height:1px;" bgcolor="#000000"><TD colspan="2"></TD></TR>
		<TR><TD width="15" align="center"><TABLE width="5" height="5">
		<TR><TD></TD></TR></TABLE></TD><TD><B><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></B>: 
		<%if(user.getLanguage()==7){%>
		��ļƻ�(<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=1" target="_parent"><%=planFeedbackCount%></A>)��������,
		����(<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=2" target="_parent"><%=planApproveCount%></A>)���ƻ���Ҫ�������,
		�ҵ�<A href="/workplan/report/WorkPlanReport.jsp?type=6" target="_parent">�����ƻ����ܽ�</A>.
		<%}else if(user.getLanguage()==8){%>
		Your (<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=1" target="_parent"><%=planFeedbackCount%></A>) plans are feeded back,
		and (<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=2" target="_parent"><%=planApproveCount%></A>) are to be approved.
		My <A href="/workplan/report/WorkPlanReport.jsp?type=6" target="_parent">Work Plan</A>.
		<%}else if(user.getLanguage()==9){%>
		���Ӌ��(<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=1" target="_parent"><%=planFeedbackCount%></A>)��������, 
		����(<A href="/workplan/search/WorkPlanSearchResult.jsp?advanced=2" target="_parent"><%=planApproveCount%></A>)��Ӌ����Ҫ�������, 
		�ҵ�<A href="/workplan/report/WorkPlanReport.jsp?type=6" target="_parent">����Ӌ���Ϳ��Y</A>.
		<%}%>
		</TD></TR>
		</TABLE>			 
	</TD>
	<TD></TD>
</TR>
<TR>
	<TD height="10" colspan="3"></TD>
</TR>
</TABLE>

</BODY>
<SCRIPT language="JavaScript">
function doAdd() {
	if (check_form(document.frmmain, "note"))
		document.frmmain.submit();
}
</SCRIPT>
</HTML>