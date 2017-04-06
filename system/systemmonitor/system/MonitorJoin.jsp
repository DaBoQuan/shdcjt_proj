<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.hrm.*"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.monitor.*"%>
<%@ page import="weaver.monitor.utils.*"%>



<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<STYLE type=text/css>
		* {
			PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
		}
		BODY {
			TEXT-ALIGN: center; FONT: 14px/150% "����", "������", Arial; BACKGROUND: #fff; COLOR: #333
		}
		#content {
			POSITION: absolute; TEXT-ALIGN: left; CLEAR: both; OVERFLOW: hidden; TOP: 60px; LEFT: 0px
		}
		#container {
			BORDER-BOTTOM: medium none; BORDER-LEFT: #656565 0px solid; MARGIN: 0px 10px; WIDTH: 738px; BACKGROUND: #fff; BORDER-TOP: medium none; BORDER-RIGHT: #656565 0px solid
		}
		#container P {
			FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif
		}
		.topArc {
			HEIGHT: 6px; BORDER-TOP: #656565 0px solid
		}
		.bottomArc {
			BORDER-BOTTOM: #656565 0px solid; HEIGHT: 6px
		}
		.topArc SPAN {
			POSITION: relative; WIDTH: 100%; DISPLAY: block; HEIGHT: 6px
		}
		.bottomArc SPAN {
			POSITION: relative; WIDTH: 100%; DISPLAY: block; HEIGHT: 6px
		}
		.topArc .left {
			BACKGROUND: url(/img/arc.gif) no-repeat 0px 0px; TOP: -1px; LEFT: -1px
		}
		.topArc .right {
			BACKGROUND: url(/img/arc.gif) no-repeat 100% -6px; RIGHT: -2px
		}
		FIELDSET {
			BORDER-BOTTOM: #fff 1px solid; BORDER-LEFT: #fff 1px solid; MARGIN: 10px auto; WIDTH: 99%; BORDER-TOP: #ccc 1px solid; BORDER-RIGHT: #fff 1px solid
		}
		FIELDSET.focus {
			BORDER-TOP-COLOR: #458fda
		}
		LEGEND {
			PADDING-BOTTOM: 0px; MARGIN: 0px 0px 0px 12px; PADDING-LEFT: 5px; PADDING-RIGHT: 5px; FONT-WEIGHT: bold; PADDING-TOP: 0px
		}
		LEGEND SPAN {
			COLOR: #666; FONT-SIZE: 12px; FONT-WEIGHT: normal
		}
		FIELDSET TABLE {
			MARGIN: 5px auto; WIDTH: 98%
		}
		FIELDSET TH {
			TEXT-ALIGN: left; PADDING-BOTTOM: 1px; PADDING-LEFT: 5px; PADDING-RIGHT: 5px; PADDING-TOP: 1px
		}
		FIELDSET TD {
			TEXT-ALIGN: left; PADDING-BOTTOM: 1px; PADDING-LEFT: 5px; PADDING-RIGHT: 5px; PADDING-TOP: 1px
		}
		FIELDSET TH {
			TEXT-ALIGN: right; WIDTH: 200px; FONT-WEIGHT: normal
		}
		FIELDSET .input {
			PADDING-LEFT: 10px; WIDTH: 245px
		}
		FIELDSET .text {
			WIDTH: 220px
		}
		FIELDSET .desc {
			PADDING-BOTTOM: 3px; PADDING-LEFT: 3px; WIDTH: 34%; PADDING-RIGHT: 3px; BACKGROUND: #f3f3f3; PADDING-TOP: 3px
		}
		#declare TD {
			PADDING-BOTTOM: 0px; PADDING-LEFT: 22px; PADDING-RIGHT: 22px; PADDING-TOP: 0px
		}
		FORM #declare P {
			PADDING-BOTTOM: 0px; TEXT-INDENT: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: #fff; COLOR: #444; FONT-SIZE: 12px; PADDING-TOP: 0px
		}
		.clause {
			BORDER-BOTTOM: #7f9db9 1px solid; BORDER-LEFT: #7f9db9 1px solid; PADDING-BOTTOM: 8px; OVERFLOW-Y: scroll; PADDING-LEFT: 15px; PADDING-RIGHT: 15px; HEIGHT: 400px; BORDER-TOP: #7f9db9 1px solid; BORDER-RIGHT: #7f9db9 1px solid; PADDING-TOP: 8px
		}
		#declare .clause P {
			LINE-HEIGHT: 150%; TEXT-INDENT: 2em
		}
		.clause .unline {
			COLOR: #000000; TEXT-DECORATION: underline
		}
		#btn {
			BACKGROUND: #f8f8f8; BORDER-TOP: #ededed 1px solid
		}
		#fByqa0 .confirm {
			WIDTH: 80px
		}
		#fByqa1 .confirm {
			WIDTH: 80px
		}
		#fBypingma .confirm {
			WIDTH: 80px
		}
		.confirm {
			MARGIN: 10px 0px; WIDTH: 140px; BACKGROUND: #f8f8f8; LETTER-SPACING: 1px; HEIGHT: 28px;border:0px;
		}
		.confirm2 {
			MARGIN: 10px 0px; WIDTH: 50px; BACKGROUND: #e0e0de; LETTER-SPACING: 1px; HEIGHT: 28px;
		}
<!--
 /* Font Definitions */
 @font-face
	{font-family:����;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1073750139 0 0 159 0;}
@font-face
	{font-family:΢���ź�;
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-alt:"Arial Unicode MS";
	mso-font-charset:134;
	mso-generic-font-family:swiss;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:1 135135232 16 0 262144 0;}
@font-face
	{font-family:"Microsoft YaHei Western";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-alt:Arial;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:"\@����";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:"\@΢���ź�";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:134;
	mso-generic-font-family:swiss;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:1 135135232 16 0 262144 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:����;
	mso-bidi-font-family:"Times New Roman";
	mso-font-kerning:1.0pt;}
a:link, span.MsoHyperlink
	{font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
strong
	{font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
p
	{mso-style-noshow:yes;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:����;
	mso-bidi-font-family:����;}
p.ListParagraph, li.ListParagraph, div.ListParagraph
	{mso-style-name:"List Paragraph";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	mso-char-indent-count:2.0;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:����;
	mso-bidi-font-family:"Times New Roman";
	mso-font-kerning:1.0pt;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;
	font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
 /* Page Definitions */
 @page
	{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:2092194061;
	mso-list-type:hybrid;
	mso-list-template-ids:665077338 567542586 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-number-format:japanese-counting;
	mso-level-text:%1��;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	mso-bidi-font-family:"Times New Roman";}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
<!--[if gte mso 10]>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:��ͨ���;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
<![endif]-->
		</style>
	</head>
	<%
		User user = HrmUserVarify.getUser(request, response);
		if (user == null)
			return;
		if (user.getUID() != 1)
		{
			response.sendRedirect("/notice/noright.jsp");
			return;
		}
		String isJoinMonitor = Util.null2String(request.getParameter("isJoinMonitor"));
		String operatetype = Util.null2String(request.getParameter("operatetype"));
		
		if (!operatetype.equals(""))
		{
			ConfigOperator co = new ConfigOperator();
			co.setProp("monitorjoin.properties", "isJoinMaintenancePlan", isJoinMonitor);
		}
		else
		{
			isJoinMonitor = Util.null2String(MonitorPropValue.getJoinPropValueByName("isJoinMaintenancePlan"));
		}
		//System.out.println("operatetype : "+operatetype+" isJoinMonitor : "+isJoinMonitor);
	%>
	<BODY style="text-align: center;">
		<form id="frmRemain" name="frmRemain" method=post
			action="/system/systemmonitor/system/MonitorJoin.jsp">
			<DIV id=container>
				<DIV class=topArc>
					<SPAN class=left><SPAN class=right></SPAN> </SPAN>
				</DIV>
				<FIELDSET>
					<LEGEND>
						��������
					</LEGEND>
					<TABLE id=declare class=blur>
						<TBODY>
							<TR>
								<TD>
									<DIV class=clause>
										<div class=Section1 style='layout-grid: 15.6pt'>

											<p align=center style='text-align: center'>
												<strong><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>Զ�̼�ط���˵��</span>
												</strong><span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p></o:p>
												</span>
											</p>

											<p>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>ϵͳ��<span
													class=GramE>�</span>�������Ա���֮ǰ�����ڲ����е�ָ����ʵ�Ѿ���ʼ��������<span
													class=GramE>��΢��˾</span>�Ƴ���Զ�̼�ط�����Ǽ����Щϵͳ���е��ڲ�ָ�꣬�����ڴ�ռ��������߳�ִ��״̬�ȣ�һ��ָ�괦�ڲ�����״̬�����Ǿͻ��յ�Ԥ����Ϣ��ͬʱҲ���Կ�������ָ�겻����ľ�������������ǿ��Ծ��������ԭ�򣬰���������<span
													class=GramE>�</span>��֮ǰ����Ȼ���ܱ�֤<span lang=EN-US>100%</span>����<span
													class=GramE>�</span>�������ǿ��Ժܴ�̶��Ͻ��ͷ���<span class=GramE>�</span>���ĸ��ʣ����Ҽ�ʹ����<span
													class=GramE>�</span>�����������Ҳ�����ñ�ƽ��������ٶ��ҵ�ԭ�򣬽�����⡣<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>�������㿪����</span><span
													class=apple-converted-space><span lang=EN-US
													style='font-size: 9.0pt; font-family: "Microsoft YaHei Western"; mso-fareast-font-family: ΢���ź�; color: black'>&nbsp;</span>
												</span><strong><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>Զ�̼�ط���</span>
												</strong><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>�����ǻ�ʱ�̹�ע��ϵͳ���еĽ���״������ʱ����ϵͳ�Ĳ��ȶ�״̬��������ֻ�еȵ�<span
													class=GramE>崻��Ժ�</span>�ſ�ʼ������Ȼ����Ҳ����ѡ�񲻿���Զ�̼�ط�����������ϵͳ<span
													class=GramE>�</span>�������ǻ������λ��ϵͳ�Զ��ռ��������ڲ�ָ�귢�͸����ǣ��԰������ǽ���ԭ����Ų顣��Ҳ����ѡ����ʱ���ԵĽ��п������߹رմ����ط���<b
													style='mso-bidi-font-weight: normal'>��Ȼ���������������߹رգ�<span
														class=GramE>��΢��˾</span>�ռ�����ϢҲ������ϵͳ�����ڲ�ָ�꣬��֤�����ռ������޹���Ϣ</b>��<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>��������ÿ�����Զ�̼�ط�����Ҫ����Զ�̼�ػ��������������������<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>1</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>���������������������<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>2</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>������з���ǽ���������÷��������Է������µĵ�ַ��</span><span
													lang=EN-US><a href="http://update.e-cology.cn/"><span
														style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>http://update.e-cology.cn</span>
												</a>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>��<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal align=center style='text-align: center'>
												<b style='mso-bidi-font-weight: normal'><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>����Զ�̼�ط�������<span
														lang=EN-US><o:p></o:p>
													</span>
												</span>
												</b>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p>&nbsp;</o:p>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>�����������ǵ�Զ�̼�ط����Э�飬��ô���ǽ��ṩ����ķ���<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p>&nbsp;</o:p>
												</span>
											</p>

											<p class=ListParagraph
												style='margin-left: 21.0pt; text-indent: -21.0pt; mso-char-indent-count: 0; mso-list: l0 level1 lfo1'>
												<![if !supportLists]>
												<b style='mso-bidi-font-weight: normal'><span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; mso-bidi-font-family: ΢���ź�; color: black'><span
														style='mso-list: Ignore'>һ��<span
															style='font: 7.0pt "Times New Roman"'> </span>
													</span>
												</span>
												</b>
												<![endif]>
												<b style='mso-bidi-font-weight: normal'><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>����ڴ��쳣<span
														lang=EN-US><o:p></o:p>
													</span>
												</span>
												</b>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>��ϵͳ�ڴ�ռ�ñ����Ƚϴ󣬳�������Χʱ��ϵͳ���ȶ��Ծͻ��½������ܻ�����ϵͳ<span
													class=GramE>�</span>������ʹ��<span class=GramE>�</span>����Ҳ���ϵͳ�������ٶ���Ӱ�죬�������յ����Ԥ����Ϣʱ���������Ҫ�Ų������ڴ�ռ���쳣��ԭ�����ڴ�ռ���ܹ����ֵ�����ˮƽ��<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p>&nbsp;</o:p>
												</span>
											</p>

											<p class=ListParagraph
												style='margin-left: 21.0pt; text-indent: -21.0pt; mso-char-indent-count: 0; mso-list: l0 level1 lfo1'>
												<![if !supportLists]>
												<b style='mso-bidi-font-weight: normal'><span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; mso-bidi-font-family: ΢���ź�; color: black'><span
														style='mso-list: Ignore'>����<span
															style='font: 7.0pt "Times New Roman"'> </span>
													</span>
												</span>
												</b>
												<![endif]>
												<b style='mso-bidi-font-weight: normal'><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>���ϵͳ<span
														lang=EN-US>CPU</span>�������<span lang=EN-US><o:p></o:p>
													</span>
												</span>
												</b>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>�ܶ�ԭ�������ϵͳ��<span
													lang=EN-US>CPU</span>�������ߣ�����ʱ��ﵽ<span lang=EN-US>CPU
														100%</span>������Ӱ��ϵͳ�ٶȣ�����������ڳ����в�������㷨����<span lang=EN-US>CPU</span>��Դ�Ĵ���ռ�ã�����������δ֪ԭ�򣬵�ϵͳ��⵽�������ʱ���ᷢ�;�����Ϣ���������յ����������Ϣʱ���Ϳ�����һ���̶��Ϸ���������<span
													lang=EN-US>CPU</span>�������ߵľ������Ȼ�����ǻ�����������������Ż�����<span
													lang=EN-US>CPU</span>�ĸ��ر��ֵ�����ˮƽ��<span lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p>&nbsp;</o:p>
												</span>
											</p>

											<p class=ListParagraph
												style='margin-left: 21.0pt; text-indent: -21.0pt; mso-char-indent-count: 0; mso-list: l0 level1 lfo1'>
												<![if !supportLists]>
												<b style='mso-bidi-font-weight: normal'><span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; mso-bidi-font-family: ΢���ź�; color: black'><span
														style='mso-list: Ignore'>����<span
															style='font: 7.0pt "Times New Roman"'> </span>
													</span>
												</span>
												</b>
												<![endif]>
												<b style='mso-bidi-font-weight: normal'><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>���ϵͳ�����¼�<span
														lang=EN-US><o:p></o:p>
													</span>
												</span>
												</b>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>ϵͳ��ĳЩ�������⣬�ᵼ��ϵͳ<span
													lang=EN-US>Crash</span>��<span lang=EN-US>JVM</span>�������������������<span
													lang=EN-US>java </span>�������ĳЩ<span lang=EN-US>bug </span>�Լ�����һЩ������Ĳ������ã���ϵͳ����ʱ��<span
													lang=EN-US>Resin</span>�ı������ƻ������ٴ�����<span lang=EN-US>Resin</span>�������Ǹ���ϵͳ�������¼�����һ���̶��Ͼ��ܹ���ص�������������������档�������յ���������ʱ�򣬻������Ҫ�����ʵ������������������<span
													lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><o:p>&nbsp;</o:p>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'><span
													style='mso-tab-count: 1'>
												</span>
												</span><span
													style='font-size: 9.0pt; font-family: ΢���ź�; mso-hansi-font-family: ΢���ź�; color: black'>��Щ��Ϣ������ͬʱҲ���¼�����ǵ�<span
													lang=EN-US><span style='mso-spacerun: yes'>&nbsp;
													</span>ecology/log/warning </span>Ŀ¼�£���Ҳ�������в鿴��<span lang=EN-US><o:p></o:p>
												</span>
												</span>
											</p>

											<p class=MsoNormal>
												<span lang=EN-US><o:p>&nbsp;</o:p>
												</span>
											</p>

										</div>
									</DIV>
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</FIELDSET>
				<DIV id=btn>
					<input name="operatetype" type="hidden" value="">
					<input type="radio" style="WIDTH: 20px; HEIGHT: 28px; MARGIN: 12px 0px;" name="isJoinMonitor" <%if("1".equals(isJoinMonitor)){ %> checked <%} %> value="1" onclick="joinMonitor(this);"><input type="button" class="confirm" style="WIDTH: 120px;" name="pack" value="����Զ�̼�ط���">
					<input type="radio" style="WIDTH: 20px; HEIGHT: 28px; MARGIN: 12px 0px;" name="isJoinMonitor" <%if(!"1".equals(isJoinMonitor)){ %> checked <%} %> value="0" onclick="joinMonitor(this);"><input type="button" class="confirm" style="WIDTH: 130px;" name="pack" value="������Զ�̼�ط���">
					<input type="button" class="confirm2" name="pack" onclick="joinMonitor(this);" value="Ӧ��">
				</DIV>
				<DIV class=bottomArc>
					<SPAN class=left><SPAN class=right></SPAN> </SPAN>
				</DIV>
			</DIV>

		</form>
	</BODY>
	<script language="javascript">
	function joinMonitor(obj)
	{
		frmRemain.operatetype.value="join";
		frmRemain.submit();
	}
	</script>
</HTML>