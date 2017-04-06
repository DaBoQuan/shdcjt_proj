<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="weaver.blog.BlogReportManager"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo"></jsp:useBean>
<jsp:useBean id="appDao" class="weaver.blog.AppDao"></jsp:useBean>
<%
	
  Calendar calendar=Calendar.getInstance();
  int currentMonth=calendar.get(Calendar.MONTH)+1;
  int currentYear=calendar.get(Calendar.YEAR);
  
  int isSignInOrSignOut=Util.getIntValue(request.getParameter("isSignInOrSignOut"),0);
  
  String userid=Util.null2String(request.getParameter("userid")); //��Ҫ�鿴��΢��(�û�)id
  int year=Util.getIntValue(request.getParameter("year"),currentYear);
  int month=Util.getIntValue(request.getParameter("month"),currentMonth);
  String monthStr=month<10?("0"+month):(""+month);
  
  BlogReportManager reportManager=new BlogReportManager();
  reportManager.setUser(user);
  Map blogResultMap=reportManager.getBlogReportByUser(userid,year,month); 
  Map moodResultMap=reportManager.getMoodReportByUser(userid,year,month); 

  List reportList=(List)blogResultMap.get("reportList");
  List moodReportList=(List)moodResultMap.get("reportList");
  
  List totaldateList=(List)blogResultMap.get("totaldateList");          //�����ܵ�����
  int totalWorkday=((Integer)blogResultMap.get("totalWorkday")).intValue();    //���¹���������
  int totalUnsubmit=((Integer)blogResultMap.get("totalUnsubmit")).intValue();  //΢��δ�ύ����
  double workIndex=((Double)blogResultMap.get("workIndex")).doubleValue();        //����ָ��
  double moodIndex=((Double)moodResultMap.get("moodIndex")).doubleValue();    //����ָ��
  
%>
<table id="reportList" style="width:100%;;border-collapse:collapse;margin-top: 3px"  border="1" cellspacing="0" bordercolor="#9db1ba" cellpadding="2" >
	  <!-- ������  -->
	  <tr style="background: url('images/report-head-bg.png');background-repeat: repeat-x;" height="20px">
	    <td style="width:55px" nowrap="nowrap"></td>
	    <%
	      for(int i=0;i<totaldateList.size();i++){
	    	  int day=((Integer)totaldateList.get(i)).intValue();
	    	  if(i<reportList.size()){
	    		  Map map=(Map)reportList.get(i);
		    	  boolean isWorkday=((Boolean)map.get("isWorkday")).booleanValue();
		    	  if(isWorkday){
		%>
		      <td class="tdWidth" nowrap="nowrap"><%=day%></td>
		<%    		  
		    	  }
	    	  }else{
	    %>
	          <td class="tdWidth" nowrap="nowrap"><%=day%></td>
	    <%}}%>
	    <td style="width: 5%" align="center"><%=SystemEnv.getHtmlLabelName(26960,user.getLanguage())%></td><!-- ָ�� -->
	</tr>
	<!-- ������  -->
	
	<!-- ΢������  -->
	<tr class="item1">
	    <td><%=SystemEnv.getHtmlLabelName(26467,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></td> <!-- ΢������ -->
	    <%
	      for(int i=0;i<totaldateList.size();i++){
	    	if(i<reportList.size()){
	    	   Map map=(Map)reportList.get(i);
	    	   boolean isWorkday=((Boolean)map.get("isWorkday")).booleanValue();
	    	   boolean isSubmited=((Boolean)map.get("isSubmited")).booleanValue();
	    %>
	     <%if(isWorkday){%>
		    <td align="center" >
		       <%if(isSubmited){%>
		        <div><img src="images/submit-ok.png" /></div>
		       <%}else{ %>
		        <div><img src="images/submit-no.png" /></div> 
		       <%} %> 
		    </td>
		  <%}else{%>
		    
	    <%}}else{%>
	       <td >&nbsp;</td>
	    <%}
	    }%>
	    <td><span title="<%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%><%=totalUnsubmit%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26932,user.getLanguage())%><%=totalWorkday%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(workIndex)%></span><span style="font-weight: bold;margin-left: 3px;color: #666666"><%=workIndex%></span><a href="javascript:openChart('blog','<%=userid %>',<%=year%>,1,'<%=ResourceComInfo.getLastname(userid)%><%=SystemEnv.getHtmlLabelName(26467,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')" style="text-decoration: none"><img src="images/chart.png" style="margin-left: 3px;border: 0px" align="absmiddle" /></a></td>
		</tr>
		<!-- ΢������  -->
		<%if(appDao.getAppVoByType("mood").isActive()) {%>
	<tr class="item1">
	    <td><%=SystemEnv.getHtmlLabelName(26769 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></td><!-- ���鱨�� -->
	    
	    <%
	    int happyDays=((Integer)moodResultMap.get("happyDays")).intValue();
	    int unHappyDays=((Integer)moodResultMap.get("unHappyDays")).intValue();
	    for(int i=0;i<totaldateList.size();i++){ 
	    	if(i<reportList.size()){
	    	   Map map=(Map)moodReportList.get(i);
	    	   boolean isWorkday=((Boolean)map.get("isWorkday")).booleanValue();
	    	   boolean isSubmited=((Boolean)map.get("isSubmited")).booleanValue();
	    	   String faceImg=(String)map.get("faceImg");
	    	   if(isWorkday){
	    	   %>
	    		<td align="center"">
	    			 <%if(isSubmited&&!"".equals(faceImg)){%>
			        	<div><img src="<%=faceImg %>" /></div>
			       	<%}else{ %>
			        	
			       	<%} %> 
	    		</td>
	    		<%}else{ %>
	    		
	    		<%}}else{ %>
	    		<td>&nbsp;</td>
	    		<%} %>
	    	
	    <%} %>
	    
	    <td><span title="<%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%><%=unHappyDays%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%><%=happyDays%><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>"><%=reportManager.getReportIndexStar(moodIndex)%></span><span style="font-weight: bold;margin-left: 3px;color: #666666"><%=moodIndex%></span><a href="javascript:openChart('mood','<%=userid%>',<%=year%>,1,'<%=ResourceComInfo.getLastname(userid)%><%=SystemEnv.getHtmlLabelName(26769 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')" style="text-decoration: none"><img src="images/chart.png" style="margin-left: 3px;border: 0px" align="absmiddle" /></a></td>
	 </tr>
	 <%} 
	  if(isSignInOrSignOut==1){
		  Map schedulrResultMap=reportManager.getScheduleReportByUser(userid,year,month); 
		  List scheduleReportList=(List)schedulrResultMap.get("reportList"); 
		  double scheduleIndex=((Double)schedulrResultMap.get("scheduleIndex")).doubleValue();    //����ָ��
		  int totalAbsent=((Integer)schedulrResultMap.get("totalAbsent")).intValue();        //����������
		  int totalLate=((Integer)schedulrResultMap.get("totalLate")).intValue();            //�ٵ�������
	 %>
	<tr class="item1">
	    <td><%=SystemEnv.getHtmlLabelName(15880 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></td><!-- ���ڱ��� -->
	    <%for(int i=0;i<totaldateList.size();i++){ 
	    	if(i<reportList.size()){
	    	   Map map=(Map)scheduleReportList.get(i);
	    	   boolean isWorkday=((Boolean)map.get("isWorkday")).booleanValue();
	    	   boolean isLate=((Boolean)map.get("isLate")).booleanValue();
	    	   boolean isAbsent=((Boolean)map.get("isAbsent")).booleanValue();
	    	   if(isWorkday){
	    	   %>
	    		<td align="center">
	    			 <%if(isLate){%>
			        	<div><img width="18px" src="images/sign-no.png"/></div>
			       	<%}else if(isAbsent){ %>
			        	<div><img width="18px"  src="images/sign-absent.png"/></div>
			       	<%}else { %> 
			       	    <div><img width="18px"  src="images/sign-ok.png" /></div>
			       	<%} %>
	    		</td>
	    		<%}else{ %>
	    		
	    		<%}}else{ %>
	    		<td>&nbsp;</td>
	    		<%} %>
	    	
	    <%} %>
	    <td><span title="<%=SystemEnv.getHtmlLabelName(20085,user.getLanguage())%><%=totalAbsent%><%=SystemEnv.getHtmlLabelName(18083,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20081,user.getLanguage())%><%=totalLate %><%=SystemEnv.getHtmlLabelName(18083,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%><%=totalWorkday%><%=SystemEnv.getHtmlLabelName(20079,user.getLanguage())%>"><%=reportManager.getReportIndexStar(scheduleIndex)%></span><span style="font-weight: bold;margin-left: 3px;color: #666666"><%=scheduleIndex%></span><a href="javascript:openChart('schedule','<%=userid%>',<%=year%>,1,'<%=ResourceComInfo.getLastname(userid)%><%=SystemEnv.getHtmlLabelName(15880 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')" style="text-decoration: none"><img src="images/chart.png" style="margin-left: 3px;border: 0px" align="absmiddle" /></a></td>
	</tr>
	<%} %>
 </table> 

