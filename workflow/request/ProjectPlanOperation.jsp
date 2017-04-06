<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.lang.* "%>
<%@ page import="java.util.* "%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="RequestCheckAddinRules" class="weaver.workflow.request.RequestCheckAddinRules" scope="page"/>
<%
int userid = user.getUID();
String logintype = user.getLogintype();

String src=Util.fromScreen(request.getParameter("src"),user.getLanguage());
String iscreate=Util.fromScreen(request.getParameter("iscreate"),user.getLanguage());
int workflowid=Util.getIntValue(request.getParameter("workflowid"),-1);
int nodeid=Util.getIntValue(request.getParameter("nodeid"),-1);
String nodetype=Util.fromScreen(request.getParameter("nodetype"),user.getLanguage());
int formid = Util.getIntValue(request.getParameter("formid"),-1);
int billid = Util.getIntValue(request.getParameter("billid"),0);

int lastnodeid = Util.getIntValue(request.getParameter("nodeid"),-1);
String lastnodetype = Util.null2String(request.getParameter("nodetype"));
int requestid=Util.getIntValue(request.getParameter("requestid"),-1);
String requestname=Util.fromScreen(request.getParameter("name"),user.getLanguage());
String clientip=request.getRemoteAddr();
String remark = Util.null2String(request.getParameter("remark"));
String signdocids = Util.null2String(request.getParameter("signdocids"));
String signworkflowids = Util.null2String(request.getParameter("signworkflowids"));
int linkid = 0;
String linkname="";
int destnodeid=0;
int totalgroups=0;
int passedgroups=0;
float nodepasstime=-1;

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
        	
char flag=Util.getSeparator() ;
String Procpara="";
String sql="";


//�õ�ҳ���ֶε�ֵ
String projectid=Util.fromScreen(request.getParameter("projectid"),user.getLanguage());
String name=Util.fromScreen(request.getParameter("name"),user.getLanguage());
String resourceid=Util.fromScreen(request.getParameter("resourceid"),user.getLanguage());
String subprojectid=Util.fromScreen(request.getParameter("subprojectid"),user.getLanguage());
String plantype=Util.fromScreen(request.getParameter("plantype"),user.getLanguage());
String plansort=Util.fromScreen(request.getParameter("plansort"),user.getLanguage());
String begindate=Util.fromScreen(request.getParameter("begindate"),user.getLanguage());
String begintime=Util.fromScreen(request.getParameter("begintime"),user.getLanguage());
String enddate=Util.fromScreen(request.getParameter("enddate"),user.getLanguage());
String endtime=Util.fromScreen(request.getParameter("endtime"),user.getLanguage());
String docid=Util.fromScreen(request.getParameter("docid"),user.getLanguage());
String budgetmoney=Util.fromScreen(request.getParameter("budgetmoney"),user.getLanguage());
String summary=Util.fromScreen(request.getParameter("summary"),user.getLanguage());
if(budgetmoney.equals(""))	budgetmoney="0";
String basictype="1";
String detailtype="1";

String totaldays="0";
String totalhours="0";

if(src.equals("save")&&iscreate.equals("1")) {//�½�request��ѡ�񱣴�
	RecordSet.executeProc("workflow_RequestID_Update","");
    RecordSet.next();
    requestid = RecordSet.getInt(1);
        
    String creatertype = "";
	if(logintype.equals("1"))
	   	creatertype = "0";
	if(logintype.equals("2"))
	   	creatertype = "1";
       	
    //�����ֶ���Ϣ	
    Procpara=resourceid + flag + requestid + flag + formid + flag + basictype+flag+detailtype+flag+
    	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
    	name + flag + "" + flag + summary + flag + totaldays + flag +
    	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
    	"" + flag + "0" + flag + 
    	plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";
    
    RecordSet.executeProc("bill_HrmTime_Insert",Procpara);
    RecordSet.next();
    billid=RecordSet.getInt(1);
    sql="insert into workflow_form (requestid,billformid,billid) values("+
    	requestid+","+formid+","+billid+")";
    RecordSet.executeSql(sql);
	//�ڵ��Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(nodeid);
        RequestCheckAddinRules.setObjtype(1);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();
        
	RecordSet.executeProc("workflow_NodeLink_SelectPasstime",""+nodeid+flag+"-1");
	if(RecordSet.next())
		nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
		
        //����request�ܱ���Ϣ
        
        Procpara=requestid+""+ flag + workflowid+"" + flag + "" + flag + "" + flag 
        		+ nodeid+"" + flag + nodetype + flag + SystemEnv.getHtmlLabelName(125,user.getLanguage()) + flag
        		+ "" + flag + "" + flag + requestname + flag + userid+"" + flag + CurrentDate + flag
        		+ CurrentTime + flag + "" + flag + "" + flag + "" + flag + ""+ flag + creatertype+ flag + ""+flag
        		+nodepasstime+flag+nodepasstime;
        RecordSet.executeProc("workflow_Requestbase_Insert",Procpara);
        out.print(Procpara);
        //����LOG����Ϣ
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "1" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip + flag + creatertype
        	+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        
        //����operator��Ϣ
        String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
        Procpara=requestid+"" + flag + userid+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+ flag + creatertype + flag +"0";
        RecordSet.executeProc("workflow_CurrentOperator_Insert",Procpara);
        
        String topage=URLDecoder.decode(Util.null2String(request.getParameter("topage")));
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
	RecordSet.executeProc("workflow_RequestID_Update","");
        RecordSet.next();
        requestid = RecordSet.getInt(1);
        
        String creatertype = "";
	if(logintype.equals("1"))
	     	creatertype = "0";
	if(logintype.equals("2"))
	       	creatertype = "1";
	       	
        //�����ֶ���Ϣ
        Procpara=resourceid + flag + requestid + flag + formid + flag + basictype + flag + detailtype+ flag +
        	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
        	name + flag + "" + flag + summary + flag + totaldays + flag +
        	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
        	"" + flag + "0" + flag +
        	plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";
        
        RecordSet.executeProc("bill_HrmTime_Insert",Procpara);
        RecordSet.next();
        billid=RecordSet.getInt(1);
        sql="insert into workflow_form (requestid,billformid,billid) values("+
        	requestid+","+formid+","+billid+")";
        RecordSet.executeSql(sql);
	//��ѯ��һ�ڵ�
	RecordSet.executeProc("workflow_NodeLink_Select",nodeid+""+flag+"0"+flag+""+requestid);
	ArrayList whereclauses=new ArrayList();
	ArrayList linkids=new ArrayList();
	ArrayList linknames=new ArrayList();
	ArrayList destnodeids=new ArrayList();
	while(RecordSet.next()){
		//whereclauses.add(RecordSet.getString("condition"));
		linknames.add(RecordSet.getString("linkname"));
		linkids.add(RecordSet.getString("id"));
		destnodeids.add(RecordSet.getString("destnodeid"));
		
		weaver.workflow.node.NodeInfo nodeInfo = new weaver.workflow.node.NodeInfo();
		if(RecordSet.getDBType().equals("oracle"))
			whereclauses.add(nodeInfo.getConditionStr(RecordSet.getString("id")));
		else
			whereclauses.add(RecordSet.getString("condition"));
	}
	int i=0;
	for(i=0;i<destnodeids.size();i++){
		String where=(String)whereclauses.get(i);
		if(where.trim().equals(""))	break;
		else{
			sql="select * from workflow_form where requestid="+requestid+" and "+where;
			RecordSet.executeSql(sql);
			if(RecordSet.next())	break;
		}
	}
	linkid=Util.getIntValue(""+linkids.get(i),0);
	linkname=(String) linknames.get(i);
	destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
	RecordSet.executeProc("workflow_NodeLink_SelectPasstime",""+nodeid+flag+"-1");
	if(RecordSet.next())
		nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
        //����LOG����Ϣ
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "2" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+ flag + creatertype
        	+ flag + ""+destnodeid+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        
	//����request�ܱ���Ϣ        
        RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
        RecordSet.next();
        String destnodetype=RecordSet.getString(1);
        
        sql="select count(id) from workflow_nodegroup where nodeid = "+destnodeid;
        RecordSet.executeSql(sql);
        if(RecordSet.next())
        	totalgroups = RecordSet.getInt(1);
        	
        Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
        		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
        		+ "0" + flag + totalgroups+"" + flag + requestname + flag + userid+"" + flag + CurrentDate + flag
        		+ CurrentTime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + ""+flag+creatertype+ flag+creatertype+flag
        		+nodepasstime + flag + nodepasstime;
        RecordSet.executeProc("workflow_Requestbase_Insert",Procpara);
        
        //����operator��Ϣ
        String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
        RequestCheckUser.setUserid(userid);
		RequestCheckUser.setNodeid(destnodeid);
		RequestCheckUser.setLogintype(logintype);
		RequestCheckUser.setIsbill(1);
		RequestCheckUser.setRequestid(requestid);
		RequestCheckUser.setWorkflowid(workflowid);
		RequestCheckUser.setWorkflowtype(workflowtype);
        totalgroups = RequestCheckUser.addCurrentoperator();
        //�ڵ��Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(nodeid);
        RequestCheckAddinRules.setObjtype(1);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();
               
        //�����Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(linkid);
        RequestCheckAddinRules.setObjtype(0);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();  
        
        //����鿴��Ա�б�
        Procpara=requestid+"" + flag + userid+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+ flag + creatertype +flag+"2";
        RecordSet.executeProc("workflow_CurrentOperator_Insert",Procpara);
        
        String topage=URLDecoder.decode(Util.null2String(request.getParameter("topage")));
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

//request_base �� ������Ϣ
	RecordSet.executeProc("workflow_Requestbase_SelectByID",requestid+"");
        RecordSet.next();
        lastnodeid=RecordSet.getInt("lastnodeid");
        lastnodetype=RecordSet.getString("lastnodetype");
        String status=RecordSet.getString("status");
        passedgroups=RecordSet.getInt("passedgroups");
        totalgroups=RecordSet.getInt("totalgroups");
        int creater=RecordSet.getInt("creater");
        String createdate=RecordSet.getString("createdate");
        String createtime=RecordSet.getString("createtime");
        int lastoperator=RecordSet.getInt("lastoperator");
        String lastoperatedate=RecordSet.getString("lastoperatedate");
        String lastoperatetime=RecordSet.getString("lastoperatetime");
        int creatertype = RecordSet.getInt("creatertype");
        int lastoperatortype = RecordSet.getInt("lastoperatortype");
        nodepasstime = RecordSet.getFloat("nodepasstime");
        float nodelefttime = RecordSet.getFloat("nodelefttime");

if(src.equals("delete")&&iscreate.equals("0")){//����request��ѡ��ɾ��logtype=5
	//����base���е�deleted�ֶ�Ϊ1
	Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
        		+ nodeid+"" + flag + nodetype + flag + status + flag
        		+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
        		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "1" + flag
        		+ creatertype + flag +lastoperatortype+flag+nodepasstime+flag+nodelefttime ;
        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	
	String operatortype = "";
        if(logintype.equals("1"))
        	operatortype = "0";
        if(logintype.equals("2"))
        	operatortype = "1";
        	
	//����LOG����Ϣ
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "5" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
        	+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        
        // �� bill_hrmtime ���״̬��Ϊ 2
        RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"2");
}

if(src.equals("save")&&iscreate.equals("0")){//����request��ѡ�񱣴�logtype=1
        //�����ֶ���Ϣ
        Procpara=""+billid+flag+
        	resourceid + flag + requestid + flag + formid + flag + basictype + flag + detailtype+ flag +
        	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
        	name + flag + "" + flag + summary + flag + totaldays + flag +
        	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
        	"" + flag + plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";
        RecordSet.executeProc("bill_HrmTime_Update",Procpara);
        //�ڵ��Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(nodeid);
        RequestCheckAddinRules.setObjtype(1);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();
        //����request�ܱ���Ϣ
        Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype + flag 
        		+ nodeid+"" + flag + nodetype + flag + status + flag
        		+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
        		+ createdate + flag + createtime + flag + lastoperator+"" + flag 
        		+ lastoperatedate + flag + lastoperatetime + flag + "" + flag
        		+ creatertype + flag +lastoperatortype +flag+nodepasstime+flag+nodelefttime ;
        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
        
        //����LOG����Ϣ
        String operatortype = "";
        if(logintype.equals("1"))
        	operatortype = "0";
        if(logintype.equals("2"))
        	operatortype = "1";

        int isremark=Util.getIntValue(request.getParameter("isremark"),0);

        String logtype  = "1" ;
        if(isremark==1) logtype = "9" ;
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + logtype + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
        	+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;

        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);  
        //ɾ��remark�����߼�¼
        if(isremark==1){
        	RecordSet.executeSql("delete from workflow_currentoperator where requestid="+requestid+" and userid="+userid+" and isremark='1' and usertype="+operatortype);
        }
}

if(src.equals("submit")&&iscreate.equals("0")){//����request��ѡ���ύlogtype=2
        String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
        
	//�����ֶ���Ϣ
    Procpara=""+billid+flag+
    	resourceid + flag + requestid + flag + formid + flag + basictype + flag + detailtype+ flag +
    	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
    	name + flag + "" + flag + summary + flag + totaldays + flag +
    	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
    	"" + flag + plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";    
    RecordSet.executeProc("bill_HrmTime_Update",Procpara);
	//�ڵ��Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(nodeid);
        RequestCheckAddinRules.setObjtype(1);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();
       
	String operatortype = "";
        if(logintype.equals("1"))
        	operatortype = "0";
        if(logintype.equals("2"))
        	operatortype = "1";
        
        
        //�ȼ��passedgroups����
        sql="select count(distinct groupid) from workflow_currentoperator where isremark = '0' and requestid="+requestid+" and userid="+userid+" and usertype="+operatortype;
        RecordSet.executeSql(sql);
        if(RecordSet.next())	passedgroups+=RecordSet.getInt(1);
        //����operator��
		sql = "select distinct groupid from workflow_currentoperator where isremark = '0' and requestid="+requestid+" and userid="+userid+" and usertype="+operatortype;
		RecordSet.executeSql(sql);
		while(RecordSet.next()){
			int tmpgroupid = RecordSet.getInt(1);
			rs.executeProc("workflow_NodeGroup_SelectByid",""+tmpgroupid);
			int tmpcanview = 0;
			if(rs.next())
				tmpcanview = rs.getInt("canview");
			if(tmpcanview==1   || lastnodetype.equals("0") || lastnodetype.equals("") ){
				sql = " update workflow_currentoperator set isremark = '2' where requestid="+requestid+" and groupid ="+tmpgroupid;
				rs.executeSql(sql);
			}else if(tmpcanview==0){
				sql = " delete workflow_currentoperator where requestid="+requestid+" and groupid ="+tmpgroupid;
				rs.executeSql(sql);
			}
		}
        if(passedgroups<totalgroups){//��ǰ�ڵ�û����ȫ����ͨ��������ͣ���ڵ�ǰ�ڵ�
        	//����request�ܱ���Ϣ        
	        Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
	        		+ nodeid+"" + flag + nodetype + flag + status + flag
	        		+ passedgroups + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
	        		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "" + flag
	        		+ creatertype + flag + lastoperatortype+flag+nodepasstime+flag+nodelefttime;
	        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	        //����LOG����Ϣ
	        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "2" + flag 
        		+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
        		+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        	RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        }
        else{//��ǰ�ڵ���ȫ����ͨ����������һ�ڵ�
    	//ɾ��ԭ��remark����
    	sql="delete from workflow_currentoperator where isremark ='1' and requestid="+requestid;
    	RecordSet.executeSql(sql);
        	//��ѯ��һ�ڵ�
		RecordSet.executeProc("workflow_NodeLink_Select",nodeid+""+flag+"0"+flag+""+requestid);
		ArrayList whereclauses=new ArrayList();
		ArrayList linkids=new ArrayList();
		ArrayList linknames=new ArrayList();
		ArrayList destnodeids=new ArrayList();
		while(RecordSet.next()){
			//whereclauses.add(RecordSet.getString("condition"));
			linkids.add(RecordSet.getString("id"));
			linknames.add(RecordSet.getString("linkname"));
			destnodeids.add(RecordSet.getString("destnodeid"));
			
			weaver.workflow.node.NodeInfo nodeInfo = new weaver.workflow.node.NodeInfo();
			if(RecordSet.getDBType().equals("oracle"))
				whereclauses.add(nodeInfo.getConditionStr(RecordSet.getString("id")));
			else
				whereclauses.add(RecordSet.getString("condition"));
		}
		
		int i=0;
		for(i=0;i<destnodeids.size();i++){
			String where=(String)whereclauses.get(i);
			if(where.trim().equals(""))	break;
			else{
				sql="select * from bill_hrmtime where id="+billid+" and "+where;
				RecordSet.executeSql(sql);
				if(RecordSet.next())	break;
			}
		}
		linkid=Util.getIntValue(""+linkids.get(i),0);
		linkname=(String) linknames.get(i);
		destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
		
		RecordSet.executeProc("workflow_NodeLink_SelectPasstime",""+nodeid+flag+"-1");
		if(RecordSet.next())
			nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
		else
			nodepasstime = -1;
	       
		
		RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
		RecordSet.next();
		String destnodetype=RecordSet.getString(1);
		
		sql="select count(id) from workflow_nodegroup where nodeid = "+destnodeid;
	    RecordSet.executeSql(sql);
	    if(RecordSet.next())
	       	totalgroups = RecordSet.getInt(1);
	       	
	        //����request�ܱ���Ϣ   
	        
	        Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
	        		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
	        		+ "0" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
	        		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + ""+flag
	        		+ creatertype + flag + operatortype+flag+nodepasstime+flag+nodepasstime;
	        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);	
	    
	    	//����LOG����Ϣ
	        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "2" + flag 
        		+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
        		+ flag + ""+destnodeid+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        	RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        	    
	        //����operator��Ϣ
	        if(!destnodetype.equals("0")){       
		        RequestCheckUser.setUserid(userid);
			RequestCheckUser.setNodeid(destnodeid);
			RequestCheckUser.setLogintype(logintype);
			RequestCheckUser.setIsbill(1);
			RequestCheckUser.setRequestid(requestid);
			RequestCheckUser.setWorkflowid(workflowid);
			RequestCheckUser.setWorkflowtype(workflowtype);
		    totalgroups = RequestCheckUser.addCurrentoperator();
		 }
		 else{
		 	totalgroups = 1;
		 	Procpara=requestid+"" + flag + creater+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+flag+creatertype+flag+"0";
        	RecordSet.executeProc("workflow_CurrentOperator_Insert",Procpara);
        	RecordSet.executeProc("SysRemindInfo_InserHasnewwf",""+creater+flag+creatertype+flag+""+requestid);
        }
   	    // ���Ϊ�����ڵ�, �� bill_itemusage ���״̬��Ϊ 1
        if(destnodetype.equals("3")) 
        	RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"1");
        //�����Զ���ֵ����
	        RequestCheckAddinRules.resetParameter();
	        RequestCheckAddinRules.setRequestid(requestid);
	        RequestCheckAddinRules.setObjid(linkid);
	        RequestCheckAddinRules.setObjtype(0);
	        RequestCheckAddinRules.setIsbill(1);
	        RequestCheckAddinRules.setFormid(formid);
	        RequestCheckAddinRules.checkAddinRules();
    }
}

if(src.equals("reject")&&iscreate.equals("0")){//����request��ѡ���˻�logtype=3
        String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
        
	//�����ֶ���Ϣ
    Procpara=""+billid+flag+
    	resourceid + flag + requestid + flag + formid + flag + basictype + flag + detailtype+ flag +
    	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
    	name + flag + "" + flag + summary + flag + totaldays + flag +
    	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
    	"" + flag + plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";    
    RecordSet.executeProc("bill_HrmTime_Update",Procpara);
	//�ڵ��Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(nodeid);
        RequestCheckAddinRules.setObjtype(1);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules();
	//��ѯ��һ�ڵ�
	RecordSet.executeProc("workflow_NodeLink_Select",nodeid+""+flag+"1"+flag+""+requestid);
	ArrayList whereclauses=new ArrayList();
	ArrayList linkids=new ArrayList();
	ArrayList linknames=new ArrayList();
	ArrayList destnodeids=new ArrayList();
	while(RecordSet.next()){
		//whereclauses.add(RecordSet.getString("condition"));
		linkids.add(RecordSet.getString("id"));
		linknames.add(RecordSet.getString("linkname"));
		destnodeids.add(RecordSet.getString("destnodeid"));
		
		weaver.workflow.node.NodeInfo nodeInfo = new weaver.workflow.node.NodeInfo();
		if(RecordSet.getDBType().equals("oracle"))
			whereclauses.add(nodeInfo.getConditionStr(RecordSet.getString("id")));
		else
			whereclauses.add(RecordSet.getString("condition"));
	}
	int i=0;
	for(i=0;i<destnodeids.size();i++){
		String where=(String)whereclauses.get(i);
		if(where.trim().equals(""))	break;
		else{
			sql="select * from bill_hrmtime where id="+billid+" and "+where;
			RecordSet.executeSql(sql);
			if(RecordSet.next())	break;
		}
	}
	linkid=Util.getIntValue(""+linkids.get(i),0);
	linkname=(String) linknames.get(i);
	destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
	
	RecordSet.executeProc("workflow_NodeLink_SelectPasstime",""+nodeid+flag+"-1");
		if(RecordSet.next())
			nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
		else
			nodepasstime = -1;
	
	RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
	RecordSet.next();
	String destnodetype=RecordSet.getString(1);
	
	String operatortype = "";
    if(logintype.equals("1"))
       	operatortype = "0";
    if(logintype.equals("2"))
       	operatortype = "1";
        	
	//����request�ܱ���Ϣ       
    sql="select count(id) from workflow_nodegroup where nodeid = "+destnodeid;
	RecordSet.executeSql(sql);
	if(RecordSet.next())
	   	totalgroups = RecordSet.getInt(1); 
	    
    Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
        		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
        		+ "0" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag + createdate + flag
        		+ createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + ""+flag+creatertype+flag +operatortype+flag
        		+ nodepasstime+flag+nodepasstime ;
    RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
    
    //����LOG����Ϣ
	
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "3" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag + operatortype
        	+ flag + ""+destnodeid+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
           
	//����operator��Ϣ,��ɾ��operator���е���ؼ�¼���ٲ����µļ�¼
	//����operator��
	sql = "select distinct groupid from workflow_currentoperator where isremark = '0' and requestid="+requestid+" and userid="+userid+" and usertype="+operatortype;
	RecordSet.executeSql(sql);
	while(RecordSet.next()){
		int tmpgroupid = RecordSet.getInt(1);
		rs.executeProc("workflow_NodeGroup_SelectByid",""+tmpgroupid);
		int tmpcanview = 0;
		if(rs.next())
			tmpcanview = rs.getInt("canview");
		if(tmpcanview==1){
			sql = " update workflow_currentoperator set isremark = '2' where requestid="+requestid+" and groupid ="+tmpgroupid;
			rs.executeSql(sql);
		}else if(tmpcanview==0){
			sql = " delete workflow_currentoperator where requestid="+requestid+" and groupid ="+tmpgroupid;
			rs.executeSql(sql);
		}
	}
	sql="delete from workflow_currentoperator where isremark <> '2' and requestid="+requestid;
	RecordSet.executeSql(sql);
	if(!destnodetype.equals("0")){
		RequestCheckUser.setUserid(userid);
		RequestCheckUser.setNodeid(destnodeid);
		RequestCheckUser.setLogintype(logintype);
		RequestCheckUser.setIsbill(1);
		RequestCheckUser.setRequestid(requestid);
		RequestCheckUser.setWorkflowid(workflowid);
		RequestCheckUser.setWorkflowtype(workflowtype);
		totalgroups = RequestCheckUser.addCurrentoperator();
	}
	else{//next node is create
	    totalgroups = 1;
	    Procpara=requestid+"" + flag + creater+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+flag+creatertype+flag+"0";
	    RecordSet.executeProc("workflow_CurrentOperator_Insert",Procpara);
	    RecordSet.executeProc("SysRemindInfo_InserHasnewwf",""+creater+flag+creatertype+flag+""+requestid);
	}
	//�����Զ���ֵ����
        RequestCheckAddinRules.resetParameter();
        RequestCheckAddinRules.setRequestid(requestid);
        RequestCheckAddinRules.setObjid(linkid);
        RequestCheckAddinRules.setObjtype(0);
        RequestCheckAddinRules.setIsbill(1);
        RequestCheckAddinRules.setFormid(formid);
        RequestCheckAddinRules.checkAddinRules(); 
}

if(src.equals("reopen")&&iscreate.equals("0")){//����request��ѡ�����´�logtype=4
	String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
	String operatortype = "";
    if(logintype.equals("1"))
    	operatortype = "0";
    if(logintype.equals("2"))
    	operatortype = "1";
        
	//�����ֶ���Ϣ
        Procpara=""+billid+flag+
        	resourceid + flag + requestid + flag + formid + flag + basictype + flag + detailtype+ flag +
        	begindate + flag + begintime + flag + enddate + flag + endtime + flag +
        	name + flag + "" + flag + summary + flag + totaldays + flag +
        	totalhours + flag + "0" + flag + projectid + flag + "" + flag + docid + flag +
        	"" + flag + plantype + flag + plansort + flag + subprojectid + flag + budgetmoney+flag+""+flag+"";
        
        RecordSet.executeProc("bill_HrmTime_Update",Procpara);
	
	//��ѯ��һ�ڵ㼴create�ڵ�
	RecordSet.executeProc("workflow_CreateNode_Select",workflowid+"");
	RecordSet.next();
	destnodeid=RecordSet.getInt(1);
	RecordSet.executeProc("workflow_NodeLink_SelectPasstime",""+nodeid+flag+"-1");
		if(RecordSet.next())
			nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
		else
			nodepasstime = -1;
			
	linkname="reopen";
	totalgroups=1;
	//����operator��Ϣ,��ɾ��operator���е���ؼ�¼���ٲ����µļ�¼
	//����operator��
	sql = "select distinct groupid from workflow_currentoperator where isremark = '0' and requestid="+requestid+" and userid="+userid+" and usertype="+operatortype;
	RecordSet.executeSql(sql);
	while(RecordSet.next()){
		int tmpgroupid = RecordSet.getInt(1);
		rs.executeProc("workflow_NodeGroup_SelectByid",""+tmpgroupid);
		int tmpcanview = 0;
		if(rs.next())
			tmpcanview = rs.getInt("canview");
		if(tmpcanview==1){
			sql = " update workflow_currentoperator set isremark = '2' where requestid="+requestid+" and groupid ="+tmpgroupid;
			rs.executeSql(sql);
		}else if(tmpcanview==0){
			sql = " delete workflow_currentoperator where requestid="+requestid+" and groupid ="+tmpgroupid;
			rs.executeSql(sql);
		}
	}
	sql="delete from workflow_currentoperator where isremark <> '2' and requestid="+requestid;
	RecordSet.executeSql(sql);
        
    Procpara=requestid+"" + flag + creater+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+flag+creatertype+flag+"0";
    RecordSet.executeProc("workflow_CurrentOperator_Insert",Procpara);
	RecordSet.executeProc("SysRemindInfo_InserHasnewwf",""+creater+flag+creatertype+flag+""+requestid);
	
	//����LOG����Ϣ
    Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "4" + flag 
    	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
    	+ flag + ""+destnodeid+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
    RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
    
	//����request�ܱ���Ϣ        
        RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
        RecordSet.next();
        String destnodetype=RecordSet.getString(1);
        Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
        		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
        		+ "0" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag + createdate + flag
        		+ createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "" + flag+creatertype + flag + operatortype+flag
        		+nodepasstime + flag+nodepasstime;
        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
}

if(src.equals("active")){//����request logtype=6
	String operatortype = "";
        if(logintype.equals("1"))
        	operatortype = "0";
        if(logintype.equals("2"))
        	operatortype = "1";
	//����base���е�deleted�ֶ�Ϊ0
	Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
        		+ nodeid+"" + flag + nodetype + flag + status + flag
        		+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
        		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "0"+flag+creatertype+flag+operatortype+flag
        		+nodepasstime+flag+nodelefttime;
        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	
	//����LOG����Ϣ
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "6" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip + flag +operatortype
        	+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        // ���Ϊ�����ڵ�, �� bill_hrmtime ���״̬��Ϊ 1
        if(nodetype.equals("3")) 
            RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"1");
        else
            RecordSet.executeProc("bill_HrmTime_UpdateStatus",""+billid+flag+"0");
}
	//response.sendRedirect("/workflow/request/RequestView.jsp");
	out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
%>