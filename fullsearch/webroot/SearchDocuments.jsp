<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="demo" class="com.weaver.ecology.search.web.SearchDocumentsBean"/>
<jsp:setProperty name="demo" property="pageContext" value="<%=pageContext%>"/>
<jsp:setProperty name="demo" property="key" param="key"/>
<jsp:setProperty name="demo" property="page" param="page"/>
<jsp:setProperty name="demo" property="init" value="true"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>e-cology�ĵ�ȫ�ļ���_<c:out value="${key}"/></title>
   
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="Keywords" content="keyword1,keyword2,keyword3" />
    <meta http-equiv="Description" content="This is my page" />
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <style type="text/css">
    	body{}
		.search{width:80%;margin:0px auto;}
		.searchInfo{background-color:#DDDDDD;}
		.result{font-size:10pt;}
		.result div{text-indent:20px;}
		.result b{color:#CC0000;}
    </style>
    <script language="javascript">
	    var p=<c:out value="${pageInfo}" escapeXml="false"/>;
	    var param='key=<c:out value="${key}"/>';
		var page=<c:out value="${page}"/>;
		var isLastPage=<c:out value="${isLastPage}"/>;
	    function getU(){
	    	return "SearchDocuments.jsp";
	    }
	    function initPage(){
		    var s='';
		    var getUrl=function(page,text){
		    	return "<a href='"+getU()+"?"+param+"&page="+page+"'>"+text+"</a>";
		    }
		    /*var pageInfo=document.getElementById("pageInfo");
		    for(var i=1;i<=p.pages;i++){
		    	s+=(i==p.page)?"["+i+"]":getUrl(i);
		    }*/
			var getPages=function(){
				var t='',t1;
				for(var i=1;i<=page;i++){
					t1="["+i+"]";
					if(i==page){t+=t1;continue;}
					//var t1=(i==1)?'��һҳ':'['+i+']';
					t+=getUrl(i,t1)+"&nbsp;";
				}
				return t;
			}
			if(page==1)s+=getUrl(2,'��һҳ');
			else s+=getPages()+"&nbsp;"+((isLastPage)?"":getUrl(page+1,'��һҳ'));
		    pageInfo.innerHTML=s;
	    }
    </script>
  <meta http-equiv="Content-Type" content="text/html; charset=GBK" /></head>
  
  <body onload="initPage()">
	<br/>

<div class="search">
	<div style="padding-left:80px;">�ĵ�&nbsp;&nbsp;<a href="#">��Ŀ</a>&nbsp;&nbsp;
	<a href="#">����</a>&nbsp;&nbsp;<a href="#">�ͻ�</a></div>
	<form action="" method="get" name="frm1" id="frm1">
	�ؼ��ʣ�
	  <input name="key" type="text" value="<c:out value="${key}"/>" size="40"/>
	<input type="submit" name="btn1" value="����" />
	</form>
	<div class="searchInfo" align="right"><c:out value="${info}"/></div>
	<div class="result">
		<c:out value="${result}" escapeXml="false"/>
	</div>
<p><span id="pageInfo"></span></p>
</div>

</body>
</html>
