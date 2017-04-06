<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetCO" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CRMSearchComInfo" class="weaver.crm.search.SearchComInfo" scope="session" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />

<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="CustomerDescComInfo" class="weaver.crm.Maint.CustomerDescComInfo" scope="page" />
<jsp:useBean id="CustomerSizeComInfo" class="weaver.crm.Maint.CustomerSizeComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="ContactWayComInfo" class="weaver.crm.Maint.ContactWayComInfo" scope="page" />
<jsp:useBean id="SectorInfoComInfo" class="weaver.crm.Maint.SectorInfoComInfo" scope="page" />
<jsp:useBean id="CustomerRatingComInfo" class="weaver.crm.Maint.CustomerRatingComInfo" scope="page" />
<jsp:useBean id="CreditInfoComInfo" class="weaver.crm.Maint.CreditInfoComInfo" scope="page" />
<jsp:useBean id="TradeInfoComInfo" class="weaver.crm.Maint.TradeInfoComInfo" scope="page" />
<jsp:useBean id="CustomerStatusComInfo" class="weaver.crm.Maint.CustomerStatusComInfo" scope="page" />
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>
<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page"/>
<jsp:useBean id="CityComInfo" class="weaver.hrm.city.CityComInfo" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(527,user.getLanguage())+SystemEnv.getHtmlLabelName(356,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<%
String userid = ""+user.getUID();
String loginType = ""+user.getLogintype();
String userSeclevel = user.getSeclevel();
String destination = Util.null2String(request.getParameter("destination"));
/*
if(!CRMSearchComInfo.getAccountManager().equals("")&&destination.equals("myAccount")){//�����¿�Ƭ����ͻ�����
    userid = CRMSearchComInfo.getAccountManager();
    loginType = "1";
    userSeclevel = ResourceComInfo.getSeclevel(userid);
}
*/

int perpage=10;
char flag = 2;
String ProcPara = userid+flag+loginType;
RecordSet.executeProc("CRM_Customize_SelectByUid",ProcPara);

boolean hasCustomize = true;
if(RecordSet.getCounts()<=0){
	hasCustomize = false;
}else{
	RecordSet.first();
  perpage=RecordSet.getInt("perpage");
}
int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);
if(perpage<=0 )	perpage=10;

int j=0;
int options[] = new int[6];
for(j=0;j<6;j++){
	if(hasCustomize){
		options[j] = RecordSet.getInt(j+2);
	}else{
		switch(j){
			case 0: options[j] = 101;break;
			case 1: options[j] = 203;break;
			default: options[j] = 0;
		}
	}
}

int nMaxCols = 0;
for(j=0;j<6;j++){
	if(options[j]!=0){
		nMaxCols = j+1 > nMaxCols ? j+1 : nMaxCols ;
	}
}
String leftjointable = CrmShareBase.getTempTable(userid);

String name="";
String text="";
String column="";
String orderkey="";
String target="\"_fullwindow\"";
String transmethod="";
String href="";
String linkkey="";

String strURL="";
String strData="";
String linkvaluecolumn="";

String tableInfo = "";
String backFields = "";
String colString = "";
String sqlFrom = "";
String sqlWhere = "";
String orderBy = "";
if(loginType.equals("1")){
	if (RecordSet.getDBType().equals("oracle")){
		backFields = "t1.id,(select t3.id from (select * from CRM_CustomerContacter order by main desc,id desc) t3 where t3.customerid = t1.id and rownum = 1) as contacterid";
		sqlFrom = "from CRM_CustomerInfo t1 left join "+leftjointable+" t2 on t1.id = t2.relateditemid";
		sqlWhere = CRMSearchComInfo.FormatSQLSearch(user.getLanguage())+" and t1.id = t2.relateditemid";
	} else {
		backFields = "t1.id,(select top 1 t3.id from CRM_CustomerContacter t3 where t3.customerid = t1.id order by main desc,id desc) as contacterid";
		sqlFrom = "from CRM_CustomerInfo t1 left join "+leftjointable+" t2 on t1.id = t2.relateditemid";
		sqlWhere = CRMSearchComInfo.FormatSQLSearch(user.getLanguage())+" and t1.id = t2.relateditemid";
	}
	orderBy = "t1.id";
}else{
	backFields = "t1.id,t3.id as contacterid";
	sqlFrom = "from CRM_CustomerInfo t1 left join CRM_CustomerContacter t3 on t1.id=t3.customerid";
	sqlWhere = CRMSearchComInfo.FormatSQLSearch(user.getLanguage())+" and t1.agent="+userid;
	orderBy = "t1.id";
}
for(j=0;j<nMaxCols;j++){
	if(options[j]==0){
		continue;
	}
	RecordSetCO.executeProc("CRM_CustomizeOption_SelectByID",""+options[j]);
	if(RecordSetCO.getCounts()<=0)
		response.sendRedirect("/CRM/DBError.jsp?type=FindData_SRD_4");
	RecordSetCO.first();
	text = ((RecordSetCO.getInt("tabledesc")==1)?SystemEnv.getHtmlLabelName(136,user.getLanguage()):SystemEnv.getHtmlLabelName(572,user.getLanguage())) + SystemEnv.getHtmlLabelName(RecordSetCO.getInt("labelid"),user.getLanguage());
	if(RecordSetCO.getInt("tabledesc")==1){//���ﴦ���ֹ������ͬ���ֶ�
		backFields += ",t1."+RecordSetCO.getString("fieldname");
		if((backFields.indexOf("."+RecordSetCO.getString("fieldname")+",")!=-1)||(backFields.indexOf("as "+RecordSetCO.getString("fieldname"))!=-1)){
            backFields += " as "+RecordSetCO.getString("fieldname")+j;
			column = name = RecordSetCO.getString("fieldname")+j;
			orderkey = "t1."+RecordSetCO.getString("fieldname");
		}else{
			column = name = RecordSetCO.getString("fieldname");
			orderkey = "t1."+RecordSetCO.getString("fieldname");
		}



	}else{
		if(loginType.equals("1")){
			if (RecordSet.getDBType().equals("oracle")){
				backFields += "," + "(select t3."+RecordSetCO.getString("fieldname")+" from (select * from CRM_CustomerContacter order by main desc,id desc) t3 where t3.customerid = t1.id and rownum = 1)";
				if((backFields.indexOf("."+RecordSetCO.getString("fieldname")+",")!=-1)||(backFields.indexOf("as "+RecordSetCO.getString("fieldname"))!=-1)){
					backFields += " as "+RecordSetCO.getString("fieldname")+j;
					column = name = RecordSetCO.getString("fieldname")+j;
					orderkey = RecordSetCO.getString("fieldname")+j;
				}else{
					backFields += " as "+RecordSetCO.getString("fieldname");
					column = name = RecordSetCO.getString("fieldname");
					orderkey = RecordSetCO.getString("fieldname");
				}
			} else {
				backFields += "," + "(select top 1 t3."+RecordSetCO.getString("fieldname")+" from CRM_CustomerContacter t3 where t3.customerid = t1.id order by main desc,id desc)";
				if((backFields.indexOf("."+RecordSetCO.getString("fieldname")+",")!=-1)||(backFields.indexOf("as "+RecordSetCO.getString("fieldname"))!=-1)){
					backFields += " as "+RecordSetCO.getString("fieldname")+j;
					column = name = RecordSetCO.getString("fieldname")+j;
					orderkey = RecordSetCO.getString("fieldname")+j;
				}else{
					backFields += " as "+RecordSetCO.getString("fieldname");
					column = name = RecordSetCO.getString("fieldname");
					orderkey = "t3."+RecordSetCO.getString("fieldname");
				}
			}
		} else {
			backFields += ",t3."+RecordSetCO.getString("fieldname");
			if((backFields.indexOf("."+RecordSetCO.getString("fieldname")+",")!=-1)||(backFields.indexOf("as "+RecordSetCO.getString("fieldname"))!=-1)){
				backFields += " as "+RecordSetCO.getString("fieldname")+j;
				column = name = RecordSetCO.getString("fieldname")+j;
				orderkey = "t3."+RecordSetCO.getString("fieldname");
			}else{
				column = name = RecordSetCO.getString("fieldname");
				orderkey = "t3."+RecordSetCO.getString("fieldname");
			}
		}
	}

	switch(options[j]){
		case 102:
		case 202://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.systeminfo.language.LanguageComInfo.getLanguagename\"";
			break;
		case 106://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.hrm.city.CityComInfo.getCityname\"";
			break;
		case 107://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.hrm.country.CountryComInfo.getCountryname\"";
			break;
		case 108://��Ҫ����Ӧ����ת���� ʡ��
			transmethod = "\"weaver.hrm.province.ProvinceComInfo.getProvincename\"";
			break;
		case 114://��Ҫ����Ӧ����ת���� ��ϵ����
			transmethod = "\"weaver.crm.Maint.ContactWayComInfo.getContactWayname\"";
			break;
		case 115://��Ҫ����Ӧ����ת���� ��ҵ
			transmethod = "\"weaver.crm.Maint.SectorInfoComInfo.getSectorInfoname\"";
			break;
		case 116://��Ҫ����Ӧ����ת���� ��ģ
			transmethod = "\"weaver.crm.Maint.CustomerSizeComInfo.getCustomerSizedesc\"";
			break;
		case 117://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.crm.Maint.CustomerTypeComInfo.getCustomerTypename\"";
			break;
		case 119://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.crm.Maint.CustomerDescComInfo.getCustomerDescname\"";
			break;
		case 120://��Ҫ����Ӧ����ת���� ״̬
			transmethod = "\"weaver.crm.Maint.CustomerStatusComInfo.getCustomerStatusname\"";
			break;
		case 121://��Ҫ����Ӧ����ת���� ����
			transmethod = "\"weaver.crm.Maint.CustomerRatingComInfo.getCustomerRatingname\"";
			break;
		case 122://��Ҫ����Ӧ����ת���� ��ͬ���
			transmethod = "\"weaver.crm.Maint.TradeInfoComInfo.getTradeInfoname\"";
			break;
		case 123://��Ҫ����Ӧ����ת���� ���õȼ�
			transmethod = "\"weaver.crm.Maint.CreditInfoComInfo.getCreditInfoname\"";
			break;
		case 201://��Ҫ����Ӧ����ת���� ��ϵ�˳ƺ�
			transmethod = "\"weaver.crm.Maint.ContacterTitleComInfo.getContacterTitlename\"";
			break;
		case 124:
		case 212://��Ҫ����Ӧ����ת���� Ա����Ϣ ��������������
			strURL = "\"/hrm/resource/HrmResource.jsp\"";
			linkkey ="\"id\"";
			transmethod = "\"weaver.hrm.resource.ResourceComInfo.getResourcename\"";
			break;
		case 125://��Ҫ����Ӧ����ת���� ������Ϣ ��������������
			strURL = "\"/hrm/company/HrmDepartmentDsp.jsp\"";
			linkkey ="\"id\"";
			transmethod = "\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"";
			break;
		case 126:
		case 127://��Ҫ����Ӧ����ת���� �ͻ���Ϣ ��������������
			strURL = "\"/CRM/data/ViewCustomer.jsp\"";
			linkkey = "\"CustomerID\"";
			transmethod = "\"weaver.crm.Maint.CustomerInfoComInfo.getCustomerInfoname\"";
			break;
		case 101://������������
			strURL = "\"/CRM/data/ViewCustomer.jsp\"";
			linkkey = "\"CustomerID\"";
			linkvaluecolumn = "\"id\"";
			break;
		case 203:
		case 204:
		case 205://������������
			strURL = "\"/CRM/data/ViewContacter.jsp\"";
			linkkey = "\"ContacterID\"";
			linkvaluecolumn = "\"contacterid\"";
			break;

		default:break;
	}
	colString +="<col name=\""+name+"\" text=\""+text+"\" column=\""+column+"\"";
	if(options[j]==102||options[j]==202||options[j]==106||options[j]==107||options[j]==108||options[j]==114||options[j]==115||options[j]==116||options[j]==117||options[j]==119||options[j]==120||options[j]==121||
	options[j]==122||options[j]==123||options[j]==201||options[j]==124||options[j]==212||options[j]==125||options[j]==126||options[j]==127)
		colString +=" transmethod="+transmethod;
	if(options[j]==101||options[j]==124||options[j]==212||options[j]==125||options[j]==126||options[j]==127||options[j]==203||options[j]==204||options[j]==205)
		colString +=" href="+strURL+" linkkey="+linkkey;
	if(options[j]==101||options[j]==203||options[j]==204||options[j]==203)
		colString +=" linkvaluecolumn="+linkvaluecolumn;
	colString+=" orderkey=\""+orderkey+"\" target=\"_fullwindow\"/>";
}

String popedomOtherpara = loginType+"_"+userid+"_"+userSeclevel;
String operateString= "<operates width=\"15%\">";
       operateString+=" <popedom transmethod=\"weaver.splitepage.operate.SpopForCus.getCusOpratePopedom\"  otherpara=\""+popedomOtherpara+"\"></popedom> ";
       operateString+="     <operate href=\"/CRM/data/ViewContactLog.jsp\" linkkey=\"CustomerID\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(6082,user.getLanguage())+"\" target=\"_fullwindow\"  index=\"0\"/>";
       operateString+="     <operate href=\"javascript:doEdit()\" text=\""+SystemEnv.getHtmlLabelName(93,user.getLanguage())+"\" target=\"_fullwindow\"  index=\"1\"/>";
       operateString+="     <operate href=\"javascript:doShare()\" text=\""+SystemEnv.getHtmlLabelName(119,user.getLanguage())+"\" target=\"_fullwindow\"  index=\"2\"/>";
       operateString+="     <operate href=\"javascript:doViewLog()\" text=\""+SystemEnv.getHtmlLabelName(83,user.getLanguage())+"\" target=\"_fullwindow\"  index=\"3\"/>";       
       operateString+="</operates>";
       
String tableString="<table  pagesize=\""+perpage+"\" tabletype=\"none\">";
       tableString+="<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(sqlFrom)+"\" sqlorderby=\""+orderBy+"\" sqlsortway=\"Desc\" sqlprimarykey=\"t1.id\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlisdistinct=\"true\" />";
       tableString+="<head>"+colString+"</head>";
       tableString+=operateString;
       tableString+="</table>";     
//out.println("select "+backFields+" "+sqlFrom+" "+sqlWhere+" order by "+orderBy);       
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",javascript:onReSearch(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(343,user.getLanguage())+",javascript:location.href='/CRM/search/Customize.jsp',_top} " ;
RCMenuHeight += RCMenuHeightStep ;

if(HrmUserVarify.checkUserRight("MailMerge:Merge", user)){
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1226,user.getLanguage())+",javascript:location.href='/sendmail/CrmChoice.jsp?issearch=1',_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
}
if(HrmUserVarify.checkUserRight("MutiApproveCustomerNoRequest", user)){
    RCMenu += "{"+SystemEnv.getHtmlLabelName(17529,user.getLanguage())+",javascript:location.href='/CRM/data/ChangeLevelCustomerList.jsp',_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
}

if(HrmUserVarify.checkUserRight("EditCustomer:Delete", user)){
    RCMenu += "{"+"Excel,javascript:crmExport(),_top} " ;
    RCMenuHeight += RCMenuHeightStep;
}

%>
<table width=100% height=96% border="0" cellspacing="0" cellpadding="0">
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
     	<wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" tableInfo="<%=tableInfo%>"/> 
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<iframe id="searchexport" style="display:none"></iframe>
<script language="javascript">

<%---onReSearch() edited by ��ε� 2005-03-10 for TD:1546----%>
function onReSearch(){
<%if(Util.null2String(CRMSearchComInfo.getSearchtype()).equals("advanced")){%>
location.href="/CRM/search/SearchAdvanced.jsp?actionKey=common";
<%}else{%>
location.href="/CRM/search/SearchSimple.jsp?actionKey=common";
<%}%>
}

function crmExport(){
    searchexport.location="SearchResultExport.jsp";
}

function doEdit(crmid){
	var url = "/CRM/data/EditCustomer.jsp?CustomerID="+crmid;
	openFullWindowHaveBar(url);
}

function doShare(crmid){
	var url = "/CRM/data/AddShare.jsp?itemtype=2&CustomerID="+crmid+"&customername=";
	openFullWindowHaveBar(url);
}

function doViewLog(crmid){
	var url = "/CRM/data/ViewLog.jsp?log=n&CustomerID="+crmid;
	openFullWindowHaveBar(url);
}
</script>
</body>
</html>

