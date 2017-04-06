<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*,weaver.conn.*"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="DmlActionInfoService" class="weaver.workflow.dmlaction.services.DmlActionInfoService" scope="page"/>
<%
if(!HrmUserVarify.checkUserRight("WorkflowManage:All", user))
{
	response.sendRedirect("/notice/noright.jsp");
	
	return;
}
int actionid = Util.getIntValue(Util.null2String(request.getParameter("actionid")),0);
//��������
String operate = Util.null2String(request.getParameter("operate"));
//��������
String actionname = Util.null2String(request.getParameter("actionname"));
//��������
int workflowId = Util.getIntValue(Util.null2String(request.getParameter("workflowId")),0);
//����Դ��
String maintablename = Util.null2String(request.getParameter("maintablename"));

//ִ��˳��
int dmlorder = Util.getIntValue(Util.null2String(request.getParameter("dmlorder")),0);
//�ڵ�id
int nodeid = Util.getIntValue(Util.null2String(request.getParameter("nodeid")),0);
//�Ƿ�Ϊ�ڵ��
String ispreoperator = Util.null2String(request.getParameter("ispreoperator"));
//���ڽڵ�id
int nodelinkid = Util.getIntValue(Util.null2String(request.getParameter("nodelinkid")),0);
//����Դid
String datasourceid = Util.null2String(request.getParameter("datasourceid"));
//��������
String dmltype = Util.null2String(request.getParameter("dmltype"));

int actionsqlsetid = Util.getIntValue(Util.null2String(request.getParameter("actionsqlsetid")),0);
//DML����formid
int dmlformid = Util.getIntValue(Util.null2String(request.getParameter("dmlformid")),0);
//DML����form����
String dmlformname = Util.null2String(request.getParameter("dmlformname"));
//DML����form�Ƿ�Ϊ��ϸ
String dmlisdetail = Util.null2String(request.getParameter("dmlisdetail"));
//DML������
String dmltablename = Util.null2String(request.getParameter("dmltablename"));
//DML�������
String dmltablebyname = Util.null2String(request.getParameter("dmltablebyname"));

//DML�����ֶζ�Ӧ��ϵ
String [] dmlfieldnames = request.getParameterValues("dmlfieldname");
//DML����������Ӧ��ϵ
String [] wherefieldnames = request.getParameterValues("wherefieldname");
//�Զ�����������
String dmlmainwhere = Util.null2String(request.getParameter("dmlmainwhere"));
//�Զ�������DML�������
String dmlmainsqltype = Util.null2String(request.getParameter("dmlmainsqltype"));
//�Զ�������DML���
String dmlmainsql = Util.null2String(request.getParameter("dmlmainsql"));


if("add".equals(operate))
{
	actionid = DmlActionInfoService.saveDMLActionSet(actionname,dmlorder,workflowId,nodeid,ispreoperator,nodelinkid,datasourceid,dmltype,
			maintablename,dmlformid,dmlformname,dmlisdetail,dmltablename,dmltablebyname,dmlfieldnames,wherefieldnames,dmlmainwhere,dmlmainsqltype,dmlmainsql);
	out.println("<script language=javascript>window.parent.close();dialogArguments.reloadDMLAtion();</script>");
	//response.sendRedirect("DMLActionSettingView.jsp?actionid="+actionid);
}
else if("edit".equals(operate))
{
	DmlActionInfoService.editDMLActionSet(actionid,actionname,dmlorder,workflowId,nodeid,ispreoperator,nodelinkid,
			datasourceid,dmltype,maintablename,actionsqlsetid,dmlformid,dmlformname,dmlisdetail,dmltablename,
			dmltablebyname,dmlfieldnames,wherefieldnames,dmlmainwhere,dmlmainsqltype,dmlmainsql);
	out.println("<script language=javascript>window.parent.close();dialogArguments.reloadDMLAtion();</script>");
	//response.sendRedirect("DMLActionSettingView.jsp?actionid="+actionid);
}
else if("delete".equals(operate))
{
	DmlActionInfoService.deleteDMLActionSet(actionid,actionsqlsetid,workflowId,nodeid,ispreoperator,nodelinkid);
	
	out.println("<script language=javascript>window.parent.close();dialogArguments.reloadDMLAtion();</script>");
}
%>
