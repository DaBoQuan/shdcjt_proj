<%@ page language="java" contentType="text/html; charset=GBK" %> 

<%@ page import="java.net.*" %>
<%@ page import="weaver.file.FileUpload" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>


<%@ include file="/systeminfo/init.jsp" %>

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
String requestname = Util.fromScreen3(fu.getParameter("name"),user.getLanguage());
//ͼ�λ����̣���������Ϊrequestname
if(requestname.equals("")) requestname = Util.fromScreen3(fu.getParameter("requestname"),user.getLanguage());
String requestlevel = Util.fromScreen(fu.getParameter("requestlevel"),user.getLanguage());
String messageType =  Util.fromScreen(fu.getParameter("messageType"),user.getLanguage());
String remark = Util.null2String(fu.getParameter("remark"));
String method = Util.fromScreen(fu.getParameter("method"),user.getLanguage()); // ��Ϊ�½��ĵ�ʱ��Ĳ�������
String topage=URLDecoder.decode(Util.null2String(fu.getParameter("topage")));  //���ص�ҳ��
String submitNodeId=Util.null2String(fu.getParameter("submitNodeId"));
String Intervenorid=Util.null2String(fu.getParameter("Intervenorid"));
int isovertime = Util.getIntValue(fu.getParameter("isovertime"),0);

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
RequestManager.setSubmitNodeId(submitNodeId);
RequestManager.setIntervenorid(Intervenorid);
RequestManager.setMessageType(messageType) ;
RequestManager.setUser(user) ;
//add by chengfeng.han 2011-7-28 td20647 
int isagentCreater = Util.getIntValue((String)session.getAttribute(workflowid+"isagent"+user.getUID()));
int beagenter = Util.getIntValue((String)session.getAttribute(workflowid+"beagenter"+user.getUID()),0);
RequestManager.setIsagentCreater(isagentCreater);
RequestManager.setBeAgenter(beagenter);
//end
boolean savestatus = RequestManager.saveRequestInfo() ;
requestid = RequestManager.getRequestid() ;
billid=RequestManager.getBillid() ;
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

String triggerStatus=(String)session.getAttribute("triggerStatus"); 
session.removeAttribute("triggerStatus");
if( !flowstatus&&triggerStatus!=null&&triggerStatus.equals("1") ) {
	//response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=3");
	out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=3');</script>");
	return ;
}

if( !flowstatus ) {
	//response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
	out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
	return ;
}
boolean logstatus = RequestManager.saveRequestLog() ;

String nextnodetype=RequestManager.getNextNodetype();

char flag=Util.getSeparator() ;

//�õ�ҳ���ֶε�ֵ
String name=Util.fromScreen(fu.getParameter("name"),user.getLanguage());
int resourceid=Util.getIntValue(fu.getParameter("resourceid"),0);

String namelabel = "";
String resourceidlabel = "";
RecordSet.executeSql("select * from workflow_billfield where billid = 11");
while(RecordSet.next()){
	if(RecordSet.getString("fieldname").equals("name")) namelabel = RecordSet.getString("id");
	if(RecordSet.getString("fieldname").equals("resourceid")) resourceidlabel = RecordSet.getString("id");
}

if(name.equals("")) name = Util.fromScreen(fu.getParameter("field"+namelabel),user.getLanguage());
if(resourceid==0) resourceid = Util.getIntValue(fu.getParameter("field"+resourceidlabel),0);

String basictype="4";

if(src.equals("save")&&iscreate.equals("1")) {//�½�request��ѡ�񱣴�

	RecordSet.executeSql("update Bill_HrmTime set resourceid="+resourceid+",basictype="+basictype+
					",requestid="+requestid+",billid="+formid+",name='"+name+"',status='0' where id = "+billid);

        if(!topage.equals("")){
        	if(topage.indexOf("?")!=-1){
        		//response.sendRedirect(topage+"&requestid="+requestid);
        		out.print("<script>wfforward('"+topage+"&requestid="+requestid+"');</script>");
        	}else{
				//response.sendRedirect(topage+"?requestid="+requestid);
				out.print("<script>wfforward('"+topage+"?requestid="+requestid+"');</script>");
			}
		}
}
if(src.equals("submit")&&iscreate.equals("1")) {//�½�request��ѡ���ύ

	RecordSet.executeSql("update Bill_HrmTime set resourceid="+resourceid+",basictype="+basictype+
					",requestid="+requestid+",billid="+formid+",name='"+name+"',status='0' where id = "+billid);

        if(!topage.equals("")){
        	if(topage.indexOf("?")!=-1){
        		//response.sendRedirect(topage+"&requestid="+requestid);
        		out.print("<script>wfforward('"+topage+"&requestid="+requestid+"');</script>");
        	}else{
				//response.sendRedirect(topage+"?requestid="+requestid);
				out.print("<script>wfforward('"+topage+"?requestid="+requestid+"');</script>");
			}
		}
}
	
	
if(src.equals("delete")&&iscreate.equals("0")){//����request��ѡ��ɾ��logtype=5

        // �� bill_hrmtime ���״̬��Ϊ 2
        RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"2");
}

if(src.equals("save")&&iscreate.equals("0")){//����request��ѡ�񱣴�logtype=1

}

if(src.equals("submit")&&iscreate.equals("0")){//����request��ѡ���ύlogtype=2

         if(nextnodetype.equals("3")){
         	RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"1");
         }
}

if(src.equals("reject")&&iscreate.equals("0")){//����request��ѡ���˻�logtype=3

}

if(src.equals("reopen")&&iscreate.equals("0")){//����request��ѡ�����´�logtype=4

}

if(src.equals("active")){//����request logtype=6

        // ���Ϊ�����ڵ�, �� bill_hrmtime ���״̬��Ϊ 1
        if(nodetype.equals("3")) 
            RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"1");
        else
            RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"0");
}

        if(iscreate.equals("1")){
			//response.sendRedirect("/workflow/request/RequestView.jsp");
			out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
        }else{
			if("delete".equals(src) && savestatus && flowstatus){%>
				<SCRIPT LANGUAGE="JavaScript">
				alert("<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15242,user.getLanguage())%>");
                //window.close();
                	try{
			    	    window.close();
			    	    window.opener._table.reLoad();
			    	}catch(e){}
			    	try{
			    	    parent.window.close();
			    	    parent.window.opener._table.reLoad();
			    	}catch(e){}
			        window.history.go(-2);
			   		try{	
			   			parent.window.opener.btnWfCenterReload.onclick();
			   		}catch(e){}
			   		try{
			   			parent.window.opener.reLoad();
			   		}catch(e){}
                
				</SCRIPT>
            <%
			}else{
				String isShowPrompt="true";
				//response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&fromoperation=1&updatePoppupFlag=1&isShowPrompt="+isShowPrompt+"&src="+src+"&isovertime="+isovertime+"&urger="+urger+"&isintervenor="+isintervenor);//td3450 xwj 20060207
				out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&fromoperation=1&updatePoppupFlag=1&isShowPrompt="+isShowPrompt+"&src="+src+"&isovertime="+isovertime+"');</script>");
            }
        }
%>