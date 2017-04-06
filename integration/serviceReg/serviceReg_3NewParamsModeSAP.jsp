<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
 <%@ include file="/systeminfo/init.jsp" %>
<%@page import="com.weaver.integration.datesource.SAPInterationOutUtil,com.weaver.integration.params.*"%>
<%@page import="com.weaver.integration.log.LogInfo"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionImportParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionExportParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionBaseParamBean"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionAllParams"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />

<HTML><HEAD><base target="_self">
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>

<%

		
		//Z_OSAP_MATERIAL_GETALL�������ֶεĺ���
		//BAPI_ROUTING_CREATE������ṹ,������ṹ,���������
		//BAPI_MATERIAL_SAVEDATA����ṹ���
		String servId = Util.null2String(request.getParameter("servId")).trim();
	    String poolid = Util.null2String(request.getParameter("poolid")).trim();
	    String type=Util.null2String(request.getParameter("type")).trim();
	    String paramName = Util.null2String(request.getParameter("paramName")).trim().toUpperCase();
	    String paramDesc = Util.null2String(request.getParameter("paramDesc")).trim().toUpperCase();
	    String disValue = Util.null2String(request.getParameter("disValue")).trim().toUpperCase();
	    String operation=Util.null2String(Util.getIntValue(request.getParameter("operation"),1)+"").trim(); //operation��������1��ʾ�������,2��ʾ������ӻ��޸� 
	    String stuortablevalue=Util.null2String(request.getParameter("stuortablevalue")).trim();//���type=3,��ʾ����ṹ������,type=6��ʾ����ṹ������,type=8��ʾ����������
		
	    String checkvalue=Util.null2String(request.getParameter("checkvalue")).toUpperCase();//ѡ�е�һ��ֵ
		
		String paramnametitle = "";
		String paramdesctitle = "";
		if("1".equals(type) || "3".equals(type) || "4".equals(type) || "6".equals(type) || "8".equals(type) || "11".equals(type)) {
			paramnametitle = SystemEnv.getHtmlLabelName(23481,user.getLanguage());//23481
			paramdesctitle = SystemEnv.getHtmlLabelName(30667,user.getLanguage());
		}
		if("2".equals(type) || "5".equals(type)) {
			paramnametitle = SystemEnv.getHtmlLabelName(30668,user.getLanguage());
			paramdesctitle = SystemEnv.getHtmlLabelName(30670,user.getLanguage());
		}
		if("10".equals(type) || "7".equals(type)) {
			paramnametitle = SystemEnv.getHtmlLabelName(30671,user.getLanguage());
			paramdesctitle = SystemEnv.getHtmlLabelName(30674,user.getLanguage());
		}
		if("".equals(operation)){operation="1";}
		
	
%>
<BODY>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSubmit(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:onReset(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;

//RCMenu += "{���,javascript:onClean(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearchParamsForm(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
if("1".equals(operation))
{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:btnok_onclick(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}else{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:onClean(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="*">
<col width="10">
</colgroup>
<tr>
	<td></td>
	<td height="35px">
	  <form action="" method="post" id="searchFormParams">
	  		<input type="hidden" name="servId" value="<%=servId%>">
	  		<input type="hidden" name="poolid" value="<%=poolid%>">
	  		<input type="hidden" name="type" value="<%=type%>">
	  		<input type="hidden" name="disValue" value="<%=disValue%>">
	  		<input type="hidden" name="operation" value="<%=operation%>">
	  		<input type="hidden" name="stuortablevalue" value="<%=stuortablevalue%>">
	  		
			<table width=100%  border="0"  cellpadding="0" class='ViewForm'  cellspacing='1'>
				<colgroup>
				<col width="50">
				<col width="220">
				<col width="50">
				<col width="*">
				</colgroup>
				<tr class=Spacing>
					<td class=field><%=paramnametitle %></td><td class=field><input type="text" name="paramName" value="<%=paramName %>" style="width:200px;"></td>
					<td class=field><%=paramdesctitle %></td><td class=field><input type="text" name="paramDesc" value="<%=paramDesc %>" style="width:200px;">
					<input id="searchFormParamsBtn" type="submit" style="visibility:hidden;width:1px;height:1px; ">
					</td>
				</tr>
			</table>
			
		</form>
	</td>	
	<td></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top" width="100%">


<!-- 
<table width=100% class="viewform">
<TR>
<TD >SystemEnv.getHtmlLabelName(15433,user.getLanguage())%></TD>
<TD  class=field colspan=3>

</TD>
</tr>
<TR style="height:1px;"><TD class=Line colSpan=6></TD></TR> 
<tr>
<TD >��������</TD>
<TD  class=field>
		<input type="text">
</TD>
<TD >��������</TD>
<TD  class=field>
		<input type="text">
</TD>
</TR>
<TR class="Spacing"  style="height:1px;"><TD class="Line1" colspan=6></TD></TR>
</table>
 -->
<%
	if("1".equals(type)||"3".equals(type)||"4".equals(type)||"6".equals(type)||"8".equals(type)||"11".equals(type)||"12".equals(type))
	{
		if("1".equals(operation))
		{
		
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type=checkbox id='check_per_ALL' onclick='javascript:check_per_ALLClick();'>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(23481,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30667,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(23481,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30667,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}else if("2".equals(type)||"5".equals(type))
	{
		if("1".equals(operation))
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type=checkbox id='check_per_ALL' onclick='javascript:check_per_ALLClick();'>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(30668,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30670,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30668,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30670,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}else if("7".equals(type)||"10".equals(type))
	{
		if("1".equals(operation))
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type=checkbox id='check_per_ALL' onclick='javascript:check_per_ALLClick();'>"+SystemEnv.getHtmlLabelName(556,user.getLanguage())+"</th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(30671,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30674,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30671,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30674,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}
	
	LogInfo li=new LogInfo();
	SAPFunctionAllParams sa  = null;
	SAPFunctionImportParams saimport = null;
	SAPFunctionExportParams saexp = null;
	if("".equals(stuortablevalue)) {
		sa = ServiceParamsUtil.getSAPFunAllParsByServID(servId,paramName,paramDesc,disValue,li);
		if(sa != null) {
			saimport = sa.getSip();//�õ����е��������
			saexp = sa.getSep();//�õ����е��������
		}
	}
	
	
		if("1".equals(type))//��ȡ�������
		{
			List list = null;
			if(saimport != null) {
				list=saimport.getStrList();//�õ�������������������
			}
			
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
						SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
						if(h%2==0) {
							out.println("<tr class=DataDark>");
						}else {
							out.println("<tr class=DataLight>");
						}
						
							if("1".equals(operation))
							{
								if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
								}else
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
								}
							}
							out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
							out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
						out.println("</tr>");
					}
			}
		}else if("3".equals(type))//��ȡĳ������ṹ������Ĳ���
		{
			if(!"".equals(stuortablevalue))
			{
				List list=ServiceParamsUtil.getCompParamsByServIdAndParamName(servId, stuortablevalue, "import", true,paramName,paramDesc,disValue);
				if(null!=list)
				{
					for(int h=0;h<list.size();h++) {
							SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
							if(h%2==0) {
								out.println("<tr class=DataDark>");
							}else {
								out.println("<tr class=DataLight>");
							}
								if("1".equals(operation))
								{
									if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
									}else
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
									}
								}
								out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
								out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
							out.println("</tr>");
					}
				}
			}
		}
		else if("4".equals(type))//��ȡ�������
		{
			List list = null;
			if(saexp != null) {
				list=saexp.getStrList();//�õ�������������������
			}
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
					SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
					if(h%2==0) {
						out.println("<tr class=DataDark>");
					}else {
						out.println("<tr class=DataLight>");
					}
						if("1".equals(operation))
						{
							if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
							{
								out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
							}else
							{
								out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
							}
						}
						out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
						out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
					out.println("</tr>");
				}
			}
		}
		else if("6".equals(type))//��ȡ����ṹ������������
		{
			if(!"".equals(stuortablevalue))
			{
				List list=ServiceParamsUtil.getCompParamsByServIdAndParamName(servId, stuortablevalue, "export", true,paramName,paramDesc,disValue);
				if(null!=list)
				{
					for(int h=0;h<list.size();h++) {
							SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
							if(h%2==0) {
								out.println("<tr class=DataDark>");
							}else {
								out.println("<tr class=DataLight>");
							}
								if("1".equals(operation))
								{
									if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
									}else
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
									}
								}
								out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
								out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
							out.println("</tr>");
					}
				}
			}
			
		}
		else if("8".equals(type)||"12".equals(type))//��ȡ�����������������
		{
			if(!"".equals(stuortablevalue))
			{
				List list=ServiceParamsUtil.getCompParamsByServIdAndParamName(servId, stuortablevalue, "export", false,paramName,paramDesc,disValue);
				if(null!=list)
				{
					for(int h=0;h<list.size();h++) {
							SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
							if(h%2==0) {
								out.println("<tr class=DataDark>");
							}else {
								out.println("<tr class=DataLight>");
							}
								if("1".equals(operation))
								{
									if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
									}else
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
									}
								}
								out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
								out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
							out.println("</tr>");
					}
				}
			}
		}
		else if("2".equals(type))//��ȡ����ṹ�����Ƽ���
		{
			List list = null;
			if(saimport != null)  list=saimport.getStructList();//�õ�������������������
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
					SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
					if(h%2==0) {
						out.println("<tr class=DataDark>");
					}else {
						out.println("<tr class=DataLight>");
					}
						if("1".equals(operation))
						{
							if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
							{
								out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
							}else
							{
								out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
							}
						}
						out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
						out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
					out.println("</tr>");
				}
			}
		}else if("5".equals(type))//��ȡ����ṹ�ṹ�����Ƽ���
		{
			List list = null;
			if(saexp != null) list=saexp.getStructList();//�õ�������������������
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
						SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
						if(h%2==0) {
							out.println("<tr class=DataDark>");
						}else {
							out.println("<tr class=DataLight>");
						}
							if("1".equals(operation))
							{
								if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
								}else
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
								}
							}
							out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
							out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
						out.println("</tr>");
					}
			}
		}else if("7".equals(type))//��ȡ���������Ƽ���
		{
			List list = null;
			if(saexp != null) list=saexp.getTableList();//�õ�������������������
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
						SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
						if(h%2==0) {
							out.println("<tr class=DataDark>");
						}else {
							out.println("<tr class=DataLight>");
						}
							if("1".equals(operation))
							{
								if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
								}else
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
								}
							}
							out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
							out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
						out.println("</tr>");
					}
			}
		}else if("10".equals(type))//��ȡ���������Ƽ���
		{
			List list = null;
			if(saimport != null)  list=saimport.getTableList();
			if(null!=list)
			{
				for(int h=0;h<list.size();h++) {
						SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
						if(h%2==0) {
							out.println("<tr class=DataDark>");
						}else {
							out.println("<tr class=DataLight>");
						}
							if("1".equals(operation))
							{
								if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
								}else
								{
									out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
								}
							}
							out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
							out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
						out.println("</tr>");
					}
			}
		}else if("11".equals(type))//��ȡĳ���������������еĲ���
		{
			if(!"".equals(stuortablevalue)) {
				List list=ServiceParamsUtil.getCompParamsByServIdAndParamName(servId, stuortablevalue, "import", false,paramName,paramDesc,disValue);
				if(null!=list)
				{
					for(int h=0;h<list.size();h++) {
							SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
							if(h%2==0) {
								out.println("<tr class=DataDark>");
							}else {
								out.println("<tr class=DataLight>");
							}
								if("1".equals(operation))
								{
									if(checkvalue.equals(sbpb.getParamName().toUpperCase()))
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
									}else
									{
										out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
									}
								}
								out.println("<td>"+sbpb.getParamName().toUpperCase()+"</td>");
								out.println("<td>"+sbpb.getParamDesc().toUpperCase()+"</td>");
							out.println("</tr>");
						}
				}
			}
			
		}
	out.println("</TABLE>");
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
</BODY></HTML>

<SCRIPT LANGUAGE="javascript">
var ids = "";
var names = "";
function btnok_onclick() {
	window.parent.returnValue = {id: ids, name: names};//Array(documentids,documentnames)
    window.parent.close();
}
//��ѡ
jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(event){
		if($(this)[0].tagName=="TR"&&event.target.tagName!="INPUT"){
			
			<%
				if("1".equals(operation))
				{
			%>
		   		   var $checkboxtemp = $(this).find("input[name=check_per]");
		   		   $checkboxtemp.attr("checked",!$checkboxtemp.attr("checked"));
				   ids= "";
			       names = "";
			       $("input[name=check_per]").each(function() {
			        	if($(this).attr("checked") == true) {
			        		ids += "##" + $(this).parent().parent().find("td:eq(1)").text();
			        		names += "##" + $(this).parent().parent().find("td:eq(2)").text();
			        	}
			        });
		
			  <%
				}else{
			%>		
					ids =   $(this).find("td:eq(0)").text();
			   		names = $(this).find("td:eq(1)").text();
			   		submitData();
			<%		
				}
			%>

		}
		//���checkbox��
	    if(event.target.tagName=="INPUT"){
	       var obj = $("input[name=check_per]");
	        ids= "";
	        names = "";
	        obj.each(function() {
	        	if($(this).attr("checked") == true) {
	        		ids += "##" + $(this).parent().parent().find("td:eq(1)").text();
	        		names += "##" + $(this).parent().parent().find("td:eq(2)").text();
	        	}
	        });
	    }
		
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
		$(this).addClass("Selected")
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
		$(this).removeClass("Selected")
	})

});
</SCRIPT>
<script language="javascript">
function onSubmit() {
		$G("SearchForm").submit();
}
function onReset() {
		$G("SearchForm").reset()
}
function submitData()
{
	btnok_onclick();
}
function onClean()
{
	 window.parent.returnValue = {id: "",name: ""};
     window.parent.close();
}
function doSearchParamsForm() {
	$("#searchFormParamsBtn").click();
}
function check_per_ALLClick() {
	var temp = $("#check_per_ALL").attr("checked");
	$("input[name='check_per'][type='checkbox']").attr("checked",temp);
	if(temp == false) {
		ids = "";
		names = "";
	} else {
		$("input[name='check_per'][type='checkbox']").each(function(){
			var idtemp = $(this).parent().parent().find("td:eq(1)").html();
			var nametemp = $(this).parent().parent().find("td:eq(2)").html();
			ids += "##" + idtemp;
			names += "##" + nametemp;
		});
	}
	
}
function replaceALL(str,oldstr,newstr) 
{ 
   re=new RegExp(oldstr,"g"); 
   var newstart=str.replace(re,newstr); 
   return newstart;
   // ���ͣ�re=new RegExp("l","g")�еĵ�һ����������Ҫ�滻���ַ������ڶ�������ָ�滻���еģ�
   //���У��ڶ�����Ҳ��������Ϊ("i"),��ʾֻ�滻��һ���ַ����� 
   //str.replace(re,"t")�еڶ���������Ҫ�޸ĵ��ַ�����
} 
</script>