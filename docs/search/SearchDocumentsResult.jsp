<%@ page language="java" import="java.util.*" pageEncoding="GBK" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page import="com.weaver.ecology.search.util.CommonUtils"%>
<jsp:useBean id="demo" class="com.weaver.ecology.search.web.SearchDocumentsBean"/>
<jsp:setProperty name="demo" property="pageContext" value="<%=pageContext%>"/>
<jsp:setProperty name="demo" property="key" param="key"/>
<jsp:setProperty name="demo" property="page" param="page"/>
<jsp:setProperty name="demo" property="init" value="true"/>



<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />

<link href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="../../js/weaver.js"></script>
    <style type="text/css">
    	body{}
		.search{width:100%;padding:2px;}
		.searchInfo{background-color:#D9E1F7;height:20px;margin-bottom:12px;margin-top:5px;}
		.result{PADDING-LEFT: 15px; FONT-SIZE: 10pt;WORD-BREAK: break-all; LINE-HEIGHT: 120%; WORD-WRAP: break-word;}
		/** {font-size:10pt;margin:0px auto;} .f **/

		.result div{text-indent:20px;}
		.result b{color:#CC0000;}
		.result span{text-indent:0px;/*background-color:#DDDDDD;*/}
		.TotopSpace{padding-top:15px}
    </style>
    <script language="javascript">
//	    var p=<c:out value="${pageInfo}" escapeXml="false"/>;
		var p='<c:out value="${pageInfo}" escapeXml="false"/>';
	    
	    var cpage = '<c:out value="${cpage}" />';
	    var maxPerPage = '<c:out value="${maxPerPage}" />';
	    var recordCount = '<c:out value="${recordCount}"/>';
	    var startRecordNum = '<c:out value="${startRecordNum}"/>';
	    var endRecordNum = '<c:out value="${endRecordNum}"/>';
	    var pages = '<c:out value="${pages}"/>';
	    var param='key=<c:out value="${key}"/>';
		var page=<c:out value="${page}"/>;
		var isLastPage=<c:out value="${isLastPage}"/>;
		var isNoResult='<c:out value="${isNoResult}"/>';
	    function getU(){
	    	return "SearchDocumentsResult.jsp";
	    }
		function searchText(){//��������
			var key=document.getElementById("key").value;
			if(key==""){
				window.alert('<%=SystemEnv.getHtmlLabelName(20456,user.getLanguage())%>');
			}else document.getElementById('frm1').submit();
		}
	    function initPage(){
			document.getElementById("key").focus();
		    if(!isLastPage && (isNoResult=="" || isNoResult=="true"))return;
		    var s='';
		    var getUrl=function(page,text){
		    	return "<a href='"+getU()+"?"+param+"&page="+page+"'>"+text+"</a>";
		    }
		   var pageInfo = document.getElementById("pageInfo");
		    var t = 0;
		    
		    var r = 0;
		    if(page - 5 >= 1){
		    	if(page + 5 <= pages){
		    	 	r = page - 4;
		    	}
		    	else if(page + 5 > pages){
		    		if(pages - 9 > 1)
		    			r = pages - 9;
		    		else
		    			r = 1;
		    	}
		    
		    }else{ 
		    	r = 1;
		    	} 
		    	
		   
		    var ll='<%=CommonUtils.getLabelById(1258)%>';/*��һҳ*/	
		    if(page > 1){
		    	s += getUrl(page-1,ll)+"&nbsp;";
		    }
		    	
		    	
		    for(var i = r; i <= pages; i++){

		    	 s+=(i==page)?"<font color = 'red'>"+i+"</font>&nbsp;":getUrl(i,i)+"&nbsp;"; 	
		    	 t++;
		    	 if(t == 10) break;
		    }
		   	if(pages == 1) s = '';
		   	var lll='<%=CommonUtils.getLabelById(1259)%>';/*��һҳ*/			
			s+= (recordCount==endRecordNum)?"":getUrl(page+1,lll);
		    pageInfo.innerHTML= s; 
		   
	    }
    </script>

</head>
<%
String name = CommonUtils.getLabelById(58);/*�ĵ�ȫ�ļ���*/
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(18446,user.getLanguage())+":"+name;
String needfav ="1";
String needhelp ="";
boolean canEdit = false;
%>
<body onLoad="initPage()">

<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:searchText(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width="100%" height="98%" border="1" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10"/>
<col width=""/>
<col width="10"/>
</colgroup>
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<table class=Shadow>
<tr>
<td valign="top">
<div class="search">
	<form action="" method="get" name="frm1" id="frm1">
	<table width="100%" class="ViewForm">
	<tr><td height="18" colspan="2"><%=SystemEnv.getHtmlLabelName(18446,user.getLanguage())%></td></tr>
	<tr class="Spacing"><td class="Line1" colspan="2"></td></tr>
	<tr>
	  <td><%=SystemEnv.getHtmlLabelName(19049,user.getLanguage())%><!--ģ��--></td>
	<td class="Field">
	<!--<label for="searchAll"><input type="radio" name="searchType" id="searchAll" value="all" >--><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%><!--</label>-->&nbsp;
		<label for="searchDocument"><input type="radio" name="searchType" id="searchDocument" checked value="document"><%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></label>&nbsp;
		<!--<label for="searchWorkflow"><input type="radio" name="searchType" id="searchWorkflow" value="workflow" >--><%=SystemEnv.getHtmlLabelName(18015,user.getLanguage())%><!--</label>-->&nbsp;<%=SystemEnv.getHtmlLabelName(17855,user.getLanguage())%><!--</label>-->&nbsp;
		<!--<label for="searchClient"><input type="radio" name="searchType" id="searchClient" value="client" >--><%=SystemEnv.getHtmlLabelName(136,user.getLanguage())%><!--</label>-->&nbsp;
		<!--<label for="searchProject"><input type="radio" name="searchType" id="searchProject" value="project" >--><%=SystemEnv.getHtmlLabelName(101,user.getLanguage())%><!--</label>-->&nbsp;	</td>
	</tr>
	<tr><td class="Line" colSpan="2"></td></tr>
	<tr>
	  <td><%=CommonUtils.getLabelById(2095)%></td>
	  <td class="Field"><!--�ؼ���-->
	    <input class="InputStyle" id="key" name="key" type="text" value='<c:out value="${key}"/>' size="50"/>
	  </td>
	</tr>
	<tr><td class="Line" colSpan="2"></td></tr>
	<!--
	<tr>
	<td><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></td><td class="Field">
	<label for="docAll"><input type="radio" id="docAll" name="sdoctype" checked ><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></label>&nbsp;
		<label for="docHtml"><input type="radio" id="docHtml" name="sdoctype" >HTML<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></label>&nbsp;
		<label for="docWord"><input type="radio" id="docWord" name="sdoctype" >WORD<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></label>&nbsp;
		<label for="docExcel"><input type="radio" id="docExcel" name="sdoctype" >EXCEL<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></label>&nbsp;
		<label for="docPdf"><input type="radio" id="docPdf" name="sdoctype" >PDF<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></label>&nbsp;
	</td>
	</tr>-->
	</table>
	<!--<label for="searchCollaboration"><input type="radio" name="searchType" id="searchCollaboration" value="collaboration" >-->
	</form>
	<div class="searchInfo" align="right">
		<c:out value="${key1}"/>, <c:out value="${pagese}"/>��  (<c:out value="${info}"/>)
	</div>
	<div class="result">
		<c:out value="${result}" escapeXml="false"/>
	</div>
	<div style="width:80%;text-align:center;"><span id="pageInfo"></span></div>

<!--
<form action="" method="get" name="frm2" id="frm2">
	<table width="100%"><tr>
	  <td width="7%">-->
	  <!--�ؼ���,,,<%=CommonUtils.getLabelById(2095)%>-->
	  <!--</td><td width="31%" class="Field" ><input class="InputStyle" style="FONT-FAMILY: arial;FONT-SIZE:16px;width:300px;" name="key" type="text" value='<c:out value="${key}"/>' size="50"/></td><td width="62%">
	<button accesskey="S" class="btn" onClick="document.getElementById('frm2').submit();"><u>S</u>-<%=CommonUtils.getLabelById(197)%></button>
	</td></tr></table>
	</form>
-->

</div></td>
</tr>
</table>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
</body></html>
