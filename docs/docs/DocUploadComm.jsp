<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="weaver.hrm.*"%>
<%@ page import="weaver.systeminfo.*"%>
<%@ page
	import="weaver.general.StaticObj,weaver.general.Util"%>
<%@ page import="weaver.general.DesUtil"%>	
<%@ page import="weaver.hrm.settings.RemindSettings"%>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
%>

<%
	User user = HrmUserVarify.getUser(request,response);
	DesUtil desUtil = new DesUtil();
	String mode=Util.null2String(request.getParameter("mode"));
	String docid=Util.null2String(request.getParameter("docid"));
	String maxUploadImageSize=Util.null2String(request.getParameter("maxUploadImageSize"));
	boolean isEditionOpen = "1".equals(Util.null2String(request.getParameter("isEditionOpen")));
%>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<link href="/js/swfupload/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="/js/swfupload/handlers.js"></script>
<%if(7==7) {%>
	<script type='text/javascript' src='/js/weaver-lang-cn-gbk.js'></script>
<%} else if(7==8) {%>
	<script type='text/javascript' src='/js/weaver-lang-en-gbk.js'></script>
<%} else if(7==9) {%>
	<script type='text/javascript' src='/js/weaver-lang-tw-gbk.js'></script>
<%}%>

<div id="divImgsAddContent" style="overflow: auto">
	<div><span> <span id="spanButtonPlaceHolder"></span><!--选取多个文件-->
	</span> &nbsp;&nbsp; <span
		style="color: #262626; cursor: hand; TEXT-DECORATION: none" disabled
		id="btnCancel_upload" onClick="oUploader.cancelQueue()"> <span><img
		src="/js/swfupload/delete.gif" border="0"></span> <span
		style="height: 19px"><font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407, 7)%></font><!--清除所有选择--></span>
	</span></div>
	
	<div class="fieldset flash" id="fsUploadProgress"></div>
	<div id="divStatus"></div>
</div>
<script language="javascript">
var oUploader;

var upload_url;
var mode="<%=mode%>";
var docid="<%=docid%>";
var maxUploadImageSize="<%=maxUploadImageSize%>";
var isEditionOpen = <%=isEditionOpen%>;
if(mode=="add"||isEditionOpen){
	upload_url= "/docs/docs/DocImgUploadOnly.jsp";	
} else if(mode=="view"||mode=="edit"){
	upload_url="/docs/docs/DocImgUpload.jsp";
}	

var settings = {	
	flash_url : "/js/swfupload/swfupload.swf",
    post_params: {
        "docid": docid,
        "userid":'<%=desUtil.encrypt(user.getUID()+"")%>',
        "usertype":'<%=user.getLogintype()%>'
    },        
	upload_url: upload_url,
	file_size_limit : maxUploadImageSize+" MB",
	file_types : "*.*",
	file_types_description : "All Files",
	file_upload_limit : "50",
	file_queue_limit : "0",
	custom_settings : {
		progressTarget : "fsUploadProgress",
		cancelButtonId : "btnCancel_upload"
	},
	debug: false,
	
	button_image_url : "/js/swfupload/add.png",	// Relative to the SWF file
	button_placeholder_id : "spanButtonPlaceHolder",

	button_width: 140,
	button_height: 18,
	button_text : '<span class="button">'+wmsg.acc.selectUpload+'</span>',
	button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
	button_text_top_padding: 0,
	button_text_left_padding: 18,
		
	button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
	button_cursor: SWFUpload.CURSOR.HAND,
	
	file_queued_handler : fileQueued,
	file_queue_error_handler : fileQueueError,
	file_dialog_complete_handler : function(){			
		document.getElementById("btnCancel_upload").disabled = false;
		fileDialogComplete				
	},
	upload_start_handler : uploadStart,
	upload_progress_handler : uploadProgress,
	upload_error_handler : uploadError,
	queue_complete_handler : queueComplete,

	upload_success_handler : function (file, server_data) {		
		if(mode=="add"||isEditionOpen){
			//alert(server_data)
			var imageid=server_data.replace(/(^\s*)|(\s*$)/g, "");	
			var sPara={imgid:imageid,icon:'',name:file.name,size:Math.round(file.size/1024)+'K'};						
			parent.addStoreDocImgsData(sPara);		
		}

	},				
	upload_complete_handler : function(){			
		try {
			if (this.getStats().files_queued === 0) {									
				if(mode!="add"&&!isEditionOpen){
					parent.storeDocImgs.load();
				}	
				parent.winImg.hide();	
			} else {	
				this.startUpload();
			}
		} catch (ex) { alert(ex); }
	}
};	

try{
	oUploader = new SWFUpload(settings);
} catch(e){alert(e)}






	function flashChecker() {
		var hasFlash = 0; //是否安装了flash
		var flashVersion = 0; //flash版本
		var isIE = /*@cc_on!@*/0; //是否IE浏览器

		if (isIE) {
			var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
			if (swf) {
				hasFlash = 1;
				VSwf = swf.GetVariable("$version");
				flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
			}
		} else {
			if (navigator.plugins && navigator.plugins.length > 0) {
				var swf = navigator.plugins["Shockwave Flash"];
				if (swf) {
					hasFlash = 1;
					var words = swf.description.split(" ");
					for ( var i = 0; i < words.length; ++i) {
						if (isNaN(parseInt(words[i])))
							continue;
						flashVersion = parseInt(words[i]);
					}
				}
			}
		}
		return {
			f :hasFlash,
			v :flashVersion
		};
	}
	var fls = flashChecker();
	var flashversion = 0;
	if (fls.f)
		flashversion = fls.v;
	if (flashversion < 9)
		document.getElementById("fsUploadProgress").innerHTML = "<br>&nbsp;&nbsp;附件上传的功能需要你的机器支持Flash9及其以上的版本，请从下面选择安装方式:<br><br><a target='_blank' href='http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=shockwaveFlash'>&nbsp;&nbsp;在线安装<a>	<br><br><a href='/resource/install_flash9_player.exe' target='_blank'>&nbsp;&nbsp;下载安装包</a>";
</script>