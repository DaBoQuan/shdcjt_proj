<%
	response.setHeader("Expires", "-1") ; // '����ǰҳ����ΪΨһ���ҳ��,����ر����ҳ���Ժ�,������ҳ����ܱ�����
%>
<HTML xmlns:IE>
<HEAD>
	<TITLE>Clock</TITLE>
	<STYLE>
	@media all 
	{
	  IE\:Clock 
	  {
	    behavior: url(/htc/clock.htc) ; //����clock��html���
	  }
	}
	</STYLE>
<script>
function getTheTime() {
	thehour =cal.hour;
	theminute = cal.minute;
	if(thehour<10) thehour ="0"+thehour;
	if(theminute<10) theminute ="0"+theminute;
	window.returnValue =thehour+':'+theminute ;
	window.close();
}
</script>	
</HEAD>

<BODY scroll="no">

<TABLE width=100% height=100% border=0 cellpadding=0 cellspacing=0>
<TR>
<!--	
	��ʾ����
-->
	<TD>
		<IE:Clock id=cal style="height:100%;width:100%;border:1px solid black;">
		</IE:Clock>
	</TD>
</TR>
<TR>
	<TD align=center height=30px>
		<TABLE border=0 cellpadding=2 cellspacing=0>
		<TR>
			<TD align="center"><input type="BUTTON" value="ȷ��" ACCESSKEY=1 TITLE="ȷ��[1]" onclick="getTheTime()"></TD>
			<TD align="center"><input type="BUTTON" value="ȡ��" ACCESSKEY=3 TITLE="ȡ��[3]" onclick="window.returnValue = '';window.close()"></TD>
		</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>
</BODY>
</HTML>



