<%@ page import="java.util.*,weaver.general.*" %>

<jsp:useBean id="UpgradeFileMove" class="weaver.systeminfo.UpgradeFileMove" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<BODY>


<%

String Needmovefilelist = Util.null2String(request.getParameter("Needmovefilelist"));
String NEWFILEPATH = Util.null2String(request.getParameter("NEWFILEPATH"));
String SYSFILEPATH = Util.null2String(request.getParameter("SYSFILEPATH"));

UpgradeFileMove.setNeedmovefilelist( Needmovefilelist ) ;
UpgradeFileMove.setNewfilepath( NEWFILEPATH ) ;
UpgradeFileMove.setSysfilepath( SYSFILEPATH ) ;
UpgradeFileMove.MoveFile() ;

String message = UpgradeFileMove.getErrorFileList( ) ;
%>
<br><br>
ִ����ϣ�<a href='CopyFile.jsp'>�ظ����ļ�����ҳ��</a>
<br><br>

<% if( !message.equals("") ) { %>
����������Ϣ �� <br><br>
<%=Util.toScreen(message,7,"0")%>
<% } %>
</BODY>
</HTML>