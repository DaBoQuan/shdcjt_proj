<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.file.FileManage"%>
<jsp:useBean id="License" class="weaver.mobile.MobileLicense" scope="page" />
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
char[] c_code=new char[16];
new FileReader(GCONST.getRootPath()+File.separator+"WEB-INF"+File.separator+"code.key").read(c_code);

String realcode=new String(c_code).trim();
if(code.equals("")){//message=2 表示数据库连接或者执行出错
	message = "2";
	response.sendRedirect("InMobileLicense.jsp?message="+message+"&code="+code);
	return;
}
if(!realcode.equals(code)&&!code.equals("")){
%>
无效的验证码！
<%return;
}
int fileid = 0 ;
try {
	//message=0 表示License信息错误;message=1 表示成功;message=2 表示数据库连接或者执行出错;message=3 表示License文件上传出错;
	//message=4 表示License信息错误，License过期;message=5 表示License信息错误，注册用户数大于License申请人数;message=6 表示选择的License文件不正确
	fileid = Util.getIntValue(fu.uploadFiles("license"),0);
	
	String filename = fu.getFileName();
	
	String sql = "select filerealpath from imagefile where imagefileid = "+fileid;
	boolean r1 = RecordSet.executeSql(sql);
	
	if(!r1) message="2";//message=2 表示数据库连接或者执行出错
	
	String uploadfilepath="";
	if(RecordSet.next())
		uploadfilepath = RecordSet.getString("filerealpath");
	
	if(!uploadfilepath.equals("")){
		String projectPath = this.getServletConfig().getServletContext().getRealPath("/");
		if (projectPath.lastIndexOf("/") != (projectPath.length() - 1) && projectPath.lastIndexOf("\\") != (projectPath.length() - 1)) {
			projectPath += "/";
		}
		String licensefilepath = projectPath+"mobile"+File.separator+filename;;
		fm.copy(uploadfilepath,licensefilepath);

		message = License.checkLicense(licensefilepath)+"";
	}
}catch(Exception e) {
    message = "3" ;//message=3 表示License文件上传出错
}

response.sendRedirect("InMobileLicense.jsp?message="+message+"&code="+code);
%>