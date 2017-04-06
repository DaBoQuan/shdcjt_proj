<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pu" class="weaver.page.PageUtil" scope="page" />

<%
String imagefilename = "/images/home.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";

if(!HrmUserVarify.checkUserRight("homepage:Maint", user)){
	ArrayList shareList = pu.getShareMaintListByUser(user.getUID()+"");
	if(shareList.size()!=0){
		response.sendRedirect("HomepageShareMaintList.jsp");
		 return;
	}else{
	    response.sendRedirect("/notice/noright.jsp");
	    return;
	}
}

//�Ƿ��Ȩϵͳ���粻�ǣ�����ʾ��ܣ�ֱ��ת���б�ҳ��
rs.executeSql("select detachable from SystemSet");
int detachable=0;
if(rs.next()){
    detachable=rs.getInt("detachable");
    session.setAttribute("detachable",String.valueOf(detachable));
}
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="JavaScript">
	var contentUrl = (window.location+"").substring(0,(window.location+"").lastIndexOf("/")+1)+"HompepageRight.jsp";
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
		<IFRAME name=leftframe id=leftframe src="homepageLeft.jsp?rightStr=homepage:Maint" width="100%" height="100%" frameborder=no scrolling=no>
		�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
		</td>
		<td height=100% id=oTd0 name=oTd0 width="10px" style=��padding:0px��>
		<IFRAME name=middleframe id=middleframe   src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
		�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
		</td>
		<td height=100% id=oTd2 name=oTd2 width="*" id="tdcontent" style=��padding:0px��>
		<IFRAME name=contentframe id=contentframe src="HomepageRight.jsp" width="100%" height="100%" frameborder=no scrolling=auto>
		�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
		</td>
		</tr>
  </TBODY>
</TABLE>
</body>
</html>