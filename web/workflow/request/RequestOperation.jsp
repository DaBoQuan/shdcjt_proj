<%@ page import="weaver.general.Util,java.net.*"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>

<%
User user = new User() ;
user = HrmUserVarify.checkUser(request , response) ;
int userid = 0;
int language = 7;
String logintype = "2";
String userName = "" ;
if (user==null)
{
user = new User() ;
user.setUid(0);
user.setLanguage(7);
user.setLogintype("2");
}
else
{
 userid = user.getUID();
 logintype = user.getLogintype();
 language = user.getLanguage() ;
 userName =  user.getUsername() ;
}

String src = Util.null2String(request.getParameter("src"));
String iscreate = Util.null2String(request.getParameter("iscreate"));
int requestid = Util.getIntValue(request.getParameter("requestid"),-1);
int workflowid = Util.getIntValue(request.getParameter("workflowid"),-1);
String workflowtype = Util.null2String(request.getParameter("workflowtype"));
int isremark = Util.getIntValue(request.getParameter("isremark"),-1);
int formid = Util.getIntValue(request.getParameter("formid"),-1);
int isbill = Util.getIntValue(request.getParameter("isbill"),-1);
int billid = Util.getIntValue(request.getParameter("billid"),-1);
int nodeid = Util.getIntValue(request.getParameter("nodeid"),-1);
String nodetype = Util.null2String(request.getParameter("nodetype"));
String requestname = Util.fromScreen(request.getParameter("requestname"),language);
String requestlevel = Util.fromScreen(request.getParameter("requestlevel"),language);
String remark = Util.fromScreen(request.getParameter("remark"),language);
String method = Util.fromScreen(request.getParameter("method"),language); // ��Ϊ�½��ĵ�ʱ��Ĳ�������
String topage=URLDecoder.decode(Util.null2String(request.getParameter("topage")));  //���ص�ҳ��


if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    response.sendRedirect("/web/workflow/request/RequestBackMessage.jsp?message=3"); 
    return ;//��������ʼ����
}


RequestManager.setSrc(src) ;
RequestManager.setIscreate(iscreate) ;
RequestManager.setRequestid(requestid) ;
RequestManager.setWorkflowid(workflowid) ;
RequestManager.setWorkflowtype(workflowtype) ;
RequestManager.setIsremark(isremark) ;
RequestManager.setFormid(formid) ;
RequestManager.setIsbill(isbill) ;
RequestManager.setBillid(billid) ;
RequestManager.setNodeid(nodeid) ;
RequestManager.setNodetype(nodetype) ;
RequestManager.setRequestname(requestname) ;
RequestManager.setRequestlevel(requestlevel) ;
RequestManager.setRemark(remark) ;
RequestManager.setRequest(request) ;
RequestManager.setUser(user) ;


boolean savestatus = RequestManager.saveRequestInfo() ;
requestid = RequestManager.getRequestid() ;
if( !savestatus ) {
    
	response.sendRedirect("/web/workflow/request/RequestBackMessage.jsp?message=1");
    return ;//��������Ϣ�������

}

boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
    response.sendRedirect("/web/workflow/request/RequestBackMessage.jsp?message=2");
    return ;//��������һ�ڵ����һ�ڵ�����ߴ���
}

boolean logstatus = RequestManager.saveRequestLog() ;

if( method.equals("") ) {
	if(!topage.equals("")){
        	if(topage.indexOf("?")!=-1)
        		response.sendRedirect(topage+"&requestid="+requestid);
        	else
				response.sendRedirect(topage+"?requestid="+requestid);
		}
	else 
		{
			response.sendRedirect("/web/workflow/request/RequestBackMessage.jsp?message=0");
			return ;//�ύ�ɹ�
		}
}
%>