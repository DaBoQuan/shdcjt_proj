<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.workflow.request.RequestConstants" %>
<%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="MeetingComInfo" class="weaver.meeting.Maint.MeetingComInfo" scope="page"/>
<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for @td2977 20051111-->
<jsp:useBean id="DocUtil" class="weaver.docs.docs.DocUtil" scope="page" /><%----- xwj for td3323 20051209  ------%>
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="scci" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="WorkflowPhrase" class="weaver.workflow.sysPhrase.WorkflowPhrase" scope="page"/>
<jsp:useBean id="RecordSetLog" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<jsp:useBean id="RecordSetLog1" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<jsp:useBean id="RecordSetLog2" class="weaver.conn.RecordSet" scope="page" /><%--xwj for td2140  2005-07-25 --%>
<jsp:useBean id="RecordSetOld" class="weaver.conn.RecordSet" scope="page" /> <%-- xwj for td2104 on 20050802--%>
<jsp:useBean id="RecordSetlog3" class="weaver.conn.RecordSet" scope="page" /> <%-- added by xwj for td2891--%>
<jsp:useBean id="rsaddop" class="weaver.conn.RecordSet" scope="page" />
<%@page import = "weaver.general.TimeUtil"%><!--added by xwj for td2891-->
<jsp:useBean id="rsCheckUserCreater" class="weaver.conn.RecordSet" scope="page" /> <%-- added by xwj for td2891--%>
<jsp:useBean id="WfLinkageInfo" class="weaver.workflow.workflow.WfLinkageInfo" scope="page"/>
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="RequestLogOperateName" class="weaver.workflow.request.RequestLogOperateName" scope="page"/>
<jsp:useBean id="resourceComInfo_mbm" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="departmentComInfo_mbm" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="docinfmeet" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="wfrequestcominfomeet" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfomeet" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page"/>
<script type="text/javascript" language="javascript" src="/FCKEditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/FCKEditorExt.js"></script>
<!--������ʾ��Ϣ  ��ʼ-->
<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<!--������ʾ��Ϣ  ����-->
<form name="frmmain" method="post" action="BillMeetingOperation.jsp" enctype="multipart/form-data">
<input type="hidden" name="needwfback"  id="needwfback" value="1"/>
<input type="hidden" name="lastOperator"  id="lastOperator" value="<%=lastOperator%>"/>
<input type="hidden" name="lastOperateDate"  id="lastOperateDate" value="<%=lastOperateDate%>"/>
<input type="hidden" name="lastOperateTime"  id="lastOperateTime" value="<%=lastOperateTime%>"/>
<input type="hidden" name="htmlfieldids">
<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</DIV>
<!--����ı������ -->
<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<BR>
<%----- xwj for td3323 20051209 begin ------%>
<%
int languagebodyid = user.getLanguage() ;
HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
String needconfirm="";
String isannexupload_edit="";
String annexdocCategory_edit="";
String isSignDoc_edit="";
String isSignWorkflow_edit="";
String showDocTab_edit="";
String showWorkflowTab_edit="";
String showUploadTab_edit="";
RecordSetLog.execute("select needAffirmance,isannexupload,annexdocCategory,isSignDoc,isSignWorkflow,showDocTab,showWorkflowTab,showUploadTab from workflow_base where id="+workflowid);
if(RecordSetLog.next()){
    needconfirm=Util.null2o(RecordSetLog.getString("needAffirmance"));
    isannexupload_edit=Util.null2String(RecordSetLog.getString("isannexupload"));
    annexdocCategory_edit=Util.null2String(RecordSetLog.getString("annexdocCategory"));
    isSignDoc_edit=Util.null2String(RecordSetLog.getString("isSignDoc"));
    isSignWorkflow_edit=Util.null2String(RecordSetLog.getString("isSignWorkflow"));
    showDocTab_edit=Util.null2String(RecordSetLog.getString("showDocTab"));
    showWorkflowTab_edit=Util.null2String(RecordSetLog.getString("showWorkflowTab"));
    showUploadTab_edit=Util.null2String(RecordSetLog.getString("showUploadTab"));
}
    String ismode= Util.null2String(request.getParameter("ismode"));


String newfromtime="";
String newendtime="";
String Address="";
 RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid+"");
 String docCategory_ = "";
 if(RecordSet.next()){
	docCategory_ = RecordSet.getString("docCategory");
 }
 int secid = Util.getIntValue(docCategory_.substring(docCategory_.lastIndexOf(",")+1),-1);
 int maxUploadImageSize = DocUtil.getMaxUploadImageSize(secid);
 if(maxUploadImageSize<=0){
 maxUploadImageSize = 5;
 }
ArrayList selfieldsadd=WfLinkageInfo.getSelectField(workflowid,nodeid,0);
ArrayList changefieldsadd=WfLinkageInfo.getChangeField(workflowid,nodeid,0);
String isSignMustInput="0";
String needcheck10404 = "";
RecordSet.execute("select issignmustinput from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSet.next()){
	isSignMustInput = ""+Util.getIntValue(RecordSet.getString("issignmustinput"), 0);
	if("1".equals(isSignMustInput)){
		needcheck10404 = ",remarkText10404";
	}
}
%>
<script language=javascript>
function accesoryChanage(obj){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        var oFile=$GetEle("oFile");
        oFile.FilePath=objValue;
        fileLenth= oFile.getFileSize();
    } catch (e){
        alert("���ڼ���ļ��ϴ���С�Ŀؼ�û�а�װ������IE���ã��������Ա��ϵ��");
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1)
    if (fileLenthByM><%=maxUploadImageSize%>) {
        alert("��������Ϊ:"+fileLenthByM+"M,��Ŀ¼�²����ϴ�����<%=maxUploadImageSize%>M���ļ�,�����Ҫ���ʹ��ļ�,�������Ա��ϵ!");
        createAndRemoveObj(obj);
    }
}

function createAndRemoveObj(obj){
    objName = obj.name;
    var  newObj = document.createElement("input");
    newObj.name=objName;
    newObj.className="InputStyle";
    newObj.type="file";
    newObj.size=70;
    newObj.onchange=function(){accesoryChanage(this);};

    var objParentNode = obj.parentNode;
    var objNextNode = obj.nextSibling;
    obj.removeNode();
    objParentNode.insertBefore(newObj,objNextNode);
}
</script>
<%----- xwj for td3323 20051209 end ------%>
<TABLE class="ViewForm">
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">

  <%//xwj for td1834 on 2005-05-22
    String isEdit_ = "-1";
    RecordSet.executeSql("select isedit from workflow_nodeform where nodeid = " + String.valueOf(nodeid) + " and fieldid = -1");
    if(RecordSet.next()){
   isEdit_ = Util.null2String(RecordSet.getString("isedit"));
    }

    //��ô����ֶ��� mackjoe 2005-07-22
    DynamicDataInput ddi=new DynamicDataInput(workflowid+"");
    String trrigerfield=ddi.GetEntryTriggerFieldName();

  %>

  <!--�½��ĵ�һ�У�����˵������Ҫ�� -->
  <TR class="Spacing" style="height:1px;">
    <TD class="Line1" colSpan=2></TD>
  </TR>
  <TR>
    <TD><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></TD>
    <TD class=field>

        <%if(!"1".equals(isEdit_)){//xwj for td1834 on 2005-05-22
          if(!"0".equals(nodetype)){%>
       <%=Util.toScreenToEdit(requestname,user.getLanguage())%>
       <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,user.getLanguage())%>">
          <%}
          else{%>
          <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit(requestname,user.getLanguage())%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,user.getLanguage()))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
          <%}
         }
       else{%>
        <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit(requestname,user.getLanguage())%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,user.getLanguage()))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%}%>

      <%
      String isEditREQL = "-1";
      if(!"0".equals(nodetype)){
          RecordSet.executeSql("select isedit from workflow_nodeform where nodeid = " + String.valueOf(nodeid) + " and fieldid = -2");
          if(RecordSet.next()) isEditREQL = Util.null2String(RecordSet.getString("isedit"));
      }
      if("0".equals(nodetype)||(!"0".equals(nodetype)&&isEditREQL.equals("1"))){%>
      <input type=radio value="0" name="requestlevel" <%if(requestlevel.equals("0")){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <input type=radio value="1" name="requestlevel" <%if(requestlevel.equals("1")){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <input type=radio value="2" name="requestlevel" <%if(requestlevel.equals("2")){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%>
      <%}else{%>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
      <%}%>

        </TD></TR>
        <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
      <!--add by xhheng @ 2005/01/25 for ��Ϣ���� Request06����ת�����в쿴�������� -->
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%
      String sqlWfMessage = "select messageType,docCategory from workflow_base where id="+workflowid;
      int wfMessageType=0;
      String docCategory="";
      rs.executeSql(sqlWfMessage);
      if (rs.next()) {
        wfMessageType=rs.getInt("messageType");
        docCategory=rs.getString("docCategory");
      }
      if(wfMessageType == 1){
        String sqlRqMessage = "select messageType from workflow_requestbase where requestid="+requestid;
        int rqMessageType=0;
        rs.executeSql(sqlRqMessage);
        if (rs.next()) {
          rqMessageType=rs.getInt("messageType");
        }%>
        <%
        String isEditMSG = "-1";
        if(!"0".equals(nodetype)){
            RecordSet.executeSql("select isedit from workflow_nodeform where nodeid = " + String.valueOf(nodeid) + " and fieldid = -3");
            if(RecordSet.next()) isEditMSG = Util.null2String(RecordSet.getString("isedit"));
        }%>
        <TR>
        <TD > <%=SystemEnv.getHtmlLabelName(17586,user.getLanguage())%></TD>
        <td class=field>
        <%if( "0".equals(nodetype) || (!"0".equals(nodetype)&&isEditMSG.equals("1")) ){%>
        <span id=messageTypeSpan></span>
        <input type=radio value="0" name="messageType"   <%if(rqMessageType==0){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%>
        <input type=radio value="1" name="messageType"   <%if(rqMessageType==1){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%>
        <input type=radio value="2" name="messageType"   <%if(rqMessageType==2){%>checked<%}%>><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%>
        <%}else{%>
        <%if(rqMessageType==0){%><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%>
        <%} else if(rqMessageType==1){%><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%>
        <%} else if(rqMessageType==2){%><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%> <%}%>
			<input type="hidden" value="<%=rqMessageType%>" id="messageType" name="messageType">
        <%}%>
        </TD></TR>
        <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
      <%}%>
  <!--��һ�н��� -->
  <%
  if(formid==163){%>
  <TR>
  	<TD>����ʹ�����</TD>
  	<TD class=field><a href="/car/CarUseInfo.jsp" target="_blank">�鿴</a></TD>
  </TR>
  <TR style="height:1px;"><TD class=Line2 colSpan=2></TD></TR>
  <%}%>
<%

//��ѯ�����ߵ��ݵ��ֶ�,�ֶε����ƣ��ֶε�HTML���ͺ��ֶε����ͣ�����HTML���͵�һ����չ��
String remindBeforeStart = "";
String remindBeforeEnd = "";
String remindBeforeStartV = "";
String remindBeforeEndV = "";
String remindTimesBeforeStart = "";
String remindTimesBeforeEnd = "";
int temmhour=0;
int temptinme=0;
int temmhourend=0;
int temptinmeend=0;
ArrayList fieldids=new ArrayList();             //�ֶζ���
ArrayList fieldorders = new ArrayList();        //�ֶ���ʾ˳����� (�����ļ�����Ҫ)
ArrayList languageids=new ArrayList();          //�ֶ���ʾ������(�����ļ�����Ҫ)
ArrayList fieldlabels=new ArrayList();          //���ݵ��ֶε�label����
ArrayList fieldhtmltypes=new ArrayList();       //���ݵ��ֶε�html type����
ArrayList fieldtypes=new ArrayList();           //���ݵ��ֶε�type����
ArrayList fieldnames=new ArrayList();           //���ݵ��ֶεı��ֶ�������
ArrayList fieldvalues=new ArrayList();          //�ֶε�ֵ
ArrayList fieldviewtypes=new ArrayList();       //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)
ArrayList fieldimgwidths=new ArrayList();
ArrayList fieldimgheights=new ArrayList();
ArrayList fieldimgnums=new ArrayList();
int detailno=0;
int detailsum=0;
String textheight = "4";//xwj for @td2977 20051111

if(isbill.equals("0")) {
    RecordSet.executeSql("select t2.fieldid,t2.fieldorder,t1.fieldlable,t1.langurageid from workflow_fieldlable t1,workflow_formfield t2 where t1.formid=t2.formid and t1.fieldid=t2.fieldid and (t2.isdetail<>'1' or t2.isdetail is null)  and t2.formid="+formid+"  and t1.langurageid="+user.getLanguage()+" order by t2.fieldorder");

    while(RecordSet.next()){
        fieldids.add(Util.null2String(RecordSet.getString("fieldid")));
        fieldorders.add(Util.null2String(RecordSet.getString("fieldorder")));
        fieldlabels.add(Util.null2String(RecordSet.getString("fieldlable")));
        languageids.add(Util.null2String(RecordSet.getString("langurageid")));
    }
}
else {
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
    while(RecordSet.next()){
        fieldids.add(Util.null2String(RecordSet.getString("id")));
        fieldlabels.add(Util.null2String(RecordSet.getString("fieldlabel")));
        fieldhtmltypes.add(Util.null2String(RecordSet.getString("fieldhtmltype")));
        fieldtypes.add(Util.null2String(RecordSet.getString("type")));
        fieldnames.add(Util.null2String(RecordSet.getString("fieldname")));
        fieldviewtypes.add(Util.null2String(RecordSet.getString("viewtype")));
        fieldimgwidths.add(Util.null2String(RecordSet.getString("imgwidth")));
        fieldimgheights.add(Util.null2String(RecordSet.getString("imgheight")));
        fieldimgnums.add(Util.null2String(RecordSet.getString("textheight")));
          RecordSet_nf1.executeSql("select * from workflow_nodeform where nodeid = "+nodeid+" and fieldid = " + RecordSet.getString("id"));
        if(!RecordSet_nf1.next()){
        RecordSet_nf2.executeSql("insert into workflow_nodeform(nodeid,fieldid,isview,isedit,ismandatory) values("+nodeid+","+RecordSet.getString("id")+",'1','1','0')");
        }
    }
}

// ��ѯÿһ���ֶε�ֵ
if( !isbill.equals("1")) {
    RecordSet.executeProc("workflow_FieldValue_Select",requestid+"");       // ��workflow_form���в�
    RecordSet.next();
    for(int i=0;i<fieldids.size();i++){
        String fieldname=FieldComInfo.getFieldname((String)fieldids.get(i));
        fieldvalues.add(Util.null2String(RecordSet.getString(fieldname)));
    }
}
else {
    RecordSet.executeSql("select tablename from workflow_bill where id = " + formid) ; // ��ѯ���������ݱ����Ϣ
    RecordSet.next();
    String tablename = RecordSet.getString("tablename") ;
    RecordSet.executeSql("select * from " + tablename + " where id = " + billid) ; // ����Ĭ�ϵĵ��ݱ�,������id��Ϊ��������Primary key, billid��ֵ����id. �������,����Ҫ��д�������. ����,Ĭ�ϵĵ��ݱ������ requestid ���ֶ�

    RecordSet.next();
    for(int i=0;i<fieldids.size();i++){
        String fieldname=(String)fieldnames.get(i);
        String tfieldvalue = Util.null2String(RecordSet.getString(fieldname));
        if("remindType".equals(fieldname))
        {
        	tfieldvalue = ""+Util.getIntValue(tfieldvalue,1);
        }
        fieldvalues.add(tfieldvalue);        
        if("remindBeforeStart".equals(fieldname))
        {
        	remindBeforeStartV = tfieldvalue;
        }
        if("remindBeforeEnd".equals(fieldname))
        {
        	remindBeforeEndV = tfieldvalue;
        }
        if("remindTimesBeforeStart".equals(fieldname))
        {
        	temmhour=Util.getIntValue(tfieldvalue,0)/60;
    		temptinme=Util.getIntValue(tfieldvalue,0)%60;
        }
        if("remindTimesBeforeEnd".equals(fieldname))
        {
    		temmhourend=Util.getIntValue(tfieldvalue,0)/60;
    		temptinmeend=Util.getIntValue(tfieldvalue,0)%60;
        }
    }
}

// ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
String resourceFieldId = "";
String crmFieldId = "";
String resourceNumFieldId = "";
ArrayList isfieldids=new ArrayList();              //�ֶζ���
ArrayList isviews=new ArrayList();              //�ֶ��Ƿ���ʾ����
ArrayList isedits=new ArrayList();              //�ֶ��Ƿ���Ա༭����
ArrayList ismands=new ArrayList();              //�ֶ��Ƿ�����������

RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
while(RecordSet.next()){
    isfieldids.add(Util.null2String(RecordSet.getString("fieldid")));
    isviews.add(Util.null2String(RecordSet.getString("isview")));
    isedits.add(Util.null2String(RecordSet.getString("isedit")));
    ismands.add(Util.null2String(RecordSet.getString("ismandatory")));
}


// �õ�ÿ���ֶε���Ϣ����ҳ����ʾ

for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ
	int tmpindex = i ;
    if(isbill.equals("0")) tmpindex = fieldorders.indexOf(""+i);     // ����Ǳ�, �õ���˳���Ӧ�� i

	String fieldid=(String)fieldids.get(tmpindex);  //�ֶ�id

    if( isbill.equals("1")) {
        String viewtype = (String)fieldviewtypes.get(tmpindex) ;   // ����ǵ��ݵĴӱ��ֶ�,����ʾ
        if( viewtype.equals("1") ) continue ;
    }

    String isview="0" ;    //�ֶ��Ƿ���ʾ
	String isedit="0" ;    //�ֶ��Ƿ���Ա༭
	String ismand="0" ;    //�ֶ��Ƿ��������

    int isfieldidindex = isfieldids.indexOf(fieldid) ;
    if( isfieldidindex != -1 ) {
        isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
	    isedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
	    ismand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
    }

    String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
    String fieldhtmltype = "" ;                     //�ֶε�ҳ������
    String fieldtype = "" ;                         //�ֶε�����
    String fieldlable = "" ;                        //�ֶ���ʾ��
    int languageid = 0 ;
    int fieldimgwidth=0;                            //ͼƬ�ֶο��
    int fieldimgheight=0;                           //ͼƬ�ֶθ߶�
    int fieldimgnum=0;                              //ÿ����ʾͼƬ����

    if(isbill.equals("0")) {
        languageid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
        fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
        fieldtype=FieldComInfo.getFieldType(fieldid);
        fieldlable=(String)fieldlabels.get(tmpindex);
        fieldname=FieldComInfo.getFieldname(fieldid);
        fieldimgwidth=FieldComInfo.getImgWidth(fieldid);
		fieldimgheight=FieldComInfo.getImgHeight(fieldid);
		fieldimgnum=FieldComInfo.getImgNumPreRow(fieldid);
    }
    else {
        languageid = user.getLanguage() ;
        fieldname=(String)fieldnames.get(tmpindex);
        fieldhtmltype=(String)fieldhtmltypes.get(tmpindex);
        fieldtype=(String)fieldtypes.get(tmpindex);
        fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(tmpindex),0),languageid );
        fieldimgwidth=Util.getIntValue((String)fieldimgwidths.get(tmpindex),0);
		fieldimgheight=Util.getIntValue((String)fieldimgheights.get(tmpindex),0);
		fieldimgnum=Util.getIntValue((String)fieldimgnums.get(tmpindex),0);
    }
    String fieldvalue=(String)fieldvalues.get(tmpindex);

    if(fieldname.equals("manager")) {
	    String tmpmanagerid = ResourceComInfo.getManagerID(""+userid);
%>
	<input type=hidden name="field<%=fieldid%>" value="<%=tmpmanagerid%>">
<%
	    continue;
	}

	if(fieldname.equalsIgnoreCase("begindate")) newfromdate="field"+fieldid;      //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if(fieldname.equalsIgnoreCase("enddate")) newenddate="field"+fieldid;     //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
    if(fieldname.equalsIgnoreCase("begintime")) newfromtime="field"+fieldid;
    if(fieldname.equalsIgnoreCase("endtime")) newendtime="field"+fieldid;
    if(fieldname.equalsIgnoreCase("Address")) Address="field"+fieldid;
    if(fieldname.equalsIgnoreCase("remindBeforeStart")) remindBeforeStart="field"+fieldid;
    if(fieldname.equalsIgnoreCase("remindBeforeEnd")) remindBeforeEnd="field"+fieldid;
    if(fieldname.equalsIgnoreCase("remindTimesBeforeStart")) remindTimesBeforeStart="field"+fieldid;
    if(fieldname.equalsIgnoreCase("remindTimesBeforeEnd")) remindTimesBeforeEnd="field"+fieldid;
    
    
    if(fieldname.equalsIgnoreCase("resources"))
    {
        resourceFieldId = "field" + fieldid;
    }
    if(fieldname.equalsIgnoreCase("crms"))
    {
        crmFieldId = "field" + fieldid;
    }
    if(fieldname.equalsIgnoreCase("resourcenum"))
    {
        resourceNumFieldId = "field" + fieldid;
    }
    
    
    if(fieldhtmltype.equals("3") && fieldvalue.equals("0")) fieldvalue = "" ;
    if(fieldhtmltype.equals("1") && (fieldtype.equals("2") || fieldtype.equals("3")) && Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue = "" ;

    if(ismand.equals("1"))  needcheck+=",field"+fieldid;   //�����������,�����������ļ����

    // ���濪ʼ������ʾ�ֶ�
	if(fieldname.equalsIgnoreCase("remindBeforeStart")||fieldname.equalsIgnoreCase("remindBeforeEnd")||fieldname.equalsIgnoreCase("remindTimesBeforeStart")||fieldname.equalsIgnoreCase("remindTimesBeforeEnd"))
	{
    	out.println("<input type=hidden name=field"+fieldid+" value='"+fieldvalue+"'>");
    	continue;
	}
    if(isview.equals("1")){         // �ֶ���Ҫ��ʾ
%>
    <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%></td>
      <td class=field style="TEXT-VALIGN: center">
      <%
        if(fieldhtmltype.equals("1")){                          // �����ı���
        	
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(isedit.equals("1") && isremark==0 ){
                    if(ismand.equals("1")) {
      %>
        <input datatype="text" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" size=50 value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%

				    }else{%>
        <input datatype="text" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" size=50 onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))">
      <span id="field<%=fieldid%>span"></span>
      <%            }
			    }
                else {
      %>
        <span id="field<%=fieldid%>span"><%=Util.toScreen(fieldvalue,user.getLanguage())%></span>
         <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" >
      <%
                }
		    }
		    else if(fieldtype.equals("2")){                     // �����ı����е�����
			    if(isedit.equals("1") && isremark==0 ){
				    if(ismand.equals("1")) {
      %>
        <input datatype="int" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>"
		onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%

				    }else{%>
        <input datatype="int" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))" <%}%>>
      <span id="field<%=fieldid%>span"></span>
       <%           }
			    }
                else {
      %>
        <span id="field<%=fieldid%>span"><%=fieldvalue%></span>
         <input datatype="int" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
      <%
                }
		    }
		    else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
			    if(isedit.equals("1") && isremark==0 ){
				    if(ismand.equals("1")) {
       %>
        <input datatype="float" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>"
       onKeyPress="ItemNum_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
    				}else{%>
        <input datatype="float" type=text class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemNum_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))" <%}%>>
      <span id="field<%=fieldid%>span"></span>
       <%           }
			    }
                else {
      %>
        <span id="field<%=fieldid%>span"><%=fieldvalue%></span>
         <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
      <%
                }
		    }
		    /*------------- xwj for td3131 20051116 begin----------*/
    else if(fieldtype.equals("4")){     // �����ı����еĽ��ת��%>
            <TABLE cols=2 id="field<%=fieldid%>_tab">
                <tr><td>
                <%if(isedit.equals("1") && isremark==0 ){
                    if(ismand.equals("1")) {%>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>" size=60
                            onfocus="FormatToNumber('<%=fieldid%>')"
                            onKeyPress="ItemNum_KeyPress('field_lable<%=fieldid%>')"
                            <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>
                                onBlur="numberToFormat('<%=fieldid%>');
                                checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'));
                                datainput('field_lable<%=fieldid%>')"
                            <%}else{%>
                                onBlur="numberToFormat('<%=fieldid%>');
                                checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'))"
                            <%}%>
                        >
                    <span id="field_lable<%=fieldid%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                    <%}else{%>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>" size=60
                            onKeyPress="ItemNum_KeyPress('field_lable<%=fieldid%>')"
                            onfocus="FormatToNumber('<%=fieldid%>')"
                            <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>
                                onBlur="numberToFormat('<%=fieldid%>');
                                checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'));
                                datainput('field_lable<%=fieldid%>')"
                            <%}else{%>
                                onBlur="numberToFormat('<%=fieldid%>');checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'))"
                            <%}%>
                        >
                    <%}%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" type=hidden class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" value="<%=fieldvalue%>" >
                <%}else{%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>"  disabled="true" size=60>
                    <input datatype="float" type=hidden class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" value="<%=fieldvalue%>" >
                <%}%>
                </td></tr>
                <tr><td>
                    <input type=text class=Inputstyle size=60 name="field_chinglish<%=fieldid%>" readOnly="true">
                </td></tr>
                <script language="javascript">
                    $GetEle("field_lable"+<%=fieldid%>).value  = milfloatFormat(floatFormat(<%=fieldvalue%>));
                    $GetEle("field_chinglish"+<%=fieldid%>).value = numberChangeToChinese(<%=fieldvalue%>);
                </script>
            </table>
	    <%}
		    /*------------- xwj for td3131 20051116 end ----------*/
           if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
		  }                                                       // �����ı�����������
	    else if(fieldhtmltype.equals("2")){                     // �����ı���
	    /*-----xwj for @td2977 20051111 begin-----*/
	    if(isbill.equals("0")){
			 rscount.executeSql("select * from workflow_formdict where id = " + fieldid);
			 if(rscount.next()){
			 textheight = rscount.getString("textheight");
			 }
			 }
			    /*-----xwj for @td2977 20051111 begin-----*/
		    if(isedit.equals("1") && isremark==0 ){
		    	%>
				<script>$GetEle("htmlfieldids").value += "field<%=fieldid%>;<%=Util.toScreen(fieldlable,languagebodyid)%>,";</script>
					<%
			    if(ismand.equals("1")) {
       %>
        <textarea class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))"
		rows="<%=textheight%>" cols="40" style="width:80%" ><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
			    }else{
       %>
        <textarea class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" rows="<%=textheight%>" cols="40" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> style="width:80%" onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
      <span id="field<%=fieldid%>span"></span>
       <%       }
		    }
            else {
      %>
        <span id="field<%=fieldid%>span"><%=Util.toScreen(fieldvalue,user.getLanguage())%></span>
         <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" >
      <%
            }
            if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
	    }                                                           // �����ı�����������
	    else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl =BrowserComInfo.getLinkurl(fieldtype);   // ���ֵ�����ʱ�����ӵ�url
            String showname = "";                                                   // ֵ��ʾ������
            String showid = "";                                                     // ֵ

             String tablename=""; //������Ӧ�ı�,����������Դ��
             String columname=""; //������Ӧ�ı������ֶ�
             String keycolumname="";   //������Ӧ�ı�ֵ�ֶ�
             

             //add by dongping
             //����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
             if (fieldtype.equals("118")) {
             	showname ="<a href=/meeting/report/MeetingRoomPlan.jsp target=blank>�鿴������ʹ�����</a>" ;
        %>
            	<%=Util.toScreen(showname,user.getLanguage()) %>
        <%
             }
             else
             {
            // ����Ƕ��ĵ�, ��Ҫ�ж��Ƿ����¼�����ĵ�,�����,��Ҫ����ԭ���ĺ���
            if( fieldtype.equals("37") && fieldid.equals(docfileid) && !newdocid.equals("")) {
                if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                fieldvalue += newdocid ;
            }



            if(fieldtype.equals("2") ||fieldtype.equals("19")  )	showname=fieldvalue; // ����ʱ��
            else if(!fieldvalue.equals("")) {
                 tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                 columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                 keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                //add by wang jinyong
                HashMap temRes = new HashMap();

                if(fieldtype.equals("135")||fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")||fieldtype.equals("160")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }

                RecordSet.executeSql(sql);
                while(RecordSet.next()){
                    showid = Util.null2String(RecordSet.getString(1)) ;
                    String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                    if(!linkurl.equals("")){
                        if(fieldtype.equals("16")){
                              int tempnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
                              tempnum++;
                              session.setAttribute("resrequestid"+tempnum,""+showid);
                              session.setAttribute("slinkwfnum",""+tempnum);
                              temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"&wflinkno="+tempnum+"'>"+tempshowname+"</a> " );
                              session.setAttribute("haslinkworkflow","1");
                          }else{
                              temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " );
                          }
                    }else{
                        //showname += tempshowname ;
                        temRes.put(String.valueOf(showid),tempshowname);
                    }
                }
                StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                String temstkvalue = "";
                while(temstk.hasMoreTokens()){
                    temstkvalue = temstk.nextToken();

                    if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                        showname += temRes.get(temstkvalue);
                    }
                }

            }

			 /*��ʼ��*/
            //String url=BrowserComInfo.getBrowserurl(fieldbodytype);     // �����ť����ҳ���url
		    //String linkurl=BrowserComInfo.getLinkurl(fieldbodytype);    // ���ֵ�����ʱ�����ӵ�url
		    //String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
		    //String showid = "";                                     // �½�ʱ��Ĭ��ֵ
			if(fieldtype.equals("89")){//�����ťΪ�������ͣ���������ֻѡ�����������Ǹ�����������������
                url += "?approver="+workflowid;
            }
            if (nodetype.equals("0")&&fieldvalue.equals("")&&false)
			{
            if((fieldtype.equals("1") ||fieldtype.equals("17")) && !(""+creater).equals("")){ //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(""+creater,0);
            }else if(fieldtype.equals("4") && !(""+creater).equals("")){ //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(""+creater),0);
            }else if(fieldtype.equals("24") && !(""+creater).equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(""+creater),0);
            }else if(fieldtype.equals("32") && !(""+creater).equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"),0);
            }

            if(fieldtype.equals("2")){
                showname = currentdate;
                showid = currentdate;
            }

            if(showid.equals("0")) showid = "" ;

            if(! showid.equals("")){       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
                 tablename=BrowserComInfo.getBrowsertablename(fieldtype);
                 columname=BrowserComInfo.getBrowsercolumname(fieldtype);
                 keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);
                 sql="";
                if(showid.indexOf(",")==-1){
                    sql="select "+columname+" from "+tablename+" where "+keycolumname+"="+showid;
                }else{
                    sql="select "+columname+" from "+tablename+" where "+keycolumname+" in("+showid+")";
                }

                RecordSet.executeSql(sql);
                while(RecordSet.next()) {
                    if(!linkurl.equals(""))
                    {
        				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                    	{
                    		showname = "<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + RecordSet.getString(1) + "</a>&nbsp";
                    	}
        				else
        					showname = "<a href='"+linkurl+showid+"'>"+RecordSet.getString(1)+"</a>&nbsp";
        			}
                    else
                        showname +=RecordSet.getString(1) ;
                }
            }
			fieldvalue=showid;
			}
			/*��ʼ������*/

            if(isedit.equals("1") && isremark==0 ){
                if(!fieldtype.equals("37") && !fieldtype.equals("160")) {    //  ���ĵ����⴦��
	   %>
        <button type=button  class=Browser 
		<%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'));datainput('field<%=fieldid%>'), countAttend();"
		<%}else{ if(fieldtype.equals("2")){%>
		onclick ="onShowFlowDate('<%=fieldid%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))"
		<%}if(fieldtype.equals("19")){%>
		 onclick ="onWorkFlowShowTime(field<%=fieldid%>span,field<%=fieldid%>,field<%=fieldid%>.getAttribute('viewtype'))"
		<%}else{%>
		onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype')), countAttend()"
		<%}}%> 
		title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
       <%       }else if(fieldtype.equals("160")){
                rsaddop.execute("select a.level_n from workflow_groupdetail a ,workflow_nodegroup b where a.groupid=b.id and a.type=50 and a.objid="+fieldid+" and b.nodeid in (select nodeid from workflow_flownode where workflowid="+workflowid+") ");
				String roleid="";
				if (rsaddop.next())
				{
				roleid=rsaddop.getString(1);
				}
%>
        <button type=button  class=Browser  onclick="onShowResourceRole('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'),'<%=roleid%>')" title="<%=SystemEnv.getHtmlLabelName(20570,user.getLanguage())%>"></button>
<%
			  }else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button type=button  class=AddDoc onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp;<button type=button  class=AddDoc onclick="onNewDoc(<%=fieldid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
       <%       }
            }
       %>
        <span id="field<%=fieldid%>span"><%=showname%>
       <%
            if( ismand.equals("1") && fieldvalue.equals("")){
       %>
        <img src="/images/BacoError.gif" align=absmiddle>
       <%
            }
       %>
        </span> <input type=hidden viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" value="<%=fieldvalue%>">
       <% }
       if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
	    }                                                    // �����ť��������
	    else if(fieldhtmltype.equals("4")) {                    // check��
	   %>
        <input type=checkbox viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" value=1 name="field<%=fieldid%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onChange="datainput('field<%=fieldid%>');" <%}%> <%if(fieldvalue.equals("1")){%> checked <%}%> >
        <%if(isedit.equals("0") || isremark==1 ){%>
        <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
        <%}%>
       <%
            if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
        	String otherEvent= "";
        	if("remindType".equals(fieldname))
    	    {
        		otherEvent = "showRemindTime(this);";
    	    }
	   %>
        <select class=inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" <%if(ismand.equals("1")){%>onBlur="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));"<%}%> <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0&&selfieldsadd.indexOf(fieldid)>=0){%> onChange="<%=otherEvent %>datainput('field<%=fieldid%>');changeshowattr('<%=fieldid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);" <%}else if(selfieldsadd.indexOf(fieldid)>=0){ %> onChange="<%=otherEvent %>changeshowattr('<%=fieldid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);" <%}else{%> onChange="<%=otherEvent %>" <%}%>><!--added by xwj for td3313 20051206 -->
	    <option value=""></option><!--added by xwj for td3297 20051130 -->
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
            rs.executeProc("workflow_selectitembyid_new",""+fieldid+flag+isbill);
             boolean checkempty = true;//xwj for td3313 20051206
			      String finalvalue = "";//xwj for td3313 20051206
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                 /* -------- xwj for td3313 20051206 begin -*/
                 if(tmpselectvalue.equals(fieldvalue)){
				          checkempty = false;
				          finalvalue = tmpselectvalue;
				         }
				         /* -------- xwj for td3313 20051206 end -*/
	   %>
	    <option value="<%=tmpselectvalue%>" <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
	   <%
            }
       %>
	    </select>

	    <!--xwj for td3313 20051206 begin-->
	    <span id="field<%=fieldid%>span">
	    <%
	     if(ismand.equals("1") && checkempty){
	    %>
       <IMG src='/images/BacoError.gif' align=absMiddle>
      <%
            }
       %>
	     </span>
	    <!--xwj for td3313 20051206 end-->

        <%if(isedit.equals("0") || isremark==1 ){%>
        <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=finalvalue%>" >
        <%}%>
       <%
            if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
       if("remindType".equals(fieldname))
       {
        String remindTypeStatus = "";
       	if(isedit.equals("0") || isremark==1 )
       	{
       		remindTypeStatus = "disabled";
       	}
       %>
       <TR id="remindTimeLine" <% if("1".equals(fieldvalue)) {%> style="display:none" <% } %>  style="height:1px;">
			<TD class="Line2" colSpan="2"></TD>
	   </TR>
       <TR id="remindTime" <% if("1".equals(fieldvalue)) {%> style="display:none" <% } %>>
			<TD><%=SystemEnv.getHtmlLabelName(785,user.getLanguage())%></TD>
			<TD class="Field">
				<INPUT id='remindBeforeStart' <%=remindTypeStatus %> type="checkbox" name="remindBeforeStart" value=<%=remindBeforeStartV %> <% if("1".equals(remindBeforeStartV)) { %>checked<% } %>>
					<%=SystemEnv.getHtmlLabelName(19784,user.getLanguage())%>
					<INPUT id='remindDateBeforeStart' <%=remindTypeStatus %> class="InputStyle" type="input" name="remindDateBeforeStart" onchange="checkint('remindDateBeforeStart')" size=5 value="<%= temmhour %> ">
					<%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%>
					<INPUT id='remindTimeBeforeStart' <%=remindTypeStatus %> class="InputStyle" type="input" name="remindTimeBeforeStart" onchange="checkint('remindTimeBeforeStart')" size=5 value="<%= temptinme %>">
					<%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%>
				<br>
				<INPUT id='remindBeforeEnd' <%=remindTypeStatus %> type="checkbox" name="remindBeforeEnd" value=<%=remindBeforeEndV %> <% if("1".equals(remindBeforeEndV)) { %>checked<% } %>>

					<%=SystemEnv.getHtmlLabelName(19785,user.getLanguage())%>
					<INPUT id='remindDateBeforeEnd' <%=remindTypeStatus %> class="InputStyle" type="input" name="remindDateBeforeEnd" onchange="checkint('remindDateBeforeEnd')" size=5 value="<%= temmhourend%>">
					<%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%>
					<INPUT id='remindTimeBeforeEnd' <%=remindTypeStatus %> class="InputStyle" type="input" name="remindTimeBeforeEnd"  onchange="checkint('remindTimeBeforeEnd')" size=5 value="<%= temptinmeend %>">
					<%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%>
			</TD>
		</TR>
		
       <%}
        //add by xhheng @20050310 for �����ϴ�
        }else if(fieldhtmltype.equals("6")){
        %>
          <%if( isedit.equals("1")){%>
          <!--modify by xhheng @20050511 for 1803-->
          <TABLE cols=3 id="field<%=fieldid%>_tab">
            <TBODY >
            <COL width="50%" >
            <COL width="25%" >
            <COL width="25%">
          <%
          if(!fieldvalue.equals("")) {
            sql="select id,docsubject,accessorycount from docdetail where id in("+fieldvalue+") order by id asc";
            RecordSet.executeSql(sql);
            int linknum=-1;
            int imgnum=fieldimgnum;
              boolean isfrist=false;
            while(RecordSet.next()){
                isfrist=false;
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
              int accessoryCount=RecordSet.getInt(3);

              DocImageManager.resetParameter();
              DocImageManager.setDocid(Integer.parseInt(showid));
              DocImageManager.selectDocImageInfo();

              String docImagefileid = "";
              long docImagefileSize = 0;
              String docImagefilename = "";
              String fileExtendName = "";
              int versionId = 0;

              if(DocImageManager.next()){
                //DocImageManager��õ�doc��һ�����������°汾
                docImagefileid = DocImageManager.getImagefileid();
                docImagefileSize = DocImageManager.getImageFileSize(Util.getIntValue(docImagefileid));
                docImagefilename = DocImageManager.getImagefilename();
                fileExtendName = docImagefilename.substring(docImagefilename.lastIndexOf(".")+1).toLowerCase();
                versionId = DocImageManager.getVersionId();
              }
             if(accessoryCount>1){
               fileExtendName ="htm";
             }

              String imgSrc=AttachFileUtil.getImgStrbyExtendName(fileExtendName,20);
              if(fieldtype.equals("2")){
              if(linknum==0){
              isfrist=true;
              %>
            <tr>
                <td colSpan=3>
                    <table cellspacing="0" cellpadding="0">
                        <tr>
              <%}
                  if(imgnum>0&&linknum>=imgnum){
                      imgnum+=fieldimgnum;
                      isfrist=true;
              %>
              </tr>
              <tr>
              <%
                  }
              %>
                  <input type=hidden name="field<%=fieldid%>_del_<%=linknum%>" value="0">
                  <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>>
                  <td <%if(!isfrist){%>style="padding-left:15"<%}%>>
                     <table>
                      <tr>
                          <td colspan="2" align="center"><img src="/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&requestid=<%=requestid%>" style="cursor:hand" alt="<%=docImagefilename%>" <%if(fieldimgwidth>0){%>width="<%=fieldimgwidth%>"<%}%> <%if(fieldimgheight>0){%>height="<%=fieldimgheight%>"<%}%> onclick="addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>')">
                          </td>
                      </tr>
                      <tr>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick='onChangeSharetype("span<%=fieldid%>_id_<%=linknum%>","field<%=fieldid%>_del_<%=linknum%>","<%=ismand%>",oUpload<%=fieldid%>);return false;'>[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></span>]</a>
                                    <span id="span<%=fieldid%>_id_<%=linknum%>" name="span<%=fieldid%>_id_<%=linknum%>" style="visibility:hidden"><b><font COLOR="#FF0033">��</font></b><span></td>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>');return false;">[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></span>]</a>
                              </td>
                      </tr>
                        </table>
                    </td>
              <%}else{%>

          <tr>
            <INPUT type=hidden name="field<%=fieldid%>_del_<%=linknum%>" value="0" >
            <td >
              <%=imgSrc%>

              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a  style="cursor:hand" onclick="opendoc('<%=showid%>','<%=versionId%>','<%=docImagefileid%>')"><%=docImagefilename%></a>&nbsp
              <%}else{%>
                <a style="cursor:hand" onclick="opendoc1('<%=showid%>')"><%=tempshowname%></a>&nbsp

              <%}%>
              <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>>
            </td>
            <td >
                <button type=button  class=btn accessKey=1  onclick='onChangeSharetype("span<%=fieldid%>_id_<%=linknum%>","field<%=fieldid%>_del_<%=linknum%>","<%=ismand%>",oUpload<%=fieldid%>)'><U><%=linknum%></U>-ɾ��
                  <span id="span<%=fieldid%>_id_<%=linknum%>" name="span<%=fieldid%>_id_<%=linknum%>" style="visibility:hidden">
                    <B><FONT COLOR="#FF0033">��</FONT></B>
                  <span>
                </BUTTON>
            </td>
            <%if(accessoryCount==1){%>
            <td >
              <span id = "selectDownload">
                  <button type=button  class=btn accessKey=1  onclick="downloads('<%=docImagefileid%>')">
                    <U><%=linknum%></U>-<%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%>	  (<%=docImagefileSize/1000%>K)
                  </BUTTON>
              </span>
            </td>
            <%}%>
          </tr>
              <%}}
            if(fieldtype.equals("2")&&linknum>-1){%>
            </tr></table></td></tr>
            <%}%>
            <input type=hidden name="field<%=fieldid%>_idnum" value=<%=linknum+1%>>
            <input type=hidden name="field<%=fieldid%>_idnum_1" value=<%=linknum+1%>>
          <%}%>
          <tr>
            <td >
             <%
            String mainId="";
            String subId="";
            String secId="";
          if(docCategory!=null && !docCategory.equals("")){
            mainId=docCategory.substring(0,docCategory.indexOf(','));
            subId=docCategory.substring(docCategory.indexOf(',')+1,docCategory.lastIndexOf(','));
            secId=docCategory.substring(docCategory.lastIndexOf(',')+1,docCategory.length());
          }
          String picfiletypes="*.*";
          String filetypedesc="All Files";
          if(fieldtype.equals("2")){
              picfiletypes=BaseBean.getPropValue("PicFileTypes","PicFileTypes");
              filetypedesc="Images Files";
          }
          boolean canupload=true;
          if("".equals(mainId) && "".equals(subId) && "".equals(secId)){
                    canupload=false;
            %>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(17616,user.getLanguage())+SystemEnv.getHtmlLabelName(92,user.getLanguage())+SystemEnv.getHtmlLabelName(15808,user.getLanguage())%>!</font>
           <%}else{
           %>
            <script>
          var oUpload<%=fieldid%>;
          function fileupload<%=fieldid%>() {
        var settings = {
            flash_url : "/js/swfupload/swfupload.swf",
            upload_url: "/docs/docupload/MultiDocUploadByWorkflow.jsp",    // Relative to the SWF file
            post_params: {
                "mainId": "<%=mainId%>",
                "subId":"<%=subId%>",
                "secId":"<%=secId%>",
                "userid":"<%=user.getUID()%>",
                "logintype":"<%=user.getLogintype()%>",
                "workflowid":"<%=workflowid%>"
            },
            file_size_limit :"<%=maxUploadImageSize%> MB",
            file_types : "<%=picfiletypes%>",
            file_types_description : "<%=filetypedesc%>",
            file_upload_limit : 100,
            file_queue_limit : 0,
            custom_settings : {
                progressTarget : "fsUploadProgress<%=fieldid%>",
                cancelButtonId : "btnCancel<%=fieldid%>",
                uploadspan : "field<%=fieldid%>span",
                uploadfiedid : "field<%=fieldid%>"
            },
            debug: false,
            button_image_url : "/js/swfupload/add.png",
            button_placeholder_id : "spanButtonPlaceHolder<%=fieldid%>",
            button_width: 100,
            button_height: 18,
            button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
            button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
            button_text_top_padding: 0,
            button_text_left_padding: 18,
            button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
            button_cursor: SWFUpload.CURSOR.HAND,

            // The event handler functions are defined in handlers.js
            file_queued_handler : fileQueued,
            file_queue_error_handler : fileQueueError,
            file_dialog_complete_handler : fileDialogComplete_1,
            upload_start_handler : uploadStart,
            upload_progress_handler : uploadProgress,
            upload_error_handler : uploadError,
            upload_success_handler : uploadSuccess_1,
            upload_complete_handler : uploadComplete_1,
            queue_complete_handler : queueComplete    // Queue plugin event
        };


        try {
            oUpload<%=fieldid%>=new SWFUpload(settings);
        } catch(e) {
            alert(e)
        }
    }
        	//window.attachEvent("onload", fileupload<%=fieldid%>);
        	if (window.addEventListener) {
			   	window.addEventListener("load", fileupload<%=fieldid%>, false);
			} else if (window.attachEvent) {
			   	window.attachEvent("onload", fileupload<%=fieldid%>);
			} else {
			   	window.onload=fileupload<%=fieldid%>;
			}
        </script>
      <TABLE class="ViewForm">
          <tr>
              <td colspan="2">
                  <div>
                      <span>
                      <span id="spanButtonPlaceHolder<%=fieldid%>"></span><!--ѡȡ����ļ�-->
                      </span>
                      &nbsp;&nbsp;
								<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload<%=fieldid%>.cancelQueue();showmustinput(oUpload<%=fieldid%>);" id="btnCancel<%=fieldid%>">
									<span><img src="/js/swfupload/delete.gif" border="0"></span>
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--�������ѡ��--></span>
								</span><span id="uploadspan">(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%><%=maxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>)</span>
                      <span id="field<%=fieldid%>span">
				<%
				 if(ismand.equals("1")&&fieldvalue.equals("")){
				%>
			   <img src='/images/BacoError.gif' align=absMiddle>
			  <%
					}
			   %>
	     </span>
                  </div>
                  <input  class=InputStyle  type=hidden size=60 name="field<%=fieldid%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>"  viewtype="<%=ismand%>" value="<%=fieldvalue%>">
              </td>
          </tr>
          <tr>
              <td colspan="2">
                  <div class="fieldset flash" id="fsUploadProgress<%=fieldid%>">
                  </div>
                  <div id="divStatus<%=fieldid%>"></div>
              </td>
          </tr>
      </TABLE>
            <%}%>
          <input type=hidden name='mainId' value=<%=mainId%>>
          <input type=hidden name='subId' value=<%=subId%>>
          <input type=hidden name='secId' value=<%=secId%>>
          </td>
          </tr>
      </TABLE>
          <%}else{
          if(!fieldvalue.equals("")) {
            %>
          <TABLE cols=3 id="field<%=fieldid%>_tab">
            <TBODY >
            <COL width="50%" >
            <COL width="25%" >
            <COL width="25%">
            <%
            sql="select id,docsubject,accessorycount from docdetail where id in("+fieldvalue+") order by id asc";
            int linknum=-1;
            RecordSet.executeSql(sql);
            while(RecordSet.next()){
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
              int accessoryCount=RecordSet.getInt(3);

              DocImageManager.resetParameter();
              DocImageManager.setDocid(Integer.parseInt(showid));
              DocImageManager.selectDocImageInfo();

              String docImagefileid = "";
              long docImagefileSize = 0;
              String docImagefilename = "";
              String fileExtendName = "";
              int versionId = 0;

              if(DocImageManager.next()){
                docImagefileid = DocImageManager.getImagefileid();
                docImagefileSize = DocImageManager.getImageFileSize(Util.getIntValue(docImagefileid));
                docImagefilename = DocImageManager.getImagefilename();
                fileExtendName = docImagefilename.substring(docImagefilename.lastIndexOf(".")+1).toLowerCase();
                versionId = DocImageManager.getVersionId();
              }
             if(accessoryCount>1){
               fileExtendName ="htm";
             }
              String imgSrc=AttachFileUtil.getImgStrbyExtendName(fileExtendName,20);
              %>
              <tr>
              <td>
              <%=imgSrc%>
              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a style="cursor:hand" onclick="opendoc('<%=showid%>','<%=versionId%>','<%=docImagefileid%>')"><%=docImagefilename%></a>&nbsp
              <%}else{%>
                <a style="cursor:hand" onclick="opendoc1('<%=showid%>')"><%=tempshowname%></a>&nbsp
              <%}%>
              <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>> <!--xwj for td2893 20051017-->
              </td>
              <%if(accessoryCount==1){%>
              <td >
                <span id = "selectDownload">
                  <button type=button  class=btn accessKey=1  onclick="downloads('<%=docImagefileid%>')">
                    <U><%=linknum%></U>-����	(<%=docImagefileSize/1000%>K)
                  </BUTTON>
                </span>
              </td>
              <%}%>
              <td>&nbsp;</td>
              </tr>
              <%}%>
              <input type=hidden name="field<%=fieldid%>_idnum" value=<%=linknum+1%>><!--xwj for td2893 20051017-->
              <input type=hidden name="field<%=fieldid%>" value=<%=fieldvalue%>>
              </tbody>
              </table>
              <%
            }
          }
        }     // ѡ����������� ���������ж�����
       else if(fieldhtmltype.equals("7")){//�����ֶ�
 			out.println(Util.null2String((String)specialfield.get(fieldid+"_1")));
       }
       %>
      </td>
    </tr><TR style="height:1px;"><TD class=Line2 colSpan=2></TD></TR>

<%
    }else {                              // ����ʾ����Ϊ hidden ������Ϣ
%>
    <input type=hidden name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" >
<%
    }%>

	<%
}       // ѭ������
%>

</table>

<!--#######��ϸ�� Start#######-->
<%//@ include file="/workflow/request/WorkflowManageRequestDetailBody.jsp" %>
<!--#######��ϸ�� END#########-->
<input type=hidden name="requestid" value=<%=requestid%>>           <!--����id-->
<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="workflowtype" value="<%=workflowtype%>">       <!--����������-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="<%=nodetype%>">                     <!--��ǰ�ڵ�����-->
<input type=hidden name="src">                                <!--�������� save��submit,reject,delete-->
<input type=hidden name="iscreate" value="0">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name="billid" value="<%=billid%>">             <!--����id-->
<input type=hidden name=isremark>
<input type=hidden name ="method">                                <!--�½��ĵ�ʱ�� method Ϊdocnew-->
<input type=hidden name ="topage" value="<%=topage%>">				<!--���ص�ҳ��-->
<input type=hidden name ="needcheck" value="<%=needcheck+needcheck10404%>">
<input type=hidden name ="inputcheck" value="">

<script language="javascript">

function onNewDoc(fieldid) {
    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldid ;
    $GetEle("frmmain").src.value='save';
    setRemindData();
    //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
}

function DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo)
{
    YearFrom  = parseInt(YearFrom,10);
    MonthFrom = parseInt(MonthFrom,10);
    DayFrom = parseInt(DayFrom,10);
    YearTo    = parseInt(YearTo,10);
    MonthTo   = parseInt(MonthTo,10);
    DayTo = parseInt(DayTo,10);
    if(YearTo<YearFrom)
    return false;
    else{
        if(YearTo==YearFrom){
            if(MonthTo<MonthFrom)
            return false;
            else{
                if(MonthTo==MonthFrom){
                    if(DayTo<DayFrom)
                    return false;
                    else
                    return true;
                }
                else
                return true;
            }
            }
        else
        return true;
        }
}

//ֻ�жϵ�ǰ�����Ժ��Ƿ��б�ռ��
function checkuse(){
    <%
    String tempbegindate="";
    String tempenddate="";
    String tempbegintime="";
    String tempendtime="";
    String tempAddress="0";
    RecordSet.executeSql("select Address,begindate,enddate,begintime,endtime from meeting where meetingstatus=2 and isdecision<2 and (cancel is null or cancel<>'1') and begindate>='"+currentdate+"' AND address <> 0 AND address IS NOT null");
    while(RecordSet.next()){
        tempAddress=RecordSet.getString("Address");
        tempbegindate=RecordSet.getString("begindate");
        tempenddate=RecordSet.getString("enddate");
        tempbegintime=RecordSet.getString("begintime");
        tempendtime=RecordSet.getString("endtime");
   %>
   if("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && $GetEle("frmmain").<%=newenddate%>.value != ""&&$GetEle("frmmain").<%=Address%>.value=="<%=tempAddress%>"){
       if(!($GetEle("frmmain").<%=newfromdate%>.value+" "+$GetEle("frmmain").<%=newfromtime%>.value>"<%=tempenddate+' '+tempendtime%>" || $GetEle("frmmain").<%=newenddate%>.value+" "+$GetEle("frmmain").<%=newendtime%>.value<"<%=tempbegindate+' '+tempbegintime%>")){
           return true;
       }
   }
   <%
    }
    %>
    return false;
}

function checktimeok(){
if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && $GetEle("frmmain").<%=newenddate%>.value != ""){
			YearFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(0,4);
			MonthFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(5,7);
			DayFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(8,10);
			YearTo=$GetEle("frmmain").<%=newenddate%>.value.substring(0,4);
			MonthTo=$GetEle("frmmain").<%=newenddate%>.value.substring(5,7);
			DayTo=$GetEle("frmmain").<%=newenddate%>.value.substring(8,10);
			// window.alert(YearFrom+MonthFrom+DayFrom);
            if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
                window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
                return false;
  			 }else{
                if($GetEle("frmmain").<%=newenddate%>.value==$GetEle("frmmain").<%=newfromdate%>.value && $GetEle("frmmain").<%=newendtime%>.value<$GetEle("frmmain").<%=newfromtime%>.value){
                    window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
                    return false;
                }
            }
  }
     return true;
}

function doTriggerInit(){
    var tempS = "<%=trrigerfield%>";
    var tempA = tempS.split(",");
    for(var i=0;i<tempA.length;i++){
        datainput(tempA[i]);
    }
} 
function datainput(parfield){                <!--���ݵ���-->
      //var xmlhttp=XmlHttp.create();
      var StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=detailsum%>&trg="+parfield;
      <%
          ArrayList Linfieldname=ddi.GetInFieldName();
          ArrayList Lcondetionfieldname=ddi.GetConditionFieldName();
          for(int i=0;i<Linfieldname.size();i++){
              String temp=(String)Linfieldname.get(i);
      %>
          StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
          for(int i=0;i<Lcondetionfieldname.size();i++){
              String temp=(String)Lcondetionfieldname.get(i);
      %>
          StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
      %>
      //alert(StrData);
      $GetEle("datainputform").src="DataInputFrom.jsp?"+StrData;
      //xmlhttp.open("POST", "DataInputFrom.jsp", false);
      //xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
      //xmlhttp.send(StrData);
  }
  function addannexRow(accname)
  {
    $GetEle(accname+'_num').value=parseInt($GetEle(accname+'_num').value)+1;
    ncol = $GetEle(accname+'_tab').cols;
    oRow = $GetEle(accname+'_tab').insertRow(-1);
    for(j=0; j<ncol; j++) {
      oCell = oRow.insertCell(-1);

      switch(j) {
        case 0:
          var oDiv = document.createElement("div");
          <%----- Modified by xwj for td3323 20051209  ------%>
          var sHtml = "<input class=InputStyle  type=file size=50 name='"+accname+"_"+$GetEle(accname+'_num').value+"' onchange='accesoryChanage(this)'> (��Ŀ¼�����ֻ���ϴ�<%=maxUploadImageSize%>M/���ĸ���) ";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
        case 1:
          var oDiv = document.createElement("div");
          var sHtml = "&nbsp;";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
        case 2:
          var oDiv = document.createElement("div");
          var sHtml = "&nbsp;";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
      }
    }
  }


</script>



	  	<br/>

<%
boolean isOldWf_ = false;
RecordSetOld.executeSql("select nodeid from workflow_currentoperator where requestid = " + requestid);
while(RecordSetOld.next()){
	if(RecordSetOld.getString("nodeid") == null || "".equals(RecordSetOld.getString("nodeid")) || "-1".equals(RecordSetOld.getString("nodeid"))){
			isOldWf_ = true;
	}
}

%>
<%@ include file="WorkflowManageSign.jsp" %>



  <script language="javascript">
function countAttend()
{
	var count = 0;	
	
	if("" != $GetEle("<%= resourceFieldId %>").value)
	{
		countArray = $GetEle("<%= resourceFieldId %>").value.split(",");
		for(var i = 0; i < countArray.length; i++)
		{
			count++;
		}
	}

	if("" != $GetEle("<%= crmFieldId %>").value)
	{
		countArray = $GetEle("<%= crmFieldId %>").value.split(",");
		for(var i = 0; i < countArray.length; i++)
		{
			count++;
		}
	}
	
	if($GetEle("<%= resourceNumFieldId %>span") != undefined)
	{
		$GetEle("<%= resourceNumFieldId %>span").innerHTML = "";
	}
	if($GetEle("<%= resourceNumFieldId %>") != undefined)
	{
		$GetEle("<%= resourceNumFieldId %>").value = count;
	}
}
    function setRemindData()
	{
		try{
			var remindBeforeStart = $GetEle("remindBeforeStart");
			var remindDateBeforeStart = $GetEle("remindDateBeforeStart");
			var remindTimeBeforeStart = $GetEle("remindTimeBeforeStart");
			var remindBeforeEnd = $GetEle("remindBeforeEnd");
			var remindDateBeforeEnd = $GetEle("remindDateBeforeEnd");
			var remindTimeBeforeEnd = $GetEle("remindTimeBeforeEnd");
			//�ж�"��ʼǰ(����)" �Ƿ�ѡ
			if(remindBeforeStart && remindBeforeStart.checked) {
				remindBeforeStart.value = 1;
			} else if(remindBeforeStart&&!remindBeforeStart.checked) {
				remindBeforeStart.value = 0;
				//���"��ʼǰ(����)" ����ѡ, �� ��ʼǰСʱ�ͷ���ֵ��������, �ʶ���Ϊ0
				if(remindDateBeforeStart) {
					remindDateBeforeStart.value=0;
				}
				if(remindTimeBeforeStart) {
					remindTimeBeforeStart.value=0;
				}
			}
			//�ж�"����ǰ(����)" �Ƿ�ѡ
			if(remindBeforeEnd && remindBeforeEnd.checked) {
				remindBeforeEnd.value = 1;
			} else if(remindBeforeEnd && !remindBeforeEnd.checked) {
				remindBeforeEnd.value = 0;
				//���"����ǰ(����)" ����ѡ, �� ����ǰСʱ�ͷ���ֵ��������, �ʶ���Ϊ0
				if(remindDateBeforeEnd) {
					remindDateBeforeEnd.value=0;
				}
				if(remindTimeBeforeEnd) {
					remindTimeBeforeEnd.value=0;
				}
			}
<% if(!remindBeforeStart.equals("")){%>
if ($GetEle("<%=remindBeforeStart%>") && remindBeforeStart) $GetEle("<%=remindBeforeStart%>").value = remindBeforeStart.value;
<%}%>
<% if(!remindBeforeEnd.equals("")){%>
if ($GetEle("<%=remindBeforeEnd%>") && remindBeforeEnd) $GetEle("<%=remindBeforeEnd%>").value = remindBeforeEnd.value;
<%}%>
<% if(!remindTimesBeforeStart.equals("")){%>
if ($GetEle("<%=remindTimesBeforeStart%>") && remindDateBeforeStart) $GetEle("<%=remindTimesBeforeStart%>").value = parseInt(remindDateBeforeStart.value * 60) + parseInt(remindTimeBeforeStart.value);
<%}%>
<% if(!remindTimesBeforeEnd.equals("")){%>
if ($GetEle("<%=remindTimesBeforeEnd%>") && remindDateBeforeEnd) $GetEle("<%=remindTimesBeforeEnd%>").value = parseInt(remindDateBeforeEnd.value * 60) + parseInt(remindTimeBeforeEnd.value);
<%}%>
	}catch(e){}
	}
    
function showRemindTime(obj)
{
	//�� ���ѷ�ʽ Ϊ ������ �� ��ʱ��������ʾ���ѵ���ϸ��Ϣ
	if("1" == obj.value || obj.value == "")
	{
		$GetEle("remindTime").style.display = "none";
		$GetEle("remindTimeLine").style.display = "none";
	}
	else
	{
		$GetEle("remindTime").style.display = "";
		$GetEle("remindTimeLine").style.display = "";
	}
}
	
    function displaydiv_1()
	{
		if(WorkFlowDiv.style.display == ""){
			WorkFlowDiv.style.display = "none";
			WorkFlowspan.innerHTML = "<a href='#' onClick=displaydiv_1() target=_self>ȫ��</a>";
		}
		else{
			WorkFlowspan.innerHTML = "<a href='#' onClick=displaydiv_1() target=_self>����</a>";
			WorkFlowDiv.style.display = "";
		}
	}

    function doRemark(){        <!-- �����ת�����ύ��ť -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoRemark").click();
        }catch(e){
            $GetEle("frmmain").isremark.value='1';
            $GetEle("frmmain").src.value='save';
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231   
                                      
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18981,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            setRemindData();
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
        }
	}

    function doRemark_n(obj){        <!-- �����ת�����ύ��ť -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoRemark").click();
        }catch(e){
            $GetEle("frmmain").isremark.value='1';
            $GetEle("frmmain").src.value='save';
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231

            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18981,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            obj.disabled=true;
            setRemindData();
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
        }
	}

    function doSave(){          <!-- ������水ť -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoSave").click();
        }catch(e){
            var ischeckok="";
            try{
             if(check_form($GetEle("frmmain"),$GetEle("needcheck").value+$GetEle("inputcheck").value))
              ischeckok="true";
            }catch(e){
              ischeckok="false";
            }
            if(ischeckok=="false"){
                if(check_form($GetEle("frmmain"),'<%=needcheck%>'))
                    ischeckok="true";
            }
            if(ischeckok=="true"){
                if(checktimeok()) {
                        $GetEle("frmmain").src.value='save';
                        jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231
                                                              
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            			setRemindData();
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
                    }
             }
        }
	}
    function doSave_n(obj){          <!-- ������水ť -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoSave").click();
        }catch(e){
            var ischeckok="";
            try{
             if(check_form($GetEle("frmmain"),$GetEle("needcheck").value+$GetEle("inputcheck").value))
              ischeckok="true";
            }catch(e){
              ischeckok="false";
            }
            if(ischeckok=="false"){
                if(check_form($GetEle("frmmain"),'<%=needcheck%>'))
                    ischeckok="true";
            }
            if(ischeckok=="true"){
                if(checktimeok()) {
                        $GetEle("frmmain").src.value='save';
                        jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231
                                                                                      
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18979,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            			setRemindData();
                        obj.disabled=true;
                    //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
                    }
             }
        }
	}

    function doRemark_n(obj){   <!-- �����ת�����ύ��ť -->
		if ("<%=needconfirm%>"=="1")
		{
	    if (!confirm("<%=SystemEnv.getHtmlLabelName(19990,user.getLanguage())%>"))
        return false; 
		}
		
        try
        {
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoRemark").click();
        }
        catch(e)
        {                
			if(checktimeok()) 
			{
		        $GetEle("frmmain").isremark.value='1';
		        $GetEle("frmmain").src.value='save';
		        
                
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201

            //TD4262 ������ʾ��Ϣ  ��ʼ
			<%
			    if(ismode.equals("1"))
			    {
			%>
	            
	            contentBox = $GetEle("divFavContent18978");
                showObjectPopup(contentBox)
			<%
			    
			    }
			    else
			    {
			%>
		       
			        var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
			        showPrompt(content);
			        
			<%
			    }
			%>
                //TD4262 ������ʾ��Ϣ  ����
				setRemindData();
				 obj.disabled=true;
                //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
	}


    function doSubmit(obj){        <!-- ����ύ -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoSubmit").click();
        }catch(e){
      //modify by xhheng @20050328 for TD 1703
      //��ϸ������check��ͨ��try $GetEle("needcheck")�����,�����ԭ������ϸ���ݵ��޸�
        var ischeckok="";
        try{
			getRemarkText_log();
        if(check_form($GetEle("frmmain"),$GetEle("needcheck").value+$GetEle("inputcheck").value))
          ischeckok="true";
        }catch(e){
          ischeckok="false";
        }
        if(ischeckok=="false"){
          if(check_form($GetEle("frmmain"),'<%=needcheck%>'))
            ischeckok="true";
        }
        if(ischeckok=="true"){
            if(checktimeok()){
                if(checkuse() && -1 != $GetEle("frmmain").<%=Address%>.value && 0 != $GetEle("frmmain").<%=Address%>.value){
                    if(confirm("<%=SystemEnv.getHtmlLabelName(19095,user.getLanguage())%>")){
                        $GetEle("frmmain").src.value='submit';
                        jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231   
                                              
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            			setRemindData();
                        obj.disabled=true;
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
                    }
                }else{
                    $GetEle("frmmain").src.value='submit';
                    jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231 
                                            
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18978,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            		setRemindData();
                    obj.disabled=true;
                    //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
                }
            }
        }
        }
	}

	function doReject(){        <!-- ����˻� -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoReject").click();
        }catch(e){
            $GetEle("frmmain").src.value='reject';
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231   
            if(onSetRejectNode()){
            //������ʾ��Ϣ  ��ʼ meiYQ 2007.10.19 start
		       	var content="<%=SystemEnv.getHtmlLabelName(18980,user.getLanguage())%>";
		       	showPrompt(content);
            //������ʾ��Ϣ  ���� meiYQ 2007.10.19 end
            setRemindData();
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
    }

	function doReopen(){        <!-- ������¼��� -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoReopen").click();
        }catch(e){
            $GetEle("frmmain").src.value='reopen';
            $GetEle("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;
            jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231
            setRemindData();
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
        }
	}

	function doDelete(){        <!-- ���ɾ�� -->
        try{
            //Ϊ�˶ԡ��������š�����������Ĵ�����ο�MR1010
            $GetEle("planDoDelete").click();
        }catch(e){
            if(confirm("��ȷ��ɾ���ù�������")) {
                $GetEle("frmmain").src.value='delete';
                $GetEle("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3425 20051231
                setRemindData();
                //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
    }
//��ӳ��ö���
function onAddPhrase(phrase){
	if(phrase!=null && phrase!=""){
		try{
			var remarkHtml = FCKEditorExt.getHtml("remark");
			var remarkText = FCKEditorExt.getText("remark");
			if(remarkText==null || remarkText==""){
				FCKEditorExt.setHtml(phrase,"remark");
			}else{
				FCKEditorExt.setHtml(remarkHtml+"<p>"+phrase+"</p>","remark");
			}
		}catch(e){}
	}
}

	function showPrompt(content)
{

     var showTableDiv  = $GetEle('_xTable');
     var message_table_Div = document.createElement("div")
     message_table_Div.id="message_table_Div";
     message_table_Div.className="xTable_message";
     showTableDiv.appendChild(message_table_Div);
     var message_table_Div  = $GetEle("message_table_Div");
     message_table_Div.style.display="inline";
     message_table_Div.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_table_Div.style.position="absolute"
     message_table_Div.style.top=pTop;
     message_table_Div.style.left=pLeft;

     message_table_Div.style.zIndex=1002;
     var oIframe = document.createElement('iframe');
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
function openAccessory(fileId){
	jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
	openFullWindowHaveBar("/weaver/weaver.file.FileDownload?fileid="+fileId+"&requestid=<%=requestid%>");
}
function showfieldpop(){
<%if(fieldids.size()<1){%>
alert("<%=SystemEnv.getHtmlLabelName(22577,user.getLanguage())%>");
<%}%>
}
if (window.addEventListener)
window.addEventListener("load", showfieldpop, false);
else if (window.attachEvent)
window.attachEvent("onload", showfieldpop);
else
window.onload=showfieldpop; 
</script>

<script type="text/javascript">
function onShowBrowser2(id,url,linkurl,type1,ismand) {
	var id1 = null;
	if (type1 == 2 || type1 == 19 ) {
		id1 = window.showModalDialog(url, "", "dialogHeight:320px;dialogwidth:275px");
		$GetEle("field"+id+"span").innerHTML = id1;
		$GetEle("field"+id).value=id1;
	} else {
	    if (type1 != 162 && type1 != 171 && type1 != 152 && type1 != 142 && type1 != 135 && type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=165 && type1!=166 && type1!=167 && type1!=168 && type1!=4 && type1!=167 && type1!=164 && type1!=169 && type1!=170) {
	    	id1 = window.showModalDialog(url, "", "dialogWidth=550px;dialogHeight=550px");
		} else {
	        if (type1 == 135) {
				tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?projectids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        } else if (type1 == 4 || type1 == 164 || type1 == 169 || type1 == 170) {
		        tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?selectedids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        } else if (type1 == 37) {
		        tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?documentids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        } else if (type1 == 142 ) {
		        tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?receiveUnitIds=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
			} else if (type1 == 162 ) {
				tmpids = $GetEle("field"+id).value;
				url = url + "&beanids=" + tmpids;
				url = url.substring(0, url.indexOf("url=") + 4) + escape(url.substr(url.indexOf("url=") + 4));
				id1 = window.showModalDialog(url, "", "dialogWidth=550px;dialogHeight=550px");
			} else if (type1 == 165 || type1 == 166 || type1 == 167 || type1 == 168 ) {
		        index = (id + "").indexOf("_");
		        if (index != -1) {
		        	tmpids=uescape("?isdetail=1&isbill=<%=isbill%>&fieldid="& Mid(id,1,index-1)&"&resourceids="&$GetEle("field"+id).value);
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
		        } else {
		        	tmpids = uescape("?fieldid=" + id + "&isbill=<%=isbill%>&resourceids=" + $GetEle("field" + id).value);
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
		        }
			} else {
		        tmpids = $GetEle("field" + id).value;
				id1 = window.showModalDialog(url + "?resourceids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
			}
		}
		
	    if (id1 != undefined && id1 != null) {
			if (type1 == 171 || type1 == 152 || type1 == 142 || type1 == 135 || type1 == 17 || type1 == 18 || type1==27 || type1==37 || type1==56 || type1==57 || type1==65 || type1==166 || type1==168 || type1==170) {
				if (wuiUtil.getJsonValueByIndex(id1, 0) != "" && wuiUtil.getJsonValueByIndex(id1, 0) != "0" ) {
					var resourceids = wuiUtil.getJsonValueByIndex(id1, 0);
					var resourcename = wuiUtil.getJsonValueByIndex(id1, 1);
					var sHtml = ""

					resourceids = resourceids.substr(1);
					resourcename = resourcename.substr(1);
					var tlinkurl = linkurl;
					var resourceIdArray = resourceids.split(",");
					var resourceNameArray = resourcename.split(",");
					for (var _i=0; _i<resourceIdArray.length; _i++) {
						var curid = resourceIdArray[_i];
						var curname = resourceNameArray[_i];

						if (tlinkurl == "/hrm/resource/HrmResource.jsp?id=") {
							sHtml += "<a href=javaScript:openhrm(" + curid + "); onclick='pointerXY(event);'>" + curname + "</a>&nbsp";
						} else {
							sHtml += "<a href=" + tlinkurl + curid + ">" + curname + "</a>&nbsp";
						}
					}
					
					$GetEle("field"+id+"span").innerHTML = sHtml;
					$GetEle("field"+id).value= resourceids;
				} else {
 					if (ismand == 0) {
 						$GetEle("field"+id+"span").innerHTML = "";
 					} else {
 						$GetEle("field"+id+"span").innerHTML = "<img src='/images/BacoError.gif' align=absmiddle>";
 					}
 					$GetEle("field"+id).value = "";
				}

			} else {
			   if (wuiUtil.getJsonValueByIndex(id1, 0) != "" && wuiUtil.getJsonValueByIndex(id1, 0) != "0" ) {
	               
	            	    if (linkurl == "") {
				        	$GetEle("field" + id + "span").innerHTML = wuiUtil.getJsonValueByIndex(id1, 1);
				        } else {
							if (linkurl == "/hrm/resource/HrmResource.jsp?id=") {
								$GetEle("field"+id+"span").innerHTML = "<a href=javaScript:openhrm("+ wuiUtil.getJsonValueByIndex(id1, 0) + "); onclick='pointerXY(event);'>" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a>&nbsp";
							} else {
								$GetEle("field"+id+"span").innerHTML = "<a href=" + linkurl + wuiUtil.getJsonValueByIndex(id1, 0) + ">"+ wuiUtil.getJsonValueByIndex(id1, 1) + "</a>";
							}
				        }
	               $GetEle("field"+id).value = wuiUtil.getJsonValueByIndex(id1, 0);
	                
			   } else {
					if (ismand == 0) {
						$GetEle("field"+id+"span").innerHTML = "";
					} else {
						$GetEle("field"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>";
					}
					$GetEle("field"+id).value="";
			   }
			}
		}
	}
}

function onShowBrowser(id,url,linkurl,type1,ismand) {
	onShowBrowser2(id,url,linkurl,type1,ismand);
}


function onShowResourceRole(id, url, linkurl, type1, ismand, roleid) {
	var tmpids = $GetEle("field" + id).value;
	url = url + roleid + "_" + tmpids;

	id1 = window.showModalDialog(url);
	if (id1) {

		if (wuiUtil.getJsonValueByIndex(id1, 0) != ""
				&& wuiUtil.getJsonValueByIndex(id1, 0) != "0") {

			var resourceids = wuiUtil.getJsonValueByIndex(id1, 0);
			var resourcename = wuiUtil.getJsonValueByIndex(id1, 1);
			var sHtml = "";

			resourceids = resourceids.substr(1);
			resourcename = resourcename.substr(1);

			$GetEle("field" + id).value = resourceids;

			var idArray = resourceids.split(",");
			var nameArray = resourcename.split(",");
			for ( var _i = 0; _i < idArray.length; _i++) {
				var curid = idArray[_i];
				var curname = nameArray[_i];

				sHtml = sHtml + "<a href=" + linkurl + curid
						+ " target='_new'>" + curname + "</a>&nbsp";
			}

			$GetEle("field" + id + "span").innerHTML = sHtml;

		} else {
			if (ismand == 0) {
				$GetEle("field" + id + "span").innerHTML = "";
			} else {
				$GetEle("field" + id + "span").innerHTML = "<img src='/images/BacoError.gif' align=absmiddle>";
			}
			$GetEle("field" + id).value = "";
		}
	}
}


</script>

</form>
<script type="text/javascript" src="/js/selectDateTime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>