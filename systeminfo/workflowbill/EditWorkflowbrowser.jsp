<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.systeminfo.workflowbill.WorkFlowBillUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="bci" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<%
if(Util.getIntValue(user.getSeclevel(),0)<20){
 	response.sendRedirect("ManageWorkflowbill.jsp");
}   
%>
<html>
<head>
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
</head>
<body>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>�༭: ���������������</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 </TBODY>
</TABLE>
</div>
<DIV class=HdrProps>
</DIV>
<FORM style="MARGIN-TOP: 0px" name=workflowbrowseredit method=post action="WorkflowbrowserOperation.jsp">
  <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>-����</BUTTON>
  <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
  <BUTTON class=btn id=btnBack accessKey=B name=btnBack onclick="backSubmit()"><U>D</U>-����</BUTTON>
  <br>
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=5>�������Ϣ</TH>
    </TR>          
    <TR class=Separator> 
       <TD class=sep1 colSpan=5></TD>
    </TR>
<%
String sid = request.getParameter("id");
int id = Util.getIntValue(sid,0);
WorkFlowBillUtil wf = new WorkFlowBillUtil();
/*String sql = "select * from workflow_browserurl where id = "+id;
rs.executeSql(sql);
while(rs.next()){
   int labelid = Util.getIntValue(rs.getString("labelid"),0);
   String label = wf.getLabelByLabelId(labelid);
   String dbtype = rs.getString("fielddbtype");	
   String url = rs.getString("browserurl");
   String table = rs.getString("tablename");
   String colum = rs.getString("columname");
   String keycolum = rs.getString("keycolumname");
   String linkurl = rs.getString("linkurl");            */
   
   while(bci.next()){                      
    int labelid = Util.getIntValue(bci.getBrowserlabelid(sid),0);
    String label = wf.getLabelByLabelId(labelid);
    String dbtype = bci.getBrowserdbtype(sid);
    String url = bci.getBrowserurl(sid);
    String table = bci.getBrowsertablename(sid);
    String colum = bci.getBrowsercolumname(sid);
    String keycolum = bci.getBrowserkeycolumname(sid);
    String linkurl = bci.getLinkurl(sid);

%>
   <TR> 
       <TD>ID</TD>
       <TD Class=Field><%=id%></TD>
       <INPUT  type=hidden name="id" value=<%=id%>>
    </TR>  
    <TR> 
       <TD>����</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=label value=<%=label%> ></TD>
    </TR>
    <TR> 
       <TD>����id</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=labelid value=<%=labelid%> ></TD>
    </TR>
    <TR> 
       <TD>URL</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=url value=<%=url%>> </TD>
    </TR>
    <TR> 
       <TD>���ݿ�����</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=dbtype value=<%=dbtype%>> </TD>
    </TR>
    <TR> 
       <TD>��Ӧ����</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=table value=<%=table%>> </TD>
    </TR>
    <TR> 
       <TD>���Ӧ�ֶ�</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=colum value=<%=colum%>> </TD>
    </TR>
    <TR> 
       <TD>��ؼ��ֶ�</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=keycolum value=<%=keycolum%>> </TD>
    </TR>
    <TR> 
       <TD>����URL</TD>
       <TD Class=Field><INPUT class=FieldxLong  name=linkurl value=<%=linkurl%>></TD>
    </TR>
<%
  break;
  }
  bci.removeBrowserCache();
%>    
  </TABLE>
  <br>
<input type=hidden name=operation value=editWorkflowbrowser> 
<script language="javascript">
function backSubmit(){
    location = "ViewWorkflowbrowser.jsp?id=<%=id%>";
}
</script>   
</FORM>
</body>
</html>