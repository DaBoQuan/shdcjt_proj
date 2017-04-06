<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.interfaces.workflow.action.Action" %>
<%@ page import="weaver.general.StaticObj" %>
<jsp:useBean id="InterfaceTransmethod" class="weaver.formmode.interfaces.InterfaceTransmethod" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML>
<HEAD>
    <LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
    <SCRIPT language="javascript" src="/js/weaver.js"></script>
	<style>
		#loading{
		    position:absolute;
		    left:45%;
		    background:#ffffff;
		    top:40%;
		    padding:8px;
		    z-index:20001;
		    height:auto;
		    border:1px solid #ccc;
		}
	</style>
</HEAD>
<body>
<%
	if (!HrmUserVarify.checkUserRight("ModeSetting:All", user)) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = SystemEnv.getHtmlLabelName(30208,user.getLanguage()) + ":" + SystemEnv.getHtmlLabelName(82,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	
	String sql = "";
	int id = Util.getIntValue(Util.null2String(request.getParameter("id")),0);
	String modeid=Util.null2String(request.getParameter("modeid"));
	String modename = "";
	String treename = Util.null2String(request.getParameter("treename"));
	String rootname = Util.null2String(request.getParameter("rootname"));
	String treedesc = Util.null2String(request.getParameter("treedesc"));
	String rooticon = Util.null2String(request.getParameter("rooticon"));
	String defaultaddress = Util.null2String(request.getParameter("defaultaddress"));
	String expandfirstnode = Util.null2String(request.getParameter("expandfirstnode"));
	
	
	
	
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javaScript:doSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javaScript:doBack(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
</colgroup>
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
<td></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
	<form name="frmSearch" method="post" action="/formmode/tree/CustomTreeOperation.jsp" enctype="multipart/form-data">
		<input type="hidden" id="operation" name="operation" value="save">
		<input type="hidden" id="id" name="id" value="<%=id%>">
		<table class="ViewForm">
			<COLGROUP>
				<COL width="15%">
				<COL width="85%">
			</COLGROUP>
			<TR>
				<TD colSpan=2><B><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></B></TD>
			</TR>
			<tr style="height:1px"><td colspan=4 class=Line1></td></tr>

			<tr>
				<td>
					<!-- �������� -->
					<%=SystemEnv.getHtmlLabelName(30209,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="treename" name="treename" type="text" value="<%=treename%>" size="30" maxlength="50" onblur="checkinput2('treename','treenamespan',1)">
					<span id="treenamespan">
						<%
							if(treename.equals("")) {
						%>
								<img align="absMiddle" src="/images/BacoError.gif"/>
						<%
							}
						%>
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���� -->
					<%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="treedesc" name="treedesc" type="text" value="<%=treedesc%>" size="30" maxlength="2000">
					<span id="treedescspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���ڵ�����-->
					<%=SystemEnv.getHtmlLabelName(30210,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="rootname" name="rootname" type="text" value="<%=rootname%>" size="30" maxlength="100" onblur="checkinput2('rootname','rootnamespan',1)">
					<span id="rootnamespan">
						<%
							if(treename.equals("")) {
						%>
								<img align="absMiddle" src="/images/BacoError.gif"/>
						<%
							}
						%>
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���ڵ�ͼ��-->
					<%=SystemEnv.getHtmlLabelName(30211,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="rooticon" name="rooticon" type="file" value="" size="30" onchange="selectImg(this)">
					<span id="rooticonspan">
						(16 * 16)
					</span>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="oldimg">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���ڵ����ӵ�ַ-->
					<%=SystemEnv.getHtmlLabelName(81440,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="defaultaddress" name="defaultaddress" type="text" value="<%=defaultaddress%>" size="60" maxlength="1000">
					<span id="defaultaddressspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- �Ƿ�Ĭ��չ��һ���ڵ�-->
					<%=SystemEnv.getHtmlLabelName(81441,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="expandfirstnode" name="expandfirstnode" type="checkbox" value="1" <%if(expandfirstnode.equals("1")){out.println("checked");} %>>
					<span id="expandfirstnodespan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>			
			
		</table>
	</form>

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
<script type="text/javascript">
    function doSubmit(){
		if(check_form(document.frmSearch,"treename,rootname")){
	        enableAllmenu();
	        document.frmSearch.submit();			
		}
    }
    function doBack(){
		enableAllmenu();
        location.href="/formmode/tree/CustomTreeList.jsp";
    }
    function doDelete(){
    	if(isdel()){
        	enableAllmenu();
        	document.frmSearch.operation.value = "del";
        	document.frmSearch.submit();
    	}
    }

    function selectImg(obj){
		if(obj.value==""){
			$("#oldimg").html("");
		}else{
			$("#oldimg").html("<img border=0 src="+obj.value+">");
		}
	}

    function onShowModeSelect(inputName, spanName){
    	var datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/formmode/browser/ModeBrowser.jsp");
    	if (datas){
    	    if(datas.id!=""){
    		    $(inputName).val(datas.id);
    			if ($(inputName).val()==datas.id){
    		    	$(spanName).html(datas.name);
    			}
    	    }else{
    		    $(inputName).val("");
    			$(spanName).html("");
    		}
    	} 
    }
	
	$(document).ready(function(){//onload�¼�
		$(".loading", window.parent.document).hide(); //���ؼ���ͼƬ
	})
</script>

</BODY>
</HTML>
