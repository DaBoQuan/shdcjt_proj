<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>


<%
String message = Util.null2String(request.getParameter("message")) ;
if(!message.equals("")) message = SystemEnv.getErrorMsgName(Util.getIntValue(message),7) ;
String logintype = Util.null2String(request.getParameter("logintype")) ;
if(logintype.equals("")) logintype="1";
%>


<html>
<head>
<title>Эͬ����ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
</script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>
<SCRIPT language=javascript1.1>
<!--
function checkall()
{ 
	var i=0;
	var errMessage="";
if (form1.loginid.value=="") {errMessage=errMessage+"�������û�����\n";i=i+1;}
if (form1.userpassword.value=="") {errMessage=errMessage+"���������룡\n";i=i+1;}
if (i>0){alert(errMessage);form1.loginid.focus(); return false ;}
//  else { form1.submit() ; }
}
// -->
</SCRIPT>
<script language="JavaScript">
function click() {
if (event.button==2) {alert('��ЧԴ��Эͬ') }}
document.onmousedown=click
</script>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" margin=0 onload="javascripts:form1.loginid.focus()">
<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0"  bgcolor="#FFFFFF">
  <tr> 
    <td width="489" rowspan="2" valign="top" background="/images_face/login/bg.gif" ><img src="/images_face/login/left.jpg"></td>
    <td valign="top"> 
      <div align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="260">&nbsp;</td>
          </tr>
          <tr>
            <td height="217">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="217" background="/images_face/login/tablebg_datacenter.jpg">
        <form name=form1 action= "VerifyLogin.jsp"  method=post onSubmit="return checkall()">
		  <INPUT type=hidden name="loginfile" value= "/datacenter/maintenance/user/Login.jsp" >
		  <INPUT type=hidden name="logintype" value="2"> 
                  <tr> 
                    <td height="85">&nbsp;</td>
					<td height="85" valign="bottom" style="color:#FF0000;font-size:9pt"><%=message%></td>
                  </tr>
                  <tr> 
                    <td height="20" width="150">
                      <table width="150" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td></td>
                        </tr>
                      </table>
                    </td>
                    <td height="20"> 
                      <input type="text" name="loginid" class="stedit" size="10">
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="2" height="18">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td height="20" width="150"></td>
                    <td height="20"> 
                      <input type="password" name="userpassword" class="stedit" size="10" >
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="2" height="18">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td width=150 height="20">&nbsp;</td>
                    <td height="20"> 
                      <input type="submit" class="submit" name="Submit" value="&gt;&gt; �� ¼">
                    </td>
                  </tr>
                  <tr> 
                    <td>&nbsp;</td>
                  </tr>
                </form>
              </table>
            </td>
          </tr>
          <tr>
            <td height="19" background="/images_face/login/url.jpg">&nbsp;</td>
          </tr>
		  <tr>          
			  <td>	
				 <table width="100%" height=100% border="0" cellspacing="20" cellpadding="0"  bgcolor="#FFFFFF">
				 <tr> 
				 <td><span style="line-height: 20px"> <font style="color:#990000;font-weight: bold">��ʾ��</font>Эͬ����ϵͳ��Ҫ������<font style="color:#5F7DD0;font-weight: bold">IE5.0����</font> �Լ�ʹ�� <font style="color:#5F7DD0;font-weight: bold">Microsoft �������(VM)</font>����������״ε�¼ϵͳ��ȷ������������Ƿ���IE5.0���ϣ�Microsoft �������(VM)������ֱ�ӵ��<a href="/weaverplugin/msjavx86.exe"><font style="color:#5F7DD0;font-weight: bold;TEXT-DECORATION: underline">����</font></a>���ذ�װ���ò��ֻ�����״����ذ�װ�󼴿ɣ�����Ҫ�ظ���װ��</span>
				 </td>
				 </tr>
				 </table>
			  </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</html>
