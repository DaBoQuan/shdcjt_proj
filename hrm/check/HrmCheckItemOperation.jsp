<%@ page import="java.security.*,weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CheckItemComInfo" class="weaver.hrm.check.CheckItemComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />

<%

String operation = Util.null2String(request.getParameter("operation")); 
String id = Util.null2String(request.getParameter("id"));  
String checkitemname = Util.fromScreen(request.getParameter("checkitemname"),user.getLanguage());/*���ͱ���*/
String checkitemexplain =    Util.fromScreen(request.getParameter("checkitemexplain"),user.getLanguage());/*Ա��id*/

char separator = Util.getSeparator() ;  
String para = "" ;  
   
if(operation.equalsIgnoreCase("add")){   
    para =checkitemname + separator + checkitemexplain ;
    
    rs.executeProc("HrmCheckItem_Insert",para);
    CheckItemComInfo.removeCheckCache() ;
	SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Util.getIntValue(id));
      SysMaintenanceLog.setRelatedName(checkitemname);
      SysMaintenanceLog.setOperateType("1");
      SysMaintenanceLog.setOperateDesc("HrmCheckItem_Insert"+para);
      SysMaintenanceLog.setOperateItem("96");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

	  response.sendRedirect("HrmCheckItem.jsp");    
      return;
}
else if(operation.equals("edit")){
    if(!HrmUserVarify.checkUserRight("HrmCheckItemEdit:Edit", user)){
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
 
    para =""+id + separator + checkitemname + separator + checkitemexplain ;
 
    RecordSet.executeProc("HrmCheckItem_Update",para);
    CheckItemComInfo.removeCheckCache() ;
	SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Util.getIntValue(id));
      SysMaintenanceLog.setRelatedName(checkitemname);
      SysMaintenanceLog.setOperateType("2");
      SysMaintenanceLog.setOperateDesc("HrmCheckItem_Update"+para);
      SysMaintenanceLog.setOperateItem("96");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();
	  response.sendRedirect("HrmCheckItem.jsp");
	  return;
}
else if(operation.equals("delete")){
    if(!HrmUserVarify.checkUserRight("HrmCheckItemEdit:Delete", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
	String sql2="select COUNT(*) AS Nums from HrmCheckKindItem where checkitemid="+id;
  	rs.executeSql(sql2);
	int existNums=0;      
	if(rs.next()){
		existNums=Util.getIntValue(rs.getString(1),0);
	}
	if(existNums>0){
	
		response.sendRedirect("HrmCheckItemEdit.jsp?isDelete=no&id="+id);
		return;
	}else{
		para = ""+id;    
		rs.executeProc("HrmCheckItem_Delete",para);
    para = ""+id;
	RecordSet.executeProc("HrmCheckItem_Delete",para);
	CheckItemComInfo.removeCheckCache() ;
	SysMaintenanceLog.resetParameter();
      SysMaintenanceLog.setRelatedId(Util.getIntValue(id));
      SysMaintenanceLog.setRelatedName(checkitemname);
      SysMaintenanceLog.setOperateType("3");
      SysMaintenanceLog.setOperateDesc("HrmCheckItem_Delete"+para);
      SysMaintenanceLog.setOperateItem("96");
      SysMaintenanceLog.setOperateUserid(user.getUID());
      SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
      SysMaintenanceLog.setSysLogInfo();

	  response.sendRedirect("HrmCheckItem.jsp");
	  return;
	}
}

CheckItemComInfo.removeCheckCache() ;
response.sendRedirect("/hrm/check/HrmCheckItem.jsp");
%>