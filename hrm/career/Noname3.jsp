<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.null2String(request.getParameter("operation"));

char separator = Util.getSeparator() ;


Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
String applyid="";
applyid = Util.null2String(request.getParameter("applyid"));

if(operation.equals("addcareerapply")&&applyid.equals("")){

RecordSet.executeProc("SequenceIndex_Update","resourceid");
RecordSet.next();

applyid = RecordSet.getString("currentid");

String firstname = Util.fromScreen(request.getParameter("firstname"),user.getLanguage()) ;			/*��*/
String lastname = Util.fromScreen(request.getParameter("lastname"),user.getLanguage()) ;			/*��*/
String aliasname= Util.fromScreen(request.getParameter("aliasname"),user.getLanguage()) ;				/*����*/
String titleid= Util.fromScreen(request.getParameter("titleid"),user.getLanguage()) ;				/*�ƺ�*/
String sex = Util.fromScreen(request.getParameter("sex"),user.getLanguage()) ;
String birthday = Util.fromScreen(request.getParameter("birthday"),user.getLanguage()) ;			/*����*/
String nationality = Util.fromScreen(request.getParameter("nationality"),user.getLanguage()) ;		/*����*/
String defaultlanguage = Util.fromScreen(request.getParameter("defaultlanguage"),user.getLanguage()) ;	/*��������*/
String maritalstatus = Util.fromScreen(request.getParameter("maritalstatus"),user.getLanguage()) ;
String marrydate = Util.fromScreen(request.getParameter("marrydate"),user.getLanguage()) ;			/*�������*/
String email = Util.fromScreen(request.getParameter("email"),user.getLanguage()) ;				/*����*/
String homeaddress = Util.fromScreen(request.getParameter("homeaddress"),user.getLanguage()) ;				/*��ͥ��ַ*/
String homepostcode = Util.fromScreen(request.getParameter("homepostcode"),user.getLanguage()) ;				/*��ͥ�ʱ�*/
String homephone = Util.fromScreen(request.getParameter("homephone"),user.getLanguage()) ;				/*��ͥ�绰*/
String certificatecategory = Util.fromScreen(request.getParameter("certificatecategory"),user.getLanguage()) ;/**/
String certificatenum = Util.fromScreen(request.getParameter("certificatenum"),user.getLanguage()) ;			/*֤������*/
String nativeplace = Util.fromScreen(request.getParameter("nativeplace"),user.getLanguage()) ;				/*����*/
String educationlevel = Util.fromScreen(request.getParameter("educationlevel"),user.getLanguage()) ;			/*ѧ��*/
String bememberdate = Util.fromScreen(request.getParameter("bememberdate"),user.getLanguage()) ;				/*��������*/
String bepartydate = Util.fromScreen(request.getParameter("bepartydate"),user.getLanguage()) ;				/*�뵳����*/
String bedemocracydate = Util.fromScreen(request.getParameter("bedemocracydate"),user.getLanguage()) ;		/*��������*/
String regresidentplace = Util.fromScreen(request.getParameter("regresidentplace"),user.getLanguage()) ;		/*�������ڵ�*/
String healthinfo = Util.fromScreen(request.getParameter("healthinfo"),user.getLanguage()) ;					/*����״��*/
String residentplace = Util.fromScreen(request.getParameter("residentplace"),user.getLanguage()) ;			/*�־�ס��*/
String policy = Util.fromScreen(request.getParameter("policy"),user.getLanguage()) ;							/*������ò*/
String degree = Util.fromScreen(request.getParameter("degree"),user.getLanguage()) ;							/*ѧλ*/
String height = Util.fromScreen(request.getParameter("height"),user.getLanguage()) ;							/*���*/
String homepage = Util.fromScreen(request.getParameter("homepage"),user.getLanguage()) ;						/*������ҳ*/
String train = Util.fromScreen(request.getParameter("train"),user.getLanguage()) ;							/*��ѵ������֤��*/
String contactor = Util.fromScreen(request.getParameter("contactor"),user.getLanguage()) ;							/*��ϵ��*/
String category = Util.fromScreen(request.getParameter("category"),user.getLanguage()) ;						/*ӦƸ�����*/
String major = Util.fromScreen(request.getParameter("major"),user.getLanguage()) ;						/*רҵ*/							
String salarynow = Util.fromScreen(request.getParameter("salarynow"),user.getLanguage()) ;				/*��ǰ��н*/
String worktime = Util.fromScreen(request.getParameter("worktime"),user.getLanguage()) ;				/*��������*/
String salaryneed = Util.fromScreen(request.getParameter("salaryneed"),user.getLanguage()) ;				/*��н����*/				
String reason = Util.fromScreen(request.getParameter("reason"),user.getLanguage()) ;							/**/
String otherrequest = Util.fromScreen(request.getParameter("otherrequest"),user.getLanguage()) ;		/**/
String selfcomment = Util.fromScreen(request.getParameter("selfcomment"),user.getLanguage()) ;		/*�Լ���*/
String currencyid = Util.fromScreen(request.getParameter("currencyid"),user.getLanguage()) ;				/*����*/

String careerid = Util.null2String(request.getParameter("careerid"));

	String para = "";
	
	para  = applyid;
	para += separator+"0";
	para += separator+"0";
	para += separator+careerid;
	para += separator+firstname;
	para += separator+lastname;
	para += separator+titleid;
	para += separator+sex;
	para += separator+birthday;
	para += separator+nationality;
	para += separator+defaultlanguage;
	para += separator+certificatecategory;
	para += separator+certificatenum;
	para += separator+nativeplace;
	para += separator+educationlevel;
	para += separator+bememberdate;
	para += separator+bepartydate;
	para += separator+bedemocracydate;
	para += separator+regresidentplace;
	para += separator+healthinfo;
	para += separator+residentplace;
	para += separator+policy;
	para += separator+degree;
	para += separator+height;
	para += separator+homepage;
	para += separator+maritalstatus;
	para += separator+marrydate;
	para += separator+train;
	para += separator+email;
	para += separator+homeaddress;
	para += separator+homepostcode;
	para += separator+homephone;
	para += separator+category;
	para += separator+contactor;
	para += separator+major;
	para += separator+salarynow;
	para += separator+worktime;
	para += separator+salaryneed;
	para += separator+currencyid;
	para += separator+reason;
	para += separator+otherrequest;
	para += separator+selfcomment;
	para += separator+currentdate;

	RecordSet.executeProc("HrmCareerApply_Insert",para);
    %>
	<input type=hidden name=applyid value="<%=applyid%>">

    <%
	response.sendRedirect("HrmCareerApplyAddConfirm.jsp?applyid="+applyid);
}
 else if(operation.equals("editpass")){
	
	String para = applyid+separator+"0";

	RecordSet.executeProc("HrmCareerApply_Update",para);
	RecordSet.next();

	response.sendRedirect("HrmCareerApply.jsp?");
}//end if 
 else if(operation.equals("edithire")||(operation.equals("addcareerapply")&&!applyid.equals(""))){
	

	String loginid = Util.fromScreen(request.getParameter("loginid"),user.getLanguage()) ;				/*��½id*/
	String password = Util.getEncrypt(Util.fromScreen(request.getParameter("password"),user.getLanguage())) ;				/*����*/
	String systemlanguage = Util.fromScreen(request.getParameter("systemlanguage"),user.getLanguage()) ;				/*ϵͳ����*/
	String countryid = Util.fromScreen(request.getParameter("countryid"),user.getLanguage()) ;				/*��������*/
	String jobtitle = Util.fromScreen(request.getParameter("jobtitle"),user.getLanguage()) ;				/*ְλ*/
	String departmentid = Util.fromScreen(request.getParameter("departmentid"),user.getLanguage()) ;				/*����*/
	String costcenterid = Util.fromScreen(request.getParameter("costcenterid"),user.getLanguage()) ;				/*�ɱ�����*/
	String managerid = Util.fromScreen(request.getParameter("managerid"),user.getLanguage()) ;				/*����*/
	String seclevel = Util.fromScreen(request.getParameter("seclevel"),user.getLanguage()) ;				/*��ȫ����*/

	RecordSet.executeProc("HrmCareerApply_SelectById",applyid);
	RecordSet.next();

	String careerid = Util.null2String(RecordSet.getString("careerid"));
	String ischeck = Util.null2String(RecordSet.getString("ischeck"));
	String ishire = Util.null2String(RecordSet.getString("ishire"));
	String firstname = Util.toScreen(RecordSet.getString("firstname"),user.getLanguage()) ;			/*��*/
	String lastname = Util.toScreen(RecordSet.getString("lastname"),user.getLanguage()) ;			/*��*/
	String titleid= Util.toScreen(RecordSet.getString("titleid"),user.getLanguage()) ;				/*�ƺ�*/
	String sex = Util.toScreen(RecordSet.getString("sex"),user.getLanguage()) ;
	String birthday = Util.toScreen(RecordSet.getString("birthday"),user.getLanguage()) ;			/*����*/
	String nationality = Util.toScreen(RecordSet.getString("nationality"),user.getLanguage()) ;		/*����*/
	String defaultlanguage = Util.toScreen(RecordSet.getString("defaultlanguage"),user.getLanguage()) ;	/*��������*/
	String maritalstatus = Util.toScreen(RecordSet.getString("maritalstatus"),user.getLanguage()) ;
	String marrydate = Util.toScreen(RecordSet.getString("marrydate"),user.getLanguage()) ;			/*�������*/	
	String email = Util.toScreen(RecordSet.getString("email"),user.getLanguage()) ;				/*����*/
	String homeaddress = Util.toScreen(RecordSet.getString("homeaddress"),user.getLanguage()) ;				/*��ͥ��ַ*/
	String homepostcode = Util.toScreen(RecordSet.getString("homepostcode"),user.getLanguage()) ;				/*��ͥ�ʱ�*/
	String homephone = Util.toScreen(RecordSet.getString("homephone"),user.getLanguage()) ;				/*��ͥ�绰*/
	String certificatecategory = Util.toScreen(RecordSet.getString("certificatecategory"),user.getLanguage()) ;/**/
	String certificatenum = Util.toScreen(RecordSet.getString("certificatenum"),user.getLanguage()) ;			/*֤������*/
	String nativeplace = Util.toScreen(RecordSet.getString("nativeplace"),user.getLanguage()) ;				/*����*/
	String educationlevel = Util.toScreen(RecordSet.getString("educationlevel"),user.getLanguage()) ;			/*ѧ��*/
	String bememberdate = Util.toScreen(RecordSet.getString("bememberdate"),user.getLanguage()) ;				/*��������*/
	String bepartydate = Util.toScreen(RecordSet.getString("bepartydate"),user.getLanguage()) ;				/*�뵳����*/
	String bedemocracydate = Util.toScreen(RecordSet.getString("bedemocracydate"),user.getLanguage()) ;		/*��������*/
	String regresidentplace = Util.toScreen(RecordSet.getString("regresidentplace"),user.getLanguage()) ;		/*�������ڵ�*/
	String healthinfo = Util.toScreen(RecordSet.getString("healthinfo"),user.getLanguage()) ;					/*����״��*/
	String residentplace = Util.toScreen(RecordSet.getString("residentplace"),user.getLanguage()) ;			/*�־�ס��*/
	String policy = Util.toScreen(RecordSet.getString("policy"),user.getLanguage()) ;							/*������ò*/	
	String degree = Util.toScreen(RecordSet.getString("degree"),user.getLanguage()) ;							/*ѧλ*/
	String height = Util.toScreen(RecordSet.getString("height"),user.getLanguage()) ;							/*���*/
	String homepage = Util.toScreen(RecordSet.getString("homepage"),user.getLanguage()) ;						/*������ҳ*/
	String train = Util.toScreen(RecordSet.getString("train"),user.getLanguage()) ;							/*��ѵ������֤��*/					
	String createrid = ""+user.getUID();

	String para = applyid+separator+"1";

	RecordSet.executeProc("HrmCareerApply_Update",para);

	para = "";
	
	para  = applyid;
	para += separator+loginid;
	para += separator+password;
	para += separator+firstname;
	para += separator+lastname;
	para += separator+"";
	para += separator+titleid;
	para += separator+sex;
	para += separator+birthday;
	para += separator+nationality;
	para += separator+defaultlanguage;
	para += separator+systemlanguage;
	para += separator+maritalstatus;
	para += separator+marrydate;
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+email;
	para += separator+countryid;
	para += separator+"";
	para += separator+"";
	para += separator+homeaddress;
	para += separator+homepostcode;
	para += separator+homephone;
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+jobtitle;
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+seclevel;
	para += separator+departmentid;
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+costcenterid;
	para += separator+managerid;
	para += separator+"";
	para += separator+"0.0";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+createrid;
	para += separator+currentdate;
	para += separator+"";
	para += separator+"";

	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"0.0";
	para += separator+"0.0";
	para += separator+"0.0";
	para += separator+"0.0";
	para += separator+"0.0";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"0";
	para += separator+"0";
	para += separator+"0";
	para += separator+"0";
	para += separator+"0";

	para += separator+certificatecategory;
	para += separator+certificatenum;
	para += separator+nativeplace;
	para += separator+educationlevel;
	para += separator+bememberdate;
	para += separator+bepartydate;
	para += separator+bedemocracydate;
	para += separator+regresidentplace;
	para += separator+healthinfo;
	para += separator+residentplace;
	para += separator+policy;
	para += separator+degree;
	para += separator+height;
	para += separator+homepage;
	para += separator+train;
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";
	para += separator+"";

	RecordSet.executeProc("HrmResource_Insert",para);

	
	RecordSet.executeProc("HrmCareerApply_Delete",applyid);
		
	SysMaintenanceLog.setRelatedId(Util.getIntValue(applyid));
	SysMaintenanceLog.setOperateType("1");
	SysMaintenanceLog.setOperateDesc("HrmResource_Insert,"+para);
	SysMaintenanceLog.setSysLogInfo();

	ResourceComInfo.removeResourceCache();

 	response.sendRedirect("../resource/HrmResource.jsp?id="+applyid);
 

}
else if(operation.equals("deletecareerapply")){
	
	RecordSet.executeProc("HrmCareerApply_Delete",applyid);
	RecordSet.next();

	response.sendRedirect("HrmCareerApply.jsp");
 }
%>
