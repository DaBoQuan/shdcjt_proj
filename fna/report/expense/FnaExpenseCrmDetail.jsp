<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ page import="weaver.fna.budget.BudgetHandler"%>
<%@ page import="weaver.fna.budget.PeriodExpense"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="FnaBudgetInfoComInfo" class="weaver.fna.maintenance.FnaBudgetInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet4" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<style>
#tabPane tr td{padding-top:2px}
#monthHtmlTbl td,#seasonHtmlTbl td{cursor:hand;text-align:center;padding:0 2px 0 2px;color:#333;text-decoration:underline}
.cycleTD{font-family:MS Shell Dlg,Arial;background-image:url(/images/tab2.png);cursor:hand;font-weight:bold;text-align:center;color:#666;border-bottom:1px solid #879293;}
.cycleTDCurrent{font-family:MS Shell Dlg,Arial;padding-top:2px;background-image:url(/images/tab.active2.png);cursor:hand;font-weight:bold;text-align:center;color:#666}
.seasonTDCurrent,.monthTDCurrent{color:black;font-weight:bold;background-color:#CCC}
#subTab{border-bottom:1px solid #879293;padding:0}
#goalGroupStatus{text-align:center;color:black;font-weight: bold}
</style>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>


<%
//System.out.println("-----------------------");
String crmid = Util.null2String(request.getParameter("crmid"));
//System.out.println("crmidCRM:"+crmid);
int custoridss = Util.getIntValue(request.getParameter("custoridss"));
//System.out.println("custoridss*********:"+custoridss);

String budgetperiods = Util.null2String(request.getParameter("budgetperiods"));//�ڼ�ID

String fnayear = "";//�ڼ���

String sqlstr = "";
char separator = Util.getSeparator() ;
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);

//����ڼ�Ϊ��
if("".equals(budgetperiods)) {
	//ȡǰһ�β������ڼ�
	budgetperiods = (String)session.getAttribute("budgetperiods");
	//System.out.println("session budgetperiods:"+budgetperiods);
	if(budgetperiods==null||"".equals(budgetperiods)){
		//���δȡ����ȡ��Ĭ����Ч�ڼ�
		sqlstr =" select id from FnaYearsPeriods where status = 1 ";
		RecordSet.executeSql(sqlstr);
		if(RecordSet.next()) {
			budgetperiods = RecordSet.getString("id");
		} else {
			//���δȡ����ȡ�����
			RecordSet.executeProc("FnaYearsPeriods_SelectMaxYear","");
			if(RecordSet.next()){
				budgetperiods = RecordSet.getString("id");
			}
		}
		//System.out.println("empty budgetperiods:"+budgetperiods);
	}
} else {
	session.setAttribute("budgetperiods",budgetperiods);
}
//ȡ��ǰ�ڼ�����
if("".equals(fnayear)) {
	sqlstr = " select fnayear from FnaYearsPeriods where id = " + budgetperiods;
	RecordSet.executeSql(sqlstr);
	if(RecordSet.next()) {
		fnayear = RecordSet.getString("fnayear");
	}
}

//ȡԤ���ڼ����(Ԥ����Ƚ���ʾ����Ч���͡��رա�״̬��Ԥ�����)
List budgetperiodsList = new ArrayList();
List budgetyearsList = new ArrayList();
sqlstr ="select id,fnayear from FnaYearsPeriods where status in (0,1) order by fnayear desc" ;
RecordSet.executeSql(sqlstr);
while(RecordSet.next()) {
	String tempid = Util.null2String(RecordSet.getString(1));
	String tempfnayear = Util.null2String(RecordSet.getString(2));
	budgetperiodsList.add(tempid);
	budgetyearsList.add(tempfnayear);
}

double tmpnum = 0d;
double tmpnum1 =0d;
double tmpnum2 =0d;

ArrayList startdates = new ArrayList() ;
ArrayList enddates = new ArrayList() ;
ArrayList feetypeperiods = new ArrayList() ;
HashMap feecircle = new HashMap() ;
ArrayList periodstartdates = new ArrayList() ;
ArrayList periodenddates = new ArrayList() ;

ArrayList budgettypeperiods = new ArrayList() ;
ArrayList budgetaccounts = new ArrayList() ;
ArrayList expensetypeperiods = new ArrayList() ;
ArrayList expenseaccounts = new ArrayList() ;

RecordSet.executeSql("select startdate, enddate from FnaYearsPeriodsList where fnayear= '"+fnayear+"' order by Periodsid ");
while( RecordSet.next() ) {
    startdates.add( Util.null2String(RecordSet.getString( "startdate" ) ) ) ;
    enddates.add( Util.null2String(RecordSet.getString( "enddate" ) ) ) ;
}

if (startdates.isEmpty() || enddates.isEmpty() || enddates.size()<12)
        response.sendRedirect("/notice/MissingInfo.jsp") ;

String fnayearstartdate = (String) startdates.get(0) ;
String fnayearenddate = (String) enddates.get(11) ;

RecordSet.executeSql("select id, feeperiod , agreegap from FnaBudgetfeeType where feelevel = 1 ");
while( RecordSet.next() ) {
    String tempfeetypeid = Util.null2String(RecordSet.getString( "id" ) ) ;
    int tempfeeperiod = Util.getIntValue(RecordSet.getString( "feeperiod" ) , 1 ) ;
    feecircle.put(""+tempfeetypeid,""+tempfeeperiod);
    switch( tempfeeperiod ) {
        case 1 :
            for(int i=1 ; i<13; i++) {
                String tempperiodstartdate = (String) startdates.get(i-1) ;
                String tempperiodenddate = (String) enddates.get(i-1) ;
                feetypeperiods.add(tempfeetypeid+"_"+i) ;
                periodstartdates.add(tempfeetypeid+"_"+tempperiodstartdate) ;
                periodenddates.add(tempfeetypeid+"_"+tempperiodenddate) ;
            }
            break ;
        case 2 :
            for(int i=1 ; i<5; i++) {
                String tempperiodstartdate = (String) startdates.get((i-1)*3) ;
                String tempperiodenddate = (String) enddates.get(i*3-1) ;
                feetypeperiods.add(tempfeetypeid+"_"+i) ;
                periodstartdates.add(tempfeetypeid+"_"+tempperiodstartdate) ;
                periodenddates.add(tempfeetypeid+"_"+tempperiodenddate) ;
            }
            break ;
        case 3 :
            for(int i=1 ; i<3; i++) {
                String tempperiodstartdate = (String) startdates.get((i-1)*6) ;
                String tempperiodenddate = (String) enddates.get(i*6-1) ;
                feetypeperiods.add(tempfeetypeid+"_"+i) ;
                periodstartdates.add(tempfeetypeid+"_"+tempperiodstartdate) ;
                periodenddates.add(tempfeetypeid+"_"+tempperiodenddate) ;
            }
            break ;
        case 4 :
            String tempperiodstartdate = (String) startdates.get(0) ;
            String tempperiodenddate = (String) enddates.get(11) ;
            feetypeperiods.add(tempfeetypeid+"_1") ;
            periodstartdates.add(tempfeetypeid+"_"+tempperiodstartdate) ;
            periodenddates.add(tempfeetypeid+"_"+tempperiodenddate) ;
            break ;
    }
}

/*sqlstr =" select budgettypeid, budgetperiods , sum(budgetaccount) as budgetaccount from FnaBudgetInfoDetail where budgetcrmid =" + crmid + " and budgetstartdate >= '" +fnayearstartdate+ "' and budgetenddate<= '" +fnayearenddate+ "' group by budgettypeid, budgetperiods " ;

RecordSet.executeSql(sqlstr);
while(RecordSet.next()){
    String tempbudgettypeid = Util.null2String(RecordSet.getString(1)) ;
    String tempbudgetperiods = Util.null2String(RecordSet.getString(2)) ;
    String tempaccount = "" + Util.getDoubleValue(RecordSet.getString(3),0) ;

    if(tempaccount.equals("0")) continue ;

    budgettypeperiods.add(tempbudgettypeid + "_" + tempbudgetperiods ) ;
    budgetaccounts.add( tempaccount ) ;
}*/


HashMap map=BudgetHandler.getExpenseRecursion(fnayear,0,0,0,Util.getIntValue(crmid),0);
Set set=map.keySet();
for(Iterator i=set.iterator();i.hasNext();){
  String tempfeetypeid=(String)  i.next() ;
  
  RecordSet.executeSql("select supsubject from FnaBudgetfeeType where feelevel = 2 and id = (select supsubject from FnaBudgetfeeType where feelevel = 3 and id = " + tempfeetypeid+")");
  RecordSet.next();
  String tempsuptypeid = Util.null2String(RecordSet.getString("supsubject"));
  
  if( feecircle.get( ""+tempsuptypeid) ==null ) continue ;
  String tempfeecircle=(String)feecircle.get(""+tempsuptypeid);
  
  PeriodExpense[] expenses=(PeriodExpense[])map.get(tempfeetypeid) ;
  if(expenses==null) continue;
  switch(Util.getIntValue(tempfeecircle)){
      case 1:
          for (int c=0;c<12;c++) {
              try {
                  expensetypeperiods.add( tempfeetypeid + "_" + (c+1)) ;
                  expenseaccounts.add( "" + (expenses[c].getExpense().getRealExpense()) ) ;
              } catch (Exception e) {
                  //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
              }
          }
          break;
      case 2:
          for (int c=0;c<4;c++) {
              try {
                  expensetypeperiods.add( tempfeetypeid + "_" + (c+1)) ;
                  double exp=expenses[0+3*c].getExpense().getRealExpense()+expenses[1+3*c].getExpense().getRealExpense()+expenses[2+3*c].getExpense().getRealExpense();
                  expenseaccounts.add( "" + exp ) ;
              } catch (Exception e) {
                  //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
              }
          }
          break;
      case 3:
          for (int c=0;c<2;c++) {
              try {

                  expensetypeperiods.add( tempfeetypeid + "_" + (c+1)) ;
                  double exp=expenses[0+6*c].getExpense().getRealExpense()+expenses[1+6*c].getExpense().getRealExpense()+expenses[2+6*c].getExpense().getRealExpense()+
                          expenses[3+6*c].getExpense().getRealExpense()+expenses[4+6*c].getExpense().getRealExpense()+expenses[5+6*c].getExpense().getRealExpense();
                  expenseaccounts.add( "" +exp ) ;
              } catch (Exception e) {
                  //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
              }
          }
          break;
      case 4:
          try {
                  expensetypeperiods.add( tempfeetypeid + "_" + 1) ;
                  double exp=expenses[0].getExpense().getRealExpense()+expenses[1].getExpense().getRealExpense()+expenses[2].getExpense().getRealExpense()+
                          expenses[3].getExpense().getRealExpense()+expenses[4].getExpense().getRealExpense()+expenses[5].getExpense().getRealExpense()+
                          expenses[6].getExpense().getRealExpense()+expenses[7].getExpense().getRealExpense()+expenses[8].getExpense().getRealExpense()
                          +expenses[9].getExpense().getRealExpense()+expenses[10].getExpense().getRealExpense()+expenses[11].getExpense().getRealExpense();
                  expenseaccounts.add( "" + exp) ;
              } catch (Exception e) {
                  //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
              }
          break;
  }
}
if (!fnayearstartdate.equals("")&&!fnayearenddate.equals("")) {
sqlstr =" select feetypeid , amount , occurdate from FnaAccountLog where iscontractid=1 and occurdate >= '"+ fnayearstartdate + "' and occurdate <= '"+ fnayearenddate +"' and crmid = " + crmid ;
}
else if (!fnayearstartdate.equals(""))
{
sqlstr =" select feetypeid , amount , occurdate from FnaAccountLog where iscontractid=1 and occurdate >= '"+ fnayearstartdate + "'  and crmid = " + crmid ;
}
else 
{
sqlstr =" select feetypeid , amount , occurdate from FnaAccountLog where iscontractid=1 and   occurdate <= '"+ fnayearenddate +"' and crmid = " + crmid ;
}
RecordSet.executeSql(sqlstr);
    while(RecordSet.next()){
    String tempfeetypeid = Util.null2String(RecordSet.getString(1)) ;
	double tempaccount = Util.getDoubleValue(RecordSet.getString(2),0) ;
	String tempoccurdate = Util.null2String(RecordSet.getString(3)) ;
	
	if( tempaccount == 0 ) continue ;

	RecordSet2.executeSql("select supsubject from FnaBudgetfeeType where feelevel = 2 and id = (select supsubject from FnaBudgetfeeType where feelevel = 3 and id = " + tempfeetypeid+")");
	RecordSet2.next();
	String tempsuptypeid = Util.null2String(RecordSet2.getString("supsubject"));
	
    for( int i= 0 ; i < periodstartdates.size() ; i++ ) {
        String tempperiodstartdate = (String) periodstartdates.get(i) ;
        String tempperiodenddate = (String) periodenddates.get(i) ;
        if(!tempperiodstartdate.startsWith(tempsuptypeid+"_")&&!tempperiodenddate.startsWith(tempsuptypeid+"_")) continue;
        tempperiodstartdate = Util.StringReplace(tempperiodstartdate,tempsuptypeid+"_","");
        tempperiodenddate = Util.StringReplace(tempperiodenddate,tempsuptypeid+"_","");
        
        if ( tempoccurdate.compareTo(tempperiodstartdate) >=0 && tempoccurdate.compareTo(tempperiodenddate) <=0 ) {
            String feetypeperiod = (String)feetypeperiods.get(i) ;
            if( feetypeperiod.indexOf( tempsuptypeid + "_" ) != 0 ) continue ;

            String currentperiod = Util.StringReplace(feetypeperiod,tempsuptypeid + "_", "") ;
            int expensetypeperiodindex = expensetypeperiods.indexOf(tempfeetypeid + "_" + currentperiod ) ;
            if( expensetypeperiodindex == -1 ) {
                expensetypeperiods.add( tempfeetypeid + "_" + currentperiod ) ;
                expenseaccounts.add( "" + tempaccount ) ;
            }
            else {
                double tempperaccount = Util.getDoubleValue( (String)expenseaccounts.get(expensetypeperiodindex) , 0 ) ;
                tempaccount += tempperaccount ;
                expenseaccounts.set( expensetypeperiodindex , "" + tempaccount ) ;
            }
            break ;
        }
    }
}

String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(428,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(2121,user.getLanguage())+",javascript:submitBudget(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/fna/report/expense/FnaExpenseProject.jsp,_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
if(custoridss==1){
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:comeBack("+crmid+"),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
if(custoridss!=1){
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/fna/report/expense/FnaExpenseCrm.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
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

<FORM id="frmMain" name="frmMain" action="FnaExpenseCrmDetail.jsp" method=post>
<input type=hidden name=crmid value="<%=crmid%>">

<!--��ͷ ��ʼ-->

<TABLE class ="ViewForm">
	<TBODY>
	<colgroup>
    <col width="40%">
    <col width="20%">
    <col width="40%">
    </colgroup>
    <tr>
      <td></td>

      <td></td>

      <td align=right></td>
    </tr>

	<TR style="height: 1px;"><TD class=Line colSpan=3></TD></TR>

 	<TR>
        <td colSpan=3><%=SystemEnv.getHtmlLabelName(15365,user.getLanguage())%>:
		<select name="budgetperiods" onChange="onChangeFnaYear(this);">
		<%for(int i=0;i<budgetyearsList.size();i++){%>
			<option value="<%=budgetperiodsList.get(i)%>"<%if(budgetperiods.equals((String)budgetperiodsList.get(i))) out.print("selected");%>><%=budgetyearsList.get(i)%></option>
		<%}%>
		</select>
	  </td>
   </TR>


    <TR style="height: 1px;"><TD class=Line colSpan=3></TD></TR>

    </TBODY>
  </TABLE>
</FORM>

<!--��ͷ ����-->

<table width="100%" border=0 cellspacing=0 cellpadding=0 id="tabPane">
<colgroup>
<col width="79"></col>
<col width="79"></col>
<col width="79"></col>
<col width="79"></col>
<col width="*"></col>
</colgroup>
<tr height="20">
	<td class="cycleTD" onClick="setGoal(this,monthbudgetlisttable);"><%=SystemEnv.getHtmlLabelName(15428,user.getLanguage())%></td>
	<td class="cycleTD" onClick="setGoal(this,quarterbudgetlisttable);"><%=SystemEnv.getHtmlLabelName(15429,user.getLanguage())%></td>
	<td class="cycleTD" onClick="setGoal(this,halfyearbudgetlisttable);"><%=SystemEnv.getHtmlLabelName(15430,user.getLanguage())%></td>
	<td class="cycleTD" onClick="setGoal(this,yearbudgetlisttable);"><%=SystemEnv.getHtmlLabelName(15431,user.getLanguage())%></td>
	<td id="subTab" style="text-align:right;">&nbsp;</td>
</tr>
</table>

<table width=100% style="border-right:1px solid #879293;border-bottom:1px solid #879293;border-left:1px solid #879293;padding:10px;padding-right:0">
	<tr><td align=center valign=top>

<!--�¶�Ԥ�� ��ʼ-->

<TABLE width=100% class=ListStyle cellspacing=1 id="monthbudgetlisttable" style="display:block">
  <COLGROUP>
    <col width="70">
    <col width="70">
    <col width="70">
    <!--<col width="80">-->
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
    <col width="4%">
  <THEAD>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(18424,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18425,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18426,user.getLanguage())%></th>
  <%--<th>&nbsp;</th>--%>
  <th>1<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>2<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>3<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>4<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>5<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>6<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>7<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>8<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>9<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>10<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>11<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>12<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(1013,user.getLanguage())%></th>
  </tr>
  <TR class=Line style="height: 1px;"><TD colspan="16" ></TD></TR>
  </THEAD>
<%
	boolean isFirest = false;
	boolean isSecond = false;
	boolean isThird = false;

	//ȡ���¶�һ����Ŀ
        RecordSet.executeSql(" select id,name from FnaBudgetfeeType where feeperiod = 1 and feelevel = 1 order by name");
	while(RecordSet.next()) {
        String firestlevelid = Util.null2String(RecordSet.getString("id")) ;
        String firestlevelname = Util.toScreen(RecordSet.getString("name"),user.getLanguage()) ;
        isFirest = true;

        RecordSet4.executeSql("select count(*) as counts from FnaBudgetfeeType where  supsubject in (select id from FnaBudgetfeeType where supsubject = "+firestlevelid+")");
        RecordSet4.next();

        //ȡ�ø�һ����Ŀ�µĶ�����Ŀ
                RecordSet2.executeSql(" select id,name from FnaBudgetfeeType where feelevel = 2 and supsubject = " + firestlevelid);
		while(RecordSet2.next()) {
	        String secondlevelid = Util.null2String(RecordSet2.getString("id")) ;
	        String secondlevelname = Util.toScreen(RecordSet2.getString("name"),user.getLanguage()) ;
	        isSecond = true;

	        //ȡ�øö�����Ŀ�µ�������Ŀ
		    RecordSet3.executeSql(" select a.id,a.name,a.alertvalue from FnaBudgetfeeType"
		    +" a where "
		    +"  a.feelevel = 3 and a.supsubject = " + secondlevelid

		    );
			while(RecordSet3.next()) {
		        String thirdlevelid = Util.null2String(RecordSet3.getString("id"));
		        String thirdlevelname = Util.toScreen(RecordSet3.getString("name"),user.getLanguage());
                        double alertvalue = (new Double(Util.null2o(RecordSet3.getString("alertvalue")))).doubleValue()/100;
		        isThird = !isThird;
%>
	<TR>
<%
				if(isFirest) {
					isFirest = false;
%>
        <TD bgcolor="#EFEFEF" rowspan=<%=RecordSet4.getString("counts")%>><%=firestlevelname%></TD>
<%
				}
				if(isSecond) {
					isSecond = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()%>"><%=secondlevelname%></TD>
<%
				}
%>
        <TD bgcolor="#EFEFEF"><a href="#" onClick="return submitBudget(<%=thirdlevelid%>)"><%=thirdlevelname%></a></TD>
        <%--<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr height=20 class=datadark><td nowrap><%=SystemEnv.getHtmlLabelName(386,user.getLanguage())%></td></tr>
        	<tr height=20 class=datalight><td nowrap><%=SystemEnv.getHtmlLabelName(628,user.getLanguage())%></td></tr>
        	<tr height=20  CLASS=Total STYLE="COLOR:RED;FONT-WEIGHT:BOLD"><td nowrap><%=SystemEnv.getHtmlLabelName(15368,user.getLanguage())%></td></tr>
            </table>
        </TD>--%>
<%
				double tmpSum=0d,tmpSum1=0d,tmpSum2=0d,tmpSum3=0d;

				for(int j=1;j<13;j++){
					tmpnum = 0d;tmpnum1 = 0d;tmpnum2 = 0d;
%>
		<TD>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<%--<tr height=20 class=datadark><td nowrap align=right>
<%
					tmpnum1 = 0;
					tmpSum1 += tmpnum1;
					out.print(tmpnum1);
%>
				</td></tr>--%>
				<tr height=20 class=datadark><td nowrap align=right>
                    <%

                        int accountindex = expensetypeperiods.indexOf(thirdlevelid + "_" + j);
                        if (accountindex != -1) {
                            double tempexpense = Util.getDoubleValue((String) expenseaccounts.get(accountindex), 0);
                            tmpnum = (new BigDecimal(tempexpense)).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_DOWN).doubleValue();
                            if (tmpnum != 0)
                                tmpSum3 += tempexpense;
                        }

                        out.print("<font color=");
                        if ((tmpnum > (tmpnum1 * alertvalue)) && (tmpnum < tmpnum1)) out.print("ORANGE");
                        else if (tmpnum > tmpnum1) out.print("RED");
                        else out.print("BLACK");
                        out.print(">");
                        out.print(tmpnum);
                        out.print("</font>");
                    %>
				</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpSum2 =  (tmpnum - tmpnum1) * 100 / tmpnum1 ;
                    int tmptgapint = (new Double( tmpSum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
            </table>
		</TD>
<%
				}
%>
		<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        	<%--<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print(tmpSum1);
                            %>
	        	</td></tr>--%>
	        	<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print("<font color=");
                            if((tmpSum3>(tmpSum1*alertvalue))&&(tmpnum<tmpnum1)) out.print("ORANGE");
                            else if(tmpSum3>tmpSum1) out.print("RED");
                            else out.print("BLACK");
                            out.print(">");
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum3));
                            out.print("</font>");
                             %>
	        	</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpnum2 =  (tmpSum3 - tmpSum1) * 100 / tmpSum1 ;
                    int tmptgapint = (new Double( tmpnum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
        	</table>
		</TD>
	</TR>
<%
			}
		}
	}
%>
	<TR class=Line style="height: 1px;"><TD colspan="16" ></TD></TR>
  </TBODY>
</TABLE>


<!--�¶�Ԥ�� ����-->
<!--����Ԥ�� ��ʼ-->

<TABLE width=100% class=ListStyle cellspacing=1 id="quarterbudgetlisttable" style="display:none">
  <COLGROUP>
    <col width="70">
    <col width="70">
    <col width="70">
    <!--<col width="80">-->
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
  <THEAD>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(18424,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18425,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18426,user.getLanguage())%></th>
<!--<th>&nbsp;</th>-->
  <th>1<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>2<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>3<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>4<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(1013,user.getLanguage())%></th>
  </tr>
  <TR class=Line style="height: 1px;"><TD colspan="8" ></TD></TR>
  </THEAD>
<%
	isFirest = false;
	isSecond = false;
	isThird = false;

	//ȡ���¶�һ����Ŀ
    RecordSet.executeSql(" select id,name from FnaBudgetfeeType where feeperiod = 2 and feelevel = 1 order by name");
	while(RecordSet.next()) {
        String firestlevelid = Util.null2String(RecordSet.getString("id")) ;
        String firestlevelname = Util.toScreen(RecordSet.getString("name"),user.getLanguage()) ;
        isFirest = true;

        //ȡ�ø�һ����Ŀ�µĶ�����Ŀ
	    RecordSet2.executeSql(" select id,name from FnaBudgetfeeType where feelevel = 2 and supsubject = " + firestlevelid);
		while(RecordSet2.next()) {
	        String secondlevelid = Util.null2String(RecordSet2.getString("id")) ;
	        String secondlevelname = Util.toScreen(RecordSet2.getString("name"),user.getLanguage()) ;
	        isSecond = true;

	        //ȡ�øö�����Ŀ�µ�������Ŀ
		    RecordSet3.executeSql(" select a.id,a.name from FnaBudgetfeeType"
		    +" a where "
		    +" a.feelevel = 3 and a.supsubject = " + secondlevelid

		    );
			while(RecordSet3.next()) {
		        String thirdlevelid = Util.null2String(RecordSet3.getString("id"));
		        String thirdlevelname = Util.toScreen(RecordSet3.getString("name"),user.getLanguage());
                        double alertvalue = (new Double(Util.null2o(RecordSet3.getString("alertvalue")))).doubleValue()/100;
		        isThird = !isThird;
%>
	<TR>
<%
				if(isFirest) {
					isFirest = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()*RecordSet2.getCounts()%>"><%=firestlevelname%></TD>
<%
				}
				if(isSecond) {
					isSecond = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()%>"><%=secondlevelname%></TD>
<%
				}
%>
        <TD bgcolor="#EFEFEF"><a href="#" onClick="return submitBudget(<%=thirdlevelid%>)"><%=thirdlevelname%></a></TD>
        <%--<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr height=20 class=datadark><td nowrap><%=SystemEnv.getHtmlLabelName(386,user.getLanguage())%></td></tr>
        	<tr height=20 class=datalight><td nowrap><%=SystemEnv.getHtmlLabelName(628,user.getLanguage())%></td></tr>
            <tr height=20  CLASS=Total STYLE="COLOR:RED;FONT-WEIGHT:BOLD"><td nowrap><%=SystemEnv.getHtmlLabelName(15368,user.getLanguage())%></td></tr>
        	</table>
        </TD>--%>
<%
				double tmpSum=0d,tmpSum1=0d,tmpSum2=0d,tmpSum3=0d;

				for(int j=1;j<5;j++){
					tmpnum = 0d;tmpnum1 = 0d;tmpnum2 = 0d;
%>
		<TD>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<%--<tr height=20 class=datadark><td nowrap align=right>
<%
					tmpnum1 =0;
					tmpSum1 += tmpnum1;
					out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpnum1));
%>
				</td></tr>--%>
				<tr height=20 class=datadark><td nowrap align=right>
                    <%
                        int accountindex = expensetypeperiods.indexOf(thirdlevelid + "_" + j);
                        if (accountindex != -1) {
                            double tempexpense = Util.getDoubleValue((String) expenseaccounts.get(accountindex), 0);
                            tmpnum = (new BigDecimal(tempexpense)).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_DOWN).doubleValue();
                            if (tmpnum != 0)
                                tmpSum3 += tempexpense;
                        }


                        out.print("<font color=");
                        if ((tmpnum > (tmpnum1 * alertvalue)) && (tmpnum < tmpnum1)) out.print("ORANGE");
                        else if (tmpnum > tmpnum1) out.print("RED");
                        else out.print("BLACK");
                        out.print(">");
                        out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpnum));
                        out.print("</font>");
                    %>
				</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpSum2 =  (tmpnum - tmpnum1) * 100 / tmpnum1 ;
                    int tmptgapint = (new Double( tmpSum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
			</table>
		</TD>
<%
				}
%>
		<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        	<%--<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum1));
                            %>
	        	</td></tr>--%>
	        	<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print("<font color=");
                            if((tmpSum3>(tmpSum1*alertvalue))&&(tmpnum<tmpnum1)) out.print("ORANGE");
                            else if(tmpSum3>tmpSum1) out.print("RED");
                            else out.print("BLACK");
                            out.print(">");
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum3));
                            out.print("</font>");
                             %>
	        	</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpnum2 =  (tmpSum3 - tmpSum1) * 100 / tmpSum1 ;
                    int tmptgapint = (new Double( tmpnum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
        	</table>
		</TD>
	</TR>
<%
			}
		}
	}
%>
	<TR class=Line style="height: 1px;"><TD colspan="8" ></TD></TR>
  </TBODY>
</TABLE>

<!--����Ԥ�� ����-->
<!--����Ԥ�� ��ʼ-->


<TABLE width=100% class=ListStyle cellspacing=1 id="halfyearbudgetlisttable" style="display:none">
  <COLGROUP>
    <col width="70">
    <col width="70">
    <col width="70">
    <!--<col width="80">-->
    <col width="17%">
    <col width="17%">
    <col width="17%">
  <THEAD>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(18424,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18425,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18426,user.getLanguage())%></th>
  <%--<th>&nbsp;</th>--%>
  <th>1<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th>2<%=SystemEnv.getHtmlLabelName(15372,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(1013,user.getLanguage())%></th>
  </tr>
  <TR class=Line style="height: 1px;"><TD colspan="6" ></TD></TR>
  </THEAD>
<%
	isFirest = false;
	isSecond = false;
	isThird = false;

	//ȡ���¶�һ����Ŀ
    RecordSet.executeSql(" select id,name from FnaBudgetfeeType where feeperiod = 3 and feelevel = 1 order by name");
	while(RecordSet.next()) {
        String firestlevelid = Util.null2String(RecordSet.getString("id")) ;
        String firestlevelname = Util.toScreen(RecordSet.getString("name"),user.getLanguage()) ;
        isFirest = true;

        //ȡ�ø�һ����Ŀ�µĶ�����Ŀ
	    RecordSet2.executeSql(" select id,name from FnaBudgetfeeType where feelevel = 2 and supsubject = " + firestlevelid);
		while(RecordSet2.next()) {
	        String secondlevelid = Util.null2String(RecordSet2.getString("id")) ;
	        String secondlevelname = Util.toScreen(RecordSet2.getString("name"),user.getLanguage()) ;
	        isSecond = true;

	        //ȡ�øö�����Ŀ�µ�������Ŀ
		    RecordSet3.executeSql(" select a.id,a.name from FnaBudgetfeeType"
		    +" a where "
		    +"  a.feelevel = 3 and a.supsubject = " + secondlevelid

		    );
			while(RecordSet3.next()) {
		        String thirdlevelid = Util.null2String(RecordSet3.getString("id"));
		        String thirdlevelname = Util.toScreen(RecordSet3.getString("name"),user.getLanguage());
                        double alertvalue = (new Double(Util.null2o(RecordSet3.getString("alertvalue")))).doubleValue()/100;
		        isThird = !isThird;
%>
	<TR>
<%
				if(isFirest) {
					isFirest = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()*RecordSet2.getCounts()%>"><%=firestlevelname%></TD>
<%
				}
				if(isSecond) {
					isSecond = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()%>"><%=secondlevelname%></TD>
<%
				}
%>
        <TD bgcolor="#EFEFEF"><a href="#" onClick="return submitBudget(<%=thirdlevelid%>)"><%=thirdlevelname%></a></TD>
        <%--<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr height=20 class=datadark><td nowrap><%=SystemEnv.getHtmlLabelName(386,user.getLanguage())%></td></tr>
        	<tr height=20 class=datalight><td nowrap><%=SystemEnv.getHtmlLabelName(628,user.getLanguage())%></td></tr>
            <tr height=20  CLASS=Total STYLE="COLOR:RED;FONT-WEIGHT:BOLD"><td nowrap><%=SystemEnv.getHtmlLabelName(15368,user.getLanguage())%></td></tr>
        	</table>
        </TD>--%>
<%
				double tmpSum=0d,tmpSum1=0d,tmpSum2=0d,tmpSum3=0d;

				for(int j=1;j<3;j++){
					tmpnum = 0d;tmpnum1 = 0d;tmpnum2 = 0d;
%>
		<TD>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<%--<tr height=20 class=datadark><td nowrap align=right>
<%
					tmpnum1 = 0;
					tmpSum1 += tmpnum1;
					out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpnum1));
%>
				</td></tr>--%>
				<tr height=20 class=datadark><td nowrap align=right>
                    <%
                        int accountindex = expensetypeperiods.indexOf(thirdlevelid + "_" + j);
                        if (accountindex != -1) {
                            double tempexpense = Util.getDoubleValue((String) expenseaccounts.get(accountindex), 0);
                            tmpnum = (new BigDecimal(tempexpense)).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_DOWN).doubleValue();
                            if (tmpnum != 0)
                                tmpSum3 += tempexpense;
                        }

                        out.print("<font color=");
                        if ((tmpnum > (tmpnum1 * alertvalue)) && (tmpnum < tmpnum1)) out.print("ORANGE");
                        else if (tmpnum > tmpnum1) out.print("RED");
                        else out.print("BLACK");
                        out.print(">");
                        out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpnum));
                        out.print("</font>");
                    %>
				</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpSum2 =  (tmpnum - tmpnum1) * 100 / tmpnum1 ;
                    int tmptgapint = (new Double( tmpSum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
			</table>
		</TD>
<%
				}
%>
		<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        	<%--<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum1));
                            %>
	        	</td></tr>--%>
	        	<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print("<font color=");
                            if((tmpSum3>(tmpSum1*alertvalue))&&(tmpnum<tmpnum1)) out.print("ORANGE");
                            else if(tmpSum3>tmpSum1) out.print("RED");
                            else out.print("BLACK");
                            out.print(">");
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum3));
                            out.print("</font>");
                             %>
	        	</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpnum2 =  (tmpSum3 - tmpSum1) * 100 / tmpSum1 ;
                    int tmptgapint = (new Double( tmpnum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
        	</table>
		</TD>
	</TR>
<%
			}
		}
	}
%>
	<TR class=Line style="height: 1px;"><TD colspan="6" ></TD></TR>
  </TBODY>
</TABLE>


<!--����Ԥ�� ����-->
<!--���Ԥ�� ��ʼ-->


<TABLE width=100% class=ListStyle cellspacing=1 id="yearbudgetlisttable" style="display:none">
  <COLGROUP>
    <col width="70">
    <col width="70">
    <col width="70">
    <%--<col width="80">--%>
    <col width="50%">
  <THEAD>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(18424,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18425,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(18426,user.getLanguage())%></th>
  <%--<th>&nbsp;</th>--%>
  <th><%=SystemEnv.getHtmlLabelName(1013,user.getLanguage())%></th>
  </tr>
  <TR class=Line style="height: 1px;"><TD colspan="4" ></TD></TR>
  </THEAD>
<%
	isFirest = false;
	isSecond = false;
	isThird = false;

	//ȡ���¶�һ����Ŀ
    RecordSet.executeSql(" select id,name from FnaBudgetfeeType where feeperiod = 4 and feelevel = 1 order by name");
	while(RecordSet.next()) {
        String firestlevelid = Util.null2String(RecordSet.getString("id")) ;
        String firestlevelname = Util.toScreen(RecordSet.getString("name"),user.getLanguage()) ;
        isFirest = true;

        //ȡ�ø�һ����Ŀ�µĶ�����Ŀ
	    RecordSet2.executeSql(" select id,name from FnaBudgetfeeType where feelevel = 2 and supsubject = " + firestlevelid);
		while(RecordSet2.next()) {
	        String secondlevelid = Util.null2String(RecordSet2.getString("id")) ;
	        String secondlevelname = Util.toScreen(RecordSet2.getString("name"),user.getLanguage()) ;
	        isSecond = true;

	        //ȡ�øö�����Ŀ�µ�������Ŀ
		    RecordSet3.executeSql(" select a.id,a.name from FnaBudgetfeeType"
		    +" a where "
		    +"  a.feelevel = 3 and a.supsubject = " + secondlevelid
		    );
			while(RecordSet3.next()) {
		        String thirdlevelid = Util.null2String(RecordSet3.getString("id"));
		        String thirdlevelname = Util.toScreen(RecordSet3.getString("name"),user.getLanguage());
                        double alertvalue = (new Double(Util.null2o(RecordSet3.getString("alertvalue")))).doubleValue()/100;
		        isThird = !isThird;
%>
	<TR>
<%
				if(isFirest) {
					isFirest = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()*RecordSet2.getCounts()%>"><%=firestlevelname%></TD>
<%
				}
				if(isSecond) {
					isSecond = false;
%>
        <TD bgcolor="#EFEFEF" rowspan="<%=RecordSet3.getCounts()%>"><%=secondlevelname%></TD>
<%
				}
%>
        <TD bgcolor="#EFEFEF"><a href="#" onClick="return submitBudget(<%=thirdlevelid%>)"><%=thirdlevelname%></a></TD>
        <%--<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr height=20 class=datadark><td nowrap><%=SystemEnv.getHtmlLabelName(386,user.getLanguage())%></td></tr>
        	<tr height=20 class=datalight><td nowrap><%=SystemEnv.getHtmlLabelName(628,user.getLanguage())%></td></tr>
            <tr height=20  CLASS=Total STYLE="COLOR:RED;FONT-WEIGHT:BOLD"><td nowrap><%=SystemEnv.getHtmlLabelName(15368,user.getLanguage())%></td></tr>
        	</table>
        </TD>--%>
        <%
            double tmpSum = 0d, tmpSum1 = 0d, tmpSum2 = 0d, tmpSum3 = 0d;

            for (int j = 1; j <= 1; j++) {
                tmpnum = 0d;

                tmpnum = 0;
                tmpSum1 += tmpnum;

                int accountindex = expensetypeperiods.indexOf(thirdlevelid + "_" + j);
                if (accountindex != -1) {
                    double tempexpense = Util.getDoubleValue((String) expenseaccounts.get(accountindex), 0);
                    tmpnum = (new BigDecimal(tempexpense)).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_DOWN).doubleValue();
                    if (tmpnum != 0)
                        tmpSum3 += tempexpense;
                }

            }
        %>
		<TD>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        	<%--<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum1));
                            %>
	        	</td></tr>--%>
	        	<tr height=20 class=datadark><td nowrap align=right>
                            <%
                            out.print("<font color=");
                            if((tmpSum3>(tmpSum1*alertvalue))&&(tmpnum<tmpnum1)) out.print("ORANGE");
                            else if(tmpSum3>tmpSum1) out.print("RED");
                            else out.print("BLACK");
                            out.print(">");
                            out.print(FnaBudgetInfoComInfo.getStrFromDouble(tmpSum3));
                            out.print("</font>");
                             %>
	        	</td></tr>
                <%--<tr height=20 class=datadark><td nowrap align=right>
                <%
                    tmpnum2 =  (tmpSum3 - tmpSum1) * 100 / tmpSum1 ;
                    int tmptgapint = (new Double( tmpnum2 )).intValue() ;
                    if( tmptgapint != 0 )
                        out.print(tmptgapint + "%");
                %>
                </td></tr>--%>
        	</table>
		</TD>
	</TR>
<%
			}
		}
	}
%>
	<TR class=Line style="height: 1px;"><TD colspan="4" ></TD></TR>
  </TBODY>
</TABLE>

<!--���Ԥ�� ����-->



</td></tr>
<tr><td colspan="5">&nbsp;</td></tr>
<tr><td colspan="5">&nbsp;</td></tr>
</table>

</td>
</tr>
</TABLE>

</td>
<td></td>
</tr>
<tr>
<td height="5" colspan="3"></td>
</tr>
</table>
<form name="detail" action=FnaExpenseTypeCrmDetail.jsp method=post>
  <input class=inputstyle id=feetypeid type=hidden name=feetypeid >
  <input class=inputstyle id=custoridss type=hidden name=custoridss value="<%=custoridss%>">
  <input class=inputstyle id=fnayear type=hidden name=fnayear value="<%=fnayear%>">
  <input class=inputstyle id=crmid type=hidden name=crmid value="<%=crmid%>">
  <input class=inputstyle id=startdate type=hidden name=startdate value="<%=fnayearstartdate%>">
  <input class=inputstyle id=enddate type=hidden name=enddate value="<%=fnayearenddate%>">
</form>
<script language=javascript>
document.getElementById("tabPane").rows[0].cells[0].className = "cycleTDCurrent";

function setGoal(o,b){
	document.getElementById("tabPane").rows[0].cells[0].className = "cycleTD";
	document.getElementById("tabPane").rows[0].cells[1].className = "cycleTD";
	document.getElementById("tabPane").rows[0].cells[2].className = "cycleTD";
	document.getElementById("tabPane").rows[0].cells[3].className = "cycleTD";
	document.getElementById("yearbudgetlisttable").style.display="none";
	document.getElementById("halfyearbudgetlisttable").style.display="none";
	document.getElementById("quarterbudgetlisttable").style.display="none";
	document.getElementById("monthbudgetlisttable").style.display="none";
	o.className = "cycleTDCurrent";
	b.style.display="block";
}

function onChangeFnaYear(o){
	document.frmMain.submit();
}
function submitBudget(thevalue) {
	if(thevalue!=null)
    detail.feetypeid.value=thevalue ;
    else
    detail.feetypeid.value="";
    detail.submit() ;
    return false;
}
function comeBack(customerID){
	if(parent){
		location="/CRM/data/ViewCustomerTotal.jsp?CustomerID="+customerID;
	}else{
		location="/CRM/data/ViewCustomer.jsp?CustomerID="+customerID;
	}
}
</script>



</BODY>
</HTML>