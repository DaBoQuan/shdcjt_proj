<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<% if(!HrmUserVarify.checkUserRight("FnaYearsPeriodsEdit:Edit",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</head>
<%
String id = Util.null2String(request.getParameter("id"));
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
RecordSet.executeProc("FnaCurrency_SelectByID",id);
RecordSet.next();
String currencyname = Util.toScreen(RecordSet.getString("currencyname"),user.getLanguage());
String currencydesc = Util.toScreenToEdit(RecordSet.getString("currencydesc"),user.getLanguage());
String activable = Util.null2String(RecordSet.getString("activable"));
String isdefault = Util.null2String(RecordSet.getString("isdefault"));

//added by lupeng 2004.05.20 to fix TD498.
//get all the currency names in the system.
String existCurrencyNames = "";
RecordSet.executeSql("SELECT currencyname FROM FnaCurrency");
while (RecordSet.next()) 
	existCurrencyNames += Util.null2String(RecordSet.getString("currencyname")) + ",";
//end

String imagefilename = "/images/hdSystem.gif";
String titlename = SystemEnv.getHtmlLabelName(406,user.getLanguage())+" : "+ currencyname ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
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
<%
if(msgid!=-1){
%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
</font>
</DIV>
<%}%>
<TABLE class=Shadow>
<tr>
<td valign="top">

<FORM id=frmMain name=frmMain action=FnaCurrenciesOperation.jsp method=post >  
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type=hidden name=operation value="editcurrencies">
  <input class=inputstyle type=hidden name=isdefaultold value="<%=isdefault%>">
  <TABLE class=viewForm id=tblCurrency>
  <THEAD> <COLGROUP> <COL width="20%"> <COL width="80%"> 
  <TR class=title> 
    <TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
  </TR>
  </THEAD> <TBODY> 
  <TR style="height:1px;"> 
    <TD class=line1 colSpan=2></TD>
  </TR>
  <TR> 
    <TD><%=SystemEnv.getHtmlLabelName(399,user.getLanguage())%></TD>
    <TD class=Field>
    <input class=inputstyle type=text name=currencyname value="<%=currencyname%>" onChange='checkinput("currencyname","currencynameimage")'> 
    <span id=currencynameimage><%if(currencyname.equals("")){%><img src="/images/BacoError.gif" align=absMiddle><%}%></span>
    </TD>
  </TR>
  <TR style="height:1px;"><TD class=Line colSpan=2></TD></TR> 
  <TR> 
    <TD><%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%></TD>
    <TD class=Field>
        <input class=inputStyle maxlength=60
      	onChange='checkinput("currencydesc","currencydescimage")' name=currencydesc value="<%=currencydesc%>">
        <span id=currencydescimage></span></TD>
  </TR>
  <TR style="height:1px;"><TD class=Line colSpan=2></TD></TR> 
  <tr> 
    <td><%=SystemEnv.getHtmlLabelName(155,user.getLanguage())%></td>
      <td class=Field>
        <input class=inputStyle id=activable type=checkbox  name="activable" value="1" <%if(activable.equals("1")) {%>checked<%}%>>
      </td>
  </tr>
  <TR style="height:1px;"><TD class=Line colSpan=2></TD></TR> 
  <TR> 
    <TD><%=SystemEnv.getHtmlLabelName(149,user.getLanguage())%></TD>
      <TD class=Field>
        <input class=inputStyle id=isdefault type=checkbox  name="isdefault" value="1" <%if(isdefault.equals("1")) {%> checked disabled <%}%> onclick="check();">
      </TD>
  </TR>
  <TR style="height:1px;"><TD class=Line colSpan=2></TD></TR> 
  </TBODY> 
</TABLE>
</form>
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
<script language=javascript>  
function submitData() {
	if(checkactivable()){
		 if(check_form(frmMain,"currencyname,currencydesc") && isValid()){
			frmMain.submit();
		 }
	}
}

//added by lupeng 2004.05.20 to fix TD498.
var existCurrencyNames = "<%=existCurrencyNames%>";

function isValid() {
	var elem = document.all("currencyname");
    if (elem.value == "<%=currencyname%>")
        return true;

	var currencyName = elem.value + ",";
	if (currencyName != "<%=currencyname%>" && existCurrencyNames.indexOf(currencyName) != -1) {
		alert("<%=SystemEnv.getErrorMsgName(33,user.getLanguage())%>");
		elem.focus();
		return false;
	}

	return true;
}
//end

function check() {
	 if(document.getElementById("isdefault").checked){
		document.getElementById("activable").checked = true;
	 }
	 return true;
}

function checkactivable() {
	 if(document.getElementById("isdefault").checked == true && document.getElementById("activable").checked == false){
		alert("<%=SystemEnv.getHtmlLabelName(27080,user.getLanguage())%>");
		return false
	 }
	 return true;
}
</script>

</BODY>
</HTML>
