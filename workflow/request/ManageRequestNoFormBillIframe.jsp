<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.AttachFileUtil" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.rtx.RTXConfig" %>
<%@ page import="weaver.file.Prop,weaver.general.GCONST" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet5" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSet3" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSet6" class="weaver.conn.RecordSet" scope="page" /> 
<jsp:useBean id="RecordSet7" class="weaver.conn.RecordSet" scope="page" /> 
<jsp:useBean id="RecordSet8" class="weaver.conn.RecordSet" scope="page" /> 
<jsp:useBean id="RecordSet9" class="weaver.conn.RecordSet" scope="page" /> 
<jsp:useBean id="RequestTriDiffWfManager" class="weaver.workflow.request.RequestTriDiffWfManager" scope="page" />
<jsp:useBean id="RequestDetailImport" class="weaver.workflow.request.RequestDetailImport" scope="page" />
<jsp:useBean id="rssign" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="WfFunctionManageUtil" class="weaver.workflow.workflow.WfFunctionManageUtil" scope="page"/>
<jsp:useBean id="WfForceOver" class="weaver.workflow.workflow.WfForceOver" scope="page" />
<jsp:useBean id="WfForceDrawBack" class="weaver.workflow.workflow.WfForceDrawBack" scope="page" />
<jsp:useBean id="flowDoc" class="weaver.workflow.request.RequestDoc" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="WFLinkInfo_nf" class="weaver.workflow.request.WFLinkInfo" scope="page"/>
<%
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
%>
<%
String isworkflowdoc = Util.getIntValue(request.getParameter("isworkflowdoc"),0)+"";//�Ƿ�Ϊ����
int seeflowdoc = Util.getIntValue(request.getParameter("seeflowdoc"),0);

String newfromdate="a";
String newenddate="b";
String  isrequest = Util.null2String(request.getParameter("isrequest")); // �Ƿ��Ǵ���ع���������������,1:��
int salesMessage = Util.getIntValue(request.getParameter("salesMessage"),-1);
int requestid = Util.getIntValue(request.getParameter("requestid"),0);
String wfdoc = Util.null2String((String)session.getAttribute(requestid+"_wfdoc"));
String message = Util.null2String(request.getParameter("message"));  // ���صĴ�����Ϣ
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
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
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //�Ƿ�����̴����ĵ�����
String topage = Util.null2String(request.getParameter("topage")) ;        //���ص�ҳ��
String isaffirmance=Util.null2String(request.getParameter("isaffirmance"));//�Ƿ���Ҫ�ύȷ��
String reEdit=Util.null2String(request.getParameter("reEdit"));//�Ƿ�Ϊ�༭
// �������½��ĵ��Ĵ���
String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
String fromPDA=Util.null2String((String)session.getAttribute("loginPAD"));   //��PDA��¼

// ��ƽ 2004-12-2 FOR TD1421  �½�����ʱ���������ϵ��ĵ��½���ť�����½����ĵ�֮���ܷ������̣������ĵ�ȴû�йҴ�������
String newdocid = Util.null2String(request.getParameter("newdocid"));        // �½����ĵ�

// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
int usertype = 0;                           //�û��ڹ��������е����� 0: �ڲ� 1: �ⲿ
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";
String isrejectremind="";
String ischangrejectnode="";
String isselectrejectnode="";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());

if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;

String sql = "" ;
char flag = Util.getSeparator() ;
boolean wfmonitor="true".equals(session.getAttribute(userid+"_"+requestid+"wfmonitor"))?true:false;                //���̼����
boolean haveBackright=false;            //ǿ���ջ�Ȩ��
boolean haveOverright=false;            //ǿ�ƹ鵵Ȩ��
boolean haveStopright = false;			//��ͣȨ��
boolean haveCancelright = false;		//����Ȩ��
boolean haveRestartright = false;		//����Ȩ��
String currentnodetype = "";
int currentnodeid = 0;

int lastOperator=0;
String lastOperateDate="";
String lastOperateTime="";

status = Util.null2String((String)session.getAttribute(userid+"_"+requestid+"status"));
requestname= Util.null2String((String)session.getAttribute(userid+"_"+requestid+"requestname"));
requestlevel=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"requestlevel"));
requestmark= Util.null2String((String)session.getAttribute(userid+"_"+requestid+"requestmark"));
creater= Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"creater"),0);
creatertype=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"creatertype"),0);
deleted=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"deleted"),0);
workflowid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"workflowid"),0);
nodeid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"nodeid"),0);
nodetype=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"nodetype"));
workflowname=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"workflowname"));
workflowtype=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"workflowtype"));
formid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"formid"),0);
billid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"billid"),0);
isbill=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"isbill"));
isremark=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"isremark"));
helpdocid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"helpdocid"),0);
String IsPendingForward=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"IsPendingForward"));
boolean IsCanSubmit="true".equals(session.getAttribute(userid+"_"+requestid+"IsCanSubmit"))?true:false;
String IsBeForward=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"IsBeForward"));
currentnodeid=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"currentnodeid"),0);
boolean isImportDetail="true".equals(session.getAttribute(userid+"_"+requestid+"isImportDetail"))?true:false;

currentnodetype=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"currentnodetype"));
boolean IsFreeWorkflow="true".equals(session.getAttribute(userid+"_"+requestid+"IsFreeWorkflow"))?true:false;
boolean IsCanModify="true".equals(session.getAttribute(userid+"_"+requestid+"IsCanModify"))?true:false;
String coadisforward=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"coadisforward"));
boolean coadCanSubmit="true".equals(session.getAttribute(userid+"_"+requestid+"coadCanSubmit"))?true:false;

lastOperator=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"lastOperator"),0);
lastOperateDate=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"lastOperateDate"));
lastOperateTime=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"lastOperateTime"));

String nextnodetype = "";//�ύ����һ���ڵ�����
RecordSet.executeSql("select b.nodetype as nextnodetype from workflow_nodelink a, workflow_flownode b where a.destnodeid=b.nodeid and a.workflowid="+workflowid+" and a.nodeid="+nodeid+" and (a.isreject is null or a.isreject='') order by a.nodepasstime,a.id");
if(RecordSet.next()) nextnodetype = RecordSet.getString("nextnodetype");
RecordSet.executeSql("select isremark,nodeid from workflow_currentoperator where (isremark<8 or isremark>8) and requestid="+requestid+" and userid="+userid+" and usertype="+usertype+" order by isremark");
while(RecordSet.next())	{
    int tempisremark = Util.getIntValue(RecordSet.getString("isremark"),0) ;
    int tmpnodeid=Util.getIntValue(RecordSet.getString("nodeid"));
    if( tempisremark == 0 || tempisremark == 1 || tempisremark == 5 || tempisremark == 9|| tempisremark == 7) {                       // ��ǰ�����߻�ת����
        isremark = tempisremark ;
        nodeid=tmpnodeid;
        nodetype=WFLinkInfo_nf.getNodeType(nodeid);
        break ;
    }
}
if( isremark != 0 && isremark != 1  && isremark != 5 && isremark != 8 && isremark != 9&& isremark != 7) {
    response.sendRedirect("/notice/noright.jsp");
    return;
}
int currentstatus = -1;//��ǰ����״̬(��Ӧ������ͣ����������)
String isModifyLog = "";
RecordSet.executeSql("select t1.ismodifylog,t2.currentstatus from workflow_base t1, workflow_requestbase t2 where t1.id=t2.workflowid and t2.requestid="+requestid);
if(RecordSet.next()) {
	currentstatus = Util.getIntValue(RecordSet.getString("currentstatus"));
	isModifyLog = RecordSet.getString("isModifyLog");
	
}
haveStopright = WfFunctionManageUtil.haveStopright(currentstatus,creater,user,currentnodetype,requestid,false);//���̲�Ϊ��ͣ���߳���״̬����ǰ�û�Ϊ���̷����˻���ϵͳ����Ա����������״̬��Ϊ�����͹鵵
haveCancelright = WfFunctionManageUtil.haveCancelright(currentstatus,creater,user,currentnodetype,requestid,false);//���̲�Ϊ����״̬����ǰ�û�Ϊ���̷����ˣ���������״̬��Ϊ�����͹鵵
haveRestartright = WfFunctionManageUtil.haveRestartright(currentstatus,creater,user,currentnodetype,requestid,false);//����Ϊ��ͣ���߳���״̬����ǰ�û�Ϊϵͳ����Ա����������״̬��Ϊ�����͹鵵
if(currentstatus>-1&&!haveCancelright&&!haveRestartright)
{
	String tips = "";
	if(currentstatus==0)
	{
		tips = SystemEnv.getHtmlLabelName(26154,user.getLanguage());//��������ͣ,�������̷����˻�ϵͳ����Ա��ϵ!
	}
	else
	{
		tips = SystemEnv.getHtmlLabelName(26155,user.getLanguage());//�����ѳ���,����ϵͳ����Ա��ϵ!
	}
%>
	<script language="JavaScript">
		var tips = '<%=tips%>';
		if(tips!="")
		{
			alert(tips);
		}
		window.location.href="/notice/noright.jsp?isovertime=<%=isovertime%>";
	</script>
<%
    return ;
}
RecordSet.executeProc("workflow_Nodebase_SelectByID",nodeid+"");
if(RecordSet.next()){
	isreopen=RecordSet.getString("isreopen");
	isreject=RecordSet.getString("isreject");
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
if(isremark == 8){
	//RecordSet2.executeSql("update workflow_currentoperator set isremark=2,operatedate='"+currentdate+"',operatetime='"+currenttime+"' where requestid="+requestid+" and userid="+userid+" and usertype=0"+usertype);
  //ʱ�������ݿⱣ��һ�£����Բ��ô洢�������������ݿ⡣
  RecordSet2.executeProc("workflow_CurrentOperator_Copy",requestid+""+flag+userid+flag+usertype+"");
  if(currentnodetype.equals("3")){
    RecordSet2.executeSql("update workflow_currentoperator set iscomplete=1 where requestid="+requestid+" and userid="+userid+" and usertype="+usertype);
  }
	response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&isremark=8&fromFlowDoc="+fromFlowDoc);
	return;
}
/*--  xwj for td2104 on 20050802 begin  --*/
boolean isOldWf = false;
RecordSet3.executeSql("select nodeid from workflow_currentoperator where requestid = " + requestid);
while(RecordSet3.next()){
	if(RecordSet3.getString("nodeid") == null || "".equals(RecordSet3.getString("nodeid")) || "-1".equals(RecordSet3.getString("nodeid"))){
			isOldWf = true;
	}
}

if(! currentnodetype.equals("3") )
    RecordSet.executeProc("SysRemindInfo_DeleteHasnewwf",""+userid+flag+usertype+flag+requestid);
else
    RecordSet.executeProc("SysRemindInfo_DeleteHasendwf",""+userid+flag+usertype+flag+requestid);

String imagefilename = "/images/hdReport.gif";
String titlename =  SystemEnv.getHtmlLabelName(648,user.getLanguage())+":"
	                +SystemEnv.getHtmlLabelName(553,user.getLanguage())+" - "+Util.toScreen(workflowname,user.getLanguage())+ " - " + status + " "+requestmark;//Modify by ����� 2004-10-26 For TD1231
String needfav ="1";
String needhelp ="";
//if(helpdocid !=0 ) {titlename=titlename + "<img src=/images/help.gif style=\"CURSOR:hand\" width=12 onclick=\"location.href='/docs/docs/DocDsp.jsp?id="+helpdocid+"'\">";}

boolean docFlag=flowDoc.haveDocFiled(""+workflowid,""+nodeid);
String isSignMustInput="0";
String isFormSignature=null;
rssign.execute("select issignmustinput,isFormSignature from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(rssign.next()){
	isSignMustInput = ""+Util.getIntValue(rssign.getString("issignmustinput"), 0);
	isFormSignature = Util.null2String(rssign.getString("isFormSignature"));
}
int isUseWebRevision_t = Util.getIntValue(new weaver.general.BaseBean().getPropValue("weaver_iWebRevision","isUseWebRevision"), 0);
if(isUseWebRevision_t != 1){
	isFormSignature = "";
}
String  docFlagss=docFlag?"1":"0";
session.setAttribute("requestAdd"+requestid,docFlagss);
//�ж������ֶ��Ƿ���ʾѡ��ť
ArrayList newTextList = flowDoc.getDocFiled(""+workflowid);
if(newTextList != null && newTextList.size() > 0){
  String flowDocField = ""+newTextList.get(1);
  String newTextNodes = ""+newTextList.get(5);
  session.setAttribute("requestFlowDocField"+user.getUID(),flowDocField);
  session.setAttribute("requestAddNewNodes"+user.getUID(),newTextNodes);
}
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">
<script language=javascript src="/js/weaver.js"></script>
<script type='text/javascript' src='/dwr/interface/DocReadTagUtil.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/util.js'></script>
<link href="/js/swfupload/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogressBywf.js"></script>
<script type="text/javascript" src="/js/swfupload/handlersBywf.js"></script>    
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<style>
.wordSpan{font-family:MS Shell Dlg,Arial;CURSOR: hand;font-weight:bold;FONT-SIZE: 10pt}
</style>
</head>
<title><%=requestname%></title>


<script language="javascript">

//TD4262 ������ʾ��Ϣ  ��ʼ
function windowOnload()
{
<%
	if( message.equals("1") ) {//��������Ϣ�������
%>
//	      contentBox = $GetEle("divFavContent16332");
//          showObjectPopup(contentBox);
//          window.setTimeout("oPopup.hide()", 2000);
		  var content="<%=SystemEnv.getHtmlLabelName(16332,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);
<%
	} else if( message.equals("2") ) {//��������һ�ڵ����һ�ڵ�����ߴ���
%>
//	      contentBox = $GetEle("divFavContent16333");
//          showObjectPopup(contentBox);
//          window.setTimeout("oPopup.hide()", 2000);
		  var content="<%=SystemEnv.getHtmlLabelName(16333,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);
<%
	} else if( message.equals("3") ) {//�����̴�������ֵ�����������̴��������á�
%>

		  var content="<%=SystemEnv.getHtmlLabelName(19455,user.getLanguage())%>";
		  showPrompt(content);
          //window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	} else if( message.equals("4") ) {//�Ѿ���ת����һ�ڵ㣬���������ύ��
%>

		  var content="<%=SystemEnv.getHtmlLabelName(21266,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	} else if( message.equals("5") ) {//������ת��ʱ�������ԡ�
%>

		  var content="<%=SystemEnv.getHtmlLabelName(21270,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	} else if( message.equals("6") ) {//ת��ʧ�ܣ������ԣ�
%>

		  var content="<%=SystemEnv.getHtmlLabelName(21766,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	} else if( message.equals("7") ) {//�Ѿ����������ظ�����
%>

		  var content="<%=SystemEnv.getHtmlLabelName(22751,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	} else if( message.equals("8") ) {//���������Ѹ��ģ���˶Ժ��ٴ���
%>

		  var content="<%=SystemEnv.getHtmlLabelName(24676,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("$GetEle('message_table_Div').style.display='none';$GetEle('HelpFrame').style.display='none'", 2000);

<%
	}
%>
window.setTimeout(function(){displayAllmenu();},3000);
}
//TD4262 ������ʾ��Ϣ  ����

<%--added by xwj for td3247 20051201--%>
window.onbeforeunload = function protectManageBillFlow(event){
  	if(!checkDataChange())//added by cyril on 2008-06-10 for TD:8828
        return "<%=SystemEnv.getHtmlLabelName(18877,user.getLanguage())%>";
   }

     function doBack(){
        jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
        parent.document.location.href="/workflow/request/RequestView.jsp"; //xwj for td3425 20051201
   }

		function downloads(files)
		{ jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		$GetEle("fileDownload").src="/weaver/weaver.file.FileDownload?fileid="+files+"&download=1";
		}
    function downloadsBatch(fieldvalue,requestid)
    { 
       jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
       $GetEle("fileDownload").src="/weaver/weaver.file.FileDownload?fieldvalue="+fieldvalue+"&download=1&downloadBatch=1&requestid="+requestid;
    }
		function opendoc(showid,versionid,docImagefileid)
		{jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		openFullWindowHaveBar("/docs/docs/DocDspExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>");
		}
		function opendoc1(showid)
		{
		jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		openFullWindowHaveBar("/docs/docs/DocDsp.jsp?id="+showid+"&isrequest=1&requestid=<%=requestid%>");
		}
function replaceAll(strOrg,strFind,strReplace){ 
var index = 0; 
while(strOrg.indexOf(strFind,index) != -1){ 
strOrg = strOrg.replace(strFind,strReplace); 
index = strOrg.indexOf(strFind,index); 
} 
return strOrg 
} 
function doLocationHref(){

	var workflowRequestLogId=0;
	if($GetEle("workflowRequestLogId")!=null){
		workflowRequestLogId=$GetEle("workflowRequestLogId").value;
	}

	var id = <%=requestid%>;
	var remark = "";

	try{
		FCKEditorExt.updateContent();
		$GetEle("frmmain").target = "_blank";
		$GetEle("frmmain").action = "/workflow/request/Remark.jsp?requestid="+id+"&workflowRequestLogId="+workflowRequestLogId;
		//�����ϴ�
                        StartUploadAll();
                        checkfileuploadcomplet();
	}catch(e){
		try{
			remark = FCKEditorExt.getHtml("remark");
		}catch(e){}
		var forwardurl = "/workflow/request/Remark.jsp?requestid="+id+"&workflowRequestLogId="+workflowRequestLogId+"&remark="+escape(remark);
		openFullWindowHaveBar(forwardurl);
	}

}

<%
String isFormSignatureOfThisJsp=null;
RecordSet.executeSql("select ismode,showdes,isFormSignature from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSet.next()){
	isFormSignatureOfThisJsp = Util.null2String(RecordSet.getString("isFormSignature"));
}
%>

   function doReview(){


         jQuery($GetEle("flowbody")).attr("onbeforeunload", "");

//����ǩ������
<%if("1".equals(isFormSignatureOfThisJsp)){%>
	                    if(SaveSignature()){
                            doLocationHref();
                        }else{
							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,user.getLanguage())%>");
								isDocEmpty=0;
							}else{
							    alert("<%=SystemEnv.getHtmlLabelName(21442,user.getLanguage())%>");
							}
							return ;
						}
<%}else{%>
                        doLocationHref();
<%}%>

   }

var isfirst = 0 ;

function displaydiv()
{
    if(oDivAll.style.display == ""){
		oDivAll.style.display = "none";
		oDivInner.style.display = "none";
        oDiv.style.display = "none";

        spanimage.innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
    }
    else{
        if(isfirst == 0) {
			$GetEle("picInnerFrame").src="/workflow/request/WorkflowRequestPictureInner.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>";				
			$GetEle("picframe").src="/workflow/request/WorkflowRequestPicture.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>";

            isfirst ++ ;
        }

        spanimage.innerHTML = "<img src='/images/ArrowUpGreen.gif' border=0>" ;
		oDivAll.style.display = "";
		oDivInner.style.display = "";
        oDiv.style.display = "";
        workflowStatusLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19678,user.getLanguage())%></font>";
        workflowChartLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19676,user.getLanguage())%></font>";
    }
}


function displaydivOuter()
{
    if(oDiv.style.display == ""){
        oDiv.style.display = "none";
        workflowStatusLabelSpan.innerHTML="<font color=red><%=SystemEnv.getHtmlLabelName(19677,user.getLanguage())%></font>";
		if(oDiv.style.display == "none"&&oDivInner.style.display == "none"){
		    oDivAll.style.display = "none";
            spanimage.innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
		}
    }
    else{
        oDiv.style.display = "";
        workflowStatusLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19678,user.getLanguage())%></font>";
    }
}

function displaydivInner()
{
    if(oDivInner.style.display == ""){
        oDivInner.style.display = "none";
        workflowChartLabelSpan.innerHTML="<font color=red><%=SystemEnv.getHtmlLabelName(19675,user.getLanguage())%></font>";
		if(oDiv.style.display == "none"&&oDivInner.style.display == "none"){
		    oDivAll.style.display = "none";
            spanimage.innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
		}
    }
    else{
        oDivInner.style.display = "";
        workflowChartLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19676,user.getLanguage())%></font>";
    }
}

<%-----------xwj for td3131 20051115 begin -----%>
function numberToFormat(index){
    if($GetEle("field_lable"+index).value != ""){
		var floatNum = floatFormat($GetEle("field_lable"+index).value);
       	var val = numberChangeToChinese(floatNum)
       	if(val == ""){
       		alert("<%=SystemEnv.getHtmlLabelName(31181,user.getLanguage())%>");
            $GetEle("field"+index).value = "";
            $GetEle("field_lable"+index).value = "";
            $GetEle("field_chinglish"+index).value = "";
       	} else {
	        $GetEle("field"+index).value = floatNum;
	        $GetEle("field_lable"+index).value = milfloatFormat(floatNum);
       		$GetEle("field_chinglish"+index).value = val;
       	}
    }else{
        $GetEle("field"+index).value = "";
        $GetEle("field_chinglish"+index).value = "";
    }
}
function FormatToNumber(index){
    if($GetEle("field_lable"+index).value != ""){
        $GetEle("field_lable"+index).value = $GetEle("field"+index).value;
    }else{
        $GetEle("field"+index).value = "";
        $GetEle("field_chinglish"+index).value = "";
    }
}
<%-----------xwj for td3131 20051115 end -----%>

</SCRIPT>

<BODY id="flowbody" <%if (docFlag) {%> onload="changeTab()"<%}%>  <%if (!docFlag&&!fromPDA.equals("1")) {%>  <%}%>><%--Modified by xwj for td3247 20051201--%>
<%if (!docFlag) {%>
<%@ include file="RequestTopTitle.jsp" %>
<%}%>
<iframe id="fileDownload" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="triSubwfIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<%
String managepage= "";
String operationpage = "" ;
String hasfileup="";
if(isbill.equals("1")){
    RecordSet.executeProc("bill_includepages_SelectByID",formid+"");
    if(RecordSet.next()) {
        managepage = Util.null2String(RecordSet.getString("managepage"));
        operationpage = Util.null2String(RecordSet.getString("operationpage"));
        hasfileup=Util.null2String(RecordSet.getString("hasfileup"));
    }
}

//---------------------------------------------------------------------------------
// ����������-��ǰ������Ƿ�IE����Ϊ���ݣ�������δ�޸ĵĵ��ݣ�����ת������ҳ�� START
//---------------------------------------------------------------------------------
if (!isIE.equalsIgnoreCase("true")) {
	if (isbill.equals("1") && formid > 0 && !managepage.equals("")) {
		if (!"180".equals(formid + "") && !"85".equals(formid + "") &&!"7".equals(formid + "") && !"79".equals(formid + "") && !"158".equals(formid + "") && !"157".equals(formid + "") && !"156".equals(formid + "") ) {
			//response.sendRedirect("/wui/common/page/sysRemind.jsp?labelid=15590");
%>

<script type="text/javascript">

window.parent.location.href = "/wui/common/page/sysRemind.jsp?labelid=27826";

</script>

<%
			return;
		}
	}
}
//---------------------------------------------------------------------------------
//����������-��ǰ������Ƿ�IE����Ϊ���ݣ�������δ�޸ĵĵ��ݣ�����ת������ҳ�� END
//---------------------------------------------------------------------------------

//TD9145
Prop prop = Prop.getInstance();
String ifchangstatus = Util.null2String(prop.getPropValue(GCONST.getConfigFile() , "ecology.changestatus"));
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
String subnobackName = "";//�ύ���跴��
String subbackName = "";//�ύ�跴��
String hasnoback = "";//ʹ���ύ���跴����ť
String hasback = "";//ʹ���ύ�跴����ť
String forsubnobackName = "";//ת����ע���跴��
String forsubbackName = "";//ת����ע�跴��
String hasfornoback = "";//ʹ��ת����ע���跴����ť
String hasforback = "";//ʹ��ת����ע�跴����ť
String ccsubnobackName = "";//������ע���跴��
String ccsubbackName = "";//������ע�跴��
String hasccnoback = "";//ʹ�ó�����ע���跴����ť
String hasccback = "";//ʹ�ó�����ע�跴����ť
String newOverTimeName=""; //��ʱ���ð�ť
String hasovertime="";    //�Ƿ�ʹ�ó�ʱ���ð�ť
String FreeWorkflowname=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"FreeWorkflowname"));
String sqlselectName = "select * from workflow_nodecustomrcmenu where wfid="+workflowid+" and nodeid="+nodeid;
if(isremark != 0){
	RecordSet.executeSql("select nodeid from workflow_currentoperator c where c.requestid="+requestid+" and c.userid="+userid+" and c.usertype="+usertype+" and c.isremark='"+isremark+"' ");
	String tmpnodeid="";
	if(RecordSet.next()){
		tmpnodeid = Util.null2String(RecordSet.getString("nodeid"));
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
		subnobackName = Util.null2String(RecordSet.getString("subnobackName7"));
		subbackName = Util.null2String(RecordSet.getString("subbackName7"));
		forsubnobackName = Util.null2String(RecordSet.getString("forsubnobackName7"));
		forsubbackName = Util.null2String(RecordSet.getString("forsubbackName7"));
		ccsubnobackName = Util.null2String(RecordSet.getString("ccsubnobackName7"));
		ccsubbackName = Util.null2String(RecordSet.getString("ccsubbackName7"));
        newOverTimeName = Util.null2String(RecordSet.getString("newOverTimeName7"));
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
		subnobackName = Util.null2String(RecordSet.getString("subnobackName9"));
		subbackName = Util.null2String(RecordSet.getString("subbackName9"));
		forsubnobackName = Util.null2String(RecordSet.getString("forsubnobackName9"));
		forsubbackName = Util.null2String(RecordSet.getString("forsubbackName9"));
		ccsubnobackName = Util.null2String(RecordSet.getString("ccsubnobackName9"));
		ccsubbackName = Util.null2String(RecordSet.getString("ccsubbackName9"));
        newOverTimeName = Util.null2String(RecordSet.getString("newOverTimeName9"));
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
		subnobackName = Util.null2String(RecordSet.getString("subnobackName8"));
		subbackName = Util.null2String(RecordSet.getString("subbackName8"));
		forsubnobackName = Util.null2String(RecordSet.getString("forsubnobackName8"));
		forsubbackName = Util.null2String(RecordSet.getString("forsubbackName8"));
		ccsubnobackName = Util.null2String(RecordSet.getString("ccsubnobackName8"));
		ccsubbackName = Util.null2String(RecordSet.getString("ccsubbackName8"));
        newOverTimeName = Util.null2String(RecordSet.getString("newOverTimeName8"));
	}
	haswfrm = Util.null2String(RecordSet.getString("haswfrm"));
	hassmsrm = Util.null2String(RecordSet.getString("hassmsrm"));
	hasnoback = Util.null2String(RecordSet.getString("hasnoback"));
	hasback = Util.null2String(RecordSet.getString("hasback"));
	hasfornoback = Util.null2String(RecordSet.getString("hasfornoback"));
	hasforback = Util.null2String(RecordSet.getString("hasforback"));
	hasccnoback = Util.null2String(RecordSet.getString("hasccnoback"));
	hasccback = Util.null2String(RecordSet.getString("hasccback"));
	t_workflowid = Util.getIntValue(RecordSet.getString("workflowid"), 0);
    hasovertime = Util.null2String(RecordSet.getString("hasovertime"));
}

if(isremark == 1){
	submitname = forsubName;
	subnobackName = forsubnobackName;
	subbackName = forsubbackName;
}
if(isremark == 9||isremark == 7){
	submitname = ccsubName;
	subnobackName = ccsubnobackName;
	subbackName =  ccsubbackName;
}
if("".equals(submitname)){
	if(nodetype.equals("0") || isremark == 1 || isremark == 9||isremark == 7){
		submitname = SystemEnv.getHtmlLabelName(615,user.getLanguage());      // �����ڵ����ת��, Ϊ�ύ
	}else if(nodetype.equals("1")){
		submitname = SystemEnv.getHtmlLabelName(142,user.getLanguage());  // ����
	}else if(nodetype.equals("2")){
		submitname = SystemEnv.getHtmlLabelName(725,user.getLanguage());  // ʵ��
	}
}
if("".equals(subbackName)){
		if(nodetype.equals("0") || isremark == 1 || isremark == 9||isremark == 7)	{
			if((nodetype.equals("0") && ("1".equals(hasnoback)||"1".equals(hasback))) || (isremark==1 && ("1".equals(hasfornoback)||"1".equals(hasforback))) || (isremark==9 && ("1".equals(hasccnoback)||"1".equals(hasccback)))){
				subbackName = SystemEnv.getHtmlLabelName(615,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21761,user.getLanguage())+"��";      // �����ڵ����ת��, Ϊ�ύ
			}else{
				subbackName = SystemEnv.getHtmlLabelName(615,user.getLanguage());
			}
		}else if(nodetype.equals("1")){
			if("1".equals(hasnoback)||"1".equals(hasback)){
				subbackName = SystemEnv.getHtmlLabelName(142,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21761,user.getLanguage())+"��";  // ����
			}else{
				subbackName = SystemEnv.getHtmlLabelName(142,user.getLanguage());
			}
		}else if(nodetype.equals("2")){
			if("1".equals(hasnoback)||"1".equals(hasback)){
				subbackName = SystemEnv.getHtmlLabelName(725,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21761,user.getLanguage())+"��";  // ʵ��
			}else{
				subbackName = SystemEnv.getHtmlLabelName(725,user.getLanguage());
			}
		}
}
if("".equals(subnobackName)){
	if(nodetype.equals("0") || isremark == 1 || isremark == 9||isremark == 7)	{
		subnobackName = SystemEnv.getHtmlLabelName(615,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21762,user.getLanguage())+"��";      // �����ڵ����ת��, Ϊ�ύ
	}else if(nodetype.equals("1")){
		subnobackName = SystemEnv.getHtmlLabelName(142,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21762,user.getLanguage())+"��";  // ����
	}else if(nodetype.equals("2")){
		subnobackName = SystemEnv.getHtmlLabelName(725,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(21762,user.getLanguage())+"��";  // ʵ��
	}
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
if("".equals(FreeWorkflowname.trim())){
	FreeWorkflowname = SystemEnv.getHtmlLabelName(21781,user.getLanguage());
}
%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%String strBar="[";//�˵�%>
<%if (!fromPDA.equals("1") && !wfmonitor) {%>  <!--pda��¼��Ҫ�˵�-->
<%
if (isaffirmance.equals("1") && nodetype.equals("0") && !reEdit.equals("1")){//�ύȷ�ϲ˵�
if(IsCanSubmit||coadCanSubmit){
RCMenu += "{"+SystemEnv.getHtmlLabelName(16634,user.getLanguage())+",javascript:doSubmit_Pre(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(16634,user.getLanguage())+"',iconCls:'btn_submit',handler: function(){doSubmit_Pre(this);}},";
}    
topage = URLEncoder.encode(topage);
RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+",javascript:doEdit(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+"',iconCls:'btn_edit',handler: function(){parent.location.href='ViewRequest.jsp?reEdit=1&fromFlowDoc="+fromFlowDoc+"&requestid="+requestid+"&isovertime="+isovertime+"&topage="+topage+"';}},";
}else{
if(isremark == 1||isremark == 9||isremark == 7){

if("".equals(ifchangstatus)){
		RCMenu += "{"+submitname+",javascript:doRemark_nNoBack(this),_self}" ;
		RCMenuHeight += RCMenuHeightStep ;
		strBar += "{text: '"+submitname+"',iconCls:'btn_submit',handler: function(){doRemark_nNoBack();}},";
	}else{
		if((!"1".equals(hasfornoback)&&isremark==1) || (!"1".equals(hasccnoback)&&isremark==9)){
			RCMenu += "{"+subbackName+",javascript:doRemark_nBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doRemark_nBack(this);}},";
		}else{
			if(("1".equals(hasforback)&&isremark==1) || ("1".equals(hasccback)&&isremark==9)){
				RCMenu += "{"+subbackName+",javascript:doRemark_nBack(this),_self}";
				RCMenuHeight += RCMenuHeightStep;
				strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doRemark_nBack(this);}},";
			}
			RCMenu += "{"+subnobackName+",javascript:doRemark_nNoBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subnobackName+"',iconCls:'btn_subnobackName',handler: function(){doRemark_nNoBack(this);}},";
		}
	}
	  if(isremark==1&&IsCanModify){
        RCMenu += "{"+saveName+",javascript:doSave_nNew(this),_self}" ;
        RCMenuHeight += RCMenuHeightStep ;
        strBar += "{text: '"+saveName+"',iconCls:'btn_wfSave',handler: function(){doSave_nNew(this);}},";
    }
    if((isremark==1&&IsBeForward.equals("1"))||(isremark==9&&IsPendingForward.equals("1"))){
        RCMenu += "{"+forwardName+",javascript:doReview(),_self}" ;//add by mackjoe
        RCMenuHeight += RCMenuHeightStep ;
        strBar += "{text: '"+forwardName+"',iconCls:'btn_forward',handler: function(){doReview();}},";
    }
}else if(isremark == 5){		//��ʱ
    if("".equals(ifchangstatus)){
		RCMenu += "{"+submitname+",javascript:doSubmitNoBack(this),_self}" ;
		RCMenuHeight += RCMenuHeightStep ;
		strBar += "{text: '"+submitname+"',iconCls:'btn_submit',handler: function(){doSubmitNoBack(this);}},";
	}else{
		if(!"1".equals(hasnoback)){
			RCMenu += "{"+subbackName+",javascript:doSubmitBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doSubmitBack(this);}},";
		}else{
			if("1".equals(hasback)){
				RCMenu += "{"+subbackName+",javascript:doSubmitBack(this),_self}";
				RCMenuHeight += RCMenuHeightStep;
				strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doSubmitBack(this);}},";
			}
			RCMenu += "{"+subnobackName+",javascript:doSubmitNoBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subnobackName+"',iconCls:'btn_subnobackName',handler: function(){doSubmitNoBack(this);}},";
		}
	}
}else {

if(IsCanSubmit||coadCanSubmit){
if (isaffirmance.equals("1") && nodetype.equals("0") && reEdit.equals("1")){
    if("".equals(ifchangstatus)){
		RCMenu += "{"+submitname+",javascript:doAffirmanceNoBack(this),_self}" ;
		RCMenuHeight += RCMenuHeightStep ;
		strBar += "{text: '"+submitname+"',iconCls:'btn_submit',handler: function(){doAffirmanceNoBack(this);}},";
	}else{
		if(!"1".equals(hasnoback)){
			RCMenu += "{"+subbackName+",javascript:doAffirmanceBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doAffirmanceBack(this);}},";
		}else{
			if("1".equals(hasback)){
				RCMenu += "{"+subbackName+",javascript:doAffirmanceBack(this),_self}";
				RCMenuHeight += RCMenuHeightStep;
				strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doAffirmanceBack(this);}},";
			}
			RCMenu += "{"+subnobackName+",javascript:doAffirmanceNoBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subnobackName+"',iconCls:'btn_subnobackName',handler: function(){doAffirmanceNoBack(this);}},";
		}
	}
}else{
    if("".equals(ifchangstatus)){
		RCMenu += "{"+submitname+",javascript:doSubmit(this),_self}" ;
		RCMenuHeight += RCMenuHeightStep ;
		strBar += "{text: '"+submitname+"',iconCls:'btn_submit',handler: function(){doSubmit(this);}},";
	}else{
		if(!"1".equals(hasnoback)){
			RCMenu += "{"+subbackName+",javascript:doSubmitBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doSubmitBack(this);}},";
		}else{
			if("1".equals(hasback)){
				RCMenu += "{"+subbackName+",javascript:doSubmitBack(this),_self}";
				RCMenuHeight += RCMenuHeightStep;
				strBar += "{text: '"+subbackName+"',iconCls:'btn_subbackName',handler: function(){doSubmitBack(this);}},";
			}
			RCMenu += "{"+subnobackName+",javascript:doSubmitNoBack(this),_self}";
			RCMenuHeight += RCMenuHeightStep;
			strBar += "{text: '"+subnobackName+"',iconCls:'btn_subnobackName',handler: function(){doSubmitNoBack(this);}},";
		}
	}
}
if(IsFreeWorkflow){
    RCMenu += "{"+FreeWorkflowname+",javascript:doFreeWorkflow(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    strBar += "{text: '"+FreeWorkflowname+"',iconCls:'btn_edit',handler: function(){doFreeWorkflow(this);}},";
}
if(isImportDetail){
    RCMenu += "{"+SystemEnv.getHtmlLabelName(26255,user.getLanguage())+",javascript:doImportDetail(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+saveName+",javascript:doSave_nNew(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+saveName+"',iconCls:'btn_wfSave',handler: function(){doSave_nNew(this);}},";
if( isreject.equals("1")&&isremark==0 ){
    RCMenu += "{"+rejectName+",javascript:doReject_New(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    strBar += "{text: '"+rejectName+"',iconCls:'btn_rejectName',handler: function(){doReject_New();}},";
}
}
if((isremark!=7&&IsPendingForward.equals("1"))||(isremark==7&&"1".equals(coadisforward))){
RCMenu += "{"+forwardName+",javascript:doReview(),_self}" ;//Modified by xwj for td3247 20051201
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+forwardName+"',iconCls:'btn_forward',handler: function(){doReview();}},";
}
%>

<%  if(isreopen.equals("1") && false ){%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(244,user.getLanguage())+",javascript:doReopen(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(244,user.getLanguage())+"',iconCls:'btn_doReopen',handler: function(){doReopen();}},";
%>
<%  }
}
%>
<%
/*added by cyril on 2008-07-10 for TD:8835*/
if(isModifyLog.equals("1")) {
	RCMenu += "{"+SystemEnv.getHtmlLabelName(21625,user.getLanguage())+",javascript:doViewModifyLog(),_self}" ;
	RCMenuHeight += RCMenuHeightStep ;
	strBar += "{text: '"+SystemEnv.getHtmlLabelName(21625,user.getLanguage())+"',iconCls:'btn_doViewModifyLog',handler: function(){doViewModifyLog();}},";
}
/*end added by cyril on 2008-07-10 for TD:8835*/
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
		strBar += "{text: '"+newWFName+"',iconCls:'btn_newWFName',handler: function(){onNewRequest("+t_workflowid+", "+requestid+",0);}},";
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
	strBar += "{text: '"+newSMSName+"',iconCls:'btn_newSMSName',handler: function(){onNewSms("+workflowid+", "+nodeid+", "+requestid+");}},";
}
/*TD9145 END*/
if("1".equals(hasovertime)&&isremark==0){
	if("".equals(newOverTimeName)){
		newOverTimeName = SystemEnv.getHtmlLabelName(18818,user.getLanguage());
	}
	RCMenu += "{"+newOverTimeName+",javascript:onNewOverTime(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
    strBar += "{text: '"+newOverTimeName+"',iconCls:'btn_newSMSName',handler: function(){onNewOverTime();}},";
}
String isTriDiffWorkflow=null; 
RecordSet.executeSql("select isTriDiffWorkflow,isrejectremind,ischangrejectnode,isselectrejectnode from workflow_base where id="+workflowid);

if(RecordSet.next()){
	isTriDiffWorkflow=Util.null2String(RecordSet.getString("isTriDiffWorkflow"));
    isrejectremind=Util.null2String(RecordSet.getString("isrejectremind"));
    ischangrejectnode=Util.null2String(RecordSet.getString("ischangrejectnode"));
	  isselectrejectnode=Util.null2String(RecordSet.getString("isselectrejectnode"));
}

if(!"1".equals(isTriDiffWorkflow)){
	isTriDiffWorkflow="0";
}


                StringBuffer sb=new StringBuffer();
				if("1".equals(isTriDiffWorkflow)){
					sb.append("  select  ab.id as subwfSetId,c.id as buttonNameId,c.triSubwfName7,c.triSubwfName8 from ")
					  .append(" ( ")
					  .append("  select a.triggerType,b.nodeType,b.nodeId,a.triggerTime,a.fieldId ,a.id ")
					  .append("    from Workflow_TriDiffWfDiffField a,workflow_flownode b ")
					  .append("   where a.triggerNodeId=b.nodeId ")
					  .append("     and a.mainWorkflowId=b.workflowId ")
					  .append("     and a.mainWorkflowId=").append(workflowid)
					  .append("     and a.triggerNodeId=").append(nodeid)
					  .append("     and a.triggerType='2' ")
					  .append(" )ab left join  ")
					  .append(" ( ")
					  .append("   select *  ")
					  .append("     from Workflow_TriSubwfButtonName ")
					  .append("    where workflowId=").append(workflowid)
					  .append("      and nodeId=").append(nodeid)
					  .append("      and subwfSetTableName='Workflow_TriDiffWfDiffField' ")
					  .append(" )c on ab.id=c.subwfSetId ")
					  .append(" order by ab.triggerType asc,ab.nodeType asc,ab.nodeId asc,ab.triggerTime asc,ab.fieldId asc ,ab.id asc ")
					  ;
				}else{
					sb.append("  select  ab.id as subwfSetId,c.id as buttonNameId,c.triSubwfName7,c.triSubwfName8 from ")
					  .append(" ( ")
					  .append("  select a.triggerType,b.nodeType,b.nodeId,a.triggerTime,a.subWorkflowId ,a.id ")
					  .append("    from Workflow_SubwfSet a,workflow_flownode b ")
					  .append("   where a.triggerNodeId=b.nodeId ")
					  .append("     and a.mainWorkflowId=b.workflowId ")
					  .append("     and a.mainWorkflowId=").append(workflowid)
					  .append("     and a.triggerNodeId=").append(nodeid)
					  .append("     and a.triggerType='2' ")
					  .append(" )ab left join  ")
					  .append(" ( ")
					  .append("   select *  ")
					  .append("     from Workflow_TriSubwfButtonName ")
					  .append("    where workflowId=").append(workflowid)
					  .append("      and nodeId=").append(nodeid)
					  .append("      and subwfSetTableName='Workflow_SubwfSet' ")
					  .append(" )c on ab.id=c.subwfSetId ")
					  .append(" order by ab.triggerType asc,ab.nodeType asc,ab.nodeId asc,ab.triggerTime asc,ab.subWorkflowId asc,ab.id asc ")
					  ;
				}
				int subwfSetId=0;
				int buttonNameId=0;
				String triSubwfName7=null;
				String triSubwfName8=null;
				String triSubwfName=null;
				String trClass="datalight";
				int indexId=0;
				RecordSet.executeSql(sb.toString());
				while(RecordSet.next()){
					subwfSetId=Util.getIntValue(RecordSet.getString("subwfSetId"),0);
					buttonNameId=Util.getIntValue(RecordSet.getString("buttonNameId"),0);
					triSubwfName7=Util.null2String(RecordSet.getString("triSubwfName7"));
					triSubwfName8=Util.null2String(RecordSet.getString("triSubwfName8"));
					indexId++;
					triSubwfName="";
					if(isremark!=1){
					if(user.getLanguage()==8){
						triSubwfName=triSubwfName8;
					}else{
						triSubwfName=triSubwfName7;
					}
					if(triSubwfName.equals("")){
						triSubwfName=SystemEnv.getHtmlLabelName(22064,user.getLanguage())+indexId;
					}
					//lihaibo start
					String finalsubworkflownameS="";
					if("1".equals(isTriDiffWorkflow)){
			        	finalsubworkflownameS = RequestTriDiffWfManager.getWorkFlowNameByisTriDiffWorkflow(requestid,subwfSetId,workflowid,nodeid);
					}else{
						finalsubworkflownameS = RequestTriDiffWfManager.getWorkFlowNameByDiffWorkflow(subwfSetId,workflowid);
					}
					RCMenu += "{"+triSubwfName+",javascript:triSubwf2("+subwfSetId+",\\\""+finalsubworkflownameS+"\\\"),_top} " ;
					RCMenuHeight += RCMenuHeightStep ;
					strBar += "{text: '"+triSubwfName+"',iconCls:'btn_relateCwork',handler: function(){triSubwf2("+subwfSetId+",\\\""+finalsubworkflownameS+"\\\");}},";
					//lihaibo end
					
					//RCMenu += "{"+triSubwfName+",javascript:triSubwf("+subwfSetId+"),_top} " ;
					//RCMenuHeight += RCMenuHeightStep ;
					//strBar += "{text: '"+triSubwfName+"',iconCls:'',handler: function(){triSubwf("+subwfSetId+");}},";
				}
				}
if(!isfromtab&&!"1".equals(session.getAttribute("istest"))){
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doBack(),_self}" ;//td3425 xwj 2005-12-31
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+"',iconCls:'btn_back',handler: function(){doBack();}},";
}
%>
<%--add by ben for TD3665 begin--%>
<%
HashMap map = WfFunctionManageUtil.wfFunctionManageByNodeid(workflowid,nodeid);
String ov = (String)map.get("ov");
String rb = (String)map.get("rb");
haveOverright=isremark != 1&&isremark != 9&&isremark != 7&&isremark != 5&&"1".equals(ov) && WfForceOver.isNodeOperator(requestid,userid) && !currentnodetype.equals("3");
haveBackright=isremark != 1&&isremark != 9&&isremark != 7&&isremark != 5&&!"0".equals(rb) && WfForceDrawBack.isHavePurview(requestid,userid,Integer.parseInt(logintype),-1,-1) && !currentnodetype.equals("0");
if(haveOverright){
RCMenu += "{"+SystemEnv.getHtmlLabelName(18360,user.getLanguage())+",javascript:doDrawBack(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(18360,user.getLanguage())+"',iconCls:'btn_doDrawBack',handler: function(){doDrawBack(this);}},";
}
if(haveBackright){
RCMenu += "{"+SystemEnv.getHtmlLabelName(18359,user.getLanguage())+",javascript:doRetract(this),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(18359,user.getLanguage())+"',iconCls:'btn_doRetract',handler: function(){doRetract(this);}},";
}
if(haveStopright)
{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(20387,user.getLanguage())+",javascript:doStop(this),_self}" ;
	RCMenuHeight += RCMenuHeightStep ;
	strBar += "{text: '"+SystemEnv.getHtmlLabelName(20387,user.getLanguage())+"',iconCls:'btn_end',handler: function(){bodyiframe.doStop(this);}},";
}
if(haveCancelright)
{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(16210,user.getLanguage())+",javascript:doCancel(this),_self}" ;
	RCMenuHeight += RCMenuHeightStep ;
	strBar += "{text: '"+SystemEnv.getHtmlLabelName(16210,user.getLanguage())+"',iconCls:'btn_backSubscrible',handler: function(){bodyiframe.doCancel(this);}},";
}
if(haveRestartright)
{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(18095,user.getLanguage())+",javascript:doRestart(this),_self}" ;
	RCMenuHeight += RCMenuHeightStep ;
	strBar += "{text: '"+SystemEnv.getHtmlLabelName(18095,user.getLanguage())+"',iconCls:'btn_next',handler: function(){bodyiframe.doRestart(this);}},";
}
if(nodetype.equals("0")&&isremark != 1&&isremark != 9&&isremark != 7&&isremark != 5&&WfFunctionManageUtil.IsShowDelButtonByReject(requestid,workflowid)){    // �����ڵ�(�˻ش����ڵ�Ҳ��)
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
strBar += "{text: '"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+"',iconCls:'btn_doDelete',handler: function(){doDelete();}},";
}
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(257,user.getLanguage())+",javascript:openSignPrint(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;        
strBar += "{text: '"+SystemEnv.getHtmlLabelName(257,user.getLanguage())+"',iconCls:'btn_print',handler: function(){openSignPrint();}},";        
}
if(strBar.lastIndexOf(",")>-1) strBar = strBar.substring(0,strBar.lastIndexOf(","));
strBar+="]";

String needconfirm="";
RecordSet.executeSql("select t1.ismodifylog,t1.needAffirmance from workflow_base t1, workflow_requestbase t2 where t1.id=t2.workflowid and t2.requestid="+requestid);
if(RecordSet.next()) {
	needconfirm = RecordSet.getString("needAffirmance");
}

%>
<%-- end--%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script language="javascript">
enableAllmenu();
</script>
        <input type=hidden name=seeflowdoc value="<%=seeflowdoc%>">
		<input type=hidden name=isworkflowdoc value="<%=isworkflowdoc%>">
        <input type=hidden name=wfdoc value="<%=wfdoc%>">
        <input type="hidden" name="isovertime" value="<%=isovertime%>">
        <input type=hidden name=picInnerFrameurl value="/workflow/request/WorkflowRequestPictureInner.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>">

		<TABLE width="100%">
		<tr>
		<td valign="top">

    <table width="100%">
        <tr><td width="80%" align=left>
        <% if( message.equals("1") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(16332,user.getLanguage())%></font>
        <% } else if( message.equals("2") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(16333,user.getLanguage())%></font>
        <% } else if( message.equals("3") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(19455,user.getLanguage())%></font>
		<%}else if( message.equals("4") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21266,user.getLanguage())%></font>
		<%} else if( message.equals("5") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21270,user.getLanguage())%></font>
		<%} else if( message.equals("182") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21624,user.getLanguage())%></font>
		<%} else if( message.equals("183") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(24033,user.getLanguage())%></font>
		<%} else if( message.equals("24569") ) {//������ٵ�ר��--����ʱ�䲻���ڿ�ʼʱ��֮ǰ%>
        <font color=red><%=SystemEnv.getHtmlLabelName(24569,user.getLanguage())%></font>
		<%}else if( message.equals("19") ) {//�ʲ��������̱������������������
			%>
        <font color=red><%=SystemEnv.getHtmlLabelName(17273,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(1446,user.getLanguage())%></font>
		<%}else if( message.equals("201") ) {//�ʲ����������������������������
			%>
        <font color=red><%=SystemEnv.getHtmlLabelName(15313,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(1446,user.getLanguage())%></font>
		<%} else if( message.equals("6") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21766,user.getLanguage())%></font>
		<%} else if( message.equals("7") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(22751,user.getLanguage())%></font>
		<%} else if( message.equals("8") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(24676,user.getLanguage())%></font>
		<%}%>
		<font color=red><%=Util.null2String(SystemEnv.getHtmlLabelName(salesMessage,user.getLanguage()))%></font>
		<font color=red><%=Util.null2String((String)session.getAttribute(requestid+"_"+message))%></font>
        </td>
        <td width="20%" align=right>
        </td></tr>
    </table>


<%
if( !managepage.equals("")) {
%>
  <%if (fromPDA.equals("1")) {%>
		<% if(isremark == 1){ %>
		<a href="javascript:$GetEle('isremark').value='1';$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} if(isremark == 5) {%>
        <a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%></a>
		<%} else {%>
		<a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} 
		 if (isreject.equals("1")) {%>
	   <a href="javascript:$GetEle('src').value='reject';$GetEle('frmmain').submit();" ><%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%></a>
		<%}%>
		<a href="javascript:$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></a> 
		<a href="javascript:location.href='/workflow/search/WFSearchResultPDA.jsp'"><%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%></a>
	    <%}%>
<jsp:include page="<%=managepage%>" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />

    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="nextnodetype" value="<%=nextnodetype%>" />
    <jsp:param name="isreopen" value="<%=isreopen%>" />
    <jsp:param name="isreject" value="<%=isreject%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="currenttime" value="<%=currenttime%>" />
	<jsp:param name="docfileid" value="<%=docfileid%>" />
    <jsp:param name="newdocid" value="<%=newdocid%>" />
    <jsp:param name="topage" value="<%=topage%>" />
    <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
   
    <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />
</jsp:include>
<%}else{
      //modify by xhheng @20050315 for �����ϴ�
      if( operationpage.equals("") ){ 
        operationpage = "RequestOperation.jsp" ;
        %>
        <form name="frmmain" method="post" action="<%=operationpage%>"  <%if (!fromPDA.equals("1")) {%> enctype="multipart/form-data" <%}%>>
	 <%if (fromPDA.equals("1")) {%>
		<% if(isremark == 1){ %>
		<a href="javascript:$GetEle('isremark').value='1';$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} else if(isremark == 5) {%>
        <a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%></a>
		<%} else {%>
		<a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} 
		 if (isreject.equals("1")) {%>
	   <a href="javascript:$GetEle('src').value='reject';$GetEle('frmmain').submit();" ><%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%></a>
		<%}%>
		<a href="javascript:$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></a> 
		<a href="javascript:location.href='/workflow/search/WFSearchResultPDA.jsp'"><%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%></a>
	    <%}%>
        <%
      }else{
        if(hasfileup.equals("1")){
          %>
      <form name="frmmain" method="post"  action="<%=operationpage%>"  <%if (!fromPDA.equals("1")) {%> enctype="multipart/form-data" <%}%> >
        <%if (fromPDA.equals("1")) {%>
		<% if(isremark == 1){ %>
		<a href="javascript:$GetEle('isremark').value='1';$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} else if(isremark == 5) {%>
        <a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%></a>
		<%} else {%>
		<a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} 
		 if (isreject.equals("1")) {%>
	   <a href="javascript:$GetEle('src').value='reject';$GetEle('frmmain').submit();" ><%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%></a>
		<%}%>
		<a href="javascript:$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></a> 
		<a href="javascript:location.href='/workflow/search/WFSearchResultPDA.jsp'"><%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%></a>
	    <%}%>
          <%}else{%>
     
          <form name="frmmain" method="post" action="<%=operationpage%>">
          <%
            }%>
		   <%if (fromPDA.equals("1")) {%>
		<% if(isremark == 1){ %>
		<a href="javascript:$GetEle('isremark').value='1';$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} else if(isremark == 5) {%>
        <a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%></a>
		<%} else {%>
		<a href="javascript:$GetEle('src').value='submit';$GetEle('frmmain').submit();"><%=submitname%></a>
		<%} 
		 if (isreject.equals("1")) {%>
	   <a href="javascript:$GetEle('src').value='reject';$GetEle('frmmain').submit();" ><%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%></a>
		<%}%>
		<a href="javascript:$GetEle('src').value='save';$GetEle('frmmain').submit();"><%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></a> 
		<a href="javascript:location.href='/workflow/search/WFSearchResultPDA.jsp'"><%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%></a>
	    <%}%>	  
		  <%
       }%>
	   <%
			session.setAttribute(userid+"_"+workflowid+"workflowname", workflowname);
	   %>
    <%--@ include file="WorkflowManageRequestBody.jsp" --%>
<jsp:include page="WorkflowManageRequestBodyAction.jsp" flush="true">

	<jsp:param name="userid" value="<%=userid%>" />
    <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
    <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />

    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
	<jsp:param name="isbill" value="<%=isbill%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="isreopen" value="<%=isreopen%>" />
    <jsp:param name="isreject" value="<%=isreject%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="currenttime" value="<%=currenttime%>" />
    <jsp:param name="needcheck" value="<%=needcheck%>" />
	<jsp:param name="topage" value="<%=topage%>" />
	<jsp:param name="newenddate" value="<%=newenddate%>" />
	<jsp:param name="newfromdate" value="<%=newfromdate%>" />
	<jsp:param name="docfileid" value="<%=docfileid%>" />
	<jsp:param name="newdocid" value="<%=newdocid%>" />
</jsp:include>
<%
//add by mackjoe at 2006-06-07 td4491 ����ϸʱ�ż���
boolean  hasdetailb=false;
if(isbill.equals("0")) {
    RecordSet.executeSql("select count(*) from workflow_formfield  where isdetail='1' and formid="+formid);
}else{
    RecordSet.executeSql("select count(*) from workflow_billfield  where viewtype=1 and billid="+formid);
}
if(RecordSet.next()){
    if(RecordSet.getInt(1)>0) hasdetailb=true;
}
if(hasdetailb){
%>
    <%--@ include file="WorkflowManageRequestDetailBodyBill.jsp" --%>
    <jsp:include page="WorkflowManageRequestDetailBodyBill.jsp" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="newdocid" value="<%=newdocid%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="currenttime" value="<%=currenttime%>" />
	<jsp:param name="docfileid" value="<%=docfileid%>" />
    <jsp:param name="needcheck" value="<%=needcheck%>" />
    <jsp:param name="isaffirmance" value="<%=isaffirmance%>" />
    <jsp:param name="reEdit" value="<%=reEdit%>" />
    </jsp:include>
<%
    }
%>
    <%--@ include file="WorkflowManageSign.jsp" --%>
    <jsp:include page="WorkflowManageSign1.jsp" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />

    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
	<jsp:param name="isbill" value="<%=isbill%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="isreopen" value="<%=isreopen%>" />
    <jsp:param name="isreject" value="<%=isreject%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
	<jsp:param name="currentdate" value="<%=currentdate%>" />
	<jsp:param name="currenttime" value="<%=currenttime%>" />
    <jsp:param name="needcheck" value="<%=needcheck%>" />
    <jsp:param name="isworkflowdoc" value="<%=isworkflowdoc%>" />
    </jsp:include>
<input type="hidden" name="needwfback"  id="needwfback" value="1"/>
	<input type="hidden" name="lastOperator"  id="lastOperator" value="<%=lastOperator%>"/>
	<input type="hidden" name="lastOperateDate"  id="lastOperateDate" value="<%=lastOperateDate%>"/>
	<input type="hidden" name="lastOperateTime"  id="lastOperateTime" value="<%=lastOperateTime%>"/>

</form>
<%
}
int haslinkworkflow=Util.getIntValue(String.valueOf(session.getAttribute("haslinkworkflow")),0);
if(haslinkworkflow==1&&!isrequest.equals("1")){
    session.setAttribute("desrequestid",""+requestid);
}else{
    if(haslinkworkflow==0&&!isrequest.equals("1")){
        session.removeAttribute("desrequestid");
        int linkwfnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")),0);
        for(int i=0;i<=linkwfnum;i++){
            session.removeAttribute("resrequestid"+i);
        }
        session.removeAttribute("slinkwfnum");
    }
}
%>

<%
String custompage = "";
//��ѯ�ù������ı�id���Ƿ��ǵ��ݣ�0��1�ǣ��������ĵ�id
RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid+"");
if(RecordSet.next()){
	custompage = Util.null2String(RecordSet.getString("custompage"));
}
%>
<%
	if(!custompage.equals("")){
%>
		<jsp:include page="<%=custompage%>" flush="true">
			<jsp:param name="userid" value="<%=userid%>" />
		    <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
		    <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
		    <jsp:param name="requestid" value="<%=requestid%>" />
		    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
		    <jsp:param name="creater" value="<%=creater%>" />
		    <jsp:param name="creatertype" value="<%=creatertype%>" />
		    <jsp:param name="deleted" value="<%=deleted%>" />
		    <jsp:param name="billid" value="<%=billid%>" />
			<jsp:param name="isbill" value="<%=isbill%>" />
		    <jsp:param name="workflowid" value="<%=workflowid%>" />
		    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
		    <jsp:param name="formid" value="<%=formid%>" />
		    <jsp:param name="nodeid" value="<%=nodeid%>" />
		    <jsp:param name="nodetype" value="<%=nodetype%>" />
		    <jsp:param name="isreopen" value="<%=isreopen%>" />
		    <jsp:param name="isreject" value="<%=isreject%>" />
		    <jsp:param name="isremark" value="<%=isremark%>" />
			<jsp:param name="currentdate" value="<%=currentdate%>" />
			<jsp:param name="currenttime" value="<%=currenttime%>" />
		    <jsp:param name="needcheck" value="<%=needcheck%>" />
			<jsp:param name="topage" value="<%=topage%>" />
			<jsp:param name="newenddate" value="<%=newenddate%>" />
			<jsp:param name="newfromdate" value="<%=newfromdate%>" />
			<jsp:param name="docfileid" value="<%=docfileid%>" />
			<jsp:param name="newdocid" value="<%=newdocid%>" />
        </jsp:include>
<%		
	}
%>

</td>
		</tr>
		</TABLE>

</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
if (window.addEventListener){
    window.addEventListener("load", windowOnload, false);
}else if (window.attachEvent){
    window.attachEvent("onload", windowOnload);
}else{
    window.onload=windowOnload;
}

function changeTab()
{
   /*
   for(i=0;i<=1;i++){
  		parent.$GetEle("oTDtype_"+i).background="/images/tab2.png";
  		parent.$GetEle("oTDtype_"+i).className="cycleTD";
  	}
  	parent.$GetEle("oTDtype_0").background="/images/tab.active2.png";
  	parent.$GetEle("oTDtype_0").className="cycleTDCurrent";
  	*/
  	}



function doDrawBack(obj){
	if("<%=needconfirm%>"=="1"&&!confirm("<%=SystemEnv.getHtmlLabelName(24703,user.getLanguage())%>")){
		return false;
	}else{
	var ischeckok="true";
	<%
		if(isSignMustInput.equals("1")){
		    if("1".equals(isFormSignature)){
			}else{
	%>
	            if(ischeckok=="true"){
	            	getRemarkText_log();
				    if(!check_form($GetEle('frmmain'),'remarkText10404')){
					    ischeckok="false";
				    }
			    }
	<%
			}
		}
	%>
			if(ischeckok=="true"){	
				jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
				obj.disabled=true;
				$GetEle('frmmain').action="/workflow/workflow/wfFunctionManageLink.jsp?flag=ov&fromflow=1";
				//�����ϴ�
			    StartUploadAll();
		        checkuploadcomplet();
		}
	}
}
function doRetract(obj){
obj.disabled=true;
document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=rb&requestid=<%=requestid%>" //xwj for td3665 20060224
}

function showWFHelp(docid){
    var screenWidth = window.screen.width*1;
    var screenHeight = window.screen.height*1;
    var operationPage = "/docs/docs/DocDsp.jsp?id="+docid;
    window.open(operationPage,"_blank","top=0,left="+(screenWidth-800)/2+",height="+(screenHeight-90)+",width=800,status=no,scrollbars=yes,toolbar=yes,menubar=no,location=no");
}
// modify by xhheng @20050304 for TD 1691
function openSignPrint() {
    window.open("PrintRequest.jsp?requestid=<%=requestid%>&isprint=1&fromFlowDoc=<%=fromFlowDoc%>", "", "toolbar,resizable,scrollbars,dependent,height=500,width=550");
}

function returnTrue(o){
	return;
}

function addDocReadTag(docId) {
	//user.getLogintype() ��ǰ�û�����  1: ����û�  2:�ⲿ�û�
	DocReadTagUtil.addDocReadTag(docId,<%=user.getUID()%>,<%=user.getLogintype()%>,"<%=request.getRemoteAddr()%>",returnTrue);

}
/** added by cyril on 2008-07-10 for TD:8835*/
function doViewModifyLog() {
	window.open("/workflow/request/RequestModifyLogView.jsp?requestid=<%=requestid%>&nodeid=<%=nodeid%>&isAll=0&ismonitor=<%=wfmonitor?"1":"0"%>&urger=0");
}
/** end by cyril on 008-07-10 for TD:8835*/
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
function doEdit(obj){
	parent.location.href="ViewRequest.jsp?reEdit=1&fromFlowDoc=<%=fromFlowDoc%>&requestid=<%=requestid%>&isovertime=<%=isovertime%>&topage=<%=topage%>";
}
function doSubmitBack(obj){
	$GetEle("needwfback").value = "1";
	getRemarkText_log();
	doSubmit(obj);
}
function doSubmitNoBack(obj){
	$GetEle("needwfback").value = "0";
	getRemarkText_log();
	doSubmit(obj);
}
function doRemark_nBack(obj){
	$GetEle("needwfback").value = "1";
	getRemarkText_log();
	doRemark_n(obj);
}
function doRemark_nNoBack(obj){
	$GetEle("needwfback").value = "0";
	getRemarkText_log();
	doRemark_n(obj);
}
function doAffirmanceBack(obj){
	$GetEle("needwfback").value = "1";
	getRemarkText_log();
	doAffirmance(obj);
}
function doAffirmanceNoBack(obj){
	$GetEle("needwfback").value = "0";
	getRemarkText_log();
	doAffirmance(obj);
}
function doSave_nNew(obj){
	getRemarkText_log();
	doSave_n(obj);
}
function doReject_New(){
	getRemarkText_log();
	doReject();
}
function doSubmit_Pre(obj){
	getRemarkText_log();
	doSubmit(obj);
}
function getRemarkText_log(){
	try{
		var reamrkNoStyle = FCKEditorExt.getText("remark");
		if(reamrkNoStyle == ""){
			$GetEle("remarkText10404").value = reamrkNoStyle;
		}else{
			var remarkText = FCKEditorExt.getTextNew("remark");
			$GetEle("remarkText10404").value = remarkText;
		}
		for(var i=0; i<FCKEditorExt.editorName.length; i++){
			var tmpname = FCKEditorExt.editorName[i];
			try{
				if(tmpname == "remark"){
					continue;
				}
				$(tmpname).value = FCKEditorExt.getText(tmpname);
			}catch(e){}
		}
	}catch(e){
	}
}

function triSubwf(paramSubwfSetId){
	$GetEle("triSubwfIframe").src="/workflow/request/TriSubwfIframe.jsp?operation=triSubwf&requestId=<%=requestid%>&nodeId=<%=nodeid%>&paramSubwfSetId="+paramSubwfSetId;
}

function triSubwf2(paramSubwfSetId,subworkflowname){
	subworkflowname = subworkflowname.replace(new RegExp(',',"gm"),'\n');
	var info = "<%=SystemEnv.getHtmlLabelName(25394,user.getLanguage())%>:"+"\n"+subworkflowname+"<%=SystemEnv.getHtmlLabelName(25395,user.getLanguage())%>";
	if(confirm(info)){
		$GetEle("triSubwfIframe").src="/workflow/request/TriSubwfIframe.jsp?operation=triSubwf&requestId=<%=requestid%>&nodeId=<%=nodeid%>&paramSubwfSetId="+paramSubwfSetId;
	}
}

function returnTriSubwf(returnString){
	if(returnString==1){
		alert("<%=SystemEnv.getHtmlLabelName(22064,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(498,user.getLanguage())%>");
	}else {
		alert("<%=SystemEnv.getHtmlLabelName(22064,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15242,user.getLanguage())%>");
	}
}
function doFreeWorkflow(){
    window.showModalDialog("/workflow/workflow/BrowserMain.jsp?url=/workflow/request/FreeWorkflowSet.jsp?requestid=<%=requestid%>",window);
}
function onNewOverTime(){
	var redirectUrl =  "/workflow/request/OverTimeSetByNodeUser.jsp?workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&requestid=<%=requestid%>&formid=<%=formid%>&isbill=1&billid=<%=billid%>";
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
function onSetRejectNode(){
    <%
     if((isrejectremind.equals("1")&&ischangrejectnode.equals("1"))||isselectrejectnode.equals("1")){
 %>
     var url=escape("/workflow/request/RejectNodeSet.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=currentnodeid%>&isrejectremind=<%=isrejectremind%>&ischangrejectnode=<%=ischangrejectnode%>&isselectrejectnode=<%=isselectrejectnode%>");
    var result = showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
     if (result != null) {
          var val=result.split("|");
        if($GetEle("RejectNodes")) $GetEle("RejectNodes").value=val[0];
        if($GetEle("RejectToNodeid")) $GetEle("RejectToNodeid").value=val[1]; 
		return true;
    }else{
        return false;
    }
    <%}else{%>
    return true;
    <%}%>
}    
</SCRIPT>
<!-- added by cyril on 20080610 for td8828-->
<script language=javascript src="/js/checkData.js"></script>
<script type="text/javascript" src="/js/swfupload/workflowswfupload.js"></script>
<script language="JavaScript">
	if("<%=seeflowdoc%>"=="1"){
		if($GetEle("rightMenu")!=null){
			$GetEle("rightMenu").style.display="none";
		}
	}
<%if("1".equals(session.getAttribute("istest"))){%>
function setAdiabled(){
	jQuery("a").attr("disabled", true);
	jQuery("a").attr("onclick", "");
	jQuery("a").attr("href", "");
	jQuery("a").attr("target", "_blank");
}
function setAdiabledLoad(){
	setAdiabled();
	setInterval(setAdiabled, 500);
}
jQuery(document).ready(function(){
	setAdiabledLoad();
});
<%}%>
</script>
