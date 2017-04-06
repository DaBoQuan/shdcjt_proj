<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
    char separator = Util.getSeparator() ;
    String operation = Util.null2String(request.getParameter("operation"));
    
    String moduleId = Util.null2String(request.getParameter("moduleId"));
    String moduleName = Util.null2String(request.getParameter("moduleName"));

    //��������
    if(operation.equalsIgnoreCase("search")){
        moduleName=URLEncoder.encode(moduleName);//��response.sendRedirect��������Ҫת����շ���Ҫ����

		response.sendRedirect("ManageSystemModule.jsp?moduleName="+moduleName+"&moduleId="+moduleId);
        return ;
    }
    //��Ӳ���
    else if(operation.equalsIgnoreCase("addModule")){ 
        String moduleReleased = Util.null2String(request.getParameter("moduleReleased"));

        if(moduleReleased.equals("")){
            moduleReleased = "0";
        }

        String para = "";

        para = moduleName;
        para +=separator+moduleReleased;

        rs.executeProc("SystemModule_Insert", para);

    	response.sendRedirect("ManageSystemModule.jsp");
      	return ;
    }
    //ɾ������
    else if(operation.equalsIgnoreCase("deleteModule")){
		String id = Util.null2String(request.getParameter("deleteModuleId"));
		String para = "";

        para = id;

        rs.executeProc("SystemModule_Delete", para);
        
    	response.sendRedirect("ManageSystemModule.jsp");
      	return ;
    }
    //�޸�
    else if(operation.equalsIgnoreCase("editModule")){ 
        String moduleReleased = Util.null2String(request.getParameter("moduleReleased"));

        if(moduleReleased.equals("")){
            moduleReleased = "0";
        }

		String para = "";

        para = moduleId;
		para +=separator+moduleName;
		para +=separator+moduleReleased;

		rs.executeProc("SystemModule_Update", para);
        
    	response.sendRedirect("ManageSystemModule.jsp");
      	return ;
    }
%>