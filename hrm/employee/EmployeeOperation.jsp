<%@ page import="java.security.*,weaver.general.Util" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%

String signed = Util.null2String(request.getParameter("signed"));//�ж��Ƿ��������ܼ�����ɣ���������
String hrmid = request.getParameter("hrmid");

if(signed.equals("1")){
    //����������ܼ�����ɣ���ô���ж����ݿ����Ƿ����е����Ѿ����óɹ��������ǣ���ô˵�����ܼ���㣬Ӧ�÷��ز���ʾ��
    //���ȷʵ�Ѿ����е���Ŀ�����óɹ�����״̬������Ϊ1����������Ա���оͲ����и�Ա����
     RecordSet.executeProc("Employee_SetAll",hrmid); 
     RecordSet.next();
     String isfinish = RecordSet.getString(1);
     if(isfinish.equals("-1")){
        response.sendRedirect("/hrm/employee/EmployeeManage.jsp?isfinish=30&hrmid="+hrmid);
     }
     else{
         response.sendRedirect("/hrm/employee/EmployeeView.jsp?hrmid="+hrmid);
     }
}
else{
char flag = 2;
String ProcPara = "";
String method = request.getParameter("method");


String loginid = Util.fromScreen(request.getParameter("loginid"),user.getLanguage());
String password = Util.fromScreen(request.getParameter("password"),user.getLanguage());
if(!password.equals("novalue$1")){
password= Util.getEncrypt(Util.fromScreen(request.getParameter("password"),user.getLanguage()));
}

//���ø����ʻ�������

String email = Util.fromScreen(request.getParameter("email"),user.getLanguage());
String emailpassword = Util.fromScreen(request.getParameter("emailpassword"),user.getLanguage());
//�����ʼ��ʻ�������

String textfile1=Util.fromScreen(request.getParameter("textfile1"),user.getLanguage());
String textfile2=Util.fromScreen(request.getParameter("textfile2"),user.getLanguage());
String telephone=Util.fromScreen(request.getParameter("telephone"),user.getLanguage());
String businesscard=Util.fromScreen(request.getParameter("businesscard"),user.getLanguage());

if (method.equals("login"))
{
	ProcPara =  loginid;
	ProcPara += flag + password;
    ProcPara += flag + hrmid;

    RecordSet.executeProc("Employee_LoginUpdate",ProcPara);
    RecordSet.next();
    String idadd = RecordSet.getString(1);
    //response.sendRedirect("/hrm/employee/EmployeeManage.jsp?hrmid="+hrmid);
    //��½����ͻ
    if(idadd.equals("-1")){
     response.sendRedirect("/hrm/employee/EmployeeEdit.jsp?msgid=30&id=1&hrmid="+hrmid+"&loginid="+loginid);
    }
}
if (method.equals("email"))
{
	ProcPara =  email;
	ProcPara += flag +  emailpassword;
	ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_EmaiUpdate",ProcPara);   
}
if (method.equals("cardedit"))
{
	ProcPara =  textfile1;
	ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_CardUpdate",ProcPara); 
}
if (method.equals("seatnum"))
{
	ProcPara =  textfile2;
	ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_SeatUpdate",ProcPara); 
}
if (method.equals("telephoneset"))
{
	ProcPara =  telephone;
	ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_TeleUpdate",ProcPara); 
}
if (method.equals("businesscardset"))
{
	ProcPara =  businesscard;
	ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_BusiCardUpdate",ProcPara); 

}
if (method.equals("cpt"))
{
    String id = request.getParameter("id");
	ProcPara =  id;
    ProcPara += flag + hrmid;
	RecordSet.executeProc("Employee_CptUpdate",ProcPara); 
}

response.sendRedirect("/hrm/employee/EmployeeManage.jsp?hrmid="+hrmid);

}//else ����if(!(signed.equals("1")))
%>