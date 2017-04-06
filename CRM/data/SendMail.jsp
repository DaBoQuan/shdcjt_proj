<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="SendMail" class="weaver.crm.Maint.SendMail" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CRMSearchComInfo" class="weaver.crm.search.SearchComInfo" scope="session" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />

<%
String leftjointable = CrmShareBase.getTempTable(""+user.getUID());
  
	String CRM_SearchSql="";
if(user.getLogintype().equals("1")){	
	CRM_SearchSql = "select distinct t1.id from CRM_CustomerInfo  t1,"+leftjointable+"  t2  "+ CRMSearchComInfo.FormatSQLSearch(user.getLanguage())+" and t1.id = t2.relateditemid";    
}else{
	CRM_SearchSql = "select t1.id from CRM_CustomerInfo  t1 "+ CRMSearchComInfo.FormatSQLSearch(user.getLanguage())+" and t1.agent="+user.getUID();    
}

int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);  //�Կͻ���Ⱥ����λ������ҳ
int customerid= Util.getIntValue(request.getParameter("customerid"),0);//��ĳһ�ͻ�����ʱ
int mailid= Util.getIntValue(request.getParameter("mailid"),0);
String selfComment=Util.null2String(request.getParameter("selfComment"));
String subject = Util.null2String(request.getParameter("subject"));
String from = Util.null2String(request.getParameter("from"));   
String issearch = Util.null2String(request.getParameter("issearch"));

int sendto = Util.getIntValue(request.getParameter("sendto"));

if (mailid==0)//�����ð�ʽʱ�����ı��������ż����ݵ����
{
	SendMail.setSelfComment(selfComment);
	SendMail.setSubject(subject);
	SendMail.setFrom(from);
	SendMail.setSendTo(sendto);

	if(issearch.equals("1"))
	{
		RecordSet.executeSql(CRM_SearchSql);
		while(RecordSet.next())
			{
				SendMail.setCustomerId(RecordSet.getInt("id"));
				SendMail.SendHtmlMail2(request);
			}
	}else if(customerid!=0){
		SendMail.setCustomerId(customerid);
		SendMail.SendHtmlMail2(request);
		response.sendRedirect("ViewCustomer.jsp?CustomerID="+customerid);
		return;
	}
}

else{//���ð�ʽʱ
SendMail.setMailId(mailid);
SendMail.setSubject(subject);
SendMail.setFrom(from);
SendMail.setSendTo(sendto);

if(issearch.equals("1")){
	RecordSet.executeSql(CRM_SearchSql);
	while(RecordSet.next()){
		SendMail.setCustomerId(RecordSet.getInt("id"));
		SendMail.SendHtmlMail(request);	
	}
}else if(customerid!=0){
	SendMail.setCustomerId(customerid);
	SendMail.SendHtmlMail(request);
	response.sendRedirect("ViewCustomer.jsp?CustomerID="+customerid);
	return;
}
}
response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum="+pagenum);
%>