<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<jsp:useBean id="License" class="weaver.mobile.MobileLicense" scope="page" />
<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String message = Util.null2String(request.getParameter("message")) ;
String code = Util.null2String(request.getParameter("code")) ;
String imagefilename = "/images/hdSystem.gif";
String titlename = "LICENSE" ;
String needfav ="1";
String needhelp ="";

String licensecode = "";
licensecode = License.getMobileLicenseCode();

//companyname=Util.toScreen(companyname,7);
%>
<BODY>


<FORM id="codeform" style="MARGIN-TOP: 0px" name=frmMain action="MobileLicenseOperation.jsp" method=post onsubmit="return checkcode()" enctype="multipart/form-data">
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
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
	<div>
	<BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>�ύ</BUTTON> 
	</div><br>
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="10%"> <COL width="80%"><TBODY>
    <tr class=Title><TH colSpan=2>MOBILE LICENSE�ύ</TH></tr>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <tr>
        <td>��֤��:</td>
        <td class=Field><input class="InputStyle" type=password  id=code name=code maxlength=16 size=16 onchange='checkinput("code","codeimage")'><SPAN id=codeimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN><a  href="\system\ModifyCode.jsp">������֤��</a></td>
    </tr>
    <tr>
        <td>license�ļ�:</td>
        <td class=Field><input class="InputStyle" type=file id="license" name=license size=50 onchange='checkinput("license","licenseimage")'><SPAN id=licenseimage><IMG src="/images/BacoError.gif" align=absMiddle></td>
    </tr>
    </TBODY> 
  </TABLE>
  <br>
  <br>
	<DIV>
	ʶ����:	<span class=fontred><%=licensecode%></span>
	<br><br>
	�ᡡʾ: �����û��<span class=fontred>ʶ����</span>,���ȷ����ֻ����Ա�����<span class=fontred>ʶ����</span><br><br>�뽫<span class=fontred>��˾����</span>��<span class=fontred>ʶ����</span>�ύ�������Ӧ��,�Ի�ȡLicense
	</DIV>

	<%if(!message.equals("")){%>
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="10%"> <COL width="80%"><TBODY>
    <br>
    <br>
    <br>
		<tr class=Title><TH colSpan=2>�ύ������Ϣ</TH></tr>	
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
	    </TBODY> 
  </TABLE>	
		<DIV class=fontred>
	
		<%
		//message=0 ��ʾLicense��Ϣ����;message=1 ��ʾ�ɹ�;message=2 ��ʾ���ݿ����ӻ���ִ�г���;message=3 ��ʾLicense�ļ��ϴ�����;
		//message=4 ��ʾLicense��Ϣ����License����;message=5 ��ʾLicense��Ϣ����ע���û�������License��������;message=6 ��ʾѡ���License�ļ�����ȷ
		if(message.equals("1")){
			message=" Success ! " ;
			message+="";
		}else if(message.equals("0")){
			message="License��Ϣ��������������Resin����,���Ҽ��License�Ƿ���ȷ��<br>";
			message+="License message error,please try to restart Resin and check if the License is correct!";
		}else if(message.equals("2")){
			message="���ݿ����ӻ���ִ��ʧ�ܣ��밴���в����飺1.������ݿ�������Ƿ�������2.������ݿ��������Ƿ���ڣ�3.���weaver.properies������Ϣ�Ƿ���ȷ��<br>";
			message+="Failed to Connect Data Server,please check by step as below:1.checking the Data Server is OK;2.checking the SQL driver is exist;<br>";
			message+="3.checking the message of the file 'weaver.properies' is right!";
		}else if(message.equals("3")){
			message="License�ļ��ϴ�����<br>";
			message+="License file uploading error!";
		}else if(message.equals("4")){
			message="License��Ϣ����License�ѹ��ڣ�<br>";
			message+="License message error,license is overdue!";
		}else if(message.equals("5")){
			message="License��Ϣ�����ѷ����û�������License����������<br>";
			message+="License message error,the HRMs is larger than the apllied in the license!";
		}else if(message.equals("6")){
			message="û��ѡ����ȷ��License�ļ�����License�ļ������ڣ�<br>";
			message+="Wrong choosing License file or License file is not exist!";
		}
			%>
			<%=Util.toScreen(message,7,"2")%>
			</DIV>
	<%}%>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
</FORM>
</BODY>
<script language="javascript">
function check_form(thiswins,items)
{
	thiswin = thiswins
	items = items + ",";

	for(i=1;i<=thiswin.length;i++)
	{
	tmpname = thiswin.elements[i-1].name;
	tmpvalue = thiswin.elements[i-1].value;
    if(tmpvalue==null){
        continue;
    }
	while(tmpvalue.indexOf(" ") == 0)
		tmpvalue = tmpvalue.substring(1,tmpvalue.length);

	if(tmpname!="" &&items.indexOf(tmpname+",")!=-1 && tmpvalue == ""){
		 alert("������Ϣ��������");
		 return false;
		}

	}
	return true;
}
function checkcode() {
	if(!check_form(codeform,"code,license"))
	    return false;
	return true;
}
</script>
</HTML>
