<%@ page language="java" contentType="text/html; charset=GBK" %>
<%response.setHeader("Cache-Control","no-store");response.setHeader("Pragrma","no-cache");response.setDateHeader("Expires",0);%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="weaver.docs.category.DocTreeDocFieldConstant" %>
<%@ page import="weaver.general.Util" %>
<%@page import="weaver.hrm.*"%>
<%
	User user = HrmUserVarify.getUser (request , response) ;
	if(user == null)  return ;
    int dummyId=Util.getIntValue(request.getParameter("dummyId"),1);
%>
<HTML>
<HEAD>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <meta http-equiv="Pragma" content="no-cache" /> 
    <meta http-equiv="Cache-Control" content="no-cache" /> 
    <meta http-equiv="Expires" content="0" />
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="/wui/common/jquery/plugin/zTree/js/jquery.ztree.core.min.js"></script>
	<link rel="stylesheet" href="/wui/common/jquery/plugin/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">	
    <base target="mainFrame"/>
<script type="text/javascript">
	/**
	 * ��ȡurl��alax��ʽ����ӽڵ�ʱʹ�ã�
	 */
	function getAsyncUrl(treeId, treeNode) {
		//��ȡ�ӽڵ�ʱ
	    if (treeNode != undefined && treeNode.isParent != undefined && treeNode.isParent != null) {
	    	return "/docs/docdummy/DocDummyLeftXML.jsp?" + treeNode.ajaxParam + "&" + new Date().getTime() + "=" + new Date().getTime();
	    } else {
	    	//��ʼ��ʱ
	    	return "/docs/docdummy/DocDummyLeftXML.jsp";
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
			onClick: zTreeOnClick   //�ڵ����¼�
		}
	};

	var zNodes =[];
	
	$(document).ready(function(){
		//��ʼ��zTree
		$.fn.zTree.init($("#ztreeObj"), setting, zNodes);
	});
	
	function zTreeOnClick(event, treeId, treeNode) {
	    var treeObj = $.fn.zTree.getZTreeObj(treeId);
	    if (treeNode.isParent) {
			treeObj.expandNode(treeNode);
		}
		treeObj.checkNode(treeNode, true, false);
	};
</SCRIPT>
	
</HEAD>

<BODY oncontextmenu="return false;" onload="onClickTreeDocField(<%=dummyId%>);">
    <table width=100% class="ViewForm" valign="top">
        <TR>
            <td>
                <div id="ztreeDiv" style="height:100%;width:100%;">
                	<ul id="ztreeObj" class="ztree"></ul>
                </div>
            <td>
        </tr>
    </table>
	<FORM NAME=SearchForm STYLE="margin-bottom:0"  method=post target="contentframe">
    <input type="hidden" name="dummyId">

    </FORM>
</BODY>
</HTML>

<script type="text/javascript">
function onClickTreeDocField(id) {
    $("form[name='SearchForm']").attr("action", "DocDummyRight.jsp");
	$("input[name='dummyId']").val(id);
	$("form[name='SearchForm']").submit();
}
</script>