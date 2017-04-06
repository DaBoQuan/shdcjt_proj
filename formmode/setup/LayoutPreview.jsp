<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="weaver.formmode.interfaces.ModeManageMenu" %>
<%@page import="weaver.formmode.view.ResolveFormMode"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResolveFormMode" class="weaver.formmode.view.ResolveFormMode" scope="page" />
<jsp:useBean id="ModeRightInfo" class="weaver.formmode.setup.ModeRightInfo" scope="page" />
<jsp:useBean id="ModeShareManager" class="weaver.formmode.view.ModeShareManager" scope="page" />

<%
int modeId = Util.getIntValue(request.getParameter("modeId"),0);
int formId = Util.getIntValue(request.getParameter("formId"),0);
int type = Util.getIntValue(request.getParameter("type"),0);
int billid = Util.getIntValue(request.getParameter("billid"),0);
String editData = Util.null2String(request.getParameter("editData"));//��Ϊ�ձ�ʾ�����½���༭��������ֱ༭��ť
int isfromTab = Util.getIntValue(request.getParameter("isfromTab"),0);
int fromSave = Util.getIntValue(request.getParameter("fromSave"),0);
String iscreate = Util.null2String(request.getParameter("iscreate"));

ModeRightInfo.setModeId(modeId);
ModeRightInfo.setType(type);
ModeRightInfo.setUser(user);
boolean isRight = false;
boolean isEdit = false;		//�Ƿ��б༭Ȩ�ޣ���Ҫ����Ҽ���ť�Ƿ���ʾ
boolean isDel = false;		//�Ƿ���ɾ��Ȩ�ޣ���Ҫ����Ҽ���ť�Ƿ���ʾ
ModeShareManager.setModeId(modeId);

boolean haveTab = false;//��Ҫ��tabҳ
String sql = "";

HashMap parentTabValueMap = new HashMap();
if(formId!=0){
	sql = "select id,fieldname from workflow_billfield where viewtype=0 and billid = " + formId;
	rs.executeSql(sql);
	while(rs.next()){
		String id = Util.null2String(rs.getString("id"));
		String fieldid = "field"+id;
		String fieldname = Util.null2String(rs.getString("fieldname"));
		String fieldvalue = Util.null2String(request.getParameter("field"+id));
		if(!fieldvalue.equals("")){
			//System.out.println(fieldname+"	"+fieldid+"	"+fieldvalue);
			parentTabValueMap.put(id,fieldvalue);
		}
	}
}


String custompage = "";
String modename = "";
String isImportDetail = "";
if(modeId > 0 ){
	rs.executeSql("select * from modeinfo where id="+modeId);
	if(rs.next()){
		if(type==1){
			isImportDetail = Util.null2String(rs.getString("isImportDetail"));
		}
		modename = Util.null2String(rs.getString("modename"));
		custompage = Util.null2String(rs.getString("custompage"));
	}
}
String titles = "";
String status = "";
switch(type){
	case 1:
		status = SystemEnv.getHtmlLabelName(82,user.getLanguage());
		break;
	case 2:
		status = SystemEnv.getHtmlLabelName(93,user.getLanguage());
		break;
	case 3:
		status = SystemEnv.getHtmlLabelName(665,user.getLanguage());
		break;
}
if (!status.equals("")) {
	titles = modename +": "+status;
} else {
	titles = modename;
	status = SystemEnv.getHtmlLabelName(89,user.getLanguage());
}
String imagefilename = "/images/hdMaintenance.gif";
String titlename = titles;
String needfav ="";
String needhelp ="";

%>
<html>
<head>
<meta>
<title><%=modename %></title>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/formmode/js/AddMode.js"></script>
<SCRIPT language="javascript" src="/workflow/request/js/requesthtml.js"></script>
<!--<script type="text/javascript" language="javascript" src="/FCKEditor/fckeditor.js"></script>-->
<!--<script type="text/javascript" language="javascript" src="/FCKEditor/FCKEditorExt.js"></script>-->
<script type="text/javascript" src="/wui/common/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/wui/common/js/ckeditor/ckeditorFormmode.js"></script>

<link href="/js/swfupload/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogressBywf.js"></script>
<script type="text/javascript" src="/js/swfupload/handlersBywf.js"></script>
<script type='text/javascript' src='/dwr/interface/DocReadTagUtil.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/util.js'></script>
<script type="text/javascript" language="javascript" src="/formmode/js/jquery.js"></script>
</head>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<form action="" name=frmmain id=frmmain>
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
<%
ResolveFormMode.setRequest(request);
ResolveFormMode.setUser(user);
ResolveFormMode.setIscreate(type);
ResolveFormMode.setRelateFieldMap(parentTabValueMap);
Hashtable ret_hs = ResolveFormMode.analyzeLayout();
String hasHtmlMode = (String)ret_hs.get("hasHtmlMode");
if(hasHtmlMode.equals("0")){
%>
<script type="text/javascript">
alert("δ���� <%=(modename+" "+status)%>ģ�壡");
</script>
<%
}
String formhtml = Util.null2String((String)ret_hs.get("formhtml"));
out.print(formhtml);
//System.out.println(formhtml);
StringBuffer jsStr = ResolveFormMode.getJsStr();
StringBuffer htmlHiddenElementsb = ResolveFormMode.getHtmlHiddenElementsb();
out.println(htmlHiddenElementsb.toString());//��hidden��input�����ҳ����
//System.out.println(htmlHiddenElementsb.toString());
String needcheck = ResolveFormMode.getNeedcheck();

ResolveFormMode rfm = new ResolveFormMode();
rfm.setModeId(modeId);
rfm.setType(type);
String src = type == 1?"submit":"save";
String trrigerfield = rfm.GetEntryTriggerFieldName();
String trrigerdetailfield = rfm.GetEntryTriggerDetailFieldName();

int detailsum=0;
%>
<input type=hidden name ="needcheck" id="needcheck" value="<%=needcheck%>">
<input type=hidden name=src id="src" value="<%=src %>">
<input type=hidden name=formid id="formid" value="<%=formId %>">
<input type=hidden name=iscreate id="iscreate" value="<%=type%>">
<input type=hidden name=formmodeid id="formmodeid" value="<%=modeId%>">
<input type=hidden name=billid id="billid" value="<%=billid%>">
<input type=hidden name ="inputcheck" id="inputcheck" value="">
<input type=hidden name=fromImportDetail id="fromImportDetail" value="0">
<input type=hidden name="pageexpandid" id="pageexpandid" value="">

<input type=hidden name=isfromTab id="isfromTab" value="<%=isfromTab%>">

<iframe id="selectChangeDetail" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="selectChange" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="datainputformdetail" frameborder=0 scrolling=no src=""  style="display:none" ></iframe>

<!-- �Զ���ҳ�� -->
<%
	if(!custompage.equals("")){
%>
		<jsp:include page="<%=custompage%>" flush="true">
			<jsp:param name="type" value="<%=type%>" />
			<jsp:param name="formmodeid" value="<%=modeId%>" />
			<jsp:param name="billid" value="<%=billid%>" />
			<jsp:param name="formid" value="<%=formId%>" />
		</jsp:include>
<%		
	}
%>

	  </td>
  	 </tr>
  	</TABLE>
   </td>
   <td></td>
  </tr>
 </table>
</tr>
</table>
</form>
<script type="text/javascript">
function initFieldValue(fieldid){

}
<%
out.println(jsStr.toString());
%>
function doSqlFieldAjax(obj,fieldids){

}
function doFieldAjax(thisfieldid,fieldidtmp,fieldExt){

}

function doFieldDateAjax(para, fieldidtmp, fieldExt){

}

function doCustomFunction(detailid,issystemflag){

}

function windowOpenOnSelf(detailid,issystemflag){
   
}
//ִ�нӿڶ���
function doInterfacesAction(detailid,issystemflag){

}

function windowOpenOnNew(detailid,issystemflag){

}

function toDel(detailid,issystemflag){

}
function toEdit(detailid,issystemflag){

}
function doBack(){

}
function doShare(){

}
function doImportDetail() {

}

function returnTrue(o){
	return;
}

function addDocReadTag(docId) {
	
}

function openAccessory(fileId){ 
	
}

function openDocExt(showid,versionid,docImagefileid,isedit){
	
}

function changeChildField(obj, fieldid, childfieldid){

}

function changeChildFieldDetail(obj, fieldid, childfieldid, rownum){

}

function doInitChildSelect(fieldid,pFieldid,finalvalue){

}
function doInitDetailchildSelect(fieldid,pFieldid,rownum,childvalue){

}
function doInitDetailchildSelectAdd(fieldid,pFieldid,rownum,childvalue){

}
function checkModeNumFun() {//����������ϸ

}
/*	
 *	�������û��Զ��������ݣ��������ύ���߱����ʱ��ִ�иú�����
 *	������ͨ������true�����򷵻�false
 *	�û���ʹ��htmlģ���ʱ��ͨ����д������������ﵽ����������ݵ�����
 */
function checkCustomize(){

}

function doSubmit(detailid,issystemflag){

}
function onShowBrowser3(id,url,linkurl,type1,ismand) {

}
function onShowBrowser2(id,url,linkurl,type1,ismand, funFlag) {

}
//��������
function changeshowattr(fieldid,fieldvalue,rownum,workflowid,nodeid){

}

//����Ϊֻ��
function setReadOnly(obj){

}
//����Ϊֻ��
function setCanEdit(obj){

}

function onShowResourceRole(id, url, linkurl, type1, ismand, roleid) {

}

function onShowResourceConditionBrowser(id, url, linkurl, type1, ismand) {

}

function doTriggerInit(){

}
function datainput(parfield){				//�ֶ�����-���ֶ�

}

function datainputd(parfield){				//��ϸ

}

function hideRightClickMenu1(){	

}
function getNumber(index){

}

function onChangeSharetype(delspan,delid,ismand,Uploadobj){

}
document.body.onclick = hideRightClickMenu1;
</script>
<script type="text/javascript" src="/js/swfupload/workflowswfupload.js"></script>
<script language=javascript src="/js/checkData.js"></script>

<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<script type="text/javascript" src="/js/selectDateTime.js"></script>
</body>
</html>