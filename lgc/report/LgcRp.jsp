<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdLOG.gif";
String titlename = SystemEnv.getHtmlLabelName(535,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(351,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<DIV class=HdrProps></DIV>

<TABLE class=ViewForm>
  <COLGROUP>
  <COL width="48%">
  <COL width=24>
  <COL width="48%"></COLGROUP>
  <TBODY>
  <TR>
    <TD vAlign=top>
      <TABLE width="100%">
        <TBODY> 
        <TR class=Title> 
          <TH>ͳ��</TH>
        </TR>
        <TR class=Spacing> 
          <TD class=Line1></TD>
        </TR>
        <TR> 
          <TD><A 
            href="LgcRpAssortmentSum.jsp">����</A></TD>
        </TR>
        <TR> 
          <TD><a 
        href="LgcRpAssetTypeSum.jsp">����</a></TD>
        </TR>
        <!-- TR> 
          <TD><a 
        href="http://server-weaver/new/docs/BLRepItems.asp">����</a></TD>
        </TR -->
        <tr> 
          <td><a 
            href="LgcRpAssetResourceSum.jsp">������Դ</a></td>
        </tr>
        <tr> 
          <td><a 
            href="LgcRpAssetDepartmentSum.jsp">����</a></td>
        </tr>
        <TR> 
          <TD><A 
            href="LgcRpAssetConfigueSum.jsp">��������</A></TD>
        </TR>
        </TBODY> 
      </TABLE>
    </TD>
    <TD></TD>
    <TD vAlign=top>
      <TABLE width="100%">
        <TBODY> 
        <TR class=Title> 
          <TH>�ʲ�</TH>
        </TR>
        <TR class=Spacing> 
          <TD class=Line1></TD>
        </TR>
        <tr> 
          <td><a href="/lgc/search/LgcSearch.jsp">����</a></td>
        </tr>
        <TR> 
          <TD><A href="/lgc/asset/LgcStockDetailView.jsp">���</A></TD>
        </TR>
        </TBODY> 
      </TABLE>
    </TD></TR>
  <TR>
    <TD vAlign=top>
      <TABLE width="100%">
        <TBODY></TBODY></TABLE>
      <TABLE width="100%">
        <TBODY> 
        <TR class=Title> 
          <TH>����</TH>
        </TR>
        <TR class=Spacing> 
          <TD class=Line1></TD>
        </TR>
        <TR> 
          <TD><A href="/lgc/sales/LgcWebSales.jsp">���϶���</A></TD>
        </TR>
        </TBODY> 
      </TABLE>
    </TD>
    <TD></TD>
    <TD vAlign=top>
      <!-- TABLE width="100%">
        <TBODY>
        <TR class=Title>
          <TH>�ɹ�</TH></TR>
        <TR class=Spacing>
          <TD class=Line1></TD></TR>
        <TR>
          <TD><A 
            href="http://server-weaver/new/docs/BLTransactions.asp?Topic=P">�ɹ�����</A></TD></TR>
        <TR>
          <TD><A 
        href="http://server-weaver/new/docs/BLPurchase.asp">���ɹ�</A></TD></TR>
        <TR>
          <TD><A 
            href="http://server-weaver/new/docs/BLWorkflow.asp?Topic=P">������: 
            �ɹ�����</A></TD></TR></TBODY></TABLE-->
</TD></TR></TBODY></TABLE></BODY></HTML>
