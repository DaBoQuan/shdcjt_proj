<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="RpTrainPeoNumByDepManager" class="weaver.hrm.report.RpTrainPeoNumByDepManager" scope="page" />
<jsp:useBean id="TrainTypeComInfo" class="weaver.hrm.tools.TrainTypeComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(352,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(834,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_self} " ;
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
<%
String departmentid=Util.fromScreen(request.getParameter("departmentid"),user.getLanguage());
String startdate=Util.fromScreen(request.getParameter("startdate"),user.getLanguage());
String enddate=Util.fromScreen(request.getParameter("enddate"),user.getLanguage());
String direction=Util.fromScreen(request.getParameter("direction"),user.getLanguage());
if(direction.equals("")){
	direction="1";
}
//char separator = Util.getSeparator() ;
%>
<form name=frmmain method=post action="HrmRpTrainPeoNumByDep.jsp">
    <table class=viewFORM>
    <col width=10%> <col width=30%> <col width=10%> <col width=30%> <col width=10%> <col width=10%> 
    <tr class=title> 
      <th colspan=6><%=SystemEnv.getHtmlLabelName(324,user.getLanguage())%></th>
    </tr>
    <tr class=spacing> 
      <td class=line1 colspan=6></td>
    </tr>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
      <td class="field"><button class=Browser id=SelectDeparment onClick="onShowDepartment()"></button> 
        <span class=inputStyle id=departmentspan><%=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid),user.getLanguage())%></span> 
        <input id=departmentid type=hidden name=departmentid value="<%=departmentid%>">
      </td>
      <td><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%></td>
      <td class="field"><button class=calendar id=SelectDate onClick=getStartDate()></button>&nbsp; 
        <span id=startdatespan > 
        <%=startdate%> 
        </span> -&nbsp;&nbsp;<button class=calendar id=SelectDate2 onClick="getEndDate()"></button>&nbsp; 
        <span id=enddatespan " > 
        <%=enddate%> 
        </span> 
        <input type="hidden" name="startdate" value="<%=startdate%>">
        <input type="hidden" name="enddate" value="<%=enddate%>">
      </td>
	  <TD class="field"> 
        <INPUT  type=radio <%if (direction.equals("1")) {%>CHECKED<%}%> value=1 name=direction>
        <%=SystemEnv.getHtmlLabelName(1892,user.getLanguage())%></TD>
     <TD class="field"> 
        <INPUT  type=radio <%if (direction.equals("2")) {%>CHECKED<%}%> value=2 name=direction>
        <%=SystemEnv.getHtmlLabelName(1859,user.getLanguage())%></TD>
    </tr>
  </table>
</form>

<table class=ListStyle cellspacing=1 >
 <TR class=Header> 
<th colspan=4 align=left><%=SystemEnv.getHtmlLabelName(356,user.getLanguage())%></th>
<COL WIDTH=20%>
<COL WIDTH=60%>
<COL WIDTH=10% ALIGN=RIGHT>
<COL WIDTH=10% ALIGN=RIGHT>
<%
  int linecolor=0;
  int hasresult=0;
  ArrayList TrainPeoNumtotals=new ArrayList();
  ArrayList traintypeids=new ArrayList();
  int total=0;
  RpTrainPeoNumByDepManager.resetParameter();
  RpTrainPeoNumByDepManager.setDepartmentid(Util.getIntValue(departmentid,0));
  RpTrainPeoNumByDepManager.setStartdate(startdate);
  RpTrainPeoNumByDepManager.setEnddate(enddate);
  RpTrainPeoNumByDepManager.setDirection(direction);
  RpTrainPeoNumByDepManager.selectRpTrainPeoNumByDep();
  while(RpTrainPeoNumByDepManager.next()){
  	hasresult=1;
  	TrainPeoNumtotals.add(RpTrainPeoNumByDepManager.getTrainPeoNumTotal()+"");
  	traintypeids.add(RpTrainPeoNumByDepManager.getTrainTypeid()+"");
  }
  RpTrainPeoNumByDepManager.closeStatement();
%>
<%
	if(hasresult==0){
%>
  <tr><td colspan=4><%=SystemEnv.getHtmlNoteName(19,user.getLanguage())%></td></tr>
</table>
<%	}
	else{
		for(int i=0;i<TrainPeoNumtotals.size();i++){
			total+=Util.getIntValue((String)TrainPeoNumtotals.get(i),0);
		}
%>
  <tr class=header>
  	<td><%=SystemEnv.getHtmlLabelName(834,user.getLanguage())%></td>
  	<td>&nbsp;</td>
  	<td><%=SystemEnv.getHtmlLabelName(363,user.getLanguage())%></td>
  	<td>%</td>
  </tr>
    <TR class=Line><TD colspan="4" ></TD></TR> 
<%
int tempcount=0;
String temptype="";
for(int i=0;i<traintypeids.size();i++){
%>
  <tr <%if(linecolor==0){%> class=datalight <%} else {%> class=datadark <%}%>>
  	<td><%=Util.toScreen(TrainTypeComInfo.getTrainTypename(((String)traintypeids.get(i))),user.getLanguage())%></td>
  	<td>
		<TABLE height="100%" cellSpacing=0 width="100%">
	        <TBODY><TR>
<%
		int tempTrainPeoNumsum=Util.getIntValue((String) TrainPeoNumtotals.get(i),0);
		float resultpercent=0;
		resultpercent=(float)tempTrainPeoNumsum*100/(float)total;
		resultpercent=(float)((int)(resultpercent*100))/100;
		float tempother = 1-resultpercent;
%>
	          <TD class=redgraph width="<%=resultpercent%>%">&nbsp;</TD>
			 <TD width="<%=tempother%>%">&nbsp;</TD>
	        </TR></TBODY></TABLE>
	</td>
	<td><%=tempTrainPeoNumsum%></td>
	<td><%=resultpercent%></td>
  </tr>
<%
	if(linecolor==0)	linecolor=1;
	else linecolor=0;
}
%>
  <TR CLASS=Total STYLE=COLOR:RED;FONT-WEIGHT:BOLD>
     <TD><%=SystemEnv.getHtmlLabelName(523,user.getLanguage())%></TD>
     <TD></TD>
     <TD><%=total%></TD>
     <TD>100.00</TD>
  </TR>
</table>
<%
}	
%>
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
<script language=javascript>  
function submitData() {
 frmMain.submit();
}
</script>
<script language=vbs>
sub onShowDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&frmmain.departmentid.value)
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	departmentspan.innerHtml = id(1)
	frmmain.departmentid.value=id(0)
	else
	departmentspan.innerHtml = ""
	frmmain.departmentid.value=""
	end if
	end if
end sub
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>