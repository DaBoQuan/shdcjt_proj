<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CostcenterComInfo" class="weaver.hrm.company.CostCenterComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="JobGroupsComInfo" class="weaver.hrm.job.JobGroupsComInfo" scope="page"/>
<jsp:useBean id="JobActivitiesComInfo" class="weaver.hrm.job.JobActivitiesComInfo" scope="page"/>
<jsp:useBean id="LocationComInfo" class="weaver.hrm.location.LocationComInfo" scope="page"/>
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>
<jsp:useBean id="CompetencyComInfo" class="weaver.hrm.job.CompetencyComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="BankComInfo" class="weaver.hrm.finance.BankComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page"/>
<jsp:useBean id="RelatedRequestCount" class="weaver.workflow.request.RelatedRequestCount" scope="page"/>
<jsp:useBean id="UseKindComInfo" class="weaver.hrm.job.UseKindComInfo" scope="page"/>
<jsp:useBean id="JobTypeComInfo" class="weaver.hrm.job.JobTypeComInfo" scope="page"/>
<jsp:useBean id="JobCallComInfo" class="weaver.hrm.job.JobCallComInfo" scope="page"/>
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<%
String userid = Util.null2String(request.getParameter("id"));
RecordSet.execute("select * from HrmResource where id ='"+userid+"'");
RecordSet.next();


String workcode = Util.toScreenToEdit(RecordSet.getString("workcode"),user.getLanguage()) ;	/*����*/
String lastname = Util.toScreen(RecordSet.getString("lastname"),user.getLanguage()) ;			/*����*/
String sex = Util.toScreen(RecordSet.getString("sex"),user.getLanguage()) ;/*�Ա�:0:����1:Ů��2:δ֪*/
String birthday = Util.toScreen(RecordSet.getString("birthday"),user.getLanguage()) ;/*��������*/
String departmentid = Util.toScreen(RecordSet.getString("departmentid"),user.getLanguage()) ;		/*��������*/
String costcenterid = Util.toScreen(RecordSet.getString("costcenterid"),user.getLanguage()) ;
String subcompanyid = Util.toScreen(RecordSet.getString("subcompanyid1"),user.getLanguage()) ;
if(subcompanyid==null||subcompanyid.equals("")||subcompanyid.equalsIgnoreCase("null"))
 subcompanyid="-1";
session.setAttribute("hrm_subCompanyId",subcompanyid);
/*�����ɱ�����*/
String jobtitle = Util.toScreen(RecordSet.getString("jobtitle"),user.getLanguage()) ;			/*��λ*/
String joblevel = Util.toScreen(RecordSet.getString("joblevel"),user.getLanguage()) ;			/*ְ��*/

String jobactivitydesc = Util.toScreen(RecordSet.getString("jobactivitydesc"),user.getLanguage()) ;	/*ְ������*/
String managerid = Util.toScreen(RecordSet.getString("managerid"),user.getLanguage()) ;			/*ֱ���ϼ�*/
String assistantid = Util.toScreen(RecordSet.getString("assistantid"),user.getLanguage()) ;		/*����*/
String status = Util.toScreen(RecordSet.getString("status"),user.getLanguage()) ;

String locationid = Util.toScreen(RecordSet.getString("locationid"),user.getLanguage()) ;		/*�칫�ص�*/
String workroom = Util.toScreen(RecordSet.getString("workroom"),user.getLanguage()) ;			/*�칫��*/
String telephone = Util.toScreen(RecordSet.getString("telephone"),user.getLanguage()) ;			/*�칫�绰*/
String mobile = Util.toScreen(RecordSet.getString("mobile"),user.getLanguage()) ;			/*�ƶ��绰*/

String mobilecall = Util.toScreen(RecordSet.getString("mobilecall"),user.getLanguage()) ;		/*�����绰*/
String fax = Util.toScreen(RecordSet.getString("fax"),user.getLanguage()) ;				/*����*/
String email = Util.toScreen(RecordSet.getString("email"),user.getLanguage()) ;				/*����*/

String resourceimageid = Util.getFileidOut(RecordSet.getString("resourceimageid")) ;	/*��Ƭid ��SequenceIndex��õ�����ʹ�����ı������*/
int systemlanguage = Util.getIntValue(RecordSet.getString("systemlanguage"),7);
String jobcall = Util.toScreenToEdit(RecordSet.getString("jobcall"),user.getLanguage()) ;	/*��ְ��*/
String resourcetype = Util.toScreen(RecordSet.getString("resourcetype"),user.getLanguage()) ;
/*
������Դ����:
�а���: F
ְԱ: H
ѧ��: D
*/
String extphone = Util.toScreen(RecordSet.getString("extphone"),user.getLanguage()) ;		/*�ֻ��绰*/
String jobgroup= Util.toScreen(RecordSet.getString("jobgroup"),user.getLanguage()) ;		/*�������*/
String jobactivity= Util.toScreen(RecordSet.getString("jobactivitydesc"),user.getLanguage()) ;	/*ְ��*/
String createrid = Util.toScreen(RecordSet.getString("createrid"),user.getLanguage()) ;		/*������id*/

String createdate = Util.toScreen(RecordSet.getString("createdate"),user.getLanguage()) ;	/*��������*/
String lastmodid = Util.toScreen(RecordSet.getString("lastmodid"),user.getLanguage()) ;		/*����޸���id*/
String lastmoddate = Util.toScreen(RecordSet.getString("lastmoddate"),user.getLanguage()) ;	/*�޸�����*/
String lastlogindate = Util.toScreen(RecordSet.getString("lastlogindate"),user.getLanguage()) ;	/*����¼����*/

String jobtype = Util.toScreenToEdit(RecordSet.getString("jobtype"),user.getLanguage()) ;	/*ְ�����*/
String seclevel = Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage()) ;			/*��ȫ����*/

RecordSet.execute("select count(*) from HrmResource where managerid = '"+userid+"' and (status =0 or status = 1 or status =2 or status =3)");
RecordSet.next();
String subordinatescount = RecordSet.getString(1) ;

String imagesrc = ResourceComInfo.getMessagerUrls(userid);
if("".equals(imagesrc)){
	imagesrc = "/messager/images/dummyContact.png";
}
%>
<img src="<%=imagesrc %>" class="ContactsAvatar Absolute" style="right:0" />
<ul class="ContactsList">
<li id="ContactsListTit" class="cBlue2 FB FS16"><%=lastname %> </li>
<li><%=SystemEnv.getHtmlLabelName(416,user.getLanguage())%>�� <% if(sex.equals("0")) {%>
	                                <%=SystemEnv.getHtmlLabelName(417,user.getLanguage())%>
	                                <%} if(sex.equals("1")) {%>
	                                <%=SystemEnv.getHtmlLabelName(418,user.getLanguage())%>
	                                <%}%></li>

<li><%=SystemEnv.getHtmlLabelName(15713,user.getLanguage())%>��<%=telephone%> </li>
<li><%=SystemEnv.getHtmlLabelName(620,user.getLanguage())%>��<%=mobile%></li>
<li><%=SystemEnv.getHtmlLabelName(15714,user.getLanguage())%>��<%=mobilecall %></li>
<li><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%>��<%=email%></li>
<li><%=SystemEnv.getHtmlLabelName(494,user.getLanguage())%>��<%=fax %></li>
<li><%=SystemEnv.getHtmlLabelName(15709,user.getLanguage())%>�� <%=Util.toScreen(ResourceComInfo.getResourcename(managerid),user.getLanguage())%> </li>
<li><%=SystemEnv.getHtmlLabelName(382,user.getLanguage())%>�� <%=jobactivity %></li>
<li><%=SystemEnv.getHtmlLabelName(18939,user.getLanguage())%>��<%=DepartmentComInfo.getDepartmentname(departmentid) %>  </li>
<li><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%>��<%=JobTitlesComInfo.getJobTitlesname(jobtitle) %> </li>
<li><%=SystemEnv.getHtmlLabelName(15712,user.getLanguage())%>��<%=Util.toScreen(LocationComInfo.getLocationname(locationid),user.getLanguage())%> </li>
<li><%=SystemEnv.getHtmlLabelName(420,user.getLanguage())%>��<%=workroom%></li>
</ul>

