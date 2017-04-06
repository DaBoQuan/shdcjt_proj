var prjTaskObj;
var prjTaskObjTemp=new Array();
var temRowIndex=0;
function initPrjTaskObj(){
	 prjTaskObj=$.z4x($("textarea[name=task_xml]").val());
	 if(!prjTaskObj.rootTask.task){
		 prjTaskObj.rootTask.task=[];
	 }
	 prjTaskObj.rootTask.$depth=0
	 getRows(prjTaskObj.rootTask,prjTaskObj.rootTask);
	modiChildsSize();
}
function getRows(curTask,parentTask){
	if(curTask){
		if(curTask.task&&curTask.task.length>0){
			for(var i=0;i<curTask.task.length;i++){
				curTask.task[i].$rowLevel=temRowIndex++;
				curTask.task[i].$depth=curTask.$depth+1;
				var temNode={};
				temNode.$id=curTask.task[i].$id;
				temNode.$selfid=curTask.task[i].$selfid;
				temNode.$rowLevel=curTask.task[i].$rowLevel;
				temNode.$parentId=curTask.$id;
				temNode.$depth=curTask.task[i].$depth;
				prjTaskObjTemp.push(temNode);
				getRows(curTask.task[i],curTask);
			}
		}
	}
	
}
/**
 * �����ڵ�
 * @param nodeId �ڵ�id
 * @param level  �����ټ�
 * @return
 */
function moveNodeUp(nodeId,level){
	if(!(level&&true)){
		level=1;
	}
	for(var i=0;i<prjTaskObjTemp.length;i++){
		var curNode=prjTaskObjTemp[i];
		if(curNode.$id==nodeId){
			if(curNode.$depth-level>0){
				curNode.$depth=curNode.$depth-level;
				var oldParentId=curNode.$parentId;
				curNode.$parentId=getParentNodeId(curNode.$parentId,level);
				
				if(isHasChild(curNode.$id)){
					upChildenLevel(curNode.$id,level);
				}
			}
			i++;
			for(;i<prjTaskObjTemp.length&&oldParentId==prjTaskObjTemp[i].$parentId;i++){
				var curNode2=prjTaskObjTemp[i];
				curNode2.$parentId=curNode.$id;
			}
			return;
		}
	}
}
/**
 * ����ָ���ڵ�������ӽڵ�
 * @param nodeId �ڵ�Id
 * @return
 */
function upChildenLevel(nodeId){
	for(var i=0;i< prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$parentId==nodeId){
			prjTaskObjTemp[i].$depth=prjTaskObjTemp[i].$depth-1;
			if(isHasChild(prjTaskObjTemp[i].$id)){
				upChildenLevel(prjTaskObjTemp[i].$id);
			}
		}
	}
}
/**
 * �����ڵ�
 * @param nodeId �ڵ�Id
 * @return
 */
function moveNodeDown(nodeId){
	for(var i=0;i<prjTaskObjTemp.length;i++){
		var curNode=prjTaskObjTemp[i];
		if(i>0&&curNode.$id==nodeId){
			if(prjTaskObjTemp[i-1].$depth-curNode.$depth>-1){
				curNode.$depth=curNode.$depth+1;
				curNode.$parentId=getParentId(curNode);
				if(isHasChild(curNode.$id)){
					downChildenLevel(curNode.$id);
				}
			}
			return;
		}
	}
}
/**
 * ��Ŀ��ڵ����һ���ڵ�
 * @param srcObj  Ҫ����Ľڵ�
 * @param targteObj Ŀ��ڵ�
 * @return
 */
function insertAfter(srcObj,targteObj){
	var childNodes=findChildNodesById(srcObj.$id);
	srcObj.$parentId=targteObj.$id;
	for(var i=0;i<childNodes.length;i++){
		
	}
}
/**
 * ����Id��ѯֱ���ֽڵ�
 * @param nodeId
 * @return
 */
function findChildNodesById(nodeId){
	
}
/**
 * 
 * @param srcObj  ��Ҫ�ƶ��ĵ�
 * @param targetObj Ŀ����
 * @param locatObj  
 * @param locatAt
 * @param isFirstRow
 * @return
 */
function modeNode(srcObj,targetObj,locatObj,locatAt,isFirstRow){
	var targetIndex=targetObj.rowIndex/2+targetObj.rowIndex%2;
	var srcIndex=srcObj.rowIndex/2+srcObj.rowIndex%2;
	var srcNode=prjTaskObjTemp[srcIndex-1];
	var targetNode;
	var depthChange;
	if(targetIndex==0){
		targetNode=null;
		depthChange=0-srcNode.$depth;
		srcNode.$parentId=undefined;
	}else{
		targetNode=prjTaskObjTemp[targetIndex-1];
		depthChange=targetNode.$depth-srcNode.$depth;
		srcNode.$parentId=targetNode.$id;
	}
	var nodeQueue=new Array();
	nodeQueue.push(srcNode);
	findAllChilden(srcNode.$id,nodeQueue);
	prjTaskObjTemp.splice(srcIndex-1,nodeQueue.length);
	var curNode=targetObj;
	/*if(targetNode){
		var tempNodeQueue=new Array();
		findAllChilden(targetNode.$id,tempNodeQueue);
		if(tempNodeQueue.length>0){
			curNode=$("#tr_"+tempNodeQueue[tempNodeQueue.length-1]);
		}
	}
	*/
	for(var i=0;i<nodeQueue.length;i++){
		prjTaskObjTemp.splice(targetIndex+i,0,nodeQueue[i]);
		nodeQueue[i].$depth=nodeQueue[i].$depth+depthChange+1;
		$(curNode).next().after($("#tr_"+nodeQueue[i].$id).next());
		$(curNode).next().after($("#tr_"+nodeQueue[i].$id));
		curNode=$("#tr_"+nodeQueue[i].$id);
	}
	modiChildsSize();
	
}
function modeNode2(srcObj,targetObj,locatObj,locatAt,isFirstRow){
	srcRowIndex = parseInt(srcObj.rowIndex/2);
	targetRowIndex = parseInt(targetObj.rowIndex/2);
	locatIndex = parseInt(locatObj.rowIndex/2);
	try	{			
		var srcNode = prjTaskObjTemp[srcRowIndex-1];		
		var locatNode = prjTaskObjTemp[targetRowIndex-1];
		
		if (isFirstRow)	{
			srcNode.$parentId=undefined;
			srcNode.$rowLevel=0;
			srcNode.$depth=1;
			prjTaskObjTemp.splice(locatIndex-1,0,srcNode);
			prjTaskObjTemp.splice(srcRowIndex,1);
			$(targetObj).next().after($(srcObj).next());
			$(targetObj).next().after($(srcObj));
			modiChildsSize();
			var childNodes=new Array();
			
			return 1 ;
		}
		var rowLevelChange=parseInt(locatNode.$rowLevel)-parseInt(srcNode.$rowLevel);
		if(locatNode.$depth<=srcNode.$depth){
			srcNode.$rowLevel=srcNode.$rowLevel+rowLevelChange;
			if(locatNode.$depth<srcNode.$depth){
				srcNode.$depth=locatNode.$depth+1;
				srcNode.$parentId=locatNode.$id;
			}
			if(rowLevelChange<0){
				prjTaskObjTemp.splice(locatIndex-1,0,srcNode);
				prjTaskObjTemp.splice(srcRowIndex,1);
				$(targetObj).next().after($(srcObj).next());
				$(targetObj).next().after($(srcObj));
			}else{
				prjTaskObjTemp.splice(targetRowIndex,0,srcNode);
				prjTaskObjTemp.splice(srcRowIndex-1,1);
				$(targetObj).next().after($(srcObj).next());
				$(targetObj).next().after($(srcObj));
			}
			modiChildsSize();
			return 1;
		}
		
	}
	catch (e)	{	
		//alert(e.number+": "+e.description);
		return 3;
	}
}
function getParentId(curNode){
	curNode.$parentId;
	var brotherNodes=[];
	var newParentNode={};
	for(var i=0;i<prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$parentId==curNode.$parentId){
			brotherNodes.push(prjTaskObjTemp[i]);
		}
	}
	for(var i=0;i<brotherNodes.length;i++){
		if(brotherNodes[i].$id==curNode.$id){
			break;
		}
		newParentNode=brotherNodes[i];
	}
	return newParentNode.$id
}
function downChildenLevel(nodeId){
	for(var i=0;i< prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$parentId==nodeId){
			prjTaskObjTemp[i].$depth=prjTaskObjTemp[i].$depth+1;
			if(isHasChild(prjTaskObjTemp[i].$id)){
				downChildenLevel(prjTaskObjTemp[i].$id);
			}
		}
	}
}
function findAllChilden(nodeId,nodeQuene){
	for(var i=0;i< prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$parentId==nodeId){
			nodeQuene.push(prjTaskObjTemp[i]);
			if(isHasChild(prjTaskObjTemp[i].$id)){
				findAllChilden(prjTaskObjTemp[i].$id,nodeQuene);
			}
		}
	}
}
function getParentNodeId(nodeId){
	for(var i=0;i<prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$id==nodeId){
			return prjTaskObjTemp[i].$parentId;
		}
	}
	return undefined;
}
function addNode(iRowIndex){
	var node={};
	node.$id=iRowIndex;
	node.$depth=1;
	node.$rowLevel=0;
	prjTaskObjTemp.push(node);
}
function getPrevNode($id){
	
}
var modiChildsSize = function() {
	for(var i=0;i<prjTaskObjTemp.length;i++){
		var curNode=prjTaskObjTemp[i];
		document.getElementById("txtTaskName_"+curNode.$id).size = 24-(curNode.$depth-1)*3; 
		if(isHasChild(curNode.$id)){
			document.getElementById("img_"+curNode.$id).style.visibility="visible" ;
		}else{
			document.getElementById("img_"+curNode.$id).style.visibility="hidden" ;
		}
	}
};
function isHasChild(nodeId){
	for(var i=0;i<prjTaskObjTemp.length;i++){
		if(prjTaskObjTemp[i].$parentId==nodeId){
			return true;
		}
	}
	return false;
}
var addedNode=[];
function generaDomJson(){
	var nodeQueue=[{}];
	var result={};
	var parentNode={};
	for(var i=0;i<nodeQueue.length;i++){
			var curNode={};
			
			var parent=getElmentById(nodeQueue[i].$parentId);
			if(nodeQueue[i].$id){
				curNode.$id=nodeQueue[i].$id;
				if(nodeQueue[i].$selfid){
					curNode.$selfid=nodeQueue[i].$selfid;
				}
				if(nodeQueue[i].$parentId==undefined){
					result.task.push(curNode);
					addedNode.push(result.task[result.task.length-1]);
				}else{
					if(parent.task==undefined){
						parent.task=new Array();
					}
					parent.task.push(curNode);
					addedNode.push(parent.task[parent.task.length-1]);
				}
				
			}else{
				result.task=new Array();
			}
			findChildren(nodeQueue[i].$id,nodeQueue);
	}
	return result;
}
function findChildren(nodeId,nodeQueue){
	for(i=0;i<prjTaskObjTemp.length;i++){
		if(nodeId==prjTaskObjTemp[i].$parentId){
			nodeQueue.push(prjTaskObjTemp[i]);
			prjTaskObjTemp.splice(i,1);
			i=i-1;
		}
	}
}

function getElmentById(id){
	for(var i=0;i<addedNode.length;i++){
		if(id==addedNode[i].$id)
		return addedNode[i];
	}
}
var showTRchilds = function(nodeId,mode) {
	if(nodeId>0){
		var nodeQueue=new Array();
		findAllChilden(nodeId,nodeQueue);
		for(var i=0;i<nodeQueue.length;i++){
			$("#tr_"+nodeQueue[i].$id).css("display",mode=="visible"?"":"none");
			$("#tr_"+nodeQueue[i].$id).next().css("display",mode=="visible"?"":"none");
		}
	}
};
function deleteRow(){
	 var message="";
	 if(readCookie("languageidweaver")==8){
		message="His children task will be delete,are you sure?"; 
	}
	else if(readCookie("languageidweaver")==9){ 
		message="�����΄�Ҳ�����h��,�Ƿ��^�m?"; 
	}
	else {
		message="��������Ҳ����ɾ��,�Ƿ����?";  
	}
	 if(!confirm(message)) return  ;
	var selectedItems=$("input[name=chkTaskItem]:checked");
	var nodeQueue=new Array();
    var val="";
	selectedItems.each(function(){
	  val= $(this).parent().parent().attr("id");
	  if(val!="" && val != null){
	       $(this).parent().parent().remove();  
	       
	  }else{
	       $(this).parent().parent().parent().remove();
	  }
	});
	
}
function findAllDeletedList(){
	
}