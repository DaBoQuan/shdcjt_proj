<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</head>
<body>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(17989,user.getLanguage());
String needfav ="";
String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<table width=100% height=90% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr><td height="10" colspan="3"></td></tr>
<tr>
<td></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<!--��ʼ-->
  <table class="viewform">
    <COLGROUP>
    <COL width="20%">
	<COL width="80%">
	<TR class="Title"><Th colSpan=2><%=SystemEnv.getHtmlLabelName(17989,user.getLanguage())%></Th></TR>
	<TR class="Spacing"><TD class="Line1" colspan=2></TD></TR>
  </table>
<!--����-->
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
</table>
������ã������У�
<script type="text/javascript">
$(document).ready(function(){//onload�¼�
	$(".loading", window.parent.document).hide(); //���ؼ���ͼƬ
})
</script>
</body>
</html>