<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="com.weaver.integration.params.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<link href="/css/Weaver.css" type=text/css rel=stylesheet>
<link href="/integration/css/intepublic.css" type=text/css rel=stylesheet>
<link href="/integration/css/loading.css" type=text/css rel=stylesheet>
<jsp:useBean id="SapUtil" class="com.weaver.integration.util.IntegratedUtil" scope="page"/>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<%
			
			String browsertype=Util.null2String(request.getParameter("browsertype"));//���=226��ʾ�Ǽ��ɿ�����ѡ��=227��ʾ�Ǽ��ɿ�����ѡ
			if("227".equals(browsertype))
			{
				out.println(SystemEnv.getHtmlLabelName(30653 ,user.getLanguage()));
				return;
			}
			
			String title="ϵͳ���ɵ�ѡ�����ť����";
			String formid=Util.null2String(request.getParameter("formid"));//�õ����̱���formid
			String mark=Util.null2String(request.getParameter("mark")).trim();//�����ť��ʶ��id
			String dataauth=Util.null2String(request.getParameter("dataauth"));//�õ��Ƿ�����������Ȩ����
			String updateTableName=Util.null2String(request.getParameter("updateTableName"));//�õ���������Ա��name,�����жϵ�ǰ���õ������ť���������ű���
			String w_type=Util.null2String(Util.getIntValue(request.getParameter("w_type"),0)+"");//0-��ʾ�������ť��������Ϣ��1-��ʾ�ǽڵ��������ʱ����Ϣ
			String srcType=Util.null2String(request.getParameter("srcType"));//���������Դ���ֶι���--�½��ֶ� (detailfield=��ϸ�ֶ�,mainfield=���ֶ�)
			String iframsr="/integration/browse/integrationSapDirections.jsp?w_type="+w_type;
			//String nodename = "";		
			//String workFlowName = "";
			int isbill = 0;//�ϱ������±�,0��ʾ�ϱ�1,��ʾ�±�
			//�ڵ�id
			int nodeid = Util.getIntValue(Util.null2String(request.getParameter("nodeid")),0);
			//�Ƿ�ڵ�󸽼Ӳ���
			int ispreoperator = Util.getIntValue(request.getParameter("ispreoperator"), 0);
			//����id
			int nodelinkid = Util.getIntValue(request.getParameter("nodelinkid"), 0);
			//��������id
			int workflowid = Util.getIntValue(Util.null2String(request.getParameter("workflowid")),0);
			if("1".equals(w_type))
			{
				 title="�ڵ㶯��action����";
				//if(nodeid>0){
					//RecordSet.executeSql("select nodename from workflow_nodebase b where b.id = "+nodeid);
					//if(RecordSet.next()){
						//nodename = RecordSet.getString("nodename");
					//}
				//}
				if(workflowid>-1){
					//workFlowName = Util.null2String(WorkflowComInfo.getWorkflowname("" + workflowid));
					isbill = Util.getIntValue(WorkflowComInfo.getIsBill("" + workflowid), 0);
					formid = Util.getIntValue(WorkflowComInfo.getFormId("" + workflowid), 0)+"";
				}
			}
			
			String opera="save";
			if(!"".equals(mark)){opera="update";}
			String hpid="";
			String poolid="";
			String baseid="";//�����ť��id
			String w_enable="";//�Ƿ�����
			String regservice="";//��������
			String brodesc="";
			String authcontorl="";
			String sid="";
			String servicesid="";
			//boolean flag = false;
			String regname="";
			String w_actionorder="";
			//���������ť�ı�ʶ����������ť�Ļ�����Ϣ
			if("update".equals(opera))
			{
			
				String sql="select a.*,b.sid from int_BrowserbaseInfo a left join  int_heteProducts b on a.hpid=b.id where mark='"+mark+"'";
				if(RecordSet.execute(sql)&&RecordSet.next())
				{
					 baseid=RecordSet.getString("id");
					 hpid=RecordSet.getString("hpid");
					 poolid=RecordSet.getString("poolid");
					 w_actionorder=RecordSet.getString("w_actionorder");
					 sid=RecordSet.getString("sid");
					 regservice=RecordSet.getString("regservice");//��������
					 brodesc=RecordSet.getString("brodesc");
					 authcontorl=RecordSet.getString("authcontorl");
					 w_enable=RecordSet.getString("w_enable");
					 servicesid=sid+"_"+hpid+"_"+poolid+"_"+regservice;
					 if("1".equals(sid))//1--�м��,��Ӧ������ԴΪdml����Դ��(���ǹ涨)
					 {
					 	rs.execute("select * from dml_service where id="+regservice);
					 	if(rs.next())
					 	{
					 		regname=rs.getString("regname");
					 	}
					 }else if("2".equals(sid))//2--webservice,��Ӧ������ԴΪwebservice��Դ��(���ǹ涨)
					 {
					 	rs.execute("select * from ws_service where id="+regservice);
					 	if(rs.next())
					 	{
					 		regname=rs.getString("regname");
					 	}
					 }else if("3".equals(sid))//3---rfc,��Ӧ������ԴΪsap����Դ��(���ǹ涨)
					 {
					 	rs.execute("select * from sap_service where id="+regservice);
					 	if(rs.next())
					 	{
					 		regname=rs.getString("regname");
					 	}
					 }
				}
				// flag = ServiceParamsUtil.isExitsLocalParams(regservice);
				 iframsr="/integration/browse/integrationBrowerSet.jsp?opera="+opera+"&baseid="+baseid+"&formid="+formid+"&updateTableName="+updateTableName+"&dataauth="+dataauth+"&mark="+mark+"&regservice="+regservice+"&w_type="+w_type+"&isbill="+isbill+"&nodeid="+nodeid+"&workflowid="+workflowid+"&srcType="+srcType;
			}
		%>
<html>
	<head>
		<title><%=title%>-<%=mark%></title>
		<style type="text/css">
			.selectItemCss {
				width:250px;
				margin-right: 0px;
			}
		</style>
	</head>
	<body>

	
		
		<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(86 ,user.getLanguage())+",javascript:doSubmit(this,1),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		//RCMenu += "{���沢��Ϊģ��,javascript:doSubmit(this,2),_self} " ;
		//RCMenuHeight += RCMenuHeightStep ;
		if(!"1".equals(w_type))
		{
			RCMenu += "{"+SystemEnv.getHtmlLabelName(30656 ,user.getLanguage())+",javascript:doSubmit(this,2),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		RCMenu += "{"+SystemEnv.getHtmlLabelName(201 ,user.getLanguage())+",javascript:doGoBack(this),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu.jsp" %>
		
		
		
		<div style="width: 100%;padding: 10px;">
		<!-- Shadow���-start -->
		<TABLE class="Shadow">
			<tr>
				<td valign="top">
					<!--ListStyle ���start  -->
				    <TABLE class=ListStyle cellspacing=1 style="table-layout: fixed;">
						<COLGROUP>
							<COL width="120px"/>
							<COL width="300px"/>
							<COL width="*"/>
						</COLGROUP>
						<TR class=Header >
							<TH colspan="3"><%=title%>-<%=mark%></TH>
						</TR>
						<TR class=Line style="height:1px">
							<TD colSpan=3 style="padding:0px"></TD>
						</TR>
						<input type="hidden" id="mark" name="mark" value="<%=mark%>">
						<TR class=DataLight>	
							<TD><%=SystemEnv.getHtmlLabelName(30657 ,user.getLanguage()) %></TD>
							<TD colSpan=2>
								<button type='button' class='browser' onclick=onchangeservice(this)></button> 
								<input type=hidden name="servicesid" id="servicesid" value="<%=servicesid%>">
								<span><%=regname%></span>
								<span id=regservicesapn>
									<%if(!"update".equals(opera)){out.println("<img src='/images/BacoError.gif' align=absMiddle>");}%>
								</span>
							</TD>
						</TR>
						<TR class=DataDark>	
							<TD><%=SystemEnv.getHtmlLabelName(30658 ,user.getLanguage()) %></TD>
							<TD colSpan=2>
								<textarea rows="5" cols="80" id="brodesc" tabindex="1" onpropertychange="checkLength(this,100);" oninput="checkLength(this,100);"><%=brodesc%></textarea>
							</TD>
						</TR>
						<%
							if("0".equals(w_type))
							{
						 %>
						<TR class=DataLight>	
							<TD><%=SystemEnv.getHtmlLabelName(30659 ,user.getLanguage()) %></TD>
							<TD colSpan=2>
								<input type="checkbox" name="authcontorl"  id="authcontorl" value="1" <%if("1".equals(authcontorl)){out.println("checked=checked");} %>>
							</TD>
						</TR>
						<%
							}
						 %>
						<%
						
							if("1".equals(w_type))
							{
								
								
						 %>
						<TR class=DataLight>	
							<TD><%=SystemEnv.getHtmlLabelName(18624 ,user.getLanguage()) %></TD>
							<TD colSpan=2>
								<input type="checkbox" name="w_enable" id="w_enable" value="1" <%if("1".equals(w_enable)){out.println("checked='checked'");}%>>
							</TD>
						</TR>
						
						<TR class=DataDark>	
							<TD>ִ��˳��</TD>
							<TD colSpan=2>
								<input type="text"  maxlength="3" name="w_actionorder" id="w_actionorder" value="<%=w_actionorder%>"> 
								(����ԽС��ִ������)
							</TD>
						</TR>
						
						<%
							}	
						%>
							
					</TABLE>
					<!--ListStyle ���end  -->
				</td>
			</tr>
		</TABLE>
		<!-- Shadow���-end -->
		<iframe src="<%=iframsr%>" style="width: 100%;height: 400px;" frameborder="0" scrolling="no" id="maindiv">
		</iframe>
		</div>
		
	
	<DIV class=huotu_dialog_overlay id="hidediv">
			
	</DIV>
	<div  id="hidedivmsg" class="bd_dialog_main">
						
	</div>
		
		<script type="text/javascript">
		
			var updateChangeService="0";//1��ʾ�½���ʱ��changeע�����2��ʾ�޸ĵ�ʱ��changeע�����,"0"��ʾû�ý���change����,"3"��ʾ�޸ĵ�ʱ��change�������˳�ʼ״̬��ʱ��
			//�ж�iframe�Ƿ�������
			function iframeLoaded(iframeEl, callback) {
		     	if(iframeEl.attachEvent) {
		            iframeEl.attachEvent("onload", function() {
		                if(callback && typeof(callback) == "function") {
		                    callback();
		                }
		            });
		        } else {
		            iframeEl.onload = function() {
		                if(callback && typeof(callback) == "function") {
		                    callback();
		                }
		            }
		        }
		   }
		   //iframe������ɺ�ص��ĺ���
			function closeDIV()
			{
				document.getElementById("hidediv").style.display="none";
				document.getElementById("hidedivmsg").style.display="none";
			}
			
			function onchangeservice(obj)
			{
				<%
					if("save".equals(opera))
					{
				%>
						updateChangeService="1";
				<%
					}else if("update".equals(opera))
					{
				%>
						updateChangeService="2";
				<%
					}
				%>
					
				var selectedids=$("#servicesid").val();
				var sid = window.showModalDialog("/integration/browse/IntegrationServiceBrower.jsp?selectedids="+selectedids, "", "dialogWidth:550px;dialogHeight:550px;");
				if(sid)
				{
					$("#servicesid").attr("value",sid.id);
					$("#servicesid").next().html(sid.name);
					if(sid.id!="")
					{
						var regservice = $("#servicesid").val().split("_")[3];//�����id
						$("#servicesid").next().next().html("");
						var temp=document.body.clientWidth;
						$("#hidediv").css("height",temp);
						var h2=$("#hidedivmsg").css("height");
						var w2=$("#hidedivmsg").css("width");
						var a=(document.body.clientWidth)/2-140; 
						var b=(document.body.clientHeight)/2-40;
						$("#hidedivmsg").css("left",a);
						$("#hidedivmsg").css("top",b);
						$("#hidediv").show();
						$("#hidedivmsg").html("<%=SystemEnv.getHtmlLabelName(30661 ,user.getLanguage()) %>"+"...").show();
						
						<%
							if("update".equals(opera))
							{
						%>
								if("<%=regservice%>"==regservice)
								{
									updateChangeService="3";
								}
						<%
							}
						%>
				
						var args0="?opera=<%=opera%>";
							args0+="&baseid=<%=baseid%>";
							args0+="&formid=<%=formid%>";
							args0+="&updateTableName=<%=updateTableName%>";
							args0+="&dataauth=<%=dataauth%>";
							args0+="&mark=<%=mark%>";
							args0+="&regservice="+regservice+"";
							args0+="&w_type=<%=w_type%>";
							args0+="&isbill=<%=isbill%>";
							args0+="&nodeid=<%=nodeid%>";
							args0+="&workflowid=<%=workflowid%>";
							args0+="&updateChangeService="+updateChangeService+"";
							args0+="&srcType=<%=srcType%>";
							
							
						document.getElementById("maindiv").src="/integration/browse/integrationBrowerSet.jsp"+args0;
						iframeLoaded(document.getElementById("maindiv"),closeDIV);//�ص�
					}else
					{
						$("#servicesid").next().next().html("<img src='/images/BacoError.gif' align=absMiddle>");
						document.getElementById("maindiv").src="/integration/browse/integrationSapDirections.jsp?w_type=<%=w_type%>";
						
					}
				}
			}
			//�����ύ
			function doSubmit(obj,dataauth)
			{
				
				//��֤���ҳ������ݱ�����
				var temp=0;
				$(" span img").each(function (){
					if($(this).attr("align")=='absMiddle')
					{
						if($(this).css("display")=='inline')
						{
							temp++;
						}
					}
				});
				if(temp!=0)
				{
					alert("<%=SystemEnv.getHtmlLabelName(30622 ,user.getLanguage()) %>"+"!");
					return;
				}
				try
				{
					window.frames["maindiv"].document.getElementById("mark").value;
				}catch(e)
				{
					//���������ʾ�����ҳ����󲻴���
					alert("<%=SystemEnv.getHtmlLabelName(30663 ,user.getLanguage()) %>"+"!");
					return;
				}
				
				//��֤�ڲ�ҳ������ݱ�����
				if(window.frames["maindiv"].checkRequired())
				{
					
					window.frames["maindiv"].document.getElementById("mark").value=$("#mark").val();
					window.frames["maindiv"].document.getElementById("hpid").value=$("#servicesid").val().split("_")[1];
					window.frames["maindiv"].document.getElementById("poolid").value=$("#servicesid").val().split("_")[2];
					window.frames["maindiv"].document.getElementById("regservice").value=$("#servicesid").val().split("_")[3];
					window.frames["maindiv"].document.getElementById("brodesc").value=$("#brodesc").val();
					window.frames["maindiv"].document.getElementById("w_actionorder").value=$("#w_actionorder").val();
					
					
					if($("#authcontorl").is(":checked"))//jquery�жϸ�ѡ��ѡ��
					{
						window.frames["maindiv"].document.getElementById("authcontorl").value="1";
					}
					window.frames["maindiv"].document.getElementById("ispreoperator").value="<%=ispreoperator%>";
					window.frames["maindiv"].document.getElementById("nodelinkid").value="<%=nodelinkid%>";
					if($("#w_enable").is(":checked"))//jquery�жϸ�ѡ��ѡ��
					{
						window.frames["maindiv"].document.getElementById("w_enable").value="1";
					}
					//�ж��Ƿ���ʾ������Ȩ����
					window.frames["maindiv"].document.getElementById("dataauth").value=dataauth;
					var temp=document.body.clientWidth;
					$("#hidediv").css("height",temp);
					var h2=$("#hidedivmsg").css("height");
					var w2=$("#hidedivmsg").css("width");
					var a=(document.body.clientWidth)/2-140; 
					var b=(document.body.clientHeight)/2-40;
					$("#hidedivmsg").css("left",a);
					$("#hidedivmsg").css("top",b);
					$("#hidediv").show();
					$("#hidedivmsg").html("<%=SystemEnv.getHtmlLabelName(20240 ,user.getLanguage()) %>").show();
					window.frames["maindiv"].document.getElementById("weaver").submit();
				}
			}
			 $(window).unload(function () {
			 	 if($("#mark").val()!="")
			 	 {	
			 	 	window.returnValue=$("#mark").val();
			 	 }	
			 });
			 function changeurl(utlstr)
			 {
			 	//�ο�http://www.jb51.net/article/21139.htm
			 	window.name = "__self"; 
				window.open(utlstr, "__self"); 
				
			 }
			 
			 function doGoBack() {
				 window.close();
			 }
			 //�����ı���ĳ���
			function checkLength(obj,maxlength){
			    if(obj.value.length > maxlength){
			        obj.value = obj.value.substring(0,maxlength);
			    }
			}
		</script>
	</body>
</html>

