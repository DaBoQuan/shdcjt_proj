<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogReportManager"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="weaver.blog.AppDao"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@page import="weaver.blog.AppItemVo"%>
<%@page import="weaver.blog.AppVo"%>
<html>
<head>
<title><%=SystemEnv.getHtmlLabelName(26468,user.getLanguage())%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="/css/Weaver.css" type="text/css" />
<LINK href="css/blog.css" type=text/css rel=STYLESHEET>
<script type='text/javascript' src='js/timeline/lavalamp.min.js'></script>
<script type='text/javascript' src='js/timeline/easing.js'></script>
<script type='text/javascript' src='js/highlight/jquery.highlight.js'></script>
<script language="javascript" src="/js/weaverTable.js" type="text/javascript"></script>
<link href="js/timeline/lavalamp.css" rel="stylesheet" type="text/css"> 
<script type="text/javascript">var languageid=<%=user.getLanguage()%>;</script>
<script type="text/javascript" src="/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="/kindeditor/kindeditor-Lang.js"></script>

<link href="js/weaverImgZoom/weaverImgZoom.css" rel="stylesheet" type="text/css">
<script src="js/weaverImgZoom/weaverImgZoom.js"></script>

<script type="text/javascript" src="js/raty/js/jquery.raty.js"></script>

<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>

<!-- ΢����ǩ -->
<script type="text/javascript" src="/blog/js/notepad/notepad.js"></script>

<!-- ����javascript -->
<jsp:include page="blogUitl.jsp"></jsp:include>
</head>
<body>
<%@ include file="/blog/uploader.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%
	String userid = "" + user.getUID();
	BlogDao blogDao = new BlogDao();
	Date today = new Date();
	Date startDateTmp = new Date();
	SimpleDateFormat dateFormat1=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat dateFormat2=new SimpleDateFormat("yyyy��MM��dd��");
	SimpleDateFormat timeFormat=new SimpleDateFormat("HH:mm");
	
	String curDate = dateFormat1.format(today); //��ǰ����
	startDateTmp.setDate(startDateTmp.getDate() - 30);
	String startDate =dateFormat1.format(startDateTmp);

	AppDao appDao = new AppDao();
	List appItemVoList = appDao.getAppItemVoList("mood");
	
	String enableDate=blogDao.getSysSetting("enableDate");       //΢����������
	String attachmentDir=blogDao.getSysSetting("attachmentDir"); //�����ϴ�Ŀ¼
	
	if(dateFormat1.parse(enableDate).getTime()>dateFormat1.parse(startDate).getTime()){
		startDate=enableDate;
	}
	
	String menuItem=Util.null2String(request.getParameter("menuItem"));
	
	if(menuItem.equals(""))
		menuItem="myBlog";
	
	BlogReportManager reportManager=new BlogReportManager();
	
	//���ü�¼
	int visitTotal=blogDao.getVisitTotal(userid);
	int visitCurrentpage=1;
	int visitTotalpage=visitTotal%5>0?visitTotal/5+1:visitTotal/5;
	List visitorList=blogDao.getVisitorList(userid,visitCurrentpage,5,visitTotal);
	
	int accessTotal=blogDao.getAccessTotal(userid);
	int accessCurrentpage=1;
	int accessTotalpage=accessTotal%5>0?accessTotal/5+1:accessTotal/5;
	List visitList=blogDao.getAccessList(userid,accessCurrentpage,5,accessTotal);
	
	List tempList=blogDao.getTemplate(""+user.getUID());
	String tempContent="";
	int isUsedTemp=0;
	if(tempList.size()>0){
		isUsedTemp=1;
		tempContent=(String)((Map)tempList.get(0)).get("tempContent");
	}
%>

<script type="text/javascript">
   var tempHeight=0;      //΢��ģ��߶�
   var isUsedTemp=<%=isUsedTemp%>;  //������ģ��
</script>

 <div>
	 <DIV id=bg></DIV>
	 <div id="loading">
			<div style=" position: absolute;top: 35%;left: 25%" align="center">
			    <img src="/images/loading2.gif" style="vertical-align: middle"><label id="loadingMsg"><%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%></label>
			</div>
	 </div>
 </div>
<div style="height: 100%;" id="myBlogdiv">
    <div style="height:30px;line-height:30px;margin-top:0px" class="TopTitle">
	   <div class="topNav" style="float: left;margin-right:10px">  
			<ul>
				<li class="selected"><a href="myBlog.jsp" style="font-weight: bold;"><%=SystemEnv.getHtmlLabelName(26468,user.getLanguage())%></a></li><!-- ΢����ҳ--> 
			</ul>
		</div>
		<span style="float: right;margin-right: 5px;margin-top: 5px;" >
		    <button title="<%=SystemEnv.getHtmlLabelName(18753,user.getLanguage())%>" class="btnFavorite" id="BacoAddFavorite" onclick="openFavouriteBrowser()" type="button" style="vertical-align: top;"></button><!-- �����ղؼ� -->
	        <button title="����" style="margin-left:5px;vertical-align: top;" class="btnHelp" id="btnHelp" onclick="alert('����');" type="button"></button><!-- ����-->
		</span>
		<div id="searchDiv"  align="right" style="display: block;float: right;margin-top: 4px;">
			<table  cellpadding=0 cellspacing=0>
			<tr>
				<td>
				     <INPUT id=startdate name=startdate type=hidden value="<%=startDate%>">
					 <BUTTON type="button" class=Calendar onclick="getDate('startdatespan','startdate')" style="vertical-align: top;"></BUTTON>
					 <SPAN id="startdatespan"><%=startDate%></SPAN>
					 	<%=SystemEnv.getHtmlLabelName(15322,user.getLanguage())%>&nbsp;
					 <BUTTON type="button" class=Calendar onclick="getDate('enddatespan','enddate')" style="vertical-align: top;"></BUTTON> 
					 <SPAN id=enddatespan><%=curDate%></SPAN>&nbsp;
					 <INPUT id=enddate name=enddate type=hidden value="<%=curDate%>">
					<span>&nbsp;</span>
				</td>
				<td align="right">
	                <div class="searchBox">
	                <input id="content" class="searchInput" onkeydown="if(event.keyCode==13) jQuery('#searchBtn').click();"/> 
	                <div class="searchBtn" id="searchBtn" from="homepage" onclick="search('content','startdate','enddate',this);removeScroll()"></div>
	                </div>
				</td>
			</tr>
		</table>
		</div>
	</div>
<div class="mainContent" style="">
<table style="width: 100%">
   <tr>
       <td valign="top" width="*" style="max-width: 800px;">
            <!-- ��� --> 
			<div class="left">
			    
			    <div class="tabStyle2" style="margin-top:6px;display: none;width: 100%" id="myBlogMenu">
					<UL>
					    <!-- �ҵ�΢�� -->
						<LI id="blog" class="select2" style="margin-left: 10px" url="discussList.jsp?blogid=<%=userid%>&requestType=myblog"><A href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(26468,user.getLanguage())%></A></LI>
						<!-- �ҵı��� -->
						<LI id="report" url="myBlogReport.jsp?from=view&userid=<%=userid%>"><A href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(18040,user.getLanguage())%></A></LI>
						<!-- �ҵĹ�ע -->
						<LI url="myAttentionHrm.jsp?userid=<%=userid%>"><A href="javascript:void(0)" ><%=SystemEnv.getHtmlLabelName(26933,user.getLanguage())%></A></LI>
						<!-- ��ע�ҵ� -->
						<LI url="attentionMeHrm.jsp?userid=<%=userid%>"><A href="javascript:void(0)" ><%=SystemEnv.getHtmlLabelName(26940,user.getLanguage())%></A></LI>
					    <!-- ���ܲ鿴 -->
					    <LI url="canViewHrm.jsp?userid=<%=userid%>"><A href="javascript:void(0)" >���ܲ鿴</A></LI>
					    <!-- ���ܲ鿴 -->
					    <LI url="canViewMeHrm.jsp?userid=<%=userid%>"><A href="javascript:void(0)" >�ܲ鿴��</A></LI>
					</UL>
				</div>
			    
				<div class="reportBody" id="reportBody" align="center" style="padding-top: 8px;float: none;"></div>
				
				<!-- ��ҳ���ݼ�����ʾ -->
				<div id="loadingdiv" style="position:relative;width: 100%;height: 30px;margin-bottom: 15px;display: none;">
			      <div class='loading' style="position: absolute;top: 10px;left: 50%;">
			         <img src='/images/loadingext.gif' align="absMiddle"><%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>
			      </div>
			    </div>	
			</div>
       </td>
       <td valign="top" style="width:195px;padding-left: 12px"> 
          <!-- �ұ� -->
			<div class="right" style="margin-top: 10px;">
				<div class="side-item" style="margin-bottom: 6px;">
				    <span>   
				             <!-- ����ָ�� -->
							 <a href="javascript:void(0)" class="index" onclick="openReport()"><%=SystemEnv.getHtmlLabelName(26929,user.getLanguage())%>��<span id="workIndexCount" title="<%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26932,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(0)%></span><span id="workIndex" style="font-weight: bold;margin-left: 8px;color: #666666">0.0</span></a><br/><!-- δ�ύ Ӧ�ύ -->
							 <%if(appDao.getAppVoByType("mood").isActive()){ 
							 %>
							 <!-- ����ָ�� -->
							 <a href="javascript:void(0)" class="index" onclick="openReport()"><%=SystemEnv.getHtmlLabelName(26930,user.getLanguage())%>��<span id="moodIndexCount" title="<%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(0)%></span><span id="moodIndex" style="font-weight: bold;margin-left: 8px;color: #666666">0.0</span></a><br/><!-- ������ ���� -->
							 <%}%>
							 <% String isSignInOrSignOut=Util.null2String(GCONST.getIsSignInOrSignOut());//�Ƿ�����ǰ��ǩ�˹���
							    if(isSignInOrSignOut.equals("1")){
							 %>
							 <!-- ����ָ�� -->
							 <a href="javascript:void(0)" class="index" onclick="openReport()"><%=SystemEnv.getHtmlLabelName(26931,user.getLanguage())%>��<span id="scheduleIndexCount" title="<%=SystemEnv.getHtmlLabelName(20085,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(18083,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20081,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(18083,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%>0<%=SystemEnv.getHtmlLabelName(20079,user.getLanguage())%>"><%=reportManager.getReportIndexStar(0)%></span><span id="scheduleIndex" style="font-weight: bold;margin-left: 8px;color: #666666">0.0</span></a><!-- ���� �ٵ� -->
						     <%} %>
					</span>
				</div>
				<%
					  String allowRequest=blogDao.getSysSetting("allowRequest");   //�Ƿ���չ�ע����
					  Map count=blogDao.getReindCount(user); 
					  int remindCount=((Integer)count.get("remindCount")).intValue();           //����δ�鿴��
					  int commentCount=((Integer)count.get("commentCount")).intValue();         //����δ�鿴
					  int updateCount=((Integer)count.get("updateCount")).intValue();           //��������
					  
				%>
			
				<div class="side-item menu">
				        <!-- �ҵ���ҳ --> 
					    <div class="menuItem homepage selected"  id="homepage" url="discussList.jsp?requestType=homepage&currentpage=1">
						    <span class="menuName"><span class="title"><%=SystemEnv.getHtmlLabelName(27128,user.getLanguage())%></span></span><em id="unpdateCount" class="msg-count" onclick="viewUnreadMsg('update',event)" style="display: <%=updateCount>0?"":"none"%>"><span class="count"><%=updateCount%></span></em>
						</div>
						<!-- �ҵ�΢�� -->
						<div class="menuItem myblog" id="myBlog" url="discussList.jsp?blogid=<%=userid%>&requestType=myblog">
						    <span class="menuName"><span class="title"><%=SystemEnv.getHtmlLabelName(26468,user.getLanguage())%></span></span>
						</div>
						<!-- �����ҵ� -->
						<div class="menuItem commentonme"  id="comment" url="commentOnMe.jsp">
						    <span class="menuName"><span class="title"><%=SystemEnv.getHtmlLabelName(26999,user.getLanguage())%></span></span><em class="msg-count" style="display:<%=commentCount>0?"":"none"%>"><span class="count"><%=commentCount%></span></em>
						</div>
						<!-- ΢����ǩ -->
						<div class="menuItem notepad" id="notepad"  url="blogNotes.jsp">
						    <span class="menuName"><span class="title">΢����ǩ</span></span>
						</div>
						<!-- ��Ϣ���� -->
						<div class="menuItem sysremind" id="sysremind"  url="blogRemind.jsp">
						    <span class="menuName"><span class="title"><%=SystemEnv.getHtmlLabelName(19085,user.getLanguage())%></span></span><em class="msg-count" style="display:<%=remindCount>0?"":"none"%>"><span class="count"><%=remindCount%></span></em>
						</div>
				</div>
				<%if(visitorList.size()>0){ %>
					<div class="side-item people-box">
						<div class="title">
							<img src="images/visit-icon.png" align="absmiddle" style="margin-right: 3px"><%=SystemEnv.getHtmlLabelName(26934,user.getLanguage())%><!-- ������� -->
						    <span style="margin-left: 75px"><img id="prepage" onclick="visitpage('pre')" align="absmiddle" width="12px" style="cursor: pointer;" alt="��һҳ" src="images/pre_page_no.png">&nbsp;&nbsp;<img onclick="visitpage('next')" id="nextpage" align="absmiddle" style="cursor: pointer;" alt="��һҳ" width="12px" src="<%=visitTotalpage>1?"images/next_page.png":"images/next_page_no.png" %>"></span>
						</div>
						<div id="visitList" class="peoplebox-body clear">
								<ul class="people-list" style="width: 100%">
								<%for(int i=0;i<visitorList.size();i++){
									Map map=(Map)visitorList.get(i);
									String visitor=(String)map.get("userid");
									String visitdate=(String)map.get("visitdate");
									visitdate=dateFormat2.format(dateFormat1.parse(visitdate));
									String visittime=(String)map.get("visittime");
									visittime=timeFormat.format(timeFormat.parse(visittime));
								%>
									<li style="margin-right: 0px;width: 100%;height: 45px">
									
									<div style="float: left;">
									  <a  href="viewBlog.jsp?blogid=<%=visitor%>" target="_blank">
									      <img style="border: 0px;cursor: pointer;" src="<%=ResourceComInfo.getMessagerUrls(visitor)%>" width="40px">
									  </a>
									</div>
									<div style="float: left;margin-left: 5px">
									   <span class="name" style="text-align: left;height: 40px;">
									      <span style="margin-bottom:3px;text-align: left;">
									        <a  href="viewBlog.jsp?blogid=<%=visitor%>" target="_blank"><%=ResourceComInfo.getLastname(visitor) %></a>
									      </span>
									      <span style="color: #666;text-align: left;"><%=visitdate+" "+visittime%></span>
									   </span>
									</div>
								</li>
								<%}%>
							   </ul>
							
						</div>
					</div>
				<%}%>
				<%if(visitList.size()>0){%>
					<div class="side-item people-box">
						<div class="title">
							<img src="images/visit-icon.png" align="absmiddle" style="margin-right: 3px"><%=SystemEnv.getHtmlLabelName(26935,user.getLanguage())%><!-- ������� -->
						    <span style="margin-left: 75px"><img id="accessprepage" onclick="accesspage('pre')" align="absmiddle" width="12px" style="cursor: pointer;" alt="��һҳ" src="images/pre_page_no.png">&nbsp;&nbsp;<img onclick="accesspage('next')" id="accessnextpage" align="absmiddle" style="cursor: pointer;" alt="��һҳ" width="12px" src="<%=accessTotalpage>1?"images/next_page.png":"images/next_page_no.png" %>"></span>
						</div>
						<div id="accessList" class="peoplebox-body clear" style="width: 195px;">
							<ul class="people-list" style="width: 100%">
								<%for(int i=0;i<visitList.size();i++){
								    Map map=(Map)visitList.get(i);
									String visitor=(String)map.get("userid");
									String visitdate=(String)map.get("visitdate");
									visitdate=dateFormat2.format(dateFormat1.parse(visitdate));
									String visittime=(String)map.get("visittime");
									visittime=timeFormat.format(timeFormat.parse(visittime));
								%>
									<li  style="margin-right: 0px;width: 100%;height: 45px">
									<div style="float: left;">
									   <a href="viewBlog.jsp?blogid=<%=visitor%>" target="_blank">
									       <img style="border: 0px;cursor: pointer;" src="<%=ResourceComInfo.getMessagerUrls(visitor) %>" width="40px">
									   </a>
									   
									</div>
									<div style="float: left;margin-left: 5px;">
									   <span class="name" style="text-align: left;height: 40px;">
									      <span style="margin-bottom:3px;text-align: left;">
									          <a href="viewBlog.jsp?blogid=<%=visitor%>" target="_blank"><%=ResourceComInfo.getLastname(visitor) %></a>
									      </span>
									      <span style="color: #666;text-align: left;"><%=visitdate+" "+visittime%></span>
									   </span>
									</div>
									
								</li>
								<%}%>
							</ul>
						</div>
					</div>
				<%} %>
			</div>
       </td>
   </tr>
</table>

<div class="clear"></div>
</div>

<iframe id="downloadFrame" style="display: none"></iframe>
<!-- ΢��ģ������ -->
<div id="templatediv">
  <%=tempContent%>
</div>
<div class="editorTmp" style="display:none">
<table>
	<tr>
		<td>
		 <textarea name="submitText" scroll="none" style="border: solid 1px;"></textarea>
		</td>
	</tr>
	<tr>
		<td class="appItem_bg">
			<div style="float: left;margin-right: 10px;vertical-align: middle;" >
			    <!-- ���� -->
				<input type="button" class="submitButton" onclick="saveContent(this)"/>
				<!-- ȡ�� -->
				<input type="button" class="editCancel" onclick="editCancel(this);" value="<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%>">
			</div>  
	   	 <%
	   	    List appVoList=appDao.getAppVoList();
	   	 	for(int i=0;i<appVoList.size();i++){
	   	 		AppVo appVo=(AppVo)appVoList.get(i);
	   	 		if("mood".equals(appVo.getAppType())){
	   	 		if(appItemVoList!=null&&appItemVoList.size()>0){ 
			   		AppItemVo appItemVo1=(AppItemVo)appItemVoList.get(0);
			   		
			   		String itemType1=appItemVo1.getType();
	  				String itemName1=appItemVo1.getItemName();
	  				if(itemType1.equals("mood"));
	  				   itemName1=SystemEnv.getHtmlLabelName(Util.getIntValue(itemName1),user.getLanguage());
			   %>
			   <!-- ���� -->
			   <div class="optItem" style="width:90px;position: relative;">
				  <div id="mood_title" class="opt_mood_title"  onclick="show_select('mood_title','mood_items','qty_<%=appItemVo1.getType() %>','mood',event,this)">
				 	
				    <img src="<%=appItemVo1.getFaceImg() %>" width="16px" alt="<%=itemName1%>" align="absmiddle" style="margin-right:3px;margin-left:2px">
				    
				    <a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(26920,user.getLanguage())%></a><!-- ���� -->
				 
				  </div>
				  <div id="mood_items" style="display:none" class="opt_items">
				  		<%
				  			for(int j=0;j<appItemVoList.size();j++) {
				  				AppItemVo appItemVo= (AppItemVo)appItemVoList.get(j);
				  				String itemType=appItemVo.getType();
				  				String itemName=appItemVo.getItemName();
				  				if(itemType.equals("mood"));
				  				   itemName=SystemEnv.getHtmlLabelName(Util.getIntValue(itemName),user.getLanguage());
				  		%>
					   		<div class='qty_items_out'  val='<%=appItemVo.getId() %>'><img src="<%=appItemVo.getFaceImg() %>" alt="<%=itemName%>" width="16px" align="absmiddle" style="margin-right:3px;margin-left:2px"><%=itemName%></div>
					   <%} %>
				  </div> 
				  <input name="qty_<%=appItemVo1.getType() %>" class="qty" type="hidden" id="qty_<%=appItemVo1.getType() %>" value="<%=appItemVo1.getId() %>" />
			   </div>
				
		   	 <%} 
	   	   }else if("attachment".equals(appVo.getAppType())){
	   	 %>
	   	    <!-- ���� -->
	   	    <div class="optItem" style="width: 120px;position: relative;">
			  <div id="temp_title" style="width: 120px" class="opt_title" onclick="openApp(this,'')">
			   <%
			   if(attachmentDir!=null&&!attachmentDir.trim().equals("")){ 
				   String attachmentDirs[]=Util.TokenizerString2(attachmentDir,"|");
				   RecordSet recordSet=new RecordSet();
				   recordSet.executeSql("select maxUploadFileSize from DocSecCategory where id="+attachmentDirs[2]);
				   recordSet.next();
				   String maxsize = Util.null2String(recordSet.getString(1));
			   %>
			    <a href="javascript:void(0)"><div class="uploadDiv" mainId="<%=attachmentDirs[0]%>" subId="<%=attachmentDirs[1]%>" secId="<%=attachmentDirs[2]%>" maxsize="<%=maxsize%>"></div></a>
			   <%}else{ %>
			    <span style="color: red">�����ϴ�Ŀ¼δ����</span>
			   <%} %>
			  </div>
		  </div>
	   	 <%}else{ %>
			  <div class="optItem">
				  <div id="temp_title" class="opt_title" onclick="openApp(this,'<%=appVo.getAppType() %>')">
				    <img src="<%=appVo.getIconPath() %>" width="16px" align="absmiddle" style="margin-right:3px;margin-left:2px"><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(Integer.parseInt(appVo.getName()),user.getLanguage()) %></a>
				  </div>
	
			  </div>
		  <%}} %>
		  
</td>
	</tr>
	</table>
</div>
</div>
</body>
</html>
<script>
    var tempHeight=0;      //΢��ģ��߶�
    var isUsedTemp=<%=isUsedTemp%>;  //������ģ��
    
	jQuery(function(){
		jQuery(".menuItem").click(function(obj){
		    jQuery(document.body).focus();
			jQuery(".menuItem").each(function(){
				jQuery(this).removeClass("selected");
			});
			
			jQuery(this).addClass("selected");
			var url=jQuery(this).attr("url");
			displayLoading(1,"page");
		    var menuItem=jQuery(this).attr("id");
		    
		    //δ���������Ѳ�������
		    if(menuItem!="homepage")
		       jQuery(this).find(".msg-count").hide();
		    
			jQuery.post(url,{},function(a){
			    
				jQuery("#reportBody").html(a.replace(/<link.*?>.*?/, ''));
				
				if(menuItem=="notepad")
				      //��ʼ��΢����ǩ�༭��
				      showBlogNotes();
				else{       
					  //��ʾ����༭��
					  jQuery(".editor").each(function(){
					    if(jQuery(this).css("display")=="block"){
						   showAfterSubmit(this);
						}
				      });
			    }
			   
				if(menuItem=="myBlog"){
			        jQuery("#myBlogMenu").show();
			        jQuery("#searchBtn").attr("from","myBlog");    //�޸�������Դҳ
			        
			        jQuery(".tabStyle2 li").each(function(){
						jQuery(this).removeClass("select2");
					});
					jQuery("#blog").addClass("select2");
			    }else{ 
			        jQuery("#searchBtn").attr("from","homepage");  //�޸�������Դҳ
			        jQuery("#myBlogMenu").hide();     
			     }
				
				
				if(menuItem=="myBlog"||menuItem=="homepage"||menuItem=="comment"){  
			       
			        //��ʼ������ͼƬ
			        jQuery('.reportContent img').each(function(){
						initImg(this);
				    });
					//�ϼ����ֳ�ʼ��
					jQuery(".blog_raty").each(function(){
					   managerScore(this);
					   jQuery(this).attr("isRaty","true"); 
					});
					
				}
				
				if(menuItem=="homepage"){
				    //initScroll();      //����ҵ���ҳʱ��ʼ�������������� 
				}    
				else 
				    removeScroll();
				      
				displayLoading(0);
			});
		});
		
		jQuery(".menuName").hover(
		  function(){
		     jQuery(this).css("text-decoration","underline");
		  },function(){
		     jQuery(this).css("text-decoration","none");
		  }
		);
		jQuery("#unpdateCount").hover(
		  function(){
		     jQuery(this).css("font-weight","bold");
		  },function(){
		     jQuery(this).css("font-weight","normal");
		  }
		);
		
		if("<%=menuItem%>"!="")
		     jQuery("#<%=menuItem%>").click();
		else
		     jQuery("#homepage").click();
		     
		notepad('.reportContent'); //΢����ǩѡȡ����        
	});
	
	//�鿴����΢��
	function viewUnreadMsg(msgType,event){
	   displayLoading(1,"page");
	   jQuery.post("discussList.jsp?blogid=<%=userid%>&requestType=homepageNew",function(a){
	      
	      jQuery(".menuItem").each(function(){
				jQuery(this).removeClass("selected");
		  }); 
		  jQuery("#homepage").addClass("selected");
		  jQuery("#searchBtn").attr("from","homepage");  //�޸�������Դҳ
	      jQuery("#myBlogMenu").hide();      
	      jQuery("#reportBody").html(a.replace(/<link.*?>.*?/, ''));
	      
		  
		  //��ʼ������ͼƬ
		  jQuery('.reportContent img').each(function(){
			  initImg(this);
		  });
		  
		  jQuery(".blog_raty").each(function(){ //�ϼ����ֳ�ʼ��
		     managerScore(this);
		     jQuery(this).attr("isRaty","true"); 
		  });
		  removeScroll();
	      displayLoading(0);
	   });
	   window.event.cancelBubble = true;
	}

jQuery(document).ready(function(){
    //��ȡ����ָ��
    getIndex(<%=userid%>); 
	//�������������˵�
	jQuery(document.body).bind("click",function(){
		jQuery(".dropDown").hide();
		jQuery(".opt_items").hide();
	});
});

   /*�������ش���*/  
    var index=0;           //��ʼ��ȡ�±�
	var hght=0;             //��ʼ���������ܳ�
	var top=0;              //��ʼ���������ĵ�ǰλ��
	var preTop=0;
	var currentpage=0;       //��ǰҳ��ʼֵ
	var total=0;
	var flag=true;         //ÿ�������Ƿ���ɱ�ǣ��������ٹ���Э�������޷����� �ɹ���������Ϊtrue
	var pagesize=0;
	
	//��ʼ������
	function initScroll(){
	      index=20;           //��ʼ��ȡ�±�
		  hght=0;             //��ʼ���������ܳ�
		  top=0;              //��ʼ���������ĵ�ǰλ��
		  preTop=0;
		  currentpage=1;       //��ǰҳ��ʼֵ
		  total=0;
		  flag=true;         //ÿ�������Ƿ���ɱ�ǣ��������ٹ���Э�������޷����� �ɹ���������Ϊtrue
		  pagesize=20;
	     
	     //��ȡ��ҳ��¼���������index����total��󶨹��������¼�
	     jQuery.post("blogOperation.jsp?operation=getHomepageTotal&pagesize="+pagesize,function(data){
            total=jQuery.trim(data);
	        if(index<total){
			 jQuery("#myBlogdiv").bind("scroll",function(){
				  hght=this.scrollHeight;//�õ��������ܳ�������hght����
				  top=this.scrollTop;//�õ���������ǰֵ������top����
				  if(this.scrollTop>parseInt(this.scrollHeight/3)&&preTop<this.scrollTop)//�жϹ�������ǰλ���Ƿ񳬹��ܳ���1/3��parseIntΪȡ������,���¹���ʱ�ż�������
				    show();
			       preTop=this.scrollTop;//��¼��һ��λ��
			 });
	       }		 
	     
	     });
	}
	
	//ɾ������
	function removeScroll(){
	    jQuery("#myBlogdiv").unbind("scroll");     
	}
	
	function show(){
	    if(flag){
			index=index+pagesize;
			if(index>total){                    //����ȡ������������ʱ
			   //pagesize=total-(index-pagesize); 
			   index=total;                     //ҳ��������������������
			   jQuery("#myBlogdiv").unbind("scroll"); 
			}
			flag=false;
			currentpage=currentpage+1;          //ȡ��һҳ
			jQuery("#loadingdiv").show();  
		    jQuery.post("discussList.jsp?blogid=<%=userid%>&requestType=homepage&currentpage="+currentpage+"&pagesize="+pagesize,function(data){
				    
				    var tempdiv=jQuery("<div>"+data+"</div>");
				    //��ʼ������ͼƬ
			        tempdiv.find('.reportContent img').each(function(){
						initImg(this);
				    });
				    jQuery("#reportBody").append(tempdiv);
				    


				    //�ϼ����ִ���
				    jQuery(".blog_raty").each(function(){
				       if(jQuery(this).attr("isRaty")!="true"){
					       managerScore(this);
					       jQuery(this).attr("isRaty","true"); 
					   }    
					});
				    hght=0;
				    top=0;
				    flag=true;
				    jQuery("#loadingdiv").hide();  
				    
			});
		}
	} 
/*�������ش���*/	
    
    //��ʼ���ҵ�΢���˵�
	jQuery(function(){
		jQuery(".tabStyle2 li").click(function(obj){
		        jQuery(document.body).focus();
				jQuery(".tabStyle2 li").each(function(){
					jQuery(this).removeClass("select2");
				});
				jQuery(this).addClass("select2");
				var url=jQuery(this).attr("url");
				var tabid=jQuery(this).attr("id");
				displayLoading(1,"page"); 
				jQuery.post(url,{},function(a){
					jQuery("#reportBody").html(a.replace(/<link.*?>.*?/, ''));
					//��ʾ����༭��
					jQuery(".editor").each(function(){
					 if(jQuery(this).css("display")=="block"){
						 showAfterSubmit(this);
						}
				    });
					if(tabid=="blog"){
					
					    //ͼƬ��ʼ�� 
						jQuery('.reportContent img').each(function(){
						   initImg(this);
				        });
						
						//�ϼ����ֳ�ʼ��
						jQuery(".blog_raty").each(function(){
						   managerScore(this);
						})
					}else if(tabid=="report"){  
					    jQuery(function(){jQuery(".lavaLamp").lavaLamp({ fx: "backout", speed: 700 })});
					}
					if(tabid!="report")
					   displayLoading(0);
				});
			});
	});
	
	//��ӵ��ղؼ�
    function openFavouriteBrowser(){
	   var url=window.location.href;
	   fav_uri=url.substring(url.indexOf("/blog/"),url.length)+"&";
	   fav_uri = encodeURIComponent(fav_uri,true); 
	   var fav_pagename=jQuery("title").html();
	   window.showModalDialog("/favourite/FavouriteBrowser.jsp?fav_pagename="+fav_pagename+"&fav_uri="+fav_uri+"&fav_querystring=");
    }
    //��ʾ����
    function showHelp(){
       var operationPage = "http://help.e-cology.com.cn/help/RemoteHelp.jsp";
       var screenWidth = window.screen.width*1;
       var screenHeight = window.screen.height*1;
       window.open(operationPage+"?pathKey=cowork/coworkview.jsp","_blank","top=0,left="+(screenWidth-800)/2+",height="+(screenHeight-90)+",width=800,status=no,scrollbars=yes,toolbar=yes,menubar=no,location=no");
    }
    
 //�ύ�ظ�ʱ���ύ�ȴ�
 function displayLoading(state,flag){
  if(state==1){
        //���մ�
        var bgHeight=document.body.scrollHeight; 
        var bgWidth=window.parent.document.body.offsetWidth;
        jQuery("#bg").css("height",bgHeight,"width",bgWidth);
        jQuery("#bg").show();
        //alert(1);
        if(flag=="save")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%>");   //���ڱ��棬���Ե�...
        else if(flag=="page")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%>");   //ҳ������У����Ժ�...
        else if(flag=="data")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");   //���ڻ�ȡ����,���Ե�...  
              
        //��ʾloading
	    var loadingHeight=jQuery("#loading").height();
	    var loadingWidth=jQuery("#loading").width();
	    jQuery("#loading").css({"top":'40%',"left":'30%'});
	    jQuery("#loading").show();
    }else{
        jQuery("#loading").hide();
        jQuery("#bg").hide(); //���չر�
    }
}
  
/*������ü�¼*/
var visitTotal=<%=visitTotal%>;
var visitCurrentpage=<%=visitCurrentpage%>;
var visitTotalpage=<%=visitTotalpage%>;
function visitpage(pageType){
  if(pageType=="next"){
     if(visitCurrentpage==visitTotalpage)
        return ;
     visitCurrentpage=visitCurrentpage+1;
     if(visitCurrentpage==visitTotalpage){
        jQuery("#nextpage").attr("src","images/next_page_no.png"); 
     }   
     jQuery("#prepage").attr("src","images/pre_page.png");   
     jQuery.post("visitRecord.jsp?recordType=visit&total="+visitTotal+"&currentpage="+visitCurrentpage,function(data){
        data=jQuery.trim(data);
        jQuery("#visitList").html(data);
     });
  }else{
     if(visitCurrentpage==1)
        return ;
     visitCurrentpage=visitCurrentpage-1;
     if(visitCurrentpage==1){
        jQuery("#prepage").attr("src","images/pre_page_no.png"); 
     } 
     jQuery("#nextpage").attr("src","images/next_page.png");     
     jQuery.post("visitRecord.jsp?recordType=visit&total="+visitTotal+"&currentpage="+visitCurrentpage,function(data){
        data=jQuery.trim(data);
        jQuery("#visitList").html(data);
     });
  }
}  
  
/*������ü�¼*/    

/*������ʼ�¼*/
var accessTotal=<%=accessTotal%>;
var accessCurrentpage=<%=accessCurrentpage%>;
var accessTotalpage=<%=accessTotalpage%>;



function accesspage(pageType){
  if(pageType=="next"){
     if(accessCurrentpage==accessTotalpage)
        return ;
     accessCurrentpage=accessCurrentpage+1;
     if(accessCurrentpage==accessTotalpage){
        jQuery("#accessnextpage").attr("src","images/next_page_no.png"); 
     }
     jQuery("#accessprepage").attr("src","images/pre_page.png"); 
          
     jQuery.post("visitRecord.jsp?recordType=access&total="+accessTotal+"&currentpage="+accessCurrentpage,function(data){
        data=jQuery.trim(data);
        jQuery("#accessList").html(data);
     });
  }else{
     if(accessCurrentpage==1)
        return ;
     accessCurrentpage=accessCurrentpage-1;
     if(accessCurrentpage==1){
        jQuery("#accessprepage").attr("src","images/pre_page_no.png"); 
     }  
     jQuery("#accessnextpage").attr("src","images/next_page.png");    
     jQuery.post("visitRecord.jsp?recordType=access&total="+accessTotal+"&currentpage="+accessCurrentpage,function(data){
        data=jQuery.trim(data);
        jQuery("#accessList").html(data);
     });
  }
}  
  
/*������ü�¼*/  


</script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker.js"></script>

