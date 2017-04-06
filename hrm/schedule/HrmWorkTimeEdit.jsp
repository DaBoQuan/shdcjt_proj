<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.file.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language = "javascript" src = "/js/weaver.js"></script>
</head>

<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(16731 , user.getLanguage()) ;
String needfav ="1";
String needhelp ="";

boolean CanAdd = true ; //HrmUserVarify.checkUserRight("HrmScheduleMaintanceAdd:Add", user);

String resourceidpar = Util.null2String(request.getParameter("resourceid"));
String departmentidpar = Util.null2String(request.getParameter("departmentid"));
String workdatepar = Util.null2String(request.getParameter("workdate"));
String isself = Util.null2String(request.getParameter("isself"));

if(!resourceidpar.equals("") || !departmentidpar.equals("") ) isself = "1" ;


Calendar todaycal = Calendar.getInstance ();
String month = Util.add0(todaycal.get(Calendar.MONTH)+1,2);
String year = Util.add0(todaycal.get(Calendar.YEAR),4);
if(workdatepar.equals("")) workdatepar = year + "-" + month ; 

String sql = "" ;
int selectcolcount = 0 ;
int colwidth = 0 ;
ArrayList shiftids = new ArrayList() ; 
ArrayList shiftnames = new ArrayList() ; 
ArrayList reesourceshiftids = new ArrayList() ; 
ArrayList resouceworkcounts = new ArrayList() ; 

if(isself.equals("1")) {
    String sqlwhere1 = "";
    String sqlwhere2 = "";

    if(!resourceidpar.equals("")) { 
        sqlwhere1 += " and resourceid =" + resourceidpar  ; 
        sqlwhere2 += " and id =" + resourceidpar  ; 
    } 

    if(!departmentidpar.equals("")) { 
        sqlwhere1 += " and resourceid in (select id from HrmResource where departmentid = " + departmentidpar +")" ; 
        sqlwhere2 =  " and departmentid = " + departmentidpar ; 
    } 

    if(!workdatepar.equals("")) { 
        sqlwhere1 += " and workdate ='" + workdatepar + "'" ; 
    } 

    sql = " select id from hrmresource where status in (0,1,2,3) " + sqlwhere2 + " order by departmentid " ;


    // �õ����е�ǰ���Ű����࣬���뻺��
    RecordSet.executeSql("select id, shiftname from HrmArrangeShift where ishistory='0' order by id ") ; 
    while ( RecordSet.next() ) { 
        String id = Util.null2String(RecordSet.getString("id")) ; 
        String shiftname = Util.toScreen(RecordSet.getString("shiftname") , user.getLanguage()) ; 

        shiftids.add(id) ; 
        shiftnames.add(shiftname) ; 
    } 

    selectcolcount = shiftids.size() + 3 ;
    colwidth = 65/(shiftids.size()+1) ;

    // �õ�ѡ��������Դ��Χ��ʱ�䷶Χ�ڵ����г�����Ϣ���뻺�棬��������Դ���Ű�������Ϊ����
    RecordSet.executeSql(" select a.* from HrmWorkTimeCount a , Hrmresource b where a.resourceid = b.id and b.status in ( 0,1,2,3 ) " + sqlwhere1 ) ; 
    while( RecordSet.next() ) { 
        String resourceid = Util.null2String(RecordSet.getString("resourceid")) ; 
        String shiftid = Util.null2String(RecordSet.getString("shiftid")) ; 
        String workcount = Util.null2String(RecordSet.getString("workcount")) ; 
        
        reesourceshiftids.add(resourceid + "_" + shiftid) ; 
        resouceworkcounts.add(workcount) ; 
    } 
}


%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doBack(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="0" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM id=frmmain name=frmmain method=post action="HrmWorkTimeEdit.jsp">
<input class=inputstyle type="hidden" name="operation" value=save>
<input type="hidden" name="isself" value="1">
<table class=Viewform>
  <tbody>
  <COLGROUP>   
    <COL width="20%">
    <COL width="20%"> 
    <COL width="30%">
    <COL width="30%">
    <TR class=Title>
    <TH colSpan=3><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
  </TR>
  <TR class=Spacing style="height:2px">
    <TD class=Line1 colSpan=6 ></TD>
  </TR>

  <tr>
    <td><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
    <td class=field>

      <input class="wuiBrowser" type=hidden name=departmentid value="<%=departmentidpar%>" 
	  _url="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp"
	  _displayText="<%=DepartmentComInfo.getDepartmentname(departmentidpar)%>">
    </td>
     <td><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%></td>
    <td class=field>
       <BUTTON class=Calendar id=selectworkdate onclick="getSdDate(workdatespan,workdate)"></BUTTON> 
       <SPAN id=workdatespan ><%=workdatepar%></SPAN>
       <input class=inputstyle type="hidden" name="workdate" value="<%=workdatepar%>">
    </td>
    <td>
 </tr>  
<TR style="height:1px"><TD class=Line colSpan=4></TD></TR>
  <tr>
    <td><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></td>
    <td class=field>

      <input class="wuiBrowser" type=hidden name=resourceid value="<%=resourceidpar%>" 
	  _url="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
	  _displayText="<%=ResourceComInfo.getResourcename(resourceidpar)%>">
    </td>
    <td></td>
    <td></td>
  </tr>  
<TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
  </tbody>
</table>
<br>

<% if(isself.equals("1")) { %>
<TABLE class = ListStyle cellspacing=1>
  <TBODY>
  <TR class = Header>
    <TH colspan=<%=selectcolcount%>><%=SystemEnv.getHtmlLabelName(16732,user.getLanguage())%></TH>
  </TR>
  <!--TR class = separator>
    <TD class = Sep1 colspan=<%=selectcolcount%>></TD>
  </TR-->
  <TR class = Header>
    <TH width="20%"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TH>
    <TH width="15%"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></TH>
    <TH width="<%=colwidth%>%"><%=SystemEnv.getHtmlLabelName(16254,user.getLanguage())%></TH>
  <%
    for(int i = 0 ; i < shiftnames.size() ; i++ ) { 
        String shiftname = (String) shiftnames.get(i) ; 
  %>
    <TH width="<%=colwidth%>%"><%=shiftname%></TH>
  <% } %>
    </TR>
  <%
    boolean isLight = false ; 
    String currentdepartmentid = "" ;
    int shiftindex = 0 ;
    String workcount = "" ;
    RecordSet.executeSql(sql) ; 
    while(RecordSet.next()) { 
        String resourceid = Util.null2String(RecordSet.getString("id")) ;
        String departmentid = Util.null2String(ResourceComInfo.getDepartmentID(resourceid)) ;
        isLight = !isLight ; 
  %> 
       <TR class='<%=( isLight ? "datalight" : "datadark" )%>'> 
        <TD>
        <% if( !currentdepartmentid.equals(departmentid) ) {
                currentdepartmentid = departmentid ;
        %>
        <%=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid),user.getLanguage())%>
        <% } %>
        </TD>
        <TD><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid) , user.getLanguage())%></TD>
        <TD>
        <%  shiftindex = reesourceshiftids.indexOf(resourceid + "_0") ; 
            if( shiftindex != -1 ) workcount = (String) resouceworkcounts.get( shiftindex ) ;
            else workcount = "" ;
        %>
        <input class=inputstyle type="text" size=7 name="<%=resourceid%>_0" value="<%=workcount%>" onKeyPress = "ItemCount_KeyPress()" onBlur = 'checknumber("<%=resourceid%>_0")'>
        </TD>
  <%
        for(int j = 0 ; j < shiftids.size() ; j++ ) {
            String shiftid = (String) shiftids.get(j) ; 
            shiftindex = reesourceshiftids.indexOf(resourceid + "_" + shiftid) ; 
            if( shiftindex != -1 ) workcount = (String) resouceworkcounts.get( shiftindex ) ;
            else workcount = "" ;
        %>
        
        <TD><input class=inputstyle type="text" size=7 name="<%=resourceid%>_<%=shiftid%>" value="<%=workcount%>" onKeyPress = "ItemCount_KeyPress()" onBlur = 'checknumber("<%=resourceid%>_<%=shiftid%>")'></TD>
  <%    } %>
     </TR> 
  <% } %>
  </TBODY>
 </TABLE>
 <%}%>
</form>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="0" colspan="3"></td>
</tr>
</table>
<script language=javascript>  
function submitData() {
    document.forms[0].submit();
}

function doSave(obj){
	document.frmmain.operation.value = "save" ; 
    document.frmmain.action = "HrmWorkTimeOperation.jsp" ;
    obj.disabled = true ;
	document.frmmain.submit() ; 	
} 

function doBack(){
    document.frmmain.action = "HrmWorkTimeList.jsp" ;
    document.frmmain.isself.value= ""  ;
	document.frmmain.submit() ; 	
} 
</script>

<script language=vbs>
sub onShowResourceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	resourceidspan.innerHtml = id(1)
	frmmain.resourceid.value=id(0)
	else 
	resourceidspan.innerHtml = ""
	frmmain.resourceid.value=""
	end if
	end if
end sub

sub onShowDepartment(spanname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&inputname.value)
	issame = false 
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else
	spanname.innerHtml = ""
	inputname.value=""
	end if	
	end if
end sub
</script>

</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>