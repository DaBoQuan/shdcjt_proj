<%@ page language="java" contentType="text/html; charset=GBK" %>
<script type="text/javascript">
<!--
function onSelectMainDocument(){
	data = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if(data){
		if(data.id!=""){
			spanMainDocument.innerHTML = data.name;
			weaver.maindoc.value=data.id;
	    }else{
			spanMainDocument.innerHTML = "";
			weaver.maindoc.value = -1;
		}
	}
}

function onShowResource(){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (data){
	    if (data.id!=""){
			owneridspan.innerHTML = "<a href='javaScript:openhrm("+wuiUtil.getJsonValueByIndex(data,0)+");' onclick='pointerXY(event);'>"+wuiUtil.getJsonValueByIndex(data,1)+"</a>"
			weaver.ownerid.value=wuiUtil.getJsonValueByIndex(data,0)
			docdepartmentidspan.innerHTML = "<a href='/hrm/company/HrmDepartmentDsp.jsp?id="+wuiUtil.getJsonValueByIndex(data,2)+"'>"+wuiUtil.getJsonValueByIndex(data,3)+"</a>"
			weaver.docdepartmentid.value=wuiUtil.getJsonValueByIndex(data,2)
	    }else{
			owneridspan.innerHTML = " <IMG src='/images/BacoError.gif' align=absMiddle>"
			weaver.ownerid.value=""
			docdepartmentidspan.innerHTML = " <IMG src='/images/BacoError.gif' align=absMiddle>"
			weaver.docdepartmentid.value=""
	    }
	}
}
function onShowLanguage(){
	data = window.showModalDialog("/systeminfo/language/LanguageBrowser.jsp")
	language.innerHTML = data.name
	weaver.doclangurage.value=data.id
}

function onShowResourceConditionBrowser(id, url, linkurl, type1, ismand) {

	var tmpids = $GetEle("customfield" + id).value;
	var dialogId = window.showModalDialog(url + "?resourceCondition=" + tmpids);
	if (wuiUtil.isNotEmpty(dialogId)) {
		if (wuiUtil.getJsonValueByIndex(dialogId, 0) != "") {
			var shareTypeValues = wuiUtil.getJsonValueByIndex(dialogId, 0);
			var shareTypeTexts = wuiUtil.getJsonValueByIndex(dialogId, 1);
			var relatedShareIdses = wuiUtil.getJsonValueByIndex(dialogId, 2);
			var relatedShareNameses = wuiUtil.getJsonValueByIndex(dialogId, 3);
			var rolelevelValues = wuiUtil.getJsonValueByIndex(dialogId, 4);
			var rolelevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 5);
			var secLevelValues = wuiUtil.getJsonValueByIndex(dialogId, 6);
			var secLevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 7);

			var sHtml = "";
			var fileIdValue = "";
			shareTypeValues = shareTypeValues.substr(1);
			shareTypeTexts = shareTypeTexts.substr(1);
			relatedShareIdses = relatedShareIdses.substr(1);
			relatedShareNameses = relatedShareNameses.substr(1);
			rolelevelValues = rolelevelValues.substr(1);
			rolelevelTexts = rolelevelTexts.substr(1);
			secLevelValues = secLevelValues.substr(1);
			secLevelTexts = secLevelTexts.substr(1);

			var shareTypeValueArray = shareTypeValues.split("~");
			var shareTypeTextArray = shareTypeTexts.split("~");
			var relatedShareIdseArray = relatedShareIdses.split("~");
			var relatedShareNameseArray = relatedShareNameses.split("~");
			var rolelevelValueArray = rolelevelValues.split("~");
			var rolelevelTextArray = rolelevelTexts.split("~");
			var secLevelValueArray = secLevelValues.split("~");
			var secLevelTextArray = secLevelTexts.split("~");
			for ( var _i = 0; _i < shareTypeValueArray.length; _i++) {

				var shareTypeValue = shareTypeValueArray[_i];
				var shareTypeText = shareTypeTextArray[_i];
				var relatedShareIds = relatedShareIdseArray[_i];
				var relatedShareNames = relatedShareNameseArray[_i];
				var rolelevelValue = rolelevelValueArray[_i];
				var rolelevelText = rolelevelTextArray[_i];
				var secLevelValue = secLevelValueArray[_i];
				var secLevelText = secLevelTextArray[_i];

				fileIdValue = fileIdValue + "~" + shareTypeValue + "_"
						+ relatedShareIds + "_" + rolelevelValue + "_"
						+ secLevelValue;

				if (shareTypeValue == "1") {
					sHtml = sHtml + "," + shareTypeText + "("
							+ relatedShareNames + ")";
				} else if (shareTypeValue == "2") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18941, user.getLanguage())%>";
				} else if (shareTypeValue == "3") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18942, user.getLanguage())%>";
				} else if (shareTypeValue == "4") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(3005, user.getLanguage())%>="
							+ rolelevelText
							+ "  <%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18945, user.getLanguage())%>";
				} else {
					sHtml = sHtml
							+ ","
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18943, user.getLanguage())%>";
				}

			}

			fileIdValue = fileIdValue + "~" + shareTypeValues + "_"
					+ relatedShareIdses + "_" + rolelevelValues + "_"
					+ secLevelValues;

			if (shareTypeValues == "1") {
				sHtml = sHtml + "," + shareTypeTexts + "("
						+ relatedShareNameses + ")";
			} else if (shareTypeValues == "2") {
				sHtml = sHtml
						+ ","
						+ shareTypeTexts
						+ "("
						+ relatedShareNameses
						+ ")"
						+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
						+ secLevelValues
						+ "<%=SystemEnv.getHtmlLabelName(18941, user.getLanguage())%>";
			} else if (shareTypeValues == "3") {
				sHtml = sHtml
						+ ","
						+ shareTypeTexts
						+ "("
						+ relatedShareNameses
						+ ")"
						+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
						+ secLevelValues
						+ "<%=SystemEnv.getHtmlLabelName(18942, user.getLanguage())%>";
			} else if (shareTypeValues == "4") {
				sHtml = sHtml
						+ ","
						+ shareTypeTexts
						+ "("
						+ relatedShareNameses
						+ ")"
						+ "<%=SystemEnv.getHtmlLabelName(3005, user.getLanguage())%>="
						+ rolelevelTexts
						+ "  <%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
						+ secLevelValues
						+ "<%=SystemEnv.getHtmlLabelName(18945, user.getLanguage())%>";
			} else {
				sHtml = sHtml
						+ ","
						+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
						+ secLevelValues
						+ "<%=SystemEnv.getHtmlLabelName(18943, user.getLanguage())%>";
			}
			sHtml = sHtml.substr(1);
			fileIdValue = fileIdValue.substr(1);

			$GetEle("customfield" + id).value = fileIdValue;
			$GetEle("customfield" + id + "span").innerHTML = sHtml;
		}
	} else {
		if (ismand == 0) {
			$GetEle("customfield" + id + "span").innerHTML = "";
		} else {
			$GetEle("customfield" + id + "span").innerHTML = "<img src='/images/BacoError.gif' align=absmiddle>";
		}
		$GetEle("customfield" + id).value = "";
	}
}

function onShowBrowser(id,url,linkurl,type1,ismand){
	if(type1== 2 || type1 == 19){
		id1 = window.showModalDialog(url)
		document.all("customfield"+id+"span").innerHTML = id1.name
		document.all("customfield"+id).value=id1.id
	}else if(type1 == 141){
		onShowResourceConditionBrowser(id,url,linkurl,type1,ismand);
	}else{
		if(type1==143){
			tmpids = document.all("customfield"+id).value;
			id1 = window.showModalDialog(url+"?treeDocFieldIds="+tmpids);
		}else if(type1 != 171 && type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=142 && type1!=152 && type1!=168 && type1!=4 && type1!=167 && type1!=164 && type1!=169 && type1!=170 && type1!=162){
			id1 = window.showModalDialog(url);
		}else if(type1==142){
			tmpids = document.all("customfield"+id).value
			id1 = window.showModalDialog(url+"?receiveUnitIds="+tmpids);
		}else if(type1==4 || type1==167 || type1==164 || type1==169 || type1==170){
			tmpids = document.all("customfield"+id).value
			id1 = window.showModalDialog(url+"?selectedids="+tmpids)
		}else if(type1==162){
			tmpids = document.all("customfield"+id).value;
			url = url + "&beanids=" + tmpids;
			url = url.substring(0, url.indexOf("url=") + 4) + escape(url.substr(url.indexOf("url=") + 4));
			id1 = window.showModalDialog(url);
		}else{
			tmpids = document.all("customfield"+id).value
			id1 = window.showModalDialog(url+"?resourceids="+tmpids)
		}

		if(id1){
			if(type1 == 171 || type1 == 17 || type1 == 18 || type1==27 || type1==37 || type1==56 || type1==57 || type1==65 || type1 == 142 || type1 == 168 || type1 == 166){
				if(id1.id!=0 && id1.id!=""){
					resourceids = id1.id
					resourcename = id1.name
					sHtml = ""
					resourceids = resourceids.substr(1);
					resourcename = resourcename.substr(1);
					//resourceids = Mid(resourceids,2,len(resourceids))
					document.all("customfield"+id).value= resourceids
					//resourcename = Mid(resourcename,2,len(resourcename))
					resourceids = resourceids.split(",");
					resourcename = resourcename.split(",");
					for(var i=0;i<resourceids.length;i++){
						if(resourceids[i]!=""){
							sHtml = sHtml+"<a href="+linkurl+resourceids[i]+">"+resourcename[i]+"</a>&nbsp"
						}
					}
					
					//sHtml = sHtml+"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("customfield"+id+"span").innerHTML = sHtml
					
				}else{
					if (ismand==0){
						document.all("customfield"+id+"span").innerHTML = "";
					}else{
						document.all("customfield"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					}
					document.all("customfield"+id).value=""
					
				}
			}else if(type1 == 152){
				if(id1.id!=0 && id1.id!=""){
					resourceids = id1.id
					resourcename = id1.name
					sHtml = ""
					resourceids = resourceids.substr(1);
					resourcename = resourcename.substr(1);
					//resourceids = Mid(resourceids,2,len(resourceids))
					document.all("customfield"+id).value= resourceids
					//resourcename = Mid(resourcename,2,len(resourcename))
					resourceids = resourceids.split(",");
					resourcename = resourcename.split(",");
					for(var i=0;i<resourceids.length;i++){
						if(resourceids[i]!=""){
							sHtml = sHtml+"<a href="+linkurl+resourceids[i]+">"+resourcename[i]+"</a>&nbsp"
						}
					}
					
					//sHtml = sHtml+"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("customfield"+id+"span").innerHTML = sHtml
				}else{
					if (ismand==0){
						document.all("customfield"+id+"span").innerHTML = "";
					}else{
						document.all("customfield"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					}
					document.all("customfield"+id).value=""
				}
			}else if(type1 == 143){
				if(id1.id!=0 && id1.id!=""){
					resourceids = id1.id
					resourcename = id1.name
					sHtml = ""
					resourceids = resourceids.substr(1);
					resourcename = resourcename.substr(1);
					//resourceids = Mid(resourceids,2,len(resourceids))
					document.all("customfield"+id).value= resourceids
					//resourcename = Mid(resourcename,2,len(resourcename))
					resourceids = resourceids.split(",");
					resourcename = resourcename.split(",");
					for(var i=0;i<resourceids.length;i++){
						if(resourceids[i]!=""){
							sHtml = sHtml+"<a href="+linkurl+resourceids[i]+">"+resourcename[i]+"</a>&nbsp"
						}
					}
					
					//sHtml = sHtml+"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("customfield"+id+"span").innerHTML = sHtml
				}else{
					if (ismand==0){
						document.all("customfield"+id+"span").innerHTML = "";
					}else{
						document.all("customfield"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					}
					document.all("customfield"+id).value=""
				}
		
			}else{
				if(id1.id!=0 && id1.id!=""){

	               if (type1 == 162) {
				   		var ids = id1.id;
						var names =  id1.name;
						var descs =  id1.key3;
						sHtml = ""
						ids = ids.substr(1);
						document.all("customfield"+id).value= ids;
						
						names = names.substr(1);
						descs = descs.substr(1);
						var idArray = ids.split(",");
						var nameArray = names.split(",");
						var descArray = descs.split(",");
						for (var _i=0; _i<idArray.length; _i++) {
							var curid = idArray[_i];
							var curname = nameArray[_i];
							var curdesc = descArray[_i];
							sHtml += "<a title='" + curdesc + "' >" + curname + "</a>&nbsp";
						}
						
						document.all("customfield" + id + "span").innerHTML = sHtml;
						return;
	               }
				   if (type1 == 161) {
					   	var ids = id1.id;
					   	var names = id1.name;
						var descs =  id1.desc;
						document.all("customfield"+id).value = ids;
						sHtml = "<a title='" + descs + "'>" + names + "</a>&nbsp";
						document.all("customfield" + id + "span").innerHTML = sHtml;
						return ;
				   }

					 if (linkurl == ""){
						document.all("customfield"+id+"span").innerHTML = id1.name
					 }else{
						document.all("customfield"+id+"span").innerHTML = "<a href="+linkurl+id1.id+">"+id1.name+"</a>"
					 }
					document.all("customfield"+id).value=id1.id
				}else{
					if (ismand==0){
						document.all("customfield"+id+"span").innerHTML = "";
					}else{
						document.all("customfield"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					}
					document.all("customfield"+id).value=""
				}

			}
		}
	}
}


function onShowHrmresID(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (data){
		if (data.id!=""){
			hrmresspan.innerHTML = "<A href='javaScript:openhrm("+data.id+");' onclick='pointerXY(event);'>"+data.name+"</A>"
			weaver.hrmresid.value=data.id

		}else{
			if (objval=="2"){
				hrmresspan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				hrmresspan.innerHTML =""
			}
			weaver.hrmresid.value=""
		}
	}
}



function onShowAssetId(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp")
	if (data){
		if(data.id!=""&&data.id!=0){
		assetidspan.innerHTML = "<A href='/cpt/capital/CapitalBrowser.jsp?id="+data.id+"'>"+data.name+"</A>"
		weaver.assetid.value=data.id
		}else{
			if (objval=="2") {
					assetidspan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				assetidspan.innerHTML =""
			}
		//weaver.assetid.value="0"
			weaver.assetid.value=""
		}
	}
}

function onShowCrmID(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (data){
		if (data.id!=""){
			crmidspan.innerHTML = "<A href='/CRM/data/ViewCustomer.jsp?CustomerID="+data.id+"'>"+data.name+"</A>"
			weaver.crmid.value=data.id
		}else{
			if (objval=="2") {
					crmidspan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				crmidspan.innerHTML =""
			}
			//weaver.crmid.value="0"
			weaver.crmid.value=""
		}
	}
}
function onShowItemID(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/asset/LgcAssetBrowser.jsp")
	if (data) {
		if (data.id!=""){
			itemspan.innerHTML = "<A href='/lgc/asset/LgcAsset.jsp?paraid="+data.id+"'>"+data.name+"</A>"
			weaver.itemid.value=data.id
		}else{
			if(objval=="2"){
				itemspan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				itemspan.innerHTML =""
			}
			//weaver.itemid.value="0"
			weaver.itemid.value=""
		}
	}
}

function onShowItemmaincategoryID(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/maintenance/LgcAssortmentBrowserAll.jsp")
	if (data){
		if (data.id!=""){
		itemmaincategorypan.innerHTML = data.name
		weaver.itemmaincategoryid.value=data.id
		}else{
			if (objval=="2"){
				itemmaincategorypan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				itemmaincategorypan.innerHTML =""
			}
		//weaver.itemmaincategoryid.value="0"
			weaver.itemmaincategoryid.value=""
		}
	}
}
function onShowProjectID(objval){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if (data){
		if (data.id!=""){
		projectidspan.innerHTML = "<A href='/proj/data/ViewProject.jsp?ProjID="+data.id+"'>"+data.name+"</A>"
		weaver.projectid.value=data.id
		}else{
			if (objval=="2"){
				projectidspan.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			}else{
				projectidspan.innerHTML =""
			}
			//weaver.projectid.value="0"
			weaver.projectid.value=""
		}
	}
}
function onShowMutiDummy(input,span){	
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/DocTreeDocFieldBrowserMulti.jsp?para="+input.value)
	if(data){
	    if (data.id!=""){
	    	var ids = data.id.substring(1);
		    var names = data.name.substring(1);
			dummyidArray=ids.split(",");
			dummynames=names.split(",");
			//dummyLen=ubound(dummyidArray)-lbound(dummyidArray) 
			var sHtml="";
			
			for(var k=0;k<dummyidArray.length;k++){
				sHtml = sHtml+"<a href='/docs/docdummy/DocDummyList.jsp?dummyId="+dummyidArray[k]+"'>"+dummynames[k]+"</a>&nbsp"
			}
			
			$(input).val(ids);
			$(span).html(sHtml);
	    }else{			
	    	$(input).val("");
			$(span).html("");
	    }
	}
}
//-->
</script>

<script language=javascript>
function checkDocMain(){
	if(document.weaver.docpublishtype!=null&&document.weaver.docpublishtype.value==2){
		if(check_form(document.weaver,'docmain')){
			return true;
		} else {
			//DocAllPropPanel.expand(true);
			onExpandOrCollapse(true);
			//DocSetTabPanel.setActiveTab("DocPropAdd");
			onActiveTab("divProp");
			return false;  
		}
	} 
	return true;
}


function onSave(obj){
	//alert(document.getElementById("imageidsExt").value)
	//alert(1)
	//alert(check_form(document.weaver,'<%=needinputitems%>'))
	
	if(!check_form(document.weaver,'<%=needinputitems%>')){
		//alert(2)		
		onExpandOrCollapse(true);
		//DocAllPropPanel.expand(true);
		//DocSetTabPanel.setActiveTab("DocPropAdd");
		onActiveTab("divProp");
		return false;  
	} 
	//alert(3)
	if(checkSubjectRepeated()&&checkDocMain()){
		/** ###@2007-08-22 modify by yeriwei!
		text = document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.weaver.doccontent.value=text;
		*/
		FCKEditorExt.updateContent();
		
        if (<%=isPersonalDoc%>) {
            document.weaver.docstatus.value=1
            document.weaver.from.value='personalDoc'
            document.weaver.userCategory.value=<%=userCategory%>
        }
        /*
        else {
            //�ĵ�������Ĺ���Ȩ������
            <%if(isSetShare.equals("1")){%>
                document.weaver.docstatus.value=0;
            <%}else{%>
                document.weaver.docstatus.value=1;
            <%}%>
        }
        */

		document.weaver.operation.value='addsave';
        
		//���ݼ���Ƿ���������� �Ʊ�2011/5/27
        try{
			if(ContentSearch() && jQuery("#ext-gen18").text() == ""){
			   if(!confirm("<%=SystemEnv.getHtmlLabelName(26266,user.getLanguage())%>")){
				  return false;
			   }
			}
		}catch(e){}


		try{
		    var objDraft=obj.parentNode.parentNode.parentNode.firstChild.nextSibling.firstChild.firstChild;
			objDraft.disabled = true ;

		    var objPreview=obj.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.firstChild.firstChild;
			objPreview.disabled = true ;
		}catch(e){}
        obj.disabled = true ;
        try{
        	Ext.getCmp("divContentTab").getBottomToolbar().disable();
        }catch(e){}
        

        //TD4213 ������ʾ��Ϣ  ��ʼ
		var content="<%=SystemEnv.getHtmlLabelName(18885,user.getLanguage())%>";
		showPrompt(content);
        //TD4213 ������ʾ��Ϣ  ����
		document.body.onbeforeunload = null;//by cyril on 2008-06-24 for TD:8828
		document.weaver.submit();
	}
}

function onDraft(obj){
	if(!check_form(document.weaver,'<%=needinputitems%>')){
		//DocAllPropPanel.expand(true);
		onExpandOrCollapse(true);
		//DocSetTabPanel.setActiveTab("DocPropAdd");
		onActiveTab("divProp");
		return false;
	}
	if(checkSubjectRepeated()&&checkDocMain()){
		/***####@2007-08-22 modify by yeriwei!
		text = document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.weaver.doccontent.value=text;
		***/
		FCKEditorExt.updateContent();
		
		document.weaver.docstatus.value=0;
		document.weaver.operation.value='adddraft';

		try{
			var objSubmit=obj.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild;
			objSubmit.disabled = true ;

		    var objPreview=obj.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.firstChild.firstChild;
			objPreview.disabled = true ;
		}catch(e){}
		 try{
        	Ext.getCmp("divContentTab").getBottomToolbar().disable();
        }catch(e){}
        obj.disabled = true ;

        //TD4213 ������ʾ��Ϣ  ��ʼ
		var content="<%=SystemEnv.getHtmlLabelName(18885,user.getLanguage())%>";
		showPrompt(content);
        //TD4213 ������ʾ��Ϣ  ����
		document.body.onbeforeunload = null;//by cyril on 2008-06-24 for TD:8828		
		document.weaver.submit();
	}
}

function onPreview(obj){
	if(!check_form(document.weaver,'<%=needinputitems%>')){
		//DocAllPropPanel.expand(true);
		onExpandOrCollapse(true);
		//DocSetTabPanel.setActiveTab("DocPropAdd");
		onActiveTab("divProp");
		return false;
	}
    if(checkSubjectRepeated()&&checkDocMain()){
	    /***###@2007-08-22 modify by yeriwei!
		text = document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML;
	    text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
	    document.weaver.doccontent.value=text;
		***/
		//FCKEditoryExt.updateContent();
		FCKEditorExt.updateContent();
		
	    document.weaver.docstatus.value=0;
	    document.weaver.operation.value='addpreview';

		try{
			var objSubmit=obj.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild;
			objSubmit.disabled = true ;

		    var objDraft=obj.parentNode.parentNode.parentNode.firstChild.nextSibling.firstChild.firstChild;
			objDraft.disabled = true ;
		}catch(e){}
		try{
        	Ext.getCmp("divContentTab").getBottomToolbar().disable();
        }catch(e){}
        obj.disabled = true ;

        //TD4213 ������ʾ��Ϣ  ��ʼ
		var content="<%=SystemEnv.getHtmlLabelName(18885,user.getLanguage())%>";
		showPrompt(content);
        //TD4213 ������ʾ��Ϣ  ����
		document.body.onbeforeunload = null;//by cyril on 2008-06-24 for TD:8828
	    document.weaver.submit();
    }
}
/*
function onHtml(){
	if(document.weaver.doccontent.style.display==''){

		text = document.weaver.doccontent.value;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML=text;
		document.weaver.doccontent.style.display='none';
		divifrm.style.display='';
	}
	else{
		text = document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.weaver.doccontent.value=text;
		document.weaver.doccontent.style.display='';
		divifrm.style.display='none';
	}
}
*/
accessorynum = 2 ;
function addannexRow()
{
	nrewardTR = $('rewardTR');
	nrewardTable = nrewardTR.parentElement.parentElement;
	oRow = nrewardTable.insertRow(nrewardTR.rowIndex);
	oRow.height=20;
	for(j=0; j<2; j++) {
		oCell = oRow.insertCell();
		switch(j) {
    		case 0:
						var sHtml = "<%=SystemEnv.getHtmlLabelName(156,user.getLanguage())%>";
						oCell.innerHTML = sHtml;
						break;
        case 1:
        		oCell.colSpan = 3;
        		oCell.className = "field";
            //var sHtml = "<input class=InputStyle  type=file size=70 name='accessory"+accessorynum+"' onchange='accesoryChanage(this)'>(��Ŀ¼�����ֻ���ϴ�<%=maxUploadImageSize%>M/���ĸ���)";
            var sHtml = "<input class=InputStyle  type=file size=70 name='accessory"+accessorynum+"' onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=maxUploadImageSize%>M)";
            <%if (isPersonalDoc){%>
                sHtml = "<input class=InputStyle  type=file size=70 name='accessory"+accessorynum+"'>";
            <%}%>
						oCell.innerHTML = sHtml;
						break;
		}
	}
	accessorynum = accessorynum*1 +1;
	document.weaver.accessorynum.value = accessorynum ;

	oRow = nrewardTable.insertRow(nrewardTR.rowIndex);
	oRow.className = "Spacing";
	oCell = oRow.insertCell();
	oCell.colSpan = 2;
	oCell.className = "Line";
}

function accesoryChanage(obj){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        File.FilePath=objValue;
        fileLenth= File.getFileSize();
    } catch (e){
    	if(e.message=="Type mismatch"||e.message=="���Ͳ�ƥ��")
        alert("<%=SystemEnv.getHtmlLabelName(21015,user.getLanguage())%> ");
        else
        alert("<%=SystemEnv.getHtmlLabelName(21090,user.getLanguage())%> ");
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    //var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1)
	var fileLenthByK =  fileLenth/1024;
	var fileLenthByM =  fileLenthByK/1024;

	var fileLenthName;
	if(fileLenthByM>=0.1){
		fileLenthName=fileLenthByM.toFixed(1)+"M";
	}else if(fileLenthByK>=0.1){
		fileLenthName=fileLenthByK.toFixed(1)+"K";
	}else{
		fileLenthName=fileLenth+"B";
	}

    if (fileLenthByM><%=maxUploadImageSize%>) {
        //alert("��������Ϊ:"+fileLenthByM+"M,��Ŀ¼�²����ϴ�����<%=maxUploadImageSize%>M���ļ�,�����Ҫ���ʹ��ļ�,�������Ա��ϵ!");
        alert("<%=SystemEnv.getHtmlLabelName(20254,user.getLanguage())%>"+fileLenthName+",<%=SystemEnv.getHtmlLabelName(20255,user.getLanguage())%><%=maxUploadImageSize%>M<%=SystemEnv.getHtmlLabelName(20256,user.getLanguage())%>");
        createAndRemoveObj(obj);
    }
}

function createAndRemoveObj(obj){
    objName = obj.name;
    var  newObj = document.createElement("input");
    newObj.name=objName;
    newObj.className="InputStyle";
    newObj.type="file";
    newObj.size=70;
    newObj.onchange=function(){accesoryChanage(this);};

    var objParentNode = obj.parentNode;
    var objNextNode = obj.nextSibling;
    obj.removeNode();
    objParentNode.insertBefore(newObj,objNextNode);
}
</script>
<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
<!-- added by cyril on 20080605 for td8828-->
<script>
	function checkChange(event) {

		try{
			FCKEditorExt.updateContent();
		}catch(e){
		}

		if(!checkDataChange())
	        event.returnValue="<%=SystemEnv.getHtmlLabelName(19006,user.getLanguage())%>";
	}
    function wfchangetab(){    		
    	if(!checkDataChange()) {
    	  return true;
    	}else{
    	  return false;
    	}
    }
</script>
<script language=javascript src="/js/checkData.js"></script>
<!-- end by cyril on 20080605 for td8828-->