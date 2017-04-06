<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@page import="weaver.monitor.logs.MonitorLogMan"%>

<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<script language="javascript" src="/js/weaver.js"></script>
	</head>
	<%
		User user = HrmUserVarify.getUser (request , response) ;
		if(user == null)  return ;
		if (user.getUID()!=1)
		{
			response.sendRedirect("/notice/noright.jsp");
			return;
		}
		
		String filename = Util.null2String(request.getParameter("filename"));
		String startdate = Util.null2String(request.getParameter("startdate"));
		String enddate = Util.null2String(request.getParameter("enddate"));
		boolean isstatus = Util.null2String(request.getParameter("isstatus")).equals("1");
		boolean ismem = Util.null2String(request.getParameter("ismem")).equals("1");
		boolean issql = Util.null2String(request.getParameter("issql")).equals("1");
		boolean isthread = Util.null2String(request.getParameter("isthread")).equals("1");
		boolean iswarning = Util.null2String(request.getParameter("iswarning")).equals("1");
		boolean isconn = Util.null2String(request.getParameter("isconn")).equals("1");
		boolean isjavacore = Util.null2String(request.getParameter("isjavacore")).equals("1");
		boolean isresinconf = Util.null2String(request.getParameter("isresinconf")).equals("1");
		
		String operatetype = Util.null2String(request.getParameter("operatetype"));
		
		String filenamezip = "";
		float filenamezipsize = 0;
	
		if("pack".equals(operatetype))
		{
			if(!"".equals(startdate)&&!"".equals(enddate))
			{
				if(startdate.compareTo(enddate)>0)
				{
					String tempdate = startdate;
					startdate = enddate;
					enddate = tempdate;
				}
			}
			MonitorLogMan MonitorLogMan = new MonitorLogMan();
			MonitorLogMan.setFilename(filename);
			MonitorLogMan.setStartdate(startdate);
			MonitorLogMan.setEnddate(enddate);
			MonitorLogMan.setIsstatus(isstatus);
			MonitorLogMan.setIsmem(ismem);
			MonitorLogMan.setIssql(issql);
			MonitorLogMan.setIsthread(isthread);
			MonitorLogMan.setIswarning(iswarning);
			MonitorLogMan.setIsconn(isconn);
			MonitorLogMan.setIsjavacore(isjavacore);
			MonitorLogMan.setIsresinconf(isresinconf);
			
			filenamezip = MonitorLogMan.packMonitorLogFiles();
			filenamezipsize = MonitorLogMan.getFilenamezipsize();
		}
		else if("delete".equals(operatetype))
		{
			filenamezip = Util.null2String(request.getParameter("filenamezip"));
			MonitorLogMan MonitorLogMan = new MonitorLogMan();
			MonitorLogMan.setFilename(filenamezip);
			MonitorLogMan.deletePackLogFiles("");
		}
	%>
	<BODY>
		<form id="frmRemain" name="frmRemain" method=post action="/system/systemmonitor/system/MonitorLog.jsp" >
			<input name="operatetype" type="hidden" value="">
			<input name="filenamezip" type="hidden" value="<%=filenamezip %>">
			<table class=ViewForm>
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				<tbody>
					<tr>
						<td>
							�ļ�����
						</td>
						<td class="field">
							<input id="filename" name="filename" type=text class=Inputstyle value="<%=filename %>" maxLength="10" onBlur='checkinput_char_num("filename");'>
						</td>
						<td>
							����
						</td>
						<td class="field">
							<button class=calendar id=SelectDate onClick="getDate(startdatespan,startdate)"></button>&nbsp;
	                          <span id=startdatespan ><%=startdate %></span>
	                          -&nbsp;&nbsp;<button class=calendar id=SelectDate2 onClick="getDate(enddatespan,enddate)"></button>&nbsp;
	                          <span id=enddatespan><%=enddate %></span>
	                          <input type="hidden" name="startdate" value="<%=startdate %>">
	                          <input type="hidden" name="enddate" value="<%=enddate %>">
						</td>
					</tr>
					<TR>
						<TD class=Line colSpan=4></TD>
					</TR>
					<tr>
						<td>
							����ļ�
						</td>
						<td class="field" colSpan=3>
							<input type=checkbox name='isstatus' value=1 <%if("".equals(operatetype)||isstatus){ %>checked<%} %>> ϵͳ��Ϣ��־
							<input type=checkbox name='ismem' value=1 <%if("".equals(operatetype)||ismem){ %>checked<%} %>> �ڴ���־
							<input type=checkbox name='issql' value=1 <%if("".equals(operatetype)||issql){ %>checked<%} %>> SQLִ����־
							<input type=checkbox name='isthread' value=1 <%if("".equals(operatetype)||isthread){ %>checked<%} %>> ϵͳ�߳���־
							<input type=checkbox name='iswarning' value=1 <%if("".equals(operatetype)||iswarning){ %>checked<%} %>> ϵͳԤ����־
							<input type=checkbox name='isconn' value=1 <%if("".equals(operatetype)||isconn){ %>checked<%} %>> ���ݿ�������־
							<input type=checkbox name='isjavacore' value=1 <%if("".equals(operatetype)||isjavacore){ %>checked<%} %>> javacore
							<input type=checkbox name='isresinconf' value=1 <%if("".equals(operatetype)||isresinconf){ %>checked<%} %>> resin�����ļ�
						</td>
					</tr>
					<TR>
						<TD class=Line colSpan=4></TD>
					</TR>
					<tr>
						<td colSpan=4 align="right">
							<input type="button" class="submit" name="pack" value="���" onclick="packfile(this);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<TR>
						<TD class=Line colSpan=4></TD>
					</TR>
					<%if("pack".equals(operatetype)&&!"".equals(filenamezip)&&filenamezipsize>0){ %>
					<tr>
						<td>
							<%=filenamezip %>
						</td>
						<td class="field">
							<%=filenamezipsize %>K
						</td>
						<td>
							<a href="/log/<%=filenamezip %>" target="_blank">����</a>
						</td>
						<td class="field">
							<input type="button" class="submit" name="delete" value="ɾ��" onclick="deletefile(this);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<TR>
						<TD class=Line colSpan=4></TD>
					</TR>
					<%}else if("pack".equals(operatetype)&&("".equals(filenamezip)||filenamezipsize<=0)){ %>
					<tr>
						<td colSpan=4>
							��������Ҫ������ļ�...
						</td>
					</tr>
					<TR>
						<TD class=Line colSpan=4></TD>
					</TR>
					<%} %>
				</tbody>
			</table>
		</form>
	</BODY>
	<script language="javascript">
	function packfile(obj)
	{
		if(frmRemain.isstatus.checked==false&&frmRemain.ismem.checked==false&&frmRemain.issql.checked==false&&frmRemain.isthread.checked==false&&frmRemain.iswarning.checked==false&&frmRemain.isjavacore.checked==false&&frmRemain.isresinconf.checked==false)
		{
			alert("����ѡ��һ����Ҫ������ļ�!");
			return;
		}
		obj.disabled = false;
		frmRemain.operatetype.value="pack";
		frmRemain.submit();
	}
	function deletefile(obj)
	{
		obj.disabled = false;
		frmRemain.operatetype.value="delete";
		frmRemain.submit();
	}
	</script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>