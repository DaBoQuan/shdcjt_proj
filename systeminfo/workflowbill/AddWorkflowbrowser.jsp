<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
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
    <TD align=left><SPAN id=BacoTitle class=titlename>���: �����������</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

<DIV class=HdrProps>
</DIV>
<FORM style="MARGIN-TOP: 0px" name=addBrowserform method=post action="WorkflowbrowserOperation.jsp">
  <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>S</U>-����</BUTTON>
  <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
  <BUTTON class=btn id=btnBack accessKey=B name=btnBack onclick="backSubmit()"><U>D</U>-����</BUTTON>        
  <br>
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=5>�������Ϣ</TH>
    </TR>
<%
  String errorMsg=Util.null2String(request.getParameter("errorMsg"));
  if(errorMsg.equals("1")) {
%>
    <TR class=Section> 
      <TH colSpan=5>����ID�Ѿ���ռ��,������ѡ��</TH>
    </TR>
<%
  }
%>
    <TR class=Separator> 
      <TD class=sep1 colSpan=5></TD>
    </TR>    
<%
  int id= 0;
  String maxIdSql = "";
  if(rs.getDBType().equals("oracle")){
    maxIdSql="select id from (select id from workflow_browserurl order by id desc) where rownum=1 ";
  }else{
    maxIdSql = "select top 1 id  from workflow_browser order by id desc";
  }
  String  sql = "select max(id) from workflow_browserurl";
  rs.executeSql(sql); 
  if(rs.next()){
    id= Util.getIntValue(rs.getString(1),0);
  } 
  id=id+1;	
%>    
    <TR> 
       <TD>ID</TD>
       <TD Class=Field><%=id%></TD>
       <INPUT  type=hidden name="id" value=<%=id%>>
    </TR>  
    <TR> 
       <TD>����</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=label></TD>
    </TR>
    <TR> 
       <TD>����id</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=labelid></TD>
    </TR>
    <TR> 
       <TD>URL</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=url></TD>
    </TR>
    <TR> 
       <TD>���ݿ�����</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=dbtype></TD>
    </TR>
    <TR> 
       <TD>��Ӧ����</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=table></TD>
    </TR>
    <TR> 
       <TD>���Ӧ�ֶ�</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=colum></TD>
    </TR>
    <TR> 
       <TD>��ؼ��ֶ�</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=keycolum></TD>
    </TR>
    <TR> 
       <TD>����URL</TD>
       <TD Class=Field><INPUT class=FieldxLong accessKey=Z name=linkurl></TD>
    </TR>    
  </TABLE>
  <br>
  <input type=hidden name=operation value="addWorkflowbrowser">
</FORM>
<script language="javascript">
function backSubmit(){
    location = "ManageWorkflowbrowser.jsp";
}
</script>
</body>
</html>