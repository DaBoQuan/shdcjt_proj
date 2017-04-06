<%@ page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CptShare" class="weaver.cpt.capital.CptShare" scope="page" />
<%@ page import="weaver.file.FileUpload" %>
<%
FileUpload fu = new FileUpload(request);
String src = Util.null2String(fu.getParameter("src"));
String iscreate = Util.null2String(fu.getParameter("iscreate"));
int requestid = Util.getIntValue(fu.getParameter("requestid"),-1);
int workflowid = Util.getIntValue(fu.getParameter("workflowid"),-1);
String workflowtype = Util.null2String(fu.getParameter("workflowtype"));
int isremark = Util.getIntValue(fu.getParameter("isremark"),-1);
int formid = Util.getIntValue(fu.getParameter("formid"),-1);
int isbill = Util.getIntValue(fu.getParameter("isbill"),-1);
int billid = Util.getIntValue(fu.getParameter("billid"),-1);
int nodeid = Util.getIntValue(fu.getParameter("nodeid"),-1);
String nodetype = Util.null2String(fu.getParameter("nodetype"));
String requestname = Util.fromScreen(fu.getParameter("requestname"),user.getLanguage());
String requestlevel = Util.fromScreen(fu.getParameter("requestlevel"),user.getLanguage());
String messageType =  Util.fromScreen(fu.getParameter("messageType"),user.getLanguage());
String remark = Util.null2String(fu.getParameter("remark"));
String[] check_node_vals = fu.getParameterValues("check_node_val");

if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
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
RequestManager.setRequest(fu) ;
RequestManager.setUser(user) ;
//add by chengfeng.han 2011-7-28 td20647 
int isagentCreater = Util.getIntValue((String)session.getAttribute(workflowid+"isagent"+user.getUID()));
int beagenter = Util.getIntValue((String)session.getAttribute(workflowid+"beagenter"+user.getUID()),0);
RequestManager.setIsagentCreater(isagentCreater);
RequestManager.setBeAgenter(beagenter);
//end
//add by xhheng @ 2005/01/24 for ��Ϣ���� Request06
RequestManager.setMessageType(messageType) ;

boolean savestatus = RequestManager.saveRequestInfo() ;
requestid = RequestManager.getRequestid() ;
if( !savestatus ) {
    if( requestid != 0 ) {

        String message=RequestManager.getMessage();
        if(!"".equals(message)){
			out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message="+message+"');</script>");
            return ;
        }

        //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
        out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1');</script>");
        return ;
    }
    else {
        //response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
        out.print("<script>wfforward('/workflow/request/RequestView.jsp?message=1');</script>");
        return ;
    }
}

boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
	//response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
	out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
	return ;
}

char flag = 2; 
String updateclause = "" ;
// add record into bill_CptApplyDetail
if( src.equals("save") || src.equals("submit") ) {      // �޸�ϸ���������Ϣ
	if( !iscreate.equals("1") ) RecordSet.executeSql("delete from bill_CptAdjustDetail where cptadjustid =" + billid);
    else {
        requestid = RequestManager.getRequestid() ;
        billid = RequestManager.getBillid() ;
    }

	int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	float totalamount =0;

	
	for(int i=0;i<rowsum;i++) {		
	  String idval = ""+i;
		if(check_node_vals!=null){
		  idval = check_node_vals[i];
		 }
		
		int cptid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+idval+"_cptid")),0);
		int capitalid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+idval+"_capitalid")),0);
		float number = Util.getFloatValue(fu.getParameter("node_"+idval+"_number"),0);
		//if (number <= 0) continue;
		float unitprice = Util.getFloatValue(fu.getParameter("node_"+idval+"_unitprice"),0);
		float amount = number * unitprice;
		String needdate = Util.null2String(fu.getParameter("node_"+idval+"_needdate"));
		String purpose = Util.null2String(fu.getParameter("node_"+idval+"_purpose"));
		String cptdesc = Util.null2String(fu.getParameter("node_"+idval+"_cptdesc"));		
		String para = ""+billid+flag+cptid+flag+capitalid+flag+number+flag+unitprice+flag + amount+flag+needdate+flag+purpose+flag+cptdesc;		
		RecordSet.executeProc("bill_CptAdjustDetail_Insert",para);		
		totalamount += amount;		
	}					
	updateclause += " set totalamount = "+totalamount+" ";
	updateclause="update bill_CptAdjustMain "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);

}

//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-���ʲ����� ==��ʼ==
if(src.equals("submit")&&RequestManager.getNextNodetype().equals("3")){

	String CptDept_to = Util.null2String(fu.getParameter("field190"));//��������
	String hrmid = Util.null2String(fu.getParameter("field191"));//����������
    
	int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	for(int i=0;i<rowsum;i++){		
		String replacecapitalid = Util.null2String(fu.getParameter("node_"+i+"_capitalid"));//�����ʲ� 
		Calendar today = Calendar.getInstance();
		String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     		 Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                         Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
    String usecount="1"; 
		String usestatus ="-4";
		String tempremark = Util.null2String(fu.getParameter("node_"+i+"_purpose"))+"/"+Util.null2String(fu.getParameter("node_"+i+"_cptdesc"));//��ע=��;+����
		String CptDept_from = CapitalComInfo.getDepartmentid(replacecapitalid);//�ʲ���������

		//int number = (int)Util.getFloatValue(fu.getParameter("node_"+i+"_number"),0);
		//for(int j=0;j<number;j++){
			String para = "";
	
	    para = replacecapitalid ;
	    para +=flag+currentdate;
	    para +=flag+CptDept_to;
	    para +=flag+hrmid;
	    para +=flag+usecount;
	    para +=flag+"";
	    para +=flag+usestatus;
	    para +=flag+tempremark;    
	    para +=flag+CptDept_from;
	    
		  RecordSet.executeProc("Capital_Adjust",para);
		  RecordSet.executeSql("update cptcapital set resourceid = '" + hrmid + "',departmentid = '" + CptDept_to + "' where id = '" + replacecapitalid + "'");
		  CapitalComInfo.removeCapitalCache();
		  CptShare.setCptShareByCpt(replacecapitalid);//����detail�� 
	  //}
 }
}
//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-���ʲ����� ==����==

boolean logstatus = RequestManager.saveRequestLog() ;

//response.sendRedirect("/workflow/request/RequestView.jsp");
out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
%>