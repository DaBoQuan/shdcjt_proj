<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="VerifyPower" class="weaver.proj.VerifyPower" scope="page" />

<%
char flag = 2;
String taskrecordid = Util.null2String(request.getParameter("taskrecordid"));
String recordid = Util.null2String(request.getParameter("recordid"));
RecordSet.executeProc("Prj_Find_MaterialProcessbyid",recordid);
String prjid="";
String taskid="";
String material="";
String unit="";
String begindate="";
String enddate="";
String quantity="";
String cost="";
if(RecordSet.next()){
	prjid = RecordSet.getString("prjid");
	taskid = RecordSet.getString("taskid");
	material = RecordSet.getString("material");
	unit = RecordSet.getString("unit");
	begindate = RecordSet.getString("begindate");
	enddate = RecordSet.getString("enddate");
	quantity=RecordSet.getString("quantity");
	cost=RecordSet.getString("cost");
}
String ProjID = RecordSet.getString("prjid");

String logintype = ""+user.getLogintype();
/*Ȩ�ޣ�begin*/
boolean canview=false;
boolean canedit=false;
boolean iscreater=false;
boolean ismanager=false;
boolean ismanagers=false;
boolean ismember=false;
boolean isrole=false;
boolean isshare=false;
String iscustomer="0";

VerifyPower.init(request,response,ProjID);
if(logintype.equals("1")){
	iscreater = VerifyPower.isCreater();
	ismanager = VerifyPower.isManager();
	if(!iscreater && !ismanager){
		ismanagers = VerifyPower.isManagers();
	}
	if(!iscreater && !ismanager && !ismanagers){
		isrole = VerifyPower.isRole();
	}
}

if(iscreater || ismanager || ismanagers || isrole){
	canedit = true;
}

if(!canedit){
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
/*Ȩ�ޣ�end*/

RecordSet2.executeProc("Prj_ProjectInfo_SelectByID",ProjID);
if(RecordSet2.getCounts()<=0)
	response.sendRedirect("/proj/DBError.jsp?type=FindData_VP");
RecordSet2.first();

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdPRJ.gif";
String titlename = SystemEnv.getHtmlLabelName(1328,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",ProjMaterialProcessOperation.jsp?taskrecordid="+taskrecordid+"&recordid="+recordid+"&method=delete,_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:history.back(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM id=weaver action="ProjMaterialProcessOperation.jsp" method=post >
<input type="hidden" name="method" value="edit">
<input type="hidden" name="taskrecordid" value="<%=taskrecordid%>">
<input type="hidden" name="recordid" value="<%=recordid%>">
<input type="hidden" name="prjid" value="<%=prjid%>">
<input type="hidden" name="taskid" value="<%=taskid%>">

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

<TABLE class=viewform>
  <COLGROUP>
  <COL width="20%">
  <COL width=80%>
  <TBODY>
  <TR class=spacing>
          <TD class=line1 colSpan=2></TD></TR>
    <TR>
          <TD><%=SystemEnv.getHtmlLabelName(1328,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=inputstyle maxLength=20 size=10 name="material" onChange="checkinput('material','materialspan')" value=<%=material%>> <span 
            id=materialspan></span> </TD>
        </TR>  <TR class=spacing>
          <TD class=line colSpan=2></TD></TR>
    <TR>
          <TD><%=SystemEnv.getHtmlLabelName(1329,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=inputstyle maxLength=20 size=6 name="unit" value=<%=unit%>> <span 
            id=unitspan></span> </TD>
        </TR>
<TR class=spacing>
          <TD class=line colSpan=2></TD></TR>
	 <TR>
	 <TD><%=SystemEnv.getHtmlLabelName(1330,user.getLanguage())%></TD>
	  <TD class=Field><INPUT class=inputstyle maxLength=10 size=10 name="cost" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("cost")' value=<%=cost%>> <span 
		id=costspan></span> </TD>
	 </TR>
<TR class=spacing>
          <TD class=line colSpan=2></TD></TR>
	 <TR>
	 <TD><%=SystemEnv.getHtmlLabelName(1331,user.getLanguage())%></TD>
	  <TD class=Field><INPUT class=inputstyle maxLength=5 size=5 name="quantity" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("quantity")' value=<%=quantity%>><SPAN id=quantityimage></SPAN></TD>
	 </TR> <TR class=spacing>
          <TD class=line1 colSpan=2></TD></TR>    
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

</form>
<script language=vbs>

sub onShowrelateid()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	Prjrelateidspan.innerHtml = "<A href='/cpt/capital/CptCapital.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaver.relateid.value=id(0)
	else 
	Prjrelateidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.relateid.value=""
	end if
	end if
end sub
</script>
 <script language="javascript">
function submitData()
{if (check_form(weaver,'material'))
		weaver.submit();
}
</script>
</html>