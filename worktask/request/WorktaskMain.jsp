<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
String imagefilename = "/images/hdHRM.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";
String objId=Util.null2String(request.getParameter("objId")); 
String type_d=Util.null2String(request.getParameter("type_d"));
String type=Util.null2String(request.getParameter("type")); 
String planDate=Util.null2String(request.getParameter("planDate")); 
String years=Util.null2String(request.getParameter("years"));
String months=Util.null2String(request.getParameter("months"));
String weeks=Util.null2String(request.getParameter("weeks"));
String quarters=Util.null2String(request.getParameter("quarters"));
String rigthPage = Util.null2String(request.getParameter("rigthPage"));//�ұ߿��ҳ���ַ
int wtid = Util.getIntValue(request.getParameter("wtid"), 0);
int worktaskStatus = Util.getIntValue(request.getParameter("worktaskStatus"), 0);
if("".equals(rigthPage.trim())){//�趨Ĭ��ֵ��Ϊ�½�ҳ��
	rigthPage = "RequestSubmitFrame";
}
if("RequestExecuteFrame".equals(rigthPage.trim()) || "RequestExecuteViewFrame".equals(rigthPage.trim())){
	worktaskStatus = 5;
}else if("RequestCheckFrame".equals(rigthPage.trim())){
	worktaskStatus = 9;
}else if("RequestApproveFrame".equals(rigthPage.trim())){
	worktaskStatus = 2;
}
if("".equals(type_d)){
	type_d = "3";
}
if("".equals(objId)){
	if("1".equals(type_d)){
		objId = ResourceComInfo.getSubCompanyID(""+user.getUID());
	}else if("2".equals(type_d)){
		objId = ResourceComInfo.getDepartmentID(""+user.getUID());
	}else if("3".equals(type_d)){
		objId = ""+user.getUID();
	}
}
int isNewWindow = Util.getIntValue(request.getParameter("isNewWindow"), 0);
//�Ƿ��Ȩϵͳ���粻�ǣ�����ʾ��ܣ�ֱ��ת���б�ҳ��
/**
rs.executeSql("select detachable from SystemSet");
int detachable=0;
if(rs.next()){
    detachable=rs.getInt("detachable");
    session.setAttribute("detachable",String.valueOf(detachable));
}
if(detachable==0){
    response.sendRedirect("manageform.jsp");
    return;
}
*/
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript"  defer="defer" src="/js/JSDateTime/WdatePicker.js?rnd="+Math.random()></script>
<script language="JavaScript">
var contentUrl = (window.location+"").substring(0,(window.location+"").lastIndexOf("/")+1)+"manageform.jsp";
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
<IFRAME name=leftframe id=leftframe src="/worktask/request/organizationTree2.jsp?rigthPage=<%=rigthPage%>" width="100%" height="100%" frameborder=no scrolling="auto"> 
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd0 name=oTd0 width="10px"  style=��padding:0px��>
<IFRAME name=middleframe id=middleframe   src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd2 name=oTd2 width="*" style=��padding:0px��>
<IFRAME name=contentframe id=contentframe src="/worktask/request/<%=rigthPage%>.jsp?objId=<%=objId%>&type_d=<%=type_d%>&months=<%=months%>&years=<%=years%>&type=<%=type%>&planDate=<%=planDate%>&quarters=<%=quarters%>&weeks=<%=weeks%>&wtid=<%=wtid%>&worktaskStatus=<%=worktaskStatus%>&isNewWindow=<%=isNewWindow%>" width="100%" height="100%" frameborder=no scrolling="no">
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
</tr>
</TBODY>
</TABLE>
 </body>
<script language="javascript">
var hasOnHidden = false;
function onHuidden(){
	if(hasOnHidden == false){
		middleframe.mnToggleleft();
	}
	hasOnHidden = true;
}
</script>
</html>