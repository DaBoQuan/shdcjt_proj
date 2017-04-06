<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="HrmCareerApplyComInfo" class="weaver.hrm.career.HrmCareerApplyComInfo" scope="session" />

<% char separator = Util.getSeparator() ;


Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

int currentyear=today.get(Calendar.YEAR);                 
String Name=Util.fromScreen(request.getParameter("Name"),user.getLanguage());

HrmCareerApplyComInfo.setCareerInvite(Util.fromScreen(request.getParameter("careerinvite"),user.getLanguage()));

HrmCareerApplyComInfo.setFromDate(Util.fromScreen(request.getParameter("FromDate"),user.getLanguage()));
HrmCareerApplyComInfo.setEndDate(Util.fromScreen(request.getParameter("EndDate"),user.getLanguage()))
;
HrmCareerApplyComInfo.setName(Util.fromScreen(request.getParameter("Name"),user.getLanguage())) ;	/*����*/
HrmCareerApplyComInfo.setJobTitle(Util.fromScreen(request.getParameter("jobtitle"),user.getLanguage())) ;/*ӦƸְλ*/
HrmCareerApplyComInfo.setIsCheck(Util.fromScreen(request.getParameter("IsCheck"),user.getLanguage())) ;/*����*/
if (!request.getParameter("CareerAgeFrom").equals(""))
{
String CareerAgeFrom=""+(currentyear-Util.getIntValue(request.getParameter("CareerAgeFrom"),0))+currentdate.substring(4) ;//���������ʱ��
HrmCareerApplyComInfo.setCareerAgeFrom(CareerAgeFrom);
HrmCareerApplyComInfo.setAgeFrom(Util.getIntValue(request.getParameter("CareerAgeFrom"),0));
}
if (!request.getParameter("CareerAgeTo").equals(""))
{
String CareerAgeTo =""+(currentyear-Util.getIntValue(request.getParameter("CareerAgeTo"),0))+currentdate.substring(4);//����С����ʱ��
HrmCareerApplyComInfo.setCareerAgeTo(CareerAgeTo);
HrmCareerApplyComInfo.setAgeTo(Util.getIntValue(request.getParameter("CareerAgeTo"),0));
}
HrmCareerApplyComInfo.setHeightFrom(Util.fromScreen(request.getParameter("HeightFrom"),user.getLanguage()));//��������
HrmCareerApplyComInfo.setHeightTo(Util.fromScreen(request.getParameter("HeightTo"),user.getLanguage())) ;//����С���
HrmCareerApplyComInfo.setEducationLevel(Util.fromScreen(request.getParameter("EducationLevel"),user.getLanguage())) ;//ѧ��
HrmCareerApplyComInfo.setSex(Util.fromScreen(request.getParameter("Sex"),user.getLanguage())) ;//�Ա�
HrmCareerApplyComInfo.setMaritalStatus(Util.fromScreen(request.getParameter("MaritalStatus"),user.getLanguage())) ;//����
HrmCareerApplyComInfo.setRegResidentPlace(Util.fromScreen(request.getParameter("RegResidentPlace"),user.getLanguage())) ;//�������ڵ�
HrmCareerApplyComInfo.setCategory(Util.fromScreen(request.getParameter("Category"),user.getLanguage()));//���
HrmCareerApplyComInfo.setMajor(Util.fromScreen(request.getParameter("Major"),user.getLanguage()));//רҵ
HrmCareerApplyComInfo.setWorkTimeFrom(Util.fromScreen(request.getParameter("WorkTimeFrom"),user.getLanguage()));
HrmCareerApplyComInfo.setWorkTimeTo(Util.fromScreen(request.getParameter("WorkTimeTo"),user.getLanguage())); //��������
HrmCareerApplyComInfo.setDegree(Util.fromScreen(request.getParameter("Degree"),user.getLanguage())); //ѧλ
HrmCareerApplyComInfo.setSchool(Util.fromScreen(request.getParameter("School"),user.getLanguage())); //���Ͷ�ѧУ
HrmCareerApplyComInfo.setCompany(Util.fromScreen(request.getParameter("Company"),user.getLanguage())); //����ҵ��˾
HrmCareerApplyComInfo.setPolicy(Util.fromScreen(request.getParameter("Policy"),user.getLanguage())); //������ò
HrmCareerApplyComInfo.setNativePlace(Util.fromScreen(request.getParameter("NativePlace"),user.getLanguage())); //����
HrmCareerApplyComInfo.setResidentPlace(Util.fromScreen(request.getParameter("ResidentPlace"),user.getLanguage())); //�־�ס��
HrmCareerApplyComInfo.setNationality(Util.fromScreen(request.getParameter("Nationality"),user.getLanguage())); //����
HrmCareerApplyComInfo.setDefaultLanguage(Util.fromScreen(request.getParameter("DefaultLanguage"),user.getLanguage())); //��������
HrmCareerApplyComInfo.setTrain(Util.fromScreen(request.getParameter("Train"),user.getLanguage())); //��ѵ������֤��

HrmCareerApplyComInfo.setSalaryNowFrom(Util.fromScreen(request.getParameter("SalaryNowFrom"),user.getLanguage())); 
HrmCareerApplyComInfo.setSalaryNowTo(Util.fromScreen(request.getParameter("SalaryNowTo"),user.getLanguage())); 
HrmCareerApplyComInfo.setOldJob(Util.fromScreen(request.getParameter("oldjob"),user.getLanguage())); 
HrmCareerApplyComInfo.setSalaryNeedFrom(Util.fromScreen(request.getParameter("SalaryNeedFrom"),user.getLanguage())); 
HrmCareerApplyComInfo.setSalaryNeedTo(Util.fromScreen(request.getParameter("SalaryNeedTo"),user.getLanguage())); 
HrmCareerApplyComInfo.setWeightFrom(Util.fromScreen(request.getParameter("WeightFrom"),user.getLanguage())); 
HrmCareerApplyComInfo.setWeightTo(Util.fromScreen(request.getParameter("WeightTo"),user.getLanguage())); 

HrmCareerApplyComInfo.setSubCompanyId(Util.fromScreen(request.getParameter("subCompanyId"),user.getLanguage()));

response.sendRedirect("/hrm/career/HrmCareerApplyResult.jsp?start=1&perpage=10");
%>