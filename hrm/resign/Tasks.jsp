<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util,weaver.hrm.resign.ResignProcess"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.proj.Maint.*"%>

<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers"scope="page" />
<jsp:useBean id="ResourceComInfo"class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<%
String id = Util.null2String(request.getParameter("id"));
//��ǰ�û�Ϊ��¼���˻������ϼ����߾��С���ְ������Ȩ����ɲ鿴��ҳ��
String userId = "" + user.getUID();
String managerId = ResourceComInfo.getManagerID(id);
if(!userId.equals(id) && !userId.equals(managerId) && !HrmUserVarify.checkUserRight("Resign:Main", user)){
	response.sendRedirect("/notice/noright.jsp");
	return;
}
%>

<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
	</HEAD>
	<%
		String imagefilename = "/images/hdDOC.gif";
		String titlename = SystemEnv.getHtmlLabelName(17572, user.getLanguage());
		String needfav = "1";
		String needhelp = "";

		
	%>
    <%
		int perpage=Util.getIntValue(request.getParameter("perpage"),10);
		
		String SqlWhere = " where t1.manager="+id;
		
		String backFields = "t1.id,t1.name,t1.procode,t1.prjtype,t1.worktype,t1.manager,t1.department,t1.status";
		String sqlFrom = " from Prj_ProjectInfo t1";
		System.out.println("sql:"+backFields+sqlFrom+SqlWhere);
		String tableString=""+
		  "<table  pagesize=\""+perpage+"\" tabletype=\"none\">"+
		  "<sql backfields=\""+backFields+"\" sqlform=\""+sqlFrom+"\" sqlprimarykey=\"id\" sqlsortway=\"Desc\" sqldistinct=\"true\" sqlwhere=\""+Util.toHtmlForSplitPage(SqlWhere)+"\"/>"+
		  "<head>"+                             
				  "<col width=\"25%\"  text=\""+SystemEnv.getHtmlLabelName(195,user.getLanguage())+"\" column=\"name\"   target=\"_self\" linkkey=\"ProjID\" linkvaluecolumn=\"id\" href=\"/proj/data/ViewProject.jsp\" orderkey=\"name\"/>"+
				  "<col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(17852,user.getLanguage())+"\" column=\"procode\"   target=\"_self\" linkkey=\"ProjID\" linkvaluecolumn=\"id\" href=\"/proj/data/ViewProject.jsp\" orderkey=\"procode\"/>"+
				  "<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(586,user.getLanguage())+"\" column=\"prjtype\" orderkey=\"prjtype\" transmethod=\"weaver.splitepage.transform.SptmForProj.getProjTypeName\"/>"+
				  "<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(432,user.getLanguage())+"\" column=\"worktype\" orderkey=\"worktype\" transmethod=\"weaver.splitepage.transform.SptmForProj.getWorkTypeName\"/>"+
				  "<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(144,user.getLanguage())+"\" column=\"manager\" orderkey=\"manager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
				  "<col width=\"12%\"  text=\""+SystemEnv.getHtmlLabelName(124,user.getLanguage())+"\" column=\"department\" orderkey=\"department\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
				  "<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(587,user.getLanguage())+"\"  column=\"status\" orderkey=\"status\" transmethod=\"weaver.splitepage.transform.SptmForProj.getProjStatusName\" otherpara=\""+user.getLanguage()+"\"/>"+ 
		  "</head>"+	 
		  "</table>";
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
	<%
		if (HrmUserVarify.checkUserRight("HrmRrightTransfer:Tran", user)) {
				RCMenu += "{"
				+ SystemEnv.getHtmlLabelName(16528, user.getLanguage())
				+ ",/hrm/transfer/HrmRightTransfer.jsp,_self}";
				RCMenuHeight += RCMenuHeightStep;
			}
			RCMenu += "{"
					+ SystemEnv.getHtmlLabelName(1290, user.getLanguage())
					+ ",javascript:returnMain(),_self}";
			RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu.jsp"%>

<table width=100% height=96% border="0" cellspacing="0" cellpadding="0">
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
				<td valign="top"><wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" isShowTopInfo="true"/></td>
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

<script language=javascript>
function returnMain(){
        window.location="/hrm/resign/Resign.jsp?resourceid=<%=id%>";
}
function rankclick(targetId){
	var objSrcElement = window.event.srcElement;
    if (document.all(targetId)==null) {
         objSrcElement.src = "/images/project_rank1.gif";
	} else {
         var targetElement = document.all(targetId);
          if (targetElement.style.display == "none"){
             objSrcElement.src = "/images/project_rank1.gif";
             targetElement.style.display = "";
		}else{
             objSrcElement.src = "/images/project_rank2.gif";
             targetElement.style.display = "none";
		}
	}
}
</script>
</BODY>
</HTML>
