<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<%
char flag = 2;
String ProcPara = "";
String CurrentUser = ""+user.getUID();
String SubmiterType = ""+user.getLogintype();
String ClientIP = request.getRemoteAddr();

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

String method = Util.null2String(request.getParameter("method"));
String taskrecordid=Util.null2String(request.getParameter("taskrecordid"));
String recordid=Util.null2String(request.getParameter("recordid"));
RecordSet.executeProc("Prj_TaskProcess_SelectByID",taskrecordid);
RecordSet.next();
String projid=RecordSet.getString("prjid");
String taskid=RecordSet.getString("taskid");
String version="|"+RecordSet.getString("version")+"|";
String material=Util.null2String(request.getParameter("material"));
String unit=Util.null2String(request.getParameter("unit"));
String begindate=Util.null2String(request.getParameter("begindate"));
String enddate=Util.null2String(request.getParameter("enddate"));
String quantity=Util.null2String(request.getParameter("quantity"));
String cost=Util.null2String(request.getParameter("cost"));
if(quantity.equals("")) quantity = "0" ;
if(cost.equals("")) cost = "0" ;

if(method.equals("add"))
{
	ProcPara = projid;
	ProcPara += flag+taskid;
	ProcPara += flag+material;
	ProcPara += flag+unit;
	ProcPara += flag+"2";
	ProcPara += flag+begindate;
	ProcPara += flag+enddate;
	ProcPara += flag+quantity;
	ProcPara += flag+cost;
	RecordSet.executeProc("Prj_MaterialProcess_Insert",ProcPara);

	response.sendRedirect("/proj/plan/ViewTaskProcess.jsp?log=n&taskrecordid="+taskrecordid);
	return;
}
if(method.equals("edit"))
{
	ProcPara = recordid;
	ProcPara += flag+material;
	ProcPara += flag+unit;
	ProcPara += flag+begindate;
	ProcPara += flag+enddate;
	ProcPara += flag+quantity;
	ProcPara += flag+cost;
	RecordSet.executeProc("Prj_MaterialProcess_Update",ProcPara);

	response.sendRedirect("/proj/plan/ViewTaskProcess.jsp?log=n&taskrecordid="+taskrecordid);
	return;
}
if(method.equals("delete"))
{
	ProcPara = recordid;
	RecordSet.executeProc("Prj_MaterialProcess_Delete",ProcPara);

	response.sendRedirect("/proj/plan/ViewTaskProcess.jsp?log=n&taskrecordid="+taskrecordid);
	return;
}
%>
