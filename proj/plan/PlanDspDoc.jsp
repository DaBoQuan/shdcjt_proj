<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
char flag = 2;
String ProcPara = "";
String ProjID = Util.null2String(request.getParameter("ProjID"));
String log = Util.null2String(request.getParameter("log"));
String Version = Util.null2String(request.getParameter("version"));
int MaxVersion = 0 ;
int CurrentVersion = 0 ;
String isActived = "" ;
String isCurrentActived = "" ;
int MinLenWbscoding = 0 ;
RecordSet.executeProc("Prj_TaskInfo_SelectMaxVersion",ProjID);
if(RecordSet.next()){
	MaxVersion = RecordSet.getInt("version");
	isActived = RecordSet.getString("isactived"); 
}

if(MaxVersion==0){
	MaxVersion = 1;
}
if(Version.equals("")){
	Version = ""+MaxVersion ;
}
RecordSet.executeProc("Prj_ProjectInfo_SelectByID",ProjID);
if(RecordSet.getCounts()<=0)
	response.sendRedirect("/base/error/DBError.jsp?type=FindData");
RecordSet.first();

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(407,user.getLanguage())+"-"+"<a href='/proj/data/ViewProject.jsp?log="+log+"&ProjID="+RecordSet.getString("id")+"'>"+Util.toScreen(RecordSet.getString("name"),user.getLanguage())+"</a>";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/proj/plan/ViewPlan.jsp?ProjID="+ProjID+",_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form name=weaver method=post action="PlanDspDoc.jsp">
  <input type="hidden" name="ProjID" value="<%=ProjID%>">
  
  
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

<table class=viewform>
  <tr>
     <td width="60"><%=SystemEnv.getHtmlLabelName(1333,user.getLanguage())%></td>
     <td class=field>&nbsp
		<select  name=version size=1 class=inputstyle   onChange="weaver.submit()">
		 <%for(int i=1;i<=MaxVersion;i++){%>
			 <option value="<%=i%>" <%if(Version.equals(""+i)){%>selected<%}%>><%=i%></option>
		 <%}%>
		 </select>	 
	 </td>
  </tr><TR><TD class=Line1 colSpan=2></TD></TR> 
</table>
</form>

<TABLE class=liststyle cellspacing=1 >
<TBODY>
        <TR class=Header>
          <th><%=SystemEnv.getHtmlLabelName(1339,user.getLanguage())%></th>
		  <th><%=SystemEnv.getHtmlLabelName(1340,user.getLanguage())%></th>
		  <th><%=SystemEnv.getHtmlLabelName(1341,user.getLanguage())%></th>
		</TR><TR class=Line><Th colspan="3" ></Th></TR> 
<%
String CurrentUser = ""+user.getUID();
String logintype = ""+user.getLogintype();
int usertype = 0;
if(logintype.equals("2"))
	usertype= 1;

String sql="SELECT t1.id, t1.docsubject, t1.ownerid, t1.doccreatedate, t1.doccreatetime FROM DocDetail  t1, docuserview t2, Prj_Doc t3 ";
String sqlwhere=" where t1.id = t2.docid and t2.userid = "+CurrentUser + " and t1.id = t3.docid  and t3.type = '1' and t3.prjid = " + ProjID + " and t3.version <= " + Version;
String orderby=" ORDER BY t1.id DESC ";
sql=sql+sqlwhere+orderby;
RecordSet.executeSql(sql);
while(RecordSet.next())
{
	String id=RecordSet.getString("id");
	String createdate=RecordSet.getString("doccreatedate");
	String createtime=RecordSet.getString("doccreatetime");
	String ownerid=RecordSet.getString("ownerid");
	String docsubject=RecordSet.getString("docsubject");
%>
    <tr class=datadark>
      <td><%=Util.toScreen(createdate,user.getLanguage())%>&nbsp<%=Util.toScreen(createtime,user.getLanguage())%></td>
      <td>
      <a href="/hrm/resource/HrmResource.jsp?id=<%=ownerid%>"><%=Util.toScreen(ResourceComInfo.getResourcename(ownerid),user.getLanguage())%></a>
      </td>
      <td><a href="/docs/docs/DocDsp.jsp?id=<%=id%>"><%=Util.toScreen(docsubject,user.getLanguage())%></a></td>
       </tr>

<%}%>
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

</BODY>
</HTML>
