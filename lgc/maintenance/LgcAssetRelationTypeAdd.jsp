<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("LgcAssetRelationTypeAdd:Add",user)) {
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
String titlename = SystemEnv.getHtmlLabelName(706,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
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

<FORM id=frmMain action=LgcAssetRelationTypeOperation.jsp method=post onsubmit='return check_form(this,"typename")'>
  <DIV style="display:none">
  <%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:frmMain.mysave.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

  <BUTTON class=btnSave accessKey=S id=mysave  type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></BUTTON></div>
  <input type=hidden name=operation value="addtype">
  <TABLE class=ViewForm>
  <TBODY>
  <TR>
    <TH class=Title align=left>������Ϣ</TH></TR>
  <TR class=Spacing>
    <TD class=Line1 colSpan=4></TD></TR></TBODY></TABLE>
  <TABLE class=ViewForm id=tblScenarioCode>
    <THEAD> <COLGROUP> <COL width="15%"> <COL width="30%"> <COL width="15%"> <COL width="40%"></THEAD> 
    <TBODY> 
    <TR> 
      <TD>����</TD>
      <TD class=FIELD> 
        <input class=InputStyle  id=typename name=typename maxlength="30" onchange='checkinput("typename","typenameimage")' size="30">
        <SPAN id=typenameimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
      <TD>���ｨ��</TD>
      <TD class=field> 
        <input type="checkbox" name="shopadvice" value="1">
      </TD>
    </TR><tr><td class=Line colspan=4></td></tr>
    <tr> 
      <td>����</td>
      <td class=FIELD> 
        <select class=InputStyle id=State name=typekind>
          <option value="1">ǿ��</option>
          <option value="2">��ѡ��һ</option>
          <option value="3">��ѡ</option>
          <option value="4">��ѡ��һ</option>
          <option value="5">�ų�</option>
        </select>
      </td>
      <td>��ͬ����</td>
      <td class=field> 
        <input type="checkbox" name="contractlimit" value="1">
      </td>
    </TR><tr><td class=Line colspan=4></td></tr>
    <TR> 
      <TD>˵��</TD>
      <TD class=FIELD><nobr> 
        <textarea class=InputStyle id="typedesc" name="textarea" onChange="checkinput(&quot;typedesc&quot;,&quot;typedescimage&quot;)" cols="60" rows="6"></textarea>
      </TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
    </TR><tr><td class=Line colspan=4></td></tr>
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
</BODY></HTML>
