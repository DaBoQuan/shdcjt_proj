<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<html>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(682,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(60,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<DIV class=HdrProps></DIV>
<TABLE class=Form>
  <COLGROUP> <COL width="48%"> <COL width=24> <COL width="48%"> <TBODY> 
  <TR> 
    <TD vAlign=top> 
      <TABLE width="100%">
        <TBODY> 
        <TR class=Section> 
          <TH>�ʲ�</TH>
        </TR>
        <TR class=Separator> 
          <TD class=sep1></TD>
        </TR>
        <tr> 
          <td><a 
            href="asset/LgcAssetAssortment.jsp">��</a></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcAssortment.jsp">����</a></td>
        </tr>
        </TBODY> 
      </TABLE>
    </TD>
    <TD></TD>
    <TD vAlign=top> 
      <!-- TABLE width="100%">
        <TBODY> 
        <TR class=Section> 
          <TH>��ͬ</TH>
        </TR>
        <TR class=Separator> 
          <TD class=sep2></TD>
        </TR>
        <tr> 
          <td><a 
            href="http://server-weaver/new/docs/BLContractParameters.asp">����</a></td>
        </tr>
        <tr> 
          <td><a 
        href="http://server-weaver/new/docs/BLProcesses.asp">��Ч</a></td>
        </tr>
        <tr> 
          <td><a 
        href="http://server-weaver/new/docs/BLProcesses.asp">����</a></td>
        </tr>
        </TBODY> 
      </TABLE -->
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>����</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcCountType.jsp">���㷽��</a></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcPaymentType.jsp">�ո��ʽ</a></td>
        </tr>
        </tbody> 
      </table>
    </TD>
  </TR>
  <TR> 
    <TD vAlign=top> 
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>����</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td> 
            <p><a 
          href="maintenance/LgcAssetType.jsp">����</a></p>
          </td>
        </tr>
        <tr> 
          <td><a href="maintenance/LgcAssetUnit.jsp">������λ</a></td>
        </tr>
        <tr> 
          <td><a href="maintenance/LgcAssetRelationType.jsp">��������</a></td>
        </tr>
        </tbody> 
      </table>
    </TD>
    <TD></TD>
    <TD vAlign=top>
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>���</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcWarehouse.jsp">�ֿ�</a></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcStockMode.jsp">�����ⷽʽ</a></td>
        </tr>
        <tr> 
          <td><a 
          href="/workflow/request/RequestType.jsp">����</a></td>
        </tr>
        </tbody> 
      </table>
    </TD>
  </TR>
  <TR> 
    <TD vAlign=top> 
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>�б�</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td><a 
          href="catalog/LgcCatalogs.jsp">Ŀ¼</a></td>
        </tr>
        </tbody> 
      </table>
    </TD>
    <TD></TD>
    <TD vAlign=top> 
      <!-- table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>�ɹ�</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td><a 
          href="http://server-weaver/new/docs/BLItemCatalogs.asp">�ɹ���</a></td>
        </tr>
        </tbody> 
      </table -->
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>����</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <tr> 
          <td><a href="sales/LgcWebSales.jsp">�������۵�</a></td>
        </tr>
        </tbody> 
      </table>
    </TD>
  </TR>
  <tr> 
    <td valign=top> 
      <table width="100%">
        <tbody> 
        <tr class=Section> 
          <th>����</th>
        </tr>
        <tr class=Separator> 
          <td class=sep1></td>
        </tr>
        <!-- tr> 
          <td><a 
        href="http://server-weaver/new/docs/BLSettings.asp">�趨</a></td>
        </tr -->
        <tr> 
          <td><a 
          href="maintenance/LgcAttributeMove.jsp">�ƶ�������</a></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcAssortmentMove.jsp">�ƶ�������</a></td>
        </tr>
        <tr> 
          <td><a 
          href="maintenance/LgcAssetmarkChg.jsp">���ģ���ʶ</a></td>
        </tr>
        </tbody> 
      </table>
    </td>
    <td></td>
    <td valign=top>&nbsp; </td>
  </tr>
  </TBODY> 
</TABLE>
</BODY>
</html>
