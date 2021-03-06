<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.docs.category.security.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="SubCategoryManager" class="weaver.docs.category.SubCategoryManager" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	/* 修改分目录顺序 */
	String[] secids=request.getParameterValues("secid");
	String[] secorders=request.getParameterValues("secorder");
	if(secids!=null){
	for(int i=0;i<secids.length;i++){
	   RecordSet.executeSql("update docseccategory set secorder ='"+secorders[i]+"' where id = '"+secids[i]+"'");
	}
	SecCategoryComInfo.removeMainCategoryCache();
	}
	
	AclManager am = new AclManager();
	String operation = Util.null2String(request.getParameter("operation"));
  	String name = Util.fromScreen(request.getParameter("categoryname"),user.getLanguage());
  	name = name.trim();
  	String coder = Util.fromScreen(request.getParameter("coder"),user.getLanguage());
  	float  suborder = Util.getFloatValue(request.getParameter("suborder"),0);
  	
  	int noRepeatedName = Util.getIntValue(request.getParameter("norepeatedname"));

    String isUseFTPOfSystem=Util.null2String(request.getParameter("isUseFTPOfSystem"));//ecology系统使用FTP服务器设置功能  1:启用   0或其它:不使用
    String refreshSec=Util.null2String(request.getParameter("refreshSec"));//更新子目录设置  1：启用   0或其它：不启用
    String isUseFTP=Util.null2String(request.getParameter("isUseFTP"));//指定文档分目录是否启用FTP服务器设置
    int FTPConfigId=Util.getIntValue(request.getParameter("FTPConfigId"));//FTP服务器

    SubCategoryManager.resetParameter();	
  	SubCategoryManager.setIsUseFTPOfSystem(isUseFTPOfSystem);
  	SubCategoryManager.setRefreshSec(refreshSec);
  	SubCategoryManager.setIsUseFTP(isUseFTP);
  	SubCategoryManager.setFTPConfigId(FTPConfigId);

	SubCategoryManager.setCoder(coder);
	SubCategoryManager.setSuborder(suborder);
	SubCategoryManager.setNoRepeatedName(noRepeatedName);

	String srccategoryname = Util.fromScreen(request.getParameter("srccategoryname"),user.getLanguage());
	if(operation.equalsIgnoreCase("add")){
    int mainid = Util.getIntValue(request.getParameter("maincategoryid"),0);
    /* 上级分目录id */
    int subid = Util.getIntValue(request.getParameter("subcategoryid"), -1);
    //float sub_order = Util.getFloatValue(request.getParameter("sub_order"), 0);
      if(!HrmUserVarify.checkUserRight("DocSubCategoryAdd:Add", user) && !am.hasPermission(mainid, AclManager.CATEGORYTYPE_MAIN, user, AclManager.OPERATION_CREATEDIR)){
          response.sendRedirect("/notice/noright.jsp");
          return;
      }

      String checkSql = "select count(id) from DocSubCategory where maincategoryid="+mainid+" and categoryname = '"+name+"'";
      RecordSet.executeSql(checkSql);
      if(RecordSet.next()){
          if(RecordSet.getInt(1)>0){
              response.sendRedirect("DocSubCategoryAdd.jsp?id="+mainid+"&errorcode=10");
              return;
          }
      }



  	if (subid < 0) {
      	//SubCategoryManager.resetParameter();
      	SubCategoryManager.setClientAddress(request.getRemoteAddr());
    	SubCategoryManager.setUserid(user.getUID());
    	SubCategoryManager.setCategoryname(name);
    	SubCategoryManager.setMainCategoryid(mainid);
    	SubCategoryManager.setAction(operation);
    	SubCategoryComInfo.removeMainCategoryCache();
    	//RecordSet.executeSql("update DocSubCategory set suborder = "+sub_order+" where id = (select max(id) from DocSubCategory)");
    	response.sendRedirect("DocMainCategoryEdit.jsp?id="+mainid+"&reftree=1");
    } else {
        //SubCategoryManager.resetParameter();
      	SubCategoryManager.setClientAddress(request.getRemoteAddr());
    	SubCategoryManager.setUserid(user.getUID());
    	SubCategoryManager.setCategoryname(name);
    	SubCategoryManager.setMainCategoryid(mainid);
    	SubCategoryManager.setSubCategoryid(subid);
    	SubCategoryManager.setAction(operation);
    	SubCategoryComInfo.removeMainCategoryCache();
    	//RecordSet.executeSql("update DocSubCategory set suborder = "+sub_order+" where id = (select max(id) from DocSubCategory)");
    	response.sendRedirect("DocSubCategoryEdit.jsp?id="+subid+"&reftree=1");
    }        
  }
  else if(operation.equalsIgnoreCase("edit")){
  	int mainid = Util.getIntValue(request.getParameter("mainid"),0);
  	int subid = Util.getIntValue(request.getParameter("subid"), -1);
  	int id = Util.getIntValue(request.getParameter("id"),0);

      if(!HrmUserVarify.checkUserRight("DocSubCategoryEdit:Edit", user) && !am.hasPermission(mainid, AclManager.CATEGORYTYPE_MAIN, user, AclManager.OPERATION_CREATEDIR)){
          response.sendRedirect("/notice/noright.jsp");
          return;
      }

      String checkSql = "select count(id) from DocSubCategory where categoryname <> '"+srccategoryname+"' and maincategoryid="+mainid+" and categoryname = '"+name+"'";
      RecordSet.executeSql(checkSql);
      if(RecordSet.next()){
          if(RecordSet.getInt(1)>0){
              response.sendRedirect("DocSubCategoryEdit.jsp?errorcode=10&id="+id);
              return;
          }
      }

  	//SubCategoryManager.resetParameter();
  	SubCategoryManager.setClientAddress(request.getRemoteAddr());
	SubCategoryManager.setUserid(user.getUID());
	SubCategoryManager.setCategoryname(name);
	//SubCategoryManager.setCoder(coder);
	//SubCategoryManager.setSuborder(suborder);
	//SubCategoryManager.setNoRepeatedName(noRepeatedName);
	
	SubCategoryManager.setCategoryid(id);
	SubCategoryManager.setMainCategoryid(mainid);
	SubCategoryManager.setAction(operation);
	SubCategoryComInfo.removeMainCategoryCache();
	if (subid < 0) {
	    response.sendRedirect("DocMainCategoryEdit.jsp?id="+mainid+"&reftree=1");
	} else {
	    response.sendRedirect("DocSubCategoryEdit.jsp?id="+subid+"&reftree=1");
	}
  }
  else if(operation.equalsIgnoreCase("delete")){
  	int mainid = Util.getIntValue(request.getParameter("mainid"),0);
  	int subid = Util.getIntValue(request.getParameter("subid"), -1);
  	int id = Util.getIntValue(request.getParameter("id"),0);

      if(!HrmUserVarify.checkUserRight("DocSubCategoryEdit:Delete", user) && !am.hasPermission(mainid, AclManager.CATEGORYTYPE_MAIN, user, AclManager.OPERATION_CREATEDIR)){
          response.sendRedirect("/notice/noright.jsp");
          return;
      }

  	String categoryname=SubCategoryComInfo.getSubCategoryname(""+id);
	String message = "";
  	//SubCategoryManager.resetParameter();
  	SubCategoryManager.setClientAddress(request.getRemoteAddr());
	SubCategoryManager.setUserid(user.getUID());
	SubCategoryManager.setCategoryname(categoryname);
	SubCategoryManager.setCategoryid(id);
	message = SubCategoryManager.DeleteCategoryInfo();
	if(!message.equals("")) {
  		int messageid = Util.getIntValue(message,0);
  		response.sendRedirect("DocSubCategoryEdit.jsp?id="+id+"&message="+messageid);
  	}
  	else {
		SubCategoryComInfo.removeMainCategoryCache();
		if (subid < 0) {
    	    response.sendRedirect("DocMainCategoryEdit.jsp?id="+mainid+"&reftree=1");
    	} else {
    	    response.sendRedirect("DocSubCategoryEdit.jsp?id="+subid+"&reftree=1");
    	}
	 }
  }
%>
 <input type="button" name="Submit2" value="<%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%>" onClick="javascript:history.go(-1)">