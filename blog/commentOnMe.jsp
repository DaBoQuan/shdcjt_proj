<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.conn.RecordSet"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.blog.BlogReplyVo"%>
<%@page import="weaver.blog.AppDao"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
 <div class="title_bg">
     <div class="title_comment"><%=SystemEnv.getHtmlLabelName(26999,user.getLanguage())%></div><!-- �����ҵ� -->
 </div>
 <div id="commentDiv">
 </div>
<script type="text/javascript">
  jQuery.post("discussList.jsp?requestType=commentOnMe",function(data){
     jQuery("#commentDiv").html(data);
     //��ʼ������ͼƬ
     jQuery('.reportContent img').each(function(){
		initImg(this);
     });
	 //�ϼ����ֳ�ʼ��
	 jQuery(".blog_raty").each(function(){
	   managerScore(this);
	   jQuery(this).attr("isRaty","true"); 
	 });
     jQuery("#commentcount").hide();
     jQuery.post("blogOperation.jsp?operation=markCommentRead"); //ɾ����������
  }); 
</script>



