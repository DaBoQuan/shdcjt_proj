<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="RequestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/> 
<%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(17599,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(18613,user.getLanguage());
String needfav ="1";
String needhelp ="";

boolean islight=true ;
String userid=user.getUID()+"";
String votingid=Util.fromScreen(request.getParameter("votingid"),user.getLanguage());

RecordSet.executeProc("Voting_SelectByID",votingid);
RecordSet.next();
String subject=RecordSet.getString("subject");
String detail=RecordSet.getString("detail");
String createrid=RecordSet.getString("createrid");
String createdate=RecordSet.getString("createdate");
String createtime=RecordSet.getString("createtime");
String approverid=RecordSet.getString("approverid");
String approvedate=RecordSet.getString("approvedate");
String approvetime=RecordSet.getString("approvetime");
String begindate=RecordSet.getString("begindate");
String begintime=RecordSet.getString("begintime");
String enddate=RecordSet.getString("enddate");
String endtime=RecordSet.getString("endtime");
String isanony=RecordSet.getString("isanony");
String docid=RecordSet.getString("docid");
String crmid=RecordSet.getString("crmid");
String projectid=RecordSet.getString("projid");
String requestid=RecordSet.getString("requestid");
String votingcount = RecordSet.getString("votingcount");
String status = RecordSet.getString("status");

titlename += "&nbsp;&nbsp;" + "<b>"
	+ SystemEnv.getHtmlLabelName(125, user.getLanguage())
	+ ":&nbsp;</b>"
	+ createdate
	+ "&nbsp;&nbsp;"
	+ createtime
	+ "&nbsp;&nbsp;"
	+ "<b>"
	+ SystemEnv.getHtmlLabelName(271, user.getLanguage())
	+ ":&nbsp;</b>"
	+ "<a href=\"javaScript:openhrm('"
	+ createrid
	+ "');\" onclick='pointerXY(event);'>"
	+ Util.toScreen(ResourceComInfo.getResourcename(createrid),user.getLanguage())
	+ "</A>&nbsp;&nbsp;"
	+ "<b>"
	+ "&nbsp;&nbsp;"
	+ SystemEnv.getHtmlLabelName(359, user.getLanguage())
	+ ":&nbsp;</b>"
	+ approvedate
	+ "&nbsp;&nbsp;"
	+ approvetime
	+ "&nbsp;&nbsp;"
	+ "<b>"
	+ SystemEnv.getHtmlLabelName(439, user.getLanguage())
	+ ":&nbsp;</b>"
	+ "<a href=\"javaScript:openhrm('"
	+ approverid
	+ "');\" onclick='pointerXY(event);'>"
	+ Util.toScreen(ResourceComInfo.getResourcename(approverid), user.getLanguage()) + "</A>&nbsp;&nbsp;";
 
    
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.go(-1),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<form name=frmmain action="VotingPollOperation.jsp" method=post>
<input type=hidden name=method value="polledit">
<input type=hidden name=votingid value="<%=votingid%>">
<TABLE width=100% height=100% border="0" cellspacing="0">
      <colgroup>
        <col width="5">
          <col width="">
            <col width="5">
              <tr>
                <td height="5" colspan="3"></td>
              </tr>
              <tr>
                <td></td>
                <td valign="top">  
                <form name="frmSubscribleHistory" method="post" action="">
                  <TABLE class=Shadow>
                    <tr>
                      <td valign="top">
<table class=viewform>
<col width=15%><col width=35%><col width=15%><col width=35%> 
    <td colspan=4 align=center><font size=5 color=blue>
    <%=Util.toScreen(subject,user.getLanguage())%></font>
    </td>
  </tr>
  <tr>
    <td colspan=4>
    <%=Util.toScreen(detail,user.getLanguage())%>
    </td>
  </tr>
</table>

<br>
<br>
<table class=liststyle>
<col width=20%><col width=80%>
<TR class=header>
    <TH colSpan=2 align=left><%=SystemEnv.getHtmlLabelName(18613,user.getLanguage())%></TH>
  </TR> 
  <tr class=header>
    <td><%=SystemEnv.getHtmlLabelName(616,user.getLanguage())%></td>
    <td><%=SystemEnv.getHtmlLabelName(504,user.getLanguage())%></td>
  </tr>  
<%
islight = true ;
RecordSet.executeSql("select * from votingremark where votingid="+votingid);
while(RecordSet.next()){
    String resourceid = RecordSet.getString("resourceid");
    String useranony = RecordSet.getString("useranony");
    String remark = RecordSet.getString("remark");
    String operatedate=RecordSet.getString("operatedate");
    String operatetime=RecordSet.getString("operatetime"); 
    if(remark.equals(""))   continue ;
%>
  <tr <%if(islight){%> class=datadark <%} else {%> class=datalight <%}%>>
    <td><%if(useranony.equals("1")){%><%=SystemEnv.getHtmlLabelName(18611,user.getLanguage())%><%}else{%><%=ResourceComInfo.getResourcename(resourceid)%><%}%>
    <br><%=operatedate%>  <%=operatetime%></td>
    <td colspan=3><%=remark%></td>
  </tr>
<%
    islight=!islight ;
}
%>
</table>
                    </td>
                    </tr>
                  </TABLE>  
                  </form>
                </td>
                <td></td>
              </tr>
              <tr>
                <td height="5" colspan="3"></td>
              </tr>
            </table>
</form>
</body>
</html>