<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="weaver.blog.BlogReplyVo"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="weaver.conn.RecordSet"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo"></jsp:useBean>
<%@ include file="common.jsp"%>
<style>
  .blogStatus_tab{background: url('/page/element/blogStatus/images/ele-tab-bg.png');}
  .blogStatus_tab .selected{background: url('/page/element/blogStatus/images/ele-tab-btn3.png') no-repeat;color: #333;width: 77px;cursor: pointer;text-align: center;}
  .blogStatus_tab .unselected{background: url('/page/element/blogStatus/images/ele-tab-btn2.png') no-repeat;color: #333;width: 77px;cursor: pointer;text-align: center;}
  .blogContent{margin-top: 5px;clear:both;background: #f8f8f8; border-bottom: #dcdcdc 1px solid; border-left: #dcdcdc 1px solid; border-top: #dcdcdc 1px solid; border-right: #dcdcdc 1px solid; padding-bottom: 5px; padding-left: 5px; padding-right: 2px; padding-top: 2px;}
  .blogContent p{margin:0px}
</style>
<%
	String  blog_showNum="10";
	String 	blog_isCreatedate="1";
	String 	blog_isRelatedName="1";
	String sql="select name,value from hpelementsetting where eid='"+eid+"'";
	rs_Setting.execute(sql);
	while(rs_Setting.next()){
		String name=rs_Setting.getString("name");
		if(name.equals("blog_showNum"))
			blog_showNum=rs_Setting.getString("value");
		else if(name.equals("blog_isCreatedate"))
			blog_isCreatedate=rs_Setting.getString("value");
		else if(name.equals("blog_isRelatedName"))
			blog_isRelatedName=rs_Setting.getString("value");
	}
	
	if(!Pattern.matches("^\\d+$",blog_showNum)){
		blog_showNum="10";
	}
	String showType=Util.null2String(request.getParameter("showType"));
	if("".equals(showType))
		showType="all";
	BlogDao blogDao=new BlogDao();    
    List commentList=blogDao.getBlogStatusRemidList(user,"comment",blog_showNum);
    List remindList=blogDao.getBlogStatusRemidList(user,"remind",blog_showNum);
    List updateList=blogDao.getBlogStatusRemidList(user,"update",blog_showNum);
    
    Map map=blogDao.getReindCount(user);
    int commentCount=((Integer)map.get("commentCount")).intValue();
    int remindCount=((Integer)map.get("remindCount")).intValue();
    int updateCount=((Integer)map.get("updateCount")).intValue();
    
    String mainTypes[]={"update","comment","remind"};
    int counts[]={updateCount,commentCount,remindCount};
    
    for (int i = 0; i < counts.length; i++) {    
      for (int j = i + 1; j <counts.length; j++) {    
    	if (counts[i] <counts[j]) {    
    	     int temp = counts[i]; 
    	     counts[i] = counts[j];    
    	     counts[j] = temp;    
    	     
    	     String tempType=mainTypes[i];
    	     mainTypes[i]=mainTypes[j];
    	     mainTypes[j]=tempType;
    	    }    
    	}    
    }    
    
	SimpleDateFormat frm1=new SimpleDateFormat("MM��dd��");
	SimpleDateFormat frm2=new SimpleDateFormat("yyyy-MM-dd");
	
	String selectTab="";
%>
<div class="blogStatus_tab">
   <table height="32px" border="0" cellpadding="0" cellspacing="0">
     <tr>
      <%
      for(int i=0;i<mainTypes.length;i++){
    	String mainType=mainTypes[i];
    	int size=counts[i]; 
    	if(i==0)
    		selectTab=mainType;
      %>
       <%if(mainType.equals("remind")){%>
         <td onclick="showRemind(this,<%=eid%>,'<%=mainType%>')" <%=i==0?"class='selected'":"class='unselected'"%> id="<%=eid%>_remind"><%=SystemEnv.getHtmlLabelName(26928,user.getLanguage())%><%=size>0?"("+size+")":""%></td><!-- ���� -->
       <%}else if(mainType.equals("comment")){ %>  
         <td onclick="showRemind(this,<%=eid%>,'<%=mainType%>')" <%=i==0?"class='selected'":"class='unselected'"%> id="<%=eid%>_comment"><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%><%=size>0?"("+size+")":""%></td><!-- ���� -->
       <%}else if(mainType.equals("update")){ %>  
         <td onclick="showRemind(this,<%=eid%>,'<%=mainType%>')" <%=i==0?"class='selected'":"class='unselected'"%> id="<%=eid%>_update"><%=SystemEnv.getHtmlLabelName(17744,user.getLanguage())%><%=size>0?"("+size+")":""%></td><!-- ���� -->
       <%} %>
      <% } %>   
     </tr>
   </table>
</div>

<%
   for(int i=0;i<mainTypes.length;i++){
      String mainType=mainTypes[i];
      List resultList=null;
      if(mainType.equals("remind"))
    	  resultList=remindList;
      else if(mainType.equals("comment"))
    	  resultList=commentList;
      else if(mainType.equals("update"))
    	  resultList=updateList;
%>  
<TABLE  class="<%=eid%>_blogStatus_table" width="100%" id='<%=eid+"_table_"+mainType%>' style="display:<%=i==0?"":"none"%>">
<TR vAlign=center>
<TD vAlign=center width=1></TD>
<TD vAlign=top width=* id='<%=eid+"_td_"+mainType%>'>
	<TABLE width="100%">     
<%
	  for(int j=0;j<resultList.size();j++){
		map=(Map)resultList.get(j);  
		String id=(String)map.get("id");  
		String remindType=(String)map.get("remindType");
		String relatedid=(String)map.get("relatedid");
		String createdate=(String)map.get("createdate");
		String remindValue=(String)map.get("remindValue");
	 %>
	 <!-- ��ע���� -->
	  <%if("1".equals(remindType)){%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=*>
				    <!-- ���������ע -->
					<A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid)%><%=SystemEnv.getHtmlLabelName(26988,user.getLanguage())%></FONT>
					</A> 
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- ����ͬ�� -->
		<%if("2".equals(remindType)){%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=*>
				   <!-- ��������Ĺ�ע���� -->
				   <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid)%><%=SystemEnv.getHtmlLabelName(26989,user.getLanguage())%></FONT>
				   </A> 
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- ����ܾ� -->
		<%if("3".equals(remindType)){%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=*>
				   <!-- �ܾ�����Ĺ�ע���� -->
				   <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid) %><%=SystemEnv.getHtmlLabelName(26991,user.getLanguage())%></FONT>
				   </A> 
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- ��ע�ҵ� -->
		<%if("5".equals(remindType)){%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=*>
				   <!-- ��ע���� -->
				   <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid) %><%=SystemEnv.getHtmlLabelName(26992,user.getLanguage())%></FONT>
				   </A> 
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- ΢������ -->
		<%if("6".equals(remindType)){
			BlogDiscessVo discussVo= blogDao.getDiscussVo(remindValue);
			
			//���΢����¼�����ڣ���ɾ������
			if(discussVo==null){
			   RecordSet recordSet=new RecordSet();
			   recordSet.execute("delete from blog_remind where id="+id);
			   continue;	
			}
				
			String workdate=discussVo.getWorkdate();
			try{
				workdate=frm1.format(frm2.parseObject(workdate));
		    }catch(Exception e){
		    	e.printStackTrace();
		    }
			
            String message=SystemEnv.getHtmlLabelName(615,user.getLanguage())+workdate+SystemEnv.getHtmlLabelName(26759,user.getLanguage());
		%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=* valign="top">
				    <!-- �ύ��{0}����΢�� -->
				    <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','homepage')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid) %><%=message%></FONT>
				    </A>
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- δ�ύ���� -->
		<%if("7".equals(remindType)){
			if("".equals(remindValue))
				continue;
		    try{
		    	remindValue=frm1.format(frm2.parseObject(remindValue));
		    }catch(Exception e){
		    	e.printStackTrace();
		    }
			
			String message=SystemEnv.getHtmlLabelName(26928,user.getLanguage())+SystemEnv.getHtmlLabelName(615,user.getLanguage())+remindValue+SystemEnv.getHtmlLabelName(26759,user.getLanguage());
		%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD  width=*>
				    <!-- �������ύ{0}����΢�� -->
				    <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid) %><%=message%></FONT>
				    </A>
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- δ�ύϵͳ���� -->
		<%if("8".equals(remindType)){
			Object object[]=new Object[1];
    		object[0]=remindValue;
			String message = MessageFormat.format(SystemEnv.getHtmlLabelName(26995,user.getLanguage()),object);
		%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD width=*>
				    <!-- �������ύ{0}����΢�� -->
				    <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','sysremind')">
					    <FONT class=font><%=message%></FONT>
				    </A>
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=SystemEnv.getHtmlLabelName(15172,user.getLanguage())%></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		<!-- �����ҵ�  -->
		<%if("9".equals(remindType)){
			
			String disucssid=Util.TokenizerString2(remindValue, "|")[0];  //΢��id
			String beReplayid=Util.TokenizerString2(remindValue, "|")[1];   //�����۵�����id
			String replayid=Util.TokenizerString2(remindValue, "|")[2];//����id
			
			BlogReplyVo replyVo=blogDao.getReplyById(replayid);
			BlogReplyVo beReplayVo=blogDao.getReplyById(beReplayid);
			
			if(replyVo==null||(!beReplayid.equals("0")&&beReplayVo==null))
				continue;
			
			String workdate=replyVo.getWorkdate();
			try{
				workdate=frm1.format(frm2.parseObject(workdate));
		    }catch(Exception e){
		    	e.printStackTrace();
		    }
			
			String message="";
			if("0".equals(beReplayid)){
				Object object[]=new Object[1];
    		    object[0]=workdate;
				message=MessageFormat.format(SystemEnv.getHtmlLabelName(26996,user.getLanguage()),object); //��������{0}����΢��
			}	
			else if(replyVo.getBediscussantid().equals(""+user.getUID())){
				Object object[]=new Object[1];
    		    object[0]=workdate;
				message=MessageFormat.format(SystemEnv.getHtmlLabelName(26997,user.getLanguage()),object); //����{0}�Ĺ���΢���лظ�����
			}else{
				Object object[]=new Object[1];
    		    object[0]=ResourceComInfo.getLastname(replyVo.getBediscussantid())+workdate;
				message=MessageFormat.format(SystemEnv.getHtmlLabelName(26998,user.getLanguage()),object); //��{0}�Ĺ���΢���лظ�����
			}
		%>
		   <TR height=18>
				<TD width=8><IMG name=esymbol src="/page/element/blogStatus/images/li.png"></TD>
				<TD valign="top"  width=*>
				    <A href="javascript:openRemind(<%=eid%>,'<%=mainType%>','comment')">
					    <FONT class=font><%=ResourceComInfo.getLastname(relatedid) %><%=message%></FONT>
				    </A>
				</TD>
				<td width="70" style="display:<%=blog_isRelatedName.equals("1")?"":"none"%>"><%=ResourceComInfo.getLastname(relatedid) %></td>
				<td width="76" style="display:<%=blog_isCreatedate.equals("1")?"":"none"%>"><%=createdate%></td>
			</TR>
			<TR class=sparator style="height:1px" height=1 ><TD colSpan=4 style='padding:0px'></TD></TR>
		<%} %>
		
	 <%} %>	
 </TABLE> 
</TD>
<TD width=1></TD>
</TR>
</TABLE>
<%} %>

 <script>
    
  changeMore(<%=eid%>,"<%=selectTab%>");
  
  function openRemind(eid,mainType,menuItem){
    openFullWindowHaveBar('/blog/blogView.jsp?menuItem='+menuItem)
    
    jQuery("#"+eid+"_table_"+mainType).html("");
    
    if(mainType=="update")
       tabName="<%=SystemEnv.getHtmlLabelName(17744,user.getLanguage())%>"; //����
    else if(mainType=="remind")   
       tabName="<%=SystemEnv.getHtmlLabelName(26928,user.getLanguage())%>"; //����
    else if(mainType=="comment")   
       tabName="<%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%>";   //����
    else if(mainType=="request")   
       tabName="<%=SystemEnv.getHtmlLabelName(648,user.getLanguage())%>";   //����   
    jQuery("#"+eid+"_"+mainType).html(tabName);
  }
  
  function showRemind(obj,eid,mainType){
     jQuery(obj).parent("tr:first").find(".selected").removeClass("selected").addClass("unselected");
     jQuery(obj).removeClass("unselected").addClass("selected");
     
     jQuery("."+eid+"_blogStatus_table").hide();
     jQuery("#"+eid+"_table_"+mainType).show();
     
     changeMore(eid,mainType);
  }
  
  //�޸�moreҳ��
  function changeMore(eid,mainType){
    if(mainType=="update")
       $("#more_"+eid).attr("href","javascript:openFullWindowForXtable('/blog/blogView.jsp?menuItem=homepage')")
    else if(mainType=="comment") 
       $("#more_"+eid).attr("href","javascript:openFullWindowForXtable('/blog/blogView.jsp?menuItem=comment')")
    else 
       $("#more_"+eid).attr("href","javascript:openFullWindowForXtable('/blog/blogView.jsp?menuItem=sysremind')")  
  }
  
</script>