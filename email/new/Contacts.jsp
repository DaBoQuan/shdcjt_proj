<%@page import="weaver.email.domain.MailContact"%>
<%@page import="weaver.email.domain.MailGroup"%>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="gms" class="weaver.email.service.GroupManagerService" scope="page" />
<jsp:useBean id="cms" class="weaver.email.service.ContactManagerService" scope="page" />

<html>
	<head>
		<link href="/email/css/base.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript">var languageid=<%=user.getLanguage()%>;</script>
		
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
		
		<script type="text/javascript" src="/email/js/autocomplete/jquery.autocomplete.js"></script>
		<link href="/email/js/autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
	</head>
<%
	int allContactCount = cms.getAllContactCountById(user.getUID());
	int notGroupContactCount = cms.getNotGroupContactCountById(user.getUID());
%>
	<body >
		<div class="hideScroll w-all h-all">
			<div class="left leftMenu h-all" style="overflow: auto;" id="_left">
				<div id="nav" class="btnNav p-l-5">
					<div class="left addContacts" id="addContact" onclick="addContact()"><%=SystemEnv.getHtmlLabelName(81294,user.getLanguage()) %></div>
					<div class="left addGroup" method="addGroup" onclick="addGroup(this)"><%=SystemEnv.getHtmlLabelName(30131,user.getLanguage()) %></div>
					<div class="clear"></div>
				</div>
				<!-- ���б� -->
				<div id="contactsTree"></div>
			</div>
			<div id="right" class="left h-all p-l-5 ">
				<iframe src="/email/new/ContactList.jsp?mailgroupid=<%=Integer.MAX_VALUE%>" name="contactTable" id="contactTable" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>
			</div>
			<div class="clear"></div>
		</div>
		
	</body>
</html>

<style>
.btnSpan{
	cursor: pointer;
	padding:1px;
}
.btnSpanOver{
	padding:1px;
	cursor: pointer;
	color:#ffffff;
	background: #36c;
	border-radius:3px;
}
.btn{
	padding-left :14px;
	padding-right:14px;
	height: 28px;
	background-image: url("/email/images/btn.png");
	background-repeat:no-repeat;
	line-height: 28px;
	text-align: center;
	cursor: pointer;
	color:#555555;
	border: 1px solid #bbbbbb;
	border-radius:3px;
}
.leftMenu{
	width: 203px;
	background: #f6f6f6;
	border-bottom: 1px solid #cccccc;
 	border-left: 1px solid #cccccc;
 	border-right: 1px solid #cccccc;
}
.addContacts{
	background: url("/email/images/contactsIconBg.png") no-repeat;
	color:#3C6692;
	height: 34px;
	width: 88px;
	margin-top: 10px;
	cursor: pointer;
	outline: 0;
	padding: 0;
	display: inline-block;
	height: 34px;
	width: 88px;
	font-size: 14px;
	line-height: 34px;
	position: relative;
	z-index: 1;
	text-align: center;
	line-height: 34px;
	
}

.addGroup{
	background: url("/email/images/contactsIconBg.png") no-repeat;
	background-position:	-87px 0px;
	color:#3C6692;
	height: 34px;
	width: 89px;
	margin-top: 10px;
	cursor: pointer;
	outline: 0;
	padding: 0;
	display: inline-block;
	height: 34px;
	width: 89px;
	font-size: 14px;
	line-height: 34px;
	position: relative;
	z-index: 1;
	text-align: center;
	line-height: 34px;
}

.addContacts:hover{
	background-position:	0px -48px;
} 

.addGroup:hover{
	background-position:	-87px -48px;
} 

.contactsGroup{
	line-height: 30px;
}
.contactsGroupHover{
	background: #e6e6e6;
}

.contactsAll{
	line-height: 30px;
	background: #e6e6e6;
}

div{
	font-size: 12px;
}

.hideScroll{
	overflow-x: hidden;
	overflow-y: hidden;
}

.autoScroll{
	overflow-x: auto;
	overflow-y: auto;
}


</style>

<script>

var currentGroup = <%=Integer.MAX_VALUE %>;

jQuery(document).ready(function(){
	
	
	//var  ifH=$(window.parent.document).find("#mainFrame").width()-$("#_left").width();
	//alert($(window.parent.document).find("#mainFrame").width()+"---"+$("#_left").width());
	//$("#right").width(ifH);

	
	$("#fromSearch").bind("change",function(){
		if($(this).val()!=""){
			$(".searchFrom").hide();
			$(".clearFrom").show();
		}else{
			$(".searchFrom").show();
			$(".clearFrom").hide();
		}
	})
	
	/**************************************************************/
	
	setWidth(217);
	//�������б�
	loadContactsTree();
});


/**************************************************************/

//���ÿ��
function setWidth(employWidth) {
	if(employWidth == undefined) {
		employWidth = 217;
	}
	$("div#right").width(document.body.clientWidth - employWidth-5);
	$(window).resize(function() {
		$("div#right").width(document.body.clientWidth - employWidth-5);
	});
}

//�������б�ҳ��
function loadContactsTree() {
	$("div#contactsTree").load("/email/new/GroupListLeft.jsp", function(){
		//��ʼ����߷����б�
		initContactsTree();
		//ѡ����
		selectGroup();
	});
}

//ѡ����
function selectGroup() {
	var _groupList = $("div#contactsTree");
	_groupList.find("div.contactsAll").removeClass("contactsAll");
	_groupList.find("span.bold").removeClass("bold");
	_groupList.find("div[id="+ currentGroup +"]").addClass("contactsAll");
	_groupList.find("div[id="+ currentGroup +"]").find("span#info").addClass("bold");
}

//��ʼ����߷����б�
function initContactsTree(){
	var _groups = $("#contactsTree").find("div");
	
	_groups.find("div#group").click(function(){
		currentGroup = this.parentNode.id; //���õ�ǰ��
		$("#contactTable").attr("src","/email/new/ContactList.jsp?mailgroupid="+currentGroup);
		selectGroup();
	});
	
	_groups.mouseover(function() {
		$(this).addClass("contactsGroupHover");
		$(this).find("#action").show();
	});
	_groups.mouseleave (function(){
		$(this).removeClass("contactsGroupHover");
		$(this).find("#action").hide();
	});
	
	_groups.each(function() {
		var _group = $(this).find("#group");	//ҳ����������ʾ��DIV
		var _editGroup = $(this).find("#editGroup");	//ҳ�������ڱ༭��DIV
		
		_group.each(function(){
			$(this).find("#edit").click(function(event){
				stopEvent(event);
				_group.hide();
				_editGroup.show();
				_editGroup.find("input#groupName").focus();
			});
			$(this).find("#delete").click(function(event){
				stopEvent(event);
				if(confirm("<%=SystemEnv.getHtmlLabelName(15097,user.getLanguage()) %>")) {
					var _groupId = $(this).find("input#groupId").val();
					var _param = {"method": "delete", "id": _groupId};
					$.get("/email/new/GroupManageOperation.jsp", _param, function() {
						loadContactsTree();
						window.contactTable.reLoadGroups(); //ˢ�¡��ƶ����顿�͡����Ƶ��顿�е����б�
						window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
					});
				}
			});
		});
		
		_editGroup.each(function(){
			$(this).find("input#groupName").blur(function(event){
				stopEvent(event);
				var _groupId = $(this.parentNode).find("input#groupId").val();
				var _oldGroupName = $.trim($(this.parentNode).find("input#oldGroupName").val());
				var _groupName = $.trim($(this.parentNode).find("input#groupName").val());
				if( _groupName == ""){
					alert("<%=SystemEnv.getHtmlLabelName(81311,user.getLanguage()) %>"); 
					return;
				}
				if( _groupName == _oldGroupName){
					_group.show();
					_editGroup.hide();
					return;
				}
				var _param = {"method": "edit", "id": _groupId, "groupName": _groupName};
				$.get("/email/new/GroupManageOperation.jsp", _param, function(data) {
					if(data == 0) {
						alert("<%=SystemEnv.getHtmlLabelName(30910,user.getLanguage()) %>");
					} else if(data == 1) {
						loadContactsTree();
						window.contactTable.reLoadGroups(); //ˢ�¡��ƶ����顿�͡����Ƶ��顿�е����б�
						window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
					} else if(data == 2) {
						alert("<%=SystemEnv.getHtmlLabelName(30651,user.getLanguage()) %>");
					}
				});
			});
		});
	});
}

//������鴰��
function addGroup(himself) {
	var _method = $(himself).attr("method");
	
	var contactsId = window.contactTable.getContactsId();
	
	if(_method=="cmtg" || _method=="cctg") {
		if(contactsId.length==0) {
			alert("<%=SystemEnv.getHtmlLabelName(81308,user.getLanguage()) %>");
			return;
		}
	}
	
	var diag = new Dialog();
	diag.Width = 400;
	diag.Height = 80;
	diag.Title = "<%=SystemEnv.getHtmlLabelName(81302,user.getLanguage()) %>";
	diag.InnerHtml = '<div id="groupEditor" style="padding-top: 30px;">' +
					 '<span><%=SystemEnv.getHtmlLabelName(81303 ,user.getLanguage()) %>��</span>' +
					 '<span><input type="text" class="w-300" name="groupName"></span>' +
					 '</div>';
	if(_method == "addGroup") {
		diag.OKEvent = createGroup;		//���ȷ������õķ���
	} else if(_method == "cmtg") {
		diag.OKEvent = cmtg;			//���ȷ������õķ���
	} else if(_method == "cctg") {
		diag.OKEvent = cctg;			//���ȷ������õķ���
	}
	diag.show();
	
	//���������
	function createGroup(){
		var _groupName = $.trim($("input[name=groupName]").val());
		if( _groupName == ""){
			alert("<%=SystemEnv.getHtmlLabelName(81311,user.getLanguage()) %>"); 
			return;
		}
		
		var para ={method: "add", groupName: _groupName};
		$.post("/email/new/GroupManageOperation.jsp", para, function(data){
			if(data == 0) {
				alert("<%=SystemEnv.getHtmlLabelName(30910,user.getLanguage()) %>");
			} else if(data == 1) {
				loadContactsTree(); //���¼���������б�
				window.contactTable.reLoadGroups(); //ˢ�¡��ƶ����顿�͡����Ƶ��顿�е����б�
				diag.close();
			} else if(data == -1){
				alert("<%=SystemEnv.getHtmlLabelName(30651,user.getLanguage()) %>");			
			}
		})
	}
	
	//�����½����ƶ�����
	function cmtg() {
		var _groupName = $.trim($("input[name=groupName]").val());
		if( _groupName == ""){
			alert("<%=SystemEnv.getHtmlLabelName(81311,user.getLanguage()) %>"); 
			return;
		}
		
		var param ={"idSet": contactsId.toString(), "sourceGroup": currentGroup, "groupName": _groupName, method: "cmtg"};
		$.post("/email/new/ContactManageOperation.jsp", param, function(data){
			if(data == 0) {
				alert("<%=SystemEnv.getHtmlLabelName(30910,user.getLanguage()) %>");
			} else if(data == 1) {
				loadContactsTree(); //���¼���������б�
				window.contactTable.reLoadGroups(); //ˢ�¡��ƶ����顿�͡����Ƶ��顿�е����б�
				window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
				diag.close();
			} else if(data == -1){
				alert("<%=SystemEnv.getHtmlLabelName(30651,user.getLanguage()) %>");			
			}
		})
	}
	//�����½������Ƶ���
	function cctg() {
		var _groupName = $.trim($("input[name=groupName]").val());
		if( _groupName == ""){
			alert("<%=SystemEnv.getHtmlLabelName(81311,user.getLanguage()) %>"); 
			return;
		}
		
		var param ={"idSet": contactsId.toString(),  "groupName": _groupName, method: "cctg"};
		$.post("/email/new/ContactManageOperation.jsp", param, function(data){
			if(data == 0) {
				alert("<%=SystemEnv.getHtmlLabelName(30910,user.getLanguage()) %>");
			} else if(data == 1) {
				loadContactsTree(); //���¼���������б�
				window.contactTable.reLoadGroups(); //ˢ�¡��ƶ����顿�͡����Ƶ��顿�е����б�
				window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
				diag.close();
			} else if(data == -1){
				alert("<%=SystemEnv.getHtmlLabelName(30651,user.getLanguage()) %>");			
			}
		})
	}
}

//ɾ����ϵ��
function deleteContacts(contactsId, mailgroupid) {
	if(contactsId.length > 0){
		var diag = new Dialog();
		diag.Width = 400;
		diag.Height = 90;
		diag.Title = "<%=SystemEnv.getHtmlLabelName(81299,user.getLanguage()) %>";
		if(mailgroupid==<%=Integer.MIN_VALUE %> || mailgroupid==<%=Integer.MAX_VALUE %>) {
			diag.InnerHtml = '<div class="w-all h-all">' +
							 	'<div class="font14" style="line-height: 100px;"><%=SystemEnv.getHtmlLabelName(31188,user.getLanguage()) %>��</div>' +
							 	'<input class="hide" type="checkbox" name="isTrDel" checked="true">' +
							 '</div>';
		} else {
			diag.InnerHtml = '<div class="w-all h-all">' +
						 		'<div class="font14" style="position: relative;top: 29px;"><%=SystemEnv.getHtmlLabelName(31192,user.getLanguage()) %>��</div>' +
						 		'<div class="colorred" style="position: relative;top: 35px;left: -38px;">' +
						 			'<span><input type="checkbox" name="isTrDel"></span>' +
						 			'<span><%=SystemEnv.getHtmlLabelName(31193,user.getLanguage()) %></span>' +
						 		'</div>' +
							 '</div>';
		}
		diag.OKEvent = submitDelete;//���ȷ������õķ���
		diag.show();
	} else {
		alert("<%=SystemEnv.getHtmlLabelName(81305,user.getLanguage()) %>");
	}
	
	function submitDelete() {
		var _isTrDel = $("input[name=isTrDel]").attr("checked");
		var param = {"idSet": contactsId.toString(), "isTrDel": _isTrDel, "sourceGroup": mailgroupid, "method": "delete"};
		$.get("/email/new/ContactManageOperation.jsp", param, function(){
			loadContactsTree();
			window.contactTable.deletePageContact();
			diag.close();
		});
	}
}

//��ֹ�¼�ð��
function stopEvent(event) {
	if (event.stopPropagation) { 
		// this code is for Mozilla and Opera 
		event.stopPropagation();
	} 
	else if (window.event) { 
		// this code is for IE 
		window.event.cancelBubble = true; 
	}
}

/**************start*****************MailContactAdd.jspҳ����������******************************************/

//���������ϵ��ҳ��
function addContact() {
	var diag = new Dialog();
	diag.Width = 450;
	diag.Height = 380;
	diag.Title = "<%=SystemEnv.getHtmlLabelName(19956,user.getLanguage()) %>";
	diag.URL = "/email/new/MailContacterAdd.jsp";
	diag.OKEvent = submitFMailContacter;//���ȷ������õķ���
	diag.show();
	
	function submitFMailContacter() {
		var _innerWindow = diag.innerFrame.contentWindow;
		if(_innerWindow.checkInput()) {
			var param = _innerWindow.getSerialize();
			$.post("/email/new/ContactManageOperation.jsp", param, function(){
				loadContactsTree(); //���¼���������б�
				window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
				diag.close();
			});
		} else {
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage()) %>"); 
		}
	}
}

//����ָ������ϵ��
function loadContact(id) {
	var diag = new Dialog();
	diag.Width = 450;
	diag.Height = 380;
	diag.Title = "<%=SystemEnv.getHtmlLabelName(30921,user.getLanguage()) %>";
	diag.URL = "/email/new/MailContacterAdd.jsp?id="+ id;
	diag.OKEvent = submitFMailContacter;//���ȷ������õķ���
	diag.show();
	
	function submitFMailContacter() {
		var _innerWindow = diag.innerFrame.contentWindow;
		if(_innerWindow.checkInput()) {
			var param = _innerWindow.getSerialize();
			$.post("/email/new/ContactManageOperation.jsp", param, function(){
				loadContactsTree(); //���¼���������б�
				window.contactTable._table.reLoad(); //���¼��ص�ǰ��ϵ���б�
				diag.close();
			});
		} else {
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage()) %>"); 
		}
	}
}
/**************end*****************MailContactAdd.jspҳ����������******************************************/
</script>