<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="MouldManager" class="weaver.docs.mouldfile.MouldManager" scope="page" />
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mouldfile.DocMouldComInfo" scope="page" />
<%
	MouldManager.resetParameter();
  	MouldManager.setLanguageid(user.getLanguage());
	MouldManager.setClientAddress(request.getRemoteAddr());
	MouldManager.setUserid(user.getUID());

  	MouldManager.UploadMould(request);
  	DocMouldComInfo.removeDocMouldCache();

	int subcompanyid1=Util.getIntValue(String.valueOf(session.getAttribute("DocMouldDsp_")),0);
	int subcompanyid2=Util.getIntValue(String.valueOf(session.getAttribute("DocMouldDspExt.jsp_")),0);
	MouldManager.getMouldSubInfoById();
	int subcompanyid = MouldManager.getSubcompanyid1();
	//System.out.println("subcompanyidlllll:"+subcompanyid);
    String urlfrom = MouldManager.getUrlFrom() ;
	String operation=MouldManager.getOperation();
	String state  = MouldManager.getState();//��ͬ�ĵ��Ƿ����á�
	int doctype = MouldManager.getDoctype();//��ͬ�ĵ����ļ����ͣ� 0��HTML��2��Word��3��Excel
    //���ص�ģ����ʾҳ��
 	//response.sendRedirect("DocMould.jsp?urlfrom="+urlfrom);
	
	//Modify by ����� 2004-10-25 For TD1271
	if(operation.equals("delete") && !state.equals("nodelete")){
 			response.sendRedirect("DocMould.jsp?urlfrom="+urlfrom+"&subcompanyid1="+subcompanyid1);
	}else if(operation.equals("delete") && state.equals("nodelete") && doctype == 0){
			response.sendRedirect("DocMouldDsp.jsp?id="+MouldManager.getId()+"&urlfrom="+urlfrom+"&state="+state+"&subcompanyid1="+subcompanyid1);
	}else if(operation.equals("delete") && state.equals("nodelete") && (doctype == 2 || doctype == 3)){
			response.sendRedirect("DocMouldDspExt.jsp?id="+MouldManager.getId()+"&urlfrom="+urlfrom+"&state="+state+"&subcompanyid1="+subcompanyid2);
	}else if(!operation.equals("delete")){
			response.sendRedirect("DocMouldDsp.jsp?id="+MouldManager.getId()+"&urlfrom="+urlfrom+"&subcompanyid1="+subcompanyid);
	}
%>
