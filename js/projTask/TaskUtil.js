function addRow(){
        var oRow;      
        oRow = tblTask.insertRow(-1);     
        oRow.className="DataLight";  
        iRowIndex++ ;
        if(RowindexNum==undefined){
        	RowindexNum=0;
        	iRowIndex=0;
        }
        RowindexNum++;
        oRow.id="tr_"+iRowIndex;
        oRow.customIndex = iRowIndex;
        for (var i = 1; i <= 10; i++) {
            oCell = oRow.insertCell(-1);
    		oCell.align = "left";
           
            var oDiv = document.createElement("div");
            var sHtml=""; 
            switch (i){               
               case 1: //���	                    
                    oCell.style.backgroundColor="#e7e7e7";
					if(readCookie("languageidweaver")==8){
						oCell.title="click then move"; 
					}
					if(readCookie("languageidweaver")==9){
						oCell.title="�Γ��x��Ȼ����τ�";
					}
					else {
						oCell.title="����ѡ�� Ȼ����϶�";  
					}	                        
                    oCell.onclick=function(){onDragTDDBClick(this);};
                    sHtml=RowindexNum+"<input type='hidden' name='templetTaskId' value='-1'><input type='hidden' name='txtRowIndex' id='txtRowindex_"+iRowIndex+"' value='"+iRowIndex+"'>";
                    break ;
                case 2: //checkbox ��	                    
                    sHtml="<input type='checkbox' class='inputStyle' name='chkTaskItem' id='chkTaskItem_"+iRowIndex+"' value='"+iRowIndex+"'>";                   
                    break ;
				case 3: //��������	
                    oCell.align = "right";
                    sHtml="<table><tr width='100%'><td><div id='taskNameDiv_"+iRowIndex+"' align='right'  valign='bottom'><img id='img_"+iRowIndex+"' style='visibility:hidden;cursor:pointer' src='/images/project_rank.gif' onclick='onImgClick(this,"+iRowIndex+")' imgState='show' ><div></td><td><input type='txtTaskName' class='inputStyle' name='txtTaskName'      id='txtTaskName_"+iRowIndex+"' onchange='onTaskNameChange(this,"+iRowIndex+")' size='24'  customIndex='"+iRowIndex+"'></td></tr></table>";  
                    break ;
                case 4: //����						
                    sHtml="<input type='txtWorkLong' class='inputStyle' name='txtWorkLong'  size='4' id='txtWorkLong_"+iRowIndex+"'  onKeyPress='ItemNum_KeyPress(this)' onchange='onWorkLongChange(this,txtBeginDate_"+iRowIndex+",spanBeginDate_"+iRowIndex+",txtEndDate_"+iRowIndex+",spanEndDate_"+iRowIndex+")'>"; 
                    break ;
                case 5: //��ʼʱ��						
                    sHtml="<button type=\"button\" class=Calendar onclick='onShowBeginDate(txtBeginDate_"+iRowIndex+",spanBeginDate_"+iRowIndex+",txtEndDate_"+iRowIndex+",spanEndDate_"+iRowIndex+",txtWorkLong_"+iRowIndex+")'></BUTTON>"+
                          "<SPAN id=spanBeginDate_"+iRowIndex+" ></SPAN>"+
                          "<input type='hidden' name='txtBeginDate' id='txtBeginDate_"+iRowIndex+"'>";                
                    break ;
                case 6: //����ʱ��						
                   sHtml="<button type=\"button\" class=Calendar onclick='onShowEndDate(txtEndDate_"+iRowIndex+",spanEndDate_"+iRowIndex+",txtBeginDate_"+iRowIndex+",spanBeginDate_"+iRowIndex+",txtWorkLong_"+iRowIndex+")'></BUTTON>"+
                          "<SPAN id=spanEndDate_"+iRowIndex+" ></SPAN>"+
                          "<input type='hidden' name='txtEndDate' id='txtEndDate_"+iRowIndex+"'>";                
                   break ;
                case 7: //ǰ������						
                    //sHtml="<select name='seleBeforeTask' id='seleBeforeTask_"+iRowIndex+"'  onchange='onBeforeTaskChange(this,"+iRowIndex+")'><option value='0'></option></select>";
                	sHtml="<button type=\"button\" class=Browser onclick='onSelectBeforeTask(seleBeforeTaskSpan_"+iRowIndex+",seleBeforeTask_"+iRowIndex+")'></button><input type=hidden name='seleBeforeTask' id='seleBeforeTask_"+iRowIndex+"' value=''  oninput='beforeTask_check(this)'  onpropertychange='beforeTask_check(this)'><span id='seleBeforeTask_TD'><span id='seleBeforeTaskSpan_"+iRowIndex+"'></span></span><input type=hidden name='index_"+iRowIndex+"' id='index_"+iRowIndex+"' value='"+iRowIndex+"'>";
                    break ;
                case 8: //Ԥ��	 					
                    sHtml="<input type='text' class='inputStyle' name='txtBudget' size='8' id='txtBudget_"+iRowIndex+"' onKeyPress='ItemNum_KeyPress(this)'>";                
                    break ;
                case 9: //������		
                    //sHtml="<select  name='txtManager' id='txtManager_"+iRowIndex+"'  ><option value='0'></option></select>";
                	sHtml="<button type=\"button\" class=Browser onclick='onSelectManager(txtManagerSpan_"+iRowIndex+",txtManager_"+iRowIndex+")'></button><input type=hidden name='txtManager' id='txtManager_"+iRowIndex+"' value=''><span id='txtManagerSpan_"+iRowIndex+"'></span>";
                    break ;
                case 10: //������	                ;<a href='javaScript:downLevel("+iRowIndex+")'
					if(readCookie("languageidweaver")==8){
						sHtml="<img title='up' src='/images/leftup.gif' border='0' onclick='upLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></img>&nbsp;&nbsp<img  title='down'     src='/images/rightDown.gif' border='0'  onclick='downLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></img>";               
					}
					else if(readCookie("languageidweaver")==9)
					{
						sHtml="<img title='����' src='/images/leftup.gif' border='0' onclick='upLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></ img>&nbsp;&nbsp<img title='����' src='/images/rightDown.gif' border='0' onclick='downLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></img>";
					}
					else {						
						sHtml="<img title='����' src='/images/leftup.gif' border='0' onclick='upLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></img>&nbsp;&nbsp<img  title='����'     src='/images/rightDown.gif' border='0'  onclick='downLevel("+iRowIndex+")' style='cursor:pointer;width:20px'></img>";                      
					}	                    
                    break ;
                default:
                    sHtml=" ";                
                    break ;
            }
            //alert(sHtml)
            oDiv.innerHTML = sHtml;
			oCell.appendChild(oDiv);              
        }
        //�ѽڵ�����ĵ�������                 
        addNode(iRowIndex)

        //���һ��
        oRow = tblTask.insertRow(-1); 
        oRow.className="Line";
        oCell = oRow.insertCell(-1)
        oCell.colSpan="10";

        //�ƶ�����Ӧ�Ľ����ȥ

      // addRowNeedMove(iRowIndex,lastSelectedTRObj);
    }

    function addOption(idStr,valueStr,rowIndex){
          var txtManagerObj3 = document.getElementById("txtManager_"+rowIndex);                           
          txtManagerObj3.options.add(new Option(valueStr,idStr));
    }

    function removeAllManager(){
    	//�޸���Ŀ��Աʱ�����κ�����
    }
    
    function getAllSelelt(){
    	var resultStr = "";
    	var txtManagerObjs = document.getElementsByName("txtManager");  
         for (var i=0;i<txtManagerObjs.length;i++){
             var obj = txtManagerObjs[i];
             resultStr += obj.value+"|";
         }
         return resultStr;
    }
    
    function addSeleValue (oldSelectValue){
    	//�޸���Ŀ��Աʱ�����κ�����    	
    }

	function isContainValue(selectObj,optionValue) {
		for (var i=0;i<selectObj.options.length ;i++ )	{
			var option = selectObj.options.item(i);
			if (option.value==optionValue)	return "true";
		}
		return "false";
	}
    function getObj(objId){
        try {
            var obj = document.getElementById(objId);
            return obj;
        } catch(ex){
            return null;
        }

    }

	function getUseableRowIndex(){
        try {
           var objTRs=tblTask.getElementsByTagName("TR");
		   var returnIndex=null;
		   if(objTRs!=null){
			   for(var i=0;i<objTRs.length;i++){
				   if(i>10) break;				  
				   if(objTRs[i].customIndex!=null) {
					   returnIndex=objTRs[i].customIndex;
					   //alert(objTRs[i].customIndex)
					   break;
				   }
			   }
		   }
		   return returnIndex;
        } catch(ex){
            return null;
        }

    }

    function onCheckAll(obj){
        var taskItems = document.getElementsByName("chkTaskItem");
        for (var i=0;i<taskItems.length;i++){
            taskItems[i].checked= obj.checked ;
        }
    }

    function onTaskNameChange(txtObj,rowIndex){      
    	/**
		var seleBeforeTaskObjs = document.getElementsByName("seleBeforeTask");
		if(seleBeforeTaskObjs == "[object]"){
			alert("");
			return;
		}
		for (var i=0;i<seleBeforeTaskObjs.length;i++){
			var selectValue = seleBeforeTaskObjs[i].value ;
			
			var optionIndex = getOptionIndex( seleBeforeTaskObjs[i].options,rowIndex);
			if (optionIndex!=-1)  seleBeforeTaskObjs[i].options.remove(optionIndex);     
			if (txtObj.value!="") {
				seleBeforeTaskObjs[i].options.add(new Option(txtObj.value,rowIndex),optionIndex) ;			
				seleBeforeTaskObjs[i].value = selectValue;
			}
		}   
		*/     
    }

    function getOptionIndex (optionsObj,objValue){
        for (var i=0 ;i<optionsObj.length;i++){
            if (optionsObj[i].value == objValue){
                return i;
            }
        }
        return -1;
    }
    
    //�ж�ǰ�������Ƿ�Ϸ� by alan
    function beforeTask_check(obj) {
    	var oldindex = -1;
    	var oldobjs = document.getElementsByName('seleBeforeTask');
    	for(var i=1; i<=oldobjs.length; i++) {
    		if(oldobjs[i-1]==obj) {
    			oldindex = i;
    		}
    	}
    	var tdobjs = $('#seleBeforeTask_TD');
    	if(oldindex==obj.value) {
    		$(tdobjs[oldindex-1]).find('span').html("");
    		$(obj).val("0");
			if(readCookie("languageidweaver")==8){
				alert("Can't let hisself set his prefix task!");
			} 
			else if(readCookie("languageidweaver")==9){ 
				alert("���ܰѱ����O�Þ�ǰ���΄�!"); 
			}
			else {
				alert("���ܰѱ�������Ϊǰ������!"); 
			}
    	}
    }

    //��ǰֵ����ı��ʱ��
    function onBeforeTaskChange(obj,selfIndex){
        var beforeTaskValue = obj.value;	
        if (beforeTaskValue==0) return false;
	
		
        //�õ���������Ķ���
         var selfTaskBeginDateObj = document.getElementById("txtBeginDate_"+selfIndex);
         var selfTaskBeginDateSpanObj = document.getElementById("spanBeginDate_"+selfIndex);

         var selfTaskEndDateObj = document.getElementById("txtEndDate_"+selfIndex);
         var selfTaskEndDateSpanObj = document.getElementById("spanEndDate_"+selfIndex);

         var selfWorkLongObj = document.getElementById("txtWorkLong_"+selfIndex);

   
        //�õ�ǰ���κεĶ���
         var beforeTaskBeginDateObj = document.getElementById("txtBeginDate_"+beforeTaskValue);
         var beforeTaskBeginDateSpanObj = document.getElementById("spanBeginDate_"+beforeTaskValue);

         var beforeTaskEndDateObj = document.getElementById("txtEndDate_"+beforeTaskValue);
         var beforeTaskEndDateSpanObj = document.getElementById("spanEndDate_"+beforeTaskValue);

         var beforeWorkLongObj = document.getElementById("txtWorkLong_"+beforeTaskValue);

            //���ǰ������Ľ���ʱ����ڱ�������Ŀ�ʼʱ�� ��ô�޸ı��������ʱ��
         if (beforeTaskEndDateObj.value>selfTaskBeginDateObj.value||selfTaskBeginDateObj.value=='') {
            var newValue = getAddNewDateStr(beforeTaskEndDateObj.value,2);
            selfTaskBeginDateObj.value = newValue;
            selfTaskBeginDateSpanObj.innerHTML = newValue;
            if (selfWorkLongObj.value!="") {
                var newValue2 =getAddNewDateStr(selfTaskBeginDateObj.value,parseInt(selfWorkLongObj.value));
                selfTaskEndDateObj.value = newValue2;
                selfTaskEndDateSpanObj.innerHTML=newValue2;
            }
         }    
		 
		 	
		//�ж�ǰ������ѡ����ǲ����䱾��
		//�õ��õ��������������	
		//alert(beforeTaskValue+" "+selfIndex);
		if (beforeTaskValue==selfIndex)	{
			if(readCookie("languageidweaver")==8){
				alert("Can't let hisself set his prefix task!");
			} 
			else if(readCookie("languageidweaver")==9){ 
				alert("���ܰѱ����O�Þ�ǰ���΄�!"); 
			}
			else {
				alert("���ܰѱ�������Ϊǰ������!"); 
			}	
			obj.value=0;	
			return false;
		}
   }
  //����������ĺ�����ͨ��
  //�������Ϊ-1 ��ʾ,sDate1��sDate2С
  function dateDiffForJava(sDate1, sDate2){  //sDate1��sDate2��2002-12-18��ʽ
    var aDate, oDate1, oDate2, iDays
    oDate1=new Date(sDate1);
	oDate2=new Date(sDate2);
	if(""+oDate1.getFullYear()=="NaN"){
		aDate = sDate1.split("-")
	    oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])  //ת��Ϊ12-18-2002��ʽ
	    aDate = sDate2.split("-")
	    oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])
    }
	if (oDate2-oDate1>=0) {
        iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24)  //�����ĺ�����ת��Ϊ����
        iDays=iDays+1;
    } else {        
		iDays = -1 	    
	}
    return iDays
  }

//�ж�input�����Ƿ������������,����С����
  function ItemNum_KeyPress(obj){
     var event=getEvent();
	  tmpvalue = obj.value;
     var count = 0;
     var len = -1;
     len = tmpvalue.length; 
     for(i = 0; i < len; i++){
        if(tmpvalue.charAt(i) == "."){
        count++;     
        }
     }
     if(!((event.keyCode>=48 && event.keyCode<=57) || (event.keyCode==46 &&len>=1&& count == 0))) {           
    	 event.keyCode=0;         
      }
  }

  function upLevel(rowIndex){
		moveNodeUp(rowIndex);
		modiChildsSize();
  }

  function downLevel(rowIndex){        
	  moveNodeDown(rowIndex);
	  modiChildsSize();
  }

 function onImgClick(obj,rowIndex){   
    if ($(obj).attr("imgState")=='show'){
        obj.src='/images/project_rank2.gif'
        obj.imgState='hidden'
        	showTRchilds(rowIndex,"hidden");
    } else {
        obj.src='/images/project_rank.gif'
        obj.imgState='show'
        	showTRchilds(rowIndex,"visible");
    }
 }
  
 function onHiddenImgClick(divObj,imgObj){
     if (imgObj.objStatus=="show"){
        divObj.style.display='none' ;       
        imgObj.src="/images/down.jpg";
		if(readCookie("languageidweaver")==8){
			imgObj.title="click then expand";
		}
		else if(readCookie("languageidweaver")==9){ 
			imgObj.title="�c��չ�_"; 
		}
		else {
			imgObj.title="���չ��";
		}	       
        imgObj.objStatus="hidden";
        if (divObj==divTaskList){
            divAddAndDel.style.display='none' ; 
        }
     } else {        
        divObj.style.display='' ;    
        imgObj.src="/images/up.jpg";
		if(readCookie("languageidweaver")==8){
			imgObj.title="click then hidden";
		}
		else if(readCookie("languageidweaver")==9){ 
			imgObj.title="�c���[��"; 
		}
		else {
			imgObj.title="�������";
		}        
        imgObj.objStatus="show";
        if (divObj==divTaskList){

            divAddAndDel.style.display='' ; 
        }
     }
 }
   function  getXmlDocStr1(){      
        str = ptu.getXmlDocStr();
        document.all("areaLinkXml").value=  str ;    
   }


 function addSelManager(strId,strValue){ 
	 //�޸���Ŀ��Աʱ�����κδ���
  }
 
  function protectProjTemplet(event){ 
  	//if(!checkDataChange()) {//added by cyril on 2008-06-12 for TD:8828
			if(readCookie("languageidweaver")==8){
				return event.returnValue="Project templet isn't save. if you left data will be lost ,are you srue?";
			}
			else if(readCookie("languageidweaver")==9)
			{
				return event.returnValue="�Ŀģ��߀�]���棬����x�_�������Gʧ���������Ҫ�x�_�᣿";
			}
			else {
				return event.returnValue="��Ŀģ�廹û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��";
				//return("��ǰҳ����޸�û�б��棬ȷ���˳���");
			} 
	//	}        
  }

  function protectProj(e){ 
  	//if(!checkDataChange()) {//added by cyril on 2008-06-12 for TD:8828
		/*  if(readCookie("languageidweaver")==8){
			    event.returnValue="Project  isn't save. if you left data will be lost ,are you srue?";			
			} 
			else if(readCookie("languageidweaver")==9)
			{
				event.returnValue="�Ŀ߀�]���棬����x�_�������Gʧ���������Ҫ�x�_�᣿";
			} 
			else {
				event.returnValue="��Ŀ��û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��";
			}
			*/
  	  e=e||event;
	  e.returnValue="��Ŀ��û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��";
    //}
   }