<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="WFDocumentManager" class="weaver.workflow.workflow.WFDocumentManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<%
    String workFlowID = request.getParameter("workFlowID");

    String show = request.getParameter("show");  //�Ƿ�ͨ�����̴����ĵ�    0:����
    String workFlowCoding = request.getParameter("workFlowCoding");  //���̱����ֶ�
    String createDocument = request.getParameter("createDocument");  //�����ĵ��ֶ�
    String documentTitleField = request.getParameter("documentTitleField");  //�ĵ������ֶ�
    String documentLocation = request.getParameter("documentLocation"); //�ļ����Ŀ¼

    String mainCategoryDocument = request.getParameter("mainCategoryDocument");  //һ����Ŀ¼
    String subCategoryDocument = request.getParameter("subCategoryDocument");  //������Ŀ¼
    String secCategoryDocument = request.getParameter("secCategoryDocument");  //������Ŀ¼

    String useTempletNode = Util.null2String(request.getParameter("useTempletNode"));  //�׺�ڵ�
    String printNodes = request.getParameter("printNodes");  //��ӡ�ڵ�
    String signatureNodes = request.getParameter("signatureNodes");//ǩ�½ڵ�
	String newTextNodes = Util.null2String(request.getParameter("newTextNodes"));//�Ƿ�ֻ���½�����
	String isCompellentMark = Util.null2String(request.getParameter("isCompellentMark"));//�Ƿ���뱣���ۼ�
	String isCancelCheck = Util.null2String(request.getParameter("isCancelCheckInput"));//�Ƿ�ȡ������
	String isWorkflowDraft = Util.null2String(request.getParameter("isWorkflowDraft"));//�Ƿ��Ϊ���̲ݸ�

	String ifVersion = Util.null2String(request.getParameter("ifVersion"));//�Ƿ������İ汾
    int titleFieldId = Util.getIntValue(request.getParameter("titleFieldId"),0);
    int keywordFieldId = Util.getIntValue(request.getParameter("keywordFieldId"),0);
	int extfile2doc = Util.getIntValue(request.getParameter("extfile2doc"),0);//���̸����Ƿ��Ϊ���ĸ���
	String defaultDocType = Util.null2String(request.getParameter("defaultDocType"));//Ĭ���ĵ����ͣ�1��Office Word   2��WPS����
	String isHideTheTraces = Util.null2String(request.getParameter("isHideTheTraces"));//�༭����ʱĬ�����غۼ�

	if("".equals(useTempletNode.trim())){
		useTempletNode = "-1";
	}

	if("".equals(isCompellentMark)){
		isCompellentMark = "0";
	}
	if("".equals(isCancelCheck)){
		isCancelCheck = "0";
	}
    if(!"".equals(show) && null != show)
    {

		WFDocumentManager.saveCreateDocByWorkFlow(workFlowID, "1", workFlowCoding, createDocument, documentLocation, mainCategoryDocument, subCategoryDocument, secCategoryDocument, useTempletNode, documentTitleField,printNodes,  newTextNodes, isCompellentMark, isCancelCheck,signatureNodes,isWorkflowDraft,defaultDocType,extfile2doc,isHideTheTraces);

		//RecordSet.executeSql("update workflow_base set ifVersion='"+ifVersion+"' where id=" +workFlowID);
		RecordSet.executeSql("update workflow_base set ifVersion='"+ifVersion+"',titleFieldId="+titleFieldId+",keywordFieldId="+keywordFieldId+" where id=" +workFlowID);
    }
    else
    {
		WFDocumentManager.saveCreateDocByWorkFlow(workFlowID, "0", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "","", "0", "0","","","",0,"0");
		//RecordSet.executeSql("update workflow_base set ifVersion='0' where id=" +workFlowID);
		RecordSet.executeSql("update workflow_base set ifVersion='0',titleFieldId="+titleFieldId+",keywordFieldId="+keywordFieldId+" where id=" +workFlowID);

    }
    
    response.sendRedirect("/workflow/workflow/CreateDocumentByWorkFlow.jsp?ajax=1&wfid=" + request.getParameter("workFlowID") + "&formid=" + request.getParameter("formID") + "&isbill=" + request.getParameter("isbill"));
%>



