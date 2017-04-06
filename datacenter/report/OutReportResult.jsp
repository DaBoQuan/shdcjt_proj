<%@ page import="java.util.*,java.math.*,java.io.*,weaver.general.Util,weaver.file.*,weaver.datacenter.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>

<%
String acceptlanguage = request.getHeader("Accept-Language");
if(!"".equals(acceptlanguage))
	acceptlanguage = acceptlanguage.toLowerCase();

String outrepid = Util.null2String(request.getParameter("outrepid"));
String outrepcategory = Util.null2String(request.getParameter("outrepcategory"));
String modulename = Util.null2String(request.getParameter("modulename"));
String designusername = user.getUsername() ;

// ���� 2004 ��10��23 ������ģ���ļ�����Ӧ�иߺ��п�
String autocolumn = Util.null2String(request.getParameter("autocolumn")); //�п�
String autorow = Util.null2String(request.getParameter("autorow")); //�и�

Calendar today = Calendar.getInstance();
String currentyear = Util.add0(today.get(Calendar.YEAR), 4) ;
String currentmonth = Util.add0(today.get(Calendar.MONTH) + 1, 2) ;
String currentday = Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
String currentdate = currentyear + " " + SystemEnv.getHtmlLabelName(445,user.getLanguage()) + " " + currentmonth + " " + SystemEnv.getHtmlLabelName(6076,user.getLanguage()) + " " + currentday + " " + SystemEnv.getHtmlLabelName(16889,user.getLanguage()) ;

// �����û�����Ȩ�޵��ж�
String userid = "" + user.getUID() ;
String usertype = "" ;
if(user.getLogintype().equals("1")) usertype = "1" ;
else  usertype = "2" ;
boolean hasdownload = false ;

if(HrmUserVarify.checkUserRight("DataCenter:Maintenance", user)) hasdownload = true ;
else {
    RecordSet.executeSql(" select sharelevel from T_OutReportShare where outrepid="+outrepid + 
                         " and userid = " + userid + " and usertype = '" + usertype + "' ");
    if(RecordSet.next() && RecordSet.getInt(1)==1) hasdownload = true ;
}

// �����û�����Ȩ�޵��ж� ����

ExcelSheet es = null ;
ExcelRow er = null ;




OutReportManage OutReportManage = (OutReportManage)session.getAttribute("weaveroutreportmanager") ;
if(OutReportManage == null || !outrepcategory.equals(OutReportManage.getOutRepCategory())) {
    if( outrepcategory.equals("0") ) OutReportManage = new OutReportFixManage() ;      // �̶�����
    else if( outrepcategory.equals("1") ) OutReportManage = new OutReportStatManage() ; // ��ϸ����
    else if( outrepcategory.equals("2") ) OutReportManage = new OutReportOrderManage() ; // ���򱨱�
    session.setAttribute("weaveroutreportmanager", OutReportManage)  ;
}

if(!outrepid.equals(OutReportManage.getOutRepID())) {
    OutReportManage.init(outrepid, user) ;
}

OutReportManage.initRequest(request, user) ;
OutReportManage.initReportValue() ;
es = new ExcelSheet() ;

String outrepname = OutReportManage.getOutRepName() ;
String modulefilename = OutReportManage.getModulefilename() ;
int reportrowcount = OutReportManage.getReportRowCount() ;
int outrepcolumn = OutReportManage.getReportColumnCount() ;

if(!modulename.equals("")) outrepname += " (" + modulename + ") " ;

String yearf = OutReportManage.getYearf() ;
String monthf = OutReportManage.getMonthf() ;   
String dayf = OutReportManage.getDayf() ;  
String yeart = OutReportManage.getYeart() ;  
String montht = OutReportManage.getMontht() ;
String dayt = OutReportManage.getDayt() ;

String firstinputuser="";
String lastinputuser="";
String firstcrmname="";
String allinputuser="";
ArrayList allinputusers=new ArrayList();
String allcrmname="";
String lastinputdate="";
String firstinputdate="";
String approveuser="";
String fromdate="";
String todate="";
if(Util.getIntValue(yearf)<1){
    fromdate="1900";
}else{
    fromdate=yearf;
}
if(Util.getIntValue(monthf)<1){
    fromdate+="-01";
}else{
    fromdate+="-"+monthf;
}
if(Util.getIntValue(dayf)<1){
    fromdate+="-01";
}else{
    fromdate+="-"+dayf;
}
if(Util.getIntValue(yeart)<1){
    todate="9999";
}else{
    todate=yeart;
}
if(Util.getIntValue(montht)<1){
    todate+="-12";
}else{
    todate+="-"+montht;
}
if(Util.getIntValue(dayt)<1){
    todate+="-31";
}else{
    todate+="-"+dayt;
}
String crmids=Util.null2String(request.getParameter("crm"));
ArrayList crmidlist=Util.TokenizerString(crmids,",");
for(int i=0;i<crmidlist.size();i++){
    allcrmname+=CustomerInfoComInfo.getCustomerInfoname((String)crmidlist.get(i))+" ";
}
String sql="";
if(outrepcategory.equals("1")){
    sql="select distinct itemtable from t_reportstatitemtable where outrepid="+outrepid;
}else{
    sql="select distinct b.itemtable from t_outreportitem a,t_outreportitemtable b where a.itemid=b.itemid and a.outrepid="+outrepid;
}
RecordSet.executeSql(sql);
String inputdate="";
String inputuserid="";
String tmpcrmid="";
while(RecordSet.next()){
    String inputtablename=RecordSet.getString("itemtable");
    sql="select reportuserid,crmid,inputdate,confirmuserid from "+inputtablename+" where crmid in("+crmids+") and reportdate >='"+fromdate+"' and reportdate <='"+todate+"' order by reportdate,crmid";
    rs.executeSql(sql);
    while(rs.next()){
        inputuserid=rs.getString("reportuserid");
        tmpcrmid=rs.getString("crmid");
        approveuser=rs.getString("confirmuserid");
        inputdate=Util.null2String(rs.getString("inputdate"));
        if(allinputusers.indexOf(inputuserid)==-1){
            allinputuser+=ResourceComInfo.getResourcename(inputuserid)+" ";
            allinputusers.add(inputuserid);
        }
        if(firstinputuser.equals("") && crmidlist.size()>0 && crmidlist.get(0).equals(tmpcrmid)) firstinputuser=inputuserid;
        if(firstinputdate.equals("") && crmidlist.size()>0 && crmidlist.get(0).equals(tmpcrmid)) firstinputdate=inputdate;
        if(firstcrmname.equals("") && crmidlist.size()>0 && crmidlist.get(0).equals(tmpcrmid)) firstcrmname=CustomerInfoComInfo.getCustomerInfoname(tmpcrmid);
    }
}
lastinputdate=inputdate;
lastinputuser=inputuserid;
String firstinputusermanager=ResourceComInfo.getResourcename(ResourceComInfo.getManagerID(firstinputuser));
firstinputuser=ResourceComInfo.getResourcename(firstinputuser);
String lastinputusermanager=ResourceComInfo.getResourcename(ResourceComInfo.getManagerID(lastinputuser));
lastinputuser=ResourceComInfo.getResourcename(lastinputuser);
approveuser=ResourceComInfo.getResourcename(approveuser);
int indx=firstinputdate.indexOf("-");
if(indx>0){
    firstinputdate=firstinputdate.substring(0,indx)+"��"+firstinputdate.substring(indx+1,firstinputdate.length());
}
indx=firstinputdate.indexOf("-");
if(indx>0){
    firstinputdate=firstinputdate.substring(0,indx)+"��"+firstinputdate.substring(indx+1,firstinputdate.length());
}
if(firstinputdate.length()>0) firstinputdate+="��";
indx=lastinputdate.indexOf("-");
if(indx>0){
    lastinputdate=lastinputdate.substring(0,indx)+"��"+lastinputdate.substring(indx+1,lastinputdate.length());
}
indx=lastinputdate.indexOf("-");
if(indx>0){
    lastinputdate=lastinputdate.substring(0,indx)+"��"+lastinputdate.substring(indx+1,lastinputdate.length());
}
if(lastinputdate.length()>0) lastinputdate+="��";    

String imagefilename = "/images/hdHRM.gif";
String titlename = SystemEnv.getHtmlLabelName(15101,user.getLanguage()) + ": " + outrepname ;
String needfav ="1";
String needhelp ="";
%>
<BODY <% if( !modulefilename.equals("") ) { %>onload="return init()" onscroll="ChinaExcel.Refresh();" <%}%>>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<DIV style="display:none">
<BUTTON class=btn accessKey=S onClick="javascript:location.href='OutReportSel.jsp?outrepid=<%=outrepid%>'"><U>S</U>-<%=SystemEnv.getHtmlLabelName(15518,user.getLanguage())%></BUTTON>
<% if( modulefilename.equals("") && hasdownload) { // û�в����ʱ��,��������Ȩ��,����Excel�������ʾ�����ʱ����ʾexcel %>      
<BUTTON class=btn accessKey=E onClick="javascript:location.href='/weaver/weaver.file.ExcelOut'"><U>E</U>-Excel</BUTTON>
<% } else if (hasdownload) { // ��������ش�ӡ���� %>
<BUTTON class=btn accessKey=E onClick="javascript:ChinaExcel.OnSaveAsExcelFile();"><U>E</U>-Excel</BUTTON>
<BUTTON class=btn accessKey=P onClick="javascript:ChinaExcel.OnFilePrint();"><U>P</U>-<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%></BUTTON>
<BUTTON class=btn accessKey=U onClick="javascript:ChinaExcel.OnPrintSetup();"><U>U</U>-<%=SystemEnv.getHtmlLabelName(257,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(68,user.getLanguage())%></BUTTON>
<BUTTON class=btn accessKey=V onClick="javascript:ChinaExcel.OnFilePrintPreview();"><U>V</U>-<%=SystemEnv.getHtmlLabelName(221,user.getLanguage())%></BUTTON>
<% } %>
<% if(outrepcategory.equals("1") || outrepcategory.equals("2")) {%>
<BUTTON class=btn accessKey=T onClick="javascript:location.href='OutReportStat.jsp?outrepid=<%=outrepid%>&outrepcategory=<%=outrepcategory%>'"><U>T</U>-<%=SystemEnv.getHtmlLabelName(16901,user.getLanguage())%></BUTTON>
<%}%>
</DIV>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(15518,user.getLanguage())+",javascript:location.href='OutReportSel.jsp?outrepid="+outrepid+"',_self} ";
RCMenuHeight += RCMenuHeightStep;
if( modulefilename.equals("") && hasdownload) { // û�в����ʱ��,��������Ȩ��,����Excel�������ʾ�����ʱ����ʾexcel
    RCMenu += "{"+SystemEnv.getHtmlLabelName(17416,user.getLanguage())+"-Excel,javascript:location.href='/weaver/weaver.file.ExcelOut',_self} ";
    RCMenuHeight += RCMenuHeightStep;
 } else if (hasdownload) { // ��������ش�ӡ����
    RCMenu += "{"+SystemEnv.getHtmlLabelName(17416,user.getLanguage())+"-Excel,javascript:ChinaExcel.OnSaveAsExcelFile(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(257,user.getLanguage())+",javascript:ChinaExcel.OnFilePrint(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(20756,user.getLanguage())+",javascript:ChinaExcel.OnPrintSetup(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(20757,user.getLanguage())+",javascript:ChinaExcel.OnFilePrintPreview(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
}
if(outrepcategory.equals("1") || outrepcategory.equals("2")) {
    RCMenu += "{"+SystemEnv.getHtmlLabelName(16901,user.getLanguage())+",javascript:location.href='OutReportStat.jsp?outrepid="+outrepid+"&outrepcategory="+outrepcategory+"',_self} ";
    RCMenuHeight += RCMenuHeightStep;
}
if(!modulefilename.equals("")){
RCMenu += "{"+SystemEnv.getHtmlLabelName(18173,user.getLanguage())+",javascript:dosystemhead(),_self} ";
RCMenuHeight += RCMenuHeightStep;
}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=97% border="0" cellspacing="0" cellpadding="0">
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
<% 
if( modulefilename.equals("") ) {   // ԭ������ʾ��ʽ
%>
		
    <TABLE class=liststyle cellspacing=1>
      <TBODY>
      <TR class=header>
        <TH colSpan=<%=outrepcolumn%>><%=SystemEnv.getHtmlLabelName(15101,user.getLanguage())%> :  <%=outrepname%>
        </TH>
      </TR>
      <TR class=line>
        <TD  colSpan=<%=outrepcolumn%>></TD>
      </TR>
    <% 

    boolean isLight = false;
    for(int j=1; j<reportrowcount+1 ; j++) {  // ÿ��
        er =es.newExcelRow () ;
        isLight = ! isLight ;
    %>
      <TR class='<%=( isLight ? "datalight" : "datadark" )%>'>
    <%                      
        for(int i= 1; i<outrepcolumn+1 ; i++) {  // ÿ��
            String thevalue = OutReportManage.getReportValue(j,i) ;
            boolean isdigital = false ;
            if(Util.getDoubleValue(thevalue,-9999.99) != -9999.99 && i!=1 && j!=1) {        // ������
                isdigital = true ;
                if(Util.getIntValue(thevalue,-9999) == -9999) {     // ��������
                    thevalue = "" + (new BigDecimal(thevalue)).divide ( new BigDecimal ( 1 ), 2, BigDecimal.ROUND_HALF_DOWN ).doubleValue() ;
                    er.addValue(Util.getfloatToString(thevalue)) ;
                }
                thevalue = Util.getFloatStr(Util.getfloatToString(thevalue),3) ;
            }
            else {
                String tempthevalue = thevalue ;
                thevalue = Util.StringReplace(thevalue,"&dt;&at;" , "<br>") ;
                er.addStringValue(Util.StringReplace(tempthevalue,"&dt;&at;" , ",")) ;
            }
    %>
        <TD <%if(i==1 || j==1) {%> style="BACKGROUND-COLOR:#d6d3ce" align=center <%} else if(isdigital) {%> align=right <%}%>><nobr>
            <% if(thevalue.equals("")) {%>&nbsp;<%} else {%><%=thevalue%><%}%>
        </TD>
    <%
        }   
    %>
      </TR>
    <%  
    }

    
    ExcelFile.init() ;
    ExcelFile.setFilename(outrepname) ;
    ExcelFile.addSheet(outrepname, es) ;

    %>  
     </TBODY></TABLE>
<%
} else {      // �ɲ����ʾ
 
%>

<script language=javascript src="/workflow/mode/loadmode.js"></script>
<%if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1){%>
<script language=javascript src="/workflow/mode/chinaexcelobj_tw.js"></script>
<%}else{%>
<script language=javascript src="/workflow/mode/chinaexcelobj.js"></script>
<%} %>

<% 
}
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

<% if( !modulefilename.equals("") ) {%>
<SCRIPT FOR="ChinaExcel" EVENT="MouseLClick()"	LANGUAGE="JavaScript" >
    rightMenu.style.visibility="hidden";
    return false;
</SCRIPT>
<SCRIPT FOR="ChinaExcel" EVENT="MouseRClick()"	LANGUAGE="JavaScript" >
        rightMenu.style.left=ChinaExcel.offsetLeft+ChinaExcel.GetMousePosX();
        rightMenu.style.top=ChinaExcel.offsetTop+ChinaExcel.GetMousePosY();
		rightMenu.style.visibility="visible";
		return false;
</SCRIPT>
<script language=javascript>
function dosystemhead(){
    ChinaExcel.ShowHeader =!ChinaExcel.ShowHeader;
}
function init()
{
    ChinaExcel.Login("��΢���","891e490cd34e3e33975b1b7e523e8b32","�Ϻ���΢���缼�����޹�˾");    
	ChinaExcel.ReadHttpTabFile("/reportModel/<%=modulefilename%>.tab");
    // ChinaExcel.SetStatFetchDataMode("OutReportXml.jsp",1);
    ChinaExcel.DesignMode = false;
    ChinaExcel.SetShowPopupMenu(false);
	ChinaExcel.SetOnlyShowTipMessage(false);
    setChinaExcelValue("ReportTitle","<%=outrepname%>");//���ģ������
    setChinaExcelValue("ReportDesigner","<%=designusername%>");//��ǰ��¼�û�����
    setChinaExcelValue("ReportDate","<%=currentdate%>");//ϵͳ����
    setChinaExcelValue("modulename","<%=modulename%>");//��ѯ����ģ������
    setChinaExcelValue("yearf","<%=yearf%>");//��ò�ѯ��������
    setChinaExcelValue("monthf","<%=monthf%>");//��ò�ѯ��������
    setChinaExcelValue("dayf","<%=dayf%>");//��ò�ѯ��������
    setChinaExcelValue("yeart","<%=yeart%>");//��ò�ѯ��������
    setChinaExcelValue("montht","<%=montht%>");//��ò�ѯ��������
	setChinaExcelValue("dayt","<%=dayt%>");//��ò�ѯ��������
    setChinaExcelValue("firstinputuser","<%=firstinputuser%>");//��õ�һ�����
    setChinaExcelValue("lastinputuser","<%=lastinputuser%>");//������һ�����
    setChinaExcelValue("allinputuser","<%=allinputuser%>");//����������
    setChinaExcelValue("firstinputusermanager","<%=firstinputusermanager%>");//��õ�һ�����ֱ���ϼ�
    setChinaExcelValue("lastinputusermanager","<%=lastinputusermanager%>");//������һ�����ֱ���ϼ�
    setChinaExcelValue("firstcrmname","<%=firstcrmname%>");//��ò�ѯ������һ���ͻ�����
    setChinaExcelValue("allcrmname","<%=allcrmname%>");//��ò�ѯ�������пͻ�����
    setChinaExcelValue("firstinputdate","<%=firstinputdate%>");//��ò�ѯ������һ���ͻ������������
    setChinaExcelValue("lastinputdate","<%=lastinputdate%>");//��ò�ѯ�������һ���ͻ���������
    setChinaExcelValue("approveuser","<%=approveuser%>");//��ʱ����
    ChinaExcel.SetPasteType(1);
    ChinaExcel.ReCalculate();

    <% if( autocolumn.equals("1") ) {%>
    ChinaExcel.AutoSizeCol(1,<%=outrepcolumn%>,true);
    <% } %>
    
    <% if( autorow.equals("1") ) {%>
    ChinaExcel.AutoSizeRow(1,<%=reportrowcount%>,true) ;
    <% } %>
    ChinaExcel.SetCanAutoSizeHideCols(true);
    ChinaExcel.SetProtectFormShowCursor(true);
    ChinaExcel.ShowGrid = false;
    ChinaExcel.height="100%";
    ChinaExcel.RefreshViewSize();
}

function gettotalheight(){
        var maxrow=ChinaExcel.GetMaxRow();
        var totalheight=0;
        for(var i=1;i<=maxrow;i++){
            totalheight+=ChinaExcel.GetRowSize(i,1);
        }
        return totalheight;
}
function gettotalwidth(){
        var maxcol=ChinaExcel.GetMaxCol();
        var totalwidth=0;
        for(var i=1;i<=maxcol;i++){
            totalwidth+=ChinaExcel.GetColSize(1,i);
        }
        return totalwidth;
}

function setChinaExcelValue(setKey,valueStr)
{
	TitleRow=ChinaExcel.GetCellUserStringValueRow(setKey);
	TitleCol=ChinaExcel.GetCellUserStringValueCol(setKey);	
	ChinaExcel.SetCellVal(TitleRow,TitleCol,valueStr);
	ChinaExcel.Refresh();
}

function onCbClick(szCommand)
{
	switch(szCommand.toUpperCase())
	{
		case "CMDPRINTSETUP":
			ChinaExcel.OnPrintSetup();			
			break;
		case "CMDFILEPRINT":
			ChinaExcel.OnFilePrint();			
			break;
		case "CMDFILEPRINTPREVIEW":
			ChinaExcel.OnFilePrintPreview();
			break;
		case "CMDABOUT":
			ChinaExcel.AboutBox();
			break;
	}
}

</script>

<%}%>
 
</BODY></HTML>
