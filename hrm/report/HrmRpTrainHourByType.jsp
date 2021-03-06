<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="TrainTypeComInfo" class="weaver.hrm.tools.TrainTypeComInfo" scope="page"/>
<jsp:useBean id="RpTrainHourByTypeManager" class="weaver.hrm.report.RpTrainHourByTypeManager" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(352,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(833,user.getLanguage());
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
String traintypeid=Util.fromScreen(request.getParameter("traintypeid"),user.getLanguage());
String startdate=Util.fromScreen(request.getParameter("startdate"),user.getLanguage());
String enddate=Util.fromScreen(request.getParameter("enddate"),user.getLanguage());
String indepartmentid = Util.fromScreen(request.getParameter("indepartmentid"),user.getLanguage());
%>
<form name=frmmain method=post action="HrmRpTrainHourByType.jsp">
    <table class=viewFORM>
    <col width=10%> <col width=40%> <col width=10%> <col width=40%> 
    <tr class=title> 
      <th colspan=4><%=SystemEnv.getHtmlLabelName(324,user.getLanguage())%></th>
    </tr>
    <tr class=spacing> 
      <td class=line1 colspan=4></td>
    </tr>
    <tr> 
      <TD><%=SystemEnv.getHtmlLabelName(807,user.getLanguage())%></TD>
      <TD class=Field> 
        <BUTTON class=Browser id=selecttraintypeid onClick="onShowTrainTypeID()"></BUTTON> 
        <SPAN class=inputStyle id=traintypeidspan><%=Util.toScreen(TrainTypeComInfo.getTrainTypename(traintypeid),user.getLanguage())%></SPAN> 
        <INPUT class=inputStyle id=traintypeid type=hidden name=traintypeid value="<%=traintypeid%>">
      </TD>
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
        <input type="hidden" name="indepartmentid" value="<%=indepartmentid%>">
	  </td>
    </tr>
  </table>
</form>

<table class=ListStyle cellspacing=1 >
 <TR class=Header> 
<th colspan=4 align=left><%=SystemEnv.getHtmlLabelName(356,user.getLanguage())%></th>
<COL WIDTH=20%><COL WIDTH=60%><COL WIDTH=10% ALIGN=RIGHT><COL WIDTH=10% ALIGN=RIGHT>
<%
  int linecolor=0;
  int hasresult=0;
  ArrayList trainhoursums=new ArrayList();
  ArrayList departmentids=new ArrayList();
  ArrayList resourceids=new ArrayList();

  int total=0;
  RpTrainHourByTypeManager.resetParameter();
  RpTrainHourByTypeManager.setTrainTypeid(Util.getIntValue(traintypeid,0));
  RpTrainHourByTypeManager.setStartdate(startdate);
  RpTrainHourByTypeManager.setEnddate(enddate);
  if(!indepartmentid.equals("")){
	RpTrainHourByTypeManager.setInDepartmentid(Util.getIntValue(indepartmentid,0));
  }
  RpTrainHourByTypeManager.selectRpTrainHourByType();

  while(RpTrainHourByTypeManager.next()){
  	hasresult=1;
  	trainhoursums.add(RpTrainHourByTypeManager.getTrainHourSum()+"");
	if(!indepartmentid.equals("")){
		resourceids.add(RpTrainHourByTypeManager.getResourceid()+"");
	}
	else{
		departmentids.add(RpTrainHourByTypeManager.getDepartmentid()+"");
	}
  }
  RpTrainHourByTypeManager.closeStatement();
%>
<%
	if(hasresult==0){
%>
  <tr><td colspan=4><%=SystemEnv.getHtmlNoteName(19,user.getLanguage())%></td></tr>
</table>
<%	}
	else{
		for(int i=0;i<trainhoursums.size();i++){
			total+=Util.getIntValue((String)trainhoursums.get(i),0);
		}
%>
  <tr class=header>
  	<td><%=SystemEnv.getHtmlLabelName(833,user.getLanguage())%></td>
  	<td>&nbsp;</td>
  	<td><%=SystemEnv.getHtmlLabelName(1890,user.getLanguage())%></td>
  	<td>%</td>
  </tr>
    <TR class=Line><TD colspan="4" ></TD></TR> 
<%
for(int i=0;i<trainhoursums.size();i++){
%>
  <tr <%if(linecolor==0){%> class=datalight <%} else {%> class=datadark <%}%>>
<% 	if(!indepartmentid.equals("")){%>
	<td><%=Util.toScreen(ResourceComInfo.getResourcename(((String)resourceids.get(i))),user.getLanguage())%></td>
<%	}
	else{
%>
  	<td><A href="HrmRpTrainHourByType.jsp?indepartmentid=<%=(String)departmentids.get(i)%>&traintypeid=<%=traintypeid%>&startdate=<%=startdate%>&enddate=<%=enddate%>">
	<%=Util.toScreen(DepartmentComInfo.getDepartmentname((String)departmentids.get(i)),user.getLanguage())%></A>
	</td>
<%  }
%>
  	<td>
		<TABLE height="100%" cellSpacing=0 width="100%">
	        <TBODY><TR>
<%
		int temptrainhoursum=Util.getIntValue((String) trainhoursums.get(i),0);
		float resultpercent=0;
		resultpercent=(float)temptrainhoursum*100/(float)total;
		resultpercent=(float)((int)(resultpercent*100))/100;
		float tempother = 1-resultpercent;
%>
	          <TD class=redgraph width="<%=resultpercent%>%">&nbsp;</TD>
			 <TD width="<%=tempother%>%">&nbsp;</TD>
	        </TR></TBODY></TABLE>
	</td>
	<td><%=temptrainhoursum%></td>
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
sub onShowTrainTypeID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/tools/TrainTypeBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	traintypeidspan.innerHtml = id(1)
	frmmain.traintypeid.value=id(0)
	else 
	traintypeidspan.innerHtml = ""
	frmmain.traintypeid.value="" 
	end if
	end if
end sub
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>