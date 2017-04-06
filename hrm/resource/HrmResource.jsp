<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,
                 weaver.file.Prop,
                 weaver.login.Account,
				 weaver.login.VerifyLogin,
                 weaver.general.GCONST" %>
<%@ page import="java.util.*" %>

<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.systeminfo.sysadmin.HrmResourceManagerVO"%>
<%@ page import="weaver.systeminfo.sysadmin.HrmResourceManagerDAO"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RelatedRequestCount" class="weaver.workflow.request.RelatedRequestCount" scope="page"/>
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>
<jsp:useBean id="HrmListValidate" class="weaver.hrm.resource.HrmListValidate" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="MouldStatusCominfo" class="weaver.systeminfo.MouldStatusCominfo"></jsp:useBean>
<% if(!(user.getLogintype()).equals("1")) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
<style>
	#loading {
	Z-INDEX: 20001; BORDER-BOTTOM: #ccc 1px solid; POSITION: absolute; BORDER-LEFT: #ccc 1px solid; PADDING-BOTTOM: 8px; PADDING-LEFT: 8px; PADDING-RIGHT: 8px; BACKGROUND: #ffffff; HEIGHT: auto; BORDER-TOP: #ccc 1px solid; BORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 8px; TOP: 40%; LEFT: 45%
}

</style>
</head>

<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);    
String id = Util.null2String(request.getParameter("id"));
if(id.equals("")) id=String.valueOf(user.getUID());
if( id.equals("1") ) {
    if( user.getUID() == 1) {
        response.sendRedirect("/hrm/resource/HrmResourcePassword.jsp?id="+id) ;
        return ;
    }
    else {
        response.sendRedirect("/notice/hrmsystem.jsp") ;
        return ;
    }
}

//update by fanggsh TD4233 begin
HrmResourceManagerDAO dao = new HrmResourceManagerDAO();
HrmResourceManagerVO vo = dao.getHrmResourceManagerByID(id);

if(vo.getId()!=null&&!(vo.getId()).equals(""))
{
	if(vo.getId().equals(String.valueOf(id))){
        response.sendRedirect("/hrm/resource/HrmResourcePassword.jsp?id="+id) ;
        return ;
	}else{
        response.sendRedirect("/notice/hrmsystem.jsp") ;
        return ;
	}
}
//update by fanggsh TD4233 end

//get request count
/*int tempid=Util.getIntValue(id,0);
RelatedRequestCount.resetParameter();
RelatedRequestCount.setUserid(user.getUID());
RelatedRequestCount.setUsertype(0);
RelatedRequestCount.setRelatedid(tempid);
RelatedRequestCount.setRelatedtype("hrmresource");
RelatedRequestCount.selectRelatedCount();
*/
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
RecordSet.executeProc("HrmResource_SelectByID",id);
RecordSet.next();


/*
�Ա�:
0:����
1:Ů��
2:δ֪
*/
String departmentid = Util.toScreen(RecordSet.getString("departmentid"),user.getLanguage()) ;		/*��������*/
String costcenterid = Util.toScreen(RecordSet.getString("costcenterid"),user.getLanguage()) ;
String subcompanyid = Util.toScreen(RecordSet.getString("subcompanyid1"),user.getLanguage()) ;
String lastname = Util.toScreen(RecordSet.getString("lastname"),user.getLanguage()) ;			/*����*/
if(subcompanyid==null||subcompanyid.equals("")||subcompanyid.equalsIgnoreCase("null"))
 subcompanyid="-1";
session.setAttribute("hrm_subCompanyId",subcompanyid);



/*
������Դ����:
�а���: F
ְԱ: H
ѧ��: D
*/


String createrid = Util.toScreen(RecordSet.getString("createrid"),user.getLanguage()) ;		/*������id*/

String createdate = Util.toScreen(RecordSet.getString("createdate"),user.getLanguage()) ;	/*��������*/
String lastmodid = Util.toScreen(RecordSet.getString("lastmodid"),user.getLanguage()) ;		/*����޸���id*/
String lastmoddate = Util.toScreen(RecordSet.getString("lastmoddate"),user.getLanguage()) ;	/*�޸�����*/
String lastlogindate = Util.toScreen(RecordSet.getString("lastlogindate"),user.getLanguage()) ;	/*����¼����*/

String jobtype = Util.toScreenToEdit(RecordSet.getString("jobtype"),user.getLanguage()) ;	/*ְ�����*/
String seclevel = Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage()) ;			/*��ȫ����*/


/*��ʾȨ���ж�*/
int userid = user.getUID();

boolean isSelf		=	false;
boolean isManager	=	false;
boolean displayAll	=	false;
boolean isHr = false;

boolean isSys = ResourceComInfo.isSysInfoView(userid,id);
boolean isFin = ResourceComInfo.isFinInfoView(userid,id);
boolean isCap = ResourceComInfo.isCapInfoView(userid,id);
//boolean isCreater = ResourceComInfo.isCreaterOfResource(userid,id);

AllManagers.getAll(id);
if(HrmUserVarify.checkUserRight("HrmResourceEdit:Edit",user,departmentid)){
  isHr = true;
}
if(HrmUserVarify.checkUserRight("HrmResource:Display",user))  {
	displayAll		=	true;
}
/*
if(!((currentdate.compareTo(startdate)>=0 || startdate.equals(""))&& (currentdate.compareTo(enddate)<=0 || enddate.equals("")))){
	if (!displayAll){
		response.sendRedirect("/notice/noright.jsp") ;
		return ;
	}
}
*/

if (id.equals(""+user.getUID()) ){
	isSelf = true;
}

while(AllManagers.next()){
	String tempmanagerid = AllManagers.getManagerID();
	if (tempmanagerid.equals(""+user.getUID())) {
		isManager = true;
	}
}

// �ж��Ƿ���Բ鿴����Ԥ��
boolean canviewbudget = HrmUserVarify.checkUserRight("FnaBudget:All",user, departmentid) ;
boolean caneditbudget =  HrmUserVarify.checkUserRight("FnaBudgetEdit:Edit", user) &&  (""+user.getUserDepartment()).equals(departmentid) ;
boolean canapprovebudget = HrmUserVarify.checkUserRight("FnaBudget:Approve",user) ;

boolean canlinkbudget = canviewbudget || caneditbudget || canapprovebudget || isSelf ;

// �ж��Ƿ���Բ鿴������֧
boolean canviewexpense = HrmUserVarify.checkUserRight("FnaTransaction:All",user, departmentid) ;
boolean canlinkexpense = canviewexpense || isSelf ;

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage());

titlename="<B>"+SystemEnv.getHtmlLabelName(125,user.getLanguage())+":&nbsp;</B>"+createdate+"&nbsp;&nbsp;<b>"+SystemEnv.getHtmlLabelName(271,user.getLanguage())+":&nbsp;</b><A href=HrmResource.jsp?id="+createrid+">"+Util.toScreen(ResourceComInfo.getResourcename(createrid),user.getLanguage())+"</A>&nbsp;&nbsp;<B>"+SystemEnv.getHtmlLabelName(103,user.getLanguage())+":&nbsp;</B>"+lastmoddate+"&nbsp;&nbsp;<B>"+SystemEnv.getHtmlLabelName(424,user.getLanguage())+":&nbsp;</B><A href=HrmResource.jsp?id="+lastmodid+">"+Util.toScreen(ResourceComInfo.getResourcename(lastmodid),user.getLanguage())+"</A>&nbsp;&nbsp;";
String needfav ="1";
String needhelp ="";
String newtitlename = SystemEnv.getHtmlLabelName(411,user.getLanguage())+":"+lastname;
%>
<BODY scroll="no"> 
<DIV style="" id=loading><SPAN><IMG align=absMiddle src="/images/loading2.gif"></SPAN> <SPAN id=loading-msg><%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%></SPAN> </DIV>
<%
	session.setAttribute("fav_pagename" , newtitlename ) ;	
%>
<%
String arrOtherTab="[";

arrOtherTab+="{	title:'"+SystemEnv.getHtmlLabelName(1361,user.getLanguage())+" ',autoScroll : true,url:'/hrm/resource/HrmResourceBase.jsp?id="+id+"',id:'t1361'}";
arrOtherTab+=",{	title:'"+SystemEnv.getHtmlLabelName(30804,user.getLanguage())+" ',autoScroll : true,url:'/hrm/resource/HrmResourceTotal.jsp?id="+id+"',id:'t410'}";//SystemEnv.getHtmlLabelName(410,user.getLanguage())

int detachable=0;
if(session.getAttribute("detachable")!=null){
    detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
}else{
    rs.executeSql("select detachable from SystemSet");
    if(rs.next()){
        detachable=rs.getInt("detachable");
        session.setAttribute("detachable",String.valueOf(detachable));
    }
}
int operatelevel=-1;
if(detachable==1){
    operatelevel=CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(),"HrmResourceEdit:Edit",Integer.parseInt(subcompanyid));
}else{
    if(HrmUserVarify.checkUserRight("HrmResourceEdit:Edit", user))
        operatelevel=2;
}
int operatelevelnew = -1;
if(detachable==1){
	operatelevelnew=CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(),"ResourcesInformationSystem:All",Integer.parseInt(subcompanyid));
}else{
    if(HrmUserVarify.checkUserRight("ResourcesInformationSystem:All", user))
    	operatelevelnew=2;
}

//xiaofeng
String mode=Prop.getPropValue(GCONST.getConfigFile() , "authentic");
if(isSelf&&HrmListValidate.isValidate(16)&&!(mode!=null&&mode.equals("ldap"))){
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(409,user.getLanguage())+"',url:'/hrm/resource/HrmResourcePassword.jsp?id="+id+"',id:'t409'}";
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(409,user.getLanguage())+",/hrm/resource/HrmResourcePassword.jsp?id="+id+",_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
}
if(software.equals("ALL") || software.equals("HRM")){
     if((isSelf||operatelevel>=0)&&HrmListValidate.isValidate(11)){
    	 arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(15687,user.getLanguage())+"',url:'/hrm/resource/HrmResourcePersonalView.jsp?id="+id+"',id:'t15687'}";
		 //RCMenu += "{"+SystemEnv.getHtmlLabelName(15687,user.getLanguage())+",/hrm/resource/HrmResourcePersonalView.jsp?id="+id+"&isView=1,_self} " ;
		 //RCMenuHeight += RCMenuHeightStep ;
     }
if((isSelf||isManager||operatelevel>=0)&&HrmListValidate.isValidate(12)){
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(15688,user.getLanguage())+"',url:'/hrm/resource/HrmResourceWorkView.jsp?id="+id+"',id:'t15688'}";
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(15688,user.getLanguage())+",/hrm/resource/HrmResourceWorkView.jsp?id="+id+"&isView=1,_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
 }
if(isgoveproj==0){
if((isSelf||operatelevel>=0||isFin || isManager)&&HrmListValidate.isValidate(13)){
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(16480,user.getLanguage())+"',url:'/hrm/resource/HrmResourceFinanceView.jsp?id="+id+"&isView=1',id:'t16480'}";
	//xiaofeng RCMenu += "{"+SystemEnv.getHtmlLabelName(15805,user.getLanguage())+",/hrm/resource/HrmResourceFinanceView.jsp?id="+id+"&isView=1,_self} " ;
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(16480,user.getLanguage())+",/hrm/resource/HrmResourceFinanceView.jsp?id="+id+"&isView=1,_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
}
}
if((isSelf||operatelevel>=0 || isCap)&&HrmListValidate.isValidate(14)&&"1".equals(MouldStatusCominfo.getStatus("cpt"))){
	//modified by lupeng 2004.2.6
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(15806,user.getLanguage())+",/cpt/search/CptMyCapital.jsp?id="+id+",_self} " ;
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(15806,user.getLanguage())+",/cpt/search/SearchOperation.jsp?resourceid="+id+"&isdata=2,_self} " ;
	//end
	//RCMenuHeight += RCMenuHeightStep ;
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(15806,user.getLanguage())+"',url:'/cpt/search/SearchOperation.jsp?resourceid="+id+"&isdata=2',id:'t15806'}";
}
}
if((isSelf||operatelevelnew>=0||isSys)&&HrmListValidate.isValidate(15)){
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(15804,user.getLanguage())+",/hrm/resource/HrmResourceSystemView.jsp?id="+id+"&isView=1,_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(15804,user.getLanguage())+"',url:'/hrm/resource/HrmResourceSystemView.jsp?id="+id+"&isView=1',id:'t15804'}";
}
if((isSelf || isManager || HrmUserVarify.checkUserRight("HrmResource:Workflow",user,departmentid))&&HrmListValidate.isValidate(17)){
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(259,user.getLanguage())+",/workflow/request/RequestView.jsp?resourceid="+id+",_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(259,user.getLanguage())+"',url:'/workflow/request/RequestView.jsp?resourceid="+id+"',id:'t259'}";
}
if((isSelf || isManager || HrmUserVarify.checkUserRight("HrmResource:Plan",user,departmentid))&&HrmListValidate.isValidate(18) ) {
	
	arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(407,user.getLanguage())+"',url:'/workplan/data/WorkPlan.jsp?resourceid="+id+"',id:'t407'}";
}
//added by lupeng 2004-07-08


if(HrmUserVarify.checkUserRight("HrmResource:Log",user,departmentid) ){
	if(HrmListValidate.isValidate(23)){
	    if(rs.getDBType().equals("db2")){
	        //RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where int(operateitem)=29 and relatedid="+id+",_self} " ;
	        arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+"',url:'/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where int(operateitem)=29 and relatedid="+id+"',id:'t83'}";
	    }else{
			//RCMenu += "{"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+",/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem=29 and relatedid="+id+",_self} " ;
			arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(83,user.getLanguage())+"',url:'/systeminfo/SysMaintenanceLog.jsp?sqlwhere=where operateitem=29 and relatedid="+id+"',id:'t83'}";
	    }
		//RCMenuHeight += RCMenuHeightStep ;
	}
	}
	if(isgoveproj==0){
		if(software.equals("ALL") || software.equals("HRM")){
		    if(isSelf || isManager || HrmUserVarify.checkUserRight("HrmResource:Absense",user,departmentid)) {
		        if(HrmListValidate.isValidate(20)){
					//RCMenu += "{"+SystemEnv.getHtmlLabelName(15880,user.getLanguage())+",/hrm/resource/HrmResourceAbsense.jsp?resourceid="+id+",_self} " ;
					//RCMenuHeight += RCMenuHeightStep ;
					arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(15880,user.getLanguage())+"',url:'/hrm/resource/HrmResourceAbsense.jsp?resourceid="+id+"',id:'t15880'}";
		        }
		    }
		if(isSelf||isManager||HrmUserVarify.checkUserRight("HrmResource:TrainRecord",user)) {
			if(HrmListValidate.isValidate(21)){
				//RCMenu += "{"+SystemEnv.getHtmlLabelName(816,user.getLanguage())+",/hrm/resource/HrmResourceTrainRecord.jsp?resourceid="+id+",_self} " ;
				//RCMenuHeight += RCMenuHeightStep ;
				arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(816,user.getLanguage())+"',url:'/hrm/resource/HrmResourceTrainRecord.jsp?resourceid="+id+"',id:'t816'}";
			}
		}
		if(isSelf||isManager||HrmUserVarify.checkUserRight("HrmResource:RewardsRecord",user)) {
			if(HrmListValidate.isValidate(22)){
				//RCMenu += "{"+SystemEnv.getHtmlLabelName(16065,user.getLanguage())+",HrmResourceRewardsRecord.jsp?resourceid="+id+",_self} " ;
				//RCMenuHeight += RCMenuHeightStep ;
				arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(16065,user.getLanguage())+"',url:'HrmResourceRewardsRecord.jsp?resourceid="+id+"',id:'t16065'}";
			}
		}
	}
}
	
boolean roleseeflag = false;
String rolesqlstr = "select * from (select distinct subcompanyid from SysRoleSubcomRight "+
"where roleid in (select roleid from Hrmrolemembers where resourceid = "+userid+")) a "+
"where a.subcompanyid = (select subcompanyid1 from hrmresource where id = "+id+")";
RecordSet.executeSql(rolesqlstr);
if(RecordSet.next()) roleseeflag = true;
if(userid == 1) roleseeflag = true;

//�жϸ��û��Ա༭��Ա�����Ƿ���еĽ�ɫά��Ȩ��(TD19119)
boolean rolesmanage = false;
int varifylevel=-1;
if(detachable==1){
    varifylevel = CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(), "HrmRolesEdit:Edit", Integer.parseInt(subcompanyid));
}else{
    if(HrmUserVarify.checkUserRight("HrmRolesEdit:Edit", user))
        varifylevel=2;
}
if(varifylevel > 0) {
	rolesmanage = true;
}

if(HrmUserVarify.checkUserRight("HrmResourceEdit:Edit", user) && roleseeflag && rolesmanage){
 arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(16527,user.getLanguage())+"',url:'/hrm/roles/HrmResourceNewRoles.jsp?resourceid="+id+"',id:'t16527'}";
}

arrOtherTab+="]";
%>

<script language=javascript>
	var arrOtherTab=eval(<%=arrOtherTab%>);
	var tablist="";
	var fistTabItem="";
	var iframeList="";
		for(var item=0;item<arrOtherTab.length;item++){
		if(item==0){
			
			tablist+="<li  sid='"+arrOtherTab[item].id+"'  first=yes url='"+arrOtherTab[item].url+"&isfromtab=true"+"'><div class=\"tab-selected tab-item\" ><a  href='javascript:void(0)'  >"+arrOtherTab[item].title+"</a></div><li>";
			iframeList+=" <iframe src='/hrm/resource/HrmResourceBase.jsp?id=<%=id %>'  id='iframepage'  frameBorder=0 scrolling=auto width=100% height='100%' onload=\"loading()\"  style='display:block;'></iframe>";
			 
		} else{
			tablist+="<li  sid='"+arrOtherTab[item].id+"'   url='"+arrOtherTab[item].url+"&isfromtab=true"+"'><div class=\"tab-item\" ><a  href='javascript:void(0)'>"+arrOtherTab[item].title+"</a></div><li>";
			//iframeList+=" <iframe src=''  id='"+arrOtherTab[item].id+"'  frameBorder=0 scrolling=no width='100%' onload='iFrameHeight()'  style='display:none;'></iframe>";
		}
	}
	
</script>
<table width="100%" style="min-width:820px;height:100%;">
	<colgroup>
		<col width="5">
		<col width="">
		<col width="5">
	</colgroup>
	<tr style="height:1px;">
		<td></td>
		<td>
			
			<table cellpadding="0" cellspacing="0" width="100%" border="0">
			  	<tr>
			  		<td width="6px" height="28px;" style="">
						<div id="tab-left" class="tab-left-selected" style="">
							
						</div>
					</td>
					<td>
						<div id="tab-center" >
							<ul>
								<script>
									document.write(tablist);
								</script>
							</ul>
						</div>
					</td>
					<td width="6px" style="">
						<div id="tab-right" style=""></div>
					</td>
			  	</tr>
	  		</table>
 
		
		</td>
		<td></td>
			
	</tr>
	<tr style="height:100%">
		<td colspan="3" style="height:100%">
			
		  <div id="content" style="height:100%">
						<script>
							 document.write(iframeList);
						</script>
		
		  </div>
		</td>
	</tr>
</table>


<script type="text/javascript" language="javascript">   
	  function loading(){
		  $("#loading").hide();
	 }

	$("#tab-left").addClass("tab-left-selected");
	
	$(function(){
		initMenuWidth();
		$("#tab-center li").click(function(){
			
			$("#tab-center li .tab-selected").removeClass("tab-selected");
			$(this).children("div").addClass("tab-selected");
			$("#content iframe").css("display","none");
			var temid=$(this).attr("sid");
			if($(this).attr("first")=="yes"){
				$("#tab-left").removeClass("tab-left-unselected");
				$("#tab-left").addClass("tab-left-selected");
				
				$("#iframepage").css("display","block");
				
			}else{
				$("#tab-left").removeClass("tab-left-selected");
				$("#tab-left").addClass("tab-left-unselected");
				if($("#"+$(this).attr("sid")).attr("src")==undefined){
				  $("#content").append(	" <iframe src=''  id='"+$(this).attr("sid")+"'  frameBorder=0 onload=\"loading()\" scrolling=auto width='100%'  height='100%' onload='loading();'  style='display:none;'></iframe>");
				  $("#"+$(this).attr("sid")).attr("src",$(this).attr("url")).load(function(){});
					$("#loading").hide();
					$("#loading").show();
				}else{
					$("#loading").hide();
				}
			}
		
			
				$("#"+$(this).attr("sid")).css("display","block");
		});
		window.onresize=function(){
			var ifms=document.getElementsByTagName("iframe");
			for(var i=0;i<ifms.length;i++ ){
				ifms[i].height=document.body.clientHeight-getElementTop(ifms[i])-3;
			}
		}
	});
	function getElementTop(element){
	��������var actualTop = element.offsetTop;
	��������var current = element.offsetParent;

	��������while (current !== null){
	������������actualTop += current.offsetTop;
	������������current = current.offsetParent;
	��������}

	��������return actualTop;
	����}
	function initMenuWidth(){
		var tabWidth=0;
		$("#tab-center li").each(function(e,e2){
			tabWidth+=$(e2).width();
		});
		$("#tab-center ul").css("width",tabWidth+10);
	}
</script>

</BODY>
</HTML>