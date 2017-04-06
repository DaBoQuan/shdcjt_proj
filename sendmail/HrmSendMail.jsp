<%@ page import="weaver.general.Util,
                 java.sql.Timestamp" %>
<jsp:useBean id="SendMail" class="weaver.general.SendMail" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="JobTitlesComInfo1" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="JobGroupsComInfo1" class="weaver.hrm.job.JobGroupsComInfo" scope="page" />
<jsp:useBean id="JobActivitiesComInfo1" class="weaver.hrm.job.JobActivitiesComInfo" scope="page" />
<jsp:useBean id="CostCenterComInfo1" class="weaver.hrm.company.CostCenterComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo1" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ContacterTitleComInfo1" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page" />
<jsp:useBean id="SystemComInfo" class="weaver.system.SystemComInfo" scope="page" />
<jsp:useBean id="hr" class="java.util.Hashtable" scope="page" />

<jsp:useBean id="HrmSearchComInfo" class="weaver.hrm.search.HrmSearchComInfo" scope="session" />
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%
int id= Util.getIntValue(request.getParameter("id"),0);
int applyid=Util.getIntValue(request.getParameter("applyid"),0);
String issearch = Util.null2String(request.getParameter("issearch"));
int pagenum=Util.getIntValue(request.getParameter("pagenum"),0);  //��Ա��Ⱥ��ʱ

String fromPage = Util.null2String(request.getParameter("fromPage")).trim();

int mailid= Util.getIntValue(request.getParameter("mailid"),0);//��ð�ʽid
String selfComment=Util.fromScreen(request.getParameter("selfComment"),user.getLanguage());//�û��������ʼ���������

String subject = Util.null2String(request.getParameter("subject"));//�ʼ�subject
String from = Util.null2String(request.getParameter("from"));      //�����˵�ַ

//add by wjy
String nothrmids = Util.null2String(request.getParameter("nothrmids")); //����ѡ���ų����ʼ�������
String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));
String fromdate = Util.null2String(request.getParameter("fromdate"));
String fromtime = Util.null2String(request.getParameter("fromtime"));

    Date newdate = new Date() ;
    long datetime = newdate.getTime() ;
    Timestamp timestamp = new Timestamp(datetime) ;
    String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
    String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

    fromdate = (fromdate.equals("")?CurrentDate:fromdate); //�ƻ��������ڣ������д�򰴵�ǰ����
    fromtime = (fromtime.equals("")?CurrentTime:fromtime); //�ƻ�����ʱ�䣬�����д�򰴵�ǰʱ��
//add end by wjy

// ��Ⱥ���ʼ����иĽ��� ������Ⱥ���ʼ���֤���ֵĹ���
String defmailserver = SystemComInfo.getDefmailserver() ;
String defneedauth = SystemComInfo.getDefneedauth() ;
String defmailuser = SystemComInfo.getDefmailuser() ;
String defmailpassword = SystemComInfo.getDefmailpassword() ;

SendMail.setMailServer(defmailserver) ;
if( defneedauth.equals("1") ) {
    SendMail.setNeedauthsend(true) ;
    SendMail.setUsername(defmailuser) ;
    SendMail.setPassword(defmailpassword) ;
}
else SendMail.setNeedauthsend(false) ;
// ��Ⱥ���ʼ����иĽ�����

String email = "" ;
String to = "" ;
String cc = "" ;
String bcc = "" ;
int char_set = 3 ;
String priority = "3" ;
String tempto = "";
String tempto2 = "";
String nothrmid = ""; //���ų����ʼ�������

String  nextpageur1 = "" ;
String succeed = "" ;

/* ��Ϊ�û��������ʼ����ĺͲ��ð�ʽ���ַ�ʽ,ÿ�ַ�ʽҪ�ǵ����Բ�ͬ��4�����*/
boolean sendok = false;


if(mailid==0) {   //�����ð�ʽʱ�����ı��������ż����ݵ����

    if(issearch.equals("1"))  {  //��ĳ��Ա�����ʼ�
        nextpageur1="/hrm/search/HrmResourceSearchResult.jsp?hassql=1";

        if(!HrmSearchComInfo.FormatSQLSearch().equals(""))
            rs.executeSql("select email,id from HrmResource  "+HrmSearchComInfo.FormatSQLSearch());
        else
            rs.executeSql("select email,id from HrmResource");
        int i=0 ;
        to = "" ;
        String body = selfComment ;
        int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"1") ;
        while(rs.next()){
            tempto = Util.null2String(rs.getString(1)) ;
            nothrmid = Util.null2String(rs.getString(2)) ;
            if(nothrmids.indexOf(nothrmid)!=-1){
                continue;
            }
            System.out.println("tempto = " + tempto);
            if( !tempto.equals("") && Util.isEmail(tempto)){
                to = tempto;

                sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,nothrmid) ;
            }
        }
	}
	else if(id!=0&&id!=(-1))  {  //��ĳ��Ա�����ʼ�
        nextpageur1="/hrm/resource/HrmResource.jsp?id="+id;
        rs.executeSql("select email,id from HrmResource where id="+id);
        if(rs.next()) {
            tempto = Util.null2String(rs.getString(1)) ;
            tempto2 = Util.null2String(rs.getString(2)) ;
        }
        if( !tempto.equals("") && Util.isEmail(tempto)) to = tempto;

        if(to.length()!=0) {
            String body = selfComment ;
            int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"1") ;
            sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,tempto2) ;
            succeed = to ;
        }
	}
    else if(applyid!=0 && applyid!=(-1)) {    //��ĳ��ӦƸ�߷��ʼ�
        nextpageur1="/hrm/career/HrmCareerApplyEdit.jsp?applyid="+applyid;

        rs.executeSql("select email,id from HrmCareerApply where id="+applyid);
        if(rs.next()) {
            tempto = Util.null2String(rs.getString(1)) ;
            tempto2 = Util.null2String(rs.getString(2)) ;
        }
        if( !tempto.equals("") && Util.isEmail(tempto)) to = tempto;

        if(to.length()!=0) {
            String body = selfComment ;
            int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"2") ;
            sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,tempto2) ;
            succeed = to ;
        }
    }
}

else   { //���ð�ʽʱ���
    if(issearch.equals("1")) {   //��ĳ��Ա�����ʼ�
        nextpageur1="/hrm/search/HrmResourceSearchResult.jsp?hassql=1";
        String subject1 = subject;
        String body = "";

        String sql = "select mouldtext from DocMailMould where id="+mailid ;
        rs.executeSql(sql);
        if(rs.next()){
            body = Util.null2String(rs.getString(1));

        }
        int pos = body.indexOf("<IMG alt=");
        while(pos!=-1){
            pos = body.indexOf("?fileid=",pos);
            int endpos = body.indexOf("\"",pos);
            String tmpid = body.substring(pos+8,endpos);
            int startpos = body.lastIndexOf("\"",pos);
            String servername = request.getServerName();
            String tmpcontent = body.substring(0,startpos+1);
            tmpcontent += "http://"+servername;
            tmpcontent += body.substring(startpos+1);
            body = tmpcontent;
            pos = body.indexOf("<IMG alt=",endpos);
        }

        if(!HrmSearchComInfo.FormatSQLSearch().equals(""))
            rs.executeSql("select * from HrmResource "+HrmSearchComInfo.FormatSQLSearch());
        else
            rs.executeSql("select * from HrmResource");

        int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"1") ;
        while(rs.next()){
            tempto = Util.null2String(rs.getString("email")) ;
            tempto2 = Util.null2String(rs.getString("id")) ;
            if( !tempto.equals("") && Util.isEmail(tempto)) {
                to = tempto  ;

                hr.put("HRM_Loginid",""+rs.getString("loginid"));
                hr.put("HRM_Name",""+rs.getString("name"));
                hr.put("HRM_Title",""+ContacterTitleComInfo1.getContacterTitlename(rs.getString("titleid")));
                hr.put("HRM_Birthday",""+rs.getString("birthday"));
                hr.put("HRM_Telephone",""+rs.getString("telephone"));
                hr.put("HRM_Email",""+rs.getString("email"));
                hr.put("HRM_Startdate",""+rs.getString("startdate"));
                hr.put("HRM_Enddate",""+rs.getString("enddate"));
                hr.put("HRM_Contractdate",""+rs.getString("contractdate"));
                hr.put("HRM_Jobtitle",""+JobTitlesComInfo1.getJobTitlesname(rs.getString("jobtitle")));
                hr.put("HRM_Jobgroup",""+JobGroupsComInfo1.getJobGroupsname(rs.getString("jobgroup")));
                hr.put("HRM_Jobactivity",""+JobActivitiesComInfo1.getJobActivitiesname(rs.getString("jobactivity")));
                hr.put("HRM_Jobactivitydesc",""+rs.getString("jobactivitydesc"));
                hr.put("HRM_Joblevel",""+rs.getString("joblevel"));
                hr.put("HRM_Seclevel",""+rs.getString("seclevel"));
                hr.put("HRM_Department",""+DepartmentComInfo1.getDepartmentname(rs.getString("departmentid")));
                hr.put("HRM_Costcenter",""+CostCenterComInfo1.getCostCentername(rs.getString("costcenterid")));
                hr.put("HRM_Manager",""+ResourceComInfo1.getResourcename(rs.getString("managerid")));
                hr.put("HRM_Assistant",""+ResourceComInfo1.getResourcename(rs.getString("assistantid")));

                String tempbody = Util.toScreen(Util.fillValuesToString(body,hr),user.getLanguage()) ;
                String tempsubject = Util.fromScreen2(Util.fillValuesToString(subject,hr),user.getLanguage());

                sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,tempto2) ;
                succeed = succeed + to + "," ;

            }
        }
    }
    else if(id!=0&&id!=(-1))   { //��ĳ��Ա�����ʼ�
        nextpageur1="/hrm/resource/HrmResource.jsp?id="+id;
        rs.executeSql("select * from HrmResource where id="+id);
        if(rs.next()) {
            tempto = Util.null2String(rs.getString("email")) ;
            tempto2 = Util.null2String(rs.getString("id")) ;
            if( !tempto.equals("") && Util.isEmail(tempto)) {
                to = tempto;
                hr.put("HRM_Loginid",""+rs.getString("loginid"));
                hr.put("HRM_Name",""+rs.getString("name"));
                hr.put("HRM_Title",""+ContacterTitleComInfo1.getContacterTitlename(rs.getString("titleid")));
                hr.put("HRM_Birthday",""+rs.getString("birthday"));
                hr.put("HRM_Telephone",""+rs.getString("telephone"));
                hr.put("HRM_Email",""+rs.getString("email"));
                hr.put("HRM_Startdate",""+rs.getString("startdate"));
                hr.put("HRM_Enddate",""+rs.getString("enddate"));
                hr.put("HRM_Contractdate",""+rs.getString("contractdate"));
                hr.put("HRM_Jobtitle",""+JobTitlesComInfo1.getJobTitlesname(rs.getString("jobtitle")));
                hr.put("HRM_Jobgroup",""+JobGroupsComInfo1.getJobGroupsname(rs.getString("jobgroup")));
                hr.put("HRM_Jobactivity",""+JobActivitiesComInfo1.getJobActivitiesname(rs.getString("jobactivity")));
                hr.put("HRM_Jobactivitydesc",""+rs.getString("jobactivitydesc"));
                hr.put("HRM_Joblevel",""+rs.getString("joblevel"));
                hr.put("HRM_Seclevel",""+rs.getString("seclevel"));
                hr.put("HRM_Department",""+DepartmentComInfo1.getDepartmentname(rs.getString("departmentid")));
                hr.put("HRM_Costcenter",""+CostCenterComInfo1.getCostCentername(rs.getString("costcenterid")));
                hr.put("HRM_Manager",""+ResourceComInfo1.getResourcename(rs.getString("managerid")));
                hr.put("HRM_Assistant",""+ResourceComInfo1.getResourcename(rs.getString("assistantid")));


                String sql = "select mouldtext from DocMailMould  where id="+mailid;

                String body = "";
                rs.executeSql(sql);
                if(rs.next()){
                    body = Util.null2String(rs.getString(1));
                }
                int pos = body.indexOf("<IMG alt=");
                while(pos!=-1){
                    pos = body.indexOf("?fileid=",pos);
                    int endpos = body.indexOf("\"",pos);
                    String tmpid = body.substring(pos+8,endpos);
                    int startpos = body.lastIndexOf("\"",pos);
                    String servername = request.getServerName();
                    String tmpcontent = body.substring(0,startpos+1);
                    tmpcontent += "http://"+servername;
                    tmpcontent += body.substring(startpos+1);
                    body=tmpcontent;
                    pos = body.indexOf("<IMG alt=",endpos);
                }

                subject = Util.fromScreen2(Util.fillValuesToString(subject,hr),user.getLanguage());
                body = Util.toScreen(Util.fillValuesToString(body,hr),user.getLanguage());
                int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"1") ;
                sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,tempto2) ;
                succeed = to ;
            }
        }
    }
    else if(applyid!=0 && applyid!=(-1)) { //��ĳ��ӦƸ�߷��ʼ�
        nextpageur1="/hrm/career/HrmCareerApplyEdit.jsp?applyid="+applyid;
        rs.executeSql("select email,id from HrmCareerApply where id="+applyid);
        if(rs.next()) {
            tempto = Util.null2String(rs.getString(1)) ;
            tempto2 = Util.null2String(rs.getString(2)) ;
        }
        if( !tempto.equals("") && Util.isEmail(tempto)) to = tempto;

        if(to.length()!=0) {
            String sql = "select mouldtext from DocMailMould  where id="+mailid;
            String body = "";
            rs.executeSql(sql);
            if(rs.next()){
                body = Util.null2String(rs.getString(1));
            }
            int pos = body.indexOf("<IMG alt=");
            while(pos!=-1){
                pos = body.indexOf("?fileid=",pos);
                int endpos = body.indexOf("\"",pos);
                String tmpid = body.substring(pos+8,endpos);
                int startpos = body.lastIndexOf("\"",pos);
                String servername = request.getServerName();
                String tmpcontent = body.substring(0,startpos+1);
                tmpcontent += "http://"+servername;
                tmpcontent += body.substring(startpos+1);
                body=tmpcontent;
                pos = body.indexOf("<IMG alt=",endpos);
            }
            rs.executeProc("HrmCareerApply_SelectById",""+applyid);
            rs.next();

            hr.put("HRM_Email",""+rs.getString("email"));

            subject = Util.fromScreen2(Util.fillValuesToString(subject,hr),user.getLanguage());
            body = Util.toScreen(Util.fillValuesToString(body,hr),user.getLanguage()) ;
            int temId = SendMail.sendhtmlMain(from,cc,bcc,char_set,priority,user,fromdate,fromtime,"2") ;
            sendok = SendMail.sendhtmlProxy(temId,to,Util.fromScreen2(subject,user.getLanguage()),body,tempto2) ;
            succeed = to ;
        }
    }
}
if(!succeed.equals("")) succeed = succeed.substring(0,succeed.length()-1);
boolean gotoWindowParent = (id!=0&&id!=(-1));
if (sendok) {
%>
<script>
    //alert("ϵͳ��ʾ��<%=succeed%>�ʼ����ͳɹ�!");
    if(<%=gotoWindowParent%> && <%=fromPage.length()>0%>){
    	window.location = decodeURIComponent("<%=fromPage%>");
    }else{
    	window.location = "<%=nextpageur1%>";
    }
</script>
<%
} else {
%>
<script>
    //alert("ϵͳ��ʾ��<%=succeed%>�ʼ�����ʧ��!");
    if(<%=gotoWindowParent%> && <%=fromPage.length()>0%>){
    	window.location = decodeURIComponent("<%=fromPage%>");
    }else{
    	window.location = "<%=nextpageur1%>";
    }
</script>
<%
}
%>