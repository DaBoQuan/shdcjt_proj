<%@ page language="java" contentType="application/x-json;charset=GBK" %>
<%@page import="java.util.Calendar"%><%@page import="net.sf.json.JSONObject"%><%@page import="weaver.hrm.User"%><%@page import="weaver.hrm.HrmUserVarify"%><%@ page import="org.apache.commons.logging.Log"%><%@ page import="org.apache.commons.logging.LogFactory"%><%@page import="weaver.general.Util"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="java.util.List"%><%@page import="java.util.ArrayList"%><%@page import="java.text.SimpleDateFormat"%><%@page import="java.util.Date"%>
<%@page import="net.sf.json.JsonConfig"%>
<%@page import="java.util.StringTokenizer"%><jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/><%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");

	User user = HrmUserVarify.getUser(request, response);
	//if(user == null)  return ;
	Log logger = LogFactory.getLog(this.getClass());

	//onmousemove="coordinateReport()"
	/*
	 * ҳ���������
	 * ���ݿ����ݶ�ȡ
	 */
	Calendar thisCalendar = Calendar.getInstance(); //��ǰ����
	Calendar selectCalendar = Calendar.getInstance(); //������ʾ������

	int countDays = 0; //��Ҫ��ʾ������
	int offsetDays = 0; //�����ʾ��ʾ��һ���ƫ������
	String thisDate = ""; //��ǰ����
	String selectDate = ""; //������ʾ����

	String beginDate = "";
	String endDate = "";

	String beginYear = "";
	String beginMonth = "";
	String beginDay = "";

	String endYear = "";
	String endMonth = "";
	String endDay = "";

	//��������
	String userId = String.valueOf(user.getUID()); //��ǰ�û�Id
	String userType = user.getLogintype(); //��ǰ�û�����
	String selectUser = Util.null2String(request
			.getParameter("selectUser")); //��ѡ���û�Id				
	String hasrightview = Util.null2String(request
			.getParameter("hasrightview")); //�Ƿ���Ȩ�޲鿴	
	String viewType = request.getParameter("viewtype"); //1:�ռƻ���ʾ 2:�ܼƻ���ʾ 3:�¼ƻ���ʾ
	String selectDateString = Util.null2String(request
			.getParameter("selectdate")); //��ѡ������
	String isShare = Util.null2String(request.getParameter("isShare")); //�Ƿ��ǹ���    1�������ճ�
	String selectUserNames = Util.null2String(request
			.getParameter("selectUserNames")); //�鿴����������

	boolean appendselectUser = false;

	viewType = "day".equals(viewType) ? "1"
			: ("week".equals(viewType) ? "2" : "3");

	if ("".equals(selectUser) || userId.equals(selectUser)) {
		appendselectUser = true;
		selectUser = userId;
	}
	selectUser = selectUser.replaceAll(",", "");
	if (!"1".equals(isShare) && !"".equals(selectUser)
			&& !userId.equals(selectUser)) {
		boolean hasright = false;
		String tempsql = "select a.managerstr "
				+ "	  from hrmresource a "
				+ "	  where (a.managerstr = '" + userId
				+ "' or a.managerstr like '" + userId + ",%' or "
				+ "	        a.managerstr like '%," + userId
				+ ",%' or a.managerstr like '%," + userId + "') "
				+ "	        and a.id=" + selectUser;
		recordSet.executeSql(tempsql);
		if (recordSet.next()) {
			String tmanagerstr = recordSet.getString(1);
			if (!"".equals(tmanagerstr)) {
				hasright = true;
			}
		}
		if (!hasright) {
			out.clearBuffer();

		}
	}
	String thisYear = Util.add0((thisCalendar.get(Calendar.YEAR)), 4); //��ǰ��
	String thisMonth = Util.add0(
			(thisCalendar.get(Calendar.MONTH)) + 1, 2); //��ǰ��
	String thisDayOfMonth = Util.add0((thisCalendar
			.get(Calendar.DAY_OF_MONTH)), 2); //��ǰ��
	thisDate = thisYear + "-" + thisMonth + "-" + thisDayOfMonth;

	if (!"".equals(selectDateString))
	//��ѡ������
	{
		int selectYear = Util.getIntValue(selectDateString.substring(0,
				4)); //��ѡ����
		int selectMonth = Util.getIntValue(selectDateString.substring(
				5, 7)) - 1; //��ѡ����
		int selectDay = Util.getIntValue(selectDateString.substring(8,
				10)); //��ѡ����
		selectCalendar.set(selectYear, selectMonth, selectDay);
	}

	String selectYear = Util.add0((selectCalendar.get(Calendar.YEAR)),
			4); //�� 
	String selectMonth = Util.add0(
			(selectCalendar.get(Calendar.MONTH)) + 1, 2); // ��
	String selectDayOfMonth = Util.add0((selectCalendar
			.get(Calendar.DAY_OF_MONTH)), 2); //��    
	String selectWeekOfYear = String.valueOf(selectCalendar
			.get(Calendar.WEEK_OF_YEAR)); //�ڼ���
	String selectDayOfWeek = String.valueOf(selectCalendar
			.get(Calendar.DAY_OF_WEEK)); //һ�ܵڼ���
	selectDate = selectYear + "-" + selectMonth + "-"
			+ selectDayOfMonth;

	switch (Integer.parseInt(viewType))
	//����Ϊ��ʾ�ĵ�һ��
	{
	case 1:
		//�ռƻ���ʾ
		offsetDays = 0;
		break;
	case 2:
		//�ܼƻ���ʾ
		offsetDays = Integer.parseInt(selectDayOfWeek) - 1;
		selectCalendar.add(Calendar.DAY_OF_WEEK, -1
				* Integer.parseInt(selectDayOfWeek) + 1);
		break;
	case 3:
		//�¼ƻ���ʾ
		selectCalendar.set(Calendar.DATE, 1); //����Ϊ�µ�һ��
		int offsetDayOfWeek = selectCalendar.get(Calendar.DAY_OF_WEEK) - 1;
		offsetDays = Integer.parseInt(selectDayOfMonth) - 1
				+ offsetDayOfWeek;
		selectCalendar.add(Calendar.DAY_OF_WEEK, -1 * offsetDayOfWeek); //����Ϊ���������ܵĵ�һ��
		break;
	}
	beginYear = Util.add0(selectCalendar.get(Calendar.YEAR), 4); //�� 
	beginMonth = Util.add0(selectCalendar.get(Calendar.MONTH) + 1, 2); // ��
	beginDay = Util.add0(selectCalendar.get(Calendar.DAY_OF_MONTH), 2); //�� 
	beginDate = beginYear + "-" + beginMonth + "-" + beginDay;
	System.out.println("viewType:" + viewType);
	switch (Integer.parseInt(viewType))
	//����Ϊ��ʾ�����һ��
	{
	case 1:
		//�ռƻ���ʾ
		countDays = 1;
		break;
	case 2:
		//�ܼƻ���ʾ
		selectCalendar.add(Calendar.WEEK_OF_YEAR, 1);
		selectCalendar.add(Calendar.DATE, -1);
		countDays = 7;
		break;
	case 3:
		//�¼ƻ���ʾ
		selectCalendar.add(Calendar.DATE, offsetDays);
		//System.out.println("######" + selectCalendar.get(Calendar.DATE));
		selectCalendar.set(Calendar.DATE, 1); //����Ϊ�µ�һ��
		selectCalendar.add(Calendar.MONTH, 1);
		selectCalendar.add(Calendar.DATE, -1);
		countDays = selectCalendar.get(Calendar.DAY_OF_MONTH); //��������
		int offsetDayOfWeekEnd = 7 - selectCalendar
				.get(Calendar.DAY_OF_WEEK);
		selectCalendar.add(Calendar.DAY_OF_WEEK, offsetDayOfWeekEnd); //����Ϊ��ĩ�����ܵ����һ��
		break;
	}
	endYear = Util.add0(selectCalendar.get(Calendar.YEAR), 4); //�� 
	endMonth = Util.add0(selectCalendar.get(Calendar.MONTH) + 1, 2); // ��
	endDay = Util.add0(selectCalendar.get(Calendar.DAY_OF_MONTH), 2); //��
	endDate = endYear + "-" + endMonth + "-" + endDay;

	String overColor = "";
	String archiveColor = "";
	String archiveAvailable = "0";
	String overAvailable = "0";
	String oversql = "select * from overworkplan order by workplanname desc";
	recordSet.executeSql(oversql);
	while (recordSet.next()) {
		String id = recordSet.getString("id");
		String workplanname = recordSet.getString("workplanname");
		String workplancolor = recordSet.getString("workplancolor");
		String wavailable = recordSet.getString("wavailable");
		if ("1".equals(id)) {
			overColor = workplancolor;
			if ("1".equals(wavailable))
				overAvailable = "1";
		} else {
			archiveColor = workplancolor;
			if ("1".equals(wavailable))
				archiveAvailable = "2";
		}
	}
	if ("".equals(overColor)) {
		overColor = "#c3c3c2";
	}
	if ("".equals(archiveColor)) {
		archiveColor = "#937a47";
	}
	//String temptable = WorkPlanShareBase.getTempTable(userId);
	StringBuffer sqlStringBuffer = new StringBuffer();

	sqlStringBuffer
			.append("SELECT C.*, WorkPlanExchange.exchangeCount,overworkplan.workplancolor FROM(SELECT * FROM ");
	sqlStringBuffer.append("(");
	sqlStringBuffer
			.append("SELECT workPlan.*, workPlanType.workPlanTypeColor");
	sqlStringBuffer
			.append(" FROM WorkPlan workPlan, WorkPlanType workPlanType");
	//��ʾ�����ճ̣������ѽ����ճ�
	//sqlStringBuffer.append(" WHERE (workPlan.status = 0 or workPlan.status = 1 or workPlan.status = 2)");
	sqlStringBuffer
			.append(" WHERE (workPlan.status = 0 or workPlan.status = "
					+ overAvailable + " or workPlan.status = "
					+ archiveAvailable + ")");
	//sqlStringBuffer.append(Constants.WorkPlan_Status_Unfinished);
	/** Add By Hqf for TD9970 Start **/
	sqlStringBuffer.append("AND workPlan.deleted <> 1");
	/** Add By Hqf for TD9970 End **/
	sqlStringBuffer
			.append(" AND workPlan.type_n = workPlanType.workPlanTypeId");
	sqlStringBuffer.append(" AND workPlan.createrType = '" + userType
			+ "'");

	////////////////////////////////////////////
	if (!"1".equals(isShare)) {
		sqlStringBuffer.append(" AND (");
		sqlStringBuffer.append(" workPlan.resourceID = '");
		sqlStringBuffer.append(selectUser);
		sqlStringBuffer.append("'");
		sqlStringBuffer.append(" OR workPlan.resourceID LIKE '"
				+ selectUser + ",%'");
		sqlStringBuffer.append(" OR workPlan.resourceID LIKE '%,"
				+ selectUser + ",%'");
		sqlStringBuffer.append(" OR workPlan.resourceID LIKE '%,"
				+ selectUser + "'");
		sqlStringBuffer.append(" )");
	} else {
		if (!appendselectUser) {
			sqlStringBuffer.append(" AND (");
			StringTokenizer namesst = new StringTokenizer(
					selectUserNames, ",");
			StringTokenizer idsst = new StringTokenizer(selectUser, ",");
			sqlStringBuffer.append(" workPlan.resourceID = '");
			sqlStringBuffer.append(selectUser);
			sqlStringBuffer.append("'");
			while (idsst.hasMoreTokens()) {
				String id = idsst.nextToken();
				if (recordSet.getDBType().equals("oracle")) {
					sqlStringBuffer
							.append(" OR ','||workPlan.resourceID||',' LIKE '%,"
									+ id + ",%'");
				} else {
					sqlStringBuffer
							.append(" OR ','+workPlan.resourceID+',' LIKE '%,"
									+ id + ",%'");
				}
			}
			sqlStringBuffer.append(")");
		}

	}
	sqlStringBuffer.append(" AND ( (workPlan.beginDate >= '");
	sqlStringBuffer.append(beginDate);
	sqlStringBuffer.append("' AND workPlan.beginDate <= '");
	sqlStringBuffer.append(endDate);
	sqlStringBuffer.append("') OR ");
	sqlStringBuffer.append(" (workPlan.endDate >= '");
	sqlStringBuffer.append(beginDate);
	sqlStringBuffer.append("' AND workPlan.endDate <= '");
	sqlStringBuffer.append(endDate);
	sqlStringBuffer.append("') OR ");
	sqlStringBuffer.append(" (workPlan.endDate >= '");
	sqlStringBuffer.append(endDate);
	sqlStringBuffer.append("' AND workPlan.beginDate <= '");
	sqlStringBuffer.append(beginDate);
	sqlStringBuffer.append("') OR ");
	sqlStringBuffer
			.append(" ((workPlan.endDate IS null OR workPlan.endDate = '') AND workPlan.beginDate <= '");
	sqlStringBuffer.append(beginDate);
	sqlStringBuffer.append("') )");
	sqlStringBuffer.append(" ) A");
	sqlStringBuffer.append(" LEFT JOIN");
	sqlStringBuffer.append(" (");
	sqlStringBuffer
			.append(" SELECT workPlanShareDetail.workId, max(shareLevel) shareLevel ");
	sqlStringBuffer
			.append(" FROM WorkPlanShareDetail workPlanShareDetail");
	sqlStringBuffer.append(" WHERE workPlanShareDetail.userId = ");
	sqlStringBuffer.append(userId);
	sqlStringBuffer.append(" AND workPlanShareDetail.userType = 1");
	sqlStringBuffer.append(" GROUP BY workPlanShareDetail.workId");
	sqlStringBuffer.append(" ) B");
	sqlStringBuffer.append(" ON A.id = B.workId) C");
	sqlStringBuffer.append(" LEFT JOIN WorkPlanExchange");
	sqlStringBuffer
			.append(" ON C.id = WorkPlanExchange.workPlanId AND WorkPlanExchange.memberId = ");
	sqlStringBuffer.append(userId);
	sqlStringBuffer.append(" LEFT JOIN overworkplan ON overworkplan.id=c.status ");
	sqlStringBuffer.append(" WHERE shareLevel >= 1");

	sqlStringBuffer.append(" ORDER BY beginDate DESC, beginTime DESC");

	//System.out.println("######" + beginDate); 
	//System.out.println("######" + endDate);
	recordSet.executeSql(sqlStringBuffer.toString());
	System.out.println(sqlStringBuffer.toString());
	Map result = new HashMap();
	List eventslist = new ArrayList();
	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm");
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat format3 = new SimpleDateFormat("HH:mm");
	while (recordSet.next()) {
		try {
			boolean isAllDay = false;
			List event = new ArrayList();
			event.add(recordSet.getString("id"));
			event.add(recordSet.getString("name"));
			Date startDate = format2.parse(recordSet.getString(
					"begindate").trim()
					+ " " + recordSet.getString("begintime").trim());
			event.add(format.format(startDate));
			if (format2.parse(beginDate + " 00:00").getTime()
					- startDate.getTime() > 0) {
				beginDate = recordSet.getString("begindate");
			}
			if (!"".equals(recordSet.getString("enddate"))) {
				String endTime = recordSet.getString("endtime");
				if ("".equals(endTime.trim())) {
					endTime = "23:59";
				}
				Date endDate2 = format2.parse(recordSet
						.getString("enddate")
						+ " " + recordSet.getString("endtime"));
				//if (endDate2.getTime() - startDate.getTime() > 0
						//|| endDate2.getHours() - startDate.getHours() >= 24||endDate2.getYear()-startDate.getYear()>0) {
				if(Util.dayDiff(format2.format(startDate),format2.format(endDate2))>1){
					isAllDay = true;
				} else {

				}

				event.add(format.format(endDate2));
			} else {
				endDate = "01/01/10000";
				event.add("01/01/10000 00:00");
				isAllDay = true;
			}

			event.add("0");
			if (isAllDay) {
				event.add("1");//�ǲ���ȫ��
			} else {
				event.add("0");
			}

			event.add("0");//,0,1,0,-1,1,
			if(recordSet.getInt("status")==0){
				event.add(recordSet.getString("workPlanTypeColor"));//��ɫ
			}else{
				event.add(recordSet.getString("workplancolor"));//��ɫ
			}
			if (recordSet.getInt("shareLevel")>1) {
				event.add("1");//editable
			} else {
				event.add("0");//editable
			}
			event.add("");
			event.add("0");
			event.add("");
			eventslist.add(event);
		} catch (Exception e) {
			
		}
	}

	result.put("events", eventslist);
	result.put("issort", ""+true);
	result.put("start", beginDate + " 00:00");
	result.put("end", endDate + " 23:59");
	result.put("error", null);

	JSONObject obj = JSONObject.fromObject(result);
	out.clearBuffer();
	out.print(obj.toString());
%>