<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String imagefilename = "/images/hdHRM.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";

//�Ƿ��Ȩϵͳ
RecordSet.executeSql("select detachable from SystemSet");
int detachable=0;
if(RecordSet.next()){
    detachable=RecordSet.getInt("detachable");
    session.setAttribute("detachable",String.valueOf(detachable));
}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="JavaScript">
var contentUrl = (window.location+"").substring(0,(window.location+"").lastIndexOf("/")+1)+"managestruabbr_help.jsp";
//alert(contentUrl);
if (window.jQuery.client.browser == "Firefox") {
		jQuery(document).ready(function () {
			jQuery("#leftframe,#middleframe,#contentframe").height(jQuery("#leftframe").parent().height());
			window.onresize = function () {
				jQuery("#leftframe,#middleframe,#contentframe").height(jQuery("#leftframe").parent().height());
			};
		});
	}
</script>
</HEAD>

<body scroll="no">
<TABLE class=viewform width=100% id=oTable1 height=100% cellpadding="0px" cellspacing="0px">
  <TBODY>
<tr><td  height=100% id=oTd1 name=oTd1 width="220px" style=��padding:0px��>
<IFRAME name=leftframe id=leftframe src="managestruabbr_left.jsp?rightStr=StruAbbr:Maintenance" width="100%" height="100%" frameborder=no scrolling=no>
<%=SystemEnv.getHtmlLabelName(15017,user.getLanguage())%></IFRAME>
</td>
<td height=100% id=oTd0 name=oTd0 width="10px" style=��padding:0px��>
<IFRAME name=middleframe id=middleframe   src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
<%=SystemEnv.getHtmlLabelName(15017,user.getLanguage())%></IFRAME>
</td>
<td height=100% id=oTd2 name=oTd2 width="*" style=��padding:0px��>
<IFRAME name=contentframe id=contentframe src="managestruabbr_help.jsp" width="100%" height="100%" frameborder=no scrolling=yes>
<%=SystemEnv.getHtmlLabelName(15017,user.getLanguage())%></IFRAME>
</td>
</tr>
  </TBODY>
</TABLE>
 </body>

</html>