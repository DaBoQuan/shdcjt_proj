<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,weaver.general.TimeUtil,java.util.*,java.math.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="JobActivitiesComInfo" class="weaver.hrm.job.JobActivitiesComInfo" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<%
boolean canView = true;//�ɲ鿴

String fnabudgetinfoid = Util.null2String(request.getParameter("fnabudgetinfoid"));//ID
String organizationid = "";//��֯ID
String organizationtype = "";//��֯����
String budgetperiods = "";//�ڼ�ID
String budgetyears = "";//�ڼ���

String sqlstr = "";
char separator = Util.getSeparator() ;
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);

if(fnabudgetinfoid!=null&&!"".equals(fnabudgetinfoid)) {
	sqlstr =" select budgetperiods,budgetorganizationid,organizationtype,budgetstatus,revision,status from FnaBudgetInfo where id = " + fnabudgetinfoid;
	RecordSet.executeSql(sqlstr);
	if(RecordSet.next()) {
		budgetperiods = RecordSet.getString("budgetperiods");
		organizationid = RecordSet.getString("budgetorganizationid");
		organizationtype = RecordSet.getString("organizationtype");
	}
} else {
    canView = false;
}

//ȡ��ǰ�ڼ�����
if("".equals(budgetyears)) {
	sqlstr = " select fnayear from FnaYearsPeriods where id = " + budgetperiods;
	RecordSet.executeSql(sqlstr);
	if(RecordSet.next()) {
		budgetyears = RecordSet.getString("fnayear");
	}
}

//���Ȩ��
    int right = -1;//-1����ֹ��0��ֻ����1���༭��2����ȫ����
    if ("0".equals(organizationtype)) {
        if (HrmUserVarify.checkUserRight("HeadBudget:Maint", user)) right = Util.getIntValue(HrmUserVarify.getRightLevel("HeadBudget:Maint", user),0);
    } else {
        if (Util.getIntValue(String.valueOf(session.getAttribute("detachable")), 0) == 1) {//�����Ȩ
            int subCompanyId = 0;
            if("1".equals(organizationtype))
                subCompanyId = (new Integer(organizationid)).intValue();
            else if("2".equals(organizationtype))
                subCompanyId = (new Integer(DepartmentComInfo.getSubcompanyid1(organizationid))).intValue();
            else if("3".equals(organizationtype))
                 subCompanyId = (new Integer(DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(organizationid)))).intValue();
            right = CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(), "SubBudget:Maint",subCompanyId);
        } else {
            if (HrmUserVarify.checkUserRight("SubBudget:Maint", user))
                right = Util.getIntValue(HrmUserVarify.getRightLevel("SubBudget:Maint", user),0);
        }
    }
    if (right < 0) canView = false;//�ɲ鿴

    if (!canView) {
        response.sendRedirect("/notice/noright.jsp");
        return;
    }

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(18552,user.getLanguage());
String needfav ="1";
String needhelp ="";

double tmpnum = 0d;
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<style>
#tabPane tr td{padding-top:2px}
#monthHtmlTbl td,#seasonHtmlTbl td{cursor:hand;text-align:center;padding:0 2px 0 2px;color:#333;text-decoration:underline}
.cycleTD{font-family:MS Shell Dlg,Arial;background-image:url(/images/tab2.png);cursor:hand;font-weight:bold;text-align:center;color:#666;border-bottom:1px solid #879293;}
.cycleTDCurrent{font-family:MS Shell Dlg,Arial;padding-top:2px;background-image:url(/images/tab.active2.png);cursor:hand;font-weight:bold;text-align:center;color:#666}
.seasonTDCurrent,.monthTDCurrent{color:black;font-weight:bold;background-color:#CCC}
#subTab{border-bottom:1px solid #879293;padding:0}
#goalGroupStatus{text-align:center;color:black;font-weight: bold}
</style>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onBack(),_self} " ;
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

<FORM id="frmMain" name="frmMain" action="FnaBudgetView.jsp" method=post>
    <input type="hidden" name="fnabudgetinfoid" value="<%=fnabudgetinfoid%>">

<!--��ͷ ��ʼ-->

<TABLE class ="ViewForm">
	<TBODY>
	<colgroup>
    <col width="100%">
    <TR>
	    <TH class=Title> 
	    <%
	    String fnatitle = "<font size=\"3\">";
	    if("0".equals(organizationtype))
		fnatitle+=(Util.toScreen(CompanyComInfo.getCompanyname(organizationid),user.getLanguage()));
	    if("1".equals(organizationtype)) fnatitle+=(Util.toScreen(SubCompanyComInfo.getSubCompanyname(organizationid),user.getLanguage()));
	    if("2".equals(organizationtype)) fnatitle+=(Util.toScreen(DepartmentComInfo.getDepartmentname(organizationid),user.getLanguage()));
	    if("3".equals(organizationtype)) fnatitle+=(Util.toScreen(ResourceComInfo.getResourcename(organizationid),user.getLanguage()));
		fnatitle+=budgetyears;
		fnatitle+=SystemEnv.getHtmlLabelName(15375,user.getLanguage());
	    fnatitle+="</font>";
	    out.println(fnatitle);
	    %>
		</TH>
  	</TR>
  	
    <TR class=Spacing> 
      <TD class=Sep1></TD>
    </TR>
    
    <tr><td></td></tr>    
    
</TABLE>

<!--��ͷ ����-->

<TABLE width=100% class=ListStyle cellspacing=1>
  <COLGROUP> 
    <col width="15%">
    <col width="20%">
    <col width="25%">
    <col width="25%">
    <col width="*">
  <THEAD> 
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%><%--���--%></th>
  <th><%=SystemEnv.getHtmlLabelName(460,user.getLanguage())%><%--����--%></th>
  <th><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%><%--��λ--%></th>
  <th><%=SystemEnv.getHtmlLabelName(1915,user.getLanguage())%><%--ְ��--%></th>
  <th><%=SystemEnv.getHtmlLabelName(18501,user.getLanguage())%><%--Ԥ���ܶ�--%></th>        
  </tr>
  <TR class=Line><TD colspan="17" ></TD></TR> 
  </THEAD>
<%
	boolean isLight = false;
	RecordSet.executeSql(
            " SELECT h.id, h.workcode, h.lastname, h.jobtitle, k.budgetaccount "
            +" FROM HrmResource h LEFT JOIN "
            +" ( "
            +" SELECT a.budgetorganizationid, a.organizationtype, a.budgetperiods, SUM(b.budgetaccount) AS budgetaccount "
            +" FROM FnaBudgetInfo a LEFT JOIN "
            +" FnaBudgetInfoDetail b "
            +" ON a.id = b.budgetinfoid "
            +" WHERE (a.budgetperiods = " + budgetperiods + ") "
            +" and a.organizationtype = 3 "
            +" and a.status IN (1, 3) "
            +" GROUP BY a.id, a.budgetorganizationid, a.organizationtype, a.budgetperiods "
            +" ) k "
            +" ON h.id = k.budgetorganizationid AND k.organizationtype = 3 "
            +" WHERE (h.departmentid = " + organizationid + ") AND (h.status IN (0, 1, 2, 3)) "
            +" GROUP BY h.id, h.workcode, h.lastname, h.jobtitle, k.budgetaccount "
            +" ORDER BY h.id DESC ");
	while(RecordSet.next()) {
            String tmpuserid = Util.null2String(RecordSet.getString("id"));
            String tmpworkcode = Util.null2String(RecordSet.getString("workcode"));
            String tmplastname = Util.null2String(RecordSet.getString("lastname"));
            String tmpjobtitle = JobTitlesComInfo.getJobTitlesname(RecordSet.getString("jobtitle"));
            String tmpjobactivities = JobActivitiesComInfo.getJobActivitiesname(JobTitlesComInfo.getJobactivityid(RecordSet.getString("jobtitle")));
            String budgetaccount = Util.null2o(RecordSet.getString("budgetaccount"));
            isLight = !isLight;
%>
	<TR class="<%=(isLight?"datalight":"datadark")%>">
        <TD><%=tmpworkcode%></TD>
        <TD><a href="FnaBudgetView.jsp?organizationid=<%=tmpuserid%>&organizationtype=3&budgetperiods=<%=budgetperiods%>"><%=tmplastname%></TD>
        <TD><%=tmpjobtitle%></TD>
        <TD><%=tmpjobactivities%></TD>
	<TD ALIGN="RIGHT"><%=budgetaccount+SystemEnv.getHtmlLabelName(15279,user.getLanguage())%></TD>
	</TR>
<%
	}
%>
	<TR class=Line><TD colspan="17" ></TD></TR>
  </TBODY> 
</TABLE>

</FORM>
	
</td></tr>
<tr><td colspan="5">&nbsp;</td></tr>
<tr><td colspan="5">&nbsp;</td></tr>
</table>

</td>
</tr>
</TABLE>

</td>
<td></td>
</tr>
<tr>
<td height="5" colspan="3"></td>
</tr>
</table>

<script language=javascript>
function onBack(){
    location.href="FnaBudgetView.jsp?fnabudgetinfoid=<%=fnabudgetinfoid%>";
    //document.frmMain.action="FnaBudgetView.jsp";
    //document.frmMain.submit();
}
</script>



</BODY>
</HTML>