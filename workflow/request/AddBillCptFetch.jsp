<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowAddRequestTitle.jsp" %>
<jsp:useBean id="WFNodeDtlFieldManager" class="weaver.workflow.workflow.WFNodeDtlFieldManager" scope="page" />
<form name="frmmain" method="post" action="BillCptFetchOperation.jsp" enctype="multipart/form-data">
<input type="hidden" name="needwfback" id="needwfback" value="1" />
    <%@ include file="/workflow/request/WorkflowAddRequestBody.jsp" %>
<%
//��ȡ��ϸ������
WFNodeDtlFieldManager.resetParameter();
WFNodeDtlFieldManager.setNodeid(Util.getIntValue(""+nodeid));
WFNodeDtlFieldManager.setGroupid(0);
WFNodeDtlFieldManager.selectWfNodeDtlField();
String dtladd = WFNodeDtlFieldManager.getIsadd();
String dtledit = WFNodeDtlFieldManager.getIsedit();
String dtldelete = WFNodeDtlFieldManager.getIsdelete();
%>

<!---
�ӱ���Ϣ��ȡ..
-->
<%
	
String totalamountsum = "" ;
fieldids.clear();
fieldlabels.clear();
fieldhtmltypes.clear();
fieldtypes.clear();
fieldnames.clear();
ArrayList viewtypes=new ArrayList();
RecordSet.executeProc("workflow_billfield_Select",formid+"");
while(RecordSet.next()){
	String theviewtype = Util.null2String(RecordSet.getString("viewtype")) ;
	if( !theviewtype.equals("1") ){
		if("totalamount".equals(RecordSet.getString("fieldname"))){
			totalamountsum = "field"+RecordSet.getString("id");
		}
		continue ;
	}   // ����ǵ��ݵ������ֶ�,����ʾ
	fieldids.add(RecordSet.getString("id"));
	fieldlabels.add(RecordSet.getString("fieldlabel"));
	fieldhtmltypes.add(RecordSet.getString("fieldhtmltype"));
	fieldtypes.add(RecordSet.getString("type"));
	fieldnames.add(RecordSet.getString("fieldname"));
	viewtypes.add(RecordSet.getString("viewtype"));
}

isviews.clear();
isedits.clear();
ismands.clear();
RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
while(RecordSet.next()){
	
	String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
	int thefieldidindex = fieldids.indexOf( thefieldid ) ;
	if( thefieldidindex == -1 ) continue ;
	isviews.add(RecordSet.getString("isview"));
	isedits.add(RecordSet.getString("isedit"));
	ismands.add(RecordSet.getString("ismandatory"));
}

String dsptypes ="";
String edittypes ="";
String mandtypes ="";
int tmpcount = 1;
int viewCount = 0; 
for(int ii=0;ii<fieldids.size();ii++){
	String isview1=(String)isviews.get(ii);
	if(isview1.equals("1")) viewCount++;
	}
if(viewCount>0){
%>
<table class=liststyle cellspacing=1 >
<tr>
	<td>
		<div>
		<%if(dtladd.equals("1")){%>
		<BUTTON Class=BtnFlow type=button accessKey=A onclick="addRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></BUTTON>
		<%}
		if(dtladd.equals("1") || dtldelete.equals("1")){%>
		<BUTTON Class=BtnFlow type=button accessKey=E onclick="deleteRow1();"><U>E</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
		<%}%>
		</div>
	</td>
</tr>
</table>

<table class=liststyle cellspacing=1   cols=9 id="oTable"><COLGROUP>
<COL width="15%">
<tr class=header> 
	   <td width="5%"><%=SystemEnv.getHtmlLabelName(1426,user.getLanguage())%></td>
<%
for(int i=0;i<fieldids.size();i++){
	String fieldname=(String)fieldnames.get(i);
	String fieldid=(String)fieldids.get(i);
	String isview=(String)isviews.get(i);
	String isedit=(String)isedits.get(i);
	String ismand=(String)ismands.get(i);
	String fieldhtmltype=(String)fieldhtmltypes.get(i);
	String fieldtype=(String)fieldtypes.get(i);
	String fieldlable=SystemEnv.getHtmlLabelName(Util.getIntValue((String)fieldlabels.get(i),0),user.getLanguage());
	String viewtype = (String)viewtypes.get(i);
	if(viewtype.equals("0"))
		continue;
	
	dsptypes +=","+tmpcount+"_"+isview;
	edittypes +=","+tmpcount+"_"+isedit;
	mandtypes +=","+tmpcount+"_"+ismand;
	tmpcount++;
%>
    	  
            <td <%if(isview.equals("0")){%> style="display:none" <%}%> width="<%=viewCount==0?0:95/viewCount%>%"><%=Util.toScreen(fieldlable,user.getLanguage())%></td>
<%}%>
            </tr>
			<tr><td class="Line2" colspan="2"></td></tr>
</table>
<%}%>
<input type='hidden' id=nodesnum name=nodesnum>
<!-- ����дǩ�����Start TD10404 -->
	<table class="ViewForm" >
	<colgroup>
	<col width="20%">
	<col width="80%">
	<tr class="Title">
      <td colspan=2 align="center" valign="middle"><font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></font></td>
    </tr>
    <tr>
      <td><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></td>
      <td class=field>
      <!-- modify by xhheng @20050308 for TD 1692 -->
         <%
         //String workflowPhrases[] = WorkflowPhrase.getUserWorkflowPhrase(""+userid);
        //add by cyril on 2008-09-30 for td:9014
 		boolean isSuccess  = RecordSet.executeProc("sysPhrase_selectByHrmId",""+userid); 
 		String workflowPhrases[] = new String[RecordSet.getCounts()];
 		String workflowPhrasesContent[] = new String[RecordSet.getCounts()];
 		int m = 0 ;
 		if (isSuccess) {
 			while (RecordSet.next()){
 				workflowPhrases[m] = Util.null2String(RecordSet.getString("phraseShort"));
 				workflowPhrasesContent[m] = Util.toHtml(Util.null2String(RecordSet.getString("phrasedesc")));
 				m ++ ;
 			}
 		}
 		//end by cyril on 2008-09-30 for td:9014

if("1".equals(isFormSignature)){
		 int workflowRequestLogId=-1;
%>
		<jsp:include page="/workflow/request/WorkflowLoadSignature.jsp">
			<jsp:param name="workflowRequestLogId" value="<%=workflowRequestLogId%>" />
			<jsp:param name="isSignMustInput" value="<%=isSignMustInput%>" />
			<jsp:param name="formSignatureWidth" value="<%=formSignatureWidth%>" />
			<jsp:param name="formSignatureHeight" value="<%=formSignatureHeight%>" />
		</jsp:include>
<%
}else{
             if(workflowPhrases.length>0){
         %>
                <select class=inputstyle  id="phraseselect" name=phraseselect style="width:80%" onChange='onAddPhrase(this.value)'>
                <option value="">����<%=SystemEnv.getHtmlLabelName(22409,user.getLanguage())%>����</option>
                <%
                  for (int i= 0 ; i <workflowPhrases.length;i++) {
                    String workflowPhrase = workflowPhrases[i] ;
                    //�����value�ĳ�����
                %>
                    <option value="<%=workflowPhrasesContent[i]%>"><%=workflowPhrase%></option>
                <%}%>
                </select>

          <%}%>
				<input type="hidden" id="remarkText10404" name="remarkText10404" temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>" value="">
              <textarea class=Inputstyle name=remark rows=4 cols=40 style="width=80%;display:none" class=Inputstyle temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"  <%if(isSignMustInput.equals("1")){%>onChange="checkinput('remark','remarkSpan')"<%}%>></textarea>
	  		   	<script defer>
	  		   	function funcremark_log(){
					FCKEditorExt.initEditor("frmmain","remark",<%=user.getLanguage()%>,FCKEditorExt.NO_IMAGE);
				<%if(isSignMustInput.equals("1")){%>
					FCKEditorExt.checkText("remarkSpan","remark");
				<%}%>
					FCKEditorExt.toolbarExpand(false,"remark");
				}
	  		  	if(ieVersion>=8) window.attachEvent("onload", funcremark_log());
	  		  	else window.attachEvent("onload", funcremark_log);
				</script>
              <span id="remarkSpan">
<%
	if(isSignMustInput.equals("1")){
%>
			  <img src="/images/BacoError.gif" align=absmiddle>
<%
	}
%>
              </span>
<%}%>

       </td>
    </tr>
	<tr><td class=Line2 colSpan=2></td></tr>
    <%
         if("1".equals(isSignDoc_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signdocids" name="signdocids">
                <button class=Browser onclick="onShowSignBrowser('/docs/docs/MutiDocBrowser.jsp','/docs/docs/DocDsp.jsp?isrequest=1&id=','signdocids','signdocspan',37)" title="<%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%>"></button>
                <span id="signdocspan"></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         if("1".equals(isSignWorkflow_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signworkflowids" name="signworkflowids">
                <button class=Browser onclick="onShowSignBrowser('/workflow/request/MultiRequestBrowser.jsp','/workflow/request/ViewRequest.jsp?isrequest=1&requestid=','signworkflowids','signworkflowspan',152)" title="<%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%>"></button>
                <span id="signworkflowspan"></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         String isannexupload_add=(String)session.getAttribute(userid+"_"+workflowid+"isannexupload");
         if("1".equals(isannexupload_add)){
            int annexmainId=0;
             int annexsubId=0;
             int annexsecId=0;
             String annexdocCategory_add=(String)session.getAttribute(userid+"_"+workflowid+"annexdocCategory");
             if("1".equals(isannexupload_add) && annexdocCategory_add!=null && !annexdocCategory_add.equals("")){
                annexmainId=Util.getIntValue(annexdocCategory_add.substring(0,annexdocCategory_add.indexOf(',')));
                annexsubId=Util.getIntValue(annexdocCategory_add.substring(annexdocCategory_add.indexOf(',')+1,annexdocCategory_add.lastIndexOf(',')));
                annexsecId=Util.getIntValue(annexdocCategory_add.substring(annexdocCategory_add.lastIndexOf(',')+1));
              }
             int annexmaxUploadImageSize=Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+annexsecId),5);
             if(annexmaxUploadImageSize<=0){
                annexmaxUploadImageSize = 5;
             }
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></td>
            <td class=field>
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
        	window.attachEvent("onload", fileuploadannexupload);
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
                  </div>
                  <input  class=InputStyle  type=hidden size=60 name="field-annexupload" >
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
              <input type=hidden name='annexmainId' value=<%=annexmainId%>>
              <input type=hidden name='annexsubId' value=<%=annexsubId%>>
              <input type=hidden name='annexsecId' value=<%=annexsecId%>>
          </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}}%>
	</table>
<!-- ����дǩ�����End TD10404 -->
</form> 
<script language=javascript>
rowindex = 0;
needcheck = "<%=needcheck%>";
function addRow()
{
	ncol = oTable.cols;
	dsptypes = "<%=dsptypes%>";
	edittypes = "<%=edittypes%>";
	mandtypes = "<%=mandtypes%>";
	
	oRow = oTable.insertRow(-1);
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1);  
		oCell.style.height=24;
		oCell.style.background= "#D2D1F1";
		if(dsptypes.indexOf(j+"_0")!=-1){
			oCell.style.display="none";
		}
		switch(j) {
			case 0:
				var oDiv = document.createElement("div");
				var sHtml = "<input type='checkbox' name='check_node' value='"+rowindex+"'><input type='hidden' name='check_node_val' value='"+rowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			
			case 1: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("1_1")!=-1){
					sHtml = "<button class=Browser onClick='onShowAsset(node_"+rowindex+"_cptspan,node_"+rowindex+"_cptid)'></button> " + 
        					"<span id=node_"+rowindex+"_cptspan>";
        				if(mandtypes.indexOf("1_1")!=-1){
        					sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_cptid";
        				}
        				sHtml +="</span> <input type='hidden' name='node_"+rowindex+"_cptid' id='node_"+rowindex+"_cptid'>";
        				oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
				}
				break;
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("2_1")!=-1){
					sHtml = "<button class=Browser onClick='onShowCptCapital(node_"+rowindex+"_capitalidspan,node_"+rowindex+"_capitalid,node_"+rowindex+"_capitalcount,node_"+rowindex+"_number,node_"+rowindex+"_numberspan,\"node_"+rowindex+"\")'></button> " + 
        					"<span id=node_"+rowindex+"_capitalidspan>";
        				if(mandtypes.indexOf("2_1")!=-1){
        					sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_capitalid";
        				}
        				sHtml +="</span> <input type='hidden' name='node_"+rowindex+"_capitalid' id='node_"+rowindex+"_capitalid'><input type='hidden' name='node_"+rowindex+"_capitalcount' id='node_"+rowindex+"_capitalcount'>";
        				oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
				}
				break;
			case 3: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("3_1")!=-1){
					if(mandtypes.indexOf("3_1")!=-1){ 
						sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_number' onKeyPress='ItemNum_KeyPress()' onBlur=\"checkinput('node_"+rowindex+"_number','node_"+rowindex+"_numberspan');checkCount("+rowindex+");changeamountsum('node_"+rowindex+"')\"><span id='node_"+rowindex+"_numberspan'>";
						sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
						sHtml+="</span>";
        					needcheck += ","+"node_"+rowindex+"_number";
        				}else{
        					sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_number' onKeyPress='ItemNum_KeyPress()' onBlur='checkCount("+rowindex+");changeamountsum(\"node_"+rowindex+"\")'><span id='node_"+rowindex+"_numberspan'></span>";
        				}
	        			oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
				}else{
                    sHtml = "<input type='hidden' class=Inputstyle  name='node_"+rowindex+"_number'><span id='node_"+rowindex+"_numberspan'></span>";
	        	    oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv); 
                }
				break;
			case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("4_1")!=-1){
					if(mandtypes.indexOf("4_1")!=-1){
						sHtml = "<input type='text' class=Inputstyle   name='node_"+rowindex+"_unitprice'  onKeyPress='ItemNum_KeyPress()' onBlur=checkinput('node_"+rowindex+"_unitprice','node_"+rowindex+"_unitpricespan');changeamountsum('node_"+rowindex+"')><span id='node_"+rowindex+"_unitpricespan'>";
						sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_unitprice";
        					sHtml+="</span>"
        				}else{
        					sHtml = "<input type='text'  class=Inputstyle onBlur=changeamountsum('node_"+rowindex+"') name='node_"+rowindex+"_unitprice'>";
        				}
        				
        				  
        			}else{
        				sHtml = "<input type='hidden' class=Inputstyle  name='node_"+rowindex+"_unitprice'><span id='node_"+rowindex+"_unitpricespan'></span>";	
            		}
					oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);
				break;
			case 5: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("5_1")!=-1){
					if(mandtypes.indexOf("5_1")!=-1){
						sHtml = "<input type='text' class=Inputstyle   name='node_"+rowindex+"_amount'  onKeyPress='ItemNum_KeyPress()' onBlur=checkinput('node_"+rowindex+"_amount','node_"+rowindex+"_amountspan')><span id='node_"+rowindex+"_amountspan'>";
						sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_amount";
        					sHtml+="</span>"
        				}else{
        					sHtml = "<input type='text' class=Inputstyle   name='node_"+rowindex+"_amount'>";
        				}
        				
        			}else{
        				sHtml = "<input type='hidden' class=Inputstyle  name='node_"+rowindex+"_amount'><span id='node_"+rowindex+"_amountspan'></span>";
            		}

						oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  

				break;
			
			case 6: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";
				if(edittypes.indexOf("6_1")!=-1){
					sHtml = "<button class=Browser onClick='onBillCPTShowDate(node_"+rowindex+"_needdatespan,node_"+rowindex+"_needdate,"+mandtypes.indexOf("6_1")+")'></button> " + 
						"<span class=Inputstyle id=node_"+rowindex+"_needdatespan> ";
					if(mandtypes.indexOf("6_1")!=-1){
        					sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_needdate";
        				}
        				sHtml+="</span>"
        				sHtml += "<input type='hidden' name='node_"+rowindex+"_needdate' id='node_"+rowindex+"_needdate'>";
        				oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
        			}
				break;
			
			case 7: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";;
				if(edittypes.indexOf("7_1")!=-1){
					if(mandtypes.indexOf("7_1")!=-1){
						sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_purpose' onBlur=checkinput('node_"+rowindex+"_purpose','node_"+rowindex+"_purposespan')><span id='node_"+rowindex+"_purposespan'>";
						sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_purpose";
        					sHtml+="</span>"        				
        				}else{
        					sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_purpose'>";
        				}
        				oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
        			}
				break;	
			case 8: 
				var oDiv = document.createElement("div"); 
				var sHtml = "";;
				if(edittypes.indexOf("8_1")!=-1){
					if(mandtypes.indexOf("8_1")!=-1){
						sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_cptdesc' onBlur=checkinput('node_"+rowindex+"_cptdesc','node_"+rowindex+"_cptdescspan')><span id='node_"+rowindex+"_cptdescspan'>";
						sHtml += "<img src='/images/BacoError.gif' align=absmiddle>";
        					needcheck += ","+"node_"+rowindex+"_cptdesc";
        					sHtml+="</span>"        				
        				}else{
        					sHtml = "<input type='text' class=Inputstyle  name='node_"+rowindex+"_cptdesc'>";
        				}
        				oDiv.innerHTML = sHtml;   
					oCell.appendChild(oDiv);  
        			}
				break;	
				
		}
	}
	rowindex = rowindex*1 +1;
	document.frmmain.nodesnum.value = rowindex ;
	document.all("needcheck").value += ","+needcheck;
}

function checkCount(index){
    //var stockamount = document.all("node_"+index+"_capitalcount").value;
    //var useamount = document.all("node_"+index+"_number").value;
    //if(eval(useamount)>eval(stockamount)){
    //   alert("<%=SystemEnv.getHtmlLabelName(15313,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(1446,user.getLanguage())%>");
    //    document.all("node_"+index+"_number").value = stockamount;
    //}
}
function deleteRow1()
{
    var flag = false;
	var ids = document.getElementsByName('check_node');
	for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
	}
    if(flag) {
		if(isdel()){
            len = document.forms[0].elements.length;
            var i=0;
            var rowsum1 = 0;
            for(i=len-1; i >= 0;i--) {
                if (document.forms[0].elements[i].name=='check_node')
                    rowsum1 += 1;
            }
			var sumnum = rowsum1;
            mandtypes = "<%=mandtypes%>";
            for(i=len-1; i >= 0;i--) {
                if (document.forms[0].elements[i].name=='check_node'){
                    if(document.forms[0].elements[i].checked==true) {
                        tmprow = document.forms[0].elements[i].value;
                        for(j=0; j<7; j++) {
                            if(mandtypes.indexOf(j+"_1")!=-1){
                                if(j==1)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_cptid","");
                                if(j==2)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_capitalid","");
                                if(j==3)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_number","");
                                if(j==4)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_unitprice","");
                                if(j==5)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_amount","");
                                if(j==6)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_needdate","");
                                if(j==7)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_purpose","");
                                if(j==8)
                                    needcheck = needcheck.replace(",node_"+tmprow+"_cptdesc","");

                            }
                        }
                        oTable.deleteRow(rowsum1+1);
						sumnum -=1;
        //				rowindex = rowindex*1 - 1;
                    }
                    rowsum1 -=1;
 //                   rowindex-=1;
                }
            }
			document.frmmain.nodesnum.value = sumnum ;
            amountsumcount();
        }
    }else{
        alert('<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>');
		return;
    }
}	

function DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo)
{  
    YearFrom  = parseInt(YearFrom,10);
    MonthFrom = parseInt(MonthFrom,10);
    DayFrom = parseInt(DayFrom,10);
    YearTo    = parseInt(YearTo,10);
    MonthTo   = parseInt(MonthTo,10);
    DayTo = parseInt(DayTo,10);
    if(YearTo<YearFrom)
    return false;
    else{
        if(YearTo==YearFrom){
            if(MonthTo<MonthFrom)
            return false;
            else{
                if(MonthTo==MonthFrom){
                    if(DayTo<DayFrom)
                    return false;
                    else
                    return true;
                }
                else 
                return true;
            }
            }
        else
        return true;
        }
}


function checktimeok(){
if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && document.frmmain.<%=newenddate%>.value != ""){
			YearFrom=document.frmmain.<%=newfromdate%>.value.substring(0,4);
			MonthFrom=document.frmmain.<%=newfromdate%>.value.substring(5,7);
			DayFrom=document.frmmain.<%=newfromdate%>.value.substring(8,10);
			YearTo=document.frmmain.<%=newenddate%>.value.substring(0,4);
			MonthTo=document.frmmain.<%=newenddate%>.value.substring(5,7);
			DayTo=document.frmmain.<%=newenddate%>.value.substring(8,10);
			// window.alert(YearFrom+MonthFrom+DayFrom);
                   if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
        window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
         return false;
  			 }
  }
     return true; 
}
function toFloat(str , def) {
    if(isNaN(parseFloat(str))) return def ;
    else return str ;
}

function toInt(str , def) {
    if(isNaN(parseInt(str))) return def ;
    else return str ;
}

function amountsumcount(){
	if(document.getElementById("<%=totalamountsum%>")){
	var amountsum = 0;
	//alert(rowindex);
	for(var i=0;i<rowindex;i++){
		var amounttmp = "";
		try{
			amounttmp = eval(toFloat(document.getElementById("node_"+i+"_amount").value,0));
		}catch(e){amounttmp="";}
		//alert(amounttmp);
		if(amounttmp==""){
			amountsum += 0;
		}else{
			amountsum += parseFloat(amounttmp);
		}
	}
	//alert(amountsum);
	//alert(document.getElementById("<%=totalamountsum%>span"));
	if(document.getElementById("<%=totalamountsum%>").type=="hidden"){
		document.getElementById("<%=totalamountsum%>span").innerHTML=amountsum.toFixed(3);
		document.getElementById("<%=totalamountsum%>").value=amountsum.toFixed(3);
	}else{
		document.getElementById("<%=totalamountsum%>").value=amountsum.toFixed(3);
		if(document.getElementById("<%=totalamountsum%>span")){
			document.getElementById("<%=totalamountsum%>span").innerHTML="";
		}
	}
	}
}

var xmlHttp;
function showprice(noderowindex){
	var id = document.getElementById(noderowindex+"_capitalid").value;
	//alert(id);
	noderowindextmp = noderowindex;
	
	if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }
    xmlHttp.onreadystatechange = showstartprice;
	xmlHttp.open("get","/cpt/capital/CapitalStartPriceAjax.jsp?id="+id,true); 
	xmlHttp.send(); 
	
}
function showstartprice(){
	if(xmlHttp.readystate==4){ 
		if(xmlHttp.status==200){
			var returnTemp = xmlHttp.responseText;
			var amountsum = document.getElementById(noderowindextmp+"_number").value*returnTemp;
			if(document.getElementById(noderowindextmp+"_unitprice").type=="hidden"){
				document.getElementById(noderowindextmp+"_unitprice").value = returnTemp;
				document.getElementById(noderowindextmp+"_unitpricespan").innerHTML = returnTemp;
			}else{
				document.getElementById(noderowindextmp+"_unitprice").value = returnTemp;
				if(document.getElementById(noderowindextmp+"_unitpricespan")){
					document.getElementById(noderowindextmp+"_unitpricespan").innerHTML = "";
				}
			}
			if(document.getElementById(noderowindextmp+"_amount").type=="hidden"){
				document.getElementById(noderowindextmp+"_amount").value = toFloat(amountsum,0).toFixed(3);
				document.getElementById(noderowindextmp+"_amountspan").innerHTML = toFloat(amountsum,0).toFixed(3);
			}else{
				document.getElementById(noderowindextmp+"_amount").value = toFloat(amountsum,0).toFixed(3);
				if(document.getElementById(noderowindextmp+"_amountspan")){
					document.getElementById(noderowindextmp+"_amountspan").innerHTML = "";
				}
			}
			amountsumcount();
		}
	}
}

function changeamountsum(noderowindex){
	//alert(noderowindex);
	var pricetmp = document.getElementById(noderowindex+"_unitprice").value;
	var numbertmp = document.getElementById(noderowindex+"_number").value;
	var amountsumtmp = pricetmp*numbertmp;
	if(document.getElementById(noderowindex+"_amount").type=="hidden"){
		document.getElementById(noderowindex+"_amount").value = toFloat(amountsumtmp,0).toFixed(3);
		document.getElementById(noderowindex+"_amountspan").innerHTML = toFloat(amountsumtmp,0).toFixed(3);
	}else{
		document.getElementById(noderowindex+"_amount").value = toFloat(amountsumtmp,0).toFixed(3);
		if(document.getElementById(noderowindex+"_amountspan")){
			document.getElementById(noderowindex+"_amountspan").innerHTML = "";
		}
	}
	amountsumcount();
}

</script>
<script language=vbs>
sub onShowAsset(spanname,inputname)
	ismust1 = <%=mandtypes.indexOf("1_1")!=-1%>
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/maintenance/CptAssortmentBrowser.jsp")
	if NOT isempty(id) then
	    if id(0)<> "" and id(0)<> "0" then
		spanname.innerHtml = id(1)
		inputname.value=id(0)
		else
			if ismust1 = false then
				spanname.innerHtml =  ""
			else
				spanname.innerHtml =  "<img src='/images/BacoError.gif' align=absmiddle>"
			end if
		inputname.value=""
		end if
	end if
end sub

sub onShowCptCapital(spanname,inputname,inputnamecount,inputnamenumber,inputnamenumberspan,noderowindex)
		ismust2 = <%=mandtypes.indexOf("2_1")!=-1%>
		id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp?sqlwhere=where isdata='2'&cptstateid=1&cptuse=1")
	if NOT isempty(id) then
	    if id(0)<> "" and id(0)<> "0" then
		spanname.innerHtml = "<a href='/cpt/capital/CptCapital.jsp?id="&id(0)&"'>"&id(1)&"</a>"
		inputname.value=id(0)
        inputnamecount.value=id(7)
        inputnamenumber.value=id(7)
        inputnamenumberspan.innerHtml =  ""
		showprice(noderowindex)
		else
			if ismust2 = false then
				spanname.innerHtml =  ""
			else
				spanname.innerHtml =  "<img src='/images/BacoError.gif' align=absmiddle>" 
			end if
		inputname.value=""
		end if
	end if
end sub
</script>