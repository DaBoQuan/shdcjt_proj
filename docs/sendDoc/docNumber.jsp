<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%
boolean canedit=false;
if(HrmUserVarify.checkUserRight("SendDoc:Manage",user)) {
	canedit=true;
   }

String name="";
String desc="";
String id=Util.null2String(request.getParameter("id"));
if(!id.equals("")){
	RecordSet.executeSql("select * from DocSendDocNumber where id = "+id);
	if(RecordSet.next()){
	 name=Util.null2String(RecordSet.getString("name"));
	 desc=Util.null2String(RecordSet.getString("desc_n"));

	}
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(16980,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(canedit){

if(!id.equals(""))
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
else
RCMenu += "{"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
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

<%if(canedit){%>
<FORM id=weaverA name=weaverA action="docNumberOperation.jsp" method=post  >
<%if(id.equals("")){%>
	<input class=inputstyle type="hidden" name="method" value="add">
<%}else{%>
	<input class=inputstyle type="hidden" name="method" value="edit">
	<input class=inputstyle type="hidden" name="id" value="<%=id%>">
<%}%>
<TABLE class=Viewform>
  <COLGROUP>
  <COL width="15%">
  <COL width=85%>
  <TBODY>
  <TR class=Spacing>
          <TD class=Sep1 colSpan=4></TD></TR>

          <TD><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD class=Field>
              <input name=name class=inputstyle style="width:60%" value="<%=Util.convertInput2DB(name)%>" onchange='checkinput("name","nameimage")'><SPAN id=nameimage><%if(name.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN>
		  </TD>
        </TR>
        <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
           <TR>
          <TD><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
          <TD class=Field>
              <input class=inputstyle name=desc  style="width:60%" value="<%if(!desc.equals("")){%><%=desc%><%}%>">
		  </TD>
        </TR>
       <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  </TBODY>
</TABLE>
</FORM>

<FORM id=weaverD  action="docNumberOperation.jsp" method=post>
<input class=inputstyle type="hidden" name="method" value="delete">

<TABLE class=form>
  <COLGROUP>
  <COL width="20%">
  <COL width=80%>
  <TBODY>
  <TR class=separator>
          <TD class=Sep1 colSpan=2></TD></TR>
           <TR>
          <TD colSpan=2><BUTTON  class=btnDelete  accessKey=D type=submit  onclick="return isdel()"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON></TD>
        </TR>
  </TBODY>
</TABLE>
<%}%>
	  <TABLE class=ListStyle cellspacing=1 >
        <TBODY>
	    <TR class=Header>
			<th width=10>&nbsp;</th>
			<th><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></th>
			<th><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></th>
	    </TR>
<TR class=Line style="height: 1px!important;"><TD colspan="4" style="padding: 0!important;" ></TD></TR>

<%
RecordSet.executeSql("select * from DocSendDocNumber order by id desc");
boolean isLight = false;
while(RecordSet.next())
{
		if(isLight)
		{%>
	<TR CLASS=DataDark>
<%		}else{%>
	<TR CLASS=DataLight>
<%		}%>

			<th width=10><%if(canedit){%><input class=inputstyle type=checkbox name=IDs value="<%=RecordSet.getString("id")%>"><%}%></th>
			<td><a href="docNumber.jsp?id=<%=RecordSet.getString("id")%>"><%=Util.forHtml(Util.null2String(RecordSet.getString("name")).replaceAll("'","\\'"))%></a></td>
			<td><%=Util.forHtml(Util.null2String(RecordSet.getString("desc_n")).replaceAll("'","\\'"))%></td>
    </tr>
<%
	isLight = !isLight;
}%>
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
</body>
</html>
<script language=javascript>
function submitData() {
 if(check_form(weaverA,"name")){
 weaverA.submit();
 }
}
</script>