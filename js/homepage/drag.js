var intMoveEid;
var srcItem;
var srcGroupFlag;
var divLoc;
var dragobj={}
window.onerror=function(){return false}
function on_ini(){
	String.prototype.inc=function(s){
		return this.indexOf(s)>-1?true:false;
	}
	var agent=navigator.userAgent
	window.isOpr=agent.inc("Opera")
	window.isIE=agent.inc("IE")&&!isOpr
	window.isMoz=agent.inc("Mozilla")&&!isOpr&&!isIE
	if(isMoz){
	   Event.prototype.__defineGetter__("x",function(){return this.clientX+2})
	   Event.prototype.__defineGetter__("y",function(){return this.clientY+2})
	}
	basic_ini()
}
function basic_ini(){
	window.oDel=function(obj){if($(obj)!=null){$(obj).remove()}}
}
$(function(){
	on_ini();
	//��ʼ���϶�
	var o=$(".header");
	
});
function dragStart(e,target){
	//alert("target");
	e=e||event
	srcElement=e.srcElement||e.target;
	if(!(srcElement.className=="header" || srcElement.className=="title")) return;
	
	if(!(e.button==1||e.button==0)){
		return;
	}
	if(dragobj.o){
		return;
	}
	if(target.className=="title" ) target=target.parentNode;
	dragobj.o=target.parentNode;
	//alert(dragobj.o.className+"------"+target.className);
	srcGroupFlag=$($(target).parents(".group")[0]).attr("areaflag");
	//�������ϵ�����
	dragobj.xy=getxy(dragobj.o);
	//�������λ��
	dragobj.xx=new Array((e.x-dragobj.xy[1]),(e.y-dragobj.xy[0]))
	dragobj.o.style.width=dragobj.xy[2]+"px";
	dragobj.o.style.height=dragobj.xy[3]+"px";
	dragobj.o.style.left=(e.x-dragobj.xx[0])+"px";
	dragobj.o.style.top=(e.y-dragobj.xx[1])+"px";   
	dragobj.o.style.position="absolute";
	//������ʱ�������ڼ�ס��ԭʼλ�ã�ռλ
	
	var om=document.createElement("div");
	dragobj.otemp=om
	om.style.width=dragobj.xy[2]+"px"
	om.style.height=dragobj.xy[3]+"px"
	om.className="location";
	om.style.width="auto";
	dragobj.o.parentNode.insertBefore(om,dragobj.o)
	
	return false
}
document.onselectstart=function(){
	if(dragobj.o!=null){
		return false;
	}
}
window.onfocus=function(){document.onmouseup()}
window.onblur=function(){document.onmouseup()}
document.onmouseup=function(e){
	if(dragobj.o!=null){
		var _eid = -1;
		try{
			_eid = dragobj.o.id.split("item_")[1];
		}catch(e){
			//alert(e.message);
		}
	   dragobj.otemp.parentNode.insertBefore(dragobj.o,dragobj.otemp);
	   dragobj.o.style.position="static";
	dragobj.o.style.width="100%";
	  dragobj.o.style.height="auto";
	   var targetAreaFlag=$(dragobj.otemp).parents(".group").attr("areaflag");
	  // alert(targetAreaFlag+"===="+srcGroupFlag);
	   MoveEData(srcGroupFlag,targetAreaFlag);
	   oDel(dragobj.otemp)
	   //ֹͣ�Ϸ�
	   dragobj={}
	   
		try{
			var tab_eid = $("td[name='td_tab_"+_eid+"']");
			if(tab_eid.length>0){
				jQuery("#content_view_id_"+_eid).trigger("reload");
			}
			var ebaseid = $("#item_"+_eid).attr("ebaseid");
			if(ebaseid == 1 || ebaseid == 7 || ebaseid == 8 || ebaseid == 'news') {
				onRefresh(_eid,ebaseid);
			}
		}catch(e){
			//alert(e.message);
		}
	}
}
document.onmousemove=function(e){
	e=e||event;
	if(dragobj.o!=null){
		dragobj.o.style.zIndex="1";
	   dragobj.o.style.left=(e.x-dragobj.xx[0])+"px";
	   dragobj.o.style.top=(e.y-dragobj.xx[1])+"px";
	   dragobj.o.style.left=e.clientX;
		dragobj.o.style.top=e.clientY+document.body.scrollTop;
	   //�Զ��������֣���ʾ�Ϸ�Ч��
	   createtmpl(e);
	}
}
//ȡ����������
function mouseCoords(ev){
	if(ev.pageX || ev.pageY){
		return {x:ev.pageX, y:ev.pageY};
	}
	return {
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
		y:ev.clientY + document.body.scrollTop  - document.body.clientTop
	};
}
//ȡ��λ�÷ֱ�Ϊ�ϣ��󣬿���,����Ԫ�ر�����ͬһ������
function getxy(e){
	var a=new Array();
	var t=e.offsetTop;
	var l=e.offsetLeft;
	var w=e.offsetWidth;
	var h=e.offsetHeight;
	while(e=e.offsetParent){
	   t+=e.offsetTop;
	   l+=e.offsetLeft;
	}
	a[0]=t;a[1]=l;a[2]=w;a[3]=h;
	   return a;
}
//�ж�e��o��λ��
function inner(o,e){
var a=getxy(o)
//����Ƿ���o���ڲ�
if(e.x>a[1]&&e.x<(a[1]+a[2])&&e.y>a[0]&&e.y<(a[0]+a[3]))
{	
   if(e.y<(a[0]+a[3]/2))
	   //�ϰ벿��
		return 1;
   else
		return 2;
}else
   return 0;
}
//
function createtmpl(e){
	var items=$(".item");
	for(var i=0;i<items.length;i++){
	   if(!items[i] || items[i]==dragobj.o)
		continue;
		//�����������
		var mousePos  = mouseCoords(e);
	   var b=inner(items[i],mousePos);
	   if(b==0)
			continue;
	  dragobj.otemp.style.width="auto";
	   if(b==1){
			items[i].parentNode.insertBefore(dragobj.otemp,items[i]);
	   }
	   else{
			if(items[i].nextSibling==null){
				items[i].parentNode.appendChild(dragobj.otemp);
			}else{
				items[i].parentNode.insertBefore(dragobj.otemp,items[i].nextSibling);
			}
	   }
}
//�����Ϸ����߽�������
var groups=$(".group");
	for(var j=0;j<groups.length;j++){
	   if(groups[j].innerHTML.inc("div")||groups[j].innerHTML.inc("DIV"))
			continue;
	   var op=getxy(groups[j]);
	   if(e.x>(op[1]+10)&&e.x<(op[1]+op[2]-10)){
			groups[j].appendChild(dragobj.otemp);
			dragobj.otemp.style.width=(op[2]-10)+"px";
	   }
	}
}
