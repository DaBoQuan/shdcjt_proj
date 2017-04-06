<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.*" %>
<%@page import="weaver.page.maint.layout.PageLayoutUtil"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.zip.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.util.Date" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pc" class="weaver.page.PageCominfo" scope="page" />
<%

String dirTemplate=pc.getConfig().getString("template.path");
String tempPath = GCONST.getRootPath()+dirTemplate+"/temp";
String message = "0";

DiskFileUpload fu = new DiskFileUpload();
//fu.setSizeMax(4194304);				//4MB
fu.setSizeThreshold(4096);			//��������С4kb
fu.setRepositoryPath(tempPath);


String method="",templatename="", templatedesc="",templateid="";

String zipName="";

String zipTmp = "";

File targetFile=null;
if(request.getParameter("method")!=null){
	method = Util.null2String(request.getParameter("method"));
	templateid=Util.null2String(request.getParameter("templateid"));
}else{
	List fileItems = fu.parseRequest(request);
	Iterator i = fileItems.iterator();
	try{
		FileItem zipItem = null;
		while(i.hasNext()) {
			FileItem item = (FileItem)i.next();
			if(!item.isFormField()){
				String name = item.getName();
				if(Util.isExcuteFile(name)) continue;
				long size = item.getSize();
				if((name==null || name.equals("")) || size==0)	continue;
				
				zipName=name;
				int pos=zipName.lastIndexOf(File.separatorChar);
				if(pos==-1){
					pos=zipName.lastIndexOf("\\");
				}
				if(pos!=-1) zipName=zipName.substring(pos+1);
				zipItem = item;
				//item.delete();			
			}else{
				if(item.getFieldName().equals("method")) method=Util.null2String(item.getString("GBK"));
				if(item.getFieldName().equals("templatename")) templatename=Util.null2String(item.getString("GBK"));
				if(item.getFieldName().equals("templatedesc")) templatedesc=Util.null2String(item.getString("GBK"));
				if(item.getFieldName().equals("templateid")) templateid=Util.null2String(item.getString("GBK"));
				
			}
		} 
		if(zipItem!=null){
			
			if("add".equals(method)){
				Date currentDate = new Date();
				long currentTime = currentDate.getTime();
				zipTmp = currentTime+"";
			}else{
				rs.execute("select dir from pagetemplate where id="+templateid);
				if(rs.next()){
					zipTmp = rs.getString("dir").substring(0,rs.getString("dir").indexOf("/"));
				}
			}

			File zipFileDir  = new File(GCONST.getRootPath()+dirTemplate+"/zip/"+zipTmp+"/");
			zipFileDir.mkdirs();
			//FileUtils.cleanDirectory(zipFileDir);
			targetFile = new File( GCONST.getRootPath()+dirTemplate+"/zip/"+zipTmp+"/"+zipName);
			zipItem.write(targetFile);
			zipItem.delete();		
		}
	}catch(Exception e){
		System.out.println(e);
		message="1";
	}
}
	
templatedesc = templatedesc.replaceAll("\n","<br/>");

if("add".equals(method)){
	String rarPath = GCONST.getRootPath()+dirTemplate;
	String dir="";
	
	try {			
			ZipInputStream in = new ZipInputStream(new FileInputStream(targetFile));
			ZipEntry entry = null;
			boolean isFirst=true;
			while ((entry = in.getNextEntry()) != null) {
				String entryName = entry.getName();
				if(entryName.indexOf(zipTmp)==-1){
					entryName = zipTmp+"/"+entryName;
				}
				if(isFirst){
					dir=entryName;
					isFirst=false;
				}
							
				if (entry.isDirectory()) {
					File file = new File(rarPath + entryName);
					file.mkdirs();					
				} else {
					FileOutputStream os = new FileOutputStream(rarPath+entryName);
					byte[] buf = new byte[1024];

					int len;
					while ((len = in.read(buf)) > 0) {
					os.write(buf, 0, len);
					}
					os.close();
					in.closeEntry();
				}
			}
		
		
		//�����ݲ������ݿⲢ�õ������ݵ�ID��ΪĿ¼����

		if(!"".equals(dir)){
			PageLayoutUtil plu = new PageLayoutUtil();
			if(plu.checkLoginTemplate(dirTemplate,dir)){
				rs.executeSql("insert into pagetemplate(templatename,templatedesc,templatetype,templateusetype,dir,zipname) values ('"+templatename+"','"+templatedesc+"','cus','beforelogin','"+dir+"','"+zipTmp+"/"+zipName+"')");
			}else{
				message="1";
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		message="1";
	}
		response.sendRedirect("List.jsp?message="+message);
} else if("edit".equals(method)){
	String rarPath = GCONST.getRootPath()+dirTemplate+"/";
	String dir="";
	
	if(targetFile!=null){
		try {			
			//FileUtils.cleanDirectory(new File(rarPath+zipTmp));
			ZipInputStream in = new ZipInputStream(new FileInputStream(targetFile));
			ZipEntry entry = null;
			boolean isFirst=true;
			while ((entry = in.getNextEntry()) != null) {
			String entryName = entry.getName();
			if(entryName.indexOf(zipTmp)==-1){
				entryName = zipTmp+"/"+entryName;
			}
			if(isFirst){
				dir=entryName;
				isFirst=false;
			}				
			if (entry.isDirectory()) {
				File file = new File(rarPath + entryName);
				file.mkdirs();			
			} else {
				FileOutputStream os = new FileOutputStream(rarPath+entryName);
				byte[] buf = new byte[1024];

				int len;
				while ((len = in.read(buf)) > 0) {
					os.write(buf, 0, len);
				}
				os.close();
				in.closeEntry();
				}
			}
		
		
		if(!"".equals(dir)){
			PageLayoutUtil plu = new PageLayoutUtil();
			if(plu.checkLoginTemplate(dirTemplate,dir)){
				rs.executeSql("update  pagetemplate set templatename='"+templatename+"',templatedesc='"+templatedesc+"', dir='"+dir+"' ,zipName='"+zipTmp+"/"+zipName+"' where id="+templateid);			
			}else{
				message="1";
			}
		}
		} catch (Exception e) {
			System.out.println(e);
			message="1";
		}
		
	}else{ 
		rs.executeSql("update  pagetemplate set templatename='"+templatename+"',templatedesc='"+templatedesc+"' where id="+templateid);
	}
	response.sendRedirect("List.jsp?message="+message);
}else if("del".equals(method)){
	//�õ�zip�ļ������ѹ�����ڵ�Ŀ¼
	rs.executeSql("select * from pagetemplate where id="+templateid);
	String dir="";
	String zipNameTemp=""; 
	if(rs.next()){
			dir=rs.getString("dir");
			zipNameTemp=rs.getString("zipName");
	}
	if(!"".equals(dir)){
		//ɾ���ļ���
		try{
			File dirFile=new File( GCONST.getRootPath()+dirTemplate+dir.substring(0,dir.indexOf("/")));
			FileUtils.deleteDirectory(dirFile);
		}catch(Exception ex){
			//message="1";
		}
	}
	
	if(!"".equals(zipNameTemp)){
		//ɾ���ļ���
		try{
			File zipFile=new File( GCONST.getRootPath()+dirTemplate+"zip/"+zipNameTemp.substring(0,zipNameTemp.indexOf("/")));
			FileUtils.deleteDirectory(zipFile);
		}catch(Exception ex){
			//message="1";
		}
	}
	
	//ɾ�����ݿ��¼
	rs.executeSql("delete  pagetemplate  where id="+templateid);
	
	//��ת���б�ҳ��
	//System.out.println("List.jsp?message="+message);
	response.sendRedirect("List.jsp?message="+message);
}
%>