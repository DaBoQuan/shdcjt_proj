<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<script language=javascript src="/js/weaver.js"></script>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<%

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(16465,user.getLanguage())+SystemEnv.getHtmlLabelName(15148,user.getLanguage());
String needfav ="1";
String needhelp ="";
String newWorkerRemindIds=Util.null2String((String)request.getAttribute("newWorkerRemindIds"));
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
int usertype = 0;


%>
</head>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
</colgroup>
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
		
		<table class=liststyle cellspacing=1  >
     	<COLGROUP>
     	<!--COL width=10-->
     	<COL width="40%">
        <COL width="20%">
        <COL width="20%">
        </COLGROUP>
        <TR class="Header">
    	  <TH colSpan=5><%=SystemEnv.getHtmlLabelName(16465,user.getLanguage())+SystemEnv.getHtmlLabelName(15148,user.getLanguage())%></TH></TR>

        <tr class=header>

          <td><%=SystemEnv.getHtmlLabelName(15148,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage())%></td>
          <td><%=SystemEnv.getHtmlLabelName(1867,user.getLanguage())%></td>
          <td><%=SystemEnv.getHtmlLabelName(882,user.getLanguage())%></td>
          <td><%=SystemEnv.getHtmlLabelName(784,user.getLanguage())%></td>
          <td><%=SystemEnv.getHtmlLabelName(104,user.getLanguage())%></td>
        </tr><TR class=Line><TD colspan="5" ></TD></TR>
          <%          
              int linecolor=0;
              if(!newWorkerRemindIds.equals(""))
              RecordSet.executeSql("SELECT id,remindtype,resourceid,reminddate,relatedid FROM HrmRemindMsg where remindtype=5 and id in ("+newWorkerRemindIds+") order by remindtype,reminddate");

              while(!newWorkerRemindIds.equals("")&&RecordSet.next()){
                  String id=RecordSet.getString("id");
                  String typeid=RecordSet.getString("remindtype");
                  String type="";
                  String resourceid=RecordSet.getString("resourceid");
                  String creatorid=RecordSet.getString("relatedid");
                  String resource="<a href=/hrm/resource/HrmResource.jsp?id=" + resourceid + ">" + ResourceComInfo.getResourcename(resourceid) + "</a>&nbsp;";
                  String creator="<a href=/hrm/resource/HrmResource.jsp?id=" + creatorid + ">" + ResourceComInfo.getResourcename(creatorid) + "</a>&nbsp;";
                  String reminddate=RecordSet.getString("reminddate");
                  StringBuffer operation=new StringBuffer();
                  type=SystemEnv.getHtmlLabelName(16250,user.getLanguage())+SystemEnv.getHtmlLabelName(15148,user.getLanguage());
                  operation.append("<a href=/hrm/employee/EmployeeManage.jsp?hrmid=" );
                  operation.append(resourceid);
                  operation.append(">").append(SystemEnv.getHtmlLabelName(16250,user.getLanguage())).append( "</a>&nbsp;");
          %>
          <tr <%if(linecolor==0){%> class=datalight <%} else {%> class=datadark <%}%> >

            <td><%=type%></td>
            <td><%=resource%></td>
            <td><%=creator%></td>
            <td><%=reminddate%></td>
            <td><%=operation%></td>
          </tr>
          <%
          	if(linecolor==0)	linecolor=1;
          	else	linecolor=0;
          }
          %>


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


</body>
</html>