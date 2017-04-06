<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="GroupAction" class="weaver.hrm.group.GroupAction" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<style>
#divTree { overflow: scroll; height: 170; width: 100%; }
</style>
<!-- added by cyril on 2008-07-31 for td:9109 -->
<script type="text/javascript" src="/js/xtree.js"></script>
<script type="text/javascript" src="/js/xmlextras.js"></script>
<script type="text/javascript" src="/js/cxloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="/css/xtree2.css" />
<!-- end by cyril on 2008-07-31 for td:9109 -->

</HEAD>

<BODY oncontextmenu="return false;">
<%
int uid=user.getUID();
String nodeid=null;
String rem=null;
        Cookie[] cks= request.getCookies();
        
        for(int i=0;i<cks.length;i++){
        //System.out.println("ck:"+cks[i].getName()+":"+cks[i].getValue());
        if(cks[i].getName().equals("resourcesingle"+uid)){
        rem=cks[i].getValue();
        break;
        }
        }
if(rem!=null){
rem="1"+rem.substring(1);
Cookie ck = new Cookie("resourcesingle"+uid,rem);  
ck.setMaxAge(30*24*60*60);
response.addCookie(ck);

String[] atts=Util.TokenizerString2(rem,"|");
if(atts.length>1)
nodeid=atts[1];
}
nodeid = ""+Util.getIntValue(nodeid, -2);

String needsystem = Util.null2String(request.getParameter("needsystem"));
String seclevelto=Util.fromScreen(request.getParameter("seclevelto"),user.getLanguage());

//List grouplist=GroupAction.getGroupTree(user);

//System.out.println("nodes"+grouplist.size());
//request.setAttribute("grouplist",grouplist);
String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));
String check_per = Util.null2String(request.getParameter("resourceids"));

String resourceids = "" ;
String resourcenames ="";

if(!check_per.equals("")){
	try{
	String strtmp = "select id,lastname from HrmResource where id in ("+check_per+")";
	RecordSet.executeSql(strtmp);
	//System.out.println(strtmp);
	Hashtable ht = new Hashtable();
	while(RecordSet.next()){
		ht.put(RecordSet.getString("id"),RecordSet.getString("lastname"));
		/*
		if(check_per.indexOf(","+RecordSet.getString("id")+",")!=-1){

				resourceids +="," + RecordSet.getString("id");
				resourcenames += ","+RecordSet.getString("lastname");
		}
		*/
	}

	StringTokenizer st = new StringTokenizer(check_per,",");

	while(st.hasMoreTokens()){
		String s = st.nextToken();
		resourceids +=","+s;
		resourcenames += ","+ht.get(s).toString();
	}
	}catch(Exception e){
		
	}
}
%>
	<FORM NAME=SearchForm STYLE="margin-bottom:0" action="Select.jsp" method=post target="frame2">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
BaseBean baseBean_self = new BaseBean();
int userightmenu_self = 1;
try{
	userightmenu_self = Util.getIntValue(baseBean_self.getPropValue("systemmenu", "userightmenu"), 1);
}catch(Exception e){}
if(userightmenu_self == 1){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:document.SearchForm.btnok.click(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+", javascript:document.SearchForm.btnclear.click(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
<BUTTON class=btnok accessKey=1 style="display:none" onclick="btncancel_onclick();" id=btnok><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<BUTTON class=btn accessKey=2 style="display:none" id=btnclear onclick="btnclear_onclick()"><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
		
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script>
rightMenu.style.visibility='hidden'
</script>
	
<table height="100%" width=100% class="ViewForm" valign="top">
	
	<!--######## Search Table Start########-->
	
	
	
	<TR>
	<td>
	<div id="deeptree" class="cxtree" CfgXMLSrc="/css/TreeConfig.xml" style="overflow-x:hidden;overflow-y:auto;"/>
	</td>
	</tr>
	
	
	</table>
  <input class=inputstyle type="hidden" name="sqlwhere" value='<%=Util.null2String(request.getParameter("sqlwhere"))%>'>
  <input class=inputstyle type="hidden" name="tabid" >
  <input class=inputstyle type="hidden" name="groupid" value="<%=Util.null2String(nodeid)%>">
  <input class=inputstyle type="hidden" name="nodeid" >
  <input class=inputstyle type="hidden" name="resourceids" >
  <input class=inputstyle type=hidden name=seclevelto value="<%=seclevelto%>">
  <input class=inputstyle type=hidden name=needsystem value="<%=needsystem%>">
  <input class=inputstyle type="hidden" name="isNoAccount" id="isNoAccount">
	<!--########//Search Table End########-->
	</FORM>
<script language="javascript">
$(function(){
	initTree();
});
function initTree(){
//added by cyril on 2008-07-31 for td:9109
//����ѡ�е�ID
cxtree_id = '<%=Util.null2String(nodeid)%>';
CXLoadTreeItem("", "/hrm/tree/ResourceMultiXMLByGroup.jsp");
var tree = new WebFXTree();
tree.add(cxtree_obj);
//document.write(tree);
document.getElementById('deeptree').innerHTML = tree;
cxtree_obj.expand();
//end by cyril on 2008-07-31 for td:9109
}
</script>
<SCRIPT LANGUAGE=VBS>


</SCRIPT>
<script language="javascript">
resourceids =""
resourcenames = ""
function setGroup(id){
    $("input[name=groupid]").val(id);
    $("input[name=tabid]").val(1);
    $("input[name=nodeid]").val(id);
    doSearch();
}
function setResourceStr(){
	
	var resourceids1 =""
        var resourcenames1 = ""
       try{
	for(var i=0;i<parent.frame2.resourceArray.length;i++){
		resourceids1 += ","+parent.frame2.resourceArray[i].split("~")[0] ;
		
		resourcenames1 += ","+parent.frame2.resourceArray[i].split("~")[1] ;
	}
	resourceids=resourceids1
	resourcenames=resourcenames1
       }catch(err){}
}

function replaceStr(){
    var re=new RegExp("[ ]*[|][^|]*[|]","g")
    resourcenames=resourcenames.replace(re,"|")
    re=new RegExp("[|][^,]*","g")
    resourcenames=resourcenames.replace(re,"")
}
function doSearch()
{
	setResourceStr();
    $("input[name=resourceids]").val(resourceids.substring(1)) ;
    //�Ƿ���ʾ���˺���Ա 
    if(jQuery(parent.document).find("#frame2").contents().find("#isNoAccount").attr("checked"))
      jQuery("#isNoAccount").val("1");
    else
      jQuery("#isNoAccount").val("0");
    document.SearchForm.submit();
}


function btnclear_onclick(){
     window.parent.parent.returnValue = {id:"",name:""};
     window.parent.parent.close();
}


function btnok_onclick(){
	 setResourceStr();
     replaceStr();
     window.parent.parent.returnValue = {id:resourceids,name:resourcenames};
    window.parent.parent.close();
}
function btncancel_onclick(){
     window.parent.parent.close();
}

function btnsub_onclick(){
	setResourceStr();
    $("input[name=resourceids]").val(resourceids.substring(1));
    document.SearchForm.submit();
}
</script>
</BODY>
</HTML>