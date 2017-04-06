<%@ page import = "weaver.general.Util" %>
<%@ page import = "weaver.conn.*" %>
<jsp:useBean id = "RecordSet" class = "weaver.conn.RecordSet" scope = "page"/>
<jsp:useBean id = "log" class = "weaver.systeminfo.SysMaintenanceLog" scope = "page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file = "/systeminfo/init.jsp" %>

<%
String opera = Util.null2String(request.getParameter("operation")) ; //��������
char separator = Util.getSeparator() ; 
String procedurepara = "" ; 
int id = Util.getIntValue(request.getParameter("id") , 0) ; //

String diffname = Util.fromScreen(request.getParameter("diffname") , user.getLanguage()) ; //���
String diffdesc = Util.fromScreen(request.getParameter("diffdesc") , user.getLanguage()) ; //˵��
String difftype = Util.fromScreen(request.getParameter("difftype") , user.getLanguage()) ; //�䶯
String color = Util.fromScreen(request.getParameter("color") , user.getLanguage()) ; //��ʾ��ɫ

String diffremark = Util.fromScreen(request.getParameter("diffremark") , user.getLanguage()) ; //��ע
String salaryable = Util.fromScreen(request.getParameter("salaryable") , user.getLanguage()) ; //н�ʼ���
String counttype = Util.fromScreen(request.getParameter("counttype") , user.getLanguage()) ; //н�ʼ��㷽ʽ
String countnum = Util.fromScreen(request.getParameter("countnum") , user.getLanguage()) ; //����ֵ

String salaryitem = Util.fromScreen(request.getParameter("salaryitem") , user.getLanguage()) ; //��׼������
String mindifftime = Util.fromScreen(request.getParameter("mindifftime") , user.getLanguage()) ; //��С����ʱ��
String difftime = Util.fromScreen(request.getParameter("difftime") , user.getLanguage()) ; //���ʱ��
String timecounttype = Util.fromScreen(request.getParameter("timecounttype") , user.getLanguage()) ;
String diffscope = Util.fromScreen(request.getParameter("diffscope") , user.getLanguage()) ;  //Ӧ�÷�Χ
String subcompanyid = Util.fromScreen(request.getParameter("subcompanyid") , user.getLanguage()) ;  //�ֲ�id
/* 
ʱ����㷽ʽ �� ��ԭ�й�����id�ֶν��д洢:
1 :�Կ���ʱ�����
2 :�Դ�ʱ�����
3 :�Խϴ�ʱ�����
4 :�Խ�Сʱ�����
*/

if(opera.equals("insert")){//�½�
	if(!HrmUserVarify.checkUserRight("HrmScheduleDiffAdd:Add" , user)){ 
    		response.sendRedirect("/notice/noright.jsp") ; 
    		return ; 
	} 
	//procedurepara = diffname + separator + diffdesc + separator + difftype + separator + difftime + separator + mindifftime + separator + timecounttype + separator + salaryable + separator + counttype + separator + countnum + separator + salaryitem + separator + diffremark + separator + color ;
	if(mindifftime.equals(""))
    mindifftime="null";
    if(countnum.equals(""))
    countnum="null";
    if(salaryitem.equals(""))
    salaryitem="null";
    if(timecounttype.equals(""))
    timecounttype="null";
    String sql="insert into hrmschedulediff(diffname,diffdesc,difftype,difftime,mindifftime,salaryable,counttype,countnum,diffremark,salaryitem,color,diffscope,workflowid,subcompanyid) values('"+
                diffname+"','"+ diffdesc+"','"+difftype+"','"+ difftime+"',"+ mindifftime+",'"+ salaryable+"','"+ counttype+"',"+countnum+",'"+ diffremark+"',"+ salaryitem+
               ",'"+color+"',"+ diffscope+","+ timecounttype+","+subcompanyid+")";
    //System.out.println(sql);
    RecordSet.executeSql(sql);
    //RecordSet.executeProc("HrmScheduleDiff_Insert" , procedurepara) ;
	RecordSet.next() ; 
	id = RecordSet.getInt(1) ; 
	log.resetParameter() ; 
	log.setRelatedId(id) ; 
    log.setRelatedName(diffname) ; 
    log.setOperateType("1") ; 
//  log.setOperateDesc("HrmScheduleDiff_Insert"); 
   	log.setOperateItem("17") ; 
   	log.setOperateUserid(user.getUID()) ; 
   	log.setClientAddress(request.getRemoteAddr()) ; 
    log.setSysLogInfo() ; 
   	response.sendRedirect("HrmScheduleDiff.jsp?subcompanyid="+subcompanyid) ;
} 

if(opera.equals("save")){ //����
	if(!HrmUserVarify.checkUserRight("HrmScheduleDiffEdit:Edit" , user)){ 
    		response.sendRedirect("/notice/noright.jsp") ; 
    		return ; 
	}
    if(mindifftime.equals(""))
    mindifftime="null";
    if(countnum.equals(""))
    countnum="null";
    if(salaryitem.equals(""))
    salaryitem="null";
     if(timecounttype.equals(""))
    timecounttype="null";
    String sql="update hrmschedulediff set diffname='"+diffname+"',diffdesc='"+diffdesc+
            "', difftype='"+difftype+"',difftime='"+difftime +"',mindifftime="+mindifftime+",salaryable='"+salaryable+
            "',counttype='"+counttype+"',countnum="+countnum+",diffremark='"+diffremark+"',salaryitem="+salaryitem+
            ",color='"+color+"',diffscope="+diffscope+",workflowid="+timecounttype+" where id="+id;
    // System.out.println(sql);
    RecordSet.executeSql(sql);
    //procedurepara = id + "" + separator + diffname + separator + diffdesc + separator + difftype  + separator + difftime + separator + mindifftime + separator + timecounttype + separator + salaryable + separator + counttype + separator + countnum + separator + salaryitem + separator + diffremark + separator + color ;
    //out.println(procedurepara) ;
	//out.println(RecordSet.executeProc("HrmScheduleDiff_Update" , procedurepara)) ;
	log.resetParameter() ; 
	log.setRelatedId(id) ; 
    log.setRelatedName(diffname) ; 
  	log.setOperateType("2") ; 
//  log.setOperateDesc("HrmScheduleDiff_Insert") ; 
   	log.setOperateItem("17") ; 
   	log.setOperateUserid(user.getUID()) ; 
   	log.setClientAddress(request.getRemoteAddr()) ; 
   	log.setSysLogInfo() ; 
  	response.sendRedirect("HrmScheduleDiff.jsp?subcompanyid="+subcompanyid) ;
} 

if(opera.equals("delete")){ //ɾ��
	if(!HrmUserVarify.checkUserRight("HrmScheduleDiffEdit:Delete" , user)){ 
    		response.sendRedirect("/notice/noright.jsp") ; 
    		return ; 
	} 
	RecordSet.executeProc("HrmScheduleDiff_Delete" , id + "") ;
    RecordSet.executeSql("delete hrmschedulemonth where difftype="+id);
    log.resetParameter() ;
	log.setRelatedId(id) ; 
    log.setRelatedName(diffname) ; 
   	log.setOperateType("3") ; 
//  log.setOperateDesc("HrmScheduleDiff_Insert") ; 
   	log.setOperateItem("17") ; 
   	log.setOperateUserid(user.getUID()) ; 
   	log.setClientAddress(request.getRemoteAddr()) ; 
   	log.setSysLogInfo() ; 
   	response.sendRedirect("HrmScheduleDiff.jsp?subcompanyid="+subcompanyid) ;
} 
%>