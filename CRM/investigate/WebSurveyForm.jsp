<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=gbk" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
    String imagefilename = "/images/hdHRM.gif";
    String titlename = Util.toScreen("���յ�������",user.getLanguage(),"0");
    String needfav = "1" ;
    String needhelp = "" ;
    String sql = "" ;
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

 <TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="40%">
  <COL width="60%">
  <TBODY>
  <TR class=Header>
    <TD>���������</TD>
    <TD>����ʱ��</TD>
  </TR>
  <TR class=Line><TD colSpan=2></TD></TR>
<%
    String rsearchname = "" ;
    int countfrom = 0 ;
    int fromcount = 0 ;
    int countfade = 0 ;
    int needchange = 0;
    String inprepid = "";
    String inputid = "" ;
	String rsearchdate = "" ;
    sql = " select * from T_ResearchTable order by inputid desc";
    rs.executeSql(sql);
    while(rs.next()){
        inputid = rs.getString("inputid");
        inprepid = rs.getString("inprepid");
        rsearchname = rs.getString("rsearchname");
		rsearchdate = rs.getString("rsearchdate");
        countfrom = Util.getIntValue(rs.getString("countfrom"),0);
        fromcount = Util.getIntValue(rs.getString("fromcount"),0);
        countfade = Util.getIntValue(rs.getString("countfade"),0);
               
        if(needchange ==0){
            needchange = 1;

%>
            <TR class=datalight>
<%
        }else{
  		    needchange=0;
%>          <TR class=datadark>
<%
        }
%>
    <TD><a href="/CRM/investigate/WebCountForm.jsp?inprepid=<%=inprepid%>&inputid=<%=inputid%>"><%=rsearchname%></a></TD>
    <TD>
	<%=rsearchdate%>
	</TD>
  </TR>
<%
    }
%>  
</TBODY>
</TABLE>

		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
</BODY>
</HTML>