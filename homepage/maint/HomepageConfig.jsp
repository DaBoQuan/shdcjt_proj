<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.homepage.HomepageBean" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="hpu" class="weaver.homepage.HomepageUtil" scope="page"/>
<html>
  <head>
	<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
	<LINK href="/js/src/widget/templates/HtmlTabSet.css" type="text/css" media=screen>
	<SCRIPT language="javascript" src="/js/checkinput.js"></script>
	<SCRIPT language="javascript" src="/js/weaver.js"></script>
	<SCRIPT language="javascript" src="/js/checknumber.js"></script>
	<script language="JavaScript" src="/js/addRowBg.js" ></script>
	<script type="text/javascript" src="/js/dojo.js"></script>
	<script src="/js/tab.js"></script>
	<script type="text/javascript">
		dojo.require("dojo.widget.TabSet");
		dojo.require("dojo.io.*");
		dojo.require("dojo.event.*");
	</script> 
  </head>  
<body>
<%
	if(!HrmUserVarify.checkUserRight("homepage:styleMaint", user)){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
	String hpid = Util.null2String(request.getParameter("hpid"));
	HomepageBean hpb=hpu.getHpb(hpid);

	String baseUrl=URLEncoder.encode("/homepage/base/HomepageBase.jsp?hpid="+hpid);

	String layoutUrl=URLEncoder.encode("/homepage/layout/HomepageLayoutSele.jsp?hpid="+hpid+"&seleLayoutid="+hpb.getLayoutid());

	String styleUrl=URLEncoder.encode("/homepage/style/HomepageStyleList.jsp?hpid="+hpid+"&seleStyleid="+hpb.getStyleid());

	String elementUrl=URLEncoder.encode("/homepage/Homepage.jsp?isSetting=true&hpid="+hpid+"&layoutid=1&styleid=1");
%>

<div id="mainTabSet" dojoType="TabSet" style="width: 100%; height: 100%;" selectedTab="tabBase">   



	 <div id="tabBase" dojoType="Tab" label="<%=SystemEnv.getHtmlLabelName(61, user.getLanguage())%>"   onmouseup="if(event.button==2) {initMenu(this);}" url="<%="IfrmUrl.jsp?path="+baseUrl%>">		
	 </div> <!--����-->


	 <div id="tabLayout" dojoType="Tab" label="<%=SystemEnv.getHtmlLabelName(19407, user.getLanguage())%>"   onmouseup="if(event.button==2) {initMenu(this);}" url="<%="IfrmUrl.jsp?path="+layoutUrl%>">		
	 </div> <!--����-->

	  <div id="tabStyle" dojoType="Tab" label="<%=SystemEnv.getHtmlLabelName(1014, user.getLanguage())%>" onmouseup="if(event.button==2) {initMenu(this);}"  url="IfrmUrl.jsp?path=<%=styleUrl%>">	
	  </div> <!--��ʽ-->

	   <div id="tabElement" dojoType="Tab" label="<%=SystemEnv.getHtmlLabelName(19408, user.getLanguage())%>"  onmouseup="if(event.button==2) {initMenu(this);}"   url="IfrmUrl.jsp?path=<%=elementUrl%>">		
	   </div> <!--Ԫ��-->

</div>   

</body>
</html>
