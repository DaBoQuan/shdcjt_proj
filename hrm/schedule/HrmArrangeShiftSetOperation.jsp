<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
String resourceids[] = request.getParameterValues("resourceids") ;
String department = Util.null2String(request.getParameter("department")) ; //����
String fromdate = Util.fromScreen(request.getParameter("fromdate") , user.getLanguage()) ; //�Ű����ڴ�
String enddate = Util.fromScreen(request.getParameter("enddate") , user.getLanguage()) ; //�Ű����ڵ�
String selectresourceid = Util.null2String(request.getParameter("selectresourceid")) ; //ѡ�е���


rs.executeSql("delete HrmArrangeShiftSet where resourceid in ("+selectresourceid+")");

if( resourceids != null ) {

    for( int i=0 ; i< resourceids.length ; i++ ) {
        String resourceid = Util.null2String( resourceids[i] ) ;
        rs.executeProc("HrmArrangeShiftSet_Insert",resourceid);
    }
}

response.sendRedirect("HrmArrangeShiftSet.jsp?department="+department+"&fromdate="+fromdate+"&enddate="+enddate) ;
     
%>