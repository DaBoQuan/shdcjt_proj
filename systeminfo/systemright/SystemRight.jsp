<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript">
function CheckAll(checked) {
len = document.frmdelete.elements.length;
var i=0;
for( i=0; i<len; i++) {
if (document.frmdelete.elements[i].name=='delete_right_id') {
document.frmdelete.elements[i].checked=(checked==true?true:false);
} } }


function unselectall()
{
    if(document.frmdelete.checkall0.checked){
	document.frmdelete.checkall0.checked =0;
    }
}
function confirmdel() {
	return confirm("ȷ��ɾ��ѡ������Ϣ��?") ;
}
</script>
</head>
<%
	String searchcon="";
	searchcon = Util.toScreen(request.getParameter("searchcon"),user.getLanguage());
%>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOCSearch.gif"></TD>
      <TD align=left><SPAN id=BacoTitle class=titlename>����:Ȩ��</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmSearch method=post action="SystemRight.jsp">
    <BUTTON class=btn id=btnSearch accessKey=S name=btnSearch type=submit><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addright()"><U>A</U>-���</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleteright()"><U>D</U>-ɾ��</BUTTON>
    <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="5%"> <COL width="32%"> <COL width=1> <COL width="10%"> <COL width="32%"> <TBODY> 
          <TR class=Section> 
            <TH colSpan=5>��������</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep1 colSpan=5></TD>
          </TR>
          <TR> 
            
      <TD>Ȩ������</TD>
            <TD Class=Field colspan=4> 
              <INPUT class=FieldxLong name=searchcon accessKey=Z value="<%=searchcon%>">
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
		</form>
        <br>
		<FORM style="MARGIN-TOP: 0px" name=frmdelete method=post action="RightOperation.jsp">
        <TABLE class=Form>
          <COLGROUP> <COL width="10%"> <COL width="30%"> <COL width="30%"> <COL width="30%"><TBODY> 
          <TR class=Section> 
            <TH colSpan=5>�������</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep2 colSpan=4></TD>
          </TR>
          <TR> 
            <Td Class=Field></Td>
            <Td Class=Field>��ʶ</Td>
            
      <Td Class=Field>����</Td>
            <Td Class=Field>ϸ��</Td>
          </TR>
<%
RecordSet.executeProc("SystemRights_Select","%"+searchcon+"%");
while(RecordSet.next())
{
	String id=RecordSet.getString("id");
	String rightdesc=Util.toScreen(RecordSet.getString("rightdesc"),user.getLanguage());
%>
         <TR> 
            <TD><input type="checkbox" name="delete_right_id" value="<%=id%>" onClick=unselectall()></TD>
            <TD><%=id%></TD>
            <TD><%=rightdesc%></TD>
            <TD><a href="ViewRight.jsp?id=<%=id%>"><img src="/images/iedit.gif" width="16" height="16" border="0"></a></TD>
          </TR>
    
<%
}
%>
          <TR class=Separator> 
            <TD class=sep2 colSpan=4></TD>
          </TR>
		  </TBODY> 
        </TABLE>
		<input type="checkbox" name="checkall0" onClick="CheckAll(checkall0.checked)" value="ON">
  ȫ��ѡ�� 
  <input type="hidden" name="operation" value="search">
</FORM>
<script>
function addright() {	
	location="AddRight.jsp";
}
function deleteright() {
	document.frmdelete.operation.value="deleteright";
	if(confirmdel())
		document.frmdelete.submit();
}
</script>
      </BODY>
      </HTML>
