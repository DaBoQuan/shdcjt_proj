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
	String titlename = SystemEnv.getHtmlLabelName(30216,user.getLanguage()) + ":" + SystemEnv.getHtmlLabelName(82,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	
	String sql = "";
	int mainid = Util.getIntValue(Util.null2String(request.getParameter("mainid")),0);
	int id = Util.getIntValue(Util.null2String(request.getParameter("id")),0);
	String modeid=Util.null2String(request.getParameter("modeid"));
	String nodename = Util.null2String(request.getParameter("nodename"));
	String nodedesc = Util.null2String(request.getParameter("nodedesc"));
	String tablename = Util.null2String(request.getParameter("tablename"));
	String tablekey = Util.null2String(request.getParameter("tablekey"));
	
	String tablesup = Util.null2String(request.getParameter("tablesup"));
	String showfield = Util.null2String(request.getParameter("showfield"));
	String nodeicon = Util.null2String(request.getParameter("nodeicon"));
	String supnodefield = Util.null2String(request.getParameter("supnodefield"));
	String nodefield = Util.null2String(request.getParameter("nodefield"));
	int supnode = Util.getIntValue(Util.null2String(request.getParameter("supnode")),0);
	
	int hreftype = Util.getIntValue(Util.null2String(request.getParameter("hreftype")),1);
	int hrefid = Util.getIntValue(Util.null2String(request.getParameter("hrefid")),0);
	String hrefname = Util.null2String(request.getParameter("hrefname"));
	String hreftarget = Util.null2String(request.getParameter("hreftarget"));
	double showorder = Util.getDoubleValue(request.getParameter("showorder"),1);
	int sourceid = Util.getIntValue(Util.null2String(request.getParameter("sourceid")),0);
	int sourcefrom = Util.getIntValue(Util.null2String(request.getParameter("sourceid")),0);
	String hrefrelatefield = "";
	String sourcename = "";
	String iconField = Util.null2String(request.getParameter("iconField"));
	String dataorder = Util.null2String(request.getParameter("dataorder"));
	String datacondition = Util.null2String(request.getParameter("datacondition"));
	String hrefField = Util.null2String(request.getParameter("hrefField"));
	
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
	<form name="frmSearch" method="post" action="/formmode/tree/CustomTreeNodeOperation.jsp" enctype="multipart/form-data">
		<input type="hidden" id="operation" name="operation" value="add">
		<input type="hidden" id="id" name="id" value="<%=id%>">
		<input type="hidden" id="mainid" name="mainid" value="<%=mainid%>">
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
					<!-- ���� -->
					<%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="nodename" name="nodename" type="text" value="<%=nodename%>" size="30" maxlength="100" onblur="checkinput2('nodename','nodenamespan',1)">
					<span id="nodenamespan">
						<%
							if(nodename.equals("")) {
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
					<input class="inputstyle" id="nodedesc" name="nodedesc" type="text" value="<%=nodedesc%>" size="30" maxlength="2000">
					<span id="nodedescspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ������Դ -->
					<%=SystemEnv.getHtmlLabelName(28006,user.getLanguage())%>
				</td>
				<td class=Field>
					<select id="sourcefrom" name="sourcefrom" onchange="SourceFromChange()">
						<option value="1" <%if(sourcefrom==1)out.println("selected"); %>><%=SystemEnv.getHtmlLabelName(19049,user.getLanguage())%></option>
						<option value="2" <%if(sourcefrom==2)out.println("selected"); %>><%=SystemEnv.getHtmlLabelName(30176,user.getLanguage())%></option>
					</select>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr id="sourceidtr">
				<td>
					<!-- ѡ��������Դ -->
					<%=SystemEnv.getHtmlLabelName(30223,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="sourceidSelect" name="sourceidSelect" onClick="onShowSourceTarget(sourceid,sourceidspan)"></BUTTON>
					<input class="inputstyle" id="sourceid" name="sourceid" type="hidden" value="<%=sourceid%>" size="30" maxlength="2000">
					<span id="sourceidspan"><%=sourcename%>
					</span>
				</td>
			</tr>
			<tr id="sourceidlinetr" style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���� -->
					<%=SystemEnv.getHtmlLabelName(21900,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="tablename" name="tablename" type="text" value="<%=tablename%>" size="30" maxlength="50" onblur="checkinput2('tablename','tablenamespan',1)">
					<span id="tablenamespan">
						<%
							if(tablename.equals("")) {
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
					<%=SystemEnv.getHtmlLabelName(21027,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="tablekeySelect" name="tablekeySelect" onClick="onShowHrefField(tablekey,tablekeyspan,1,1)"></BUTTON>
					<input class="inputstyle" id="tablekey" name="tablekey" type="hidden" value="<%=tablekey%>" size="30" maxlength="50">
					<span id="tablekeyspan">
						<%
							if(tablekey.equals("")) {
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
					<!-- �ϼ� -->
					<%=SystemEnv.getHtmlLabelName(596,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="tablesupSelect" name="tablesupSelect" onClick="onShowHrefField(tablesup,tablesupspan,0,1)"></BUTTON>
					<input class="inputstyle" id="tablesup" name="tablesup" type="hidden" value="<%=tablesup%>" size="30" maxlength="50">
					<span id="tablesupspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ��ʾ�� -->
					<%=SystemEnv.getHtmlLabelName(606,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="showfieldSelect" name="showfieldSelect" onClick="onShowHrefField(showfield,showfieldspan,1,1)"></BUTTON>
					<input class="inputstyle" id="showfield" name="showfield" type="hidden" value="<%=showfield%>" size="30" maxlength="50">
					<span id="showfieldspan">
						<%
							if(showfield.equals("")) {
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
					<!-- ����Ŀ����Դ-->
					<%=SystemEnv.getHtmlLabelName(30174,user.getLanguage())%>
				</td>
				<td class=Field>
					<select id="hreftype" name="hreftype" onchange="onHrefTypeChange(this)">
						<option value="1" <%if(hreftype==1) out.println("selected");%>><%=SystemEnv.getHtmlLabelName(19049,user.getLanguage())%></option><!-- ģ��-->
						<option value="3" <%if(hreftype==3) out.println("selected");%>><%=SystemEnv.getHtmlLabelName(30175,user.getLanguage())%></option><!-- ģ���ѯ�б�-->
						<option value="2" <%if(hreftype==2) out.println("selected");%>><%=SystemEnv.getHtmlLabelName(30176,user.getLanguage())%></option><!-- �ֶ�����-->
					</select>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
	
			<tr id="hrefidtr">
				<td>
					<!-- ѡ������Ŀ��-->
					<%=SystemEnv.getHtmlLabelName(30177,user.getLanguage())%>
				</td>
				<td class=Field>
			  		 <button type="button" class="Browser" id="hrefidSelect" name="hrefidSelect" onClick="onShowHrefTarget(hrefid,hrefidspan)"></BUTTON>
			  		 <input type="hidden" name="hrefid" id="hrefid" value="<%=hrefid%>">
			  		 <span id="hrefidspan"><%=hrefname%></span>
				</td>
			</tr>
			<tr id="hrefidlinetr" style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ����Ŀ���ַ-->
					<%=SystemEnv.getHtmlLabelName(30178,user.getLanguage())%>
					<br/>
					<%=SystemEnv.getHtmlLabelName(81450,user.getLanguage())%>
				</td>
				<td class=Field>
					<textarea id="hreftarget" name="hreftarget" class="inputstyle" rows="4" style="width:70%" onblur="checkinput2('hreftarget','hreftargetspan',1)"><%=hreftarget%></textarea>
					<span id="hreftargetspan">
						<%
							if(hreftarget.equals("")){
						%>
								<img align="absMiddle" src="/images/BacoError.gif"/>
						<%
							}
						%>
					</span>
					<br>
					<!-- �������Ŀ���ַ�����ֶ������ַ�����������޸�����ֵ�ַ-->
					<%=SystemEnv.getHtmlLabelName(30179,user.getLanguage())%>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr id="hrefrelatefieldtr">
				<td>
					<!-- ����Ŀ������ֶ�-->
					<%=SystemEnv.getHtmlLabelName(30222,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="hrefrelatefieldSelect" name="hrefrelatefieldSelect" onClick="onShowRelateField(hrefrelatefield,hrefrelatefieldspan)"></BUTTON>
					<input class="inputstyle" id="hrefrelatefield" name="hrefrelatefield" type="hidden" value="<%=hrefrelatefield%>" size="30">
					<span id="hrefrelatefieldspan"></span>
				</td>
			</tr>
			<tr id="hrefrelatefieldlinetr" style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ����Ŀ���ַ�ֶ�  -->
					<%=SystemEnv.getHtmlLabelName(81451,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="hrefFieldSelect" name="hrefFieldSelect" onClick="onShowHrefField(hrefField,hrefFieldspan,0,4)"></BUTTON>
					<input class="inputstyle" id="hrefField" name="hrefField" type="hidden" value="<%=hrefField%>" size="30" maxlength="50">
					<span id="hrefFieldspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ͼ��-->
					<%=SystemEnv.getHtmlLabelName(81442,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" id="oldnodeicon" name="oldnodeicon" type="hidden" value="<%=nodeicon%>">
					<input class="inputstyle" id="nodeicon" name="nodeicon" type="file" value="<%=nodeicon%>" size="30" onchange="selectImg(this)">
					(16 * 16)
					<span id="oldimg">
						<%
							if(!nodeicon.equals("")&&!nodeicon.equals("0")) {
						%>
								<img src="/weaver/weaver.file.FileDownload?fileid=<%=nodeicon%>">
						<%
							}
						%>
					</span>
					&nbsp;
					<span id="delspan">
						<a href="javascript:void(0)" onclick="javascript:delNodeIcon()"><%=SystemEnv.getHtmlLabelName(30227,user.getLanguage())%></a>
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- �ڵ�ͼ���ֶ�  -->
					<%=SystemEnv.getHtmlLabelName(81443,user.getLanguage())%>
				</td>
				<td class=Field>
					<button type="button" class="Browser" id="iconFieldSelect" name="iconFieldSelect" onClick="onShowHrefField(iconField,iconFieldspan,0,5)"></BUTTON>
					<input class="inputstyle" id="iconField" name="iconField" type="hidden" value="<%=iconField%>" size="30" maxlength="50">
					<span id="iconFieldspan">
					</span>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ������ʾ˳��  -->
					<%=SystemEnv.getHtmlLabelName(81444,user.getLanguage())%>
				</td>
				<td class=Field>
					<textarea id="dataorder" name="dataorder" class="inputstyle" maxlength="1000" rows="4" style="width:70%"><%=dataorder%></textarea>
					<span id="dataorderspan">
					</span>
					<br/>
					<%=SystemEnv.getHtmlLabelName(81446,user.getLanguage())%>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ������ʾ����  -->
					<%=SystemEnv.getHtmlLabelName(81445,user.getLanguage())%>
				</td>
				<td class=Field>
					<textarea id="datacondition" name="datacondition" class="inputstyle" maxlength="4000" rows="4" style="width:70%"><%=datacondition%></textarea>
					<span id="dataconditionspan">
					</span>
					<br/>
					<%=SystemEnv.getHtmlLabelName(81447,user.getLanguage())%>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- �ϼ��ڵ� -->
					<%=SystemEnv.getHtmlLabelName(30217,user.getLanguage())%>
				</td>
				<td class=Field>
					<select id="supnode" name="supnode">
						<option value="0">&nbsp;&nbsp;&nbsp;&nbsp;</option>
						<%
							sql = "select * from mode_customtreedetail where mainid = " + mainid + " and id <> " + id;
							rs.executeSql(sql);
							while(rs.next()){
								int tempid = rs.getInt("id");
								String tempnodename = rs.getString("nodename");
						%>
								<option value="<%=tempid%>" <%if(supnode==tempid)out.println("selected"); %>><%=tempnodename%></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			
			<tr>
				<td>
					<!-- ���¼��ڵ�����ֶ� -->
					<%=SystemEnv.getHtmlLabelName(30218,user.getLanguage())%>
				</td>
				<td class=Field>
					<table>
						<tr>
							<!-- ���ڵ��ֶ� -->
							<td><%=SystemEnv.getHtmlLabelName(30219,user.getLanguage())%></td>
							<td>
								<button type="button" class="Browser" id="nodefieldSelect" name="nodefieldSelect" onClick="onShowHrefField(nodefield,nodefieldspan,0,1)"></BUTTON>
								<input class="inputstyle" id="nodefield" name="nodefield" type="hidden" value="<%=nodefield%>" size="30" maxlength="2000">
								<span id="nodefieldspan">
								</span>
							</td>
						</tr>
						<tr>
							<!-- �ϼ��ڵ��ֶ� -->
							<td><%=SystemEnv.getHtmlLabelName(30220,user.getLanguage())%></td>
							<td>
								<button type="button" class="Browser" id="nodefieldSelect" name="nodefieldSelect" onClick="onShowSupField(supnodefield,supnodefieldspan)"></BUTTON>
								<input class="inputstyle" id="supnodefield" name="supnodefield" type="hidden" value="<%=supnodefield%>" size="30" maxlength="2000">
								<span id="supnodefieldspan">
								</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr style="height:1px"><td colspan=4 class=Line></td></tr>
			<tr>
				<td>
					<!-- ��ʾ˳��-->
					<%=SystemEnv.getHtmlLabelName(15513,user.getLanguage())%>
				</td>
				<td class=Field>
					<input class="inputstyle" type="text" name="showorder" id="showorder" value="<%=showorder%>" size="5" onkeypress="ItemDecimal_KeyPress('showorder',15,2)" onblur="checknumber1(this);">
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
	if(check_form(document.frmSearch,"nodename,tablename,tablekey,showfield,hreftarget")){
        enableAllmenu();
        document.frmSearch.submit();			
	}
}
function doBack(){
	enableAllmenu();
    location.href="/formmode/tree/CustomTreeView.jsp?id=<%=mainid%>";
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

function delNodeIcon(){
	$("#oldimg").html("");
	$("#oldnodeicon").val("");    	
	var objFile = document.getElementById('nodeicon');
	objFile.outerHTML=objFile.outerHTML.replace(/(value=\").+\"/i,"$1\"");
}

function onShowSourceTarget(inputName, spanName){
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
	getSourceTableName();
}

function onShowHrefField(inputName, spanName,ismand,from){
    var url = "";
	var sourcefrom = jQuery("select[name=sourcefrom]").val();
	var sourceid = jQuery("input[name=sourceid]").val();
	var tablename = jQuery("input[name=tablename]").val();
	url = "/formmode/tree/ModeFieldBrowser.jsp?sourcefrom="+sourcefrom+"&sourceid="+sourceid+"&tablename="+tablename+"&&from="+from;
	url = "/systeminfo/BrowserMain.jsp?url="+escape(url);
	var datas = window.showModalDialog(url);
	if (datas){
	    if(datas.id!=""){
		    $(inputName).val(datas.id);
		    	$(spanName).html(datas.name);
	    }else{
		    $(inputName).val("");
		    if(ismand=="1"){
				$(spanName).html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
		    }else{
		    	$(spanName).html("");
			}
		}
	} 
}

function onShowRelateField(inputName, spanName){
    var url = "";
	var hreftype = jQuery("select[name=hreftype]").val();
	var hrefid = jQuery("input[name=hrefid]").val();
	if(hreftype=="1"){//ģ��
		url = "/formmode/tree/ModeFieldBrowser.jsp?hreftype="+hreftype+"&hrefid="+hrefid+"&from=2";
		url = "/systeminfo/BrowserMain.jsp?url="+escape(url);
	}else if(hreftype=="3"){//ģ���ѯ�б�
		url = "/formmode/tree/ModeFieldBrowser.jsp?hreftype="+hreftype+"&hrefid="+hrefid+"&from=2";
		url = "/systeminfo/BrowserMain.jsp?url="+escape(url);
	}
	var datas = window.showModalDialog(url);
	if (datas){
	    if(datas.id!=""){
		    $(inputName).val(datas.id);
		    	$(spanName).html(datas.name);
	    }else{
		    $(inputName).val("");
			$(spanName).html("");
		}
	} 
}

function onShowSupField(inputName, spanName){
    var url = "";
	var supnode = jQuery("select[name=supnode]").val();
	url = "/formmode/tree/ModeFieldBrowser.jsp?supnode="+supnode+"&from=3";
	url = "/systeminfo/BrowserMain.jsp?url="+escape(url);
	var datas = window.showModalDialog(url);
	if (datas){
	    if(datas.id!=""){
		    $(inputName).val(datas.id);
		    	$(spanName).html(datas.name);
	    }else{
		    $(inputName).val("");
			$(spanName).html("");
		}
	} 
}

function getSourceTableName(){
	var sourcefrom = jQuery("select[name=sourcefrom]").val();
	var sourceid = jQuery("input[name=sourceid]").val();
	if(sourcefrom!=""&&sourceid!=""){
		var url = "/formmode/tree/CustomTreeNodeAjax.jsp?sourcefrom="+sourcefrom+"&sourceid="+sourceid;
		jQuery.ajax({
			url : url,
			type : "post",
			processData : false,
			data : "",
			dataType : "text",
			async : true,
			success: function do4Success(msg){
				var tablename = jQuery.trim(msg);
				jQuery("#tablename").val(tablename);
				if(tablename==""){
					jQuery("#tablenamespan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
				}else{
					jQuery("#tablenamespan").html("");
				}
			}
		});
	}else{
		jQuery("#tablename").val("");
		jQuery("#tablenamespan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	}
}

function onShowHrefTarget(inputName, spanName){
    var url = "/systeminfo/BrowserMain.jsp?url=/formmode/browser/ModeBrowser.jsp";
	var hreftype = jQuery("select[name=hreftype]").val();
	var hrefid = jQuery("input[name=hrefid]").val();
	if(hreftype=="1"){//ģ��
		url = "/systeminfo/BrowserMain.jsp?url=/formmode/browser/ModeBrowser.jsp";
	}else if(hreftype=="3"){//ģ���ѯ�б�
		url = "/systeminfo/BrowserMain.jsp?url=/formmode/search/CustomSearchBrowser.jsp";
	} 
	var datas = window.showModalDialog(url);
	if (datas){
	    if(datas.id!=""){
		    $(inputName).val(datas.id);
		    	$(spanName).html(datas.name);
	    }else{
		    $(inputName).val("");
			$(spanName).html("");
		}
	    getHrefTarget();
	} 
}

function getHrefTarget(){
	var hreftype = jQuery("select[name=hreftype]").val();
	var hrefid = jQuery("input[name=hrefid]").val();
	if(hreftype!=""&&hrefid!=""){
		var url = "/formmode/tree/CustomTreeUrlAjax.jsp?hrefid="+hrefid+"&hreftype="+hreftype;
		jQuery.ajax({
			url : url,
			type : "post",
			processData : false,
			data : "",
			dataType : "text",
			async : true,
			success: function do4Success(msg){
				var returnurl = jQuery.trim(msg);
				jQuery("#hreftarget").val(returnurl);
				if(returnurl==""){
					jQuery("#hreftargetspan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
				}else{
					jQuery("#hreftargetspan").html("");
				}
			}
		});
	}else{
		jQuery("#hreftarget").val("");
		jQuery("#hreftargetspan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	}
}

function onShowTypeChange(){
	var showtype = jQuery("#showtype").val();
	var hreftype = jQuery("#hreftype").val();
	if(showtype=="1"){
		jQuery("#opentype").hide();
		jQuery("#opentypetr").hide();
		jQuery("#opentypelinetr").hide();
		jQuery("#relatedfieldtr").show();
		jQuery("#relatedfieldtrline").show();
	}else if(showtype=="2"){
		jQuery("#opentype").show();
		jQuery("#opentypetr").show();
		jQuery("#opentypelinetr").show();
		if(hreftype=="2"){
			jQuery("#relatedfieldtr").hide();
			jQuery("#relatedfieldtrline").hide();
		}
	}
}

function onHrefTypeChange(){
	var hreftype = jQuery("#hreftype").val();
	if(hreftype=="1"){
		jQuery("#hrefidtr").show();
		jQuery("#hrefidlinetr").show();
		jQuery("#hrefrelatefieldtr").show();
		jQuery("#hrefrelatefieldlinetr").show();
	}else if(hreftype=="2"){
		jQuery("#hrefidtr").hide();
		jQuery("#hrefidlinetr").hide();
		jQuery("#hrefid").val("");
		jQuery("#hrefidspan").html("");
		jQuery("#hrefrelatefield").val("");
		jQuery("#hrefrelatefieldtr").hide();
		jQuery("#hrefrelatefieldlinetr").hide();
	}else if(hreftype=="3"){
		jQuery("#hrefidtr").show();
		jQuery("#hrefidlinetr").show();
		jQuery("#hrefrelatefieldtr").show();
		jQuery("#hrefrelatefieldlinetr").show();
	}
	jQuery("#hrefid").val("");
	jQuery("#hrefidspan").html("");
	jQuery("#hreftarget").val("");
	jQuery("#hreftargetspan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
}

function SourceFromChange(){
	jQuery("#sourceid").val("");
	jQuery("#tablename").val("");
	jQuery("#sourceidspan").html("");
	jQuery("#tablenamespan").html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	var sourcefrom = jQuery("select[name=sourcefrom]").val();
	if(sourcefrom==1){
		jQuery("#sourceidtr").show();
		jQuery("#sourceidlinetr").show();
	}else{
		jQuery("#sourceidtr").hide();
		jQuery("#sourceidlinetr").hide();
	}
}

function initload(){
	var sourcefrom = jQuery("select[name=sourcefrom]").val();
	if(sourcefrom==2){
		jQuery("#sourceidtr").hide();
		jQuery("#sourceidlinetr").hide();
	}

	var hreftype = jQuery("select[name=hreftype]").val();
	if(hreftype==2){
		jQuery("#hrefidtr").hide();
		jQuery("#hrefidlinetr").hide();
		jQuery("#hrefrelatefieldtr").hide();
		jQuery("#hrefrelatefieldlinetr").hide();
	}		
}
	
	$(document).ready(function(){//onload�¼�
		$(".loading", window.parent.document).hide(); //���ؼ���ͼƬ
	})
</script>

</BODY>
</HTML>
