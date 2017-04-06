<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="SysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page" />

<%
String CurrentUser = ""+user.getUID();
String CurrentUserName = ""+user.getUsername();
String SubmiterType = ""+user.getLogintype();
String ClientIP = request.getRemoteAddr();

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

String Sql="";

char flag = 2;
String ProcPara = "";

String method = Util.null2String(request.getParameter("method"));
String meetingid=Util.null2String(request.getParameter("meetingid"));
String recorderid=Util.null2String(request.getParameter("recorderid"));
String isattend=Util.null2String(request.getParameter("isattend"));
String begindate=Util.null2String(request.getParameter("begindate"));
String begintime=Util.null2String(request.getParameter("begintime"));
String enddate=Util.null2String(request.getParameter("enddate"));
String endtime=Util.null2String(request.getParameter("endtime"));
String bookroom=Util.null2String(request.getParameter("bookroom"));
String roomstander=Util.null2String(request.getParameter("roomstander"));
String bookticket=Util.null2String(request.getParameter("bookticket"));
String ticketstander=Util.null2String(request.getParameter("ticketstander"));
String othermember=Util.null2String(request.getParameter("othermember"));

if(method.equals("edit"))
{
	ProcPara =  recorderid;
	ProcPara += flag + isattend;
	ProcPara += flag + begindate;
	ProcPara += flag + begintime;
	ProcPara += flag + enddate;
	ProcPara += flag + endtime;
	ProcPara += flag + bookroom;
	ProcPara += flag + roomstander;
	ProcPara += flag + bookticket;
	ProcPara += flag + ticketstander;
	ProcPara += flag + othermember;

	RecordSet.executeProc("Meeting_Member2_Update",ProcPara);

	RecordSet.executeProc("Meeting_MemberCrm_Delete",recorderid);

	int membercrmrows=Util.getIntValue(Util.null2String(request.getParameter("membercrmrows")),0);
	for(int i=0;i<membercrmrows;i++){
		String name=Util.null2String(request.getParameter("name_"+i));
		String sex=Util.null2String(request.getParameter("sex_"+i));
		String occupation=Util.null2String(request.getParameter("occupation_"+i));
		String tel=Util.null2String(request.getParameter("tel_"+i));
		String handset=Util.null2String(request.getParameter("handset_"+i));
		String desc=Util.null2String(request.getParameter("desc_"+i));
		if(!name.equals("")){
			ProcPara =  meetingid;
			ProcPara += flag + recorderid;
			ProcPara += flag + name;
			ProcPara += flag + sex;
			ProcPara += flag + occupation;
			ProcPara += flag + tel;
			ProcPara += flag + handset;
			ProcPara += flag + desc;

			RecordSet.executeProc("Meeting_MemberCrm_Insert",ProcPara);	
		}
	}

		String SWFTitle="";
		String SWFRemark="";
		String SWFSubmiter="";
		String SWFAccepter="";

		SWFAccepter="";
		Sql="select * from Meeting where id="+meetingid;
		RecordSet.executeSql(Sql);
		while(RecordSet.next()){
			SWFAccepter=RecordSet.getString("contacter");
			String strtmp = Util.toScreen("�����ִ:",user.getLanguage(),"0"); //����
			SWFTitle=Util.toScreen(strtmp+RecordSet.getString("name"),user.getLanguage());
			SWFTitle += "-"+CurrentUserName;
			SWFTitle += "-"+CurrentDate;
		}
		if(!SWFAccepter.equals("") && !SWFAccepter.equals(CurrentUser)){
		SWFRemark="";
		SWFSubmiter=CurrentUser;
		SysRemindWorkflow.setMeetingSysRemind(SWFTitle,Util.getIntValue(meetingid),Util.getIntValue(SWFSubmiter),SWFAccepter,SWFRemark);	
		}
}
%>
<script language=VBS>

     window.parent.returnvalue = Array("","")
     window.parent.close

</script>


