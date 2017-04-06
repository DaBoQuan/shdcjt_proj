<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(535,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(706,user.getLanguage());
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
if(HrmUserVarify.checkUserRight("LgcAssetRelationTypeAdd:Add", user)){
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",javascript:location='LgcAssetRelationTypeAdd.jsp',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON 
class=BtnNew id=AddNew accessKey=N onclick="location='LgcAssetRelationTypeAdd.jsp'"><U>N</U>-<%=SystemEnv.getHtmlLabelName(365,user.getLanguage())%></BUTTON>
<%}
if(HrmUserVarify.checkUserRight("LgcAssetRelationType:Log", user)){
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",javascript:location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =46',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnLog accessKey=L name=button2 onclick="location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =46'"><U>L</U>-<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%></BUTTON>
<%}
%> 
</DIV>
<TABLE class=ListStyle cellspacing=1>
  <THEAD>
  <COLGROUP>
  <COL width="40%" align=left>
  <COL width="20%">
  <COL width="20%">
  <COL width="20%">
  <TR class=header>
    <TH colspan=4><%=SystemEnv.getHtmlLabelName(706,user.getLanguage())%></TH>
  </TR>
  <TR class=Header>
    <TH>����</TH>
	<TH>����</TH>
	<TH>���ｨ��</TH>
	<TH>��ͬ����</TH>
	</TR>
    <TR class=Line><TD colSpan=4></TD></TR>
    </THEAD>
<%
int i= 0;
RecordSet.executeProc("LgcAssetRelationType_Select","");
while(RecordSet.next()) {
	String id = RecordSet.getString("id") ;
	String typename = Util.toScreen(RecordSet.getString("typename"),user.getLanguage()) ;
	String typekind = Util.null2String(RecordSet.getString("typekind")) ;
	String shopadvice = Util.null2String(RecordSet.getString("shopadvice")) ;
	String contractlimit = Util.null2String(RecordSet.getString("contractlimit")) ;
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
      href="LgcAssetRelationTypeEdit.jsp?id=<%=id%>"><%=typename%></A></TD>
    <TD>
	<% if(typekind.equals("1")) {%>ǿ��
	<%}else if(typekind.equals("2")) {%>��ѡ��һ
	<%}else if(typekind.equals("3")) {%>��ѡ
	<%}else if(typekind.equals("4")) {%>��ѡ��һ
	<%}else if(typekind.equals("5")) {%>�ų� <%}%>
	</TD>
	<TD><% if(shopadvice.equals("1")) {%><IMG src="/images/BacoCheck.gif" border=0><%}%></TD>
	<TD><% if(contractlimit.equals("1")) {%><IMG src="/images/BacoCheck.gif" border=0><%}%></TD>
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
