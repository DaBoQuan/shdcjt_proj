<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<html>
<%
	String itemid = Util.null2String(request.getParameter("id"));
	String lableid = "";
	String itemdesc = "";
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
      <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: ��־��</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="LogitemOperation.jsp">
    <input type="hidden" name="operation" value="deletelogitem">
    <input type="hidden" name="delete_logitem_id" value="<%=itemid%>">
    <BUTTON class=btn id=btnEdit accessKey=E name=btnEdit onclick="editlogitem()"><U>E</U>-�༭</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deletelogitem()"><U>D</U>-ɾ��</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addlogitem()"><U>A</U>-���</BUTTON>
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
	itemid = Util.toScreen(RecordSet.getString("itemid"),user.getLanguage()) ;
	lableid = Util.toScreen(RecordSet.getString("lableid"),user.getLanguage()) ;
	itemdesc = Util.toScreen(RecordSet.getString("itemdesc"),user.getLanguage()) ;
}
%>
    <TR> 
      <TD>��Ŀ��ʶ</TD>
      <TD Class=Field><%=itemid%></TD>
    </TR>
    <tr> 
      <td>��ǩ��ʶ</td>
      <td class=Field><%=lableid%></td>
    </tr>
    <TR> 
      <TD>����</TD>
      <TD Class=Field><%=itemdesc%></TD>
    </TR>
    </TBODY> 
  </TABLE>
      </FORM>
<script>
function deletelogitem(){
	if(confirmdel()) {
		document.frmView.submit();
	}
}
function addlogitem() {	
	location="AddLogitem.jsp";
}
function editlogitem() {	
	location="EditLogitem.jsp?id=<%=itemid%>";
}
</script>
      </BODY>
      </HTML>
