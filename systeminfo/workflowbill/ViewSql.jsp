<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: ����������SQL</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>
 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=workflowbillViewSqlform method=post action="WorkflowbillOperation.jsp">
  
  <BUTTON class=btn id=btnBack accessKey=D name=btnBack onclick="backSubmit()"><U>D</U>-����</BUTTON>        
  <br>
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=5>SQL���</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep1 colSpan=5></TD>
    </TR>          

  <input type=hidden name=operation>  
<%
  int id = Util.getIntValue(request.getParameter("id"),0);  
  String indexdesc = Util.fromScreen(request.getParameter("indexdesc"),user.getLanguage());
  String sql = "select * from workflow_bill where id = "+id;
  rs.executeSql(sql);		
  while(rs.next()){
int namelabel = Util.getIntValue(rs.getString("namelabel"),0);
String tablename = rs.getString("tablename")+"";	
String createpageUrl = rs.getString("createpage");
String managepageUrl = rs.getString("managepage");
String viewpageUrl = rs.getString("viewpage");
String detailtablename = rs.getString("detailtablename");
String detailkeyfield = rs.getString("detailkeyfield");
String insertSql = "INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield)  VALUES("+id+","+namelabel+",'"+tablename+"','"+createpageUrl+"','"+managepageUrl+"','"+viewpageUrl+"','"+detailtablename+"','"+detailkeyfield+"') <br>";
%>  
  <TR> 
     
     <TD Class=Field bgcolor="#00ccbb"><%=insertSql%></TD>            
  </TR>
<%
  }
  sql = "select distinct * from workflow_billfield where  billid = "+id+"order by id";  
  rs.executeSql(sql);  
  while(rs.next()){  
	  String name = rs.getString("fieldname");
	  int fieldlabel = Util.getIntValue(rs.getString("fieldlabel"),0);  
	  String dbtype = rs.getString("fielddbtype");
	  int htmltype_int = Util.getIntValue(rs.getString("fieldhtmltype"),0);  
	  int type_int = Util.getIntValue(rs.getString("type"),0);  
	  int dsporder = Util.getIntValue(rs.getString("dsporder"),0);
	  int viewtype_int = Util.getIntValue(rs.getString("viewtype"),0);  
	  String insertFieldSql = "INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype,  fieldhtmltype, type, dsporder, viewtype) VALUES ("+id+",'"+name+"',"+fieldlabel+",'"+dbtype+"',"+htmltype_int+","+type_int+","+dsporder+","+viewtype_int+")<br>";
%>
  
  <TR> 
     
     <TD Class=Field ><%=insertFieldSql%></TD>            
  </TR>
<%
  }
%>  
  <input type=hidden name=id value="<%= id %>">
</body>  
<script language=javascript>
  function backSubmit(){
    location = "ViewWorkflowbill.jsp?id=<%=id%>&indexdesc=<%= indexdesc%>";
  }
  
</script>
</html>