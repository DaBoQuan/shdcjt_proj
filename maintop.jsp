<%@ page import="weaver.general.Util,java.sql.Timestamp,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>

<%
String logintype = Util.null2String(user.getLogintype()) ;
String Customertype = Util.null2String(""+user.getType()) ;
%>
<html>
<head>
<title>��΢Эͬ����ϵͳ(Weaver ecology)</title>
<link rel="stylesheet" href="/css/frame.css" type="text/css">
</head>

<SCRIPT language=javascript>
function mnToggleleft(){
	var f = window.top.MainBottom;
	if (f != null) {
		var c = f.cols;
		if (c == "0,*") 
			{f.cols = "146,*"; LeftHideShow.src = "/images_frame/dh/BP_Hide.gif"; LeftHideShow.title = "����"}	
		else 
			{ f.cols = "0,*"; LeftHideShow.src = "/images_frame/dh/BP_Show.gif"; LeftHideShow.title = "��ʾ"}
	}
}
function mnToggletop(){
	var f = window.top.Main;
	if (f != null) {
		var c = f.rows;
		if (c == "0,*") 
			{f.rows = "125,*"; TopHideShow.src = "/images_frame/dh/BP2_Hide.gif"; TopHideShow.title = "����"}	
		else 
			{ f.rows = "0,*"; TopHideShow.src = "/images_frame/dh/BP2_Show.gif"; TopHideShow.title = "��ʾ"}
	}
}
</SCRIPT>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="23" height="32"><img src="/images_frame/middle_round1.gif"></td>
    <td background="/images_frame/middle_bg2.gif" style="PADDING-TOP: 3px" vAlign=top>
    <IMG id=LeftHideShow  title=���� style="CURSOR: hand" onclick=mnToggleleft() src="/images_frame/dh/BP_Hide.gif" >
    <IMG id=TopHideShow  title=���� style="CURSOR: hand" onclick=mnToggletop() src="/images_frame/dh/BP2_Hide.gif"></td>
     <td background="/images_frame/middle_bg2.gif"  width=232 style="PADDING-TOP: -3px" vAlign=top> 
	 <%if(!logintype.equals("2")){%>
       <iframe BORDER=0 FRAMEBORDER=no NORESIZE=NORESIZE height=32 width=200 SCROLLING=no SRC=/system/SysRemind.jsp></iframe>
	 <%}%>
	</td>
    <td width="29"><img src="/images_frame/middle_round2.gif"></td>
  </tr>
</table>
</body>


</html>