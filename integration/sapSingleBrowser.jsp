<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="com.weaver.integration.entity.NewSapBrowserComInfo"%>
<%@page import="com.weaver.integration.entity.NewSapBrowser"%>
<%@page import="com.weaver.integration.entity.NewSapBaseBrowser"%>
<%@page import="com.weaver.integration.entity.Sap_outParameterBean"%>
<%@page import="com.weaver.integration.entity.Sap_outTableBean"%>
<%@page import="com.weaver.integration.entity.Sap_inParameterBean"%>
<%@page import="com.weaver.integration.entity.Sap_inStructureBean"%>
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
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<html>
	<body>
	
			<% 
				//������½����̣�ֻ�ܴ�ҳ��ȡ����
				String frombrowserid = Util.null2String(request.getParameter("frombrowserid"));//�����ֶ�id
				boolean ismainfield = true;//�����ֶ�
				String detailrow = "";//��������ֶΣ������к�
				String fromfieldid = "";//�ֶ�id
				String strs[] = frombrowserid.split("_");
				if(strs.length==2){
					fromfieldid = strs[0];
					detailrow = strs[1];
					ismainfield = false;
				}else{
					fromfieldid = strs[0];
				}
				String type=Util.null2String(request.getParameter("sapbrowserid"));//�������̰�ť��ʶ 
				NewSapBrowserComInfo NewSapBrowserComInfo=new NewSapBrowserComInfo();
				NewSapBaseBrowser nb=NewSapBrowserComInfo.getSapBaseBrowser(type);
				List inParameter=nb.getSap_inParameter();//��ȡ�������
				List listoafieldin=new ArrayList();//��װoa��������ֶ�(�й̶�ֵ��)
				List listoafieldno=new ArrayList();//��װoa��������ֶ�(���е�)
				List intstrufield=nb.getSap_inStructure(); //��ȡ����ṹ
				//System.out.println("�����ť��ʶ"+type);
				//System.out.println("��������ĳ���"+inParameter.size());
				//System.out.println("����ṹ�ĳ���"+intstrufield.size());
				
				IntegratedSapUtil insaputil=new IntegratedSapUtil();
				out.println(" <form action='/integration/sapSingleBrowserDetial.jsp' method='post' name='weaverfield' id='weaverfield'>");
				if(inParameter.size()>0)//˵�����������
				{
					for(int i=0;i<inParameter.size();i++)//ѭ������
					{
						Sap_inParameterBean sap_inParameterBean=(Sap_inParameterBean)inParameter.get(i);
						String Constant=sap_inParameterBean.getConstant();//��������Ĺ̶�ֵ
						String Oafield=sap_inParameterBean.getOafield();//���������Դ��OA�ֶε�ֵ
						String sapfield=sap_inParameterBean.getSapfield();//���������sap�ֶ�
						String oafieldid=sap_inParameterBean.getFromfieldid();//OA�ֶε�id
						String ismainfieldmy=sap_inParameterBean.getIsmainfield();//�Ƿ������ֶ�
						if("".equals(Constant)&&!"".equals(oafieldid))//���û�й̶�ֵ����ô���ֵ����Դ�����̱�������ֶ�,�������oa�ֶδ���
						{
							if("1".equals(ismainfieldmy))//����
							{
								listoafieldin.add("field"+oafieldid);
							}else//��ϸ���ֶ�
							{
								listoafieldin.add("field"+oafieldid+"_"+detailrow);
							}
						}
						if(!"".equals(oafieldid))
						{
							if("1".equals(ismainfieldmy))//����
							{
								listoafieldno.add("field"+oafieldid+"@<>@"+Constant);
							}else//��ϸ���ֶ�
							{
								listoafieldno.add("field"+oafieldid+"_"+detailrow+"@<>@"+Constant);
							}
						}
					}
				}
				
				if(intstrufield.size()>0)//˵��������ṹ
				{
					
					for(int i=0;i<intstrufield.size();i++)//ѭ������
					{
						Sap_inStructureBean sap_inStructureBean=(Sap_inStructureBean)intstrufield.get(i);
						String Constant=sap_inStructureBean.getConstant();//��������Ĺ̶�ֵ
						//System.out.println("����̶�ֵ"+Constant);
						String Oafield=sap_inStructureBean.getOafield();//���������Դ��OA�ֶε�ֵ
						String sapfield=sap_inStructureBean.getSapfield();//���������sap�ֶ�
						String oafieldid=sap_inStructureBean.getFromfieldid();//OA�ֶε�id
						String ismainfieldmy=sap_inStructureBean.getIsmainfield();//�Ƿ������ֶ�
						if("".equals(Constant)&&!"".equals(oafieldid))//���û�й̶�ֵ����ô���ֵ����Դ�����̱�������ֶ�,�������oa�ֶδ���
						{
							if("1".equals(ismainfieldmy))//����
							{
								listoafieldin.add("field"+oafieldid);
							}else//��ϸ���ֶ�
							{
								listoafieldin.add("field"+oafieldid+"_"+detailrow);
							}
						}
						
						if(!"".equals(oafieldid))
						{
							if("1".equals(ismainfieldmy))//����
							{
								
								listoafieldno.add("field"+oafieldid+"@<>@"+Constant);
							}else//��ϸ���ֶ�
							{
								listoafieldno.add("field"+oafieldid+"_"+detailrow+"@<>@"+Constant);
							}
						}
					}
				}
				listoafieldno=insaputil.removeDuplicateWithOrder(listoafieldno);//ȥ���ظ����ֶ�
				for(int i=0;i<listoafieldno.size();i++)
				{
					String templist[]=(listoafieldno.get(i)+"").split("@<>@");
					if(templist.length>1)
					{
						out.println("<input type='hidden' name='"+templist[0]+"' id='"+templist[0]+"' value='"+templist[1]+"'>");					
					}else
					{
						out.println("<input type='hidden' name='"+templist[0]+"' id='"+templist[0]+"' value=''>");
					}
				}
				out.println("<input type='hidden' name='type' id='type' value='"+type+"'>");
				out.println("<input type='hidden' name='detailrow' id='detailrow' value='"+detailrow+"'>");
				out.println("<input type='hidden' name='fromfieldid' id='fromfieldid' value='"+fromfieldid+"'>");
				out.println(" </form>");
			 %>
	</body>
</html>
<script type="text/javascript">
<!--
	$(document).ready(function() {  
		<%
			for(int j=0;j<listoafieldin.size();j++)
			{
		%>
		
			 try{
			 	if($.browser.msie) { 
						//�õ��������Ҫ���ֶ�ֵ
						var obj = window.dialogArguments.document.getElementById("<%=listoafieldin.get(j)%>");
						if(obj.tagName=="SELECT"){
								//������
								document.getElementById("<%=listoafieldin.get(j)%>").value=obj[obj.selectedIndex].text;
								//alert(obj[obj.selectedIndex].text);
						}else{
								document.getElementById("<%=listoafieldin.get(j)%>").value=obj.value;
						}
					}else{
					
						var obj = window.parent.dialogArguments.document.getElementById("<%=listoafieldin.get(j)%>");
						if(obj.tagName=="SELECT"){
								//������
								document.getElementById("<%=listoafieldin.get(j)%>").value=obj[obj.selectedIndex].text;
								//alert(obj[obj.selectedIndex].text);
						}else{
								document.getElementById("<%=listoafieldin.get(j)%>").value=obj.value;
						}
					}
				}catch(e){
				}
		<%	
			}
		
		%>
		document.getElementById("weaverfield").submit();
	});
//-->
</script>
