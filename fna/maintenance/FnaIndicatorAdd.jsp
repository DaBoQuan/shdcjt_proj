<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("FnaIndicatorAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String indicatorname = Util.null2String(request.getParameter("indicatorname1")) ;
String indicatordesc = Util.null2String(request.getParameter("indicatordesc1")) ;
String indicatortype = Util.null2String(request.getParameter("indicatortype1")) ;
String indicatorbalance = Util.null2String(request.getParameter("indicatorbalance")) ;
String haspercent = Util.null2String(request.getParameter("haspercent")) ;
if(indicatortype.equals("")) indicatortype ="0" ;

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(564,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
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

<FORM id=frmMain action=FnaIndicatorOperation.jsp method=post>
  <TABLE class=viewForm>
  <TBODY>
  <TR>
    <TH class=title align=left><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH></TR>
  <TR class=spacing>
    <TD class=line1 colSpan=4></TD></TR></TBODY></TABLE>
  <TABLE class=viewForm id=tblScenarioCode>
    <THEAD> <COLGROUP> <COL width="15%"> <COL width="30%"> <COL width="15%"> <COL width="40%"></THEAD> 
    <TBODY> 
    <TR> 
      <TD><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
      <TD class=FIELD> 
        <INPUT id=indicatorname name=indicatorname maxlength="20" onchange='checkinput("indicatorname","indicatornameimage")' size="15" value="<%=indicatorname%>">
        <SPAN id=indicatornameimage> 
        <% if(indicatorname.equals("")) {%>
        <IMG src="/images/BacoError.gif" align=absMiddle> 
        <%}%>
        </SPAN></TD>
      <TD> 
        <% if(indicatortype.equals("0")) {%>
        <%=SystemEnv.getHtmlLabelName(1463,user.getLanguage())%> 
        <%} else if(indicatortype.equals("2")){%>
        <%=SystemEnv.getHtmlLabelName(1464,user.getLanguage())%> 
        <%}%>
      </TD>
      <TD <% if(indicatortype.equals("0") || indicatortype.equals("2")) {%> class=field <%}%>> 
        <% if(indicatortype.equals("0")) {%>
        <select class=InputStyle id=indicatorbalance name=indicatorbalance>
          <option value=1 <%if(indicatorbalance.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1465,user.getLanguage())%></option>
          <option value=2 <%if(indicatorbalance.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1466,user.getLanguage())%></option>
        </select>
        <%} else if(indicatortype.equals("2")){%>
        <input type="checkbox" name="haspercent" value="1" <%if(haspercent.equals("1")) {%> checked <%}%>>
        <%}%>
      </TD>
    </TR>
    <TR><TD class=Line colSpan=6></TD></TR> 
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%></td>
      <td class=FIELD><nobr> 
        <input id=indicatordesc name=indicatordesc maxlength="100" onChange='checkinput("indicatordesc","indicatordescimage")' size="30" value="<%=indicatordesc%>">
        <span id=indicatordescimage> 
        <% if(indicatordesc.equals("")) {%>
        <img src="/images/BacoError.gif" align=absMiddle> 
        <%}%>
        </span></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></td>
      <td class=FIELD> 
        <select class=InputStyle id=indicatortype name=indicatortype onchange="onChange()">
          <option value=0 <%if(indicatortype.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(189,user.getLanguage())%></option>
          <option value=1 <%if(indicatortype.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
          <option value=2 <%if(indicatortype.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(449,user.getLanguage())%></option>
        </select>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <% if(indicatortype.equals("2")) {%>
    <tr CLASS=title> 
      <TH colSpan=4><%=SystemEnv.getHtmlLabelName(449,user.getLanguage())%></TH>
    </tr>
	<TR CLASS=spacing><TD COLSPAN=4 CLASS="sep2"></TD></TR>
    <TR> 
      <TD>&nbsp;</TD>
      <TD>
        <table width="100%">
          <colgroup> <col width="48%"> <col align=middle width="4%"> <col width="48%"> 
          <tbody> 
          <tr> 
            <td class=FIELD><button class=Browser id=SelectIndicator onClick="onShowIndicator(indicatoridfirstspan,indicatoridfirst)"></button> 
	 		<span class=InputStyle id=indicatoridfirstspan><IMG src="/images/BacoError.gif" align=absMiddle></span> 
             <input id=indicatoridfirst type=hidden name=indicatoridfirst>
            </td>
            <td>/ </td>
            <td class=FIELD><button class=Browser id=SelectIndicator onClick="onShowIndicator(indicatoridlastspan,indicatoridlast)"></button> 
	 		<span class=InputStyle id=indicatoridlastspan><IMG src="/images/BacoError.gif" align=absMiddle></span> 
             <input id=indicatoridlast type=hidden name=indicatoridlast>
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          </tbody>
        </table>
      </TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
    </TR>
<%}%>
    </TBODY> 
  </TABLE>
</FORM>
<FORM id=changsubmit name=changsubmit action=FnaIndicatorAdd.jsp method=post>
  <input type=hidden name=indicatorname1>
  <input type=hidden name=indicatordesc1>
  <input type=hidden name=indicatortype1>
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
<Script language=javascript>
function onSave() {
	parastr = "indicatorname,indicatordesc" ;
	if(frmMain.indicatortype.selectedIndex == 2) parastr = parastr + ",indicatoridfirst,indicatoridlast" ;
	if(check_form(frmMain,parastr)) {
		frmMain.submit() ;
	}
	
}

function onChange() {
	changsubmit.indicatorname1.value=frmMain.indicatorname.value;
	changsubmit.indicatordesc1.value=frmMain.indicatordesc.value;
	changsubmit.indicatortype1.value=frmMain.indicatortype.selectedIndex;
	
	changsubmit.submit() ;
}
</script>

<script language=vbs>
sub onShowIndicator(spanname,inputename)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/FnaIndicatorBrowser.jsp?sqlwhere=where indicatortype !='2'")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = id(1)
	inputename.value=id(0)
	else
	spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	inputename.value=""
	end if
	end if
end sub
</script>
</BODY>
</HTML>