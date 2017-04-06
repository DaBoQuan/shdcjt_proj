<%@ page import="java.math.*" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="FnaLoanApplyOperation.jsp" enctype="multipart/form-data">
    <%@ include file="/workflow/request/WorkflowViewRequestBody.jsp" %>

<%

session.setAttribute(requestid+"_fieldids",fieldids);                  //�ֶζ���     
session.setAttribute(requestid+"_fieldorders",fieldorders);            //�ֶ���ʾ˳����� (�����ļ�����Ҫ)         
session.setAttribute(requestid+"_languageids",languageids);            //�ֶ���ʾ������(�����ļ�����Ҫ)       
session.setAttribute(requestid+"_fieldlabels",fieldlabels);            //���ݵ��ֶε�label���� 
      
session.setAttribute(requestid+"_fieldhtmltypes",fieldhtmltypes);      //���ݵ��ֶε�html type����        
session.setAttribute(requestid+"_fieldtypes",fieldtypes);              //���ݵ��ֶε�type����
session.setAttribute(requestid+"_fieldnames",fieldnames);              //���ݵ��ֶεı��ֶ�������
session.setAttribute(requestid+"_fieldvalues",fieldvalues);            //�ֶε�ֵ 

session.setAttribute(requestid+"_fieldviewtypes",fieldviewtypes);      //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)     
session.setAttribute(requestid+"_isfieldids",isfieldids);              //�ֶζ���
session.setAttribute(requestid+"_isviews",isviews);                    //�ֶ��Ƿ���ʾ����

  
%>
 
<jsp:include page="/workflow/request/ViewFnaLoanApplyAssistant.jsp" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="requestmark" value="<%=requestmark%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
</jsp:include>    