<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>
<%@ page import="weaver.WorkPlan.WorkPlanLogMan" %>
<%@ page import="weaver.WorkPlan.WorkPlanHandler" %>
<%@ page import="java.text.*"%>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsc" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resource" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="exchange" class="weaver.WorkPlan.WorkPlanExchange" scope="page"/>
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>
<jsp:useBean id="workPlanViewer" class="weaver.WorkPlan.WorkPlanViewer" scope="page"/>
<jsp:useBean id="sysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page"/>
<jsp:useBean id="workPlanValuate" class="weaver.WorkPlan.WorkPlanValuate" scope="page"/>
<jsp:useBean id="workPlanShare" class="weaver.WorkPlan.WorkPlanShare" scope="page"/>

<%
	String userId = String.valueOf(user.getUID());
	String userType = user.getLogintype();
	
	Calendar current = Calendar.getInstance();
	String currentDate = Util.add0(current.get(Calendar.YEAR), 4) + "-" + Util.add0(current.get(Calendar.MONTH) + 1, 2) + "-" + Util.add0(current.get(Calendar.DAY_OF_MONTH), 2);
	String method = Util.null2String(request.getParameter("method"));
	String from = Util.null2String(request.getParameter("from"));
	WorkPlanHandler workPlanHandler = new WorkPlanHandler();
	
	String[] logParams;
	WorkPlanLogMan workPlanLogMan = new WorkPlanLogMan();
	
    //�ж��Ƿ�Ϊϵͳ����Աsysadmin 
    int isSysadmin=0;
    RecordSet rssysadminmenu=new RecordSet();
    rssysadminmenu.executeSql("select count(*) from hrmresourcemanager where id="+userId);	
    if(rssysadminmenu.next()){
	     isSysadmin=rssysadminmenu.getInt(1);
    }    
	
	if (method.equals("add") || method.equals("edit"))
	{
	    String color = "";
	    String workPlanType = request.getParameter("workPlanType");  //�ճ�����    
	    String beginDate = Util.null2String(request.getParameter("beginDate"));  //��ʼ����	    
	    String beginTime = request.getParameter("beginTime");  //��ʼʱ��
	    String endDate = Util.null2String(request.getParameter("endDate"));  //��������
	    String endTime = request.getParameter("endTime");  //����ʱ��
	    String remindBeforeStart = Util.null2String(request.getParameter("remindBeforeStart"));  //�Ƿ�ʼǰ����
	    String remindBeforeEnd = Util.null2String(request.getParameter("remindBeforeEnd"));  //�Ƿ����ǰ����
	    
	    WorkPlan workPlan = new WorkPlan();
	    
	    workPlan.setCreaterId(Integer.parseInt(userId));
	    workPlan.setCreateType(Integer.parseInt(userType));
	    
	    if(!"".equals(workPlanType) && null != workPlanType)
	    {
	        workPlan.setWorkPlanType(Integer.parseInt(workPlanType));  //�ճ�����	
	    }
	    workPlan.setWorkPlanName(Util.null2String(request.getParameter("planName")));  //����	   
	    workPlan.setUrgentLevel(Util.null2String(request.getParameter("urgentLevel")));  //�����̶�
	    workPlan.setRemindType(Util.null2String(request.getParameter("remindType")));  //�ճ����ѷ�ʽ
	    if(!"".equals(remindBeforeStart) && null != remindBeforeStart)
	    {
	        workPlan.setRemindBeforeStart(remindBeforeStart);  //�Ƿ�ʼǰ����
	    }
	    if(!"".equals(remindBeforeEnd) && null != remindBeforeEnd)
	    {
	        workPlan.setRemindBeforeEnd(remindBeforeEnd);  //�Ƿ����ǰ����
	    }
		
		String remindDateBeforeStart = request.getParameter("remindDateBeforeStart");
	    
	    if (remindDateBeforeStart != null ) {
	    	remindDateBeforeStart = remindDateBeforeStart.trim();
	    }

	    workPlan.setRemindTimesBeforeStart(Util.getIntValue(remindDateBeforeStart,0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimeBeforeStart")),0));  //��ʼǰ����ʱ��
	    workPlan.setRemindTimesBeforeEnd(Util.getIntValue(request.getParameter("remindDateBeforeEnd"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimeBeforeEnd")),0));  //����ǰ����ʱ��
		//workPlan.setRemindDateBeforeStart(Integer.parseInt(Util.null2String(request.getParameter("remindDateBeforeStart"))));  //��ʼǰ����ʱ��(Сʱ)
	    //workPlan.setRemindDateBeforeEnd(Integer.parseInt(Util.null2String(request.getParameter("remindDateBeforeEnd"))));  //����ǰ����ʱ�䣨Сʱ��
	    workPlan.setResourceId(Util.null2String(request.getParameter("memberIDs")));  //ϵͳ������
	    workPlan.setBeginDate(beginDate);  //��ʼ����   
	    if(!"".equals(beginTime) && null != beginTime)
	    {
	        workPlan.setBeginTime(beginTime);  //��ʼʱ��
	    }
	    else
	    {
	    	//���ǵ��½��ճ̵���ʼʱ��ͽ���ʱ�䲻ͬ
		    String validedatefrom = beginDate.substring(0,4)+"-01-01";
		    String validedateto = beginDate.substring(0,4)+"-12-31";
		    String startSql="select * from HrmSchedule  where validedatefrom <= '"+validedatefrom+"' and validedateto >= '"+validedateto+"' ";
	    	String startweek = getWeekByDate(beginDate)+"starttime1";
		    if(isSysadmin>0){//��Ϊϵͳ����Ա��ֱ��ȡ�ܲ�ʱ��
		    	startSql+=" and scheduletype = '3' ";
		    }else{
		    	startSql+=" and relatedid = (select m.subcompanyid1 from hrmresource m where m.id='"+userId+"')";
		    }
	    	rs.execute(startSql);
	    	if(rs.next()){
	              beginTime = rs.getString(startweek);
	              workPlan.setBeginTime(beginTime.equals("")?"00:00":beginTime);  //��ʼʱ��
	    	}else{//���޿���ʱ���¼ȡ 00:00
	    		  workPlan.setBeginTime("00:00");  //��ʼʱ��
	    	}	    	
	    }
	    workPlan.setEndDate(endDate);  //��������
	    if(!"".equals(workPlan.getEndDate()) && null != workPlan.getEndDate() && ("".equals(endTime) || null == endTime))
	    {	        
		    String validedatefrom = endDate.substring(0,4)+"-01-01";
		    String validedateto = endDate.substring(0,4)+"-12-31";
		    String endSql="select * from HrmSchedule  where validedatefrom <= '"+validedatefrom+"' and validedateto >= '"+validedateto+"' ";	    	
		    String endweek = getWeekByDate(endDate)+"endtime2";		    
		    if(isSysadmin>0){//��Ϊϵͳ����Ա��ֱ��ȡ�ܲ�ʱ��
		    	endSql+=" and scheduletype = '3' ";
		    }else{
		    	endSql+=" and relatedid = (select m.subcompanyid1 from hrmresource m where m.id='"+userId+"')";
		    }
	    	rsc.execute(endSql);
	    	if(rsc.next()){		    
                endTime = rsc.getString(endweek);
                workPlan.setEndTime(endTime.equals("")?"00:00":endTime);  //����ʱ��
    	    }else{  //���޿���ʱ���¼ȡ 00:00
    		    workPlan.setEndTime("00:00");  //����ʱ��
    	    }
	    }
	    else
	    {
	        workPlan.setEndTime(endTime);  //����ʱ��
	    }
	    workPlan.setDescription(Util.null2String(request.getParameter("description")));  //����
	    
	    workPlan.setCustomer(Util.null2String(request.getParameter("crmIDs")));  //��ؿͻ�
	    workPlan.setDocument(Util.null2String(request.getParameter("docIDs")));  //����ĵ� 
	    workPlan.setProject(Util.null2String(request.getParameter("projectIDs")));  //�����Ŀ
	    workPlan.setTask(Util.null2String(request.getParameter("taskIDs")));  //�����Ŀ����
	    workPlan.setWorkflow(Util.null2String(request.getParameter("requestIDs")));  //�������
	    //System.out.println("meetingid  :"+request.getParameter("meetingIDs"));
	    workPlan.setMeeting(Util.null2String(request.getParameter("meetingIDs")));  //��ػ���

	    String hrmPerformanceCheckDetailID = Util.null2String(request.getParameter("hrmPerformanceCheckDetailID"));
	    if(null == hrmPerformanceCheckDetailID || "".equals(hrmPerformanceCheckDetailID))
	    {
	        hrmPerformanceCheckDetailID = "-1";
	    }
	    workPlan.setPerformanceCheckId(Integer.parseInt(hrmPerformanceCheckDetailID));  //�Զ��忼��Ҷ�ӽڵ�
	    
	    
	    if(!"".equals(workPlan.getBeginDate()) && null != workPlan.getBeginDate())
	    {	    	
	    	List beginDateTimeRemindList = Util.processTimeBySecond(workPlan.getBeginDate(), workPlan.getBeginTime(), workPlan.getRemindTimesBeforeStart() * -1 * 60);
	    	workPlan.setRemindDateBeforeStart((String)beginDateTimeRemindList.get(0));  //��ʼǰ��������
	    	workPlan.setRemindTimeBeforeStart((String)beginDateTimeRemindList.get(1));  //��ʼǰ����ʱ��
	    }
	    if(!"".equals(workPlan.getEndDate()) && null != workPlan.getEndDate())
	    {
	    	List endDateTimeRemindList = Util.processTimeBySecond(workPlan.getEndDate(), workPlan.getEndTime(), workPlan.getRemindTimesBeforeEnd() * -1 * 60);
	    	workPlan.setRemindDateBeforeEnd((String)endDateTimeRemindList.get(0));  //����ǰ��������
	    	workPlan.setRemindTimeBeforeEnd((String)endDateTimeRemindList.get(1));  //����ǰ����ʱ��
	    }

	    if (method.equals("add"))
	    {	             
	        workPlanService.insertWorkPlan(workPlan);  //�����ճ�

		    workPlanShare.setDefaultShareDetail(user,String.valueOf(workPlan.getWorkPlanID()),workPlanType);//ֻ��������ʱ������Ĭ�Ϲ���	       
	        //������־
	        logParams = new String[]
	        { String.valueOf(workPlan.getWorkPlanID()), WorkPlanLogMan.TP_CREATE, userId, request.getRemoteAddr() };
	        workPlanLogMan.writeViewLog(logParams);
	
	        //ͨ�����������Ѳ����ճ̵���Ա sean 2005-11-25 for td3273
	        /*String wfTitle = "";
	        String wfRemark = "";
	        if (!"".equals(workPlan.getResourceId()))
	        {
	            wfTitle = Util.toScreen("�½������ƻ�:", user.getLanguage(), "0");
	            wfTitle += workPlan.getWorkPlanName();
	            wfTitle += "-" + resource.getResourcename(userId);
	            wfTitle += "-" + currentDate;
	            wfRemark = Util.toScreen("�����ƻ�:", user.getLanguage(), "1") + "<A href=/workplan/data/WorkPlan.jsp?workid=" + workPlan.getWorkPlanID() + ">" + Util.fromScreen2(workPlan.getWorkPlanName(), user.getLanguage()) + "</A>";
	            sysRemindWorkflow.setCRMSysRemind(wfTitle, 0, Util.getIntValue(userId), workPlan.getResourceId(), wfRemark);
	        }*/

	        //ҳ��ת��
	        response.sendRedirect("WorkPlanDetail.jsp?workid=" + workPlan.getWorkPlanID() + "&from=" + from);
	        if (from.equals("1"))
	        {
	            out.print("<script>window.opener.location.reload();</script>");
	        }	
	    }
	    else
	    {	        
	        WorkPlan oldWorkPlan = new WorkPlan();
	        oldWorkPlan.setWorkPlanID(Integer.parseInt(request.getParameter("workid")));
	        workPlan.setWorkPlanID(oldWorkPlan.getWorkPlanID());
	        String ip = request.getRemoteAddr();
	        
	        List workPlanList = workPlanService.getWorkPlanList(oldWorkPlan);
	        
	        for(int i = 0; i < workPlanList.size(); i++)
	        {
	            oldWorkPlan = (WorkPlan)workPlanList.get(i);
	            
	            workPlanService.updateWorkPlan(oldWorkPlan, workPlan);
	            
	            workPlanLogMan.insertEditLog(oldWorkPlan, workPlan, userId, ip);	            
	        }
	        	        	       
	        
	        //���½��������������ճ��޸�  Modify by sean 2005-11-25 for td3273
	        /*String wfTitle = "";
	        String wfRemark = "";
	        if (!"".equals(workPlan.getResourceId()))
	        {
	            wfTitle = Util.toScreen("��������ƻ�:", user.getLanguage(), "0");
	            wfTitle += workPlan.getWorkPlanName();
	            wfTitle += "-" + resource.getResourcename(userId);
	            wfTitle += "-" + currentDate;
	            wfRemark = Util.toScreen("�����ƻ�:", user.getLanguage(), "1") + "<A href=/workplan/data/WorkPlan.jsp?workid=" + workPlan.getWorkPlanID() + ">" + Util.fromScreen2(workPlan.getWorkPlanName(), user.getLanguage()) + "</A>";
	            sysRemindWorkflow.setCRMSysRemind(wfTitle, 0, Util.getIntValue(userId), workPlan.getResourceId(), wfRemark);
	        }*/
	
	        //�ճ̽�����Ա�����Ķ�����ɾ����ֱ��������Ա��¼����ֹ�����ȡ����
	        //workPlanValuate.changeWorkPlanMembers(planID);
	
	        //ҳ��ת��
	        response.sendRedirect("WorkPlanDetail.jsp?workid=" + workPlan.getWorkPlanID() + "&from=" + from);
	    }	
	}
	
	else if (method.equals("delete"))
	{
	    String planID = Util.null2String(request.getParameter("workid"));
	    PoppupRemindInfoUtil.deletePoppupRemindInfo(Util.getIntValue(planID),12);
		PoppupRemindInfoUtil.deletePoppupRemindInfo(Util.getIntValue(planID),13);
	    workPlanHandler.delete(planID);
	    
	    //������־
	    logParams = new String[]
	    { planID, WorkPlanLogMan.TP_DELETE, userId, request.getRemoteAddr() };	    
	    workPlanLogMan.writeViewLog(logParams);
	    
	    exchange.workPlanDelete(Integer.parseInt(planID));
	    
	    if (from.equals("1"))
	    {
	        out.print("<script>window.opener.document.frmmain.submit();window.close();</script>");
	    }
	    else
	    {
	        response.sendRedirect("WorkPlanView.jsp");
	    }
	}
	
	else if (method.equals("finish"))
	//���ύ�����
	{
	    String planID = Util.null2String(request.getParameter("workid"));
	    String[] creater = workPlanHandler.getCreater(planID);
	    String createrID = "";
	
	    if (creater != null)
	    {
	        createrID = creater[0];
	    }
	
	    String planName = workPlanHandler.getWorkPlanName(planID);
	
	    String accepter = createrID;
	    String wfTitle = "";
	    String wfRemark = "";
	
	    wfTitle = Util.toScreen("����������ƻ�:", user.getLanguage(), "0");
	    wfTitle += planName;
	    wfTitle += "-" + resource.getResourcename(userId);
	    wfTitle += "-" + currentDate;
	    wfRemark = Util.toScreen("�����ƻ�:", user.getLanguage(), "1") + "<A href=/workplan/data/WorkPlan.jsp?workid=" + planID + ">" + Util.fromScreen2(planName, user.getLanguage()) + "</A>";
	
	    sysRemindWorkflow.setCRMSysRemind(wfTitle, 0, Util.getIntValue(userId), accepter, wfRemark);
	
	    workPlanHandler.memberFinishWorkPlan(planID);

	    if (from.equals("1"))
	    {
	        out.print("<script>window.opener.document.frmmain.submit();window.close();</script>");
	    }
	    else
	    {
	        response.sendRedirect("WorkPlanView.jsp");
	    }
	}
	
	else if (method.equals("valfinish"))
	//�ϼ����
	{
	    String planID = Util.null2String(request.getParameter("workid"));
	    String planStatus = Util.null2String(request.getParameter("status"));
	    String valMembers = Util.null2String(request.getParameter("valmembers"));
	    String valScores = Util.null2String(request.getParameter("valscores"));
	
	    String[] params;
	    if (planStatus.equals("0"))
		//�����˴��
	    { 
	        params = new String[]
	        { planID, valMembers, valScores, currentDate };
	        workPlanValuate.createrValuateMembers(params);
	    }
	
	    if (planStatus.equals("1"))
		//������
	    {
	        params = new String[]
	        { planID, valMembers, valScores, userId, currentDate };
	        workPlanValuate.managerValuateMembers(params);
	    }

	    out.print("<script>window.opener.location.reload();window.close();</script>");
	}
	
	else if (method.equals("notefinish"))
	//�ύ�����
	{
	    String planID = Util.null2String(request.getParameter("workid"));
	    String planStatus = Util.null2String(request.getParameter("status"));
	
	    if (planStatus.equals("0"))
	    {
	        workPlanHandler.finishWorkPlan(planID);
	    }
	
	    if (planStatus.equals("1"))
	    {
	        workPlanHandler.closeWorkPlan(planID);
	    }
	
	    if (from.equals("1"))
	    {
	        out.print("<script>window.opener.document.frmmain.submit();window.close();</script>");	        
	    }
	    else
	    {
	        response.sendRedirect("WorkPlanView.jsp");
	    }
	}
	else if (method.equals("convert"))
	{
	    String planID = Util.null2String(request.getParameter("workid"));
	
	    workPlanHandler.note2WorkPlan(planID);
	
	    response.sendRedirect("WorkPlanDetail.jsp?workid=" + planID + "&from=" + from);
	}
	else if (method.equals("addnote"))
	{
	    String note = Util.null2String(request.getParameter("note"));
	    String planID = String.valueOf(workPlanHandler.addNote(note, userId, userType));
	
	    workPlanViewer.setWorkPlanShareById(planID);
	
	    //������־
	    logParams = new String[]
	    { planID, WorkPlanLogMan.TP_CREATE, userId, request.getRemoteAddr() };
	    workPlanLogMan.writeViewLog(logParams);

	    if (from.equals("1"))
	    {
	        out.print("<script>window.opener.location.reload();window.close();</script>");
	    }
	    else
	    {
	        response.sendRedirect("WorkPlanView.jsp");
	    }
	}
	else
	{
	    return;
	}
%>

<%!
// ��������ȡ���ڣ�TD20444��
public String getWeekByDate(String date){
	String week=""; 
	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
	   Date d=null;
	  try {
	   d = format1.parse(date);
	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	   Calendar   c   =   Calendar.getInstance();   
	   c.setTime(d);
	   week = c.getTime().toString().substring(0,3).toLowerCase();
	   return week;    	
}
%>