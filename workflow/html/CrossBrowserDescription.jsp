<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>

<html>
<head>
	<title>�������ģʽѡ��˵��</title>
</head>
<body>
<br>
<div id="helpdiv" name="helpdiv" style="width:100%;height:100%">
<%
//���ҳ������д����˵������3������
//���ñ�ǩ����Ϊ����˵�����Ǵ������
int languageid = Util.getIntValue(request.getParameter("languageid"), 7);
if(languageid == 7){
%>
&nbsp;&nbsp;&nbsp;&nbsp;
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">�������<span lang="EN-US">Html</span>ģ���ڷ�<span lang="EN-US">IE</span>�£�<span lang="EN-US">Chrome</span>��<span lang="EN-US">FF</span>����ϸ���޷����룬������ѡ�����ÿ������ģʽ����������⣬���ô�ģʽ������Ҫ������ģ�����ݣ������������²����������</font></span></b></span><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></b></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p><font color="#000000">&nbsp;</font></o:p></span></b></span><span style="font-size: 11px"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></b></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></b></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'">1.</span></b><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'">�ж��Ƿ���Ҫ�޸�ģ�壨��Ҫ���߱�<span lang="EN-US">Html</span>��֪ʶ����</span></b></font></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<font color="#000000"><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></b></font></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">��<span lang="EN-US">.</span>��ϸ���ִ����Ƿ���ͬһ��<span lang="EN-US">Table</span>����</font></span></span><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">�����������Դ�롿��ť����Դ�����ҵ���ϸ������Ԫ�أ�</font></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><img width="80%" alt="docimages_0" src="../../images/1.png" />&nbsp;&nbsp;&nbsp;</font></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	&nbsp;</p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">�����Ԫ��Ϊһ��������<span lang="EN-US">Table</span>���Ҹ�ʽΪ���¸�ʽʱ������Ҫ����ģ�壬��֮������Ҫ���������¸�ʽ</font></span></span><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'">&lt;table id=&quot;oTable0&quot; name=&quot;oTable0&quot; &hellip;&gt;<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>//</span><span style="font-family: '΢���ź�','sans-serif'">���뺬��<span lang="EN-US">id</span>��<span lang="EN-US">name</span>���ԣ������ݱ���Ϊ&ldquo;<span lang="EN-US">oTable</span>&rdquo;���ϵ�ǰ��ϸ�ǵڼ�����ϸ<span lang="EN-US">-1</span>���磺������ϸ����ô��һ����ϸ�����֣�<span lang="EN-US">oTable0 </span>�ڶ�����ϸ������Ϊ��<span lang="EN-US">oTable1</span>�Դ�����</span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000">&lt;tbody&gt;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>&lt;tr&gt;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&lt;td&gt;</span><span style="font-family: '΢���ź�','sans-serif'">��ϸ��ͷ��<span lang="EN-US">&lt;/td&gt;</span></span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&lt;td&gt;</span><span style="font-family: '΢���ź�','sans-serif'">��ϸ��ͷ��<span lang="EN-US">&lt;/td&gt;</span></span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&hellip;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>&lt;/tr&gt;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>&lt;tr&gt;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&lt;td&gt;</span><span style="font-family: '΢���ź�','sans-serif'">��ϸ��<span lang="EN-US">&lt;/td&gt;</span></span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&lt;td&gt;</span><span style="font-family: '΢���ź�','sans-serif'">��ϸ��<span lang="EN-US">&lt;/td&gt;</span></span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>&hellip;</font></span></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p><font color="#000000">&nbsp;</font></o:p></span></span><span style="font-size: 11px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><font color="#000000"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>&lt;/tr&gt;</font></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><o:p></o:p></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p><font color="#000000">&nbsp;</font></o:p></span></span><span style="font-size: 11px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p><font color="#000000">&nbsp;</font></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 11px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p><font color="#000000">&nbsp;</font></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 11px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'">2.Html</span></b><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'">ģ�������</span></b></font></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<font color="#000000"><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></b></font></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">����<span lang="EN-US">1</span>���ֶ�����ģ�壬����Ϊ���ϵĸ�ʽ���ɡ�</font></span></span><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></p>
<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'"><font color="#000000">����<span lang="EN-US">2</span>��</font></span></span><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></p>
<p class="MsoNormal" style="text-indent: -18pt; margin: 0cm 0cm 0pt 33.75pt; mso-list: l0 level1 lfo1">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-bidi-font-family: ΢���ź�"><span style="mso-list: Ignore">��<span style="line-height: normal; font-variant: normal; font-style: normal; font-family: 'Times New Roman'; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span style="font-family: '΢���ź�','sans-serif'">���ȱ��ݴ�<span lang="EN-US">html</span>ģ�����ݣ���һ��Ҫ���ݣ����������˲��裩</span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: -18pt; margin: 0cm 0cm 0pt 33.75pt; mso-list: l0 level1 lfo1">
	<span style="font-size: 12px"><font color="#000000"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-bidi-font-family: ΢���ź�"><span style="mso-list: Ignore">��<span style="line-height: normal; font-variant: normal; font-style: normal; font-family: 'Times New Roman'; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><span style="font-family: '΢���ź�','sans-serif'">������ڵ��ֶ������������á�������ϵͳĬ��ģ�壨�������ϵ�ģ�壬�ڢ����Ѿ����ݣ�</span></font></span><font color="#000000"><span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><span lang="EN-US"><o:p></o:p></span></span></font></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	&nbsp;</p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><font color="#000000"><v:shape id="_x0000_i1026" style="width: 6in; height: 204.75pt; visibility: visible" type="#_x0000_t75"><v:imagedata o:title="" src="file:///C:\Users\CC\AppData\Local\Temp\msohtmlclip1\01\clip_image003.png"></v:imagedata></v:shape><o:p></o:p></font></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><o:p><font color="#000000">&nbsp;<img width="80%" alt="docimages_0" src="../../images/2.png" />&nbsp;&nbsp;&nbsp;</font></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 11px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	&nbsp;</p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><o:p></o:p></span></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><span style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><font color="#000000">��<span lang="EN-US">. </span>��ϵͳ���ɵ�Ĭ��ģ���У��ҵ����ɵ���ϸ�飬�����������滻��ģ��ԭ������ϸ�鼴�ɣ���������ɵ���ʽ�����⣬�����ڴ˻����Ͻ���΢�����ɡ�</font></span></span></p>
<p>
	<img width="80%" alt="docimages_0" src="../../images/3.png" />&nbsp;&nbsp;&nbsp;</p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span style="font-family: '΢���ź�','sans-serif'; font-size: 8pt; mso-no-proof: yes"><font color="#000000"><span lang="EN-US"><o:p></o:p></span></font></span></p>
<p class="MsoNormal" style="text-indent: 15.75pt; margin: 0cm 0cm 0pt">
	<span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; mso-no-proof: yes"><v:shape id="_x0000_i1027" style="width: 6in; height: 212.25pt; visibility: visible" type="#_x0000_t75"><v:imagedata o:title="" src="file:///C:\Users\CC\AppData\Local\Temp\msohtmlclip1\01\clip_image005.png"></v:imagedata></v:shape></span><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'; font-size: 8pt"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin: 0cm 0cm 0pt">
	<span style="font-size: 12px"><font color="#000000"><b style="mso-bidi-font-weight: normal"><span lang="EN-US" style="font-family: '΢���ź�','sans-serif'">3.</span></b><b style="mso-bidi-font-weight: normal"><span style="font-family: '΢���ź�','sans-serif'">���ÿ������ģʽ�������档</span></b></font></span></p>
<%
}else if(languageid == 8){
%>
&nbsp;&nbsp;&nbsp;&nbsp;<b>Description of operation</b>
<%
}else if(languageid == 9){
%>

<%}%>
</div>

</body>
</html>
