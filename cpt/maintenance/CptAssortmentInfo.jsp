<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2006-3-29
  Time: 9:12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(831,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
</HEAD>
</HTML>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
</colgroup>
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
        <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="30px">
  		<COL>
        <TBODY>
        <TR class=Title>
            <TH colSpan=2>����˵����
            </TH>
        </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=2></TD></TR>
        <TR>
          <TD height="5" colSpan=2></TD></TR>
        <TR>
          <TD align="right" valign="top" height="20"><li></TD>
          <TD>�����ඥ���ڵ����ֱ�Ӵ�����һ���ʲ��飻</TD>
        </TR>
        <TR>
          <TD height="5" colSpan=2></TD></TR>
        <TR>
          <TD align="right" valign="top" height="20"><li></TD>
          <TD>�������ʲ������ƣ��Ҳ����ʾ������ʲ�����Ϣ�������ڵ���⣻</TD>
        </TR>
        <TR>
          <TD height="5" colSpan=2></TD></TR>
        <TR>
          <TD align="right" valign="top" height="20"><li></TD>
          <TD>���ʲ�����Ϣҳ����Խ�����ز������������޸ġ�ɾ�����½�ͬ���ʲ��顢�½��¼��ʲ��飻</TD>
        </TR>
        <TR>
          <TD height="5" colSpan=2></TD></TR>
        <TR>
          <TD align="right" valign="top" height="20"><li></TD>
          <TD>û�н����ʲ����ϵ��ʲ��飬�����Խ����¼��ʲ��飬�Ѿ������ʲ����ϵ��ʲ��鲻�������½����¼��ʲ��飻</TD>
        </TR>
        <TR>
          <TD height="5" colSpan=2></TD></TR>
        <TR>
          <TD align="right" valign="top" height="20"><li></TD>
          <TD>�ʲ��������Աߵ������Ǵ�������ʲ�������ж����ʲ����ϣ����������¼��ʲ�����ʲ����ϡ�</TD>
        </TR>
        </table>
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
</BODY>
</HTML>
