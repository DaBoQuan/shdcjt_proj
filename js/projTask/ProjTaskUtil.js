var ProjTaskUtil = function(strXml){
	if (strXml==null){
		this.tnXmlDoc = new TaskNodeXmlDoc();
	} else {
		this.tnXmlDoc = new TaskNodeXmlDoc(strXml);
	}
	
}

/**
* rowIndex:�µ�TaskNodeBean���к�
* level:�����ļ���
*/
ProjTaskUtil.prototype.addNode = function(rowIndex){
	this.tnXmlDoc.addNode(rowIndex);
}


/**
*rowIndex ��Ҫ�������к�
* 
*/
ProjTaskUtil.prototype.downLevel = function(rowIndex){
	var returnValue = this.tnXmlDoc.moveNodeDown(rowIndex);		
	switch (returnValue) {
	case 1 :
		this.modiAllTxtSize();
		break ;
	case 2 :
		if(readCookie("languageidweaver")==8){
			alert("The task have  already arrived at the lowwest!");
	    } 
	    else if(readCookie("languageidweaver")==9){ 
			alert("���΄����_����ͼ�!"); 
		}
	    else {
			alert("�������Ѵﵽ��ͼ�!");
		}
		break ;
	case 3 :
		if(readCookie("languageidweaver")==8){
			alert("The last child task have  already arrived at the lowwest!");
	    }
	    else if(readCookie("languageidweaver")==9)
	    {
	    	alert("����С���΄����_����ͼ�!");
	    } 
	    else {
			alert("����С�������Ѵﵽ��ͼ�!");
		}		
		break ;
	case 4 :			
		break ;
	case 5 :		
		break ;
	} 		
}




/**
*rowIndex ��Ҫ�������к�
*/
ProjTaskUtil.prototype.upLevel = function(rowIndex){

	var returnValue = this.tnXmlDoc.moveNodeUp(rowIndex);	
	switch (returnValue) {
	case 1 :
		this.modiAllTxtSize();
		break ;
	case 2 :
		if(readCookie("languageidweaver")==8){
			alert("The task have  already arrived at the highest!");
	    }
	    else if(readCookie("languageidweaver")==9) 
	    {
	    	alert("���΄����_����߼�!");
	    }
	    else {
			alert("�������Ѵﵽ��߼�!");
		}
		break ;
	case 3 :			
		break ;	
	case 4:
		break;
	} 	
}

/*
*
*��ҳ�潵����
*/
ProjTaskUtil.prototype.downLevelForPage = function(rowIndex) {
	try
	{
		var taskNameObj = document.getElementById("txtTaskName_"+rowIndex);  
		var taskNameDivObj = document.getElementById("taskNameDiv_"+rowIndex);   
		var newTaskNameSize = taskNameObj.size-3;
		taskNameObj.size= newTaskNameSize;
		
		taskNameDivObj.style.display="";		
		
	}
	catch (e){}
	
}


/*
*
*�������ӽڵ�ļ�
*/
ProjTaskUtil.prototype.downChildrenLevel = function(rowIndex){
	var childRowIndexs = this.tnXmlDoc.getChildRowIndexs(rowIndex);
	for (var i=0;i<childRowIndexs.length;i++){
		var rowIndex = childRowIndexs[i];
		this.downLevelForPage(rowIndex);
		this.downChildrenLevel(rowIndex);
	}
}


/*
*
*��ҳ��������
*/
ProjTaskUtil.prototype.upLevelForPage = function(rowIndex) {
	try
	{
		var taskNameObj = document.getElementById("txtTaskName_"+rowIndex);  
		var taskNameDivObj = document.getElementById("taskNameDiv_"+rowIndex);   
		var newTaskNameSize = taskNameObj.size+3;
		taskNameObj.size= newTaskNameSize;
		
		var nodeLevel = this.tnXmlDoc.getNodeLevel(rowIndex);		
		if (nodeLevel==0){
			taskNameDivObj.style.display="none";
		}
		
	}
	catch (e){}	
}

/*
*
*�������ӽڵ�ļ�
*/
ProjTaskUtil.prototype.upChildrenLevel = function(rowIndex){
	var childRowIndexs = this.tnXmlDoc.getChildRowIndexs(rowIndex);
	for (var i=0;i<childRowIndexs.length;i++){
		var rowIndex = childRowIndexs[i];
		this.upLevelForPage(rowIndex);
		this.upChildrenLevel(rowIndex);
	}
}

/*
*
*�����нڵ���ƶ�
*/

ProjTaskUtil.prototype.moveNode = function(srcObj,targetObj,locatObj,locatAt,isFirstRow){		
	//�޸��߼��ṹ	
	var returnValue = this.tnXmlDoc.moveNode(srcObj,targetObj,locatObj,locatAt,isFirstRow);	
	switch (returnValue) {		
	case 1 :
		//��Դ�в��뵽Ŀ���е���һ�к� �γ�������
		targetNextLine = targetObj.nextSibling; 
		srcNextLine = srcObj.nextSibling; 
		
		targetNextLine.insertAdjacentElement("afterEnd",srcObj);  
		newLine = targetNextLine.nextSibling; 

		//��Դ����һ�е���һ�в��뵽  �����е���һ��
		newLine.insertAdjacentElement("afterEnd",srcNextLine); 

		this.moveChilds(srcObj);
		this.modiAllTxtSize();
		return true;
		break ;
	case 2 :
		if(readCookie("languageidweaver")==8){
			alert("The child task have  already arrived at the lowwest, can't move!");
	    }
	    else if(readCookie("languageidweaver")==9) 
	    {
	    	alert("�����΄Ռ��_����ͼ�,�����Ƅ�!");
	    }
	    else {
			alert("�������񽫴ﵽ��ͼ�,�����ƶ�!");
		}		
		return false;
		break ;		
	case 3 :	
		return false;
		break ;			
	case 4 :
		if(readCookie("languageidweaver")==8){
			alert("you can't  move the task into his child!");
	    }
	    else if(readCookie("languageidweaver")==9) 
	    {
	    	alert("���ܰ��ϼ��΄��Ƶ��¼��΄�!");
	    }
	    else {
			alert("���ܰ��ϼ������Ƶ��¼�����!");
		}		
		return false;
		break ;	
	} 	
}


/*
*obj Ϊ�еĶ���
*�ƶ��ӽ��
*/
ProjTaskUtil.prototype.moveChilds= function(obj){	
	var childRowIndexs = this.tnXmlDoc.getChildRowIndexs(obj.customIndex);

	for (var i=0;i<childRowIndexs.length;i++){
		var newSrcRowIndex = childRowIndexs[i];
	
		//����
		newRowObj = document.getElementById("tr_"+newSrcRowIndex);
		//�������һ���ڵ�
		newNextRowObj = document.getElementById("tr_"+newSrcRowIndex).nextSibling;
	
	
			obj.nextSibling.insertAdjacentElement("afterEnd",newRowObj);
			obj.nextSibling.nextSibling.insertAdjacentElement("afterEnd",newNextRowObj);
		 
		this.moveChilds(newRowObj);
	}

}

/*
*
*
*/
ProjTaskUtil.prototype.moveChildrens = function(srcRowIndex,targetRowIndex) {
	var childRowIndexs = this.tnXmlDoc.getChildRowIndexs(srcRowIndex);
	for (var i=0;i<childRowIndexs.length;i++){
		var newSrcRowIndex = childRowIndexs[i];
		this.moveChildForPage(newSrcRowIndex,targetRowIndex);
		this.moveChildrens(newSrcRowIndex,newSrcRowIndex);
	}
}

ProjTaskUtil.prototype.moveChildForPage = function(srcRowIndex,targetRowIndex) {
	

	var srcRow = document.getElementById("tr_"+srcRowIndex); 
	var targetRow =  document.getElementById("tr_"+targetRowIndex); 

	var srcNodeDepth = this.tnXmlDoc.getNodeLevel(srcRowIndex);
	var srcNodeSize = 25 - srcNodeDepth*3;
	//�����ƶ�
	var srcTaskNameObj = document.getElementById("txtTaskName_"+srcRowIndex);  
    var srcTaskNameDivObj = document.getElementById("taskNameDiv_"+srcRowIndex);

	srcTaskNameObj.size = srcNodeSize;
	//alert(srcNodeSize);
	if (srcNodeSize==25) srcTaskNameDivObj.style.display="none";	

	targetRow.insertAdjacentElement("afterEnd",srcRow);
}

/*
*
*
*/
ProjTaskUtil.prototype.getDeleteList = function(chkObjs) {
	var returnList = new ArrayList();
	for (var i=0;i<chkObjs.length;i++)	{
		var objValue = chkObjs[i].value;
		if (chkObjs[i].checked){
			if (!returnList.contains(objValue)) returnList.add(objValue);				
			returnList = this.getChildIds(objValue,returnList);

			//ɾ���߼���ϵ�е�ֵ
            this.tnXmlDoc.delNode(objValue);
		}		
	}
	return returnList;
}


ProjTaskUtil.prototype.getDeleteListForProjEdit = function(chkObjs,isDelXmlNode) {
	var returnList = new ArrayList();
	for (var i=0;i<chkObjs.length;i++)	{
		var objValue = chkObjs[i].value;
		if (chkObjs[i].checked){
			if (!returnList.contains(objValue)) returnList.add(objValue);				
			returnList = this.getChildIds(objValue,returnList);

			//ɾ���߼���ϵ�е�ֵ
			if (isDelXmlNode=="true")	this.tnXmlDoc.delNode(objValue);
		}		
	}
	return returnList;
}


/*
*
*
*/
ProjTaskUtil.prototype.getChildIds = function(objValue,returnList){
	     	var ObjChilds = this.tnXmlDoc.getChildRowIndexs(objValue);	

			for (var j=0;j<ObjChilds.length;j++){					
				if (!returnList.contains(ObjChilds[j]))  returnList.add(ObjChilds[j]);					 				
				this.getChildIds(ObjChilds[j],returnList);
			}


	return returnList;
	
}

/*
*�޸�����������size�ĳ����Լ���ʾ������������ͼƬ
*
*/
ProjTaskUtil.prototype.modiAllTxtSize = function() {
	var xmlDoc = this.tnXmlDoc.getThisDoc();
	var root = xmlDoc.documentElement;
	var level = -1 ;     //��ǰ�����ļ���
	this.modiChildsSize(root,level);			
}


/*
*�޸�������������������size�ĳ����Լ���ʾ������������ͼƬ
*
*/
ProjTaskUtil.prototype.modiChildsSize = function(objs,level) {
	try	{
		var childs = objs.childNodes;
		level++;
		for (var i=0;i<childs.length;i++){
			var child = childs[i];
			var childId = child.getAttribute("id");			
			var isHaveChilds = child.hasChildNodes(); 

			if (isHaveChilds){
				document.getElementById("img_"+childId).style.visibility="visible" ;
			} else {
				document.getElementById("img_"+childId).style.visibility="hidden" ;
			}
			var oldSize = document.getElementById("txtTaskName_"+childId).size;
		
			var newSize = 24 - level*3					
			
			
			if (oldSize!=newSize) {
				document.getElementById("txtTaskName_"+childId).size = newSize; 	
			}
			this.modiChildsSize(child,level);
		}
		
	}
	catch (e){
		//alert(e.description)
	}
	
}


ProjTaskUtil.prototype.showTRchilds = function(rowIndex,mode) {
	try{
		var objChildIndexs = this.tnXmlDoc.getChildRowIndexs(rowIndex);
		for (var i=0;i<objChildIndexs.length;i++) {
			var newIndex = objChildIndexs[i];
			var beforIndex = document.getElementById("index_"+newIndex).value;
			var trObj = document.getElementById("tr_"+newIndex);	
			var seleObj= document.getElementById("seleBeforeTask_"+beforIndex);
			var seleObjManager= document.getElementById("txtManager_"+newIndex);

			if (mode=="hidden"){		
				seleObjManager.style.display='none';
				seleObj.style.display='none';
				trObj.style.display='none';		
				trObj.nextSibling.style.display='none';
				
			} else {
				seleObjManager.style.display='';
				seleObj.style.display='';	
				trObj.style.display='';
				trObj.nextSibling.style.display='';				
				document.getElementById("img_"+newIndex).src='/images/project_rank.gif';
			}	
			this.showTRchilds(newIndex,mode);
		}
		
	} catch(e){alert(e.description)}
}


ProjTaskUtil.prototype.addRowNeedMove = function(srcIndex,targetObj) {
	if (targetObj==null) return false; 		
	if (targetObj.className!="Selected") return false; 
	var srcObj = document.getElementById("tr_"+srcIndex);
	var targetPrePreObj = targetObj;
	//alert("targetObj: "+targetObj.id+" id: "+targetPrePreObj.id+" trOwner: "+targetPrePreObj.trOwner);
	var targetTrIsManagerTr = targetPrePreObj.trOwner=="manager";	
	//alert(targetTrIsManagerTr)

	var result = this.tnXmlDoc.addRowNeedMove(srcIndex,targetObj.customIndex,targetTrIsManagerTr)=="true";	
	if (result){		
		var nextSrcObj = srcObj.nextSibling;		

		targetObj.nextSibling.insertAdjacentElement("afterEnd",srcObj);
		targetObj.nextSibling.nextSibling.insertAdjacentElement("afterEnd",nextSrcObj);		
	}	
	this.modiAllTxtSize()
}

/*
*
*
*/


ProjTaskUtil.prototype.getXmlDocStr = function() {
	return this.tnXmlDoc.toString(); 
}



