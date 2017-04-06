<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="SendMail" class="weaver.hrm.resource.SendMail" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />

<%
User user = HrmUserVarify.getUser (request , response);
if(user == null)  return ;
int id= Util.getIntValue(request.getParameter("id"),0);
int applyid=Util.getIntValue(request.getParameter("applyid"),0);
String issearch = Util.null2String(request.getParameter("issearch"));
int pagenum=Util.getIntValue(request.getParameter("pagenum"),0);  //��Ա��Ⱥ��ʱ

int mailid= Util.getIntValue(request.getParameter("mailid"),0);//��ð�ʽid
String selfComment=Util.null2String(request.getParameter("selfComment"));//�û��������ʼ���������

String subject = Util.null2String(request.getParameter("subject"));//�ʼ�subject
String from = Util.null2String(request.getParameter("from"));      //�����˵�ַ

/* ��Ϊ�û��������ʼ����ĺͲ��ð�ʽ���ַ�ʽ,ÿ�ַ�ʽҪ�ǵ����Բ�ͬ��4�����*/
if(mailid==0){//�����ð�ʽʱ�����ı��������ż����ݵ����

	SendMail.setSelfComment(selfComment);
	SendMail.setSubject(subject);
	SendMail.setFrom(from);
	if(issearch.equals("1"))//��ĳ��Ա�����ʼ�
		{
			if(!SearchClause.getWhereClause().equals(""))
				RecordSet.executeSql("select id from HrmResource where "+SearchClause.getWhereClause());
			else 
				RecordSet.executeSql("select id from HrmResource");
				while(RecordSet.next())
					{
						SendMail.setHRMId(RecordSet.getInt("id"));
						SendMail.SendHtmlMail2(request);	
					}
		}
	else if(id!=0&&id!=(-1))//��ĳ��Ա�����ʼ�
		{
			SendMail.setHRMId(id);
			SendMail.SendHtmlMail2(request);
			response.sendRedirect("HrmResource.jsp?id="+id);
			return;
		}
	else if(pagenum!=0&&pagenum!=(-1))//��һ��ӦƸ�߷��ʼ�
		{	
			
			if(!SearchClause.getWhereClause().equals("")){
				RecordSet.executeSql("select id from HrmCareerApply "+SearchClause.getWhereClause());
				while(RecordSet.next())
					{
						SendMail.setApplyId(RecordSet.getInt("id"));
						SendMail.SendHtmlMailApply2(request);
						
						
					}
			}
			else{ 
				RecordSet.executeSql("select id from HrmCareerApply");
				while(RecordSet.next())
					{
						SendMail.setApplyId(RecordSet.getInt("id"));
						SendMail.SendHtmlMailApply2(request);				
					}
			}
	        response.sendRedirect("/hrm/career/HrmCareerApplyResult.jsp?pagenum="+pagenum);
			return;
		}
	
    else if(applyid!=0&&applyid!=(-1))//��ĳ��ӦƸ�߷��ʼ�
		{   
			SendMail.setApplyId(applyid);
			SendMail.SendHtmlMailApply2(request);
			response.sendRedirect("/hrm/career/HrmCareerApplyEdit.jsp?applyid="+applyid);
			return;
		}

}else//���ð�ʽʱ���
{
		SendMail.setMailId(mailid);
		SendMail.setSubject(subject);
		SendMail.setFrom(from);
		if(issearch.equals("1"))//��ĳ��Ա�����ʼ�
			{
				if(!SearchClause.getWhereClause().equals(""))
				RecordSet.executeSql("select id from HrmResource where "+SearchClause.getWhereClause());
				else 
				RecordSet.executeSql("select id from HrmResource");
				while(RecordSet.next()){
				SendMail.setHRMId(RecordSet.getInt("id"));
				SendMail.SendHtmlMail(request);	
			}
		}
		else if(id!=0&&id!=(-1))//��ĳ��Ա�����ʼ�
			{
				SendMail.setHRMId(id);
				SendMail.SendHtmlMail(request);
				response.sendRedirect("HrmResource.jsp?id="+id);
				return;
			}
		else if(pagenum!=0&&pagenum!=(-1))//��һ��ӦƸ���ʼ�
		{	
			if(!SearchClause.getWhereClause().equals("")){
				RecordSet.executeSql("select id from HrmCareerApply "+SearchClause.getWhereClause());
				while(RecordSet.next())
					{
						SendMail.setApplyId(RecordSet.getInt("id"));
						SendMail.SendHtmlMailApply(request);
					}}
				else{
				RecordSet.executeSql("select id from HrmCareerApply");
				while(RecordSet.next())
					{
						SendMail.setApplyId(RecordSet.getInt("id"));
						SendMail.SendHtmlMailApply(request);
						
					}
			}
			response.sendRedirect("/hrm/career/HrmCareerApplyResult.jsp?pagenum="+pagenum);
			return;
		}
		else if(applyid!=0&&applyid!=(-1))//��ĳ��ӦƸ�߷��ʼ�
		{
			SendMail.setApplyId(applyid);
			SendMail.SendHtmlMailApply(request);
			response.sendRedirect("/hrm/career/HrmCareerApplyEdit.jsp?applyid="+applyid);
			return;
		}
}
response.sendRedirect("/hrm/search/HrmResourceSearchResult.jsp?hassql=1");
%>