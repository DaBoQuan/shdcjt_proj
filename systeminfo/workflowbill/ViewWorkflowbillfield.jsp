<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import= "weaver.systeminfo.workflowbill.WorkFlowBillUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
<%
        WorkFlowBillUtil wf = new WorkFlowBillUtil();
	String indexdesc="";
	int billid=0;
	int id;
	id = Util.getIntValue(request.getParameter("id"),0);
	//indexdesc = Util.toScreen(request.getParameter("indexdesc"),user.getLanguage(),"0");
	String sql = "select * from workflow_billfield where id = "+id;
	rs.executeSql(sql);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<script language="javascript">
</script>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>��ϸ��Ϣ: �����������ֶ�</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=workflowbillViewform method=post action="WorkflowbillOperation.jsp">
    <BUTTON class=btn id=btnEdit accessKey=E name=btnEdit onclick="editworkflowbill()"><U>E</U>-�༭</BUTTON>
<%if(Util.getIntValue(user.getSeclevel(),0)>=20){%>
	<BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleteworkflowbillfield()"><U>D</U>-ɾ��</BUTTON>
	<BUTTON class=btn id=btnBack accessKey=B name=btnBack onclick="back()"><U>D</U>-����</BUTTON>
        <input type=hidden name=operation>
        <input type=hidden name=id value="<%=id%>">
<%}%>
    <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY>
          <TR class=Section>
            <TH colSpan=5>�ֶ���Ϣ</TH>
          </TR>
          <TR class=Separator>
            <TD class=sep1 colSpan=5></TD>
          </TR>
<%
while(rs.next()){
	billid = Util.getIntValue(rs.getString("billid"),0);
	int fieldlabel = Util.getIntValue(rs.getString("fieldlabel"),0);
	indexdesc = wf.getLabelByLabelId(fieldlabel);
	String name = rs.getString("fieldname");
	String dbtype = rs.getString("fielddbtype");
	int htmltype = Util.getIntValue(rs.getString("fieldhtmltype"),0);
	int ht = wf.getHtmlType(htmltype);
	int type = wf.getType(htmltype,Util.getIntValue(rs.getString("type"),0));
	int dsporder = Util.getIntValue(rs.getString("dsporder"),0);
	int viewtype = Util.getIntValue(rs.getString("viewtype"),0);
%>

          <TR>
            <TD>�ֶ�id</TD>
            <TD Class=Field><a><%=id%></TD>
          </TR>
          <TR>
            <TD>����id</TD>
            <TD Class=Field><a><%=billid%></TD>
          </TR>
          <TR>
            <TD>�ֶ���</TD>
            <TD Class=Field><%=name%></TD>
          </TR>
          <TR>
            <TD>�ֶ���ʾ����</TD>
            <TD Class=Field><%=indexdesc%></TD>
          </TR>
          <TR>
            <TD>�ֶ����ݿ�����</TD>
            <TD Class=Field><%=dbtype%></TD>
          </TR>
          <TR>
            <TD>�ֶ�ҳ������</TD>
            <TD Class=Field><%=Util.null2String(SystemEnv.getHtmlLabelName(ht,user.getLanguage()))%></TD>
          </TR>
          <TR>
            <TD>�����ֶ�����</TD>
            <TD Class=Field><%=Util.null2String(SystemEnv.getHtmlLabelName(type,user.getLanguage()))%></TD>
          </TR>
          <TR>
            <TD>�ֶ���ʾ˳��</TD>
            <TD Class=Field><%=dsporder%></TD>
          </TR>
          <TR>
            <TD>�������ݿ�����</TD>
            <TD Class=Field>
            <%if(viewtype==0){%>
            main table
            <%}else{%>
            detail table
            <%}%>
            </TD>
          </TR>
<%
}
%>
          </TBODY>
        </TABLE>

</FORM>
<script>
    function editworkflowbill(){
        location = "EditWorkflowbillfield.jsp?id=<%=id%>&indexdesc=<%= indexdesc%>";
    }
    function deleteworkflowbillfield(){
      if(confirm("Are you sure to delete the field?")){
        document.workflowbillViewform.operation.value = "deletefield";
        document.workflowbillViewform.submit();
      }
    }
    function back(){
        location = "ViewWorkflowbill.jsp?id=<%=billid%>";
    }
</script>
</BODY>
</HTML>
