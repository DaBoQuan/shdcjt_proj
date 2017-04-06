<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.blog.BlogDao"%><html>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
<head>
<title><%=SystemEnv.getHtmlLabelName(26469,user.getLanguage())%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript">var languageid=<%=user.getLanguage()%>;</script>
<script type="text/javascript" src="/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="/kindeditor/kindeditor-Lang.js"></script> 
<script type='text/javascript' src='js/highlight/jquery.highlight.js'></script>
<link rel=stylesheet href="/css/Weaver.css" type="text/css" />
<link href="js/weaverImgZoom/weaverImgZoom.css" rel="stylesheet" type="text/css">
<script src="js/weaverImgZoom/weaverImgZoom.js"></script>

<script type="text/javascript" src="js/raty/js/jquery.raty.js"></script>

<!-- ΢����ǩ -->
<script type="text/javascript" src="/blog/js/notepad/notepad.js"></script>

<link rel="stylesheet"  href="css/blog.css">
<jsp:include page="blogUitl.jsp"></jsp:include>
<style>
  .reportItem .reportContent p{margin:0px}
</style>
<%
	String userid=""+user.getUID();
    String blogType = Util.null2String(request.getParameter("blogType"));
    String name = Util.null2String(request.getParameter("name"));
    String startDate=Util.null2String(request.getParameter("startDate"));
    String endDate=Util.null2String(request.getParameter("endDate"));
    BlogManager blogManager=new BlogManager(user);
    SimpleDateFormat datefrm=new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat frmYYR=new SimpleDateFormat("M��dd��");  
    SimpleDateFormat dayFormater=new SimpleDateFormat("dd");
    SimpleDateFormat yearMonthFormater=new SimpleDateFormat("yyyy-MM");

    BlogDao blogDao=new BlogDao();
    
    if("".equals(startDate)){
    	Date startDateTem=new Date();
        startDateTem.setDate(startDateTem.getDate()-30);
    	startDate=datefrm.format(startDateTem);
    }
    if("".equals(endDate)||datefrm.parse(endDate).getTime()>new Date().getTime())
    	endDate=datefrm.format(new Date());
    String enableDate=blogDao.getSysSetting("enableDate");
    if(datefrm.parse(enableDate).getTime()>datefrm.parse(startDate).getTime()){
    	startDate=enableDate;
    }
    List list = blogManager.getAttentionDiscussCount(""+user.getUID(),startDate,endDate);
    Iterator itr=list.iterator();
    Date today=new Date();
    //���� ��һ �ܶ� ���� ���� ���� ���� 
    String []week={SystemEnv.getHtmlLabelName(16106,user.getLanguage()),SystemEnv.getHtmlLabelName(16100,user.getLanguage()),SystemEnv.getHtmlLabelName(16101,user.getLanguage()),SystemEnv.getHtmlLabelName(16102,user.getLanguage()),SystemEnv.getHtmlLabelName(16103,user.getLanguage()),SystemEnv.getHtmlLabelName(16104,user.getLanguage()),SystemEnv.getHtmlLabelName(16105,user.getLanguage())}; 
	
%>
</head>
<body>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
 <div>
	 <DIV id=bg></DIV>
	 <div id="loading">
			<div style=" position: absolute;top: 35%;left: 25%" align="center">
			    <img src="/images/loading2.gif" style="vertical-align: middle"><label id="loadingMsg"><%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%></label>
			</div>
	 </div>
 </div>
<iframe id="downloadFrame" style="display: none"></iframe>
<div id="myBlogdiv" style="height: 100%;width:98%;margin-left:10px">
      <div style="height:30px;line-height:30px;margin-top:0px" class="TopTitle">
	   <div class="topNav" style="float: left;margin-right:10px">
			<ul>
				<li class="selected"><a href="myAttention.jsp"><%=SystemEnv.getHtmlLabelName(26469,user.getLanguage())%></a></li><!-- �ҵĹ�ע -->
			</ul>
		</div>
		<span style="float: right;margin-top: 5px;margin-right: 5px" >
		    <button title="<%=SystemEnv.getHtmlLabelName(18753,user.getLanguage())%>" style="vertical-align: top" class="btnFavorite" id="BacoAddFavorite" onclick="openFavouriteBrowser()" type="button"></button><!-- �����ղؼ� -->
	        <button title="����" style="margin-left:5px;vertical-align: top" class="btnHelp" id="btnHelp" onclick="alert('����');" type="button"></button><!-- ����-->
		</span>
		
		<div id="searchDiv"  align="right" style="display: block;float: right;margin-top: 4px;">
			<table  cellpadding=0 cellspacing=0>
			<tr>
				<td>
				     <INPUT id=startdate name=startdate type=hidden value="<%=startDate%>">
					 <INPUT id=startdate_ name=startdate_ type=hidden value="<%=startDate%>">
					 <BUTTON class=Calendar onclick="getDate('startdatespan','startdate')"></BUTTON>
					 <SPAN id="startdatespan"><%=startDate%></SPAN>
					 	<%=SystemEnv.getHtmlLabelName(15322,user.getLanguage())%>&nbsp;<!-- �� -->
					 <BUTTON class=Calendar onclick="getDate('enddatespan','enddate')"></BUTTON> 
					 <SPAN id=enddatespan><%=endDate%></SPAN>&nbsp;
					 <INPUT id=enddate name=enddate type=hidden value="<%=endDate%>">
					 <INPUT id=enddate_ name=enddate_ type=hidden value="<%=endDate%>">
					<span>&nbsp;</span>
				</td>
				<td align="right">
	                <div class="searchBox">
	                <input id="content" class="searchInput" onkeydown="if(event.keyCode==13) jQuery('#searchBtn').click();"/>
	                <div class="searchBtn" id="searchBtn" from="gz" onclick="search('content','startdate','enddate',this)"></div>
	                </div>
				</td>
			</tr>
		</table>
		</div>
	</div>	
	<div class="clear"></div>
	
	<div id="reportBody"  style="width: 99%">
		<%
		 if(list.size()>0){
		  for(int i=list.size()-1;i>=0; i--){
			HashMap titleInfoMap=(HashMap)list.get(i);
			int unsubmit=((Integer)titleInfoMap.get("unsubmit")).intValue();
			int submited=((Integer)titleInfoMap.get("submited")).intValue();
		%>
		<div class="attentionStateBody">
			<div class="attentionStateTitle" onclick="hideDetail('#details_<%=titleInfoMap.get("workdate") %>',this,'<%=titleInfoMap.get("workdate") %>');">
				<div class="sortInfo" >
					<span class="date" style="width:75px;display: inline;"><%=frmYYR.format(datefrm.parse((String)titleInfoMap.get("workdate")))%></span><span class="date"><%=week[datefrm.parse((String)titleInfoMap.get("workdate")).getDay()] %> </span>&nbsp;&nbsp; 
					<%if(unsubmit>0){%>
					 <span > <font color="red"><%=titleInfoMap.get("unsubmit") %><%=SystemEnv.getHtmlLabelName(127,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15178,user.getLanguage())%></font></span>
					<%} %>
				</div><!-- ���ύ δ�ύ -->
				<div class="coBar coBarClose" style="padding-top: 2px;margin-top:8px"><div style="margin-left: 28px"><%=SystemEnv.getHtmlLabelName(15315,user.getLanguage())%></div></div><!-- ���� -->
			</div>
			<div id="details_<%=titleInfoMap.get("workdate") %>" forDate="<%=titleInfoMap.get("workdate") %>"  class="details" style="position: relative;"> </div>
		</div>
		<%}}else
			out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(22521,user.getLanguage())+"</div>");
		%>
	</div>
</div>
</body>
</html>
<script>

//�ύ�ظ�ʱ���ύ�ȴ�
function displayLoading(state,flag){
  if(state==1){
        //���մ�
        var bgHeight=document.body.scrollHeight; 
        var bgWidth=window.parent.document.body.offsetWidth;
        jQuery("#bg").css("height",bgHeight,"width",bgWidth);
        jQuery("#bg").show();
        
        if(flag=="save")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%>");   //���ڱ��棬���Ե�...
        else if(flag=="page")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%>");   //ҳ������У����Ժ�...
        else if(flag=="data")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");   //���ڻ�ȡ����,���Ե�...  
              
        //��ʾloading
	    var loadingHeight=jQuery("#loading").height();
	    var loadingWidth=jQuery("#loading").width();
	    jQuery("#loading").css({"top":document.body.scrollTop + document.body.clientHeight/2 - loadingHeight/2,"left":document.body.scrollLeft + document.body.clientWidth/2 - loadingWidth/2});
	    jQuery("#loading").show();
    }else{
        jQuery("#loading").hide();
        jQuery("#bg").hide(); //���չر�
    }
}


	jQuery(function(){
		jQuery(".attentionStateBody:first .attentionStateTitle").click();
	});
	
	function hideDetail(tm,th,workDate){
		var t=false;
		var openDetail=undefined;
		jQuery(".attentionStateBody .details").each(function(obj){
			if(jQuery(this).is(":visible")){
				openDetail=jQuery(this).hide();
				t=workDate==jQuery(this).attr("forDate");
				jQuery(this).parent().find(".coBar").removeClass("coBarOpen").addClass("coBarClose").find("div").text("<%=SystemEnv.getHtmlLabelName(15315,user.getLanguage())%>");//չ��
				return;
			}
		});
		if(t)return;
		if(jQuery(tm).is(":visible")){
			jQuery(tm).hide();
			jQuery(th).find(".coBar").removeClass("coBarOpen").addClass("coBarClose").find("div").text("<%=SystemEnv.getHtmlLabelName(15315,user.getLanguage())%>"); //չ��
			alert(jQuery(th).find(".coBar").text());
		}else{
			jQuery(tm).show();
			jQuery(th).find(".coBar").removeClass("coBarClose").addClass("coBarOpen").find("div").text("<%=SystemEnv.getHtmlLabelName(20721,user.getLanguage())%>"); //����
			if(jQuery.trim(jQuery(tm).html())==""){
			    displayLoading(1,"data");
				jQuery(tm).load("attentionList.jsp",{'workDate':workDate},function(){
				
				    //��ʼ������ͼƬ
			       jQuery(tm).find('.reportContent img').each(function(){
						initImg(this);
				   });
					
				   //�ϼ����ֳ�ʼ��
				   jQuery(tm).find(".blog_raty").each(function(){
					   managerScore(this);
				   });
					
					displayLoading(0);
				});
			}
		}
	}
   
   //��ӵ��ղؼ�
    function openFavouriteBrowser(){
	   var url=window.location.href;
	   fav_uri="/blog/blogView.jsp?item=attention&";
	   fav_uri = encodeURIComponent(fav_uri,true); 
	   var fav_pagename=jQuery("title").html();
	   window.showModalDialog("/favourite/FavouriteBrowser.jsp?fav_pagename="+fav_pagename+"&fav_uri="+fav_uri+"&fav_querystring=");
    }	

</script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker.js"></script>

