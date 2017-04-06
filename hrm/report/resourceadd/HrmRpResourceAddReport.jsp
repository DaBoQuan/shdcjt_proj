<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
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
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(16022,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";

float resultpercent=0;
int total = 0;
int linecolor=0;

String fromdate=Util.fromScreen(request.getParameter("fromdate"),user.getLanguage());
String enddate=Util.fromScreen(request.getParameter("enddate"),user.getLanguage());

String sqlwhereyear = "";
String sqlwhere = "";
	
	sqlwhereyear+=" and (t1.startdate>='"+year+"-01-01' or ((startdate is null or startdate = '') and createdate>='"+year+"-01-01'))";
	if(rs.getDBType().equals("oracle")){
	sqlwhereyear+=" and ((t1.startdate<='"+year+"-12-31' and startdate is not null)or (startdate is null and (createdate is not null and createdate <='"+year+"-12-31')))";
	}else{
	sqlwhereyear+=" and ((t1.startdate<='"+year+"-12-31' and startdate is not null and startdate <>'')or ((startdate is null or startdate='')and (createdate is not null and createdate<>'' and createdate <='"+year+"-12-31')))";
	}


String sql = "select count(id) from HrmResource t1 where (t1.accounttype is null or t1.accounttype=0) and 4 = 4 "+sqlwhereyear;
rs.executeSql(sql);
rs.next();
total = rs.getInt(1);
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{Excel,/weaver/weaver.file.ExcelOut,ExcelOut} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/hrm/report/resourceadd/HrmRpResourceAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<iframe id="ExcelOut" name="ExcelOut" border=0 frameborder=no noresize=NORESIZE height="0%" width="0%"></iframe>
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
<form name=frmmain method=post action="HrmRpResourceAddReport.jsp">
<TABLE class=viewform>
  <TBODY> 
  <tr>
    <td width=10%><%=SystemEnv.getHtmlLabelName(15933,user.getLanguage())%></td>
    <td class=field>
      <INPUT class=inputStyle maxLength=4 size=4 name="year"    onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("year")' value="<%=year%>">
    </td>     
   </tr>  
  </TBODY> 
</TABLE>
<table class=ListStyle cellspacing=1 >
<tbody>
<tr class=header>
  <td><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1492,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1493,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1494,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1495,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1496,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1497,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1498,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1499,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1800,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1801,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1802,user.getLanguage())%></td>
  <td><%=SystemEnv.getHtmlLabelName(1803,user.getLanguage())%></td>
</tr>
<TR class=Line><TD colspan="13" ></TD></TR> 
<%
   int line = 0;
   ExcelFile.init ();
   String filename = SystemEnv.getHtmlLabelName(16023,user.getLanguage()) ;
   ExcelFile.setFilename(""+year+filename) ;

   // ���潨��һ��ͷ������ʽ, ����ϵͳ�еı�ͷ�����������ʽ!
   ExcelStyle es = ExcelFile.newExcelStyle("Header") ;
   es.setGroundcolor(ExcelStyle.WeaverHeaderGroundcolor) ;
   es.setFontcolor(ExcelStyle.WeaverHeaderFontcolor) ;
   es.setFontbold(ExcelStyle.WeaverHeaderFontbold) ;
   es.setAlign(ExcelStyle.WeaverHeaderAlign) ;
   
   ExcelSheet et = ExcelFile.newExcelSheet(""+year+filename) ;

   // ��������ÿһ�еĿ��, ���������, ������excelĬ�ϵĿ��  
   et.addColumnwidth(8000) ;
   
   ExcelRow er = null ;

   er = et.newExcelRow() ;
   er.addStringValue( SystemEnv.getHtmlLabelName(124,user.getLanguage()) , "Header" ) ; 
   for(int month = 1;month<13;month++){   
   	   String title = ""+month+Util.toScreen("��",user.getLanguage(),"0");
   	   er.addStringValue(""+title, "Header" ) ;
   }
   sql = "select distinct(t2.id) resultid from HrmResource t1,HrmDepartment t2 where (t1.accounttype is null or t1.accounttype=0) and t1.departmentid = t2.id ";
   rs2.executeSql(sql);
   while(rs2.next()){   
     String resultid = ""+rs2.getString(1);
     ExcelRow erdep = et.newExcelRow() ;
     String depname = Util.toScreen(DepartmentComInfo.getDepartmentname(resultid),user.getLanguage());
     erdep.addStringValue(depname);
     if(line%2==0){
     line++;
%>
<tr class=datalight>
<%}else{%><tr class=datadark><%line++;}%>
  <td><%=depname%></td>
<%     
     for(int month = 1;month<13;month++){   
	   String firstday = ""+year+"-"+Util.add0(month,2)+"-01";
	   String lastday = ""+year+"-"+Util.add0(month,2)+"-31";
	   sqlwhere=" and (t1.startdate>='"+firstday+"' or ((startdate is null or startdate = '') and createdate>='"+firstday+"'))";
	   if(rs.getDBType().equals("oracle")){
	   sqlwhere+=" and ((t1.startdate<='"+lastday+"' and startdate is not null)or ((startdate is null)and (createdate is not null and createdate <='"+lastday+"')))";
	   }else{
	   sqlwhere+=" and ((t1.startdate<='"+lastday+"' and startdate is not null and startdate <>'')or ((startdate is null or startdate='')and (createdate is not null and createdate <>'' and createdate <='"+lastday+"')))";
	   }
	   
	   sql = "select count(t1.id) resultcount from HrmResource t1 where (t1.accounttype is null or t1.accounttype=0) and t1.departmentid = "+resultid+sqlwhere;
	   //out.println(sql+"<br>");		     	   
	   rs.executeSql(sql);
	   rs.next();	   
	   String resultcount = ""+rs.getInt(1);
	   erdep.addStringValue(resultcount);
	   
%>
  <td><%=resultcount%></td>
<%	   	   	   
   } 
%>
</tr>
<%    
 }  
%>
</tbody>
</table>
</form>
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
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>