<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*,weaver.monitor.*,weaver.monitor.monitor.*,weaver.monitor.beans.*" %>
<%@page import="weaver.monitor.logs.MonitorLogMan"%>


<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
	</head>
	<%
		User user = HrmUserVarify.getUser (request , response) ;
		if(user == null)  return ;
		if (user.getUID()!=1)
		{
			response.sendRedirect("/notice/noright.jsp");
			return;
		}
		//��ȡϵͳ��Ϣ
		Monitor mm = MonitorFactory.getMonitor(1);
		mm.getMonitorInfo();
		SysStatusBean ssb = (SysStatusBean)mm.getMonitorToShow();
	%>
	<BODY>
		<table class=ViewForm>
			<colgroup>
				<col width="30%">
				<col width="70%">
			<tbody>

				<tr>
					<td>
						ϵͳ�汾��
					</td>
					<td class="field">
					<%=ssb.getOsName()+" "+ssb.getOsArch()+" "+ssb.getOsVersion() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;�����ڴ�
					</td>
					<td class="field">
						<%=ssb.getTotalMemorySize() %>K
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;ʣ�������ڴ�
					</td>
					<td class="field">
						<%=ssb.getFreePhysicalMemorySize() %>K
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;���������ڴ�
					</td>
					<td class="field">
						<%=ssb.getUsedMemory() %>K
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;CPUϵͳ��Ϣ
					</td>
					<td class="field">
						<%=ssb.getCpuinfo()+"&nbsp;x&nbsp;"+ssb.getCpunum() %>&nbsp;��
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;CPUʹ����
					</td>
					<td class="field">
						<%=ssb.getCpuRatio() %>%
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td colSpan=2>
						ecology��Ϣ
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;��Ȩ
					</td>
					<td class="field">
						<%=ssb.getCompanyName() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;�汾��
					</td>
					<td class="field">
						<%=ssb.getCversion() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						&nbsp;&nbsp;ecologyע���û�
					</td>
					<td class="field">
						<%=ssb.getUserNum() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						resin�汾
					</td>
					<td class="field">
						<%=ssb.getMiddleV() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
				<tr>
					<td>
						JVM��Ϣ
					</td>
					<td class="field">
						<%=ssb.getJVMVersion() %>
					</td>
				</tr>
				<TR>
					<TD class=Line colSpan=2></TD>
				</TR>
			</tbody>
		</table>
	</BODY>
</HTML>