<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="weaver.blog.BlogShareManager"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.blog.AppItemVo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="weaver.blog.BlogReplyVo"%>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.blog.AppDao"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="blogDao" class="weaver.blog.BlogDao"></jsp:useBean> 
<%
String blogid=Util.null2String(request.getParameter("blogid"));  //΢��id
String userid=""+user.getUID();
String fromPage=Util.null2String(request.getParameter("page"));
String startDate=Util.null2String(request.getParameter("startDate"));
String endDate=Util.null2String(request.getParameter("endDate"));
String requestType=Util.null2String(request.getParameter("requestType")); //��������
String ac=Util.null2String(request.getParameter("ac"));                   //��ѯ����ҳ��
String content=Util.null2String(request.getParameter("content")).replace("'","''");         //��������

String submitdate=Util.null2String(request.getParameter("submitdate"));  //�ύʱ��ָ��ߣ������ʾʱ��

int currentpage=Util.getIntValue(request.getParameter("currentpage"),1);  //ҳ��
int pagesize=Util.getIntValue(request.getParameter("pagesize"),20);       //ÿҳ��ʾ����
int total=Util.getIntValue(request.getParameter("total"),0);              //ÿҳ��ʾ����

int minUpdateid=Util.getIntValue(request.getParameter("minUpdateid"),0);  //�����Ѿ�ȡ�����ĸ���������Сid

String isFirstPage=Util.null2String(request.getParameter("isFirstPage")); //�ҵ�΢��ҳ���ж��Ƿ�Ϊ��һҳ����һҳ�ŷ��ر༭��

BlogManager blogManager=new BlogManager(user);

if("".equals(blogid)){
	blogid=""+user.getUID();
}else{
	BlogShareManager shareManager=new BlogShareManager();
	int status=shareManager.viewRight(blogid,userid); //΢���鿴Ȩ��
	if(status<=0){
	  return ;	
	}
}

SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat dateFormat1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat dateFormat2=new SimpleDateFormat("M��dd��");
SimpleDateFormat dateFormat3=new SimpleDateFormat("yyyy��M��d�� HH:mm");
SimpleDateFormat timeFormat=new SimpleDateFormat("HH:mm");

Date today=new Date();
String todaydate=dateFormat1.format(today);
String curDate=dateFormat1.format(today);
submitdate=submitdate.equals("")?curDate:submitdate;  //�ύ����

int isNeedSubmit=0;
int todayIsReplayed=0; //�����Ƿ����۹�����������۹�����ʾ��������

BlogDiscessVo discessVo;

//��鵱ǰ�û� �����Ƿ���Ҫ�ύ
if(!isFirstPage.equals("false")&&userid.equals(blogid)&&requestType.equals("myblog")){
   isNeedSubmit=blogDao.isNeedSubmit(user,curDate);
   if(blogDao.getReplyList(userid,curDate,userid).size()>0)
		todayIsReplayed=1;
}

String isManagerScore=blogDao.getSysSetting("isManagerScore");  //�����ϼ�����

Date startdateTemp=new Date();
String enableDate="";
String startTmep="";
String endTemp="";
Map conditions=new HashMap();
int totalpage=0;
List updateList=new ArrayList();   //��ø�������id list
List discussList=new ArrayList();  //΢����¼list

if(requestType.equals("homepage")){      //��ȡ΢����ҳ��������
	List attentionList=blogManager.getMyAttention(userid);
	String attentionids=userid;                                 //�����ҹ�ע���˼���,��������
	for(int i=0;i<attentionList.size();i++){
		attentionids=attentionids+","+attentionList.get(i);
	}
	conditions.put("attentionids",attentionids);
	if(total==0){
		total=blogDao.getBlogDiscussCount(conditions);
	}
	totalpage=total%pagesize==0?total/pagesize:total/pagesize+1;
	
	updateList=blogDao.getUpdateDiscussidList(userid);
	discussList=blogManager.getBlogDiscussVOList(userid,currentpage, pagesize,total,conditions);
}else if(requestType.equals("myblog")){  //�ҵ�΢����ҳ
	
	enableDate=blogDao.getSysSetting("enableDate");          //΢������ʱ��
	if("".equals(endDate)){
		Date endDateTmp=new Date();
		if(isNeedSubmit!=0||!userid.equals(blogid)||todayIsReplayed==1)  //���������û���΢������ʾ����
			endDateTmp.setDate(endDateTmp.getDate());
		else
			endDateTmp.setDate(endDateTmp.getDate()-1);
		endDate=dateFormat1.format(endDateTmp);
		
		startdateTemp=endDateTmp;
		startdateTemp.setDate(endDateTmp.getDate()-pagesize);
		startDate=dateFormat1.format(startdateTemp);
	}else{
		startdateTemp=dateFormat1.parse(endDate);
		startdateTemp.setDate(startdateTemp.getDate()-pagesize);
	}
	
	if(dateFormat1.parse(enableDate).getTime()>startdateTemp.getTime()){
		startDate=enableDate;
	}else{
		startDate=dateFormat1.format(startdateTemp);
	}
	
	discussList=blogManager.getDiscussListAll(blogid,startDate,endDate);
}else if(requestType.equals("commentOnMe")){    //�����ҵ�
	if(total==0){
		total=blogDao.getCommentTotal(userid);
	}
	
	totalpage=total%pagesize==0?total/pagesize:total/pagesize+1;
	discussList=blogDao.getCommentDiscussVOList(userid,currentpage,pagesize,total);
}else if(requestType.equals("homepageNew")){   //������������
	
	updateList=blogDao.getUpdateDiscussidList(userid);
	if(minUpdateid==0){
		minUpdateid=blogDao.getUpdateMaxRemindid(userid)+1;
	}
	Map map=blogDao.getUpdateDiscussVOList(userid, pagesize,minUpdateid);
	discussList=(List)map.get("discussList");
	minUpdateid=((Integer)map.get("maxUpdateid")).intValue();
}else if(requestType.equals("search")){       //ͨ������
	enableDate=blogDao.getSysSetting("enableDate");    //΢������ʱ��
	endDate=endDate.equals("")?curDate:endDate;
	endDate=dateFormat1.parse(enableDate).getTime()>dateFormat1.parse(endDate).getTime()?enableDate:endDate;
	
	if(startDate.equals("")){
		startdateTemp=dateFormat1.parse(endDate);
		startdateTemp.setDate(dateFormat1.parse(endDate).getDate()-30);
		startDate=dateFormat1.format(startdateTemp);
	}
	startDate=dateFormat1.parse(enableDate).getTime()>dateFormat1.parse(startDate).getTime()?enableDate:startDate;
	
	startdateTemp=dateFormat1.parse(endDate);
	startdateTemp.setDate(startdateTemp.getDate()-(currentpage-1)*pagesize-(currentpage-1));
	  
	endTemp=dateFormat1.format(startdateTemp);
	
	startdateTemp.setDate(startdateTemp.getDate()-pagesize);
	startTmep=dateFormat1.format(startdateTemp);
	
	endTemp=dateFormat1.parse(endTemp).getTime()<dateFormat1.parse(startDate).getTime()?startDate:endTemp;
	startTmep=dateFormat1.parse(startTmep).getTime()<dateFormat1.parse(startDate).getTime()?startDate:startTmep;
	
	if("myBlog".equals(ac)||"user".equals(ac)){
		 if("".equals(content))
		    discussList=blogManager.getDiscussListAll(blogid,startTmep,endTemp);
		 else{
			conditions.put("attentionids",blogid);  //�ҵ�΢����ѯ ֻ��΢������������
		    conditions.put("endDate",endDate);
			conditions.put("startDate",startDate);
			conditions.put("content",content);
			if(total==0){
				total=blogDao.getBlogDiscussCount(conditions);
			}
			totalpage=total%pagesize==0?total/pagesize:total/pagesize+1;
			discussList=blogManager.getBlogDiscussVOList(userid,currentpage, pagesize,total,conditions);
		 }
	}
	
	if("homepage".equals(ac)||"gz".equals(ac)){ //΢����ҳ  �ҵĹ�עҳ������
		List attentionList=blogManager.getMyAttention(""+user.getUID());
		 String attentionids=userid; //��������
		 for(int i=0;i<attentionList.size();i++){
			 attentionids=attentionids+","+attentionList.get(i);
		 } 
		conditions.put("attentionids",attentionids); 
		conditions.put("endDate",endDate);
		conditions.put("startDate",startDate);
		conditions.put("content",content);
		if(total==0){
			total=blogDao.getBlogDiscussCount(conditions);
		}
		totalpage=total%pagesize==0?total/pagesize:total/pagesize+1;
		discussList=blogManager.getBlogDiscussVOList(userid,currentpage, pagesize,total,conditions);
	}
}

AppDao appDao=new AppDao();
boolean moodIsActive=appDao.getAppVoByType("mood").isActive();
//���� ��һ �ܶ� ���� ���� ���� ���� 
String []week={SystemEnv.getHtmlLabelName(16106,user.getLanguage()),SystemEnv.getHtmlLabelName(16100,user.getLanguage()),SystemEnv.getHtmlLabelName(16101,user.getLanguage()),SystemEnv.getHtmlLabelName(16102,user.getLanguage()),SystemEnv.getHtmlLabelName(16103,user.getLanguage()),SystemEnv.getHtmlLabelName(16104,user.getLanguage()),SystemEnv.getHtmlLabelName(16105,user.getLanguage())};

//������ʾ������ �����Ƿ���д  �Ƿ�Ϊ��ǰ�û��鿴 ��һ��ȡ�б���ʾ  ������΢���鿴�˵�������ҳ�鿴�˵�
if(isNeedSubmit!=3&&userid.equals(blogid)&&requestType.equals("myblog")&&!isFirstPage.equals("false")){
%>
 <div class="reportItem" tid="0" forDate="<%=curDate%>" isToday="true" isNeedSubmit="<%=isNeedSubmit%>"> 
				<table width="100%">
					<colgroup>
						<col width="60px;">
					</colgroup>
					<tr>
						<td valign="top">
							<div class="dateArea">
								<div class="day"><%=SystemEnv.getHtmlLabelName(15537,user.getLanguage())%></div><!-- ���� -->
								<div class="yearAndMonth"><%=dateFormat2.format(today)%></div>
							</div>
						</td>
						<td valign="top">
								<div class="discussView" style="display: none;"></div>
								<div class="editor" style="display:block;"></div>
						</td>
					</tr>
				</table>
	</div>
<%} %>

<%
//��ȡ������ǰ�ļ�¼
if(discussList.size()>0){
for(int i=0;i<discussList.size();i++){
	discessVo=(BlogDiscessVo)discussList.get(i);
	if(discessVo==null)
		continue;
	String discussid=discessVo.getId();
	String workdate=discessVo.getWorkdate();
	long   todaytime=today.getTime(); 
	long   worktime=dateFormat1.parse(workdate).getTime(); 
	//��ȡĳ�������յ������Ѿ�������
	long daysFromWorkDate=(todaytime-worktime)/(24*60*60*1000);
	
	if(discussid!=null){
		String createdate=discessVo.getCreatedate();
		
		long createDateTime=dateFormat1.parse(createdate).getTime();
		long daysFromCreateDate=(todaytime-createDateTime)/(24*60*60*1000); //�����ύʱ���뵱ǰʱ���� 
		discussid=discessVo.getId();
		boolean isCanEdit=userid.equals(discessVo.getUserid())&&daysFromCreateDate<=3&&(requestType.equals("myblog"));
		String comefrom=discessVo.getComefrom();
		String comefromTemp="";
		if(comefrom.equals("1"))  
			comefromTemp="(����Iphone)";
		else if(comefrom.equals("2"))  
			comefromTemp="(����Ipad)";
		else if(comefrom.equals("3"))  
			comefromTemp="(����Android)";          
		else if(comefrom.equals("4"))  
			comefromTemp="(����Web�ֻ���)";
	    else
	    	comefromTemp="";       	
		
		AppItemVo  appItemVo=null;
		if(moodIsActive)
		  appItemVo=appDao.getappItemByDiscussId(discussid); 
		boolean unRead=updateList.contains(discussid);
			
%>

<%
//�ύʱ��ָ���
if((requestType.equals("homepage")||requestType.equals("homepageNew"))&&!createdate.equals(submitdate)){
	submitdate=createdate;
	Date dateTemp=new Date();
	dateTemp.setDate(dateTemp.getDate()-1);
	String yesterday=dateFormat1.format(dateTemp);      //����
	dateTemp.setDate(dateTemp.getDate()-1);
	String beforeyesterday=dateFormat1.format(dateTemp);//ǰ��
	String weekday=week[dateFormat1.parse(submitdate).getDay()];
	
	if(submitdate.equals(yesterday))
		weekday="����";
	else if(submitdate.equals(beforeyesterday))
		weekday="ǰ��";
%>
<div class="seprator">
    <div class="bg_1">
        <div class="bg_2">������<%=dateFormat2.format(dateFormat1.parse(submitdate))%> <%=weekday%> �ύ����</div>
    </div>
</div>
<%} %>

<div class="reportItem" userid="<%=discessVo.getUserid()%>" id="<%=discussid%>" tid="<%=discussid%>" forDate="<%=workdate%>"  <%=moodIsActive&&appItemVo!=null?"appItemId="+appItemVo.getId():""%>  isTodayItem="<%=i==0&&todaydate.equals(workdate)?"true":"false"%>" isToday="false" <%if(requestType.equals("homepage")||requestType.equals("homepageNew")){%><%if(unRead){%> isRead="false"<%}%> onmouseover="readDiscuss(this,<%=discussid%>,<%=discessVo.getUserid()%>)" onmouseout="moveout(this)"<%}%>> 
<table width="100%" style="TABLE-LAYOUT: fixed;">
	<tr>
		<td valign="top" width="75px" nowrap="nowrap">
		    <div class="dateArea">
			  <%if(requestType.equals("homepage")||requestType.equals("homepageNew")||(requestType.equals("search")&&!ac.equals("myBlog")&&!"user".equals(ac))){%>
			        <img width="57px" height="50px" style="margin-top:6px" src="<%=ResourceComInfo.getMessagerUrls(discessVo.getUserid())%>">
			  <%}else{ %>
			  <%if(workdate.equals(todaydate)){ %>
					<div class="day"><%=SystemEnv.getHtmlLabelName(15537,user.getLanguage())%></div><!-- ���� -->
			  <%} else{%>
					<div class="day"><%=week[dateFormat1.parse(workdate).getDay()] %></div>
			  <%} %>			
				    <div class="yearAndMonth"><%=dateFormat2.format(dateFormat1.parse(workdate)) %></div>
			<%} %>
			</div>
		</td>
		<td valign="top">
			<div class="discussView">
			<div class="sortInfo">
			   <span style="float: left;">
					<span class="name">&nbsp;<a href="viewBlog.jsp?blogid=<%=discessVo.getUserid() %>" target="_blank"><%=ResourceComInfo.getLastname(discessVo.getUserid())  %></a>&nbsp;</span>
						<%if("0".equals(discessVo.getIsReplenish())){ %>
						   <div class="state ok" title="<%=SystemEnv.getHtmlLabelName(26924,user.getLanguage())%>"></div> <!-- �ύ�� -->
							<span class="datetime">
							    <%=dateFormat3.format(dateFormat.parse(discessVo.getCreatedate()+" "+discessVo.getCreatetime())) %>&nbsp;
							</span>
						<%}else { %>
						    <div class="state after" title="<%=SystemEnv.getHtmlLabelName(26925,user.getLanguage())%>"></div> <!-- ������ -->
							<span class="datetime">
								<%=dateFormat3.format(dateFormat.parse(discessVo.getCreatedate()+" "+discessVo.getCreatetime())) %>&nbsp;
							</span>
						<%} %>
						<!-- �ϼ����� -->
						<%if(isManagerScore.equals("1")){%>
						   <span  style='width: 100px' score='<%=discessVo.getScore()%>' readOnly='<%=!(""+user.getUID()).equals(ResourceComInfo.getManagerID(discessVo.getUserid()))%>' discussid='<%=discussid%>' target='blog_raty_keep_<%=discussid%>' class='blog_raty' id='blog_raty_<%=discussid%>'></span>
					    <%} %>
					<%if(moodIsActive&&appItemVo!=null){ %>
						<img id="moodIcon" style="margin-left: 2px;margin-right: 2px;" width="16px" src="<%=appItemVo.getFaceImg()%>" alt="<%=SystemEnv.getHtmlLabelName(Util.getIntValue(appItemVo.getItemName()),user.getLanguage())%>"/>
					<%} %>
					<!-- δ����� -->
					<%if(unRead){%>    
					    <img src="/images/BDNew.gif" id="new_<%=discussid%>">
					<%}%>
					<!-- ���� -->
					    <span class="comefrom"><%=comefromTemp%></span> 
				</span>
				<span class="sortInfoRightBar" >
					<%if(isCanEdit){ %>
					   <span onclick="editContent(this)" style="cursor: pointer;">
					      <%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%><!-- �༭ --> 
					   </span>
					<%} %>
					<span onclick="showReplySubmitBox(this,<%=discussid%>,{'uid':'<%=user.getUID() %>','level':'0'},0)" style="cursor: pointer;">
					   <a><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%></a><!-- ���� -->
					</span>
					<span onclick="showReplySubmitBox(this,<%=discussid%>,{'uid':'<%=user.getUID() %>','level':'0'},1)" style="cursor: pointer;">
					   <a>˽��</a><!-- ���� -->
					</span>
				</span>
			</div>
			<div class="clear reportContent" tid="<%=discussid%>"> 
				<%=discessVo.getContent() %>
				<%if((requestType.equals("homepage")||requestType.equals("homepageNew"))&&discessVo.getIsReplenish().equals("1")){%>
					<span style="color:#0033ff;padding-top: 3px">
					   <!-- ����2011-11-1����΢�� -->
					   <br>(<%=SystemEnv.getHtmlLabelName(26927,user.getLanguage())%> <%=dateFormat2.format(dateFormat1.parse(workdate))%> <%=week[dateFormat1.parse(discessVo.getWorkdate()).getDay()] %> <%=SystemEnv.getHtmlLabelName(26759,user.getLanguage())%>)
					</span>
				<%} %>
			</div>
			<%
			List replayList=blogDao.getReplyList(discessVo.getUserid(),workdate,userid); 
			if(replayList.size()>0){   
			%>
			<div class="reply" > 
				<%
				BlogReplyVo replyVo=new BlogReplyVo();
				int index=0;
				for(int j=0;j<replayList.size();j++){
					replyVo=(BlogReplyVo)replayList.get(j);
					
					String replyComefrom=replyVo.getComefrom();
					String commentType=replyVo.getCommentType();
					String replyComefromTemp="";
					if(!replyComefrom.equals("0")||commentType.equals("1"))
						   replyComefromTemp="(";
				    if(commentType.equals("1"))	
				    	   replyComefromTemp+="˽��";
				    	
					if(replyComefrom.equals("1"))  
						replyComefromTemp+="&nbsp;����Iphone";
					else if(replyComefrom.equals("2"))  
						replyComefromTemp+="&nbsp;����Ipad)";
					else if(replyComefrom.equals("3"))  
						replyComefromTemp+="&nbsp;����Android";          
					else if(replyComefrom.equals("4"))  
						replyComefromTemp+="&nbsp;����Web�ֻ���";
				         
					if(!replyComefrom.equals("0")||commentType.equals("1"))
						   replyComefromTemp+=")";
				%>
			  <div id="re_<%=replyVo.getId()%>">
				<div class="sortInfo replyTitle">
						<span class="name">&nbsp;<a href="viewBlog.jsp?blogid=<%=replyVo.getUserid() %>" target="_blank"><%=ResourceComInfo.getLastname(replyVo.getUserid())%></a>&nbsp;</span>
						<div class="state re" title="<%=SystemEnv.getHtmlLabelName(26926,user.getLanguage())%>"></div> <!-- ������ -->
						<span class="datetime">
						    <%=dateFormat3.format(dateFormat.parse(replyVo.getCreatedate()+" "+replyVo.getCreatetime())) %>&nbsp;
						    <span class="comefrom"><%=replyComefromTemp%></span>
						</span>
						
						<span class="sortInfoRightBar">
							<%if((""+user.getUID()).equals(replyVo.getUserid())&&j==replayList.size()-1){
								long sepratorTime=(today.getTime()-dateFormat.parse(replyVo.getCreatedate()+" "+replyVo.getCreatetime()).getTime())/(1000*60);
								if(sepratorTime<=10){
							%>
								<a href='javascript:void(0)' class='deleteOperation' onclick="deleteDiscuss(this,<%=discussid%>,'<%=replyVo.getId()%>')"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a><!-- ɾ�� -->
							<%}} %>
							<a href="javascript:void(0)"  onclick="showReplySubmitBox(this,'<%=discussid%>',{'uid':'<%=replyVo.getUserid()%>','name':'<%=ResourceComInfo.getLastname(replyVo.getUserid())%>','level':'1','replyid':'<%=replyVo.getId() %>'},0)"><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%></a><!-- ���� -->
							<a href="javascript:void(0)"  onclick="showReplySubmitBox(this,'<%=discussid%>',{'uid':'<%=replyVo.getUserid()%>','name':'<%=ResourceComInfo.getLastname(replyVo.getUserid())%>','level':'1','replyid':'<%=replyVo.getId() %>'},1)">˽��</a><!-- ���� -->
						</span>
					</div>
					<div class="clear reportContent">
						<%=replyVo.getContent()%>
					</div>
				</div>
				<%if(j<replayList.size()-1){ %>
					<div class="dotedline"></div>
				<%} %>
				<%} %>
				</div>
				<%} %>
				</div>
				<div class="commitBox"></div>
				<div class="editor" tid="<%=discussid%>" style="display: none;"></div>
			</td>
		</tr>
	</table>
</div>
<%
	}else {
		%>
			<div class="reportItem" tid="0" unsubmit="true" userid="<%=discessVo.getUserid()%>" forDate="<%=workdate%>" isTodayItem="<%=i==0&&todaydate.equals(workdate)?"true":"false"%>" isToday="false" >
				<table width="100%">
					<colgroup>
						<col width="60px;">
					</colgroup>
					<tr>
						<td valign="top">
							<div class="dateArea">
								<%if(workdate.equals(todaydate)){ %>
									<div class="day"><%=SystemEnv.getHtmlLabelName(15537,user.getLanguage())%></div><!-- ���� -->
								<%} else{%>
									<div class="day"><%=week[dateFormat1.parse(workdate).getDay()] %></div>
								<%} %>
								<div class="yearAndMonth"><%=dateFormat2.format(dateFormat1.parse(workdate)) %></div>
							</div>
						</td>
						<td valign="top">
								<div class="discussView">
								<div class="sortInfo" style="float: left;background:#f5f4f4;width: 100%;height:28px;padding-top: 5px">
								   <span style="float: left;">
										<span class="name">&nbsp;<a href="viewBlog.jsp?blogid=<%=discessVo.getUserid()%>" target="_blank"><%=ResourceComInfo.getLastname(discessVo.getUserid()) %></a>&nbsp;</span>
										<div class="state no"></div>
										<span class="unSumit">
											&nbsp;<%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%>&nbsp;<!-- δ�ύ -->
										</span>
									</span>
									<span class="sortInfoRightBar"  style="cursor: pointer;">
									   <%
										if(userid.equals(discessVo.getUserid())&&daysFromWorkDate<=7){
									   %>
									    <span onclick="showAfterSubmit(this);"><a><%=dateFormat1.format(today).equals(discessVo.getWorkdate())?"�ύ":SystemEnv.getHtmlLabelName(26927,user.getLanguage())%></a></span><!--�ύ ���� -->
									  <%} else if(!userid.equals(blogid)&&daysFromWorkDate<=7){ %>
									    <span onclick="unSumitRemind(this,<%=blogid%>,<%=user.getUID()%>,'<%=discessVo.getWorkdate()%>');"><a><%=SystemEnv.getHtmlLabelName(26928,user.getLanguage())%></a></span><!-- ���� -->
									  <%}%>
									    <span onclick="showReplySubmitBox(this,0,{'uid':'<%=discessVo.getUserid()%>','level':'0'},0)" style="cursor: pointer;"><a>����</a></span><!-- ���� -->
									    <span onclick="showReplySubmitBox(this,0,{'uid':'<%=discessVo.getUserid()%>','level':'0'},1)"><a>˽��</a></span><!-- ���� -->
									</span>
								</div>
								<div class="reportContent"></div>
								<%
								List replayList=blogDao.getReplyList(discessVo.getUserid(),workdate,userid);
								if(replayList.size()>0){
								%>
								<div class="reply" > 
									<%
									BlogReplyVo replyVo=new BlogReplyVo();
									int index=0;
									for(int j=0;j<replayList.size();j++){
										replyVo=(BlogReplyVo)replayList.get(j);
										
										String replyComefrom=replyVo.getComefrom();
										String commentType=replyVo.getCommentType();
										String replyComefromTemp="";
										if(!replyComefrom.equals("0")||commentType.equals("1"))
											   replyComefromTemp="(";
									    if(commentType.equals("1"))	
									    	   replyComefromTemp+="˽��";
									    	
										if(replyComefrom.equals("1"))  
											replyComefromTemp+="&nbsp;����Iphone";
										else if(replyComefrom.equals("2"))  
											replyComefromTemp+="&nbsp;����Ipad)";
										else if(replyComefrom.equals("3"))  
											replyComefromTemp+="&nbsp;����Android";          
										else if(replyComefrom.equals("4"))  
											replyComefromTemp+="&nbsp;����Web�ֻ���";
									         
										if(!replyComefrom.equals("0")||commentType.equals("1"))
											   replyComefromTemp+=")";
										
									%>
								  <div id="re_<%=replyVo.getId()%>">
									<div class="sortInfo replyTitle">
											<span class="name">&nbsp;<a href="viewBlog.jsp?blogid=<%=replyVo.getUserid() %>" target="_blank"><%=ResourceComInfo.getLastname(replyVo.getUserid())%></a>&nbsp;</span>
											<div class="state re" title="<%=SystemEnv.getHtmlLabelName(26926,user.getLanguage())%>"></div> <!-- ������ -->
											<span class="datetime">
											    <%=dateFormat3.format(dateFormat.parse(replyVo.getCreatedate()+" "+replyVo.getCreatetime())) %>&nbsp;
											    <span class="comefrom"><%=replyComefromTemp%></span>
											</span> 
											
											<span class="sortInfoRightBar">
												<%if((""+user.getUID()).equals(replyVo.getUserid())&&j==replayList.size()-1){
													long sepratorTime=(today.getTime()-dateFormat.parse(replyVo.getCreatedate()+" "+replyVo.getCreatetime()).getTime())/(1000*60);
													if(sepratorTime<=10){
												%>
													<a href='javascript:void(0)' class='deleteOperation' onclick="deleteDiscuss(this,0,'<%=replyVo.getId()%>')"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a><!-- ɾ�� -->
												<%}} %>
												<a href="javascript:void(0)"  onclick="showReplySubmitBox(this,0,{'uid':'<%=replyVo.getUserid()%>','name':'<%=ResourceComInfo.getLastname(replyVo.getUserid())%>','level':'1','replyid':'<%=replyVo.getId() %>'},0)"><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%></a><!-- ���� -->
												<a href="javascript:void(0)"  onclick="showReplySubmitBox(this,0,{'uid':'<%=replyVo.getUserid()%>','name':'<%=ResourceComInfo.getLastname(replyVo.getUserid())%>','level':'1','replyid':'<%=replyVo.getId() %>'},1)">˽��</a><!-- ���� -->
											</span>
										</div>
										<div class="clear reportContent">
											<%=replyVo.getContent()%>
										</div>
									</div>
									<%if(j<replayList.size()-1){ %>
										<div class="dotedline"></div>
									<%} %>
									<%}} %>
									
									</div>	
							</div>
							<div class="commitBox"></div>
							<div class="editor" style="display:none;" tid="0"></div>
						</td>
					</tr>
				</table>
			</div>
		<%
	}
  }
}%>

<%
String url="";
String haveNextPage="0";
if(requestType.equals("homepage")||requestType.equals("commentOnMe")){
	if(totalpage>1&&currentpage<totalpage){
		currentpage=currentpage+1;
		url="discussList.jsp?requestType="+requestType+"&currentpage="+currentpage+"&pagesize="+pagesize+"&total="+total+"&submitdate="+submitdate;
		haveNextPage="1";
	}
}else if(requestType.equals("homepageNew")){
	if(minUpdateid>blogDao.getUpdateMinRemindid(userid)){
		url="discussList.jsp?requestType="+requestType+"&currentpage="+currentpage+"&pagesize="+pagesize+"&minUpdateid="+minUpdateid+"&submitdate="+submitdate;
		haveNextPage="1";
	}
}else if(requestType.equals("myblog")){
	startdateTemp.setDate(startdateTemp.getDate()-1);
	startDate=dateFormat1.format(startdateTemp); 
	if(startdateTemp.getTime()>=dateFormat1.parse(enableDate).getTime()){
		url="discussList.jsp?blogid="+blogid+"&requestType="+requestType+"&endDate="+startDate+"&isFirstPage=false";
		haveNextPage="1";
	}
}else if(requestType.equals("search")){
	if(("myBlog".equals(ac)||"user".equals(ac))){
		if(content.equals("")&&dateFormat1.parse(startDate).getTime()<startdateTemp.getTime()){
			currentpage=currentpage+1;
			url="discussList.jsp?blogid="+blogid+"&requestType="+requestType+"&startDate="+startDate+"&endDate="+endDate+"&content="+content+"&ac="+ac+"&currentpage="+currentpage;
			haveNextPage="1";
		}else if(totalpage>1&&currentpage<totalpage){
			currentpage=currentpage+1;
			url="discussList.jsp?blogid="+blogid+"&requestType="+requestType+"&startDate="+startDate+"&endDate="+endDate+"&content="+content+"&ac="+ac+"&currentpage="+currentpage+"&total="+total;
			haveNextPage="1";
		}
	}
	if(("homepage".equals(ac)||"gz".equals(ac))&&totalpage>1&&currentpage<totalpage){
		currentpage=currentpage+1;
		url="discussList.jsp?requestType="+requestType+"&startDate="+startDate+"&endDate="+endDate+"&content="+content+"&ac="+ac+"&currentpage="+currentpage+"&total="+total;
		haveNextPage="1";
	}
}

if(haveNextPage.equals("1")){
%>
<DIV id=moreList class=moreFoot onclick="getMore(this,'<%=url%>','<%=requestType%>','<%=content%>')" style="margin-bottom: 20px">
  <A hideFocus href="javascript:void(0)">
     <EM class=ico_load></EM>�� ��<EM class="more_down"></EM>
  </A>
</DIV>
<%}else if(discussList.size()==0)
	out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(22521,user.getLanguage())+"</div>");
%>		
