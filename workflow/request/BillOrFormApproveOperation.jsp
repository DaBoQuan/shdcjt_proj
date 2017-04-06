<%@ page language="java" contentType="text/html; charset=GBK" %>

<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page" />



<%@ include file="/systeminfo/init.jsp" %>

<%

int docId = Util.getIntValue(request.getParameter("id"),-1);
String  docsubject = Util.fromScreen(request.getParameter("docsubject"),user.getLanguage());

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
String requestname = Util.fromScreen(request.getParameter("requestname"),user.getLanguage());
String requestlevel = Util.fromScreen(request.getParameter("requestlevel"),user.getLanguage());
String messageType =  Util.fromScreen(request.getParameter("messageType"),user.getLanguage());
String remark = Util.null2String(request.getParameter("remark"));
int isfromdoc = Util.getIntValue(request.getParameter("isfromdoc"),-1);   

String docIds = Util.null2String(request.getParameter("docIds"));
String crmIds = Util.null2String(request.getParameter("crmIds"));
String hrmIds = Util.null2String(request.getParameter("hrmIds"));
String prjIds = Util.null2String(request.getParameter("prjIds"));
String cptIds = Util.null2String(request.getParameter("cptIds"));

// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�



if( src.equals("") ||requestid==-1|| workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    //response.sendRedirect("/notice/RequestError.jsp");
    out.print("<script>wfforward('/notice/RequestError.jsp');</script>");
    return ;
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
    RequestManager.setMessageType(messageType) ;
    RequestManager.setUser(user) ;

    RequestManager.setDocids(docIds);
    RequestManager.setCrmids(crmIds);
    RequestManager.setHrmids(hrmIds);
    RequestManager.setPrjids(prjIds);
    RequestManager.setCptids(cptIds);

    boolean flowstatus = RequestManager.flowNextNode() ;


    if( !flowstatus ) {
		System.out.println("flowstatus="+flowstatus+"##requestid="+requestid);     
    }
    PoppupRemindInfoUtil.updatePoppupRemindInfo(userid,0,(logintype).equals("1") ? "0" : "1",requestid); 
    boolean logstatus = RequestManager.saveRequestLog() ;

    //��������Ϊ�ĵ���Ч�������ĵ�ʧЧ����ʱ�������ĵ�������������(DocApproveWf)�����ݡ�
	RecordSet.executeSql("update DocApproveWf set status='1'  where requestId="+requestid);

    //response.sendRedirect("/docs/docs/DocDsp.jsp?id="+docId+"&isrequest=1");
	out.print("<script>wfforward('/docs/docs/DocDsp.jsp?id="+docId+"&isrequest=1');</script>");
%>