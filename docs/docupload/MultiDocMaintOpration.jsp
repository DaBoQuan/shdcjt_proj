<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page"/>


<% 
  if(!HrmUserVarify.checkUserRight("MultiDocUpload:maint", user))  {
    response.sendRedirect("/notice/noright.jsp") ;
    return ;
  }
%>


<%
//Ȩ���ж�
//����ϴ��ĸ����б���û���ļ�������û�����û���ϴ��ļ���û��Ȩ�����Ŀ¼�����ļ�


String imagefileids_MultiDocUp=(String) session.getValue("imagefileids_MultiDocUp");
if(imagefileids_MultiDocUp==null) {
	//��û�з��ʵ�ǰҳ���Ȩ��
	out.println( SystemEnv.getHtmlLabelName(2012,user.getLanguage()));	
	return;
}

ArrayList imgFileList=Util.TokenizerString(imagefileids_MultiDocUp,"+");

for(int i=0;i<imgFileList.size();i++){
	String imgFileId=(String)imgFileList.get(i);
	//out.println("imgFileId:"+imgFileId+"<br>");	
    //�洢�������
	DocManager.resetParameter();
  	DocManager.setClientAddress(request.getRemoteAddr());
    DocManager.setUserid(user.getUID());
    DocManager.setLanguageid(user.getLanguage());
    DocManager.setUsertype(""+user.getLogintype());	 

	DocManager.UploadFileToDoc(request,imgFileId);
}


//�����ϴ�ҳ��
response.sendRedirect("/docs/docupload/MultiDocMaint.jsp");
%>