<SCRIPT src="/js/homepage/Article.js"></SCRIPT>
<script type="text/javascript" src="/js/jquery/jquery.scrollTo.js"></script>

<style type="text/css" rel="STYLESHEET">
.spCss{
	height: 100%;
	padding-top: 5px;
	background:url(/js/jquery/plugins/weavertabs2/lmz.gif) no-repeat;
	border: 1px;
	text-align: center;
	background-position: center;
	font-style:normal;
	font-size:12px;
	font-family:����;
	font-weight:normal;
	text-align:center;
	
	width:77px;
	cursor:pointer;
	vertical-align:middle;
	
	
}
.picturebackhp 
{
    width: 18px;
    height: 32px;
    float:left;
    background: transparent url(/page/element/Picture/resource/image/scroll_left.gif) no-repeat 0 0;
}
.picturenexthp 
{
    width: 18px;
    height: 32px;
    float:left;
    background: transparent url(/page/element/Picture/resource/image/scroll_right.gif) no-repeat 0 0;
}
</style>

<script type="text/javascript">
<!--
	
var setinnerHTML = function (el, htmlCode) {
    var ua = navigator.userAgent.toLowerCase();
    if (ua.indexOf('msie') >= 0 && ua.indexOf('opera') < 0) {
        htmlCode = '<div style="display:none">for IE</div>' + htmlCode;
        htmlCode = htmlCode.replace(/<script([^>]*)>/gi,
                                    '<script$1 defer=true>');
        el.innerHTML = htmlCode;
        el.removeChild(el.firstChild);
        //alert(el.innerHTML);
    } else {
        var el_next = el.nextSibling;
        var el_parent = el.parentNode;
        el_parent.removeChild(el);
        el.innerHTML = htmlCode;
        if (el_next) {
            el_parent.insertBefore(el, el_next)
        } else {
            el_parent.appendChild(el);
        }
    }
}
//-->
</script>

<script language="javascript"><!--
var isSetting=false;
var tempEid=0; //��ʱԪ��ID
var objAreaFlags = new Array();
var mode="run"; //ȷ��ҳ��ģʽ  debug run
var initEnd=20; //���Ż����������ݣ����ҳ����Ҫ��ǰһ��ʱ����и߶�����Ӧ

var needInitItemsNum=0;

function setElementLogo(eid,eLogo){
	$("#icon_"+eid).children('img').attr("src",eLogo);
}	

function setElementHeight(eid,height){
	
	if(height==0){
		$("#content_view_id_"+eid).css("height","auto");
	} else {
		$("#content_view_id_"+eid).css("height",height);
	}	
}


function setElementMarginTop(eid,marginTop){
	$("#item_"+eid).css("margin-top",marginTop);
}

function setElementMarginBottom(eid,marginBottom){
	$("#item_"+eid).css("margin-bottom",marginBottom);
}

function setElementMarginLeft(eid,marginLeft){
	$("#item_"+eid).css("margin-left",marginLeft);
}

function setElementMarginRight(eid,marginRight){
	$("#item_"+eid).css("margin-right",marginRight);
}



function onRefresh(eid,ebaseid){
	$("#item_"+eid).attr('needRefresh','true')
	$("#item_"+eid).trigger("reload");  
}
var myRefreshEid;
var myRefreshEbaseId;
function setWorkFlowRefresh(eid,ebaseid){
	myRefreshEid = eid;
	myRefreshEbaseId = ebaseid;
}
var initRefresh=0;

function doResize(){
	if(initRefresh<initEnd){		
		try{				
			var oFrm=parent.document.getElementById("mainFrame");			
			//if(eid=="8166"||eid=="8153") {
				//log(oFrm.style.height+":"+document.body.scrollHeight)
				//alert(oFrm.style.height+":"+document.body.scrollHeight)
			///}
			if(oFrm.style.height==''){
				oFrm.style.height='0';
			}
			if(parseInt(oFrm.style.height)<parseInt(document.body.scrollHeight)) {
				oFrm.style.height=document.body.scrollHeight+"px";
			} else{
				oFrm.style.height=document.body.scrollHeight+"px";
			}
			//$("#content_view_id_"+eid).append(oFrm.style.height+":"+document.body.scrollHeight);			
		} catch(e){
			log(e) 
		}
		setTimeout(function(){doResize();},1000); 
		initRefresh++;
		log("initRefresh:"+initRefresh);
	} 	
}
var count=0;
var timeval=3000;

       
function replaceHtml(el, html) {   
    var oldEl = typeof el === "string" ? document.getElementById(el) : el;   
    /*@cc_on // Pure innerHTML is slightly faster in IE  
        oldEl.innerHTML = html;  
        return oldEl;  
    @*/  
    var newEl = oldEl.cloneNode(false);   
    newEl.innerHTML = html;   
    oldEl.parentNode.replaceChild(newEl, oldEl);   
    /* Since we just removed the old element from the DOM, return a reference  
    to the new element, which can be used to restore variable references. */  
    return newEl;   
}
var intNum=0;
$(document).ready(function () {
	if(window.onbeforeunload){
		$(window).bind("beforeunload",function(){window.onbeforeunload=function(){try{window.parent.document.getElementById("mainFrame").style.height=document.body.scrollHeight+"px";}catch(e){}}});
	}else{
		window.onbeforeunload=function(){try{window.parent.document.getElementById("mainFrame").style.height=document.body.scrollHeight+"px";}catch(e){}}
	}
	if(mode=="debug") $('#txtDebug').css("display","");

	$(".item").bind("reload",function(){
		elementReload($(this).attr("ebaseid"),$(this).attr("eid"),$(this).attr("cornerTop"),$(this).attr("cornerBottom"),$(this).attr("cornerTopRadian"),$(this).attr("cornerBottomRadian"))
	});
	
	/*
	$.each($(".item"),function(i,n){
		if(intNum<2){			
			$this=$(this);
			window.setTimeout(function(){
				$this.trigger("reload");
			},0)
			intNum++;
		}
	})
	*/
	
	//$(".item").trigger("reload");

	var win_height = getClientHeight();
	var scroll_top = getScrollTop();
	var itemArray = $(".item");
	var itemArray_length=itemArray.length;
	var lastTop = 0;
	for(var i=0;i<itemArray_length;i++){
		var _item = itemArray[i];
		var jq_item = $("#"+_item.id);
		//if($("#"+_item.id).attr("needRefresh")=="false")continue;
		var el_top1 = getAbsoluteTop(_item);
		document.getElementById("content_view_id_"+$(_item).attr("eid")).innerHTML = "<img class='imgWait' src=/images/loading2.gif> "+wmsg.hp.excuting+"..."+"<br /><br /><br /><br /><br /><br /><br />";
		var el_top = getAbsoluteTop(_item);
		
		//document.getElementById("title_"+_item.eid).innerHTML = ("lastTop="+lastTop+";el_top="+el_top+";win_height+scroll_top="+(win_height+scroll_top));
		
		if(el_top+0 < win_height+scroll_top || lastTop > el_top){
			jq_item.attr("isBeforeInit","true");
			jq_item.trigger("reload");
		}else{
			jq_item.attr("isBeforeInit","false");
		}
		lastTop=el_top;
	}
	elementLoad_queue();
	
	// ��Զ��֤ˢ��ҳ��߶�
	
	if(<%=isfromportal==1%>||true) {
		
		doResize(); //���Ż�����������Ҫˢ��ҳ��߶�
	}
	
});

function getScrollTop(){
    var scrollTop=0;
    if(document.documentElement&&document.documentElement.scrollTop){
        scrollTop=document.documentElement.scrollTop;
    }
    else if(document.body){
        scrollTop=document.body.scrollTop;
    }
    return scrollTop;
}

function getClientHeight(){
	var yScroll;
    if (window.innerHeight && window.scrollMaxY) {
        yScroll = window.innerHeight + window.scrollMaxY;
    }
    else if (document.body.scrollHeight > document.body.offsetHeight) {
        yScroll = document.body.scrollHeight; // all but Explorer Mac 
    }
    else {
        yScroll = document.body.offsetHeight;  // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari   
    }
    var windowHeight;
    if (self.innerHeight) {
        windowHeight = self.innerHeight; // all except Explorer       
    }
    else if (document.documentElement && document.documentElement.clientHeight) {
        windowHeight = document.documentElement.clientHeight; // Explorer 6 Strict Mode         
    }
    else if (document.body) {
        windowHeight = document.body.clientHeight; // other Explorers           
    }
    if (yScroll < windowHeight) {
        pageHeight = windowHeight; // for small pages with total height less then height of the viewport       
    }
    else {
        pageHeight = yScroll;
    }
    return pageHeight;

}
function getAbsoluteTop(element) { 
	if (arguments.length != 1 || element == null) { 
		return null; 
	} 
	var offsetTop = element.offsetTop; 
	while (element = element.offsetParent) { 
		offsetTop += element.offsetTop; 
	} 
	return offsetTop; 
}

var _elementLoad_queue_flag = true;
var ctMax=0;
function elementLoad_queue(){
	if(_elementLoad_queue_flag){
		try{
			_elementLoad_queue_flag=false;
			var itemArray = $(".item[isInited!='true']");
			var flag = false;
			var itemArray_length=itemArray.length;
			for(var i=0;i<itemArray_length;i++){
				var _item = itemArray[i];
				var el_top = getAbsoluteTop(document.getElementById(_item.id));
				var win_height = $(window).height();
				var scroll_top = getScrollTop();
				ctMax++;
				if(el_top < win_height+scroll_top){
					flag = true;
					$("#"+_item.id).trigger("reload");
					break;
				}
			}
			if(!flag && itemArray_length > 0){
				setTimeout(elementLoad_queue, 200);
			}
		}catch(e){
		}
		_elementLoad_queue_flag=true;
	}
}



function elementReload(ebaseid,eid,top,bottom,topRadian,bottomRadian){	
	var _itemObj = $("#item_"+eid);
	//if($("#item_"+eid).attr("needRefresh")=="false")return;
	_itemObj.attr("isInited","true");
	_itemObj.attr("elementLoad_queue_timeout_flag","false");

	/*
	if($("#item_"+eid).attr('needRefresh')=='false'){
		//alert($("#item_"+eid).attr('needRefresh'))
		_itemObj.attr("isInited","true");
		setTimeout(elementLoad_queue, 200);
		return;
	}
	*/
	
	//��ֹ�ظ�����Բ����ʽ
	$("#header_"+eid).uncorner();
	if(top=="Round") {
		$("#header_"+eid).corner("Round top "+topRadian); 
	}
	$("#content_"+eid).uncorner();
	if(bottom=="Round") {
		$("#content_"+eid).corner("Round bottom "+bottomRadian); 
	}	
	
	var $this = $("#content_view_id_"+eid);
	$this.html("<img class='imgWait' src=/images/loading2.gif> "+wmsg.hp.excuting+"..."+"<br /><br /><br /><br /><br /><br /><br />");
	var url=$.trim($this.attr("url")).replace(/&amp;/g,"&");
	//
	
	if (url.indexOf("?") != -1) {
		url += "&";
	} else {
		url += "?";
	}
	
	url += "e7" + new Date().getTime() + "=";
	if(ebaseid=='picture'||ebaseid=='1'||ebaseid=='menu'||ebaseid=='weather'||ebaseid=='7'||ebaseid=='8'||ebaseid=='19'){
		if(_itemObj.attr("isBeforeInit")!="true"){
	
			//document.getElementById("title_"+eid).innerHTML += "id="+_itemObj.attr("id");
	
	  	   var _timeOut = 1000;
	  	   if(ebaseid=="weather" || ebaseid=="29"){_timeOut=0;}
	  	   window.setTimeout(function(){
	   	   if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
	   	        _itemObj.attr("elementLoad_queue_timeout_flag","true");
				_itemObj.attr("isInited","true");
				setTimeout(elementLoad_queue, 200);
				//if(ebaseid=="weather" || ebaseid=="29"){window.top.document.title = ebaseid;}
	   	   }	
	  	   },_timeOut);
  	   }else{
  	   		//alert(1);
  	   }
  	   
		//$this.html("<img class='imgWait' src=/images/loading2.gif> "+wmsg.hp.excuting+"...")
		$this.load(url,function(){
			if(_itemObj.attr("isBeforeInit")!="true"){
				window.setTimeout(function(){
					if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
						_itemObj.attr("elementLoad_queue_timeout_flag","true");
						_itemObj.attr("isInited","true");
						if(_itemObj.attr("isBeforeInit")!="true"){
							setTimeout(elementLoad_queue, 200);
						}
					}
					//var _ifrm = document.getElementById("ifrm_"+eid);
					//if(_ifrm){onLoadComplete(_ifrm);}
				},0);
	  	   }else{
	  	   		//alert(1);
	  	   }
		});
		return;
	}
	
	if(true){
		log(url);
		
		if(_itemObj.attr("isBeforeInit")!="true"){
		
			//document.getElementById("title_"+eid).innerHTML += "id="+_itemObj.attr("id");
		
	  	   var _timeOut = 1000;
	  	   if(ebaseid=="weather" || ebaseid=="29"){_timeOut=0;}
	  	   window.setTimeout(function(){
	   	   if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
	   	        _itemObj.attr("elementLoad_queue_timeout_flag","true");
				_itemObj.attr("isInited","true");
				setTimeout(elementLoad_queue, 200);
				//if(ebaseid=="weather" || ebaseid=="29"){window.top.document.title = ebaseid;}
	   	   }	
	  	   },_timeOut);
  	   }else{
  	   		//alert(1);
  	   }

/*
		$.get(url, function(data){
			if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
				_itemObj.attr("elementLoad_queue_timeout_flag","true");
				_itemObj.attr("isInited","true");
				if(_itemObj.attr("isBeforeInit")!="true"){
					setTimeout(elementLoad_queue, 200);
				}
			}
			//document.getElementById("content_view_id_"+eid).innerHTML=data;
			//setinnerHTML(document.getElementById("content_view_id_"+eid),data);
			$("#content_view_id_"+eid).html(data);
			
			var _ifrm = document.getElementById("ifrm_"+eid);
			if(_ifrm){onLoadComplete(_ifrm);}
		});
*/

		$.ajax({
		   type: "POST",
		   cache: false,
		   url: url,
		   success: function(data){
				if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
					_itemObj.attr("elementLoad_queue_timeout_flag","true");
					_itemObj.attr("isInited","true");
					if(_itemObj.attr("isBeforeInit")!="true"){
						setTimeout(elementLoad_queue, 200);
					}
				}
				
				//document.getElementById("content_view_id_"+eid).innerHTML=data;
				//setinnerHTML(document.getElementById("content_view_id_"+eid),data);
				//$("#content_view_id_"+eid).html(data);
				$("#content_view_id_"+eid).html( data);
			/*	var regDetectJs = /<script(.|\n)*?>(.|\n|\r\n)*?<\/script>/ig;  
				var jsContained = data.match(regDetectJs);  
				  
				if(jsContained) {  
				    var regGetJS = /<script(.|\n)*?>((.|\n|\r\n)*)?<\/script>/im;  
				  
				    var jsNums = jsContained.length;  
				    for (var i=0; i<jsNums; i++) {  
				        var jsSection = jsContained[i].match(regGetJS);  
				  
				        if(jsSection[2]) {  
				            if(window.execScript) {  
				                window.execScript(jsSection[2]);  
				            } else {  
				                window.eval(jsSection[2]);  
				            }  
				        }  
				    }  
				}
				*/
				var _ifrm = document.getElementById("ifrm_"+eid);
				if(_ifrm){onLoadComplete(_ifrm);}
		   }
		}); 

		return;
	}
	
	if(url.substring(0,1)!="?")  {
		//$this.html("<img class='imgWait' src=/images/loading2.gif> "+wmsg.hp.excuting+"...")
		log(url)

		if(_itemObj.attr("isBeforeInit")!="true"){
			//alert(_itemObj.attr("id"));
			
	  	   var _timeOut = 1000;
	  	   if(ebaseid=="weather" || ebaseid=="29"){_timeOut=0;}
	  	   window.setTimeout(function(){
	   	   if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
	   	        _itemObj.attr("elementLoad_queue_timeout_flag","true");
				_itemObj.attr("isInited","true");
				setTimeout(elementLoad_queue, 200);
				//if(ebaseid=="weather" || ebaseid=="29"){window.top.document.title = ebaseid;}
	   	   }	
	  	   },_timeOut);
  	   }else{
  	   		//alert(1);
  	   }
			
		var xmlHttp = XmlHttp.create();	
		xmlHttp.open("POST", url, true);
			
		xmlHttp.onreadystatechange = function () {	
			switch (xmlHttp.readyState) {
			   case 0 :  //uninitialized
					break ;
			   case 1 :   //loading							
					break ;
			   case 2 :   //loaded
				   break ;
			   case 3 :   //interactive				  
				   break ;
			   case 4 :  //complete
				   if (xmlHttp.status==200)  {
				  		 //replaceHtml("content_view_id_"+eid,"aaa")
				   	   //document.getElementById("content_view_id_"+eid).innerText='aaa'
					   //count++;
			
					   var str=$.trim(xmlHttp.responseText);
					   //var re = /<script.*?>.*?<\/script>/gi;	
						////var tmpStr=str;
						//var tmpStr=tmpStr.replace(re,"")
						
						window.setTimeout(function(){
							if(_itemObj.attr("elementLoad_queue_timeout_flag")=="false"){
								_itemObj.attr("elementLoad_queue_timeout_flag","true");
								_itemObj.attr("isInited","true");
								if(_itemObj.attr("isBeforeInit")!="true"){
									setTimeout(elementLoad_queue, 200);
								}
							}
							//document.getElementById("content_view_id_"+eid).innerHTML=str;
							setinnerHTML(document.getElementById("content_view_id_"+eid),str);
							var _ifrm = document.getElementById("ifrm_"+eid);
							if(_ifrm){onLoadComplete(_ifrm);}
						},0);
						
						/*var re2 = /(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)/gi;
						//var arr;
						//var isExec=false;
						
						//while ((arr = re2.exec(str)) != null)	{						
						//	window.setTimeout($this.append(arr[0]),count*timeval+500);
						//	isExec=true;
						}*/
				   } else {				
					   //alert(xmlHttp.responseText);
				   }
			  	   break ;			 
			} 
		}		
		xmlHttp.setRequestHeader("Content-Type","text/xml");	
		xmlHttp.send(null);	

	} 
	
}


function log(s){		 
	if(mode=="debug") {
		$('#txtDebug').val($('#txtDebug').val()+s+"\n");
		var oTxtDebug=$('#txtDebug').get(0);
		oTxtDebug.scrollTop+=oTxtDebug.offsetHeight;
	}
	
}

function  GetContent(divObj,url,isAddElement,code,isNeedRefresh){
	
	divObj.innerHTML="<img src=/images/loading2.gif> "+wmsg.hp.excuting+"...";
	//return;
	var xmlHttp = XmlHttp.create();
	xmlHttp.open("GET",url, true);
	xmlHttp.onreadystatechange = function () {
		switch (xmlHttp.readyState) {
           case 3 :
			    divObj.innerHTML="<img src=/images/loading2.gif> "+wmsg.hp.transporting+"...";
		        break;
		   case 4 :
		       if(isAddElement){
			       	$(".group[areaflag='A']").prepend(xmlHttp.responseText);
			       	try{
			       		$(".group[areaflag='A']").children("div:first").bind("reload",function(){
			       			elementReload($(this).attr("ebaseid"),$(this).attr("eid"),$(this).attr("cornerTop"),$(this).attr("cornerBottom"));
			       		});
			       		
			       		$(".group[areaflag='A']").children("div:first").trigger("reload");	
			       		
					    //var eid=$(".group[areaflag='A']").children("div:first").attr("eid");					    
				       	//var jsCode = $("#content_js_"+eid).html();
						//eval(jsCode)			       
			       	}catch(e){
			       		//alert(e.name)
			       	} 
			   } else {
				   divObj.innerHTML =xmlHttp.responseText;
			   }
			   if(isNeedRefresh!=undefined){
				   window.location.reload();
			   }
		       if(xmlHttp.status < 400)   if(code!=null&&code!="") eval(code);
               break;
		}
	}
	xmlHttp.setRequestHeader("Content-Type","text/xml")
	xmlHttp.send(null);
}

	
	function onShowOrHideE(eid){	
		$("#content_"+eid).toggle();
	}
	
	function onChanageAllStatus(obj,stropen,strclose){			
		var showSpan;
		//var objChilds = obj.childNodes;
		var objChilds = $(obj).find("span");
		for(var cx=0; cx<objChilds.length; cx++){
			if(objChilds[cx].tagName == "SPAN"){
				showSpan = objChilds[cx];
			}
		}
		var status=jQuery(showSpan).attr("status");		
		if(status=="show")	{
			$(".content").hide() ;
			jQuery(showSpan).attr("status","hidden");
			try{showSpan.innerHTML=wmsg.wf.outspread;}catch(e){}			
		} else {
			$(".content").show() ;			
			jQuery(showSpan).attr("status","show");
			try{showSpan.innerHTML=wmsg.wf.shrink;}catch(e){}
		}	
	}
	function chkReplyClick(obj,eid,name){
		onNewContentCheck(document.getElementById(name+"_"+eid),eid,name)
	}


	function onNewContentCheck(obj,eid,name){	
		obj.checked=true;			
		var isHaveReply="0";
		try{
			if(document.getElementById("chk"+name+"_"+eid).checked) isHaveReply="1";
		} catch(e){
		}
		
		document.getElementById("_whereKey_"+eid).value=$(obj).attr("selecttype")+"|"+obj.value+"|"+isHaveReply;		
		
	}

	function onShowCatalog(input,span,eid) {
		var result = showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CategoryBrowser.jsp");
		if (result != null) {
		    if (result[0] > 0)  {
				input.value=result[1]
				span.innerHTML=result[5];
			}else{
				input.value="0";
				span.innerHTML="";
			}
		}
		onNewContentCheck(input,eid,'cate')
	}

	function onWFEClick(obj){
		if(!obj.checked){ //���ȡ��ѡ��,��������е�ѡ��ȡ��
			//�õ��������еĽڵ�checkbox ��Ϊ��ѡ
			var objNextTd=obj.parentNode.nextSibling;
			var objNodes=objNextTd.getElementsByTagName("input");
			for(var i=0;i<objNodes.length;i++){
				var objNode=objNodes[i];
				objNode.checked=false;
				//alert(objNode.value);
			}
		}
	}	
	function onWFENodeClick(obj){
		if(obj.checked){ //���ѡ��,���̾�ѡ��
			var objPreTd=obj.parentNode.previousSibling;
			var objNodes=objPreTd.getElementsByTagName("input");
			for(var i=0;i<objNodes.length;i++){
				var objNode=objNodes[i];
				objNode.checked=true;
				//alert(objNode.value);
			}
		}
	}
	
	function onViewTypeChange(obj,eid){		
		document.getElementById("ifrmViewType_"+eid).src="/homepage/element/setting/WorkflowCenterBrowser.jsp?viewType="+obj.value+"&eid="+eid;
		//alert(obj.value)
	}

	function elmentReLoad(ebaseid){

		/*var tables=document.getElementsByTagName("div");		
		for(var i=0;i<tables.length;i++){
			var tbl=tables[i];
			if(tbl.ebaseid==ebaseid) {
				var tblEid=tbl.eid;
				try{
					eval("objE"+tblEid).contentLoad();
				} catch(e){}
			}
		}*/
		
		$(".item[ebaseid="+ebaseid+"]").attr('needRefresh','true')
		$(".item[ebaseid="+ebaseid+"]").trigger("reload");
	}
	
	function onWorktaskSetting(obj){
		var objParent=obj.parentNode;
		var children=objParent.getElementsByTagName("INPUT");
		var value="";
		for(var i=0;i<children.length;i++){
			var child=children[i];			
			if(child.type=="checkbox" && child.checked){
				value+=child.value+"|";
			}						
		}
		if(value!="") value=value.substring(0,value.length-1);
		objParent.firstChild.value=value;			
	}

function loadContent(eid,url,queryString,e){
	var event = $.event.fix(e);
	var tabId = jQuery(event.target).attr("tabId");

	var ebaseid = $("#item_"+eid).attr("ebaseid");
	url = url + "?tabId="+tabId+"&"+queryString;
	if (url.indexOf("?") != -1) {
		url += "&";
	} else {
		url += "?";
	}
	
	url += "e7" + new Date().getTime() + "=";
	var objTd=event.target;
	
	$(objTd).siblings().removeClass("tab2selected").removeClass("tab2unselected").addClass("tab2unselected");
	$(objTd).removeClass("tab2unselected").addClass("tab2selected");
	
	$("#tabContant_"+eid).html("<img src=/images/loading2.gif>"+wmsg.hp.excuting+"...")
	try{
			if(ebaseid==1||ebaseid==29){
				$.get(url, { name: "John", time: "2pm" },function(data){
				
				$("#tabContant_"+eid).html($.trim(data));
					fixedPosition(eid);
					$("#more_"+eid).attr("href","javascript:openFullWindowForXtable('"+$("#more_"+eid).attr("morehref")+"&tabid="+tabId+"')")
			  } ); 
			}else{
				$("#tabContant_"+eid).load(url,{},function(){
					fixedPosition(eid);
					$("#more_"+eid).attr("href","javascript:openFullWindowForXtable('"+$("#more_"+eid).attr("morehref")+"&tabid="+tabId+"')")
				});
			}
		} catch(e){}
}

function showDBSetting(eid){
	if(parseInt(event.srcElement.value)==1){
		$("#dbSetting_"+eid).css("display","")
	}else{
		$("#dbSetting_"+eid).css("display","none")
	}
}
function openFullWindowForXtable(url){
	if (url.indexOf("?") != -1) {
		url += "&";
	} else {
		url += "?";
	}
	
	url += "e7" + new Date().getTime() + "=";
	var redirectUrl = url ;
	var width = screen.width ;
	var height = screen.height ;
	var szFeatures = "top=100," ; 
	szFeatures +="left=400," ;
	szFeatures +="width="+width/2+"," ;
	szFeatures +="height="+height/2+"," ; 
	szFeatures +="directories=no," ;
	szFeatures +="status=yes," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ;
	window.open(redirectUrl,"",szFeatures) ;
}

function openFullWindowHaveBarForWFList(url,requestid){
	try{
		document.getElementById("wflist_"+requestid+"span").innerHTML = "";
	}catch(e){}
	if (url.indexOf("?") != -1) {
		url += "&";
	} else {
		url += "?";
	}
	
	url += "e7" + new Date().getTime() + "=";
	var redirectUrl = url ;
	var width = screen.availWidth-10 ;
	var height = screen.availHeight-50 ;
	//if (height == 768 ) height -= 75 ;
	//if (height == 600 ) height -= 60 ;
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
	
	
function openFullWindowHaveBar(url){
	if (url.indexOf("?") != -1) {
		url += "&";
	} else {
		url += "?";
	}
	
	url += "e7" + new Date().getTime() + "=";
	var redirectUrl = url ;
	var width = screen.availWidth-10 ;
	var height = screen.availHeight-50 ;
	//if (height == 768 ) height -= 75 ;
	//if (height == 600 ) height -= 60 ;
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

function  readCookie(name){  
   var  cookieValue  =  "7";  
   var  search  =  name  +  "=";
   try{
	   if(document.cookie.length  >  0) {    
	       offset  =  document.cookie.indexOf(search);  
	       if  (offset  !=  -1)  
	       {    
	           offset  +=  search.length;  
	           end  =  document.cookie.indexOf(";",  offset);  
	           if  (end  ==  -1)  end  =  document.cookie.length;  
	           cookieValue  =  unescape(document.cookie.substring(offset,  end))  
	       }  
	   }  
   }catch(exception){
   }
   return  cookieValue;  
} 


function loadRssElementContent(eid,rssUrl,imgSymbol,hasTitle,hasDate,hasTime,titleWidth,dateWidth,timeWidth,rssTitleLength,linkmode,size,perpage,languageid){
 	var returnStr="";
 		
	var objDiv = document.getElementById("rssContent_"+eid);
	try{
		var rssRequest = XmlHttp.create();
		rssRequest.open("GET",rssUrl, true);	
		rssRequest.onreadystatechange = function () {
			switch (rssRequest.readyState) {
			   case 3 : 					
					break;
			   case 4 : 
				   if (rssRequest.status==200)  {

                     returnStr+="<TABLE id=\"_contenttable_"+eid+"\" style=\"width:100%\" class=\"Econtent\">"+
						  " <TR>"+
						  " <TD width=\"1px\"></TD>"+
						  " <TD width=\"*\" valign=\"center\">"+
						  "	    <TABLE  width=\"100%\">";
				   
						var items=rssRequest.responseXML;
						var titles=new Array(),pubDates=new Array(); dates=new Array(), times=new Array(), linkUrls=new Array(), descriptions=new Array()	
							
						var items_count=items.getElementsByTagName('item').length;

						if(items_count>perpage) items_count=perpage;
				
						for(var i=0; i<items_count; i++) {
							titles[i]="";
							pubDates[i]="";
							linkUrls[i]="";
							descriptions[i]="";
							dates[i]="";
							times[i]="";

							if(items.getElementsByTagName('item')[i].getElementsByTagName('title').length==1)
								titles[i]=items.getElementsByTagName('item')[i].getElementsByTagName('title')[0].firstChild.nodeValue;


							if(items.getElementsByTagName('item')[i].getElementsByTagName('pubDate').length==1)
								pubDates[i]=items.getElementsByTagName('item')[i].getElementsByTagName('pubDate')[0].firstChild.nodeValue;

							if(items.getElementsByTagName('item')[i].getElementsByTagName('link').length==1)
								linkUrls[i]=items.getElementsByTagName('item')[i].getElementsByTagName('link')[0].firstChild.nodeValue;

							
							returnStr+="<TR height=18px>"+
									   "  <TD width=\"8\">"+imgSymbol+"</TD>";

							
							if(hasTitle=="true"){
								 returnStr+="<TD width="+titleWidth+">";
								 var tempTitle = "";
								 if(titles[i].length>rssTitleLength){
								 	tempTitle = titles[i].substring(0,rssTitleLength)+"...";
								 }else{
								 	tempTitle = titles[i];
								 }
								
								 if(linkmode=="1"){
									returnStr+="<a href=\""+linkUrls[i]+"\" target=\"_self\" title=\""+titles[i]+"\"><FONT class=\" font\" >"+tempTitle+"</FONT></a>";
								 } else {
									returnStr+="<a href=\"javascript:openFullWindowForXtable('"+linkUrls[i]+"')\" title=\""+titles[i]+"\"><FONT class=\" font\"  >"+tempTitle+"</FONT></a>";
								 } 
								 returnStr+="</TD>";
							} 
							
							if(pubDates[i]!=""){
								var d = new Date(pubDates[i]);
							
								if(d!='NaN'){
									dates[i]=d.getYear()+"-"+(d.getMonth() + 1) + "-"+d.getDate() ;
	
									if(d.getHours()<=9)	times[i]+="0"+d.getHours() + ":";
									else times[i]+= d.getHours() + ":";
	
									if(d.getMinutes()<=9)	times[i]+="0"+d.getMinutes() + ":";
									else times[i]+= d.getMinutes() + ":";
	
									if(d.getSeconds()<=9)	times[i]+="0"+d.getSeconds();
									else times[i]+= d.getSeconds() ;
								}else{
									dates[i]="";
									times[i]="";
								}
							} else {
								dates[i]="";
								times[i]="";
							}
							if(hasDate=="true"){
								returnStr+="<TD width="+dateWidth+">"+"<font class=font>"+dates[i]+"</font>"+"</TD>";
							}
							if(hasTime=="true"){
								returnStr+="<TD width="+timeWidth+">"+"<font class=font>"+times[i]+"</font>"+"</TD>";
							}
							returnStr+="</TR>";

							if(i<items_count-1){
								returnStr+="<TR class=\"sparator\" style='height:1px'><TD style='padding:0px' colspan="+(size+1)+"></TD></TR>";	
							}
					
						}
					

						returnStr+="		</TABLE>"+
								  "	</TD>"+
								  " <TD width=\"1px\"></TD>"+
								  " </TR>"+
								  "</TABLE>";
						
						objDiv.innerHTML=returnStr;
				   } else {
					   objDiv.innerHTML=rssRequest.responseText;
				   }
				   break;
			} 
		}	
		rssRequest.setRequestHeader("Content-Type","text/xml")	
		rssRequest.send(null);	
	} catch(e){      
        if(e.number==-2147024891){
            if(languageid==8)
                objDiv.innerHTML="RSS use client read��It need let this site's url into you IE trust list.��&nbsp;<a href='/homepage/HowToAdd.jsp' target='_blank'>(How?)</a>";
            else
                objDiv.innerHTML="RSS���õ��ǿͻ��˶�ȡ����ѱ�վ����ӵ�������վ�㣡&nbsp;<a href='/homepage/HowToAdd.jsp' target='_blank'>(�������?)</a>";
        }   else {
            objDiv.innerHTML=e.number+":"+e.description;
        }
    }
	
}

function onChangeImgType(eid,value){
	if(event.srcElement.value==0){
		$("#imgsrcDiv_"+eid).hide()
	}else{
		$("#imgsrcDiv_"+eid).show()
		if(document.getElementById("_imgsrc"+eid).className=='filetree'){
			$("#_imgsrc"+eid).filetree();
		}
	}
}

function onLoadComplete(ifm){
	try{
		if(ifm.readyState=="complete"){   
			if(ifm.contentWindow.document.body.scrollHeight>ifm.height){
				ifm.style.height = ifm.height;
			}else{
				ifm.style.height = ifm.contentWindow.document.body.scrollHeight;
			}
		}
	}catch(e){
		//alert(e.message);
	}
	//$("#item_"+eid).attr("isInited","true");
	//alert(ifm.outerHTML);
	//setTimeout(elementLoad_queue, 200);
	//elementLoad_queue();
}
function onShowMultiCatalog(input,span,eid){	
	splitflag = ",,,"
		var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
		var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��;
		datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/MutilCategoryBrowser.jsp?para="+input.value+"&splitflag="+splitflag,"","dialogTop="+iTop+";dialogLeft="+iLeft+";dialogHeight=550px;dialogWidth=550px;")
		
			if (datas) {
			    if (datas.id!= "") {
			        ids = datas.id.split(",");
				    names =datas.name.split(",");
				    sHtml = "";
				    for( var i=0;i<ids.length;i++){
					    if(ids[i]!=""){
					    	sHtml = sHtml+"<a href='/docs/search/DocSearchView.jsp?showtype=0&displayUsage=0&fromadvancedmenu=0&infoId=0&showDocs=0&showTitle=1&maincategory=&subcategory=&seccategory="+ids[i]+"'>"+names[i]+"</a>&nbsp";
					    }
				    }
				    $(span).html(sHtml);
				    $(input).val(datas.id);
			    }
			    else	{
		    	     $(span).html("<IMG src='/images/BacoError.gif' align=absMiddle>");
				    $(input).val("");
			    }
			    onNewContentCheck(input,eid,"cate");
			}
			
}
function onShowDoc(input,span,eid){
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��;
	datas = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?from=hpelement","","dialogTop="+iTop+";dialogLeft="+iLeft+";dialogHeight=550px;dialogWidth=550px;");
	if(datas){
		if(datas.id!=""){
			$(input).val(datas.id);
			$(span).html( "<a href='/docs/docs/DocDsp.jsp?id="+datas.id+"'  target='_blank'>"+datas.name+"</a>");
		}
		else{
			$(input).val("");
			$(span).val("");
		}
	}
}
function onShowMutiDummy(input,span,eid)	{
	splitflag = ",,,";
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��;
	datas =window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/DocTreeDocFieldBrowserMulti.jsp?para="+input.value+"&splitflag="+splitflag,"",
	"dialogTop="+iTop+";dialogLeft="+iLeft+";dialogHeight=550px;dialogWidth=550px;");
	if (datas) {
		if (datas.id!= ""){
			dummyidArray=datas.id.split(",");
			dummynames=datas.name.split(",");
			dummyLen=dummyidArray.length;
			sHtml="";
			for(var k=0;k<dummyLen;k++){
				sHtml = sHtml+"<a href='/docs/docdummy/DocDummyList.jsp?dummyId="+dummyidArray[k]+"'>"+dummynames[k]+"</a>&nbsp;";
			}
			input.value=datas.id;
			span.innerHTML=sHtml;
		}
		else{			
			input.value="";
			span.innerHTML="";
		}
		onNewContentCheck(input,eid,"");
	}
}

function onSelectBgImg(input, span, eid) {
    imgfileid = document.getElementById("_eBackground_" + eid).value;

    data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/homepage/element/setting/img.jsp?para=" + eid + "_" + imgfileid);
    if (data) {
        //alert(id(0));
        //alert(id(1));
        if (data.id != "") {
            input.value = data.id;
            span.innerHTML = data.name;
        } else {
            span.innerHTML = "";
            input.value = "";
        }
    }
}

function onShowNew(input, span, eid) {
    data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/news/NewsBrowser.jsp");
    if (data) {
        if (data.id != "") {
            span.innerHTML = "<a href='/docs/news/NewsDsp.jsp?id=" + data.id + "' target='_blank'>" + data.name + "</a>";
            input.value = data.id;

        } else {;
            span.innerHTML = "";
            input.value = "0";
        }
        onNewContentCheck(input, eid, "news");
    }
}

function onShowSearchTemplet(input, span, eid) {
    data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/DocSearchTempletBrowser.jsp");
    if (data) {
        if (data.id != "") {
            span.innerHTML = data.name;
            input.value = data.id;
            onNewContentCheck(input, eid, "");
        } else {;
            span.innerHTML = "";
            input.value = "";
        }
    }
}

function onShowMenus(input, span, eid) {
    data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/page/element/Menu/MenusBrowser.jsp");
    if (data) {
        if (data.id != "") {
            if (data.id == "hp") {
                span.innerHTML = "<a href='/homepage/maint/HomepageLocation.jsp' target='_blank'>" + data.name + "</a>";
            } else if (data.id == "sys") {
                span.innerHTML = "<a href='/systeminfo/menuconfig/MenuMaintFrame.jsp?type=" + data.id + "' target='_blank'>" + data.name + "</a>";
            } else {
                span.innerHTML = "<a href='/page/maint/menu/MenuEdit.jsp?id=" + data.id + "' target='_blank'>" + data.name + "</a>";
            }
            input.value = data.id;
        } else {
            span.innerHTML = "";
            input.value = "0";
        }
    }
}

function onShowMenuTypes(input, span, eid, menutype) {
    menutype = menutype.value;
    data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/page/element/Menu/MenuTypesBrowser.jsp?type=" + menutype);
    menulink = "";
    if (menutype == "element") {
        menulink = "ElementStyleEdit.jsp";
    } else if (menutype == "menuh") {
        menulink = "MenuStyleEditH.jsp";
    } else {
        menulink = "MenuStyleEditV.jsp";
    }
    if (data) {
        if (data.id != "") {
            span.innerHTML = "<a href='/page/maint/style/" + menulink + "?styleid=" +data.id + "&type=" + menutype + "&from=list' target='_blank'>" + data.name + "</a>";
            input.value = data.id;
        } else {
            span.innerHTML = "";
            input.value = "0";
        }
    }
}
</script>


<SCRIPT language="VBScript">
	Function URLEncoding(vstrIn)
    strReturn = ""	
	dim i
    For i = 1 To Len(vstrIn)
        ThisChr = Mid(vStrIn,i,1)
        If Abs(Asc(ThisChr)) < &HFF Then
            strReturn = strReturn & ThisChr
        Else
            innerCode = Asc(ThisChr)
            If innerCode < 0 Then
                innerCode = innerCode + &H10000
            End If
            Hight8 = (innerCode  And &HFF00)\ &HFF
            Low8 = innerCode And &HFF
            strReturn = strReturn & "%" & Hex(Hight8) &  "%" & Hex(Low8)
        End If
    Next
    URLEncoding = strReturn
End Function
</SCRIPT>

<script type="text/javascript">
	function onShowNewNews(input,span,eid,publishtype){
		var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
		var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��;
		datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/news/NewsBrowser.jsp?publishtype="+publishtype,"","dialogTop="+iTop+";dialogLeft="+iLeft+";dialogHeight=550px;dialogWidth=550px;")
		if (datas){
			if (datas.id){
				$(span).html( "<a href='/docs/news/NewsDsp.jsp?id="+datas.id+"' target='_blank'>" +datas.name+"</a>");
				$(input).val(datas.id);
			}else{ 
				$(span).html( "");
				$(input).val("");
			}
		}
	}
	function setPictureWidth(eid,needButton)
	{
		try
		{
			var pictureTable = document.getElementById("pictureTable_"+eid);
			var picture = document.getElementById("picture_"+eid);
			pictureTable.style.display = "none";
			var pwidth = pictureTable.parentNode.offsetWidth;
			
			if(needButton=="1")
			{
				if(pwidth>64)
				{
					pwidth = pwidth-64;
				}
			}
			else
			{
				pwidth = pwidth-6;
			}
			
			picture.style.width=pwidth;
			pictureTable.style.display = "";
		}
		catch(e)
		{
		}
	}
	function autoMarquee(eid)
	{
		try
		{
			var pictureothertd = document.getElementById("pictureothertd_"+eid);
			var picture  = document.getElementById("picture_"+eid);
			var picturetd = document.getElementById("picturetd_"+eid);
			
			if(pictureothertd.offsetWidth-picture.scrollLeft<=0)
			{
				picture.scrollLeft -= picturetd.offsetWidth;
			}
			else
			{
				picture.scrollLeft ++ ;
			}
		}
		catch(e)
		{
		
		}
	}
	
	function doScrollAuto(eid,needButton,speed){

		var myMar = window["mars_"+eid];
		var picture = document.getElementById("picture_"+eid);
		var picturetd = document.getElementById("picturetd_"+eid);
		var pictureothertd = document.getElementById("pictureothertd_"+eid);
		var pictureotherlinktd = document.getElementById("pictureotherlinktd_"+eid);
		var picturelinktd = document.getElementById("picturelinktd_"+eid); 
		var picturenext = document.getElementById("picturenext_"+eid);
		var pictureback = document.getElementById("pictureback_"+eid);
		
		if(picture.offsetWidth < picturetd.offsetWidth){
			pictureothertd.innerHTML=picturetd.innerHTML;
			pictureotherlinktd.innerHTML=picturelinktd.innerHTML;
			clearInterval(myMar);
			myMar=setInterval(function(){autoMarquee(eid)},speed);
			window["mars_"+eid]=myMar;
		}
		
		picture.onmouseover = function(){clearInterval(myMar);};
		picture.onmouseout = function(){myMar = setInterval(function(){autoMarquee(eid)},speed);window["mars_"+eid]=myMar;};
		if("1"==needButton){ 
			picturenext.onmouseover = function(){clearInterval(myMar);};
			picturenext.onmouseout = function(){myMar = setInterval(function(){autoMarquee(eid)},speed);window["mars_"+eid]=myMar;};
			pictureback.onmouseover = function(){clearInterval(myMar);};
			pictureback.onmouseout = function(){myMar = setInterval(function(){autoMarquee(eid)},speed);window["mars_"+eid]=myMar;};
		}
		
		
	}
	
	function nextMarquee(eid)
	{
		//if(pictureothertd.offsetWidth-picture.scrollLeft<=0)
			//{
			//	picture.scrollLeft -= picturetd.offsetWidth;
			//}
			//else
			//{
			//	picture.scrollLeft ++ ;
			//}
		document.getElementById("picture_"+eid).scrollLeft+=75;
		//alert(document.getElementById("picture_"+eid).scrollLeft)
		//autoMarquee(eid)
		//	alert(document.getElementById("picture_"+eid).scrollLeft)
	}
	
	function backMarquee(eid)
	{
		document.getElementById("picture_"+eid).scrollLeft-=75;
		
	}
	
	function selectEngine(eid)
	{
		var keyword =document.getElementById("searchf_"+eid).keyword.value;
		var saction = "/page/element/SearchEngine/NewsSearchList.jsp?eid="+eid+"&keyword=";	
		saction +=keyword;
		openFullWindowForXtable(saction)
	
	}
</script>

<script type="text/javascript">
function changeMsg(eid,msg)
{	
	var frmLogin = document.getElementById("frmLogin_"+eid);
	var validatecode = frmLogin.validatecode;
    if(msg==0)
    {
       	if(validatecode.value=='<%=SystemEnv.getHtmlLabelName(22909,7)%>') 
           	validatecode.value='';
    }
    else if(msg==1)
    {
        if(validatecode.value=='') 
            validatecode.value='<%=SystemEnv.getHtmlLabelName(22909,7)%>';
    }
}
function checkall(eid,userparamname,userparampass,needvalidate,usbType)
{
	var errMessage="";
	var frmLogin = document.getElementById("frmLogin_"+eid);	
	var loginid = document.getElementById(userparamname);
	var userpassword = document.getElementById(userparampass);
	
	if (loginid&&loginid.value=="") 
	{
		errMessage="<%=SystemEnv.getHtmlLabelName(16647,7)%>";
		alert(errMessage);
		loginid.focus();
		return false ;
	}
	if (userpassword&&userpassword.value=="") 
	{
		errMessage="<%=SystemEnv.getHtmlLabelName(16648,7)%>";
		alert(errMessage);
		userpassword.focus();
		return false ;
	}
	if(needvalidate=="1"){
		var validatecode = frmLogin.validatecode;
		if (validatecode&&(validatecode.value==""||validatecode.value=='<%=SystemEnv.getHtmlLabelName(22909,7)%>')) 
		{
			errMessage="<%=SystemEnv.getHtmlLabelName(22909,7)%>";
			alert(errMessage);
			validatecode.focus();
			return false ;
		}
	}
	frmLogin.submit(); 
	loginid.value="";
   	userpassword.value="";
  	$("#message_"+eid).html("");

}


function getBytesLength(str) {
	// ��GBK���������ASCII�ַ���������ռ�����ַ���
	return str.replace(/[^\x00-\xff]/g, 'xx').length;
}

/**
 * �����ַ�������ȡ�ַ���
 */
function subStringByBytes(val, maxBytesLen) {
	var len = maxBytesLen;
	var result = val.slice(0, len);
	while(getBytesLength(result) > maxBytesLen) 
	{
		result = result.slice(0, --len);
	}
	return result;
}

function saveScratchpad(eid,userid)
{
	var scratchpadareatext = document.getElementById("scratchpadarea_"+eid);
	scratchpadareatext.disabled = true;
	
	var padcontent = jQuery(scratchpadareatext).val();
	
	var len = getBytesLength(padcontent);
	//alert("len : "+len);
	if(len>4000)
	{
		var reply=confirm("<%=SystemEnv.getHtmlLabelName(22934, user.getLanguage())%>?");
		if(reply)
		{
			padcontent = subStringByBytes(padcontent,4000);
			$.post("/page/element/scratchpad/ScratchpadOperation.jsp", { eid:eid, userid:userid, operation: "save",padcontent:padcontent },function(data){
			    	data = data.replace(/(^\s*)|(\s*$)/g, "");
			    	var scratchpadareatext = document.getElementById("scratchpadarea_"+eid);
			    	jQuery(scratchpadareatext).val(data);
	    			scratchpadareatext.disabled = false;
			});
		}
		else
		{
			scratchpadareatext.focus();
			scratchpadareatext.disabled = false;
		}
	}
	else
	{
		$.post("/page/element/scratchpad/ScratchpadOperation.jsp", { eid:eid,userid:userid, operation: "save",padcontent:padcontent },function(data){
			scratchpadareatext.disabled = false;
		});
	}
}

    /**
	*����Ԫ�ع�������
	*/
   function weatherAutoScroll(weatherId){
                
                var demo=document.getElementById(weatherId+"_0");
				
                var demo1=document.getElementById(weatherId+"_1");
				
                var demo2=document.getElementById(weatherId+"_2");
                
                var speed=30;
				var flag=0;  //���ڼ�¼ demo.scrollLeft ��λ�ã���ֹ���ÿ�ȹ���ʱ�����ֹ���ֹͣ����
				demo2.innerHTML=demo1.innerHTML;
				var Marquee=function(){
					if(demo2.offsetWidth-demo.scrollLeft<=0){
					     demo.scrollLeft-=demo1.offsetWidth;
					  }
					else if(flag==demo.scrollLeft&&demo.scrollLeft!=0)
					    demo.scrollLeft-=demo1.offsetWidth;
					else{
					    flag=demo.scrollLeft;
					    demo.scrollLeft++;
					}
				};
				var MyMar=setInterval(Marquee,speed);
				demo.onmouseover=function() {clearInterval(MyMar)};
				demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)};

    }
/**
	*����Ԫ���ֶ���������
	*/
	function nextWeatherMarquee(eid)
	{
		//if(pictureothertd.offsetWidth-picture.scrollLeft<=0)
			//{
			//	picture.scrollLeft -= picturetd.offsetWidth;
			//}
			//else
			//{
			//	picture.scrollLeft ++ ;
			//}
		document.getElementById("weather_"+eid+"_0").scrollLeft+=75;
		//alert(document.getElementById("picture_"+eid).scrollLeft)
		//autoMarquee(eid)
		//	alert(document.getElementById("picture_"+eid).scrollLeft)
	}
	
	function backWeatherMarquee(eid)
	{
		document.getElementById("weather_"+eid+"_0").scrollLeft-=75;
		
	}
</script>
