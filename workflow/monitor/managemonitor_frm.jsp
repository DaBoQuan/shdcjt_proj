<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init.jsp"%>
<%
	//�ж��Ƿ��Ȩ����
	String rightSha = Util.null2String(request.getParameter("rightSha"));
%>
<html>
	<head>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript">
			function getParentHeight() 
			{
				if(parent.parent.window.document.getElementById('leftFrame') == null) {
				  	return "100%";
				}else {
					return parent.parent.window.document.getElementById('leftFrame').scrollHeight;
				}
			}
			if (window.jQuery.client.browser == "Firefox") {
		     jQuery(document).ready(function () {
			 jQuery("#leftcontentframe,#middleframe,#wfmainFrame").height(jQuery("#leftcontentframe").parent().height());
			 window.onresize = function () {
				jQuery("#leftcontentframe,#middleframe,#wfmainFrame").height(jQuery("#leftcontentframe").parent().height());
			};
		});
	}
			
		</script>
	</head>
	<body scroll="no">
		<%
			//��Ȩ����
			if (!rightSha.equals("") && rightSha.equalsIgnoreCase("share") && rightSha != null)
			{
		%>
		<TABLE class=viewform width=100% id=oTable1 height=100% cellpadding="0px" cellspacing="0px">
		<%
			}
			else
			{
		%>
			<TABLE class=viewform width=100% id=oTable1 height=100%>
		<%
			}
		%>
				<TBODY>
					<tr>
						<td  height=100% id=oTd1 name=oTd1 width="220px" style=��padding:0px��>
							<IFRAME name=leftcontentframe id=leftcontentframe src="/workflow/monitor/monitortype.jsp" width="100%" height="100%" frameborder=no scrolling=no>
								�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
							</IFRAME>
						</td>
						<td height=100% id=oTd0 name=oTd0 width="10px" style=��padding:0px��>
							<IFRAME name=middleframe id=middleframe src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
								�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
							</IFRAME>
						</td>
						<td height=100% id=oTd2 name=oTd2 width="*" style=��padding:0px��>
							<IFRAME name=wfmainFrame id=wfmainFrame src="/system/systemmonitor/workflow/systemMonitorStatic.jsp" width="100%" height="100%" frameborder=no scrolling=auto>
								�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
							</IFRAME>
						</td>
					</tr>
				</TBODY>
			</TABLE>
	</body>
	</noframes>
</html>
