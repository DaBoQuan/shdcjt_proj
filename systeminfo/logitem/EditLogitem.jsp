<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<html>
<%
	String itemid = Util.null2String(request.getParameter("id"));
	String lableid = "";
	String itemdesc = "";
%>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
      <TD align=left><SPAN id=BacoTitle class=titlename>�༭: ��־��Ŀ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="LogitemOperation.jsp">
    <input type="hidden" name="operation" value="updatelogitem">
    <input type="hidden" name="itemid" value="<%=itemid%>">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>E</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
   
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>��־��Ŀ��Ϣ</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
    <%
RecordSet.executeProc("SystemLogItem_SelectByID",itemid);
if(RecordSet.next())  {
	lableid = Util.toScreenToEdit(RecordSet.getString("lableid"),user.getLanguage()) ;
	itemdesc = Util.toScreenToEdit(RecordSet.getString("itemdesc"),user.getLanguage()) ;
}
%>
    <TR> 
      <TD>��ʶ</TD>
      <TD Class=Field>
        <%=itemid%>
      </TD>
    </TR>
    <tr> 
      <td>��ǩ��ʶ</td>
      <td class=Field>
        <input type="text" name="lableid" size="10" value="<%=lableid%>">
      </td>
    </tr>
    <TR> 
      <TD>����</TD>
      <TD Class=Field>
        <input type="text" name="itemdesc" size="30" value="<%=itemdesc%>">
      </TD>
    </TR>
    </TBODY> 
  </TABLE>
  </FORM>
</BODY>
</HTML>
