<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<html>
<%
	String searchcon="";
	searchcon = Util.fromScreen(request.getParameter("searchcon"),user.getLanguage());
%>
<head>
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript">
function CheckAll(checked) {
len = document.frmSearch.elements.length;
var i=0;
for( i=0; i<len; i++) {
if (document.frmSearch.elements[i].name=='delete_note_id') {
document.frmSearch.elements[i].checked=(checked==true?true:false);
} } }


function unselectall()
{
    if(document.frmSearch.checkall0.checked){
	document.frmSearch.checkall0.checked =0;
    }
}
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
    <TD align=left width=55><IMG height=24 src="/images/hdDOCSearch.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>����: ��ʾ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmSearch method=post action="NoteOperation.jsp">
    <BUTTON class=btn id=btnSearch accessKey=S name=btnSearch type=submit onclick="searchnote()"><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addnote()"><U>A</U>-���</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deletenote()"><U>D</U>-ɾ��</BUTTON>
    <br>
        <TABLE class=ListShort>
          <COLGROUP> <COL width="5%"> <COL width="32%"> <COL width=1> <COL width="10%"> <COL width="32%"> <TBODY> 
          <TR class=Section> 
            <TH colSpan=5>��������</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep1 colSpan=5></TD>
          </TR>
          <TR> 
            <TD>��ʾ����</TD>
            <TD Class=Field colspan=4> 
              <INPUT class=FieldxLong name=searchcon value="<%=Util.toScreen(request.getParameter("searchcon"),user.getLanguage(),"0")%>">
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
        <br>
        <TABLE class=ListShort>
          <COLGROUP> <COL width="10%"> <COL width="30%"> <COL width="30%"> <COL width="30%"><TBODY> 
          <TR class=Section> 
            <TH colSpan=5>�������</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep2 colSpan=4></TD>
          </TR>
          <TR class=Header> 
            <Td Class=Field></Td>
            <Td Class=Field>��ʶ</Td>
            <Td Class=Field>����</Td>
            <Td Class=Field>ϸ��</Td>
          </TR>
<%
String SearchSql="";
if (searchcon.equalsIgnoreCase("")){
SearchSql="select * from HtmlNoteIndex order by id asc";
}
else
{
SearchSql="select * from HtmlNoteIndex where indexdesc like '%" +searchcon+"%' order by id asc"; 
}
//out.println(SearchSql);
RecordSet.executeSql(SearchSql);
boolean isLight = false;
if(RecordSet.last())
{
do{

	//String indexdesc = Util.toScreen(NoteMainManager.getIndexdesc(),user.getLanguage());
	//int id=NoteMainManager.getId();
if(isLight)
		{%>	
	<TR CLASS="DataDark">
<%}else{%>
	<TR CLASS="DataLight">
<%}%>
    
            <TD><input type="checkbox" name="delete_note_id" value="<%=RecordSet.getInt("id")%>" onClick=unselectall()></TD>
            <TD><%=RecordSet.getInt("id")%></TD>
            <TD><%=RecordSet.getString("indexdesc")%></TD>
            <TD><a href="ViewNote.jsp?id=<%=RecordSet.getInt("id")%>&indexdesc=<%=RecordSet.getString("indexdesc")%>"><img src="/images/iedit.gif" width="16" height="16" border="0"></a></TD>
          </TR>
    
<%
isLight = !isLight;
}while(RecordSet.previous());
}
//NoteMainManager.closeStatement();
%>
<TR class=Separator> 
            <TD class=sep2 colSpan=4>
            <input type="hidden" name="operation" value="search">
            </TD>
          </TR>
<tr>
          </TBODY> 
        </TABLE>
        <br>
        <input type="checkbox" name="checkall0" onClick="CheckAll(checkall0.checked)" value="ON">ȫ��ѡ��
      </FORM>
<script>
function addnote() {	
	location="AddNote.jsp";
}
function searchnote() {
	document.frmSearch.operation.value="search";
	document.frmSearch.submit();
}
function deletenote() {
	document.frmSearch.operation.value="deletenote";
	if(confirmdel())
		document.frmSearch.submit();
}
</script>
      </BODY>
      </HTML>
