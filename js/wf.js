var viewport;
var tabPanelContent;
var isworkflowdoc = 0;//����1Ϊ����
var seeflowdoc = 0;//�Ƿ�ֱ����ʾ����tabҳ
var wfdoc = "";//�鿴���ĵ�ҳ��
var picInnerFramerUrl = "";	
var createdocNoClick="0";//���������İ�ť

if($G("isworkflowdoc")!=null) isworkflowdoc = $G("isworkflowdoc").value;
if($G("seeflowdoc")!=null) seeflowdoc = $G("seeflowdoc").value;
if($G("wfdoc")!=null) wfdoc = $G("wfdoc").value;
if($G("picInnerFrameurl")!=null) picInnerFramerUrl = $G("picInnerFrameurl").value;

var panelWfLog;
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.useShims = true;
	Ext.BLANK_IMAGE_URL = '/js/extjs/resources/images/default/s.gif';
    var activeTabid = 0;	
	var panelBill={// '��'
		xtype:'panel',
		id:'bill',
		autoScroll:true,
		contentEl : 'divBill',
		iconCls:'btn_add',
		title : wmsg.wf.bill						
	};
	var panelWfPic={// '����ͼ'
		xtype:'panel',
		id:'wfPic',
		autoScroll:true,
		contentEl : 'divWfPic',
		iconCls:'btn_add',
		title : wmsg.wf.pic							
	};
	/*var panelWfLog=new Ext.Panel({// '��ת״̬'		
		id:'wfLog',
		contentEl : 'divWfLog',
		iconCls:'btn_add',
		title : wmsg.wf.status					
	});*/
	var items =[panelBill,panelWfPic,panelWfLog];
	
    if(isworkflowdoc == "1"){
		
		var panelWfText={// '��������'		   
			xtype:'panel',
			id:'wfText',
			iconCls:'btn_add',
		    //html:'<iframe id="workflowtext"  name="workflowtext" BORDER=0 FRAMEBORDER=no height="100%" width="100%" scrolling="auto" src="'+wfdoc+'"></iframe>',
			html:'',
		    title : wmsg.wf.text,
			listeners:{				
				activate:function(p){						
					try{	
						var url="";							
						var strIfrm="<IFRAME src='"+url+"' id=workflowtext  name=workflowtext style='width:100%;height:100%'  BORDER=0 FRAMEBORDER=no NORESIZE=NORESIZE scrolling='auto'></IFRAME>";
						p.getEl().dom.firstChild.firstChild.innerHTML=strIfrm;						
						readdocurl();
					} catch(e){
						//alert(e)
					}
				}
			}
		};
		items =[panelBill,panelWfPic,panelWfLog,panelWfText];
		
		if(seeflowdoc=="1"){
		    //activeTabid = 3;//����	
		}else if(seeflowdoc=="2"){
		    //activeTabid = 0;//��	
		}else if(seeflowdoc=="3"){
		    //activeTabid = 1;//����ͼ	
		}else if(seeflowdoc=="4"){
		    //activeTabid = 2;//����״̬	
		} 

	}

	
	if (isfromtab) {
		bar=bar.concat('->');
		bar=bar.concat({text: wmsg.base.openInNewWin,iconCls:'btn_add',handler: function(){
		var url =window.location.href; 
		if(url.indexOf('&isfromtab')!=-1){
			url = url.substring(0,url.indexOf('&isfromtab'));
		}
		openFullWindowForXtable(url)
		}
		});
		tabPanelContent={
					id:'tabPanelContent',	
					xtype:'tabpanel',
					listeners: {
			            beforetabchange : function( thisPanel,  newTab,  currentTab ) {		
			            	changeTabToWf(newTab,  currentTab)		            
			            }
			        },				
					region : 'center',
					activeTab : activeTabid,
					tabPosition : 'bottom',
					tbar : bar,
					items : items
		};
		
		viewport = new Ext.Viewport({
			layout : 'border',
			items : [tabPanelContent]
		});
	} else {
		tabPanelContent={
			id:'tabPanelContent',	
			xtype:'tabpanel',
			listeners: {
	            beforetabchange : function( thisPanel,  newTab,  currentTab ) {		
	            		return changeTabToWf(newTab,  currentTab)		             
	            }
	        },		        
			//title : wftitle,
			activeTab : activeTabid,
			frame : true,
			tabPosition : 'bottom',
			minTabWidth : 150,
			resizeTabs : true,
			items : items
			,tbar : bar
		};		
		viewport = new Ext.Viewport({
			layout : 'border',
			items : [	
				panelTitle,		
				new Ext.Panel({	
				margins: '0 8 2 5',			
				region : 'center',				
				layout:'fit',
				//activeTab : 0,
				items : [tabPanelContent]
			})]
		});
	}


	//Ext.get('loading').fadeOut();		

});

function changeTabToWf(newTab,currentTab){
	if(currentTab!=null){//�뿪��������ʱ�����ѱ���		
		if(currentTab.id=='wfText') {	
			var modify = false;
			try {
				modify = document.frames["workflowtext"].wfchangetab();
				document.getElementById("workflowtext").contentWindow.document.body.onbeforeunload = null;
			}catch(e){}
			if(modify && !confirm(wmsg.wf.leavedoc)){
				return false;
			}else{
				bodyiframe.displayAllmenu();//��ʾ����Ҽ���ext��ť
				addsave();
			}			
		}
	}

    if(newTab.id=='wfText'&&currentTab!=null) { //������				
		if(bodyiframe.document.getElementById("needoutprint")) bodyiframe.document.getElementById("needoutprint").value = "1";//��ʶ������
	 	if(createdocNoClick!="1"){
		    bodyiframe.document.getElementById("createdoc").click();
		}
	    createdocNoClick = "0";		
		try{
			bodyiframe.document.getElementById("rightMenu").style.display="none";//����Ҽ�ȥ��	
			bodyiframe.enableAllmenu();
		}catch(e){
			//alert(e);
		}
    }else{
		if(bodyiframe.document.getElementById("needoutprint")) bodyiframe.document.getElementById("needoutprint").value = "";//��ʶ������    	
    }

    if(newTab.id=='bill' && currentTab!=null) { //���				
		try{
		 	var action_old = frmmain.action;
			var indexTmp = action_old.indexOf(".jsp");
			if(indexTmp > 0){
				var action_new = action_old.substring(0, indexTmp+4);
			}
			frmmain.action = action_new;
		}catch(e){
		}
    }
	
	var displaytab = "";
 	if(newTab.id=='bill') displaytab = "divBill";
 	if(newTab.id=='wfPic') displaytab = "divWfPic";
 	//if(newTab.id=='wfLog') displaytab = "divWfLog";

 	try {
		document.getElementById(displaytab).style.display = '';	
	} catch (e) {}


    if(currentTab!=null&&currentTab.id=='bill') { //�뿪��
	 	try {
			setTimeout("document.getElementById('divBill').style.display = 'none'",10);
		} catch (e) {}
    }

	if(newTab.id=="wfLog" && isfirstAccess!=undefined && isfirstAccess == true){
		try{
			workflowrequestpicture.load();
		}catch(e){
		}
		isfirstAccess = false
	}

	if(newTab.id=="wfPic"){
		try{
			if(document.getElementById("picInnerFrame").src==""){
				document.getElementById("picInnerFrame").src = picInnerFramerUrl;
			}
		}catch(e){}
	}

}

function ajaxreadurlinit(){
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
	if(bodyiframe.document.getElementById("rand")!=null)
		rand = bodyiframe.document.getElementById("rand").value;
	var requestid = bodyiframe.document.getElementsByName("requestid")[0].value;
    var ajax=ajaxreadurlinit();
    ajax.open("POST", "/workflow/request/GetRequestSession.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid="+requestid+"&rand="+rand);
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
            	
            	var url = ajax.responseText.trim();
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
	try{		
		var _tabPanelContent = Ext.getCmp("tabPanelContent");
		var _currentTab = _tabPanelContent.getActiveTab();
		if(_currentTab.getId()!="wfText"){
			createdocNoClick="1";
			_tabPanelContent.setActiveTab("wfText");
		}
	}catch(e){
	}
	try{
	enableAllmenu();
	}catch(e){
	}
}

function readdocurl(){   
	if(bodyiframe.window.frames['delzw'].document.readyState=="complete")   
	    getdocurl();   
	else   
		setTimeout("readdocurl()",50);   
}   

function addsave(){
	try{
		bodyiframe.frmmain.method.value = "";
		bodyiframe.document.frmmain.target="";
		bodyiframe.document.getElementById("rand").value = bodyiframe.document.getElementById("rand").value + "+save";
	}catch(e){}
}
function delsave(){
	var rand="";
	try{
		rand = bodyiframe.document.getElementById("rand").value;
		if(rand.indexOf("+")>0)
			bodyiframe.document.getElementById("rand").value = bodyiframe.rand.substring(0,rand.indexOf("+"));
	}catch(e){}
}
function eventPush(obj, event, handler) {
	if (obj.addEventListener){
	     obj.addEventListener(event, handler, false);
	} else if (obj.attachEvent){
	     obj.attachEvent('on'+event, handler);
	}
}
function loadcomplete(){
	Ext.get('loading').fadeOut();	
}