<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.lang.* "%>
<%@ page import="java.util.* "%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.net.*" %>
<%@ page import="weaver.WorkPlan.WorkPlanLogMan" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="RequestCheckAddinRules" class="weaver.workflow.request.RequestCheckAddinRules" scope="page"/>
<jsp:useBean id="WorkPlanViewer" class="weaver.WorkPlan.WorkPlanViewer" scope="page"/>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/><!--xwj for td3450 20060111-->
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>
<%@ page import="weaver.file.FileUpload" %>
<%
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

FileUpload fu = new FileUpload(request);

int userid = user.getUID();
String logintype = user.getLogintype();

String method=Util.fromScreen(fu.getParameter("method"),user.getLanguage());
String src=Util.fromScreen(fu.getParameter("src"),user.getLanguage());
String iscreate=Util.fromScreen(fu.getParameter("iscreate"),user.getLanguage());
int workflowid=Util.getIntValue(fu.getParameter("workflowid"),-1);
String workflowtype = Util.null2String(fu.getParameter("workflowtype"));
int nodeid=Util.getIntValue(fu.getParameter("nodeid"),-1);
String nodetype=Util.fromScreen(fu.getParameter("nodetype"),user.getLanguage());
int formid = Util.getIntValue(fu.getParameter("formid"),-1);
int billid = Util.getIntValue(fu.getParameter("billid"),0);
int isremark = Util.getIntValue(fu.getParameter("isremark"),-1);

int lastnodeid = Util.getIntValue(fu.getParameter("nodeid"),-1);
String lastnodetype = Util.null2String(fu.getParameter("nodetype"));
int requestid=Util.getIntValue(fu.getParameter("requestid"),-1);
String remark = Util.null2String(fu.getParameter("remark"));
String clientip=fu.getRemoteAddr();

String requestname = Util.null2String(fu.getParameter("requestname"));
int requestlevel = Util.getIntValue(Util.null2String(fu.getParameter("requestlevel")),0);

if( src.equals("") || workflowid == -1 || formid == -1 || nodeid == -1 || nodetype.equals("") ) {
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
RequestManager.setIsbill(1) ;
RequestManager.setBillid(billid) ;
RequestManager.setNodeid(nodeid) ;
RequestManager.setNodetype(nodetype) ;
RequestManager.setRequestname(requestname) ;
RequestManager.setRequestlevel(""+requestlevel) ;
RequestManager.setRemark(remark) ;
RequestManager.setRequest(fu) ;
RequestManager.setUser(user) ;

boolean savestatus = RequestManager.saveRequestInfo() ;//����������Ϣ
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
        
char flag=Util.getSeparator() ;
String topage = "";

int nodesnum = Util.getIntValue(fu.getParameter("rownum"),0);
String submitman = ""+userid;
String allaccepterid = "";
for(int i=0 ; i < nodesnum ; i++){//������ϸ��
    String creatertype = "";
    if(logintype.equals("1"))   creatertype = "0";
    if(logintype.equals("2"))   creatertype = "1";
    //ҳ���ֶ���Ϣ
    String name=Util.null2String(fu.getParameter("name_"+i)) ;//����
    String resourceid=Util.null2String(fu.getParameter("resourceid_"+i)) ;//������
    String accepterid=Util.null2String(fu.getParameter("accepterid_"+i)) ;//������
    if(!accepterid.equals("")){
        if(allaccepterid.equals("")) allaccepterid = accepterid;
        else allaccepterid += ","+accepterid;
    }
    String reqlevelD=Util.null2String(fu.getParameter("requestlevel_"+i));//�����̶�
    int isopen=Util.getIntValue(fu.getParameter("isopen_"+i),0);//�Ƿ񿪷�
    String begindate=Util.null2String(fu.getParameter("begindate_"+i));//��ʼ����
    String begintime=Util.null2String(fu.getParameter("begintime_"+i));//��ʼʱ��
    String enddate=Util.null2String(fu.getParameter("enddate_"+i));//��������
    String endtime=Util.null2String(fu.getParameter("endtime_"+i));//����ʱ��
    String wakedate=Util.null2String(fu.getParameter("wakedate_"+i));//��������
    String delaydate=Util.null2String(fu.getParameter("delaydate_"+i));//��������
    String summary=Util.fromScreen2(fu.getParameter("summary_"+i),user.getLanguage());//��ϸ˵��

    int projectid=Util.getIntValue(fu.getParameter("projectid_"+i),0); //�����Ŀ
    int crmid=Util.getIntValue(fu.getParameter("crmid_"+i),0);//��ؿͻ�
    int relatedrequestid=Util.getIntValue(fu.getParameter("relatedrequestid_"+i),0);//�������
    
    String detailid=Util.null2String(fu.getParameter("detailid_"+i)) ;//��ϸkey
    String updateSQL = "";
    if(detailid.equals("")){//�½��ƻ�
        updateSQL="insert into bill_hrmtimedetail (requestid,name,resourceid,accepterid,"+
                  "begindate,begintime,enddate,endtime,wakedate,delaydate,crmid,"+
                  "projectid,relatedrequestid,isopen,remark,requestlevel) "+
                  "values ("+requestid+",'"+name+"',"+resourceid+",'"+accepterid+"','"+
                  begindate+"','"+begintime +"','"+enddate+"','"+endtime+"','"+wakedate+"','"+
                  delaydate+"',"+crmid+","+projectid+","+relatedrequestid+
                  ","+isopen+",'"+summary+"',"+reqlevelD+")";
    }else{//�޸ļƻ�
        updateSQL="update bill_hrmtimedetail set "+
                  "requestid="+requestid+","+
                  "name='"+name+"',"+
                  "resourceid="+resourceid+","+
                  "accepterid='"+accepterid+"',"+
                  "begindate='"+begindate+"',"+
                  "begintime='"+begintime+"',"+
                  "enddate='"+enddate+"',"+
                  "endtime='"+endtime+"',"+
                  "wakedate='"+wakedate+"',"+
                  "delaydate='"+delaydate+"',"+
                  "crmid="+crmid+","+
                  "projectid="+projectid+","+
                  "relatedrequestid="+relatedrequestid+","+
                  "isopen="+isopen+","+
                  "remark='"+summary+"',"+
                  "requestlevel="+reqlevelD+" "+
                  "where id="+detailid;
    }
    RecordSet.executeSql(updateSQL);
    
    //����ĵ�����
    if(detailid.equals("")){
        RecordSet.executeSql("select max(id) as id from bill_hrmtimedetail");
        if(RecordSet.next())
            detailid = RecordSet.getString("id");
    }
    int relatedrow=Util.getIntValue(Util.null2String(request.getParameter("relatedrow")),-1);//����������
    if(method.equals("docnew")&&relatedrow==i){//�½��ĵ�
        topage = URLEncoder.encode("/workflow/request/ResourcePlanOperation.jsp?method=docnewdone&detailid="+detailid);        
    }else if(method.equals("docadd")&&relatedrow==i){
        String docid=Util.null2String(fu.getParameter("docid"));
        String alldoc="";
        RecordSet.executeSql("select alldoc from bill_hrmtime where requestid="+requestid);
        if(RecordSet.next())
            alldoc=RecordSet.getString("alldoc");
        if(alldoc.equals("")) alldoc=docid;
        else alldoc+=","+docid;
        RecordSet.executeSql("update bill_hrmtime set alldoc='"+alldoc+"' where requestid="+requestid);//��������
            
        String detaildocs = "";
        RecordSet.executeSql("select alldoc from bill_hrmtimedetail where id="+detailid);
        if(RecordSet.next()) detaildocs = RecordSet.getString("alldoc");
        if(detaildocs.equals("")) detaildocs=docid;
        else  detaildocs+=","+docid;
        RecordSet.executeSql("update bill_hrmtimedetail set alldoc='"+detaildocs+"' where id="+detailid);//������ϸ��
            
        //���ĵ�idд��requestbase��ʵ�ֹ���
        RecordSet.executeSql("update workflow_requestbase set docids='"+alldoc+"' where requestid="+requestid);  
    }else if(method.equals("docdel")&&relatedrow==i){
        String docid=Util.null2String(fu.getParameter("docid"));
        String alldoc="";
        RecordSet.executeSql("select alldoc from bill_hrmtime where requestid="+requestid);
        if(RecordSet.next()) alldoc=RecordSet.getString("alldoc");
        if(!alldoc.equals("")){
            alldoc=Util.remove(","+alldoc,","+docid);
        }
        if(!alldoc.equals("")) alldoc=alldoc.substring(1);
        RecordSet.executeSql("update bill_hrmtime set alldoc='"+alldoc+"' where requestid="+requestid);//��������
        
        String detaildocs = "";
        RecordSet.executeSql("select alldoc from bill_hrmtimedetail where id="+detailid);
        if(RecordSet.next()) detaildocs=RecordSet.getString("alldoc");
        if(!detaildocs.equals("")){
            detaildocs=Util.remove(","+detaildocs,","+docid);
        }
        if(!detaildocs.equals("")) detaildocs=alldoc.substring(1);
        RecordSet.executeSql("update bill_hrmtimedetail set alldoc='"+detaildocs+"' where id="+detailid);//������ϸ��
        
        //���ĵ�idд��requestbase��ʵ�ֹ���
        RecordSet.executeSql("update workflow_requestbase set docids='"+alldoc+"' where requestid="+requestid); 
        
    }
    //����ĵ�����
    
    if(src.equals("submit")&&nodetype.equals("0")){//�����ڵ��ύ�����ճ�
        //String accepterids[] = Util.TokenizerString2(accepterid,",");
        //for(int j=0; j < accepterids.length; j++){//��ӹ����ƻ�
            WorkPlan workPlan = new WorkPlan();
            workPlan.setCreaterId(Integer.parseInt(resourceid));
            workPlan.setWorkPlanType(Integer.parseInt(Constants.WorkPlan_Type_Plan));        
            workPlan.setWorkPlanName(name);    
            workPlan.setUrgentLevel(reqlevelD);
            workPlan.setRemindType(Constants.WorkPlan_Remind_No);  
            workPlan.setResourceId(accepterid);	        
            workPlan.setBeginDate(begindate);
            if(null != begintime && !"".equals(begintime)){
                workPlan.setBeginTime(begintime);  //��ʼʱ��
            }else{
                workPlan.setBeginTime(Constants.WorkPlan_StartTime);  //��ʼʱ��
            }
            workPlan.setEndDate(enddate);
            if(null != enddate && !"".equals(enddate) && (null == endtime || "".equals(endtime))){
                workPlan.setEndTime(Constants.WorkPlan_EndTime);  //����ʱ��
            }else{
                workPlan.setEndTime(endtime);  //����ʱ��
            }
            workPlan.setDescription(Util.convertInput2DB(summary));
            workPlan.setCustomer(String.valueOf(crmid));
            workPlan.setProject(String.valueOf(projectid));
            workPlan.setWorkflow(relatedrequestid+","+requestid);

            workPlanService.insertWorkPlan(workPlan);  //�����ճ�

            //������־
            WorkPlanLogMan logMan = new WorkPlanLogMan();
            String[] logParams = new String[] {String.valueOf(workPlan.getWorkPlanID()), WorkPlanLogMan.TP_CREATE, resourceid, fu.getRemoteAddr()};
            logMan.writeViewLog(logParams);
        //}
    } 
}

//����������Ϣ�����µ������ֶθ��ڵ������������Դ�ֶ��й�
RecordSet.executeSql("update bill_hrmtime set resourceid="+submitman+",accepterid='"+allaccepterid+"' where requestid="+requestid);
RecordSet.executeSql("update workflow_requestbase set requestlevel="+requestlevel+" where requestid="+requestid);


boolean flowstatus = RequestManager.flowNextNode() ;//����������һ���ڵ�
if( !flowstatus ) {
	//response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
	out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
	return ;
}


if(method.equals("docnew")){
    //response.sendRedirect("/docs/docs/DocList.jsp?topage="+topage+"&showsubmit=0");
    out.print("<script>wfforward('/docs/docs/DocList.jsp?topage="+topage+"&showsubmit=0');</script>");
    return;
}else if(method.equals("docadd")||method.equals("docdel")||src.equals("save")){
	//response.sendRedirect("ViewRequest.jsp?requestid="+requestid);
    out.print("<script>wfforward('ViewRequest.jsp?requestid="+requestid+"');</script>");
    return; 
}

if(method.equals("docnewdone")){
    String docid=Util.fromScreen(request.getParameter("docid"),user.getLanguage());
    String detailid=Util.fromScreen(request.getParameter("detailid"),user.getLanguage());
    String alldoc="";
    RecordSet.executeSql("select alldoc from bill_hrmtime where requestid="+requestid);
    if(RecordSet.next())
        alldoc=RecordSet.getString("alldoc");
    if(alldoc.equals(""))   alldoc=docid;
    else    alldoc+=","+docid;
    RecordSet.executeSql("update bill_hrmtime set alldoc='"+alldoc+"' where requestid="+requestid);//��������
    
    String detaildocs = "";
    RecordSet.executeSql("select alldoc from bill_hrmtimedetail where id="+detailid);
    if(RecordSet.next()) detaildocs = RecordSet.getString("alldoc");
    if(detaildocs.equals("")) detaildocs=docid;
    else  detaildocs+=","+docid;
    RecordSet.executeSql("update bill_hrmtimedetail set alldoc='"+detaildocs+"' where id="+detailid);//������ϸ��
    
    //���ĵ�idд��requestbase��ʵ�ֹ���
    RecordSet.executeSql("update workflow_requestbase set docids='"+alldoc+"' where requestid="+requestid);       
       
	//response.sendRedirect("ViewRequest.jsp?requestid="+requestid);
    out.print("<script>wfforward('ViewRequest.jsp?requestid="+requestid+"');</script>");
    return;    
}
if(src.equals("deleteall")){
    String sqltmp="update bill_hrmtime set status='2' where requestid = "+requestid;
    RecordSet.executeSql(sqltmp);
    sqltmp="update workflow_requestbase set deleted='1' where requestid = "+requestid;
    RecordSet.executeSql(sqltmp);
}
	//response.sendRedirect("/workflow/request/RequestView.jsp");
	if(formid==6){	
		out.print("<script>window.top.close();</script>");
	}else{
		out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
	}
%>