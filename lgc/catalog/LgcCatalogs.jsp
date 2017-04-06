<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(535,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(92,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


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
<DIV style="display:none">
<%
if(HrmUserVarify.checkUserRight("LgcCatalogsAdd:Add", user)){
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",javascript:location='LgcCatalogsAdd.jsp',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON 
class=BtnNew id=AddNew accessKey=N onclick="location='LgcCatalogsAdd.jsp'"><U>N</U>-<%=SystemEnv.getHtmlLabelName(365,user.getLanguage())%></BUTTON>
<%}
if(HrmUserVarify.checkUserRight("LgcCatalogs:Log", user)){
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",javascript:location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =52',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnLog accessKey=L name=button2 onclick="location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =52'"><U>L</U>-<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%></BUTTON>
<%}
%> 
</DIV>

<TABLE class=ListStyle cellspacing=1>
  <THEAD>
  <COLGROUP>
  <COL width="20%" align=left>
  <COL width="40%" align=left>
  <COL width="12%">
  <COL width="18%">
  <COL width="10%">
  <TR class=header>
    <TH colspan=5><%=SystemEnv.getHtmlLabelName(92,user.getLanguage())%></TH>
  </TR>
  <TR class=Header>
    <TH>����</TH>
	<TH>˵��</TH>
	<TH>˳��</TH>
	<TH>��ȫ����</TH>
	<TH>��ʾ</TH>
	</TR>
    <TR class=Line><TD colSpan=5></TD></TR>
    </THEAD>
<%
int i= 0;
RecordSet.executeProc("LgcCatalogs_Select","");
while(RecordSet.next()) {
	String id = RecordSet.getString("id") ;
	String catalogname = Util.toScreen(RecordSet.getString("catalogname"),user.getLanguage()) ;
	String catalogdesc = Util.toScreen(RecordSet.getString("catalogdesc"),user.getLanguage()) ;
	String catalogorder = Util.null2String(RecordSet.getString("catalogorder")) ;
	String seclevelfrom = Util.null2String(RecordSet.getString("seclevelfrom")) ;
	String seclevelto = Util.null2String(RecordSet.getString("seclevelto")) ;
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
      href="LgcCatalogsEdit.jsp?id=<%=id%>"><%=catalogname%></A></TD>
    <TD><%=catalogdesc%></TD>
	<TD><%=catalogorder%></TD>
	<TD><%=seclevelfrom%> - <%=seclevelto%></TD>
	<TD><a href="LgcCatalogsView.jsp?id=<%=id%>"><IMG src="/images/ArrowNext.gif" border=0></a></TD>
	</TR>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>    
</BODY></HTML>
