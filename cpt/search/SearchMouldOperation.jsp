<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.null2String(request.getParameter("operation"));
char separator = Util.getSeparator() ;

String mouldid = Util.fromScreen(request.getParameter("mouldid"),user.getLanguage());
String mouldname = Util.fromScreen(request.getParameter("newmould"),user.getLanguage()) ;				/*���*/
String userid = ""+user.getUID();

String mark = Util.fromScreen(request.getParameter("mark"),user.getLanguage()) ;				/*���*/
String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());			/*����*/
String startdate = Util.fromScreen(request.getParameter("startdate"),user.getLanguage());			/*��Ч��*/
String startdate1 = Util.fromScreen(request.getParameter("startdate1"),user.getLanguage());			/*��Ч��*/
String enddate= Util.fromScreen(request.getParameter("enddate"),user.getLanguage());				/*��Ч��*/
String enddate1= Util.fromScreen(request.getParameter("enddate1"),user.getLanguage());				/*��Ч��*/
String seclevel= Util.fromScreen(request.getParameter("seclevel"),user.getLanguage());				/*��ȫ����*/
String seclevel1= Util.fromScreen(request.getParameter("seclevel1"),user.getLanguage());				/*��ȫ����*/
String departmentid = Util.fromScreen(request.getParameter("departmentid"),user.getLanguage());/*����*/
String costcenterid = Util.fromScreen(request.getParameter("costcenterid"),user.getLanguage());			/*�ɱ�����*/
String resourceid = Util.fromScreen(request.getParameter("resourceid"),user.getLanguage());		/*������Դ*/
String currencyid = Util.fromScreen(request.getParameter("currencyid"),user.getLanguage());	/*����*/
String capitalcost = Util.fromScreen(request.getParameter("capitalcost"),user.getLanguage());	/*�ɱ�*/
String capitalcost1 = Util.fromScreen(request.getParameter("capitalcost1"),user.getLanguage());	/*�ɱ�*/
String startprice = Util.fromScreen(request.getParameter("startprice"),user.getLanguage());	/*��ʼ�۸�*/
String startprice1 = Util.fromScreen(request.getParameter("startprice1"),user.getLanguage());	/*��ʼ�۸�*/
String depreendprice = Util.fromScreen(request.getParameter("depreendprice"),user.getLanguage()); /*�۾ɵ׼�(��)*/
String depreendprice1 = Util.fromScreen(request.getParameter("depreendprice1"),user.getLanguage()); /*�۾ɵ׼�(��)*/
String capitalspec = Util.fromScreen(request.getParameter("capitalspec"),user.getLanguage());			/*����ͺ�(��)*/
String capitallevel = Util.fromScreen(request.getParameter("capitallevel"),user.getLanguage());	/*�ʲ��ȼ�(��)*/
String manufacturer = Util.fromScreen(request.getParameter("manufacturer"),user.getLanguage());			/*���쳧��(��)*/
String manudate	= Util.fromScreen(request.getParameter("manudate"),user.getLanguage());			/*��������(��)*/
String manudate1	= Util.fromScreen(request.getParameter("manudate1"),user.getLanguage());			/*��������(��)*/
String capitaltypeid = Util.fromScreen(request.getParameter("capitaltypeid"),user.getLanguage());			/*�ʲ�����*/
String capitalgroupid = Util.fromScreen(request.getParameter("capitalgroupid"),user.getLanguage());			/*�ʲ���*/
String unitid = Util.fromScreen(request.getParameter("unitid"),user.getLanguage());				/*������λ*/
String capitalnum = Util.fromScreen(request.getParameter("capitalnum"),user.getLanguage());			/*����*/
String capitalnum1 = Util.fromScreen(request.getParameter("capitalnum1"),user.getLanguage());			/*����*/
String currentnum = Util.fromScreen(request.getParameter("currentnum"),user.getLanguage());			/*��ǰ����*/
String currentnum1 = Util.fromScreen(request.getParameter("currentnum1"),user.getLanguage());			/*��ǰ����*/
String replacecapitalid =Util.fromScreen(request.getParameter("replacecapitalid"),user.getLanguage());				/*���*/
String version =Util.fromScreen(request.getParameter("version"),user.getLanguage()) ;			/*�汾*/
String itemid =Util.fromScreen(request.getParameter("itemid"),user.getLanguage());			/*��Ʒ*/
String depremethod1 =Util.fromScreen(request.getParameter("depremethod1"),user.getLanguage());			/*�۾ɷ�һ*/
String depremethod2 =Util.fromScreen(request.getParameter("depremethod2"),user.getLanguage());			/*�۾ɷ���*/
String deprestartdate =Util.fromScreen(request.getParameter("deprestartdate"),user.getLanguage());		/*�۾ɿ�ʼ����*/
String deprestartdate1 =Util.fromScreen(request.getParameter("deprestartdate1"),user.getLanguage());		/*�۾ɿ�ʼ����*/
String depreenddate = Util.fromScreen(request.getParameter("depreenddate"),user.getLanguage()) ;			/*�۾ɽ�������*/
String depreenddate1 = Util.fromScreen(request.getParameter("depreenddate1"),user.getLanguage()) ;			/*�۾ɽ�������*/
String customerid=Util.fromScreen(request.getParameter("customerid"),user.getLanguage());			/*�ͻ�id*/
String attribute= Util.fromScreen(request.getParameter("attribute"),user.getLanguage());
String stateid = Util.fromScreen(request.getParameter("stateid"),user.getLanguage());	/*�ʲ�״̬*/
String location = Util.fromScreen(request.getParameter("location"),user.getLanguage()) ;			/*��ŵص�*/
String isdata = Util.fromScreen(request.getParameter("isdata"),user.getLanguage()) ;			/*�ʲ�������*/
String counttype = Util.fromScreen(request.getParameter("counttype"),user.getLanguage()) ;			/*���ʻ�ͺ�*/
String isinner = Util.fromScreen(request.getParameter("isinner"),user.getLanguage()) ;			/*���ڻ�����*/
String stockindate = Util.fromScreen(request.getParameter("stockindate"),user.getLanguage()) ;			/*������ڴ�*/
String stockindate1 = Util.fromScreen(request.getParameter("stockindate1"),user.getLanguage()) ;			/*������ڵ�*/

//�������ֶ�
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


if(operation.equals("add")){
     
  	String para = "";
	para  =mouldname;
	para +=separator+userid;
	para +=separator+mark;
	para +=separator+name;
	para +=separator+startdate;
	para +=separator+startdate1;
	para +=separator+enddate;
	para +=separator+enddate1;
	para +=separator+seclevel;
	para +=separator+seclevel1;
	para +=separator+departmentid;
	para +=separator+costcenterid;
	para +=separator+resourceid;
	para +=separator+currencyid;
	para +=separator+capitalcost;
	para +=separator+capitalcost1;
	para +=separator+startprice;
	para +=separator+startprice1;
	para +=separator+depreendprice;
	para +=separator+depreendprice1;
	para +=separator+capitalspec;
	para +=separator+capitallevel;
	para +=separator+manufacturer;
	para +=separator+manudate;
	para +=separator+manudate1;
	para +=separator+capitaltypeid;
	para +=separator+capitalgroupid;
	para +=separator+unitid;
	para +=separator+capitalnum;
	para +=separator+capitalnum1;
	para +=separator+currentnum;
	para +=separator+currentnum1;
	para +=separator+replacecapitalid;
	para +=separator+version;
	para +=separator+itemid;
	para +=separator+depremethod1;
	para +=separator+depremethod2;
	para +=separator+deprestartdate;
	para +=separator+deprestartdate1;
	para +=separator+depreenddate;
	para +=separator+depreenddate1;
	para +=separator+customerid;
	para +=separator+attribute;
	para +=separator+stateid;
	para +=separator+location;
	para +=separator+isdata;
	para +=separator+counttype;
	para +=separator+isinner;
    para +=separator+stockindate;
    para +=separator+stockindate1;
		
	RecordSet.executeProc("CptSearchMould_Insert",para);
	RecordSet.next() ;
	String tempmouldid = RecordSet.getString(1);

	String sql = "update CptSearchMould set fnamark = '"+ fnamark+"',barcode = '"+ barcode+"',blongdepartment = '"+ blongdepartment+"',sptcount = '"+ sptcount+"',relatewfid = '"+ relatewfid +"',SelectDate = '"+SelectDate +"',SelectDate1 = '"+SelectDate1 +"',contractno = '"+contractno +"',Invoice = '"+Invoice+"',depreyear = '"+depreyear +"',deprerate = '"+ deprerate +"',issupervision = '"+issupervision +"',amountpay = '"+ amountpay +"',amountpay1 = '"+ amountpay1 +"',depreyear1 = '"+ depreyear1 +"',deprerate1 = '"+ deprerate1 +"',purchasestate = '"+ purchasestate +"' where id = " + tempmouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set datafield1 = '"+ datafield1 +"',datafield11 = '"+ datafield11 +"',datafield2 = '"+ datafield2 +"',datafield22 = '"+datafield22 +"',datafield3 = '"+ datafield3 +"',datafield33 = '"+datafield33 +"',datafield4 = '"+ datafield4 +"',datafield44 = '"+ datafield44 +"',datafield5 = '"+ datafield5 +"',datafield55 = '"+ datafield55 + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set numberfield1 = '"+ numberfield1 +"',numberfield11 = '"+ numberfield11 +"',numberfield2 = '"+ numberfield2 +"',numberfield22 = '"+ numberfield22 +"',numberfield3 = '"+ numberfield3+"',numberfield33 = '"+numberfield33 +"', numberfield4 = '"+ numberfield4 +"',numberfield44 = '"+ numberfield44 +"',numberfield5 = '"+ numberfield5 +"',numberfield55 = '"+ numberfield55 +"' where id = " + tempmouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set textfield1 = '"+ textfield1 +"',textfield2 = '"+ textfield2 +"',textfield3 = '"+ textfield3 +"',textfield4 = '"+ textfield4 +"',textfield5 = '"+ textfield5 + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set tinyintfield1 = '"+ tinyintfield1 +"',tinyintfield2 = '"+ tinyintfield2 +"',tinyintfield3 = '"+tinyintfield3 +"',tinyintfield4 = '"+tinyintfield4 +"',tinyintfield5 = '"+ tinyintfield5 + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set docff01name = '"+ docff01name +"',docff02name = '"+ docff02name +"',docff03name = '"+ docff03name +"',docff04name = '"+ docff04name +"',docff05name = '"+ docff05name + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set depff01name = '"+ depff01name +"',depff02name = '"+ depff02name +"',depff03name = '"+ depff03name +"',depff04name = '"+ depff04name +"',depff05name = '"+ depff05name + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set crmff01name = '"+ crmff01name +"',crmff02name = '"+ crmff02name +"',crmff03name = '"+ crmff03name +"',crmff04name = '"+ crmff04name +"',crmff05name = '"+ crmff05name + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set reqff01name = '"+ reqff01name +"',reqff02name = '"+ reqff02name +"',reqff03name = '"+ reqff03name +"',reqff04name = '"+ reqff04name +"',reqff05name = '"+ reqff05name + "' where id = " + tempmouldid;
	RecordSet.executeSql(sql);	

	sql = "select * from CptSearchDefinition where mouldid = -1";
	RecordSet.executeSql(sql);
	while(RecordSet.next()){		
		sql = "insert into CptSearchDefinition (fieldname,isconditionstitle,istitle,isconditions,isseniorconditions,displayorder,mouldid) select fieldname,isconditionstitle,istitle,isconditions,isseniorconditions,displayorder,'"+tempmouldid+"' from CptSearchDefinition where id = " + RecordSet.getString("id");	
		rs.executeSql(sql);
	}


	response.sendRedirect("CptSearch.jsp?advanced=1&mouldid="+tempmouldid);
 }
else if(operation.equals("edit")){
  	String para = "";
	para  =mouldid;
	para +=separator+userid;
	para +=separator+mark;
	para +=separator+name;
	para +=separator+startdate;
	para +=separator+startdate1;
	para +=separator+enddate;
	para +=separator+enddate1;
	para +=separator+seclevel;
	para +=separator+seclevel1;
	para +=separator+departmentid;
	para +=separator+costcenterid;
	para +=separator+resourceid;
	para +=separator+currencyid;
	para +=separator+capitalcost;
	para +=separator+capitalcost1;
	para +=separator+startprice;
	para +=separator+startprice1;
	para +=separator+depreendprice;
	para +=separator+depreendprice1;
	para +=separator+capitalspec;
	para +=separator+capitallevel;
	para +=separator+manufacturer;
	para +=separator+manudate;
	para +=separator+manudate1;
	para +=separator+capitaltypeid;
	para +=separator+capitalgroupid;
	para +=separator+unitid;
	para +=separator+capitalnum;
	para +=separator+capitalnum1;
	para +=separator+currentnum;
	para +=separator+currentnum1;
	para +=separator+replacecapitalid;
	para +=separator+version;
	para +=separator+itemid;
	para +=separator+depremethod1;
	para +=separator+depremethod2;
	para +=separator+deprestartdate;
	para +=separator+deprestartdate1;
	para +=separator+depreenddate;
	para +=separator+depreenddate1;
	para +=separator+customerid;
	para +=separator+attribute;
	para +=separator+stateid;
	para +=separator+location;
	para +=separator+isdata;
	para +=separator+counttype;
	para +=separator+isinner;
    para +=separator+stockindate;
    para +=separator+stockindate1;
    
	out.print(para);
	RecordSet.executeProc("CptSearchMould_Update",para);

	String sql = "update CptSearchMould set fnamark = '"+ fnamark+"',barcode = '"+ barcode+"',blongdepartment = '"+ blongdepartment+"',sptcount = '"+ sptcount+"',relatewfid = '"+ relatewfid +"',SelectDate = '"+SelectDate +"',SelectDate1 = '"+SelectDate1 +"',contractno = '"+contractno +"',Invoice = '"+Invoice+"',depreyear = '"+depreyear +"',deprerate = '"+ deprerate +"',issupervision = '"+issupervision +"',amountpay = '"+ amountpay +"',amountpay1 = '"+ amountpay1 +"',depreyear1 = '"+ depreyear1 +"',deprerate1 = '"+ deprerate1 +"',purchasestate = '"+ purchasestate +"' where id = " + mouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set datafield1 = '"+ datafield1 +"',datafield11 = '"+ datafield11 +"',datafield2 = '"+ datafield2 +"',datafield22 = '"+datafield22 +"',datafield3 = '"+ datafield3 +"',datafield33 = '"+datafield33 +"',datafield4 = '"+ datafield4 +"',datafield44 = '"+ datafield44 +"',datafield5 = '"+ datafield5 +"',datafield55 = '"+ datafield55 + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set numberfield1 = '"+ numberfield1 +"',numberfield11 = '"+ numberfield11 +"',numberfield2 = '"+ numberfield2 +"',numberfield22 = '"+ numberfield22 +"',numberfield3 = '"+ numberfield3+"',numberfield33 = '"+numberfield33 +"', numberfield4 = '"+ numberfield4 +"',numberfield44 = '"+ numberfield44 +"',numberfield5 = '"+ numberfield5 +"',numberfield55 = '"+ numberfield55 +"' where id = " + mouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set textfield1 = '"+ textfield1 +"',textfield2 = '"+ textfield2 +"',textfield3 = '"+ textfield3 +"',textfield4 = '"+ textfield4 +"',textfield5 = '"+ textfield5 + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set tinyintfield1 = '"+ tinyintfield1 +"',tinyintfield2 = '"+ tinyintfield2 +"',tinyintfield3 = '"+tinyintfield3 +"',tinyintfield4 = '"+tinyintfield4 +"',tinyintfield5 = '"+ tinyintfield5 + "' where id = " + mouldid;
	RecordSet.executeSql(sql);
	sql = "update CptSearchMould set docff01name = '"+ docff01name +"',docff02name = '"+ docff02name +"',docff03name = '"+ docff03name +"',docff04name = '"+ docff04name +"',docff05name = '"+ docff05name + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set depff01name = '"+ depff01name +"',depff02name = '"+ depff02name +"',depff03name = '"+ depff03name +"',depff04name = '"+ depff04name +"',depff05name = '"+ depff05name + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set crmff01name = '"+ crmff01name +"',crmff02name = '"+ crmff02name +"',crmff03name = '"+ crmff03name +"',crmff04name = '"+ crmff04name +"',crmff05name = '"+ crmff05name + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	
	sql = "update CptSearchMould set reqff01name = '"+ reqff01name +"',reqff02name = '"+ reqff02name +"',reqff03name = '"+ reqff03name +"',reqff04name = '"+ reqff04name +"',reqff05name = '"+ reqff05name + "' where id = " + mouldid;
	RecordSet.executeSql(sql);	

	
  	response.sendRedirect("CptSearch.jsp?advanced=1&mouldid="+mouldid);
 }
 else if(operation.equals("delete")){
	String para = ""+mouldid;
	RecordSet.executeProc("CptSearchMould_Delete",para);
	RecordSet.executeSql("delete from CptSearchDefinition where mouldid = " + mouldid);		  
 	response.sendRedirect("CptSearch.jsp");
 }
%>
