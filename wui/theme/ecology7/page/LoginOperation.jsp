<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.*,weaver.general.*,weaver.systeminfo.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>

<%

String method=Util.null2String(request.getParameter("method"));
String backdata = "1";//�ж��û��Ƿ��¼��1:�û��ѵ�¼��0:��ҳ��ʱ
if("checkIsAlive".equals(method)) {
	User user = null;
    user = HrmUserVarify.checkUser(request,response) ;
    if(user == null)  backdata = "0";
    out.println(backdata);
}

%>