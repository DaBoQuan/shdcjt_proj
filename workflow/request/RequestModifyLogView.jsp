<!--
created by cyril on 2008-07-09
���޸���־����
-->
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="FieldValue" class="weaver.workflow.field.FieldValue" scope="page" />
<%
	boolean isMonitor = false;//���̶�����
	int ismonitor = Util.getIntValue(request.getParameter("ismonitor"), 0);
	int urger = Util.getIntValue(request.getParameter("urger"), 0);	
	if(ismonitor==1 || urger==1)
		isMonitor = true;
	String workflowid = "";
	String requestid = Util.null2String(request.getParameter("requestid"));
	String pnodeid = Util.null2String(request.getParameter("nodeid"));
	String isAll = Util.null2String(request.getParameter("isAll"));
	String requestname = "";
	String sql = "";
	String viewNodeids = "";

	RecordSet.executeProc("workflow_Requestbase_SByID", requestid + "");
	RecordSet.next();
	requestname = RecordSet.getString("requestname");
	workflowid = RecordSet.getString("workflowid");
    ArrayList detailtables=new ArrayList();
    int isbill=0;
    int billid=0;
    RecordSet.executeSql("select formid,isbill from workflow_base where isbill='1' and id="+workflowid);
    if(RecordSet.next()){
    	isbill=RecordSet.getInt(2);
        billid=RecordSet.getInt(1);
        RecordSet.executeSql("select tablename from workflow_billdetailtable where billid="+billid+" order by orderid");
        while(RecordSet.next()){
            detailtables.add(RecordSet.getString(1));
        }
    }

	boolean isOracle = RecordSet.getDBType().equals("oracle");
	
	//ȡ�������нڵ�
	String allNodeids = "";
	
	if(!isMonitor) {
		sql = "select nodeid from workflow_flownode where workflowid="+workflowid;
		RecordSet.executeSql(sql);
		while(RecordSet.next()) {
			allNodeids += RecordSet.getString("nodeid")+",";
		}
		//out.println("all="+allNodeids);
		
		sql = "select viewnodeids from workflow_flownode where workflowid=" + workflowid + " ";
		//if (!isAll.equals("1")) {
			//��־�鿴��ΧȨ��
			sql += " and nodeid=" + pnodeid;
		//}
		RecordSet.executeSql(sql);
		//out.println(sql);
		if(RecordSet.next()) {
			String ids = RecordSet.getString("viewnodeids");
			if (ids != null && !ids.equals("")) {
				//out.println(ids);
				if (!ids.equals("-1")) {
					viewNodeids += ids;
				}
				else if(ids.equals("-1")) {
					if(!viewNodeids.equals("") && !viewNodeids.substring(viewNodeids.length()-1, viewNodeids.length()).equals(","))
						viewNodeids += ",";
					viewNodeids += allNodeids;
					//out.println(viewNodeids);
				}
			}
		}
		if(!viewNodeids.equals(""))
			viewNodeids = viewNodeids.substring(0, viewNodeids.length()-1);
		//out.println("===>"+viewNodeids+"<===<br>");
	}

	StringBuffer s = new StringBuffer();
	//���ֶ��޸ļ�¼
	s = new StringBuffer();
	s.append("select * ");
	if(isOracle)
		s.append("from (select * ");
	s.append("from (select id, ");
	s.append("-1 sn,-1 fieldorder,optKind,-1 optType,requestId,nodeId,");
	s.append("(select nodename from workflow_nodebase where id=t.Nodeid) nodeName,");
	s.append("isBill,fieldLableId,");
	s.append("-1 fieldGroupId,fieldId,fieldHtmlType,fieldType,fieldNameCn,");
	s.append("fieldNameEn,fieldNameTw,");
	if(!isOracle) {
		s.append("convert(varchar(8000),fieldOldText) fieldOldText,");
		s.append("convert(varchar(8000),fieldNewText) fieldNewText,");
	}
	else {
		s.append("fieldOldText,fieldNewText,");
	}
	s.append("modifierType,agentId,modifierId,modifierIP,modifyTime from workflow_track t ");
	s.append("where t.requestid = " + requestid + " ");
	s.append("and (fieldid in (select fieldid from workflow_nodeform where isView=1 and nodeid=t.nodeid) ");
	s.append("or fieldid in (select fieldid from workflow_modeview where isView=1 and nodeid=t.nodeid) ");
	s.append("or fieldid=-1) ");
	if (!isAll.equals("1")) {//ֻ��ʾ���ڵ�
		s.append("and t.nodeid=" + pnodeid + " ");
	}
	if(!isMonitor) {//�Ǽ��
		//s.append("and (nodeid in (select nodeid from workflow_currentoperator where userid="+user.getUID()+" and requestid=t.requestId) ");
		if(!viewNodeids.equals(""))
			s.append(" and ( nodeid in (" + viewNodeids + ") ");
		else
			s.append("and ( 1=2 ");
		s.append(") ");
	}
	s.append(") a ");
	s.append("UNION ALL ");
	s.append("select * ");
	s.append("from (select t1.id,t1.sn,t2.fieldorder,t1.optKind,t1.optType,t1.requestId,t1.nodeId,");
	s.append("(select nodename from workflow_nodebase where id=t1.Nodeid) nodeName,");
	s.append("t1.isBill,t1.fieldLableId,");
	s.append("t1.fieldGroupId,t1.fieldId,t1.fieldHtmlType,t1.fieldType,t1.fieldNameCn,t1.fieldNameEn,fieldNameTw,");
	if(!isOracle) {
		s.append("convert(varchar(8000),t1.fieldOldText) fieldOldText,");
		s.append("convert(varchar(8000),t1.fieldNewText) fieldNewText,");
	}
	else {
		s.append("t1.fieldOldText,t1.fieldNewText,");
	}
	s.append("t1.modifierType,t1.agentId,t1.modifierId,t1.modifierIP,t1.modifyTime ");
	s.append("from workflow_trackdetail t1, ");
    if(isbill==1){
    s.append("(select a.id as fieldid,b.orderid as groupId,a.dsporder as fieldorder ");
	s.append("from workflow_billfield a,workflow_billdetailtable b ");
	s.append("where a.viewtype = '1' and a.detailtable=b.tablename and b.billid="+billid+" ) t2 ");
    }else{
	s.append("(select fieldid,groupId,fieldorder ");
	s.append("from workflow_formfield ");
	s.append("where isdetail = '1'  and formid="+billid+") t2 ");
    }
	s.append("where t1.requestid = " + requestid + " ");
	if (!isAll.equals("1")) {//ֻ��ʾ���ڵ�
		s.append("and t1.nodeid=" + pnodeid + " ");
	}
	if(!isMonitor) {
		//s.append("and (t1.nodeid in (select nodeid from workflow_currentoperator where userid="+user.getUID()+" and requestid=t1.requestId) ");
		if(!viewNodeids.equals(""))
			s.append(" and ( t1.nodeid in (" + viewNodeids + ") ");
		else
			s.append("and ( 1=2 ");
		s.append(") ");
	}
	s.append("and (t1.fieldid in (select fieldid from workflow_nodeform where isView=1 and nodeid=t1.nodeid) ");
	s.append("or t1.fieldid in (select fieldid from workflow_modeview where isView=1 and nodeid=t1.nodeid) ");
	s.append(") ");
	s.append("and t1.fieldid = t2.fieldid ");
    if(isbill==1){
        s.append("and t1.fieldgroupid+1 = t2.groupid ");
    }else{
        s.append("and t1.fieldgroupid = t2.groupid ");
    }
	if(isOracle)
		s.append("order by t1.modifyTime, t1.sn,  t2.fieldorder, t1.modifierId, t1.nodeId, t1.optType, t1.fieldgroupid, t1.modifierIP ");
	s.append(") b ");
	if(isOracle)
		s.append(") ");
	s.append("order by modifytime, sn, fieldorder, modifierid, nodeid, opttype, fieldGroupId, modifierip,id");
	//out.println(s.toString());
	RecordSet.executeSql(s.toString());
	/*
	 if(RecordSet.getCounts()<=0){
	 response.sendRedirect("/base/error/DBError.jsp?type=FindData");
	 return;
	 }
	*/
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<style>
#dettb td {
	height: 22px;
}

.add {
	color: #00FF00;
}

.mod {
	color: #FF0000;
}

.del {
	color: #0000FF;
}
</style>
</HEAD>
<%
	String imagefilename = "/images/hdReport.gif";
	String titlename = SystemEnv.getHtmlLabelName(21621, user.getLanguage()) + " - " + SystemEnv.getHtmlLabelName(648, user.getLanguage()) + ":<a href=ViewRequest.jsp?requestid=" + requestid + ">" + Util.toScreen(requestname, user.getLanguage()) + "</a>";
	String needfav = "1";
	String needhelp = "";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp"%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>

<%
	if (isAll.equals("0")) {
		RCMenu += "{" + SystemEnv.getHtmlLabelName(20234, user.getLanguage()) + ",javascript:doViewAll(1),_self}";
		RCMenuHeight += RCMenuHeightStep;
	} else {
		RCMenu += "{" + SystemEnv.getHtmlLabelName(89, user.getLanguage()) + SystemEnv.getHtmlLabelName(18564, user.getLanguage()) + ",javascript:doViewAll(0),_self}";
		RCMenuHeight += RCMenuHeightStep;
	}
	//RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:doBack(),_self}";
	//RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp"%>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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



				<table class="viewform">
					<colgroup>
						<col width="100%">
					<tr class="Title">
						<th><%=SystemEnv.getHtmlLabelName(21621, user.getLanguage())%></th>
					</tr>
					<tr class="Spacing">
						<td class="Line1"></td>
					</tr>
					<tr>
						<td valign=top>
						<table class=liststyle cellspacing=1>
							<colgroup>
								<col width="15%">
								<col>
							<tbody>
								<tr class=Header>
									<th width="15%"><%=SystemEnv.getHtmlLabelName(15586, user.getLanguage())%></th>
									<th><%=SystemEnv.getHtmlLabelName(15275, user.getLanguage())%></th>
								</tr>
								<TR class=Line style="height: 1px;"> 
									<Th colspan="2"></Th>
								</TR>

								<%
									boolean isDetail = false;//�Ƿ���ϸ
									boolean isDetailRow = false;//�Ƿ���ϸһ�н���
									boolean isDetailRowRow = false;//�Ƿ���ϸ�е�һ�н���
									StringBuffer detBuf = new StringBuffer();//��ϸƴ��
									String previousFieldName = "";//��ϸѭ���Ŀ�ʼfield

									boolean isMatch = false;//�Ƿ�ƥ��
									boolean isLoadDetail = false;//�Ƿ������ϸ
									boolean isContentClose = false;//���ֶ����ݱ�ǩ�Ƿ�ر�
									boolean isDetailClose = false;//���ֶ����ݱ�ǩ�Ƿ�ر�
									Map fieldMap = new HashMap();//��ϸ�ֶε��б�

									Map typeMap = new HashMap();//��������
									typeMap.put("1", SystemEnv.getHtmlLabelName(456, user.getLanguage()));
									typeMap.put("2", SystemEnv.getHtmlLabelName(103, user.getLanguage()));
									typeMap.put("3", SystemEnv.getHtmlLabelName(91, user.getLanguage()));
									
									Map levelMap = new HashMap();
									levelMap.put("0", SystemEnv.getHtmlLabelName(225, user.getLanguage()));
									levelMap.put("1", SystemEnv.getHtmlLabelName(15533, user.getLanguage()));
									levelMap.put("2", SystemEnv.getHtmlLabelName(2087, user.getLanguage()));
									
									Map msgMap =  new HashMap();
									msgMap.put("0", SystemEnv.getHtmlLabelName(17583, user.getLanguage()));
									msgMap.put("1", SystemEnv.getHtmlLabelName(17584, user.getLanguage()));
									msgMap.put("2", SystemEnv.getHtmlLabelName(17585, user.getLanguage()));

									StringBuffer s1 = new StringBuffer();
									StringBuffer s2 = new StringBuffer();

									String modifytime = "";
									String modifierip = "";
									int modifierid = 0;
									int modifiertype = 0;
									int nodeid = 0;
									int eqnodeid = 0;
									int esn = -1;
									String egroupId = "";
									int sid = 0;//���ֶε�ǰ��¼��
									int rowid = 1;//�к�
									int cnt = RecordSet.getCounts();//���ֶ��޸��ܼ�¼��
									while (RecordSet.next()) {
										//out.println("modifytime="+RecordSet.getString("modifytime"));
										sid++;
										//����ǵ�һ�λ��߲�ƥ��Ļ�setֵ
										if (sid > 1) {
											if (modifytime.equals(RecordSet.getString("modifytime")) && modifierip.equals(RecordSet.getString("modifierip")) && modifierid == RecordSet.getInt("modifierid") && modifiertype == RecordSet.getInt("modifiertype") && nodeid == RecordSet.getInt("nodeid")) {
												isMatch = true;
												eqnodeid = nodeid;
											} else {
												eqnodeid = nodeid;
												isMatch = false;
											}
										}
										//�ڶ��ο�ʼѭ������ǩ�ǹر�
										if (sid > 1 && isMatch == false) {
											//�ر����ֶ�
											if (isContentClose == true) {
												if (isDetailRowRow == true) {
													if (!s1.toString().equals(""))
														out.println(s1.toString() + "</tr>");
													if (!s2.toString().equals(""))
														out.println(s2.toString() + "</tr>");
													isDetailRowRow = false;
												}
												s1 = new StringBuffer();
												s2 = new StringBuffer();
												if (isDetailClose == true) {
													out.println("</table></td></tr><!-- 2.detail end -->");
													isDetailClose = false;
												}
												out.println("</table><!-- 2.content end -->");
												isContentClose = false;
											}
											//�ر���ϸ��ǩ
											if (isDetailRow == true) {
												out.println("<!-- �ڶ��ο�ʼѭ�� �ر���ϸ��ǩ --></table>");
												isDetailRow = false;
											}
								%>
								<!--�ڶ��ο�ʼѭ������ǩ�ǹر�-->
								</td>
								</tr>
								<tr>
									<td colspan="2" height=8></td>
								</tr>
								<%
									}
										if (sid == 1 || isMatch == false) {
											modifytime = RecordSet.getString("modifytime");
											modifierip = RecordSet.getString("modifierip");
											modifierid = RecordSet.getInt("modifierid");
											modifiertype = RecordSet.getInt("modifiertype");
											nodeid = RecordSet.getInt("nodeid");
											if (sid == 1)
												eqnodeid = nodeid;
											rowid = 1;
										} else
											rowid++;
										if (isMatch == false) {
											esn = -1;
											egroupId = "";//�ڵ㲻ƥ�䣬��ϸ������
											//�ж��Ƿ�����ͬ�Ľڵ�
											//out.println(eqnodeid+"<====>"+nodeid);
											if (sid > 1 && eqnodeid == nodeid) {
								%>
								<!-- ��ͬ�Ľڵ� -->
								<tr>
									<td></td>
									<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr class=Header>
											<th>
											<%
											if(RecordSet.getInt("agentId")==-1 && RecordSet.getInt("modifierid")==-1) {
											%>
												<%=SystemEnv.getHtmlLabelName(468, user.getLanguage())%> 
											<%
											}
											else {
												if(RecordSet.getInt("agentId")!=-1) {
											%>
											<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=Util.toScreen(ResourceComInfo.getDepartmentID(RecordSet.getString("agentId")),user.getLanguage())%>"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ResourceComInfo.getDepartmentID(RecordSet.getString("agentId"))),user.getLanguage())%></a>
	               							/
											<a href="javaScript:openhrm(<%=RecordSet.getString("agentId")%>);" onclick='pointerXY(event);'>
											<%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("agentId")), user.getLanguage())%></a>
											->
											<%
											}
											%>
											<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=Util.toScreen(ResourceComInfo.getDepartmentID(RecordSet.getString("modifierid")),user.getLanguage())%>"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ResourceComInfo.getDepartmentID(RecordSet.getString("modifierid"))),user.getLanguage())%></a>
	               							/
											<a
												href="javaScript:openhrm(<%=RecordSet.getString("modifierid")%>);" onclick='pointerXY(event);'>
											<%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("modifierid")), user.getLanguage())%></a>
											<%
											}
											%>
											</th>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
									<%
										} else {
									%> <!-- ��ͬ�ڵ� -->
								<tr class=Header>
									<th width="15%"><%=RecordSet.getString("nodeName")%></th>
									<th>
									<%
									if(RecordSet.getInt("agentId")==-1 && RecordSet.getInt("modifierid")==-1) {
									%>
										<%=SystemEnv.getHtmlLabelName(468, user.getLanguage())%> 
									<%
									}
									else {
										if(RecordSet.getInt("agentId")!=-1) {
									%>
									<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=Util.toScreen(ResourceComInfo.getDepartmentID(RecordSet.getString("agentId")),user.getLanguage())%>"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ResourceComInfo.getDepartmentID(RecordSet.getString("agentId"))),user.getLanguage())%></a>
	               					/
									<a href="javaScript:openhrm(<%=RecordSet.getString("agentId")%>);" onclick='pointerXY(event);'>
									<%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("agentId")), user.getLanguage())%></a>
									->
									<%
									}
									%>
									<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=Util.toScreen(ResourceComInfo.getDepartmentID(RecordSet.getString("modifierid")),user.getLanguage())%>"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ResourceComInfo.getDepartmentID(RecordSet.getString("modifierid"))),user.getLanguage())%></a>
	               					/
									<a href="javaScript:openhrm(<%=RecordSet.getString("modifierid")%>);" onclick='pointerXY(event);'>
									<%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("modifierid")), user.getLanguage())%></a>
									<%
									}
									%>
									</th>
								</tr>
								<TR class=Line style="height: 1px;">
									<Th colspan="2"></Th>
								</TR>
								<tr>
									<td></td>
									<td>
									<%
										}
												isContentClose = true;//�������ֶ�����
									%> <!-- content start -->
									<table id=dettb border="0" cellpadding="0" cellspacing="0"
										width="100%">
										<tr>
											<td><%=RecordSet.getString("modifytime")%>&nbsp;&nbsp;
											<%if(!(RecordSet.getInt("agentId")==-1 && RecordSet.getInt("modifierid")==-1)) {%>
											IP:<%=RecordSet.getString("modifierip")%>
											<%} %>
											</td>
										</tr>
										<%
											}
												if (RecordSet.getInt("opttype") == -1) {//����ϸ�Ĵ���
													//�����б���
													String bgcolor = "";
													if ((rowid % 2) == 1)
														bgcolor = " bgcolor = #EAEAEA ";
													else
														bgcolor = "";
										%>
										<tr <%=bgcolor%>>
											<td><%=rowid%>�� <%
												//����Ƿ񵥾�,���ݵ��ֶ�����ȡ����ͬ
														if (RecordSet.getInt("isBill") == 1) {
											%> [<%=SystemEnv.getHtmlLabelName(RecordSet.getInt("fieldLableId"), user.getLanguage())%>]
											<%
												} else {
											%> [<%if(user.getLanguage()==7){%><%=RecordSet.getString("fieldNameCn")%><%}else if(user.getLanguage()==9){%><%=RecordSet.getString("fieldNameTw")%><%}else{%><%=RecordSet.getString("fieldNameEn")%><%}%>]
											<%
												}
											
											if(RecordSet.getInt("fieldid")==-1) {//������ֶεĴ���												
												String strLevel = "";
												String strMsg = "";
												String title = "";
												String showname1 = "";
												String showname2 = "";
												for(int m=0; m<2; m++) {
													if(RecordSet.getInt("fieldLableId")==15534) {//�����̶� 0:���� 1:��Ҫ 2:����17586
														if(m==0)
															strLevel = (String) levelMap.get(Util.null2String(RecordSet.getString("fieldOldText")));
														else
															strLevel = (String) levelMap.get(Util.null2String(RecordSet.getString("fieldNewText")));
													}
													else if(RecordSet.getInt("fieldLableId")==17586) {//�������� 0:���������� 1:���߶������� 2���߶�������
														if(m==0)
															strMsg = (String) msgMap.get(Util.null2String(RecordSet.getString("fieldOldText")));
														else
															strMsg = (String) msgMap.get(Util.null2String(RecordSet.getString("fieldNewText")));
													}
													else {//����
														if(m==0)
															title = Util.null2String(RecordSet.getString("fieldOldText"));
														else
															title = Util.null2String(RecordSet.getString("fieldNewText"));
													}
													if(m==0)
														showname1 = Util.null2String(strLevel)+Util.null2String(strMsg)+Util.null2String(title);
													else
														showname2 = Util.null2String(strLevel)+Util.null2String(strMsg)+Util.null2String(title);
												}
												
												
											%>
												<%=SystemEnv.getHtmlLabelName(623, user.getLanguage())%> 
												"<span class=mod><%=showname1%></span>"
												<%=SystemEnv.getHtmlLabelName(21623, user.getLanguage())%> 
												"<span class=mod><%=showname2%></span>"
											<%
											}
											else {
												//���������⴦��
												if(RecordSet.getInt("fieldHtmlType")!=6) {
												%>
												<%=SystemEnv.getHtmlLabelName(623, user.getLanguage())%> 
												"<span class=mod><%=FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldOldText")), RecordSet.getInt("isBill"))%></span>"
												<%
												}
												%>
												<%=SystemEnv.getHtmlLabelName(21623, user.getLanguage())%> 
												"<span class=mod><%=FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldNewText")), RecordSet.getInt("isBill"))%></span>"
											<%
											}
											%>
											</td>
										</tr>
										<%
											} else {//��ϸ�Ĵ���
													if (egroupId.equals("") || !egroupId.equals(nodeid + "_" + RecordSet.getInt("fieldGroupId"))) {//����ͬһ����ϸ���ӡ������
														egroupId = nodeid + "_" + RecordSet.getInt("fieldGroupId");
                                                        esn=-1;
														//�ر���ϸ�б�
														if (isDetailClose == true) {
															if (!s1.toString().equals(""))
																out.println(s1.toString() + "</tr>");
															if (!s2.toString().equals(""))
																out.println(s2.toString() + "</tr>");
															out.println("</table></td></tr><!-- 1.detail end -->");
															isDetailClose = false;
														}
														isDetailClose = true;//������ϸ�б�
														//�ж��Ƿ�Ϊģ��
														weaver.workflow.workflow.WFModeNodeFieldManager wFModeNodeFieldManager=new weaver.workflow.workflow.WFModeNodeFieldManager();
														boolean isMode=wFModeNodeFieldManager.getIsModeByWorkflowIdAndNodeId(Util.getIntValue(workflowid), nodeid);
														//�õ���ϸ�ֶ�����
														s = new StringBuffer();

														if(isbill==1){
                                                            s.append("select a.id as fieldid, ");
                                                            s.append("(select labelname from HtmlLabelInfo t ");
                                                            s.append("where t.languageid = 7 and t.indexid = a.fieldlabel) fieldNameCn,");
                                                            s.append("(select labelname from HtmlLabelInfo t where t.languageid = 8 and t.indexid = a.fieldlabel) fieldNameEn, ");
                                                            s.append("(select labelname from HtmlLabelInfo t where t.languageid = 9 and t.indexid = a.fieldlabel) fieldNameTw ");
														    s.append("from workflow_billfield a ");
														    s.append("where a.viewtype = '1' ");
                                                            s.append("and a.id in (select fieldid from ");
                                                            if(isMode) s.append(" workflow_modeview ");
                                                            else s.append(" workflow_nodeform ");
                                                            s.append("where isView=1 and nodeid=" + nodeid + ") ");//ֻȡ�ڵ�����ʾ��
                                                            s.append(" and a.detailtable= '" + detailtables.get(RecordSet.getInt("fieldGroupId")) + "' order by dsporder ");
														}else{
                                                            s.append("select a.fieldid, ");
                                                            s.append("(select fieldlable from workflow_fieldlable t ");
                                                            s.append("where t.langurageid = 7 and t.fieldid = a.fieldid and t.formid = a.formid) fieldNameCn,");
                                                            s.append("(select fieldlable from workflow_fieldlable t where t.langurageid = 8 and t.fieldid = a.fieldid ");
                                                            s.append("and t.formid = a.formid) fieldNameEn, ");
                                                            s.append("(select fieldlable from workflow_fieldlable t where t.langurageid = 9 and t.fieldid = a.fieldid ");
                                                            s.append("and t.formid = a.formid) fieldNameTw ");
														    s.append("from workflow_formfield a ");
														    s.append("where a.isdetail = '1' ");
                                                            s.append("and a.fieldid in (select fieldid from ");
                                                            if(isMode) s.append(" workflow_modeview ");
                                                            else s.append(" workflow_nodeform ");
                                                            s.append("where isView=1 and nodeid=" + nodeid + ") ");//ֻȡ�ڵ�����ʾ��
                                                            s.append("and a.groupId = " + RecordSet.getInt("fieldGroupId") + " and a.formid="+billid+" order by fieldorder ");
														}

														rs.executeSql(s.toString());
														//out.println(s.toString());
														s1 = new StringBuffer();
														s2 = new StringBuffer();
														out.println("<TR class=Line><TD style=\"height:3px\"></TD></TR>");
														out.println("<!-- detail start --><tr><td><table id=dettb border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
														/*��ϸ����*/

														out.println("<tr bgcolor=#D2D2D2><td>" + SystemEnv.getHtmlLabelName(104, user.getLanguage()) + "</td>");
														while (rs.next()) {
															fieldMap.put(rs.getString("fieldid"), rs.getString("fieldid") + "");
															out.println("<td>&nbsp;");
															if(user.getLanguage()==7) {
																out.println(rs.getString("fieldNameCn"));
															}
															else if(user.getLanguage()==9) {
																out.println(rs.getString("fieldNameTw"));
															}
															else {
																out.println(rs.getString("fieldNameEn"));
															}
															out.println("&nbsp;</td>");
														}
														out.println("</tr>");
														out.println("<TR bgcolor=#A1A1A1><TD style=\"height:2px\" colSpan=" + rs.getCounts() + 1 + "></TD></TR>");

														/*END ��ϸ����*/
													}
													if (esn == -1 || esn != RecordSet.getInt("sn")) {
														esn = RecordSet.getInt("sn");
														if (isDetailRowRow == true) {
															if (!s1.toString().equals(""))
																out.println(s1.toString() + "</tr>");
															if (!s2.toString().equals(""))
																out.println(s2.toString() + "</tr>");
															isDetailRowRow = false;
														}
														s1 = new StringBuffer();
														s2 = new StringBuffer();
														isDetailRowRow = true;
														if (RecordSet.getInt("opttype") == 1)//�����������
															s1.append("<tr><td class=add>" + typeMap.get(RecordSet.getString("optType")) + "</td>");
														if (RecordSet.getInt("opttype") == 2) {//�޸ĵ������
															//s2 = new StringBuffer();
															s1.append("<tr bgcolor=#EAEAEA><td class=mod>" + typeMap.get(RecordSet.getString("optType")) + "(" + SystemEnv.getHtmlLabelName(502, user.getLanguage()) + ")</td>");
															s2.append("<tr><td class=mod>" + typeMap.get(RecordSet.getString("optType")) + "(" + SystemEnv.getHtmlLabelName(21673, user.getLanguage()) + ")</td>");
														}
														if (RecordSet.getInt("opttype") == 3)//ɾ���������
															s1.append("<tr><td class=del>" + typeMap.get(RecordSet.getString("optType")) + "</td>");
													}

													if (fieldMap.get(RecordSet.getString("fieldid")) != null) {//�����б��е��ֶβ���ʾ
														if (RecordSet.getInt("opttype") == 1) {//����
															s1.append("<td class=add>&nbsp;" + FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldNewText")), RecordSet.getInt("isBill")) + "</td>");
														} else if (RecordSet.getInt("opttype") == 2) {//�޸�
															s1.append("<td class=mod>&nbsp;" + FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldOldText")), RecordSet.getInt("isBill")) + "</td>");
															s2.append("<td class=mod>&nbsp;" + FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldNewText")), RecordSet.getInt("isBill")) + "</td>");
														} else if (RecordSet.getInt("opttype") == 3) {//ɾ��
															s1.append("<td class=del>&nbsp;" + FieldValue.getFieldValue(session, RecordSet.getInt("fieldid"), RecordSet.getInt("fieldHtmlType"), RecordSet.getInt("fieldType"), Util.null2String(RecordSet.getString("fieldOldText")), RecordSet.getInt("isBill")) + "</td>");
														}
													}
												}
												//�ж��Ƿ��Ѿ���β��,���˹رձ�ǩ
												if (sid == cnt) {
													if (isDetailRowRow == true) {
														if (!s1.toString().equals(""))
															out.println(s1.toString() + "</tr>");
														if (!s2.toString().equals(""))
															out.println(s2.toString() + "</tr>");
														isDetailRowRow = false;
													}
													//System.out.println("s1="+s1.toString());
													//System.out.println("s2="+s2.toString());
													s1 = new StringBuffer();
													s2 = new StringBuffer();
													//�ر���ϸ�б�
													if (isDetailClose == true) {
														out.println("<!-- 3.detail end --></table></td></tr>");
														isDetailClose = false;
													}
													//�ж����ֶ������Ƿ���,������ر�
													if (isContentClose == true) {
														out.println("</table><!-- 3.content end -->");
														isContentClose = false;
													}
													//�ر���ϸ��ǩ
													if (isDetailRow == true) {
														out.println("<!-- �ر���ϸ --></table>");
														isDetailRow = false;
													}
										%>
										</td>
										</tr>
										<tr>
											<td colspan="2" height=8></td>
										</tr>
										<%
											}
												//�жϵ�һ��
												if (sid == 1) {
													isMatch = true;
												}
											}
										%>
										</tbody>
									</table>
									</td>
								</tr>
						</table>
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
</BODY>
</HTML>

<script>
var URL = '/workflow/request/RequestModifyLogView.jsp?requestid=<%=requestid%>&nodeid=<%=pnodeid%>';
function doViewAll(flag) {
	location.href = URL+"&isAll="+flag+"&ismonitor=<%=ismonitor%>&urger=<%=urger%>";
}
function doBack() {
	location.href = 'ViewRequest.jsp?requestid=<%=requestid%>';
}
</script>