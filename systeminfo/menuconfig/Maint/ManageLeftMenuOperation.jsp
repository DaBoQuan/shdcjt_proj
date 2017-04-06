<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfoHandler" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="LabelComInfo" class="weaver.systeminfo.label.LabelComInfo" scope="page"/>
<%
    char separator = Util.getSeparator() ;
    String operation = Util.null2String(request.getParameter("operation"));
    
    String labelId = Util.null2String(request.getParameter("labelId"));
    String iconUrl = Util.null2String(request.getParameter("iconUrl"));
    String linkAddress = Util.null2String(request.getParameter("linkAddress"));
    String menuLevel = Util.null2String(request.getParameter("menuLevel"));
    String parentId = Util.null2String(request.getParameter("parentId"));
    String systemModuleId = Util.null2String(request.getParameter("systemModuleId"));

	//������ǩ����
    if(operation.equalsIgnoreCase("searchLabel")){
      String descLike = request.getParameter("descLike");
	  descLike=URLEncoder.encode(descLike);//��response.sendRedirect��������Ҫת����շ���Ҫ����
    
      String defaultIndex = Util.null2String(request.getParameter("defaultIndex"));
      int pageNum=Util.getIntValue(request.getParameter("pageNum"));

	  response.sendRedirect("LeftMenuAdd.jsp?labelId="+labelId+"&iconUrl="+iconUrl+"&linkAddress="+linkAddress+"&parentId="+parentId+"&systemModuleId="+systemModuleId+"&descLike="+descLike+"&menuLevel="+menuLevel+"&defaultIndex="+defaultIndex);
      return ;
    }

    //��������
    if(operation.equalsIgnoreCase("search")){
        String menuName = Util.null2String(request.getParameter("menuName"));
        menuName=URLEncoder.encode(menuName);//��response.sendRedirect��������Ҫת����շ���Ҫ����
        String menuId = Util.null2String(request.getParameter("menuId"));

		response.sendRedirect("ManageLeftMenu.jsp?menuName="+menuName+"&menuId="+menuId+"&menuLevel="+menuLevel+"&parentId="+parentId);
        return ;
    }
    //��Ӳ���
    else if(operation.equalsIgnoreCase("addLeftMenuInfo")){ 
    	String maxIdSql = "SELECT MAX(id) as MaxId FROM LeftMenuInfo";

        RecordSet.executeSql(maxIdSql);
        int maxId = 0;
        while(RecordSet.next()){
            maxId = RecordSet.getInt("MaxId");
        }
		
        String defaultIndex = Util.null2String(request.getParameter("defaultIndex"));

		if(defaultIndex.equalsIgnoreCase("")){
			defaultIndex = "1";
		}
        String para = "";

        para = menuLevel;
        para +=separator+parentId;
        para +=separator+defaultIndex;

        rs.executeProc("LeftMenuConfig_U_ByInfoInsert", para);
        
        int id = maxId+1;

        para = String.valueOf(id);
        para +=separator+labelId;
        para +=separator+iconUrl;
        para +=separator+linkAddress;
        para +=separator+menuLevel;
        para +=separator+parentId;
        para +=separator+defaultIndex;
        para +=separator+"0";
        para +=separator+"";
        para +=separator+systemModuleId;
        para +=separator+"0";

        rs.executeProc("LeftMenuInfo_Insert", para);
        
    	response.sendRedirect("ManageLeftMenu.jsp");
      	return ;
    }
    //ɾ������
    else if(operation.equalsIgnoreCase("deleteMenu")){
		String id = Util.null2String(request.getParameter("deleteMenuId"));
		String para = "";

        para = id;

		rs.executeProc("LeftMenuInfo_DeleteById", para);
        
    	response.sendRedirect("ManageLeftMenu.jsp");
      	return ;
    }
    //�޸�--������ɾ��ӵ���ʽ
    else if(operation.equalsIgnoreCase("editLeftMenuInfo")){ 
		String id = Util.null2String(request.getParameter("menuId"));
		String oldIndex = Util.null2String(request.getParameter("oldIndex"));
		String defaultIndex = Util.null2String(request.getParameter("defaultIndex"));
		if(defaultIndex.equalsIgnoreCase("")){
			defaultIndex = "1";
		}
		String para = "";

        para = id;
		para +=separator+oldIndex;
		para +=separator+labelId;
		para +=separator+iconUrl;
		para +=separator+linkAddress;
		para +=separator+menuLevel;
		para +=separator+parentId;
		para +=separator+defaultIndex;
		para +=separator+systemModuleId;

		rs.executeProc("LeftMenuInfo_Update", para);


        //db2
        rs.executeProc("Tri_ULeftMC_ByInfo", id+separator+defaultIndex);
        /*
        CREATE PROCEDURE Tri_ULeftMC_ByInfo(
        id_1	int,
        defaultIndex_1 int
        )	 */


        
    	response.sendRedirect("ManageLeftMenu.jsp");
      	return ;
    }
%>