<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.general.GCONST"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="weaver.blog.BlogReportManager"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.blog.BlogManager"%>
<jsp:useBean id="appDao" class="weaver.blog.AppDao"></jsp:useBean>
<%
  String userid=Util.null2String(request.getParameter("userid")); //��Ҫ�鿴��΢��(�û�)id
  String from=Util.null2String(request.getParameter("from"));
  String type=Util.null2String(request.getParameter("type"));
  
  Calendar calendar=Calendar.getInstance();
  int currentMonth=calendar.get(Calendar.MONTH)+1;
  int currentYear=calendar.get(Calendar.YEAR);
  
  int year=Util.getIntValue(request.getParameter("year"),currentYear);
  
  BlogDao blogDao=new BlogDao();
  Map monthMap=blogDao.getCompaerMonth(year);
  int startMonth=((Integer)monthMap.get("startMonth")).intValue();   //��ʼ�·�
  int endMonth=((Integer)monthMap.get("endMonth")).intValue();       //�����·�
  
  Map enbaleDate=blogDao.getEnableDate();
  int enableYear=((Integer)enbaleDate.get("year")).intValue();      //΢����ʼʹ����
  
  int month=Util.getIntValue(request.getParameter("month"),endMonth);
  String monthStr=month<10?("0"+month):(""+month);
  
  String isSignInOrSignOut=Util.null2String(GCONST.getIsSignInOrSignOut());//�Ƿ�����ǰ��ǩ�˹���
%>

<div style="width:100%;position: relative;" >
  <div align="center" id="reportTitle" style="margin-top: 8px;font-weight: bold;font-size: 15px;color: #123885;"><%=year+"-"+monthStr%> <%=SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></div><!-- �ҵı��� -->
  <div style="margin-top: 3px;margin-bottom: 15px;">
         <div class="lavaLampHead" style="height: 29px">
             <div style="width: 80%;float: left;">
					<ul class="lavaLamp" id="timeContent">
					  <%for(int i=startMonth;i<=endMonth;i++){ 
					      monthStr=i<10?("0"+i):("")+i;
					  %>
					     <li <%=i==month?"class='current'":""%>><a href="javascript:changeMonth(<%=year%>,<%=i%>,'<%=monthStr%>','<%=SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>')"><%=i%><%=SystemEnv.getHtmlLabelName(6076,user.getLanguage())%></a></li><!-- �� -->
					  <%}%>
					</ul>
			  </div>	
			  <div class="report_yearselect" align="right">
			     <select class="yearSelect" id="yearSelect" onchange="changeYear()">
			         <%
					   for(int i=currentYear;i>=enableYear;i--){ 
					 %>
					   <option value="<%=i%>" <%=i==year?"selected='selected'":""%>><%=i%><%=SystemEnv.getHtmlLabelName(445,user.getLanguage())%></option><!-- �� -->
				    <%} %>
			     </select>
			  </div>	
         </div>
    </div>
    <div style="width:100%;overflow-x: auto;padding-bottom: 30px;">
		<div id="blogReportDiv"> 
		 
		</div>
		<div style="text-align: left;margin-top: 8px">
	          <%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%>��<span style="margin-right: 8px"><img src="images/submit-no.png" align="absmiddle" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%></span><!-- ˵��  δ�ύ-->
	          <span  style="margin-right: 8px"><img src="images/submit-ok.png" align="absmiddle" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(15176,user.getLanguage())%></span><!-- ���ύ -->
	          <%if(appDao.getAppVoByType("mood").isActive()){ %>
		          <span  style="margin-right: 8px"><img src="images/mood-unhappy.png" align="absmiddle" width="16px" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%></span><!--������-->
		          <span  style="margin-right: 8px"><img src="images/mood-happy.png" align="absmiddle" width="16px" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%></span><!-- ����-->
	          <%}else{%>
	          <%}%>
		       <%if(isSignInOrSignOut.equals("1")){ %> 
			      <span style="margin-right: 8px;"><img src="images/sign-absent.png" width="18px" w align="absmiddle" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(20085,user.getLanguage())%></span><!-- ���� -->
			      <span style="margin-right: 8px;"><img src="images/sign-no.png" align="absmiddle" width="18px"  style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(20081,user.getLanguage())%></span><!-- �ٵ� -->
			      <span style="margin-right: 8px;"><img src="images/sign-ok.png" align="absmiddle" width="18px" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%></span><!-- ���� -->
		       <%} %>
	     </div>  
	</div>
</div>		
<script type="text/javascript">
  jQuery(document).ready(function(){ 
     displayLoading(1,'page');  
     jQuery.post("myReportRecord.jsp?userid=<%=userid%>&year=<%=year%>&month=<%=month%>&isSignInOrSignOut=<%=isSignInOrSignOut%>",function(data){
        jQuery("#blogReportDiv").html(data);
        displayLoading(0);  
     });
     jQuery(function(){jQuery(".lavaLamp").lavaLamp({ fx: "backout", speed: 700 })});
  });
  
  function changeMonth(year,month,monthstr,title){
     displayLoading(1,'data');  
     jQuery("#blogReportDiv").load("myReportRecord.jsp?userid=<%=userid%>&isSignInOrSignOut=<%=isSignInOrSignOut%>&year="+year+"&month="+month,function(){
     displayLoading(0); 
    });
    jQuery("#reportTitle").html(year+"-"+monthstr+" "+title);
  }
 
  function changeYear(){
    var year=jQuery("#yearSelect").val();
    jQuery.post("myBlogReport.jsp?from=other&userid=<%=userid%>&year="+year,function(a){
       jQuery("#reportBody").html(a.replace(/<link.*?>.*?/, ''));
    });
    jQuery(function(){jQuery(".lavaLamp").lavaLamp({ fx: "backout", speed: 700 })});
  }   
</script>	
