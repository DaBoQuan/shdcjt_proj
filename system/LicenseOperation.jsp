<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.file.FileManage"%>
<jsp:useBean id="LN" class="ln.LN" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
%>

<%
String message = "0" ;
String imagefilename = "/images/hdSystem.gif";
String titlename = "LICENSE" ;
String needfav ="1";
String needhelp ="";

FileUpload fu = new FileUpload(request,false);
FileManage fm = new FileManage();
String code = Util.null2String(fu.getParameter("code")).trim();
char[]  c_code=new char[16];
new FileReader(GCONST.getRootPath()+File.separator+"WEB-INF"+File.separator+"code.key").read(c_code);

String realcode=new String(c_code).trim();
if(code.equals("")){//message=2 ��ʾ���ݿ����ӻ���ִ�г���
	message = "2";
	response.sendRedirect("InLicense.jsp?message="+message+"&code="+code);
	return; 
}
if(!realcode.equals(code)&&!code.equals("")){ 
	//out.println(code);  
%> 
��Ч����֤�룡
<%return;
}  
int fileid = 0 ;
try {
	//message=0 ��ʾLicense��Ϣ����;message=1 ��ʾ�ɹ�;message=2 ��ʾ���ݿ����ӻ���ִ�г���;message=3 ��ʾLicense�ļ��ϴ�����;
	//message=4 ��ʾLicense��Ϣ����License����;message=5 ��ʾLicense��Ϣ����ע���û�������License��������;message=6 ��ʾѡ���License�ļ�����ȷ
	fileid = Util.getIntValue(fu.uploadFiles("license"),0);
	
	String filename = fu.getFileName(); 
	
	String sql = "select filerealpath from imagefile where imagefileid = "+fileid;  
	boolean r1 = RecordSet.executeSql(sql);
	
	if(!r1) message="2";//message=2 ��ʾ���ݿ����ӻ���ִ�г���
	
	String uploadfilepath="";
	if(RecordSet.next())
		uploadfilepath = RecordSet.getString("filerealpath");
	
	if(!uploadfilepath.equals("")){
		String licensefilepath = GCONST.getRootPath()+"license"+File.separatorChar+LN.OutLicensecode()+".license" ;
		fm.copy(uploadfilepath,licensefilepath);
		fm.DeleteFile(uploadfilepath);

		LN.removeLicenseComInfo();
        LN.ReadFromFile(licensefilepath);
		message = LN.InLicense();
	}
}catch(Exception e) {
    message = "3" ;//message=3 ��ʾLicense�ļ��ϴ�����
}

response.sendRedirect("InLicense.jsp?message="+message+"&code="+code);

%>

