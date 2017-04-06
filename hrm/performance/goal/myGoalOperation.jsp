<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.SessionOper" %>
<%@ page import="weaver.hrm.performance.goal.GoalUtil" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="hrm" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="delalert" class="weaver.hrm.performance.DelAlertInfo" scope="page" />
<jsp:useBean id="ApproveParameter" class="weaver.workflow.request.ApproveParameter" scope="session"/>
<jsp:useBean id="sysWF" class="weaver.system.SysCreateWF" scope="page"/>

<%
String operation = Util.null2String(request.getParameter("operation"));
String operation2 = Util.null2String(request.getParameter("operation2"));
int goalId = 0;
String goalName = Util.null2String(request.getParameter("goalName"));
String goalCode = Util.null2String(request.getParameter("goalCode"));
int parentId = Util.getIntValue(request.getParameter("parentTargetId"));
String goalDate = Util.null2String((String)SessionOper.getAttribute(session,"goalDate"));
int objId = Util.getIntValue(request.getParameter("objId"));					//���ε�λ
int operations = user.getUID();															//������
int type_t = Util.getIntValue(request.getParameter("targetTypeId"));			//ָ������
String startDate = Util.null2String(request.getParameter("startDate"));
String endDate = Util.null2String(request.getParameter("endDate"));
String goalType = Util.null2String(request.getParameter("goalType"));		//Ŀ������:0���� 1�ֹ�˾ 2���� 3��Ա
String cycle = Util.null2String(request.getParameter("cycle"));				//����:0�� 1���� 2���� 3��
String goalProperty = Util.null2String(request.getParameter("goalProperty"));
String unit = Util.null2String(request.getParameter("unit"));							//������λ
double targetValue = Util.getDoubleValue(request.getParameter("targetValue"),0);
double previewValue = Util.getDoubleValue(request.getParameter("previewValue"),0);
String memo = Util.null2String(request.getParameter("memo"));
//TD
String percent_n = Util.null2String(request.getParameter("percent_n"));
//int percent_n = Util.getIntValue(request.getParameter("percent_n"),0);		//Ȩ��

String isApproved = Util.null2String(request.getParameter("isApproved"));
String currentTime = TimeUtil.getCurrentTimeString();
String clientIP = request.getRemoteAddr();

String sql = "";
String redirectUrl = "";

//Ŀ���½�===========================
if(operation.equals("goalAdd")){{
	if(operation2.equals("goalBreak")){
		String cycleSeason = Util.null2String(request.getParameter("cycleSeason"));			//
		String cycleMonth = Util.null2String(request.getParameter("cycleMonth"));				//
		if(cycle.equals("1")){
			goalDate = goalDate.substring(0,4) + cycleSeason;
		}else if(cycle.equals("0")){
			goalDate = goalDate.substring(0,4) + cycleMonth;
		}
	}
	
	boolean isReleased = false;

	int tmpGroupId = 0;
	/*
	//����GroupId
	int tmpGroupId = 0;
	sql = "SELECT groupId,status FROM HrmPerformanceGoal WHERE objId="+objId+" AND goalDate='"+goalDate+"' AND goalType='"+goalType+"' AND cycle='"+cycle+"'";
	rs.executeSql(sql);
	while(rs.next()){
		if(rs.getString("status").equals("3")){
			isReleased = true;
			break;
		}
		if(rs.getInt("groupId")!=-1){
			tmpGroupId = rs.getInt("groupId");
			break;
		}
	}
	//TD3707
	//added by hubo,2006-03-21
	if(isReleased){
		response.sendRedirect("myGoalBreak.jsp?id="+parentId+"&msg=1&msgObjId="+objId+"&msgGoalDate="+goalDate+"&msgGoalType="+goalType+"&msgCycle="+cycle+"");
		return;
	}
	*/

	if(operation2.equals("goalBreak")){
		String objIdAll = Util.null2String(request.getParameter("objId"));
		String[] aObjId = Util.TokenizerString2(objIdAll, "|");
		for(int i=0;i<aObjId.length;i++){
			if(aObjId[i].equals("")) continue;
			goalId = GoalUtil.getGoalMaxId();
			//save������Ϣ
			String[] aaObjId = Util.TokenizerString2(aObjId[i], ",");
			if(aaObjId.length>1){
				//�ֽ����������λ
				sql = "INSERT INTO HrmPerformanceGoal(id, goalName, objId, goalCode, parentId, goalDate, operations, type_t, startDate, endDate, goalType, cycle, property, unit, targetValue, previewValue, memo, percent_n, status, groupId)VALUES("+goalId+", '"+goalName+"', "+aaObjId[0]+", '"+goalCode+"', "+parentId+", '"+goalDate+"', "+operations+", "+type_t+", '"+startDate+"', '"+endDate+"', '"+aaObjId[1]+"', '"+cycle+"', '"+goalProperty+"', '"+unit+"', "+targetValue+", "+previewValue+", '"+memo+"', '0','0',"+tmpGroupId+")";
			}else{
				//�ֽ�����������λ
				sql = "INSERT INTO HrmPerformanceGoal(id, goalName, objId, goalCode, parentId, goalDate, operations, type_t, startDate, endDate, goalType, cycle, property, unit, targetValue, previewValue, memo, percent_n, status, groupId)VALUES("+goalId+", '"+goalName+"', "+aaObjId[0]+", '"+goalCode+"', "+parentId+", '"+goalDate+"', "+operations+", "+type_t+", '"+startDate+"', '"+endDate+"', '"+goalType+"', '"+cycle+"', '"+goalProperty+"', '"+unit+"', "+targetValue+", "+previewValue+", '"+memo+"', '0','0',"+tmpGroupId+")";
			}
			rs.executeSql(sql);

			//save���ֱ�׼
			int rownum = Util.getIntValue(request.getParameter("rownum"));
			String stdName = "";
			int point = 0;
			//out.println(rownum);
			for(int j=0;j<rownum;j++){
				stdName = Util.null2String(request.getParameter("stdName_"+j));
				point = Util.getIntValue(request.getParameter("point_"+j),0);
				sql = "INSERT INTO HrmPerformanceGoalStd (goalId,stdName,point) VALUES ("+goalId+",'"+stdName+"',"+point+")";
				//out.println(sql);
				rs.executeSql(sql);
			}
		}
	}else{
		goalId = GoalUtil.getGoalMaxId();
		//save������Ϣ
		sql = "INSERT INTO HrmPerformanceGoal(id, goalName, objId, goalCode, parentId, goalDate, operations, type_t, startDate, endDate, goalType, cycle, property, unit, targetValue, previewValue, memo, percent_n, status, groupId)VALUES("+goalId+", '"+goalName+"', "+objId+", '"+goalCode+"', "+parentId+", '"+goalDate+"', "+operations+", "+type_t+", '"+startDate+"', '"+endDate+"', '"+goalType+"', '"+cycle+"', '"+goalProperty+"', '"+unit+"', "+targetValue+", "+previewValue+", '"+memo+"', '"+percent_n+"','0',"+tmpGroupId+")";
		//out.println(sql);
		rs.executeSql(sql);

		//save���ֱ�׼
		int rownum = Util.getIntValue(request.getParameter("rownum"));
		String stdName = "";
		int point = 0;
		//out.println(rownum);
		for(int i=0;i<rownum;i++){
			stdName = Util.null2String(request.getParameter("stdName_"+i));
			point = Util.getIntValue(request.getParameter("point_"+i),0);
			sql = "INSERT INTO HrmPerformanceGoalStd (goalId,stdName,point) VALUES ("+goalId+",'"+stdName+"',"+point+")";
			//out.println(sql);
			rs.executeSql(sql);
		}
		
		String _sql = "SELECT a.id,a.status FROM BPMGoalGroup a,HrmPerformanceGoal b where a.objid = b.objid and a.objid = b.objid and a.goalDate = b.goalDate and a.goalType = b.goalType and a.cycle = b.cycle and b.id= "+goalId; 
		rs.executeSql(_sql);   
		if(rs.next() && rs.getInt(2)==3){ //����ܵ�Ŀ���ѷ���  ��������������
				rs.executeSql("UPDATE HrmPerformanceGoal SET modifyStatus='1',modifyUser="+user.getUID()+" WHERE id="+goalId+"");
				rs.executeSql("INSERT INTO HrmKPIRevision (goalId,operator,operateTime,operateType,clientIP) VALUES ("+goalId+","+user.getUID()+",'"+currentTime+"','1','"+clientIP+"')");
			}
		}
	}
	
	//ɾ��������Ϣ
   if (goalType.equals("3"))
   delalert.delAlert(objId,cycle,goalDate,0,"3");

	redirectUrl = operation2.equals("goalBreak") ? "myGoalBreak.jsp?id="+parentId+"" : "myGoalListIframe.jsp";

//����ָ��===========================
}else if(operation.equals("targetImport")){
	/*
	String targetIds = Util.null2String(request.getParameter("targetIds"));
	String[] arrayTargetIds = targetIds.split(",");
	for(int i=0;i<arrayTargetIds.length;i++){
		sql = "SELECT * FROM HrmPerformanceTargetDetail WHERE id="+Util.getIntValue(arrayTargetIds[i])+"";
		out.println(sql);
	}
	*/

//�ύ����===========================
}else if(operation.equals("goalSubmit")){
	int workflowId = 0;
	int goalGroupId = 0;
	String goalGroupName = Util.null2String(request.getParameter("goalGroupName"));
	objId = ((Integer)SessionOper.getAttribute(session,"objId")).intValue();
	goalType = (String)SessionOper.getAttribute(session,"goalType");
	goalDate = (String)SessionOper.getAttribute(session,"goalDate");
	cycle = (String)SessionOper.getAttribute(session,"cycle");
	sql = "SELECT id FROM BPMGoalGroup WHERE objId="+objId+" AND goalType='"+goalType+"' AND	goalDate='"+goalDate+"' AND cycle='"+cycle+"'";
	rs.executeSql(sql);
	if(rs.next()){
		goalGroupId = rs.getInt("id");
		sql = "UPDATE BPMGoalGroup SET status='2' WHERE id="+goalGroupId+"";
		rs.executeSql(sql);
		//����Ŀ����groupId
		sql = "UPDATE HrmPerformanceGoal SET groupId="+goalGroupId+" WHERE objId="+objId+" AND goalType='"+goalType+"' AND	goalDate='"+goalDate+"' AND cycle='"+cycle+"'";
		rs.executeSql(sql);
	}else{
		goalGroupId = GoalUtil.getGoalGroupMaxId();
		
		//��Ŀ����������
		int objIdFlow = objId;
		if(goalType.equals("3")){
			objIdFlow = Util.getIntValue(hrm.getDepartmentID(String.valueOf(objId)));
		}
		rs.executeSql("SELECT goalFlowId FROM HrmPerformanceCheckFlow WHERE objId="+objIdFlow+" AND objType='"+goalType+"'");
		if(rs.next()){
			workflowId = rs.getInt("goalFlowId");
		}
		if(workflowId==-1){
			out.println("<div style='color:red;font-size:12px'>"+SystemEnv.getHtmlLabelName(18268,user.getLanguage())+"!</div>");
			return;
		}
		//������������
		String subject = SystemEnv.getHtmlLabelName(18102,user.getLanguage())+":"+goalGroupName;
		ArrayList infos = new ArrayList();
		infos.add(new Integer(goalGroupId));
		int requestid = 0;
		try{
		    sysWF.setUser(user);
			requestid = sysWF.setWorkflowInfo(workflowId,subject,user.getUID(),infos);
		}catch(Exception e){
			//TD3927
			//modified by hubo,2006-03-16
			redirectUrl ="/hrm/performance/goal/myGoalListIframe.jsp?msg=1";
			response.sendRedirect(redirectUrl);
			return;
		}

		//����Ŀ����groupId
		sql = "UPDATE HrmPerformanceGoal SET groupId="+goalGroupId+" WHERE objId="+objId+" AND goalType='"+goalType+"' AND	goalDate='"+goalDate+"' AND cycle='"+cycle+"'";
		rs.executeSql(sql);
		//Ŀ��Group���в���һ����¼
		sql = "INSERT INTO BPMGoalGroup (id,goalName,objId,goalType,goalDate,cycle,status,requestid) VALUES ("+goalGroupId+",'"+goalGroupName+"',"+objId+",'"+goalType+"','"+goalDate+"','"+cycle+"','2',"+requestid+")";
		rs.executeSql(sql);
	}
	redirectUrl ="/hrm/performance/goal/myGoalListIframe.jsp";

//�˻��ύ===========================
}else if(operation.equals("goalSubmit2")){
	objId = ((Integer)SessionOper.getAttribute(session,"objId")).intValue();
	goalType = (String)SessionOper.getAttribute(session,"goalType");
	goalDate = (String)SessionOper.getAttribute(session,"goalDate");
	cycle = (String)SessionOper.getAttribute(session,"cycle");
	int requestId = 0;
	int groupId = Util.getIntValue(request.getParameter("groupId"));
	sql = "SELECT id FROM BPMGoalGroup WHERE objId="+objId+" AND goalType='"+goalType+"' AND	goalDate='"+goalDate+"' AND cycle='"+cycle+"'";
	rs.executeSql(sql);
	if(rs.next()){
		groupId = rs.getInt("id");
	}
	sql = "SELECT requestid FROM BillBPMApproveGoal WHERE paraId="+groupId+"";
	rs.executeSql(sql);
	if(rs.next()){
		requestId = rs.getInt("requestId");
		//����Ŀ����groupId
		sql = "UPDATE HrmPerformanceGoal SET groupId="+groupId+" WHERE objId="+objId+" AND goalType='"+goalType+"' AND	goalDate='"+goalDate+"' AND cycle='"+cycle+"'";
		rs.executeSql(sql);
	}
	redirectUrl ="/workflow/request/BillBPMApproveGoalOperation.jsp?fromWhere=goalList&requestid="+requestId+"";

//Ŀ��ֽ�===========================
}else if(operation.equals("goalBreak")){

//Ŀ��༭===========================
}else if(operation.equals("goalEdit")){
	goalId = Util.getIntValue(request.getParameter("id"));

	//�༭�ѷ�����Ŀ��ʱ
	//��������¼-----------------------------------------
	boolean saveRevision = Util.null2String(request.getParameter("saveRevision")).equals("1") ? true : false;
	if(saveRevision){
		//rs.executeSql("INSERT INTO HrmKPIRevision (goalId,operator,operateTime,operateType,clientIP) VALUES ("+goalId+","+user.getUID()+",'"+currentTime+"','0','"+clientIP+"')");
		//��ϸ----------------------------------------------
		String _goalName = "";
		String _goalCode = "";
		int _parentId = 0;
		int _typeT = 0;
		String _startDate="", _endDate="";
		String _property = "";
		String _unit = "";
		String _targetValue="", _previewValue="";
		String _memo = "";
		String _percentN = "";
		
		rs.executeSql("SELECT * FROM HrmPerformanceGoal WHERE id="+goalId+"");
		if(rs.next()){
			_goalName = rs.getString("goalname");
			_goalCode = rs.getString("goalCode");
			_parentId = rs.getInt("parentid");
			_typeT = rs.getInt("type_t");
			_startDate = rs.getString("startdate");
			_endDate = rs.getString("enddate");
			_property = rs.getString("property");
			_unit = rs.getString("unit");
			_targetValue = rs.getString("targetValue");
			_previewValue = rs.getString("previewValue");
			_memo = rs.getString("memo");
			_percentN = rs.getString("percent_n");
		}
		String sqlPrefix = "INSERT INTO HrmKPIRevisionDetail (goalId,operator,operateTime,operateType,clientIP,fieldName,originalValue,updatedValue) VALUES ("+goalId+","+user.getUID()+",'"+currentTime+"','0','"+clientIP+"',";
		String sqlTemp = "";
		if(!goalName.equals(_goalName)){
			sqlTemp = "'goalName','"+_goalName+"','"+goalName+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!goalCode.equals(_goalCode)){
			sqlTemp = "'goalCode','"+_goalCode+"','"+goalCode+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(parentId!=_parentId){
			sqlTemp = "'parentId','"+_parentId+"','"+parentId+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(type_t!=_typeT){
			sqlTemp = "'type_t','"+_typeT+"','"+type_t+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!startDate.equals(_startDate)){
			sqlTemp = "'startDate','"+_startDate+"','"+startDate+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!endDate.equals(_endDate)){
			sqlTemp = "'endDate','"+_endDate+"','"+endDate+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!goalProperty.equals(_property)){
			sqlTemp = "'property','"+_property+"','"+goalProperty+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!unit.equals(_unit)){
			sqlTemp = "'unit','"+_unit+"','"+unit+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!String.valueOf(targetValue).equals(_targetValue)){
			sqlTemp = "'targetValue','"+_targetValue+"','"+targetValue+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!String.valueOf(previewValue).equals(_previewValue)){
			sqlTemp = "'previewValue','"+_previewValue+"','"+previewValue+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!memo.equals(_memo)){
			sqlTemp = "'memo','"+_memo+"','"+memo+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
		if(!percent_n.equals(_percentN)){
			sqlTemp = "'percent_n','"+_percentN+"','"+percent_n+"')";
			rs.executeSql(sqlPrefix + sqlTemp);
		}
	}
	
	String _sql = "SELECT a.id,a.status FROM BPMGoalGroup a,HrmPerformanceGoal b where a.objid = b.objid and a.goalDate = b.goalDate and a.goalType = b.goalType and a.cycle = b.cycle and b.id= "+goalId; 
	rs.executeSql(_sql);
	if(rs.next() && rs.getInt(2)==3){ //����ܵ�Ŀ���ѷ���  ��������������
		if(isApproved.equals("true")){
			rs.executeSql("UPDATE HrmPerformanceGoal SET modifyStatus='2',modifyUser="+user.getUID()+" WHERE id="+goalId+"");
			rs.executeSql("INSERT INTO HrmKPIRevisionLog SELECT * FROM HrmPerformanceGoal WHERE id="+goalId+"");
			rs.executeSql("INSERT INTO HrmKPIRevision (goalId,operator,operateTime,operateType,clientIP) VALUES ("+goalId+","+user.getUID()+",'"+currentTime+"','2','"+clientIP+"')");
		}
	}

	//update������Ϣ-----------------------------------------
	if(goalProperty.equals("0")){
		targetValue = 0;
		previewValue = 0;
	}
	sql = "UPDATE HrmPerformanceGoal SET goalName='"+goalName+"', goalCode='"+goalCode+"', parentId="+parentId+", goalDate='"+goalDate+"', type_t="+type_t+", startDate='"+startDate+"', endDate='"+endDate+"', cycle='"+cycle+"', property='"+goalProperty+"', unit='"+unit+"', targetValue="+targetValue+", previewValue="+previewValue+", memo='"+memo+"', percent_n='"+percent_n+"' WHERE id="+goalId+"";
	rs.executeSql(sql);


	//update���ֱ�׼-----------------------------------------
	sql = "DELETE FROM HrmPerformanceGoalStd WHERE goalId="+goalId+"";
	rs.executeSql(sql);
	int rownum = Util.getIntValue(request.getParameter("rownum"));
	String stdName = "";
	int point = 0;
	for(int i=0;i<rownum;i++){
		stdName = Util.null2String(request.getParameter("stdName_"+i));
		point = Util.getIntValue(request.getParameter("point_"+i),0);
		sql = "INSERT INTO HrmPerformanceGoalStd (goalId,stdName,point) VALUES ("+goalId+",'"+stdName+"',"+point+")";
		//out.println(sql);
		rs.executeSql(sql);
	}

	redirectUrl = "myGoalView.jsp?id="+goalId+"";

//Ŀ�굼��ָ���===========================
}else if(operation.equals("exportToTarget")){
	int targetDetailId = 0;
	String goalIds = Util.null2String(request.getParameter("goalIds"));
	String[] arrayGoalIds = Util.TokenizerString2(goalIds,",");
	for(int i=0;i<arrayGoalIds.length;i++){
		targetDetailId = GoalUtil.getTargetDetailMaxId();
		sql = "INSERT INTO HrmPerformanceTargetDetail (id,targetId,targetName,targetCode,type_l,cycle,type_t,unit,targetValue,previewValue,memo) SELECT "+targetDetailId+",type_t,goalName,goalCode,goalType,cycle,property,unit,targetValue,previewValue,memo FROM HrmPerformanceGoal WHERE id="+arrayGoalIds[i]+"";
		//out.println(sql);
		rs.executeSql(sql);
		
		//���ֱ�׼
		sql = "INSERT INTO HrmPerformanceTargetStd (targetDetailId,stdName,point) SELECT "+targetDetailId+",stdName,point FROM HrmPerformanceGoalStd WHERE goalId="+arrayGoalIds[i]+"";
		//out.println(sql);
		rs.executeSql(sql);
		//TD3689
		//added by hubo,2006-03-16
		sql = "UPDATE HrmPerformanceGoal SET beExported='1' WHERE id="+arrayGoalIds[i]+"";
		rs.executeSql(sql);
	}

	out.println("<script type='text/javascript'>alert('"+SystemEnv.getHtmlLabelName(18419,user.getLanguage())+"');history.back();</script>");
	return;

//Ȩ�ص���=================================
}else if(operation.equals("modifyPercent")){
	String[] percentValues = request.getParameterValues("percent_n");
	String[] percentIDs = request.getParameterValues("percent_id");
	for(int i=0;i<percentIDs.length;i++){
		sql = "UPDATE HrmPerformanceGoal SET percent_n='"+percentValues[i]+"' WHERE id="+Util.getIntValue(percentIDs[i])+"";
		rs.executeSql(sql);
		//out.println(sql);
	}
	redirectUrl = "myGoalListIframe.jsp";

//Ŀ��ɾ��==================================
}else if(operation.equals("delete")){
	goalId = Util.getIntValue(request.getParameter("id"));
	
	String _sql = "SELECT a.id,a.status FROM BPMGoalGroup a,HrmPerformanceGoal b where a.objid = b.objid and a.goalDate = b.goalDate and a.goalType = b.goalType and a.cycle = b.cycle and b.id= "+goalId; 
    boolean  candelete = true;
    rs.executeSql(_sql);
	if(rs.next()){ //����ܵ�Ŀ���ύ������ ɾ����������ȷ�� 
		candelete = false;
	}
	if(isApproved.equals("true") && !candelete){
		sql = "UPDATE HrmPerformanceGoal SET modifyStatus='3' WHERE id="+goalId+"";
		rs.executeSql(sql);
		rs.executeSql("INSERT INTO HrmKPIRevision (goalId,operator,operateTime,operateType,clientIP) VALUES ("+goalId+","+user.getUID()+",'"+currentTime+"','3','"+clientIP+"')");
	}else{
		sql = "DELETE FROM HrmPerformanceGoal WHERE id="+goalId+"";
		rs.executeSql(sql);
	}
	redirectUrl = "myGoalListIframe.jsp";
}

response.sendRedirect(redirectUrl);
%>