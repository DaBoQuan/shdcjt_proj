<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(17088,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    int parentid = Util.getIntValue(request.getParameter("parentid"),0);
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<FORM id=weaver action="HrmCustomFieldOperation.jsp" method=post >
  <input type="hidden" name="method" value="add">
  <input type="hidden" name="parentid" value="<%=parentid%>">

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

<TABLE class="viewform">
  <COLGROUP>
  <COL width="100%">
  <TBODY>
  <TR>
    <TD vAlign=top>
      <TABLE class="viewform">
      <COLGROUP>
  	<COL width="20%">
  	<COL width="80%">
        <TBODY>
        <TR class="Title">
            <TH><%=SystemEnv.getHtmlLabelName(61,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(87,user.getLanguage())%></TH>
          </TR>
        <TR class="Spacing" style="height:1px;">
          <TD class="Line1" colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(17549,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=Inputstyle maxLength=50 size=20 name="formlabel" onchange='checkinput("formlabel","formlabelimage")'><SPAN id=formlabelimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
        </TR> <TR class="Spacing"  style="height:1px;">
          <TD class="Line" colSpan=2></TD></TR>
          <input type=hidden name="viewtype" value="1">
          <TR>
          <TD><%=SystemEnv.getHtmlLabelName(15513,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=Inputstyle maxLength=3 size=20 name="scopeorder" value="0" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'></TD>
         </TR>   <TR class="Spacing" style="height:1px;">
          <TD class="Line" colSpan=2></TD></TR>
        </TBODY></TABLE></TD>
    </TR></TBODY></TABLE>


        <%--�Զ����ֶ�--%>

<SCRIPT LANGUAGE=javascript>
function addrow(){
	var oRow;
	var oCell;

	oRow = inputface.insertRow(-1);
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
	oCell.innerHTML = flable.innerHTML ;
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
	oCell.innerHTML = fhtmltype.innerHTML;
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
	oCell.innerHTML = ftype1.innerHTML ;
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
	oCell.innerHTML = ftype5.innerHTML ;
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
    oCell.innerHTML = fismand.innerHTML ;
	oCell = oRow.insertCell(-1);
    oCell.style.borderBottom="silver 1pt solid";
	oCell.innerHTML = action.innerHTML ;

}

function addrow2(obj){
	var tobj = obj.parentElement.parentElement.cells[3].childNodes[0];
	var oRow;
	var oCell;

	oRow = tobj.insertRow(-1);
	oCell = oRow.insertCell(-1);
	oCell.innerHTML = fselectitem.innerHTML ;
	oCell = oRow.insertCell(-1);
	oCell.innerHTML = itemaction.innerHTML ;

}

function delitem(obj){
	var rowobj = obj.parentElement.parentElement;

	rowobj.parentElement.deleteRow(rowobj.rowIndex);

}

function upitem(obj){
	if(obj.parentElement.parentElement.rowIndex==0){
		return;
	}
	var tobj = obj.parentElement.parentElement.parentElement;
	var rowobj = tobj.insertRow(obj.parentElement.parentElement.rowIndex-1);
	for(var i=0; i<2; i++){
		var cellobj = rowobj.insertCell(-1)
        //cellobj.style.borderBottom="silver 1pt solid";
		cellobj.innerHTML = obj.parentElement.parentElement.cells[i].innerHTML;
	}

	tobj.deleteRow(obj.parentElement.parentElement.rowIndex);

}

function downitem(obj){
	if(obj.parentElement.parentElement.rowIndex==obj.parentElement.parentElement.parentElement.rows.length-1){
		return;
	}
	var tobj = obj.parentElement.parentElement.parentElement;
	var rowobj = tobj.insertRow(obj.parentElement.parentElement.rowIndex+2);
	for(var i=0; i<2; i++){
		var cellobj = rowobj.insertCell(-1)
        //cellobj.style.borderBottom="silver 1pt solid";
		cellobj.innerHTML = obj.parentElement.parentElement.cells[i].innerHTML;
	}

	tobj.deleteRow(obj.parentElement.parentElement.rowIndex);

}

function del(obj){
	var rowobj = obj.parentElement.parentElement;

	rowobj.parentElement.deleteRow(rowobj.rowIndex);

}

function up(obj){
	if(jQuery(obj).parent().parent().index()==0){
		return;
	}
	var tobj = jQuery(obj).parents("table")[0];
	
	var rowobj = tobj.insertRow(jQuery(obj).parent().parent().index()-1);
	for(var i=0; i<6; i++){
		var cellobj = rowobj.insertCell(-1);
        cellobj.style.borderBottom="silver 1pt solid";
		cellobj.innerHTML = jQuery(obj).parents("tr")[0].cells[i].innerHTML;
		$(cellobj).find("input").val($(jQuery(obj).parents("tr")[0].cells[i]).find("input").val());
	}

	tobj.deleteRow(jQuery(obj).parent().parent().index());

}

function down(obj){
	if(jQuery(obj).parent().parent().index()==jQuery(obj).parents("table")[0].rows.length-1){
		return;
	}
	var tobj = jQuery(obj).parents("table")[0];
	var rowobj = tobj.insertRow(jQuery(obj).parent().parent().index()+2);
	for(var i=0; i<6; i++){
		var cellobj = rowobj.insertCell(-1);
        cellobj.style.borderBottom="silver 1pt solid";
		cellobj.innerHTML = jQuery(obj).parents("tr")[0].cells[i].innerHTML;
		$(cellobj).find("input").val($(jQuery(obj).parents("tr")[0].cells[i]).find("input").val());
	}

	tobj.deleteRow(jQuery(obj).parent().parent().index());

}

function htmltypeChange(obj){
	if(obj.selectedIndex == 0){
		obj.parentElement.parentElement.cells[2].innerHTML=ftype1.innerHTML ;
		obj.parentElement.parentElement.cells[3].innerHTML=ftype5.innerHTML ;
	}else if(obj.selectedIndex == 2){
		obj.parentElement.parentElement.cells[2].innerHTML=ftype2.innerHTML ;
		obj.parentElement.parentElement.cells[3].innerHTML=ftype4.innerHTML ;
	}else if(obj.selectedIndex == 4){
		obj.parentElement.parentElement.cells[2].innerHTML=fselectaction.innerHTML ;
		obj.parentElement.parentElement.cells[3].innerHTML=fselectitems.innerHTML ;
	}else{
		obj.parentElement.parentElement.cells[2].innerHTML=ftype3.innerHTML ;
		obj.parentElement.parentElement.cells[3].innerHTML=ftype4.innerHTML ;
	}
}

function typeChange(obj){
	if(obj.selectedIndex == 0){
		obj.parentElement.parentElement.cells[3].innerHTML=ftype5.innerHTML ;
	}else{
		obj.parentElement.parentElement.cells[3].innerHTML=ftype4.innerHTML ;
	}
}

function clearTempObj(){
    flable.innerHTML="";
    fhtmltype.innerHTML="";
    ftype1.innerHTML="";
    ftype2.innerHTML="";
    ftype3.innerHTML="";
    ftype4.innerHTML="";
    ftype5.innerHTML="";
    fselectaction.innerHTML="";
    fselectitems.innerHTML="";
    fselectitem.innerHTML="";
    fismand.innerHTML="";
}

var selectRowObj;
function importSel(obj){
    selectRowObj = obj;
    //id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CustomSelectFieldBrowser.jsp");
    var ret = showSelectRow();
    if(ret != ""){
        document.all("selectItemGetter").src="SelectRowGetter.jsp?fieldid="+ret;
    }
}

</SCRIPT>

<script language="VbScript">
function showSelectRow()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CustomSelectFieldBrowser.jsp")
	if (Not IsEmpty(id)) then
        showSelectRow=id(0)
	else
        showSelectRow=""
    end if
end function
</script>
<iframe name="selectItemGetter" style="width:100%;height:200;display:none"></iframe>
<br>
<b>�����ֶ�</b>
<hr>
<BUTTON Class=Btn type=button accessKey=A onclick="addrow()"><U>A</U>-����ֶ�</BUTTON>
<div style="DISPLAY: none" id="flable">
��ǩ:<input  class=InputStyle name="fieldlable"><input  type="hidden" name="fieldid" value="-1">
</div>

<div style="DISPLAY: none" id="fhtmltype">
	������ʽ:
    <select size="1" name="fieldhtmltype" onChange = "htmltypeChange(this)">
		<option value="1" selected>�����ı���</option>
		<option value="2" >�����ı���</option>
		<option value="3" >�����ť</option>
		<option value="4" >Check��</option>
		<option value="5" >ѡ���</option>
    </select>
</div>

<div style="DISPLAY: none" id="ftype1">
	����:
	<select size=1 name=type onChange = "typeChange(this)">
		<option value="1" selected>�ı�</option>
		<option value="2">����</option>
		<option value="3">������</option>
	</select>
</div>

<div style="DISPLAY: none" id="ftype2">
	����:
	<select size=1 name=type>
    <%while(BrowserComInfo.next()){
    		if("224".equals(BrowserComInfo.getBrowserid())||"225".equals(BrowserComInfo.getBrowserid())||"226".equals(BrowserComInfo.getBrowserid())||"227".equals(BrowserComInfo.getBrowserid()))
    		{
    			continue;
    		}
    %>
		<option value="<%=BrowserComInfo.getBrowserid()%>" ><%=SystemEnv.getHtmlLabelName(Util.getIntValue(BrowserComInfo.getBrowserlabelid(),0),7)%></option>
    <%}%>
	</select>
</div>

<div style="DISPLAY: none" id="ftype3">
	<input name=type type=hidden value="0">
</div>

<div style="DISPLAY: none" id="ftype4">
	<input name=flength type=hidden  value="100">
</div>

<div style="DISPLAY: none" id="ftype5">
	�ı�����:<input  class=InputStyle name=flength type=text value="100" maxlength=4 style="width:50">
</div>

<div style="DISPLAY: none" id="fismand">
	����:
	<select size=1 name=ismand>
		<option value="0">��</option>
		<option value="1">��</option>
	</select>
</div>

<div style="DISPLAY: none" id="fselectaction">
	<input name=type type=hidden  value="0">
	<BUTTON Class=Btn type=button accessKey=A onclick="addrow2(this)">���ѡ����</BUTTON><br>
    <BUTTON Class=Btn type=button accessKey=I onclick="importSel(this)">����</BUTTON>
</div>
<div style="DISPLAY: none" id="fselectitems">
	<TABLE cellSpacing=0 cellPadding=1 width="100%" border=0 >
	<COLGROUP>
		<col width="40%">
		<col width="60%">
	</COLGROUP>
	</TABLE>
    <input name=selectitemid type=hidden value="--">
	<input name=selectitemvalue type=hidden >

    <input name=flength type=hidden  value="100">
</div>

<div style="DISPLAY: none" id="fselectitem">
	<input name=selectitemid type=hidden value="-1">
	<input  class=InputStyle name=selectitemvalue type=text style="width:100">
</div>

<div style="DISPLAY: none" id="itemaction">
    <img src="/images/icon_ascend.gif" height="14" onclick="upitem(this)">
    <img src="/images/icon_descend.gif" height="14" onclick="downitem(this)">
	<img src="/images/delete.gif" height="14" onclick="delitem(this)">
</div>

<div style="DISPLAY: none" id="action">
    <img src="/images/icon_ascend.gif" height="14" onclick="up(this)">
    <img src="/images/icon_descend.gif" height="14" onclick="down(this)">
	<img src="/images/delete.gif" height="14" onclick="del(this)">
</div>
<hr>
<form action="testcustomdo.jsp" method="post" name="cusform">
<TABLE cellSpacing=0 cellPadding=1 width="100%" border=0 id="inputface">
<COLGROUP>
	<col width="23%" valign="top">
	<col width="20%" valign="top">
	<col width="22%" valign="top">
	<col width="18%" valign="top">
	<col width="10%" valign="top">
	<col width="7%" valign="top">
</COLGROUP>
</TABLE>
        <%--�Զ����ֶν���--%>


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
<script language="javascript">
function submitData()
{
	if (check_form(weaver,'formlabel')){
        clearTempObj();
		weaver.submit();
    }
}
</script>
</BODY>
</HTML>
