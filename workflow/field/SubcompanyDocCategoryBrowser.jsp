<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="weaver.workflow.field.SubcompanyDocCategoryUtil" %>

<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubcompanyDocCategoryManager" class="weaver.workflow.field.SubcompanyDocCategoryManager" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(19207,user.getLanguage());
String needfav ="1";
String needhelp ="";
 
%>

<%
if(!HrmUserVarify.checkUserRight("FieldManage:All", user)){
    response.sendRedirect("/notice/noright.jsp");
    return;
}

int fieldId = Util.getIntValue(request.getParameter("fieldId"),0);
int isBill = Util.getIntValue(request.getParameter("isBill"),0);
int selectValue = Util.getIntValue(request.getParameter("selectValue"),-1);

String companyIcon = "/images/treeimages/global16.gif";
String docPath = SubcompanyDocCategoryUtil.getDocPath(fieldId,isBill,selectValue,0,"0");
%>

<HTML>
<HEAD>
<link type="text/css" rel="stylesheet" href="/css/Weaver.css">
<link type="text/css" rel="stylesheet" href="/js/xloadtree/xtree.css">
<style>
TABLE.Shadow A {
	COLOR: #333; TEXT-DECORATION: none
}
TABLE.Shadow A:hover {
	COLOR: #333; TEXT-DECORATION: none
}

TABLE.Shadow A:link {
	COLOR: #333; TEXT-DECORATION: none
}
TABLE.Shadow A:visited {
	TEXT-DECORATION: none
}
</style>
<script type="text/javascript" src="/js/xloadtree/xtree4SubcompanyDocCategory.js"></script>
<script type="text/javascript" src="/js/xloadtree/xloadtree4SubcompanyDocCategory.js"></script>
<script type="text/javascript" src="/js/xmlextras.js"></script>
</head>
<body>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td></td>
<td valign="top">
<TABLE class="Shadow">
<tr>
<td valign="top">		
<!--=================================-->
<TABLE class=ListStyle cellspacing=1>
<TR class=Header>
	<TH width="50%"><%=SystemEnv.getHtmlLabelName(17871,user.getLanguage())%></TH>
	<th width="50%"><%=SystemEnv.getHtmlLabelName(19207,user.getLanguage())%></th>
</TR>
<TR class=Line>
	<TD colSpan="2"></TD>
</TR>
<tr>
	<td colspan="2" id="treeTD">
	<script type="text/javascript">
	webFXTreeConfig.blankIcon		= "/images/xp2/blank.png";
	webFXTreeConfig.lMinusIcon		= "/images/xp2/Lminus.png";
	webFXTreeConfig.lPlusIcon		= "/images/xp2/Lplus.png";
	webFXTreeConfig.tMinusIcon		= "/images/xp2/Tminus.png";
	webFXTreeConfig.tPlusIcon		= "/images/xp2/Tplus.png";
	webFXTreeConfig.iIcon			= "/images/xp2/I.png";
	webFXTreeConfig.lIcon			= "/images/xp2/L.png";
	webFXTreeConfig.tIcon			= "/images/xp2/T.png";

	var rti;
	var tree = new WebFXTree('<%=CompanyComInfo.getCompanyname("1")%>','0|0|<%=docPath%>','','<%=companyIcon%>','<%=companyIcon%>');
	<%out.println(SubcompanyDocCategoryManager.getSubCompanyTreeJSByComp(fieldId,isBill,selectValue));%>
	document.write(tree);
	//rti.expand();
	</script>
	</td>
</tr>
</table>
<!--=================================-->
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>

</body>
</html>


<script type="text/javascript">


function onShowCatalog(flowType,obj){
	if(flowType=="0"){
		var result = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CategoryBrowser.jsp");
	}else if(flowType=="1"){
		var result = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CategoryBrowser.jsp");
	}
	if(result==null) return false;
	
	var vary0 = wuiUtil.getJsonValueByIndex(result, 0);
	var vary1 = wuiUtil.getJsonValueByIndex(result, 1);
	var vary2 = wuiUtil.getJsonValueByIndex(result, 2);
	var vary3 = wuiUtil.getJsonValueByIndex(result, 3);
	var vary4 = wuiUtil.getJsonValueByIndex(result, 4);
	
	var docPath=vary2;
	var docCategory=vary3+","+vary4+","+vary1;

	if(typeof(vary2)=="undefined"){
		docPath="";
	}
	if(typeof(vary3)=="undefined"){
		docCategory="";
	}
	var arrayObj = obj.split("|");
	if(arrayObj[1]=="3"){
		location.href = "SubcompanyDocCategoryOperation.jsp?fieldId=<%=fieldId%>&isBill=<%=isBill%>&selectValue=<%=selectValue%>&syc=y&flowType="+flowType+"&objId="+arrayObj[0]+"&objType="+arrayObj[1]+"&docCategory="+docCategory+"&docPath="+docPath;
	}else{
		if(confirm("<%=SystemEnv.getHtmlLabelName(18260,user.getLanguage())%>?")){
			location.href = "SubcompanyDocCategoryOperation.jsp?fieldId=<%=fieldId%>&isBill=<%=isBill%>&selectValue=<%=selectValue%>&syc=y&flowType="+flowType+"&objId="+arrayObj[0]+"&objType="+arrayObj[1]+"&docCategory="+docCategory+"&docPath="+docPath;
		}else{
			location.href = "SubcompanyDocCategoryOperation.jsp?fieldId=<%=fieldId%>&isBill=<%=isBill%>&selectValue=<%=selectValue%>&syc=n&flowType="+flowType+"&objId="+arrayObj[0]+"&objType="+arrayObj[1]+"&docCategory="+docCategory+"&docPath="+docPath;
		}
	}
}

</script>