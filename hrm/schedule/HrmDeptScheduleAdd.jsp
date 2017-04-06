<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%
if(!HrmUserVarify.checkUserRight("HrmDeptScheduleAdd:Add", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language=VBS>
sub onShowMould(tdname,inputename)
	
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
		document.all(tdname).innerHtml = id(1)
		document.all(inputename).value=id(0)
	end if
end sub

sub onShowTime(spanname,inputename)
	returntime = window.showModalDialog("/systeminfo/Clock.jsp",,"dialogHeight:360px;dialogwidth:275px")
	document.all(spanname).innerHtml = returntime
	document.all(inputename).value=returntime
end sub
</script>  
<SCRIPT language=javascript>
function ItemCount_KeyPress()
{
 if(!((window.event.keyCode>=48) && (window.event.keyCode<=58)))
  {
     window.event.keyCode=0;
  }
}

function checknumber(objectname)
{	
	valuechar = document.all(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=":") isnumber = true ;}
	if(isnumber) document.all(objectname).value = "" ;
}
function submitData() {
 if(check_form(frmMain,'dept_id')){
 frmMain.submit();
 }
</SCRIPT>
</head>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(369,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(124,user.getLanguage());
String needfav ="1";
String needhelp ="";

boolean CanAdd = HrmUserVarify.checkUserRight("HrmDeptScheduleAdd:Add", user);
int dept_id=Util.getIntValue(request.getParameter("id"),0);
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(CanAdd){
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/hrm/schedule/HrmDeptScheduleList.jsp,_self} " ;
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
<FORM id=weaver name=frmmain action="HrmDeptScheduleOperation.jsp" method=post onsubmit="return check_form(this,'dept_id')">
<input class=inputstyle type="hidden" name="operation" value="insert">
<table class=ListStyle cellspacing=1 >
	<COLGROUP>
  	<COL width="30%">
  	<COL width="35%">
  	<COL width="35%">
	<TR class=Header> 
          <TH width="30%"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TH>
          <TH width="70%" colspan=2><button class=Browser onclick="onShowMould('deptname','dept_id')"></button>
          <span id=deptname>
          <%if(dept_id!=0){%><%=Util.toScreen(DepartmentComInfo.getDepartmentmark(dept_id+""),user.getLanguage())%>
          -<%=Util.toScreen(DepartmentComInfo.getDepartmentname(dept_id+""),user.getLanguage())%><%}%>
          </span>
          <input class=inputstyle type="hidden" name="dept_id" <%if(dept_id!=0){%>value="<%=dept_id%>"<%}%>></TH>
        </TR>
        <TR class=Header>
    	  <TD><%=SystemEnv.getHtmlLabelName(390,user.getLanguage())%></TD>
    	  <TD><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%></TD>
    	  <TD><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%></TD>
  	 </TR>
     <TR class=Line><TD colspan="3" ></TD></TR> 
<%
    rs.executeProc("HrmSchedule_Select_Default","");
    rs.next();
    try{
%>  	
  <TR class=datalight>
    <td><%=SystemEnv.getHtmlLabelName(392,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('monstarttime1span','monstarttime1')"></button>
    <span id="monstarttime1span"><%=Util.toScreen(rs.getString("monstarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="monstarttime1" value="<%=Util.toScreen(rs.getString("monstarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('monendtime1span','monendtime1')"></button>
    <span id="monendtime1span"><%=Util.toScreen(rs.getString("monendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="monendtime1" value="<%=Util.toScreen(rs.getString("monendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('monstarttime2span','monstarttime2')"></button>
    <span id="monstarttime2span"><%=Util.toScreen(rs.getString("monstarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="monstarttime2" value="<%=Util.toScreen(rs.getString("monstarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('monendtime2span','monendtime2')"></button>
    <span id="monendtime2span"><%=Util.toScreen(rs.getString("monendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="monendtime2" value="<%=Util.toScreen(rs.getString("monendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  
  <TR class=datadark>
    <td><%=SystemEnv.getHtmlLabelName(393,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('tuestarttime1span','tuestarttime1')"></button>
    <span id="tuestarttime1span"><%=Util.toScreen(rs.getString("tuestarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="tuestarttime1" value="<%=Util.toScreen(rs.getString("tuestarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('tueendtime1span','tueendtime1')"></button>
    <span id="tueendtime1span"></span><%=Util.toScreen(rs.getString("tueendtime1"),user.getLanguage())%>
    <input class=inputstyle type=hidden name="tueendtime1" value="<%=Util.toScreen(rs.getString("tueendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('tuestarttime2span','tuestarttime2')"></button>
    <span id="tuestarttime2span"><%=Util.toScreen(rs.getString("tuestarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="tuestarttime2" value="<%=Util.toScreen(rs.getString("tuestarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('tueendtime2span','tueendtime2')"></button>
    <span id="tueendtime2span"><%=Util.toScreen(rs.getString("tueendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="tueendtime2" value="<%=Util.toScreen(rs.getString("tueendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  <TR class=datalight>
    <td><%=SystemEnv.getHtmlLabelName(394,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('wedstarttime1span','wedstarttime1')"></button>
    <span id="wedstarttime1span"><%=Util.toScreen(rs.getString("wedstarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="wedstarttime1" value="<%=Util.toScreen(rs.getString("wedstarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('wedendtime1span','wedendtime1')"></button>
    <span id="wedendtime1span"><%=Util.toScreen(rs.getString("wedendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="wedendtime1" value="<%=Util.toScreen(rs.getString("wedendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('wedstarttime2span','wedstarttime2')"></button>
    <span id="wedstarttime2span"><%=Util.toScreen(rs.getString("wedstarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="wedstarttime2" value="<%=Util.toScreen(rs.getString("wedstarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('wedendtime2span','wedendtime2')"></button>
    <span id="wedendtime2span"><%=Util.toScreen(rs.getString("wedendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="wedendtime2" value="<%=Util.toScreen(rs.getString("wedendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  <TR class=datadark>
    <td><%=SystemEnv.getHtmlLabelName(395,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('thustarttime1span','thustarttime1')"></button>
    <span id="thustarttime1span"><%=Util.toScreen(rs.getString("thustarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="thustarttime1" value="<%=Util.toScreen(rs.getString("thustarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('thuendtime1span','thuendtime1')"></button>
    <span id="thuendtime1span"><%=Util.toScreen(rs.getString("thuendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="thuendtime1" value="<%=Util.toScreen(rs.getString("thuendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('thustarttime2span','thustarttime2')"></button>
    <span id="thustarttime2span"><%=Util.toScreen(rs.getString("thustarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="thustarttime2" value="<%=Util.toScreen(rs.getString("thustarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('thuendtime2span','thuendtime2')"></button>
    <span id="thuendtime2span"><%=Util.toScreen(rs.getString("thuendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="thuendtime2" value="<%=Util.toScreen(rs.getString("thuendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  <TR class=datalight>
    <td><%=SystemEnv.getHtmlLabelName(396,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('fristarttime1span','fristarttime1')"></button>
    <span id="fristarttime1span"><%=Util.toScreen(rs.getString("fristarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="fristarttime1" value="<%=Util.toScreen(rs.getString("fristarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('friendtime1span','friendtime1')"></button>
    <span id="friendtime1span"><%=Util.toScreen(rs.getString("friendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="friendtime1" value="<%=Util.toScreen(rs.getString("friendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('fristarttime2span','fristarttime2')"></button>
    <span id="fristarttime2span"><%=Util.toScreen(rs.getString("fristarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="fristarttime2" value="<%=Util.toScreen(rs.getString("fristarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('friendtime2span','friendtime2')"></button>
    <span id="friendtime2span"><%=Util.toScreen(rs.getString("friendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="friendtime2" value="<%=Util.toScreen(rs.getString("friendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  <TR class=datadark>
    <td><%=SystemEnv.getHtmlLabelName(397,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('satstarttime1span','satstarttime1')"></button>
    <span id="satstarttime1span"><%=Util.toScreen(rs.getString("satstarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="satstarttime1" value="<%=Util.toScreen(rs.getString("satstarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('satendtime1span','satendtime1')"></button>
    <span id="satendtime1span"><%=Util.toScreen(rs.getString("satendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="satendtime1" value="<%=Util.toScreen(rs.getString("satendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('satstarttime2span','satstarttime2')"></button>
    <span id="satstarttime2span"><%=Util.toScreen(rs.getString("satstarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="satstarttime2" value="<%=Util.toScreen(rs.getString("satstarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('satendtime2span','satendtime2')"></button>
    <span id="satendtime2span"><%=Util.toScreen(rs.getString("satendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="satendtime2" value="<%=Util.toScreen(rs.getString("satendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
  <TR class=datalight>
    <td><%=SystemEnv.getHtmlLabelName(398,user.getLanguage())%></td>
    <TD>
    <button class=Clock onclick="onShowTime('sunstarttime1span','sunstarttime1')"></button>
    <span id="sunstarttime1span"><%=Util.toScreen(rs.getString("sunstarttime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="sunstarttime1" value="<%=Util.toScreen(rs.getString("sunstarttime1"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('sunendtime1span','sunendtime1')"></button>
    <span id="sunendtime1span"><%=Util.toScreen(rs.getString("sunendtime1"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="sunendtime1" value="<%=Util.toScreen(rs.getString("sunendtime1"),user.getLanguage())%>">
    </TD>
    <TD>
    <button class=Clock onclick="onShowTime('sunstarttime2span','sunstarttime2')"></button>
    <span id="sunstarttime2span"><%=Util.toScreen(rs.getString("sunstarttime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="sunstarttime2" value="<%=Util.toScreen(rs.getString("sunstarttime2"),user.getLanguage())%>">-
    <button class=Clock onclick="onShowTime('sunendtime2span','sunendtime2')"></button>
    <span id="sunendtime2span"><%=Util.toScreen(rs.getString("sunendtime2"),user.getLanguage())%></span>
    <input class=inputstyle type=hidden name="sunendtime2" value="<%=Util.toScreen(rs.getString("sunendtime2"),user.getLanguage())%>">
    </TD>
  </TR>
<%
      }
      catch(Exception e){
        System.out.println(e.toString());
      }
    
%>    
</table>
</form>
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
</body>
</html>