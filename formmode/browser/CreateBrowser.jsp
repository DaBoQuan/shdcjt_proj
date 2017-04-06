<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
if (!HrmUserVarify.checkUserRight("ModeSetting:All", user)) {
	response.sendRedirect("/notice/noright.jsp");
	return;
}

String imagefilename = "/images/hdHRMCard.gif";
String titlename = SystemEnv.getHtmlLabelName(28625,user.getLanguage());
String needfav ="1";
String needhelp ="";
String customid = Util.null2String(request.getParameter("customid"));
String browserid = Util.null2String(request.getParameter("browserid"));
String type = Util.null2String(request.getParameter("type"));
String flag = Util.null2String(request.getParameter("flag"));
String sql = "";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:doback(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM id=weaver name=frmMain action="/formmode/browser/CreateBrowserOperation.jsp" method=post onsubmit="javascript:return submitData();">

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
			<input id="customid" name="customid" type="hidden" value="<%=customid%>">
			<TABLE class="viewform">
				<COLGROUP>
					<COL width="20%">
					<COL width="80%">
				</COLGROUP>
				<TBODY>
					<%
						String msg = "";
						if(flag.equals("1")){
							//msg = "";
							msg = SystemEnv.getHtmlLabelName(28629,user.getLanguage());
						}else if(flag.equals("2")){
							msg = SystemEnv.getHtmlLabelName(19327,user.getLanguage());
						}
						if(!msg.equals("")){
							out.println("<font color=red>"+msg+"</font>");
						}
					%>
			    	<TR class="Spacing" style="height: 1px">
						<TD class="Line" colSpan=2 ></TD>
					</TR>
					<TR>
		      			<TD><%=SystemEnv.getHtmlLabelName(84,user.getLanguage())%></TD>
		          		<TD class=Field>
		        			<INPUT type=text class=Inputstyle size=30 maxlength="40" name="browserid" onchange='checkinput("browserid","browseridimage")' onBlur="checkBrowserId('browserid','browseridimage')" value="<%=browserid%>">
		          			<SPAN id=browseridimage><%if(browserid.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN>
		          		</TD>
		        	</TR>
		        	<TR style="height: 1px">
		    			<TD class="Line" colSpan=2 ></TD>
		    		</TR>
					<TR>
			      		<TD><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></TD>
						<td class="Field">
							<select id="type" name="type">
								<option value="1" <%if(type.equals("1")){out.println("selected");}%>><%=SystemEnv.getHtmlLabelName(28626,user.getLanguage())%></option>
								<option value="2" <%if(type.equals("2")){out.println("selected");}%>><%=SystemEnv.getHtmlLabelName(28627,user.getLanguage())%></option>
							</select>
						</td>
			        </TR>
			        <TR class="Spacing" style="height: 1px">
			    		<TD class="Line" colSpan=2 ></TD>
			    	</TR>
					<TR>
					    <TD colspan="2">
					        <br>
					        	<b><%=SystemEnv.getHtmlLabelName(85, user.getLanguage())%>��</b>
					        <br>
					        1����ʶֻ��Ϊ���֡���ĸ���»��ߣ���󳤶�Ϊ40���ַ���<br>
					        2����ʶΪ�Զ��������ť��ID��<br>
					    </TD>
					</TR>
			 	</TBODY>
			</TABLE>
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

 </form>

<SCRIPT LANGUAGE="javascript">


function submitData()
{
	var checkfields = "browserid";
	checkBrowserId('browserid','browseridimage');
	if (check_form(frmMain,checkfields)){
        enableAllmenu();
        frmMain.submit();
    }else{
        return false;
	}
}

//���browseridֻ��ΪӢ��+����+"_"
function checkBrowserId(inputname,inputspan){
	var inputvalue = $GetEle(inputname).value; 
	var length = inputvalue.length;
	var valuechar = inputvalue.split("");
	//alert(inputvalue +"	"+length);
	var islegal = true;
	for(var i=0;i<length;i++){
		//�ж��Ƿ�Ϊ���ֺ��»���
		var letter = valuechar[i];
		var charnumber = parseInt(letter);
		if( isNaN(charnumber) && (valuechar[i]!="_")){
			//�ж��Ƿ�Ϊ��ĸ
			var str = /[_a-zA-Z]/; 
        	if(!str.test(letter)) {         
        		islegal = false; 
			}
		}
	}
	if(!islegal){
		$GetEle(inputname).value = "";
		$GetEle(inputspan).innerHTML = "<IMG src=\"/images/BacoError.gif\" align=\"absMiddle\">";
	}
}

function doback(){
	window.parent.close();
    window.close();
}

</SCRIPT>

</BODY></HTML>
