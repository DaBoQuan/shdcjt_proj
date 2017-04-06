<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="DocSearchComInfo" class="weaver.docs.search.DocSearchComInfo" scope="session"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>
<%
//��ǰ�û�Ϊ��¼���˻������ϼ����߾��С���ְ������Ȩ����ɲ鿴��ҳ��
String id = Util.null2String(request.getParameter("id"));
String userId = "" + user.getUID();
String managerId = ResourceComInfo.getManagerID(id);
if(!userId.equals(id) && !userId.equals(managerId) && !HrmUserVarify.checkUserRight("Resign:Main", user)){
	response.sendRedirect("/notice/noright.jsp");
	return;
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
int userid=Util.getIntValue(request.getParameter("id")) ;
String loginType = "0" ;



//��ʼ��ֵ
String doccreaterid = ""+userid ;
String docstatus = Util.null2String(request.getParameter("docstatus"));
String maincategory = Util.null2String(request.getParameter("maincategory"));
String dspreply = Util.null2String(request.getParameter("dspreply")) ;

if(doccreaterid.equals("")) doccreaterid = ""+user.getUID() ;
if(dspreply.equals("")) dspreply="1";
//ҳ����
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(58,user.getLanguage())+":" ;
if(user.getLogintype().equals("1"))
	titlename += ResourceComInfo.getResourcename(doccreaterid);
else
    titlename += CustomerInfoComInfo.getCustomerInfoname(doccreaterid);

String needfav ="1";
String needhelp ="";


//  ��ѯ����
DocSearchComInfo.resetSearchInfo() ;
DocSearchComInfo.setDoccreaterid(doccreaterid) ;
DocSearchComInfo.setUsertype(user.getLogintype()) ;
if(!docstatus.equals(""))  DocSearchComInfo.addDocstatus(docstatus) ;
if(!maincategory.equals(""))  DocSearchComInfo.setMaincategory(maincategory) ;

if ("0".equals(dspreply)) DocSearchComInfo.setContainreply("1");   //ȫ��
else if("1".equals(dspreply)) DocSearchComInfo.setContainreply("0");   //�ǻظ�
else if ("2".equals(dspreply)) DocSearchComInfo.setIsreply("1");  //���ظ�
//backFields
String backFields="t1.id,t1.seccategory,doclastmodtime,docsubject,t1.docextendname,";
//from
String sqlFrom = "DocDetail  t1";
//where

String sqlWhere = " where  t1.ownerid="+userid+" " ;
//orderBy
String orderBy = "doclastmoddate,doclastmodtime";
//primarykey
String primarykey = "t1.id";
//pagesize
int pagesize = UserDefaultManager.getNumperpage();
if(pagesize <2) pagesize=10;
//colString
String colString ="<col name=\"id\" width=\"3%\"  align=\"center\" text=\" \" column=\"docextendname\" orderkey=\"docextendname\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocIconByExtendName\"/>";
       colString +="<col name=\"id\" width=\"21%\"  text=\"�ĵ�\" column=\"id\" orderkey=\"docsubject\" target=\"_fullwindow\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocName\" href=\"/docs/docs/DocDsp.jsp\" linkkey=\"id\" />";


//  �û��Զ�������
boolean dspcreater = false ;
boolean dspcreatedate = false ;
boolean dspmodifydate = false ;
boolean dspdocid = false;
boolean dspcategory = false ;
boolean dspaccessorynum = false ;
boolean dspreplynum = false ;




      backFields+="ownerid,";
      colString +="<col width=\"8%\"  text=\"������\" column=\"ownerid\" orderkey=\"ownerid\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getName\"  otherpara=\""+loginType+"\"/>";


    backFields+="doccreatedate,";
    colString +="<col width=\"10%\"  text=\"��������\" column=\"doccreatedate\" orderkey=\"doccreatedate\"/>";

    backFields+="doclastmoddate,";
    colString +="<col width=\"10%\"  text=\"�޸�����\" column=\"doclastmoddate\" orderkey=\"doclastmoddate,doclastmodtime\"/>";

    backFields+="maincategory,";
    colString +="<col width=\"14%\"  text=\"Ŀ¼\" column=\"id\" orderkey=\"maincategory\" returncolumn=\"id\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getAllDirName\"/>";

    backFields+="replaydoccount,";
    colString +="<col width=\"7%\"  text=\"�ظ���\" column=\"replaydoccount\" orderkey=\"replaydoccount\"/>";

    backFields+="accessorycount,";
    colString +="<col width=\"7%\" text=\"������\" column=\"accessorycount\" orderkey=\"accessorycount\"/>";

backFields+="sumReadCount,docstatus";
colString +="<col width=\"7%\"   text=\"�����\" column=\"sumReadCount\" orderkey=\"sumReadCount\"/>";
colString +="<col width=\"5%\"  text=\"״̬\" column=\"docstatus\" orderkey=\"docstatus\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocStatus\"/>";

//Ĭ��Ϊ���ĵ�����������������,����Ҫ������ֶ�
if (backFields.indexOf("doclastmoddate")==-1) {
    backFields+=",doclastmoddate";
}

String tableString="<table  pagesize=\""+pagesize+"\" tabletype=\"none\">";
       tableString+="<sql backfields=\""+backFields+"\" sqlform=\""+sqlFrom+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\""+primarykey+"\" sqlsortway=\"Desc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqldistinct=\"true\"/>";
       tableString+="<head>"+colString+"</head>";

       tableString+="</table>";
%>



<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%

    RCMenu += "{����,javascript:window.history.go(-1),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<TABLE width=100% height=100% border="0" cellspacing="0" cellpadding="0" valign="top">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<TD valign="top">
		<TABLE class=Shadow valign="top">
		<TR>
            <TD valign="top">
            <FORM name="frmSearch" method="post" action="">
                <TABLE class=ViewForm valign="top">

                     <TR>
                         <TD valign="top"  colspan=6>
                             <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run"/>
                          </TD>
                     </TR>
                </TABLE>
                </FORM>
             </TD>
         </TR>
         </TABLE>
    </TD>
    <td ></td>
</TR>
</TABLE>
    <FORM name="frmPostData" method="post" action="\docs\docs\DocOperate.jsp">
        <input type="hidden" name="operation">
        <input type="hidden" name="docid">
        <input type="hidden"   name="redirectTo"  value="\docs\search\DocView.jsp">
    </FORM>
</BODY>
</HTML>
<script language="javaScript">
    function onSearch(){
        frmSearch.submit();
    }

    function doDocDel(docid){
        if (isdel()){
            var url = "/docs/docs/DocOperate.jsp?operation=delete&docid="+docid;
            openFullWindow1(url);
        }
    }

    function doDocShare(docid){
        var url = "/docs/docs/DocOperate.jsp?operation=share&docid="+docid;
        openFullWindowHaveBar(url);
    }

    function doDocViewLog(docid){
        var url = "/docs/docs/DocOperate.jsp?operation=viewLog&docid="+docid;
        openFullWindowHaveBar(url);
    }
</script>