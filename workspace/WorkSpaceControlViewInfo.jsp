<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel="STYLESHEET">
<SCRIPT language="javascript" src="/js/weaver.js"></SCRIPT>
<TITLE></TITLE>
</HEAD>

<BODY scroll="no" >
<TABLE height="6" width="100%" border="0" cellspacing="0" cellpadding="0">
<TR>
	<TD bgcolor="#B3B3B3" align="center" valign="middle"><img id="ViewInfo" name="ViewInfo" src="/images/HomePageHidden_2.gif" onclick="javascript:workPlanTogglebottom()" border="0" style="cursor:hand" title="<%=SystemEnv.getHtmlLabelName(16636,user.getLanguage())%>"></TD>
</TR>	
</TABLE>
</BODY>
</HTML>

<SCRIPT language="javascript">
function workPlanTogglebottom() {
	var f = window.parent.workspacemain;
	if (f != null) {
		var c = f.rows;		
		if (c == "*,6,0") {
			f.rows = "*,6,235";
			document.all("ViewInfo").src="/images/HomePageHidden_2.gif";
			document.all("ViewInfo").title="<%=SystemEnv.getHtmlLabelName(16636,user.getLanguage())%>";
		} else { 
			f.rows = "*,6,0";
			document.all("ViewInfo").src="/images/HomePageShow_2.gif";
			document.all("ViewInfo").title="<%=SystemEnv.getHtmlLabelName(89,user.getLanguage())%>";
		}
	}
}

</SCRIPT>