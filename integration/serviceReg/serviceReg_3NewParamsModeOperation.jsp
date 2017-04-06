<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="com.weaver.integration.util.IntegratedSapUtil"%>
<%@ page import="com.weaver.integration.entity.NewSapBrowserComInfo"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="com.weaver.integration.params.*,com.weaver.integration.datesource.*,com.weaver.integration.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="SapUtil" class="com.weaver.integration.util.IntegratedSapUtil" scope="page"/>
<%
	String flag="0";//0����ʧ��,1����ɹ�
	String servId=Util.null2String(request.getParameter("servId"));//int_BrowserbaseInfo��id
	String browserId=Util.null2String(request.getParameter("browserId"));
	String poolid=Util.null2String(request.getParameter("poolid"));
	String modeId = "";
	if("".equals(browserId)) {
		 modeId = ServiceParamModeUtil.insertSerParMode(servId,"3");
	}else {
		ServiceParamModeDisUtil.deleteAllParamsMode(servId,browserId);
		modeId = browserId;
	}

	int hidden01=Util.getIntValue(request.getParameter("hidden01"),0);//����������ܸ���
	int hidden02=Util.getIntValue(request.getParameter("hidden02"),0);//����ṹ���ܸ���
	int hidden03=Util.getIntValue(request.getParameter("hidden03"),0);//����������ܸ���
	int hidden04=Util.getIntValue(request.getParameter("hidden04"),0);//����ṹ���ܸ���
	int hidden05=Util.getIntValue(request.getParameter("hidden05"),0);//�������ܸ���
	int hidden07=Util.getIntValue(request.getParameter("hidden07"),0);//�������ܸ���
	IntegratedSapUtil saputil=new IntegratedSapUtil();
	//��֤һ��ֵ�Ƿ�����
	//�޸�ʱ����ɾ�ٲ�
	String procpara="";
		
		
		//�������
		for(int i=1;i<=hidden01;i++) {	
			//SAPȡֵ�ֶ�
			String sap01=Util.null2String(request.getParameter("sap01_"+i)).trim();
			//��Ӧ��oa�ֶ�
			String oa01=Util.null2String(request.getParameter("sapDesc01_"+i)).trim();
			//�̶�ֵ
			String con01=Util.null2String(request.getParameter("con01_"+i)).trim();
			if("".equals(sap01)) continue;
			ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
			spmb.setParamCons(con01);
			spmb.setParamModeId(modeId);
			spmb.setServId(servId);
			spmb.setParamName(sap01);
			spmb.setParamType("import");
			spmb.setParamDesc(oa01);
			ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
		}
		
		//����ṹ
				for(int i=1;i<=hidden02;i++) {	
					
					String structName = Util.null2String(request.getParameter("stru_"+i)).trim();
					if("".equals(structName))continue;
					ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
					spmb.setParamModeId(modeId);
					spmb.setServId(servId);
					spmb.setParamName(structName);
					spmb.setParamType("import");
					spmb.setCompSty(true);
					spmb.setCompStyTypeName("struct");
					ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
					int fieldDisLength = Util.getIntValue(request.getParameter("cbox2_"+i),0);
					for(int j=1;j<=fieldDisLength;j++) {
						//SAPȡֵ�ֶ�
						String sap01=Util.null2String(request.getParameter("sap02_"+i+"_"+j)).trim();
						//��Ӧ��oa�ֶ�
						String oa01=Util.null2String(request.getParameter("sapDesc02_"+i+"_"+j)).trim();
						//�̶�ֵ
						String con01=Util.null2String(request.getParameter("con02_"+i+"_"+j)).trim();
						if("".equals(sap01)) continue;
						ServiceParamModeDisBean spmb2 = new ServiceParamModeDisBean();
						spmb2.setParamCons(con01);
						spmb2.setParamModeId(modeId);
						spmb2.setServId(servId);
						spmb2.setParamName(sap01);
						spmb2.setParamType("import");
						spmb2.setParamDesc(oa01);
						spmb2.setCompstyname(structName);
						ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb2, true);
					}
					
				}
		//�������
		for(int i=1;i<=hidden03;i++) {	
			//SAPȡֵ�ֶ�
			String sap01=Util.null2String(request.getParameter("sap03_"+i)).trim();
			//��Ӧ��oa�ֶ�
			String oa01=Util.null2String(request.getParameter("sapDesc03_"+i)).trim();
			if("".equals(sap01)) continue;
			ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
			spmb.setParamModeId(modeId);
			spmb.setServId(servId);
			spmb.setParamName(sap01);
			spmb.setParamType("export");
			spmb.setParamDesc(oa01);
			ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
		}
		
		// ����ṹ
			for(int i=1;i<=hidden04;i++) {	
					
					String structName = Util.null2String(request.getParameter("outstru_"+i)).trim();
					if("".equals(structName))continue;
					ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
					spmb.setParamModeId(modeId);
					spmb.setServId(servId);
					spmb.setParamName(structName);
					spmb.setParamType("export");
					spmb.setCompSty(true);
					spmb.setCompStyTypeName("struct");
					ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
					int fieldDisLength = Util.getIntValue(request.getParameter("cbox4_"+i),0);
					for(int j=1;j<=fieldDisLength;j++) {
						//SAPȡֵ�ֶ�
						String sap01=Util.null2String(request.getParameter("sap04_"+i+"_"+j)).trim();
						//��Ӧ��oa�ֶ�
						String oa01=Util.null2String(request.getParameter("sapDesc04_"+i+"_"+j)).trim();
						
						if("".equals(sap01)) continue;
						ServiceParamModeDisBean spmb2 = new ServiceParamModeDisBean();
						spmb2.setParamModeId(modeId);
						spmb2.setServId(servId);
						spmb2.setParamName(sap01);
						spmb2.setParamType("export");
						spmb2.setParamDesc(oa01);
						spmb2.setCompstyname(structName);
						ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb2, true);
					}
					
			}
		
			// �����
						for(int i=1;i<=hidden05;i++) {	
								
								String structName = Util.null2String(request.getParameter("outtable_"+i)).trim();
								if("".equals(structName))continue;
								ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
								spmb.setParamModeId(modeId);
								spmb.setServId(servId);
								spmb.setParamName(structName);
								spmb.setParamType("export");
								spmb.setCompSty(true);
								spmb.setCompStyTypeName("table");
								ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
								int fieldDisLength = Util.getIntValue(request.getParameter("cbox5_"+i),0);
								for(int j=1;j<=fieldDisLength;j++) {
									//SAPȡֵ�ֶ�
									String sap01=Util.null2String(request.getParameter("sap05_"+i+"_"+j)).trim();
									//��Ӧ��oa�ֶ�
									String oa01=Util.null2String(request.getParameter("sapDesc05_"+i+"_"+j)).trim();
									
									if("".equals(sap01)) continue;
									ServiceParamModeDisBean spmb2 = new ServiceParamModeDisBean();
									spmb2.setParamModeId(modeId);
									spmb2.setServId(servId);
									spmb2.setParamName(sap01);
									spmb2.setParamType("export");
									spmb2.setParamDesc(oa01);
									spmb2.setCompstyname(structName);
									ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb2, true);
								}
								
						}
			
						//�����
						for(int i=1;i<=hidden07;i++) {	
							
							String structName = Util.null2String(request.getParameter("outtable7_"+i)).trim();
							if("".equals(structName))continue;
							ServiceParamModeDisBean spmb = new ServiceParamModeDisBean();
							spmb.setParamModeId(modeId);
							spmb.setServId(servId);
							spmb.setParamName(structName);
							spmb.setParamType("import");
							spmb.setCompSty(true);
							spmb.setCompStyTypeName("table");
							ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb, true);
							int fieldDisLength = Util.getIntValue(request.getParameter("cbox7_"+i),0);
							for(int j=1;j<=fieldDisLength;j++) {
								//SAPȡֵ�ֶ�
								String sap01=Util.null2String(request.getParameter("sap07_"+i+"_"+j)).trim();
								//��Ӧ��oa�ֶ�
								String oa01=Util.null2String(request.getParameter("sapDesc07_"+i+"_"+j)).trim();
								//�̶�ֵ
								String con01=Util.null2String(request.getParameter("con07_"+i+"_"+j)).trim();
								if("".equals(sap01)) continue;
								ServiceParamModeDisBean spmb2 = new ServiceParamModeDisBean();
								spmb2.setParamCons(con01);
								spmb2.setParamModeId(modeId);
								spmb2.setServId(servId);
								spmb2.setParamName(sap01);
								spmb2.setParamType("import");
								spmb2.setParamDesc(oa01);
								spmb2.setCompstyname(structName);
								ServiceParamModeDisUtil.insOrUpdBySerParModeDisBean(spmb2, true);
							}
							
						}
					
%>

<script type="text/javascript">
		window.parent.parent.document.getElementById("hidediv").style.display="none";
		window.parent.parent.document.getElementById("hidedivmsg").style.display="none";
		alert("<%=SystemEnv.getHtmlLabelName(30648,user.getLanguage())%>!");
		window.parent.parent.document.getElementById("marktemp").value= <%=modeId%>;
		window.parent.parent.close();
</script>