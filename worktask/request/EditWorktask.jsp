<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.SessionOper" %>
<%@ page import="weaver.hrm.performance.*" %>
<%@ page import="weaver.worktask.worktask.*" %>
<STYLE TYPE="text/css">
/*��ʽ��δ����*/
.btn_RequestSubmitList {BORDER-RIGHT: #7b9ebd 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7b9ebd 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde); BORDER-LEFT: #7b9ebd 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7b9ebd 1px solid 
} 
</STYLE>
<%@ page import="weaver.general.*" %>
<jsp:useBean id="recordSet_requestbase" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<%
session.setAttribute("relaterequest", "new");
int canCreateHistoryWorktask = Util.getIntValue(BaseBean.getPropValue("worktask", "canCreateHistoryWorktask"), 1);
String currentDay = TimeUtil.getCurrentDateString();
//Ȩ���жϣ�ȷ���˵� Start
int isRefash = Util.getIntValue(request.getParameter("isRefash"), 0);
boolean canView = false;
boolean canEdit = false;
boolean canSubmit = false;
int requestid = Util.getIntValue(request.getParameter("requestid"), 0);
int operatorid = 0;
String worktaskName = "";

int wtid = 0;
int request_status = 0;
recordSet_requestbase.execute("select * from worktask_requestbase where requestid="+requestid);
if(recordSet_requestbase.next()){
	wtid = Util.getIntValue(recordSet_requestbase.getString("taskid"), 0);
	request_status = Util.getIntValue(recordSet_requestbase.getString("status"), 0);
}else{
	response.sendRedirect("/notice/noright.jsp");
}
int needcheck = Util.getIntValue(recordSet_requestbase.getString("needcheck"), 0);
int checkor = Util.getIntValue(recordSet_requestbase.getString("checkor"), 0);
if(needcheck == 0){
	checkor = 0;
}
int creater = Util.getIntValue(recordSet_requestbase.getString("creater"), 0);
int approverequest = Util.getIntValue(recordSet_requestbase.getString("approverequest"), 0);
WTRequestManager wtRequestManager = new WTRequestManager(wtid);
wtRequestManager.setLanguageID(user.getLanguage());
wtRequestManager.setUserID(user.getUID());
Hashtable checkRight_hs = wtRequestManager.checkRight(requestid, request_status, 0, creater, checkor, approverequest);
canView = (Util.null2String((String)checkRight_hs.get("canView"))).equalsIgnoreCase("true")?true:false;
canEdit = (Util.null2String((String)checkRight_hs.get("canEdit"))).equalsIgnoreCase("true")?true:false;
canSubmit = (Util.null2String((String)checkRight_hs.get("canSubmit"))).equalsIgnoreCase("true")?true:false;

if(canView == false){
	response.sendRedirect("/notice/noright.jsp");
}
if(canEdit == false){
	response.sendRedirect("/worktask/request/ViewWorktask.jsp?requestid="+requestid);
}

//Ȩ���жϣ�ȷ���˵� End
String worktaskStatusName = "";
Hashtable worktaskStatus_hs = new Hashtable();
rs.execute("select * from SysPubRef where masterCode='WorkTaskStatus' and flag=1");
while(rs.next()){
	int detailCode_tmp = Util.getIntValue(rs.getString("detailCode"), 0);
	String worktaskStatusName_tmp = SystemEnv.getHtmlLabelName(Util.getIntValue(rs.getString("detailLabel")), user.getLanguage());
	worktaskStatus_hs.put("worktaskstatus_"+detailCode_tmp, worktaskStatusName_tmp);
	if(request_status == detailCode_tmp){
		worktaskStatusName = worktaskStatusName_tmp;
	}
}
Hashtable canCreateTasks_hs = wtRequestManager.getCanCreateTasks(false);

worktaskName = (String)canCreateTasks_hs.get("tasks_"+wtid);
String tasksSelectStr = (String)canCreateTasks_hs.get("tasksSelectStr");

Hashtable ret_hs_1 = wtRequestManager.getViewFieldInfo();
ArrayList textheightList = (ArrayList)ret_hs_1.get("textheightList");
ArrayList idList = (ArrayList)ret_hs_1.get("idList");
ArrayList fieldnameList = (ArrayList)ret_hs_1.get("fieldnameList");
ArrayList crmnameList = (ArrayList)ret_hs_1.get("crmnameList");
ArrayList ismandList = (ArrayList)ret_hs_1.get("ismandList");
ArrayList fieldhtmltypeList = (ArrayList)ret_hs_1.get("fieldhtmltypeList");
ArrayList typeList = (ArrayList)ret_hs_1.get("typeList");
ArrayList wttypeList = (ArrayList)ret_hs_1.get("wttypeList");
ArrayList iseditList = (ArrayList)ret_hs_1.get("iseditList");
ArrayList defaultvalueList = (ArrayList)ret_hs_1.get("defaultvalueList");
ArrayList defaultvaluecnList = (ArrayList)ret_hs_1.get("defaultvaluecnList");
ArrayList fieldlenList = (ArrayList)ret_hs_1.get("fieldlenList");

int annexmaincategory = 0;
int annexsubcategory = 0;
int annexseccategory = 0;
rs.execute("select * from worktask_base where id="+wtid);
if(rs.next()){
	annexmaincategory = Util.getIntValue(rs.getString("annexmaincategory"), 0);
	annexsubcategory = Util.getIntValue(rs.getString("annexsubcategory"), 0);
	annexseccategory = Util.getIntValue(rs.getString("annexseccategory"), 0);
}
int maxUploadImageSize = 5;
maxUploadImageSize = Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+annexseccategory), 5);
if(maxUploadImageSize<=0){
	maxUploadImageSize = 5;
}
%>
<HTML><HEAD>
<title><%=Util.toScreen(worktaskName, user.getLanguage())%></title>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">
<script language=javascript src="/js/weaver.js"></script>
<script language=javascript src="/js/xmlextras.js"></script>
<script type='text/javascript' src='/dwr/interface/DocReadTagUtil.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/util.js'></script>
</HEAD>
<%@ include file="/cowork/uploader.jsp" %>
<%
String needfav ="1";
String needhelp ="";
String titlename = SystemEnv.getHtmlLabelName(82, user.getLanguage())+": "+worktaskName;
String imagefilename = "/images/hdMaintenance.gif";
%>
<BODY id="taskbody">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86, user.getLanguage())+",javaScript:OnSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
if(request_status == 1){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(615, user.getLanguage())+",javaScript:OnSubmit(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
//���ذ�ť�����ص��鿴ҳ��
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290, user.getLanguage())+",javaScript:OnComeBack(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<form name="taskform" method="post" action="RequestOperation.jsp" enctype="multipart/form-data">
<input type="hidden" name="wtid" id="wtid" value="<%=wtid%>">
<input type="hidden" name="taskid_<%=requestid%>" id="taskid_<%=requestid%>" value="<%=wtid%>">
<input type="hidden" name="requestid" id="requestid" value="<%=requestid%>">
<input type="hidden" name="requestid_add" value="<%=requestid%>">
<input type="hidden" name="operationType">
<input type="hidden" id="isCreate" name="isCreate" value="0">
<input type="hidden" id="needcheck" name="needcheck" value="wtid" >
<input type="hidden" id="functionPage" name="functionPage" value="AddWorktask.jsp" >
<input type="hidden" id="isRefash" name="isRefash" value="<%=isRefash%>" >
<input type="hidden" id="istemplate" name="istemplate" value="0" >
<table width=100% height=95% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
	<tr>
		<td height="10" colspan="3">
			<br>
			<div align="center">
				<font style="font-size:14pt;FONT-WEIGHT: bold"><%=worktaskName%></font>
			</div>
			<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
			</div>
			</td>
	</tr>
	<tr>
		<td></td>
		<td valign="top">
		<TABLE class="Shadow">
		<tr>
			<td valign="top">
			<!--table class="ViewForm" style="border:1px solid #FF0000"-->
			<table class="ViewForm">
			<colgroup>
			<col width="20%">
			<col width="80%">
			<tr style='height: 1px;'><td class=Line2 colSpan=2></td></tr>
			<tr>
				<td><%=SystemEnv.getHtmlLabelName(18177, user.getLanguage())%></td>
				<td  class="Field"><%=worktaskName%></td>
			</tr>
			<tr style='height: 1px;'><td class=Line2 colSpan=2></td></tr>
			<%
				int sourceworktaskid = Util.getIntValue(recordSet_requestbase.getString("sourceworktaskid"), 0);
				int sourcewokflowid = Util.getIntValue(recordSet_requestbase.getString("sourcewokflowid"), 0);
				int sourceworkplanid = Util.getIntValue(recordSet_requestbase.getString("sourceworkplanid"), 0);
				if(sourceworktaskid!=0 && sourcewokflowid!=0 && sourceworkplanid!=0){
					String linkStr = "";
					if(sourceworktaskid != 0){
						linkStr = "<a href=\"/worktask/request/ViewWorktaskTemplate.jsp?requestid="+sourceworktaskid+"\">"+SystemEnv.getHtmlLabelName(16539, user.getLanguage())+SystemEnv.getHtmlLabelName(64, user.getLanguage())+"</a>";
					}else if(sourcewokflowid != 0){
						linkStr = "";
					}else if(sourceworkplanid != 0){
						linkStr = "";
					}
			%>
			<tr>
				<td><%=SystemEnv.getHtmlLabelName(22139, user.getLanguage())%></td>
				<td  class="Field"><%=linkStr%></td>
			</tr>
			<tr style='height: 1px;'><td class=Line2 colSpan=2></td></tr>
			<%}%>
			<tr>
				<td><%=SystemEnv.getHtmlLabelName(21947, user.getLanguage())%></td>
				<td  class="Field"><%=worktaskStatusName%></td>
			</tr>
			<tr style='height: 1px;'><td class=Line2 colSpan=2></td></tr>
			<%
				String checkStr = "";
				String planStartDate = "";
				String planEndDate = "";
				String planDays = "";
				String needcheckField = "";
				String checkorField = "";
				for(int i=0; i<idList.size(); i++){
					int textheight_tmp = Util.getIntValue((String)textheightList.get(i), 0);
					int fieldid_tmp = Util.getIntValue((String)idList.get(i), 0);
					String fieldname_tmp = Util.null2String((String)fieldnameList.get(i));
					String crmname_tmp = Util.null2String((String)crmnameList.get(i));
					String fieldhtmltype_tmp = Util.null2String((String)fieldhtmltypeList.get(i));
					String type_tmp = Util.null2String((String)typeList.get(i));
					int isedit_tmp = Util.getIntValue((String)iseditList.get(i), 0);
					int ismand_tmp = Util.getIntValue((String)ismandList.get(i), 0);
					String value_tmp = Util.null2String(recordSet_requestbase.getString(fieldname_tmp));
					String fieldlen_tmp = Util.null2String((String)fieldlenList.get(i));
					int wttype = Util.getIntValue((String)wttypeList.get(i), 1);
					if(wttype != 1){
						continue;
					}
					if(ismand_tmp == 1 && !"4".equals(fieldhtmltype_tmp)){
						checkStr += (",field" + fieldid_tmp + "_"+requestid);
					}
					if("planstartdate".equalsIgnoreCase(fieldname_tmp)){
						planStartDate = "field" + fieldid_tmp + "_"+requestid;
					}else if("planenddate".equalsIgnoreCase(fieldname_tmp)){
						planEndDate = "field" + fieldid_tmp + "_"+requestid;
					}else if("plandays".equalsIgnoreCase(fieldname_tmp)){
						planDays = "field" + fieldid_tmp + "_"+requestid;
						if("".equals(value_tmp.trim())){
							value_tmp = "0";
						}
					}else if("needcheck".equalsIgnoreCase(fieldname_tmp)){
						needcheckField = "field"+fieldid_tmp+"_";
					}else if("checkor".equalsIgnoreCase(fieldname_tmp)){
						checkorField = "field"+fieldid_tmp+"_";
					}
					if("16".equals(type_tmp) || "152".equals(type_tmp) || "171".equals(type_tmp)){
						if(!"".equals(value_tmp)){
							String[] tlinkwts = Util.TokenizerString2(value_tmp, ",");
							for(int dx=0; dx<tlinkwts.length; dx++){
								String tlinkwt = Util.null2o(tlinkwts[dx]);
								int tempnum = Util.getIntValue((String)(session.getAttribute("tlinkwtnum")), 0);
								tempnum++;
								session.setAttribute("retrequestid"+tempnum, tlinkwt);
								session.setAttribute("tlinkwfnum", ""+tempnum);
								session.setAttribute("haslinkworktask", "1");
								session.setAttribute("deswtrequestid"+tempnum, ""+requestid);
							}
						}
					}
					String sHtml = "";
					
					sHtml = wtRequestManager.getFieldCellWithValue(textheight_tmp,fieldid_tmp, fieldname_tmp, fieldlen_tmp, crmname_tmp, fieldhtmltype_tmp, type_tmp, isedit_tmp, ismand_tmp, value_tmp, requestid);
					out.println("<tr><td>"+crmname_tmp+"</td><td class=\"field\">"+sHtml+"</td></tr>");
					out.println("<tr style='height: 1px;'><td class=Line2 colSpan=2></td></tr>");
				}
				//��������
				int remindtype = 0;
				int beforestart = 0;
				int beforestarttime = 0;
				int beforestarttype = 0;
				int beforestartper = 0;
				int beforeend = 0;
				int beforeendtime = 0;
				int beforeendtype = 0;
				int beforeendper = 0;
				remindtype = Util.getIntValue(recordSet_requestbase.getString("remindtype"), 0);
				beforestart = Util.getIntValue(recordSet_requestbase.getString("beforestart"), 0);
				beforestarttime = Util.getIntValue(recordSet_requestbase.getString("beforestarttime"), 0);
				beforestarttype = Util.getIntValue(recordSet_requestbase.getString("beforestarttype"), 0);
				beforestartper = Util.getIntValue(recordSet_requestbase.getString("beforestartper"), 0);
				beforeend = Util.getIntValue(recordSet_requestbase.getString("beforeend"), 0);
				beforeendtime = Util.getIntValue(recordSet_requestbase.getString("beforeendtime"), 0);
				beforeendtype = Util.getIntValue(recordSet_requestbase.getString("beforeendtype"), 0);
				beforeendper = Util.getIntValue(recordSet_requestbase.getString("beforeendper"), 0);
				String startTimeType = "";
				String endTimeType = "";
				if(beforestarttype == 0){
					startTimeType = SystemEnv.getHtmlLabelName(1925,user.getLanguage());
				}else if(beforestarttype == 1){
					startTimeType = SystemEnv.getHtmlLabelName(391,user.getLanguage());
				}else{
					startTimeType = SystemEnv.getHtmlLabelName(15049,user.getLanguage());
				}
				if(beforeendtype == 0){
					endTimeType = SystemEnv.getHtmlLabelName(1925,user.getLanguage());
				}else if(beforeendtype == 1){
					endTimeType = SystemEnv.getHtmlLabelName(391,user.getLanguage());
				}else{
					endTimeType = SystemEnv.getHtmlLabelName(15049,user.getLanguage());
				}
			%>
			<TR>
				<TD><%=SystemEnv.getHtmlLabelName(18713, user.getLanguage())%></TD>
				<TD class="Field">
					<INPUT type="radio" value="0" name="remindtype" id="remindtype" onclick="showRemindTime(this)" <%if (remindtype == 0) {%>checked<%}%>><%=SystemEnv.getHtmlLabelName(19782,user.getLanguage())%>
					<INPUT type="radio" value="1" name="remindtype" id="remindtype" onclick="showRemindTime(this)" <%if (remindtype == 1) {%>checked<%}%>><%=SystemEnv.getHtmlLabelName(17586,user.getLanguage())%>
					<INPUT type="radio" value="2" name="remindtype" id="remindtype" onclick="showRemindTime(this)" <%if (remindtype == 2) {%>checked<%}%>><%=SystemEnv.getHtmlLabelName(18845,user.getLanguage())%>
				</TD>
			</TR>
			<TR style='height: 1px;'>
				<TD class="Line2" colSpan="2"></TD>
			</TR>
			<!--��ʼǰ����-->
			<TR id="startTime" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD><%=SystemEnv.getHtmlLabelName(785, user.getLanguage())%></TD>
				<TD class="Field">
					<INPUT type="checkbox" name="beforestart" value="1" <% if(beforestart == 1) { %>checked<% } %>>
						<%=SystemEnv.getHtmlLabelName(19784,user.getLanguage())%>
						<INPUT class="InputStyle" type="input" name="beforestarttime" size=5 onKeyPress="ItemCount_KeyPress_self(event)" value="<%= beforestarttime%>" onChange="document.all('beforestart').checked=true">
						<select name="beforestarttype" id="beforestarttype" onChange="onChangeStartTimeType()" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
							<option value="0" <%if(beforestarttype == 0){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%></option>
							<option value="1" <%if(beforestarttype == 1){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%></option>
							<option value="2" <%if(beforestarttype == 2){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%></option>
						</select>
				</TD>
			</TR>
			<TR id="startTimeLine" style="height: 1px;display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD class="Line2" colSpan="2"></TD>
			</TR>
			<TR id="startTime2" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD><%=SystemEnv.getHtmlLabelName(18080, user.getLanguage())%></TD>
				<TD class="Field">
					<%=SystemEnv.getHtmlLabelName(21977, user.getLanguage())%>
					<INPUT class="InputStyle" type="input" name="beforestartper"  size=5 onKeyPress="ItemCount_KeyPress_self(event)" value="<%=beforestartper%>">
					<span id="beforestarttypespan" name="beforestarttypespan"><%=startTimeType%></span>
				</TD>
			</TR>
			<TR id="startTimeLine2" style="height: 1px;display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD class="Line2" colSpan="2"></TD>
			</TR>
			<!--����ǰ����-->
			<TR id="endTime" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD><%=SystemEnv.getHtmlLabelName(785, user.getLanguage())%></TD>
				<TD class="Field">
					<INPUT type="checkbox" name="beforeend" value="1" <% if(beforeend == 1) { %>checked<% } %>>
						<%=SystemEnv.getHtmlLabelName(19785,user.getLanguage())%>
						<INPUT class="InputStyle" type="input" name="beforeendtime" size=5 onKeyPress="ItemCount_KeyPress_self(event)" value="<%= beforeendtime%>"  onChange="document.all('beforeend').checked=true">
						<select name="beforeendtype" id="beforeendtype" onChange="onChangeEndTimeType()" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
							<option value="0" <%if(beforeendtype == 0){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%></option>
							<option value="1" <%if(beforeendtype == 1){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%></option>
							<option value="2" <%if(beforeendtype == 2){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%></option>
						</select>
				</TD>
			</TR>
			<TR id="endTimeLine" style="height: 1px;display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD class="Line2" colSpan="2"></TD>
			</TR>
			<TR id="endTime2" style="display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD><%=SystemEnv.getHtmlLabelName(18080, user.getLanguage())%></TD>
				<TD class="Field">
					<%=SystemEnv.getHtmlLabelName(21977, user.getLanguage())%>
					<INPUT class="InputStyle" type="input" name="beforeendper"  size=5 onKeyPress="ItemCount_KeyPress_self(event)" value="<%=beforeendper%>">
					<span id="beforeendtypespan" name="beforeendtypespan"><%=endTimeType%></span>
				</TD>
			</TR>
			<TR id="endTimeLine2" style="height: 1px;display:'<%if(remindtype == 0) {%>none<%}%>'">
				<TD class="Line2" colSpan="2"></TD>
			</TR>
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
</form>
<script language="javascript">

function OnSave(){
	checkPlanDays();
	//alert(document.all("needcheck").value);
	document.all("needcheck").value += "<%=checkStr%>";
	if(check_form(document.taskform, document.all("needcheck").value) && checkWorkPlanRemind()){
		document.taskform.action = "RequestOperation.jsp";
		document.taskform.operationType.value="save";
		showPrompt("<%=SystemEnv.getHtmlLabelName(22060, user.getLanguage())%>");
		//document.taskform.submit();
			doUpload();
		enableAllmenu();
	}else{
		document.all("needcheck").value = "wtid";
	} 
}

function OnSubmit(){
	document.all("needcheck").value += "<%=checkStr%>";
	if(check_form(document.taskform, document.all("needcheck").value) && checkWorkPlanRemind()){
		document.taskform.action = "RequestOperation.jsp";
		document.taskform.operationType.value="Submit";
		showPrompt("<%=SystemEnv.getHtmlLabelName(22061, user.getLanguage())%>");
		//document.taskform.submit();
			doUpload();
		enableAllmenu();
	}else{
		document.all("needcheck").value = "wtid";
	}
}


function doUpload(){
	jQuery(".uploadfield").each(function(){
		var oUploader=window[jQuery(this).attr("oUploaderIndex")];
		if(oUploader.getStats().files_queued != 0){ //�ж��Ƿ���Ҫ�ϴ�
	     	 oUploader.startUpload(); 
	    }
	});
	doSaveAfterAccUpload();
}
function afterChooseFile(uploaddiv,totalnumFiles){
	var ismand=jQuery(uploaddiv).attr("ismand");
	var field=jQuery(uploaddiv).attr("field");
	if(ismand=="1"){
	   if(totalnumFiles>0)
	      jQuery("#field"+field+"span").html("");
	   else
	      jQuery("#field"+field+"span").html("<IMG align=absMiddle src='/images/BacoError.gif'>");   
	}
}


function doSaveAfterAccUpload(){
	var isuploaded=true;
	jQuery(".uploadfield").each(function(){
		var oUploader=window[jQuery(this).attr("oUploaderIndex")];
		if(oUploader.getStats().files_queued != 0){ //�ж��ϴ��Ƿ����
	     	 isuploaded=false; 
	    }
	});
	if(isuploaded){
		document.taskform.submit();
	}
}








function checkPlanDays(){
	try{
		var planDays = document.getElementById("<%=planDays%>").value;
		try{
			var days = parseInt(planDays);
			if(days < 0){
				alert(document.getElementById("<%=planDays%>").getAttribute("temptitle")+"<%=SystemEnv.getHtmlLabelName(22065, user.getLanguage())%>");
				return false;
			}
		}catch(e){
			return false;
		}
		return true;
	}catch(e){
		return true;
	}
}


function showPrompt(content){
     var showTableDiv  = document.getElementById('_xTable');
     var message_table_Div = document.createElement("div")
     message_table_Div.id="message_table_Div";
     message_table_Div.className="xTable_message";
     showTableDiv.appendChild(message_table_Div);
     var message_table_Div  = document.getElementById("message_table_Div");
     message_table_Div.style.display="inline";
     message_table_Div.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_table_Div.style.position="absolute"
     //message_table_Div.style.posTop=pTop;
     //message_table_Div.style.posLeft=pLeft;
     message_table_Div.style.top = pTop;
     message_table_Div.style.left = pLeft;
     message_table_Div.style.zIndex=1002;
     var oIframe = document.createElement('iframe');
     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_table_Div.style.zIndex - 1;
     oIframe.style.width = parseInt(message_table_Div.offsetWidth);
     oIframe.style.height = parseInt(message_table_Div.offsetHeight);
     oIframe.style.display = 'block';
}
</script>
<script language="vbs">
sub onShowBrowser31(id,url,linkurl,type1,ismand)

	if type1= 2 or type1 = 19 then
	    objspan = "field"+id+"span"
	    objinput = "field"+id
		if type1 = 2 then
		  onFlownoShowDate objspan,objinput,ismand
        else
	      onWorkFlowShowTime objspan,objinput,ismand
		end if
	else
		if  type1 <> 152 and type1 <> 142 and type1 <> 135 and type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>56 and type1<>57 and type1<>65 and type1<>165 and type1<>166 and type1<>167 and type1<>168 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
			id1 = window.showModalDialog(url)
		else
            if type1=135 then
			tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?projectids="&tmpids)
			elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
			elseif type1=37 then
            tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?documentids="&tmpids)
            elseif type1=142 then
            tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?receiveUnitIds="&tmpids)
            elseif type1=165 or type1=166 or type1=167 or type1=168 then
            index=InStr(id,"_")
            if index>0 then
            tmpids=uescape("?isdetail=1&fieldid="& Mid(id,1,index-1)&"&resourceids="&document.all("field"+id).value)
            id1 = window.showModalDialog(url&tmpids)
            else
            tmpids=uescape("?fieldid="&id&"&resourceids="&document.all("field"+id).value)
            id1 = window.showModalDialog(url&tmpids)
            end if
            else
            tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
            end if
		end if
		if NOT isempty(id1) then
			if  type1 = 152 or type1 = 142 or type1 = 135 or type1 = 17 or type1 = 18 or type1=27 or type1=37 or type1=56 or type1=57 or type1=65 or type1=166 or type1=168 or type1=170 then
				if id1(0)<> ""  and id1(0)<> "0"  then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceidss = Mid(resourceids,2,len(resourceids))
					resourceids = Mid(resourceids,2,len(resourceids))

					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&" target='_new'>"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&" target='_new'>"&resourcename&"</a>&nbsp"
					document.all("field"+id+"span").innerHtml = sHtml
					document.all("field"+id).value= resourceidss
				else
					if ismand=0 then
						document.all("field"+id+"span").innerHtml = empty
					else
						document.all("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("field"+id).value=""
				end if

			else
			   if  id1(0)<>""  and id1(0)<> "0"  then
                   if type1=162 then
				     ids = id1(0)
					names = id1(1)
					descs = id1(2)
					sHtml = ""
					ids = Mid(ids,2,len(ids))
					document.all("field"+id).value= ids
					names = Mid(names,2,len(names))
					descs = Mid(descs,2,len(descs))
					while InStr(ids,",") <> 0
						curid = Mid(ids,1,InStr(ids,","))
						curname = Mid(names,1,InStr(names,",")-1)
						curdesc = Mid(descs,1,InStr(descs,",")-1)
						ids = Mid(ids,InStr(ids,",")+1,Len(ids))
						names = Mid(names,InStr(names,",")+1,Len(names))
						descs = Mid(descs,InStr(descs,",")+1,Len(descs))
						sHtml = sHtml&"<a title='"&curdesc&"' >"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a title='"&descs&"'>"&names&"</a>&nbsp"
					document.all("field"+id+"span").innerHtml = sHtml
					exit sub
				   end if
				   if type1=161 then
				     name = id1(1)
					desc = id1(2)
				    document.all("field"+id).value=id1(0)
					sHtml = "<a title='"&desc&"'>"&name&"</a>&nbsp"
					document.all("field"+id+"span").innerHtml = sHtml
					exit sub
				   end if
			        if linkurl = "" then
						document.all("field"+id+"span").innerHtml = id1(1)
					else
						document.all("field"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&" target='_new'>"&id1(1)&"</a>"
					end if
					document.all("field"+id).value=id1(0)

				else
					if ismand=0 then
						document.all("field"+id+"span").innerHtml = empty
					else
						document.all("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("field"+id).value=""
				end if
			end if
		end if
	end if
	onChangeCheckor(id)
end sub
</script>
<script language="javascript">
function onChangeCheckor(id){
	try{
		var ids = id.split("_");
		var fieldid = ids[0];
		var rowindex = ids[1];
		var fieldname1 = "field"+id;
		var fieldname2 = "<%=checkorField%>"+rowindex;
		if(fieldname1 == fieldname2){
			if(document.getElementById("<%=checkorField%>"+rowindex).value==null || document.getElementById("<%=checkorField%>"+rowindex).value==""){
				document.getElementById("<%=needcheckField%>"+rowindex).checked = false;
			}else{
				document.getElementById("<%=needcheckField%>"+rowindex).checked = true;
			}
		}
	}catch(e){}
}
function onShowPlanDateCompute(objinput, objspan, ismand){
	WdatePicker_onShowPlanDateCompute(objinput, objspan, ismand);
}
function WdatePicker_onShowPlanDateCompute(inputname, spanname, ismand){
	var returnvalue;
	var oncleaingFun = function(){
		  $dp.$(inputname).value = "";
			if(ismand == 1){
				$dp.$(spanname).innerHTML = "<img src='/images/BacoError.gif' align=absmiddle>";
			}else{
				$dp.$(spanname).innerHTML = "";
			}
			try{
				document.getElementById("<%=planDays%>").value = 0;
				try{
					if(document.getElementById("<%=planDays%>").type == "hidden"){
						document.getElementById("<%=planDays%>span").innerHTML = 0;
					}
				}catch(e){}
			}catch(e){}
	  }
	 WdatePicker({el:spanname,onpicked:function(dp){
		returnvalue = dp.cal.getDateStr();	
		$dp.$(spanname).innerHTML = returnvalue;
        $dp.$(inputname).value = returnvalue;
		try{
			var planStartDate = document.getElementById("<%=planStartDate%>").value;
			var planEndDate = document.getElementById("<%=planEndDate%>").value;
			<%if(canCreateHistoryWorktask == 0){%>
			try{
				if(planStartDate!=null && planStartDate!=""){
					if(planStartDate < "<%=currentDay%>"){
						alert(document.getElementById("<%=planStartDate%>").temptitle + "<%=SystemEnv.getHtmlLabelName(22269, user.getLanguage())+SystemEnv.getHtmlLabelName(15625, user.getLanguage())+SystemEnv.getHtmlLabelName(22270, user.getLanguage())%>");
						$dp.$(objinput).value = oldValue;
						$dp.$(objspan).innerHTML = oldinnerHTML;
						return false;
					}
				}
			}catch(e){
			}
		<%}%>
		try{
			if(planStartDate!=null && planStartDate!="" && planEndDate!=null && planEndDate!=""){
				if(planStartDate > planEndDate){
					alert(document.getElementById("<%=planEndDate%>").temptitle + "<%=SystemEnv.getHtmlLabelName(22269, user.getLanguage())%>" + document.getElementById("<%=planStartDate%>").temptitle + "<%=SystemEnv.getHtmlLabelName(22270, user.getLanguage())%>");
					$dp.$(objinput).value = oldValue;
					$dp.$(objspan).innerHTML = oldinnerHTML;
					return false;
				}
			}
		}catch(e){
		}
			if(planStartDate != null && planStartDate != "" && planEndDate != null && planEndDate != ""){
				var days = getnumber(planStartDate, planEndDate);
				//document.getElementById("<%=planDays%>").value = days;
				$GetEle("<%=planDays%>").value = days;
				try{
					if($GetEle("<%=planDays%>").type == "hidden"){
						//document.getElementById("<%=planDays%>span").innerHTML = days;
						$GetEle("<%=planDays%>span").innerHTML=days;
					}
				}catch(e){}
			}else{
				//document.getElementById("<%=planDays%>").value = 0;
				$GetEle("<%=planDays%>").value = 0;
				try{
					if($GetEle("<%=planDays%>").type == "hidden"){
						//document.getElementById("<%=planDays%>span").innerHTML = 0;
						$GetEle("<%=planDays%>span").innerHTML=0;
					}
				}catch(e){}
			}
		}catch(e){
			try{
				//document.getElementById("<%=planDays%>").value = 0;
				$GetEle("<%=planDays%>").value = 0;
				try{
					if($GetEle("<%=planDays%>").type== "hidden"){
						//document.getElementById("<%=planDays%>span").innerHTML = 0;
						$GetEle("<%=planDays%>span").innerHTML=0;
					}
				}catch(e){}
			}catch(e){}
		}
	},oncleared:oncleaingFun});

	//onShowFlowDate(spanname, inputname, ismand);
}
function ItemCount_KeyPress_self(event){
    event = event || window.event
	if(!((event.keyCode>=48) && (event.keyCode<=57))){
		event.keyCode=0;
	}
}

function showRemindTime(obj){
	//alert(document.all("remindTime").style);
	if("0" == obj.value){
		document.all("startTime").style.display = "none";
		document.all("startTimeLine").style.display = "none";
		document.all("startTime2").style.display = "none";
		document.all("startTimeLine2").style.display = "none";
		document.all("beforestarttype").style.display = "none";
		document.all("endTime").style.display = "none";
		document.all("endTimeLine").style.display = "none";
		document.all("endTime2").style.display = "none";
		document.all("endTimeLine2").style.display = "none";
		document.all("beforeendtype").style.display = "none";
	}else{
		document.all("startTime").style.display = "";
		document.all("startTimeLine").style.display = "";
		document.all("startTime2").style.display = "";
		document.all("startTimeLine2").style.display = "";
		document.all("beforestarttype").style.display = "";
		document.all("endTime").style.display = "";
		document.all("endTimeLine").style.display = "";
		document.all("endTime2").style.display = "";
		document.all("endTimeLine2").style.display = "";
		document.all("beforeendtype").style.display = "";
	}
}

function checkWorkPlanRemind(){
	//alert(document.taskform.remindtype);
	if(document.taskform.remindtype[0].checked == false){
		if(document.taskform.beforestart.checked || document.taskform.beforeend.checked){
			return true;
		}else{
			alert("<%=SystemEnv.getHtmlLabelName(21978, user.getLanguage())%>");
			return false;
		}
	}else{
		document.taskform.beforestart.checked = false;
		document.taskform.beforeend.checked = false;
		document.taskform.beforestarttime.value = 0;
		document.taskform.beforeendtime.value = 0;
		document.taskform.beforestartper.value = 0;
		document.taskform.beforeendper.value = 0;
		return true;
	}
}
function onChangeStartTimeType(){
	var timeTypeText = document.all("beforestarttype").options.item(document.all("beforestarttype").selectedIndex).innerText;
	document.getElementById("beforestarttypespan").innerHTML = timeTypeText;
}
function onChangeEndTimeType(){
	var timeTypeText = document.all("beforeendtype").options.item(document.all("beforeendtype").selectedIndex).innerText;
	document.getElementById("beforeendtypespan").innerHTML = timeTypeText;
}
function getnumber(date1,date2){
	//Ĭ�ϸ�ʽΪ"20030303",�����Լ���Ҫ�ĸ�ʽ�ͷ���
	var year1 =  date1.substr(0,4);
	var year2 =  date2.substr(0,4);

	var month1 = date1.substr(5,2);
	var month2 = date2.substr(5,2);

	var day1 = date1.substr(8,2);
	var day2 = date2.substr(8,2);

	temp1 = year1+"/"+month1+"/"+day1;
	temp2 = year2+"/"+month2+"/"+day2;

	var dateaa= new Date(temp1); 
	var datebb = new Date(temp2); 
	var date = datebb.getTime() - dateaa.getTime(); 
	var time = Math.floor(date / (1000 * 60 * 60 * 24)+1);
	return time;
	//alert(time);
}
function OnComeBack(){
	location.href="/worktask/request/ViewWorktask.jsp?requestid=<%=requestid%>";
}
//�������JS Start
function openDocExt(showid,versionid,docImagefileid,isedit){
	taskbody.onbeforeunload=null;
    
	if(isedit==1){
		openFullWindowHaveBar("/docs/docs/DocEditExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
	}else{
		openFullWindowHaveBar("/docs/docs/DocDspExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
	}
}

function openAccessory(fileId){ 
	taskbody.onbeforeunload=null;
	openFullWindowHaveBar("/weaver/weaver.file.FileDownload?fileid="+fileId+"&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
}
function accesoryChanage(obj){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        File.FilePath=objValue;
        fileLenth= File.getFileSize();
    } catch (e){
        //alert('<%=SystemEnv.getHtmlLabelName(20253,user.getLanguage())%>');
		if(e.message=="Type mismatch"||e.message=="���Ͳ�ƥ��"){
			alert("<%=SystemEnv.getHtmlLabelName(21015,user.getLanguage())%> ");
		}else{
			alert("<%=SystemEnv.getHtmlLabelName(21090,user.getLanguage())%> ");
		}
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1)
    if (fileLenthByM><%=maxUploadImageSize%>) {
        alert("<%=SystemEnv.getHtmlLabelName(20254,user.getLanguage())%>"+fileLenthByM+"M,<%=SystemEnv.getHtmlLabelName(20255,user.getLanguage())%><%=maxUploadImageSize%>M<%=SystemEnv.getHtmlLabelName(20256 ,user.getLanguage())%>");
        createAndRemoveObj(obj);
    }
}
  function addannexRow(accname,maxsize)
  {
    document.all(accname+'_num').value=parseInt(document.all(accname+'_num').value)+1;
    ncol = document.all(accname+'_tab').cols;
    oRow = document.all(accname+'_tab').insertRow();
    for(j=0; j<ncol; j++) {
      oCell = oRow.insertCell();
      oCell.style.height=24;
      switch(j) {
        case 1:
          var oDiv = document.createElement("div");
          var sHtml = "";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
        case 0:
          var oDiv = document.createElement("div");
          <%----- Modified by xwj for td3323 20051209  ------%>
          var sHtml = "<input class=InputStyle  type=file size=45 name='"+accname+"_"+document.all(accname+'_num').value+"' onchange='accesoryChanage(this)'> (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxsize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>) ";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
      }
    }
}
function createAndRemoveObj(obj){
    objName = obj.name;
    tempObjonchange=obj.onchange;
    outerHTML="<input name="+objName+" class=InputStyle type=file size=45 >";  
    document.getElementById(objName).outerHTML=outerHTML;       
    document.getElementById(objName).onchange=tempObjonchange;
}
function addDocReadTag(docId) {
	//user.getLogintype() ��ǰ�û�����  1: ����û�  2:�ⲿ�û�
	DocReadTagUtil.addDocReadTag(docId,<%=user.getUID()%>,<%=user.getLogintype()%>,"<%=request.getRemoteAddr()%>",returnTrue);

}
function openDocExt(showid,versionid,docImagefileid,isedit){
	taskbody.onbeforeunload=null;

	if(isedit==1){
		openFullWindowHaveBar("/docs/docs/DocEditExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
	}else{
		openFullWindowHaveBar("/docs/docs/DocDspExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
	}
}

function openAccessory(fileId){
	taskbody.onbeforeunload=null;
	openFullWindowHaveBar("/weaver/weaver.file.FileDownload?fileid="+fileId+"&requestid=<%=requestid%>&operatorid=<%=operatorid%>&fromworktask=1");
}
function returnTrue(o){
	return;
}
function downloads(files){
	taskbody.onbeforeunload=null;
	document.location.href="/weaver/weaver.file.FileDownload?fileid="+files+"&download=1";
}
 function onChangeSharetype(delspan,delid,ismand,maxUploadImageSize){
	fieldid=delid.substr(0,delid.indexOf("_")); 
	fieldidnum=fieldid+"_idnum_1";
	fieldidspan=fieldid+"span";
	fieldidspans=fieldid+"spans";
	fieldid=fieldid+"_1";
	 var sHtml = "<input class=InputStyle  type=file size=50 name="+fieldid+" onchange='accesoryChanage(this,"+maxUploadImageSize+")'> (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxUploadImageSize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>) ";
	 var sHtml1 = "<input class=InputStyle  type=file size=50 name="+fieldid+" onchange=\"accesoryChanage(this,"+maxUploadImageSize+");checkinput(\'"+fieldid+"\',\'"+fieldidspan+"\')\"> (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxUploadImageSize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>) ";

    if(document.all(delspan).style.visibility=='visible'){
      document.all(delspan).style.visibility='hidden';
      document.all(delid).value='0';
	  document.all(fieldidnum).value=parseInt(document.all(fieldidnum).value)+1;
    }else{
      document.all(delspan).style.visibility='visible';
      document.all(delid).value='1';
	  document.all(fieldidnum).value=parseInt(document.all(fieldidnum).value)-1;
    }
	//alert(document.all(fieldidnum).value);
	if (ismand=="1")
	  {
	  alert(fieldidnum);
	if (document.all(fieldidnum).value=="0")
	  {
	   alert(1);
	    document.all("needcheck").value=document.all("needcheck").value+","+fieldid;
		document.all(fieldidspan).innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
	     alert(fieldidspans);
		//document.all(fieldidspans).innerHTML=sHtml1;
	  }
	  else
	  {   if (document.all("needcheck").value.indexOf(","+fieldid)>0)
		  {
		  alert(2);
	     document.all("needcheck").value=document.all("needcheck").value.substr(0,document.all("needcheck").value.indexOf(","+fieldid));
		 document.all(fieldidspan).innerHTML="";
		 document.all(fieldidspans).innerHTML=sHtml;
		  }
	  }
	  }
  }
  //�������JS End
  
  function onShowBrowser3(id,url,linkurl,type1,ismand){
	if(type1==2||type1 ==19){
	    spanname = "field"+id+"span";
	    inputname = "field"+id;
		if(type1 ==2)
		  onFlownoShowDate(spanname,inputname,ismand);
        else
	      onWorkFlowShowTime(spanname,inputname,ismand);
	}else{
		if(type1!=152 && type1 !=142 && type1 != 135 && type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=165 && type1!=166 && type1!=167 && type1!=168 && type1!=4 && type1!=167 && type1!=164 && type1!=169 && type1!=170)
		{
			id1 = window.showModalDialog(url);
		}else{
            if(type1==135){
			    tmpids = document.all("field"+id).value;
			    id1 = window.showModalDialog(url+"?projectids="+tmpids)
			}else if(type1==4 || type1==167 || type1==164 || type1==169 || type1==170){
                tmpids = document.all("field"+id).value;
			    id1 = window.showModalDialog(url+"?selectedids="+tmpids);
			}else if(type1==37) {
            tmpids = document.all("field"+id).value;
			    id1 = window.showModalDialog(url+"?documentids="+tmpids);
            }else if (type1==142){
            tmpids = document.all("field"+id).value;
			    id1 = window.showModalDialog(url+"?receiveUnitIds="+tmpids);
            }else if( type1==165 || type1==166 || type1==167 || type1==168){
                //index=InStr(id,"_");
                index=id.indexOf("_");
	            if (index!=-1){
		            //Mid(id,1,index-1)
		            tmpids=uescape("?isdetail=1&fieldid="+substr(id,0,index-1)+"&resourceids="+document.all("field"+id).value)
		            id1 = window.showModalDialog(url+tmpids);
	            }else{
		            tmpids=uescape("?fieldid="+id+"&resourceids="+document.all("field"+id).value);
		            id1 = window.showModalDialog(url+tmpids);
	            }
            }else{
               tmpids = document.all("field"+id).value;
			   id1 = window.showModalDialog(url+"?resourceids="+tmpids);
			}
           }
		
		if(id1){
			if  (type1 == 152 || type1 == 142 || type1 == 135 || type1 == 17 || type1 == 18 || type1==27 || type1==37 || type1==56 || type1==57 || type1==65 || type1==166 || type1==168 || type1==170) 
			{
				if (id1.id!==""  && id1.id!=="0"){
					resourceids = id1.id;
					resourcename = id1.name;
					sHtml = "";
					resourceidss =resourceids.substr(1);
					resourceids = resourceids.substr(1);

					resourcename =resourcename.substr(1);
					
					ids=resourceids.split(",");
					names=resourcename.split(",");
					for(var i=0;i<ids.length;i++){
					   if(ids[i]!="")
					      sHtml = sHtml+"<a href="+linkurl+ids[i]+" target='_blank'>"+names[i]+"</a>&nbsp";
					}
					//$GetEle("field"+id+"span").innerHTML = sHtml;
					document.all("field"+id+"span").innerHTML = sHtml;
					document.all("field"+id).value= resourceidss;
				}else{
					if (ismand==0)
						document.all("field"+id+"span").innerHTML ="";
					else
						document.all("field"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					document.all("field"+id).value="";
				}
			}else{
			   if  (id1.id!=""  && id1.id!="0"){
                   if (type1==162){
				     ids = id1.id;
					names = id1.name;
					descs = wuiUtil.getJsonValueByIndex(id1,2);
					sHtml = "";
					ids =ids.substr(1);
					document.all("field"+id).value= ids;
					names =names.substr(1).split(",");
					descs =descs.substr(1).split(",");
					for(var i=0;i<names.length;i++){
					   sHtml = sHtml+"<a title='"+descs[i]+"' >"+names[i]+"</a>&nbsp";
					}
					document.all("field"+id+"span").innerHTML = sHtml;
					return;
				   }
				   if (type1==161){
				     name =wuiUtil.getJsonValueByIndex(id1,1);
					 desc = wuiUtil.getJsonValueByIndex(id1,2);
				     document.all("field"+id).value=wuiUtil.getJsonValueByIndex(id1,0);
					 sHtml = "<a title='"+desc+"'>"+name+"</a>&nbsp";
					 document.all("field"+id+"span").innerHTML = sHtml;
					 return;
				   }
			        if (linkurl == "") 
						document.all("field"+id+"span").innerHTML =wuiUtil.getJsonValueByIndex(id1,1);
					else
						document.all("field"+id+"span").innerHTML = "<a href="+linkurl+id1.id+" target='_blank'>"+id1.name+"</a>";
					document.all("field"+id).value=id1.id;

				}else{
					if (ismand==0)
						document.all("field"+id+"span").innerHTML ="";
					else
						document.all("field"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>"
					
					document.all("field"+id).value=""
				}
              }  			
		}
	 }	
	onChangeCheckor(id);
}
  
jQuery(document).ready(function(){
	jQuery(".uploadfield").each(function(){
		var fieldid=jQuery(this).attr("field");
		bindUploaderDiv(jQuery(this),"field"+fieldid+"_1"); 
	});
	jQuery(".progressCancel").live("click",function(){
		var uploaddiv=jQuery(this).parents(".uploadfield");
		var totalnumFiles=window[uploaddiv.attr("oUploaderIndex")].getStats().files_queued;
		afterChooseFile(uploaddiv,totalnumFiles);
	});
	jQuery(".btnCancel_upload").live("click",function(){
		var uploaddiv=jQuery(this).parents(".uploadfield");
		var totalnumFiles=window[uploaddiv.attr("oUploaderIndex")].getStats().files_queued;
		afterChooseFile(uploaddiv,totalnumFiles);
	});
});  

</script>


</BODY>
</HTML>
<SCRIPT language="javascript"  defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript"  src="/js/selectDateTime.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
