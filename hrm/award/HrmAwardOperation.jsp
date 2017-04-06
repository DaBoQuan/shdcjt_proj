<%@ page import="java.security.*,weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AwardComInfo" class="weaver.hrm.award.AwardComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%

String operation = Util.null2String(request.getParameter("operation")); 
String id = Util.null2String(request.getParameter("id"));  
String rptitle = Util.fromScreen(request.getParameter("rptitle"),user.getLanguage());/*���ͱ���*/
String resourceid =    Util.fromScreen(request.getParameter("resourceid"),user.getLanguage());/*Ա��id*/
String rptypeid = Util.fromScreen(request.getParameter("rptypeid"),user.getLanguage());/* ��������*/
String rpdate = Util.fromScreen(request.getParameter("rpdate"),user.getLanguage()) ;       /*��������*/	
String rpexplain = Util.fromScreen(request.getParameter("rpexplain"),user.getLanguage()) ;	/*˵��*/
String rptransact = Util.fromScreen(request.getParameter("rptransact"),user.getLanguage()) ;

char separator = Util.getSeparator() ;  
String para = "" ;  
  
if(operation.equalsIgnoreCase("add")){   
    para =rptitle + separator + resourceid + separator + rptypeid + separator + rpdate + separator + rpexplain + separator + rptransact;
    
     rs.executeProc("HrmAwardInfo_Insert",para);
     rs.executeSql(" select * from HrmAwardInfo");
     rs.last();
     int idd=rs.getInt(1);

      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(idd);
      SysMaintenanceLog.setRelatedName(rptitle);
      SysMaintenanceLog.setOperateType("1");
      SysMaintenanceLog.setOperateDesc("HrmAwardInfo_Insert,"+para);
      SysMaintenanceLog.setOperateItem("93");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

     AwardComInfo.removeAwardCache();
    response.sendRedirect("HrmAward.jsp");
}

if(operation.equals("edit")){
    if(!HrmUserVarify.checkUserRight("HrmResourceRewardsRecordEdit:Edit", user)){
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
 
    para =""+id + separator + rptitle + separator + resourceid + separator + rptypeid
    + separator + rpdate + separator + rpexplain + separator + rptransact ;
 
    RecordSet.executeProc("HrmAwardInfo_Update",para);
  
      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Integer.parseInt(id));
      SysMaintenanceLog.setRelatedName(rptitle);
      SysMaintenanceLog.setOperateType("2");
      SysMaintenanceLog.setOperateDesc("HrmAwardInfo_Update,"+para);
      SysMaintenanceLog.setOperateItem("93");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

    AwardComInfo.removeAwardCache();
    response.sendRedirect("/hrm/award/HrmAward.jsp");
}
 else if(operation.equals("delete")){
    if(!HrmUserVarify.checkUserRight("HrmResourceRewardsRecordEdit:Delete", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
    para = ""+id;
	RecordSet.executeProc("HrmAwardInfo_Delete",para);

      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Integer.parseInt(id));
      SysMaintenanceLog.setRelatedName(rptitle);
      SysMaintenanceLog.setOperateType("3");
      SysMaintenanceLog.setOperateDesc("HrmAwardInfo_Delete,"+para);
      SysMaintenanceLog.setOperateItem("93");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

    AwardComInfo.removeAwardCache();
	response.sendRedirect("HrmAward.jsp");  
 }
%>