<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.docs.category.security.*" %>
<%@ page import="weaver.docs.category.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mould.DocMouldComInfo" scope="page" />
<jsp:useBean id="DocTreeDocFieldComInfo" class="weaver.docs.category.DocTreeDocFieldComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%!
//���ݲ���Ȩ�ޣ���������Ȩ���ж����յ�����Ȩ��
private String setDLValueInit(String strDLValue, String strOprateValue) {
	String strDLNewValue = "0";
	if (strDLValue != null && !"".equals(strDLValue)) {
		strDLNewValue = strDLValue;
	} else if("1".equals(strOprateValue) || "2".equals(strOprateValue) || "3".equals(strOprateValue)) {
		strDLNewValue = "1";
	} else if("0".equals(strOprateValue)) {
		strDLNewValue = "0";
	}
	return strDLNewValue;
}
/** TD12005 �ĵ�����Ȩ�޿���   ���� */
%>
<%
if(! HrmUserVarify.checkUserRight("SystemSetEdit:Edit", user)) { 
    response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(17688,user.getLanguage()) + ":" +SystemEnv.getHtmlLabelName(2115,user.getLanguage());
String needfav ="1";
String needhelp ="";

%>
<%
int pagepos=Util.getIntValue(Util.null2String(request.getParameter("pagepos")),1);
String type=Util.fromScreen(request.getParameter("type"),user.getLanguage()) ;
String mainid=Util.fromScreen(request.getParameter("mainid"),user.getLanguage()) ;
String subid=Util.fromScreen(request.getParameter("subid"),user.getLanguage()) ;
String secid=Util.fromScreen(request.getParameter("secid"),user.getLanguage()) ;
if(type.equals("main")){
	subid = "";
	secid = "";
}else if(type.equals("sub")){
	secid = "";
}

String wfid=Util.fromScreen(request.getParameter("wfid"),user.getLanguage()) ;
ArrayList list = new ArrayList();
%>
<BODY>
    <%@ include file="/systeminfo/TopTitle.jsp" %>
    <%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
    <%
	    RCMenu += "{" + "Excel,javascript:exportXSL(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
	    RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
	    RCMenuHeight += RCMenuHeightStep ;
	    RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",javascript:doSearchAgain(),_self}" ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doBack(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
	%>
    <%@ include file="/systeminfo/RightClickMenu.jsp" %>

	<table width=100% height=90% border="0" cellspacing="0" cellpadding="0">
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
			
			<TABLE class="Shadow">
			<tr>
			<td valign="top">
			
<form action="basedata_doc.jsp" method="post" name="frmmain">
<input type="hidden" name="type" value="">
<INPUT type="hidden" name=pagepos value="">
<table class=form>

  <tr>
    <td width="15%"><%=SystemEnv.getHtmlLabelName(65,user.getLanguage())%></td>
    <td width="35%" class=field>
    <select name="mainid" size=1 style="width:90%" onchange="goChoose('main')">
        <option value=""><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
    <%
        while(MainCategoryComInfo.next()){
            String tmpid=MainCategoryComInfo.getMainCategoryid() ;
            String tmpname=MainCategoryComInfo.getMainCategoryname() ;
            String select="" ;
            if(mainid.equals(tmpid))    select="selected";
    %>      <option value="<%=tmpid%>" <%=select%>><%=tmpname%></option>
    <%
        }
    %>
    </select>
    </td>
    <td width="15%"><%=SystemEnv.getHtmlLabelName(66,user.getLanguage())%></td>
    <td width="35%" class=field>
    <select name="subid" size=1 style="width:90%" onchange="goChoose('sub')">
        <option value=""><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
    <%
        while(SubCategoryComInfo.next()){
            String tmpid=SubCategoryComInfo.getSubCategoryid() ;
            String tmpname=SubCategoryComInfo.getSubCategoryname() ;
            String tmpmainid=SubCategoryComInfo.getMainCategoryid() ;
            String select="" ;
            if(!mainid.equals("")){  
                if(!mainid.equals(tmpmainid))
                	continue;
                else
                	list.add(tmpid);
            }
            if(subid.equals(tmpid))    select="selected";
    %>      <option value="<%=tmpid%>" <%=select%>><%=tmpname%></option>
    <%
        }
    %>
    </select>
    </td>
  </tr>
  <tr>
    <td width="15%"><%=SystemEnv.getHtmlLabelName(67,user.getLanguage())%></td>
    <td width="35%" class=field>
    <select name="secid" size=1 style="width:90%" onchange="goChoose('sec')">
        <option value=""><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
    <%
        while(SecCategoryComInfo.next()){
            String tmpid=SecCategoryComInfo.getSecCategoryid() ;
            String tmpname=SecCategoryComInfo.getSecCategoryname() ;
            String tmpsubid=SecCategoryComInfo.getSubCategoryid() ;
            String select="" ;
            if(!mainid.equals("")||!subid.equals("")){
	            if(!subid.equals("")){
	                if(!subid.equals(tmpsubid))continue;
	            }else{
		            String subid2 = "";
	            	for(int i=0;i<list.size();i++){
	            		subid2 = (String)list.get(i);
	            		if(subid2.equals(tmpsubid))break;
	            	}
	            	if(!subid2.equals(tmpsubid))continue;
	            }
            }
            if(secid.equals(tmpid))    select="selected";
    %>      <option value="<%=tmpid%>" <%=select%>><%=tmpname%></option>
    <%
        }
    %>
    </select>
    </td>
    <td width="15%"><%=SystemEnv.getHtmlLabelName(15057,user.getLanguage())%></td>
    <td width="35%" class=field>
    <select name="wfid" size=1 style="width:90%">
        <option value=""><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
    <%	RecordSet.executeSql("select * from workflow_base where isbill='1' and formid=28");
        while(RecordSet.next()){
            String tmpid=RecordSet.getString("id") ;
            String tmpname=RecordSet.getString("workflowname") ;
            String select="" ;
            if(wfid.equals(tmpid))    select="selected";
    %>      <option value="<%=tmpid%>" <%=select%>><%=tmpname%></option>
    <%
        }
    %>
    </select>
    </td>
  </tr>
</table>
</form>

<br>
<TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <COL width="5%"><COL width="9%">
  <TBODY>
  <TR class=separator>
    <TD class=Sep1 colSpan=14 ></TD></TR>
  <TR class=Header >
    <TH colspan="14"><%=SystemEnv.getHtmlLabelName(15056,user.getLanguage())%></TH>
  </TR>
<%
int countsize = 0;
int pagesizes = 0;
int currentpagestart = 0;
int currentpageend = 0;
String tmpmain="" ;
String tmpsub ="" ;
String sqlwhere = "";
if(!mainid.equals(""))  
	sqlwhere += " and t3.id = "+mainid;
if(!subid.equals(""))  
	sqlwhere += " and t2.id = "+subid;
if(!secid.equals(""))  
	sqlwhere += " and t1.id = "+secid;
if(!wfid.equals(""))  
	sqlwhere += " and t1.approveworkflowid = "+wfid;
String sql = "select count(*) from DocSecCategory t1,DocSubCategory t2,DocMainCategory t3 where t1. subcategoryid = t2.id and t2.maincategoryid = t3.id "+sqlwhere;
//out.println(sql);
RecordSet.executeSql(sql);
if(RecordSet.next())
{
	countsize = RecordSet.getInt(1);
}
pagesizes = countsize%10==0?countsize/10:(countsize/10+1);
if(pagepos<=0)
{
	pagepos = 1;
}
if(pagepos>=pagesizes)
{
	pagepos = pagesizes;
}

currentpagestart = (pagepos-1)*10<0?0:(pagepos-1)*10;
currentpageend = (pagepos*10>countsize)?countsize:pagepos*10;
int currentpagesize = currentpageend-currentpagestart;
//out.println("currentpagestart : "+currentpagestart+"   currentpageend : "+currentpageend);
if(RecordSet.getDBType().equals("oracle"))
{
	
	sql = "select * "+
		  "	  from (select rownum as rowno, r.* "+
		  "	          from (select t1.* "+
		  "	                  from DocSecCategory  t1, "+
		  "	                       DocSubCategory  t2, "+
		  "	                       DocMainCategory t3 "+
		  "	                 where t1. subcategoryid = t2.id "+
		  "	                   and t2.maincategoryid = t3.id "+sqlwhere+
		  "	                 order by t3.categoryorder, t2.id) r) c "+
		  "	 where c.rowno <= "+currentpageend+
		  "	   and c.rowno > "+currentpagestart;
		  
}
else
{
	sql = "select top "+currentpagesize+" c.* "+
	  "	  from (select top "+currentpagesize+" r.* "+
	  "	          from (select top "+currentpageend+" t1.*, "+
	  "						   t3.categoryorder "+
	  "	                  from DocSecCategory  t1, "+
	  "	                       DocSubCategory  t2, "+
	  "	                       DocMainCategory t3 "+
	  "	                 where t1. subcategoryid = t2.id "+
	  "	                   and t2.maincategoryid = t3.id "+sqlwhere+
	  "	                 order by t3.categoryorder asc, t2.id asc ) r order by r.categoryorder desc, r.id desc ) c "+
	  "	 order by c.categoryorder asc, c.id asc";
}
//out.println(sql);
RecordSet.executeSql(sql);
while(RecordSet.next()){
    String seccategoryid=RecordSet.getString("id");
    String coder=RecordSet.getString("coder");
    String seccategoryname=RecordSet.getString("categoryname");
    String subcategoryid=RecordSet.getString("subcategoryid");
    String subcategoryname=SubCategoryComInfo.getSubCategoryname(subcategoryid) ;
    String maincategoryid=SubCategoryComInfo.getMainCategoryid(subcategoryid) ;
    String maincategoryname=MainCategoryComInfo.getMainCategoryname(maincategoryid) ;
    String approvewfid=RecordSet.getString("approveworkflowid") ;
    String publishable=RecordSet.getString("publishable") ;
    String replyable=RecordSet.getString("replyable") ;
    String hasasset=RecordSet.getString("hasasset");
    String assetlabel=RecordSet.getString("assetlabel");
    String hashrmres=RecordSet.getString("hashrmres");
	String hrmreslabel=RecordSet.getString("hrmreslabel");
	String hascrm=RecordSet.getString("hascrm");
	String crmlabel=RecordSet.getString("crmlabel");
	String hasproject=RecordSet.getString("hasproject");
	String projectlabel=RecordSet.getString("projectlabel");
    String markable=RecordSet.getString("markable") ;
    String markAnonymity=RecordSet.getString("markAnonymity") ;
    int defaultLockedDoc=Util.getIntValue(Util.null2String(RecordSet.getString("defaultLockedDoc")),0);
    int noDownload = Util.getIntValue(Util.null2String(RecordSet.getString("nodownload")),0);
    int maxOfficeDocFileSize=Util.getIntValue(Util.null2String(RecordSet.getString("maxOfficeDocFileSize")),8);	
    int maxUploadFileSize=Util.getIntValue(Util.null2String(RecordSet.getString("maxUploadFileSize")),0);
    int noRepeatedName = Util.getIntValue(Util.null2String(RecordSet.getString("norepeatedname")),0);
    int isControledByDir = Util.getIntValue(Util.null2String(RecordSet.getString("iscontroledbydir")),0);
    int pubOperation = Util.getIntValue(Util.null2String(RecordSet.getString("puboperation")),0);
    int relationable  = Util.getIntValue(RecordSet.getString("relationable"),0);
    int childDocReadRemind = Util.getIntValue(Util.null2String(RecordSet.getString("childdocreadremind")),0);
    String isPrintControl=Util.null2String(RecordSet.getString("isPrintControl"));
    int printApplyWorkflowId = Util.getIntValue(Util.null2String(RecordSet.getString("printApplyWorkflowId")),0);
    
    String isLogControl = Util.null2String(RecordSet.getString("isLogControl"));
    String defaultDummyCata=Util.null2String(RecordSet.getString("defaultDummyCata"));
    int useCustomSearch = Util.getIntValue(Util.null2String(RecordSet.getString("useCustomSearch")),0); 
    float secorder = RecordSet.getFloat("secorder");
    int isOpenAttachment = Util.getIntValue(Util.null2String(RecordSet.getString("isOpenAttachment")),0);
    int editionIsOpen = Util.getIntValue(Util.null2String(RecordSet.getString("editionIsOpen")),0);
    
    int readOpterCanPrint = Util.getIntValue(Util.null2String(RecordSet.getString("readoptercanprint")),0);
    int appointedWorkflowId = Util.getIntValue(Util.null2String(RecordSet.getString("appointedWorkflowId")),0); 
    int logviewtype = Util.getIntValue(RecordSet.getString("logviewtype"),0);
    String orderable=RecordSet.getString("orderable") ;
    String shareable=RecordSet.getString("shareable");
    int allownModiMShareL=Util.getIntValue(Util.null2String(RecordSet.getString("allownModiMShareL")),0);
    int isSetShare=Util.getIntValue(Util.null2String(RecordSet.getString("isSetShare")),0);
    String docmouldid=RecordSet.getString("docmouldid") ;
    int appliedTemplateId = Util.getIntValue(Util.null2String(RecordSet.getString("appliedTemplateId")),0);
    String appliedTemplateName = "";
    if(appliedTemplateId>0){
    	rs.executeSql(" select name from DocSecCategoryTemplate where id = " + appliedTemplateId);
    	rs.next();
    	appliedTemplateName = Util.null2String(rs.getString(1));
    }
    if(!mainid.equals(""))  
        if(!mainid.equals(maincategoryid))  continue;
    if(!subid.equals(""))  
        if(!subid.equals(subcategoryid))  continue;
    if(!secid.equals(""))  
        if(!secid.equals(seccategoryid))  continue;
    if(!wfid.equals(""))  
        if(!wfid.equals(approvewfid))  continue;
%>
  <TR class=Header>
    <TD><%=SystemEnv.getHtmlLabelName(65,user.getLanguage())%></TD><!-- ��Ŀ¼ -->
    <TD>
    <%
    if(!tmpmain.equals("maincategoryid"))
    {
        tmpmain=maincategoryid ;   
    %>
    <b><%=maincategoryname%></b>
    <%
    }
    else 
    {%>
    &nbsp;
    <%} %>   
    </TD>
	<TD><%=SystemEnv.getHtmlLabelName(66,user.getLanguage())%></TD><!-- ��Ŀ¼ -->
	<TD>
    <%
    if(!tmpsub.equals("subcategoryid"))
    {
        tmpsub=subcategoryid ;   
    %>
    <b><%=subcategoryname%></b>
    <%
    } 
    else 
    {%>
    &nbsp;
    <%} %>   
    </TD>
    <TD><%=SystemEnv.getHtmlLabelName(67,user.getLanguage())%></TD><!-- ��Ŀ¼ -->
    <TD><b><%=seccategoryname%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19389,user.getLanguage())%></TD><!-- ��Ŀ¼���� -->
    <TD><b><%=coder %>&nbsp;</b></TD>
    <td><%=SystemEnv.getHtmlLabelName(19456,user.getLanguage())%></td><!-- Ŀ¼ģ�� -->
    <TD><b><%=appliedTemplateName%></b></TD>
    <td> <%=SystemEnv.getHtmlLabelName(19790,user.getLanguage())%></td><!-- ��������Ϊ���� -->
    <TD><b><%if(publishable.equals("1")){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <td><%=SystemEnv.getHtmlLabelName(115,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(117,user.getLanguage())%></td><!-- ����ظ� -->
    <TD><b><%if(replyable.equals("1")){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  </TR>
  <TR class=Header>
  	<TD><%=SystemEnv.getHtmlLabelName(18572,user.getLanguage())%></TD><!-- ������ -->
    <TD><b><%if(orderable.equals("1")){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  	<TD><%=SystemEnv.getHtmlLabelName(20449,user.getLanguage())%></TD> <!-- �����޸Ĺ��� -->
    <TD><b>
       <%=SystemEnv.getHtmlLabelName(15059,user.getLanguage())%>&nbsp;:&nbsp;<%if(allownModiMShareL==1){out.println(SystemEnv.getHtmlLabelName(163,user.getLanguage()));}else{{out.println(SystemEnv.getHtmlLabelName(161,user.getLanguage()));}}%>
       <br>
       <%=SystemEnv.getHtmlLabelName(18574,user.getLanguage())%>&nbsp;:&nbsp;<%if(shareable.equals("1")){out.println(SystemEnv.getHtmlLabelName(163,user.getLanguage()));}else{{out.println(SystemEnv.getHtmlLabelName(161,user.getLanguage()));}}%>
    </b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19435,user.getLanguage())%></TD><!-- �ĵ��ύʱ���ù��� -->
    <TD><b><%if(isSetShare==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(18575,user.getLanguage())%></TD><!-- ������ -->
	<TD><b><%if(markable.equals("1")){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(18576,user.getLanguage())%></TD><!-- �������� -->
    <TD><b><%if(markAnonymity.equals("1")){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(18578,user.getLanguage())%></TD><!-- �����鿴�ĵ� -->
    <TD><b><%if(defaultLockedDoc==1){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19458,user.getLanguage())%></TD><!-- ��ֹ�ĵ����� -->
    <TD><b><%if(noDownload==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  </tr>
  <TR class=Header>
  	<TD><%=SystemEnv.getHtmlLabelName(24024,user.getLanguage())%></TD><!-- Office�ĵ���� -->
    <TD><b><%=maxOfficeDocFileSize%></b></TD>
  	<TD><%=SystemEnv.getHtmlLabelName(18580,user.getLanguage())%></TD><!-- �����ϴ���� -->
    <TD><b>
       <%=maxUploadFileSize %>
    </b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19449,user.getLanguage())%></TD><!-- ��ֹ�ĵ����� -->
    <TD><b><%if(noRepeatedName==1||noRepeatedName==11){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19459,user.getLanguage())%></TD><!-- �Ƿ��ܿ�Ŀ¼ -->
	<TD><b><%if(isControledByDir==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19460,user.getLanguage())%></TD><!-- �������� -->
    <TD><b><%if(pubOperation==1){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(22672,user.getLanguage())%></TD><!-- �Ƿ���ʾ�����Դ -->
    <TD><b><%if(relationable==1){%><%=SystemEnv.getHtmlLabelName(15060,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19461,user.getLanguage())%></TD><!-- ���ĵ��Ķ����� -->
    <TD><b><%if(childDocReadRemind==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  </tr>
  <TR class=Header>
  	<TD><%=SystemEnv.getHtmlLabelName(21528,user.getLanguage())%></TD><!-- �Ƿ��ӡ���� -->
    <TD><b><%if(isPrintControl.equals("1")){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  	<TD><%=SystemEnv.getHtmlLabelName(21532,user.getLanguage())%></TD><!-- ��ӡ�������� -->
    <TD><b>
       <%=WorkflowComInfo.getWorkflowname(""+printApplyWorkflowId)%>
    </b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(19462,user.getLanguage())%></TD><!-- ����ֻ�������˴�ӡ -->
    <TD><b><%if(readOpterCanPrint==1){%><%=SystemEnv.getHtmlLabelName(115,user.getLanguage())%> <%} else if(readOpterCanPrint==0) {%><%=SystemEnv.getHtmlLabelName(233,user.getLanguage())%> <%}else if(readOpterCanPrint==2) {%><%=SystemEnv.getHtmlLabelName(19463,user.getLanguage())%><%} %></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(20997,user.getLanguage())%></TD><!-- �ĵ���־�鿴 -->
	<TD><b><%if(logviewtype==0){%><%=SystemEnv.getHtmlLabelName(20998,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(20999,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(21996,user.getLanguage())%></TD><!-- �ĵ��Ķ���־���� -->
    <TD><b><%if(isLogControl.equals("1")){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(20498,user.getLanguage())%></TD><!-- Ĭ������Ŀ¼ -->
    <TD><b><%=DocTreeDocFieldComInfo.getMultiTreeDocFieldNameOther(defaultDummyCata)%></b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(24000,user.getLanguage())%></TD><!-- ������ֱ�Ӵ� -->
    <TD><b><%if(isOpenAttachment==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  </tr>
  <TR class=Header>
  	<TD><%=SystemEnv.getHtmlLabelName(21382,user.getLanguage())%></TD><!-- �½�������ָ������ -->
    <TD><b><%=WorkflowComInfo.getWorkflowname(""+appointedWorkflowId)%></b></TD>
  	<TD><%=SystemEnv.getHtmlLabelName(88,user.getLanguage())%></TD><!-- ˳�� -->
    <TD><b>
       <%=secorder%>
    </b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())+SystemEnv.getHtmlLabelName(385,user.getLanguage())%></TD><!-- ����Ȩ�� -->
    <td>
	<%
	        //����Ȩ��
	        String createdesc="";
	        rs.executeProc("Doc_DirAcl_SByDirID",""+seccategoryid+Util.getSeparator()+AclManager.CATEGORYTYPE_SEC+Util.getSeparator()+AclManager.OPERATION_CREATEDOC);    
	
	        while(rs.next()){
	            //���� + ��ȫ����
	            if(rs.getInt("permissiontype")==1)	{
	                 createdesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage())+","+Util.toScreen(DepartmentComInfo.getDepartmentname(rs.getString("departmentid")),user.getLanguage())+"/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //��ɫ + ��ȫ���� + ����
	            if(rs.getInt("permissiontype")==2)	{
	                 createdesc+=SystemEnv.getHtmlLabelName(122,user.getLanguage())+","+Util.toScreen(RolesComInfo.getRolesname(rs.getString("roleid")),user.getLanguage())+"/";
	                if(rs.getInt("rolelevel")==0){
	                    createdesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage());
	                }
	                if(rs.getInt("rolelevel")==1){
	                    createdesc+=SystemEnv.getHtmlLabelName(141,user.getLanguage());
	                }
	                if(rs.getInt("rolelevel")==2){
	                    createdesc+=SystemEnv.getHtmlLabelName(140,user.getLanguage());
	                }
	
	                    createdesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //��ȫ����
	            if(rs.getInt("permissiontype")==3)	{
	                 createdesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+","+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //�û����� + ��ȫ����
	            if(rs.getInt("permissiontype")==4)	{
	                 createdesc+=SystemEnv.getHtmlLabelName(7179,user.getLanguage())+",";
	                 if(rs.getInt("usertype")==0){
	                   createdesc+=SystemEnv.getHtmlLabelName(131,user.getLanguage()).trim();
	                 }
	                 else{
	                   createdesc+=CustomerTypeComInfo.getCustomerTypename(rs.getString("usertype"));
	                 }
	                 createdesc+="/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	
	            }
	            //������Դ
	            if(rs.getInt("permissiontype")==5)	{
	                 createdesc+=SystemEnv.getHtmlLabelName(179,user.getLanguage())+","+Util.toScreen(ResourceComInfo.getResourcename(rs.getString("userid")),user.getLanguage());
	            }
	            createdesc+="<br>" ;
	        }
	        
	%><b><%=createdesc%>&nbsp;</b> 
    </td>
    <TD><%=SystemEnv.getHtmlLabelName(77,user.getLanguage())+SystemEnv.getHtmlLabelName(385,user.getLanguage())%></TD><!-- ����Ȩ�� -->
    <td>
	<%
	        //����Ȩ��
	        String copydesc="";
	        rs.executeProc("Doc_DirAcl_SByDirID",""+seccategoryid+Util.getSeparator()+AclManager.CATEGORYTYPE_SEC+Util.getSeparator()+AclManager.OPERATION_COPYDOC);    
	
	        while(rs.next()){
	            //���� + ��ȫ����
	            if(rs.getInt("permissiontype")==1)	{
	                 copydesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage())+","+Util.toScreen(DepartmentComInfo.getDepartmentname(rs.getString("departmentid")),user.getLanguage())+"/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //��ɫ + ��ȫ���� + ����
	            if(rs.getInt("permissiontype")==2)	{
	                 copydesc+=SystemEnv.getHtmlLabelName(122,user.getLanguage())+","+Util.toScreen(RolesComInfo.getRolesname(rs.getString("roleid")),user.getLanguage())+"/";
	                if(rs.getInt("rolelevel")==0){
	                    copydesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage());
	                }
	                if(rs.getInt("rolelevel")==1){
	                    copydesc+=SystemEnv.getHtmlLabelName(141,user.getLanguage());
	                }
	                if(rs.getInt("rolelevel")==2){
	                    copydesc+=SystemEnv.getHtmlLabelName(140,user.getLanguage());
	                }
	
	                    copydesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //��ȫ����
	            if(rs.getInt("permissiontype")==3)	{
	                 copydesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+","+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	            }
	            //�û����� + ��ȫ����
	            if(rs.getInt("permissiontype")==4)	{
	                 copydesc+=SystemEnv.getHtmlLabelName(7179,user.getLanguage())+",";
	                 if(rs.getInt("usertype")==0){
	                   copydesc+=SystemEnv.getHtmlLabelName(131,user.getLanguage()).trim();
	                 }
	                 else{
	                   copydesc+=CustomerTypeComInfo.getCustomerTypename(rs.getString("usertype"));
	                 }
	                 copydesc+="/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
	
	            }
	            //������Դ
	            if(rs.getInt("permissiontype")==5)	{
	                 copydesc+=SystemEnv.getHtmlLabelName(179,user.getLanguage())+","+Util.toScreen(ResourceComInfo.getResourcename(rs.getString("userid")),user.getLanguage());
	            }
	            copydesc+="<br>" ;
	        }
	        
	%><b><%=copydesc%>&nbsp;</b>
    </td>
    <TD><%=SystemEnv.getHtmlLabelName(78,user.getLanguage())+SystemEnv.getHtmlLabelName(385,user.getLanguage())%></TD><!-- �ƶ�Ȩ�� -->
    <td>
	<%
        //�ƶ�Ȩ��
        String movedesc="";
        rs.executeProc("Doc_DirAcl_SByDirID",""+seccategoryid+Util.getSeparator()+AclManager.CATEGORYTYPE_SEC+Util.getSeparator()+AclManager.OPERATION_MOVEDOC);    

        while(rs.next()){
            //���� + ��ȫ����
            if(rs.getInt("permissiontype")==1)	{
                 movedesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage())+","+Util.toScreen(DepartmentComInfo.getDepartmentname(rs.getString("departmentid")),user.getLanguage())+"/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
            }
            //��ɫ + ��ȫ���� + ����
            if(rs.getInt("permissiontype")==2)	{
                 movedesc+=SystemEnv.getHtmlLabelName(122,user.getLanguage())+","+Util.toScreen(RolesComInfo.getRolesname(rs.getString("roleid")),user.getLanguage())+"/";
                if(rs.getInt("rolelevel")==0){
                    movedesc+=SystemEnv.getHtmlLabelName(124,user.getLanguage());
                }
                if(rs.getInt("rolelevel")==1){
                    movedesc+=SystemEnv.getHtmlLabelName(141,user.getLanguage());
                }
                if(rs.getInt("rolelevel")==2){
                    movedesc+=SystemEnv.getHtmlLabelName(140,user.getLanguage());
                }

                    movedesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
            }
            //��ȫ����
            if(rs.getInt("permissiontype")==3)	{
                 movedesc+=SystemEnv.getHtmlLabelName(683,user.getLanguage())+","+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());
            }
            //�û����� + ��ȫ����
            if(rs.getInt("permissiontype")==4)	{
                 movedesc+=SystemEnv.getHtmlLabelName(7179,user.getLanguage())+",";
                 if(rs.getInt("usertype")==0){
                   movedesc+=SystemEnv.getHtmlLabelName(131,user.getLanguage()).trim();
                 }
                 else{
                   movedesc+=CustomerTypeComInfo.getCustomerTypename(rs.getString("usertype"));
                 }
                 movedesc+="/"+SystemEnv.getHtmlLabelName(683,user.getLanguage())+":"+Util.toScreen(rs.getString("seclevel"),user.getLanguage());

            }
            //������Դ
            if(rs.getInt("permissiontype")==5)	{
                 movedesc+=SystemEnv.getHtmlLabelName(179,user.getLanguage())+","+Util.toScreen(ResourceComInfo.getResourcename(rs.getString("userid")),user.getLanguage());
            }
            movedesc+="<br>" ;
        }
        
	%><b><%=movedesc%>&nbsp;</b>
    </td>
    <TD><%=SystemEnv.getHtmlLabelName(15059,user.getLanguage())%></TD><!-- Ĭ�Ϲ��� -->
    <td>
	<%
        String sharedesc="" ;
		//���Ŀ¼���ĵ���������ص�Ȩ��
		String PCreater = "3";
		String PCreaterManager = "1";
		String PCreaterJmanager = "1";
		String PCreaterDownOwner = "0";
		String PCreaterSubComp = "0";
		String PCreaterDepart = "0";
		String PCreaterDownOwnerLS = "0";
		String PCreaterSubCompLS = "0";
		String PCreaterDepartLS = "0";
	
		String PCreaterW = "3";
		String PCreaterManagerW = "1";
		String PCreaterJmanagerW = "1";
		
		String PCreaterDL = "1";
		String PCreaterManagerDL = "1";
		String PCreaterSubCompDL = "0";
		String PCreaterDepartDL = "0";
		String PCreaterWDL = "1";
		String PCreaterManagerWDL = "1";
	
		rs.executeSql("select * from secCreaterDocPope where secid = "+seccategoryid);
		if (rs.next()) {
		    PCreater = Util.null2String(rs.getString("PCreater"));
		    PCreaterManager = Util.null2String(rs.getString("PCreaterManager"));
		    PCreaterJmanager = Util.null2String(rs.getString("PCreaterJmanager"));
		    PCreaterDownOwner = Util.null2String(rs.getString("PCreaterDownOwner"));
		    PCreaterSubComp = Util.null2String(rs.getString("PCreaterSubComp"));
		    PCreaterDepart = Util.null2String(rs.getString("PCreaterDepart"));
		    PCreaterDownOwnerLS = Util.null2String(rs.getString("PCreaterDownOwnerLS"));   
		    PCreaterSubCompLS = Util.null2String(rs.getString("PCreaterSubCompLS"));   
		    PCreaterDepartLS = Util.null2String(rs.getString("PCreaterDepartLS"));
		    PCreaterW = Util.null2String(rs.getString("PCreaterW"));
		    PCreaterManagerW = Util.null2String(rs.getString("PCreaterManagerW"));
		    PCreaterJmanagerW = Util.null2String(rs.getString("PCreaterJmanagerW"));
		    
		    /** TD12005 �ĵ�����Ȩ�޿���    ��ʼ ======���ݿ���������ֶ�========== */
		    PCreaterDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterDL")), PCreater);
		    PCreaterManagerDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterManagerDL")), PCreaterManager);
		    PCreaterSubCompDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterSubCompDL")), PCreaterSubComp);
		    PCreaterDepartDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterDepartDL")), PCreaterDepart);
		    PCreaterWDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterWDL")), PCreaterW);
		    PCreaterManagerWDL = this.setDLValueInit(Util.null2String(rs.getString("PCreaterManagerWDL")), PCreaterManagerW);
		    /** TD12005 �ĵ�����Ȩ�޿���   ���� */
		}
		//Ĭ�Ϲ���(���ĵ���������� �ڲ���Ա)
		if(!"0".equals(PCreater)||!"0".equals(PCreaterManager)||!"0".equals(PCreaterSubComp)||!"0".equals(PCreaterDepart))
			sharedesc+="<span style='color: red;'>"+SystemEnv.getHtmlLabelName(18589,user.getLanguage())+"</span><br>";
		//�ĵ�������
		if(!"0".equals(PCreater))
			sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(18582,user.getLanguage())+"/";
        if("1".equals(PCreater))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreater))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>";
        if("3".equals(PCreater))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
        //������ֱ���ϼ�
        if(!"0".equals(PCreaterManager))
        	sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(18583,user.getLanguage())+"/";
        if("1".equals(PCreaterManager))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterManagerDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreaterManager))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>";
        if("3".equals(PCreaterManager))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
      	//�����˱��ֲ�
      	if(!"0".equals(PCreaterSubComp))
        	sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(18584,user.getLanguage())+"/";
        if("1".equals(PCreaterSubComp))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterSubCompDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreaterSubComp))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>";
        if("3".equals(PCreaterSubComp))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
        //�����˱�����
        if(!"0".equals(PCreaterDepart))
        	sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(15081,user.getLanguage())+"/";
        if("1".equals(PCreaterDepart))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterDepartDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreaterDepart))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>";
        if("3".equals(PCreaterDepart))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
        //Ĭ�Ϲ���(���ĵ���������� �ⲿ��Ա)
        if(!"0".equals(PCreaterW)||!"0".equals(PCreaterManagerW))
        	sharedesc+="<span style='color: red;'>"+SystemEnv.getHtmlLabelName(2209,user.getLanguage())+"</span><br>";
        	
        //�ĵ�������
    	if(!"0".equals(PCreaterW))
    		sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(18582,user.getLanguage())+"/";
        if("1".equals(PCreaterW))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterWDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreaterW))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>"; 
        if("3".equals(PCreaterW))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
        //�����˾���
        if(!"0".equals(PCreaterManagerW))
    		sharedesc+="&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(15080,user.getLanguage())+"/";
        if("1".equals(PCreaterManagerW))
        {
        	sharedesc+=SystemEnv.getHtmlLabelName(367,user.getLanguage());
        	if("1".equals(PCreaterManagerWDL))
        	{
        		sharedesc+=":"+SystemEnv.getHtmlLabelName(23733,user.getLanguage());
        	}
        	sharedesc+="<br>";
        }
        if("2".equals(PCreaterManagerW))sharedesc+=SystemEnv.getHtmlLabelName(93,user.getLanguage())+"<br>";
        if("3".equals(PCreaterManagerW))sharedesc+=SystemEnv.getHtmlLabelName(17874,user.getLanguage())+"<br>";
        
        rs.executeProc("DocSecCategoryShare_SBySecID",seccategoryid);  
        if(rs.next())
        {
        	sharedesc+="<span style='color: red;'>"+SystemEnv.getHtmlLabelName(375,user.getLanguage())+"</span><br>";
        }
        rs.beforFirst();
        while(rs.next()){
            int sharetype=rs.getInt("sharetype");
            String userid=rs.getString("userid");
            int sharelevel=rs.getInt("sharelevel");
            String departmentid=rs.getString("departmentid");
            String seclevel=rs.getString("seclevel");
            String roleid=rs.getString("roleid");
            int rolelevel=rs.getInt("rolelevel");
            String strDownload = "";
		        if (noDownload != 1 && Util.getIntValue(Util.null2String(rs.getString("downloadlevel")), 0) == 1) {
		        	strDownload = ":" + SystemEnv.getHtmlLabelName(23733,user.getLanguage());
		        }
            if(sharetype==1){
            	sharedesc+="&nbsp;&nbsp;";
                sharedesc+= SystemEnv.getHtmlLabelName(179,user.getLanguage()) ;
                sharedesc+=ResourceComInfo.getResourcename(userid)+"/" ;
                if(sharelevel==1)   sharedesc+= SystemEnv.getHtmlLabelName(367,user.getLanguage())+ strDownload  ; 
                if(sharelevel==2)   sharedesc+= SystemEnv.getHtmlLabelName(93,user.getLanguage())  ; 
                sharedesc+="<br>" ;
            }
            if(sharetype==3){
            	sharedesc+="&nbsp;&nbsp;";
                sharedesc+=DepartmentComInfo.getDepartmentname(departmentid)+":";
                sharedesc+= SystemEnv.getHtmlLabelName(683,user.getLanguage())+">=" +seclevel +"/" ;
                if(sharelevel==1)   sharedesc+= SystemEnv.getHtmlLabelName(367,user.getLanguage())+ strDownload  ; 
                if(sharelevel==2)   sharedesc+= SystemEnv.getHtmlLabelName(93,user.getLanguage())  ; 
                sharedesc+="<br>" ;
            }
            if(sharetype==4){
            	sharedesc+="&nbsp;&nbsp;";
                sharedesc+=RolesComInfo.getRolesname(roleid)+":";
                if(rolelevel==0)    sharedesc+= SystemEnv.getHtmlLabelName(15062,user.getLanguage()) +"/" ; 
                if(rolelevel==1)    sharedesc+= SystemEnv.getHtmlLabelName(15063,user.getLanguage()) +"/" ;
                if(rolelevel==2)    sharedesc+= SystemEnv.getHtmlLabelName(15064,user.getLanguage()) +"/" ;
                if(sharelevel==1)   sharedesc+= SystemEnv.getHtmlLabelName(367,user.getLanguage())+ strDownload ; 
                if(sharelevel==2)   sharedesc+= SystemEnv.getHtmlLabelName(93,user.getLanguage()) ; 
                sharedesc+="<br>" ;
            }
            if(sharetype==5){
            	sharedesc+="&nbsp;&nbsp;";
                sharedesc+= SystemEnv.getHtmlLabelName(1340,user.getLanguage()) +":";
                sharedesc+= SystemEnv.getHtmlLabelName(683,user.getLanguage())+">=" +seclevel +"/" ;
                if(sharelevel==1)   sharedesc+= SystemEnv.getHtmlLabelName(367,user.getLanguage())+ strDownload ; 
                if(sharelevel==2)   sharedesc+= SystemEnv.getHtmlLabelName(93,user.getLanguage()) ; 
                sharedesc+="<br>" ;
            }
            if(sharetype<0){
            	sharedesc+="&nbsp;&nbsp;";
                String crmtype= "" + ((-1)*RecordSet.getInt("sharetype")) ;
	    		String crmtypename=CustomerTypeComInfo.getCustomerTypename(crmtype);
                sharedesc+=crmtypename+":";
                sharedesc+= SystemEnv.getHtmlLabelName(683,user.getLanguage())+">="+seclevel +"/" ;
                if(sharelevel==1)   sharedesc+= SystemEnv.getHtmlLabelName(367,user.getLanguage())+ strDownload  ; 
                if(sharelevel==2)   sharedesc+= SystemEnv.getHtmlLabelName(93,user.getLanguage())  ; 
                sharedesc+="<br>" ;
            }
        }
	%><b><%=sharedesc%>&nbsp;</b>
    </td>
    <TD><%=SystemEnv.getHtmlLabelName(18095,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(19450,user.getLanguage())%></TD><!-- ���ð汾���� -->
    <TD><b><%if(editionIsOpen==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
  </tr>
   
  <TR class=Header>
  	<TD><%=SystemEnv.getHtmlLabelName(19415,user.getLanguage())%></TD><!-- ������Ŀ¼������� -->
    <TD><b>
    <%
    rs.executeSql("select * from codemain where id="+seccategoryid);
    String isUse = Util.null2String(rs.getString("isUse"));
    if(isUse.equals("1")){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b>
    </TD>
  	<TD><%=SystemEnv.getHtmlLabelName(506,user.getLanguage())%></TD><!-- �ĵ�ģ�� -->
    <TD><b><a href="/docs/mould/DocMouldDsp.jsp?id=<%=docmouldid%>"><%=DocMouldComInfo.getDocMouldname(docmouldid)%></a>&nbsp;</b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(15058,user.getLanguage())%></TD><!-- �������� -->
    <TD><b><a href="basedata_workflow.jsp?wfid=<%=approvewfid%>"><%=WorkflowComInfo.getWorkflowname(approvewfid)%></a>&nbsp;</b></TD>
    <TD><%=SystemEnv.getHtmlLabelName(18095,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20237,user.getLanguage())%></TD><!-- �����Զ����б� -->
	<TD><b><%if(useCustomSearch==1){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%> <%} else {%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%> <%}%></b></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
    <TD></TD>
  </tr>
  <tr style="width:100%;">
	  <TD colspan="14">
		  <TABLE class=ListStyle cellspacing=1>
		       <colgroup>
		       <col width="30%">
		       <col width="30%">
		       <col width="30%">
		       <tr class=header>
		           <td colSpan=3><%=SystemEnv.getHtmlLabelName(22256,user.getLanguage())%></td><!-- ���� -->
		       </tr>
		       <tr class=header>
		            <td><%=SystemEnv.getHtmlLabelName(15795,user.getLanguage())%></td><!-- �������� -->
		            <td><%=SystemEnv.getHtmlLabelName(104,user.getLanguage())%></td><!-- ���� -->
		            <td><%=SystemEnv.getHtmlLabelName(17607,user.getLanguage())%></td><!-- �Զ������� -->
		        </tr>
		       <tr>
		      		<td><%=SystemEnv.getHtmlLabelName(16173,user.getLanguage())%></td>
		      		<td class=field>
		      		<%
		      		if(hasasset.equals("1"))
		      		{
		      		%>
		      		<%=SystemEnv.getHtmlLabelName(16174,user.getLanguage())%>
		      		<%
		      		}
		      		else if(hasasset.equals("0"))
		      		{
		      		%>
		      		<%=SystemEnv.getHtmlLabelName(16175,user.getLanguage())%>
		      		<%
		      		}
		      		else if(hasasset.equals("2"))
		      		{
		      		%>
		      		<%=SystemEnv.getHtmlLabelName(16176,user.getLanguage())%>
		      		<%
		      		} 
		      		%>
		      		</td>
		      		<td class=field>
		      			<%=Util.toScreenToEdit(assetlabel,user.getLanguage())%>
		      		</td>
		      	</tr>
		      	<TR><TD class=Line colSpan=3></TD></TR>
		      	<tr>
		      		<td><%=SystemEnv.getHtmlLabelName(16177,user.getLanguage())%></td>
		      		<td class=field>
			       		<%if(hashrmres.equals("1")){%><%=SystemEnv.getHtmlLabelName(16174,user.getLanguage())%><%}%>
			       		<%if(hashrmres.equals("0")){%><%=SystemEnv.getHtmlLabelName(16175,user.getLanguage())%><%}%>
			       		<%if(hashrmres.equals("2")){%><%=SystemEnv.getHtmlLabelName(16176,user.getLanguage())%><%}%>
		      		</td>
		      		<td class=field>
		      			<%=Util.toScreenToEdit(hrmreslabel,user.getLanguage())%>
		      		</td>
		      	</tr>
		      	<TR><TD class=Line colSpan=3></TD></TR>
		      	<tr>
		      		<td>CRM<%=SystemEnv.getHtmlLabelName(160,user.getLanguage())%></td>
		      		<td class=field>
			       		<%if(hascrm.equals("1")){%><%=SystemEnv.getHtmlLabelName(16174,user.getLanguage())%><%}%>
			       		<%if(hascrm.equals("0")){%><%=SystemEnv.getHtmlLabelName(16175,user.getLanguage())%><%}%>
			       		<%if(hascrm.equals("2")){%><%=SystemEnv.getHtmlLabelName(16176,user.getLanguage())%><%}%>
		      		</td>
		      		<td class=field>
		      			<%=Util.toScreenToEdit(crmlabel,user.getLanguage())%>
		      		</td>
		      	</tr>
			<TR><TD class=Line colSpan=3></TD></TR>
		      	<tr>
		      		<td><%=SystemEnv.getHtmlLabelName(16178,user.getLanguage())%></td>
		      		<td class=field>
			       		<%if(hasproject.equals("1")){%><%=SystemEnv.getHtmlLabelName(16174,user.getLanguage())%><%}%>
			       		<%if(hasproject.equals("0")){%><%=SystemEnv.getHtmlLabelName(16175,user.getLanguage())%><%}%>
			       		<%if(hasproject.equals("2")){%><%=SystemEnv.getHtmlLabelName(16176,user.getLanguage())%><%}%>
		      		</td>
		      		<td class=field>
		      			<%=Util.toScreenToEdit(projectlabel,user.getLanguage())%>
		      		</td>
		      	</tr>
			<TR><TD class=Line colSpan=3></TD></TR>
		  </TABLE>
	  </td>
  </tr>
  <TR class=Line><TD colspan="14"></TD></TR>
<%
    }
%>  
    </tbody>
    </table>

			
			</td>
			</tr>
			<TR class=separator><TD class=Sep1 colSpan=14 ></TD></TR>
			<TR>
				<TD colspan="14">
					<DIV class=xTable_info>
					<DIV>
						<TABLE width="100%">
							<TBODY>
								<TR>
									<TD></TD>
									<TD>
										<DIV align=right>
											<input id=currentpage name=currentpage type="hidden" value="<%=pagepos %>">
											<%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%><!-- �� --><%=countsize%><%=SystemEnv.getHtmlLabelName(18256,user.getLanguage())%><!-- �� --><%=SystemEnv.getHtmlLabelName(264,user.getLanguage())%><!-- ��¼ -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(265,user.getLanguage())%><!-- ÿҳ -->10<%=SystemEnv.getHtmlLabelName(18256,user.getLanguage())%><!-- �� -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%><!-- �� --><%=pagesizes %><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(524,user.getLanguage())%><!-- ��ǰ --><%=SystemEnv.getHtmlLabelName(15323,user.getLanguage())%><!-- �� --><%=pagepos %><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->&nbsp;&nbsp;
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('f')"><SPAN><%=SystemEnv.getHtmlLabelName(18363,user.getLanguage())%><!-- ��ҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('u')"><SPAN><%=SystemEnv.getHtmlLabelName(1258,user.getLanguage())%><!-- ��һҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('d')"><SPAN><%=SystemEnv.getHtmlLabelName(1259,user.getLanguage())%><!-- ��һҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none" id=pagelast onclick="goToPage('l')"><SPAN><%=SystemEnv.getHtmlLabelName(18362,user.getLanguage())%><!-- βҳ --></SPAN>
											</A>&nbsp;
											<BUTTON id=goPageBotton onclick="goPage()">
												<%=SystemEnv.getHtmlLabelName(23162,user.getLanguage())%><!-- ת�� -->
											</BUTTON>
											&nbsp;<%=SystemEnv.getHtmlLabelName(15323,user.getLanguage())%><!-- �� --><INPUT style="TEXT-ALIGN: right" id=gopage name=gopage class=text value=<%=pagepos %> size=2><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->
										</DIV>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</DIV>
				</DIV>
				</TD>
			</TR>
			
			</TABLE>
			
			</td>
			<td></td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
<iframe id="iframeExcel" style="display: none"></iframe>
</BODY></HTML>
<script language=javascript>
function onSearch(){
	frmmain.submit();
}
function doSearchAgain()
{
	document.location.href = "basedata_doc.jsp";
}
function doBack()
{
	document.location.href = "basedata.jsp";
}
function goChoose(type){
	document.frmmain.type.value=type;
}
function goToPage(forward)
{
	var currentpage = document.getElementById("currentpage").value;
	var actionpage = "";
	if(forward=="f")
	{
		actionpage = 1;
	}
	else if(forward=="u")
	{
		actionpage = currentpage*1-1;
	}
	else if(forward=="d")
	{
		actionpage = currentpage*1+1;
	}
	else if(forward=="l")
	{
		actionpage = '<%=pagesizes %>';
	}
	document.frmmain.pagepos.value=actionpage;
	frmmain.submit();
}
function goPage()
{
	var gopage = document.getElementById("gopage").value;
	if(gopage=="")
	{
		gopage = "1";
	}
	document.frmmain.pagepos.value=gopage;
	frmmain.submit();
}
function exportXSL()
{
	document.getElementById("iframeExcel").src = "/system/basedata/basedata_docexcel.jsp?pagepos=<%=pagepos%>&type=<%=type%>&mainid=<%=mainid%>&subid=<%=subid%>&secid=<%=secid%>";
}
</script>