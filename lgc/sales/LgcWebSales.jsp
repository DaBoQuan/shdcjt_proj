<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String purchasestatus = Util.null2String(request.getParameter("purchasestatus")) ;
String fromdate = Util.null2String(request.getParameter("fromdate")) ;
String todate = Util.null2String(request.getParameter("todate")) ;
String id = Util.null2String(request.getParameter("id")) ;
String userid = ""+ user.getUID() ;

String sqlstr = "select id, currencyid, purchasecount, purchasedate, purchasestatus from LgcWebShop where manageid = " + userid ;
if(!purchasestatus.equals("")) sqlstr += " and purchasestatus = '"+purchasestatus+"' ";
if(!fromdate.equals("")) sqlstr += " and purchasedate >= '"+fromdate+"' ";
if(!todate.equals("")) sqlstr += " and purchasedate <= '"+todate+"' ";
if(!id.equals("")) sqlstr += " and id = "+id ;
sqlstr += " order by purchasedate desc " ;

String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(735,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<FORM id=weaver name=frmMain action="LgcWebSales.jsp" method=post>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

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

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:weaver.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

  <TABLE class=ViewForm>
    <COLGROUP> <COL width="20%"> <COL width="30%"> <COL width="20%"> <COL width="30%"> 
    <TBODY> 
    <TR class=Title> 
      <TH colSpan=4><%=SystemEnv.getHtmlLabelName(324,user.getLanguage())%></TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=4 ></TD>
    </TR>
    <tr> 
      <td>״̬</td>
      <td class=Field> 
        <select class=InputStyle name="purchasestatus">
 		  <option value=""> </option>
          <option value="0" <%if(purchasestatus.equals("0")) {%> selected <%}%>>δ����</option>
          <option value="1" <%if(purchasestatus.equals("1")) {%> selected <%}%>>���ڴ���</option>
          <option value="2" <%if(purchasestatus.equals("2")) {%> selected <%}%>>�ѷ���</option>
          <option value="3" <%if(purchasestatus.equals("3")) {%> selected <%}%>>����</option>
        </select>
      </td>
      <td>��������</td>
      <td class=Field><button class=calendar id=SelectDate onClick="getDate(fromdatespan,fromdate)"></button>&nbsp; 
        <span id=fromdatespan ><%=fromdate%></span> 
        -&nbsp;&nbsp;<button class=calendar 
      id=SelectDate2 onClick="getDate(todatespan,todate)"></button>&nbsp; <SPAN id=todatespan><%=todate%></span> 
        <input type="hidden" name="fromdate" value="<%=fromdate%>">
        <input type="hidden" name="todate" value="<%=todate%>">
      </td>
    </tr>
    <TR> 
      <TD>�������</TD>
      <TD class=Field>
        <input class=InputStyle type="text" name="id" size="15" maxlength="15" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber1(this)' value="<%=id%>">
      </TD>
      <TD>&nbsp;</TD>
      <TD></TD>
    </TR>
    </TBODY>
  </TABLE>
 </form>
 
<br>
 
<TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="20%">
  <COL width="20%">
  <COL width="40%">
  <COL width="20%">
  <TBODY>
  <TR class=header>
    <TH colSpan=4>����</TH>
  </TR>
  <TR class=Header>
    <TD>���</TD>
    <TD>��������</TD>
    <TD>���</TD>
	<TD>״̬</TD>
  </TR>
  <TR class=Line><TD colSpan=4></TD></TR>
<%
    int needchange = 0;
	RecordSet.executeSql(sqlstr);
	while(RecordSet.next()) {
    	String ids = RecordSet.getString("id") ;
		String purchasedates = RecordSet.getString("purchasedate") ;
		String currencyids = RecordSet.getString("currencyid") ;
		String purchasecounts = RecordSet.getString("purchasecount") ;
		String purchasestatuss = RecordSet.getString("purchasestatus") ;
       	if(needchange ==0){
       		needchange = 1;
%>
  <TR class=datalight>
  <%
  	}else{
  		needchange=0;
  %><TR class=datadark>
  <% }%>
    <TD><a href="LgcWebSalesDetail.jsp?id=<%=ids%>"><%=ids%></a></TD>
    <TD><%=purchasedates%></TD>
	<TD><b><%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyids),user.getLanguage())%> <%=purchasecounts%></b></TD>
	<TD>
	<% if(purchasestatuss.equals("0")) {%> δ����
    <%} else if(purchasestatuss.equals("1")) {%> ���ڴ���
    <%} else if(purchasestatuss.equals("2")) {%> �ѷ���
    <%} else if(purchasestatuss.equals("3")) {%> ���� <%}%>
	</TD>
  </TR>
<%}%>
 </TBODY></TABLE>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %> 
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
