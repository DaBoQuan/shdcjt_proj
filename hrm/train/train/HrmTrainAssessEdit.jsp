<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.hrm.train.TrainLayoutComInfo" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="TrainTypeComInfo" class="weaver.hrm.tools.TrainTypeComInfo" scope="page" />
<jsp:useBean id="TrainPlanComInfo" class="weaver.hrm.train.TrainPlanComInfo" scope="page" />
<jsp:useBean id="TrainResourceComInfo" class="weaver.hrm.train.TrainResourceComInfo" scope="page" />
<html>
<%

	
String id = request.getParameter("id");
String trainid = "";
String day = "";
int result = 2;
String explain = "";
String sql = "select * from HrmTrainAssess where id = "+id;
rs.executeSql(sql);
while(rs.next()){
  trainid = Util.null2String(rs.getString("trainid"));
  day = Util.null2String(rs.getString("assessdate"));
  result = Util.getIntValue(rs.getString("implement"),2);
  explain = Util.toScreenToEdit(rs.getString("explain"),user.getLanguage());
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(532,user.getLanguage())+SystemEnv.getHtmlLabelName(678,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+SystemEnv.getHtmlLabelName(532,user.getLanguage())+SystemEnv.getHtmlLabelName(6102,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:dosave(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/hrm/train/train/HrmTrainAssess.jsp?trainid="+trainid+",_self} " ;
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

<FORM id=weaver name=frmMain action="TrainOtherOperation.jsp" method=post >

<TABLE class=ViewForm>
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">
  <TBODY>
  <TR class=Title>
    <TH colSpan=2><%=SystemEnv.getHtmlLabelName(6128,user.getLanguage())%></TH></TR>
  <TR class=Spacing>
    <TD class=Line1 colSpan=2 ></TD>
  </TR>               
        <tr>
          <td><%=SystemEnv.getHtmlLabelName(15696,user.getLanguage())%> </td>
          <td class=Field>
            <BUTTON class=Calendar id=selectstartdate onclick="getDate(dayspan,day)" onchange="checkinput('day','dayspan')"></BUTTON> 
            <SPAN id=dayspan ><%=day%></SPAN> 
            <input class=inputstyle type="hidden" id="day" name="day" value="<%=day%>"> 	      
	      </td>	   
        </tr> 
        <tr>
          <td><%=SystemEnv.getHtmlLabelName(15677,user.getLanguage())%></td>
          <td class=Field>
            <select class=inputstyle name=result value=<%=result%>>       
              <option value=0 <%if(result == 0){%>selected <%}%>><%=SystemEnv.getHtmlLabelName(15661,user.getLanguage())%></option>
              <option value=1 <%if(result == 1){%>selected <%}%>><%=SystemEnv.getHtmlLabelName(15660,user.getLanguage())%></option>
              <option value=2 <%if(result == 2){%>selected <%}%>><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%></option>
              <option value=3 <%if(result == 3){%>selected <%}%>><%=SystemEnv.getHtmlLabelName(15700,user.getLanguage())%></option>
              <option value=4 <%if(result == 4){%>selected <%}%>><%=SystemEnv.getHtmlLabelName(16132,user.getLanguage())%></option>
            </select>
          </td>
        </tr>      
        <tr>
          <td><%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%></td>
          <td class=Field>
             <textarea class=inputstyle cols=50 rows=4 name=explain value="<%=explain%>"><%=explain%></textarea>      
          </td>
        </tr>      
  </TBODY>
</TABLE> 
<input class=inputstyle type="hidden" name=operation> 
<input class=inputstyle type=hidden name=trainid value=<%=trainid%>>
<input class=inputstyle type=hidden name=id value=<%=id%>>
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

 <script language=vbs>
sub onShowResource(inputname,spanname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	    resourceids = id(0)
		resourcename = id(1)
		sHtml = ""
		resourceids = Mid(resourceids,2,len(resourceids))
		resourcename = Mid(resourcename,2,len(resourcename))
		inputname.value= resourceids
		while InStr(resourceids,",") <> 0
			curid = Mid(resourceids,1,InStr(resourceids,",")-1)
			curname = Mid(resourcename,1,InStr(resourcename,",")-1)
			resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
			resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
			sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
		wend
		sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
		spanname.innerHtml = sHtml
	else	
    	spanname.innerHtml = ""
    	inputname.value="0"
	end if
	end if
end sub
</script>
<script language=javascript>
function dosave(){
if(check_form(document.frmMain,'day')){      
    document.frmMain.operation.value="editassess";
    document.frmMain.submit();
    }
  } 
 </script>
 
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
