<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="LeftMenuConfigHandler" class="weaver.systeminfo.menuconfig.LeftMenuConfigHandler" scope="page"/>
<%
int menuID = Util.getIntValue(request.getParameter("id"));
String edit = Util.null2String(request.getParameter("edit"));

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(17594,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(17596,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(18772,user.getLanguage());
if(edit.equals("sub")){
	titlename = SystemEnv.getHtmlLabelName(17594,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(17596,user.getLanguage())+" - " + SystemEnv.getHtmlLabelName(18773,user.getLanguage());
}
String needfav ="1";
String needhelp ="";    


int userid=0;
userid=user.getUID();
String targetFrame="";
String linkAddress="",customName="";
int viewIndex = 0;
String sql = "select a.linkAddress,a.customName,b.viewIndex,a.baseTarget from LeftMenuInfo a,LeftMenuConfig b WHERE a.id="+menuID+" AND a.id=b.infoid AND "+LeftMenuConfigHandler.getConfigWhere(user);
rs.executeSql(sql);
if(rs.next()){
	linkAddress = rs.getString("linkAddress");
	customName = rs.getString("customName");
	viewIndex = rs.getInt("viewIndex");
	targetFrame=rs.getString("baseTarget");
}
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
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:deleteMenu(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",LeftMenuConfig.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="CustomLeftMenuOperation.jsp">
<input name="operationType" type="hidden" value="edit"/>
<input type="hidden" name="menuID" value="<%=menuID%>"/>
<input type="hidden" name="edit" value="<%=edit%>"/>
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
		
<!--================================================================================-->		
<TABLE class=ViewForm>
<COLGROUP>
<COL width="20%">
<COL width="80%">
<TBODY>
<TR class=Title><TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH></TR>
<TR class=Spacing><TD class=Line1 colSpan=2></TD></TR>			 
<tr>
	<%if(edit.equals("sub")){%>
	<td><%=SystemEnv.getHtmlLabelName(18390,user.getLanguage())%></td>
	<%}else{%>
	<td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
	<%}%>
	<td class=Field>
		<INPUT class=InputStyle maxLength=50 style=""  name="customMenuName" value="<%=customName%>" onchange="checkinput('customMenuName','Nameimage')">
		<SPAN id=Nameimage></SPAN>
	</td>
</tr>
<TR><TD class=Line colSpan=2></TD></TR>
<%if(edit.equals("sub")){%>
<tr>
	<td><%=SystemEnv.getHtmlLabelName(16208,user.getLanguage())%><br>(<%=SystemEnv.getHtmlLabelName(18391,user.getLanguage())%>)</td>
	<td class=Field>
		<INPUT class=InputStyle maxLength=200 style="width:80%"  name="customMenuLink" value="<%=linkAddress%>"  onchange="checkinput('customMenuLink','linkImage')">
		<SPAN id=linkImage></SPAN>
	</td>
</tr>
<TR><TD class=Line colSpan=2></TD></TR>
<%}%>
<tr>
	<td><%=SystemEnv.getHtmlLabelName(338,user.getLanguage())%></td>
	<td class=Field><INPUT class=InputStyle maxLength=50  name="customMenuCViewIndex" value="<%=viewIndex%>"></td>
</tr>
<TR><TD class=Line colSpan=2></TD></TR>
<TR><TD class=Line colSpan=2></TD></TR>
				<tr>
				  <td><%=SystemEnv.getHtmlLabelName(20235,user.getLanguage())%></td>
				  <td class=Field>
					
					<INPUT class=InputStyle maxLength=20  name="targetframe" value="<%=targetFrame%>"> <font color=red>(<%=SystemEnv.getHtmlLabelName(20236,user.getLanguage())%>)</font>
					
					
				  </td>
				</tr>
<TR><TD class=Line colSpan=2></TD></TR>
</TBODY>
</TABLE>
<!--================================================================================-->		
		
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
function deleteMenu(){
	if(confirm("<%=SystemEnv.getHtmlLabelName(17048,user.getLanguage())%>?")){
		window.frames["rightMenuIframe"].event.srcElement.disabled = true;
		location.href = "CustomLeftMenuOperation.jsp?operationType=del&menuID=<%=menuID%>";
	}	
}

function checkSubmit(){
	if(check_form(frmMain,'customMenuName,customMenuLink')){
		frmMain.submit();
		window.frames["rightMenuIframe"].event.srcElement.disabled = true;
	}
}

function doCheck_form(){
	if(check_form(frmMain,'customMenuName')){
		frmMain.submit();
		window.frames["rightMenuIframe"].event.srcElement.disabled = true;
	}
}

function doCheck_Input(){
	checkinput("customMenuCName","Nameimage");
}

</script>

</html>

