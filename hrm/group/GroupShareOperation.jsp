<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="GroupAction" class="weaver.hrm.group.GroupAction" scope="page" />

<%
/*Ȩ���ж�--Begin*/  
boolean cansave=HrmUserVarify.checkUserRight("CustomGroup:Edit", user);
int creatorid = Util.getIntValue(request.getParameter("ownerid"));
int operuid=user.getUID();
/*Ȩ���ж�--End*/  
int id = Util.getIntValue(request.getParameter("id"));
String method = Util.null2String(request.getParameter("method"));
int groupid = Util.getIntValue(request.getParameter("groupid"));
//int relatedshareid = Util.getIntValue(request.getParameter("relatedshareid"));
String relatedshareid = Util.null2String(request.getParameter("relatedshareid"));
int sharetype = Util.getIntValue(request.getParameter("sharetype"));
//String sharetype = Util.null2String(request.getParameter("sharetype"));
//int rolelevel = Util.getIntValue(request.getParameter("rolelevel"));
String rolelevel = Util.null2String(request.getParameter("rolelevel"));
//int seclevel = Util.getIntValue(request.getParameter("seclevel"));
String seclevel = Util.null2String(request.getParameter("seclevel"));
int sharelevel = Util.getIntValue(request.getParameter("sharelevel"));
int crmid = Util.getIntValue(request.getParameter("crmid"),0); //�ͻ����ʹ�-1��ʼ���εݼ���0��ʾ�ͻ�����Ϊ��
String userid ="-1" ;
String departmentid = "-1" ;
String subcompanyid="-1";
String roleid = "-1" ;
int foralluser = -1 ;
//int sharecrm=0;
if(sharetype==1){
	userid = relatedshareid ;
} 
if(sharetype==2) subcompanyid = relatedshareid ;
if(sharetype==3) departmentid = relatedshareid ;
if(sharetype==4) roleid = relatedshareid ;
if(sharetype==5) foralluser = 1 ;



if(method.equals("delete"))
{
	if(creatorid!=operuid&&!cansave){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
}
 GroupAction.deleteShare(id,groupid);



   

	

	
response.sendRedirect("GroupShare.jsp?groupid="+groupid);
	return;
}


if(method.equals("add"))
{
	  
	if(creatorid!=operuid&&!cansave){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
}
//  crmid =0
    GroupAction.addShare(groupid,sharetype,seclevel,rolelevel,sharelevel,userid,subcompanyid,departmentid,roleid,foralluser,crmid);




	response.sendRedirect("GroupShare.jsp?groupid="+groupid);
	return;
}
%>
