<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("LgcCountTypeAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(703,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
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

<FORM style="MARGIN-TOP: 0px" id=weaver name=right method=post action="LgcCountTypeOperation.jsp" onSubmit='return check_form(this,"typename")'>
  <input type="hidden" name="operation" value="addtype">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:weaver.btnSave.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
  <BUTTON class=btn id=btnSave accessKey=S name=btnSave style="display:none"  type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></BUTTON> 
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:weaver.reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
  <BUTTON class=btn id=btnClear accessKey=R name=btnClear style="display:none"  type=reset><U>R</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON> 
  <br>
        
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title> 
      <TH colSpan=2>���㷽����Ϣ</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <input class=InputStyle  accesskey=Z name=typename size="30" onchange='checkinput("typename","typenameimage")' maxlength="30">
        <SPAN id=typenameimage><IMG 
            src="/images/BacoError.gif" align=absMiddle></SPAN> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>˵��</td>
      <td class=Field> 
        <textarea class=InputStyle accesskey="Z" name="typedesc" cols="60"></textarea>
      </td>
    </TR><tr><td class=Line colspan=2></td></tr>
	<tr> 
      <td>���������Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger1 onClick='onShowLedger(salesinidspan,salesinid)'></button> 
        <span class=InputStyle id=salesinidspan></span>
		<input class=InputStyle  id=salesinid type=hidden name=salesinid>
	  </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>���۳ɱ���Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger2 onClick='onShowLedger(salescostidspan,salescostid)'></button> 
        <span class=InputStyle id=salescostidspan></span>
		<input class=InputStyle  id=salescostid type=hidden name=salescostid> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>����˰��Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger3 onClick='onShowLedger(salestaxidspan,salestaxid)'></button> 
        <span class=InputStyle id=salestaxidspan></span>
		<input class=InputStyle  id=salestaxid type=hidden name=salestaxid> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>����˰��Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger4 onClick='onShowLedger(purchasetaxidspan,purchasetaxid)'></button> 
        <span class=InputStyle id=purchasetaxidspan></span>
		<input class=InputStyle  id=purchasetaxid type=hidden name=purchasetaxid> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>��������Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger5 onClick='onShowLedger(stockidspan,stockid)'></button> 
        <span class=InputStyle id=stockidspan></span>
		<input class=InputStyle  id=stockid type=hidden name=stockid> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <TR> 
      <TD>��������Ŀ</TD>
      <TD class=Field><button class=Browser 
            id=SelectLedger6 onClick='onShowLedger(stockdiffidspan,stockdiffid)'></button> 
        <span class=InputStyle id=stockdiffidspan></span>
		<input class=InputStyle  id=stockdiffid type=hidden name=stockdiffid> </TD>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>�����ɱ���Ŀ</td>
      <td class=Field><button class=Browser 
            id=SelectLedger7 onClick='onShowLedger(producecostidspan,producecostid)'></button> 
        <span class=InputStyle id=producecostidspan></span>
		<input class=InputStyle  id=producecostid type=hidden name=producecostid> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    </TBODY> 
  </TABLE>
</FORM>
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
<script language="VBS">
sub onShowLedger(spanname, inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/FnaLedgerBrowser.jsp")
	if NOT isempty(id) then
	    if id(0)<> "" then
		spanname.innerHtml = id(1)
		inputname.value=id(0)
		else
		spanname.innerHtml = ""
		inputname.value=""
		end if
	end if
end sub
</script>


      </BODY>
      </HTML>
