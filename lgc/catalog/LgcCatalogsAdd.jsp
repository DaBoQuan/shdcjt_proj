<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<% if(!HrmUserVarify.checkUserRight("LgcCatalogsAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(92,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
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

<FORM id=frmmain action=LgcCatalogsOperation.jsp  method=post onsubmit='return check_form(this,"catalogname,catalogdesc,seclevelfrom,seclevelto")'>
  <DIV style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:frmmain.mysave.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>  
  <BUTTON class=btnSave accessKey=S id=mysave  type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></BUTTON> 
    <input type=hidden name=operation value="addcatalog">
  </div>
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
              <INPUT  class=InputStyle maxLength=30 onchange='checkinput("catalogname","catalognameimage")'
            size=30 name=catalogname>
              <SPAN id=catalognameimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>˵��</TD>
            <TD class=Field> <nobr>
              <INPUT class=InputStyle maxLength=60 onchange='checkinput("catalogdesc","catalogdescimage")'
            size=40 name=catalogdesc>
              <SPAN id=catalogdescimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>˳��</TD>
            <TD class=Field> 
              <INPUT class=InputStyle id=catalogorder size=4 value=1 name=catalogorder onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("catalogorder")'>
            </TD>
          </TR><tr><td class=Line colspan=4></td></tr>
          <TR> 
            <TD>ÿҳ��¼</TD>
            <TD class=Field> 
              <INPUT class=InputStyle id=perpage size=10 value=10 name=perpage onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("perpage")'>
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
              <input class=InputStyle id=seclevelfrom size=10 value=10 name=seclevelfrom onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("seclevelfrom");checkinput("seclevelfrom","seclevelfromimage")'>
              <span id=seclevelfromimage></span> 
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td width="65">��ȫ���𣬵�</td>
            <td class=Field width="187"> 
              <input class=InputStyle id=seclevelto size=10 value=10 name=seclevelto onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("seclevelto");checkinput("seclevelto","secleveltoimage")'>
              <span id=secleveltoimage></span> 
            </td>
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
              <select class=InputStyle id=navibardsp  name=navibardsp>
                <option value="1">���</option>
                <option value="2">������</option>
                <option value="3">����</option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������ɫ</td>
            <td class=Field>
              <table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onClick="SelectTheColor(navibarbgcolorspan,navibarbgcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=navibarbgcolorspan bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=navibarbgcolor name="navibarbgcolor" value="FFFFFF">
            </td>
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onClick="SelectTheColor(navibarfontcolorspan,navibarfontcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=navibarfontcolorspan bgcolor="#000000">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=navibarfontcolor name="navibarfontcolor" value="000000">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <select class=InputStyle id=navibarfontsize name=navibarfontsize>
                <option value=10pt>medium</option>
                <option value=9pt selected>x-small</option>
                <option value=8pt>xx-small</option>
              </select>
            </td>
            <td>����</td>
            <td class=Field> 
              <select class=InputStyle id=navibarfonttype name=navibarfonttype>
                <option value=normal>����</option>
                <option value=bold selected>����</option>
              </select>
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
              <select class=InputStyle id=toolbardsp name=toolbardsp>
                <option value="1">��ҳ</option>
                <option value="2">��ҳ</option>
                <option value="3">����</option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>���</td>
            <td class=Field colspan=3> 
              <input class=InputStyle id=toolbarwidth size=10 value=200 name=toolbarwidth onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("toolbarwidth")'>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onClick="SelectTheColor(toolbarbgcolorspan,toolbarbgcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarbgcolorspan bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarbgcolor name="toolbarbgcolor" value="FFFFFF">
            </td>
            <td>������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarfontcolorspan,toolbarfontcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarfontcolorspan bgcolor="#000000">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarfontcolor name="toolbarfontcolor" value="000000">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>���ӱ�����ɫ</td>
            <td class=Field>
			<table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarlinkbgcolorspan,toolbarlinkbgcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarlinkbgcolorspan bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarlinkbgcolor name="toolbarlinkbgcolor" value="FFFFFF">
            </td>
            <td>����������ɫ</td>
            <td class=Field><table border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td><button class=Browser id=SelectColor onclick="SelectTheColor(toolbarlinkfontcolorspan,toolbarlinkfontcolor)"></button></td>
                  <td> 
                    <table border=1 cellspacing=0 cellpadding=0 bordercolor=black>
                      <tr>
                        <td style="border:1px" id=toolbarlinkfontcolorspan bgcolor="#000000">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </TR><tr><td class=Line colspan=4></td></tr>
              </table>
			  <input type=hidden id=toolbarlinkfontcolor name="toolbarlinkfontcolor" value="000000">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <select class=InputStyle id=toolbarfontsize name=toolbarfontsize>
                <option value=9pt>medium</option>
                <option value=8pt selected>x-small</option>
                <option value=7pt>xx-small</option>
              </select>
            </td>
            <td>����</td>
            <td class=Field> 
              <select class=InputStyle id=toolbarfonttype name=toolbarfonttype>
                <option value=normal>����</option>
                <option value=bold selected>����</option>
              </select>
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
              <input class=InputStyle id=countrydsp type=checkbox CHECKED name="countrydsp" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>- Ĭ��</td>
            <td class=Field colspan=3> 
              <select class=InputStyle id=countrydeftype name=countrydeftype>
                <option value=0 selected>������Դ</option>
                <option value=1>�̶�</option>
              </select>
              &nbsp;<BUTTON class=Browser id=SelectCountryID onclick="onShowCountryID(countryidspan,countryid)"></BUTTON> 
              <SPAN id=countryidspan></SPAN> 
              <INPUT id=countryid type=hidden name=countryid>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����������</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle 
            id=searchbyname type=checkbox name="searchbyname" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>��CRM����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle id=searchbycrm type=checkbox name="searchbycrm" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�߼�����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle 
            id=searchadv type=checkbox name="searchadv" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����б�</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle id=assortmentdsp type=checkbox name="assortmentdsp" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�б�����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle maxlength=20 name=assortmentname>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�б�����</td>
            <td class=Field colspan="3"> 
              <input class=InputStyle size=40 name=assortmentsql>
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
              <input class=InputStyle id=attributedsp type=checkbox name="attributedsp" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>��</td>
            <td class=Field colspan=3> 
              <input class=InputStyle id=attributecol size=6 value=5 name=attributecol onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("attributecol")'>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <select class=InputStyle id=attributefontsize name=attributefontsize>
                <option value=9pt>medium</option>
                <option value=8pt selected>x-small</option>
                <option value=7pt>xx-small</option>
              </select>
            </td>
            <td>����</td>
            <td class=Field> 
              <select class=InputStyle id=attributefonttype name=attributefonttype>
                <option value=normal>����</option>
                <option value=bold selected>����</option>
              </select>
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
              <input class=InputStyle size=40  name=assetsql>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td colspan=4><span class=Mini>����: i.IsSalesItem = 1</span></td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 1</td>  
            <td class=Field> 
              <select class=InputStyle  style="WIDTH: 98%" id=assetcol1  name=assetcol1>
			<option value="" ></option>
                <option value="714|assetmark" selected><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
				<option value="195|assetname"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
				<option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
				<option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
				<option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
				<option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
				<option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
				<option value="721|salesprice"><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
				<option value="74|assetimageid"><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
				<option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
				<option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
				<option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
				<option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
				<option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
				<option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
				<option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
			  </select>
            </td>
            <td>�� 2</td>
            <td class=Field> 
              <select class=InputStyle   style="WIDTH: 98%" id=assetcol2  name=assetcol2>
                <option value="" ></option>
                <option value="714|assetmark"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname" selected><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice"><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid"><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 3</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol3  name=assetcol3>
                <option value="" ></option>
                <option value="714|assetmark"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice"  selected><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid"><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
            <td>�� 4</td>
            <td class=Field> 
              <select class=InputStyle   style="WIDTH: 98%" id=assetcol4  name=assetcol4>
                <option value="" ></option>
                <option value="714|assetmark"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice"><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid"><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"  selected><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�� 5</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol5  name=assetcol5>
                <option value="" ></option>
                <option value="714|assetmark"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice"><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid"  selected><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
            <td>�� 6</td>
            <td class=Field> 
              <select  class=InputStyle  style="WIDTH: 98%" id=assetcol6  name=assetcol6>
                <option value="" ></option>
                <option value="714|assetmark"><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></option>
                <option value="195|assetname"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></option>
				<option value="124|departmentid"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
                <option value="179|resourceid"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
                <option value="377|assetcountyid"><%=SystemEnv.getHtmlLabelName(377,user.getLanguage())%></option>
				<option value="717|startdate"><%=SystemEnv.getHtmlLabelName(717,user.getLanguage())%></option>
                <option value="718|enddate"><%=SystemEnv.getHtmlLabelName(718,user.getLanguage())%></option>
                <option value="406|currencyid"><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></option>
                <option value="719|costprice"><%=SystemEnv.getHtmlLabelName(719,user.getLanguage())%></option>
                <option value="721|salesprice"><%=SystemEnv.getHtmlLabelName(721,user.getLanguage())%></option>
                <option value="74|assetimageid"><%=SystemEnv.getHtmlLabelName(74,user.getLanguage())%></option>
                <option value="63|assettypeid"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></option>
                <option value="271|createrid"><%=SystemEnv.getHtmlLabelName(271,user.getLanguage())%></option>
                <option value="722|createdate"><%=SystemEnv.getHtmlLabelName(722,user.getLanguage())%></option>
                <option value="424|lastmoderid"><%=SystemEnv.getHtmlLabelName(424,user.getLanguage())%></option>
                <option value="723|lastmoddate"><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></option>
                <option value="454|assetremark"><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></option>
                <option value="683|seclevel"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
                <option value="705|assetunitid"><%=SystemEnv.getHtmlLabelName(705,user.getLanguage())%></option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>�����С</td>
            <td class=Field> 
              <select class=InputStyle id=assetfontsize name=assetfontsize>
                <option value=9pt>medium</option>
                <option value=8pt selected>x-small</option>
                <option value=7pt>xx-small</option>
              </select>
            </td>
            <td>����</td>
            <td class=Field> 
              <select class=InputStyle id=assetfonttype name=assetfonttype>
                <option value=normal>����</option>
                <option value=bold selected>����</option>
              </select>
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
            type=checkbox name="webshopdap" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����</td>
            <td class=Field> 
              <select class=InputStyle id=webshoptype name=webshoptype>
                <option value="1">�ض��ͻ�</option>
                <option value="0">һ�������</option>
              </select>
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>����</td>
            <td class=Field> 
              <input class=InputStyle 
            id=webshopreturn type=checkbox name="webshopreturn" value="1">
            </td>
          </TR><tr><td class=Line colspan=4></td></tr>
          <tr> 
            <td>������Դ</td>
            <td class=Field><BUTTON class=Browser id=SelectResourceID onClick="onShowResourceID(webshopmanageidspan,webshopmanageid)"></BUTTON> <span 
            id=webshopmanageidspan></span> 
              <INPUT class=InputStyle id=webshopmanageid type=hidden name=webshopmanageid> </td>
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
</BODY></HTML>
