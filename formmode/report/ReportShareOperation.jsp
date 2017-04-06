<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ReportShareInfo" class="weaver.formmode.report.ReportShareInfo" scope="page" />

<%
if(!HrmUserVarify.checkUserRight("ModeSetting:All", user)){
	response.sendRedirect("/notice/noright.jsp");
	return;
}

String method = Util.null2String(request.getParameter("method"));
int reportid = Util.getIntValue(request.getParameter("reportid"),0);

if(method.equals("addNew")){//����Ȩ��
	String txtShareDetail[] = request.getParameterValues("txtShareDetail");
	if(txtShareDetail != null){
		for(int i=0;i<txtShareDetail.length;i++){
			String txtSD = txtShareDetail[i];
			//System.out.println("txtSD="+txtSD);
			ArrayList txtSDList = Util.TokenizerString(txtSD,"_");
			ReportShareInfo.init();
			ReportShareInfo.setReportid(reportid);
			ReportShareInfo.setSharetype(Util.getIntValue((String)txtSDList.get(0),0));
			ReportShareInfo.setRelatedids(Util.null2String((String)txtSDList.get(1)));
			ReportShareInfo.setRolelevel(Util.getIntValue((String)txtSDList.get(2),0));
			ReportShareInfo.setShowlevel(Util.getIntValue((String)txtSDList.get(3),0));
			ReportShareInfo.setRighttype(Util.getIntValue((String)txtSDList.get(4),0));
			ReportShareInfo.insertAddRight();
		}
	}
}else if(method.equals("delete")){//ɾ��Ȩ��
	String mainids = Util.null2String(request.getParameter("mainids"));
	if(!mainids.equals("")){
		ReportShareInfo.init();
		ReportShareInfo.setReportid(reportid);
		ReportShareInfo.delShareByIds(mainids);
	}
}
response.sendRedirect("/formmode/report/ReportShare.jsp?id="+reportid);
%>