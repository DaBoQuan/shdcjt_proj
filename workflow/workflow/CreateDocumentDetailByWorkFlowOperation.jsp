<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="WFDocumentManager" class="weaver.workflow.workflow.WFDocumentManager" scope="page" />

<HTML>
    <HEAD>
<%
    String workFlowID = request.getParameter("flowID");

    String selectItemID = request.getParameter("selectItemID");
    
    String secCategoryID = request.getParameter("secCategoryID");
    
    String docMouldID = request.getParameter("docMouldID");

    List bookMarkIDList = new ArrayList();
    
    List formDictIDList = new ArrayList();

    List dateShowTypeList = new ArrayList();
          
    int count = Integer.parseInt(request.getParameter("count"));

    String tempDocumentConfig="";	
    for(int i = 0; i < count; i++)
    {
        bookMarkIDList.add(request.getParameter("bookMarkID" + i));        
        
        //formDictIDList.add(request.getParameter("documentConfig" + i));
		tempDocumentConfig=Util.null2String(request.getParameter("documentConfig" + i));
		if(tempDocumentConfig.indexOf("_")>=0){
			tempDocumentConfig=tempDocumentConfig.substring(0,tempDocumentConfig.indexOf("_"));
		}
        formDictIDList.add(tempDocumentConfig);
		dateShowTypeList.add(Util.null2String(request.getParameter("dateShowType" + i)));
    }
    
    //WFDocumentManager.saveCreateDocDetail(workFlowID, selectItemID, secCategoryID, docMouldID, bookMarkIDList, formDictIDList);
    WFDocumentManager.saveCreateDocDetail(workFlowID, selectItemID, secCategoryID, docMouldID, bookMarkIDList, formDictIDList,dateShowTypeList);    
    response.sendRedirect("/workflow/workflow/CreateDocumentByWorkFlow.jsp?ajax=1&wfid=" + workFlowID + "&formid=" + request.getParameter("formID"));
%>
    </HEAD>
<BODY>

</BODY>
</HTML>