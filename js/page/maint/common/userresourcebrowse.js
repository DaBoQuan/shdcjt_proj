var mystore = new Ext.data.SimpleStore({
    fields: [
       {name: 'name'},
       {name: 'size'},
       {name: 'date'}
    ],
    listeners:{
    	datachanged : function(){
    		setFileChecked(file);
    	}
    }
});

//ѡ���ļ���
var checkedFile='';

//��ǰ����
var operate='';
/*define tree panel*/
wfTreePanel = function(){
    wfTreePanel.superclass.constructor.call(this, { 
    	contentEl:"container_id",
        width: 200,
        minSize: 175,
        maxSize: 400,
        useArrows: true,
        animate:false,
        border:true,
		header : false,
		
        footer:false

    });

};

Ext.extend(wfTreePanel, Ext.Panel, {
    autoScroll:true
});

/*define Grid*/
Ext.override(Ext.grid.GridView, {
    templates: {
        cell: new Ext.Template('<td class="x-grid3-col x-grid3-cell x-grid3-td-{id} {css}" style="{style}" tabIndex="0" {cellAttr}>', '<div class="x-grid3-cell-inner x-grid3-col-{id}" {attr}>{value}</div>', "</td>")
    }
});


    
 var sm = new  Ext.grid.CheckboxSelectionModel({header:'',singleSelect:singleSelect,listeners :{rowselect: onCheckFile}});
 var gridColumns ;
 
 if(isSystem){
 	gridColumns =   new Ext.grid.ColumnModel([
 		sm,
 			{
           id:'name',
           header: urmsg.name,
           dataIndex: 'name',
           width: 200,
           sortable:true,
           editor: new Ext.form.TextField({
               allowBlank: false
           })
        },{
           header: urmsg.size,
           dataIndex: 'size',
           sortable:true,
           width: 40
        },{
           header: urmsg.lastModified,
           dataIndex: 'date',
           sortable:true,
           width: 80
           
        }
    ]);
 }else{
 gridColumns =   new Ext.grid.ColumnModel([
 		sm,
 			{
           id:'name',
           header: urmsg.name,
           dataIndex: 'name',
           width: 200,
           sortable:true
        },{
           header: urmsg.size,
           dataIndex: 'size',
           sortable:true,
           width: 20
        },{
           header: urmsg.lastModified,
           dataIndex: 'date',
           sortable:true,
           width: 80
           
        }
    ]);
 }

wfTreeGrid = function(viewer, config){
	
    this.viewer = viewer;
    Ext.apply(this, config);
    this.id = "id";
    this.store = mystore;
	this.store.setDefaultSort("name", "asc");
	this.stripeRows=true;
    
    //this.cm= new Ext.grid.ColumnModel([new Ext.grid.RowNumberer()].concat(sm).concat(mycolumns));	
    this.cm = gridColumns;
    this.columns =gridColumns;
    this.sm = sm;
    
    wfTreeGrid.superclass.constructor.call(this, {
    	border:false,
    	style:'border-top:1px solid  #D0D0D0',
        region: 'center',  
        clicksToEdit:2,
        
	    listeners: {
	       validateedit : function(e){
				if(!checkFileName(e.value,'file')){
					return false;
				}else{
					return rename(e.originalValue,e.value);
				}
				
	       }
        },
        loadMask: {
            msg: wmsg.grid.loadMask
        },        
        stripeRows: true,    
        viewConfig: {
            forceFit: true
        }
    });
};



/*GridPanel*/
Ext.extend(wfTreeGrid, Ext.grid.EditorGridPanel, {		

});


/*define mainPanel*/
MainPanel = function(){
	this.grid = new wfTreeGrid();
	wfTrees = new wfTreePanel();
    wfTrees.setTitle(urmsg.fileDir);
 	panelLeft=new Ext.TabPanel({		
			border:false,			
            activeTab: 0,
            region: 'west',
            id: 'east-panel',  
			//collapseMode:'mini',   				
			//collapsible: true,          
            //split: true,  
            width: 125,
            //collapseFirst:true, 
            tabPosition: 'top',
            minSize: 125,
            maxSize: 125,	                
           items: [wfTrees]
                          
        });
    //btn
    MainPanel.superclass.constructor.call(this, {
        id: 'main-tabs',
        activeTab: 0,
        region: 'center',
        layout:'fit',
        margins: '5 5 5 5',
        resizeTabs: true,
        tabWidth: 150,
        minTabWidth: 120,
        enableTabScroll: true,
        border:false,
        buttons :[{
		        	id:'submit',
		            text: urmsg.submit,
		            iconCls: '',
		            handler: onSubmit,
		            scope: this
		        },{
		        	id:'open',
		            text: urmsg.cancel,
		            iconCls: '',
		            handler: onCancel,
		            scope: this
		        },{
		        	id : 'clear',
		            text: urmsg.clear,
		            iconCls: '',
		            handler: onClear,
		            scope: this
		        }],
		buttonAlign :"center",
        items: {
            id: 'main-view',
            layout: 'border',
            items: [
	            panelLeft,
	            {   
	            	id:'panelRight',
	            	xtype:'panel',
	            	region: 'center',
	            	layout:'border',
	            	//border:false,
	            	tbar:[
	            		{
					        	id:'wfType',
					        	height:27,
					        	//handleMouseEvents :false,
					            text: urmsg.createDir,
					            hidden:!isSystem,
					            
					            iconCls: '',
					            handler: createDir,
					            scope: this
					        },{
					        	id:'open',
					        	height:27,
					        	//handleMouseEvents :false,
					            text: urmsg.renameDir,
					            hidden:!isSystem,
					           
					            iconCls: '',
					            handler: renameDir,
					            scope: this
					        },{
					        	id : 'deleteDir',
					        	height:27,
					        	//handleMouseEvents :false,
					            text: urmsg.deleteDir,
					            
					            hidden:!isSystem,
					            handler:deleteDir,
					            scope: this
					        },{
					        	id : 'deleteFile',
					        	//handleMouseEvents :false,
					        	height:27,
					            text: urmsg.deleteFile,
					           
					            hidden:!isSystem,
					            handler:deleteFile,
					           
					            scope: this
					        },uploadBtn
					        
					        ],
	            	items:[
	            		{
		            		id:'uploadPanel',	
		            		border:false,         		
		            		xtype:'panel',
		            		region: 'north',
							autoScroll:true,
							autoHeight : true,
		            		contentEl:"uploadDiv",
		            		listeners:{
		            			render:function(panel){
		            				panel.hide();
		            			}
		            		}
	            		},
	            		this.grid,
	            		
	            		{
	            			xtype:'panel',
	            			region: 'south',
	            			split:true,
	            			border:false,
	            			style:'border-top:1px solid  #D0D0D0',
	            			collapseMode:'mini',
	            			html:'<div style="overflow:auto;width:100%;height:100%"><table width="100%" height="100%"><tr><td style="overflow:auto;text-align:center;height:100%;" valign="middle" id="divPreview"></td></tr></table></div>',
	            			height:150
	            		}
	            		
	            	]
				}
			]
        }
    });
};

Ext.extend(MainPanel, Ext.Panel, {});
/*define viewport*/
Ext.onReady(function(){
	
    Ext.QuickTips.init();
    Ext.BLANK_IMAGE_URL = '/js/extjs/resources/images/default/s.gif';
	Ext.useShims = true;
    mainPanel = new MainPanel();
	
    viewport = new Ext.Viewport({
        layout: 'border',
	     items: [        	
    	 mainPanel]
    });
    init();
   	if(fileExist=='false'){
   		$("#divPreview").append("<font>"+urmsg.fileNotExist+"</font>");   		
	}
    Ext.get('loading').fadeOut();
});

/**
 * �ж��ļ����Ƿ�Ϸ�
 * @param {} name
 * @return {Boolean}
 */
function checkFileName(name,type) {
    var pattern=/[\/\\\:\*\?\"\<\>\|]/;
    if($.trim(name)==''){
    	alert(urmsg.noNull);
    	return false;
    }
    
    if(name.indexOf(' ')!=-1) {
        alert(urmsg.noSpace);
        return false;
    }
   	if(type=='dir'){
   		if(name.length>100){
   			alert();
   		}
	    if(!name.toLowerCase().match(/^[0-9^a-za-z]*$/)) {
	        alert(urmsg.noSpecialChar);
	        return false;
	    }
   	}else{
   		if(!name.toLowerCase().match(/^[0-9^a-za-z^.]*$/)) {
	        alert(urmsg.noSpecialChar);
	        return false;
	    }
   	}
    
   
    
    if(/.*[\u4e00-\u9fa5]+.*$/.test(name)){
    	alert(urmsg.noChineseChar)
    	return false;
    }
    return true;
}

// ���봰��
var height=110;
if(!isIE){
	height = 95
}
var win = new Ext.Window({
				layout: 'fit',
				width: 200,
				height: height,
				closeAction: 'hide',
				plain: true,
				shadow:false,
				autoScroll:true,
				modal: true,
				title:urmsg.dirName,
				items: new Ext.Panel({ 
				   id:'elDiv',         
				   autoHeight :true, 
				   autoWidth :true, 
				   border:false,
				   contentEl:'elDiv'
				   
				}),
				buttons:[{
					text:urmsg.submit,
					handler:submit
				},{
					text:urmsg.cancel,
					handler:cancel
				}]
})

//���봰��ȷ����ť
function submit(){
	//����Ŀ¼
	if(operate=='createdir'){
		//��֤Ŀ¼����
		newDir = $("#elId").val();
		if (checkFileName(newDir,'dir')){   
			var paras = "method=createDir&currentDir="+currentDir+"&newDir="+newDir;
			
			var result = doRequest(paras)
			if(!result["status"]){
				if(result["info"]==''){
					alert(urmsg.createDirFailure);
				}else{
					alert(result["info"]);
				}
			}else{
				reShowDir($("a[rel='"+currentDir+"']").parent(),escape($("a[rel='"+currentDir+"']").attr('rel').match( /.*\// )));
				$("#elDiv").hide();
				$("#elId").val('');
				win.hide();
			}
			
			
		}   
	}else if(operate=='renamedir'){ //������Ŀ¼
		newDir = $("#elId").val();
		if (checkFileName(newDir,'dir')){  
			if(rename(currentDir,newDir)){
				var paretnDir = currentDir.substring(0,currentDir.substring(0,currentDir.length-1).lastIndexOf("/")+1);
				
				reShowDir($("a[rel='"+paretnDir+"']").parent(),escape($("a[rel='"+paretnDir+"']").attr('rel').match( /.*\// )));
				$("#elDiv").hide();
				$("#elId").val('');
				win.hide();
			}
			
		}    
	}
}

//���봰�� ȡ����ť
function cancel(){
	$("#elDiv").hide();
	$("#elId").val('');
	win.hide();
	
}

/**
 * ����Ŀ¼
 */
function createDir(){
	operate='createdir'	
	$("#elDiv").show();
	$("#elId").val('');
	checkinput('elId','elIdSpan')
	win.show();
}

/**
 * ѡ���ļ�
 * @param {} filename
 */
function setFileChecked(filename){
	if(filename!=''){
		var index = mainPanel.grid.store.find('name',filename);
		if(index==-1){
			fileExist ='false';
		}else{
			sm.selectRow(mainPanel.grid.store.find('name',filename));
		}
	}

}

/**
 * ѡ���ļ�
 * @param {} sm
 * @param {} rowIndex
 * @param {} record
 * @return {Boolean}
 */
function onCheckFile(sm,rowIndex,record){

	checkedFile = currentDir+record.get('name');
	
	var extendname="";
	var pos=checkedFile.lastIndexOf(".");
	if(pos!=-1){
		extendname=checkedFile.substring(pos+1).toLowerCase();
		if(extendname=="jpg" ||extendname=="gif"||extendname=="png") {
			
			$("#divPreview").children().remove();
			$("#divPreview").append("<img id='previewImg'  src='"+checkedFile+"' align='absmiddle'>");
			
			if($("#previewImg").attr("width")>350){
				$("#previewImg").attr("width",350)
			}
			if($("#previewImg").attr("height")>120){
				$("#previewImg").attr("height",120)
				
			}
			return true;
		}		
	}
	$("#divPreview").children().remove();
	
}

/**
 * ȷ��
 */
function onSubmit(){
	window.parent.returnValue=checkedFile;
	window.parent.close();
}

/**
 * ȡ��
 */
function onCancel(){
	window.parent.returnValue="false";
	window.parent.close();
}

/**
 * ���
 */
function onClear(){
	checkedFile = "";
	window.parent.returnValue="";
	window.parent.close();
}

/**
 * ��ʾ�ϴ�����
 */
function showUpload(){
	Ext.getDom('uploadDiv').style.display='';
	Ext.getCmp("uploadPanel").show();
	viewport.doLayout();
}	

/**
 * �����ϴ�����
 */
function hideUpload(){
	Ext.getDom('uploadDiv').style.display='none';
	Ext.getCmp("uploadPanel").hide();
	viewport.doLayout();
}

/**
 * ɾ��Ŀ¼
 */
function deleteDir(){
	//�жϵ�ǰĿ¼�Ƿ���Ȩ��ɾ��
	if(!checkDirRight()){
		alert(urmsg.noRight);
		return false;
	}
	
	//ȷ��ɾ��
	if(isdel()){
		var paras = "method=deleteDir&currentDir="+currentDir;
		var result = doRequest(paras)
		
		if(!result["status"]){
			if(result["info"]==''){
				alert(urmsg.deleteFailure);
			}else{
				alert(result["info"]);
			}
			return false
		}else{
			var paretnDir = currentDir.substring(0,currentDir.substring(0,currentDir.length-1).lastIndexOf("/")+1);
			reShowDir($("a[rel='"+paretnDir+"']").parent(),escape($("a[rel='"+paretnDir+"']").attr('rel').match( /.*\// )));
			return true;
		}
	}
}

/**
 * ɾ���ļ�
 */
function deleteFile(){
	if(checkedFile==''){
		alert(urmsg.noSelect)
		return;
	}
	if(isdel()){
		var paras = "method=deleteFile&file="+checkedFile;
		
		var result = doRequest(paras)
		if(!result["status"]){
			if(result["info"]==''){
				alert(urmsg.deleteFailure);
			}else{
				alert(result["info"]);
			}
			return false
		}else{
			reShowDir($("a[rel='"+currentDir+"']").parent(),escape($("a[rel='"+currentDir+"']").attr('rel').match( /.*\// )));
			return true;
		}
	}
}

/**
 * ������Ŀ¼
 */
function renameDir(){
	//�жϵ�ǰĿ¼�Ƿ����������
	if(!checkDirRight()){
		alert(urmsg.noRight);
		return ;
	}
	operate='renamedir';
	var tmp = new Array();
	tmp = currentDir.split('/')	
	var dirName = tmp[tmp.length-2]
	$("#elId").val(dirName);
	$("#elDiv").show();
	checkinput('elId','elIdSpan')
	win.show();
}

/**
 * ������
 * @param {} oldName
 * @param {} newName
 * @return {Boolean}
 */
function rename(oldName,newName){
	
	var paras = "method=rename&currentDir="+currentDir+"&new="+newName+"&old="+oldName;
	var result = doRequest(paras)
	if(!result["status"]){
		if(result["info"]==''){
			alert(urmsg.renameFailure);
		}else{
			alert(result["info"]);
		}
		return false
	}else{
		return true;
	}
}

/**
 * Ajax ������
 * @param {} paras
 */
function doRequest(paras){	 
	var obj; 
    if (window.ActiveXObject) { 
        obj = new ActiveXObject('Microsoft.XMLHTTP'); 
    } 
    else if (window.XMLHttpRequest) { 
        obj = new XMLHttpRequest(); 
    } 
	obj.open('post', "/weaver/weaver.page.maint.common.UserResourceServlet"+'?'+paras, false); 
    obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
    obj.send(null); 
    if (obj.status == "200") {
    	var responesText = obj.responseText.trim();
    	responesText = "var _result = " +responesText;
    	eval(responesText)
    	return _result;
	} else {
		return {status:'false',info:''};
	}			
    
}

/**
 * �жϵ�ǰĿ¼Ȩ���Ƿ�ɱ༭
 */
function checkDirRight(){
	if(currentDir!="/page/resource/userfile/flash/"&&currentDir!="/page/resource/userfile/image/"
	&&currentDir!="/page/resource/userfile/video/"&&currentDir!="/page/resource/userfile/other/"){
		return true;
	}else{
		return false;
	}
}
