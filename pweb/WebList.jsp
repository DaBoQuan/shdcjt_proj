<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="weaver.general.Util" %>
<jsp:useBean id="DocNewsComInfo" class="weaver.docs.news.DocNewsComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>

<BODY background="/images_frame/left_bg1.gif" bgcolor=#999999>

<br>

<TABLE class=ListShort>
  <TBODY>

  <%

while(DocNewsComInfo.next()) {
	String id=DocNewsComInfo.getDocNewsid();
	String name = DocNewsComInfo.getDocNewsname();
	String status = DocNewsComInfo.getDocNewsstatus();
	String publishtype = DocNewsComInfo.getPublishtype();
	if(!publishtype.equals("0")) continue;
	if(!status.equals("1")) continue;
%> 
  <TR>
  <td>
		<li><a href="/pweb/WebDsp.jsp?id=<%=id%>&isrequest=Y" target="mainFrame_sub"><%=name%></a>
  </td>
  </tr>
<%
}
%> 
 <TR>
  <td>
		<li><a href="/pweb/careerapply/HrmCareerInviteWeb.jsp" target="mainFrame_sub">��Ƹ��Ϣ</a>
  </td>
  </tr>
 </table></BODY></HTML>
