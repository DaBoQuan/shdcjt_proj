<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ include file="/integration/integrationinit.jsp" %>
<script language=javascript src="/js/weaver.js"></script>
<html>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
int language=user.getLanguage();
 //1����Դ����2ע��������
 String showtype=Util.null2String(request.getParameter("showtype"));
%>
<body>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<br>
<%if(language!=8){%>
<p><strong>����˵��</strong></p>
<ul>
 
  	<%
  		if("1".equals(showtype)){
  	 %>
		  <li>���������е��칹ϵͳ����ҳ����ʾ��ϵͳ�µ����е�����Դ</li>
		  <li>ϵͳ����Ա���Զ�ÿһ��ϵͳ�µ�����Դ����ά��</li>
  <%}else{ %>
  	 	 <li>���������е��칹ϵͳ����ҳ����ʾ��ϵͳ�µ�����ע��ķ���</li>
 		 <li>ϵͳ����Ա���Զ�ÿһ��ϵͳ�µķ������ά��</li>
  	<%} %>
</ul>
<%}else{ %>
<p><strong>Operation Instruction</strong></p>
<ul>

	<%
  		if("1".equals(showtype)){
  	 %>
	  <li>Click on the left tree products, this page will display all of the products under the data source</li>
	  <li>The system administrator can service each data source maintenance</li>
  <%}else{ %>
	 	<li>Click on the left tree products, this page will display all of the products under the registered service</li>
	 	 <li>The system administrator can service each product maintenance</li>
  <%} %>
</ul>
<%}%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</body>
</html>