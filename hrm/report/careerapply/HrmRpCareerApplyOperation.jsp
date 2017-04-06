<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="HrmCareerApplyComInfo" class="weaver.hrm.career.HrmCareerApplyComInfo" scope="session" />

<% 
char separator = Util.getSeparator() ;
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
int currentyear=today.get(Calendar.YEAR);
String Name=Util.fromScreen(request.getParameter("Name"),user.getLanguage());

HrmCareerApplyComInfo.setFromDate(Util.fromScreen(request.getParameter("FromDate"),user.getLanguage()));
HrmCareerApplyComInfo.setEndDate(Util.fromScreen(request.getParameter("EndDate"),user.getLanguage()))//ӦƸ����
;
HrmCareerApplyComInfo.setName(Util.fromScreen(request.getParameter("Name"),user.getLanguage())) ;	/*����*/
HrmCareerApplyComInfo.setJobTitle(Util.fromScreen(request.getParameter("jobtitle"),user.getLanguage())) ;/*ӦƸְλ*/

if (!request.getParameter("CareerAgeFrom").equals(""))
{
    String CareerAgeFrom=""+(currentyear-Util.getIntValue(request.getParameter("CareerAgeFrom"),0))+currentdate.substring(4) ;//���������ʱ��
    HrmCareerApplyComInfo.setCareerAgeFrom(CareerAgeFrom);    
}
if (!request.getParameter("CareerAgeTo").equals(""))
{
    String CareerAgeTo =""+(currentyear-Util.getIntValue(request.getParameter("CareerAgeTo"),0))+currentdate.substring(4);//����С����ʱ��
    HrmCareerApplyComInfo.setCareerAgeTo(CareerAgeTo);
}

HrmCareerApplyComInfo.setEducationLevel(Util.fromScreen(request.getParameter("EducationLevel"),user.getLanguage())) ;//ѧ��
HrmCareerApplyComInfo.setSex(Util.fromScreen(request.getParameter("Sex"),user.getLanguage())) ;//�Ա�
HrmCareerApplyComInfo.setMaritalStatus(Util.fromScreen(request.getParameter("MaritalStatus"),user.getLanguage())) ;//����
HrmCareerApplyComInfo.setRegResidentPlace(Util.fromScreen(request.getParameter("RegResidentPlace"),user.getLanguage())) ;//�������ڵ�
HrmCareerApplyComInfo.setCategory(Util.fromScreen(request.getParameter("Category"),user.getLanguage()));//���
HrmCareerApplyComInfo.setWorkTimeFrom(Util.fromScreen(request.getParameter("WorkTimeFrom"),user.getLanguage()));
HrmCareerApplyComInfo.setWorkTimeTo(Util.fromScreen(request.getParameter("WorkTimeTo"),user.getLanguage())); //��������
HrmCareerApplyComInfo.setSalaryNeedFrom(Util.fromScreen(request.getParameter("SalaryNeedFrom"),user.getLanguage())); 
HrmCareerApplyComInfo.setSalaryNeedTo(Util.fromScreen(request.getParameter("SalaryNeedTo"),user.getLanguage())); //��н����

String plan = Util.null2String(request.getParameter("plan"));

response.sendRedirect("/hrm/report/careerapply/HrmRpCareerApplyResult.jsp?plan="+plan);
%>