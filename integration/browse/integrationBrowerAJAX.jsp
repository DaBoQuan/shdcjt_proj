<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%@ page import="net.sf.json.*" %>
<%
	String ygid=Util.null2String(request.getParameter("ygid"));//�õ��칹��Ʒ��id
	String mark=Util.null2String(request.getParameter("mark"));
	String opera=Util.null2String(request.getParameter("opera"));
	String type=Util.null2String(request.getParameter("type"));//type==1,��ʾ�л��칹��Ʒ������,/type==2��ʾ�л�����Դ������
	String sid="";//���ݽ�����ʽ��id
	String selecteddatasourid=Util.null2String(request.getParameter("selecteddatasourid"));//�õ�ѡ�е�����Դ��id
	JSONObject json = new JSONObject();
	if("1".equals(type))//��Ҫ�������Դ��������з���
	{
		json.accumulate("","");
		String sql="select sid from int_heteProducts where id='"+ygid+"'";
		if(RecordSet.execute(sql)&&RecordSet.next())
		{
			 sid=RecordSet.getString("sid");
		}
		if("1".equals(sid))//�м��ķ�ʽ----dml����Դ
		{
			//����ò�Ʒ�µ�����Դ
			RecordSet.execute("select * from dml_datasource where hpid='"+ygid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("sourcename"));
			}
		}else if("2".equals(sid))//webservice�ķ�ʽ--webservice����Դ
		{
			//����ò�Ʒ�µ�����Դ
			RecordSet.execute("select * from ws_datasource where hpid='"+ygid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("poolname"));
			}
		}else if("3".equals(sid))//RFC�ķ�ʽ---sap������Դ
		{	
			//����ò�Ʒ�µ�����Դ
			RecordSet.execute("select * from sap_datasource where hpid='"+ygid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("poolname"));
			}
		}
	}else if("2".equals(type))//��Ҫ��ѯע��ķ�����������з���
	{
	
		json.accumulate("","");
		String sql="select sid from int_heteProducts where id='"+ygid+"'";
		if(RecordSet.execute(sql)&&RecordSet.next())
		{
			 sid=RecordSet.getString("sid");
		}
		//�����칹��Ʒ��id������Դ��id,���ע��ķ���
		if("1".equals(sid))//�м��ķ�ʽ----dml����Դ
		{
			RecordSet.execute("select * from dml_service where hpid='"+ygid+"' and poolid='"+selecteddatasourid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("regname"));
			}
		}else if("2".equals(sid))//webservice�ķ�ʽ--webservice����Դ
		{
			RecordSet.execute("select * from ws_service where hpid='"+ygid+"' and poolid='"+selecteddatasourid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("regname"));
			}
			
		}else if("3".equals(sid))//RFC�ķ�ʽ---sap������Դ
		{	
			RecordSet.execute("select * from sap_service where hpid='"+ygid+"' and poolid='"+selecteddatasourid+"'");
			while(RecordSet.next())
			{
				json.accumulate(RecordSet.getString("id"),RecordSet.getString("regname"));
			}
		}
	}else if("3".equals(type))
	{
		
		//��֤Ψһ
		if(RecordSet.execute("select count(*) s from int_BrowserbaseInfo where mark='"+mark+"'")&&RecordSet.next())
		{
			if(RecordSet.getInt("s")<=0)//֤��û���ظ���ֵ��
			{
				json.accumulate("msg","0");
			}else
			{
				json.accumulate("msg","1");
			}
		}else
		{
			json.accumulate("msg","1");
		}
	}
	out.clear();
	out.print(json);
%>