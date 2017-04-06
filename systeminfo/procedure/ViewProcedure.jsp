<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<html>
<%
	String id = Util.null2String(request.getParameter("id"));
	String procedurename = "";
	String proceduretable = "";
	String procedurescript = "";
	String proceduredesc = "";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<script language="javascript">
function confirmdel() {
	return confirm("ȷ��ɾ��ѡ������Ϣ��?") ;
}
</script>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: �洢����</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="ProcedureOperation.jsp">
    <input type="hidden" name="operation" value="deleteprocedure">
    <input type="hidden" name="delete_procedure_id" value="<%=id%>">
    <BUTTON class=btn id=btnEdit accessKey=E name=btnEdit onclick="editprocedure()"><U>E</U>-�༭</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleteprocedure()"><U>D</U>-ɾ��</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addprocedure()"><U>A</U>-���</BUTTON>
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
	procedurename = Util.toScreen(RecordSet.getString("procedurename"),user.getLanguage()) ;
	proceduretable = Util.toScreen(RecordSet.getString("proceduretabel"),user.getLanguage()) ;
	procedurescript = Util.toScreen(RecordSet.getString("procedurescript"),user.getLanguage()) ;
	proceduredesc = Util.toScreen(RecordSet.getString("proceduredesc"),user.getLanguage()) ;
}
%>
    <TR> 
      <TD>����</TD>
      <TD Class=Field><%=procedurename%></TD>
    </TR>
    <tr> 
      <td>��صı�</td>
      <td class=Field><%=proceduretable%></td>
    </tr>
    <tr> 
      <td>�ű�</td>
      <td class=Field><%=procedurescript%></td>
    </tr>
    <TR> 
      <TD>����</TD>
      <TD Class=Field><%=proceduredesc%></TD>
    </TR>
    </TBODY> 
	</TABLE>
      </FORM>
<script>
function deleteprocedure(){
	if(confirmdel()) {
		document.frmView.submit();
	}
}
function addprocedure() {	
	location="AddProcedure.jsp";
}
function editprocedure() {	
	location="EditProcedure.jsp?id=<%=id%>";
}
</script>
      </BODY>
      </HTML>
