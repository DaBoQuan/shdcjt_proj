<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util,weaver.general.BaseBean" %>
<%@ page import="weaver.general.AttachFileUtil" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.workflow.request.RevisionConstants" %>
<%--@ page import="java.sql.Timestamp" --%>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSetlog3" class="weaver.conn.RecordSet" scope="page" /> <%-- added by xwj for td2891--%>
<%@page import = "weaver.general.TimeUtil"%>
<%@ page import="weaver.workflow.request.ComparatorUtilBean"%>
<!--added by xwj for td2891-->
<jsp:useBean id="rsCheckUserCreater" class="weaver.conn.RecordSet" scope="page" /> <%-- added by xwj for td2891--%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<!--jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/-->
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<!--jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" /-->
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="docinf" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="wfrequestcominfo" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="WorkflowPhrase" class="weaver.workflow.sysPhrase.WorkflowPhrase" scope="page"/>
<jsp:useBean id="RecordSetLog" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<jsp:useBean id="RecordSetLog1" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<jsp:useBean id="RecordSetLog2" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<!--jsp:useBean id="RecordSetOld" class="weaver.conn.RecordSet" scope="page" /--> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="WFNodeMainManager" class="weaver.workflow.workflow.WFNodeMainManager" scope="page" />
<jsp:useBean id="requestNodeFlow" class="weaver.workflow.request.RequestNodeFlow" scope="page" />
<jsp:useBean id="WFManager" class="weaver.workflow.workflow.WFManager" scope="page"/>
<jsp:useBean id="RequestUseTempletManager" class="weaver.workflow.request.RequestUseTempletManager" scope="page" />
<jsp:useBean id="RequestSignatureManager" class="weaver.workflow.request.RequestSignatureManager" scope="page" />
<script type="text/javascript" src="/wui/common/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/wui/common/js/ckeditor/ckeditorext.js"></script>

<%
//TD9892
BaseBean bb_workflowMSmode = new BaseBean();
int urm_workflowMSmode = 1;
try{
	urm_workflowMSmode = Util.getIntValue(bb_workflowMSmode.getPropValue("systemmenu", "userightmenu"), 1);
}catch(Exception e){}

int requestid = Util.getIntValue(request.getParameter("requestid"),0);
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);
String nodetype= Util.null2String(request.getParameter("nodetype"));
String isremark=Util.null2String(request.getParameter("isremark"));
String isOldWf=Util.null2String(request.getParameter("isOldWf"));

boolean isOldWf_ = false;
if(isOldWf.trim().equals("true")) isOldWf_=true;
String creatername="";
// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());
int workflowid=Util.getIntValue(request.getParameter("workflowid"),0);           //������id
String currentdate= Util.null2String(request.getParameter("currentdate"));
String currenttime= Util.null2String(request.getParameter("currenttime"));
String needcheck="";
String needconfirm="";
String isSignDoc_edit="";
String isSignWorkflow_edit="";
String isannexupload_edit="";
String annexdocCategory_edit="";
RecordSetLog.execute("select needAffirmance,isannexupload,annexdocCategory,isSignDoc,isSignWorkflow from workflow_base where id="+workflowid);
if(RecordSetLog.next()){
    needconfirm=Util.null2o(RecordSetLog.getString("needAffirmance"));
    isannexupload_edit=Util.null2String(RecordSetLog.getString("isannexupload"));
    annexdocCategory_edit=Util.null2String(RecordSetLog.getString("annexdocCategory"));
    isSignDoc_edit=Util.null2String(RecordSetLog.getString("isSignDoc"));
    isSignWorkflow_edit=Util.null2String(RecordSetLog.getString("isSignWorkflow"));
}
String isSignMustInput="0";
RecordSetLog.execute("select issignmustinput from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSetLog.next()){
	isSignMustInput = ""+Util.getIntValue(RecordSetLog.getString("issignmustinput"), 0);
}

/**���̴�Ϊ�ĵ��Ƿ�Ҫǩ�����**/
boolean fromworkflowtodoc = Util.null2String((String)session.getAttribute("urlfrom_workflowtodoc_"+requestid)).equals("true");
boolean ReservationSign = false;
RecordSet.executeSql("select * from workflow_base where id = " + workflowid);
if(RecordSet.next()) ReservationSign = (RecordSet.getInt("keepsign")==2);
if(fromworkflowtodoc&&ReservationSign){
	return;
}
/**���̴�Ϊ�ĵ��Ƿ�Ҫǩ�����**/

    String billtablename = "";
    int operatorsize = 0;
    int formid=Util.getIntValue(request.getParameter("formid"),0);
    int isbill=Util.getIntValue(request.getParameter("isbill"),0);
    int billid=Util.getIntValue(request.getParameter("billid"),0);
    int creater = Util.getIntValue(request.getParameter("creater"),0);
    int creatertype =Util.getIntValue(request.getParameter("creatertype"),0);

//TD4262 ������ʾ��Ϣ  ��ʼ
    String ismode= Util.null2String(request.getParameter("ismode"));
//TD4262 ������ʾ��Ϣ  ����
    String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //�Ƿ�����̴����ĵ�����
    String isworkflowdoc = Util.getIntValue(request.getParameter("isworkflowdoc"),0)+"";//�Ƿ�Ϊ����

    int usertype = (user.getLogintype()).equals("1") ? 0 : 1;
    creatername=ResourceComInfo.getResourcename(""+creater);
    boolean hasnextnodeoperator = false;
    Hashtable operatorsht = new Hashtable();
    String intervenoruserids="";
    String intervenorusernames="";
    int nextnodeid=nodeid;
if(isremark.equals("5")){
if (isbill == 1) {
			RecordSet.executeSql("select tablename from workflow_bill where id = " + formid); // ��ѯ���������ݱ����Ϣ
			if (RecordSet.next())
				billtablename = RecordSet.getString("tablename");          // ��õ��ݵ�����
}
//��ѯ�ڵ������
        requestNodeFlow.setRequestid(requestid);
		requestNodeFlow.setNodeid(nodeid);
		requestNodeFlow.setNodetype(nodetype);
		requestNodeFlow.setWorkflowid(workflowid);
		requestNodeFlow.setUserid(userid);
		requestNodeFlow.setUsertype(usertype);
		requestNodeFlow.setCreaterid(creater);
		requestNodeFlow.setCreatertype(creatertype);
		requestNodeFlow.setIsbill(isbill);
		requestNodeFlow.setBillid(billid);
		requestNodeFlow.setBilltablename(billtablename);
		requestNodeFlow.setRecordSet(RecordSet);
		hasnextnodeoperator = requestNodeFlow.getNextNodeOperator();

		if(hasnextnodeoperator){
			operatorsht = requestNodeFlow.getOperators();
            nextnodeid=requestNodeFlow.getNextNodeid();
            operatorsize = operatorsht.size();
            if(operatorsize > 0){

                TreeMap map = new TreeMap(new ComparatorUtilBean());
				Enumeration tempKeys = operatorsht.keys();
				try{
				while (tempKeys.hasMoreElements()) {
					String tempKey = (String) tempKeys.nextElement();
					ArrayList tempoperators = (ArrayList) operatorsht.get(tempKey);
					map.put(tempKey,tempoperators);
				}
				}catch(Exception e){}
				Iterator iterator = map.keySet().iterator();
				while(iterator.hasNext()) {
				String operatorgroup = (String) iterator.next();
				ArrayList operators = (ArrayList) operatorsht.get(operatorgroup);
				for (int i = 0; i < operators.size(); i++) {
				    String operatorandtype = (String) operators.get(i);
						String[] operatorandtypes = Util.TokenizerString2(operatorandtype, "_");
						String opertor = operatorandtypes[0];
						String opertortype = operatorandtypes[1];
                        intervenoruserids+=opertor+",";
                        if("0".equals(opertortype)){
						intervenorusernames += "<A href='javaScript:openhrm("+opertor+");' onclick='pointerXY(event);'>"+ResourceComInfo.getResourcename(opertor)+"</A>&nbsp;";
						}else{
						intervenorusernames += CustomerInfoComInfo.getCustomerInfoname(opertor)+" ";
						}

				}
                }
        }
        }
    if(intervenoruserids.length()>1){
        intervenoruserids=intervenoruserids.substring(0,intervenoruserids.length()-1);
    }
    needcheck+=",Intervenorid";
    if(isremark.equals("5"))  needcheck="";
%>
<iframe id="workflownextoperatorfrm" frameborder=0 scrolling=no src=""  style="display:none;"></iframe>
<%}
%>
<br>

<!--TD4262 ������ʾ��Ϣ  ��ʼ-->

<%
    if(ismode.equals("1")){
%>

<div id="divFavContent16332" style="display:none"><!--��������Ϣ�������-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(16332,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent16333" style="display:none"><!--��������һ�ڵ����һ�ڵ�����ߴ���-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(16333,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>


<div id="divFavContent18978" style="display:none"><!--�����ύ���̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent18979" style="display:none"><!--���ڱ������̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent18980" style="display:none"><!--�����˻����̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18980,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent18984" style="display:none"><!--����ɾ�����̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18984,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent24676" style="display:none"><!--���������Ѹ��ģ���˶Ժ��ٴ���-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(24676,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>
<%
    }else{
%>
<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<%
    }
%>
<!--TD4262 ������ʾ��Ϣ  ����-->
<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<iframe id="checkReportDataForm" frameborder=0 scrolling=no src="javascript:false"  style="display:none"></iframe>
<iframe id="showtipsinfoiframe" name="showtipsinfoiframe" frameborder=0 scrolling=no src="javascript:false"  style="display:none"></iframe>
<input type=hidden name="divcontent" value="">
<input type=hidden name="content" value="">

<table width="100%" id=t_sign>
<tr>
<td width="50%"  valign="top">
<input type=hidden name="isremark" value="<%=isremark%>">
<!-- added by pony on 2006-05-11 for TD4264 begin -->
<input type=hidden name="requestid" value="<%=requestid%>">
<input type=hidden name="nodeid" value="<%=nodeid%>">
<input type=hidden name="nodetype" value="<%=nodetype%>">
<input type=hidden name="workflowid" value="<%=workflowid%>">
<input type=hidden name="currentdate" value="<%=currentdate%>">
<input type=hidden name="currenttime" value="<%=currenttime%>">
<input type=hidden name="formid" value="<%=formid%>">
<input type=hidden name="isbill" value="<%=isbill%>">
<input type=hidden name="billid" value="<%=billid%>">
<input type=hidden name="creater" value="<%=creater%>">
<input type=hidden name="creatertype" value="<%=creatertype%>">
<input type=hidden name="ismode" value="<%=ismode%>">
<input type=hidden name="RejectNodes" value="">
<input type=hidden name="RejectToNodeid" value="">
<%
//ģ�����Ƿ�����ǩ���ֶΣ���������˰�ģ��ģʽ��ʾ�����û�����ð���ǰģʽ��ʾ
RecordSet.executeSql("select * from workflow_modeview where formid="+formid+" and nodeid="+nodeid+" and fieldid=-4");
String hasSign = "0";
if(RecordSet.next()){hasSign="1";}
%>
<%if(hasSign.equals("0")){%>
<input type=hidden name="workflowRequestLogId" value="-1">
<%}%>
<!-- added end. -->
<%--added by xwj for td 2104 on 2005-08-1 begin--%>
  <table class="viewform">
        <!-- modify by xhheng @20050308 for TD 1692 -->
         <COLGROUP>
         <COL width="20%">
         <COL width="80%">
         <%if(isremark.equals("5")){%>
         <tr><td colspan="2"><b><%=SystemEnv.getHtmlLabelName(18913,user.getLanguage())%></b></td></tr>
         <TR class=spacing>
            <TD class=line1 colSpan=2></TD>
        </TR>
         <tr>
             <td><%=SystemEnv.getHtmlLabelName(18914,user.getLanguage())%></td>
             <td class=field>
                 <select class=inputstyle  id="submitNodeId" name=submitNodeId  onChange='nodechange(this.value)'>
                 <%
                 WFNodeMainManager.setWfid(workflowid);
                 WFNodeMainManager.selectWfNode();
                 while(WFNodeMainManager.next()){
                    int tmpid = WFNodeMainManager.getNodeid();
                    if(tmpid==nodeid) continue;
                    String tmpname = WFNodeMainManager.getNodename();
                    String tmptype = WFNodeMainManager.getNodetype();
                 %>
                 <option value="<%=tmpid%>_<%=tmptype%>" <%if(nextnodeid==tmpid){%>selected<%}%>><%=tmpname%></option>
                 <%}%>
                 </select>
             </td>
         </tr>
	<TR class=spacing>
            <TD class=line2 colSpan=2></TD>
        </TR>
         <tr>
             <td><%=SystemEnv.getHtmlLabelName(18915,user.getLanguage())%></td>
             <td class=field>
                 <span id="Intervenorspan">
                     <%if(intervenoruserids.equals("")){%>
                     <button class=Browser onclick="onShowMutiHrm('Intervenorspan','Intervenorid')" ></button>
                     <%}%><%=intervenorusernames%><%if(intervenorusernames.equals("")){%><img src='/images/BacoError.gif' align=absmiddle><%}%></span>
                 <input type=hidden name="Intervenorid" value="<%=intervenoruserids%>">
             </td>
         </tr>
	<TR class=spacing>
            <TD class=line2 colSpan=2></TD>
        </TR>
         <%
         }
boolean IsBeForwardCanSubmitOpinion="true".equals(session.getAttribute(userid+"_"+requestid+"IsBeForwardCanSubmitOpinion"))?true:false;
String isFormSignature=null;
int formSignatureWidth=RevisionConstants.Form_Signature_Width_Default;
int formSignatureHeight=RevisionConstants.Form_Signature_Height_Default;
RecordSet.executeSql("select isFormSignature,formSignatureWidth,formSignatureHeight  from workflow_flownode where workflowId="+workflowid+" and nodeId="+nodeid);
if(RecordSet.next()){
	isFormSignature = Util.null2String(RecordSet.getString("isFormSignature"));
	formSignatureWidth= Util.getIntValue(RecordSet.getString("formSignatureWidth"),RevisionConstants.Form_Signature_Width_Default);
	formSignatureHeight= Util.getIntValue(RecordSet.getString("formSignatureHeight"),RevisionConstants.Form_Signature_Height_Default);
}
int isUseWebRevision_t = Util.getIntValue(new weaver.general.BaseBean().getPropValue("weaver_iWebRevision","isUseWebRevision"), 0);
if(isUseWebRevision_t != 1){
	isFormSignature = "";
}
if(hasSign.equals("0")&&IsBeForwardCanSubmitOpinion){
        int annexmainId=0;
         int annexsubId=0;
         int annexsecId=0;

         if("1".equals(isannexupload_edit) && annexdocCategory_edit!=null && !annexdocCategory_edit.equals("")){
            annexmainId=Util.getIntValue(annexdocCategory_edit.substring(0,annexdocCategory_edit.indexOf(',')));
            annexsubId=Util.getIntValue(annexdocCategory_edit.substring(annexdocCategory_edit.indexOf(',')+1,annexdocCategory_edit.lastIndexOf(',')));
            annexsecId=Util.getIntValue(annexdocCategory_edit.substring(annexdocCategory_edit.lastIndexOf(',')+1));
          }
         int annexmaxUploadImageSize=Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+annexsecId),5);
         if(annexmaxUploadImageSize<=0){
            annexmaxUploadImageSize = 5;
         }
         char flag1 = Util.getSeparator();
         RecordSet.executeProc("workflow_RequestLog_SBUser",""+requestid+flag1+""+userid+flag1+""+usertype+flag1+"1");
         String myremark = "" ;
         String annexdocids = "" ;
         String signdocids="";
         String signworkflowids="";
		 int workflowRequestLogId=-1;
         if(RecordSet.next())
         {
            myremark = Util.null2String(RecordSet.getString("remark"));
            myremark = Util.StringReplace(myremark,"&lt;br&gt;","\n");
            annexdocids=Util.null2String(RecordSet.getString("annexdocids"));
			workflowRequestLogId=Util.getIntValue(RecordSet.getString("requestLogId"),-1);
			signdocids=Util.null2String(RecordSet.getString("signdocids"));
			signworkflowids=Util.null2String(RecordSet.getString("signworkflowids"));
         }
         String signdocname="";
        String signworkflowname="";
        ArrayList templist=Util.TokenizerString(signdocids,",");
        for(int i=0;i<templist.size();i++){
            signdocname+="<a href='/docs/docs/DocDsp.jsp?isrequest=1&id="+templist.get(i)+"' target='_blank'>"+docinf.getDocname((String)templist.get(i))+"</a> ";
        }
        templist=Util.TokenizerString(signworkflowids,",");
        int tempnum = Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
        for(int i=0;i<templist.size();i++){
                tempnum++;
                session.setAttribute("resrequestid" + tempnum, "" + templist.get(i));
            signworkflowname+="<a style=\"cursor:hand\" onclick=\"openFullWindowHaveBar('/workflow/request/ViewRequest.jsp?isrequest=1&requestid="+templist.get(i)+"&wflinkno="+tempnum+"')\">"+wfrequestcominfo.getRequestName((String)templist.get(i))+"</a> ";
        }
        session.setAttribute("slinkwfnum", "" + tempnum);
        session.setAttribute("haslinkworkflow", "1");

         //String workflowPhrases[] = WorkflowPhrase.getUserWorkflowPhrase(""+userid);
        //add by cyril on 2008-09-30 for td:9014
    		boolean isSuccess  = RecordSet.executeProc("sysPhrase_selectByHrmId",""+userid); 
    		String workflowPhrases[] = new String[RecordSet.getCounts()];
    		String workflowPhrasesContent[] = new String[RecordSet.getCounts()];
    		int x = 0 ;
    		if (isSuccess) {
    			while (RecordSet.next()){
    				workflowPhrases[x] = Util.null2String(RecordSet.getString("phraseShort"));
    				workflowPhrasesContent[x] = Util.toHtml(Util.null2String(RecordSet.getString("phrasedesc")));
    				x ++ ;
    			}
    		}
    		//end by cyril on 2008-09-30 for td:9014
         /*----------xwj for td3034 20051118 begin ------*/
         %>
         <tr class="Title">
                  <td colspan=2 align="center" valign="middle"><font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></font></td>
                </tr>
            <tr>
              <td><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></td>
              <td class=field>

         <%

if("1".equals(isFormSignature)){
%>
		<jsp:include page="/workflow/request/WorkflowLoadSignature.jsp">
			<jsp:param name="workflowRequestLogId" value="<%=workflowRequestLogId%>" />
			<jsp:param name="isSignMustInput" value="<%=isSignMustInput%>" />
			<jsp:param name="formSignatureWidth" value="<%=formSignatureWidth%>" />
			<jsp:param name="formSignatureHeight" value="<%=formSignatureHeight%>" />
		</jsp:include>
         <script defer>
             function funcremark_log() {
             }
         </script>
<%
}else{
         if(workflowPhrases.length>0){
         %>
                <select class=inputstyle  id="phraseselect" name=phraseselect style="width:80%" onChange='onAddPhrase(this.value)' disabled=true onmousewheel="return false;">
                <option value="">����<%=SystemEnv.getHtmlLabelName(22409,user.getLanguage())%>����</option>
                <%
                  for (int i= 0 ; i <workflowPhrases.length;i++) {
                    String workflowPhrase = workflowPhrases[i] ;  %>
                    <option value="<%=workflowPhrasesContent[i]%>"><%=workflowPhrase%></option>
                <%}%>
                </select>
              <%}%>
  				<input type="hidden" id="remarkText10404" name="remarkText10404" temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>" value="">
            <textarea  class=Inputstyle name=remark id=remark rows=4 cols=40 style="width:80%;display:none" temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"   <%if(isSignMustInput.equals("1")){%>onChange="checkinput('remark','remarkSpan')"<%}%>><%=myremark%></textarea>
	  		   	<script defer>
	  		   	function funcremark_log(){
	  		   		CkeditorExt.initEditor("frmmain","remark",<%=user.getLanguage()%>,CkeditorExt.NO_IMAGE, 200);
				<%if(isSignMustInput.equals("1")){%>
					CkeditorExt.checkText("remarkSpan","remark");
				<%}%>
					CkeditorExt.toolbarExpand(false,"remark");
				}
				</script>
              <span id="remarkSpan">
<%
	if(isSignMustInput.equals("1")&&"".equals(myremark)){
%>
			  <img src="/images/BacoError.gif" align=absmiddle>
<%
	}
%>
              </span>
<%}%>
         </td> </tr>
         <tr><td class=Line2 colSpan=2></td></tr>
         <%
         if("1".equals(isSignDoc_edit)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signdocids" name="signdocids" value="<%=signdocids%>">
                <button class=Browser onclick="onShowSignBrowser('/docs/docs/MutiDocBrowser.jsp','/docs/docs/DocDsp.jsp?isrequest=1&id=','signdocids','signdocspan',37)" title="<%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%>"></button>
                <span id="signdocspan"><%=signdocname%></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         if("1".equals(isSignWorkflow_edit)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signworkflowids" name="signworkflowids" value="<%=signworkflowids%>">
                <button class=Browser onclick="onShowSignBrowser('/workflow/request/MultiRequestBrowser.jsp','/workflow/request/ViewRequest.jsp?isrequest=1&requestid=','signworkflowids','signworkflowspan',152)" title="<%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%>"></button>
                <span id="signworkflowspan"><%=signworkflowname%></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
            if("1".equals(isannexupload_edit)){
         %>
        <tr>
            <td><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></td>
            <td class=field>
          <table cols=3 id="field-annexupload_tab">
          <tbody ><col width="50%" >
            <col width="25%" >
            <col width="25%">
           <%
            int linknum=-1;
            if(!annexdocids.equals("")){
            RecordSet.executeSql("select id,docsubject,accessorycount,SecCategory from docdetail where id in("+annexdocids+") order by id asc");
            while(RecordSet.next()){
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
              int accessoryCount=RecordSet.getInt(3);
              String SecCategory=Util.null2String(RecordSet.getString(4));

              DocImageManager.resetParameter();
              DocImageManager.setDocid(Util.getIntValue(showid));
              DocImageManager.selectDocImageInfo();

              String docImagefileid = "";
              long docImagefileSize = 0;
              String docImagefilename = "";
              String fileExtendName = "";
              int versionId = 0;

              if(DocImageManager.next()){
                //DocImageManager��õ�doc��һ�����������°汾
                docImagefileid = DocImageManager.getImagefileid();
                docImagefileSize = DocImageManager.getImageFileSize(Util.getIntValue(docImagefileid));
                docImagefilename = DocImageManager.getImagefilename();
                fileExtendName = docImagefilename.substring(docImagefilename.lastIndexOf(".")+1).toLowerCase();
                versionId = DocImageManager.getVersionId();
              }
             if(accessoryCount>1){
               fileExtendName ="htm";
             }
              boolean nodownload=SecCategoryComInfo1.getNoDownload(SecCategory).equals("1")?true:false;
              String imgSrc= AttachFileUtil.getImgStrbyExtendName(fileExtendName,20);
              %>

          <tr>
            <input type=hidden name="field-annexupload_del_<%=linknum%>" value="0" >
            <td >
              <%=imgSrc%>
              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openFullWindowHaveBar('/docs/docs/DocDspExt.jsp?id=<%=showid%>&imagefileId=<%=docImagefileid%>&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>')"><%=docImagefilename%></a>&nbsp
              <%}else{%>
                <a style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openFullWindowHaveBar('/docs/docs/DocDsp.jsp?id=<%=showid%>&isrequest=1&requestid=<%=requestid%>')"><%=tempshowname%></a>&nbsp
              <%}%>
              <input type=hidden name="field-annexupload_id_<%=linknum%>" value=<%=showid%>>
            </td>
            <td >
                <button class=btnFlow accessKey=1  onclick='onChangeSharetype("span-annexupload_id_<%=linknum%>","field-annexupload_del_<%=linknum%>","0",oUploadannexupload)'><u><%=linknum%></u>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%>
                </button><span id="span-annexupload_id_<%=linknum%>" name="span-annexupload_id_<%=linknum%>" style="visibility:hidden">
                    <b><font COLOR="#FF0033">��</font></b>
                  <span>
            </td>
            <%if(accessoryCount==1 && ((!fileExtendName.equalsIgnoreCase("xls")&&!fileExtendName.equalsIgnoreCase("doc"))||!nodownload)){%>
            <td >
              <span id = "selectDownload">
                  <button class=btnFlowd accessKey=1  onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>')">
                    <u><%=linknum%></u>-<%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%>	  (<%=docImagefileSize/1000%>K)
                  </button>
              </span>
            </td>
            <%}%>
          </tr>
              <%}}%>
            <input type=hidden name="field-annexupload_idnum" value=<%=linknum+1%>>
            <input type=hidden name="field-annexupload_idnum_1" value=<%=linknum+1%>>
          <tr>
            <td colspan=3>
            <%if(annexsecId<1){%>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(21418,user.getLanguage())+SystemEnv.getHtmlLabelName(15808,user.getLanguage())%>!</font>
           <%}else{%>
              <script>
          var oUploadannexupload;
          function fileuploadannexupload() {
        var settings = {
            flash_url : "/js/swfupload/swfupload.swf",
            upload_url: "/docs/docupload/MultiDocUploadByWorkflow.jsp",    // Relative to the SWF file
            post_params: {
                "mainId":"<%=annexmainId%>",
                "subId":"<%=annexsubId%>",
                "secId":"<%=annexsecId%>",
                "userid":"<%=user.getUID()%>",
                "logintype":"<%=user.getLogintype()%>"
            },
            file_size_limit :"<%=annexmaxUploadImageSize%> MB",
            file_types : "*.*",
            file_types_description : "All Files",
            file_upload_limit : 100,
            file_queue_limit : 0,
            custom_settings : {
                progressTarget : "fsUploadProgressannexupload",
                cancelButtonId : "btnCancelannexupload",
                uploadfiedid:"field-annexupload"
            },
            debug: false,


            // Button settings

            button_image_url : "/js/swfupload/add.png",    // Relative to the SWF file
            button_placeholder_id : "spanButtonPlaceHolderannexupload",

            button_width: 100,
            button_height: 18,
            button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
            button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
            button_text_top_padding: 0,
            button_text_left_padding: 18,

            button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
            button_cursor: SWFUpload.CURSOR.HAND,

            // The event handler functions are defined in handlers.js
            file_queued_handler : fileQueued,
            file_queue_error_handler : fileQueueError,
            file_dialog_complete_handler : fileDialogComplete_2,
            upload_start_handler : uploadStart,
            upload_progress_handler : uploadProgress,
            upload_error_handler : uploadError,
            upload_success_handler : uploadSuccess_1,
            upload_complete_handler : uploadComplete_1,
            queue_complete_handler : queueComplete    // Queue plugin event
        };


        try {
            oUploadannexupload=new SWFUpload(settings);
        } catch(e) {
            alert(e)
        }
    }
        	//window.attachEvent("onload", fileuploadannexupload);
        	if (window.addEventListener){
  			    window.addEventListener("load", fileuploadannexupload, false);
  			}else if (window.attachEvent){
  			    window.attachEvent("onload", fileuploadannexupload);
  			}else{
  			    window.onload=fileuploadannexupload;
  			}
        </script>
      <TABLE class="ViewForm">
          <tr>
              <td colspan="2">
                  <div>
                      <span>
                      <span id="spanButtonPlaceHolderannexupload"></span><!--ѡȡ����ļ�-->
                      </span>
                      &nbsp;&nbsp;
								<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUploadannexupload.cancelQueue();" id="btnCancelannexupload">
									<span><img src="/js/swfupload/delete.gif" border="0"></span>
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--�������ѡ��--></span>
								</span><span>(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%><%=annexmaxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>)</span>
                      <span id="field-annexuploadspan"></span>
                  </div>
                  <input  class=InputStyle  type=hidden size=60 name="field-annexupload" id="field-annexupload" value="<%=annexdocids%>">
              </td>
          </tr>
          <tr>
              <td colspan="2">
                  <div class="fieldset flash" id="fsUploadProgressannexupload">
                  </div>
                  <div id="divStatusannexupload"></div>
              </td>
          </tr>
      </TABLE>
           <%}%>
              <input type=hidden name='annexmainId' value=<%=annexmainId%>>
          <input type=hidden name='annexsubId' value=<%=annexsubId%>>
          <input type=hidden name='annexsecId' value=<%=annexsecId%>>
            </td>
          </tr>
          </tbody>
          </table>
          </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}
}else{%>
         <script defer>
             function funcremark_log() {
             }
         </script>
<%}%>
        </table>
        
<%
    boolean hasUseTempletSucceed=false;
    boolean isUseTempletNode=false;
    boolean hasSignatureSucceed=false;
    if("1".equals(fromFlowDoc)||"1".equals(isworkflowdoc)){
    	hasUseTempletSucceed=RequestUseTempletManager.ifHasUseTempletSucceed(requestid);
    	isUseTempletNode=RequestUseTempletManager.ifIsUseTempletNode(requestid,user.getUID(),user.getLogintype());
    	hasSignatureSucceed=RequestSignatureManager.ifHasSignatureSucceed(requestid,nodeid,user.getUID(),Util.getIntValue(user.getLogintype(),1));
    }
%>
<input type="hidden" name="temphasUseTempletSucceed" id="temphasUseTempletSucceed" value="<%=hasUseTempletSucceed%>"/>
<input type="hidden" name="isUseTempletNode" id="isUseTempletNode" value="<%=isUseTempletNode%>"/>

<%--added by xwj for td 2104 on 2005-08-1 end--%>
<!--����ɾ��ǩ������ֶ� by ben 2007-3-16-->

		           <%
boolean isLight = false;
int nLogCount=0;

/*--  xwj for td2104 on 20050802 B E G I N --*/
String viewLogIds = "";
ArrayList canViewIds = new ArrayList();
String viewNodeId = "-1";
String tempNodeId = "-1";
String singleViewLogIds = "-1";
char procflag=Util.getSeparator();
//RecordSetLog.executeSql("select distinct nodeid from workflow_currentoperator where requestid="+requestid+" and userid="+user.getUID());

if(nodeid>0){
viewNodeId = ""+nodeid;
RecordSetLog1.executeSql("select viewnodeids from workflow_flownode where workflowid=" + workflowid + " and nodeid="+viewNodeId);
if(RecordSetLog1.next()){
singleViewLogIds = RecordSetLog1.getString("viewnodeids");
}

if("-1".equals(singleViewLogIds)){//ȫ���鿴
RecordSetLog2.executeSql("select nodeid from workflow_flownode where workflowid= " + workflowid+" and exists(select 1 from workflow_nodebase where id=workflow_flownode.nodeid and (requestid is null or requestid="+requestid+"))");
while(RecordSetLog2.next()){
tempNodeId = RecordSetLog2.getString("nodeid");
if(!canViewIds.contains(tempNodeId)){
canViewIds.add(tempNodeId);
}
}
}
else if(singleViewLogIds == null || "".equals(singleViewLogIds)){//ȫ�����ܲ鿴

}
else{//�鿴����
String tempidstrs[] = Util.TokenizerString2(singleViewLogIds, ",");
for(int i=0;i<tempidstrs.length;i++){
if(!canViewIds.contains(tempidstrs[i])){
canViewIds.add(tempidstrs[i]);
}
}
}
}
if(canViewIds.size()>0){
for(int a=0;a<canViewIds.size();a++)
{
viewLogIds += (String)canViewIds.get(a) + ",";
}
viewLogIds = viewLogIds.substring(0,viewLogIds.length()-1);
}
else{
viewLogIds = "-1";
}
//RecordSet.executeProc("workflow_RequestLog_SNSave",""+requestid + procflag + "17,18");

/*----added by xwj for td2891 begin-----*/
//������id�Ѿ���ҳ���õ��ˣ�����Ҫ�����ݿ���ȡ�����ε��� mackjoe at 2006-06-12 td4491
/*
String tempWorkflowid = "-1";
String  sqlTemp ="select workflowid from workflow_requestbase where requestid ="+requestid;
RecordSet.executeSql(sqlTemp);
RecordSet.next();
tempWorkflowid = RecordSet.getString("workflowid");
*/
String sqlTemp = "select nodeid from workflow_flownode where workflowid = "+workflowid+" and nodetype = '0'";
RecordSet.executeSql(sqlTemp);
RecordSet.next();
String creatorNodeId = RecordSet.getString("nodeid");
/*----added by xwj for td2891 end-----*/
/*----added by chujun for td8883 start ----*/
WFManager.setWfid(workflowid);
WFManager.getWfInfo();
String orderbytype = Util.null2String(WFManager.getOrderbytype());
String orderby = "desc";
if("2".equals(orderbytype)){
	orderby = "asc";
}

/*----added by chujun for td8883 end ----*/
String viewNodeIdSQL = "select  t1.*, t2.nodename from workflow_requestlog t1,workflow_nodebase t2 "+
" where t1.requestid="+requestid+" and t1.nodeid=t2.id and t1.logtype != '1' " +
" and t1.nodeid in ("+ viewLogIds +") order by operatedate "+orderby+",operatetime "+orderby+"";
RecordSet.executeSql(viewNodeIdSQL);
/*--  xwj for td2104 on 20050802 E N D --*/

String lineNTdOne="";
String lineNTdTwo="";


%>

</td>
<%-- �öδ����ѱ����Σ���ɾ�� --%>

        </tr></table>
  <script language="javascript">

<%
    if(ismode.equals("1")){
%>
//TD4262 ������ʾ��Ϣ  ��ʼ
var oPopup;
try{
    oPopup = window.createPopup();
}catch(e){}
//TD4262 ������ʾ��Ϣ  ����

<%
    }
%>

    function doRemark_n(obj)
    <!-- �����ת�����ύ��ť -->
	
    {   

var ischeckok="true";
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
            	if(!check_form(document.frmmain,'remarkText10404') || !check_form(document.frmmain,'remark')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>
if(ischeckok=="true"){
	if ("<%=needconfirm%>"=="1")
	{
    if (!confirm("<%=SystemEnv.getHtmlLabelName(19990,user.getLanguage())%>"))
    return false; 
	}

        try
        {
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoRemark").click();
        }
        catch(e)
        {                
			if(checktimeok()) 
			{
		        document.frmmain.isremark.value='1';
		        document.frmmain.src.value='save';
		        
           		<%--added by xwj for td2104 on 2005-08-01--%>
                <%--document.getElementById("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;--%>
                
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201


            	//����ǩ������
<%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
	                    if(SaveSignature()){
            //TD4262 ������ʾ��Ϣ  ��ʼ
			<%
			    if(ismode.equals("1")){
			%>
	            
                             contentBox = document.getElementById("divFavContent18978");
                            showObjectPopup(contentBox)
			<%
			    
			    }else{
			%>
		       
                            var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
                            showPrompt(content);
			        
			<%
			    }
			%>
                            //TD4262 ������ʾ��Ϣ  ����
                            document.frmmain.action="RequestRemarkOperation.jsp";
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
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
            //TD4262 ������ʾ��Ϣ  ��ʼ
			<%
			    if(ismode.equals("1")){
			%>
	            
                        contentBox = document.getElementById("divFavContent18978");
                        showObjectPopup(contentBox)
			<%
			    
			    }else{
			%>
		       
                        var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
                        showPrompt(content);
			        
			<%
			    }
			%>
                        //TD4262 ������ʾ��Ϣ  ����
                        document.frmmain.action="RequestRemarkOperation.jsp";
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
<%}%>
				obj.disabled=true;
            }
        }
}
	}
	function checkNodesNum()
	{
		var nodenum = 0;
		try
		{
		<%
		int checkdetailno = 0;
		//
		if(isbill>0)
		{
			if(formid==7||formid==156 || formid==157 || formid==158)
			{
				%>
				
				var rowneed=frmmain.ChinaExcel.GetCellUserStringValueRow("detail0_isneed");
				var head=frmmain.ChinaExcel.GetCellUserStringValueRow("detail0_head");
				var end=frmmain.ChinaExcel.GetCellUserStringValueRow("detail0_end");
			   	var nodesnum = end-head-2;
			   	nodesnum = nodesnum*1;
			   	if(rowneed>0)
			   	{
			   		if(nodesnum>0)
			   		{
			   			nodenum = 0;
			   		}
			   		else
			   		{
			   			nodenum = 1;
			   		}
			   	}
			   	else
			   	{
			   		nodenum = 0;
			   	}
			   	<%
			}
			else
			{
			    //����
			    RecordSet.execute("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
			    //System.out.println("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
			    while(RecordSet.next())
			    {
			    	
	   	%>
	   	var rowneed=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkdetailno%>_isneed");
		var head=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkdetailno%>_head");
		var end=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkdetailno%>_end");
	   	var nodesnum = end-head-2;
	   	nodesnum = nodesnum*1;
	   	nodesnum = nodesnum*1;
	   	if(rowneed>0)
	   	{
	   		if(nodesnum>0)
	   		{
	   			nodenum = 0;
	   		}
	   		else
	   		{
	   			nodenum = '<%=checkdetailno+1%>';
	   		}
	   	}
	   	else
	   	{
	   		nodenum = 0;
	   	}
	   	if(nodenum>0)
	   	{
	   		return nodenum;
	   	}
	   	<%
	   				checkdetailno ++;		
			    }
			}
		}
		else
		{
		 	int checkGroupId=0;
		 	RecordSet.execute("select distinct groupId from Workflow_formfield where formid="+formid+" and isdetail='1' order by groupid");
		    while (RecordSet.next())
		    {
		    	checkGroupId=RecordSet.getInt(1);
		    	%>
		       	var rowneed=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkGroupId%>_isneed");
				var head=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkGroupId%>_head");
				var end=frmmain.ChinaExcel.GetCellUserStringValueRow("detail<%=checkGroupId%>_end");
				var nodesnum = end-head-2;
		       	nodesnum = nodesnum*1;
		       	if(rowneed>0)
		       	{
		       		if(nodesnum>0)
		       		{
		       			nodenum = 0;
		       		}
		       		else
		       		{
		       			nodenum = <%=checkGroupId+1%>;
		       		}
		       	}
		       	else
		       	{
		       		nodenum = 0;
		       	}
		       	if(nodenum>0)
			   	{
			   		return nodenum;
			   	}
		       	<%
		    }
	    }
	    //����ϸѭ������
		%>
		}
		catch(e)
		{
			nodenum = 0;
		}
		return nodenum;
	}
    function doSave_n(obj){  
		enableAllmenu();
		var nodenum = checkNodesNum();
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,user.getLanguage())%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,user.getLanguage())%>!");
    		displayAllmenu();
    		return false;
    	}
		<!-- ������水ť -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoSave").click();
        }catch(e){
            try{
            frmmain.ChinaExcel.EndCellEdit(true);
            }catch(e1){}
            var ischeckok="";
            try{
              if(check_form(document.frmmain,document.getElementById("needcheck").value+document.getElementById("inputcheck").value))
              ischeckok="true";
            }catch(e){
              ischeckok="false";
            }
            if(ischeckok=="false"){
                if(check_form(document.frmmain,'<%=needcheck%>'))
                    ischeckok="true";
            }
			if(ischeckok=="true"){
					if(("<%=formid%>"=="85" || "<%=formid%>"=="163") && "<%=isbill%>"=="1"){
						  if(!checkmeetingtimeok()){
						  	  displayAllmenu();
							  return;
						  }
					}
			}
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>

            if(ischeckok=="true"){
                objSubmit=obj;
                FCKEditorExt.updateContent();
                if(checktimeok()&&checkReportData("save")) {
                }else {
	             	 displayAllmenu();
	             	 return;
	            }
             } else {
             	 displayAllmenu();
             	 return;
             }
        }
	}


    function doRemark()
    <!-- �����ת�����ύ��ť,������͵���Ա�ύ -->
	
    {    

var ischeckok="true";
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>
if(ischeckok=="true"){
	if ("<%=needconfirm%>"=="1")
	{
	if (!confirm("<%=SystemEnv.getHtmlLabelName(19990,user.getLanguage())%>"))
    return false;
	}

        try
        {
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoRemark").click();
        }
        catch(e)
        {                
			if(checktimeok()) 
			{
		        document.frmmain.isremark.value='<%=isremark%>';
		        document.frmmain.src.value='save';
		        
           		<%--added by xwj for td2104 on 2005-08-01--%>
                <%--document.getElementById("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;--%>
                
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201


document.frmmain.action="RequestRemarkOperation.jsp";
//����ǩ������
<%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
	                    if(SaveSignature()){
            //TD4262 ������ʾ��Ϣ  ��ʼ
			<%
			    if(ismode.equals("1")){
			%>
	            
                            contentBox = document.getElementById("divFavContent18978");
                            showObjectPopup(contentBox)
			<%
			    
			    }else{
			%>
		       
                            var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
                            showPrompt(content);
			        
			<%
			    }
			%>
                            //TD4262 ������ʾ��Ϣ  ����
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
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
            //TD4262 ������ʾ��Ϣ  ��ʼ
			<%
			    if(ismode.equals("1")){
			%>
                        contentBox = document.getElementById("divFavContent18978");
                        showObjectPopup(contentBox)
			<%
			    
			    }else{
			%>
		       
                        var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
                        showPrompt(content);
			        
			<%
			    }
			%>
                        //TD4262 ������ʾ��Ϣ  ����
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
<%}%>
            }
        }
}
	}

    function doSave(){          <!-- ������水ť -->
    	enableAllmenu();
    	var nodenum = checkNodesNum();
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,user.getLanguage())%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,user.getLanguage())%>!");
    		displayAllmenu();
    		return false;
    	}
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoSave").click();
        }catch(e){
            try{
            frmmain.ChinaExcel.EndCellEdit(true);
            }catch(e1){}
            var ischeckok="";
            try{
             if(check_form(document.frmmain,document.getElementById("needcheck").value+document.getElementById("inputcheck").value))
              ischeckok="true";
            }catch(e){
              ischeckok="false";
            }
            if(ischeckok=="false"){
                if(check_form(document.frmmain,'<%=needcheck%>'))
                    ischeckok="true";
            }
			if(ischeckok=="true"){
					if(("<%=formid%>"=="85" || "<%=formid%>"=="163") && "<%=isbill%>"=="1"){
						  if(!checkmeetingtimeok()){
						  	  displayAllmenu();
							  return;
						  }
					}
			}
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
	            getRemarkText_log();
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>


            if(ischeckok=="true"){
                objSubmit="";
                FCKEditorExt.updateContent();
                if(checktimeok()&&checkReportData("save")) {
                } else {
	             	 displayAllmenu();
	             	 return;
	            }
             } else {
             	 displayAllmenu();
             	 return;
             }
        }
	}

    function doAffirmance(obj){          <!-- �ύȷ�� -->
    	enableAllmenu();
    	var nodenum = checkNodesNum();
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,user.getLanguage())%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,user.getLanguage())%>!");
    		displayAllmenu();
    		return false;
    	}
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoSave").click();
        }catch(e){
            try{
            frmmain.ChinaExcel.EndCellEdit(true);
            }catch(e1){}
            var ischeckok="";
            try{
             if(check_form(document.frmmain,document.getElementById("needcheck").value+document.getElementById("inputcheck").value))
              ischeckok="true";
            }catch(e){
              ischeckok="false";
            }
            if(ischeckok=="false"){
                if(check_form(document.frmmain,'<%=needcheck%>'))
                    ischeckok="true";
            }
			if(ischeckok=="true"){
					if(("<%=formid%>"=="85" || "<%=formid%>"=="163") && "<%=isbill%>"=="1"){
						  if(!checkmeetingtimeok()){
						  	  displayAllmenu();
							  return;
						  }
					}
			}
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>


            if(ischeckok=="true"){
                objSubmit=obj;
                FCKEditorExt.updateContent();
                if(checktimeok()&&checkReportData("Affirmance")) {
                }else{
					displayAllmenu();
					return; 
				}
             }else{
				displayAllmenu();
				return; 
			}
        }
	}

    function doSubmit(obj){        <!-- ����ύ -->
    	enableAllmenu();
			document.getElementById('RejectToNodeid').value = '';
    	var nodenum = checkNodesNum();
    	var isuseTemplate = document.getElementById("temphasUseTempletSucceed").value;
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,user.getLanguage())%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,user.getLanguage())%>!");
    		displayAllmenu();
    		return false;
    	}
        try{
            frmmain.ChinaExcel.EndCellEdit(true);
            }catch(e1){}
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoSubmit").click();
        }catch(e){
      //modify by xhheng @20050328 for TD 1703
      //��ϸ������check��ͨ��try document.getElementById("needcheck")�����,�����ԭ������ϸ���ݵ��޸�
        var ischeckok="";
        try{
        var checkstr=document.getElementById("needcheck").value+document.getElementById("inputcheck").value+',<%=needcheck%>';
        if(<%=isremark%>==5){
            checkstr="";
        }
        if(check_form(document.frmmain,checkstr))
          ischeckok="true";
        }catch(e){
          ischeckok="false";
        }
        if(ischeckok=="false"){
          if(check_form(document.frmmain,'<%=needcheck%>'))
            ischeckok="true";
        }
		if(ischeckok=="true"){
				if(("<%=formid%>"=="85" || "<%=formid%>"=="163") && "<%=isbill%>"=="1"){
					  if(!checkmeetingtimeok()){
					  	  displayAllmenu();
						  return;
					  }
				}
		}
<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
	            getRemarkText_log();
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>

        if(ischeckok=="true"){
    		if (("<%=needconfirm%>"=="1")&&("<%=nodetype%>"!="0"))
    		{
	    		if (!confirm("<%=SystemEnv.getHtmlLabelName(19990,user.getLanguage())%>")) {
	    			displayAllmenu();
	            	return false; 
	            }
    		}

			<%
			if("1".equals(fromFlowDoc)||"1".equals(isworkflowdoc)){

			%>
				if (isuseTemplate == 'false'){
					if(document.getElementById("createdoc")){
					if(window.confirm("<%=SystemEnv.getHtmlLabelName(21252,user.getLanguage())%>")){
					   //parent.resetbanner(1,1);
					   document.getElementById("createdoc").click();
					   displayAllmenu();
					   return false;
					}else{
						displayAllmenu();
					   return false;
					}
					}
				}
			<%
				
			}
			if("1".equals(fromFlowDoc)||"1".equals(isworkflowdoc)){
				if(!hasSignatureSucceed){
			%>
					if(!window.confirm("<%=SystemEnv.getHtmlLabelName(23043,user.getLanguage())%>")){
						displayAllmenu();
					   return false;
					}
			<%
				}
			}
			%>

            objSubmit=obj;
            FCKEditorExt.updateContent();
            if(checktimeok()&&checkReportData("submit")) {
            }else{
				displayAllmenu();
				return; 
			}
        }else{
			displayAllmenu();
			return; 
		}
        }
	}

	function doReject(){//����˻�
		enableAllmenu();
		<%
		if(isSignMustInput.equals("1")){
		%>
			if(!check_form(document.frmmain,'remark')){
				displayAllmenu();
			    return false;
			}
		<%
		}
		%>
		var isuseTemplate = document.getElementById("temphasUseTempletSucceed").value;
		var _isUseTempletNode = document.getElementById("isUseTempletNode").value;
		if ("<%=needconfirm%>"=="1"){
			if (!confirm("<%=SystemEnv.getHtmlLabelName(19991,user.getLanguage())%>")){
				displayAllmenu();
	        	return false;
			}
		}

		<%
		if("1".equals(fromFlowDoc)||"1".equals(isworkflowdoc)){

		%>
			if(_isUseTempletNode == 'true'&&isuseTemplate== 'true'){
				if(window.confirm("<%=SystemEnv.getHtmlLabelName(22985,user.getLanguage())%>")){
				   //parent.resetbanner(1,1);
				   document.getElementById("createdoc").click();
				   displayAllmenu();
				   return;
				}else{
					displayAllmenu();
				   return;
				}
			}
		<%
			
		}
		%>

		try{
			frmmain.ChinaExcel.EndCellEdit(true);
		}catch(e1){}
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoReject").click();
        }catch(e){
            if(onSetRejectNode())
            showtipsinfo(<%=requestid%>,<%=workflowid%>,<%=nodeid%>,<%=isbill%>,1,<%=billid%>,"","reject","<%=ismode%>","divFavContent18980","<%=SystemEnv.getHtmlLabelName(18980,user.getLanguage())%>");
        }
    }

	function doReopen(){        <!-- ������¼��� -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoReopen").click();
        }catch(e){
            document.frmmain.src.value='reopen';
            document.getElementById("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;
            jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
        }
	}

	function doDelete(){        <!-- ���ɾ�� -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            document.getElementById("planDoDelete").click();
        }catch(e){
            if(confirm("<%=SystemEnv.getHtmlLabelName(16667,user.getLanguage())%>")) {
                document.frmmain.src.value='delete';
                document.getElementById("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201

                //TD4262 ������ʾ��Ϣ  ��ʼ
<%
    if(ismode.equals("1")){
%>
	            contentBox = document.getElementById("divFavContent18984");
                showObjectPopup(contentBox)
<%
    }else{
%>
		       var content="<%=SystemEnv.getHtmlLabelName(18984,user.getLanguage())%>";
		       showPrompt(content);
<%
    }
%>
                //TD4262 ������ʾ��Ϣ  ����

                //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
    }
//��ӳ��ö���
function onAddPhrase(phrase){
	if(phrase!=null && phrase!=""){
		document.getElementById("remarkSpan").innerHTML = "";
		try{
			var remarkHtml = FCKEditorExt.getHtml("remark");
			var remarkText = FCKEditorExt.getText("remark");
			if(remarkText==null || remarkText==""){
				FCKEditorExt.setHtml(phrase,"remark");
			}else{
				FCKEditorExt.setHtml(remarkHtml+"<p>"+phrase+"</p>","remark");
			}
		}catch(e){}
	}
}
//xwj for td3665 20060227
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
				    if(!check_form(document.frmmain,'remarkText10404')){
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
				document.frmmain.action="/workflow/workflow/wfFunctionManageLink.jsp?flag=ov&fromflow=1";
				//�����ϴ�
			    StartUploadAll();
		        checkuploadcomplet();
		}
	}
}
function doRetract(obj){
jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
obj.disabled=true;
document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=rb&requestid=<%=requestid%>" //xwj for td3665 20060224
}
function nodechange(value){
    var nodeids=value.split("_");
    var selnodeid=nodeids[0];
    var selnodetype=nodeids[1];
    if(selnodetype==0){
        document.getElementById("Intervenorid").value="<%=creater%>";
        document.getElementById("Intervenorspan").innerHTML="<A href='javaScript:openhrm(<%=creater%>);' onclick='pointerXY(event);'><%=creatername%></a>";
    }else{
    <%if(urm_workflowMSmode==1){%>
    rightMenu.style.display="none";
    <%}%>
    document.getElementById("workflownextoperatorfrm").src="/workflow/request/WorkflowNextOperator.jsp?requestid=<%=requestid%>&isremark=<%=isremark%>&workflowid=<%=workflowid%>"+
            "&formid=<%=formid%>&isbill=<%=isbill%>&billid=<%=billid%>&creater=<%=creater%>&creatertype=<%=creatertype%>&nodeid="+selnodeid+"&nodetype="+selnodetype;
    }
}



//TD4262 ������ʾ��Ϣ  ��ʼ
//��ʾ����

<%
    if(ismode.equals("1")){
%>
function showObjectPopup(contentBox){
  try{
    var iX=document.body.offsetWidth/2-50;
	var iY=document.body.offsetHeight/2+document.body.scrollTop-50;

	var oPopBody = oPopup.document.body;
    oPopBody.style.border = "1px solid #8888AA";
    oPopBody.style.backgroundColor = "white";
    oPopBody.style.position = "absolute";
    oPopBody.style.padding = "0px";
    oPopBody.style.zindex = 150;

    oPopBody.innerHTML = contentBox.innerHTML;

    oPopup.show(iX, iY, 200, 22, document.body);
  }catch(e){}
}
<%
    }else{
%>
function showPrompt(content)
{
     var showTableDiv  = document.getElementById('_xTable');
     var message_table_Div = document.createElement("<div>")
     message_table_Div.id="message_table_Div";
     message_table_Div.className="xTable_message";
     showTableDiv.appendChild(message_table_Div);
     var message_table_Div  = document.getElementById("message_table_Div");
     message_table_Div.style.display="inline";
     message_table_Div.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_table_Div.style.position="absolute"
     message_table_Div.style.posTop=pTop;
     message_table_Div.style.posLeft=pLeft;

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
<%
    }
%>
//TD4262 ������ʾ��Ϣ  ����
var showTableDiv  = document.getElementById('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
}
function displaydiv_1()
{
	if(WorkFlowDiv.style.display == ""){
		WorkFlowDiv.style.display = "none";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></span>";
	}
	else{
		WorkFlowDiv.style.display = "";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></span>";

	}
}

function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showallreceived(operator,operatedate,operatetime,returntdid,viewLogIds,logtype,destnodeid){
    showreceiviedPopup("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");
    var ajax=ajaxinit();
    ajax.open("POST", "WorkflowReceiviedPersons.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid=<%=requestid%>&viewnodeIds=<%=viewLogIds%>&operator="+operator+"&operatedate="+operatedate+"&operatetime="+operatetime+"&returntdid="+returntdid+"&logtype="+logtype+"&destnodeid="+destnodeid);
    //��ȡִ��״̬
    ajax.onreadystatechange = function() {
        //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
            document.getElementById(returntdid).innerHTML = ajax.responseText;
            }catch(e){}
            showTableDiv.style.display='none';
            oIframe.style.display='none';
        } 
    } 
}
function accesoryChanage(obj,maxUploadImageSize){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        var oFile=document.getElementById("oFile");
        oFile.FilePath=objValue;
        fileLenth= oFile.getFileSize();
    } catch (e){
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
    if (fileLenthByM>maxUploadImageSize) {
     	alert("<%=SystemEnv.getHtmlLabelName(20254,user.getLanguage())%>"+fileLenthByM+"M,<%=SystemEnv.getHtmlLabelName(20255,user.getLanguage())%>"+maxUploadImageSize+"M<%=SystemEnv.getHtmlLabelName(20256 ,user.getLanguage())%>");
        createAndRemoveObj(obj);
    }
}

function createAndRemoveObj(obj){
    objName = obj.name;
    tempObjonchange=obj.onchange;
    outerHTML="<input name="+objName+" class=InputStyle type=file size=50 >";
    document.getElementById(objName).outerHTML=outerHTML;
    document.getElementById(objName).onchange=tempObjonchange;
}
function addannexRow(accname,maxsize)
  {
    document.getElementById(accname+'_num').value=parseInt(document.getElementById(accname+'_num').value)+1;
    ncol = document.getElementById(accname+'_tab').cols;
    oRow = document.getElementById(accname+'_tab').insertRow(-1);
    for(j=0; j<ncol; j++) {
      oCell = oRow.insertCell(-1);

      switch(j) {
        case 0:
          var oDiv = document.createElement("div");
          oCell.colSpan=3;
          var sHtml = "<input class=InputStyle  type=file size=50 name='"+accname+"_"+document.getElementById(accname+'_num').value+"' onchange='accesoryChanage(this,"+maxsize+")'> (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxsize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>) ";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
      }
    }
  }

 function onChangeSharetype(delspan,delid,ismand,Uploadobj){
	fieldid=delid.substr(0,delid.indexOf("_"));
    linknum=delid.substr(delid.lastIndexOf("_")+1);
	fieldidnum=fieldid+"_idnum_1";
	fieldidspan=fieldid+"span";
    delfieldid=fieldid+"_id_"+linknum;
    if(document.getElementById(delspan).style.visibility=='visible'){
      document.getElementById(delspan).style.visibility='hidden';
      document.getElementById(delid).value='0';
	  document.getElementById(fieldidnum).value=parseInt(document.getElementById(fieldidnum).value)+1;
        var tempvalue=document.getElementById(fieldid).value;
          if(tempvalue==""){
              tempvalue=document.getElementById(delfieldid).value;
          }else{
              tempvalue+=","+document.getElementById(delfieldid).value;
          }
	     document.getElementById(fieldid).value=tempvalue;
    }else{
      document.getElementById(delspan).style.visibility='visible';
      document.getElementById(delid).value='1';
	  document.getElementById(fieldidnum).value=parseInt(document.getElementById(fieldidnum).value)-1;
        var tempvalue=document.getElementById(fieldid).value;
        var tempdelvalue=","+document.getElementById(delfieldid).value+",";
          if(tempvalue.substr(0,1)!=",") tempvalue=","+tempvalue;
          if(tempvalue.substr(tempvalue.length-1)!=",") tempvalue+=",";
          tempvalue=tempvalue.substr(0,tempvalue.indexOf(tempdelvalue))+tempvalue.substr(tempvalue.indexOf(tempdelvalue)+tempdelvalue.length-1);
          if(tempvalue.substr(0,1)==",") tempvalue=tempvalue.substr(1);
          if(tempvalue.substr(tempvalue.length-1)==",") tempvalue=tempvalue.substr(0,tempvalue.length-1);
	     document.getElementById(fieldid).value=tempvalue;
    }
	//alert(document.getElementById(fieldidnum).value);
	if (ismand=="1")
	  {
	if (document.getElementById(fieldidnum).value=="0")
	  {
	    document.getElementById(fieldid).value="";
        if(Uploadobj.getStats().files_queued==0){
		document.getElementById(fieldidspan).innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
        }
	  }
	  else
	  {
		 document.getElementById(fieldidspan).innerHTML="";
	  }
	  }
  }

function checkReportData(src){
        var reportUserId="";
		var crmId="";
		var year="";
		var month="";
		var day="";
		var date="";
        if(document.getElementById("reportUserIdInputName")!=null){
			var reportUserIdInputName=document.getElementById("reportUserIdInputName").value;
            reportUserId=document.getElementById(reportUserIdInputName).value;
        }
        if(document.getElementById("crmIdInputName")!=null){
			var crmIdInputName=document.getElementById("crmIdInputName").value
		    crmId=document.getElementById(crmIdInputName).value;
		}
        if(document.getElementById("year")!=null){
			year=document.getElementById("year").value;
		}
		if(document.getElementById("month")!=null){
			month=document.getElementById("month").value;
		}
		if(document.getElementById("day")!=null){
			day=document.getElementById("day").value;
		}
		if(document.getElementById("date")!=null){
			date=document.getElementById("date").value;
		}
        if(reportUserId=="" || crmId==""){
            checkReportDataReturn(0,"","",src);
        }else{
            StrData="requestid=<%=requestid%>&formid=<%=formid%>&reportUserId="+reportUserId+"&crmId="+crmId+"&year="+year+"&month="+month+"&day="+day+"&date="+date+"&src="+src;
            if(document.getElementById("checkReportDataForm")!=null){
                document.getElementById("checkReportDataForm").src="checkReportDataForm.jsp?"+StrData;
            }else{
                checkReportDataReturn(0,"","",src);
            }
        }
	}
function checkReportDataReturn(ret,thedate,dspdate,src){

		if(ret==1||ret==2){
			alert(dspdate+" "+"<%=SystemEnv.getHtmlLabelName(20775,user.getLanguage())%>");
			return false;
		}
		if(src=="save"){
                    document.frmmain.src.value='save';
                    jQuery($GetEle("flowbody")).attr("onbeforeunload", "");


            <%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
	                    if(SaveSignature()){
<%
    if(ismode.equals("1")){
%>
                            contentBox = document.getElementById("divFavContent18979");
                            showObjectPopup(contentBox)
<%
    }else{
%>
                            var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
                            showPrompt(content);
<%
    }
%>
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
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
<%
    if(ismode.equals("1")){
%>
                        contentBox = document.getElementById("divFavContent18979");
                        showObjectPopup(contentBox)
<%
    }else{
%>
                        var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
                        showPrompt(content);
<%
    }
%>
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
<%}%>
            if(objSubmit!=""){
					objSubmit.disabled=true;
				}
        }else if(src=="submit"){
            showtipsinfo(<%=requestid%>,<%=workflowid%>,<%=nodeid%>,<%=isbill%>,0,<%=billid%>,objSubmit,"submit","<%=ismode%>","divFavContent18978","<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>");
		}else if(src=="Affirmance"){
                document.frmmain.src.value='save';
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231

                document.frmmain.topage.value="ViewRequest.jsp?isaffirmance=1&reEdit=0&fromFlowDoc=<%=fromFlowDoc%>";
                <%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
	                    if(SaveSignature()){
<%
    if(ismode.equals("1")){
%>
                            contentBox = document.getElementById("divFavContent18979");
                            showObjectPopup(contentBox)
<%
    }else{
%>
                            var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
                            showPrompt(content);
<%
    }
%>
                            //TD4262 ������ʾ��Ϣ  ����
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
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
<%
    if(ismode.equals("1")){
%>
                        contentBox = document.getElementById("divFavContent18979");
                        showObjectPopup(contentBox)
<%
    }else{
%>
                        var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
                        showPrompt(content);
<%
    }
%>
                        //TD4262 ������ʾ��Ϣ  ����
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
<%}%>
				if(objSubmit!=""){
					objSubmit.disabled=true;
				}
		}
	}

function showtipsinfo(requestid,workflowid,nodeid,isbill,isreject,billid,obj,src,ismode,divcontent,content){

		var nowtarget = frmmain.target;
		var nowaction = frmmain.action;

		$G("divcontent").value=divcontent;
		$G("content").value=content;
		$G("src").value=src;
		frmmain.target = "showtipsinfoiframe";
		frmmain.action = "/workflow/request/WorkflowTipsinfo.jsp";
		frmmain.submit();

		frmmain.target = nowtarget;
		frmmain.action = nowaction;
}


function showtipsinfoReturn(returnvalue,src,ismode,divcontent,content,messageLabelName){

	obj="";
            try{
                if(messageLabelName!=""){
					alert(messageLabelName);
					return ;
				}
            }catch(e){}
            try{
                tipsinfo=returnvalue;
                if(tipsinfo!=""){
                    if(confirm(tipsinfo)){
                        document.frmmain.src.value=src;
                        jQuery($GetEle("flowbody")).attr("onbeforeunload", "");

                        //����ǩ������
                        <%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
                            if(SaveSignature()){
                                if(ismode=="1"){
                                    contentBox = document.getElementById(divcontent);
                                    showObjectPopup(contentBox)
                                }else{
                                    showPrompt(content);
                                }

                                //�����ϴ�
                                StartUploadAll();
                                checkuploadcomplet();
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
                            if(ismode=="1"){
                                contentBox = document.getElementById(divcontent);
                                showObjectPopup(contentBox)
                            }else{
                                showPrompt(content);
                            }

                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
                        <%}%>
                    }
                }else{
                    document.frmmain.src.value=src;
                    jQuery($GetEle("flowbody")).attr("onbeforeunload", "");


                    //����ǩ������
                <%if("1".equals(isFormSignature)&&"0".equals(hasSign)){%>
                    if (SaveSignature()) {
                        if (ismode == "1") {
                            contentBox = document.getElementById(divcontent);
                            showObjectPopup(contentBox)
                        } else {
                            showPrompt(content);
                        }

                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
                    } else {
							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,user.getLanguage())%>");
								isDocEmpty=0;
							}else{
								alert("<%=SystemEnv.getHtmlLabelName(21442,user.getLanguage())%>");
							}
                        return;
                    }
                <%}else{%>
                    if (ismode == "1") {
                        contentBox = document.getElementById(divcontent);
                        showObjectPopup(contentBox)
                    } else {
                        showPrompt(content);
                    }

                    //�����ϴ�
                    StartUploadAll();
                    checkuploadcomplet();
                <%}%>
                }
            }catch(e){}
}
function doStop(obj){
	//��ȷ��Ҫ��ͣ��ǰ������?
	if(confirm("<%=SystemEnv.getHtmlLabelName(26156,user.getLanguage())%>?")){
		jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		enableAllmenu();
		document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=stop&requestid=<%=requestid%>" //xwj for td3665 20060224
	}
	else
	{
		displayAllmenu();
		return false;
	}
}
function doCancel(obj){
	//��ȷ��Ҫ������ǰ������?
	if(confirm("<%=SystemEnv.getHtmlLabelName(26157,user.getLanguage())%>?")){
		jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		enableAllmenu();
		document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=cancel&requestid=<%=requestid%>" //xwj for td3665 20060224
	}
	else
	{
		displayAllmenu();
		return false;
	}
}
function doRestart(obj)
{
	//��ȷ��Ҫ���õ�ǰ������?
	if(confirm("<%=SystemEnv.getHtmlLabelName(26158,user.getLanguage())%>?")){
		jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		enableAllmenu();
		document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=restart&requestid=<%=requestid%>" //xwj for td3665 20060224
	}
	else
	{
		displayAllmenu();
		return false;
	}
}
</script>

<SCRIPT LANGUAGE=VBS>
sub onShowBrowser(id,url,linkurl,type1,ismand)
	if type1= 2 or type1 = 19 then
		id1 = window.showModalDialog(url,,"dialogHeight:320px;dialogwidth:275px")

		document.getElementById("field"+id+"span").innerHtml = id1
		document.getElementById("field"+id).value=id1
	else
		if type1 <> 152 and type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>56 and type1<>57 and type1<>65 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
			id1 = window.showModalDialog(url)
		elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.getElementById("field"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
		else
			tmpids = document.getElementById("field"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
		end if
		if NOT isempty(id1) then
			if type1 = 152 or type1 = 17 or type1 = 18 or type1=27 or type1=37 or type1=56 or type1=57 or type1=65 then
				if id1(0)<> ""  and id1(0)<> "0"  then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.getElementById("field"+id).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
					if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
							sHtml = sHtml&"<a href=javaScript:openhrm("&curid&"); onclick='pointerXY(event);'>"&curname&"</a>&nbsp"
						else
							sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					end if
					wend
					if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
						sHtml = sHtml&"<a href=javaScript:openhrm("&resourceids&"); onclick='pointerXY(event);'>"&resourcename&"</a>&nbsp"
					else
						sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					end if
					document.getElementById("field"+id+"span").innerHtml = sHtml

				else
					if ismand=0 then
						document.getElementById("field"+id+"span").innerHtml = empty
					else
						document.getElementById("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.getElementById("field"+id).value=""
				end if

			else
			   if  id1(0)<>""  and id1(0)<> "0"  then
			        if linkurl = "" then
						document.getElementById("field"+id+"span").innerHtml = id1(1)
					else
						if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
							document.getElementById("field"+id+"span").innerHtml = "<a href=javaScript:openhrm("&id1(0)&"); onclick='pointerXY(event);'>"&id1(1)&"</a>&nbsp"
						else
							document.getElementById("field"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
						end if
						
					end if
					document.getElementById("field"+id).value=id1(0)
				else
					if ismand=0 then
						document.getElementById("field"+id+"span").innerHtml = empty
					else
						document.getElementById("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.getElementById("field"+id).value=""
				end if
			end if
		end if
	end if
end sub
sub getDate(i)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	document.getElementById("datespan"&i).innerHtml= returndate
	document.getElementById("dff0"&i).value=returndate
end sub
sub onShowMutiHrm(spanname,inputename)
		tmpids = document.getElementById(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
		    if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.getElementById(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<A href='javaScript:openhrm("&curid&");' onclick='pointerXY(event);'>"&curname&"</a>&nbsp"
					wend
					sHtml = "<button class=Browser onclick=onShowMutiHrm('Intervenorspan','Intervenorid') ></button>"&sHtml&"<A href='javaScript:openhrm("&resourceids&");' onclick='pointerXY(event);'>"&resourcename&"</a>"
					document.getElementById(spanname).innerHtml = sHtml

				else
					document.getElementById(spanname).innerHtml ="<button class=Browser onclick=onShowMutiHrm('Intervenorspan','Intervenorid') ></button><img src='/images/BacoError.gif' align=absmiddle>"
					document.getElementById(inputename).value=""
				end if
			end if
end sub
sub onShowSignBrowser(url,linkurl,inputname,spanname,type1)
    tmpids = document.getElementById(inputname).value
    if type1=37 then
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="&url&"?documentids="&tmpids)
    else
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="&url&"?resourceids="&tmpids)
    end if
        if NOT isempty(id1) then
		   if id1(0)<> ""  and id1(0)<> "0"  then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.getElementById(inputname).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&" target='_blank'>"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&" target='_blank'>"&resourcename&"</a>&nbsp"
					document.getElementById(spanname).innerHtml = sHtml

		else
				    document.getElementById(spanname).innerHtml = empty
					document.getElementById(inputname).value=""
        end if
      end if
end sub
</script>