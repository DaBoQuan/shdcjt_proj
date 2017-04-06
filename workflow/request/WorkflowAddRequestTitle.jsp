<%@ page import="weaver.general.*,weaver.conn.*,java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %> 

<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="flowDoc" class="weaver.workflow.request.RequestDoc" scope="page"/>


<%	

//��ù������Ļ�����Ϣ
String workflowid = Util.null2String(request.getParameter("workflowid"));
String workflowtype = Util.null2String(request.getParameter("workflowtype"));
String nodeid= Util.null2String(request.getParameter("nodeid")) ;
String formid= Util.null2String(request.getParameter("formid")) ;
String workflowname = WorkflowComInfo.getWorkflowname(workflowid);
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //???????????
String isbill = "1" ;
int helpdocid = Util.getIntValue(request.getParameter("helpdocid"),0);
int messageType= Util.getIntValue(request.getParameter("messageType"),0);
int defaultName= Util.getIntValue(request.getParameter("defaultName"),0);
String docCategory= Util.null2String(request.getParameter("docCategory")) ;

//��õ�ǰ�û���id�����ͺ����ơ��������Ϊ1����ʾΪ�ڲ��û���������Դ����2Ϊ�ⲿ�û���CRM��
int userid = user.getUID();
String logintype = user.getLogintype();
String username = "";
if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());


//�Բ�ͬ��ģ����˵,���Զ����Լ���ص����ݣ���Ϊ����Ĭ��ֵ�����罫 docid ��ֵ����Ϊ�������Ĭ���ĵ�
//Ĭ�ϵ�ֵ���Ը�������м��ö��Ÿ�

String prjid = Util.null2String(request.getParameter("prjid"));
String docid = Util.null2String(request.getParameter("docid"));
String crmid = Util.null2String(request.getParameter("crmid"));
String hrmid = Util.null2String(request.getParameter("hrmid"));
String reqid = Util.null2String(request.getParameter("reqid"));
if(hrmid.equals("") && logintype.equals("1")) hrmid = "" + userid ;
if(crmid.equals("") && logintype.equals("2")) crmid = "" + userid ;

//������������ɺ󽫷��ص�ҳ��
String topage = Util.null2String(request.getParameter("topage"));


//��õ�ǰ�����ں�ʱ��
String currentdate = Util.null2String(request.getParameter("currentdate"));
String currenttime = Util.null2String(request.getParameter("currenttime"));


//�����ύ��ʱ����Ҫ��������ֶ���������������ö��Ÿ񿪣�requestnameΪ�½������е�һ�е�����˵������ÿһ�����󶼱����е�
String needcheck="requestname";

//��ʼ���ںͽ������ڱȽ���
String newfromdate="a";
String newenddate="b";
%>