<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="HrmUserVarify" class="weaver.hrm.HrmUserVarify" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<%
if(!HrmUserVarify.checkUserRight("MoneyWeek:All", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	} 
%>


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(15413,user.getLanguage())+",javascript:onGoSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(589,user.getLanguage())+",javascript:weaver.reset(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>


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

<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle style="FONT-WEIGHT: bold; FONT-SIZE: 12pt"><%=SystemEnv.getHtmlLabelName(15418,user.getLanguage())%>:<%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%></SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
    <TD align=middle width=24><BUTTON class=btnFavorite id=BacoAddFavorite 
    title="Add to favorites" ></BUTTON></TD>
	 <TD align=middle width=24><BUTTON class=btnBack id=onBack title="<%=SystemEnv.getHtmlLabelName(15408,user.getLanguage())%>" onclick="javascript:history.back();"></BUTTON></TD>
  </TR>
  </TBODY>
</TABLE>


<FORM id=weaver action="RptMoneyWeekDetail.jsp" method=post>

<script>
function onGoSearch(){
    if(check_form(weaver,'fromdate,enddate'))
        weaver.submit();
}
</script>
<TABLE class=ViewForm>
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">
  <TBODY>
    <TR class=Spacing>
      <TD class=Line1 colSpan=2></TD></TR>
    <TR>
      <TD><%=SystemEnv.getHtmlLabelName(277,user.getLanguage())%></TD>
      <TD class=Field>
	  <BUTTON class=calendar id=SelectDate onclick=getfromDate()></BUTTON>&nbsp;
	  <SPAN id=fromdatespan ><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
	  <input type="hidden" name="fromdate" value="">
	  －<BUTTON class=calendar id=SelectDate onclick=getendDate()></BUTTON>&nbsp;
	  <SPAN id=enddatespan ><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
	  <input type="hidden" name="enddate" value="">
      </TD>
    </TR> <TR class=Spacing>
      <TD class=Line colSpan=2></TD></TR>
	  <tr>
    <INPUT type= hidden class=InputStyle maxLength=2 size=5 name="level" value="3"></TD>
    <INPUT type=hidden class=InputStyle maxLength=15 size=5 name="currency" value="1"></TD>
    </TR>
    <!--TR>
      <TD>显示金额为零的记录</TD>
      <TD class=Field><INPUT type="checkbox" name="amountzero" value="1"></TD>
    </TR>
    <TR>
      <TD>显示发生额为零的记录</TD>
      <TD class=Field><INPUT type="checkbox" name="transzero" value="1"></TD>
    </TR!-->
    <TR>
      <TD><%=SystemEnv.getHtmlLabelName(15416,user.getLanguage())%></TD>
      <TD class=Field><INPUT type="checkbox" name="unposted" value="1"></TD>
    </TR> <TR class=Spacing>
      <TD class=Line colSpan=2></TD></TR>
     <TR>
      <TD><%=SystemEnv.getHtmlLabelName(15417,user.getLanguage())%></TD>
      <TD class=Field><INPUT type="checkbox" name="wang" value="1"></TD>
    </TR> <TR class=Spacing>
      <TD class=Line1 colSpan=2></TD></TR>
  </TBODY>
</TABLE>
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


</FORM>
</BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
