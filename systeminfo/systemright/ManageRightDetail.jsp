<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RightComInfo" class="weaver.systeminfo.systemright.RightComInfo" scope="page"/>
<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript">
function CheckAll(checked) {
len = document.frmDelete.elements.length;
var i=0;
for( i=0; i<len; i++) {
if (document.frmDelete.elements[i].name=='delete_rightdetail_id') {
document.frmDelete.elements[i].checked=(checked==true?true:false);
} } }


function unselectall()
{
    if(document.frmDelete.checkall0.checked){
	document.frmDelete.checkall0.checked =0;
    }
}
function confirmdel() {
	return confirm("ȷ��ɾ��ѡ������Ϣ��?") ;
}
</script>
</head>
<%
	String searchcon="";
    String searchkey="";
	searchcon = Util.toScreen(request.getParameter("searchcon"),user.getLanguage());
    searchkey = Util.toScreen(request.getParameter("searchkey"),user.getLanguage());
%>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOCSearch.gif"></TD>
      <TD align=left><SPAN id=BacoTitle class=titlename>����: Ȩ����ϸ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
    <FORM style="MARGIN-TOP: 0px" name=frmSearch method=post action="ManageRightDetail.jsp">
    <BUTTON class=btn id=btnSearch accessKey=S name=btnSearch type=submit><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addrightdetail()"><U>A</U>-���</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleterightdetail()"><U>D</U>-ɾ��</BUTTON>
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
                <TD>Ȩ����ϸ����</TD>
                <TD Class=Field colspan=4>
                  <INPUT class=FieldxLong name=searchcon accessKey=Z value="<%=searchcon%>">
                </TD>
            </TR>
            <TR>
                <TD>Ȩ����ϸ�ؼ���</TD>
                <TD Class=Field colspan=4>
                  <INPUT class=FieldxLong name=searchkey accessKey=Z value="<%=searchkey%>">
                </TD>
            </TR>
          </TBODY>
        </TABLE>
	  </form>
      <br>
	  <FORM style="MARGIN-TOP: 0px" name=frmDelete method=post action="RightDetailOperation.jsp">
	  <input type="hidden" name="operation" value="deleterightdetail">
        <TABLE class=Form>
          <COLGROUP> <COL width="8%"> <COL width="22%"> <COL width="22%"> <COL width="22%"><COL width="22%"><TBODY>
          <TR class=Section>
            <TH colSpan=7>�������</TH>
          </TR>
          <TR class=Separator>
            <TD class=sep2 colSpan=7></TD>
          </TR>
          <TR>
            <Td Class=Field></Td>
            <Td Class=Field>��ʶ</Td>
            <Td Class=Field>����</Td>
            <Td Class=Field>Ȩ����ϸ�ؼ���</Td>
            <Td Class=Field>����Ȩ��</Td>
          </TR>
<%
String sqlStr="";
searchkey=searchkey.trim() ;
searchcon=searchcon.trim() ;
sqlStr="select * from SystemRightDetail ";
sqlStr+=" where rightdetailname like '%"+searchcon+"%' ";
if (!searchkey.equals(""))   sqlStr+=" and rightdetail like '%"+searchkey+"%' ";
sqlStr+=" order by rightid ";
RecordSet.executeSql(sqlStr);
while(RecordSet.next())
{
		String id = RecordSet.getString("id");
		String rightdetailname = Util.toScreen(RecordSet.getString("rightdetailname"),user.getLanguage()) ;
        String rightdetail = Util.toScreen(RecordSet.getString("rightdetail"),user.getLanguage()) ;
        String rightname = RightComInfo.getRightname(RecordSet.getString("rightid"),""+user.getLanguage()) ;
%>
         <TR>
            <TD><input type="checkbox" name="delete_rightdetail_id" value="<%=id%>" onClick=unselectall()></TD>
            <TD><%=id%></TD>
            <TD><%=rightdetailname%></TD>
            <TD><%=rightdetail%></TD>
            <TD><%=rightname%></TD>
          </TR>

<%
}
%>
          <TR class=Separator>
            <TD class=sep2 colSpan=7></TD>
          </TR>
		  </TBODY>
        </TABLE>
        <br>
        <input type="checkbox" name="checkall0" onClick="CheckAll(checkall0.checked)" value="ON">ȫ��ѡ��
      </FORM>
<script>
function addrightdetail() {
	location="AddRightDetail.jsp";
}

function deleterightdetail() {
	if(confirmdel())
		document.frmDelete.submit();
}
</script>
      </BODY>
      </HTML>
