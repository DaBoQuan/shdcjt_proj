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
<p><strong>操作说明</strong></p>
<ul>
<%if("sysadmin".equals(user.getLoginid())){%>
  <li>点击总部，显示所有分部的机构代字设置</li>
<%}%>
  <li>点击某个分部，显示该分部下的所有部门的机构代字设置</li>
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