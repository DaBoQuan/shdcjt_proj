<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogDao"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@page import="weaver.blog.WorkDayDao"%>
<%@page import="weaver.blog.BlogReportManager"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.blog.BlogManager"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo"></jsp:useBean>
<jsp:useBean id="appDao" class="weaver.blog.AppDao"></jsp:useBean>
<html>
<head>
<script type='text/javascript' src='js/timeline/lavalamp.min.js'></script>
<script type='text/javascript' src='js/timeline/easing.js'></script>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="css/blog.css" type=text/css rel=STYLESHEET>
<link href="js/timeline/lavalamp.css" rel="stylesheet" type="text/css"> 
<script type='text/javascript' src='js/blogUtil.js'></script>
<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
</head>
<%
String userid=""+user.getUID();
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

BlogManager blogManager=new BlogManager(user);
List attentionList=blogManager.getMyAttention(userid);

%>
<body>
<div id="divTopMenu"></div>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
   <%
     RCMenu += "{"+SystemEnv.getHtmlLabelName(26962,user.getLanguage())+",javascript:doCompare(),_self} ";
	 RCMenuHeight += RCMenuHeightStep ;
   %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%if(attentionList.size()>0){ %>
<div style="width:100%;">
  <div align="center" id="reportTitle" class="reportTitle" style="display: <%=!"other".equals(from)?"block":"none"%>"><%=year+"-"+monthStr%> <%=SystemEnv.getHtmlLabelName(26943,user.getLanguage())%></div><!-- ��ע���� -->
  <div style="margin-top: 3px;margin-bottom: 15px">
       <div class="lavaLampHead">
             <div style="width: 80%;float: left;">
					<ul class="lavaLamp" id="timeContent">
					  <%for(int i=startMonth;i<=endMonth;i++){ 
					      monthStr=i<10?("0"+i):("")+i;
					  %>
					     <li <%=i==month?"class='current'":""%>><a href="javascript:changeMonth(<%=year%>,<%=i%>,'<%=monthStr%>','<%=SystemEnv.getHtmlLabelName(26943,user.getLanguage())%>')"><%=i%><%=SystemEnv.getHtmlLabelName(6076,user.getLanguage())%></a></li><!-- �� -->
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
    
	<div align="left" style="margin-top: 8px">
	  <div style="float: left;" class="reportTab">
	  <!-- �������� -->
		  <%=SystemEnv.getHtmlLabelName(22375,user.getLanguage())%>��
		  <a href="#" onclick="changeReport(this,'blog')" style="margin-right: 8px;" class="items"><%=SystemEnv.getHtmlLabelName(26467,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></a><!-- ΢������ -->
		  <%if(appDao.getAppVoByType("mood").isActive()){ %>
		  <a href="#" onclick="changeReport(this,'mood')" style="margin-right: 8px;"><%=SystemEnv.getHtmlLabelName(26769 ,user.getLanguage())+SystemEnv.getHtmlLabelName(15101,user.getLanguage())%></a><!-- ���鱨�� -->
		  <%} %>
	  </div>
	  <div style="float: right;">
	     <div class="remarkDiv" style="text-align: left;" id="blogRemarks">
	         <span style="margin-right: 8px"><img src="images/submit-no.png" align="absmiddle" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%></span>
	         <span  style="margin-right: 8px"><img src="images/submit-ok.png" align="absmiddle" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(15176,user.getLanguage())%></span>
	         <span  style="margin-right: 8px">"<%=SystemEnv.getHtmlLabelName(523 ,user.getLanguage())%>"<%=SystemEnv.getHtmlLabelName(15191,user.getLanguage())%>"<font color="red"><%=SystemEnv.getHtmlLabelName(15178 ,user.getLanguage())+SystemEnv.getHtmlLabelName(355,user.getLanguage())%></font>/<%=SystemEnv.getHtmlLabelName(26932 ,user.getLanguage())+SystemEnv.getHtmlLabelName(355,user.getLanguage())%>"</span>  
	     </div>
	     
	    <div class="remarkDiv" style="text-align: left;display: none;" id="moodRemarks">
	          <span  style="margin-right: 8px"><img src="images/mood-unhappy.png" align="absmiddle" width="16px" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(26918,user.getLanguage())%></span>
	          <span  style="margin-right: 8px"><img src="images/mood-happy.png" align="absmiddle" width="16px" style="margin-right: 5px" /><%=SystemEnv.getHtmlLabelName(26917,user.getLanguage())%></span>
	          <span  style="margin-right: 8px">"<%=SystemEnv.getHtmlLabelName(523 ,user.getLanguage())%>"<%=SystemEnv.getHtmlLabelName(15191,user.getLanguage())%>"<font color="red"><%=SystemEnv.getHtmlLabelName(26918 ,user.getLanguage())+SystemEnv.getHtmlLabelName(852,user.getLanguage())%></font>/<%=SystemEnv.getHtmlLabelName(852,user.getLanguage())%>"</span>
	    </div>
	  </div>
	</div>
    
    <div id="reportDiv">
    
    </div>
    <br>
    <br>
</div>
<%}else
	out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(26963 ,user.getLanguage())+"</div>");	//��ǰû�б���ע����
%>	
<script type="text/javascript">
   var type="blog";
   jQuery(document).ready(function(){
    if(<%=attentionList.size()%>>0) {  
	     window.parent.displayLoading(1,"data");
	     jQuery("#reportDiv").load("attentionReportRecord.jsp?year=<%=year%>&month=<%=month%>&type=blog",function(){
	        window.parent.displayLoading(0);
	     });
	     jQuery(function(){jQuery(".lavaLamp").lavaLamp({ fx: "backout", speed: 700 })});
     }else
        window.parent.displayLoading(0); 
  });
  
   function selectBox(obj){
    if(jQuery(obj).attr("checked")){
       jQuery(".condition").attr("checked",true);
    }else{
       jQuery(".condition").attr("checked",false);
    }
  }
  
 function changeMonth(year,month,monthstr,title){
    window.parent.displayLoading(1,"data");
    jQuery("#reportDiv").load("attentionReportRecord.jsp?year="+year+"&month="+month+"&type="+type,function(){
       window.parent.displayLoading(0);
    });
    jQuery("#reportTitle").html(year+"-"+monthstr+" "+title);
    
    compareYear=year;
    compareMonth=month;
  }
  
  function changeYear(){
    window.parent.displayLoading(1,"page");
    var year=jQuery("#yearSelect").val();
    window.location.href="attentionReport.jsp?year="+year;
  } 
  
  function changeReport(obj,typeTemp){
	type=typeTemp;
	window.parent.displayLoading(1,"data");
	jQuery("#reportDiv").load("attentionReportRecord.jsp?year="+compareYear+"&month="+compareMonth+"&type="+type+"",function(){
	   window.parent.displayLoading(0);
	});
	   jQuery(".reportTab a").removeClass("items");
	   jQuery(obj).addClass("items");
	   jQuery(".reportDiv").hide();
	   jQuery("#"+type+"ReportDiv").show();
	   jQuery(".remarkDiv").hide();
	   jQuery("#"+type+"Remarks").show();
  }
  var compareYear=<%=year%>;
  var compareMonth=<%=month%>;
  
  function compareChart(reportdiv,title,charType){
   var conType="";    
   var conValue="";
   var conditions=jQuery("#"+reportdiv).find(".condition:checked"); 
   if(conditions.length==0){
      alert("<%=SystemEnv.getHtmlLabelName(25763 ,user.getLanguage())%>"); //�Բ�����ѡ����Ա!
      return ;
   }
   conditions.each(function(){
      conType=conType+","+jQuery(this).attr("conType");
      conValue=conValue+","+jQuery(this).attr("conValue");
   });
   conType=conType.substr(1);
   conValue=conValue.substr(1);
   
    var diag = new Dialog();
    diag.Modal = true;
    diag.Drag=false;
	diag.Width = 680;
	diag.Height = 425;
	diag.ShowButtonRow=false;
	diag.Title =title;
	diag.URL = "compareChart.jsp?title="+title+"&conValue="+conValue+"&conType="+conType+"&year="+compareYear+"&month="+compareMonth+"&chartType="+charType;
    diag.show();
  }

//�Ա�
function doCompare(){
   jQuery("#compareBtn").click();
}
  
</script>	
</body>
</html>