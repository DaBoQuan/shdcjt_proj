<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util,java.net.*"%>
<%
String message = Util.null2String(request.getParameter("message"));  // ���صĴ�����Ϣ

%>

<HTML>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="/css/Weaver.css">
</HEAD>
<BODY>
<%if (message.equals("0")) {%>

<TABLE class=Form>
<TR>
	<TD valign=top>
		<TABLE>
			<TR class=Section><TH style="font-size:8pt"> �ύ�ɹ���</TH></TR>
		    
			<TR><TD>��Ϣ�ύ�ɹ������ǻᾡ�������ϵ��лл��</TD></TR>
			
		</TABLE>
	</TD>
	
</TR>
</TABLE>

<%}else{%>

<TABLE class=Form>
<TR>
	<TD valign=top>
		<TABLE>
			<TR class=Section><TH style="font-size:8pt"> �ύ����</TH></TR>
		    
			<TR><TD>��֪ͨ��վ����Ա��</TD></TR>
			
		</TABLE>
	</TD>
	
</TR>
</TABLE>

<%}%>

</BODY>
</HTML>