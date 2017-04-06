<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="DocReceiveManager" class="weaver.docs.change.DocReceiveManager" scope="page" />
<%
String src = request.getParameter("src");
String status = Util.null2String(request.getParameter("status"));
String detail = Util.null2String(request.getParameter("detail"));
if(src.equals("receive")) {
	DocReceiveManager.receiveDoc(request, user.getUID());
%>
<script>
alert('<%=SystemEnv.getHtmlLabelName(23114,user.getLanguage())%>');
location.href = 'ReceiveDoc.jsp';
</script>
<%
}
else if(src.equals("signin")) {
	String ids = Util.null2String(request.getParameter("ids"));
	DocReceiveManager.replyAction(ids, "1", "");
%>
<script>
alert('<%=SystemEnv.getHtmlLabelName(23115,user.getLanguage())%>');
location.href = 'ReceiveDoc.jsp';
</script>
<%
}
//��������
else if(src.equals("createworkflow")) {
	String sn = Util.null2String(request.getParameter("sn"));
	String ids = Util.null2String(request.getParameter("ids"));
	String wfid = Util.null2String(request.getParameter("createWfid"));
	//out.println(sn+" @ "+ids+" @ "+wfid);
	String requestid = DocReceiveManager.createWorkflow(request, wfid, user.getUID(), ids,sn);
	session.setAttribute("createworkflow_status" + user.getUID(),"1");
%>
<script>
<%
	if(Util.getIntValue(requestid)>0){
%>
		alert('<%=SystemEnv.getHtmlLabelName(23116,user.getLanguage())%>');
		window.open("/workflow/request/ViewRequest.jsp?requestid=<%=requestid%>");
<%}else{%>
		alert('<%=SystemEnv.getHtmlLabelName(26173,user.getLanguage())%>');
<%}%>
location.href = 'ReceiveDoc.jsp';
</script>
<%
}
else {
	String ids = Util.null2String(request.getParameter("ids"));
	DocReceiveManager.replyAction(ids, status, detail);
%>
<script>
<%
if(status.equals("3")) {
%>
alert('<%=SystemEnv.getHtmlLabelName(23117,user.getLanguage())%>');
<%
}
else{
%>
alert('<%=SystemEnv.getHtmlLabelName(23118,user.getLanguage())%>');
<%
}
%>
location.href = 'ReceiveDoc.jsp';
</script>
<%
}
%>