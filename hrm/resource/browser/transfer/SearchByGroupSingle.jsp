<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="RoleComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="GroupAction" class="weaver.hrm.group.GroupAction" scope="page" />
<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<style>
#divTree { overflow: scroll; height: 170; width: 100%; }
</style>
<script type="text/javascript" src="/js/xtree.js"></script>
<script type="text/javascript" src="/js/xmlextras.js"></script>
<script type="text/javascript" src="/js/cxloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="/css/xtree2.css" />
</HEAD>
<BODY onload="initTree()" oncontextmenu="return false;">
<%
//under Cookie by cyril
int uid=user.getUID();
String nodeid=null;
String rem=null;
Cookie[] cks= request.getCookies();
for(int i=0;i<cks.length;i++){
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
	if(atts.length>1) nodeid=atts[1];
}
nodeid = ""+Util.getIntValue(nodeid, -2);
//upper Cookie by cyril

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
	RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:SearchForm.btnok.click(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:SearchForm.btnclear.click(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
	<BUTTON class=btn accessKey=O style="display:none" id=btnok><U>O</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>
	<BUTTON class=btn accessKey=2 style="display:none" id=btnclear><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script>
rightMenu.style.visibility='hidden'
</script>

<table width=100% height="100%" class="ViewForm" valign="top">
	<!--######## Search Table Start########-->
	<TR>
	<td>
	<div id="deeptree" class="cxtree" CfgXMLSrc="/css/TreeConfig.xml" />
	<td>
	</tr>
	</table>
<input class=inputstyle type="hidden" name="sqlwhere" value='<%=Util.null2String(request.getParameter("sqlwhere"))%>'>
  <input class=inputstyle type="hidden" name="resourceids" >
  <input class=inputstyle type="hidden" name="tabid" >
  <input class=inputstyle type="hidden" name="groupid" value="<%=Util.null2String(nodeid)%>">
  <input class=inputstyle type="hidden" name="nodeid" >
	<!--########//Search Table End########-->
	</FORM>

<SCRIPT LANGUAGE=VBS>
resourceids =""
resourcenames = ""

Sub btnclear_onclick()
     window.parent.returnvalue = Array("","")
     window.parent.close
End Sub


Sub btnok_onclick()
	 setResourceStr()
     replaceStr()
     window.parent.returnvalue = Array(resourceids,resourcenames)
    window.parent.close
End Sub

Sub btnsub_onclick()
	setResourceStr()
    document.all("resourceids").value = resourceids.substring(1)
    document.SearchForm.submit
End Sub
</SCRIPT>

<script language="javascript">
function initTree(){
	//added by cyril
	//����ѡ�е�ID
	cxtree_id = '<%=Util.null2String(nodeid)%>';
	CXLoadTreeItem("", "/hrm/tree/ResourceMultiXMLByGroup.jsp");
	var tree = new WebFXTree();
	tree.add(cxtree_obj);
	//document.write(tree);
	document.getElementById('deeptree').innerHTML = tree;
	cxtree_obj.expand();
	//end by cyril
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
    document.all("resourceids").value = resourceids.substring(1) ;
    document.SearchForm.submit();
}
function setGroup(id){
	document.all("groupid").value=id;
    document.all("nodeid").value=id;
    document.all("tabid").value=1;
    doSearch();
}

</script>
</BODY>
</HTML>