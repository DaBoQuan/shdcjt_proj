<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="HrmUserVarify" class="weaver.hrm.HrmUserVarify" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="FnaDptToKingdeeComInfo" class="weaver.fna.maintenance.FnaDptToKingdeeComInfo" />


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String fromdate = Util.null2String(request.getParameter("fromdate"));
int fromyear = Util.getIntValue(fromdate.substring(0,4));
int fromperiod = Util.getIntValue(fromdate.substring(5));
String enddate = Util.null2String(request.getParameter("enddate"));
int endyear = Util.getIntValue(enddate.substring(0,4));
int endperiod = Util.getIntValue(enddate.substring(5));
int level = Util.getIntValue(request.getParameter("level"),1);
int currency = Util.getIntValue(request.getParameter("currency"),0);
int amountzero = Util.getIntValue(request.getParameter("amountzero"),0);
int transzero = Util.getIntValue(request.getParameter("transzero"),0);
int unposted = Util.getIntValue(request.getParameter("unposted"),0);
int wang=Util.getIntValue(request.getParameter("wang"),0);



String tempid=""+Util.getIntValue(request.getParameter("departmentid"),-1);
String departmentid=""+FnaDptToKingdeeComInfo.getKingdeeCode(tempid);

String resource="";
if(!HrmUserVarify.checkUserRight("ManageFeeDetail:All", user)){ 
    resource=user.getLastname();
}
else {
    String thelevel=HrmUserVarify.getRightLevel("ManageFeeDetail:All",user);
    if(tempid.equals("-1"))
    {
     if (thelevel.equals("0")) departmentid=""+user.getUserDepartment();
     if (thelevel.equals("1")){
         while(DepartmentComInfo.next()){
            String cursubcompanyid = DepartmentComInfo.getSubcompanyid1();
            if(!(""+user.getUserSubCompany1()).equals(cursubcompanyid)) continue;
            String tempdepartment = ""+FnaDptToKingdeeComInfo.getKingdeeCode(DepartmentComInfo.getDepartmentid()) ;
            if(departmentid.equals("")) departmentid = tempdepartment ;
            else departmentid += ","+ tempdepartment ;
        }
    } 
         
    if(thelevel.equals("2")) departmentid="";
    }
}




String ProcPara = "";
String account = "1191";//��Ҫ��¡�ľ����Ŀ���
char flag = 2;
	

ProcPara = ""+fromyear + flag + fromperiod + flag + endyear + flag + endperiod + flag + currency + flag + account + flag + level + flag + departmentid + flag + resource + flag + amountzero + flag + transzero + flag + unposted+flag+wang;

RecordSet.executeProc("sp_ManageFeeDetail",ProcPara,"ecologyjindie");
%>

<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{Excel,/weaver/weaver.file.ExcelOut,_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>
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


<TABLE cellSpacing=0  width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdReport.gif"></TD>
    <TD align=left><SPAN id=BacoTitle style="FONT-WEIGHT: bold; FONT-SIZE: 12pt"><%=SystemEnv.getHtmlLabelName(15407,user.getLanguage())%></SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
    <TD align=middle width=24><BUTTON class=btnFavorite id=BacoAddFavorite 
    title="Add to favorites" ></BUTTON></TD>
	 <TD align=middle width=24><BUTTON class=btnBack id=onBack title="<%=SystemEnv.getHtmlLabelName(15408,user.getLanguage())%>" onclick="javascript:history.back();"></BUTTON></TD>
  </TR>
  </TBODY>
</TABLE>


<table  class=ListStyle  cellSpacing=1  >
  <tr class=Header>
    <!--td width="9%" rowspan="2">��Ŀ</td!-->
    <td width="9%" rowspan="2"><%=SystemEnv.getHtmlLabelName(15409,user.getLanguage())%></td>
    <td width="9%" rowspan="2"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
    <td width="9%" rowspan="2"><%=SystemEnv.getHtmlLabelName(362,user.getLanguage())%></td>
    <td width="16%" colspan="2"><%=SystemEnv.getHtmlLabelName(1810,user.getLanguage())%></td>
    <td width="16%" colspan="2"><%=SystemEnv.getHtmlLabelName(15410,user.getLanguage())%></td>
    <td width="16%" colspan="2"><%=SystemEnv.getHtmlLabelName(15411,user.getLanguage())%></td>
    <td width="16%" colspan="2"><%=SystemEnv.getHtmlLabelName(15412,user.getLanguage())%></td>
  </tr>
  <tr class=Header>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1465,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1466,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1465,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1466,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1465,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1466,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1465,user.getLanguage())%></td>
    <td width="8%"><%=SystemEnv.getHtmlLabelName(1466,user.getLanguage())%></td>
  </tr>
  <tr class="Line2"><td colspan="11"></td></tr>
<%
    ExcelSheet es = new ExcelSheet() ;
    ExcelRow er = es.newExcelRow () ;  
    er.addStringValue(SystemEnv.getHtmlLabelName(15409,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(124,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(362,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1810,user.getLanguage()));
    er.addStringValue("") ;
    er.addStringValue(SystemEnv.getHtmlLabelName(15410,user.getLanguage()));
    er.addStringValue("") ;
    er.addStringValue(SystemEnv.getHtmlLabelName(15411,user.getLanguage())) ;
    er.addStringValue("") ;
    er.addStringValue(SystemEnv.getHtmlLabelName(15412,user.getLanguage())) ;
    er.addStringValue("") ;
    es.addExcelRow(er) ;
   
 	er = es.newExcelRow () ;
    er.addStringValue("") ;
    er.addStringValue("") ;
    er.addStringValue("") ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1465,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1466,user.getLanguage()));
    er.addStringValue(SystemEnv.getHtmlLabelName(1465,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1466,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1465,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1466,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1465,user.getLanguage())) ;
    er.addStringValue(SystemEnv.getHtmlLabelName(1466,user.getLanguage())) ;
  
   es.addExcelRow(er) ;
  
while(RecordSet.next())
{  er = es.newExcelRow () ;
%>
	<%if(RecordSet.getString("FDetailId").trim().equals("0")){%>
  <tr  class=datadark>
    <!--td width="9%"><%=RecordSet.getString("FNumber")%></td!-->
    <td width="9%"><%=RecordSet.getString("FName")%></td>
    <td width="9%">&nbsp;</td>
    <td width="9%">&nbsp;</td>
	<%
	er.addStringValue(RecordSet.getString("FName"));
	er.addStringValue("");
	er.addStringValue("");
	}else{%>
  <tr class=datalight>
    <!--td width="9%">&nbsp;</td!-->
    <td width="9%">&nbsp;</td>
    <td width="9%"><%=RecordSet.getString("FItemName")%></td>
    <td width="9%"><%=RecordSet.getString("FItemName3")%></td>
	<%}
	er.addStringValue("");
	er.addStringValue(RecordSet.getString("FItemName")) ;
  er.addStringValue(RecordSet.getString("FItemName3")) ;
  %>
    <td width="8%"><%if(!RecordSet.getString("FBeginBalanceFord").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FBeginBalanceFord").substring(0,RecordSet.getString("FBeginBalanceFord").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FBeginBalanceFord").substring(0,RecordSet.getString("FBeginBalanceFord").length()-2),3));
    }else{
	er.addStringValue("");
	}%>
    </td>
    
    <td width="8%"><%if(!RecordSet.getString("FBeginBalanceForc").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FBeginBalanceForc").substring(0,RecordSet.getString("FBeginBalanceForc").length()-2),3)%> 
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FBeginBalanceForc").substring(0,RecordSet.getString("FBeginBalanceForc").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FDebitFor").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FDebitFor").substring(0,RecordSet.getString("FDebitFor").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FDebitFor").substring(0,RecordSet.getString("FDebitFor").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FCreditFor").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FCreditFor").substring(0,RecordSet.getString("FCreditFor").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FCreditFor").substring(0,RecordSet.getString("FCreditFor").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FYtdDebitFor").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FYtdDebitFor").substring(0,RecordSet.getString("FYtdDebitFor").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FYtdDebitFor").substring(0,RecordSet.getString("FYtdDebitFor").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FYtdCreditFor").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FYtdCreditFor").substring(0,RecordSet.getString("FYtdCreditFor").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FYtdCreditFor").substring(0,RecordSet.getString("FYtdCreditFor").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FEndBalanceFord").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FEndBalanceFord").substring(0,RecordSet.getString("FEndBalanceFord").length()-2),3)%>
     <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FEndBalanceFord").substring(0,RecordSet.getString("FEndBalanceFord").length()-2),3));
    }else{	er.addStringValue("");}%></td>
    
    <td width="8%"><%if(!RecordSet.getString("FEndBalanceForc").equals("0.0000")){%>
    <%=Util.getFloatStr(RecordSet.getString("FEndBalanceForc").substring(0,RecordSet.getString("FEndBalanceForc").length()-2),3)%>
    <%er.addStringValue(Util.getFloatStr(RecordSet.getString("FEndBalanceForc").substring(0,RecordSet.getString("FEndBalanceForc").length()-2),3));
    }else{	er.addStringValue("");}%></td>
  </tr>
<%
  es.addExcelRow(er) ;
}%>
</table>

<%
 ExcelFile.init() ;
 ExcelFile.setFilename(SystemEnv.getHtmlLabelName(15407,user.getLanguage())) ;
 ExcelFile.addSheet(SystemEnv.getHtmlLabelName(15407,user.getLanguage()), es) ;
 %>
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
