<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.systeminfo.*" %>

<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<html>
<head>
<title>��ЧԴ��Эͬ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<%
	String id = Util.null2String(request.getParameter("id"));

String checkOutMessage=Util.null2String(request.getParameter("checkOutMessage"));  //�ѱ������ʾ��Ϣ

if(!checkOutMessage.equals("")){
%>
<SCRIPT LANGUAGE="JavaScript">
alert("<%=checkOutMessage%>");
</SCRIPT>
<%
}

	String mainFrameSrc="";
	if("".equals(id)){
		mainFrameSrc="WebDsp.jsp";
	}else{
		mainFrameSrc="WebDsp.jsp?isrequest=Y&id="+id;
	}
%>
<frameset rows="50,*" cols="*" frameborder="yes" border="1" framespacing="0" id=Main> 
  <frame name="topFrame" scrolling="NO" noresize src="top.jsp" target="mainFrame_sub">
  <frameset cols="146,*" frameborder="no" border="1" framespacing="0" id=MainBottom> 
    <frame name="leftFrame" noresize scrolling="NO" src="WebList.jsp" target="mainFrame_sub">
    <frame name="mainFrame_sub" noresize src="<%=mainFrameSrc %>" id="mainFrame_sub">
  </frameset>
</frameset>

<noframes>
	<body bgcolor="#FFFFFF" text="#000000">
	</body>
</noframes>

</html>
