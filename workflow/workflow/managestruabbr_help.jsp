<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<script language=javascript src="/js/weaver.js"></script>
<html>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
int language=user.getLanguage();
%>
<body>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<br>
<%if(language!=8){%>
<p><strong>����˵��</strong></p>
<ul>
<%if("sysadmin".equals(user.getLoginid())){%>
  <li>����ܲ�����ʾ���зֲ��Ļ�����������</li>
<%}%>
  <li>���ĳ���ֲ�����ʾ�÷ֲ��µ����в��ŵĻ�����������</li>
</ul>
<%}else{%>
<p><strong>Operation Instruction</strong></p>

<ul>
<%if("sysadmin".equals(user.getLoginid())){%>
  <li>Click on the company, the abbrs of the subcompanies could be set.</li>
<%}%>
  <li>Click on one subcompany, the abbrs of the departments under the subcompany could be set.</li>
</ul>
<%}%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</body>
</html>