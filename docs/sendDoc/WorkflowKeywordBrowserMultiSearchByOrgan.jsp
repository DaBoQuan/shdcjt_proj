<%@ page language="java" contentType="text/html; charset=GBK" %> 

<jsp:useBean id="WorkflowKeywordComInfo" class="weaver.docs.senddoc.WorkflowKeywordComInfo" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>

<HTML><HEAD>

<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>

<script type="text/javascript" src="/js/xtree.js"></script>
<script type="text/javascript" src="/js/xmlextras.js"></script>
<script type="text/javascript" src="/js/cxloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="/css/xtree2.css" />
<link href="/css/deepTree.css" rel="stylesheet" type="text/css">
</HEAD>
<%
int uid=user.getUID();
int tabid=0;

String nodeid=null;
String rem=null;

Cookie[] cks= request.getCookies();
        
for(int i=0;i<cks.length;i++){
	//System.out.println("ck:"+cks[i].getName()+":"+cks[i].getValue());
    if(cks[i].getName().equals("WorkflowKeywordBrowserMulti"+uid)){
        rem=cks[i].getValue();
        break;
    }
}

if(rem!=null){
rem=tabid+rem.substring(1);
Cookie ck = new Cookie("WorkflowKeywordBrowserMulti"+uid,rem);  
ck.setMaxAge(30*24*60*60);
response.addCookie(ck);

String[] atts=Util.TokenizerString2(rem,"|");
if(atts.length>1)
    nodeid=atts[1];
}

boolean exist=false;
String keywordName="";
if(nodeid!=null){
	keywordName=WorkflowKeywordComInfo.getKeywordName(nodeid.substring(nodeid.lastIndexOf("_")+1));
}

if(!keywordName.equals("")){
	exist=true;
}
else{
	exist=false;
}

if(!exist){
	nodeid=null;
}

String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));

String strKeyword = Util.null2String(request.getParameter("strKeyword"));

%>

<BODY>
	<FORM NAME=SearchForm STYLE="margin-bottom:0" action="WorkflowKeywordBrowserMultiSelect.jsp" method=post target="frame2">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
BaseBean baseBean_self = new BaseBean();
int userightmenu_self = 1;
try{
	userightmenu_self = Util.getIntValue(baseBean_self.getPropValue("systemmenu", "userightmenu"), 1);
}catch(Exception e){}
if(userightmenu_self == 1){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:btnok_onclick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:btnclear_onclick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
	<BUTTON type='button' class=btn accessKey=O style="display:none" id=btnok onclick="btnok_onclick();"><U>O</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>
	<BUTTON type='button' class=btn accessKey=2 style="display:none" id=btnclear onclick="btnclear_onclick();"><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%if(userightmenu_self == 1){%>
<script>
rightMenu.style.visibility='hidden'
</script>
<%}%>
<table width=100% class="ViewForm" valign="top">
	
	<!--######## Search Table Start########-->
	
	
	
	<TR>
	<td height=170>
	<div id="deeptree" class="cxtree" CfgXMLSrc="/css/TreeConfig.xml"  style="overflow-x:hidden;overflow-y:auto;"/>
	<td>
	</tr>
	
	
	</table>
<input class=inputstyle type="hidden" name="sqlwhere" value='<%=Util.null2String(request.getParameter("sqlwhere"))%>'>
  <input class=inputstyle type="hidden" name="strKeyword" value="<%=strKeyword%>">
  <input class=inputstyle type="hidden" name="tabid" >
  <input class=inputstyle type="hidden" name="nodeid" >
  <input class=inputstyle type="hidden" name="parentId" >
	<!--########//Search Table End########-->
	</FORM>


  

<script type="text/javascript" language="javascript">
var strKeyword ="";
function btnclear_onclick(){
    window.parent.parent.returnValue = "";
    window.parent.parent.close();
}
function btnok_onclick(){
	setKeywordStr();
	window.parent.parent.returnValue = strKeyword;
    window.parent.parent.close();
}
function btnsub_onclick(){
	setKeywordStr();
    document.all("strKeyword").value = strKeyword;
    document.SearchForm.submit();
}
</script>
<!--  
<SCRIPT LANGUAGE=VBS>
strKeyword =""

Sub btnclear_onclick()
     window.parent.returnvalue = ""
     window.parent.close
End Sub


Sub btnok_onclick()
	 setKeywordStr()
     window.parent.returnvalue = strKeyword
    window.parent.close
End Sub

Sub btnsub_onclick()
	setKeywordStr()
    document.all("strKeyword").value = strKeyword
    document.SearchForm.submit
End Sub  
</SCRIPT>-->

<script language="javascript">

function initTree(){
	//deeptree.init("/hrm/tree/ResourceSingleXML.jsp<%if(nodeid!=null){%>?init=true&nodeid=<%=nodeid%><%}%>");
	//added by cyril on 2008-07-31 for td:9109
	//����ѡ�е�ID
	CXLoadTreeItem("", "/docs/sendDoc/WorkflowKeywordBrowserMultiXML.jsp<%if(nodeid!=null){%>?init=true&nodeid=<%=nodeid%><%}%>")
	var tree = new WebFXTree();
	tree.add(cxtree_obj);
	//document.write(tree);
	document.getElementById('deeptree').innerHTML = tree;
	cxtree_obj.expand();
	//end by cyril on 2008-07-31 for td:9109
	}


//to use xtree,you must implement top() and showcom(node) functions

function top(){
<%if(nodeid!=null){%>
try{
	var deeptree = document.getElementById("deeptree");
	deeptree.scrollTop=<%=nodeid%>.offsetTop;
	deeptree.HighlightNode(<%=nodeid%>.parentNode);
	deeptree.ExpandNode(<%=nodeid%>.parentNode);
 }catch(e){

    }
<%}%>
}

function showcom(node){
}

function check(node){
}
</script>
</BODY>
</HTML>
<!-- ����js�����Ǵ�body�����Ƴ����ģ�������Google������� ����ʰ�ť ����֯�ܹ�ͼ�ų��� 2012-08-08 ypc �޸� start -->
<script language="javascript">

	jQuery(document).ready(function () {initTree();});
	
	function setKeywordStr(){
	    var strKeyword1 = ""
	    try{
		    for(var i=0;i<parent.frame2.keywordArray.length;i++){
				strKeyword1 += " "+parent.frame2.keywordArray[i].split("~")[1] ;
		    }
			if(strKeyword1!=""){
				strKeyword1=strKeyword1.substr(1);
			}
		    strKeyword=strKeyword1;
	    }catch(err){}	
	}

	function doSearch(){
		setKeywordStr();
	    document.all("strKeyword").value = strKeyword;
	    document.SearchForm.submit();
	}

	function setParent(nodeid){
	    parentId=nodeid.substring(nodeid.lastIndexOf("_")+1);
	    document.all("parentId").value=parentId;
	    document.all("tabid").value=0;
	    document.all("nodeid").value=nodeid;
	    doSearch();
	}
</script>
<!-- ����js�����Ǵ�body�����Ƴ����ģ�������Google������� ����ʰ�ť ����֯�ܹ�ͼ�ų��� 2012-08-08 ypc �޸� end -->