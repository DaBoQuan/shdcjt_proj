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
	String attentionid=Util.null2String(fu.getParameter("attentionid"));   //��ע��id
	String islower=Util.null2String(fu.getParameter("islower"));           //�Ƿ�Ϊ��ǰ�û�����
	String tempid=Util.null2String(request.getParameter("tempid"));  //����ģ��id
	BlogReportManager reportManager=new BlogReportManager();
	/*��ע����*/
	if(operation.equals("addAttention")){                 //��ӹ�ע
	    blogManager.addAttention(userid,attentionid,islower);
	    blogDao.addRemind(attentionid,userid,"5","","0");  //��ע�ҵ�+1����
	}else if(operation.equals("cancelAttention")){       //ȡ����ע
		blogManager.cancelAttention(userid,attentionid,islower);
	}else if(operation.equals("requestAttention")){     //�����ע
		blogManager.requestAttention(userid,attentionid,islower);
	}else if(operation.equals("dealRequest")){
		String requestid=Util.null2String(fu.getParameter("requestid"));
		String sender=Util.null2String(fu.getParameter("sender"));
		String status=Util.null2String(fu.getParameter("status"));
		blogManager.dealRequest(userid,sender,requestid,status);
		if(status.equals("1")){        //ͬ��
		   blogDao.addRemind(sender,userid,"2","","0");  //����ɹ�����
		}else if(status.equals("-1"))  //�ܾ�
		   blogDao.addRemind(sender,userid,"3","","0");	//����ʧ������
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
	}else if(operation.equals("unsubmitRemind")){     //δ�ύ����
		String remindid=Util.null2String(fu.getParameter("remindid"));
		String relatedid=Util.null2String(fu.getParameter("discussant"));
		String remindValue=Util.null2String(fu.getParameter("workdate"));
		String sql="select id from blog_remind where remindid="+remindid+" and relatedid="+relatedid+" and remindType=7 and remindValue='"+remindValue+"'";
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
		if(!recordSet.next())
		   blogDao.addRemind(remindid,relatedid,"7",remindValue,"0");	//����ʧ������
	}else if(operation.equals("signCheck")){         //ǩ�� ǩ�˼��΢���Ƿ��ύ
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String status=blogDao.getBlogStatus();       //΢������״̬
		Date enabledate=dateFormat.parse(blogDao.getSysSetting("enableDate")); //΢������ʱ��
		Date currentdate=dateFormat.parse(dateFormat.format(new Date()));      //��ǰ����
		String isSignRemind=blogDao.getSysSetting("isSingRemind");    //�Ƿ�����ǩ������
		String checkday=Util.null2String(fu.getParameter("checkday"));//����ʱ�Ĺ���΢��
		
		boolean todayHasBlog=true;         //�����Ƿ��ύ����΢����
		boolean prevWorkDayHasBlog=true;   //��һ���������Ƿ��ύ����΢��
		
		if(status.equals("1")&&isSignRemind.equals("1")&&currentdate.getTime()>=enabledate.getTime()){
			SimpleDateFormat frm=new SimpleDateFormat("yyyy-MM-dd");
		    if(checkday.equals("today"))       //ǩ��ʱ������
			   todayHasBlog=blogDao.chkDiscussExits(userid,frm.format(new Date()));
		    if(checkday.equals("prevWorkDay")){//ǩ��ʱ�����һ��������
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
	}else if(operation.equals("markCommentRead")){ //�������Ϊ�Ѷ�
		String sql="delete from blog_remind where remindType=9 and remindid="+userid; 
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("delUpdateRemind")){ //ɾ����������
		String sql="delete from blog_remind where remindType=6 and remindid="+userid;
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("managerScore")){     //�ϼ�����
		String discussid=Util.null2String(fu.getParameter("discussid"));
		String score=Util.null2String(fu.getParameter("score"));
		
		String sql="update blog_discuss set score='"+score+"' where id="+discussid;
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
	}else if(operation.equals("getHomepageTotal")){    //��ȡ��ҳ��¼����
		List attentionList=blogManager.getMyAttention(userid);
		String attentionids=userid;                                 //�����ҹ�ע���˼���,��������
		for(int i=0;i<attentionList.size();i++){
			attentionids=attentionids+","+attentionList.get(i);
		}
		int total=blogDao.getBlogDiscussCount(attentionids);
		out.println(total);
	}else if(operation.equals("readDiscuss")){    //ɾ���������� �� ��ӷ��ʼ�¼  �Ķ���¼
		String discussid=Util.null2String(fu.getParameter("discussid"));
		String blogid=Util.null2String(fu.getParameter("blogid"));
		String sql="delete from blog_remind where remindType=6 and remindid="+userid+" and remindValue='"+discussid+"'";
		RecordSet recordSet=new RecordSet();
		recordSet.execute(sql);
		blogDao.addReadRecord(userid,blogid);  //����Ѷ���¼
	    blogDao.addVisitRecord(userid,blogid); //��ӷ��ʼ�¼
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
		//����ָ��
		Map workMap=new HashMap();
		Map resultMap = reportManager.getBlogReportByUser(blogid,currentYear, currentMonth);
		int totalWorkday = ((Integer) resultMap.get("totalWorkday")).intValue(); //���¹���������
		int totalUnsubmit = ((Integer) resultMap.get("totalUnsubmit")).intValue(); //΢��δ�ύ����
		double workIndex = ((Double) resultMap.get("workIndex")).doubleValue(); //����ָ��

		workMap.put("workIndex",""+resultMap.get("workIndex"));
		workMap.put("workIndexTitle",SystemEnv.getHtmlLabelName(15178,user.getLanguage())+totalUnsubmit+SystemEnv.getHtmlLabelName(1925,user.getLanguage())+SystemEnv.getHtmlLabelName(26932,user.getLanguage())+totalWorkday+SystemEnv.getHtmlLabelName(1925,user.getLanguage()));
		workMap.put("workIndexStar",reportManager.getReportIndexStar(workIndex));
		index.put("work",workMap);
		
		//����ָ��
		AppDao appDao = new AppDao();
		if(appDao.getAppVoByType("mood").isActive()){ 
			Map moodMap=new HashMap();
			Map moodResultMap = reportManager.getMoodReportByUser(blogid,currentYear, currentMonth);
			int happyDays = ((Integer) moodResultMap.get("happyDays")).intValue();
			int unHappyDays = ((Integer) moodResultMap.get("unHappyDays")).intValue();
			double moodIndex = ((Double) moodResultMap.get("moodIndex")).doubleValue(); //����ָ��
			
			moodMap.put("moodIndex",""+moodResultMap.get("moodIndex"));
			moodMap.put("moodIndexTitle",SystemEnv.getHtmlLabelName(26918,user.getLanguage())+unHappyDays+SystemEnv.getHtmlLabelName(1925,user.getLanguage())+SystemEnv.getHtmlLabelName(26917,user.getLanguage())+happyDays+SystemEnv.getHtmlLabelName(1925,user.getLanguage()));
			moodMap.put("moodIndexStar",reportManager.getReportIndexStar(moodIndex));
			index.put("mood",moodMap);
		}
		//����ָ��
		String isSignInOrSignOut=Util.null2String(GCONST.getIsSignInOrSignOut());
		if(isSignInOrSignOut.equals("1")){
		   Map scheduleMap=new HashMap();	
		   Map schedulrResultMap=reportManager.getScheduleReportByUser(blogid,currentYear,currentMonth); 
		   double scheduleIndex=((Double)schedulrResultMap.get("scheduleIndex")).doubleValue();    //����ָ��
		   int totalAbsent=((Integer)schedulrResultMap.get("totalAbsent")).intValue();          //����������
		   int totalLate=((Integer)schedulrResultMap.get("totalLate")).intValue();              //�ٵ�������
		   
		   scheduleMap.put("scheduleIndex",""+schedulrResultMap.get("scheduleIndex"));
		   scheduleMap.put("scheduleIndexTitle",SystemEnv.getHtmlLabelName(20085,user.getLanguage())+totalAbsent+SystemEnv.getHtmlLabelName(18083,user.getLanguage())+SystemEnv.getHtmlLabelName(20081,user.getLanguage())+totalLate+SystemEnv.getHtmlLabelName(18083,user.getLanguage())+SystemEnv.getHtmlLabelName(18609,user.getLanguage())+totalWorkday+SystemEnv.getHtmlLabelName(20079,user.getLanguage()));
		   scheduleMap.put("scheduleIndexStar",reportManager.getReportIndexStar(scheduleIndex));
		   
		   index.put("schedule",scheduleMap);
		} 
		JSONObject json=JSONObject.fromObject(index);
		out.println(json);
	}else if(operation.equals("getMyAttentionCount")){ //��ȡ�ҹ�ע��������
		int total=blogDao.getMyAttentionCount(userid);
		out.println(total);
	}else if(operation.equals("saveNotepad")){ //������±�����
	    String content=Util.null2String(request.getParameter("content")); //���±�����
		String saveType=Util.null2String(fu.getParameter("saveType"));//��������
		blogDao.saveNotes(userid,content,saveType); //��������
	}
	
	/*�Զ��屨��*/
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
	}else if(operation.equals("delCondition")){          //�Զ��屨����ѡ����鿴Ȩ��
	  String conditionid=Util.null2String(request.getParameter("conditionid"));	
	  reportManager.delTempCondition(conditionid);
	}else if(operation.equals("isCanView")){          //�Զ��屨����ѡ����鿴Ȩ��
		BlogShareManager shareManager=new BlogShareManager();
	    boolean isCanView=shareManager.isCanView(userid,attentionid);
	    out.println(isCanView);
	}
	
%>