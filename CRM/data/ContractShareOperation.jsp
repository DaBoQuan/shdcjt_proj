<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ContractViewer" class="weaver.crm.ContractViewer" scope="page"/>

<%
char flag = 2;
String ProcPara = "";
String id = Util.null2String(request.getParameter("id"));
String method = Util.null2String(request.getParameter("method"));
String contractId = Util.null2String(request.getParameter("contractId")); 
String CustomerID = Util.null2String(request.getParameter("CustomerID")); 
String relatedshareid = Util.null2String(request.getParameter("relatedshareid")); 
String sharetype = Util.null2String(request.getParameter("sharetype")); 
String rolelevel = Util.null2String(request.getParameter("rolelevel")); 
String seclevel = Util.null2String(request.getParameter("seclevel"));
String sharelevel = Util.null2String(request.getParameter("sharelevel"));
String CurrentUser = ""+user.getUID();
String ClientIP = request.getRemoteAddr();
String SubmiterType = ""+user.getLogintype();

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

String userid = "0" ;
String departmentid = "0" ;
String roleid = "0" ;
String foralluser = "0" ;

if(sharetype.equals("1")) userid = relatedshareid ;
if(sharetype.equals("2")) departmentid = relatedshareid ;
if(sharetype.equals("3")) roleid = relatedshareid ;
if(sharetype.equals("4")) foralluser = "1" ;

if(method.equals("delete"))
{

	RecordSet.executeProc("Contract_ShareInfo_Del",id);

	ContractViewer.setContractShareById(""+contractId);

	response.sendRedirect("/CRM/data/ContractShareAdd.jsp?contractId="+contractId+"&CustomerID="+CustomerID);
	return;
}


if(method.equals("add"))
{
	ProcPara = contractId;
	ProcPara += flag+sharetype;
	ProcPara += flag+seclevel;
	ProcPara += flag+rolelevel;
	ProcPara += flag+sharelevel;
	ProcPara += flag+userid;
	ProcPara += flag+departmentid;
	ProcPara += flag+roleid;
	ProcPara += flag+foralluser;

	RecordSet.executeProc("Contract_ShareInfo_Ins",ProcPara);

	ContractViewer.setContractShareById(""+contractId);

	response.sendRedirect("/CRM/data/ContractShareAdd.jsp?contractId="+contractId+"&CustomerID="+CustomerID);
	return;
}

%>
