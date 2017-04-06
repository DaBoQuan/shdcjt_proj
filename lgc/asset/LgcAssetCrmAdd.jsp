<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("LgcAssetCrmAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
String paraid = Util.null2String(request.getParameter("paraid")) ;
String assetid = paraid ;
String countryid = Util.null2String(request.getParameter("countryid")) ;

String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(535,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(147,user.getLanguage());
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
		<td valign="top"><%
if(msgid!=-1){
%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
</font>
</DIV>
<%}%>
<FORM name=frmain action="LgcAssetCrmOperation.jsp?"Action=2 method=post>
  <DIV style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:OnSubmit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
    
<BUTTON class=btnSave accessKey=S onclick='OnSubmit()'><U>S</U>-����</BUTTON> </DIV>

<input type="hidden" name="assetid" value="<%=assetid%>">
<input type="hidden" name="countryid" value="<%=countryid%>">
<input type="hidden" name="operation" value="addassetcrm">

  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title> 
      <TH colSpan=2>CRM</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR> 
      <TD>CRM</TD>
      <TD class=Field> <button class=Browser id=SelectCrm onClick="onShowCrmId()"></button> 
              <span <input class=InputStyle  id=crmidspan><IMG src='/images/BacoError.gif' align=absMiddle></span> 
              <input id=crmid type=hidden name=crmid>
       </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>��Ҫ</TD>
      <TD class=Field> 
        <input type=checkbox  name="ismain" value="1">
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>�ʲ����&nbsp;-&nbsp;CRM</TD>
      <TD class=Field> 
        <INPUT <input class=InputStyle  maxLength=30 size=30 name=assetcode>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>����</TD>
       <TD class=Field><BUTTON class=Browser 
            id=selectcurrency onClick="onShowCurrencyID()"></BUTTON> <SPAN <input class=InputStyle  
            id=currencyidspan>RMB</SPAN> 
              <INPUT <input class=InputStyle  id=currencyid type=hidden value=2 name=currencyid>
       </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>�۸�</TD>
      <TD class=Field> 
        <INPUT <input class=InputStyle  maxLength=16 size=16 value=0.00 name=purchaseprice onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("purchaseprice")'>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>��ֵ˰&nbsp;%</TD>
      <TD class=Field> 
        <INPUT <input class=InputStyle   size=13  name=taxrate onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("taxrate")'>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>������λ</TD>
      <td class=Field> <BUTTON class=Browser id=SelectAssetUnitID onClick="onShowAssetUnitID()"></BUTTON> 
              <span id=unitidspan></span> 
              <INPUT <input class=InputStyle  type=hidden name=unitid>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD>��װ��λ</TD>
      <TD class=Field> 
        <INPUT <input class=InputStyle  maxLength=30 size=30 name=packageunit>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
    <TR> 
      <TD valign="top">��ע</TD>
      <TD class=Field> 
        <textarea class=InputStyle cols="60" name=supplyremark rows="6"></textarea>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
     <tr> 
      <td>�ĵ�</td>
      <td class=Field> <BUTTON class=Browser id=SelectDocID onClick="onShowDocID()"></BUTTON> 
              <span id=docidspan></span> 
              <INPUT <input class=InputStyle  type=hidden name=docid>
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr>
<!--    <TR> 
      <TD>��ͬ</TD>
      <TD class=Field> <BUTTON class=Browser id=SelectDocumentID></BUTTON> <A 
      <input class=InputStyle  id=DocumentIDLink 
      href="http://server-weaver/new/docs/BDDocument.asp?Action=View&amp;ID="></A> 
      </TD>
    </TR><tr><td class=Line colspan=3></td></tr> -->
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
<SCRIPT language=VBS>
/////////////////////////////////////////////////////////////////////////////////

sub onShowCrmId()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	crmidspan.innerHtml = id(1)
	frmain.crmid.value=id(0)
	else 
	crmidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	frmain.crmid.value="" 
	end if
	end if
end sub

sub onShowDocID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	docidspan.innerHtml = id(1)
	frmain.docid.value=id(0)
	else
	docidspan.innerHtml = ""
	frmain.docid.value=""
	end if
	end if
end sub

sub onShowCurrencyID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp")
	if NOT isempty(id) then
		if id(0)<> "" then
		currencyidspan.innerHtml = id(1)
		frmain.currencyid.value=id(0)
		else
		currencyidspan.innerHtml = ""
		frmain.currencyid.value= ""
		end if
	end if
end sub

sub onShowAssetUnitID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/maintenance/LgcAssetUnitBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	unitidspan.innerHtml = id(1)
	frmain.unitid.value=id(0)
	else 
	unitidspan.innerHtml = ""
	frmain.unitid.value=""
	end if
	end if
end sub

</SCRIPT>

<SCRIPT language="javascript">
function OnSubmit(){
    if(check_form(document.frmain,"crmid"))
	{	
		document.frmain.submit();
	}
}
</script>

</BODY></HTML>
