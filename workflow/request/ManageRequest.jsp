<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<%
// ����Ƕ����ͼ�λ��ı���ƣ�������һ��ҳ��������body����������һ����תҳ��


int requestid = Util.getIntValue(request.getParameter("requestid"),0);
String message = Util.null2String(request.getParameter("message"));  // ���صĴ�����Ϣ
String topage = Util.null2String(request.getParameter("topage")) ;        //���ص�ҳ��

// �������½��ĵ��Ĵ���
String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
String newdocid = Util.null2String(request.getParameter("docid"));        // �½����ĵ�

String actionPage = "" ;

RecordSet.executeSql("select count(a.formid) from workflow_formprop a, workflow_base b, workflow_Requestbase c where a.formid = b.formid and b.id = c.workflowid and c.requestid = "+requestid);
if(RecordSet.next() && RecordSet.getInt(1) > 0 ) actionPage = "ManageRequestForm.jsp" ;
else actionPage = "ManageRequestNoForm.jsp" ;

int userid=user.getUID();                   //��ǰ�û�id
int lastOperator=0; //��������id
String lastOperateDate="";//����������
String lastOperateTime="";//������ʱ��
// ��ѯ�������ع�����������Ϣ
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
if(RecordSet.next()){
    lastOperator = Util.getIntValue(RecordSet.getString("lastOperator"),0);
    lastOperateDate=Util.null2String(RecordSet.getString("lastOperateDate"));
    lastOperateTime=Util.null2String(RecordSet.getString("lastOperateTime"));
}

session.setAttribute(userid+"_"+requestid+"lastOperator",""+lastOperator);
session.setAttribute(userid+"_"+requestid+"lastOperateDate",lastOperateDate);
session.setAttribute(userid+"_"+requestid+"lastOperateTime",lastOperateTime);
%>

<BODY onload='manageform.submit ()'>
<FORM name=manageform method=post action='<%=actionPage%>?requestid=<%=requestid%>&message=<%=message%>&topage=<%=topage%>&docfileid=<%=docfileid%>&newdocid=<%=newdocid%>'>
    <input type="hidden" name="requestid" value="<%=requestid%>">
    <input type="hidden" name="message" value="<%=message%>">
    <input type="hidden" name="topage" value="<%=topage%>">
    <input type="hidden" name="docfileid" value="<%=docfileid%>">
    <input type="hidden" name="newdocid" value="<%=newdocid%>">
</FORM>
</BODY>
</HTML>