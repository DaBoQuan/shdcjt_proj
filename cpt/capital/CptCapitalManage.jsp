<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
if(!HrmUserVarify.checkUserRight("CptCapitalAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
String urltarget=Util.null2String(request.getParameter("urltarget"));
if( urltarget.equals("")) urltarget = "/cpt/capital/CptCapitalUse.jsp" ;
String imagefilename = "/images/hdHRMCard.gif";
String titlename = SystemEnv.getHtmlLabelName(6050,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%//@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
/*RCMenu += "{"+SystemEnv.getHtmlLabelName(886,user.getLanguage())+",javascript:doSubmit(1),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(883,user.getLanguage())+",javascript:doSubmit(2),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(6051,user.getLanguage())+",javascript:doSubmit(4),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(6054,user.getLanguage())+",javascript:doSubmit(5),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(6052,user.getLanguage())+",javascript:doSubmit(6),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(6053,user.getLanguage())+",javascript:doSubmit(7),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(6055,user.getLanguage())+",javascript:doSubmit(8),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15305,user.getLanguage())+",javascript:doSubmit(9),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15306,user.getLanguage())+",javascript:doSubmit(12),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15307,user.getLanguage())+",javascript:doSubmit(11),CptManageIframe} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:back(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;*/
%>
<%//@ include file="/systeminfo/RightClickMenu.jsp" %>
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

			<FORM name=frmain id=frmain method=post action="/cpt/capital/CptCapitalManage.jsp">
			<input type="hidden" name="urltarget">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<iframe NAME=CptManageIframe BORDER=0 FRAMEBORDER=no NORESIZE=NORESIZE height=100% width=100% SCROLLING=AUTO SRC="<%=urltarget%>"></iframe>
					</td>
				</tr>
			</table>
			</FORM>

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

<script language=javascript>
function doSubmit(getValue)
{
  if (getValue=="1") document.frmain.urltarget.value="/cpt/capital/CptCapitalUse.jsp";//�ʲ�����
  if (getValue=="2") document.frmain.urltarget.value="/cpt/capital/CptCapitalMove.jsp";//�ʲ�����
  if (getValue=="3") document.frmain.urltarget.value="/workflow/request/RequestType.jsp";//�ʲ��깺
  if (getValue=="4") document.frmain.urltarget.value="/cpt/capital/CptCapitalLend.jsp";//�ʲ�����
  if (getValue=="5") document.frmain.urltarget.value="/cpt/capital/CptCapitalLoss.jsp";//�ʲ�����
  if (getValue=="6") document.frmain.urltarget.value="/cpt/capital/CptCapitalDiscard.jsp";//�ʲ�����
  if (getValue=="7") document.frmain.urltarget.value="/cpt/capital/CptCapitalMend.jsp";//�ʲ�ά��
  if (getValue=="8") document.frmain.urltarget.value="/cpt/capital/CptCapitalModifyOperation.jsp?isdata=2";//�ʲ����
  if (getValue=="9") document.frmain.urltarget.value="/cpt/capital/CptCapitalBack.jsp";//�ʲ��˻�
  if (getValue=="10") document.frmain.urltarget.value="/cpt/report/CptRpCapitalCheckStock.jsp";//�ʲ��̵�
  if (getValue=="11") document.frmain.urltarget.value="/cpt/search/CptInstockSearch.jsp";//�ʲ�����
  if (getValue=="12") document.frmain.urltarget.value="/cpt/capital/CptCapitalInstock1.jsp";//�ʲ����
  document.frmain.submit();
}
</script>
<script language="javascript">
function back()
{
	window.history.back(-1);
}
</script>
</BODY>
</HTML>
