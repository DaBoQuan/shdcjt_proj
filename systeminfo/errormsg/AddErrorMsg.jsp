<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>���: ������Ϣ</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 </TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>
  <FORM style="MARGIN-TOP: 0px" name=frmView method=post action="ErrorMsgOperation.jsp">
    <BUTTON class=btn id=btnSave accessKey=S name=btnSave type=submit><U>E</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
    <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
          <TR class=Section> 
            <TH colSpan=5>������Ϣ��Ϣ</TH>
          </TR>
          <%
            String errorMsg=Util.null2String(request.getParameter("errorMsg"));
            if(errorMsg.equals("1")) {
            
            %>
          <TR class=Section> 
            <TH colSpan=5>������ϢID�Ѿ���ռ��,������ѡ��</TH>
          </TR>
          <%}%>
          <TR> 
            <TD>��ϢID</TD>
            <%
            int id_1= 0;
	String maxIdSql = "";
	if(rs.getDBType().equals("oracle")){
		maxIdSql="select id from (select id from ErrorMsgindex order by id desc) where rownum=1 ";
	}else{
		maxIdSql = "select top 1 id  from ErrorMsgindex order by id desc";
	}
	rs.executeSql(maxIdSql); 
	if(rs.next()){
	   id_1= rs.getInt("id");
	} 
	id_1++;	
            
            %>
            <TD Class=Field><INPUT  name="id_1" value=<%=id_1%>></TD>
          </TR>
          <TR class=Separator> 
            <TD class=sep1 colSpan=5></TD>
          </TR>
          <TR> 
            <TD>����</TD>
            <TD Class=Field><INPUT class=FieldxLong name=indexdesc></TD>
          </TR>
          </TBODY> 
        </TABLE>
        <br>
        <TABLE class=Form>
          <COLGROUP><COL width="50%"> <COL width="50%"> 
          <TR class=Section> 
            <TH colSpan=2>������Ϣ����</TH>
          </TR>
          <TR class=Separator> 
            <TD class=sep2 colSpan=2></TD>
          </TR>
          <TR> 
            <Td Class=Field>����</Td>
            <Td Class=Field>������Ϣ����</Td>
          </TR>
       


<%
String lanSql="select * from syslanguage";
rs.executeSql(lanSql);
while(rs.next()){
	String langid = rs.getString("id");
	//String langname = Util.toScreen(LanguageComInfo.getLanguagename(),user.getLanguage());
	String langname =rs.getString("language");
%>
          <TR> 
            <Td><%=langname%></Td>
            <Td><INPUT class=FieldLong name="errormsgname<%=langid%>"></Td>
          </TR>
<%
}
%>
<input type="hidden" name="operation" value="adderrormsg">
</TABLE>

      </FORM>
      </BODY>
      </HTML>
