<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
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
    <TD align=left><SPAN id=BacoTitle class=titlename>���: �洢����</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="ProcedureOperation.jsp">
    <input type="hidden" name="operation" value="addprocedure">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
        
  <TABLE class=Form>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>�洢������Ϣ</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <input accesskey=Z name=procedurename size="30">
      </td>
    </tr>
    <tr> 
      <td>��صı�</td>
      <td class=Field> 
        <textarea  accesskey="Z" name="proceduretable" cols="50"></textarea>
      </td>
    </tr>
    <tr> 
      <td>�ű�</td>
      <td class=Field> 
        <textarea accesskey="Z" name="procedurescript" cols="50" rows="8"></textarea>
      </td>
    </tr>
    <tr> 
      <td>����</td>
      <td class=Field> 
        <textarea accesskey="Z" name="proceduredesc" cols="50"></textarea>
      </td>
    </tr>
    </TBODY> 
  </TABLE>
</FORM>
      </BODY>
      </HTML>
