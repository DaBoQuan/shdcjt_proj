<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*,weaver.hrm.report.schedulediff.*"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
User user = HrmUserVarify.getUser (request , response) ;
if (user != null) {
	out.print(currentTimeIsWorkTime(user));
} else {
	out.print("false");
}
%>

<%!
/**
 * ��ȡָ���û����ڷֲ�����ǰʱ�����Ƿ��ǹ���ʱ��
 */
private boolean currentTimeIsWorkTime(User user) throws Exception {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	HrmScheduleDiffUtil hrmScheduleDiffUtil = new HrmScheduleDiffUtil();
	hrmScheduleDiffUtil.setUser(user);
	
	String currentDate = sdf.format(new Date());
	
	Map workday = hrmScheduleDiffUtil.getOnDutyAndOffDutyTimeMap(currentDate, user.getUserSubCompany1());
	String offDutyTime = currentDate + " " + (String)workday.get("offDutyTimePM") + ":00";
	
	return new Date().before(sdf2.parse(offDutyTime));
}
%>
