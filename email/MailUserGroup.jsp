<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.* "%>

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String type = Util.null2String(request.getParameter("type"));
String name = Util.null2String(request.getParameter("name"));
String userid=user.getUID()+"" ;
%>

</SCRIPT>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdCRMAccount.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(71,user.getLanguage())
+ SystemEnv.getHtmlLabelName(2026,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 

RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",MailUserGroupAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(2032,user.getLanguage())+",WeavermailIndex.jsp,_self} " ;
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

				<TABLE class=ListStyle cellspacing="1">
				  <TBODY>
				  <tr class=Header> <th colspan=4><%=SystemEnv.getHtmlLabelName(71,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(2026,user.getLanguage())%></th>				  
				  <TR class=Header>
				  <th><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></th>
				  <th><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></th> <th><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(127,user.getLanguage())%></th>
				  <th><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></th>
				  </tr>
				  <TR class=Line><TD colspan="4" ></TD></TR> 
				<%
				boolean isLight = false;
					//�����Ѿ����ڵ�user group
					RecordSet.executeProc("MailUserGroup_SelectByUser",userid);
					while(RecordSet.next()){
						if(isLight = !isLight)
						{%>	
					<TR CLASS=DataDark>
				<%		}else{%>
					<TR CLASS=DataLight>
				<%		}%>
						<TD><a href="/email/MailUserGroupEdit.jsp?mailgroupid=<%=RecordSet.getInt("mailgroupid")%>"><%=Util.toScreen(RecordSet.getString("mailgroupname"),user.getLanguage())%></a></TD>
						<TD><%=Util.toScreen(RecordSet.getString("operatedesc"),user.getLanguage())%></TD>
						<TD><%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("createrid")),user.getLanguage())%></TD>
						<TD><%=Util.toScreen(RecordSet.getString("createrdate"),user.getLanguage())%></TD>
					</TR>
				<%
					}
						
				%>
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
