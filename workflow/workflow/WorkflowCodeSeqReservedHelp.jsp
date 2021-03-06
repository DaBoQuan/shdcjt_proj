<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<script language=javascript src="/js/weaver.js"></script>
<html>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
int language=user.getLanguage();
%>
<body>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<br>
<%if(language!=8){%>
<p><strong>操作说明</strong></p>
<%if(detachable!=1){%>
<ul>
  <li>点击左边树中的流程类型，本页会显示该流程类型下的所有流程</li>
  <li>点击左边树中的具体流程时，本页会显示该流程的预留编号信息</li>
</ul>
<%}else{%>
<ul>
  <li>点击最左边的组织结构树，可以对相应组织下的流程进行操作，选择组织结构时，中间树会更新</li>
  <li>点击中间树中的流程类型，本页会显示该流程类型下的所有流程</li>
  <li>点击中间树中的具体流程时，本页会显示该流程的预留编号信息</li>
</ul>
<%}}else{%>
<p><strong>Operation Instruction</strong></p>
<%if(detachable!=1){%>
<ul>
  <li>click flow type of left tree,this page will show all flows  of this flow type</li>
  <li>click one flow  of left tree,this page will show it's reserved code infomation</li>
</ul>
<%}else{%>
<ul>
  <li>click left organization tree,can do operation with flows of the organization,and when click one organization,middle tree  will renew</li>
  <li>click flow type of middle tree,this page will show all flows  of this flow type</li>
  <li>click one flow  of middle tree,this page will show it's reserved code infomation</li>
</ul>
<%}}%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</body>
</html>