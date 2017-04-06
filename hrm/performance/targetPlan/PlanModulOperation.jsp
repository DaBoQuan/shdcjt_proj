    <%@ page language="java" contentType="text/html; charset=GBK" %>
    <%@ page import="java.security.*,weaver.general.Util,java.text.*,java.util.Date" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.math.BigDecimal" %>
    <%@ page import="weaver.general.SessionOper" %>
    <%@ include file="/systeminfo/init.jsp" %>
    <jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsf" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsk" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rse" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsd" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="createWF" class="weaver.system.SysCreateWF" scope="page" />
    <jsp:useBean id="plan" class="weaver.hrm.performance.targetplan.PlanInfo" scope="page" />
    <jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
    <jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
    <jsp:useBean id="workPlanModuleManager" class="weaver.WorkPlan.WorkPlanModuleManager" scope="page" />
    
    <%
    
  
    String operationType=Util.null2String(request.getParameter("operationType"));
    int immediatetouch = Util.getIntValue(Util.null2String(request.getParameter("immediatetouch")), 0);//�Ƿ���������
 
    //�ƻ���insert
    if (operationType.equals("planAdd")){

    String deptId="";
    String subCompany="";
    deptId=""+user.getUserDepartment();
    subCompany=""+user.getUserSubCompany1();
    String createtype=user.getLogintype();
    String id=plan.getMaxID("targetplanid");
    //String mid=plan.getMaxID("plangroupid");
    String name=Util.fromScreen(request.getParameter("name"),user.getLanguage());
    String type="";
    String objId=""+user.getUID();
	String type_d="3"; //�ƻ�����������
    String createrid=""+user.getUID();
    String urgentlevel=Util.null2String(request.getParameter("urgentlevel"));
    String isremind=Util.null2o(request.getParameter("isremind"));
    String waketime=Util.null2o(request.getParameter("waketime"));
    String mid=Util.null2String(request.getParameter("id"));
    String principal=Util.null2String(request.getParameter("principal"));
    String crmid=Util.null2String(request.getParameter("crmid"));
    String docid=Util.null2String(request.getParameter("docid"));
    String projectid=Util.null2String(request.getParameter("projectid"));
    String requestid=Util.null2String(request.getParameter("requestid"));
    String description=Util.convertInput2DB(request.getParameter("description"));
    String pName=Util.null2String(request.getParameter("pName"));
    String planProperty=Util.null2String(request.getParameter("planProperty"));
    
    String remindType = Util.null2String(request.getParameter("remindType"));  //�ճ����ѷ�ʽ
    String remindBeforeStart = Util.null2String(request.getParameter("remindBeforeStart"));  //�Ƿ�ʼǰ����
    String remindBeforeEnd = Util.null2String(request.getParameter("remindBeforeEnd"));  //�Ƿ����ǰ����
    
    int remindTimesBeforeStart = Util.getIntValue(request.getParameter("remindDateBeforeStart"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimeBeforeStart")),0);  //��ʼǰ����ʱ��
    int remindTimesBeforeEnd=Util.getIntValue(request.getParameter("remindDateBeforeEnd"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimeBeforeEnd")),0);  //����ǰ����ʱ��
    
    //System.out.println("remindTimesBeforeStart : "+remindTimesBeforeStart);
    //System.out.println("remindTimesBeforeEnd : "+remindTimesBeforeEnd);
    
    if(null == planProperty || "".equals(planProperty))
    {
        planProperty = "-1";
    }
    String timeModul=Util.null2String(request.getParameter("timeModul"));
    String frey=Util.null2String(request.getParameter("frey"));
    String frequency="";
    String frequencyy="";
    String planId="";
    String status="3";
    String unitType = Util.null2String(request.getParameter("unittype"));
    String type_n= Util.null2String(request.getParameter("type_n"));
    if (type_n.equals("0")) status="0";
    if (isremind.equals("")) isremind="1";
    
   
    	if (isremind.equals("2")) {
		if (!waketime.equals("")) {
			BigDecimal b1 = new BigDecimal(waketime);
			float a1 = b1.setScale(1, BigDecimal.ROUND_HALF_UP).floatValue();
			int a2 = 1;
			if (unitType.equals("1"))
				a2 = 60;
			else
				a2 = 1440;

			waketime = String.valueOf(a1 * a2);
			if (waketime.indexOf(".") != -1)
				waketime = waketime.substring(0, waketime.indexOf("."));

		} else
			waketime = "0";

	} 
	if (timeModul.equals("0")) type="3";
	else if (timeModul.equals("1")) type="2";
	else if (timeModul.equals("2")) type="0";
	else if (timeModul.equals("3")) type="5";
    if (!timeModul.equals("9"))
    {
    frequency=Util.null2o(request.getParameter("fer_"+timeModul));
    frequencyy=Util.null2o(request.getParameter("frey"));
    frequencyy=frequencyy.equals("0")?"1":frequencyy;
    
    }
    else
    {
    frequency="0";
    frequencyy="0";
    }
    
    
    
    String workPlanTypeID = "-1";  //�ճ�����ID
    if("0".equals(type_n))
    //������Ϊ��������ʱ�������ճ�����
    {
        workPlanTypeID = Util.null2String(request.getParameter("workPlanType"));        
    }
    if("".equals(workPlanTypeID) || null == workPlanTypeID)
    {
        workPlanTypeID = "-1";
    }    

    String createType = "";  //�������� 0������ 1������	
    String workPlanCreateTime = "";  //��������ʱ��    
    
    String persistentType = Util.null2String(request.getParameter("timeType"));  //�ճ̳������� 1���� 2��Сʱ 3������    
    String persistentTimes = Util.null2o(request.getParameter("times"));  //�ճ̳�������
    
    String availableBeginDate = Util.null2String(request.getParameter("beginDate"));  //�ճ�ģ����Ч��ʼʱ��   
    String availableEndDate = Util.null2String(request.getParameter("endDate"));  //�ճ�ģ����Ч����ʱ��

	if(!"9".equals(timeModul))
	//����Ҫ��������ʱ
	{
	    if("3".equals(timeModul))
	    //��
	    {
	        workPlanCreateTime = Util.null2String(request.getParameter("dayTime"));
	    }
	    else if("0".equals(timeModul))
	    //��
	    {
	        workPlanCreateTime = Util.null2String(request.getParameter("weekTime"));
	    }
	    else if("1".equals(timeModul))
	    //��
	    {
	        createType = Util.null2String(request.getParameter("monthType"));        
	        
	        workPlanCreateTime = Util.null2String(request.getParameter("monthTime"));
	    }
	    else if("2".equals(timeModul))
	    //��
	    {
	        createType = Util.null2String(request.getParameter("yearType"));
	        
	        workPlanCreateTime = Util.null2String(request.getParameter("yearTime"));
	    }
	    if("".equals(workPlanCreateTime) || null == workPlanCreateTime)
	    //�������ʱ��Ϊ�գ���Ĭ��Ϊ00:00
	    {
	        workPlanCreateTime = "00:00";
	    }	    
	}
	else	
	{
	    persistentTimes = "";
	}
                
    rse.execute("SELECT * FROM HrmPerformancePlanModul WHERE ID = " + mid);
    
    if (rse.next())
    { 
	    planId=rse.getString("id");
	    id=planId;
	    
	    String SQL = "UPDATE HrmPerformancePlanModul"
	    	+ " SET name = '" + name + "',"
	    	+ " type_n = '" + type_n + "',"
	    	+ " planProperty = " + planProperty + ","
	    	+ " status = '" + status + "',"
	    	+ " isRemind = " + isremind + ","
	    	+ " wakeTime = " + waketime + ","
	    	+ " principal = '" + principal + "',"
	    	+ " crmID = '" + crmid + "',"
	    	+ " docID = '" + docid + "',"
	    	+ " projectID = '" + projectid + "',"
	    	+ " requestID = '" + requestid + "',"
	    	+ " description = '" + description + "',"
	    	+ " timeModul = '" + timeModul + "',"
	    	+ " frequency = " + frequency + ","
	    	+ " frequencyy = " + frequencyy + " ,"
	    	+ " urgentLevel = '" + urgentlevel + "',"
	    	
	    	+ " workPlanTypeID = " + workPlanTypeID + ","
	    	+ " createType = '" + createType + "',"
	    	+ " workPlanCreateTime = '" + workPlanCreateTime + "',"
	    	+ " persistentType = '" + persistentType + "',"
	    	+ " persistentTimes = '" + persistentTimes + "',"
	    	+ " availableBeginDate = '" + availableBeginDate + "',"
	    	+ " availableEndDate = '" + availableEndDate + "',"
	    	+ " remindBeforeStart = '"+remindBeforeStart+"',"
	    	+ " remindBeforeEnd = '"+remindBeforeEnd+"',"
	    	+ " remindType = "+remindType+","
	    	+ " remindTimesBeforeStart = "+remindTimesBeforeStart+","
	    	+ " remindTimesBeforeEnd = "+remindTimesBeforeEnd+","
	    	+ " immediatetouch="+immediatetouch
	    	+ " WHERE ID = " + planId;
		//System.out.println("update sql : "+SQL);
	    rs.execute(SQL);
	    
	    //rs.execute("DELETE FROM HrmPerformancePlanCheck WHERE planModulId = " + planId); //��ձ�־��
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		Date dt = new Date();
		String nowdate = format.format(dt);
		//ɾ����ģ�崥����δ�����ճ�
		String sql  = "delete from workplan where id in(select workplanid from HrmPerformancePlanCheck WHERE planModulId = " + planId+" and plandate>='"+nowdate+"')";
		
		//System.out.println("sql : "+sql);
		rs.executeSql(sql);
		rs.execute("DELETE FROM HrmPerformancePlanCheck WHERE planModulId = " + planId+" and plandate>='"+nowdate+"'"); //��ձ�־��

    }
    else
    {
        String SQL = "INSERT INTO HrmPerformancePlanModul(id,type_n,name,cycle,planType,objId,createrid,resourceid,status,planProperty,isremind,waketime,principal,crmid,docid,projectid,requestid,description,timeModul,frequency,frequencyy,deptId,subcompanyId,createrType,urgentLevel, workPlanTypeID, createType, workPlanCreateTime, persistentType, persistentTimes, availableBeginDate, availableEndDate,"
        			+"remindBeforeStart,remindBeforeEnd,remindType,remindTimesBeforeStart,remindTimesBeforeEnd,immediatetouch) "
			+ " values("+id+",'"+type_n+"','"+name+"','"+type+"','3',"+objId+","+createrid+","+createrid+",'"+status+"',"+planProperty+","+isremind+","+waketime+",'"+principal+"','"+crmid+"','"+docid+"','"+projectid+"','"+requestid+"','"+description+"','"+timeModul+"',"+frequency+","+frequencyy+","+deptId+","+subCompany+",'"+createtype+"','"+urgentlevel + "', " + workPlanTypeID + ", '" + createType + "', '" + workPlanCreateTime + "', '" + persistentType + "', '" + persistentTimes + "', '" + availableBeginDate + "', '" + availableEndDate 
			+ "','"+remindBeforeStart + "', '" +remindBeforeEnd + "', " +remindType + ", " +remindTimesBeforeStart + ", " +remindTimesBeforeEnd+","+immediatetouch+")";
		//System.out.println("insert sql : "+SQL);
    	rs.execute(SQL);    
    }

    
    //�ؼ�����
    int rownum = Util.getIntValue(request.getParameter("rownum"));
	String keyName = "";
	int viewSort = 0;
	String sql="";
	String sql1="";
	//out.println(rownum);
	sql1="delete from HrmPerformancePlanKeyModul where planId="+id;
	rs.executeSql(sql1);
	for(int i=0;i<rownum;i++){
		keyName = Util.null2String(request.getParameter("keyName_"+i));
		viewSort = Util.getIntValue(request.getParameter("viewSort_"+i),0);
		
		sql = "INSERT INTO HrmPerformancePlanKeyModul  VALUES ("+id+",'"+keyName+"',"+viewSort+")";
		//out.println(sql);
		
		rs.executeSql(sql);
	}	
	
	
    //�ɹ�����
    int rownum1 = Util.getIntValue(request.getParameter("rownum1"));
	String effortName = "";
	int viewSort1 = 0;
	 sql="";
	 sql1="";
	//out.println(rownum);
	sql1="delete from HrmPerformancePlanEffortModul where planId="+id;
	rs.executeSql(sql1);
	for(int i=0;i<rownum1;i++){
		effortName = Util.null2String(request.getParameter("effortName_"+i));
		viewSort1 = Util.getIntValue(request.getParameter("viewSort1_"+i),0);
		
		sql = "INSERT INTO HrmPerformancePlanEffortModul  VALUES ("+id+",'"+effortName+"',"+viewSort1+")";
		//out.println(sql);
		
		rs.executeSql(sql);
	}
	//���Ϊ����������������ճ�
	if(immediatetouch==1)
	{
		workPlanModuleManager.createAllWorkPlan(id);
	}
	if("0".equals(type_n))
	//�ճ�ת���б�ҳ��
	{
	    response.sendRedirect("PlanModulList.jsp?target=workplan");
	}
	else
	//Ŀ�꼨Чת��
	{
		response.sendRedirect("PlanModelAdd.jsp?id="+id);
    	//out.print("<script>history.go(-1);</script>");
	}

    }
    
    
    //�����ؼ����insert
    if (operationType.equals("KeyAdd")){
   
    String viewSort=Util.null2String(request.getParameter("viewSort"));
    String keyName=Util.fromScreen(request.getParameter("keyName"),user.getLanguage());
    String id=Util.null2String(request.getParameter("id"));
    rs.execute("insert into  HrmPerformancePlanKeyModul  values("+id+",'"+keyName+"',"+viewSort+") ");
     out.print("<script>history.go(-2);</script>");
    }
    
    
     //�����ؼ����update
    if (operationType.equals("KeyEdit")){
   
    String viewSort=Util.null2String(request.getParameter("viewSort"));
    String keyName=Util.fromScreen(request.getParameter("keyName"),user.getLanguage());
    String id=Util.null2String(request.getParameter("id"));
    String did=Util.null2String(request.getParameter("did"));
    rs.execute("update  HrmPerformancePlanKeyModul  set keyName='"+keyName+"',viewSort="+viewSort+" where id="+did);
    out.print("<script>history.go(-2);</script>");
    }
    
     
    //�����ɹ���insert
    if (operationType.equals("EffortAdd")){
   
    String viewSort=Util.null2String(request.getParameter("viewSort"));
    String effortName=Util.fromScreen(request.getParameter("effortName"),user.getLanguage());
    String id=Util.null2String(request.getParameter("id"));
    String planDate=Util.null2String(request.getParameter("planDate"));
    String type=Util.null2String(request.getParameter("type"));
    rs.execute("insert into  HrmPerformancePlanEffortModul  values("+id+",'"+effortName+"',"+viewSort+") ");
    out.print("<script>history.go(-2);</script>");
    }
    
    
     //�����ɹ���update
    if (operationType.equals("EffortEdit")){
   
    String viewSort=Util.null2String(request.getParameter("viewSort"));
    String effortName=Util.fromScreen(request.getParameter("effortName"),user.getLanguage());
    String id=Util.null2String(request.getParameter("id"));
    String did=Util.null2String(request.getParameter("did"));
    String planDate=Util.null2String(request.getParameter("planDate"));
    String type=Util.null2String(request.getParameter("type"));
    rs.execute("update  HrmPerformancePlanEffortModul set effortName='"+effortName+"',viewSort="+viewSort+" where id="+did);
    out.print("<script>history.back(-2);</script>");
    }
    
     
    if (operationType.equals("del"))
    //ɾ��ģ��
    {   
	    String id=Util.null2String(request.getParameter("id"));
	    DateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		Date dt = new Date();
		String nowdate = format.format(dt);
		//ɾ����ģ�崥����δ�����ճ�
		String sql  = "delete from workplan where id in(select workplanid from HrmPerformancePlanCheck WHERE planModulId = " + id+" and plandate>='"+nowdate+"')";
		
		//System.out.println("sql : "+sql);
		rs.executeSql(sql);
		rs.execute("DELETE FROM HrmPerformancePlanCheck WHERE planModulId = " + id+" and plandate>='"+nowdate+"'"); //��ձ�־��
	    rs.execute("delete from  HrmPerformancePlanKeyModul where PlanId="+id);
	    rs.execute("delete from  HrmPerformancePlanEffortModul where PlanId="+id);
	    rs.execute("delete from  HrmPerformancePlanModul where id="+id);
	    out.print("<script>history.go(-1);</script>");
    }
    %>
 