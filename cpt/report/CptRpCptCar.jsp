<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>

<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</head>
<%
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String currentdate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);

String userid =""+user.getUID();

/*Ȩ���ж�,�ʲ�����Ա�Լ��������ϼ�*/
boolean canView = false;
ArrayList allCanView = new ArrayList();
String sql = "select resourceid from HrmRoleMembers where roleid = 32 ";
RecordSet.executeSql(sql);
while(RecordSet.next()){
	String tempid = RecordSet.getString("resourceid");
	allCanView.add(tempid);
	AllManagers.getAll(tempid);
	while(AllManagers.next()){
		allCanView.add(AllManagers.getManagerID());
	}
}// end while

for (int i=0;i<allCanView.size();i++){
	if(userid.equals((String)allCanView.get(i))){
		canView = true;
	}
}
if(!canView) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
/*Ȩ���жϽ���*/

String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(15345,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<DIV class=HdrProps></DIV>
<FORM method=post name=frmain>
  <TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
    <TBODY> 
    <TR> 
 <TD vAlign=top width="84%">
 <BUTTON class=btnSearch accessKey=S onClick="onSearch()"><U>S</U>-<%=SystemEnv.getHtmlLabelName(15329,user.getLanguage())%></BUTTON> 
         <TABLE class=Form>
          <COLGROUP> <COL width="49%"> <COL width=10> <COL width="49%"> <TBODY> 
          <TR> 
            <TD vAlign=top> 
              <TABLE width="100%">
                <COLGROUP> <COL width="30%"> <COL width="70%"> <TBODY> 
               
                <TR class=Separator> 
                  <TD class=Sep1 colSpan=2></TD>
                </TR>
                <tr> 
                  <td><%=SystemEnv.getHtmlLabelName(920,user.getLanguage())%></td>
                  <td class=Field> 
                   <button class=Browser onClick='onShowAssetCapital(carspan,car)'></button>
	<span class=saveHistory id=carspan></span> 
	<input type='hidden' name='car' id='car'>
    	</td>
                </tr>
                <tr> 
                  <td><%=SystemEnv.getHtmlLabelName(740,user.getLanguage())%></td>
                  <td class=Field> 
         <button class=Browser onClick='getDate(begindatespan,begindate)'></button> 
         <span class=saveHistory id=begindatespan><%=currentdate%></span> 
    	<input type='hidden' name='begindate' id='begindate' value="<%=currentdate%>">
    	</td>
     
                </tr>
                <tr> 
                  <td><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></td>
                  <td class=Field> 
        <button class=Browser onClick='getDate(enddatespan,enddate)'></button> 
         <span class=saveHistory id=enddatespan><%=currentdate%></span> 
    	<input type='hidden' name='enddate' id='enddate' value="<%=currentdate%>"></td>
     
                </tr>
                </TBODY> 
              </TABLE>
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
      </TD>
    </TR>
    </TBODY>
  </TABLE>
</FORM>
<SCRIPT language=javascript>
function onSearch(){
	document.frmain.action="CptRpCptCarResult.jsp";
	frmain.submit();
}
</SCRIPT>
<SCRIPT language=VBS>
sub onShowAssetCapital(spanname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp?sqlwhere=where capitalgroupid=9 ")
	if NOT isempty(id) then
	    if id(0)<> "" and id(0)<> "0" then
		spanname.innerHtml = "<a href='/cpt/capital/CptCapital.jsp?id="&id(0)&"'>"&id(1)&"</a>"
		inputname.value=id(0)
		else
		spanname.innerHtml =  "<img src='/images/BacoError.gif' align=absmiddle>"
		inputname.value=""
		end if
	end if
end sub

</SCRIPT>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
