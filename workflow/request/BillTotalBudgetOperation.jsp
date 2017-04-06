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
<jsp:useBean id="RequestTransactionManager" class="weaver.workflow.request.RequestTransactionManager" scope="page"/>
<jsp:useBean id="RequestCheckAddinRules" class="weaver.workflow.request.RequestCheckAddinRules" scope="page"/>
<%
boolean isoracle=false;
if(RecordSet.getDBType().equals("oracle")) isoracle=true;
boolean isdb2=RecordSet.getDBType().equals("db2");
int userid = user.getUID();
String logintype = user.getLogintype();

String creatertype = "";
if(logintype.equals("1"))     	creatertype = "0";
if(logintype.equals("2"))      	creatertype = "1";	

String operatortype = "";
if(logintype.equals("1"))      	operatortype = "0";
if(logintype.equals("2"))      	operatortype = "1";

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
String requestname=Util.fromScreen(request.getParameter("requestname"),user.getLanguage());
String requestlevel=Util.fromScreen(request.getParameter("requestlevel"),user.getLanguage());
String remark = Util.null2String(request.getParameter("remark"));
String clientip=request.getRemoteAddr();
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

int year = Util.getIntValue(CurrentDate.substring(0,4)) ;
char flag=Util.getSeparator() ;
String Procpara="";
String sql="";
String docids = "";
String crmids = "";
String hrmids = "";
String prjids = "";
String cptids = "";

if(src.equals("save")&&iscreate.equals("1")) {//�½�request��ѡ�񱣴�	
	RecordSet.executeProc("workflow_RequestID_Update","");
	RecordSet.next();
	requestid = RecordSet.getInt(1);
	
	//�����ֶ���Ϣ     
	String sqltmp = " insert into bill_TotalBudget (resourceid) values(0)";
    RecordSet.executeSql(sqltmp);
    sqltmp = " select max(id) from bill_TotalBudget";
    RecordSet.executeSql(sqltmp);
    if(RecordSet.next())
    	billid = RecordSet.getInt(1);
	String updateclause="set ";
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
	while(RecordSet.next()){
		String fieldid=RecordSet.getString("id");
    	String fieldname=RecordSet.getString("fieldname");
    	String fielddbtype=RecordSet.getString("fielddbtype");
		if(isoracle){
			if(fielddbtype.equals("integer"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("number(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else {
                String thetempvalue = Util.fromScreen2(request.getParameter("field"+fieldid),user.getLanguage()) ;
                if( thetempvalue.equals("") ) thetempvalue = " " ;
        		updateclause+=fieldname+" = '"+thetempvalue+"',";
            }
    	}else{
			if(fielddbtype.equals("int"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("decimal(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else
				updateclause+=fieldname+" = '"+Util.fromScreen2(Util.null2String(request.getParameter("field"+fieldid)),user.getLanguage())+"',";
		}
    	String fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
    	String fieldtype=FieldComInfo.getFieldType(fieldid);
    	if(fieldhtmltype.equals("3") && (fieldtype.equals("1") ||fieldtype.equals("17")))
        		hrmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && (fieldtype.equals("7") || fieldtype.equals("18")))
        		crmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("8"))
        		prjids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("9"))
        		docids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("23"))
        		cptids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
    } 
	updateclause+= "requestid="+requestid+",billid="+formid+",status='0',";
					
	updateclause=updateclause.substring(0,updateclause.length()-1);
	updateclause="update bill_TotalBudget "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);
	//дbudget_detail��
	String departmentid=user.getUserDepartment()+"";
	int rowsum=Util.getIntValue(request.getParameter("rowsum"),0);
	RecordSet.executeSql("delete from bill_budgetdetail where departmentid="+departmentid+" and year="+year);
	for(int i=1;i<(rowsum+1);i++){
	    String feeid=Util.fromScreen(request.getParameter("row"+i),user.getLanguage());
		for(int j=1;j<13;j++){
			String month=j+"";
			String budget=Util.fromScreen(request.getParameter("fee_"+i+"_"+j),user.getLanguage());
			if(budget.equals(""))	budget="0";
			Procpara=departmentid+flag+feeid+flag+month+flag+budget+flag+""+year;
			RecordSet.executeProc("bill_BudgetDetail_Insert",Procpara);
		}
	}
	
	//�ڵ��Զ���ֵ����
    RequestCheckAddinRules.resetParameter();
    RequestCheckAddinRules.setRequestid(requestid);
    RequestCheckAddinRules.setObjid(nodeid);
    RequestCheckAddinRules.setObjtype(1);
    RequestCheckAddinRules.setIsbill(1);
    RequestCheckAddinRules.setFormid(formid);
    RequestCheckAddinRules.checkAddinRules();
		
	//����workflow_form��
	sql="insert into workflow_form (requestid,billformid,billid) values("+requestid+","+formid+","+billid+")";
    RecordSet.executeSql(sql);
	//����request�ܱ���Ϣ
	RecordSet.executeProc("workflow_NodeLink_SPasstime",""+nodeid+flag+"-1");
	if(RecordSet.next())
		nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);       
	if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);
	Procpara=requestid+""+ flag + workflowid+"" + flag + "" + flag + "" + flag 
			+ nodeid+"" + flag + nodetype + flag + SystemEnv.getHtmlLabelName(125,user.getLanguage()) + flag
			+ "" + flag + "" + flag + requestname + flag + userid+"" + flag + CurrentDate + flag
			+ CurrentTime + flag + "" + flag + "" + flag + "" + flag + ""+ flag + creatertype+ flag + ""+flag
			+nodepasstime+flag+nodepasstime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids;
	RecordSet.executeProc("workflow_Requestbase_Insert",Procpara);
	//����LOG����Ϣ
	Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "1" + flag 
		+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip + flag + creatertype
		+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
	RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
	//����operator��Ϣ
	String workflowtype=WorkflowComInfo.getWorkflowtype(workflowid+"");
	Procpara=requestid+"" + flag + userid+"" + flag + "" + flag + workflowid+"" + flag + workflowtype+ flag + creatertype + flag +"0";
	RecordSet.executeProc("workflow_CurrentOperator_I",Procpara);
	
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
	//�����ֶ���Ϣ     
	String sqltmp = " insert into bill_TotalBudget (resourceid) values(0)";
    RecordSet.executeSql(sqltmp);
    sqltmp = " select max(id) from bill_TotalBudget";
    RecordSet.executeSql(sqltmp);
    if(RecordSet.next())
    	billid = RecordSet.getInt(1);
	String updateclause="set ";
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
	while(RecordSet.next()){
		String fieldid=RecordSet.getString("id");
    	String fieldname=RecordSet.getString("fieldname");
    	String fielddbtype=RecordSet.getString("fielddbtype");
		if(isoracle){
			if(fielddbtype.equals("integer"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("number(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else {
                String thetempvalue = Util.fromScreen2(request.getParameter("field"+fieldid),user.getLanguage()) ;
                if( thetempvalue.equals("") ) thetempvalue = " " ;
        		updateclause+=fieldname+" = '"+thetempvalue+"',";
            }
    	}else{
			if(fielddbtype.equals("int"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("decimal(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else
				updateclause+=fieldname+" = '"+Util.fromScreen2(Util.null2String(request.getParameter("field"+fieldid)),user.getLanguage())+"',";
		}
    	String fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
    	String fieldtype=FieldComInfo.getFieldType(fieldid);
    	if(fieldhtmltype.equals("3") && (fieldtype.equals("1") ||fieldtype.equals("17")))
        		hrmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && (fieldtype.equals("7") || fieldtype.equals("18")))
        		crmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("8"))
        		prjids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("9"))
        		docids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("23"))
        		cptids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
    } 
	updateclause+= "requestid="+requestid+",billid="+formid+",status='0',";
					
	updateclause=updateclause.substring(0,updateclause.length()-1);
	updateclause="update bill_TotalBudget "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);
	
	//����workflow_form��
	sql="insert into workflow_form (requestid,billformid,billid) values("+requestid+","+formid+","+billid+")";
    RecordSet.executeSql(sql);
    
    //дbudget_detail��
	String departmentid=user.getUserDepartment()+"";
	int rowsum=Util.getIntValue(request.getParameter("rowsum"),0);
	RecordSet.executeSql("delete from bill_budgetdetail where departmentid="+departmentid+" and year="+year);
	for(int i=1;i<(rowsum+1);i++){
	    String feeid=Util.fromScreen(request.getParameter("row"+i),user.getLanguage());
		for(int j=1;j<13;j++){
			String month=j+"";
			String budget=Util.fromScreen(request.getParameter("fee_"+i+"_"+j),user.getLanguage());
			if(budget.equals(""))	budget="0";
			Procpara=departmentid+flag+feeid+flag+month+flag+budget+flag+""+year;
			RecordSet.executeProc("bill_BudgetDetail_Insert",Procpara);
		}
	}
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
			sql="select * from bill_TotalBudget where requestid="+requestid+" and "+where;
			RecordSet.executeSql(sql);
			if(RecordSet.next())	break;
		}
	}
	linkid=Util.getIntValue(""+linkids.get(i),0);
	linkname=(String) linknames.get(i);
	destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
	RecordSet.executeProc("workflow_NodeLink_SPasstime",""+nodeid+flag+"-1");
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
	if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);	
	Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
			+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
			+ "0" + flag + totalgroups+"" + flag + requestname + flag + userid+"" + flag + CurrentDate + flag
			+ CurrentTime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + ""+flag+creatertype+ flag+creatertype+flag
			+nodepasstime + flag + nodepasstime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids;
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
    RecordSet.executeProc("workflow_CurrentOperator_I",Procpara);
    
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
//����request level��Ϣ
if(iscreate.equals("1")){
    RecordSet.executeProc("workflow_Rbase_UpdateLevel",""+requestid+flag+requestlevel);
}

//request_base �� ������Ϣ
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
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
creatertype = RecordSet.getString("creatertype");
int lastoperatortype = RecordSet.getInt("lastoperatortype");
nodepasstime = RecordSet.getFloat("nodepasstime");
float nodelefttime = RecordSet.getFloat("nodelefttime");

if(src.equals("delete")&&iscreate.equals("0")){//����request��ѡ��ɾ��logtype=5
	//������request_base���ж������ĸ��ֶ���Ϣ
	docids = RecordSet.getString("docids");
	crmids = RecordSet.getString("crmids");
	hrmids = RecordSet.getString("hrmids");
	prjids = RecordSet.getString("prjids");
	cptids = RecordSet.getString("cptids");
	//����base���е�deleted�ֶ�Ϊ1
	Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
	    		+ nodeid+"" + flag + nodetype + flag + status + flag
	    		+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
	    		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "1" + flag
	    		+ creatertype + flag +lastoperatortype+flag+nodepasstime+flag+nodelefttime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ;
	RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	    	
	//����LOG����Ϣ
	Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "5" + flag 
		+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
		+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
	RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
	    
	// �� bill_TotalBudget ���״̬��Ϊ 2
	RecordSet.executeProc("bill_TotalBudget_UpdateStatus",""+billid+flag+"2");
}

if(src.equals("save")&&iscreate.equals("0")){//����request��ѡ�񱣴�logtype=1
	//���remark�Ĳ������Ƿ���Ȩ��
	    int isremark=Util.getIntValue(request.getParameter("isremark"),0);
	    String usertype="";
	    if(logintype.equals("1"))
        	usertype = "0";
        if(logintype.equals("2"))
        	usertype = "1";
	    if(isremark==1){
	        sql="select * from workflow_currentoperator where isremark='1' and requestid="+requestid+" and userid="+userid+" and usertype="+usertype;
	        RecordSet.executeSql(sql);
	        if(!RecordSet.next()){
				//response.sendRedirect("/workflow/request/RequestView.jsp");
				out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
				return;
	        }
	    }
	    
	String updateclause="set ";
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
	while(RecordSet.next()){
		String fieldid=RecordSet.getString("id");
    	String fieldname=RecordSet.getString("fieldname");
    	String fielddbtype=RecordSet.getString("fielddbtype");
		if(isoracle){
			if(fielddbtype.equals("integer"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("number(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else {
                String thetempvalue = Util.fromScreen2(request.getParameter("field"+fieldid),user.getLanguage()) ;
                if( thetempvalue.equals("") ) thetempvalue = " " ;
        		updateclause+=fieldname+" = '"+thetempvalue+"',";
            }
    	}else{
			if(fielddbtype.equals("int"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("decimal(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else
				updateclause+=fieldname+" = '"+Util.fromScreen2(Util.null2String(request.getParameter("field"+fieldid)),user.getLanguage())+"',";
		}
    	String fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
    	String fieldtype=FieldComInfo.getFieldType(fieldid);
    	if(fieldhtmltype.equals("3") && (fieldtype.equals("1") ||fieldtype.equals("17")))
        		hrmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && (fieldtype.equals("7") || fieldtype.equals("18")))
        		crmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("8"))
        		prjids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("9"))
        		docids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("23"))
        		cptids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
    }
	updateclause=updateclause.substring(0,updateclause.length()-1);
	updateclause="update bill_TotalBudget "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);
	
	if(nodetype.equals("0")){
	    //дbudget_detail��
    	String departmentid=user.getUserDepartment()+"";
    	int rowsum=Util.getIntValue(request.getParameter("rowsum"),0);
    	RecordSet.executeSql("delete from bill_budgetdetail where departmentid="+departmentid+" and year="+year);
    	for(int i=1;i<(rowsum+1);i++){
    	    String feeid=Util.fromScreen(request.getParameter("row"+i),user.getLanguage());
    		for(int j=1;j<13;j++){
    			String month=j+"";
    			String budget=Util.fromScreen(request.getParameter("fee_"+i+"_"+j),user.getLanguage());
    			if(budget.equals(""))	budget="0";
    			Procpara=departmentid+flag+feeid+flag+month+flag+budget+flag+""+year;
    			RecordSet.executeProc("bill_BudgetDetail_Insert",Procpara);
    		}
    	}
	}
	//�ڵ��Զ���ֵ����
    RequestCheckAddinRules.resetParameter();
    RequestCheckAddinRules.setRequestid(requestid);
    RequestCheckAddinRules.setObjid(nodeid);
    RequestCheckAddinRules.setObjtype(1);
    RequestCheckAddinRules.setIsbill(1);
    RequestCheckAddinRules.setFormid(formid);
    RequestCheckAddinRules.checkAddinRules();
	//����request�ܱ���Ϣ
	if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);
	Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype + flag 
			+ nodeid+"" + flag + nodetype + flag + status + flag
			+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
			+ createdate + flag + createtime + flag + lastoperator+"" + flag 
			+ lastoperatedate + flag + lastoperatetime + flag + "" + flag
			+ creatertype + flag +lastoperatortype +flag+nodepasstime+flag+nodelefttime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ;
	RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	
	//����LOG����Ϣ
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
	String updateclause="set ";
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
	while(RecordSet.next()){
		String fieldid=RecordSet.getString("id");
    	String fieldname=RecordSet.getString("fieldname");
    	String fielddbtype=RecordSet.getString("fielddbtype");
		if(isoracle){
			if(fielddbtype.equals("integer"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("number(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else {
                String thetempvalue = Util.fromScreen2(request.getParameter("field"+fieldid),user.getLanguage()) ;
                if( thetempvalue.equals("") ) thetempvalue = " " ;
        		updateclause+=fieldname+" = '"+thetempvalue+"',";
            }
    	}else{
			if(fielddbtype.equals("int"))
				updateclause+=fieldname+" = "+Util.getIntValue(request.getParameter("field"+fieldid),0)+",";
			else if(fielddbtype.equals("decimal(10,3)"))
				updateclause+=fieldname+" = "+Util.getFloatValue(request.getParameter("field"+fieldid),0)+",";
			else
				updateclause+=fieldname+" = '"+Util.fromScreen2(Util.null2String(request.getParameter("field"+fieldid)),user.getLanguage())+"',";
		}
    	String fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
    	String fieldtype=FieldComInfo.getFieldType(fieldid);
    	if(fieldhtmltype.equals("3") && (fieldtype.equals("1") ||fieldtype.equals("17")))
        		hrmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && (fieldtype.equals("7") || fieldtype.equals("18")))
        		crmids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("8"))
        		prjids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("9"))
        		docids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
        	if(fieldhtmltype.equals("3") && fieldtype.equals("23"))
        		cptids +=","+Util.getIntValue(request.getParameter("field"+fieldid),0);
    } 				
	updateclause=updateclause.substring(0,updateclause.length()-1);
	updateclause="update bill_TotalBudget "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);
	
	if(nodetype.equals("0")){
	    //дbudget_detail��
    	String departmentid=user.getUserDepartment()+"";
    	int rowsum=Util.getIntValue(request.getParameter("rowsum"),0);
    	RecordSet.executeSql("delete from bill_budgetdetail where departmentid="+departmentid+" and year="+year);
    	for(int i=1;i<(rowsum+1);i++){
    	    String feeid=Util.fromScreen(request.getParameter("row"+i),user.getLanguage());
    		for(int j=1;j<13;j++){
    			String month=j+"";
    			String budget=Util.fromScreen(request.getParameter("fee_"+i+"_"+j),user.getLanguage());
    			if(budget.equals(""))	budget="0";
    			Procpara=departmentid+flag+feeid+flag+month+flag+budget+flag+""+year;
    			RecordSet.executeProc("bill_BudgetDetail_Insert",Procpara);
    		}
    	}
	}
	
	 //�ڵ��Զ���ֵ����
    RequestCheckAddinRules.resetParameter();
    RequestCheckAddinRules.setRequestid(requestid);
    RequestCheckAddinRules.setObjid(nodeid);
    RequestCheckAddinRules.setObjtype(1);
    RequestCheckAddinRules.setIsbill(1);
    RequestCheckAddinRules.setFormid(formid);
    RequestCheckAddinRules.checkAddinRules();
	
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
			sql = " delete workflow_currentoperator where requestid="+requestid+" and groupid ="+tmpgroupid+" and isremark='0'";
			rs.executeSql(sql);
		}
	}
	if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);
	if(passedgroups<totalgroups){//��ǰ�ڵ�û����ȫ����ͨ��������ͣ���ڵ�ǰ�ڵ�
		//����request�ܱ���Ϣ        
	    Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
	    		+ nodeid+"" + flag + nodetype + flag + status + flag
	    		+ passedgroups + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
	    		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "" + flag
	    		+ creatertype + flag + lastoperatortype+flag+nodepasstime+flag+nodelefttime
	        	+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ;
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
				sql="select * from bill_TotalBudget where id="+billid+" and "+where;
				RecordSet.executeSql(sql);
				if(RecordSet.next())	break;
			}
		}
		linkid=Util.getIntValue(""+linkids.get(i),0);
		linkname=(String) linknames.get(i);
		destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
		
		RecordSet.executeProc("workflow_NodeLink_SPasstime",""+nodeid+flag+"-1");
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
	    		+ creatertype + flag + operatortype+flag+nodepasstime+flag+nodepasstime
	        	+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ;
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
	    	RecordSet.executeProc("workflow_CurrentOperator_I",Procpara);
	    	RecordSet.executeProc("SysRemindInfo_InserHasnewwf",""+creater+flag+creatertype+flag+""+requestid);
		}
        // ���Ϊ�����ڵ�,�� bill_TotalBudget ���״̬��Ϊ 1
    	if(destnodetype.equals("3"))
    		RecordSet.executeProc("bill_TotalBudget_UpdateStatus",""+billid+flag+"1");
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
			sql="select * from bill_TotalBudget where id="+billid+" and "+where;
			RecordSet.executeSql(sql);
			if(RecordSet.next())	break;
		}
	}
	linkid=Util.getIntValue(""+linkids.get(i),0);
	linkname=(String) linknames.get(i);
	destnodeid=Util.getIntValue((String)destnodeids.get(i),0);
	RecordSet.executeProc("workflow_NodeLink_SPasstime",""+nodeid+flag+"-1");
	if(RecordSet.next())
		nodepasstime=Util.getFloatValue(RecordSet.getString("nodepasstime"),-1);
	else
		nodepasstime = -1;
	
	RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
	RecordSet.next();
	String destnodetype=RecordSet.getString(1);
        	
	//����request�ܱ���Ϣ       
    sql="select count(id) from workflow_nodegroup where nodeid = "+destnodeid;
	RecordSet.executeSql(sql);
	if(RecordSet.next())
	   	totalgroups = RecordSet.getInt(1);    
	if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);
    Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
    		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
    		+ "0" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag + createdate + flag
    		+ createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + ""+flag+creatertype+flag +operatortype+flag
    		+ nodepasstime+flag+nodepasstime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ; 
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
	    RecordSet.executeProc("workflow_CurrentOperator_I",Procpara);
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
	
	//��ѯ��һ�ڵ㼴create�ڵ�
	RecordSet.executeProc("workflow_CreateNode_Select",workflowid+"");
	RecordSet.next();
	destnodeid=RecordSet.getInt(1);
	RecordSet.executeProc("workflow_NodeLink_SPasstime",""+nodeid+flag+"-1");
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
    RecordSet.executeProc("workflow_CurrentOperator_I",Procpara);
    RecordSet.executeProc("SysRemindInfo_InserHasnewwf",""+creater+flag+creatertype+flag+""+requestid);
    
    //����request�ܱ���Ϣ        
    if(!hrmids.equals(""))
    	hrmids = hrmids.substring(1);
    if(!crmids.equals(""))
    	crmids = crmids.substring(1);
    if(!prjids.equals(""))
    	prjids = prjids.substring(1);
    if(!docids.equals(""))
    	docids = docids.substring(1);
        if(!cptids.equals(""))
        	cptids = cptids.substring(1);
    RecordSet.executeProc("workflow_NodeType_Select",workflowid+""+flag+destnodeid+"");
    RecordSet.next();
    String destnodetype=RecordSet.getString(1);
    Procpara=requestid+""+ flag + workflowid+"" + flag + nodeid+"" + flag + nodetype+"" + flag 
       		+ destnodeid+"" + flag + destnodetype + flag + linkname + flag
       		+ "0" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag + createdate + flag
       		+ createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "" + flag+creatertype + flag + operatortype+flag
       		+nodepasstime + flag+nodepasstime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids  ;
    RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
    //����LOG����Ϣ
    Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "4" + flag 
       	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip+flag+operatortype
       	+ flag + ""+destnodeid+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
    RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
}

if(src.equals("active")){//����request logtype=6
	//������request_base���ж������ĸ��ֶ���Ϣ
	docids = RecordSet.getString("docids");
	crmids = RecordSet.getString("crmids");
	hrmids = RecordSet.getString("hrmids");
	prjids = RecordSet.getString("prjids");
	cptids = RecordSet.getString("cptids");
	//����base���е�deleted�ֶ�Ϊ0
	Procpara=requestid+""+ flag + workflowid+"" + flag + lastnodeid+"" + flag + lastnodetype+"" + flag 
        		+ nodeid+"" + flag + nodetype + flag + status + flag
        		+ passedgroups+"" + flag + totalgroups+"" + flag + requestname + flag + creater+"" + flag 
        		+ createdate + flag + createtime + flag + userid+"" + flag + CurrentDate + flag + CurrentTime + flag + "0"+flag+creatertype+flag+operatortype+flag
        		+nodepasstime+flag+nodelefttime+flag+docids+flag+crmids+flag+hrmids+flag+prjids+flag+cptids ; 
        RecordSet.executeProc("workflow_Requestbase_Update",Procpara);
	
	//����LOG����Ϣ
        Procpara=requestid+"" + flag + workflowid+"" + flag + nodeid+"" + flag + "6" + flag 
        	+ CurrentDate + flag + CurrentTime + flag + userid+"" + flag + remark + flag + clientip + flag +operatortype
        	+ flag + "0"+ flag + "" + flag + -1+ flag + "0"+ flag + -1+flag+""+flag+"0"+ flag + signdocids+flag+signworkflowids;
        RecordSet.executeProc("workflow_RequestLog_Insert",Procpara);
        // ���Ϊ�����ڵ�, �� bill_hrmtime ���״̬��Ϊ 1
        if(nodetype.equals("3")) 
            RecordSet.executeProc("bill_TotalBudget_UpdateStatus",""+billid+flag+"1");
        else
            RecordSet.executeProc("bill_TotalBudget_UpdateStatus",""+billid+flag+"0");
}

	//response.sendRedirect("/workflow/request/RequestView.jsp");
	out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
%>