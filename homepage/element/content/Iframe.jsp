<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.conn.*" %>
<%@ include file="/homepage/element/content/Common.jsp" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="java.io.BufferedReader" %>
<jsp:useBean id="dnm" class="weaver.docs.news.DocNewsManager" scope="page"/>
<jsp:useBean id="dm" class="weaver.docs.docs.DocManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="oDocManager" class="weaver.docs.docs.DocManager" scope="page"/>
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
		strsqlwherecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String hpsb.getEsymbol() ����ͼ��
		String hpsb.getEsparatorimg()   �зָ��� 
	*/

%>
<%
if("".equals(strsqlwhere)) return;

String strAddr="";
String strMore="";
String strWidth="";
String strHeight="";

String flag="^,^";
int pos1=strsqlwhere.indexOf(flag);
int pos2=strsqlwhere.indexOf(flag, pos1+3);
int pos3=strsqlwhere.indexOf(flag, pos2+3);

strAddr=strsqlwhere.substring(0,pos1);
strMore=strsqlwhere.substring(pos1+3,pos2);
strWidth=strsqlwhere.substring(pos2+3,pos3);
strHeight=strsqlwhere.substring(pos3+3);
%>
<iframe id="ifrm_<%=eid%>" name="ifrm_<%=eid%>" BORDER=0 FRAMEBORDER="no" NORESIZE=NORESIZE  scrolling="auto"
width="100%" height="<%=strHeight%>"  scrolling="NO" src="<%=strAddr%>"></iframe>






