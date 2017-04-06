<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.docs.category.security.AclManager " %>
<%@ page import="weaver.docs.category.* " %>
<%@ page import="java.util.*"%>

<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<jsp:useBean id="SignatureManager" class="weaver.docs.docs.SignatureManager" scope="page" />
<%
if(!HrmUserVarify.checkUserRight("SignatureAdd:Add", user)){
    response.sendRedirect("/notice/noright.jsp");
}
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "<b>"+SystemEnv.getHtmlLabelName(16627,user.getLanguage())+"</b>";
String needfav = "1";
String needhelp = "1";

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script LANGUAGE="JavaScript" SRC="/js/checkinput.js"></script>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<SCRIPT language="javascript">
function showHeader(){
	if(oDiv.style.display=='')
		oDiv.style.display='none';
	else
		oDiv.style.display='';
}


function onshowdocmain(vartmp){
	if(vartmp==1)
		otrtmp.style.display='';
	else
		otrtmp.style.display='none';
}

function onSave(){
    if(check_form(document.weaver,"markName,hrmresid")){
        weaver.opera.value="add";
        weaver.submit();
    }
}
function onShowResource(inputname,spanname){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			_displayTemplate:"#b{name}",
			_displaySelector:"",
			_required:"no",
			_displayText:"",
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //��ô��ڵ�ˮƽλ��;
	opts.top=iTop;
	opts.left=iLeft;
	 linkurl="javaScript:openhrm(";
   datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp","","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
  if (datas) {
		    if (datas.id!= "") {
		        ids = datas.id.split(",");
			    names =datas.name.split(",");
			    sHtml = "";
			    for( var i=0;i<ids.length;i++){
				    if(ids[i]!=""){
				    	sHtml = sHtml+"<a href="+linkurl+ids[i]+")  onclick='pointerXY(event);'>"+names[i]+"</a>&nbsp";
				    }
			    }
			    $("#"+spanname).html(sHtml);
			    $("input[name="+inputname+"]").val(datas.id);
		    }
		    else	{
	    	     $("#"+spanname).html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			    $("input[name="+inputname+"]").val("");
		    }
		}
}
</script>
</head>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

//modiby dongping for td1228 start
//ǩ�������У�����Ƚ���������Ȼ���ٵ���½�ǩ�£���ѡ�񷵻صĻ�����������ҳ���ڴ���ҳ�档
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:location='/docs/docs/SignatureList.jsp',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
//end
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
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">


<FORM id=weaver name=weaver method=post enctype="multipart/form-data" action="UploadSignature.jsp">
<INPUT TYPE="hidden" name = "opera">
<INPUT TYPE="hidden" name = "markId" value="">
<INPUT TYPE="hidden" name = "hrmresid" id="hrmresid" value="" onChange='checkinput("hrmresid","hrmresspan")'>


<table class=ViewForm>
  <colgroup>
  <col width="20%">
  <col width="80%">
  <tbody>
<TR style="height: 1px!important;"><TD class=Line1 colSpan=2></TD></TR>
    <tr>
    <td><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></td>
    <td class=field><button type="button" class=Browser type="button" onClick="onShowResource('hrmresid','hrmresspan')" ></button><span id=hrmresspan style="padding-top:5px"><IMG src='/images/BacoError.gif' align=absMiddle></span></td>
    </tr>
<TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
    <tr>
    <td><%=SystemEnv.getHtmlLabelName(18694,user.getLanguage())%></td>
    <td class=field><INPUT TYPE="text" class=InputStyle NAME="markName" value="" onChange='checkinput("markName","markNamespan")'><span id=markNamespan><IMG src='/images/BacoError.gif' align=absMiddle></span></td>
    </tr>
<TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
    <tr>
    <td><%=SystemEnv.getHtmlLabelName(18695,user.getLanguage())%></td>
    <td class=field><INPUT TYPE="file" NAME="markPic"  class=InputStyle  onChange="markImg.src=weaver.markPic.value;markImg.style.display=''"><%=SystemEnv.getHtmlLabelName(23258,user.getLanguage()) %></td>
    </tr>
<TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
    <tr height=20>
    <td></td>
    <td class=field><img id=markImg src=""  style="display:none"></img></td>
    </tr>
<TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>

  </tbody>
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

</body>