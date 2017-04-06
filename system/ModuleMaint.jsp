<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%> 
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.general.StaticObj,
                 weaver.general.Util" %>
<%@ page import="weaver.hrm.settings.RemindSettings" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>



<html>
<head>
	<link href="/css/Weaver.css" type=text/css rel=stylesheet>
</head> 
<body>
<%
if (user.getUID() != 1) {
	response.sendRedirect("/notice/noright.jsp");
	return;
} 
String imagefilename = "/images/hdMaintenance.gif";
String titlename ="ϵͳģ����ʾά��ҳ��";
String needfav ="1";
String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
	RCMenu += "{����,javascript:frm.submit(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;


	RCMenu += "{����,javascript:window.history.go(-1),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<TABLE width=100% height=100% border="0" cellspacing="0">
    <colgroup>
    <col width="10">
    <col width="">
    <col width="10">
    <tr>
      <td height="10" colspan="3"></td>
    </tr>

    <tr>
        <td></td>
        <td valign="top">
			<table class="Shadow">
				<colgroup>
				<col width="1">
				<col width="">
				<col width="10">
			<tr>
				<TD></td>		
				<td valign="top">
					<form name="frm" method="post" action="ModuleOprate.jsp">
					<table class="viewForm" cellspacing="1" cellpadding="1">
						<%
						File f = new File(GCONST.getPropertyPath() + "module.properties");
						
						InputStream is =new BufferedInputStream(new FileInputStream(f));
						Properties prop = new Properties() ;						
						prop.load(is);
            			is.close();
						
						 for (Enumeration e = prop.propertyNames() ; e.hasMoreElements() ;) {
							 String key=e.nextElement().toString();
							 String value=prop.getProperty(key);
							 String showName="";
							 if("portal.status".equals(key)) showName="�Ż�����";
							 else if("workflow.status".equals(key)) showName="���̹���";
							 else if("doc.status".equals(key)) showName="֪ʶ����";
							 else if("photo.status".equals(key)) showName="������";
							 else if("car.status".equals(key)) showName="��������";
							 else if("scheme.status".equals(key)) showName="�ճ̹���";
							 else if("report.status".equals(key)) showName="�������";
							 else if("meeting.status".equals(key)) showName="�������";
							 else if("message.status".equals(key)) showName="ͨ�Ź���";
							 else if("finance.status".equals(key)) showName="�������";
							 else if("cpt.status".equals(key)) showName="�ʲ�����";
							 else if("proj.status".equals(key)) showName="��Ŀ";
							 else if("crm.status".equals(key)) showName="�ͻ�";
							 else if("info.status".equals(key)) showName="��Ϣ����";
							 else if("cwork.status".equals(key)) showName="Э����";
							 else if("setting.status".equals(key)) showName="��������";
							 else if("hrm.status".equals(key)) showName="������Դ";
							 
						%> 
						<tr>
							<td width="15%"><%=showName%></td>
							<td width="85%" class="field"> 
								<%if("portal.status".equals(key)||
										"workflow.status".equals(key)||
										"doc.status".equals(key)||
										"hrm.status".equals(key)||
										"setting.status".equals(key)){
								%>
									<input type="radio" value="1" disabled checked>����
									<input type="radio" value="0" disabled>�ر�		
									<input  type="hidden" value="1" name="<%=key%>">						
								<%} else { %>
									<input type="radio" value="1" name="<%=key%>" <%if("1".equals(value)) out.println("checked");%>>����
									<input type="radio" value="0" name="<%=key%>" <%if("0".equals(value)) out.println("checked");%>>�ر�
								<%}%>							
							</td>
						</tr>
						<TR><TD class=line colspan=2></TD></TR>
						<%}%>
					</table>
					</form>
					 



				</td>
			</tr>
			<TR><TD class=line colspan=3></TD></TR>
			
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			</table>
	    </td>
		<td></td>
	</tr>
	<tr>
		<td height="10" colspan="3"></td>
	</tr>
</TABLE>
</body>
</html>
