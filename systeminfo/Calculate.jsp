<%@ page language="java" contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Expires", "-1") ; // '����ǰҳ����ΪΨһ���ҳ��,����ر����ҳ���Ժ�,������ҳ����ܱ�����
%>
<HTML xmlns:InetSDK>
<HEAD>
<TITLE>Calculator</TITLE>
<META NAME="AUTHOR" CONTENT="InetSDK">
<META NAME="MS.LOCALE" CONTENT="EN-US">
<META NAME="ROBOTS" CONTENT="noindex">

<style>
   INPUT    {font-family: Courier New}
   @media all {
      InetSDK\:CALC {behavior:url(/htc/Calculate.htc)} 
   }
</style>
</HEAD>
<script>
function getTheValue() {
	window.returnValue = resultWindow.innerText;
	window.close();
}
</script>
<BODY TOPMARGIN=0 LEFTMARGIN=0  bgcolor="#9C979D" LINK="#000000" VLINK="#808080" ALINK="#000000" scroll="no">
<P>
<!--
	fire the event onResultChange;
-->
<InetSDK:CALC id="myCalc" onResultChange="resultWindow.innerText =window.event.result;">
<TABLE>
  <TR > 
    <TD COLSPAN=5 bgcolor="#EAEAEA"> 
      <DIV ID="resultWindow" STYLE="padding:5" ALIGN="RIGHT" >0.</DIV>
    </TD></TR>
<TR><TD><INPUT TYPE=BUTTON VALUE=" 7 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 8 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 9 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" / "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" C "></TD>
</TR>
<TR><TD><INPUT TYPE=BUTTON VALUE=" 4 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 5 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 6 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" * "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" % " DISABLED></TD>
</TR>
<TR><TD><INPUT TYPE=BUTTON VALUE=" 1 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 2 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" 3 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" - "></TD>
    <TD><INPUT TYPE=BUTTON VALUE="1/x" DISABLED></TD>
</TR>
<TR><TD><INPUT TYPE=BUTTON VALUE=" 0 "></TD>
    <TD><INPUT TYPE=BUTTON VALUE="+/-"></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" . "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" + "></TD>
    <TD><INPUT TYPE=BUTTON VALUE=" = "></TD>
</TR>
</TABLE>
</InetSDK:CALC>

<TABLE border=0 cellpadding=2 cellspacing=0 align="center">
		<TR>
			<TD align="center"><input type="BUTTON" value="ȷ��" ACCESSKEY=1 TITLE="ȷ��[1]" onclick="getTheValue()"></TD>
			<TD align="center"><input type="BUTTON" value="ȡ��" ACCESSKEY=3 TITLE="ȡ��[3]" onclick="window.returnValue = '';window.close()"></TD>
		</TR>
		</TABLE>
</BODY>
</HTML>