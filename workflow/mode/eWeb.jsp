<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="weaver.general.Util" %>
<script language=javascript src="/js/weaver.js"></script>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String acceptlanguage = request.getHeader("Accept-Language");
if(!"".equals(acceptlanguage))
	acceptlanguage = acceptlanguage.toLowerCase();
int wfid=Util.getIntValue(request.getParameter("wfid"),0);
int formid=Util.getIntValue(request.getParameter("formid"),0);
int nodeid=Util.getIntValue(request.getParameter("nodeid"),0);
int modeid=Util.getIntValue(request.getParameter("modeid"),0);
int isbill=Util.getIntValue(request.getParameter("isbill"),-1);
int isprint=Util.getIntValue(request.getParameter("isprint"),-1);
int isform=Util.getIntValue(request.getParameter("isform"),0);
String ajax=Util.null2String(request.getParameter("ajax"));
// �Ƿ���������ͼ�λ��༭
String design = Util.null2String(request.getParameter("design"));
int languageid=user.getLanguage();

rs.executeSql("select nodetype from workflow_flownode where nodeid="+nodeid);
String nodetype = "0";
if(rs.next()){
	nodetype = rs.getString("nodetype");
}
String hrmremain="";
String deptremain="";
String subcomremain="";
String loanbalance="";
String oldamount="";
if(isbill==1&&(formid==156 ||formid==157 ||formid==158 ||formid==159)){
    rs.executeSql("select fieldname,id,type,fieldhtmltype from workflow_billfield where viewtype=1 and billid="+formid);
    while(rs.next()){
        if("hrmremain".equals(Util.null2String(rs.getString("fieldname")).toLowerCase())){
            hrmremain="field"+rs.getString("id")+"_0_"+rs.getString("type")+"_"+rs.getString("fieldhtmltype");
        }
        if("deptremain".equals(Util.null2String(rs.getString("fieldname")).toLowerCase())){
            deptremain="field"+rs.getString("id")+"_0_"+rs.getString("type")+"_"+rs.getString("fieldhtmltype");
        }
        if("subcomremain".equals(Util.null2String(rs.getString("fieldname")).toLowerCase())){
            subcomremain="field"+rs.getString("id")+"_0_"+rs.getString("type")+"_"+rs.getString("fieldhtmltype");
        }
        if("loanbalance".equals(Util.null2String(rs.getString("fieldname")).toLowerCase())){
            loanbalance="field"+rs.getString("id")+"_0_"+rs.getString("type")+"_"+rs.getString("fieldhtmltype");
        }
        if("oldamount".equals(Util.null2String(rs.getString("fieldname")).toLowerCase())){
            oldamount="field"+rs.getString("id")+"_0_"+rs.getString("type")+"_"+rs.getString("fieldhtmltype");
        }
    }
}
%>
<html>

<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<!--Style Sheets First one to adjust fonts on input fields.-->
<LINK rel=stylesheet type=text/css HREF="chinaexcel.css">
<SCRIPT  LANGUAGE=JAVASCRIPT src="/js/characterConv.js"></SCRIPT>
<SCRIPT  LANGUAGE=VBSCRIPT src="functions.vbs"></SCRIPT>

<SCRIPT  LANGUAGE=JAVASCRIPT src="commands.js"></SCRIPT>

<title></title>

<SCRIPT LANGUAGE="javascript">
function getOuterLanguage()
{
	return '<%=acceptlanguage%>';
}
var language=readCookie("languageidweaver");
function stop () {
    if(language==8){
        alert("ShangHai Weaver Software Report Editor!");
    }
    else if(language==9){ 
        alert ('�Ϻ���΢ܛ������OӋ����'); 
    }
    else{
        alert ('�Ϻ���΢��������������');
    }
return false;
}
document.oncontextmenu=stop;
var loaded=false;
function deleteA(){    
    var StartRow=CellWeb1.GetSelectRegionStartRow();
    var StartCol=CellWeb1.GetSelectRegionStartCol();
    var EndRow=CellWeb1.GetSelectRegionEndRow();
    var EndCol=CellWeb1.GetSelectRegionEndCol();
    var uservalue="";
    var k=StartRow;
    var j=StartCol;
    for(k; k <= EndRow ; k++){
        j=StartCol;
        for(j; j <= EndCol; j++){            
            uservalue=CellWeb1.GetCellUserStringValue(k,j);
            if(uservalue!=null && uservalue!=""){
                CellWeb1.SetCellProtect(k,j,k,j,false);
                CellWeb1.SetCellNormalType(k,j);
                CellWeb1.DeleteCellImage(k,j,k,j);
                //CellWeb1.HorzTextAlign = 1;
                CellWeb1.SetCellUserValue(k,j,k,j,0);
                try{
                parent.fieldlist.document.getElementById(uservalue).style.display='';
                }catch(e){}
                if(uservalue.indexOf("_head")>0 || uservalue.indexOf("_end")>0 || uservalue.indexOf("_isprintbegin")>0 || uservalue.indexOf("_isprintend")>0){
                    CellWeb1.DeleteRow(k,k);
                    EndRow--;
                    k--;
                    break;
                }
                CellWeb1.SetCellUserStringValue(k,j,k,j,"");
                CellWeb1.SetCellDigitShowStyle(k,j,k,j,-1,2);
                CellWeb1.SetCellVal(k,j,"");
            }            
        }
    }
    CellWeb1.RefreshViewSize();
}
function hidefield(){
    var maxrow=CellWeb1.GetMaxRow();
    var maxcol=CellWeb1.GetMaxCol();
    var userstr="";
    var userval=0; 
    var hiderowstart=0;
    var hiderowend=0;
    var mandatoryfield="";
    var showfield="";
    var editfield="";
    for(var i=1;i<=maxrow;i++){        
        for(var j=1;j<=maxcol;j++){
            userstr=CellWeb1.GetCellUserStringValue(i,j);
            userval=CellWeb1.GetCellUserValue(i,j);
            if(userstr.indexOf("field")>-1){
                if(userval==0){
                    showfield+=userstr.substring(5,userstr.indexOf("_"))+",";
                }
                if(userval==1){
                    editfield+=userstr.substring(5,userstr.indexOf("_"))+",";
                }
                if(userval==2){
                    mandatoryfield+=userstr.substring(5,userstr.indexOf("_"))+",";
                }
            }
            if(userstr=="requestname"){//ģ�������ñ���
            		if(userval==0){
                    showfield+="-1,";
                }
                if(userval==1){
                    editfield+="-1,";
                }
                if(userval==2){
                    mandatoryfield+="-1,";
                }
            }
            if(userstr=="requestlevel"){//ģ�������ý����̶�
            		if(userval==0){
                    showfield+="-2,";
                }
                if(userval==1){
                    editfield+="-2,";
                }
                if(userval==2){
                    mandatoryfield+="-2,";
                }
            }
            if(userstr=="messageType"){//ģ�������ö�������
            		if(userval==0){
                    showfield+="-3,";
                }
                if(userval==1){
                    editfield+="-3,";
                }
                if(userval==2){
                    mandatoryfield+="-3,";
                }
            }
            if(userstr=="qianzi"){//ģ��������ǩ��
            		if(userval==0){
                    showfield+="-4,";
                }
                if(userval==1){
                    editfield+="-4,";
                }
                if(userval==2){
                    mandatoryfield+="-4,";
                }
            }
            if(userstr.indexOf("_isneed")>0||userstr.indexOf("_isdefault")>0){
            	
            }
            if(userval>0){                
                CellWeb1.SetCellProtect(i,j,i,j,false);
            }else{
                if(userstr.indexOf("_sel")<0){
                    CellWeb1.SetCellProtect(i,j,i,j,true);
                }
            }
            if(userstr.length>0){
                //��ͷ��β��ʶ
                /*
                var htmltype=userstr.substring(userstr.lastIndexOf("_")+1);                
                if(htmltype=="3" || htmltype=="6"){
                    CellWeb1.SetCellProtect(i,j,i,j,true);
                }
                */
                if(userstr.indexOf("_head")>0 || userstr.indexOf("_end")>0 || userstr.indexOf("_isprintbegin")>0 || userstr.indexOf("_isprintend")>0){
                    if(userstr.indexOf("_head")>0) hiderowstart=i;
                    if(userstr.indexOf("_end")>0) hiderowend=i;
                    if(hiderowstart>0 && hiderowend>0){
                        CellWeb1.SetRowHide(hiderowstart,hiderowend,true);
                        hiderowstart=0;
                        hiderowend=0;
                    }
                    if(userstr.indexOf("_isprintbegin")>0) hiderowstart=i;
                    if(userstr.indexOf("_isprintend")>0) hiderowend=i;
                    if(hiderowstart>0 && hiderowend>0){
                        CellWeb1.SetRowHide(hiderowstart,hiderowend,true);
                        hiderowstart=0;
                        hiderowend=0;
                    }
                    break;
                }else{
                    if(userstr.indexOf("_add")<0 && userstr.indexOf("_del")<0&& userstr.indexOf("_showKeyword")<0&& userstr.indexOf("_createCodeAgain")<0){
                        var cellval=CellWeb1.GetCellValue(i,j);
                        if(cellval.indexOf("@")<0){
                            CellWeb1.SetCellVal(i,j,"");
                        }
                    }
                }
            }
        }
    }
    if(mandatoryfield.length>1){
       mandatoryfield=mandatoryfield.substring(0,mandatoryfield.length-1);
    }
    if(showfield.length>1){
       showfield=showfield.substring(0,showfield.length-1);
    }
    if(editfield.length>1){
       editfield=editfield.substring(0,editfield.length-1);
    }
    form1.mandatoryfields.value=mandatoryfield;
    form1.editfields.value=editfield;
    form1.viewfields.value=showfield;
}
function showfield(){
    var maxrow=CellWeb1.GetMaxRow();
    var maxcol=CellWeb1.GetMaxCol();
    var userstr="";
    var userval=0;
    var hiderowstart=0;
    var hiderowend=0;
    for(var i=1;i<=maxrow;i++){
        for(var j=1;j<=maxcol;j++){
            userstr=CellWeb1.GetCellUserStringValue(i,j);             
            if(userstr.length>0){
                if(userstr.indexOf("_sel")<0){
                    CellWeb1.SetCellProtect(i,j,i,j,true);
                }
                //��ͷ��β��ʶ
                if(userstr.indexOf("_head")>0 || userstr.indexOf("_end")>0 || userstr.indexOf("_isprintbegin")>0 || userstr.indexOf("_isprintend")>0){
                    if(userstr.indexOf("_head")>0) hiderowstart=i;
                    if(userstr.indexOf("_end")>0) hiderowend=i;
                    if(hiderowstart>0 && hiderowend>0){
                        CellWeb1.SetRowHide(hiderowstart,hiderowend,false);
                        hiderowstart=0;
                        hiderowend=0;
                    }
                    if(userstr.indexOf("_isprintbegin")>0) hiderowstart=i;
                    if(userstr.indexOf("_isprintend")>0) hiderowend=i;
                    if(hiderowstart>0 && hiderowend>0){
                        CellWeb1.SetRowHide(hiderowstart,hiderowend,false);
                        hiderowstart=0;
                        hiderowend=0;
                    }
                    try{
                        parent.fieldlist.document.getElementById(userstr).style.display='none';
                    }catch(e){}
                    break;
                }else{
                    if(userstr.indexOf("_add")<0 && userstr.indexOf("_del")<0 && userstr.indexOf("_sel")<0&& userstr.indexOf("_showKeyword")<0&& userstr.indexOf("_createCodeAgain")<0){
                        try{
                            var cellval=CellWeb1.GetCellValue(i,j);
                            if(cellval.indexOf("@")<0){
                                CellWeb1.SetCellVal(i,j,"��$"+getChangeField(parent.fieldlist.document.getElementById(userstr).value)+"��");
                            }else{
                                CellWeb1.SetCellProtect(i,j,i,j,false);
                            }
                        }catch(e){}
                    }
                }
                try{
                    parent.fieldlist.document.getElementById(userstr).style.display='none';
                }catch(e){}
            }else{
                CellWeb1.SetCellProtect(i,j,i,j,false);
            }
        }
    }
}
function testSave(){
    if(currentver>systemver){
        if(language==8){
            alert("Warning:Your machine's Report editor edition is higher than the server edition, can't Save the works!");
        }
        else if(language==9){ 
             alert("���棺���C����汾��춷������汾�����܌�ģ���M�б��棡"); 
        }
        else{
            alert("���棺��������汾���ڷ������汾�����ܶ�ģ����б��棡");
        }
        return;
    }
    if(currentver<systemver){
        if(language==8){
            alert("Warning:Your machine's Report editor edition is lower than the server edition, can't Save the works!");
        }
        else if(language==9){ 
             alert("���棺���C����汾��춷������汾�����܌�ģ���M�б��棡"); 
        }
        else{
            alert("���棺��������汾���ڷ������汾�����ܶ�ģ����б��棡");
        }
        return;
    }

   
    
    CellWeb1.ShowHeader=false;
    CellWeb1.ShowGrid =false;
    hidefield();
    //alert(form1.modestring.value)
    if('<%=design%>'!='1'){
  
	    form1.modestring.value=CellWeb1.SaveDataAsZipText();
		document.form1.submit();
	}else{
		
		// ������ͼ�λ��༭ʱ��ͨ��ajax��ʽ�ύ���ݣ�����ˢ�±�ҳ��
		hidefield();
		var url = getFormUrl();
		
		var xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlHttp.onreadystatechange = function(){
			
			if (xmlHttp.readyState == 4) {
				try{
					var result = xmlHttp.responseText.replace(/(^\s*)|(\s*$)/g, "");
					if(result=='0'){
						alert("<%=SystemEnv.getHtmlLabelName(22620,user.getLanguage())%>");
					}else{
						alert("<%=SystemEnv.getHtmlLabelName(18758,user.getLanguage())%>");
						
						if(window.dialogArguments!=null){
							//window.dialogArguments.designOnClose();
						}
						<%if(design.equals("1")){%>
						try{
							parent.dialogArguments.window.document.location.href = parent.dialogArguments.window.document.location.href + "&randnum=" + new Date().getTime();
						}catch(e){}
						<%}%>
					}
					CellWeb1.ShowHeader=true;
   					CellWeb1.ShowGrid =true;
					showfield();
				}catch(e){
					alert("<%=SystemEnv.getHtmlLabelName(22620,user.getLanguage())%>");
				}
		    }
		}
		xmlHttp.open("POST", url, true);
		xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		var modestring = CellWeb1.SaveDataAsZipText();
		modestring = myescapecode(modestring);
		xmlHttp.send("modestring="+modestring);
	}
}
// ��ȡform��Ϣ
function getFormUrl(){
	var url = document.form1.action;
	var _paras = "";
	for(var i=0;i<document.form1.elements.length;i++ ){
		if(document.form1.elements[i].name == "modestring"){
			continue;
		}
		_paras+="&"+document.form1.elements[i].name+"="+document.form1.elements[i].value;
	}
	
	return url+"?"+_paras.substring(1,_paras.length);
}

function InitFontname(){
	strFontnames = CellWeb1.GetDisplayFontNames();
	var arrFontname = strFontnames.split('|');
	arrFontname.sort();
	var i;
	var sysFont;
	sysFont = "����";
		
	for( i =0; i < arrFontname.length;i++ ){
		if(arrFontname[i] != "")
		{
			var oOption = document.createElement("OPTION");
			FontNameSelect.options.add(oOption);
			oOption
			oOption.innerText = arrFontname[i];
			oOption.value = arrFontname[i];
			if( arrFontname[i] == sysFont ) oOption.selected = true;
		}
	}
}

function menu_init()
{
	var nMenuID;
	var bPrint;
	
	nMenuID = MenuOcx.GetMenuID("SetRowAutoSize");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.IsRowAutoSize());
	if(CellWeb1.GetJumpStyle() ==1)
	{
		nMenuID = MenuOcx.GetMenuID("JumpNextCol");
		MenuOcx.SetMenuChecked(nMenuID,true);
		nMenuID = MenuOcx.GetMenuID("JumpNextRow");
		MenuOcx.SetMenuChecked(nMenuID,false);
	}
	else
	{
		nMenuID = MenuOcx.GetMenuID("JumpNextCol");
		MenuOcx.SetMenuChecked(nMenuID,false);
		nMenuID = MenuOcx.GetMenuID("JumpNextRow");
		MenuOcx.SetMenuChecked(nMenuID,true);
	}
	nMenuID = MenuOcx.GetMenuID("SetAutoJumpNextRowCol");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.IsAutoJumpNextRowCol());
	nMenuID = MenuOcx.GetMenuID("ShowErrorMsgBox");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.ShowErrorMsgBox);
	nMenuID = MenuOcx.GetMenuID("DesignMode")
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.DesignMode);
	nMenuID = MenuOcx.GetMenuID("ShowGrid");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.ShowGrid);
	nMenuID = MenuOcx.GetMenuID("ShowHeader");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.ShowHeader);
	nMenuID = MenuOcx.GetMenuID("FormProtect");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.FormProtect);
	nMenuID = MenuOcx.GetMenuID("SetProtectFormShowCursor");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.GetProtectFormShowCursor());
	nMenuID = MenuOcx.GetMenuID("SetShowPopupMenu");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.GetShowPopupMenu());
	nMenuID = MenuOcx.GetMenuID("SetAllowRowResizing");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.IsAllowRowResizing());
	nMenuID = MenuOcx.GetMenuID("SetAllowColResizing");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.IsAllowColResizing());
	nMenuID = MenuOcx.GetMenuID("SetDClickLabelCanSort");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.GetDClickLabelCanSort());
	bPrint = CellWeb1.IsCellCanPrint(CellWeb1.Row,CellWeb1.Col);
	nMenuID = MenuOcx.GetMenuID("SetCellCanPrint");
	MenuOcx.SetMenuChecked(nMenuID,bPrint);
	bPrint = CellWeb1.IsCellOnlyPrintText(CellWeb1.Row,CellWeb1.Col);
	nMenuID = MenuOcx.GetMenuID("SetCellOnlyPrintText");
	MenuOcx.SetMenuChecked(nMenuID,bPrint);
	nMenuID = MenuOcx.GetMenuID("SetRowLabel");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.GetRowLabel());
	nMenuID = MenuOcx.GetMenuID("SetColLabel");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.GetColLabel());
	nMenuID = MenuOcx.GetMenuID("SetPrintFormBackground");
	MenuOcx.SetMenuChecked(nMenuID,CellWeb1.IsPrintFormBackground());
	nMenuID = MenuOcx.GetMenuID("SetNotPrintFormBackground");
	MenuOcx.SetMenuChecked(nMenuID,!CellWeb1.IsPrintFormBackground());
    CellWeb1.GetFocus();
}

function menu_onload()
{
	MenuOcx.style.left = 0;
	MenuOcx.style.top = 0;

	var lWidth = document.body.offsetWidth;
	if( lWidth <= 0) lWidth = 1;
	MenuOcx.style.width = "100%";

	var href = window.document.location;//ȡ��������url·��
	var  re;         // ����������
	s = href.toString();
	//alert(s);
    re = /http/;    // ����������ʽģʽ��
    if( ! s.search(re) )   // ����ƥ�������ַ�������web��
    {
   		href = unescape(href);
		end = href.lastIndexOf("/");
		href = href.substring(0, end + 1);//web�������������
        if(language==8){
            href = href + "menu_en.xml";
        }
        <%if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1){%>
            href = href + "menu_tw.xml";
        <%}else{%>
        if(language!=8){
            href = href + "menu.xml";
        }
        <%}%>
        //alert("web")
    }
    else
    {
    	href = window.location.pathname; //ȡ�ñ���·������Ե�url·��
   		href = unescape(href);
		start = href.indexOf("/");
		end = href.lastIndexOf("\\");
		href = href.substring(start + 1, end + 1);
		if(language==8){
            href = href + "menu_en.xml";
        }
        <%if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1){%>
            href = href + "menu_tw.xml";
        <%}else{%>
        if(language!=8){
            href = href + "menu.xml";
        }
        <%}%>
	 	//alert("disk");
    }	
	//alert(href);
	MenuOcx.SetMenuFromXML(href);
    CellWeb1.GetFocus();
}

function mouseout(){
  try{
	var x = oPopup.document.parentWindow.event.clientX;
	var y = oPopup.document.parentWindow.event.clientY
	if(x<0 || y<0) oPopup.hide();
  }catch(e){}	
}

var oPopup;
try{
   oPopup = window.createPopup()
}catch(e){}

function showPopup()
{
  try{
    var lefter =CellWeb1.GetMousePosX();	
    var topper =CellWeb1.GetMousePosY();
    var fieldname=CellWeb1.GetCellUserStringValue(CellWeb1.Row,CellWeb1.Col);
    var specialfield = fieldname.split("_");
    var htmltype = 0;
    if(specialfield.length==3) htmltype = specialfield[2];

    if(fieldname=="requestname"){
    	<%
	    if(nodetype.equals("0")){
    	%>
	    	ocontextReqName.style.display='';
	    	showtypeReqName.checked=true;
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,2);
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName.offsetHeight, document.CellWeb1);
		    ocontextReqName.style.display='none';
	  	<%}else if(nodetype.equals("3")){%>
	  		ocontextReqName1.style.display='';
	    	showtypeReqName1.checked=true;
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName1.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName1.offsetHeight, document.CellWeb1);
		    ocontextReqName1.style.display='none';
	  	<%}else{%>
	    	ocontextReqName2.style.display='';
	    	var tempvalue=CellWeb1.GetCellUserValue(CellWeb1.Row,CellWeb1.Col);
	    	if(tempvalue<=0){
	        showtypeReqName2[0].checked=true;
	        showtypeReqName2[1].checked=false;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
	    	}else{
	        showtypeReqName2[0].checked=false;
	        showtypeReqName2[1].checked=true;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,2);
	    	}
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName2.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName2.offsetHeight, document.CellWeb1);
		    ocontextReqName2.style.display='none';
	  	<%}%>
    }else if(fieldname=="requestlevel"||fieldname=="messageType"){
    	<%if(nodetype.equals("3")){%>
    		ocontextReqName1.style.display='';
	    	showtypeReqName1.checked=true;
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName1.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName1.offsetHeight, document.CellWeb1);
		    ocontextReqName1.style.display='none';
    	<%}else{%>
	    	ocontextCombox.style.display='';
	    	var tempvalue=CellWeb1.GetCellUserValue(CellWeb1.Row,CellWeb1.Col);
	    	if(tempvalue<=0){
	        showtypeCombox[0].checked=true;
	        showtypeCombox[1].checked=false;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
	    	}else{
	        showtypeCombox[0].checked=false;
	        showtypeCombox[1].checked=true;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,1);
	    	}
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextCombox.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextCombox.offsetHeight, document.CellWeb1);
		    ocontextCombox.style.display='none';
	  	<%}%>
    }else if(fieldname=="qianzi"){
    	<%if(nodetype.equals("3")){%>
    		ocontextReqName1.style.display='';
	    	showtypeReqName1.checked=true;
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName1.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName1.offsetHeight, document.CellWeb1);
		    ocontextReqName1.style.display='none';
    	<%}else{%>
	    	ocontextCombox.style.display='';
	    	var tempvalue=CellWeb1.GetCellUserValue(CellWeb1.Row,CellWeb1.Col);
	    	if(tempvalue<=0){
	        showtypeCombox[0].checked=true;
	        showtypeCombox[1].checked=false;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
	    	}else{
	        showtypeCombox[0].checked=false;
	        showtypeCombox[1].checked=true;
	        CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,1);
	    	}
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextCombox.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextCombox.offsetHeight, document.CellWeb1);
		    ocontextCombox.style.display='none';
	  	<%}%>
    }else if(htmltype == 7||fieldname.indexOf("wfl")==0||fieldname=="<%=hrmremain%>"||fieldname=="<%=deptremain%>"||fieldname=="<%=subcomremain%>"||fieldname=="<%=loanbalance%>"||fieldname=="<%=oldamount%>"){//�����ֶΣ���������Ҽ��޿ɱ༭�ͱ���
    		ocontextReqName1.style.display='';
	    	showtypeReqName1.checked=true;
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
		    oPopup.document.body.attachEvent("onmouseout",mouseout);
		    oPopup.document.body.innerHTML = ocontextReqName1.innerHTML; 
		    oPopup.show(lefter,topper,120,ocontextReqName1.offsetHeight, document.CellWeb1);
		    ocontextReqName1.style.display='none';            
    }
    else if(fieldname.indexOf("_isneed")>0||fieldname.indexOf("_isdefault")>0){//�����ֶΣ���������Ҽ��޿ɱ༭�ͱ���
    		ocontextReqName1.style.display='none';
	    	CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
		    ocontextReqName1.style.display='none';
    }
    else{
	//alert(lefter+","+topper);	
	ocontext.style.display='';
    var tempvalue=CellWeb1.GetCellUserValue(CellWeb1.Row,CellWeb1.Col);
    if(tempvalue<=0){
        showtype[0].checked=true;
        showtype[1].checked=false;
        showtype[2].checked=false;
        if(tempvalue<0){
           CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,0);
        }
    }else{
        if(tempvalue==1){
            showtype[1].checked=true;
            showtype[0].checked=false;
            showtype[2].checked=false;
        }else{
            if(tempvalue>=2){
                showtype[2].checked=true;
                showtype[0].checked=false;
                showtype[1].checked=false;
                if(tempvalue>2){
                    CellWeb1.SetCellUserValue(CellWeb1.Row,CellWeb1.Col,CellWeb1.Row,CellWeb1.Col,2);
                }
            }
        }
    }
    oPopup.document.body.attachEvent("onmouseout",mouseout);
    oPopup.document.body.innerHTML = ocontext.innerHTML; 
    oPopup.show(lefter,topper,120,ocontext.offsetHeight, document.CellWeb1);
    ocontext.style.display='none';
  }
  
  }catch(e){}
  
}

function hidePopup()
{
  try{
	ocontext.style.display='none';
    parent.oPopup.hide();
  }catch(e){}  
}

function window_onresize() {
	var lWidth = document.body.offsetWidth;
	if( lWidth <= 0) lWidth = 1;
	CellWeb1.style.width = lWidth;

	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight;
}
var lWidth=1;
var currentver=0;
var systemver=0;
function window_onload() {
    try{
        currentver=getCurrentVer();
        systemver=CellVersion.value;
    }catch(e){}
    if(currentver>systemver){
        if(language==8){
            alert("Warning:Your machine's Report editor edition is higher than the server edition, can't Save the works!");
        }
        else if(language==9){ 
             alert("���棡���C����汾��춷������汾�����܌�ģ���M�б��棡"); 
         }
        else{
            alert("���棡��������汾���ڷ������汾�����ܶ�ģ����б��棡");
        }
    }
    if(currentver<systemver){
        if(language==8){
            alert("Warning:Your machine's Report editor edition is lower than the server edition, can't Save the works!");
        }
        else if(language==9){ 
            alert("���棡���C����汾��춷������汾�����܌�ģ���M�б��棡"); 
        }
        else{
            alert("���棡��������汾���ڷ������汾�����ܶ�ģ����б��棡");
        }
    }
    cellregedit();
    menu_onload();
	menu_init();
	var aw = screen.availWidth; 
	var ah = screen.availHeight;
	//self.moveTo(0,0);
	//self.resizeTo(aw, ah);

	CellWeb1.border = 0;
	CellWeb1.style.left = 0;	
	
	CellWeb1.style.top = idTBDesign.offsetTop + idTBDesign.offsetHeight+27;
	lWidth = document.body.offsetWidth;
	if( lWidth <= 0)
		lWidth = 1;
	//CellWeb1.style.width = "100%";
	
	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight;

	CellWeb1.style.display="";
    //CellWeb1.SetMaxRows(20);
    //CellWeb1.SetMaxCols(10);
    CellWeb1.SetShowPopupMenu(false);
    CellWeb1.DesignMode=true;        
    InitFontname();
}

</SCRIPT>

<!--BUTTON-->
<SCRIPT FOR="cbButton" EVENT="onmousedown()"	LANGUAGE="JavaScript" >
	return onCbMouseDown(this);
</SCRIPT>

<SCRIPT FOR="cbButton" EVENT="onclick()"		LANGUAGE="JavaScript" >
	return onCbClickEvent(this);
</SCRIPT>

<SCRIPT FOR="cbButton" EVENT="oncontextmenu()"	LANGUAGE="JavaScript" >
	return(event.ctrlKey);
</SCRIPT>

<SCRIPT FOR="CellWeb1" EVENT="MouseRClick()"	LANGUAGE="JavaScript" >
    showRightMenu();
    //var userstring=CellWeb1.GetCellUserStringValue(CellWeb1.Row,CellWeb1.Col);
    //if(userstring!=null && userstring!="" && userstring.indexOf("_add")<0 && userstring.indexOf("_del")<0 && userstring.indexOf("_head")<0 && userstring.indexOf("_end")<0 && userstring.indexOf("_sel")<0)
	//    showPopup();
	//return false;
</SCRIPT>
<SCRIPT FOR="CellWeb1" EVENT="CellContentChanged()"	LANGUAGE="JavaScript" >
	
</SCRIPT>

<SCRIPT ID=clientEventHandlersVBS LANGUAGE=vbscript>
</SCRIPT>
</HEAD>
<BODY id="mainbody" class="mainBody" LANGUAGE=javascript onresize="return window_onresize()" onload="return window_onload()">

<script language=javascript src="/workflow/mode/chinaexcelmenu.js"></script>
<div id=toptable style="width:100%">
<TABLE class="cbToolbar" id="idTBGeneral" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD NOWRAP><A class=tbButton id=cmdFileNew <%if(languageid==8){%>title=New<%}else{%>title=�½�<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/new.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFileOpen <%if(languageid==8){%>title="Open File"<%}else{%>title=���ĵ�<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/open.gif" width="16" height="16"></A></TD>
    <TD NOWRAP><A class=tbButton id=StyleCheck <%if(languageid==8){%>title="Format Check"<%}else{%>title=ģ���ʽ���<%}%> href="#" onclick="mnuStyleCheck_click()"><IMG align=absMiddle src="/images/icon_balancelist.gif" width="16" height="16"></A></TD>
    <TD NOWRAP><A class=tbButton id=CMDFILESAVEAS <%if(languageid==8){%>title="Save As"<%}else{%>title=���浽����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/savexml.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A  id=testsave href="#" <%if(languageid==8){%>title="Save"<%}else{%>title="���浽������"<%}%> onclick="testSave()" ><IMG align=absMiddle src="images/save.gif" width="16" height="16"></A></TD>
	<!--TD NOWRAP><A class=tbButton id=cmdFilePrintPaperSet title=��ӡҳ���� href="#" name=cbButton><IMG align=absMiddle src="images/printpapaerset.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFilePrintSetup title=��ӡ���� href="#" name=cbButton><IMG align=absMiddle src="images/printsetup.gif" width="16" height="16"></A></TD-->
	<TD NOWRAP><A class=tbButton id=cmdFilePrint <%if(languageid==8){%>title=Print<%}else{%>title=��ӡ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/print.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdFilePrintPreview <%if(languageid==8){%>title="Print View"<%}else{%>title=��ӡԤ��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/printpreview.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditCut <%if(languageid==8){%>title=Cut<%}else{%>title=����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/cut.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditCopy <%if(languageid==8){%>title=Copy<%}else{%>title=����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/copy.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditPaste <%if(languageid==8){%>title=Paste<%}else{%>title=ճ��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/paste.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdEditFind <%if(languageid==8){%>title=Find<%}else{%>title=����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/find.gif" width="16" height="16"></A></TD>
	<!--TD NOWRAP><A class=tbButton id=cmdEditUndo title=���� href="#" name=cbButton><IMG align=absMiddle src="images/undo.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdEditRedo title=���� href="#" name=cbButton  sticky="true"><IMG align=absMiddle src="images/redo.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdStatWizard title=����ͳ���� href="#" name=cbButton><IMG align=absMiddle src="images/databasewizard.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFunctionList title=�����б� href="#" name=cbButton><IMG align=absMiddle src="images/formula.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdUserFunctionGuide title=�Զ��庯���� href="#" name=cbButton><IMG align=absMiddle src="images/formulaS.gif" width="16" height="16"></A></TD-->
	
	<!--TD NOWRAP><A class=tbButton id=cmdChartWzd title=ͼ���� href="#" name=cbButton><IMG align=absMiddle src="images/chartw.gif" width="16" height="16"></A></TD-->
	<TD NOWRAP><A class=tbButton id=cmdInsertPic <%if(languageid==8){%>title="Insert Floating Pic"<%}else{%>title=���븡��ͼƬ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/insertpic.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdInsertCellPic <%if(languageid==8){%>title="Insert Cell Pic"<%}else{%>title=���뵥ԪͼƬ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/insertcellpic.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdHyperlink <%if(languageid==8){%>title="URL"<%}else{%>title=��������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/hyperlink.gif" width="16" height="16"></A></TD>
    <TD NOWRAP id="cmdBoderType" <%if(languageid==8){%>title="Border Type"<%}else{%>Title="�߿�����"<%}%>>
		<SELECT name="BorderTypeSelect" ACCESSKEY="v" size="1">
          <option value="0" selected><%if(languageid==8){%>Filament<%}else{%>ϸ��<%}%></option>
          <option value="1"><%if(languageid==8){%>Midline<%}else{%>����<%}%></option>
          <option value="2"><%if(languageid==8){%>Broad<%}else{%>����<%}%></option>
          <option value="3"><%if(languageid==8){%>Dot<%}else{%>����<%}%></option>
          <option value="4"><%if(languageid==8){%>Dashed<%}else{%>����<%}%></option>
          <option value="5"><%if(languageid==8){%>Dot Line<%}else{%>�㻮��<%}%></option>
          <option value="6"><%if(languageid==8){%>Dot Dot Line<%}else{%>��㻮��<%}%></option>
        </SELECT>
	</TD>
    <TD NOWRAP id="cmdDrawColor" <%if(languageid==8){%>title="Border Color"<%}else{%>Title="������ɫ"<%}%>>
		<SELECT name="BorderColor" ACCESSKEY="v" size="1" onchange="cmdDrawType.focus()">
          <option value="0" selected style="background-color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="16711680" style="background-color:blue">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="32768" style="background-color:#008000">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="16776960" style="background-color:#00FFFF">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="255" style="background-color:red">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="16711935" style="background-color:#FF00FF">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="65535" style="background-color:#FFFF00">&nbsp;&nbsp;&nbsp;&nbsp;</option>  
          <option value="16777215" style="background-color:#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="128" style="background-color:#800000">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="65280" style="background-color:#00FF00">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="32896" style="background-color:#808000">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="8388608" style="background-color:#000080">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="8388736" style="background-color:#800080">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="8421376" style="background-color:#008080">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="12632256" style="background-color:#C0C0C0">&nbsp;&nbsp;&nbsp;&nbsp;</option>
          <option value="8421504" style="background-color:#808080">&nbsp;&nbsp;&nbsp;&nbsp;</option>
        </SELECT>
	</TD>
    <!--TD NOWRAP><A class=tbButton id=cmdDrawColor title=������ɫ href="#" name=cbButton><IMG align=absMiddle src="images/bordercolor.bmp" width="16" height="16"></A></TD-->
    <TD NOWRAP id="cmdDrawType" <%if(languageid==8){%>title="Draw Border Type"<%}else{%>Title="���߿�����"<%}%>>
		<SELECT name="DrawTypeSelect" ACCESSKEY="v" size="1">
          <option value="0" selected><%if(languageid==8){%>All Border<%}else{%>�����п���<%}%></option>
          <option value="1"><%if(languageid==8){%>Outer Border<%}else{%>�������<%}%></option>
          <option value="2"><%if(languageid==8){%>Up Border<%}else{%>���Ͽ���<%}%></option>
          <option value="3"><%if(languageid==8){%>Down Border<%}else{%>���¿���<%}%></option>
          <option value="4"><%if(languageid==8){%>Left Border<%}else{%>�������<%}%></option>
          <option value="5"><%if(languageid==8){%>Right Border<%}else{%>���ҿ���<%}%></option>
          <option value="6"><%if(languageid==8){%>Up-Down Border<%}else{%>�����¿���<%}%></option>
          <option value="7"><%if(languageid==8){%>Left-right Border<%}else{%>�����ҿ���<%}%></option>
          <option value="8"><%if(languageid==8){%>Inner Border<%}else{%>���ڿ���<%}%></option>
          <option value="9"><%if(languageid==8){%>Horizontal Border<%}else{%>�������<%}%></option>
          <option value="10"><%if(languageid==8){%>Vertical Border<%}else{%>��������<%}%></option>
        </SELECT>
	</TD>
    <TD NOWRAP><A class=tbButton id=cmdDrawBorder <%if(languageid==8){%>title="Draw Border"<%}else{%>title=���߿���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/border.gif" width="16" height="16"></A></TD>
    <TD NOWRAP id="cmdEraseType" <%if(languageid==8){%>title="Erase Border Type"<%}else{%>Title="Ĩ�߿�����"<%}%>>
		<SELECT name="EraseTypeSelect" ACCESSKEY="v" size="1">
          <option value="0" selected><%if(languageid==8){%>All Border<%}else{%>Ĩ���п���<%}%></option>
          <option value="1"><%if(languageid==8){%>Outer Border<%}else{%>Ĩ�����<%}%></option>
          <option value="2"><%if(languageid==8){%>Up Border<%}else{%>Ĩ�Ͽ���<%}%></option>
          <option value="3"><%if(languageid==8){%>Down Border<%}else{%>Ĩ�¿���<%}%></option>
          <option value="4"><%if(languageid==8){%>Left Border<%}else{%>Ĩ�����<%}%></option>
          <option value="5"><%if(languageid==8){%>Right Border<%}else{%>Ĩ�ҿ���<%}%></option>
          <option value="6"><%if(languageid==8){%>Up-Down Border<%}else{%>Ĩ���¿���<%}%></option>
          <option value="7"><%if(languageid==8){%>Left-right Border<%}else{%>Ĩ���ҿ���<%}%></option>
          <option value="8"><%if(languageid==8){%>Inner Border<%}else{%>Ĩ�ڿ���<%}%></option>
          <option value="9"><%if(languageid==8){%>Horizontal Border<%}else{%>Ĩ�����<%}%></option>
          <option value="10"><%if(languageid==8){%>Vertical Border<%}else{%>Ĩ������<%}%></option>
        </SELECT>
	</TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdEraseBorder <%if(languageid==8){%>title="Erase Border"<%}else{%>title=Ĩ�߿���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/erase.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="100%"></TD>
	</TR>
</TABLE>
<TABLE class="cbToolbar" id="idTBFormat" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD NOWRAP id="cmdFontName" <%if(languageid==8){%>title="Font"<%}else{%>Title="����"<%}%>>
		<SELECT name="FontNameSelect" style="WIDTH: 225px; HEIGHT: 23px" onChange="changeFontName(FontNameSelect.value)" ACCESSKEY="v" size="1">
        &nbsp; </SELECT>
	</TD>
	<TD NOWRAP class="tbDivider" id="cmdFontSize" <%if(languageid==8){%>title="Font Size"<%}else{%>Title="�ֺ�"<%}%>>
		<SELECT name="FontSizeSelect" onChange="changeFontSize(FontSizeSelect.value)" ACCESSKEY="v" size="1">
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option selected value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
          <option value="14">14</option>
          <option value="16">16</option>
          <option value="18">18</option>
          <option value="20">20</option>
          <option value="22">22</option>
          <option value="24">24</option>
          <option value="26">26</option>
          <option value="28">28</option>
          <option value="30">30</option>
          <option value="36">36</option>
          <option value="42">42</option>
          <option value="48">48</option>
          <option value="72">72</option>
          <option value="100">100</option>
          <option value="150">150</option>
          <option value="300">300</option>
          <option value="500">500</option>
          <option value="800">800</option>
          <option value="1200">1200</option>
          <option value="2000">2000</option>
        </SELECT>
	</TD>

	<TD NOWRAP><A class=tbButton id=cmdBold <%if(languageid==8){%>title="Bold"<%}else{%>title=����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/bold.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdItalic <%if(languageid==8){%>title="Italic"<%}else{%>title=б��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/italic.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdUnderline <%if(languageid==8){%>title="Underline"<%}else{%>title=�»���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/underline.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdBackColor <%if(languageid==8){%>title="Background Color"<%}else{%>title=����ɫ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/backcolor.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdForeColor <%if(languageid==8){%>title="Font Color"<%}else{%>title=ǰ��ɫ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/forecolor.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdWordWrap <%if(languageid==8){%>title="Auto Wrap"<%}else{%>title=�Զ�����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/wordwrap.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignLeft <%if(languageid==8){%>title="Flush Left"<%}else{%>title=�������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/alignleft.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignCenter <%if(languageid==8){%>title="Flush Center"<%}else{%>title=���ж���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/aligncenter.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignRight <%if(languageid==8){%>title="Flush Right"<%}else{%>title=���Ҷ���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/alignright.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignTop <%if(languageid==8){%>title="Flush Top"<%}else{%>title=���϶���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/aligntop.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignMiddle <%if(languageid==8){%>title="Flush Middle"<%}else{%>title=��ֱ����<%}%> href="#" name=cbButton  sticky="true"><IMG align=absMiddle src="images/alignmiddle.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdAlignBottom <%if(languageid==8){%>title="Flush Bootom"<%}else{%>title=���¶���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/alignbottom.gif" width="16" height="16"></A></TD>
    <TD NOWRAP><A class=tbButton id=cmdFinanceType <%if(languageid==8){%>title="Finance Show"<%}else{%>title=�������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/finance.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdFinanceHeaderType <%if(languageid==8){%>title="Finance Header"<%}else{%>title=�����ͷ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/financeheader.gif" width="16" height="16"></A></TD>
    <TD class="tbDivider" NOWRAP width="100%"></TD>
	</TR>
</TABLE>
<TABLE class="cbToolbar" id="idTBDesign" cellpadding='0' cellspacing='0' width="100%">
	<TR>    
	<TD NOWRAP width="21"><A class=tbButton id=cmdInsertCol <%if(languageid==8){%>title="Insert Col"<%}else{%>title=������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/insertcol.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdInsertRow <%if(languageid==8){%>title="Insert Row"<%}else{%>title=������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/insertrow.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdInsertCell <%if(languageid==8){%>title="Insert Cell"<%}else{%>title=���뵥Ԫ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/insertcell.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdDeleteCell <%if(languageid==8){%>title="Del Cell"<%}else{%>title=ɾ����Ԫ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/deletecell.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdDeleteCol <%if(languageid==8){%>title="Del Col"<%}else{%>title=ɾ����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/deletecol.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdDeleteRow <%if(languageid==8){%>title="Del Row"<%}else{%>title=ɾ����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/deleterow.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdMaxRowCol <%if(languageid==8){%>title="Max Col"<%}else{%>title=���ñ��������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/sheetsize.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdMergeCell <%if(languageid==8){%>title="Merge Cell"<%}else{%>title=��ϵ�Ԫ��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/mergecell.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdUnMergeCell <%if(languageid==8){%>title="UnMerge Cell"<%}else{%>title=ȡ����Ԫ�����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/unmergecell.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdReCalcAll <%if(languageid==8){%>title="Recalculation"<%}else{%>title=�������ȫ��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/calculateall.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdFormProtect <%if(languageid==8){%>title="Form Protect"<%}else{%>title=����/ȡ��������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/formprotect.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdReadOnly <%if(languageid==8){%>title="Read Only"<%}else{%>title=��Ԫ��ֻ��<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/readonly.gif" width="16" height="16"></A></TD>
    <TD NOWRAP><A class=tbButton id=cmdFormulaSumH <%if(languageid==8){%>title="SumH"<%}else{%>title=ˮƽ���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/sumh.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormulaSumV <%if(languageid==8){%>title="SumV"<%}else{%>title=��ֱ���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/sumv.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormulaSumHV <%if(languageid==8){%>title="SumHV"<%}else{%>title=˫�����<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/sum.gif" width="16" height="16"></A></TD>
    <TD class="tbDivider" NOWRAP><A class=tbButton id=SETCCINCELLS <%if(languageid==8){%>title="no-main cell of combined cell attend calculate"<%}else{%>title=��ϵ�Ԫ�еķ�����Ԫ���ڼ���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/sumcell.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdCurrency <%if(languageid==8){%>title="��"<%}else{%>title=���ҷ���<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/currency.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdPercent <%if(languageid==8){%>title="��"<%}else{%>title=�ٷֺ�<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/percent.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdThousand <%if(languageid==8){%>title="��"<%}else{%>title=ǧ��λ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/thousand.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdShowGridline <%if(languageid==8){%>title="Grid Line"<%}else{%>title=��ʾ/���ر��������<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/gridline.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdShowHeader <%if(languageid==8){%>title="Form Header"<%}else{%>title=��ʾ/����ϵͳ��ͷ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/header.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdShape3D <%if(languageid==8){%>title="Shape 3D"<%}else{%>title=����/ȡ����Ԫ3ά��ʾ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/shape3D.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdRowLabel <%if(languageid==8){%>title="Row Label"<%}else{%>title=����/ȡ���б�ͷ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/rowlabel.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdColLabel <%if(languageid==8){%>title="Col Label"<%}else{%>title=����/ȡ���б�ͷ<%}%> href="#" name=cbButton><IMG align=absMiddle src="images/collabel.gif" width="16" height="16"></A></TD>
	
    <TD class="tbDivider" NOWRAP><A class=tbButton id=delaxtive href="#" <%if(languageid==8){%>title="Del Fields"<%}else{%>title="ɾ���ֶ�"<%}%> onclick="deleteA()" ><IMG align=absMiddle src="/images/BacoCross.gif" width="13" height="13"></A></TD>
	<TD NOWRAP width="100%"></TD>
	</TR>
</TABLE>
</div>
<div id=divtest style="width:100%;LEFT: 0px;POSITION: relative;"><%if(languageid==8){%>Loading<%}else{%>����װ�ر�����������<%}%>......</div>

<%if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1){%>
<script language=javascript src="/workflow/mode/chinaexcelweb_tw.js"></script>
<%}else{%>
<script language=javascript src="/workflow/mode/chinaexcelweb.js"></script>
<%} %>
<div id='divshowCheck' name='divshowCheck' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<DIV id="ocontext" name="ocontext" style="display:none;width:100%" >
<table id=otable cellpadding='0' width=120 cellspacing='0'>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:15px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="0" name="showtype" id="showtype" checked onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(89,languageid)%></td></tr>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="1" name="showtype" id="showtype" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(18018,languageid)%>
</td></tr>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="2" name="showtype" id="showtype" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(18019,languageid)%>
</td></tr>
</table>
</DIV>
<DIV id="ocontextReqName" name="ocontextReqName" style="display:none;width:100%" >
<table id=otable cellpadding='0' width=120 cellspacing='0'>
<tr><td colspan=6 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="2" name="showtypeReqName" id="showtypeReqName" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(18019,languageid)%>
</td></tr>
</table>
</DIV>
<DIV id="ocontextReqName1" name="ocontextReqName1" style="display:none;width:100%" >
<table id=otable cellpadding='0' width=120 cellspacing='0'>
<tr><td colspan=6 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="0" name="showtypeReqName1" id="showtypeReqName1" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(89,languageid)%>
</td></tr>
</table>
</DIV>
<DIV id="ocontextReqName2" name="ocontextReqName2" style="display:none;width:100%" >
<table id=otable cellpadding='0' width=120 cellspacing='0'>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:15px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="0" name="showtypeReqName2" id="showtypeReqName2" checked onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(89,languageid)%></td></tr>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="2" name="showtypeReqName2" id="showtypeReqName2" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(18019,languageid)%>
</td></tr>
</table>
</DIV>
<DIV id="ocontextCombox" name="ocontextCombox" style="display:none;width:100%" >
<table id=otable cellpadding='0' width=120 cellspacing='0'>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:15px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="0" name="showtypeCombox" id="showtype" checked onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(89,languageid)%></td></tr>
<tr><td colspan=2 onmouseover="this.style.background='#1397D4'" onmouseout="this.style.background='#3081BB'" STYLE="font-family:verdana; font-size:12; height:20px; background:#3081BB; border:1px solid black; padding:4px; cursor:hand; border-top:0px solid black;color:#ffffff;BORDER-RIGHT: #000000 1px solid;BORDER-TOP: #ffffff 1px solid;BORDER-LEFT: #ffffff 1px solid;BORDER-BOTTOM: #000000 1px solid" >
<input type=radio value="1" name="showtypeCombox" id="showtype" onclick="parent.setuservalue(this)"><%=SystemEnv.getHtmlLabelName(18018,languageid)%>
</td></tr>
</table>
</DIV>
<script language=javascript>
function readmode(){
    CellWeb1.ReadHttpFile("/workflow/mode/ModeReader.jsp?modeid=<%=modeid%>&nodeid=<%=nodeid%>&isform=<%=isform%>");
    showfield();
}
</script>
<script language=vbs>
        readmode()
        CellWeb1.ShowHeader=true
        CellWeb1.ShowGrid =true
        parent.showlist()
</script>
<form name="form1" method="post" action="eweb_operation.jsp" >
<input type=hidden id="modestring" name="modestring" value="">
<input type=hidden id="wfid" name="wfid" value="<%=wfid%>">
<input type=hidden id="formid" name="formid" value="<%=formid%>">
<input type=hidden id="nodeid" name="nodeid" value="<%=nodeid%>">
<input type=hidden id="modeid" name="modeid" value="<%=modeid%>">
<input type=hidden id="isbill" name="isbill" value="<%=isbill%>">
<input type=hidden id="isprint" name="isprint" value="<%=isprint%>">
<input type=hidden id="isform" name="isform" value="<%=isform%>">
<input type=hidden id="mandatoryfields" name="mandatoryfields" value="">
<input type=hidden id="viewfields" name="viewfields" value="">
<input type=hidden id="editfields" name="editfields" value="">
<input type=hidden id="ajax" name="ajax" value="<%=ajax%>">    
<input type=hidden id ="design" name ="design" value="<%=design%>">
</form>
<script language=javascript>
function setuservalue(obj){
    var chinacel=CellWeb1;
    var startrow=chinacel.GetSelectRegionStartRow();
    var endrow=chinacel.GetSelectRegionEndRow();
    var startcol=chinacel.GetSelectRegionStartCol();
    var endcol=chinacel.GetSelectRegionEndCol();
    for(var i=startrow;i<=endrow;i++){
        for(var j=startcol;j<=endcol;j++){
            var uservalue=chinacel.GetCellUserStringValue(i,j);
            if(uservalue!=null && uservalue!="" && uservalue.indexOf("_add")<0 && uservalue.indexOf("_del")<0 && uservalue.indexOf("_head")<0 && uservalue.indexOf("_end")<0 && uservalue.indexOf("_sel")<0&& uservalue.indexOf("_showKeyword")<0&& uservalue.indexOf("_isprintbegin")<0&& uservalue.indexOf("_isprintend")<0){
                var index=uservalue.lastIndexOf("_");
                var htmltype=0;
                if(index>0){
                    htmltype=uservalue.substr(index+1);
                }
                chinacel.SetCellProtect(i,j,i,j,false);
                chinacel.SetCellUserValue(i,j,i,j,obj.value);
                if(obj.value=="2"){
                    if(htmltype==3 || htmltype==6 || uservalue=="qianzi"){
                        chinacel.ReadHttpImageFile("/images/BacoBrowser_b.gif",i,j,true,true);
                    }else{
                        chinacel.ReadHttpImageFile("/images/BacoError.gif",i,j,true,true);
                    }
                }else if(obj.value=="1"){
                    if(htmltype==3 || htmltype==6 || uservalue=="qianzi"){
                        chinacel.ReadHttpImageFile("/images/BacoBrowser.gif",i,j,true,true);
                    }else{
                        chinacel.DeleteCellImage(i,j,i,j);
                    }
                }else{
                    chinacel.DeleteCellImage(i,j,i,j);
                }
                chinacel.SetCellProtect(i,j,i,j,true);
            }
        }
    }
}
</script>

</BODY>
</HTML>
