<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
		
		String flag="0";//0����ʧ��,1����ɹ�
		//save--����,update--�޸�,delete-ɾ��
		String opera=Util.null2String(request.getParameter("opera"));
		String id=Util.null2String(request.getParameter("sid"));
		if(!"".equals(id)&&(id.length()==(id.lastIndexOf(",")+1)))
		{
			id=id.substring(0,(id.length()-1));
		}
		String dataname=Util.null2String(request.getParameter("dataname"));
		String datadesc=Util.null2String(request.getParameter("datadesc"));
		String sql="";
		if("save".equals(opera))
		{
			if(!"".equals(dataname))
			{
				sql=" insert into int_dataInter (dataname,datadesc) values ('"+dataname+"','"+datadesc+"')";
				if(rs.execute(sql))
				{
					flag="1";
				}
			}
		}else if("update".equals(opera))
		{
			sql=" update int_dataInter set ";
			if(!"".equals(dataname))
			{
				sql+=" dataname='"+dataname+"' ,";
			}
			sql+=" datadesc='"+datadesc+"' ,";
			//ȥ�����һ������
			sql=sql.substring(0,sql.lastIndexOf(","));
			sql+=" where id ='"+id+"'";
			if(rs.execute(sql))
			{
				flag="1";
			}
		}else if("delete".equals(opera))
		{
				sql=" delete int_dataInter where id in("+id+")";
				if(rs.execute(sql))
				{
					flag="1";
				}
		}
		
%>

<script type="text/javascript">
	<!--
		if(<%=flag%>==1)
		{
			alert("<%=SystemEnv.getHtmlLabelName(30700 ,user.getLanguage())%>"+"!");
		}else
		{
			alert("<%=SystemEnv.getHtmlLabelName(30651 ,user.getLanguage())%>"+"!");
		}
		window.location.href="/integration/dataInterlist.jsp";
//-->
</script>
