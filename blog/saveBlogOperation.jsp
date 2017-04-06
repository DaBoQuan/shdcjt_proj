<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="weaver.conn.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.blog.AppDao"%>
<%@page import="weaver.blog.BlogDao"%>
<%@page import="weaver.blog.BlogManager"%>
<%@page import="java.util.List"%>
<%@page import="oracle.sql.CLOB"%>
<%@page import="java.io.Writer"%>
<%@page import="weaver.blog.BlogDiscessVo"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.conn.ConnStatement"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="cs" class="weaver.conn.ConnStatement" scope="page" />

<%

  boolean isoracle = (cs.getDBType()).equals("oracle");
    HashMap result=new HashMap();
	User user = HrmUserVarify.getUser (request , response) ;
    if(user==null){
    	result.put("status","2"); //��ʱ
    	JSONObject json=JSONObject.fromObject(result);
		out.println(json);
    }else {
	request.setCharacterEncoding("UTF-8");
	Date today=new Date();
	String userid=""+user.getUID();
	String curDate=new SimpleDateFormat("yyyy-MM-dd").format(today);//��ǰ����
	String curTime=new SimpleDateFormat("HH:mm:ss").format(today);//��ǰʱ��
	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat dateFormat3=new SimpleDateFormat("yyyy��M��d�� HH:mm");
	
	String content=Util.null2String(request.getParameter("content"));//��־����
	
	String forDate=Util.null2String(request.getParameter("forDate"));
	String appType=Util.null2String(request.getParameter("type"));
	String appItemId=Util.null2String(request.getParameter("appItemId"));
	int discussid=Util.getIntValue(Util.null2String(request.getParameter("discussid")),0);
	//��ֹ���ݴ���ȱʧ
	if(content.equals("")||forDate.equals("")||appItemId.equals("0")){
		result.put("status","3");
		JSONObject json=JSONObject.fromObject(result);
		out.println(json);
		
	}else{

		appItemId=appItemId.equals("2")?appItemId:"1"; //�������鶪ʧ���	
		String score="0";
		String comefrom="0";
		
		BlogDao blogDao=new BlogDao();
		String isManagerScore=blogDao.getSysSetting("isManagerScore");  //�����ϼ�����
		
		boolean isEdit=discussid!=0?true:false;  //�Ƿ��Ǳ༭
		
		String lastUpdateTime=""+today.getTime();
		String sql="";
		AppDao appDao=new AppDao();
		boolean isAppend=false;
		try{
		if(!isEdit){ //���΢����¼id=0 ���ʾΪ����
			
			BlogDiscessVo discessVo=blogDao.getDiscussVoByDate(userid,forDate);
			if(discessVo!=null){ //�ж��Ƿ�Ϊ����΢����discessVoΪnullΪ�����������������׷�ӵ��������£����˶
			
				isAppend=true;
				content=discessVo.getContent()+content;
				if(isoracle){//oracle���ݿ��clob�ֶ���Ҫ�����ķ�ʽ�ӵ����ݿ�
				
				sql="update blog_discuss set lastUpdatetime=?,content=? where id=?";
				cs.setStatementSql(sql);
				cs.setString(1,lastUpdateTime);
				cs.setString(2,"empty_clob()");
				cs.setString(3,discessVo.getId());
				cs.executeQuery();
				sql="select content from blog_discuss where id=?";
				cs.setStatementSql(sql, false);
				cs.setString(1,discessVo.getId());
                cs.executeQuery();
                cs.next();
                CLOB theclob = cs.getClob(1);

                String contenttemp = content; // (new
                // String(this.doccontent.getBytes("ISO8859_1"),
                // "GBK")) ;
                char[] contentchar = contenttemp.toCharArray();
                Writer contentwrite = theclob.getCharacterOutputStream();
                contentwrite.write(contentchar);
                contentwrite.flush();
                contentwrite.close();
                
				}else{
				sql="update blog_discuss set lastUpdatetime=?,content=? where id=?";
				cs.setStatementSql(sql);
				cs.setString(1,lastUpdateTime);
				cs.setString(2,content);
				cs.setString(3,discessVo.getId());
				}			
					
			}else{//����΢��
			
			 if (isoracle) {
			
			 sql="insert into blog_discuss (userid, createdate, createtime,content,lastUpdatetime,isReplenish,workdate,score,comefrom)"+
					"values (?, ?,?,?,?,?,?,?,?)";
				cs.setStatementSql(sql);
				cs.setString(1,""+userid);
				cs.setString(2,""+curDate);
				cs.setString(3,""+curTime);
				cs.setString(4,"empty_clob()");
				cs.setString(5,""+lastUpdateTime);
				cs.setString(6,""+(forDate.equals(curDate)?"0":"1"));
				cs.setString(7,""+forDate);
				cs.setString(8,"0");
				cs.setString(9,"0");
			    cs.executeQuery();
			   
				sql="select content from  blog_discuss where id = (select max(id) from blog_discuss )";
				cs.setStatementSql(sql, false);
                cs.executeQuery();
                cs.next();
                CLOB theclob = cs.getClob(1);

                String contenttemp = content; // (new
                // String(this.doccontent.getBytes("ISO8859_1"),
                // "GBK")) ;
                char[] contentchar = contenttemp.toCharArray();
                Writer contentwrite = theclob.getCharacterOutputStream();
                contentwrite.write(contentchar);
                contentwrite.flush();
                contentwrite.close();
                
			 
			 }else{
				sql="insert into blog_discuss (userid, createdate, createtime,content,lastUpdatetime,isReplenish,workdate,score,comefrom)"+
					"values (?, ?,?,?,?,?,?,?,?)";	
				cs.setStatementSql(sql);
				cs.setString(1,""+userid);
				cs.setString(2,""+curDate);
				cs.setString(3,""+curTime);
				cs.setString(4,""+content);
				cs.setString(5,""+lastUpdateTime);
				cs.setString(6,""+(forDate.equals(curDate)?"0":"1"));
				cs.setString(7,""+forDate);
				cs.setString(8,"0");
				cs.setString(9,"0");
				}
			}
		
		}else{            //����
		
		if(isoracle){
		    sql="update blog_discuss set lastUpdatetime=?,content=? where id=?";
			cs.setStatementSql(sql);
			cs.setString(1,""+lastUpdateTime);
			cs.setString(2,"empty_clob()");
			cs.setString(3,""+discussid);
			 cs.executeQuery();
			  sql="select content from  blog_discuss where id =? ";
			   cs.setStatementSql(sql, false);
				cs.setString(1,""+discussid);
                cs.executeQuery();
                cs.next();
                CLOB theclob = cs.getClob(1);

                String contenttemp = content; // (new
                // String(this.doccontent.getBytes("ISO8859_1"),
                // "GBK")) ;
                char[] contentchar = contenttemp.toCharArray();
                Writer contentwrite = theclob.getCharacterOutputStream();
                contentwrite.write(contentchar);
                contentwrite.flush();
                contentwrite.close();
		
		}else{
		    sql="update blog_discuss set lastUpdatetime=?,content=? where id=?";
			cs.setStatementSql(sql);
			cs.setString(1,""+lastUpdateTime);
			cs.setString(2,""+content);
			cs.setString(3,""+discussid);
		
		}
			
			
		}
		
		HashMap backData=new HashMap();
		
		if(cs.executeUpdate()>0){
			cs.close(); //�ر����ݿ�����
			
			//����Ǳ༭����ȡ����ʱ��ʱ��
			if(isEdit){
				BlogDiscessVo discessVo=blogDao.getDiscussVo(""+discussid);
				curDate=discessVo.getCreatedate();
				curTime=discessVo.getCreatetime();
				score=discessVo.getScore();
				comefrom=discessVo.getComefrom();
			}
			//discuss=0��ʾ�½�
			if(!isEdit){
				sql="select max(id) as maxid  from blog_discuss where userid="+userid+"";
				rs.executeSql(sql);
				if(rs.next()){
					discussid=rs.getInt("maxid");
				}
			}
			
			backData.put("id",""+discussid);
			backData.put("curDate",curDate);
			backData.put("curTime",curTime);
			backData.put("forDate",forDate);
			
			String createdatetime=dateFormat3.format(dateFormat.parse(curDate+" "+curTime));
			backData.put("createdatetime",createdatetime);
			backData.put("score",score);
			backData.put("isManagerScore",isManagerScore);
			
			backData.put("comefrom",comefrom);
			
			backData.put("userName",user.getLastname());
			backData.put("userid",""+user.getUID());
			
			String type=(!forDate.equals(curDate))?"1":"0"; //�Ƿ�Ϊ����  1���� 0�����ύ
			backData.put("type",type);
			
			result.put("status","1");  //�����Ƿ�ɹ�
			
			if(appDao.getAppVoByType("mood").isActive()){
				if(!isEdit&&!isAppend){
					sql="INSERT INTO blog_appDatas(userid,workDate,createDate,createTime,discussid,appitemId)"+
						 "VALUES('"+user.getUID()+"','"+forDate+"','"+curDate+"','"+curTime+"','"+discussid+"','"+appItemId+"')";
				}else{
					sql="update blog_appDatas set  appitemId='"+appItemId+"' where discussid='"+discussid+"'";
				}
				rs.executeSql(sql);
				sql="SELECT * FROM blog_appDatas LEFT JOIN blog_AppItem ON blog_appDatas.appItemId=blog_AppItem.id WHERE discussid='"+discussid+"'";
				rs.executeSql(sql);
				if(rs.next()){
					backData.put("appItemId",appItemId);
					backData.put("faceImg",rs.getString("face"));
					backData.put("itemName",SystemEnv.getHtmlLabelName(Util.getIntValue(rs.getString("itemName")),user.getLanguage()));
				}
			}
			//�ύ�µ�΢��ʱ��������
			if(!isEdit&&!isAppend){
				//ɾ���Ķ���¼
				sql="DELETE FROM blog_read WHERE blogid='"+user.getUID()+"'";
				rs.executeSql(sql);
				
				//����ע�ҵ��˷���΢���ύ����
				List attentionMeList=blogDao.getAttentionMe(userid);
				for(int i=0;i<attentionMeList.size();i++){
					blogDao.addRemind((String)attentionMeList.get(i),userid,"6",""+discussid,"0");
				}
			}
			
			result.put("backdata",backData);
			JSONObject json=JSONObject.fromObject(result);
			
			out.println(json);
			
		}else{
			result.put("status","0");
			JSONObject json=JSONObject.fromObject(result);
			
			out.println(json);
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			cs.close();
		}
	    }
    }
%>