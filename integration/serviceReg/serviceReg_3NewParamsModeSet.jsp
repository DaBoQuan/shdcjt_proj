<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@page import="com.weaver.integration.datesource.*,com.weaver.integration.params.*,com.weaver.integration.log.*"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet02" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="inteutil" class="com.weaver.integration.util.IntegratedUtil" scope="page"/>
<jsp:useBean id="ssu" class="com.weaver.integration.util.SAPServcieUtil" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<link href="/css/Weaver.css" type=text/css rel=stylesheet>
<link href="/integration/css/intepublic.css" type=text/css rel=stylesheet>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<html>
	<head>
		<title><%=SystemEnv.getHtmlLabelName(26968,user.getLanguage())%></title>
	</head>

	
	<!-- ҵ���߼� start-->
	<%
			
			
			//function addOneFieldObjOA��׼ 
			//--------------<button> �����ť
			//--------------<input>  ���ص�oa�ֶ�name
			//--------------<span>   ��ʾ��oa�ֶ�name
			//--------------<span>   ��ʾimg
			//--------------<input>  ��¼�ֶ�(�Ƿ����ֶΣ��ֶε����ݿ�id,)
			
			//table--id����
			//��һ��table id:sap_01   ȫѡcbox_01                              ���add_01                ��tableid chind01
			//�ڶ���table id:sap_02   ȫѡcbox_02_01,cbox_02_02,...cbox_02_n ���add_02
			//������table id:sap_03   ȫѡcbox_03     ���add_03
			//���ĸ�table id:sap_04   ȫѡcbox_04_01,cbox_04_02,...cbox_04_n ���add_04
			//�����table id:sap_05   ȫѡcbox_05_01,cbox_05_02,...cbox_05_n ���add_05
			String browserId = Util.null2String(request.getParameter("browserId"));
			String servId = Util.null2String(request.getParameter("servId"));
			String poolid = Util.null2String(request.getParameter("poolid"));
			
			SAPFunctionStatusBean ssb = ServiceParamsUtil.getStatusByServId(servId, new LogInfo());
			boolean impTableStatus = false;
			boolean impStructStatus = false;
			boolean impStrStatus = false;
			boolean expTableStatus = false;
			boolean expStructStatus = false;
			boolean expStrStatus = false;
			if(ssb != null) {
				impTableStatus = ssb.isImpTableStatus();
				impStructStatus = ssb.isImpStructStatus();
				impStrStatus = ssb.isImpStrStatus();
				expTableStatus = ssb.isExpTableStatus();
				expStructStatus = ssb.isExpStructStatus();
				expStrStatus = ssb.isExpStrStatus();
			}
			
			int sap_inParameter=1;//�������������
			int sap_inStructure=1;//����ṹ������
			int sap_outParameter=1;
			int sap_outStructure=1;
			int sap_outTable=1;
			int int_authorizeRight=1;
			int sap_inTable=1;
			String sql="";
			String opera="";//
			opera = "".equals(browserId)?"save":"update";
			//��һ������--�������
			ServiceParamModeStatusBean spmsb =new ServiceParamModeStatusBean();
			if(!"".equals(browserId)){//
					 spmsb =ServiceParamModeDisUtil.getServParModStaBeanById(servId, browserId);
			}
			StringBuffer sapinParameter01= new StringBuffer();
			sapinParameter01.append("<TABLE class='ListStyle marginTop0 ' cellspacing=1 id='sap_01' style='height:100%;table-layout: fixed;'>");
			sapinParameter01.append(" <colgroup> <col width='119px'/>  <col width='*' /> </colgroup>");
			sapinParameter01.append("<tr>");
			sapinParameter01.append("<td>&nbsp;"+SystemEnv.getHtmlLabelName(28245,user.getLanguage())+"</td>");
			sapinParameter01.append("<td><button type='button'  class='btn' id='bath_01' onclick='addBathFieldObj(1,1)'>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button> <button type='button' class='btn' id='add_01' onclick='addBathFieldObj(1,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>");
			sapinParameter01.append("<button type='button' class='btn' id='del_01' onclick='addBathFieldObj(1,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button> <input type='hidden' id='hidden01' value='"+spmsb.getImpstrcount()+"' name='hidden01'></td>"); 
			sapinParameter01.append("</tr>"); 	
			sapinParameter01.append("<tr>");
			sapinParameter01.append("<td colspan='2'>");
				sapinParameter01.append(" <TABLE class=ListStyle cellspacing=1 id='chind01' style='table-layout: fixed;'>");
				sapinParameter01.append(" <colgroup> <col width='113px'/> <col width='80px'/><col width='210px'/><col width='80px'/><col width='200px'/><col width='80px'/><col width='*'/></colgroup>");
				sapinParameter01.append(" <tr class=Header>");
				sapinParameter01.append(" <td><input type='checkbox' id='cbox_01'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td><td colspan='6'>"+SystemEnv.getHtmlLabelName(30605,user.getLanguage())+"</td>");
				sapinParameter01.append(" </tr>");
				sapinParameter01.append(" <TR class=Line style='height:1px'><TD colSpan=7 style='padding:0px'></TD></TR>");
				
					if("update".equals(opera))
					{
							List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "import", false, "", "");
							if(list != null) {
								for(int i=0;i<list.size();i++) {
									ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
									String input01="sap01_"+sap_inParameter;
									String input01Span="sap01_"+sap_inParameter+"Span";
									String input02="sapDesc01_"+sap_inParameter;
									String input03="con01_"+sap_inParameter;
									
									String temp = "<tr style='height:40px;'><td><input type='checkbox' name='cbox1'></td><td>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td>";
									temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(1,"+sap_inParameter+")></button></span>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' value='"+spmdb.getParamName()+"' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(1,this)'></span>";
									temp += "</td><td>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='padding-top:5px;'><input type='text' name='"+input02+"' style='border:1px solid #D4E9E9;width:185px;height:28px;' value='"+spmdb.getParamDesc()+"'></td>";
									temp += "<td>"+SystemEnv.getHtmlLabelName(453,user.getLanguage())+"</td><td style='padding-top:5px;'><input type='text' ";
									temp += "name='"+input03+"' value='"+spmdb.getParamCons()+"' style='border:1px solid #D4E9E9;width:170px;height:28px;'></td></tr>";
									sapinParameter01.append(temp);
									sap_inParameter++;
								}
							}
					}
			sapinParameter01.append(" </TABLE>");
			sapinParameter01.append("</td>");
			sapinParameter01.append("</tr>"); 
			sapinParameter01.append("</table>");
			
			//�ڶ�������--����ṹ
			StringBuffer sapinParameter02= new StringBuffer();										  	
			sapinParameter02.append("<TABLE class='ListStyle marginTop0 shownone' cellspacing=1 id='sap_02' style='table-layout: fixed;'>");
			sapinParameter02.append(" <colgroup> <col width='120px'/>  <col width='*' /> </colgroup>");										 
			sapinParameter02.append(" <tr>");	
			sapinParameter02.append(" <td>&nbsp;"+SystemEnv.getHtmlLabelName(28251,user.getLanguage())+"</td>");	
			sapinParameter02.append(" <td><button type='button'  class='btn' id='bath_02' onclick='addBathFieldObj(2,1)'>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button><button type='button' class='btn'  id='add_02' onclick='addBathFieldObj(2,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button><button type='button' class='btn' id='del_02' onclick='addBathFieldObj(2,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button> <input type='hidden' id='hidden02' name='hidden02' value='"+spmsb.getImpstructcount()+"' ></td>");	
			sapinParameter02.append(" </tr>");	
					if("update".equals(opera))
					{	
						List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "import", true, "struct", "");
						if(list != null) {
							for(int i=0;i<list.size();i++) {
								ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
								String newstru="stru_"+sap_inStructure;
								String newstruSpan="stru_"+sap_inStructure+"span";
								String newname="cbox2_"+sap_inStructure;
								String bath="bath2_"+sap_inStructure;
								String newtable="sap_02"+"_"+sap_inStructure;
								String addFieldBtn = "addstru_"+sap_inStructure;
								String delFieldBtn = "delstru_"+sap_inStructure;
								int newchtable = ServiceParamModeDisUtil.getCompFieldCountByName(servId, browserId, "import", spmdb.getParamName());
								int childstu=1;
								String temp = "<tr><td class='tdcenter'><input type='checkbox' name='cbox2'></td>"; 	
								temp += "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
								temp += " style='vertical-align: middle;' onclick=addOneFieldObj(2,"+sap_inStructure+",'"+newstru+"')></button>"; 
								temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:15px;'>"; 
								temp += " </span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+spmdb.getParamName()+"' onchange='javascript:sapFieldChange(2,this)' style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
								temp += " </td><td>";
								temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='"+newchtable+"'></td></tr></table>";
								temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
								temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
								temp += " onclick='checkbox2(this,"+sap_inStructure+")'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td><td style='text-align:right;' colspan='7'>";
								temp += "<button type='button'  class='btn' id='"+bath+"'"; 
								temp += " onclick=addBathFieldObj(3,1,'"+newstru+"','"+sap_inStructure+"')>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button>"; 
								temp += " <button type='button' class='btn' id='"+addFieldBtn+"' ";  
								temp += " onclick=addBathFieldObj(3,2,'"+newstru+"','"+sap_inStructure+"')>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>";
								temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
								temp += " onclick=addBathFieldObj(3,3,'"+newstru+"','"+sap_inStructure+"')>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button>"; 
								temp += "</td></tr>";
								temp += "<TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'></TD></TR>";
								
								List listtemp = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "import", false, "", spmdb.getParamName());
								if(listtemp != null) {
									for(int j=0;j<listtemp.size();j++) {
										ServiceParamModeDisBean spmdbtemp = (ServiceParamModeDisBean)listtemp.get(j);
										String input01="sap02_"+sap_inStructure+"_"+childstu;
										String input03="con02_"+sap_inStructure+"_"+childstu;
										String input01Desc = "sapDesc02_"+sap_inStructure+"_"+childstu;
										String input01Span="sap02_"+sap_inStructure+"_"+childstu+"span";
										String numstemp = sap_inStructure+"_"+childstu;
										temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
										temp += "<button type='button' style='vertical-align: middle;' class='browser'";
										temp += " onclick=addOneFieldObj(3,'"+numstemp+"','stru_"+sap_inStructure+"')></button>";
										temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
										temp += "<input type='text' name='"+input01+"'";  
										temp += " value='"+spmdbtemp.getParamName()+"' onchange='javascript:sapFieldChange(3,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
										temp += "</td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
										temp += "<input type='text' name='"+input01Desc+"'";  
										temp += " value='"+spmdbtemp.getParamDesc()+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
										temp += "</td><td style='width:80px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(453,user.getLanguage())+"</td>";
										temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' value='"+spmdbtemp.getParamCons()+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
										childstu ++;
									}
								}
								temp += " </TABLE></td></tr>";
								sapinParameter02.append(temp);
								sap_inStructure++;
							}
						}
					}	
												  	
			sapinParameter02.append(" </TABLE>");													
														
			//������--�������							 
																			  	
			StringBuffer sapinParameter03= new StringBuffer();
			sapinParameter03.append("<TABLE class='ListStyle marginTop0 shownone' cellspacing=1 id='sap_03' style='table-layout: fixed;'>");
			sapinParameter03.append(" <colgroup> <col width='119px'/>  <col width='*' /> </colgroup>");
			sapinParameter03.append("<tr>");
			sapinParameter03.append("<td>&nbsp;"+SystemEnv.getHtmlLabelName(28255,user.getLanguage())+"</td>");
			sapinParameter03.append("<td><button type='button' class='btn' id='bath_03' onclick='addBathFieldObj(4,1)'>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button><button type='button' class='btn' id='add_03' onclick='addBathFieldObj(4,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>");
			sapinParameter03.append("<button type='button' class='btn' id='del_03' onclick='addBathFieldObj(4,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button><input type='hidden' id='hidden03' name='hidden03' value='"+spmsb.getExpstrcount()+"'></td>"); 
			sapinParameter03.append("</tr>"); 	
			sapinParameter03.append("<tr>");
			sapinParameter03.append("<td colspan='2'>");
			sapinParameter03.append(" <TABLE class=ListStyle cellspacing=1 id='chind03' style='table-layout: fixed;'>");
			sapinParameter03.append(" <colgroup> <col width='113px'/> <col width='80px'/><col width='210px'/><col width='80px'/><col width='*'/></colgroup>");
			sapinParameter03.append(" <tr class=Header>");
			sapinParameter03.append(" <td><input type='checkbox' id='cbox_03'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td><td colspan='4'>"+SystemEnv.getHtmlLabelName(30605,user.getLanguage())+"</td>");
			sapinParameter03.append(" </tr>");
			sapinParameter03.append(" <TR class=Line style='height:1px'><TD colSpan=5 style='padding:0px'></TD></TR>");
					
			if("update".equals(opera)){
				List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "export", false, "", "");
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
						String input01="sap03_"+sap_outParameter;
						String input01Span="sap03_"+sap_outParameter+"span";
						String input02="sapDesc03_"+sap_outParameter;//��ʾ��--�ı���
						String temp = "<tr style='height:40px;'><td><input type='checkbox' name='cbox3'></td><td>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td>";
						temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(4,"+sap_outParameter+")></button></span>";
						temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
						temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' value='"+spmdb.getParamName()+"' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(4,this)'></span>";
						temp += "</td><td>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='padding-top:5px;'><input type='text' name='"+input02+"' value='"+spmdb.getParamDesc()+"' style='border:1px solid #D4E9E9;width:185px;height:28px;'></td></tr>";
						sapinParameter03.append(temp);
						sap_outParameter++;
					}
				}		
			}
			
			sapinParameter03.append(" </TABLE>");
			sapinParameter03.append("</td>");
			sapinParameter03.append("</tr>"); 
			sapinParameter03.append("</table>");																		
																						
																					
			//���ĸ�----����ṹ																
																						
			StringBuffer sapinParameter04= new StringBuffer();
			sapinParameter04.append("<TABLE class='ListStyle marginTop0 shownone' cellspacing=1 id='sap_04' style='table-layout: fixed;'>");
			sapinParameter04.append(" <colgroup> <col width='120px'/>  <col width='*' /> </colgroup>");										 
			sapinParameter04.append(" <tr>");	
			sapinParameter04.append(" <td>&nbsp;"+SystemEnv.getHtmlLabelName(28256,user.getLanguage())+"</td>");	
			sapinParameter04.append(" <td><button type='button'  class='btn' id='bath_04' onclick=addBathFieldObj(5,1)>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button><button type='button' class='btn' id='add_04' onclick='addBathFieldObj(5,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button><button type='button' class='btn' id='del_04' onclick='addBathFieldObj(5,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button><input type='hidden' id='hidden04' name='hidden04' value='"+spmsb.getExpstructcount()+"'></td>");	
			sapinParameter04.append(" </tr>");	
			
				if("update".equals(opera)) {	
					List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "export", true, "struct", "");
					if(list != null) {
						for(int i=0;i<list.size();i++) {
							ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
							String stuname= spmdb.getParamName();
							String newname="cbox4"+"_"+sap_outStructure;
							String newtable="sap_04"+"_"+sap_outStructure;
							String newstru="outstru_"+sap_outStructure;
							String newstruSpan="outstru_"+sap_outStructure+"span";
							String bath="bath4_"+sap_outStructure;
							String addFieldBtn = "addoutstru_"+sap_outStructure;
							String delFieldBtn = "deloutstru_"+sap_outStructure;
							int newchtable = ServiceParamModeDisUtil.getCompFieldCountByName(servId, browserId, "export",stuname);
							int childstu=1;
							String temp = "<tr><td class='tdcenter'><input type='checkbox' name='cbox4'></td>"; 	
							temp += "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
							temp += " style='vertical-align: middle;' onclick=addOneFieldObj(5,"+sap_outStructure+",'"+newstru+"')></button>"; 
							temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
							temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(5,this)' value='"+stuname+"'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
							temp += " </td><td>"; 
							temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='"+newchtable+"'></td></tr></table>";
							temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
							temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
							temp += " onclick='checkbox4(this,"+sap_outStructure+")'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td>";
							temp += " <td colspan='4' style='text-align:right;'>";
							temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(6,1,'"+newstru+"','"+sap_outStructure+"')>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button>"; 
							temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
							temp += " onclick=addBathFieldObj(6,2,'"+newstru+"','"+sap_outStructure+"')>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>";
							temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
							temp += " onclick=addBathFieldObj(6,3,'"+newstru+"','"+sap_outStructure+"')>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button>";
							temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
							temp += " </TD></TR>";
							List listtemp = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "export", false, "", stuname);
							if(listtemp != null) {
								for(int j=0;j<listtemp.size();j++) {
									ServiceParamModeDisBean spmdbtemp = (ServiceParamModeDisBean)listtemp.get(j);
									String input01="sap04_"+sap_outStructure+"_"+childstu;
									String input01Span="sap04_"+sap_outStructure+"_"+childstu+"span";
									String input01Desc = "sapDesc04_"+sap_outStructure+"_"+childstu;
									String numstemp = sap_outStructure+"_"+childstu;
									temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
									temp += "<button type='button' style='vertical-align: middle;' class='browser'";
									temp += " onclick=addOneFieldObj(6,'"+numstemp+"','outstru_"+sap_outStructure+"')></button>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<input type='text' name='"+input01+"'";  
									temp += " value='"+spmdbtemp.getParamName()+"' onchange='javascript:sapFieldChange(6,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
									temp += "<input type='text' name='"+input01Desc+"'";  
									temp += " value='"+spmdbtemp.getParamDesc()+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td></tr>";
									childstu ++;
								}
							}
						
							
							temp += "</table></td></tr>";
							sapinParameter04.append(temp);//���������ṹ���������ʾ������������
							sap_outStructure ++;
						}
					}
				}									  	
			sapinParameter04.append(" </TABLE>");																				
																					
													
																				
			//�����----�����																																		
			StringBuffer sapinParameter05= new StringBuffer();
			sapinParameter05.append("<TABLE class='ListStyle marginTop0 shownone' cellspacing=1 id='sap_05' style='table-layout: fixed;'>");
			sapinParameter05.append(" <colgroup> <col width='120px'/>  <col width='*' /> </colgroup>");										 
			sapinParameter05.append(" <tr>");	
			sapinParameter05.append(" <td>&nbsp;"+SystemEnv.getHtmlLabelName(28260,user.getLanguage())+"</td>");	
			sapinParameter05.append(" <td><button type='button'  class='btn' id='bath_05' onclick='addBathFieldObj(7,1)'>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button><button type='button' class='btn' id='add_05' onclick='addBathFieldObj(7,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button><button type='button' class='btn' id='del_05' onclick='addBathFieldObj(7,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button><input type='hidden' id='hidden05' name='hidden05' value='"+spmsb.getExptablecount()+"'></td>");	
			sapinParameter05.append(" </tr>");
			
			if("update".equals(opera))
			{
				List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "export", true, "table", "");
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
						String stuname= spmdb.getParamName();
						String newname="cbox5"+"_"+sap_outTable;
						String newtable="sap_05"+"_"+sap_outTable;
						String newstru="outtable_"+sap_outTable;
						String newstruSpan="outtable_"+sap_outTable+"span";
						String bath="bath5_"+sap_outTable;
						String addFieldBtn = "addouttable_"+sap_outTable;
						String delFieldBtn = "delouttable_"+sap_outTable;
						int newchtable = ServiceParamModeDisUtil.getCompFieldCountByName(servId, browserId, "export",stuname);
						int childstu=1;
						String temp = "<tr><td class='tdcenter'><input type='checkbox' name='cbox5'></td>"; 	
						temp += "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' "; 
						temp += " style='vertical-align: middle;' onclick=addOneFieldObj(7,"+sap_outTable+",'"+newstru+"')></button>"; 
						temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
						temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+stuname+"' onchange='javascript:sapFieldChange(7,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
						temp += " </td><td>"; 
						temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='"+newchtable+"'></td></tr></table>";
						temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
						temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
						temp += " onclick='checkbox5(this,"+sap_outTable+")'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td>";
						temp += " <td colspan='4' style='text-align:right;'>";
						temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(8,1,'"+newstru+"','"+sap_outTable+"') >"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button>"; 
						temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
						temp += " onclick=addBathFieldObj(8,2,'"+newstru+"','"+sap_outTable+"') >"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>";
						temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
						temp += " onclick=addBathFieldObj(8,3,'"+newstru+"','"+sap_outTable+"') >"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button>";
						temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
						temp += " </TD></TR>";	
						
						List listtemp = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "export", false, "", stuname);
						if(listtemp != null) {
							for(int j=0;j<listtemp.size();j++) {
								ServiceParamModeDisBean spmdbtemp = (ServiceParamModeDisBean)listtemp.get(j);
								String input01="sap05_"+sap_outTable+"_"+childstu;
								String input01Span="sap05_"+sap_outTable+"_"+childstu+"span";
								String input01Desc = "sapDesc05_"+sap_outTable+"_"+childstu;
								String numstemp = sap_outTable+"_"+childstu;
								temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
								temp += "<button type='button' style='vertical-align: middle;' class='browser'";
								temp += " onclick=addOneFieldObj(8,'"+numstemp+"','outtable_"+sap_outTable+"')></button>";
								temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
								temp += "<input type='text' name='"+input01+"'";  
								temp += " value='"+spmdbtemp.getParamName()+"' onchange='javascript:sapFieldChange(8,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
								temp += "</td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
								temp += "<input type='text' name='"+input01Desc+"'";  
								temp += " value='"+spmdbtemp.getParamDesc()+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
								temp += "</td></tr>";
								childstu ++;
							}
						}	
						temp += "</TABLE></td></tr>";
						sapinParameter05.append(temp);
						sap_outStructure ++;
					}
				}
			}	
			sapinParameter05.append(" </TABLE>");																			
																				
																				
			
			
			
			//���߸�----�����																																		
			StringBuffer sapinParameter07= new StringBuffer();
			sapinParameter07.append("<TABLE class='ListStyle marginTop0 shownone' cellspacing=1 id='sap_07' style='table-layout: fixed;'>");
			sapinParameter07.append(" <colgroup> <col width='120px'/>  <col width='*' /> </colgroup>");										 
			sapinParameter07.append(" <tr>");	
			sapinParameter07.append(" <td>&nbsp;"+SystemEnv.getHtmlLabelName(30712,user.getLanguage())+"</td>");	
			sapinParameter07.append(" <td><button type='button'  class='btn' id='bath_07' onclick='addBathFieldObj(10,1)'>"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button><button type='button' class='btn' id='add_07' onclick='addBathFieldObj(10,2)'>"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button><button type='button' class='btn' id='del_07' onclick='addBathFieldObj(10,3)'>"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button><input type='hidden' id='hidden07' name='hidden07'  value='"+spmsb.getImptablecount()+"'></td>");	
			sapinParameter07.append(" </tr>");
			
			if("update".equals(opera))
			{
				List list = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "import", true, "table", "");
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						ServiceParamModeDisBean spmdb = (ServiceParamModeDisBean)list.get(i);
						String newname="cbox7"+"_"+sap_inTable;
						String newstru="outtable7_"+sap_inTable;
						String newtable="sap_07"+"_"+sap_inTable;
						String newstruSpan="outtable7_"+sap_inTable+"span";
						String bath="bath7_"+sap_inTable;
						String addFieldBtn = "addtable_"+sap_inTable;
						String delFieldBtn = "deltable_"+sap_inTable;
						String stuname= spmdb.getParamName();
						int newchtable = ServiceParamModeDisUtil.getCompFieldCountByName(servId, browserId, "import",stuname);
						int childstu=1;
						String temp = "<tr><td class='tdcenter'><input type='checkbox' name='cbox7'></td>"; 	
						temp += "<td style='padding-top:0px;padding-bottom:0px;'>"; 
					   temp += "<table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' ";
					    temp += " style='vertical-align: middle;' onclick=addOneFieldObj(10,"+sap_inTable+",'"+newstru+"')></button>"; 
					    temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
					    temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+stuname+"' onchange='javascript:sapFieldChange(10,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
					    temp += " </td><td>"; 
					    temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='"+newchtable+"'></td></tr></table>";
					    temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
					    temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
					    temp += " onclick='checkbox7(this,"+sap_inTable+")'/>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</td>";
					    temp += " <td colspan='7' style='text-align:right;'>";
					    temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(11,1,'"+newstru+"','"+sap_inTable+"') >"+SystemEnv.getHtmlLabelName(25055,user.getLanguage())+"</button>"; 
					    temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
					    temp += " onclick=addBathFieldObj(11,2,'"+newstru+"','"+sap_inTable+"') >"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+"</button>";
					    temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
					    temp += " onclick=addBathFieldObj(11,3,'"+newstru+"','"+sap_inTable+"') >"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"</button>";
					    temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'></TD></TR>";
					    List listtemp = ServiceParamModeDisUtil.getParamsModeDisById(servId, browserId, "import", false, "", stuname); 
						if(listtemp != null) {
							for(int j=0;j<listtemp.size();j++) {
								ServiceParamModeDisBean spmdbtemp = (ServiceParamModeDisBean)listtemp.get(j);
								String input01="sap07_"+sap_inTable+"_"+childstu;
								String input01Span="sap07_"+sap_inTable+"_"+childstu+"span";
								String input03="con07_"+sap_inTable+"_"+childstu;
								String input01Desc = "sapDesc07_"+sap_inTable+"_"+childstu;
								String numstemp = sap_inTable+"_"+childstu;
								temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(28247,user.getLanguage())+"</td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
								temp += "<button type='button' style='vertical-align: middle;' class='browser'";
								temp += " onclick=addOneFieldObj(11,'"+numstemp+"','outtable7_"+sap_inTable+"')></button>";
								temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
								temp += "<input type='text' name='"+input01+"'";  
								temp += " value='"+spmdbtemp.getParamName()+"' onchange='javascript:sapFieldChange(11,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
								temp += "</td><td style='width:90px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(30708,user.getLanguage())+"</td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
								temp += "<input type='text' name='"+input01Desc+"'";  
								temp += " value='"+spmdbtemp.getParamDesc()+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
								temp += "</td><td style='width:80px;vertical-align: middle;'>"+SystemEnv.getHtmlLabelName(453,user.getLanguage())+"</td>";
								temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' value='"+spmdbtemp.getParamCons()+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
								childstu ++;
							}
						}
						temp += " </TABLE>";
						temp += " </td></tr>";
						sapinParameter07.append(temp);
						sap_inTable ++;
					}	
				}
			}		
			sapinParameter07.append(" </TABLE>");																		
													 										  	
	%>
	<!-- ҵ���߼� end-->
	
	
	<body>
	<form  method="post" name="weaver" target="postiframe" action="/integration/serviceReg/serviceReg_3NewParamsModeOperation.jsp">
	
					<!--ListStyle ���start  -->
				    <TABLE  cellspacing=1 style='table-layout: fixed;' id="tableid">
						<COLGROUP>
							<COL width="120px"/>
							<COL width="120px"/>
							<COL width="*"/>
						</COLGROUP>
						<TR class=DataLight>	
							<TD colspan="3">
									<div class="navigation">
								  			<ul>
								  			    <%
								  			 	 if(impStrStatus) {
								  			    %>
											    <li item=1><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(28245,user.getLanguage()) %></a></li>
											    <%} %>
											    <%
											      if(impStructStatus) {
											    %>
											    <li item=2><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(28251,user.getLanguage())%></a></li>
											    <%} %>
											    <%
											    if(impTableStatus) {
											    %>
											    <li item=7 ><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(30712,user.getLanguage()) %></a></li>
											     <%} %>
											    <%
											    if(expStrStatus) {
											    %>
											    <li item=3><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(28255,user.getLanguage())%></a></li>
											     <%} %>
											    <%
											    if(expStructStatus) {
											    %>
												<li item=4><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(28256,user.getLanguage()) %></a></li>
												 <%} %>
											    <%
											    if(expTableStatus) {
											    %>
												<li item=5><a href="javascript:void(0)"><%=SystemEnv.getHtmlLabelName(28260,user.getLanguage())%></a></li>
												 <%} %>
										    </ul>
									</div>
									<!-- ��һ��tabҳ���������table--start -->
									<%=sapinParameter01 %>
								    <!-- ��һ��tabҳ���������table--end -->
								    
									<!-- �ڶ���tabҳ���������-start -->
									<%=sapinParameter02 %>	
									<!-- �ڶ���tabҳ���������--end -->
									<!-- ������tabҳ���������-start -->
									<%=sapinParameter03 %>	
									<!-- ������tabҳ���������--end -->
									<!-- ���ĸ�tabҳ���������-start -->
									<%=sapinParameter04 %>	
									<!-- ���ĸ�tabҳ���������--end -->
									<!-- �����tabҳ���������-start -->
									<%=sapinParameter05 %>	
									<!-- �����tabҳ���������--end -->
									<!-- ������tabҳ���������-start -->
									<!-- ������tabҳ���������--end -->
									<!-- ���߸�tabҳ���������-start -->
									<%=sapinParameter07 %>	
									<!-- ���߸�tabҳ���������--end -->
							</TD>
						</TR>
					</TABLE>
					<!--ListStyle ���end  -->
					
					
				<input type="hidden" name="browserId" value="<%=browserId%>">	
				<input type="hidden" name="poolid" id="poolid" value="<%=poolid%>">
				<input type="hidden" name="servId" id="servId" value="<%=servId%>">
				
				<iframe src="" style="display: none;" id="postiframe" name="postiframe"></iframe>
	</form>
	</body>
	
	<script type="text/javascript">
			$(document).ready(function() {
				$(".navigation li:eq(0)").removeClass("selectedli").addClass("selectedli");
				var itemtemp = $(".navigation li:eq(0)").attr("item");
				if(itemtemp<=7)
				{
					$("#sap_01").hide();
					$("#sap_02").hide();
					$("#sap_03").hide();
					$("#sap_04").hide();
					$("#sap_05").hide();
					$("#sap_06").hide();
					$("#sap_07").hide();
					$("#sap_0"+itemtemp).show();
				}
			window.parent.document.getElementById("hidediv").style.display = "none";
			window.parent.document.getElementById("hidedivmsg").style.display = "none";
			$("#cbox_01").click (function(){
					//$("#sap_01 tr td:first-child [type=checkbox]").each(function(){ 
					//	var flag=$("#cbox_01").attr('checked');
						//$(this).attr('checked',flag);
					//});
					
					$("#chind01 tr").parent().find("input[type='checkbox']").each(
						function(){
							var flag=$("#cbox_01").attr('checked');
							$(this).attr('checked',flag);
						}
					);
			});
			$("#cbox_03").click (function(){
					//$("#sap_03 tr td:first-child [type=checkbox][name=cbox3]").each(function(){ 
						//var flag=$("#cbox_03").attr('checked');
						//$(this).attr('checked',flag);
					//});
					
						$("#chind03 tr").parent().find("input[type='checkbox'][name=cbox3]").each(
						function(){
							var flag=$("#cbox_03").attr('checked');
							$(this).attr('checked',flag);
						}
					);
			});
			
			$("#cbox_06").click (function(){
					$("#sap_06 tr td:first-child [type=checkbox][name=autho]").each(function(){ 
						var flag=$("#cbox_06").attr('checked');
						$(this).attr('checked',flag);
					});
			});		
			$("#saveDate").click (function(){
					weaver.submit();
			});
			$(".navigation li").click (function(){
					$(this).parent().children().removeClass("selectedli"); 
					$(this).addClass("selectedli");
					var temp=$(this).attr("item");
					if(temp<=7)
					{
						$("#sap_01").hide();
						$("#sap_02").hide();
						$("#sap_03").hide();
						$("#sap_04").hide();
						$("#sap_05").hide();
						$("#sap_06").hide();
						$("#sap_07").hide();
						$("#sap_0"+temp).show();
					}
					//$(this).blur();//����ʧȥ��������
			});
 	}); 

 	function checkbox2(obj,chtable)
 	{
 		//�õ��ӱ��id
 		var newtable=$("#sap_02"+"_"+chtable);
		$("#sap_02"+"_"+chtable+" tr td:first-child [type=checkbox][name=zibox]").each(function(){ 
			var flag=obj.checked;
			$(this).attr('checked',flag);
		});
 	}

 	function checkbox4(obj,chtable)
 	{
 		//�õ��ӱ��id
 		var newtable=$("#sap_04"+"_"+chtable);
		$("#sap_04"+"_"+chtable+" tr td:first-child [type=checkbox][name=zibox]").each(function(){ 
			var flag=obj.checked;
			$(this).attr('checked',flag);
		});
 	}
 	function checkbox5(obj,chtable)
 	{
 		//�õ��ӱ��id
 		var newtable=$("#sap_05"+"_"+chtable);
		$("#sap_05"+"_"+chtable+" tr td:first-child [type=checkbox][name=zibox]").each(function(){ 
			var flag=obj.checked;
			$(this).attr('checked',flag);
		});
 	}
 	function checkbox7(obj,chtable)
 	{
 		//�õ��ӱ��id
 		var newtable=$("#sap_07"+"_"+chtable);
		$("#sap_07"+"_"+chtable+" tr td:first-child [type=checkbox][name=zibox]").each(function(){ 
			var flag=obj.checked;
			$(this).attr('checked',flag);
		});
 	}
 	function checkbox5son(obj,chtable)
 	{
 		//�õ��ӱ��id
 		var newtable=$("#sapson_05"+"_"+chtable);
		$("#sapson_05"+"_"+chtable+" tr td:first-child [type=checkbox][name=zibox]").each(function(){ 
			var flag=obj.checked;
			$(this).attr('checked',flag);
		});
 	}
 	setInterval(flashText, 500);  
 	function flashText()
 	{
 		//����iframe����Ӧ���ݸ߶�
 		var ifheight=$("#tableid").height();
 		window.parent.document.getElementById("maindiv").style.height=ifheight;
 	}

 	//ѡ��oa�ֶ�
 	//wfid���̵�id
 	//�����ť����
 	//haveimg�Ƿ���img���span,0û��,1��
 	function addOneFieldObjOA(obj,haveimg)
 	{
 	
 			//function addOneFieldObjOA��׼ 
			//--------------<button> �����ť
			//--------------<input>  ���ص�oa�ֶ�name
			//--------------<span>   ��ʾ��oa�ֶ�name
			//--------------<span>   ��ʾimg
			//--------------<input>  ��¼�ֶ�(�Ƿ����ֶΣ��ֶε����ݿ�id,)
 			var formid=$("#formid").val();
 			var checkvalue=$(obj).next().val();
 		 	var temp=window.showModalDialog("/integration/browse/integrationBatchOA.jsp?formid=","","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 			if(temp)
		 	{
		 		 if (temp.names!=""&&temp.viewtype!="-1") {
					var tempname=temp.name.split("##");
					$(obj).next().val(tempname[1]);
				 }else {
				 	
				 }
		 	}
 	}
 	
 	
 	//���е����ֶβ���
 	//type=1��ʾ�������,obj��ʾsap�ֶ������ť
 	//type=2��ʾ����ṹ,obj��ʾ�ṹ���������ť��id
 	//type=3��ʾ����ṹ-->>ĳ���ṹ��-->>sap�ֶ�,������Ҫ�ṩ�ṹ���id
 	//type=4��ʾ���������obj��ʾsap�ֶ������ť
 	//type=5��ʾ����ṹ,obj��ʾ�ṹ���������ť
 	//type=6��ʾ����ṹ-->>ĳ���ṹ-->>sap�ֶ�,������Ҫ�ṩ�ṹ��ĵ�id
 	//type=7��ʾ�����,obj��ʾ���������ť
 	//type=8��ʾ�����-->>ĳ����-->>>>sap�ֶ�,������Ҫ�ṩ����ı����id
 	//type=9��ʾ�����,obj��ʾ���������ť
 	//type=10��ʾ�����-->>ĳ����-->>>>sap�ֶ�,������Ҫ�ṩ����ı����id
 	function addOneFieldObj(type,nums,stuname)
 	{
 			if(type == 1) {
 				var input01="sap01_"+nums;
				var input01Span="sap01_"+nums+"Span";
				var input02="sapDesc01_"+nums;
 				var lengthtemp = $("#hidden01").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							if(i == nums) continue;
							var valuetemp = $("input[name='sap01_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid%>&type=1&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("input[name='"+input02+"']").attr("value",temp.name);
 						$("#"+input01Span).html("");
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						$("input[name='"+input02+"']").attr("value","");
 					 }
 			 	}
 			}
 			
 			if(type == 4) {
 				var input01="sap03_"+nums;
				var input01Span="sap03_"+nums+"span";
				var input02="sapDesc03_"+nums;
 				var lengthtemp = $("#hidden03").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							if(i == nums) continue;
							var valuetemp = $("input[name='sap03_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type=4&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("input[name='"+input02+"']").attr("value",temp.name);
 						$("#"+input01Span).html("");
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						$("input[name='"+input02+"']").attr("value","");
 					 }
 			 	}
 			}
 			
 			if(type == 2) {
 				var input01="stru_"+nums;
				var input01Span="stru_"+nums+"span";
				var $bath2Btn = $("#bath2_"+nums);
	 			var $addFieldBtn = $("#addstru_"+nums);
				var $delFieldBtn = $("#delstru_"+nums);
				var lengthtemp = $("#hidden02").val();
				var disValue = '';
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i == nums) continue;
						var valuetemp = $("input[name='stru_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type=2&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
		 			 if($.trim($("input[name='"+input01+"']").attr("value"))!=$.trim(temp.id)) {
			 				var lengthtemp3 = $("#cbox2"+"_"+nums).val();
			 				for(var i=1;i<=lengthtemp3;i++) {
			 					var input013="sap02_"+nums+"_"+i;
			 					$("input[name='"+input013+"']").parent().parent().remove();
			 				}
			 			 }

 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("#"+input01Span).html("");
 						 $bath2Btn.attr("disabled","");
 			 			 $addFieldBtn.attr("disabled","");
 						 $delFieldBtn.attr("disabled","");
 						 
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 					 }
 			 	}
				
 			}
 			
 			if(type == 5) {
 				var input01="outstru_"+nums;
				var input01Span="outstru_"+nums+"span";
				var $bath2Btn = $("#bath4_"+nums);
	 			var $addFieldBtn = $("#addoutstru_"+nums);
				var $delFieldBtn = $("#deloutstru_"+nums);
				var lengthtemp = $("#hidden04").val();
				var disValue = '';
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i == nums) continue;
						var valuetemp = $("input[name='outstru_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type=5&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
 					 if($.trim($("input[name='"+input01+"']").attr("value"))!=$.trim(temp.id)) {
			 				var lengthtemp3 = $("#cbox4"+"_"+nums).val();
			 				for(var i=1;i<=lengthtemp3;i++) {
			 					var input013="sap04_"+nums+"_"+i;
			 					$("input[name='"+input013+"']").parent().parent().remove();
			 				}
			 			 }
 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("#"+input01Span).html("");
 						 $bath2Btn.attr("disabled","");
 			 			 $addFieldBtn.attr("disabled","");
 						 $delFieldBtn.attr("disabled","");
 						 
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 					 }
 			 	}
				
 			}
 			
 			if(type == 10) {
				
 				var input01="outtable7_"+nums;
				var input01Span="outtable7_"+nums+"span";
				var $bath2Btn = $("#bath7_"+nums);
	 			var $addFieldBtn = $("#addtable_"+nums);
				var $delFieldBtn = $("#deltable_"+nums);
				var lengthtemp = $("#hidden07").val();
				var disValue = '';
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i == nums) continue;
						var valuetemp = $("input[name='outtable7_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type=10&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
 					 if($.trim($("input[name='"+input01+"']").attr("value"))!=$.trim(temp.id)) {
			 				var lengthtemp3 = $("#cbox7"+"_"+nums).val();
			 				for(var i=1;i<=lengthtemp3;i++) {
			 					var input013="sap07_"+nums+"_"+i;
			 					$("input[name='"+input013+"']").parent().parent().remove();
			 				}
			 			 }
 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("#"+input01Span).html("");
 						 $bath2Btn.attr("disabled","");
 			 			 $addFieldBtn.attr("disabled","");
 						 $delFieldBtn.attr("disabled","");
 						 
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 					 }
 			 	}
				
 			}
 			
 			if(type == 7) {
 				var input01="outtable_"+nums;
				var input01Span="outtable_"+nums+"span";
				var $bath2Btn = $("#bath5_"+nums);
	 			var $addFieldBtn = $("#addouttable_"+nums);
				var $delFieldBtn = $("#delouttable_"+nums);
				var lengthtemp = $("#hidden05").val();
				var disValue = '';
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i == nums) continue;
						var valuetemp = $("input[name='outtable_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type=7&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
 					 if($.trim($("input[name='"+input01+"']").attr("value"))!=$.trim(temp.id)) {
			 				var lengthtemp3 = $("#cbox5"+"_"+nums).val();
			 				for(var i=1;i<=lengthtemp3;i++) {
			 					var input013="sap05_"+nums+"_"+i;
			 					$("input[name='"+input013+"']").parent().parent().remove();
			 				}
			 			 }
 			 		 if (temp.id!="" && temp.id != 0){
 						$("input[name='"+input01+"']").attr("value",temp.id);
 						$("#"+input01Span).html("");
 						 $bath2Btn.attr("disabled","");
 			 			 $addFieldBtn.attr("disabled","");
 						 $delFieldBtn.attr("disabled","");
 						 
 					 }else {
 						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
 						$("input[name='"+input01+"']").attr("value","");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 					 }
 			 	}
 			}
 		 	
 			if(type == 3) {
 				var input01="sap02_"+nums;
				var input01Span="sap02_"+nums+"span";
				var input02="sapDesc02_"+nums;
				var chtable = input01.split("_")[1];
				var numtemp = input01.split("_")[2];
				var lengthtemp = $("#cbox2"+"_"+chtable).val();
				var disValue = '';
				
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i== numtemp)continue;
						var valuetemp = $("input[name='sap02_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}	
				var stuortablevalue=$("#"+stuname).val();
 				if(stuortablevalue == ''){
 					alert("�ṹ��������Ϊ�գ�");
 					return;
 				}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
			 		 if (temp.id!="" && temp.id != 0){
						$("input[name='"+input01+"']").attr("value",temp.id);
						$("input[name='"+input02+"']").attr("value",temp.name);
						$("#"+input01Span).html("");
					 }else {
						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
						$("input[name='"+input01+"']").attr("value","");
						$("input[name='"+input02+"']").attr("value","");
					 }
			 	}
 			}
 			
 			if(type == 6) {
 				var input01="sap04_"+nums;
				var input01Span="sap04_"+nums+"span";
				var input02="sapDesc04_"+nums;
				var chtable = input01.split("_")[1];
				var numtemp = input01.split("_")[2];
				var lengthtemp = $("#cbox4"+"_"+chtable).val();
				var disValue = '';
				
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i== numtemp)continue;
						var valuetemp = $("input[name='sap04_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}	
				var stuortablevalue=$("#"+stuname).val();
 				if(stuortablevalue == ''){
 					alert("<%=SystemEnv.getHtmlLabelName(30715,user.getLanguage())%>��");
 					return;
 				}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
			 		 if (temp.id!="" && temp.id != 0){
						$("input[name='"+input01+"']").attr("value",temp.id);
						$("input[name='"+input02+"']").attr("value",temp.name);
						$("#"+input01Span).html("");
					 }else {
						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
						$("input[name='"+input01+"']").attr("value","");
						$("input[name='"+input02+"']").attr("value","");
					 }
			 	}
 			}
 			
 			if(type == 11) {
 				var input01="sap07_"+nums;
				var input01Span="sap07_"+nums+"span";
				var input02="sapDesc07_"+nums;
				var chtable = input01.split("_")[1];
				var numtemp = input01.split("_")[2];
				var lengthtemp = $("#cbox7"+"_"+chtable).val();
				var disValue = '';
				
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i== numtemp)continue;
						var valuetemp = $("input[name='sap07_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}	
				var stuortablevalue=$("#"+stuname).val();
 				if(stuortablevalue == ''){
 					alert("<%=SystemEnv.getHtmlLabelName(30718,user.getLanguage())%>��");
 					return;
 				}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
			 		 if (temp.id!="" && temp.id != 0){
						$("input[name='"+input01+"']").attr("value",temp.id);
						$("input[name='"+input02+"']").attr("value",temp.name);
						$("#"+input01Span).html("");
					 }else {
						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
						$("input[name='"+input01+"']").attr("value","");
						$("input[name='"+input02+"']").attr("value","");
					 }
			 	}
 			}
 			
 			if(type == 8) {
 				var input01="sap05_"+nums;
				var input01Span="sap05_"+nums+"span";
				var input02="sapDesc05_"+nums;
				var chtable = input01.split("_")[1];
				var numtemp = input01.split("_")[2];
				var lengthtemp = $("#cbox5"+"_"+chtable).val();
				var disValue = '';
				
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						if(i== numtemp)continue;
						var valuetemp = $("input[name='sap05_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}	
				var stuortablevalue=$("#"+stuname).val();
 				if(stuortablevalue == ''){
 					alert("<%=SystemEnv.getHtmlLabelName(30721,user.getLanguage())%>��");
 					return;
 				}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?operation=2&servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
 				if(temp) {
			 		 if (temp.id!="" && temp.id != 0){
						$("input[name='"+input01+"']").attr("value",temp.id);
						$("input[name='"+input02+"']").attr("value",temp.name);
						$("#"+input01Span).html("");
					 }else {
						$("#"+input01Span).html("<img src='/images/BacoError.gif' align='center'>");
						$("input[name='"+input01+"']").attr("value","");
						$("input[name='"+input02+"']").attr("value","");
					 }
			 	}
 			}
 			
 	}
 	
 	function sapFieldChange(type,obj) {
 		if(type == 1) {
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(6);
 			var $objspan = $("#"+objname+"Span");
 			var objvalue = $(obj).attr("value");
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden01").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('sap01_'+i)) continue;
 					var comtemp = $("input[name='sap01_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:1,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc01_"+hiddenNum+"']").attr("value",data["message"]);
						}	
				},"json");
 			}
 		}
 		
 		if(type == 4) {
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(6);
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden03").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('sap03_'+i)) continue;
 					var comtemp = $("input[name='sap03_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:4,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc03_"+hiddenNum+"']").attr("value",data["message"]);
						}	
				},"json");
 			}	
 		}
 		
 	if(type == 2) {
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(5);
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			
 			var lengthtemp = $("#cbox2"+"_"+hiddenNum).val();
 		
			for(var i=1;i<=lengthtemp;i++) {
				var input01="sap02_"+hiddenNum+"_"+i;
				$("input[name='"+input01+"']").parent().parent().remove();
			}
			
 			var $bath2Btn = $("#bath2_"+hiddenNum);
 			var $addFieldBtn = $("#addstru_"+hiddenNum);
			var $delFieldBtn = $("#delstru_"+hiddenNum);
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 				$bath2Btn.attr("disabled","disabled");
	 			 $addFieldBtn.attr("disabled","disabled");
				 $delFieldBtn.attr("disabled","disabled");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden02").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('stru_'+i)) continue;
 					var comtemp = $("input[name='stru_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30725,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:2,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30726,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
	 						 $bath2Btn.attr("disabled","disabled");
	 			 			 $addFieldBtn.attr("disabled","disabled");
	 						 $delFieldBtn.attr("disabled","disabled");
						}else {
							 $bath2Btn.attr("disabled","");
	 			 			 $addFieldBtn.attr("disabled","");
	 						 $delFieldBtn.attr("disabled","");
						}
				},"json");
 			}
 		}
 		
 		if(type == 5) {
 			
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(8);
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox4"+"_"+hiddenNum).val();
 			
 			for(var i=1;i<=lengthtemp;i++) {
				var input01="sap04_"+hiddenNum+"_"+i;
				$("input[name='"+input01+"']").parent().parent().remove();
			}
 			var $bath2Btn = $("#bath4_"+hiddenNum);
 			var $addFieldBtn = $("#addoutstru_"+hiddenNum);
			var $delFieldBtn = $("#deloutstru_"+hiddenNum);
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 				$bath2Btn.attr("disabled","disabled");
	 			 $addFieldBtn.attr("disabled","disabled");
				 $delFieldBtn.attr("disabled","disabled");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden04").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('outstru_'+i)) continue;
 					var comtemp = $("input[name='outstru_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30725,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:5,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30726,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
	 						 $bath2Btn.attr("disabled","disabled");
	 			 			 $addFieldBtn.attr("disabled","disabled");
	 						 $delFieldBtn.attr("disabled","disabled");
						}else {
							 $bath2Btn.attr("disabled","");
	 			 			 $addFieldBtn.attr("disabled","");
	 						 $delFieldBtn.attr("disabled","");
						}
				},"json");
 			}
 		}
 		
 		if(type == 10) {
 			
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(10);
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			
 			var lengthtemp = $("#cbox7"+"_"+hiddenNum).val();
 		
			for(var i=1;i<=lengthtemp;i++) {
				var input01="sap07_"+hiddenNum+"_"+i;
				$("input[name='"+input01+"']").parent().parent().remove();
			}
			
 			var $bath2Btn = $("#bath7_"+hiddenNum);
 			var $addFieldBtn = $("#addtable_"+hiddenNum);
			var $delFieldBtn = $("#deltable_"+hiddenNum);
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 				$bath2Btn.attr("disabled","disabled");
	 			 $addFieldBtn.attr("disabled","disabled");
				 $delFieldBtn.attr("disabled","disabled");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden07").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('outtable7_'+i)) continue;
 					var comtemp = $("input[name='outtable7_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30727,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:10,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30728,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
	 						 $bath2Btn.attr("disabled","disabled");
	 			 			 $addFieldBtn.attr("disabled","disabled");
	 						 $delFieldBtn.attr("disabled","disabled");
						}else {
							 $bath2Btn.attr("disabled","");
	 			 			 $addFieldBtn.attr("disabled","");
	 						 $delFieldBtn.attr("disabled","");
						}
				},"json");
 			}
 		}
 		
 		if(type == 7) {
 			var objname = $(obj).attr("name");
 			var hiddenNum = objname.substring(9);
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox5"+"_"+hiddenNum).val();
 			
 			for(var i=1;i<=lengthtemp;i++) {
				var input01="sap05_"+hiddenNum+"_"+i;
				$("input[name='"+input01+"']").parent().parent().remove();
			}
 			var $bath2Btn = $("#bath5_"+hiddenNum);
 			var $addFieldBtn = $("#addouttable_"+hiddenNum);
			var $delFieldBtn = $("#delouttable_"+hiddenNum);
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 				$bath2Btn.attr("disabled","disabled");
	 			 $addFieldBtn.attr("disabled","disabled");
				 $delFieldBtn.attr("disabled","disabled");
 			}else {
 				$objspan.html("");
 				var hiddensum = $("#hidden05").attr("value");
 				for(var i=1;i<=hiddensum;i++) {
 					if(objname==('outtable_'+i)) continue;
 					var comtemp = $("input[name='outtable_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30727,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						 $bath2Btn.attr("disabled","disabled");
 			 			 $addFieldBtn.attr("disabled","disabled");
 						 $delFieldBtn.attr("disabled","disabled");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{type:7,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30728,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
	 						 $bath2Btn.attr("disabled","disabled");
	 			 			 $addFieldBtn.attr("disabled","disabled");
	 						 $delFieldBtn.attr("disabled","disabled");
						}else {
							 $bath2Btn.attr("disabled","");
	 			 			 $addFieldBtn.attr("disabled","");
	 						 $delFieldBtn.attr("disabled","");
						}
				},"json");
 			}
 		}
 		
 		if(type == 3) {
 			var objname = $(obj).attr("name");
 			var chtabletemp = objname.split("_")[1];
 			var compParamName = $("#stru_"+chtabletemp).attr("value");
 			var nowtemp = objname.split("_")[2];
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox2"+"_"+chtabletemp).val();
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				for(var i=1;i<=lengthtemp;i++) {
 					if(objname==('sap02_'+chtabletemp+"_"+i)) continue;
 					var comtemp = $("input[name='sap02_"+chtabletemp+"_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{compParamName:compParamName,type:3,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc02_"+chtabletemp+"_"+nowtemp+"']").attr("value",data["message"]);
						}	
				},"json");
 			}
 		}
 		
 		if(type==6) {
 			var objname = $(obj).attr("name");
 			var chtabletemp = objname.split("_")[1];
 			var compParamName = $("#outstru_"+chtabletemp).attr("value");
 			var nowtemp = objname.split("_")[2];
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox4"+"_"+chtabletemp).val();
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				for(var i=1;i<=lengthtemp;i++) {
 					if(objname==('sap04_'+chtabletemp+"_"+i)) continue;
 					var comtemp = $("input[name='sap04_"+chtabletemp+"_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{compParamName:compParamName,type:6,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc04_"+chtabletemp+"_"+nowtemp+"']").attr("value",data["message"]);
						}	
				},"json");
 			}
 		}
 		
 		if(type==8) {
 			var objname = $(obj).attr("name");
 			var chtabletemp = objname.split("_")[1];
 			var compParamName = $("#outtable_"+chtabletemp).attr("value");
 			var nowtemp = objname.split("_")[2];
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox5"+"_"+chtabletemp).val();
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				for(var i=1;i<=lengthtemp;i++) {
 					if(objname==('sap05_'+chtabletemp+"_"+i)) continue;
 					var comtemp = $("input[name='sap05_"+chtabletemp+"_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{compParamName:compParamName,type:8,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc05_"+chtabletemp+"_"+nowtemp+"']").attr("value",data["message"]);
						}	
				},"json");
 			}
 		}
 		
 		if(type==11) {
 			var objname = $(obj).attr("name");
 			var chtabletemp = objname.split("_")[1];
 			var compParamName = $("#outtable7_"+chtabletemp).attr("value");
 			var nowtemp = objname.split("_")[2];
 			var $objspan = $("#"+objname+"span");
 			var objvalue = $(obj).attr("value");
 			var lengthtemp = $("#cbox7"+"_"+chtabletemp).val();
 			if(objvalue == '') {
 				$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 			}else {
 				$objspan.html("");
 				for(var i=1;i<=lengthtemp;i++) {
 					if(objname==('sap07_'+chtabletemp+"_"+i)) continue;
 					var comtemp = $("input[name='sap07_"+chtabletemp+"_"+i+"']").attr("value");
 					if($.trim(objvalue) == $.trim(comtemp)) {
 						alert("<%=SystemEnv.getHtmlLabelName(30723,user.getLanguage())%>��");
 						$(obj).attr("value","");
 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
 						return;
 					}
 				}
 				$.post("/integration/serviceReg/checkServiceParamsAjax.jsp",{compParamName:compParamName,type:11,seviceId:<%=servId%>,paramName:objvalue},function(data){ 
						if(!data["flag"]) {
							alert("<%=SystemEnv.getHtmlLabelName(30724,user.getLanguage())%>��");
	 						$(obj).attr("value","");
	 						$objspan.html("<img src='/images/BacoError.gif' align='center'>");
						}else {
							$("input[name='sapDesc07_"+chtabletemp+"_"+nowtemp+"']").attr("value",data["message"]);
						}	
				},"json");
 			}
 		}
 		
 	}
 	//���������ֶβ���
 	//type=1��ʾ�������,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=2��ʾ����ṹ,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=3��ʾ����ṹ,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť),stuname(�ṹ����������ڵ��ı����id)������ֵ,chtable(�ṹ�����ˮ���)������ֵ
 	//type=4��ʾ���������source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=5��ʾ����ṹ,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=6��ʾ����ṹ,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť),stuname(�ṹ����������ڵ��ı����id)������ֵ
 	//type=7��ʾ�����,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=8��ʾ�����,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť),stuname(�������������ڵ��ı����id)������ֵ
 	//type=9��ʾ����Ȩ������,source=1(���������ť),source=2(�����Ӱ�ť),source=3(���ɾ����ť)
 	//type=10��ʾ�����
 	//type=11��ʾ�����
 	//type=12��ʾ������where���������
 	function addBathFieldObj(type,source,stuname,chtable)
 	{
 		if(type=="1")
 		{
 				if(source=="1")
 				{
 						var lengthtemp = $("#hidden01").val();
 						var disValue = '';
 						var numSum = 1;
 						if(lengthtemp>=1) {
 							for(var i=1;i<=lengthtemp;i++) {
 								var valuetemp = $("input[name='sap01_"+i+"']").attr("value");
 								if($.trim(valuetemp)== '') continue;
 								if(numSum == 1) {
 									disValue = valuetemp;
 								}else {
 									disValue += ","+valuetemp;
 								}
 								numSum ++;
 							}
 						}
 						var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
						if(temp)
						{
							if (temp.id!="" && temp.id != 0) {
								var tempsz=temp.id.split("##");
								var tempname = temp.name.split("##");
								for(var ij=0;ij<tempsz.length;ij++)
								{
									if(tempsz[ij])
									{
										var shuzi=parseInt($("#hidden01").val())+1;
										var input01="sap01_"+shuzi;
										var input01Span="sap01_"+shuzi+"Span";
										var input02="sapDesc01_"+shuzi;
										var input03="con01_"+shuzi;
										var vTb=$("#chind01");
										var temp = "<td><input type='checkbox' name='cbox1'></td><td><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td>";
										temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(1,"+shuzi+")></button></span>";
										temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
										temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' value='"+tempsz[ij]+"' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(1,this)'></span>";
										temp += "</td><td><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' name='"+input02+"' style='border:1px solid #D4E9E9;width:185px;height:28px;' value='"+tempname[ij]+"'></td>";
										temp += "<td><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' ";
										temp += "name='"+input03+"' style='border:1px solid #D4E9E9;width:170px;height:28px;'></td>"
										var td = $(temp);
										var row = $("<tr style='height:40px;'></tr>");
										row.append(td); 
										vTb.append(row); 
										//�õ���������
										//var temp=$("#chind01").get(0).rows.length;
										$("#hidden01").attr("value",shuzi);
									}
								}
							}
						}
 				}else if(source=="2")
 				{
 						var shuzi=parseInt($("#hidden01").val())+1;
						var input01="sap01_"+shuzi;
						var input01Span="sap01_"+shuzi+"Span";
						var input02="sapDesc01_"+shuzi;
						var input03="con01_"+shuzi;
						var vTb=$("#chind01");
						var temp = "<td><input type='checkbox' name='cbox1'></td><td><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td>";
						temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(1,"+shuzi+")></button></span>";
						temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
						temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(1,this)'></span>";
						temp += "</td><td><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' name='"+input02+"' style='border:1px solid #D4E9E9;width:185px;height:28px;'></td>";
						temp += "<td><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' ";
						temp += "name='"+input03+"' style='border:1px solid #D4E9E9;width:170px;height:28px;'></td>"
						var td = $(temp);
						var row = $("<tr style='height:40px;'></tr>");
						row.append(td); 
						vTb.append(row); 
						//�õ���������
						//var temp=$("#chind01").get(0).rows.length;
						$("#hidden01").attr("value",shuzi);
 				}else if(source=="3")
 				{
						var vTb=$("#chind01");
						var checked = $("#chind01 input[type='checkbox'][name='cbox1'][checked=true]"); 
						if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
								$(checked).each(function(){ 
									if($(this).attr("checked")==true) 
									{ 
										$(this).parent().parent().remove(); 
										//var shuzi=parseInt($("#hidden01").val())-1;
										//�õ���������
										//var temp=$("#chind01").get(0).rows.length;
										//$("#hidden01").attr("value",shuzi);
									} 
								}); 
							}
						}else{
							alert("��ѡ����Ҫɾ�����");
						}
 				}
 					
 		}else if(type=="2")
 		{
 			if(source=="1")
 			{
 				    var lengthtemp = $("#hidden02").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							var valuetemp = $("input[name='stru_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}	
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
					if(temp)
					{
						if (temp.id!="" && temp.id != 0) 
						{
							var tempsz=temp.id.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
										var chtable=parseInt($("#hidden02").val())+1;
										var shuzi=parseInt(chtable)+1;
										var newname="cbox2"+"_"+chtable;
										var newtable="sap_02"+"_"+chtable;
										var newstru="stru_"+chtable;
										var newstruSpan="stru_"+chtable+"span";
										var bath="bath2_"+chtable;
										var addFieldBtn = "addstru_"+chtable;
										var delFieldBtn = "delstru_"+chtable;
										
										var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox2'></td>"); 	
										var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
									    temp += " style='vertical-align: middle;' onclick=addOneFieldObj(2,"+chtable+",'"+newstru+"')></button>"; 
									    temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:15px;'>"; 
									    temp += " </span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(2,this)' style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
									    temp += " </td><td>";
									    temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
									    temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
									    temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
									    temp += " onclick='checkbox2(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td><td style='text-align:right;' colspan='7'>";
									    temp += "<button type='button'  class='btn' id='"+bath+"'"; 
									    temp += " onclick=addBathFieldObj(3,1,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
									    temp += " <button type='button' class='btn' id='"+addFieldBtn+"' ";  
									    temp += " onclick=addBathFieldObj(3,2,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
									    temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
									    temp += " onclick=addBathFieldObj(3,3,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>"; 
									    temp += "</td></tr>";
									    temp += "  <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'></TD></TR>"
									    temp += " </TABLE>";
									   
										row.append(temp);	
										row.append("</td></tr>");
										var vTb=$("#sap_02");
										vTb.append(row); 
										//�õ���������
										//var temp=$("#chind02").get(0).rows.length;
										$("#hidden02").attr("value",chtable);
								}
							}
						}
					}
 			}else if(source=="2")
 			{
 				// <COLGROUP><COL width='60px'/><COL width='80px'/><COL width='180px'/><COL width='80px'/><COL width='180px'/><COL width='60px'/><COL width='*'/></COLGROUP>
				//style='table-layout: fixed;'
				var chtable=parseInt($("#hidden02").val())+1;
				var shuzi=parseInt(chtable)+1;
				var newname="cbox2"+"_"+chtable;
				var newtable="sap_02"+"_"+chtable;
				var newstru="stru_"+chtable;
				var newstruSpan="stru_"+chtable+"span";
				var bath="bath2_"+chtable;
				var addFieldBtn = "addstru_"+chtable;
				var delFieldBtn = "delstru_"+chtable;
				var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox2'></td>"); 	
				var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
				    temp += " style='vertical-align: middle;' onclick=addOneFieldObj(2,"+chtable+",'"+newstru+"')></button>"; 
				    temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'><img src='/images/BacoError.gif'"; 
				    temp += " align=absMiddle></span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(2,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
				    temp += " </td><td>"; 
				    temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
				    temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
				    temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
				    temp += " onclick='checkbox2(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
				    temp += " <td colspan='7' style='text-align:right;'>";
				    temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(3,1,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
				    temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
				    temp += " onclick=addBathFieldObj(3,2,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
				    temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
				    temp += " onclick=addBathFieldObj(3,3,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
				    temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'>";
				    temp += " </TD></TR></TABLE>";
					row.append(temp);
					row.append("</td></tr>");
					var vTb=$("#sap_02");
					vTb.append(row); 
					//�õ���������
					//var temp=$("#chind02").get(0).rows.length;
					$("#hidden02").attr("value",chtable);
 			}else if(source=="3")
 			{
 					var vTb=$("#sap_02");
					var checked = $("#sap_02 input[type='checkbox'][name='cbox2'][checked=true]"); 
					if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
								$(checked).each(function(){ 
									if($(this).attr("checked")==true) 
									{ 
										$(this).parent().parent().remove(); 
									} 
								}); 
							}
				}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="3")
 		{
 			if(source=="1")
 			{
 				
 				var stuortablevalue=$("#"+stuname).val();
 				var lengthtemp = $("#cbox2"+"_"+chtable).val();
				var disValue = '';
				var numSum = 1;
				if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						var valuetemp = $("input[name='sap02_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
				}	
				
 				if(stuortablevalue == ''){
 					alert("�ṹ��������Ϊ�գ�");
 					return;
 				}
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							var tempname = temp.name.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									//�õ��ӱ�Ķ���
							 		var newtable=$("#sap_02"+"_"+chtable);
		 							var newchtable=parseInt($("#cbox2"+"_"+chtable).val())+1;
							 		var input01="sap02_"+chtable+"_"+newchtable;
									var input03="con02_"+chtable+"_"+newchtable;
									var input01Desc = "sapDesc02_"+chtable+"_"+newchtable;
									var input01Span="sap02_"+chtable+"_"+newchtable+"span";
									var numstemp = chtable+"_"+newchtable;
									var temp = "";
									temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
									temp += "<button type='button' style='vertical-align: middle;' class='browser'";
									temp += " onclick=addOneFieldObj(3,'"+numstemp+"','"+stuname+"')></button>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<input type='text' name='"+input01+"'";  
									temp += " value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(3,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
									temp += "<input type='text' name='"+input01Desc+"'";  
									temp += " value='"+tempname[ij]+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:80px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td>";
									temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
							 		newtable.append($(temp)); 
							 		$("#cbox2"+"_"+chtable).attr("value",newchtable);
						 		}
						 	}
					 }
				 }
 			}else if(source=="2")
 			{
 				 		//�õ��ӱ�Ķ���
					 		var newtable=$("#sap_02"+"_"+chtable);
					 		var newchtable=parseInt($("#cbox2"+"_"+chtable).val())+1;
					 		var input01="sap02_"+chtable+"_"+newchtable;
							var input03="con02_"+chtable+"_"+newchtable;
							var input01Desc = "sapDesc02_"+chtable+"_"+newchtable;
							var input01Span="sap02_"+chtable+"_"+newchtable+"span";
							var numstemp = chtable+"_"+newchtable;
							var temp = "";
							temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
							temp += "<button type='button' style='vertical-align: middle;' class='browser'";
							temp += " onclick=addOneFieldObj(3,'"+numstemp+"','"+stuname+"')></button>";
							temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
							temp += "<input type='text' name='"+input01+"'";  
							temp += " value='' onchange='javascript:sapFieldChange(3,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
							temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
							temp += "<input type='text' name='"+input01Desc+"'";  
							temp += " value='' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
							temp += "</td><td style='width:80px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td>";
							temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
					 		newtable.append($(temp)); 
					 		$("#cbox2"+"_"+chtable).attr("value",newchtable);
 			}else if(source=="3")
 			{
 				 		var checked = $("#sap_02"+"_"+chtable+" input[type='checkbox'][name='zibox'][checked=true]");
 				 		if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){ 
									$(checked).each(function(){ 
										if($(this).attr("checked")==true) 
										{ 
											$(this).parent().parent().remove(); 
										} 
									}); 
								}
						}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="4")
 		{
 			if(source=="1")
 			{
 				
 				var lengthtemp = $("#hidden03").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							var valuetemp = $("input[name='sap03_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}
					var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							var tempnames=temp.name.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									var shuzi=parseInt($("#hidden03").val())+1;
									var input01="sap03_"+shuzi;
									var input01Span="sap03_"+shuzi+"span";
									var input02="sapDesc03_"+shuzi;//��ʾ��--�ı���
									//var input04Span="setoa_"+shuzi+"span";
									var vTb=$("#chind03");
									var temp = "<td><input type='checkbox' name='cbox3'></td><td><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td>";
									temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(4,"+shuzi+")></button></span>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' value='"+tempsz[ij]+"' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(4,this)'></span>";
									temp += "</td><td><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' name='"+input02+"' value='"+tempnames[ij]+"' style='border:1px solid #D4E9E9;width:185px;height:28px;' ></td>";
									var td = $(temp);
									var row = $("<tr style='height:40px;'></tr>");
									row.append(td); 
									vTb.append(row); 
									//�õ���������
									//var temp=$("#chind03").get(0).rows.length;
									$("#hidden03").attr("value",shuzi);
								}
							}
						}
				}
 			}else if(source=="2")
 			{
 				
 					var shuzi=parseInt($("#hidden03").val())+1;
					var input01="sap03_"+shuzi;
					var input01Span="sap03_"+shuzi+"span";
					var input02="sapDesc03_"+shuzi;//��ʾ��--�ı���
					
					//var input04Span="setoa_"+shuzi+"span";
					var vTb=$("#chind03");
					var temp = "<td><input type='checkbox' name='cbox3'></td><td><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td>";
					temp += "<td style='padding-top:6px;'><span><button type='button' class='browser' onclick=addOneFieldObj(4,"+shuzi+")></button></span>";
					temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
					temp += "<span style='vertical-align: middle;'><input type='text' name='"+input01+"' value='' style='border:1px solid #D4E9E9;width:172px;height:28px;' onchange='javascript:sapFieldChange(4,this)'></span>";
					temp += "</td><td><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top:5px;'><input type='text' name='"+input02+"' style='border:1px solid #D4E9E9;width:185px;height:28px;' value=''></td>";
					var td = $(temp);
					var row = $("<tr style='height:40px;'></tr>");
					row.append(td); 
					vTb.append(row); 
					//�õ���������
					//var temp=$("#chind03").get(0).rows.length;
					$("#hidden03").attr("value",shuzi);
 			}else if(source=="3")
 			{
 					var vTb=$("#chind03");
					var checked = $("#chind03 input[type='checkbox'][name='cbox3'][checked=true]"); 
					if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
								$(checked).each(function(){ 
									if($(this).attr("checked")==true) 
									{ 
										$(this).parent().parent().remove(); 
									} 
								}); 
						}
					}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="5")
 		{
 			if(source=="1")
 			{
 				 var lengthtemp = $("#hidden04").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							var valuetemp = $("input[name='outstru_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}	
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									var chtable=parseInt($("#hidden04").val())+1;
									var newname="cbox4"+"_"+chtable;
									var newtable="sap_04"+"_"+chtable;
									var newstru="outstru_"+chtable;
									var newstruSpan="outstru_"+chtable+"span";
									var bath="bath4_"+chtable;
									var addFieldBtn = "addoutstru_"+chtable;
									var delFieldBtn = "deloutstru_"+chtable;
									var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox4'></td>"); 	
									var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
									temp += " style='vertical-align: middle;' onclick=addOneFieldObj(5,"+chtable+",'"+newstru+"')></button>"; 
									temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
									temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(5,this)' value='"+tempsz[ij]+"'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
									temp += " </td><td>"; 
									temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
									temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
									temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
									temp += " onclick='checkbox4(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
									temp += " <td colspan='4' style='text-align:right;'>";
									temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(6,1,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
									temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
									temp += " onclick=addBathFieldObj(6,2,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
									temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
									temp += " onclick=addBathFieldObj(6,3,'"+newstru+"','"+chtable+"')><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
									temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
									temp += " </TD></TR></TABLE>";
									row.append(temp);
										row.append("</td></tr>");
										var vTb=$("#sap_04");
										vTb.append(row); 
										//var shuzi=parseInt(chtable)+1;
										//�õ���������
										$("#hidden04").attr("value",chtable);
									}
								}
					}
				}
 			}else if(source=="2")
 			{
 					var chtable=parseInt($("#hidden04").val())+1;
					var newname="cbox4"+"_"+chtable;
					var newtable="sap_04"+"_"+chtable;
					var newstru="outstru_"+chtable;
					var newstruSpan="outstru_"+chtable+"span";
					var bath="bath4_"+chtable;
					var addFieldBtn = "addoutstru_"+chtable;
					var delFieldBtn = "deloutstru_"+chtable;
					var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox4'></td>"); 	
					var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>�ṹ����</td><td style='width:220px;'><button type='button' class='browser' "; 
					temp += " style='vertical-align: middle;' onclick=addOneFieldObj(5,"+chtable+",'"+newstru+"')></button>"; 
					temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'><img src='/images/BacoError.gif'"; 
					temp += " align=absMiddle></span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(5,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
					temp += " </td><td>"; 
					temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
					temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
					temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
					temp += " onclick='checkbox4(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
					temp += " <td colspan='4' style='text-align:right;'>";
					temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(6,1,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
					temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
					temp += " onclick=addBathFieldObj(6,2,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
					temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
					temp += " onclick=addBathFieldObj(6,3,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
					temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
					temp += " </TD></TR></TABLE>";
					row.append(temp);
					row.append("</td></tr>");
					var vTb=$("#sap_04");
					vTb.append(row); 
						//var shuzi=parseInt(chtable)+1;
						//�õ���������
						$("#hidden04").attr("value",chtable);
 			}else if(source=="3")
 			{
 					var vTb=$("#sap_04");
					var checked = $("#sap_04 input[type='checkbox'][name='cbox4'][checked=true]"); 
					if(checked.length>0){ 
					if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
						$(checked).each(function(){ 
							if($(this).attr("checked")==true) 
							{ 
								$(this).parent().parent().remove(); 
							} 
						}); 
					}
					}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="6")
 		{
 			if(source=="1")
 			{
 					//alert("����ṹ"+$("#"+stuname).val());
 					var stuortablevalue=$("#"+stuname).val();
 					var lengthtemp = $("#cbox4"+"_"+chtable).val();
 					var disValue = '';
 					var numSum = 1;
 					if(lengthtemp>=1) {
 					for(var i=1;i<=lengthtemp;i++) {
 						var valuetemp = $("input[name='sap04_"+chtable+"_"+i+"']").attr("value");
 						if($.trim(valuetemp)== '') continue;
 						if(numSum == 1) {
 							disValue = valuetemp;
 						}else {
 							disValue += ","+valuetemp;
 						}
 						numSum ++;
 					}
 					}	

 					if(stuortablevalue == ''){
 					alert("�ṹ��������Ϊ�գ�");
 					return;
 					}
 					var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
					if(temp)
					{
			    	 	if (temp.id!="" && temp.id != 0)
			    	    {
								var tempsz=temp.id.split("##");
								var tempnames=temp.name.split("##");
								for(var ij=0;ij<tempsz.length;ij++)
								{
									if(tempsz[ij])
									{
									
													
										//�õ��ӱ��id
								 		var newtable=$("#sap_04"+"_"+chtable);
								 		var newchtable=parseInt($("#cbox4"+"_"+chtable).val())+1;
								 		var input01="sap04_"+chtable+"_"+newchtable;
								 		var input01Span="sap04_"+chtable+"_"+newchtable+"span";
								 		var input01Desc = "sapDesc04_"+chtable+"_"+newchtable;
										var numstemp = chtable+"_"+newchtable;
										var temp = "";
										temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
										temp += "<button type='button' style='vertical-align: middle;' class='browser'";
										temp += " onclick=addOneFieldObj(6,'"+numstemp+"','"+stuname+"')></button>";
										temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
										temp += "<input type='text' name='"+input01+"'";  
										temp += " value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(6,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
										temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
										temp += "<input type='text' name='"+input01Desc+"'";  
										temp += " value='"+tempnames[ij]+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
										temp += "</td></tr>";
										newtable.append($(temp)); 
								 		$("#cbox4"+"_"+chtable).attr("value",newchtable);
								 	}
								 }
						}
					}
 			}else if(source=="2")
 			{	
 			
 			
 					//�õ��ӱ��id
			 		var newtable=$("#sap_04"+"_"+chtable);
			 		var newchtable=parseInt($("#cbox4"+"_"+chtable).val())+1;
			 		var input01="sap04_"+chtable+"_"+newchtable;
			 		var input01Span="sap04_"+chtable+"_"+newchtable+"span";
			 		var input01Desc = "sapDesc04_"+chtable+"_"+newchtable;
					var numstemp = chtable+"_"+newchtable;
					var temp = "";
					temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
					temp += "<button type='button' style='vertical-align: middle;' class='browser'";
					temp += " onclick=addOneFieldObj(6,'"+numstemp+"','"+stuname+"')></button>";
					temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
					temp += "<input type='text' name='"+input01+"'";  
					temp += " value='' onchange='javascript:sapFieldChange(6,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
					temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
					temp += "<input type='text' name='"+input01Desc+"'";  
					temp += " value='' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
					temp += "</td></tr>";
					newtable.append($(temp)); 
			 		$("#cbox4"+"_"+chtable).attr("value",newchtable);
 			}else if(source=="3")
 			{
 				var checked = $("#sap_04"+"_"+chtable+" input[type='checkbox'][name='zibox'][checked=true]");
 				if(checked.length>0){ 
					if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
								$(checked).each(function(){ 
									if($(this).attr("checked")==true) 
									{ 
										$(this).parent().parent().remove(); 
									} 
								}); 
					}
				}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="7")
 		{
 			if(source=="1")
 			{
 				
 				 var lengthtemp = $("#hidden05").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							var valuetemp = $("input[name='outtable_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}	
				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?&servId=<%=servId%>&poolid=<%=poolid %>&type=7&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									var chtable=parseInt($("#hidden05").val())+1;
									var newname="cbox5"+"_"+chtable;
									var newtable="sap_05"+"_"+chtable;
									var newstru="outtable_"+chtable;
									var newstruSpan="outtable_"+chtable+"span";
									var bath="bath5_"+chtable;
									var addFieldBtn = "addouttable_"+chtable;
									var delFieldBtn = "delouttable_"+chtable;
									var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox5'></td>"); 	
									var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' "; 
									temp += " style='vertical-align: middle;' onclick=addOneFieldObj(7,"+chtable+",'"+newstru+"')></button>"; 
									temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
									temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(7,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
									temp += " </td><td>"; 
									temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
									temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
									temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
									temp += " onclick='checkbox5(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
									temp += " <td colspan='4' style='text-align:right;'>";
									temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(8,1,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
									temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
									temp += " onclick=addBathFieldObj(8,2,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
									temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
									temp += " onclick=addBathFieldObj(8,3,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
									temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
									temp += " </TD></TR></TABLE>";	
									row.append(temp);
									row.append("</td></tr>");
									var vTb=$("#sap_05");
									vTb.append(row); 
									//var shuzi=parseInt(chtable)+1;
									//�õ���������
									$("#hidden05").attr("value",chtable);
								}
							 }
						}
				}
			
 			}else if(source=="2")
 			{
 					var chtable=parseInt($("#hidden05").val())+1;
					var newname="cbox5"+"_"+chtable;
					var newtable="sap_05"+"_"+chtable;
					var newstru="outtable_"+chtable;
					var newstruSpan="outtable_"+chtable+"span";
					var bath="bath5_"+chtable;
					var addFieldBtn = "addouttable_"+chtable;
					var delFieldBtn = "delouttable_"+chtable;
					var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox5'></td>"); 	
					var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' "; 
					temp += " style='vertical-align: middle;' onclick=addOneFieldObj(7,"+chtable+",'"+newstru+"')></button>"; 
					temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'><img src='/images/BacoError.gif'"; 
					temp += " align=absMiddle></span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(7,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
					temp += " </td><td>"; 
					temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
					temp += " <TABLE class=ListStyle style='margin-top:0px;width:100%;' cellspacing=1 id='"+newtable+"'>";
					temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
					temp += " onclick='checkbox5(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
					temp += " <td colspan='4' style='text-align:right;'>";
					temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(8,1,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
					temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
					temp += " onclick=addBathFieldObj(8,2,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
					temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
					temp += " onclick=addBathFieldObj(8,3,'"+newstru+"','"+chtable+"') disabled='disabled'><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
					temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='5'>";
					temp += " </TD></TR></TABLE>";	
					row.append(temp);
					row.append("</td></tr>");
					var vTb=$("#sap_05");
					vTb.append(row);  
						//var shuzi=parseInt(chtable)+1;
						//�õ���������
						$("#hidden05").attr("value",chtable);
 			}else if(source=="3")
 			{
 					var vTb=$("#sap_05");
					var checked = $("#sap_05 input[type='checkbox'][name='cbox5'][checked=true]"); 
						if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
							$(checked).each(function(){ 
								if($(this).attr("checked")==true) 
								{ 
									$(this).parent().parent().remove(); 
								} 
							}); 
						}
					}else{
							alert("��ѡ����Ҫɾ�����");
				}
 			}
 		}else if(type=="8")
 		{
 			if(source=="1")
 			{
 				//alert("�����������������"+($("#"+stuname).val()_);
 				var stuortablevalue=$("#"+stuname).val();
					var lengthtemp = $("#cbox5"+"_"+chtable).val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						var valuetemp = $("input[name='sap05_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
					}	

					if(stuortablevalue == ''){
					alert("�ṹ��������Ϊ�գ�");
					return;
					}
					var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							var tempnames=temp.name.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									//�õ��ӱ��id
							 		var newtable=$("#sap_05"+"_"+chtable);
							 		var newchtable=parseInt($("#cbox5"+"_"+chtable).val())+1;
							 		var input01="sap05_"+chtable+"_"+newchtable;
							 		var input01Span="sap05_"+chtable+"_"+newchtable+"span";
							 		var input01Desc = "sapDesc05_"+chtable+"_"+newchtable;
									var numstemp = chtable+"_"+newchtable;
									
									var temp = "";
									temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
									temp += "<button type='button' style='vertical-align: middle;' class='browser'";
									temp += " onclick=addOneFieldObj(8,'"+numstemp+"','"+stuname+"')></button>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<input type='text' name='"+input01+"'";  
									temp += " value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(8,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
									temp += "<input type='text' name='"+input01Desc+"'";  
									temp += " value='"+tempnames[ij]+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td></tr>";
									newtable.append($(temp)); 
							 		$("#cbox5"+"_"+chtable).attr("value",newchtable);
							 	}
							 }
					}
				}
 			}else if(source=="2") {
 				//�õ��ӱ��id
		 		var newtable=$("#sap_05"+"_"+chtable);
		 		var newchtable=parseInt($("#cbox5"+"_"+chtable).val())+1;
		 		var input01="sap05_"+chtable+"_"+newchtable;
		 		var input01Span="sap05_"+chtable+"_"+newchtable+"span";
		 		var input01Desc = "sapDesc05_"+chtable+"_"+newchtable;
				var numstemp = chtable+"_"+newchtable;
				
				var temp = "";
				temp += "<tr><td style='width:100px;'><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
				temp += "<button type='button' style='vertical-align: middle;' class='browser'";
				temp += " onclick=addOneFieldObj(8,'"+numstemp+"','"+stuname+"')></button>";
				temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
				temp += "<input type='text' name='"+input01+"'";  
				temp += " value='' onchange='javascript:sapFieldChange(8,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
				temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='padding-top: 5px;padding-bottom:5px;'>"; 
				temp += "<input type='text' name='"+input01Desc+"'";  
				temp += " value='' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
				temp += "</td></tr>";
				newtable.append($(temp)); 
		 		$("#cbox5"+"_"+chtable).attr("value",newchtable);
 			}
 			else if(source=="3")
 			{
 				 		var checked = $("#sap_05"+"_"+chtable+" input[type='checkbox'][name='zibox'][checked=true]");
				 		if(checked.length>0){ 
						if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
									$(checked).each(function(){ 
										if($(this).attr("checked")==true) 
										{ 
											$(this).parent().parent().remove(); 
										} 
									}); 
						}
						}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="10")
 		{
 			if(source=="1")
 			{
 				
 				 var lengthtemp = $("#hidden07").val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
						for(var i=1;i<=lengthtemp;i++) {
							var valuetemp = $("input[name='outtable7_"+i+"']").attr("value");
							if($.trim(valuetemp)== '') continue;
							if(numSum == 1) {
								disValue = valuetemp;
							}else {
								disValue += ","+valuetemp;
							}
							numSum ++;
						}
					}	
 				var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid %>&type="+type+"&disValue="+disValue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									var chtable=parseInt($("#hidden07").val())+1;
									var newname="cbox7"+"_"+chtable;
									var newtable="sap_07"+"_"+chtable;
									var newstru="outtable7_"+chtable;
									var newstruSpan="outtable7_"+chtable+"span";
									var bath="bath7_"+chtable;
									var addFieldBtn = "addtable_"+chtable;
									var delFieldBtn = "deltable_"+chtable;
									
									var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox7'></td>"); 	
									var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' "; 
									    temp += " style='vertical-align: middle;' onclick=addOneFieldObj(10,"+chtable+",'"+newstru+"')></button>"; 
									    temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'>"; 
									    temp += "</span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(10,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
									    temp += " </td><td>"; 
									    temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
									    temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
									    temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
									    temp += " onclick='checkbox7(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
									    temp += " <td colspan='7' style='text-align:right;'>";
									    temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(11,1,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
									    temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
									    temp += " onclick=addBathFieldObj(11,2,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
									    temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
									    temp += " onclick=addBathFieldObj(11,3,'"+newstru+"','"+chtable+"') ><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
									    temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'>";
									    temp += " </TD></TR></TABLE>";
										row.append(temp);
										var vTb=$("#sap_07");
										vTb.append(row); 
										//�õ���������
										$("#hidden07").attr("value",chtable);
								}
							 }
						}
				}
			
 			}else if(source=="2")
 			{
 					var chtable=parseInt($("#hidden07").val())+1;
					var newname="cbox7"+"_"+chtable;
					var newtable="sap_07"+"_"+chtable;
					var newstru="outtable7_"+chtable;
					var newstruSpan="outtable7_"+chtable+"span";
					var bath="bath7_"+chtable;
					var addFieldBtn = "addtable_"+chtable;
					var delFieldBtn = "deltable_"+chtable;
					
					var row = $("<tr><td class='tdcenter'><input type='checkbox' name='cbox7'></td>"); 	
					var temp = "<td style='padding-top:0px;padding-bottom:0px;'><table   cellspacing=1 style='width:100%;margin-top:0px;margin-bottom:0px;padding-top:0;padding-bottom:0;'><tr><td style='width:50px;vertical-align: middle;'>����</td><td style='width:220px;'><button type='button' class='browser' "; 
					    temp += " style='vertical-align: middle;' onclick=addOneFieldObj(10,"+chtable+",'"+newstru+"')></button>"; 
					    temp += "<span id='"+newstruSpan+"' style='vertical-align: middle;width:12px;'><img src='/images/BacoError.gif'"; 
					    temp += " align=absMiddle></span> <span><input type='text' name='"+newstru+"' id='"+newstru+"' onchange='javascript:sapFieldChange(10,this)'  style='width:180px;height:28px;border:1px solid #D4E9E9;vertical-align: middle;' ></span>";
					    temp += " </td><td>"; 
					    temp += " <input type='hidden' id='"+newname+"' name='"+newname+"' value='0'></td></tr></table>";
					    temp += " <TABLE class=ListStyle style='margin-top:0px;' cellspacing=1 id='"+newtable+"'>";
					    temp += "  <tr class=Header><td style='width:100px;'><input type='checkbox'"; 
					    temp += " onclick='checkbox7(this,"+chtable+")'/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%></td>";
					    temp += " <td colspan='7' style='text-align:right;'>";
					    temp += " <button type='button'  class='btn' id='"+bath+"'  onclick=addBathFieldObj(11,1,'"+newstru+"','"+chtable+"') disabled='disabled' ><%=SystemEnv.getHtmlLabelName(25055,user.getLanguage())%></button>"; 
					    temp += " <button type='button' class='btn' id='"+addFieldBtn+"' "; 
					    temp += " onclick=addBathFieldObj(11,2,'"+newstru+"','"+chtable+"') disabled='disabled' ><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>";
					    temp += " <button type='button' class='btn' id='"+delFieldBtn+"' "; 
					    temp += " onclick=addBathFieldObj(11,3,'"+newstru+"','"+chtable+"') disabled='disabled' ><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></button>";
					    temp += " </td></tr> <TR class=Line style='height:1px'><TD  style='padding:0px' colspan='8'>";
					    temp += " </TD></TR></TABLE>";
						row.append(temp);
						var vTb=$("#sap_07");
						vTb.append(row); 
						//�õ���������
						$("#hidden07").attr("value",chtable);
 			}else if(source=="3")
 			{
 					var vTb=$("#sap_07");
					var checked = $("#sap_07 input[type='checkbox'][name='cbox7'][checked=true]"); 
						if(checked.length>0){ 
							if(window.confirm("ȷ��Ҫִ��ɾ��������!")){ 
						$(checked).each(function(){ 
							if($(this).attr("checked")==true) 
							{ 
								$(this).parent().parent().remove(); 
							} 
						}); 
					}
					}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}else if(type=="11")
 		{
 			if(source=="1")
 			{
 				
 				var stuortablevalue=$("#"+stuname).val();
 				var lengthtemp = $("#cbox7"+"_"+chtable).val();
					var disValue = '';
					var numSum = 1;
					if(lengthtemp>=1) {
					for(var i=1;i<=lengthtemp;i++) {
						var valuetemp = $("input[name='sap07_"+chtable+"_"+i+"']").attr("value");
						if($.trim(valuetemp)== '') continue;
						if(numSum == 1) {
							disValue = valuetemp;
						}else {
							disValue += ","+valuetemp;
						}
						numSum ++;
					}
					}	

					if(stuortablevalue == ''){
					alert("��������Ϊ�գ�");
					return;
					}
					var temp=window.showModalDialog("/integration/serviceReg/serviceReg_3NewParamsModeSAP.jsp?servId=<%=servId%>&poolid=<%=poolid%>&type="+type+"&disValue="+disValue+"&stuortablevalue="+stuortablevalue,"","dialogWidth:600px;dialogHeight:600px;center:yes;scroll:yes;status:no");
				if(temp)
				{
		    	 	if (temp.id!="" && temp.id != 0)
		    	    {
							var tempsz=temp.id.split("##");
							var tempnames=temp.name.split("##");
							for(var ij=0;ij<tempsz.length;ij++)
							{
								if(tempsz[ij])
								{
									//�õ��ӱ��id
							 		var newtable=$("#sap_07"+"_"+chtable);
							 		var newchtable=parseInt($("#cbox7"+"_"+chtable).val())+1;
							 		var input01="sap07_"+chtable+"_"+newchtable;
							 		var input01Span="sap07_"+chtable+"_"+newchtable+"span";
									var input03="con07_"+chtable+"_"+newchtable;
									var input01Desc = "sapDesc07_"+chtable+"_"+newchtable;
									var numstemp = chtable+"_"+newchtable;
									var temp = "";
									temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
									temp += "<button type='button' style='vertical-align: middle;' class='browser'";
									temp += " onclick=addOneFieldObj(11,'"+numstemp+"','"+stuname+"')></button>";
									temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'></span>";
									temp += "<input type='text' name='"+input01+"'";  
									temp += " value='"+tempsz[ij]+"' onchange='javascript:sapFieldChange(11,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
									temp += "<input type='text' name='"+input01Desc+"'";  
									temp += " value='"+tempnames[ij]+"' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
									temp += "</td><td style='width:80px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td>";
									temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
									newtable.append($(temp)); 
							 		$("#cbox7"+"_"+chtable).attr("value",newchtable);
							 	}
							 }
					}
				}
 			}else if(source=="2")
 			{
 				//�õ��ӱ��id
		 		var newtable=$("#sap_07"+"_"+chtable);
		 		var newchtable=parseInt($("#cbox7"+"_"+chtable).val())+1;
		 		var input01="sap07_"+chtable+"_"+newchtable;
		 		var input01Span="sap07_"+chtable+"_"+newchtable+"span";
				var input03="con07_"+chtable+"_"+newchtable;
				var input01Desc = "sapDesc07_"+chtable+"_"+newchtable;
				var numstemp = chtable+"_"+newchtable;
				var temp = "";
				temp += "<tr><td><input type='checkbox' name='zibox'></td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(28247,user.getLanguage())%></td><td style='width:208px;padding-top: 6px;padding-bottom:6px;'>";
				temp += "<button type='button' style='vertical-align: middle;' class='browser'";
				temp += " onclick=addOneFieldObj(11,'"+numstemp+"','"+stuname+"')></button>";
				temp += "<span id='"+input01Span+"' style='vertical-align: middle;width:7px;'><img src='/images/BacoError.gif' align='center'></span>";
				temp += "<input type='text' name='"+input01+"'";  
				temp += " value='' onchange='javascript:sapFieldChange(11,this)' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
				temp += "</td><td style='width:90px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(30708,user.getLanguage())%></td><td style='width:180px;padding-top: 5px;padding-bottom:5px;'>"; 
				temp += "<input type='text' name='"+input01Desc+"'";  
				temp += " value='' style='vertical-align: middle;border:1px solid #D4E9E9;width:172px;height:28px;'>";
				temp += "</td><td style='width:80px;vertical-align: middle;'><%=SystemEnv.getHtmlLabelName(453,user.getLanguage())%></td>";
				temp += "<td style='padding-top:5px;padding-bottom:5px;'><input type='text' name='"+input03+"' style='border:1px solid #D4E9E9;width:172px;height:28px;'></td></tr>";
				newtable.append($(temp)); 
		 		$("#cbox7"+"_"+chtable).attr("value",newchtable);
 			}
 			else if(source=="3")
 			{
 				 		var checked = $("#sap_07"+"_"+chtable+" input[type='checkbox'][name='zibox'][checked=true]");
			 			if(checked.length>0){ 
						if(window.confirm("ȷ��Ҫִ��ɾ��������!")){
							$(checked).each(function(){ 
								if($(this).attr("checked")==true) 
								{ 
									$(this).parent().parent().remove(); 
								} 
							}); 
						}
						}else{
							alert("��ѡ����Ҫɾ�����");
						}
 			}
 		}
 	}

 	function checkRequired()
 	{
 		var temp=0;
		$("span img").each(function (){
			temp++;
		});
		if(temp!=0)
		{
			alert("��Ҫ���ݲ�����!");
			return false;
		}else
		{
			return true;
		}
 	}

	</script>
</html>

