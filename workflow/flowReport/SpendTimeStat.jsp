<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="shareRights" class="weaver.workflow.report.UserShareRights" scope="page"/>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<jsp:useBean id="WorkFlowTransMethod" class="weaver.general.WorkFlowTransMethod" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<BODY>
<%
String imagefilename = "/images/hdReport.gif" ; 
String titlename = SystemEnv.getHtmlLabelName(19031 , user.getLanguage()) ; 
String needfav = "1" ;
String needhelp = "" ; 
String userRights=shareRights.getUserRights("-5",user);//�õ��û��鿴��Χ
       if (userRights.equals("-100")){
    response.sendRedirect("/notice/noright.jsp") ;
	return ;
    }
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%
    ArrayList wftypess=new ArrayList();

    int totalcount=0;
    String typeId=Util.null2String(request.getParameter("typeId"));//�õ���������
    String flowStatus=Util.null2String(request.getParameter("flowStatus"));
    String flowId=Util.null2String(request.getParameter("flowId"));//�õ���������
    String minTime=Util.null2String(request.getParameter("minTime"));
    String maxTime=Util.null2String(request.getParameter("maxTime"));//�õ���������
    String nodeType=Util.null2String(request.getParameter("nodetype"));//�õ���������
    
    String fromcredate = Util.null2String(request.getParameter("fromcredate"));//�õ�����ʱ����������
    String tocredate = Util.null2String(request.getParameter("tocredate"));//�õ�����ʱ����������
    int objType1 = Util.getIntValue(request.getParameter("objType"),0);//�õ�����ʱ����������
    String rhobjNames = Util.null2String(request.getParameter("rhobjNames"));
    String rhobjId = Util.null2String(request.getParameter("rhobjId"));
    
    String sqlCondition="";
    String sqlCondition1=""; 
    if(objType1 != 0 && !"".equals(rhobjId)){
	    switch (objType1){
	        case 1:
	        	sqlCondition =" and creater in (select id from hrmresource where id in ("+rhobjId+") )"  ;
	        break;
	        case 2:
	        	sqlCondition =" and creater in (select id from hrmresource where departmentid in ("+rhobjId+") )" ;
	        break;
	        case 3:
	        	sqlCondition =" and creater in (select id from hrmresource where subcompanyid1 in ("+rhobjId+") )" ;
	        break;
		}
    }
    if(!"".equals(fromcredate)){
    	sqlCondition += " and createdate >='" +fromcredate+ "'";
    }
    if(!"".equals(tocredate)) {
    	sqlCondition += " and createdate <='" +tocredate+ "'";
	}
    
    if (userRights.equals(""))
    {sqlCondition1 += " and exists (select 1 from hrmresource where id=workflow_currentoperator.userid and hrmresource.status in (0,1,2,3))";
    }
    else
    {sqlCondition1 += " and exists (select 1 from hrmresource where id=workflow_currentoperator.userid  and departmentid in ("+userRights+") and hrmresource.status in (0,1,2,3))";
    }    
    if (!typeId.equals("")&&!typeId.equals("0"))  sqlCondition1+=" and workflow_currentoperator.workflowtype="+typeId;
    sqlCondition += " and workflow_requestbase.workflowid>1 ";
    if (!flowId.equals(""))  sqlCondition+=" and workflow_requestbase.workflowid="+flowId;
    if (flowStatus.equals("1")) sqlCondition+=" and workflow_requestbase.currentnodetype<3 ";
    if (flowStatus.equals("2")) sqlCondition+=" and workflow_requestbase.currentnodetype=3 ";
    if (!nodeType.equals(""))  sqlCondition+=" and workflow_requestbase.currentnodetype='"+nodeType+"' ";
	 if (RecordSet.getDBType().equals("oracle")||RecordSet.getDBType().equals("db2"))
	 {
	if (!minTime.equals("")) sqlCondition+=" and 24*(to_date( NVL2(lastoperatedate ,lastoperatedate||' '|| NVL2(lastoperatetime,lastoperatetime,to_char(sysdate, 'HH24:MI:SS')),to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')) ,'YYYY-MM-DD HH24:MI:SS')"+
     "-to_date(createdate||' '||createtime,'YYYY-MM-DD HH24:MI:SS'))>"+minTime;
    if (!maxTime.equals("")) sqlCondition+=" and 24*(to_date( NVL2(lastoperatedate ,lastoperatedate||' '|| NVL2(lastoperatetime,lastoperatetime,to_char(sysdate, 'HH24:MI:SS')),to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')) ,'YYYY-MM-DD HH24:MI:SS')"+
     "-to_date(createdate||' '||createtime,'YYYY-MM-DD HH24:MI:SS'))<"+maxTime;
	 }
	 else
	 {
    if (!minTime.equals("")) sqlCondition+=" and 24*(convert(float,convert(datetime,isnull(lastoperatedate ,convert(char(10),getdate(),20)) +' '+isnull(lastoperatetime,convert(char(10),getdate(),108))))-convert(float,convert(datetime,createdate+' '+createtime)))>"+minTime;
    if (!maxTime.equals("")) sqlCondition+=" and 24*(convert(float,convert(datetime,isnull(lastoperatedate ,convert(char(10),getdate(),20)) +' '+isnull(lastoperatetime,convert(char(10),getdate(),108))))-convert(float,convert(datetime,createdate+' '+createtime)))<"+maxTime;
	 }
	
	int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);
    int	perpage=20;
	
    //out.print(sqlCondition);
%>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM id=frmMain name=frmMain action=SpendTimeStat.jsp method=post>
<input type="hidden" name="pagenum" value=''>
<!--��ѯ����-->
<table  class="viewform">
<tr>
    <td width="10%"><%=SystemEnv.getHtmlLabelName(15433,user.getLanguage())%></td>
    <td class=field width="30%">
	<input class=wuiBrowser type=hidden name="typeId" id="typeId" value="<%=typeId%>"
	_url="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkTypeBrowser.jsp"
	_displayText="<%=WorkTypeComInfo.getWorkTypename(""+typeId)%>"
	>
	
	
    <!-- select class=inputstyle name=typeId onchange="chageFlowType(this,flowIds,flowId)">
    <option value=""></option>
    <%
         while(WorkTypeComInfo.next()){
         if (!WorkTypeComInfo.getWorkTypeid().equals("1"))
         {
     	String checktmp = "";
     	if(typeId.equals(WorkTypeComInfo.getWorkTypeid()))
     		checktmp=" selected";
		%>
		<option value="<%=WorkTypeComInfo.getWorkTypeid()%>" <%=checktmp%>><%=WorkTypeComInfo.getWorkTypename()%></option>
		<%
		}
		}
		%>
		</select-->
		</td>
    
    <td width="10%"><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></td>
    <td class=field width="30%">
	    <BUTTON type="button" class=Browser onClick="onShow2('flowId','flowName')" name=showflow></BUTTON>
	    <SPAN id=flowName>
		<%=WorkflowComInfo.getWorkflowname(""+flowId)%>
		</SPAN>
	     <input type=hidden name="flowId" id="flowId" value="<%=flowId%>">
    
    <!-- select class=inputstyle name=flowId style="width:200">
    <option value=""></option>
    </select-->
    <!-- select class=inputstyle name=flowIds style="display:none">
    <%
    while(WorkflowComInfo.next()){
         
     	String tempFlow = WorkflowComInfo.getWorkflowid();
     	String tempType=WorkflowComInfo.getWorkflowtype(tempFlow);
     		
	%>
	<option value="<%=tempType+"$"+WorkflowComInfo.getWorkflowid()%>"><%=WorkflowComInfo.getWorkflowname()%></option>
	<%
	}
	
	%>
	</select-->
	</td>
	 <td width="10%"><%=SystemEnv.getHtmlLabelName(19061,user.getLanguage())%></td>
    <td width="10%" class=field><select name="flowStatus">
    <option></option>
    <option value="1" <%if (flowStatus.equals("1")) {%> selected<%}%>><%=SystemEnv.getHtmlLabelName(19062,user.getLanguage())%></option>
    <option value="2" <%if (flowStatus.equals("2")) {%> selected<%}%>><%=SystemEnv.getHtmlLabelName(1961,user.getLanguage())%></option>
    </select></td>
	</tr>
	<TR  style="height:1px" class=Separartor><TD class="Line" COLSPAN=6></TD></TR>
	
	<tr>
	 <td width="10%">
	    <select class=inputstyle  name=objType onchange="onChangeType()">
	    <option value="1" <%if (objType1==1) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1867,user.getLanguage())%></option>
	    <option value="2" <%if (objType1==2) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option>
	    <option value="3" <%if (objType1==3) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></option>
	    </select>
    </td>
    <td class=field width="30%">    
    <BUTTON type=button class=Browser <%if (objType1==2||objType1==3) {%>  style="display:none"  <%}%> onClick="onShowResource('rhobjId','rhobjName', 'rhobjNames')" name=showresource></BUTTON> 
	<BUTTON type=button class=Browser <%if (objType1==0||objType1==1||objType1==3) {%> style="display:none" <%}%>  onClick="onShowDepartment('rhobjId','rhobjName', 'rhobjNames')" name=showdepartment></BUTTON> 
    <BUTTON type=button class=Browser <%if (objType1==0||objType1==1||objType1==2) {%> style="display:none"  <%}%>  onclick="onShowBranch('rhobjId','rhobjName', 'rhobjNames')" name=showBranch></BUTTON>
	<SPAN id=rhobjName><%=rhobjNames%></SPAN>
	<input type=hidden name="rhobjId" id="rhobjId" value="<%=rhobjId%>">
	<input type=hidden name="rhobjNames" id="rhobjNames" value="<%=rhobjNames%>">
	</td>
	<td width="10%"><%=SystemEnv.getHtmlLabelName(1339,user.getLanguage())%></td>
    <td class=field width="40%">
    <BUTTON type=button class=calendar id=SelectDate1 onclick=getDate(fromcredatespan,fromcredate)></BUTTON>
	<SPAN id=fromcredatespan><%=fromcredate%></SPAN> 										
	&nbsp;- &nbsp;
	<BUTTON type=button class=calendar id=SelectDate2 onclick=getDate(tocredatespan,tocredate)></BUTTON>
	<SPAN id=tocredatespan><%=tocredate%></SPAN>
	<input type="hidden" name="fromcredate"  value="<%=fromcredate%>">
	<input type="hidden" name="tocredate"  value="<%=tocredate%>">
	</td>
	</tr>
	<TR  style="height:1px" class=Separartor><TD class="Line" COLSPAN=6></TD></TR>
	
	<tr>
	 <td width="10%"><%=SystemEnv.getHtmlLabelName(15536,user.getLanguage())%></td>
    <td class=field>
     <select class=inputstyle  size=1 name=nodetype style=width:100>
     	<option value="">&nbsp;</option>
     	<option value="0" <%if (nodeType.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%></option>
     	<option value="1" <%if (nodeType.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(142,user.getLanguage())%></option>
     	<option value="2" <%if (nodeType.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(725,user.getLanguage())%></option>
     	<option value="3" <%if (nodeType.equals("3")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%></option>
     </select>
    </td>
	<td colspan="4"><%=SystemEnv.getHtmlLabelName(19079,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%>
	<input class=inputstyle name="minTime" value="<%=minTime%>" size=8 onchange="checkint('minTime')"><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%>   <%=SystemEnv.getHtmlLabelName(19079,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%>
	<input class=inputstyle  name="maxTime" value="<%=maxTime%>"  size=8 onchange="checkint('maxTime')"><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%> 
	</td>
	</tr>
<TR  style="height:1px" class=Separartor><TD class="Line" COLSPAN=6></TD></TR>
</table>

<TABLE class=ListStyle cellspacing=1 >
<!--��ϸ�����ڴ�-->
  <COLGROUP> 
  <col width="20%"> 
  <col width="15%"> 
  <col width="40%"> 
  <col width="10%"> 
  <col width="10%"> 
  <col width="5%"> 
  <TR class=Header align=left>
  <TD><%=SystemEnv.getHtmlLabelName(16579,user.getLanguage())%></TD><!-- ��������-->
  <TD><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></TD><!--������-->
  <TD><%=SystemEnv.getHtmlLabelName(19060,user.getLanguage())%></TD><!--��������-->
  <TD><%=SystemEnv.getHtmlLabelName(1335,user.getLanguage())%></TD><!--��ǰ״��-->
  <TD><%=SystemEnv.getHtmlLabelName(16354,user.getLanguage())%></TD><!--δ������-->
  <TD><%=SystemEnv.getHtmlLabelName(19079,user.getLanguage())%></TD><!--��ʱ-->
  </TR>
  <%  boolean isLight = false ;
     boolean hasNextPage=false;
      char flag = Util.getSeparator() ;
      int totals=pagenum*perpage+1;
      if (RecordSet.getDBType().equals("oracle")||RecordSet.getDBType().equals("db2"))
	  {
		String sqls=" ( select * from (select  requestname,workflow_requestbase.requestid,workflow_requestbase.workflowid,status,24*(to_date( NVL2(lastoperatedate ,lastoperatedate||' '||lastoperatetime,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')) ,'YYYY-MM-DD HH24:MI:SS')"+
	     "-to_date(createdate||' '||createtime,'YYYY-MM-DD HH24:MI:SS')) as spends "+
		" from workflow_requestbase where  "+
		"  exists (select 1 from workflow_currentoperator where requestid=workflow_requestbase.requestid "+sqlCondition1+" ) and status is not null   "+sqlCondition+
		"  order by spends desc) where rownum<"+(totals+1)+" ) s ";
	     RecordSet.execute("select count(*) from "+sqls);
	      if (RecordSet.next()) totals=RecordSet.getInt(1);
	     
		  if(totals>0){
			hasNextPage=true;
		  }
		  RecordSet.execute("select * from (select * from (select * from "+sqls+" order by spends ) where rownum< "+(totals-(pagenum-1)*perpage+1)+" ) order by  spends desc");
	  }
	  else	  
	  {
     	RecordSet.executeProc("SpendTimeStat_count",sqlCondition1+flag+sqlCondition+flag+totals);
      	if (RecordSet.next()) totals=RecordSet.getInt(1);
		if(totals>0){
			hasNextPage=true;
			RecordSet.executeProc("SpendTimeStat_Get",sqlCondition1+flag+sqlCondition+flag+pagenum+flag+perpage+flag+totals) ;
		}
	  }
  %>
  		<%if(pagenum>1){%>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(1258,user.getLanguage())+",javascript:frmMain.prepage.click(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<button type=submit  style="display:none" class=btn accessKey=P id=prepage onclick="document.all('pagenum').value=<%=pagenum-1%>;"><U>P</U> - <%=SystemEnv.getHtmlLabelName(1258,user.getLanguage())%></button>
		<%}%>
		<%if(hasNextPage){%>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(1259,user.getLanguage())+",javascript:frmMain.nextpage.click(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<button type=submit style="display:none" class=btn accessKey=N  id=nextpage onclick="document.all('pagenum').value=<%=pagenum+1%>;"><U>N</U> - <%=SystemEnv.getHtmlLabelName(1259,user.getLanguage())%></button>
		<%}%>
  <%
	  while(RecordSet.next()){       
        String theworkflowid = Util.null2String(RecordSet.getString("workflowid")) ;        
        String requestName = Util.null2String(RecordSet.getString("requestname")) ;
        String tempStatus= Util.null2String(RecordSet.getString("status")) ;
		float spends = Util.getFloatValue(RecordSet.getString("spends"),0) ;
        if(WorkflowComInfo.getIsValid(theworkflowid).equals("1")){
        isLight = !isLight ; 
        String typeName=WorkTypeComInfo.getWorkTypename(WorkflowComInfo.getWorkflowtype(theworkflowid));
        String flowName=WorkflowComInfo.getWorkflowname(theworkflowid);
        String unopertstat = WorkFlowTransMethod.getUnOperatorsForStat(RecordSet.getString("requestid"));
 %>

 <tr class='<%=( isLight ? "datalight" : "datadark" )%>'>
<td><%=typeName%></td>
<td><%=flowName%></td>
<td><%=requestName%></td>
<td><%=tempStatus%></td>
<td><%=unopertstat%></td>
<td><%=Util.round(""+spends,1)%></td>
 </tr>
 <T style="height: 1px;"><TD  class=Line colspan="6" style="padding: 0px;"></TD></TR>
 <%
 
 }
 }%>
<!-- /TABLE>
</fieldset-->
<!--��ϸ���ݽ���-->

</td>
</tr>
</TABLE></FORM>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script>
  function chageFlowType(eventobj,list_obj,target_obj)
  {
	var oOption ;
	var tempstr = eventobj.value +"$";
	target_obj.options.length = 0 ;
	
	oOption = document.createElement("OPTION");
	oOption.text = "";
	oOption.value = "";
	target_obj.options.add(oOption);
	
	if (eventobj.value.length > 0)
	{
	for (var i=0; i< list_obj.options.length; i++)
	{
		if (list_obj.options(i).value.indexOf(tempstr)>=0)
		{
		oOption = document.createElement("OPTION");
		oOption.text=list_obj.options(i).text;
		oOption.value=list_obj.options(i).value.substr(list_obj.options(i).value.indexOf('$')+1,list_obj.options(i).value.length) ;
		target_obj.options.add(oOption);
		}
	
	 }
    }
  }
  
 function onChangeType(){
 
	thisvalue=document.frmMain.objType.value;
	$G("rhobjId").value="";
	$G("rhobjName").innerHTML ="";
	$G("rhobjNames").value = "";
	if(thisvalue==3){
 		$G("showBranch").style.display='';
	}
	else{
		$G("showBranch").style.display='none';
	}
	if(thisvalue==2){
 		$G("showdepartment").style.display='';
		
	}
	else{
		$G("showdepartment").style.display='none';
	}
	if(thisvalue==1){
 		$G("showresource").style.display='';
		
	}
	else{
		$G("showresource").style.display='none';
		
    }
	
}  
  
function submitData()
{
	document.frmMain.submit();
}
function onShowResource(inputename,tdname, tdnames){
	var ids = jQuery("#"+inputename).val();            
	var datas=null;
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��; 
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+ids);
    
    if (datas){
	    if (datas.id!= "" ){
	    	var ids=datas.id.slice(1).split(",");
	    	var names=datas.name.slice(1).split(",");
	    	var i=0;
	    	var strs="";
            for(i=0;i<ids.length;i++){
                strs=strs+"<a href=javaScript:openhrm("+ids[i]+"); onclick='pointerXY(event);'>"+names[i]+"</a>&nbsp";
            }
            jQuery("#"+tdnames).val(strs);
			jQuery("#"+tdname).html(strs);
			jQuery("#"+inputename).val(datas.id.slice(1));
			jQuery("#nameimage").html("");
		}
		else{
			jQuery("#"+tdnames).val("");
			jQuery("#"+tdname).html("");
			jQuery("#"+inputename).val("");
			jQuery("#nameimage").html("<IMG src='/images/BacoError.gif' align=absMiddle></IMg>");
			
		}
	}
}
function onShowDepartment(inputename,tdname, tdnames){
	var ids = jQuery("#"+inputename).val();            
	var datas=null;
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��; 
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser1.jsp?selectedids="+ids+"&selectedDepartmentIds="+ids);
    
    if (datas){
	    if (datas.id!= "" ){
	    	var ids=datas.id.slice(1).split(",");
	    	var names=datas.name.slice(1).split(",");
	    	var i=0;
	    	var strs="";
            for(i=0;i<ids.length;i++){
                strs=strs+"<a target='_blank' href=/hrm/company/HrmDepartmentDsp.jsp?id="+ids[i]+">"+names[i]+"</a>&nbsp";
            }
            jQuery("#"+tdnames).val(strs);
            jQuery("#"+tdname).html(strs);
			jQuery("#"+inputename).val(datas.id.slice(1));
			jQuery("#nameimage").html("");
		}
		else{
			jQuery("#"+tdnames).val("");
			jQuery("#"+tdname).html("");
			jQuery("#"+inputename).val("");
			jQuery("#nameimage").html("<IMG src='/images/BacoError.gif' align=absMiddle></IMg>");
			
		}
	}
}
function onShowBranch(inputename,tdname, tdnames){
	var ids = jQuery("#"+inputename).val();            
	var datas=null;
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //��ô��ڵ�ˮƽλ��; 
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="+ids+"&selectedDepartmentIds="+ids);
    
    if (datas){
	    if (datas.id!= "" ){
	    	var ids=datas.id.slice(1).split(",");
	    	var names=datas.name.slice(1).split(",");
	    	var i=0;
	    	var strs="";
            for(i=0;i<ids.length;i++){
                strs=strs+"<a target='_blank' href=/hrm/company/HrmSubCompanyDsp.jsp?id="+ids[i]+">"+names[i]+"</a>&nbsp";
            }
            jQuery("#"+tdnames).val(strs);
			jQuery("#"+tdname).html(strs);
			jQuery("#"+inputename).val(datas.id.slice(1));
			jQuery("#nameimage").html("");
		}
		else{
			jQuery("#"+tdnames).val("");
			jQuery("#"+tdname).html("");
			jQuery("#"+inputename).val("");
			jQuery("#nameimage").html("<IMG src='/images/BacoError.gif' align=absMiddle></IMg>");
			
		}
	}
}

function onShow2(inputename,showname){
   typeid=$G("typeId").value;
   results = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowTypeBrowser.jsp?typeid="+typeid)
   if (results){
        if (results.id!=""){
          $G(showname).innerHTML =results.name;
		  $G(inputename).value=results.id;
        }else{
		  $G(showname).innerHTML ="";
          $G(inputename).value="";
        }
   }
}

</script>


<SCRIPT language=VBS>
sub onShowDepartment1(inputename,showname)
    tmpids = document.all(inputename).value
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser1.jsp?selectedids="&document.all(inputename).value&"&selectedDepartmentIds="&tmpids)
   if (Not IsEmpty(id)) then
        if id(0)<> "" then
          resourceids = id(0)
          resourcename = id(1)
          sHtml = ""
          resourceids = Mid(resourceids,2,len(resourceids))         
          document.all(inputename).value= resourceids
          resourcename = Mid(resourcename,2,len(resourcename))
          while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href=/hrm/company/HrmDepartmentDsp.jsp?id="&curid&">"&curname&"</a>&nbsp"
          wend
          sHtml = sHtml&"<a href=/hrm/company/HrmDepartmentDsp.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
          document.all(showname).innerHtml = sHtml
		  document.all("rhobjNames").value=sHtml
        else
		  document.all(showname).innerHtml =""
          document.all(inputename).value=""
		  document.all("rhobjNames").value=""
         end if
         end if
end sub


sub onShowResource1(inputename,showname)
    tmpids = document.all(inputename).value
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
        if (Not IsEmpty(id1)) then
        if id1(0)<> "" then
          resourceids = id1(0)
          resourcename = id1(1)
          sHtml = ""          
          resourceids = Mid(resourceids,2,len(resourceids))      
          document.all(inputename).value= resourceids
          resourcename = Mid(resourcename,2,len(resourcename))
          while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href=javaScript:openhrm("&curid&"); onclick='pointerXY(event);'>"&curname&"</a>&nbsp"
          wend
          sHtml = sHtml&"<a href=javaScript:openhrm("&resourceids&"); onclick='pointerXY(event);'>"&resourcename&"</a>&nbsp"
          document.getElementById(showname).innerHtml = sHtml
          document.all("rhobjNames").value=sHtml
        else
          document.all(inputename).value=""
		  document.all(showname).innerHtml =""
		  document.all("rhobjNames").value=""
        end if
         end if
end sub
	
	
sub onShowBranch1(inputename,showname)
    tmpids = document.all(inputename).value
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="&document.all(inputename).value&"&selectedDepartmentIds="&tmpids)
		if (Not IsEmpty(id1)) then
        if id1(0)<> "" then
          resourceids = id1(0)
          resourcename = id1(1)
          sHtml = ""
          resourceids = Mid(resourceids,2,len(resourceids))
          document.all(inputename).value= resourceids
          resourcename = Mid(resourcename,2,len(resourcename))
          while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href=/hrm/company/HrmSubCompanyDsp.jsp?id="&curid&">"&curname&"</a>&nbsp"
          wend
          sHtml = sHtml&"<a href=/hrm/company/HrmSubCompanyDsp.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
          document.all(showname).innerHtml = sHtml
	      document.all("rhobjNames").value=sHtml
        else		
		  document.all(showname).innerHtml =""
          document.all(inputename).value=""
		  document.all("rhobjNames").value=""
        end if
         end if
end sub

sub onShow(inputename,showname)
   id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkTypeBrowser.jsp")
   if (Not IsEmpty(id)) then
        if id(0)<> "0" then

          document.all(showname).innerHtml = id(1)
		  document.all(inputename).value=id(0)
        else
		  document.all(showname).innerHtml =""
          document.all(inputename).value=""
         end if
		  document.all("flowName").innerHtml =""
          document.all("flowId").value="" 
         end if
end sub

sub onShow21(inputename,showname)
   typeid=document.all("typeId").value
   id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowTypeBrowser.jsp?typeid="&typeid)
   if (Not IsEmpty(id)) then
        if id(0)<> "" then

          document.all(showname).innerHtml = id(1)
		  document.all(inputename).value=id(0)
        else
		  document.all(showname).innerHtml =""
          document.all(inputename).value=""
         end if
         end if
end sub
</script>
</body>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>
