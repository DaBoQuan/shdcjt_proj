<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="BillMonthWorkinfoOperation.jsp">
<%@ include file="/workflow/request/WorkflowViewRequestBody.jsp" %>		
    <tr> 
		<th colspan=2 align=center><%=SystemEnv.getHtmlLabelName(16276,user.getLanguage())%></th>
	</tr>
	<tr class="Title"> 
      <td colspan=2>
	  <table class="viewform">
	  <!-- �����ܽ� -->
     
	  <tr><td>
	    <table class=liststyle cellspacing=1   cols=4 id="oTable1">
	      <COLGROUP> 
	      <COL width="10%"><COL width="20%"> <COL width="20%"><COL width="20%"><COL width="20%">
	      <tr class=header> 
	        <td>&nbsp;</td>
	        <td><%=SystemEnv.getHtmlLabelName(16274,user.getLanguage())%></td>
	        <td><%=SystemEnv.getHtmlLabelName(15488,user.getLanguage())%></td>
	        <td><%=SystemEnv.getHtmlLabelName(16275,user.getLanguage())%></td>
	      </tr> <TR class="Line2">
    	  <TD colspan="4" ></TD></TR>
<%	boolean islight=true;
	RecordSet.executeProc("bill_monthinfodetail_SByType",""+billid+flag+"2");
	while(RecordSet.next()){
		String curworkdesc=RecordSet.getString("targetresult");
		String curscale=RecordSet.getString("scale");
		String curpoint=RecordSet.getString("point");
		if(curpoint.equals("0"))	curpoint="";
%>
		  <tr <%if(islight){%>class=datalight <%} else {%>class=datadark<%}%>>
		  <td>&nbsp;</td>
		  <td><%=Util.toScreen(curworkdesc,user.getLanguage())%></td>
		  <td><%=Util.toScreen(curscale,user.getLanguage())%>%</td>
		  <td><%=Util.toScreen(curpoint,user.getLanguage())%></td>
		  </tr>
<%
		islight=!islight;
	}
%>
	    </table>
	   </td></tr>
      </table>
      </td>
    </tr>
    <!--���¹���Ŀ�� !-->
    <tr> 
		<th colspan=2 align=center><%=SystemEnv.getHtmlLabelName(16272,user.getLanguage())%></th>
	</tr>
	<tr class="Title"> 
      <td colspan=2>
	  <table class="viewform">
	  <!-- ������� -->

	  <tr><td>
	    <table class=liststyle cellspacing=1   cols=5 id="oTable2">
	      <COLGROUP> 
	      <COL width="10%"><COL width="20%"> <COL width="20%"><COL width="20%"><COL width="20%">
	      <tr class=header> 
	        <td>&nbsp;</td>
	        <td><%=SystemEnv.getHtmlLabelName(16272,user.getLanguage())%></td>
	        <td><%=SystemEnv.getHtmlLabelName(15492,user.getLanguage())%></td>
	        <td><%=SystemEnv.getHtmlLabelName(1035,user.getLanguage())%></td>
	        <td><%=SystemEnv.getHtmlLabelName(15488,user.getLanguage())%></td>
	      </tr> <TR class="Line2">
    	  <TD colspan="5" ></TD></TR>
<%	islight=true;
	RecordSet.executeProc("bill_monthinfodetail_SByType",""+billid+flag+"1");
	while(RecordSet.next()){
		String curworkname=RecordSet.getString("targetname");
		String curworkdesc=RecordSet.getString("targetresult");
		String curdate=RecordSet.getString("forecastdate");
		String curscale=RecordSet.getString("scale");
%>
		  <tr <%if(islight){%>class=datalight <%} else {%>class=datadark<%}%>>
		  <td>&nbsp;</td>
		  <td><%=Util.toScreen(curworkname,user.getLanguage())%></td>
		  <td><%=Util.toScreen(curworkdesc,user.getLanguage())%></td>
		  <td><%=Util.toScreen(curdate,user.getLanguage())%></td>
		  <td><%=Util.toScreen(curscale,user.getLanguage())%>%</td>
		  </tr>
<%
		islight=!islight;
	}
%>
	    </table>
      </td>
    </tr>
  </table>
  <br>
  <br>
	<!--����ҳ������BUG-->
  <%--@ include file="WorkflowViewSign.jsp" --%>
			<jsp:include page="WorkflowViewSignAction.jsp" flush="true">
                <jsp:param name="workflowid" value="<%=workflowid%>" />
                <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
                <jsp:param name="requestid" value="<%=requestid%>" />
                <jsp:param name="userid" value="<%=userid%>" />
                <jsp:param name="usertype" value="<%=usertype%>" />
                <jsp:param name="isprint" value="<%=isprint%>" />
                <jsp:param name="nodeid" value="<%=nodeid%>" />
               
                <jsp:param name="desrequestid" value="<%=desrequestid%>" />
                <jsp:param name="isurger" value="<%=isurger%>" />
                <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />
			</jsp:include>
</form>
 
<script language=javascript>
	function doEdit(){
		document.frmmain.action="ManageRequest.jsp";
		document.frmmain.submit();
	}
</script>
</body>
</html>
