<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.settings.RemindSettings" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.email.domain.*" %>
<%@ page import="weaver.docs.category.security.AclManager" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="mss" class="weaver.email.service.MailSettingService" scope="page" />
<jsp:useBean id="mrs" class="weaver.email.service.MailResourceService" scope="page" />
<jsp:useBean id="mas" class="weaver.email.service.MailAccountService" scope="page" />
<jsp:useBean id="mfs" class="weaver.email.service.MailFolderService" scope="page" />
<jsp:useBean id="lms" class="weaver.email.service.LabelManagerService" scope="page" />
<jsp:useBean id="fms" class="weaver.email.service.FolderManagerService" scope="page" />
<link href="/email/css/base.css" rel="stylesheet" type="text/css" />

<link href="/email/css/base.css" rel="stylesheet" type="text/css" />

<%

	User user = HrmUserVarify.getUser (request , response) ;
	if(user == null)  return ;
	String method = Util.null2String(request.getParameter("method"));
	String checkuser=Util.null2String(request.getParameter("checkuser"));
	mss.selectMailSetting(user.getUID());
	int userLayout = Util.getIntValue(mss.getLayout(),0);
	
	int isInternal = Util.getIntValue(request.getParameter("isInternal"),-1);
	String receivemailid = Util.null2String(request.getParameter("receivemailid"));
	String star = Util.null2String(request.getParameter("star"));
	String labelid = Util.null2String(request.getParameter("labelid"));
	String folderid = Util.null2String(request.getParameter("folderid"));	
	String receivemail = Util.null2String(request.getParameter("receivemail"));	
	String subject = Util.null2String(request.getParameter("subject"));		
	String from = Util.null2String(request.getParameter("from"));
	String to = Util.null2String(request.getParameter("to"));		
	String status = Util.null2String(request.getParameter("status"));	
	String mailaccountid = Util.null2String(request.getParameter("mailaccountid"));
	String attachmentnumber = Util.null2String(request.getParameter("attachmentnumber"));	
	String startdate = Util.null2String(request.getParameter("startdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	//clickObj=0����ǡ�ȫ��",=1�������"δ��",=2�������ĳ����ǩ,=""���ǵ����ȫ����δ������ǩ����������
	String clickObj=Util.null2String(request.getParameter("clickObj"));
	//1��ʾ��ǩ����ҳ���������ģ�������ͨ�������ӵ��������
	String labelidchecked=Util.null2String(request.getParameter("labelidchecked"));
	
	if(userLayout==3){
		Object obj=session.getAttribute("newEmailurl");
		if(null!=obj){
			//���������ΪNull,��ʾ������Դ��/email/new/MailInboxListMain.jsp,��Ҫ���ò���
			String newEmailurl=obj+"";
			String newurl[]=newEmailurl.split("@");
			if(null!=newurl&&newurl.length>=16){
							isInternal=Util.getIntValue(newurl[0],-1);
							receivemailid=newurl[1];
							star=newurl[2];
							labelid=newurl[3];
							folderid=newurl[4];
							receivemail=newurl[5];
							subject=newurl[6];
							from=newurl[7];
							to=newurl[8];
							status=newurl[9];
							mailaccountid=newurl[10];
							attachmentnumber=newurl[11];
							startdate=newurl[12];
							enddate=newurl[13];
							labelidchecked=newurl[14];
							clickObj=newurl[15].trim();
						
			}
			//���������
			session.removeAttribute("newEmailurl");
		}
%>
		
		<script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js" charset="GBK"></script>
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js" ></script>
		<script type="text/javascript" src="/email/js/tzSelect/jquery.tzSelect.js"></script>
		<script type="text/javascript" src="/email/js/checkbox/jquery.checkbox.js"></script>
		<script type="text/javascript" src="/email/js/leanModal/jquery.leanModal.min.js"></script>
		<script language="javascript" defer="defer" src="/js/datetime.js"></script>
		<script language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
		<script language="javascript" defer="defer" src="/js/init.js"></script>
		<link rel="stylesheet" type="text/css" href="/email/js/tzSelect/jquery.tzSelect.css" />
		<link rel="stylesheet" type="text/css" href="/wui/theme/ecology7/skins/default/wui.css" />
		
		<script type="text/javascript" src="/email/joyride/jquery.cookie.js"></script>
		<script type="text/javascript" src="/email/joyride/modernizr.mq.js"></script>
		<script type="text/javascript" src="/email/joyride/jquery.joyride-1.0.5.js"></script>
		<link rel="stylesheet" href="/email/joyride/joyride-1.0.5.css">
		<link rel="stylesheet" href="/email/joyride/mobile.css">

	
		
<%
	}else{
%>
		<script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
		<script type="text/javascript" src="/email/js/tzSelect/jquery.tzSelect.js"></script>
		<script type="text/javascript" src="/email/js/checkbox/jquery.checkbox.js"></script>
		<script type="text/javascript" src="/email/js/leanModal/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/email/js/tzSelect/jquery.tzSelect.css" />
<%	
	}
	
	String receivemailname="";
	if(!receivemailid.equals("")){
		mas.setId(receivemailid);
		mas.selectMailAccount();
		if(mas.next()){
			receivemailname = mas.getAccountname();
		}
	}
	
	int index = Util.getIntValue(request.getParameter("index"),1);
	int perpage =20;
	
	mss.selectMailSetting(user.getUID());
	if(!Util.null2String(mss.getPerpage()).equals("")){
		perpage = Util.getIntValue(mss.getPerpage());
	}
	
	int layout = Util.getIntValue(mss.getLayout(),3);
	
	int main = Util.getIntValue(mss.getMainid(),-1);
	int sub = Util.getIntValue(mss.getSubid(),-1);
	int sec = Util.getIntValue(mss.getSecid(),-1);
	
	// �ĵ�����Ŀ¼����
	//mss.get
	
	mrs.resetParameter();
	
	//���ʼ���
	mrs.setResourceid(user.getUID()+"");
	mrs.setFolderid(folderid);
	mrs.setSubject(subject.trim());
	mrs.setLabelid(labelid);
	mrs.setStarred(star);
	mrs.setSendfrom(from);
	mrs.setSendto(to);
	//mrs.setStatus(status);
	mrs.setAttachmentnumber(attachmentnumber);
	mrs.setMailaccountid(mailaccountid);
	mrs.setIsInternal(isInternal);
	mrs.setStartdate(startdate);
	mrs.setEnddate(enddate);
	mrs.selectMailResource();
	int totalMailCount = mrs.getRecordCount();
	
	
	//String param = {"mailsId": needfulMailsId.toString(), "operation": "cancelLabel"};
	String param ="{";
			 param+="\"folderid\":\""+folderid+"\",";
			 param+="\"subject\":\""+subject.trim()+"\",";
			 param+="\"labelid\":\""+labelid+"\",";
			 param+="\"star\":\""+star+"\",";
			 param+="\"from\":\""+from+"\",";
			 param+="\"to\":\""+to+"\",";
			 param+="\"attachmentnumber\":\""+attachmentnumber+"\",";
			 param+="\"mailaccountid\":\""+mailaccountid+"\",";
			 param+="\"isInternal\":\""+isInternal+"\",";
			 param+="\"startdate\":\""+startdate+"\",";
			 param+="\"enddate\":\""+enddate+"\"";
			 param+="}";
	int unreadMailCount =0;

	if(!folderid.equals("-1")&&!folderid.equals("-2")){
		//��ȡδ���ʼ�����
		mrs.setStatus("");
		mrs.setStatus("0");
		mrs.selectMailResource();
		unreadMailCount = mrs.getRecordCount();
	}else if((folderid.equals("")&&!"".equals(labelid))||isInternal==1){
		//��ȡδ���ʼ�����
		mrs.setStatus("");
		mrs.setStatus("0");
		mrs.selectMailResource();
		unreadMailCount = mrs.getRecordCount();
	}
	
	//��¼��ȫ�����������Ա��ж��ٷ��ܵ�����
	int totalMailCountNew=0;
	if("0".equals(clickObj)){
		//˵���ǵ��ȫ���ĳ�����
		//��¼�ܵ�����
		totalMailCountNew=totalMailCount;
	}else if("1".equals(clickObj)){
		//˵���ǵ��δ���ʼ��ĳ�����-zzl
		//��¼�ܵ�����,��仰һ��Ҫ���ں�һ�仰ǰ��
		totalMailCountNew=totalMailCount;
		//��Ҫ��δ���ʼ��������������ʼ�����������ҳ��ͳ��
		totalMailCount=unreadMailCount;
	
	}else{
		//��¼�ܵ�����
		totalMailCountNew=totalMailCount;
	}

	int totalPage;
	if (totalMailCount % perpage == 0) {
        totalPage = totalMailCount / perpage;
    } else {
        totalPage = totalMailCount / perpage + 1;
    }

	if(receivemailid.equals("")){
		receivemailid =  mas.getAutoReceiveAccountIds(user.getUID());
	}
	
	
	String displayName ="";
	if(!folderid.equals("")){
		displayName = mfs.getSysFolderName(Util.getIntValue(folderid),user.getLanguage());
		if(displayName.equals("")){
			mfs.selectMailFolderInfo(Util.getIntValue(folderid));
			if(mfs.next()){
				displayName = mfs.getFolderName();
			}
		}
	}else if(!labelid.equals("")){
		displayName = lms.getLabelInfo(labelid).getName();
	}else if(isInternal==1){
		displayName =  SystemEnv.getHtmlLabelName(24714,user.getLanguage());
	}else{
		displayName = SystemEnv.getHtmlLabelName(81337,user.getLanguage());
	}
	
	if(method.equals("dosearch")){
		displayName = SystemEnv.getHtmlLabelName(81289,user.getLanguage()); 
	}
	
	
	
%>
<style>
*{		
	font-family:"΢���ź�"!important; 
}
</style>

<div id="mailListContainer" >
<div class="w-all h-all " >
	<div id="mailListTop">
	<!-- ͷ��start -->
	<div class="font12 color333 m-l-10 ">
			<div class="left">
				<span class="btnSpan  p-l-5 p-r-5  <%if("".equals(status)){out.println(" btnSpanOver selected");}%>" onclick="showMail(this)" target=''>
						<%=SystemEnv.getHtmlLabelName(332,user.getLanguage()) %>
						<span  id=totalMailCount_id>(<%=totalMailCountNew %>)</span>
				</span>
				-<span class="btnSpan p-l-5 p-r-5 <%if("0".equals(status)){out.println("btnSpanOver  selected");}%>" onclick="showMail(this)" target='0'  id="changeBk02"  _xuhao=0>
							<!-- δ�� -->
						<%=SystemEnv.getHtmlLabelName(25396,user.getLanguage()) %>
						<span id="unreadMailCount_id">(<%=unreadMailCount %>)</span>
				</span>
			</div>
			
			<!-- label��ǩ��ʾ����start -->
			<%
					if(!"".equals(labelid)&&"1".equals(labelidchecked)&&!"".equals(folderid)){
						//��ǩid��Ϊ�գ����������ǩid����ҳ�棬���������Բ˵�
						MailLabel  mailLabels = lms.getLabelInfo(labelid);
						String labelStr = "";
						labelStr+="<div class='label hand left' style='  background:"+mailLabels.getColor()+"'  _topmenu='1'>"
								+	"<div class='left lbName'>"+mailLabels.getName()+"</div>"
								+     "<input type='hidden' name='lableId' value='"+mailLabels.getId()+"' />"
								+     "<input type='hidden' name='mailId' value='' />"
								+	"<div class='left closeLb hand hide '   title='"+SystemEnv.getHtmlLabelName(81338,user.getLanguage())+"' name='sb'></div>"
								+ "<div class='cleaer'></div>"	
								+"</div>";
						out.println(labelStr);
						out.println("<input type='hidden' id='labelidchecked_true'>");
				}
			 %>
			<!-- label��ǩ��ʾ����end -->
			
			
			<div class="left w-100">&nbsp;</div>
			<div id="receiveLoading" class=" h-20 m-t-3 left p-r-5 hide colorfff" style="background: #499b3c;line-height: 20px;"><div class="left" style="background-image: url(/email/images/loading.gif);background-repeat:no-repeat;background-position: center;width: 20px;">&nbsp;</div><%=SystemEnv.getHtmlLabelName(81290,user.getLanguage()) %> <%=receivemailname %></div>
			<div class="clear"></div>
	</div>
	<div class="h-5 ">&nbsp;</div>
	<!-- ͷ��end -->
	
	<!-- �˵���--start -->
	<div id="inBoxTitle"    style="background: url(/email/images/inboxTitleBg.png) repeat-x;background-color: #f0f0f0" >
		
		<!-- ��߰�ť-start -->
		<div class="left  p-t-5" style="width: 500px;">
		<%if(!folderid.equals("-3")) {%>
		<button class="btnGray1 left" type="button" onclick="moveMail2DelFolder()"><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage()) %></button>
		<%}%>
		<button class="btnGray1 left" type="button" onclick="deleteCheckedMail()"><%=SystemEnv.getHtmlLabelName(2031,user.getLanguage()) %></button>
		<!--  <button class="btnGray1" type="button" onclick="doSubmit()">ת��</button> -->
		<!-- <button class="btnGray1 left" type="button" onclick="updateMailAsRead()">���Ϊ�Ѷ�</button>
		<!-- 
		<button class="btnGray1" type="button" onclick="doSubmit()">����</button>
		<button class="btnGray1" type="button" onclick="doSubmit()">�ƶ�</button>
		 -->
		<div class="btnGrayDrop relative left " id="saveAs" style="width: 80px;" _xuhao=1><%=SystemEnv.getHtmlLabelName(81292,user.getLanguage()) %>...
			<ul class="btnGrayDropContent hide" style="position: fixed;width: 92px;" >
				<li class="item" onclick="doExportDocs(event)"><%=SystemEnv.getHtmlLabelName(19821,user.getLanguage()) %></li>
				<li class="item" onclick="doExportContacts(event)"><%=SystemEnv.getHtmlLabelName(19822,user.getLanguage()) %></li>
			</ul>
		</div>
		
		<div class="btnGrayDrop relative left " id="signAs" style="width: 80px;" _xuhao=2><%=SystemEnv.getHtmlLabelName(81293 ,user.getLanguage()) %>...
			<ul class="btnGrayDropContent hide" style="position: fixed;width: 92px;" >
				<li class="item" onclick="updateMailStatus(0,event)"><%=SystemEnv.getHtmlLabelName(27603 ,user.getLanguage()) %></li>
				<li class="item" onclick="updateMailStatus(1,event)"><%=SystemEnv.getHtmlLabelName(81295 ,user.getLanguage()) %></li>
				<li style="height: 10px;"><div class="line-1 m-t-5"></div></li>
				<li class="item" onclick="markStar(1,event)"><%=SystemEnv.getHtmlLabelName(81337 ,user.getLanguage()) %></li>
				<li class="item" onclick="markStar(0,event)"><%=SystemEnv.getHtmlLabelName(81297 ,user.getLanguage()) %></li>
				<li style="height: 10px;"><div class="line-1 m-t-5"></div></li>
				<%
				 	ArrayList<MailLabel> lmsList= lms.getLabelManagerList(user.getUID());
					for(int i=0; i<lmsList.size();i++){
						MailLabel ml = lmsList.get(i);
						%>
						<li class="markLabel item" target="<%=ml.getId()%>"><div class="m-r-5 left " style="margin-top:8px;border-radius:2px; height:8px;width:8px; background:<%=ml.getColor()%>;">&nbsp;</div><%=Util.getMoreStr(ml.getName(),4,"...") %></li>
						<%
					}
				%>
				<%
					if(lmsList.size()>0){
						%>
					<li style="height: 10px;"><div class="line-1 m-t-5"></div></li>
						<%
					}
				%>
				
				<!-- ȡ�����б�ǩ--start -->
				<li class="item"  onclick="cancelLabel(this)"><%=SystemEnv.getHtmlLabelName(31219 ,user.getLanguage()) %></li>
				<!-- ȡ�����б�ǩ--end -->
				<!-- �½������--start -->
				<li class="item"   onclick="createLabel(1,this)">+<%=SystemEnv.getHtmlLabelName(31220 ,user.getLanguage()) %></li>
				<!-- �½������--end -->
			</ul>
		</div>
		

		<!-- <button class="font12" type="button">ɾ��</button>
		<button class="font12" type="button">����ɾ��</button>
		<button class="font12" type="button">ת��</button>
		<button class="font12" type="button">ȫ�����Ϊ�Ѷ�</button>
		<button class="font12" type="button">����</button>
		<button class="font12" type="button">�ƶ�</button>
		<button class="font12" type="button">�����ĵ�</button>
		<button class="font12" type="button">�����ͻ���ϵ</button> -->
		
		
		<div class="btnGrayDrop relative left " id="moveTo" style="width: 80px;"><%=SystemEnv.getHtmlLabelName(81298 ,user.getLanguage()) %>...
			<ul class="btnGrayDropContent hide" style="position: fixed;width: 92px;" >
				<li class="item" target="0"><%=SystemEnv.getHtmlLabelName(19816 ,user.getLanguage()) %></li>
				<li class="item" target="-1"><%=SystemEnv.getHtmlLabelName(2038 ,user.getLanguage()) %></li>
				<li style="height: 10px;"><div class="line-1 m-t-5"></div></li>
				<%
					ArrayList<MailFolder> folderList= fms.getFolderManagerList(user.getUID());
					for(int i=0; i<folderList.size();i++){
						MailFolder mf = folderList.get(i);
						%>
						<li class="item" target="<%=mf.getId()%>"><%=Util.getMoreStr(mf.getFolderName(), 4, "...") %></li>
						<%
					}
				%>
				<%
					if(folderList.size()>0){
						%>
					<li style="height: 10px;"><div class="line-1 m-t-5"></div></li>
						<%
					}
				%>
				<!-- �½����ƶ�--start -->
				<li class="newitem"  onclick="createLabel(2,this)">+<%=SystemEnv.getHtmlLabelName(31221 ,user.getLanguage()) %></li>
				<!-- �½����ƶ�--end -->
			</ul>
		</div>
		<!-- �ʼ�����--start -->
		<button class="btnGray1 left" type="button" onclick="popAddMailRule(this)" id="changeBk04" _xuhao=3>
		<%=SystemEnv.getHtmlLabelName(19828 ,user.getLanguage()) %>
		</button>
		<!-- �ʼ�����--end -->
		</div>
		<!-- ��߰�ť-end -->
		
		<div class="right m-r-5  m-t-5" style="height:18px; border: 1px solid #bbb;border-radius:2px;">
			<div class="left ">
				<input type="text" class=" w-100 p-l-5" style="height: 16px!important;font-weight: normal;" id="keyword" value="<%=subject%>" onchange="$('#subject').val(this.value)"  _xuhao=4>
			</div>
			<div class="left  hand "  style="height:18px;">
				<div class="w-15 " style="height:18px;background: url(/email/images/iconDArr.png) center center no-repeat;" id="showHighSearch">
				<form id="highSearchForm" name="highSearchForm" action="/email/new/MailInboxListMain.jsp" method="post">
				<div id="highSearchDiv" class="w-350 hide " style="position:fixed; top:55px;right:5px; border: 1px solid #bbb;background: #fff;z-index: 999;">
					<div class="h-20 p-t-5"><span class="p-l-10 bold font14 "><%=SystemEnv.getHtmlLabelName(21995 ,user.getLanguage()) %></span><b class="right m-r-15 closeHightSearch" >��</b></div>
					<div class="p-l-15 p-r-15">
						<!-- clickObj=0����ǡ�ȫ��",=1�������"δ��",=2�������ĳ����ǩ,=""���ǵ����ȫ����δ������ǩ���������� -->
						<input name="clickObj"  id="clickObj" type="hidden" value="0">
						<input name="folderid" id="folderid" type="hidden" value="<%=folderid%>">
						<input name="labelid" id="labelid" type="hidden" value="<%=labelid%>">
						<input name="labelidchecked" id="labelidchecked" type="hidden" value="">
						<input name="star" id="star" type="hidden" value="<%=star%>">
						<input name="method" id="method" type="hidden" value="dosearch">
						<input name="perpage" id="perpage" type="hidden" value="<%=perpage%>">
						<input name="isInternal" id="isInternal" type="hidden" value="<%=isInternal%>">
						<input name ="index"  id="index" type="hidden" value="<%=index %>">
						<input name ="totalPage"  id="totalPage" type="hidden" value="<%=totalPage %>">
						<table class="w-all ">
							<tr height="35px">
								<td class="w-100 p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(344 ,user.getLanguage()) %>
								</td>
								<td>
									<input class="input w-180" type="text" id="subject" name="subject" value="<%=subject%>"> 
								</td>
							</tr>
							<tr height="35px">
								<td class="w-100  p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(2034 ,user.getLanguage()) %>
								</td>
								<td>
									<input class="input w-180" type="text" id="from" name="from" value=<%=from %>> 
								</td>
							</tr>
							<tr height="35px">
								<td class="w-100 p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(2046 ,user.getLanguage()) %>
								</td>
								<td>
									<input class="input w-180" type="text" id="to" name="to" value="<%=to%>"> 
								</td>
							</tr>
							
							<tr height="35px">
								<td class="w-100 p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(18002 ,user.getLanguage()) %>
								</td>
								<td>
									
									<button class="Calendar" style="height: 16px" type="button" onclick="getDate(startdatespan,startdate)"></button>
									<span id="startdatespan"><%=startdate%></span>
									<input type="hidden" id="startdate" name="startdate" value="<%=startdate%>">
									
									��
									<button class="Calendar" style="height: 16px" type="button" onclick="getDate(enddatespan,enddate)"></button>
									<span id="enddatespan"><%=enddate%></span>
									<input type="hidden" id="enddate" name="enddate" value="<%=enddate%>">
									
								</td>
							</tr>
							
							<tr height="35px">
								<td class="w-100 p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(19844 ,user.getLanguage()) %>
								</td>
								<td>
									<select name="attachmentnumber" id="attachmentnumber" class="w-180">
										<option value="" <%if(attachmentnumber.equals("")) out.print("selected"); %>></option>
										<option value="1" <%if(attachmentnumber.equals("1")) out.print("selected"); %>><%=SystemEnv.getHtmlLabelName(346 ,user.getLanguage()) %></option>
										<option value="0" <%if(attachmentnumber.equals("0")) out.print("selected"); %>><%=SystemEnv.getHtmlLabelName(15507 ,user.getLanguage()) %></option>
									</select>
								</td>
							</tr>
							<tr height="35px">
								<td class="w-100 p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(23845 ,user.getLanguage()) %>
								</td>
								<td>
									<select name="mailaccountid" class="w-180">
										<option value="" <%if(mailaccountid.equals("")) out.print("selected"); %>></option>
										<%
										mas.clear();
										mas.setUserid(user.getUID()+"");
										mas.selectMailAccount();
										while(mas.next()){
											%>
											<option value="<%=mas.getId()%>" <%if(mailaccountid.equals(mas.getId())) out.print("selected"); %>><%=mas.getAccountname() %></option>
											<%
										}
										%>
										
									</select>
								</td>
							</tr>
							<tr height="35px">
								<td class="w-100  p-l-15 font14">
									<%=SystemEnv.getHtmlLabelName(18958 ,user.getLanguage()) %>
								</td>
								<td>
									<select name="status" id="status" class="w-180">
										<option value="" <%if(status.equals("")) out.print("selected"); %>></option>
										<option value="1" <%if(status.equals("1")) out.print("selected"); %>><%=SystemEnv.getHtmlLabelName(25425 ,user.getLanguage()) %></option>
										<option value="0" <%if(status.equals("0")) out.print("selected"); %>><%=SystemEnv.getHtmlLabelName(25396 ,user.getLanguage()) %></option>
									</select>
								</td>
							</tr>
						</table>
						
					</div>
					<div class="center m-t-10 m-b-10"> <button class="btnGray" type="button"  onclick="submitdata()" ><%=SystemEnv.getHtmlLabelName(197 ,user.getLanguage()) %></button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btnGray closeHightSearch" type="button"><%=SystemEnv.getHtmlLabelName(201 ,user.getLanguage()) %></button></div>
				</div>
				</form>
			</div>
			</div>
			<div class="left  hand "  style="height:18px;background: #459830" onclick="$('#highSearchForm')[0].submit()">
				<div class="w-20" style="height:18px;background: url(/email/images/searchBtn.png) center center no-repeat;"></div>
			</div>
			
		</div>
		
		
		
		
		<div class=" right font12 p-t-5  p-r-10 relative"  >
		<span id="currentIndex"><%=index %></span>/<%=totalPage %>
		<span class="btnSpan" onclick="prevPage()"><%=SystemEnv.getHtmlLabelName(1258 ,user.getLanguage()) %></span>
		<span class="btnSpan "  onclick="nextPage()"><%=SystemEnv.getHtmlLabelName(1259 ,user.getLanguage()) %></span>
		&nbsp;&nbsp; <input type="text" class="p-l-5" name="goto" id="goto" style="width: 35px;height: 18px!important;" value="<%=index %>"> 
		<span class="btnSpan" onclick="gotoPage()" ><%=SystemEnv.getHtmlLabelName(81304 ,user.getLanguage()) %></span>
		</div>

			<div style="clear: both;height: 0px">&nbsp;</div>
	</div>
	


		
		
		<table cellspacing="0" cellpadding="0" style="table-layout:fixed;width:100%;*width:auto;" class="O2">
			<tbody>
				<tr>
					<td style="padding:1px 0 1px 5px;" width="27">
					
						<input id="selectAll" type="checkbox" title="<%=SystemEnv.getHtmlLabelName(2241 ,user.getLanguage()) %>/<%=SystemEnv.getHtmlLabelName(201 ,user.getLanguage()) %><%=SystemEnv.getHtmlLabelName(556 ,user.getLanguage()) %>">
					</td>
					<td class="o_title2" style="width:6px;font-size:1px;padding:0;">&nbsp;</td>
					<td style="width:31px;padding:0;"><div class="ico_mailtitle">&nbsp;</div></td>
					<%if(userLayout==2) { %>
					<td class="o_title2" style="width:200px;"><%=SystemEnv.getHtmlLabelName(2034 ,user.getLanguage()) %></td>
					<%} else { %>
					<td class="o_title2" style="width:230px;"><%=SystemEnv.getHtmlLabelName(2034 ,user.getLanguage()) %></td>
					<%} %>
					<td class="o_title2"><%=SystemEnv.getHtmlLabelName(344 ,user.getLanguage()) %></td>
					<%if(userLayout==2) { %>
					
					<%} else { %>
					<td class="o_title2" style="padding-left:2px;width:100px;"><div style="margin-left:10px;"><%=SystemEnv.getHtmlLabelName(25130 ,user.getLanguage()) %></div></td><td style="width:20px;font-size:1px;padding-left:2px">&nbsp;</td>
					<%} %>
				</tr>
			</tbody>
		</table>
		</div>
		<div id="mailList" style="overflow-y:auto;">
		
		</div>
		<!-- group end -->
	
	<input type="hidden" name="selectedAccountIds" id="selectedAccountIds">
</div>
</div>
<div id="mailContentContainer">
</div>

<!-- ��ӹ��˹��� -->
<div id="addMailRule" name="addMailRule" style="height: 250px; overflow-y: auto;display:none"></div>
<!-- ��̬��ʼ��һ��leanModal���� -->
<div id="lean_overlay"></div>
<%
	if(userLayout==3)
	{
 %>
<ol id="joyRideTipContent">
<li data-id="changeBk02" data-text="��һ��" class="custom ">
<span>δ���ʼ�</span>
<p></p>
<p>�����Ե������鿴����δ���ʼ�</p>
</li>
<li data-id="saveAs" data-text="��һ��" class="custom ">
<span>�ʼ�����</span>
<p></p>
<p>ͨ������Ĳ��������Է���ؽ��ʼ���������Ϊϵͳ�ĵ���ͻ���ϵ��¼</p>
</li>
<li data-id="signAs" data-text="��һ��" class="custom">
<span>�ʼ����</span>
<p></p>
<p>ͨ������Ĳ��������Է���ؽ��ʼ��������Ϊδ�����Ѷ������������Ǳ��Ǻͱ�ǩ���</p>
</li>

<li data-id="changeBk04" data-text="��һ��" class="custom">
<span>�ʼ�����</span>
<p></p>
<p>���������ʼ�����ͨ���ʼ�������Զ��ʼ����з��������Զ����</p>
</li>
<li data-id="keyword" data-text="���" class="custom">
<span>�ʼ�����</span>
<p></p>
<p>������ͨ�������������ʼ�����ؼ��ֿ��ٲ����ʼ�</p>
</li>
</ol>
<%
	}
 %>
<div  class="maskguidelist"  id="maskguidelist"></div>

<style>
<!--
	.select{
		
	}
	.select .ico_select_s{
		background: url(/email/images/mailicon.png) 0px -128px no-repeat;
		height: 14px;
		width: 14px;
		
	}
	.lbName{
		color:#ffffff;
		height: 20px;
		padding-left:8px;
		line-height: 20px;
		vertical-align: middle;
		
	}
	.closeLb{
		background: url("/email/images/closeNew.png") left center;
		background-repeat: no-repeat;
		width: 18px;
		height: 20px;
		margin-left: 5px;
	}
	.label{
		border-radius: 2px;
		float: right;
		display: inline-block;
		padding-right: 8px;
		height: 20px;
		line-height: 20px;
		margin-left: 3px;
	}
	.ico_mailtitle {
		background: url('/email/images/mailicon.png') 1px -82px no-repeat;
		width: 26px;
		height: 16px;
	}
	table.O2 {
		border-top: 1px solid white;
		color: #333333;
		font-size:12px;
	}
	td.o_title2 {
		background: url(/email/images/mailicon.png) -128px 0px repeat-y;
		margin: 0px;
		padding: 0px 0px 0px 12px;
	}
	table.O2 td {
		border-bottom: 1px solid #C1C8D2;
		background-color: #F2F4F6;
		padding-top: 0px;
	}
	
	table{
		font-size: 12px!important;
	}
	
	table.M, table.F {
		height: 24px;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #E3E6EB;
		font-weight: normal;
		clear: both;
		
	}
	table.i {
		table-layout: fixed;
		width: 100%;
		height: 26px;
	}
	table.i td.cx, table.i td.cx_s {
		vertical-align: top;
		padding: 6px 0px 1px 5px;
		width: 24px;
	}

	table.i td.ci {
		vertical-align: top;
		width: 50px;
		padding: 4px 0px 0px;
	}

	table.i td.l {
		padding-top: 2px;
		cursor: pointer;
	}
	table.i td.tl {
		width: 111px;
		padding-right: 12px;
	}
	.txtflow, .tf {
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;
	}
	table.i td.fg_n {
		width: 23px;
	}
	
	.txtflow, .tf {
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;
	}
	
	table.i td.dt {
		width: 100px;
		white-space: nowrap;
	}
	
	td.lb {
		white-space: nowrap;
	}

	table.i td.fg {
		width: 20px;
	}
	table.i td.ci div.ciz {
		width: 9px;
		margin-top: 2px;
	}
	table.i td.ci div.cir {
		width: 18px;
		height: 16px;
		overflow: hidden;
		cursor: pointer;
	}
	table.i .no {
		font-weight: normal;
		font-size: 12px;
	}
	.Rr {
		background: url(/email/images/mailicon.png) -48px -16px no-repeat;
	}
	.Ru {
		background: url(/email/images/mailicon.png) -48px 0px no-repeat;
	}
	.Ju {
		background: url(/email/images/mailicon.png) -65px 0px no-repeat;
		cursor: pointer;
	}
	table.i td.fg div {
		width: 14px;
		height: 14px;
		background: url(/email/images/mailicon.png) -32px -160px no-repeat;
	}
	table.i td.fs1 div {
		width: 14px;
		height: 14px;
		background: url(/email/images/mailicon.png) -48px -160px no-repeat;
	}
	table.i td.ci div.cij {
		width: 12px;
		height: 12px;
		overflow: hidden;
		margin-top: 3px;
	}
	
	.mailviewtoolbar{
		padding-top: 8px;
	}
	
	.maskguidelist{
				background-color: rgb(0, 0, 0);
				z-index: 9;
				position: absolute;
				width: 100%;
				height: 0px;
				top:0px;
				filter:alpha(opacity=30);
				opacity:0.3;
			}
-->
</style>

<script>

var checkuser="<%=checkuser%>";
jQuery(document).ready(function(){
	if(<%=userLayout%>==3){
		//if(checkuser=="false"){
			//var h=$(document).height()+100;
			//$("#maskguidelist").height(h);
		//}
		//zzl-����tabҳ�ı���
		//$(window.parent.document).find(".active > .title").html("<%=displayName%>");
	}else{
		//zzl-����tabҳ�ı���
		//$(window.parent.parent.document).find(".active > .title").html("<%=displayName%>");
	}
	
	
	$(".btnSpan").hover(
			function(){$(this).addClass("btnSpanOver")},
			function(){if(!$(this).hasClass('selected'))$(this).removeClass("btnSpanOver")}
	);
	$("select").tzSelect();
	if('<%=receivemail%>'=='true'){
		setAutoMailAccountId();
	}
	loadMailListContent($("#index").val());
	//���ָ���ʼ�
	$(".markLabel").bind("click", function(){
		$(".btnGrayDropContent").hide();
		stopEvent();
		var self = $(this);
		
		var mails = getCheckedMailList();
		if(mails=="") {
			//��ѡ���ʼ�
			alert("<%=SystemEnv.getHtmlLabelName(31226  ,user.getLanguage()) %>!");
			return;
		}
		var needfulMailsId = new Array();
		for(var i=0; i<mails.length; i++){
			var isExist = false;
			var tempId = mails[i].id;
			var lables = mails[i].lables;
			for(var j=0; j<lables.length; j++){
				if(lables[j]==self.attr("target")){
					isExist = true;
					break;
				}
			}
			if(!isExist){
				needfulMailsId.push(tempId);
			}
		}
		//�ж��Ƿ������Ҫ��ӱ�ǩ���ʼ�
		if(needfulMailsId.length==0){
			//��ѡ�е��ʼ��Ѿ���ӹ��ñ�ǩ��
			//
			alert("<%=SystemEnv.getHtmlLabelName(31227,user.getLanguage()) %>!")
			return;
		}
		var param = {"mailsId": needfulMailsId.toString(), "operation": "addLable", "lableId": self.attr("target")};
		$.post("/email/new/MailManageOperation.jsp", param, function(){
			loadMailListContent($("index").val());
		});
	});
	
	//�ƶ�ָ���ʼ�
	$("#moveTo").find(".item").bind("click", function(event){
		$(".btnGrayDropContent").hide();
		stopEvent();
		var mails = getCheckedMailIds();
		
		if(mails!="") {
			var folderid = $(this).attr("target")
			if(mails==""){
				return;
			}
			moveMailToFolder(mails,folderid)
			 // ˢ�������ݺ�δ������
			 RefreshCount();
		} else {
			alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
		}
	});
	
	
	
	// �󶨸߼�������ʾ
	$("#showHighSearch").bind("click",function(event){
		 var x=$(this).offset().left
		 var y=$(this).offset().top
		 //alert($(this).offset().left);
		 $("#highSearchDiv").css("top",y+20);
		 $("#highSearchDiv").css("left",x-280);
		$("#highSearchDiv").show();
		stopEvent(); 
	})
	
	$(".closeHightSearch").bind("click",function(event){
		$("#highSearchForm")[0].reset();  
		$("#highSearchDiv").hide();
		stopEvent();
	})
	
	//�󶨵���Ϊ��ť�¼�
	$("#saveAs").bind("click",function(event){
		 var x=$(this).offset().left
		 var y=$(this).offset().top
		 //alert($(this).offset().left);
		 $("#saveAs").find(".btnGrayDropContent").css("top",y+25);
		 $("#saveAs").find(".btnGrayDropContent").css("left",x);
		 
		$(".btnGrayDropContent").hide();
		$("#saveAs").find(".btnGrayDropContent").show();
		
		stopEvent();
	})
	
	$("#signAs").bind("click",function(event){
		$(".btnGrayDropContent").hide();
		 var x=$(this).offset().left;
		 var y=$(this).offset().top;
		 //alert($(this).offset().left);
		 $("#signAs").find(".btnGrayDropContent").css("top",y+25);
		 $("#signAs").find(".btnGrayDropContent").css("left",x);
		$("#signAs").find(".btnGrayDropContent").show(); 
		stopEvent();
	})
	
	$("#moveTo").bind("click",function(event){
		$(".btnGrayDropContent").hide();
		var x=$(this).offset().left
		var y=$(this).offset().top
		 //alert($(this).offset().left);
		$("#moveTo").find(".btnGrayDropContent").css("top",y+25);
		$("#moveTo").find(".btnGrayDropContent").css("left",x);
		$("#moveTo").find(".btnGrayDropContent").show();
		stopEvent();
	})
	
	
	
	$(document).bind("click",function(){
		//����ط�ΪʲôҪ���ã����·�ҳ������
		//$("#highSearchForm")[0].reset();  

		$("#highSearchDiv").hide();
		$(".btnGrayDropContent").hide();
	})
 	
 	
 
});

//�ʼ������Ǳ깦�ܲ���
function markStar(star,event){
	$(".btnGrayDropContent").hide();
	stopEvent(); 
	var mailids = getCheckedMailIds();
	if(mailids!=""){
		var param = {"mailId": mailids, "star": star, "operation": "updateStar"};
		$.post("/email/new/MailManageOperation.jsp", param, function(){
			loadMailListContent($("index").val());
		});
	} else {
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
	}
}

function loadMailListContent(index){
	var t;
	var formData=$("#highSearchForm").serialize();
	
	jQuery("#mailList").load("/email/new/MailListContent.jsp",formData, function(){
		//��ʼ�����ǰ�ť
		initStarTarget2();
		//��ʼ����ǩ�����Ӧ
		initLableTarget2();
		//ȫѡ��ȡ��ȫѡ
		initSelectAll();
		//���º������Ű�ʱ�������ǵ�һҳʱ��Ĭ��ѡ�е�һ���ʼ�
		if($("#index").val()==1) if(<%=layout%>==1 || <%=layout%>==2) {
			initSelectedFirstMail();
		}
		//�÷��ļ���Ϊ��ڲ鿴ʱ��Ϊ�ݸ��ʼ����ǰ׺��
		if(<%=folderid.equals("")%>) {
			//220
			$("div#mailList").find("div#draft").prepend("(<%=SystemEnv.getHtmlLabelName(220,user.getLanguage()) %>)");
		}
		
		$(".label").mouseenter(function(){
			var obj = $(this);
			t=setTimeout(function(){
				
				$(obj).find(".closeLb").show();
			},500);
		}).mouseleave(function(){
			var obj = $(this);
			
			$(obj).find(".closeLb").hide();
			clearTimeout(t);
			
		});
	});
}

//ѡ�е�һ���ʼ�
function initSelectedFirstMail() {
	$("div#mailList table:first").find("div.title").addClass("bold");
}

function ctwMail(mailId,obj) {
	var url ="/email/new/MailAdd.jsp?id="+ mailId +"&flag=4";
	
	window.parent.addTab("2",url,obj.innerHTML,"s_"+mailId);
	
}

function viewMail(mailId,obj){

	//ֻ�вݸ�����ʼ���ƽ�̵��ʼ������һ���µĵ���tabҳ
	 var url = "/email/new/MailView.jsp?mailid="+mailId+"&folderid=<%=folderid%>&loadjquery=1";
	 jQuery("div .bold").removeClass("bold");
	jQuery(obj).addClass("bold")
	if(<%=layout%>==3){//ƽ��
			window.parent.addTab("2",url,"","s_"+mailId);
	}else{
		jQuery(".centerDiv").load(url);
		// ˢ�������ݺ�δ������
 		RefreshCount();
	}
}


function mailViewInit(mailid,url){
	/*
	
	//$('#viewMarkLable').tzSelect();
	//$('#viewMoveFolder').tzSelect();
	
	//�ƶ�ָ���ʼ�
	$("select#viewMoveFolder").bind("change", function(){
		var mails = mailid;
		var folderid = $(this).val()
		if(mails==""){
			return;
		}
		moveMailToFolder(mails,folderid)
		
		nextMail(mails);
		
	});
	//��ӱ�ǩ
	$('#viewMarkLable').bind("change",function(){
		var mails = mailid;
		var labelid = $(this).val()
		if(mails==""){
			return;
		}
		if($("#label_"+labelid).length>0){
			return;
		}else{
			var param = {"mailsId": mails, "operation": "addLable", "lableId": labelid};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				$("#mailContentContainer").html("");
				$("#mailContentContainer").load(url,function(){
					
					//mailViewInit(mails,url);
				});
			});
		}
	})
	
	$("#replayBtn").bind("click",function(){
		var url="/email/new/MailAdd.jsp?flag=1&id="+mailid
		Goto(url);
	})

	$("#replayAllBtn").bind("click",function(){
		var url="/email/new/MailAdd.jsp?flag=2&id="+mailid
		Goto(url);
	})
	$("#forwardBtn").bind("click",function(){
		var url="/email/new/MailAdd.jsp?flag=3&id="+mailid
		Goto(url);
	})
	
	$("#delBtn").bind("click",function(){
		moveMailToFolder(mailid,"-3")
		jQuery("#backBtn").trigger("click")
	})
	
	$("#dropBtn").bind("click",function(){
		deleteMail(mailid)
		jQuery("#backBtn").trigger("click")
	})
	
	$("#backBtn").bind("click",function(){
		$("#mailListContainer").show();
		$("#mailContentContainer").html("");
		$("#mailContentContainer").hide();
	})
	
	//��ǩ����
	initLableTarget();
	
	//�Ǳ깦��
	$("div.fg").bind("click", function(){
		//alert(1)
		var self = this;
		if($(self).hasClass("fs1")) {
			var param = {"mailId": mailid, "star": 0, "operation": "updateStar"};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				$(self).removeClass("fs1");
				
			});
		} else {
			var param = {"mailId": mailid, "star": 1, "operation": "updateStar"};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				
				$(self).addClass("fs1");
				
			});
		}
		
	});
	*/
		
}

function setAutoMailAccountId(){
	if("<%=receivemailid%>"=="") return false;
	jQuery("#selectedAccountIds").val("<%=receivemailid%>");
	getMail();
}

// ��ȡ�ʼ�
function getMail(){
	var ids = jQuery("#selectedAccountIds").val();
	var ids2 = ids.split(",");
	jQuery("#receiveLoading").show();
	jQuery.post("/email/MailOperationGet.jsp?operation=get&mailAccountId=" + ids2[0],function(){
		loadMailListContent($("index").val());
		jQuery("#receiveLoading").hide();
		// ˢ�������ݺ�δ������
		RefreshCount();
	})
}

//�Ǳ깦��
function initStarTarget2(){
	$("td.fg").bind("click", function(){
		var self = this;
		var mailId = $(self).find("input[name=mailId]").val();
		if($(self).hasClass("fs1")) {
			var param = {"mailId": mailId, "star": 0, "operation": "updateStar"};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				$(self).removeClass("fs1");
				$(self).attr("title","<%=SystemEnv.getHtmlLabelName(81337 ,user.getLanguage()) %>")
			});
		} else {
			var param = {"mailId": mailId, "star": 1, "operation": "updateStar"};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				$(self).addClass("fs1");
				$(self).attr("title","<%=SystemEnv.getHtmlLabelName(81297 ,user.getLanguage()) %>")
			});
		}
	});
}

//��ǩ����
function initLableTarget2(){
	//��ʼ����ǩ�е�closeLb��ť
	$(".label").find(".closeLb").bind("click", function(){
		var self = this;
		var hisParent = $(self).parent();
		var mailId = $(hisParent).find("input[name=mailId]").val();
		var lableId = $(hisParent).find("input[name=lableId]").val();
		var param = {"mailId": mailId, "lableId": lableId, "operation": "removeLable"};
		$.post("/email/new/MailManageOperation.jsp", param, function(){
			$(hisParent).remove();
		});
	});
	
	$(".label").bind("click",function(e){
		var _e =e.target; 		 
		//����Ķ����ı�ǩ���Ҵ������¼��Ķ�����close��DIV
		if($(this).attr("_topmenu")=="1"&&_e.getAttribute("name")=="sb"){
				$("#labelid").val("");
				$('#highSearchForm')[0].submit();
		}else if($(this).attr("_conmenu")=="1"&&_e.getAttribute("name")=="nb"){
				//���û�����б��еı�ǩ�رհ�ťʱ�����������ύ�¼�
		}
		else{
				$("#labelid").val($(this).find("input[name='lableId']").val());
				//��ʾ��ǩ����ҳ���������ģ�������ͨ�������ӵ��������
				$("#labelidchecked").val("1");
				$('#highSearchForm')[0].submit();
		}
	})
	
	
}

//ȫѡ��ȡ��ȫѡ
function initSelectAll() {
	$("input#selectAll").bind("click", function(){
		if(this.checked) {
			$("div#mailList").find(":checkbox").attr( {"checked": true} );
		} else {
			$("div#mailList").find(":checkbox").attr( {"checked": false} );
		}
	});
}

//���ѡ�е�mail
function getCheckedMailList() {
	var mails = new Array();
	$("div#mailList").find("input").each(function(){
		if(this.checked==true) {
			var mail = new Object();
			mail.id = this.value;
			mail.lables = new Array();
			$(this).parent().parent().parent().find("input[name=lableId]").each(function(){
				mail.lables.push(this.value);
			});
			mails.push(mail);
		}
	});
	return mails;
}

//��ȡѡ�е��ʼ�ID
function getCheckedMailIds() {
	var mails = new Array();
	$("div#mailList").find("input:checked").each(function(){
		mails.push($(this).val());
	});
	return mails.toString();
}

function moveMail2DelFolder(){
    var mailIds = getCheckedMailIds();
	if(mailIds==""){
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
		return;
	}
	if(isdel()) {
		var mails = getCheckedMailIds();
		moveMailToFolder(mails,'-3');
		//ˢ�������ݺ�δ������
		RefreshCount();
	}
}


//�ƶ��ʼ���ָ���ļ���
function moveMailToFolder(mailIds,folderid){
	if(mailIds!=""){
		var param = {"mailId": mailIds,movetoFolder:folderid, "operation": "move"};
		$.post("/email/new/MailManageOperation.jsp", param, function(){
			loadMailListContent($("index").val());
		});
	}
}

//����ɾ��ѡ���ʼ�
function deleteCheckedMail(){
	 var mailIds = getCheckedMailIds();
	if(mailIds==""){
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
		return;
	}
	if(isdel()) {
		var mailIds = getCheckedMailIds();
		if(mailIds!=""){
			var param = {"mailId": mailIds, "operation": "delete"};
			$.post("/email/new/MailManageOperation.jsp", param, function(){
				loadMailListContent($("index").val());
				 // ˢ�������ݺ�δ������
				RefreshCount();
			});
		}
	}
}



//�޸��ʼ�״̬ 1���Ѷ�  0:δ��
function updateMailStatus(status,event){
	 
	var mailIds = getCheckedMailIds();
	$(".btnGrayDropContent").hide();
	stopEvent();
	
	if(mailIds!=""){
		doUpdateMailStatus(mailIds,status)
		// ˢ�������ݺ�δ������
		RefreshCount();
	}else{
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
	}
}

//�޸��ʼ�״̬
function doUpdateMailStatus(mailIds,status){
	if(mailIds!=""){
		var param = {"mailId": mailIds,status:status, "operation": "updateStatus"};
		$.post("/email/new/MailManageOperation.jsp", param, function(){
			loadMailListContent($("index").val());
		});
	}
}

/*��һ���ʼ�*/
function nextMail(mailId){
	
	var nextmailid = jQuery("#tbl_"+mailId).nextAll("table.mailitem:first").find("input").val();
	viewMail(nextmailid,jQuery("#tbl_"+mailId).nextAll("table.mailitem:first").find(".title"));
}
/*��һ���ʼ�*/
function prevMail(mailId){
	
	var nextmailid = jQuery("#tbl_"+mailId).prevAll("table.mailitem:first").find("input").val();
	viewMail(nextmailid,jQuery("#tbl_"+mailId).prevAll("table.mailitem:first").find(".title"));
}

//��һҳ
function nextPage(){
	
	var index = $("#index").val();
	var totalPage =$("#totalPage").val()
	index = index*1
	totalPage = totalPage*1
	if(totalPage>=index+1){
		$("#index").val(index+1);
		$("#goto").val(index+1);
		$("#currentIndex").text(index+1)
		loadMailListContent($("index").val());
	
	}
}

//��һҳ
function prevPage(){
	var index = $("#index").val()
	index = index*1
	if(index-1>0){
		$("#goto").val(index-1);
		$("#index").val(index-1)
		$("#currentIndex").text(index-1)
		loadMailListContent($("index").val());
	}
}

function gotoPage(){
	var gotopage = $("#goto").val()
	var totalPage =$("#totalPage").val()
	var index = $("#index").val()
	gotopage = gotopage*1
	index = index*1;
	totalPage = totalPage*1
	if(totalPage>=gotopage&&gotopage>0&&gotopage!=index){
		
		$("#index").val(gotopage)
		$("#currentIndex").text(gotopage)
		loadMailListContent($("index").val());
	}
	
}

//�����ĵ�
function doExportDocs(event){
	var mainid;
	var subid;
	var secid;
	var mailids = getCheckedMailIds();
	$("#saveAs").find(".btnGrayDropContent").hide();
	stopEvent();
	
	if(mailids!=""){
		if(<%=main%><1 && <%=sub%><1 && <%=sec%><1){
			//window.parent.returnValue = Array(1, id, path, mainid, subid);
			var result = showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/PermittedCategoryBrowser.jsp?operationcode=<%=AclManager.OPERATION_CREATEDOC%>");
			if(!result){
				return;
			}
			if(result!=null){
				secid = result[1];
				mainid = result[3];
				subid = result[4];
			}
			
			if(secid=="" || secid==0 || mainid=="" || subid==""){
				return;
			}
		}else{
			mainid = '<%=main%>';
			subid = '<%=sub%>';
			secid = '<%=sec%>';
		}		
		//showMsgBox($("#actionMsgBox")[0], "<img src='/images/loading2.gif'> <%=SystemEnv.getHtmlLabelName(19950,user.getLanguage())%>...");
		var param = {mailIds:mailids,operation:'exportDocs',mainId:mainid,subId:subid,secId:secid}
		$.post("/email/MailOperation.jsp",param,function(){
			alert("<%=SystemEnv.getHtmlLabelName(31228,user.getLanguage()) %>")
		})

	}else{
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
	}
}

//�����ͻ���ϵ
function doExportContacts(event){
	
	var mailids = getCheckedMailIds();
	$("#saveAs").find(".btnGrayDropContent").hide();
	if(mailids!=""){
		
		crmIds = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp");
		if(crmIds){
			try{
				if(crmIds.id!=""){
					var temp = crmIds.id;
					//$("formMailList").crmIds.value =crmIds.id;
					//alert($("formMailList").crmIds.value);
					//$("formMailList").operation.value = "exportContacts";
					//$("formMailList").submit();
					var param = {mailIds:mailids,operation:'exportContacts',crmIds:temp}
					$.post("/email/MailOperation.jsp",param,function(){
						alert("<%=SystemEnv.getHtmlLabelName(31228,user.getLanguage()) %>")
					})
					//hideRightClickMenu();
					//showMsgBox($("actionMsgBox"), "<img src='/images/loading2.gif'> <%=SystemEnv.getHtmlLabelName(19949,user.getLanguage())%>...");
				}
			}catch(e){
				//TODO
				alert("error");
			}
		}
   }else{
	   alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!")
   }
	stopEvent();
}

//��������ʼ����˹���
function popAddMailRule(himself){
	//���ص����򣬱��������ʼ�����ĵ�����һ����ʾ
	$(".btnGrayDropContent").hide();
	$("div#addMailRule").load("/email/new/MailRuleEdit.jsp", function(){
		//$(himself).show_modal({ overlay:0.3, closeButton: ".modal_close" }, this);
		var diag = new Dialog();
		diag.Width  = "480px";
		diag.Title = "<%=SystemEnv.getHtmlLabelName(19834,user.getLanguage()) %>";
		diag.InvokeElementId="addMailRule";
		diag.OKEvent = function(){submitAddMailRule()};
		diag.show();
	});
}

function showMsgBox(o, msg){
	with(o){
		innerHTML = msg;
		style.display = "inline";
		style.position = "absolute"
		style.top = document.body.offsetHeight/2+document.body.scrollTop-50;
		style.left = document.body.offsetWidth/2-50;
	}
}

//�򿪷�����
function openShowNameHref(hrmid,obj,type){	
		parent.addTab("1","/email/new/MailAdd.jsp?to="+hrmid+"&isInternal="+type,"<%=SystemEnv.getHtmlLabelName(30912,user.getLanguage()) %>");		
}	

function showMail(obj,type){
	$(".btnSpan").removeClass("selected").removeClass("btnSpanOver");
	$(obj).addClass("btnSpanOver").addClass("selected");
	$("#status").val($(obj).attr("target"));
	//loadMailListContent($("#index").val());
	if($(obj).attr("target")=="0"){
		$("#clickObj").val("1");
		$("#status").next().find(".selectBox").html("<%=SystemEnv.getHtmlLabelName(25396,user.getLanguage()) %>");
	}else if($(obj).attr("target")=="1"){
		$("#status").next().find(".selectBox").html("<%=SystemEnv.getHtmlLabelName(25425,user.getLanguage()) %>");
	}else if($(obj).attr("target")==""){
		$("#clickObj").val("0");
		$("#status").next().find(".selectBox").html("");
	}
	try{
		if($("#labelidchecked_true")){
					//˵�������б�ǩ������£����ȫ����δ��
					$("#labelidchecked").val("1");
		}
	}catch(e){}
	$("#highSearchForm").submit();
	//loadMailListContent(1);
}

//��ֹ�¼�ð��
function stopEvent() {
	if (event.stopPropagation) { 
		// this code is for Mozilla and Opera 
		event.stopPropagation();
	} 
	else if (window.event) { 
		// this code is for IE 
		window.event.cancelBubble = true; 
	}
}
function cancelLabel(obj){
	var mails = getCheckedMailList();
	if(mails=="") {
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
		return;
	}
	var needfulMailsId = new Array();
	for(var i=0; i<mails.length; i++){
		var tempId = mails[i].id;
		needfulMailsId.push(tempId);
	}
	var param = {"mailsId": needfulMailsId.toString(), "operation": "cancelLabel"};
	$.post("/email/new/MailManageOperation.jsp", param, function(){
		loadMailListContent($("index").val());
		$(obj).parent().hide();
	});
}
function createLabel(type,obj){
	var mails = getCheckedMailList();
	if(mails=="") {
		alert("<%=SystemEnv.getHtmlLabelName(31226,user.getLanguage()) %>!");
		return;
	}
	var needfulMailsId = new Array();
	for(var i=0; i<mails.length; i++){
		var tempId = mails[i].id;
		needfulMailsId.push(tempId);
	}
	$(obj).parent().hide();
	stopEvent() ;
	 if(type==1){
		openDialogcreateLabel("<%=SystemEnv.getHtmlLabelName(31220,user.getLanguage()) %>","/email/new/LabelCreate.jsp?mailsId="+needfulMailsId.toString()+"&type=1",1);
	}else{
		openDialogcreateLabel("<%=SystemEnv.getHtmlLabelName(31221,user.getLanguage()) %>","/email/new/LabelCreate.jsp?mailsId="+needfulMailsId.toString()+"&type=2",2);
	} 
	
}
var dlgcreateLabel;
//������ҳ���У����ô˷�������Ӧ�Ľ���
function openDialogcreateLabel(title,url,type) {
			dlgcreateLabel=new Dialog();//����Dialog����
			dlgcreateLabel.Model=true;
			dlgcreateLabel.Width=500;//���峤��
			if(type==2){
				dlgcreateLabel.Height=100;
			}else{
				dlgcreateLabel.Height=200;
			}
			dlgcreateLabel.URL=url;
			dlgcreateLabel.Title=title;
			dlgcreateLabel.OKEvent = SaveDatecreateLabel;//���ȷ������õķ���
			dlgcreateLabel.show();			
}
function closeDialogcreateLabel() {
		dlgcreateLabel.close();
		loadMailListContent($("index").val());
}
function SaveDatecreateLabel(){
	     document.getElementById("_DialogFrame_0").contentWindow.submitDate(dlgcreateLabel);
}
function submitdata(){
	//clickObj=0����ǡ�ȫ��",=1�������"δ��",=2�������ĳ����ǩ,=""���ǵ����ȫ����δ������ǩ����������
	//String clickObj=Util.null2String(request.getParameter("clickObj"));
		var status=$("#status").val();
		if(status=="1"){
			//�Ѷ�
			$("#clickObj").val("");
		}else if(status=="0"){
			//δ��
			$("#clickObj").val("1");
		}else{
			//ȫ��
			$("#clickObj").val("0");
		}
		$('#highSearchForm')[0].submit();
}
function nextWizard(obj){
	//alert(obj);
}
function finishALLIframe(){
		//alert("�򵼽���");
		$(".joyride-tip-guide").remove();
		//$("#maskguidelist").height("0px");
		$(window.parent.document.getElementById("clickshowjoy")).attr("href","javascript:showjoy()");
		//window.parent.document.getElementById("maskguide").style.cssText="height:0px";
}
function ShowWizard(){
	$(document).joyride({"postStepCallback":nextWizard,"postRideCallback":finishALLIframe});
}

function isdel(){
	var str = "<%=SystemEnv.getHtmlLabelName(15097,user.getLanguage())%>";
   if(!confirm(str)){
       return false;
   }
       return true;
 }
 
 // ˢ�������ݺ�δ������
 function RefreshCount(){
 		var param =<%=param%>;
		$.post("/email/new/RefreshCountAjAX.jsp", param, function(data){
				$("#totalMailCount_id").html("("+data.totalMailCount+")");
				$("#unreadMailCount_id").html("("+data.unreadMailCount+")");
		},"json");
 }
 
</script>
