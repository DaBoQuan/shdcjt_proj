<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
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
      <TD align=left><SPAN id=BacoTitle class=titlename>���: ��־��Ŀ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="LogitemOperation.jsp">
    <input type="hidden" name="operation" value="addlogitem">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
        
  <TABLE class=Form>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>��־��Ŀ��Ϣ</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>��ʶ</td>
   
      <td class=Field> 
        <input name=itemid size="10">
      </td>
    </tr>
    <tr> 
      <td>��ǩ��ʶ</td>
      <td class=Field> 
        <input type="text" name="lableid" size="10" value="">
      </td>
    </tr>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <input type="text" name="itemdesc" size="30" value="">
      </td>
    </tr>
    </TBODY> 
  </TABLE>
</FORM>
      </BODY>
      </HTML>
