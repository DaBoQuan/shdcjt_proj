<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.teechart.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="GraphFile" class="weaver.file.GraphFile" scope="session"/>
<jsp:useBean id="GraphFile2" class="weaver.file.GraphFile" scope="session"/>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String year = Util.null2String(request.getParameter("year"));
if(year.equals("")){
Calendar todaycal = Calendar.getInstance ();
year = Util.add0(todaycal.get(Calendar.YEAR), 4);
}

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(15983,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";

float resultpercent=0;
int total = 0;
int linecolor=0;

String fromdate=Util.fromScreen(request.getParameter("fromdate"),user.getLanguage());
String enddate=Util.fromScreen(request.getParameter("enddate"),user.getLanguage());

String sqlwhere = "";

if(!fromdate.equals("")){
	sqlwhere+=" and t1.changedate>='"+fromdate+"'";
}
if(!enddate.equals("")){
	sqlwhere+=" and (t1.changedate<='"+enddate+"' or t1.changedate is null)";
}

String sql = "select count(id) from HrmStatusHistory t1 where type_n = 2 "+sqlwhere;
rs.executeSql(sql);
rs.next();
total = rs.getInt(1);

String sqlstr = "select t3.id resultid, count(t1.id) resultcount from HrmStatusHistory t1,HrmJobtitles t2,HrmDepartment t3 where type_n = 2 and t1.oldjobtitleid = t2.id and t2.jobdepartmentid = t3.id "+sqlwhere+" group by t3.id";
rs.executeSql(sqlstr);
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15984,user.getLanguage())+",/hrm/report/hire/HrmRpHireTime.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15981,user.getLanguage())+",/hrm/report/hire/HrmHireReport.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15729,user.getLanguage())+",/hrm/report/hire/HrmRpHireDetail.jsp,_self} " ;
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
<form name=frmmain method=post action="HrmRpHire.jsp">
<table class=ViewForm>
<colgroup>
<col width="15%">
<col width="35%">
<col width="15%">
<col width="35%">
<tbody>
<TR class= Spacing>
  <TD colspan=4 class=line1></TD>
</TR>
<tr>    
    <td width=10%><%=SystemEnv.getHtmlLabelName(15985,user.getLanguage())%></td>
    <td class=field colSpan=3>
    <BUTTON type=button class=calendar id=SelectDate onclick=getfromDate()></BUTTON>&nbsp;
    <SPAN id=fromdatespan ><%=Util.toScreen(fromdate,user.getLanguage())%></SPAN>
    <input class=inputstyle type="hidden" name="fromdate" value=<%=fromdate%>>
    －<BUTTON type=button class=calendar id=SelectDate onclick=getendDate()></BUTTON>&nbsp;
    <SPAN id=enddatespan ><%=Util.toScreen(enddate,user.getLanguage())%></SPAN>
    <input class=inputstyle type="hidden" name="enddate" value=<%=enddate%>>  
    </td>      
</tr>
<TR style="height:2px"><TD class=Line colSpan=4></TD></TR> 
</tbody>
</table>
<table class=ListStyle cellspacing=1 >
<colgroup>
<col width="5%">
<tbody>
  <TR class=Header>
    <TH colspan=5><%=SystemEnv.getHtmlLabelName(15945,user.getLanguage())%>: <%=total%></TH>
  </TR>
  <tr class=header>
    <td></td>
    <td><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
    <td><%=SystemEnv.getHtmlLabelName(352,user.getLanguage())%></td>
    <td><%=SystemEnv.getHtmlLabelName(1859,user.getLanguage())%></td>
    <td><%=SystemEnv.getHtmlLabelName(336,user.getLanguage())%></td>
  </tr>
<TR class=Line><TD colspan="5" ></TD></TR> 
  <%
   rs.first();
   	PieTeeChart pie=TeeChartFactory.createPieChart(SystemEnv.getHtmlLabelName(15986,user.getLanguage()),600,350);
//	pie.isDebug();

/*   GraphFile.init ();
   GraphFile.setPicwidth ( 500 ); 
   GraphFile.setPichight ( 350 );
   GraphFile.setLeftstartpos ( 30 );
   GraphFile.setHistogramwidth ( 15 );
   GraphFile.setPicquality( (new Float("10.0")).floatValue() ) ;
   GraphFile.setPiclable ( SystemEnv.getHtmlLabelName(15986,user.getLanguage()) );
   GraphFile.newLine ();
   GraphFile.addPiclinecolor("#660033") ;
   GraphFile.addPiclinelable("Line") ;
*/   
   int totalnum = 0;
   if(total!=0){
     do{
	String resultid = rs.getString(1);
	int resultcount = rs.getInt(2);
	if(resultcount < 0){
	  resultcount = 0;
	}
	totalnum+=resultcount;
	resultpercent=(float)resultcount*100/(float)total;
	resultpercent=(float)((int)(resultpercent*100))/(float)100;			
	
   %>
  <TR <%if(linecolor==0){%>class=datalight <%} else {%> class=datadark <%}%>>
    <td><a href="HrmRpHireDetail.jsp?olddepartment=<%=resultid%>">>>></a></td>
    <TD><a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=resultid%>"> <%=Util.toScreen(DepartmentComInfo.getDepartmentname(resultid),user.getLanguage())%></TD>
    <TD height="100%">        
	<% String className=(resultpercent==100)?"redgraph":"greengraph"; %>
        <TABLE height="100%" cellSpacing=0 class="<%=className%>" width="<%=resultpercent%>%">                       
        <TBODY>
        <TR>
        <TD width="100%" height="100%"><img src="/images/ArrowUpGreen.gif" width=1 height=1></td>
        </TR>
        </TBODY>
        </TABLE>    
    </TD>
    <TD><%=resultcount%></TD>
    <TD><%=resultpercent%>%</TD>
    </TR>
    <%		if(linecolor==0) linecolor=1;
    		else	linecolor=0;
    		
			pie.addSeries(Util.toScreen(DepartmentComInfo.getDepartmentname(resultid),user.getLanguage()),resultcount);

//            GraphFile.addConditionlable(Util.toScreen(DepartmentComInfo.getDepartmentname(resultid),user.getLanguage())) ;		
//            GraphFile.addPiclinevalues ( ""+resultcount , Util.toScreen(DepartmentComInfo.getDepartmentname(resultid),user.getLanguage()) , GraphFile.random , null  );    		
    	}while(rs.next());
    	
		pie.addSeries(SystemEnv.getHtmlLabelName(375,user.getLanguage()),total-totalnum);
		
//        GraphFile.addConditionlable( SystemEnv.getHtmlLabelName(375,user.getLanguage()) ) ;		
//		GraphFile.addPiclinevalues ( ""+(total-totalnum ), SystemEnv.getHtmlLabelName(375,user.getLanguage()) , GraphFile.random , null  );    		    		
	}
	int colcount = GraphFile.getConditionlableCount() + 1 ;
	%>  
</table>
<br>
<!--<TABLE class=ViewForm>
  <TBODY>     
  <TR> 
    <TD align=center>
        <img src='/weaver/weaver.file.GraphOut?pictype=3'>
    </TD>
  </TR>     
  </TBODY> 
</TABLE>-->
</form>
<div class="chart">
<%
if ("true".equals(isIE)){
	pie.print(out);
}else{   %>
<p height="100%" width="100%" align="center" style="color:red;font-size:14px;">
			您当前使用的浏览器不支持【报表视图】，如需使用该功能，请使用IE浏览器！
</p>
<%} %>	
<br>
</div>
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
<script language=vbs>
sub onShowOldJobtitle()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/jobtitles/JobTitlesBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	oldjobtitlespan.innerHtml = id(1)
	frmmain.oldjobtitle.value=id(0)
	else 
	oldjobtitlespan.innerHtml = ""
	frmmain.oldjobtitle.value=""
	end if
	end if
end sub
sub onShowNewJobtitle()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/jobtitles/JobTitlesBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	newjobtitlespan.innerHtml = id(1)
	frmmain.newjobtitle.value=id(0)
	else 
	newjobtitlespan.innerHtml = ""
	frmmain.newjobtitle.value=""
	end if
	end if
end sub
sub onShowOldDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&frmmain.olddepartment.value)	
	if id(0)<> 0 then	
	olddepartmentspan.innerHtml = id(1)
	frmmain.olddepartment.value=id(0)
	else
	olddepartmentspan.innerHtml = ""
	frmmain.olddepartment.value=""	
	end if
end sub
sub onShowNewDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&frmmain.newdepartment.value)	
	if id(0)<> 0 then	
	newdepartmentspan.innerHtml = id(1)
	frmmain.newdepartment.value=id(0)
	else
	newdepartmentspan.innerHtml = ""
	frmmain.newdepartment.value=""	
	end if
end sub
</script>
<script language=javascript>  
function submitData() {
 frmmain.submit();
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>