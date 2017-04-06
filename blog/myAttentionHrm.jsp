<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.blog.BlogShareManager"%>
<%@page import="weaver.conn.RecordSet"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo"></jsp:useBean>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo"></jsp:useBean>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo"></jsp:useBean>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo"></jsp:useBean>
<script>
   function addAttention(attentionid,islower){
      jQuery.post("blogOperation.jsp?operation=addAttention&islower="+islower+"&attentionid="+attentionid);
      jQuery("#cancelAttention_"+attentionid).show();
      jQuery("#addAttention_"+attentionid).hide();
   }
   function cancelAttention(attentionid,islower){
      jQuery.post("blogOperation.jsp?operation=cancelAttention&islower="+islower+"&attentionid="+attentionid);
      jQuery("#cancelAttention_"+attentionid).hide();
      jQuery("#addAttention_"+attentionid).show();
   }
</script>
<%
 String from=Util.null2String(request.getParameter("from"));
 String userid=Util.null2String(request.getParameter("userid"));
 String currentUserid=""+user.getUID();
 BlogDao blogDao=new BlogDao(); 
 SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
 SimpleDateFormat dateFormat2=new SimpleDateFormat("yyyy��MM��dd��");
 SimpleDateFormat timeFormat=new SimpleDateFormat("HH:mm");

 String departmentid=ResourceComInfo.getDepartmentID(userid);   //�û���������
 String subCompanyid=ResourceComInfo.getSubCompanyID(userid);   //�û������ֲ�
 String seclevel=ResourceComInfo.getSeclevel(userid);           //���ڰ�ȫ�ȼ�
 
 String allowRequest=blogDao.getSysSetting("allowRequest");    //ϵͳ�����������
 
 BlogShareManager shareManager=new BlogShareManager();
 String managerstr="','+t.managerstr+','";
 RecordSet recordSet=new RecordSet();
 if(recordSet.getDBType().equals("oracle"))
	managerstr="','||t.managerstr||','"; 
 
 List blogList=blogDao.getBlogMapList(userid,"attention",null);
 
 if(blogList.size()>0){
%>
<DIV id=footwall_visitme class="footwall" style="width: 100%;float: left;">
<UL>
<%	 
for(int i=0;i<blogList.size();i++){
    Map map=(Map)blogList.get(i);	
    String attentionid=(String)map.get("attentionid");
    
    String isnew=(String)map.get("isnew");
    String isshare=(String)map.get("isshare");//��������
    String isSpecified=(String)map.get("isSpecified"); //ָ������
    String isattention=(String)map.get("isattention");
    String islower=(String)map.get("islower");
    String iscancel=(String)map.get("iscancel");
    String status="0";                  //���ڹ���͹�ע��Χ��
    
    if(isshare.equals("1") || isSpecified.equals("1"))                 //�ڹ���Χ��
  	  status="1";
    if(status.equals("1")&&isattention.equals("1")) //�ڹ�ע��Χ��
  	  status="2";
    if(status.equals("2")&&islower.equals("1")&&iscancel.equals("1"))
  	  status="1";
    
    if(status.equals("0")){
  	  int isReceive=1;
  	  RecordSet recordSet2=new RecordSet();
  	  String sqlStr="select isReceive from blog_setting where userid="+attentionid;
  	  recordSet2.execute(sqlStr);
  	  if(recordSet2.next())
  		 isReceive=recordSet2.getInt("isReceive");
  	  if(isReceive==0)
  		 status="-1";             //����������
  	  if(allowRequest.equals("0"))
  		  status="-1";             //ϵͳ����Ϊ����������
    }	  
         
         String username=ResourceComInfo.getLastname(attentionid);
         String deptName=DepartmentComInfo.getDepartmentname(ResourceComInfo.getDepartmentID(attentionid));
 %>
  <LI class="LInormal" style="height: 75px">
	<DIV class="LIdiv">
	   <A class=figure href="viewBlog.jsp?blogid=<%=attentionid%>" target=_blank><IMG src="<%=ResourceComInfo.getMessagerUrls(attentionid)%>" width=55  height=55></A>
	   <div class=info>
	    <SPAN class=line><A class=name href="viewBlog.jsp?blogid=<%=attentionid%>" target=_blank><%=username%></A></SPAN> 
	    <SPAN class="line gray-time" title="<%=deptName%>"><%=deptName%></SPAN>
	   
	    <div> 
			<%if(!"view".equals(from)) {%>
               <a class="btnEcology" id="cancelAttention_<%=attentionid%>" href="javascript:void(0)" onclick="cancelAttention(<%=attentionid%>,<%=islower%>)" style="margin-right: 8px;display:<%=attentionid.equals(""+user.getUID())?"none":"" %>">
					<div class="left" style="width:70px;color: #666"><span ><span style="font-size: 16px;font-weight: bolder;margin-right: 3px">-</span><%=SystemEnv.getHtmlLabelName(26938,user.getLanguage())%></span></div><!-- ȡ����ע -->
					<div class="right"> &nbsp;</div>
	           </a>
	           <a class="btnEcology" id="addAttention_<%=attentionid%>" href="javascript:void(0)" onclick="addAttention(<%=attentionid%>,<%=islower%>)" style="margin-right: 8px;display: none">
					<div class="left" style="width:70px;color: #666"><span ><span style="font-size: 16px;font-weight: bolder;margin-right: 3px">+</span><%=SystemEnv.getHtmlLabelName(26939,user.getLanguage())%></span></div><!-- ��ӹ�ע -->
					<div class="right"> &nbsp;</div>
	           </a> 
			  <%} %>
		 </div>
	   </div>	   
	</DIV>
  </LI>
   <%}%> 
</UL>
</DIV>   
<%}else{ 
	out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(22521,user.getLanguage())+"</div>");
}%>
<script>
  jQuery("#footwall_visitme li").hover(
    function(){
       jQuery(this).addClass("LIhover");
    },function(){
       jQuery(this).removeClass("LIhover");
    }
  );
</script>
<br>
<br>	    
