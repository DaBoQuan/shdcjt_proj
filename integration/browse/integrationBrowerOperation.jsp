<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="com.weaver.integration.util.IntegratedSapUtil"%>
<%@page import="com.weaver.integration.entity.NewSapBrowserComInfo"%>
<%@page import="weaver.workflow.action.BaseAction"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="SapUtil" class="com.weaver.integration.util.IntegratedSapUtil" scope="page"/>
<%
	String opera=Util.null2String(request.getParameter("opera"));
	String flag="0";//0����ʧ��,1����ɹ�
	String baseid=Util.null2String(request.getParameter("baseid"));//int_BrowserbaseInfo��id
	String mark=Util.null2String(request.getParameter("mark"));
	String hpid=Util.null2String(request.getParameter("hpid"));
	String poolid=Util.null2String(request.getParameter("poolid"));
	String formid=Util.null2String(request.getParameter("formid"));
	String regservice=Util.null2String(request.getParameter("regservice"));
	String brodesc=Util.null2String(request.getParameter("brodesc"));
	String dataauth=Util.null2String(request.getParameter("dataauth"));//�õ��Ƿ�����������Ȩ����
	String oldautotypeid=Util.null2String(request.getParameter("oldautotypeid"));
	//String ismainfield=Util.null2String(request.getParameter("ismainfield"));
	String authcontorl=Util.getIntValue(request.getParameter("authcontorl"),0)+"";//����˵���������ť�Ƿ�����Ȩ�޿���
	String updateTableName=Util.null2String(request.getParameter("updateTableName"));
	String w_fid= Util.getIntValue(Util.null2String(request.getParameter("workflowid")),-1)+"";//��������id
	String w_nodeid=Util.null2String(request.getParameter("nodeid"));//�ڵ�id
	String w_actionorder=Util.null2String(Util.getIntValue(request.getParameter("w_actionorder"),0)+"");//ִ��˳��
	String w_enable=Util.getIntValue(request.getParameter("w_enable"),0)+"";//�Ƿ�����(0,�����ã�1������)	
	String w_type=Util.getIntValue(request.getParameter("w_type"),0)+"";//0-��ʾ�������ť��������Ϣ��1-��ʾ�ǽڵ��������ʱ����Ϣ
	int isbill= Util.getIntValue(request.getParameter("isbill"),0);//0��ʾ�ϱ�,1��ʾ�±�
	//�Ƿ�ڵ�󸽼Ӳ���
	String ispreoperator = Util.getIntValue(request.getParameter("ispreoperator"), -1)+"";
	//����id
	String nodelinkid = Util.getIntValue(request.getParameter("nodelinkid"), -1)+"";
	int hidden01=Util.getIntValue(request.getParameter("hidden01"),0);//����������ܸ���
	int hidden02=Util.getIntValue(request.getParameter("hidden02"),0);//����ṹ���ܸ���
	int hidden03=Util.getIntValue(request.getParameter("hidden03"),0);//����������ܸ���
	int hidden04=Util.getIntValue(request.getParameter("hidden04"),0);//����ṹ���ܸ���
	int hidden05=Util.getIntValue(request.getParameter("hidden05"),0);//�������ܸ���
	int hidden06=Util.getIntValue(request.getParameter("hidden06"),0);//��Ȩ����
	int hidden07=Util.getIntValue(request.getParameter("hidden07"),0);//�������ܸ���
	IntegratedSapUtil saputil=new IntegratedSapUtil();
	//��֤һ��ֵ�Ƿ�����
	//�޸�ʱ����ɾ�ٲ�
	String procpara="";
	//System.out.println("------���ݴ��������־---"+opera);
	//System.out.println("����������ܸ���---"+hidden01);
	//System.out.println("����ṹ���ܸ���---"+hidden02);
	//System.out.println("����������ܸ���---"+hidden03);
	//System.out.println("����ṹ���ܸ���---"+hidden04);
	//System.out.println("�������ܸ���-----"+hidden05);
	//System.out.println("��Ȩ����----------"+hidden06);
	//System.out.println("�������ܸ���-----"+hidden07);
		
	if("save".equals(opera))
	{
		if("".equals(mark))
		{
			if(rs.executeProc("int_browermark_Insert","browser.")&&rs.next())
			{
				//�õ���ˮ�ŵ�mark
				mark=rs.getString(1);
			}
		}
		//System.out.println("�õ���ˮ��"+mark);
		//��֤Ψһ
		if(rs.execute("select count(*) s from int_BrowserbaseInfo where mark='"+mark+"'")&&rs.next())
		{
			if(rs.getInt("s")<=0)//֤��û���ظ���ֵ��
			{
					procpara = mark + Util.getSeparator(); 
					procpara += hpid + Util.getSeparator();
					procpara += poolid + Util.getSeparator();
					procpara += regservice + Util.getSeparator()+"";
					procpara += brodesc + Util.getSeparator()+"";
					procpara += authcontorl+ Util.getSeparator()+"";//���Ȩ�޿��ƿ���
					procpara += w_fid + Util.getSeparator()+"";
					procpara += w_nodeid + Util.getSeparator()+"";
					procpara += w_actionorder + Util.getSeparator()+"";
					procpara += w_enable + Util.getSeparator()+"";
					procpara += w_type+ Util.getSeparator()+"";
					procpara += ispreoperator + Util.getSeparator()+"";
					procpara += nodelinkid;
					if(rs.executeProc("int_BrowserbaseInfo_insert",procpara))
					{
						//System.out.println("���������Ϣ�ɹ�");
						rs.next();
						baseid=rs.getString(1);////sap_baseInfo��id
						for(int i=1;i<=hidden01;i++)
						{	
							//SAPȡֵ�ֶ�
							String sap01=Util.null2String(request.getParameter("sap01_"+i)).toUpperCase()+""+"";
							//��Ӧ��oa�ֶ�
							String oa01=Util.null2String(request.getParameter("oa01_"+i)).toUpperCase()+"";
							//�̶�ֵ
							String con01=Util.null2String(request.getParameter("con01_"+i));
							//�Ƿ������ֶ�
							String add01=Util.null2String(request.getParameter("add01_"+i));
							//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
							String oafieldid="";
							String args[]=add01.split("_");
							if(args.length>=2)
							{
								oafieldid=args[1];
								add01=args[0];
							}
							//w_type
							if(!"".equals(sap01)&&!"".equals(oa01))
							{
								procpara = baseid + Util.getSeparator(); 
							    procpara += sap01 + Util.getSeparator(); 
							    procpara += oa01 + Util.getSeparator();
							    procpara += con01+ Util.getSeparator()+"";
							    procpara += i+""+ Util.getSeparator();
							    procpara +=add01+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							    procpara +=oafieldid+""+Util.getSeparator()+"";
							    procpara +=isbill;
							     
							    rs.executeProc("sap_inParameter_Insert",procpara);
							    
						    }
						}
						for(int i=1;i<=hidden02;i++)
						{	
							//�õ��ṹ����
							String stru=Util.null2String(request.getParameter("stru_"+i)).toUpperCase()+"";
							
							String nameid=SapUtil.InsertSap_complexname(baseid,"3",stru,"","");
							//�õ��ýṹ������Ĳ�������
							int cbox2=Util.getIntValue(request.getParameter("cbox2_"+i),0);
							if(cbox2<=0)
							{
								continue;//������һ���ṹ���ѭ��
							}else
							{
								//ѭ��ȡ�ṹ�������������
								
								for(int j=1;j<=cbox2;j++)
								{
									//SAPȡֵ�ֶ�
									String sap02=Util.null2String(request.getParameter("sap02_"+i+"_"+j)).toUpperCase()+"";
									//��Ӧ��oa�ֶ�
									String oa02=Util.null2String(request.getParameter("oa02_"+i+"_"+j)).toUpperCase()+"";
									//�̶�ֵ
									String con02=Util.null2String(request.getParameter("con02_"+i+"_"+j));
									//�Ƿ������ֶ�
									String add02=Util.null2String(request.getParameter("add02_"+i+"_"+j))+"";
									
									//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
									String oafieldid="";
									String args[]=add02.split("_");
									if(args.length>=2)
									{
										oafieldid=args[1];
										add02=args[0];
									}
									if(!"".equals(sap02)&&!"".equals(oa02)&&!"-1".equals(nameid))
									{
										procpara = baseid + Util.getSeparator(); 
										procpara += nameid + Util.getSeparator(); 
									    procpara += sap02 + Util.getSeparator(); 
									    procpara += oa02 + Util.getSeparator();
									    procpara += con02+ Util.getSeparator();
									    procpara += j+""+ Util.getSeparator()+"";
										procpara += i+""+Util.getSeparator()+"";
										procpara +=add02+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							    		procpara +=oafieldid+ Util.getSeparator()+"";
							    		procpara +=isbill;
									    rs.executeProc("sap_inStructure_Insert",procpara);
									     
								    }
								}
							
							}
						}
						for(int i=1;i<=hidden03;i++)
						{
							//SAPȡֵ�ֶ�
							String sap03=Util.null2String(request.getParameter("sap03_"+i)).toUpperCase()+"";
							//��ʾ��
							String show03=Util.null2String(request.getParameter("show03_"+i));
							//�Ƿ���ʾ
							String dis03=Util.getIntValue(request.getParameter("dis03_"+i),0)+"";
							//�踳ֵ��oa�ֶ�
							String setoa3=Util.null2String(request.getParameter("setoa3_"+i)).toUpperCase()+"";
							//�Ƿ������ֶ�
							String add03=Util.null2String(request.getParameter("add03_"+i));
							
							//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
							String oafieldid="";
							String args[]=add03.split("_");
							if(args.length>=2)
							{
								oafieldid=args[1];
								add03=args[0];
							}	
							//�õ����ֶε�fieldid
							if(!"".equals(sap03))
							{
								procpara = baseid + Util.getSeparator(); 
							    procpara += sap03 + Util.getSeparator(); 
							    procpara += show03 + Util.getSeparator();
							    procpara += dis03+ Util.getSeparator();
							    procpara += i+""+Util.getSeparator()+"";
							    procpara += setoa3+""+Util.getSeparator()+"";
							    procpara +=add03+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							    procpara +=oafieldid+ Util.getSeparator()+"";
							    procpara +=isbill;
							    rs.executeProc("sap_outParameter_Insert",procpara);
							}
						}
						for(int i=1;i<=hidden04;i++)
						{
							//�õ��ṹ����
							String stru=Util.null2String(request.getParameter("outstru_"+i)).toUpperCase()+"";
							String nameid=SapUtil.InsertSap_complexname(baseid,"4",stru,"","");
							//�õ��ýṹ������Ĳ�������
							int cbox4=Util.getIntValue(request.getParameter("cbox4_"+i),0);
							if(cbox4<=0)
							{
								continue;//������һ���ṹ���ѭ��
							}else
							{
								//ѭ��ȡ�ṹ�������������
								for(int j=1;j<=cbox4;j++)
								{
									//SAPȡֵ�ֶ�
									String sap04=Util.null2String(request.getParameter("sap04_"+i+"_"+j)).toUpperCase()+"";
									//��ʾ��
									String show04=Util.null2String(request.getParameter("show04_"+i+"_"+j));
									//�Ƿ���ʾ
									String dis04=Util.getIntValue(request.getParameter("dis04_"+i+"_"+j),0)+"";
									//�Ƿ���Ϊ��ѯ����
									String con04=Util.getIntValue(request.getParameter("sea04_"+i+"_"+j),0)+"";
									//�踳ֵ��oa�ֶ�
									String setoa4=Util.null2String(request.getParameter("setoa4_"+i+"_"+j)).toUpperCase()+"";
									//�Ƿ������ֶ�
									String add04=Util.null2String(request.getParameter("add04_"+i+"_"+j));
									
									//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
									String oafieldid="";
									String args[]=add04.split("_");
									if(args.length>=2)
									{
										oafieldid=args[1];
										add04=args[0];
									}
									if(!"".equals(sap04)&&!"-1".equals(nameid))
									{
									  	procpara = baseid + Util.getSeparator(); 
									    procpara += nameid + Util.getSeparator(); 
									    procpara += sap04 + Util.getSeparator(); 
									    procpara += show04 +Util.getSeparator(); 
									    procpara += dis04 +Util.getSeparator(); 
									    procpara += con04+Util.getSeparator(); 
									    procpara += j+""+ Util.getSeparator()+"";
										procpara += i+""+Util.getSeparator()+""; 
										procpara += setoa4+""+Util.getSeparator()+"";
										procpara +=add04+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							   			procpara +=oafieldid+ Util.getSeparator()+"";
							   			procpara +=isbill;
									    rs.executeProc("sap_outStructure_Insert",procpara);
								   }
								}
							}
						}
						for(int i=1;i<=hidden05;i++)
						{
							//�õ�����
							String stru=Util.null2String(request.getParameter("outtable_"+i));
							//�õ���д��
							String backtable5=Util.null2String(request.getParameter("backtable5_"+i));
							//�õ���д����
							String backoper5=Util.null2String(request.getParameter("backoper5_"+i));
							String nameid=SapUtil.InsertSap_complexname(baseid,"2",stru,backtable5,backoper5);
							//�õ��ñ�����Ĳ�������
							int cbox5=Util.getIntValue(request.getParameter("cbox5_"+i),0);
							//�õ�where������������
				    		int sapson_05count=Util.getIntValue(request.getParameter("sapson_05count_"+i),0);
				    		//System.out.println("where�����ܸ���"+sapson_05count);
					    	////System.out.println("���������Ĳ����ܸ���"+cbox5);	
							//ѭ��ȡ�������������
							for(int j=1;j<=cbox5;j++)
							{
								//SAPȡֵ�ֶ�
								String sap05=Util.null2String(request.getParameter("sap05_"+i+"_"+j)).toUpperCase()+"";
								//��ʾ��
								String show05=Util.null2String(request.getParameter("show05_"+i+"_"+j));
								//�Ƿ���ʾ
								String dis05=Util.getIntValue(request.getParameter("dis05_"+i+"_"+j),0)+"";
								//�Ƿ���Ϊ��ѯ����
								String sea05=Util.getIntValue(request.getParameter("sea05_"+i+"_"+j),0)+"";
								//�Ƿ�Ϊ����
								String key05=Util.getIntValue(request.getParameter("key05_"+i+"_"+j),0)+"";
								//�踳ֵ��oa�ֶ�
								String setoa5=Util.null2String(request.getParameter("setoa5_"+i+"_"+j)).toUpperCase()+"";
								//�Ƿ������ֶ�
								String add05=Util.null2String(request.getParameter("add05_"+i+"_"+j));
								//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
								String oafieldid="";
								String args[]=add05.split("_");
								if(args.length>=2)
								{
									oafieldid=args[1];
									add05=args[0];
								}
								if(!"".equals(sap05)&&!"-1".equals(nameid))
								{
								  	procpara = baseid + Util.getSeparator(); 
								    procpara += nameid + Util.getSeparator(); 
								    procpara += sap05 + Util.getSeparator();
								    procpara += show05 + Util.getSeparator();
								    procpara += dis05 + Util.getSeparator();
								    procpara += sea05 + Util.getSeparator();
								    procpara += key05+ Util.getSeparator();
								    procpara += j+""+ Util.getSeparator()+"";
									procpara += i+""+ Util.getSeparator()+"";
									procpara += setoa5+""+ Util.getSeparator()+"";
									procpara +=add05+ Util.getSeparator();//ƴ���Ƿ���ϸ��
						   			procpara +=oafieldid+ Util.getSeparator()+"";
						   			procpara +=isbill;
						   			//System.out.println("������������"+procpara);
								    boolean result=rs.executeProc("sap_outTable_Insert",procpara);
							   }
							}
							//System.out.println("����where����"+sapson_05count);
							//ѭ��where����
							if(sapson_05count<=0)
							{
								continue;
							}else
							{
					    		//ѭ������where�����ĸ���
					    		for(int o=1;o<=sapson_05count;o++)
					    		{
					    				//baseid_1  integer,
										//outtablename_2   varchar2,	
										//sapfield_3    varchar2,	
									    //oafield_4    varchar2,	
									    //constant_5  varchar2,	
									    //ordernum_6  varchar2,	
									    //ismainfield_7 varchar2,	
									    //fromfieldid_8  varchar2,	
					    				 //����������where����
							    		String input01=Util.null2String(request.getParameter("sap05son_"+i+"_"+o));//��ϸȡֵ�ֶ�
										String input02=Util.null2String(request.getParameter("set05son_"+i+"_"+o));//��ϸ��ֵ�ֶ����ݿ��ֶε�����
										String input03=Util.null2String(request.getParameter("add05son_"+i+"_"+o));//��ϸ��ֵ�ֶ����ݿ��ֶε�id
										String input04=Util.null2String(request.getParameter("con05son_"+i+"_"+o));//�̶�ֵ
										String ismainfield_7="";
										String fromfieldid_8="";
										if("".equals(input03))
										{
											continue;
										}else
										{
											ismainfield_7=input03.split("_")[0];
											fromfieldid_8=input03.split("_")[1];
										}
										if(!"".equals(ismainfield_7)&&!"".equals(fromfieldid_8))
										{
											procpara = baseid + Util.getSeparator()+""; 
					    					procpara += nameid + Util.getSeparator()+""; 
					    					procpara += input01 + Util.getSeparator()+"";
					    					procpara += input02 + Util.getSeparator()+"";
					    					procpara += input04+ Util.getSeparator()+"";
					    					procpara += 0+""+Util.getSeparator()+"";
					    					procpara += ismainfield_7+""+ Util.getSeparator()+"";
					    					procpara += fromfieldid_8+""+ Util.getSeparator()+"";
					    					procpara +=isbill;
					    					//931PRODUCTIONRESOURCEDEL_INDMATKL2010595
					    					//System.out.println("���������"+procpara);
					    					boolean result02=rs.executeProc("sap_outparaprocess_Insert",procpara);
											//System.out.println("�����Ƿ�ɹ�"+result02);
										}
					    		}
					    	}
						
						}
						for(int i=1;i<=hidden06;i++)
						{
							//��Ȩ����
							String autotype=Util.null2String(request.getParameter("autotype_"+i));
							//��Ȩ��Ա���ɫ
							String autouserid=Util.null2String(request.getParameter("autouserorwf_"+i));
							//��Ȩ����
							String autowfid=Util.null2String(request.getParameter("autowfid_"+i));
							//��ϸ����
							//String autoset=Util.null2String(request.getParameter("autodeti_"+i));
							if(!"".equals(autouserid))
							{
								procpara = baseid + Util.getSeparator(); 
							    procpara += autotype + Util.getSeparator(); 
							    if("1".equals(autotype))//��Ա
							    {
							    	 procpara += autouserid + Util.getSeparator(); 
							    	 procpara += "" + Util.getSeparator(); 
							    }else  if("2".equals(autotype))//��ɫ
							    {
							    	procpara += "" + Util.getSeparator(); 
							    	procpara += autouserid + Util.getSeparator(); 
							    }
							    procpara += autowfid + Util.getSeparator();
							  //  procpara += autoset+ Util.getSeparator()+"";
							    procpara +=i;
								rs.executeProc("int_authorizeRight_Insert",procpara);	  
							}
						}
						for(int i=1;i<=hidden07;i++)
						{
							//�õ�����
							String tablename=Util.null2String(request.getParameter("outtable7_"+i));
							String backtable7=Util.null2String(request.getParameter("backtable7_"+i));//�õ�Դ��
							String nameid=SapUtil.InsertSap_complexname(baseid,"1",tablename,backtable7,"");
							//�õ������������Ĳ�������
							int cbox7=Util.getIntValue(request.getParameter("cbox7_"+i),0);
							
							//System.out.println("���������Ĳ�������"+cbox7);
							if(cbox7<=0)
							{
								continue;//������һ���ṹ���ѭ��
							}else
							{
								//ѭ��ȡ�ṹ�������������
								for(int j=1;j<=cbox7;j++)
								{
									//SAP��ֵ�ֶ�
									String sap07=Util.null2String(request.getParameter("sap07_"+i+"_"+j)).toUpperCase()+"";
									//oaȡֵ�ֶ�
									String setoa7=Util.null2String(request.getParameter("setoa7_"+i+"_"+j)).toUpperCase()+"";
									//�Ƿ������ֶ�
									String add07=Util.null2String(request.getParameter("add07_"+i+"_"+j));
									//�̶�ֵ
									String con07=Util.null2String(request.getParameter("con07_"+i+"_"+j));
									
									//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
									String oafieldid="";
									String args[]=add07.split("_");
									if(args.length>=2)
									{
										oafieldid=args[1];
										add07=args[0];
									}
									//�õ����ֶε�fieldid
									//String oafieldid=saputil.checkOAField(add07, updateTableName, setoa7, formid);
									if(!"".equals(sap07)&&!"-1".equals(nameid))
									{
									  	procpara = baseid + Util.getSeparator(); 
									    procpara += nameid + Util.getSeparator(); 
									    procpara += sap07 + Util.getSeparator();
									    procpara += setoa7+""+ Util.getSeparator()+"";
									    procpara += con07+""+ Util.getSeparator()+"";
									    procpara += j+""+ Util.getSeparator()+"";
										procpara += i+""+ Util.getSeparator()+"";
										procpara +=add07+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							   			procpara +=oafieldid+ Util.getSeparator()+"";
							   			procpara +=isbill;
									    rs.executeProc("sap_inTable_Insert",procpara);
								   }
								}
							
							}
						
						}
						
						flag="1";
					}
			}else
			{
				
				flag="2";
			}
		}
	
	}else if("update".equals(opera))
	{
		//delete int_BrowserbaseInfo
		//delete sap_inParameter
		//delete sap_inStructure
		//delete sap_outParameter
		//delete sap_outStructure
		//delete sap_outTable
		//��֤Ψһ
		if(rs.execute("select count(*) s from int_BrowserbaseInfo where mark='"+mark+"' and id<>'"+baseid+"'")&&rs.next())
		{
			//System.out.println("�޸�Ψһ����֤---------");
			if(rs.getInt("s")<=0)//֤��û���ظ���ֵ��
			{
				//System.out.println("�޸ı�ʶΨһ---------");
				//procpara += authcontorl;//���Ȩ�޿��ƿ���
				//procpara += w_fid + Util.getSeparator()+"";
					//procpara += w_nodeid + Util.getSeparator()+"";
					//procpara += w_actionorder + Util.getSeparator()+"";
					//procpara += w_enable + Util.getSeparator()+"";
					//procpara += w_type+"";
					//w_actionorder='"+w_actionorder+"',w_enable='"+w_enable+"',w_fid='"+w_fid+"',w_fid='"+w_fid+"',w_fid='"+w_fid+"
				rs.execute("update int_BrowserbaseInfo  set hpid='"+hpid+"',w_enable='"+w_enable+"',poolid='"+poolid+"',regservice='"+regservice+"',brodesc='"+brodesc+"',authcontorl='"+authcontorl+"' ,w_actionorder='"+w_actionorder+"' where id='"+baseid+"'");
				//System.out.println("�޸ĵ�update���"+"update int_BrowserbaseInfo  set hpid='"+hpid+"',w_enable='"+w_enable+"',poolid='"+poolid+"',regservice='"+regservice+"',brodesc='"+brodesc+"',authcontorl='"+authcontorl+"' where id='"+baseid+"'");
				//�޸Ĳ�������ɾ�����е�����
				rs.execute("delete sap_inParameter where baseid='"+baseid+"'");
				rs.execute("delete sap_inStructure where baseid='"+baseid+"'");
				rs.execute("delete sap_outParameter where baseid='"+baseid+"'");
				rs.execute("delete sap_outStructure where baseid='"+baseid+"'");
				rs.execute("delete sap_outTable where baseid='"+baseid+"'");	
				rs.execute("delete sap_inTable where baseid='"+baseid+"'");	
				rs.execute("delete sap_complexname where baseid='"+baseid+"'");//ɾ��������ṹ�������
				rs.execute("delete sap_outparaprocess where baseid='"+baseid+"'");//ɾ��where����
				//System.out.println("����ɾ�����һ---------");
			//	rs.execute("delete int_authorizeRight where baseid='"+baseid+"'");	
				for(int i=1;i<=hidden01;i++)
				{	
					//SAPȡֵ�ֶ�
					String sap01=Util.null2String(request.getParameter("sap01_"+i)).toUpperCase()+"";
					//��Ӧ��oa�ֶ�
					String oa01=Util.null2String(request.getParameter("oa01_"+i)).toUpperCase()+"";
					//�̶�ֵ
					String con01=Util.null2String(request.getParameter("con01_"+i));
					//�Ƿ������ֶ�
					String add01=Util.null2String(request.getParameter("add01_"+i));
					//�����޸�״̬�¶������_
					if(add01.length()==1&&"_".equals(add01)){add01="";}
					
					//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
					String oafieldid="";
					String args[]=add01.split("_");
					if(args.length>=2)
					{
						oafieldid=args[1];
						add01=args[0];
					}
					//System.out.println(oafieldid+"��һb������"+add01);
					if(!"".equals(sap01)&&!"".equals(oa01))
					{
						procpara = baseid + Util.getSeparator(); 
					    procpara += sap01 + Util.getSeparator(); 
					    procpara += oa01 + Util.getSeparator();
					    procpara += con01+ Util.getSeparator()+"";
					    procpara += i+""+Util.getSeparator()+"";
					    procpara +=add01+ Util.getSeparator()+"";//ƴ���Ƿ���ϸ��
						procpara +=oafieldid+ Util.getSeparator()+"";
						procpara +=isbill;
					    boolean result=rs.executeProc("sap_inParameter_Insert",procpara);
				   }
				}
				//System.out.println("��������������һ---------");
				for(int i=1;i<=hidden02;i++)
				{	
					//�õ��ṹ����
					String stru=Util.null2String(request.getParameter("stru_"+i)).toUpperCase()+"";
					String nameid=SapUtil.InsertSap_complexname(baseid,"3",stru,"","");
					//�õ��ýṹ������Ĳ�������
					int cbox2=Util.getIntValue(request.getParameter("cbox2_"+i),0);
					if(cbox2<=0)
					{
						continue;//������һ���ṹ���ѭ��
					}else
					{
						//ѭ��ȡ�ṹ�������������
						
						for(int j=1;j<=cbox2;j++)
						{
							//SAPȡֵ�ֶ�
							String sap02=Util.null2String(request.getParameter("sap02_"+i+"_"+j)).toUpperCase()+"";
							//��Ӧ��oa�ֶ�
							String oa02=Util.null2String(request.getParameter("oa02_"+i+"_"+j)).toUpperCase()+"";
							//�̶�ֵ
							String con02=Util.null2String(request.getParameter("con02_"+i+"_"+j));
							//�Ƿ������ֶ�
							String add02=Util.null2String(request.getParameter("add02_"+i+"_"+j));
							//�����޸�״̬�¶������_
							if(add02.length()==1&&"_".equals(add02)){add02="";}
							//System.out.println("add02_"+i+"_"+j+"�õ�����ṹ�Ĳ���"+add02);
							//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
							String oafieldid="";
							String args[]=add02.split("_");
							//System.out.println("����"+args.length);
							if(args.length>=2)
							{
								oafieldid=args[1];
								add02=args[0];
								//System.out.println("oafieldid"+oafieldid);
								//System.out.println("add02"+add02);
								
							}
							//System.out.println("�޸�����ṹ");
							if(!"".equals(sap02)&&!"".equals(oa02)&&!"-1".equals(nameid))
							{
								procpara = baseid + Util.getSeparator(); 
								procpara += nameid + Util.getSeparator(); 
							    procpara += sap02 + Util.getSeparator(); 
							    procpara += oa02 + Util.getSeparator();
							    procpara += con02 + Util.getSeparator();
							    procpara += j+""+ Util.getSeparator()+"";
								procpara += i+""+ Util.getSeparator()+"";
								procpara +=add02+""+Util.getSeparator();//ƴ���Ƿ���ϸ��
								procpara +=oafieldid+""+Util.getSeparator();
								procpara +=isbill;
							    boolean result=rs.executeProc("sap_inStructure_Insert",procpara);
						   }
						}
					
					}
				}
				//System.out.println("����ṹ�������һ---------");
				for(int i=1;i<=hidden03;i++)
				{
					
					//SAPȡֵ�ֶ�
					String sap03=Util.null2String(request.getParameter("sap03_"+i)).toUpperCase()+"";
					//��ʾ��
					String show03=Util.null2String(request.getParameter("show03_"+i));
					//�Ƿ���ʾ
					String dis03=Util.getIntValue(request.getParameter("dis03_"+i),0)+"";
					//�踳ֵ��oa�ֶ�
					String setoa3=Util.null2String(request.getParameter("setoa3_"+i)).toUpperCase()+"";
					//�Ƿ������ֶ�
					String add03=Util.null2String(request.getParameter("add03_"+i));
					//�����޸�״̬�¶������_
					if(add03.length()==1&&"_".equals(add03)){add03="";}
					//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
					String oafieldid="";
					String args[]=add03.split("_");
					//System.out.println(args.length+"�������"+add03);
					if(args.length>=2)
					{
						oafieldid=args[1];
						add03=args[0];
						//System.out.println("oafieldid"+oafieldid);
						//System.out.println("add03"+add03);
					}		
					if(!"".equals(sap03))
					{
						procpara = baseid + Util.getSeparator(); 
					    procpara += sap03 + Util.getSeparator(); 
					    procpara += show03 + Util.getSeparator();
					    procpara += dis03+ Util.getSeparator();
					    procpara += i+""+Util.getSeparator()+"";
					    procpara +=setoa3+Util.getSeparator()+"";
					    procpara +=add03+ Util.getSeparator();//ƴ���Ƿ���ϸ��
						procpara +=oafieldid+ Util.getSeparator()+"";
						procpara +=isbill;
					    boolean result=rs.executeProc("sap_outParameter_Insert",procpara);
				    }
				
				}
				//System.out.println("��������������һ---------");
				for(int i=1;i<=hidden04;i++)
				{
					//�õ��ṹ����
					String stru=Util.null2String(request.getParameter("outstru_"+i)).toUpperCase()+"";
					String nameid=SapUtil.InsertSap_complexname(baseid,"4",stru,"","");
					//�õ��ýṹ������Ĳ�������
					int cbox4=Util.getIntValue(request.getParameter("cbox4_"+i),0);
					//System.out.println(nameid+"�����"+stru+"��˳��"+stru);
					if(cbox4<=0)
					{
						continue;//������һ���ṹ���ѭ��
					}else
					{
						//ѭ��ȡ�ṹ�������������
						for(int j=1;j<=cbox4;j++)
						{
							//SAPȡֵ�ֶ�
							String sap04=Util.null2String(request.getParameter("sap04_"+i+"_"+j)).toUpperCase()+"";
							//��ʾ��
							String show04=Util.null2String(request.getParameter("show04_"+i+"_"+j));
							//�Ƿ���ʾ
							String dis04=Util.getIntValue(request.getParameter("dis04_"+i+"_"+j),0)+"";
							//�Ƿ���Ϊ��ѯ����
							String con04=Util.getIntValue(request.getParameter("sea04_"+i+"_"+j),0)+"";
							//�踳ֵ��oa�ֶ�
							String setoa4=Util.null2String(request.getParameter("setoa4_"+i+"_"+j)).toUpperCase()+"";
							//�Ƿ������ֶ�
							String add04=Util.null2String(request.getParameter("add04_"+i+"_"+j));
							//�����޸�״̬�¶������_
							if(add04.length()==1&&"_".equals(add04)){add04="";}
							//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
							String oafieldid="";
							String args[]=add04.split("_");
							if(args.length>=2)
							{
								oafieldid=args[1];
								add04=args[0];
							}
							if(!"".equals(sap04)&&!"-1".equals(nameid))
							{
							  	procpara = baseid + Util.getSeparator(); 
							    procpara += nameid + Util.getSeparator(); 
							    procpara += sap04 + Util.getSeparator(); 
							    procpara += show04 +Util.getSeparator(); 
							    procpara += dis04 +Util.getSeparator(); 
							    procpara += con04 +Util.getSeparator(); 
							    procpara += j+""+ Util.getSeparator()+"";
								procpara += i+""+ Util.getSeparator()+"";
								procpara += setoa4+ Util.getSeparator()+"";
								procpara +=add04+ Util.getSeparator();//ƴ���Ƿ���ϸ��
								procpara +=oafieldid+ Util.getSeparator()+"";
								procpara +=isbill;
							    boolean result=rs.executeProc("sap_outStructure_Insert",procpara);
						   }
						}
					}
				}
				//System.out.println("����ṹ�������һ---------");
				for(int i=1;i<=hidden05;i++)
				{
					//�õ�����
					String stru=Util.null2String(request.getParameter("outtable_"+i)).toUpperCase()+"";
					//�õ���д��
					String backtable5=Util.null2String(request.getParameter("backtable5_"+i));
					//�õ���д����
					String backoper5=Util.null2String(request.getParameter("backoper5_"+i));
					String nameid=SapUtil.InsertSap_complexname(baseid,"2",stru,backtable5,backoper5);
							
					//�õ��ýṹ������Ĳ�������
					int cbox5=Util.getIntValue(request.getParameter("cbox5_"+i),0);
					//�õ�where������������
		    		int sapson_05count=Util.getIntValue(request.getParameter("sapson_05count_"+i),0);
		    		//System.out.println("where�����ܸ���"+sapson_05count);
					
						//ѭ��ȡ�ṹ�������������
						for(int j=1;j<=cbox5;j++)
						{
							//SAPȡֵ�ֶ�
							String sap05=Util.null2String(request.getParameter("sap05_"+i+"_"+j)).toUpperCase()+"";
							//��ʾ��
							String show05=Util.null2String(request.getParameter("show05_"+i+"_"+j));
							//�Ƿ���ʾ
							String dis05=Util.getIntValue(request.getParameter("dis05_"+i+"_"+j),0)+"";
							//�Ƿ���Ϊ��ѯ����
							String sea05=Util.getIntValue(request.getParameter("sea05_"+i+"_"+j),0)+"";
							//�Ƿ�Ϊ����
							String key05=Util.getIntValue(request.getParameter("key05_"+i+"_"+j),0)+"";
							//�Ƿ������ֶ�
							String add05=Util.null2String(request.getParameter("add05_"+i+"_"+j));
							//�����޸�״̬�¶������_
							if(add05.length()==1&&"_".equals(add05)){add05="";}
							//�踳ֵ��oa�ֶ�
							String setoa5=Util.null2String(request.getParameter("setoa5_"+i+"_"+j)).toUpperCase()+"";
							
							//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
							String oafieldid="";
							String args[]=add05.split("_");
							if(args.length>=2)
							{
								oafieldid=args[1];
								add05=args[0];
							}
							if(!"".equals(sap05)&&!"-1".equals(nameid))
							{
							  	procpara = baseid + Util.getSeparator(); 
							    procpara += nameid + Util.getSeparator(); 
							    procpara += sap05 + Util.getSeparator();
							    procpara += show05 + Util.getSeparator();
							    procpara += dis05 + Util.getSeparator();
							    procpara += sea05 + Util.getSeparator();
							    procpara += key05+ Util.getSeparator();
							    procpara += j+""+ Util.getSeparator()+"";
								procpara += i+""+ Util.getSeparator()+"";
								procpara += setoa5+ Util.getSeparator()+"";
								procpara +=add05+ Util.getSeparator();//ƴ���Ƿ���ϸ��
								procpara +=oafieldid+ Util.getSeparator()+"";
								procpara +=isbill;
							    boolean  result=rs.executeProc("sap_outTable_Insert",procpara);
						   }
						}
					
					
							//ѭ��where����
							if(sapson_05count<=0)
							{
								continue;
							}else
							{
					    		//ѭ������where�����ĸ���
					    		for(int o=1;o<=sapson_05count;o++)
					    		{
					    				//baseid_1  integer,
										//outtablename_2   varchar2,	
										//sapfield_3    varchar2,	
									    //oafield_4    varchar2,	
									    //constant_5  varchar2,	
									    //ordernum_6  varchar2,	
									    //ismainfield_7 varchar2,	
									    //fromfieldid_8  varchar2,	
					    				 //����������where����
							    		String input01=Util.null2String(request.getParameter("sap05son_"+i+"_"+o));//��ϸȡֵ�ֶ�
										String input02=Util.null2String(request.getParameter("set05son_"+i+"_"+o));//��ϸ��ֵ�ֶ����ݿ��ֶε�����
										String input03=Util.null2String(request.getParameter("add05son_"+i+"_"+o));//��ϸ��ֵ�ֶ����ݿ��ֶε�id
										String input04=Util.null2String(request.getParameter("con05son_"+i+"_"+o));//�̶�ֵ
										String ismainfield_7="";
										String fromfieldid_8="";
										if("".equals(input03))
										{
											continue;
										}else
										{
											ismainfield_7=input03.split("_")[0];
											fromfieldid_8=input03.split("_")[1];
										}
										procpara = baseid + Util.getSeparator()+""; 
				    					procpara += nameid + Util.getSeparator()+""; 
				    					procpara += input01 + Util.getSeparator()+"";
				    					procpara += input02 + Util.getSeparator()+"";
				    					procpara += input04+ Util.getSeparator()+"";
				    					procpara += 0+""+Util.getSeparator()+"";
				    					procpara += ismainfield_7+""+ Util.getSeparator()+"";
				    					procpara += fromfieldid_8+""+ Util.getSeparator()+"";
				    					procpara +=isbill;
				    					//931PRODUCTIONRESOURCEDEL_INDMATKL2010595
				    					//System.out.println("���������"+procpara);
				    					boolean result02=rs.executeProc("sap_outparaprocess_Insert",procpara);
				    					
										//System.out.println("�����Ƿ�ɹ�"+result02);
					    		}
					    	}
						
				}
						for(int i=1;i<=hidden06;i++)
						{
							//��Ȩ����
							String autotype=Util.null2String(request.getParameter("autotype_"+i));
							//��Ȩ��Ա���ɫ
							String autouserid=Util.null2String(request.getParameter("autouserorwf_"+i));
							//��Ȩ����
							String autowfid=Util.null2String(request.getParameter("autowfid_"+i));
							//int_authorizeRight���id
							String autoset=Util.null2String(request.getParameter("autodeti_"+i));
							if("".equals(autoset))//����
							{
								if(!"".equals(autouserid))
								{
									procpara = baseid + Util.getSeparator(); 
								    procpara += autotype + Util.getSeparator(); 
								    if("1".equals(autotype))//��Ա
								    {
								    	 procpara += autouserid + Util.getSeparator(); 
								    	 procpara += "" + Util.getSeparator(); 
								    }else  if("2".equals(autotype))//��ɫ
								    {
								    	procpara += "" + Util.getSeparator(); 
								    	procpara += autouserid + Util.getSeparator(); 
								    }
								    procpara += autowfid + Util.getSeparator();
								    procpara +=i;
									rs.executeProc("int_authorizeRight_insert",procpara);	  
								}
								
							}else//�޸�
							{
								if(!"".equals(autouserid))
								{
									oldautotypeid=oldautotypeid.replace(","+autoset+",",",");//�ų��޸ĵ�����id
									procpara = autoset + Util.getSeparator(); 
									procpara += baseid + Util.getSeparator(); 
								    procpara += autotype + Util.getSeparator(); 
								    if("1".equals(autotype))//��Ա
								    {
								    	 procpara += autouserid + Util.getSeparator(); 
								    	 procpara += "" + Util.getSeparator(); 
								    }else  if("2".equals(autotype))//��ɫ
								    {
								    	procpara += "" + Util.getSeparator(); 
								    	procpara += autouserid + Util.getSeparator(); 
								    }
								    procpara += autowfid + Util.getSeparator();
								    procpara +=i;
									rs.executeProc("int_authorizeRight_update",procpara);	  
								}
							}
					}
					if(!"".equals(oldautotypeid)&&oldautotypeid.length()>0)//˵����Щ����Ҫɾ��
					{
						String oldautotypeids[]=oldautotypeid.split(",");
						for(int h=0;h<oldautotypeids.length;h++)
						{
							if(!"".equals(oldautotypeids[h]))
							{
								rs.execute("delete int_authorizeRight where id='"+oldautotypeids[h]+"'");
								rs.execute("delete int_authorizeDetaRight where rightid='"+oldautotypeids[h]+"'");
							}
						}
					}
					
					for(int i=1;i<=hidden07;i++)
						{
							//�õ�����
							String tablename=Util.null2String(request.getParameter("outtable7_"+i));
							String backtable7=Util.null2String(request.getParameter("backtable7_"+i));//�õ�Դ��
							String nameid=SapUtil.InsertSap_complexname(baseid,"1",tablename,backtable7,"");
							//�õ��ýṹ������Ĳ�������
							int cbox7=Util.getIntValue(request.getParameter("cbox7_"+i),0);
							if(cbox7<=0)
							{
								continue;//������һ���ṹ���ѭ��
							}else
							{
								//ѭ��ȡ�ṹ�������������
								for(int j=1;j<=cbox7;j++)
								{
								
									//SAP��ֵ�ֶ�
									String sap07=Util.null2String(request.getParameter("sap07_"+i+"_"+j)).toUpperCase()+"";
									//oaȡֵ�ֶ�
									String setoa7=Util.null2String(request.getParameter("setoa7_"+i+"_"+j)).toUpperCase()+"";
									//�Ƿ������ֶ�
									String add07=Util.null2String(request.getParameter("add07_"+i+"_"+j));
									//�����޸�״̬�¶������_
									if(add07.length()==1&&"_".equals(add07)){add07="";}
									//�̶�ֵ
									String con07=Util.null2String(request.getParameter("con07_"+i+"_"+j));
									
									//�ж������oa�ֶ��Ƿ���ڣ����ҵõ����ֶε�fieldid
									String oafieldid="";
									String args[]=add07.split("_");
									if(args.length>=2)
									{
										oafieldid=args[1];
										add07=args[0];
									}

									if(!"".equals(sap07)&&!"-1".equals(nameid))
									{
									  	procpara = baseid + Util.getSeparator(); 
									    procpara += nameid + Util.getSeparator(); 
									    procpara += sap07 + Util.getSeparator();
									    procpara += setoa7+""+ Util.getSeparator()+"";
									    procpara += con07+""+ Util.getSeparator()+"";
									    procpara += j+""+ Util.getSeparator()+"";
										procpara += i+""+ Util.getSeparator()+"";
										procpara +=add07+ Util.getSeparator();//ƴ���Ƿ���ϸ��
							   			procpara +=oafieldid+ Util.getSeparator()+"";
							   			procpara +=isbill;
									    rs.executeProc("sap_inTable_Insert",procpara);
								   }
								}
							
							}
						}
											
				flag="1";
			}else
			{
				flag="2";
			}
		}
		
	}
	if("1".equals(w_type))//��Ҫ���¸��������
	{
		//���������̽ڵ�ǰ�󡢸��ӹ����
		BaseAction baseAction = new BaseAction();
		baseAction.checkActionOnNodeOrLink(Util.getIntValue(w_fid),Util.getIntValue(w_nodeid+""),Util.getIntValue(nodelinkid+""), Util.getIntValue(ispreoperator+""));
	}
	NewSapBrowserComInfo newsapcominfo= new NewSapBrowserComInfo();
	newsapcominfo.removeSapBrowserComInfo();//������
	//System.out.println("����flag"+flag);
%>
<body></body>
<script type="text/javascript">
	
	
	if("<%=flag%>"=="1")
	{
		window.parent.parent.alert("<%=SystemEnv.getHtmlLabelName(30648 ,user.getLanguage()) %>"+"!");
		
		<%
			if("1".equals(w_type))//0-��ʾ�������ť��������Ϣ��1-��ʾ�ǽڵ��������ʱ����Ϣ
			{
			//ˢ�½ڵ��������
		%>
			window.parent.parent.close();
			dialogArguments.reloadDMLAtion();//�༭��ʱ��ˢ�½ڵ���������
		<%
			}else//0-��ʾ�������ť��������Ϣ��1-��ʾ�ǽڵ��������ʱ����Ϣ
			{
		%>
				window.parent.parent.document.getElementById("hidediv").style.display="none";
				if("<%=dataauth%>"=="2")
				{
					//��ʾ������Ȩ--(ѡ��������Ȩ�Ľ���)
					//window.parent.document.getElementById("dataauthli").style.display="";
					//window.parent.document.getElementById("dataauthli").click();
					var utlstr="/integration/browse/integrationBrowerMain.jsp";
					utlstr+="?browsertype=226&mark=<%=mark%>&formid=<%=formid%>&updateTableName=<%=updateTableName%>&dataauth=<%=dataauth%>";
					window.parent.parent.changeurl(utlstr);
				}else
				{
					window.parent.parent.returnValue='<%=mark%>';
					window.parent.parent.close();
				}
		<%
			}
		%>
	}else if(<%=flag%>=="2")
	{
		window.parent.parent.alert("<%=SystemEnv.getHtmlLabelName(30651 ,user.getLanguage()) %>"+"!");
		window.parent.parent.document.getElementById("hidediv").style.display="none";
		window.parent.parent.document.getElementById("hidedivmsg").style.display="none";
		
	}
	else
	{
		window.parent.parent.alert("<%=SystemEnv.getHtmlLabelName(30651 ,user.getLanguage()) %>"+"!");
		window.parent.parent.document.getElementById("hidediv").style.display="none";
		window.parent.parent.document.getElementById("hidedivmsg").style.display="none";
	}
</script>