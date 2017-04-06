<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.system.*"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="ln.LN" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="verifylogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdSystem.gif";
String titlename = SystemEnv.getHtmlLabelName(18014,user.getLanguage());
String needfav ="1";
String needhelp ="";

boolean canEdit = HrmUserVarify.checkUserRight("SystemSetEdit:Edit", user) ;

LN license = new LN();
license.CkHrmnum();
String companyName = license.getCompanyname();
String licenseCode = license.getLicensecode();
String hrmNum = license.getHrmnum();
String concurrentFlag = Util.null2String(license.getConcurrentFlag());//�û���������ʶ
int onlineusercount = verifylogin.checkUserLoginCount();

int licensenum = license.CkUsedHrmnum(); //��ʹ�õ�license����
int unusedlice = license.CkUnusedHrmnum() ;//δlicense��ʹ������
if(hrmNum.equals("999999"))hrmNum=SystemEnv.getHtmlLabelName(18637,user.getLanguage());
String expireDate = license.getExpiredate();
if(expireDate.equals("9999-99-99"))expireDate=SystemEnv.getHtmlLabelName(18638,user.getLanguage());
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(canEdit){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(18640,user.getLanguage())+",javascript:location='/system/InLicense.jsp',_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form id=weaver name=frmmain method=post style="MARGIN-TOP: 0px">
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
			<table class="ViewForm">
				<COLGROUP>
				<COL width="20%">
				<COL width="80%">
				<TBODY>
				<TR class=Title>
				  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(18014,user.getLanguage())%></TH>
				</TR>
				<TR class=Spacing style="height:1px;">
				  <TD class=Line1 colSpan=2></TD>
				</TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(16898,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(companyName,user.getLanguage())%></td>
				</tr>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(18639,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(licenseCode,user.getLanguage())%></td>
				</tr>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(15029,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(hrmNum,user.getLanguage())%></td>
				</tr>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(expireDate,user.getLanguage())%></td>
				</tr>
				<TR class=Title>
				  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(21519,user.getLanguage())%></TH>
				</TR>
				<TR class=Spacing style="height:1px;">
				  <TD class=Line1 colSpan=2></TD>
				</TR>
				<%if("1".equals(concurrentFlag)){ %>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(23657,user.getLanguage())%></td>
					<td class=Field><%=onlineusercount%></td>
				</tr>
				<%} else { %>
				<%if(license.getHrmnum().equals("999999")){%>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(21522,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(hrmNum,user.getLanguage())%></td>
				</tr>
				<%}else{%>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(21522,user.getLanguage())%></td>
					<td class=Field><%=licensenum%></td>
				</tr>
				<%}%>
				<%if(license.getHrmnum().equals("999999")){%>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(21523,user.getLanguage())%></td>
					<td class=Field><%=Util.toScreen(hrmNum,user.getLanguage())%></td>
				</tr>
				<%}else{%>
				<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
				<tr>
					<td><%=SystemEnv.getHtmlLabelName(21523,user.getLanguage())%></td>
					<td class=Field><%=unusedlice%></td>
				</tr>
				<%}}%>
				</TBODY>
			</table>
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
</form>
</BODY>
</HTML>