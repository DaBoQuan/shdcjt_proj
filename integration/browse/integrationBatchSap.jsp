<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
 <%@ include file="/systeminfo/init.jsp" %>
<%@page import="com.weaver.integration.datesource.SAPInterationOutUtil"%>
<%@page import="com.weaver.integration.log.LogInfo"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionImportParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionExportParams"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionBaseParamBean"%>
<%@page import="com.weaver.integration.datesource.SAPFunctionAllParams"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />

<HTML>
<base target="_self">
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%

		
		//Z_OSAP_MATERIAL_GETALL�������ֶεĺ���
		//BAPI_ROUTING_CREATE������ṹ,������ṹ,���������
		//BAPI_MATERIAL_SAVEDATA����ṹ���
		String poolid="";
		String functionName="";
		String regservice=Util.null2String(request.getParameter("regservice"));//ע������id
		//����ò�Ʒ�µ�����Դ�����ӳ�id��SAP-ABAP������
		RecordSet02.execute("select * from sap_service where id='"+regservice+"'");
		while(RecordSet02.next())
		{
			poolid=RecordSet02.getString("poolid");
			functionName=RecordSet02.getString("funname");
		}
		//�����ж���Զ�̻�ȡ�������Ǳ��ػ�ȡ������1�Ǳ��ػ�ȡ������2��Զ�̻�ȡ����
		String  islocal=Util.null2String(request.getParameter("islocal"));
		String type=Util.null2String(request.getParameter("type"));
		String stuortablevalue=Util.null2String(request.getParameter("stuortablevalue"));//���type=3,��ʾ����ṹ������,type=6��ʾ����ṹ������,type=8��ʾ����������
		String checkvalue=Util.null2String(request.getParameter("checkvalue"));//ѡ�е�һ��ֵ
		String operation=Util.null2String(request.getParameter("operation")); //operation��������1��ʾ�������,2��ʾ������ӻ��޸�
		if("".equals(operation)){operation="1";}
		//System.out.println("-----------ҳ����־------------");
		//System.out.println("���ӳص�id="+poolid);
		//System.out.println("����������="+functionName);
		//System.out.println("����type="+type);
		//System.out.println("(operation��������1��ʾ�������,2��ʾ������ӻ��޸�)="+operation);
		//System.out.println("ѡ�е�һ��ֵ="+checkvalue);
		//System.out.println("(���type=3,��ʾ����ṹ������,type=6��ʾ����ṹ������,type=8��ʾ����������)="+stuortablevalue);
		//System.out.println("��ȡ�����ķ�ʽ[1���ء�2Զ��]"+islocal);
		//System.out.println("------------------------");
		
		String se_fieldname=Util.null2String(request.getParameter("se_fieldname")).toUpperCase().trim();
		String  se_fielddesc=Util.null2String(request.getParameter("se_fielddesc")).toUpperCase().trim();
%>
<BODY>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSubmit(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:onReset(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;

if("1".equals(operation))
{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:btnok_onclick(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}else{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311 ,user.getLanguage())+",javascript:onClean(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
RCMenu += "{����,javascript:window.parent.onseach(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<div style="display:none">
<button type=button  class=btn accessKey=O id=btnok onclick="btnok_onclick()"><U>O1</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>
</div>

<form action="/integration/browse/integrationBatchSap.jsp" method="post"  id="SearchForm">

<input type='hidden'   name="regservice"  value='<%=regservice%>'>
<input type='hidden'   name="islocal"  value='<%=islocal%>'>
<input type='hidden'   name="type"  value='<%=type%>'>
<input type='hidden'   name="stuortablevalue"  value='<%=stuortablevalue%>'>
<input type='hidden'   name="checkvalue"  value='<%=checkvalue%>'>
<input type='hidden'   name="operation"  value='<%=operation%>'>


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
<table width=100% class="viewform">
<TR style="height:1px;"><TD class=Line colSpan=6></TD></TR> 
<tr>
<TD >��������</TD>
<TD  class=field>
		<input type='text' name='se_fieldname' value='<%=se_fieldname%>'>
</TD>
<TD >��������</TD>
<TD  class=field>
		<input type='text' name='se_fielddesc' value='<%=se_fielddesc%>'>
</TD>
</TR>
<TR class="Spacing"  style="height:1px;"><TD class="Line1" colspan=6></TD></TR>
</table>

<%
	if("1".equals(type)||"3".equals(type)||"4".equals(type)||"6".equals(type)||"8".equals(type)||"11".equals(type)||"12".equals(type))
	{
		if("1".equals(operation))
		{
		
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type='checkbox' value='1' name='selectAll' id='selectAll' onclick='selectAllBox(this)'></th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(23481 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30667 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(23481 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30667 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}else if("2".equals(type)||"5".equals(type))
	{
		if("1".equals(operation))
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type='checkbox' value='1' name='selectAll' id='selectAll' onclick='selectAllBox(this)'></th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(30668 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30670 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30668 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30670 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}else if("7".equals(type)||"10".equals(type))
	{
		if("1".equals(operation))
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<th width=10% ><input type='checkbox' value='1' name='selectAll' id='selectAll' onclick='selectAllBox(this)'></th>");
			 out.println("<TH width=40% >"+SystemEnv.getHtmlLabelName(30671 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30674 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='3' ></Th></TR> ");
		}else
		{
			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30671 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30674 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
		}
	}
	
	LogInfo li=new LogInfo();
	SAPFunctionAllParams sa=new SAPFunctionAllParams();
	SAPInterationOutUtil spout=new SAPInterationOutUtil();
	List list=new ArrayList();
	if("1".equals(islocal))//���ػ�ȡ����
	{
		//System.out.println("�ӱ���ץȡ�˲���............");
		list=spout.getLocallyParameters(regservice,type,stuortablevalue);
	}else//ֱ�ӷ���sap��ȡ����
	{
		//System.out.println("��Զ��ץȡ�˲���............");
		sa=spout.getALLParamsByFunctionName(poolid,functionName,li);
		SAPFunctionImportParams saimport=sa.getSip();//�õ����е��������
		SAPFunctionExportParams saexp=sa.getSep();//�õ����е��������
		if("1".equals(type)){
			list=saimport.getStrList();//�õ�������������������
		}else if("2".equals(type)){
			list=saimport.getStructList();//��ȡ����ṹ�����Ƽ���
		}else if("3".equals(type)){
			list=spout.getParamsByFuncNameCompSty(poolid,functionName,"import",true,stuortablevalue,li);//��ȡĳ������ṹ������Ĳ���
		}else if("4".equals(type)){
			list=saexp.getStrList();//�õ�������������������
		}else if("5".equals(type)){
			list=saexp.getStructList();//��ȡ����ṹ�ṹ�����Ƽ���
		}else if("6".equals(type)){
			list=spout.getParamsByFuncNameCompSty(poolid,functionName,"export",true,stuortablevalue,li);//��ȡ����ṹ������������
		}else if("7".equals(type)){
			list=saexp.getTableList();//��ȡ���������Ƽ���
		}else if("8".equals(type)||"12".equals(type)){
			list=spout.getParamsByFuncNameCompSty(poolid,functionName,"export",false,stuortablevalue,li);//��ȡ�����������������
		}else if("10".equals(type)){
			list=saimport.getTableList();//��ȡ���������Ƽ���
		}else if("11".equals(type)){
			list=spout.getParamsByFuncNameCompSty(poolid,functionName,"import",false,stuortablevalue,li);//��ȡĳ���������������еĲ���
		}	
	}
	if(null!=list)
	{
		for(int h=0;h<list.size();h++) {
				SAPFunctionBaseParamBean sbpb = (SAPFunctionBaseParamBean)list.get(h);
				
				String  zh_Fieldname=sbpb.getParamName().toUpperCase().trim();
				String  zh_Fielddesc=sbpb.getParamDesc().toUpperCase().trim();
				if(zh_Fieldname.indexOf(se_fieldname)==-1){
					continue;
				}
				if(zh_Fielddesc.indexOf(se_fielddesc)==-1){
					continue;
				}
				if(h%2==0){
					out.println("<tr class=DataDark>");
				}else{
					out.println("<tr class=DataLight>");
				}
				if("1".equals(operation)){
					if(checkvalue.equals(sbpb.getParamName())){
						out.println("<td style='width:50px'><input type=checkbox name='check_per' checked=checked></td>");
					}else{
						out.println("<td style='width:50px'><input type=checkbox name='check_per'></td>");
					}
				}
			out.println("<td>"+zh_Fieldname+"</td>");
			out.println("<td>"+zh_Fielddesc+"</td>");
			out.println("</tr>");
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
</form>
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
					var obj = jQuery(this).find("input[name=check_per]");
				   	if (obj.attr("checked") == true){
				   		   obj.attr("checked", false);
				   		ids = ids.replace("," + jQuery(this).find("td:eq(1)").text(), "")
				   		names = names.replace("," + replaceALL(jQuery(this).find("td:eq(2)").text(),",",""), "")
		
				   	}else{
				   		    obj.attr("checked", true);
				   		ids = ids + "," + jQuery(this).find("td:eq(1)").text();
				   		names = names + "," + replaceALL(jQuery(this).find("td:eq(2)").text(),",","");
				   	}
			  <%
				}else
				{
			%>		
					ids = ","+jQuery(this).find("td:eq(0)").text()
			   		names =","+replaceALL(jQuery(this).find("td:eq(1)").text(),",","");
			   		submitData();
			<%		
				}
			%>

		}
		//���checkbox��
	    if(event.target.tagName=="INPUT"){
	       var obj = jQuery(this).find("input[name=check_per]");
		   	if (obj.attr("checked") == true){
		   	    ids = ids + "," + jQuery(this).find("td:eq(1)").text();
		   		names = names + "," + replaceALL(jQuery(this).find("td:eq(2)").text(),",","");
		   	}else{
		   		ids = ids.replace("," + jQuery(this).find("td:eq(1)").text(), "")
		   		names = names.replace("," + replaceALL(jQuery(this).find("td:eq(2)").text(),",",""), "")
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
function onSubmit() {
		$G("SearchForm").submit()
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
	 window.parent.returnValue = {id: "0",name: ""};
     window.parent.close();
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
function selectAllBox(obj){
		$("[name='check_per']").attr("checked",obj.checked);//ȫѡ��ѡ
	    if (obj.checked == true){
	    	 ids=names="";
	    	 jQuery("#BrowseTable").find("input[name='check_per']").each(function (){
	    	 	 	  ids = ids + "," + jQuery(this).parent().parent().find("td:eq(1)").text();
			   		  names = names + "," + replaceALL( jQuery(this).parent().parent().find("td:eq(2)").text(),",","");
	    	 });
	   	}else{
	   		 //jQuery("#BrowseTable > input[name='check_per'] ").each(function (){
	   		  jQuery("#BrowseTable").find("input[name='check_per']").each(function (){
	    	 		 ids = ids.replace("," +  jQuery(this).parent().parent().find("td:eq(1)").text(), "");
		   			names = names.replace("," + replaceALL( jQuery(this).parent().parent().find("td:eq(2)").text(),",",""), "");
	    	 });
	   	}
}
function onseach(){
	$("#SearchForm").submit()
}
</script>