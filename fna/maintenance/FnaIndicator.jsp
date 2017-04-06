<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(564,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(HrmUserVarify.checkUserRight("FnaIndicatorAdd:Add", user)){
RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/fna/maintenance/FnaIndicatorAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
if(HrmUserVarify.checkUserRight("FnaBudgetModule:Log", user)){
RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem ="+42+",_self} " ;
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
<TABLE class=ListStyle cellspacing=1 >
  <TBODY>
  <TR class=Header>
    <TH><%=SystemEnv.getHtmlLabelName(564,user.getLanguage())%></TH>
  </TR>
 
    </TBODY></TABLE>
<TABLE class=ListStyle cellspacing=1 >
  <THEAD>
  <COLGROUP>
  <COL width="40%" align=left>
  <COL width="60%"  align=left>
  <TR class=Header>
    <TH><%=SystemEnv.getHtmlLabelName(564,user.getLanguage())%></TH>
    <TH><%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%></TH>
    </TR>
    <TR class=Line><TD colspan="2" ></TD></TR> 
    </THEAD>
<%
int i= 0;
RecordSet.executeProc("FnaIndicator_Select","");
while(RecordSet.next()) {
	String id = RecordSet.getString("id") ;
	String indicatorname = Util.toScreen(RecordSet.getString("indicatorname"),user.getLanguage()) ;
	String indicatordesc = Util.toScreen(RecordSet.getString("indicatordesc"),user.getLanguage()) ;
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
    <TD><A 
      href="FnaIndicatorEdit.jsp?id=<%=id%>"><%=indicatorname%></A></TD>
    <TD><%=indicatordesc%></TD></TR>
<%}%>
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
    </BODY>
    </HTML>
