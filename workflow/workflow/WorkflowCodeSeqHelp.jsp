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
<p><strong>����˵��</strong></p>
<%if(detachable!=1){%>
<ul>
  <li>���������е��������ͣ���ҳ����ʾ�����������µ���������</li>
  <li>���������еľ�������ʱ����ҳ����ʾ�����̵���ʼ�����Ϣ</li>
</ul>
<%}else{%>
<ul>
  <li>�������ߵ���֯�ṹ�������Զ���Ӧ��֯�µ����̽��в�����ѡ����֯�ṹʱ���м��������</li>
  <li>����м����е��������ͣ���ҳ����ʾ�����������µ���������</li>
  <li>����м����еľ�������ʱ����ҳ����ʾ�����̵���ʼ�����Ϣ</li>
</ul>
<%}}else{%>
<p><strong>Operation Instruction</strong></p>
<%if(detachable!=1){%>
<ul>
  <li>click flow type of left tree,this page will show all flows  of this flow type</li>
  <li>click one flow  of left tree,this page will show it's start code infomation</li>
</ul>
<%}else{%>
<ul>
  <li>click left organization tree,can do operation with flows of the organization,and when click one organization,middle tree  will renew</li>
  <li>click flow type of middle tree,this page will show all flows  of this flow type</li>
  <li>click one flow  of middle tree,this page will show it's start code infomation</li>
</ul>
<%}}%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</body>
</html>