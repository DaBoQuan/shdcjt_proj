<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
char separator = Util.getSeparator() ;
String departmentid = Util.null2String(request.getParameter("departmentid"));
String resourceid = Util.null2String(request.getParameter("resourceid"));
String budgettypeid = Util.null2String(request.getParameter("budgettypeid")) ;
String budgetstatus = Util.null2String(request.getParameter("budgetstatus"));
String fnayear = Util.null2String(request.getParameter("fnayear")) ;
String budgetinfoid = Util.null2String(request.getParameter("budgetinfoid")) ;


String imagefilename = "/images/hdFIN.gif";
String titlename = SystemEnv.getHtmlLabelName(386 , user.getLanguage());
String needfav = "1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onReturn(),_TOP} " ;
RCMenuHeight += RCMenuHeightStep ;
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

<form id=frmMain name=frmMain method=post action=FnaBudgetEdit.jsp>
  <TABLE class=ListStyle cellspacing=1 >
    <COLGROUP> 
	<COL width="30%"> 
	<COL width="10%"> 
	<COL width="10%"> 
	<COL width="10%"> 
	<COL width="10%"> 
	<COL width="30%"> 
    <THEAD> 
    <TR class=Header> 
    <TH colspan="3"> 
    <%=Util.toScreen(ResourceComInfo.getResourcename(resourceid) , user.getLanguage())%> - <%=Util.toScreen(BudgetfeeTypeComInfo.getBudgetfeeTypename(budgettypeid) , user.getLanguage())%>
    </TH>
    <TH colSpan=3 style="TEXT-ALIGN: right">
    <%=SystemEnv.getHtmlLabelName(15365,user.getLanguage())%>:<%=fnayear%>
    </TH>
  </TR>
  </THEAD> <TBODY> 
     <TR class=Header> 
      <TD><%=SystemEnv.getHtmlLabelName(446,user.getLanguage())%></TD>
      <TD><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></TD>
      <TD>CRM</TD>
      <TD><%=SystemEnv.getHtmlLabelName(101,user.getLanguage())%></TD>
	  <TD><%=SystemEnv.getHtmlLabelName(534,user.getLanguage())%></TD>
	  <TD><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></TD>
    </TR>
    <TR class=Line><TD colspan="6" ></TD></TR> 
<%
if( !budgetinfoid.equals("") ) {
    RecordSet.executeSql(" select * from FnaBudgetInfoDetail " +
                         " where budgetinfoid = " + budgetinfoid + " and budgettypeid = " +
                         budgettypeid + " and  budgetresourceid =" + resourceid + 
                         " order by budgetperiods ");

    boolean isLight = false;
    boolean budgetperiodsdisplay = false ;
    String tempbudgetperiods = "" ;
    
    while(RecordSet.next()) {
        String budgetperiods = Util.null2String(RecordSet.getString("budgetperiods"));
        String budgetstartdate = Util.null2String(RecordSet.getString("budgetstartdate"));
        String budgetenddate = Util.null2String(RecordSet.getString("budgetenddate"));
        String budgetcrmid = Util.null2String(RecordSet.getString("budgetcrmid"));
        String budgetresourceid = Util.null2String(RecordSet.getString("budgetresourceid"));
        String budgetprojectid = Util.null2String(RecordSet.getString("budgetprojectid"));
        String budgetaccount = Util.null2String(RecordSet.getString("budgetaccount"));
        String budgetremarks = Util.toScreen(RecordSet.getString("budgetremark"),user.getLanguage()) ;
        isLight = !isLight ;
        budgetperiodsdisplay = false ;
        if( ! tempbudgetperiods.equals( budgetperiods ) ) {
            tempbudgetperiods = budgetperiods ;
            budgetperiodsdisplay = true ;
        }
%>
    <tr class='<%=( isLight ? "datalight" : "datadark" )%>'> 
      <td><nobr><% if(budgetperiodsdisplay) {%><%=SystemEnv.getHtmlLabelName(446,user.getLanguage())%><%=budgetperiods%>: <%=budgetstartdate%> ~ <%=budgetenddate%><%}%></td>
      <td><nobr><%=Util.toScreen(ResourceComInfo.getResourcename(budgetresourceid),user.getLanguage())%></td>
      <td><nobr><%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(budgetcrmid),user.getLanguage())%>
      </td>
      <td><nobr>
	  <%=Util.toScreen(ProjectInfoComInfo.getProjectInfoname(budgetprojectid),user.getLanguage())%>
      </td>
	  <td style="TEXT-ALIGN: right"><nobr><%=budgetaccount%></td>
	  <td><nobr><%=budgetremarks%></td>
    </tr>
<%  } }%>
</tbody> 
</table>
</form>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>

<form id=frmMainReturn name=frmMainReturn method=post action=FnaBudgetResourceDetail.jsp>
  <input type=hidden name="resourceid" value="<%=resourceid%>">
  <input type=hidden name="fnayear" value="<%=fnayear%>">
</form>
<script language=javascript>
function onReturn() {
    document.frmMainReturn.submit();
}
</script>
</body>
</html>