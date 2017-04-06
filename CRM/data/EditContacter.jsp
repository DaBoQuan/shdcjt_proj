<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="weaver.general.Util"%>

<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetC" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetFF" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="LanguageComInfo"
	class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="ContacterTitleComInfo"
	class="weaver.crm.Maint.ContacterTitleComInfo" scope="page" />
<jsp:useBean id="RecordSetShare" class="weaver.conn.RecordSet"
	scope="page" />
<jsp:useBean id="ResourceComInfo"
	class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CheckUserRight"
	class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo"
	scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />
<%
	String flag = Util.null2String(request.getParameter("flag"));
	String ContacterID = Util.null2String(request.getParameter("ContacterID"));
	String log = Util.null2String(request.getParameter("log"));
	RecordSet.executeProc("CRM_CustomerContacter_SByID", ContacterID);
	if (RecordSet.getCounts() <= 0) {
		response.sendRedirect("/CRM/data/EditContacter.jsp?ContacterID="
				+ ContacterID + "&flag=true");
		return;
	}
	RecordSet.first();
	String CustomerID = RecordSet.getString(2);
	String photoid = Util.null2String(RecordSet.getString("contacterimageid"));

	RecordSetC.executeProc("CRM_CustomerInfo_SelectByID", CustomerID);
	if (RecordSetC.getCounts() <= 0) {
		response.sendRedirect("/CRM/data/EditContacter.jsp?ContacterID="+ ContacterID + "&flag=true");
		return;
	}
	RecordSetC.first();

	boolean hasFF = true;
	RecordSetFF.executeProc("Base_FreeField_Select", "c2");
	if (RecordSetFF.getCounts() <= 0)
		hasFF = false;
	else
		RecordSetFF.first();

	/*Ȩ���жϣ���Begin*/

	String useridcheck = "" + user.getUID();
	String customerDepartment = "" + RecordSetC.getString("department");
	boolean canedit = false;
	boolean isCustomerSelf = false;

	//String ViewSql = "select * from CrmShareDetail where crmid="
	//		+ CustomerID + " and usertype=1 and userid="
	//		+ user.getUID();

	//RecordSetV.executeSql(ViewSql);

	//if (RecordSetV.next()) {
	//	if (RecordSetV.getString("sharelevel").equals("2")
	//	|| RecordSetV.getString("sharelevel").equals("3")
	//	|| RecordSetV.getString("sharelevel").equals("4")) {
	//		canedit = true;
	//	}
	//}

int sharelevel = CrmShareBase.getRightLevelForCRM(""+user.getUID(),CustomerID);
if(sharelevel>1) canedit = true;

	if (user.getLogintype().equals("2")
			&& CustomerID.equals(useridcheck)) {
		isCustomerSelf = true;
	}

	if (useridcheck.equals(RecordSetC.getString("agent"))) {
		canedit = true;
	}

	if (RecordSetC.getInt("status") == 7
			|| RecordSetC.getInt("status") == 8) {
		canedit = false;
	}

	/*Ȩ���жϣ���End*/

	if (!canedit && !isCustomerSelf) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
%>


<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<SCRIPT language="javascript" src="../../js/weaver.js"></script>
	</HEAD>
	<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = SystemEnv.getHtmlLabelName(93, user
			.getLanguage())
			+ SystemEnv.getHtmlLabelName(572, user.getLanguage())
			+ " - "
			+ SystemEnv.getHtmlLabelName(136, user.getLanguage())
			+ ":<a href='/CRM/data/ViewCustomer.jsp?log="
			+ log
			+ "&CustomerID="
			+ RecordSetC.getString("id")
			+ "'>"
			+ Util.toScreen(RecordSetC.getString("name"), user
			.getLanguage()) + "</a>";
	String needfav = "1";
	String needhelp = "";
	%>
	<body>
		<%@ include file="/systeminfo/TopTitle.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
	<% if(flag.equals("no")) {%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getHtmlLabelName(21575,user.getLanguage())%>
</font>
</DIV>
<%}%>
<FORM id=weaver name="weaver" action="/CRM/data/ContacterOperation.jsp" method=post onsubmit='return check_form(this,"Title,FirstName,JobTitle,Manager")'
	enctype="multipart/form-data">
<input type="hidden" name="method" value="edit">
<input type="hidden" name="log" value="<%=log%>">
<input type="hidden" name="ContacterID" value="<%=ContacterID%>">
<DIV style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(this),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(589,user.getLanguage())+",javascript:document.weaver.reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<BUTTON class=btnReset accessKey=R  id=myfun2  type=reset><U>R</U>-<%=SystemEnv.getHtmlLabelName(589,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:doCancel(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<BUTTON class=Btn accessKey=C  id=myfun3  onclick='doCancel()'><U>C</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDel(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<BUTTON type="button" class=BtnDelete id=Delete accessKey=D name=button1 onclick="doDel()"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
</DIV>
	<%@ include file="/systeminfo/RightClickMenu.jsp"%>
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
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
<TABLE class=ViewForm width="100%">
	<TBODY>
		<TABLE class=ViewForm>
			<COLGROUP>
				<COL width="60%">
				<COL width=10>
				<COL width="39%">
			<TBODY>
				<TR>
					<TD vAlign=top>
						<TABLE width="100%">
							<TABLE class=ViewForm>
								<COLGROUP>
									<COL width="20%">
									<COL width="80%">
								<TBODY>
									<TR class=Title>
										<TH colSpan=2>
											<%=SystemEnv.getHtmlLabelName(61, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(87, user.getLanguage())%>
									</TH>
								</TR>
								<TR class=Spacing   style="height: 1px">
									<TD class=Line1 colSpan=2></TD>
								</TR>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(462, user.getLanguage())%>
									</TD>
									<TD class=Field>
										
										<INPUT class="wuiBrowser" _required="yes" _displayText="<%="".equals(Util.toScreen(ContacterTitleComInfo.getContacterTitlename(RecordSet.getString("title")), user.getLanguage()))?"<IMG src='/images/BacoError.gif' align=absMiddle>":Util.toScreen(ContacterTitleComInfo.getContacterTitlename(RecordSet.getString("title")), user.getLanguage())%> " _url="/systeminfo/BrowserMain.jsp?url=/CRM/Maint/ContacterTitleBrowser.jsp" type=hidden name=Title
											value="<%=Util.toScreenToEdit(RecordSet.getString("title"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(413, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=50 size=14
											name="FirstName"
											onchange='checkinput("FirstName","FirstNameimage")'
											value="<%=Util.toScreenToEdit(RecordSet.getString("firstname"),user.getLanguage())%>">
										<SPAN id=FirstNameimage><%="".equals(Util.toScreenToEdit(RecordSet.getString("firstname"),user.getLanguage()))?"<IMG src=\"/images/BacoError.gif\" align=absMiddle>":"" %></SPAN>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(475, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=50 size=14
											name="LastName"
											value="<%=Util.toScreenToEdit(RecordSet.getString("lastName"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(640, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="JobTitle"
											onchange='checkinput("JobTitle","JobTitleimage")'
											value="<%=Util.toScreenToEdit(RecordSet.getString("jobtitle"), user.getLanguage())%>">
										<SPAN id=JobTitleimage><%="".equals(Util.toScreenToEdit(RecordSet.getString("jobtitle"),user.getLanguage()))?"<IMG src=\"/images/BacoError.gif\" align=absMiddle>":"" %></SPAN>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(477, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=150 size=30
											name="CEmail" onblur="mailValid()"
											value="<%=Util.toScreenToEdit(RecordSet.getString("email"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(420, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(421, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=20 size=30
											name="PhoneOffice"
											value="<%=Util.toScreenToEdit(RecordSet.getString("phoneoffice"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(619, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(421, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=20 size=30
											name="PhoneHome"
											value="<%=Util.toScreenToEdit(RecordSet.getString("phonehome"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(620, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=20 size=30
											name="Mobile"
											value="<%=Util.toScreenToEdit(RecordSet.getString("mobilephone"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(494, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=20 size=30
											name="CFax"
											value="<%=Util.toScreenToEdit(RecordSet.getString("fax"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>

								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(6066, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="interest"
											value="<%=Util.toScreenToEdit(RecordSet.getString("interest"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(6067, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="hobby"
											value="<%=Util.toScreenToEdit(RecordSet.getString("hobby"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(572, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(596, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="managerstr"
											value="<%=Util.toScreenToEdit(RecordSet.getString("managerstr"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(442, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(460, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="subordinate"
											value="<%=Util.toScreenToEdit(RecordSet.getString("subordinate"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(6068, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="strongsuit"
											value="<%=Util.toScreenToEdit(RecordSet.getString("strongsuit"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%--<TR>--%>
								<%--<TD><%=SystemEnv.getHtmlLabelName(671,user.getLanguage())%></TD>--%>
								<%--  <TD class=Field><INPUT class=InputStyle maxLength=3 size=5 name="age" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("age")' value="<%=Util.toScreenToEdit(RecordSet.getString("age"),user.getLanguage())%>"></TD>--%>
								<%--</TR><tr><td class=Line colspan=2></td></tr>--%>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1884, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<button type="button" class=Calendar id=selectbirthday
											onClick="getbirthday()"></button>
										<span id=birthdayspan><%=Util.toScreenToEdit(RecordSet.getString("birthday"), user.getLanguage())%> </span>
										<INPUT type="hidden" class=InputStyle
											name="birthday"
											value="<%=Util.toScreenToEdit(RecordSet.getString("birthday"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(17534, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<%=SystemEnv.getHtmlLabelName(17548, user.getLanguage())%>
										<INPUT class=InputStyle maxLength=2 size=5
											name="birthdaynotifydays"
											onKeyPress="ItemCount_KeyPress()"
											onBlur='checknumber("birthdaynotifydays")'
											value="<%=Util.toScreenToEdit(RecordSet.getString("birthdaynotifydays"), user.getLanguage())%>">
										<%=SystemEnv.getHtmlLabelName(1925, user.getLanguage())%>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1967, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="home"
											value="<%=Util.toScreenToEdit(RecordSet.getString("home"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1518, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="school"
											value="<%=Util.toScreenToEdit(RecordSet.getString("school"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(803, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="speciality"
											value="<%=Util.toScreenToEdit(RecordSet.getString("speciality"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1840, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="nativeplace"
											value="<%=Util.toScreenToEdit(RecordSet.getString("nativeplace"),user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1887, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="IDCard" onKeyPress="ItemCount_KeyPress()"
										onBlur='checknumber("IDCard")'
											value="<%=Util.toScreenToEdit(RecordSet.getString("IDCard"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(812, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<TEXTAREA class=InputStyle NAME=experience ROWS=3
											STYLE="width:60%">
				<%=Util.toScreenToEdit(RecordSet.getString("experience"),user.getLanguage())%>
										</TEXTAREA>
																</TD>
															</TR>
															<tr  style="height: 1px">
																<td class=Line colspan=2></td>
															</tr>
	
															<TR>
																<TD>
																	<%=SystemEnv.getHtmlLabelName(231, user.getLanguage())%>
									</TD>
									<TD class=Field>
									
										<INPUT class="wuiBrowser" _required="yes" _displayText="<%=Util.toScreen(LanguageComInfo.getLanguagename(RecordSet.getString("language")), user.getLanguage())%>" _url="/systeminfo/BrowserMain.jsp?url=/systeminfo/language/LanguageBrowser.jsp" type=hidden name="Language"
											value="<%=Util.toScreenToEdit(RecordSet.getString("language"), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
	if (!user.getLogintype().equals("2")) {
	%>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(572, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(144, user.getLanguage())%>
									</TD>
									<TD class=Field>

										<INPUT class=wuiBrowser _displayTemplate="<A href='/hrm/resource/HrmResource.jsp?id=#b{id}'>#b{name}</A>" _displayText="<a href='/hrm/resource/HrmResource.jsp?id=<%=RecordSet.getString("manager")%>'><%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("manager")), user.getLanguage())%> </a>" _required="yes" _url="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" type=hidden name=Manager
											value=<%=Util.toScreenToEdit(RecordSet.getString("manager"),user.getLanguage())%>>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
	} else {
	%>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(572, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(144, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<span id=manageridspan></span>
										<INPUT class=InputStyle type=hidden name=Manager
											value=<%=Util.toScreenToEdit(RecordSet.getString("manager"),user.getLanguage())%>>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
	}
	%>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(1262, user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT type=checkbox name="Main" value="1"
											<%if(RecordSet.getString("main").equals("1")){%>
											checked disabled <%}%>>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<!--      <TR>
	<TD><%=SystemEnv.getHtmlLabelName(74, user.getLanguage())%></TD>
	<TD class=Field><INPUT class=InputStyle maxLength=5 size=5 name="Photo" value="<%=RecordSet.getString("picid")%>"></TD>
	</TR><tr><td class=Line colspan=2></td></tr>
	-->
												
														</TBODY>
													</TABLE>
	
													<TABLE class=ViewForm>
														<COLGROUP>
															<COL width="10%">
															<COL width="90%">
														<TBODY>
															<TR class=Title>
																<TH colSpan=2>
																	<%=SystemEnv.getHtmlLabelName(570, user.getLanguage())%>
									</TH>
								</TR>
								<TR class=Spacing  style="height: 1px">
									<TD class=Line1 colSpan=2></TD>
								</TR>
								<%
			if (hasFF) {
			for (int i = 1; i <= 5; i++) {
				if (RecordSetFF.getString(i * 2 + 1).equals("1")) {
	%>
								<TR>
									<TD>
										<%=Util.toScreen(RecordSetFF.getString(i * 2),user.getLanguage())%>
									</TD>
									<TD class=Field>
										<BUTTON class=Calendar onclick="getCrmDate(<%=i%>)"></BUTTON>
										<SPAN id=datespan<%=i%>><%=RecordSet.getString("datefield" + i)%>
										</SPAN>
										<input type="hidden" name="dff0<%=i%>"
											id="dff0<%=i%>"
											value="<%=RecordSet.getString("datefield" + i)%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
			}
			}
			for (int i = 1; i <= 5; i++) {
				if (RecordSetFF.getString(i * 2 + 11).equals("1")) {
	%>
								<TR>
									<TD>
										<%=Util.toScreen(RecordSetFF.getString(i * 2 + 10), user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=30 size=30
											name="nff0<%=i%>"
											value="<%=RecordSet.getString("numberfield" + i)%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
			}
			}
			for (int i = 1; i <= 5; i++) {
				if (RecordSetFF.getString(i * 2 + 21).equals("1")) {
	%>
								<TR>
									<TD>
										<%=Util.toScreen(RecordSetFF.getString(i * 2 + 20), user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT class=InputStyle maxLength=100 size=30
											name="tff0<%=i%>"
											value="<%=Util.toScreenToEdit(RecordSet.getString("textfield" + i), user.getLanguage())%>">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
			}
			}
			for (int i = 1; i <= 5; i++) {
				if (RecordSetFF.getString(i * 2 + 31).equals("1")) {
	%>
								<TR>
									<TD>
										<%=Util.toScreen(RecordSetFF.getString(i * 2 + 30), user.getLanguage())%>
									</TD>
									<TD class=Field>
										<INPUT type=checkbox name="bff0<%=i%>" value="1"
											<%if(RecordSet.getString("tinyintfield"+i).equals("1")){%>
											checked <%}%>>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<%
			}
			}
		}
	%>
							</TBODY>
						</TABLE>
						<TD width="1%"></TD>
						<TD vAlign=top width="49%">
							<table width="100%">
								<TR class=Title>
									<TH>
										<%=SystemEnv.getHtmlLabelName(15707,user.getLanguage())%>
									</TH>
								</TR>
								<TR  style="height: 1px">
									<TD class=Line colSpan=3></TD>
								</TR>
								<%
									if(!photoid.equals("0")&&!photoid.equals("") ){
								%>
								<TR class=Spacing  style="height: 1px">
									<TD class=Line1></TD>
								<TR>
									<TD>
										<img border=0 width="450" height="480" src="/weaver/weaver.file.FileDownload?fileid=<%=photoid%>">
									</TD>
								</TR>
								<input class=inputstyle type=hidden name=oldresourceimage value="<%=photoid%>">
								<input class=inputstyle type="hidden" name=contacterids value="<%=ContacterID%>">
								<tr>
									<td align=right>
										<BUTTON class=btnDelete accessKey=D
											onClick="delpic()">
											<U>D</U>-
											<%=SystemEnv.getHtmlLabelName(16075,user.getLanguage())%>
										</BUTTON>
									</td>
								</tr>
								<%
						}else{
						%>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(15707,user.getLanguage())%>
																</TD>
																<TD class=Field>
																	<input class=inputstyle type=file name=photoid
																		value="<%=photoid%>">
																</TD>
	
																<TD class=Field>
															(<%=SystemEnv.getHtmlLabelName(21130,user.getLanguage())%>:400*450)
									</TD>
								</TR>
								<TR  style="height: 1px">
									<TD class=Line colSpan=2></TD>
								</TR>
								<%
						}
						%>
							</table>
						</td>
						</TR>
						<TABLE class=ViewForm>
							<COLGROUP>
								<COL width="10%">
								<COL width="90%">
							<TBODY>
								<TR class=Title>
									<TH colSpan=4>
										<%=SystemEnv.getHtmlLabelName(454, user.getLanguage())%>
									</TH>
								</TR>
								<TR class=Spacing  style="height: 1px">
									<TD class=Line1 colSpan=2></TD>
								</TR>
								<TR>
									<TD rowspan="1" colspan=2>
										<TEXTAREA class=InputStyle NAME=Remark ROWS=3 STYLE="width:100%"><%=RecordSet.getString("remark")%></TEXTAREA>
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
								<TR>
									<TD>
										<%=SystemEnv.getHtmlLabelName(454, user.getLanguage())%>
										<%=SystemEnv.getHtmlLabelName(58, user.getLanguage())%>
																</TD>
																<TD class=Field>
										<INPUT class="wuiBrowser" type=hidden name="RemarkDoc"
											value='<%=RecordSet.getString("remarkDoc")%>'
											_displayText="<%=DocComInfo.getDocname(RecordSet.getString("remarkDoc"))%>"
											_displayTemplate="<a href='/docs/docs/DocDsp.jsp?id=#b{id}'>#b{name}</a>"
											_url="/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp">
									</TD>
								</TR>
								<tr  style="height: 1px">
									<td class=Line colspan=2></td>
								</tr>
							</TBODY>
						</TABLE>
					</table>
			</TR>
			</FORM>
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

<script>
function onDelete(){
	window.onbeforeunload=null;
	weaver.method.value="delete";
	weaver.submit();
}
function doDel(){
	if(isdel()){onDelete();}
}
function delpic(){
      if(confirm("ȷ��Ҫɾ����ͼƬ��")){
      window.onbeforeunload=null;
	  weaver.method.value = "delpic";
	  weaver.submit();
     }
  }
</script>


<SCRIPT type="text/javascript">
//added by lupeng 2004.06.04.
function mailValid() {
	var emailStr = document.all("CEmail").value;
	emailStr = emailStr.replace(" ","");
	if (!checkEmail(emailStr)) {
		alert("<%=SystemEnv.getHtmlLabelName(18779, user.getLanguage())%>");
		document.all("CEmail").focus();
		document.all("CEmail").value="";
		return;
	}
}

function doCancel(){
	document.location.href="/CRM/data/ViewContacter.jsp?log=<%=log%>&ContacterID=<%=ContacterID%>&canedit=true"
}

function onSave(obj){
	if(check_form(document.weaver,'Title,FirstName,JobTitle')){
		window.onbeforeunload=null;
		obj.disabled=true;
	    weaver.submit();
	}
}
function protectContacter(){
	if(!checkDataChange())//added by cyril on 2008-06-13 for TD:8828
		event.returnValue="<%=SystemEnv.getHtmlLabelName(19004, user.getLanguage())%>";
}
</SCRIPT>
	</BODY>
	<SCRIPT language="javascript" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
	<!-- added by cyril on 2008-06-13 for TD:8828 -->
	<script language=javascript src="/js/checkData.js"></script>
	<!-- end by cyril on 2008-06-13 for TD:8828 -->
</HTML>
