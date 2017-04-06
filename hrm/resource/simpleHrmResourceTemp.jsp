<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/init.jsp" %>
<%@ page import="weaver.general.Util,
                 weaver.file.Prop,
                 weaver.login.Account,
				 weaver.login.VerifyLogin,
                 weaver.general.GCONST,
                 weaver.hrm.HrmUserVarify" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="AppDetachComInfo" class="weaver.hrm.appdetach.AppDetachComInfo" scope="page"/>
<jsp:useBean id="PluginUserCheck" class="weaver.license.PluginUserCheck" scope="page" />
<%
String id = request.getParameter("userid");
String ip = HrmUserVarify.getOnlineUserIp(id);

if(AppDetachComInfo.checkUserAppDetach(id, "1", user)==0) {
	out.print("$$$noright");
	return;
}

if("".equals(ip)) 
{
	ip = ",";
}

RecordSet.executeProc("HrmResource_SelectByID",id);
RecordSet.next();
String lastname = Util.toScreen(RecordSet.getString("lastname"),user.getLanguage()) ;			/*����*/
String sex = Util.toScreen(RecordSet.getString("sex"),user.getLanguage()) ;
String departmentid = Util.toScreen(RecordSet.getString("departmentid"),user.getLanguage()) ;		/*��������*/
departmentid=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid),user.getLanguage());
if("0".equals(sex))
{
	sex = "Mr.";
}
else if("1".equals(sex))
{
	sex="Ms.";	
}
String jobactivitydesc = Util.toScreen(RecordSet.getString("jobactivitydesc"),user.getLanguage()) ;	/*ְ������*/
String telephone = Util.toScreen(RecordSet.getString("telephone"),user.getLanguage()) ;			/*�칫�绰*/
String mobile = Util.toScreen(RecordSet.getString("mobile"),user.getLanguage()) ;			/*�ƶ��绰*/
String email = Util.toScreen(RecordSet.getString("email"),user.getLanguage()) ;				/*����*/

String resourceimageid = Util.getFileidOut(RecordSet.getString("resourceimageid")) ;	/*��Ƭid ��SequenceIndex��õ�����ʹ�����ı������*/
String managerid = Util.toScreen(RecordSet.getString("managerid"),user.getLanguage()) ;			/*ֱ���ϼ�*/
managerid=Util.toScreen(ResourceComInfo.getResourcename(managerid),user.getLanguage());
if("".equals(lastname)||null==lastname)
{
	String sql = "select * from HrmResourceManager where id="+id;	
	RecordSet.execute(sql);
	RecordSet.next();
	lastname = Util.toScreen(RecordSet.getString("lastname"),user.getLanguage()) ;
	sex = "Mr.";
}
if("".equals(lastname))
{
	lastname = ",";
}
if("".equals(sex))
{
	sex = ",";
}
if("".equals(mobile))
{
	mobile = ",";
}
if("".equals(telephone))
{
	telephone = ",";
}
if("".equals(email))
{
	email = ",";
}
if("".equals(departmentid))
{
	departmentid = ",";
}
if("".equals(jobactivitydesc))
{
	jobactivitydesc = ",";
}

String messager = "";
if((PluginUserCheck.getPluginAllUserId("messager").indexOf(id)!=-1)&&Util.getIntValue(id)!=user.getUID()){
	messager = "messager";
}


//System.out.println("resourceimageid : "+resourceimageid);
out.print("$$$ip="+ip+"$$$"+lastname+"$$$"+sex+"$$$"+mobile+"$$$"+telephone+"$$$"+email+"$$$"+departmentid+"$$$"+managerid+"$$$imageid="+resourceimageid+"$$$"+messager);
%>