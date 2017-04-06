<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
<%
	String indexdesc="";
	int id;
	indexdesc = Util.toScreen(request.getParameter("indexdesc"),user.getLanguage(),"0");
	id = Util.getIntValue(request.getParameter("id"),0);
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
    <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: ��ǩ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="LabelOperation.jsp">
    <BUTTON class=btn id=btnEdit accessKey=E name=btnEdit onclick="editlabel()"><U>E</U>-�༭</BUTTON>
<%if(Util.getIntValue(user.getSeclevel(),0)>=20){%>    
	<BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deletelabel()"><U>D</U>-ɾ��</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addlabel()"><U>A</U>-���</BUTTON>
<%}%>
<BUTTON class=btn id=btnEdit accessKey=S name=btnEdit onclick="viewSQL()"><U>E</U>-����SQL</BUTTON>
<BUTTON class=btn id=btnBack accessKey=B name=btnBack onclick="backSubmit()"><U>B</U>-����</BUTTON> 
    <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
          <TR class=Section> 
            <TH colSpan=5>��ǩ��Ϣ</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep1 colSpan=5></TD>
          </TR>
          <TR> 
            <TD>��ʶ</TD>
            <TD Class=Field><%=id%></TD>
          </TR>
          <TR> 
            <TD>����</TD>
            <TD Class=Field><%=indexdesc%></TD>
          </TR>
          </TBODY> 
        </TABLE>
        <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="30%"> <COL width="30%"> <COL width="30%"><TBODY> 
          <TR class=Section> 
            <TH colSpan=5>��ǩ����</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep2 colSpan=3></TD>
          </TR>
          <TR> 
            <Td Class=Field>��ʶ</Td>
            <Td Class=Field>����</Td>
            <Td Class=Field>��ǩ����</Td>
          </TR>
<%
String labelIfoSql="select HtmlLabelInfo.*,syslanguage.language from HtmlLabelInfo inner join syslanguage on HtmlLabelInfo.languageid=syslanguage.id where indexid=" + id;
rs.executeSql(labelIfoSql);
/*
LabelInfoManager.resetParameter();
LabelInfoManager.setIndexid(id);
LabelInfoManager.selectLabelInfo();
*/
while(rs.next())
{
	String labelname = rs.getString("labelname");
	int languageid=rs.getInt("id");
	
	
%>
         <TR> 
            <TD><%=id%></TD>
            <TD><%=rs.getString("language")%></TD>
            <TD><%=labelname%></TD>
          </TR>
<%
}
//LabelInfoManager.closeStatement();
%>
<input type="hidden" name="operation" value="deletelabel">
<input type="hidden" name="delete_label_id" value="<%=id%>">
      </FORM>
<script>
function deletelabel(){
	if(confirmdel()) {
		document.frmView.submit();
	}
}
function addlabel() {	
	location='AddLabel.jsp';
}
function editlabel() {	
	location='EditLabel.jsp?id=<%=id%>&indexdesc=<%=indexdesc%>';
}
function viewSQL(){
    location = 'ViewSql.jsp?id=<%=id%>&indexdesc=<%=indexdesc%>';
}

function backSubmit(){
    location = "ManageLabel.jsp";
}
</script>
      </BODY>
      </HTML>
