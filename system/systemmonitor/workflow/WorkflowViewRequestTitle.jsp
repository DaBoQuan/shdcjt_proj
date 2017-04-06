<%@ page import="weaver.general.*,java.util.*,weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<%
int requestid=Util.getIntValue(request.getParameter("requestid"),0);
int start =Util.getIntValue(request.getParameter("start"),1);
String requestname= "" ;   //��������
String requestlevel= Util.null2String(request.getParameter("requestlevel")) ; //������Ҫ���� 0:���� 1:��Ҫ 2:����
String requestmark = Util.null2String(request.getParameter("requestmark")) ;     //������
String isbill= "1";          //�Ƿ񵥾� 0:�� 1:��
int creater= Util.getIntValue(request.getParameter("creater"),0) ;              //����Ĵ�����
int creatertype = Util.getIntValue(request.getParameter("creatertype"),0) ;     //���������� 0: �ڲ��û� 1: �ⲿ�û�
int deleted = Util.getIntValue(request.getParameter("deleted"),0) ;  //�����Ƿ�ɾ��  1:�� 0�������� ��
int workflowid= Util.getIntValue(request.getParameter("workflowid"),0) ;           //������id
int formid = Util.getIntValue(request.getParameter("formid"),0) ;               //�����ߵ��ݵ�id
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0) ;               //�ڵ�id
int billid = Util.getIntValue(request.getParameter("billid"),0) ;                   //��Ӧ�ĵ���id
String nodetype = Util.null2String(request.getParameter("nodetype")) ;         //�ڵ�����  0:���� 1:���� 2:ʵ�� 3:�鵵
String workflowname = WorkflowComInfo.getWorkflowname(workflowid+"");         //����������
boolean canactive = Util.null2String(request.getParameter("canactive")).equalsIgnoreCase("true") ;         //����������

int userid=user.getUID();                                           //��ǰ�û�id
String logintype = user.getLogintype();                             //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
int usertype = 0;
if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;

String sql = "" ;
char flag = Util.getSeparator() ;
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
if(RecordSet.next()){	
    requestname= Util.null2String(RecordSet.getString("requestname")) ;
}
%>