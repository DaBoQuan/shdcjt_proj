<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*,HT.HTSrvAPI,java.math.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="weaver.file.Prop"%>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.systeminfo.template.UserTemplate"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.file.Prop"%>
<%@ page import="weaver.systeminfo.setting.*"%>
<jsp:useBean id="PluginUserCheck" class="weaver.license.PluginUserCheck"
	scope="page" />


<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="HrmScheduleDiffUtil"
	class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page" />



<%@ include file="/wui/common/page/initWui.jsp"%>

<%
	//�ж�����ǿ���޸�
	String changepwd = (String) request.getSession().getAttribute(
			"changepwd");
	if ("n".equals(changepwd)) {
		request.getSession().removeAttribute("changepwd");
		response.sendRedirect("/login/Login.jsp");
		return;
	} else if ("y".equals(changepwd)) {
		request.getSession().removeAttribute("changepwd");
	}

	/*�û���֤*/
	User user = HrmUserVarify.getUser(request, response);
	if (user == null) {
		response.sendRedirect("/login/Login.jsp");
		return;
	}
	String initsrcpage = "";
	String gopage = Util.null2String(request.getParameter("gopage"));
	String frompage = Util
			.null2String(request.getParameter("frompage"));
	int targetid = Util
			.getIntValue(request.getParameter("targetid"), 0);
	String logintype = Util.null2String(user.getLogintype());

	if (targetid == 0) {
		if (!logintype.equals("2")) {
			//initsrcpage="/workspace/WorkSpace.jsp";
			initsrcpage = "";
		} else {
			initsrcpage = "";
		}
	}
	if (!gopage.equals("")) {
		gopage = URLDecoder.decode(gopage);
		if (!"".equals(frompage)) {
			System.out.println(frompage);
			initsrcpage = gopage + "&message=1&id=" + user.getUID();
		} else {
			initsrcpage = gopage;
		}
	} else {
		String username = user.getUsername();
		String userid = "" + user.getUID();
		if (logintype.equals("2")) {
			switch (targetid) {
				case 1 : // �ĵ�  - ����
					initsrcpage = "/docs/news/NewsDsp.jsp?id=1";
					break;
				case 2 : // ������Դ - ����
					initsrcpage = "/docs/news/NewsDsp.jsp?id=2";
					break;
				case 3 : // ���� - ��֯�ṹ
					initsrcpage = "/org/OrgChart.jsp?charttype=F";
					break;
				case 4 : // ��Ʒ - ����ҳ��
					initsrcpage = "/lgc/catalog/LgcCatalogsView.jsp";
					break;
				case 5 : // CRM - �ҵĿͻ�
					initsrcpage = "/CRM/data/ViewCustomer.jsp?CustomerID="
							+ userid;
					break;
				case 6 : // ��Ŀ - �ҵ���Ŀ
					initsrcpage = "/proj/search/SearchOperation.jsp";
					break;
				case 7 : // ������ - �ҵĹ�����
					initsrcpage = "/workflow/request/RequestView.jsp";
					break;
				case 8 : // ������ - �ҵĹ�����
					initsrcpage = "/system/SystemMaintenance.jsp";
					break;
				case 9 : // ������ - �ҵĹ�����
					initsrcpage = "/cpt/CptMaintenance.jsp";
					break;

			}
		} else {
			switch (targetid) {
				case 1 : // �ĵ�  - ����
					initsrcpage = "/docs/report/DocRp.jsp";
					break;
				case 2 : // ������Դ - ����
					initsrcpage = "/hrm/report/HrmRp.jsp";
					break;
				case 3 : // ���� - ��֯�ṹ
					initsrcpage = "/fna/report/FnaReport.jsp";
					break;
				case 4 : // ��Ʒ - ����ҳ��
					initsrcpage = "/lgc/report/LgcRp.jsp";
					break;
				case 5 : // CRM - �ҵĿͻ�
					initsrcpage = "/CRM/CRMReport.jsp";
					break;
				case 6 : // ��Ŀ - �ҵ���Ŀ
					initsrcpage = "/proj/ProjReport.jsp";
					break;
				case 7 : // ������ - �ҵĹ�����
					initsrcpage = "/workflow/WFReport.jsp";
					break;
				case 8 : // ������ - �ҵĹ�����
					initsrcpage = "/system/SystemMaintenance.jsp";
					break;
				case 9 : // ������ - �ҵĹ�����
					initsrcpage = "/cpt/report/CptRp.jsp";
					break;

			}
		}
	}
	/**
	 * ϵͳ���⡢Ƥ��
	 */
	String pslSkinfolder = "";

	String curTheme = "";

	curTheme = getCurrWuiConfig(session, user, "theme");
	pslSkinfolder = getCurrWuiConfig(session, user, "skin");

	String ely6flg = "";
	if ("ecology6".equals(curTheme.toLowerCase())) {
		curTheme = "ecology7";
		ely6flg = "ecology6";
	}

	request.setAttribute("REQUEST_SKIN_FOLDER", pslSkinfolder);

	Map pageConfigKv = getPageConfigInfo(session, user);

	String logo = (String) pageConfigKv.get("logoTop");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title></title>
<!--For Base-->
<link rel="stylesheet" type="text/css" href="/wui/common/css/base.css" />
<script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
<script type="text/javascript"
	src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
<script type="text/javascript"
	src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script type="text/javascript"
	src="/js/jquery/plugins/client/jquery.client.js"></script>

<!--[if IE 6]>
			<script type='text/javascript' src='/wui/common/jquery/plugin/8a-min.js'></script>
		<![endif]-->
<!--[if IE 6]>	
			<script languange="javascript">
				DD_belatedPNG.fix('.menuItemIcon,#divFloatBg,.menuNavSpan_Expand,.menuNavSpan_Contraction,.toolbarSplitLine,#navTd span,.divFloatLeftmenu div,#leftBlockHrmInfoCenter,#topBlockHiddenContr,#leftBlockHiddenContr,.leftBlockTopBgLeft,.leftBlockHrmInfoLeft,.leftBlockHrmInfoRight,.leftMenuBottomLeft,.leftMenuBottomRight,.versiontype,#tblHrmToolbr span,.tbItm,#toolbarMoreBlockTop,.searchBlockBgDiv,#sign_dispan,.topBlockDateBlock,.toolbarTopRight,background');
				DD_belatedPNG.fix('#logo');
			</script>  
			<STYLE TYPE="text/css">
				html {filter:expression(document.execCommand("BackgroundImageCache", false, true));}
			</style>

		<![endif]-->

<STYLE TYPE="text/css">
body {
	margin: 0px;
	/*���Ա���̬���ĵ�ֵ*/
	/*background:url('images/body-bg.png') repeat-y;*/
	font-size: 9pt;
	font-family: verdana;
}

TABLE {
	FONT-SIZE: 9pt;
	FONT-FAMILY: Verdana
}

.xTable_message {
	border: 1px solid #8888AA;
	background: white;
	position: absolute;
	padding: 5px;
	z-index: 100;
	display: none;
	FONT-SIZE: 9pt;
	MARGIN: 0px;
	FONT-FAMILY: Verdana;
	LIST-STYLE-TYPE: circle;
}

table td {
	padding: 0px;
}

#container {
	width: 100%;
	height: 100%;
	border-collapse: collapse;
}

#head {
	WIDTH: 100%;
	height: 70px;
	background:
		url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/head-bg.jpg')
		no-repeat;
	/*background:url('images/head-bg.png') no-repeat;*/
	border-collapse: collapse;
}

#contentContainer {
	WIDTH: 100%;
	height: 100%;
	border-collapse: collapse;
}

#contentContainer #content {
	WIDTH: 100%;
	height: 100%;
	border-collapse: collapse;
}

#leftmenucontainer {
	height: 100%;
}

#footer {
	
}

#shadown-corner {
	background:
		url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/shadown-coner.png')
		no-repeat;
	width: 10px;
	height: 10px;
}

#shadown-x {
	background:
		url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/shadown-x.png')
		repeat-x;
	height: 10px;
}

#shadown-y {
	background:
		url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/shadown-y.png')
		repeat-y;
	width: 10px;
}

#shadown-content {
	background: #fff;
}

/*�ɸ�������  ���˵�*/
/*���˵���*/
#leftmenucontainer {
	
}
/*���˵���*/
#leftmenucontainer-top {
	height: 10px;
}

#leftmenu-top {
	height: 86px;
}

#leftmenu-bottom {
	height: 250px;
}

#leftmenu-bottom-bottom {
	height: 7px;
}

#leftmenu-bottom {
	position: absolute;
	width: 128;
	height: 0px;
	z-index: 0;
}

#leftBlockTd {
	background: none;
}

.leftBlockTopBgLeft {
	overflow: hidden;
	width: 10px;
	position: absolute;
	left: 0;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockTopBgLeft.jpg)
		no-repeat;
	height: 10px;
}

#leftBlockTopBgCenter {
	overflow: hidden;
	position: absolute;
	left: 10px;
	right: 2px;
	top: 0;
	height: 10px;
}

.leftBlockTopBgRight {
	overflow: hidden;
	position: absolute;
	right: -2;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockTopBgRight.jpg)
		no-repeat;
	height: 10px;
	width: 2px;
}

#leftmenu-top {
	position: absolute;
	width: 128;
	height: 87px;
}

.leftBlockHrmInfoLeft {
	width: 60px;
	position: absolute;
	left: 0;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockHrmInfoBgLeft.png)
		no-repeat;
	height: 87px;
}

.leftBlockHrmInfoCenter {
	position: absolute;
	left: 60px;
	right: 6px;
	top: 0;
	height: 87px;
	width: 60px;
}

.leftBlockHrmInfoRight {
	position: absolute;
	right: 0;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockHrmInfoBgRight.png)
		no-repeat;
	height: 87px;
	width: 6px;
}

#leftBlock_HrmDiv {
	position: relative;
	top: 0px;
	height: 86px;
}

#leftmenu-bottom-bottom {
	width: 128px;
	position: relative;
	top: 0px;
}

.leftMenuBottomLeft {
	width: 5px;
	position: absolute;
	left: 0;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftMenuBottomLeft.png)
		no-repeat;
	height: 7px;
}

#leftMenuBottomCenter {
	position: absolute;
	left: 5px;
	right: 6px;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftMenuBottomCenter.png)
		repeat-x;
	height: 7px;
}

.leftMenuBottomRight {
	position: absolute;
	right: 0;
	top: 0;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftMenuBottomRight.png)
		no-repeat;
	height: 7px;
	width: 6px;
}

#topBlockHiddenContr {
	width: 502px;
	height: 20px;
	position: relative;
	margin-bottom: -12px;
	cursor: pointer;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/topBlockContraction.png)
		no-repeat;
	background-position: 0 25;
}

#leftBlockHiddenContr {
	height: 502px;
	width: 12px;
	position: relative;
	margin-right: -12px;
	cursor: pointer;
	background:
		url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/leftBlockContraction.png)
		no-repeat;
	overflow: hidden;
	background-position: 25 0;
}

.versiontype {
	position: absolute;
	left: 150;
	top: 40;
	/*background:url(/wui/theme/ecology7/page/images/versiontype.png) no-repeat;height:10px;width:33px;display:block;overflow:hidden;*/
}

#mainFrame {
	height: 100% !important;
}
/*IE6 fixed*/
</STYLE>

<script type="text/javascript">
		window.onresize = function winResize() {
			if (jQuery("#mainBody").width() <= 1024 ) {
				jQuery("#container").css("width", "1020px");
			} else {
				jQuery("#container").css("width", jQuery("#mainBody").width() - 4);
			}
		}		
		jQuery(document).ready(function(){
		     jQuery("#mainBody").css("background","url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/body-bg.png') repeat-y");
		});
		//background:url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/body-bg.png') repeat-y;
		</script>
</head>


<!-- �������������CSS2011/5/19 -->

<body id="mainBody" scroll="no" style="">

	<!-- ǩ��ǩ����div -->
	<div id='divShowSignInfo'
		style='background: #FFFFFF; padding: 0px; width: 100%; display: none;'
		valign='top'></div>
	<div id='message_Div' style='display: none;'></div>
	<table id="container" height="70px" cellspacing="0" cellpadding="0">
		<!--��-->
		<tr id="mainTopBlockTr">
			<td height="70px" valign="top">
				<table id="head" cellspacing="0" cellpadding="0">
					<tr>
						<td width="270px">
							<div style="height: 70px; overflow: hidden;">
								<!-- main���ܲ�� -->
								<jsp:include page="/wui/common/page/mainPlugins.jsp"></jsp:include>
							</div>
						</td>
						<td width="*" class="center" align="center"
							style="position: relative; z-index: 1;">
							<!--���ò˵�����--> <jsp:include
								page="/wui/theme/ecology7/page/top.jsp"></jsp:include>

						</td>
						<td width="300px">
							<!--����������ť��--> <!--�ų��ð�ť����--> <jsp:include
								page="/wui/theme/ecology7/page/toolbar.jsp"></jsp:include>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!--��-->
		<tr height="*">
			<td>
				<table id="contentcontainer">
					<tr height="*">
						<td width="5px"></td>
						<td width="*">
							<table id="content">
								<tr>
									<td width="126px" id="leftBlockTd">
										<!--�������˵���-->
										<div id="leftmenucontainer"
											style="width: 100%; overflow: hidden;">
											<div id="leftmenucontainer-top"
												style="position: relative; left: -1;">
												<div class="leftBlockTopBgLeft"></div>
												<div id="leftBlockTopBgCenter"></div>
												<div class="leftBlockTopBgRight"></div>
											</div>
											<div style="padding-left: 10px; margin-top: 5px;">
												<table width="100%" cellpadding="0px" cellspacing="0px">
													<tr>
														<td>
															<table width="100%" cellpadding="0px" cellspacing="0px">
																<tr>
																	<td style="position: relative;">
																		<div id="leftmenu-top" style="">
																			<div class="leftBlockHrmInfoLeft"></div>
																			<div id="leftBlockHrmInfoCenter"
																				class="leftBlockHrmInfoCenter"></div>
																			<div class="leftBlockHrmInfoRight"></div>
																		</div>
																		<div id="leftBlock_HrmDiv">
																			<!--���ü�ʱͨѶ��صĶ���-->
																			<jsp:include
																				page="/wui/theme/ecology7/page/hrmInfo.jsp"></jsp:include>
																		</div>
																	</td>
																</tr>
															</table>

														</td>
													</tr>
													<tr>
														<td style="position: relative;">
															<div id="leftmenu-bottom"></div> <!--�������˵���-->
															<div style="position: relative; top: 0px;">

																<jsp:include page="/wui/theme/ecology7/page/left.jsp"></jsp:include>

															</div>
															<div id="leftmenu-bottom-bottom">
																<div class="leftMenuBottomLeft"></div>
																<div id="leftMenuBottomCenter"></div>
																<div class="leftMenuBottomRight"></div>
															</div>
														</td>
													</tr>
												</table>
											</div>
										</div>

									</td>
									<td width="*">
										<TABLE width="100%" height="100%" cellpadding="0px"
											cellspacing="0px">
											<TR>
												<TD id="shadown-corner"></TD>
												<TD width="*" id="shadown-x">
													<!-- �����˵�������block -->
													<TABLE width="100%" height="100%" cellpadding="0px"
														cellspacing="0px">
														<TR>
															<TD align="center">
																<table border="0" width="502px" height="5px"
																	align="center" cellpadding="0px" cellspacing="0px">
																	<tr>
																		<td style="position: relative; width: 502px;">
																			<div id="topBlockHiddenContr"></div>
																		</td>
																	</tr>
																</table>
															</TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
											<TR>
												<TD id="shadown-y" align="center">
													<!-- ���˵�������block -->
													<TABLE width="100%" height="100%" cellpadding="0px"
														cellspacing="0px">
														<TR>
															<TD align="center">
																<table border="0" width="100%" height="502px" width="0"
																	align="center" cellpadding="0px" cellspacing="0px">
																	<tr>
																		<td style="position: relative;">
																			<div id="leftBlockHiddenContr"></div>
																		</td>
																	</tr>
																</table>
															</TD>
														</TR>
													</TABLE>
												</TD>
												<TD id="shadown-content" valign="top"><iframe
														name="mainFrame" id="mainFrame" border="0"
														frameborder="no" noresize="noresize" width="100%"
														scrolling="auto" src="<%=initsrcpage%>"
														style="height: 100%;"></iframe> <!--&nbsp;/hrm/resource/HrmResource_frm.jsp-->
												</TD>
											</TR>
										</TABLE>
									</td>
								</tr>
							</table>
						</td>
						<td width="5px"></td>
					</tr>
				</table>
			</td>
		</tr>

		<!--��-->
		<tr height="5px">
			<td>
				<div id="footer"></div>
			</td>
		</tr>
	</table>

	<!--����logo����-->
	<%
		if (logo == null || logo.equals("")) {
	%>
	<img src="/wui/theme/ecology7/page/images/logo.png" border="0"
		style="position: absolute; top: 0; left: 0;" id="logo" />
	<%
		} else {
	%>
	<img src="<%=logo%>" border="0"
		style="position: absolute; top: 0; left: 0;" id="logo" />
	<%
		}
	%>
	<!-- �汾��Ϣ -->
	<div class="versiontype"></div>
</body>
</html>

<script languange="javascript">
//��������ȣ����ݷֱ����Զ�������
var LeftBlock_Max_Width = 0;
/**
 * ��ʼ��������������ô�С
 * �Զ�ִ��
 */
function leftBlockSizeInit() {
	var clientScreenHeight = window.screen.height;
	var clientScreenWidth = window.screen.width;
	if (clientScreenWidth < 1280) {
		clientScreenWidth = 1280;
	}
    var tpLeftMenuMaxHeight = Math.round(clientScreenHeight / 2.8);
    var tpLeftMenuMaxWidth = Math.round(clientScreenWidth / 8);
    setLeftBlockSize(tpLeftMenuMaxWidth, tpLeftMenuMaxHeight);
    //alert(tpLeftMenuMaxHeight);
    LeftBlock_Max_Width = tpLeftMenuMaxWidth;
}

/**
 * ����������������ô�С
 */
function setLeftBlockSize(tpLeftMenuMaxWidth, tpLeftMenuMaxHeight) {
	//jQuery("#leftBlockTd").css("width", tpLeftMenuMaxWidth + 3);
	jQuery("#leftBlockTd").css("width", tpLeftMenuMaxWidth + 25);
	jQuery("#leftmenucontainer").css("width", tpLeftMenuMaxWidth + 25);
	jQuery("#leftBlockTopBgCenter").css("width", tpLeftMenuMaxWidth + 14);
	jQuery("#leftBlockTopBgCenter").css("background", "url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockTopBgCenter.jpg')");
	
	//td 126px
	jQuery("#leftmenu-top").css("width", tpLeftMenuMaxWidth + 3);
	jQuery("#leftmenu-top").css("height", 86);
	
	jQuery("#leftBlockHrmInfoCenter").css("width", tpLeftMenuMaxWidth - 63);
	jQuery("#leftBlockHrmInfoCenter").css("background", "url('/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/left/leftBlockHrmInfoBgCenter.png')");
	jQuery("#leftBlockHrmInfoCenter").css("background-repeat", "repeat-x");	
	
	//jQuery("#leftmenu-bottom").css("height", tpLeftMenuMaxHeight + 124 - 61);
	setMainElementHeight(27);
	
	if(jQuery.client.browser=="Explorer"){
		jQuery("#leftmenu-bottom").css("width", tpLeftMenuMaxWidth + 3);
	}else{
		jQuery("#leftmenu-bottom").css("width", tpLeftMenuMaxWidth + 1);
	}
	jQuery("#leftBlock_HrmDiv").css("height", 86);
	jQuery("#leftmenu-bottom-bottom").css("width", tpLeftMenuMaxWidth + 3);
	
	jQuery("#leftMenuBottomCenter").css("width", tpLeftMenuMaxWidth - 8);
	
	
	
	setHrmInfoDep(tpLeftMenuMaxWidth - 62);
}
/**
 * �Զ�����
 */
leftBlockSizeInit();


function  setMainElementHeight(height) {
	if(jQuery.client.browser=="Explorer"){
		jQuery("#leftmenu-bottom").css("height", height + jQuery("#drillcrumb").height() + 71);
	}else{
		jQuery("#leftmenu-bottom").css("height", height + jQuery("#drillcrumb").height() + 71);
	}
} 

/**
 * ��ʾ���������������
 */
function leftBlockContractionOrExpand(_this) {
	if (jQuery("#leftmenucontainer").css("display") == 'none') {
		jQuery("#leftmenucontainer").show();
		jQuery("#leftBlockTd").css("width", LeftBlock_Max_Width + 25);
		
		if (tmpLyTopmenu != lyClickTopmenuStatictics) {
			dymlftenu(recentlyClickTopMenuObj, false);
		}
		
		jQuery("#leftBlockHiddenContr").css("background", "");
		
		leftBlockHiddenContrFlag = 0;
	} else {
		jQuery("#leftmenucontainer").hide();
		jQuery("#leftBlockTd").css("width", 0);
		
		if (recentlyClickTopMenuObj != null && recentlyClickTopMenuObj != undefined) {
			recentlyClickTopMenuObjId = jQuery(recentlyClickTopMenuObj).attr("levelid");
			if (recentlyClickTopMenuObjId == "" || recentlyClickTopMenuObjId == undefined || recentlyClickTopMenuObjId == null) {
				recentlyClickTopMenuObjId = "-9999";
			} 
		}
		
		tmpLyTopmenu = lyClickTopmenuStatictics;
		jQuery("#leftBlockHiddenContr").css("background", "url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/leftBlockExpand.png) no-repeat");
		leftBlockHiddenContrFlag = -1;
	}
}

/**
 * ��ʾ�������ض�������
 */
function topBlockContractionOrExpand(_this) {
	if (jQuery("#mainTopBlockTr").css("display") == 'none') {
		jQuery("#mainTopBlockTr").show();
		jQuery("#topBlockHiddenContr").css("background", "");
		jQuery("#logo").show();
		jQuery(".versiontype").show();
		topBlockHiddenContrFlag = 0;
	} else {
		jQuery("#mainTopBlockTr").hide();
		jQuery("#logo").hide();
		jQuery(".versiontype").hide();
		jQuery("#topBlockHiddenContr").css("background", "url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/topBlockExpand.png) no-repeat");
		topBlockHiddenContrFlag = -1;
	}
}
/**
 * �������������hrmInfo�Ĵ�С
 */
function setHrmInfoDep(tpLeftMenuMaxWidth) {
	jQuery("#leftBlockHrmDep").css("width", tpLeftMenuMaxWidth);
	jQuery("#tdMessageState").css("left", tpLeftMenuMaxWidth - 60);
}

jQuery("#leftBlockHiddenContr").css("background", "");
jQuery("#topBlockHiddenContr").css("background", "");

/**
 * ���һ�ε�����˵���id
 * ���ڵ����˵����أ����ҵ���˶����˵�������£������á�
 */
var recentlyClickTopMenuObjId = "";
var tmpLyTopmenu = -1;

/**
 * ��¼��������״̬��0������   -1��������ʾ
 * ���ã��Ƿ������ʾ����/��ʾ���İ�ť
 */
var leftBlockHiddenContrFlag = 0;
var topBlockHiddenContrFlag = 0;
jQuery(document).ready(function() {

	//����������ذ�ť���ʱ����
	jQuery("#leftBlockHiddenContr").bind("click", function() {
		leftBlockContractionOrExpand();
	});
	
	//�����������ذ�ť���ʱ����
	jQuery("#topBlockHiddenContr").bind("click", function() {
		topBlockContractionOrExpand();
	});
	
	//����������ذ�ť
	jQuery("#leftBlockHiddenContr").hover(function() {
		if (leftBlockHiddenContrFlag != -1) {
			jQuery(this).css("background", "url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/leftBlockContraction.png) no-repeat");
		}
	}, function() {
		if (leftBlockHiddenContrFlag != -1) {
			jQuery(this).css("background", "none");
		}
	});
	
	//�����������ذ�ť
	jQuery("#topBlockHiddenContr").hover(function() {
		if (topBlockHiddenContrFlag != -1) {
			jQuery(this).css("background", "url(/wui/theme/ecology7/skins/<%=pslSkinfolder%>/page/main/topBlockContraction.png) no-repeat");
		
		}
	}, function() {
		if (topBlockHiddenContrFlag != -1) {
			jQuery(this).css("background", "none");
		}
	});
});

window.document.onkeydown = function () {
	if (window.event.ctrlKey &&window.event.shiftKey && window.event.keyCode == 13) {
		if (topBlockHiddenContrFlag == leftBlockHiddenContrFlag) {
			topBlockContractionOrExpand();
			leftBlockContractionOrExpand();
		} else if (topBlockHiddenContrFlag != -1) {
			topBlockContractionOrExpand();
		} else if (leftBlockHiddenContrFlag != -1) {
			leftBlockContractionOrExpand();
		}
	}
}

function addCookie(objName,objValue,objHours){//���cookie
	var str = objName + "=" + escape(objValue);
	if(objHours > 0){//Ϊ0ʱ���趨����ʱ�䣬������ر�ʱcookie�Զ���ʧ
		var date = new Date();
		var ms = 10*365*24*60*60*1000;
		date.setTime(date.getTime() + ms);
		str += "; expires=" + date.toGMTString();
	}
	document.cookie = str;
}

function getCookie(objName){//��ȡָ�����Ƶ�cookie��ֵ
	var arrStr = document.cookie.split("; ");
	for(var i = 0;i < arrStr.length;i ++){
		var temp = arrStr[i].split("=");
		if(temp[0] == objName) return unescape(temp[1]);
 	}
}
				
</script>
<script>   
  var con=null;
  window.onbeforeunload=function(){	
	  if(typeof(isMesasgerUnavailable) == "undefined") {
		     isMesasgerUnavailable = true; 
	  }  
	  if(!isMesasgerUnavailable){
	  	return "<%=SystemEnv.getHtmlLabelName(24985, user.getLanguage())%>";
	  }	 
	  var e=getEvent();
	  var n = e.screenX - window.screenLeft;
	  var b = n > document.documentElement.scrollWidth-20;  
	  if(b && e.clientY < 0 || e.altKey){
	  	  e.returnValue = "<%=SystemEnv.getHtmlLabelName(16628, user.getLanguage())%>
	";
		}
	}
</script>

<%
	boolean isHaveEMessager = Prop.getPropValue("Messager2", "IsUseEMessager").equalsIgnoreCase("1");
	if (isHaveEMessager)
	{

	} else
	{

		if (true)
		{
%>

<%
	}
	}
%>
