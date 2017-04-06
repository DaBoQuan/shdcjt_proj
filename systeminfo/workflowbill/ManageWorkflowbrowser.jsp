<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.systeminfo.workflowbill.WorkFlowBillUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="bci" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<html>
<%
  WorkFlowBillUtil wf = new WorkFlowBillUtil();
%>
<head>
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<body>
  <DIV class=HdrTitle>
    <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
       <TBODY>
          <TR>
            <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
            <TD align=left><SPAN id=BacoTitle class=titlename>����: �����������</SPAN></TD>
            <TD align=right>&nbsp;</TD>
            <TD width=5></TD>
          <tr>
       </TBODY> 
    </TABLE>
  </DIV>
  <DIV class=HdrProps>
  </DIV>
  
  <FORM style="MARGIN-TOP: 0px" name=workflowbrowserform method=post action="WorkflowbrowserOperation.jsp">
       <BUTTON class=btn id=btnSearch accessKey=S name=btnSearch type=submit onclick="searchworkflowbrowser()"><U>S</U>-����</BUTTON>
       <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
<%
if(Util.getIntValue(user.getSeclevel(),0)>=20){
%>
       <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addworkflowbrowser()"><U>A</U>-���</BUTTON>  
       <input type=hidden name=operation>  
<%
}
%> 	
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
          <TD>��ǩ����</TD>
          <TD Class=Field colspan=4> 
            <input class=text name=searchcon accessKey=Z value="<%=Util.toScreen(request.getParameter("searchcon"),user.getLanguage(),"0")%>">
          </TD>
        </TR>         
     </TABLE>
     <br>
     <TABLE class=ListShort>
       <COLGROUP> <COL width="10%"> <COL width="10%"> <COL width="10%"> <COL width="10%"><TBODY> 
         <TR class=Section> 
           <TH colSpan=5>�������</TH>
         </TR>
         <TR class=Separator> 
           <TD class=sep2 colSpan=4></TD>
         </TR>
       <TR class=Header>             
         <Td> ID </Td>
         <Td> ���� </Td>
         <Td>���ݿ����� </Td>         
         <TD>��Ӧ���� </TD>
         <TD>���Ӧ�ֶ� </TD>
         <TD>��ؼ��ֶ� </TD>         
       </TR>
<!--<%
  String sql = "select * from workflow_browserurl order by id desc";  
  rs.executeSql(sql);
  while(rs.next()){
     int id = Util.getIntValue(rs.getString("id"),0);
     int labelid = Util.getIntValue(rs.getString("labelid"),0);
     String label = wf.getLabelByLabelId(labelid);
     String dbtype = rs.getString("fielddbtype");
     String url = rs.getString("browserurl");
     String table = rs.getString("tablename");
     String colum = rs.getString("columname");
     String keycolum = rs.getString("keycolumname");
     String linkurl = rs.getString("linkurl");
%>
      <TR>
         <TD><a href="ViewWorkflowbrowser.jsp?id=<%=id%>"><%=id%></a></TD>
         <TD><a href="ViewWorkflowbrowser.jsp?id=<%=id%>"><%=label%></a></TD>
         <TD><%=dbtype%></TD>         
         <TD><%=table%></TD>
         <TD><%=colum%></TD>
         <TD><%=keycolum%></TD>         
      </TR>
<%    
  }
%> 
 -->
 
 
<%
  while(bci.next()){
    String id_s = bci.getBrowserid();
    int id = Util.getIntValue(bci.getBrowserid(),0);
%>     
     <TR>
         <TD><a href="ViewWorkflowbrowser.jsp?id=<%=id%>"><%=id%></a></TD>
         <TD><a href="ViewWorkflowbrowser.jsp?id=<%=id%>"><%=wf.getLabelByLabelId(Util.getIntValue(bci.getBrowserlabelid(),0))%></a></TD>
         <TD><%=bci.getBrowserdbtype(id_s)%></TD>         
         <TD><%=bci.getBrowsertablename()%></TD>
         <TD><%=bci.getBrowsercolumname()%></TD>
         <TD><%=bci.getBrowserkeycolumname()%></TD>         
      </TR>     
<%
  }  
%>      
  </FORM>
<script>
function addworkflowbrowser() {        
	location="AddWorkflowbrowser.jsp";
}
function searchworkflowbrowser() {               
	document.workflowbrowserform.operation.value="search";
	document.workflowbrowserform.submit();
}
</script>  
</body>
</html>