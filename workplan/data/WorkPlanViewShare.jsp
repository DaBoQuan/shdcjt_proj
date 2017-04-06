<%@ page language="java" contentType="text/html; charset=GBK" buffer="none" %>

<%@ include file="/systeminfo/init.jsp" %>

<%@ include file="CreateCalendarSegment.jsp" %>
<%@ include file="ViewCalendarSegment.jsp" %>
<%@ include file="ShareCalendarSegment.jsp" %>

<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.Constants" %>

<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>
<!--<jsp:useBean id="WorkPlanShareBase" class="weaver.WorkPlan.WorkPlanShareBase" scope="page"/>-->
<HTML>
<HEAD>
	<LINK href="/css/Weaver.css" type="text/css" rel="STYLESHEET">
	<LINK href="/css/calendar.css" type="text/css" rel="STYLESHEET">
	<SCRIPT language="javaScript" src="/js/jquery/jquery.js"></SCRIPT>
	<SCRIPT language="VBS" src="/js/browser/DateBrowser.vbs"></SCRIPT>
	<SCRIPT language="VBS" src="/js/browser/CustomerMultiBrowser.vbs"></SCRIPT>
	<SCRIPT language="VBS" src="/js/browser/DocsMultiBrowser.vbs"></SCRIPT>
	<SCRIPT language="VBS" src="/js/browser/ProjectMultiBrowser.vbs"></SCRIPT>
	<SCRIPT language="VBS" src="/js/browser/RequestMultiBrowser.vbs"></SCRIPT>
	<SCRIPT language="javascript" src="/js/weaver.js"></SCRIPT>
	<SCRIPT language="javaScript" src="/js/OrderValidator.js"></SCRIPT>
	<SCRIPT language="javaScript" src="/js/prototype.js"></SCRIPT>
	<SCRIPT language="javaScript" src="/js/workplan/util/util.js"></SCRIPT>
	<SCRIPT language="javaScript" src="/js/workplan/util/follow.js"></SCRIPT>
	<SCRIPT language="javaScript" src="/js/workplan/util/validation.js"></SCRIPT>
	<style type="text/css">
	*{
		font-family:"verdana","����" !important;
	}
	.wk-scrolltimedevents {
		PADDING-RIGHT: 0px;
		BORDER-TOP: #a2bbdd 1px solid;
		OVERFLOW-Y: scroll;
		PADDING-LEFT: 0px;
		FONT-SIZE: 11px;
		OVERFLOW-X: hidden;
		PADDING-BOTTOM: 0px;
		LINE-HEIGHT: normal;
		PADDING-TOP: 0px;
		BORDER-BOTTOM: #fff 1px solid;
		POSITION: relative;
	}
	
	.printborder {
		BORDER-RIGHT: #000 1px solid;
		BORDER-TOP: #000 1px solid;
		BORDER-LEFT: #000 1px solid;
		BORDER-BOTTOM: #000 1px solid
	}
	
	.printborder {
		BORDER-LEFT: #c3d9ff 9px solid
	}
	
	.mainGrid {
		BACKGROUND: #c3d9ff;
		BORDER-BOTTOM: #c3d9ff 6px solid
	}
	
	.wk-dummyth {
		PADDING-RIGHT: 0px;
		PADDING-LEFT: 0px;
		PADDING-BOTTOM: 0px;
		VERTICAL-ALIGN: top;
		PADDING-TOP: 0px;
		BACKGROUND-COLOR: #c3d9ff
	}
	.wk-tzlabel {
		PADDING-BOTTOM: 2px; VERTICAL-ALIGN: bottom; OVERFLOW: hidden; COLOR: #446688; TEXT-ALIGN: center
	}
	</style>
</HEAD> 
<BODY onload="setVariables(); checkLocation('divSave', 80, 20);" onselectstart="return canBeSelected()">

<%
	// onmousemove="coordinateReport()"
	/*
	 * ҳ���������
	 * ���ݿ����ݶ�ȡ
	 */	
	Calendar thisCalendar = Calendar.getInstance();  //��ǰ����
	Calendar selectCalendar = Calendar.getInstance();  //������ʾ������

	int countDays = 0;  //��Ҫ��ʾ������
	int offsetDays = 0;  //�����ʾ��ʾ��һ���ƫ������
	String thisDate = "";  //��ǰ����
	String selectDate = "";  //������ʾ����
	
	String beginDate = "";
	String endDate = "";
	
	String beginYear = "";
	String beginMonth = "";
	String beginDay = "";
	
	String endYear = "";
	String endMonth = "";
	String endDay = "";
    
	//��������
	String userId = String.valueOf(user.getUID());  //��ǰ�û�Id
	String userType = user.getLogintype();  //��ǰ�û�����
	String selectUser = Util.null2String(request.getParameter("selectUser")); //��ѡ���û�Id		
	String selectUserNames = Util.null2String(request.getParameter("selectUserNames"));  //�鿴����������

	String viewType = String.valueOf(Util.getIntValue(request.getParameter("viewtype"), 2));  //1:�ռƻ���ʾ 2:�ܼƻ���ʾ 3:�¼ƻ���ʾ
	String selectDateString = Util.null2String(request.getParameter("selectdate"));  //��ѡ������
	boolean appendselectUser = false;
	if("".equals(selectUser) || userId.equals(selectUser))
	{
		appendselectUser = true;
		selectUser = userId;
	}

	String thisYear = Util.add0((thisCalendar.get(Calendar.YEAR)), 4);  //��ǰ��
	String thisMonth = Util.add0((thisCalendar.get(Calendar.MONTH)) + 1, 2);  //��ǰ��
	String thisDayOfMonth = Util.add0((thisCalendar.get(Calendar.DAY_OF_MONTH)), 2);  //��ǰ��
	thisDate = thisYear + "-" + thisMonth + "-" + thisDayOfMonth;

	if (!"".equals(selectDateString))
	//��ѡ������
	{	
		int selectYear = Util.getIntValue(selectDateString.substring(0, 4));  //��ѡ����
		int selectMonth = Util.getIntValue(selectDateString.substring(5, 7)) - 1;  //��ѡ����
		int selectDay = Util.getIntValue(selectDateString.substring(8, 10));  //��ѡ����
		selectCalendar.set(selectYear, selectMonth, selectDay);
	}
	
  
    String selectYear = Util.add0((selectCalendar.get(Calendar.YEAR)), 4);  //�� 
    String selectMonth = Util.add0((selectCalendar.get(Calendar.MONTH)) + 1, 2);  // ��
    String selectDayOfMonth = Util.add0((selectCalendar.get(Calendar.DAY_OF_MONTH)), 2);  //��    
    String selectWeekOfYear = String.valueOf(selectCalendar.get(Calendar.WEEK_OF_YEAR));  //�ڼ���
    String selectDayOfWeek = String.valueOf(selectCalendar.get(Calendar.DAY_OF_WEEK));  //һ�ܵڼ���
    selectDate = selectYear + "-" + selectMonth + "-" + selectDayOfMonth;

         
	switch(Integer.parseInt(viewType))
	//����Ϊ��ʾ�ĵ�һ��
	{
		case 1:
		//�ռƻ���ʾ
			offsetDays = 0;
			break;
		case 2:
		//�ܼƻ���ʾ
			offsetDays = Integer.parseInt(selectDayOfWeek) - 1;
			selectCalendar.add(Calendar.DAY_OF_WEEK, -1 * Integer.parseInt(selectDayOfWeek) + 1);
			break;
		case 3:
		//�¼ƻ���ʾ
			selectCalendar.set(Calendar.DATE, 1);  //����Ϊ�µ�һ��
			int offsetDayOfWeek = selectCalendar.get(Calendar.DAY_OF_WEEK) - 1;
			offsetDays = Integer.parseInt(selectDayOfMonth) - 1 + offsetDayOfWeek;
			selectCalendar.add(Calendar.DAY_OF_WEEK, -1 * offsetDayOfWeek);  //����Ϊ���������ܵĵ�һ��
			break;
	}	
	beginYear = Util.add0(selectCalendar.get(Calendar.YEAR), 4);  //�� 
    beginMonth = Util.add0(selectCalendar.get(Calendar.MONTH) + 1, 2);  // ��
    beginDay = Util.add0(selectCalendar.get(Calendar.DAY_OF_MONTH), 2);  //�� 
    beginDate = beginYear + "-" + beginMonth + "-" + beginDay;

	switch(Integer.parseInt(viewType))
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
			selectCalendar.set(Calendar.DATE, 1);  //����Ϊ�µ�һ��
			selectCalendar.add(Calendar.MONTH, 1);
			selectCalendar.add(Calendar.DATE, -1);
			countDays = selectCalendar.get(Calendar.DAY_OF_MONTH);  //��������
			int offsetDayOfWeekEnd = 7 - selectCalendar.get(Calendar.DAY_OF_WEEK);
			selectCalendar.add(Calendar.DAY_OF_WEEK, offsetDayOfWeekEnd);  //����Ϊ��ĩ�����ܵ����һ��
			break;
	}	
	endYear = Util.add0(selectCalendar.get(Calendar.YEAR), 4);  //�� 
    endMonth = Util.add0(selectCalendar.get(Calendar.MONTH) + 1, 2);  // ��
    endDay = Util.add0(selectCalendar.get(Calendar.DAY_OF_MONTH), 2);  //��
    endDate = endYear + "-" + endMonth + "-" + endDay;
    
    String overColor = "";
	String archiveColor = "";
	String archiveAvailable = "0";
	String overAvailable = "0";
	String oversql = "select * from overworkplan order by workplanname desc";
	recordSet.executeSql(oversql);
	while(recordSet.next())
	{
		String id = recordSet.getString("id");
		String workplanname = recordSet.getString("workplanname");
		String workplancolor = recordSet.getString("workplancolor");
		String wavailable = recordSet.getString("wavailable");
		if("1".equals(id))
		{
			overColor = workplancolor;
			if("1".equals(wavailable))
				overAvailable = "1";
		}
		else
		{
			archiveColor = workplancolor;
			if("1".equals(wavailable))
				archiveAvailable = "2";
		}
	}
	if("".equals(overColor))
	{
		overColor = "#c3c3c2";
	}
	if("".equals(archiveColor))
	{
		archiveColor = "#937a47";
	}	

    //String temptable = WorkPlanShareBase.getTempTable(userId);
    StringBuffer sqlStringBuffer = new StringBuffer();
    
	sqlStringBuffer.append("SELECT C.*, WorkPlanExchange.exchangeCount FROM(SELECT * FROM ");
	sqlStringBuffer.append("(");
	sqlStringBuffer.append("SELECT workPlan.*, workPlanType.workPlanTypeColor");
	sqlStringBuffer.append(" FROM WorkPlan workPlan, WorkPlanType workPlanType");
	//��ʾ�����ճ̣������ѽ����ճ�
	//sqlStringBuffer.append(" WHERE (workPlan.status = 0 or workPlan.status = 1 or workPlan.status = 2)");
	sqlStringBuffer.append(" WHERE (workPlan.status = 0 or workPlan.status = "+overAvailable+" or workPlan.status = "+archiveAvailable+")");
	//sqlStringBuffer.append(Constants.WorkPlan_Status_Unfinished);
	sqlStringBuffer.append(" AND workPlan.type_n = workPlanType.workPlanTypeId");
	sqlStringBuffer.append(" AND workPlan.createrType = '" + userType + "'");
	if(!appendselectUser)
	{
		sqlStringBuffer.append(" AND (");
		StringTokenizer namesst = new StringTokenizer(selectUserNames,",");
	 	StringTokenizer idsst = new StringTokenizer(selectUser,",");
	 	sqlStringBuffer.append(" workPlan.resourceID = '");
		sqlStringBuffer.append(selectUser);
		sqlStringBuffer.append("'");
	 	while(idsst.hasMoreTokens())
	 	{
	 		String id = idsst.nextToken();
	 		if (recordSet.getDBType().equals("oracle")) 
	 		{
	 			sqlStringBuffer.append(" OR ','||workPlan.resourceID||',' LIKE '%," + id + ",%'");
	 		}
	 		else
	 		{
	 			sqlStringBuffer.append(" OR ','+workPlan.resourceID+',' LIKE '%," + id + ",%'");
	 		}
	 	}
		sqlStringBuffer.append(")");
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
	sqlStringBuffer.append(" ((workPlan.endDate IS null OR workPlan.endDate = '') AND workPlan.beginDate <= '");
	sqlStringBuffer.append(beginDate);
	sqlStringBuffer.append("') )");
	sqlStringBuffer.append(" ) A");
	sqlStringBuffer.append(" LEFT JOIN");
	sqlStringBuffer.append(" (");
	sqlStringBuffer.append(" SELECT workPlanShareDetail.workId, max(shareLevel) shareLevel ");
	sqlStringBuffer.append(" FROM WorkPlanShareDetail workPlanShareDetail");
	sqlStringBuffer.append(" WHERE workPlanShareDetail.userId = ");
	sqlStringBuffer.append(userId);
	sqlStringBuffer.append(" AND workPlanShareDetail.userType = 1 ");
	sqlStringBuffer.append(" GROUP BY workPlanShareDetail.workId");
	sqlStringBuffer.append(" ) B");
	sqlStringBuffer.append(" ON A.id = B.workId) C");
	sqlStringBuffer.append(" LEFT JOIN WorkPlanExchange");
	sqlStringBuffer.append(" ON C.id = WorkPlanExchange.workPlanId AND WorkPlanExchange.memberId = ");
	sqlStringBuffer.append(userId);		
	sqlStringBuffer.append(" WHERE shareLevel >= 1");
	sqlStringBuffer.append(" ORDER BY beginDate DESC, beginTime DESC");
			
	//System.out.println("######" + beginDate); 
	//System.out.println("######" + endDate);
	//System.out.println(sqlStringBuffer.toString());
	recordSet.executeSql(sqlStringBuffer.toString());	
%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
BaseBean baseBean_self = new BaseBean();
int userightmenu_self = 1;
String addTopSpaceStr = "";
try{
	userightmenu_self = Util.getIntValue(baseBean_self.getPropValue("systemmenu", "userightmenu"), 1);
}catch(Exception e){}
if(userightmenu_self == 0){
	addTopSpaceStr = "24 + ";
}
	RCMenu += "{"+SystemEnv.getHtmlLabelName(20169,user.getLanguage())+",javascript:changeToEventView(),_self}";
	RCMenuHeight += RCMenuHeightStep;
	
	if("month".equals(request.getParameter("from")))
	{
	    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:goBack(),_self}";
		RCMenuHeight += RCMenuHeightStep;
	}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM name="weaver" method="post" action="WorkPlanViewEvent.jsp">
<INPUT type="hidden" name="selectUser" value="<%= selectUser %>">
<INPUT type="hidden" name="selectUserNames" value="<%= selectUserNames %>">
<INPUT type="hidden" name="viewtype" value="<%= viewType %>">
<INPUT type="hidden" name="selectdate" value="<%= selectDateString %>">
</FORM>

<DIV id="divSave" style="display:none;position:absolute; visibility:show;right:0px;top:0px;padding:1px;background:#ffffff;border:1px solid #EEEEEE;width:160px;color:#666666;z-index:9999 ;filter:alpha(opacity=80);">
	<TABLE>
		<TR>
			<TD>
				<IMG src="/images/loading2.gif">
			</TD>
			<TD>
				<%= SystemEnv.getHtmlLabelName(20240,user.getLanguage()) %>
			</TD>
		</TR>
	</TABLE>
</DIV>

</BODY>

<SCRIPT language="javascript">
/*
 * һ���������½�
 */
document.body.attachEvent("onmousemove", new Function("createCalendarItemSingleDayAction.moving()"));
document.body.attachEvent("onmouseup", new Function("createCalendarItemSingleDayAction.stopDrag()"));

/*
 * ���������½�
 */
document.body.attachEvent("onmousemove", new Function("createCalendarItemMultiDayAction.moving()"));
document.body.attachEvent("onmouseup", new Function("createCalendarItemMultiDayAction.stopDrag()"));

/*
 * �������½�
 */
document.body.attachEvent("onmousemove", new Function("createCalendarItemMonthAction.moving()"));
document.body.attachEvent("onmouseup", new Function("createCalendarItemMonthAction.stopDrag()"));

/*
 * һ���������ı����ʱ��
 */
document.body.attachEvent("onmousemove", new Function("alterEndTimeActionSingleDay.moving()"));
document.body.attachEvent("onmouseup", new Function("alterEndTimeActionSingleDay.stopDrag()"));


/*================ �ճ̲��� ================*/
var viewType = <%= viewType %>;
var actionUrl = "WorkPlanViewOperation.jsp";

var calendarListSingleDay = new Array();
var calendarListMultiDay = new Array();
var calendarList = new Array();  //calendarList = calendarListSingleDay + calendarListMultiDay

var thisDate = <%= thisYear %> + "-" + formatSingleDateTime(<%= thisMonth %>) + "-" + formatSingleDateTime(<%= thisDayOfMonth %>);
var beginDate = <%= beginYear %> + "-" + formatSingleDateTime(<%= beginMonth %>) + "-" + formatSingleDateTime(<%= beginDay %>);  //��ʾ�Ŀ�ʼ����
var endDate = <%= endYear %> + "-" + formatSingleDateTime(<%= endMonth %>) + "-" + formatSingleDateTime(<%= endDay %>);  //��ʾ�Ľ�������
var offsetDays = <%= offsetDays %>;  //����ʾ��һ���������
var countDays = <%= countDays %>;  //��ʾ������

var daysOfWeek = 7;
var daysOfMonth = <%= countDays %>;
var showDaysOfMonth;  //����ʾҳ������ʾ��cell��
var hoursOfDay = 24;
var minutesOfHour = 60;

var beginYearOfTable;
var beginMonthOfTable;
var beginDayOfTable;
var beginDateOfTable;


var calendarItemContentWidth = 0;  //�ճ�����Cell���
/*============ ���� һ�����ճ���ʾ���� ============*/
var timeTitleWidth = 45;  //CSS�ж���ʱ�����cell���
var calendarTitleHeight = 30;  //CSS�ж����ճ̱���Cell�߶�
var calendarItemContentHeight = 30;  //CSS�ж����Сʱ�ճ�����Cell�߶�

var calendarItemTitleHeight = 15;  //�ճ�������ʾʱ��ı���߶�

var perMinuteHeight = calendarItemContentHeight / 30;


/*============ ���� �����ճ���ʾ���� ============*/
var multiDayCalendarAreaHeight = 30;  //CSS�ж�������ճ�������ʾ�߶�
var multiDayCalendarItemHeight = 18;  //�����ճ���ʾ�߶�
var multiDayBlankAreaHeight = 20;  //�����ճ�������ʾ�հ�����߶�


/*============ �� �ճ���ʾ���� ============*/
var calendarDayTitleHeightMonth = 30;  //CSS�ж����ܼ�������ʾCell�߶�
var calendarDateTitleHeightMonth = 20; //CSS�ж������ڱ�����ʾCell�߶�
var calendarItemContentHeightMonth = 90;  //CSS�ж����ճ�����Cell�߶�
var calendarItemHeightMonth = 18;  //�ճ���ʾ�߶�

var maxDisplayRow = 4;  //cell�������ʾ���� + 1 (�������һ����ֵ = ��Ҫ��ʾ���� - (maxDisplayRow - 2))


/*================ �����½����� ================*/
var coverLayerColor = "lightyellow";


/*================ splah�½� ================*/
var enable = true;

var splash;
var splashId = "splashPopup";

var splashBeginTime = "<%= Constants.WorkPlan_StartTime %>";
var splashEndTime = "<%= Constants.WorkPlan_EndTime %>";

var splashWidth = 500;
var splashHeight = 400;


/*================ ���� ================*/
var borderUnsavedStyle = "2px dashed #000000";

var topHeightOfDays = calendarTitleHeight + multiDayCalendarAreaHeight;  //�����ճ���ʾ���򶥶˵���ʾҳ�涥�˵ľ���
var topHeightOfMonth = calendarDayTitleHeightMonth;  //���ճ���ʾ���򶥶˵���ʾҳ�涥�˵ľ���

Event.observe(window, "load", function()
{
	buildCalendar();
	loadCalendar();
	window.onresize = windowChange;
	resetScrollTimedEventSwk();
	window.location.hash="newrushHour";
	document.body.scrollTop = 0;
});
function resetScrollTimedEventSwk()
{
	try
	{
		var lastHeight = document.body.offsetHeight - document.getElementById('topcontainerwk').offsetHeight-10;
		if(lastHeight<=200)
		{
			lastHeight = 200;
		}
		scrolltimedeventswk.style.height = lastHeight+"px";
	}
	catch(e)
	{
		
	}
}
function setCalendarTitle(date, table, countDays)
{
	var row, cell;

	if(1 == countDays)
	//��
	{
		row = table.insertRow();
		row.className = "titleDate";	
		cell = row.insertCell();
		cell.innerHTML = "";
		//���õ�һ�еĿ���Լ���ʽ
		cell.style.width="45";
		cell.className = "wk-tzlabel";
		
		cell = row.insertCell();
		var output = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(";
		
		if(0 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(398,user.getLanguage()) %>";
		}
		else if(1 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(392,user.getLanguage()) %>";
		}
		else if(2 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(393,user.getLanguage()) %>";
		}
		else if(3 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(394,user.getLanguage()) %>";
		}
		else if(4 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(395,user.getLanguage()) %>";
		}
		else if(5 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(396,user.getLanguage()) %>";
		}
		else if(6 == date.getDay())
		{
			output += "<%= SystemEnv.getHtmlLabelName(397,user.getLanguage()) %>";
		}
		
		output += ")";
		
		cell.innerHTML = output;
		date.setDate(date.getDate() + 1);	
		
		//���һ�У�������ʾ��������ʹ���������������һֱ
		cell = row.insertCell();
		cell.className = "wk-dummyth";
		cell.style.width = "17px";
		cell.innerHTML = "&nbsp;";	
		cell.setAttribute("rowSpan","2");
	}
	else if(7 == countDays)
	//��
	{
		row = table.insertRow();
		row.className = "titleDate";	
		cell = row.insertCell();
		cell.innerHTML = "";
		//���õ�һ�еĿ���Լ���ʽ	
		cell.style.width="45";
		cell.className = "wk-tzlabel";
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(398,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
	
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(392,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(393,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(394,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(395,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(396,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		cell = row.insertCell();
		cell.innerHTML = formatSingleDateTime(date.getMonth() + 1) + '-' + formatSingleDateTime(date.getDate()) + "<br>(" + "<%= SystemEnv.getHtmlLabelName(397,user.getLanguage()) %>" + ")";
		date.setDate(date.getDate() + 1);
		
		//���һ�У�������ʾ��������ʹ���������������һֱ
		cell = row.insertCell();
		cell.className = "wk-dummyth";
		cell.style.width = "17px";
		cell.innerHTML = "&nbsp;";	
		cell.setAttribute("rowSpan","2");
	}
	else
	//��
	{
		row = table.insertRow();
		row.className = "titleDayMonth";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(398,user.getLanguage()) %>";
	
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(392,user.getLanguage()) %>";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(393,user.getLanguage()) %>";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(394,user.getLanguage()) %>";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(395,user.getLanguage()) %>";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(396,user.getLanguage()) %>";
		
		cell = row.insertCell();
		cell.innerHTML = "<%= SystemEnv.getHtmlLabelName(397,user.getLanguage()) %>";
	}
}

function setDateTitleMonth(container, fullDate, selectMonth)
//����ʾ��Cell������ʾ
{
	var table, row, cell;
	
	var monthOfDate = fullDate.substring(5, 7);
	var dayOfDate = fullDate.substring(8, 10);
	
	table = document.createElement("TABLE");
	table.className = "calendarTableStyle";
	container.appendChild(table);
	
	//������
	row = table.insertRow();
	cell = row.insertCell();				
	if(monthOfDate == selectMonth)
	{
		cell.className = "titleDateMonth";
	}
	else
	{
		cell.className = "titleDateMonthNotThisMonth";
	}

	cell.setAttribute("id", fullDate);		
	cell.innerHTML = dayOfDate;
	
	cell.attachEvent("onmousedown", new Function("createCalendarItemMonthAction.startDrag()"));
}
function setDateContentMonth(container, id)
//����ʾ��Cell������ʾ
{
	var table, row, cell;
	
	table = document.createElement("TABLE");
	table.style.width = "100%";
	table.style.height = calendarItemContentHeightMonth - calendarDateTitleHeightMonth - 1;  //1Ϊpadding���
	
	row = table.insertRow();
	cell = row.insertCell();	
	with(cell.style)
	{
		textAlign = "right";
		verticalAlign = "bottom";
	}
	cell.setAttribute("id", id);
	//cell.innerHTML = cell.getAttribute("id");
	
	container.appendChild(table);
}



var scrolltimedeventswk ;
//�����ճ̿��
function buildCalendarFrame(countDays)
{
	//�������ܣ����ڷ��ñ߿�
	var mainGrid = document.createElement("DIV");
	mainGrid.className = "printborder mainGrid";
	document.body.appendChild(mainGrid);
	//���ڷ�������div
	var gridcontainer = document.createElement("DIV");
	gridcontainer.setAttribute("id", "gridcontainer");
	gridcontainer.style.overflowY = "visible";
	gridcontainer.style.height = "100%";
	gridcontainer.setAttribute("closure_hashCode", "23");
	mainGrid.appendChild(gridcontainer);
	//�ճ�ͷ��DIV
	var topcontainerwk = document.createElement("DIV");
	topcontainerwk.setAttribute("id", "topcontainerwk");
	gridcontainer.appendChild(topcontainerwk);
	//�ճ�����DIV
	scrolltimedeventswk = document.createElement("DIV");
	scrolltimedeventswk.className = "wk-scrolltimedevents";
	scrolltimedeventswk.setAttribute("id", "scrolltimedeventswk");
	scrolltimedeventswk.style.height = "680px";
	gridcontainer.appendChild(scrolltimedeventswk);
	//�ճ�ͷ��table
	var headtable = document.createElement("TABLE");
	headtable.setAttribute("id", "calendarHeadTable");
	headtable.className = "calendarTableStyle";
	topcontainerwk.appendChild(headtable);
	//�ճ�����table
	var itemtable = document.createElement("TABLE");
	itemtable.setAttribute("id", "calendarTable");
	itemtable.className = "calendarTableStyle";
	scrolltimedeventswk.appendChild(itemtable);
	
	//���Ϊ���ճ̣�����ʾ�ճ�����DIV
	if(countDays>7)
	{
		scrolltimedeventswk.style.display="none";
	}
}
function buildCalendar()
//���ɱ�������
{
	var selectDate = new Date(<%= selectYear %>, <%= Integer.parseInt(selectMonth) - 1 %>, <%= selectDayOfMonth %>);
	var selectYear = selectDate.getFullYear();
	var selectMonth = formatSingleDateTime(selectDate.getMonth() + 1);
	var selectDateOfMonth = formatSingleDateTime(selectDate.getDate());

	var selectWeekOfYear = <%= selectWeekOfYear %>;
	var selectDayOfWeek = <%= selectDayOfWeek %>;
	
	selectDate = new Date(selectDate.valueOf() + (-1 * offsetDays) * 86400000);  //����Ϊ��ʾ��һ��
	
	beginYearOfTable = parseInt(selectDate.getYear(), 10);  //���ñ����ʾ��ʼ��
	beginMonthOfTable = formatSingleDateTime(parseInt(selectDate.getMonth(), 10) + 1);  //���ñ����ʾ��ʼ��
	beginDayOfTable = formatSingleDateTime(parseInt(selectDate.getDate(), 10));  //���ñ����ʾ��ʼ��
	beginDateOfTable = beginYearOfTable + "-" + beginMonthOfTable + "-" + beginDayOfTable;

	//�����ճ̿��
	buildCalendarFrame(countDays);
	var table = document.getElementById("calendarHeadTable");
	
	/*================== ���ڱ��� ==================*/	
	setCalendarTitle(selectDate, table, countDays);
	
	/*================== ������ʾCell ==================*/
	var row;
	var cell;	
	
	if(1 == countDays || 7 == countDays)
	//�ա���
	{
		/*================== �����ճ� ==================*/
		row = table.insertRow();
		row.className = "dataDay";
										
		cell = row.insertCell();
		cell.innerHTML = "";

		selectDate.setDate(selectDate.getDate() - countDays);
		for(var j = 1; j <= countDays; j++)
		{
			cell = row.insertCell();
			cell.setAttribute("id", selectDate.getYear() + "-" + formatSingleDateTime(selectDate.getMonth() + 1) + "-" + formatSingleDateTime(selectDate.getDate()));
			cell.setAttribute("indexId", j - 1);
			cell.innerHTML = "";
			//cell.innerHTML = cell.getAttribute("id");
			
			cell.attachEvent("onmousedown", new Function("createCalendarItemMultiDayAction.startDrag()"));
			
			selectDate.setDate(selectDate.getDate() + 1);
		}
	
		/*================== �ճ����� ==================*/	
		buildCalendarItemContent(selectDate);
		
		calendarItemContentWidth = (table.offsetWidth - timeTitleWidth) / countDays;  //����ÿ�񳤶�
	}
	else
	//��
	{
		var i = 0;
		var fullDate = selectDate.getYear() + "-" + formatSingleDateTime(selectDate.getMonth() + 1) + "-" + formatSingleDateTime(selectDate.getDate());

		while(beginDate <= fullDate && fullDate < endDate)
		{
			row = table.insertRow();

			for(var j = 1; j <= daysOfWeek; j++)
			{
				fullDate = selectDate.getYear().toString() + "-" + formatSingleDateTime(selectDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(selectDate.getDate()).toString();
				selectDate.setDate(selectDate.getDate() + 1);
				
				cell = row.insertCell();
				cell.setAttribute("id", fullDate);
				cell.setAttribute("indexId", (i * daysOfWeek) + j - 1);

				if(fullDate == thisDate)
				//�ǵ���
				{				
					cell.className = "dataThisDateMonth";
				}
				else
				{
					cell.className = "dataDateMonth";
				}
				
				cell.style.verticalAlign = "top";
				//cell.style.margin = 0;
				cell.style.padding = 1;
				setDateTitleMonth(cell, fullDate + ",title", selectMonth);
				setDateContentMonth(cell, fullDate + ",more");
				
				//cell.innerHTML += cell.getAttribute("id");
				//cell.innerHTML += cell.getAttribute("indexId");
				//cell.innerHTML = "";	
			}
			
			i++;
		}
		showDaysOfMonth = i * daysOfWeek;
		calendarItemContentWidth = (table.offsetWidth) / 7;  //����ÿ����		
	}
}
//�����ճ�����
function buildCalendarItemContent(selectDate)
{
	var table = document.getElementById("calendarTable");
	for(var i = 0; i < hoursOfDay * 2; i++)
	{
		/*================== ʱ������� ==================*/
		var fullTime;

		row = table.insertRow();		
		cell = row.insertCell();
		if(0 == i % 2)
		//����
		{
			fullTime = formatSingleDateTime(selectDate.getHours()) + ":00";
			cell.className = "titleTimeHalfHour";
			cell.innerHTML = fullTime;
			if(fullTime=="08:00"){cell.innerHTML += "<a name='newrushHour'></a>";}
		}
		else
		//��Сʱ
		{
			fullTime = formatSingleDateTime(selectDate.getHours()) + ":30";
			cell.className = "titleTimeWholeHour";
			cell.innerHTML = "";
			if(selectDate.getHours() < 23)
			//������24ʱ���ᷢ��������һ���
			{
				selectDate.setHours(selectDate.getHours() + 1);
			}
		}
	
		/*================== ������ ==================*/
		selectDate.setDate(selectDate.getDate() - countDays);

		for(var j = 1; j <= countDays; j++)
		{
			var fullDate = selectDate.getYear() + "-" + formatSingleDateTime(selectDate.getMonth() + 1) + "-" + formatSingleDateTime(selectDate.getDate());
			selectDate.setDate(selectDate.getDate() + 1);
			cell = row.insertCell();
			cell.setAttribute("id", fullDate + "," + fullTime);
			cell.setAttribute("indexId", j - 1);

			if(fullDate == thisDate)
			//�ǵ���
			{
				if(0 == i % 2)
				{
					cell.className = "dataHalfHourThisDate";
				}
				else
				{
					cell.className = "dataWholeHourThisDate";
				}
			}
			else
			{
				cell.className = (0 == i % 2 ? "dataHalfHour" : "dataWholeHour");
			}
			//cell.innerHTML = cell.getAttribute("id");
			cell.innerHTML = "";

			cell.attachEvent("onmousedown", new Function("createCalendarItemSingleDayAction.startDrag()"));
		}
	}
}

function loadCalendar()
//�����ճ�ͼ����ʾ
{
	calendarList = new Array();

<%
	
	/**
	 * ��ȡ���ݿ�����
	 */
	while(recordSet.next())
	{
	    int arrayId = -1;
		int itemId = recordSet.getInt("id");
		int type = recordSet.getInt("type_n");
		String color = recordSet.getString("workPlanTypeColor");				
		String itemName = recordSet.getString("name");
		if(itemName.indexOf("\\")>-1) itemName = itemName.replaceAll("\\\\","\\\\\\\\");
		String urgent = recordSet.getString("urgentLevel");
		String remindType = recordSet.getString("remindType");
		String remindBeforeStart = recordSet.getString("remindBeforeStart");
		int remindBeforeStartMinute = recordSet.getInt("remindTimesBeforeStart");
		String remindBeforeEnd = recordSet.getString("remindBeforeEnd");
		int remindBeforeEndMinute = recordSet.getInt("remindTimesBeforeEnd");
		String executeId = recordSet.getString("resourceId");
		String startDate = recordSet.getString("beginDate");
		String startTime = recordSet.getString("beginTime");
		String endDat = recordSet.getString("endDate");
		String endTime = recordSet.getString("endTime");
		
		String description = recordSet.getString("description");
		if(description.indexOf("\\")>-1) description = description.replaceAll("\\\\","\\\\\\\\");
		
		String relatedCustomer = recordSet.getString("relatedCus");
		String relatedDocument = recordSet.getString("relatedDoc");
		String relatedProject = recordSet.getString("relatedPrj");
		String relatedWorkFlow = recordSet.getString("relatedWf");
		
		String relatedTask = recordSet.getString("taskId");
		String relatedMeeting = recordSet.getString("meetingId");
		
		String status = recordSet.getString("status");
		int shareLevel = recordSet.getInt("shareLevel");  //shareLevel����Ϊnull�������֡���shareLevel > 1ʱ���ɱ༭���������ֻ��ʾ
		int exchangeCount = recordSet.getInt("exchangeCount");
		
		//�����ճ�ʱ���ı��ճ���ʾ��ʽ
		if("1".equals(status))
		{
			color =overColor ;
			itemName +="("+SystemEnv.getHtmlLabelName(1961,user.getLanguage())+")";
		}
		else if("2".equals(status))
		{
			color =archiveColor ;
			itemName +="("+SystemEnv.getHtmlLabelName(18800,user.getLanguage())+")";
		}

%>
		var tempItemName = "<%= Util.forHtml(itemName) %>";
		var tempDescription = "<%= Util.forHtml(description) %>";
		var calendarItemBuild = createCalendarItem(<%= arrayId %>, <%= itemId %>, <%= type %>, "<%= color %>", tempItemName, "<%= urgent %>", "<%= remindType %>", "<%= remindBeforeStart %>", <%= remindBeforeStartMinute %>, "<%= remindBeforeEnd %>", <%= remindBeforeEndMinute %>, "<%= executeId %>", "<%= startDate %>", "<%= startTime %>", "<%= endDat %>", "<%= endTime %>", tempDescription, "<%= relatedCustomer %>", "<%= relatedDocument %>", "<%= relatedProject %>", "<%= relatedWorkFlow %>", "<%= relatedTask %>", "<%= relatedMeeting %>","<%= status %>", <%= shareLevel %>, <%= exchangeCount %>);

		fillSingleDayOrMultiDayCalendarList(calendarItemBuild)
<%
	}
%>
	combineSingleDayAndMultiDayCalendarList();  //����ϲ�
	initArrayIdOfCalendarList();  //��ʼ������Ԫ��id
	outputCalendarList();  //�����ʾ
	initArrayIdOfDisplay();  //������ʾ��Ӧ������id
}

/*
 * ���ճ̶������Array
 */
function fillCalendarList(calendarItemBuild)
{
	calendarList.push(calendarItemBuild);
	/*if("1" == calendarItemBuild.calendarItemType)
	//һ��
	{
		calendarList.push(calendarItemBuild);
	}
	else if("2" == calendarItemBuild.calendarItemType)
	//����
	{
		calendarList.unshift(calendarItemBuild);
	}*/
}

/*
 * ���ճ̶�������Ӧ��Array
 */
function fillSingleDayOrMultiDayCalendarList(calendarItemBuild)
{
	if("1" == calendarItemBuild.calendarItemType)
	//һ��
	{
		calendarListSingleDay.push(calendarItemBuild);
	}
	else if("2" == calendarItemBuild.calendarItemType)
	//����
	{
		calendarListMultiDay.push(calendarItemBuild);
	}
}

function combineSingleDayAndMultiDayCalendarList()
{
	calendarList = calendarListMultiDay.concat(calendarListSingleDay);
}

/*
 * ��ʼ������Id����
 */
function initArrayIdOfCalendarList()
{
	for(var i = 0; i < calendarList.length; i++)
	{
		var calendarItem = calendarList[i];
		
		if(0 != calendarItem)
		{
			calendarItem.arrayId = i;
		}
	}
}
function initArrayIdOfDisplay()
{
	for(var i = 0; i < calendarList.length; i++)
	{
		var calendarItem = calendarList[i];
		
		if(0 != calendarItem)
		{
			if(calendarItem instanceof CalendarItemOfMonth)
			{
				for(var j = 0; j < calendarItem.display.length; j++)
				{
					calendarItem.display[j].setAttribute("arrayId", i);
				}
			}
			else
			{
				calendarItem.display.setAttribute("arrayId", i);
			}
		}
	}
}

/*
 * ����ճ���ʾ
 */
function outputCalendarList()
{
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].buildPatch();
		}
	}
}


function createCalendarItem(arrayId, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount)
{
	var calendarItemType = getCalendarItemType(startDate, startTime, endDate, endTime);

	if(1 == viewType || 2 == viewType)
	//������ʾ
	{
		if(undefined != $(startDate + "," + floorTime(startTime)) 
			&& 1 == calendarItemType /*&& endTime > startTime*/)
		//һ������
		{
			return new CalendarItemSingleDay(arrayId, "1", itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);
		}
		else if(2 == calendarItemType)
		//����
		{
			return new CalendarItemMultiDay(arrayId, "2", itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);
		}
		else
		//�������
		{
			return "0";
		}
	}
	else
	//����ʾ
	{
		if(undefined != $(startDate) && 1 == calendarItemType /*&& endTime > startTime*/)
		//һ������
		{
			return new CalendarItemOfMonth(arrayId, "1", itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);
		}
		else if(2 == calendarItemType)
		//����
		{
			return new CalendarItemOfMonth(arrayId, "2", itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);
		}
		else
		//�������
		{
			return "0";
		}
	}	
}
function getCalendarItemType(startDate, startTime, endDate, endTime)
{
	if(endDate == startDate)
	{
		return 1;
	}
	else if(endDate > startDate || "" == endDate)
	{
		return 2;
	}
	else
	{
		return 0;
	}
}




//������
function ItemAbstract(itemId, itemName, description)
{
	this.itemId = itemId;
	this.itemName = itemName;
	this.description = description;
}
ItemAbstract.prototype.setItemId = function(itemId)
{
	this.itemId = itemId;
}
ItemAbstract.prototype.setItemName = function(itemName)
{
	this.itemName = itemName;
}
ItemAbstract.prototype.setDescription = function(description)
{
	this.description = description;
}
ItemAbstract.prototype.debug = function()
{
		
}



//�ճ���
function CalendarItem(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount, borderStyle)
{
	ItemAbstract.apply(this, new Array(itemId, itemName, description));

	this.width;
	this.height;

	this.arrayId = arrayId;  //����id
	
	this.calendarItemType = calendarItemType;  //1:һ�����ճ� 2:�����ճ�
	this.type = type;  //����
	this.color = color;  //��ɫ
	this.urgent = urgent;  //1:һ�� 2:��Ҫ 3:����
	this.remindType = remindType;  //1:������ 2:���� 3:�ʼ�
	this.remindBeforeStart = remindBeforeStart;  //1:����
	this.remindBeforeStartMinute = remindBeforeStartMinute;
	this.remindBeforeEnd = remindBeforeEnd;  //1:����
	this.remindBeforeEndMinute = remindBeforeEndMinute;
	this.executeId = executeId;	  //������
	this.startDate = startDate;  //��ʼ����
	this.startTime = startTime;  //��ʼʱ��
	this.endDate = endDate;  //��������
	this.endTime = endTime;  //����ʱ��
	this.relatedCustomer = relatedCustomer;
	this.relatedDocument = relatedDocument;
	this.relatedProject = relatedProject;
	this.relatedWorkFlow = relatedWorkFlow;
	
	this.relatedTask = relatedTask;
	this.relatedMeeting = relatedMeeting;
	
	this.status = status;  //0:δ��� 2:��� 3:�鵵
	this.shareLevel = shareLevel;  //������
	this.exchangeCount = exchangeCount;
	this.borderStyle = borderStyle;
	
	this.minuteDifference;  //���޽�������ʱ����ʾ��ʾ���������ֵ
	
	this.display;
	this.propertyXML;
	this.activeShareId; //ӦΪSet
}
CalendarItem.prototype = new ItemAbstract();

CalendarItem.prototype.setCalendarItemType = function(calendarItemType)
{
	this.calendarItemType = calendarItemType;
}
CalendarItem.prototype.setType = function(type)
{
	this.type = type;
}
CalendarItem.prototype.setColor = function(color)
{
	this.color = color;
}
CalendarItem.prototype.setUrgent = function(urgent)
{
	this.urgent = urgent;
}
CalendarItem.prototype.setRemindType = function(remindType)
{
	this.remindType = remindType;
}
CalendarItem.prototype.setRemindBeforeStart = function(remindBeforeStart)
{
	this.remindBeforeStart = remindBeforeStart;
}
CalendarItem.prototype.setRemindBeforeStartMinute = function(remindBeforeStartMinute)
{
	this.remindBeforeStartMinute = remindBeforeStartMinute;
}
CalendarItem.prototype.setRemindBeforeEnd = function(remindBeforeEnd)
{
	this.remindBeforeEnd = remindBeforeEnd;
}
CalendarItem.prototype.setRemindBeforeEndMinute = function(remindBeforeEndMinute)
{
	this.remindBeforeEndMinute = remindBeforeEndMinute;
}
CalendarItem.prototype.setExecuteId = function(executeId)
{
	this.executeId = executeId;
}
CalendarItem.prototype.setStartDate = function(startDate)
{
	this.startDate = startDate;
}
CalendarItem.prototype.setStartTime = function(startTime)
{
	this.startTime = startTime;
}
CalendarItem.prototype.setEndDate = function(endDate)
{
	this.endDate = endDate;
}
CalendarItem.prototype.setEndTime = function(endTime)
{
	this.endTime = endTime;
}
CalendarItem.prototype.setRelatedCustomer = function(relatedCustomer)
{
	this.relatedCustomer = relatedCustomer;
}
CalendarItem.prototype.setRelatedDocument = function(relatedDocument)
{
	this.relatedDocument = relatedDocument;
}
CalendarItem.prototype.setRelatedProject = function(relatedProject)
{
	this.relatedProject = relatedProject;
}
CalendarItem.prototype.setRelatedWorkFlow = function(relatedWorkFlow)
{
	this.relatedWorkFlow = relatedWorkFlow;
}
CalendarItem.prototype.setRelatedTask = function(relatedTask)
{
	this.relatedTask = relatedTask;
}
CalendarItem.prototype.setRelatedMeeting = function(relatedMeeting)
{
	this.relatedMeeting = relatedMeeting;
}
CalendarItem.prototype.setStatus = function(status)
{
	this.status = status;
}
CalendarItem.prototype.setShareLevel = function(shareLevel)
{
	this.shareLevel = shareLevel;
}
CalendarItem.prototype.setExchangeCount = function(exchangeCount)
{
	this.exchangeCount = exchangeCount;
}
CalendarItem.prototype.setBorderStyle = function(borderStyle)
{
	this.borderStyle = borderStyle;
}

CalendarItem.prototype.transmitAsynchronous = function(method)
{
	var queryString = "";
	var ref = this;
	scrollCall();
	var saveGimg = 
	{
		onCreate: function()
		{
			Element.show('divSave');
		},
		onComplete: function() 
		{
			if(Ajax.activeRequestCount == 0)
			{
				Element.hide('divSave');
			}
		}
	};
	
	Ajax.Responders.register(saveGimg);
	
	if("addCalendarItem" == method)
	//���
	{
		//arrayId, itemId, color, status, shareLevel, exchangeCount
		queryString = "method=" + method
			  + "&workPlanType=" + this.type
			  + "&planName=" + encodeURIComponent(this.itemName)
			  + "&urgentLevel=" + this.urgent
			  + "&remindType=" + this.remindType
			  + "&remindBeforeStart=" + this.remindBeforeStart
			  + "&remindTimeBeforeStart=" + this.remindBeforeStartMinute
			  + "&remindBeforeEnd=" + this.remindBeforeEnd
			  + "&remindTimeBeforeEnd=" + this.remindBeforeEndMinute
			  + "&memberIDs=" + this.executeId
			  + "&beginDate=" + this.startDate
			  + "&beginTime=" + this.startTime
			  + "&endDate=" + this.endDate
			  + "&endTime=" + this.endTime
			  + "&description=" + encodeURIComponent(this.description)
			  + "&crmIDs=" + this.relatedCustomer
			  + "&docIDs=" + this.relatedDocument
			  + "&projectIDs=" + this.relatedProject
			  + "&requestIDs=" + this.relatedWorkFlow;

		//alert(queryString);

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",	
				asynchronous : true,
				onSuccess : function(resp)
							{
								ref.propertyXML = resp.responseXML;
								ref.parseAddCalendarItemXML();
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("editCalendarItemQuick" == method)
	//�༭
	{
		queryString = "method=" + method
			  + "&id=" + this.itemId
			  + "&startDate=" + this.startDate 
			  + "&startTime=" + this.startTime 
			  + "&endDate=" + this.endDate 
			  + "&endTime=" + this.endTime;
		
		//alert(queryString);
		
		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",		
				asynchronous : true,
				onSuccess : function(resp)
							{

							},
				onFailure : function()
							{									
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("editCalendarItem" == method)
	//�༭
	{
		//arrayId, itemId, calendarItemType, color, status, shareLevel, exchangeCount
		queryString = "method=" + method
			  + "&id=" + this.itemId
			  + "&workPlanType=" + this.type
			  + "&planName=" + encodeURIComponent(this.itemName)
			  + "&urgentLevel=" + this.urgent
			  + "&remindType=" + this.remindType
			  + "&remindBeforeStart=" + this.remindBeforeStart
			  + "&remindTimeBeforeStart=" + this.remindBeforeStartMinute
			  + "&remindBeforeEnd=" + this.remindBeforeEnd
			  + "&remindTimeBeforeEnd=" + this.remindBeforeEndMinute
			  + "&memberIDs=" + this.executeId
			  + "&beginDate=" + this.startDate
			  + "&beginTime=" + this.startTime
			  + "&endDate=" + this.endDate
			  + "&endTime=" + this.endTime
			  + "&description=" + encodeURIComponent(this.description)
			  + "&crmIDs=" + this.relatedCustomer
			  + "&docIDs=" + this.relatedDocument
			  + "&projectIDs=" + this.relatedProject
			  + "&meetingIDs=" + this.relatedMeeting
			  + "&requestIDs=" + this.relatedWorkFlow;

		//alert(queryString);

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",						
				asynchronous : true,
				onSuccess : function(resp)
							{
								ref.propertyXML = resp.responseXML;
								editCalendarSplash._modifyCalendarItem();
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("deleteCalendarItem" == method)
	//ɾ��
	{
		queryString = "method=" + method
			  + "&id=" + this.itemId			  

		//alert(queryString);

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",		
				asynchronous : true,
				onSuccess : function(resp)
							{
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}

	else if("overCalendarItem" == method)
	//���
	{
		queryString = "method=" + method
			  + "&id=" + this.itemId			  

		

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",		
				asynchronous : true,
				onSuccess : function(resp)
							{
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("getCalendarItem" == method)
	//�õ�������Ϣ111
	{
		queryString = "method=" + method
			 + "&id=" + this.itemId;

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",
				asynchronous : false,
				onSuccess : function(resp)
							{
								ref.propertyXML = resp.responseXML;						
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("getCalendarShare" == method)
	//�õ�������Ϣ
	{
		queryString = "method=" + method
			 + "&id=" + this.itemId;

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",
				asynchronous : false,
				onSuccess : function(resp)
							{
								ref.propertyXML = resp.responseXML;
								//alert(resp.responseText);															
							},
				onFailure : function()
							{
								ref.decorateCalendarItemBorderStyle(borderUnsavedStyle);
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("addCalendarShare" == method)
	//��ӹ���
	{
		queryString = "method=" + method
			 + "&id=" + this.itemId
			 + "&shareType=" + $("shareTypeShare").value
			 + "&shareId=" + $("shareIdShare").value
			 + "&roleLevel=" + $("roleLevelShare").value
			 + "&secLevel=" + $("secLevelShare").value			 
			 + "&shareLevel=" + $("shareLevelShare").value;

		//alert(queryString);

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",	
				asynchronous : true,
				onSuccess : function(resp)
							{
								ref.propertyXML = resp.responseXML;										
								shareCalendarSplash._fillListTable();
							},
				onFailure : function()
							{
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	else if("deleteCalendarShare" == method)
	//ɾ������
	{
		queryString = "method=" + method
			 + "&id=" + this.activeShareId;
		
		//alert(queryString);

		new Ajax.Request
		(
			actionUrl,
			{
				method: "post",	
				asynchronous : true,
				onSuccess : function(resp)
							{
																						
							},
				onFailure : function()
							{
								alert("Error!");
							},
				parameters : queryString
			}
		);
	}
	
}





/*============ һ�����ճ� ============*/
function CalendarItemSingleDay(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount)
{
	CalendarItem.apply(this, new Array(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount, "1px solid " + color));
}
CalendarItemSingleDay.prototype = new CalendarItem();
CalendarItemSingleDay.prototype.buildPatch = function()
{
	this.display = this._drawCalendarItem();	
	//���ճ����ݷ��õ��ճ�����div��
	var scrolltimedeventswk = document.getElementById("scrolltimedeventswk");
	scrolltimedeventswk.appendChild(this.display);
	
	this.display.appendChild(this._drawCalendarItemTitle());  //����
	this.display.appendChild(this._drawCalendarItemContent());  //����
	this.display.appendChild(this._drawCalendarItemDrag());  //�·���������
	this._resetCalendarItemDisplayInfo(this);
}
CalendarItemSingleDay.prototype.deletePatch = function()
{
	this.display.removeNode(true);
}
CalendarItemSingleDay.prototype.alterCalendarItem = function()
//�϶��ճ���ʱ���������������ʾ��Ϣ
{	
	this._fillCalendarItemContent(this.display.firstChild, this.startTime);
	this._caculateCalendarItemCoordinates(this.display, "calendarTable");	
	//writeLog(calendarList[1].display, "down" + this.height);
	
	if(undefined != this.display.childNodes[1])
	//�ı����ݸ߶�
	{		
		with(this.display.childNodes[1].style)
		{
			var tempHeight = this.height - calendarItemTitleHeight - 1;
			height = tempHeight > 0 ? tempHeight : 0;
		}
	}
	this._resetCalendarItemDisplayInfo(this);
}
CalendarItemSingleDay.prototype.modifyCalendarItem = function()
//�������鿴���༭ʱ���п����ճ���Ϣ�ѷ����ı䣬��Ҫ�������������ʾ��Ϣ
{
	var cursor = "default";

	var startDate = this.propertyXML.getElementsByTagName('startDate')[0].text;
	var startTime = this.propertyXML.getElementsByTagName('startTime')[0].text;
	var endDate = this.propertyXML.getElementsByTagName('endDate')[0].text;
	var endTime = this.propertyXML.getElementsByTagName('endTime')[0].text;
	
	var calendarItemType = getCalendarItemType(startDate, startTime, endDate, endTime);
		
	if(calendarItemType != this.calendarItemType)
	//���ͱ仯����һ���ڡ�����֮��ת��
	{
		return -1;	
	}
	else
	//�����ޱ仯
	{
		this.parseEditCalendarItemXML();  //��ֵ

		this._fillCalendarItemContent(this.display.firstChild, this.startTime);  //�������ڱ仯
		var itemName = this.itemName.replace(/</g,"&lt;");
		itemName = itemName.replace(/>/g,"&gt;");
		this.display.childNodes[1].firstChild.innerHTML = itemName;  //����ȥ�����壬�ı���
		this.display.setAttribute("title", this.display.childNodes[1].firstChild.innerText);  //title
		
		//����仯
		this._caculateCalendarItemCoordinates(this.display, "calendarTable");
		if(undefined != this.display.childNodes[1])
		//�ı����ݸ߶�
		{		
			with(this.display.childNodes[1].style)
			{
				var tempHeight = this.height - calendarItemTitleHeight - 1;
				height = tempHeight > 0 ? tempHeight : 0;
			}
		}
				
		this._decorateCalendarItemStyle(this.display, "absolute", "#ffffff", this.borderStyle, cursor);  //�������ʾ��ʽ
		if(this.shareLevel > 1)
		{
			cursor = "move";
		}
		this._decorateCalendarItemStyle(this.display.firstChild, "relative", this.color, "0", cursor);  //������ʽ
		if(this.shareLevel > 1)
		{
			cursor = "row-resize";
		}
		this._decorateCalendarItemStyle(this.display.lastChild, "absolute", this.color, "0", cursor);  //��������ʽ
	}
	this._resetCalendarItemDisplayInfo(this);
}
CalendarItemSingleDay.prototype.deleteCalendarItem = function()
//ɾ���ճ�
{
	this.transmitAsynchronous("deleteCalendarItem");
	
	this.deletePatch();
	calendarList[this.arrayId] = "0";
	
	//��calendarListSingleDay�������ɾ�����ճ�
	this._deleteCalendarFromItem(this);
}

CalendarItemSingleDay.prototype.overCalendarItem = function()
//����ճ�
{
	this.transmitAsynchronous("overCalendarItem");
	<%if("1".equals(overAvailable)){%>
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	this.setStatus("1");
	this.color ="<%=overColor%>" ;
	this.display.firstChild.style.backgroundColor = this.color;
	this.display.style.border = "1px solid " + this.color;
	this.display.lastChild.style.backgroundColor = this.color;
	
	//��д�ճ̵ı���
	var itemName = this.itemName + "(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)";
	itemName = "<A href='javascript:void(0)' onclick=viewCalendarSplash.createSplash(" + this.arrayId + ")>" + itemName + "</A>";
	this._fillCalendarItemContent(this.display.childNodes[1], itemName);
	<%
	}
	else
	{
	%>
	//�Ƴ�calendarList�еĶ�Ӧ�ճ�
	this.deletePatch();
	calendarList[this.arrayId] = "1";
	<%
	}
	%>
}
CalendarItemSingleDay.prototype.rebuildCalendarItemDisplay = function()
//��ҳ���С�仯ʱ�����¶�λ����
{
	this._caculateCalendarItemCoordinates(this.display, "calendarTable");
		
	calendarItemContentWidth = this.width;  //ÿ�񳤶�
	this._resetCalendarItemDisplayInfo(this);
}
CalendarItemSingleDay.prototype._drawCalendarItem = function()
//�����ճ���
{
	var cursor = "default";
	var calendarItemDisplay = document.createElement("div");
	//calendarItemDisplay.setAttribute("arrayId", this.arrayId);
	var title = this.itemName;
	title = title.replace(/&lt;/g,"<");
	title = title.replace(/&gt;/g,">");
	title = title.replace(/&nbsp;/g," ");
	title = title.replace(/&quot;/g,"\"");
	title = title.replace(/<br>/g,"\n");
	calendarItemDisplay.setAttribute("title", title);
	this._decorateCalendarItemStyle(calendarItemDisplay, "absolute", "#ffffff", this.borderStyle, cursor);
	this._caculateCalendarItemCoordinates(calendarItemDisplay, "calendarTable");
	//this._fillCalendarItemContent(calendarItemDisplay, this.itemName);
				
	return calendarItemDisplay;
}
CalendarItemSingleDay.prototype._drawCalendarItemTitle = function()
//�����ճ������
{
	var cursor = "default";
	var calendarItemTitle = document.createElement("div");
	
	if(this.shareLevel > 1)
	//���б༭Ȩ��ʱ�������϶�
	{
		calendarItemTitle.attachEvent("onmousedown", new Function("globalDragMoveDropActionSingleDay.startDrag()"));
		calendarItemTitle.attachEvent("onmousemove", new Function("globalDragMoveDropActionSingleDay.moving()"));
		calendarItemTitle.attachEvent("onmouseup", new Function("globalDragMoveDropActionSingleDay.stopDrag()"));
		cursor = "move";
	}

	this._decorateCalendarItemStyle(calendarItemTitle, "relative", this.color, "0", cursor);
	this._setCalendarItemElementCoordinates(calendarItemTitle, "100%", calendarItemTitleHeight);
	this._fillCalendarItemContent(calendarItemTitle, this.startTime);
	calendarItemTitle.style.overflowX = "hidden";
	return calendarItemTitle;
}
CalendarItemSingleDay.prototype._drawCalendarItemContent = function()
//�����ճ�������
{
	var cursor = "default";
	var itemName = this.itemName; 
	if(this.exchangeCount > 0)
	{
		itemName = "<B>" + itemName + "</B>"
	}
	itemName = itemName.replace(/</g,"&lt;");
	itemName = itemName.replace(/>/g,"&gt;");
	itemName = "<A href='javascript:void(0)' onclick=viewCalendarSplash.createSplash(" + this.arrayId + ")>" + itemName + "</A>";
	
	var calendarItemContent = document.createElement("div");
	var calendarItemContentHeigth = this.height - calendarItemTitleHeight - 1;
	calendarItemContentHeigth = calendarItemContentHeigth > 0 ? calendarItemContentHeigth : 0;  //��ֹС��0������
	//calendarItemContent.onclick = alertSample();
	this._decorateCalendarItemStyle(calendarItemContent, "relative", "#ffffff", "0", cursor);
	this._decorateCalendarItemWord(calendarItemContent, "normal");
	this._setCalendarItemElementCoordinates(calendarItemContent, "100%", calendarItemContentHeigth);
	this._fillCalendarItemContent(calendarItemContent, itemName);
	
	return calendarItemContent;
}
CalendarItemSingleDay.prototype._drawCalendarItemDrag = function()
//�����ճ����·���������
{
	var cursor = "default";
	var calendarItemDrag = document.createElement("div");
	var calendarItemDragHeigth = 1;

	if(this.shareLevel > 1)
	//���б༭Ȩ��ʱ�������϶�
	{
		calendarItemDrag.attachEvent("onmousedown", new Function("alterEndTimeActionSingleDay.startDrag()"));		
		cursor = "row-resize";
	}

	this._decorateCalendarItemStyle(calendarItemDrag, "absolute", this.color, "0", cursor);
	calendarItemDrag.style.fontSize = 1;
	this._setCalendarItemElementCoordinates(calendarItemDrag, "100%", calendarItemDragHeigth);

	return calendarItemDrag;
}
CalendarItemSingleDay.prototype._resetCalendarItemDisplayInfo = function(calendarItem)
{
	var le = calendarListSingleDay.length;
	var isHasSameItem = false;
	var tempInterrelateItem = new Array();
	if(le>0)
	{
		for(key in calendarListSingleDay)
		{
			var o = calendarListSingleDay[key];
			if(o.display)
			{
				if(o.startDate==calendarItem.startDate&&o.itemId!=calendarItem.itemId)
				{
					//calendarItem����ʱ�����o��ʼʱ��-����ʱ��
					if(calendarItem.endTime<=o.endTime&&calendarItem.endTime>o.startTime)
					{
						tempInterrelateItem.push(o);
						isHasSameItem = true;
					}
					//calendarItem��ȫ����o����ôλ��o����
					else if(calendarItem.endTime>o.endTime&&calendarItem.startTime<o.startTime)
					{
						tempInterrelateItem.push(o);
						isHasSameItem = true;
					}
					//calendarItem��ʼʱ�����o��ʼʱ��-����ʱ��
					else if(calendarItem.startTime<o.endTime&&calendarItem.startTime>=o.startTime)
					{
						tempInterrelateItem.push(o);
						isHasSameItem = true;
					}
				}
			}
			
		}
		if(isHasSameItem)
		{
			tempInterrelateItem.push(calendarItem);
		}
	}
	
	le = tempInterrelateItem.length;
	var perwidth = 1/le;
	var zindex = 1;
	if(le>0)
	{
		tempInterrelateItem = this._getMaxCalendarItem(tempInterrelateItem);
		for(var i =0;i<le;i++)
		{
			var max = tempInterrelateItem[i];
			max.display.style.zIndex = i;
			var width = max.width*(1-perwidth*i);
			var left = $(max.startDate + "," + floorTime(max.startTime)).offsetLeft;
			var miswidth = max.width-width;
			
			var left = left+miswidth;
			max.display.style.width = width+"px";
			max.display.style.left = left+"px";
		}
	}
}
CalendarItemSingleDay.prototype._getMaxCalendarItem = function(interrelateItem)
{
	var le = interrelateItem.length;
	var j = 1;
	var temp;
	if(le==1)
	{
		return interrelateItem;
	}
	while(j<le)
	{
		for(var i=0;i<le-j;i++)
		{
			//��ʼʱ��Խǰ����ô��item��ʾλ��Խ�ڵײ�
			if(interrelateItem[i].startTime>interrelateItem[i+1].startTime)
			{
				temp = interrelateItem[i+1];
				interrelateItem[i+1] = interrelateItem[i];
				interrelateItem[i] = temp;
			}
			//��ʼʱ����ͬ����ô��item�ĸ߶�Խ�ߣ���ʾλ��Խ�ڵײ�
			else if(interrelateItem[i].startTime==interrelateItem[i+1].startTime)
			{
				if(interrelateItem[i].display.style.posHeight<interrelateItem[i+1].display.style.posHeight)
				{
					temp = interrelateItem[i+1];
					interrelateItem[i+1] = interrelateItem[i];
					interrelateItem[i] = temp;
				}
				else if(interrelateItem[i].display.style.posHeight==interrelateItem[i+1].display.style.posHeight)
				{
					if(interrelateItem[i].itemId>interrelateItem[i+1].itemId)
					{
						temp = interrelateItem[i+1];
						interrelateItem[i+1] = interrelateItem[i];
						interrelateItem[i] = temp;
					}
				}
			}
			//��ʼʱ��Խ����ôλ�ñ��ֲ���
			else if(interrelateItem[i].startTime<interrelateItem[i+1].startTime)
			{
				
			}
		}
		j++;
	}
	return interrelateItem;
}
//��calendarListSingleDay�������ɾ�����ճ�
CalendarItemSingleDay.prototype._deleteCalendarFromItem = function(calendarItem)
{
	var len = calendarListSingleDay.length;
	for(var i =0;i<len;i++)
	{
		var o = calendarListSingleDay[i];
		if(o.itemId==calendarItem.itemId)
		{
			calendarListSingleDay.splice(i,1);
			return;
		}
	}
}
CalendarItemSingleDay.prototype._decorateCalendarItemStyle = function(pCalendarItemElement, pPosition, pBackgroundColor, pBorder, pCursor)
{	
	with(pCalendarItemElement.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		border = pBorder;
		cursor = pCursor;
	}
}
CalendarItemSingleDay.prototype._decorateCalendarItemWord = function(pCalendarItemElement, pWhiteSpace)
{	
	with(pCalendarItemElement.style)
	{
		overflow = "hidden";
		whiteSpace = pWhiteSpace;
		wordWrap = "break-word";
	}
}
CalendarItemSingleDay.prototype._caculateCalendarItemCoordinates = function(pCalendarItemDisplay, pElementItemId)
//�����ճ�����ʾ����
{
	var parameterStartDate = this.startDate;
	var parameterStartTime = "" != this.startTime ? this.startTime : "00:00";
	var parameterEndDate = "" != this.endDate ? this.endDate : parameterStartDate;
	var parameterEndTime = "" != this.endTime ? this.endTime : "23:59";

	this.minuteDifference = dateTimeDifference(parameterStartDate, parameterStartTime, parameterEndDate, parameterEndTime);
	
	this.width = ($(pElementItemId).offsetWidth - timeTitleWidth) / countDays;
	this.height = this.minuteDifference * perMinuteHeight;

	with(pCalendarItemDisplay.style)
	{
		width = this.width;
		height = this.height;

		top = <%=addTopSpaceStr%>$(this.startDate + "," + floorTime(this.startTime)).offsetTop + timeDifference(floorTime(this.startTime), this.startTime) * perMinuteHeight;
		left = $(this.startDate + "," + floorTime(this.startTime)).offsetLeft;
	}
}
CalendarItemSingleDay.prototype._setCalendarItemElementCoordinates = function(pCalendarItemElement, pWidth, pHeight)
//�����ճ�����Ԫ����ʾ����
{
	with(pCalendarItemElement.style)
	{							
		width = pWidth;
		height = pHeight;
	}
}
CalendarItemSingleDay.prototype._fillCalendarItemContent = function(pCalendarItemElement, itemName)
//���ճ����������ʾ��Ϣ
{
	pCalendarItemElement.innerHTML = itemName;
}
CalendarItemSingleDay.prototype.parseAddCalendarItemXML = function(responseXML)
{
	var color = this.propertyXML.getElementsByTagName('color')[0].text;
	this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setColor(color);
	this.setStartTime(this.propertyXML.getElementsByTagName('starttime')[0].text);
	this.setBorderStyle("1px solid " + color);
	
	this.outputAddCalendar();
}
CalendarItemSingleDay.prototype.outputAddCalendar = function()
{	
	fillCalendarList(this);  //����Array
	initArrayIdOfCalendarList();  //��ʼArray��Id
	this.buildPatch();  //������س�ʼֵ����ʾ
	initArrayIdOfDisplay();

	//��֯һ������ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i] && "1" == calendarList[i].calendarItemType)
		{
			calendarList[i].alterCalendarItem();
		}
	}
}
CalendarItemSingleDay.prototype.parseEditCalendarItemXML = function()
{
	this.setType(this.propertyXML.getElementsByTagName('type')[0].text);
	//this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setItemName(this.propertyXML.getElementsByTagName('itemName')[0].text);
	this.setColor(this.propertyXML.getElementsByTagName('color')[0].text);
	this.setUrgent(this.propertyXML.getElementsByTagName('urgent')[0].text);
	this.setRemindType(this.propertyXML.getElementsByTagName('remindType')[0].text);
	this.setRemindBeforeStart(this.propertyXML.getElementsByTagName('remindBeforeStart')[0].text);
	this.setRemindBeforeStartMinute(this.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text);
	this.setRemindBeforeEnd(this.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text);
	this.setRemindBeforeEndMinute(this.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text);
	this.setExecuteId(this.propertyXML.getElementsByTagName('executeId')[0].text);
	this.setStartDate(this.propertyXML.getElementsByTagName('startDate')[0].text);
	this.setStartTime(this.propertyXML.getElementsByTagName('startTime')[0].text);
	this.setEndDate(this.propertyXML.getElementsByTagName('endDate')[0].text);
	this.setEndTime(this.propertyXML.getElementsByTagName('endTime')[0].text);
	this.setDescription(this.propertyXML.getElementsByTagName('description')[0].text);
	
	this.setRelatedCustomer(this.propertyXML.getElementsByTagName('relatedCustomer')[0].text);
	this.setRelatedDocument(this.propertyXML.getElementsByTagName('relatedDocument')[0].text);
	this.setRelatedProject(this.propertyXML.getElementsByTagName('relatedProject')[0].text);
	this.setRelatedWorkFlow(this.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text);
	this.setRelatedTask(this.propertyXML.getElementsByTagName('relatedTask')[0].text);
	this.setRelatedMeeting(this.propertyXML.getElementsByTagName('relatedMeeting')[0].text);
	
	this.setStatus(this.propertyXML.getElementsByTagName('status')[0].text);
	this.setShareLevel(this.propertyXML.getElementsByTagName('shareLevel')[0].text);
	this.setExchangeCount(this.propertyXML.getElementsByTagName('exchangeCount')[0].text);
	
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	if(this.status==1)
	{
		this.color ="<%=overColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)"
	}
	else if(this.status==2)
	{
		this.color ="<%=archiveColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(18800,user.getLanguage())%>)";
	}
	this.setBorderStyle("1px solid " + this.color);
}
CalendarItemSingleDay.prototype.decorateCalendarItemBorderStyle = function(pBorderStyle)
{
	this.display.style.border = pBorderStyle;
}



/*============ �����ճ� ============*/
function CalendarItemMultiDay(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount)
{
	this.arrayIndex;  //��ʾ��ʶ�����±�
	CalendarItem.apply(this, new Array(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount, "1px solid #FFFFFF"));
}
CalendarItemMultiDay.prototype = new CalendarItem();
CalendarItemMultiDay.prototype.buildPatch = function()
{
	this.display = this._drawCalendarItem();	
	//�������ճ̷������ճ�ͷ��DIV��
	var topcontainerwk = document.getElementById("topcontainerwk");
	topcontainerwk.appendChild(this.display);

	this.display.appendChild(this._drawCalendarItemTitle());
	//this.display.appendChild(this._drawCalendarItemContent());
}
CalendarItemMultiDay.prototype.alterCalendarItem = function()
//�϶��ճ���ʱ���������������ʾ��Ϣ
{	
	//this._fillCalendarItemContent(this.display.firstChild, this.startTime);
	
	//���¶�����calendarHeadTableΪ�ճ�ͷ��table
	this._caculateCalendarItemCoordinates(this.display, "calendarHeadTable");	
	//writeLog(calendarList[1].display, "down" + this.height);
}
CalendarItemMultiDay.prototype.modifyCalendarItem = function()
//�������鿴���༭ʱ���п����ճ���Ϣ�ѷ����ı䣬��Ҫ�������������ʾ��Ϣ
{
	var cursor = "default";

	var startDate = this.propertyXML.getElementsByTagName('startDate')[0].text;
	var startTime = this.propertyXML.getElementsByTagName('startTime')[0].text;
	var endDate = this.propertyXML.getElementsByTagName('endDate')[0].text;
	var endTime = this.propertyXML.getElementsByTagName('endTime')[0].text;
	
	var calendarItemType = getCalendarItemType(startDate, startTime, endDate, endTime);

	if(calendarItemType != this.calendarItemType)
	//���ͱ仯����һ���ڡ�����֮��ת��
	{
		return -1;	
	}
	else
	//�����ޱ仯
	{
		this.parseEditCalendarItemXML();  //��ֵ

		var itemName = this.itemName;
        itemName = itemName.replace(/</g,"&lt;");
        itemName = itemName.replace(/>/g,"&gt;");
        var title = this.itemName;
	    title = title.replace(/&lt;/g,"<");
	    title = title.replace(/&gt;/g,">");
	    title = title.replace(/&nbsp;/g," ");
	    title = title.replace(/&quot;/g,"\"");
	    title = title.replace(/<br>/g,"\n");
		this.display.firstChild.getElementsByTagName("A")[0].innerHTML = itemName;  //����ȥ�����壬�ı���
		this.display.setAttribute("title", this.display.firstChild.getElementsByTagName("A")[0].innerText);  //title

		this._decorateCalendarItemStyle(this.display, "absolute", this.color, this.borderStyle, cursor);  //�������ʾ��ʽ
		if(this.shareLevel > 1)
		{
			cursor = "move";
		}
		this._decorateCalendarItemStyle(this.display.firstChild, "relative", this.color, "0", cursor);  //������ʽ

		//�޸���ʾ
		adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);  //������ʾ��¼�������

		for(var i = 0; i < calendarList.length; i++)
		{
			if("0" != calendarList[i] && "2" == calendarList[i].calendarItemType)
			{
				calendarList[i].alterCalendarItem();
			}
		}

		rebuildCalendarItemSingleDay();  //����һ�����ճ���ʾ
	}
}
CalendarItemMultiDay.prototype.deleteCalendarItem = function()
//ɾ���ճ�
{	
	this.transmitAsynchronous("deleteCalendarItem");
	
	this.deletePatch();
	calendarList[this.arrayId] = "0";
	
	//�޸���ʾ
	adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);  //������ʾ��¼�������

	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i] && "2" == calendarList[i].calendarItemType)
		{
			calendarList[i].alterCalendarItem();
		}
	}

	rebuildCalendarItemSingleDay();  //����һ�����ճ���ʾ
}

CalendarItemMultiDay.prototype.overCalendarItem = function()
//����ճ�
{	
	this.transmitAsynchronous("overCalendarItem");
	<%if("1".equals(overAvailable)){%>
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	this.setStatus("1");
	this.color ="<%=overColor%>" ;
	this.display.firstChild.style.backgroundColor = this.color;
	this.display.style.border = "1px solid " + this.color;
	this.display.lastChild.style.backgroundColor = this.color;
	
	//��д�ճ̵ı���
	var itemName =this.itemName + "(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)";
	var newtitle = "<A href='javascript:void(0)' onclick=viewCalendarSplash.createSplash(" + this.arrayId + ")>" + itemName + "</A>";
	newtitle = this.startTime + "��" + newtitle  + "��";
	this._fillCalendarItemContent(this.display.childNodes[0], newtitle);
	<%
	}
	else
	{
	%>
	//�Ƴ�calendarList�еĶ�Ӧ�ճ�
	this.deletePatch();
	calendarList[this.arrayId] = "0";
	
	//�޸���ʾ
	adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);  //������ʾ��¼�������

	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i] && "2" == calendarList[i].calendarItemType)
		{
			calendarList[i].alterCalendarItem();
		}
	}
	<%}%>

	rebuildCalendarItemSingleDay();  //����һ�����ճ���ʾ
}
CalendarItemMultiDay.prototype.deletePatch = function()
//
{	
	this.display.removeNode(true);
}
CalendarItemMultiDay.prototype.rebuildCalendarItemDisplay = function()
//��ҳ���С�仯ʱ�����¶�λ����
{
	//���¶�����calendarHeadTableΪ�ճ�ͷ��table
	this._caculateCalendarItemCoordinates(this.display, "calendarHeadTable");
	
	calendarItemContentWidth = this.width;  //ÿ�񳤶�
}
CalendarItemMultiDay.prototype._drawCalendarItem = function()
//���ɿ����ճ���
{
	var cursor = "default";
	var calendarItemDisplay = document.createElement("div");
	//calendarItemDisplay.setAttribute("arrayId", this.arrayId);
	var title = this.itemName;
	title = title.replace(/&lt;/g,"<");
	title = title.replace(/&gt;/g,">");
	title = title.replace(/&nbsp;/g," ");
	title = title.replace(/&quot;/g,"\"");
	title = title.replace(/<br>/g,"\n");
	calendarItemDisplay.setAttribute("title", title);

	this._decorateCalendarItemStyle(calendarItemDisplay, "absolute", this.color, this.borderStyle, cursor);
	//���¶�����calendarHeadTableΪ�ճ�ͷ��table
	this._caculateCalendarItemCoordinates(calendarItemDisplay, "calendarHeadTable");			
	
	return calendarItemDisplay;
}
CalendarItemMultiDay.prototype._drawCalendarItemTitle = function()
//�����ճ������
{
	var cursor = "default";
	var itemName = this.itemName; 
	if(this.exchangeCount > 0)
	{
		itemName = "<B>" + itemName + "</B>"
	}
	itemName = "<A href='javascript:void(0)' onclick=viewCalendarSplash.createSplash(" + this.arrayId + ")>" + itemName + "</A>";
		
	var calendarItemTitle = document.createElement("div");
	
	if(this.shareLevel > 1)
	//���б༭Ȩ��ʱ�������϶�
	{
		calendarItemTitle.attachEvent("onmousedown", new Function("globalDragMoveDropActionMultiDay.startDrag()"));
		calendarItemTitle.attachEvent("onmousemove", new Function("globalDragMoveDropActionMultiDay.moving()"));
		calendarItemTitle.attachEvent("onmouseup", new Function("globalDragMoveDropActionMultiDay.stopDrag()"));
		cursor = "move";
	}

	this._decorateCalendarItemStyle(calendarItemTitle, "relative", this.color, "0", cursor);
	this._decorateCalendarItemWord(calendarItemTitle, "nowrap");
	this._setCalendarItemElementCoordinates(calendarItemTitle, "100%", calendarItemTitleHeight);
	this._fillCalendarItemContent(calendarItemTitle, this.startTime + "��" + itemName + "��");
	//��������title
	this.display.setAttribute("title", calendarItemTitle.innerText);
	
	return calendarItemTitle;
}
CalendarItemMultiDay.prototype._drawCalendarItemContent = function()
//�����ճ�������
{
	var cursor = "default";
	var calendarItemContent = document.createElement("div");	
	//calendarItemContent.onclick = alertSample();
	this._decorateCalendarItemStyle(calendarItemContent, "relative", "#ffffff", "0", cursor);
	this._setCalendarItemElementCoordinates(calendarItemContent, "100%", this.height - calendarItemTitleHeight - 1);
	this._fillCalendarItemContent(calendarItemContent, this.itemName);
	
	return calendarItemContent;
}
CalendarItemMultiDay.prototype._decorateCalendarItemStyle = function(pCalendarItemElement, pPosition, pBackgroundColor, pBorder, pCursor)
//
{	
	with(pCalendarItemElement.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		border = pBorder;
		cursor = pCursor;
	}
}
CalendarItemMultiDay.prototype._decorateCalendarItemWord = function(pCalendarItemElement, pWhiteSpace)
{	
	with(pCalendarItemElement.style)
	{
		overflow = "hidden";
		whiteSpace = pWhiteSpace;
		wordWrap = "break-word";
	}
}
CalendarItemMultiDay.prototype._caculateCalendarItemCoordinates = function(pCalendarItemDisplay, pElementItemId)
//�����ճ�����ʾ����(�����������������ʼʱ�䲻�ڵ�ǰҳ������ʱ�䲻�ڵ�ǰҳ���޽����������)
{
	var parameterStartDate = this.startDate;
	var parameterStartTime = "00:00";
	var parameterEndDate = this.endDate;
	var parameterEndTime = "23:59";
	
	parameterStartDate = parameterStartDate < beginDateOfTable ? beginDateOfTable : parameterStartDate;  //�����ʼ���ڱ���ʾ��һ��С������ʾ��Ϊ��һ��
	var parameterMinuteDifference;

	if("" != parameterEndDate)
	//���н�������ʱ
	{
		parameterMinuteDifference = dateTimeDifference(parameterStartDate, parameterStartTime, parameterEndDate, parameterEndTime);
		this.minuteDifference = dateTimeDifference(this.startDate, parameterStartTime, parameterEndDate, parameterEndTime);
	}
	else
	//����������Ϊ��ʱ
	{
		parameterMinuteDifference = daysOfWeek * 24 * 60;
		this.minuteDifference = daysOfWeek * 24 * 60;  //ȡ����ʾ���ֵ 
	}
	var cellWidth = ($(pElementItemId).offsetWidth - timeTitleWidth) / countDays;
	var daysCount = parameterMinuteDifference / (60 * 24);	

	this.arrayIndex = adjustMultiDayDisplayAction.addFlagArray($(parameterStartDate).getAttribute("indexId"), daysCount);
	if(multiDayCalendarItemHeight * (this.arrayIndex + 1) + multiDayBlankAreaHeight > multiDayCalendarAreaHeight)
	//��������ʾ�����޿ռ���ʾʱ
	{
		multiDayCalendarAreaHeight += multiDayCalendarItemHeight;
		$(parameterStartDate).style.height = multiDayCalendarAreaHeight;  //�ı������ʾ����߶�
		topHeightOfDays = calendarTitleHeight + multiDayCalendarAreaHeight;  //���ö����߶ȣ�������
	}
	//�����¿��ʹ����border��������Ҫ��ȥborder�Ŀ��
	this.width = Math.floor((cellWidth) * daysCount)-daysCount*2;
	this.height = multiDayCalendarItemHeight;


	with(pCalendarItemDisplay.style)
	{
		width = this.width + $(parameterStartDate).offsetLeft > $(pElementItemId).offsetWidth ? $(pElementItemId).offsetWidth - $(parameterStartDate).offsetLeft : this.width;  //���ܽ���ʱ�䲻�ڵ�ǰҳ
		height = this.height;
		top = <%=addTopSpaceStr%>$(parameterStartDate).offsetTop + (this.arrayIndex * multiDayCalendarItemHeight);
		//�����¿��ʹ����border�������ճ̵�λ����Ҫ����ƶ�һ�����
		left = $(parameterStartDate).offsetLeft+9;
	}	
}
CalendarItemMultiDay.prototype._setCalendarItemElementCoordinates = function(pCalendarItemElement, pWidth, pHeight)
//�����ճ�����Ԫ����ʾ����
{
	with(pCalendarItemElement.style)
	{							
		width = pWidth;
		height = pHeight;
	}
}
CalendarItemMultiDay.prototype._fillCalendarItemContent = function(pCalendarItemElement, itemName)
//���ճ����������ʾ��Ϣ
{
	pCalendarItemElement.innerHTML = itemName;
}
CalendarItemMultiDay.prototype.parseAddCalendarItemXML = function(responseXML)
{
	this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setColor(this.propertyXML.getElementsByTagName('color')[0].text);
	this.setStartTime(this.propertyXML.getElementsByTagName('starttime')[0].text);	
		
	this.outputAddCalendar();
}
CalendarItemMultiDay.prototype.outputAddCalendar = function()
{
	fillCalendarList(this);  //����Array
	initArrayIdOfCalendarList();  //��ʼArray��Id
	this.buildPatch();  //������س�ʼֵ����ʾ
	initArrayIdOfDisplay();
	
	/*
	 * ������֯������ʾ
	 */
	adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);
		
	//��֯��ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i] && "2" == calendarList[i].calendarItemType)
		{
			calendarList[i].alterCalendarItem();
		}
	}
	
	rebuildCalendarItemSingleDay();  //����һ�����ճ���ʾ
	resetScrollTimedEventSwk();
}
CalendarItemMultiDay.prototype.parseEditCalendarItemXML = function()
{
	this.setType(this.propertyXML.getElementsByTagName('type')[0].text);
	this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setItemName(this.propertyXML.getElementsByTagName('planName')[0].text);
	this.setColor(this.propertyXML.getElementsByTagName('color')[0].text);
	this.setUrgent(this.propertyXML.getElementsByTagName('urgent')[0].text);
	this.setRemindType(this.propertyXML.getElementsByTagName('remindType')[0].text);
	this.setRemindBeforeStart(this.propertyXML.getElementsByTagName('remindBeforeStart')[0].text);
	this.setRemindBeforeStartMinute(this.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text);
	this.setRemindBeforeEnd(this.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text);
	this.setRemindBeforeEndMinute(this.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text);
	this.setExecuteId(this.propertyXML.getElementsByTagName('executeId')[0].text);
	this.setStartDate(this.propertyXML.getElementsByTagName('startDate')[0].text);
	this.setStartTime(this.propertyXML.getElementsByTagName('startTime')[0].text);
	this.setEndDate(this.propertyXML.getElementsByTagName('endDate')[0].text);
	this.setEndTime(this.propertyXML.getElementsByTagName('endTime')[0].text);
	this.setDescription(this.propertyXML.getElementsByTagName('description')[0].text);
	
	this.setRelatedCustomer(this.propertyXML.getElementsByTagName('relatedCustomer')[0].text);
	this.setRelatedDocument(this.propertyXML.getElementsByTagName('relatedDocument')[0].text);
	this.setRelatedProject(this.propertyXML.getElementsByTagName('relatedProject')[0].text);
	this.setRelatedWorkFlow(this.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text);
	this.setRelatedTask(this.propertyXML.getElementsByTagName('relatedTask')[0].text);
	this.setRelatedMeeting(this.propertyXML.getElementsByTagName('relatedMeeting')[0].text);
	this.setStatus(this.propertyXML.getElementsByTagName('status')[0].text);
	this.setShareLevel(this.propertyXML.getElementsByTagName('shareLevel')[0].text);
	this.setExchangeCount(this.propertyXML.getElementsByTagName('exchangeCount')[0].text);
	
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	if(this.status==1)
	{
		this.color ="<%=overColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)"
	}
	else if(this.status==2)
	{
		this.color ="<%=archiveColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(18800,user.getLanguage())%>)";
	}
	//this.setBorderStyle("1px solid #FFFFFF");
}
CalendarItemMultiDay.prototype.decorateCalendarItemBorderStyle = function(pBorderStyle)
{
	this.display.style.border = pBorderStyle;
}



/*============ ����ʾ�ճ� ============*/
function CalendarItemOfMonth(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount)
{
	CalendarItem.apply(this, new Array(arrayId, calendarItemType, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount, "1px solid #FFFFFF"));
	this.display = new Array();

	this.offsetDay;  //������ʾ��һ��������� view
	this.daysCount;  //��ʾ������view
	this.parameterStartDate;  //view
	this.parameterMinuteDifference;  //view
	this.firstCellOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ʼcell view
	this.arrayIndexOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ռ�õ���ʾ��
	this.beginDayOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ʾ�ĵ�һ�� view
	this.daysCountOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row����ʾ���� view
}
CalendarItemOfMonth.prototype = new CalendarItem();
CalendarItemOfMonth.prototype.reset = function()
{
	this.display = new Array();
	this.offsetDay = 0;  //������ʾ��һ��������� view
	this.daysCount = 0;  //��ʾ������view
	this.parameterStartDate = "";  //view
	this.parameterMinuteDifference = 0;  //view
	this.firstCellOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ʼcell view
	this.arrayIndexOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ռ�õ���ʾ��
	this.beginDayOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row��ʾ�ĵ�һ�� view
	this.daysCountOfRowArray = new Array();  //ÿ��display����Ԫ�ض�Ӧ��row����ʾ���� view
}
CalendarItemOfMonth.prototype.buildPatch = function()
{
	this._caculateCalendarItemSippet();	  //������Ҫ����ر�������
	this._drawCalendarItem();  //������ʾ�������Ϣ

	for(var i = 0; i < this.display.length; i++)
	//����ʾ������ҳ����
	{
		var displayItem = this.display[i];
		
		if(this.daysCountOfRowArray[i] > 0)
		//��ʾ��ҳ����
		{
			document.body.appendChild(displayItem);
			displayItem.appendChild(this._drawCalendarItemTitle());
			//displayItem.appendChild(this._drawCalendarItemContent());
		}
		else
		{
			var daysCountRow = -1 * this.daysCountOfRowArray[i];
			var cell = this.firstCellOfRowArray[i];
					
			if(cell <= this.offsetDay)
			//��ʼʱ����cell�ұ�
			{
				var finalDateCell = this.parameterStartDate;
				
				for(var j = 0; j < daysCountRow; j++)
				{
					$(finalDateCell + ",more").innerHTML = "<A href='#' onclick='changeToDayTimeView(\"" + finalDateCell + "\")'>more</A>";
					var finalDate = dateTimeAdd(finalDateCell, "00:00", 24 * 60);
					finalDateCell = finalDate.getYear().toString() + "-" + formatSingleDateTime(finalDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(finalDate.getDate()).toString();								
				}
			}
			else
			//��ʼʱ������������
			{
				var finalDate = dateTimeAdd(beginDateOfTable, "00:00", cell * 24 * 60);
				var finalDateCell = finalDate.getYear().toString() + "-" + formatSingleDateTime(finalDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(finalDate.getDate()).toString();			
			
				for(var j = 0; j < daysCountRow; j++)
				{
					$(finalDateCell + ",more").innerHTML = "<A href='#' onclick='changeToDayTimeView(\"" + finalDateCell + "\")'>more</A>";
					var finalDate = dateTimeAdd(finalDateCell, "00:00", 24 * 60);
					finalDateCell = finalDate.getYear().toString() + "-" + formatSingleDateTime(finalDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(finalDate.getDate()).toString();								
				}				
			}
		}		
	}	
}
CalendarItemOfMonth.prototype.alterCalendarItem = function()
//�϶��ճ���ʱ���������������ʾ��Ϣ
{
	this.deletePatch();
	this.reset();
	this.buildPatch();
}
CalendarItemOfMonth.prototype.modifyCalendarItem = function()
//�������鿴���༭ʱ���п����ճ���Ϣ�ѷ����ı䣬��Ҫ�������������ʾ��Ϣ
{
	this.parseEditCalendarItemXML();  //��ֵ

	//�޸���ʾ
	adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);  //������ʾ��¼�������
	
	//���more
	var date = new Date(beginYearOfTable, beginMonthOfTable - 1, beginDayOfTable);
	for(var i = 0; i < showDaysOfMonth; i++)
	{
		var dateString = date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString();

		$(dateString + ",more").innerHTML = "";
		date.setDate(date.getDate() + 1);
	}
	
	//��֯��ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].alterCalendarItem();
		}
	}
	
	return;
}
CalendarItemOfMonth.prototype.deleteCalendarItem = function()
//ɾ���ճ�
{	
	this.transmitAsynchronous("deleteCalendarItem");
	
	this.deletePatch();
	calendarList[this.arrayId] = "0";
	
	//�޸���ʾ
	adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);  //������ʾ��¼�������
	
	//���more
	var date = new Date(beginYearOfTable, beginMonthOfTable - 1, beginDayOfTable);
	for(var i = 0; i < showDaysOfMonth; i++)
	{
			var dateString = date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString();

		$(dateString + ",more").innerHTML = "";
		date.setDate(date.getDate() + 1);
	}
	
	//��֯��ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].alterCalendarItem();
		}
	}
}
CalendarItemOfMonth.prototype.deletePatch = function()
{
	for(var i = 0; i < this.display.length; i++)
	{
		this.display[i].removeNode(true);
	}
}
CalendarItemOfMonth.prototype.rebuildCalendarItemDisplay = function()
//��ҳ���С�仯ʱ�����¶�λ����
{
	for(var i = 0; i < this.display.length; i++)
	{
		var displayItem = this.display[i];
		//���·��ճ���ʾ���ճ�ͷ�������
		this._caculateCalendarItemCoordinates(displayItem, "calendarHeadTable", this.firstCellOfRowArray[i]);
	}
		
	calendarItemContentWidth = this.width;  //ÿ�񳤶�
}
CalendarItemOfMonth.prototype._drawCalendarItem = function()
//�����ճ���
{
	var cursor = "default";

	for(var i = Math.floor(this.offsetDay / daysOfWeek) * daysOfWeek; i < this.offsetDay + this.daysCount && i < showDaysOfMonth; i += daysOfWeek)
	{
		var calendarItemDisplay = document.createElement("div");
		calendarItemDisplay.setAttribute("arrayId", this.arrayId);
		var title = this.itemName;
	    title = title.replace(/&lt;/g,"<");
	    title = title.replace(/&gt;/g,">");
	    title = title.replace(/&nbsp;/g," ");
	    title = title.replace(/&quot;/g,"\"");
	    title = title.replace(/<br>/g,"\n");
	    calendarItemDisplay.setAttribute("title", title);
		this._decorateCalendarItemStyle(calendarItemDisplay, "absolute", this.color, this.borderStyle, cursor);
		//���·��ճ���ʾ���ճ�ͷ�������
		this._caculateCalendarItemCoordinates(calendarItemDisplay, "calendarHeadTable", i);
		this.display.push(calendarItemDisplay);
		this.firstCellOfRowArray.push(i);
	}
}
CalendarItemOfMonth.prototype._drawCalendarItemTitle = function()
//�����ճ������111
{
	var cursor = "default";
	var itemName = this.itemName; 
	if(this.exchangeCount > 0)
	{
		itemName = "<B>" + itemName + "</B>"
	}

	itemName = "<A href='javascript:void(0)' onclick=viewCalendarSplash.createSplash(" + this.arrayId + ")>" + itemName + "</A>";
	
	var calendarItemTitle = document.createElement("div");
	
	if(this.shareLevel > 1)
	//���б༭Ȩ��ʱ�������϶�
	{
		calendarItemTitle.attachEvent("onmousedown", new Function("globalDragMoveDropActionMonth.startDrag()"));
		calendarItemTitle.attachEvent("onmousemove", new Function("globalDragMoveDropActionMonth.moving()"));
		calendarItemTitle.attachEvent("onmouseup", new Function("globalDragMoveDropActionMonth.stopDrag()"));
		cursor = "move";
	}

	this._decorateCalendarItemStyle(calendarItemTitle, "relative", this.color, "0", cursor);
	this._decorateCalendarItemWord(calendarItemTitle, "nowrap");
	this._setCalendarItemElementCoordinates(calendarItemTitle, "100%", calendarItemTitleHeight);
	this._fillCalendarItemContent(calendarItemTitle, this.startTime + "��" + itemName + "��");
	
	return calendarItemTitle;
}
CalendarItemOfMonth.prototype._drawCalendarItemContent = function()
//�����ճ�������
{
	var cursor = "default";
	var calendarItemContent = document.createElement("div");	
	//calendarItemContent.onclick = alertSample();
	this._decorateCalendarItemStyle(calendarItemContent, "relative", "#ffffff", "0", cursor);
	this._setCalendarItemElementCoordinates(calendarItemContent, "100%", this.height - calendarItemTitleHeight - 1);
	this._fillCalendarItemContent(calendarItemContent, this.itemName);
	
	return calendarItemContent;
}
CalendarItemOfMonth.prototype._decorateCalendarItemStyle = function(pCalendarItemElement, pPosition, pBackgroundColor, pBorder, pCursor)
//������ʽ
{
	with(pCalendarItemElement.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		border = pBorder;
		cursor = pCursor;
	}
}
CalendarItemOfMonth.prototype._decorateCalendarItemWord = function(pCalendarItemElement, pWhiteSpace)
{	
	with(pCalendarItemElement.style)
	{
		overflow = "hidden";
		whiteSpace = pWhiteSpace;
		wordWrap = "break-word";
	}
}
CalendarItemOfMonth.prototype._caculateCalendarItemSippet = function()
{
	var parameterStartDate = this.startDate;
	var parameterStartTime = "00:00";
	var parameterEndDate = this.endDate;
	var parameterEndTime = "23:59";
	
	this.parameterStartDate = parameterStartDate < beginDateOfTable ? beginDateOfTable : parameterStartDate;  //�����ʼ���ڱ���ʾ��һ��С������ʾ��Ϊ��һ��

	if("" != parameterEndDate)
	//���н�������ʱ
	{
		this.parameterMinuteDifference = dateTimeDifference(this.parameterStartDate, parameterStartTime, parameterEndDate, parameterEndTime);
		this.minuteDifference = dateTimeDifference(this.startDate, parameterStartTime, parameterEndDate, parameterEndTime);
	}
	else
	//����������Ϊ��ʱ
	{
		this.parameterMinuteDifference = showDaysOfMonth * 24 * 60;
		this.minuteDifference = showDaysOfMonth * 24 * 60;  //ȡ����ʾ���ֵ 
	}

	this.daysCount = this.parameterMinuteDifference / (60 * 24);	//��ʾ������
	this.offsetDay = Math.floor(dateTimeDifference(beginDateOfTable, "00:00", this.parameterStartDate, "23:59") / (60 * 24)); //������ʾ��һ���������
}
CalendarItemOfMonth.prototype._caculateCalendarItemCoordinates = function(pCalendarItemDisplay, pElementItemId, cell)
//�����ճ�����ʾ����(�����������������ʼʱ�䲻�ڵ�ǰҳ������ʱ�䲻�ڵ�ǰҳ���޽����������)111
{
	var displayStartDate = this.parameterStartDate;
	var cellWidth = $(pElementItemId).offsetWidth / daysOfWeek;  //cell��� = table��� / һ��cell�� 
	var daysCountRow;
	
	if(cell <= this.offsetDay)
	//��һ��
	{
		if(this.offsetDay + this.daysCount <= cell + daysOfWeek)
		//�ڸ��н���
		{
			daysCountRow = this.daysCount;
		}
		else
		{
			daysCountRow = daysOfWeek - (this.offsetDay % daysOfWeek);
		}
	}
	else
	//����ռ��������
	{
		var finalDate = dateTimeAdd(beginDateOfTable, "00:00", cell * 24 * 60);
		displayStartDate = finalDate.getYear().toString() + "-" + formatSingleDateTime(finalDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(finalDate.getDate()).toString();
		
		if(this.offsetDay + this.daysCount <= cell + daysOfWeek)
		//�ڸ��н���
		{
			daysCountRow = this.offsetDay + this.daysCount - cell;			
		}
		else
		{
			daysCountRow = daysOfWeek;
		}
	}

	var arrayIndex = adjustMonthDisplayAction.addFlagArray($(displayStartDate).getAttribute("indexId"), daysCountRow);

	this.width = Math.floor((cellWidth) * daysCountRow);
	this.height = calendarItemHeightMonth;
	
	if(-1 != arrayIndex)
	//��ʾ��Ϣ
	{
		this.arrayIndexOfRowArray.push(arrayIndex);
		this.beginDayOfRowArray.push(displayStartDate);
		this.daysCountOfRowArray.push(daysCountRow);
		
		with(pCalendarItemDisplay.style)
		{
			width = this.width;
			height = this.height;
			top = <%=addTopSpaceStr%>$(displayStartDate).offsetTop + calendarDateTitleHeightMonth + (arrayIndex * calendarItemHeightMonth);
			//�����¿��ʹ����border�������ճ̵�λ����Ҫ����ƶ�һ�����
			left = $(displayStartDate).offsetLeft+9;
		}
	}
	else
	//��ʾmore
	{
		this.arrayIndexOfRowArray.push(-1);
		this.beginDayOfRowArray.push(displayStartDate);
		this.daysCountOfRowArray.push(-1 * daysCountRow);
	}
}
CalendarItemOfMonth.prototype._setCalendarItemElementCoordinates = function(pCalendarItemElement, pWidth, pHeight)
//�����ճ�����Ԫ����ʾ����
{
	with(pCalendarItemElement.style)
	{							
		width = pWidth;
		height = pHeight;
	}
}
CalendarItemOfMonth.prototype._fillCalendarItemContent = function(pCalendarItemElement, itemName)
//���ճ����������ʾ��Ϣ
{
	pCalendarItemElement.innerHTML = itemName;
}
CalendarItemOfMonth.prototype.parseAddCalendarItemXML = function(responseXML)
{
	this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setColor(this.propertyXML.getElementsByTagName('color')[0].text);
	this.setStartTime(this.propertyXML.getElementsByTagName('starttime')[0].text);
			
	this.outputAddCalendar();
}
CalendarItemOfMonth.prototype.outputAddCalendar = function()
{
	fillCalendarList(this);  //����Array
	initArrayIdOfCalendarList();  //��ʼArray��Id
	this.buildPatch();  //������س�ʼֵ����ʾ
	initArrayIdOfDisplay();
	
	/*
	 * ������֯������ʾ
	 */
	adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);
	
	//���more
	var date = new Date(beginYearOfTable, beginMonthOfTable - 1, beginDayOfTable);
	for(var i = 0; i < showDaysOfMonth; i++)
	{
		var dateString = date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString();

		$(dateString + ",more").innerHTML = "";
		date.setDate(date.getDate() + 1);
	}

	//��֯��ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].alterCalendarItem();
		}
	}
}
CalendarItemOfMonth.prototype.parseEditCalendarItemXML = function()
{
	this.setType(this.propertyXML.getElementsByTagName('type')[0].text);
	this.setItemId(this.propertyXML.getElementsByTagName('id')[0].text);
	this.setItemName(this.propertyXML.getElementsByTagName('planName')[0].text);
	this.setColor(this.propertyXML.getElementsByTagName('color')[0].text);
	this.setUrgent(this.propertyXML.getElementsByTagName('urgent')[0].text);
	this.setRemindType(this.propertyXML.getElementsByTagName('remindType')[0].text);
	this.setRemindBeforeStart(this.propertyXML.getElementsByTagName('remindBeforeStart')[0].text);
	this.setRemindBeforeStartMinute(this.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text);
	this.setRemindBeforeEnd(this.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text);
	this.setRemindBeforeEndMinute(this.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text);
	this.setExecuteId(this.propertyXML.getElementsByTagName('executeId')[0].text);
	this.setStartDate(this.propertyXML.getElementsByTagName('startDate')[0].text);
	this.setStartTime(this.propertyXML.getElementsByTagName('startTime')[0].text);
	this.setEndDate(this.propertyXML.getElementsByTagName('endDate')[0].text);
	this.setEndTime(this.propertyXML.getElementsByTagName('endTime')[0].text);
	this.setDescription(this.propertyXML.getElementsByTagName('description')[0].text);
	
	this.setRelatedCustomer(this.propertyXML.getElementsByTagName('relatedCustomer')[0].text);
	this.setRelatedDocument(this.propertyXML.getElementsByTagName('relatedDocument')[0].text);
	this.setRelatedProject(this.propertyXML.getElementsByTagName('relatedProject')[0].text);
	this.setRelatedWorkFlow(this.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text);
	this.setRelatedTask(this.propertyXML.getElementsByTagName('relatedTask')[0].text);
	this.setRelatedMeeting(this.propertyXML.getElementsByTagName('relatedMeeting')[0].text);
	this.setStatus(this.propertyXML.getElementsByTagName('status')[0].text);
	this.setShareLevel(this.propertyXML.getElementsByTagName('shareLevel')[0].text);
	this.setExchangeCount(this.propertyXML.getElementsByTagName('exchangeCount')[0].text);
		
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	if(this.status==1)
	{
		this.color ="<%=overColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)";
	}
	else if(this.status==2)
	{
		this.color ="<%=archiveColor%>" ;
		this.itemName +="(<%=SystemEnv.getHtmlLabelName(18800,user.getLanguage())%>)";
	}
	//this.setBorderStyle("1px solid #FFFFFF");
	
	this.setCalendarItemType(getCalendarItemType(this.startDate, this.startTime, this.endDate, this.endTime));
}
CalendarItemOfMonth.prototype.decorateCalendarItemBorderStyle = function(pBorderStyle)
{
	for(var i = 0; i < this.display.length; i++)
	{
		this.display[i].style.border = pBorderStyle;
	}
}
CalendarItemOfMonth.prototype.overCalendarItem = function()
//����ճ�
{	
	this.transmitAsynchronous("overCalendarItem");
	<%
	if("1".equals(overAvailable))
	{
	%>
	//�ճ̽���ʱ���ı��ճ̵���ʾ��ʽ
	this.setStatus("1");
	this.color ="<%=overColor%>" ;
	var itemName = this.itemName+"(<%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%>)";
	var vdisplay = this.display;
	for(var i =0 ;i<vdisplay.length;i++)
	{
		this.display[0].firstChild.style.backgroundColor = this.color;
		this.display[0].firstChild.style.border = "1px solid " + this.color;
		this.display[0].lastChild.style.backgroundColor = this.color;
		
		//��д�ճ̵ı���
		
		var newitemName = "<A href='javascript:void(0)' onclick='viewCalendarSplash.createSplash(" + this.arrayId + ");'>" + itemName + "</A>";
		var newtitle = this.startTime + "��" + newitemName  + "��";
		this._fillCalendarItemContent(this.display[0].lastChild, newtitle);
	}
	<%
	}
	else
	{
	%>
	//�Ƴ�calendarList�еĶ�Ӧ�ճ�
	this.deletePatch();
	calendarList[this.arrayId] = "0";
	
	//�޸���ʾ
	adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);  //������ʾ��¼�������
	
	//���more
	var date = new Date(beginYearOfTable, beginMonthOfTable - 1, beginDayOfTable);
	for(var i = 0; i < showDaysOfMonth; i++)
	{
			var dateString = date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString();

		$(dateString + ",more").innerHTML = "";
		date.setDate(date.getDate() + 1);
	}
	
	//��֯��ʾ
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].alterCalendarItem();
		}
	}
	<%}%>
}







function windowChange()
//��ҳ���С�仯ʱ����
{
	adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);  //������ʾ��¼�������
	adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);  //����ʾ��¼�������
	resetScrollTimedEventSwk();
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i])
		{
			calendarList[i].rebuildCalendarItemDisplay();
		}
	}
}

function rebuildCalendarItemSingleDay()
//����һ�����ճ���ʾ
{
	for(var i = 0; i < calendarList.length; i++)
	{
		if("0" != calendarList[i] && "1" == calendarList[i].calendarItemType)
		//���ճ�Ϊһ��������ʱ
		{
			calendarList[i].rebuildCalendarItemDisplay();
		}		
	}
}




/*
 * ����������
 */
function DragMoveDropActionAbstract()
{		
	this.active = false;
	this.activeElement;
	
	this.mouseOriginalX;
	this.mouseOriginalY;
	this.mouseMovingX;
	this.mouseMovingY;
	this.elementOriginalX;
	this.elementOriginalY;
	
	this.shortIcon;  //����ʱ��ʾͼ��
}
DragMoveDropActionAbstract.prototype.debug = function()
{
	alert("debug");
}



/*
 * �����ճ�������
 */
function DragMoveDropActionSingleDay()
{
	DragMoveDropActionAbstract.apply(this, new Array());

	/*this.cellItemIdOver;
	this.cellXOver;
	this.cellYOver;
	this.coordinateXLeftTrigger;
	this.coordinateXRightTrigger;
	this.coordinateYUpTrigger;
	this.coordinateYDownTrigger*/;
}
DragMoveDropActionSingleDay.prototype = new DragMoveDropActionAbstract();
DragMoveDropActionSingleDay.prototype.startDrag = function()
{
	if(enable && 1 == event.button)
	{
		var calendarItemTitle = event.srcElement;
		var calendarItemDisplay = calendarItemTitle.parentNode;
		var calendarItem = calendarList[calendarItemDisplay.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			//����������һ��table����Ҫ�����µ�scroll��ֵ
			this.mouseOriginalX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
			this.mouseOriginalY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;
			this.elementOriginalX = parseInt(calendarItemDisplay.style.left, 10);
			this.elementOriginalY = parseInt(calendarItemDisplay.style.top, 10);
			
			this.active = true;
			this.activeElement = calendarItemDisplay;
	
			calendarItemTitle.setCapture();
		}
	}
}
DragMoveDropActionSingleDay.prototype.moving = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		//var calendarItemTitle = event.srcElement;
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			//����������һ��table����Ҫ�����µ�scroll��ֵ
			this.mouseMovingX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
			this.mouseMovingY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;
			
			if(!this._checkAvailableCoordinate(calendarItem))
			{
				return;
			}	
			
			calendarItem = this._caculateMoveTo(calendarItem, this.mouseMovingX, this.mouseMovingY);			
			calendarItem.alterCalendarItem();
		}
		//this._windowScroll(calendarItem, this.mouseMovingX, this.mouseMovingY);
	}
}
DragMoveDropActionSingleDay.prototype.stopDrag = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			this.active = false;
			this.activeElement.childNodes[0].releaseCapture();
			delete this.activeElement;
			
			calendarItem.transmitAsynchronous("editCalendarItemQuick");
		}
	}	
}
DragMoveDropActionSingleDay.prototype._caculateMoveTo = function(pCalendarItem, pThisMouseX, pThisMouseY)
//�����ճ����ƶ���Ŀ������
{
	var calendarItem = pCalendarItem;
	var thisMouseX = pThisMouseX;
	var thisMouseY = pThisMouseY;

	//writeLog(calendarList[1].display, "move" + pThisMouseX + ":" + pThisMouseY);
	var offsetMinute = parseInt(calendarItem.startTime.split(":")[1], 10) % 30;  //�����cell����ƫ����
	
	var cellCountX = Math.floor((thisMouseX - timeTitleWidth) / calendarItemContentWidth);
	var cellCountY = Math.floor((thisMouseY - topHeightOfDays) / calendarItemContentHeight);
	
	var absoluteDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + cellCountX);
	var absoluteBeginMinute = Math.floor(cellCountY * 30) + offsetMinute;
	var absoluteEndMinute = absoluteBeginMinute + calendarItem.minuteDifference;
	
	var startDate = absoluteDate.getYear() + "-" + formatSingleDateTime(absoluteDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteDate.getDate()).toString();
	var endDate = startDate;
	
	var startTime = formatSingleDateTime(Math.floor(absoluteBeginMinute / 60)).toString() + ":" + formatSingleDateTime(absoluteBeginMinute % 60).toString();
	var endTime = formatSingleDateTime(Math.floor(absoluteEndMinute / 60)).toString() + ":" + formatSingleDateTime(absoluteEndMinute % 60).toString();
	
	calendarItem.startDate = startDate;
	calendarItem.endDate = endDate;
	calendarItem.startTime = startTime;
	calendarItem.endTime = endTime;
	
	//writeLog(calendarList[1].display, absoluteBeginMinute + "$" + absoluteEndMinute);
	return calendarItem;
}
DragMoveDropActionSingleDay.prototype._windowScroll = function(calendarItem, pMouseMovingX, pMouseMovingY)
{
	//writeLog(calendarList[1].display, "move" + (pMouseMovingY + calendarItem.height) + "XX" + document.body.offsetHeight);
	
	if(pMouseMovingY + calendarItem.height > document.body.offsetHeight)
	{		
		windowScroll(0, pMouseMovingY + calendarItem.height - document.body.offsetHeight);
	}
}
DragMoveDropActionSingleDay.prototype._checkAvailableCoordinate = function(pCalendarItem)
{
	//��Ҫʹ���µ�scrolltimedeventswk�Ŀ���ֵ
	var calendarTableWidth = $("scrolltimedeventswk").scrollWidth;
	var calendarTableHeight = $("scrolltimedeventswk").scrollHeight;
	if(this.mouseMovingX - timeTitleWidth <= 0)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingY - topHeightOfDays <= 0)
	//��Խ��
	{
		return false;
	}
	
	if(this.mouseMovingX >= calendarTableWidth)
	//��Խ��
	{
		return false;
	}
	//�����ճ̱�����ճ����ݷ��룬��Ҫ��ȥ�ճ̱���Ŀ�ȣ��Ͷ���Ŀ��
	if(this.mouseMovingY + pCalendarItem.height - topHeightOfDays-5 >= calendarTableHeight)
	//��Խ��
	{
		return false;
	}
	
	return true;
}





/*
 * �����ճ�������
 */
function DragMoveDropActionMultiDay()
{
	DragMoveDropActionAbstract.apply(this, new Array());
}
DragMoveDropActionMultiDay.prototype = new DragMoveDropActionAbstract();
DragMoveDropActionMultiDay.prototype.startDrag = function()
{
	if(enable && 1 == event.button && "DIV" == event.srcElement.tagName)
	{	
		var calendarItemTitle = event.srcElement;

		var calendarItemDisplay = calendarItemTitle.parentNode;
		var calendarItem = calendarList[calendarItemDisplay.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			this.active = true;
			this.mouseOriginalX = event.clientX + document.body.scrollLeft;
			this.mouseOriginalY = event.clientY + document.body.scrollTop;
			this.elementOriginalX = parseInt(calendarItemDisplay.style.left, 10);
			this.elementOriginalY = parseInt(calendarItemDisplay.style.top, 10);
	
			this.activeElement = calendarItemDisplay;
	
			this.shortIcon = new CalendarItemShortIconMultiDay(calendarList[calendarItem.arrayId]);
			this.shortIcon.buildPatch(this.mouseOriginalX, this.mouseOriginalY);
		
			calendarItemTitle.setCapture();
		}
	}
}
DragMoveDropActionMultiDay.prototype.moving = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			this.mouseMovingX = event.clientX + document.body.scrollLeft;
			this.mouseMovingY = event.clientY + document.body.scrollTop;
			
			if(!this._checkAvailableCoordinate(calendarItem))
			{
				return;
			}
			
			calendarItem = this._caculateMoveTo(calendarItem, this.mouseMovingX, this.mouseMovingY);	
			this.shortIcon.modifyCalendarItemShortIcon(this.mouseMovingX, this.mouseMovingY);
		}
	}
}
DragMoveDropActionMultiDay.prototype.stopDrag = function()
{
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			//�޸���ʾ
			adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);  //������ʾ��¼�������
		
			for(var i = 0; i < calendarList.length; i++)
			{
				if("0" != calendarList[i] && "2" == calendarList[i].calendarItemType)
				{
					calendarList[i].alterCalendarItem();
				}
			}
								
			rebuildCalendarItemSingleDay();  //����һ�����ճ���ʾ
					
			this.active = false;
			this.shortIcon.deletePatch();
			this.activeElement.childNodes[0].releaseCapture();
			delete this.shortIcon;
			delete this.activeElement;
	
			//��̨����
			calendarItem.transmitAsynchronous("editCalendarItemQuick");
		}
	}
}
DragMoveDropActionMultiDay.prototype._caculateMoveTo = function(pCalendarItem, pThisMouseX, pThisMouseY)
//�����ճ����ƶ���Ŀ������
{
	var calendarItem = pCalendarItem;
	var thisMouseX = pThisMouseX;
	var thisMouseY = pThisMouseY;	
	
	var cellCountX = Math.floor((thisMouseX - timeTitleWidth) / calendarItemContentWidth);	

	var absoluteBeginDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + cellCountX);
	var startDate = absoluteBeginDate.getYear() + "-" + formatSingleDateTime(absoluteBeginDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteBeginDate.getDate()).toString();

	var absoluteEndDate;
	var endDate;
	
	if("" != calendarItem.endDate)
	//�н�������
	{
		absoluteEndDate = new Date(absoluteBeginDate.valueOf() + 60000 * pCalendarItem.minuteDifference);
		endDate = absoluteEndDate.getYear() + "-" + formatSingleDateTime(absoluteEndDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteEndDate.getDate()).toString();
	}
	else
	//�޽�������
	{
		endDate = "";
	}	
	
	calendarItem.startDate = startDate;
	calendarItem.endDate = endDate;

	//writeLog(calendarList[4].display, startDate + "$" + endDate);
	return calendarItem;
}
DragMoveDropActionMultiDay.prototype._checkAvailableCoordinate = function(pCalendarItem)
{
	//ʹ���ճ̱�����Ŀ��
	var calendarTableWidth = $("calendarHeadTable").offsetWidth;
	if(this.mouseMovingX - timeTitleWidth <= 0)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingY - calendarTitleHeight <= 0)
	//��Խ��
	{
		return false;
	}

	if(this.mouseMovingX >= calendarTableWidth)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingY >= topHeightOfDays)
	//��Խ��
	{
		//writeLog(calendarList[1].display, this.mouseMovingY + "&" + topHeightOfDays);
		return false;
	}
	
	return true;
}





/*
 * ���ճ�������
 */
function DragMoveDropActionMonth()
{
	DragMoveDropActionAbstract.apply(this, new Array());
}
DragMoveDropActionMonth.prototype = new DragMoveDropActionAbstract();
DragMoveDropActionMonth.prototype.startDrag = function()
{
	if(enable && 1 == event.button && "DIV" == event.srcElement.tagName)
	{
		var calendarItemTitle = event.srcElement;

		var calendarItemDisplay = calendarItemTitle.parentNode;
		var calendarItem = calendarList[calendarItemDisplay.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			this.active = true;
			this.mouseOriginalX = event.clientX + document.body.scrollLeft;
			this.mouseOriginalY = event.clientY + document.body.scrollTop;
			this.elementOriginalX = parseInt(calendarItemDisplay.style.left, 10);
			this.elementOriginalY = parseInt(calendarItemDisplay.style.top, 10);
	
			this.activeElement = calendarItemDisplay;
	
			this.shortIcon = new CalendarItemShortIconMonth(calendarList[calendarItem.arrayId]);
			this.shortIcon.buildPatch(this.mouseOriginalX, this.mouseOriginalY);
	
			calendarItemTitle.setCapture();
		}
	}
}
DragMoveDropActionMonth.prototype.moving = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];		
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{		
			this.mouseMovingX = event.clientX + document.body.scrollLeft;
			this.mouseMovingY = event.clientY + document.body.scrollTop;
			
			if(!this._checkAvailableCoordinate(calendarItem))
			{
				return;
			}
	
			calendarItem = this._caculateMoveTo(calendarItem, this.mouseMovingX, this.mouseMovingY);
			this.shortIcon.modifyCalendarItemShortIcon(this.mouseMovingX, this.mouseMovingY);
		}
	}
}
DragMoveDropActionMonth.prototype.stopDrag = function()
{
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{					
			//�ͷ�
			this.active = false;
			this.shortIcon.deletePatch();
			this.activeElement.childNodes[0].releaseCapture();
			delete this.shortIcon;	
			delete this.activeElement;	
			
			//�޸���ʾ
			adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);  //������ʾ��¼�������
			
			//���more
			var date = new Date(beginYearOfTable, beginMonthOfTable - 1, beginDayOfTable);
			for(var i = 0; i < showDaysOfMonth; i++)
			{
				var dateString = date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString();
	
				$(dateString + ",more").innerHTML = "";
				date.setDate(date.getDate() + 1);
			}
			
			//��֯��ʾ
			for(var i = 0; i < calendarList.length; i++)
			{
				if("0" != calendarList[i])
				{
					calendarList[i].alterCalendarItem();
				}
			}	
					
			//��̨��Ϣ����
			calendarItem.transmitAsynchronous("editCalendarItemQuick");
		}
	}
}
DragMoveDropActionMonth.prototype._caculateMoveTo = function(pCalendarItem, pThisMouseX, pThisMouseY)
//�����ճ����ƶ���Ŀ������
{
	var calendarItem = pCalendarItem;
	var thisMouseX = pThisMouseX;
	var thisMouseY = pThisMouseY;	
	
	var cellCountX = Math.floor(thisMouseX / calendarItemContentWidth);
	var cellCountY = Math.floor((thisMouseY - topHeightOfMonth) / calendarItemContentHeightMonth);
	
	var absoluteBeginDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + (daysOfWeek * cellCountY + cellCountX));
	var startDate = absoluteBeginDate.getYear() + "-" + formatSingleDateTime(absoluteBeginDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteBeginDate.getDate()).toString();

	var absoluteEndDate;
	var endDate;

	if("" != calendarItem.endDate)
	//�н�������
	{
		absoluteEndDate = new Date(absoluteBeginDate.valueOf() + 60000 * pCalendarItem.minuteDifference);
		endDate = absoluteEndDate.getYear() + "-" + formatSingleDateTime(absoluteEndDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteEndDate.getDate()).toString();
	}
	else
	//�޽�������
	{
		endDate = "";
	}	

	calendarItem.startDate = startDate;
	calendarItem.endDate = endDate;

	//writeLog(calendarList[4].display, startDate + "$" + endDate);
	return calendarItem;
}
DragMoveDropActionMonth.prototype._checkAvailableCoordinate = function(pCalendarItem)
{
	//��Ҫʹ���µ�calendarHeadTable�Ŀ���ֵ
	var calendarTableWidth = $("calendarHeadTable").offsetWidth;
	var calendarTableHeight = $("calendarHeadTable").offsetHeight;

	if(this.mouseMovingX <= 0)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingY <= 30)
	//��Խ��
	{
		return false;
	}
	
	if(this.mouseMovingX >= calendarTableWidth)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingY >= calendarTableHeight)
	//��Խ��
	{
		return false;
	}
	
	return true;
}


var globalDragMoveDropActionSingleDay = new DragMoveDropActionSingleDay();  //�����ճ�����ȫ�ֱ���
var globalDragMoveDropActionMultiDay = new DragMoveDropActionMultiDay();  //�����ճ�����ȫ�ֱ���
var globalDragMoveDropActionMonth = new DragMoveDropActionMonth();  //���ճ�����ȫ�ֱ���





/*
 * �����ı��ճ̽���ʱ����
 */
function AlterEndTimeAction()
{
	DragMoveDropActionAbstract.apply(this, new Array());
	this.startDate;  //EndDate�ĳ�ʼʱ��
	this.endDate;  //EndDate������ʱ��
	this.moveDate;  //EndDate������ʱ��
	this.topYAvailable;	
}
AlterEndTimeAction.prototype = new DragMoveDropActionAbstract();
AlterEndTimeAction.prototype.caculateDate = function(mouseX, mouseY)
{
	var cellCountX = Math.floor((mouseX - timeTitleWidth) / calendarItemContentWidth);
	var cellCountY = Math.floor((mouseY - topHeightOfDays) / calendarItemContentHeight);  //һ��30����

	return new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + parseInt(cellCountX, 10), 0, cellCountY * 30);
}


/*
 * �����ı�һ�����ճ̽���ʱ����
 */
function AlterEndTimeActionSingleDay()
{
	AlterEndTimeAction.apply(this, new Array());
}
AlterEndTimeActionSingleDay.prototype = new AlterEndTimeAction();
AlterEndTimeActionSingleDay.prototype.startDrag = function()
{
	if(enable && 1 == event.button)
	{
		var calendarItemDrag = event.srcElement;
		var calendarItemDisplay = calendarItemDrag.parentNode;
		var calendarItem = calendarList[calendarItemDisplay.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			//����������һ��table����Ҫ�����µ�scroll��ֵ
			this.mouseOriginalX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
			this.mouseOriginalY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;
		
			this.startDate = this.caculateDate(this.mouseOriginalX, this.mouseOriginalY);
			this.endDate = this.startDate;
			this.moveDate = this.startDate;
		
			this.active = true;
			this.activeElement = calendarItemDisplay;
		
			this.topYAvailable = parseInt($(calendarList[this.activeElement.arrayId].startDate + "," + floorTime(calendarList[this.activeElement.arrayId].startTime)).offsetTop, 10) + calendarItemContentHeight;
		
			calendarItemDrag.setCapture();
		}
	}
}
AlterEndTimeActionSingleDay.prototype.moving = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			//����������һ��table����Ҫ�����µ�scroll��ֵ
			this.mouseMovingX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
			this.mouseMovingY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;								
			
			if(!this._checkAvailableCoordinate(calendarItem))
			{
				return;
			}
			
			this.moveDate = this.caculateDate(this.mouseOriginalX, this.mouseMovingY);
			
			if(this.moveDate.valueOf() != this.endDate.valueOf())
			{
				this.endDate = this.moveDate;
				calendarItem = this._caculateMoveTo(calendarItem, this.mouseOriginalX, this.mouseMovingY);
				
				calendarItem.alterCalendarItem();
			}
		}
				
	}
}
AlterEndTimeActionSingleDay.prototype.stopDrag = function()
{	
	if(enable && this.active&&this.activeElement)
	{
		var calendarItem = calendarList[this.activeElement.arrayId];
		//ֻ���ճ̴�����Ч״̬���ſ��϶�����ק
		if(calendarItem.status==0)
		{
			calendarItem.transmitAsynchronous("editCalendarItemQuick");
	
			this.active = false;
			this.activeElement.lastChild.releaseCapture();
			delete this.activeElement;
		}
	}	
}
AlterEndTimeActionSingleDay.prototype._caculateMoveTo = function(pCalendarItem, pThisMouseX, pThisMouseY)
//�����ճ����ƶ���Ŀ������
{
	var calendarItem = pCalendarItem;
	var thisMouseX = pThisMouseX;
	var thisMouseY = pThisMouseY;

	var offsetMinute = parseInt(calendarItem.endTime.split(":")[1], 10) % 30;  //�����cell����ƫ����
	
	var cellCountX = Math.floor((thisMouseX - timeTitleWidth) / calendarItemContentWidth);
	var cellCountY = Math.floor((thisMouseY - topHeightOfDays) / calendarItemContentHeight);
	
	var endDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + parseInt(cellCountX, 10), 0, parseInt(cellCountY * 30, 10) + parseInt(offsetMinute, 10));

	calendarItem.endTime = date2TimeString(endDate);
	//calendarItem.minuteDifference = dateTimeDifference(calendarItem.startDate, calendarItem.startTime, calendarItem.endDate, calendarItem.endTime);	
	
	return calendarItem;
}

AlterEndTimeActionSingleDay.prototype._checkAvailableCoordinate = function(pCalendarItem)
{
	//��Ҫʹ���µ�scrolltimedeventswk�Ŀ���ֵ
	var calendarTableWidth = $("scrolltimedeventswk").scrollWidth;
	var calendarTableHeight = $("scrolltimedeventswk").scrollHeight;
	
	if(this.mouseMovingX - timeTitleWidth <= 0)
	//��Խ��
	{
		return false;
	}
	//�����ճ̱�����ճ����ݷ��룬��Ҫ�ټ�ȥ�ճ̱���ĸ߶�
	if(this.mouseMovingY - this.topYAvailable - topHeightOfDays <= 0)
	//��Խ��
	{
		return false;
	}
	if(this.mouseMovingX  >= calendarTableWidth)
	//��Խ��
	{
		return false;
	}
	//�����ճ̱�����ճ����ݷ��룬��Ҫ�ټ�ȥ�ճ̱���ĸ߶�
	if(this.mouseMovingY - topHeightOfDays >= calendarTableHeight)
	//��Խ��
	{
		return false;
	}
	
	return true;
}

var alterEndTimeActionSingleDay = new AlterEndTimeActionSingleDay();





/*
 * ��ʾ��ͻ��¼����
 */
function AdjustDisplayAction(elementSize)
{
	this.busy = 1;
	this.free = 0;
	this.elementSize = elementSize;
	this.flagArray = new Array();
}
AdjustDisplayAction.prototype.debug = function()
{

}


/*
 * �����ճ���ʾ��ͻ����
 */
function AdjustMultiDayDisplayAction(elementSize)
{
	AdjustDisplayAction.apply(this, new Array(elementSize));
}
AdjustMultiDayDisplayAction.prototype = new AdjustDisplayAction();
AdjustMultiDayDisplayAction.prototype._createFlagAtomArray = function()
//Ԫ����
{
	var atomArray = new Array(this.elementSize);

	this.flagArray.push(atomArray);
	
	return atomArray;
}
AdjustMultiDayDisplayAction.prototype._fillFlagAtomArray = function(flagAtomArray, indexId, dayCount)
{
	for(var i = 0; i < dayCount; i++)
	{
		flagAtomArray[indexId + i] = this.busy;
	}
}
AdjustMultiDayDisplayAction.prototype._freeFlagAtomArray = function(flagAtomArray, indexId, dayCount)
{
	for(var i = 0; i < dayCount; i++)
	{
		flagAtomArray[indexId + i] = this.free;
	}
}
AdjustMultiDayDisplayAction.prototype.getAvailableAtomArray = function(indexId, dayCount)
//���ؿ��õ�Ԫ����
{
	for(var i = 0; i < this.flagArray.length; i++)
	{
		var canUse = false;
		
		for(var j = 0; j < dayCount; j++)
		{
			if(this.busy != this.flagArray[i][indexId + j])
			{
				canUse = true;
			}
			else
			{
				canUse = false;
				break;
			}
		}
		
		if(canUse)
		{
			return i;
		}
	}
	
	return -1;
}
AdjustMultiDayDisplayAction.prototype.addFlagArray = function(indexId, dayCount)
{
	var arrayIndex = this.getAvailableAtomArray(indexId, dayCount);
	var atomArray;
	
	if(-1 == arrayIndex)
	//��Ҫ�½�Ԫ����
	{
		atomArray = this._createFlagAtomArray();
		arrayIndex = this.flagArray.length - 1;
	}
	else
	{
		atomArray = this.flagArray[arrayIndex];
	}
	
	this._fillFlagAtomArray(atomArray, indexId, dayCount);
	
	return arrayIndex;
}
AdjustMultiDayDisplayAction.prototype.deleteFlagArray = function(flagArrayIndex, indexId, dayCount)
{
	this._freeFlagAtomArray(this.flagArray[flagArrayIndex], indexId, dayCount);
}
AdjustMultiDayDisplayAction.prototype.getFlagArrayLength = function()
{
	return this.flagArray.length;
}





/*
 * ���ճ���ʾ��ͻ����
 * ����ÿCell�����ʾ�������������һ�����ռ�ã�����more
 */
function AdjustMonthDisplayAction(elementSize)
{
	AdjustDisplayAction.apply(this, new Array(elementSize));
	for(var i = 0; i < maxDisplayRow; i++)
	//���� * ����
	{
		this.flagArray.push(this._createFlagAtomArray());
	}
}
AdjustMonthDisplayAction.prototype = new AdjustDisplayAction();
AdjustMonthDisplayAction.prototype._createFlagAtomArray = function()
//Ԫ����
{
	var atomArray = new Array(this.elementSize);
	
	for(var i = 0; i < atomArray.length; i++)
	{
		atomArray[i] = this.free;
	}
	
	return atomArray;
}
AdjustMonthDisplayAction.prototype._fillFlagAtomArray = function(flagAtomArray, indexId, dayCount)
{
	for(var i = 0; i < dayCount; i++)
	{
		flagAtomArray[indexId + i] = this.busy;
	}
}
AdjustMonthDisplayAction.prototype._fillCountAtomArray = function(indexId, dayCount)
{
	var countArray = new Array();	
	for(var i = 0; i < dayCount; i++)
	{
		var count = this.flagArray[maxDisplayRow - 1][indexId + i]++;
		countArray.push(count);
	}
	return countArray;
}
AdjustMonthDisplayAction.prototype._freeFlagAtomArray = function(flagAtomArray, indexId, dayCount)
{
	for(var i = 0; i < dayCount; i++)
	{	
		flagAtomArray[indexId + i] = this.free;
	}
}
AdjustMonthDisplayAction.prototype._freeCountAtomArray = function(indexId, dayCount)
{
	var countArray = new Array();
	for(var i = 0; i < dayCount; i++)
	{
		var count = this.flagArray[maxDisplayRow - 1][indexId + i]--;
		countArray.push(count);
	}
	return countArray;
}
AdjustMonthDisplayAction.prototype.getAvailableAtomArray = function(indexId, dayCount)
//���ؿ��õ�Ԫ����
{
	for(var i = 0; i < this.flagArray.length - 1; i++)
	{
		var canUse = false;
		
		for(var j = 0; j < dayCount; j++)
		{
			if(this.busy != this.flagArray[i][indexId + j])
			{
				canUse = true;
			}
			else
			{
				canUse = false;
				break;
			}
		}
		
		if(canUse)
		{
			return i;
		}
	}
	
	return -1;
}

AdjustMonthDisplayAction.prototype.addFlagArray = function(indexId, dayCount)
//����ռ�ñ�־λ
{
	var arrayIndex = this.getAvailableAtomArray(indexId, dayCount);

	if(-1 != arrayIndex)
	//�п���������ʾ
	{
		this._fillFlagAtomArray(this.flagArray[arrayIndex], indexId, dayCount);
	}
	else
	{
		this._fillCountAtomArray(indexId, dayCount);  //ͳ������ֵ��һ
	}

	return arrayIndex;
}
AdjustMonthDisplayAction.prototype.deleteAllFlagArrayOfItem = function(calendarItem)
{
	for(var i = 0; i < calendarItem.display.length; i++)
	{
		if(calendarItem.daysCountOfRowArray[i] > 0)
		//����ʾ�ģ���������ʾmore
		{
			this.deleteFlagArray(calendarItem.arrayIndexOfRowArray[i], $(calendarItem.beginDayOfRowArray[i]).getAttribute("indexId"), calendarItem.daysCountOfRowArray[i]);
		}
	}		
}
AdjustMonthDisplayAction.prototype.deleteFlagArray = function(flagArrayIndex, indexId, dayCount)
{
	this._freeFlagAtomArray(this.flagArray[flagArrayIndex], indexId, dayCount);
	this._freeCountAtomArray(indexId, dayCount);
}
AdjustMonthDisplayAction.prototype.getFlagArrayLength = function()
{
	return this.flagArray.length;
}



var adjustMultiDayDisplayAction = new AdjustMultiDayDisplayAction(daysOfWeek);
var adjustMonthDisplayAction = new AdjustMonthDisplayAction(showDaysOfMonth);





/*
 * �����½��ճ̸��ǲ������
 */
function CoverLayerAbstract()
{
	
}
CoverLayerAbstract.prototype.debug = function()
{
	
}


/*
 * �����½��ճ̸��ǲ���
 */
function CoverLayer(/*Date*/startDate, /*Date*/endDate, backgroundColor, width, height)
{
	CoverLayerAbstract.apply(this, new Array());
	
	this.startDate = startDate;
	this.endDate = endDate;
	this.mouseTime;  //view
	
	this.width = width;
	this.height = height;
	
	this.backgroundColor = backgroundColor;
	this.position = "absolute";
	this.filter = "progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=70,finishOpacity=0)";
	
	this.display = new Array();
}
CoverLayer.prototype = new CoverLayerAbstract();


/*
 * �����½��ճ�һ���ڸ��ǲ���
 */
function CoverLayerSingleDay(/*Date*/startDate, /*Date*/endDate, backgroundColor, width, height)
{
	CoverLayer.apply(this, new Array(startDate, endDate, backgroundColor, width, height));
}
CoverLayerSingleDay.prototype = new CoverLayer();
CoverLayerSingleDay.prototype.buildPatch = function()
{
	for(var i = 0; i < this.display.length; i++)
	{
		//���ճ����ݷ��õ��ճ�����div��
		var scrolltimedeventswk = document.getElementById("scrolltimedeventswk");
		scrolltimedeventswk.appendChild(this.display[i]);
	}
}
CoverLayerSingleDay.prototype.deletePatch = function()
{
	for(var i = 0; i < this.display.length; i++)
	{
		this.display[i].removeNode(true);
	}
}
CoverLayerSingleDay.prototype.createCoverLayer = function()
{
	var startDate;
	var endDate;
	
	//���������������»�����������
	if(this.startDate.valueOf() <= this.endDate.valueOf())
	{
		startDate = new Date(this.startDate.getYear(), this.startDate.getMonth(), this.startDate.getDate(), this.startDate.getHours(), this.startDate.getMinutes());
		endDate = this.endDate;		
	}
	else
	{
		startDate = new Date(this.endDate.getYear(), this.endDate.getMonth(), this.endDate.getDate(), this.endDate.getHours(), this.endDate.getMinutes());
		endDate = this.startDate;		
	}


	while(startDate.valueOf() <= endDate.valueOf())
	{
		var cellId = date2DateString(startDate) + "," + date2TimeString(startDate);
		
		var coverLayerDisplay = document.createElement("div");
		this._decorateCoverLayerStyle(coverLayerDisplay, "absolute", this.backgroundColor);
		this._caculateCoverLayerCoordinates(coverLayerDisplay, cellId);
			
		this.display.push(coverLayerDisplay);
		
		startDate.setMinutes(startDate.getMinutes() + 30)
	}
}
CoverLayerSingleDay.prototype._decorateCoverLayerStyle = function(pCoverLayerDisplay, pPosition, pBackgroundColor)
{
	with(pCoverLayerDisplay.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		filter = this.filter;
	}
}
CoverLayerSingleDay.prototype._caculateCoverLayerCoordinates = function(pCoverLayerDisplay, cellId)
{
	with(pCoverLayerDisplay.style)
	{
		width = this.width;
		height = this.height;
		
		left = $(cellId).offsetLeft;
		top = $(cellId).offsetTop;
	}
}


/*
 * �����½��ճ�һ�����ϸ��ǲ���
 */
function CoverLayerMultiDay(/*Date*/startDate, /*Date*/endDate, backgroundColor, width, height)
{
	CoverLayer.apply(this, new Array(startDate, endDate, backgroundColor, width, height));
}
CoverLayerMultiDay.prototype = new CoverLayer();
CoverLayerMultiDay.prototype.buildPatch = function()
{
	for(var i = 0; i < this.display.length; i++)
	{
		document.body.appendChild(this.display[i]);
	}
}
CoverLayerMultiDay.prototype.deletePatch = function()
{
	for(var i = 0; i < this.display.length; i++)
	{
		this.display[i].removeNode(true);
	}
}
CoverLayerMultiDay.prototype.createCoverLayer = function()
{
	var startDate;
	var endDate;
	
	//���������������»�����������
	if(this.startDate.valueOf() <= this.endDate.valueOf())
	{
		startDate = new Date(this.startDate.getYear(), this.startDate.getMonth(), this.startDate.getDate());
		endDate = this.endDate;		
	}
	else
	{
		startDate = new Date(this.endDate.getYear(), this.endDate.getMonth(), this.endDate.getDate());
		endDate = this.startDate;		
	}


	while(startDate.valueOf() <= endDate.valueOf())
	{
		var cellId = date2DateString(startDate);
		
		var coverLayerDisplay = document.createElement("div");
		this._decorateCoverLayerStyle(coverLayerDisplay, "absolute", this.backgroundColor);
		this._caculateCoverLayerCoordinates(coverLayerDisplay, cellId);
			
		this.display.push(coverLayerDisplay);
		
		startDate.setDate(startDate.getDate() + 1)
	}
}
CoverLayerMultiDay.prototype._decorateCoverLayerStyle = function(pCoverLayerDisplay, pPosition, pBackgroundColor)
{
	with(pCoverLayerDisplay.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		filter = this.filter;
	}
}
CoverLayerMultiDay.prototype._caculateCoverLayerCoordinates = function(pCoverLayerDisplay, cellId)
{
	with(pCoverLayerDisplay.style)
	{
		width = this.width;
		height = this.height;
		
		//�����¿��ʹ����border�������ճ̵�λ����Ҫ����ƶ�һ�����
		left = $(cellId).offsetLeft+9;
		top = $(cellId).offsetTop;
		
	}
}





/*
 * �ճ������½�������
 */
function CreateCalendarItemActionAbstract()
{
	this.active;
	this.startDate;
	this.endDate;
	this.moveDate;
	
	this.coverLayer;
	
	this.mouseOriginalX;
	this.mouseOriginalY;
	this.mouseMovingX;
	this.mouseMovingY;
}


/*
 * �ճ������½���
 */
function CreateCalendarItemAction()
{
	CreateCalendarItemActionAbstract.apply(this, new Array());
}
CreateCalendarItemAction.prototype = new CreateCalendarItemActionAbstract();


/*
 * һ�����ճ������½���
 */
function CreateCalendarItemSingleDayAction()
{
	CreateCalendarItemAction.apply(this, new Array());
}
CreateCalendarItemSingleDayAction.prototype = new CreateCalendarItemAction();
CreateCalendarItemSingleDayAction.prototype.startDrag = function()
{
	if(enable && 1 == event.button)
	{
		//�����ճ̱�����ճ����ݷ��룬Ϊ��֤�½��ճ�ʱ�����λ����ʱ���׼ȷ����Ҫ����scrolltimedeventswk�Ĺ���ֵ
		this.mouseOriginalX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
		this.mouseOriginalY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;
		
		this.startDate = this.caculateDate(this.mouseOriginalX, this.mouseOriginalY);
		this.endDate = this.startDate;
		this.moveDate = this.startDate;
		
		this.active = true;
	}
}
CreateCalendarItemSingleDayAction.prototype.moving = function()
{	
	if(enable && this.active)
	{				
		//�����ճ̱�����ճ����ݷ��룬Ϊ��֤�½��ճ�ʱ�����λ����ʱ���׼ȷ����Ҫ����scrolltimedeventswk�Ĺ���ֵ
		this.mouseMovingX = event.clientX + scrolltimedeventswk.scrollLeft+document.body.scrollLeft;
		this.mouseMovingY = event.clientY + scrolltimedeventswk.scrollTop+document.body.scrollTop;
		
		this.moveDate = this.caculateDate(this.mouseOriginalX, this.mouseMovingY);

		this.drawFilter(this.startDate, this.moveDate);
	}
}
CreateCalendarItemSingleDayAction.prototype.stopDrag = function()
{	
	if(enable && this.active)
	{
		if(undefined != this.coverLayer)
		//�����ʾ
		{
			this.coverLayer.deletePatch();		
		}

		var startDate = this.startDate;
		var endDate = new Date(this.endDate.getYear(), this.endDate.getMonth(), this.endDate.getDate(), this.endDate.getHours(), this.endDate.getMinutes() + 30);
		
		this.active = false;
		
		createCalendarSplash.createSplash(/*Date*/startDate, /*Date*/endDate);
	}
}
CreateCalendarItemSingleDayAction.prototype.drawFilter = function(startDate, moveDate)
{
	if(date2DateString(this.moveDate) + "," + date2TimeString(this.moveDate) != date2DateString(this.endDate) + "," + date2TimeString(this.endDate))
	{
		this.endDate = this.moveDate;
		
		if(undefined != this.coverLayer)
		{
			this.coverLayer.deletePatch();		
		}

		this.coverLayer = new CoverLayerSingleDay(this.startDate, this.endDate, coverLayerColor, calendarItemContentWidth, calendarItemContentHeight);
	
		this.coverLayer.createCoverLayer();
		this.coverLayer.buildPatch();
	}
}
CreateCalendarItemSingleDayAction.prototype.caculateDate = function(mouseX, mouseY)
{
	var cellCountX = Math.floor((mouseX - timeTitleWidth) / calendarItemContentWidth);
	var cellCountY = Math.floor((mouseY - topHeightOfDays) / calendarItemContentHeight);  //һ��30����

	return new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + parseInt(cellCountX, 10), 0, cellCountY * 30);
}


/*
 * �����ճ������½���
 */
function CreateCalendarItemMultiDayAction()
{
	CreateCalendarItemAction.apply(this, new Array());
}
CreateCalendarItemMultiDayAction.prototype = new CreateCalendarItemAction();
CreateCalendarItemMultiDayAction.prototype.startDrag = function()
{
	if(enable && 1 == event.button)
	{		
		this.mouseOriginalX = event.clientX + document.body.scrollLeft;
		this.mouseOriginalY = event.clientY + document.body.scrollTop;
		
		this.startDate = this.caculateDate(this.mouseOriginalX, this.mouseOriginalY);
		this.endDate = this.startDate;
		this.moveDate = this.startDate;
		
		this.active = true;
	}
}
CreateCalendarItemMultiDayAction.prototype.moving = function()
{	
	if(enable && this.active)
	{				
		this.mouseMovingX = event.clientX + document.body.scrollLeft;
		this.mouseMovingY = event.clientY + document.body.scrollTop;
		
		this.moveDate = this.caculateDate(this.mouseMovingX, this.mouseMovingY);

		this.drawFilter(this.startDate, this.moveDate);
	}
}
CreateCalendarItemMultiDayAction.prototype.stopDrag = function()
{
	if(enable && this.active)
	{
		if(undefined != this.coverLayer)
		//�����ʾ
		{
			this.coverLayer.deletePatch();		
		}

		var startDate = new Date(this.startDate.getYear(), this.startDate.getMonth(), this.startDate.getDate(), splashBeginTime.split(":")[0], splashBeginTime.split(":")[1]);
		var endDate = new Date(this.endDate.getYear(), this.endDate.getMonth(), this.endDate.getDate(), splashEndTime.split(":")[0], splashEndTime.split(":")[1]);
		
		this.active = false;

		createCalendarSplash.createSplash(/*Date*/startDate, /*Date*/endDate);
	}
}
CreateCalendarItemMultiDayAction.prototype.drawFilter = function(startDate, moveDate)
{
	if(this.moveDate != this.endDate)
	{
		this.endDate = this.moveDate;
		
		if(undefined != this.coverLayer)
		{
			this.coverLayer.deletePatch();		
		}

		this.coverLayer = new CoverLayerMultiDay(this.startDate, this.endDate, coverLayerColor, calendarItemContentWidth, multiDayCalendarAreaHeight);
	
		this.coverLayer.createCoverLayer();
		this.coverLayer.buildPatch();
	}
}
CreateCalendarItemMultiDayAction.prototype.caculateDate = function(mouseX, mouseY)
{
	var cellCountX = Math.floor((mouseX - timeTitleWidth) / calendarItemContentWidth);
	//var cellCountY = Math.floor((mouseY - topHeightOfDays) / calendarItemContentHeightMonth);

	return new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + parseInt(cellCountX, 10));
}


/*
 * ���ճ������½���
 */
function CreateCalendarItemMonthAction()
{
	CreateCalendarItemAction.apply(this, new Array());
}
CreateCalendarItemMonthAction.prototype = new CreateCalendarItemAction();
CreateCalendarItemMonthAction.prototype.startDrag = function()
{
	if(enable && 1 == event.button)
	{		
		this.mouseOriginalX = event.clientX + document.body.scrollLeft;
		this.mouseOriginalY = event.clientY + document.body.scrollTop;
		
		this.startDate = this.caculateDate(this.mouseOriginalX, this.mouseOriginalY);
		this.endDate = this.startDate;
		
		this.active = true;
	}
}
CreateCalendarItemMonthAction.prototype.moving = function()
{	
	if(enable && this.active)
	{				
		this.mouseMovingX = event.clientX + document.body.scrollLeft;
		this.mouseMovingY = event.clientY + document.body.scrollTop;
		
		this.moveDate = this.caculateDate(this.mouseMovingX, this.mouseMovingY);

		this.drawFilter(this.startDate, this.moveDate);
	}
}
CreateCalendarItemMonthAction.prototype.stopDrag = function()
{	
	if(enable && this.active)
	{
		if(undefined != this.coverLayer)
		//�����ʾ
		{
			this.coverLayer.deletePatch();		
		}
		
		var startDate = new Date(this.startDate.getYear(), this.startDate.getMonth(), this.startDate.getDate(), splashBeginTime.split(":")[0], splashBeginTime.split(":")[1]);
		var endDate = new Date(this.endDate.getYear(), this.endDate.getMonth(), this.endDate.getDate(), splashEndTime.split(":")[0], splashEndTime.split(":")[1]);
						
		this.active = false;
		
		createCalendarSplash.createSplash(/*Date*/startDate, /*Date*/endDate);
	}
}
CreateCalendarItemMonthAction.prototype.drawFilter = function(startDate, moveDate)
{
	if(this.moveDate != this.endDate)
	{
		this.endDate = this.moveDate;
		
		if(undefined != this.coverLayer)
		{
			this.coverLayer.deletePatch();		
		}

		this.coverLayer = new CoverLayerMultiDay(this.startDate, this.endDate, coverLayerColor, calendarItemContentWidth, calendarItemContentHeightMonth);
	
		this.coverLayer.createCoverLayer();
		this.coverLayer.buildPatch();
	}
}
CreateCalendarItemMonthAction.prototype.caculateDate = function(mouseX, mouseY)
{
	var cellCountX = Math.floor(mouseX / calendarItemContentWidth);
	var cellCountY = Math.floor((mouseY - topHeightOfMonth) / calendarItemContentHeightMonth);

	return new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + (daysOfWeek * cellCountY + cellCountX));
}


var createCalendarItemSingleDayAction = new CreateCalendarItemSingleDayAction();  //һ�����ճ������½�
var createCalendarItemMultiDayAction = new CreateCalendarItemMultiDayAction();  //�����ճ������½�
var createCalendarItemMonthAction = new CreateCalendarItemMonthAction();  //���ճ������½�





/*
 * �ճ������༭������
 */
function CalendarItemShortIconAbstract(calendarItem)
{
	this.calendarItem = calendarItem;
	this.display;
}
CalendarItemShortIconAbstract.prototype.debug = function()
{
	
}

/*
 * �ճ��������ձ༭��
 */
function CalendarItemShortIconMultiDay(calendarItem)
{
	CalendarItemShortIconAbstract.apply(this, new Array(calendarItem));
	this.filter = "progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50,finishOpacity=0)";
}
CalendarItemShortIconMultiDay.prototype = new CalendarItemShortIconAbstract();
CalendarItemShortIconMultiDay.prototype.buildPatch = function(pThisMouseX, pThisMouseY)
{
	var cellId = this._caculateCalendarItemShortIcon(pThisMouseX, pThisMouseY);
	this._drawCalendarItemShortIcon(cellId);
	document.body.appendChild(this.display);
}
CalendarItemShortIconMultiDay.prototype.modifyCalendarItemShortIcon = function(pThisMouseX, pThisMouseY)
{
	var cellId = this._caculateCalendarItemShortIcon(pThisMouseX, pThisMouseY);
	this._setCalendarItemShortIconCoordinates(cellId);
}
CalendarItemShortIconMultiDay.prototype.deletePatch = function()
{
	this.display.removeNode(true);
	delete this.display;
}
CalendarItemShortIconMultiDay.prototype._drawCalendarItemShortIcon = function(cellId)
//������ʾͼ��
{
	var cursor = "default";
	this.display = document.createElement("div");
	this._decorateCalendarItemShortIconStyle("absolute", this.calendarItem.color, "1px solid #FFFFFF", cursor);
	this._setCalendarItemShortIconCoordinates(cellId);
	this._fillCalendarItemShortIconContent(this.calendarItem.itemName);
}
CalendarItemShortIconMultiDay.prototype._decorateCalendarItemShortIconStyle = function(pPosition, pBackgroundColor, pBorder, pCursor)
//������ʽ
{	
	with(this.display.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		border = pBorder;
		cursor = pCursor;
		filter = this.filter;
		
		overflow = "hidden";
		whiteSpace = "nowrap";
		wordWrap = "break-word";
		textOverflow = "ellipsis";
	}
}
CalendarItemShortIconMultiDay.prototype._setCalendarItemShortIconCoordinates = function(cellId)
//�����ճ�����ʾ����
{
	//var iconOffsetHeight = this.adjustDisplayAction.getAvailableAtomArray($(cellId).getAttribute("indexId"), 1);
	var iconOffsetHeight = adjustMultiDayDisplayAction.getFlagArrayLength();
	
	with(this.display.style)
	{
		width = calendarItemContentWidth;
		height = multiDayCalendarItemHeight;
		//�����¿��ʹ����border�������ճ̵�λ����Ҫ����ƶ�һ�����
		left = $(cellId).offsetLeft+9;
		top = <%=addTopSpaceStr%>$(cellId).offsetTop + iconOffsetHeight * multiDayCalendarItemHeight;
	}
}
CalendarItemShortIconMultiDay.prototype._caculateCalendarItemShortIcon = function(pThisMouseX, pThisMouseY)
{
	var cellCountX = Math.floor((pThisMouseX - timeTitleWidth) / calendarItemContentWidth);	
	
	var absoluteBeginDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + cellCountX);
	var cellId = absoluteBeginDate.getYear() + "-" + formatSingleDateTime(absoluteBeginDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteBeginDate.getDate()).toString();
	
	return cellId;
}
CalendarItemShortIconMultiDay.prototype._fillCalendarItemShortIconContent = function(itemName)
//���ճ����������ʾ��Ϣ
{
	this.display.innerHTML = itemName;
}





/*
 * �ճ������±༭��
 */
function CalendarItemShortIconMonth(calendarItem)
{
	CalendarItemShortIconAbstract.apply(this, new Array(calendarItem));
	this.filter = "progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50,finishOpacity=0)";
}
CalendarItemShortIconMonth.prototype = new CalendarItemShortIconAbstract();
CalendarItemShortIconMonth.prototype.buildPatch = function(pThisMouseX, pThisMouseY)
{
	var cellId = this._caculateCalendarItemShortIcon(pThisMouseX, pThisMouseY);
	this._drawCalendarItemShortIcon(cellId);
	document.body.appendChild(this.display);
}
CalendarItemShortIconMonth.prototype.modifyCalendarItemShortIcon = function(pThisMouseX, pThisMouseY)
{
	var cellId = this._caculateCalendarItemShortIcon(pThisMouseX, pThisMouseY);
	this._setCalendarItemShortIconCoordinates(cellId);
}
CalendarItemShortIconMonth.prototype.deletePatch = function()
{
	this.display.removeNode(true);
	delete this.display;
}
CalendarItemShortIconMonth.prototype._drawCalendarItemShortIcon = function(cellId)
//������ʾͼ��
{
	var cursor = "default";
	this.display = document.createElement("div");
	this._decorateCalendarItemShortIconStyle("absolute", this.calendarItem.color, "1px solid #FFFFFF", cursor);
	this._setCalendarItemShortIconCoordinates(cellId);
	this._fillCalendarItemShortIconContent(this.calendarItem.itemName);
}
CalendarItemShortIconMonth.prototype._decorateCalendarItemShortIconStyle = function(pPosition, pBackgroundColor, pBorder, pCursor)
//������ʽ
{	
	with(this.display.style)
	{
		position = pPosition;
		backgroundColor = pBackgroundColor;
		border = pBorder;
		cursor = pCursor;
		filter = this.filter;
						
		overflow = "hidden";
		whiteSpace = "nowrap";
		wordWrap = "break-word";
		textOverflow = "ellipsis";
	}
}
CalendarItemShortIconMonth.prototype._setCalendarItemShortIconCoordinates = function(cellId)
//�����ճ�����ʾ����
{
	//var iconOffsetHeight = this.adjustDisplayAction.getAvailableAtomArray($(cellId).getAttribute("indexId"), 1);
	var iconOffsetHeight = adjustMonthDisplayAction.getFlagArrayLength();
	
	with(this.display.style)
	{
		width = calendarItemContentWidth;
		height = calendarDateTitleHeightMonth;
		//�����¿��ʹ����border�������ճ̵�λ����Ҫ����ƶ�һ�����
		left = $(cellId).offsetLeft + 1 + 9;
		top = $(cellId).offsetTop + 1;
	}
}
CalendarItemShortIconMonth.prototype._caculateCalendarItemShortIcon = function(pThisMouseX, pThisMouseY)
{
	var cellCountX = Math.floor(pThisMouseX / calendarItemContentWidth);
	var cellCountY = Math.floor((pThisMouseY - topHeightOfMonth) / calendarItemContentHeightMonth);
	
	var absoluteBeginDate = new Date(beginYearOfTable, beginMonthOfTable - 1, parseInt(beginDayOfTable, 10) + (daysOfWeek * cellCountY + cellCountX));
	var cellId = absoluteBeginDate.getYear() + "-" + formatSingleDateTime(absoluteBeginDate.getMonth() + 1).toString() + "-" + formatSingleDateTime(absoluteBeginDate.getDate()).toString();
	
	return cellId;
}
CalendarItemShortIconMonth.prototype._fillCalendarItemShortIconContent = function(itemName)
//���ճ����������ʾ��Ϣ
{
	this.display.innerHTML = itemName;
}





/********************************************************************
 *						�ճ��½��鿴�༭Splash							*
 ********************************************************************/
/**
 * �����������
 */
function SplashAbstract()
{
	
}
SplashAbstract.prototype.debug = function()
{
	
}



/**
 * �½��鿴�༭������
 */
function CalendarSplash()
{
	SplashAbstract.apply(this, new Array());
		
	this.calendarItem;  //�������ճ���
	
	this.active;
	this.activeElement;	
	this.elementOriginalX;
	this.elementOriginalY;
	this.mouseOriginalX;
	this.mouseOriginalY;
}
CalendarSplash.prototype = new SplashAbstract();
CalendarSplash.prototype._initSplash = function()
{
	var splash = document.createElement("div");
	splash.setAttribute("id", splashId);
	
	with(splash.style)
	{
		paddingLeft = "1%";
		paddingRight = "1%";
		zIndex = 100;
		position = "absolute";
		border = "1px solid #C0C0C0";
		backgroundColor = "#FFFFFF";
		width = splashWidth;
		height = splashHeight;
		
		left = document.body.scrollLeft + (document.body.offsetWidth - splashWidth) / 2 + 100;
		top = document.body.scrollTop + (document.body.offsetHeight - splashHeight) / 2 - 50;
	}

	return splash;
}
CalendarSplash.prototype.startDrag = function()
{
	if(1 == event.button)
	{
		this.activeElement = $(splashId);

		this.elementOriginalX = document.body.scrollLeft + (document.body.offsetWidth - splashWidth) / 2;
		this.elementOriginalY = document.body.scrollTop + (document.body.offsetHeight - splashHeight) / 2 - 50;
		this.mouseOriginalX = event.clientX + document.body.scrollLeft;
		this.mouseOriginalY = event.clientY + document.body.scrollTop;

		this.activeElement.setCapture();				
		this.active = true;
	}
}
CalendarSplash.prototype.moving = function()
{
	if(1 == this.active)
	{
		var mouseMovingX = event.clientX + document.body.scrollLeft;
		var mouseMovingY = event.clientY + document.body.scrollTop;
		
		var elementMovingX = this.elementOriginalX + (mouseMovingX - this.mouseOriginalX);
		var elementMovingY = this.elementOriginalY + (mouseMovingY - this.mouseOriginalY);

		with(this.activeElement.style)
		{
			left = elementMovingX;
			top = elementMovingY;
		}
	}
}
CalendarSplash.prototype.stopDrag = function()
{	
	if(this.active)
	{
		this.active = false;
		this.activeElement.releaseCapture();
	}	
}

/**
 * �ճ��½�������
 */
function CreateCalendarSplash()
{
	CalendarSplash.apply(this, new Array());
}
CreateCalendarSplash.prototype = new CalendarSplash();
CreateCalendarSplash.prototype.createSplash = function(/*Date*/startDate, /*Date*/endDate)
{
	enable = false;
	
	splash = this._initSplash();
	
	//���������������»�����������
	if(startDate.valueOf() > endDate.valueOf())
	{
		var tempDate;
		tempDate = startDate;
		startDate = endDate;
		endDate = tempDate;		
	}

	$("saveCalendar").style.display = "block";  //�½�ʱ�򱣴水ť
	splash.innerHTML = $("workPlanCreateSplash").innerHTML;	
	$("workPlanCreateSplash").innerHTML = "";

	document.body.appendChild(splash);
					
	//splash.attachEvent("onmousedown", createCalendarSplash.startDrag);
	//splash.attachEvent("onmousemove", createCalendarSplash.moving);
	//splash.attachEvent("onmouseup", createCalendarSplash.stopDrag);
	
	this.fillSplash(startDate, endDate);
}
CreateCalendarSplash.prototype.fillSplash = function(startDate, endDate)
{
	$("selectBeginDateSpan").innerHTML = date2DateString(startDate);
	$("beginDate").value = date2DateString(startDate);
	$("selectBeginTimeSpan").innerHTML = date2TimeString(startDate);
	$("beginTime").value = date2TimeString(startDate);

	$("endDateSpan").innerHTML = date2DateString(endDate);
	$("endDate").value = date2DateString(endDate);
	$("endTimeSpan").innerHTML = date2TimeString(endDate);
	$("endTime").value = date2TimeString(endDate);
		
<%
	recordSet.executeSql("SELECT * FROM WorkPlanType" + Constants.WorkPlan_Type_Query_By_Menu);
	String options="";
	while(recordSet.next()){
	    options=options+"<option value='"+recordSet.getInt("workPlanTypeId")+"'>"+Util.toHtml(Util.null2String(recordSet.getString("workPlanTypeName")).replace("\\","\\\\"))+"</option>"; 
	}		
%>
   jQuery("#workPlanType").html("<%=options%>");
}
CreateCalendarSplash.prototype.destroySplash = function()
{
	document.calendarForm.reset();
	
	this.cleanSplash();

	$("workPlanCreateSplash").innerHTML = $(splashId).innerHTML;
	$(splashId).removeNode(true);
	
	enable = true;
}
CreateCalendarSplash.prototype.cleanSplash = function()
{
	//�ճ�����
	$("workPlanType").disabled = false;
	for(var i = $("workPlanType").options.length - 1; i >= 0; i--)
	{
		$("workPlanType").options[i].removeNode(true);
	}

	//�ճ̱���
	$("nameImage").innerHTML = "<IMG src='/images/BacoError.gif' align='absMiddle'>";

	//�ճ�����ʱ������
	$("remindTime").style.display = "none";
	$("remindTimeLine").style.display = "none";

	//������
	$("memberSpan").innerHTML = "<A href='/hrm/resource/HrmResource.jsp?id=<%= user.getUID() %>' target='_blank'>"
			+ "<%=Util.toScreen(resourceComInfo.getResourcename(String.valueOf(user.getUID())), user.getLanguage())%>"
		  	+ "</A>";
	$("memberIDs").value = "<%=user.getUID()%>";
	
	//���ڡ�ʱ��
	$("selectBeginDateSpan").innerHTML = "";
	$("beginDate").value = "";
	$("selectBeginTimeSpan").innerHTML = "";
	$("beginTime").value = "";
	
	$("endDateSpan").innerHTML = "";
	$("endDate").value = "";
	$("endTimeSpan").innerHTML = "";
	$("endTime").value = "";
	
	//��ؿͻ�
	$("crmSpan").innerHTML = "";
	$("crmIDs").value = "";
		
	//����ĵ�
	$("docSpan").innerHTML = "";
	$("docIDs").value = "";
	
	//�����Ŀ
	$("projectSpan").innerHTML = "";
	$("projectIDs").value = "";
	
	//�������
	$("requestSpan").innerHTML = "";
	$("requestIDs").value = "";
	
	$("saveCalendar").disabled = false;
	$("saveCalendar").style.display = "none";
	$("editCalendar").style.display = "none";
}
CreateCalendarSplash.prototype.saveCalendarSplash = function(obj) 
{
	if (check_form($("calendarForm"), "planName,memberIDs,beginDate") && checkWorkPlanRemind()) 
	{
		var startDate = $("beginDate").value;
		var startTime = $("beginTime").value;
		var endDate = $("endDate").value;
		var endTime = $("endTime").value;
		
		if (!checkOrderValid("beginDate", "endDate"))
		{
			alert("<%=SystemEnv.getHtmlNoteName(54, user.getLanguage())%>");
			return;
		}

		if (startDate == endDate && !checkOrderValid("beginTime", "endTime")) 
		{
			alert("<%=SystemEnv.getHtmlNoteName(55, user.getLanguage())%>");
			return;
		}
	
		var arrayId = -1;
		var itemId = -1;
		var type = $("workPlanType").value;
		var color = "";				
		var itemName = $("planName").value;
		var urgent = <%= Constants.WorkPlan_Urgent_Normal %>;
		for(var i = 0; i < document.getElementsByName("urgentLevel").length; i++)
		{
			if(document.getElementsByName("urgentLevel")[i].checked)
			{
				urgent = document.getElementsByName("urgentLevel")[i].value;
			}
		}
		var remindType = <%= Constants.WorkPlan_Remind_No %>;
		for(var i = 0; i < document.getElementsByName("remindType").length; i++)
		{
			if(document.getElementsByName("remindType")[i].checked)
			{
				remindType = document.getElementsByName("remindType")[i].value;
			}
		}	
		
		
		itemName=itemName.replace(/^[ \t\n\r]+/g, "");
	    itemName=itemName.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		itemName=itemName.replace(/%/g,"��");
		itemName=itemName.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		itemName=itemName.replace(/#/g,"��");
		itemName=itemName.replace(/@/g,"��");
		itemName=itemName.replace(/\//g,"��");	
		var remindBeforeStart = $("remindBeforeStart").checked ? 1 : 0;
		var remindBeforeStartMinute = $("remindTimeBeforeStart").value;
		var remindBeforeEnd = $("remindBeforeEnd").checked ? 1 : 0;
		var remindBeforeEndMinute = $("remindTimeBeforeEnd").value;
		var executeId = $("memberIDs").value;
		
		var description = $("description").value;
		var relatedCustomer = $("crmIDs").value;
		var relatedDocument = $("docIDs").value;
		var relatedProject = $("projectIDs").value;
		var relatedWorkFlow = $("requestIDs").value;

		description=description.replace(/^[ \t\n\r]+/g, "");
	    description=description.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		description=description.replace(/%/g,"��");
		description=description.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		description=description.replace(/#/g,"��");
		description=description.replace(/@/g,"��");
		description=description.replace(/\//g,"��");				
		var relatedTask = "";
		if(undefined != $("relatedTask"))
		{
			relatedTask = $("relatedTask").value;
		}
		
		var relatedMeeting = "";
		if(undefined != $("relatedMeeting"))
		{		
			relatedMeeting = $("relatedMeeting").value;
		}
		
		var status = <%= Constants.WorkPlan_Status_Unfinished %>;
		var shareLevel = 2;  //��shareLevel > 1ʱ���ɱ༭���������ֻ��ʾ
		var exchangeCount = 0;
		
		
		obj.disabled = true;

		createCalendarSplash.destroySplash();

		var calendarItemBuild = createCalendarItem(arrayId, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);
		//���½����ճ���ӵ�calendarListSingleDay�У��Ա��������
		fillSingleDayOrMultiDayCalendarList(calendarItemBuild);
		calendarItemBuild.transmitAsynchronous("addCalendarItem");			
	}
}

var createCalendarSplash = new CreateCalendarSplash();



/**
 * �ճ̲鿴������
 */
function ViewCalendarSplash()
{
	CalendarSplash.apply(this, new Array());
}
ViewCalendarSplash.prototype = new CalendarSplash();
ViewCalendarSplash.prototype.createSplash = function(calendarItemId)
{
	if(enable)
	{
		enable = false;
		
		this.calendarItem = calendarList[calendarItemId];
		//alert(this.calendarItem.itemName);
	
		splash = this._initSplash();
		
		splash.innerHTML = $("workPlanViewSplash").innerHTML;	
		$("workPlanViewSplash").innerHTML = "";
	
		this.calendarItem.transmitAsynchronous("getCalendarItem");
		
		this._modifyCalendarItem();
			
		document.body.appendChild(splash);
		
		this.fillSplash();
	}
}
ViewCalendarSplash.prototype.fillSplash = function()
{
	$("workPlanArrayIdView").value = this.calendarItem.arrayId;

	$("workPlanTypeView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('workPlanTypeName')[0].text;
	$("planNameView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('planName')[0].text;
	$("urgentLevelView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('urgentLevelName')[0].text;
	$("remindTypeView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('remindTypeName')[0].text;
	$("remindTimeView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('remindTimeDescription')[0].text;
	$("executeIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('executeName')[0].text;
	$("beginDateView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('startDate')[0].text;
	$("beginTimeView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('startTime')[0].text;
	$("endDateView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('endDate')[0].text;
	$("endTimeView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('endTime')[0].text;
	$("descriptionView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('desc')[0].text;
	$("crmIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('crmIdName')[0].text;
	$("docIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('docIdName')[0].text;
	$("projectIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('projectIdName')[0].text;
	$("taskIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('taskIdName')[0].text;
	$("requestIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('requestIdName')[0].text;
	$("meetingIdView").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('meetingIdName')[0].text;
	
	//����ճ̽�����Ϊ����
	var texecuteId = <%=userId%>;
	//if((this.calendarItem.propertyXML.getElementsByTagName('executeId')[0].text==texecuteId)&&(this.calendarItem.propertyXML.getElementsByTagName('status')[0].text == 0))
	//{
	//	$("eidtCalendarButtonView").style.display = "block";
	//	$("overCalendarButtonView").style.display = "block";
	//	$("deleteCalendarButtonView").style.display = "block";
	//}
	//�������а��������Ѿ����б༭Ȩ��,���������°�ť
	var editshareLevel = (this.calendarItem.propertyXML.getElementsByTagName('shareLevel')[0].text > 1);
	var texecuteLevel = (this.calendarItem.propertyXML.getElementsByTagName('executeId')[0].text.indexOf(texecuteId)>-1);
	//�ѹ鵵���ѽ������ճ̣����������°�ť
	if(editshareLevel&&(this.calendarItem.propertyXML.getElementsByTagName('status')[0].text == 0))
	{
		$("eidtCalendarButtonView").style.display = "block";
		$("deleteCalendarButtonView").style.display = "block";
	}
	if((texecuteLevel||editshareLevel)&&(this.calendarItem.propertyXML.getElementsByTagName('status')[0].text == 0))
	{
		$("overCalendarButtonView").style.display = "block";
	}
	var canShare = this.calendarItem.propertyXML.getElementsByTagName('canShare')[0].text;
	if("true" == canShare)
	{
		$("shareCalendarButtonView").style.display = "block";
	}
}
ViewCalendarSplash.prototype.destroySplash = function()
{
	this.cleanSplash();

	$("workPlanViewSplash").innerHTML = $(splashId).innerHTML;
	$(splashId).removeNode(true);
	
	enable = true;
}
ViewCalendarSplash.prototype.cleanSplash = function()
{
	$("workPlanTypeView").innerHTML = "";
	$("planNameView").innerHTML = "";
	$("urgentLevelView").innerHTML = "";
	$("remindTypeView").innerHTML = "";
	$("remindTimeView").innerHTML = "";
	$("executeIdView").innerHTML = "";
	$("beginDateView").innerHTML = "";
	$("beginTimeView").innerHTML = "";
	$("endDateView").innerHTML = "";
	$("endTimeView").innerHTML = "";
	$("descriptionView").innerHTML = "";
	$("crmIdView").innerHTML = "";
	$("docIdView").innerHTML = "";
	$("projectIdView").innerHTML = "";
	$("taskIdView").innerHTML = "";
	$("requestIdView").innerHTML = "";
	$("meetingIdView").innerHTML = "";
	
	$("eidtCalendarButtonView").style.display = "none";
	$("overCalendarButtonView").style.display = "none";
	$("deleteCalendarButtonView").style.display = "none";
	$("shareCalendarButtonView").style.display = "none";
}
ViewCalendarSplash.prototype._modifyCalendarItem = function()
{
	if(-1 == this.calendarItem.modifyCalendarItem())
	//������ͷ����仯
	{
		var arrayId = -1;
	
		var type = this.calendarItem.propertyXML.getElementsByTagName('type')[0].text;
		var itemId = this.calendarItem.propertyXML.getElementsByTagName('id')[0].text;
		var itemName = this.calendarItem.propertyXML.getElementsByTagName('itemName')[0].text;
		itemName=itemName.replace(/^[ \t\n\r]+/g, "");
	    itemName=itemName.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		itemName=itemName.replace(/%/g,"��");
		itemName=itemName.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		itemName=itemName.replace(/#/g,"��");
		itemName=itemName.replace(/@/g,"��");
		itemName=itemName.replace(/\//g,"��");	
		var color = this.calendarItem.propertyXML.getElementsByTagName('color')[0].text;
		var urgent = this.calendarItem.propertyXML.getElementsByTagName('urgent')[0].text;
		var remindType = this.calendarItem.propertyXML.getElementsByTagName('remindType')[0].text;
		var remindBeforeStart = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStart')[0].text;
		var remindBeforeStartMinute = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text;
		var remindBeforeEnd = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text;
		var remindBeforeEndMinute = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text;
		var executeId = this.calendarItem.propertyXML.getElementsByTagName('executeId')[0].text;
		var startDate = this.calendarItem.propertyXML.getElementsByTagName('startDate')[0].text;
		var startTime = this.calendarItem.propertyXML.getElementsByTagName('startTime')[0].text;
		var endDate = this.calendarItem.propertyXML.getElementsByTagName('endDate')[0].text;
		var endTime = this.calendarItem.propertyXML.getElementsByTagName('endTime')[0].text;
		var description = this.calendarItem.propertyXML.getElementsByTagName('description')[0].text;
		description=description.replace(/^[ \t\n\r]+/g, "");
	    description=description.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		description=description.replace(/%/g,"��");
		description=description.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		description=description.replace(/#/g,"��");
		description=description.replace(/@/g,"��");
		description=description.replace(/\//g,"��");	
		var relatedCustomer = this.calendarItem.propertyXML.getElementsByTagName('relatedCustomer')[0].text;
		var relatedDocument = this.calendarItem.propertyXML.getElementsByTagName('relatedDocument')[0].text;
		var relatedProject = this.calendarItem.propertyXML.getElementsByTagName('relatedProject')[0].text;
		var relatedWorkFlow = this.calendarItem.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text;
		var relatedTask = this.calendarItem.propertyXML.getElementsByTagName('relatedTask')[0].text;
		var relatedMeeting = this.calendarItem.propertyXML.getElementsByTagName('relatedMeeting')[0].text;
		var status = this.calendarItem.propertyXML.getElementsByTagName('status')[0].text;
		var shareLevel = this.calendarItem.propertyXML.getElementsByTagName('shareLevel')[0].text;
		var exchangeCount = this.calendarItem.propertyXML.getElementsByTagName('exchangeCount')[0].text;
	
		var calendarItemBuild = createCalendarItem(arrayId, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);

		calendarList[this.calendarItem.arrayId].deletePatch();
		calendarList[this.calendarItem.arrayId] = "0";
		calendarItemBuild.outputAddCalendar();
	}
}

var viewCalendarSplash = new ViewCalendarSplash();



/**
 * �ճ̱༭������
 */
function EditCalendarSplash()
{
	CalendarSplash.apply(this, new Array());
}
EditCalendarSplash.prototype = new CalendarSplash();
EditCalendarSplash.prototype.createSplash = function(calendarItemArrayId)
{
	enable = false;
	
	this.calendarItem = calendarList[calendarItemArrayId];
	//alert(this.calendarItem.itemName);

	splash = this._initSplash();
	
	$("editCalendar").style.display = "block";

	splash.innerHTML = $("workPlanCreateSplash").innerHTML;	
	$("workPlanCreateSplash").innerHTML = "";
	
	this.calendarItem.transmitAsynchronous("getCalendarItem");
	
	this._modifyCalendarItem();
		
	document.body.appendChild(splash);
	
	this.fillSplash();
}
EditCalendarSplash.prototype.fillSplash = function()
{
	var calendarItemType = parseInt(this.calendarItem.propertyXML.getElementsByTagName('type')[0].text, 10);

	var oOption;
<%
	recordSet.executeSql("SELECT * FROM WorkPlanType WHERE available = '1' ORDER BY displayOrder ASC");
    String options1="";
	while(recordSet.next()){
		options1=options1+"<option value='"+recordSet.getInt("workPlanTypeId")+"'>"+Util.toHtml(Util.null2String(recordSet.getString("workPlanTypeName")).replace("\\","\\\\"))+"</option>";
%>
		if(1 <= calendarItemType && calendarItemType <= 6)
		{
			if(calendarItemType == <%= recordSet.getInt("workPlanTypeId") %>)
			{
				jQuery("#workPlanType").html("<%=options1%>");
				jQuery("#workPlanType").disabled = true;
				
				/*oOption = document.createElement("INPUT");
				oOption.setAttribute("type", "hidden");
				oOption.setAttribute("name", "workPlanType");
				oOption.setAttribute("value", "<%//= recordSet.getString("workPlanTypeName") %>");
				$("calendarForm").appendChild(oOption);*/
			}
		}
		else
		{
			if(0 == "<%= recordSet.getInt("workPlanTypeId") %>" || "<%= recordSet.getInt("workPlanTypeId") %>" >= 7)
			{
				jQuery("#workPlanType").html("<%=options1%>");
			}
		}						
<%
	}
%>

	
	for(var i = 0; i < document.getElementsByName('workPlanType')[0].length; i++)
	{
		if(this.calendarItem.propertyXML.getElementsByTagName('type')[0].text == document.getElementsByName('workPlanType')[0][i].value)
		{
			document.getElementsByName('workPlanType')[0].selectedIndex = i;
			break;
		}
	}
	$("planName").value = this.calendarItem.propertyXML.getElementsByTagName('itemName')[0].text;
	$("nameImage").innerHTML = "";
	for(var i = 0; i < document.getElementsByName('urgentLevel').length; i++)
	{
		if(document.getElementsByName('urgentLevel')[i].value == this.calendarItem.propertyXML.getElementsByTagName('urgent')[0].text)
		{
			document.getElementsByName('urgentLevel')[i].checked = true;
		}
	}
	for(var i = 0; i < document.getElementsByName('remindType').length; i++)
	{
		if(document.getElementsByName('remindType')[i].value == this.calendarItem.propertyXML.getElementsByTagName('remindType')[0].text)
		{
			document.getElementsByName('remindType')[i].checked = true;
		}
	}
	if("1" == this.calendarItem.propertyXML.getElementsByTagName('remindType')[0].text)
	{
		$("remindTime").style.display = "none";
		$("remindTimeLine").style.display = "none";
	}
	else
	{
		$("remindTime").style.display = "block";
		$("remindTimeLine").style.display = "block";
		if("1" == this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStart')[0].text)
		{
			$("remindBeforeStart").checked = true;
			$("remindTimeBeforeStart").value = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text;
		}
		if("1" == this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text)
		{
			$("remindBeforeEnd").checked = true;
			$("remindTimeBeforeEnd").value = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text;
		}		
	}
	$("memberSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('executeName')[0].text;
	$("memberIDs").value = this.calendarItem.propertyXML.getElementsByTagName('executeId')[0].text;
	$("selectBeginDateSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('startDate')[0].text;
	$("beginDate").value = this.calendarItem.propertyXML.getElementsByTagName('startDate')[0].text;		
	$("selectBeginTimeSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('startTime')[0].text;
	$("beginTime").value = this.calendarItem.propertyXML.getElementsByTagName('startTime')[0].text;
	$("endDateSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('endDate')[0].text;
	$("endDate").value = this.calendarItem.propertyXML.getElementsByTagName('endDate')[0].text;
	$("endTimeSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('endTime')[0].text;
	$("endTime").value = this.calendarItem.propertyXML.getElementsByTagName('endTime')[0].text;
	$("description").value = this.calendarItem.propertyXML.getElementsByTagName('description')[0].text.replace(/<br>/ig, "\n");
	$("crmSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('crmIdName')[0].text;
	$("crmIDs").value = this.calendarItem.propertyXML.getElementsByTagName('relatedCustomer')[0].text;
	$("docSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('docIdName')[0].text;	
	$("docIDs").value = this.calendarItem.propertyXML.getElementsByTagName('relatedDocument')[0].text;
	$("projectSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('projectIdName')[0].text;
	$("projectIDs").value = this.calendarItem.propertyXML.getElementsByTagName('relatedProject')[0].text;
	$("requestSpan").innerHTML = this.calendarItem.propertyXML.getElementsByTagName('requestIdName')[0].text;
	$("requestIDs").value = this.calendarItem.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text;
}
EditCalendarSplash.prototype.destroySplash = function()
{
	document.calendarForm.reset();
	
	this.cleanSplash();

	$("workPlanCreateSplash").innerHTML = $(splashId).innerHTML;
	$(splashId).removeNode(true);
	
	enable = true;
}
EditCalendarSplash.prototype.cleanSplash = function()
{
	//�ճ�����
	$("workPlanType").disabled = false;
	for(var i = $("workPlanType").options.length - 1; i >= 0; i--)
	{
		$("workPlanType").options[i].removeNode(true);
	}

	//�ճ�����ʱ������
	$("remindTime").style.display = "none";
	$("remindTimeLine").style.display = "none";

	//������
	$("memberSpan").innerHTML = "<A href='/hrm/resource/HrmResource.jsp?id=<%= user.getUID() %>' target='_blank'>"
			+ "<%=Util.toScreen(resourceComInfo.getResourcename(String.valueOf(user.getUID())), user.getLanguage())%>"
		  	+ "</A>";
	$("memberIDs").value = "<%=user.getUID()%>";
	
	//���ڡ�ʱ��
	$("selectBeginDateSpan").innerHTML = "";
	$("beginDate").value = "";
	$("selectBeginTimeSpan").innerHTML = "";
	$("beginTime").value = "";
	
	$("endDateSpan").innerHTML = "";
	$("endDate").value = "";
	$("endTimeSpan").innerHTML = "";
	$("endTime").value = "";
	
	//��ؿͻ�
	$("crmSpan").innerHTML = "";
	$("crmIDs").value = "";
		
	//����ĵ�
	$("docSpan").innerHTML = "";
	$("docIDs").value = "";
	
	//�����Ŀ
	$("projectSpan").innerHTML = "";
	$("projectIDs").value = "";
	
	//�������
	$("requestSpan").innerHTML = "";
	$("requestIDs").value = "";
	
	//��ť
	$("editCalendar").disabled = false;
	$("saveCalendar").style.display = "none";
	$("editCalendar").style.display = "none";
}
EditCalendarSplash.prototype.saveCalendarSplash = function(obj) 
{
	if (check_form($("calendarForm"), "planName,memberIDs,beginDate") && checkWorkPlanRemind()) 
	{
		var startDate = $("beginDate").value;
		var startTime = $("beginTime").value;
		var endDate = $("endDate").value;
		var endTime = $("endTime").value;
		
		if (!checkOrderValid("beginDate", "endDate"))
		{
			alert("<%=SystemEnv.getHtmlNoteName(54, user.getLanguage())%>");
			return;
		}

		if (startDate == endDate && !checkOrderValid("beginTime", "endTime")) 
		{
			alert("<%=SystemEnv.getHtmlNoteName(55, user.getLanguage())%>");
			return;
		}
		
		//var arrayId = -1;
		//var itemId = -1;
		this.calendarItem.setType($("workPlanType").value);
        var itemName=$("planName").value;
		itemName=itemName.replace(/^[ \t\n\r]+/g, "");
	    itemName=itemName.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		itemName=itemName.replace(/%/g,"��");
		itemName=itemName.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		itemName=itemName.replace(/#/g,"��");
		itemName=itemName.replace(/@/g,"��");
		itemName=itemName.replace(/\//g,"��");	
		//var color = "";			
		this.calendarItem.setItemName(itemName);
		var urgent = <%= Constants.WorkPlan_Urgent_Normal %>;
		for(var i = 0; i < document.calendarForm.urgentLevel.length; i++)
		{
			if(document.calendarForm.urgentLevel[i].checked)
			{
				urgent = document.calendarForm.urgentLevel[i].value;
			}
		}
		this.calendarItem.setUrgent(urgent);
		var remindType = <%= Constants.WorkPlan_Remind_No %>;
		for(var i = 0; i < document.calendarForm.remindType.length; i++)
		{
			if(document.calendarForm.remindType[i].checked)
			{
				remindType = document.calendarForm.remindType[i].value;
			}
		}
		this.calendarItem.setRemindType(remindType);
		var remindBeforeStart = $("remindBeforeStart").checked ? 1 : 0;
		this.calendarItem.setRemindBeforeStart(remindBeforeStart);
		this.calendarItem.setRemindBeforeStartMinute($("remindTimeBeforeStart").value);		
		var remindBeforeEnd = $("remindBeforeEnd").checked ? 1 : 0;
		this.calendarItem.setRemindBeforeEnd(remindBeforeEnd);		
		this.calendarItem.setRemindBeforeEndMinute($("remindTimeBeforeEnd").value);
		this.calendarItem.setExecuteId($("memberIDs").value);
		this.calendarItem.setStartDate(startDate);
		this.calendarItem.setStartTime(startTime);
		this.calendarItem.setEndDate(endDate);
		this.calendarItem.setEndTime(endTime);
		var description=$("description").value;
		description=description.replace(/^[ \t\n\r]+/g, "");
	    description=description.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		description=description.replace(/%/g,"��");
		description=description.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		description=description.replace(/#/g,"��");
		description=description.replace(/@/g,"��");
		description=description.replace(/\//g,"��");
		this.calendarItem.setDescription(description);
		this.calendarItem.setRelatedCustomer($("crmIDs").value);
		this.calendarItem.setRelatedDocument($("docIDs").value);
		this.calendarItem.setRelatedProject($("projectIDs").value);
		this.calendarItem.setRelatedWorkFlow($("requestIDs").value);
				
		if(undefined != $("relatedTask"))
		{
			this.calendarItem.setRelatedTask($("relatedTask").value);
		}
		
		if(undefined != $("relatedMeeting"))
		{		
			this.calendarItem.setRelatedMeeting($("relatedMeeting").value);
		}
		
		//var status = <%//= Constants.WorkPlan_Status_Unfinished %>;
		//var shareLevel = 2;  //��shareLevel > 1ʱ���ɱ༭���������ֻ��ʾ
		//var exchangeCount = 0;
		
		obj.disabled = true;

		editCalendarSplash.destroySplash();

		this.calendarItem.transmitAsynchronous("editCalendarItem");
	}
}
EditCalendarSplash.prototype._modifyCalendarItem = function()
{
	if(-1 == this.calendarItem.modifyCalendarItem())
	//������ͷ����仯
	{
		var arrayId = -1;
	
		var type = this.calendarItem.propertyXML.getElementsByTagName('type')[0].text;
		var itemId = this.calendarItem.propertyXML.getElementsByTagName('id')[0].text;
		var itemName = this.calendarItem.propertyXML.getElementsByTagName('itemName')[0].text;
		var color = this.calendarItem.propertyXML.getElementsByTagName('color')[0].text;
		var urgent = this.calendarItem.propertyXML.getElementsByTagName('urgent')[0].text;
		var remindType = this.calendarItem.propertyXML.getElementsByTagName('remindType')[0].text;
		var remindBeforeStart = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStart')[0].text;
		var remindBeforeStartMinute = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeStartMinute')[0].text;
		var remindBeforeEnd = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEnd')[0].text;
		var remindBeforeEndMinute = this.calendarItem.propertyXML.getElementsByTagName('remindBeforeEndMinute')[0].text;
		var executeId = this.calendarItem.propertyXML.getElementsByTagName('executeId')[0].text;
		var startDate = this.calendarItem.propertyXML.getElementsByTagName('startDate')[0].text;
		var startTime = this.calendarItem.propertyXML.getElementsByTagName('startTime')[0].text;
		var endDate = this.calendarItem.propertyXML.getElementsByTagName('endDate')[0].text;
		var endTime = this.calendarItem.propertyXML.getElementsByTagName('endTime')[0].text;
		var description = this.calendarItem.propertyXML.getElementsByTagName('description')[0].text;
		description=description.replace(/^[ \t\n\r]+/g, "");
	    description=description.replace(/[ \t\n\r]+$/g, "");
		//�滻%&$#@/Ϊȫ�Ƿ��� 
		description=description.replace(/%/g,"��");
		description=description.replace(/&/g,"��");
		//description=description.replace(/$/g,"��");
		description=description.replace(/#/g,"��");
		description=description.replace(/@/g,"��");
		description=description.replace(/\//g,"��");
		var relatedCustomer = this.calendarItem.propertyXML.getElementsByTagName('relatedCustomer')[0].text;
		var relatedDocument = this.calendarItem.propertyXML.getElementsByTagName('relatedDocument')[0].text;
		var relatedProject = this.calendarItem.propertyXML.getElementsByTagName('relatedProject')[0].text;
		var relatedWorkFlow = this.calendarItem.propertyXML.getElementsByTagName('relatedWorkFlow')[0].text;
		var relatedTask = this.calendarItem.propertyXML.getElementsByTagName('relatedTask')[0].text;
		var relatedMeeting = this.calendarItem.propertyXML.getElementsByTagName('relatedMeeting')[0].text;
		var status = this.calendarItem.propertyXML.getElementsByTagName('status')[0].text;
		var shareLevel = this.calendarItem.propertyXML.getElementsByTagName('shareLevel')[0].text;
		var exchangeCount = this.calendarItem.propertyXML.getElementsByTagName('exchangeCount')[0].text;
	
		var calendarItemBuild = createCalendarItem(arrayId, itemId, type, color, itemName, urgent, remindType, remindBeforeStart, remindBeforeStartMinute, remindBeforeEnd, remindBeforeEndMinute, executeId, startDate, startTime, endDate, endTime, description, relatedCustomer, relatedDocument, relatedProject, relatedWorkFlow, relatedTask, relatedMeeting, status, shareLevel, exchangeCount);

		calendarList[this.calendarItem.arrayId].deletePatch();
		calendarList[this.calendarItem.arrayId] = "0";

		calendarItemBuild.outputAddCalendar();
	}
}

var editCalendarSplash = new EditCalendarSplash();



/**
 * �ճ̹�������
 */
function ShareCalendarSplash()
{
	CalendarSplash.apply(this, new Array());
}
ShareCalendarSplash.prototype = new CalendarSplash();
ShareCalendarSplash.prototype.createSplash = function(calendarItemArrayId)
{
	enable = false;
	
	this.calendarItem = calendarList[calendarItemArrayId];
	
	splash = this._initSplash();
	
	splash.innerHTML = $("workPlanShareSplash").innerHTML;	
	$("workPlanShareSplash").innerHTML = "";
			
	this.calendarItem.transmitAsynchronous("getCalendarShare");

	document.body.appendChild(splash);
	
	this.fillSplash();
}
ShareCalendarSplash.prototype.fillSplash = function()
{
	$("workPlanArrayIdShare").value = this.calendarItem.arrayId;
	
	var canShare = this.calendarItem.propertyXML.getElementsByTagName('canShare');
	var shareIdArray = this.calendarItem.propertyXML.getElementsByTagName('shareId');
	var shareTypeNameArray = this.calendarItem.propertyXML.getElementsByTagName('shareTypeName');
	var shareContentArray = this.calendarItem.propertyXML.getElementsByTagName('shareContent');
	
	if(canShare)
	//��Ӳ˵�
	{
		$("workPlanShareSetSplash").style.display = "block";
	}	
	
	for(var i = 0; i < shareIdArray.length; i++)
	{
		var oRow = workPlanShareListTable.insertRow();		        
		var oCell;
		var oDiv;
		
		oRow.setAttribute("shareId", shareIdArray[i].text);
		
		oCell = oRow.insertCell();
        oDiv = document.createElement("div");        
        oDiv.innerHTML = shareTypeNameArray[i].text;        
        oCell.appendChild(oDiv);
        
        oCell = oRow.insertCell();
        oCell.className = "Field";
        oDiv = document.createElement("div");
        oDiv.innerHTML = shareContentArray[i].text;        
        oCell.appendChild(oDiv);

		if(canShare)
		{
	        oCell = oRow.insertCell();
	        oCell.className = "Field";
	        oDiv = document.createElement("div");        
	        oDiv.innerHTML = "<A href='javascript:void(0)' onclick='shareCalendarSplash.deleteCalendarSplash(" + shareIdArray[i].text + ")'><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></A>"
	        oCell.appendChild(oDiv);
	    }
        
        //�»���
        oRow = workPlanShareListTable.insertRow();
        oCell = oRow.insertCell();
        oCell.setAttribute("colSpan", 3);
        oCell.className = "Line";
	}				
}
ShareCalendarSplash.prototype.destroySplash = function()
{
	var divSave = $("divSave");
	if(divSave.style.display!="none")
	{
		return false;
	}
	document.calendarFormShare.reset();

	$("shareNameShare").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	$("secLevelSpanShare").style.display = "";
	$("roleLevelSpanShare").style.display = "none"
	
	$("multiHumanResourceShare").style.display = "none";
	$("singleRoleShare").style.display = "none";
	$("multiSubcompanyShare").style.display = "none";
	
    $("multiDepartmentShare").style.display = "";
	
	this.cleanSplash();

	$("workPlanShareSplash").innerHTML = $(splashId).innerHTML;
	$(splashId).removeNode(true);

	enable = true;
}
ShareCalendarSplash.prototype.cleanSplash = function()
{
	/*(for(var i = 0; i < $("shareTypeShare").length; i++)
	{
		if("2" == $("shareTypeShare")[i].value)
		{
			$("shareTypeShare").selectedIndex = i;
			break;
		}
	}

	$("multiHumanResourceShare").style.display = "none";
	$("multiSubcompanyShare").style.display = "none";
	$("multiDepartmentShare").style.display = "block";
	$("singleRoleShare").style.display = "none";
	$("relatedShareIdShare").value = "";
	$("relatedShareNameShare").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	$("relatedRoleLevelShare").style.visibility = "hidden";
	
	for(var i = 0; i < $("roleLevelShare").length; i++)
	{
		if("0" == $("roleLevelShare")[i].value)
		{
			$("roleLevelShare").selectedIndex = i;
			break;
		}
	}
	
	$("secLevelShare").value = 10;
	$("secLevelImageShare").innerHTML = "";

	for(var i = 0; i < $("shareLevelShare").length; i++)
	{
		if("1" == $("shareLevelShare")[i].value)
		{
			$("shareLevelShare").selectedIndex = i;
			break;
		}
	}*/
	
	for(var i = $("workPlanShareListTable").rows.length - 1; i > 1; i--)
	{
		$("workPlanShareListTable").deleteRow(i);
	}
			
	$("workPlanShareSetSplash").style.display = "none";
}
ShareCalendarSplash.prototype.saveCalendarSplash = function(calendarItemArrayId) 
{
	if (check_form($("calendarFormShare") ,"shareIdShare,roleLevelShare,secLevelShare"))
	{
		this.calendarItem = calendarList[calendarItemArrayId];
		
		this.calendarItem.transmitAsynchronous("addCalendarShare");
	}
}
ShareCalendarSplash.prototype.deleteCalendarSplash = function(calendarItemShareId) 
{
	if (isdel())
	{
		this.calendarItem.activeShareId = calendarItemShareId;

		this.calendarItem.transmitAsynchronous("deleteCalendarShare");
	
		this._deleteRowListTable()
	}
}
ShareCalendarSplash.prototype._fillListTable = function()
{
	var shareType = $("shareTypeShare").value;

	var oRow = workPlanShareListTable.insertRow();		        
	var oCell;
	var oDiv;

	oRow.setAttribute("shareId", this.calendarItem.propertyXML.getElementsByTagName('shareId')[0].text);

	/* ���� */
	oCell = oRow.insertCell();
    oDiv = document.createElement("div");        
    oDiv.innerHTML = $("shareTypeShare").options[$("shareTypeShare").selectedIndex].innerHTML;
    oCell.appendChild(oDiv);
    
    /* ���� */
	var content = "";	
	//��
	if(4 != shareType)
	{
		content += $("shareNameShare").innerText;
	}	
	//��ɫ
	if(3 == shareType)
	{
		content += " ";
		content += $("roleLevelShare").options[$("roleLevelShare").selectedIndex].innerHTML;
	}		
	//��ȫ����
	if(1 != shareType)
	{
		if(4 != shareType)
		{
			content += " / ";
		}
		content += "<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>";
		content += " : ";
		content += $("secLevelShare").value;
	}	
	//�鿴�༭
	content += " / ";
	content += $("shareLevelShare").options[$("shareLevelShare").selectedIndex].innerHTML;
	
    oCell = oRow.insertCell();
    oCell.className = "Field";
    oDiv = document.createElement("div");
    oDiv.innerHTML = content;        
    oCell.appendChild(oDiv);

	/* ɾ�� */
    oCell = oRow.insertCell();
    oCell.className = "Field";
    oDiv = document.createElement("div");        
    oDiv.innerHTML = "<A href='javascript:void(0)' onclick='shareCalendarSplash.deleteCalendarSplash(" + this.calendarItem.propertyXML.getElementsByTagName('shareId')[0].text + ")'><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></A>"
    oCell.appendChild(oDiv);
       
    //�»���
    oRow = workPlanShareListTable.insertRow();
    oCell = oRow.insertCell();
    oCell.setAttribute("colSpan", 3);
    oCell.className = "Line";
}
ShareCalendarSplash.prototype._deleteRowListTable = function()
{
	for(var i = 0; i < $("workPlanShareListTable").rows.length; i++)
	{
		var rowObj = $("workPlanShareListTable").rows[i];
		
		if(rowObj.getAttribute("shareId") == this.calendarItem.activeShareId)
		{
			//alert(rowObj.getAttribute("shareId"));
			workPlanShareListTable.deleteRow(rowObj.rowIndex + 1);
			workPlanShareListTable.deleteRow(rowObj.rowIndex);
		}
	}
}

var shareCalendarSplash = new ShareCalendarSplash();



function changeToEventView()
{
	document.weaver.action = "WorkPlanViewEventShare.jsp";
	document.weaver.submit();
}

function changeToDayTimeView(date)
{
	document.weaver.action = "WorkPlanViewShare.jsp?from=month&selectdatefrom=" + document.weaver.selectdate.value;
	document.weaver.selectdate.value = date;
	document.weaver.viewtype.value = "1";
	document.weaver.submit();
}

function goBack()
{
	document.weaver.action = "WorkPlanViewShare.jsp";
	document.weaver.selectdate.value = "<%= request.getParameter("selectdatefrom") %>";
	document.weaver.viewtype.value = "3";
	document.weaver.submit();
}

function showRemindTime(obj)
{
	if("1" == obj.value)
	{
		document.all("remindTime").style.display = "none";
		document.all("remindTimeLine").style.display = "none";
	}
	else
	{
		document.all("remindTime").style.display = "";
		document.all("remindTimeLine").style.display = "";
	}
}

function checkWorkPlanRemind()
{
	if(false == document.getElementsByName("remindType")[0].checked)
	{
		if($("remindBeforeStart").checked || $("remindBeforeEnd").checked)
		{
			return true;			
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(20238,user.getLanguage())%>");
			return false;
		}
	}
	else
	{
		$("remindBeforeStart").checked = false;
		$("remindBeforeEnd").checked = false;
		$("remindTimeBeforeStart").value = 10;
		$("remindTimeBeforeEnd").value = 10;
		
		return true;		
	}
}

function canBeSelected()
{
	if("input" == event.srcElement.tagName.toLowerCase() || "textarea" == event.srcElement.tagName.toLowerCase())
	{
		return true;		
	}
	else
	{
		return false;
	}
}

function onWPShowDate(spanname,inputname){
  var returnvalue;	  
  var oncleaingFun = function(){
		 $(spanname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"; 
		 $(inputname).value = '';
	}
   WdatePicker({onpicked:function(dp){
	returnvalue = dp.cal.getDateStr();	
	$dp.$(spanname).innerHTML = returnvalue;
	$dp.$(inputname).value = returnvalue;},oncleared:oncleaingFun});
}

function onWPNOShowDate(spanname,inputname){
  var returnvalue;	  
  var oncleaingFun = function(){
		 $(spanname).innerHTML = ""; 
		 $(inputname).value = '';
	}
   WdatePicker({onpicked:function(dp){
	returnvalue = dp.cal.getDateStr();	
	$dp.$(spanname).innerHTML = returnvalue;
	$dp.$(inputname).value = returnvalue;},oncleared:oncleaingFun});
}
function scrollCall()
{
	var divSave = document.getElementById("divSave");
	divSave.style.top = document.body.scrollTop+(document.body.clientHeight-divSave.style.posHeight)/2+"px";
	divSave.style.left = document.body.scrollLeft+(document.body.clientWidth-divSave.style.posWidth)/2+"px";
}
function resetSaveDiv()
{
	scrollCall();
}
window.onscroll=resetSaveDiv;
window.onresize=resetSaveDiv;
window.onload=resetSaveDiv;
</SCRIPT>

<SCRIPT language="VBScript">
sub onShowMultiHrmResourceNeeded(inputename,spanname)
    tmpIDs = document.all(inputename).value
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpIDs)
        if (Not IsEmpty(id1)) then
        if id1(0)<> "" then
          resourceIDs = id1(0)
          resourcename = id1(1)
          sHtml = ""
          resourceIDs = Mid(resourceIDs,2,len(resourceIDs))
          document.all(inputename).value= resourceIDs
          resourcename = Mid(resourcename,2,len(resourcename))
          while InStr(resourceIDs,",") <> 0
            curid = Mid(resourceIDs,1,InStr(resourceIDs,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceIDs = Mid(resourceIDs,InStr(resourceIDs,",")+1,Len(resourceIDs))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&curid&" target='_blank'>"&curname&"</a>&nbsp"
          wend
          sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&resourceIDs&" target='_blank'>"&resourcename&"</a>&nbsp"
          document.all(spanname).innerHtml = sHtml
          
        else
          document.all(spanname).innerHtml ="<IMG src='/images/BacoError.gif' align=absMiddle>"
          document.all(inputename).value=""
        end if
         end if
end sub
</SCRIPT>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>