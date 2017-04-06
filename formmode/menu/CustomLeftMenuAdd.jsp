<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuHandler" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo" %>

<%

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(17594,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(17596,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(18773,user.getLanguage());
String needfav ="1";
String needhelp ="";    

int menuID = Util.getIntValue(request.getParameter("id"));
int userid=0;
userid=user.getUID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link href="/css/Weaver.css" type=text/css rel=stylesheet>
	<SCRIPT language="javascript" src="../../js/weaver.js"></script>
  </head>
  
  <body>
  <%@ include file="/systeminfo/TopTitle.jsp" %>
  <%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
  
  <%
  RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:checkSubmit(),_self} " ;
  RCMenuHeight += RCMenuHeightStep ;

  RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",LeftMenuConfig.jsp,_self} " ;
  RCMenuHeight += RCMenuHeightStep ;
  %>
  
  <%@ include file="/systeminfo/RightClickMenu.jsp" %>

	<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="CustomLeftMenuOperation.jsp">
	<input name="operationType" type="hidden" value="add"/>
	<input name="parentID" type="hidden" value="<%=menuID%>"/>
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
		
		<TABLE class="Shadow">
			<tr>
				<td valign="top">
				
				
    <TABLE class=ViewForm>
		<COLGROUP>
		<COL width="20%">
		<COL width="80%">
		
		<TBODY>
		
                <TR class=Title>
				  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
				</TR>
				<TR class=Spacing>
				  <TD class=Line1 colSpan=2></TD>
				</TR>
                
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(18390,user.getLanguage())%></td>
				  <td class=Field><INPUT class=InputStyle maxLength=50  name="customMenuName" value="" onchange="checkinput('customMenuName','Nameimage')">
				  <SPAN id=Nameimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN></td>
				</tr>
				<TR><TD class=Line colSpan=2></TD></TR>

				<tr>
				  <td><%=SystemEnv.getHtmlLabelName(16208,user.getLanguage())%><br>(<%=SystemEnv.getHtmlLabelName(18391,user.getLanguage())%>)</td>
				  <td class=Field>
					<INPUT class=InputStyle maxLength=200 style="width:80%" name="customMenuLink" value="" onchange="checkinput('customMenuLink','linkImage')">
					<SPAN id=linkImage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
				  </td>
				</tr>

				<TR><TD class=Line colSpan=2></TD></TR>
				<tr>
				  <td><%=SystemEnv.getHtmlLabelName(338,user.getLanguage())%></td>
				  <td class=Field>
					
					<INPUT class=InputStyle maxLength=50  name="customMenuCViewIndex" value="">
					
					
				  </td>
				</tr>
                <TR><TD class=Line colSpan=2></TD></TR>
				<tr>
				  <td><%=SystemEnv.getHtmlLabelName(20235,user.getLanguage())%></td>
				  <td class=Field>
					
					<INPUT class=InputStyle maxLength=20  name="targetframe" value="">  <font color=red>(<%=SystemEnv.getHtmlLabelName(20236,user.getLanguage())%>)</font>
					
					
				  </td>
				</tr>
                <TR><TD class=Line colSpan=2></TD></TR>
		
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


</body>

<script LANGUAGE="JavaScript">

function checkSubmit(){
	if(check_form(frmMain,'customMenuName,customMenuLink')){
		window.frames["rightMenuIframe"].event.srcElement.disabled = true;
		frmMain.submit();
	}
}

function doCheck_form(){
	return check_form(frmMain,'customMenuName');
}

function doCheck_Input(){
	checkinput("customMenuCName","Nameimage");
}

</script>

</html>

