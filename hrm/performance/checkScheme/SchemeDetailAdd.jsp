<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsd" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rss" class="weaver.conn.RecordSet" scope="page" />
<% if(!HrmUserVarify.checkUserRight("CheckScheme:Performance",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</HEAD>
<%
String contentId=Util.null2String(request.getParameter("id"));
String type=Util.null2String(request.getParameter("type"));
String cycle=Util.null2String(request.getParameter("cycle"));
String mainid=Util.null2String(request.getParameter("mainid"));
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+": "+ SystemEnv.getHtmlLabelName(18064,user.getLanguage());
String titlenamet="";
if (type.equals("0")) {
titlenamet="-"+SystemEnv.getHtmlLabelName(18060,user.getLanguage());
}
if (type.equals("1")) {
titlenamet="-"+SystemEnv.getHtmlLabelName(18061,user.getLanguage());
}
if (type.equals("2")) {
titlenamet="-"+SystemEnv.getHtmlLabelName(18062,user.getLanguage());
}
titlename+=titlenamet;
String needfav ="1";
String needhelp ="";
//�����ж��Զ��忼�����ָ���Ͳ�����100%,(Ŀ�꿼�˷��¶ȿ���ҲҪ�ж�)
if (rss.getDBType().equals("oracle"))
rss.execute("select sum(percent_n) from HrmPerformanceSchemeDetail where contentId="+contentId);
else if (rss.getDBType().equals("db2"))
rss.execute("select sum(double(percent_n)) from HrmPerformanceSchemeDetail where contentId="+contentId);
else
rss.execute("select sum(convert(float,percent_n)) from HrmPerformanceSchemeDetail where contentId="+contentId);
float sum=0;


if (rss.next())
{
  sum=Util.getFloatValue(rss.getString(1));
}
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:OnSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",CheckSchemeEdit.jsp?id="+mainid+"&cycle="+cycle+",_self} " ;
RCMenuHeight += RCMenuHeightStep ;

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

<FORM name=resource id=resource action="CheckSchemeOperation.jsp" method=post>
<input type=hidden name=inserttype value=detail>
<input type=hidden name=contentId value=<%=contentId%>>
<input type=hidden name=mainid value=<%=mainid%>>
<input type=hidden name=type value=<%=type%>>
<input type=hidden name=cycle value=<%=cycle%>>
<input type=hidden name=sum value=<%=sum%>>
   <TABLE class=ViewForm>
    <COLGROUP> 
    <COL width="15%"> 
    <COL width="85%"> 
    <TBODY> 
  
    <TR> 
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=15%> <COL width=85%> <TBODY> 
          <TR class=title> 
            <TH colSpan=2 ><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
          </TR>
          <TR class=spacing> 
            <TD class=line1 colSpan=2></TD>
          </TR>
           <%if (type.equals("0")) {%>
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(18064 ,user.getLanguage())%></TD>
            <TD class=Field>
             <select class=inputstyle name="item" id="item">
             <%if (!cycle.equals("3")) {%><option value="0" selected><%=SystemEnv.getHtmlLabelName(18170 ,user.getLanguage())%></option>
             <%}%>
             <%if (!cycle.equals("2")) {%><option value="1" ><%=SystemEnv.getHtmlLabelName(18137 ,user.getLanguage())%></option>
             <%}%>
             </select>
            </TD>
          </TR>
           <%}%>
             <%if (type.equals("1")) {%>
              <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(18048 ,user.getLanguage())%></TD>
            <TD class=Field> 
           <BUTTON class=Browser id=SelectCheckID onClick="onShowCheck()"></BUTTON> 
              <span 
            id=checkidspan><img src="/images/BacoError.gif" 
            align=absMiddle></span> 
              <INPUT class=inputStyle id=checkItem 
            type=hidden name=checkItem>
            </TD>
          </TR>
             <%}%>
             <%if (type.equals("2")) {%>
               <!-- TR> 
            <TD><%=SystemEnv.getHtmlLabelName(18062 ,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(857 ,user.getLanguage())%></TD>
            <TD class=Field> 
            <BUTTON class=Browser id=SelectDocID onClick="onShowDoc()"></BUTTON> 
              <span 
            id=docidspan><img src="/images/BacoError.gif" 
            align=absMiddle></span> 
              <INPUT class=inputStyle id=docItem 
            type=hidden name=docItem>
            </TD>
          </TR-->
             <%}%>
        <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(6071 ,user.getLanguage())%></TD>
            <TD class=Field> 
              <input class=inputstyle  maxLength=4 size=4 
            name="percent_n"  onchange='checknumber("percent_n");checkinput("percent_n","nameimage")' >%
            <SPAN id=nameimage>
			<IMG src='/images/BacoError.gif' align=absMiddle>
			</SPAN> 
            </TD>
          </TR>
        <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(18067,user.getLanguage())%></TD>
            <TD class=Field> 
              <BUTTON class=Browser id=SelectFlowID onClick="onShowFlowID()"></BUTTON> 
              <span 
            id=flowidspan><img src='/images/BacoError.gif' 
            align=absMiddle></span> 
              <INPUT class=inputStyle id=checkFlow 
            type=hidden name=checkFlow>
           
            </TD>
          </TR>
        <TR><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>
      </TD>
</tr>
</TABLE>
</FORM>
</td>
<td></td>
</tr>

<tr>
<td height="10" colspan="3"></td>
</tr>
</table>


<SCRIPT language="javascript">
function OnSubmit(){
    if(check_form(document.resource,"percent_n,checkFlow"))
    
	{	if (<%=type%>=="2")
	     {
	     if (parseFloat(document.resource.percent_n.value)!=100) 
	     {
	     alert("<%=SystemEnv.getHtmlLabelName(18062,user.getLanguage())%>"+"<%=SystemEnv.getHtmlLabelName(18179,user.getLanguage())%>");
	     return;
	     }
	     }
	     if ((<%=type%>=="0")&&(<%=cycle%>=="2"))
	     {
	     if (parseFloat(document.resource.percent_n.value)!=100) 
	     {
	     alert("<%=SystemEnv.getHtmlLabelName(18136,user.getLanguage())%>"+"<%=SystemEnv.getHtmlLabelName(18179,user.getLanguage())%>");
	     return;
	     }
	     }
	     if ((<%=type%>=="1"))
	     {
	     if ((parseFloat(document.resource.percent_n.value)+parseFloat(document.resource.sum.value))>100) 
	     {
	     alert("<%=SystemEnv.getHtmlLabelName(18061,user.getLanguage())%>"+"<%=SystemEnv.getHtmlLabelName(15223,user.getLanguage())%>"+100);
	     return;
	     }
	     }
	     if ((<%=type%>=="0"&&<%=cycle%>!="2"))
	     {
	     if ((parseFloat(document.resource.percent_n.value)+parseFloat(document.resource.sum.value))>100) 
	     {
	     alert("<%=SystemEnv.getHtmlLabelName(18060,user.getLanguage())%>"+"<%=SystemEnv.getHtmlLabelName(15223,user.getLanguage())%>"+100);
	     return;
	     }
	     }
		document.resource.submit();
		enablemenu();
	}
}

</script>
<SCRIPT language=VBS>
sub onShowFlowID() 
     id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/request/FlowBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	flowidspan.innerHtml = id(1)
	resource.checkFlow.value=id(0)
	else
	flowidspan.innerHtml = "<img src='/images/BacoError.gif' align=absMiddle>"
	resource.checkFlow.value=""
	end if
	end if
end sub
sub onShowCheck() 
     id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/performance/maintenance/diyCheck/CheckBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	checkidspan.innerHtml = id(1)
	resource.checkItem.value=id(0)
	else
	checkidspan.innerHtml = "<img src='/images/BacoError.gif' align=absMiddle>"
	resource.checkItem.value=""
	end if
	end if
end sub
sub onShowDoc() 
     id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	docidspan.innerHtml = id(1)
	resource.docItem.value=id(0)
	else
	docidspan.innerHtml ="<img src='/images/BacoError.gif' align=absMiddle>"
	resource.docItem.value=""
	end if
	end if
end sub
</SCRIPT>

</BODY>
</HTML>