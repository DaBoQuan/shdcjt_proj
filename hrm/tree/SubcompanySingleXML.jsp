<%@ page language="java" contentType="text/html; charset=GBK" %><%@ page import="weaver.general.Util" %><%@ page import="weaver.common.util.xtree.TreeNode" %><%@ page import="java.util.*" %><%@ page import="weaver.hrm.*" %><jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" /><jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" /><jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" /><%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
	
	User user = HrmUserVarify.getUser (request , response);
	
	if(user == null)
	{
	    return;
	}
	String excludeid=Util.null2String(request.getParameter("excludeid"));

	TreeNode envelope=new TreeNode();
	envelope.setTitle("envelope");

    TreeNode root = new TreeNode();
    String companyname = CompanyComInfo.getCompanyname("1");
    root.setTitle(companyname);
    root.setNodeId("com_1");
    root.setTarget("_self");
    root.setIcon("/images/treeimages/global.gif");

    envelope.addTreeNode(root);

    if (excludeid.equals(""))
    {
        SubCompanyComInfo.getAppDetachSubCompanyTreeList(root,"0",0,10,false,"subcompanySingle",null,null,user);
    }
    else
    {
        SubCompanyComInfo.getAppDetachSubCompanyTreeList(root,"0",0,10,false,"subcompanySingle",null,null,excludeid,user);
    }

	//envelope.marshal(out);
	weaver.common.util.string.StringUtil.parseXml(out, envelope);
%>