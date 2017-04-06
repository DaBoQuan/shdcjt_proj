<%@ page import="weaver.general.*,java.util.*,weaver.conn.*" %>
<%@ include file="/systeminfo/init.jsp" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="flowDoc" class="weaver.workflow.request.RequestDoc" scope="page"/>

<%
String newfromdate="a";
String newenddate="b";
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //???????????
int requestid=Util.getIntValue(request.getParameter("requestid"),0);
String requestname= "" ;   //��������
String requestlevel= Util.null2String(request.getParameter("requestlevel")) ; //������Ҫ���� 0:���� 1:��Ҫ 2:����
String requestmark = Util.null2String(request.getParameter("requestmark")) ;     //������
String isbill= "1";          //�Ƿ񵥾� 0:�� 1:��
int creater= Util.getIntValue(request.getParameter("creater"),0) ;              //����Ĵ�����
int creatertype = Util.getIntValue(request.getParameter("creatertype"),0) ;     //���������� 0: �ڲ��û� 1: �ⲿ�û�
int deleted = Util.getIntValue(request.getParameter("deleted"),0) ;  //�����Ƿ�ɾ��  1:�� 0�������� ��
int workflowid= Util.getIntValue(request.getParameter("workflowid"),0) ;           //������id
String workflowtype = Util.null2String(request.getParameter("workflowtype"));
int formid = Util.getIntValue(request.getParameter("formid"),0) ;               //�����ߵ��ݵ�id
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0) ;               //�ڵ�id
int billid = Util.getIntValue(request.getParameter("billid"),0) ;                   //��Ӧ�ĵ���id
String nodetype = Util.null2String(request.getParameter("nodetype")) ;         //�ڵ�����  0:���� 1:���� 2:ʵ�� 3:�鵵
String nextnodetype = Util.null2String(request.getParameter("nextnodetype")) ;//�ύ����һ���ڵ�����
String workflowname = WorkflowComInfo.getWorkflowname(workflowid+"");         //����������

String isreopen = Util.null2String(request.getParameter("isreopen")) ;        //�Ƿ�����ش�
String isreject = Util.null2String(request.getParameter("isreject")) ;        //�Ƿ�����˻�
int isremark = Util.getIntValue(request.getParameter("isremark"),0) ;         //��ǰ����״̬
String currentdate = Util.null2String(request.getParameter("currentdate")) ;        //�Ƿ�����ش�
String currenttime = Util.null2String(request.getParameter("currenttime")) ;        //�Ƿ�����˻�

String topage = Util.null2String(request.getParameter("topage")) ;        //���ص�ҳ��

String needcheck="requestname";


// �������½��ĵ��Ĵ���
String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
//String newdocid = Util.null2String(request.getParameter("docid"));        // �½����ĵ�
String newdocid = Util.null2String(request.getParameter("newdocid"));        // �½����ĵ�

int userid=user.getUID();                                           //��ǰ�û�id
int usertype = 0;                           //�û��ڹ��������е����� 0: �ڲ� 1: �ⲿ
String logintype = user.getLogintype();                             //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());

if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;

String sql = "" ;
char flag = Util.getSeparator() ;
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
if(RecordSet.next()){	
    requestname= Util.null2String(RecordSet.getString("requestname")) ;
}

//boolean isurger = Util.null2String(request.getParameter("isurger")).equalsIgnoreCase("true") ;
//boolean wfmonitor = Util.null2String(request.getParameter("wfmonitor")).equalsIgnoreCase("true") ;
int languageidtemp  = Util.getIntValue(request.getParameter("languageid"));
//String isrequest = Util.null2String(request.getParameter("isrequest")); 
session.setAttribute(userid+"_"+requestid+"requestname",requestname);
session.setAttribute(userid+"_"+requestid+"workflowname",workflowname);

int lastOperator=0;
String lastOperateDate="";
String lastOperateTime="";

lastOperator=Util.getIntValue((String)session.getAttribute(userid+"_"+requestid+"lastOperator"),0);
lastOperateDate=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"lastOperateDate"));
lastOperateTime=Util.null2String((String)session.getAttribute(userid+"_"+requestid+"lastOperateTime"));

%>