<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.formmode.tree.CustomTreeData" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML>
<HEAD>
	<TITLE></TITLE>
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client.js"></script>
	<link rel="stylesheet" href="/wui/common/jquery/plugin/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</HEAD>
	<%
		String id = Util.null2String(request.getParameter("id"));
		String expandfirstnode = Util.null2String(request.getParameter("expandfirstnode"));
		String sql = "select * from mode_customtree where id = " + id;
		rs.executeSql(sql);
		while(rs.next()){
			expandfirstnode = Util.null2String(rs.getString("expandfirstnode"));
		}
	%>
<BODY>
	<div style="height:100%">
		<ul id="CustomTree" class="ztree"></ul>
	</div>
	
	<FORM NAME=SearchForm id="SearchForm" STYLE="margin-bottom:0" action="/formmode/tree/CustomTreeRight.jsp" method="get" target="contentframe">
		<input class=inputstyle type="hidden" name="mainid" id="mainid" value="<%=id%>">
		<input class=inputstyle type="hidden" name="name" id="name" value="">
		<input class=inputstyle type="hidden" name="pid" id="pid" value="0<%=CustomTreeData.Separator %>0">
	</FORM>
	
</BODY>
	<SCRIPT type="text/javascript">
	var firstclick = 0;
	var expandfirstnode = "<%=expandfirstnode%>";
	/**
	 * ��ȡurl��alax��ʽ����ӽڵ�ʱʹ�ã�
	 */
	function getAsyncUrl(treeId, treeNode) {
		var url = "";
		//��ȡ�ӽڵ�ʱ
	    if (treeNode != undefined && treeNode.isParent != undefined && treeNode.isParent != null) {
	    	url = "/formmode/tree/CustomTreeAjax.jsp?id=<%=id%>&&init=false&" + new Date().getTime() + "=" + new Date().getTime();
	    } else {
	    	//��ʼ��ʱ
	    	url = "/formmode/tree/CustomTreeAjax.jsp?id=<%=id%>&init=true";
	    }
	    return url;
	};
	//zTree������Ϣ
	var setting = {
		async: {
			enable: true,       //�����첽����
			dataType: "text",   //ajax��������
			url: getAsyncUrl,    //ajax��url
			type:"post",
			autoParam: ["id=pid","name=name"]
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
		$.fn.zTree.init($("#CustomTree"), setting, zNodes);
	});
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	    var treeObj = $.fn.zTree.getZTreeObj(treeId);
		var node = treeObj.getNodeByParam("id", "field_0", null);
	    if (node != undefined && node != null ) {
	    	treeObj.selectNode(node);
	    	zTreeOnClick(event, treeId, node);
	    	alert(222);
	    }

		//Ĭ��չ��һ���ڵ�
	    if(firstclick==0&&expandfirstnode==1){
			$("#CustomTree_1_switch")[0].click();
			firstclick++;
	    }
	    
	}
	
	function zTreeOnClick(event, treeId, treeNode) {
	    var treeObj = $.fn.zTree.getZTreeObj(treeId);
	    if (treeNode.isParent) {
			treeObj.expandNode(treeNode);
		}
		setTreeField(treeNode);
	};

	function setTreeField(treeNode) {
		var url = "/formmode/tree/CustomTreeHrefAjax.jsp?mainid=<%=id%>&pid="+treeNode.id;
		jQuery.ajax({
			url : url,
			type : "post",
			processData : false,
			data : "",
			dataType : "text",
			async : true,
			success: function do4Success(msg){
				var returnurl = jQuery.trim(msg);
				if(returnurl==""){
					
				}else{//������ص�url��Ϊ�գ���ôҳ����ת
					if(returnurl.toLowerCase().indexOf("http")>-1){
						$("#SearchForm").attr("method","get");
					}else{
						$("#SearchForm").attr("method","post");
					}
					$("#SearchForm").attr("action",returnurl);
				    $("#SearchForm")[0].submit();
				}
			}
		});

	}
	</SCRIPT>
</HTML>