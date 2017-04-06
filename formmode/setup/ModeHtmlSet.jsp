<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="modeSetUtil" class="weaver.formmode.setup.ModeSetUtil" scope="page" />
<html>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<%
	if (!HrmUserVarify.checkUserRight("ModeSetting:All", user)) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
%>
<%
int modeId = Util.getIntValue(request.getParameter("modeId"), 0);
int formId = Util.getIntValue(request.getParameter("formId"), 0);
String modeName = "";
if(formId == 0)
	formId = modeSetUtil.getFormIdByModeId(modeId);
	
if(modeId > 0){
	rs.executeSql("select formId,modeName from modeinfo where id="+modeId);
	if(rs.next()){
		formId = Util.getIntValue(rs.getString("formId"),0);
		modeName = Util.null2String(rs.getString("modename"));
	}
}

modeSetUtil.initHtmlSource(modeId, formId);

int showhtmlid = modeSetUtil.getShowhtmlid();			//��ʾģ��
String showhtmlname = modeSetUtil.getShowhtmlname();

int addhtmlid = modeSetUtil.getAddhtmlid();				//�½�ģ��
String addhtmlname = modeSetUtil.getAddhtmlname();

int edithtmlid = modeSetUtil.getEdithtmlid();			//�༭ģ��
String edithtmlname = modeSetUtil.getEdithtmlname();

int monitorhtmlid = modeSetUtil.getMonitorhtmlid();		//���ģ��
String monitorhtmlname = modeSetUtil.getMonitorhtmlname();

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(24666,user.getLanguage());
String needfav ="";
String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(modeId > 0){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<body>
<form id="modehtmlform" name="modehtmlform" method=post action="LayoutOperation.jsp" target="_self" method="post" >
<input type="hidden" name="operation" id="operation" value="EditModesHtml">
<input type="hidden" name="modeId" id="modeId" value="<%=modeId%>">
<input type="hidden" name="formId" id="formId" value="<%=formId%>">
<input type="hidden" name="modeName" id="modeName" value="<%=modeName%>">
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
			<COLGROUP>
			<COL width="20%">
			<COL width="80%">
			<TR class="Title"><Th colSpan=2><%=SystemEnv.getHtmlLabelName(16367,user.getLanguage())%></Th></TR>
			<TR class="Spacing" style="height:1px;"><TD class="Line1" colSpan=2></TD></TR>
			<tr><!-- ��ʾģ�� -->
				<td><%=SystemEnv.getHtmlLabelName(16450,user.getLanguage())%></td>
				<td class=field>
					<button type="button"  class=AddDoc onclick="onShowModeBrowser('showhtmlid','showhtmlspan',0)" ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
					<button type="button"  class=AddDoc onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=0&modeId=<%=modeId%>&formId=<%=formId%>')" ><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
					<span id="showhtmlspan"><a href="#" onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=0&modeId=<%=modeId%>&formId=<%=formId%>&Id=<%=showhtmlid%>')"><%=showhtmlname%></a></span>
					<input type="hidden" id="showhtmlid" name="showhtmlid" value="<%=showhtmlid%>">
					<input type="hidden" id="showhtmltype" name="showhtmltype" value="0">
				</td>
			</tr>
			<TR class="Spacing" style="height:1px;"><TD class="Line" colSpan=2></TD></TR>
			<tr><!-- �½�ģ�� -->
				<td><%=SystemEnv.getHtmlLabelName(16388,user.getLanguage())%></td>
				<td class=field>
					<button type="button"  class=AddDoc onclick="onShowModeBrowser('addhtmlid','addhtmlspan',1)" ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
					<button type="button"  class=AddDoc onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=1&modeId=<%=modeId%>&formId=<%=formId%>')" ><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
					<span id="addhtmlspan"><a href="#" onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=1&modeId=<%=modeId%>&formId=<%=formId%>&Id=<%=addhtmlid%>')"><%=addhtmlname%></a></span>
					<input type="hidden" id="addhtmlid" name="addhtmlid" value="<%=addhtmlid%>">
					<input type="hidden" id="addhtmltype" name="addhtmltype" value="1">
				</td>
			</tr>
			<TR class="Spacing" style="height:1px;"><TD class="Line" colSpan=2></TD></TR>  
			<tr><!-- �༭ģ�� -->
				<td><%=SystemEnv.getHtmlLabelName(16449,user.getLanguage())%></td>
				<td class=field>
					<button type="button"  class=AddDoc onclick="onShowModeBrowser('edithtmlid','edithtmlspan',2)" ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
					<button type="button"  class=AddDoc onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=2&modeId=<%=modeId%>&formId=<%=formId%>')" ><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
					<span id="edithtmlspan"><a href="#" onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=2&modeId=<%=modeId%>&formId=<%=formId%>&Id=<%=edithtmlid%>')"><%=edithtmlname%></a></span>
					<input type="hidden" id="edithtmlid" name="edithtmlid" value="<%=edithtmlid%>">
					<input type="hidden" id="edithtmltype" name="edithtmltype" value="2">
				</td>
			</tr>
			<TR class="Spacing" style="height:1px;"><TD class="Line" colSpan=2></TD></TR>  
			<tr><!-- ���ģ�� -->
				<td><%=SystemEnv.getHtmlLabelName(665,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(64,user.getLanguage())%></td>
				<td class=field>
					<button type="button"  class=AddDoc onclick="onShowModeBrowser('monitorhtmlid','monitorhtmlspan',3)" ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
					<button type="button"  class=AddDoc onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=3&modeId=<%=modeId%>&formId=<%=formId%>')" ><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
					<span id="monitorhtmlspan"><a href="#" onclick="openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type=3&modeId=<%=modeId%>&formId=<%=formId%>&Id=<%=monitorhtmlid%>')"><%=monitorhtmlname%></a></span>
					<input type="hidden" id="monitorhtmlid" name="monitorhtmlid" value="<%=monitorhtmlid%>">
					<input type="hidden" id="monitorhtmltype" name="monitorhtmltype" value="1">
				</td>
			</tr>
			<TR class="Spacing" style="height:1px;"><TD class="Line1" colSpan=2></TD></TR>
		</table>
	 </td>
  	 </tr>
  	</TABLE>
   </td>
   <td></td>
  </tr>
 </table>
</tr>
</table>
<form id="nodefieldform" name="nodefieldform" method=post action="wf_operation.jsp" >
</body>
<script language="javascript">
$(document).ready(function(){//onload�¼�
	$(".loading", window.parent.document).hide(); //���ؼ���ͼƬ
	if($("#modeId").val()=='0'){
		if(confirm("���ȱ��������Ϣ��")){
			window.parent.document.getElementById('modeBasicTab').click();
		}else{
			$('.AddDoc').attr('disabled','disabled');
		}
	}
})
function onShowModeBrowser(ids,spans,type){
	urls = "/formmode/setup/FormModeHtmlBrowser.jsp?modeId=<%=modeId%>&formId=<%=formId%>";
	urls = "/systeminfo/BrowserMain.jsp?url="+escape(urls);
	
	datas = window.showModalDialog(urls);
	if (datas != undefined && datas != null) {
		if(datas.id!=""){
			jQuery("#"+ids).val(datas.modeId);
			jQuery("#"+spans).html("<a href=\"#\" onclick=\"openFullWindowHaveBar('/formmode/setup/LayoutEdit.jsp?type="+type+"&modeId=<%=modeId%>&formId=<%=formId%>&Id=<%=showhtmlid%>')\">"+datas.modeName+"</a>");
		}else{
			jQuery("#"+ids).val("");
			jQuery("#"+spans).html("");
		}
	}
}

function submitData(){
	enableAllmenu();
	$(".loading", window.parent.document).show(); 
	modehtmlform.submit();
}
</script>
</html>