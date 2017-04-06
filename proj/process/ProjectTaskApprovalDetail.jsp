<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,weaver.conn.RecordSet" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.proj.Maint.*"%>

<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>

<%
    String imagefilename = "/images/hdReport.gif";
    String titlename = SystemEnv.getHtmlLabelName(1332,user.getLanguage())+SystemEnv.getHtmlLabelName(618,user.getLanguage());
    String needfav ="1";
    String needhelp ="";

    int manager =0;
    int taskID = Util.getIntValue(request.getParameter("TaskID"));
    
		String taskid = Util.null2String(request.getParameter("TaskID"));
		if(taskid.equals("")){
			RecordSetV.executeSql("SELECT id FROM Prj_TaskProcess WHERE prjid="+Util.getIntValue(request.getParameter("prjid"))+" AND taskindex="+Util.getIntValue(request.getParameter("taskindex"))+"");
			if(RecordSetV.next())	taskid = String.valueOf(RecordSetV.getInt("id"));
		}
		RecordSetV.executeProc("Prj_TaskProcess_SelectByID",taskid);
		RecordSetV.next();
		String ProjID = RecordSetV.getString("prjid");
		

    /*Test if the currrent user is the manager of the project*/
    if(taskID>0){
        String sqlStr =" Select distinct manager from Prj_ProjectInfo t1,Prj_TaskProcess t2 where t1.ID = t2.PrjID and t2.ID = "+taskID;
        RecordSet rs = new RecordSet();
        rs.executeSql(sqlStr);
        if(rs.next()){
            manager = rs.getInt("manager");
        }
    }
    if(user.getUID() != manager){
        response.sendRedirect("/notice/noright.jsp") ;
        return;
    }
    ProjectTaskApprovalDetail approvalDetail = new ProjectTaskApprovalDetail(taskID);

    ProjectTask task = approvalDetail.getTask();
    ArrayList logList = approvalDetail.getLogList();
    System.out.println("logList.size() = "+logList.size());


%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
     <%
         if(task.getStatus() != ProjectTask.APPROVED){
               RCMenu += "{"+SystemEnv.getHtmlLabelName(142,user.getLanguage())+",javascript:doApprove(this),_self} " ;
               RCMenuHeight += RCMenuHeightStep;

               RCMenu += "{"+SystemEnv.getHtmlLabelName(236,user.getLanguage())+",javascript:doRefuse(this),_self} " ;
               RCMenuHeight += RCMenuHeightStep;
         }

				RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/proj/process/ViewProcess.jsp?ProjID="+ProjID+",_self} " ;
				RCMenuHeight += RCMenuHeightStep;
				
      %>


<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form name=weaver id=weaver method=post action="/proj/process/ViewProcess.jsp">
  <input type="hidden" name="ProjID" value="">


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


<TABLE class=liststyle cellspacing=1 >
<TBODY>
  <colgroup>
  <col width="6%">
  <col width="5%">
  <col width="8%">
  <col width="8%">

  <col width="4%">
  <col width="4%">
  <col width="4%">
  <col width="4%">

  <col width="7%">
  <col width="8%">
  <col width="5%">
  <col width="4%">
  <col width="4%">
  <col width="7%">

     <TR class=Header>
          <th><%=SystemEnv.getHtmlLabelName(1352,user.getLanguage())%></th>
	      <th nowrap><%=SystemEnv.getHtmlLabelName(2097,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(1322,user.getLanguage())%></th>
	      <th nowrap><%=SystemEnv.getHtmlLabelName(1323,user.getLanguage())%></th>

          <th nowrap><%=SystemEnv.getHtmlLabelName(1298,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(15274,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(555,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(2232,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(2233,user.getLanguage())%></th>

          <th nowrap>
                <%=SystemEnv.getHtmlLabelName(103,user.getLanguage()) %><%=SystemEnv.getHtmlLabelName(277,user.getLanguage()) %>
          </th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(3002,user.getLanguage()) %></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(1332,user.getLanguage()) %><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(104,user.getLanguage()) %></th>
          <th nowrap><%=SystemEnv.getHtmlLabelName(108,user.getLanguage()) %>IP</th>
	    </TR>
     <TR class=Line><TD colspan="14" ></TD></TR>
  <TR class="DataOutline">
              <TD colspan="14">
                            <b><%=SystemEnv.getHtmlLabelName(524,user.getLanguage()) %></b>
              </TD>
  </TR>
      <TR class="DataDark">
        <TD><a href="/proj/process/ViewTask.jsp?taskrecordid=<%=task.getTaskID()%>" target=_fullwindow><%=task.getSubject()%></a></TD>
        <TD><a href="/hrm/resource/HrmResource.jsp?id=<%=task.getHrmID()%>">
            <%=ResourceComInfo.getResourcename(""+task.getHrmID())%></a></TD>
        <TD><%=task.getBeginDate()%></TD>
        <TD><%=task.getEndDate()%></TD>
        <TD><%=task.getWorkday()%></TD>
        <TD><%=Util.getPointValue(String.valueOf(task.getFixedCost()),2)%></TD>
        <TD><%=task.getFinish()%>%</TD>
        <TD><%=(task.getLandMark().equals("0")?"NO":"YES")%></TD>
        <TD></TD>
        <TD></TD>
        <TD></TD>
        <TD>
            <%
                        switch(task.getStatus()){
                            case ProjectTask.APPROVED:  /*����*/
                                out.println(SystemEnv.getHtmlLabelName(225,user.getLanguage()));
                                break;
                            case ProjectTask.ADD_UNAPPROVED: /*���ӣ�������*/
                                out.println(SystemEnv.getHtmlLabelName(456,user.getLanguage()));
                                break;
                            case ProjectTask.MODIFY_UNAPPROVED: /*�޸ģ�������*/
                                out.println(SystemEnv.getHtmlLabelName(103,user.getLanguage()));
                                break;
                            case ProjectTask.DELETE_UNAPPROVED: /*ɾ����������*/
                                out.println(SystemEnv.getHtmlLabelName(91,user.getLanguage()));
                                break;
                        }
              %>
        </TD>
        <TD></TD>
        <TD></TD>
      </TR>
   <TR class="DataOutline">
              <TD colspan="14">
                            <b><%=SystemEnv.getHtmlLabelName(1477,user.getLanguage()) %><%=SystemEnv.getHtmlLabelName(264,user.getLanguage()) %></b>
              </TD>
  </TR>
   <%/*##################��ʾ�����б�ʼ##########################*/%>

          <%for(int j=0;j<logList.size();j++){
                    ProjectTaskModifyLog log = (ProjectTaskModifyLog) logList.get(j);

          %>
                <TR class="<%=(j%2==0?"DataLight":"DataDark")%>">
                    <TD><%=log.getSubject()%></TD>
                    <TD>
                        <a href="/hrm/resource/HrmResource.jsp?id=<%=log.getHrmID()%>">
                        <%=ResourceComInfo.getResourcename(""+log.getHrmID())%>
                        </a>
                        </TD>
                    <TD><%=log.getBeginDate()%></TD>
                    <TD><%=log.getEndDate()%></TD>
                    <TD><%=log.getWorkday()%></TD>
                    <TD><%=Util.getPointValue(String.valueOf(log.getFixedCost()),2)%></TD>
                    <TD><%=log.getFinish()%>%</TD>
                    <TD><%=(log.getLandMark().equals("0")?"NO":"YES")%></TD>
                    <TD></TD>

                    <TD><%=log.getModifyDate()%> <%=log.getModifyTime()%></TD>
                    <TD><a href="/hrm/resource/HrmResource.jsp?id=<%=log.getModifyBy()%>"><%=ResourceComInfo.getResourcename(""+log.getModifyBy())%></a></TD>
                    <TD>
                        <%
                            switch(log.getStatus()){
                                case ProjectTaskModifyLog.STATUS_APPROVED:
                                    out.println(SystemEnv.getHtmlLabelName(142,user.getLanguage()));
                                    break;
                                case ProjectTaskModifyLog.STATUS_UNAPPROVED:
                                    out.println(SystemEnv.getHtmlLabelName(15746,user.getLanguage()));
                                    break;
                                case ProjectTaskModifyLog.STATUS_REFUSAL:
                                    out.println(SystemEnv.getHtmlLabelName(236,user.getLanguage()));
                                    break;

                            }
                        %>
                    </TD>
                    <TD>
                        <%
                            switch(log.getOperationType()){
                                case ProjectTaskModifyLog.OPER_ADD:
                                    out.println(SystemEnv.getHtmlLabelName(456,user.getLanguage()));
                                    break;
                                case ProjectTaskModifyLog.OPER_MODIFY:
                                    out.println(SystemEnv.getHtmlLabelName(103,user.getLanguage()));
                                    break;
                                case ProjectTaskModifyLog.OPER_DELETE:
                                    out.println(SystemEnv.getHtmlLabelName(91,user.getLanguage()));
                                    break;
                            }
                        %>
                    </TD>
                    <TD><%=log.getClientIP()%></TD>
                </TR>
          <%}%>


	<%/*################��ʾ�����б����####################*/%>
  </TBODY>
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




<script language=vbs>
sub getProj(prjid)
	returndate =  window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/process/ProjNotice.jsp?ProjID="&prjid)


end sub


</script>

<script language=javascript >
function rankclick(targetId)
{

		var objSrcElement = window.event.srcElement;
    if (document.all(targetId)==null) {

           objSrcElement.src = "/images/project_rank1.gif";

	} else {
         var targetElement = document.all(targetId);

          if (targetElement.style.display == "none")
		{
             objSrcElement.src = "/images/project_rank1.gif";
             targetElement.style.display = "";
		}
            else
		{
             objSrcElement.src = "/images/project_rank2.gif";
             targetElement.style.display = "none";
		}
	}

}


function doApprove(obj){
         if(confirm("��ȷ����׼����Ķ���")) {
                obj.disabled = true;
                document.location ="ProjectTaskApprovalOperation.jsp?method=approve&amp;TaskID=<%=taskID%>" ;
         }
}

function doRefuse(obj){
        if(confirm("��ȷ���˻�����Ķ���")){
               obj.disabled = true;
               document.location ="ProjectTaskApprovalOperation.jsp?method=refuse&amp;TaskID=<%=taskID%>" ;
        }

}
</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
