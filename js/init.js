function openFullWindow(url){
  var redirectUrl = url ;
  var width = screen.width ;
  var height = screen.height ;
  if (height == 768 ) height -= 75 ;
  if (height == 600 ) height -= 60 ;
  var szFeatures = "top=0," ; 
  szFeatures +="left=0," ;
  szFeatures +="width="+width+"," ;
  szFeatures +="height="+height+"," ; 
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
  szFeatures +="menubar=no," ;
  if (height <= 600 ) szFeatures +="scrollbars=yes," ;
  else szFeatures +="scrollbars=no," ;
  szFeatures +="resizable=yes" ; //channelmode
  window.open(redirectUrl,"",szFeatures) ;
}

function openFullWindowHaveBar(url){
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

function openFullWindowHaveBarForWFList(url,requestid){
	try{
		document.getElementById("wflist_"+requestid+"span").innerHTML = "";
	}catch(e){}
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

//Ϊ��ɾ��ʱ��
function openFullWindow1(url){
  var redirectUrl = url ;
  var width = screen.width ;
  var height = screen.height ;
  if (height == 768 ) height -= 75 ;
  if (height == 600 ) height -= 60 ;
  var szFeatures = "top="+height/2+"," ; 
  szFeatures +="left="+width/2+"," ; 
  szFeatures +="width=181," ;
  szFeatures +="height=129," ; 
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
  szFeatures +="menubar=no," ;
  if (height <= 600 ) szFeatures +="scrollbars=yes," ;
  else szFeatures +="scrollbars=no," ;
  szFeatures +="resizable=no" ; //channelmode
  window.open(redirectUrl,"",szFeatures) ;
}


function openFullWindowForXtable(url){
  var redirectUrl = url ;
  var width = screen.width ;
  var height = screen.height ;
  //if (height == 768 ) height -= 75 ;
  //if (height == 600 ) height -= 60 ;
  var szFeatures = "top=100," ; 
  szFeatures +="left=400," ;
  szFeatures +="width="+width/2+"," ;
  szFeatures +="height="+height/2+"," ; 
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
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

function setMenuDisabled(){
	var o, _disabled;
	switch(arguments.length){
		case 0 :
			o = window.frames["rightMenuIframe"].event.srcElement;
			_disabled = true;
			break;
		case 1 :
			o = arguments[0];
			_disabled = true;
			break;
		case 2 :
			o = arguments[0];
			_disabled = arguments[1];
			break;
	}
	o.disabled = _disabled;
}

/**
 * ���ݱ�ʶ��name����id����ȡԪ�أ���Ҫ���ڽ��ϵͳ�кܶ�Ԫ��û��id���ԣ�
 * ȴ��js��ʹ��document.getElementById(name)����ȡԪ�ص����⡣
 * @param identity name����id
 * @return Ԫ��
 */
function $GetEle(identity, _document) {
	var rtnEle = null;
	if (_document == undefined || _document == null) _document = document;
	
	rtnEle = _document.getElementById(identity);
	if (rtnEle == undefined || rtnEle == null) {
		rtnEle = _document.getElementsByName(identity);
		if (rtnEle.length > 0) rtnEle = rtnEle[0];
		else rtnEle = null;
	}
	return rtnEle;
}

function $G(identity, _document) {
	return $GetEle(identity, _document);
}

function $GetEles(identity) {
	var rtnEle = null;
	
	rtnEle = document.getElementsByName(identity);
	
	if (rtnEle.length == 1) {
		return rtnEle[0]; 
	} else if (rtnEle.length == 0) {
		return document.getElementById(identity);
	}
	return rtnEle;
}

var wuiUtil = {
	/**
	 * isNotNull Ŀ��ֵ��Ϊnull || undefined������true�����򷵻�false
	 */
	isNotNull: function (target) {
		if (target == undefined || target == null) {
			return false;
		}
		return true;
	}, 
	/**
	 * isNullOrEmpty Ŀ��ֵΪnull��undefined���գ�����true�����򷵻�false
	 */
	isNullOrEmpty : function (target) {
		if (target == undefined || target == null || target == "") {
			return true;
		}
		return false;
	}, 
	/**
	 * isNotEmpty Ŀ��ֵ��Ϊnull��undefined���գ�����true�����򷵻�false
	 */
	isNotEmpty : function (target) {
		if (target == undefined || target == null || target == "") {
			return false;
		}
		return true;
	},
	getJsonValueByIndex: function (josinobj, index) {
		var _index = 0;
		try {
			for(var key in josinobj){
				if (index == _index) {
					return josinobj[key]; 			
				}
				_index++;
			}
		} catch (e) {alert("browser return value is error!");}
		return "";
	}
};

//-----------------------------------------
// ѡ�����ת������ start
//-----------------------------------------
if (typeof(SYSTEM_SHOW_MODAL_DIALOG) == "undefined" && typeof(SYSTEM_SHOW_MODAL_DIALOG) != "fucntion") {
	//ϵͳģ̬����
	var SYSTEM_SHOW_MODAL_DIALOG = window.showModalDialog;
	if (window.showModalDialog == SYSTEM_SHOW_MODAL_DIALOG) {
		//��дϵͳģ̬����
		window.showModalDialog = function () {
			var url	= arguments[0];
			var parent = arguments[1];
			var dialogParent = arguments[2];

			if (!parent) {
				parent = "";
			}
			//ff�´��ڲ���������ͳһ����
			if (!dialogParent) {
				dialogParent = "dialogWidth:550px;dialogHeight:550px;" + "dialogTop:" + (window.screen.availHeight - 30 - parseInt(550))/2 + "px" + ";dialogLeft:" + (window.screen.availWidth - 10 - parseInt(550))/2 + "px" + ";";
			} else if (dialogParent != "" && dialogParent.indexOf("dialogTop") == -1) {
				dialogParent += ";dialogTop:" + (window.screen.availHeight - 30 - parseInt(550))/2 + "px" + ";dialogLeft:" + (window.screen.availWidth - 10 - parseInt(550))/2 + "px" + ";";
			}
			var returnValue;
			//����ϵͳģ̬���ڵ���function
			var rtnValue = SYSTEM_SHOW_MODAL_DIALOG(url, parent, dialogParent); 
			//ie��������õ���js��������ֵ��vb��ת����json
			if (window.ActiveXObject) {
				//����ֵ��vb
				if (rtnValue != undefined && rtnValue != null && typeof(rtnValue) == "unknown") {
					var func = window.showModalDialog.caller;
					//�жϵ���ģ̬�������Ƿ���js
					if (typeof(func) == "function") {
						var tempArray = new VBArray(rtnValue).toArray();
						var tempJsonData = "{";
						if (tempArray != null) {
							for (var i=0; i<tempArray.length; i++) {
								if (i == 0) {
									tempJsonData += "id:\"" + tempArray[i] + "\"";
								} else if (i == 1) {
									tempJsonData += "name:\"" + tempArray[i] + "\"";
								} else {
									tempJsonData += "key" + i + ":\"" + tempArray[i] + "\"";
								}
								
								if (i < tempArray.length - 1) {
									tempJsonData += ", ";
								}
							}
						}
						tempJsonData += "}";
						
						returnValue =  eval('(' + tempJsonData + ')');
						return returnValue;
					}
				} else if (typeof(rtnValue) == "object"){
					//alert(window.showModalDialog.caller.caller);
					var func = window.showModalDialog.caller;
					try {
						window.console.log("href:" + window.location.href);
						window.console.log("caller type:" + typeof(func));
						window.console.log("caller content:" + func);
					} catch (e) {}
					//�жϵ���ģ̬�������Ƿ���vb
					if ((typeof(func) == "function" && func.toString().indexOf("function onclick()") != -1) || typeof(func) == "object") {
						return string2VbArray(json2String(rtnValue));
					} else {
						var	regex = new RegExp("jsid[ ]{0,}=[ ]{0,}new VBArray[\(]id[\)].toArray[\(][\)]", "g"); // ����������ʽ����  
						var r = func.toString().match(regex);
					���� if (r != null && r != undefined && r != "") {
						 	return string2VbArray(json2String(rtnValue));
					 	}
					}
				}
			}
			return rtnValue;
		};
	}
}

function json2String(josinobj) {
	if (josinobj == undefined || josinobj == null) {
		return "";
	}
	var ary = "";
	var _index = 0;
	try {
		for(var key in josinobj){
			if (_index++ > 0) {
				ary += "(~!@#$%^&*)";
			}
			ary += josinobj[key];
		}
	} catch (e) {}
	return ary;
}
//-----------------------------------------
//ѡ�����ת������ END
//-----------------------------------------

