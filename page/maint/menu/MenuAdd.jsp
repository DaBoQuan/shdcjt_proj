<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.systeminfo.systemright.CheckSubCompanyRight" %>
<%@ include file="/systeminfo/init.jsp" %>

<%

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(86,user.getLanguage());
String needfav ="1";
String needhelp ="";
String menutype = Util.null2String(request.getParameter("menutype"));
String subCompanyId = Util.null2String(request.getParameter("subCompanyId"));
boolean HeadMenuhasRight = HrmUserVarify.checkUserRight("HeadMenu:Maint", user);	//�ܲ��˵�ά��Ȩ�� 
boolean SubMenuRight = HrmUserVarify.checkUserRight("SubMenu:Maint", user);			//�ֲ��˵�ά��Ȩ��  

boolean hasRight =false;
/*CheckSubCompanyRight cscr=new CheckSubCompanyRight();
int opreateLevel=cscr.ChkComRightByUserRightCompanyId(user.getUID(),"homepage:Maint",Util.getIntValue(subCompanyId));
hasRight = HrmUserVarify.checkUserRight("homepage:Maint", user);*/
if(HeadMenuhasRight || SubMenuRight)
	hasRight = true;
/*if(user.getUID()==1||opreateLevel>0){
	hasRight = true;
}*/
if(!hasRight){
	response.sendRedirect("/notice/noright.jsp");
	return;
}

%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
  
   	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(this),_self} " ;
   	RCMenuHeight += RCMenuHeightStep ;

	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onGoBack(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<html>
  <head>
    <link href="/css/Weaver.css" type=text/css rel=stylesheet>
	<SCRIPT language="javascript" src="/js/weaver.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.js"></script>
  </head>
<body>
	<TABLE width=100% height=100% border="0" cellspacing="0">
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
			<form method="post" action="MenuOperate.jsp" name="frmAdd">
			<input type="hidden" name="method" value="add">
			<input type="hidden" name="menutype" value="<%=menutype%>">
			<input type="hidden" name="subCompanyId" value="<%=subCompanyId %>">
			<table class="Shadow">
				<colgroup>
				<col width="1">
				<col width="">
				<col width="10">
				<tr>
					<TD></td>		
					<td valign="top">
						<table class="viewForm"> 							
							<tr>
								<td width="20%"><%=SystemEnv.getHtmlLabelName(229,user.getLanguage())%><!--����--></td>
								<td width="80%" class="field">
									<input type="text" class="inputstyle" name="menuname" id="menuname"  onChange="checkinput('menuname','menunameSpan');if(this.value=='') $('#checkTitleName').hide();">
									<span id=menunameSpan name=menunameSpan><IMG src='/images/BacoError.gif' align=absMiddle></span>
									<span id="checkTitleName" style="color: red;display: none">(<%=SystemEnv.getHtmlLabelName(229,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>)</span><!-- �����Ѿ����� -->
								</td>
							</tr>
							<tr style="height:1px;"><td class="line" colspan=2></td></tr>
							<tr>
								<td><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%><!--����--></td>
								<td class="field"><input type="text"  style="width:50%" class="inputstyle" name="menudesc"></td>
							</tr>
							<tr style="height:1px;"><td class="line" colspan=2></td></tr>
						
						</table>						
					</td>
					<td></td>		
				</tr>			
			</table>
			</form>
	    </td>
		<td></td>
	</tr>
	<tr>
		<td height="10" colspan="3"></td>
	</tr>
</TABLE>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function onSave(obj){		
		if(check_form(document.frmAdd,'menuname')){
			 var menuname=$("#menuname").val();
			 //���������ظ�����֤
			 $.post("MenuOperate.jsp?method=checkMenuName&subCompanyId=<%=subCompanyId %>&menutype=<%=menutype%>&menuname="+menuname,{},function(data){
			     if($.trim(data)=="false"){
			        saveMenu();
			        $("#checkTitleName").hide();
			     }
			     else
		            $("#checkTitleName").show();
		     });
	   }
	}
	
	function saveMenu(){
	   enableAllmenu();
	   frmAdd.submit();
	}
	
	function onGoBack(){
	  if(confirm("<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%>��"))
	    history.go(-1);
	}
//-->
</SCRIPT>