<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
		
		String flag="0";//0����ʧ��,1����ɹ�
		//save--����,update--�޸�,delete-ɾ��
		String opera=Util.null2String(request.getParameter("opera"));
		String id=Util.null2String(request.getParameter("ids"));
		if(!"".equals(id)&&(id.length()==(id.lastIndexOf(",")+1)))
		{
			id=id.substring(0,(id.length()-1));
		}
		String hpid=Util.null2String(request.getParameter("hpid"));
		String poolid=Util.null2String(request.getParameter("poolid"));
		String opermode=Util.null2String(request.getParameter("opermode"));
		String serdesc=Util.null2String(request.getParameter("serdesc"));
		String regname=Util.null2String(request.getParameter("regname"));
		String sql="";
		if("save".equals(opera))
		{
			sql=" insert into dml_service (poolid,opermode,serdesc,regname,hpid)";
			sql+=" values ('"+poolid+"','"+opermode+"','"+serdesc+"','"+regname+"','"+hpid+"')";
			if(rs.execute(sql))
			{
				flag="1";
			}
			
		}else if("update".equals(opera))
		{
			sql=" update dml_service set poolid='"+poolid+"',opermode='"+opermode+"',serdesc='"+serdesc+"',regname='"+regname+"'";
			sql+=" where id='"+id+"'";
			if(rs.execute(sql))
			{
				flag="1";
			}
		}else if("delete".equals(opera))
		{
				sql=" delete dml_service where id in("+id+")";
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
			alert("<%=SystemEnv.getHtmlLabelName(30700,user.getLanguage())%>"+"!");
		}else
		{
			alert("<%=SystemEnv.getHtmlLabelName(30651,user.getLanguage())%>"+"!");
		}
		window.location.href="/integration/serviceReg/serviceReg_1list.jsp?hpid="+<%=hpid%>;
//-->
</script>
