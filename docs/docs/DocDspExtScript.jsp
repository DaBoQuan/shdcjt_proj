<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="WorkflowBarCodeSetManager" class="weaver.workflow.workflow.WorkflowBarCodeSetManager" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="BaseBeanOfDocDspExt" class="weaver.general.BaseBean" scope="page" />
<%@ include file="/systeminfo/init.jsp" %>
<%
int docid = Util.getIntValue(request.getParameter("docid"));
String fromFlowDoc = Util.null2String(request.getParameter("fromFlowDoc"));
boolean isIWebOffice2006 = Util.null2String(request.getParameter("isIWebOffice2006")).equals("1");
int requestid = Util.getIntValue(request.getParameter("requestid"));
String ifVersion = Util.null2String(request.getParameter("ifVersion"));
String isCompellentMark = Util.null2String(request.getParameter("isCompellentMark"));
String canPostil = Util.null2String(request.getParameter("canPostil"));
String nodeid = Util.null2String(request.getParameter("nodeid"));
String isFromAccessory = Util.null2String(request.getParameter("isFromAccessory"));
String topageFromOther = Util.null2String(request.getParameter("topageFromOther"));
String isrequest = Util.null2String(request.getParameter("isrequest"));
int meetingid = Util.getIntValue(request.getParameter("meetingid"));
String hasUsedTemplet = Util.null2String(request.getParameter("hasUsedTemplet"));
String isPrintControl = Util.null2String(request.getParameter("isPrintControl"));
String doccreaterid = Util.null2String(request.getParameter("doccreaterid"));
//String docsubject = Util.null2String(request.getParameter("docsubject"));
String userid =  Util.null2String(request.getParameter("userid"));
String hasPrintNode = Util.null2String(request.getParameter("hasPrintNode"));
String isPrintNode = Util.null2String(request.getParameter("isPrintNode"));
String printApplyWorkflowId = Util.null2String(request.getParameter("printApplyWorkflowId"));
String isagentOfprintApply = Util.null2String(request.getParameter("isagentOfprintApply"));
String username =  Util.null2String(request.getParameter("username"));
int countNum = Util.getIntValue(request.getParameter("countNum"));
int isremark = Util.getIntValue(request.getParameter("isremark"));
boolean isUseTempletNode = Util.null2String(request.getParameter("isUseTempletNode")).equals("1");
String wordmouldid = Util.null2String(request.getParameter("wordmouldid"));
int versionId = Util.getIntValue(request.getParameter("versionId"));
String isSignatureNodes = Util.null2String(request.getParameter("isSignatureNodes"));
String CurrentDate = Util.null2String(request.getParameter("CurrentDate"));
String CurrentTime = Util.null2String(request.getParameter("CurrentTime"));
String replyid = Util.null2String(request.getParameter("replyid"));
String parentids = Util.null2String(request.getParameter("parentids"));
String workflowid = Util.null2String(request.getParameter("workflowid"));
String PDF417ManagerCopyRight = Util.null2String((String)session.getAttribute("PDF417ManagerCopyRight"));
boolean canPrint = Util.null2String(request.getParameter("canPrint")).equals("1");

DocManager.resetParameter();
DocManager.setId(docid);
DocManager.getDocInfoById();
String docsubject=DocManager.getDocsubject();
%>
<script language="javascript">
var checkresult = false;
var nowFunc = null;
var nowObj = null;

function checkCanSubmitCallBack(data){
	if(data>0) {
		checkresult=false;
		alert("<%=SystemEnv.getHtmlLabelName(20411,user.getLanguage())%>");
	}
	else checkresult=true;
	
	if(checkresult&&nowFunc!=null)
		if(nowObj==null) eval(nowFunc+"()");
		else eval(nowFunc+"(nowObj)");
}

    function useTemplet(){
		if(SaveDocumentOrSaveDocumentNewV()){
			<%
				        if(!"1".equals(hasUsedTemplet)){
			%>
						    document.getElementById("ClearDocAccessoriesTraceIframe").src="/docs/docs/ClearDocAccessoriesTraceIframe.jsp?operation=ClearDocAccessoriesTrace&docId=<%=docid%>&requestId=<%=requestid%>";
			<%
				        }else{
			%>
				            returnClearDocAccessoriesTrace();
			<%
				        }
			%>
					}
    }
    function getCookie(name){
    	var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    	if(arr != null){
    		return unescape(arr[2]);
    	}
    	return null;
    }
    function initExpand(){
    	var objstr1 = new Array("edition","reply","properties","mark");
    	var objstr2 = new Array("tr","up","down");
    	for(var i =0;i<objstr1.length;i++){
    		for(var j=0;j<objstr2.length;j++){
    			var tmpname = objstr1[i] + "_" + objstr2[j];
    			var tmpdisplay = getCookie(tmpname);
    			if(tmpdisplay!=null){
    				$(tmpname).style.display = tmpdisplay;
    			}
    		}
    	}
    }
    initExpand();
    function onDelete(){
    if(!checkresult) return checkCanSubmit("onDelete",null);
    
    if(confirm("<%=SystemEnv.getHtmlLabelName(19717,user.getLanguage())%>")) {

			document.getElementById("DocCheckInOutUtilIframe").src="/docs/docs/DocCheckInOutUtilIframe.jsp?operation=whetherCanDelete&docId=<%=docid%>&userId=<%=user.getUID()%>&userLoginType=<%=user.getLogintype()%>&strUserLanguage=<%=user.getLanguage()%>";

    }
    }

//oΪ���صĴ�����Ϣ
function checkForDelete(o){
	if(o==""){
		showPrompt("<%=SystemEnv.getHtmlLabelName(18894,user.getLanguage())%>");
		document.weaver.operation.value='delete';
		document.weaver.submit();
	}else{
		alert(o);
	}
}

    function onArchive(){
    if(!checkresult) return checkCanSubmit("onArchive",null);
    

    thedocno = prompt("<%=SystemEnv.getHtmlLabelName(16215,user.getLanguage())%>","") ;
    if(thedocno != null ) {
    while(thedocno.indexOf(" ") == 0)
    thedocno = thedocno.substring(1,thedocno.length);

    if(thedocno != "") {

    document.weaver.docno.value = thedocno ;
    document.weaver.operation.value='archive';
    document.weaver.submit();
    }
    }
    }

    function onPrintDoc(){

<%if(isPrintControl.equals("1")){%>
    if(document.getElementById("WebOffice").FileType==".doc"||document.getElementById("WebOffice").FileType==".docx"){	
	    WebCopysCtrlPrint();
    }else if(document.getElementById("WebOffice").FileType==".xls"||document.getElementById("WebOffice").FileType==".xlsx"){
   	    WebCopysCtrlPrintExcel();   //����EXCEL����
    }else{
		document.getElementById("WebOffice").WebOpenPrint();
	}
<%}else{%>		
		document.getElementById("WebOffice").WebOpenPrint();
<%}%>
		/**TD12005 �ĵ���־����ӡ��־��¼����ʼ*/
		DocDetailLogWrite.writeDetailLog("<%=docid%>", "<%=Util.stringReplace4DocDspExt(docsubject)%>", "21", "<%=user.getUID()%>", "<%=user.getLogintype()%>", "<%=request.getRemoteAddr()%>", "<%=doccreaterid%>", callbackWriteLog);
		/**TD12005 �ĵ���־����ӡ��־��¼������*/
    }

//��ӡ��������
function WebCopysCtrlPrint(){
	var mCopies,objPrint;
    objPrint = document.getElementById("WebOffice").WebObject.Application.Dialogs(88);     //��ӡ���öԻ���
    if (objPrint.Display==-1){
        mCopies=objPrint.NumCopies;    //ȡ����Ҫ��ӡ����
        document.getElementById("WebOffice").WebSetMsgByName("COMMAND","COPIES");
        document.getElementById("WebOffice").WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //���ñ���OFFICEPRINTS��ֵ����WebSendMessage()ʱ��һ���ύ��OfficeServer��
        document.getElementById("WebOffice").WebSetMsgByName("DOCID","<%=docid%>");  
        document.getElementById("WebOffice").WebSetMsgByName("USERID","<%=userid%>");
        document.getElementById("WebOffice").WebSetMsgByName("CLIENTADDRESS","<%=request.getRemoteAddr()%>");	
        document.getElementById("WebOffice").WebSetMsgByName("HASPRINTNODE","<%=hasPrintNode%>");
        document.getElementById("WebOffice").WebSetMsgByName("ISPRINTNODE","<%=isPrintNode%>");				
        document.getElementById("WebOffice").WebSetMsgByName("CANPRINT","<%=canPrint%>");		
        document.getElementById("WebOffice").WebSendMessage();                               //����OfficeServer��OPTION="SENDMESSAGE"       
        if (document.getElementById("WebOffice").Status=="1") {
            objPrint.Execute;
        }else{
            var maxPrints=document.getElementById("WebOffice").WebGetMsgByName("MAXPRINTS");			
            alert("<%=SystemEnv.getHtmlLabelName(21534 ,user.getLanguage())%>��<%=SystemEnv.getHtmlLabelName(21535 ,user.getLanguage())%>��"+maxPrints);
            return false;
        }
    }
}

//��ӡ��������   EXCEL
function WebCopysCtrlPrintExcel(){

	document.getElementById("WebOffice").WebOpenPrint();

}
    function onPrintApply(){
		openFullWindow("/workflow/request/AddRequest.jsp?workflowid=<%=printApplyWorkflowId%>&isagent=<%=isagentOfprintApply%>&docid=<%=docid%>");
    }

    function doSign(){

    document.weaver.remark.value+="\n<%=username%>  <%=CurrentDate%>  <%=CurrentTime%>";
    }

    function doRelateWfFun(docid) {
		openFullWindow("/workflow/search/WFSearchTemp.jsp?docids="+docid);
	}   

    function doReply(){

    location="DocReply.jsp?id=<%=replyid%>&parentids=<%=parentids%>";
    }


function selectTemplate(seccategory,wordmouldid){
    wordmouldid=document.getElementById("selectedpubmouldid").value;
    var rt = window.showModalDialog("TaoHongTemplate.jsp?seccategory="+seccategory+"&wordmouldid="+wordmouldid," ","dialogWidth=450px;dialogHeight=450px");
    if(rt != null){
		document.getElementById("WebOffice").Template=rt;
        document.getElementById("selectedpubmouldid").value=rt;
		document.getElementById("WebOffice").WebSetMsgByName("SHOWDOCMOULDBOOKMARK","<%=fromFlowDoc%>");//�����Ƿ���ʾ���ĵ�ģ����ǩ������,����ݡ��Ƿ���Դ�����̽��ĵ�����ȷ����		
		document.getElementById("WebOffice").WebSetMsgByName("COMMAND","LOADVIEWMOULD");//������ʾģ��

		if(document.getElementById("WebOffice").WebLoadTemplate()){//�����ģ��ɹ�
		    //WebToolsVisible("iSignature",false);
		    WebToolsVisibleISignatureFalse();

			var t_EditType = document.getElementById("WebOffice").EditType;
			document.getElementById("WebOffice").EditType = "-1,0,0,0,0,0,1<%=canPostil%>";

		    document.getElementById("WebOffice").RecordID=document.getElementById("versionId").value+"_<%=docid%>";
		    document.getElementById("WebOffice").WebLoadBookMarks();//�滻��ǩ

		    //document.getElementById("WebOffice").RecordID=<%=(versionId==0?"":versionId+"")%>;
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
		    document.getElementById("WebOffice").RecordID=document.getElementById("versionId").value+"_<%=docid%>";
			 <%if(isIWebOffice2006 == true){%>
				document.getElementById("WebOffice").ShowType="1";
			 <%}%>
			//WebToolsVisible("iSignature",false);
			WebToolsVisibleISignatureFalse();
		}
	}
}

function saveTHTemplate(wordmouldid){
	btndisabledtrue();
	setTimeout("btndisabledfalse();",10000);

  if(wordmouldid != null){
     if(window.confirm('<%=SystemEnv.getHtmlLabelName(21664,user.getLanguage())%>')){
		 document.getElementById("hasUsedTemplet").value="1";
	  if(<%=isSignatureNodes%>){
		document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","TRUE");	     
        if(<%if (!ifVersion.equals("1")) {%> SaveDocument()<%} else {%>SaveDocumentNewV()<%}%>){

		  document.getElementById("ClearDocAccessoriesTraceIframe").src="/docs/docs/ClearDocAccessoriesTraceIframe.jsp?operation=useTempletUpdate&docId=<%=docid%>&requestId=<%=requestid%>";
		}
        document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","FALSE");
	  }else{
		useTemplet();
	  }
	   var isUserTemplate = parent.frames["bodyiframe"].document.getElementById("temphasUseTempletSucceed");
     isUserTemplate.value = true;
	}else{
	  return;
	}
  }else{
    alert("<%=SystemEnv.getHtmlLabelName(21252,user.getLanguage())%>");
  }
}

function saveTHTemplateNoConfirm(wordmouldid){
	btndisabledtrue();
	setTimeout("btndisabledfalse();",10000);

	if(wordmouldid != null){
		 document.getElementById("hasUsedTemplet").value=1;
		if(<%=isSignatureNodes%>){
		    document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","TRUE");
			if(<%if (!ifVersion.equals("1")) {%> SaveDocument()<%} else {%>SaveDocumentNewV()<%}%>){
				document.getElementById("ClearDocAccessoriesTraceIframe").src="/docs/docs/ClearDocAccessoriesTraceIframe.jsp?operation=useTempletUpdate&docId=<%=docid%>&requestId=<%=requestid%>";
			}
			document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","FALSE");
		}else{
			useTemplet();
		}

	}else{
        alert("<%=SystemEnv.getHtmlLabelName(21252,user.getLanguage())%>");
	}
}

function useTempletCancel(){
	btndisabledtrue();
	setTimeout("btndisabledfalse();",10000);

    if(window.confirm('<%=SystemEnv.getHtmlLabelName(22984,user.getLanguage())%>')){
		document.getElementById("DocCheckInOutUtilIframe").src="/docs/docs/DocCheckInOutUtilIframe.jsp?operation=useTempletCancel&docId=<%=docid%>&versionId=<%=versionId%>&userId=<%=user.getUID()%>";
		var isUserTemplate = parent.frames["bodyiframe"].document.getElementById("temphasUseTempletSucceed");
     isUserTemplate.value = false;
	}
}

function useTempletCancelReturn(returnVersionId){

	if(returnVersionId==""){
		return;
	}

		document.getElementById("WebOffice").Template="<%=wordmouldid%>";
        document.getElementById("selectedpubmouldid").value="<%=wordmouldid%>";
		document.getElementById("WebOffice").WebSetMsgByName("SHOWDOCMOULDBOOKMARK","<%=fromFlowDoc%>");//�����Ƿ���ʾ���ĵ�ģ����ǩ������,����ݡ��Ƿ���Դ�����̽��ĵ�����ȷ����		
	    
		document.getElementById("WebOffice").WebSetMsgByName("COMMAND","LOADVIEWMOULD");//������ʾģ��

		if(document.getElementById("WebOffice").WebLoadTemplate()){//�����ģ��ɹ�
		    WebToolsVisible("iSignature",false);
			var t_EditType = document.getElementById("WebOffice").EditType;
			document.getElementById("WebOffice").EditType = "-1,0,0,0,0,0,1<%=canPostil%>";
		    document.getElementById("WebOffice").RecordID=document.getElementById("versionId").value+"_<%=docid%>";
		    document.getElementById("WebOffice").WebLoadBookMarks();//�滻��ǩ
		    document.getElementById("versionId").value=returnVersionId;
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
		    document.getElementById("versionId").value=returnVersionId;
		    document.getElementById("WebOffice").RecordID=document.getElementById("versionId").value+"_<%=docid%>";
		    document.getElementById("WebOffice").WebOpen();
			 <%if(isIWebOffice2006 == true){%>
				document.getElementById("WebOffice").ShowType="1";
			 <%}%>
			WebToolsVisible("iSignature",false);
		}
		
		try{
			//Ext.getCmp("thCancel_id").hide();
			document.getElementById("thCancel_id").style.display = "none";
		}catch(e){
		}
		try{
			//Ext.getCmp("thSaveAgain_id").hide();
			document.getElementById("thSaveAgain_id").style.display = "none";
		}catch(e){
		}
		try{
			//Ext.getCmp("thSure_id").show();
			document.getElementById("thSure_id").style.display = "block";
		}catch(e){
		}
		try{
			<%if(countNum > 1 &&isUseTempletNode&&isremark==0){%>
			    //Ext.getCmp("thModeS_id").show();
			    document.getElementById("thModeS_id").style.display = "block";	
			<%}%>

		}catch(e){
		}
        try{
        	//Ext.getCmp("signature_id1").hide();
			document.getElementById("signature_id1").style.display = "none";
        }catch(e){
        }
        try{
        	//Ext.getCmp("signature_id2").hide();
			document.getElementById("signature_id2").style.display = "none";
        }catch(e){
        }

		try{
			document.getElementById("WebOffice").DisableMenu("<%=SystemEnv.getHtmlLabelName(19718,user.getLanguage())%>");
		}catch(e){
		}
}

var stSign = 0x00000001;     //����ǩ��
var stHand = 0x00000002;     //��дǩ��
var  ssSucceeded = 0x0000;   //�ɹ�
var  ssDocumentLocked    = 0x0003;     //�ĵ��Ѿ�����

function CreateSignature(id){
  <%if(isIWebOffice2006 == true){%>
	   if(document.getElementById("WebOffice").Pages >=1){
		  document.getElementById("WebOffice").ShowType="1";								 
	   }
  <%}%>
  SetActiveDocument();   //���û�ĵ�

    var revisionsCount=0;

    try{
	    revisionsCount=document.getElementById("WebOffice").WebObject.Revisions.Count;
    }catch(e){
    }

    var signatureCount=0;
    try{
	    weaver.SignatureAPI.InitSignatureItems();  //��ǩ�����ݷ����仯ʱ��������ִ�и÷���
	    signatureCount=weaver.SignatureAPI.SignatureCount;
    }catch(e){
    }
    if(revisionsCount>0&&signatureCount<=0){
		document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","TRUE");
<%
if(ifVersion.equals("1")){
%>
        SaveDocumentNewV();
<%
}else if("1".equals(isCompellentMark)){
%>
	    if(hasAcceptAllRevisions=="true"){
            SaveDocumentNewV();
            hasAcceptAllRevisions="false";
        }else{
			SaveDocument();
		}
<%
}else{
%>
        SaveDocument();
<%
}
%>
        document.getElementById("WebOffice").WebSetMsgByName("NONEWVERSION","FALSE");
	    if(weaver.SignatureAPI.SelectionState==ssDocumentLocked) {
		    weaver.SignatureAPI.UnLockDocument();	//�Ᵽ��
	    }
        //���������ϼӸǹ���
        document.getElementById("WebOffice").WebObject.AcceptAllRevisions(); //���ܺۼ�
        hasAcceptAllRevisions="true";
    }

    var t_EditType = document.getElementById("WebOffice").EditType;
	document.getElementById("WebOffice").EditType = "-1,0,0,0,0,0,1<%=canPostil%>";

    var t_TrackRevisions = false;
	try{
		t_TrackRevisions = document.getElementById("WebOffice").WebObject.TrackRevisions;
	    document.getElementById("WebOffice").WebObject.TrackRevisions = false;  //ȡ���޶�
	}catch(e){}

  if(id==0){
	if(weaver.SignatureAPI.SelectionState==ssSucceeded) {
		 weaver.SignatureAPI.CreateSignature(stSign);	//��������ǩ��
	}
	if(weaver.SignatureAPI.SelectionState==ssDocumentLocked) {

		 weaver.SignatureAPI.UnLockDocument();	//�Ᵽ��
		 weaver.SignatureAPI.CreateSignature(stSign);	//��������ǩ��

	}
  }

	try{
		document.getElementById("WebOffice").WebObject.TrackRevisions = t_TrackRevisions;  
	}catch(e){}

	document.getElementById("WebOffice").EditType = t_EditType;
 }

 function saveIsignatureFun(){
	btndisabledtrue();
	setTimeout("btndisabledfalse();",10000);

  <%if(isIWebOffice2006 == true){%>
	   if(document.getElementById("WebOffice").Pages >=1){
		  document.getElementById("WebOffice").ShowType="1";								 
	   }
  <%}%>
  if(window.confirm('<%=SystemEnv.getHtmlLabelName(21667,user.getLanguage())%>')){

	   try{
		   SetActiveDocument();   //���û�ĵ�


           weaver.SignatureAPI.InitSignatureItems();  //��ǩ�����ݷ����仯ʱ��������ִ�и÷���
	        var newSignatureCount=weaver.SignatureAPI.SignatureCount;
			if(newSignatureCount!=document.getElementById("signatureCount").value){

				document.getElementById("DocCheckInOutUtilIframe").src="/docs/docs/DocCheckInOutUtilIframe.jsp?operation=saveIsignatureFun&requestid=<%=requestid%>&nodeId=<%=nodeid%>&userId=<%=user.getUID()%>&loginType=<%=Util.getIntValue(user.getLogintype(),1)%>&signNum="+(newSignatureCount-document.getElementById("signatureCount").value);
				return ;
			}
	   }catch(e){

	   }

       document.getElementById("WebOffice").WebSetMsgByName("CLEARHANDWRITTEN","TRUE");//ClearHandwritten   �����д��ע

       useTempletNoChangeDocAccessories();
  }
}
function docVersionWord(vid){
    url="/docs/docs/listVersion.jsp?versionId="+vid+"&docid=<%=docid%>";
    
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
	
	if(id!=null&&id!='undefined')
    	if(id.id!="")
    		window.location="DocDspExt.jsp?id=<%=docid%>&versionId="+id.id+"&fromFlowDoc=<%=fromFlowDoc%>&isrequest=<%=isrequest%>&requestid=<%=requestid%>&isFromAccessory=<%=isFromAccessory%>&isNoTurnWhenHasToPage=true&topage=<%=URLEncoder.encode(topageFromOther)%>&meetingid=<%=meetingid%>";
}


	 
</script>
<script language="vbs">
    function docVersionWord2(vid)
    url=escape("/docs/docs/listVersion.jsp?versionId="&vid&"&docid=<%=docid%>")
    id2 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="&url)
	if (Not IsEmpty(id1)) then
    if id1(0)<> "" then
    window.location="DocDspExt.jsp?id=<%=docid%>&versionId="&id1(0)&"&fromFlowDoc=<%=fromFlowDoc%>&isrequest=<%=isrequest%>&requestid=<%=requestid%>&isFromAccessory=<%=isFromAccessory%>&isNoTurnWhenHasToPage=true&topage=<%=URLEncoder.encode(topageFromOther)%>&meetingid=<%=meetingid%>"
    end if
    end if
    end function

	function docVersion(iid,vid)
        url=escape("/docs/docs/listVersion.jsp?versionId="&vid&"&docid=<%=docid%>")
        id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="&url)   
		if (Not IsEmpty(id)) then
            if id(0)<> "" then
                'msgbox ("selectVersion" & iid)
                'msgbox id(0)&"  "&id(1)&"   "&iid
                document.getElementById("selectVersion" & iid).href="DocDspExt.jsp?id=<%=docid%>&versionId="&id(0)&"&isFromAccessory=true&meetingid=<%=meetingid%>&imagefileId="&id(1)
                onclickStr=chr(34)&"top.location='/weaver/weaver.file.FileDownload?fileid="&id(1)&"&download=1'"&chr(34)
                document.getElementById("selectDownload" & iid).innerHtml="<a href='#'  onclick="&onclickStr&"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></a>"
            end if
        end if
    end function
</script>