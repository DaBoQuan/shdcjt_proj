<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CostcenterComInfo" class="weaver.hrm.company.CostCenterComInfo" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page"/>
<jsp:useBean id="CapitalStateComInfo" class="weaver.cpt.maintenance.CapitalStateComInfo" scope="page"/>
<jsp:useBean id="CapitalTypeComInfo" class="weaver.cpt.maintenance.CapitalTypeComInfo" scope="page"/>
<jsp:useBean id="AssetUnitComInfo" class="weaver.lgc.maintenance.AssetUnitComInfo" scope="page"/>
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="DepreMethodComInfo" class="weaver.cpt.maintenance.DepreMethodComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>

<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</head>
<%
//String userid =""+user.getUID();
int userid =user.getUID();


int advanced=Util.getIntValue(request.getParameter("advanced"),0); //�Ƿ��Ǹ߼����� 0:��;1:��
int mouldid=Util.getIntValue(request.getParameter("mouldid"),0);   //�Ƿ�Ӧ��ģ��  0:��ģ��,>0:ģ��id
String from = Util.fromScreen(request.getParameter("from"),user.getLanguage()) ;				/*��ѯ����*/

String mark = "";			/*���*/
String name = "";			/*����*/
String startdate = "";			/*��Ч�մ�*/
String startdate1 = "";			/*��Ч�յ�*/
String enddate= "";				/*��Ч����*/
String enddate1= "";				/*��Ч����*/
String seclevel= "";				/*��ȫ�����*/
String seclevel1= "";				/*��ȫ����*/
String subcompanyid = "";           /*�ֲ�*/
String departmentid = "";/*����*/
String costcenterid = "";			/*�ɱ�����*/
String resourceid = "";		/*������Դ*/
String currencyid = "";	/*����*/
String capitalcost = "";	/*�ɱ���*/
String capitalcost1 = "";	/*�ɱ���*/
String startprice = "";	/*��ʼ�۸��*/
String startprice1 = "";	/*��ʼ�۸�*/
String depreendprice = ""; /*�۾ɵ׼�(��)��*/
String depreendprice1 = ""; /*�۾ɵ׼�(��)��*/
String capitalspec = "";			/*����ͺ�(��)*/
String capitallevel = "";	/*�ʲ��ȼ�(��)*/
String manufacturer	= "";			/*���쳧��(��)*/
String manudate	= "";			/*��������(��)��*/
String manudate1	= "";			/*��������(��)��*/
String capitaltypeid = "";			/*�ʲ�����*/
String capitalgroupid = "";			/*�ʲ���*/
String unitid = "";				/*������λ*/
String capitalnum = "";			/*������*/
String capitalnum1 = "";			/*������*/
String currentnum = "";			/*��ǰ������*/
String currentnum1 = "";			/*��ǰ������*/
String replacecapitalid ="";				/*���*/
String version = "" ;			/*�汾*/
String itemid ="";			/*��Ʒ*/
String depremethod1 ="";			/*�۾ɷ�һ*/
String depremethod2 ="";			/*�۾ɷ���*/
String deprestartdate ="";		/*�۾ɿ�ʼ���ڴ�*/
String deprestartdate1 ="";		/*�۾ɿ�ʼ���ڵ�*/
String depreenddate ="" ;			/*�۾ɽ������ڴ�*/
String depreenddate1 ="" ;			/*�۾ɽ������ڵ�*/
String customerid="";			/*�ͻ�id*/
String attribute= "";
/*����:
0:����
1:�ɹ�
2:����
3:����
4:ά��
5:����
6:����
*/
String stateid = "";	/*�ʲ�״̬*/
String location = "";			/*��ŵص�*/
String isdata = "";			/*�ʲ�������*/
String counttype = "";		/*���ʻ�ͺ�*/
String isinner = "";		/*���ڻ�����*/
String type="";
String stockindate	= "";			/*������ڴ�*/
String stockindate1	= "";		    /*������ڵ�*/

String fnamark = ""; /*������*/
String barcode = ""; /*������*/
String blongdepartment = "";/*��������*/
String blongsubcompany = "";/*�����ֲ�*/
String sptcount = "";/*��������*/
String relatewfid = ""; /*��ع�����*/
String SelectDate = "";/*��������*/
String SelectDate1 = "";/*��������1*/
String contractno = "";/*��ͬ��*/
String Invoice = "";/*��Ʊ��*/
String depreyear = "";/*�۾�����*/
String deprerate = "";/*��ֵ��*/
String depreyear1 = "";/*�۾�����*/
String deprerate1 = "";/*��ֵ��*/
String issupervision = "";/*�Ƿ񺣹ؼ��*/
String amountpay = "";/*�Ѹ����*/
String amountpay1 = "";/*�Ѹ����*/
String purchasestate = "";/*�ɹ�״̬*/

String datafield1 = "";/*�Զ�����������*/
String datafield11 = "";/*�Զ�����������*/
String datafield2 = "";/*�Զ�����������*/
String datafield22 = "";/*�Զ�����������*/
String datafield3 = "";/*�Զ�����������*/
String datafield33 = "";/*�Զ�����������*/
String datafield4 = "";/*�Զ�����������*/
String datafield44 = "";/*�Զ�����������*/
String datafield5 = "";/*�Զ�����������*/
String datafield55 = "";/*�Զ�����������*/	
	
String numberfield1 = "";/*�Զ��帡����*/
String numberfield11 = "";/*�Զ��帡����*/
String numberfield2 = "";/*�Զ��帡����*/
String numberfield22 = "";/*�Զ��帡����*/
String numberfield3 = "";/*�Զ��帡����*/
String numberfield33 = "";/*�Զ��帡����*/
String numberfield4 = "";/*�Զ��帡����*/
String numberfield44 = "";/*�Զ��帡����*/
String numberfield5 = "";/*�Զ��帡����*/
String numberfield55 = "";/*�Զ��帡����*/
	
String textfield1 = "";/*�Զ����ı�*/
String textfield2 = "";/*�Զ����ı�*/
String textfield3 = "";/*�Զ����ı�*/
String textfield4 = "";/*�Զ����ı�*/
String textfield5 = "";/*�Զ����ı�*/

String tinyintfield1 = "";/*�Զ���check��*/
String tinyintfield2 = "";/*�Զ���check��*/
String tinyintfield3 = "";/*�Զ���check��*/
String tinyintfield4 = "";/*�Զ���check��*/
String tinyintfield5 = "";/*�Զ���check��*/
	
String docff01name = "";/*�Զ�����ĵ�*/
String docff02name = "";/*�Զ�����ĵ�*/
String docff03name = "";/*�Զ�����ĵ�*/
String docff04name = "";/*�Զ�����ĵ�*/
String docff05name = "";/*�Զ�����ĵ�*/
	
String depff01name = "";/*�Զ���ಿ��*/
String depff02name = "";/*�Զ���ಿ��*/
String depff03name = "";/*�Զ���ಿ��*/
String depff04name = "";/*�Զ���ಿ��*/
String depff05name = "";/*�Զ���ಿ��*/
	
String crmff01name = "";/*�Զ����ͻ�*/
String crmff02name = "";/*�Զ����ͻ�*/
String crmff03name = "";/*�Զ����ͻ�*/
String crmff04name = "";/*�Զ����ͻ�*/
String crmff05name = "";/*�Զ����ͻ�*/
	
String reqff01name = "";/*�Զ��������*/
String reqff02name = "";/*�Զ��������*/
String reqff03name = "";/*�Զ��������*/
String reqff04name = "";/*�Զ��������*/
String reqff05name = "";/*�Զ��������*/

if(mouldid!=0){
	RecordSet.executeProc("CptSearchMould_SelectByID",""+mouldid);
	RecordSet.next();
	mark = Util.toScreenToEdit(RecordSet.getString("mark"),user.getLanguage()) ;				/*���*/
	name = Util.toScreenToEdit(RecordSet.getString("name"),user.getLanguage());			/*����*/
	startdate = Util.toScreenToEdit(RecordSet.getString("startdate"),user.getLanguage());			/*��Ч��*/
	startdate1 = Util.toScreenToEdit(RecordSet.getString("startdate1"),user.getLanguage());			/*��Ч��*/
	enddate= Util.toScreenToEdit(RecordSet.getString("enddate"),user.getLanguage());				/*��Ч��*/
	enddate1= Util.toScreenToEdit(RecordSet.getString("enddate1"),user.getLanguage());				/*��Ч��*/
	seclevel= Util.toScreenToEdit(RecordSet.getString("seclevel"),user.getLanguage());				/*��ȫ����*/
	seclevel1= Util.toScreenToEdit(RecordSet.getString("seclevel1"),user.getLanguage());				/*��ȫ����*/
	departmentid = Util.toScreenToEdit(RecordSet.getString("departmentid"),user.getLanguage());/*����*/
	costcenterid = Util.toScreenToEdit(RecordSet.getString("costcenterid"),user.getLanguage());			/*�ɱ�����*/
	resourceid = Util.toScreenToEdit(RecordSet.getString("resourceid"),user.getLanguage());		/*������Դ*/
	currencyid = Util.toScreenToEdit(RecordSet.getString("currencyid"),user.getLanguage());	/*����*/
	capitalcost = Util.toScreenToEdit(RecordSet.getString("capitalcost"),user.getLanguage());	/*�ɱ�*/
	capitalcost1 = Util.toScreenToEdit(RecordSet.getString("capitalcost1"),user.getLanguage());	/*�ɱ�*/
	startprice = Util.toScreenToEdit(RecordSet.getString("startprice"),user.getLanguage());	/*��ʼ�۸�*/
	startprice1 = Util.toScreenToEdit(RecordSet.getString("startprice1"),user.getLanguage());	/*��ʼ�۸�*/
	depreendprice = Util.toScreenToEdit(RecordSet.getString("depreendprice"),user.getLanguage()); /*�۾ɵ׼�(��)*/
	depreendprice1 = Util.toScreenToEdit(RecordSet.getString("depreendprice1"),user.getLanguage()); /*�۾ɵ׼�(��)*/
	capitalspec = Util.toScreenToEdit(RecordSet.getString("capitalspec"),user.getLanguage());			/*����ͺ�(��)*/
	capitallevel = Util.toScreenToEdit(RecordSet.getString("capitallevel"),user.getLanguage());	/*�ʲ��ȼ�(��)*/
	manufacturer = Util.toScreenToEdit(RecordSet.getString("manufacturer"),user.getLanguage());			/*���쳧��(��)*/
	manudate	= Util.toScreenToEdit(RecordSet.getString("manudate"),user.getLanguage());			/*��������(��)*/
	manudate1	= Util.toScreenToEdit(RecordSet.getString("manudate1"),user.getLanguage());			/*��������(��)*/
	capitaltypeid = Util.toScreenToEdit(RecordSet.getString("capitaltypeid"),user.getLanguage());			/*�ʲ�����*/
	capitalgroupid = Util.toScreenToEdit(RecordSet.getString("capitalgroupid"),user.getLanguage());			/*�ʲ���*/
	unitid = Util.toScreenToEdit(RecordSet.getString("unitid"),user.getLanguage());				/*������λ*/
	capitalnum = Util.toScreenToEdit(RecordSet.getString("capitalnum"),user.getLanguage());			/*����*/
	capitalnum1 = Util.toScreenToEdit(RecordSet.getString("capitalnum1"),user.getLanguage());			/*����*/
	currentnum = Util.toScreenToEdit(RecordSet.getString("currentnum"),user.getLanguage());			/*��ǰ����*/
	currentnum1 = Util.toScreenToEdit(RecordSet.getString("currentnum1"),user.getLanguage());			/*��ǰ����*/
	replacecapitalid =Util.toScreenToEdit(RecordSet.getString("replacecapitalid"),user.getLanguage());				/*���*/
	version =Util.toScreenToEdit(RecordSet.getString("version"),user.getLanguage()) ;			/*�汾*/
	itemid =Util.toScreenToEdit(RecordSet.getString("itemid"),user.getLanguage());			/*��Ʒ*/
	depremethod1 =Util.toScreenToEdit(RecordSet.getString("depremethod1"),user.getLanguage());			/*�۾ɷ�һ*/
	depremethod2 =Util.toScreenToEdit(RecordSet.getString("depremethod2"),user.getLanguage());			/*�۾ɷ���*/
	deprestartdate =Util.toScreenToEdit(RecordSet.getString("deprestartdate"),user.getLanguage());		/*�۾ɿ�ʼ����*/
	deprestartdate1 =Util.toScreenToEdit(RecordSet.getString("deprestartdate1"),user.getLanguage());		/*�۾ɿ�ʼ����*/
	depreenddate = Util.toScreenToEdit(RecordSet.getString("depreenddate"),user.getLanguage()) ;			/*�۾ɽ�������*/
	depreenddate1 = Util.toScreenToEdit(RecordSet.getString("depreenddate1"),user.getLanguage()) ;			/*�۾ɽ�������*/
	customerid=Util.toScreenToEdit(RecordSet.getString("customerid"),user.getLanguage());			/*�ͻ�id*/
	attribute= Util.toScreenToEdit(RecordSet.getString("attribute"),user.getLanguage());
	stateid = Util.toScreenToEdit(RecordSet.getString("stateid"),user.getLanguage());	/*�ʲ�״̬*/
	location = Util.toScreenToEdit(RecordSet.getString("location"),user.getLanguage()) ;			/*��ŵص�*/
	isdata = Util.toScreenToEdit(RecordSet.getString("isdata"),user.getLanguage()) ;			/*�ʲ�������*/
	counttype = Util.toScreenToEdit(RecordSet.getString("counttype"),user.getLanguage()) ;			/*���ʻ�ͺ�*/
	isinner = Util.toScreenToEdit(RecordSet.getString("isinner"),user.getLanguage()) ;			/*���ڻ�����*/
    stockindate	    = Util.toScreenToEdit(RecordSet.getString("stockindate"),user.getLanguage()) ;			/*������ڴ�*/
    stockindate1	= Util.toScreenToEdit(RecordSet.getString("stockindate1"),user.getLanguage()) ;		    /*������ڵ�*/


	fnamark = Util.toScreenToEdit(RecordSet.getString("fnamark"),user.getLanguage()); /*������*/
	barcode = Util.toScreenToEdit(RecordSet.getString("barcode"),user.getLanguage()); /*������*/
	blongdepartment = Util.toScreenToEdit(RecordSet.getString("blongdepartment"),user.getLanguage());/*��������*/
	sptcount = Util.toScreenToEdit(RecordSet.getString("sptcount"),user.getLanguage());/*��������*/
	relatewfid = Util.toScreenToEdit(RecordSet.getString("relatewfid"),user.getLanguage()); /*��ع�����*/
	SelectDate = Util.toScreenToEdit(RecordSet.getString("SelectDate"),user.getLanguage());/*��������*/
	SelectDate1 = Util.toScreenToEdit(RecordSet.getString("SelectDate1"),user.getLanguage());/*��������1*/
	contractno = Util.toScreenToEdit(RecordSet.getString("contractno"),user.getLanguage());/*��ͬ��*/
	Invoice = Util.toScreenToEdit(RecordSet.getString("Invoice"),user.getLanguage());/*��Ʊ��*/
	depreyear = Util.toScreenToEdit(RecordSet.getString("depreyear"),user.getLanguage());/*�۾�����*/
	deprerate = Util.toScreenToEdit(RecordSet.getString("deprerate"),user.getLanguage());/*��ֵ��*/
	depreyear1 = Util.toScreenToEdit(RecordSet.getString("depreyear1"),user.getLanguage());/*�۾�����*/
	deprerate1 = Util.toScreenToEdit(RecordSet.getString("deprerate1"),user.getLanguage());/*��ֵ��*/
	issupervision = Util.toScreenToEdit(RecordSet.getString("issupervision"),user.getLanguage());/*�Ƿ񺣹ؼ��*/
	amountpay = Util.toScreenToEdit(RecordSet.getString("amountpay"),user.getLanguage());/*�Ѹ����*/
	amountpay1 = Util.toScreenToEdit(RecordSet.getString("amountpay1"),user.getLanguage());/*�Ѹ����*/
	purchasestate = Util.toScreenToEdit(RecordSet.getString("purchasestate"),user.getLanguage());/*�ɹ�״̬*/
	
	datafield1 = Util.toScreenToEdit(RecordSet.getString("datafield1"),user.getLanguage());/*�Զ�����������*/
	datafield11 = Util.toScreenToEdit(RecordSet.getString("datafield11"),user.getLanguage());/*�Զ�����������*/
	datafield2 = Util.toScreenToEdit(RecordSet.getString("datafield2"),user.getLanguage());/*�Զ�����������*/
	datafield22 = Util.toScreenToEdit(RecordSet.getString("datafield22"),user.getLanguage());/*�Զ�����������*/
	datafield3 = Util.toScreenToEdit(RecordSet.getString("datafield3"),user.getLanguage());/*�Զ�����������*/
	datafield33 = Util.toScreenToEdit(RecordSet.getString("datafield33"),user.getLanguage());/*�Զ�����������*/
	datafield4 = Util.toScreenToEdit(RecordSet.getString("datafield4"),user.getLanguage());/*�Զ�����������*/
	datafield44 = Util.toScreenToEdit(RecordSet.getString("datafield44"),user.getLanguage());/*�Զ�����������*/
	datafield5 = Util.toScreenToEdit(RecordSet.getString("datafield5"),user.getLanguage());/*�Զ�����������*/
	datafield55 = Util.toScreenToEdit(RecordSet.getString("datafield55"),user.getLanguage());/*�Զ�����������*/	
		
	numberfield1 = Util.toScreenToEdit(RecordSet.getString("numberfield1"),user.getLanguage());/*�Զ��帡����*/
	numberfield11 = Util.toScreenToEdit(RecordSet.getString("numberfield11"),user.getLanguage());/*�Զ��帡����*/
	numberfield2 = Util.toScreenToEdit(RecordSet.getString("numberfield2"),user.getLanguage());/*�Զ��帡����*/
	numberfield22 = Util.toScreenToEdit(RecordSet.getString("numberfield22"),user.getLanguage());/*�Զ��帡����*/
	numberfield3 = Util.toScreenToEdit(RecordSet.getString("numberfield3"),user.getLanguage());/*�Զ��帡����*/
	numberfield33 = Util.toScreenToEdit(RecordSet.getString("numberfield33"),user.getLanguage());/*�Զ��帡����*/
	numberfield4 = Util.toScreenToEdit(RecordSet.getString("numberfield4"),user.getLanguage());/*�Զ��帡����*/
	numberfield44 = Util.toScreenToEdit(RecordSet.getString("numberfield44"),user.getLanguage());/*�Զ��帡����*/
	numberfield5 = Util.toScreenToEdit(RecordSet.getString("numberfield5"),user.getLanguage());/*�Զ��帡����*/
	numberfield55 = Util.toScreenToEdit(RecordSet.getString("numberfield55"),user.getLanguage());/*�Զ��帡����*/
		
	textfield1 = Util.toScreenToEdit(RecordSet.getString("textfield1"),user.getLanguage());/*�Զ����ı�*/
	textfield2 = Util.toScreenToEdit(RecordSet.getString("textfield2"),user.getLanguage());/*�Զ����ı�*/
	textfield3 = Util.toScreenToEdit(RecordSet.getString("textfield3"),user.getLanguage());/*�Զ����ı�*/
	textfield4 = Util.toScreenToEdit(RecordSet.getString("textfield4"),user.getLanguage());/*�Զ����ı�*/
	textfield5 = Util.toScreenToEdit(RecordSet.getString("textfield5"),user.getLanguage());/*�Զ����ı�*/
	
	tinyintfield1 = Util.toScreenToEdit(RecordSet.getString("tinyintfield1"),user.getLanguage());/*�Զ���check��*/
	tinyintfield2 = Util.toScreenToEdit(RecordSet.getString("tinyintfield2"),user.getLanguage());/*�Զ���check��*/
	tinyintfield3 = Util.toScreenToEdit(RecordSet.getString("tinyintfield3"),user.getLanguage());/*�Զ���check��*/
	tinyintfield4 = Util.toScreenToEdit(RecordSet.getString("tinyintfield4"),user.getLanguage());/*�Զ���check��*/
	tinyintfield5 = Util.toScreenToEdit(RecordSet.getString("tinyintfield5"),user.getLanguage());/*�Զ���check��*/
		
	docff01name = Util.toScreenToEdit(RecordSet.getString("docff01name"),user.getLanguage());/*�Զ�����ĵ�*/
	docff02name = Util.toScreenToEdit(RecordSet.getString("docff02name"),user.getLanguage());/*�Զ�����ĵ�*/
	docff03name = Util.toScreenToEdit(RecordSet.getString("docff03name"),user.getLanguage());/*�Զ�����ĵ�*/
	docff04name = Util.toScreenToEdit(RecordSet.getString("docff04name"),user.getLanguage());/*�Զ�����ĵ�*/
	docff05name = Util.toScreenToEdit(RecordSet.getString("docff05name"),user.getLanguage());/*�Զ�����ĵ�*/
		
	depff01name = Util.toScreenToEdit(RecordSet.getString("depff01name"),user.getLanguage());/*�Զ���ಿ��*/
	depff02name = Util.toScreenToEdit(RecordSet.getString("depff02name"),user.getLanguage());/*�Զ���ಿ��*/
	depff03name = Util.toScreenToEdit(RecordSet.getString("depff03name"),user.getLanguage());/*�Զ���ಿ��*/
	depff04name = Util.toScreenToEdit(RecordSet.getString("depff04name"),user.getLanguage());/*�Զ���ಿ��*/
	depff05name = Util.toScreenToEdit(RecordSet.getString("depff05name"),user.getLanguage());/*�Զ���ಿ��*/
		
	crmff01name = Util.toScreenToEdit(RecordSet.getString("crmff01name"),user.getLanguage());/*�Զ����ͻ�*/
	crmff02name = Util.toScreenToEdit(RecordSet.getString("crmff02name"),user.getLanguage());/*�Զ����ͻ�*/
	crmff03name = Util.toScreenToEdit(RecordSet.getString("crmff03name"),user.getLanguage());/*�Զ����ͻ�*/
	crmff04name = Util.toScreenToEdit(RecordSet.getString("crmff04name"),user.getLanguage());/*�Զ����ͻ�*/
	crmff05name = Util.toScreenToEdit(RecordSet.getString("crmff05name"),user.getLanguage());/*�Զ����ͻ�*/
		
	reqff01name = Util.toScreenToEdit(RecordSet.getString("reqff01name"),user.getLanguage());/*�Զ��������*/
	reqff02name = Util.toScreenToEdit(RecordSet.getString("reqff02name"),user.getLanguage());/*�Զ��������*/
	reqff03name = Util.toScreenToEdit(RecordSet.getString("reqff03name"),user.getLanguage());/*�Զ��������*/
	reqff04name = Util.toScreenToEdit(RecordSet.getString("reqff04name"),user.getLanguage());/*�Զ��������*/
	reqff05name = Util.toScreenToEdit(RecordSet.getString("reqff05name"),user.getLanguage());/*�Զ��������*/

} else {
	isdata = Util.null2String(request.getParameter("isdata"));
    resourceid = Util.null2String(request.getParameter("resourceid"));
    type = Util.null2String(request.getParameter("type"));
    if(type.equals("")) type="search";
}

String datafields[] = {datafield1,datafield11,datafield2,datafield22,datafield3,datafield33,datafield4,datafield44,datafield5,datafield55};
String numberfield[] = {numberfield1,numberfield11,numberfield2,numberfield22,numberfield3,numberfield33,numberfield4,numberfield44,numberfield5,numberfield55};
String textfield[] = {textfield1,textfield2,textfield3,textfield4,textfield5};
String tinyintfield[] = {tinyintfield1,tinyintfield2,tinyintfield3,tinyintfield4,tinyintfield5};
String docffs[] = {docff01name,docff02name,docff03name,docff04name,docff05name};
String depffs[] = {depff01name,depff02name,depff03name,depff04name,depff05name};
String crmffs[] = {crmff01name,crmff02name,crmff03name,crmff04name,crmff05name};
String reqffs[] = {reqff01name,reqff02name,reqff03name,reqff04name,reqff05name};

int rownum = 0;
int halfnum = 0;
if (isdata.equals(""))
	isdata = "1";

String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(197,user.getLanguage())+":";

if (isdata.equals("1")) 
	titlename = titlename + SystemEnv.getHtmlLabelName(1509,user.getLanguage());
else
	titlename = titlename + SystemEnv.getHtmlLabelName(535,user.getLanguage());

String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
if(advanced==1) {
	RCMenu += "{"+SystemEnv.getHtmlLabelName(342,user.getLanguage())+",javascript:onAdvanced(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}else{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(347,user.getLanguage())+",javascript:onAdvanced(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{-}" ;
if(mouldid==0){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(350,user.getLanguage())+",javascript:onSaveas(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}else{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDelete(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
} 
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">

		<TABLE class=Shadow>
		<tr>
		<td valign="top">
			<FORM action=CptSearch.jsp method=post name=frmain>
			<input type=hidden name=type value="<%=type%>">
            <input type=hidden name=from value="<%=from%>">
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
			<TBODY>
			<TR>
			<TD vAlign=top width="84%">
			<input type="hidden" name="advanced" value="<%=advanced%>">
			<input type="hidden" name="mouldid" value="<%=mouldid%>"> 
			<input type="hidden" name="operation">
			<TABLE class=ViewForm>
			<COLGROUP>
			<COL width="49%">
			<COL width=10>
			<COL width="49%">
			<TBODY>
			<TR>
			  <TD vAlign=top>
				  <TABLE width="100%">
					<COLGROUP> <COL width="30%"> <COL width="70%"> <TBODY> 
					<TR class=Title> 
					  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
					</TR>
					<TR class=Spacing style="height:1px;"> 
					  <TD class=Line1 colSpan=2></TD>
					</TR>

					 <!-- �ʲ������� -->
					 <%if(mouldid==0||!(isdata.equals("0"))){%>
                     <%if(!from.equals("cptmodify")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15361,user.getLanguage())%></td>
					  <td class=Field> 
                        <select class=InputStyle id=isdata name=isdata>
						  <option value=2 <% if(isdata.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(535,user.getLanguage())%></option>
						  <option value=1 <% if(isdata.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1509,user.getLanguage())%></option>
						</select>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
                      <%}else{%>
                           <input id=isdata type=hidden name=isdata value="2">
                      <%}%>
					<%}%> 

				<%
					if(mouldid==0){
						rs.executeSql("select * from CptSearchDefinition where isconditions = 1 and isseniorconditions = 0 and mouldid=-1 order by displayorder asc");	
					}else{
						rs.executeSql("select * from CptSearchDefinition where isconditions = 1 and isseniorconditions = 0 and mouldid="+mouldid+" order by displayorder asc");	
					}
					rownum = rs.getCounts();
					while(rs.next()){
						String fieldname = rs.getString("fieldname");
						halfnum++;
				%>		
					 

				<!-- �ֶο�ʼ �ֶδ���-->
			<%if(halfnum==(rownum+2)/2){%>	
					</TBODY> 
				  </TABLE>
				</TD>
			  <TD vAlign=top width="100%">
				  <TABLE width="100%">
					<COLGROUP> <COL width="30%"> <COL width="70%"> <TBODY> 
					<TR class=Title> 
					  <TH colSpan=2>&nbsp;</TH>
					</TR>
					<TR class=Spacing style="height:1px;"> 
					  <TD class=Line1 colSpan=2></TD>
					</TR>
			<%}%>	
				<!-- �ֶν��� -->

					
					<!-- ��� -->
					<%if((mouldid==0||!(mark.equals("")))&&fieldname.equals("mark")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="mark" value="<%=mark%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>  

					<!-- ������ -->
					<%if((mouldid==0||!(fnamark.equals("")))&&fieldname.equals("fnamark")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(15293,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="fnamark" value="<%=fnamark%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>  


					<!-- ��ͬ�� -->
					<%if((mouldid==0||!(contractno.equals("")))&&fieldname.equals("contractno")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(21282,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="contractno" value="<%=contractno%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- ��Ʊ���� -->
					<%if((mouldid==0||!(Invoice.equals("")))&&fieldname.equals("Invoice")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(900,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="Invoice" value="<%=Invoice%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 					

					<!-- ���� -->
					 <%if((mouldid==0||!(name.equals("")))&&fieldname.equals("name")){%>
					<tr> 
					 <td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
					 <td class=Field> 
					 	<input class=InputStyle maxlength=60 name="name" size=30 value="<%=name%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>

					<!-- ������ -->
					<%if((mouldid==0||!(barcode.equals("")))&&fieldname.equals("barcode")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(1362,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="barcode" value="<%=barcode%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- �۾����� -->					
					<%if((mouldid==0||!(depreyear.equals(""))||!(depreyear1.equals("")))&&fieldname.equals("depreyear")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(19598,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=depreyear%>" name="depreyear" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("depreyear")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=depreyear1%>" name="depreyear1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("depreyear1")'>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 					
					
					<!-- ��ֵ�� -->					
					<%if((mouldid==0||!(deprerate.equals(""))||!(deprerate1.equals("")))&&fieldname.equals("deprerate")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(1390,user.getLanguage())%></td>
					<td class=Field>  
						<input class=InputStyle maxlength=16 size=10 value="<%=deprerate%>" name="deprerate" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("deprerate")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=deprerate1%>" name="deprerate1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("deprerate1")'>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- �Ƿ񺣹ؼ�� -->					
					<%if((mouldid==0||!(issupervision.equals("")))&&fieldname.equals("issupervision")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(22339,user.getLanguage())%></td>
					<td class=Field> 
						<select name="issupervision">
							<option value="1" <%if(issupervision.equals("0")){%>selected<%}%>></option>
							<option value="1" <%if(issupervision.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></option>
							<option value="2" <%if(issupervision.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></option>
						</select>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>					

					<!-- �ʲ��� -->
					<%if((mouldid==0||!(capitalgroupid.equals("0")||capitalgroupid.equals("")))&&fieldname.equals("capitalgroupid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(831,user.getLanguage())%></td>
					   <td class=Field> <button type=button  class=Browser onClick="onShowCapitalgroupid()"></button> 
					  <span id=capitalgroupidspan ><%=Util.toScreen(CapitalAssortmentComInfo.getAssortmentName(capitalgroupid),user.getLanguage())%>
					 </span> 
					 <input type=hidden name=capitalgroupid value="<%=capitalgroupid%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>

					<!-- ���� -->
					<%if((mouldid==0||!(currencyid.equals("0")||currencyid.equals("")))&&fieldname.equals("currencyid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></td>
					   <td class=Field> <button type=button  class=Browser onClick="onShowCurrencyID()"></button> 
					  <span id=currencyidspan ><%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyid),user.getLanguage())%>
					 </span> 
					 <input type=hidden name=currencyid value="<%=currencyid%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>
					
					<!-- �۸�/�ο��۸� -->
					<%if((mouldid==0||!(startprice.equals(""))||!(startprice1.equals("")))&&fieldname.equals("startprice")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(726,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=startprice%>" name="startprice" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("startprice")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=startprice1%>" name="startprice1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("startprice1")'>
						</td>
					</tr>
					<%}%>

					<!-- �Ѹ���� -->
					<%if((mouldid==0||!(amountpay.equals(""))||!(amountpay1.equals("")))&&fieldname.equals("amountpay")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(22338,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=amountpay%>" name="amountpay" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("amountpay")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=amountpay1%>" name="amountpay1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("amountpay1")'>
						</td>
					</tr>
					<%}%>
										
					<!-- �ʲ����� -->
					<%if((mouldid==0||!(capitaltypeid.equals("0")||capitaltypeid.equals("")))&&fieldname.equals("capitaltypeid")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(703,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowCapitaltypeid()"></button> 
						 <span id=capitaltypeidspan><%=Util.toScreen(CapitalTypeComInfo.getCapitalTypename(capitaltypeid),user.getLanguage())%></span> 
					   	 <input type=hidden name=capitaltypeid value="<%=capitaltypeid%>">
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>

					<!-- �������� -->
					<%if((mouldid==0||!(sptcount.equals("")))&&fieldname.equals("sptcount")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1363,user.getLanguage())%></td>
					  <td class=Field>
					  	<input type=checkbox name=sptcount value="1" <%if(sptcount.equals("1")){%>checked<%}%>>
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>

				<!-- ��ع����� -->
					<%if((mouldid==0||!(relatewfid.equals("")||relatewfid.equals("0")))&&fieldname.equals("relatewfid")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15295,user.getLanguage())%></td>
					  <td class=Field>
					  	  <button type=button  class=Browser onClick='onShowRequest("relatewfid","relatewfidspan")'></button>
						  <span id="relatewfidspan" name="relatewfidspan"></span>
						  <input type=hidden name="relatewfid" class=inputstyle>
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>					

				<!-- �ɹ�״̬ -->
				<%if((mouldid==0||!(purchasestate.equals("")||purchasestate.equals("0")))&&fieldname.equals("purchasestate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(22333,user.getLanguage())%></td>
					  <td class=Field> 
							<SELECT name="purchasestate">
								<OPTION value="0" <%if(purchasestate.equals("0")){%>selected<%}%>></OPTION>
								<OPTION value="1" <%if(purchasestate.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22334,user.getLanguage())%></OPTION>
								<OPTION value="2" <%if(purchasestate.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22335,user.getLanguage())%></OPTION>
								<OPTION value="3" <%if(purchasestate.equals("3")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22336,user.getLanguage())%></OPTION>
								<OPTION value="4" <%if(purchasestate.equals("4")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22337,user.getLanguage())%></OPTION>
							</SELECT>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					
				<!-- ���ڻ����� -->
				<%if((mouldid==0||!(isinner.equals("0")||isinner.equals("")))&&fieldname.equals("isinner")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15297,user.getLanguage())%></td>
					  <td class=Field> 
						<select class=InputStyle id=isinner name=isinner>
						<option value=0 <% if(isinner.equals("")) {%>selected<%}%>></option>
						  <option value=1 <% if(isinner.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15298,user.getLanguage())%></option>
						  <option value=2 <% if(isinner.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15299,user.getLanguage())%></option>
						</select>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

					<!-- ��Ч�� -->
					<%if((mouldid==0||!(startdate.equals(""))||!(startdate1.equals("")))&&fieldname.equals("startdate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></td>
					  <td class=Field>
					  	<button type=button  class=Calendar id=selectstartdate onClick="getDate(startdatespan,startdate)"></button> 
						<span id=startdatespan ><%=startdate%></span> 
						<input type="hidden" name="startdate" value="<%=startdate%>">
					   -<button type=button  class=Calendar id=selectstartdate1 onClick="getDate(startdate1span,startdate1)"></button> 
						<span id=startdate1span ><%=startdate1%></span> 
						<input type="hidden" name="startdate1" value="<%=startdate1%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ч�� -->
					<%if((mouldid==0||!(enddate.equals(""))||!(enddate1.equals("")))&&fieldname.equals("enddate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectenddate onClick="getDate(enddatespan,enddate)"></button> 
						<span id=enddatespan ><%=enddate%></span> 
						<input type="hidden" name="enddate" value="<%=enddate%>">
						-<button type=button  class=Calendar id=selectenddate1 onClick="getDate(enddate1span,enddate1)"></button> 
						<span id=enddate1span ><%=enddate1%></span> 
						<input type="hidden" name="enddate1" value="<%=enddate1%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>
                    
                    <!-- ʹ�÷ֲ�
					<%if((mouldid==0||!(departmentid.equals("0")||departmentid.equals("")))&&fieldname.equals("departmentid")){%>
                    <tr> 
                      <td><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></td>
                      <td class=Field><button type=button  class=Browser id=SelectSubCompanyID onClick="onShowSubcompany('subcompanyidspan','subcompanyid')"></button> 
                        <span id="subcompanyidspan"></span> 
                        <input id=subcompanyid type=hidden name=subcompanyid>
                      </td>
                    </tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    -->

                    <!-- ʹ�ò���-->
					<%if((mouldid==0||!(departmentid.equals("0")||departmentid.equals("")))&&fieldname.equals("departmentid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(21030,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectDeparment onClick="onShowDepartment('departmentid', 'departmentspan')"></button> 
						<span class=InputStyle id=departmentspan><%=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid),user.getLanguage())%></span> 
						<input id=departmentid type=hidden name=departmentid value="<%=departmentid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!-- �����ֲ�-->
					<%if((mouldid==0||!(blongsubcompany.equals("0")||blongsubcompany.equals("")))&&fieldname.equals("blongsubcompany")){%>
                    <tr> 
                      <td><%=SystemEnv.getHtmlLabelName(19799,user.getLanguage())%></td>
                      <td class=Field><button type=button  class=Browser id=SelectSubCompanyID onClick="onShowSubcompany('blongsubcompanyspan','blongsubcompany')"></button> 
                        <span id="blongsubcompanyspan"></span> 
                        <input id=blongsubcompany type=hidden name=blongsubcompany>
                      </td>
                    </tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    
                    <!-- ��������-->
					<%if((mouldid==0||!(blongdepartment.equals("0")||blongdepartment.equals("")))&&fieldname.equals("blongdepartment")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15393,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectDeparment onClick="onShowDepartment('blongdepartment', 'blongdepartmentspan')"></button> 
						<span class=InputStyle id=blongdepartmentspan><%=Util.toScreen(DepartmentComInfo.getDepartmentname(blongdepartment),user.getLanguage())%></span> 
						<input id=blongdepartment type=hidden name=blongdepartment value="<%=blongdepartment%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
										 
					 <!-- ������Դ/ʹ����/����Ա -->
					 <%if((mouldid==0||!(resourceid.equals("0")||resourceid.equals("")))&&fieldname.equals("resourceid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1508,user.getLanguage())%>/<%=SystemEnv.getHtmlLabelName(1507,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectResourceID onClick="onShowResourceID()"></button> 
						<span id=resourceidspan><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></span> 
						<input class=InputStyle id=resourceid type=hidden name=resourceid value="<%=resourceid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>
            
						<!-- ������λ -->
						<%if((mouldid==0||!(stateid.equals("0")||stateid.equals("")))&&fieldname.equals("unitid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowLgcAssetUnit('unitid', 'unitidspan')"></button> 
						<span id=unitidspan><%=Util.toScreen(AssetUnitComInfo.getAssetUnitname(unitid),user.getLanguage())%></span> 
						<input type=hidden name=unitid value="<%=unitid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���� -->
					<%if((mouldid==0||!(capitalnum.equals(""))||!(capitalnum1.equals("")))&&fieldname.equals("capitalnum")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1331,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=10 size=10 value="<%=capitalnum%>" name="capitalnum" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("capitalnum")'>
					   -<input class=InputStyle maxlength=10 size=10 value="<%=capitalnum1%>" name="capitalnum1" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("capitalnum1")'>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��ǰ���� -->
					<%if((mouldid==0||!(currentnum.equals(""))||!(currentnum1.equals("")))&&fieldname.equals("currentnum")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1451,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=10 size=10 value="<%=currentnum%>" name="currentnum" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("currentnum")'>
					   -<input class=InputStyle maxlength=10 size=10 value="<%=currentnum1%>" name="currentnum1" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("currentnum1")'>
				</td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

					<!-- ����ͺ� -->
					<%if((mouldid==0||!(capitalspec.equals("")))&&fieldname.equals("capitalspec")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(904,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=60 size=30 value="<%=capitalspec%>" name="capitalspec">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �ȼ� -->
					<%if((mouldid==0||!(capitallevel.equals("")))&&fieldname.equals("capitallevel")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(603,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=30 size=30 value="<%=capitallevel%>" name="capitallevel">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���쳧�� -->
					<%if((mouldid==0||!(manufacturer.equals("")))&&fieldname.equals("manufacturer")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1364,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=100 size=30 value="<%=manufacturer%>" name="manufacturer">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �������� -->
					<%if((mouldid==0||!(manudate.equals(""))||!(manudate1.equals("")))&&fieldname.equals("manudate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1365,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectmanudate onClick="getDate(manudatespan,manudate)"></button> 
						<span id=manudatespan ><%=manudate%></span> 
						<input type="hidden" name="manudate" value="<%=manudate%>" >
					  -<button type=button  class=Calendar id=selectmanudate1 onClick="getDate(manudate1span,manudate1)"></button> 
						<span id=manudate1span ><%=manudate1%></span> 
						<input type="hidden" name="manudate1" value="<%=manudate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ӧ�� -->
					<%if((mouldid==0||!(customerid.equals("0")||customerid.equals("")))&&fieldname.equals("customerid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(138,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowCustomerid()"></button> 
						<span id=customeridspan><%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(customerid),user.getLanguage())%></span> 
						<input type=hidden name=customerid value="<%=customerid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���� -->
					<%if((mouldid==0||!(attribute.equals("")))&&fieldname.equals("attribute")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(713,user.getLanguage())%></td>
					  <td class=Field> 
						<select class=InputStyle id=attribute name=attribute>
						  <option></option>
						  <option value=0 <% if(attribute.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1366,user.getLanguage())%></option>
						  <option value=1 <% if(attribute.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1367,user.getLanguage())%></option>
						  <option value=2 <% if(attribute.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1368,user.getLanguage())%></option>
						  <option value=3 <% if(attribute.equals("3")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1369,user.getLanguage())%></option>
						  <option value=4 <% if(attribute.equals("4")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(60,user.getLanguage())%></option>
						  <option value=5 <% if(attribute.equals("5")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1370,user.getLanguage())%></option>
						  <option value=6 <% if(attribute.equals("6")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(811,user.getLanguage())%></option>
						</select>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ״̬ -->
					<%if((mouldid==0||!(stateid.equals("0")||stateid.equals("")))&&fieldname.equals("stateid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowStateid()"></button> 
						<span id=stateidspan><%=Util.toScreen(CapitalStateComInfo.getCapitalStatename(stateid),user.getLanguage())%></span> 
						<input type=hidden name=stateid value="<%=stateid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!--�������-->
					<%if((mouldid==0||!(stockindate.equals(""))||!(stockindate1.equals("")))&&fieldname.equals("StockInDate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(753,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectstockindate onClick="getDate(stockindatespan,stockindate)"></button> 
						<span id=stockindatespan ><%=stockindate%></span> 
						<input type="hidden" name="stockindate" value="<%=stockindate%>" >
					  -<button type=button  class=Calendar id=selectstockindate1 onClick="getDate(stockindate1span,stockindate1)"></button> 
						<span id=stockindate1span ><%=stockindate1%></span> 
						<input type="hidden" name="stockindate1" value="<%=stockindate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!--��������-->
					<%if((mouldid==0 || !(SelectDate.equals("")) || !(SelectDate1.equals("")))&&fieldname.equals("SelectDate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(16914,user.getLanguage())%></td>
					  <td class=Field>
					    <button type=button  class=Calendar id=bSelectDate onClick="getDate(SelectDatespan,SelectDate)"></button> 
						<span id=SelectDatespan ><%=SelectDate%></span> 
						<input type="hidden" name="SelectDate" value="<%=SelectDate%>" >
					  
					   -<button type=button  class=Calendar id=bSelectDate1 onClick="getDate(SelectDate1span,SelectDate1)"></button> 
						<span id=SelectDate1span ><%=SelectDate1%></span> 
						<input type="hidden" name="SelectDate1" value="<%=SelectDate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��� -->
					<%if((mouldid==0||!(replacecapitalid.equals("0")||replacecapitalid.equals("")))&&fieldname.equals("replacecapitalid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1371,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowReplacecapitalid()"></button> 
						<span id=replacecapitalidspan><%=Util.toScreen(CapitalComInfo.getCapitalname(replacecapitalid),user.getLanguage())%></span> 
						<input type=hidden name=replacecapitalid value="<%=replacecapitalid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ʒ -->
					<%if((mouldid==0||!(itemid.equals("0")))&&fieldname.equals("itemid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(145,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowLgcAsset('itemid', 'itemidspan')"></button> 
						<span id=itemidspan><%=Util.toScreen(AssetComInfo.getAssetName(itemid),user.getLanguage())%></span> 
						<input type=hidden name=itemid value="<%=itemid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
						<%}%>
					
					<!-- ��ŵص� -->
					<%if((mouldid==0||!(location.equals("")))&&fieldname.equals("location")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1387,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=100 size=30 name=location value="<%=location%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �汾 -->
					<%if((mouldid==0||!(version.equals("")))&&fieldname.equals("version")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name=version value="<%=version%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    
                    <!--��������-->
					<%if((mouldid==0||!(deprestartdate.equals(""))||!(deprestartdate1.equals("")))&&fieldname.equals("deprestartdate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1412,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectdeprestartdate onClick="getDate(deprestartdatespan,deprestartdate)"></button> 
						<span id=deprestartdatespan ><%=deprestartdate%></span> 
						<input type="hidden" name="deprestartdate" value="<%=deprestartdate%>" >
					  -<button type=button  class=Calendar id=selectdeprestartdate1 onClick="getDate(deprestartdate1span,deprestartdate1)"></button> 
						<span id=deprestartdate1span ><%=deprestartdate1%></span> 
						<input type="hidden" name="deprestartdate1" value="<%=deprestartdate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>


					<%
					
					RecordSet.executeProc("Base_FreeField_Select","cp");
					boolean hasFF = true;
					if(RecordSet.getCounts()<=0)
						hasFF = false;
					else
						RecordSet.first();
					
					if(hasFF)
					{
						for(int i=1;i<=5;i++)
						{//����
							if(RecordSet.getString(i*2+1).equals("1")&&fieldname.equals("datefield"+i))
							{
							if(mouldid>0&&datafields[2*i-2].equals("")&&datafields[2*i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2)%></td>
								<td class=Field>
									<button type=button  class=Calendar id="selectdatafield<%=i%>" onClick="getDate(datafield<%=i%>span,datafield<%=i%>)"></button> 
									<span id="datafield<%=i%>span"><%=datafields[2*i-2]%></span> 
									<input type="hidden" name="datafield<%=i%>" value="<%=datafields[2*i-2]%>">
								   -<button type=button  class=Calendar id="selectdatafield<%=i%>1" onClick="getDate(datafield<%=i%>1span,datafield<%=i%>1)"></button> 
									<span id="datafield<%=i%>1span" ><%=datafields[2*i-1]%></span> 
									<input type="hidden" name="datafield<%=i%>1" value="<%=datafields[2*i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//����
							if(RecordSet.getString(i*2+11).equals("1")&&fieldname.equals("numberfield"+i))
							{
							if(mouldid>0&&numberfield[2*i-2].equals("")&&numberfield[2*i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+10)%></td>
								<td class=Field> 
								  <input class=InputStyle maxlength=16 size=10 value="<%=numberfield[2*i-2]%>" name="numberfield<%=i%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("numberfield<%=i%>")'>
					             -<input class=InputStyle maxlength=16 size=10 value="<%=numberfield[2*i-1]%>" name="numberfield<%=i%>1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("numberfield<%=i%>1")'>
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>			
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//�ı�
							if(RecordSet.getString(i*2+21).equals("1")&&fieldname.equals("textfield"+i))
							{
							if(mouldid>0&&textfield[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+20)%></td>
								<td class=Field> 
								  <input class=InputStyle maxlength=100 size=30 name="textfield<%=i%>" value="<%=textfield[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//checkbox
							if(RecordSet.getString(i*2+31).equals("1")&&fieldname.equals("tinyintfield"+i))
							{
							if(mouldid>0&&tinyintfield[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+30)%></td>
								<td class=Field> 
								  <input type=checkbox  name="tinyintfield<%=i%>" value="1" <%if(tinyintfield[i-1].equals("1")){%>checked<%}%>>
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//���ĵ�
							if(RecordSet.getString(i*2+41).equals("1")&&fieldname.equals("docff0"+i+"name"))
							{
							if(mouldid>0&&docffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+40)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowMDocid("docff0<%=i%>name","docff0<%=i%>namespan")'></button>
								  <span name="docff0<%=i%>namespan" id="docff0<%=i%>namespan">
									<%
									  	String tempdoc[] = Util.TokenizerString2(docffs[i-1],",");
									  	if(tempdoc!=null){
									  		for(int j=0;j<tempdoc.length;j++)
									  		out.println("<a href=javascript:openFullWindowForXtable('/docs/docs/DocDsp.jsp?id="+tempdoc[j]+"')>"+DocComInfo.getDocname(tempdoc[j])+"</a> ");
									  	}
								   %>
								  </span>
								  <input type=hidden name="docff0<%=i%>name" class=inputstyle value="<%=docffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//�ಿ��
							if(RecordSet.getString(i*2+51).equals("1")&&fieldname.equals("depff0"+i+"name"))
							{
							if(mouldid>0&&depffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+50)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowDepartmentMutil("depff0<%=i%>namespan","depff0<%=i%>name")'></button>
								  <SPAN id="depff0<%=i%>namespan" name="depff0<%=i%>namespan">
								  <%
								  	String tempdep[] = Util.TokenizerString2(depffs[i-1],",");
								  	if(tempdep!=null){
								  		for(int j=0;j<tempdep.length;j++)
								  		out.println(DepartmentComInfo.getDepartmentname(tempdep[j])+" ");
								  	}
								  %>
								  </SPAN>
								  <input type=hidden name="depff0<%=i%>name" class=inputstyle value="<%=depffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//��ͻ�
							if(RecordSet.getString(i*2+61).equals("1")&&fieldname.equals("crmff0"+i+"name"))
							{
							if(mouldid>0&&crmffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+60)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowCRM("crmff0<%=i%>name","crmff0<%=i%>namespan")'></button>
								  <span id="crmff0<%=i%>namespan" name="crmff0<%=i%>namespan">
								  <%
								  	String tempcrm[] = Util.TokenizerString2(crmffs[i-1],",");
								  	if(tempcrm!=null){
								  		for(int j=0;j<tempcrm.length;j++)
								  		out.println("<a href=javascript:openFullWindowForXtable('/CRM/data/ViewCustomer.jsp?CustomerID="+tempcrm[j]+"')>"+CustomerInfoComInfo.getCustomerInfoname(tempcrm[j])+"</a> ");
								  	}
								  %>								  
								  </span>
								  <input type=hidden name="crmff0<%=i%>name" class=inputstyle value="<%=crmffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//������
							if(RecordSet.getString(i*2+71).equals("1")&&fieldname.equals("reqffo"+i+"name"))
							{
							if(mouldid>0&&reqffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+70)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowRequest("reqff0<%=i%>name","reqff0<%=i%>namespan")'></button>
								  <span id="reqff0<%=i%>namespan" name="reqff0<%=i%>namespan">
								  <%
								  	String tempreq[] = Util.TokenizerString2(reqffs[i-1],",");
								  	if(tempreq!=null){
								  		for(int j=0;j<tempreq.length;j++)
								  		out.println("<a href=javascript:openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid="+tempreq[j]+"')>"+WorkflowRequestComInfo.getRequestName(tempreq[j])+"</a> ");
								  	}
								  %>								  
								  </span>
								  <input type=hidden name="reqff0<%=i%>name" class=inputstyle value="<%=reqffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
					}
			%>


			<%}%>



					</TBODY> 
				  </TABLE>
				</TD></TR>

<!-- ===========�߼�=========== -->

			<%if(advanced==1){ //�߼�%>

			<TR>
			  <TD vAlign=top>
				  <TABLE width="100%">
					<COLGROUP> <COL width="30%"> <COL width="70%"> <TBODY> 
					<TR class=Title> 
					  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(410,user.getLanguage())%></TH>
					</TR>
					<TR class=Spacing style="height:1px;"> 
					  <TD class=Line1 colSpan=2></TD>
					</TR>
					

					
				<%
					if(mouldid==0){
						rs.executeSql("select * from CptSearchDefinition where isconditions = 1 and isseniorconditions = 1 and mouldid=-1 order by displayorder asc");	
					}else{
						rs.executeSql("select * from CptSearchDefinition where isconditions = 1 and isseniorconditions = 1 and mouldid="+mouldid+" order by displayorder asc");	
					}
					rownum = rs.getCounts();
					halfnum = 0;
					while(rs.next()){
						String fieldname = rs.getString("fieldname");
						halfnum++;
				%>		
					 
				<!-- �ֶο�ʼ �ֶδ���-->
			<%if(halfnum==(rownum+3)/2){%>	
					</TBODY> 
				  </TABLE>
				</TD>
			  <TD vAlign=top>
				  <TABLE width="100%">
					<COLGROUP> <COL width="30%"> <COL width="70%"> <TBODY> 
					<TR class=Title> 
					  <TH colSpan=2>&nbsp;</TH>
					</TR>
					<TR class=Spacing style="height:1px;"> 
					  <TD class=Line1 colSpan=2></TD>
					</TR>
			<%}%>	
				<!-- �ֶν��� -->

					
					<!-- ��� -->
					<%if((mouldid==0||!(mark.equals("")))&&fieldname.equals("mark")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="mark" value="<%=mark%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>  

					<!-- ������ -->
					<%if((mouldid==0||!(fnamark.equals("")))&&fieldname.equals("fnamark")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(15293,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="fnamark" value="<%=fnamark%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>  


					<!-- ��ͬ�� -->
					<%if((mouldid==0||!(contractno.equals("")))&&fieldname.equals("contractno")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(21282,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="contractno" value="<%=contractno%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- ��Ʊ���� -->
					<%if((mouldid==0||!(Invoice.equals("")))&&fieldname.equals("Invoice")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(900,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="Invoice" value="<%=Invoice%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 					

					<!-- ���� -->
					 <%if((mouldid==0||!(name.equals("")))&&fieldname.equals("name")){%>
					<tr> 
					 <td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
					 <td class=Field> 
					 	<input class=InputStyle maxlength=60 name="name" size=30 value="<%=name%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>

					<!-- ������ -->
					<%if((mouldid==0||!(barcode.equals("")))&&fieldname.equals("barcode")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(1362,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name="barcode" value="<%=barcode%>">
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- �۾����� -->					
					<%if((mouldid==0||!(depreyear.equals(""))||!(depreyear1.equals("")))&&fieldname.equals("depreyear")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(19598,user.getLanguage())%></td>
					<td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=depreyear%>" name="depreyear" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("depreyear")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=depreyear1%>" name="depreyear1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("depreyear1")'>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 					
					
					<!-- ��ֵ�� -->					
					<%if((mouldid==0||!(deprerate.equals(""))||!(deprerate1.equals("")))&&fieldname.equals("deprerate")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(1390,user.getLanguage())%></td>
					<td class=Field>  
						<input class=InputStyle maxlength=16 size=10 value="<%=deprerate%>" name="deprerate" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("deprerate")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=deprerate1%>" name="deprerate1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("deprerate1")'>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%> 

					<!-- �Ƿ񺣹ؼ�� -->					
					<%if((mouldid==0||!(issupervision.equals("")))&&fieldname.equals("issupervision")){%>
					<tr> 
					<td><%=SystemEnv.getHtmlLabelName(22339,user.getLanguage())%></td>
					<td class=Field> 
						<select name="issupervision">
							<option value="1" <%if(issupervision.equals("0")){%>selected<%}%>></option>
							<option value="1" <%if(issupervision.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></option>
							<option value="2" <%if(issupervision.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></option>
						</select>
					</td>
					 </tr>
					  <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>					

					<!-- �ʲ��� -->
					<%if((mouldid==0||!(capitalgroupid.equals("0")))&&fieldname.equals("capitalgroupid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(831,user.getLanguage())%></td>
					   <td class=Field> <button type=button  class=Browser onClick="onShowCapitalgroupid()"></button> 
					  <span id=capitalgroupidspan ><%=Util.toScreen(CapitalAssortmentComInfo.getAssortmentName(capitalgroupid),user.getLanguage())%>
					 </span> 
					 <input type=hidden name=capitalgroupid value="<%=capitalgroupid%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>

					<!-- ���� -->
					<%if((mouldid==0||!(currencyid.equals("0")))&&fieldname.equals("currencyid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></td>
					   <td class=Field> <button type=button  class=Browser onClick="onShowCurrencyID()"></button> 
					  <span id=currencyidspan ><%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyid),user.getLanguage())%>
					 </span> 
					 <input type=hidden name=currencyid value="<%=currencyid%>">
					 </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>
					
					<!-- �۸�/�ο��۸� -->
					<%if((mouldid==0||!(startprice.equals(""))||!(startprice1.equals("")))&&fieldname.equals("startprice")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(726,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=startprice%>" name="startprice" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("startprice")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=startprice1%>" name="startprice1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("startprice1")'>
						</td>
					</tr>
					<%}%>

					<!-- �Ѹ���� -->
					<%if((mouldid==0||!(amountpay.equals(""))||!(amountpay1.equals("")))&&fieldname.equals("amountpay")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(22338,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=16 size=10 value="<%=amountpay%>" name="amountpay" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("amountpay")'>
					   -<input class=InputStyle maxlength=16 size=10 value="<%=amountpay1%>" name="amountpay1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("amountpay1")'>
						</td>
					</tr>
					<%}%>
										
					<!-- �ʲ����� -->
					<%if((mouldid==0||!(capitaltypeid.equals("0")))&&fieldname.equals("capitaltypeid")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(703,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowCapitaltypeid()"></button> 
						 <span id=capitaltypeidspan><%=Util.toScreen(CapitalTypeComInfo.getCapitalTypename(capitaltypeid),user.getLanguage())%></span> 
					   	 <input type=hidden name=capitaltypeid value="<%=capitaltypeid%>">
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>

					<!-- �������� -->
					<%if((mouldid==0||!(sptcount.equals("")))&&fieldname.equals("sptcount")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1363,user.getLanguage())%></td>
					  <td class=Field>
					  	<input type=checkbox name=sptcount value="1" <%if(sptcount.equals("1")){%>checked<%}%>>
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>

				<!-- ��ع����� -->
					<%if((mouldid==0||!(relatewfid.equals("")))&&fieldname.equals("relatewfid")){%>
				   <tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15295,user.getLanguage())%></td>
					  <td class=Field>
					  	  <button type=button  class=Browser onClick='onShowRequest("relatewfid","relatewfidspan")'></button>
						  <span id="relatewfidspan" name="relatewfidspan"></span>
						  <input type=hidden name="relatewfid" class=inputstyle>
					 </td>
				   </tr>
				   <TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
				   <%}%>					

				<!-- �ɹ�״̬ -->
				<%if((mouldid==0||!(purchasestate.equals("")))&&fieldname.equals("purchasestate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(22333,user.getLanguage())%></td>
					  <td class=Field> 
							<SELECT name="purchasestate">
								<OPTION value="0" <%if(purchasestate.equals("0")){%>selected<%}%>></OPTION>
								<OPTION value="1" <%if(purchasestate.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22334,user.getLanguage())%></OPTION>
								<OPTION value="2" <%if(purchasestate.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22335,user.getLanguage())%></OPTION>
								<OPTION value="3" <%if(purchasestate.equals("3")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22336,user.getLanguage())%></OPTION>
								<OPTION value="4" <%if(purchasestate.equals("4")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(22337,user.getLanguage())%></OPTION>
							</SELECT>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					
				<!-- ���ڻ����� -->
				<%if((mouldid==0||!(isinner.equals("0")))&&fieldname.equals("isinner")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15297,user.getLanguage())%></td>
					  <td class=Field> 
						<select class=InputStyle id=isinner name=isinner>
						<option value=0 <% if(isinner.equals("")) {%>selected<%}%>></option>
						  <option value=1 <% if(isinner.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15298,user.getLanguage())%></option>
						  <option value=2 <% if(isinner.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15299,user.getLanguage())%></option>
						</select>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

					<!-- ��Ч�� -->
					<%if((mouldid==0||!(startdate.equals(""))||!(startdate1.equals("")))&&fieldname.equals("startdate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></td>
					  <td class=Field>
					  	<button type=button  class=Calendar id=selectstartdate onClick="getDate(startdatespan,startdate)"></button> 
						<span id=startdatespan ><%=startdate%></span> 
						<input type="hidden" name="startdate" value="<%=startdate%>">
					   -<button type=button  class=Calendar id=selectstartdate1 onClick="getDate(startdate1span,startdate1)"></button> 
						<span id=startdate1span ><%=startdate1%></span> 
						<input type="hidden" name="startdate1" value="<%=startdate1%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ч�� -->
					<%if((mouldid==0||!(enddate.equals(""))||!(enddate1.equals("")))&&fieldname.equals("enddate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectenddate onClick="getDate(enddatespan,enddate)"></button> 
						<span id=enddatespan ><%=enddate%></span> 
						<input type="hidden" name="enddate" value="<%=enddate%>">
						-<button type=button  class=Calendar id=selectenddate1 onClick="getDate(enddate1span,enddate1)"></button> 
						<span id=enddate1span ><%=enddate1%></span> 
						<input type="hidden" name="enddate1" value="<%=enddate1%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					</TR>
					<%}%>
                    
                    <!-- ʹ�÷ֲ�
					<%if(mouldid==0&&fieldname.equals("departmentid")){%>
                    <tr> 
                      <td><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></td>
                      <td class=Field><button type=button  class=Browser id=SelectSubCompanyID onClick="onShowSubcompany('subcompanyidspan','subcompanyid')"></button> 
                        <span id="subcompanyidspan"></span> 
                        <input id=subcompanyid type=hidden name=subcompanyid>
                      </td>
                    </tr>
					<TR> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    -->
                    
                    <!-- ʹ�ò���-->
					<%if((mouldid==0||!(departmentid.equals("0")))&&fieldname.equals("departmentid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(21030,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectDeparment onClick="onShowDepartment('departmentid', 'departmentspan')"></button> 
						<span class=InputStyle id=departmentspan><%=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid),user.getLanguage())%></span> 
						<input id=departmentid type=hidden name=departmentid value="<%=departmentid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!-- �����ֲ�-->
					<%if((mouldid==0||!(blongsubcompany.equals("0")||blongsubcompany.equals("")))&&fieldname.equals("blongsubcompany")){%>
                    <tr> 
                      <td><%=SystemEnv.getHtmlLabelName(19799,user.getLanguage())%></td>
                      <td class=Field><button type=button  class=Browser id=SelectSubCompanyID onClick="onShowSubcompany('blongsubcompanyspan','blongsubcompany')"></button> 
                        <span id="blongsubcompanyspan"></span> 
                        <input id=blongsubcompany type=hidden name=blongsubcompany>
                      </td>
                    </tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    
                    <!-- ��������-->
					<%if((mouldid==0||!(blongdepartment.equals("0")||blongdepartment.equals("")))&&fieldname.equals("blongdepartment")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(15393,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectDeparment onClick="onShowDepartment('blongdepartment', 'blongdepartmentspan')"></button> 
						<span class=InputStyle id=blongdepartmentspan><%=Util.toScreen(DepartmentComInfo.getDepartmentname(blongdepartment),user.getLanguage())%></span> 
						<input id=blongdepartment type=hidden name=blongdepartment value="<%=blongdepartment%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
										 
					 <!-- ������Դ/ʹ����/����Ա -->
					 <%if((mouldid==0||!(resourceid.equals("0")))&&fieldname.equals("resourceid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1508,user.getLanguage())%>/<%=SystemEnv.getHtmlLabelName(1507,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Browser id=SelectResourceID onClick="onShowResourceID()"></button> 
						<span id=resourceidspan><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></span> 
						<input class=InputStyle id=resourceid type=hidden name=resourceid value="<%=resourceid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					 <%}%>
            
						<!-- ������λ -->
						<%if((mouldid==0||!(stateid.equals("0")))&&fieldname.equals("unitid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowLgcAssetUnit('unitid', 'unitidspan')"></button> 
						<span id=unitidspan><%=Util.toScreen(AssetUnitComInfo.getAssetUnitname(unitid),user.getLanguage())%></span> 
						<input type=hidden name=unitid value="<%=unitid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���� -->
					<%if((mouldid==0||!(capitalnum.equals(""))||!(capitalnum1.equals("")))&&fieldname.equals("capitalnum")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1331,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=10 size=10 value="<%=capitalnum%>" name="capitalnum" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("capitalnum")'>
					   -<input class=InputStyle maxlength=10 size=10 value="<%=capitalnum1%>" name="capitalnum1" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("capitalnum1")'>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��ǰ���� -->
					<%if((mouldid==0||!(currentnum.equals(""))||!(currentnum1.equals("")))&&fieldname.equals("currentnum")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1451,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=10 size=10 value="<%=currentnum%>" name="currentnum" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("currentnum")'>
					   -<input class=InputStyle maxlength=10 size=10 value="<%=currentnum1%>" name="currentnum1" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("currentnum1")'>
				</td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

					<!-- ����ͺ� -->
					<%if((mouldid==0||!(capitalspec.equals("")))&&fieldname.equals("capitalspec")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(904,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=60 size=30 value="<%=capitalspec%>" name="capitalspec">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �ȼ� -->
					<%if((mouldid==0||!(capitallevel.equals("")))&&fieldname.equals("capitallevel")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(603,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=30 size=30 value="<%=capitallevel%>" name="capitallevel">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���쳧�� -->
					<%if((mouldid==0||!(manufacturer.equals("")))&&fieldname.equals("manufacturer")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1364,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=100 size=30 value="<%=manufacturer%>" name="manufacturer">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �������� -->
					<%if((mouldid==0||!(manudate.equals(""))||!(manudate1.equals("")))&&fieldname.equals("manudate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1365,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectmanudate onClick="getDate(manudatespan,manudate)"></button> 
						<span id=manudatespan ><%=manudate%></span> 
						<input type="hidden" name="manudate" value="<%=manudate%>" >
					  -<button type=button  class=Calendar id=selectmanudate1 onClick="getDate(manudate1span,manudate1)"></button> 
						<span id=manudate1span ><%=manudate1%></span> 
						<input type="hidden" name="manudate1" value="<%=manudate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ӧ�� -->
					<%if((mouldid==0||!(customerid.equals("0")))&&fieldname.equals("customerid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(138,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowCustomerid()"></button> 
						<span id=customeridspan><%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(customerid),user.getLanguage())%></span> 
						<input type=hidden name=customerid value="<%=customerid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ���� -->
					<%if((mouldid==0||!(attribute.equals("")))&&fieldname.equals("attribute")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(713,user.getLanguage())%></td>
					  <td class=Field> 
						<select class=InputStyle id=attribute name=attribute>
						  <option></option>
						  <option value=0 <% if(attribute.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1366,user.getLanguage())%></option>
						  <option value=1 <% if(attribute.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1367,user.getLanguage())%></option>
						  <option value=2 <% if(attribute.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1368,user.getLanguage())%></option>
						  <option value=3 <% if(attribute.equals("3")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1369,user.getLanguage())%></option>
						  <option value=4 <% if(attribute.equals("4")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(60,user.getLanguage())%></option>
						  <option value=5 <% if(attribute.equals("5")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1370,user.getLanguage())%></option>
						  <option value=6 <% if(attribute.equals("6")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(811,user.getLanguage())%></option>
						</select>
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ״̬ -->
					<%if((mouldid==0||!(stateid.equals("0")))&&fieldname.equals("stateid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowStateid()"></button> 
						<span id=stateidspan><%=Util.toScreen(CapitalStateComInfo.getCapitalStatename(stateid),user.getLanguage())%></span> 
						<input type=hidden name=stateid value="<%=stateid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!--�������-->
					<%if((mouldid==0 || !(stockindate.equals("")) || !(stockindate1.equals("")))&&fieldname.equals("StockInDate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(753,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectstockindate onClick="getDate(stockindatespan,stockindate)"></button> 
						<span id=stockindatespan ><%=stockindate%></span> 
						<input type="hidden" name="stockindate" value="<%=stockindate%>" >
					  -<button type=button  class=Calendar id=selectstockindate1 onClick="getDate(stockindate1span,stockindate1)"></button> 
						<span id=stockindate1span ><%=stockindate1%></span> 
						<input type="hidden" name="stockindate1" value="<%=stockindate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>

                    <!--��������-->
					<%if((mouldid==0 || !(SelectDate.equals("")) || !(SelectDate1.equals("")))&&fieldname.equals("SelectDate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(16914,user.getLanguage())%></td>
					  <td class=Field>
					    <button type=button  class=Calendar id=bSelectDate onClick="getDate(SelectDatespan,SelectDate)"></button> 
						<span id=SelectDatespan ><%=SelectDate%></span> 
						<input type="hidden" name="SelectDate" value="<%=SelectDate%>" >
					  
					   -<button type=button  class=Calendar id=bSelectDate1 onClick="getDate(SelectDate1span,SelectDate1)"></button> 
						<span id=SelectDate1span ><%=SelectDate1%></span> 
						<input type="hidden" name="SelectDate1" value="<%=SelectDate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��� -->
					<%if((mouldid==0||!(replacecapitalid.equals("0")))&&fieldname.equals("replacecapitalid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1371,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowReplacecapitalid()"></button> 
						<span id=replacecapitalidspan><%=Util.toScreen(CapitalComInfo.getCapitalname(replacecapitalid),user.getLanguage())%></span> 
						<input type=hidden name=replacecapitalid value="<%=replacecapitalid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- ��Ʒ -->
					<%if((mouldid==0||!(itemid.equals("0")))&&fieldname.equals("itemid")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(145,user.getLanguage())%></td>
					  <td class=Field> <button type=button  class=Browser onClick="onShowLgcAsset('itemid', 'itemidspan')"></button> 
						<span id=itemidspan><%=Util.toScreen(AssetComInfo.getAssetName(itemid),user.getLanguage())%></span> 
						<input type=hidden name=itemid value="<%=itemid%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
						<%}%>
					
					<!-- ��ŵص� -->
					<%if((mouldid==0||!(location.equals("")))&&fieldname.equals("location")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1387,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=100 size=30 name=location value="<%=location%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
					
					<!-- �汾 -->
					<%if((mouldid==0||!(version.equals("")))&&fieldname.equals("version")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%></td>
					  <td class=Field> 
						<input class=InputStyle maxlength=60 size=30 name=version value="<%=version%>">
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>
                    
                    <!--��������-->
					<%if((mouldid==0||!(deprestartdate.equals(""))||!(deprestartdate1.equals("")))&&fieldname.equals("deprestartdate")){%>
					<tr> 
					  <td><%=SystemEnv.getHtmlLabelName(1412,user.getLanguage())%></td>
					  <td class=Field><button type=button  class=Calendar id=selectdeprestartdate onClick="getDate(deprestartdatespan,deprestartdate)"></button> 
						<span id=deprestartdatespan ><%=deprestartdate%></span> 
						<input type="hidden" name="deprestartdate" value="<%=deprestartdate%>" >
					  -<button type=button  class=Calendar id=selectdeprestartdate1 onClick="getDate(deprestartdate1span,deprestartdate1)"></button> 
						<span id=deprestartdate1span ><%=deprestartdate1%></span> 
						<input type="hidden" name="deprestartdate1" value="<%=deprestartdate1%>" >
					  </td>
					</tr>
					<TR style="height:1px;"> 
						<TD class=Line colSpan=2></TD>
					  </TR>
					<%}%>


					<%
					
					RecordSet.executeProc("Base_FreeField_Select","cp");
					boolean hasFF = true;
					if(RecordSet.getCounts()<=0)
						hasFF = false;
					else
						RecordSet.first();
					
					if(hasFF)
					{
						for(int i=1;i<=5;i++)
						{//����
							if(RecordSet.getString(i*2+1).equals("1")&&fieldname.equals("datefield"+i))
							{
							if(mouldid>0&&datafields[2*i-2].equals("")&&datafields[2*i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2)%></td>
								<td class=Field>
									<button type=button  class=Calendar id="selectdatafield<%=i%>" onClick="getDate(datafield<%=i%>span,datafield<%=i%>)"></button> 
									<span id="datafield<%=i%>span"><%=datafields[2*i-2]%></span> 
									<input type="hidden" name="datafield<%=i%>" value="<%=datafields[2*i-2]%>">
								   -<button type=button  class=Calendar id="selectdatafield<%=i%>1" onClick="getDate(datafield<%=i%>1span,datafield<%=i%>1)"></button> 
									<span id="datafield<%=i%>1span" ><%=datafields[2*i-1]%></span> 
									<input type="hidden" name="datafield<%=i%>1" value="<%=datafields[2*i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//����
							if(RecordSet.getString(i*2+11).equals("1")&&fieldname.equals("numberfield"+i))
							{
							if(mouldid>0&&numberfield[2*i-2].equals("")&&numberfield[2*i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+10)%></td>
								<td class=Field> 
								  <input class=InputStyle maxlength=16 size=10 value="<%=numberfield[2*i-2]%>" name="numberfield<%=i%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("numberfield<%=i%>")'>
					             -<input class=InputStyle maxlength=16 size=10 value="<%=numberfield[2*i-1]%>" name="numberfield<%=i%>1" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("numberfield<%=i%>1")'>
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>			
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//�ı�
							if(RecordSet.getString(i*2+21).equals("1")&&fieldname.equals("textfield"+i))
							{
							if(mouldid>0&&textfield[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+20)%></td>
								<td class=Field> 
								  <input class=InputStyle maxlength=100 size=30 name="textfield<%=i%>" value="<%=textfield[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//checkbox
							if(RecordSet.getString(i*2+31).equals("1")&&fieldname.equals("tinyintfield"+i))
							{
							if(mouldid>0&&tinyintfield[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+30)%></td>
								<td class=Field> 
								  <input type=checkbox  name="tinyintfield<%=i%>" value="1" <%if(tinyintfield[i-1].equals("1")){%>checked<%}%>>
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//���ĵ�
							if(RecordSet.getString(i*2+41).equals("1")&&fieldname.equals("docff0"+i+"name"))
							{
							if(mouldid>0&&docffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+40)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowMDocid("docff0<%=i%>name","docff0<%=i%>namespan")'></button>
								  <span name="docff0<%=i%>namespan" id="docff0<%=i%>namespan">
									<%
									  	String tempdoc[] = Util.TokenizerString2(docffs[i-1],",");
									  	if(tempdoc!=null){
									  		for(int j=0;j<tempdoc.length;j++)
									  		out.println("<a href=javascript:openFullWindowForXtable('/docs/docs/DocDsp.jsp?id="+tempdoc[j]+"')>"+DocComInfo.getDocname(tempdoc[j])+"</a> ");
									  	}
								   %>
								  </span>
								  <input type=hidden name="docff0<%=i%>name" class=inputstyle value="<%=docffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//�ಿ��
							if(RecordSet.getString(i*2+51).equals("1")&&fieldname.equals("depff0"+i+"name"))
							{
							if(mouldid>0&&depffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+50)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowDepartmentMutil("depff0<%=i%>namespan","depff0<%=i%>name")'></button>
								  <SPAN id="depff0<%=i%>namespan" name="depff0<%=i%>namespan">
								  <%
								  	String tempdep[] = Util.TokenizerString2(depffs[i-1],",");
								  	if(tempdep!=null){
								  		for(int j=0;j<tempdep.length;j++)
								  		out.println(DepartmentComInfo.getDepartmentname(tempdep[j])+" ");
								  	}
								  %>
								  </SPAN>
								  <input type=hidden name="depff0<%=i%>name" class=inputstyle value="<%=depffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//��ͻ�
							if(RecordSet.getString(i*2+61).equals("1")&&fieldname.equals("crmff0"+i+"name"))
							{
							if(mouldid>0&&crmffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+60)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowCRM("crmff0<%=i%>name","crmff0<%=i%>namespan")'></button>
								  <span id="crmff0<%=i%>namespan" name="crmff0<%=i%>namespan">
								  <%
								  	String tempcrm[] = Util.TokenizerString2(crmffs[i-1],",");
								  	if(tempcrm!=null){
								  		for(int j=0;j<tempcrm.length;j++)
								  		out.println("<a href=javascript:openFullWindowForXtable('/CRM/data/ViewCustomer.jsp?CustomerID="+tempcrm[j]+"')>"+CustomerInfoComInfo.getCustomerInfoname(tempcrm[j])+"</a> ");
								  	}
								  %>								  
								  </span>
								  <input type=hidden name="crmff0<%=i%>name" class=inputstyle value="<%=crmffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
						for(int i=1;i<=5;i++)
						{//������
							if(RecordSet.getString(i*2+71).equals("1")&&fieldname.equals("reqffo"+i+"name"))
							{
							if(mouldid>0&&reqffs[i-1].equals("")) continue;
							%>
							  <tr> 
								<td><%=RecordSet.getString(i*2+70)%></td>
								<td class=Field> 
								  <button type=button  class=Browser onClick='onShowRequest("reqff0<%=i%>name","reqff0<%=i%>namespan")'></button>
								  <span id="reqff0<%=i%>namespan" name="reqff0<%=i%>namespan">
								  <%
								  	String tempreq[] = Util.TokenizerString2(reqffs[i-1],",");
								  	if(tempreq!=null){
								  		for(int j=0;j<tempreq.length;j++)
								  		out.println("<a href=javascript:openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid="+tempreq[j]+"')>"+WorkflowRequestComInfo.getRequestName(tempreq[j])+"</a> ");
								  	}	
								  %>								  
								  </span>
								  <input type=hidden name="reqff0<%=i%>name" class=inputstyle value="<%=reqffs[i-1]%>">
								</td>
							  </tr>
								<TR style="height:1px;"> 
								<TD class=Line colSpan=2></TD>
							  </TR>
							  <%}
						}
					}
			%>


			<%}%>	









					</TBODY> 
				  </TABLE>
				</TD></TR>
							 <%}//end of advanced judgement%>
				</TBODY></TABLE><!-- Columns --></TD>
			<TD style="BACKGROUND-COLOR: rgb(216,236,239)" vAlign=top width="16%">
			<TABLE class=ListShort>
			<TBODY>
			<TR>
			  <TH><%=SystemEnv.getHtmlLabelName(64,user.getLanguage())%></TH></TR>
			 <TR class=DataLight>
			  <TD><a href="CptSearch.jsp?mouldid=0"><%=SystemEnv.getHtmlLabelName(149,user.getLanguage())%></a></TD></TR>
			<% 
			int i=0;
			userid =user.getUID();
			RecordSet.executeProc("CptSearchMould_SelectByUserID",""+userid);
			while(RecordSet.next()){
			String tempid = RecordSet.getString("id");
			String tempmouldname = RecordSet.getString("mouldname");
				if(i==0){%><TR class=DataDark><%i=1;}
				else{%><TR class=DataLight><%i=0;}%>
			  <td><a href="CptSearch.jsp?mouldid=<%=tempid%>&advanced=1"><%=Util.toScreen(tempmouldname,user.getLanguage())%></a></td>
			</TR>
			<%}
			if(mouldid==0){%>
			<TR>
			  <TD><INPUT type="text" name="newmould"  size=15 onChange="checkinput('newmould','newmouldspan')" class="InputStyle">
			  <span id=newmouldspan><IMG src="/images/BacoError.gif" align=absMiddle></span></TD>
			</TR>
			<%}%>  
			</TBODY>
			</TABLE>
			</TD></TR>
			</TBODY>
			</TABLE>
			</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

<SCRIPT language=javascript>
function onSearch(){
	document.frmain.action="SearchOperation.jsp";
	frmain.submit();
}
function onAdvanced(){
	if(document.frmain.advanced.value=='1'){
		document.frmain.advanced.value='0';
		frmain.submit();
	}
	else {
		document.frmain.advanced.value='1';
		frmain.submit();
	}
}
function onSaveas(){
	if(check_form(document.frmain,'newmould')){
	document.frmain.operation.value="add";
	document.frmain.action="SearchMouldOperation.jsp";
	document.frmain.submit();
	}
}        
function onSave(){
	document.frmain.operation.value="edit";
	document.frmain.action="SearchMouldOperation.jsp";
	document.frmain.submit();
}
function onDelete(){
	if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")){
	document.frmain.operation.value="delete";
	document.frmain.action="SearchMouldOperation.jsp";
	document.frmain.submit();
	}
}

function onShowDepartmentMutil(spanname, inputname) {
    
    url=escape("/hrm/company/MutiDepartmentBrowser.jsp?selectedids="+ $GetEle(inputname).value);
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
    try {
        jsid = new VBArray(id).toArray();
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0" && jsid[1]!="") {
             $GetEle(spanname).innerHTML = jsid[1].substring(1);
             $GetEle(inputname).value = jsid[0].substring(1);
        }else {
             $GetEle(spanname).innerHTML = "";
             $GetEle(inputname).value = "";
        }
    }
}

</SCRIPT>
<SCRIPT language="javascript" src="/js/browser/LgcAssetBrowser.js"></SCRIPT>

<script type="text/javascript">

function onShowCRM(inputname, spanname) {
	var temp = $GetEle(inputname).value;
	id1 = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids="
							+ temp, "", "dialogWidth:550px;dialogHeight:550px;");
	if (id1 != null) {
		if (wuiUtil.getJsonValueByIndex(id1, 0).length() > 500) { // '500Ϊ��ṹ��ؿͻ��ֶεĳ���
			alert("��ѡ�����ؿͻ�����̫�࣬���ݿ⽫�޷��������е���ؿͻ���������ѡ��");
			$GetEle(spanname).innerHTML = "";
			$GetEle(inputname).value = "";
		} else if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
			var resourceids = wuiUtil.getJsonValueByIndex(id1, 0).substr(1);
			var resourcename = wuiUtil.getJsonValueByIndex(id1, 1).substr(1);
			var sHtml = "";

			$GetEle(inputname).value = resourceids;

			var resourceidArray = resourceids.split(",");
			var resourcenameArray = resourcename.split(",");

			for ( var _i = 0; _i < resourceidArray.length; _i++) {
				var curid = resourceidArray[_i];
				var curname = resourcenameArray[_i];

				sHtml = sHtml
						+ "<a href=javascript:openFullWindowForXtable('/CRM/data/ViewCustomer.jsp?CustomerID="
						+ curid + "')>" + curname + "</a>&nbsp";
			}

			$GetEle(spanname).innerHTML = sHtml;
		} else {
			$GetEle(spanname).innerHTML = "";
			$GetEle(inputname).value = "";
		}
	}
}

function onShowRequest(inputname, spanname) {
	var temp = $GetEle(inputname).value;
	id1 = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/workflow/request/MultiRequestBrowser.jsp?resourceids="
							+ temp, "", "dialogWidth:550px;dialogHeight:550px;");
	if (id1 != null) {
		if (wuiUtil.getJsonValueByIndex(id1, 0).length() > 500) { // '500Ϊ��ṹ��������ֶεĳ���
			alert("��ѡ��������������̫�࣬���ݿ⽫�޷��������е�������̣�������ѡ��");
			$GetEle(spanname).innerHTML = "";
			$GetEle(inputname).value = "";
		} else if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
			var resourceids = wuiUtil.getJsonValueByIndex(id1, 0).substr(1);
			var resourcename = wuiUtil.getJsonValueByIndex(id1, 1).substr(1);
			var sHtml = "";

			$GetEle(inputname).value = resourceids;

			var resourceidArray = resourceids.split(",");
			var resourcenameArray = resourcename.split(",");

			for ( var _i = 0; _i < resourceidArray.length; _i++) {
				var curid = resourceidArray[_i];
				var curname = resourcenameArray[_i];

				sHtml = sHtml
						+ "<a href=javascript:openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid="
						+ curid + "')>" + curname + "</a>&nbsp";
			}

			$GetEle(spanname).innerHTML = sHtml;
		} else {
			$GetEle(spanname).innerHTML = "";
			$GetEle(inputname).value = "";
		}
	}
}

function onShowMDocid(inputename, spanname) {
	var tmpids = $GetEle(inputename).value;
	var id1 = window.showModalDialog(
			"/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?documentids="
					+ tmpids, "", "dialogWidth:550px;dialogHeight:550px;");
	if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
		var DocIds = wuiUtil.getJsonValueByIndex(id1, 0).substr(1);
		var DocName = wuiUtil.getJsonValueByIndex(id1, 1).substr(1);
		var sHtml = "";

		$GetEle(inputename).value = DocIds;

		var docIdArray = DocIds.split(",");
		var DocNameArray = DocName.split(",");

		for ( var _i = 0; _i < docIdArray.length; _i++) {
			var curid = docIdArray[_i];
			var curname = DocNameArray[_i];

			sHtml = sHtml + "<a href=/docs/docs/DocDsp.jsp?id=" + curid + ">"
					+ curname + "</a>&nbsp";
		}

		$GetEle(spanname).innerHTML = sHtml;

	} else {
		$GetEle(spanname).innerHTML = "";
		$GetEle(inputename).value = "";
	}
}

function onShowCostCenter() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/hrm/company/CostcenterBrowser.jsp?sqlwhere= where departmentid="
							+ frmain.departmentid.value, "",
					"dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != 0) {
			$GetEle("costcenterspan").innerHTML = wuiUtil.getJsonValueByIndex(
					id, 1);
			$GetEle("costcenterid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("costcenterspan").innerHTML = "";
			$GetEle("costcenterid").value = "";
		}
	}
}

function onShowResourceID() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("resourceidspan").innerHTML = "<A href='/hrm/resource/HrmResource.jsp?id="
					+ wuiUtil.getJsonValueByIndex(id, 0)
					+ "'>"
					+ wuiUtil.getJsonValueByIndex(id, 1) + "</A>";
			$GetEle("resourceid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("resourceidspan").innerHTML = "";
			$GetEle("resourceid").value = "";
		}
	}
}

function onShowCurrencyID() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("currencyidspan").innerHTML = wuiUtil.getJsonValueByIndex(
					id, 1);
			$GetEle("currencyid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("currencyidspan").innerHTML = "";
			$GetEle("currencyid").value = "";
		}
	}
}

function onShowDepremethod1() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/DepremethodBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 1) != "") {
			$GetEle("depremethod1span").innerHTML = wuiUtil
					.getJsonValueByIndex(id, 1);
			$GetEle("depremethod1").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("depremethod1span").innerHTML = "";
			$GetEle("depremethod1").value = "";
		}
	}
}

function onShowDepremethod2() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/DepremethodBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("depremethod2span").innerHTML = wuiUtil
					.getJsonValueByIndex(id, 1);
			$GetEle("depremethod2").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("depremethod2span").innerHTML = "";
			$GetEle("depremethod2").value = "";
		}
	}
}

function onShowCapitaltypeid() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/CapitalTypeBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("capitaltypeidspan").innerHTML = wuiUtil
					.getJsonValueByIndex(id, 1);
			$GetEle("capitaltypeid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("capitaltypeidspan").innerHTML = "";
			$GetEle("capitaltypeid").value = "";
		}
	}
}

function onShowCapitalgroupid() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/CptAssortmentBrowser.jsp",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("capitalgroupidspan").innerHTML = wuiUtil
					.getJsonValueByIndex(id, 1);
			$GetEle("capitalgroupid").value = wuiUtil
					.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("capitalgroupidspan").innerHTML = "";
			$GetEle("capitalgroupid").value = "";
		}
	}
}

function onShowCustomerid() {
	var id = window.showModalDialog(
			"/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp",
			"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("customeridspan").innerHTML = wuiUtil.getJsonValueByIndex(
					id, 1);
			$GetEle("customerid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("customeridspan").innerHTML = "";
			$GetEle("customerid").value = "";
		}
	}
}

function onShowStateid() {
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/CapitalStateBrowser.jsp?from=search",
					"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 1) != "") {
			$GetEle("Stateidspan").innerHTML = wuiUtil.getJsonValueByIndex(id,
					1);
			$GetEle("Stateid").value = wuiUtil.getJsonValueByIndex(id, 0);
		} else {
			$GetEle("Stateidspan").innerHTML = "";
			$GetEle("Stateid").value = "";
		}
	}
}

function onShowReplacecapitalid() {
	var id = window.showModalDialog(
			"/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp",
			"", "dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			$GetEle("replacecapitalidspan").innerHTML = wuiUtil
					.getJsonValueByIndex(id, 1);
			$GetEle("replacecapitalid").value = wuiUtil.getJsonValueByIndex(id,
					0);
		} else {
			$GetEle("replacecapitalidspan").innerHTML = "";
			$GetEle("replacecapitalid").value = "";
		}
	}
}

function onShowSubcompany(tdname, inputename) {
	var linkurl = "/hrm/company/HrmSubCompanyDsp.jsp?id=";
	var id = window
			.showModalDialog(
					"/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="
							+ $GetEle(inputename).value, "",
					"dialogWidth:550px;dialogHeight:550px;");
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			var resourceids = wuiUtil.getJsonValueByIndex(id, 0).substr(1);
			var resourcename = wuiUtil.getJsonValueByIndex(id, 1).substr(1);
			var sHtml = "";

			$GetEle(inputename).value = resourceids;

			var resourceidArray = resourceids.split(",");
			var resourcenameArray = resourcename.split(",");

			for ( var _i = 0; _i < resourceidArray.length; _i++) {
				var curid = resourceidArray[_i];
				var curname = resourcenameArray[_i];

				sHtml = sHtml + "<a href=" + linkurl + curid + ">" + curname
						+ "</a>&nbsp";
			}

			$GetEle(tdname).innerHTML = sHtml;

		} else {
			$GetEle(tdname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			$GetEle(inputename).value = "";
		}
	}
}

</script>

<SCRIPT language="javascript" src="/js/browser/DepartmentBrowser.js"></SCRIPT>
<SCRIPT language="javascript" src="/js/browser/LgcAssetUnitBrowser.js"></SCRIPT>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
