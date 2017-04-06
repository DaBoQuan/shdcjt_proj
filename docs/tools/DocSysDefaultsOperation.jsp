<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mould.DocMouldComInfo" scope="page" />
<jsp:useBean id="MouldManager" class="weaver.docs.mould.MouldManager" scope="page" />
<jsp:useBean id="SysDefaultsComInfo" class="weaver.docs.tools.SysDefaultsComInfo" scope="page" />
<jsp:useBean id="log" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<%

  String logsql = "select * from DocSysDefault";
  RecordSet.executeSql(logsql);
  RecordSet.next();
	String fgpicwidthold=RecordSet.getString("fgpicwidth");
	String fgpicfixtypeold=RecordSet.getString("fgpicfixtype");
	String docdefmouldidold=RecordSet.getString("docdefmouldid");
	//System.out.println("docdefmouldidold11111111:"+docdefmouldidold);
	//String docapprovewfid=RecordSet.getString("docapprovewfid");
  if(!HrmUserVarify.checkUserRight("DocSysDefaults:Edit", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
		}
  int fgpicwidth=Util.getIntValue(request.getParameter("fgpicwidth"),120);  //���
  String fgpicfixtype=Util.null2String(request.getParameter("fgpicfixtype"));//������С
  int docdefmouldid=Util.getIntValue(request.getParameter("docdefmouldid"),0);//Ĭ���ĵ���ʾģ��
  //System.out.println("docdefmouldid:"+docdefmouldid);
  int docapprovewfid=Util.getIntValue(request.getParameter("docapprovewfid"),0);

  String fgpicwidthaa = String.valueOf(fgpicwidth); 
  String fgpicwidthbb = String.valueOf(docdefmouldid);
//System.out.println("fgpicwidthbb22222222:"+fgpicwidthbb);
int reslutaa = 0;
int reslutbb = 0;
int reslutcc = 0;
if(!fgpicwidthaa.equals(fgpicwidthold)||!fgpicfixtypeold.equals(fgpicfixtypeold)){
	//System.out.println("**************1");
           reslutaa = 1;
}
if(!fgpicwidthbb.equals(docdefmouldidold)){
		//System.out.println("**************2");
		 reslutbb = 2;
}
if(fgpicwidthaa.equals(fgpicwidthold)&&fgpicfixtypeold.equals(fgpicfixtypeold)&&fgpicwidthbb.equals(docdefmouldidold)){
		//System.out.println("**************3");
		reslutcc = 3;
}
  int userid=user.getUID();
  char flag=Util.getSeparator();
  String ParaStr=""+fgpicwidth+flag+fgpicfixtype+flag+""+docdefmouldid+flag+""+docapprovewfid;
  RecordSet.executeProc("DocSysDefault_Update",ParaStr);
  SysDefaultsComInfo.removeSysDefaultsCache();
  // write operation log
  if(reslutaa==1){
	  //System.out.println("=================1");
  log.resetParameter();
  log.setRelatedId(1);
  log.setRelatedName(""+SystemEnv.getHtmlLabelName(70,user.getLanguage()));
  log.setOperateType("2");
  log.setOperateDesc("DocSysDefault_Update");
  log.setOperateItem("7");
  log.setOperateUserid(userid);
  log.setClientAddress(request.getRemoteAddr());
  log.setSysLogInfo();
  
  DocMouldComInfo.setUserDefDocMouldID(docdefmouldid);
  DocMouldComInfo.removeDocMouldCache() ;
  MouldManager.removeDefaultMouldCache() ;
}
if(reslutbb==2){
	//System.out.println("==================2");
log.resetParameter();
  log.setRelatedId(1);
  log.setRelatedName(""+SystemEnv.getHtmlLabelName(58,user.getLanguage()));
  log.setOperateType("2");
  log.setOperateDesc("DocSysDefault_Update");
  log.setOperateItem("7");
  log.setOperateUserid(userid);
  log.setClientAddress(request.getRemoteAddr());
  log.setSysLogInfo();
  
  DocMouldComInfo.setUserDefDocMouldID(docdefmouldid);
  DocMouldComInfo.removeDocMouldCache() ;
  MouldManager.removeDefaultMouldCache() ;
}
if(reslutcc==3){
	//System.out.println("==================3");
	  log.resetParameter();
  log.setRelatedId(1);
  log.setRelatedName(""+SystemEnv.getHtmlLabelName(70,user.getLanguage()));
  log.setOperateType("2");
  log.setOperateDesc("DocSysDefault_Update");
  log.setOperateItem("7");
  log.setOperateUserid(userid);
  log.setClientAddress(request.getRemoteAddr());
  log.setSysLogInfo();
  
  DocMouldComInfo.setUserDefDocMouldID(docdefmouldid);
  DocMouldComInfo.removeDocMouldCache() ;
  MouldManager.removeDefaultMouldCache() ;
}
  /* 2004-05-10 �����޸ģ����ĵ�Ĭ����ʾģ����л��洦��*/
  

  response.sendRedirect("/docs/tools/DocSysDefaults.jsp?saved=true");
%>
