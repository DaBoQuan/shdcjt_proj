<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>


<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="CRMSearchComInfo" class="weaver.crm.search.SearchComInfo" scope="session" />


<%
/*��reportҳ������ز���*/
	String settype=Util.null2String(request.getParameter("settype"));
	String customercity=Util.null2String(request.getParameter("customercity"));//��AddressReSum.jspҳ��ȡ��ֵ
	if(settype.equals("customercity")) //��reportҳ����ѡ����ֲ�ʱ
	{
		CRMSearchComInfo.setCustomerCity(customercity);//��Bean��setCustomerCity
    //perpage������CRM_Customize���ȡ���˴����ش���  modify by xhheng @20050118 for TD 1345
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
CRMSearchComInfo.resetSearchInfo();
String msg=Util.null2String(request.getParameter("msg"));
if(msg.equals("report")){
	String id=Util.null2String(request.getParameter("id"));
	if(settype.equals("contactway")){
		CRMSearchComInfo.setContactWay(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("customersize")){
		CRMSearchComInfo.setCustomerSize(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("customertype")){
		CRMSearchComInfo.addCustomerType(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("customerdesc")){
		CRMSearchComInfo.setCustomerDesc(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("customerstatus")){
		CRMSearchComInfo.setCustomerStatus(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("paymentterm")){
		CRMSearchComInfo.setPaymentTerm(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("customerrating")){
		CRMSearchComInfo.setCustomerRating(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("creditinfo")){
		CRMSearchComInfo.setCreditLevel(id);

		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("tradeinfo")){
		CRMSearchComInfo.setContractLevel(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("manager")){
		CRMSearchComInfo.setAccountManager(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("department")){
		CRMSearchComInfo.setCustomerDept(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("sectorinfo")){
		CRMSearchComInfo.setCustomerSector(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("city")){
		CRMSearchComInfo.setCustomerCity(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
	if(settype.equals("province")){
		CRMSearchComInfo.setCustomerProvince(id);
		response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
		return;
	}
/*���ص�һ������ҳ�棬������*/
	response.sendRedirect("/notice/noright.jsp");
	return;
}


String actionKey = Util.null2String(request.getParameter("actionKey"));
String destination = Util.null2String(request.getParameter("destination"));
String searchtype = Util.null2String(request.getParameter("searchtype"));
CRMSearchComInfo.setSearchtype(searchtype);

if(destination.equals("crmindept"))
{

	CRMSearchComInfo.setCustomerRegion(Util.null2String(request.getParameter("depid")));
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
	return;
}


if(destination.equals("myAccount"))
{
	String resourceid =  Util.null2String(request.getParameter("resourceid"));
	if(resourceid.equals("")) resourceid = "" + user.getUID() ;
	CRMSearchComInfo.setAccountManager(resourceid);
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1&destination=myAccount");
	return;
}

CRMSearchComInfo.setCustomerName(Util.null2String(request.getParameter("CustomerName")));
if(destination.equals("QuickSearch"))
{
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
	return;
}

String CustomerTypes[]=request.getParameterValues("CustomerTypes");
if(CustomerTypes != null)
{
	for(int i=0;i<CustomerTypes.length;i++)
	{
		CRMSearchComInfo.addCustomerType(CustomerTypes[i]);
	}
}

/*Modify by ����� 2004-10-25 For TD1259*/
CRMSearchComInfo.setCustomerCode(Util.null2String(request.getParameter("CustomerCode")));
CRMSearchComInfo.setCustomerCity(Util.null2String(request.getParameter("CustomerCity")));
CRMSearchComInfo.setCustomerProvince(Util.null2String(request.getParameter("CustomerProvince")));
CRMSearchComInfo.setCustomerCountry(Util.null2String(request.getParameter("CustomerCountry")));
CRMSearchComInfo.setCustomerRegion(Util.null2String(request.getParameter("CustomerRegion")));
CRMSearchComInfo.setCustomerSector(Util.null2String(request.getParameter("CustomerSector")));
CRMSearchComInfo.setCustomerDesc(Util.null2String(request.getParameter("CustomerDesc")));
CRMSearchComInfo.setContacterFirstName(Util.null2String(request.getParameter("ContacterFirstName")));
CRMSearchComInfo.setContacterLastName(Util.null2String(request.getParameter("ContacterLastName")));
CRMSearchComInfo.setContacterAge(Util.null2String(request.getParameter("age")));
CRMSearchComInfo.setContacterAgeTo(Util.null2String(request.getParameter("ageTo")));
CRMSearchComInfo.setContacterIDCard(Util.null2String(request.getParameter("IDCard")));
CRMSearchComInfo.setCustomerStatus(Util.null2String(request.getParameter("CustomerStatus")));
CRMSearchComInfo.setAccountManager(Util.null2String(request.getParameter("AccountManager")));
CRMSearchComInfo.setContactWay(Util.null2String(request.getParameter("ContactWay")));
CRMSearchComInfo.setCustomerSize(Util.null2String(request.getParameter("CustomerSize")));
CRMSearchComInfo.setCustomerOrigin(Util.null2String(request.getParameter("CustomerOrigin")));
CRMSearchComInfo.setFromDate(Util.null2String(request.getParameter("fromdate")));
CRMSearchComInfo.setEndDate(Util.null2String(request.getParameter("enddate")));
CRMSearchComInfo.setPrjID(Util.null2String(request.getParameter("PrjID")));
CRMSearchComInfo.setFirstNameDesc(Util.null2String(request.getParameter("FirstNameDesc")));
CRMSearchComInfo.setLastNameDesc(Util.null2String(request.getParameter("LastNameDesc")));

CRMSearchComInfo.setDebtorNumber(Util.null2String(request.getParameter("DebtorNumber")));
CRMSearchComInfo.setWebAccess(Util.null2String(request.getParameter("WebAccess")));
CRMSearchComInfo.setCreditorNumber(Util.null2String(request.getParameter("CreditorNumber")));

CRMSearchComInfo.setCustomerAddress1(Util.null2String(request.getParameter("CustomerAddress1")));
CRMSearchComInfo.setCustomerRating(Util.null2String(request.getParameter("CustomerRating")));
CRMSearchComInfo.setCustomerPostcode(Util.null2String(request.getParameter("CustomerPostcode")));
CRMSearchComInfo.setCustomerTelephone(Util.null2String(request.getParameter("CustomerTelephone")));
CRMSearchComInfo.setCustomerParent(Util.null2String(request.getParameter("CustomerParent")));
CRMSearchComInfo.setContacterManager(Util.null2String(request.getParameter("ContacterManager")));

CRMSearchComInfo.setContacterEmail(Util.null2String(request.getParameter("ContacterEmail")));
CRMSearchComInfo.setCustomerCreater(Util.null2String(request.getParameter("CustomerCreater")));
CRMSearchComInfo.setCustomerModifier(Util.null2String(request.getParameter("CustomerModifier")));

CRMSearchComInfo.setContacterAge(Util.null2String(request.getParameter("age")));
CRMSearchComInfo.setContacterAgeTo(Util.null2String(request.getParameter("ageTo")));
CRMSearchComInfo.setContacterIDCard(Util.null2String(request.getParameter("IDCard")));

CRMSearchComInfo.setTypeFrom(Util.null2String(request.getParameter("TypeFrom")));
CRMSearchComInfo.setTypeTo(Util.null2String(request.getParameter("TypeTo")));
CRMSearchComInfo.setStatusFrom(Util.null2String(request.getParameter("StatusFrom")));
CRMSearchComInfo.setStatusTo(Util.null2String(request.getParameter("StatusTo")));

CRMSearchComInfo.setActionKey(actionKey);// add by xwj 2005-03-10  td:1546

if(destination.equals("toSimple"))
{
	response.sendRedirect("/CRM/search/SearchSimple.jsp?actionKey=" + actionKey);
	return;
}
if(destination.equals("toAdvanced"))
{
	response.sendRedirect("/CRM/search/SearchAdvanced.jsp?actionKey=" + actionKey);
	return;
}

/*--edited by ��ε� 2005-03-09 TD:1546--*/
if(searchtype.equals("simple"))
{
	
	if(actionKey.equals("batchShare")){
	response.sendRedirect("/CRM/data/ShareMutiCustomerList.jsp");
	return;
	}
	else{
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
	return;
	}
    
}

else if(searchtype.equals("advanced")){

  if(actionKey.equals("batchShare")){
	response.sendRedirect("/CRM/data/ShareMutiCustomerList.jsp");
	return;
	}
	else{
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
	return;
	}
}
//td1761 xwj 2005-05-24
else if(searchtype.equals("baseOnCustomerStatus")){
	response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");
	return;
}

else{
    response.sendRedirect("/CRM/search/SearchResult.jsp?pagenum=1");    
}
   
%>


