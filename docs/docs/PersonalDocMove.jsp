<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.docs.category.security.*" %>
<%@ page import="weaver.docs.category.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String docids= ",";
String foldids=  ",";

String[] selectFiles = request.getParameterValues("selectfile");
String[] selectFolders = request.getParameterValues("selectfolder");
if (selectFiles != null){
    for (int i=0;i<selectFiles.length;i++){
        docids += selectFiles[i] +",";
    }
} 
if (selectFolders != null){
     for (int i=0;i<selectFolders.length;i++){
        foldids += selectFolders[i] +",";
    }
}

%>

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
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
	   
	 document.all("tocategory").value=node.categoryid;
}
</script>
</HEAD>
<BODY>
<%
int haspost= Util.getIntValue(request.getParameter("haspost"),0);
int msg= Util.getIntValue(request.getParameter("msg"),0);


String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(78,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(18493,user.getLanguage())+"/"+SystemEnv.getHtmlLabelName(18473,user.getLanguage());
String needfav ="";
String needhelp ="";

if(haspost == 1&&msg==0){%>

<script language=javascript>
window.opener.parent.Pdocright.document.location.reload(true);
window.close();
</script>
<%}%>

<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:checkForm(this),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;

    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.go(-1),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<DIV class=HdrProps>
<%if(haspost==1&&msg==1){%>
<font color=red>��ѡ�ļ�����Ч��������ѡ��</font>
<%}%>
</DIV>

<form method="POST" action="PersonalDocOperation.jsp" name="create_folder_form">
<input type=hidden name="docids" value="<%=docids%>">
<input type=hidden name="foldids" value="<%=foldids%>">
<input type=hidden name="operation" value="movedoc">
<input type=hidden name="tocategory" value="-1">

<table class=form>
    <colgroup>
        <col width=100%>
    <tr class=separator>
        <TD class=Sep1 colspan=1></TD>
    </tr>
</table>

</form>
<script src=/js/tree_maker2.js></script>
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
function checkForm(obj){
    obj.disabled = true ;
	document.create_folder_form.submit();
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

node = tree.add(0,Tree_ROOT,Tree_LAST,'<%=SystemEnv.getHtmlLabelName(18476,user.getLanguage())%>','','','','',0,0);
node.setScript('selectCategory(tree.getSelect().id)');
			
<%
	String sqltmp = "select * from docuserselfcategory where userid = "+user.getUID()+" order by parentids";
	RecordSet.executeSql(sqltmp);
	while(RecordSet.next()){
		String tmpid = RecordSet.getString("id");
		String tmpname = RecordSet.getString("name");
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
