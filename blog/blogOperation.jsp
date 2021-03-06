<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="weaver.blog.BlogReportManager"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.systeminfo.menuconfig.MenuUtil"%>
<%@page import="weaver.mobile.webservices.MobileServiceImpl"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="weaver.general.GCONST"%>
<%@page import="weaver.blog.AppDao"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@ page import="weaver.blog.BlogShareManager"%>
<%@ page import="weaver.file.FileUpload" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="net.sf.json.JSONObject"%>
<jsp:useBean id="blogDao" class="weaver.blog.BlogDao"></jsp:useBean>
<%
    String userid=""+user.getUID();
    request.setCharacterEncoding("UTF-8"); 
    FileUpload fu = new FileUpload(request);
    BlogManager blogManager=new BlogManager(user);
    
	String operation=Util.null2String(fu.getParameter("operation"));
	String attentionid=Util.null2String(fu.getParameter("attentionid"));   //关注者id
	String islower=Util.null2String(fu.getParameter("islower"));           //是否为当前用户下属
	String tempid=Util.null2String(request.getParameter("tempid"));  //报表模板id
	BlogReportManager reportManager=new BlogReportManager();
	/*关注处理*/
	if(operation.equals("addAttention")){                 //添加关注
	    blogManager.addAttention(userid,attentionid,islower);
	    blogDao.addRemind(attentionid,userid,"5","","0");  //关注我的+1提醒
	}else if(operation.equals("cancelAttention")){       //取消关注
		blogManager.cancelAttention(userid,attentionid,islower);
	}else if(operation.equals("requestAttention")){     //申请关注
		blogManager.requestAttention(userid,attentionid,islower);
	}else if(operation.equals("dealRequest")){
		String requestid=Util.null2String(fu.getParameter("requestid"));
		String sender=Util.null2String(fu.getParameter("sender"));
		String status=Util.null2String(fu.getParameter("status"));
		blogManager.dealRequest(userid,sender,requestid,status);
		if(status.equals("1")){        //同意
		   blogDao.addRemind(sender,userid,"2","","0");  //申请成功提醒
		}else if(status.equals("-1"))  //拒绝
		   blogDao.addRemind(sender,userid,"3","","0");	//申请失败提醒
	}else if(operation.equals("delMsg")){
		String msgid=Util.null2String(fu.getParameter("msgid"));
		String remindType=Util.null2String(fu.getParameter("remindType"));
		String sql="";
		if(remindType.equals("8"))
		  sql="update blog_remind set status=-1 where id="+msgid;
		else
		  sql="delete from blog_remind where id="+msgid;	
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("unsubmitRemind")){     //未提交提醒
		String remindid=Util.null2String(fu.getParameter("remindid"));
		String relatedid=Util.null2String(fu.getParameter("discussant"));
		String remindValue=Util.null2String(fu.getParameter("workdate"));
		String sql="select id from blog_remind where remindid="+remindid+" and relatedid="+relatedid+" and remindType=7 and remindValue='"+remindValue+"'";
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
		if(!recordSet.next())
		   blogDao.addRemind(remindid,relatedid,"7",remindValue,"0");	//申请失败提醒
	}else if(operation.equals("signCheck")){         //签到 签退检查微博是否提交
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String status=blogDao.getBlogStatus();       //微博启用状态
		Date enabledate=dateFormat.parse(blogDao.getSysSetting("enableDate")); //微博启用时间
		Date currentdate=dateFormat.parse(dateFormat.format(new Date()));      //当前日期
		String isSignRemind=blogDao.getSysSetting("isSingRemind");    //是否启用签到提醒
		String checkday=Util.null2String(fu.getParameter("checkday"));//检查何时的工作微博
		
		boolean todayHasBlog=true;         //今天是否提交工作微博了
		boolean prevWorkDayHasBlog=true;   //上一个工作日是否提交工作微博
		
		if(status.equals("1")&&isSignRemind.equals("1")&&currentdate.getTime()>=enabledate.getTime()){
			SimpleDateFormat frm=new SimpleDateFormat("yyyy-MM-dd");
		    if(checkday.equals("today"))       //签退时检查今天
			   todayHasBlog=blogDao.chkDiscussExits(userid,frm.format(new Date()));
		    if(checkday.equals("prevWorkDay")){//签到时检查上一个工作日
				WorkDayDao workDayDao=new WorkDayDao(user);
				for(int j=1;j<7;j++){
					Date tmpDate=new Date();
					tmpDate.setDate(tmpDate.getDate()-j);
					if(workDayDao.getIsWorkday(frm.format(tmpDate))){
						prevWorkDayHasBlog=blogDao.chkDiscussExits(""+user.getUID(),frm.format(tmpDate));
						break;
					}
				}
		    }
		}
		Map map=new HashMap();
		map.put("isSignRemind",isSignRemind);
		map.put("todayHasBlog",new Boolean(todayHasBlog));
		map.put("prevWorkDayHasBlog",new Boolean(prevWorkDayHasBlog));
		out.print(JSONObject.fromObject(map));
	}else if(operation.equals("markCommentRead")){ //标记评论为已读
		String sql="delete from blog_remind where remindType=9 and remindid="+userid; 
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("delUpdateRemind")){ //删除更新提醒
		String sql="delete from blog_remind where remindType=6 and remindid="+userid;
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("managerScore")){     //上级评分
		String discussid=Util.null2String(fu.getParameter("discussid"));
		String score=Util.null2String(fu.getParameter("score"));
		
		String sql="update blog_discuss set score='"+score+"' where id="+discussid;
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("getHomepageTotal")){    //获取主页记录总数
		List attentionList=blogManager.getMyAttention(userid);
		String attentionids=userid;                                 //所有我关注的人集合,包含自身
		for(int i=0;i<attentionList.size();i++){
			attentionids=attentionids+","+attentionList.get(i);
		}
		int total=blogDao.getBlogDiscussCount(attentionids);
		out.println(total);
	}else if(operation.equals("readDiscuss")){    //删除更新提醒 和 添加访问记录  阅读记录
		String discussid=Util.null2String(fu.getParameter("discussid"));
		String blogid=Util.null2String(fu.getParameter("blogid"));
		String sql="delete from blog_remind where remindType=6 and remindid="+userid+" and remindValue='"+discussid+"'";
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
		blogDao.addReadRecord(userid,blogid);  //添加已读记录
	    blogDao.addVisitRecord(userid,blogid); //添加访问记录
	}else if(operation.equals("getDiscussContent")){
		String discussid=Util.null2String(fu.getParameter("discussid"));
		BlogDiscessVo discessVo=blogDao.getDiscussVo(discussid);
		out.print(discessVo.getContent());
	}else if(operation.equals("getIndex")){
		Calendar calendar = Calendar.getInstance();
		int currentMonth = calendar.get(Calendar.MONTH) + 1;
		int currentYear = calendar.get(Calendar.YEAR);
		reportManager.setUser(user);
		
		Map index=new HashMap();
		String blogid=Util.null2String(fu.getParameter("blogid"));
		//工作指数
		Map workMap=new HashMap();
		Map resultMap = reportManager.getBlogReportByUser(blogid,currentYear, currentMonth);
		int totalWorkday = ((Integer) resultMap.get("totalWorkday")).intValue(); //当月工作日总数
		int totalUnsubmit = ((Integer) resultMap.get("totalUnsubmit")).intValue(); //微博未提交总数
		double workIndex = ((Double) resultMap.get("workIndex")).doubleValue(); //工作指数

		workMap.put("workIndex",""+resultMap.get("workIndex"));
		workMap.put("workIndexTitle",SystemEnv.getHtmlLabelName(15178,user.getLanguage())+totalUnsubmit+SystemEnv.getHtmlLabelName(1925,user.getLanguage())+SystemEnv.getHtmlLabelName(26932,user.getLanguage())+totalWorkday+SystemEnv.getHtmlLabelName(1925,user.getLanguage()));
		workMap.put("workIndexStar",reportManager.getReportIndexStar(workIndex));
		index.put("work",workMap);
		
		//心情指数
		AppDao appDao = new AppDao();
		if(appDao.getAppVoByType("mood").isActive()){ 
			Map moodMap=new HashMap();
			Map moodResultMap = reportManager.getMoodReportByUser(blogid,currentYear, currentMonth);
			int happyDays = ((Integer) moodResultMap.get("happyDays")).intValue();
			int unHappyDays = ((Integer) moodResultMap.get("unHappyDays")).intValue();
			double moodIndex = ((Double) moodResultMap.get("moodIndex")).doubleValue(); //心情指数
			
			moodMap.put("moodIndex",""+moodResultMap.get("moodIndex"));
			moodMap.put("moodIndexTitle",SystemEnv.getHtmlLabelName(26918,user.getLanguage())+unHappyDays+SystemEnv.getHtmlLabelName(1925,user.getLanguage())+SystemEnv.getHtmlLabelName(26917,user.getLanguage())+happyDays+SystemEnv.getHtmlLabelName(1925,user.getLanguage()));
			moodMap.put("moodIndexStar",reportManager.getReportIndexStar(moodIndex));
			index.put("mood",moodMap);
		}
		//考勤指数
		String isSignInOrSignOut=Util.null2String(GCONST.getIsSignInOrSignOut());
		if(isSignInOrSignOut.equals("1")){
		   Map scheduleMap=new HashMap();	
		   Map schedulrResultMap=reportManager.getScheduleReportByUser(blogid,currentYear,currentMonth); 
		   double scheduleIndex=((Double)schedulrResultMap.get("scheduleIndex")).doubleValue();    //考勤指数
		   int totalAbsent=((Integer)schedulrResultMap.get("totalAbsent")).intValue();          //旷工总天数
		   int totalLate=((Integer)schedulrResultMap.get("totalLate")).intValue();              //迟到总天数
		   
		   scheduleMap.put("scheduleIndex",""+schedulrResultMap.get("scheduleIndex"));
		   scheduleMap.put("scheduleIndexTitle",SystemEnv.getHtmlLabelName(20085,user.getLanguage())+totalAbsent+SystemEnv.getHtmlLabelName(18083,user.getLanguage())+SystemEnv.getHtmlLabelName(20081,user.getLanguage())+totalLate+SystemEnv.getHtmlLabelName(18083,user.getLanguage())+SystemEnv.getHtmlLabelName(18609,user.getLanguage())+totalWorkday+SystemEnv.getHtmlLabelName(20079,user.getLanguage()));
		   scheduleMap.put("scheduleIndexStar",reportManager.getReportIndexStar(scheduleIndex));
		   
		   index.put("schedule",scheduleMap);
		} 
		JSONObject json=JSONObject.fromObject(index);
		out.println(json);
	}else if(operation.equals("getMyAttentionCount")){ //获取我关注的人总数
		int total=blogDao.getMyAttentionCount(userid);
		out.println(total);
	}else if(operation.equals("saveNotepad")){ //保存记事本内容
	    String content=Util.null2String(request.getParameter("content")); //记事本内容
		String saveType=Util.null2String(fu.getParameter("saveType"));//保存类型
		blogDao.saveNotes(userid,content,saveType); //保存内容
	}
	
	/*自定义报表*/
	if(operation.equals("addReport")){          
	   tempid=reportManager.addReportTemp(userid);
       out.println(tempid);
	}else if(operation.equals("editReport")){      
	  String tempName=Util.fromScreen(Util.null2String(request.getParameter("tempName")),user.getLanguage());	
	  reportManager.editReportTemp(tempid,tempName);
	}else if(operation.equals("delReport")){ 
	  reportManager.delReportTemp(tempid); 	
	}else if(operation.equals("addCondition")){
	  String type=Util.null2String(request.getParameter("type"));	
	  String content=Util.null2String(request.getParameter("value"));	
	  reportManager.addTempCondition(tempid,type,content); 	
	}else if(operation.equals("delCondition")){          //自定义报表人选择检查查看权限
	  String conditionid=Util.null2String(request.getParameter("conditionid"));	
	  reportManager.delTempCondition(conditionid);
	}else if(operation.equals("isCanView")){          //自定义报表人选择检查查看权限
		BlogShareManager shareManager=new BlogShareManager();
	    boolean isCanView=shareManager.isCanView(userid,attentionid);
	    out.println(isCanView);
	}
	
%>