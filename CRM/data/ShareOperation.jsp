<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<!--<jsp:useBean id="CrmViewer" class="weaver.crm.CrmViewer" scope="page"/>-->
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page"/>

<%
char flag = 2;
String ProcPara = "";
String id = Util.null2String(request.getParameter("id"));
String method = Util.null2String(request.getParameter("method"));
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
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
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
    //td11633 hww
    String user_id = "";
	RecordSet.executeSql("select userid from CRM_ShareInfo where id = "+id);
    if(RecordSet.next()) user_id = RecordSet.getString(1);
	
	RecordSet.executeProc("CRM_ShareInfo_Delete",id);

	ProcPara = CustomerID;
	ProcPara += flag+"ds";
	ProcPara += flag+"0";
	ProcPara += flag+id;
	ProcPara += flag+CurrentDate;
	ProcPara += flag+CurrentTime;
	ProcPara += flag+CurrentUser;
	ProcPara += flag+SubmiterType;
	ProcPara += flag+ClientIP;
	RecordSet.executeProc("CRM_Log_Insert",ProcPara);   	
	
	//CrmViewer.setCrmShareByCrm(""+CustomerID);
	CrmShareBase.resetContactShare(""+CustomerID);//���¼���ÿͻ��Ŀͻ���ϵ�Ĺ���
	
	//if(!"0".equals(user_id)){
	//	RecordSet.executeSql("delete from CrmShareDetail where crmid = "+CustomerID+" and userid ="+user_id);//td11633 hww
	//} else {
	//	RecordSet.executeSql("delete from CrmShareDetail where crmid = "+CustomerID+" and userid <> (select manager from CRM_CustomerInfo where id = "+CustomerID+")");//td11633 hww
	//}
	response.sendRedirect("/CRM/data/ViewCustomer.jsp?log=n&CustomerID="+CustomerID);
	return;
}


if(method.equals("add"))
{
	ProcPara = CustomerID;
	ProcPara += flag+sharetype;
	ProcPara += flag+seclevel;
	ProcPara += flag+rolelevel;
	ProcPara += flag+sharelevel;
	ProcPara += flag+userid;
	ProcPara += flag+departmentid;
	ProcPara += flag+roleid;
	ProcPara += flag+foralluser;
    String tempcontents="";
    if(sharetype.equals("1")) tempcontents = userid ;
    if(sharetype.equals("2")) tempcontents = departmentid ;
    if(sharetype.equals("3")) tempcontents = roleid ;
    if(sharetype.equals("4")) tempcontents = "1" ;
    ProcPara += flag+tempcontents;
	String Remark="sharetype:"+sharetype+"seclevel:"+seclevel+"rolelevel:"+rolelevel+"sharelevel:"+sharelevel+"userid:"+userid+"departmentid:"+departmentid+"roleid:"+roleid+"foralluser:"+foralluser;

	if(RecordSet.executeProc("CRM_ShareInfo_Insert",ProcPara)){
		String shareid = "";
		RecordSet.execute("select max(id) as id from CRM_ShareInfo");
		if(RecordSet.next()){
			shareid = RecordSet.getString("id");
		}
	
	if(sharetype.equals("3")){
	    String crm_manager = "";
	    RecordSet.executeSql("select manager from crm_customerinfo where id="+CustomerID);
	    if(RecordSet.next()) crm_manager = RecordSet.getString("manager");
	    int crm_manager_dept = Util.getIntValue(ResourceComInfo.getDepartmentID(crm_manager),-1);//����id
	    int crm_manager_com = Util.getIntValue(ResourceComInfo.getSubCompanyID(crm_manager),-1);//�ֲ�id
	    if(rolelevel.equals("0"))
	        RecordSet.executeSql("update CRM_ShareInfo set deptorcomid="+crm_manager_dept+" where relateditemid="+CustomerID+" and id="+shareid);
	    else if(rolelevel.equals("1"))
	        RecordSet.executeSql("update CRM_ShareInfo set deptorcomid="+crm_manager_com+" where relateditemid="+CustomerID+" and id="+shareid);
	}

	ProcPara = CustomerID;
	ProcPara += flag+"ns";
	ProcPara += flag+"0";
	ProcPara += flag+Remark;
	ProcPara += flag+CurrentDate;
	ProcPara += flag+CurrentTime;
	ProcPara += flag+CurrentUser;
	ProcPara += flag+SubmiterType;
	ProcPara += flag+ClientIP;
	RecordSet.executeProc("CRM_Log_Insert",ProcPara);

	//CrmViewer.setCrmShareByCrm(""+CustomerID);
	RecordSet.executeSql("select max(id) as shareobjid from CRM_ShareInfo");
	RecordSet.next();
	String shareobjid = RecordSet.getString("shareobjid");
	CrmShareBase.setCRM_WPShare_newCRMShare(""+CustomerID,shareobjid);
	if(!isfromtab)
		response.sendRedirect("/CRM/data/ViewCustomer.jsp?log=n&CustomerID="+CustomerID);
	else
		response.sendRedirect("/CRM/data/ViewCustomerBase.jsp?log=n&CustomerID="+CustomerID);
	return;
	}
}

if(method.equals("edit"))
{
	String oldsharetype = "";
	String oldcontents = "";
	String oldroleid = "";
	String oldrolelevel = "";
	String oldforalluser = "";
	String oldseclevel = "";
	RecordSet.executeSql("select * from CRM_ShareInfo where id="+id);
	if(RecordSet.next()){
	    oldsharetype = RecordSet.getString("sharetype");
	    oldcontents = RecordSet.getString("contents");
	    oldroleid = RecordSet.getString("roleid");
	    oldrolelevel = RecordSet.getString("rolelevel");
	    oldforalluser = RecordSet.getString("foralluser");
	    oldseclevel = RecordSet.getString("seclevel");
	}
	
	ProcPara = id;
	ProcPara += CustomerID;
	ProcPara += flag+sharetype;
	ProcPara += flag+seclevel;
	ProcPara += flag+rolelevel;
	ProcPara += flag+sharelevel;
	ProcPara += flag+userid;
	ProcPara += flag+departmentid;
	ProcPara += flag+roleid;
	ProcPara += flag+foralluser;
	String tempcontents="";
    if(sharetype.equals("1")) tempcontents = userid ;
    if(sharetype.equals("2")) tempcontents = departmentid ;
    if(sharetype.equals("3")) tempcontents = roleid ;
    if(sharetype.equals("4")) tempcontents = "1" ;
    ProcPara += flag+tempcontents;
	RecordSet.executeProc("CRM_ShareInfo_Update",ProcPara);
	if(sharetype.equals("3")){
	    String crm_manager = "";
	    RecordSet.executeSql("select manager from crm_customerinfo where id="+CustomerID);
	    if(RecordSet.next()) crm_manager = RecordSet.getString("manager");
	    int crm_manager_dept = Util.getIntValue(ResourceComInfo.getDepartmentID(crm_manager),-1);//����id
	    int crm_manager_com = Util.getIntValue(ResourceComInfo.getSubCompanyID(crm_manager),-1);//�ֲ�id
	    if(rolelevel.equals("0"))
	        RecordSet.executeSql("update CRM_ShareInfo set deptorcomid="+crm_manager_dept+" where relateditemid="+CustomerID+" and id="+id);
	    else if(rolelevel.equals("1"))
	        RecordSet.executeSql("update CRM_ShareInfo set deptorcomid="+crm_manager_com+" where relateditemid="+CustomerID+" and id="+id);
	}
	//CrmViewer.setCrmShareByCrm(""+CustomerID);
	//�༭����ʱ���¼���ͻ���ϵ�Ĺ���
	if(!sharetype.equals(oldsharetype)||!tempcontents.equals(oldcontents)||!roleid.equals(oldroleid)||!rolelevel.equals(oldrolelevel)||!foralluser.equals(oldforalluser)||!seclevel.equals(oldseclevel)) 
	    CrmShareBase.resetContactShare(""+CustomerID);

	response.sendRedirect("/CRM/data/ViewCustomer.jsp?CustomerID="+CustomerID);
	return;
}
%>
