<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/element/loginViewCommon.jsp"%>
<%@ page import="weaver.general.ColorUtil" %>
<%@ page import="org.apache.commons.configuration.Configuration" %>
<%@ page import="org.apache.commons.lang.text.StrTokenizer" %>
<%@page import="weaver.general.GCONST"%>
<%@page import="weaver.general.Util"%>
<%@page import="org.apache.commons.configuration.XMLConfiguration"%>

<%@page import="org.w3c.dom.Document"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="dnm" class="weaver.docs.news.DocNewsManager" scope="page"/>
<jsp:useBean id="dm" class="weaver.docs.docs.DocManager" scope="page"/>
<jsp:useBean id="dc" class="weaver.docs.docs.DocComInfo" scope="page"/>
<%
	/*
		������Ϣ
		--------------------------------------
		hpid:����ҳID
		subCompanyId:��ҳ�����ֲ��ķֲ�ID
		eid:Ԫ��ID
		ebaseid:����Ԫ��ID
		styleid:��ʽID
		
		������Ϣ
		--------------------------------------
		String strsqlwhere ��ʽΪ ����1^,^����2...
		int perpage  ��ʾҳ��
		String linkmode �鿴��ʽ  1:��ǰҳ 2:����ҳ

		
		�ֶ���Ϣ
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		valuecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String hpsb.getEsymbol() ����ͼ��
		String hpsb.getEsparatorimg()   �зָ��� 
	*/

%>

<%
String reportFormId = "";
String reportFormTitle = "";
String reportFormHeight="";
String reportFormWidth="";
String reportFormSql = "";
String reportPoint="";
try {
	strsqlwhere = Util.StringReplace(strsqlwhere, "^,^"," ^,^ ");
} catch (Exception e) {					
	e.printStackTrace();
}

if(!"".equals(strsqlwhere)){
	int tempPos=strsqlwhere.indexOf("^,^");
	if(tempPos!=-1){
		StrTokenizer  strToken =  new StrTokenizer(strsqlwhere, "^,^");
		String[] arySqlWhere = strToken.getTokenArray();
		reportFormId=arySqlWhere[0].trim();
		reportFormTitle =arySqlWhere[1].trim();
		reportFormWidth= arySqlWhere[2].trim();
		reportFormHeight = arySqlWhere[3].trim();
		reportPoint= arySqlWhere[4].trim();
		reportFormSql=arySqlWhere[5].trim();
		reportFormSql = weaver.general.Util.stringReplace4DocDspExt(reportFormSql);
	} 
}
if(Util.getIntValue(reportFormId)<=10){
String reportFormSrc = "";
rs.execute("select * from hpReportFormType where id = '"+reportFormId+"'");

if(rs.next()){
	reportFormSrc = "/FusionChartsFree/Charts/"+rs.getString("src");
	
}

            String strXML="";
            if(!reportPoint.equals("")){
            	strXML =  hpes.getReportFormContent(eid,reportFormId,reportFormTitle,reportFormSql,reportFormSrc,reportPoint);
            }else{
            	strXML =  hpes.getReportFormContent(eid,reportFormId,reportFormTitle,reportFormSql,reportFormSrc);
            }
			strXML=strXML.replaceAll("&","��");//��������ֶ����������ַ���&�����ᵼ�±����޷�������
//TD34803 lv start           
String newReportFormSrc = "";
//��strXML���н������õ���ȷ��ͼ�����xml���µ�ͼ��swf�ļ�·����
if(strXML.indexOf("^,^")>-1){
	newReportFormSrc = strXML.substring(strXML.indexOf("^,^")+3);
	strXML = strXML.substring(0,strXML.indexOf("^,^"));
}
//TD34803 lv end    
//System.out.println("reportFormSrc="+reportFormSrc+"\n"+"newReportFormSrc="+newReportFormSrc+"\n"+"strXML="+strXML);
            response.setContentType("text/html;charset=utf-8");
			
            %> 
        <CENTER>
            <jsp:include page="/FusionChartsFree/FusionChartsHTMLRenderer.jsp" flush="true"> 
                <jsp:param name="chartSWF" value="<%=(newReportFormSrc.length()>0?newReportFormSrc:reportFormSrc)%>" /> 
                <jsp:param name="strURL" value="" /> 
                <jsp:param name="strXML" value="<%=strXML%>" /> 
                <jsp:param name="chartId" value="<%=eid%>" /> 
                <jsp:param name="chartWidth" value="<%=reportFormWidth%>" /> 
                <jsp:param name="chartHeight" value="<%=reportFormHeight%>" /> 
                <jsp:param name="debugMode" value="false" />                 
            </jsp:include>
        </CENTER>

<%}else{
	
	//String aa = xmlConfig.getString("Gauge2Label[@text]");
	//System.out.println(aa);
	String reportFormSrc = "";
	rs.execute("select * from hpReportFormType where id = '"+reportFormId+"'");

	if(rs.next()){
		reportFormSrc = rs.getString("src");
		
	}
	
	String strXML = "";
    if(!reportPoint.equals("")){
		strXML =  hpes.getReportFormContent(eid,reportFormId,reportFormTitle,reportFormSql,reportFormSrc,reportPoint);
	}else{
		strXML =  hpes.getReportFormContent(eid,reportFormId,reportFormTitle,reportFormSql,reportFormSrc);
	}
%>
	<%if(!strXML.equals("")) {%>
	 <CENTER>
	<div id ='reportForm<%=eid%>' style="width:<%=reportFormWidth%>; height:<%=reportFormHeight%>">
		<img src="about:blank" onerror='var eid =this.parentNode.id;this.parentNode.innerHTML="";initGauges(eid,"<%=strXML%>");'>
	</div>	
	</CENTER>
	<%}else{ %>
	
	<%} %>
<%	
}%>