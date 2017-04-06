<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.general.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsExtend" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pm" class="weaver.page.PageCominfo" scope="page" />
<%
	int subCompanyId = Util.getIntValue(request
			.getParameter("subCompanyId"));
	int templateId = Util.getIntValue(request
			.getParameter("templateId"));
	int extendtempletid = Util.getIntValue(request
			.getParameter("extendtempletid"));
	int extandHpThemeId = Util.getIntValue(request
			.getParameter("extandHpThemeId"));
	int extandHpThemeItemId = Util.getIntValue(request
			.getParameter("extandHpThemeItemId"));

	String theme = Util.null2String(request.getParameter("theme"));
	String skin = Util.null2String(request.getParameter("skin"));

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = SystemEnv.getHtmlLabelName(23142, user
			.getLanguage())
			+ " - "
			+ SystemEnv.getHtmlLabelName(93, user.getLanguage());
	String needfav = "1";
	String needhelp = "";

	int userid = user.getUID();
	String canCustom = pm.getConfig().getString("portal.custom");
	Map cssKv = null;
	if ("ecology7".equals(theme)) {
		String projectPath = this.getServletConfig().getServletContext().getRealPath("/");
		if (projectPath.lastIndexOf("/") != (projectPath.length() - 1) && projectPath.lastIndexOf("\\") != (projectPath.length() - 1)) {
			projectPath += "/";
		}
		cssKv = parseCss(readCss(projectPath + "wui/theme/ecology7/skins/" + skin + "/page/left.css"));
	}
%>
<html>
	<head>
		<link href="/css/Weaver.css" type=text/css rel=stylesheet>
		<SCRIPT language="javascript" src="/js/weaver.js"></script>

		<style>
input {
	width: 340px
}
</style>
	</head>

	<body>
		<%@ include file="/systeminfo/TopTitle.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>

		<%
			RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage())
					+ ",javascript:checkSubmit(this),_self} ";
			RCMenuHeight += RCMenuHeightStep;

			RCMenu += "{"
					+ SystemEnv.getHtmlLabelName(1290, user.getLanguage())
					+ ",javascript:retPrePage(this),_self} ";
			RCMenuHeight += RCMenuHeightStep;
		%>

		<%@ include file="/systeminfo/RightClickMenu.jsp"%>

		<FORM style="margin: 0" name="frmMain" method="post"
			enctype="multipart/form-data" action="themeOperation.jsp">
			<input name="method" type="hidden" value="edit" />
			<input name="templateId" type="hidden" value="<%=templateId%>" />
			<input type="hidden" id="subCompanyId" name="subCompanyId"
				value="<%=subCompanyId%>" />
			<input type="hidden" name="extendtempletid"
				value="<%=extendtempletid%>" />
			<input type="hidden" name="fieldname" />



			<table width=100% height=100% border="0" cellspacing="0"
				cellpadding="0">
				<colgroup>
					<col width="10">
					<col width="">
					<col width="10">
				<tr>
					<td height="10" colspan="3"></td>
				</tr>
				<tr>
					<td></td>
					<td valign="top">

						<TABLE class="Shadow">
							<tr>
								<td valign="top">
									<TABLE class=ViewForm>
										<COLGROUP>
											<COL width="30%">
											<COL width="70%">
										<TBODY>


											<TR class=Spacing style="height: 1px;">
												<TD class=Line1 colSpan=2></TD>
											</TR>

											<TR>
												<TD COLSPAN=2>
													<%
														String templateName = "";
														String templateTitle = "";
														String isOpen = "";
														String defaultHp = "";
														boolean saved = false;
														String sql = "SELECT * FROM SystemTemplate WHERE id=" + templateId;

														rs.executeSql(sql);
														if (rs.next()) {
															templateName = rs.getString("templateName");
															templateTitle = rs.getString("templateTitle");
															isOpen = rs.getString("isOpen").equals("1") ? "1" : "0";
															defaultHp = rs.getString("defaultHp");
															String tempextendtempletid = Util.null2String(rs
																	.getString("extendtempletid"));
															String tempextendtempletvalueid = Util.null2String(rs
																	.getString("extendtempletvalueid"));

															if ("1".equals(tempextendtempletid)
																	&& !"".equals(tempextendtempletvalueid))
																saved = true;
														}

														String logoTop = "";
														String logoBottom = "";
														int isopen = 0;
														int islock = 0;

														String bodyBg = "";
														String topBgImage = "";
														String toolbarBgColor = "";
														String menuborderColor = "";

														String leftbarBgImage = "";
														String leftbarBgImageH = "";

														String leftbarborderColor = "";
														String leftbarFontColor = "";

														String topleftbarBgImage_left = "";
														String topleftbarBgImage_center = "";
														String topleftbarBgImage_right = "";

														String bottomleftbarBgImage_left = "";
														String bottomleftbarBgImage_center = "";
														String bottomleftbarBgImage_right = "";

														rsExtend.executeSql("select * from extandHpThemeItem where id="
																+ extandHpThemeItemId + " and extandHpThemeId="
																+ extandHpThemeId);

														if (rsExtend.next()) {
															extandHpThemeItemId = Util.getIntValue(
																	rsExtend.getString("id"), 0);
															extandHpThemeId = Util.getIntValue(rsExtend
																	.getString("extandHpThemeId"), 0);
															theme = Util.null2String(rsExtend.getString("theme"));
															skin = Util.null2String(rsExtend.getString("skin"));
															logoTop = Util.null2String(rsExtend.getString("logoTop"));
															
															logoBottom = Util.null2String(rsExtend.getString("logoBottom"));
															isopen = Util.getIntValue(rsExtend.getString("isopen"), 0);
															islock = Util.getIntValue(rsExtend.getString("islock"), 0);

															bodyBg = Util.null2String(rsExtend.getString("bodyBg"));
															topBgImage = Util.null2String(rsExtend.getString("topBgImage"));
															toolbarBgColor = Util.null2String(rsExtend
																	.getString("toolbarBgColor"));
															menuborderColor = Util.null2String(rsExtend
																	.getString("menuborderColor"));

															leftbarBgImage = Util.null2String(rsExtend
																	.getString("leftbarBgImage"));
															leftbarBgImageH = Util.null2String(rsExtend
																	.getString("leftbarBgImageH"));

															leftbarborderColor = Util.null2String(rsExtend
																	.getString("leftbarborderColor"));
															leftbarFontColor = Util.null2String(rsExtend
																	.getString("leftbarFontColor"));

															topleftbarBgImage_left = Util.null2String(rsExtend
																	.getString("topleftbarBgImage_left"));
															topleftbarBgImage_center = Util.null2String(rsExtend
																	.getString("topleftbarBgImage_center"));
															topleftbarBgImage_right = Util.null2String(rsExtend
																	.getString("topleftbarBgImage_right"));

															bottomleftbarBgImage_left = Util.null2String(rsExtend
																	.getString("bottomleftbarBgImage_left"));
															bottomleftbarBgImage_center = Util.null2String(rsExtend
																	.getString("bottomleftbarBgImage_center"));
															bottomleftbarBgImage_right = Util.null2String(rsExtend
																	.getString("bottomleftbarBgImage_right"));
														}
													%>
													<input type="hidden" name="extandHpThemeId"
														value="<%=extandHpThemeId%>" />
													<input type="hidden" name="extandHpThemeItemId"
														value="<%=extandHpThemeItemId%>" />
													<input type="hidden" name="theme" value="<%=theme%>" />
													<input type="hidden" name="skin" value="<%=skin%>" />

													<TABLE class=ViewForm>
														<COLGROUP>
															<COL width="30%">
															<COL width="70%">
														<tr>
															<td><%=SystemEnv.getHtmlLabelName(18151, user.getLanguage())%></td>
															<td class=Field>
																<INPUT class=InputStyle maxLength=50 id="templateName"
																	name="templateName" value="<%=templateName%>"
																	onchange="checkinput('templateName','templateNameImage')">
																<SPAN id="templateNameImage"></SPAN>
															</td>
														</tr>
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>

														<td><%=SystemEnv.getHtmlLabelName(18795, user.getLanguage())%></td>
														<td class=Field>
															<INPUT class=InputStyle maxLength=50 id="templateTitle"
																name="templateTitle" value="<%=templateTitle%>">
														</td>
														</tr>

														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>

														<%
															if ("ecology7".equals(theme)) {
																Map cssItemMap = null;
																String leftmenucontainer = "";
																cssItemMap = (Map)cssKv.get("#leftmenucontainer");
																if (cssItemMap != null) {
																	leftmenucontainer = (String)cssItemMap.get("background");
																}
																String leftmenu_bottom = "";
																cssItemMap = (Map)cssKv.get("#leftmenu-bottom");
																if (cssItemMap != null) {
																	leftmenu_bottom = (String)cssItemMap.get("background-color");
																}
																
																String drillcrumb = "";
																cssItemMap = (Map)cssKv.get("#drillcrumb");
																if (cssItemMap != null) {
																	drillcrumb = (String)cssItemMap.get("background");
																}
																
																String leftMenuTopNavDiv = "";
																cssItemMap = (Map)cssKv.get(".leftmenutopnavdiv");
																if (cssItemMap != null) {
																	leftMenuTopNavDiv = (String)cssItemMap.get("border-top");
																}
																
																String drillcrumb_border_left = "";
																cssItemMap = (Map)cssKv.get("#drillcrumb");
																if (cssItemMap != null) {
																	drillcrumb_border_left = (String)cssItemMap.get("border-left");
																}
																
																String drillcrumb_border_top = "";
																cssItemMap = (Map)cssKv.get("#drillcrumb");
																if (cssItemMap != null) {
																	drillcrumb_border_top = (String)cssItemMap.get("border-top");
																}
																String drillcrumb_border_right = "";
																cssItemMap = (Map)cssKv.get("#drillcrumb");
																if (cssItemMap != null) {
																	drillcrumb_border_right = (String)cssItemMap.get("border-right");
																}
																String drillcrumb_border_bottom = "";
																cssItemMap = (Map)cssKv.get("#drillcrumb");
																if (cssItemMap != null) {
																	drillcrumb_border_bottom = (String)cssItemMap.get("border-bottom");
																}

																String leftMenuBottomNavDiv = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavdiv");
																if (cssItemMap != null) {
																	leftMenuBottomNavDiv = (String)cssItemMap.get("background");
																}
																
																String leftMenuBottomNavDiv_border = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavdiv");
																if (cssItemMap != null) {
																	leftMenuBottomNavDiv_border = (String)cssItemMap.get("border-top");
																}
																
																String leftMenuBottomNavTbl_left = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavtbl");
																if (cssItemMap != null) {
																	leftMenuBottomNavTbl_left = (String)cssItemMap.get("border-left");
																}
																
																String leftMenuBottomNavTbl_top = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavtbl");
																if (cssItemMap != null) {
																	leftMenuBottomNavTbl_top = (String)cssItemMap.get("border-top");
																}
																
																String leftMenuBottomNavTbl_right = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavtbl");
																if (cssItemMap != null) {
																	leftMenuBottomNavTbl_right = (String)cssItemMap.get("border-right");
																}
																
																String leftMenuBottomNavTbl_bottom = "";
																cssItemMap = (Map)cssKv.get(".leftmenubottomnavtbl");
																if (cssItemMap != null) {
																	leftMenuBottomNavTbl_bottom = (String)cssItemMap.get("border-bottom");
																}
														%>
														<tr>
															<td valign="top">
																logo(278*70)
															</td>
															<td class=Field>
																<%
																	if (logoTop.equals("")) {
																%>
																<img src="images/ecology7_logo.png" width="278px"
																	height="70px" />
																<%
																	} else {
																%>
																<img src="<%=logoTop%>" width="278px" height="70px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('logoTop')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="logoTop" value="">
															</td>
														</tr>

														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td valign="top">
																���˵���ͼƬ��Ҫ����󣬷��ܿ���Ч�����������滻ԭ��ͼƬ������ǰ���ݣ�
															</td>
															<td class=Field height="500px">
																<TABLE class=ViewForm height="100%">
																	<COLGROUP>
																		<COL width="*">
																		<COL width="185px">
																	<tr>
																		<td valign="top">
																			<TABLE class=ViewForm>
																				<COLGROUP>
																					<COL width="30%">
																					<COL width="70%">
																				<tr>
																					<td valign="top">
																						����ͼƬ-��(Բ��ͼƬ10*10)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockTopBgLeft.jpg"
																							width="10px" height="10px" />
																						<br />
																						<input type="file" name="leftBlockTopBgLeft"
																							value="" csskey="leftBlockTopBgLeft">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						����ͼƬ-��(1*10)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockTopBgCenter.jpg"
																							width="10px" height="10px" />
																						<br />
																						<input type="file" name="leftBlockTopBgCenter"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						����ͼƬ-��(2*10)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockTopBgRight.jpg"
																							width="2px" height="10px" />
																						<br />
																						<input type="file" name="leftBlockTopBgRight"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						��౳����ɫ
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="leftmenucontainer"
																							value="<%=leftmenucontainer %>" onchange="leftPriview(this.value, '#leftmenucontainer', 'background');">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						ͷ�����򱳾�ͼƬ-��(60*87)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockHrmInfoBgLeft.png"
																							width="60px" />
																						<br />
																						<input type="file" name="leftBlockHrmInfoBgLeft"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						ͷ�����򱳾�ͼƬ-��(1*87)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockHrmInfoBgCenter.png"
																							width="10px" height="87px" />
																						<br />
																						<input type="file" name="leftBlockHrmInfoBgCenter"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						ͷ�����򱳾�ͼƬ-��(6*87)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftBlockHrmInfoBgRight.png"
																							width="6px" height="87px" />
																						<br />
																						<input type="file" name="leftBlockHrmInfoBgRight"
																							value="">
																					</td>
																				</tr>
																				
																				
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵�������ɫ(6*87)
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="leftmenu_bottom" value="<%=leftmenu_bottom %>" onchange="leftPriview(this.value, '#leftmenu-bottom', 'background-color');">
																					</td>
																				</tr>
																				
																				
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ�����ͼƬ-��(5*7)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuBottomLeft.png"
																							width="5px" />
																						<br />
																						<input type="file" name="leftMenuBottomLeft"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ�����ͼƬ-��(1*7)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuBottomCenter.png"
																							width="10px" height="7px" />
																						<br />
																						<input type="file" name="leftMenuBottomCenter"
																							value="">
																					</td>
																				</tr>
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ�����ͼƬ-��(6*7)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuBottomRight.png"
																							width="6px" height="7px" />
																						<br />
																						<input type="file" name="leftMenuBottomRight"
																							value="">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵���������������ɫ
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="drillcrumb" value="<%=drillcrumb %>" onchange="leftPriview(this.value, '#drillcrumb', 'background');">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵����������ϱ߿���ɫ(��)
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="leftMenuTopNavDiv" value="<%=leftMenuTopNavDiv %>" onchange="leftPriview(this.value, '.leftmenutopnavdiv', 'border-top');">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵����������߿���ɫ
																					</td>
																					<td class=Field valign="top">
																						��<input type="text" name="drillcrumb_border_left" value="<%=drillcrumb_border_left %>" size="6" onchange="leftPriview(this.value, '#drillcrumb', 'border-left');">
																						<br>
																						�ϣ�<input type="text" name="drillcrumb_border_top" value="<%=drillcrumb_border_top %>" size="6" onchange="leftPriview(this.value, '#drillcrumb', 'border-top');">
																						<br>
																						�ң�<input type="text" name="drillcrumb_border_right" value="<%=drillcrumb_border_right %>" size="6" onchange="leftPriview(this.value, '#drillcrumb', 'border-right');">
																						<br>
																						�£�<input type="text" name="drillcrumb_border_bottom" value="<%=drillcrumb_border_bottom %>" size="6" onchange="leftPriview(this.value, '#drillcrumb', 'border-bottom');">
																					</td>
																				</tr>
																				
																				
																				
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ�����������ɫ
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="leftMenuBottomNavDiv" value="<%=leftMenuBottomNavDiv %>" onchange="leftPriview(this.value, '.leftmenubottomnavdiv', 'background');">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ������ϱ߿���ɫ(��)
																					</td>
																					<td class=Field valign="top">
																						<input type="text" name="leftMenuBottomNavDiv_border" value="<%=leftMenuBottomNavDiv_border %>" onchange="leftPriview(this.value, '.leftmenubottomnavdiv', 'border-top');">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵��ײ������߿���ɫ
																					</td>
																					<td class=Field valign="top">
																						��<input type="text" name="leftMenuBottomNavTbl_left" value="<%=leftMenuBottomNavTbl_left %>" size="6" onchange="leftPriview(this.value, '.leftmenubottomnavtbl', 'border-left');">
																						<br>
																						�ϣ�<input type="text" name="leftMenuBottomNavTbl_top" value="<%=leftMenuBottomNavTbl_top %>" size="6" onchange="leftPriview(this.value, '.leftmenubottomnavtbl', 'border-top');">
																						<br>
																						�ң�<input type="text" name="leftMenuBottomNavTbl_right" value="<%=leftMenuBottomNavTbl_right %>" size="6" onchange="leftPriview(this.value, '.leftmenubottomnavtbl', 'border-right');">
																						<br>
																						�£�<input type="text" name="leftMenuBottomNavTbl_bottom" value="<%=leftMenuBottomNavTbl_bottom %>" size="6" onchange="leftPriview(this.value, '.leftmenubottomnavtbl', 'border-bottom');">
																					</td>
																				</tr>
																				
																				
																				
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵����ͼƬ-��(11*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuItemLeft.png"
																							width="11px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemLeft"
																							value="">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵����ͼƬ-��(1*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuItemCenter.png"
																							width="30px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemCenter"
																							value="">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵����ͼƬ-��(5*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuItemRight.png"
																							width="11px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemRight"
																							value="">
																					</td>
																				</tr>
																				
																				
																				
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵���ѡ�б���ͼƬ-��(11*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuItemNavLeft.png"
																							width="11px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemNavLeft"
																							value="">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵���ѡ�б���ͼƬ-��(1*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuItemNavCenter.png"
																							width="30px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemNavCenter"
																							value="">
																					</td>
																				</tr>
																				
																				<TR style="height: 1px;">
																					<TD class=Line colSpan=2></TD>
																				</TR>
																				<tr>
																					<td valign="top">
																						�˵���ѡ�б���ͼƬ-��(5*111)
																					</td>
																					<td class=Field valign="top">
																						<img
																							src="/wui/theme/ecology7/skins/<%=skin%>/page/left/leftMenuNavRight.png"
																							width="11px" height="111px" />
																						<br />
																						<input type="file" name="leftMenuItemNavRight"
																							value="">
																					</td>
																				</tr>
																			</table>	
																		</td>
																		<td class=Field valign="top">
																			<div style="height:450px;position:relative;" id="priviewDiv">
																			<iframe name="priview" id="priviewIframe" id="priview" border="0"
																				frameborder="no" noresize="noresize" width="185px"
																				height="500px" scrolling="no"
																				src="/wui/theme/ecology7/page/skinSetting/skinSettingPriview.jsp?theme=<%=theme%>&skin=<%=skin%>"
																				style="height: 100%;"></iframe>
																			</div>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<%
															} else if ("ecologyBasic".equals(theme)) {
														%>
														<tr>
															<td valign="top">
																logo��(198*43)
															</td>
															<td class=Field>
																<%
																	if (logoTop.equals("")) {
																%>
																<img src="images/ecologyBasic_logo_up.png" width="198px"
																	height="43px" />
																<%
																	} else {
																%>
																<img src="<%=logoTop%>" width="198px" height="43px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('logoTop')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="logoTop" value="">
															</td>
														</tr>
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td valign="top">
																logo��(198*28)
															</td>
															<td class=Field>
																<%
																	if (logoBottom.equals("")) {
																%>
																<img src="images/ecologyBasic_logo_down.png"
																	width="198px" height="28px" />
																<%
																	} else {
																%>
																<img src="<%=logoBottom%>" width="198px" height="28px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('logoBottom')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="logoBottom" value="">
															</td>
														</tr>

														<!-- ������������ -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td valign="top">
																ҳ�汳��ͼ(2000*1)
															</td>
															<td class=Field>
																<%
																	if (bodyBg.equals("")) {
																%>
																<img src="images/bodyBg.png" width="200px" height="1px" />
																<%
																	} else {
																%>
																<img src="<%=bodyBg%>" width="200px" height="1px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('bodyBg')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="bodyBg" value="">
															</td>
														</tr>


														<!-- ��������ͼ(2000*7) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>

														<tr>
															<td><%=SystemEnv.getHtmlLabelName(18153, user
										.getLanguage())%>(2000*7)
															</td>
															<td class=Field>
																<%
																	if (topBgImage.equals("") || topBgImage.equals("0")) {
																%>
																<img src="images/headBg.jpg" width="200px" height="7px" />
																<%
																	} else {
																%>
																<img src="<%=topBgImage%>" width="200px" height="7px">
																<br />
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('topBgImage')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<br />
																<%
																	}
																%>
																<br />
																<input class="inputstyle" type="file" name="topBgImage"
																	value="">

															</td>
														</tr>

														<!-- ��ݰ�ť����ͼ(1*28) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>

														<tr>
															<td>
																��ݰ�ť����ͼ(1*28)
															</td>
															<td class=Field>
																<%
																	if (toolbarBgColor.equals("") || toolbarBgColor.equals("0")) {
																%>
																<img src="images/toolbarBg.png" width="200px"
																	height="28px" />
																<%
																	} else {
																%>
																<img src="<%=toolbarBgColor%>" width="200px"
																	height="28px">
																<br />
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('toolbarBgColor')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<br />
																<%
																	}
																%>
																<br />
																<input class="inputstyle" type="file"
																	name="toolbarBgColor" value="">

															</td>
														</tr>

														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵���߿򱳾�ɫ
															</td>
															<td class=Field>
																<table>
																	<tr>
																		<td rowspan="2">
																			<input type="text" class="InputStyle" maxlength="50"
																				id="menuborderColor" name="menuborderColor"
																				value="<%=menuborderColor.equals("") ? "#b1d4d9"
						: menuborderColor%>" />
																		</td>
																		<td>
																			<img src="/images/ColorPicker.gif"
																				onclick="javascript:getColor('menuborderColor');"
																				class="colorPicker">
																		</td>
																	</tr>
																	<tr>
																		<td id="menuborderColorTD"
																			style='height: 4px; background-color: <%=menuborderColor.equals("") ? "#b1d4d9"
						: menuborderColor%>;'></td>
																	</tr>
																</table>
															</td>
														</tr>

														<!-- ��˵���ǰ��ʾ���౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵���ǰ��ʾ���౳��ͼ(��)(5*28)
															</td>
															<td class=Field>
																<%
																	if (topleftbarBgImage_left.equals("")) {
																%>
																<img src="images/topFolde_leftr.png" width="5px"
																	height="28px" />
																<%
																	} else {
																%>
																<img src="<%=topleftbarBgImage_left%>" width="5px"
																	height="28px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('topleftbarBgImage_left')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="topleftbarBgImage_left"
																	value="">
															</td>
														</tr>

														<!-- ��˵���ǰ��ʾ���౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵���ǰ��ʾ���౳��ͼ(��)(1*28)
															</td>
															<td class=Field>
																<%
																	if (topleftbarBgImage_center.equals("")) {
																%>
																<img src="images/topFolde_center.png" width="200px"
																	height="28px" />
																<%
																	} else {
																%>
																<img src="<%=topleftbarBgImage_center%>" width="200px"
																	height="28px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('topleftbarBgImage_center')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="topleftbarBgImage_center"
																	value="">
															</td>
														</tr>

														<!-- ��˵���ǰ��ʾ���౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵���ǰ��ʾ���౳��ͼ(��)(5*28)
															</td>
															<td class=Field>
																<%
																	if (topleftbarBgImage_right.equals("")) {
																%>
																<img src="images/topFolde_right.png" width="5px"
																	height="28px" />
																<%
																	} else {
																%>
																<img src="<%=topleftbarBgImage_right%>" width="5px"
																	height="28px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('topleftbarBgImage_right')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="topleftbarBgImage_right"
																	value="">
															</td>
														</tr>

														<!-- ��˵����౳��ͼ -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td><%=SystemEnv.getHtmlLabelName(18157, user
										.getLanguage())%>(1*26)
															</td>
															<td class=Field>
																<%
																	if (leftbarBgImage.equals("")) {
																%>
																<img src="images/leftbarBgImage.png" width="200px"
																	height="26px" />
																<%
																	} else {
																%>
																<img src="<%=leftbarBgImage%>" width="200px"
																	height="26px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('leftbarBgImage')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="leftbarBgImage" value="">
															</td>
														</tr>

														<!-- ��˵����౳��ͼ�������� -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td><%=SystemEnv.getHtmlLabelName(18157, user
										.getLanguage())%>(<%=SystemEnv.getHtmlLabelName(18158, user
										.getLanguage())%>)(1*26)
															</td>
															<td class=Field>
																<%
																	if (leftbarBgImageH.equals("")) {
																%>
																<img src="images/leftbarBgImageH.png" width="200px"
																	height="26px" />
																<%
																	} else {
																%>
																<img src="<%=leftbarBgImageH%>" width="200px"
																	height="26px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('leftbarBgImageH')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="leftbarBgImageH" value="">
															</td>
														</tr>


														<!-- ������������ɫ -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td><%=SystemEnv.getHtmlLabelName(18159, user
										.getLanguage())%></td>
															<td class=Field>
																<table>
																	<tr>
																		<td rowspan="2">
																			<input type="text" class="InputStyle" maxlength="50"
																				id="leftbarFontColor" name="leftbarFontColor"
																				value="<%=leftbarFontColor.equals("") ? "#000"
						: leftbarFontColor%>" />
																		</td>
																		<td>
																			<img src="/images/ColorPicker.gif"
																				onclick="javascript:getColor('leftbarFontColor');"
																				class="colorPicker">
																		</td>
																	</tr>
																	<tr>
																		<td id="leftbarFontColorTD"
																			style='height: 4px; background-color: <%=leftbarFontColor.equals("") ? "#000"
						: leftbarFontColor%>;'></td>
																	</tr>
																</table>
															</td>
														</tr>

														<!-- ���˵�����߿���ɫ -->
														<TR class=Spacing style="height: 1px;">
															<TD class=Line1 colSpan=2></TD>
														</TR>
														<tr>
															<td>
																���˵�����߿�ɫ
															</td>
															<td class=Field>
																<table>
																	<tr>
																		<td rowspan="2">
																			<input type="text" class="InputStyle" maxlength="50"
																				id="leftbarborderColor" name="leftbarborderColor"
																				value="<%=leftbarborderColor.equals("") ? "#85b9c0"
						: leftbarborderColor%>" />
																		</td>
																		<td>
																			<img src="/images/ColorPicker.gif"
																				onclick="javascript:getColor('leftbarborderColor');"
																				class="colorPicker">
																		</td>
																	</tr>
																	<tr>
																		<td id="leftbarborderColorTD"
																			style='height: 4px; background-color: <%=leftbarborderColor.equals("") ? "#85b9c0"
						: leftbarborderColor%>;'></td>
																	</tr>
																</table>
															</td>
														</tr>



														<!-- ��˵���ǰ��ʾ���౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵��ײ����౳��ͼ(��)(65*27)
															</td>
															<td class=Field>
																<%
																	if (bottomleftbarBgImage_left.equals("")) {
																%>
																<img src="images/thumbBoxBg_left.png" width="65px"
																	height="27px" />
																<%
																	} else {
																%>
																<img src="<%=bottomleftbarBgImage_left%>" width="65px"
																	height="28px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('bottomleftbarBgImage_left')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="bottomleftbarBgImage_left"
																	value="">
															</td>
														</tr>

														<!-- ��˵��ײ����౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵��ײ����౳��ͼ(��)(1*27)
															</td>
															<td class=Field>
																<%
																	if (bottomleftbarBgImage_center.equals("")) {
																%>
																<img src="images/thumbBoxBg_center.png" width="200px"
																	height="27px" />
																<%
																	} else {
																%>
																<img src="<%=bottomleftbarBgImage_center%>"
																	width="200px" height="27px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('bottomleftbarBgImage_center')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="bottomleftbarBgImage_center"
																	value="">
															</td>
														</tr>

														<!-- ��˵��ײ����౳��ͼ(��) -->
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>
														<tr>
															<td>
																��˵��ײ����౳��ͼ(��)(5*27)
															</td>
															<td class=Field>
																<%
																	if (bottomleftbarBgImage_right.equals("")) {
																%>
																<img src="images/thumbBoxBg_right.png" width="5px"
																	height="27px" />
																<%
																	} else {
																%>
																<img src="<%=bottomleftbarBgImage_right%>" width="5px"
																	height="27px">
																<br>
																<button type="button" class="btnDelete" accesskey="D"
																	onclick="ondelpic('bottomleftbarBgImage_right')">
																	<u>D</u>-<%=SystemEnv
									.getHtmlLabelName(91, user.getLanguage())%></button>
																<%
																	}
																%>
																<br />
																<input type="file" name="bottomleftbarBgImage_right"
																	value="">
															</td>
														</tr>

														<%
															}
														%>
														<TR style="height: 1px;">
															<TD class=Line colSpan=2></TD>
														</TR>

													</TABLE>

												</TD>
											</TR>
									</TABLE>

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

	</body>
</html>

<script type="text/javascript">

$(document).ready(function () {
	$("input[type=file]").change(function() {
		//leftPriviewImg($(this).attr("csskey"));
		//alert($(this).val());
		//alert("url(" + $(this).val() + ") 0 0 no-repeat!important");
		//leftPriview($(this).attr("csskey"), "background", "url(" + $(this).val() + ") 0 0 no-repeat!important");
	});
});

function leftPriview(cssValue, className, cssKey) {
	addCssByStyle(className + "{" + cssKey + ":" + cssValue + "!important;}", document.getElementById("priviewIframe").contentWindow.document);
}

function leftPriviewImg(cssKey) {
	//alert(cssKey);
}

function addCssByStyle(cssString, document){
	var doc=document;
	var style=doc.createElement("style");
	style.setAttribute("type", "text/css");

	if(style.styleSheet){// IE
		style.styleSheet.cssText = cssString;
	} else {// w3c
		var cssText = doc.createTextNode(cssString);
		style.appendChild(cssText);
	}

	var heads = doc.getElementsByTagName("head");
	if(heads.length) {
		heads[0].appendChild(style);
	} else {
		doc.documentElement.appendChild(style);
	}
}
</script>

<script language="javascript">
<%
if (theme.equals("ecology7")) {
%>
window.onscroll = function () {
};

<%}%>

function getColor(o) {
	var dialogObject = new Object() ;
	var colorValue = "";
	colorValue = window.showModalDialog("/systeminfo/template/ColorPicker.jsp", dialogObject, "dialogWidth:330px; dialogHeight:300px; center:yes; help:no; resizable:no; status:no") ;
	document.getElementById(o).value = (colorValue=="") ? "" : colorValue ;
	document.getElementById(o+"TD").style.backgroundColor = colorValue;
}

function chkExtendClick(obj,url){
	if(!obj.checked){
		window.location=url;	
	}
}


function checkSubmit(obj){
	if(check_form($G("frmMain"), "templateName")){
		obj.disabled=true;
		$G("frmMain").submit();	
	}
}

function retPrePage(obj){
	document.location.href = "setting.jsp?templateId=<%=templateId%>&subCompanyId=<%=subCompanyId%>&extendtempletid=<%=extendtempletid%>";
}

function del(obj){
	if(<%=isOpen%>=="1"){
		alert("<%=SystemEnv.getHtmlLabelName(18970, user.getLanguage())%>");
		return false;
	}else{
		if(isdel()){
			document.getElementById("method").value = "delete";
			obj.disabled=true;
			document.frmMain.submit();		
		}
	}
}

function preview(){
	if(<%=!saved%>)
		alert("<%=SystemEnv.getHtmlLabelName(20822, user.getLanguage())%>")
	else
		openFullWindowForXtable("index.jsp?from=preview&userSubcompanyId=<%=subCompanyId%>&templateId=<%=templateId%>&extendtempletid=<%=extendtempletid%>")
}
function ondelpic(fieldname){	
	$G("method").value = "delpic";
	$G("fieldname").value = fieldname;
	$G("frmMain").submit();	
}

</script>

<%!

public Map parseCss(String cssString) {
	Map result = new HashMap();
	
	if (cssString == null || "".equals(cssString)) {
		return result;
	}
	//ɾ��css�е�ע��(/*...*/)
	cssString = java.util.regex.Pattern.compile("/\\*[^(\\*/)]+\\*/", java.util.regex.Pattern.CASE_INSENSITIVE).matcher(cssString).replaceAll("");
	//ƥ��css�� (.class|#id { key:value})
	java.util.regex.Matcher matcher = java.util.regex.Pattern.compile("[^{^}]*\\{[^{^}]*\\}", java.util.regex.Pattern.CASE_INSENSITIVE).matcher(cssString);
	while (matcher.find()) {
		parseCssItem(result, matcher.group());
	}
	return result;
}

public void parseCssItem(Map classKv, String cssBlockString) {
	if (cssBlockString == null || "".equals(cssBlockString)) {
		return;
	}
	//class����
	String className = "";
	//class����
	String classContent = "";
	//���ݿ�ʼ�±�
	int braceIndex = cssBlockString.indexOf("{");
	//���ݽ����±�
	int braceIndexEnd = cssBlockString.indexOf("}");
	
	if (braceIndex != -1 && braceIndexEnd != -1) {
		className = cssBlockString.substring(0, braceIndex);
		
		if (braceIndexEnd > braceIndex+1) {
			classContent = cssBlockString.substring(braceIndex+1, braceIndexEnd);
		}
		
		String[] classItems = null;
		if (!"".equals(classContent)) {
			classContent = classContent.trim();
			classItems = classContent.split(";");
		}
		if (classItems != null && classItems.length > 0) {
			for (int i=0; i<classItems.length; i++) {
				String classItem = classItems[i];
				String[] cssItem = classItem.split(":");
				String cssName = "";
				String cssValue = "";
				if (cssItem != null && cssItem.length > 0) {
					cssName = cssItem[0];
					cssValue = cssItem[1];
					if (cssName != null && !"".equals(cssName)) {
						Map tempCssKv = (Map)classKv.get(className.trim().toLowerCase());
						if (tempCssKv != null) {
							tempCssKv.put(cssName.trim().toLowerCase(), cssValue.trim().toLowerCase().replace("!important", ""));
						} else {
							Map result = new HashMap();
							result.put(cssName.trim().toLowerCase(), cssValue.trim().toLowerCase().replace("!important", ""));	
							classKv.put(className.trim().toLowerCase(), result);
						}						
						
					}
				}
			}
		}
	}
}

/**
 * ��ȡcss�ļ�����Ϊ�ַ�������
 * @param path css�ļ���ַ
 * @return css�ַ���
 */
public String readCss(String path) {
	String result = "";
	if (path == null || "".equals(path)) {
		return result;
	}
	
	File cssfile = new File(path);
	//������Ϊ�ļ�
	if (!cssfile.exists() || !cssfile.isFile() ) {
		return result;
	}
	
	BufferedReader br = null;
	StringBuffer cssString = new StringBuffer();
	try {
		br = new BufferedReader(new FileReader(path));
		String cssLine = null;
		while (br.ready() && (cssLine = br.readLine()) != null) {
			cssString.append(cssLine);
			//cssString.append("\r\n");
		}
		br.close();
		br = null;
		
		result = cssString.toString();
	} catch (Exception e) {
		if (br != null) {
			try {
				br.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
		e.printStackTrace();
	}
	return result;
}
%>