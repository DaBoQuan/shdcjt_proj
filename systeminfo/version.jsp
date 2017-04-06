<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%
String companyName="";
String cversion="";
RecordSet.executeSql("select companyname,cversion from license");
if (RecordSet.next())
{
	companyName=RecordSet.getString("companyname");
	cversion=RecordSet.getString("cversion");
}
%>


<html>
<head>
<title><%=SystemEnv.getHtmlLabelName(16900,user.getLanguage())%> ecology</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="/css/Weaver.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" scroll="no">

<style>
.textfield{
	width:100%;
	height:60px;
	overflow:auto;
	border:1px solid #31699B;
}

.splite{
	width:25px;
	display:inline;
}
</style>
<table width="460" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="2"><img src="/images_face/version/ecology.gif"></td>
  </tr>
  <tr> 
    <td width="362" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr>
          <td height="20">&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%>:&nbsp;<%=cversion%></td>
        </tr>
        <tr>
          <td height="20">&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(16898,user.getLanguage())%>:&nbsp;<%=companyName%></td>
        </tr>
        <tr>
        <%if(user.getLanguage()==7){%>
          <td>              
            <div class="textfield"><div class='splite'></div>������ǻ���J2EE�ĸ��ּ�����B/Sģʽ������ṹ�����ɵģ����Ϻ���΢����Ƽ��ɷ����޹�˾����������<br>
<div class='splite'></div>������İ�Ȩ�����Ϻ���΢����Ƽ��ɷ����޹�˾��δ����΢��˾����Ȩ��ɲ������Է�����ʹ�ø������<br>
<div class='splite'></div>weaver e-cology����΢˾������Ϻ���΢����Ƽ��ɷ����޹�˾�̱꣬Windows��NT��Java�Ⱦ��Ǹ���ع�˾���̱��ע���̱ꡣ<br>
<div class='splite'></div>����:�����������������Ȩ���͹��ʹ�Լ�ı�����δ����Ȩ���Ը��ƻ�ɢ��������Ĳ��ֻ�ȫ�������������������º����´���������֪��Υ���߽����跨�ɷ�Χ�ڵ�ȫ���Ʋá�</div>
          </td>
         <%}else if(user.getLanguage()==8){%>
          <td>              
            <div class="textfield"><div class='splite'></div>This software is based on various technologies of J2EE and three-layer framework of B/S mode,It's developed independently by Shanghai Weaver Network Co., Ltd.<br>
<div class='splite'></div>The copyright of this software belongs to Shanghai Weaver Network Co., Ltd.It is prohibited to release or use this software.<br>
<div class='splite'></div>Weaver e-cology and releated are trademarks of Shanghai Weaver Network Co., Ltd.Windows, NT, Java and related are trademarks of the other companies.<br>
<div class='splite'></div>Warning:This program is protected by the law of copyright and the law of international convention. Without permission, any copying or dispersing any part of the program will be subjected to civil and criminal penalties. Any trespasser who knows this warning will be measured out harsh justice.</div>
          </td>
         <%}else if(user.getLanguage()==9){%>
          <td>              
            <div class="textfield"><div class='splite'></div>��ܛ���ǻ��J2EE�ĸ��N���g��B/Sģʽ�����ӽY���OӋ��ɵģ����Ϻ���΢�W��Ƽ��ɷ����޹�˾�����_�l��<br> 
<div class='splite'></div>��ܛ���İ������Ϻ���΢�W��Ƽ��ɷ����޹�˾��δ����΢��˾���ڙ��S�ɲ������԰l����ʹ��ԓܛ���� <br>
<div class='splite'></div>weaver e-cology����΢˾�˾����Ϻ���΢�W��Ƽ��ɷ����޹�˾�̘ˣ�Windows��NT��Java�Ⱦ��Ǹ����P��˾���̘˻��]���̘ˡ�<br> 
<div class='splite'></div>����:��Ӌ��C�����������෨�͇��H���s�ı��o��δ���ڙ������}�u��ɢ�ѱ�����Ĳ��ֻ�ȫ���������܇��������º�����̎�P������֪���`���ߌ��o�跨�ɹ����ȵ�ȫ���u�á�</div>
          </td>
         <%}%>
        </tr>
        <tr height="5">
          <td></td>
        </tr>
        <tr height="30">          <td>&nbsp;&nbsp;<u><%=SystemEnv.getHtmlLabelName(16899,user.getLanguage())%>&nbsp;&nbsp;&copy;&nbsp;&nbsp;Shanghai Weaver Network Co., Ltd</u></td>
        </tr>
        <tr height="30">
          <td align="right"><button name="submit" onclick="window.close()" style="width:80px"><%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></button>&nbsp;&nbsp;</td>
        </tr>
        <tr height="30">
          <td></td>
        </tr>
        <tr height="30">
          <td valign="bottom">&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(16897,user.getLanguage())%>:&nbsp;<a href="http://www.weaver.com.cn" target="_blank"><u>www.weaver.com.cn</u></a></td>
        </tr>
      </table>
    </td>
    <td width="98"><img src="/images_face/version/img.gif"></td>
  </tr>
</table>
</body>
</html>