<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %><%@ page import="weaver.cpt.search.CptSearchComInfo" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="CptSearchComInfo" class="weaver.cpt.search.CptSearchComInfo" scope="session" />
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%
String userid = ""+user.getUID();
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
String Tempdeptid=""+user.getUserDepartment();
String	subcompanyid = Util.fromScreen(request.getParameter("subcompanyid"),user.getLanguage());/*�ֲ�*/
String	departmentid = Util.fromScreen(request.getParameter("departmentid"),user.getLanguage());/*����*/
String	resourceid = Util.fromScreen(request.getParameter("resourceid"),user.getLanguage());
/*
Ȩ���ж�,�ʲ�����Ա�Լ��������ϼ�
boolean canView = false;
ArrayList allCanView = new ArrayList();
String sql = "select resourceid from HrmRoleMembers where roleid = 7 ";
RecordSet.executeSql(sql);
while(RecordSet.next()){
	String tempid = RecordSet.getString("resourceid");
	allCanView.add(tempid);
	AllManagers.getAll(tempid);
	while(AllManagers.next()){
		allCanView.add(AllManagers.getManagerID());
	}
}// end while

for (int i=0;i<allCanView.size();i++){
	if(userid.equals((String)allCanView.get(i))){
		canView = true;
	}
}


if(!canView) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
Ȩ���жϽ���
*/


CptSearchComInfo.resetSearchInfo();

String from = Util.fromScreen(request.getParameter("from"),user.getLanguage()) ;				/*��ѯ����*/

String blongsubcompany = Util.fromScreen(request.getParameter("blongsubcompany"),user.getLanguage());//�����ֲ�
String subcompanyid1 = Util.fromScreen(request.getParameter("subcompanyid1"),user.getLanguage()) ;	
String  mark = Util.fromScreen(request.getParameter("mark"),user.getLanguage()) ;				/*���*/
String	name = Util.fromScreen2(request.getParameter("name"),user.getLanguage());			/*����*/
String	startdate = Util.fromScreen(request.getParameter("startdate"),user.getLanguage());			/*��Ч��*/
String	startdate1 = Util.fromScreen(request.getParameter("startdate1"),user.getLanguage());			/*��Ч��*/
String	enddate= Util.fromScreen(request.getParameter("enddate"),user.getLanguage());				/*��Ч��*/
String	enddate1= Util.fromScreen(request.getParameter("enddate1"),user.getLanguage());				/*��Ч��*/
String	seclevel= Util.fromScreen(request.getParameter("seclevel"),user.getLanguage());				/*��ȫ����*/
String	seclevel1= Util.fromScreen(request.getParameter("seclevel1"),user.getLanguage());				/*��ȫ����*/
//String	departmentid = Util.fromScreen(request.getParameter("departmentid"),user.getLanguage());/*����*/
//out.println(departmentid);
if (departmentid.equals("0")){ departmentid="";}
if (subcompanyid.equals("0")){ subcompanyid="";}
String	costcenterid = Util.fromScreen(request.getParameter("costcenterid"),user.getLanguage());			/*�ɱ�����*/
if (costcenterid.equals("0")){ costcenterid="";}
//String	resourceid = Util.fromScreen(request.getParameter("resourceid"),user.getLanguage());		/*������Դ*/
if (resourceid.equals("0")){ resourceid="";}
if (resourceid.equals("-1")){ resourceid="0";}
String	currencyid = Util.fromScreen(request.getParameter("currencyid"),user.getLanguage());	/*����*/
if (currencyid.equals("0")){ currencyid="";}
String	capitalcost = Util.fromScreen(request.getParameter("capitalcost"),user.getLanguage());	/*�ɱ�*/
String	capitalcost1 = Util.fromScreen(request.getParameter("capitalcost1"),user.getLanguage());	/*�ɱ�*/
String	startprice = Util.fromScreen(request.getParameter("startprice"),user.getLanguage());	/*��ʼ�۸�*/
String	startprice1 = Util.fromScreen(request.getParameter("startprice1"),user.getLanguage());	/*��ʼ�۸�*/
String	depreendprice = Util.fromScreen(request.getParameter("depreendprice"),user.getLanguage()); /*�۾ɵ׼�(��)*/
String	depreendprice1 = Util.fromScreen(request.getParameter("depreendprice1"),user.getLanguage()); /*�۾ɵ׼�(��)*/
String	capitalspec = Util.fromScreen(request.getParameter("capitalspec"),user.getLanguage());			/*����ͺ�(��)*/
String	capitallevel = Util.fromScreen(request.getParameter("capitallevel"),user.getLanguage());	/*�ʲ��ȼ�(��)*/
String	manufacturer = Util.fromScreen(request.getParameter("manufacturer"),user.getLanguage());			/*���쳧��(��)*/
String	manudate	= Util.fromScreen(request.getParameter("manudate"),user.getLanguage());			/*��������(��)*/
String	manudate1	= Util.fromScreen(request.getParameter("manudate1"),user.getLanguage());			/*��������(��)*/
String	capitaltypeid = Util.fromScreen(request.getParameter("capitaltypeid"),user.getLanguage());			/*�ʲ�����*/
if (capitaltypeid.equals("0")){ capitaltypeid="";}
String	capitalgroupid = Util.fromScreen(request.getParameter("capitalgroupid"),user.getLanguage());			/*�ʲ���*/
if (capitalgroupid.equals("0")){ capitalgroupid="";}
String	unitid = Util.fromScreen(request.getParameter("unitid"),user.getLanguage());				/*������λ*/
if (unitid.equals("0")){ unitid="";}
String	capitalnum = Util.fromScreen(request.getParameter("capitalnum"),user.getLanguage());			/*����*/
String	capitalnum1 = Util.fromScreen(request.getParameter("capitalnum1"),user.getLanguage());			/*����*/
String	currentnum = Util.fromScreen(request.getParameter("currentnum"),user.getLanguage());			/*��ǰ����*/
String	currentnum1 = Util.fromScreen(request.getParameter("currentnum1"),user.getLanguage());			/*��ǰ����*/
String	replacecapitalid =Util.fromScreen(request.getParameter("replacecapitalid"),user.getLanguage());				/*���*/
if (replacecapitalid.equals("0")){ replacecapitalid="";}
String	version =Util.fromScreen(request.getParameter("version"),user.getLanguage()) ;			/*�汾*/
String	itemid =Util.fromScreen(request.getParameter("itemid"),user.getLanguage());			/*��Ʒ*/
if (itemid.equals("0")){ itemid="";}
String	depremethod1 =Util.fromScreen(request.getParameter("depremethod1"),user.getLanguage());			/*�۾ɷ�һ*/
if (depremethod1.equals("0")){ depremethod1="";}
String	depremethod2 =Util.fromScreen(request.getParameter("depremethod2"),user.getLanguage());			/*�۾ɷ���*/
if (depremethod2.equals("0")){ depremethod2="";}
String	deprestartdate =Util.fromScreen(request.getParameter("deprestartdate"),user.getLanguage());		/*�۾ɿ�ʼ����*/
String	deprestartdate1 =Util.fromScreen(request.getParameter("deprestartdate1"),user.getLanguage());		/*�۾ɿ�ʼ����*/
String	depreenddate = Util.fromScreen(request.getParameter("depreenddate"),user.getLanguage()) ;			/*�۾ɽ�������*/
String	depreenddate1 = Util.fromScreen(request.getParameter("depreenddate1"),user.getLanguage()) ;			/*�۾ɽ�������*/
String	customerid=Util.fromScreen(request.getParameter("customerid"),user.getLanguage());			/*�ͻ�id*/
if (customerid.equals("0")){ customerid="";}
String	attribute= Util.fromScreen(request.getParameter("attribute"),user.getLanguage());
String	stateid = Util.fromScreen(request.getParameter("stateid"),user.getLanguage());	/*�ʲ�״̬*/
//if (stateid.equals("0")){ stateid="";}
String	location = Util.fromScreen(request.getParameter("location"),user.getLanguage()) ;			/*��ŵص�*/
String	isdata = Util.fromScreen(request.getParameter("isdata"),user.getLanguage()) ;			/*��ŵص�*/
String	counttype = Util.fromScreen(request.getParameter("counttype"),user.getLanguage());	/*���ʻ�ͺ�*/
if (counttype.equals("0")){ counttype="";}
String	isinner = Util.fromScreen(request.getParameter("isinner"),user.getLanguage());	/*���ڻ�����*/
if (isinner.equals("0")){ isinner="";}
String stockindate	= Util.fromScreen(request.getParameter("stockindate"),user.getLanguage());			/*������ڴ�*/
String stockindate1	= Util.fromScreen(request.getParameter("stockindate1"),user.getLanguage());		    /*������ڵ�*/




String fnamark = Util.fromScreen(request.getParameter("fnamark"),user.getLanguage()); /*������*/
String barcode = Util.fromScreen(request.getParameter("barcode"),user.getLanguage()); /*������*/
String blongdepartment = Util.fromScreen(request.getParameter("blongdepartment"),user.getLanguage());/*��������*/
String sptcount = Util.fromScreen(request.getParameter("sptcount"),user.getLanguage());/*��������*/
String relatewfid = Util.fromScreen(request.getParameter("relatewfid"),user.getLanguage()); /*��ع�����*/
String SelectDate = Util.fromScreen(request.getParameter("SelectDate"),user.getLanguage());/*��������*/
String SelectDate1 = Util.fromScreen(request.getParameter("SelectDate1"),user.getLanguage());/*��������1*/
String contractno = Util.fromScreen(request.getParameter("contractno"),user.getLanguage());/*��ͬ��*/
String Invoice = Util.fromScreen(request.getParameter("Invoice"),user.getLanguage());/*��Ʊ��*/
String depreyear = Util.fromScreen(request.getParameter("depreyear"),user.getLanguage());/*�۾�����*/
String deprerate = Util.fromScreen(request.getParameter("deprerate"),user.getLanguage());/*��ֵ��*/
String depreyear1 = Util.fromScreen(request.getParameter("depreyear1"),user.getLanguage());/*�۾�����*/
String deprerate1 = Util.fromScreen(request.getParameter("deprerate1"),user.getLanguage());/*��ֵ��*/
String issupervision = Util.fromScreen(request.getParameter("issupervision"),user.getLanguage());/*�Ƿ񺣹ؼ��*/
String amountpay = Util.fromScreen(request.getParameter("amountpay"),user.getLanguage());/*�Ѹ����*/
String amountpay1 = Util.fromScreen(request.getParameter("amountpay1"),user.getLanguage());/*�Ѹ����*/
String purchasestate = Util.fromScreen(request.getParameter("purchasestate"),user.getLanguage());/*�ɹ�״̬*/

String datafield1 = Util.fromScreen(request.getParameter("datafield1"),user.getLanguage());/*�Զ�����������*/
String datafield11 = Util.fromScreen(request.getParameter("datafield11"),user.getLanguage());/*�Զ�����������*/
String datafield2 = Util.fromScreen(request.getParameter("datafield2"),user.getLanguage());/*�Զ�����������*/
String datafield22 = Util.fromScreen(request.getParameter("datafield22"),user.getLanguage());/*�Զ�����������*/
String datafield3 = Util.fromScreen(request.getParameter("datafield3"),user.getLanguage());/*�Զ�����������*/
String datafield33 = Util.fromScreen(request.getParameter("datafield33"),user.getLanguage());/*�Զ�����������*/
String datafield4 = Util.fromScreen(request.getParameter("datafield4"),user.getLanguage());/*�Զ�����������*/
String datafield44 = Util.fromScreen(request.getParameter("datafield44"),user.getLanguage());/*�Զ�����������*/
String datafield5 = Util.fromScreen(request.getParameter("datafield5"),user.getLanguage());/*�Զ�����������*/
String datafield55 = Util.fromScreen(request.getParameter("datafield55"),user.getLanguage());/*�Զ�����������*/	
	
String numberfield1 = Util.fromScreen(request.getParameter("numberfield1"),user.getLanguage());/*�Զ��帡����*/
String numberfield11 = Util.fromScreen(request.getParameter("numberfield11"),user.getLanguage());/*�Զ��帡����*/
String numberfield2 = Util.fromScreen(request.getParameter("numberfield2"),user.getLanguage());/*�Զ��帡����*/
String numberfield22 = Util.fromScreen(request.getParameter("numberfield22"),user.getLanguage());/*�Զ��帡����*/
String numberfield3 = Util.fromScreen(request.getParameter("numberfield3"),user.getLanguage());/*�Զ��帡����*/
String numberfield33 = Util.fromScreen(request.getParameter("numberfield33"),user.getLanguage());/*�Զ��帡����*/
String numberfield4 = Util.fromScreen(request.getParameter("numberfield4"),user.getLanguage());/*�Զ��帡����*/
String numberfield44 = Util.fromScreen(request.getParameter("numberfield44"),user.getLanguage());/*�Զ��帡����*/
String numberfield5 = Util.fromScreen(request.getParameter("numberfield5"),user.getLanguage());/*�Զ��帡����*/
String numberfield55 = Util.fromScreen(request.getParameter("numberfield55"),user.getLanguage());/*�Զ��帡����*/
	
String textfield1 = Util.fromScreen(request.getParameter("textfield1"),user.getLanguage());/*�Զ����ı�*/
String textfield2 = Util.fromScreen(request.getParameter("textfield2"),user.getLanguage());/*�Զ����ı�*/
String textfield3 = Util.fromScreen(request.getParameter("textfield3"),user.getLanguage());/*�Զ����ı�*/
String textfield4 = Util.fromScreen(request.getParameter("textfield4"),user.getLanguage());/*�Զ����ı�*/
String textfield5 = Util.fromScreen(request.getParameter("textfield5"),user.getLanguage());/*�Զ����ı�*/

String tinyintfield1 = Util.fromScreen(request.getParameter("tinyintfield1"),user.getLanguage());/*�Զ���check��*/
String tinyintfield2 = Util.fromScreen(request.getParameter("tinyintfield2"),user.getLanguage());/*�Զ���check��*/
String tinyintfield3 = Util.fromScreen(request.getParameter("tinyintfield3"),user.getLanguage());/*�Զ���check��*/
String tinyintfield4 = Util.fromScreen(request.getParameter("tinyintfield4"),user.getLanguage());/*�Զ���check��*/
String tinyintfield5 = Util.fromScreen(request.getParameter("tinyintfield5"),user.getLanguage());/*�Զ���check��*/
	
String docff01name = Util.fromScreen(request.getParameter("docff01name"),user.getLanguage());/*�Զ�����ĵ�*/
String docff02name = Util.fromScreen(request.getParameter("docff02name"),user.getLanguage());/*�Զ�����ĵ�*/
String docff03name = Util.fromScreen(request.getParameter("docff03name"),user.getLanguage());/*�Զ�����ĵ�*/
String docff04name = Util.fromScreen(request.getParameter("docff04name"),user.getLanguage());/*�Զ�����ĵ�*/
String docff05name = Util.fromScreen(request.getParameter("docff05name"),user.getLanguage());/*�Զ�����ĵ�*/
	
String depff01name = Util.fromScreen(request.getParameter("depff01name"),user.getLanguage());/*�Զ���ಿ��*/
String depff02name = Util.fromScreen(request.getParameter("depff02name"),user.getLanguage());/*�Զ���ಿ��*/
String depff03name = Util.fromScreen(request.getParameter("depff03name"),user.getLanguage());/*�Զ���ಿ��*/
String depff04name = Util.fromScreen(request.getParameter("depff04name"),user.getLanguage());/*�Զ���ಿ��*/
String depff05name = Util.fromScreen(request.getParameter("depff05name"),user.getLanguage());/*�Զ���ಿ��*/
	
String crmff01name = Util.fromScreen(request.getParameter("crmff01name"),user.getLanguage());/*�Զ����ͻ�*/
String crmff02name = Util.fromScreen(request.getParameter("crmff02name"),user.getLanguage());/*�Զ����ͻ�*/
String crmff03name = Util.fromScreen(request.getParameter("crmff03name"),user.getLanguage());/*�Զ����ͻ�*/
String crmff04name = Util.fromScreen(request.getParameter("crmff04name"),user.getLanguage());/*�Զ����ͻ�*/
String crmff05name = Util.fromScreen(request.getParameter("crmff05name"),user.getLanguage());/*�Զ����ͻ�*/
	
String reqff01name = Util.fromScreen(request.getParameter("reqff01name"),user.getLanguage());/*�Զ��������*/
String reqff02name = Util.fromScreen(request.getParameter("reqff02name"),user.getLanguage());/*�Զ��������*/
String reqff03name = Util.fromScreen(request.getParameter("reqff03name"),user.getLanguage());/*�Զ��������*/
String reqff04name = Util.fromScreen(request.getParameter("reqff04name"),user.getLanguage());/*�Զ��������*/
String reqff05name = Util.fromScreen(request.getParameter("reqff05name"),user.getLanguage());/*�Զ��������*/





//set CptSearchComInfo values------------------------------------

CptSearchComInfo.setBlongsubcompany(blongsubcompany);
CptSearchComInfo.setMark(mark);
CptSearchComInfo.setName(name);
CptSearchComInfo.setStartdate(startdate);
CptSearchComInfo.setStartdate1(startdate1);
CptSearchComInfo.setEnddate(enddate);
CptSearchComInfo.setEnddate1(enddate1);
CptSearchComInfo.setSeclevel(seclevel);
CptSearchComInfo.setSeclevel1(seclevel1);
CptSearchComInfo.setDepartmentid(departmentid);
CptSearchComInfo.setSubcompanyid(subcompanyid);
CptSearchComInfo.setCostcenterid(costcenterid);
CptSearchComInfo.setResourceid(resourceid);
CptSearchComInfo.setCurrencyid(currencyid);
CptSearchComInfo.setCapitalcost(capitalcost);
CptSearchComInfo.setCapitalcost1(capitalcost1);
CptSearchComInfo.setStartprice(startprice);
CptSearchComInfo.setStartprice1(startprice1);
CptSearchComInfo.setDepreendprice(depreendprice);
CptSearchComInfo.setDepreendprice1(depreendprice1);
CptSearchComInfo.setCapitalspec(capitalspec);
CptSearchComInfo.setCapitallevel(capitallevel);
CptSearchComInfo.setManufacturer(manufacturer);
CptSearchComInfo.setManudate(manudate);
CptSearchComInfo.setManudate1(manudate1);
CptSearchComInfo.setCapitaltypeid(capitaltypeid);
CptSearchComInfo.setCapitalgroupid(capitalgroupid);
CptSearchComInfo.setUnitid(unitid);
CptSearchComInfo.setCapitalnum(capitalnum);
CptSearchComInfo.setCapitalnum1(capitalnum1);
CptSearchComInfo.setCurrentnum(currentnum);
CptSearchComInfo.setCurrentnum1(currentnum1);
CptSearchComInfo.setReplacecapitalid(replacecapitalid);
CptSearchComInfo.setVersion(version);
CptSearchComInfo.setItemid(itemid);
CptSearchComInfo.setDepremethod1(depremethod1);
CptSearchComInfo.setDepremethod2(depremethod2);
CptSearchComInfo.setDeprestartdate(deprestartdate);
CptSearchComInfo.setDeprestartdate1(deprestartdate1);
CptSearchComInfo.setDepreenddate(depreenddate);
CptSearchComInfo.setDepreenddate1(depreenddate1);
CptSearchComInfo.setCustomerid(customerid);
CptSearchComInfo.setAttribute(attribute);
CptSearchComInfo.setStateid(stateid);
CptSearchComInfo.setLocation(location);
CptSearchComInfo.setIsData(isdata);
CptSearchComInfo.setCountType(counttype);
CptSearchComInfo.setIsInner(isinner);
CptSearchComInfo.setStockindate(stockindate);
CptSearchComInfo.setStockindate1(stockindate1);

//==================������=================================================================
CptSearchComInfo.setFnamark(fnamark);
CptSearchComInfo.setBarcode(barcode);
CptSearchComInfo.setBlongdepartment(blongdepartment);
CptSearchComInfo.setSptcount(sptcount);
CptSearchComInfo.setRelatewfid(relatewfid);
CptSearchComInfo.setSelectDate(SelectDate);
CptSearchComInfo.setSelectDate1(SelectDate1);
CptSearchComInfo.setContractno(contractno);
CptSearchComInfo.setInvoice(Invoice);
CptSearchComInfo.setDepreyear(depreyear);
CptSearchComInfo.setDepreyear1(depreyear1);
CptSearchComInfo.setDeprerate(deprerate);
CptSearchComInfo.setDeprerate1(deprerate1);
CptSearchComInfo.setIssupervision(issupervision);
CptSearchComInfo.setAmountpay(amountpay);
CptSearchComInfo.setAmountpay1(amountpay1);
CptSearchComInfo.setPurchasestate(purchasestate);

CptSearchComInfo.setDatefield1(datafield1);
CptSearchComInfo.setDatefield11(datafield11);
CptSearchComInfo.setDatefield2(datafield2);
CptSearchComInfo.setDatefield22(datafield22);
CptSearchComInfo.setDatefield3(datafield3);
CptSearchComInfo.setDatefield33(datafield33);
CptSearchComInfo.setDatefield4(datafield4);
CptSearchComInfo.setDatefield44(datafield44);
CptSearchComInfo.setDatefield5(datafield5);
CptSearchComInfo.setDatefield55(datafield55);
	
CptSearchComInfo.setNumberfield1(numberfield1);
CptSearchComInfo.setNumberfield11(numberfield11);
CptSearchComInfo.setNumberfield2(numberfield2);
CptSearchComInfo.setNumberfield22(numberfield22);
CptSearchComInfo.setNumberfield3(numberfield3);
CptSearchComInfo.setNumberfield33(numberfield33);
CptSearchComInfo.setNumberfield4(numberfield4);
CptSearchComInfo.setNumberfield44(numberfield44);
CptSearchComInfo.setNumberfield5(numberfield5);
CptSearchComInfo.setNumberfield55(numberfield55);

CptSearchComInfo.setTextfield1(textfield1);
CptSearchComInfo.setTextfield2(textfield2);
CptSearchComInfo.setTextfield3(textfield3);
CptSearchComInfo.setTextfield4(textfield4);
CptSearchComInfo.setTextfield5(textfield5);

CptSearchComInfo.setTinyintfield1(tinyintfield1);
CptSearchComInfo.setTinyintfield2(tinyintfield2);
CptSearchComInfo.setTinyintfield3(tinyintfield3);
CptSearchComInfo.setTinyintfield4(tinyintfield4);
CptSearchComInfo.setTinyintfield5(tinyintfield5);
	
CptSearchComInfo.setDocff01name(docff01name);
CptSearchComInfo.setDocff02name(docff02name);
CptSearchComInfo.setDocff03name(docff03name);
CptSearchComInfo.setDocff04name(docff04name);
CptSearchComInfo.setDocff05name(docff05name);

CptSearchComInfo.setDepff01name(depff01name);
CptSearchComInfo.setDepff02name(depff02name);
CptSearchComInfo.setDepff03name(depff03name);
CptSearchComInfo.setDepff04name(depff04name);
CptSearchComInfo.setDepff05name(depff05name);

CptSearchComInfo.setCrmff01name(crmff01name);
CptSearchComInfo.setCrmff02name(crmff02name);
CptSearchComInfo.setCrmff03name(crmff03name);
CptSearchComInfo.setCrmff04name(crmff04name);
CptSearchComInfo.setCrmff05name(crmff05name);

CptSearchComInfo.setReqff01name(reqff01name);
CptSearchComInfo.setReqff02name(reqff02name);
CptSearchComInfo.setReqff03name(reqff03name);
CptSearchComInfo.setReqff04name(reqff04name);
CptSearchComInfo.setReqff05name(reqff05name);
//=========================================================================

//out.println("STRing is "+CptSearchComInfo.FormatSQLSearch());
String type= Util.fromScreen(request.getParameter("type"),user.getLanguage()) ;
/*
if(type.equals("search")){
    response.sendRedirect("CptSearchResult.jsp?type=search");
}
*/
if(from.equals("report")){
    response.sendRedirect("../report/CptRpCapitalResult.jsp?subcompanyid="+subcompanyid);
}
else if(from.equals("checkstock")){
	response.sendRedirect("../report/CptRpCapitalCheckStockResult.jsp");
}
else if(from.equals("cptmodify")){
	response.sendRedirect("../capital/CptCapitalModify.jsp?from=1");
}
else if(from.equals("search")){
	response.sendRedirect("/cpt/capital/CptCapitalMaintenance.jsp?from=search&subcompanyid1="+subcompanyid1+"");
}
else{
    response.sendRedirect("CptSearchResult.jsp?type="+type+"&isfromtab="+isfromtab);
}

%>
