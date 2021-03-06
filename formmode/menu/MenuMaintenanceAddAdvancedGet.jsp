<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuHandler" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo" %>
<%@ page import="weaver.general.Util,weaver.general.GCONST,weaver.file.Prop,
                 weaver.docs.category.security.AclManager,
                 weaver.docs.category.CategoryTree,
                 weaver.docs.category.CommonCategory" %>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<jsp:useBean id="ProjTempletUtil" class="weaver.proj.Templet.ProjTempletUtil" scope="page"/>
<jsp:useBean id="ProjectTypeComInfo" class="weaver.proj.Maint.ProjectTypeComInfo" scope="page"/>
<jsp:useBean id="InputReportComInfo" class="weaver.datacenter.InputReportComInfo" scope="page" />

<%
String type=Util.null2String(request.getParameter("type"));
Prop prop = Prop.getInstance();
String hasOvertime = Util.null2String(prop.getPropValue(GCONST.getConfigFile(), "ecology.overtime"));
String hasChangStatus = Util.null2String(prop.getPropValue(GCONST.getConfigFile(), "ecology.changestatus"));
String selectArr = "";
int maincate = 0;
int rownum = 0;
int needtd=0;

int wftypetotal=0;
int wftotal=0;

ArrayList mainids=new ArrayList();
ArrayList subids=new ArrayList();
ArrayList secids=new ArrayList();
ArrayList NewWorkflowTypes = new ArrayList();


selectArr = "|";

if("adddoc".equals(type)||"mydoc".equals(type)||"newdoc".equals(type)||"doccategory".equals(type)){
	RecordSet.executeSql(" select id as categoryid,0 as categorytype,-1 as superdirid,-1 as superdirtype,categoryname,categoryorder from DocMainCategory "
			  + " UNION "
			  + " select id as categoryid,1 as categorytype,maincategoryid as superdirid,0 as superdirtype,categoryname,0 as categoryorder from DocSubCategory "
			  + " UNION "
			  + " select id as categoryid,2 as categorytype,subcategoryid as superdirid,1 as superdirtype,categoryname,0 as categoryorder from DocSecCategory "
	);
	CategoryTree tree = new CategoryTree();
	while (RecordSet.next()) {
	    CommonCategory category = new CommonCategory();
	    category.id = RecordSet.getInt("categoryid");
	    category.type = RecordSet.getInt("categorytype");
	    category.superiorid = RecordSet.getInt("superdirid");
	    category.superiortype = RecordSet.getInt("superdirtype");
	    category.name = RecordSet.getString("categoryname");
	    tree.allCategories.add(category);
	    if (category.type == AclManager.CATEGORYTYPE_MAIN) {
	  	  tree.mainCategories.add(category);
	    }
	}
	tree.rebuildCategoryRelation();
	
	
	
	Vector alldirs = tree.allCategories;
	for (int i=0;i<alldirs.size();i++) {
	    CommonCategory temp = (CommonCategory)alldirs.get(i);
	    if (temp.type == AclManager.CATEGORYTYPE_MAIN) {
	        mainids.add(Integer.toString(temp.id));
	    } else if (temp.type == AclManager.CATEGORYTYPE_SEC) {
	        secids.add(Integer.toString(temp.id));
	        if (subids.indexOf(Integer.toString(temp.superiorid)) == -1) {
	            subids.add(Integer.toString(temp.superiorid));
	        }
	    }
	}
}

List inputReportFormIdList=new ArrayList();
ArrayList NewWorkflows = new ArrayList();
if("addwf".equals(type)||"waitdowf".equals(type)||"donewf".equals(type)||"alreadydowf".equals(type)||"mywf".equals(type)||
		"sendwf".equals(type)||"supervisewf".equals(type)||"overtimewf".equals(type)||"backwf".equals(type)	){
	
	selectArr="|";
	
	String sql = "select distinct workflowtype from ShareInnerWfCreate t1,workflow_base t2 where t1.workflowid=t2.id and t2.isvalid='1'";
	RecordSet.executeSql(sql);
	while(RecordSet.next()){
		NewWorkflowTypes.add(RecordSet.getString("workflowtype"));
	}
	
	
	  sql = "select distinct workflowid from ShareInnerWfCreate";
	  RecordSet.executeSql(sql);
	  while(RecordSet.next()){
	    NewWorkflows.add(RecordSet.getString("workflowid"));
	  }

	
	String tempWorkflowId=null;
	String tempFormId=null;
	String tempIsBill=null;
	for(int i=0;i<NewWorkflows.size();i++){
		tempWorkflowId=(String)NewWorkflows.get(i);
		tempFormId=WorkflowComInfo.getFormId(tempWorkflowId);
		tempIsBill=WorkflowComInfo.getIsBill(tempWorkflowId);
		if(Util.getIntValue(tempFormId,0)<0){
			inputReportFormIdList.add(tempFormId);
		}
	}	
}



if("adddoc".equals(type)){
%>
<TABLE class=ViewForm id="customSetting_1">
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(16398,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		<TR><TD colSpan=2>

		<table class=ViewForm>
		  <%
		  
		  
		  maincate = mainids.size();
		  rownum = maincate/2;
		  if((maincate-rownum*2)!=0)
		  	  rownum=rownum+1;
		  %>
		  <tr class=field>
		    <td width="50%" align=left valign=top>
		    <%
		 	needtd=rownum;
		 	for(int i=0;i<mainids.size();i++){
		 		String mainid = (String)mainids.get(i);
		 		String mainname=MainCategoryComInfo.getMainCategoryname(mainid);
		 		needtd--;
		 	%>
		 	<table class=ViewForm>
				<tr class=field>
				  <td colspan=2 align=left>
				  <% if(selectArr.indexOf("M"+mainid+"|")==-1){%>
				  <input type="checkbox" name="docdir_ND_m<%=mainid%>" value="docdir_ND_M<%=mainid%>" onclick="checkMain('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_ND_m<%=mainid%>" value="docdir_ND_M<%=mainid%>" onclick="checkMain('<%=mainid%>')" checked>
				  <%}%>
				  <b><%=mainname%></b> </td></tr>
		 	<%
				for(int j=0;j<subids.size();j++){
					String subid = (String)subids.get(j);
					String subname=SubCategoryComInfo.getSubCategoryname(subid);
				 	String curmainid = SubCategoryComInfo.getMainCategoryid(subid);
				 	if(!curmainid.equals(mainid)) continue;
			%>
				<tr class="field">
				  <td width="20%"></td>
				  <td>
				  <% if(selectArr.indexOf("S"+subid+"|")==-1){%>
				  <input type="checkbox" name="docdir_ND_s<%=mainid%>" value="docdir_ND_S<%=subid%>" onclick="checkSub('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_ND_s<%=mainid%>" value="docdir_ND_S<%=subid%>" onclick="checkSub('<%=mainid%>')" checked>
				  <%}%>
				  <%=subname%></td></tr>
			<%
				}
			%>
			</table>
			<%
				if(needtd==0){
					needtd=maincate/2;
			%>
				</td><td align=left valign=top>
			<%
				}
			}
			%>
		  </tr>
		</table>				  	
		<script>
		function checkMain(id) {
			var mainchecked=eval("document.frmmain.docdir_ND_m"+id).checked ;
			var ary = eval("document.frmmain.docdir_ND_s"+id);
			if(ary!=undefined){
				if(ary.length==null){
					 ary.checked= mainchecked ;
				}else{
					for(var i=0; i<ary.length; i++) {
						ary[i].checked= mainchecked ;
					}
				}
			}
		}
		
		function checkSub(id) {
			var ary = eval("document.frmmain.docdir_ND_s"+id);
			var mainchecked = false;
			if(ary!=undefined){
			if(ary.length==null) mainchecked = ary.checked;
			else
				for(var i=0; i<ary.length; i++) {
					if(ary[i].checked){
						mainchecked = true;
						break;
					}
				}
			}
			if(mainchecked) eval("document.frmmain.docdir_ND_m"+id).checked=true;
			else eval("document.frmmain.docdir_ND_m"+id).checked=false;
		}				  	
		</script>				  	
		  	
		  </TD>
		</TR>
	</TBODY>
</TABLE>
<%}else if("mydoc".equals(type)){%>
<%-- 文档 我的文档 默认显示方式 --%>
<TABLE class=ViewForm id="customSetting_2" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
		<%-- 
		<tr>
		  <td><%=SystemEnv.getHtmlLabelName(19056,user.getLanguage())%></td>
		  <td class=Field>
		  
			<input type="radio" name="displayUsage_2" value="0" checked><%=SystemEnv.getHtmlLabelName(320,user.getLanguage())%>
			<input type="radio" name="displayUsage_2" value="1" ><%=SystemEnv.getHtmlLabelName(19064,user.getLanguage())%>
		  
		  </td>
		</tr>
		
		<TR  style="height: 1px"><TD class=Line colSpan=2></TD></TR> --%>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(16398,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		<TR><TD colSpan=2>

		<table class=ViewForm>
		  <%
		  selectArr = "|";
		  
		  maincate = mainids.size();
		  rownum = maincate/2;
		  if((maincate-rownum*2)!=0)
		  	  rownum=rownum+1;
		  %>
		  <tr class=field>
		    <td width="50%" align=left valign=top>
		    <%
		 	needtd=rownum;
		 	for(int i=0;i<mainids.size();i++){
		 		String mainid = (String)mainids.get(i);
		 		String mainname=MainCategoryComInfo.getMainCategoryname(mainid);
		 		needtd--;
		 	%>
		 	<table class=ViewForm>
				<tr class=field>
				  <td colspan=2 align=left>
				  <% if(selectArr.indexOf("M"+mainid+"|")==-1){%>
				  <input type="checkbox" name="docdir_MD_m<%=mainid%>" value="docdir_MD_M<%=mainid%>" onclick="checkMain2('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_MD_m<%=mainid%>" value="docdir_MD_M<%=mainid%>" onclick="checkMain2('<%=mainid%>')" checked>
				  <%}%>
				  <b><%=mainname%></b> </td></tr>
		 	<%
				for(int j=0;j<subids.size();j++){
					String subid = (String)subids.get(j);
					String subname=SubCategoryComInfo.getSubCategoryname(subid);
				 	String curmainid = SubCategoryComInfo.getMainCategoryid(subid);
				 	if(!curmainid.equals(mainid)) continue;
			%>
				<tr class="field">
				  <td width="20%"></td>
				  <td>
				  <% if(selectArr.indexOf("S"+subid+"|")==-1){%>
				  <input type="checkbox" name="docdir_MD_s<%=mainid%>" value="docdir_MD_S<%=subid%>" onclick="checkSub2('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_MD_s<%=mainid%>" value="docdir_MD_S<%=subid%>" onclick="checkSub2('<%=mainid%>')" checked>
				  <%}%>
				  <%=subname%></td></tr>
			<%
				}
			%>
			</table>
			<%
				if(needtd==0){
					needtd=maincate/2;
			%>
				</td><td align=left valign=top>
			<%
				}
			}
			%>
		  </tr>
		</table>				  	
		<script>
		function checkMain2(id) {
			var mainchecked=eval("document.frmmain.docdir_MD_m"+id).checked ;
			var ary = eval("document.frmmain.docdir_MD_s"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkSub2(id) {
			var ary = eval("document.frmmain.docdir_MD_s"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.docdir_MD_m"+id).checked=true;
			else eval("document.frmmain.docdir_MD_m"+id).checked=false;
		}				  	
		</script>				  	
		  	
		  </TD>
		</TR>
		
		
		
		
	</TBODY>
</TABLE>
<%}else if("newdoc".equals(type)){%>
<%-- 文档 最新文档 默认显示方式 --%>
<TABLE class=ViewForm id="customSetting_3" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
		<tr>
		  <td><%=SystemEnv.getHtmlLabelName(19056,user.getLanguage())%></td>
		  <td class=Field>
		  
			<input type="radio" name="displayUsage_3" value="0" checked><%=SystemEnv.getHtmlLabelName(320,user.getLanguage())%>
			<input type="radio" name="displayUsage_3" value="1" ><%=SystemEnv.getHtmlLabelName(19064,user.getLanguage())%>
		  
		  </td>
		</tr>
		
		
		<TR  style="height: 1px"><TD class=Line colSpan=2></TD></TR>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(16398,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing><TD class=Line1 colSpan=2></TD></TR>
		<TR><TD colSpan=2>

		<table class=ViewForm>
		  <%
		  selectArr = "|";
		  
		  maincate = mainids.size();
		  rownum = maincate/2;
		  if((maincate-rownum*2)!=0)
		  	  rownum=rownum+1;
		  %>
		  <tr class=field>
		    <td width="50%" align=left valign=top>
		    <%
		 	needtd=rownum;
		 	for(int i=0;i<mainids.size();i++){
		 		String mainid = (String)mainids.get(i);
		 		String mainname=MainCategoryComInfo.getMainCategoryname(mainid);
		 		needtd--;
		 	%>
		 	<table class=ViewForm>
				<tr class=field>
				  <td colspan=2 align=left>
				  <% if(selectArr.indexOf("M"+mainid+"|")==-1){%>
				  <input type="checkbox" name="docdir_NESTD_m<%=mainid%>" value="docdir_NESTD_M<%=mainid%>" onclick="checkMain3('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_NESTD_m<%=mainid%>" value="docdir_NESTD_M<%=mainid%>" onclick="checkMain3('<%=mainid%>')" checked>
				  <%}%>
				  <b><%=mainname%></b> </td></tr>
		 	<%
				for(int j=0;j<subids.size();j++){
					String subid = (String)subids.get(j);
					String subname=SubCategoryComInfo.getSubCategoryname(subid);
				 	String curmainid = SubCategoryComInfo.getMainCategoryid(subid);
				 	if(!curmainid.equals(mainid)) continue;
			%>
				<tr class="field">
				  <td width="20%"></td>
				  <td>
				  <% if(selectArr.indexOf("S"+subid+"|")==-1){%>
				  <input type="checkbox" name="docdir_NESTD_s<%=mainid%>" value="docdir_NESTD_S<%=subid%>" onclick="checkSub3('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_NESTD_s<%=mainid%>" value="docdir_NESTD_S<%=subid%>" onclick="checkSub3('<%=mainid%>')" checked>
				  <%}%>
				  <%=subname%></td></tr>
			<%
				}
			%>
			</table>
			<%
				if(needtd==0){
					needtd=maincate/2;
			%>
				</td><td align=left valign=top>
			<%
				}
			}
			%>
		  </tr>
		</table>				  	
		<script>
		function checkMain3(id) {
			var mainchecked=eval("document.frmmain.docdir_NESTD_m"+id).checked ;
			var ary = eval("document.frmmain.docdir_NESTD_s"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkSub3(id) {
			var ary = eval("document.frmmain.docdir_NESTD_s"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.docdir_NESTD_m"+id).checked=true;
			else eval("document.frmmain.docdir_NESTD_m"+id).checked=false;
		}				  	
		</script>				  	
		  	
		  </TD>
		</TR>


	</TBODY>
</TABLE>
<%}else if("doccategory".equals(type)){%>
<%-- 文档 文档目录 默认显示方式 --%>
<TABLE class=ViewForm id="customSetting_4" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
		<%-- 
		<tr>
		  <td><%=SystemEnv.getHtmlLabelName(19056,user.getLanguage())%></td>
		  <td class=Field>
		  
			<input type="radio" name="displayUsage_4" value="0" checked><%=SystemEnv.getHtmlLabelName(320,user.getLanguage())%>
			<input type="radio" name="displayUsage_4" value="1" ><%=SystemEnv.getHtmlLabelName(19064,user.getLanguage())%>
		  
		  </td>
		</tr>
		
		
		<TR  style="height: 1px"><TD class=Line colSpan=2></TD></TR> --%>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(16398,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		<TR><TD colSpan=2>

		<table class=ViewForm>
		  <%
		  selectArr = "|";
		  
		  maincate = mainids.size();
		  rownum = maincate/2;
		  if((maincate-rownum*2)!=0)
		  	  rownum=rownum+1;
		  %>
		  <tr class=field>
		    <td width="50%" align=left valign=top>
		    <%
		 	needtd=rownum;
		 	for(int i=0;i<mainids.size();i++){
		 		String mainid = (String)mainids.get(i);
		 		String mainname=MainCategoryComInfo.getMainCategoryname(mainid);
		 		needtd--;
		 	%>
		 	<table class=ViewForm>
				<tr class=field>
				  <td colspan=2 align=left>
				  <% if(selectArr.indexOf("M"+mainid+"|")==-1){%>
				  <input type="checkbox" name="docdir_DC_m<%=mainid%>" value="docdir_DC_M<%=mainid%>" onclick="checkMain4('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_DC_m<%=mainid%>" value="docdir_DC_M<%=mainid%>" onclick="checkMain4('<%=mainid%>')" checked>
				  <%}%>
				  <b><%=mainname%></b> </td></tr>
		 	<%
				for(int j=0;j<subids.size();j++){
					String subid = (String)subids.get(j);
					String subname=SubCategoryComInfo.getSubCategoryname(subid);
				 	String curmainid = SubCategoryComInfo.getMainCategoryid(subid);
				 	if(!curmainid.equals(mainid)) continue;
			%>
				<tr class="field">
				  <td width="20%"></td>
				  <td>
				  <% if(selectArr.indexOf("S"+subid+"|")==-1){%>
				  <input type="checkbox" name="docdir_DC_s<%=mainid%>" value="docdir_DC_S<%=subid%>" onclick="checkSub4('<%=mainid%>')">
				  <%} else {%>
				  <input type="checkbox" name="docdir_DC_s<%=mainid%>" value="docdir_DC_S<%=subid%>" onclick="checkSub4('<%=mainid%>')" checked>
				  <%}%>
				  <%=subname%></td></tr>
			<%
				}
			%>
			</table>
			<%
				if(needtd==0){
					needtd=maincate/2;
			%>
				</td><td align=left valign=top>
			<%
				}
			}
			%>
		  </tr>
		</table>				  	
		<script>
		function checkMain4(id) {
			var mainchecked=eval("document.frmmain.docdir_DC_m"+id).checked ;
			var ary = eval("document.frmmain.docdir_DC_s"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkSub4(id) {
			var ary = eval("document.frmmain.docdir_DC_s"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.docdir_DC_m"+id).checked=true;
			else eval("document.frmmain.docdir_DC_m"+id).checked=false;
		}				  	
		</script>				  	
		  	
		  </TD>
		</TR>


	</TBODY>
</TABLE>
<%}else if("addwf".equals(type)){%>
<%-- 流程 新建流程 工作流 --%>
<TABLE class=ViewForm id="customSetting_5" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		String dataCenterWorkflowTypeId="";
		RecordSet.executeSql("select currentId from sequenceindex where indexDesc='dataCenterWorkflowTypeId'");
		if(RecordSet.next()){
			dataCenterWorkflowTypeId=Util.null2String(RecordSet.getString("currentId"));
		}
		List inputReportList=new ArrayList();
		RecordSet.executeSql("select inprepId from T_inputReport where deleted=0");
		while(RecordSet.next()){
			inputReportList.add(RecordSet.getString("inprepId"));
		}

		if(inputReportList.size()>0&&NewWorkflowTypes.indexOf(dataCenterWorkflowTypeId)==-1){
			NewWorkflowTypes.add(dataCenterWorkflowTypeId);
		}

		ArrayList NewInputReports = new ArrayList();
		String inprepId=null;
		String inprepName=null;
		for(int i=0;i<inputReportList.size();i++){
			inprepId=Util.null2String((String)inputReportList.get(i));
			if(!inprepId.equals("")&&inputReportFormIdList.indexOf(InputReportComInfo.getbillid(inprepId))==-1){
				NewInputReports.add(inprepId);
			}
		}

		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
		if(dataCenterWorkflowTypeId.equals(wftypeid)){
			while(InputReportComInfo.next()){
				inprepId = InputReportComInfo.getinprepid();
			 	inprepName=InputReportComInfo.getinprepname();

			 	if(NewInputReports.indexOf(inprepId)==-1) continue;  

			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_NF_t<%=wftypeid%>" value="workflow_NF_T<%=wftypeid%>" onclick="checkType('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_NF_t<%=wftypeid%>" value="workflow_NF_T<%=wftypeid%>" onclick="checkType('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=inprepName%>
				<% if(selectArr.indexOf("R"+inprepId+"|")==-1){%>
				<input type="checkbox" name="workflow_NF_w<%=wftypeid%>" value="workflow_NF_R<%=inprepId%>" onclick="checkWorkflow('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_NF_w<%=wftypeid%>" value="workflow_NF_R<%=inprepId%>" onclick="checkWorkflow('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
			}
		}
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
				if(NewWorkflows.indexOf(wfid)==-1) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_NF_t<%=wftypeid%>" value="workflow_NF_T<%=wftypeid%>" onclick="checkType('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_NF_t<%=wftypeid%>" value="workflow_NF_T<%=wftypeid%>" onclick="checkType('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_NF_w<%=wftypeid%>" value="workflow_NF_W<%=wfid%>" onclick="checkWorkflow('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_NF_w<%=wftypeid%>" value="workflow_NF_W<%=wfid%>" onclick="checkWorkflow('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType(id) {
			var mainchecked=eval("document.frmmain.workflow_NF_t"+id).checked ;
			
			var ary = eval("document.frmmain.workflow_NF_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow(id) {
			var ary = eval("document.frmmain.workflow_NF_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_NF_t"+id).checked=true;
			else eval("document.frmmain.workflow_NF_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>
		
<%}else if("waitdowf".equals(type)){%>
<%-- 流程 待办事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_6" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_PM_t<%=wftypeid%>" value="workflow_PM_T<%=wftypeid%>" onclick="checkType2('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_PM_t<%=wftypeid%>" value="workflow_PM_T<%=wftypeid%>" onclick="checkType2('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_PM_w<%=wftypeid%>" value="workflow_PM_W<%=wfid%>" onclick="checkWorkflow2('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_PM_w<%=wftypeid%>" value="workflow_PM_W<%=wfid%>" onclick="checkWorkflow2('<%=wftypeid%>')" checked>
				<%}%>
				<BUTTON class=Browser id=SelectAddress onclick="onChooseNode(workflow_PM_v<%=wfid%>, workflow_PM_n<%=wfid%>, workflow_PM_span<%=wfid%>, '<%=wfid%>', '<%=wftypeid%>')"></BUTTON>
				<SPAN id="workflow_PM_span<%=wfid%>"></SPAN>
				<input type="hidden" id="workflow_PM_v<%=wfid%>" name="workflow_PM_v<%=wfid%>" value="" />
				<input type="hidden" id="workflow_PM_n<%=wfid%>" name="workflow_PM_n<%=wfid%>" value="" />
				</ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType2(id) {
			var mainchecked=eval("document.frmmain.workflow_PM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_PM_w"+id);
			if(ary!=undefined){
				if(ary.length==null){
					ary.checked= mainchecked;
					//alert(mainchecked);
					if(mainchecked == false){
						//alert(eval("document.frmmain.workflow_PM_w"+id).parentElement.childNodes(7).name);
						ary.parentElement.childNodes(4).innerHTML="";
						ary.parentElement.childNodes(5).value="0";
						ary.parentElement.childNodes(7).value="";
					}
				}else{
					for(var i=0; i<ary.length; i++) {
						ary[i].checked= mainchecked;
						//alert('for '+mainchecked);
						if(mainchecked == false){
							ary[i].parentElement.childNodes(4).innerHTML="";
							ary[i].parentElement.childNodes(5).value="0";
							ary[i].parentElement.childNodes(7).value="";
						}
					}
				}
			}
		}
		
		function checkWorkflow2(id) {
			var ary = eval("document.frmmain.workflow_PM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null){
					mainchecked = ary.checked;
					if(mainchecked == false){
						//alert(eval("document.frmmain.workflow_PM_w"+id).parentElement.childNodes(5).tagName);
						ary.parentElement.childNodes(4).innerHTML="";
						ary.parentElement.childNodes(5).value="0";
						ary.parentElement.childNodes(7).value="";
					}
				}else{
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							//break;
						}else{
							ary[i].parentElement.childNodes(4).innerHTML="";
							ary[i].parentElement.childNodes(5).value="0";
							ary[i].parentElement.childNodes(7).value="";
						}
					}
				}
			}
			if(mainchecked) eval("document.frmmain.workflow_PM_t"+id).checked=true;
			else eval("document.frmmain.workflow_PM_t"+id).checked=false;
		}

		function onChooseNode(inputName, inputName2, spanName, workflowId, wfTypeName){
			printNodes=inputName.value;
			tempUrl=escape("/workflow/workflow/WorkflowNodeBrowserMulti.jsp?printNodes="+printNodes+"&workflowId="+workflowId);
			var result =window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+tempUrl);

			if (result != null){
				if (result[0] > 0 && result[1] != 0){  
					inputName.value=result[1];
					spanName.innerHTML=result[2];
					inputName2.value=result[2];
					inputName.parentElement.childNodes(1).checked=true;
					//alert(inputName2.value);
					//alert(t1.checked);
					//alert(inputName.parentElement.childNodes(1).checked);
					//alert(document.getElementById(spanName));

					checkWorkflow2(wfTypeName);
					//alert(result[1]);
					//alert(spanName);
					//alert(inputName.value);
				}else{
					inputName.value="0";
					spanName.innerHTML="";
					inputName2.value="";
					//eval("document.frmmain."+wfTypeName).checked=false;
				}
			}
		}
		</script>
		</TD></TR>
	</TBODY>
</TABLE>
<%}else if("donewf".equals(type)){%>
<%-- 流程 已办事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_7" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_HM_t<%=wftypeid%>" value="workflow_HM_T<%=wftypeid%>" onclick="checkType3('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_HM_t<%=wftypeid%>" value="workflow_HM_T<%=wftypeid%>" onclick="checkType3('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_HM_w<%=wftypeid%>" value="workflow_HM_W<%=wfid%>" onclick="checkWorkflow3('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_HM_w<%=wftypeid%>" value="workflow_HM_W<%=wfid%>" onclick="checkWorkflow3('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType3(id) {
			var mainchecked=eval("document.frmmain.workflow_HM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_HM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow3(id) {
			var ary = eval("document.frmmain.workflow_HM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_HM_t"+id).checked=true;
			else eval("document.frmmain.workflow_HM_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>


<%}else if("alreadydowf".equals(type)){%>
<%-- 流程 办结事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_8" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_CM_t<%=wftypeid%>" value="workflow_CM_T<%=wftypeid%>" onclick="checkType4('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_CM_t<%=wftypeid%>" value="workflow_CM_T<%=wftypeid%>" onclick="checkType4('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_CM_w<%=wftypeid%>" value="workflow_CM_W<%=wfid%>" onclick="checkWorkflow4('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_CM_w<%=wftypeid%>" value="workflow_CM_W<%=wfid%>" onclick="checkWorkflow4('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType4(id) {
			var mainchecked=eval("document.frmmain.workflow_CM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_CM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow4(id) {
			var ary = eval("document.frmmain.workflow_CM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_CM_t"+id).checked=true;
			else eval("document.frmmain.workflow_CM_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>



<%}else if("mywf".equals(type)){%>
<%-- 流程 我的请求 工作流 --%>
<TABLE class=ViewForm id="customSetting_9" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_MR_t<%=wftypeid%>" value="workflow_MR_T<%=wftypeid%>" onclick="checkType5('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_MR_t<%=wftypeid%>" value="workflow_MR_T<%=wftypeid%>" onclick="checkType5('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_MR_w<%=wftypeid%>" value="workflow_MR_W<%=wfid%>" onclick="checkWorkflow5('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_MR_w<%=wftypeid%>" value="workflow_MR_W<%=wfid%>" onclick="checkWorkflow5('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType5(id) {
			var mainchecked=eval("document.frmmain.workflow_MR_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_MR_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow5(id) {
			var ary = eval("document.frmmain.workflow_MR_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_MR_t"+id).checked=true;
			else eval("document.frmmain.workflow_MR_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>
<%}else if("sendwf".equals(type)){%>
<%-- 流程 抄送事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_12" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_RM_t<%=wftypeid%>" value="workflow_RM_T<%=wftypeid%>" onclick="checkType6('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_RM_t<%=wftypeid%>" value="workflow_RM_T<%=wftypeid%>" onclick="checkType6('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_RM_w<%=wftypeid%>" value="workflow_RM_W<%=wfid%>" onclick="checkWorkflow6('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_RM_w<%=wftypeid%>" value="workflow_RM_W<%=wfid%>" onclick="checkWorkflow6('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType6(id) {
			var mainchecked=eval("document.frmmain.workflow_RM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_RM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow6(id) {
			var ary = eval("document.frmmain.workflow_RM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_RM_t"+id).checked=true;
			else eval("document.frmmain.workflow_RM_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>

<%}else if("supervisewf".equals(type)){%>
<%-- 流程 督办事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_13" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";

		//ArrayList urgerWFtypes=WFUrgerManager.getWrokflowTree();
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_SM_t<%=wftypeid%>" value="workflow_SM_T<%=wftypeid%>" onclick="checkType7('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_SM_t<%=wftypeid%>" value="workflow_SM_T<%=wftypeid%>" onclick="checkType7('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_SM_w<%=wftypeid%>" value="workflow_SM_W<%=wfid%>" onclick="checkWorkflow7('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_SM_w<%=wftypeid%>" value="workflow_SM_W<%=wfid%>" onclick="checkWorkflow7('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType7(id) {
			var mainchecked=eval("document.frmmain.workflow_SM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_SM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow7(id) {
			var ary = eval("document.frmmain.workflow_SM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_SM_t"+id).checked=true;
			else eval("document.frmmain.workflow_SM_t"+id).checked=false;
		}				  	
		</script>				  	
		
		
		
		</TD></TR>
		
	</TBODY>
</TABLE>

<%}else if("overtimewf".equals(type)){%>
<%if(!"".equals(hasOvertime)){%>
<%-- 流程 超时事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_14" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_OM_t<%=wftypeid%>" value="workflow_OM_T<%=wftypeid%>" onclick="checkType8('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_OM_t<%=wftypeid%>" value="workflow_OM_T<%=wftypeid%>" onclick="checkType8('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_OM_w<%=wftypeid%>" value="workflow_OM_W<%=wfid%>" onclick="checkWorkflow8('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_OM_w<%=wftypeid%>" value="workflow_OM_W<%=wfid%>" onclick="checkWorkflow8('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType8(id) {
			var mainchecked=eval("document.frmmain.workflow_OM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_OM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow8(id) {
			var ary = eval("document.frmmain.workflow_OM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_OM_t"+id).checked=true;
			else eval("document.frmmain.workflow_OM_t"+id).checked=false;
		}				  	
		</script>				  	
		</TD></TR>
	</TBODY>
</TABLE>
<%}%>
<%}else if("backwf".equals(type)){%>

<%if(!"".equals(hasChangStatus)){%>
<%-- 流程 反馈事宜 工作流 --%>
<TABLE class=ViewForm id="customSetting_15" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		
		<TR><TD colSpan=2>
		

		<table class="ViewForm" width="100%">
		   <tr class=field>
		        <td width="50%" align=left valign=top>
		<%
		
		selectArr="|";
		
		wftypetotal=NewWorkflowTypes.size();
		wftotal=WorkflowComInfo.getWorkflowNum();
		rownum = wftypetotal/2;
		if((wftypetotal-rownum*2)!=0)
			rownum=rownum+1;
		
			int i=0;
		 	needtd=rownum;
		 	while(WorkTypeComInfo.next()){	
		 		String wftypename=WorkTypeComInfo.getWorkTypename();
		 		String wftypeid = WorkTypeComInfo.getWorkTypeid();
		 		if(NewWorkflowTypes.indexOf(wftypeid)==-1) continue;            
			 	//if(selectedworkflow.indexOf("T"+wftypeid+"|")==-1&& isuserdefault.equals("1")) continue;
		 		needtd--;
		 	%>
		 	<table class="ViewForm">
				<tr>
				  <td>
		 	<%
		 	int isfirst = 1;
			while(WorkflowComInfo.next()){
				String wfname=WorkflowComInfo.getWorkflowname();
			 	String wfid = WorkflowComInfo.getWorkflowid();
			 	String curtypeid = WorkflowComInfo.getWorkflowtype();
		        int isagent=0;
		        String agentname="";
			 	if(!curtypeid.equals(wftypeid)) continue;
			 	//check right
			 	//if(selectedworkflow.indexOf("W"+wfid+"|")==-1&& isuserdefault.equals("1")) continue;
			 	i++;
			 	
			 	if(isfirst ==1){
			 		isfirst = 0;
			%>
				<ul><li><b><%=Util.toScreen(wftypename,user.getLanguage())%>
				<% if(selectArr.indexOf("T"+wftypeid+"|")==-1){%>
				<input type="checkbox" name="workflow_FM_t<%=wftypeid%>" value="workflow_FM_T<%=wftypeid%>" onclick="checkType9('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_FM_t<%=wftypeid%>" value="workflow_FM_T<%=wftypeid%>" onclick="checkType9('<%=wftypeid%>')" checked>
				<%}%></b>
			
			<%	} %>
				<ul><li><%=Util.toScreen(wfname,user.getLanguage())%><%=agentname%>
				<% if(selectArr.indexOf("W"+wfid+"|")==-1){%>
				<input type="checkbox" name="workflow_FM_w<%=wftypeid%>" value="workflow_FM_W<%=wfid%>" onclick="checkWorkflow9('<%=wftypeid%>')">
				<%} else {%>
				<input type="checkbox" name="workflow_FM_w<%=wftypeid%>" value="workflow_FM_W<%=wfid%>" onclick="checkWorkflow9('<%=wftypeid%>')" checked>
				<%}%></ul></li>
			<%
				}
				WorkflowComInfo.setTofirstRow();
			%>
				</ul></li></td></tr>
			</table>
			<%
				if(needtd==0){
					needtd=wftypetotal/2;
			%>
			</td><td width="50%" align=left valign=top>
			<%
				}
			}
			%>		
			</td>
		  </tr>
		</table>
		<script>
		function checkType9(id) {
			var mainchecked=eval("document.frmmain.workflow_FM_t"+id).checked ;
			var ary = eval("document.frmmain.workflow_FM_w"+id);
			if(ary!=undefined){
				if(ary.length==null) ary.checked= mainchecked ;
				else
				for(var i=0; i<ary.length; i++) {
					ary[i].checked= mainchecked ;
				}
			}
		}
		
		function checkWorkflow9(id) {
			var ary = eval("document.frmmain.workflow_FM_w"+id);
			var mainchecked = false;
			if(ary!=undefined){
				if(ary.length==null) mainchecked = ary.checked;
				else
					for(var i=0; i<ary.length; i++) {
						if(ary[i].checked){
							mainchecked = true;
							break;
						}
					}
			}
			if(mainchecked) eval("document.frmmain.workflow_FM_t"+id).checked=true;
			else eval("document.frmmain.workflow_FM_t"+id).checked=false;
		}				  	
		</script>
		</TD></TR>
	</TBODY>
</TABLE>
<%}%>

<%}else if("addcus".equals(type)){%>
<%-- 项目 新建客户      --%>
<TABLE class=ViewForm id="customSetting_10" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
		<!--
        <TR class=Title>
		  <TH colSpan=2><%//=SystemEnv.getHtmlLabelName(586,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing><TD class=Line1 colSpan=2></TD></TR>
		-->
		<TR><TD colSpan=2>
		</TD></TR>
		
	</TBODY>
</TABLE>


<%}else if("addproject".equals(type)){%>
<%-- 项目 新建项目 项目类型 --%>
<TABLE class=ViewForm id="customSetting_11" >
	<COLGROUP>
	<COL width="20%">
	<COL width="80%">
	<TBODY>
        <TR class=Title>
		  <TH colSpan=2><%=SystemEnv.getHtmlLabelName(586,user.getLanguage())%></TH>
		</TR>
		<TR class=Spacing style="height: 1px"><TD class=Line1 colSpan=2></TD></TR>
		<TR><TD>
		
		<%
			selectArr = "|";
			ArrayList projectColList = new ArrayList();
		
			int firstColNum = 0;
		    int totalProjectType = ProjectTypeComInfo.getProjectTypeNum();
		    if (totalProjectType%2==0)   firstColNum = totalProjectType/2;
		    else firstColNum = totalProjectType/2+1;
		      
		    int i=0;
		    while(ProjectTypeComInfo.next()){
		        String projectTypeId = ProjectTypeComInfo.getProjectTypeid();       
		        projectColList.add(projectTypeId);
		        i++;
		    }
		%>
		
		
            <TABLE width="100%">
            <colgroup>
            <col width="45%">
            <col width="10%">
            <col width="45%">
            <TR>
                <TD valign="top">
                    <TABLE  width="100%" valign="top">
                    <%
                    for (int j=0;j<projectColList.size();j++){
                    	String projectId = (String)projectColList.get(j);
                    %>
						<% if(j==projectColList.size()/2){ %>
                            </TABLE>
                        </TD>
                        <TD></TD>
                        <TD valign="top">
                            <TABLE width="100%" valign="top">
                        <% } %>
                    	<TR><TD>
                        <b><ul><li>
                           	<%=ProjectTypeComInfo.getProjectTypename(projectId)%>
                       		<input type="checkbox" name="project_p<%=projectId%>" value="project_P<%=projectId%>" <% if(selectArr.indexOf("P"+projectId+"|") != -1) out.print("checked"); %>>
                       	</li></ul></b>
                       	</TD></TR>
                    <% } %>
                    </TABLE>
                </TD>
            </TR>
            </TABLE>				
<%} else {}%>
