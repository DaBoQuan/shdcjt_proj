<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,java.util.*,weaver.conn.*" %>
<%@ page import="weaver.general.AttachFileUtil" %>
<%@ page import="weaver.rtx.RTXConfig" %>
<%@ page import="weaver.worktask.worktask.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSet4" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSet5" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td3665 on 20060227--%>
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="CoworkDAO" class="weaver.cowork.CoworkDAO" scope="page"/>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/><!--xwj for td3450 20060112-->
<jsp:useBean id="WfFunctionManageUtil" class="weaver.workflow.workflow.WfFunctionManageUtil" scope="page"/><!--xwj for td3665 20060224-->
<jsp:useBean id="WfForceOver" class="weaver.workflow.workflow.WfForceOver" scope="page" /><!--xwj for td3665 20060224-->
<jsp:useBean id="WfForceDrawBack" class="weaver.workflow.workflow.WfForceDrawBack" scope="page" /><!--xwj for td3665 20060224-->
<jsp:useBean id="flowDoc" class="weaver.workflow.request.RequestDoc" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="WFManager" class="weaver.workflow.workflow.WFManager" scope="page"/>
<jsp:useBean id="WFLinkInfo" class="weaver.workflow.request.WFLinkInfo" scope="page"/>
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<%----xwj for td3665 20060301 begin---%>
<%
String info = (String)request.getParameter("infoKey");
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
//if(0==0){
//out.println("<script>window.opener.btnWfCenterReload.onclick()</script>");
//return;
//}
%>
<script language="JavaScript">
<%if(isovertime==1){%>
        window.opener.location.href=window.opener.location.href;
<%}%>
<%if(info!=null && !"".equals(info)){

  if("ovfail".equals(info)){%>
 alert("<%=SystemEnv.getHtmlLabelName(18566,user.getLanguage())%>")
 <%}
 else if("rbfail".equals(info)){%>
 alert("<%=SystemEnv.getHtmlLabelName(18567,user.getLanguage())%>")
 <%}
 else{
 
 }
 }%>
</script>
<%----xwj for td3665 20060301 end---%>

<%
boolean isnotprintmode =Util.null2String(request.getParameter("isnotprintmode")).equals("1")?true:false;
String reEdit=""+Util.getIntValue(request.getParameter("reEdit"),1);//�Ƿ�Ϊ�༭
int requestid=Util.getIntValue(request.getParameter("requestid"),0);
String isrequest = Util.null2String(request.getParameter("isrequest")); //
String nodetypedoc=Util.null2String(request.getParameter("nodetypedoc"));
int desrequestid=0;
int wflinkno=Util.getIntValue(request.getParameter("wflinkno"));
boolean isprint = Util.null2String(request.getParameter("isprint")).equals("1")?true:false;
String fromoperation=Util.null2String(request.getParameter("fromoperation"));

String fromPDA = Util.null2String((String)session.getAttribute("loginPAD"));   //��PDA��¼
//TD4262 ������ʾ��Ϣ  ��ʼ
String src=Util.null2String(request.getParameter("src"));//����ý���ǰ�Ĳ�����"submit"���ύ��"reject"���˻ء�
String isShowPrompt=Util.null2String(request.getParameter("isShowPrompt"));//�Ƿ���ʾ��ʾ  ȡֵ"true"����"false"
//TD4262 ������ʾ��Ϣ  ����

String requestname="";      //��������
String requestlevel="";     //������Ҫ���� 0:���� 1:��Ҫ 2:����
String requestmark = "" ;   //������
String isbill="0";          //�Ƿ񵥾� 0:�� 1:��
int creater=0;              //����Ĵ�����
int creatertype = 0;        //���������� 0: �ڲ��û� 1: �ⲿ�û�
int deleted=0;              //�����Ƿ�ɾ��  1:�� 0�������� ��
int billid=0 ;              //����ǵ���,��Ӧ�ĵ��ݱ��id
String isModifyLog = "";		//�Ƿ��¼����־ by cyril on 2008-07-09 for TD:8835

int workflowid=0;           //������id
String workflowtype = "" ;  //����������
int formid=0;               //�����ߵ��ݵ�id
int helpdocid = 0;          //�����ĵ� id
String workflowname = "" ;         //����������
String status = ""; //��ǰ�Ĳ�������
String docCategory="";//������Ŀ¼
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
int usertype = 0;
if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;
int nodeid=WFLinkInfo.getCurrentNodeid(requestid,userid,Util.getIntValue(logintype,1));               //�ڵ�id
String nodetype=WFLinkInfo.getNodeType(nodeid);         //�ڵ�����  0:���� 1:���� 2:ʵ�� 3:�鵵

//��ǰ���������ڵ�id�����ͣ������ж��Ƿ���ǿ�ƹ鵵Ȩ��TD9023
String currentnodetype = "";
int currentnodeid = 0;

boolean canview = false ;               // �Ƿ���Բ鿴
boolean canactive = false ;             // �Ƿ���Զ�ɾ���Ĺ���������
boolean isurger=false;                  //�����˿ɲ鿴
boolean wfmonitor=false;                //���̼����
boolean haveBackright=false;            //ǿ���ջ�Ȩ��
//boolean haveOverright=false;            //ǿ�ƹ鵵Ȩ��

String sql = "" ;
char flag = Util.getSeparator() ;
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //�Ƿ�����̴����ĵ�����
if(isrequest.equals("1")){      // ����ع���������,�в鿴Ȩ��
    requestid=Util.getIntValue(String.valueOf(session.getAttribute("resrequestid"+wflinkno)),0);
    String realateRequest=Util.null2String(String.valueOf(session.getAttribute("relaterequest")));
	if (requestid==0&&realateRequest.equals("new"))  requestid=Util.getIntValue(request.getParameter("requestid"),0);
	int tempnum_ = Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
	for(int cx_=0; cx_<=tempnum_; cx_++){
		int resrequestid_ = Util.getIntValue(String.valueOf(session.getAttribute("resrequestid"+cx_)));
		
		if(resrequestid_ == requestid){
			desrequestid=Util.getIntValue(String.valueOf(session.getAttribute("desrequestid")),0);//��������ID
			rs.executeSql("select count(*) from workflow_currentoperator where userid="+userid+" and usertype="+usertype+" and requestid="+desrequestid);
		    if(rs.next()){
		        int counts=rs.getInt(1);
		        if(counts>0){
		           canview=true;
		           break;
		        }
		    }
		}
	}
    session.setAttribute(requestid+"wflinkno",wflinkno+"");//���������̣��������̲�������Ȩ�޴�ӡ������    
}
//�Ӽƻ�����ҳ��������в鿴Ȩ�� Start
int isworktask = Util.getIntValue(request.getParameter("isworktask"), 0);
if(isworktask == 1){
	int haslinkworktask = Util.getIntValue((String)session.getAttribute("haslinkworktask"), 0);
	if(haslinkworktask == 1){
		int tlinkwfnum = Util.getIntValue((String)session.getAttribute("tlinkwfnum"), 0);
		int i_tmp = 0;
		for(i_tmp=0; i_tmp<tlinkwfnum; i_tmp++){
			int retrequestid = Util.getIntValue((String)session.getAttribute("retrequestid"+i_tmp), 0);
			if(retrequestid != requestid){
				session.removeAttribute("retrequestid"+i_tmp);
				session.removeAttribute("deswtrequestid"+i_tmp);
				continue;
			}
			int deswtrequestid = Util.getIntValue((String)session.getAttribute("deswtrequestid"+i_tmp), 0);
			rs.execute("select * from worktask_requestbase where requestid="+deswtrequestid);
			if(rs.next()){
				int wt_id = Util.getIntValue(rs.getString("taskid"), 0);
				int wt_status = Util.getIntValue(rs.getString("status"), 1);
				int wt_creater = Util.getIntValue(rs.getString("creater"), 0);
				int wt_needcheck = Util.getIntValue(rs.getString("needcheck"), 0);
				int wt_checkor = Util.getIntValue(rs.getString("checkor"), 0);
				int wt_approverequest = Util.getIntValue(rs.getString("approverequest"), 0);
				if(wt_needcheck == 0){
					wt_checkor = 0;
				}
				WTRequestManager wtRequestManager = new WTRequestManager(wt_id);
				wtRequestManager.setLanguageID(user.getLanguage());
				wtRequestManager.setUserID(user.getUID());
				Hashtable checkRight_hs = wtRequestManager.checkRight(deswtrequestid, wt_status, 0, wt_creater, wt_checkor, wt_approverequest);
				boolean canView_tmp = false;
				canView_tmp = (Util.null2String((String)checkRight_hs.get("canView"))).equalsIgnoreCase("true")?true:false;
				if(canView_tmp==false){
					checkRight_hs = wtRequestManager.checkTemplateRight(deswtrequestid, wt_status, 0, wt_creater, wt_checkor, wt_approverequest);
					canView_tmp = (Util.null2String((String)checkRight_hs.get("canView"))).equalsIgnoreCase("true")?true:false;
				}
				if(canView_tmp == true){
					canview = canView_tmp;
				}
			}
			session.removeAttribute("retrequestid"+i_tmp);
			session.removeAttribute("deswtrequestid"+i_tmp);
			session.setAttribute("haslinkworktask", "0");
			session.setAttribute("tlinkwfnum", "0");
			continue;
		}
	}

}
//�Ӽƻ�����ҳ��������в鿴Ȩ�� End
ArrayList canviewwff = (ArrayList)session.getAttribute("canviewwf");
if(canviewwff!=null)
   if(canviewwff.indexOf(requestid+"")>-1)
         canview = true;

if(creater == userid && creatertype == usertype){   // �����߱����в鿴Ȩ��
	canview=true;
	canactive=true;
}

// ����û��鿴Ȩ��
// ����û��Ƿ���Բ鿴�ͼ���ù����� (����Ƕ�ɾ���Ĺ�����,��ɾ��״̬��Ϊɾ��ǰ��״̬)
// canview = HrmUserVarify.checkUserRight("ViewRequest:View", user);   //��ViewRequest:ViewȨ�޵��˿��Բ鿴ȫ��������
// canactive = HrmUserVarify.checkUserRight("ViewRequest:Active", user);   //��ViewRequest:ActiveȨ�޵��˿��Բ鿴ȫ��������
   

// ��ǰ�û����и������Ӧ����Ϣ isremarkΪ0Ϊ��ǰ������, isremarkΪ1Ϊ��ǰ��ת����,isremarkΪ2Ϊ�ɸ��ٲ鿴��,isremark=5Ϊ��Ԥ��
//RecordSet.executeProc("workflow_currentoperator_SByUs",userid+""+flag+usertype+flag+requestid+"");
int preisremark=0;
String isremarkForRM = "";
RecordSet.executeSql("select isremark,isreminded,preisremark from workflow_currentoperator where requestid="+requestid+" and userid="+userid+" and usertype="+usertype+" order by isremark");
boolean istoManagePage=false;   //add by xhheng @20041217 for TD 1438
while(RecordSet.next())	{
    String isremark = Util.null2String(RecordSet.getString("isremark")) ;
	isremarkForRM = isremark;
    preisremark=Util.getIntValue(RecordSet.getString("preisremark"),0) ;
    //modify by mackjoe at 2005-09-29 td1772 ת�����⴦��ת����Ϣ����δ����һֱ��Ҫ����ʹ�����ѹ鵵
    if( isremark.equals("1")||isremark.equals("5") || isremark.equals("8")|| isremark.equals("9") ||(isremark.equals("0")  && !nodetype.equals("3")) ) {
      //modify by xhheng @20041217 for TD 1438
      istoManagePage=true;
      canview=true;
      break;
    }
    canview=true;
}
//add by mackjoe at 2006-04-24 td3994
int urger=Util.getIntValue(request.getParameter("urger"),0);
session.setAttribute(userid+""+requestid+"urger",""+urger);    
if(!canview || urger==1) isurger=WFUrgerManager.UrgerHaveWorkflowViewRight(requestid,userid,Util.getIntValue(logintype,1));
int ismonitor=Util.getIntValue(request.getParameter("ismonitor"),0);
session.setAttribute(userid+""+requestid+"ismonitor",""+ismonitor);    
if(!canview&&!isurger) wfmonitor=WFUrgerManager.getMonitorViewRight(requestid,userid); 
PoppupRemindInfoUtil.updatePoppupRemindInfo(userid,10,(logintype).equals("1") ? "0" : "1",requestid);  
if(!canview && !isurger && !wfmonitor && !CoworkDAO.haveRightToViewWorkflow(Integer.toString(userid),Integer.toString(requestid))) {
    if(!WFUrgerManager.UrgerHaveWorkflowViewRight(desrequestid,userid,Util.getIntValue(logintype,1)) && !WFUrgerManager.getMonitorViewRight(desrequestid,userid)){//�������̺ͼ�����̵���������в鿴Ȩ��
        response.sendRedirect("/notice/noright.jsp?isovertime="+isovertime);
        return ;
    }
}
// ��ѯ�������ع�����������Ϣ
RecordSet.executeProc("workflow_Requestbase_SByID",requestid+"");
if(RecordSet.next()){
    status  = Util.null2String(RecordSet.getString("status")) ;
    requestname= Util.null2String(RecordSet.getString("requestname")) ;
	requestlevel = Util.null2String(RecordSet.getString("requestlevel"));
    requestmark = Util.null2String(RecordSet.getString("requestmark")) ;
    creater = Util.getIntValue(RecordSet.getString("creater"),0);
	creatertype = Util.getIntValue(RecordSet.getString("creatertype"),0);
    deleted = Util.getIntValue(RecordSet.getString("deleted"),0);
	workflowid = Util.getIntValue(RecordSet.getString("workflowid"),0);
	currentnodeid = Util.getIntValue(RecordSet.getString("currentnodeid"),0);
    if(nodeid<1) nodeid = currentnodeid;
	currentnodetype = Util.null2String(RecordSet.getString("currentnodetype"));
    if(nodetype.equals("")) nodetype = currentnodetype;
    docCategory=Util.null2String(RecordSet.getString("docCategory"));
    workflowname = WorkflowComInfo.getWorkflowname(workflowid+"");
    workflowtype = WorkflowComInfo.getWorkflowtype(workflowid+"");
}
if(urger==1 && isurger==true){//���̶������ڣ����Ҿ��ж���鿴���̱���Ȩ��
	nodeid = currentnodeid;
	nodetype = currentnodetype;
}
String isaffirmance=WorkflowComInfo.getNeedaffirmance(""+workflowid);//�Ƿ���Ҫ�ύȷ��
//TD8715 ��ȡ��������Ϣ���Ƿ���ʾ����ͼ
WFManager.setWfid(workflowid);
WFManager.getWfInfo();
String isShowChart = Util.null2String(WFManager.getIsShowChart());
//System.out.println("isShowChart = " + isShowChart);
RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid+"");
if(RecordSet.next()){
	isModifyLog = Util.null2String(RecordSet.getString("isModifyLog"));//by cyril on 2008-07-09 for TD:8835
	formid = Util.getIntValue(RecordSet.getString("formid"),0);
	isbill = ""+Util.getIntValue(RecordSet.getString("isbill"),0);
	helpdocid = Util.getIntValue(RecordSet.getString("helpdocid"),0);
}

session.setAttribute(userid+""+requestid+"isaffirmance",isaffirmance);
session.setAttribute(userid+""+requestid+"reEdit",reEdit);
//�ж��Ƿ������̴����ĵ��������ڸýڵ����������ֶ�
boolean docFlag=flowDoc.haveDocFiled(""+workflowid,""+nodeid);
String  docFlagss=docFlag?"1":"0";
session.setAttribute("requestAdd"+requestid,docFlagss);
if (!fromFlowDoc.equals("1"))
{
if (docFlag)
{ if (fromoperation.equals("1"))
	{

	if (!nodetypedoc.equals("0")) {
	%>
	<script>
		<%if("1".equals(isShowChart)){%>
	 //setTimeout("window.close()",1);
     //window.opener._table.reLoad();
try{	
	window.opener.btnWfCenterReload.onclick();
}catch(e){}

try{
	window.opener._table.reLoad();
}catch(e){}
     window.location.href="/workflow/request/WorkflowDirection.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&isbill=<%=isbill%>&formid=<%=formid%>";
	 <%}else{%>
	 setTimeout("window.close()",1);
     //window.opener._table.reLoad();
try{
	window.opener.btnWfCenterReload.onclick();
}catch(e){}

try{
	window.opener._table.reLoad();
}catch(e){}

		 <%}%>
    </script>
    <%return;}
	else
	{%>
			<script>
		try{
	window.opener.btnWfCenterReload.onclick();
}catch(e){}

try{
	window.opener._table.reLoad();
}catch(e){}
</script>
<%
		if("1".equals(isShowChart)){
			response.sendRedirect("/workflow/request/WorkflowDirection.jsp?requestid="+requestid+"&workflowid="+workflowid+"&isbill="+isbill+"&formid="+formid);
		}else{
		 response.sendRedirect("RequestView.jsp");
		}
     return;
	}
    }
session.setAttribute(userid+""+requestid+"requestname",requestname);
session.setAttribute(userid+""+requestid+"requestmark",requestmark);
session.setAttribute(userid+""+requestid+"status",status);
session.setAttribute(userid+""+requestid+"workflowname",workflowname);
response.sendRedirect("ViewRequestDoc.jsp?requestid="+requestid+"&isrequest="+isrequest+"&isovertime="+isovertime+"&isaffirmance="+isaffirmance+"&reEdit="+reEdit+"&wflinkno="+wflinkno);
return;
}
}

if(fromoperation.equals("1")&&(src.equals("submit")||src.equals("reject"))){//fromoperation=1��ʾ��������������,�����ύ���˻ز���ʱ���ص�����ͼҳ�档
%>
<script>
try{
	window.opener.btnWfCenterReload.onclick();
}catch(e){}
try{
	window.opener._table.reLoad();
}catch(e){}
<%if("1".equals(isShowChart)){%>
window.location.href="/workflow/request/WorkflowDirection.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&isbill=<%=isbill%>&formid=<%=formid%>";
</script>
<%  return;
	}else{%>
</script>
    <%}

}
String tempremark = Util.null2String(request.getParameter("isremark"));
if(tempremark.equals("8")){
%>
<script>
     //window.opener._table.reLoad();
try{	
	window.opener.btnWfCenterReload.onclick();
}catch(e){}
try{
	window.opener._table.reLoad();
}catch(e){}
</script>
<%
}

if( isbill.equals("1") ) {
    RecordSet.executeProc("workflow_form_SByRequestid",requestid+"");
    if(RecordSet.next()){
    formid = Util.getIntValue(RecordSet.getString("billformid"),0);
    billid= Util.getIntValue(RecordSet.getString("billid"));
    }
	if(formid == 207){//�ƻ�������������������
    	//���⴦��ֱ����ת���ƻ�������棬������������
    	int approverequest = Util.getIntValue(request.getParameter("requestid"), 0);
    	int wt_requestid = 0;
    	rs.execute("select * from worktask_requestbase where approverequest="+approverequest);
    	if(rs.next()){
    		wt_requestid = Util.getIntValue(rs.getString("requestid"), 0);
    	}
    	response.sendRedirect("/worktask/request/ViewWorktask.jsp?requestid="+wt_requestid);
		return;
    }
}

//xwj for td3450 20060112
if(istoManagePage && !isprint){
PoppupRemindInfoUtil.updatePoppupRemindInfo(userid,0,(logintype).equals("1") ? "0" : "1",requestid);
}
else{
String updatePoppupFlag = Util.null2String(request.getParameter("updatePoppupFlag"));
if( !"1".equals(updatePoppupFlag)){
PoppupRemindInfoUtil.updatePoppupRemindInfo(userid,1,(logintype).equals("1") ? "0" : "1",requestid);
}
}
String message = Util.null2String(request.getParameter("message"));       // ���صĴ�����Ϣ
//add by xhheng @20041217 for TD 1438 start
if(istoManagePage && !isprint && !wfmonitor){
    String topage = URLEncoder.encode(Util.null2String(request.getParameter("topage"))) ;        //���ص�ҳ��
    String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
    String newdocid = Util.null2String(request.getParameter("docid"));        // �½����ĵ�
    String actionPage = "ManageRequestNoForm.jsp?fromFlowDoc="+fromFlowDoc ;

    session.setAttribute(userid+""+requestid+"status",status);
    session.setAttribute(userid+""+requestid+"requestname",requestname);
    session.setAttribute(userid+""+requestid+"requestlevel",requestlevel);
    session.setAttribute(userid+""+requestid+"requestmark",requestmark);
    session.setAttribute(userid+""+requestid+"creater",""+creater);
    session.setAttribute(userid+""+requestid+"creatertype",""+creatertype);
    session.setAttribute(userid+""+requestid+"deleted",""+deleted);
    session.setAttribute(userid+""+requestid+"workflowid",""+workflowid);
    session.setAttribute(userid+""+requestid+"nodeid",""+nodeid);
    session.setAttribute(userid+""+requestid+"nodetype",nodetype);
    session.setAttribute(userid+""+requestid+"workflowname",workflowname);
    session.setAttribute(userid+""+requestid+"workflowtype",workflowtype);
    session.setAttribute(userid+""+requestid+"formid",""+formid);
    session.setAttribute(userid+""+requestid+"billid",""+billid);
    session.setAttribute(userid+""+requestid+"isbill",isbill);
    session.setAttribute(userid+""+requestid+"helpdocid",""+helpdocid);
    session.setAttribute(userid+""+requestid+"docCategory",docCategory);
    session.setAttribute(userid+""+requestid+"newdocid",newdocid);
    session.setAttribute(userid+""+requestid+"wfmonitor",""+wfmonitor);

    //RecordSet������һ���ͻ�������ִ��֮�䣬��ѯ������Ա�������һ�β�ѯ(��RecordSet�� Description 4)
    //�����ڶ���sqlִ��ʧ��ʱ��û�����RecordSet�����Ա�����һ��sqlִ�н��
    //�ɴˣ�Ϊ��ֹͼ�λ�����ؽű�û��ִ�ж�����sqlִ��ʧ�������µ��߼������������µ�RecordSet����mrs
    //�����ϵ�ͼ�λ���ʽ��Ĭ��Ϊ��ͨ��ʽ mackjoe at 2006-06-12
    /*RecordSet mrs=new RecordSet();
    mrs.executeSql("select count(a.formid) from workflow_formprop a, workflow_base b, workflow_Requestbase c where a.formid = b.formid and b.id = c.workflowid and b.isbill='0' and c.requestid = "+requestid);

    if(mrs.next() && mrs.getInt(1) > 0 ){
      actionPage = "ManageRequestForm.jsp" ;
    }else{
      actionPage = "ManageRequestNoForm.jsp" ;
    }
    */
    //System.out.println("actionPage="+actionPage);

    //�����˵����̲鿴״̬��Ϊ�Ѳ鿴2,���ύ���Ĳ�Ҫ�ڸ��²���ʱ��
    if (RecordSet.getDBType().equals("oracle"))
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh begin
	{
        //RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate= to_char(sysdate,'yyyy-mm-dd'),operatetime=to_char(sysdate,'hh24:mi:ss'),orderdate=receivedate,ordertime=receivetime where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
        RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=( case isremark when '2' then operatedate else to_char(sysdate,'yyyy-mm-dd') end  ) ,operatetime=( case isremark when '2' then operatetime else to_char(sysdate,'hh24:mi:ss') end  ) where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2 ");
	}
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh end
    else if (RecordSet.getDBType().equals("db2"))
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh begin
	{
        //RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=to_char(current date,'yyyy-mm-dd'),operatetime=to_char(current time,'hh24:mi:ss'),orderdate=receivedate,ordertime=receivetime where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
        RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=( case isremark when '2' then operatedate else to_char(current date,'yyyy-mm-dd') end ),operatetime=( case isremark when '2' then operatetime else to_char(current time,'hh24:mi:ss') end ) where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
	}
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh end
    else
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh begin
	{
        //RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=convert(char(10),getdate(),20),operatetime=convert(char(8),getdate(),108),orderdate=receivedate,ordertime=receivetime where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
        //RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=to_char(current date,'yyyy-mm-dd'),operatetime=to_char(current time,'hh24:mi:ss')  where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");//update by fanggsh 20060510
        RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,operatedate=( case isremark when '2' then operatedate else convert(char(10),getdate(),20) end ),operatetime=( case isremark when '2' then operatetime else convert(char(8),getdate(),108) end ) where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");//update by fanggsh 20060510

	}
		//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh end
    //��¼��һ�β鿴ʱ��
    //RecordSet.executeProc("workflow_CurOpe_UpdatebyView",""+requestid+ flag + userid + flag + usertype);

    actionPage+="&requestid="+requestid+"&isrequest="+isrequest+"&isovertime="+isovertime+"&isaffirmance="+isaffirmance+"&reEdit="+reEdit;
    if(!message.equals("")) actionPage+="&message="+message;
    if(!topage.equals("")) actionPage+="&topage="+topage;
    if(!docfileid.equals("")) actionPage+="&docfileid="+docfileid;
    if(!newdocid.equals("")) actionPage+="&newdocid="+newdocid;
    response.sendRedirect(actionPage);

    //��ǰ�����߻��߱�ת����,���ҵ�ǰ�ڵ㲻Ϊ�����ڵ�,ֱ�ӽ������ҳ��
    return ;
}
//add by xhheng @20041217 for TD 1438 end

// ��¼�鿴��־
String clientip = request.getRemoteAddr();
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String currenttime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                     Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                     Util.add0(today.get(Calendar.SECOND), 2) ;

// modify by xhheng @20050304 for TD 1691

/*--  xwj for td2104 on 20050802 begin  --*/
boolean isOldWf = false;
if(isprint==false){
RecordSet4.executeSql("select nodeid from workflow_currentoperator where requestid = " + requestid);
while(RecordSet4.next()){
	if(RecordSet4.getString("nodeid") == null || "".equals(RecordSet4.getString("nodeid")) || "-1".equals(RecordSet4.getString("nodeid"))){
			isOldWf = true;
	}
}

if(isOldWf){//������ , ��� td2104 ��ǰ
RecordSet.executeProc("workflow_RequestViewLog_Insert",requestid+"" + flag + userid+"" + flag + currentdate +flag + currenttime + flag + clientip + flag + usertype +flag + nodeid + flag + "9" + flag + -1);
//������û���κεط�ʹ����ordertype='-1'�����������Դ˴�ֱ�Ӱ�-1�ĳ�9 by ben 2006-05-24 for TD439
}
else{
int showorder = 10000;
String orderType = "";
RecordSet.executeSql("select agentorbyagentid, agenttype, showorder from workflow_currentoperator where userid = " + userid +
" and nodeid = " + nodeid + " and requestid = " + requestid + " and isremark in ('0','1','4','5','8','9','7') and usertype = " + usertype);

if(RecordSet.next()){
  orderType = "1"; // ��ǰ�ڵ������
  showorder  = RecordSet.getInt("showorder");
}
else{

orderType = "2";// �ǵ�ǰ�ڵ������
RecordSet2.executeSql("select max(showorder) from workflow_requestviewlog where id = " + requestid + "  and ordertype = '2' and currentnodeid = " + nodeid);
RecordSet2.next();
if(RecordSet2.getInt(1) != -1){
showorder = RecordSet2.getInt(1) + 1;
}
}
if(wfmonitor){
    orderType ="3";//���̼���˲鿴
}
if(isurger){
    orderType ="4";//���̶����˲鿴
}
RecordSet.executeProc("workflow_RequestViewLog_Insert",requestid+"" + flag + userid+"" + flag + currentdate +flag + currenttime + flag + clientip + flag + usertype +flag + nodeid + flag + orderType + flag + showorder);

}

/*--  xwj for td2104 on 20050802 end  --*/


//�����˵����̲鿴״̬��Ϊ�Ѳ鿴2
	//TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh begin
//RecordSet.executeSql("update workflow_currentoperator set viewtype=-2,orderdate=receivedate,ordertime=receivetime where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
RecordSet.executeSql("update workflow_currentoperator set viewtype=-2 where requestid = " + requestid + "  and userid ="+userid+" and usertype = "+usertype+" and viewtype<>-2");
    //TD4294  ɾ��workflow_currentoperator����orderdate��ordertime�� fanggsh end
//��¼��һ�β鿴ʱ��
RecordSet.executeProc("workflow_CurOpe_UpdatebyView",""+requestid+ flag + userid + flag + usertype);

if(! nodetype.equals("3") )
    RecordSet.executeProc("SysRemindInfo_DeleteHasnewwf",""+userid+flag+usertype+flag+requestid);
else
    RecordSet.executeProc("SysRemindInfo_DeleteHasendwf",""+userid+flag+usertype+flag+requestid);
}

String imagefilename = "/images/hdReport.gif";
String titlename =  SystemEnv.getHtmlLabelName(648,user.getLanguage())+":"
	                +SystemEnv.getHtmlLabelName(553,user.getLanguage())+" - "+Util.toScreen(workflowname,user.getLanguage()) + " - " +  status + " "+requestmark ;//Modify by ����� 2004-10-26 For TD1231
//if(helpdocid !=0 ) {titlename=titlename + "<img src=/images/help.gif style=\"CURSOR:hand\" width=12 onclick=\"location.href='/docs/docs/DocDsp.jsp?id="+helpdocid+"'\">";}
String needfav ="1";
String needhelp ="";
//add by mackjoe at 2005-12-20 ����ģ��Ӧ��
String ismode="";
int modeid=0;
int isform=0;
int showdes=0;
int printdes=0;
RecordSet.executeSql("select ismode,showdes,printdes from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSet.next()){
    ismode=Util.null2String(RecordSet.getString("ismode"));
    showdes=Util.getIntValue(Util.null2String(RecordSet.getString("showdes")),0);
    printdes=Util.getIntValue(Util.null2String(RecordSet.getString("printdes")),0);
}
if(ismode.equals("1") && showdes!=1){
    RecordSet.executeSql("select id from workflow_nodemode where isprint='0' and workflowid="+workflowid+" and nodeid="+nodeid);
    if(RecordSet.next()){
        modeid=RecordSet.getInt("id");
    }else{
        RecordSet.executeSql("select id from workflow_formmode where isprint='0' and formid="+formid+" and isbill='"+isbill+"'");
        if(RecordSet.next()){
            modeid=RecordSet.getInt("id");
            isform=1;
        }
    }
}else if("2".equals(ismode)){
	RecordSet.executeSql("select id from workflow_nodehtmllayout where type=1 and workflowid="+workflowid+" and nodeid="+nodeid);
    if(RecordSet.next()){
        modeid=RecordSet.getInt("id");
    }
}

//��ie�²�֧��ģ��ģʽ��ӡ
int print_modeid = 0;
if(  !isnotprintmode && isprint && printdes!=1){
	 RecordSet.executeSql("select id from workflow_nodemode where isprint='1' and workflowid="+workflowid+" and nodeid="+nodeid);
	    if(RecordSet.next()){
	    	print_modeid=RecordSet.getInt("id");
	    }else{
	        RecordSet.executeSql("select id from workflow_formmode where formid="+formid+" and isbill='"+isbill+"' and isprint='1'");
	       if(RecordSet.next()){
	            print_modeid=RecordSet.getInt("id");
	        }
	    }
	    //���������
	 	//if(print_modeid >0) {
		// 	response.sendRedirect("PrintMode.jsp?requestid="+requestid+"&isbill="+isbill+"&workflowid="+workflowid+"&formid="+formid+"&nodeid="+nodeid+"&billid="+billid);
		// 	return;
	 	//}
}

if (print_modeid > 0) {
	if ("true".equals((String)session.getAttribute("browser_isie"))) {
		response.sendRedirect("PrintMode.jsp?requestid="+requestid+"&isbill="+isbill+"&workflowid="+workflowid+"&formid="+formid+"&nodeid="+nodeid+"&billid="+billid);
		return;
	} else {
%>
	<script type="text/javascript">
		var closeflg = window.confirm("����ǰ���������֧�֡�ģ��ģʽ-��ӡģ�塿\r\n���ȷ���ԡ�һ��ģʽ��Ԥ����ӡ,���ȡ���رմ�ҳ��");
		if (!closeflg) {
			window.close();
		}
	</script>
<%}} %>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<script type='text/javascript' src='/dwr/interface/DocReadTagUtil.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/util.js'></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/FCKEditorExt.js"></script>     
<script type="text/javascript" language="javascript" src="/js/jquery/jquery.js"></script>
<LINK href="/css/rp.css" rel="STYLESHEET" type="text/css">

<style>
.wordSpan{font-family:MS Shell Dlg,Arial;CURSOR: hand;font-weight:bold;FONT-SIZE: 10pt}
</style>

</head>
<script language=javascript>

function hiddenPop(){
 try{
    <%
	if(modeid>0 && "1".equals(ismode)){
%>
    oPopup.hide();
<%
    }else{
%>
    showTableDiv.style.display='none';
    oIframe.style.display='none';
<%
    }
%>
}catch(e){}
}
var fromoperation="<%=fromoperation%>";
var overtime="<%=isovertime%>";
function windowOnload()
{
    <%if(modeid>0 && "1".equals(ismode)){%>
        init();
    <%}else{%>
    setwtableheight();
    <%}
        if( message.equals("4") ) {//�Ѿ���ת����һ�ڵ㣬���������ύ��
%>

		  var content="<%=SystemEnv.getHtmlLabelName(21266,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("message_table_Div.style.display='none';document.all.HelpFrame.style.display='none'", 2000);
<%
	} else if( message.equals("5") ) {//������ת��ʱ�������ԡ�
%>

		  var content="<%=SystemEnv.getHtmlLabelName(21270,user.getLanguage())%>";
		  showPrompt(content);
          window.setTimeout("message_table_Div.style.display='none';document.all.HelpFrame.style.display='none'", 2000);

<%
	}
%>
    if (fromoperation=="1") {
<%
         //TD4262 ������ʾ��Ϣ  ��ʼ
		 if(isShowPrompt.equals("true"))
		{
			 if(src.equals("submit")){
				 if(modeid>0 && "1".equals(ismode)){
%>
	                 contentBox = document.getElementById("divFavContent18982");
                     showObjectPopup(contentBox);
<%
				 }else{
%>
		             var content="<%=SystemEnv.getHtmlLabelName(18982,user.getLanguage())%>";
		             showPrompt(content);
<%
				 }
			 }else if(src.equals("reject")){
				 if(modeid>0 && "1".equals(ismode)){
%>
	                 contentBox = document.getElementById("divFavContent18983");
                     showObjectPopup(contentBox);
<%
				 }else {
%>
		             var content="<%=SystemEnv.getHtmlLabelName(18983,user.getLanguage())%>";
		             showPrompt(content);
<%
				 }
			}
		}
%>

         //TD4262 ������ʾ��Ϣ  ����
		<%if("1".equals(isShowChart)){%>
        //setTimeout("window.close()",1);
       			try{
				window.opener._table.reLoad();
			}catch(e){}
			window.location.href="/workflow/request/WorkflowDirection.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&isbill=<%=isbill%>&formid=<%=formid%>";
		<%}else{%>
			setTimeout("window.close()",1);
			try{
				window.opener._table.reLoad();
			}catch(e){}
		<%}%>
        //window.opener.document.frmmain.submit();
        //���ύ�����ڸ�Ϊ���÷�ҳ�ؼ���ˢ�º���
        if( overtime!="1")
        {
        	try
        	{
        		window.opener.btnWfCenterReload.onclick();
        		window.opener._table.reLoad();
        	}
        	catch(e)
        	{
        	<%if("1".equals(isShowChart)){%>
				window.location.href="/workflow/request/WorkflowDirection.jsp?requestid=<%=requestid%>&workflowid=<%=workflowid%>&isbill=<%=isbill%>&formid=<%=formid%>";
				<%}else{%>
					window.location.href = "RequestView.jsp";
				<%}%>
        	}
        }

    }
}
<%if(modeid<1 || "2".equals(ismode)){%>
function setwtableheight(){
    var totalheight=5;
    var bodyheight=document.body.clientHeight;
    if(document.all("divTopTitle")!=null){
        totalheight+=document.all("divTopTitle").clientHeight;
    }
    <%if (fromFlowDoc.equals("1")){%>
        totalheight+=100;
        bodyheight=parent.document.body.clientHeight;
    <%}%>
    document.all("w_table").height=bodyheight-totalheight;
}
window.onresize = function (e){
    setwtableheight();
}
<%}%>
</script>

<script language="javascript">
var isfirst = 0 ;

function displaydiv()
{
	var oDivAll = $GetEle("oDivAll");
    if(oDivAll.style.display == ""){
		oDivAll.style.display = "none";
		$GetEle("oDivInner").style.display = "none";
		$GetEle("oDiv").style.display = "none";
        <%if(modeid>0 && "1".equals(ismode)){%>  $GetEle("oDivSign").style.display = "none";<%}%>
        $GetEle("spanimage").innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
    } else{
        if(isfirst == 0) {
        	$GetEle("divPicInnerFrame").style.display = "";
        	$GetEle("divPicFrame").style.display = "";
        	$GetEle("picInnerFrame").src = "/workflow/request/WorkflowRequestPictureInner.jsp?isview=1&fromFlowDoc=<%=fromFlowDoc%>&modeid=<%=modeid%>&requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>";				
        	$GetEle("picFrame").src = "/workflow/request/WorkflowRequestPicture.jsp?requestid=<%=requestid%>&desrequestid=<%=desrequestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isbill=<%=isbill%>&formid=<%=formid%>&isurger=<%=isurger%>";
            <%if(modeid>0 && "1".equals(ismode)){%>  $GetEle("picSignFrame").src="/workflow/request/WorkflowViewSignMode.jsp?isprint=true&languageid=<%=user.getLanguage()%>&userid=<%=userid%>&requestid=<%=requestid%>&workflowid=<%=workflowid%>&nodeid=<%=nodeid%>&isOldWf=<%=isOldWf%>&desrequestid=<%=desrequestid%>&ismonitor=<%=ismonitor%>&logintype=<%=logintype%>";<%}%>
            isfirst ++ ;
        } else {
        	$GetEle("divPicInnerFrame").style.display = "none";
        	$GetEle("divPicFrame").style.display = "none";
        	$GetEle("picInnerFrame").src = "";	
        	$GetEle("picFrame").src = "";
        }

        $GetEle(spanimage).innerHTML = "<img src='/images/ArrowUpGreen.gif' border=0>" ;
		oDivAll.style.display = "";
		$GetEle("oDivInner").style.display = "";
		$GetEle("oDiv").style.display = "";
		$GetEle("workflowStatusLabelSpan").innerHTML = "<font color=green><%=SystemEnv.getHtmlLabelName(19678,user.getLanguage())%></font>";
		$GetEle("workflowChartLabelSpan").innerHTML = "<font color=green><%=SystemEnv.getHtmlLabelName(19676,user.getLanguage())%></font>";
        <%if(modeid>0 && "1".equals(ismode)){%>
        	$GetEle("oDivSign").style.display = "";
        	$GetEle("workflowSignLabelSpan").innerHTML = "<font color=green><%=SystemEnv.getHtmlLabelName(21200,user.getLanguage())%></font>";
        <%}%>
    }
}


function displaydivOuter()
{
	var oDiv = $GetEle("oDiv");
	var workflowStatusLabelSpan = $GetEle("workflowStatusLabelSpan");
    if(oDiv.style.display == ""){
        oDiv.style.display = "none";
        workflowStatusLabelSpan.innerHTML="<font color=red><%=SystemEnv.getHtmlLabelName(19677,user.getLanguage())%></font>";
		if(oDiv.style.display == "none" && $GetEle("oDivInner").style.display == "none" <%if(modeid>0 && "1".equals(ismode)){%> && $GetEle("oDivSign").style.display == "none"<%}%>){
			$GetEle("oDivAll").style.display = "none";
		    $GetEle("spanimage").innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
		}
    }
    else{
        oDiv.style.display = "";
        workflowStatusLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19678,user.getLanguage())%></font>";
    }
}

function displaydivInner()
{
	var oDivInner = $GetEle("oDivInner");
	var workflowChartLabelSpan = $GetEle("workflowChartLabelSpan");
    if(oDivInner.style.display == ""){
        oDivInner.style.display = "none";
        workflowChartLabelSpan.innerHTML = "<font color=red><%=SystemEnv.getHtmlLabelName(19675,user.getLanguage())%></font>";
		if($GetEle("oDiv").style.display == "none" && oDivInner.style.display == "none" <%if(modeid>0 && "1".equals(ismode)){%> && $GetEle("oDivSign").style.display == "none"<%}%>){
			$GetEle("oDivAll").style.display = "none";
		    $GetEle(spanimage).innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
		}
    }
    else{
        oDivInner.style.display = "";
        workflowChartLabelSpan.innerHTML="<font color=green><%=SystemEnv.getHtmlLabelName(19676,user.getLanguage())%></font>";
    }
}
</SCRIPT>

<body style="overflow:auto">
<%if (!fromFlowDoc.equals("1")) {%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%}%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% border="0" cellspacing="0" cellpadding="0" id="w_table">
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
		<%if("2".equals(ismode) && modeid>0){%>
			<TABLE class=ViewForm>
		<%}else{%>
			<TABLE class=Shadow>
		<%}%>
		<tr>
		<td valign="top">
        <%if( message.equals("4") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21266,user.getLanguage())%></font>
		<%} else if( message.equals("5") ) {%>
        <font color=red><%=SystemEnv.getHtmlLabelName(21270,user.getLanguage())%></font>
		<%}%>
        <div align="" id="t_help">
        <!-- modify by xhheng @20050304 for TD 1691 -->
        <% if(helpdocid !=0 && isprint==false) {%>
        <img src="/images/help.gif" style="CURSOR:hand" width=12 onclick="showWFHelp(<%=helpdocid%>)">
        <%}%>
        <%if(isprint==false){%>
        <a href="#" onClick="displaydiv()">
            <SPAN id="spanimage" name="spanimage"><img src="/images/ArrowDownRed.gif" border=0></span>
        </a></div>
        <%}%>

<div  id=oDivAll style="display:none"  width="100%">
  <TABLE border=0 cellpadding=0 cellspacing=0 width="100%">
  <TR>
    <TH align="right"><span id=workflowChartLabelSpan onclick="displaydivInner()" class="wordSpan"><font color=green><%=SystemEnv.getHtmlLabelName(19676,user.getLanguage())%></font></span></TH>
  </TR>
  <TR>
    <TD align="left" >
    <div  id=oDivInner style="display:none"  width="100%">
        <TABLE border=0 cellpadding=0 cellspacing=0 width="100%"><TR><TD ID='ImageTdInner'></TD></TR></TABLE>
        <BR>
    </div>
	</TD>
  </TR>
  <TR>
    <TH align="right"><span id=workflowStatusLabelSpan onclick="displaydivOuter()" class="wordSpan"><font color=green><%=SystemEnv.getHtmlLabelName(19678,user.getLanguage())%></font></span></TH>
  </TR>
  <TR>
    <TD  align="left">
    <div  id=oDiv style="display:none"  width="100%">
       <TABLE border=0 cellpadding=0 cellspacing=0 width="100%"><TR><TD ID='IMAGETD'></TD></TR></TABLE>
       <BR>
    </div>
	</TD>
    </TR>
  <%if(modeid>0 && "1".equals(ismode)){%>
    <TR>
    <TH align="right"><span id=workflowSignLabelSpan onclick="displaydivSign()" class="wordSpan"><font color=green><%=SystemEnv.getHtmlLabelName(21200,user.getLanguage())%></font></span></TH>
  </TR>
  <TR>
    <TD  align="left">
    <div  id=oDivSign style="display:none"  width="100%">
       <TABLE border=0 cellpadding=0 cellspacing=0 width="100%"><TR><TD ID='IMAGETDSign'></TD></TR></TABLE>
       <BR>
    </div>
	</TD>
    </TR>
   <%}%>
  </TABLE>
</div>

<DIV id="divPicInnerFrame" style="display:none">
<iframe ID="picInnerFrame" BORDER=0 FRAMEBORDER=no height="0%" width="0%" scrolling="NO" src=""></iframe>
</DIV>

<DIV id="divPicFrame" style="display:none">
<iframe ID="picFrame" BORDER=0 FRAMEBORDER=no height="0%" width="0%" scrolling="NO" src=""></iframe>
</DIV>
<!--TD4262 ������ʾ��Ϣ  ��ʼ-->
<%
    if(modeid>0 && "1".equals(ismode)){
%>
<div id="divFavContent18982" style="display:none">  <!--�����ύ�ɹ���-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18982,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>

<div id="divFavContent18983" style="display:none"> <!--�����˻سɹ���-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18983,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>
<div id="divFavContent19205" style="display:none"> <!--���ڻ�ȡ���ݡ�-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>
<%
    }else{
%>
<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<%
	}
%>
<!--TD4262 ������ʾ��Ϣ  ����-->

<%
if(modeid>0 && "1".equals(ismode)){
    request.setAttribute("requestname",requestname);
%>
<div id="divFavContent18978" style="display:none"><!--�����ύ���̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>
<div id="divFavContent18984" style="display:none"><!--����ɾ�����̣����Ե�....-->
	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		<tr height="22">
			<td style="font-size:9pt"><%=SystemEnv.getHtmlLabelName(18984,user.getLanguage())%>
			</td>
		</tr>
	</table>
</div>
<DIV>
<iframe ID="picSignFrame" BORDER=0 FRAMEBORDER=no height="0%" width="0%" scrolling="NO" src=""></iframe>
</DIV>
<%if(fromFlowDoc.equals("1") || (isbill.equals("1") && formid==7)){%>
<div id="t_headother"></div>
<%}%>
    <form name="frmmain" method="post" action="RequestOperation.jsp" <%if (!fromPDA.equals("1")) {%> enctype="multipart/form-data" <%}%>>
<%
boolean hasRequestname = false;
boolean hasRequestlevel = false;
boolean hasMessage = false;
RecordSet.executeSql("select * from workflow_modeview where formid="+formid+" and nodeid="+nodeid+" and fieldid=-1");
if(RecordSet.next()) hasRequestname = true;
RecordSet.executeSql("select * from workflow_modeview where formid="+formid+" and nodeid="+nodeid+" and fieldid=-2");
if(RecordSet.next()) hasRequestlevel = true;
RecordSet.executeSql("select * from workflow_modeview where formid="+formid+" and nodeid="+nodeid+" and fieldid=-3");
if(RecordSet.next()) hasMessage = true;
%>
<%
if(!hasRequestname||!hasRequestlevel||!hasMessage){
%>
    <TABLE class="ViewForm" id="t_header">
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">
  <TR class="Spacing">
    <TD class="Line1" colSpan=2></TD>
  </TR>
  <TR>
    <TD><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></TD>
    <TD class=field>
    <%if(!hasRequestname){%>
       <%=Util.toScreenToEdit(requestname,user.getLanguage())%>
       <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,user.getLanguage())%>">
    <%}%>  
    <%if(!hasRequestlevel){%>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
		<%}%>

    <%if(!hasMessage){%>
      <!--add by xhheng @ 2005/01/25 for ��Ϣ���� Request06����ת�����в쿴�������� -->
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%
      String sqlWfMessage = "select messageType from workflow_base where id="+workflowid;
      int wfMessageType=0;
      RecordSet.executeSql(sqlWfMessage);
      if (RecordSet.next()) {
        wfMessageType=RecordSet.getInt("messageType");
      }
      if(wfMessageType == 1){
        String sqlRqMessage = "select messageType from workflow_requestbase where requestid="+requestid;
        int rqMessageType=0;
        RecordSet.executeSql(sqlRqMessage);
        if (RecordSet.next()) {
          rqMessageType=RecordSet.getInt("messageType");
        }%>
        <%if(rqMessageType==0){%><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%>
        <%} else if(rqMessageType==1){%><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%>
        <%} else if(rqMessageType==2){%><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%> <%}%>
      <%}%>
      <%}%>
      </TD>
  </TR>
  <TR>
    <TD class="Line1" colSpan=2></TD>
  </TR>
  </table> 
<%}%>     
    <%if(isbill.equals("1") && formid==7){%>
    <jsp:include page="/workflow/request/BillBudgetExpenseDetailMode.jsp" flush="true">
	<jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    </jsp:include>
    <%}%>
    <jsp:include page="WorkflowViewmode.jsp" flush="true">
    <jsp:param name="modeid" value="<%=modeid%>" />
    <jsp:param name="isform" value="<%=isform%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />    
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="Languageid" value="<%=user.getLanguage()%>" />
    </jsp:include>
    <jsp:include page="ViewmodeValue.jsp" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
	<jsp:param name="workflowid" value="<%=workflowid%>" />
	<jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="isbill" value="<%=isbill%>" />
    <jsp:param name="Languageid" value="<%=user.getLanguage()%>" />
    <jsp:param name="isurger" value="<%=isurger%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />  
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
	<jsp:param name="isprint" value="1" />
    </jsp:include>
    </form>
<%
}else{
//end by mackjoe

String viewpage= "";
if(isbill.equals("1")){
    RecordSet.executeProc("bill_includepages_SelectByID",formid+"");
    if(RecordSet.next()) viewpage = RecordSet.getString("viewpage");
}
if( !viewpage.equals("")) {
     request.setAttribute("requestname",requestname);
    request.setAttribute("workflowname",workflowname);
    String vp_isprint = Util.null2String(request.getParameter("isprint"));
%>
<jsp:include page="<%=viewpage%>" flush="true">
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="requestmark" value="<%=requestmark%>" />
    <jsp:param name="creater" value="<%=creater%>" />
    <jsp:param name="creatertype" value="<%=creatertype%>" />
    <jsp:param name="deleted" value="<%=deleted%>" />
    <jsp:param name="billid" value="<%=billid%>" />
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="canactive" value="<%=canactive%>" />
    <jsp:param name="isprint" value="<%=vp_isprint%>" />
	<jsp:param name="desrequestid" value="<%=desrequestid%>" />
	<jsp:param name="isrequest" value="<%=isrequest%>" />
    <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
    <jsp:param name="isurger" value="<%=isurger%>" />
    <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />

</jsp:include>
<%}else{%>

<form name="frmmain" method="post" action="RequestOperation.jsp" <%if (!fromPDA.equals("1")) {%> enctype="multipart/form-data" <%}%>>
    <%
    request.setAttribute("requestname",requestname);
    request.setAttribute("workflowname",workflowname);
    if("2".equals(ismode) && modeid>0){
	%>
            <jsp:include page="WorkflowViewRequestHtml.jsp" flush="true">
				<jsp:param name="modeid" value="<%=modeid%>" />
                <jsp:param name="workflowid" value="<%=workflowid%>" />
                <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
                <jsp:param name="canactive" value="<%=canactive%>" />
                <jsp:param name="deleted" value="<%=deleted%>" />
                <jsp:param name="nodeid" value="<%=nodeid%>" />
                <jsp:param name="requestid" value="<%=requestid%>" />
                <jsp:param name="requestlevel" value="<%=requestlevel%>" />
                <jsp:param name="isbill" value="<%=isbill%>" />
                <jsp:param name="billid" value="<%=billid%>" />
                <jsp:param name="formid" value="<%=formid%>" />
                <jsp:param name="isprint" value="1" />
                <jsp:param name="logintype" value="<%=logintype%>" />
                <jsp:param name="userid" value="<%=userid%>" />
                <jsp:param name="nodetype" value="<%=nodetype%>" />
                <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
                <jsp:param name="desrequestid" value="<%=desrequestid%>" />
                <jsp:param name="isrequest" value="<%=isrequest%>" />
                <jsp:param name="isurger" value="<%=isurger%>" />
                <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />
				<jsp:param name="isremark" value="2" />
            </jsp:include>
	<%}else{%>
            <jsp:include page="WorkflowViewRequestBodyAction.jsp" flush="true">
                <jsp:param name="workflowid" value="<%=workflowid%>" />
                <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
                <jsp:param name="canactive" value="<%=canactive%>" />
                <jsp:param name="deleted" value="<%=deleted%>" />
                <jsp:param name="nodeid" value="<%=nodeid%>" />
                <jsp:param name="requestid" value="<%=requestid%>" />
                <jsp:param name="requestlevel" value="<%=requestlevel%>" />
                <jsp:param name="isbill" value="<%=isbill%>" />
                <jsp:param name="billid" value="<%=billid%>" />
                <jsp:param name="formid" value="<%=formid%>" />
                <jsp:param name="isprint" value="<%=isprint%>" />
                <jsp:param name="logintype" value="<%=logintype%>" />
                <jsp:param name="userid" value="<%=userid%>" />
                <jsp:param name="nodetype" value="<%=nodetype%>" />
                <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
                <jsp:param name="desrequestid" value="<%=desrequestid%>" />
                <jsp:param name="isrequest" value="<%=isrequest%>" />
                <jsp:param name="isurger" value="<%=isurger%>" />
                <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />
                <jsp:param name="isOldWf" value="<%=isOldWf%>" />
            </jsp:include>
            <jsp:include page="WorkflowViewSignAction.jsp" flush="true">
                <jsp:param name="workflowid" value="<%=workflowid%>" />
                <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
                <jsp:param name="requestid" value="<%=requestid%>" />
                <jsp:param name="userid" value="<%=userid%>" />
                <jsp:param name="usertype" value="<%=usertype%>" />
                <jsp:param name="isprint" value="<%=isprint%>" />
                <jsp:param name="nodeid" value="<%=nodeid%>" />
                <jsp:param name="isOldWf" value="<%=isOldWf%>" />
                <jsp:param name="desrequestid" value="<%=desrequestid%>" />
                <jsp:param name="isurger" value="<%=isurger%>" />
                <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />	
            </jsp:include>
	<%}%>
</form>
<%}
}
int haslinkworkflow=Util.getIntValue(String.valueOf(session.getAttribute("haslinkworkflow")),0);
if(haslinkworkflow==1&&!isrequest.equals("1")){
    session.setAttribute("desrequestid",""+requestid);
}else{
    if(haslinkworkflow==0&&!isrequest.equals("1")){
        session.removeAttribute("desrequestid");
        int linkwfnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")),0);
        for(int i=0;i<=linkwfnum;i++){
            session.removeAttribute("resrequestid"+i);
        }
        session.removeAttribute("slinkwfnum");
    }
}
%>
	</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
</table>

</body>
</html>
<SCRIPT LANGUAGE="JavaScript">

try{
	window.opener.btnWfCenterReload.onclick();
}catch(e){}

if (window.addEventListener){
    window.addEventListener("load", windowOnload, false);
}else if (window.attachEvent){
    window.attachEvent("onload", windowOnload);
}else{
    window.onload=windowOnload;
}

function doRetract(obj){
obj.disabled=true;
document.location.href="/workflow/workflow/wfFunctionManageLink.jsp?flag=rb&requestid=<%=requestid%>" //xwj for td3665 20060224
}

function showWFHelp(docid){
    var screenWidth = window.screen.width*1;
    var screenHeight = window.screen.height*1;
    var operationPage = "/docs/docs/DocDsp.jsp?id="+docid;
    window.open(operationPage,"_blank","top=0,left="+(screenWidth-800)/2+",height="+(screenHeight-90)+",width=800,status=no,scrollbars=yes,toolbar=yes,menubar=no,location=no");
}
// modify by xhheng @20050304 for TD 1691
function openSignPrint1() {
    var redirectUrl = "PrintMode.jsp?requestid=<%=requestid%>&isbill=<%=isbill%>&workflowid=<%=workflowid%>&formid=<%=formid%>&nodeid=<%=nodeid%>&billid=<%=billid%>&fromFlowDoc=1&urger=<%=urger%>&ismonitor=<%=ismonitor%>" ;
  var width = screen.availWidth-10 ;
  var height = screen.availHeight-50 ;
  //if (height == 768 ) height -= 75 ;
  //if (height == 600 ) height -= 60 ;
   var szFeatures = "top=0," ;
  szFeatures +="left=0," ;
  szFeatures +="width="+width+"," ;
  szFeatures +="height="+height+"," ;
  szFeatures +="directories=no," ;
  szFeatures +="status=yes,toolbar=no,location=no," ;
  szFeatures +="menubar=no," ;
  szFeatures +="scrollbars=yes," ;
  szFeatures +="resizable=yes" ; //channelmode
  window.open(redirectUrl,"",szFeatures) ;
}

//TD4262 ������ʾ��Ϣ  ��ʼ
//��ʾ����
<%
    if(modeid>0 && "1".equals(ismode)){
%>
var oPopup;
try{
    oPopup = window.createPopup()
}
catch(e){}
function showObjectPopup(contentBox){
  try{
    var iX=document.body.offsetWidth/2-50;
	var iY=document.body.offsetHeight/2+document.body.scrollTop-50;

	var oPopBody = oPopup.document.body;
    oPopBody.style.border = "1px solid #8888AA";
    oPopBody.style.backgroundColor = "white";
    oPopBody.style.position = "absolute";
    oPopBody.style.padding = "0px";
    oPopBody.style.zindex = 150;

    oPopBody.innerHTML = contentBox.innerHTML;

    oPopup.show(iX, iY, 180, 22, document.body);
  }catch(e){}
}
function displaydivSign()
{
	var oDivSign = $GetEle("oDivSign");
    if(oDivSign.style.display == ""){
        oDivSign.style.display = "none";
        $GetEle("workflowSignLabelSpan").innerHTML = "<font color=red><%=SystemEnv.getHtmlLabelName(21199,user.getLanguage())%></font>";
		if($GetEle("oDiv").style.display == "none" && $GetEle("oDivInner").style.display == "none" && oDivSign.style.display == "none"){
			$GetEle("oDivAll").style.display = "none";
		    $GetEle("spanimage").innerHTML = "<img src='/images/ArrowDownRed.gif' border=0>" ;
		}
    }
    else{
        oDivSign.style.display = "";
        $GetEle("workflowSignLabelSpan").innerHTML = "<font color=green><%=SystemEnv.getHtmlLabelName(21200,user.getLanguage())%></font>";
    }
}
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showallreceived(operator,operatedate,operatetime,returntdid,viewLogIds,logtype,destnodeid){
    <%
    if(modeid>0 && "1".equals(ismode)){
    %>
    showObjectPopup(document.getElementById("divFavContent19205"));
    <%}else{%>
    showPrompt("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");
    <%}%>
    var ajax=ajaxinit();
    ajax.open("POST", "WorkflowReceiviedPersons.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid=<%=requestid%>&viewnodeIds="+viewLogIds+"&operator="+operator+"&operatedate="+operatedate+"&operatetime="+operatetime+"&returntdid="+returntdid+"&logtype="+logtype+"&destnodeid="+destnodeid);
    //��ȡִ��״̬
    ajax.onreadystatechange = function() {
        //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
            document.all(returntdid).innerHTML = ajax.responseText;
            }catch(e){}
            hiddenPop();
        }
    }
}
function displaydiv_1()
{
	var WorkFlowDiv = $GetEle("WorkFlowDiv");
	var WorkFlowspan = $GetEle("WorkFlowspan");
    if(WorkFlowDiv.style.display == ""){
        WorkFlowDiv.style.display = "none";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></span>";
    } else {
        WorkFlowDiv.style.display = "";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></span>";
    }
}
function openSignPrint() {
  var redirectUrl = "PrintRequest.jsp?requestid=<%=requestid%>&isprint=1&fromFlowDoc=1&urger=<%=urger%>&ismonitor=<%=ismonitor%>" ;
  <%//���������̴�ӡȨ������  
  if(wflinkno>=0){
  %>
  redirectUrl = "PrintRequest.jsp?requestid=<%=requestid%>&isprint=1&fromFlowDoc=1&isrequest=1&wflinkno=<%=wflinkno%>&urger=<%=urger%>&ismonitor=<%=ismonitor%>";
  <%}%>  
  var width = screen.width ;
  var height = screen.height ;
  if (height == 768 ) height -= 75 ;
  if (height == 600 ) height -= 60 ;
  var szFeatures = "top=0," ;
  szFeatures +="left=0," ;
  szFeatures +="width="+width+"," ;
  szFeatures +="height="+height+"," ;
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
  szFeatures +="menubar=no," ;
szFeatures +="toolbar=yes," ;
  szFeatures +="scrollbars=yes," ;

  szFeatures +="resizable=yes" ; //channelmode
  window.open(redirectUrl,"",szFeatures) ;
}        
<%
    }else{
%>
var showTableDiv  = document.getElementById('_xTable');
var oIframe = document.createElement('iframe');
function showPrompt(content)
{
     var message_table_Div = document.createElement("div")
     message_table_Div.id="message_table_Div";
     message_table_Div.className="xTable_message";
     showTableDiv.appendChild(message_table_Div);
     var message_table_Div  = document.getElementById("message_table_Div");
     message_table_Div.style.display="inline";
     message_table_Div.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_table_Div.style.position="absolute"
     message_table_Div.style.top=pTop;
     message_table_Div.style.left=pLeft;

     message_table_Div.style.zIndex=1002;
     //oIframe = document.createElement('iframe');
     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_table_Div.style.zIndex - 1;
     oIframe.style.width = parseInt(message_table_Div.offsetWidth);
     oIframe.style.height = parseInt(message_table_Div.offsetHeight);
     oIframe.style.display = 'block';

}
<%
    }
%>
//TD4262 ������ʾ��Ϣ  ����


function returnTrue(o){
	return;
}

function addDocReadTag(docId) {
	//user.getLogintype() ��ǰ�û�����  1: ����û�  2:�ⲿ�û�
	DocReadTagUtil.addDocReadTag(docId,<%=user.getUID()%>,<%=user.getLogintype()%>,"<%=request.getRemoteAddr()%>",returnTrue);

}
function doReview(){
        var id = <%=requestid%>;
        //document.location.href="/workflow/request/Remark.jsp?requestid="+id; //xwj for td3247 20051201
		 <%if (!fromFlowDoc.equals("1")) {%>
        document.location.href="/workflow/request/Remark.jsp?requestid="+id; //xwj for td3247 20051201
		<%}else {%>
        parent.document.location.href="/workflow/request/Remark.jsp?requestid="+id; 
		<%}%>
   }
function onAddPhrase(phrase){            <!-- ��ӳ��ö��� -->
    if(phrase!=null && phrase!=""){
      var remarkValue= document.all("remark").value;
      document.all("remark").value = remarkValue + "\n" + phrase ;
    }
  }
<%if (isurger){%>
function doSupervise(obj)
{
        <% if(ismode.equals("1")){ %>
        contentBox = document.getElementById("divFavContent18978");
        showObjectPopup(contentBox)
    <% }else{ %>
        var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
        showPrompt(content);
    <%  } %>
        $G("src").value='supervise';
        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
}
<%}%>
/** added by cyril on 2008-07-09 for TD:8835*/
function doViewModifyLog() {
	var logURL = "/workflow/request/RequestModifyLogView.jsp?requestid=<%=requestid%>&nodeid=<%=nodeid%>&isAll=0&ismonitor=<%=ismonitor%>&urger=<%=urger%>";
	window.open(logURL);
	/*
	if(parent!=null)
		parent.document.location.href = logURL;
	else
		document.location.href = logURL;
	*/
}
/** end by cyril on 008-07-09 for TD:8835*/
function onNewRequest(wfid,requestid,agent){
	var redirectUrl =  "AddRequest.jsp?workflowid="+wfid+"&isagent="+agent+"&reqid="+requestid;
	var width = screen.availWidth-10 ;
	var height = screen.availHeight-50 ;
	var szFeatures = "top=0," ;
	szFeatures +="left=0," ;
	szFeatures +="width="+width+"," ;
	szFeatures +="height="+height+"," ;
	szFeatures +="directories=no," ;
	szFeatures +="status=yes,toolbar=no,location=no," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ; //channelmode
	window.open(redirectUrl,"",szFeatures) ;
}
function onNewSms(wfid, nodeid, reqid){
	var redirectUrl =  "/sms/SendRequestSms.jsp?workflowid="+wfid+"&nodeid="+nodeid+"&reqid="+reqid;
	var width = screen.availWidth/2;
	var height = screen.availHeight/2;
	var top = height/2;
	var left = width/2;
	var szFeatures = "top="+top+"," ;
	szFeatures +="left="+left+"," ;
	szFeatures +="width="+width+"," ;
	szFeatures +="height="+height+"," ;
	szFeatures +="directories=no," ;
	szFeatures +="status=yes,toolbar=no,location=no," ;
	szFeatures +="menubar=no," ;
	szFeatures +="scrollbars=yes," ;
	szFeatures +="resizable=yes" ; //channelmode
	window.open(redirectUrl,"",szFeatures) ;
}
</SCRIPT>
