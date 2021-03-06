<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util,weaver.hrm.User,
                 weaver.rtx.RTXExtCom,
                 weaver.hrm.settings.BirthdayReminder,
                 weaver.hrm.settings.RemindSettings,
                 weaver.systeminfo.setting.HrmUserSettingHandler,
                 weaver.systeminfo.setting.HrmUserSetting,
                 weaver.general.TimeUtil,
                 weaver.login.Account" %>
<%@ page import="weaver.rtx.RTXConfig" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*,HT.HTSrvAPI,java.math.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.file.Prop" %>

<%@ include file="/systeminfo/init.jsp" %>
<%@ include file="/systeminfo/template/templateCss.jsp" %>
<%@ include file="/docs/common.jsp" %>
<%@ include file="/times.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rtxClient" class="weaver.rtx.RTXClientCom" scope="page" />
<jsp:useBean id="autoPlan" class="weaver.hrm.performance.targetplan.AutoPlan" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="DocSearchComInfo" class="weaver.docs.search.DocSearchComInfo" scope="session" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="HrmScheduleDiffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page" />
<jsp:useBean id="PluginUserCheck" class="weaver.license.PluginUserCheck" scope="page" />
<jsp:useBean id="MouldStatusCominfo" class="weaver.systeminfo.MouldStatusCominfo" scope="page" />

<SCRIPT LANGUAGE="javascript">
//设置页面title
document.title = "<%=templateTitle%> - <%=user.getUsername()%>";
</script>

<SCRIPT LANGUAGE="javascript">
var voteids = "";//网上调查的id
var eBirth = false;//判断是否有人过生日

</SCRIPT>

<!--网上调查部分-- 开始No blank -->
<% 
//------------------------------------
// 客户端语言取得 Start
//------------------------------------
String acceptlanguage = request.getHeader("Accept-Language");
if(!"".equals(acceptlanguage))
    acceptlanguage = acceptlanguage.toLowerCase();
//------------------------------------
//客户端语言取得 ENd
//------------------------------------
%>

<%
//------------------------------------
// 插件检测（是否安装） Start
//------------------------------------
boolean NoCheck=false;
RecordSet.executeSql("select NoCheckPlugin from SysActivexCheck where NoCheckPlugin='1' and logintype='1' and userid="+user.getUID());
if(RecordSet.next()) NoCheck=true;
if(!NoCheck){
%>
<script language="javascript" src="/js/activex/ActiveX.js"></script>

<SCRIPT LANGUAGE="javascript">
function getOuterLanguage()
{
    return '<%=acceptlanguage%>';
}
checkWeaverActiveX(<%=user.getLanguage()%>);
</script>
<%
}
//------------------------------------
//插件检测（是否安装） End
//------------------------------------
 %>
 
<%
//------------------------------------
//网上调查部分 Start
//------------------------------------
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16);
HrmScheduleDiffUtil.setUser(user);
boolean isWorkday = HrmScheduleDiffUtil.getIsWorkday(CurrentDate);
boolean isSyadmin=false;
//判断分权管理员
RecordSet.executeSql("select loginid from hrmresourcemanager where loginid = '"+user.getLoginid()+"'");
if(RecordSet.next()){
   isSyadmin = true;
}

String sql=""; 
sql="select distinct t1.id from voting t1,VotingShareDetail t2 where t1.id=t2.votingid and t2.resourceid="+user.getUID()+" and t1.status=1 "+ 
        " and t1.id not in (select distinct votingid from votingresource where resourceid ="+user.getUID()+")" 
        +" and (t1.beginDate<'"+CurrentDate+"' or (t1.beginDate='"+CurrentDate+"' and (t1.beginTime is null or t1.beginTime='' or t1.beginTime<='"+CurrentTime+"'))) "; 
RecordSet.executeSql(sql); 
while(RecordSet.next()){ 
String votingid = RecordSet.getString("id"); 
%> 
<script language=javascript> 
    //window.open("/voting/VotingPoll.jsp?votingid=<%=votingid%>", "", "toolbar,resizable,scrollbars,dependent,height=600,width=800,top=0,left=100") ; 
   if(voteids == ""){
      voteids = '<%=votingid%>';
   }else{
      voteids =voteids + "," +  '<%=votingid%>';
   }

</script> 
<%
}
//------------------------------------
//网上调查部分 End
//------------------------------------
%> 
 

 
<%
//------------------------------------
//生日提醒部分 Start
//------------------------------------
//boolean checkchattemp = false;
//String chatserver = Util.null2String(weaver.general.GCONST.getCHATSERVER());//检测即时通讯是否开启
//if(!"".equals(chatserver)) checkchattemp = true;


//String frommain = Util.null2String(request.getParameter("frommain")) ;
RemindSettings settings=(RemindSettings)application.getAttribute("hrmsettings");
String birth_valid = settings.getBirthvalid();
String birth_remindmode = settings.getBirthremindmode();
BirthdayReminder birth_reminder = new BirthdayReminder();
if(birth_valid!=null&&birth_valid.equals("1")&&birth_remindmode!=null&&birth_remindmode.equals("0")){
    String today = TimeUtil.getCurrentDateString();
    if( application.getAttribute("birthday")==null||application.getAttribute("birthday")!=today){
        application.setAttribute("birthday",today);
        ArrayList birthEmployers=birth_reminder.getBirthEmployerNames();
        application.setAttribute("birthEmployers",birthEmployers);
    }
    ArrayList birthEmployers=(ArrayList)application.getAttribute("birthEmployers");
 
    if(birthEmployers.size()>0){    
%>
	<script>
	var chasm = screen.availWidth;
	var mount = screen.availHeight;
	function openCenterWin(url,w,h) {
	   window.open(url,'','scrollbars=yes,resizable=no,width=' + w + ',height=' + h + ',left=' + ((chasm - w - 10) * .5) + ',top=' + ((mount - h - 30) * .5));
	}
	//openCenterWin('/hrm/setting/Birthday.jsp',516,420);
	eBirth = true;
		
	</script>
<%
    }
}
//------------------------------------
//生日提醒部分 End
//------------------------------------
%>

<script language=javascript>

jQuery(document).ready(function() {
   showVote();
   showBirth();
});
  
  //setTimeout("showVote()",7000);
  //setTimeout("showBirth()",6000);
  function showVote(){
     if(voteids !=""){
	     var arr = voteids.split(",");
		 for(i=0;i<arr.length;i++){
		    var diag_vote = new Dialog();
			diag_vote.Width = 800;
			diag_vote.Height = 600;
			diag_vote.Modal = false;
			diag_vote.Title = "<%=SystemEnv.getHtmlLabelName(17599,user.getLanguage())%>";
			diag_vote.URL = "/voting/VotingPoll.jsp?votingid="+arr[i];
			diag_vote.show();
		 }
	 }
  }

  function showBirth(){
     if(eBirth){
	     var diag_bir = new Dialog();
		diag_bir.Width = 516;
		diag_bir.Height = 420;
		diag_bir.AutoClose=6;
		diag_bir.Modal = false;
		diag_bir.Title = "<%=SystemEnv.getHtmlLabelName(17534,user.getLanguage())%>";
		diag_bir.URL = "/hrm/setting/Birthday.jsp?theme=ecology7";
		diag_bir.show();
	 }
  }
 
</script> 

<script language=javascript>
var glbreply = true;
</script>

<%
//------------------------------------
//个人计划生成部分 Start
//------------------------------------
String username = ""+user.getUsername() ;
String userid = ""+user.getUID() ;
String usertype = "" ;
if(user.getLogintype().equals("1")) usertype = "1" ;
else  usertype = ""+(-1*user.getType()) ;

char separator = Util.getSeparator() ;

Calendar today = Calendar.getInstance();
String currentyear = Util.add0(today.get(Calendar.YEAR), 4) ;
String currentmonth = Util.add0(today.get(Calendar.MONTH)+1, 2) ;
String currentdate = Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
String currenthour = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) ;

String initsrcpage = "" ;
String logintype = Util.null2String(user.getLogintype()) ;
String Customertype = Util.null2String(""+user.getType()) ;
int targetid = Util.getIntValue(request.getParameter("targetid"),0) ;
//String loginfile = Util.null2String(request.getParameter("loginfile")) ;
String loginfile = Util.getCookie(request , "loginfileweaver") ;
String message = Util.null2String(request.getParameter("message")) ;
String logmessage = Util.null2String((String)session.getAttribute("logmessage")) ;
//自动生成个人计划
//autoPlan.autoSetPlanDay(""+user.getUID(),user);
if(targetid == 0) {
    if(!logintype.equals("2")){
        //initsrcpage="/workspace/WorkSpace.jsp";
       // initsrcpage="/homepage/HomepageRedirect.jsp";
        initsrcpage="/homepage/HomepageRedirect.jsp?hpid=1&subCompanyId=1&isfromportal=0&isfromhp=0";
    }else{
        initsrcpage="/docs/news/NewsDsp.jsp";
    }
}

String gopage = Util.null2String(request.getParameter("gopage"));
String frompage = Util.null2String(request.getParameter("frompage"));
if(!gopage.equals("")){
    gopage=URLDecoder.decode(gopage);
    if(!"".equals(frompage)){
        initsrcpage = gopage+"&message=1&id="+user.getUID();
    }else{
        initsrcpage = gopage;
    }
}
else {
    username = user.getUsername() ;
    userid = ""+user.getUID() ;
    if(logintype.equals("2")){
        switch(targetid) {
            case 1:                                                 // 文档  - 新闻
                initsrcpage = "/docs/news/NewsDsp.jsp?id=1" ;
                break ;
            case 2:                                                 // 人力资源 - 新闻
                initsrcpage = "/docs/news/NewsDsp.jsp?id=2" ;
                break ;
            case 3:                                                 // 财务 - 组织结构
                initsrcpage = "/org/OrgChart.jsp?charttype=F" ;
                break ;
            case 4:                                                 // 物品 - 搜索页面
                initsrcpage = "/lgc/catalog/LgcCatalogsView.jsp" ;
                break ;
            case 5:                                                 // CRM - 我的客户
                initsrcpage = "/CRM/data/ViewCustomer.jsp?CustomerID="+userid ;
                break ;
            case 6:                                                 // 项目 - 我的项目
                initsrcpage = "/proj/search/SearchOperation.jsp" ;
                break ;
            case 7:                                                 // 工作流 - 我的工作流
                initsrcpage = "/workflow/request/RequestView.jsp" ;
                break ;
            case 8:                                                 // 工作流 - 我的工作流
                initsrcpage = "/system/SystemMaintenance.jsp" ;
                break ;
            case 9:                                                 // 工作流 - 我的工作流
                initsrcpage = "/cpt/CptMaintenance.jsp" ;
                break ;
        }
    }else{
        switch(targetid) {
            case 1:                                                 // 文档  - 新闻
                initsrcpage = "/docs/report/DocRp.jsp" ;
                break ;
            case 2:                                                 // 人力资源 - 新闻
                initsrcpage = "/hrm/report/HrmRp.jsp" ;
                break ;
            case 3:                                                 // 财务 - 组织结构
                initsrcpage = "/fna/report/FnaReport.jsp" ;
                break ;
            case 4:                                                 // 物品 - 搜索页面
                initsrcpage = "/lgc/report/LgcRp.jsp" ;
                break ;
            case 5:                                                 // CRM - 我的客户
                initsrcpage = "/CRM/CRMReport.jsp" ;
                break ;
            case 6:                                                 // 项目 - 我的项目
                initsrcpage = "/proj/ProjReport.jsp" ;
                break ;
            case 7:                                                 // 工作流 - 我的工作流
                initsrcpage = "/workflow/WFReport.jsp" ;
                break ;
            case 8:                                                 // 工作流 - 我的工作流
                initsrcpage = "/system/SystemMaintenance.jsp" ;
                break ;
            case 9:                                                 // 工作流 - 我的工作流
                initsrcpage = "/cpt/report/CptRp.jsp" ;
                break ;
        }
    }
}
if(!relogin0.equals("1")&&frommain.equals("yes")){
logmessages=(Map)application.getAttribute("logmessages");
logmessages.put(""+user.getUID(),logmessage);
}

logmessages=(Map)application.getAttribute("logmessages");
logmessages.put(""+user.getUID(),logmessage);

if(!relogin0.equals("1")&&!frommain.equals("yes")&&!logmessage.equals("")){

session.setAttribute("frommain","true");
%>
<script language=javascript>

    flag=confirm("<%=SystemEnv.getHtmlLabelName(16643,user.getLanguage())%>!\n<%=SystemEnv.getHtmlLabelName(2023,user.getLanguage())%>:"+"<%=logmessage%>");
    if(flag)
    //window.location="/main.jsp?frommain=yes&gopage=<%=gopage%>"
    else
    window.location="/login/Login.jsp"
</script>
<%}%>

<%if(relogin0.equals("1")&&!logmessage.equals("")){%>
<script language=javascript>
    //alert("<%=SystemEnv.getHtmlLabelName(16643,user.getLanguage())%>!\n<%=SystemEnv.getHtmlLabelName(27892,user.getLanguage())+SystemEnv.getHtmlLabelName(2023,user.getLanguage())%>:"+"<%=logmessage%>");
    jQuery(function () {
		Dialog.alert("<%=SystemEnv.getHtmlLabelName(16643,user.getLanguage())%>!<br><%=SystemEnv.getHtmlLabelName(27892,user.getLanguage())+SystemEnv.getHtmlLabelName(2023,user.getLanguage())%>:"+"<%=logmessage%>"
			,function(){}, 372, 70, false
		);
	});
</script>
<%}%>
<script language=javascript>
function goMainFrame(o){
    o.contentWindow.document.frames[1].document.location.href = "<%=initsrcpage%>";    
}
 
//------------------------------------
//个人计划生成部分 Start
//------------------------------------
</script>


<%
//------------------------------------
//usb key检测部分 Start
//------------------------------------
if(needusb0==1&&"2".equals(usbtype0)){  
    String randLong = ""+Math.random()*1000000000;
    String serialNo = user.getSerial();
    HTSrvAPI htsrv = new HTSrvAPI();
    String sharv = "";
    sharv = htsrv.HTSrvSHA1(randLong, randLong.length());
    sharv = sharv + "04040404";
    String ServerEncData = htsrv.HTSrvCrypt(0, serialNo, 0, sharv);
%>
<script language="JavaScript"  src="/js/htusbjs.js"></script>
<script language="vbs"  src="/js/htusb.vbs"></script>
<OBJECT id="htactx" name="htactx" classid="clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E" codebase="HTActX.cab#version=1,0,0,1" style="HEIGHT: 0px; WIDTH: 0px;display:none"></OBJECT>
<script language="JavaScript">
var usbuserloginid = "<%=user.getLoginid()%>";
var usblanguage = "<%=user.getLanguage()%>";
var ServerEncData = "<%=ServerEncData%>";
var randLong = "<%=randLong%>";
var password = "<%=user.getPwd()%>";
checkusb();
</script>

<%
}
//------------------------------------
//usb key检测部分 End
//------------------------------------
%>



<!-- //------------------------------------  -->
<!-- //页面关闭时，提示脚本 Start -->
<!-- //------------------------------------ -->
<%@ include file="/favourite/FavouriteShortCut.jsp" %>
<script>   
    var con=null;
    window.onbeforeunload=function(){   
    	if(!isMesasgerUnavailable && glbreply == true){
            return "<%=SystemEnv.getHtmlLabelName(24985,user.getLanguage())%>";
        }   
    }  
    window.onunload=function(e){
		e=e||event;
        var   n   =   e.screenX   -   window.screenLeft;      
        var   b   =   n   >   document.documentElement.scrollWidth-20;   
        if(b   &&   e.clientY   <   0   ||   e.altKey) {          
            $.get("/login/LogoutForMain.jsp");
        }
        <%
        boolean isHaveMessager=Prop.getPropValue("Messager","IsUseWeaverMessager").equalsIgnoreCase("1");
        isHaveMessager=true;
        int isHaveMessagerRight =PluginUserCheck.checkPluginUserRight("messager",user.getUID()+"");
        if(isHaveMessager&&!userid.equals("1")&&isHaveMessagerRight==1){%>
            logoutForMessager();
        <%
        }
        %>
    }
</script>

<!-- //------------------------------------  -->
<!-- //页面关闭时，提示脚本 End -->
<!-- //------------------------------------ -->


<script>
//------------------------------------
//鼠标右键部分 Start
//------------------------------------
/*
document.oncontextmenu=""
search.searchvalue.oncontextmenu=showRightClickMenu1

function showRightClickMenu1(){
    var o = document.getElementById("leftFrame").contentWindow.document.getElementById("mainFrame");
    if(o.workSpaceLeft!=null)
        o.workSpaceLeft.rightMenu.style.visibility="hidden";
    if(o.workSpaceInfo!=null)
        o.workSpaceInfo.rightMenu.style.visibility="hidden";
    if(o.workSpaceRight!=null)
        o.workSpaceRight.rightMenu.style.visibility="hidden";
    if(o.workplanLeft!=null)
        o.workplanLeft.rightMenu.style.visibility="hidden";
    if(o.workplanRight!=null)
        o.workplanRight.rightMenu.style.visibility="hidden";
        showRightClickMenu();
}
*/
//------------------------------------
//鼠标右键部分 End
//------------------------------------
</script>



<% 
//------------------------------------
//文档弹出窗口 Start
//------------------------------------
String docsid = "";
String pop_width = "";
String pop_hight = "";
String is_popnum = "";
String popupsql = "select docid,pop_num,pop_hight,pop_width,is_popnum from DocDetail  t1, "+tables+"  t2,DocPopUpInfo t3 where t1.id=t2.sourceid and t1.id = t3.docid and (t1.ishistory is null or t1.ishistory = 0) and (t3.pop_startdate <= '"+CurrentDate+"' and t3.pop_enddate >= '"+CurrentDate+"') and pop_num > is_popnum";
RecordSet.executeSql(popupsql); 
while(RecordSet.next()){ 
docsid = RecordSet.getString("docid");
pop_hight = RecordSet.getString("pop_hight");
pop_width = RecordSet.getString("pop_width");
is_popnum = RecordSet.getString("is_popnum");
if("".equals(pop_hight)) pop_hight = "500";
if("".equals(pop_width)) pop_width = "600";
%>
<script language=javascript> 
  var is_popnum = <%=is_popnum%>;
  var docsid = <%=docsid%>;
  var pop_hight = <%=pop_hight%>;
  var pop_width = <%=pop_width%>;
  var docid_num = docsid +"_"+ is_popnum;
  window.open("/docs/docs/DocDsp.jsp?popnum="+docid_num,"","height="+pop_hight+",width="+pop_width+",scrollbars,resizable=yes,status=yes,Minimize=yes,Maximize=yes");
</script> 
<%
}
//------------------------------------
//文档弹出窗口 End
//------------------------------------
%>



<SCRIPT language=javascript>
//------------------------------------
//RTX客户端打开 Start
//------------------------------------
function openRtxClient(){
    document.all("rtxClient").src="/RTXClientOpen.jsp?notify=true";
}
function openEimClient(){
    document.all("rtxClient").src="/EimClientOpen.jsp";
}
//------------------------------------
//RTX客户端打开 End
//------------------------------------

//------------------------------------
//左侧菜单和顶部隐藏 Start
//------------------------------------
function mnToggleleft(){
}
function mnToggletop(){
}
//------------------------------------
//左侧菜单和顶部隐藏 END
//------------------------------------


//------------------------------------
//多账号 Start
//------------------------------------
/*
var firstTime = new Date().getTime();
function setAccountSelect(){
    var nowTime = new Date().getTime();
    if((nowTime-firstTime) < 10000){
        setTimeout(function(){setAccountSelect();},1000);
    }else{
        try{
            document.getElementById("accountSelect").disabled = false;
        }catch(e){}
    }
}
setAccountSelect();
*/
//------------------------------------
//多账号 end
//------------------------------------
</SCRIPT>

<!-- //------------------------------------  -->
<!-- //显示版本 Start                    -->
<!-- //------------------------------------  -->
<script language="vbs">
'sub showVersion()
'    about=window.showModalDialog("/systeminfo/version.jsp",,"dialogHeight:376px;dialogwidth:466px;help:no")
'end sub
</script>
<!-- //------------------------------------  -->
<!-- //显示版本 End                    -->
<!-- //------------------------------------  -->
<script language="javascript" src="/js/Cookies.js"></script>

<!-- //------------------------------------  -->
<!-- //消息提醒 start                    -->
<!-- //------------------------------------  -->
<%if(!Util.null2String(user.getLogintype()).equals("2")){%>
    <iframe BORDER=0 FRAMEBORDER=no NORESIZE=NORESIZE width=0 height=0 SCROLLING=no SRC=/system/SysRemind.jsp></iframe>
<%}%>
<!-- //------------------------------------  -->
<!-- //消息提醒 End                    -->
<!-- //------------------------------------  -->
<%
HrmUserSettingHandler handler = new HrmUserSettingHandler();
HrmUserSetting setting = handler.getSetting(user.getUID());

boolean rtxOnload = setting.isRtxOnload();

if(rtxClient.isValidOfRTX() && rtxOnload){
	String rtxorelinkurl = "";
	RTXConfig rtxConfig = new RTXConfig();
	String RtxOrElinkType = (Util.null2String(rtxConfig.getPorp(RTXConfig.RtxOrElinkType))).toUpperCase();
	if("ELINK".equals(RtxOrElinkType)){ 
		rtxorelinkurl = "EimClientOpen.jsp";
	} else {
		rtxorelinkurl = "RTXClientOpen.jsp";
	}
%>
<iframe name="rtxClient" src="/<%=rtxorelinkurl%>" style="display:none"></iframe>
<%} else { %>
<iframe name="rtxClient" src="" style="display:none"></iframe>
<%}%>