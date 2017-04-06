<%--���տͻ����ύ�Ĳ������ݣ��������ʽת��Ϊ����������ҳ������Ҫ�ĸ�ʽ����Ҫ�ǹ�������������Ϣ�ĸ�ʽ--%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="RequestDataPost" class="weaver.workflow.request.RequestDataPost" scope="page" />

<%

//��ù������Ļ�����Ϣ
String workflowid = Util.null2String(request.getParameter("workflowid"));   //������

//�Ӳ����л���û���Ϣ����Ϊ�ͻ����ύ��POST���󲢲�֧��session
int userid = Util.getIntValue(request.getParameter("userid"));  //������
String logintype = Util.null2String(request.getParameter("logintype")); //������

//��������������ƣ�Ҳ���ǹ�������ʾҳ���е�˵���ֶΣ�����ֶ�Ϊ�����ֶ�
String requestname = Util.null2String(request.getParameter("requestname")); //������

//������Ҳ���ǹ�������ʾҳ���ϵģ����� ��ҳ ���⣩ѡ��
String requestlevel = Util.null2String(request.getParameter("requestlevel")); //������

//�õ��û�������
String username = "";
if(logintype.equals("1"))
	username = ResourceComInfo.getResourcename(""+userid);
if(logintype.equals("2"))
	username = CustomerInfoComInfo.getCustomerInfoname(""+userid);

//����û��Ƿ��д���Ȩ��
RequestCheckUser.setUserid(userid);
RequestCheckUser.setWorkflowid(Util.getIntValue(workflowid,0));
RequestCheckUser.setLogintype(logintype);
RequestCheckUser.checkUser();
int  hasright=RequestCheckUser.getHasright();

//���û��Ȩ����ô�򷵻ص�����д��false�ַ�������ʶ����ʧ��
if(hasright==0){
    //out.println("false:û�д���Ȩ��");
    //return;
}

String nodeid= "" ;
String formid= "" ;
String isbill="0";

//��ѯ�ù������ı�id���Ƿ��ǵ��ݣ�0��1�ǣ�
RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid);
if(RecordSet.next()){
	formid = Util.null2String(RecordSet.getString("formid"));
	isbill = ""+Util.getIntValue(RecordSet.getString("isbill"),0);
}

//��Ϊ���ܴ���������������������ǵ��ݵĻ�����ô���ش�����Ϣ
if(isbill.equals("1")){
    out.print("1");
    return;
}

//��ѯ�ù������ĵ�ǰ�ڵ�id �����Ĺ������Ĵ����ڵ� ��
RecordSet.executeProc("workflow_CreateNode_Select",workflowid);
if(RecordSet.next())  nodeid = Util.null2String(RecordSet.getString(1)) ;

//�Բ�ͬ��ģ����˵,���Զ����Լ���ص����ݣ���Ϊ����Ĭ��ֵ�����罫 docid ��ֵ����Ϊ�������Ĭ���ĵ�
//Ĭ�ϵ�ֵ���Ը�������м��ö��Ÿ�
String prjid = Util.null2String(request.getParameter("prjid"));
String docid = Util.null2String(request.getParameter("docid"));
String crmid = Util.null2String(request.getParameter("crmid"));
String hrmid = Util.null2String(request.getParameter("hrmid"));
if(hrmid.equals("") && logintype.equals("1")) hrmid = "" + userid ;
if(crmid.equals("") && logintype.equals("2")) crmid = "" + userid ;

//��õ�ǰ�����ں�ʱ��
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String currenttime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                     Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                     Util.add0(today.get(Calendar.SECOND), 2) ;

%>



<%
//�洢�ֶ����ƺ��ֶ�id��ӳ��

//�洢���ֶ�ӳ��
ArrayList fieldids = new ArrayList();
ArrayList fieldNames = new ArrayList();
//�洢��ϸ�ֶ�ӳ��
ArrayList detailFieldids = new ArrayList();
ArrayList detailFieldNames = new ArrayList();

//�õ����ֶ�����
String selectSql = "SELECT a.fieldid, b.fieldname FROM workflow_formfield a, workflow_formdict b WHERE a.fieldid=b.id and (a.isdetail<>'1' or a.isdetail is null) and a.formid="+formid;
RecordSet.executeSql(selectSql);
while(RecordSet.next()){
    fieldids.add(RecordSet.getString(1));
    fieldNames.add(RecordSet.getString(2));
}

//�õ���ϸ�ֶ�����
selectSql = "SELECT a.fieldid, b.fieldname FROM workflow_formfield a, workflow_formdictdetail b WHERE a.fieldid=b.id and a.isdetail='1' and a.formid="+formid;
RecordSet.executeSql(selectSql);
while(RecordSet.next()){
    detailFieldids.add(RecordSet.getString(1));
    detailFieldNames.add(RecordSet.getString(2));
}

//���ô�����������Ҫ�ı�Ҫ�Ĳ���
RequestDataPost.setParam("userid",""+userid);
RequestDataPost.setParam("logintype",logintype);
RequestDataPost.setParam("src","submit");
RequestDataPost.setParam("iscreate","1");
RequestDataPost.setParam("workflowid",workflowid);
RequestDataPost.setParam("requestlevel",requestlevel);
RequestDataPost.setParam("formid",formid);
RequestDataPost.setParam("isbill","0");
RequestDataPost.setParam("nodeid",nodeid);
RequestDataPost.setParam("nodetype","0");
RequestDataPost.setParam("requestname",requestname);
RequestDataPost.setParam("remark","<br>"+username+" "+currentdate+" "+currenttime);

//ת�����ֶεĲ�������Ϊ�ڲ����ݹ�������Ҫ�����Ƹ�ʽ
String fieldValue = "";
for(int i=0; i<fieldNames.size(); i++){
    if((fieldValue = request.getParameter("field_"+fieldNames.get(i))) != null){
        RequestDataPost.setParam("field"+fieldids.get(i),fieldValue);
    }
}

//�õ���ϸ���ݵ�����
int nodesnum = Util.getIntValue(request.getParameter("nodesnum"));
RequestDataPost.setParam("nodesnum",""+nodesnum);

//ת����ϸ�ֶεĲ�������Ϊ�ڲ����ݹ�������Ҫ�����Ƹ�ʽ
for(int i=0; i<nodesnum; i++){
    for(int j=0; j<detailFieldNames.size(); j ++){
        if((fieldValue = request.getParameter("field_"+detailFieldNames.get(j)+"_"+i)) != null){
            RequestDataPost.setParam("field"+detailFieldids.get(j)+"_"+i,fieldValue);
        }
    }
}
String serverPage = "http://"+request.getServerName()+"/workflow/request/RequestOutOperation.jsp";

out.print(RequestDataPost.doPost(serverPage));
%>
