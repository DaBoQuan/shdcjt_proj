<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.docs.category.security.*" %>
<%@ page import="weaver.docs.category.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<%
String imagefilename = "";
String titlename = "" ;
String needfav ="";
String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script>
selectid = 0 ;
lasttext = "";

function clearCategory() {
    window.parent.returnValue=Array(0, 0);
    window.parent.close();
}
    

function selectCategory(nodeID) {
	if(selectid != 0){
	   var lastnode = tree.getNode(selectid);   
	   tree.setText(selectid,lasttext);
	}  

	   var node = tree.getNode(nodeID);
	  selectid = nodeID;
	  lasttext = node.text;
	   tree.setText(nodeID,"<b>"+node.text+"</b>"); 
	   window.parent.pdocRight.window.location="/docs/docs/PersonalDocRight.jsp?userCategory="+node.categoryid;
	// document.all("tocategory").value=node.categoryid;
}

function onBaseSelect(){
    window.parent.pdocRight.window.location="/docs/docs/PersonalDocRight.jsp?userCategory=0";
    window.location.reload();
}
</script>
</HEAD>
<body>
<span  name="pdocSpan" onclick="onBaseSelect()"   style="cursor:hand">
    <img src="images\ebfolder.gif"><%=user.getUsername()%><%=SystemEnv.getHtmlLabelName(18471,user.getLanguage())%>
</span>
<br>

<script src="/js/tree_maker2.js"></script>
<script>
function load(nodeID) // nodeIDΪ�������id
{    
    var node = tree.getNode(nodeID);
    
}
function findThisNode(categoryid, categorytype) {
    var i;
    var node;
    for (i=0;i<Tree_node_array.length;i++) {
        node = Tree_node_array[i];
        if (node != null && node.categoryid == categoryid && node.categorytype == categorytype) {
            return node;
        }
    }
    return null;
}
function loadthisnode(categoryid, categorytype) {
    var node = findThisNode(categoryid, categorytype);
    if (node != null) {
        load(node.id);
    }
}
function expandthisnode(categoryid, categorytype) {    
    var node = findThisNode(categoryid, categorytype);
    if (node != null) {
        alert('expanding ' + node.text);
        node.expand(true);
    }
}
</script>
<script>
var tree = new Tree_treeView(); // ���� Tree_treeView ����
tree.showLine=true; //��ʾ����
tree.lineFolder = "/images/treemaker/"
tree.fileImg="/images/treemaker/link.gif"; // ����Ĭ��ͼƬ
tree.folderImg1="/docs/docs/images/ebfolder.gif";
tree.folderImg2="/docs/docs/images/openfolder.gif";
var node;
var parentNode;

//node = tree.add(0,Tree_ROOT,Tree_LAST,'��Ŀ¼','','','','',0,0);
node = tree.add(0,Tree_ROOT,Tree_LAST,'<%=SystemEnv.getHtmlLabelName(18472,user.getLanguage())%>','','','','',-1,-1);
node.setScript('selectCategory(tree.getSelect().id)');
			
<%
	String sqltmp = "select * from docuserselfcategory where userid = "+user.getUID()+" order by parentids";
	RecordSet.executeSql(sqltmp);
	while(RecordSet.next()){
		String tmpid = RecordSet.getString("id");
		String tmpname = Util.toHtml4(RecordSet.getString("name"));
        //System.out.println(tmpname);
		String tmpparentid = RecordSet.getString("parentid");
		String tmpparentids = RecordSet.getString("parentids");
		ArrayList tmparray = Util.TokenizerString(tmpparentids,",");;
		
		if(tmpparentid.equals("0")){
		%>
			node = tree.add(0,Tree_ROOT,Tree_LAST,'<%=tmpname%>','','','','',<%=tmpid%>,<%=tmparray.size()%>);
			node.setScript('selectCategory(tree.getSelect().id)');
		<%}
		else{
		%>
			parentNode = findThisNode(<%=tmpparentid%>, <%=tmparray.size()-1%>);
			node=parentNode.addChild(Tree_LAST, '<%=tmpname%>','','','','',<%=tmpid%>,<%=tmparray.size()%>);
			node.setScript('selectCategory(tree.getSelect().id)');
			parentNode = findThisNode(<%=tmpid%>, <%=tmparray.size()%>);
			parentNode.setScript('selectCategory(tree.getSelect().id)');
		<%}
	}
	
%>

</script>
</BODY></HTML>
