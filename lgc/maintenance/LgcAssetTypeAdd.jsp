<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("LgcAssetTypeAdd:Add",user)) {
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
String titlename = SystemEnv.getHtmlLabelName(713,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
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
<FORM style="MARGIN-TOP: 0px" name=right method=post id=weaver action="LgcAssetTypeOperation.jsp" onSubmit='return check_form(this,"typename")'>
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

  <BUTTON class=btn id=btnClear accessKey=R name=btnClear  style="display:none"  type=reset><U>R</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON> 
  <br>
        
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>��ʶ</td>
      <td class=Field> 
        <input class=InputStyle  accesskey=Z name=typemark onChange='checkinput("typemark","typemarkimage")' maxlength="20">
        <span id=typemarkimage><img 
            src="/images/BacoError.gif" align=absMiddle></span> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <input class=InputStyle  accesskey=Z name=typename size="30" onchange='checkinput("typename","typenameimage")' maxlength="30">
        <SPAN id=typenameimage><IMG 
            src="/images/BacoError.gif" align=absMiddle></SPAN> </td>
    </TR><tr><td class=Line colspan=2></td></tr>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <textarea class=InputStyle accesskey="Z" name="typedesc" cols="60"></textarea>
      </td>
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
      </BODY>
      </HTML>
