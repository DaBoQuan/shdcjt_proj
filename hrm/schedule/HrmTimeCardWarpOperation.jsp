<%@ page import="weaver.general.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="HrmTimeCardInit" class="weaver.hrm.schedule.HrmTimeCardInit" scope="page"/>

<%
String opera = Util.null2String(request.getParameter("operation")) ; 
char separator = Util.getSeparator() ;
String procedurepara="";
String id = Util.null2String(request.getParameter("id")) ; // ��¼id
String fromdate = Util.null2String(request.getParameter("fromdate")) ; // ��
String todate = Util.null2String(request.getParameter("todate")) ; // ��
String resourceidpar = Util.null2String(request.getParameter("resourceid"));
String departmentidpar = Util.null2String(request.getParameter("departmentid"));
String startdate = Util.null2String(request.getParameter("startdate")) ; // ��
String enddate = Util.null2String(request.getParameter("enddate")) ; // ��
String isself = Util.null2String(request.getParameter("isself")) ; 

if( opera.equals("delete")) {  // ɾ��
    RecordSet.executeProc("HrmRightCardInfo_Delete" , id) ; 
    if(RecordSet.next()) {
        String resourceid = Util.null2String(RecordSet.getString(1)) ;
        String carddate = Util.null2String(RecordSet.getString(2)) ;
        if(!resourceid.equals("") && !carddate.equals("")) {
            HrmTimeCardInit.initTimecardInfo(resourceid,carddate,carddate) ;
        }
    }
}
else if( opera.equals("workout")) {        // ת��Ӱ�
    RecordSet.executeProc("HrmRightCardInfo_AddWork" , id) ; 
    if(RecordSet.next()) {
        String resourceid = Util.null2String(RecordSet.getString(1)) ;
        String carddate = Util.null2String(RecordSet.getString(2)) ;
        if(!resourceid.equals("") && !carddate.equals("")) {
            HrmTimeCardInit.initTimecardInfo(resourceid,carddate,carddate) ;
        }
    }
}
else if( opera.equals("recreate")) {        // �������ɸ�ʱ���ڵ�ƫ��
    RecordSet.executeSql(" update HrmRightCardInfo set islegal = 0 where carddate>='" + fromdate + 
                      "' and carddate<='" + enddate + "' and islegal = 2 ") ;
    HrmTimeCardInit.initTimecardInfo(startdate,enddate) ;
}


response.sendRedirect("HrmTimeCardWarpList.jsp?fromdate="+fromdate+"&todate="+todate+"&isself="+isself+"&resourceid="+resourceidpar+"&departmentid="+departmentidpar);

%>