<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="OpenSendDoc" class="weaver.docs.senddoc.OpenSendDoc" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="BaseBeanOfDocDspExt" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="WorkflowBarCodeSetManager" class="weaver.workflow.workflow.WorkflowBarCodeSetManager" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="shareManager" class="weaver.share.ShareManager" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%@ include file="/systeminfo/init.jsp" %>
<%@ include file="iWebOfficeConf.jsp" %>

<%
int docid = Util.getIntValue(request.getParameter("docid"));
String fromFlowDoc = Util.null2String(request.getParameter("fromFlowDoc"));

int requestid = Util.getIntValue(request.getParameter("requestid"));
String ifVersion = Util.null2String(request.getParameter("ifVersion"));
String isCompellentMark = Util.null2String(request.getParameter("isCompellentMark"));
String canPostil = Util.null2String(request.getParameter("canPostil"));
//String nodeid = Util.null2String(request.getParameter("nodeid"));
String isFromAccessory = Util.null2String(request.getParameter("isFromAccessory"));
//String topageFromOther = Util.null2String(request.getParameter("topageFromOther"));
String isrequest = Util.null2String(request.getParameter("isrequest"));
//int meetingid = Util.getIntValue(request.getParameter("meetingid"));
String hasUsedTemplet = Util.null2String(request.getParameter("hasUsedTemplet"));
String isPrintControl = Util.null2String(request.getParameter("isPrintControl"));
String doccreaterid = Util.null2String(request.getParameter("doccreaterid"));
//String docsubject = Util.null2String(request.getParameter("docsubject"));
String userid =  Util.null2String(request.getParameter("userid"));
//String hasPrintNode = Util.null2String(request.getParameter("hasPrintNode"));
//String isPrintNode = Util.null2String(request.getParameter("isPrintNode"));
//String printApplyWorkflowId = Util.null2String(request.getParameter("printApplyWorkflowId"));
//String isagentOfprintApply = Util.null2String(request.getParameter("isagentOfprintApply"));
//String username =  Util.null2String(request.getParameter("username"));
int countNum = Util.getIntValue(request.getParameter("countNum"));
int isremark = Util.getIntValue(request.getParameter("isremark"));
boolean isUseTempletNode = Util.null2String(request.getParameter("isUseTempletNode")).equals("1");
String wordmouldid = Util.null2String(request.getParameter("wordmouldid"));
int versionId = Util.getIntValue(request.getParameter("versionId"));
boolean isSignatureNodes = Util.null2String(request.getParameter("isSignatureNodes")).equals("1");
String CurrentDate = Util.null2String(request.getParameter("CurrentDate"));
String CurrentTime = Util.null2String(request.getParameter("CurrentTime"));
//String replyid = Util.null2String(request.getParameter("replyid"));
//String parentids = Util.null2String(request.getParameter("parentids"));
String workflowid = Util.null2String(request.getParameter("workflowid"));
String PDF417ManagerCopyRight = Util.null2String((String)session.getAttribute("PDF417ManagerCopyRight"));

int appointedWorkflowId = Util.getIntValue(request.getParameter("appointedWorkflowId"),0);
String logintype = Util.null2String(request.getParameter("logintype"));
String userSeclevel = Util.null2String(request.getParameter("userSeclevel"));
int userCategory = Util.getIntValue(request.getParameter("userCategory"),0);
String from =  Util.null2String(request.getParameter("from"));
String topage = Util.null2String(request.getParameter("topage"));
String maxOfficeDocFileSize = Util.null2String(request.getParameter("maxOfficeDocFileSize"));
boolean isPersonalDoc = Util.null2String(request.getParameter("isPersonalDoc")).equals("1");
boolean onlyview = Util.null2String(request.getParameter("onlyview")).equals("1");
boolean canEdit = Util.null2String(request.getParameter("canEdit")).equals("1");
String nodeName = URLDecoder.decode(Util.null2String(request.getParameter("nodeName")),"GBK");
boolean istoManagePage = Util.null2String(request.getParameter("istoManagePage")).equals("1");
int mouldSecCategoryId= Util.getIntValue(request.getParameter("mouldSecCategoryId"),0);
boolean cantop = Util.null2String(request.getParameter("cantop")).equals("1");
int istop= Util.getIntValue(request.getParameter("istop"),0);
boolean canEditHis = Util.null2String(request.getParameter("canEditHis")).equals("1");
String docstatus = Util.null2String(request.getParameter("docstatus"));
int hasright = Util.getIntValue(request.getParameter("hasright"),0);
int languageId = Util.getIntValue(request.getParameter("languageId"),0);
boolean canReader = Util.null2String(request.getParameter("canReader")).equals("1");
boolean canShare = Util.null2String(request.getParameter("canShare")).equals("1");
boolean canDel = Util.null2String(request.getParameter("canDel")).equals("1");
String docreplyable = Util.null2String(request.getParameter("docreplyable"));
boolean cannewworkflow = Util.null2String(request.getParameter("cannewworkflow")).equals("1");
boolean canPublish = Util.null2String(request.getParameter("canPublish")).equals("1");
boolean canInvalidate = Util.null2String(request.getParameter("canInvalidate")).equals("1");
boolean canArchive = Util.null2String(request.getParameter("canArchive")).equals("1");
boolean canCancel = Util.null2String(request.getParameter("canCancel")).equals("1");
boolean canReopen = Util.null2String(request.getParameter("canReopen")).equals("1");
boolean canCheckOut = Util.null2String(request.getParameter("canCheckOut")).equals("1");
boolean canCheckIn = Util.null2String(request.getParameter("canCheckIn")).equals("1");
boolean canCheckInCompellably = Util.null2String(request.getParameter("canCheckInCompellably")).equals("1");
int docdepartmentid = Util.getIntValue(request.getParameter("docdepartmentid"),0);
boolean canPrintApply = Util.null2String(request.getParameter("canPrintApply")).equals("1");
boolean canPrint = Util.null2String(request.getParameter("canPrint")).equals("1");
int isbill = Util.getIntValue(request.getParameter("isbill"),0);
int formid = Util.getIntValue(request.getParameter("formid"),0);
String docapprovable = Util.null2String(request.getParameter("docapprovable"));
int seccategory = Util.getIntValue(request.getParameter("seccategory"),0);
boolean canViewLog = Util.null2String(request.getParameter("canViewLog")).equals("1");
boolean hasRightOfViewHisVersion = Util.null2String(request.getParameter("hasRightOfViewHisVersion")).equals("1");
boolean isCurrentNode = Util.null2String(request.getParameter("isCurrentNode")).equals("1");
int defaultDocLocked = Util.getIntValue(request.getParameter("defaultDocLocked"),0);
String filetype = Util.null2String(request.getParameter("filetype"));
boolean canDownload = Util.null2String(request.getParameter("canDownload")).equals("1");
String nodetype = Util.null2String(request.getParameter("nodetype"));
String isreply = Util.null2String(request.getParameter("isreply"));
int accessorycount = Util.getIntValue(request.getParameter("accessorycount"),0);
//String doctitlename = Util.null2String(request.getParameter("doctitlename"));
String mServerUrl = Util.null2String(request.getParameter("mServerUrl"));
//String webOfficeFileName = Util.null2String(request.getParameter("webOfficeFileName"));
boolean isLocked = Util.null2String(request.getParameter("isLocked")).equals("1");
String isCancelCheck = Util.null2String(request.getParameter("isCancelCheck"));
boolean isApplyMould = Util.null2String(request.getParameter("isApplyMould")).equals("1");
String isUseBarCodeThisJsp = Util.null2String(request.getParameter("isUseBarCodeThisJsp"));
//String docMouldName = Util.null2String(request.getParameter("docMouldName"));
int readCountint = Util.getIntValue(request.getParameter("readCountint"),0);

DocManager.resetParameter();
DocManager.setId(docid);
DocManager.getDocInfoById();
String docsubject=DocManager.getDocsubject();
docsubject=Util.StringReplace(docsubject,"\"", "&quot;");
String doctitlename=docsubject + "("+SystemEnv.getHtmlLabelName(260,user.getLanguage())+" "+readCountint +" "+SystemEnv.getHtmlLabelName(18929,user.getLanguage())+ ")";

String docMouldName = Util.null2String((String)session.getAttribute("docMouldName_"+wordmouldid));


//ȡ���ĵ�����
String sql1 = "";
if(versionId==0){
    sql1 = "select * from DocImageFile where docid="+docid+" and (isextfile <> '1' or isextfile is null) order by versionId desc";
}else{
    sql1 = "select * from DocImageFile where docid="+docid+" and versionId="+versionId;
}
RecordSet.executeSql(sql1) ;
RecordSet.next();
versionId = Util.getIntValue(RecordSet.getString("versionId"),0);
if(versionId==0){
	RecordSet.executeSql("select * from DocImageFile where docid="+docid+" order by versionId desc") ;
	if(RecordSet.next()){
		versionId = Util.getIntValue(RecordSet.getString("versionId"),0);
	}
}
//String filetype=Util.null2String(""+RecordSet.getString("docfiletype"));
String imagefileName=Util.null2String(""+RecordSet.getString("imagefilename"));

String webOfficeFileName=docsubject;
if ("true".equals(request.getParameter("isFromAccessory"))){
    webOfficeFileName=imagefileName;
}

doctitlename=Util.stringReplace4DocDspExt(doctitlename);
webOfficeFileName=Util.stringReplace4DocDspExt(webOfficeFileName);

if(!"true".equals(request.getParameter("isFromAccessory"))){
	String imageFileNameNoPostfix=webOfficeFileName;
	List postfixList=new ArrayList();
	postfixList.add(".doc");
	postfixList.add(".dot");
	postfixList.add(".docx");
	postfixList.add(".xls");	
	postfixList.add(".xlt");
	postfixList.add(".xlw");
	postfixList.add(".xla");
	postfixList.add(".xlsx");
	postfixList.add(".ppt");
	postfixList.add(".pptx");
	postfixList.add(".wps");
	postfixList.add(".pgf");		

	String tempPostfix=null;
	String postfix="";
	for(int i=0;i<postfixList.size();i++){
		tempPostfix=(String)postfixList.get(i)==null?"":(String)postfixList.get(i);			
	    if(imageFileNameNoPostfix.endsWith(tempPostfix)){
		    imageFileNameNoPostfix=imageFileNameNoPostfix.substring(0,imageFileNameNoPostfix.indexOf(tempPostfix));
			postfix=tempPostfix;
	    }
	}

	if(postfix.equals("")){
		postfix=filetype;
	}

	imageFileNameNoPostfix=Util.StringReplace(imageFileNameNoPostfix,".","��");
	webOfficeFileName=imageFileNameNoPostfix+postfix;
}

%>


<%--int imagefileId = Util.getIntValue(request.getParameter("imagefileId"),0);--%>
<script language="javascript">
	var menubar=[];
	var menubarForwf=[];
	var menuOtherBar=[];
		function webOfficeMenuClick(vIndex,vCaption){
			if (vIndex==1) {
			if (<%=isFromAccessory%>){
				location.href='DocEditExt.jsp?id=<%=docid%>&versionId=<%=versionId%>&isFromAccessory=true';  //�༭�������ĵ�
			} else {
				location.href='DocEdit.jsp?id=<%=docid%>';  //�༭�������ĵ�
			}
		}   
		else if (vIndex==2)  doRemark(); //��עͨ��
		else if (vIndex==3)  doSubmit(); //��׼
		else if (vIndex==4)  doSubmit(); //�ύ
		else if (vIndex==5)  location.href='/workflow/request/RemarkOld.jsp?requestid=<%=requestid%>';  //ת��
		else if (vIndex==6)  doReject();   //�˻�
		else if (vIndex==7)  {
			 if (<%=isFromAccessory%>){
				location.href='DocEditExt.jsp?id=<%=docid%>&versionId=<%=versionId%>&isFromAccessory=true';  //�༭�������ĵ�
			} else {
				location.href='DocEdit.jsp?id=<%=docid%>';  //�༭�������ĵ�
			}
		}//�༭
		else if (vIndex==8)  doShare()     //����
		else if (vIndex==9)  onDelete();  //ɾ��
		else if (vIndex==10) onReopen();  //���´�
		else if (vIndex==11) doReply();  //�ظ�
		else if (vIndex==12) location.href='/docs/sendDoc/docCheckDetail.jsp?sendDocId=<%=OpenSendDoc.getSendDocId(""+docid)%>';  //������Ϣ
		else if (vIndex==13){
	<%
			if(appointedWorkflowId>0){
				boolean hasNewRequestRight=false;
				String isagent="0";
				//�ж��Ƿ������̴���Ȩ��
				
				hasNewRequestRight = shareManager.hasWfCreatePermission(user, appointedWorkflowId);

				if(!hasNewRequestRight){
					String begindate="";
					String begintime="";
					String enddate="";
					String endtime="";
					int beagenterid=0;
					RecordSet.executeSql("select distinct workflowid,beagenterid,begindate,begintime,enddate,endtime from workflow_agent where workflowid="+appointedWorkflowId+" and agenttype>'0' and iscreateagenter=1 and agenterid="+userid);
					while(RecordSet.next()&&!hasNewRequestRight){
						begindate=Util.null2String(RecordSet.getString("begindate"));
						begintime=Util.null2String(RecordSet.getString("begintime"));
						enddate=Util.null2String(RecordSet.getString("enddate"));
						endtime=Util.null2String(RecordSet.getString("endtime"));
						beagenterid=Util.getIntValue(RecordSet.getString("beagenterid"),0);

						if(!begindate.equals("")){
							if((begindate+" "+begintime).compareTo(CurrentDate+" "+CurrentTime)>0)
								continue;
						}
						if(!enddate.equals("")){
							if((enddate+" "+endtime).compareTo(CurrentDate+" "+CurrentTime)<0)
								continue;
						}
						
						hasNewRequestRight = shareManager.hasWfCreatePermission(beagenterid, appointedWorkflowId);
						
						if(hasNewRequestRight){
							isagent="1";
						}
					}
				}

				if(hasNewRequestRight){
	%>
					location.href='/workflow/request/AddRequest.jsp?workflowid=<%=appointedWorkflowId%>&isagent=<%=isagent%>&docid=<%=docid%>' ;
	<%
				}else{
	%>
					document.workflow.submit();  //�½�������
	<%
				}
			}else{
	%>
				document.workflow.submit();  //�½�������
	<%
			}
	%>
		}
		else if (vIndex==14) doRelateWfFun("<%=docid%>");  //������
		
		else if (vIndex==15) onPublish();  //����
		else if (vIndex==16) onInvalidate();  //ʧЧ
		else if (vIndex==17) onArchive();  //�鵵    
		else if (vIndex==18) onCancel();  //����    
		else if (vIndex==19) onReopen();  //���´�
		
		else if (vIndex==25) onCheckOut();  //ǩ��   
		else if (vIndex==26) onCheckIn();  //ǩ��   
		else if (vIndex==27) onCheckIn();  //ǿ��ǩ��
		
		else if (vIndex==30) onReload();  //����
		else if (vIndex==31) location.href='DocApproveRemark.jsp?docid=<%=docid%>&isrequest=<%=isrequest%>&requestid=<%=requestid%>'; //�������
		else if (vIndex==32) doViewLog();  //��־
		else if (vIndex==33) doViewLog();  //��־
		else if (vIndex==35) openVersion("<%=versionId%>");  //�򿪰汾
		else if (vIndex==36) ShowRevision();  //��ʾ/���غۼ�
		else if (vIndex==37) WebSaveLocal2();  //��Ϊ�����ļ�
		else if (vIndex==38) doSign();  //ǩ��
		else if (vIndex==39)  { 
			 if (<%=isFromAccessory%>){
				location.href='DocEditExt.jsp?id=<%=docid%>&versionId=<%=versionId%>&isFromAccessory=true&from=<%=from%>&userCategory=<%=userCategory%>';  //�༭�������ĵ�
			} else {
				location.href='DocEdit.jsp?from=<%=from%>&id=<%=docid%>&userCategory=<%=userCategory%>';  //�༭
			}
		}//�༭
		else if (vIndex==41) DocCommonExt.showorhiddenprop();  //��ʾ/���� 
		else if (vIndex==42) location.reload();   //ˢ��  
		else if (vIndex==43) window.history.go(-1);  //����  
		else if (vIndex==45) doRelate2Cowork();
		else if (vIndex==46) saveTHTemplate("<%=wordmouldid%>");//�׺�
		else if (vIndex==47) onPrintDoc();//��ӡ
		else if (vIndex==48) onPrintApply();//��ӡ����	
		else if (vIndex==49) onPrintLog();//��ӡ��־
		else if (vIndex==50) onSave();//�ݸ�ʱ�ύ
		else if (vIndex==51) showNewWorkFlowFunc();//���������ĵ��鵵������½�������
	}
</script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)"> 
	 webOfficeMenuClick(vIndex,vCaption);
</script>

<%if(isIWebOffice2006 == true){%>
<script language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)>
//��Ӧ�������¼�
if (vIndex==-1){//�ؼ�Ĭ�ϵĹ���������INDEXֵΪ-1����ʱ������Ҫ��vCaption��ֵ�жϵ����ĸ���ť
  if(vCaption=="������ע"){//���µ���ִ�г�ʼ���ķ���
    onLoadAgain();
  }
}
</script>
<%}
String initHidenWfMenu = "";//�еİ�ť��Ҫ����
%>

<script LANGUAGE="JavaScript">

	//TD8873 Start
	function WebSaveLocal2(){

        try{
			var tempFileName=document.getElementById("WebOffice").FileName;

			tempFileName=tempFileName.replace(/\\/g,'��');
			tempFileName=tempFileName.replace(/\//g,'��');
			tempFileName=tempFileName.replace(/:/g,'��');
			tempFileName=tempFileName.replace(/\*/g,'��');
			tempFileName=tempFileName.replace(/\?/g,'��');
			tempFileName=tempFileName.replace(/\"/g,'��');
			tempFileName=tempFileName.replace(/</g,'��');
			tempFileName=tempFileName.replace(/>/g,'��');
			tempFileName=tempFileName.replace(/\|/g,'��');

			var tempfiletype = tempFileName.substring(tempFileName.lastIndexOf("."),tempFileName.length);
			if(tempfiletype!=null&&(tempfiletype==".doc"||tempfiletype==".xls"||tempfiletype==".ppt"||tempfiletype==".wps"||tempfiletype==".docx"||tempfiletype==".xlsx"||tempfiletype==".pptx")){
				tempFileName=tempFileName.substring(0,tempFileName.lastIndexOf("."));
				tempFileName=tempFileName.replace(/\./g,'��');
				tempFileName=tempFileName+tempfiletype;
			} else 

			tempFileName=tempFileName.replace(/\./g,'��');
			document.getElementById("WebOffice").FileName=tempFileName;
		}catch(e){
		}

		 var filetype = document.getElementById("WebOffice").FileType;
		if(filetype == '.doc'){
			WebSaveLocalWord();
		}else{
			WebSaveLocalExcel();
		}
		/**TD12005 �ĵ���־��������־��¼����ʼ*/
        DocDetailLogWrite.writeDetailLog("<%=docid%>", "<%=Util.stringReplace4DocDspExt(docsubject)%>", "22", "<%=user.getUID()%>", "<%=user.getLogintype()%>", "<%=request.getRemoteAddr()%>", "<%=doccreaterid%>", callbackWriteLog);
		/**TD12005 �ĵ���־��������־��¼������*/
	}

	function showNewWorkFlowFunc(){
	  var topage_wftemp = "<%=topage%>";
	  var docid_wftemp = "<%=docid%>";
	  openFullWindowForXtable("/workflow/request/RequestType.jsp?topage="+topage_wftemp+"&docid="+docid_wftemp);
	}

    var viewStatus=true;

	function ShowRevision(mObject){

		if (viewStatus){

			document.getElementById("WebOffice").editType="-1,0,1,1,0,0,1<%=canPostil%>";
			viewStatus=false;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19712,user.getLanguage())%>...");
		}else{

			document.getElementById("WebOffice").editType="-1,0,0,1,0,0,1<%=canPostil%>";
			viewStatus=true;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19713,user.getLanguage())%>...");
		}
	}


var hasAcceptAllRevisions="false";
function SaveDocument(){

    var fileSize=getFileSize();

	if(parseFloat(fileSize)>parseFloat(<%=maxOfficeDocFileSize%>)){
		alert("<%=SystemEnv.getHtmlLabelName(24028,user.getLanguage())%>"+fileSize+"M��<%=SystemEnv.getHtmlLabelName(24029,user.getLanguage())%><%=maxOfficeDocFileSize%>M��");
		return false;
	}

  document.getElementById("WebOffice").WebSetMsgByName("SAVETYPE","EDIT");
  document.getElementById("WebOffice").WebSetMsgByName("HASUSEDTEMPLET", document.getElementById("hasUsedTemplet").value);
  document.getElementById("WebOffice").FileType=changeFileType(document.getElementById("WebOffice").FileType);

<%if(isIWebOffice2003&&filetype.equals(".doc")){%>
	try{
		var fileSize=0;
		document.getElementById("WebOffice").WebObject.SaveAs();
		fileSize=document.getElementById("WebOffice").WebObject.BuiltinDocumentProperties(22);
		document.getElementById("WebOffice").WebSetMsgByName("NEWFS",fileSize);
	}catch(e){
	}
<%}%>

  if (!document.getElementById("WebOffice").WebSave(<%=isNoComment%>)){
     StatusMsg(document.getElementById("WebOffice").Status);
     alert("<%=SystemEnv.getHtmlLabelName(19007,user.getLanguage())%>");

     return false;
  }else{
     StatusMsg(document.getElementById("WebOffice").Status);
     return true;
  }
}

function SaveDocumentNewV(){

    var fileSize=getFileSize();

	if(parseFloat(fileSize)>parseFloat(<%=maxOfficeDocFileSize%>)){
		alert("<%=SystemEnv.getHtmlLabelName(24028,user.getLanguage())%>"+fileSize+"M��<%=SystemEnv.getHtmlLabelName(24029,user.getLanguage())%><%=maxOfficeDocFileSize%>M��");
		return false;
	}

  document.getElementById("WebOffice").WebSetMsgByName("SAVETYPE","NEWVERSION");
  document.getElementById("WebOffice").WebSetMsgByName("HASUSEDTEMPLET", document.getElementById("hasUsedTemplet").value);

  var vDetail="<%=user.getUsername()%>"+"<%=TimeUtil.getCurrentDateString()%>"+" "+"<%=TimeUtil.getOnlyCurrentTimeString()%>"+"<%=SystemEnv.getHtmlLabelName(18805,user.getLanguage())%>��"+"<%=nodeName%>"+"��<%=SystemEnv.getHtmlLabelName(15586,user.getLanguage())%>"+"<%=SystemEnv.getHtmlLabelName(21706,user.getLanguage())%>";

  document.getElementById("WebOffice").WebSetMsgByName("VERSIONDETAIL", vDetail);
  document.getElementById("WebOffice").FileType=changeFileType(document.getElementById("WebOffice").FileType);

<%if(isIWebOffice2003&&filetype.equals(".doc")){%>
	try{
		var fileSize=0;
		document.getElementById("WebOffice").WebObject.SaveAs();
		fileSize=document.getElementById("WebOffice").WebObject.BuiltinDocumentProperties(22);
		document.getElementById("WebOffice").WebSetMsgByName("NEWFS",fileSize);
	}catch(e){
	}
<%}%>

  if (!document.getElementById("WebOffice").WebSave(<%=isNoComment%>)){
     StatusMsg(document.getElementById("WebOffice").Status);
     alert("<%=SystemEnv.getHtmlLabelName(19007,user.getLanguage())%>");
     return false;
  }else{
     StatusMsg(document.getElementById("WebOffice").Status);
     return true;
  }
}

function SaveDocumentOrSaveDocumentNewV(){

    var returnStatus=false;

<%
if(ifVersion.equals("1")){
%>
    returnStatus=SaveDocumentNewV();
<%
}else if("1".equals(isCompellentMark)){
%>
	if(hasAcceptAllRevisions=="true"){
        returnStatus=SaveDocumentNewV();
        hasAcceptAllRevisions="false";
    }else{
		returnStatus=SaveDocument();
	}
<%
}else{
%>
    returnStatus=SaveDocument();
<%
}
%>
	return returnStatus;
}

    function initmenu(){
         <%  if(!onlyview){
             if (!fromFlowDoc.equals("1")) {
%>
         document.getElementById("WebOffice").ShowMenu="1";         
        <%
            if (!isPersonalDoc){
                if(isrequest.equals("1")){ //�ӹ�����������ĵ�
                    //hasright = 0 ;        
                    //if(logintype.equals("1")) operatortype = 0;
                    //if(logintype.equals("2")) operatortype = 1;
                    
                    //if(requestid != 0 ) {
                        //RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
                        //if(RecordSet.next()){
                            //workflowid=RecordSet.getInt("workflowid");
                            //nodeid=RecordSet.getInt("currentnodeid");
                            //nodetype=RecordSet.getString("currentnodetype");
                            //requestname=RecordSet.getString("requestname");
                            //status=RecordSet.getString("status");
                            //creater=RecordSet.getInt("creater");

                            //docIds = Util.null2String(RecordSet.getString("docIds"));
                            //crmIds = Util.null2String(RecordSet.getString("crmIds"));
                            //hrmIds = Util.null2String(RecordSet.getString("hrmIds"));
                            //prjIds = Util.null2String(RecordSet.getString("prjIds"));
                            //cptIds = Util.null2String(RecordSet.getString("cptIds"));
                        //}
                        //RecordSet.executeSql("select isremark from workflow_currentoperator where requestid="+requestid+" and userid="+userid+" and usertype = "+operatortype + " and isremark in ('1','0') " );
                        //if(RecordSet.next())	{
                            //if((RecordSet.getString(1)).equals("0")) hasright=1;
                            //else if((RecordSet.getString(1)).equals("1")) isremark=1;
                        //}
                        //RecordSet.executeProc("workflow_Nodebase_SelectByID",nodeid+"");
                        //if(RecordSet.next()){
                            //user_fieldid=RecordSet.getString("userids");
                            //isreopen=RecordSet.getString("isreopen");
                            //isreject=RecordSet.getString("isreject");
                            //isend=RecordSet.getString("isend");
                        //}
                        //RecordSet.executeSql("select billId from workflow_form where requestid="+requestid);
                        //if(RecordSet.next()){
							//billid = RecordSet.getInt("billId");
                        //}
                        //~~~~~~~~~~~~~~get workflowtype & formid & isbill & messageType~~~~~~~~~~~~~~~~~~~~~
                        //RecordSet.executeSql("select workflowtype,formid,isbill,messageType from workflow_base where id="+workflowid);
                        //if(RecordSet.next()){
							//workflowtype = RecordSet.getString("workflowtype");
							//formid = RecordSet.getInt("formid");
							//isbill = RecordSet.getInt("isbill");
							//messageType = RecordSet.getString("messageType");
                        //}
                    //}
                    //����ӹ��������룬�ĵ��������̵ĵ�ǰ���������ĵ���Ϊ�鵵������¿����޸ģ��������������ĵ�Ϊ�ݸ塢���������˻�״̬�¿����޸ġ�
                    if(canEditHis && ((!docstatus.equals("5") && hasright == 1) ||  ((docstatus.equals("0") || docstatus.equals("2") || docstatus.equals("1") || docstatus.equals("4")||Util.getIntValue(docstatus,0)<0) && hasright == 0)) ) {%>
                        document.getElementById("WebOffice").AppendMenu("1","<%=SystemEnv.getHtmlLabelName(19714,user.getLanguage())%>(&E)");  //�༭�������ĵ�       
						menubar.push({text:'<%=SystemEnv.getHtmlLabelName(19714,user.getLanguage())%>',iconCls:'btn_save',handler:function(){webOfficeMenuClick(1,'');}});
                    <%}        
                    // �����ת��������ע��ť
                    
                }
                // �ӷǹ�����������ĵ�
                else if(canEdit) {
                %>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%>',iconCls:'btn_edit',handler:function(){webOfficeMenuClick(7,'');  }});
                    document.getElementById("WebOffice").AppendMenu("7","<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%>");  //�༭ location='DocEdit.jsp?id="+docid+"   
                <%
					if(docstatus.equals("0")||Util.getIntValue(docstatus,0)<=0){
                %>
					    menubar.push({text:'<%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%>',iconCls:'btn_save',handler:function(){onSave();  }});
					    document.getElementById("WebOffice").AppendMenu("50","<%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%>");  //�ύ
                <%
					}					
				}
                 // �ݸ�ʱ�༭�ύ
                else if(canReader) {
					if(docstatus.equals("0")||Util.getIntValue(docstatus,0)<=0){
                %>
					    menubar.push({text:'<%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%>',iconCls:'btn_save',handler:function(){onSave();  }});
					    document.getElementById("WebOffice").AppendMenu("50","<%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%>");  //�ύ
                <%
					}
				} 
                
                // ���б༭Ȩ�޵���,���ĵ������޸Ĺ����, �й���ť
                if(canShare){ %>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(119,user.getLanguage())%>',iconCls:'btn_share',handler:function(){webOfficeMenuClick(8,'');}});
                    document.getElementById("WebOffice").AppendMenu("8","<%=SystemEnv.getHtmlLabelName(119,user.getLanguage())%>");  //����  doShare  
                <%}
                
                // �ĵ��������ĵ��ǹ鵵,������������,�Ǵ�״̬��ʱ�����ɾ���ĵ�
                if(canDel) { %>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%>',iconCls:'btn_remove',handler:function(){webOfficeMenuClick(9,''); }});
                     document.getElementById("WebOffice").AppendMenu("9","<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%>");  //ɾ��    onDelete
                 <%}
                
                // ���б༭Ȩ�޵��˶��������������ĵ��������´�
                if(canEdit && docstatus.equals("10")){ %>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(244,user.getLanguage())%>',iconCls:'btn_add',handler:function(){webOfficeMenuClick(10,''); }});
                    document.getElementById("WebOffice").AppendMenu("10","<%=SystemEnv.getHtmlLabelName(244,user.getLanguage())%>");  //���´�    onReopen       
                <%}
                
                //�ĵ��ظ��� ����ǿ��Իظ����ĵ������������ĵ��� ���Իظ�
                if(docreplyable.equals("1")&&(docstatus.equals("2")||docstatus.equals("1"))) { 
                    //replyid = docid; //replyid��ʼ��Ϊ�ĵ�id
                    //if(isreply.equals("1")) replyid = replydocid; //����ǻظ����ĵ�%>
                    document.getElementById("WebOffice").AppendMenu("11","<%=SystemEnv.getHtmlLabelName(18540,user.getLanguage())%>");  //�ظ�    doReply    
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(18540,user.getLanguage())%>',iconCls:'btn_add',handler:function(){webOfficeMenuClick(11,''); }});
                <%}
                
                // ������Զ�����ϵͳ���͸��ĵ�,���Է�������ĵ�
                if(OpenSendDoc.inSendDoc(""+docid)) {%>
                    document.getElementById("WebOffice").AppendMenu("12","<%=SystemEnv.getHtmlLabelName(16999,user.getLanguage())%>"); 
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(18540,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(12,'');}});       
                <%}
                
                // ����ĵ����ڴ�״̬,�����½�������
                if(!docstatus.equals("3") && cannewworkflow) {%>
                	document.getElementById("WebOffice").AppendMenu("13","<%=SystemEnv.getHtmlLabelName(1239,user.getLanguage())%>");  //�½�������    document.workflow.submit() 
   				   	menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(1239,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(13,'');}});  			  

                <%}%>

                //������Э��
				document.getElementById("WebOffice").AppendMenu("45","<%=SystemEnv.getHtmlLabelName(19759,user.getLanguage())%>");  //�½�������    document.workflow.submit()
				 	menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19759,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(45,'');}});  	
                // ���Բ鿴�ĵ����˶����в鿴��ع��������б�Ȩ��
                document.getElementById("WebOffice").AppendMenu("14","<%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%>");  //������    location='/workflow/search/WFSearchTemp.jsp?docids="+docid+"
				menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(14,'');}});  	

                <%
                // �����ĵ�����ԱȨ�޵��˿��ԶԴ������ĵ����з���
                if(canPublish){%>
                	document.getElementById("WebOffice").AppendMenu("15","<%=SystemEnv.getHtmlLabelName(114,user.getLanguage())%>");  //����    onPublish

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(114,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(15,'');}});  
                <%}

                // ���б༭���ĵ�����ԱȨ�޵��˿��Զ���Ч/�����ĵ�����ʧЧ����
                if(canInvalidate){%>
                	document.getElementById("WebOffice").AppendMenu("16","<%=SystemEnv.getHtmlLabelName(15750,user.getLanguage())%>");  //ʧЧ    onInvalidate

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(15750,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(16,'');}});
                <%}
                
                // �����ĵ�����ԱȨ�޵��˿��Զ���Ч/�����ĵ����й鵵����
                if(canArchive){%>
                	document.getElementById("WebOffice").AppendMenu("17","<%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%>");  //�鵵    onArchive

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(17,'');}});
                <%}
                
                // �����ĵ�����ԱȨ�޵��˿��Զ���Ч/�����ĵ��������ϲ���
                // �����ĵ�����ԱȨ�޵��˿��Զ�ʧЧ�ĵ��������ϲ���
                // �����ĵ�����ԱȨ�޵��˿��ԶԹ鵵�ĵ��������ϲ���
                if(canCancel){%>
                	document.getElementById("WebOffice").AppendMenu("18","<%=SystemEnv.getHtmlLabelName(15358,user.getLanguage())%>");  //����    onCancel

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(15358,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(18,'');}});
                <%}
                
                // �����ĵ�����ԱȨ�޵��˿��ԶԹ鵵�ĵ��������´򿪲���
                // �����ĵ�����ԱȨ�޵��˿��Զ������ĵ��������´򿪲���
                if(canReopen){%>
                	document.getElementById("WebOffice").AppendMenu("19","<%=SystemEnv.getHtmlLabelName(244,user.getLanguage())%>");  //���´�   onReopen

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(244,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(19,'');}});
                <%}

                //�ĵ�δǩ��ʱ,�༭Ȩ�޵��û����ֶ������ĵ�ǩ������
                if(canCheckOut){%>
                	document.getElementById("WebOffice").AppendMenu("25","<%=SystemEnv.getHtmlLabelName(19692,user.getLanguage())%>");  

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19692,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(25,'');}});
                <%}

                //�ĵ�ǩ������ǩ����Ϊ��ǰ�û�����ɽ����ĵ�ǩ�����
                if(canCheckIn){%>
                	document.getElementById("WebOffice").AppendMenu("26","<%=SystemEnv.getHtmlLabelName(19693,user.getLanguage())%>");  

					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(19693,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(26,'');}});
                <%}

                //�ĵ�ǩ������ǩ���˲�Ϊ��ǰ�û�����ǰ�û������ĵ�����Ա��Ŀ¼����ԱȨ�ޣ���ɽ���ǿ��ǩ�����
                if(canCheckInCompellably){%>
                	document.getElementById("WebOffice").AppendMenu("27","<%=SystemEnv.getHtmlLabelName(19688,user.getLanguage())%>");  

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19688,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(27,'');}});
                <%}

                
                // �����ĵ�����ԱȨ�޵��˿��Զ������ĵ����й鵵
                if(HrmUserVarify.checkUserRight("DocEdit:Reload",user,docdepartmentid) && docstatus.equals("5")){%>
                	document.getElementById("WebOffice").AppendMenu("30","<%=SystemEnv.getHtmlLabelName(256,user.getLanguage())%>");  //����    onReload   

					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(256,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(30,'');}});
                <%}
				if(canPrintApply){
%>
                	document.getElementById("WebOffice").AppendMenu("48","<%=SystemEnv.getHtmlLabelName(21530,user.getLanguage())%>");  //��ӡ����    onPrintApply
					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(21530,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(48,'');}});
<%
				}
				if(canPrint){
				%>
                	document.getElementById("WebOffice").AppendMenu("47","<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%>");  //��ӡ    onPrintDoc
					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(47,'');}});
	
                <%
				}
				if(isPrintControl.equals("1")){
				%>
                	document.getElementById("WebOffice").AppendMenu("49","<%=SystemEnv.getHtmlLabelName(21533,user.getLanguage())%>");  //��ӡ��־    onPrintLog
					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(21533,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(49,'');}});
	
                <%
				}
                // �����������������, ���߾��б༭Ȩ�޲����ĵ��������ģ��������������ť
			    if(isbill==1&&formid==28){
					if((canEdit && docapprovable.equals("1")) || isremark==1 || hasright==1 ) {%>

                     document.getElementById("WebOffice").AppendMenu("31","<%=SystemEnv.getHtmlLabelName(1008,user.getLanguage())%>");  //�������    location.href='DocApproveRemark.jsp?docid="+docid+"&isrequest="+isrequest+"&requestid="+requestid+"'
					 menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(1008,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(31,'');}});
                <%  }
		        }
//TD12005			    if((SecCategoryComInfo.getLogviewtype(seccategory)==1&&user.getLoginid().equalsIgnoreCase("sysadmin"))||(SecCategoryComInfo.getLogviewtype(seccategory)==0)){
		    //���ĵ�Ŀ¼�趨Ϊ"���ĵ���־Ȩ�޲鿴"ʱ���������ĵ��鿴Ȩ�޵���Ҳ�ܲ鿴��־(TD12005)
            if((SecCategoryComInfo.getLogviewtype(seccategory)==1&&HrmUserVarify.checkUserRight("FileLogView:View", user))||(SecCategoryComInfo.getLogviewtype(seccategory)==0)){
                // ���б༭Ȩ�޵��˶����Բ鿴�ĵ��Ĳ鿴��־
                if(canViewLog&&logintype.equals("1")){%>
                    document.getElementById("WebOffice").AppendMenu("32","<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%>");  //��־  doViewLog
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%>',iconCls:'btn_log',handler:function(){ webOfficeMenuClick(32,'');}});
					
					
                <%
               	 //blnRealViewLog=true;
                }else if(canEdit&&logintype.equals("2")){%>
                    document.getElementById("WebOffice").AppendMenu("33","<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%>");  //��־  doViewLog
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%>',iconCls:'btn_log',handler:function(){ webOfficeMenuClick(33,'');}});
					
					
                <%}
               	 //blnRealViewLog=true;
			    }
                %>
                
                document.getElementById("WebOffice").AppendMenu("34","-");  //-------
                
                // ���б༭Ȩ�޵��˶����Բ鿴�ĵ��汾��Ϣ
 <%if(hasRightOfViewHisVersion||canEditHis){%>
                    document.getElementById("WebOffice").AppendMenu("35","<%=SystemEnv.getHtmlLabelName(16384,user.getLanguage())%>");   //�򿪰汾  openVersion("+versionId+")
					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16384,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(35,'');}});
                <%
}
	                if (canEdit || (defaultDocLocked != 1&&!docstatus.equals("5"))||hasRightOfViewHisVersion){%>

                        
                        <%if(filetype.equals(".doc")){%>
                        document.getElementById("WebOffice").AppendMenu("36","<%=SystemEnv.getHtmlLabelName(16385,user.getLanguage())%>");    //��ʾ/���غۼ�  ShowRevision()
						menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16385,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(36,'');}});
                        <%}%>
                    
                    <%}%>

                    <%if(canDownload){%>
                    document.getElementById("WebOffice").AppendMenu("37","<%=SystemEnv.getHtmlLabelName(16382,user.getLanguage())%>");   //��Ϊ�����ļ�  WebSaveLocal()          
					menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16382,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(37,'');}});
                 	<%}%>
 
                <%//}

            } else {%>
                document.getElementById("WebOffice").AppendMenu("39","<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%>");   //�༭  
				menubar.push({text:'<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%>',iconCls:'btn_edit',handler:function(){ webOfficeMenuClick(39,'');}});
            <%}%>
                document.getElementById("WebOffice").AppendMenu("40","-");
				<%if(!fromFlowDoc.equals("1")){%>
                document.getElementById("WebOffice").AppendMenu("43","<%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%>"); 
				menubar.push({text:'<%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%>',iconCls:'btn_back',handler:function(){ webOfficeMenuClick(43,'');}});
				<%}%>
                document.getElementById("WebOffice").AppendMenu("42","<%=SystemEnv.getHtmlLabelName(354,user.getLanguage())%>");    
				menubar.push({text:'<%=SystemEnv.getHtmlLabelName(354,user.getLanguage())%>',iconCls:'btn_refresh',handler:function(){ webOfficeMenuClick(42,'');}});
				
				
                document.getElementById("WebOffice").AppendMenu("44","-");  //-------
             <%
			 }else{
			 %>
                document.getElementById("WebOffice").ShowMenu="1"; 
				
<%
//boolean istoManagePage=false;
//RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
//if(RecordSet.next()){
//	nodetype=Util.null2String(RecordSet.getString("currentnodetype"));
//}
//if(logintype.equals("1")) operatortype = 0;
//if(logintype.equals("2")) operatortype = 1;

//RecordSet.executeSql("select isremark from workflow_currentoperator where requestid="+requestid+" and userid="+userid+" and usertype="+operatortype+" order by isremark");
//while(RecordSet.next())	{
//    isremark = Util.getIntValue(RecordSet.getString("isremark"),-1) ;
//    if( isremark==1||isremark==5 || (isremark==0  && !nodetype.equals("3")) ) {
//      istoManagePage=true;
//      break;
//    }
//}

if(istoManagePage){

			if(isUseTempletNode){
			%>
			document.getElementById("WebOffice").AppendMenu("46","<%=SystemEnv.getHtmlLabelName(20227,user.getLanguage())%>");   //�׺�
			    menubarForwf.push({id:'thSure_id',text:'<%=SystemEnv.getHtmlLabelName(21659,user.getLanguage())%>',handler:function(){ saveTHTemplate(<%=wordmouldid%>);}});
			    <%if((!"1".equals(hasUsedTemplet))&&isUseTempletNode&&isremark==0){%>
			    <%}else{
			    	initHidenWfMenu += "try{";
			    	//initHidenWfMenu += "\tExt.getCmp('thSure_id').hide();";
			    	initHidenWfMenu += "\tdocument.getElementById('thSure_id').style.display = \"none\";";
			    	initHidenWfMenu += "}catch(e){}";
			    }%>
			    menubarForwf.push({id:'thModeS_id',text:'<%=SystemEnv.getHtmlLabelName(21660,user.getLanguage())%>',handler:function(){ selectTemplate(<%=mouldSecCategoryId%>,<%=wordmouldid%>);}});
			    <%if(countNum > 1 && (!"1".equals(hasUsedTemplet))&&isUseTempletNode&&isremark==0){%>
					
			    <%}else{
			    	initHidenWfMenu += "try{";
			    	//initHidenWfMenu += "\tExt.getCmp('thModeS_id').hide();";
			    	initHidenWfMenu += "\tdocument.getElementById('thModeS_id').style.display = \"none\";";
			    	initHidenWfMenu += "}catch(e){}";
			    }%>
			    menubarForwf.push({id:'thCancel_id',text:'<%=SystemEnv.getHtmlLabelName(22983,user.getLanguage())%>',handler:function(){ useTempletCancel();}});
		        <%if(("1".equals(hasUsedTemplet))&&isUseTempletNode&&isremark==0){%>
			    <%}else{
			    	initHidenWfMenu += "try{";
			    	//initHidenWfMenu += "\tExt.getCmp('thCancel_id').hide();";
			    	initHidenWfMenu += "\tdocument.getElementById('thCancel_id').style.display = \"none\";";
			    	initHidenWfMenu += "}catch(e){}";
			    }%>
			    menubarForwf.push({id:'thSaveAgain_id',text:'<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>',handler:function(){ saveTHTemplateNoConfirm(<%=wordmouldid%>);}});
			    <%if(("1".equals(hasUsedTemplet))&&isUseTempletNode&&isremark==0 && !isSignatureNodes){%>
			    <%}else{
			    	initHidenWfMenu += "try{";
			    	//initHidenWfMenu += "\tExt.getCmp('thSaveAgain_id').hide();";
			    	initHidenWfMenu += "\tdocument.getElementById('thSaveAgain_id').style.display = \"none\";";
			    	initHidenWfMenu += "}catch(e){}";
			    }
			}
}
			if(isSignatureNodes){/*�Ƿ���ʾ����*/%>
	           menubarForwf.push({id:'signature_id1',text:'<%=SystemEnv.getHtmlLabelName(21650,user.getLanguage())%>',iconCls:'btn_signature',handler:function(){CreateSignature(0)}});
               menubarForwf.push({id:'signature_id2',text:'<%=SystemEnv.getHtmlLabelName(21656,user.getLanguage())%>',iconCls:'btn_signature1',handler:function(){saveIsignatureFun()}});
	        <%}%>
<%
if(hasRightOfViewHisVersion||canEditHis){
%>               
                    document.getElementById("WebOffice").AppendMenu("35","<%=SystemEnv.getHtmlLabelName(16384,user.getLanguage())%>");   //�򿪰汾  openVersion("+versionId+")
                <%
}				
%>
			<%
            if(canDownload){
			%>
                 document.getElementById("WebOffice").AppendMenu("37","<%=SystemEnv.getHtmlLabelName(16382,user.getLanguage())%>");   //��Ϊ�����ļ�  WebSaveLocal2() 
			<%
                }
                if(canPrintApply){
%>
                	document.getElementById("WebOffice").AppendMenu("48","<%=SystemEnv.getHtmlLabelName(21530,user.getLanguage())%>");  //��ӡ����    onPrintApply
				<%}if(docstatus.equals("5")){%>
                 document.getElementById("WebOffice").AppendMenu("51","<%=SystemEnv.getHtmlLabelName(1239,user.getLanguage())%>");  //���������ĵ��鵵������½�������
<%
                }
                if(canPrint){
			%>
                	document.getElementById("WebOffice").AppendMenu("47","<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%>");  //��ӡ    onPrintDoc
			        menubarForwf.push({id:'thprint_id1',text:'<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(47,'');}});			
			<%
				}
				if(isPrintControl.equals("1")){
				%>
                	document.getElementById("WebOffice").AppendMenu("49","<%=SystemEnv.getHtmlLabelName(21533,user.getLanguage())%>");  //��ӡ��־    onPrintLog
	
                <%
				}
                if (canEdit || (defaultDocLocked != 1&&!docstatus.equals("5"))||hasRightOfViewHisVersion){
				    if(filetype.equals(".doc")){
						%>
                        document.getElementById("WebOffice").AppendMenu("36","<%=SystemEnv.getHtmlLabelName(16385,user.getLanguage())%>");    //��ʾ/���غۼ� ShowRevision()
						menubarForwf.push(
						  {id:'hide_id',text:'<%=SystemEnv.getHtmlLabelName(19713,user.getLanguage())%>',iconCls:'btn_ShowOrHidden',handler:function(){showMarkFunc()}}
						);
						menubarForwf.push(
						  {id:'dispaly_id',text:'<%=SystemEnv.getHtmlLabelName(19712,user.getLanguage())%>',iconCls:'btn_displayh',handler:function(){hideMarkFunc()}}
						);
            <%
				    }

                }
			      RecordSet.executeProc("DocImageFile_SelectByDocid", "" + docid);
			      if(RecordSet.next()){
%>
                      menubarForwf.push(
			          {id:'flowDocAcc_id',text:'<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(156,user.getLanguage())%>(0)',iconCls:'btn_acc',handler:function(){doImgAcc()}}
                      );
<%
			      }

			 }}
			%>
				menubar.push('-');
				
				menubar.push({text:'<%=SystemEnv.getHtmlLabelName(21739,user.getLanguage())%>',iconCls: 'btn_list',menu:menuOtherBar});				
				menubar.push('-');
				<%
				if(HrmUserVarify.checkUserRight("Document:Top", user))
				{
					//boolean cantop = false;
					//int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
					//String createidsubcomid = ResourceComInfo.getSubCompanyID(""+doccreaterid);
					//if(detachable==1)
					//{
					//	ArrayList subcompanylist=SubCompanyComInfo.getRightSubCompany(user.getUID(),"MeetingType:Maintenance");
					//	if(subcompanylist.indexOf(createidsubcomid)!=-1)
					//	{
					//		cantop = true;	
					//	}
					//}
					//else
					//{
					//	cantop = true;
					//}
					if(cantop)
					{
						
				%>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(23784,user.getLanguage())%>',iconCls: 'btn_up',handler:function(){DocToTop(<%=docid%>,1);}});				
					menubar.push('-');
				<%
					}
					//String sql = "select istop from docdetail d where d.id="+docid;
					//rs.executeSql(sql);
					//rs.next();
					//int istop = rs.getInt(1);
					if(istop==1)
					{
				%>
					menubar.push({text:'<%=SystemEnv.getHtmlLabelName(24675,user.getLanguage())%>',iconCls: 'btn_down',handler:function(){DocToTop(<%=docid%>,2);}});				
					menubar.push('-');
				<%
					}
				}
				%>
				menubar.push({text:'<span id=spanProp>"+SystemEnv.getHtmlLabelName(21689,user.getLanguage())+"</span>',iconCls:'btn_ShowOrHidden',handler:function(){DocCommonExt.showorhiddenprop()}});

}



    function StatusMsg(mString){
    	try{

    	}catch(e){}
    }
  
    function onLoad(){
    //������ʾ��Ϣ  ��ʼ
    showPrompt("<%=SystemEnv.getHtmlLabelName(18974,user.getLanguage())%>");
    //������ʾ��Ϣ  ����

    try{
        document.body.scroll = "no";
        document.title="<%=doctitlename%>";
        window.status="<%=SystemEnv.getHtmlLabelName(19715,user.getLanguage())%>";        
        // ��Ӳ˵�
        initmenu();
        
        document.getElementById("WebOffice").WebUrl="<%=mServerUrl%>";
       
        document.getElementById("WebOffice").RecordID="<%=(versionId==0?"":versionId+"")%>_<%=docid%>";
        document.getElementById("WebOffice").FileName="<%=webOfficeFileName%>";
        document.getElementById("WebOffice").FileType="<%=filetype%>";
        if ("<%=filetype%>"==".ppt"){
             document.getElementById("WebOffice").ProgName="powerpoint.show"; 
        }      
	  <%if(isIWebOffice2006 == true){%>
	      <%if((!isIWebOffice2009||"1".equals(isHandWriteForIWebOffice2009))&&!isSignatureNodes&&(!isLocked
		     ||(fromFlowDoc.equals("1")&&(!docstatus.equals("5")))
		     ||hasRightOfViewHisVersion
		      )
		      ){%>
	        	document.getElementById("WebOffice").ShowToolBar="1";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ  2 :����OFFICE���������
		        document.getElementById("WebOffice").VisibleTools('�½��ļ�',false);
		        document.getElementById("WebOffice").VisibleTools('���ļ�',false);
		        document.getElementById("WebOffice").VisibleTools('�����ļ�',false);
	            document.getElementById("WebOffice").VisibleTools('ȫ��',false);
		        document.getElementById("WebOffice").VisibleTools('������ע',false);
          <%}else{%>
	          <%if(isLocked){%>
	        	  document.getElementById("WebOffice").ShowToolBar="2";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ  2 :����OFFICE���������
	          <%}else{%>
	        	  document.getElementById("WebOffice").ShowToolBar="0";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ  2 :����OFFICE���������
	          <%}%>
	      <%}%>
	  <%}else{%>
	      <%if(isLocked){%>
	        	document.getElementById("WebOffice").ShowToolBar="2";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ  2 :����OFFICE���������
          <%}%>
	  <%}%>

        document.getElementById("WebOffice").MaxFileSize = <%=maxOfficeDocFileSize%> * 1024; 
        document.getElementById("WebOffice").UserName="<%=user.getUsername()%>";
        document.getElementById("WebOffice").WebSetMsgByName("USERID","<%=user.getUID()%>");

	    <%if(isLocked){%>
		//document.getElementById("WebOffice").EditType="0<%=canPostil%>";
		document.getElementById("WebOffice").EditType="4<%=canPostil%>";
	    <%}else{
			if(isUseTempletNode==true && "1".equals(fromFlowDoc)){%>
				<%if("1".equals(isCompellentMark) && "1".equals(isCancelCheck)){%>
					document.getElementById("WebOffice").EditType="-1,0,0,1,0,0,1<%=canPostil%>";
					document.getElementById("WebOffice").DisableKey ("CTRL+SHIFT+E");
				<%}else if(!"1".equals(isCompellentMark) && !"1".equals(isCancelCheck)){%>
					document.getElementById("WebOffice").EditType="-1,0,0,0,0,1,1<%=canPostil%>";
				<%}else{%>
					document.getElementById("WebOffice").EditType="-1,0,0,0,0,0,1<%=canPostil%>";
				<%}%>
			<%}else{%>
				if(document.getElementById("WebOffice").FileType==".doc"){
					document.getElementById("WebOffice").EditType="-1,0,0,0,0,0,1<%=canPostil%>";
				}else{
					document.getElementById("WebOffice").EditType="1<%=canPostil%>";
				}
			<%}%>
		<%}%>

<%if("1".equals(isCancelCheck)){%>
      try{
		  var mStatus = document.getElementById("WebOffice").Office2007Ribbon; //��õ�ǰOffice2007�ǹ�������״̬�����ȡ�ý��Ϊ-1����ʾû�а�װOffice2007
		  if(mStatus!=-1){
			  document.getElementById("WebOffice").RibbonUIXML = '<customUI xmlns="http://schemas.microsoft.com/office/2006/01/customui">' +
                                             '<ribbon startFromScratch="false">'+ //falseʱ��ʾѡ�
                                             ' <tabs>'+
                                             ' <tab idMso="TabReviewWord" visible="false">' + //�ر����Ĺ�����
                                             ' </tab>'+
                                             ' </tabs>' +
                                             '</ribbon>' +
                                             '</customUI>'; //����Ϊ���õ�XML������
		  }

	  }catch(e){
	  }
<%}%>

		<%if(isApplyMould){%>
<%
//�׺�ǰȡ���ۼ�  ��ʼ
  String acceptAllRevisionsBeforeUseTemplet = Util.null2String(BaseBeanOfDocDspExt.getPropValue("weaver_usetemplet","AcceptAllRevisionsBeforeUseTemplet"));

  if("1".equals(acceptAllRevisionsBeforeUseTemplet)&&isUseTempletNode){
%>
	    try{

		    document.getElementById("WebOffice").Template="";
		    if(document.getElementById("WebOffice").WebOpen()){
		        document.getElementById("WebOffice").WebObject.AcceptAllRevisions(); //���ܺۼ�

		        document.getElementById("WebOffice").WebSetMsgByName("SAVETYPE","NEWVERSION");
		        document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","TRUE");
		        var vDetailonLoad="<%=SystemEnv.getHtmlLabelName(23030,user.getLanguage())%>";
		        document.getElementById("WebOffice").WebSetMsgByName("VERSIONDETAIL", vDetailonLoad);
                document.getElementById("WebOffice").FileType=changeFileType(document.getElementById("WebOffice").FileType);
		        document.getElementById("WebOffice").WebSave(<%=isNoComment%>);
		        document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","FALSE");
		        var tempVersionId=document.getElementById("WebOffice").WebGetMsgByName("VERSIONID");
		        if(tempVersionId>=1){
		            document.getElementById("versionId").value=tempVersionId;
		        }
		    }
        }catch(e){
		}
<%
  }
//�׺�ǰȡ���ۼ�  ����
%>


		document.getElementById("WebOffice").Template="<%=wordmouldid%>";
		document.getElementById("WebOffice").WebSetMsgByName("SHOWDOCMOULDBOOKMARK","<%=fromFlowDoc%>");//�����Ƿ���ʾ���ĵ�ģ����ǩ������,����ݡ��Ƿ���Դ�����̽��ĵ�����ȷ����
	    //WebToolsVisible("iSignature",false);
	    WebToolsVisibleISignatureFalse();
		document.getElementById("WebOffice").WebSetMsgByName("COMMAND","LOADVIEWMOULD");//������ʾģ��

		if(document.getElementById("WebOffice").WebLoadTemplate()){//�����ģ��ɹ�

			var t_EditType = document.getElementById("WebOffice").EditType;
			document.getElementById("WebOffice").EditType = "-1,0,0,0,0,0,1<%=canPostil%>";
		    document.getElementById("WebOffice").RecordID="<%=(versionId==0?"":versionId+"")%>_<%=docid%>";
		    document.getElementById("WebOffice").WebLoadBookMarks();//�滻��ǩ
		    document.getElementById("WebOffice").RecordID=document.getElementById("versionId").value+"_<%=docid%>";
		    document.getElementById("WebOffice").WebInsertFile();//��������

<%
//�׺�ʱ�����ά����
if(fromFlowDoc.equals("1")){
  String isUseBarCode = Util.null2String(BaseBeanOfDocDspExt.getPropValue("weaver_barcode","ISUSEBARCODE"));
  if(isUseBarCode.equals("1")){
	//�ж��Ƿ����ö�ά����
	RecordSet.executeSql("select * from Workflow_BarCodeSet where workflowId="+workflowid+" and isUse='1'");
	if(RecordSet.next()){
		isUseBarCodeThisJsp="1";
		int barCodeSetId=Util.getIntValue(RecordSet.getString("id"),0);
		String measureUnit=Util.null2String(RecordSet.getString("measureUnit"));
		int printRatio = Util.getIntValue(RecordSet.getString("printRatio"),96);
		int minWidth = Util.getIntValue(RecordSet.getString("minWidth"),30);
		int maxWidth = Util.getIntValue(RecordSet.getString("maxWidth"),70);
		int minHeight = Util.getIntValue(RecordSet.getString("minHeight"),10);
		int maxHeight = Util.getIntValue(RecordSet.getString("maxHeight"),25);
		int bestWidth = Util.getIntValue(RecordSet.getString("bestWidth"),50);
		int bestHeight = Util.getIntValue(RecordSet.getString("bestHeight"),20);

		if(measureUnit.equals("1")){
			minWidth=(int)(0.5+minWidth*printRatio/25.4);
			maxWidth=(int)(0.5+maxWidth*printRatio/25.4);
			minHeight=(int)(0.5+minHeight*printRatio/25.4);
			maxHeight=(int)(0.5+maxHeight*printRatio/25.4);
			bestWidth=(int)(0.5+bestWidth*printRatio/25.4);
			bestHeight=(int)(0.5+bestHeight*printRatio/25.4);
		}

		String PDF417TextValue=WorkflowBarCodeSetManager.getPDF417TextValue(requestid,barCodeSetId,user.getLanguage());
%>
	    
        var hasBarCodeLabel=false;
        var barCodeLabelNum =  document.getElementById("WebOffice").WebObject.Bookmarks.Count;

		for (i=1;i<=barCodeLabelNum;i++){
			if(document.getElementById("WebOffice").WebObject.Bookmarks.Item(i).Name=="barcode"){
				hasBarCodeLabel=true;
				break;
			}
		}

      if(hasBarCodeLabel){

	    weaver.PDF417Manager.CopyRight = "<%=PDF417ManagerCopyRight%>";
	    //����ͼƬ��Ⱥ͸߶ȷ�Χ,
	    //������С������Ϊ0����ʹ�õ�ǰͼƬ���,�߶��Զ�����
	    var minWidth = <%=minWidth%>;
	    var maxWidth = <%=maxWidth%>;
	    var minHeight = <%=minHeight%>;
	    var maxHeight = <%=maxHeight%>;
	    weaver.PDF417Manager.LimitWidth(minWidth, maxWidth);
	    weaver.PDF417Manager.LimitHeight(minHeight, maxHeight);

	    //����ͼƬ��ȣ�ʵ�ʿ�Ƚ��ӽ��Ҳ���������ֵ��
	    //����Ϊ0����ʹ�õ�ǰͼƬ���,�߶��Զ�����
	    weaver.PDF417Manager.BestWidth = <%=bestWidth%>;
	    weaver.PDF417Manager.BestHeight = <%=bestHeight%>;

		var PDF417TextValue="<%=PDF417TextValue%>"; 
	    //���ñ����ַ���
	    mResult = weaver.PDF417Manager.SetBarCodeString(PDF417TextValue,false);

        if (mResult){
			alert("<%=SystemEnv.getHtmlLabelName(21471,user.getLanguage())%>");
		}else{
			var codeFileUrl = weaver.PDF417Manager.GetBarCodeFile(".gif");  //��ȡ����ͼƬ����_·��
		    codeFileUrl=codeFileUrl.replace(/\\\\/g,'\\');
		    codeFileUrl=codeFileUrl.replace(/\\/g,'\\\\');

            document.getElementById("WebOffice").WebObject.Application.Selection.GoTo(-1,0,0,"barcode");
			document.getElementById("WebOffice").WebObject.Application.Selection.InlineShapes.AddPicture (codeFileUrl);
		}
      }
       

<%
	}
  }
}
%>

			document.getElementById("WebOffice").EditType = t_EditType;
		}else{
		    document.getElementById("WebOffice").Template="";
		    document.getElementById("WebOffice").WebOpen();
		}

        <% }else{ %>
        document.getElementById("WebOffice").Template="";
        document.getElementById("WebOffice").WebOpen();
        <%}%>
 
<%if(isIWebOffice2006 == true){%>
//iWebOffice2006 �������ݿ�ʼ
  document.getElementById("WebOffice").ShowType="1";  //�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
//iWebOffice2006 �������ݽ���
<%}

		if(canPrint&&!"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,true);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%} else if(canPrint&&"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
	document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
	     <%} else {%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("��ӡ");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
	document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
		 <%}

	    if(isLocked&&filetype.equals(".doc")){%>
	        	SetHidRevision();
        <%}

if(!isLocked&&"1".equals(isCompellentMark) && "1".equals(fromFlowDoc)){%>//�Ƿ���뱣���ۼ�
			document.getElementById("WebOffice").editType="-1,0,0,1,0,0,1<%=canPostil%>";
<%}

	    if(isLocked&&(filetype.equals(".doc")||filetype.equals(".docx")||filetype.equals(".xls")||filetype.equals(".xlsx"))){%>
			document.getElementById("WebOffice").CopyType="0";
        <%}%>

         StatusMsg(document.getElementById("WebOffice").Status);
       
        }catch(e){
            //alert("error:"+e.description);
        }

		//WebToolsVisible("iSignature",false);
	    WebToolsVisibleISignatureFalse();

	    <%if(isLocked&&filetype.equals(".doc")){%>
	        	SetHidRevision();

	   <%}%>

     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����

    setWebObjectSaved();
}

function onLoadEnd(){
	<%=initHidenWfMenu%>
    try{

<%
	if(fromFlowDoc.equals("1")){
	    if(isIWebOffice2006 == true&&!isLocked&&!isSignatureNodes){
%>
		    if(document.getElementById("WebOffice").Pages >=1){
				if(window.confirm('<%=SystemEnv.getHtmlLabelName(21680,user.getLanguage())%>')){
				    document.getElementById("WebOffice").ShowType="2";
				}								 
		    }
<%
	    }

	    if(!"1".equals(hasUsedTemplet)&&isUseTempletNode&&isremark==0){
			String usedTempletInfo=null;
			if(!isApplyMould){
				usedTempletInfo=SystemEnv.getHtmlLabelName(23569,user.getLanguage());
			}else if(countNum == 1){
				usedTempletInfo=SystemEnv.getHtmlLabelName(21661,user.getLanguage());
			}else{
				usedTempletInfo=SystemEnv.getHtmlLabelName(21665,user.getLanguage())+"<"+docMouldName+">\\n"+SystemEnv.getHtmlLabelName(21666,user.getLanguage());
			}
%>
				alert("<%=usedTempletInfo%>");
<%
	    }
%>
		var signatureCount=0;
		try{
			SetActiveDocument();   //���û�ĵ�
		
		    weaver.SignatureAPI.InitSignatureItems();  //��ǩ�����ݷ����仯ʱ��������ִ�и÷���
		    signatureCount=weaver.SignatureAPI.SignatureCount;
		
		    if(signatureCount>=1){
		        document.getElementById("signatureCount").value=signatureCount;
		    }
		}catch(e){
		}
<%
	    if(!(isApplyMould&&isUseTempletNode&&isremark==0) && isSignatureNodes){
%>
			if(window.confirm('<%=SystemEnv.getHtmlLabelName(21658,user.getLanguage())%>')){			   
				CreateSignature(0);
			} 
<%
	    }
%>

<%
	}else{
	    if(!isLocked){
			if(canEdit){
%>
			    alert("<%=SystemEnv.getHtmlLabelName(21700,user.getLanguage())%>��<%=SystemEnv.getHtmlLabelName(21701,user.getLanguage())%>��");
<%
			}
	    }
	}
%>
       
    }catch(e){
    }
}

function onLoadAgain(){

    try{


	     WebToolsVisibleISignatureFalse();

	     <%if(canPrint&&!"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,true);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%} else if(canPrint&&"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
	document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
	     <%} else {%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("��ӡ");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
	document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
		 <%}

if("1".equals(isCompellentMark) && "1".equals(fromFlowDoc)){%>//�Ƿ���뱣���ۼ�
			document.getElementById("WebOffice").editType="-1,0,0,1,0,0,1<%=canPostil%>";
<%}else{%>
			document.getElementById("WebOffice").WebShow(false);
<%}%>
         StatusMsg(document.getElementById("WebOffice").Status);
       
        }catch(e){

        }

	    <%if(isLocked&&filetype.equals(".doc")){%>
	        	SetHidRevision();
	   <%}else {
       }%>

}

    function UnLoad(){

        try{
	        weaver.SignatureAPI.ReleaseActiveDocument();  //�˳���ʱ���ͷŻ�ĵ���һ��Ҫִ��
        }catch(e){

        }

    try{
    if (!document.getElementById("WebOffice").WebClose()){
    StatusMsg(document.getElementById("WebOffice").Status);
    }else{
    StatusMsg("<%=SystemEnv.getHtmlLabelName(19716,user.getLanguage())%>...");
    }
    }catch(e){}
    }
</script>