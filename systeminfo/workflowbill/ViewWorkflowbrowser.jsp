<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@ page import="weaver.systeminfo.workflowbill.WorkFlowBillUtil" %>
<jsp:useBean id="bci" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<html>
<%
  WorkFlowBillUtil wf = new WorkFlowBillUtil();
  String sid = request.getParameter("id");
  int id = Util.getIntValue(sid,0);
  
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<script language="javascript">
    function editworkflowbrowser(){
        location = "EditWorkflowbrowser.jsp?id=<%=id%>";
    }
    function deleteworkflowbill(){ 
      if(confirm("do you sure to delete the workflow_bill?")){     
        document.workflowbrowserViewform.operation.value = "delete";      
        document.workflowbrowserViewform.submit();
      }
    }    
    function viewBrowserSQL(){
    	location = "ViewBrowserSql.jsp?id=<%=id%>";
    }
    
    function backSubmit(){
      location = "ManageWorkflowbrowser.jsp";
}
</script>
</head>
<body>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: �����������</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 </TBODY>
</TABLE>
</div>

<DIV class=HdrProps>
</DIV>
<FORM style="MARGIN-TOP: 0px" name=workflowbrowserViewform method=post action="WorkflowbrowserOperation.jsp">
  <BUTTON class=btn id=btnEdit accessKey=E name=btnEdit onclick="editworkflowbrowser()"><U>E</U>-�༭</BUTTON>
<%
 if(Util.getIntValue(user.getSeclevel(),0)>=20){
%>    
  <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleteworkflowbill()"><U>D</U>-ɾ��</BUTTON>        
    <input type=hidden name=operation>
    <input type=hidden name=id value="<%= id %>">
<%
  }
%>
  <BUTTON class=btn id=btnBack accessKey=B name=btnBack onclick="backSubmit()"><U>D</U>-����</BUTTON> 
  <BUTTON class=btn id=btnEdit accessKey=S name=btnEdit onclick="viewBrowserSQL()"><U>E</U>-����SQL</BUTTON>
  <br>
<%
/*  String sql = "select * from workflow_browserurl where id = "+id;  
  rs.executeSql(sql);
  while(rs.next()){
    int labelid = Util.getIntValue(rs.getString("labelid"),0);
    String label = wf.getLabelByLabelId(labelid);
    String dbtype = rs.getString("fielddbtype");
    String url = rs.getString("browserurl");
    String table = rs.getString("tablename");
    String colum = rs.getString("columname");
    String keycolum = rs.getString("keycolumname");
    String linkurl = rs.getString("linkurl");*/
        
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

  <TABLE class=Form>
     <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
     <TR class=Section> 
        <TH colSpan=5>�������Ϣ</TH>
     </TR>
     <TR class=Separator> 
        <TD class=sep1 colSpan=5></TD>
     </TR>          
     <TR> 
        <TD>���</TD>
        <TD Class=Field><%=id%></TD> 
        <input type=hidden name=id value="<%=id%>">       
     </TR>    
     <TR> 
        <TD>����</TD>
        <TD Class=Field><%=label%></TD>                        
     </TR>    
     <TR> 
        <TD>����id</TD>
        <TD Class=Field><%=labelid%></TD>                        
     </TR>    
     <TR> 
        <TD>���ݿ�����</TD>
        <TD Class=Field><%=dbtype%></TD>                
     </TR>    
     <TR> 
        <TD>URL</TD>
        <TD Class=Field><%=url%></TD>                
     </TR>    
     <TR> 
        <TD>��Ӧ����</TD>
        <TD Class=Field><%=table%></TD>                
     </TR>    
     <TR> 
        <TD>���Ӧ�ֶ�</TD>
        <TD Class=Field><%=colum%></TD>                
     </TR>    
     <TR> 
        <TD>��ؼ��ֶ�</TD>
        <TD Class=Field><%=keycolum%></TD>                
     </TR>    
     <TR> 
        <TD>����URL</TD>
        <TD Class=Field><%=linkurl%></TD>               
     </TR>    
<%break;
	  }
%>

  </TABLE>
</body>
</html>
