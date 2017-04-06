<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet_tmp" class="weaver.conn.RecordSet" scope="page"/>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WFManager" class="weaver.workflow.workflow.WFManager" scope="session"/>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="CustomerStatusComInfo" class="weaver.crm.Maint.CustomerStatusComInfo" scope="page" />
<jsp:useBean id="FormComInfo" class="weaver.workflow.form.FormComInfo" scope="page" />
<jsp:useBean id="BillComInfo" class="weaver.workflow.workflow.BillComInfo" scope="page" />
<jsp:useBean id="wfAddinOperateManager" class="weaver.workflow.workflow.WfAddinOperateManager" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="MainCCI" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SecCCI" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="SubCCI" class="weaver.docs.category.SubCategoryComInfo" scope="page" />


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">
</head>
<%
if(! HrmUserVarify.checkUserRight("SystemSetEdit:Edit", user)) { 
    response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(17688,user.getLanguage()) + ":" +SystemEnv.getHtmlLabelName(2118,user.getLanguage());

String needfav ="1";
String needhelp ="";

boolean isOracle = false;
if(RecordSet.getDBType().equalsIgnoreCase("oracle")){
	isOracle = true;
}
%>
<%
int pagepos=Util.getIntValue(Util.null2String(request.getParameter("pagepos")),1);
String twfname=Util.fromScreen(request.getParameter("wfname"),user.getLanguage());
String wfid=Util.fromScreen(request.getParameter("wfid"),user.getLanguage());
if(!"".equals(wfid)){
	twfname = WorkflowComInfo.getWorkflowname(wfid);
}
String wfids4excel = "";



boolean islight=true ;
int countsize = 0;
int pagesizes = 0;
int currentpagestart = 0;
int currentpageend = 0;
String sql = "select * from workflow_base where isvalid='1' " ;    
sql+= " order by workflowtype,id";
String sqlWhere = "";
if(!twfname.equals(""))
	sqlWhere+=" and wb.workflowname like '%"+Util.fromScreen2(twfname,7)+"%'" ; // 2012-09-07 ypc �޸�
if(!wfid.equals(""))
	sqlWhere+=" and wb.id ="+wfid ; // 2012-09-07 ypc �޸�
sql = "select count(*) from workflow_base wb where wb.isvalid='1' "+sqlWhere; // 2012-09-07 ypc �޸�
RecordSet.executeSql(sql);
if(RecordSet.next())
{
	countsize = RecordSet.getInt(1);
}
pagesizes = countsize%10==0?countsize/10:(countsize/10+1);
if(pagepos<=0)
{
	pagepos = 1;
}
if(pagepos>=pagesizes)
{
	pagepos = pagesizes;
}
currentpagestart = (pagepos-1)*10<0?0:(pagepos-1)*10;
currentpageend = (pagepos*10>countsize)?countsize:pagepos*10;
int currentpagesize = currentpageend-currentpagestart;
if(RecordSet.getDBType().equals("oracle"))
{
//2012-09-07 ypc �޸Ĵ�Sql���
	sql = "select * "+
		  "	  from (select rownum as rowno, r.* "+
		  "	          from (select wb.*,wc.isUse from workflow_base wb left join workflow_Code wc on wb.formid = wc.formId where wb.isvalid='1' "+sqlWhere+" order by wb.workflowtype,wb.id) r) c "+
		  "	 where c.rowno <= "+currentpageend+
		  "	   and c.rowno > "+currentpagestart;
}
else
{
//2012-09-07 ypc �޸Ĵ�Sql���
	sql = "select top "+currentpagesize+" c.* "+
		  "	  from (select top "+currentpagesize+" r.* "+
		  "	          from (select top "+currentpageend+" wb.*,wc.isUse "+
		  "	                  from workflow_base wb left join workflow_Code wc on wb.formid = wc.formId"+
		  "	                 where wb.isvalid = '1' "+sqlWhere+
		  "	                 order by wb.workflowtype asc,wb.id asc) r "+
		  "	         order by r.workflowtype desc, r.id desc) c "+
		  "	 order by c.workflowtype asc, c.id asc";
}
//out.println(sql);
String tmpsql="" ;
RecordSet.executeSql(sql);

%>
<BODY>
    <%@ include file="/systeminfo/TopTitle.jsp" %>
    <%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(RecordSet.getCounts() > 0){
	RCMenu += "{" + "Excel,javascript:exportXSL(),_self} ";
	RCMenuHeight += RCMenuHeightStep;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",javascript:doSearchAgain(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;	
RCMenu += "{"+SystemEnv.getHtmlLabelName(309,user.getLanguage())+",javascript:doClose(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

    <%@ include file="/systeminfo/RightClickMenu.jsp" %>

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
			
			<TABLE class="Shadow">
			<tr>
			<td valign="top">
			
<form action="basedata_workflow.jsp" method="post" name="frmmain">
<INPUT type="hidden" name=pagepos value="">
<table class=form>
  <tr>
    <td width="15%"><%=SystemEnv.getHtmlLabelName(2079,user.getLanguage())%></td>
    <td width="35%" class=field>
    <INPUT class=saveHistory type=text name=wfname style="width:80%" value=<%=twfname%>>
    </td>
</table>
</form>

<br>
<TABLE class=ListStyle cellspacing=1>
  <TR class=Header >
    <TH colspan="4"><%=SystemEnv.getHtmlLabelName(15069,user.getLanguage())%></TH>
  </TR>
</TABLE>

<TABLE class=ListStyle cellspacing=1>
  <TBODY>
<%

while(RecordSet.next()){
    String workflowname=RecordSet.getString("workflowname");
    String workflowid=RecordSet.getString("id");
    String isbill=RecordSet.getString("isbill");
    String needmark=RecordSet.getString("isUse");
    String formid=RecordSet.getString("formid");
    String messageType=RecordSet.getString("messageType");
    String multiSubmit=RecordSet.getString("multiSubmit");
    String defaultName=RecordSet.getString("defaultName");
    String docPath=RecordSet.getString("docPath");
    String helpdocid=RecordSet.getString("helpdocid");
    
    //ypc 2012-09-17 ���
    String isimportwf = RecordSet.getString("isimportwf"); //�½�ʱ�Ƿ�ɵ�������
    String isrejectremind=RecordSet.getString("isrejectremind");//�˻��Ƿ�����
    String ischangrejectnode =RecordSet.getString("ischangrejectnode"); //�˻����Ƿ���������ѽڵ�
    String issignview = RecordSet.getString("issignview");//��������������ʾ��1������ʾ��
    String isImportDetail=RecordSet.getString("isImportDetail");//�Ƿ񴴽��ڵ���Ե�����ϸ������
    String IsSelectrejectNode=RecordSet.getString("IsSelectrejectNode");//�Ƿ�������˵�����ڵ�
    String nosynfields = RecordSet.getString("nosynfields"); //����Ҫͬ�����ֶ��б�
    String newdocpath = RecordSet.getString("newdocpath"); //�ĵ��½�Ŀ¼
    String bill = RecordSet.getString("isbill");
    wfids4excel += (workflowid+",");
    String SAPSource = RecordSet.getString("SAPSource"); //sap����Դ
    
    //����ͬ���ֶ� start ypc 2012-09-19 ���
    String Sql = "";
    String fieldlablename = "";
    if(bill.equals("0")){//�� ypc2012-09-19
    	Sql+="select DISTINCT fieldlable from workflow_fieldlable wf inner join workflow_formfield wfl on wf.fieldid=wfl.fieldid  where wfl.fieldid in("+nosynfields+") and wf.formid="+formid+"";
	}else if(bill.equals("1")){//����
		Sql +="select id as fieldid,fieldlabel,viewtype as isdetail,dsporder as fieldorder, viewtype as isdetail from workflow_billfield where billid="+formid+" and id in("+nosynfields+")";
	}
    RecordSet.execute(Sql);
    while(RecordSet.next()){
    	if(bill.equals("1")){//�����޷����ֶ�������Ϊ��ѯ��������������д���
			fieldlablename += SystemEnv.getHtmlLabelName(RecordSet.getInt("fieldlabel"),user.getLanguage())+",";
		}else{
			fieldlablename += Util.null2String(RecordSet.getString("fieldlable"))+",";
		}
    }
    //����ͬ���ֶ� end ypc 2012-09-19 ���
    //�ĵ��½�Ŀ¼ start ypc 2012-09-19 ���
    	String newdocpathspan ="";
    	if(newdocpath!=null && !newdocpath.equals("")){
    	      String _temp1 = newdocpath.substring(0,newdocpath.indexOf(','));
    	      String _temp2 = newdocpath.substring(newdocpath.indexOf(',')+1,newdocpath.lastIndexOf(','));
    	      String _temp3 = newdocpath.substring(newdocpath.lastIndexOf(',')+1,newdocpath.length());
    	      String tempName = SubCCI.getSubCategoryname(_temp2);
    	      tempName = tempName.replaceAll("&lt;", "��").replaceAll("&gt;", "��").replaceAll("<", "��").replaceAll(">", "��");
    	      if(!_temp1.equals(""))
    	      newdocpathspan = "/"+MainCCI.getMainCategoryname(_temp1)+"/"+tempName+"/"+SecCCI.getSecCategoryname(_temp3);
    	    }
    //�ĵ��½�Ŀ¼ end ypc 2012-09-19 ���
%>
  <tr> 
    <TD>
    <TABLE class=ListStyle cellspacing=1>
    <colgroup>
    <col width="5%"><col width="10%">
    <col width="5%"><col width="10%">
    <col width="5%"><col width="5%">
    <col width="5%"><col width="5%">
    <col width="5%"><col width="5%">
    <col width="5%"><col width="5%">
	<col width="5%"><col width="10%">
	<col width="5%"><col width="10%">
    <tr class=Header>
        <td><%=SystemEnv.getHtmlLabelName(2079,user.getLanguage())%></td>
        <td class=field><b><%=workflowname%></b></td>
		<%      
		if(isbill.equals("0"))
		{
	    %>
        <td><%=SystemEnv.getHtmlLabelName(700,user.getLanguage())%></td>
        <td class=field><b><%=FormComInfo.getFormname(""+formid)%></b></td>
		<%      
		}
		else
		{
	        int labelid = Util.getIntValue(BillComInfo.getBillLabel(""+formid));
	    %>
        <td><%=SystemEnv.getHtmlLabelName(15590,user.getLanguage())%></td>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(labelid,user.getLanguage())%></b></td>

		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(18167,user.getLanguage())%></td><!-- ģ��ѡ�� -->
		<%      
			int typeid = -1;
			int templateid = -1;
			String wfname = "";
			String iscust = "";
			String mailMessageType = "";
			String isaffirmance = "";
			String isforwardrights = "";
			String isShowChart = "";
			String isModifyLog = "";
			String orderbytype = "";
			String wfdocpath = "";
			String wfdocpathspan = "";
			String wfdocowner = "";
			String wfdocownerspan = "";
			String candelacc = "";
			String docRightByOperator="";
			int docRightByHrmResource = -1;
			String ShowDelButtonByReject = "";
			int subCompanyId2 = -1 ;//add by wjy
			String wfdes="";
			String isSignDoc = "";
			String showDocTab = "";
			String isSignWorkflow = "";
			String showWorkflowTab = "";
			String isannexUpload = "";
			String annexmaincategory = "";
			String annexsubcategory= "";
			String annexseccategory= "";
			String annexdocPath = "";
			String showUploadTab = "";
			String isneeddelacc="";
			if(!workflowid.equals(""))
			{
				WFManager.setWfid(Util.getIntValue(workflowid,-1));
				WFManager.getWfInfo();
				wfname=WFManager.getWfname();
			    templateid=WFManager.getTemplateid();
			    isbill = WFManager.getIsBill();
			    typeid=WFManager.getTypeid();
			    iscust = WFManager.getIsCust();
			    mailMessageType=WFManager.getMailMessageType();
			    isaffirmance=WFManager.getIsaffirmance();
			    isforwardrights=WFManager.getIsforwardRights();
			    isShowChart = WFManager.getIsShowChart();
			    isModifyLog = WFManager.getIsModifyLog();
			    orderbytype = WFManager.getOrderbytype();
			    wfdocpath = WFManager.getWfdocpath();
			    isneeddelacc=WFManager.getIsneeddelacc();
			    if(wfdocpath!=null && !wfdocpath.equals("")){
			        String _temp1 = wfdocpath.substring(0,wfdocpath.indexOf(','));
			        String _temp2 = wfdocpath.substring(wfdocpath.indexOf(',')+1,wfdocpath.lastIndexOf(','));
			        String _temp3 = wfdocpath.substring(wfdocpath.lastIndexOf(',')+1,wfdocpath.length());
			        if(!_temp1.equals(""))
			        wfdocpathspan="/"+MainCCI.getMainCategoryname(_temp1)+"/"+SubCCI.getSubCategoryname(_temp2)+"/"+SecCCI.getSecCategoryname(_temp3);
			    }
			    wfdocowner = WFManager.getWfdocowner();
			    wfdocownerspan = ResourceComInfo.getLastname(wfdocowner);
			    candelacc = WFManager.getCanDelAcc();//�Ƿ���������ɾ������
			    docRightByOperator=WFManager.getDocRightByOperator();
			    docRightByHrmResource = WFManager.getDocRightByHrmResource();
			    ShowDelButtonByReject = WFManager.getShowDelButtonByReject();
			    subCompanyId2 = WFManager.getSubCompanyId2() ;//add by wjy
			    wfdes=WFManager.getWfdes();
			    isSignDoc=WFManager.getSignDoc();
			    showDocTab=WFManager.getShowDocTab();
			    isSignWorkflow=WFManager.getSignWorkflow();
			    showWorkflowTab=WFManager.getShowWorkflowTab();
			    isannexUpload=WFManager.getIsAnnexUpload();
			    String tempannexcategory=WFManager.getAnnexDocCategory();
			    if(tempannexcategory!=null && !tempannexcategory.equals("")){
			        annexmaincategory=tempannexcategory.substring(0,tempannexcategory.indexOf(','));
			        annexsubcategory=tempannexcategory.substring(tempannexcategory.indexOf(',')+1,tempannexcategory.lastIndexOf(','));
			        annexseccategory=tempannexcategory.substring(tempannexcategory.lastIndexOf(',')+1,tempannexcategory.length());
			        if(!annexmaincategory.equals(""))
			        annexdocPath="/"+MainCCI.getMainCategoryname(annexmaincategory)+"/"+SubCCI.getSubCategoryname(annexsubcategory)+"/"+SecCCI.getSecCategoryname(annexseccategory);
			    }
			    showUploadTab=WFManager.getShowUploadTab();
			    String templatename = "";
			    if(templateid>0)
			    {
			        WFManager.reset();
			        WFManager.setWfid(templateid);
			    	WFManager.getWfInfo();
			    	templatename=WFManager.getWfname();
			    }

			    tempannexcategory=WFManager.getDocCategory();
			    if(tempannexcategory!=null && !tempannexcategory.equals("")){
			        annexmaincategory=tempannexcategory.substring(0,tempannexcategory.indexOf(','));
			        annexsubcategory=tempannexcategory.substring(tempannexcategory.indexOf(',')+1,tempannexcategory.lastIndexOf(','));
			        annexseccategory=tempannexcategory.substring(tempannexcategory.lastIndexOf(',')+1,tempannexcategory.length());
			        if(!annexmaincategory.equals(""))
			        	docPath="/"+MainCCI.getMainCategoryname(annexmaincategory)+"/"+SubCCI.getSubCategoryname(annexsubcategory)+"/"+SecCCI.getSecCategoryname(annexseccategory);
			    }
		%>
        <td class=field><b><%=templatename%></b></td>
		<%      
			}
		%>
        <td><%=SystemEnv.getHtmlLabelName(15433,user.getLanguage())%></td><!-- ���������� -->
        <td class=field><b><%=WorkTypeComInfo.getWorkTypename(""+typeid)%></b></td>
        <td><%=SystemEnv.getHtmlLabelName(15588,user.getLanguage())%></td><!-- �Ƿ��Ż���� -->
		<%      
		if(iscust.equals("0"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(15589,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(15554,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(17582,user.getLanguage())%></td><!-- �Ƿ�������� -->
		<%      
		if(messageType.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
    	%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(17995,user.getLanguage())%></td><!-- �Ƿ��ʼ����� -->
		<%      
		if(mailMessageType.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
    	%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(17601,user.getLanguage())%></td><!-- �Ƿ������ύ -->
		<%      
		if(multiSubmit.equals("1"))
		{
    	%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
    	%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
    </tr>
    <tr class=Header>
        <td><%=SystemEnv.getHtmlLabelName(17606,user.getLanguage())%></td><!-- �Ƿ�Ĭ��˵�� -->
		<%      
		if(defaultName.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(19649,user.getLanguage())%></td><!-- �Ƿ���Ҫȷ�� -->
		<%      
		if(isaffirmance.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(22576,user.getLanguage())%></td><!-- �Ƿ�����ת�������ñ�ת����Ȩ�� -->
		<%      
		if(isforwardrights.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>
		<td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}
		%>
        <td><%=SystemEnv.getHtmlLabelName(21574,user.getLanguage())%></td><!-- �ύ���̺��Ƿ���ʾ����ͼ -->
		<%      
		if(isShowChart.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(21681,user.getLanguage())%></td><!-- �Ƿ��¼���޸���־ -->
		<%      
		if(isModifyLog.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(21603,user.getLanguage())%></td><!-- �������������ʾģʽ -->
		<%      
		if(orderbytype.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(21604,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(21605,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(22220,user.getLanguage())%></td><!-- ���̱���Ϊ�ĵ��Ĵ��·�� -->
        <td class=field><b><%=wfdocpathspan%></b></td>
        <td class=field><%=SystemEnv.getHtmlLabelName(22221,user.getLanguage())%></td><!-- ���̱���Ϊ�ĵ��������� -->
        <td class=field><b><%=wfdocownerspan%></b></td>
    </tr>
    <tr class=Header>
        <td><%=SystemEnv.getHtmlLabelName(156,user.getLanguage())+SystemEnv.getHtmlLabelName(92,user.getLanguage())%></td><!-- �����ϴ�Ŀ¼ -->
        <td class=field><b><%=docPath%></b></td>
        <td><%=SystemEnv.getHtmlLabelName(22944,user.getLanguage())%></td><!-- �Ƿ���������ɾ������ -->
		<%
		if(candelacc.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(18011,user.getLanguage())%></td><!-- �Ƿ�����ĵ������˸�Ȩ -->
		<%      
		if(docRightByOperator.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>
		<td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}
		%>
        <td><%=SystemEnv.getHtmlLabelName(19321,user.getLanguage())%></td><!-- ��������Դ�����ֶθ�Ȩ -->
		<%      
		if(docRightByHrmResource==1)
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(22267,user.getLanguage())%></td><!-- �˻ش����ڵ��Ƿ��ɾ�� -->
		<%      
		if(ShowDelButtonByReject.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td class=field><%=SystemEnv.getHtmlLabelName(15593,user.getLanguage())%></td><!-- �����ĵ� -->
        <td class=field><b><%=Util.toScreen(DocComInfo.getDocname(""+helpdocid),user.getLanguage())%></b></td>
        <td class=field><%=SystemEnv.getHtmlLabelName(17868,user.getLanguage())%></td><!-- �������� -->
        <td class=field><b><%=SubCompanyComInfo.getSubCompanyname(String.valueOf(subCompanyId2))%></b></td>
        <td class=field><%=SystemEnv.getHtmlLabelName(15594,user.getLanguage())%></td><!-- ���������� -->
        <td class=field><b><%=wfdes%></b></td>
    </tr>
    <tr class=Header>
        <td><%=SystemEnv.getHtmlLabelName(23726,user.getLanguage())%></td><!-- �Ƿ�����ǩ����������ĵ� -->
        <%
		if(isSignDoc.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(23728,user.getLanguage())%></td><!-- �Ƿ���ʾ����ĵ�ѡ� -->
		<%
		if(showDocTab.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(23727,user.getLanguage())%></td><!-- �Ƿ�����ǩ������������� -->
		<%      
		if(isSignWorkflow.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>
		<td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}
		%>
        <td><%=SystemEnv.getHtmlLabelName(23729,user.getLanguage())%></td><!-- �Ƿ���ʾ�������ѡ� -->
		<%      
		if(showWorkflowTab.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td><%=SystemEnv.getHtmlLabelName(21417,user.getLanguage())%></td><!-- �Ƿ�����ǩ������ϴ����� -->
		<%      
		if(isannexUpload.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td class=field><%=SystemEnv.getHtmlLabelName(21418,user.getLanguage())%></td><!-- ǩ����������ϴ�Ŀ¼ -->
        <td class=field><b><%=annexdocPath%></b></td>
        <td><%=SystemEnv.getHtmlLabelName(23725,user.getLanguage())%></td><!-- �Ƿ���ʾ��ظ���ѡ� -->
        <%      
		if(showUploadTab.equals("1"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
		<%
		  String status= "";
		  String frequencyt= "";
		  String dateType= "";
		  String timeSet= "";
		  String dateSum= "";
		  String alertType= "";
		  RecordSet2.execute("select * from WorkFlowPlanSet where flowid="+workflowid);
		  if(RecordSet2.next())
		  {
			  status=RecordSet2.getString("status");
			  frequencyt=RecordSet2.getString("frequencyt");
			  dateType=RecordSet2.getString("dateType");
			  timeSet=RecordSet2.getString("timeSet");
			  dateSum=RecordSet2.getString("dateSum");
			  alertType=RecordSet2.getString("alertType");
		  }
		  %>
        <td class=field><%=SystemEnv.getHtmlLabelName(18095,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18812,user.getLanguage())%></td><!-- �������̼ƻ�  -->
        <%      
		if(status.equals("0"))
		{
        %>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
        %>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
    </tr>
    <tr class=Header>
        <td><%=SystemEnv.getHtmlLabelName(15592,user.getLanguage())%></td><!-- �Ƿ��� -->
        <%
		if(needmark.equals("1"))
		{
		%>
        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
		<%      
		}
		else
		{
		%>  
        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
		<%      
		}       
		%>
        <td class=field><%=SystemEnv.getHtmlLabelName(28571,user.getLanguage())%></td>
        <td class=field>
        	<b>
        	<%=isneeddelacc.equals("1")?SystemEnv.getHtmlLabelName(163,user.getLanguage()):SystemEnv.getHtmlLabelName(161,user.getLanguage())%>
        	</b>
        </td>
        <!-- 2012-09-2-17 ypc ��� -->
          
          <!-- �������ڵ㵼����ϸ -->
          <td class=field><%=SystemEnv.getHtmlLabelName(26254,user.getLanguage())%></td>
          <%if(isImportDetail.equals("1")){ %>
          		 <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{ %>
          		 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%} %>
          
          <!-- �˻��Ƿ����� -->
          <td class=field><%=SystemEnv.getHtmlLabelName(24447,user.getLanguage())%></td>
          <%if(isrejectremind.equals("1")){%>
          		 <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{%>
          		 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%}%>
          
          <!-- �˻�ʱ�Ƿ���������ѽڵ�  -->
           <td class=field><%=SystemEnv.getHtmlLabelName(24448,user.getLanguage())%></td>
          <%if(ischangrejectnode.equals("1")){ %>
          		<td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{ %>
          	 	 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%} %>
          
          <!-- �˻�ʱ�Ƿ��ѡ���˻ؽڵ�  -->
           <td class=field><%=SystemEnv.getHtmlLabelName(26435,user.getLanguage())%></td>
          <%if(IsSelectrejectNode.equals("1")){ %>
          		<td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{ %>
          	 	 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%} %>
          
           <!-- �½�ʱ�Ƿ�ɵ�������  -->
           <td class=field><%=SystemEnv.getHtmlLabelName(24269,user.getLanguage())%></td>
          <%if(isimportwf.equals("1")){ %>
          		<td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{ %>
          	 	 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%} %>
     	  <!-- ��������������ʾ  -->
          <td class=field><%=SystemEnv.getHtmlLabelName(26370,user.getLanguage())%></td>
          <%if(issignview.equals("1")){ %>
          		<td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><b></td>
          <%}else{ %>
          	 	 <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
          <%} %>
    </tr>
    
    <tr class=Header>
          <!-- ����ͬ���ֶ�  -->
          <td class=field><%=SystemEnv.getHtmlLabelName(28064,user.getLanguage())%></td>
          <%if(!fieldlablename.equals("")){ %>
          		<td class=field><b><%=fieldlablename%><b></td>
          <%}else{ %>
          	 	 <td class=field><b></b></td>
          <%} %>
          <!-- �ĵ��½�Ŀ¼  -->
          <td class=field><%=SystemEnv.getHtmlLabelName(24621,user.getLanguage())%></td>
          <%if(!newdocpathspan.equals("")){ %>
          		<td class=field><b><%=newdocpathspan%><b></td>
          <%}else{ %>
          	 	 <td class=field><b></b></td>
          <%} %>
          <!-- SAP����Դ -->
    	<td class=field>
    	SAP<%=SystemEnv.getHtmlLabelName(18076,user.getLanguage())%>
    	</td>
    	<td class=field><%=SAPSource%></td>
    	<td class=field></td>
    	<td class=field></td>
    	<td class=field></td>
    	<td class=field></td>
    	<td class=field></td>
    	<td class=field></td>
    </tr>
    </table>

	<TABLE class=ListStyle cellspacing=1>
        <colgroup>
        <col width="7%">
        <col width="7%">
        <col width="28%">
        <col width="14%">
        <col width="14%">
        <col width="5%">
        <col width="5%">
        <tr class=header>
            <td colSpan="8"><%=SystemEnv.getHtmlLabelName(15615,user.getLanguage())%></td><!-- �ڵ���Ϣ -->
        </tr>
        <tr class=header>
            <td><%=SystemEnv.getHtmlLabelName(15070,user.getLanguage())%>(<%=SystemEnv.getHtmlLabelName(15536,user.getLanguage())%>)</td><!-- �ڵ�����(�ڵ�����) -->
            <td><%=SystemEnv.getHtmlLabelName(15072,user.getLanguage())%></td><!-- ������ -->
            <td><%=SystemEnv.getHtmlLabelName(15073,user.getLanguage())%>(<%=SystemEnv.getHtmlLabelName(17892,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%>)</td><!-- �����鶨�� --><!-- �������� -->
            <td><%=SystemEnv.getHtmlLabelName(18009,user.getLanguage())%></td><!-- �ڵ�ǰ���Ӳ��� -->
            <td><%=SystemEnv.getHtmlLabelName(18010,user.getLanguage())%></td><!-- �ڵ�󸽼Ӳ��� -->
            <td><%=SystemEnv.getHtmlLabelName(18359,user.getLanguage())%></td><!-- ǿ���ջ� -->
            <td><%=SystemEnv.getHtmlLabelName(18360,user.getLanguage())%></td><!-- ǿ�ƹ鵵 -->
        </tr>
		<tr class=header>
            <td colSpan="7"><%=SystemEnv.getHtmlLabelName(21393,user.getLanguage())%></td><!-- �ڵ�����-->
        </tr>
        <%
        boolean changeclass = false;
		String sv = "";
		String dv = "";
		String zc = "";
		String mc = "";
		String fw = "";
		String rb = "";
		String ov = "";
		
		RecordSet2.executeSql("select * from workflow_function_manage where workflowid = " + workflowid + " and operatortype = -1");
		if(RecordSet2.next()){
			sv = RecordSet2.getString("typeview");
			dv = RecordSet2.getString("dataview");
			zc = RecordSet2.getString("automatism");
			mc = RecordSet2.getString("manual");
			fw = RecordSet2.getString("transmit");
			rb = RecordSet2.getString("retract");
			ov = RecordSet2.getString("pigeonhole");
		}
		String trclass = changeclass?"DataDark":"DataLight";
        changeclass = changeclass?false:true;
		%>
		<tr class=<%=trclass %>>
            <td  height="23"><%=SystemEnv.getHtmlLabelName(16758,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(1867,user.getLanguage())%></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <%      
			if(rb.equals("1"))
			{
			%>  
	        <td class=field><%=SystemEnv.getHtmlLabelName(18365,user.getLanguage())%></td>
			<%      
			}
			else if(rb.equals("2"))
			{
			%>  
	        <td class=field><%=SystemEnv.getHtmlLabelName(18366,user.getLanguage())%></td>
			<%      
			}
			else
			{
			%>
			<td class=field><%=SystemEnv.getHtmlLabelName(18364,user.getLanguage())%></td>
			<%
			}
			%>
            <%      
			if(ov.equals("1"))
			{
	        %>
	        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
			<%      
			}
			else
			{
	        %>  
	        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
			<%      
			}       
			%>
        </tr>
<%
        ArrayList nodeids=new ArrayList () ;
        ArrayList nodenames=new ArrayList () ;
        ArrayList nodetypes=new ArrayList();
        tmpsql="select w1.nodeid,w2.nodename,w1.nodetype from workflow_flownode w1,workflow_nodebase w2 where (w2.IsFreeNode is null or w2.IsFreeNode!='1') and w1.nodeid=w2.id and w1.workflowid="+ workflowid +" order by w1.nodeid " ;
        rs.executeSql(tmpsql) ;
        while(rs.next()){
            String nodeid=rs.getString("nodeid");
            nodeids.add(nodeid) ;
            nodenames.add(rs.getString("nodename"));
            nodetypes.add(rs.getString("nodetype"));
        }
        
        for(int i=0; i<nodeids.size() ;i++){
            String nodeid = Util.null2String((String) nodeids.get(i));
            String nodename = Util.null2String((String) nodenames.get(i));
            trclass = changeclass?"DataDark":"DataLight";
            changeclass = changeclass?false:true;
            String nodetype = Util.null2String((String) nodetypes.get(i));
            String nodetypeStr = "";
            if("0".equals(nodetype)){
            	nodetype = SystemEnv.getHtmlLabelName(125,user.getLanguage());
            }else if("1".equals(nodetype)){
            	nodetype = SystemEnv.getHtmlLabelName(142,user.getLanguage());
            }else if("2".equals(nodetype)){
            	nodetype = SystemEnv.getHtmlLabelName(615,user.getLanguage());
            }else if("3".equals(nodetype)){
            	nodetype = SystemEnv.getHtmlLabelName(251,user.getLanguage());
            }
%>
		<tr class=<%=trclass %>>
			<td><%=nodename%>&nbsp;(<%=nodetype%>)</td>
<%
            ArrayList groupids=new ArrayList() ;
            ArrayList groupnames=new ArrayList() ;
            String groupname="" ;
            String groupdesc="" ;
            tmpsql="select id,groupname from workflow_nodegroup where nodeid="+nodeid;
            rs.executeSql(tmpsql) ;

            while(rs.next()){
                groupids.add(rs.getString("id")) ;
                groupnames.add(rs.getString("groupname")) ;
            }
		%>
		<td colspan="2">
		<table class="viewform" style="width:100%;height:100%">
		<colgroup>
        <col width="20%">
        <col width="80%">
		<%
            for(int j=0; j<groupids.size(); j++){
            	String bottomStyle = "";
            	if(j<(groupids.size()-1)){
            		bottomStyle = "border-bottom:1px solid #C1DAD7;";
            	}
                groupname=(String)groupnames.get(j);
				out.println("<tr>\n");
				out.println("<td style=\"border-right:1px solid #C1DAD7;"+bottomStyle+"\">"+groupname+"</td>\n");
                String tmpgroupid=(String) groupids.get(j);
                tmpsql="select * from workflow_groupdetail where groupid="+tmpgroupid ;
                rs.executeSql(tmpsql);
                String tmpdesc="" ;
                groupdesc = "";
                while(rs.next()){
                    int type=rs.getInt("type") ;
                    String objid=rs.getString("objid") ;
                    int level=rs.getInt("level_n");
                    int level2_n=rs.getInt("level2_n");
                    String signorder=rs.getString("signorder");
                    String conditioncn = Util.null2String(rs.getString("conditioncn"));
                    String nodename2 = "";
								    int nodeidindex = nodeids.indexOf(""+objid);
								    if( nodeidindex != -1 ) nodename2 = (String) nodenames.get(nodeidindex);
								    
					String tmpName="";
					String tmpCase2Rolesmark="";
								    
                    switch(type){
                        //���� + ��ȫ����   ĳһ���Ű�ȫ������ڵ����趨ֵ��������Դ
                        case 1:
                        case 22:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(124,user.getLanguage()) +"-"+DepartmentComInfo.getDepartmentname(objid);
                            break;
                        case 2:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(122,user.getLanguage()) +"-";                            
                            /*ԭʼ�߼� ������̽ڵ������Ϊ��ɫʱ���������ʾ��ɫ˵�����ǽ�ɫ����
                            tmpdesc+="<a href='basedata_role.jsp?roleid="+objid+"'>"+RolesComInfo.getRolesname(""+objid)+"</a>-";
                            */
                            RecordSet_tmp.executeSql("select rolesmark from hrmroles where id = "+objid);
                            if(RecordSet_tmp.next()){
                            	tmpCase2Rolesmark=RecordSet_tmp.getString("rolesmark");
                            }else{
                            	tmpCase2Rolesmark=RolesComInfo.getRolesname(""+objid);
                            }
                            tmpdesc+="<a href='basedata_role.jsp?roleid="+objid+"'>"+tmpCase2Rolesmark+"</a>-";
                            
                            if(level==0) tmpdesc+= SystemEnv.getHtmlLabelName(124,user.getLanguage()) ;
                            if(level==1) tmpdesc+= SystemEnv.getHtmlLabelName(141,user.getLanguage()) ;
                            if(level==2) tmpdesc+= SystemEnv.getHtmlLabelName(140,user.getLanguage()) ;
                            break;
                        case 3:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(179,user.getLanguage()) +"-";              
                            tmpdesc+=ResourceComInfo.getResourcename(""+objid);
                            break;
                        case 5:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15555,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1 or workflow_formdict.type=17) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";      // ������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1 or type=17) " +
															  " and id = "+objid+" ";
														RecordSet2.execute(sql);
														RecordSet2.next();
														if(isbill.equals("0")){
															tmpName=RecordSet2.getString("name");
														}else{
															tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
														}
														tmpdesc+=","+tmpName;
                            break;
                        case 6:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15559,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" "; // ��������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 7:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15562,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" "; // ��������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 8:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15564,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 9 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=9 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 9:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15566,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 9 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=9 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 10:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15567,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 8 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=8 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 11:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15569,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 8 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=8 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 12:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15570,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 8 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=8 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 13:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15571,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 23 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=23 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 14:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15573,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 23 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=23 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 15:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15574,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 7 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 16:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15575,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 7 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 23:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15555,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1 or workflow_formdict.type=17) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1 or type=17) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 24:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15555,user.getLanguage());
													  if(isbill.equals("0"))
														  sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 7 or workflow_formdict.type = 18 ) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
														  " and workflow_formdict.id = "+objid+" ";
													  else
														  sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
														  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 25:
                        		tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15581,user.getLanguage());
                            break;
                        case 20:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(1282,user.getLanguage()) +"-" ;
                            tmpdesc+= CustomerTypeComInfo.getCustomerTypename(""+objid) ;
                            break;
                        case 21:
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15078,user.getLanguage()) +"-" ;
                            tmpdesc+= CustomerStatusComInfo.getCustomerStatusname(""+objid) ;
                            break;
                        case 4 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(1340,user.getLanguage());
                            break;
                        case 17 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15079,user.getLanguage())  ;
                            break;
                        case 18 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15080,user.getLanguage())  ;
                            break;
                        case 19 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15081,user.getLanguage());
                            break;
                        case 30 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(141,user.getLanguage()) ;
                            tmpdesc+= SubCompanyComInfo.getSubCompanyname(""+objid) ;
                            break;
                        case 31 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15560,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" "; // ��������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 32 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15561,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" "; // ��������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 33 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15565,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 9 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=9 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 34 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15568,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 8 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=8 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 35 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15572,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 23 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=23 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 36 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15576,user.getLanguage()) ;
                            break;
                        case 37 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15577,user.getLanguage()) ;
                            break;
                        case 38 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15563,user.getLanguage()) ;
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 1) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" "; // ��������������Դ�ֶ�
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=1) " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 39 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(15578,user.getLanguage()) ;
                            break;
                        case 40 :
                            tmpdesc+=";&nbsp;"+SystemEnv.getHtmlLabelName(18676,user.getLanguage());// "�ڵ�����߱���"
                            tmpdesc+=","+ nodename2 ;
                            break;
                        case 41 :
                            tmpdesc+=";&nbsp;"+SystemEnv.getHtmlLabelName(18677,user.getLanguage());// "�ڵ�����߾���"
                            tmpdesc+=","+ nodename2 ;
                            break;
                        case 42 :
                            tmpdesc+=";&nbsp;"+SystemEnv.getHtmlLabelName(18939,user.getLanguage());// "����"
                            if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and (workflow_formdict.type = 4 or workflow_formdict.type=57) and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";      // �ಿ��
													  else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and (type=4 or type=57) " +
															  " and id = "+objid+" ";
													  RecordSet2.executeSql(sql);
													  RecordSet2.next();
														if(isbill.equals("0")){
															tmpName=RecordSet2.getString("name");
														}else{
															tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
														}
														tmpdesc+=","+tmpName;
                            break;
                        case 43 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(122,user.getLanguage());
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and  workflow_formfield.fieldid= workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 65 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";      // ���ɫ
													  else
													  	sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=65 " +
														  " and id = "+objid+" ";
														System.out.println("sql"+sql);
													  RecordSet2.executeSql(sql);
													  RecordSet2.next();
														if(isbill.equals("0")){
															tmpName=RecordSet2.getString("name");
														}else{
															tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
														}
														tmpdesc+=","+tmpName;
                            break;
                        case 44 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(17204,user.getLanguage());// "�ͻ��ֶξ���ľ���"
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 7 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 45 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(18678,user.getLanguage());// "�ͻ��ֶηֲ�"
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 7 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 46 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(18679,user.getLanguage());//"�ͻ��ֶβ���" 
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 7 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=7 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 47 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(18680,user.getLanguage()); //"��Ŀ�ֶξ���ľ���" 
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 8 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=8 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                        case 48 :
                            tmpdesc+=";&nbsp;"+ SystemEnv.getHtmlLabelName(18681,user.getLanguage()); //"�����ҵĹ���Ա"
														if(isbill.equals("0"))
															sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and workflow_formdict.fieldhtmltype='3' and workflow_formdict.type = 87 and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" "+
															  " and workflow_formdict.id = "+objid+" ";
														else
															sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " and fieldhtmltype = '3' and type=87 " +
															  " and id = "+objid+" ";
                            RecordSet2.execute(sql);
                            RecordSet2.next();
							if(isbill.equals("0")){
								tmpName=RecordSet2.getString("name");
							}else{
								tmpName=SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage());
							}
							tmpdesc+=","+tmpName;
                            break;
                    }
                    //��ȫ����
                    switch (type){
                    case 1:
                    case 4:
                    case 7:
                    case 9:
                    case 11:
                    case 12:
                    case 14:
                    case 19:
                    case 20:
                    case 21:
                    case 22:
                    case 23:
                    case 25:
                    case 30:
                    case 31:
                    case 32:
                    case 33:
                    case 34:
                    case 35:
                    case 36:
                    case 37:
                    case 38:
                    case 39:
                    case 45:
                    case 46:
	                    if(level2_n!=-1){
	                        tmpdesc+=","+ SystemEnv.getHtmlLabelName(683,user.getLanguage()) + level +"-" + level2_n;// "��ȫ���� "
	                    }else{
	                        tmpdesc+=","+ SystemEnv.getHtmlLabelName(683,user.getLanguage()) + level;// "��ȫ���� "
	                    }
	                    break;

                    case 5:
                    case 42:
                    case 43:
                    	/*//ԭʼȡ�����鶨���ǩ���Ե��߼�
	                    if(level==0){
	                        tmpdesc+=","+SystemEnv.getHtmlLabelName(15585,user.getLanguage());
	                    }else if(level==1){
	                        tmpdesc+=","+SystemEnv.getHtmlLabelName(15557,user.getLanguage());
	                    }else{
	                        tmpdesc+=","+SystemEnv.getHtmlLabelName(15558,user.getLanguage());
	                    }
	                    */
	                  	//����editoperatorgroup.jsp�޸ĵ�ȡ�����鶨���ǩ���Ե��߼�
                    	if("0".equals(signorder)){
                    		tmpdesc+=","+SystemEnv.getHtmlLabelName(15556,user.getLanguage());
                    	} else if("1".equals(signorder)){
                    		tmpdesc+=","+SystemEnv.getHtmlLabelName(15557,user.getLanguage());
                    	}else if("2".equals(signorder)){
                    		tmpdesc+=","+SystemEnv.getHtmlLabelName(15558,user.getLanguage());
                    	}else if("3".equals(signorder)){
                    		tmpdesc+=","+SystemEnv.getHtmlLabelName(21227,user.getLanguage());
                    	}else if("4".equals(signorder)){
                    		tmpdesc+=","+SystemEnv.getHtmlLabelName(21228,user.getLanguage());
                    	}
	                    break;
                    }
                    if(!"".equals(conditioncn)){
	                    tmpdesc += "["+SystemEnv.getHtmlLabelName(17892,user.getLanguage())+SystemEnv.getHtmlLabelName(15364,user.getLanguage())+":"+conditioncn+"]";
                    }
                    if(!"".equals(tmpdesc)){
	                    tmpdesc = tmpdesc + "&nbsp;";
                    }
                }
                
                if(!tmpdesc.equals(""))   tmpdesc=tmpdesc.substring(1) ;
                if(!"".equals(tmpdesc))
                {
                	groupdesc += ""+tmpdesc+"" ;
                }
                out.println("<td style=\"word-break:break-all;word-wrap:break-word;"+bottomStyle+"\">"+groupdesc+"</td>\n");
                out.println("</tr>\n");
                out.println("<tr class=\"Line\" ><td class=\"Line\" colSpan=\"2\"></td></tr>\n");
          }
%>
	</table>
	</td>
<%          
            //��nodeid�ҽڵ�ǰ�󸽼Ӳ���
            String preaddStr = "";
			String addStr = "";
			Hashtable reths = wfAddinOperateManager.getAddinOperateStr(Util.getIntValue(nodeid), 0, 1, user, formid, isbill, Util.getIntValue(workflowid));
			preaddStr = Util.null2String((String)reths.get("preaddStr"));
			addStr = Util.null2String((String)reths.get("addStr"));
%>          
            <td style="word-break:break-all;word-wrap:break-word"><%=preaddStr%>&nbsp;</td>
            <td style="word-break:break-all;word-wrap:break-word"><%=addStr%>&nbsp;</td>
            <%
			sv = "";
			dv = "";
			zc = "";
			mc = "";
			fw = "";
			rb = "";
			ov = "";
			
			RecordSet2.executeSql("select * from workflow_function_manage where workflowid = " + workflowid + " and operatortype = " + nodeid);
			
			if(RecordSet2.next()){
				sv = RecordSet2.getString("typeview");
				dv = RecordSet2.getString("dataview");
				zc = RecordSet2.getString("automatism");
				mc = RecordSet2.getString("manual");
				fw = RecordSet2.getString("transmit");
				rb = RecordSet2.getString("retract");
				ov = RecordSet2.getString("pigeonhole");
			}
			%>
            <%      
			if(rb.equals("1"))
			{
			%>  
	        <td class=field><%=SystemEnv.getHtmlLabelName(18365,user.getLanguage())%></td>
			<%      
			}
			else if(rb.equals("2"))
			{
			%>  
	        <td class=field><%=SystemEnv.getHtmlLabelName(18366,user.getLanguage())%></td>
			<%      
			}
			else
			{
			%>
			<td class=field><%=SystemEnv.getHtmlLabelName(18364,user.getLanguage())%></td>
			<%
			}
			%>
            <%      
			if(ov.equals("1"))
			{
	        %>
	        <td class=field><b><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></b></td>
			<%      
			}
			else
			{
	        %>  
	        <td class=field><b><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></b></td>
			<%      
			}       
			%>
		</tr>
		<tr class="<%=trclass%>">
			<%
				String nodeAttrStr = wfAddinOperateManager.getNodeattr(Util.getIntValue(nodeid), user);
			%>
			<td colspan="7" style="word-break:break-all;word-wrap:break-word">&nbsp;<%=nodeAttrStr%></td>
		</tr>
<%
            
        }
%>
    </table>
<!-- ������Ϣ Start -->
	<TABLE class=ListStyle cellspacing=1>
		<colgroup>
		<col width="25%">
		<col width="25%">
		<col width="25%">
		<col width="13%">
		<col width="12%">
		<tr class=header>
			<td colSpan="5"><%=SystemEnv.getHtmlLabelName(15606,user.getLanguage())%></td><!-- ������Ϣ -->
		</tr>
		<tr class="header">
			<td><%=SystemEnv.getHtmlLabelName(15611,user.getLanguage())%></td><!-- �������� -->
			<td><%=SystemEnv.getHtmlLabelName(15070,user.getLanguage())%></td><!-- �ڵ����� -->
			<td><%=SystemEnv.getHtmlLabelName(15074,user.getLanguage())%></td><!-- Ŀ��ڵ� -->
			<td><%=SystemEnv.getHtmlLabelName(15075,user.getLanguage())%></td><!-- �Ƿ��˻� -->
			<td><%=SystemEnv.getHtmlLabelName(20576,user.getLanguage())%></td><!-- ���ɱ�� -->
		</tr>
		<tr class="header">
			<td colspan="2"><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%></td><!-- �������� -->
			<td colspan="3"><%=SystemEnv.getHtmlLabelName(15610,user.getLanguage())%></td><!-- ���ӹ��� -->
		</tr>
		<%
			changeclass = false;
			sql = "select * from workflow_nodelink n where workflowid="+workflowid+" and exists(select b1.id from workflow_nodebase b1 where b1.id=n.nodeid and (b1.IsFreeNode is null or b1.IsFreeNode!='1')) and exists(select b2.id from workflow_nodebase b2 where b2.id=n.destnodeid and (b2.IsFreeNode is null or b2.IsFreeNode!='1')) order by id";
			rs.execute(sql);
			while(rs.next()){
				int linkid = Util.getIntValue(rs.getString("id"));
				int nodeid = Util.getIntValue(rs.getString("nodeid"));
				String nodename_t = "";
				if(nodeids.indexOf(""+nodeid) > -1){
					nodename_t = Util.null2String((String)nodenames.get(nodeids.indexOf(""+nodeid)));
				}
				int destnodeid = Util.getIntValue(rs.getString("destnodeid"));
				String destnodename_t = "";
				if(nodeids.indexOf(""+destnodeid) > -1){
					destnodename_t = Util.null2String((String)nodenames.get(nodeids.indexOf(""+destnodeid)));
				}
				String linkname = Util.null2String(rs.getString("linkname"));
				int isreject = Util.getIntValue(rs.getString("isreject"));
				String isrejectStr = "";
				if(isreject == 1){
					isrejectStr = SystemEnv.getHtmlLabelName(163,user.getLanguage());
				}else{
					isrejectStr = SystemEnv.getHtmlLabelName(161,user.getLanguage());
				}
				int isbulidcode = Util.getIntValue(rs.getString("isbulidcode"));
				String isbulidcodeStr = "";
				if(isbulidcode == 1){
					isbulidcodeStr = SystemEnv.getHtmlLabelName(163,user.getLanguage());
				}else{
					isbulidcodeStr = SystemEnv.getHtmlLabelName(161,user.getLanguage());
				}
				trclass = changeclass?"DataDark":"DataLight";
		        changeclass = changeclass?false:true;
		        String conditioncn = "";
				if(isOracle == true){
					conditioncn = wfAddinOperateManager.getLinkConditioncn(linkid);
				}else{
					conditioncn = Util.null2String(rs.getString("conditioncn"));
				}
				Hashtable reths = wfAddinOperateManager.getAddinOperateStr(0, linkid, 0, user, formid, isbill, Util.getIntValue(workflowid));
				String linkaddStr = Util.null2String((String)reths.get("addStr"));
				out.println("<tr class=\""+trclass+"\">\n");
				out.println("<td>"+linkname+"</td>\n");
				out.println("<td>"+nodename_t+"</td>\n");
				out.println("<td>"+destnodename_t+"</td>\n");
				out.println("<td>"+isrejectStr+"</td>\n");
				out.println("<td>"+isbulidcodeStr+"</td>\n");
				out.println("</tr>\n");

				out.println("<tr class=\""+trclass+"\">\n");
				out.println("<td colspan=\"2\" style=\"word-break:break-all;word-wrap:break-word\">&nbsp;"+conditioncn+"</td>\n");
				out.println("<td colspan=\"3\" style=\"word-break:break-all;word-wrap:break-word\">&nbsp;"+linkaddStr+"</td>\n");
				out.println("</tr>\n");
			}
		%>
	</TABLE>

<!-- ������Ϣ End -->
    <TABLE class=ListStyle cellspacing=1>
        <colgroup>
        <col width="30%">
        <col width="20%">
        <col width="20%">
        <col width="30%">
        <tr class=header>
            <td colSpan=4><%=SystemEnv.getHtmlLabelName(21220,user.getLanguage())%></td><!-- �������� -->
        </tr>
        <tr class=header>
            <td><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></td>
            <td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
            <td><%=SystemEnv.getHtmlLabelName(139,user.getLanguage())%></td>
            <td><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%></td>
        </tr>
        <%
		ArrayList ids = new ArrayList();
		ArrayList names = new ArrayList();
		ids.clear();
		names.clear();
		
		if(isbill.equals("0"))
		  sql = "select workflow_formdict.id as id,workflow_fieldlable.fieldlable as name from workflow_formdict,workflow_formfield,workflow_fieldlable where  workflow_fieldlable.isdefault='1' and workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.fieldid = workflow_formfield.fieldid and workflow_formfield.fieldid = workflow_formdict.id and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid;
		else
		  sql = "select id as id , fieldlabel as name from workflow_billfield where billid="+ formid+ " " ;
		//out.println(sql);
		RecordSet2.executeSql(sql);
		while(RecordSet2.next()){
			ids.add(RecordSet2.getString("id"));
		    if(isbill.equals("0")) names.add(Util.null2String(RecordSet2.getString("name")));
			else names.add(SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet2.getString("name")),user.getLanguage()));
		}


		//the record in db
		int colorcount=0;
		RecordSet2.executeSql("select * from workflow_urgerdetail where workflowid="+workflowid+" order by id");
		
		String oldids="-1";
		while(RecordSet2.next()){
			int detailid = RecordSet2.getInt("id");
			int type = RecordSet2.getInt("utype");
			int objid = RecordSet2.getInt("objid");
			int level = RecordSet2.getInt("level_n");
			int level2 = RecordSet2.getInt("level2_n");
		
		    String conditions=RecordSet2.getString("conditions");
		    String conditioncn=RecordSet2.getString("conditioncn");
			oldids=oldids+","+detailid;
		if(colorcount==0)
		{
			colorcount=1;
		%>
		<TR class=DataLight>
		<%
		}
		else
		{
			colorcount=0;
		%>
		<TR class=DataDark>
		<%
		}
		%>
			<td height="23">
			<%
			if(type==1)
			{%><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%><%}
			if(type==2)
				{%><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%> <%}
			if(type==3)
				{%><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%> <%}
			if(type==4)
				{%><%=SystemEnv.getHtmlLabelName(1340,user.getLanguage())%> <%}
			if(type==5)
				{%><%=SystemEnv.getHtmlLabelName(15555,user.getLanguage())%> <%}
			if(type==6)
				{%><%=SystemEnv.getHtmlLabelName(15559,user.getLanguage())%> <%}
			if(type==7)
				{%><%=SystemEnv.getHtmlLabelName(15562,user.getLanguage())%> <%}
			if(type==8)
				{%><%=SystemEnv.getHtmlLabelName(15564,user.getLanguage())%> <%}
			if(type==9)
				{%><%=SystemEnv.getHtmlLabelName(15566,user.getLanguage())%> <%}
			if(type==10)
				{%><%=SystemEnv.getHtmlLabelName(15567,user.getLanguage())%> <%}
			if(type==11)
				{%><%=SystemEnv.getHtmlLabelName(15569,user.getLanguage())%> <%}
			if(type==12)
				{%><%=SystemEnv.getHtmlLabelName(15570,user.getLanguage())%> <%}
			if(type==13)
				{%><%=SystemEnv.getHtmlLabelName(15571,user.getLanguage())%> <%}
			if(type==14)
				{%><%=SystemEnv.getHtmlLabelName(15573,user.getLanguage())%> <%}
			if(type==15)
				{%><%=SystemEnv.getHtmlLabelName(15574,user.getLanguage())%> <%}
			if(type==16)
				{%><%=SystemEnv.getHtmlLabelName(15575,user.getLanguage())%> <%}
			if(type==17)
				{%><%=SystemEnv.getHtmlLabelName(15079,user.getLanguage())%> <%}
			if(type==18)
				{%><%=SystemEnv.getHtmlLabelName(15080,user.getLanguage())%> <%}
			if(type==19)
				{%><%=SystemEnv.getHtmlLabelName(15081,user.getLanguage())%> <%}
			if(type==20)
				{%><%=SystemEnv.getHtmlLabelName(1282,user.getLanguage())%> <%}
			if(type==21)
				{%><%=SystemEnv.getHtmlLabelName(15078,user.getLanguage())%> <%}
			if(type==22)
				{%><%=SystemEnv.getHtmlLabelName(15579,user.getLanguage())%> <%}
			if(type==23)
				{%><%=SystemEnv.getHtmlLabelName(2113,user.getLanguage())%> <%}
			if(type==24)
				{%><%=SystemEnv.getHtmlLabelName(15580,user.getLanguage())%> <%}
			if(type==25)
				{%><%=SystemEnv.getHtmlLabelName(15581,user.getLanguage())%> <%}
			if(type==30)
			    {%><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%> <%}
			if(type==31)
				{%><%=SystemEnv.getHtmlLabelName(15560,user.getLanguage())%> <%}
			if(type==32)
				{%><%=SystemEnv.getHtmlLabelName(15561,user.getLanguage())%> <%}
			if(type==33)
				{%><%=SystemEnv.getHtmlLabelName(15565,user.getLanguage())%> <%}
			if(type==34)
				{%><%=SystemEnv.getHtmlLabelName(15568,user.getLanguage())%> <%}
			if(type==35)
				{%><%=SystemEnv.getHtmlLabelName(15572,user.getLanguage())%> <%}
			if(type==36)
				{%><%=SystemEnv.getHtmlLabelName(15576,user.getLanguage())%> <%}
			if(type==37)
				{%><%=SystemEnv.getHtmlLabelName(15577,user.getLanguage())%> <%}
			if(type==38)
				{%><%=SystemEnv.getHtmlLabelName(15563,user.getLanguage())%> <%}
			if(type==39)
				{%><%=SystemEnv.getHtmlLabelName(15578,user.getLanguage())%> <%}
			if(type==40)
				{%><%=SystemEnv.getHtmlLabelName(18676,user.getLanguage())%> <%}
			if(type==41)
				{%><%=SystemEnv.getHtmlLabelName(18677,user.getLanguage())%> <%}
			if(type==42)
				{%><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%> <%}
			if(type==43)
				{%><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%> <%}
			if(type==44)
				{%><%=SystemEnv.getHtmlLabelName(17204,user.getLanguage())%> <%}
			if(type==45)
				{%><%=SystemEnv.getHtmlLabelName(18678,user.getLanguage())%> <%}
			if(type==46)
				{%><%=SystemEnv.getHtmlLabelName(18679,user.getLanguage())%><%}
			if(type==47)
				{%><%=SystemEnv.getHtmlLabelName(18680,user.getLanguage())%> <%}
			if(type==48)
				{%><%=SystemEnv.getHtmlLabelName(18681,user.getLanguage())%> <%}
			if(type==49)
				{%><%=SystemEnv.getHtmlLabelName(19309,user.getLanguage())%> <%}
			if(type==50)
				{%><%=SystemEnv.getHtmlLabelName(20570,user.getLanguage())%> <%}
			%>
			</td>
			<td  height="23">
			<%
				switch (type){
					case 1:
					case 22:
					%>
					<%=DepartmentComInfo.getDepartmentname(""+objid)%>
					<%
					break;
					case 2:
					RecordSet1.executeSql("select rolesmark from hrmroles where id = "+objid);
					RecordSet1.next();
					%>
					<%=RecordSet1.getString(1)%>
					<%
					break;
					case 3:
					
					%>
					<%=ResourceComInfo.getResourcename(""+objid)%>
					<%
					break;
					case 5:
					case 49:
					case 6:
					case 7:
					case 8:
					case 9:
					case 10:
					case 11:
					case 12:
					case 13:
					case 14:
					case 15:
					case 16:
					case 23:
					case 24:
					case 31:
					case 32:
					case 33:
					case 34:
					case 35:
					case 38:
					case 42:
					case 43:
					case 44:
					case 45:
					case 46:
					case 47:
					case 48:
						int index=ids.indexOf(""+objid);
						if(index!=-1){
					%>
					<%=names.get(index)%>
					<%	}
					break;
					case 20:
					%>
					<%=Util.toScreen(CustomerTypeComInfo.getCustomerTypename(""+objid),user.getLanguage())%>
					<%
					break;
					case 21:
					%>
					<%=Util.toScreen(CustomerStatusComInfo.getCustomerStatusname(""+objid),user.getLanguage())%>
					<%
					break;
					case 30:
					%>
					<%=SubCompanyComInfo.getSubCompanyname(""+objid)%>
					<%
					break;
					case 50:
					int indexs=ids.indexOf(""+objid);
					//System.out.print(indexs);
					if(indexs!=-1){
					%>
					<%=names.get(indexs)%>/
					<%	}%>
					<%=RolesComInfo.getRolesname(""+level)%>
						<%
					break;
				}
			%>
			</td>
			<td height="23">
			<%
				switch (type){
					case 1:
					case 4:
					case 7:
					case 9:
					case 11:
					case 12:
					case 14:
					case 19:
					case 20:
					case 21:
					case 22:
					case 23:
					case 25:
					case 30:
					case 31:
					case 32:
					case 33:
					case 34:
					case 35:
					case 36:
					case 37:
					case 38:
					case 39:
					case 45:
					case 46:
					case 42:
					%>
					<%if(level2!=-1){%>
					<%=level%>-<%=level2%>
					<%}else{%>
					>=<%=level%>
					<%}%>
					<%
					break;
					case 2:
					 if(level==0){%>
					<%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%>
					<%}else if(level==1){%>
					<%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%>
					<%}else if(level==2){%>
					<%=SystemEnv.getHtmlLabelName(140,user.getLanguage())%>
					<%}
					break;
				}%>
			</td>
			<td><%=conditioncn%></td>
		</tr>
		<%} %>
   	</TABLE>
    </TD>
  </TR>
  <tr><td height=10></td></tr>
<%  
    }
%>  
    </tbody>
    </table>
			
			</td>
			</tr>
			<TR class=separator><TD class=Sep1 colSpan=14 ></TD></TR>
			<TR>
				<TD colspan="14">
					<DIV class=xTable_info>
					<DIV>
						<TABLE width="100%">
							<TBODY>
								<TR>
									<TD></TD>
									<TD>
										<DIV align=right>
											<input id=currentpage name=currentpage type="hidden" value="<%=pagepos %>">
											<%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%><!-- �� --><%=countsize%><%=SystemEnv.getHtmlLabelName(18256,user.getLanguage())%><!-- �� --><%=SystemEnv.getHtmlLabelName(264,user.getLanguage())%><!-- ��¼ -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(265,user.getLanguage())%><!-- ÿҳ -->10<%=SystemEnv.getHtmlLabelName(18256,user.getLanguage())%><!-- �� -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(18609,user.getLanguage())%><!-- �� --><%=pagesizes %><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->
											&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(524,user.getLanguage())%><!-- ��ǰ --><%=SystemEnv.getHtmlLabelName(15323,user.getLanguage())%><!-- �� --><%=pagepos %><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->&nbsp;&nbsp;
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('f')"><SPAN><%=SystemEnv.getHtmlLabelName(18363,user.getLanguage())%><!-- ��ҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('u')"><SPAN><%=SystemEnv.getHtmlLabelName(1258,user.getLanguage())%><!-- ��һҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none"
												id=pagenext onclick="goToPage('d')"><SPAN><%=SystemEnv.getHtmlLabelName(1259,user.getLanguage())%><!-- ��һҳ --></SPAN>
											</A>
											<A style="CURSOR: hand; TEXT-DECORATION: none" id=pagelast onclick="goToPage('l')"><SPAN><%=SystemEnv.getHtmlLabelName(18362,user.getLanguage())%><!-- βҳ --></SPAN>
											</A>&nbsp;
											<BUTTON id=goPageBotton onclick="goPage()">
												<%=SystemEnv.getHtmlLabelName(23162,user.getLanguage())%><!-- ת�� -->
											</BUTTON>
											&nbsp;<%=SystemEnv.getHtmlLabelName(15323,user.getLanguage())%><!-- �� --><INPUT style="TEXT-ALIGN: right" id=gopage name=gopage class=text value=<%=pagepos %> size=2><%=SystemEnv.getHtmlLabelName(23161,user.getLanguage())%><!-- ҳ -->
										</DIV>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</DIV>
				</DIV>
				</TD>
			</TR>
			</TABLE>
			
			</td>
			<td></td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>

<SCRIPT language=javascript>
function onSearch(){
	frmmain.submit();
}
function exportXSL()
{
	document.getElementById("iframeExcel").src = "/system/basedata/basedata_workflowexcel.jsp?wfids4excel=<%=wfids4excel%>&pagepos=<%=pagepos%>&wfname=<%=twfname%>&wfid=<%=wfid%>";
}
function goToPage(forward)
{
	var currentpage = document.getElementById("currentpage").value;
	var actionpage = "";
	if(forward=="f")
	{
		actionpage = 1;
	}
	else if(forward=="u")
	{
		actionpage = currentpage*1-1;
	}
	else if(forward=="d")
	{
		actionpage = currentpage*1+1;
	}
	else if(forward=="l")
	{
		actionpage = '<%=pagesizes %>';
	}
	document.frmmain.pagepos.value=actionpage;
	frmmain.submit();
}
function goPage()
{
	var gopage = document.getElementById("gopage").value;
	if(gopage=="")
	{
		gopage = "1";
	}
	document.frmmain.pagepos.value=gopage;
	frmmain.submit();
}
function doSearchAgain()
{
	document.location.href = "basedata_workflow.jsp";
}
function doBack()
{
	document.location.href = "basedata.jsp";
}
function doClose(){
	window.close();
}
</SCRIPT>
<iframe id="iframeExcel" style="display: none"></iframe>
</BODY></HTML>
