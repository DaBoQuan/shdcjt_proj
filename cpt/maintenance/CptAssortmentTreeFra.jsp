<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2006-3-24
  Time: 13:40:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<%
    String paraid=Util.null2String(request.getParameter("paraid"));
%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<SCRIPT language=javascript>
function mnToggleleft(){
	var o = window.parent.cptAssortmentFrameSet;
	if(o.cols=="220,*"){
            o.cols = "10,*"; LeftHideShow.src = "/cowork/images/hide.gif"; LeftHideShow.title = '<%=SystemEnv.getHtmlLabelName(89,user.getLanguage())%>';
    }
		else{
            o.cols = "220,*"; LeftHideShow.src = "/cowork/images/show.gif"; LeftHideShow.title = '<%=SystemEnv.getHtmlLabelName(16636,user.getLanguage())%>';
    }
}

</SCRIPT>
</HEAD>
<BODY>
<table height="100%" width=100%  cellspacing="0" cellspacing="0">
    <tr>
        <td width="100%"><IFRAME name=treeFrame id=treeFrame src="CptAssortmentTree.jsp?paraid=<%=paraid%>" width="100%" height="100%" frameborder=no>
	�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�</IFRAME></td>
        <td style="background-color:#DFDFDF" align=left valign=center ><IMG id=LeftHideShow name=LeftHideShow title=<%=SystemEnv.getHtmlLabelName(16636,user.getLanguage())%> style="CURSOR: hand"  src="/cowork/images/show.gif" onclick="mnToggleleft()"/>
    </td></tr>
</table>
</BODY>
</HTML>