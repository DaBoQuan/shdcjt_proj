<%@ page import="java.math.BigDecimal"%>
<%@ page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CptShare" class="weaver.cpt.capital.CptShare" scope="page" />
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
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

if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    //response.sendRedirect("/notice/RequestError.jsp");
    out.print("<script>wfforward('/notice/RequestError.jsp');</script>");
    return ;
}

int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
if(src.equals("submit") || (!iscreate.equals("1")&&src.equals("save")) ){//�ύ��Ǵ����ڵ㱣��ʱ�����ʲ��Ķ�������
	RecordSetTrans.setAutoCommit(false);
	try{
		for(int i=0;i<rowsum;i++){
			String number = Util.null2String(fu.getParameter("node_"+i+"_number"));//��������
			if (number.equals("")) continue;
					
			int capitalid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_capitalid")),0);
			
			String old_number = "0";
			if(!iscreate.equals("1")){//����ǷǴ����ڵ㣬�ʲ���������������Ϊ�ýڵ�ı��������
				RecordSetTrans.executeSql("select numbers as number_n from bill_Discard_Detail where detailrequestid = "+requestid+" and capitalid="+capitalid);
				if(RecordSetTrans.next()){
				    old_number = Util.null2String(RecordSetTrans.getString("number_n"));
				    if(old_number.equals("")) old_number = "0";
				}
			}
			
			String storeNumber = "0";
			String frozennum = "0";
			RecordSetTrans.executeSql("select capitalnum,frozennum from CptCapital where id="+capitalid);
			if(RecordSetTrans.next()){
				frozennum = Util.null2String(RecordSetTrans.getString("frozennum"));//��������
				storeNumber = Util.null2String(RecordSetTrans.getString("capitalnum"));//ʵ�ʿ����
				if(frozennum.equals("")) frozennum = "0";
				if(storeNumber.equals("")) storeNumber = "0";
				storeNumber = (new BigDecimal(storeNumber)).subtract(new BigDecimal(frozennum)).toString();
			}
			if( ((new BigDecimal(storeNumber)).compareTo(new BigDecimal("0"))==-1) 
			  ||(iscreate.equals("1") && ((new BigDecimal(number)).compareTo(new BigDecimal(storeNumber))==1) ) 
			  ||(!iscreate.equals("1") && ((new BigDecimal(number)).subtract(new BigDecimal(old_number)).compareTo(new BigDecimal(storeNumber))==1) )
			  ){//ʵ�ʿ���� < 0 �����ڴ����ڵ㱨����������ʵ�ʿ�������߷Ǵ����ڵ㱨����������ʵ�ʿ�����������ύ�ͱ���
				    RecordSetTrans.rollback();
				    //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=19");
				    out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=19');</script>");
				    return ;
			}else{
				if(iscreate.equals("1")) frozennum = (new BigDecimal(frozennum)).add(new BigDecimal(number)).toString();
				else frozennum = (new BigDecimal(frozennum)).add(new BigDecimal(number)).subtract(new BigDecimal(old_number)).toString();
				RecordSetTrans.executeSql("update CptCapital set frozennum="+frozennum+" where id="+capitalid);
			}		
		}
		RecordSetTrans.commit();
	}catch(Exception exception){
		RecordSetTrans.rollback();
	}
}else if("reject".equals(src)){//�˻�
	//����˻ص������ڵ㣬���ͷŸ�������������ʲ���
	RecordSetTrans.setAutoCommit(false);
	try{
		RecordSetTrans.executeSql("select destnodeid as lastnodeid from workflow_nodelink where wfrequestid is null and workflowid="+workflowid+" and nodeid="+nodeid+" and isreject='1'");
		if(RecordSetTrans.next()){
			int lastnodeid = RecordSetTrans.getInt("lastnodeid");
			RecordSetTrans.executeSql("select nodetype as lastnodetype from workflow_flownode where nodeid="+lastnodeid);
			if(RecordSetTrans.next()){
				String lastnodetype = RecordSetTrans.getString("lastnodetype");
				if(lastnodetype.equals("0")){//�˻ص������ڵ�
					for(int i=0;i<rowsum;i++){
						int capitalid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_capitalid")),0);
						BigDecimal old_number_n = new BigDecimal("0");
						BigDecimal old_frozennum = new BigDecimal("0");
						BigDecimal new_frozennum = new BigDecimal("0");
						RecordSetTrans.executeSql("select numbers as old_number_n from bill_Discard_Detail where detailrequestid="+requestid+" and capitalid="+capitalid);
						if(RecordSetTrans.next()){
						    String tempold_number_n = Util.null2String(RecordSetTrans.getString("old_number_n"));
						    if(!tempold_number_n.equals("")) 
						        old_number_n = new BigDecimal(tempold_number_n);
						}
						RecordSetTrans.executeSql("select frozennum as old_frozennum from CptCapital where id="+capitalid);
						if(RecordSetTrans.next()){
						    String tempold_frozennum = Util.null2String(RecordSetTrans.getString("old_frozennum"));
						    if(!tempold_frozennum.equals(""))
						        old_frozennum = new BigDecimal(tempold_frozennum);
						}
						new_frozennum = old_frozennum.subtract(old_number_n);
						RecordSetTrans.executeSql("update CptCapital set frozennum="+new_frozennum+" where id="+capitalid);
					}
				}
			}
		}
		RecordSetTrans.commit();
	}catch(Exception exception){
		RecordSetTrans.rollback();
	}
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

char flag = 2; 
if( src.equals("save") || src.equals("submit") ) {// �����޸���ϸ����Ϣ
	if( !iscreate.equals("1") ) RecordSet.executeSql("delete from bill_Discard_Detail where detailrequestid =" + requestid);
  else{
  	requestid = RequestManager.getRequestid();
  }

	//int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	
	for(int i=0;i<rowsum;i++) {
		int capitalid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_capitalid")),0);//�����ʲ�
		String number = Util.null2String(fu.getParameter("node_"+i+"_number"));//����
		if (number.equals("")) continue;
		String needdate = Util.null2String(fu.getParameter("node_"+i+"_needdate"));//��������
		String fee = Util.null2String(fu.getParameter("node_"+i+"_fee"));//��ط���
		if(fee.equals("")) fee = "0";
		String desc = Util.null2String(fu.getParameter("node_"+i+"_remark"));//��ע
		String para = ""+requestid+flag+capitalid+flag+number+flag+needdate+flag+fee+flag+desc;
		RecordSet.executeProc("bill_Discard_Detail_Insert",para);	
	}
}

boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
    //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
    out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
    return ;
}

//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-���ʲ����� ==��ʼ==
if(src.equals("submit")&&RequestManager.getNextNodetype().equals("3")){
	//int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	for(int i=0;i<rowsum;i++) {
		String capitalid = Util.null2String(fu.getParameter("node_"+i+"_capitalid"));//�����ʲ�
		String discarddate = Util.null2String(fu.getParameter("node_"+i+"_needdate"));//��������
		String capitalnum = Util.null2String(fu.getParameter("node_"+i+"_number"));//����
		if(capitalnum.equals("")) capitalnum = "0";
		String fee = Util.null2String(fu.getParameter("node_"+i+"_fee"));//��ط���
		if(fee.equals("")){
			fee = "0";
		}
		String sptcount = "";//sptcount1Ϊ1��ʾ��������
		RecordSet.executeProc("CptCapital_SelectByID",capitalid);
    if(RecordSet.next()){
    	sptcount = RecordSet.getString("sptcount");
    }
		if(sptcount.equals("")) sptcount = "0";
		
		String tempremark = Util.null2String(fu.getParameter("node_"+i+"_remark"));//��ע		

		char separator = Util.getSeparator() ;
		String para = "";
		if(sptcount.equals("1")){
			para = capitalid;
			para +=separator+discarddate;
			para +=separator+"0";
			para +=separator+"0";
			para +=separator+"1";
			para +=separator+"";
			para +=separator+"0";
			para +=separator+"";
			para +=separator+fee;
			para +=separator+"5";
			para +=separator+tempremark;
			para +=separator+sptcount;
			RecordSet.executeProc("CptUseLogDiscard_Insert",para);
		}else{
			para = capitalid;
			para +=separator+discarddate;
			para +=separator+"0";
			para +=separator+"0";
			para +=separator+capitalnum;
			para +=separator+"";
			para +=separator+"0";
			para +=separator+"";
			para +=separator+fee;
			para +=separator+"5";
			para +=separator+tempremark;
			para +=separator+sptcount;
			
			RecordSet.executeProc("CptUseLogDiscard_Insert",para);
		}
		CapitalComInfo.removeCapitalCache();
		
		//���¶�������
		BigDecimal old_frozennum = new BigDecimal("0");
		BigDecimal new_frozennum = new BigDecimal("0");
		RecordSet.executeSql("select frozennum as old_frozennum from CptCapital where id="+capitalid);
		if(RecordSet.next()){
		    String temp = Util.null2String(RecordSet.getString("old_frozennum"));
		    if(!temp.equals("")) old_frozennum = new BigDecimal(temp);
		}
		new_frozennum = old_frozennum.subtract(new BigDecimal(capitalnum));
		RecordSet.executeSql("update CptCapital set frozennum="+new_frozennum+" where id="+capitalid);
    
	}
}
//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-���ʲ����� ==����==

boolean logstatus = RequestManager.saveRequestLog() ;

//response.sendRedirect("/workflow/request/RequestView.jsp");
out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
%>