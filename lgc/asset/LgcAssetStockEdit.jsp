<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="WarehouseComInfo" class="weaver.lgc.maintenance.WarehouseComInfo" scope="page"/>
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
char separator = Util.getSeparator() ;
boolean canedit = HrmUserVarify.checkUserRight("LgcAssetStockEdit:Edit", user) ;
String paraid = Util.null2String(request.getParameter("paraid")) ;
String assetstockid = paraid ;

RecordSet.executeProc("FnaCurrency_SelectByDefault","");
RecordSet.next();
String defcurrenyid = RecordSet.getString(1);

RecordSet.executeProc("LgcAssetStock_SelectByID",assetstockid);
RecordSet.next();

String warehouseid = Util.null2String(RecordSet.getString("warehouseid"));
String assetid = Util.null2String(RecordSet.getString("assetid"));
String stocknum = Util.null2String(RecordSet.getString("stocknum"));
String unitprice = Util.null2String(RecordSet.getString("unitprice"));

RecordSet.executeProc("LgcStockInOut_SelectByAsset",assetid+separator+warehouseid);
RecordSet.next();

String currencyid = Util.null2String(RecordSet.getString("currencyid"));
String exchangerate = Util.null2String(RecordSet.getString("exchangerate"));

String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(739,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(93,user.getLanguage());
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
<FORM name=frmain action=LgcAssetStockOperation.jsp?Action=2 method=post>
<%if(canedit){%>
<DIV style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:OnSubmit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnSave accessKey=S onclick='OnSubmit()'><U>S</U>-����</BUTTON>
<% }
if(HrmUserVarify.checkUserRight("LgcAssetStockEdit:Delete", user)){
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDelete(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnDelete id=Delete accessKey=D onclick="onDelete()"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
<%}%>
 </DIV>
<input type="hidden" name="operation" value="editassetstock">
<input type="hidden" name="assetstockid" value="<%=assetstockid%>">
<input type="hidden" name="assetid" value="<%=assetid%>">
<input type="hidden" name="warehouseid" value="<%=warehouseid%>">
<input type=hidden name="trandefcurrencyid" value="<%=defcurrenyid%>">

<TABLE class=ViewForm>
    <COLGROUP> <COL width="10%"> <COL width="90%"> <TBODY> 
    <TR class=Title> 
      <TH colSpan=2>������Ϣ</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>�ʲ�</td>
      <td class=Field> <a href="LgcAsset.jsp?paraid=<%=assetid%>"><%=Util.toScreen(AssetComInfo.getAssetName(assetid),user.getLanguage())%></a></td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <TR> 
      <TD>�ֿ�</TD><td class=Field> 
	  <%=Util.toScreen(WarehouseComInfo.getWarehousename(warehouseid),user.getLanguage())%></td>
	  </TD>
    </TR><tr><td class=Line colspan=2></td></tr>
	<TR> 
      <TD>����</TD>
		<TD class=Field><BUTTON class=Browser id=selectcurrency onClick="onShowCurrencyID()"></BUTTON> <SPAN <input class=InputStyle            id=currencyidspan><%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyid),user.getLanguage())%></SPAN> 
              <input class=InputStyle  id=currencyid type=hidden value="<%=currencyid%>" name=currencyid>
        </TD>
    </TR><tr><td class=Line colspan=2></td></tr>
	<TR> 
      <TD valign="top">����</TD>
      <TD class=Field> 
        <input class=InputStyle  type="text"  name=exchangerate onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("exchangerate")' value=<%=exchangerate%>>
      </TD>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td valign="top">�ڳ���</td>
      <td class=Field> 
        <input class=InputStyle  type="text"  name=stocknum onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("stocknum")' value=<%=stocknum%>>
      </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <TR> 
      <TD valign="top">�ڳ�����</TD>
      <TD class=Field> 
        <input class=InputStyle  type="text"  name=unitprice onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("unitprice")' value=<%=unitprice%>>
      </TD>
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
<SCRIPT language=VBS>
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
</SCRIPT>
<SCRIPT language="javascript">
function OnSubmit(){
   		document.frmain.submit();
}

function onDelete(){
		if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
			document.frmain.operation.value="deleteassetstock";
			document.frmain.submit();
		}
}
</script>
</BODY></HTML>
