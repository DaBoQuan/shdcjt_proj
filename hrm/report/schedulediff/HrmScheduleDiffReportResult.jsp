<%@ page language="java" contentType="text/html; charset=GBK" %>

<jsp:useBean id="HrmScheduleDiffManager" class="weaver.hrm.report.schedulediff.HrmScheduleDiffManager" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>



<%@ include file="/systeminfo/init.jsp" %>

<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(16559,user.getLanguage());
String needfav ="1";
String needhelp ="";

%>

<%

String fromDate = Util.null2String(request.getParameter("fromDate"));
String toDate = Util.null2String(request.getParameter("toDate"));

int subCompanyId = Util.getIntValue(request.getParameter("subCompanyId"),0);
int departmentId = Util.getIntValue(request.getParameter("departmentId"),0);
int resourceId = Util.getIntValue(request.getParameter("resourceId"),0);

//��ȫ���  
//��ѯ�Ŀ�ʼ���ںͽ������ڱ�����ֵ�ҳ���Ϊ10
if(fromDate==null||fromDate.trim().equals("")||fromDate.length()!=10
 ||toDate==null||toDate.trim().equals("")||toDate.length()!=10){
	return;
}
//�ǿ��ڹ���Աֻ�ܿ����Լ��ļ�¼
if(!HrmUserVarify.checkUserRight("BohaiInsuranceScheduleReport:View", user)){
	resourceId=user.getUID();
}

//����resourceId��departmentId��subCompanyId��ֵ
if(resourceId>0){
	departmentId=Util.getIntValue(ResourceComInfo.getDepartmentID(""+resourceId),0);
}

//����departmentId����subCompanyId��ֵ
if(departmentId>0){
	subCompanyId=Util.getIntValue(DepartmentComInfo.getSubcompanyid1(""+departmentId),0);
}
%>

<BODY onload="showdata()">
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%

RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",javascript:location.href='HrmScheduleDiffReport.jsp?fromDate="+fromDate+"&toDate="+toDate+"&subCompanyId="+subCompanyId+"&departmentId="+departmentId+"&resourceId="+resourceId+"',_self} " ;
RCMenuHeight += RCMenuHeightStep;

RCMenu += "{Excel,/weaver/weaver.file.ExcelOut,_self} " ;
RCMenuHeight += RCMenuHeightStep;

%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>




<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
<script language=javascript>
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
        ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showdata(){
    var ajax=ajaxinit();
    ajax.open("POST", "HrmScheduleDiffReportResultData.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("fromDate=<%=fromDate%>&toDate=<%=toDate%>&subCompanyId=<%=subCompanyId%>&departmentId=<%=departmentId%>&resourceId=<%=resourceId%>");
    //��ȡִ��״̬
    ajax.onreadystatechange = function() {
        //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
                document.all("showdatadiv").innerHTML=ajax.responseText;
            }catch(e){
                return false;
            }
        }
    }
}
</script>
<div id="showdatadiv">
	<table id="scrollarea" name="scrollarea" width="100%" height="100%" style="zIndex:-1" >
	<tr>
			<td align="center" valign="center">
				<fieldset style="width:30%;margin-top: 30px;">   
					<img src="/images/loading2.gif" align="top"><%=SystemEnv.getHtmlLabelName(20204,user.getLanguage())%></fieldset>
			</td>
	</tr>
	</table>
</div>
		
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
</body>
</html>




