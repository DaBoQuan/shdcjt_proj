<%@ page language="java" contentType="text/html; charset=GBK" %> 

<%@ page import="weaver.docs.category.DocTreeDocFieldConstant" %>

<%@ include file="/systeminfo/init.jsp" %>
<%
	if (!HrmUserVarify.checkUserRight("ModeSetting:All", user)) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
%>
<%

String treeFieldId=Util.null2String(request.getParameter("treeFieldId"));
String err=Util.null2String(request.getParameter("err"));
%>

<HTML><HEAD>
	
	<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client.js"></script>
	<link rel="stylesheet" href="/wui/common/jquery/plugin/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript">
if (window.jQuery.client.browser == "Firefox") {
	jQuery(document).ready(function (){
		jQuery("#ztreeDiv").height(jQuery(document.body).height());
	});
}
</script>
</HEAD>

<BODY>
<FORM NAME=SearchForm id="SearchForm" STYLE="margin-bottom: 0"
	action="DocTreeDocFieldDsp.jsp" method=post target="contentframe">

<table height="100%" width=100% class="ViewForm" valign="top">

	<!--######## Search Table Start########-->
	<TR>
		<td height="100%">	
			 <div id="ztreeDiv" style="height:100%;width:100%;">
             	 <ul id="ztreeObj" class="ztree"></ul>
             </div>
		<td>
	</tr>
</table>

<input class=inputstyle type="hidden" name="id" id="hdnid">
<input class=inputstyle type="hidden" name="typeId" id="typeId">
</FORM>

</BODY>
</HTML>
<script type="text/javascript">
	/**
	 * ��ȡurl��alax��ʽ����ӽڵ�ʱʹ�ã�
	 */
	function getAsyncUrl(treeId, treeNode) {
		//��ȡ�ӽڵ�ʱ
	    if (treeNode != undefined && treeNode.isParent != undefined && treeNode.isParent != null) {
	    	return "/formmode/setup/ModeTreeLeftXML.jsp?" + treeNode.ajaxParam + "&" + new Date().getTime() + "=" + new Date().getTime();
	    } else {
	    	//��ʼ��ʱ
	    	return "/formmode/setup/ModeTreeLeftXML.jsp";
	    }
	};
	//zTree������Ϣ
	var setting = {
		async: {
			enable: true,       //�����첽����
			dataType: "text",   //ajax��������
			url: getAsyncUrl    //ajax��url
		},
		data: {
			simpleData: {
				enable: true,   //���ص�json����Ϊ���������ͣ��Ǹ���json��������
				idKey:"id",     //tree�ı�ʶ����
				pIdKey:"pId",   //���ڵ��ʶ����
				rootPId: 0      //�����ڵ�ĸ�id
			}
		},
		view: {
			expandSpeed: ""     //Ч��
		},
		callback: {
			onClick: zTreeOnClick,   //�ڵ����¼�
			onAsyncSuccess: zTreeOnAsyncSuccess  //ajax�ɹ��¼�
		}
	};
	var zNodes =[];
	$(document).ready(function(){
		//��ʼ��zTree
		$.fn.zTree.init($("#ztreeObj"), setting, zNodes);
	});
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	    var treeObj = $.fn.zTree.getZTreeObj(treeId);
	    //treeObj.expandAll(false);
		var node = treeObj.getNodeByParam("id", "field_<%=treeFieldId%>", null);
	    if (node != undefined && node != null ) {
	    	treeObj.selectNode(node);
	    	zTreeOnClick(event, treeId, node);
	    }
	}
	
	function zTreeOnClick(event, treeId, treeNode) {
	    var treeObj = $.fn.zTree.getZTreeObj(treeId);
	    if (treeNode.isParent) {
			treeObj.expandNode(treeNode);
		}
		setTreeField(treeNode.id);
	};

	function setTreeField(nodeId) {
	    var treeFieldId = "";
	    var treetype = nodeId.split("_");
		if(treetype.length == 3){
			treeFieldId = treetype[2];
			$("#SearchForm").attr("action", "ModeManage.jsp");
		    $("#hdnid").val(treeFieldId);
		    $("#typeId").val(treetype[1]);
		    $("#SearchForm")[0].submit();
		}else{
			treeFieldId = nodeId.substring(nodeId.lastIndexOf("_")+1);
			$("#SearchForm").attr("action", "ModeSettingRight.jsp");
		    $("#hdnid").val(treeFieldId);
		    $("#SearchForm")[0].submit();
		}
	}
	
</SCRIPT>