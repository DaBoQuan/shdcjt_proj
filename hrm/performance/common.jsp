 <%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.security.*,weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.SessionOper" %>
<%
    if ((SessionOper.getAttribute(session,"hrm.objId")==null)||((""+SessionOper.getAttribute(session,"hrm.objId")).equals("")))
    {%>
    <script language=javascript>
	alert("ϵͳ��ʱ�����ص�¼")
	window.top.location="/login/Login.jsp"
	</script>
	return;
    <%}
    %>