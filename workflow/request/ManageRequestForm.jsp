<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.rtx.RTXConfig" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSet3" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="WfFunctionManageUtil" class="weaver.workflow.workflow.WfFunctionManageUtil" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<%
String newfromdate="a";
String newenddate="b";

int salesMessage = Util.getIntValue(request.getParameter("salesMessage"),-1);
int requestid = Util.getIntValue(request.getParameter("requestid"),0);
String message = Util.null2String(request.getParameter("message"));  // ���صĴ�����Ϣ
String requestname="";      //��������
String requestlevel="";     //������Ҫ���� 0:���� 1:��Ҫ 2:����
String requestmark = "" ;   //������
String isbill="0";          //�Ƿ񵥾� 0:�� 1:��
int creater=0;              //����Ĵ�����
int creatertype = 0;        //���������� 0: �ڲ��û� 1: �ⲿ�û�
int deleted=0;              //�����Ƿ�ɾ��  1:�� 0�������� ��
int billid=0 ;              //����ǵ���,��Ӧ�ĵ��ݱ��id

int workflowid=0;           //������id
String workflowtype = "" ;  //����������
int formid=0;               //�����ߵ��ݵ�id
int helpdocid = 0;          //�����ĵ� id
int nodeid=0;               //�ڵ�id
String nodetype="";         //�ڵ�����  0:���� 1:���� 2:ʵ�� 3:�鵵
String workflowname = "" ;          //����������
String isreopen="";                 //�Ƿ�����ش�
String isreject="";                 //�Ƿ�����˻�
int isremark = -1 ;              //��ǰ����״̬  modify by xhheng @ 20041217 for TD 1291
String status = "" ;     //��ǰ�Ĳ�������
String needcheck="requestname";

String topage = Util.null2String(request.getParameter("topage")) ;        //���ص�ҳ��

// �������½��ĵ��Ĵ���
String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
// modify by xhheng @2004-12-16 FOR TD1421  
String newdocid = Util.null2String(request.getParameter("newdocid"));        // �½����ĵ�


// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
int usertype = 0;                           //�û��ڹ��������е����� 0: �ڲ� 1: �ⲿ
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());

if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;

String sql = "" ;
char flag = Util.getSeparator() ;

// ��ǰ�û����и������Ӧ����Ϣ isremarkΪ0Ϊ��ǰ������, isremarkΪ1Ϊ��ǰ��ת����,isremarkΪ2Ϊ�ɸ��ٲ鿴��
RecordSet.executeProc("workflow_currentoperator_SByUs",userid+""+flag+usertype+flag+requestid+"");
while(RecordSet.next())	{
    int tempisremark = Util.getIntValue(RecordSet.getString("isremark"),0) ;
    if( tempisremark == 0 ) {                       // ��ǰ�����߻�ת����
        isremark = tempisremark ;
        break ;
    }
    if( tempisremark == 1 ) isremark = tempisremark ;
}
if( isremark != 0 && isremark != 1 ) {
    response.sendRedirect("/notice/noright.jsp");
    return;
}

// ��ѯ�������ع�����������Ϣ
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
if(RecordSet.next()){
    status = Util.null2String(RecordSet.getString("status")) ;
    requestname= Util.null2String(RecordSet.getString("requestname")) ;
	requestlevel = Util.null2String(RecordSet.getString("requestlevel"));
    requestmark = Util.null2String(RecordSet.getString("requestmark")) ;
    creater = Util.getIntValue(RecordSet.getString("creater"),0);
	creatertype = Util.getIntValue(RecordSet.getString("creatertype"),0);
    deleted = Util.getIntValue(RecordSet.getString("deleted"),0);
	workflowid = Util.getIntValue(RecordSet.getString("workflowid"),0);
	nodeid = Util.getIntValue(RecordSet.getString("currentnodeid"),0);
	nodetype = Util.null2String(RecordSet.getString("currentnodetype"));
    workflowname = WorkflowComInfo.getWorkflowname(workflowid+"");
    workflowtype = WorkflowComInfo.getWorkflowtype(workflowid+"");
}


RecordSet.executeProc("workflow_Nodebase_SelectByID",nodeid+"");
if(RecordSet.next()){
	isreopen=RecordSet.getString("isreopen");
	isreject=RecordSet.getString("isreject");
}

RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid+"");
if(RecordSet.next()){
	formid = Util.getIntValue(RecordSet.getString("formid"),0);
	isbill = ""+Util.getIntValue(RecordSet.getString("isbill"),0);
	helpdocid = Util.getIntValue(RecordSet.getString("helpdocid"),0);
}

if( isbill.equals("1") ) {
    RecordSet.executeProc("workflow_form_SByRequestid",requestid+"");
    RecordSet.next();
    formid = Util.getIntValue(RecordSet.getString("billformid"),0);
    billid= Util.getIntValue(RecordSet.getString("billid"));
}

// ��¼�鿴��־
String clientip = request.getRemoteAddr();
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String currenttime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                     Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                     Util.add0(today.get(Calendar.SECOND), 2) ;


/*--  xwj for td2104 on 20050802 begin  --*/
boolean isOldWf = false;
RecordSet3.executeSql("select nodeid from workflow_currentoperator where requestid = " + requestid);
while(RecordSet3.next()){
	if(RecordSet3.getString("nodeid") == null || "".equals(RecordSet3.getString("nodeid")) || "-1".equals(RecordSet3.getString("nodeid"))){
			isOldWf = true;
	}
}
if(isOldWf){//������ , ��� td2104 ��ǰ
System.out.println("old_11");
RecordSet.executeProc("workflow_RequestViewLog_Insert",requestid+"" + flag + userid+"" + flag + currentdate +flag + currenttime + flag + clientip + flag + usertype +flag + nodeid + flag + "9" + flag + -1);
//������û���κεط�ʹ����ordertype='-1'�����������Դ˴�ֱ�Ӱ�-1�ĳ�9 by ben 2006-05-24 for TD4396
}
else{
System.out.println("new_11");
int showorder = 10000;
String orderType = ""; 
RecordSet.executeSql("select agentorbyagentid, agenttype, showorder from workflow_currentoperator where userid = " + userid +
" and nodeid = " + nodeid + " and requestid = " + requestid + " and isremark in ('0','1','4') and usertype = " + usertype);
if(RecordSet.next()){ 
  orderType = "1"; // ��ǰ�ڵ������
  showorder  = RecordSet.getInt("showorder");
}
else{
orderType = "2";// �ǵ�ǰ�ڵ������
RecordSet2.executeSql("select max(showorder) from workflow_requestviewlog where id = " + requestid + "  and ordertype = '2' and currentnodeid = " + nodeid);
RecordSet2.next();
if(RecordSet2.getInt(1) != -1){ 
showorder = RecordSet2.getInt(1) + 1;
}
}
RecordSet.executeProc("workflow_RequestViewLog_Insert",requestid+"" + flag + userid+"" + flag + currentdate +flag + currenttime + flag + clientip + flag + usertype + flag + nodeid + flag + orderType + flag + showorder);
}
/*--  xwj for td2104 on 20050802 end  --*/



if(! nodetype.equals("3") )
    RecordSet.executeProc("SysRemindInfo_DeleteHasnewwf",""+userid+flag+usertype+flag+requestid);
else
    RecordSet.executeProc("SysRemindInfo_DeleteHasendwf",""+userid+flag+usertype+flag+requestid);

String imagefilename = "/images/hdReport.gif";
String titlename =  SystemEnv.getHtmlLabelName(648,user.getLanguage())+":"
	                +SystemEnv.getHtmlLabelName(553,user.getLanguage())+" - "+Util.toScreen(workflowname,user.getLanguage())+ " - " + status + " "+requestmark;//Modify by ����� 2004-10-26 For TD1231
String needfav ="1";
String needhelp ="";
//if(helpdocid !=0 ) {titlename=titlename + "<img src=/images/help.gif style=\"CURSOR:hand\" width=12 onclick=\"location.href='/docs/docs/DocDsp.jsp?id="+helpdocid+"'\">";}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">
<script language=javascript src="/js/weaver.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<SCRIPT language=VBS>

Sub oc_CurrentMenuOnMouseOut(icount)
    document.getElementById("oc_divMenuDivision"&icount).style.visibility = "hidden"
End Sub

Sub oc_CurrentMenuOnClick(icount)
    document.getElementById("oc_divMenuDivision"&icount).style.visibility = ""
End Sub
</SCRIPT>

<script language="javascript">
var isfirst = 0 ;

function displaydiv()
{
    if(oDiv.style.display == ""){
        oDiv.style.display = "none";
        spanimage.innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
    }
    else{
        if(isfirst == 0) {
            document.getElementById("picframe").src="/workflow/request/WorkflowRequestPicture.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>";

            isfirst ++ ;
        }

        spanimage.innerHTML = "<img src='/images/ArrowUpGreen.gif' border=0>" ;
        oDiv.style.display = "";
    }
}
</SCRIPT>


<body  id="flowbody">
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%//TD9145
String submitname = "" ; // �ύ��ť������ : ����, ����, ʵ��
String forwardName = "";//ת��
String saveName = "";//����
String rejectName = "";//�˻�
String forsubName = "";//ת���ύ
String ccsubName = "";//�����ύ
String newWFName = "";//�½����̰�ť
String newSMSName = "";//�½����Ű�ť
String haswfrm = "";//�Ƿ�ʹ���½����̰�ť
String hassmsrm = "";//�Ƿ�ʹ���½����Ű�ť
int t_workflowid = 0;//�½����̵�ID
String sqlselectName = "select * from workflow_nodecustomrcmenu where wfid="+workflowid+" and nodeid="+nodeid;
if(isremark != 0){
	RecordSet.executeSql("select nodeid from workflow_currentoperator c where c.requestid="+requestid+" and c.userid="+userid+" and c.usertype="+usertype+" and c.isremark='"+isremark+"' ");
	int tmpnodeid = 0;
	if(RecordSet.next()){
		tmpnodeid=Util.getIntValue(RecordSet.getString("nodeid"), 0);
	}
	sqlselectName = "select * from workflow_nodecustomrcmenu where wfid="+workflowid+" and nodeid="+tmpnodeid;
}

RecordSet.executeSql(sqlselectName);

if(RecordSet.next()){
	if(user.getLanguage() == 7){
		submitname = Util.null2String(RecordSet.getString("submitname7"));
		forwardName = Util.null2String(RecordSet.getString("forwardName7"));
		saveName = Util.null2String(RecordSet.getString("saveName7"));
		rejectName = Util.null2String(RecordSet.getString("rejectName7"));
		forsubName = Util.null2String(RecordSet.getString("forsubName7"));
		ccsubName = Util.null2String(RecordSet.getString("ccsubName7"));
		newWFName = Util.null2String(RecordSet.getString("newWFName7"));
		newSMSName = Util.null2String(RecordSet.getString("newSMSName7"));
	}
	else if(user.getLanguage() == 9){
		submitname = Util.null2String(RecordSet.getString("submitname9"));
		forwardName = Util.null2String(RecordSet.getString("forwardName9"));
		saveName = Util.null2String(RecordSet.getString("saveName9"));
		rejectName = Util.null2String(RecordSet.getString("rejectName9"));
		forsubName = Util.null2String(RecordSet.getString("forsubName9"));
		ccsubName = Util.null2String(RecordSet.getString("ccsubName9"));
		newWFName = Util.null2String(RecordSet.getString("newWFName9"));
		newSMSName = Util.null2String(RecordSet.getString("newSMSName9"));
	}
	else{
		submitname = Util.null2String(RecordSet.getString("submitname8"));
		forwardName = Util.null2String(RecordSet.getString("forwardName8"));
		saveName = Util.null2String(RecordSet.getString("saveName8"));
		rejectName = Util.null2String(RecordSet.getString("rejectName8"));
		forsubName = Util.null2String(RecordSet.getString("forsubName8"));
		ccsubName = Util.null2String(RecordSet.getString("ccsubName8"));
		newWFName = Util.null2String(RecordSet.getString("newWFName8"));
		newSMSName = Util.null2String(RecordSet.getString("newSMSName8"));
	}
	haswfrm = Util.null2String(RecordSet.getString("haswfrm"));
	hassmsrm = Util.null2String(RecordSet.getString("hassmsrm"));
	t_workflowid = Util.getIntValue(RecordSet.getString("workflowid"), 0);
}
if(isremark == 1){
	submitname = forsubName;
}
if(isremark == 9){
	submitname = ccsubName;
}
if("".equals(forwardName)){
	forwardName = SystemEnv.getHtmlLabelName(6011,user.getLanguage());
}
if("".equals(saveName)){
	saveName = SystemEnv.getHtmlLabelName(86,user.getLanguage());
}
if("".equals(rejectName)){
	rejectName = SystemEnv.getHtmlLabelName(236,user.getLanguage());
}
if("".equals(submitname)){
	if(nodetype.equals("0") || isremark == 1 )	{
		submitname = SystemEnv.getHtmlLabelName(615,user.getLanguage());      // �����ڵ����ת��, Ϊ�ύ
	}else if(nodetype.equals("1")){
		submitname = SystemEnv.getHtmlLabelName(142,user.getLanguage());  // ����
	}else if(nodetype.equals("2")){
		submitname = SystemEnv.getHtmlLabelName(725,user.getLanguage());  // ʵ��
	}
}

%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<% if(isremark == 1){ 

RCMenu += "{"+submitname+",javascript:doRemark(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;

} else { 

RCMenu += "{"+submitname+",javascript:doSubmit(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+forwardName+",Remark.jsp?requestid="+requestid+",_self}" ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+saveName+",javascript:doSave(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;

  if(isreopen.equals("1") && false ){

RCMenu += "{"+SystemEnv.getHtmlLabelName(244,user.getLanguage())+",javascript:doReopen(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
  }
  if( isreject.equals("1") ){

RCMenu += "{"+rejectName+",javascript:doReject(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
  }
  if(nodetype.equals("0") &&isremark != 1 && isremark != 9 && isremark != 5&&WfFunctionManageUtil.IsShowDelButtonByReject(requestid,workflowid)){    // �����ڵ�(�˻ش����ڵ�Ҳ��) 

RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
  }
}
/*TD9145 START*/
if("1".equals(haswfrm)){
	if("".equals(newWFName)){
		newWFName = SystemEnv.getHtmlLabelName(1239,user.getLanguage());
	}
	RequestCheckUser.setUserid(userid);
	RequestCheckUser.setWorkflowid(t_workflowid);
	RequestCheckUser.setLogintype(logintype);
	RequestCheckUser.checkUser();
	int  t_hasright=RequestCheckUser.getHasright();
	if(t_hasright == 1){
		RCMenu += "{"+newWFName+",javascript:onNewRequest("+t_workflowid+", "+requestid+",0),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
	}
}
RTXConfig rtxconfig = new RTXConfig();
String temV = rtxconfig.getPorp(rtxconfig.CUR_SMS_SERVER_IS_VALID);
boolean valid = false;
if (temV != null && temV.equalsIgnoreCase("true")) {
	valid = true;
} else {
	valid = false;
}
if(valid == true && "1".equals(hassmsrm) && HrmUserVarify.checkUserRight("CreateSMS:View", user)){
	if("".equals(newSMSName)){
		newSMSName = SystemEnv.getHtmlLabelName(16444,user.getLanguage());
	}
	RCMenu += "{"+newSMSName+",javascript:onNewSms("+workflowid+", "+nodeid+", "+requestid+"),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
/*TD9145 END*/
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",RequestView.jsp,_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

    <table width="100%">
        <tr><td width="80%" align=left>
        <% if( message.equals("1") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(16332,user.getLanguage())%></font>
        <% } else if( message.equals("2") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(16333,user.getLanguage())%></font>
		<%}%>
		<font color=red><%=Util.null2String(SystemEnv.getHtmlLabelName(salesMessage,user.getLanguage()))%></font>
        </td>
        <td width="20%" align=right>
        <% if(helpdocid !=0 ) {%>
        <img src="/images/help.gif" style="CURSOR:hand" width=12 onclick="showWFHelp(<%=helpdocid%>)">
        <%}%>
        <a href="#" onClick="displaydiv()">
            <SPAN id=spanimage><img src="/images/ArrowDownRed.gif" border=0></span>
        </a>
        </td></tr>
    </table>

<div  id=oDiv style="display:none"  width="100%">
<TABLE border=0 cellpadding=0 cellspacing=0 width="100%"><TR><TD ID='IMAGETD'></TD></TR></TABLE>
<BR>
</div>

<DIV>
<iframe ID="picframe" BORDER=0 FRAMEBORDER=no height="0%" width="0%" scrolling="NO" src=""></iframe>
</DIV>


<%
String managepage= "";
String operationpage = "" ;
if(isbill.equals("1")){
    RecordSet.executeProc("bill_includepages_SelectByID",formid+"");
    if(RecordSet.next()) {
        managepage = Util.null2String(RecordSet.getString("managepage"));
        operationpage = Util.null2String(RecordSet.getString("operationpage"));
    }
}
if( !managepage.equals("")) {
%>
<jsp:include page="<%=managepage%>" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="requestmark" value="<%=requestmark%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="isreopen" value="<%=isreopen%>" />
    <jsp:param name="isreject" value="<%=isreject%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="docfileid" value="<%=docfileid%>" />
    <jsp:param name="newdocid" value="<%=newdocid%>" />
</jsp:include>
<%}else{
    if( operationpage.equals("") ) operationpage = "RequestOperation.jsp" ;
%>
<form name="frmmain" method="post" action="<%=operationpage%>">
    <%@ include file="WorkflowManageRequestFormBody.jsp" %>
    <%@ include file="WorkflowManageSign.jsp" %>
</form>
<%}%>
<!-- modify by xhheng @20050304 for TD 1691 -->
<a href='javascript:openSignPrint();'><%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%></a>
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
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
function showWFHelp(docid){
    var screenWidth = window.screen.width*1;
    var screenHeight = window.screen.height*1;
    var operationPage = "/docs/docs/DocDsp.jsp?id="+docid;
    window.open(operationPage,"_blank","top=0,left="+(screenWidth-800)/2+",height="+(screenHeight-90)+",width=800,status=no,scrollbars=yes,toolbar=yes,menubar=no,location=no");
}
// modify by xhheng @20050304 for TD 1691
function openSignPrint() {
    window.open("PrintRequest.jsp?requestid=<%=requestid%>&isprint=1", "", "toolbar,resizable,scrollbars,dependent,height=500,width=550");
}
function onNewRequest(wfid,requestid,agent){
	var redirectUrl =  "AddRequest.jsp?workflowid="+wfid+"&isagent="+agent+"&reqid="+requestid;
	var width = screen.availWidth-10 ;
	var height = screen.availHeight-50 ;
	var szFeatures = "top=0," ;
	szFeatures +="left=0," ;
	szFeatures +="width="+width+"," ;
	szFeatures +="height="+height+"," ;
	szFeatures +="directories=no," ;
	szFeatures +="status=yes,toolbar=no,location=no," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ; //channelmode
	window.open(redirectUrl,"",szFeatures) ;
}
function onNewSms(wfid, nodeid, reqid){
	var redirectUrl =  "/sms/SendRequestSms.jsp?workflowid="+wfid+"&nodeid="+nodeid+"&reqid="+reqid;
	var width = screen.availWidth/2;
	var height = screen.availHeight/2;
	var top = height/2;
	var left = width/2;
	var szFeatures = "top="+top+"," ;
	szFeatures +="left="+left+"," ;
	szFeatures +="width="+width+"," ;
	szFeatures +="height="+height+"," ;
	szFeatures +="directories=no," ;
	szFeatures +="status=yes,toolbar=no,location=no," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ; //channelmode
	window.open(redirectUrl,"",szFeatures) ;
}
</SCRIPT>