/**
*<rootTask>
*	<task id="1" level="0" ></task>
*	<task id="2" level="0" ></task>
*	<task id="3" level="0" ></task>
*	<task id="4" level="0" ></task>
*    ................. 
*</rootTask>
*/

function TaskNodeXmlDoc(xmlStr){
	//if(window.ActiveXObject){
	/**this.xmlDoc = new ActiveXObject("Microsoft.XMLDOM") ; 
	this.xmlDoc.async  = false; 
	this.xmlDoc.validateOnParse = false; 
	this.xmlDoc.resolveExternals = false; 
	this.xmlDoc.preserveWhiteSpace = true; 
	this.xmlDoc.setProperty("SelectionLanguage", "XPath");
	if (xmlStr==null){
		this.xmlDoc.documentElement = this.xmlDoc.createElement("rootTask"); 
	} else {
		this.xmlDoc.loadXML(xmlStr);
	}

	this.root = this.xmlDoc.documentElement; 
	*/
	if(window.ActiveXObject){
		this.xmlDoc = new ActiveXObject("Microsoft.XMLDOM") ; 
		this.xmlDoc.async  = false; 
		if (xmlStr==null){
			this.xmlDoc.documentElement = this.xmlDoc.createElement("rootTask"); 
		} else {
			this.xmlDoc.loadXML(xmlStr);
		}
	}else if (document.implementation&&document.implementation.createDocument)
    {
        xmlParser = new DOMParser();
        this.xmlDoc=xmlParser.parseFromString(xmlStr,"text/xml");
    }
    else
    {
       alert("�����������֧��xml");
    }

}
TaskNodeXmlDoc.prototype.addNode=function(rowIndex,level){
	var newElem = this.xmlDoc.createElement("task"); 
	newElem.setAttribute("id",rowIndex);
	this.root.appendChild(newElem); 	
}

TaskNodeXmlDoc.prototype.getNodeLevel=function(rowIndex){
	var level = 0;
	var currentNode = this.xmlDoc.selectSingleNode("//task[@id='"+rowIndex+"']");	
	var level = this.getNodeDepth(currentNode,level);
	return level-1;
}

TaskNodeXmlDoc.prototype.getNodeDepth=function(currentNode,level){
	newCurrentNode = currentNode.parentNode;
	if (newCurrentNode.tagName!="rootTask")	{
		level=this.getNodeDepth(newCurrentNode,level);
	}
	level++;
	return level;
}

TaskNodeXmlDoc.prototype.getLastChildNodeDepthSelf=function(currentNode){
	try	{	
		var lastNode;
		if (currentNode.hasChildNodes())		{	
			lastNode = currentNode.selectSingleNode("descendant::task[position()=last()]");			
		}else{
			lastNode = currentNode;
			
		}		
		var	currentNodeDepth =  this.getNodeDepth(currentNode,-1);
		var	lastNodeDepth =  this.getNodeDepth(lastNode,-1);

		//alert(" currentNodeDepth: "+currentNodeDepth+" lastNodeDepth : "+lastNodeDepth);
		return lastNodeDepth-currentNodeDepth+1;
	}
	catch (e){
		//alert(e.description)
		return 0;
	}	
}

TaskNodeXmlDoc.prototype.getLastChildNodeDepth=function(currentNode){
	try	{	
		var lastNode;
		if (currentNode.hasChildNodes())		{	
			lastNode = currentNode.selectSingleNode("descendant::task[position()=last()]");
		}else{
			lastNode = currentNode;
		}
		//alert(lastNode.xml)
		return this.getNodeDepth(lastNode,-1);
	}
	catch (e){
		//alert(e.description)
		return 0;
	}	
}

TaskNodeXmlDoc.prototype.getPreSibling=function(obj){	
	try	{
		var preNode = obj.previousSibling;		
		if (preNode!=null)	return preNode ;
	}
	catch (e){
		return null;
	}
}
TaskNodeXmlDoc.prototype.isHaveNextSibling=function(obj){		
	try	{
		var nextNode = obj.nextSibling;		
		if (nextNode==null)	return false ;
		return true ;
	}
	catch (e){
		return false;
	}
}

/*
*���� 1:����
*	 2:�Ѵﵽ��ͼ�
*    3:���ӽ���Ѵﵽ��ͼ�
*    4:ǰ����ͬ����������
*    5:��������
*/
TaskNodeXmlDoc.prototype.moveNodeDown=function(rowIndex){
	try	{
		var currentNode = this.xmlDoc.selectSingleNode("//task[@id='"+rowIndex+"']");		
		if (this.getNodeDepth(currentNode,-1)>=7) return 2;  //�Ѵﵽ��ͼ�
		

		var preNode = this.getPreSibling(currentNode);
		if (preNode==null) return 4;  //ǰ����ͬ����������	
		if (this.getLastChildNodeDepth(currentNode)>=7) return 3; //���ӽ���Ѵﵽ��ͼ�	
		var lastRowIndex = this.getLastRowIndex(rowIndex,this.getNodeDepth(currentNode,-1)+1);	
	
		var preNodeChildrens = preNode.childNodes;
		var afterNode ;
		for (var i=0;i<preNodeChildrens.length;i++)	{
			var id = preNodeChildrens[i].getAttribute("id");
			if (id==lastRowIndex){
				afterNode = preNodeChildrens[i];
				break;
			}
		}
		if (preNode!=null) {
			if (afterNode!=null)	{
				preNode.insertBefore(currentNode,afterNode);
			} else {
				preNode.appendChild(currentNode);
			}			
		}

		
		return 1;
	}
	catch (e)	{		
		return 5;  //��������
	}
}

/*
*���� 1:����
*	 2:�Ѵﵽ���
*    3:��������
*    4:��������
*/

TaskNodeXmlDoc.prototype.moveNodeUp=function(rowIndex){
	try
	{
		var currentNode = this.xmlDoc.selectSingleNode("//task[@id='"+rowIndex+"']");
		var currentLevel = this.getNodeDepth(currentNode,-1);
		if (currentLevel<=0) return 2;  //�Ѵﵽ���

		var managerRowIndex =this.getManagerRowIndex(rowIndex);   //���û���򷵻�Ϊ-1
		if (managerRowIndex!=-1){
			managerRowIndexDepth = this.getNodeLevel(managerRowIndex);
			//alert("currentLevel : "+currentLevel+"managerRowIndexDepth : "+managerRowIndexDepth)
			if (currentLevel-1<=managerRowIndexDepth) return 4;  
		}
		//�䱾���Ժ���ֵܽڵ�Ӧȫ������Ӽ� 
		var nextSbilingList = this.getNextSbilingList(currentNode);
		
		for (var j=0;j<nextSbilingList.size();j++){			
			currentNode.appendChild(nextSbilingList.get(j));
		}
		//������ƶ�
		var lastRowIndex = this.getLastRowIndex(rowIndex,this.getNodeDepth(currentNode,-1)-1);	
		var grandpaNode = currentNode.parentNode.parentNode;
		var grandpaNodeChildrens = grandpaNode.childNodes;
		var afterNode ;
		if (grandpaNode!=null) {
			for (var i=0;i<grandpaNodeChildrens.length;i++)	{
				var id = grandpaNodeChildrens[i].getAttribute("id");				
				if (id==lastRowIndex){
					afterNode = grandpaNodeChildrens[i];
				    break;
				}
			}			
			if (afterNode!=null)	{
				grandpaNode.insertBefore(currentNode,afterNode);
			} else {
				grandpaNode.appendChild(currentNode);
			}			
		} 		
		return 1;
	}
	catch (e){		
		return 3;
	}
}


TaskNodeXmlDoc.prototype.getManagerRowIndex=function(rowIndex){
	var ruslt = -1;
	try	{
		var obj = document.getElementById("tr_"+rowIndex);
		var taskRows = tblTask.rows;

		for (var i=obj.rowIndex;i>=0;i-- )	{
			var row =  taskRows[i];
			
			if (row.trOwner=="manager")  {				
				return row.customIndex;
		    }
		}			
	}
	catch (e){
		alert(e.description)
		ruslt=-1;	
	}
	
	return ruslt;
}


TaskNodeXmlDoc.prototype.getChildRowIndexs=function(rowIndex){
	var returnArray = new Array();
	try	{		
		var currentNode = this.xmlDoc.selectSingleNode("//task[@id='"+rowIndex+"']");
		if (currentNode.hasChildNodes()) {
			var chilNodes = currentNode.childNodes;
			for (var i=0;i<chilNodes.length;i++ )	{
				returnArray[i]=chilNodes[i].getAttribute("id");
			}
		}
		
	}
	catch (e){}
	return returnArray;
}


TaskNodeXmlDoc.prototype.getNextSbilingList=function(currentNode){
	var sbilingList = new ArrayList();
	try	{
		var allowNext = false ;
		var mySbilings = currentNode.parentNode.childNodes;			
		for (var j=0; j<mySbilings.length;j++) {
		  siblingNode = mySbilings.item(j);

		  if (allowNext==false){
			 if (siblingNode==currentNode) {
				 allowNext = true ;				
				 continue ;
			 }
		  }
		  if (!allowNext) continue ;	
		  sbilingList.add(siblingNode);		 
		 }		
	}
	catch (ex)	{}
	return sbilingList;
}
/*
*���� 1:����
*	 2:���ӽ���Ѵﵽ��ͼ�
*    3:��������
*    4:�����ƶ����ֽڵ���·�
*/

//�����ڵ��ƶ���ʱ��,�ͷ��ڴ˽��ĺ���,��������صĽ��ͬ��

TaskNodeXmlDoc.prototype.moveNode=function(srcObj,targetObj,locatObj,locatAt,isFirstRow){	
	srcRowIndex = srcObj.customIndex;
	targetRowIndex = targetObj.customIndex;
	locatIndex = locatObj.customIndex;
	try	{			
		var srcNode = this.xmlDoc.selectSingleNode("//task[@id='"+srcRowIndex+"']");		
		var locatNode = this.xmlDoc.selectSingleNode("//task[@id='"+locatIndex+"']");
		if (isFirstRow)	{
			locatNode.parentNode.insertBefore(srcNode,locatNode);
			return 1 ;
		}		

		var targetNode = this.xmlDoc.selectSingleNode("//task[@id='"+targetRowIndex+"']");		
		//�ж�targetNode�ǲ���srcNode���ӽڵ�		
		if (this.isAChild(targetNode,srcNode)=="true") return 4;
		var srcNodeDepth = this.getLastChildNodeDepthSelf(srcNode);
		var targetNodeDepth = this.getNodeDepth(targetNode,-1)+1;
		//alert("srcObj: "+srcNode.getAttribute("id")+" srcNodeDepth: "+srcNodeDepth+" targetObj: "+targetNode.getAttribute("id")+" targetNodeDepth : "+targetNodeDepth)
		
		//�����Ŀ�������ӽ��,��˽����Ϊ���ӽ��  ���Ŀ�������ӽ������Ϊ��ͬ�����
		if (locatAt=="before"){
			//��һ�� ���һ�м�	
			if (isFirstRow){				
				
			} else {
				//�ڶ��������һ��  ������ӽ��,����Ϊ�����ӽ�� ���û���ӽ��,����Ϊ���ֵܽ��	
				if (targetNode.hasChildNodes()) {
					if (srcNodeDepth+targetNodeDepth>8) return 2; 
					//srcNode ��Ϊ���ӽ��					
					targetNode.insertBefore(srcNode,locatNode);
				} else {	
					if (srcNodeDepth+targetNodeDepth-1>8) return 2; 
					// targetNode��������Ƿ����ֵ�					
					if (this.isHaveNextSibling(targetNode)){
						targetNode.parentNode.insertBefore(srcNode,locatNode);
					} else {
						targetNode.parentNode.appendChild(srcNode);
					}
					
				}
			}
		} else {
			//��λ�ýڵ�ͬ��
			if (srcNodeDepth+targetNodeDepth-1>8) return 2; 
			locatNode.parentNode.appendChild(srcNode);
		}		
		return 1;
	}
	catch (e)	{	
		alert(e.number+": "+e.description);
		return 3;
	}
}

/*
* ���� a �ǲ��� b ������
*/
TaskNodeXmlDoc.prototype.isAChild=function(nodeA ,nodeB){
	try	{
		nodeAParent = nodeA.parentNode;
		if (nodeAParent.tagName=="rootTask")   	return "false";
		if (nodeAParent==nodeB)   return "true";
		isAChild(nodeAParent,nodeB);
	}
	catch (ex){ 
		return "false";
	}
	
}

TaskNodeXmlDoc.prototype.delNode=function(rowIndex){
	var delNode = this.xmlDoc.selectNodes("//task[@id='"+rowIndex+"']");	
	delNode.removeAll();
}


/*
*����ͷ��� -1 ���򷵻�����к�
*/
TaskNodeXmlDoc.prototype.getLastRowIndex=function(rowIndex,objLevel){	
	//alert("rowIndex: "+rowIndex+" objLevel:"+objLevel)
	try	{
		var objs = document.getElementsByName("txtTaskName");
		var allowNext = false ;		
		for (var i=0;i<objs.length;i++){
			 var obj = objs[i];
			 var obRowIndex = obj.customIndex;	
			 if (obRowIndex==rowIndex) allowNext = true ;
			 if (!allowNext) continue;
			 if (obj.size==24-3*objLevel) return obj.customIndex;
		}
	    return -1;
	} catch (e){
		return -1;
	}	
}


TaskNodeXmlDoc.prototype.addRowNeedMove=function(srcIndex,targetIndex,isManagerTR){	

	//alert("srcIndex: "+srcIndex+" targetIndex: "+targetIndex+" isManagerTR: "+isManagerTR)
	var ruslt = "false";
	try	{
		var srcNode = this.xmlDoc.selectSingleNode("//task[@id='"+srcIndex+"']");	
		var targetNode = this.xmlDoc.selectSingleNode("//task[@id='"+targetIndex+"']");			
		if (targetNode==null) return ruslt;		
		if(isManagerTR){
				if (targetNode.hasChildNodes()){					
					targetNode.insertBefore(srcNode,targetNode.firstChild);
				} else {				
					targetNode.appendChild(srcNode);
				}
				return "true";
		}
		if (targetNode.hasChildNodes()){
			targetNode.insertBefore(srcNode,targetNode.firstChild);
		} else {			
			targetNode.parentNode.insertBefore(srcNode,targetNode.nextSibling);
		}
		ruslt = "true";
	}
	catch (ex){alert(ex)}
	return  ruslt
}

TaskNodeXmlDoc.prototype.getThisDoc=function(){	
	return this.xmlDoc;
}

TaskNodeXmlDoc.prototype.toString=function(){
	var xmlStr = this.xmlDoc.xml;	
	return xmlStr.toString();
}



