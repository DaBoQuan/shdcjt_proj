<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="HrmKqSystemComInfo" class="weaver.hrm.schedule.HrmKqSystemComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
    
char separator = Util.getSeparator() ; 

String tosomeone = Util.null2String(request.getParameter("tosomeone")) ; //�ռ��˵�ַ
String timeinterval = Util.null2String(request.getParameter("timeinterval")) ;  //���ݲɼ�ʱ����(����)
String getdatatype = Util.null2String(request.getParameter("getdatatype")) ; //���ݲɼ���ʽ
String getdatavalue = Util.null2String(request.getParameter("getdatavalue"+getdatatype)) ; //������ʽ��ֵ
String avgworkhour = Util.null2String(request.getParameter("avgworkhour")) ; //ƽ��ÿ�¹���ʱ��(Сʱ)
String salaryenddate = Util.null2String(request.getParameter("salaryenddate")) ; //н�ʼ����������(�������죬��)
String signIpScope = Util.null2String(request.getParameter("signIpScope")) ;//ǩ��ǩ��ip

String para = tosomeone + separator + timeinterval + separator + getdatatype + separator + getdatavalue + separator + avgworkhour + separator + salaryenddate + separator + signIpScope ; 


RecordSet.executeProc("HrmkqSystemSet_Update" , para) ; 
RecordSet.next() ; 
HrmKqSystemComInfo.removeSystemCache() ; //

%>
<script>
    alert("<%=SystemEnv.getHtmlLabelName(16746,user.getLanguage())%>");	
    window.location = "HrmkqSystemSetEdit.jsp";
</script>