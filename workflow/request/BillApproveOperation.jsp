<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.lang.* "%>
<%@ page import="java.net.*" %>
 <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="RequestTransactionManager" class="weaver.workflow.request.RequestTransactionManager" scope="page"/>
<jsp:useBean id="RequestCheckAddinRules" class="weaver.workflow.request.RequestCheckAddinRules" scope="page"/>
<jsp:useBean id="ApproveParameter" class="weaver.workflow.request.ApproveParameter" scope="page"/>

<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />

<%
String src = Util.null2String(request.getParameter("src"));
String iscreate = Util.null2String(request.getParameter("iscreate"));
int requestid = Util.getIntValue(request.getParameter("requestid"),-1);
int workflowid = Util.getIntValue(request.getParameter("workflowid"),-1);
int docid = Util.getIntValue(request.getParameter("docid"),-1);
String  docsubject = Util.fromScreen(request.getParameter("docsubject"),user.getLanguage());
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
int isfromdoc = Util.getIntValue(request.getParameter("isfromdoc"),-1);         //�Ƿ���ĵ���ʾҳ���ύ����������

char flag = 2 ;
String Procpara = "" ;
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
//String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
//String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
String CurrentDate = RequestManager.getCurrentDate();
String CurrentTime = RequestManager.getCurrentTime();
if(CurrentDate.equals("")){
	CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
}

if(CurrentTime.equals("")){
	CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
}

int userid = user.getUID();
String logintype = user.getLogintype();
if(requestlevel.equals("")) requestlevel="0";
if(messageType.equals("")) messageType="0";
 String strSql="select d.docsubject,s.approveworkflowid from  docseccategory s "+
                               "right join docdetail d  on s.id=d.seccategory where d.id="+docid;        
  RecordSet.executeSql(strSql);
   if(RecordSet.next()) {
     docsubject=Util.null2String(RecordSet.getString("docsubject"));
     workflowid=Util.getIntValue(RecordSet.getString("approveworkflowid"));
                }
                
      //������ʱ���ܴ�����������SESSION�Ŀͻ������⣬���������ʼ��
      ApproveParameter.resetParameter();
      ApproveParameter.setWorkflowid(workflowid);
      ApproveParameter.setNodetype("0");
      ApproveParameter.setApproveid(docid);
      ApproveParameter.setApprovetype("9");
      ApproveParameter.setRequestname(docsubject);          
      ApproveParameter.setGopage("/docs/docs/DocApprove.jsp?id=");
      ApproveParameter.setBackpage("/docs/docs/DocApprove.jsp?id="); 
              

if(src.equals("submit")&&iscreate.equals("1")) {//�½�requestʱ
	workflowid=ApproveParameter.getWorkflowid();
	formid=ApproveParameter.getFormid();
	requestname=ApproveParameter.getRequestname();
	nodeid=ApproveParameter.getNodeid();
	nodetype=ApproveParameter.getNodetype();
}
isbill=1;
if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    //response.sendRedirect("/notice/RequestError.jsp");
	out.print("<script>try{parent.location.href='/notice/RequestError.jsp';}catch(e){}</script>");
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
RequestManager.setUser(user) ;
RequestManager.setRequestid(requestid);
RequestManager.setBilltablename("bill_Approve");        // ����������bill ������
//add by xhheng @ 2005/01/24 for ��Ϣ���� Request06
RequestManager.setMessageType(messageType) ;


boolean savestatus = true ;

//���Ǵ��ĵ���ʾҳ���ύ���������Ĳ���saveRequestInfo����������ĵ���ʾҳ��û�е��ݵ��ֶ���Ϣ�������
if( isfromdoc != 1 )  {
    savestatus = RequestManager.saveRequestInfo() ;   
    requestid = RequestManager.getRequestid() ;

    if(src.equals("submit")&&iscreate.equals("1")) {//�½�requestʱ
	    if(requestid<=0&&docid>=1&&"9".equals(ApproveParameter.getApprovetype()+"")){
			RecordSet.executeSql("update DocDetail set docStatus='0' where id="+docid);
		}
	}
    if( !savestatus ) {
        if( requestid != 0 ) {

            String message=RequestManager.getMessage();
                if(!"".equals(message)){
			    out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message="+message+"');</script>");
                return ;
            }

            //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
            out.print("<script>try{parent.location.href='/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1';}catch(e){}</script>");
    		return ;
        }
        else {
            //response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
            out.print("<script>try{parent.location.href='/workflow/request/RequestView.jsp?message=1';}catch(e){}</script>");
            return ;
        }
    }
}



String approveid= "" ;
String approvetype= "" ;
String gopage = "" ;
String backpage = "" ;

if(src.equals("submit")&&iscreate.equals("1")) {//�½�requestʱ
    billid = RequestManager.getBillid() ;
    approveid=ApproveParameter.getApproveid()+"";
	approvetype=ApproveParameter.getApprovetype()+"";
	gopage=ApproveParameter.getGopage();
	backpage=ApproveParameter.getBackpage();
    
    String updateclause="set ";
    updateclause+= "approveid="+approveid+",approvetype="+approvetype+",gopage='"+gopage+"',status='0'";
	updateclause="update bill_Approve "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);
}
else {
    RecordSet.executeProc("Bill_Approve_SelectByID",billid+"");
    if (RecordSet.next()) {
        approveid=RecordSet.getString("approveid");
        approvetype=RecordSet.getString("approvetype");
        gopage=RecordSet.getString("gopage");
    }
}


if (approvetype.equals("9"))    //�ĵ� 
    RequestManager.setDocids(approveid);
if (approvetype.equals("10"))    //�ͻ�
    RequestManager.setCrmids(approveid);
if (approvetype.equals("11"))    //��Ŀ
    RequestManager.setPrjids(approveid);


boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
    //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
	out.print("<script>try{parent.location.href='/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2';}catch(e){}</script>");
    return ;
}

boolean logstatus = RequestManager.saveRequestLog() ;


if(src.equals("submit")&&iscreate.equals("1")) {
	if( RequestManager.getNextNodetype().equals("3") ) {
		//дDocApproveRemark��
		RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"1");
		
		//Procpara= ""+userid+flag+"2"+flag+CurrentDate+flag+CurrentTime+flag+approveid;
		//RecordSet.executeProc("DocDetail_Approve",Procpara);
		DocManager.approveDocFromWF("approve",approveid,CurrentDate,CurrentTime,userid+"");
	}
  boolean  blnOsp = "true".equals(request.getParameter("blnOsp")) ;

  if (blnOsp){%>
    <SCRIPT LANGUAGE="JavaScript">   
        window.close(); 
        window.parent.returnValue="1";   
    </SCRIPT>
  <% return;   
  }
  
  String topage=URLDecoder.decode(Util.null2String(request.getParameter("topage")));
  String flagTASK=Util.null2String(request.getParameter("flagTASK"));  
  if(!topage.equals("")){
  	if(flagTASK.equals("1")){
		//response.sendRedirect("/docs/docs/DocDsp.jsp?fromFlowDoc=1&id="+docid+"&blnOsp="+blnOsp+"&topage="+URLEncoder.encode(topage));
  		out.print("<script>try{parent.location.href='/docs/docs/DocDsp.jsp?fromFlowDoc=1&id="+docid+"&blnOsp="+blnOsp+"&topage="+URLEncoder.encode(topage)+"';}catch(e){}</script>");
  	}else{            
      if(topage.indexOf("?")!=-1){ 
		//response.sendRedirect(topage+"&requestid="+requestid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime);
      	out.print("<script>try{parent.location.href='"+topage+"&requestid="+requestid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");
      }else{
      	//response.sendRedirect(topage+"?requestid="+requestid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime); 
		out.print("<script>try{parent.location.href='"+topage+"?requestid="+requestid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");      
      }
     }           
  }	else {
    //response.sendRedirect(backpage+approveid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime);
	out.print("<script>try{parent.location.href='"+backpage+approveid+"&isfromdoc=1"+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");
  }
  return;
}

else if(src.equals("save")&&iscreate.equals("0")){  //����request��ѡ�񱣴�logtype=1
	if(isremark==1){  //��¼ǩ�����
        //дDocApproveRemark��
        Procpara=approveid+flag+remark+flag+""+userid+flag+CurrentDate+flag+CurrentTime+flag+"2";
        RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
    }
}

else if(src.equals("submit")&&iscreate.equals("0")){//����request��ѡ���ύlogtype=2
    //дDocApproveRemark��
    if(nodetype.equals("0")) { // ��Ϊ����ע

        //Procpara= ""+userid+flag+"3"+flag+CurrentDate+flag+CurrentTime+flag+approveid;
    	//RecordSet.executeProc("DocDetail_Approve",Procpara);
    	//DocManager.approveDocFromWF("approve",approveid,CurrentDate,CurrentTime,userid+"");
    	if(!approveid.equals("")) RecordSet.executeSql("update DocDetail set docStatus='3'  where id="+approveid);
        Procpara=approveid+flag+remark+flag+""+userid+flag+CurrentDate+flag+CurrentTime+flag+"2";
    }
    else 
    {
		//DocManager.approveDocFromWF("approve",approveid,CurrentDate,CurrentTime,userid+"");
        Procpara=approveid+flag+remark+flag+""+userid+flag+CurrentDate+flag+CurrentTime+flag+"1";
	}

    RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
    
    boolean  blnOsp = "true".equals(request.getParameter("blnOsp")) ;

    if (blnOsp){%>
    <SCRIPT LANGUAGE="JavaScript">   
        window.close(); 
        window.parent.returnValue="1";   
    </SCRIPT>
    <% return;   
    }else{
    //��ת���ĵ������Ĳ���ҳ��ȥ�����ĵ���״̬�ı�
    if( RequestManager.getNextNodetype().equals("3") )    {
        RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"1");
        //Modified by xwj for td1951 on 2005-06-30
        if(!"".equals(gopage) && gopage !=null){
          if(gopage.indexOf("?") != -1){
            //response.sendRedirect(gopage.trim() + approveid + "&type=approve&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime); 
          	out.print("<script>try{parent.location.href='"+gopage.trim() + approveid + "&type=approve&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");
          }
          else{
            //response.sendRedirect(gopage.trim() + "?id=" + approveid + "&type=approve&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime);
          	out.print("<script>try{parent.location.href='"+gopage.trim() + "?id=" + approveid + "&type=approve&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");
          }
          
        }
        return;
    }
    }
}

else if(src.equals("reject")&&iscreate.equals("0")){//����request��ѡ���˻�logtype=3
    //дDocApproveRemark��
    Procpara=approveid+flag+remark+flag+""+userid+flag+CurrentDate+flag+CurrentTime+flag+"0";
    RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
     //Modified by xwj for td1951 on 2005-06-30
        if(!"".equals(gopage) && gopage !=null){
        if(gopage.indexOf("?") != -1){
          //response.sendRedirect(gopage.trim() + approveid + "&type=reject&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime); 
		  out.print("<script>try{parent.location.href='"+gopage.trim() + approveid + "&type=reject&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");        	
        }
        else{
          //response.sendRedirect(gopage.trim() + "?id=" + approveid + "&type=reject&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime);
          out.print("<script>try{parent.location.href='"+gopage.trim() + "?id=" + approveid + "&type=reject&requestid="+requestid+"&isfromdoc="+isfromdoc+"&currentDate="+CurrentDate+"&currentTime="+CurrentTime+"';}catch(e){}</script>");
        }
        }
    return;
}

else if(src.equals("active")){//����request logtype=6
	// ���Ϊ�����ڵ�, �� bill_hrmtime ���״̬��Ϊ 1
	if( RequestManager.getNextNodetype().equals("3") ) 
		RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"1");
	else
		RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"0");

}

else if(src.equals("delete")&&iscreate.equals("0")){//����request��ѡ��ɾ��logtype=5
	// �� bill_Approve ���״̬��Ϊ 2
	RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"2");
}


//response.sendRedirect("/workflow/request/RequestView.jsp");
out.print("<script>try{parent.location.href='/workflow/request/RequestView.jsp';}catch(e){}</script>");
%>