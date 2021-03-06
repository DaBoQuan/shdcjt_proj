// 说明：给 Javascript 数组添加一个 indexOf 方法
[].indexOf || (Array.prototype.indexOf = function(v){
     for(var i = this.length; i-- && this[i] !== v;);
     return i;
	 }); 
// 取消check框后面跟随的红色惊叹号
function checkboxCheck(elementname,spanid){
	if(elementname.checked){
		elementname.value="1";
		spanid.innerHTML='';
	}
	else{
		elementname.value="";
		spanid.innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
	}
}
// 取消输入框后面跟随的红色惊叹号
function checkinput(elementname,spanid){
	var tmpvalue = $GetEle(elementname).value;
	// 处理$GetEle可能找不到对象时的情况，通过id查找对象
    if(tmpvalue==undefined)
        tmpvalue=document.getElementById(elementname).value;

	while(tmpvalue.indexOf(" ") >= 0){
		tmpvalue = tmpvalue.replace(" ", "");
	}
	if(tmpvalue != ""){
		while(tmpvalue.indexOf("\r\n") >= 0){
			tmpvalue = tmpvalue.replace("\r\n", "");
		}
		if(tmpvalue != ""){
			$GetEle(spanid).innerHTML = "";
		}else{
			$GetEle(spanid).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			//$GetEle(elementname).value = "";
		}
	}else{
		$GetEle(spanid).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		//$GetEle(elementname).value = "";
	}
}
// 判断email格式是否正确
// modified by lupeng 2004.06.04.
function checkinput_email(elementname,spanid){
	emailStr = $GetEle(elementname).value;
	emailStr = emailStr.replace(" ","");
	if (emailStr == "" || !checkEmail(emailStr)) {
		$GetEle(spanid).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		$GetEle(elementname).value = "";
	} else
		$GetEle(spanid).innerHTML = "";
}
// added by xwj 2004.06.04.
function checkinput_email_only(elementname,spanid,flag){
    if(flag){
      checkinput_email(elementname,spanid);
    }
    else{
     var emailStr = $GetEle(elementname).value;
     emailStr = emailStr.replace(" ","");
     if(!checkEmail(emailStr)){
        $GetEle(spanid).innerHTML = "";
        $GetEle(elementname).value = "";
     }
    }
}
/**
 * Reference: Sandeep V. Tamhankar (stamhankar@hotmail.com), Added by lupeng
 * 2004.06.04.
 */
function checkEmail(emailStr) {	
   if (emailStr.length == 0) {
	   return true;
   }
   var emailPat=/^(.+)@(.+)$/;
   var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
   var validChars="\[^\\s" + specialChars + "\]";
   var quotedUser="(\"[^\"]*\")";
   var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;
   var atom=validChars + '+';
   var word="(" + atom + "|" + quotedUser + ")";
   var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
   var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");
   var matchArray=emailStr.match(emailPat);
   if (matchArray == null) {
	   return false;
   }
   var user=matchArray[1];
   var domain=matchArray[2];
   if (user.match(userPat) == null) {
	   return false;
   }
   var IPArray = domain.match(ipDomainPat);
   if (IPArray != null) {
	   for (var i = 1; i <= 4; i++) {
		  if (IPArray[i] > 255) {
			 return false;
		  }
	   }
	   return true;
   }
   var domainArray=domain.match(domainPat);
   if (domainArray == null) {
	   return false;
   }
   var atomPat=new RegExp(atom,"g");
   var domArr=domain.match(atomPat);
   var len=domArr.length;
   if ((domArr[domArr.length-1].length < 0) ||
	   (domArr[domArr.length-1].length > 50)) {
	   return false;
   }
   if (len < 2) {
	   return false;
   }
   return true;
}

// ------------- added by xwj for td3131 数字金额小写转大写 20051115-----------*/
function numberChangeToChinese(num) {
	var prefh="";
	if(!isNaN(num)){
	    if(num<0){
	        prefh="负";
	        num=Math.abs(num);
	    }
	}
	if (isNaN(num) || num > Math.pow(10, 12)) return "";
	var cn = "零壹贰叁肆伍陆柒捌玖";
	var unit = new Array("拾佰仟", "分角");
	var unit1= new Array("万亿万", "");
	var numArray = num.toString().split(".");
	var start = new Array(numArray[0].length-1, 2);

	function toChinese(num, index)
	{
	var num = num.replace(/\d/g, function ($1)
	{
	return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1);
	});
	return num;
	}

	for (var i=0; i<numArray.length; i++)
	{
	var tmp = "";
	for (var j=0; j*4<numArray[i].length; j++)
	{
	var strIndex = numArray[i].length-(j+1)*4;
	var str = numArray[i].substring(strIndex, strIndex+4);
	var start = i ? 2 : str.length-1;
	var tmp1 = toChinese(str, i);
	tmp1 = tmp1.replace(/(零.)+/g, "零").replace(/零+$/, "");
	// tmp1 = tmp1.replace(/^壹拾/, "拾")
	tmp = (tmp1+unit1[i].charAt(j-1)) + tmp;
	}
	numArray[i] = tmp ;
	}

	numArray[1] = numArray[1] ? numArray[1] : "";
	numArray[0] = numArray[0] ? numArray[0]+"圆" : numArray[0], numArray[1] = numArray[1].replace(/^零+/, "");
	numArray[1] = numArray[1].match(/分/) ? numArray[1] : numArray[1]+"整";
	var money =  numArray[0]+numArray[1];
	money = money.replace(/(亿万)+/g, "亿"); 
	if(money=="整"){
		money="零圆整";
	}else{
	    money=prefh+money;
	}
	return money;
}
// ------------- added by xwj for td3131 数字金额大写转小写 20051115-----------*/
// 数字金额大写转小写
function chineseChangeToNumber(num) {
	var prefh="";
	if(num.length>0){
	    if(num.indexOf("负")==0){
	        prefh="-";
	        num=num.substr(1);
	    }
	}

	var numArray = new Array()
	var unit = "万亿万圆$";
	for (var i=0; i<unit.length; i++)
	{
	var re = eval("/"+ (numArray[i-1] ? unit.charAt(i-1) : "") +"(.*)"+unit.charAt(i)+"/");
	if (num.match(re))
	{
	// numArray[i] = num.match(re)[1].replace(/^拾/, "壹拾")
	numArray[i] = numArray[i].replace(/[零壹贰叁肆伍陆柒捌玖]/g, function ($1)
	{
	return "零壹贰叁肆伍陆柒捌玖".indexOf($1);
	});
	numArray[i] = numArray[i].replace(/[分角拾佰仟]/g, function ($1)
	{
	return "*"+Math.pow(10, "分角 拾佰仟 ".indexOf($1)-2)+"+";
	}).replace(/^\*|\+$/g, "").replace(/整/, "0");
	numArray[i] = "(" + numArray[i] + ")*"+Math.ceil(Math.pow(10, (2-i)*4));
	}
	else numArray[i] = 0;
	}
	return prefh+eval(numArray.join("+"));
}

function floatFormat(num)
{   if (num!=null)
{
    
    num  =  num+"";  
	ary = num.split(".");
	if(ary.length==1){
		if(num == "")
			num = "0";
		num = num + ".00";
	}else{
		if(ary[1].length<2)
			num = num + "0";
		else if(ary[1].length>2)
			num = ary[0] + "." + ary[1].substring(0,2);
	}
	} 
    return  num;  
}
// 数字千分位格式化2
function milfloatFormat(num) {       
	if (num!=null) {   
	    num  =  num+"";  
	    var  re=/(-?\d+)(\d{3})/  
	    while(re.test(num)){  
	        num=num.replace(re,"$1,$2")  
	    }  
	    return  num;  
	}
	else return "";
}

function checkinput1(elementname, spanid){
	var tmpvalue = elementname.value;

	while(tmpvalue.indexOf(" ") >= 0){
		tmpvalue = tmpvalue.replace(" ","");
	}
	while(tmpvalue.indexOf("\r\n") >= 0){
		tmpvalue = tmpvalue.replace("\r\n", "");
	}
	if(tmpvalue!=""){
		spanid.innerHTML='';
	}else{
		spanid.innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
		elementname.value = "";
	}
}
// 判断input框中是否输入的是数字,包括小数点
function ItemNum_KeyPress(elementname)
{
	var evt = getEvent();
	evt = jQuery.event.fix(evt);
	if(elementname==undefined){
		elementname = evt.target.name;
	}
	
	var keyCode = evt.which ? evt.which : evt.keyCode;
 // added by xwj for td1844 on 2005-05-12 避免多次输入小数点
 tmpvalue = $GetEle(elementname).value;
 var count = 0;
 var count2 = 0;
 var len = -1;
 if(elementname){
 len = tmpvalue.length;
 }
 for(i = 0; i < len; i++){
    if(tmpvalue.charAt(i) == "."){
    count++;     
    }
 }
 for(i = 0; i < len; i++){// 避免多次输入负号
    if(tmpvalue.charAt(i) == "-"){
    count2++;     
    }
 }
 
 //ypc 2012-09-05 修改
     if(!(((keyCode>=48) && (keyCode<=57)) || keyCode==46 || keyCode==45) || (keyCode==46 && count == 1) || (keyCode==45 && count2 == 1)){
	     if (evt.keyCode) {
     		evt.keyCode = 0;evt.returnValue=false;     
	     } else {
	     	evt.which = 0;evt.preventDefault();
	     }
	 }
}

// 判断input框中是否输入的是正整数,不包括小数点
function ItemPlusCount_KeyPress()
{
	var evt = getEvent();
	var keyCode = evt.which ? evt.which : evt.keyCode;
 if(!(((keyCode>=48) && (keyCode<=57))))
  {
     if (evt.keyCode) {
     	evt.keyCode = 0;evt.returnValue=false;     
     } else {
     	evt.which = 0;evt.preventDefault();
     }
     
	 
	 
  }
}

//金额千分位转换 2012-09-04 ypc 修改
//function clearNoNum(obj){
	//先把非数字的都替换掉，除了数字和.
	//obj.value = obj.value.replace(/[^\d.]/g,"");
	//必须保证第一个为数字而不是.
	//obj.value = obj.value.replace(/^\./g,"");
	//保证只有出现一个.而没有多个.
	//obj.value = obj.value.replace(/\.{2,}/g,".");
	//保证.只出现一次，而不能出现两次以上
	//obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
//}


// 判断input框中是否输入的是数字,不包括小数点
function ItemCount_KeyPress()
{
	var evt = getEvent();
	var keyCode = evt.which ? evt.which : evt.keyCode;
 if(!(((keyCode>=48) && (keyCode<=57))|| keyCode==45))
  {
     if (evt.keyCode) {
     	evt.keyCode = 0;evt.returnValue=false;     
     } else {
     	evt.which = 0;evt.preventDefault();
     }
     
	 
	 
  }
}

// 判断input框中是否输入的是数字,包括"-"
function ItemPhone_KeyPress()
{
	var evt = getEvent();
	var keyCode = evt.which ? evt.which : evt.keyCode;
 if(!(((keyCode>=48) && (keyCode<=57)) || keyCode==45))
  {
     
	if (evt.keyCode) {
     	evt.keyCode = 0;evt.returnValue=false;     
     } else {
     	evt.which = 0;evt.preventDefault();
     }
     
	 
	 
  }
}

// 判断input框中是否输入的是小数,包括小数点
/*
 * p（精度） 指定小数点左边和右边可以存储的十进制数字的最大个数。精度必须是从 1 到最大精度之间的值。最大精度为 38。
 * 
 * s（小数位数） 指定小数点右边可以存储的十进制数字的最大个数。小数位数必须是从 0 到 p 之间的值。默认小数位数是 0，因而 0 <= s <=
 * p。最大存储大小基于精度而变化。
 */
function ItemDecimal_KeyPress(elementname,p,s)
{	
	var evt = getEvent();
	var keyCode = evt.which ? evt.which : evt.keyCode;
	var tmpvalue = $GetEle(elementname).value;

    var dotCount = 0;
	var integerCount=0;
	var afterDotCount=0;
	var hasDot=false;

    var len = -1;
    if(elementname){
		len = tmpvalue.length;
    }
    for(i = 0; i < len; i++){
		if(tmpvalue.charAt(i)=="."){ 
			dotCount++;
			hasDot=true;
		}else{
			if(hasDot==false){
				integerCount++;
			}else{
				afterDotCount++;
			}
		}		
    }

    if(!(((keyCode>=48) && (keyCode<=57)) || keyCode==46 || keyCode==45) || (keyCode==46 && dotCount == 1)){  
		if (evt.keyCode) {
	     	evt.keyCode = 0;evt.returnValue=false;     
	     }else{
	     	evt.which = 0;evt.preventDefault();
	     }
    }
    
	if(integerCount>=p-s && hasDot==false && (keyCode>=48) && (keyCode<=57)){
		if (evt.keyCode) {
	     	evt.keyCode = 0;evt.returnValue=false;     
	     } else {
	     	evt.which = 0;evt.preventDefault();
	     }
	     
		 
		 
	}
	if(afterDotCount>=s&&integerCount>=p-s){
		 if (evt.keyCode) {
	     	evt.keyCode = 0;evt.returnValue=false;     
	     } else {
	     	evt.which = 0;evt.preventDefault();
	     }
	}
	/* 新增 */
	var rtnflg = false;
	
	var cursorPosition = getCursortPosition($G(elementname));
	
	var vidValue = $G(elementname).value;
	var dotIndex = vidValue.indexOf(".");
	if (hasDot) {
		if (cursorPosition <= dotIndex) {
			if (integerCount >= (p - s)) {
				rtnflg = true;
			}
		} else {
			if(afterDotCount >= s) {
				rtnflg = true;
			}
		}
	}
	if (rtnflg) {
		//var isie = (document.all) ? true : false;//ypc 2012-09-04  添加 //如果是IE浏览器就向下执行否则就不执行
		//if (evt.keyCode != undefined) { //ypc 2012-09-04 修改
		if (evt.keyCode != 0) { //ypc 2012-09-04 修改
		//if(isie){
			evt.keyCode = 0;
			evt.returnValue=false; 
		} else {
			evt.which = 0;
			evt.preventDefault();
		}
	}
}

/**
 * 获取光标所在位置
 */
function getCursortPosition(inputElement) {
	var CaretPos = 0; 
	if (document.selection) {
		inputElement.focus();
		var Sel = document.selection.createRange();
		Sel.moveStart('character', -inputElement.value.length);
		CaretPos = Sel.text.length;
	} else if (inputElement.selectionStart || inputElement.selectionStart == '0') { //ff
		CaretPos = inputElement.selectionStart;
	}
	return (CaretPos);
}


// 判断input框中是否输入的是数字,不包括小数点
function checkcount(objectname)
{
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) {
		charnumber = parseInt(valuechar[i]);
		if( isNaN(charnumber) && (valuechar[i]!="-" || (valuechar[i]=="-" && i!=0))){
			isnumber = true ;
		}
		if (valuechar.length==1 && valuechar[i]=="-"){
		    isnumber = true ;
		}
	}
	if(isnumber){
		$GetEle(objectname).value = "" ;
	}
}

//用于验证值的范围在最小值与最大值之间。否则清空值。
function checkItemScale(obj,msg, minValue,maxValue){
	var val = obj.value;
	if(val != ""){
		//去掉数字之前的多余的0
		if(val.indexOf("0") == 0){
			while(val.indexOf("0") == 0){
				val = val.substring(1);
			}
		} else {
			while(val.indexOf("-") == 0 && val.indexOf("0") == 1){
				val = "-" + val.substring(2);
			}
		}
		
		try{
			val = parseInt(val);
			if(val < minValue || val > maxValue){
				alert(msg);
				obj.value = "";
				return false;
			} else {
				obj.value = val;
				return true;
			}
		}catch(e){
			obj.value = "";
			return false;
		}
	}
}

//检查浮点型数字的正确性。
function checkFloat(obj)
{
	var value = obj.value;
	if(value != ""){
		//var reg = /^-?\d+\.?\d+$/;
		var reg = /^(-?\d+)(\.\d+)?$/;
		if (!reg.test(value)){
			obj.value = "";
		}
	}
}

//验证整数的正确性
function checkcount1(obj)
{
	var value = obj.value;
	if(value != ""){
		var reg = /^-?\d+$/;
		if (!reg.test(value)){
			obj.value = "";
		}
	}
}


// 判断input框中是否输入的是数字,包括小数点
function checknumber(objectname)
{
	/*
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	var hasdian = false;
	for(i=0 ; i<valuechar.length ; i++) { 
		charnumber = parseInt(valuechar[i]) ; 
		if( isNaN(charnumber)&& valuechar[i]!="." && valuechar[i]!="-"){
			isnumber = true ;
		}
		if((valuechar[i]=="."&&i==0&&hasdian==false)||(valuechar[i]=="-"&&i>0)){
			isnumber = true ;
		}
		if(valuechar[i]=="."){
			hasdian = true;
		}
		if (valuechar.length==1 && valuechar[i]=="-"){
		    isnumber = true ;
		}
	}
	if(isnumber){
		$GetEle(objectname).value = "" ;
	}
	*/
	var objValue=$GetEle(objectname).value;
	if(objValue!=parseFloat(objValue))
	    $GetEle(objectname).value = "" ;
}
function checknumber1(objectname)
{
	valuechar = objectname.value.split("") ;
	isnumber = false ;
	var hasdian = false;
	for(i=0 ; i<valuechar.length ; i++) {
		charnumber = parseInt(valuechar[i]) ; 
		if( isNaN(charnumber)&& valuechar[i]!="." && valuechar[i]!="-"){
			isnumber = true ;
		}
		if((valuechar[i]=="."&&i==0&&hasdian==false)||(valuechar[i]=="-"&&i>0)){
			isnumber = true ;
		}
		if(valuechar[i]=="."){
			hasdian = true;
		}
		if (valuechar.length==1 && valuechar[i]=="-"){
		    isnumber = true ;
		}
	}
	if(isnumber){
		objectname.value = "" ;
	}
}
// 判断input框中是否输入的是正整数
function checkPlusnumber1(objectname)
{
	valuechar = objectname.value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)) isnumber = true ;}
	if(isnumber) objectname.value = "" ;
}

// 判断input框中是否输入的是数字,包括"-"
function checkphone(objectname)
{
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!="-") isnumber = true ;}
	if(isnumber) $GetEle(objectname).value = "" ;
}
function checkphone1(objectname)
{
	valuechar = objectname.value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!="-") isnumber = true ;}
	if(isnumber) objectname.value = "" ;
}

function ItemTime_KeyPress()
{
	var evt = getEvent();
	var keyCode = evt.which ? evt.which : evt.keyCode;
 if(!((keyCode>=48) && (keyCode<=58)))
  {
		if (evt.keyCode) {
	     	evt.keyCode = 0;
	     	evt.returnValue=false;     
	     } else {
	     	evt.which = 0;
	     	evt.preventDefault();
	     }
  }
}

function checktime(objectname)
{
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=":") isnumber = true ;}
	if(isnumber) $GetEle(objectname).value = "" ;
}

function checktime1(objectname)
{
	valuechar = objectname.value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=":") isnumber = true ;}
	if(isnumber) objectname.value = "" ;
}


// 判断input框中是否输入的是英文字母和数字，并且以字母开头
function checkinput_char_num(objectname)
{
	valuechar = $GetEle(objectname).value.split("") ;
	if(valuechar.length==0){
	    return ;
	}
	notcharnum = false ;
	notchar = false ;
	notnum = false ;
	for(i=0 ; i<valuechar.length ; i++) {
		notchar = false ;
		notnum = false ;
		charnumber = parseInt(valuechar[i]) ; if(isNaN(charnumber)) notnum = true ;
		// if(valuechar[i].toLowerCase()<'a' || valuechar[i].toLowerCase()>'z')
		// notchar = true ;
		if((valuechar[i].toLowerCase()<'a' || valuechar[i].toLowerCase()>'z')&&valuechar[i]!='_') notchar = true ;
		if(notnum && notchar) notcharnum = true ;
	}
	if(valuechar[0].toLowerCase()<'a' || valuechar[0].toLowerCase()>'z') notcharnum = true ;
	if(notcharnum) $GetEle(objectname).value = "" ;
}

// 检测input框中输入的小数中的整数部分是否超过限制的位数
function checkdecimal_length(elementname,maxlength)
{
	if(!isNaN(parseInt($GetEle(elementname).value)) && (maxlength > 0)){
		inputTemp = $GetEle(elementname).value ;
		if (inputTemp.indexOf(".") !=-1)
		{
			inputTemp = inputTemp.substring(0,inputTemp.indexOf("."));
		}
		if (inputTemp.length > maxlength)
		{
			alert($GetEle(elementname).value+"的整数部分超过"+maxlength+"位！");
			$GetEle(elementname).value = "" ;
		}
	}
}

// 截取字符串，添加省略号
// added by hubo, 2005/12/06
function ellipsis(str,lens){
	str = str.replace(/<.*?>/ig,"");
	str = str.replace(/<img.*/ig,"");
	var len = 0;
	var i;
	for(i=0;i<str.length;i++){
		len += str.charCodeAt(i)<127 ? 1 : 2;
		if(len>=lens) return str.substr(0,i+1)+"...";
	}
	return str;
}

// 去掉字符串头尾空格
// added by hubo, 2005/09/01
function trim(s){
	if(s==null){return s;}
	var i;
	var beginIndex = 0;
	var endIndex = s.length - 1;
	for(i=0;i<s.length;i++){
		if(s.charAt(i)==' ' || s.charAt(i)=='　'){
			beginIndex++;
		}else{
			break;
		}
	}
	for(i=s.length-1;i>=0;i--){
		if(s.charAt(i)==' ' || s.charAt(i)=='　'){
			endIndex--;
		}else{
			break;
		}
	}
	if(endIndex<beginIndex){return "";}
	return s.substring(beginIndex, endIndex + 1);
}

// *****************************************
// added by hubo, 2005/08/31
function doSwitch(objTbls){
	var evt = getEvent();
	var spanSwitch = evt.srcElement||evt.target;
    if (spanSwitch.nodeName=="IMG") spanSwitch = $(spanSwitch).parent()[0];
	var tblList = (objTbls).split(",");
	for(i=0;i<tblList.length;i++){
		if(document.getElementById(tblList[i])==null) continue;
		with(document.getElementById(tblList[i])){
			if(tBodies[0].style.display=="none"){
				$(tBodies[0]).show();
				spanSwitch.innerHTML = "<img src='/images/up.jpg' style='cursor:pointer'> ";
			}else{
				tBodies[0].style.display = "none";
				spanSwitch.innerHTML = "<img src='/images/down.jpg' style='cursor:pointer'>";
			}
		}
	}

}
// by ben 2005-12-26

function doSwitchx(obj){
	var evt = getEvent();
	var spanSwitch = evt.srcElement||evt.target;;
    if (spanSwitch.nodeName=="IMG") spanSwitch = spanSwitch.parentElement;
	
			if($GetEle(obj).style.display=="none"){
				$GetEle(obj).style.display = "";
				spanSwitch.innerHTML = "<img src='/images/up.jpg' style='cursor:hand'> ";
			}else{
				$GetEle(obj).style.display = "none";
				spanSwitch.innerHTML = "<img src='/images/down.jpg' style='cursor:hand'>";
			}
		}
	
function doSwitchx(obj,show,hidden){
	var evt = getEvent();
	var spanSwitch = evt.srcElement||evt.target;
    if (spanSwitch.tagName=="IMG") spanSwitch = spanSwitch.parentElement;
	
			if($GetEle(obj).style.display=="none"){
				$GetEle(obj).style.display = "";
				spanSwitch.innerHTML = "<img src='/images/up.jpg' style='cursor:hand' title='"+hidden+"'> ";
			}else{
				$GetEle(obj).style.display = "none";
				spanSwitch.innerHTML = "<img src='/images/down.jpg' style='cursor:hand' title='"+show+"' >";
			}
		}
function checkint(objectname)
{
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)) isnumber = true ;}
	if(isnumber) $GetEle(objectname).value = "" ;
}	

function checkintc(objectname,temp)
{
	valuechar = $GetEle(objectname).value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; 
	if( isNaN(charnumber)) isnumber = true ;}
	if(isnumber) $GetEle(objectname).value = "" ;
	else 
	{
	if (parseInt($GetEle(objectname).value)>parseInt(temp))
	$GetEle(objectname).value=parseInt(temp);
	}
}		
function change2input(a,b)
{

if (parseFloat(a)>parseFloat(b))
{
return true;
}
else
{
return false;
}
}
// by ben 2006-1-17
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
  else szFeatures +="scrollbars=yes," ;
  szFeatures +="resizable=yes" ; 
  window.open(redirectUrl,"new",szFeatures) ;
}

function openNewFullWindow(url){
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
  else szFeatures +="scrollbars=yes," ;
  szFeatures +="resizable=yes" ;
  window.open(redirectUrl,"",szFeatures) ;
}
var flag = false;
//数据加载未完成的时候 置灰底部tab
function enablebottommenu(){
	try{
		//显示底部tab菜单
		if(window.ActiveXObject){
			for (b=0;b<parent.document.getElementById("requestTabButton").all.length;b++){
				if(parent.document.getElementById("requestTabButton").all.item(b).tagName == "LI"){
					//alert("未完成="+b);
					parent.document.getElementById("requestTabButton").all.item(b).disabled=true;
					flag = true;
				}
			}
		}else{
			jQuery("#toolbarbottommenu", parent.document).show();
		}
	}catch(e){
		
	}
}

//数据加载完成的时候 显示底部tab
function displaybottommenu(){
	try{
		//显示底部tab菜单
		if(window.ActiveXObject){
			for (b=0;b<parent.document.getElementById("requestTabButton").all.length;b++){
				if(parent.document.getElementById("requestTabButton").all.item(b).tagName == "LI"){
					//alert("完成="+b);
					parent.document.getElementById("requestTabButton").all.item(b).disabled=false;
				}
			}
		}else{
			jQuery("#toolbarbottommenu", parent.document).hide();
		}
	}catch(e){
		
	}
}

function enablemenu()
{
	// for (a=0;a<window.frames["rightMenuIframe"].document.all.length;a++){
		// window.frames["rightMenuIframe"].document.all.item(a).disabled=true;
	// }
	window.frames["rightMenuIframe"].event.srcElement.disabled = true;

}
function enableAllmenu()
{
	var _document = document.getElementById("rightMenuIframe").contentWindow.document;
	var menuBtns = jQuery("#menuTable button", _document);
	// TD9015 点击任一按钮，把所有"BUTTON"给灰掉
	for (a=0;a<menuBtns.length;a++){
		jQuery(menuBtns[a]).attr("disabled", true);
	}
	// window.frames["rightMenuIframe"].event.srcElement.disabled = false;
	
	try{// ext菜单灰色
		parent.Ext.getCmp('tabPanelContent').getTopToolbar().disable();// 鼠标灰掉
	}catch(e){
	}
	try{
		// 头部菜单灰色
		if (window.ActiveXObject) {
			for (b=0;b<parent.document.getElementById("toolbarmenu").all.length;b++){
				if(parent.document.getElementById("toolbarmenu").all.item(b).tagName == "TABLE"){
					parent.document.getElementById("toolbarmenu").all.item(b).disabled=true;
				}
			}
		} else {
			jQuery("#toolbarmenuCoverdiv", parent.document).show();
		}
		
	}
	catch(e)
	{
	}
	//只做一次置灰色操作
	if(flag==false){
		enablebottommenu();
	}
}
function displayAllmenu()
{
	var _document = document.getElementById("rightMenuIframe").contentWindow.document;
	var menuBtns = jQuery("#menuTable button", _document);
	// TD9015 点击任一按钮，把所有"BUTTON"给灰掉
	for (a=0;a<menuBtns.length;a++){
		jQuery(menuBtns[a]).attr("disabled", false);
	}
	try{// ext菜单弄白
		parent.Ext.getCmp('tabPanelContent').getTopToolbar().enable();// 释放鼠标
	}catch(e){
	}
	try{
		// 显示头部菜单
		if (window.ActiveXObject) {
			for (b=0;b<parent.document.getElementById("toolbarmenu").all.length;b++){
				if(parent.document.getElementById("toolbarmenu").all.item(b).tagName == "TABLE"){
					parent.document.getElementById("toolbarmenu").all.item(b).disabled=false;
				}
			}
		} else {
			jQuery("#toolbarmenuCoverdiv", parent.document).hide();
		}
	}
	catch(e)
	{
	}
	//只做一次置会操作
	//if(flag==false){
		displaybottommenu();
	//}
}

function enableAllmenuParent(){
	try{//ext菜单灰色
		Ext.getCmp('tabPanelContent').getTopToolbar().disable();//鼠标灰掉
	}catch(e){
	}
	try{
		//头部菜单灰色
		if (window.ActiveXObject) {
			for (b=0;b<document.getElementById("toolbarmenu").all.length;b++){
				if(document.getElementById("toolbarmenu").all.item(b).tagName == "TABLE"){
					document.getElementById("toolbarmenu").all.item(b).disabled=true;
				}
			}
		} else {
			jQuery("#toolbarmenuCoverdiv", parent.document).show();
		}
	}catch(e){
	}
}
// *****************************************

function showMsgBox(o, msg, t, l){
	with(o){
		innerHTML = msg;
		style.display = "inline";
		style.position = "absolute"
		style.posTop = t||(document.body.offsetHeight/2+document.body.scrollTop-50);
		style.posLeft = l||(document.body.offsetWidth/2-50);
	}
}


/*
 * Function: 取字符串字节长度 Document by by 2007-3-9
 */
function realLength(str) {
	var j=0;
	for (var i=0;i<=str.length-1;i++) {
		j=j+1;
		if ((str.charCodeAt(i))>127) {
			j=j+1;
		}
	}
	return j;
}

// 中文作为3个字节处理
function realLengthOnly(str)
{
	var j=0;
	for (var i=0;i<=str.length-1;i++)
	{
		j=j+1;
		if ((str.charCodeAt(i))>127)
		{
			j=j+2;
		}
	}
	return j;
}

// 只检查长度
function checkLengthOnly(elementname,len,fieldname,msg,msg1,msg2)
{
	len = len*1;
	try{
		var str = FCKEditorExt.getHtml(elementname);
		if(len!=0 && realLengthOnly(str)>len){
			alert("【"+fieldname+"】"+msg1+len+","+"("+msg2+")\n\n【"+fieldname+"】"+msg+":"+realLengthOnly(str));
			return false;
		}
	}catch(e){
		var str = $GetEle(elementname).value;
		if(len!=0 && realLengthOnly(str)>len){
			alert("【"+fieldname+"】"+msg1+len+","+"("+msg2+")\n\n【"+fieldname+"】"+msg+":"+realLengthOnly(str));
			return false;
		}
	}
	return true;
}
function checkLength(elementname,len,fieldname,msg,msg1) {
	len = len*1;
	var str = $GetEle(elementname).value;
	// 处理$GetEle可能找不到对象时的情况，通过id查找对象
    if(str == undefined) {
        str = document.getElementById(elementname).value;
    }
    
	if(len!=0 && realLength(str) > len){
		alert(fieldname + msg + len + "," + "(" + msg1 + ")");
		while(true){
			str = str.substring(0, str.length - 1);
			if(realLength(str) <= len){
				$GetEle(elementname).value = str;
				return;
			}
		}
	}
}
function checkLengthAndCut(elementname,len,fieldname,msg,msg1)
{
	len = len*1;
	var str = $GetEle(elementname).value;
	// 处理$GetEle可能找不到对象时的情况，通过id查找对象
    if(str==undefined)
        str=document.getElementById(elementname).value;
	if(len!=0 && realLength(str)>len){
		alert(fieldname+msg+len+"("+msg1+")");
		while(true){
			str = str.substring(0,str.length-1);
			if(realLength(str)<=len){
				$GetEle(elementname).value = str;
				return false;
			}
		}
	}
	return true;
}
function checkLengthfortext(elementname,len,fieldname,msg,msg1)
{
	len = len*1;
	var str = $GetEle(elementname).value;
	if(len!=0 && realLengthOnly(str)>len){
		alert(fieldname+msg+len+","+"("+msg1+")");
		var str2="";
		var flag = true;
		while(true){
			while(flag){
				if(str.length > len){
					str2 = str.substring(0,len);
				}else{
					str2 = str.substring(0,str.length/2);
				}
				str2 = str.substring(0,str.length/2);
				if(realLengthOnly(str2)>len){
					str=str2;
				}else{
					flag=false;
				}
			}
			if(realLengthOnly(str)<=len){
				$GetEle(elementname).value = str;
				return;
			}
			str = str.substring(0,str.length-1);
		}
	}
/*
 * delete by cyril on 2008-08-12 cut error var str=$GetEle(elementname).value;
 * 
 * var j=parseInt(realLength(str)); var len1=parseInt(len);
 * 
 * if (len1!=0) { if (j>len1) { alert(fieldname+msg+len+","+"("+msg1+")"); if
 * (len1<2) { len1=2; }
 * $GetEle(elementname).value=str.substring(0,parseInt(len1/2 - 1)); } }
 */
}

function checkLength4Read(elementname,spanname,len,fieldname,msg,msg1){
	len = len*1;
	var str = $GetEle(elementname).value;
	if(len!=0 && realLengthOnly(str)>len){


		alert(fieldname+msg+len+","+"("+msg1+")");
		var str2="";
		var flag = true;
		while(true){
			while(flag){
				if(str.length > len){
					str2 = str.substring(0,len);
				}else{
					str2 = str.substring(0,str.length/2);
				}
				if(realLengthOnly(str2)>len){
					str=str2;
				}else{
					flag=false;
				}
			}
			if(realLengthOnly(str)<=len){
				$GetEle(elementname).value = str;
				$GetEle(spanname).innerHTML = str;
				return;
			}
			str = str.substring(0,str.length-1);
		}
	}

}

function checkLengthbrow(elementname,spanname,len,fieldname,msg,msg1,demand)
{
var str=$GetEle(elementname).value;

var j=parseInt(realLength(str));
var len1=parseInt(len);

if (len1!=0)
{
if (j>len1)
{
	alert(fieldname+msg+len+","+"("+msg1+")");
	if (len1<2)
	{
		len1=2;
	}
	$GetEle(elementname).value="";
	
	if (demand==1)
	{
		$GetEle(spanname).innerHTML="<img src=\"/images/BacoError.gif\" align=absmiddle>";
	}
	else
	{
		$GetEle(spanname).innerHTML="";
	}

	

}
}
}


function checkLength1(elementname,len,fieldname,langu)
{var msg;
 var msg1;
 if (langu==7)
 {

	msg="文本长度不能超过";
	msg1="1个中文字符等于2个长度";
 }
 else if (langu==9)
 {
	msg="文本長度不能超過"; 
	msg1="1個中文字符等於2個長度";	
 }
 else
 {
 msg="text length can not exceed";
 msg1="one gb2312 char equals tow char";
 }
var str=elementname.value;

var j=parseInt(realLength(str));
var len1=parseInt(len);

if (len1!=0)
{
if (j>len1)
{
	alert(fieldname+msg+len+","+"("+msg1+")");
	if (len1<2)
	{
		len1=2;
	}
	elementname.value=str.substring(0,parseInt(len1/2 - 1));
}
}
}


/* 一个页面有多个名字相同的文本框时，检测它们输入的是否为数字，包括小数点 */
function check_number(objectname){
   for( var i=0;i<document.getElementsByName(objectname).length;i++){
     if(checkinputnumber(document.getElementsByName(objectname)[i].value)){
         document.getElementsByName(objectname)[i].value = "";
     } 
   }
}
function checkinputnumber(objectname){
	valuechar = objectname.split("");
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { 
	    charnumber = parseInt(valuechar[i]) ; 
	    if( isNaN(charnumber)&& valuechar[i]!=".") 
	    isnumber = true ;
	}
	return isnumber;
}
// 取消输入框后面跟随的红色惊叹号
function checkinput2(elementname,spanid,viewtype){
	if (wuiUtil.isNullOrEmpty(viewtype)) {
		viewtype = $G(elementname).getAttribute("viewtype");
	}
	
	if(viewtype==1){
		var tmpvalue = "";
		try{
			tmpvalue = $GetEle(elementname).value;
		}catch(e){
			tmpvalue = $GetEle(elementname).value;
		}
		while(tmpvalue.indexOf(" ") >= 0){
			tmpvalue = tmpvalue.replace(" ", "");
		}
		while(tmpvalue.indexOf("\r\n") >= 0){
			tmpvalue = tmpvalue.replace("\r\n", "");
		}
		if(tmpvalue!=""){
			$GetEle(spanid).innerHTML = "";
		}else{
			$GetEle(spanid).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			$GetEle(elementname).value = "";
		}
	}
}
function checkinput3(elementname,spanid,viewtype){
	if (viewtype == undefined || viewtype == null) {
		viewtype = elementname.getAttribute('viewtype');
		if (viewtype == undefined || viewtype == null) {
			try {
				var callerStr = checkinput3.caller.toString();
				var param = callerStr.substring(callerStr.indexOf("checkinput3("), callerStr.indexOf(".viewtype)")).split(",");
				
				var targetfield = jQuery.trim(param[param.length - 1]);
				viewtype = $G(targetfield).getAttribute("viewtype");
			} catch (e) {
				viewtype = 0;
			}
		}
	}
	
	if(viewtype==1){
		var tmpvalue = elementname.value;

		while(tmpvalue.indexOf(" ") >= 0){
			tmpvalue = tmpvalue.replace(" ", "");
		}
		while(tmpvalue.indexOf("\r\n") >= 0){
			tmpvalue = tmpvalue.replace("\r\n", "");
		}
		if(tmpvalue!=""){
			 spanid.innerHTML='';
		}else{
			spanid.innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
			elementname.value = "";
		}
    }
}
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function changeshowattr(fieldid,fieldvalue,rownum,workflowid,nodeid){
    len = document.forms[0].elements.length;
    var ajax=ajaxinit();
    ajax.open("POST", "/workflow/request/WorkflowChangeShowAttrAjax.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("workflowid="+workflowid+"&nodeid="+nodeid+"&fieldid="+fieldid+"&fieldvalue="+fieldvalue);
    // 获取执行状态
    ajax.onreadystatechange = function() {
        // 如果执行状态成功，那么就把返回信息写到指定的层里
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
            var returnvalues=ajax.responseText;
            if(returnvalues!=""){
                var tfieldid=fieldid.split("_");
                var isdetail=tfieldid[1];
                var fieldarray=returnvalues.split("&");
                for(n=0;n<fieldarray.length;n++){
                    var fieldattrs=fieldarray[n].split("$");
                    var fieldids=fieldattrs[0];
                    var fieldattr=fieldattrs[1];
                    var fieldidarray=fieldids.split(",");
                    if(fieldattr==-1){ // 没有设置联动，恢复原值和恢复原显示属性
                        for(i=0;i<len;i++){
                            for(j=0;j<fieldidarray.length;j++){
                                var tfieldidarray=fieldidarray[j].split("_");
                                if (tfieldidarray[1]==isdetail){
                                    if(rownum>-1){  // 明细字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]+"_"+rownum&&$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum)){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum).value;
                                            if($GetEle('field'+tfieldidarray[0]+"_"+rownum+"span")){
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if(isedit==3){
                                                	document.forms[0].elements[i].setAttribute('viewtype','1');
                                                    if(document.forms[0].elements[i].value==""&&$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")<=0) $GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
                                                    try{
														if(document.forms[0].elements[i].value==""&&$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")<=0){
															$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
															$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
														}
													}catch(e){}
                                                    if(checkstr_.indexOf("field"+tfieldidarray[0]+"_"+rownum+",")<0) $GetEle("needcheck").value=checkstr_+"field"+tfieldidarray[0]+"_"+rownum;
                                                }
                                                if(isedit==2){
                                                	document.forms[0].elements[i].setAttribute('viewtype','0');
                                                    if($GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")>-1) $GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
                                                    try{
														if($GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")>-1){
															$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
														}
													}catch(e){}
													$GetEle("needcheck").value=checkstr_.replace("field"+tfieldidarray[0]+"_"+rownum+",","");
                                                }
                                            }
                                        }
                                    }else{     // 主字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]&&$GetEle('oldfieldview'+tfieldidarray[0])){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]).value;
                                            if($GetEle('field'+tfieldidarray[0]+"span")){
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if(isedit==3) {
                                                	document.forms[0].elements[i].setAttribute('viewtype','1');
                                                    if(document.forms[0].elements[i].value=="") $GetEle('field'+tfieldidarray[0]+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
                                                    try{
														if(document.forms[0].elements[i].value==""){
															$GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
															$GetEle('field'+tfieldidarray[0]+"span").innerHTML="";
														}
													}catch(e){}
                                                    if(checkstr_.indexOf("field"+tfieldidarray[0]+",")<0) $GetEle("needcheck").value=checkstr_+"field"+tfieldidarray[0];
                                                }
                                                if(isedit==2) {
                                                	document.forms[0].elements[i].setAttribute('viewtype','0');
                                                    if($GetEle('field'+tfieldidarray[0]+"span").innerHTML.indexOf("/images/BacoError.gif")>-1) $GetEle('field'+tfieldidarray[0]+"span").innerHTML="";
                                                    try{
														if($GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML.indexOf("/images/BacoError.gif")>-1){
															$GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML="";
														}
													}catch(e){}
													$GetEle("needcheck").value=checkstr_.replace("field"+tfieldidarray[0]+",","");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(fieldattr==1){// 为编辑，显示属性设为编辑
                        for(i=0;i<len;i++){
                            for(j=0;j<fieldidarray.length;j++){
                                var tfieldidarray=fieldidarray[j].split("_");
                                if (tfieldidarray[1]==isdetail){
                                    if(rownum>-1){  // 明细字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]+"_"+rownum&&$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum)){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum).value;
                                            if(isedit>1&&$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span")){
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if($GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")>-1) $GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
                                                try{
													if($GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")>-1){
														$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
													}
												}catch(e){}
                                                $GetEle("needcheck").value=checkstr_.replace("field"+tfieldidarray[0]+"_"+rownum+",","");
                                                document.forms[0].elements[i].setAttribute('viewtype','0');
                                            }
                                        }
                                    }else{     // 主字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]&&$GetEle('oldfieldview'+tfieldidarray[0])){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]).value;
                                            if(isedit>1&&$GetEle('field'+tfieldidarray[0]+"span")){
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if($GetEle('field'+tfieldidarray[0]+"span").innerHTML.indexOf("/images/BacoError.gif")>-1) $GetEle('field'+tfieldidarray[0]+"span").innerHTML="";
                                                try{
													if($GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML.indexOf("/images/BacoError.gif")>-1){
														$GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML="";
													}
												}catch(e){}
                                                $GetEle("needcheck").value=checkstr_.replace("field"+tfieldidarray[0]+",","");
                                                document.forms[0].elements[i].setAttribute('viewtype','0');
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(fieldattr==2){// 为必填，显示属性设为编辑
                        for(i=0;i<len;i++){
                            for(j=0;j<fieldidarray.length;j++){
                                var tfieldidarray=fieldidarray[j].split("_");
                                if (tfieldidarray[1]==isdetail){
                                    if(rownum>-1){  // 明细字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]+"_"+rownum&&$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum)){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]+"_"+rownum).value;
                                            if(isedit>1&&$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span")){
                                                if(document.forms[0].elements[i].value==""&&$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")<=0) $GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
                                                try{
													if(document.forms[0].elements[i].value==""&&$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML.indexOf("/images/BacoError.gif")<=0){
														$GetEle('field_lable'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
														$GetEle('field'+tfieldidarray[0]+"_"+rownum+"span").innerHTML="";
													}
												}catch(e){}
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if(checkstr_.indexOf("field"+tfieldidarray[0]+"_"+rownum+",")<0) $GetEle("needcheck").value=checkstr_+"field"+tfieldidarray[0]+"_"+rownum;
                                                document.forms[0].elements[i].setAttribute('viewtype','1');
                                            }
                                        }
                                    }else{     // 主字段
                                        if(document.forms[0].elements[i].name=='field'+tfieldidarray[0]&&$GetEle('oldfieldview'+tfieldidarray[0])){
                                            isedit=$GetEle('oldfieldview'+tfieldidarray[0]).value;
                                            if(isedit>1&&$GetEle('field'+tfieldidarray[0]+"span")){
                                                if(document.forms[0].elements[i].value=="") $GetEle('field'+tfieldidarray[0]+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
                                                try{
													if(document.forms[0].elements[i].value==""){
														$GetEle('field_lable'+tfieldidarray[0]+"span").innerHTML="<IMG src='/images/BacoError.gif' align=absMiddle>";
														$GetEle('field'+tfieldidarray[0]+"span").innerHTML="";
													}
												}catch(e){}
                                                var checkstr_=$GetEle("needcheck").value+",";
                                                if(checkstr_.indexOf("field"+tfieldidarray[0]+",")<0) $GetEle("needcheck").value=checkstr_+"field"+tfieldidarray[0];
                                                document.forms[0].elements[i].setAttribute('viewtype','1');
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
                // alert($GetEle("needcheck").value);
            }catch(e){}
        }
    }
}
function  upWord()
{
if(top.document.body.style.zoom!=0) 
top.document.body.style.zoom*=1.1; 
else top.document.body.style.zoom=1.1;
}

function  lowWord()
{
if(top.document.body.style.zoom!=0) 
	top.document.body.style.zoom*=0.9; 
else top.document.body.style.zoom=0.9;
}

function changeToThousands(inputfieldname){
    sourcevalue = $GetEle(inputfieldname).value;
    if(sourcevalue.indexOf(".")<0)
        re = /(\d{1,3})(?=(\d{3})+($))/g;
    else
        re = /(\d{1,3})(?=(\d{3})+(\.))/g;
    tovalue = sourcevalue.replace(re,"$1,");
    $GetEle(inputfieldname).value = tovalue;
}

function changeToNormalFormat(inputfieldname){
    sourcevalue = $GetEle(inputfieldname).value;
    tovalue = sourcevalue.replace(/,/g,"");
    $GetEle(inputfieldname).value = tovalue;
}
function getFckText(fckValue){
	var textValue = "";
	try{
    	while(fckValue.indexOf("</p>") >= 0){
			fckValue = fckValue.replace("</p>", "_=+=_");
		}
		while(fckValue.indexOf("</P>") >= 0){
			fckValue = fckValue.replace("</P>", "_=+=_");
		}
		var div = document.createElement("div");
		div.innerHTML = fckValue;
		fckValue = div.innerText;

		while(fckValue.indexOf("_=+=_") >= 0){
			fckValue = fckValue.replace("_=+=_", "&dt;&at;");
		}
		textValue = fckValue;
	}catch(e){
	}
	return textValue;
}

// ***********************************************************************
// 函数名 ：checkMaxLength（TD9084）
// 机能概要 ：对指定字符串按字节长截取，超过时给出提示，超过部分去除
// 参数说明 ：obj 输入框对象
// 注意：对象的maxlength、alt须设定，alt为信息内容
// 返回值 ：
// ***********************************************************************
function checkMaxLength(obj){
	var tmpvalue = obj.value;
	var size = obj.maxLength;
	if(realLength(tmpvalue) > size){
		alert(obj.alt);
		while(true){
			tmpvalue = tmpvalue.substring(0,tmpvalue.length-1);
			if(realLength(tmpvalue)<=size){
				obj.value = tmpvalue;
				return;
			}
		}
	}
}
function doshowmrsndiv(fieldid){
	try{
		document.getElementById("mrsnspan"+fieldid).style.display = "";
		document.getElementById("mrsnaspan"+fieldid).style.display = "none";
	}catch(e){
		alert(e);
	}
}

function enablePhraseselect(){
	try{
		document.getElementById("phraseselect").disabled = true;
	}catch(e){}
}
function displayPhraseselect(){
	try{
		document.getElementById("phraseselect").disabled = false;
	}catch(e){}
}

function getEvent() {
	if (window.ActiveXObject) {
		return window.event;// 如果是ie
	}
	func = getEvent.caller;
	while (func != null) {
		var arg0 = func.arguments[0];
		if (arg0) {
			if ((arg0.constructor == Event || arg0.constructor == MouseEvent)
					|| (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
				return arg0;
			}
		}
		func = func.caller;
	}
	return null;
}

/**
 * 根据标识（name或者id）获取元素，主要用于解决系统中很多元素没有id属性，
 * 却在js中使用document.getElementById(name)来获取元素的问题。
 * @param identity name或者id
 * @return 元素
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
function autoFrameSize(down) { 
//--------------------------------------------------------------------------
// 如果使用此方法进行iFrame的高度、宽度同步，将会造成签字意见区域布局变形
// 如：iFrame内有元素定义宽度为1000px，通过此方法将iFrame的宽度同步至1000px
// 而显示区域只有600px，那么整个布局就乱了。
// 现去掉此方法，如果客户提出了此问题，则直接给客户单独修改
//--------------------------------------------------------------------------
/*
	var pTar = null; 
	if (document.getElementById){ 
		pTar = document.getElementById(down); 
	} else{ 
		eval('pTar = ' + down + ';'); 
	} 
	if (pTar && !window.opera){  
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){ 
			pTar.height = pTar.contentDocument.body.offsetHeight + 20; 
			pTar.width = pTar.contentDocument.body.scrollWidth + 20; 
		} else if (pTar.Document && pTar.Document.body.scrollHeight){ 
			pTar.height = pTar.Document.body.scrollHeight; 
			pTar.width = pTar.Document.body.scrollWidth; 
		} 
	} 
*/
}