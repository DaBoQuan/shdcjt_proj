<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(572,user.getLanguage())+SystemEnv.getHtmlLabelName(527,user.getLanguage());
String needfav ="1";
String needhelp ="";

String firstname = Util.null2String(request.getParameter("firstname")) ;
String age = Util.null2String(request.getParameter("age")) ;
String ageTo = Util.null2String(request.getParameter("ageTo")) ;
String IDCard = Util.null2String(request.getParameter("IDCard")) ;

int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);
int perpage=Util.getPerpageLog();
if(perpage<10) perpage=10;

Calendar today = Calendar.getInstance();

String birthbyage = "";
String birthbyageTo = "";

int tempyear = Util.getIntValue(Util.add0(today.get(Calendar.YEAR), 4));

if(!age.equals("")){
    birthbyage = (tempyear-Util.getIntValue(age))+"-"+
            Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
            Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
}

if(!ageTo.equals("")){
    birthbyageTo =(tempyear-Util.getIntValue(ageTo))+"-"+
            Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
            Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
}

String whereclause = "";
/*-----  xwj for td2043 on 2005-6-1  begin  -----*/
whereclause += "where t1.customerid = t2.relateditemid " + 
"and t1.customerid  in  (select id from CRM_CustomerInfo where deleted = 0) ";

if(!firstname.equals("")) whereclause +="and t1.firstname like '%"+firstname+"%'";

if(!birthbyage.equals("")) {
    if(RecordSet.getDBType().equalsIgnoreCase("oracle")){
        if(whereclause.equals("")) whereclause +=" where t1.birthday <='"+birthbyage+"' and t1.birthday is not null ";
        else whereclause +=" and t1.birthday <='"+birthbyage+"' and t1.birthday is not null ";
    }else{
        if(whereclause.equals("")) whereclause +=" where t1.birthday <='"+birthbyage+"' and t1.birthday<>'' ";
        else whereclause +=" and t1.birthday <='"+birthbyage+"' and t1.birthday<>'' ";
    }
}
if(!birthbyageTo.equals("")) {
	if(RecordSet.getDBType().equalsIgnoreCase("oracle")){
        if(whereclause.equals("")) whereclause +=" where t1.birthday >='"+birthbyageTo+"' and t1.birthday is not null ";
        else whereclause +=" and t1.birthday >='"+birthbyageTo+"' and t1.birthday is not null ";
    }else{
        if(whereclause.equals("")) whereclause +=" where t1.birthday >='"+birthbyageTo+"' and t1.birthday<>'' ";
        else whereclause +=" and t1.birthday >='"+birthbyageTo+"' and t1.birthday<>'' ";
    }
}
if(!IDCard.equals("")) {
	if(whereclause.equals("")) whereclause +="where t1.IDCard like '%"+IDCard+"%'" ;
	else whereclause +=" and t1.IDCard like '%"+IDCard+"%'" ;
}

String leftjointable = CrmShareBase.getTempTable(""+user.getUID());

String backFields = "id, firstname, title, jobtitle, customerid";
String sqlFrom = " CRM_CustomerContacter t1,"+leftjointable+" t2";
String popedomOtherpara = user.getLogintype()+"_"+user.getUID();
String tableString=""+
			  "<table  pagesize=\""+perpage+"\" tabletype=\"none\">"+
			  "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(sqlFrom)+"\" sqlprimarykey=\"id\" sqlorderby=\"customerid\" sqlsortway=\"asc\" sqlisdistinct=\"true\" sqlwhere=\""+Util.toHtmlForSplitPage(whereclause)+"\"/>"+
			  "<head>"+                             
					  "<col width=\"35%\"  text=\""+SystemEnv.getHtmlLabelName(413,user.getLanguage())+"\" column=\"firstname\" orderkey=\"firstname\" target=\"_self\" linkkey=\"ContacterID\" linkvaluecolumn=\"id\" href=\"/CRM/data/ViewContacter.jsp\"/>"+
					  "<col width=\"25%\"  text=\""+SystemEnv.getHtmlLabelName(462,user.getLanguage())+"\" column=\"title\" orderkey=\"title\" transmethod=\"weaver.crm.Maint.ContacterTitleComInfo.getContacterTitlename\"/>"+
					  "<col width=\"20%\"  text=\""+SystemEnv.getHtmlLabelName(640,user.getLanguage())+"\" column=\"jobtitle\" orderkey=\"jobtitle\"/>"+
					  "<col width=\"20%\"  text=\""+SystemEnv.getHtmlLabelName(136,user.getLanguage())+"\"  column=\"customerid\" orderkey=\"customerid\" transmethod=\"weaver.crm.Maint.CustomerInfoComInfo.getCustomerInfoname\" linkkey=\"CustomerID\" href=\"/CRM/data/ViewCustomer.jsp\"/>"+ 
			  "</head>"+
			  "</table>";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onReSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<FORM id=report name=report action=ContacterSearch.jsp method=post>
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

			<TABLE class=ViewForm>
			<COLGROUP>
			  <COL width="10%">
			  <COL width="40%">
			  <COL width="10%">
			  <COL width="40%">
			  <TBODY>
		        <TR>
		          <TD><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></TD>
		          <TD class=field><INPUT class=InputStyle maxLength=50 size=30 name="firstname" value="<%=firstname%>"></TD>
		          <TD><%=SystemEnv.getHtmlLabelName(671,user.getLanguage())%></TD>
		          <TD class=field><INPUT class=inputstyle name=age size=5 maxlength=3  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("age")' value="<%=age%>"><%=SystemEnv.getHtmlLabelName(15864,user.getLanguage())%>��
		          <INPUT class=inputstyle name=ageTo size=5 maxlength=3  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("ageTo")' value="<%=ageTo%>"><%=SystemEnv.getHtmlLabelName(15864,user.getLanguage())%>
		          </TD>
		        </TR><tr style="height: 1px"><td class=Line colspan=4></td></tr>
		        <TR>
				  <TD><%=SystemEnv.getHtmlLabelName(1887,user.getLanguage())%></TD>
		          <TD class=field><INPUT class=InputStyle maxLength=100 size=30 name="IDCard" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("IDCard")'  value="<%=IDCard%>"></TD>
		        </TR><tr style="height: 1px"><td class=Line colspan=4></td></tr>
			</TBODY>
			</TABLE>
			<TABLE class=ListStyle cellspacing=0>
			<tr><td valign="top"><wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" isShowTopInfo="true"/></td></tr>
			</TABLE>
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

<script>
function onReSearch(){
	report.submit();
}
</script>
</FORM>
</BODY>
</HTML>
