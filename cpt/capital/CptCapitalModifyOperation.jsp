<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="CptSearchComInfo" class="weaver.cpt.search.CptSearchComInfo" scope="session" />
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%
String userid = ""+user.getUID();
String Tempdeptid=""+user.getUserDepartment();
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
if (stateid.equals("0")){ stateid="";}
String	location = Util.fromScreen(request.getParameter("location"),user.getLanguage()) ;			/*��ŵص�*/
String	isdata = Util.fromScreen(request.getParameter("isdata"),user.getLanguage()) ;			/*��ŵص�*/
String	counttype = Util.fromScreen(request.getParameter("counttype"),user.getLanguage());	/*���ʻ�ͺ�*/
if (counttype.equals("0")){ counttype="";}
String	isinner = Util.fromScreen(request.getParameter("isinner"),user.getLanguage());	/*���ڻ�����*/
if (isinner.equals("0")){ isinner="";}

//set CptSearchComInfo values------------------------------------
CptSearchComInfo.setMark(mark);
CptSearchComInfo.setName(name);
CptSearchComInfo.setStartdate(startdate);
CptSearchComInfo.setStartdate1(startdate1);
CptSearchComInfo.setEnddate(enddate);
CptSearchComInfo.setEnddate1(enddate1);
CptSearchComInfo.setSeclevel(seclevel);
CptSearchComInfo.setSeclevel1(seclevel1);
CptSearchComInfo.setDepartmentid(departmentid);
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

//out.println("STRing is "+CptSearchComInfo.FormatSQLSearch());
String type= Util.fromScreen(request.getParameter("type"),user.getLanguage()) ;
/*
if(type.equals("search")){
    response.sendRedirect("CptSearchResult.jsp?type=search");
}
*/

//�Ƿ��Ȩϵͳ���粻�ǣ�����ʾ��ܣ�ֱ��ת���б�ҳ��
RecordSet.executeSql("select detachable from SystemSet");
int detachable=0;
if(RecordSet.next()){
    detachable=RecordSet.getInt("detachable");
    session.setAttribute("detachable",String.valueOf(detachable));
}
if(detachable==0){
    response.sendRedirect("CptCapitalModify.jsp?mark=" + mark);
}else{
    response.sendRedirect("CptCapMod_frm.jsp");
}
%>
