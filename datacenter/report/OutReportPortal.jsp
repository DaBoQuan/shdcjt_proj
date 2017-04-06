<%@ page language="java" contentType="text/html; charset=GBK" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ReportTypeComInfo" class="weaver.workflow.report.ReportTypeComInfo" scope="page" />
<jsp:useBean id="FormComInfo" class="weaver.workflow.form.FormComInfo" scope="page" />
<jsp:useBean id="BillComInfo" class="weaver.workflow.workflow.BillComInfo" scope="page"/>

<%@ include file="/systeminfo/init.jsp" %>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%


String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(16371,user.getLanguage())+"��"+ SystemEnv.getHtmlLabelName(20829,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

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


      <TABLE  class=liststyle cellspacing=1>
        <COLGROUP>
        <COL width="50%">
        <COL width="50%">
        <TBODY>
        <TR class=header>
          <TH colSpan=2><%=SystemEnv.getHtmlLabelName(15436,user.getLanguage())%></TH></TR>
        <TR class=Header>
          <TD><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
        </TR><TR class=Line><TD colspan=2 ></TD></TR> 
		<%

		String outRepId=null;
		String outRepName=null;
		String outRepDesc=null;
		String outRepEnName=null;
		String outRepEnDesc=null;

		String trClass="DataLight";
		String outRepCategory="0";

		if(HrmUserVarify.checkUserRight("DataCenter:Maintenance", user)){ 
			RecordSet.executeProc("T_OutReport_SelectAll",outRepCategory);
		}else{
			RecordSet.executeSql("select a.outRepId,a.outRepName,a.outRepDesc,a.outRepEnName,a.outRepEnDesc from T_OutReport a, T_OutReportShare b where a.outrepid = b.outrepid and b.userid="+user.getUID()+" and b.usertype = '"+user.getLogintype()+"' and a.outRepCategory='"+outRepCategory+"'");
		}
		while(RecordSet.next()){

		 	outRepId =Util.null2String(RecordSet.getString("outRepId"));
			outRepName=Util.null2String(RecordSet.getString("outRepName"));
			outRepDesc=Util.null2String(RecordSet.getString("outRepDesc"));
			outRepEnName=Util.null2String(RecordSet.getString("outRepEnName"));
			outRepEnDesc=Util.null2String(RecordSet.getString("outRepEnDesc"));
		%>
			<tr class="<%=trClass%>"> 
          <td><a 
           href="javascript:onNewWindow('/datacenter/report/OutReportSel.jsp?outrepid=<%=outRepId%>');"><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepName:outRepEnName%></a></td>
			    <td><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepDesc:outRepEnDesc%></td>
			</tr>
		<%

			if(trClass.equals("DataLight")){
			    trClass="DataDark";
		    }else{
			    trClass="DataLight";
			}
		}
		%>
	  </TABLE>

<br>
<br>

      <TABLE  class=liststyle cellspacing=1>
        <COLGROUP>
        <COL width="50%">
        <COL width="50%">
        <TBODY>
        <TR class=header>
          <TH colSpan=2><%=SystemEnv.getHtmlLabelName(17070,user.getLanguage())%></TH></TR>
        <TR class=Header>
          <TD><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
        </TR><TR class=Line><TD colspan=2 ></TD></TR> 
		<%


		trClass="DataLight";
		outRepCategory="2";

		if(HrmUserVarify.checkUserRight("DataCenter:Maintenance", user)){ 
			RecordSet.executeProc("T_OutReport_SelectAll",outRepCategory);
		}else{
			RecordSet.executeSql("select a.outRepId,a.outRepName,a.outRepDesc,a.outRepEnName,a.outRepEnDesc from T_OutReport a, T_OutReportShare b where a.outrepid = b.outrepid and b.userid="+user.getUID()+" and b.usertype = '"+user.getLogintype()+"' and a.outRepCategory='"+outRepCategory+"'");
		}
		while(RecordSet.next()){

		 	outRepId =Util.null2String(RecordSet.getString("outRepId"));
			outRepName=Util.null2String(RecordSet.getString("outRepName"));
			outRepDesc=Util.null2String(RecordSet.getString("outRepDesc"));
			outRepEnName=Util.null2String(RecordSet.getString("outRepEnName"));
			outRepEnDesc=Util.null2String(RecordSet.getString("outRepEnDesc"));
		%>
			<tr class="<%=trClass%>"> 
          <td><a 
             href="javascript:onNewWindow('/datacenter/report/OutReportSel.jsp?outrepid=<%=outRepId%>');"><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepName:outRepEnName%></a></td>
			    <td><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepDesc:outRepEnDesc%></td>
			</tr>
		<%

			if(trClass.equals("DataLight")){
			    trClass="DataDark";
		    }else{
			    trClass="DataLight";
			}
		}
		%>
	  </TABLE>

<br>
<br>

      <TABLE  class=liststyle cellspacing=1>
        <COLGROUP>
        <COL width="50%">
        <COL width="50%">
        <TBODY>
        <TR class=header>
          <TH colSpan=2><%=SystemEnv.getHtmlLabelName(16538,user.getLanguage())%></TH></TR>
        <TR class=Header>
          <TD><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
        </TR><TR class=Line><TD colspan=2 ></TD></TR> 
		<%


		trClass="DataLight";
		outRepCategory="1";

		if(HrmUserVarify.checkUserRight("DataCenter:Maintenance", user)){ 
			RecordSet.executeProc("T_OutReport_SelectAll",outRepCategory);
		}else{
			RecordSet.executeSql("select a.outRepId,a.outRepName,a.outRepDesc,a.outRepEnName,a.outRepEnDesc from T_OutReport a, T_OutReportShare b where a.outrepid = b.outrepid and b.userid="+user.getUID()+" and b.usertype = '"+user.getLogintype()+"' and a.outRepCategory='"+outRepCategory+"'");
		}
		while(RecordSet.next()){

		 	outRepId =Util.null2String(RecordSet.getString("outRepId"));
			outRepName=Util.null2String(RecordSet.getString("outRepName"));
			outRepDesc=Util.null2String(RecordSet.getString("outRepDesc"));
			outRepEnName=Util.null2String(RecordSet.getString("outRepEnName"));
			outRepEnDesc=Util.null2String(RecordSet.getString("outRepEnDesc"));
		%>
			<tr class="<%=trClass%>"> 
          <td><a 
             href="javascript:onNewWindow('/datacenter/report/OutReportSel.jsp?outrepid=<%=outRepId%>');"><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepName:outRepEnName%></a></td>
			    <td><%=(user.getLanguage()==7||user.getLanguage()==9)?outRepDesc:outRepEnDesc%></td>
			</tr>
		<%

			if(trClass.equals("DataLight")){
			    trClass="DataDark";
		    }else{
			    trClass="DataLight";
			}
		}
		%>
	  </TABLE>

<br>
<br>

      <TABLE  class=liststyle cellspacing=1>
        <COLGROUP>
        <COL width="50%">
        <COL width="25%">
        <COL width="25%">
        <TBODY>
        <TR class=header>
          <TH colSpan=3><%=SystemEnv.getHtmlLabelName(16532,user.getLanguage())%></TH></TR>
        <TR class=Header>
          <TD><%=SystemEnv.getHtmlLabelName(15517,user.getLanguage())%></TD>
          <TD><%=SystemEnv.getHtmlLabelName(15434,user.getLanguage())%></TD>
          <TD><%=SystemEnv.getHtmlLabelName(19514,user.getLanguage())%></TD>
        </TR><TR class=Line><TD colspan=3 ></TD></TR> 
		<%

		String reportId=null;
		String reportName=null;
		String reportType=null;
		String formId=null;
		String formName=null;
		String isBill=null;
        StringBuffer sb=new StringBuffer();
		sb.append(" select t1.reportId,t2.reportName,t2.reportType,t2.formId,t2.isBill ")
		  .append("  from WorkflowReportShareDetail t1,Workflow_Report t2 ")
		  .append(" where t1.reportId=t2.id ")
		  .append("   and userId= ").append(user.getUID())
		  .append("   and userType=1 ")
		  .append("   and isShowOnReportOutput='1' ");
        RecordSet.executeSql(sb.toString());
		while(RecordSet.next()){
			reportId=Util.null2String(RecordSet.getString("reportId"));
			reportName=Util.null2String(RecordSet.getString("reportName"));
			reportType=Util.null2String(RecordSet.getString("reportType"));
			formId=Util.null2String(RecordSet.getString("formId"));
			isBill=Util.null2String(RecordSet.getString("isBill"));
		    if("0".equals(isBill)){
		        formName = FormComInfo.getFormname(formId);	
		    }else if("1".equals(isBill)){
		        formName = SystemEnv.getHtmlLabelName(Util.getIntValue(BillComInfo.getBillLabel(formId),0), user.getLanguage());
		    }

%>
        <tr class="<%=trClass%>"> 
          <td><a 
            href="javascript:onNewWindow('/workflow/report/ReportCondition.jsp?id=<%=reportId%>');"><%=reportName%></a></td>
          <td><%=ReportTypeComInfo.getReportTypename(reportType)%></td>
          <td><%=formName%></td>
        </tr>
<%

			if(trClass.equals("DataLight")){
			    trClass="DataDark";
		    }else{
			    trClass="DataLight";
			}
		}
		%>
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
</BODY></HTML>

<script language=javascript>
function onNewWindow(redirectUrl){
	    var width = screen.availWidth-10 ;
	    var height = screen.availHeight-50 ;
	    var szFeatures = "top=0," ;
 	    szFeatures +="left=0," ;
	    szFeatures +="width="+width+"," ;
	    szFeatures +="height="+height+"," ;
	    szFeatures +="directories=no," ;
	    szFeatures +="status=yes,toolbar=no,location=no," ;
	    szFeatures +="menubar=no," ;
	    szFeatures +="scrollbars=yes," ;
	    szFeatures +="resizable=yes" ; //channelmode
	    window.open(redirectUrl,"",szFeatures) ;
}
</script>