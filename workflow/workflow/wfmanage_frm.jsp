<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<%
//�Ƿ�Ϊ����ģ��
String isTemplate=Util.null2String(request.getParameter("isTemplate"));
//�ж��Ƿ��Ȩ����
String rightSha=Util.null2String(request.getParameter("rightSha"));
%>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script type="text/javascript">
	function getParentHeight() {
		if(parent.parent.window.document.getElementById('leftFrame') == null) {
		 	return "100%";
		}else {
			return parent.parent.window.document.getElementById('leftFrame').scrollHeight;
		}
	}
	if (window.jQuery.client.browser == "Firefox") {
		jQuery(document).ready(function () {
			jQuery("#wfleftFrame,#middleframe,#wfmainFrame").height(jQuery("#wfleftFrame").parent().height());
			window.onresize = function () {
				jQuery("#wfleftFrame,#middleframe,#wfmainFrame").height(jQuery("#wfleftFrame").parent().height());
			};
		});
	}
	
</script>
</head>
<!--
<frameset cols="250,*" frameborder="no" border="1" framespacing="1">
  <frame src="wfmanage_left2.jsp?isTemplate=<%=isTemplate%>" scrolling="auto" name="wfleftFrame"  id="leftFrame" />
  <frame src="" scrolling="auto" name="wfmainFrame" id="mainFrame" />
</frameset>
<noframes>
-->
<body scroll="no">
<%
if(!rightSha.equals("") && rightSha.equalsIgnoreCase("share") && rightSha!=null){  //��Ȩ����
%>
<TABLE class=viewform width=100% id=oTable1 height=100%>
<%}else{%>
<TABLE class=viewform width=100% id=oTable1 style="height: 100%;" cellpadding="0px" cellspacing="0px">
<%}%>
  <TBODY>
<tr><td  height=100% id=oTd1 name=oTd1 width="220px" style=��padding:0px��>
<IFRAME name=wfleftFrame id=wfleftFrame src="wfmanage_left2.jsp?isTemplate=<%=isTemplate%>" width="100%" height="100%" frameborder=no scrolling=no >
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd0 name=oTd0 width="10px" style=��padding:0px��>
<IFRAME name=middleframe id=middleframe   src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd2 name=oTd2 width="*" style=��padding:0px��>
<IFRAME name=wfmainFrame id=wfmainFrame src="WorkFlowHelp.jsp" width="100%" height="100%" frameborder=no scrolling=auto>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
</tr>
  </TBODY>
</TABLE>
</body>
</noframes></html>
