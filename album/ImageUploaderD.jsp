<%@ page language="java" contentType="text/html; charset=gbk" %>
<%@ page import='java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*,javax.servlet.http.HttpServletRequest,,weaver.hrm.*'%>
<%@ page import="weaver.general.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="p" class="weaver.album.PhotoComInfo" scope="page" />
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;
int albumId = Util.getIntValue(request.getParameter("id"));
String ancestorId = p.getAncestorId(""+albumId);

double albumSize=0.0, albumSizeUsed=0.0, albumSizeFree=0.0;
double maxTotalFileSizeByte = 0;
String maxTotalFileSize = "0";
String _albumSizeUsed = "0.00";
rs.executeSql("SELECT * FROM AlbumSubcompany WHERE subcompanyId="+ancestorId+"");
if(rs.next()){
	_albumSizeUsed = Util.null2String(rs.getString("albumSizeUsed"));
	albumSize = Double.parseDouble(rs.getString("albumSize"))/1000;
	albumSizeUsed = _albumSizeUsed.equals("") ? 0.00 : Double.parseDouble(rs.getString("albumSizeUsed"))/1000;
	albumSizeFree = albumSize-albumSizeUsed;
	maxTotalFileSizeByte = albumSizeFree*1024*1024;
	if(maxTotalFileSizeByte>0){
		maxTotalFileSize = String.valueOf(maxTotalFileSizeByte);//Util.round(String.valueOf(maxTotalFileSizeByte), 0);
	}
}

//�ò���ϵͳ����
String userAgent = request.getHeader("User-Agent");
String[] userAgentArr = Util.TokenizerString2(userAgent,";"); 
boolean isIe=true;
String osType="";
if(userAgentArr.length>=4){
  osType = userAgentArr[2];
}else{
	isIe=false;
}
osType = osType.trim();

if(osType.indexOf(' ')>-1){osType = osType.substring(0, osType.length());}
if((osType.indexOf("Mozilla/4.0 (compatible;")>-1)&&(0==osType.compareTo("Windows NT 5.0"))){osType = "Windows 2000";}
osType = Util.replace(osType,"NT5.0","2000",0);
osType = Util.replace(osType,"NT 5.0","2000",0);
osType = Util.replace(osType,"NT5.1","XP",0);
osType = Util.replace(osType,"NT 5.1","XP",0);
osType = Util.replace(osType,"NT5.2","2003",0);
osType = Util.replace(osType,"NT 5.2","2003",0);
//osType = osType.replace(')', ' ');
osType = osType.trim();

if(isIe){
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<style>body{margin:0}</style>
</head>
<body>
<%//����ͻ�����Windows 2003����Windows XP����ϵͳ����ʹ��UImageUploaderXPD.cab��%>
<object 
	id="UImageUploaderN" 
	type="application/x-oleobject" 
	classid="clsid:C7F9DEFD-2A17-88E8-862D-ED37D96E86B2" 
	codeBase="<%if(osType.equals("Windows 2003")||osType.equals("Windows XP")){%>UImageUploaderXPN.cab<%}else{%>UImageUploaderN.cab<%}%>#version=5,0,0,5" 
	style="width:100%;height:100%"
	VIEWASTEXT>
</object>
<script language="JavaScript">
//�ж�����İ汾�ǲ�������
if(UImageUploaderN.Version != "5.0.0.5"){
	strErrInfo = "ͼƬ�ϴ���������°汾��Ϊ��5.0.0.5.\n���ļ�����ϰ�װ������İ汾Ϊ��"
	strErrInfo += UImageUploaderN.Version
	strErrInfo += "��\n\nΪ��֤�ɹ��ϴ��� ������ʹ�����°�������"
	alert(strErrInfo)
}

UImageUploaderN.Action = "ImageUploadDealN.jsp";
UImageUploaderN.RedirectUrl = "AlbumList.jsp?id=<%=albumId%>";
//UImageUploaderN.ExpandLastTimeDirectory = 1;

//����������ļ���չ��
//UImageUploaderN.SetAllowedExtensions("*")
//���ò�������ļ���չ��
UImageUploaderN.SetForbiddenExtensions("bmp;")

//һ�������ϴ�������ļ�����
UImageUploaderN.MaxFileNum = 100
//ָ��һ���ϴ��ܹ������ļ���С(bytes)
try{
	UImageUploaderN.MaxTotalFileSize = "<%=maxTotalFileSize%>";
}catch(e){
	UImageUploaderN.MaxTotalFileSize = -1;
}

//������Ȩ��Ϣ
UImageUploaderN.SetLicenseSN("25HAB6GRL1H9DYF8-P69P5CLCLCLCP1P2-G81FXHEHFP838WDU-JCJ2C1XBGZ1Y6FZ8")
UImageUploaderN.CompanyName = "�Ϻ���΢����Ƽ����޹�˾"

UImageUploaderN.ListViewIconStyle = 32777
UImageUploaderN.EnableEditDescription = 0;
UImageUploaderN.ShowEditButton = 0;

//�󶨱�����������˽����ոñ���
//UImageUploaderN.AddField('FormFieldName1', 'FormFieldValue1')
//UImageUploaderN.AddField('FormFieldName2', 'FormFieldValue2')
UImageUploaderN.AddField('parentId', '<%=albumId%>');
</script>
</body>
</html>

<%}else { 
   response.sendRedirect("/wui/common/page/sysRemind.jsp?labelid=20001");
%>
<%} %>
