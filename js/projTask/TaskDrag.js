var lastSelectedTRObj=null;  //���һ��ѡ������Ǹ�TR����
var lastSelectedLineObj=null;
var srcRowObj;   //���ڼ�¼���϶���Դ�ж���
var targetRowObj;  //���ڼ�¼���϶���Ŀ¼�ж���
var allowMove;       //�����ƶ��Ķ���
var popedomMove;     //����Ȩ�޲����ƶ�
var el;
var dragFlag=0;

//����ı��䱾�����ʽΪselect

function onDragTDDBClick(obj){
	var parentObj =$(obj).parent("tr")[0];	
	if(lastSelectedTRObj&&lastSelectedTRObj!=parentObj){
		lastSelectedTRObj.className="DataLight"
			for(var i=0;i<lastSelectedTRObj.cells.length;i++){
				lastSelectedTRObj.cells[i].className="DataLight";
			}
	};
	if(parentObj.className!="Selected"){
		parentObj.className="Selected";
		lastSelectedTRObj=parentObj;
		
			for(var i=0;i<parentObj.cells.length;i++){
				try{
				parentObj.cells[i].className="Selected";
				}catch(e){
					alert(i);
				}
			}
		
	}else{
		parentObj.className="DataLight";
		for(var i=0;i<parentObj.cells.length;i++){
			parentObj.cells[i].className="DataLight";
		}
		lastSelectedTRObj=null;
	}
}
function mousedown(e){    
	el =$.event.fix(e).target;	
	if(el==null||el.nodeName!="TD"||el.cellIndex!=0 || $(el).parents("tr")[0].rowIndex<2) return false;  //��2�����ϵ�һ����TD�Ķ���
	if ($(el).attr("trOwner")=="manager") return false ;
	if ($(el).attr("class")!="Selected") return false; 
	srcRowObj =  $(el).parents("tr")[0]; 
	allowMove=true ;
	popedomMove = true ;
}

function mouseup(e){		
	try
	{

		if (!allowMove) return false;
		allowMove = false ;
		if (!popedomMove){
			if (lastSelectedTRObj!=null) lastSelectedTRObj.className="DataLight";
			if (lastSelectedLineObj!=null) $(lastSelectedLineObj).find("td").css("background-color","#EFEFEF");	
			return false ;
		}
		
		if (el!=null && el.tagName=="TD" && ($(el).parent()[0].className=="DataLight" || $(el).parent()[0].className=="Selected"|| $(el).parent()[0].className=="Header")  && el.cellIndex==0) {	
			targetRowObj = el.parentElement
		}

		if (insertObj(srcRowObj,targetRowObj))  {		
			if (lastSelectedTRObj!=null&&lastSelectedTRObj!=targetRowObj) lastSelectedTRObj.className="DataLight";
		}
		if (lastSelectedLineObj!=null) $(lastSelectedLineObj).find("td").css("background-color","#EFEFEF");	
	}	catch (e){
			if (lastSelectedTRObj!=null) {
				lastSelectedTRObj.className="DataLight";
				lastSelectedTRObj == null ;
			}
			if (lastSelectedLineObj!=null) $(lastSelectedLineObj).find("td").css("background-color","#EFEFEF");	
		alert(e.number+": "+e.description)
		throw(e);
	}
	
}

function mousemove(e){
	
	if (!allowMove) return false;
	
	el =$.event.fix(e).target;		
	
	if (el!=null && el.nodeName=="TD" && ($(el).parent().attr("class")=="DataLight" || $(el).parent().attr("class")=="Selected"|| $(el).parent().attr("class")=="Header")  && el.cellIndex==0) {		
		if ($(el).parent().attr("rowStatus")=="disabled") {
			popedomMove = false ;				
			return false;
		}
		
		if (lastSelectedLineObj!=null) {
			$(lastSelectedLineObj).find("td").css("background","#EFEFEF");	
			
		}
		$(el).parent().next().find("td").css("background-color","#7F7F7F");	
		lastSelectedLineObj = $(el).parent().next();
	}
}

function insertObj(srcObj,targetObj){  	
	if (srcObj==targetObj) return false ;	

	//�޸��߼�DOC�����ƶ���ص��ж���
	var locatObj;
    var locatAt;
	var isFirstRow=false;

	if (targetObj.className=="Header"){  //��Ŀ�����Ǳ�ͷ��ʱ��,��afterObjΪ����һ�е���һ��,���ҷ�ʽΪǰ
		locatObj=$(targetObj).next().next()[0];
		locatAt="before"
		isFirstRow=true;
	} else 	if(isLastLine(targetObj)=="false"){   //��Ϊ���һ��ʱ ����ĵط�Ϊ,Ŀ���к���		
		locatObj=targetObj;
		locatAt="after"
	} else {  //��Ϊ�ռ�ͨ��ʱ ����ĵط�Ϊ,Ŀ���е���һ�е���һ�е�ǰ��				
		locatObj=$(targetObj).next().next()[0];
		locatAt="before";
	}
	
	//�ƶ�����
	var result = modeNode(srcObj,targetObj,locatObj,locatAt,isFirstRow);	

	return result;
}

//�Ƿ������һ��
function isLastLine(obj){
	try	{
		var Next2Sibling = $(obj).next().next();	
		if (Next2Sibling.length==0) return "false";
		return "true" ;		
	}catch (e){		
		return "false";		
	}	
}

function findNextBrother(nodeId){
	flag=0;
	
	return flag;
}

