<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="com.weaver.integration.entity.NewSapBrowserComInfo"%>
<%@page import="com.weaver.integration.entity.NewSapBrowser"%>
<%@page import="com.weaver.integration.entity.NewSapBaseBrowser"%>
<%@page import="com.weaver.integration.entity.Sap_outParameterBean"%>
<%@page import="com.weaver.integration.entity.Sap_outTableBean"%>
<%@page import="com.weaver.integration.entity.Sap_inParameterBean"%>
<%@page import="com.weaver.integration.datesource.SAPInterationOutUtil"%>
<%@page import="com.weaver.integration.log.LogInfo"%>
<%@page import="com.weaver.integration.params.BrowserReturnParamsBean"%>
<%@page import="com.weaver.integration.entity.Sap_complexnameBean"%> 
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
<script language="javascript" src="/js/weaver.js"></script>
<html>
	<base target="_self">
	<body>
	
			<% 
				
				String imagefilename = "/images/hdSystem.gif";
				String titlename = SystemEnv.getHtmlLabelName(30638 ,user.getLanguage());
				String needfav ="1";
				String needhelp ="";
				String mark=Util.null2String(request.getParameter("mark"));//�������̰�ť��ʶ 
				String rightid=Util.null2String(request.getParameter("rightid"));//int_authorizeRight���id
				//���Ĭ��ѡ�е�ֵ
				String operate=Util.null2String(request.getParameter("operate"));
				if("".equals(operate)){operate="search";}
				String isinclude=Util.getIntValue(request.getParameter("isinclude"),0)+"";
				String sql="";
				String ids=Util.null2String(request.getParameter("ids")).trim();
				int rows=50;//ÿҳ��ʾ������
				int rownum=1;//�к�
				int countdata=0;//�õ�������
				int curpage=Util.getIntValue(request.getParameter("curpage"),1);//��ǰҳ
				NewSapBrowserComInfo newSapBrowserComInfo=new NewSapBrowserComInfo();
				NewSapBaseBrowser nb=newSapBrowserComInfo.getSapBaseBrowser(mark);
				List outParameter=nb.getSap_outParameter();//��ȡ�������
				List outTable=nb.getSap_outTable();//��ȡ�����
				List outStructure=nb.getSap_outStructure();//��ȡ����ṹ
				List inParameter=nb.getSap_inParameter();//��ȡ�������
				List inStructure=nb.getSap_inStructure();//��ȡ����ṹ
				StringBuffer intablefield=new StringBuffer(); //��¼����������ֶ�
				StringBuffer intstrufield=new StringBuffer(); //��¼����ṹ���ֶ�
				StringBuffer outtablesb=new StringBuffer(); //��¼�����������ֶ�
				StringBuffer outtablestr=new StringBuffer();//��¼��������ʾ�ֶ�
				StringBuffer outtablelist=new StringBuffer();//��װ��ҳ���table
				List listoafield=new ArrayList();//��װ��ֵ�ֶ�
				List seachfield=new ArrayList();//��װ��ѯ�ֶ�
				List listsapfield=new ArrayList();//��װ������sap��ʾ���ֶ���
				List listsapfielddisplay=new ArrayList();//��װ������sap�������ֶ���
				List listparamy=new ArrayList();//��װ�����ֶ�
				Map tableMap=new HashMap();
				List listvalue=new ArrayList();
				int display=0;//�õ��е�����	
				
				
				if("save".equals(operate))
				{
					//�������
					String check_per[]=ids.split(",");
					if(null!=check_per)
					{
						rs.execute("delete int_authorizeDetaRight where rightid='"+rightid+"'");
						for(int jbk=0;jbk<check_per.length;jbk++){
							String valuerwo=check_per[jbk];
							if(!"".equals(valuerwo))
							{
								sql="insert into int_authorizeDetaRight (rightid,isinclude,value) values ('"+rightid+"','"+isinclude+"','"+valuerwo+"')";
								rs.execute(sql);
							}
						}
						NewSapBrowserComInfo newsapcominfo= new NewSapBrowserComInfo();
						newsapcominfo.removeSapBrowserComInfo();//������
					}
				}	
				
				sql="select * from int_authorizeDetaRight where rightid='"+rightid+"'";
				rs.execute(sql);
				while(rs.next())
				{
					ids=ids.replace((","+rs.getString("value")),"");//��ȥ���ظ���ֵ
					ids+=","+rs.getString("value");
				}
							
				//˵��������ֶ�
				if(outTable.size()>0){
							//ѭ�����������������ֶ�--start
							for(int i=0;i<outTable.size();i++){
										Sap_outTableBean s=(Sap_outTableBean)outTable.get(i);
										//�ж��Ƿ��в�ѯ�ֶ�
										if((s.getSearch()).equals("1")){
												//outtablesb.append("<TR class='Spacing'  style='height:1px;'>");
												outtablesb.append("@@<td class=field>"+s.getShowname()+"</td>");
												outtablesb.append("@@<td><input type='text' name='"+s.getName()+"."+s.getSapfield()+"' value='"+Util.null2String(request.getParameter(s.getName()+"."+s.getSapfield()))+"'></td>");
												//outtablesb.append("</TR>");
												seachfield.add(s.getName()+"."+s.getSapfield());
										}
										//��һ����ʾ��ѡ��
										if(display==0){
												outtablestr.append("<th>");
												outtablestr.append("<input type='checkbox' name='check_perALL' onclick=selectall(this) value=1 >ȫѡ");
												outtablestr.append("</th>");
												outtablestr.append("<th>���");
												outtablestr.append("</th>");
										}
										//�ж��Ƿ�����ʾ�ֶΣ���ʾ��
										if((s.getDisplay()).equals("1")){
											outtablestr.append("<th>");
												outtablestr.append(s.getShowname());
											outtablestr.append("</th>");
											display++;
											listsapfield.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
										}else {
											 //������
											outtablestr.append("<th style='display:none'>");
												outtablestr.append(s.getShowname());
											outtablestr.append("</th>");
											display++;
											listsapfielddisplay.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
										}
										//�ж��Ƿ��и�ֵ�ֶ�
										if(!"".equals(s.getFromfieldid())){
											listoafield.add(s.getFromfieldid()+"-"+s.getOafield()+"-"+s.getIsmainfield());
										}
										//�ж��Ƿ�Ϊ����
										if("1".equals(s.getPrimarykey())){
											listparamy.add(s.getName()+"."+s.getSapfield());//����.�ֶ���
										}
							}
						//ѭ�����������������ֶ�--end
						if(!"".equals(outtablesb.toString().trim())){	
								String pj="";
								String strtj[]=outtablesb.toString().split("@@");
								for(int i=0;i<strtj.length;i++){
									if(i%4==0&&i!=0){
											pj+="<TR class='Spacing'  style='height:1px;'>";
											pj+=strtj[i-3];
											pj+=strtj[i-2];
											pj+=strtj[i-1];
											pj+=strtj[i];
											pj+="</TR>";
									}else if((strtj.length-1)==i){
											pj+="<TR class='Spacing'  style='height:1px;'>";
											pj+=strtj[i-1];
											pj+=strtj[i];
											pj+="</TR>";
									}
								}
								System.out.println("pj="+pj);
								//˵������������
								outtablesb=new StringBuffer("<table width=100% class='viewform' id='seachtable'><colgroup><col width='25%'><col width='25%'><col width='25%'><col width='25%'></colgroup>"+pj);
								outtablesb.append("</table>");
						}
						SAPInterationOutUtil saputil=new SAPInterationOutUtil();
						//������������������ṹ��Ϊ��
						//��Ϊ���ﲻ����ȥ��Ӧ�ı���ȥץֵ
						HashMap hashmap=new HashMap();
						//ִ�к���
						BrowserReturnParamsBean returnpar=saputil.executeABAPFunction(hashmap,mark,new LogInfo());
						if(null!=returnpar){
								List listouttable=nb.getSap_complexnameBeanByMark(mark, "2");
								if(null!=listouttable&&listouttable.size()>0){
									//˵���������,ֻ���һ�ű��û�����Ȩ��--start
									for(int c=0;c<1;c++){
													Sap_complexnameBean sap_complexnameBean02=(Sap_complexnameBean)listouttable.get(c);
													tableMap=returnpar.getTableMap();
													listvalue=(List)tableMap.get(sap_complexnameBean02.getName());//�õ��ñ���������е�abap����
													for(int i=0;i<listvalue.size();i++){
																boolean flag=false;
																Map hashmap02=(HashMap)listvalue.get(i);//��ʾһ������
																//��������--start
																for(int jk=0;jk<seachfield.size();jk++){
																	String seaflied=Util.null2String(request.getParameter(seachfield.get(jk)+"")).trim().toUpperCase();
																	//System.out.println("��������"+seaflied);
																	//System.out.println("����"+hashmap02.get(seachfield.get(jk)+""));
																	if((hashmap02.get(seachfield.get(jk)+"")+"").indexOf(seaflied)==-1){
																		flag=true;//��ʾ�������ݲ���������
																		break;
																	}
																}
																if(flag){
																	//�����ж���һ�����ݣ��Ƿ��������
																
																	continue;
																	
																}else{
																	
																	//˵���п���ʾ���ֶ�
																	if(listsapfield.size()>0){
																			
																			
																				if(countdata<(rows*curpage)&&countdata>=rows*(curpage-1)){
																					//�������ڵ�ǰҳ��ʾ������
																					String prarmlie="";
																					if(countdata%2==0){
																						outtablelist.append("<tr class='DataDark'>");
																					}else{
																						outtablelist.append("<tr class='DataLight'>");
																					}
																					//ѭ��������
																					for(int bj=0;bj<listparamy.size();bj++){
																						//�����п����кܶ࣬��������
																						prarmlie+=hashmap02.get(listparamy.get(bj))+"$_$";
																					}
																					outtablelist.append("<td>");
																					//prarmlie=002$_$
																					//ids=,GG-CDE-002$_$
																					System.out.println("prarmlie="+prarmlie);
																					System.out.println("ids="+ids);
																					
																					//ѭ��ѡ�е���
																					boolean  checkb=false;
																					String chenckedin[]=ids.split(",");
																					for(int ck=0;ck<chenckedin.length;ck++){
																							if(!"".equals(ids)&&prarmlie.equals(chenckedin[ck])&&!"$_$".equals(prarmlie)){
																								checkb=true;
																							}
																					}
																					if(checkb){
																							outtablelist.append("<input type='checkbox' name='check_per' value='"+prarmlie+"' checked> ");
																					}else{
																							outtablelist.append("<input type='checkbox' name='check_per' value='"+prarmlie+"'> ");
																					}
																				
																					outtablelist.append("</td>");
																					outtablelist.append("<td>"+(countdata+1));
																					outtablelist.append("</td>");
																					for(int jk=0;jk<listsapfield.size();jk++){
															         						outtablelist.append("<td>"+hashmap02.get(listsapfield.get(jk))+"</td>");
															         				}
															         				for(int jk=0;jk<listsapfielddisplay.size();jk++){
															         					//���������
															         						outtablelist.append("<td style='display:none'>"+hashmap02.get(listsapfielddisplay.get(jk))+"<input name='"+listsapfielddisplay.get(jk)+"' type='hidden' value='"+hashmap02.get(listsapfielddisplay.get(jk))+"'></td>");
															         				}
															         				outtablelist.append("</tr>");
															         				countdata++;
																					continue;
																				}else{
																					//���ݲ����ڵ�ǰҳ��ʾ������
																					countdata++;
																					continue;
																				}
																		
																	}
																
																}
																//��������--end
															
													}
									}
									//˵���������,ֻ���һ�ű��û�����Ȩ��--end
								}
						}
				}
				
			 %>
			 
			 
			<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
			<%
			RCMenu += "{"+SystemEnv.getHtmlLabelName(197 ,user.getLanguage())+",javascript:btnseach(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			RCMenu += "{"+SystemEnv.getHtmlLabelName(826 ,user.getLanguage())+",javascript:btnok_onclick(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:btnCancel(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			//System.out.println("������"+listvalue.size());
			if(curpage>1)
			{
				//����һҳ
				RCMenu += "{"+SystemEnv.getHtmlLabelName(1258 ,user.getLanguage())+",javascript:nextpage(2),_self} " ;
				RCMenuHeight += RCMenuHeightStep ;
			}
			
			if(countdata>(curpage*rows))
			{
				//����һҳ
				RCMenu += "{"+SystemEnv.getHtmlLabelName(1259 ,user.getLanguage())+",javascript:nextpage(1),_self} " ;
				RCMenuHeight += RCMenuHeightStep ;
			}
		
			
			RCMenu += "{"+SystemEnv.getHtmlLabelName(15504,user.getLanguage())+",javascript:submitClear(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
			
			
			
			
			%>
			<%@ include file="/systeminfo/TopTitle.jsp" %>
			<%@ include file="/systeminfo/RightClickMenu.jsp" %>
			
			<form action="/integration/browse/integrationSAPDataAuthSetting.jsp" name="weaver" method="post">
			<input type="hidden" name="operate" id="operate" value="<%=operate%>">
			<input type=hidden  name="mark"  id="mark" value="<%=mark%>">
			<input type="hidden" name="rightid" id="rightid" value="<%=rightid%>">
			<input type="hidden" name="curpage"  id="curpage" value="<%=curpage%>">
			
		
			<input type="hidden" name="ids"  id="ids" value="<%=ids%>">
			<!--  
			<textarea rows="5" cols="50" name="ids" id="ids"><=ids%></textarea>
			-->
			<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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
							<%=outtablesb%>
							<br>
							˵������SAP�������е�ֵΪ��ʱ,ѡ����ΪȨ�޿���ֵ,��Ϊ��Ч��
							<table class=viewform>
							<colgroup>
									<col width="100px">
									<col width="*">
							</colgroup>
							<TR class='Spacing'  style='height:1px;'><TD class='Line1' colspan=2></TD></TR>
							<tr>
								<td>
								
									 <%=SystemEnv.getHtmlLabelName(28224 ,user.getLanguage()) %>
									  <input type="checkbox"   checked="checked" disabled="disabled"><%=SystemEnv.getHtmlLabelName(346 ,user.getLanguage()) %>
									   <input type="hidden" name="isinclude" value="1">
								</td>
								<td class=field style="text-align: right;">
									<%=SystemEnv.getHtmlLabelName(30640 ,user.getLanguage()) %><%=curpage%><%=SystemEnv.getHtmlLabelName(30642 ,user.getLanguage()) %>&nbsp;&nbsp;
									<%=SystemEnv.getHtmlLabelName(18609 ,user.getLanguage()) %>
									<%=countdata%>
									<%=SystemEnv.getHtmlLabelName(24683 ,user.getLanguage()) %>&nbsp;&nbsp;
									<%=SystemEnv.getHtmlLabelName(30643 ,user.getLanguage()) %><%=rows%><%=SystemEnv.getHtmlLabelName(24683 ,user.getLanguage()) %>&nbsp;&nbsp;
								</td>
							</tr>
							<TR class='Spacing'  style='height:1px;'><TD class='Line1' colspan=2></TD></TR>
							</table>	
							<table  ID=BrowseTable class=BroswerStyle cellspacing="1">
								<tr class="DataHeader">
									<%=outtablestr%>
								</tr>
									<%=outtablelist %>
							</table>
							<%
							
									if("".equals(outtablesb.toString().trim())&&"".equals(outtablestr.toString().trim())&&"".equals(outtablelist.toString().trim()))
									{
										out.println(SystemEnv.getHtmlLabelName(30645 ,user.getLanguage()));
									}
							%>
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
		</form>
		
	</body>
</html>
<script type="text/javascript">

$(document).ready(function(){ 
	         $("input").keydown(function(e){ 
	             var curKey = e.which; 
	             if(curKey == 13){ 
	                 btnseach();
	                 return false; 
	             } 
	         }); 
}); 
var ids = "<%=ids%>";
//��ѡ
jQuery(document).ready(function(){
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(event){
		if($(this)[0].tagName=="TR"&&event.target.tagName!="INPUT"){
				var obj = jQuery(this).find("input[name=check_per]");
			   	if (obj.attr("checked") == true){
			   		obj.attr("checked", false);
			   		ids = ids.replace("," + jQuery(this).find("input[name=check_per]").val(), "")
			   	}else{
			   		obj.attr("checked", true);
			   		ids = ids + "," + jQuery(this).find("input[name=check_per]").val();
			   	}
		}
		//���checkbox��
	    if(event.target.tagName=="INPUT"){
	       var obj = jQuery(this).find("input[name=check_per]");
		   	if (obj.attr("checked") == true){
		   	    ids = ids + "," + jQuery(this).find("input[name=check_per]").val();
		   	}else{
		   		ids = ids.replace("," + jQuery(this).find("input[name=check_per]").val(), "")
		   	}
		   
	    }
	   
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
		$(this).addClass("Selected")
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
		$(this).removeClass("Selected")
	})
});
function btnseach()
{
	$("#operate").attr("value","search");
	$("#curpage").attr("value","1");
	weaver.submit();
	enableAllmenu();
}
function btnclear_onclick() {
     window.parent.returnValue = {id: "0",name: ""};
     window.parent.close();
}

function btnok_onclick() {
	//alert("����"+ids);
	$("#ids").attr("value",ids);
	$("#operate").attr("value","save");
	weaver.submit();
	enableAllmenu();
}
function btnCancel()
{
	window.close();
}
function submitClear()
{
	//���
	$("#seachtable").find("input").attr("value","");
	
}
function nextpage(type)
{
	if(type=="1")
	{
		//��һҳ
		var temp=parseInt($("#curpage").val())+1;
		$("#curpage").attr("value",temp);
		$("#ids").attr("value",ids);
		weaver.submit();
	}else
	{
		//��һҳ
		var temp=parseInt($("#curpage").val())-1;
		$("#curpage").attr("value",temp);
		$("#ids").attr("value",ids);
		weaver.submit();
	}
	enableAllmenu();
}
function selectall(obj){
	var check_nodes = jQuery("input[type='checkbox'][name='check_per']"); 
	if(obj.checked){
		var allsapcode = '';
		check_nodes.each(function(){
			this.checked = true;
			ids = ids.replace("," +this.value, "");
			ids +=","+this.value;//ȥ�ظ����һ�ȡֵ
		});
	}else{
		var allsapcode = '';
		check_nodes.each(function(){
			this.checked = false;
			ids = ids.replace("," +this.value, "");
		});
	}
}
</script>
