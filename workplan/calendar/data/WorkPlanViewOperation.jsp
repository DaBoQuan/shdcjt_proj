<%@ page language="java" contentType="text/html; charset=gbk" %><?xml version="1.0" encoding="gbk"?>


<%@ page import="java.util.List" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.hrm.User" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>


<%@page import="java.net.URLDecoder"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%><jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsc" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rcs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="customerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="projectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="requestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/>
<jsp:useBean id="docComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="rolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="subCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="meetingComInfo" class="weaver.meeting.Maint.MeetingComInfo" scope="page"/>

<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>

<jsp:useBean id="exchange" class="weaver.WorkPlan.WorkPlanExchange" scope="page"/>
<jsp:useBean id="ProjectTaskApprovalDetail" class="weaver.proj.Maint.ProjectTaskApprovalDetail" scope="page"/>

<jsp:useBean id="hrmUserVarify" class="weaver.hrm.HrmUserVarify" scope="page"/>
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>
<jsp:useBean id="workPlanHandler" class="weaver.WorkPlan.WorkPlanHandler" scope="page"/>
<jsp:useBean id="workPlanShare" class="weaver.WorkPlan.WorkPlanShare" scope="page"/>
<jsp:useBean id="workPlanViewer" class="weaver.WorkPlan.WorkPlanViewer" scope="page"/>
<jsp:useBean id="workPlanExchange" class="weaver.WorkPlan.WorkPlanExchange" scope="page"/>
<jsp:useBean id="workPlanLogMan" class="weaver.WorkPlan.WorkPlanLogMan" scope="page"/>


<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="sysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page"/>

<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
	request.setCharacterEncoding("UTF-8");
	User user = hrmUserVarify.getUser(request, response);	
	if(user == null)  return ;
	String userId = String.valueOf(user.getUID());  //��ǰ�û�Id
	String userType = user.getLogintype();

	String method = request.getParameter("method");
	 
	String color = "";
    WorkPlan workPlan = new WorkPlan();

    workPlan.setCreaterId(Integer.parseInt(userId));
    workPlan.setCreateType(Integer.parseInt(userType));
    
    char sep = Util.getSeparator();
    
    //�ж��Ƿ�Ϊϵͳ����Աsysadmin 
    int isSysadmin=0;
    RecordSet rssysadminmenu=new RecordSet();
    rssysadminmenu.executeSql("select count(*) from hrmresourcemanager where id="+userId);	
    if(rssysadminmenu.next()){
	     isSysadmin=rssysadminmenu.getInt(1);
    }    
    
	if("addCalendarItem".equals(method))
	{	    	    
	    String workPlanType = request.getParameter("workPlanType");  //�ճ�����p
	    String workPlanName=Util.null2String(URLDecoder.decode(request.getParameter("planName"),"UTF-8"));  //����p
	    String urgentLevel=Util.null2String(request.getParameter("urgentLevel"));//�����̶�p
	    urgentLevel="".equals(urgentLevel)?"1":urgentLevel;
	    String remindType = Util.null2String(request.getParameter("remindType"));  //��������
	    String remindBeforeStart = Util.null2String(request.getParameter("remindBeforeStart"));  //�Ƿ�ʼǰ����p
	    if(!"".equals(workPlanType) && null != workPlanType)
	    {
	        workPlan.setWorkPlanType(Integer.parseInt(workPlanType));  //�ճ�����	
	    }else{
	    	workPlanType="0";
	    	 workPlan.setWorkPlanType(0);
	    }
	    workPlan.setWorkPlanName(workPlanName);
	    workPlan.setUrgentLevel(urgentLevel);  
	    workPlan.setRemindType(remindType);
	    //workPlan.setRemindType(remindBeforeStart);
	    if(!"".equals(remindBeforeStart) && null != remindBeforeStart)
	    {
	        workPlan.setRemindBeforeStart(remindBeforeStart);  //�Ƿ�ʼǰ����
	    }
	    else
	    {
	        workPlan.setRemindBeforeStart("0");
	    }
	   
	    String remindBeforeEnd = Util.null2String(request.getParameter("remindBeforeEnd"));  //�Ƿ����ǰ����p
	    if(!"".equals(remindBeforeEnd) && null != remindBeforeEnd)
	    {
	        workPlan.setRemindBeforeEnd(remindBeforeEnd);  //�Ƿ����ǰ����



	    }
	    else
	    {
	        workPlan.setRemindBeforeEnd("0");
	    }
	    
	    if(!"".equals(remindBeforeStart) && null != remindBeforeStart)
	    {
	    	workPlan.setRemindTimesBeforeStart(Util.getIntValue(request.getParameter("remindDateBeforeStart"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimesBeforeStart")),0));  //��ʼǰ����ʱ��p
	    }
	    else
	    {
	        workPlan.setRemindTimesBeforeStart(0);
	    }
	    
	     if(!"".equals(remindBeforeEnd) && null != remindBeforeEnd)
	    {
	    	workPlan.setRemindTimesBeforeEnd(Util.getIntValue(request.getParameter("remindDateBeforeEnd"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimesBeforeEnd")),0));  //����ǰ����ʱ��p
	    }
	    else
	    {
	        workPlan.setRemindTimesBeforeEnd(0);
	    }
	    
	    workPlan.setResourceId(Util.null2String(request.getParameter("memberIDs")).equals("")?""+user.getUID():Util.null2String(request.getParameter("memberIDs")));  //ϵͳ������p
	    
	    String beginDate = Util.null2String(request.getParameter("beginDate"));  //��ʼ����p
	    workPlan.setBeginDate(beginDate);  //��ʼ����
	    String beginTime = request.getParameter("beginTime");  //��ʼʱ��p
	    if("00".equals(beginTime) || "".equals(beginTime) || null == beginTime){
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
	    }else{
	    	workPlan.setBeginTime(beginTime);  //��ʼʱ��
	    }
	    
	    String endDate = Util.null2String(request.getParameter("endDate"));  //��������p
	    workPlan.setEndDate(endDate);  //��������
	    String endTime = request.getParameter("endTime");  //����ʱ��p
	    if(!"".equals(workPlan.getEndDate()) && null != workPlan.getEndDate() && ("".equals(endTime) || null == endTime || "00".equals(endTime)))
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
	    workPlan.setDescription(URLDecoder.decode(Util.null2String(request.getParameter("description")),"UTF-8"));  //����p
	    workPlan.setCustomer(Util.null2String(request.getParameter("crmIDs")));  //��ؿͻ�p
	    workPlan.setDocument(Util.null2String(request.getParameter("docIDs")));  //����ĵ�p
	    workPlan.setProject(Util.null2String(request.getParameter("projectIDs")));  //�����Ŀp
	    workPlan.setTask(Util.null2String(request.getParameter("taskIDs")));  //�����Ŀ����
	    workPlan.setWorkflow(Util.null2String(request.getParameter("requestIDs")));  //�������p    
	    
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

		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT * FROM WorkPlanType WHERE workPlanTypeId = ");
		stringBuffer.append(workPlanType);

	    recordSet.executeSql(stringBuffer.toString());
	    if(recordSet.next())
	    {
	        color = recordSet.getString("workPlanTypeColor");
	    }
	    
	    workPlanService.insertWorkPlan(workPlan);
	    workPlanShare.setDefaultShareDetail(user,String.valueOf(workPlan.getWorkPlanID()),workPlanType);
	    
    	//������־
    	String logParams[] = new String[]
		{ String.valueOf(workPlan.getWorkPlanID()), workPlanLogMan.TP_CREATE, userId, request.getRemoteAddr() };
		workPlanLogMan.writeViewLog(logParams);
    	
       	out.clearBuffer();
       	/*
	    out.println("<item>");
    	out.print("<id>");
    	out.print(workPlan.getWorkPlanID());
    	out.println("</id>");
    	out.print("<color>");
    	out.print(color);
    	out.println("</color>");
    	out.print("<starttime>");
    	out.print(workPlan.getBeginTime());
    	out.println("</starttime>");
    	out.print("<endtime>");
    	out.print(workPlan.getEndTime());
    	out.println("</endtime>");    	
    	out.println("</item>");
    	*/
    	SimpleDateFormat format1=new SimpleDateFormat("MM/dd/yyyy HH:mm");
    	SimpleDateFormat format2=new SimpleDateFormat("yyyy-MM-dd HH:mm");
    	Date startDateTime=new Date();
    	Date endDateTime=new Date();
    	Map result=new HashMap();
   		List data=new ArrayList();
   		boolean isAllDay=false;
    	result.put("IsSuccess","true");
    	
    	data.add(""+workPlan.getWorkPlanID());
    	data.add(workPlan.getWorkPlanName());
    	if(!"".equals(workPlan.getBeginDate())){
    		startDateTime=format2.parse(workPlan.getBeginDate()+" "+workPlan.getBeginTime());
    		data.add(workPlan.getBeginDate()+" "+workPlan.getBeginTime());
    	}else{
    		data.add("");
    	}
    	if(!"".equals(workPlan.getEndDate())){
    		endDateTime=format2.parse(workPlan.getEndDate()+" "+workPlan.getEndTime());
    		data.add(workPlan.getEndDate()+" "+workPlan.getEndTime());
    		if(endDateTime.getDate()-startDateTime.getDate()>=1){
    			isAllDay=true;
    		}
    	}else{
    		data.add("");
    	}
    	data.add("0");
    	if(isAllDay){
    		data.add("1");//�ǲ���ȫ��
    	}else{
    		data.add("0");
    	}
    	data.add("0");//,0,1,0,-1,1,
    	data.add(color);//��ɫ
    	data.add("1");//editable
    	data.add("1");
    	data.add("1");
    	result.put("Data",data);
    	//["92","�����ȫ��","12/29/2011 01:30","12/29/2011 05:00","0","0","0","1","1","Belion",""]
    	JSONObject jsonObj=JSONObject.fromObject(result);
    	out.print(jsonObj.toString());
    	out.flush();
	}
	else if("editCalendarItemQuick".equals(method))
	{
		String id =(String) request.getAttribute("id");
		
		String startDate = (String)request.getAttribute("startDate");
		String startTime = (String)request.getAttribute("startTime");
		String endDate =(String) request.getAttribute("endDate");
		String endTime = (String)request.getAttribute("endTime");
		
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT 1 FROM workPlanShareDetail WHERE workId = ");
		stringBuffer.append(id);
		stringBuffer.append(" AND userId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND userType = 1");
		stringBuffer.append(" AND shareLevel > 1");
			
		recordSet.executeSql(stringBuffer.toString());
		if(recordSet.next()){//�ж��Ƿ���ύ�������б༭Ȩ��
		    recordSet1.executeSql("SELECT * FROM WorkPlan WHERE id = " + id);
		    if(recordSet1.next()) {
		        String remindBeforeStart = recordSet1.getString("remindBeforeStart");
		        String remindBeforeEnd = recordSet1.getString("remindBeforeEnd");
		        int remindTimesBeforeStart = recordSet1.getInt("remindTimesBeforeStart");
		        int remindTimesBeforeEnd = recordSet1.getInt("remindTimesBeforeEnd");
		        
		        String remindDateBeforeStart = "";
		        String remindTimeBeforeStart = "";
		        String remindDateBeforeEnd = "";
		        String remindTimeBeforeEnd = "";

		        if(null != startDate && !"".equals(startDate) && "1".equals(remindBeforeStart))
		        {
			        List beginDateTimeRemindList = Util.processTimeBySecond(startDate, startTime, remindTimesBeforeStart * -1 * 60);
			    	remindDateBeforeStart = (String)beginDateTimeRemindList.get(0);  //��ʼǰ��������
			    	remindTimeBeforeStart = (String)beginDateTimeRemindList.get(1);  //��ʼǰ����ʱ��
		        }
		        
		        if(null != endDate && !"".equals(endDate) && "1".equals(remindBeforeEnd))
		        {
			    	List endDateTimeRemindList = Util.processTimeBySecond(endDate, endTime, remindTimesBeforeEnd * -1 * 60);
			    	remindDateBeforeEnd = (String)endDateTimeRemindList.get(0);  //����ǰ��������



			    	remindTimeBeforeEnd = (String)endDateTimeRemindList.get(1);  //����ǰ����ʱ��



		        }
		        if(!"".equals(endDate) && null != endDate && ("".equals(endTime) || null == endTime || "00".equals(endTime))){
		        	String validedatefrom = endDate.substring(0,4)+"-01-01";
		        	String validedateto = endDate.substring(0,4)+"-12-31";
		        	String endSql="select * from HrmSchedule  where validedatefrom <= '"+validedatefrom+"' and validedateto >= '"+validedateto+"' ";		    
		        	String endweek = getWeekByDate(endDate)+"endtime2";
				    if(isSysadmin>0){//��Ϊϵͳ����Ա��ֱ��ȡ�ܲ�ʱ��
				    	endSql+=" and scheduletype = '3' ";
				    }else{
				    	endSql+=" and relatedid = (select m.subcompanyid1 from hrmresource m where m.id='"+userId+"')";
				    }
				    rcs.execute(endSql);
			    	if(rcs.next()){		    
		                endTime = rcs.getString(endweek);
		                endTime = endTime.equals("")?"00:00":endTime;  //����ʱ��
		    	    }else{  //���޿���ʱ���¼ȡ 00:00
		    		    endTime = "00:00";  //����ʱ��
		    	    }		        	
		        }		        		        
		        stringBuffer = new StringBuffer();
				stringBuffer.append("UPDATE WorkPlan SET beginDate = '");
				stringBuffer.append(startDate);
				stringBuffer.append("', beginTime = '");
				stringBuffer.append(startTime);
				stringBuffer.append("', endDate = '");
				stringBuffer.append(endDate);
				stringBuffer.append("', endTime = '");
				stringBuffer.append(endTime);
				stringBuffer.append("'");
				
				if(null != startDate && !"".equals(startDate) && "1".equals(remindBeforeStart))
		        {
					stringBuffer.append(", remindDateBeforeStart = '");
					stringBuffer.append(remindDateBeforeStart);
					stringBuffer.append("', remindTimeBeforeStart = '");
					stringBuffer.append(remindTimeBeforeStart);
					stringBuffer.append("'");
		        }
				
				if(null != endDate && !"".equals(endDate) && "1".equals(remindBeforeEnd))
				{
					stringBuffer.append(", remindDateBeforeEnd = '");
					stringBuffer.append(remindDateBeforeEnd);
					stringBuffer.append("', remindTimeBeforeEnd = '");
					stringBuffer.append(remindTimeBeforeEnd);
					stringBuffer.append("'");
				}
				
				stringBuffer.append(" WHERE id = ");
				stringBuffer.append(id);
						        
		        recordSet2.executeSql(stringBuffer.toString());
		        
				workPlanExchange.exchangeAdd(Integer.parseInt(id), userId, userType);  //��ʶ�ճ��ѱ��༭
				out.clearBuffer();
		    	out.print("{\"IsSuccess\":true}");
		    }else{
				out.clearBuffer();
		    	out.print("{\"IsSuccess\":false}");
			}
		}else{
			out.clearBuffer();
	    	out.print("{\"IsSuccess\":false}");
		}
		
	}
	else if("editCalendarItem".equals(method))
	{
	    String id = request.getParameter("id");
	    
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT 1 FROM workPlanShareDetail WHERE workId = ");
		stringBuffer.append(id);
		stringBuffer.append(" AND userId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND userType = 1");
		stringBuffer.append(" AND shareLevel > 1");
			
		recordSet.executeSql(stringBuffer.toString());
		if(recordSet.next())
		//�ж��Ƿ���ύ�������б༭Ȩ��



		{
		    String workPlanType = request.getParameter("workPlanType");  //�ճ�����p
		    if(!"".equals(workPlanType) && null != workPlanType)
		    {
		        workPlan.setWorkPlanType(Integer.parseInt(workPlanType));  //�ճ�����	
		    }
		    	    
		    workPlan.setWorkPlanName(Util.null2String(URLDecoder.decode(request.getParameter("planName"),"UTF-8")));  //����p
		    
		    workPlan.setUrgentLevel(Util.null2String(request.getParameter("urgentLevel")));  //�����̶�p
		    
		    workPlan.setRemindType(Util.null2String(request.getParameter("remindType")));  //�ճ����ѷ�ʽp
		    
		    String remindBeforeStart = Util.null2String(request.getParameter("remindBeforeStart"));  //�Ƿ�ʼǰ����p
		    if(!"".equals(remindBeforeStart) && null != remindBeforeStart)
		    {
		        workPlan.setRemindBeforeStart(remindBeforeStart);  //�Ƿ�ʼǰ����
		    }
		    else
		    {
		        workPlan.setRemindBeforeStart("0");
		    }
		    
		    String remindBeforeEnd = Util.null2String(request.getParameter("remindBeforeEnd"));  //�Ƿ����ǰ����p
		    if(!"".equals(remindBeforeEnd) && null != remindBeforeEnd)
		    {
		        workPlan.setRemindBeforeEnd(remindBeforeEnd);  //�Ƿ����ǰ����

		    }
		    else
		    {
		        workPlan.setRemindBeforeEnd("0");
		    }
		    
		    if(!"".equals(remindBeforeStart) && null != remindBeforeStart)
		    {
		    	workPlan.setRemindTimesBeforeStart(Util.getIntValue(request.getParameter("remindDateBeforeStart"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimesBeforeStart")),0));  //��ʼǰ����ʱ��p
		    }
		    else
		    {
		        workPlan.setRemindTimesBeforeStart(0);
		    }
		    
		     if(!"".equals(remindBeforeEnd) && null != remindBeforeEnd)
		    {
		    	workPlan.setRemindTimesBeforeEnd(Util.getIntValue(request.getParameter("remindDateBeforeEnd"),0)*60+Util.getIntValue(Util.null2String(request.getParameter("remindTimesBeforeEnd")),0));  //����ǰ����ʱ��p
		    }
		    else
		    {
		        workPlan.setRemindTimesBeforeEnd(0);
		    }
		    
		    workPlan.setResourceId(Util.null2String(request.getParameter("memberIDs")));  //ϵͳ������p
		    
		    String beginDate = Util.null2String(request.getParameter("beginDate"));  //��ʼ����p
		    workPlan.setBeginDate(beginDate);  //��ʼ����

		    String beginTime = request.getParameter("beginTime");  //��ʼʱ��p
		    if("00".equals(beginTime) || "".equals(beginTime) || null == beginTime){
		    	//���ǵ��½��ճ̵���ʼʱ��ͽ���ʱ�䲻ͬ
			    String validedatefrom = beginDate.substring(0,4)+"-01-01";
			    String validedateto = beginDate.substring(0,4)+"-12-31";
			    String startSql="select * from HrmSchedule  where validedatefrom = '"+validedatefrom+"' and validedateto= '"+validedateto+"' ";
			    if(isSysadmin>0){//��Ϊϵͳ����Ա��ֱ��ȡ�ܲ�ʱ��
			    	startSql+=" and scheduletype = '3' ";
			    }else{
			    	startSql+=" and relatedid = (select m.subcompanyid1 from hrmresource m where m.id='"+userId+"')";
			    }
			    String startweek = getWeekByDate(beginDate)+"starttime1";
		    	rs.execute(startSql);
		    	if(rs.next()){
		              beginTime = rs.getString(startweek);		
		              workPlan.setBeginTime(beginTime.equals("")?"00:00":beginTime);  //��ʼʱ��
		    	}else{  //���޿���ʱ�� ��ȡ 00:00
		    		  workPlan.setBeginTime("00:00");
		    	}		        	    	
		    }else{
		    	workPlan.setBeginTime(beginTime);  //��ʼʱ��
		    }
		    String endDate = Util.null2String(request.getParameter("endDate"));  //��������p
		    workPlan.setEndDate(endDate);  //��������
		    
		    String endTime = request.getParameter("endTime");  //����ʱ��p
		    if(!"".equals(workPlan.getEndDate()) && null != workPlan.getEndDate() && ("".equals(endTime) || null == endTime || "00".equals(endTime)))
		    {		    	
			    String validedatefrom = endDate.substring(0,4)+"-01-01";
			    String validedateto = endDate.substring(0,4)+"-12-31";
			    String endSql="select * from HrmSchedule  where validedatefrom = '"+validedatefrom+"' and validedateto= '"+validedateto+"' ";		    
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
		    	}else{  //���޿���ʱ�� ��ȡ 00:00
		    		    workPlan.setEndTime("00:00");  //����ʱ��
		    	}		    	
		    }
		    else
		    {
		        workPlan.setEndTime(endTime);  //����ʱ��
		    }
		    workPlan.setDescription(Util.null2String(URLDecoder.decode(request.getParameter("description"),"UTF-8")));  //����p		    
		    workPlan.setCustomer(Util.null2String(request.getParameter("crmIDs")));  //��ؿͻ�p
		    workPlan.setDocument(Util.null2String(request.getParameter("docIDs")));  //����ĵ�p
		    workPlan.setProject(Util.null2String(request.getParameter("projectIDs")));  //�����Ŀp
		    workPlan.setTask(Util.null2String(request.getParameter("taskIDs")));  //�����Ŀ����
		    workPlan.setWorkflow(Util.null2String(request.getParameter("requestIDs")));  //�������p    
		    workPlan.setMeeting(Util.null2String(request.getParameter("meetingIDs")));  //��ػ���
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
			
		    
			//����
		    WorkPlan oldWorkPlan = new WorkPlan();
	        oldWorkPlan.setWorkPlanID(Integer.parseInt(id));
	        
	        workPlan.setWorkPlanID(oldWorkPlan.getWorkPlanID());	        
	        
	        String ip = request.getRemoteAddr();
	        
	        List workPlanList = workPlanService.getWorkPlanList(oldWorkPlan);
	        
	        for(int i = 0; i < workPlanList.size(); i++)
	        {
	            oldWorkPlan = (WorkPlan)workPlanList.get(i);
	            
		        workPlan.setTask(oldWorkPlan.getTask());
	            workPlanService.updateWorkPlan(oldWorkPlan, workPlan);
	            
	            workPlanLogMan.insertEditLog(oldWorkPlan, workPlan, userId, ip);	            
	        }
			
	        workPlanExchange.exchangeAdd(Integer.parseInt(id), userId, userType);  //��ʶ�ճ��ѱ��༭
	        out.clearBuffer();
	        out.print("{\"IsSuccess\":true}");
		   // response.sendRedirect("WorkPlanViewOperation.jsp?method=getCalendarItem&id=" + id);
		}else{
			out.clearBuffer();
	        out.print("{\"IsSuccess\":false}");
		}
	}


	else if("overCalendarItem".equals(method))
	{
		
		String planID = Util.null2String(request.getParameter("id"));
		boolean isPass=false;
	    String[] creater = workPlanHandler.getCreater(planID);
	    String createrID = "";
	    if (creater != null) createrID = creater[0];
	    
	    if(createrID.equals(userId)){ //�ύ�����
		    String planStatus =workPlanHandler.getWorkPlanStatus(planID);
		
		    if (planStatus.equals("0"))
		    {
		    	isPass=workPlanHandler.finishWorkPlan(planID);
		    }
		
		    if (planStatus.equals("1"))
		    {
		    	isPass=workPlanHandler.closeWorkPlan(planID);
		    }
	    }else{ //���ύ�����
	    	String planName = workPlanHandler.getWorkPlanName(planID);
	    	
		    String accepter = createrID;
		    String wfTitle = "";
		    String wfRemark = "";
		    Calendar current = Calendar.getInstance();
		    String currentDate = Util.add0(current.get(Calendar.YEAR), 4) + "-" + Util.add0(current.get(Calendar.MONTH) + 1, 2) + "-" + Util.add0(current.get(Calendar.DAY_OF_MONTH), 2);
		
		    wfTitle = Util.toScreen("����������ƻ�:", user.getLanguage(), "0");
		    wfTitle += planName;
		    wfTitle += "-" + resourceComInfo.getResourcename(userId);
		    wfTitle += "-" + currentDate;
		    wfRemark = Util.toScreen("�����ƻ�:", user.getLanguage(), "1") + "<A href=/workplan/data/WorkPlan.jsp?workid=" + planID + ">" + Util.fromScreen2(planName, user.getLanguage()) + "</A>";
		    sysRemindWorkflow.setCRMSysRemind(wfTitle, 0, Util.getIntValue(userId), accepter, wfRemark);
		
		    isPass=workPlanHandler.memberFinishWorkPlan(planID);
	    }
		
		Map result=new HashMap();
		result.put("IsSuccess",""+isPass);
		out.clearBuffer();
		out.print(JSONObject.fromObject(result).toString());
	}

	else if("getCalendarItem".equals(method))
	{  
		String id = request.getParameter("id");

		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT workPlan.*, workPlanType.workPlanTypeName, workPlanType.workPlanTypeColor, workPlanShareDetail.shareLevel");
		stringBuffer.append(" FROM WorkPlan workPlan, WorkPlanType workPlanType, WorkPlanShareDetail workPlanShareDetail");
		stringBuffer.append(" WHERE workPlan.type_n = workPlanType.workPlanTypeId");
		stringBuffer.append(" AND workPlan.id = workPlanShareDetail.workId");
		stringBuffer.append(" AND workPlan.id = ");
		stringBuffer.append(id);
		stringBuffer.append(" AND workPlanShareDetail.userId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND userType = ");
		stringBuffer.append(userType);
		stringBuffer.append(" order by sharelevel desc ");		
		recordSet.executeSql(stringBuffer.toString());
		PoppupRemindInfoUtil.updatePoppupRemindInfo(Util.getIntValue(userId),12,"0",Util.getIntValue(id));
		PoppupRemindInfoUtil.updatePoppupRemindInfo(Util.getIntValue(userId),13,"0",Util.getIntValue(id));
		if(recordSet.next())
		{
			Map result=new HashMap();
		    //��Ϊ�ѿ�
		    int[] viewParams = new int[] {Integer.parseInt(id), Integer.parseInt(userId)};			
		    workPlanExchange.exchangeView(viewParams);
		    
		    //������Ϣ		    
		    String urgentLevel = recordSet.getString("urgentLevel");
		    String remindType = recordSet.getString("remindType");
		    String remindBeforeStart = recordSet.getString("remindBeforeStart");
		    String remindBeforeEnd = recordSet.getString("remindBeforeEnd");
		    String remindTimesBeforeStart = recordSet.getString("remindTimesBeforeStart");
		    String remindTimesBeforeEnd = recordSet.getString("remindTimesBeforeEnd");

			int temmhourb=Util.getIntValue(remindTimesBeforeStart,0)/60;
		    int temptimeb=Util.getIntValue(remindTimesBeforeStart,0)%60;
			int temmhoure=Util.getIntValue(remindTimesBeforeEnd,0)/60;
		    int temptimee=Util.getIntValue(remindTimesBeforeEnd,0)%60;

		    String executeId = recordSet.getString("resourceId");
		    String crmId = recordSet.getString("crmId");
		    String docId = recordSet.getString("docId");
		    String projectId = recordSet.getString("projectId");
		    String workFlowId = recordSet.getString("requestId");
		    String taskId = recordSet.getString("taskId");
		    String meetingId = recordSet.getString("meetingId");
			if (userId.equals(recordSet.getString("createrId"))) 
			{
				result.put("canShare","true");
			}
			else
			{
				result.put("canShare","false");
			}
	    	result.put("type",""+recordSet.getInt("type_n"));
	    	result.put("id",""+recordSet.getInt("id"));
	    	result.put("planName",(Util.null2String((recordSet.getString("name")))));
	    	result.put("itemName",Util.null2String((recordSet.getString("name"))).replaceAll("&lt;","<").replaceAll("&gt;",">"));
	    	result.put("color",recordSet.getString("workPlanTypeColor"));
	    	result.put("urgent",urgentLevel);
	    	result.put("remindType",remindType);
	    	result.put("remindBeforeStart",""+remindBeforeStart);
	    	result.put("remindBeforeStartMinute",""+temptimeb);
	    	result.put("remindBeforeStartHour",""+temmhourb);
	    	result.put("remindBeforeEnd",remindBeforeEnd);
	    	result.put("remindBeforeEndMinute",""+temptimee);
	    	result.put("remindBeforeEndHour",""+temmhoure);
	    	result.put("executeId",executeId);
	    	result.put("startDate",recordSet.getString("beginDate"));
	    	result.put("startTime",recordSet.getString("beginTime"));
	    	result.put("endDate",recordSet.getString("endDate"));
	    	result.put("endTime",recordSet.getString("endTime"));
	    	result.put("desc",Util.convertInput2DB2(Util.null2String(recordSet.getString("description"))));
	    	result.put("description",Util.convertDB2Input(Util.StringReplace(Util.null2String(recordSet.getString("description")),"&nbsp;"," ")));
	    	result.put("relatedCustomer",crmId);    	
	    	result.put("relatedDocument",docId);   
	    	result.put("relatedProject",projectId);
	    	result.put("relatedWorkFlow",workFlowId);
	    	result.put("relatedTask",taskId);
	    	result.put("relatedMeeting",meetingId);
	    	result.put("status",recordSet.getString("status"));	    	
	    	result.put("shareLevel",""+recordSet.getInt("shareLevel"));
	    	result.put("exchangeCount","0");
	    	result.put("workPlanTypeName",Util.toHtml(Util.null2String(recordSet.getString("workPlanTypeName"))));
	    	
	    	if ("1".equals(urgentLevel)) 
      		{
	    		result.put("urgentLevelName",SystemEnv.getHtmlLabelName(154,user.getLanguage()));
      		}
      		else if (urgentLevel.equals("2")) 
      		{
      			result.put("urgentLevelName",SystemEnv.getHtmlLabelName(15533,user.getLanguage()));
	  		}
      		else 
      		{
      			result.put("urgentLevelName",SystemEnv.getHtmlLabelName(2087,user.getLanguage()));
	  		}
	    	
	    	if("1".equals(remindType))
			{
	    		result.put("remindTypeName",SystemEnv.getHtmlLabelName(19782,user.getLanguage()));
			}
			else if("2".equals(remindType))
			{
				result.put("remindTypeName",SystemEnv.getHtmlLabelName(17586,user.getLanguage()));
			}
			else if("3".equals(remindType))
			{
				result.put("remindTypeName",SystemEnv.getHtmlLabelName(18845,user.getLanguage()));
			}
	    	String remindTimeDescription="";
 			if("1".equals(remindBeforeStart))
 			{	
 				remindTimeDescription+=(SystemEnv.getHtmlLabelName(19784,user.getLanguage()) + String.valueOf(temmhourb) + SystemEnv.getHtmlLabelName(391,user.getLanguage())+String.valueOf(temptimeb) + SystemEnv.getHtmlLabelName(15049,user.getLanguage()));
 			}
     		if("1".equals(remindBeforeEnd))
 			{
     			
				remindTimeDescription+=" "+(SystemEnv.getHtmlLabelName(19785,user.getLanguage()) + String.valueOf(temmhoure) + SystemEnv.getHtmlLabelName(391,user.getLanguage())+String.valueOf(temptimee) + SystemEnv.getHtmlLabelName(15049,user.getLanguage()));
 			}
     		result.put("remindTimeDescription",remindTimeDescription);
	    	String executeName="";
	    	if (null != executeId && !"".equals(executeId)) 
			{
				List executeList = Util.TokenizerString(executeId,",");
				for (int i = 0; i < executeList.size(); i++) 
				{
					executeName+="<a href='/hrm/resource/HrmResource.jsp?id="+((String)executeList.get(i))+"'  target='_blank'>"+resourceComInfo.getResourcename((String)executeList.get(i))+"</a>";
					executeName+=" ";
				}
			}
	    	result.put("executeName",executeName);
	    	String crmIdName="";
	    	if (null != crmId && !"".equals(crmId))
			{
				List crmIdList = Util.TokenizerString(crmId, ",");
				for (int i = 0; i < crmIdList.size(); i++) 
				{
					crmIdName += "<a href='/CRM/data/ViewCustomer.jsp?CustomerID="+((String)crmIdList.get(i))+"' target='_blank'>"+customerInfoComInfo.getCustomerInfoname((String)crmIdList.get(i))+"</a>";
					crmIdName += " ";
				}
			}
	    	result.put("crmIdName",crmIdName);
	    	String docIdName="";
	    	if (null != docId && !"".equals(docId))
			{
				List docIdList = Util.TokenizerString(docId, ",");
				for (int i = 0; i < docIdList.size(); i++) 
				{
					docIdName += "<a href='/docs/docs/DocDsp.jsp?id="+((String)docIdList.get(i))+"' target='_blank'>"+(docComInfo.getDocname((String)docIdList.get(i)))+"</a>";
					
					docIdName += (" ");
				}
			}
	    	result.put("docIdName",docIdName);
	    	String projectIdName="";
	    	if (null != projectId && !"".equals(projectId))
			{
				List projectIdList = Util.TokenizerString(projectId, ",");
				for (int i = 0; i < projectIdList.size(); i++) 
				{
					projectIdName += "<a href='/proj/data/ViewProject.jsp?ProjID="+((String)projectIdList.get(i))+"' target='_blank'>"+(projectInfoComInfo.getProjectInfoname((String)projectIdList.get(i)))+"</a>";
					projectIdName +=(" ");
				}
			}
	    	result.put("projectIdName",projectIdName);
	    	String taskIdName="";
	    	if (null != taskId && !"".equals(taskId) && !"0".equals(taskId))
			{
				List taskIdList = Util.TokenizerString(taskId, ",");
				for (int i = 0; i < taskIdList.size(); i++) 
				{
					taskIdName +=(ProjectTaskApprovalDetail.getTaskSuject((String)taskIdList.get(i)) + "(" + SystemEnv.getHtmlLabelName(101,user.getLanguage()) + ":" + ProjectTaskApprovalDetail.getProjectNameByTaskId((String)taskIdList.get(i)) + ")");
					taskIdName +=(" ");
				}
			}
	    	result.put("taskIdName",taskIdName);
	    	String requestIdName="";
	    	if (null != workFlowId && !"".equals(workFlowId))
			{
				List workFlowIdList = Util.TokenizerString(workFlowId, ",");
				for (int i = 0; i < workFlowIdList.size(); i++) 
				{
					requestIdName += 
					"<a href='/workflow/request/ViewRequest.jsp?requestid="+((String)workFlowIdList.get(i))+"' target='_blank'>"
							+(requestComInfo.getRequestname((String)workFlowIdList.get(i)))+"</a>";
					requestIdName += (" ");
				}
			}
	    	
	    	result.put("requestIdName",requestIdName);
	    	List mettings=new ArrayList();
	    	
	    	if (null != meetingId && !"".equals(meetingId))
			{	
				List meetingIdList = Util.TokenizerString(meetingId, ",");
				for (int i = 0; i < meetingIdList.size(); i++) 
				{
					Map meeting =new HashMap();
					meeting.put("meetingId",meetingId);
					meeting.put("meetingName",meetingComInfo.getMeetingInfoname((String)meetingIdList.get(i)));
					mettings.add(meeting);
				}
			}
	    	result.put("meetingIdName",mettings);
	    	out.clearBuffer();
	    	out.print(JSONObject.fromObject(result).toString());
		}else{
			out.clearBuffer();
			out.print("{}");
		}
	}
	else if("deleteCalendarItem".equals(method))
	{
		String id = request.getParameter("id");
				
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT 1 FROM workPlanShareDetail WHERE workId = ");
		stringBuffer.append(id);
		stringBuffer.append(" AND userId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND userType = 1");
		stringBuffer.append(" AND shareLevel > 1");
			
		recordSet.executeSql(stringBuffer.toString());
		PoppupRemindInfoUtil.deletePoppupRemindInfo(Util.getIntValue(id),12);
		PoppupRemindInfoUtil.deletePoppupRemindInfo(Util.getIntValue(id),13);
		if(recordSet.next())
		//�ж��Ƿ���ύ�������б༭Ȩ��
		{
		    workPlanHandler.delete(id);
			
			String logParams[] = new String[]
			{ id, workPlanLogMan.TP_DELETE, userId, request.getRemoteAddr() };
			workPlanLogMan.writeViewLog(logParams);
	
			workPlanExchange.workPlanDelete(Integer.parseInt(id));
			out.clearBuffer();
			out.print("{\"IsSuccess\":true}");
		}else{
			out.clearBuffer();
			out.print("{\"IsSuccess\":false}");
		}
	}
	else if("getCalendarShare".equals(method))
	//�õ�������Ϣ
	{	    
		Map item=new HashMap();
		List itemList=new ArrayList();
		Map result=new HashMap();
		result.put("data",itemList);
		String id = request.getParameter("id");
		
		boolean canEdit = false;
		String createrId = "";
		
		String[] creater = workPlanHandler.getCreater(id);		
		if (null != creater)
		{
		    createrId = creater[0];
		}		
		if (createrId.equals(userId))
		{
		    canEdit = true;
		}
		
						
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("SELECT * FROM WorkPlanShare WHERE workPlanId = ");
		stringBuffer.append(id);

		recordSet.executeSql(stringBuffer.toString());
		
		if (canEdit){	result.put("canShare","true");
		}
		else{
			result.put("canShare","false");
		}
		
		while(recordSet.next())
		{
		    int shareType = recordSet.getInt("shareType");
		    int shareLevel = recordSet.getInt("shareLevel");
			item=new HashMap();
			itemList.add(item);
			item.put("shareId",new Integer(recordSet.getInt("id")));
			String shareContent="";
			if (1 == shareType)
			//������Դ
		    {
		        String shareUserId = recordSet.getString("userId");
		        item.put("shareTypeName",SystemEnv.getHtmlLabelName(179,user.getLanguage()));
		        shareContent="";
		        List shareUserIdList = Util.TokenizerString(shareUserId, ",");
				for(int i = 0; i < shareUserIdList.size(); i++)
				{
					shareContent+=" ";
					shareContent+=(Util.toScreen(resourceComInfo.getResourcename((String)shareUserIdList.get(i)), user.getLanguage()));
				}
				shareContent+=(" / ");
				if (1 == shareLevel) 
				{
					shareContent+=(SystemEnv.getHtmlLabelName(367,user.getLanguage()));
				}
				else if (2 == shareLevel) 
				{

					shareContent+=(SystemEnv.getHtmlLabelName(93,user.getLanguage()));
				}
				item.put("shareContent",shareContent);
		    }
		    else if(2 == shareType)
			//����
		    {			    
			    String shareDepartmentId = recordSet.getString("deptId");
			    item.put("shareTypeName",SystemEnv.getHtmlLabelName(124, user.getLanguage()));
		        shareContent="";
				List shareDepartmentIdList = Util.TokenizerString(shareDepartmentId, ",");
				for(int i = 0; i < shareDepartmentIdList.size(); i++)
				{
					shareContent+=(" ");
					shareContent+=(Util.toScreen(departmentComInfo.getDepartmentname((String)shareDepartmentIdList.get(i)), user.getLanguage()));
				}
				shareContent+=(" / ");
				shareContent+=(SystemEnv.getHtmlLabelName(683,user.getLanguage()));
				shareContent+=(" : ");
				shareContent+=(Util.toScreen(recordSet.getString("securityLevel"), user.getLanguage()));
				shareContent+=(" / ");
				if (1 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(367,user.getLanguage()));
				}
				else if (2 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(93,user.getLanguage()));
				}			    
				item.put("shareContent",shareContent);     		        
		    }
		    else if(3 == shareType)
			//��ɫ
		    {			    
		        String shareRoleId = recordSet.getString("roleId");
		       
		        item.put("shareTypeName",SystemEnv.getHtmlLabelName(122, user.getLanguage()));
		        shareContent="";
		        shareContent+=(Util.toScreen(rolesComInfo.getRolesname(shareRoleId), user.getLanguage()));
		        shareContent+=(" / ");			    
			    if (0 == recordSet.getInt("roleLevel")) 
				{
			    	shareContent+=(SystemEnv.getHtmlLabelName(124,user.getLanguage()));
				} 
				else if (1 == recordSet.getInt("roleLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(141,user.getLanguage()));
				} 
				else if (2 == recordSet.getInt("roleLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(140,user.getLanguage()));
				}
			    shareContent+=(" / ");
			    shareContent+=(SystemEnv.getHtmlLabelName(683,user.getLanguage()));
			    shareContent+=(" : ");
			    shareContent+=(Util.toScreen(recordSet.getString("securityLevel"),user.getLanguage()));
			    shareContent+=(" / ");			    
			    
				if (1 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(367,user.getLanguage()));
				}
				else if (2 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(93,user.getLanguage()));
				}			    
				item.put("shareContent",shareContent);     	        		        
		    }
		    else if(4 == shareType){
				//������
		        item.put("shareTypeName",SystemEnv.getHtmlLabelName(235, user.getLanguage())+SystemEnv.getHtmlLabelName(127, user.getLanguage()));
		        shareContent="";
		        shareContent+=(SystemEnv.getHtmlLabelName(683,user.getLanguage()));
			    shareContent+=(" : ");
			    shareContent+=(Util.toScreen(recordSet.getString("securityLevel"),user.getLanguage()));
			    shareContent+=(" / ");
			    if (1 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(367,user.getLanguage()));
				}
				else if (2 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(93,user.getLanguage()));
				}
			    item.put("shareContent",shareContent);     	 
		    }
		    else if(5 == shareType)
			//�ֲ�
		    {
		        String shareSubCompanyId = recordSet.getString("subCompanyId");
		        item.put("shareTypeName",SystemEnv.getHtmlLabelName(141, user.getLanguage()));
		        shareContent="";
		        
			    shareContent+=("<shareContent>");
			    List shareSubCompanyIdList = Util.TokenizerString(shareSubCompanyId, ",");
				for(int i = 0; i < shareSubCompanyIdList.size(); i++)
				{
				    shareContent+=(" ");
				    shareContent+=(Util.toScreen(subCompanyComInfo.getSubCompanyname((String)shareSubCompanyIdList.get(i)),user.getLanguage()));
				}			
				shareContent+=(" / ");
				shareContent+=(SystemEnv.getHtmlLabelName(683,user.getLanguage()));
				shareContent+=(" : ");
				shareContent+=(Util.toScreen(recordSet.getString("securityLevel"),user.getLanguage()));
				shareContent+=(" / ");			    			    			    
			    if (1 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(367,user.getLanguage()));
				}
				else if (2 == recordSet.getInt("shareLevel"))
				{
					shareContent+=(SystemEnv.getHtmlLabelName(93,user.getLanguage()));
				}
				item.put("shareContent",shareContent);     	 
		    }
		}
		out.clearBuffer();
		out.print(JSONObject.fromObject(result).toString());
		
	}
	else if("addCalendarShare".equals(method))
	{				
		StringBuffer stringBuffer = new StringBuffer();
						
		String id = request.getParameter("id");
		
		stringBuffer.append("SELECT 1 FROM WorkPlan WHERE id = ");
		stringBuffer.append(id);
		stringBuffer.append(" AND createrId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND createrType = ");
		stringBuffer.append(userType);
		recordSet1.executeSql(stringBuffer.toString());
		if(recordSet1.next())
		{
		    stringBuffer = new StringBuffer();
		    
			String shareType = Util.null2String(request.getParameter("shareType"));
			String shareId = Util.null2String(request.getParameter("shareId"));
			String roleLevel = Util.null2String(request.getParameter("roleLevel"));
			String secLevel = Util.null2String(request.getParameter("secLevel"));
			String shareLevel = Util.null2String(request.getParameter("shareLevel"));
		
			String userShareId = "0";
			String departmentShareId = "0";
			String roleShareId = "0";
			String allShare = "0";
			String subCompanyShareId = "0";
		
			if ("1".equals(shareType))
			{
			    userShareId = shareId;
			}
			else if ("2".equals(shareType))
			{
			    departmentShareId = shareId;
			}
			else if ("3".equals(shareType))
			{
			    roleShareId = shareId;
			}
			else if ("5".equals(shareType))
			{
			    subCompanyShareId = shareId;
			}
			else
			{
			    allShare = "1";
			}
		
			stringBuffer.append(id);
			stringBuffer.append(sep);
			stringBuffer.append(shareType);
			stringBuffer.append(sep);
			stringBuffer.append(userShareId);
			stringBuffer.append(sep);
			stringBuffer.append(subCompanyShareId);
			stringBuffer.append(sep);
			stringBuffer.append(departmentShareId);
			stringBuffer.append(sep);
			stringBuffer.append(roleShareId);
			stringBuffer.append(sep);
			stringBuffer.append(allShare);
			stringBuffer.append(sep);
			stringBuffer.append(roleLevel);
			stringBuffer.append(sep);
			stringBuffer.append(secLevel);
			stringBuffer.append(sep);
			stringBuffer.append(shareLevel);
		
			recordSet.executeProc("WorkPlanShare_Ins", stringBuffer.toString());
	       workPlanShare.setShareDetail(id);
	       workPlanExchange.exchangeAdd(Integer.parseInt(id), userId, userType);  //��ʶ�ճ��ѱ��༭
	       
	       //ȡ����



	       stringBuffer = new StringBuffer();
	       stringBuffer.append("SELECT max(id) AS id FROM WorkPlanShare");
	       recordSet.executeSql(stringBuffer.toString());       
	       if(recordSet.next())
	       {     
	    	   out.clearBuffer();
	           out.print("{\"shareId\":\""+recordSet.getInt("id")+"\"}");
	       }
		}
	}
	else if("deleteCalendarShare".equals(method))
	{				
		StringBuffer stringBuffer = new StringBuffer();
						
		String workPlanShareId = request.getParameter("id");
		
		stringBuffer.append("SELECT WorkPlan.id AS workPlanId FROM WorkPlan, WorkPlanShare");
		stringBuffer.append(" WHERE WorkPlan.id = WorkPlanShare.workPlanId");
		stringBuffer.append(" AND WorkPlanShare.id = ");
		stringBuffer.append(workPlanShareId);
		stringBuffer.append(" AND WorkPlan.createrId = ");
		stringBuffer.append(userId);
		stringBuffer.append(" AND WorkPlan.createrType = ");
		stringBuffer.append(userType);

		recordSet1.executeSql(stringBuffer.toString());
		if(recordSet1.next())
		{
		    String workPlanId = recordSet1.getString("workPlanId");
		    stringBuffer = new StringBuffer();
			stringBuffer.append("DELETE FROM WorkPlanShare WHERE id = ");
			stringBuffer.append(workPlanShareId);
			
			recordSet.executeSql(stringBuffer.toString());
			
			workPlanShare.setShareDetail(workPlanId);
			
			workPlanExchange.exchangeAdd(Integer.parseInt(workPlanId), userId, userType);  //��ʶ�ճ��ѱ��༭
			out.clearBuffer();
			out.print("{\"IsSuccess\":true}");
		}else{
			out.clearBuffer();
			out.print("{\"IsSuccess\":false}");
		}
	}else if("getSubordinate".equals(method)){
		List userList=new ArrayList();
		String cuserId=Util.null2String(request.getParameter("userId"));
		rs.executeProc("HrmResource_SelectByManagerID", cuserId);
		
		while(rs.next()){
			Map cuser=new HashMap();
			cuser.put("id",rs.getString("id"));
			cuser.put("name",resourceComInfo.getResourcename(rs.getString("id")));
			userList.add(cuser);
		}
		out.clearBuffer();
		out.println(JSONArray.fromObject(userList).toString());
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