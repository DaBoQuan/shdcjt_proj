<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.workflow.workflow.WorkflowComInfo"%>
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

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%
		WorkflowComInfo workflowComInfo = new WorkflowComInfo();
		String workflowid=Util.null2String(request.getParameter("workflowid")); 
		int formid = Util.getIntValue(workflowComInfo.getFormId(""+workflowid), 0);
		String operation=Util.null2String(request.getParameter("operation"));
		int isbill=Util.getIntValue(request.getParameter("isbill"),1);
		//System.out.println("��������id"+workflowid);
		//System.out.println("��������formid"+formid);
		RecordSet rs = new RecordSet();
		String sql="";
		String tablename="";
		
		//ȡ���������
		//if(isbill == 0){
			//sql = "select fd.id, fd.fieldname, fd.fieldhtmltype, fd.type, fd.fielddbtype from workflow_formdict fd left join workflow_formfield ff on ff.fieldid=fd.id where ff.formid="+formid+" order by fd.id";
			//tablename = "workflow_form";//�ϱ�����������
		//}else{
			//sql = "select bf.id, bf.fieldname, bf.fieldhtmltype, bf.type, bf.fielddbtype from workflow_billfield bf where (viewtype=0 or viewtype is null) and billid="+formid+" order by bf.dsporder";
			//rs.execute("select tablename from workflow_bill where id="+formid);
			//if(rs.next()){
				//�±�����������
			//	tablename = Util.null2String(rs.getString("tablename"));
			//}
		//}
		//ȡ��ϸ�������
		if(isbill == 0){
				sql = "select distinct groupid from workflow_formfield where formid="+formid+" and isdetail='1' order by groupid";
			}else{
				sql = "select tablename as groupid from Workflow_billdetailtable where billid="+formid+" order by orderid";
		}
		//System.out.println("����ϸ��"+sql);
		List groupidList=new ArrayList();
		rs.execute(sql);
		while(rs.next()){
				String groupid_t = "";
				if(isbill == 0){
					groupid_t = "mx_"+Util.getIntValue(rs.getString("groupid"), 0);
				}else{
					groupid_t = Util.null2String(rs.getString("groupid"));
				}
				groupidList.add(groupid_t);
		}
%>
<BODY>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSubmit(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:onReset(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:onClean(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<div style="display:none">
<button type=button  class=btn accessKey=O id=btnok onclick="btnok_onclick()"><U>O1</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>
</div>

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

<%

			 out.println("<TABLE ID=BrowseTable class='BroswerStyle'  cellspacing='1' width='100%'>");
			 out.println("<TR class=DataHeader>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30671 ,user.getLanguage())+"</TH>");
			 out.println("<TH width=50% >"+SystemEnv.getHtmlLabelName(30674 ,user.getLanguage())+"</TH>");
			 out.println("</tr>");
			 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
			 for(int i=0;i<groupidList.size();i++)
			 {
			 	if(i%2==0)
			 	{
				 	out.println("<TR class=DataDark>");
				}else
				{
					out.println("<TR class=DataLink>");
				}
				 out.println("<Td width=50% >"+groupidList.get(i)+"</Td>");
				 out.println("<Td width=50% >"+SystemEnv.getHtmlLabelName(19325 ,user.getLanguage())+""+(i+1)+"</Td>");
				 out.println("</tr>");
				 out.println("<TR class=Line  style='height:1px;'><th colspan='2' ></Th></TR> ");
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
</BODY></HTML>

<SCRIPT LANGUAGE="javascript">
var ids = "";
var names = "";
function btnok_onclick() {
	window.returnValue = {id: ids, name: names};//Array(documentids,documentnames)
    window.close();
}
//��ѡ
jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(event){
		if($(this)[0].tagName=="TR"&&event.target.tagName!="INPUT"){
					ids = ","+jQuery(this).find("td:eq(0)").text()
			   		names =","+jQuery(this).find("td:eq(1)").text();
			   		btnok_onclick();
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
function onClean()
{
	 window.parent.returnValue = {id: "0",name: ""};
     window.parent.close();
}
function onReset() {
		window.close();
}
</SCRIPT>
