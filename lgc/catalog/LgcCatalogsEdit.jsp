<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String id = Util.null2String(request.getParameter("id"));
RecordSet.executeProc("LgcCatalogs_SelectByID",id);
RecordSet.next();
	
	
String catalogname = RecordSet.getString("catalogname") ;
String catalogdesc = RecordSet.getString("catalogdesc") ;
String catalogorder = Util.null2String(RecordSet.getString("catalogorder")) ;
String perpage = Util.null2String(RecordSet.getString("perpage")) ;
String seclevelfrom = Util.null2String(RecordSet.getString("seclevelfrom")) ;
String seclevelto = Util.null2String(RecordSet.getString("seclevelto")) ;
String navibardsp = Util.null2String(RecordSet.getString("navibardsp")) ;
String navibarbgcolor = Util.null2String(RecordSet.getString("navibarbgcolor")) ;
String navibarfontcolor = Util.null2String(RecordSet.getString("navibarfontcolor")) ;
String navibarfontsize = Util.null2String(RecordSet.getString("navibarfontsize")) ;
String navibarfonttype = Util.null2String(RecordSet.getString("navibarfonttype")) ;
String toolbardsp = Util.null2String(RecordSet.getString("toolbardsp")) ;
String toolbarwidth = Util.null2String(RecordSet.getString("toolbarwidth")) ;
String toolbarbgcolor = Util.null2String(RecordSet.getString("toolbarbgcolor")) ;
String toolbarfontcolor = Util.null2String(RecordSet.getString("toolbarfontcolor")) ;
String toolbarlinkbgcolor = Util.null2String(RecordSet.getString("toolbarlinkbgcolor")) ;
String toolbarlinkfontcolor = Util.null2String(RecordSet.getString("toolbarlinkfontcolor")) ;
String toolbarfontsize = Util.null2String(RecordSet.getString("toolbarfontsize")) ;
String toolbarfonttype = Util.null2String(RecordSet.getString("toolbarfonttype")) ;
String countrydsp = Util.null2String(RecordSet.getString("countrydsp")) ;
String countrydeftype = Util.null2String(RecordSet.getString("countrydeftype")) ;
String countryid = Util.null2String(RecordSet.getString("countryid")) ;
String searchbyname = Util.null2String(RecordSet.getString("searchbyname")) ;
String searchbycrm = Util.null2String(RecordSet.getString("searchbycrm")) ;
String searchadv = Util.null2String(RecordSet.getString("searchadv")) ;
String assortmentdsp = Util.null2String(RecordSet.getString("assortmentdsp")) ;
String assortmentname = RecordSet.getString("assortmentname") ;
String assortmentsql = RecordSet.getString("assortmentsql") ;
String attributedsp = Util.null2String(RecordSet.getString("attributedsp")) ;
String attributecol = Util.null2String(RecordSet.getString("attributecol")) ;
String attributefontsize = Util.null2String(RecordSet.getString("attributefontsize")) ;
String attributefonttype = Util.null2String(RecordSet.getString("attributefonttype")) ;
String assetsql =RecordSet.getString("assetsql") ;
String assetcol1 = Util.null2String(RecordSet.getString("assetcol1")) ;
String assetcol2 = Util.null2String(RecordSet.getString("assetcol2")) ;
String assetcol3 = Util.null2String(RecordSet.getString("assetcol3")) ;
String assetcol4 = Util.null2String(RecordSet.getString("assetcol4")) ;
String assetcol5 = Util.null2String(RecordSet.getString("assetcol5")) ;
String assetcol6 = Util.null2String(RecordSet.getString("assetcol6")) ;
String assetfontsize = Util.null2String(RecordSet.getString("assetfontsize")) ;
String assetfonttype = Util.null2String(RecordSet.getString("assetfonttype")) ;
String webshopdap = Util.null2String(RecordSet.getString("webshopdap")) ;
String webshoptype = Util.null2String(RecordSet.getString("webshoptype")) ;
String webshopreturn = Util.null2String(RecordSet.getString("webshopreturn")) ;
String webshopmanageid = Util.null2String(RecordSet.getString("webshopmanageid")) ;
String createrid = Util.toScreenToEdit(RecordSet.getString("createrid"),user.getLanguage()) ;					/*������id*/
String createdate = Util.toScreenToEdit(RecordSet.getString("createdate"),user.getLanguage()) ;					/*��������*/
String lastmodid = Util.toScreenToEdit(RecordSet.getString("lastmoderid"),user.getLanguage()) ;					/*����޸���id*/
String lastmoddate = Util.toScreenToEdit(RecordSet.getString("lastmoddate"),user.getLanguage()) ;

boolean canedit = HrmUserVarify.checkUserRight("LgcCatalogsEdit:Edit",user) ;


String temStr="";
temStr+="<B>"+SystemEnv.getHtmlLabelName(125,user.getLanguage())+":&nbsp;</B>"+createdate+"&nbsp;&nbsp;<b>"+SystemEnv.getHtmlLabelName(271,user.getLanguage())+":&nbsp;</b>"+Util.toScreen(ResourceComInfo.getResourcename(createrid),user.getLanguage())+"&nbsp;&nbsp;<B>"+SystemEnv.getHtmlLabelName(103,user.getLanguage())+":&nbsp;</B>"+lastmoddate+"&nbsp;&nbsp;<B>"+SystemEnv.getHtmlLabelName(424,user.getLanguage())+":&nbsp;</B>"+Util.toScreen(ResourceComInfo.getResourcename(lastmodid),user.getLanguage())+"&nbsp;&nbsp;";

String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(92,user.getLanguage())+" : "+Util.toScreen(catalogname,user.getLanguage())+"&nbsp;&nbsp;&nbsp;&nbsp;"+temStr;
String needfav ="1";
String needhelp ="";
%>
<BODY>

<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


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



<FORM id=frmmain name=frmmain action=LgcCatalogsOperation.jsp  method=post>
 <DIV style="display:none">
  <% if(canedit) {%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onEdit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnSave id=saveB accessKey=S name=SaveB onclick="onEdit()"><U>S</U>-<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></BUTTON>
<%}
if(HrmUserVarify.checkUserRight("LgcCatalogsAdd:Add",user)) {%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",javascript:location.href='LgcCatalogsAdd.jsp',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnNew id=AddNew accessKey=N onclick='location.href="LgcCatalogsAdd.jsp"'><U>N</U>-<%=SystemEnv.getHtmlLabelName(365,user.getLanguage())%></BUTTON>
<%}
if(HrmUserVarify.checkUserRight("LgcCatalogsEdit:Delete",user)) {%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDelete(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnDelete id=Delete accessKey=D onclick="onDelete()"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
<%}
if(HrmUserVarify.checkUserRight("LgcCatalogs:Log",user)) {%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",javascript:location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =52 and relatedid="+id+"',_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=BtnLog accessKey=L name=button2 onclick="location='/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem =52 and relatedid=<%=id%>'"><U>L</U>-<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%></BUTTON>
<%}%>
  </div>
  <input type=hidden name=operation>
  <input type=hidden name=id value="<%=id%>">
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="49%"> <COL width=10> <COL width="49%"> <TBODY> 
    <TR class=Title> 
      <TH colSpan=3>������Ϣ</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=3></TD>
    </TR>
    <TR> 
      <TD vAlign=top> 
        <TABLE class=ViewForm>
          <COLGROUP> <COL width=150> <TBODY> 
          <TR> 
            <TD>����</TD>
            <TD class=Field> 
			<% if(canedit) {%>
              <INPUT  class=InputStyle maxLength=30 onchange='checkinput("catalogname","catalognameimage")'
            size=30 name=catalogname value="<%=Util.toScreenToEdit(catalogname,user.getLanguage())%>">
              <SPAN id=catalognameimage></SPAN>
			 <%} else {%> <%=Util.toScreen(catalogname,user.getLanguage())%><%}%>
			  </TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>˵��</TD>
            <TD class=Field> <nobr> 
              <% if(canedit) {%>
              <INPUT class=InputStyle maxLength=60 onchange='checkinput("catalogdesc","catalogdescimage")'
            size=40 name=catalogdesc value="<%=Util.toScreenToEdit(catalogdesc,user.getLanguage())%>">
              <SPAN id=catalogdescimage></SPAN>
              <%} else {%>
              <%=Util.toScreen(catalogdesc,user.getLanguage())%> 
              <%}%>
              </TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>˳��</TD>
            <TD class=Field> 
              <% if(canedit) {%>
              <INPUT class=InputStyle id=catalogorder size=4 value=<%=catalogorder%> name=catalogorder onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("catalogorder")'>
              <%} else {%>
              <%=catalogorder%>
              <%}%>
            </TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>ÿҳ��¼</TD>
            <TD class=Field> 
              <% if(canedit) {%>
              <INPUT class=InputStyle id=perpage size=10 value=<%=perpage%> name=perpage onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("perpage")'>
              <%} else {%>
              <%=perpage%> 
              <%}%>
            </TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          </TBODY> 
        </TABLE>
      </TD>
      <TD></TD>
      <TD vAlign=top> 
        <TABLE class=ViewForm>
          <tr> 
            <td width="65">��ȫ���𣬴�</td>
            <td class=Field width="187"> 
              <% if(canedit) {%>
              <input class=InputStyle id=seclevelfrom size=10 value=<%=seclevelfrom%> name=seclevelfrom onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("seclevelfrom");checkinput("seclevelfrom","seclevelfromimage")'>
              <span id=seclevelfromimage>
              <%} else {%>
              <%=seclevelfrom%> 
              <%}%>
              </span> </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td width="65">��ȫ���𣬵�</td>
            <td class=Field width="187"> 
              <% if(canedit) {%>
              <input class=InputStyle id=seclevelto size=10 value=<%=seclevelto%> name=seclevelto onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("seclevelto");checkinput("seclevelto","secleveltoimage")'>
              <span id=secleveltoimage>
              <%} else {%>
              <%=seclevelto%> 
              <%}%>
              </span> </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <COLGROUP> <COL width=150> <TBODY> </TBODY> 
        </TABLE>
      </TD>
    </TR>
    <!-- Color & Layout -->
    <TR class=Title> 
      <TH>������</TH>
      <TH>&nbsp;</TH>
      <TH>������</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=3></TD>
    </TR>
    <TR> 
      <TD vAlign=top> 
        <table class=ViewForm>
          <tr> 
            <td>��ʾ</td>
            <td class=Field colSpan=3> 
              <% if(canedit) {%>
              <select class=InputStyle id=navibardsp  name=navibardsp>
                <option value="1" <%if(navibardsp.equals("1")) {%> selected <%}%>>���</option>
                <option value="2" <%if(navibardsp.equals("2")) {%> selected <%}%>>������</option>
                <option value="3" <%if(navibardsp.equals("3")) {%> selected <%}%>>����</option>
              </select>
              <%} else {
			  if(navibardsp.equals("1")) {%> ���
			  <%} else if(navibardsp.equals("2")) {%> ������
			  <%} else if(navibardsp.equals("3")) {%> ����
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������ɫ</td>
            <td class=Field>
              <table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onClick="SelectTheColor(navibarbgcolorspan,navibarbgcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=navibarbgcolorspan bgcolor="#<%=navibarbgcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=navibarbgcolor name="navibarbgcolor" value="<%=navibarbgcolor%>">
            </td>
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onClick="SelectTheColor(navibarfontcolorspan,navibarfontcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=navibarfontcolorspan bgcolor="#<%=navibarfontcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=navibarfontcolor name="navibarfontcolor" value="<%=navibarfontcolor%>">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=navibarfontsize name=navibarfontsize>
                <option value=10pt <%if(navibarfontsize.equals("10pt")) {%> selected <%}%>>medium</option>
                <option value=9pt <%if(navibarfontsize.equals("9pt")) {%> selected <%}%>>x-small</option>
                <option value=8pt <%if(navibarfontsize.equals("8pt")) {%> selected <%}%>>xx-small</option>
              </select>
              <%} else {
			  if(navibarfontsize.equals("10pt")) {%>medium
              <%} else if(navibarfontsize.equals("9pt")) {%>x-small
              <%} else if(navibarfontsize.equals("8pt")) {%>xx-small
              <%}}%>
            </td>
            <td>����</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=navibarfonttype name=navibarfonttype>
                <option value=normal <%if(navibarfonttype.equals("normal")) {%> selected <%}%>>����</option>
                <option value=bold <%if(navibarfonttype.equals("bold")) {%> selected <%}%>>����</option>
              </select>
			  <%} else {
			  if(navibarfonttype.equals("normal")) {%>����
              <%} else if(navibarfonttype.equals("bold")) {%>����
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
        </table>
      </TD>
      <TD></TD>
      <TD vAlign=top> 
        <table class=ViewForm>
          <colgroup> <col width=150> <tbody> 
          <tr> 
            <td>��ʾ</td>
            <td class=Field colspan=3> 
              <% if(canedit) {%>
              <select class=InputStyle id=toolbardsp name=toolbardsp>
                <option value="1" <%if(toolbardsp.equals("1")) {%> selected <%}%>>��ҳ</option>
                <option value="2" <%if(toolbardsp.equals("2")) {%> selected <%}%>>��ҳ</option>
                <option value="3" <%if(toolbardsp.equals("3")) {%> selected <%}%>>����</option>
              </select>
              <%} else {
			  if(toolbardsp.equals("1")) {%>��ҳ 
              <%} else if(toolbardsp.equals("2")) {%>��ҳ 
              <%} else if(toolbardsp.equals("3")) {%>���� 
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>���</td>
            <td class=Field colspan=3> 
              <% if(canedit) {%>
              <input class=InputStyle id=toolbarwidth size=10 value=<%=toolbarwidth%> name=toolbarwidth onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("toolbarwidth")'>
              <%} else {%>
              <%=toolbarwidth%> 
              <%}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onClick="SelectTheColor(toolbarbgcolorspan,toolbarbgcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarbgcolorspan bgcolor="#<%=toolbarbgcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarbgcolor name="toolbarbgcolor" value="<%=toolbarbgcolor%>">
            </td>
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarfontcolorspan,toolbarfontcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarfontcolorspan bgcolor="#<%=toolbarfontcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarfontcolor name="toolbarfontcolor" value="<%=toolbarfontcolor%>">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>���ӱ�����ɫ</td>
            <td class=Field>
			<table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarlinkbgcolorspan,toolbarlinkbgcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarlinkbgcolorspan bgcolor="#<%=toolbarlinkbgcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </TR><tr><td class=Line colspan=4></td></tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarlinkbgcolor name="toolbarlinkbgcolor" value="<%=toolbarlinkbgcolor%>">
            </td>
            <td>����������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><% if(canedit) {%><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarlinkfontcolorspan,toolbarlinkfontcolor)"></button><%}%></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarlinkfontcolorspan bgcolor="#<%=toolbarlinkfontcolor%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </TR><tr><td class=Line colspan=4></td></tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarlinkfontcolor name="toolbarlinkfontcolor" value="<%=toolbarlinkfontcolor%>">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=toolbarfontsize name=toolbarfontsize>
                <option value=10pt <%if(toolbarfontsize.equals("10pt")) {%> selected <%}%>>medium</option>
                <option value=9pt <%if(toolbarfontsize.equals("9pt")) {%> selected <%}%>>x-small</option>
                <option value=8pt <%if(toolbarfontsize.equals("8pt")) {%> selected <%}%>>xx-small</option>
              </select>
              <%} else {
			  if(toolbarfontsize.equals("10pt")) {%>
              medium 
              <%} else if(toolbarfontsize.equals("9pt")) {%>
              x-small 
              <%} else if(toolbarfontsize.equals("8pt")) {%>
              xx-small 
              <%}}%>
            </td>
            <td>����</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=toolbarfonttype name=toolbarfonttype>
                <option value=normal <%if(toolbarfonttype.equals("normal")) {%> selected <%}%>>����</option>
                <option value=bold <%if(toolbarfonttype.equals("bold")) {%> selected <%}%>>����</option>
              </select>
              <%} else {
			  if(toolbarfonttype.equals("normal")) {%>
              ���� 
              <%} else if(toolbarfonttype.equals("bold")) {%>
              ���� 
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          </tbody> 
        </table>
      </TD>
    </TR>
    <TR class=Title> 
      <TH>������ʾ</TH>
      <TH></TH>
      <TH>����</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=3></TD>
    </TR>
    <TR> 
      <TD vAlign=top> 
        <table class=ViewForm>
          <colgroup> <col width=150> <tbody> 
          <tr> 
            <td>����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle id=countrydsp type=checkbox name="countrydsp" value="1" <%if(countrydsp.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>- Ĭ��</td>
            <td class=Field colspan=3> 
              <% if(canedit) {%>
              <select class=InputStyle id=countrydeftype name=countrydeftype>
                <option value=0 <%if(countrydeftype.equals("0")) {%> selected <%}%>>������Դ</option>
                <option value=1 <%if(countrydeftype.equals("1")) {%> selected <%}%>>�̶�</option>
              </select>
              <%} else {
			  if(countrydeftype.equals("0")) {%>
              ������Դ 
              <%} else if(countrydeftype.equals("1")) {%>
              �̶� 
              <%}}%>
              &nbsp;<% if(canedit) {%><BUTTON class=Browser id=SelectCountryID onclick="onShowCountryID(countryidspan,countryid)"></BUTTON><%}%> 
              <SPAN id=countryidspan><%=Util.toScreen(CountryComInfo.getCountrydesc(countryid),user.getLanguage())%></SPAN> 
              <INPUT id=countryid type=hidden name=countryid value="<%=countryid%>">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����������</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle 
            id=searchbyname type=checkbox name="searchbyname" value="1" <%if(searchbyname.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>��CRM����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle id=searchbycrm type=checkbox name="searchbycrm" value="1" <%if(searchbycrm.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�߼�����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle 
            id=searchadv type=checkbox name="searchadv" value="1" <%if(searchadv.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����б�</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle id=assortmentdsp type=checkbox name="assortmentdsp" value="1" <%if(assortmentdsp.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�б�����</td>
            <td class=Field colspan="3"> 
              <% if(canedit) {%>
              <input class=InputStyle maxlength=20 name=assortmentname value="<%=Util.toScreenToEdit(assortmentname,user.getLanguage())%>">
              <%} else {%>
              <%=Util.toScreen(assortmentname,user.getLanguage())%>
              <%}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�б�����</td>
            <td class=Field colspan="3"> 
              <% if(canedit) {%>
              <input class=InputStyle size=40 name=assortmentsql value="<%=Util.toScreenToEdit(assortmentsql,user.getLanguage())%>">
              <%} else {%>
              <%=Util.toScreen(assortmentsql,user.getLanguage())%> 
              <%}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td colspan="4"><span class=Mini>����: a.Assortment IN (13, 20)</span></td>
          </TR><tr><td class=Line colspan=4></td></tr>
          </tbody> 
        </table>
      </TD>
      <TD></TD>
      <TD vAlign=top> 
        <table class=ViewForm>
          <colgroup> <col width=150> <tbody> 
          <tr> 
            <td>��ʾ</td>
            <td class=Field colspan=3> 
              <input class=InputStyle id=attributedsp type=checkbox name="attributedsp" value="1" <%if(attributedsp.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>��</td>
            <td class=Field colspan=3> 
              <% if(canedit) {%>
              <input class=InputStyle id=attributecol size=6 value=<%=attributecol%> name=attributecol onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("attributecol")'>
              <%} else {%>
              <%=attributecol%> 
              <%}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=attributefontsize name=attributefontsize>
                <option value=10pt <%if(attributefontsize.equals("10pt")) {%> selected <%}%>>medium</option>
                <option value=9pt <%if(attributefontsize.equals("9pt")) {%> selected <%}%>>x-small</option>
                <option value=8pt <%if(attributefontsize.equals("8pt")) {%> selected <%}%>>xx-small</option>
              </select>
              <%} else {
			  if(attributefontsize.equals("10pt")) {%>
              medium 
              <%} else if(attributefontsize.equals("9pt")) {%>
              x-small 
              <%} else if(attributefontsize.equals("8pt")) {%>
              xx-small 
              <%}}%>
            </td>
            <td>����</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=attributefonttype name=attributefonttype>
                <option value=normal <%if(attributefonttype.equals("normal")) {%> selected <%}%>>����</option>
                <option value=bold <%if(attributefonttype.equals("bold")) {%> selected <%}%>>����</option>
              </select>
              <%} else {
			  if(attributefonttype.equals("normal")) {%>
              ���� 
              <%} else if(attributefonttype.equals("bold")) {%>
              ���� 
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          </tbody> 
        </table>
      </TD>
    </TR>
    <!-- Attributes -->
    <TR class=Title> 
      <TH>�ʲ�</TH>
      <TH></TH>
      <TH>���Ϲ���</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=3></TD>
    </TR>
    <TR> 
      <TD vAlign=top> 
        <table class=ViewForm>
          <colgroup> <col width=150> <tbody> 
          <tr> 
            <td>��ʾ����</td>
            <td class=Field colspan=3> 
              <% if(canedit) {%>
              <input class=InputStyle size=40  name=assetsql value="<%=Util.toScreenToEdit(assetsql,user.getLanguage())%>">
              <%} else {%>
              <%=Util.toScreen(assetsql,user.getLanguage())%> 
              <%}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td colspan=4><span class=Mini>����: i.IsSalesItem = 1</span></td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 1</td>  
            <td class=Field> 
             <select  class=InputStyle  style="WIDTH: 98%" id=assetcol1  name=assetcol1 <% if(!canedit) {%> disabled <%}%> >
				<option value="" ></option>
                <option value="714|assetmark" <% if(assetcol1.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
				<option value="195|assetname" <% if(assetcol1.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol1.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
				<option value="179|resourceid" <% if(assetcol1.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
				<option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol1.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
				<option value="718|enddate" <% if(assetcol1.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
				<option value="406|currencyid" <% if(assetcol1.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
				<option value="719|costprice" <% if(assetcol1.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
				<option value="721|salesprice" <% if(assetcol1.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
				<option value="74|assetimageid" <% if(assetcol1.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
				<option value="63|assettypeid" <% if(assetcol1.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
				<option value="271|createrid" <% if(assetcol1.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
				<option value="722|createdate" <% if(assetcol1.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
				<option value="424|lastmoderid" <% if(assetcol1.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
				<option value="723|lastmoddate" <% if(assetcol1.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
				<option value="454|assetremark" <% if(assetcol1.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
				<option value="683|seclevel" <% if(assetcol1.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol1.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
			  </select>
            </td>
            <td>�� 2</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol2  name=assetcol2 <% if(!canedit) {%> disabled <%}%>>
                <option value="" ></option>
                <option value="714|assetmark" <% if(assetcol2.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" <% if(assetcol2.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol2.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid" <% if(assetcol2.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol2.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate" <% if(assetcol2.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid" <% if(assetcol2.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice" <% if(assetcol2.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice" <% if(assetcol2.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid" <% if(assetcol2.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid" <% if(assetcol2.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid" <% if(assetcol2.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate" <% if(assetcol2.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid" <% if(assetcol2.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate" <% if(assetcol2.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark" <% if(assetcol2.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel" <% if(assetcol2.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol2.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
			  </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 3</td>
            <td class=Field> 
              <select  class=InputStyle style="WIDTH: 98%" id=assetcol3  name=assetcol3 <% if(!canedit) {%> disabled <%}%>>
                <option value="" ></option>
                <option value="714|assetmark" <% if(assetcol3.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" <% if(assetcol3.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol3.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid" <% if(assetcol3.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol3.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate" <% if(assetcol3.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid" <% if(assetcol3.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice" <% if(assetcol3.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice" <% if(assetcol3.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid" <% if(assetcol3.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid" <% if(assetcol3.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid" <% if(assetcol3.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate" <% if(assetcol3.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid" <% if(assetcol3.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate" <% if(assetcol3.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark" <% if(assetcol3.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel" <% if(assetcol3.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol3.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
			  </select>
            </td>
            <td>�� 4</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol4  name=assetcol4 <% if(!canedit) {%> disabled <%}%>>
                <option value="" ></option>
                <option value="714|assetmark" <% if(assetcol4.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" <% if(assetcol4.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol4.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid" <% if(assetcol4.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol4.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate" <% if(assetcol4.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid" <% if(assetcol4.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice" <% if(assetcol4.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice" <% if(assetcol4.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid" <% if(assetcol4.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid" <% if(assetcol4.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid" <% if(assetcol4.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate" <% if(assetcol4.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid" <% if(assetcol4.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate" <% if(assetcol4.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark" <% if(assetcol4.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel" <% if(assetcol4.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol4.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
			  </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 5</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol5  name=assetcol5 <% if(!canedit) {%> disabled <%}%>>
                <option value="" ></option>
                <option value="714|assetmark" <% if(assetcol5.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" <% if(assetcol5.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol5.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid" <% if(assetcol5.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol5.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate" <% if(assetcol5.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid" <% if(assetcol5.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice" <% if(assetcol5.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice" <% if(assetcol5.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid" <% if(assetcol5.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid" <% if(assetcol5.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid" <% if(assetcol5.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate" <% if(assetcol5.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid" <% if(assetcol5.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate" <% if(assetcol5.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark" <% if(assetcol5.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel" <% if(assetcol5.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol5.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
            <td>�� 6</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol6  name=assetcol6 <% if(!canedit) {%> disabled <%}%>>
                <option value="" ></option>
                <option value="714|assetmark" <% if(assetcol6.equals("714|assetmark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" <% if(assetcol6.equals("195|assetname")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid" <% if(assetcol6.equals("124|departmentid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid" <% if(assetcol6.equals("179|resourceid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid" <% if(assetcol1.equals("377|assetcountyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate" <% if(assetcol6.equals("717|startdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate" <% if(assetcol6.equals("718|enddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid" <% if(assetcol6.equals("406|currencyid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice" <% if(assetcol6.equals("719|costprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice" <% if(assetcol6.equals("721|salesprice")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid" <% if(assetcol6.equals("74|assetimageid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid" <% if(assetcol6.equals("63|assettypeid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid" <% if(assetcol6.equals("271|createrid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate" <% if(assetcol6.equals("722|createdate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid" <% if(assetcol6.equals("424|lastmoderid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate" <% if(assetcol6.equals("723|lastmoddate")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark" <% if(assetcol6.equals("454|assetremark")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel" <% if(assetcol6.equals("683|seclevel")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid" <% if(assetcol6.equals("705|assetunitid")) {%> selected <%}%>><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=assetfontsize name=assetfontsize>
                <option value=10pt <%if(assetfontsize.equals("10pt")) {%> selected <%}%>>medium</option>
                <option value=9pt <%if(assetfontsize.equals("9pt")) {%> selected <%}%>>x-small</option>
                <option value=8pt <%if(assetfontsize.equals("8pt")) {%> selected <%}%>>xx-small</option>
              </select>
              <%} else {
			  if(assetfontsize.equals("10pt")) {%>
              medium 
              <%} else if(assetfontsize.equals("9pt")) {%>
              x-small 
              <%} else if(assetfontsize.equals("8pt")) {%>
              xx-small 
              <%}}%>
            </td>
            <td>����</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=assetfonttype name=assetfonttype>
                <option value=normal <%if(assetfonttype.equals("normal")) {%> selected <%}%>>����</option>
                <option value=bold <%if(assetfonttype.equals("bold")) {%> selected <%}%>>����</option>
              </select>
              <%} else {
			  if(assetfonttype.equals("normal")) {%>
              ���� 
              <%} else if(assetfonttype.equals("bold")) {%>
              ���� 
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          </tbody> 
        </table>
      </TD>
      <TD></TD>
      <TD vAlign=top> 
        <table class=ViewForm>
          <colgroup> <col width=150> <tbody> 
          <tr> 
            <td>ʹ��</td>
            <td class=Field> 
              <input class=InputStyle id=webshopdap 
            type=checkbox name="webshopdap" value="1" <%if(webshopdap.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����</td>
            <td class=Field> 
              <% if(canedit) {%>
              <select class=InputStyle id=webshoptype name=webshoptype>
                <option value="1" <%if(webshoptype.equals("1")) {%> selected <%}%>>�ض��ͻ�</option>
                <option value="0" <%if(webshoptype.equals("0")) {%> selected <%}%>>һ�������</option>
              </select>
              <%} else {
			  if(webshoptype.equals("1")) {%>
              �ض��ͻ� 
              <%} else if(webshoptype.equals("0")) {%>
              һ������� 
              <%}}%>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����</td>
            <td class=Field> 
              <input class=InputStyle 
            id=webshopreturn type=checkbox name="webshopreturn" value="1" <%if(webshopreturn.equals("1")) {%> checked <%} if(!canedit) {%> disabled <%}%> >
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������Դ</td>
            <td class=Field><% if(canedit) {%><BUTTON class=Browser id=SelectResourceID onClick="onShowResourceID(webshopmanageidspan,webshopmanageid)"></BUTTON><%}%> <span 
            id=webshopmanageidspan><%=Util.toScreen(ResourceComInfo.getResourcename(webshopmanageid),user.getLanguage())%></span> 
              <INPUT class=InputStyle id=webshopmanageid type=hidden name=webshopmanageid value="<%=webshopmanageid%>"> </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          </tbody> 
        </table>
      </TD>
    </TR>
    </TBODY> 
  </TABLE>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script language=VBS>
sub SelectTheColor(spanname,inputname)
	id = window.showModalDialog("/systeminfo/ColorBrowser.jsp")
   if (Not IsEmpty(id)) then
	  inputname.value = id
	  spanname.bgColor = id
   end if
end sub

sub onShowCountryID(spanname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/country/CountryBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else 
	spanname.innerHtml = ""
	inputname.value=""
	end if
	end if
end sub

sub onShowResourceID(spanname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = "<A href='HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	inputname.value=id(0)
	else 
	spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	inputname.value=""
	end if
	end if
end sub

</script>
<Script language=javascript>
function onEdit() {
	if(check_form(frmmain,"catalogname,catalogdesc,seclevelfrom,seclevelto")) {
		frmmain.operation.value="editcatalog";
		frmmain.submit();
	}
}
 function onDelete(){
		if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
			frmmain.operation.value="deletecatalog";
			frmmain.submit();
		}
}
</script>
</BODY></HTML>
