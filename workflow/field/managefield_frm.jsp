<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String imagefilename = "/images/hdHRM.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";

//�Ƿ��Ȩϵͳ���粻�ǣ�����ʾ��ܣ�ֱ��ת���б�ҳ��
//rs.executeSql("select detachable from SystemSet");
int detachable=0;//�ֶι�����Ȩ��TD10331
//if(rs.next()){
//    detachable=rs.getInt("detachable");
//    session.setAttribute("detachable",String.valueOf(detachable));
//}
if(detachable==0){
    response.sendRedirect("managefield.jsp");
    return;
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="JavaScript">
var contentUrl = (window.location+"").substring(0,(window.location+"").lastIndexOf("/")+1)+"managefield.jsp";
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

<body>
<TABLE class=viewform width=100% id=oTable1 height=100%>
  <COLGROUP>
  <COL width="50%">
  <COL width=5>
  <COL width="50%">
  <TBODY>
<tr><td  height=100% id=oTd1 name=oTd1 width=30%>
<IFRAME name=leftframe id=leftframe src="managefield_left.jsp?rightStr=FieldManage:All" width="100%" height="100%" frameborder=no scrolling=no>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd0 name=oTd0 width=1%>
<IFRAME name=middleframe id=middleframe   src="/framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
<td height=100% id=oTd2 name=oTd2 width=70%>
<IFRAME name=contentframe id=contentframe src="managefield.jsp" width="100%" height="100%" frameborder=no scrolling=yes>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME>
</td>
</tr>
  </TBODY>
</TABLE>
 </body>

</html>