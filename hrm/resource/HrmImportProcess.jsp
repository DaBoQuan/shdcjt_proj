<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,weaver.file.*,java.util.*" %>
<%@page import="weaver.join.hrm.in.IHrmImportAdapt"%>
<%@page import="weaver.join.hrm.in.HrmResourceVo"%>
<%@page import="weaver.join.hrm.in.IHrmImportProcess"%>
<%@page import="weaver.join.hrm.in.processImpl.HrmImportProcess"%>
<%@page import="weaver.general.StaticObj"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
	if (!HrmUserVarify.checkUserRight("HrmDefaultScheduleEdit:Edit",
			user)) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
%>
<%
 /*�ۺϿ��Ƕ�����Դ��ʵ��ͨ�������ļ������������ͽ�����*/
  StaticObj staticObj=StaticObj.getInstance();  

  IHrmImportAdapt importAdapt=(IHrmImportAdapt)Class.forName("weaver.join.hrm.in.adaptImpl.HrmImportAdaptExcel").newInstance();
  
  FileUploadToPath fu = new FileUploadToPath(request) ; 
  
  //�ظ����ֶΣ����ݿ�������ͬ�����update
  String keyField=fu.getParameter("keyField");
  
  //���ظ�����֤�ֶη��뻺�棬��HrmImportLog.jsp�л�ȡ�������жϹؼ��ֶ���
  staticObj.putObject("keyField",keyField);
  
  //��������  ���|����
  String importType=fu.getParameter("importType");
  
  List errorInfo=importAdapt.creatImportMap(fu);  
  
  //�����ȡ���ݺ���֤ģ��û�з�������
  if(errorInfo.isEmpty()){
	  Map hrMap=importAdapt.getHrmImportMap();
	
	  IHrmImportProcess importProcess=(IHrmImportProcess)Class.forName("weaver.join.hrm.in.processImpl.HrmImportProcess").newInstance();
	  
	  importProcess.processMap(keyField,hrMap,importType); 
	  
	  staticObj.putObject("importStatus","over");
  }else{
	  staticObj.putObject("importStatus","error");
	  staticObj.putObject("errorInfo",errorInfo);
  }
%>


