<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.ArrayList,
                 java.util.Iterator,
                 weaver.general.TimeUtil" %>
<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");

String today = TimeUtil.getCurrentDateString();
ArrayList birthEmployers=(ArrayList)application.getAttribute("birthEmployers");
String themeType=request.getParameter("theme"); //�������ͣ��û����ֵ������������Ƿ��Զ��ر�
%>
<script>
<%if(!"ecology7".equals(themeType)){%>
    setTimeout('window.close();',10000);
<%}%>
</script>                 
<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="499" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr>
    <td align="left" valign="top" height="247"><img src="/images_face/ecologyFace_1/BirthdayBg_1.jpg"></td>
  </tr>
  <tr> 
    <td align="left" valign="top" background="/images_face/ecologyFace_1/BirthdayBg_2.jpg"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="30"><br>
          </td>
          <td width="220" align="left" valign="top"><font color="#FFFFFF"><br>
            ��һ�ݿ���,���źؿ���! <br>
            �κ��˶���Ҫ��ϵ�ף��,<br>
            ������ˡ��������,��İ��ˡ���<br>
            �ͳ���������!<br>
            <br>
            <br>
            <%=today%> </font></td>
          <td width="120">&nbsp;</td>
          <td align="left" valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="55" height="18"><font color="#FFFFFF">��������:</font></td>
                <td>&nbsp;</td>
              </tr>
              <% Iterator iter=birthEmployers.iterator();
              while(iter.hasNext()){
              %>
              <tr> 
                <td height="18">&nbsp;</td>
                <td><font color="#FFFFFF"><%=iter.next()%></font></td>
              </tr>
              <%}%>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
