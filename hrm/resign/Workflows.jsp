<%@ page import="weaver.general.Util,
                 weaver.hrm.resign.ResignProcess,
                 weaver.hrm.resign.WorkFlowDetail" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
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
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(17569,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%

    RCMenu += "{����,javascript:window.history.go(-1),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>

<%
boolean hasNextPage=false;






String sqlwhere="where t1.requestid = t2.requestid and (t2.isremark='0' or t2.isremark='1' or t2.isremark='5' or  t2.isremark='8' or  t2.isremark='9' or  t2.isremark='7') and t2.islasttimes=1 and t2.userid = "+id+" and t2.usertype=0" ;
String orderby=" t1.createdate,t1.createtime,t1.requestlevel";
int perpage=Util.getIntValue(Util.null2String(request.getParameter("perpage")),10);

%>

<FORM id=weaver name=frmmain method=post action="Workflows.jsp">

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
<table class=liststyle cellspacing=1   id=tblReport>
    <tr>

                      <td valign="top">
                          <%
                           String tableString = "";

                            if(perpage <2) perpage=10;

                            String backfields = "t1.requestid, t1.createdate, t1.createtime,t1.lastoperatedate, t1.lastoperatetime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.status,t1.requestlevel,t3.multiSubmit";
                            String fromSql  = "from workflow_requestbase t1,workflow_currentoperator t2 ,workflow_base t3 ";
                            String sqlWhere = sqlwhere+" and t1.workflowid=t3.id ";


                         tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                                                 "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.requestid\" sqlsortway=\"Desc\" sqlisdistinct=\"true\"/>"+
                                                 "			<head>"+
                                                 "				<col width=\"18%\"  text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" column=\"createdate\" orderkey=\"t1.createdate,t1.createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />"+
                                                 "				<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(882,user.getLanguage())+"\" column=\"creater\" orderkey=\"t1.creater\"  otherpara=\"t1.creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
                                                 "				<col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(259,user.getLanguage())+"\" column=\"workflowid\" orderkey=\"t1.workflowid\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\" />"+
                                                 "				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(15534,user.getLanguage())+"\" column=\"requestlevel\"  orderkey=\"t1.requestlevel\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultUrgencyDegree\" otherpara=\""+user.getLanguage()+"\"/>"+
                                                 "				<col width=\"29%\"  text=\""+SystemEnv.getHtmlLabelName(1334,user.getLanguage())+"\" column=\"requestname\" orderkey=\"t1.requestname\" href =\"/workflow/request/ViewRequest.jsp\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_fullwindow\" />"+
                                                 "			  <col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(740,user.getLanguage())+"\" column=\"createdate\" orderkey=\"t1.createdate\"  />"+
                                                 "			  <col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(1335,user.getLanguage())+"\" column=\"status\" orderkey=\"t1.status\" />"+
                                                 "			</head>"+
                                                 "</table>";


                          %>

                          <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" />
                      </td>
                    </tr>


</table>
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
</body>
<script language=vbs>
sub gettheDate(inputname,spanname)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	if (Not IsEmpty(returndate)) then
	spanname.innerHtml= returndate
	inputname.value=returndate
	end if
end sub

sub onShowResource()
	tmpval = document.all("creatertype").value
	if tmpval = "0" then
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	else
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	end if
	if NOT isempty(id) then
	        if id(0)<> "" then
		resourcespan.innerHtml = id(1)
		frmmain.createrid.value=id(0)
		else
		resourcespan.innerHtml = ""
		frmmain.createrid.value=""
		end if
	end if

end sub
</script>

<SCRIPT language="javascript">
function OnChangePage(start){
        document.frmmain.start.value = start;
		document.frmmain.submit();
}

function returnMain(){
        window.location="/hrm/resign/Resign.jsp?resourceid=<%=id%>";
}
</script>

</html>