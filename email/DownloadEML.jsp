<%@ page language="java" contentType="charset=GBK" %><%@ page import="weaver.hrm.*,weaver.general.*,weaver.conn.*,java.io.*" %><jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" /><%
User user = HrmUserVarify.getUser(request, response);
if(user == null)  return ;
String mailId = Util.null2String(request.getParameter("mailId"));
String subject = Util.null2String(request.getParameter("subject"));
String emlName = "";
String _emlPath = "";

rs.executeSql("SELECT subject,emlName,emlpath FROM mailresource WHERE id="+mailId+"");
if(rs.next()){
	//subject = rs.getString("subject");
	emlName = rs.getString("emlName");
	_emlPath = Util.null2String(rs.getString("emlPath"));
}

subject = Util.replace(subject, ":|\\?|\\*|\\||/|\\\\|\"|<|>", "", 0);
String emlPath = GCONST.getRootPath() + "email" + File.separatorChar + "eml" + File.separatorChar;

response.setContentType("application/vnd.ms-outlook;charset=GBK");
response.setHeader("Content-disposition","attachment;filename="+subject+".eml");


java.lang.String strFileName; //�ļ��� 
java.io.File objFile; //�ļ����� 
java.io.FileReader objFileReader; //���ļ����� 
char[] chrBuffer = new char[10]; //���� 
int intLength; //ʵ�ʶ������ַ���(һ������Ϊһ���ַ�) 

//���ô����ļ��� 
strFileName = emlPath+emlName+".eml"; 
if(!_emlPath.equals("")) strFileName = _emlPath;

//�����ļ����� 
objFile = new java.io.File(strFileName); 

//�ж��ļ��Ƿ���� 
if(objFile.exists()){//�ļ����� 
	//�������ļ����� 
	objFileReader = new java.io.FileReader(objFile); 

	//���ļ����� 
	while((intLength=objFileReader.read(chrBuffer))!=-1){ 
		//��� 
		out.write(chrBuffer,0,intLength); 
	} 

	//�رն��ļ����� 
	objFileReader.close(); 
}
%>