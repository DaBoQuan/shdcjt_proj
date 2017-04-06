//Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
Ext.namespace('Weaver');
Weaver.WeaverTableExt2 = function(config,tbar) {
	var getColumnFields=function(config) {
		var strFields = new Array();
		var tableColumns = config.TableBaseParas.columns;
		for (var i = 0; i < tableColumns.length; i++)
			strFields = strFields.concat(tableColumns[i].column);
		return strFields;
	}
	
	var store = new Ext.data.Store({
		baseParams : {
			TableBaseParas : Ext.util.JSON.encode(config.TableBaseParas)
			
		},	
		proxy : new Ext.data.HttpProxy({
			method : 'POST',
			timeout:180000,
			url : '/weaver/weaver.common.util.taglib.SplitPageXmlServletNew'
		}), 
		reader : new Ext.data.JsonReader({
			root : 'data',
			totalProperty : 'totalCount',
			id : 'id',
			fields : getColumnFields(config)
		}),
		remoteSort : true
	});
	
	store.setDefaultSort(config.TableBaseParas.sort, config.TableBaseParas.dir);

	var bbar = new Ext.PagingToolbar({
		pageSize : config.TableBaseParas.pageSize,
		store : store,
		displayInfo : true,
		displayMsg : wmsg.grid.gridDisp1 + '{0} - {1}' + wmsg.grid.gridDisp2
				+ '{2}' + wmsg.grid.gridDisp3,
		emptyMsg : wmsg.grid.noItem
	});

	var columns = config.TableBaseParas.columns;

	var sm = new Ext.grid.RowSelectionModel({handleMouseDown: Ext.emptyFn});
	// ��ҪCheckbox
	if (config.gridType == "checkbox") {
		sm= new  Ext.grid.CheckboxSelectionModel({header:'<div id="hdCheckBox" class="x-grid3-hd-checker">&#160;</div>',handleMouseDown: Ext.emptyFn});
		columns = [sm].concat(columns);
		
	}

	// �����Ҫ�к�
	//if (config.isNeedRowNumber == true) {
	if (false) {
		columns = [new Ext.grid.RowNumberer()].concat(columns);
	}
	var gridHeight = config.TableBaseParas.pageSize * config.columnWidth + 60;
	var cm = new Ext.grid.ColumnModel(columns);
	cm.defaultSortable = true;
	Ext.override(Ext.grid.GridView, {
		templates : {
			cell : new Ext.Template(
					'<td class="x-grid3-col x-grid3-cell x-grid3-td-{id} {css}" style="{style}" tabIndex="0" {cellAttr}>',
					'<div class="x-grid3-cell-inner x-grid3-col-{id}" {attr}>{value}</div>',
					"</td>")
		}
	});
	
	var grid;
	if(tbar=="[]"||tbar==""){
		grid = new Ext.grid.GridPanel({
			id : config.tableId,
			title : config.title,
			store : store,
			cm : cm,
			trackMouseOver : true,
			autoSizeColumns : true,
			sm : sm,
			plugins: config.gridType == "checkbox"?[ new Ext.ux.plugins.CheckBoxMemory({hdID:'hdCheckBox'})]:null,
			stripeRows : true,
			loadMask : true,
			viewConfig : {
				forceFit : true,
				emptyText : wmsg.grid.noItem
			},
			bbar : bbar
		});		
	} else {		
		grid = new Ext.grid.GridPanel({
			id : config.tableId,
			title : config.title,
			store : store,
			cm : cm,
			trackMouseOver : true,
			autoSizeColumns : true,
			sm : sm,
			plugins: config.gridType == "checkbox"?[ new Ext.ux.plugins.CheckBoxMemory({hdID:'hdCheckBox'})]:null,
			stripeRows : true,
			loadMask : true,
			viewConfig : {
				forceFit : true,
				emptyText : wmsg.grid.noItem
			},
			tbar : eval(tbar),
			bbar : bbar
		});
	}
	return {
		load:function(){
			store.reload({
				params : {
					start : 0,
					limit : config.TableBaseParas.pageSize
				}
			});
		},
		
		getGrid:function(title){
			grid.setTitle(title);
			return grid;
		},
		init : function() {

		},	
		getGridWidth : function() {
			return grid.width;
		},
		setGridWidth : function(newWidth) {
			grid.setWidth(newWidth);
		},
		firstPage : function() {		
			bbar.moveFirst();
			var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
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
		},
		prePage : function() {
			var newPages=parseInt(bbar.el.dom.getElementsByTagName("input")[0].value);
			var message=bbar.el.dom.getElementsByTagName("div")[1].innerHTML;
			var pageNums;
			if(readCookie("languageidweaver")==8) {
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('of')+2)));   // of ��ҳ��
			}else if(readCookie("languageidweaver")==9) {
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('�'))));
			}else{
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('ҳ'))));
			}
			
			if(bbar.items.get(1).disabled==false){
				newPages--;
				bbar.movePrevious();
			}
			var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
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
		},
		nextPage : function() {	
			var newPages=parseInt(bbar.el.dom.getElementsByTagName("input")[0].value);
			var message=bbar.el.dom.getElementsByTagName("div")[1].innerHTML;
			var pageNums;
			if(readCookie("languageidweaver")==8) {
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('of')+2)));    // of ��ҳ��
			}else if(readCookie("languageidweaver")==9) {
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('�'))));
			}else{
				pageNums=parseInt(message.substring(parseInt(message.lastIndexOf('��')+1),parseInt(message.lastIndexOf('ҳ'))));
			}
				
			if(bbar.items.get(7).disabled==false){
				newPages++;
				bbar.moveNext();
			}
			var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
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
		},
		lastPage : function() {			
			bbar.moveLast();
			var tbodyIframe = window.frames["rightMenuIframe"].document.getElementById("menuTable");
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
		
		},
		reLoad : function() {
			bbar.doLoad(bbar.cursor);
		},
		_xtable_CheckedCheckboxId : function() {
			return grid.plugins[0].getSelection();
		},
		setConfig:function(newConfig){
			config = newConfig;
			
		}
	}
	
}