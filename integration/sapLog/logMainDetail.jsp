<%@page import="com.weaver.integration.log.LogInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<link href="/css/Weaver.css" type=text/css rel=stylesheet>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>


<html>
	<head>
		<title>sap����</title>
	</head>
	<%
		
		String Logtype=Util.null2String(request.getParameter("Logtype"));
		String opera=Util.null2String(request.getParameter("opera"));
		String fromdate2=Util.null2String(request.getParameter("fromdate2"));
		String todate2=Util.null2String(request.getParameter("todate2"));
		String sid=Util.null2String(request.getParameter("sid"));
		String allidstr=Util.null2String(request.getParameter("allidstr"));
		String allidname=Util.null2String(request.getParameter("allidname"));
		String poolid = "";//���ӳ�id
		String hpid = "";//�����칹ϵͳid
		String regserviceid = "";//ע������id
		if(!"".equals(allidstr)){
				poolid=allidstr.split("_")[2];
				hpid=allidstr.split("_")[1];
				regserviceid=allidstr.split("_")[3];
		}
		if("delete".equals(opera)&&!"".equals(sid)){
			if(!"".equals(sid)&&(sid.length()==(sid.lastIndexOf(",")+1))){//ȥ�����һ������
				sid=sid.substring(0,(sid.length()-1));
			}
			RecordSet.execute("delete int_saplog where id in("+sid+")");
			RecordSet.execute("delete int_saplogpar where baseid in("+sid+")");
			RecordSet.execute("delete int_saplogstu where baseid in("+sid+")");
			RecordSet.execute("delete int_saplogtab  where baseid in("+sid+")");
		}
		
		String imagefilename = "/images/hdMaintenance.gif";
		String titlename = "��־����鿴";
		String needhelp ="";
		String tableString="";
		String sqlwhere=" where 1=1 ";
		if(!"".equals(Logtype)){
			sqlwhere+=" and Logtype='"+Logtype+"'";
		}
		if(!"".equals(fromdate2)){
			sqlwhere+=" and logcreateData >='"+fromdate2+"'";
		}
		if(!"".equals(todate2)){
			sqlwhere+=" and logcreateData <='"+todate2+"'";
		}

		if(!"".equals(poolid)){
			sqlwhere+=" and poolid ='"+poolid+"'";
		}
		if(!"".equals(hpid)){
			sqlwhere+=" and hpid ='"+hpid+"'";
		}
		if(!"".equals(regserviceid)){
			sqlwhere+=" and regserviceid ='"+regserviceid+"'";
		}



		String backfields=" * " ;
		String perpage="10";
		String para1="column:logcreatetime";
		String para2="column:poolid+column:hpid+column:regserviceid";
		
		
		String fromSql=" int_saplog "; 
		tableString =   " <table instanceid=\"sendDocListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+
				"<checkboxpopedom     popedompara=\"column:id\"    showmethod=\"com.weaver.integration.util.IntegratedMethod.publicshowBox\"  />"+
                "       <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\"  sqlorderby=\"id\"  sqlprimarykey=\"id\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
                "       <head>"+
                "           <col width=\"20%\"  text=\"��־����\" column=\"Logtype\"  transmethod=\"com.weaver.integration.util.IntegratedMethod.getLogtype\"/>"+
				"           <col width=\"20%\"  text=\"��־����ʱ��\" column=\"logcreateData\"   transmethod=\"com.weaver.integration.util.IntegratedMethod.getLogDataStr\" otherpara=\""+para1+"\"/>"+
				"           <col width=\"40%\"  text=\"������\" column=\"id\"   transmethod=\"com.weaver.integration.util.IntegratedMethod.getLogRegname\"  otherpara=\""+para2+"\" />"+
				"           <col width=\"20%\"  text=\"��־����\" column=\"id\"   transmethod=\"com.weaver.integration.util.IntegratedMethod.getSapLog\"/>"+
                "       </head>"+
                " </table>";
	%>
	<body>

			<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
			<%
			RCMenu += "{����,javascript:doRefresh(this),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			RCMenu += "{ɾ��,javascript:doDelete(this),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			%>
			<%@ include file="/systeminfo/RightClickMenu.jsp" %>

				<form action="/integration/sapLog/logMainDetail.jsp" method="post" name="sapserlist" id="sapserlist">
			    <!-- �������-start-->
				<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
				<colgroup>
				<col width="10">
				<col width="">
				<col width="10">
				</colgroup>
				<tr>
				<td height="10" colspan="3"></td>
				</tr>
				<tr>
				<td ></td>
				<td valign="top">
				
						<TABLE class="Shadow">
						<tr>
						<td valign="top">
						
								<table class=ViewForm >
									<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="25%">
									<col width="10%">
									<col width="25%">
									</colgroup>
								<tbody>
								<TR class="Title"> 
								      <TH colSpan="6">&nbsp;��ѯ����</TH>
								    </TR>
								<TR class=Spacing  style="height:1px;">
								  <TD colspan=6 class=line1></TD>
								</TR>
								<tr>    
								  	<td width=10%>
								     	��־����
								     </td>
								    <td class=field  >
								   				<select name="Logtype">
												<option value="">ȫ��</option>
												<option value="0" <%if("0".equals(Logtype)){out.println("selected='selected'");} %> >�ڵ��</option>
												<option value="1" <%if("1".equals(Logtype)){out.println("selected='selected'");} %>>�ڵ�ǰ</option>
												<option value="2" <%if("2".equals(Logtype)){out.println("selected='selected'");} %>>�����ť</option>
												<option value="3" <%if("3".equals(Logtype)){out.println("selected='selected'");} %>>������</option>
										</select>
								    </td>
								    
								       <td width=10%>
								     	��־����ʱ��
								     </td>
								    <td class=field >
										

										<BUTTON type="button" class=calendar id=SelectDate3  onclick="gettheDate(fromdate2,fromdatespan2)"></BUTTON>
										<SPAN id=fromdatespan2 ><%=fromdate2%></SPAN>
										-&nbsp;&nbsp;
										<BUTTON type="button" class=calendar id=SelectDate4 onclick="gettheDate(todate2,todatespan2)"></BUTTON>
										<SPAN id=todatespan2 ><%=todate2%></SPAN>
										<input type="hidden" name="fromdate2" value="<%=fromdate2%>"><input type="hidden" name="todate2" value="<%=todate2%>">

								    </td>

								      <td width=10%>���õķ���</td>
								      <td class=field>
											<button type='button' class='browser' onclick=onchangeservice(this)></button> 
											<span id="servicename"><%=allidname%></span>
											<input type=hidden   name="allidname" id="allidname" value="<%=allidname%>">
											<input type=hidden  name="allidstr" id="allidstr" value="<%=allidstr%>">
									</td>
								  
								     
								</tr>
								<TR style="height:1px;"><TD class=Line colSpan=6></TD></TR>
								</tbody>
								</table>
								
								
								<TABLE width="100%">
								    <tr>
								        <td valign="top">  
								           	<wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" />
								        </td>
								    </tr>
								</TABLE>
						</td>
						</tr>
						</TABLE>
				
				</td>
				<td></td>
				</tr>
				<tr>
				<td  colspan="3">
				</td>
				</tr>
				</table>
			<!--�������-end  -->
			</form>
	<script type="text/javascript">
		
	function onchangeservice()
	{		
			var selectedids=$("#servicesid").val();
			var sid = window.showModalDialog("/integration/browse/IntegrationServiceBrower.jsp?selectedids="+selectedids, "", "dialogWidth:550px;dialogHeight:550px;");
			if(sid)
			{
				$("#servicename").html(sid.name);
				$("#allidname").attr("value",sid.name);
				$("#allidstr").attr("value",sid.id);
			}
	}
		//������ҳ���У����ô˷�������Ӧ�Ľ���
		function openDialog(title,url) {
					var dlg=new Dialog();//����Dialog����
					dlg.Model=true;
					dlg.Width=800;//���峤��
					dlg.Height=600;
					dlg.URL=url;
					dlg.Title=title;
					dlg.show();
		}


		function doRefresh(){
			$("#sapserlist").submit();
		}
		function loadLogDetail(logid){
			
			openDialog("��־�鿴","/integration/sapLog/logMainDetailAJAX.jsp?logid="+logid);
			/*if(logid){
					$.post("/integration/sapLog/logMainDetailAJAX.jsp",{logid:logid},function(data){ 
					if(data["content"]) {
							//$("#logdetailshow").html(data["content"]);
							openDialog(data["content"].serialize(),"/integration/sapLog/logMainDetailAJAX.jsp");
					}
	 				
				},"json");
			}*/
		}
		function doDelete()
		{
			var requestids = _xtable_CheckedCheckboxId();	
			if(!requestids)
			{
				alert("��ѡ��ɾ������!");
				return;
			}else
			{	
				if(window.confirm("ȷ��Ҫִ��ɾ��������!"))
				{
				window.location.href="/integration/sapLog/logMainDetail.jsp?opera=delete&sid="+requestids;
				}
			}		
		}
	</script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
	</body>
</html>

