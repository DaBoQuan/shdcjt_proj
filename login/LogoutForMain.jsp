<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="java.util.Map"%>
<%@ page import="weaver.hrm.settings.RemindSettings"%>
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%
    System.out.println("moniter:"+request.getSession(true).getAttribute("moniter"));
    System.out.println("WeaverMailSet:"+request.getSession(true).getAttribute("WeaverMailSet"));
	User user = HrmUserVarify.getUser(request, response);
	RemindSettings settings0 = (RemindSettings) application.getAttribute("hrmsettings");
	Map logmessages = (Map) application.getAttribute("logmessages");
	String a_logmessage = "";
	if (logmessages != null)
		a_logmessage = Util.null2String((String)logmessages.get(""+ user.getUID()));
	String s_logmessage = Util.null2String((String)session.getAttribute("logmessage"));
	if (s_logmessage == null)
		s_logmessage = "";
	String relogin0 = Util.null2String(settings0.getRelogin());
	String fromPDA = Util.null2String((String)session.getAttribute("loginPAD"));
	//hubo ���С���ڵ�¼��ʶ
	if (request.getSession(true).getAttribute("layoutStyle") != null)
		request.getSession(true).setAttribute("layoutStyle", null);
	System.out.println("remove:s_logmessage:" + s_logmessage + "a_logmessage:" + a_logmessage);
	//xiaofeng ��Ч�ĵ��������˳�ʱ�����½���,�߳����û�ֱ���˳�
	if (!relogin0.equals("1") && !s_logmessage.equals(a_logmessage)) {
		if (fromPDA.equals("1")) {
			response.sendRedirect("/login/LoginPDA.jsp");
		} else {
			response.sendRedirect("/login/Login.jsp");
		}
		return;
	} else {
		logmessages = (Map) application.getAttribute("logmessages");
		if (logmessages != null)
			logmessages.remove("" + user.getUID());
	}
    
	String loginfile = Util.getCookie(request, "loginfileweaver");
	
	LicenseCheckLogin.updateOnlinFlag(""+ user.getUID());
	
	request.getSession(true).removeValue("moniter");
	request.getSession(true).removeValue("WeaverMailSet");
	request.getSession(true).invalidate();
%>