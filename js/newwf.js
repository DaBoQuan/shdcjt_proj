var isworkflowdoc = 0;//����1Ϊ����
var seeflowdoc = 0;//�Ƿ�ֱ����ʾ����tabҳ
var wfdoc = "";//�鿴���ĵ�ҳ��
var createdocNoClick="0";//���������İ�ť
var picInnerFramerUrl = "";	
var statInnerFrameurl = "";
if($G("isworkflowdoc")!=null) isworkflowdoc = $G("isworkflowdoc").value;
if($G("seeflowdoc")!=null) seeflowdoc = $G("seeflowdoc").value;
if($G("wfdoc")!=null) wfdoc = $G("wfdoc").value;
if($G("picInnerFrameurl")!=null) picInnerFramerUrl = $G("picInnerFrameurl").value;
if($G("statInnerFrameurl")!=null) statInnerFrameurl = $G("statInnerFrameurl").value;


function initNewRequestFrame()
{
	//document.body.scroll ="no";
	jQuery(document.body).attr("scroll", "no");
	jQuery(document.body).css("overflow", "hidden");
	jQuery(document.body).addClass("ext-ie");
	//document.body.className += " ext-ie";

//	document.getElementById("WfBillIframeDiv").appendChild(document.getElementById("divBill"));
//	document.getElementById("WfBillIframeDiv").style.display = "none";
//    document.getElementById("WfPicIframeDiv").style.display = "none"
//    document.getElementById("WfLogIframeDiv").style.display = "none"
    //document.getElementById("divWfBill").style.display = "";
	//document.getElementById("divWfPic").style.display = "none";
	//document.getElementById("divWfLog").style.display = "none";
	jQuery("#divWfBill").css("display", "");
	jQuery("#divWfPic").css("display", "none");
	jQuery("#divWfLog").css("display", "none");
	setToolBarMenu();
}
function setToolBarMenu()
{
	var toolbarmenu = document.getElementById("toolbarmenu");
	var toolbarmenudiv = document.getElementById("toolbarmenudiv");
	if(bar!="" && bar != undefined && bar != null)
	{
		for(var i = 0;i<bar.length;i++)
		{
			var bare = bar[i];
			var newtd = document.createElement("td");
			newtd.className = "";
			//newtd.innerHTML = "<BUTTON class='nx-btn-text "+bare.iconCls+"' onmouseout='resetButtonClass(this,1);' onmouseover='resetButtonClass(this,2);' onclick='new "+bare.handler+"'>"+bare.text+"</BUTTON>";
			newtd.innerHTML = "<TABLE style='WIDTH: auto' class='x-btn  x-btn-text-icon' onmouseout='resetButtonClass(this,1);' onmouseover='resetButtonClass(this,2);' onclick='new "+bare.handler+"' cellSpacing=0>"+
							  "		<TBODY class='x-btn-small x-btn-icon-small-left'>"+
							  "			<TR><TD class=x-btn-tl><I>&nbsp;</I></TD><TD class=x-btn-tc></TD><TD class=x-btn-tr><I>&nbsp;</I></TD></TR>"+
							  "			<TR><TD class=x-btn-ml><I>&nbsp;</I></TD>"+
							  "				<TD class=x-btn-mc><EM unselectable='on'><BUTTON class='x-btn-text "+bare.iconCls+"'>"+bare.text+"</BUTTON></EM></TD>"+
							  "				<TD class=x-btn-mr><I>&nbsp;</I></TD>"+
							  "			</TR>"+
							  "			<TR><TD class=x-btn-bl><I>&nbsp;</I></TD><TD class=x-btn-bc></TD><TD class=x-btn-br><I>&nbsp;</I></TD></TR>"+
							  "		</TBODY>"+
							  "	</TABLE>"
			//toolbarmenu.appendChild(newtd);
			jQuery(toolbarmenu).append(newtd);
		}
		if(toolbarmenudiv)
		{
			//toolbarmenudiv.style.display="";
			jQuery(toolbarmenudiv).css("display", "");
		}
	}
	else
	{
		//toolbarmenudiv.style.display="none";
		jQuery(toolbarmenudiv).hide();
	}
}
function resetButtonClass(o,type)
{
	var oclassname = o.className;
	if(oclassname)
	{
		oclassname = oclassname.replace(/(^\s*)|(\s*$)/g, "");
	}
	if(type==1)
	{
		if(oclassname.indexOf('x-btn-over')>-1)
		{
			o.className = oclassname.replace(/x-btn-over/g,'');
		}
	}
	else
	{
		if(oclassname.indexOf('x-btn-over')<0)
		{
			o.className=oclassname+" x-btn-over ";
		}
	}
}
var tempcurrentTab = "WfBill"; 
function changeTabToWf(newTab,o)
{
	if(tempcurrentTab==newTab)
	{
		return false;
	}
	o.className = "x-tab-with-icon x-tab-strip-active";
	
	if(tempcurrentTab!="")
	{
		var tempcurrentTabdiv = document.getElementById(tempcurrentTab);
		if(tempcurrentTabdiv)
		{
			tempcurrentTabdiv.className = "x-tab-with-icon";
		}
	}
	if(tempcurrentTab!=null)
	{//�뿪��������ʱ�����ѱ���		
		if(tempcurrentTab=='WfText') 
		{	
			var modify = false;
			try 
			{
				modify = document.frames["workflowtext"].wfchangetab();
				jQuery(document.getElementById("workflowtext").contentWindow.document.body).attr("onbeforeunload", "");
			}
			catch(e)
			{}
			
			if(modify && !confirm(wmsg.wf.leavedoc))
			{
				return false;
			}
			else
			{
				$G("bodyiframe").contentWindow.displayAllmenu();//��ʾ����Ҽ���ext��ť
				addsave();
                var tmpindx=$G("bodyiframe").contentWindow.document.frmmain.action.indexOf("?");
                if(tmpindx>-1) $G("bodyiframe").contentWindow.document.frmmain.action =$G("bodyiframe").contentWindow.document.frmmain.action.substr(0,tmpindx);
			}
		}
	}
	if(newTab=='WfPic') 
    {
    	try {
			if(jQuery("#picInnerFrame").attr("src") == "") {
				jQuery("#picInnerFrame").attr("src", picInnerFramerUrl);
			}
		}
		catch(e)
		{}
		try
		{
			if(jQuery("#piciframe").attr("src") == "") {
				jQuery('#loading').css("display", "");
				jQuery("#piciframe").attr("src",  picInnerFramerUrl);
				eventPush(jQuery('#piciframe').get(0), 'load',loadcomplete);
				loadcomplete();
			}
		}
		catch(e)
		{}
    }
    if(newTab=='WfLog') 
    {
    	try
    	{
			if(jQuery("#statiframe").attr("src") == "") {
				jQuery("#loading").css("display", "");
				jQuery("#statiframe").attr("src", statInnerFrameurl);
				eventPush(jQuery("#statiframe").get(0),'load',loadcomplete);
			}
		}
		catch(e)
		{}
    }
	var cbodyiframediv = document.getElementById("div"+tempcurrentTab);
	cbodyiframediv.style.display="none";
	tempcurrentTab = newTab;
    if(newTab=='WfText') 
    {
    	//������
    	if($G("bodyiframe").contentWindow.document.getElementById("needoutprint")) $G("bodyiframe").contentWindow.document.getElementById("needoutprint").value = "1";//��ʶ������
	 	if(createdocNoClick!="1")
	 	{
			var language=7;
		    try{
				language=readCookie("languageidweaver");
			}catch(e){}
			
			if($G("bodyiframe").contentWindow.document.getElementById("createdoc")==null){
				if(language==8){
					alert("It haven't text,couldn't been viewed��");
				}else if(language==9){
					alert("�Пo���ģ����ܲ鿴��");
				}else{
					alert("�������ģ����ܲ鿴��");
				}
				return ;
			}
			$G("bodyiframe").contentWindow.document.getElementById("createdoc").click();
		}
	    createdocNoClick = "0";		
		try
		{
			$G("bodyiframe").contentWindow.document.getElementById("rightMenu").style.display="none";//����Ҽ�ȥ��	
			$G("bodyiframe").contentWindow.enableAllmenu();
		}
		catch(e)
		{
			//alert(e);
		}
    }
    else{
		if($G("bodyiframe").contentWindow.document.getElementById("needoutprint")) $G("bodyiframe").contentWindow.document.getElementById("needoutprint").value = "";//��ʶ������    	
    }
    if(newTab=='WfBill') 
    { //���				
    	$G("bodyiframe").contentWindow.document.getElementById("rightMenu").style.display="";//����Ҽ���ʾ
		try
		{
		 	var action_old = $G("bodyiframe").contentWindow.document.frmmain.action;
			var indexTmp = action_old.indexOf(".jsp");
			if(indexTmp > 0)
			{
				var action_new = action_old.substring(0, indexTmp+4);
			}
			$G("bodyiframe").contentWindow.document.frmmain.action = action_new;
		}catch(e){}
		try{
			document.getElementById("workflowtext").src = "";
			$G("bodyiframe").contentWindow.setheight();
			$G("bodyiframe").contentWindow.RefreshViewSize();
		}catch(e){}
	    createdocNoClick = "0";	
	    if($G("bodyiframe").contentWindow.document.getElementById('chinaExcel')!=undefined){
	    	$G("bodyiframe").contentWindow.location.reload();
	    }
    }
	var bodyiframediv = document.getElementById("div"+newTab);
	bodyiframediv.style.display="";
}
function ajaxreadurlinit()
{
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

function getdocurl(){
	var rand = "";
	if($G("bodyiframe").contentWindow.document.getElementsByName("rand") != null) {
		rand = $G("bodyiframe").contentWindow.document.getElementsByName("rand")[0].value;
	}
	var requestid = $G("bodyiframe").contentWindow.document.getElementsByName("requestid")[0].value;
    jQuery.ajax({
    	type: 'post',
    	url: "/workflow/request/GetRequestSession.jsp?requestid=" + requestid + "&rand=" + rand,
    	dataType: "text", 
	    contentType : "charset=gbk", 
    	success: function (msg) {
	    	var url = msg.replace(/(^\s*)|(\s*$)/g, "");
			if(url == "") {//û�ж���url����һֱ��ȡ
				setTimeout(getdocurl, 50);
			}else {
				setdocurl(url);
			}
    	}, error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("XMLHttpRequest.status:" 
            		+ XMLHttpRequest.status 
            		+ ", XMLHttpRequest.readyState:" 
            		+ XMLHttpRequest.readyState 
            		+ ", textStatus:" 
            		+ textStatus);
        }
    });
    /*
    var ajax=ajaxreadurlinit();
    ajax.open("POST", "/workflow/request/GetRequestSession.jsp?requestid=" + requestid + "&rand="+rand, true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid="+requestid+"&rand="+rand);
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
            	
            	var url = ajax.responseText.replace(/(^\s*)|(\s*$)/g, "");
            	alert(url);
				if(url=="") {//û�ж���url����һֱ��ȡ
					setTimeout("getdocurl()",50);
				}else {
					setdocurl(url);
				}
            }catch(e){
            	alert("wf.js ��ȡurl����");
            }
        }
    }
    */
}

function setdocurl(url){
	var error = url.substring(0,5);
	if(error=="error"){
		location.href=url.substring(5);
	}else{
		document.getElementById("workflowtext").src = url;
	}
}

function clicktext(){//�������ģ�����½����Ļ�����������
	try
   	{
   		if(tempcurrentTab!="WfText")
   		{
   			var o = document.getElementById("WfText");
   			o.className = "x-tab-with-icon x-tab-strip-active";
	
			if(tempcurrentTab!="")
			{
				var tempcurrentTabdiv = document.getElementById(tempcurrentTab);
				if(tempcurrentTabdiv)
				{
					tempcurrentTabdiv.className = "x-tab-with-icon";
				}
			}
			var cbodyiframediv = document.getElementById("div"+tempcurrentTab);
			cbodyiframediv.style.display="none";
			tempcurrentTab = "WfText";
			try
			{
				$G("bodyiframe").contentWindow.document.getElementById("rightMenu").style.display="none";//����Ҽ�ȥ��	
				$G("bodyiframe").contentWindow.enableAllmenu();
			}
			catch(e)
			{
				//alert(e);
			}
			var bodyiframediv = document.getElementById("divWfText");
			bodyiframediv.style.display="";
			createdocNoClick = "1";
   		}
   		readdocurl();
	} 
	catch(e)
	{
		//alert(e)
	}
	$G("bodyiframe").contentWindow.enableAllmenu();
}

function readdocurl(){   
	if($G("bodyiframe").contentWindow.window.frames['delzw'].document.readyState=="complete")   
	    getdocurl();   
	else   
		setTimeout("readdocurl()",50);   
}   

function addsave(){
	try
	{
		$G("bodyiframe").contentWindow.frmmain.method.value = "";
		$G("bodyiframe").contentWindow.document.frmmain.target="";
		$G("bodyiframe").contentWindow.document.getElementById("rand").value = $G("bodyiframe").contentWindow.document.getElementById("rand").value + "+save";
	}
	catch(e)
	{}
}
function delsave(){
	var rand="";
	try{
		rand = $G("bodyiframe").contentWindow.document.getElementById("rand").value;
		if(rand.indexOf("+")>0)
			$G("bodyiframe").contentWindow.document.getElementById("rand").value = $G("bodyiframe").contentWindow.rand.substring(0,rand.indexOf("+"));
	}catch(e){}
}
function eventPush(obj, event, handler) {
	/*
	if (obj.addEventListener){
	     obj.addEventListener(event, handler, false);
	} else if (obj.attachEvent){
	     obj.attachEvent('on'+event, handler);
	}
	 */
	jQuery(obj).bind(event, handler);
}
function loadcomplete(){
	//document.getElementById('loading').style.display="none";	
	jQuery("#loading").hide();
}

function oc_CurrentMenuOnMouseOut(icount) {
	jQuery("#oc_divMenuDivision" + icount).css("visibility", "hidden");
}

function oc_CurrentMenuOnClick(icount) {
	jQuery("#oc_divMenuDivision" + icount).css("visibility", "");
}

/**
 * ��ֹʱ��ð��
 * @param e �¼�event 
 * @param handler 
 * @return
 */
function isMouseLeaveOrEnter(e, handler) {
    if (e.type != 'mouseout' && e.type != 'mouseover') return false;
    var reltg = e.relatedTarget ? e.relatedTarget : e.type == 'mouseout' ? e.toElement : e.fromElement;
    while (reltg && reltg != handler)
        reltg = reltg.parentNode;
    return (reltg != handler);
}