var viewport;
var pageToolBar;
var grid;
var tabPanel;
var ishidden = false;
try
{
	var isinit = document.getElementById("isinit").value;
	if(isinit=="true")
	{
		ishidden = true;
	}
}
catch(e)
{
}
Ext.onReady(function() {
    grid = new wfSearchGrid();
    tabPanel = {
    	id:'wfsearchtab',
    	xtype:'panel',
    	activeTab: 0,	
		margins: '2 8 5 5',
		region: 'center',
		layout:'fit',
        resizeTabs: true,
        tabWidth: 150,
        minTabWidth: 120,
        enableTabScroll: true,  
        items: [
        	{
        	 layout: 'border',
        	 //title:'<img src="/images/wf/list.gif" align=absMiddle>&nbsp;'+wmsg.wf.list,
        	 items:[grid]
        	}
		]
    };
    
    search();
    	
	viewport= new Ext.Viewport({
        layout: 'border',
        items: [panelTitle, tabPanel]
    });
    Ext.get('loading').fadeOut();
});

wfSearchGrid = function(viewer, config){
	var checkboxPlugin = new Ext.ux.plugins.CheckBoxMemory({hdID:'hdCheckBox'});
    this.viewer = viewer;
    Ext.apply(this, config);
    this.id = TableBaseParas.gridId;
    this.store =new Ext.data.Store({				
		proxy : new Ext.data.HttpProxy({
			method : 'POST',			
			url : gridUrl
		}),		
		reader : new Ext.data.JsonReader({
			root : 'data',
			totalProperty : 'totalCount',
			id : 'id',
			fields : getColumnFields(TableBaseParas)
		}),		
		remoteSort : true
	});	
	this.store.setDefaultSort(TableBaseParas.sort, TableBaseParas.dir);
	/*
	this.tbar = [
					{id:'open',
		            text: wmsg.wf.openChosenWf,
		            tooltip: {
		                text: wmsg.wf.openChosenWf
		            },
		            iconCls: 'btn_doOpen',
		            handler: openSelecteds,
		            scope: this}
		            ];
		            */
	this.stripeRows=true;
    var sm = new  Ext.grid.CheckboxSelectionModel({header:'<div id="hdCheckBox" class="x-grid3-hd-checker">&#160;</div>',handleMouseDown: Ext.emptyFn});
    this.cm= new Ext.grid.ColumnModel([new Ext.grid.RowNumberer()].concat(sm).concat(TableBaseParas.columns));	
    this.columns =new Ext.grid.ColumnModel([new Ext.grid.RowNumberer()].concat(sm).concat(colsTableBaseParas));	
    pageToolBar = new Ext.PagingToolbar({
        pageSize: TableBaseParas.pageSize,
        store: this.store,
        displayInfo: true,
        displayMsg: wmsg.grid.gridDisp1 + '{0} - {1}' + wmsg.grid.gridDisp2
				+ '{2}' + wmsg.grid.gridDisp3,
        emptyMsg: wmsg.grid.noItem
        
    });
    this.bbar = pageToolBar;
    
    wfSearchGrid.superclass.constructor.call(this, {
    	border:false,
    	style:'border-top:1px solid  #D0D0D0',
        region: 'center',        
        loadMask: {
            msg: wmsg.grid.loadMask
        },        
        sm: sm,    
        plugins:[checkboxPlugin],
        stripeRows: true,    
        viewConfig: {
            forceFit: true
        }
    });

     
};
Ext.extend(wfSearchGrid, Ext.grid.GridPanel, {
	
    loadwfTree: function(paras){ 
    	var url = '/workflow/request/ext/GridExtProxy.jsp';
    	
        Ext.Ajax.request({
					url : url+'?'+paras , 
					params : {
								 paras: paras,
								 columns:Ext.util.JSON.encode(TableBaseParas.columns)
							 },
					method: 'POST',
					success: function ( result, request) {
					
						eval(result.responseText);
						TableBaseParas.columns = allColumns;
						grid.store.baseParams={
				    		paras: paras,
							TableBaseParas : Ext.util.JSON.encode(TableBaseParas)			
						};						
						
						grid.store.reload({
							params : {
								start:0,
								limit:TableBaseParas.pageSize
							}
						});																	
					},
					failure: function ( result, request) { 
						Ext.MessageBox.alert('Failed', 'Successfully posted form: '+result); 
					} 
				});		
    	},
    formatTitle: function(value, p, record){
        return String.format('<div class="topic"><b>{0}</b><span class="author">{1}</span></div>', value, record.data.author, record.id, record.data.forumid);
    }
});


function getColumnFields(TableBaseParas) {
	var strFields = new Array();
	var tableColumns = TableBaseParas.columns;

	for (var i = 0; i < tableColumns.length; i++) {	   
		strFields = strFields.concat( tableColumns[i].dataIndex);
		
	}
	return strFields.concat(multiSubmit.dataIndex);
}

function loadGrid(paras){
	
	grid.loadwfTree(paras);
}


function firstPage(){
	//pageToolBar.onClick("first");//EXT2.0
	pageToolBar.moveFirst();//EXT3.0
	var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
	//���ǹ���Ա�û���¼ϵͳʱ��tbodyIframeΪnull���ʼӴ��жϡ�
	if(tbodyIframe != null){
		if(tbodyIframe.cells != undefined) {
			for(var i = 0; i < tbodyIframe.cells.length; i++) {
				var val = tbodyIframe.cells[i].outerHTML;
				if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = true;
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = true;
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = '';
				}
				if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = '';
				}
			}
		}else{
			for(var i = 0; i < tbodyIframe.children.length; i++) {
				var val = tbodyIframe.children[i].outerHTML;
				if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = true;
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = true;
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = '';
				}
				if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = '';
				}
			}
		}
	}
}

function prePage() {
	var newPages=parseInt(pageToolBar.el.dom.getElementsByTagName("input")[0].value);
	var message=pageToolBar.el.dom.getElementsByTagName("div")[1].innerHTML;
	var pageNums;
	if(readCookie("languageidweaver")==8) {
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('of')+2)));    // of ��ҳ��
	}else if(readCookie("languageidweaver")==9) {
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('�'))));
	}else{
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('ҳ'))));
	}
	
	if(pageToolBar.items.get(1).disabled==false){
		newPages--;
		//pageToolBar.onClick("prev");//EXT2.0
		pageToolBar.movePrevious();//EXT3.0
	}
	
	var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
	//���ǹ���Ա�û���¼ϵͳʱ��tbodyIframeΪnull���ʼӴ��жϡ�
	if(tbodyIframe != null){
		if(tbodyIframe.cells != undefined) {
			if(newPages==1){		
				for(var i = 0; i < tbodyIframe.cells.length; i++) {
					var val = tbodyIframe.cells[i].outerHTML;
					if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = true;
					}
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = true;
					}
				}
			}
			if(newPages<pageNums){
				for(var i = 0; i < tbodyIframe.cells.length; i++) {
					var val = tbodyIframe.cells[i].outerHTML;
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = '';
					}
					if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = '';
					}
				}
			}
		}else{
			if(newPages==1){		
				for(var i = 0; i < tbodyIframe.children.length; i++) {
					var val = tbodyIframe.children[i].outerHTML;
					if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = true;
					}
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = true;
					}
				}
			}
			
			if(newPages<pageNums){
				for(var i = 0; i < tbodyIframe.children.length; i++) {
					var val = tbodyIframe.children[i].outerHTML;
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = '';
					}
					if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = '';
					}
				}
			}
		}
	}
}
function nextPage() {
	var newPages=parseInt(pageToolBar.el.dom.getElementsByTagName("input")[0].value);
	var message=pageToolBar.el.dom.getElementsByTagName("div")[1].innerHTML;
	var pageNums;
	if(readCookie("languageidweaver")==8) {
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('of')+2)));     // of ��ҳ��
	}else if(readCookie("languageidweaver")==9) {
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('�'))));
	}else{
		pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('ҳ'))));
	}
	
	if(pageToolBar.items.get(7).disabled==false){
		newPages++;
		//pageToolBar.onClick("next");//EXT2.0
		pageToolBar.moveNext();//EXT3.0
	}

	var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
	//���ǹ���Ա�û���¼ϵͳʱ��tbodyIframeΪnull���ʼӴ��жϡ�
	if(tbodyIframe != null){
		if(tbodyIframe.cells != undefined) {
			if(newPages>=pageNums){
				for(var i = 0; i < tbodyIframe.cells.length; i++) {
					var val = tbodyIframe.cells[i].outerHTML;
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = true;
					}
					if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = true;
					}
				}
			}
			
			if(newPages>1){		
				for(var i = 0; i < tbodyIframe.cells.length; i++) {
					var val = tbodyIframe.cells[i].outerHTML;
					if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = '';
					}
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
						var button = tbodyIframe.cells[i].children[0];
						button.disabled = '';
					}
				}
			}
		}else{
			if(newPages>=pageNums){
				for(var i = 0; i < tbodyIframe.children.length; i++) {
					var val = tbodyIframe.children[i].outerHTML;
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = true;
					}
					if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = true;
					}
				}
			}
			
			
			if(newPages>1){		
				for(var i = 0; i < tbodyIframe.children.length; i++) {
					var val = tbodyIframe.children[i].outerHTML;
					if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = '';
					}
					if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
						var button = tbodyIframe.children[i];
						button.disabled = '';
					}
				}
			}
		}
	}
}
function lastPage() {
	//pageToolBar.onClick("last");//EXT2.0
	pageToolBar.moveLast();//EXT3.0
	var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
	//���ǹ���Ա�û���¼ϵͳʱ��tbodyIframeΪnull���ʼӴ��жϡ�
	if(tbodyIframe != null){
		if(tbodyIframe.cells != undefined) {
			for(var i = 0; i < tbodyIframe.cells.length; i++) {
				var val = tbodyIframe.cells[i].outerHTML;
				if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = '';
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = '';
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = true;
				}
				if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
					var button = tbodyIframe.cells[i].children[0];
					button.disabled = true;
				}
			}
		}else{
			for(var i = 0; i < tbodyIframe.children.length; i++) {
				var val = tbodyIframe.children[i].outerHTML;
				if(val.indexOf("��ҳ") > 0 || val.indexOf("���") > 0 || val.indexOf("first page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = '';
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Front Page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = '';
				}
				if(val.indexOf("��һҳ") > 0 || val.indexOf("��һ�") > 0 || val.indexOf("Next Page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = true;
				}
				if(val.indexOf("βҳ") > 0 || val.indexOf("β�") > 0 || val.indexOf("last page") > 0) {
					var button = tbodyIframe.children[i];
					button.disabled = true;
				}
			}
		}
	}
}
function reLoad() {
	//pageToolBar.onClick("refresh");//EXT2.0
	pageToolBar.refresh();//EXT3.0
}

function openWfToTab(url,title){
	/*url+'&isfromtab=true';	
	Ext.getCmp('wfsearchtab').add({		
         title: '<img src="/images/wf/topic.gif" align=absMiddle>&nbsp;'+title,
         tabTip: title,
         html: "<IFRAME  SRC='"+url+"'  style='width:100%;height:100%'  BORDER=0 FRAMEBORDER=no NORESIZE=NORESIZE scrolling='auto'></IFRAME>",
         closable: true,
         autoScroll: true
		
	});*/
	openFullWindowHaveBar(url);
}

function openSelecteds(){
    	var records=grid.plugins[0].getSelection();
    	records = records.split(',');
    	records.length = records.length-1;
    	if(records.length>10){
    		if(confirm(wmsg.wf.openChosenWfSuggestion)!=true){
    			return;
    		}   		
    	}
    	for(var i=0;i<records.length;i++){	
	    	var url = '/workflow/request/ViewRequest.jsp'
	    	url = url+'?requestid='+records[i];  
	    	url=url+'&isovertime=0';    	
	    	/*var title = records[i].get('requestname');
	    	var strArray=new Array();   
	    	strArray=title.split(",");   
	    	title = strArray[1];
	    	strArray = title.split("'");
	    	title = strArray[1];
	    	title =title.replace(new RegExp('&lt;','gm'),'<');
	    	title =title.replace(new RegExp('&gt;','gm'),'>');*/
	    	openWfToTab(url,'');
    	}
}

Table = function(){
	return{
		reLoad : function(){
			reLoad();
		}
	}
}
_table = new Table();
