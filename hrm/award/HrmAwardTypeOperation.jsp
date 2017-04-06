<%@ page import="java.security.*,weaver.general.Util,
                 weaver.conn.RecordSet" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="AwardComInfo" class="weaver.hrm.award.AwardComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
    /**
     * Added by Charoes Huang On May 19,
     * @param typeid
     * @return  a boolean value
     */
    private boolean canDelete(int typeid){
        boolean canDelete =true;
        String sqlStr ="Select COUNT(*) AS COUNT FROM HrmAwardInfo WHERE rptypeid ="+typeid;
        RecordSet rs = new RecordSet();
        rs.executeSql(sqlStr);
        if(rs.next()){
            if(rs.getInt("COUNT") > 0)
                canDelete = false;
        }
        return canDelete;
    }
%>
<%
String operation = Util.null2String(request.getParameter("operation"));  
String id = Util.null2String(request.getParameter("id"));  
String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());/*����*/
String awardtype = Util.fromScreen(request.getParameter("awardtype"),user.getLanguage()) ;       /*����*/

String description = Util.fromScreen(request.getParameter("description"),user.getLanguage()) ;	/*��Ӧ���*/
String transact = Util.fromScreen(request.getParameter("transact"),user.getLanguage()) ;	/*��ش���*/

char separator = Util.getSeparator() ;  
String para = "" ;
boolean canDelete =false;
if(operation.equalsIgnoreCase("add")){
    
    para = name+separator+awardtype+separator+description+separator+transact;
    rs.executeProc("HrmAwardType_Insert",para);
   
   rs.executeSql(" select * from HrmAwardType");
   rs.last();
   int idd=rs.getInt(1);
	    
      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(idd);
      SysMaintenanceLog.setRelatedName(name);
      SysMaintenanceLog.setOperateType("1");
      SysMaintenanceLog.setOperateDesc("HrmAwardType_Insert,"+para);
      SysMaintenanceLog.setOperateItem("94");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

    AwardComInfo.removeAwardCache(); 
    response.sendRedirect("HrmAwardType.jsp");
}


 if(operation.equals("edit")){
    if(!HrmUserVarify.checkUserRight("HrmRewardsTypeEdit:Edit", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
     
	 para = ""+id + separator + name + separator + awardtype + separator + description
		+separator + transact;
     
	RecordSet.executeProc("HrmAwardType_Update",para);

      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Integer.parseInt(id));
      SysMaintenanceLog.setRelatedName(name);
      SysMaintenanceLog.setOperateType("2");
      SysMaintenanceLog.setOperateDesc("HrmAwardType_Update,"+para);
      SysMaintenanceLog.setOperateItem("94");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

	AwardComInfo.removeAwardCache(); 
    response.sendRedirect("/hrm/award/HrmAwardType.jsp");
 }else if(operation.equals("delete")){
 	if(!HrmUserVarify.checkUserRight("HrmRewardsTypeEdit:Delete", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
	try{	
    canDelete = canDelete(Integer.valueOf(id).intValue());
	}catch(Exception e){
	
	}
    /*Modified By Charoes Huang On May 19,2004*/
    if(canDelete){
    para = ""+id;
	RecordSet.executeProc("HrmAwardType_Delete",para);
 
      SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Integer.parseInt(id));
      SysMaintenanceLog.setRelatedName(name);
      SysMaintenanceLog.setOperateType("3");
      SysMaintenanceLog.setOperateDesc("HrmAwardType_Delete,"+para);
      SysMaintenanceLog.setOperateItem("94");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

    AwardComInfo.removeAwardCache();
    }
	response.sendRedirect("HrmAwardType.jsp");
 }
%>