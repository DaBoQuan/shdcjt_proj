<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String outrepcategory = "" + Util.getIntValue(request.getParameter("outrepcategory"),0);

String imagefilename = "/images/hdHRMCard.gif";
String titlename = SystemEnv.getHtmlLabelName(15514,user.getLanguage()) ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM id=weaver name=frmMain action="OutReportOperation.jsp" method=post >
<input type="hidden" name=operation value=add>
<input type="hidden" name=outrepcategory value="<%=outrepcategory%>">

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



<TABLE class=viewform>
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">
  <TBODY>
  <TR class=title>
      <TH colSpan=2><%=SystemEnv.getHtmlLabelName(15514,user.getLanguage())%></TH>
    </TR>
  <TR class=spacing  style="height:1px;">
    <TD class=line1 colSpan=2 ></TD></TR>
  <TR>
          <TD>����</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="outrepname" onchange='checkinput("outrepname","outrepnameimage")'>
          <SPAN id=outrepnameimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
        </TR>  
        <TR class=spacing style="height:1px;">
    <TD class=line colSpan=2 ></TD></TR>
    <TR>
          <TD>Ӣ������</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="outrepenname">
          </TD>
        </TR>  
        <TR class=spacing  style="height:1px;">
    <TD class=line colSpan=2 ></TD></TR>
    <% if(outrepcategory.equals("0")||outrepcategory.equals("2")) { // ֻ��Ϊ�̶�����������򱨱�ʱ����ʾ %>
    <TR>
      <TD>����</TD>
      <TD class=Field><INPUT type=text class=inputstyle size=50 name="outreprow" onchange='checkinput("outreprow","outreprowimage")' onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)' <% if(outrepcategory.equals("2")) { %>value="1"<%}%>>
      <SPAN id=outreprowimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
    </TR>
    <TR class=spacing style="height:1px;"><TD class=line colSpan=2 ></TD></TR>
    <TR>
      <TD>����</TD>
      <TD class=Field><INPUT type=text class=inputstyle size=50 name="outrepcolumn" onchange='checkinput("outrepcolumn","outrepcolumnimage")' onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
      <SPAN id=outrepcolumnimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
    </TR> 
    <TR class=spacing style="height:1px;"><TD class=line colSpan=2 ></TD></TR>
    <% } %>
    <TR>
          <TD>���ı���ģ���ļ�</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="modulefilename" ></TD>
    </TR> 
    <TR class=spacing style="height:1px;"><TD class=line colSpan=2></TD></TR>
    <TR>
          <TD>Ӣ�ı���ģ���ļ�</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="enmodulefilename" ></TD>
    </TR> 
    <!-- ���� 2004 ��10��23 ������ģ���ļ�����Ӧ�иߺ��п�-->
    <TR class=spacing style="height:1px;"><TD class=line colSpan=2></TD></TR>
    <TR>
          <TD>����ģ������Ӧ</TD>
          <TD class=Field>
            �п�<INPUT type=checkbox class=inputstyle name="autocolumn" value='1'>
            �иߣ�<INPUT type=checkbox class=inputstyle name="autorow" value='1'>
          </TD>
    </TR> 
    <TR class=spacing style="height:1px;"><TD class=line colSpan=2 ></TD></TR>
    <TR> 
      <TD>��������</TD>
      <TD class=Field >
        <select class="InputStyle"  name="outreptype" style="width:50%">
          <option value="0">��̬</option>
		  <option value="1">�걨</option>
		  <option value="2">�±�</option>
		  <option value="3">Ѯ��</option>
		  <option value="4">�ܱ�</option>
		  <option value="5">�ձ�</option>
        </select>
      </TD>
    </TR>
    <TR class=spacing style="height:1px;">
    <TD class=line colSpan=2 ></TD></TR>
        <TR>
          <TD>��������</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="outrepdesc"></TD>
        </TR> 
     <TR class=spacing style="height:1px;"><TD class=line colSpan=2 ></TD></TR>
     <TR>
          <TD>Ӣ������</TD>
          <TD class=Field><INPUT type=text class=inputstyle size=50 name="outrependesc"></TD>
        </TR> <TR class=spacing  style="height:1px;">
    <TD class=line1 colSpan=2 style="height:1px;"></TD></TR>
 </TBODY></TABLE>
 
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

<script language="javascript">

function submitData()
{
<% if(outrepcategory.equals("0")||outrepcategory.equals("2")) { %>
	if (check_form(frmMain,'outrepname,outreprow,outrepcolumn')) {
		if(toInt(document.frmMain.outreprow.value,0)>0 &&  toInt(document.frmMain.outrepcolumn.value,0)>0 ) {
		    frmMain.submit();
		}
		else {
			alert("���б������0��");
		}
	}
<%}else{%>
if (check_form(frmMain,'outrepname')) {		
	frmMain.submit();		
}
<%}%>
}

function toInt(str , def) {
	if(isNaN(parseInt(str))) return def ;
	else return parseInt(str) ;
}

</script>
</BODY></HTML>
