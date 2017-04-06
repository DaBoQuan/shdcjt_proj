 <%@ page import="java.math.*" %>
 <%@ page import="weaver.fna.budget.BudgetHandler"%>
 <jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
 <jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
 <jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
 <jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
 <%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>
 <jsp:useBean id="WFNodeDtlFieldManager" class="weaver.workflow.workflow.WFNodeDtlFieldManager" scope="page" />
 <form name="frmmain" method="post" action="FnaWipeApplyOperation.jsp" enctype="multipart/form-data">
 <input type="hidden" name="needwfback" id="needwfback" value="1" />
 <input type="hidden" name="lastOperator"  id="lastOperator" value="<%=lastOperator%>"/>
 <input type="hidden" name="lastOperateDate"  id="lastOperateDate" value="<%=lastOperateDate%>"/>
 <input type="hidden" name="lastOperateTime"  id="lastOperateTime" value="<%=lastOperateTime%>"/>

     <%@ include file="/workflow/request/WorkflowManageRequestBody.jsp" %>
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
session.setAttribute(requestid+"_isedits",isedits);                    //�ֶ��Ƿ���Ա༭����

session.setAttribute(requestid+"_ismands",ismands);                    //�ֶ��Ƿ�����������
 %>
     <jsp:include page="/workflow/request/ManageFnaWipeApply0.jsp" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="requestmark" value="<%=requestmark%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="isreopen" value="<%=isreopen%>" />
    <jsp:param name="isreject" value="<%=isreject%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="docfileid" value="<%=docfileid%>" />
    <jsp:param name="newdocid" value="<%=newdocid%>" />
    <jsp:param name="topage" value="<%=topage%>" />
    <jsp:param name="isaffirmancebody" value="<%=isaffirmancebody%>"/>
    <jsp:param name="reEditbody" value="<%=reEditbody%>"/>     
    </jsp:include>