<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<html>
<%
	String id = Util.null2String(request.getParameter("id"));
	String procedurename = "";
	String proceduretable = "";
	String procedurescript = "";
	String proceduredesc = "";
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
    <TD align=left><SPAN id=BacoTitle class=titlename>�༭: �洢����</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="ProcedureOperation.jsp">
    <input type="hidden" name="operation" value="updateprocedure">
    <input type="hidden" name="id" value="<%=id%>">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>E</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
   <TABLE class=Form>
	<COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
	<TR class=Section> 
    <TH colSpan=2>�洢������Ϣ</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
<%
RecordSet.executeProc("ProcedureInfo_SelectByID",id);
if(RecordSet.next())  {
	procedurename = Util.toScreenToEdit(RecordSet.getString("procedurename"),user.getLanguage()) ;
	proceduretable = Util.toScreenToEdit(RecordSet.getString("proceduretabel"),user.getLanguage()) ;
	procedurescript = Util.toScreenToEdit(RecordSet.getString("procedurescript"),user.getLanguage()) ;
	proceduredesc = Util.toScreenToEdit(RecordSet.getString("proceduredesc"),user.getLanguage()) ;
}
%>
    <TR> 
      <TD>����</TD>
      <TD Class=Field><input accesskey=Z name=procedurename size="30" value="<%=procedurename%>"></TD>
    </TR>
    <tr> 
      <td>��صı�</td>
      <td class=Field><textarea  accesskey="Z" name="proceduretable" cols="50"><%=proceduretable%></textarea></td>
    </tr>
    <tr> 
      <td>�ű�</td>
      <td class=Field><textarea accesskey="Z" name="procedurescript" cols="50" rows="8"><%=procedurescript%></textarea></td>
    </tr>
    <TR> 
      <TD>����</TD>
      <TD Class=Field><textarea  accesskey="Z" name="proceduredesc" cols="50"><%=proceduredesc%></textarea></TD>
    </TR>
	</TBODY> 
	</TABLE>
  </FORM>
</BODY>
</HTML>
