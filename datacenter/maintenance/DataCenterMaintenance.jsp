<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = Util.toScreen("��������",7,"0") ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">


<TABLE class=viewform>
  <COLGROUP>
  <COL width="48%">
  <COL width=24>
  <COL width="48%">
  <TBODY>
  <TR>
    <TD vAlign=top>
      <TABLE class=viewform width="100%">
        <TBODY> 
        <TR class=title> 
          <TH>�����趨</TH>
        </TR>
        <TR class=spacing> 
          <TD class=line1></TD>
        </TR>
        <tr class=spacing> 
          <td><a 
            href="/datacenter/maintenance/inputreport/InputReport.jsp">��������ά��</a></td>
        </tr>
        <tr class=spacing> 
		<td><a 
            href="/datacenter/maintenance/condition/OutReportCondition.jsp">��������ά��</a></td>
        </tr>
		<tr class=spacing> 
		<td><a 
            href="/datacenter/maintenance/outreport/OutReport.jsp">�������ά��</a></td>
        </tr>
        </TBODY> 
      </TABLE>
    </TD>
    <TD></TD>
    <TD vAlign=top>
      <TABLE class=viewform width="100%">
        <TBODY> 
        <TR class=title> 
          <TH>�������</TH>
        </TR>
        <TR class=spacing> 
          <TD class=line1></TD>
        </TR>
        <tr class=spacing> 
          <td><a 
            href="/datacenter/maintenance/reportstatus/ReportConfirm.jsp">��������ȷ��</a></td>
        </tr>
        <% if(HrmUserVarify.checkUserRight("DataCenter:Maintenance", user)) {%>
        <tr class=spacing> 
          <td><a 
            href="/datacenter/maintenance/reportstatus/ReportStatus.jsp">����������</a></td>
        </tr>
        <%}%>
        <tr class=spacing> 
          <td height="8"></td>
        </tr>
        </TBODY> 
      </TABLE>
      <TABLE class=viewform width="100%">
        <TBODY> 
        <TR class=title> 
          <TH>�û�����</TH>
        </TR>
          <TR class=spacing> 
          <TD class=line1></TD>
        </TR>
        <tr class=spacing> 
          <td><a 
            href="/datacenter/maintenance/user/UserManager.jsp">�û�����</a></td>
        </tr>
        </TBODY> 
      </TABLE>
    </TD></TR></TBODY></TABLE>
	
	</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

	</BODY></HTML>
