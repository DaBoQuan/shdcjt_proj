<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="weaver.blog.BlogReportManager"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.blog.BlogManager"%>

<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%><jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo"></jsp:useBean>

<%
  String userid=""+user.getUID();
  Calendar calendar=Calendar.getInstance();
  int currentMonth=calendar.get(Calendar.MONTH)+1;
  int currentYear=calendar.get(Calendar.YEAR);
  String type=Util.null2String(request.getParameter("type"));
  int year=Util.getIntValue(request.getParameter("year"),currentYear);
  int month=Util.getIntValue(request.getParameter("month"),currentMonth);
  String monthStr=month<10?("0"+month):(""+month);
  
  BlogReportManager reportManager=new BlogReportManager();
  reportManager.setUser(user);
  Map resultMap=new HashMap();
  int allUnsubmit=0;
  int allWorkday=0;
  double allWorkIndex=0;
  if("blog".equals(type)){
	  resultMap=reportManager.getBlogAttentionReport(userid,year,month);
	  allUnsubmit=((Integer)resultMap.get("allUnsubmit")).intValue();      //����ע��δ�ύ����
	  allWorkday=((Integer)resultMap.get("allWorkday")).intValue();      //����ע��δ�ύ����
	  allWorkIndex=((Double)resultMap.get("allWorkIndex")).doubleValue();      //����ע��δ�ύ����
  }else if("mood".equals(type)){
	  resultMap=reportManager.getMoodAttentionReport(userid,year,month);
  }else{
	  out.println("�����ݿ���ʾ");
	  return;
  }
  List resultList=(List)resultMap.get("resultList");          //ͳ�ƽ��
  List totaldateList=(List)resultMap.get("totaldateList");          //�����ܵ�����
  int totalWorkday=((Integer)resultMap.get("totalWorkday")).intValue();    //���¹���������
  
  List isWorkdayList=(List)resultMap.get("isWorkdayList");    //��Ч����ͳ��list
  List resultCountList=(List)resultMap.get("resultCountList"); //��Ч����ͳ��list
  
  int total=resultList.size();
%>
	<div id="blogReportDiv" class="reportDiv" style="overflow-x: auto;width: 100%;">
	 <table id="reportList" style="width:100%;;border-collapse:collapse;margin-top: 3px;margin-bottom: 40px;"  border="1" cellspacing="0" bordercolor="#9db1ba" cellpadding="2" >
 	<tr style="background: url('images/report-head-bg.png');background-repeat: repeat-x;" height="20px">
	    <td style="width:80px;min-width: 80px" class="tdWidth"  nowrap="nowrap"> 
	      <div style="float: left;">
	           <input type="checkbox"  onclick="selectBox(this)" title="<%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%>"/>  <!-- ȫѡ -->
	       </div>
	       <div style="float: left;">
			   <a class="btnEcology" id="compareBtn"  href="javascript:void(0)" onclick="compareChart('blogReportDiv','<%=SystemEnv.getHtmlLabelName(26943,user.getLanguage())%>','<%=type %>')">
				 <div class="left" style="width:45px;color: #666"><span ><span style="font-size: 16px;font-weight: bolder;margin-right: 3px">+</span><%=SystemEnv.getHtmlLabelName(26962,user.getLanguage())%></span></div><!-- �Ա� -->
				 <div class="right"> &nbsp;</div>
			   </a>
		  </div>
	    </td>
	    <%
	      for(int i=0;i<totaldateList.size();i++){
	    	  int day=((Integer)totaldateList.get(i)).intValue();
	    	  if(i<isWorkdayList.size()){
	    		  boolean isWorkday=((Boolean)isWorkdayList.get(i)).booleanValue();
		    	  if(isWorkday){
		%>
		      <td class="tdWidth" nowrap="nowrap"><%=day%></td>
		<%    		  
		    	  }
	    	  }else{
	    %>
	          <td class="tdWidth" nowrap="nowrap"><%=day%></td>
	    <%}}%>
	    
	    <td style="width: 5%" align="center">
	    	<%if("blog".equals(type)) {%>
	    	<%=SystemEnv.getHtmlLabelName(26929,user.getLanguage())%><!-- ����ָ�� -->
	    	<%} else if("mood".equals(type)){%>
	    		<%=SystemEnv.getHtmlLabelName(26930,user.getLanguage())%><!-- ����ָ�� -->
	    	<%} else{%>
	    		<%=SystemEnv.getHtmlLabelName(26931,user.getLanguage())%><!-- ����ָ�� -->
	    	<%} %>
	    </td>
	</tr>
	<%
	  
	  if("blog".equals(type)){
		  for(int i=0;i<resultList.size();i++){
	    	  Map reportMap=(Map)resultList.get(i);
	    	  String attentionid=(String)reportMap.get("attentionid");
	    	  List reportList=(List)reportMap.get("reportList");
	    	  int totalUnsubmit=((Integer)reportMap.get("totalUnsubmit")).intValue();
	    	  double workIndex=((Double)reportMap.get("workIndex")).doubleValue();
	    	  
	  %>
	  <tr class="item1">
	     <td><input type="checkbox" conType="1" conValue="<%=attentionid%>" attentionid="<%=attentionid%>" class="condition" /><a href="viewBlog.jsp?blogid=<%=attentionid%>" target="_blank"><%=ResourceComInfo.getLastname(attentionid)%></a></td>
	  <%
	     for(int j=0;j<totaldateList.size();j++){
	       if(j<isWorkdayList.size()){	 
	         boolean isWorkday=((Boolean)isWorkdayList.get(j)).booleanValue();
	         boolean isSubmited=((Boolean)reportList.get(j)).booleanValue();
	  %> 
	       <%if(isWorkday){%>
		    <td align="center">
		       <%if(isSubmited){%>
		        <div><img src="images/submit-ok.png" /></div>
		       <%}else{ %>
		        <div><img src="images/submit-no.png" /></div> 
		       <%} %> 
		    </td>
		  <%}else{%>
	  <%}}else{%>
	        <td >&nbsp;</td>
	 <%}}%>
	    <td>
	     <a href="viewBlog.jsp?blogid=<%=attentionid%>" class="index" target="_blank"><span title="<%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%><%=totalUnsubmit%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26932,user.getLanguage())%><%=totalWorkday%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(workIndex)%></span></a><%=workIndex%><a href="javascript:openChart('blog','<%=attentionid%>',<%=year%>,'1','<%=ResourceComInfo.getLastname(attentionid)%><%=SystemEnv.getHtmlLabelName(26467,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')" style="text-decoration: none"><img src="images/chart.png" style="margin-left: 3px;border: 0px" align="absmiddle" /></a></td>
	 </tr>
	 <% }%>
	 <tr>
	    <td align="left"><%=SystemEnv.getHtmlLabelName(523,user.getLanguage())%></td><!-- �ܼ� -->
	<%
	  for(int i=0;i<totaldateList.size();i++){
		  if(i<isWorkdayList.size()){	 
		    boolean isWorkday=((Boolean)isWorkdayList.get(i)).booleanValue();
		    int unsubmit=((Integer)resultCountList.get(i)).intValue();
		    if(isWorkday){
	%>
	      <td align="center" style="width: 18px;"><span style="color:red"><%=unsubmit%></span>/<%=total%></td>
	<% 	    	
		    }else{
    %>
    <%		    	
		    }
	}else{
	%>
	      <td>&nbsp;</td>
	<%	
	}
	  }
	%>    
	    <td><span title="<%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%><%=allUnsubmit%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26932,user.getLanguage())%><%=allWorkday%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(allWorkIndex)%></span><%=allWorkIndex%></td>
	</tr>
	<%}else if("mood".equals(type)){
			for(int i=0;i<resultList.size();i++){
		    	  Map reportMap=(Map)resultList.get(i);
		    	  String attentionid=(String)reportMap.get("attentionid");
		    	  List reportList=(List)reportMap.get("reportList");
		    	  int totalUnsubmit=((Integer)reportMap.get("totalUnsubmit")).intValue();
	    		  double moodIndex=((Double)reportMap.get("moodIndex")).doubleValue();
	    		  int happyDays=((Integer)reportMap.get("happyDays")).intValue();
	    		    int unHappyDays=((Integer)reportMap.get("unHappyDays")).intValue();
	    		  %>
	    		  <tr class="item1">
	    		     <td><input type="checkbox" conType="1" conValue="<%=attentionid%>" class="condition" /><a href="viewBlog.jsp?blogid=<%=attentionid%>" class="index" target="_blank"><%=ResourceComInfo.getLastname(attentionid)%></a></td>
	    		  <%
	    		     for(int j=0;j<totaldateList.size();j++){
	    		       if(j<isWorkdayList.size()){	 
	    		         boolean isWorkday=((Boolean)isWorkdayList.get(j)).booleanValue();
	    		         String faceImg=(String)reportList.get(j);
	    		  			%> 
	    		       <%if(isWorkday){%>
	    			    <td align="center">
	    			       <%if("".equals(faceImg)){%>
	    			        &nbsp;
	    			       <%}else{ %>
	    			        <div><img src="<%=faceImg %>" /></div> 
	    			       <%} %> 
	    			    </td>
	    			  <%}else{%>
	    		  <%}}else{%>
	    		        <td >&nbsp;</td>
	    		 <%}}%>
	    		    <td>
	    		     <a href="viewBlog.jsp?blogid=<%=attentionid%>" class="index" target="_blank"><span title="<%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%><%=unHappyDays%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%><%=happyDays%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(moodIndex)%></span></a><%=moodIndex%><a href="javascript:openChart('mood','<%=attentionid%>',<%=year%>,'1','<%=ResourceComInfo.getLastname(attentionid)%><%=SystemEnv.getHtmlLabelName(26769 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')" style="text-decoration: none"><img src="images/chart.png" style="margin-left: 3px;border: 0px" align="absmiddle" /></a></td>
	    		 </tr>
	    		  
	    <%
	    	  }
		%>
		<tr>
	    <td align="left"><%=SystemEnv.getHtmlLabelName(523,user.getLanguage())%></td><!-- �ܼ� -->
	<%
	 for(int i=0;i<totaldateList.size();i++){
		  if(i<isWorkdayList.size()){	 
		    boolean isWorkday=((Boolean)isWorkdayList.get(i)).booleanValue();
		    int unHappy=((Integer)((HashMap)resultCountList.get(i)).get("unhappy")).intValue();
		    int happy=((Integer)((HashMap)resultCountList.get(i)).get("happy")).intValue();
		    if(isWorkday){
	%>
	      <td align="center" style="width: 18px;"><span style="color:red"><%=unHappy%></span>/<%=unHappy+happy%></td>
	<% 	    	
		    }else{
    %>
    <%		    	
		    }
	}else{
	%>
	      <td>&nbsp;</td>
	<%	
	}
	  }
	%>    
	    <td><span title="<%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%><%=resultMap.get("totalUnHappyDays") %><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%><%=resultMap.get("totalHappyDays") %><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(((Double)resultMap.get("totalMoodIndex")).doubleValue())%></span><%=resultMap.get("totalMoodIndex") %></td>
	</tr>
		<%} %>  
	  
	
	</table>
  </div>	
 
