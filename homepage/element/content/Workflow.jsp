<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.conn.*" %>
<%@ include file="/homepage/element/content/Common.jsp" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="weaver.workflow.request.*" %>

<jsp:useBean id="dnm" class="weaver.docs.news.DocNewsManager" scope="page"/>
<jsp:useBean id="dm" class="weaver.docs.docs.DocManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rsIn" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="sppb" class="weaver.general.SplitPageParaBean" scope="page"/>
<jsp:useBean id="spu" class="weaver.general.SplitPageUtil" scope="page"/>
<jsp:useBean id="HomepageFiled" class="weaver.homepage.HomepageFiled" scope="page"/>

<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page"/>
<jsp:useBean id="WorkFlowTransMethod" class="weaver.general.WorkFlowTransMethod" scope="page"/>
<jsp:useBean id="HomepageSetting" class="weaver.homepage.HomepageSetting" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />


<%
	/*
		������Ϣ
		--------------------------------------
		hpid:����ҳID
		subCompanyId:��ҳ�����ֲ��ķֲ�ID
		eid:Ԫ��ID
		ebaseid:����Ԫ��ID
		styleid:��ʽID
		
		������Ϣ
		--------------------------------------
		String strsqlwhere ��ʽΪ ����1^,^����2...
		int perpage  ��ʾҳ��
		String linkmode �鿴��ʽ  1:��ǰҳ 2:����ҳ
 
		
		�ֶ���Ϣ
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		strsqlwherecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String hpsb.getEsymbol() ����ͼ��
		String hpsb.getEsparatorimg()   �зָ��� 
	*/

%>
<%	

	ArrayList tabIdList = new ArrayList();
	ArrayList tabTitleList = new ArrayList();
	
   if (!"".equals(strsqlwhere))  { //��ʾΪ�ϰ汾��������
		HomepageSetting.wfCenterUpgrade(strsqlwhere,Util.getIntValue(eid));
   } 
   
   String tabSql="select tabId,tabTitle from hpsetting_wfcenter where eid="+eid+" order by tabId";
   rs.execute(tabSql);
   while(rs.next()){
	   tabIdList.add(rs.getString("tabId"));
	   tabTitleList.add(rs.getString("tabTitle"));
  }
   
  String queryString = request.getQueryString();
  String url = "/page/element/compatible/WorkflowTabContentData.jsp";
  
%>
<div id="tabContainer_<%=eid%>" class='tab2'>
	<table height='32'  cellspacing='0' cellpadding='0' border='0'>
		<tr>
			<%for(int i=0;i<tabIdList.size();i++){ %>
				<%if(i==0){ %>
					<td id="tab_<%=eid%>" tabId=<%=tabIdList.get(i) %> class='tab2selected' onclick="loadContent('<%=eid%>','<%=url%>','<%=queryString%>')"><%=tabTitleList.get(i) %></td>
				<% }else{%>
					<td id="tab_<%=eid+"_"+tabIdList.get(i)%>" tabId=<%=tabIdList.get(i) %> class='tab2unselected' onclick="loadContent('<%=eid%>','<%=url%>','<%=queryString%>')"><%=tabTitleList.get(i) %></td>
			<%	 }
			 } %>
		</tr>
	</table>
</div>
<div id="tabContant_<%=eid%>">

</div>
<script type="text/javascript">
$("#tab_<%=eid%>").trigger("click");

</script>


