<%@ page import = "weaver.general.Util" %>
<%@ page import = "weaver.conn.*" %>
<jsp:useBean id = "RecordSet" class = "weaver.conn.RecordSet" scope = "page"/>
<jsp:useBean id = "log" class = "weaver.systeminfo.SysMaintenanceLog" scope = "page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file = "/systeminfo/init.jsp" %>

<%
/*
if(!HrmUserVarify.checkUserRight("HrmDefaultScheduleEdit:Edit", user)){
    response.sendRedirect("/notice/noright.jsp") ; 
    return ; 
}  */

String operation = Util.fromScreen(request.getParameter("operation") , user.getLanguage()) ; 


int id = Util.getIntValue(request.getParameter("id") , 0) ; // �༭����ɾ����ʱ����id

String monstarttime1 = Util.fromScreen(request.getParameter("monstarttime1") , user.getLanguage()) ; 
String monendtime1 = Util.fromScreen(request.getParameter("monendtime1") , user.getLanguage()) ; 
String monstarttime2 = Util.fromScreen(request.getParameter("monstarttime2") , user.getLanguage()) ; 
String monendtime2 = Util.fromScreen(request.getParameter("monendtime2") , user.getLanguage()) ; 

String tuestarttime1 = Util.fromScreen(request.getParameter("tuestarttime1") , user.getLanguage()) ; 
String tueendtime1 = Util.fromScreen(request.getParameter("tueendtime1") , user.getLanguage()) ; 
String tuestarttime2 = Util.fromScreen(request.getParameter("tuestarttime2") , user.getLanguage()) ; 
String tueendtime2 = Util.fromScreen(request.getParameter("tueendtime2") , user.getLanguage()) ; 

String wedstarttime1 = Util.fromScreen(request.getParameter("wedstarttime1") , user.getLanguage()) ; 
String wedendtime1 = Util.fromScreen(request.getParameter("wedendtime1") , user.getLanguage()) ; 
String wedstarttime2 = Util.fromScreen(request.getParameter("wedstarttime2") , user.getLanguage()) ; 
String wedendtime2 = Util.fromScreen(request.getParameter("wedendtime2") , user.getLanguage()) ; 

String thustarttime1 = Util.fromScreen(request.getParameter("thustarttime1") , user.getLanguage()) ; 
String thuendtime1 = Util.fromScreen(request.getParameter("thuendtime1") , user.getLanguage()) ; 
String thustarttime2 = Util.fromScreen(request.getParameter("thustarttime2") , user.getLanguage()) ; 
String thuendtime2 = Util.fromScreen(request.getParameter("thuendtime2") , user.getLanguage()) ; 

String fristarttime1 = Util.fromScreen(request.getParameter("fristarttime1") , user.getLanguage()) ; 
String friendtime1 = Util.fromScreen(request.getParameter("friendtime1") , user.getLanguage()) ; 
String fristarttime2 = Util.fromScreen(request.getParameter("fristarttime2") , user.getLanguage()) ; 
String friendtime2 = Util.fromScreen(request.getParameter("friendtime2") , user.getLanguage()) ; 

String satstarttime1 = Util.fromScreen(request.getParameter("satstarttime1") , user.getLanguage()) ; 
String satendtime1 = Util.fromScreen(request.getParameter("satendtime1") , user.getLanguage()) ; 
String satstarttime2 = Util.fromScreen(request.getParameter("satstarttime2") , user.getLanguage()) ; 
String satendtime2 = Util.fromScreen(request.getParameter("satendtime2") , user.getLanguage()) ; 

String sunstarttime1 = Util.fromScreen(request.getParameter("sunstarttime1") , user.getLanguage());
String sunendtime1 = Util.fromScreen(request.getParameter("sunendtime1") , user.getLanguage()) ; 
String sunstarttime2 = Util.fromScreen(request.getParameter("sunstarttime2") , user.getLanguage()) ; 
String sunendtime2 = Util.fromScreen(request.getParameter("sunendtime2") , user.getLanguage()) ; 

// ������Ч����
String validedatefrom = Util.fromScreen(request.getParameter("validedatefrom") , user.getLanguage()) ; 
String validedateto = Util.fromScreen(request.getParameter("validedateto") , user.getLanguage()) ; 

//�������ͺͶ���
String scheduleType = Util.fromScreen(request.getParameter("scheduleType") , user.getLanguage()) ;
if(scheduleType.trim().equals("")){
	scheduleType="3";
}
int relatedId= Util.getIntValue(request.getParameter("relatedId"),0);

//��ȡ����������
String relatedname = Util.fromScreen(request.getParameter("relatedname") , user.getLanguage()) ;
if(scheduleType.equals("3")&&relatedname.equals("")){
	relatedname="�ܲ�";
}

String totaltime = "" ; 
totaltime = Util.addTime(Util.subTime(monendtime1 , monstarttime1) , Util.subTime(monendtime2 , monstarttime2)) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(tueendtime1 , tuestarttime1) , Util.subTime(tueendtime2 , tuestarttime2))) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(wedendtime1 , wedstarttime1) , Util.subTime(wedendtime2 , wedstarttime2))) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(thuendtime1 , thustarttime1) , Util.subTime(thuendtime2 , thustarttime2))) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(friendtime1 , fristarttime1) , Util.subTime(friendtime2 , fristarttime2))) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(satendtime1 , satstarttime1) , Util.subTime(satendtime2 , satstarttime2))) ; 
totaltime = Util.addTime(totaltime , Util.addTime(Util.subTime(sunendtime1 , sunstarttime1) , Util.subTime(sunendtime2 , sunstarttime2))) ; 

char separator = Util.getSeparator() ; 

if(operation.equals("editschedule")) { 
	
	String procedurepara= "" + id + separator  + relatedId + separator + monstarttime1 + separator + monendtime1 + separator + monstarttime2 + separator + monendtime2 + separator + tuestarttime1 + separator + tueendtime1 + separator + tuestarttime2 + separator + tueendtime2 + separator + wedstarttime1 + separator + wedendtime1 + separator + wedstarttime2 + separator + wedendtime2 + separator +  thustarttime1 + separator+ thuendtime1 + separator + thustarttime2 + separator + thuendtime2 + separator + fristarttime1 + separator+ friendtime1 + separator + fristarttime2 + separator + friendtime2 + separator + satstarttime1 + separator+ satendtime1 + separator + satstarttime2 + separator + satendtime2 + separator + sunstarttime1 + separator+ sunendtime1 + separator + sunstarttime2 + separator + sunendtime2 + separator + totaltime + separator+ validedatefrom + separator+ validedateto+ separator+ scheduleType ; 
	
    RecordSet.executeProc("HrmSchedule_Update" , procedurepara) ; 
	log.resetParameter() ; 
	log.setRelatedId(id) ; 
    log.setRelatedName(relatedname) ; 
    log.setOperateType("2") ; 
//  log.setOperateDesc("HrmSchedule_Update") ; 
    log.setOperateItem("13") ; 
    log.setOperateUserid(user.getUID()) ; 
    log.setClientAddress(request.getRemoteAddr()) ; 
    log.setSysLogInfo() ; 
    response.sendRedirect("/hrm/schedule/HrmDefaultScheduleList.jsp") ; 
 
}
if(operation.equals("insertschedule")) { 
	    
        String procedurepara = "" + relatedId + separator  + monstarttime1 + separator+ monendtime1 + separator + monstarttime2 + separator + monendtime2 + separator + tuestarttime1 + separator+ tueendtime1 + separator + tuestarttime2 + separator + tueendtime2 + separator + wedstarttime1 + separator+ wedendtime1 + separator + wedstarttime2 + separator + wedendtime2 + separator + thustarttime1 + separator+ thuendtime1 + separator + thustarttime2 + separator + thuendtime2 + separator + fristarttime1 + separator +  friendtime1 + separator + fristarttime2 + separator + friendtime2 + separator + satstarttime1 + separator+ satendtime1 + separator + satstarttime2 + separator + satendtime2 + separator +            sunstarttime1 + separator+ sunendtime1 + separator + sunstarttime2 + separator + sunendtime2 + separator + totaltime + separator+ validedatefrom + separator+ validedateto+ separator+ scheduleType ; 
		
	RecordSet.executeProc("HrmSchedule_Insert" , procedurepara) ; 
    if( RecordSet.next() )  id = RecordSet.getInt(1) ; 	
	
    log.resetParameter() ; 
	log.setRelatedId(id) ; 
    log.setRelatedName(relatedname) ; 
    log.setOperateType("1") ; 
//  log.setOperateDesc("HrmSchedule_Insert") ; 
    log.setOperateItem("13") ; 
    log.setOperateUserid(user.getUID()) ; 
    log.setClientAddress(request.getRemoteAddr()) ; 
    log.setSysLogInfo() ; 
    response.sendRedirect("/hrm/schedule/HrmDefaultScheduleList.jsp") ; 
 } 

if(operation.equals("deleteschedule")) { //ɾ��
	
        String procedurepara = "" + id ;
		
	RecordSet.executeProc("HrmSchedule_Delete" , procedurepara) ; 
	
	log.resetParameter() ; 
	log.setRelatedId(id) ; 
    log.setRelatedName(relatedname) ; 
    log.setOperateType("3") ; 
//  log.setOperateDesc("HrmSchedule_Insert") ; 
    log.setOperateItem("13") ; 
    log.setOperateUserid(user.getUID()) ; 
    log.setClientAddress(request.getRemoteAddr()) ; 
    log.setSysLogInfo() ; 
	response.sendRedirect("/hrm/schedule/HrmDefaultScheduleList.jsp") ; 
 }
%>