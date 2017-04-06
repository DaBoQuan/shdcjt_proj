<%@ page import="weaver.general.Util,
                 weaver.hrm.resign.ResignProcess,
                 weaver.hrm.resign.DebtDetail" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="RequestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/>


<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%
String id=Util.null2String(request.getParameter("id"));
//��ǰ�û�Ϊ��¼���˻������ϼ����߾��С���ְ������Ȩ����ɲ鿴��ҳ��
String userId = "" + user.getUID();
String managerId = ResourceComInfo.getManagerID(id);
if(!userId.equals(id) && !userId.equals(managerId) && !HrmUserVarify.checkUserRight("Resign:Main", user)){
	response.sendRedirect("/notice/noright.jsp");
	return;
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(17573,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%





boolean hasNextPage=false;


int total=Util.getIntValue(Util.null2String(request.getParameter("total")),1);
int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
int perpage=Util.getIntValue(Util.null2String(request.getParameter("perpage")),10);
ArrayList debts=ResignProcess.getDebtsDetail(id,start,perpage,user.getLanguage());
if(total>start*perpage){
	hasNextPage=true;
}


%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


<FORM id=weaver name=frmmain method=post action="Debts.jsp">
<input name=start type=hidden value="<%=start%>">
<input name=total type=hidden value="<%=total%>">
<input name=id type=hidden value="<%=id%>">
<input name=perpage type=hidden value="<%=perpage%>">
</form>
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

<!-- 
<TABLE class=ListStyle cellspacing=1>
  <TBODY>
  
  <TR class=Header>
  <th ><%=SystemEnv.getHtmlLabelName(15397,user.getLanguage())%></th>
  <th ><%=SystemEnv.getHtmlLabelName(15398,user.getLanguage())%></th>
  <th ><%=SystemEnv.getHtmlLabelName(874,user.getLanguage())%></th>
  <th ><%=SystemEnv.getHtmlLabelName(793,user.getLanguage())%></th>
  </tr>
  <TR class=Line><TD colspan=4 ></TD></TR>
  <%
boolean islight=true;
int totalline=1;

Iterator iter=debts.iterator();
while(iter.hasNext()){
        DebtDetail debt=(DebtDetail)iter.next();
	 String occurdate = debt.getDate();
         String amount = debt.getMoney();
         String credenceno = debt.getReceiptNo();
         String releatedid = debt.getReqid();
         String releatedname = debt.getRelatedReq();
	
	
%>
    <tr <%if(islight){%> class=datalight <%} else {%> class=datadark <%}%>>
    <td ><%=occurdate%>
  </td>
  <td ><%=amount%>
  </td>
  <td ><%=credenceno%>
  </td>
  <td ><A
  href="/workflow/request/ViewRequest.jsp?requestid=<%=releatedid%>"><B><%=releatedname%></B></A>&nbsp;
  </td>
  
  
  </tr>
  

<%
	islight=!islight;
	if(hasNextPage){
		totalline+=1;
		if(totalline>perpage)	break;
	}
}
%>
  </tbody>
</table>
-->


<table class=ListStyle cellspacing=1 >
    <col width=15%>
    <col width=15%>
    <col width=30%>
    <col width=40%>
    <tr class=Header><th colspan=4><%=SystemEnv.getHtmlLabelName(18798,user.getLanguage())%></th></tr>
    <TR class=Spacing><TD class=Line1 colSpan=4></TD></TR>
    <tr class=header>
        <td><%=SystemEnv.getHtmlLabelName(15397,user.getLanguage())%></td>
        <td><%=SystemEnv.getHtmlLabelName(15398,user.getLanguage())%></td>
        <td><%=SystemEnv.getHtmlLabelName(874,user.getLanguage())%></td>
        <td><%=SystemEnv.getHtmlLabelName(793,user.getLanguage())%></td>
    </td></tr>
    <TR class=Line><TD colspan="4" ></TD></TR> 
<%
    if( !id.equals("") ) {
		//"order by occurdate" added by lupeng 2004.05.13 for TD448.
        String sql="select * from fnaloaninfo where organizationtype=3 and organizationid="+id+" order by occurdate";

         islight=true;
        RecordSet.executeSql(sql);
        while(RecordSet.next()){
            String tmpid= Util.null2String( RecordSet.getString("id") ) ;
            String tmprequestid= Util.null2String( RecordSet.getString("requestid") ) ;
            String tmprequestname= Util.null2String( RequestComInfo.getRequestname(tmprequestid));
            String tmpamount= Util.null2String( RecordSet.getString("amount") ) ;
            String tmpoccurdate= Util.null2String( RecordSet.getString("occurdate") ) ;
            String tmpdebitremark= Util.null2String( RecordSet.getString("debitremark") ) ;
            String tmptype= Util.null2String( RecordSet.getString("loantype") ) ;
            String manager= Util.null2String( RecordSet.getString("processorid") ) ;

            if(!tmptype.equals("1")) tmpamount = ""+Util.getDoubleValue(tmpamount,0) ;
%>
    <tr <%if(islight){%> class=datalight <%} else {%> class=datadark<%}%>>
        <td><%=tmpoccurdate%></td>
        <td><%=tmpamount%></td>
        <td><A href="FnaPersonalReturnView.jsp?paraid=<%=tmpid%>">No:<%=tmpdebitremark%></A></td>
        <td>
        <%if(tmptype.equals("2")){%><%=SystemEnv.getHtmlLabelName(15399,user.getLanguage())%> (������:<%=Util.toScreen(ResourceComInfo.getResourcename(manager),user.getLanguage())%>)<%} else {%>
        <a href="/workflow/request/ViewRequest.jsp?requestid=<%=tmprequestid%>">
        <%=tmprequestname%></a>
        <%}%>
        </td>
    </tr>
<%  
            islight=!islight;
        }
    

        String loanamount= "" ;
        RecordSet.executeSql("select sum(amount) as amount from fnaloaninfo where organizationtype=3 and organizationid="+id);
        if( RecordSet.next() ) loanamount= Util.null2String( RecordSet.getString("amount") );
%>
    <tr class=TOTAL style="FONT-WEIGHT: bold; COLOR: red">
        <td><%=SystemEnv.getHtmlLabelName(18801,user.getLanguage())%></td>
        <td><%=loanamount%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
<%  }   %>
</TABLE>



<table align=right>
   <tr>
   <td>&nbsp;</td>
   <td>
   <%if(start>1){%>
   <%

RCMenu += "{"+SystemEnv.getHtmlLabelName(1258,user.getLanguage())+",javascript:OnChangePage("+(start-1)+"),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>
     <%}%>
 <td><%if(hasNextPage){%>
      <%

RCMenu += "{"+SystemEnv.getHtmlLabelName(1259,user.getLanguage())+",javascript:OnChangePage("+(start+1)+"),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>     <%}


RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:returnMain(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;

%>
 <td>&nbsp;</td>
   </tr>
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

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<SCRIPT language="javascript">
function OnChangePage(start){
        document.frmmain.start.value = start;
		document.frmmain.submit();
}
function returnMain(){
        window.location="/hrm/resign/Resign.jsp?resourceid=<%=id%>";
}

</script>
</BODY></HTML>