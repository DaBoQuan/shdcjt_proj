<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
int hreftype = Util.getIntValue(request.getParameter("hreftype"),0);
int hrefid = Util.getIntValue(request.getParameter("hrefid"),0);
String hreftarget = "";
String sql = "";
if(hreftype==1){//ģ��
	//http://127.0.0.1:86/formmode/view/AddFormMode.jsp?modeId=2&formId=-241&type=0
	sql = "select * from modeinfo where id = " +hrefid;
	rs.executeSql(sql);
	while(rs.next()){
		int formid = rs.getInt("formid");
		hreftarget = "/formmode/view/AddFormMode.jsp?modeId="+hrefid+"&formId="+formid+"&type=0";
	}
}else if(hreftype==3){//ģ���ѯ�б�
	//http://127.0.0.1:86/formmode/search/CustomSearchBySimple.jsp?customid=1
	sql = "select * from mode_customsearch where id = " +hrefid;
	rs.executeSql(sql);
	while(rs.next()){
		int formid = rs.getInt("formid");
		hreftarget = "/formmode/search/CustomSearchBySimple.jsp?customid="+hrefid;
	}
}
%>
<%=hreftarget%>