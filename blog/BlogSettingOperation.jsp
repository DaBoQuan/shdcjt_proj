<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.blog.BlogDao"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@ page import="weaver.blog.BlogShareManager"%>
<%@ page import="weaver.file.FileUpload" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
    String userid=""+user.getUID();
    FileUpload fu = new FileUpload(request);
	String operation=Util.null2String(fu.getParameter("operation"));
	BlogShareManager shareManager=new BlogShareManager();
	
	if(operation.equals("add")){           //��ӹ�������
	   shareManager.addShare(""+userid,fu);
	   BlogDao blogDao=new BlogDao();
	   blogDao.delUpdateRemind(userid);
	   response.sendRedirect("shareSetting.jsp");
	}else if(operation.equals("delete")){ //ɾ����������
	   String shareid=Util.null2String(fu.getParameter("shareid"));
	   shareManager.deleteShare(userid,shareid); 
	   BlogDao blogDao=new BlogDao();
	   blogDao.delUpdateRemind(userid);
	}else if(operation.equals("edit")){
	   String isReceive=Util.null2String(fu.getParameter("isReceive"));
	   isReceive=isReceive.equals("1")?"1":"0";
	   String isThumbnail=Util.null2String(fu.getParameter("isThumbnail"));
	   isThumbnail=isThumbnail.equals("1")?"1":"0";
	   String maxAttention=Util.null2String(fu.getParameter("maxAttention"));
	   String sqlstr="update blog_setting set isReceive="+isReceive+",maxAttention="+maxAttention+",isThumbnail="+isThumbnail+" where userid="+userid;
	   
	   RecordSet.execute(sqlstr);
	   
	   response.sendRedirect("baseSetting.jsp");
	}else if(operation.equals("editApp")){ //����΢��Ӧ��ѡ�� 
		String[] appids=fu.getParameterValues("appid"); 
		
		String isActives[]=new String[appids.length];
		for(int i=0;i<appids.length;i++){
			String isActive=fu.getParameter("isActive_"+appids[i]);
			isActive=isActive.equals("1")?"1":"0";
			String sql="update blog_app set isActive="+isActive+" where id="+appids[i];
			RecordSet.execute(sql);
		}
		response.sendRedirect("BlogAppSetting.jsp");
    }else if(operation.equals("editBaseSetting")){ //����΢��Ӧ��ѡ�� 
		String allowRequest=fu.getParameter("allowRequest");
		allowRequest=allowRequest.equals("1")?"1":"0";
		String isSingRemind=fu.getParameter("isSingRemind");
		isSingRemind=isSingRemind.equals("1")?"1":"0";
		String isManagerScore=fu.getParameter("isManagerScore");
		isManagerScore=isManagerScore.equals("1")?"1":"0";
		String enableDate=fu.getParameter("enableDate"); 
		String attachmentDir=fu.getParameter("attachmentDir");
		String sql="update blog_sysSetting set allowRequest="+allowRequest+",enableDate='"+enableDate+"',isSingRemind="+isSingRemind+",isManagerScore="+isManagerScore+",attachmentDir='"+attachmentDir+"'";
		RecordSet.execute(sql);
		response.sendRedirect("BlogbaseSetting.jsp");
    }else if(operation.equals("addTemp")){ //�½�΢��ģ��
    	BlogDao blogDao=new BlogDao();
    	int tempid=Util.getIntValue(fu.getParameter("tempid"),0);
        String tempName=Util.null2String(fu.getParameter("tempName"));
        String tempContent=Util.null2String(fu.getParameter("tempContent"));
        String isUsed=Util.null2String(fu.getParameter("isUsed"));
        isUsed=isUsed.equals("1")?"1":"0";
        if(tempid==0)//�½�ģ��
        {
        	blogDao.addTemp(tempName,isUsed,tempContent);
        	response.sendRedirect("BlogTemplateSetting.jsp");
        }else
        {
        	blogDao.updateTemp(""+tempid,tempName,isUsed,tempContent);
        	response.sendRedirect("BlogTemplateSetting.jsp");
        }
    }else if(operation.equals("deleteTemp")){           //ɾ��΢��ģ��
		   int tempid=Util.getIntValue(fu.getParameter("tempid"),0);
		   BlogDao blogDao=new BlogDao();
		   blogDao.deleteTemp(""+tempid);
	}else if(operation.equals("addTempShare")){         //��ӹ�������
	   int tempid=Util.getIntValue(fu.getParameter("tempid"),0);
	   BlogDao blogDao=new BlogDao();
	   blogDao.addTempShare(""+tempid,fu);
	   response.sendRedirect("blogTemplateShare.jsp?tempid="+tempid);
	}else if(operation.equals("deleteTempShare")){       //ɾ����������
		   int shareid=Util.getIntValue(fu.getParameter("shareid"),0);
		   BlogDao blogDao=new BlogDao();
		   blogDao.deleteTempShare(""+shareid);
	}else if(operation.equals("addSpecified")){         //���ָ����������
		   int specifiedid=Util.getIntValue(fu.getParameter("specifiedid"),0);
		   BlogDao blogDao=new BlogDao();
		   blogDao.addSpecifiedShare(""+specifiedid,fu);
		   response.sendRedirect("/blog/specified/blogSpecifiedShareList.jsp");
	}else if(operation.equals("deleteSpecifiedShare")){       //ɾ��ָ����������
		   int shareid=Util.getIntValue(fu.getParameter("shareid"),0);
		   String specifiedid=Util.null2String(fu.getParameter("specifiedid"));
		   BlogDao blogDao=new BlogDao(); 
		   blogDao.deleteSpecifiedShare(specifiedid,""+shareid);
	}else if(operation.equals("deleteSpecified")){            //ɾ��ָ������
		   int specifiedid=Util.getIntValue(fu.getParameter("specifiedid"),0);
		   BlogDao blogDao=new BlogDao();
		   blogDao.deleteSpecified(""+specifiedid);
	}
%>