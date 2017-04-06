<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.file.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CptSearchComInfo" class="weaver.cpt.search.CptSearchComInfo" scope="session" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="CapitalStateComInfo" class="weaver.cpt.maintenance.CapitalStateComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page" />
<jsp:useBean id="CapitalAssortmentList" class="weaver.cpt.maintenance.CapitalAssortmentList" scope="page" />
<jsp:useBean id="CapitalCurPrice" class="weaver.cpt.capital.CapitalCurPrice" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="cptsearch" class="weaver.cpt.search.CapitalSearch" scope="page" />

<%

Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                 Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                 Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String CurrentUser = ""+user.getUID();
String logintype = ""+user.getLogintype();
String ProcPara = "";
char flag = 2;
ProcPara = CurrentUser;
ProcPara += flag+logintype;

String subcompanyid = Util.fromScreen(request.getParameter("subcompanyid"),user.getLanguage()) ;		
//��ѯ����
String assortmentid = CptSearchComInfo.getCapitalgroupid();

String tempsearchsql = CptSearchComInfo.FormatSQLSearch();

//put all capitalid into hashtable
Hashtable ht = new Hashtable();
ArrayList ids = new ArrayList() ;
ArrayList marks = new ArrayList() ;
ArrayList capitalnums = new ArrayList() ;
ArrayList names = new ArrayList() ;
ArrayList resourceids = new ArrayList() ;
ArrayList capitalspecs = new ArrayList() ;
ArrayList startprices = new ArrayList() ;
ArrayList capitalgroupids = new ArrayList() ;
ArrayList stateids = new ArrayList() ;
ArrayList remarks = new ArrayList() ;
ArrayList departmentids = new ArrayList() ;
ArrayList fnamarks = new ArrayList() ;
ArrayList StockInDates = new ArrayList() ;
ArrayList locations = new ArrayList() ;
ArrayList customerids = new ArrayList() ;
ArrayList sptcounts = new ArrayList() ;
ArrayList deprestartdates = new ArrayList() ;
ArrayList depreyears = new ArrayList() ;
ArrayList deprerates = new ArrayList() ;
ArrayList selectdates = new ArrayList() ;
ArrayList blongdepartments = new ArrayList();

String sql  = "select id,mark,StockInDate,location,customerid,capitalnum , name, resourceid, capitalspec, startprice, stateid, remark, departmentid, fnamark, capitalgroupid,sptcount,deprestartdate,depreyear,deprerate,selectdate,blongdepartment from CptCapital   where id in ( select distinct t1.id from CptCapital t1  , CptShareDetail  t2 " + tempsearchsql + " and t1.id = t2.cptid and t2.userid=" + CurrentUser + " and t2.usertype = " + logintype + " )  order by mark asc" ;

RecordSet.executeSql(sql);

while(RecordSet.next()){
	String tempid = RecordSet.getString("id");
    String tempmark = RecordSet.getString("mark");
    String tempcapitalnum = RecordSet.getString("capitalnum");
    String tempname = RecordSet.getString("name");
    String tempresourceid = RecordSet.getString("resourceid");
    String tempcapitalspec = RecordSet.getString("capitalspec");
    String tempstartprice = RecordSet.getString("startprice");
    String tempcapitalgroupid = RecordSet.getString("capitalgroupid");
    String tempstateid =  RecordSet.getString("stateid");
    String tempremark  = RecordSet.getString("remark");
    String tempdepartmentid  = RecordSet.getString("departmentid");
    String tempfnamark  = RecordSet.getString("fnamark");
    String tempStockInDate = RecordSet.getString("StockInDate");
    String templocation = RecordSet.getString("location");
    String tempcustomerid = RecordSet.getString("customerid");
    String tempsptcount = RecordSet.getString("sptcount");
    String tempdeprestartdate = RecordSet.getString("deprestartdate");
    String tempdepreyear = RecordSet.getString("depreyear");
    String tempdeprerate = RecordSet.getString("deprerate");
    String tempselectdate = RecordSet.getString("selectdate");
	String tempblongdepartment = RecordSet.getString("blongdepartment");
	
    ArrayList tempal = (ht.get(tempcapitalgroupid)==null)?new ArrayList():(ArrayList)ht.get(tempcapitalgroupid);
	tempal.add(tempid);
	ht.put(tempcapitalgroupid,tempal);

    ids.add(tempid) ;
    marks.add(tempmark) ;
    capitalnums.add(tempcapitalnum) ;
    names.add(tempname) ;
    resourceids.add(tempresourceid) ;
    capitalspecs.add(tempcapitalspec) ;
    startprices.add(tempstartprice) ;
    capitalgroupids.add(tempcapitalgroupid) ;
    stateids.add(tempstateid) ;
    remarks.add(tempremark) ;
    departmentids.add(tempdepartmentid) ;
    fnamarks.add(tempfnamark) ;
    StockInDates.add(tempStockInDate) ;
    locations.add(templocation) ;
    customerids.add(tempcustomerid) ;
    sptcounts.add(tempsptcount) ;
    deprestartdates.add(tempdeprestartdate) ;
    depreyears.add(tempdepreyear) ;
    deprerates.add(tempdeprerate) ;
    selectdates.add(tempselectdate);
	blongdepartments.add(tempblongdepartment);
}

//initial AssortmentList
CapitalAssortmentList.initCapitalAssortmentList("0");
if(assortmentid.equals("")){
	CapitalAssortmentList.setCapitalAssortmentList2("0");
}
else{
	CapitalAssortmentList.setCapitalAssortmentList2(assortmentid);
}

//get max step
int stepcount = 0;
while(CapitalAssortmentList.next()){
	int step = Util.getIntValue(CapitalAssortmentList.getAssortmentStep());
	if(step>stepcount){
		stepcount=step;
	}
}

if(!(CptSearchComInfo.getCountType()).equals("")){
	stepcount = 2;
}

int tdwidth=10;
if (stepcount>0) tdwidth=(int)(10/stepcount);

String strData="";
String strURL="";
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript>
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showdata(datasql){
    var ajax=ajaxinit();
    ajax.open("POST", "CptRpCapitalResultData.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("datasql="+encodeURIComponent(datasql)+"&Language=<%=user.getLanguage()%>");
    //��ȡִ��״̬
    ajax.onreadystatechange = function() {
        //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
                document.all("showdatadiv").innerHTML=ajax.responseText;
            }catch(e){
                return false;
            }
        }
    }
}
</script>
</HEAD>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(1510,user.getLanguage());//TotalCount+" - "+pagenum+" - "+perpage;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",javascript:onReSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{Excel,/weaver/weaver.file.ExcelOut,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=150% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
			<table width=100%>
			<tr>
			<td>
			<TABLE class=ListStyle cellspacing="1">
			  <COLGROUP>
			  <% for(int i=0;i<stepcount;i++){ %>	
                <!--���-->
			    <COL width="<%=tdwidth%>%">
			  <% } %>
                <!--���-->
                <COL width="6%">
                <!--������-->
                <COL width="6%">
                <!--�ʲ�����-->
                <COL width="8%">
                <!--����ͺ�-->
                <COL width="8%">
                <!--����-->
                <COL width="4%">
                <!--��������-->
                <COL width="6%">
                <!--����-->
                <COL width="4%">
                <!--��ֵ-->
                <COL width="4%">
                <!--�ܽ��-->
                <COL width="4%">
                <!--״̬-->
                <COL width="4%">
                <!--ʹ����-->
                <COL width="4%">
                <!--ʹ�ò���-->
                <COL width="6%">
                <!--��ⲿ��-->
                <COL width="6%">
                <!--��ŵص�-->
                <COL width="10%">
                <!--��Ӧ��-->
                <COL width="10%">
                <!--��ע-->
                <!--COL width="0%"-->
			  <TBODY>
				<%
				
					ExcelSheet es = new ExcelSheet() ;
					ExcelRow er = es.newExcelRow () ;  
				
					String searchmark = CptSearchComInfo.getMark();
					String searchname =  CptSearchComInfo.getName();   
					String searchdepartmentid =  CptSearchComInfo.getDepartmentid();   
					String searchresourceid =  CptSearchComInfo.getResourceid();   
					String searchstartdate =  CptSearchComInfo.getStartdate();   
					String searchstartdateto =  CptSearchComInfo.getStartdate1();   
					String searchenddate =  CptSearchComInfo.getEnddate();   
					String searchenddateto =  CptSearchComInfo.getEnddate1();   
					String searchstateid =  CptSearchComInfo.getStateid();   
					String searchgroupid =  CptSearchComInfo.getCapitalgroupid();  
					String searchcounttype = CptSearchComInfo.getCountType();  
				%>
			  
			  <% 
				for(int i=1;i<=stepcount;i++){
                 //<!--���-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(178,user.getLanguage())+i) ;
			  %>	
              <!--���-->
			  
			  <% } %>
			  <TR><TD colspan=<%=stepcount+16%>>
			  	<div id="showdatadiv"><%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>
			  		<script>showdata("<%=sql%>");</script>
			  	</div>
			  </TD></TR>
			<% 
                 //<!--���-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(714,user.getLanguage())) ;
                 //<!--������-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(15293,user.getLanguage())) ;
                 //<!--�ʲ�����-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(1445,user.getLanguage())) ;
				 //<!--����ͺ�-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(904,user.getLanguage())) ;
                 //<!--����-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(1331,user.getLanguage())) ;
                 //<!--��������-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(16914,user.getLanguage())) ;
                 //<!--����-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(1330,user.getLanguage())) ;
                 //<!--��ֵ-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(1450,user.getLanguage())) ;
                 //<!--�ܽ��-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(1447,user.getLanguage())) ;
				 //<!--״̬-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(602,user.getLanguage())) ;
				 //<!--ʹ����-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(1508,user.getLanguage())) ;
                 //<!--ʹ�ò���-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(21030,user.getLanguage())) ;
                 //<!--��ⲿ��-->
				 er.addStringValue(SystemEnv.getHtmlLabelName(15393,user.getLanguage())) ;
                 //<!--��ŵص�-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(1387,user.getLanguage())) ; ;
                 //<!--�������-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(753,user.getLanguage())) ;
                 //<!--��Ӧ��-->
                 er.addStringValue(SystemEnv.getHtmlLabelName(138,user.getLanguage())) ;
				 //<!--��ע-->
                 //er.addStringValue(SystemEnv.getHtmlLabelName(454,user.getLanguage())) ;
				 es.addExcelRow(er) ;

			int needchange = 0;
			int totalline=1;

			ArrayList loopal;

			//get all assortment
			int sumnum = 0;
			double sumprice = 0;
			int sumassortnum = 0;
			double sumassortprice = 0;
			int sumallnum = 0;
			double sumallprice = 0;
			String lastid = "";
			boolean flagfirst = true;
			String tempid = "";
			String assortmentstep = "";
			String assortmentname = "";

			//��ѭ��
			while(CapitalAssortmentList.next()){
					tempid = CapitalAssortmentList.getAssortmentId();
					assortmentstep = CapitalAssortmentList.getAssortmentStep();
					assortmentname = CapitalAssortmentList.getAssortmentName();
			//		out.print("assortmentname:"+assortmentname);
					loopal = (ArrayList)ht.get(tempid);
					//do capital in each assortment
					//��ѭ��
				 if(loopal!=null){
					for(int i=0;i<loopal.size();i++){
					String cptid = (String)loopal.get(i);
					int theindex = ids.indexOf(cptid) ;
					if( theindex == -1 ) continue ;
					
					String tempmark = (String)marks.get(theindex) ;
					String tempcapitalnum = (String)capitalnums.get(theindex) ;
					String tempname = (String)names.get(theindex) ;
					String tempresourceid = (String)resourceids.get(theindex) ;
					String tempcapitalspec = (String)capitalspecs.get(theindex) ;
					String tempstartprice = (String)startprices.get(theindex) ;
					String tempcapitalgroupid = (String)capitalgroupids.get(theindex) ;
					String tempstateid =  (String)stateids.get(theindex) ;
					String remark  = (String)remarks.get(theindex) ;
					String departmentid  = (String)departmentids.get(theindex) ;
					String fnamark  = (String)fnamarks.get(theindex) ;
                    String StockInDate  = (String)StockInDates.get(theindex) ;
                    String location  = (String)locations.get(theindex) ;
                    String customerid  = (String)customerids.get(theindex) ;
					String currentprice  = "";
                    String tempsptcount  = (String)sptcounts.get(theindex) ;
                    String tempdeprestartdate  = (String)deprestartdates.get(theindex) ;
                    String tempdepreyear  = (String)depreyears.get(theindex) ;
                    String tempdeprerate  = (String)deprerates.get(theindex) ;
                    String SelectDate  = (String)selectdates.get(theindex) ;
					String tempblongdepartment = (String)blongdepartments.get(theindex) ;

					ids.remove(theindex) ;
					marks.remove(theindex) ;
					capitalnums.remove(theindex) ;
					names.remove(theindex) ;
					resourceids.remove(theindex) ;
					capitalspecs.remove(theindex) ;
					startprices.remove(theindex) ;
					capitalgroupids.remove(theindex) ;
					stateids.remove(theindex) ;
					remarks.remove(theindex) ;
					departmentids.remove(theindex) ;
					fnamarks.remove(theindex) ;
                    StockInDates.remove(theindex) ;
                    locations.remove(theindex) ;
                    customerids.remove(theindex) ;
                    sptcounts.remove(theindex) ;
                    deprestartdates.remove(theindex) ;
                    depreyears.remove(theindex) ;
                    deprerates.remove(theindex) ;
					selectdates.remove(theindex);
					blongdepartments.remove(theindex);
					
					
					/*���㵱ǰ��ֵ*/
                    CapitalCurPrice.setSptcount(tempsptcount);
                    CapitalCurPrice.setStartprice(tempstartprice);
                    CapitalCurPrice.setCapitalnum(tempcapitalnum);
                    CapitalCurPrice.setDeprestartdate(tempdeprestartdate);
                    CapitalCurPrice.setDepreyear(tempdepreyear);
                    CapitalCurPrice.setDeprerate(tempdeprerate);

                    currentprice=CapitalCurPrice.getCurPrice();
				 
					
					String temptotal = ""+(int)((Util.getDoubleValue(tempstartprice)*Util.getDoubleValue(tempcapitalnum,0)+0.005)*100)/100.00 ;
			%>

			<% 
			
				er = es.newExcelRow () ;
			%>
               <!--����չ�ֿ�ʼ-->
			  <% for(int j=1;j<=stepcount;j++){ %>	
                <!--���-->
				<% //get assortmentid and name of current level
				   String tempassortmentid = tempid;
				   if(Util.getIntValue(assortmentstep,0)>=j){
					   if(Util.getIntValue(assortmentstep,0)!=j){   
						  int t = Util.getIntValue(assortmentstep,0)-j;
						  for(int k=0;k<t;k++){
							tempassortmentid = CapitalAssortmentComInfo.getSupAssortmentId(tempassortmentid);
						  }
						  assortmentname = 	CapitalAssortmentComInfo.getAssortmentName(tempassortmentid);
					   }
					   else{
						  assortmentname = CapitalAssortmentList.getAssortmentName();
					   }// end if
				   if(j==1){
						lastid=tempassortmentid;
				   }
				 }else{
					 assortmentname="";
					}
					er.addStringValue(assortmentname);%>
			   <% 
				};//end for   		
						
                        //<!--���-->
						er.addStringValue(tempmark);
                        //<!--������-->
                        er.addStringValue(fnamark);
                        //<!--�ʲ�����-->
                        er.addStringValue(tempname);
						//<!--����ͺ�-->
                        er.addStringValue(tempcapitalspec);
                        //<!--����-->
                        er.addValue(tempcapitalnum);
                        //<!--��������-->
                        er.addStringValue(SelectDate);
                        //<!--����-->
                        er.addValue(Util.getFloatStr(tempstartprice,3));
                        //<!--��ֵ-->
                        er.addValue(Util.getFloatStr(currentprice,3));
                        //<!--�ܽ��-->
                        er.addValue(Util.getFloatStr(temptotal,3));
                        //<!--״̬-->
                        er.addStringValue(Util.toScreen(CapitalStateComInfo.getCapitalStatename(tempstateid),user.getLanguage()));
                        //<!--ʹ����-->
                        er.addStringValue(Util.toScreen(ResourceComInfo.getResourcename(tempresourceid),user.getLanguage()));
                        //<!--ʹ�ò���-->
                        er.addStringValue(Util.toScreen(cptsearch.getDepartmentNameNoHref(tempresourceid),user.getLanguage()));
                        //<!--��������-->
                        er.addStringValue(Util.toScreen(DepartmentComInfo.getDepartmentname(tempblongdepartment),user.getLanguage()));
                        //<!--��ŵص�-->
                        er.addStringValue(location);
                        //<!--�������-->
                        er.addStringValue(StockInDate);
                        //<!--��Ӧ��-->
                        er.addStringValue(Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(customerid),user.getLanguage()));
                        //<!--��ע-->
                        //er.addStringValue(Util.toScreenToEdit(remark,user.getLanguage()));
						
						es.addExcelRow(er) ;
						
			%>

			<%
					}//end for
				 }
			}// end while
			%>
			  
			</TBODY>
			</TABLE>
			</td>
			</tr>
			</table>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
</table>
<%
 ExcelFile.init() ;
 ExcelFile.setFilename(SystemEnv.getHtmlLabelName(1510,user.getLanguage())) ;
 ExcelFile.addSheet(SystemEnv.getHtmlLabelName(1510,user.getLanguage()), es) ;
 %>
<script>
function onReSearch(){
	location.href="CptRpCapital.jsp?subcompanyid1=<%=subcompanyid%>";
}
</script>

</body>
</html>
