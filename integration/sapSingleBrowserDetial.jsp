<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="com.weaver.integration.entity.NewSapBrowserComInfo"%>
<%@page import="com.weaver.integration.entity.NewSapBrowser"%>
<%@page import="com.weaver.integration.entity.NewSapBaseBrowser"%>
<%@page import="com.weaver.integration.entity.Sap_outParameterBean"%>
<%@page import="com.weaver.integration.entity.Sap_outTableBean"%>
<%@page import="com.weaver.integration.entity.Sap_inParameterBean"%>
<%@page import="com.weaver.integration.datesource.SAPInterationOutUtil"%>
<%@page import="com.weaver.integration.params.BrowserReturnParamsBean"%>
<%@page import="com.weaver.integration.log.LogInfo"%>
<%@page import="com.weaver.integration.entity.Sap_inStructureBean"%>
<%@page import="com.weaver.integration.entity.Sap_outStructureBean"%>
<%@page import="com.weaver.integration.util.IntegratedSapUtil"%> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="java.util.List" %>
<%@ page import="weaver.parseBrowser.*" %>
<%@ page import="weaver.interfaces.sap.SAPConn" %>
<%@ page import="com.sap.mw.jco.JCO" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs01" class="weaver.conn.RecordSet" scope="page" />
<script language="javascript" src="/js/weaver.js"></script>
<link href="/integration/css/intepublic.css" type=text/css rel=stylesheet>
<link href="/integration/css/loading.css" type=text/css rel=stylesheet>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<html>
	<body>
	
			<% 
				//������½����̣�ֻ�ܴ�ҳ��ȡ����
				String imagefilename = "/images/hdSystem.gif";
				String titlename = "SAP"+SystemEnv.getHtmlLabelName(30688 ,user.getLanguage());
				String needfav ="1";
				String needhelp ="";
				String type=Util.null2String(request.getParameter("type"));//�������̰�ť��ʶ 
				String operate=Util.null2String(request.getParameter("operate"));
				if("".equals(operate)){operate="select";}
				String fromfieldid=Util.null2String(request.getParameter("fromfieldid"));//�ֶ�id
				String detailrow=Util.null2String(request.getParameter("detailrow"));//�к�
				NewSapBrowserComInfo NewSapBrowserComInfo=new NewSapBrowserComInfo();
				NewSapBaseBrowser nb=NewSapBrowserComInfo.getSapBaseBrowser(type);//��ȡ�����ť�Ļ�����Ϣ
				IntegratedSapUtil integratedSapUtil=new IntegratedSapUtil();
				int rows=50;//ÿҳ��ʾ������
				int rownum=1;//�к�
				int countdata=1;//�õ�������
				int curpage=Util.getIntValue(request.getParameter("curpage"),1);//��ǰҳ
				List outParameter=nb.getSap_outParameter();//��ȡ�������
				List outTable=nb.getSap_outTable();//��ȡ�����
				List outStructure=nb.getSap_outStructure();//��ȡ����ṹ
				List inParameter=nb.getSap_inParameter();//��ȡ�������
				List inStructure=nb.getSap_inStructure();//��ȡ����ṹ
				
				 String hpid = nb.getHpid();//�칹ϵͳ��id
				 String poolid=nb.getPoolid();//���ӳص�id
				 String regservice=nb.getRegservice();//����id
				 int loadDate=0;
				 if(rs.execute("select loadDate from sap_service where id='"+regservice+"'")&&rs.next()){
				 	loadDate=Util.getIntValue(Util.null2String(rs.getString("loadDate")),0);
				 }
				
				boolean isOnlyOutTable=true;//�ж��Ƿ�ֻ����������ֻ���������д����������ֵ���������û��������Ͳ���д����������ֵ��������ΪĿǰ�������������ṹû�������ĸ���
				
				StringBuffer intablefield=new StringBuffer(); //��¼����������ֶ�
				StringBuffer intstrufield=new StringBuffer(); //��¼����ṹ���ֶ�
				StringBuffer outtablesb=new StringBuffer(); //��¼�����������ֶ�
				StringBuffer outtablestr=new StringBuffer();//��¼��������ʾ�ֶ�
				StringBuffer outtablelist=new StringBuffer();//��¼����������list
				List listoafield=new ArrayList();//��װ��ֵ�ֶ�
				List listsapfield=new ArrayList();//��װ������sap��ʾ���ֶ���
				List listsapfielddisplay=new ArrayList();//��װ������sap�������ֶ���
				List listparamy=new ArrayList();//��װ�����ֶ�
				List seachfield=new ArrayList();//��װ��ѯ�ֶ�
				Map TableList=new HashMap();
				SAPInterationOutUtil saputil=new SAPInterationOutUtil();
				HashMap hashmap=new HashMap();
				
				//��¼������ҳ��������Ĳ���
				String oncelistinput="";
				//����ҳ���������
				for(int i=0;i<inParameter.size();i++)
				{
					Sap_inParameterBean sap_inParameterBean=(Sap_inParameterBean)inParameter.get(i);
					String Constant=sap_inParameterBean.getConstant();//��������Ĺ̶�ֵ
					String Oafield=sap_inParameterBean.getOafield();//���������Դ��OA�ֶε�ֵ
					String sapfield=sap_inParameterBean.getSapfield();//���������sap�ֶ�
					String oafieldid=sap_inParameterBean.getFromfieldid();//OA�ֶε�id
					String ismainfieldmy=sap_inParameterBean.getIsmainfield();//�Ƿ������ֶ�
					String inpar="";
					if("1".equals(ismainfieldmy))//����
					{
						 inpar=Util.null2String(request.getParameter("field"+oafieldid)).trim().toUpperCase();
					}else//��ϸ���ֶ�
					{
						 inpar=Util.null2String(request.getParameter("field"+oafieldid+"_"+detailrow)).trim().toUpperCase();
					}
					if("".equals(Constant))//��ʾû�й̶�ֵ
					{
							Constant=inpar;//����ҳ���Ĭ��ֵ
						
							if("1".equals(ismainfieldmy))//����
							{
									//��¼����ҳ������Ĳ���
								  oncelistinput+=("<input type='hidden' name='field"+oafieldid+"' value='"+Constant+"'>");
							}else{
									//��¼����ҳ������Ĳ���
								  oncelistinput+=("<input type='hidden' name='field"+oafieldid+"_"+detailrow+"' value='"+Constant+"'>");
							}
					}
					//System.out.println("---���������־(��������)----");
					//System.out.println("--------------sapȡֵ�ֶ�----"+sapfield);
					//System.out.println("--------------��Ӧ��oa�ֶ�----"+Oafield);
					//System.out.println("--------------�Ƿ������ֶ�----"+ismainfieldmy);
					//System.out.println("--------------�̶�ֵ----"+Constant);
					hashmap.put(sapfield,Constant);
					//System.out.println("---���������������־----");
					//System.out.println("--------------�������----"+sapfield);
					//System.out.println("--------------�̶�ֵ----"+Constant);
					//System.out.println("                   ");
				}
				//����ҳ������ṹ
				for(int i=0;i<inStructure.size();i++)
				{
					Sap_inStructureBean sap_instructureBean=(Sap_inStructureBean)inStructure.get(i);
					String Constant=sap_instructureBean.getConstant();//��������Ĺ̶�ֵ
					String Oafield=sap_instructureBean.getOafield();//���������Դ��OA�ֶε�ֵ
					String sapfield=sap_instructureBean.getSapfield();//���������sap�ֶ�
					String oafieldid=sap_instructureBean.getFromfieldid();//OA�ֶε�id
					String ismainfieldmy=sap_instructureBean.getIsmainfield();//�Ƿ������ֶ�
					String stuname=sap_instructureBean.getName();//�ṹ�������
					String inpar="";
					if("1".equals(ismainfieldmy))//����
					{
						 inpar=Util.null2String(request.getParameter("field"+oafieldid)).trim().toUpperCase();
					}else//��ϸ���ֶ�
					{
						 inpar=Util.null2String(request.getParameter("field"+oafieldid+"_"+detailrow)).trim().toUpperCase();
					}
					if("".equals(Constant))//��ʾû�й̶�ֵ
					{
							Constant=inpar;//����ҳ���Ĭ��ֵ
							if("1".equals(ismainfieldmy))//����
							{
								   //��¼����ҳ������Ĳ���
								  oncelistinput+=("<input type='hidden' name='field"+oafieldid+"' value='"+Constant+"'>");
							}else{
								   //��¼����ҳ������Ĳ���
								  oncelistinput+=("<input type='hidden' name='field"+oafieldid+"_"+detailrow+"' value='"+Constant+"'>");
							}
					}
					//System.out.println("---���������־(�ṹ��)----");
					//System.out.println("--------------sapȡֵ�ֶ�----"+sapfield);
					//System.out.println("--------------��Ӧ��oa�ֶ�----"+Oafield);
					//System.out.println("--------------�Ƿ������ֶ�----"+ismainfieldmy);
					//System.out.println("--------------�̶�ֵ----"+Constant);
					hashmap.put(stuname+"."+sapfield,Constant);
					//System.out.println("---���������������־----");
					//System.out.println("--------------�������----"+stuname+"."+sapfield);
					//System.out.println("--------------�̶�ֵ----"+Constant);
					//System.out.println("                   ");
				}
				int display=0;//�õ���ʾ�е�����
				if(outTable.size()>0)//˵���������,���ض���ֵ
				{
							//�����--start
							int tempj=0;
							for(int i=0;i<outTable.size();i++)//ѭ������
							{
								Sap_outTableBean s=(Sap_outTableBean)outTable.get(i);
								//�ж��Ƿ��в�ѯ�ֶ�
								if((s.getSearch()).equals("1"))
								{
									if(tempj%2==0&&tempj!=0)
									{
										outtablesb.append("<TR class='Spacing'  style='height:1px;'><TD class='Line1' colspan=4></TD></TR>");
										outtablesb.append("<TR class='Spacing'  style='height:1px;'>");
									}
									outtablesb.append("<td>"+s.getShowname()+"</td>");

									outtablesb.append("<td class=field><input type='text' name='"+s.getName()+"."+s.getSapfield()+"' value='"+Util.null2String(request.getParameter(s.getName()+"."+s.getSapfield())).toUpperCase()+"'></td>");
									if(tempj%2==1)
									{
										outtablesb.append("</TR>");
									}
									tempj++;
									seachfield.add(s.getName()+"."+s.getSapfield());
									hashmap.put(s.getSapfield(),Util.null2String(request.getParameter(s.getSapfield())).toUpperCase());
								}
								if(display==0)
								{
									outtablestr.append("<th style='display:none'>"+SystemEnv.getHtmlLabelName(30689 ,user.getLanguage()));
									outtablestr.append("</th>");
									outtablestr.append("<th>");
										outtablestr.append(SystemEnv.getHtmlLabelName(15486 ,user.getLanguage()));
									outtablestr.append("</th>");
								}
								//�ж��Ƿ�����ʾ�ֶ�
								if((s.getDisplay()).equals("1"))//��ʾ��
								{
									outtablestr.append("<th>");
										outtablestr.append(s.getShowname());
									outtablestr.append("</th>");
									display++;
									listsapfield.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
								}else//������
								{
									outtablestr.append("<th style='display:none'>");
										outtablestr.append(s.getShowname());
									outtablestr.append("</th>");
									display++;
									listsapfielddisplay.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
								}
								//�ж��Ƿ��и�ֵ�ֶ�
								if(!"".equals(s.getFromfieldid()))
								{
									listoafield.add(s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getIsmainfield()+"-"+s.getName()+"."+s.getSapfield());
								}
								//�ж��Ƿ�Ϊ����
								if("1".equals(s.getPrimarykey()))
								{
									listparamy.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
								}
							}
							if(tempj%2!=0)
							{
								outtablesb.append("</TR>");
								outtablesb.append("<TR class='Spacing'  style='height:1px;'><TD class='Line1' colspan=4></TD></TR>");
							}
							if(!"".equals(outtablesb.toString().trim()))
							{	
								
								outtablesb=new StringBuffer("<table width=100% class='viewform' id='seachtable'><colgroup><col width='25%'><col width='25%'><col width='25%'><col width='25%'></colgroup>"+outtablesb);
								outtablesb.append("</table>");
							}
							//�����--end	
							//System.out.println("------����sap�����Ļ���������Ϣ----");
							//System.out.println("------��������ĸ���----"+hashmap.size());
							//System.out.println("------�����ť�ı�ʶ----"+type);
							//System.out.println("---------------------------------");
							BrowserReturnParamsBean returnpar=new BrowserReturnParamsBean ();
							if("search".equals(operate)||loadDate==1)
							{
								  //System.out.println("ִ����������");
								 returnpar=saputil.executeABAPFunction(hashmap,type,new LogInfo());
							}
							
							if(null!=returnpar)
							{
								TableList=returnpar.getTableMap();
								if(null!=TableList)
								{
									Iterator iteratorm=TableList.entrySet().iterator();
									while(iteratorm.hasNext())
									{
										Map.Entry entry = (Map.Entry)iteratorm.next();
										Object key=entry.getKey();
										List valuelist = (List)entry.getValue();
										//System.out.println("�����ı���Ϊ:-------------"+key);
										if(null!=valuelist)
										{
											for(int ji=0;ji<valuelist.size();ji++)
											{
													boolean flag=false;
													Map hashmap02=(HashMap)valuelist.get(ji);//��ʾһ������
													//��������
													for(int jk=0;jk<seachfield.size();jk++)
													{
														
														//�����Сд��������
														String seaflied=Util.null2String(request.getParameter(seachfield.get(jk)+"")).trim().toUpperCase();
														//System.out.println("��������"+seaflied);
													//	System.out.println("����"+hashmap02.get(seachfield.get(jk)+""));
														if((hashmap02.get(seachfield.get(jk)+"")+"").indexOf(seaflied)==-1)//������������
														{
															
															flag=true;//��ʾ�������ݲ���������
															break;
														}
														
													}
													if(flag)
													{
														rownum++;
														continue;
													}
													if(listsapfield.size()>0)//˵���п���ʾ���ֶλ������ص��ֶ�
													{
														if("search".equals(operate))//�����Դ������
														{
																	String prarmlie="";
																	//ѭ��������
																	for(int bj=0;bj<listparamy.size();bj++)//�����п����кܶ࣬��������
																	{
																		prarmlie+=hashmap02.get(listparamy.get(bj))+"$_$";
																	}
																	//��֤Ȩ��--start
																	if(integratedSapUtil.checkUserOperate(type,prarmlie,user))
																	{
																	
																		if(countdata<=(rows*curpage)&&countdata>rows*(curpage-1))
																		{
																					if(countdata%2==0)
																					{
																						outtablelist.append("<tr class='DataDark'>");
																					}else
																					{
																						outtablelist.append("<tr class='DataLight'>");
																					}
																					outtablelist.append("<td style='display:none'>"+prarmlie.replaceAll("\\$_\\$"," "));
																					outtablelist.append("</td>");
																					outtablelist.append("<td>"+countdata);
																					outtablelist.append("</td>");
															         				for(int jk=0;jk<listsapfield.size();jk++)//�����ʾ��
															         				{
															         						Object result=hashmap02.get(listsapfield.get(jk));
															         						if(null==result)
															         						{
															         							result="";
															         						}
															         						outtablelist.append("<td>"+result+"<input name='"+listsapfield.get(jk)+"' type='hidden' value='"+result+"'></td>");
															         				}
															         				for(int jk=0;jk<listsapfielddisplay.size();jk++)//���������
															         				{
															         						Object result=hashmap02.get(listsapfielddisplay.get(jk));
															         						if(null==result)
															         						{
															         							result="";
															         						}
															         						outtablelist.append("<td style='display:none'>"+result+"<input name='"+listsapfielddisplay.get(jk)+"' type='hidden' value='"+result+"'></td>");
															         				}
															         				outtablelist.append("</tr>");
												         					}
											         				countdata++;
																	rownum++;
																	continue;
																}
																//��֤Ȩ��--end
														}else//����Դ������
														{	
																	String prarmlie="";
																	//ѭ��������
																	for(int bj=0;bj<listparamy.size();bj++)//�����п����кܶ࣬��������
																	{
																		prarmlie+=hashmap02.get(listparamy.get(bj))+"$_$";
																	}
																	
																	
																	//��֤Ȩ��--start
																	if(integratedSapUtil.checkUserOperate(type,prarmlie,user))
																	{
																	
																		if(rownum<=(rows*curpage)&&rownum>rows*(curpage-1))
																		{
																				if(rownum%2==0)
																				{
																					outtablelist.append("<tr class='DataDark'>");
																				}else
																				{
																					outtablelist.append("<tr class='DataLight'>");
																				}
																				outtablelist.append("<td style='display:none'>"+prarmlie.replaceAll("\\$_\\$"," "));
																				outtablelist.append("</td>");
																				outtablelist.append("<td>"+rownum);
																				outtablelist.append("</td>");
																				for(int jk=0;jk<listsapfield.size();jk++)//�����ʾ��
														         				{
														         						Object result=hashmap02.get(listsapfield.get(jk));
														         						if(null==result)
														         						{
														         							result="";
														         						}
														         						outtablelist.append("<td>"+result+"<input name='"+listsapfield.get(jk)+"' type='hidden' value='"+result+"'></td>");
														         				}
														         				for(int jk=0;jk<listsapfielddisplay.size();jk++)//���������
														         				{
														         						Object result=hashmap02.get(listsapfielddisplay.get(jk));
														         						if(null==result)
														         						{
														         							result="";
														         						}
														         						outtablelist.append("<td style='display:none'>"+result+"<input name='"+listsapfielddisplay.get(jk)+"' type='hidden' value='"+result+"'></td>");
														         				}
														         				outtablelist.append("</tr>");
																		}
																	
																	countdata++;
																	rownum++;
																	continue;
																}
																//��֤Ȩ��--end
														}
														
							         			}
																
											}
										}
									}
								}
							}
				}else  //����Ϊ����ṹ���������
				{
				
					
					isOnlyOutTable=false;
					for(int i=0;i<outStructure.size();i++)
					{
						Sap_outStructureBean s=(Sap_outStructureBean)outStructure.get(i);
						
						if(display==0)
						{
							outtablestr.append("<th style='display:none'>"+SystemEnv.getHtmlLabelName(30689 ,user.getLanguage()));
							outtablestr.append("</th>");
							outtablestr.append("<th>");
								outtablestr.append(SystemEnv.getHtmlLabelName(15486 ,user.getLanguage()));
							outtablestr.append("</th>");
						}
								
						//�ж��Ƿ�����ʾ�ֶ�
						if((s.getDisplay()).equals("1"))//��ʾ��
						{
							outtablestr.append("<th>");
								outtablestr.append(s.getShowname());
							outtablestr.append("</th>");
							display++;
							listsapfield.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
						}else//������
						{
							outtablestr.append("<th style='display:none'>");
								outtablestr.append(s.getShowname());
							outtablestr.append("</th>");
							display++;
							listsapfielddisplay.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
						}
						
						//�ж��Ƿ��и�ֵ�ֶ�
						if(!"".equals(s.getFromfieldid()))
						{
							listoafield.add(s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getIsmainfield()+"-"+s.getSapfield());
						}
						
						outtablelist=new StringBuffer("<tr class='DataDark'>");
						BrowserReturnParamsBean returnpar=saputil.executeABAPFunction(hashmap,type,new LogInfo());
						if(null!=returnpar)
						{
							outtablelist.append("<td style='display:none'>");
							outtablelist.append("</td>");
							outtablelist.append("<td>"+rownum);
							outtablelist.append("</td>");
							Map stmap=returnpar.getStrMap();
							for(int jk=0;jk<listsapfield.size();jk++)
	         				{
	         						Object result=stmap.get(listsapfield.get(jk));
	         						if(null==result)
	         						{
	         							result="";
	         						}
	         						outtablelist.append("<td>"+result+"<input name='"+listsapfield.get(jk)+"' type='hidden' value='"+result+"'></td>");
	         				}
	         				for(int jk=0;jk<listsapfielddisplay.size();jk++)//���������
	         				{
	         						Object result=stmap.get(listsapfielddisplay.get(jk));
	         						if(null==result)
	         						{
	         							result="";
	         						}
	         						outtablelist.append("<td style='display:none'>"+result+"<input name='"+listsapfielddisplay.get(jk)+"' type='hidden' value='"+result+"'></td>");
	         				}
						}
						outtablelist.append("</tr>");
					
					}
					for(int i=0;i<outParameter.size();i++)
					{
						Sap_outParameterBean s=(Sap_outParameterBean)outParameter.get(i);
						if(display==0)
						{
							outtablestr.append("<th style='display:none'>"+SystemEnv.getHtmlLabelName(30689 ,user.getLanguage()));
							outtablestr.append("</th>");
							outtablestr.append("<th>");
								outtablestr.append(SystemEnv.getHtmlLabelName(15486 ,user.getLanguage()));
							outtablestr.append("</th>");
						}
						//�ж��Ƿ�����ʾ�ֶ�
						if((s.getDisplay()).equals("1"))//��ʾ��
						{
							outtablestr.append("<th>");
								outtablestr.append(s.getShowname());
							outtablestr.append("</th>");
							display++;
							listsapfield.add(s.getSapfield());//����.�ֶ���
						}else//������
						{
							outtablestr.append("<th style='display:none'>");
								outtablestr.append(s.getShowname());
							outtablestr.append("</th>");
							display++;
							listsapfielddisplay.add(s.getSapfield());//����.�ֶ���
						}
						
						//�ж��Ƿ��и�ֵ�ֶ�
						if(!"".equals(s.getFromfieldid()))
						{
							listoafield.add(s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getIsmainfield()+"-"+s.getSapfield());
						}
					}
					outtablelist=new StringBuffer("<tr class='DataDark'>");
					BrowserReturnParamsBean returnpar=saputil.executeABAPFunction(hashmap,type,new LogInfo());
					if(null!=returnpar)
					{
						outtablelist.append("<td style='display:none'>");
						outtablelist.append("</td>");
						outtablelist.append("<td>"+rownum);
						outtablelist.append("</td>");
						Map stmap=returnpar.getStrMap();
						
						for(int jk=0;jk<listsapfield.size();jk++)
         				{
         						
         						Object result=stmap.get(listsapfield.get(jk));
         						if(null==result)
         						{
         							result="";
         						}
         						outtablelist.append("<td>"+result+"<input name='"+listsapfield.get(jk)+"' type='hidden' value='"+result+"'></td>");
         				}
         				for(int jk=0;jk<listsapfielddisplay.size();jk++)//���������
         				{
         						Object result=stmap.get(listsapfielddisplay.get(jk));
         						if(null==result)
         						{
         							result="";
         						}
         						outtablelist.append("<td style='display:none'>"+result+"<input name='"+listsapfielddisplay.get(jk)+"' type='hidden' value='"+result+"'></td>");
         				}
					}
					outtablelist.append("</tr>");
					
					countdata=2;//��ʾֻ��һ������
				}
				
			 %>
			 
			 
			<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
			<%
			RCMenu += "{"+SystemEnv.getHtmlLabelName(197 ,user.getLanguage())+",javascript:btnseach(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:onClose(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			if(curpage>1)
			{
				RCMenu += "{"+SystemEnv.getHtmlLabelName(1258 ,user.getLanguage())+",javascript:nextpage(2),_self} " ;
				RCMenuHeight += RCMenuHeightStep ;
			}
		
			if((countdata-1)>(curpage*rows))
			{
				RCMenu += "{"+SystemEnv.getHtmlLabelName(1259 ,user.getLanguage())+",javascript:nextpage(1),_self} " ;
				RCMenuHeight += RCMenuHeightStep ;
			}
		
			RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			%>
			<%@ include file="/systeminfo/TopTitle.jsp" %>
			<%@ include file="/systeminfo/RightClickMenu.jsp" %>
		
			<table width=100% height=100% border="0" cellspacing="0" cellpadding="0" id="bjsap">
			<colgroup>
			<col width="10">
			<col width="*">
			<col width="10">
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			<tr>
				<td ></td>
				<td valign="top">
					<TABLE class=Shadow>
					<tr>
					<td valign="top" width="100%">
					
								<form action="/integration/sapSingleBrowserDetial.jsp" name="weaver" method="post" >
										<%=oncelistinput %>
										<input type="hidden" name="operate" id="operate" value="<%=operate%>">
										<input type="hidden" name="type"  id="type" value="<%=type%>">
										<input type="hidden" name="curpage"  id="curpage" value="<%=curpage%>">
										<input type="hidden" name="fromfieldid"  id="curpage" value="<%=fromfieldid%>">
										<input type="hidden" name="detailrow"  id="detailrow" value="<%=detailrow%>">
										<%=outtablesb%>
							</form>
							
							<br>
							<table class=viewform>
							<TR class='Spacing'  style='height:1px;'><TD class='Line1' ></TD></TR>
							<tr>
								<td class=field style="text-align: right">
								    <%=SystemEnv.getHtmlLabelName(30640,user.getLanguage())%><%=curpage%><%=SystemEnv.getHtmlLabelName(30642,user.getLanguage())%>&nbsp;&nbsp;
									<%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%>
									<%out.println((countdata-1));%>
									<%=SystemEnv.getHtmlLabelName(30690,user.getLanguage())%>&nbsp;&nbsp;
									<%=SystemEnv.getHtmlLabelName(30643,user.getLanguage())%><%=rows%><%=SystemEnv.getHtmlLabelName(30690,user.getLanguage())%>&nbsp;&nbsp;
								</td>
							</tr>
							<TR class='Spacing'  style='height:1px;'><TD class='Line1'></TD></TR>
							</table>
							<table  ID=BrowseTable class=BroswerStyle cellspacing="1"  style="width:100%">
								<tr class="DataHeader">
									<%=outtablestr%>
								</tr>
									<%=outtablelist %>
							</table>
					</td>
					</tr>
					</TABLE>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			</table>
		
	</body>

	<DIV class=huotu_dialog_overlay id="hidediv"></DIV>
	     <div  id="hidedivmsg" class="bd_dialog_main"></div>

</html>

<script type="text/javascript">
jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr").bind("click",function(event){
			setParentWindowValue($(this));
			<%if(isOnlyOutTable){%>
				var temparry=Array($.trim($(this).find("td")[0].innerHTML),$.trim($(this).find("td")[0].innerHTML));
				window.parent.returnValue = Array($.trim($(this).find("td")[0].innerHTML),$.trim($(this).find("td")[0].innerHTML));
			<%}
				//�������ȸ�ֵ����������˸�ֵ�ֶΣ���ô��ֵ�ֶβ��ܸ����������ֶε�ֵ���������setParentWindowValue�����ŵ�returnvalue����ִ�к��������⣬�������ã�
			%>
			window.parent.close();
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
		$(this).addClass("Selected")
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
		$(this).removeClass("Selected")
	})

});
function btnclear_onclick(){
	window.parent.returnValue = Array(0,"");
	window.parent.close();
}
$(document).ready(function(){ 
	         $("input").keydown(function(e){ 
	             var curKey = e.which; 
	             if(curKey == 13){ 
	                 btnseach();
	                 return false; 
	             } 
	         }); 
}); 

function setParentWindowValue(checkvalue)
{
	//$(checkvalue).children("td").each(function(index) {
			//var tdvalue=$(this).text();
	//});

	<%
		//�õ���Ҫ��ֵ��oa�ֶ�
		for(int jk=0;jk<listoafield.size();jk++)
		{
			//T_DATA.MATNR
			//s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getismainfield()
			String temp=listoafield.get(jk)+"";
			String tempa[]=temp.split("-");
			String jie="field"+tempa[0];
			String jiespan="field"+tempa[0]+"span";
			String ismainfield=tempa[2];
			String filename=tempa[3];
			//s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getismainfield()
			if("0".equals(ismainfield)){
				jie = jie+"_"+detailrow;
				jiespan=jie+"span";
			}
	%>
	
	if($.browser.msie) { 
		//ie
			try{
					if($(checkvalue).find("input[name=<%=filename%>]").val()){
					 	window.dialogArguments.document.getElementById("<%=jie%>").value = $(checkvalue).find("input[name=<%=filename%>]").val();
					}else{
						window.dialogArguments.document.getElementById("<%=jie%>").value="";
					}
			}catch(e){
			}
			
			try{
			if(window.dialogArguments.document.getElementById("<%=jie%>").type=="hidden"){
				if($(checkvalue).find("input[name=<%=filename%>]").val())
				{
				 window.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML = $(checkvalue).find("input[name=<%=filename%>]").val();
				}else
				{
					window.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML="";
				}
			}else{
				window.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML = "";
			} 
			}catch(e){
			}
	}else{
			//��ie			
			//˵�����ϱ�����ϸ�ֶν���
			//input����û��id���ԣ�ֻ��name����
			//�����ڷ�ie������£�js�ű��Ҳ�������
			//�����ڷ�ie������£���	window.parent.dialogArguments.document.getElementsByName("<%=jie%>")[0]��ȡ����
			//�����ie������£��ǿ��ַ���Ĭ�ϲ�����tureô����
			
			try{
				if($(checkvalue).find("input[name=<%=filename%>]").val()){
						
				 		window.parent.dialogArguments.document.getElementsByName("<%=jie%>")[0].value = $(checkvalue).find("input[name=<%=filename%>]").val();
				}else{
						window.parent.dialogArguments.document.getElementsByName("<%=jie%>")[0].value="";
				}
				}catch(e){
						
				}
				try{
						
					if(	window.parent.dialogArguments.document.getElementsByName("<%=jie%>")[0].type=="hidden"){
						
						if($(checkvalue).find("input[name=<%=filename%>]").val()!=""){
							
						 	window.parent.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML = $(checkvalue).find("input[name=<%=filename%>]").val();
							
						}else{
							window.parent.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML="";
						}
					}else{
							window.parent.dialogArguments.document.getElementById("<%=jiespan%>").innerHTML = "";
					} 
				}catch(e){
						
							
				}
	}		
<%		
	}
%>
}
function btnseach()
{
	$("#operate").attr("value","search");
	$("#curpage").attr("value","1");
	weaver.submit();

	enableAllmenu();
	var temp=parseInt($("#bjsap").css("height"))+50;
	$("#hidediv").css("height",temp);
	var h2=$("#hidedivmsg").css("height");
	var w2=$("#hidedivmsg").css("width");
	var a=(document.body.clientWidth)/2-140; 
	var b=(document.body.clientHeight)/2-40;
	$("#hidedivmsg").css("left",a);
	$("#hidedivmsg").css("top",b);
	$("#hidediv").show();
	$("#hidedivmsg").html("����������"+"...").show();

}
function submitClear()
{
	btnclear_onclick();
}
function onClose()
{
	window.close();
}
function nextpage(type)
{
	if(type=="1")
	{
		var temp=parseInt($("#curpage").val())+1;
		$("#curpage").attr("value",temp);
		weaver.submit();
	}else
	{
		var temp=parseInt($("#curpage").val())-1;
		$("#curpage").attr("value",temp);
		weaver.submit();
	}
	
}
</script>