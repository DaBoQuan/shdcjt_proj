<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.conn.RecordSet"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.hrm.resource.ResourceComInfo"%>
<%@page import="weaver.hrm.company.DepartmentComInfo"%>
<%@ page import="weaver.general.*" %>
<%
 BlogDao blogDao=new BlogDao();
 String listType=request.getParameter("listType");
 String keyworkd=Util.null2String(request.getParameter("keyworkd"));
 String userid=""+user.getUID();
 int departmentid=user.getUserDepartment();   //�û���������
 int subCompanyid=user.getUserSubCompany1();  //�û������ֲ�
 String seclevel=user.getSeclevel();          //���ڰ�ȫ�ȼ�
 String sqlStr="";
%>

 <%if(listType.equals("attention")){
	int pagesize=Util.getIntValue(request.getParameter("pagesize"),30);
	int total=Util.getIntValue(request.getParameter("total"),30);
	int currentpage=Util.getIntValue(request.getParameter("currentpage"),1);
	List attentionList=blogDao.getAttentionMapList(userid,currentpage,pagesize,total);
    if(attentionList.size()>0){
 %> 
  <table id='blogList' class="ListStyle" cellspacing="1" style="margin:0px;width:100%">
		<tbody id="list_body">
		  <%
		    String trClass="";
		    for(int i=0;i<attentionList.size();i++){
		      Map map=(Map)attentionList.get(i);	
		      String attentionid=(String)map.get("attentionid");
		      String isnew=(String)map.get("isnew");
		      String username=(String)map.get("username");
		      String deptName=(String)map.get("deptName");
		  %>
			<TR class=<%=(trClass=trClass.equals("dataLight")?"dataDark":"dataLight")%>>
				<TD class="item" style="<%=isnew.equals("1")?"FONT-WEIGHT: bold":""%>" onclick="openBlog(<%=attentionid%>,1,this)" vAlign="center">
					<DIV class=title  title="<%=username%>"><%=username%></DIV>
					<div class="attdept" title="<%=deptName%>"><%=deptName%></div>
			    </TD>
			</TR>
		  <%} %>	
		</tbody>
  </table>
  <%}else
	  out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(26963,user.getLanguage())+"</div>");  //��ǰû�й�ע����
  %> 
<%}else if(listType.equals("searchList")||listType.equals("canview")){ 
	String allowRequest=blogDao.getSysSetting("allowRequest");   //ϵͳ�����������
	Map conditions=new HashMap();
	conditions.put("keyworkd",keyworkd);
    List blogList=blogDao.getBlogMapList(userid,listType,conditions);
   if(blogList.size()>0){
%> 
      <table id='blogList' class="ListStyle" cellspacing="1" style="margin:0px;width:100%">
		<tbody id="list_body">
		  <%
		    ResourceComInfo resourceComInfo=new ResourceComInfo();
		    DepartmentComInfo departmentComInfo=new DepartmentComInfo();
		    String trClass="";
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
		    	  sqlStr="select isReceive from blog_setting where userid="+attentionid;
		    	  recordSet2.execute(sqlStr);
		    	  if(recordSet2.next())
		    		 isReceive=recordSet2.getInt("isReceive");
		    	  if(isReceive==0)
		    		 status="-1";             //����������
		    	  if(allowRequest.equals("0"))
		    		  status="-1";             //ϵͳ����Ϊ����������
		      }	  
		      String username=resourceComInfo.getLastname(attentionid);
		      String deptName=departmentComInfo.getDepartmentname(resourceComInfo.getDepartmentID(attentionid));
		  %>
			<TR class=<%=(trClass=trClass.equals("dataLight")?"dataDark":"dataLight")%>>
			<TD class="item" onclick="openBlog(<%=attentionid%>,1,this)" style="<%=isnew.equals("1")?"FONT-WEIGHT: bold":""%>" vAlign=center>
				<DIV class=title><%=username%></DIV>
				<div class="dept"><%=deptName%></div>
				<%if(status.equals("0")&&!attentionid.equals(userid)){%>
			       <div class="disOperation"> 
				       <a class="btnEcology" id="cancelAttention" href="javascript:void(0)" onclick="disAttention(this,<%=attentionid%>,<%=islower%>,event);" status="apply" style="margin-right: 8px;">
							<div class="left" style="width:68px;color: #666;font-weight: normal !important;padding-left: 0px"><span id="btnLabel"><span class="apply">��</span><%=SystemEnv.getHtmlLabelName(26941,user.getLanguage())%></span></div><!-- �����ע -->
							<div class="right"> &nbsp;</div>
					   </a>
				  </div>  
			    <%}else if(status.equals("1")&&!attentionid.equals(userid)){%>
			      <div class="disOperation"> 
				       <a class="btnEcology" id="cancelAttention" href="javascript:void(0)" onclick="disAttention(this,<%=attentionid%>,<%=islower%>,event);" status="add" style="margin-right: 8px;">
							<div class="left" style="width:68px;color: #666;font-weight: normal !important"><span id="btnLabel"><span class="add">+</span><%=SystemEnv.getHtmlLabelName(26939,user.getLanguage())%></span></div><!-- ��ӹ�ע -->
							<div class="right"> &nbsp;</div>
					   </a>
				  </div>  
			    <%}else if(status.equals("2")&&!attentionid.equals(userid)){%>
			      <div class="disOperation"> 
				       <a class="btnEcology" id="cancelAttention" href="javascript:void(0)" onclick="disAttention(this,<%=attentionid%>,<%=islower%>,event);" status="cancel" style="margin-right: 8px;">
							<div class="left" style="width:68px;color: #666;font-weight: normal !important"><span id="btnLabel"><span class="cancel">-</span><%=SystemEnv.getHtmlLabelName(24957,user.getLanguage())%></span></div><!-- ȡ����ע -->
							<div class="right"> &nbsp;</div>
					   </a>
				  </div>   
			    <%} %>
			</TR>
		 <%} %>	
		</tbody>
  </table>
  <%}else
	  out.println("<div class='norecord'>"+SystemEnv.getHtmlLabelName(22521,user.getLanguage())+"</div>");  
  %> 
   <%}else if(listType.equals("hrmOrg")){ %>
    <script>
	 jQuery(document).ready(function(){
	       $("#hrmOrgTree").addClass("hrmOrg"); 
	       $("#hrmOrgTree").treeview({
	          url:"hrmOrgTree.jsp"
	       });
	 });
    </script> 
    <div style="width:100%;;border-top:1px solid  #c8ebfd;line-height:1px"></div>
    <ul id="hrmOrgTree" style="width: 100%"></ul>
    
   <%}%>

