<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
      <TD align=left><SPAN id=BacoTitle class=titlename>���: Ȩ��</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="RightOperation.jsp">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
        
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>Ȩ������</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>����</td>
      <td class=Field>
        <select name="righttype">
          <option value="0">CRM</option>
		  <option value="1">�ĵ�</option>
		  <option value="2">����</option>
		  <option value="3">������Դ</option>
		  <option value="4">����</option>
		  <option value="5">������</option>
		  <option value="6">��Ŀ</option>
		  <option value="7">ϵͳ</option>
        </select>
      </td>
    </tr>
    <TR> 
      <td>����</td>
      <td class=Field> 
        <input accesskey=Z name=rightdescown>
      </td>
    </TR>
    </TBODY> 
  </TABLE>
		<br>
        
  <TABLE class=Form>
    <COLGROUP><COL width="30%"> <COL width="70%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=3>Ȩ��ϸ��</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep2 colSpan=3></TD>
    </TR>
    <TR> 
      <Td Class=Field>����</Td>
      <Td Class=Field colspan="2">Ȩ��</Td>
    </TR>
    <%
while(LanguageComInfo.next()){
	String langid = LanguageComInfo.getLanguageid();
	String langname = Util.toScreen(LanguageComInfo.getLanguagename(),user.getLanguage());
%>
    <TR> 
      <Td rowspan="2" valign="top"><%=langname%></Td>
      <Td width="15%">����</Td>
      <Td class=Field>
        <input type="text" name="rightname<%=langid%>">
      </Td>
    </TR>
    <TR> 
      <Td width="15%">����</Td>
      <Td class=Field>
        <input type="text" name="rightdesc<%=langid%>" size="30">
      </Td>
    </TR>
    <%
}
%>
  </table>
<input type="hidden" name="operation" value="addright">

      </FORM>
      </BODY>
      </HTML>
