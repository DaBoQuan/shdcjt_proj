<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectTypeComInfo" class="weaver.proj.Maint.ProjectTypeComInfo" scope="page" />
<jsp:useBean id="ProjTypeUtil" class="weaver.proj.ProjTypeUtil" scope="page" />
<jsp:useBean id="sysWF" class="weaver.system.SysCreateWF" scope="page"/>
<jsp:useBean id="ApproveParameter" class="weaver.workflow.request.ApproveParameter" scope="session"/>

<%
String method = request.getParameter("method");
String id = request.getParameter("id");
String type = Util.fromScreen(request.getParameter("type"),user.getLanguage());
String desc = Util.fromScreen(request.getParameter("desc"),user.getLanguage());
String wfid = request.getParameter("approvewfid");
String typeCode = Util.null2String(request.getParameter("txtTypeCode"));
String insertWorkPlan = Util.null2String(request.getParameter("insertWorkPlan"));

String[] projTemplateStatusNew = Util.TokenizerString2(Util.null2String(request.getParameter("projTemplateStatusNew")),",");
String[] projTemplateStatusOld = Util.TokenizerString2(Util.null2String(request.getParameter("projTemplateStatusOld")),",");
String[] projTemplateIDs = Util.TokenizerString2(Util.null2String(request.getParameter("projTemplateIDs")),",");


if (method.equals("add")){
	char flag=2;
	RecordSet.executeProc("Prj_ProjectType_Insert",type+flag+desc+flag+wfid+flag+typeCode+flag+insertWorkPlan);
	ProjectTypeComInfo.removeProjectTypeCache();
}
else if (method.equals("edit")){
	char flag=2;
	RecordSet.executeProc("Prj_ProjectType_Update",id+flag+type+flag+desc+flag+typeCode+flag+wfid+flag+insertWorkPlan);
	ProjectTypeComInfo.removeProjectTypeCache();


    //add by dongping  for custom field
    String[] fieldlable = request.getParameterValues("fieldlable");
    String[] fieldid = request.getParameterValues("fieldid");
    String[] fieldhtmltype = request.getParameterValues("fieldhtmltype");
    String[] customeType = request.getParameterValues("customeType");
    String[] flength = request.getParameterValues("flength");
    String[] ismand = request.getParameterValues("ismand");
    String[] selectitemid = request.getParameterValues("selectitemid");
    String[] selectitemvalue = request.getParameterValues("selectitemvalue");

    int scopeId = Util.getIntValue(id);

    ProjTypeUtil.setProjCustormFiled(fieldlable,fieldid,fieldhtmltype,customeType,flength,ismand,selectitemid,selectitemvalue,scopeId);
    //end by dongping  for custom field

    //Ϊ��Ŀ����ָ��ģ��
    String rdoTemplet = Util.null2String(request.getParameter("rdoTemplet"));
    if(!"".equals(rdoTemplet)) {
        String strSql = "update Prj_Template set isSelected=0 where proTypeId = "+id;
        //System.out.println(strSql);
        RecordSet.executeSql(strSql);

        strSql = "update Prj_Template set isSelected=1 where id = "+rdoTemplet;
        //System.out.println(strSql);
        RecordSet.executeSql(strSql);
    } else {
         String strSql = "update Prj_Template set isSelected=0 where proTypeId = "+id;
        //System.out.println(strSql);
        RecordSet.executeSql(strSql);
    }

	//=====================================================================
	//ģ������
	//added by hubo,20060226
	String sqlT = "";
	String sqlApprove = "";
	String status = "";
	int projTemplateWFID = 0;
	String projTemplateWFName = "";
	int projTemplateRequestID = 0;
	boolean isApprove = false;
	//��Ŀģ���Ƿ���Ҫ����
	sqlApprove = "SELECT isNeedAppr,wfid FROM ProjTemplateMaint";
	rs.executeSql(sqlApprove);
	if(rs.next()){
		if(rs.getString("isNeedAppr").equals("1")){
			projTemplateWFID = rs.getInt("wfid");
			isApprove = true;
		}
	}

	for(int i=0;i<projTemplateIDs.length;i++){
		//ģ��Ӳݸ�״̬��Ϊ����״̬
		if((projTemplateStatusOld[i].equals("0") || projTemplateStatusOld[i].equals("3")) && projTemplateStatusNew[i].equals("1")){	
			if(isApprove){
				status = "2";
				//���˻زݸ�ģ�壬ͬʱ�ύ�˻�����
				if(projTemplateStatusOld[i].equals("3")){
					sqlApprove = "SELECT requestid FROM BillProjTemplateApprove WHERE projTemplateId="+projTemplateIDs[i]+" ORDER BY requestid DESC";
					rs.executeSql(sqlApprove);
					if(rs.next()){
						flowNextNode(rs.getInt("requestid"),user,request,response);
					}
				}else{//��������˻زݸ�ģ�壬�����µ���������
					sqlApprove = "SELECT templetName FROM Prj_Template WHERE id="+Util.getIntValue(projTemplateIDs[i])+"";
					rs.executeSql(sqlApprove);
					if(rs.next()){
						projTemplateWFName = Util.null2String(rs.getString("templetName"));
					}
					projTemplateWFName = SystemEnv.getHtmlLabelName(18392,user.getLanguage())+":"+projTemplateWFName;
					requestM("submit","1",Util.getIntValue(projTemplateIDs[i]),projTemplateWFID,"0",projTemplateWFName,user,request,response);
				}
			}else{
				status = projTemplateStatusNew[i];
				sqlT = "UPDATE Prj_Template SET status='"+status+"' WHERE id="+projTemplateIDs[i]+"";
				RecordSet.executeSql(sqlT);
			}
		}else{
			status = projTemplateStatusNew[i];
			sqlT = "UPDATE Prj_Template SET status='"+status+"' WHERE id="+projTemplateIDs[i]+"";
			RecordSet.executeSql(sqlT);
		}
	}
	//=====================================================================
}
else if (method.equals("delete")){
    //modify by dongping for TD694
	String referenced = "" ;
    RecordSet.executeSql("SELECT count(id) FROM Prj_ProjectInfo where prjtype = "+id);
    if (RecordSet.next()) {
        if (!RecordSet.getString(1).equals("0"))
            referenced = "yes" ;
    }
    
    if (referenced.equals("yes")) {
       response.sendRedirect("/proj/Maint/EditProjectType.jsp?id="+id+"&referenced="+referenced); 
       return ;
	} else {
	    RecordSet.executeProc("Prj_ProjectType_Delete",id);
	}
	
	ProjectTypeComInfo.removeProjectTypeCache();

    //ɾ�������Ŀ����ɾ��ʱ��ص�ģ��,����,�Լ�������
    RecordSet.executeSql("select id from Prj_Template where proTypeId="+id);
    while (RecordSet.next()){
        String templetId = RecordSet.getString(1);
        //ɾ���������������
        RecordSet1.executeSql("delete Prj_TemplateTask where templetId="+templetId);
        //ɾ��ģ�������������
        RecordSet1.executeSql("delete Prj_Template where id="+templetId);        
    }
} else {
	response.sendRedirect("/CRM/DBError.jsp?type=Unknown");
	return;
}

response.sendRedirect("/proj/Maint/ListProjectType.jsp");
%>


<%!
void requestM(String src,String iscreate,int templateId,int workflowid,String nodetype,String requestname,User user,javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpServletResponse response) throws Exception{
	weaver.workflow.request.RequestManager requestManager = new weaver.workflow.request.RequestManager();
	weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
	weaver.conn.RecordSet rs2 = new weaver.conn.RecordSet();

	String sql = "";
	int requestid = 0;
	String workflowtype = "";
	int isremark = 0;
	int formid = 0;
	int isbill = 0;
	int billid = 0;
	int nodeid = 0;
	String requestlevel = "";
	String messageType = "";
	String remark = "";

	isbill=1;
	formid = 152;
	billid = 152;
	sql = "SELECT nodeid FROM workflow_flownode WHERE workflowid="+workflowid+" AND nodetype='0'";
	rs.executeSql(sql);
	if(rs.next()){
		nodeid = rs.getInt("nodeid");
	}
	
	if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
		 response.sendRedirect("/notice/RequestError.jsp");
		 return ;
	}

	requestManager.setSrc(src) ;
	requestManager.setIscreate(iscreate) ;
	requestManager.setRequestid(requestid) ;
	requestManager.setWorkflowid(workflowid) ;
	requestManager.setWorkflowtype(workflowtype) ;
	requestManager.setIsremark(isremark) ;
	requestManager.setFormid(formid) ;
	requestManager.setIsbill(isbill) ;
	requestManager.setBillid(billid) ;
	requestManager.setNodeid(nodeid) ;
	requestManager.setNodetype(nodetype) ;
	requestManager.setRequestname(requestname) ;
	requestManager.setRequestlevel(requestlevel) ;
	requestManager.setRemark(remark) ;
	requestManager.setRequest(request) ;
	requestManager.setUser(user) ;
	//add by xhheng @ 2005/01/24 for ��Ϣ���� Request06
	requestManager.setMessageType(messageType) ;

	boolean savestatus = requestManager.saveRequestInfo() ;
	requestid = requestManager.getRequestid() ;
	if( !savestatus ) {
		 if( requestid != 0 ) {
			  response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
			  return ;
		 }
		 else {
			  response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
			  return ;
		 }
	}

	boolean flowstatus = requestManager.flowNextNode() ;
	if( !flowstatus ) {
		 response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
		 return ;
	}

	boolean logstatus = requestManager.saveRequestLog() ;


	//����ʱ
	if(src.equals("submit")&&iscreate.equals("1")) {
		rs2.executeSql("UPDATE BillProjTemplateApprove SET projTemplateId="+templateId+" WHERE requestid="+requestid+"");
		if( requestManager.getNextNodetype().equals("3")) {
			rs2.executeSql("UPDATE Prj_Template SET status='1' WHERE id="+templateId+"");
			return;
		}else{
			rs2.executeSql("UPDATE Prj_Template SET status='2' WHERE id="+templateId+"");
			return;
		}
	}
}


void flowNextNode(int requestid,User user,javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpServletResponse response) throws Exception{
	weaver.workflow.request.RequestManager requestManager = new weaver.workflow.request.RequestManager();
	weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
	weaver.conn.RecordSet rs2 = new weaver.conn.RecordSet();

	String sql = "";
	String src = "";
	String iscreate = "";
	int workflowid = 0;
	String workflowtype = "";
	int isremark = 0;
	int formid = 0;
	int isbill = 0;
	int billid = 0;
	int nodeid = 0;
	String nodetype = "";
	String requestname = "";
	String requestlevel = "";
	String messageType = "";
	String remark = "";

	src = "submit";
	iscreate = "0";
	sql = "SELECT * FROM workflow_requestbase WHERE requestid="+requestid+"";
	rs.executeSql(sql);
	if(rs.next()){
		workflowid = rs.getInt("workflowid");
		requestname = rs.getString("requestname");
		requestlevel = rs.getString("requestlevel");
		messageType = rs.getString("messageType");
		nodeid = rs.getInt("currentnodeid");
		nodetype = rs.getString("currentnodetype");
	}
	sql = "SELECT * FROM workflow_base WHERE id="+workflowid+"";
	rs.executeSql(sql);
	if(rs.next()){
		workflowtype = rs.getString("workflowtype");
		formid = rs.getInt("formid");
		isbill = rs.getInt("isbill");
		billid = formid;
	}

	if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
		response.sendRedirect("/notice/RequestError.jsp");
		return ;
	}

	requestManager.setSrc(src) ;
	requestManager.setIscreate(iscreate) ;
	requestManager.setRequestid(requestid) ;
	requestManager.setWorkflowid(workflowid) ;
	requestManager.setWorkflowtype(workflowtype) ;
	requestManager.setIsremark(isremark) ;
	requestManager.setFormid(formid) ;
	requestManager.setIsbill(isbill) ;
	requestManager.setBillid(billid) ;
	requestManager.setNodeid(nodeid) ;
	requestManager.setNodetype(nodetype) ;
	requestManager.setRequestname(requestname) ;
	requestManager.setRequestlevel(requestlevel) ;
	requestManager.setRemark(remark) ;
	requestManager.setRequest(request) ;
	requestManager.setUser(user) ;
	requestManager.setMessageType(messageType) ;

	boolean savestatus = requestManager.saveRequestInfo() ;
	requestid = requestManager.getRequestid() ;
	if( !savestatus ) {
		 if( requestid != 0 ) {
			  response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
			  return ;
		 }
		 else {
			  response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
			  return ;
		 }
	}

	boolean flowstatus = requestManager.flowNextNode() ;
	if( !flowstatus ) {
		 response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
		 return ;
	}

	boolean logstatus = requestManager.saveRequestLog() ;

	rs.executeSql("SELECT projTemplateId FROM BillProjTemplateApprove WHERE requestid="+requestid+"");
	if(rs.next()){
		rs2.executeSql("UPDATE Prj_Template SET status='2' WHERE id="+rs.getInt("projTemplateId")+"");
	}
}
%>