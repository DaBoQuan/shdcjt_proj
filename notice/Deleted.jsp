<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="/css/Weaver.css">
</HEAD>

<%
String showtype= Util.null2String(request.getParameter("showtype")) ;
String imagefilename = "/images/hdNoAccess.gif";
String titlename = SystemEnv.getHtmlLabelName(19327,user.getLanguage())+"...";
String needfav ="";
String needhelp ="";
String errmsg="";    
if(showtype.equals("wf")){
    errmsg=SystemEnv.getHtmlLabelName(23229,user.getLanguage());
}
if(showtype.equals("doc")){
    errmsg=SystemEnv.getHtmlLabelName(23230,user.getLanguage());
}
if(showtype.equals("doc0")){
    errmsg=SystemEnv.getHtmlLabelName(19711,user.getLanguage());
}
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<table width=100% height=96% border="0" cellspacing="0" cellpadding="0">
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
			<TR>
				<TD valign=top>
					<TABLE>
						<TR class=Section><TH style="font-size:8pt" align="left"><%=errmsg%></TH></TR>

						<TR><TD><%=SystemEnv.getHtmlLabelName(2013,user.getLanguage())%></TD></TR>

					</TABLE>
				</TD>

			</TR>
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