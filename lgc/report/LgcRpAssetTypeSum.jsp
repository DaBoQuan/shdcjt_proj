<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="LgcRpSumManage" class="weaver.lgc.report.LgcRpSumManage" scope="page" />
<jsp:useBean id="AssetTypeComInfo" class="weaver.lgc.maintenance.AssetTypeComInfo" scope="page"/>

<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(352,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(63,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_top} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>

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
<%
LgcRpSumManage.setOptional("assettype") ;
LgcRpSumManage.getRpResult() ;
%>
	
<TABLE class=ListStyle width="100%" cellspacing=1>
  <COLGROUP> 
  <COL align=left width="20%"> 
  <COL align=left width="50%"> 
  <COL align=right width="15%"> 
  <COL align=right width="15%"> 
  <TBODY> 
  <TR class=Header>
    <TH colSpan=4><%=SystemEnv.getHtmlLabelName(324,user.getLanguage())%></TH>
  </TR>
  <TR class=Header> 
    <TH><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></TH>
    <TH><%=SystemEnv.getHtmlLabelName(535,user.getLanguage())%></TH>
    <TH><%=SystemEnv.getHtmlLabelName(363,user.getLanguage())%></TH>
    <TH>%</TH>
  </TR>
  <TR class=Line><TD colSpan=4></TD></TR>
  <%  
	int i=0;
	while(LgcRpSumManage.next())  { 
		  String resultid = LgcRpSumManage.getResultID();
		  String resultcount = LgcRpSumManage.getResultCount();
		  String resultpercent = LgcRpSumManage.getResultPercent() ;
		  String imagepercent = LgcRpSumManage.getImagePercent() ;
	if(i==0){
		i=1;
	%>
	<TR class=DataLight>
	<%
		}else{
			i=0;
	%>
	<TR class=DataDark>
	<%
	}
	%>
    <TD><%=Util.toScreen(AssetTypeComInfo.getAssetTypename(resultid),user.getLanguage())%></TD>
    <TD> 
      <TABLE height="100%" cellSpacing=0 width="100%">
        <TBODY> 
        <TR> 
          <a href="/lgc/search/LgcSearchOperation.jsp?assettype=<%=resultid%>&operation=search">
          <TD class=redgraph <%if(Util.getFloatValue(imagepercent.substring(0,imagepercent.length()-1),0)>=1){%>width="<%=imagepercent%>"<%} else {%>width="1" <%}%> style="CURSOR:HAND">&nbsp;</TD></a>
          <TD>&nbsp;</TD>
        </TR>
        </TBODY>
      </TABLE>
    </TD>
    <TD><%=resultcount%></TD>
    <TD><%=resultpercent%></TD>
  </TR>
  <% } %>
  </TBODY>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</BODY></HTML>
