<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.Writer"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
User user = HrmUserVarify.getUser(request,response);
if(user == null)  return ;

String CoType = Util.null2String(request.getParameter("CoType"));
String returnvalue="";

String mainId = "";
String subId = "";
String secId = "";
String maxsize = "0";
if(!CoType.equals("")){//�Ȳ���Ĭ��Э�������͵ĸ����ϴ�Ŀ¼
    rs.executeSql("select category from cowork_maintypes a,cowork_types b where a.id = b.departmentid and b.id="+CoType);
    rs.next();
    String category = Util.null2String(rs.getString("category"));
    if(!category.equals("")){//���������Ŀ¼����ȡֵ
        String[] categoryArr = Util.TokenizerString2(category,",");
        mainId = categoryArr[0];
        subId = categoryArr[1];
        secId = categoryArr[2];
        rs.executeSql("select maxUploadFileSize from DocSecCategory where id="+secId);
	      rs.next();
	      maxsize = Util.null2String(rs.getString(1));
    }
}
if(mainId.equals("")&&subId.equals("")&&secId.equals("")){//�����ʼЭ��������Ϊ�ջ��ʼЭ�������Ͷ�Ӧ�ĸ����ϴ�Ŀ¼δ���ã������ͳһ�ĸ����ϴ�Ŀ¼����
    rs.executeSql("select * from CoworkAccessory");
    if(rs.next()){
	     mainId = Util.null2String(rs.getString(2));
	     subId = Util.null2String(rs.getString(3));
	     secId = Util.null2String(rs.getString(4));
	     rs.executeSql("select maxUploadFileSize from DocSecCategory where id="+secId);
	     rs.next();
	     maxsize = Util.null2String(rs.getString(1));
    } 
}
if(mainId.equals("")&&subId.equals("")&&secId.equals("")){
    returnvalue = "<font color='red'>"+SystemEnv.getHtmlLabelName(17616,user.getLanguage())+
                  SystemEnv.getHtmlLabelName(92,user.getLanguage())+
                  SystemEnv.getHtmlLabelName(15808,user.getLanguage())+"!</font>";
}else{
	returnvalue="<div id='uploadDiv' mainId="+mainId+" subId="+subId+" secId="+secId+" maxsize="+maxsize+"></div>";
}
%>
<%=returnvalue%>