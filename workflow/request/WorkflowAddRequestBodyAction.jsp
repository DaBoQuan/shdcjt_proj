<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<%@ page import="weaver.workflow.request.RequestConstants" %>
<jsp:useBean id="WorkflowPhrase" class="weaver.workflow.sysPhrase.WorkflowPhrase" scope="page"/>
<jsp:useBean id="DocUtil" class="weaver.docs.docs.DocUtil" scope="page" /><%----- xwj for td3323 20051209  ------%>
<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for @td2977 20051111-->
<jsp:useBean id="rsaddop" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for td3130 20051124-->
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_item" class="weaver.conn.RecordSet" scope="page" />
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<%@ page import="java.util.HashMap,java.util.*" %>
<%@ page import="weaver.system.code.*" %>
<%@ page import="weaver.general.TimeUtil,weaver.general.Util" %>
<%@ page import="weaver.workflow.request.RevisionConstants" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.general.StaticObj" %>
<jsp:useBean id="requestPreAddM" class="weaver.workflow.request.RequestPreAddinoperateManager" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="flowDoc" class="weaver.workflow.request.RequestDoc" scope="page"/>
<jsp:useBean id="WfLinkageInfo" class="weaver.workflow.workflow.WfLinkageInfo" scope="page"/>
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="ProjectInfoComInfo1" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo1" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DocComInfo1" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo1" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo1" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page"/>
<!--����ı��⿪ʼ -->
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<!-- 
<script type="text/javascript" language="javascript" src="/FCKEditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/FCKEditorExt.js"></script>
 -->
 <script type="text/javascript" src="/wui/common/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/wui/common/js/ckeditor/ckeditorext.js"></script>
<script type="text/javascript" src="../../js/weaver.js"></script>
<%
String selectInitJsStr = "";


int userid = Util.getIntValue(request.getParameter("userid"),0);
int userlanguage=Util.getIntValue(request.getParameter("languageid"),7);
String logintype = Util.null2String(request.getParameter("logintype"));
String username = Util.null2String((String)session.getAttribute(userid+"_"+logintype+"username"));
int formid=Util.getIntValue(request.getParameter("formid"),0);
String isbill = Util.null2String(request.getParameter("isbill"));
int workflowid = Util.getIntValue(request.getParameter("workflowid"));
String  workflowtype=Util.null2String(request.getParameter("workflowtype"));
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0) ;
String  workflowname=Util.null2String((String)session.getAttribute(userid+"_"+workflowid+"workflowname"));
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //�Ƿ�����̴����ĵ�����
String  docCategory=Util.null2String(request.getParameter("docCategory"));
String needcheck=Util.null2String(request.getParameter("needcheck"));
String currentdate=Util.null2String(request.getParameter("currentdate"));
String currenttime=Util.null2String(request.getParameter("currenttime"));
String prjid=Util.null2String(request.getParameter("prjid"));
String reqid=Util.null2String(request.getParameter("reqid"));
String docid=Util.null2String(request.getParameter("docid"));
String hrmid=Util.null2String(request.getParameter("hrmid"));
String crmid=Util.null2String(request.getParameter("crmid"));
int messageType=Util.getIntValue(request.getParameter("messageType"),0);
int defaultName=Util.getIntValue(request.getParameter("defaultName"),0);
String  topage=Util.null2String(request.getParameter("topage"));
ArrayList uploadfieldids=new ArrayList();
//��ʼ���ںͽ������ڱȽ���
String newfromdate="a";
String newenddate="b";

HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
CodeBuild cbuild = new CodeBuild(formid);
String  codeFields=Util.null2String(cbuild.haveCode());

String currentyear="";
if(currentdate!=null&&currentdate.indexOf("-")>=0){
	currentyear=currentdate.substring(0,currentdate.indexOf("-"));
}

ArrayList flowDocs=flowDoc.getDocFiled(""+workflowid); //�õ����̽��ĵ��ķ��ĺ��ֶ�
Map secMaxUploads = new HashMap();//��װѡ��Ŀ¼����Ϣ
Map secCategorys = new HashMap();
String codeField="";
if (flowDocs!=null&&flowDocs.size()>0)
{
codeField=""+flowDocs.get(0);
}
if (!fromFlowDoc.equals("1")) {%>
<br>
<div align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,userlanguage)%></font>
</div>
<title><%=Util.toScreen(workflowname,userlanguage)%></title>
<%}%>
<!--����ı������ -->

<!--TD4262 ������ʾ��Ϣ  ��ʼ-->
<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<!--TD4262 ������ʾ��Ϣ  ����-->
<iframe id="selectChange" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="workflowKeywordIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>

<%----- xwj for td3323 20051209 begin ------%>
<%
 int secid = Util.getIntValue(docCategory.substring(docCategory.lastIndexOf(",")+1),-1);
 int maxUploadImageSize = Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+secid),5);
 if(maxUploadImageSize<=0){
 maxUploadImageSize = 5;
 }
 int uploadType = 0;
 String selectedfieldid = "";
 String result = RequestManager.getUpLoadTypeForSelect(workflowid);
 if(!result.equals("")){
 selectedfieldid = result.substring(0,result.indexOf(","));
 uploadType = Integer.valueOf(result.substring(result.indexOf(",")+1)).intValue();
 }
 boolean isCanuse = RequestManager.hasUsedType(workflowid); //�жϵ�Ϊѡ��Ŀ¼ʱ�����ϴ�Ŀ¼�Ƿ�������ȫ
 if(selectedfieldid.equals("") || selectedfieldid.equals("0")){
 	isCanuse = false;
 }
 //���������ŷ�ʽΪѡ��Ŀ¼��������Ĭ��ֵ
 if(uploadType==1)
 {
	 maxUploadImageSize = 5;
 }
String docFlags=(String)session.getAttribute("requestAdd"+userid);
String newTNflag=(String)session.getAttribute("requestAddNewNodes"+userid);
String flowDocField=(String)session.getAttribute("requestFlowDocField"+userid);

String keywordismand="0";
String keywordisedit="0";
int titleFieldId=0;
int keywordFieldId=0;
String isSignDoc_add="";
String isSignWorkflow_add="";
RecordSet_nf1.execute("select titleFieldId,keywordFieldId,isSignDoc,isSignWorkflow from workflow_base where id="+workflowid);
if(RecordSet_nf1.next()){
	titleFieldId=Util.getIntValue(RecordSet_nf1.getString("titleFieldId"),0);
	keywordFieldId=Util.getIntValue(RecordSet_nf1.getString("keywordFieldId"),0);
    isSignDoc_add=Util.null2String(RecordSet_nf1.getString("isSignDoc"));
    isSignWorkflow_add=Util.null2String(RecordSet_nf1.getString("isSignWorkflow"));
}
%>
<script language=javascript>
function createAndRemoveObj(obj){
    objName = obj.name;
    //var  newObj = document.createElement("input");
    //newObj.name=objName;
    //newObj.className="InputStyle";
    //newObj.type="file";
    //newObj.size=70;
    //newObj.onchange=function(){accesoryChanage(this);};

    //var objParentNode = obj.parentNode;
    //var objNextNode = obj.nextSibling;
    //obj.removeNode();
    //objParentNode.insertBefore(newObj,objNextNode);
    tempObjonchange=obj.onchange;
    outerHTML="<input name="+objName+" class=InputStyle type=file size=60 >";  
    $G(objName).outerHTML=outerHTML;       
    $G(objName).onchange=tempObjonchange;
}
</script>
<%----- xwj for td3323 20051209 end ------%>

<input type=hidden name="workflowRequestLogId" value="-1" id="workflowRequestLogId">
<input type="hidden" name="htmlfieldids" id="htmlfieldids">

<table class="ViewForm">
  <colgroup>
  <col width="20%">
  <col width="80%">

  <!--�½��ĵ�һ�У�����˵������Ҫ�� -->

  <tr style="height:1px;"><td class=Line1 colSpan=2></td></tr>
  <tr>
    <td><%=SystemEnv.getHtmlLabelName(21192,userlanguage)%></td>
    <td class=field>
      <!--modify by xhheng @20050318 for TD1689-->
      <%if(defaultName==1){%>
       <%--xwj for td1806 on 2005-05-09--%>
        <input type=text class=Inputstyle  temptitle="<%=SystemEnv.getHtmlLabelName(21192,userlanguage)%>" name=requestname onChange="checkinput('requestname','requestnamespan');changeKeyword()" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit( workflowname+"-"+username+"-"+currentdate,userlanguage )%>" >
        <span id=requestnamespan></span>
      <%}else{%>
        <input type=text class=Inputstyle  temptitle="<%=SystemEnv.getHtmlLabelName(21192,userlanguage)%>" name=requestname onChange="checkinput('requestname','requestnamespan');changeKeyword()" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "" >
        <span id=requestnamespan><img src="/images/BacoError.gif" align=absmiddle></span>
      <%}%>
      <input type=radio value="0" name="requestlevel" checked><%=SystemEnv.getHtmlLabelName(225,userlanguage)%>
      <input type=radio value="1" name="requestlevel"><%=SystemEnv.getHtmlLabelName(15533,userlanguage)%>
      <input type=radio value="2" name="requestlevel"><%=SystemEnv.getHtmlLabelName(2087,userlanguage)%>
    </td>
  </tr>
<tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
  <!--��һ�н��� -->
  <!--add by xhheng @ 2005/01/24 for ��Ϣ���� Request06�����������п�ʼ -->
  <%
    if(messageType == 1){
  %>
  <tr>
    <td > <%=SystemEnv.getHtmlLabelName(17586,userlanguage)%></td>
    <td class=field>
	      <span id=messageTypeSpan></span>
	      <input type=radio value="0" name="messageType" checked><%=SystemEnv.getHtmlLabelName(17583,userlanguage)%>
	      <input type=radio value="1" name="messageType"><%=SystemEnv.getHtmlLabelName(17584,userlanguage)%>
	      <input type=radio value="2" name="messageType"><%=SystemEnv.getHtmlLabelName(17585,userlanguage)%>
	    </td>
  </tr>
  <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>

  <%}%>


  <!--���������н��� -->

<%

//��ѯ�����ߵ��ݵ��ֶ�,�ֶε����ƣ��ֶε�HTML���ͺ��ֶε����ͣ�����HTML���͵�һ����չ��

ArrayList fieldids=new ArrayList();             //�ֶζ���
ArrayList fieldorders = new ArrayList();        //�ֶ���ʾ˳����� (�����ļ�����Ҫ)
ArrayList languageids=new ArrayList();          //�ֶ���ʾ������(�����ļ�����Ҫ)
ArrayList fieldlabels=new ArrayList();          //���ݵ��ֶε�label����
ArrayList fieldhtmltypes=new ArrayList();       //���ݵ��ֶε�html type����
ArrayList fieldtypes=new ArrayList();           //���ݵ��ֶε�type����
ArrayList fieldnames=new ArrayList();           //���ݵ��ֶεı��ֶ�������
ArrayList fieldviewtypes=new ArrayList();       //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)
ArrayList fieldrealtype=new ArrayList();
int detailno=0;
// ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
ArrayList isfieldids=new ArrayList();              //�ֶζ���
ArrayList isviews=new ArrayList();              //�ֶ��Ƿ���ʾ����
ArrayList isedits=new ArrayList();              //�ֶ��Ƿ���Ա༭����
ArrayList ismands=new ArrayList();              //�ֶ��Ƿ�����������

String isbodyview="0" ;    //�ֶ��Ƿ���ʾ
String isbodyedit="0" ;    //�ֶ��Ƿ���Ա༭
String isbodymand="0" ;    //�ֶ��Ƿ��������
String fieldbodyid="";
String fieldbodyname = "" ;                         //�ֶ����ݿ���е��ֶ���
String fieldbodyhtmltype = "" ;                     //�ֶε�ҳ������
String fieldbodytype = "" ;                         //�ֶε�����
String fieldbodylable = "" ;                        //�ֶ���ʾ��
String fielddbtype="";                              //�ֶ���������
int languagebodyid = 0 ;
int detailsum=0;
String isdetail = "";//xwj for @td2977 20051111
String textheight = "4";//xwj for @td2977 20051111
int fieldlen=0;  //�ֶ����ͳ���
//��ô����ֶ���
DynamicDataInput ddi=new DynamicDataInput(workflowid+"");
String trrigerfield=ddi.GetEntryTriggerFieldName();
ArrayList selfieldsadd=WfLinkageInfo.getSelectField(workflowid,nodeid,0);
ArrayList changefieldsadd=WfLinkageInfo.getChangeField(workflowid,nodeid,0);
if(isbill.equals("0")) {
    RecordSet_nf1.executeSql("select t2.fieldid,t2.fieldorder,t1.fieldlable,t1.langurageid from workflow_fieldlable t1,workflow_formfield t2 where t1.formid=t2.formid and t1.fieldid=t2.fieldid and (t2.isdetail<>'1' or t2.isdetail is null)  and t2.formid="+formid+"  and t1.langurageid="+userlanguage+" order by t2.fieldorder");

    while(RecordSet_nf1.next()){
        fieldids.add(Util.null2String(RecordSet_nf1.getString("fieldid")));
        fieldorders.add(Util.null2String(RecordSet_nf1.getString("fieldorder")));
        fieldlabels.add(Util.null2String(RecordSet_nf1.getString("fieldlable")));
        languageids.add(Util.null2String(RecordSet_nf1.getString("langurageid")));
    }
}
else {

    RecordSet_nf1.executeProc("workflow_billfield_Select",formid+"");
    while(RecordSet_nf1.next()){
        fieldids.add(Util.null2String(RecordSet_nf1.getString("id")));
        fieldlabels.add(Util.null2String(RecordSet_nf1.getString("fieldlabel")));
        fieldhtmltypes.add(Util.null2String(RecordSet_nf1.getString("fieldhtmltype")));
        fieldtypes.add(Util.null2String(RecordSet_nf1.getString("type")));
        fieldnames.add(Util.null2String(RecordSet_nf1.getString("fieldname")));
        fieldviewtypes.add(Util.null2String(RecordSet_nf1.getString("viewtype")));
		fieldrealtype.add(Util.null2String(RecordSet_nf1.getString("fielddbtype")));
    }
}
//System.out.println("workflow_FieldForm_Select "+nodeid);
RecordSet_nf1.executeProc("workflow_FieldForm_Select",nodeid+"");
while(RecordSet_nf1.next()){
    isfieldids.add(Util.null2String(RecordSet_nf1.getString("fieldid")));
    isviews.add(Util.null2String(RecordSet_nf1.getString("isview")));
    isedits.add(Util.null2String(RecordSet_nf1.getString("isedit")));
    ismands.add(Util.null2String(RecordSet_nf1.getString("ismandatory")));
}
//modify by mackjoe at 2006-06-07 td4491 ���ڵ�ǰ���Ӳ����Ƴ�ѭ��������������ݿ������
//TD10029
ArrayList inoperatefields = new ArrayList();
ArrayList inoperatevalues = new ArrayList();
int fieldop1id=0;
requestPreAddM.setCreater(userid);
requestPreAddM.setOptor(userid);
requestPreAddM.setWorkflowid(workflowid);
requestPreAddM.setNodeid(nodeid);
Hashtable getPreAddRule_hs = requestPreAddM.getPreAddRule();
inoperatefields = (ArrayList)getPreAddRule_hs.get("inoperatefields");
inoperatevalues = (ArrayList)getPreAddRule_hs.get("inoperatevalues");


// �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
String beagenter=""+userid;
//��ñ�������
int body_isagent=Util.getIntValue((String)session.getAttribute(workflowid+"isagent"+userid),0);
if(body_isagent==1){
    beagenter=""+Util.getIntValue((String)session.getAttribute(workflowid+"beagenter"+userid),0);
}
String preAdditionalValue = "";
boolean isSetFlag = false;//xwj for td3308 20051124
for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

    //���ݳ�ʼ��
	isbodyview="0";
	isbodyedit="0";
	isbodymand="0";

  int tmpindex = i ;
    if(isbill.equals("0")) tmpindex = fieldorders.indexOf(""+i);     // ����Ǳ�, �õ���˳���Ӧ�� i

	fieldbodyid=(String)fieldids.get(tmpindex);  //�ֶ�id
    if( isbill.equals("1")) {
        String viewtype = (String)fieldviewtypes.get(tmpindex) ;   // ����ǵ��ݵĴӱ��ֶ�,����ʾ
        if( viewtype.equals("1") ) continue ;
    }

 /*---xwj for td3130 20051124 begin ---*/
  preAdditionalValue = "";
  isSetFlag = false;//added by xwj for td3359 20051222
  //���ڵ�ǰ���Ӳ����Ƴ�ѭ��������������ݿ������
  //rsaddop.executeSql("select customervalue from workflow_addinoperate where workflowid=" + workflowid + " and ispreadd='1' and isnode = 1 and objid = "+nodeid+" and fieldid = " + fieldbodyid);
  int inoperateindex=inoperatefields.indexOf(fieldbodyid);
  if(inoperateindex>-1){
  isSetFlag = true;
  preAdditionalValue = (String)inoperatevalues.get(inoperateindex);
  }
  /*---xwj for td3130 20051124 end ---*/

    int isfieldidindex = isfieldids.indexOf(fieldbodyid) ;
    if( isfieldidindex != -1 ) {
        isbodyview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
	    isbodyedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
	    isbodymand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
    }



    if(isbill.equals("0")) {
        languagebodyid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
        fieldbodyhtmltype=FieldComInfo.getFieldhtmltype(fieldbodyid);
        fieldbodytype=FieldComInfo.getFieldType(fieldbodyid);
        fieldbodylable=(String)fieldlabels.get(tmpindex);
        fieldbodyname=FieldComInfo.getFieldname(fieldbodyid);
		fielddbtype=FieldComInfo.getFielddbtype(fieldbodyid);

    }
    else {
        languagebodyid = userlanguage ;
        fieldbodyname=(String)fieldnames.get(tmpindex);
        fieldbodyhtmltype=(String)fieldhtmltypes.get(tmpindex);
        fieldbodytype=(String)fieldtypes.get(tmpindex);
		fielddbtype=(String)fieldrealtype.get(tmpindex);
        fieldbodylable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(tmpindex),0),languagebodyid );
    }
	 fieldlen=0;
    if ((fielddbtype.toLowerCase()).indexOf("varchar")>-1)
	{
	   fieldlen=Util.getIntValue(fielddbtype.substring(fielddbtype.indexOf("(")+1,fielddbtype.length()-1));

	}
    if(fieldbodyname.equals("manager")) {
	    String tmpmanagerid = ResourceComInfo.getManagerID(beagenter);
%>
	<input type=hidden name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=tmpmanagerid%>" />
<%
    if(isbodyview.equals("1")){
%> <tr>
      <td <%if(fieldbodyhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldbodylable,languagebodyid)%> </td>
      <td class=field><%=ResourceComInfo.getLastname(tmpmanagerid)%></td>
   </tr><tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
<%
    }
	    continue;
	}
    if( ! isbodyview.equals("1") ) { //����ʾ��������һ��ѭ��,����������Դ�ֶΣ�Ӧ������������Դ�ֶΣ���Ϊ������Դ�ֶ��п�����Ϊ������һ�ڵ�Ĳ�����
        if(fieldbodyhtmltype.equals("3") && (fieldbodytype.equals("1") ||fieldbodytype.equals("17")||fieldbodytype.equals("165")||fieldbodytype.equals("166")) && !preAdditionalValue.equals("")){           
           out.println("<input type=hidden name=field"+fieldbodyid+" id=field"+fieldbodyid+" value="+preAdditionalValue+">");
        }else if(!preAdditionalValue.equals("")){
        	out.println("<input type=hidden name=field"+fieldbodyid+" id=field"+fieldbodyid+" value="+preAdditionalValue+">");
        }        
        continue ;                  
    }
	if(fieldbodyname.equals("begindate")) newfromdate="field"+fieldbodyid;      //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if(fieldbodyname.equals("enddate")) newenddate="field"+fieldbodyid;     //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if((""+keywordFieldId).equals(fieldbodyid)) keywordismand=isbodymand;     
	if((""+keywordFieldId).equals(fieldbodyid)) keywordisedit=isbodyedit;     

    if(isbodymand.equals("1")&&!fieldbodyid.equals(codeField)&&!fieldbodyid.equals(codeField))  needcheck+=",field"+fieldbodyid;   //�����������,�����������ļ����(����Ƿ��ʺ��ֶΣ����������飬�����Զ�����)

    // ���濪ʼ������ʾ�ֶ�
%>
    <tr>
      <td <%if(fieldbodyhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldbodylable,languagebodyid)%> </td>
      <td class=field style="word-wrap:break-word;word-break:break-all;">
      <%
        if(fieldbodyhtmltype.equals("1")){                          // �����ı���
            if(fieldbodytype.equals("1")){                          // �����ı����е��ı�
                if(isbodyview.equals("1")){

                if(isbodyedit.equals("1")&&!fieldbodyid.equals(codeField)&&!fieldbodyid.equals(codeFields)){
					if(keywordFieldId>0&&(""+keywordFieldId).equals(fieldbodyid)){
%>
<button type=button class=Browser  onclick="onShowKeyword(field<%=fieldbodyid%>.viewtype)" title="<%=SystemEnv.getHtmlLabelName(21517,userlanguage)%>"></button>
<%
					}
                    if(isbodymand.equals("1")) {
      %>
        <input datatype="text" viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=50 onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);checkLength('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,languagebodyid)%>','<%=SystemEnv.getHtmlLabelName(20246,userlanguage)%>','<%=SystemEnv.getHtmlLabelName(20247,userlanguage)%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldbodyid)){%>;changeKeyword()<%}%>"<%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>');" <%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
      <%

		}else{%>
		<!-- �����ı�-�ı� -->	
        <input datatype="text" viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=50 onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);checkLength('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,languagebodyid)%>','<%=SystemEnv.getHtmlLabelName(20246,userlanguage)%>','<%=SystemEnv.getHtmlLabelName(20247,userlanguage)%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldbodyid)){%>;changeKeyword()<%}%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>')" <%}%> value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
		<!-- �����ı�-�ı� -->	
        <span id="field<%=fieldbodyid%>span"></span>
      <%            }
		    }else{ %>
        <!--input  type=text class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>"  size=50 readonly-->
            <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
            <input  type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>"  size=50 value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
      <%          }
            }
            }
		    else if(fieldbodytype.equals("2")){                     // �����ı����е�����
                if(isbodyview.equals("1")){
			    if(isbodyedit.equals("1")){
				    if(isbodymand.equals("1")) {
      %>
        <input  datatype="int" viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=20
		onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checkcount1(this);checkItemScale(this,'<%=SystemEnv.getHtmlLabelName(31181,userlanguage).replace("12","9")%>',-999999999,999999999);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);datainput('field<%=fieldbodyid%>');" <%}else{%> onBlur="checkcount1(this);checkItemScale(this,'<%=SystemEnv.getHtmlLabelName(31181,userlanguage).replace("12","9")%>',-999999999,999999999);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);" <%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
       <%

		}else{%>
		<!-- �����ı�-����  �ٴ������ onkeyup onafterpaste style="ime-mode:disabled" ypc  2012-09-04 ��� -->
        <input  datatype="int" viewtype="<%=isbodymand%>"  onafterpaste="if(isNaN(value))execCommand('undo')"  style="ime-mode:disabled"  temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=20  onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checkcount1(this);checkItemScale(this,'<%=SystemEnv.getHtmlLabelName(31181,userlanguage).replace("12","9")%>',-999999999,999999999);datainput('field<%=fieldbodyid%>');checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);" <%}else{%> onBlur="checkcount1(this);checkItemScale(this,'<%=SystemEnv.getHtmlLabelName(31181,userlanguage).replace("12","9")%>',-999999999,999999999);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype)" <%}%> value="<%=preAdditionalValue%>"> <!--modified by xwj for td3130 20051124-->
		<!-- �����ı�-���� -->
        <span id="field<%=fieldbodyid%>span"></span>
       <%           }
			    }else{  %>
         <!--input datatype="int" type=text class=Inputstyle name="field<%=fieldbodyid%>" size=20 readonly-->
         <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
         <input datatype="int" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <%        }
            }
            }
		    else if(fieldbodytype.equals("3")||fieldbodytype.equals("5")){                     // �����ı����еĸ�����
		    	int decimaldigits_t = 2;
		    	if(fieldbodytype.equals("3")){
		    		int digitsIndex = fielddbtype.indexOf(",");
		        	if(digitsIndex > -1){
		        		decimaldigits_t = Util.getIntValue(fielddbtype.substring(digitsIndex+1, fielddbtype.length()-1), 2);
		        	}else{
		        		decimaldigits_t = 2;
		        	}
		    	}
                if(isbodyview.equals("1")){
			    if(isbodyedit.equals("1")){
				    if(isbodymand.equals("1")) {
       %>
       <!-- �����ı�-������ �ͽ��ǧ��λ  style="ime-mode:disabled" onkeyup  onafterpaste ypc 2012-09-04 ���  start-->
       <!-- QC46731 �½�ҳ��ĸ�����δʵ�ֱ�����֤���ֶ����� -->
        <input datatype="float" style="ime-mode:disabled" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"   viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=20
		onKeyPress="ItemDecimal_KeyPress('field<%=fieldbodyid%>',15,<%=decimaldigits_t%>)" <%if(fieldbodytype.equals("5")){%>onfocus="changeToNormalFormat('field<%=fieldbodyid%>')"<%}%><%if (trrigerfield.indexOf("field" + fieldbodyid) >= 0) {%>  onBlur="checkFloat(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);datainput('field<%=fieldbodyid%>');<%if (fieldbodytype.equals("5")) {%>changeToThousands('field<%=fieldbodyid%>')<%}%>" <%} else {%> onBlur="checkFloat(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);<%if (fieldbodytype.equals("5")) {%>changeToThousands('field<%=fieldbodyid%>')<%}%>" <%}%> >
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
       <%}else{%>
       <input datatype="float"  style="ime-mode:disabled"  onafterpaste="if(isNaN(value))execCommand('undo')" 
       onKeyPress="ItemDecimal_KeyPress('field<%=fieldbodyid%>',15,<%=decimaldigits_t%>)"
       viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" size=20 <%if(fieldbodytype.equals("5")){%>onfocus="changeToNormalFormat('field<%=fieldbodyid%>')"<%}%> <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checkFloat(this);datainput('field<%=fieldbodyid%>');checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype); <%if(fieldbodytype.equals("5")){%>changeToThousands('field<%=fieldbodyid%>')<%}%> " <%}else{%> onBlur="checkFloat(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype); <%if(fieldbodytype.equals("5")){%>changeToThousands('field<%=fieldbodyid%>')<%}%> "<%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"></span>
       <%}
      }else{%>
         <!--input datatype="float" type=text class=Inputstyle name="field<%=fieldbodyid%>"  size=20 readonly-->
         <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
         <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <!-- �����ı�-������ �ͽ��ǧ��λ end-->
        <%}
		 }
	    }
          
	     /*-----------xwj for td3131 20051115 begin  ----------*/
	    else if(fieldbodytype.equals("4")){%>
            <table cols=2 id="field<%=fieldbodyid%>_tab">
            <!-- ypc 2012-08-22 ����δ��� onKeyPress="ItemNum_KeyPress('field_lable<%=fieldbodyid%>')" ���� onkeyup="clearNoNum(this)" �ڰ��¼��̵�ʱ��ȥ����������������Ƿ����Ҫ�����Ҫ��  -->
            <tr><td>
                <%if(isbodyview.equals("1")){
                    if(isbodyedit.equals("1")){%>
                    	<!-- ypc 2012-09-04 ��� onkeydown  style="ime-mode:disabled" onkeyup onaferpaste-->
                        <input datatype="float" viewtype="<%=isbodymand%>" type=text class=Inputstyle id="field_lable<%=fieldbodyid%>" name="field_lable<%=fieldbodyid%>" size=60
                            onfocus="FormatToNumber('<%=fieldbodyid%>')"
                            onKeyPress="ItemNum_KeyPress('field_lable<%=fieldbodyid%>',this)"
                            style="ime-mode:disabled;"  onafterpaste="if(isNaN(value))execCommand('undo')"
                            <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
                                onBlur="checkFloat(this);numberToFormat('<%=fieldbodyid%>');datainput('field_lable<%=fieldbodyid%>');checkinput2('field_lable<%=fieldbodyid%>','field_lable<%=fieldbodyid%>span',field<%=fieldbodyid%>.viewtype)"
                            <%}else{%>
                                onBlur="checkFloat(this);numberToFormat('<%=fieldbodyid%>');checkinput2('field_lable<%=fieldbodyid%>','field_lable<%=fieldbodyid%>span',field<%=fieldbodyid%>.viewtype)"
                            <%}%>
                        >
                        <span id="field_lable<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)&&isbodymand.equals("1")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
                        <span id="field<%=fieldbodyid%>span"></span>
                        <input datatype="float" viewtype="<%=isbodymand%>" type=hidden class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="">
                    <%}else{%>
                        <span id="field<%=fieldbodyid%>span"></span>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldbodyid%>" disabled="true">
                        <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="">
                    <%}
                }
                if(!"".equals(preAdditionalValue)){%>
                    <script language="javascript">
                    	$GetEle("field_lable"+<%=fieldbodyid%>).value  = numberChangeToChinese(<%=preAdditionalValue%>);
                    	$GetEle("field"+<%=fieldbodyid%>).value  = <%=preAdditionalValue%>;
                    </script>
                <%}%>
            </td></tr>
            <tr><td>
                <input type=text class=Inputstyle size=60 name="field_chinglish<%=fieldbodyid%>" readOnly="true">
            </td></tr>
            </table>
	    <%}
	    /*-----------xwj for td3131 20051115 end ----------*/
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
    }
        }// �����ı�����������
	    else if(fieldbodyhtmltype.equals("2")){                     // �����ı���
	    	
	     /*-----xwj for @td2977 20051111 begin-----*/
	     if(isbill.equals("0")){
			 rscount.executeSql("select * from workflow_formdict where id = " + fieldbodyid);
			 if(rscount.next()){
			 textheight = rscount.getString("textheight");
			 }
		}else{
			rscount.executeSql("select * from workflow_billfield where viewtype=0 and id = " + fieldbodyid+" and billid="+formid);
			if(rscount.next()){
				textheight = ""+Util.getIntValue(rscount.getString("textheight"), 4);
			}
		}
			    /*-----xwj for @td2977 20051111 begin-----*/
            if(isbodyview.equals("1")){
		    if(isbodyedit.equals("1")){
			    if(isbodymand.equals("1")) {
       %>
        <textarea class=Inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>');" <%}%> onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);checkLengthfortext('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,languagebodyid)%>','<%=SystemEnv.getHtmlLabelName(20246,userlanguage)%>','<%=SystemEnv.getHtmlLabelName(20247,userlanguage)%>')"
		rows="<%=textheight%>" cols="40" style="width:80%" class=Inputstyle ><%=preAdditionalValue%></textarea><!--xwj for @td2977 20051111-->
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->

       <%
			    }else{
       %>
        <textarea class=Inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" onchange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);checkLengthfortext('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,languagebodyid)%>','<%=SystemEnv.getHtmlLabelName(20246,userlanguage)%>','<%=SystemEnv.getHtmlLabelName(20247,userlanguage)%>')" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);datainput('field<%=fieldbodyid%>');" <%}%> rows="<%=textheight%>" cols="40" style="width:80%"><%=Util.encodeAnd(preAdditionalValue)%></textarea><!--xwj for @td2977 20051111--><!--modified by xwj for td3130 20051124-->
        <span id="field<%=fieldbodyid%>span"></span>
       <%       }%>
       <script>$G("htmlfieldids").value += "field<%=fieldbodyid%>;<%=Util.toScreen(fieldbodylable,languagebodyid)%>,";</script>
       <%if (fieldbodytype.equals("2")) {%>
		   	<script>function funcField<%=fieldbodyid%>(){
			   	
		   		CkeditorExt.initEditor('frmmain','field<%=fieldbodyid%>','<%=userlanguage%>',CkeditorExt.NO_IMAGE,200)
				//FCKEditorExt.initEditor('frmmain','field<%=fieldbodyid%>',<%=userlanguage%>,FCKEditorExt.NO_IMAGE);
				<%if(isbodyedit.equals("1"))out.println("CkeditorExt.checkText('field"+fieldbodyid+"span','field"+fieldbodyid+"');");%>
				CkeditorExt.toolbarExpand(false,"field<%=fieldbodyid%>");
				}
				if (window.addEventListener){
				    window.addEventListener("load", funcField<%=fieldbodyid%>, false);
				}else if (window.attachEvent){
				    window.attachEvent("onload", funcField<%=fieldbodyid%>);
				}else{
				    window.onload=funcField<%=fieldbodyid%>;
				}
			</script>
		<%} }else{  %>
                <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
                <input type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value='<%=preAdditionalValue%>'><!--modified by xwj for td3130 20051124-->
         <!--textarea  class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" rows="4" cols="40" style="width:80%"  readonly></textarea-->
        <%        }
	    }
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
    }
        }// �����ı�����������
	    else if(fieldbodyhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
		    String url=BrowserComInfo.getBrowserurl(fieldbodytype);     // �����ť����ҳ���url
		    String linkurl=BrowserComInfo.getLinkurl(fieldbodytype);    // ���ֵ�����ʱ�����ӵ�url
		    String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
		    String showid = "";                                     // �½�ʱ��Ĭ��ֵ

            if((fieldbodytype.equals("8") || fieldbodytype.equals("135")) && !prjid.equals("")){       //�����ťΪ��Ŀ,��ǰ��Ĳ����л����ĿĬ��ֵ
                showid = "" + Util.getIntValue(prjid,0);
            }else if((fieldbodytype.equals("9") || fieldbodytype.equals("37")) && !docid.equals("")){ //�����ťΪ�ĵ�,��ǰ��Ĳ����л���ĵ�Ĭ��ֵ
                showid = "" + Util.getIntValue(docid,0);
            }else if((fieldbodytype.equals("1") ||fieldbodytype.equals("17")||fieldbodytype.equals("165")||fieldbodytype.equals("166")) && !hrmid.equals("")){ //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(hrmid,0);
            }else if((fieldbodytype.equals("7") || fieldbodytype.equals("18")) && !crmid.equals("")){ //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
                showid = "" + Util.getIntValue(crmid,0);
            }else if((fieldbodytype.equals("16") || fieldbodytype.equals("152") || fieldbodytype.equals("171")) && !reqid.equals("")){ //�����ťΪREQ,��ǰ��Ĳ����л��REQĬ��ֵ
                showid = "" + Util.getIntValue(reqid,0);
			}else if((fieldbodytype.equals("4") || fieldbodytype.equals("57") || fieldbodytype.equals("167") || fieldbodytype.equals("168")) && !hrmid.equals("")){ //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(hrmid),0);
            }else if(fieldbodytype.equals("24") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(hrmid),0);
            }else if(fieldbodytype.equals("32") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"),0);
            }else if((fieldbodytype.equals("164") || fieldbodytype.equals("169") || fieldbodytype.equals("170")) && !hrmid.equals("")){ //�����ťΪ�ֲ�,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�ķֲ��õ��ֲ�Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getSubCompanyID(hrmid),0);
            }else if(fieldbodytype.equals("226")||fieldbodytype.equals("227")){
					//zzl��ͨģ����������ֶε�"���������ť"
					//ƴ��?type=browser.267|11266
					url+="?type="+fielddbtype+"|"+fieldbodyid;	
			}

            if(fieldbodytype.equals("2")){ //added by xwj for td3130 20051124
                 if(!isSetFlag){
                    showname = currentdate;
                    showid = currentdate;
                }else{
                    showname=preAdditionalValue;
                    showid=preAdditionalValue;
                }
            }

            if(fieldbodytype.equals("178")){ 
                 if(!isSetFlag){
                    showname = currentyear;
                    showid = currentyear;
                }else{
                    showname=preAdditionalValue;
                    showid=preAdditionalValue;
                }
            }

				if(fieldbodytype.equals("19")){ //added by ben 2008-3-14 Ĭ�ϵ�ǰʱ��
                 if(!isSetFlag){
                    showname = currenttime.substring(0,5);
                    showid = currenttime.substring(0,5);
                }else{
                    showname=preAdditionalValue;
                    showid=preAdditionalValue;
                }
            }
            if(showid.equals("0")) showid = "" ;


            if(isSetFlag){
            showid = preAdditionalValue;//added by xwj for td3308 20051213
           }

            if(fieldbodytype.equals("2") || fieldbodytype.equals("19")  || fieldbodytype.equals("178"))	showname=showid; // ����ʱ��
            else if(!showid.equals("")){       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
                ArrayList tempshowidlist=Util.TokenizerString(showid,",");
                if(fieldbodytype.equals("8") || fieldbodytype.equals("135")){
                    //��Ŀ������Ŀ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("1") ||fieldbodytype.equals("17")){
                    //��Ա������Ա
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                        	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                          	{
                        		showname+="<a href='javaScript:openhrm("+tempshowidlist.get(k)+");' onclick='pointerXY(event);'>"+ResourceComInfo.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                          	}
                        	else
                            	showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ResourceComInfo.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=ResourceComInfo.getResourcename((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("7") || fieldbodytype.equals("18")){
                    //�ͻ�����ͻ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("4") || fieldbodytype.equals("57")){
                    //���ţ��ಿ��
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DepartmentComInfo1.getDepartmentname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=DepartmentComInfo1.getDepartmentname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("164")){
                    //�ֲ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+SubCompanyComInfo1.getSubCompanyname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=SubCompanyComInfo1.getSubCompanyname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("9") || fieldbodytype.equals("37")){
                    //�ĵ������ĵ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if (fieldbodytype.equals("9")&&docFlags.equals("1"))
                        {
                        //linkurl="WorkflowEditDoc.jsp?docId=";//ά������
                         String tempDoc=""+tempshowidlist.get(k);
                       showname+="<a href='#' onlick='createDoc("+fieldbodyid+","+tempDoc+")'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }
                        else
                        {
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=DocComInfo1.getDocname((String)tempshowidlist.get(k))+" ";
                        }
                        }
                    }
                }else if(fieldbodytype.equals("23")){
                    //�ʲ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("16") || fieldbodytype.equals("152") || fieldbodytype.equals("171")){
                    //�������
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+WorkflowRequestComInfo1.getRequestName((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=WorkflowRequestComInfo1.getRequestName((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldbodytype.equals("161")||fieldbodytype.equals("162")){
                    
					Browser browser=(Browser) StaticObj.getServiceByFullname(fielddbtype, Browser.class);
                    for(int k=0;k<tempshowidlist.size();k++){
						try{
                            BrowserBean bb=browser.searchById((String)tempshowidlist.get(k));
                            String desc=Util.null2String(bb.getDescription());
                            String name=Util.null2String(bb.getName());							showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
						}catch (Exception e){
						}
                    }                    
                }else if(fieldbodytype.equals("141")){
                    //������Դ����
					showname+=ResourceConditionManager.getFormShowName(preAdditionalValue,languagebodyid);                    
                }
                else if(fieldbodytype.equals("226")||fieldbodytype.equals("227")){
                    //zzl--�����ֶ��½���ʱ����Ĭ��ֵ
					showname+=preAdditionalValue;    
                }
                else{

					
                    String tablename=BrowserComInfo.getBrowsertablename(fieldbodytype);
                    String columname=BrowserComInfo.getBrowsercolumname(fieldbodytype);
					/*��ΪӦƸ����(HrmCareerApply)����Ա��firstname������ʱ��Ϊ�գ��˴�����ֱ��ȡ����������(lastname+firstname)
					�ᵼ�������ύ��ӦƸ�˲���ʾ�����Դ˴��������⴦��ֻȡӦƸ�˵�lastname	�ο�TD24866*/
					if(columname.equals("(lastname+firstname)"))
						columname = "lastname";
                    String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldbodytype);
                    if(!tablename.equals("") && !columname.equals("") && !keycolumname.equals("")){
	                    String sql="";
	                    if(showid.indexOf(",")==-1){
	                        sql="select "+columname+" from "+tablename+" where "+keycolumname+"="+showid;
	                    }else{
	                        sql="select "+columname+" from "+tablename+" where "+keycolumname+" in("+showid+")";
	                    }

	                    RecordSet_nf1.executeSql(sql);
	                    while(RecordSet_nf1.next()) {
	                        if(!linkurl.equals(""))
	                            showname += "<a href='"+linkurl+showid+"' target='_new'>"+RecordSet_nf1.getString(1)+"</a>&nbsp";
	                        else
	                            showname +=RecordSet_nf1.getString(1) ;
	                    }
                    }
                }
            }

           //deleted by xwj for td3130 20051124

		    if(isbodyedit.equals("1")){
//add  by ben delweath rolepersone

              if(fieldbodytype.equals("160")){
                rsaddop.execute("select a.level_n, a.level2_n from workflow_groupdetail a ,workflow_nodegroup b where a.groupid=b.id and a.type=50 and a.objid="+fieldbodyid+" and b.nodeid in (select nodeid from workflow_flownode where workflowid="+workflowid+" ) ");
				String roleid="";
				int rolelevel_tmp = 0;
				if (rsaddop.next())
				{
				roleid=rsaddop.getString(1);
				rolelevel_tmp=Util.getIntValue(rsaddop.getString(2), 0);
				roleid += "a"+rolelevel_tmp;
				}
%>
        <button type=button class=Browser  onclick="onShowResourceRole('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'),'<%=roleid%>')" title="<%=SystemEnv.getHtmlLabelName(20570,userlanguage)%>"></button>
<%
			  }
              else if(fieldbodytype.equals("161")||fieldbodytype.equals("162")){
              url+="?type="+fielddbtype;
%>
       <button type=button class=Browser  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'));<%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>datainput('field<%=fieldbodyid%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'));<%}%>"></button>
<%
			  }
              else if(fieldbodytype.equals("141")){
%>
        <button type=button class=Browser  onclick="onShowResourceConditionBrowser('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(172,userlanguage)%>"></button>
<%
			  } else
//add by fanggsh 20060621 for TD4528 end
                if(!fieldbodytype.equals("37")&&!fieldbodytype.equals("9")) {
					session.setAttribute("relaterequest","new");
					//  ���ĵ����⴦��
	   %>
       <button type=button class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'));datainput('field<%=fieldbodyid%>');"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'))"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,userlanguage)%>">
	   </button>
	   
        <%}else if(fieldbodytype.equals("37")){                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button type=button class=AddDocFlow onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'))" > <%=SystemEnv.getHtmlLabelName(611,userlanguage)%></button>&nbsp;&nbsp<button type=button class=AddDocFlow onclick="onNewDoc(<%=fieldbodyid%>)" title="<%=SystemEnv.getHtmlLabelName(82,userlanguage)%>"><%=SystemEnv.getHtmlLabelName(82,userlanguage)%></button>
       <%}else if(fieldbodytype.equals("9") && fieldbodyid.equals(flowDocField)){       // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
	        if(!"1".equals(newTNflag)){
	   %>
       <button type=button class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'));datainput('field<%=fieldbodyid%>');"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',jQuery($GetEle('field<%=fieldbodyid%>')).attr('viewtype'))"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,userlanguage)%>">
	   </button>
       <%}
        }else{%>
	    <button type=button class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser3('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>','<%=isbodymand%>');datainput('field<%=fieldbodyid%>');"
	   <%}else{%>
		  onclick="onShowBrowser3('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>','<%=isbodymand%>')"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,userlanguage)%>">
	    </button>
	   <%}
           if(fieldbodytype.equals("9")&&docFlags.equals("1") && fieldbodyid.equals(flowDocField))  ///�Ƿ������̽��ĵ�s
           {%>
           <span id="CreateNewDoc"><button type=button id="createdoc" class=AddDocFlow onclick="createDoc('<%=fieldbodyid%>','')" title="<%=SystemEnv.getHtmlLabelName(82,userlanguage)%>"><%=SystemEnv.getHtmlLabelName(82,userlanguage)%></button>
           </span>
           <%}
        }
	   if(fieldbodytype.equals("161")||fieldbodytype.equals("162")){%>
	   <input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=showid%>" >
       <%}
       else if (fieldbodytype.equals("9")&&docFlags.equals("1")) {%>
		<input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=showid%>"  <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onpropertychange="datainput('field<%=fieldbodyid%>');" <%}%>>
      <%} else {%>
        <input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=showid%>" onpropertychange="checkLengthbrow('field<%=fieldbodyid%>','field<%=fieldbodyid%>span','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,languagebodyid)%>','<%=SystemEnv.getHtmlLabelName(20246,userlanguage)%>','<%=SystemEnv.getHtmlLabelName(20247,userlanguage)%>',field<%=fieldbodyid%>.viewtype);<%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>datainput('field<%=fieldbodyid%>');<%}%>" >
		<%}%>
		
        <span id="field<%=fieldbodyid%>span"><%=Util.toScreen(showname,userlanguage)%>
       <%   if(isbodymand.equals("1") && showname.equals("")) {
       %>
           <img src="/images/BacoError.gif" align=absmiddle>
       <%
            }
       %>
        </span>
        &nbsp;&nbsp;
        <%if(fieldbodytype.equals("87")){%>
        <A href="/meeting/report/MeetingRoomPlan.jsp" target="blank"><%=SystemEnv.getHtmlLabelName(2193,userlanguage)%></A>
        <%}%>
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
    }
        }                                                       // �����ť��������
	    else if(fieldbodyhtmltype.equals("4")) {                  // check��
	   %>
        <input type=checkbox viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" value=1<%if(preAdditionalValue.equals("1")){%> checked<%}%>  name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" <%if(isbodyedit.equals("0")){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onChange="datainput('field<%=fieldbodyid%>');" <%}%>><!--modified by xwj for td3130 20051124-->
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
    }
        }                                                       // check����������
        else if(fieldbodyhtmltype.equals("5")){                     // ѡ���   select
        	//����¼���Ϣ
        	String uploadMax = "";
        	if(fieldbodyid.equals(selectedfieldid)&&uploadType==1)
        	{
        		uploadMax = "changeMaxUpload('field"+fieldbodyid+"');reAccesoryChanage();";
        	}
        	//����select�ֶ�����
         	String onchangeAddStr = "";
        	int childfieldid_tmp = 0;
        	if("0".equals(isbill)){
        		rs_item.execute("select childfieldid from workflow_formdict where id="+fieldbodyid);
        	}else{
        		rs_item.execute("select childfieldid from workflow_billfield where id="+fieldbodyid);
        	}
        	if(rs_item.next()){
	       		childfieldid_tmp = Util.getIntValue(rs_item.getString("childfieldid"), 0);
        	}
        	int firstPfieldid_tmp = 0;
        	boolean hasPfield = false;
        	if("0".equals(isbill)){
        		rs_item.execute("select id from workflow_formdict where childfieldid="+fieldbodyid);
        	}else{
        		rs_item.execute("select id from workflow_billfield where childfieldid="+fieldbodyid);
        	}
        	while(rs_item.next()){
        		firstPfieldid_tmp = Util.getIntValue(rs_item.getString("id"), 0);
        		if(fieldids.contains(""+firstPfieldid_tmp)){
        			hasPfield = true;
        			break;
        		}
        	}
        	if(childfieldid_tmp != 0){//����ȳ������ֶΣ���Ҫ�����ֶ�����ѡ�����
				onchangeAddStr = "changeChildField(this, "+fieldbodyid+", "+childfieldid_tmp+")";
			}
        	%>
        <script>
        	function funcField<%=fieldbodyid%>(){
        	    changeshowattr('<%=fieldbodyid%>_0',$G('field<%=fieldbodyid%>').value,-1,'<%=workflowid%>','<%=nodeid%>');
        	}
        	//window.attachEvent("onload", funcField<%=fieldbodyid%>);
        	if (window.addEventListener){
			    window.addEventListener("load", funcField<%=fieldbodyid%>, false);
			}else if (window.attachEvent){
			    window.attachEvent("onload", funcField<%=fieldbodyid%>);
			}else{
			    window.onload=funcField<%=fieldbodyid%>;
			}
        </script>
        <select class=inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>" <%if(isbodyedit.equals("0")){%> name="disfield<%=fieldbodyid%>" DISABLED <%}else{%>name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>"<%}%> onBlur="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.viewtype);" onChange="<%=uploadMax %>;<%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>datainput('field<%=fieldbodyid%>');<%}if(selfieldsadd.indexOf(fieldbodyid)>=0){%>changeshowattr('<%=fieldbodyid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);<%}%><%=onchangeAddStr%>" ><!--added by xwj for td3313 20051206 -->
	    <option value=""></option><!--added by xwj for td3297 20051130 -->
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
	   boolean checkempty = true;//xwj for td3313 20051206
	   String finalvalue = "";//xwj for td3313 20051206
	   if(hasPfield==false || isbodyedit.equals("0")){
            char flag= Util.getSeparator() ;
            RecordSet_nf2.executeProc("workflow_selectitembyid_new",""+fieldbodyid+flag+isbill);
            while(RecordSet_nf2.next()){
                String tmpselectvalue = Util.null2String(RecordSet_nf2.getString("selectvalue"));
                String tmpselectname = Util.toScreen(RecordSet_nf2.getString("selectname"),userlanguage);
                String isdefault = Util.toScreen(RecordSet_nf2.getString("isdefault"),userlanguage);//xwj for td2977 20051107
                //��ȡѡ��Ŀ¼�ĸ�����С��Ϣ
                String tdocCategory = Util.toScreen(RecordSet_nf2.getString("docCategory"),userlanguage);
                if(!"".equals(tdocCategory)&&fieldbodyid.equals(selectedfieldid)&&uploadType==1)
                {
                	int tsecid = Util.getIntValue(tdocCategory.substring(tdocCategory.lastIndexOf(",")+1),-1);
                	String tMaxUploadFileSize = ""+Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+tsecid),5);
                	secMaxUploads.put(tmpselectvalue,tMaxUploadFileSize);
                    secCategorys.put(tmpselectvalue,tdocCategory);
                	if("y".equals(isdefault)||tmpselectvalue.equals(preAdditionalValue)){
				          maxUploadImageSize = Util.getIntValue(tMaxUploadFileSize,5);
                          docCategory=tdocCategory;
				    }
                }
				         /* -------- xwj for td3313 20051206 begin -*/
				        if("".equals(preAdditionalValue)){
				         if("y".equals(isdefault)){
				          checkempty = false;
				          finalvalue = tmpselectvalue;
				         }
				        }
				        else{
				         if(tmpselectvalue.equals(preAdditionalValue)){
				          checkempty = false;
				          finalvalue = tmpselectvalue;
				         }
				        }
				         /* -------- xwj for td3313 20051206 end -*/
	   %>
	    <option value="<%=tmpselectvalue%>"  <%if("".equals(preAdditionalValue)){if("y".equals(isdefault)){%>selected<%}}else{if(tmpselectvalue.equals(preAdditionalValue)){%>selected<%}}//xwj for td2977 20051107%> ><%=tmpselectname%></option><!--modified by xwj for td3130 20051124-->
	   <%
            }
       }else{
           char flag= Util.getSeparator();
           RecordSet_nf2.executeProc("workflow_selectitembyid_new",""+fieldbodyid+flag+isbill);
           while(RecordSet_nf2.next()){
               String tmpselectvalue = Util.null2String(RecordSet_nf2.getString("selectvalue"));
               String tmpselectname = Util.toScreen(RecordSet_nf2.getString("selectname"),userlanguage);
               String isdefault = Util.toScreen(RecordSet_nf2.getString("isdefault"),userlanguage);//xwj for td2977 20051107
				if("".equals(preAdditionalValue)){
					if("y".equals(isdefault)){
				    	checkempty = false;
				        finalvalue = tmpselectvalue;
				    }
				}else{
				    if(tmpselectvalue.equals(preAdditionalValue)){
				    	checkempty = false;
				        finalvalue = tmpselectvalue;
				    }
				}
           }
       	selectInitJsStr += "doInitChildSelect("+fieldbodyid+","+firstPfieldid_tmp+",\""+finalvalue+"\");\n";
       }
       %>
	    </select>
	    <!--xwj for td3313 20051206 begin-->
	    <span id="field<%=fieldbodyid%>span">
	    <%
	     if(isbodymand.equals("1") && checkempty){
	    %>
       <img src='/images/BacoError.gif' align=absMiddle>
      <%
            }
       %>
	     </span>
	    <%if(isbodyedit.equals("0")){%>
        <input type=hidden class=Inputstyle name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" value="<%=finalvalue%>" >
      <%}%>
	    <!--xwj for td3313 20051206 end-->
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
    }
        }                                                       // ѡ���   select����
       //add by xhheng @20050310 for �����ϴ�
       else if(fieldbodyhtmltype.equals("6")){

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
          if(fieldbodytype.equals("2")){
              picfiletypes=BaseBean.getPropValue("PicFileTypes","PicFileTypes");
              filetypedesc="Images Files";
          }

      %>
            <%if(isbodyedit.equals("1")){
                boolean canupload=true;
                if(uploadType == 0){if("".equals(mainId) && "".equals(subId) && "".equals(secId)){
                    canupload=false;
            %>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(17616,userlanguage)+SystemEnv.getHtmlLabelName(92,userlanguage)+SystemEnv.getHtmlLabelName(15808,userlanguage)%>!</font>
           <%}}else if(!isCanuse){
               canupload=false;
           %>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(17616,userlanguage)+SystemEnv.getHtmlLabelName(92,userlanguage)+SystemEnv.getHtmlLabelName(15808,userlanguage)%>!</font>
           <%}
           if(canupload){
               uploadfieldids.add(fieldbodyid);
           %>
            <script>
          var oUpload<%=fieldbodyid%>;
          function fileupload<%=fieldbodyid%>() {
        var settings = {
            flash_url : "/js/swfupload/swfupload.swf",
            upload_url: "/docs/docupload/MultiDocUploadByWorkflow.jsp",    // Relative to the SWF file
            post_params: {
                "mainId": "<%=mainId%>",
                "subId":"<%=subId%>",
                "secId":"<%=secId%>",
                "userid":"<%=userid%>",
                "logintype":"<%=logintype%>",
                "workflowid":"<%=workflowid%>",
                "workflowid":"<%=workflowid%>"
            },
            file_size_limit :"<%=maxUploadImageSize%> MB",
            file_types : "<%=picfiletypes%>",
            file_types_description : "<%=filetypedesc%>",
            file_upload_limit : 100,
            file_queue_limit : 0,
            custom_settings : {
                progressTarget : "fsUploadProgress<%=fieldbodyid%>",
                cancelButtonId : "btnCancel<%=fieldbodyid%>",
                uploadspan : "field<%=fieldbodyid%>span",
                uploadfiedid : "field<%=fieldbodyid%>"
            },
            debug: false,


            // Button settings

            button_image_url : "/js/swfupload/add.png",    // Relative to the SWF file
            button_placeholder_id : "spanButtonPlaceHolder<%=fieldbodyid%>",

            button_width: 100,
            button_height: 18,
            button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,userlanguage)%></span>',
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
            oUpload<%=fieldbodyid%>=new SWFUpload(settings);
        } catch(e) {
            alert(e)
        }
    }
        	//window.attachEvent("onload", fileupload<%=fieldbodyid%>);
          	if (window.addEventListener){
			    window.addEventListener("load", fileupload<%=fieldbodyid%>, false);
			}else if (window.attachEvent){
			    window.attachEvent("onload", fileupload<%=fieldbodyid%>);
			}else{
			    window.onload=fileupload<%=fieldbodyid%>;
			}
        </script>
      <TABLE class="ViewForm">
          <tr>
              <td colspan="2">
                  <div>
                      <span>
                      <span id="spanButtonPlaceHolder<%=fieldbodyid%>"></span><!--ѡȡ����ļ�-->
                      </span>
                      &nbsp;&nbsp;
								<span style="color:gray;cursor:pointer;TEXT-DECORATION:none" disabled onclick="oUpload<%=fieldbodyid%>.cancelQueue();showmustinput(oUpload<%=fieldbodyid%>);" id="btnCancel<%=fieldbodyid%>">
									<span><img src="/js/swfupload/delete.gif" border="0"></span>
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,userlanguage)%></font><!--�������ѡ��--></span>
								</span><span id="uploadspan">(<%=SystemEnv.getHtmlLabelName(18976,userlanguage)%><%=maxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,userlanguage)%>)</span>
                      <span id="field<%=fieldbodyid%>span">
				<%
		
				 if(isbodymand.equals("1")){
				needcheck+=",field"+fieldbodyid;
				%>
			   <img src='/images/BacoError.gif' align=absMiddle>
			  <%
					}
			   %>
	     </span>
                  </div>
                  <input  class=InputStyle  type=hidden size=60 name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" temptitle="<%=Util.toScreen(fieldbodylable,languagebodyid)%>"  viewtype="<%=isbodymand%>">
              </td>
          </tr>
          <tr>
              <td colspan="2">
                  <div class="fieldset flash" id="fsUploadProgress<%=fieldbodyid%>">
                  </div>
                  <div id="divStatus<%=fieldbodyid%>"></div>
              </td>
          </tr>
      </TABLE>
            <%}%>
          <input type=hidden name='mainId' value=<%=mainId%>>
          <input type=hidden name='subId' value=<%=subId%>>
          <input type=hidden name='secId' value=<%=secId%>>
      <%
              }
       }                                          // ѡ����������� ���������ж�����
       else if(fieldbodyhtmltype.equals("7")){//�����ֶ�
           if(isbill.equals("0")) out.println(Util.null2String((String)specialfield.get(fieldbodyid+"_0")));
           else out.println(Util.null2String((String)specialfield.get(fieldbodyid+"_1")));
       }     
       %>
      </td>
    </tr>
	 <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
<%
    }       // ѭ������
%>
<input type=hidden name ="needcheck" value="<%=needcheck%>">
<input type=hidden name ="inputcheck" value="">
<%
//add by mackjoe at 2006-06-07 td4491 ����ϸʱ�ż���
boolean  hasdetailb=false;
if(!(isbill.equals("1")&&(formid==7||formid==156||formid==157||formid==158||formid==159))){
if(isbill.equals("0")) {
    RecordSet_nf1.executeSql("select count(*) from workflow_formfield  where isdetail='1' and formid="+formid);
}else{
    RecordSet_nf1.executeSql("select count(*) from workflow_billfield  where viewtype=1 and billid="+formid);
}
if(RecordSet_nf1.next()){
    if(RecordSet_nf1.getInt(1)>0) hasdetailb=true;
}
}
if(hasdetailb){
%>
  </table>
  <jsp:include page="WorkflowAddRequestDetailBody.jsp" flush="true">
		<jsp:param name="workflowid" value="<%=workflowid%>" />
		<jsp:param name="nodeid" value="<%=nodeid%>" />
		<jsp:param name="formid" value="<%=formid%>" />
        <jsp:param name="detailsum" value="<%=detailsum%>"/>
        <jsp:param name="isbill" value="<%=isbill%>"/>
        <jsp:param name="currentdate" value="<%=currentdate%>" />
		<jsp:param name="currenttime" value="<%=currenttime%>" />
        <jsp:param name="needcheck" value="<%=needcheck%>" />
		<jsp:param name="prjid" value="<%=prjid%>" />
		<jsp:param name="reqid" value="<%=reqid%>" />
		<jsp:param name="docid" value="<%=docid%>" />
		<jsp:param name="hrmid" value="<%=hrmid%>" />
		<jsp:param name="crmid" value="<%=crmid%>" />
  </jsp:include>
  <table class="ViewForm" >
  <colgroup>
  <col width="20%">
  <col width="80%">
<%}%>

    <tr class="Title">
      <td colspan=2 align="center" valign="middle"><font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(17614,userlanguage)%></font></td>
    </tr>
    <tr>
      <td><%=SystemEnv.getHtmlLabelName(17614,userlanguage)%></td>
      <td style="text-align:right;">
      <!-- modify by xhheng @20050308 for TD 1692 -->
         <%
         //String workflowPhrases[] = WorkflowPhrase.getUserWorkflowPhrase(""+userid);
        //add by cyril on 2008-09-30 for td:9014
 		boolean isSuccess  = RecordSet_nf1.executeProc("sysPhrase_selectByHrmId",""+userid);
 		String workflowPhrases[] = new String[RecordSet_nf1.getCounts()];
 		String workflowPhrasesContent[] = new String[RecordSet_nf1.getCounts()];
 		int m = 0 ;
 		if (isSuccess) {
 			while (RecordSet_nf1.next()){
 				workflowPhrases[m] = Util.null2String(RecordSet_nf1.getString("phraseShort"));
 				workflowPhrasesContent[m] = Util.toHtml(Util.null2String(RecordSet_nf1.getString("phrasedesc")));
 				m ++ ;
 			}
 		}
 		//end by cyril on 2008-09-30 for td:9014

String isSignMustInput="0";
String isFormSignature=null;
int formSignatureWidth=RevisionConstants.Form_Signature_Width_Default;
int formSignatureHeight=RevisionConstants.Form_Signature_Height_Default;
RecordSet_nf1.executeSql("select isFormSignature,formSignatureWidth,formSignatureHeight,issignmustinput from workflow_flownode where workflowId="+workflowid+" and nodeId="+nodeid);
if(RecordSet_nf1.next()){
	isFormSignature = Util.null2String(RecordSet_nf1.getString("isFormSignature"));
	formSignatureWidth= Util.getIntValue(RecordSet_nf1.getString("formSignatureWidth"),RevisionConstants.Form_Signature_Width_Default);
	formSignatureHeight= Util.getIntValue(RecordSet_nf1.getString("formSignatureHeight"),RevisionConstants.Form_Signature_Height_Default);
	isSignMustInput = ""+Util.getIntValue(RecordSet_nf1.getString("issignmustinput"), 0);
}
int isUseWebRevision_t = Util.getIntValue(new weaver.general.BaseBean().getPropValue("weaver_iWebRevision","isUseWebRevision"), 0);
if(isUseWebRevision_t != 1){
	isFormSignature = "";
}
if("1".equals(isFormSignature)){
		 int workflowRequestLogId=-1;
%>
		<jsp:include page="/workflow/request/WorkflowLoadSignature.jsp">
			<jsp:param name="workflowRequestLogId" value="<%=workflowRequestLogId%>" />
			<jsp:param name="isSignMustInput" value="<%=isSignMustInput%>" />
			<jsp:param name="formSignatureWidth" value="<%=formSignatureWidth%>" />
			<jsp:param name="formSignatureHeight" value="<%=formSignatureHeight%>" />
		</jsp:include>
<%
}else{
             if(workflowPhrases.length>0){
         %>
                <select class=inputstyle  id="phraseselect" name=phraseselect style="width:80%" onChange='onAddPhrase(this.value)' onmousewheel="return false;">
                <option value="">����<%=SystemEnv.getHtmlLabelName(22409,userlanguage)%>����</option>
                <%
                  for (int i= 0 ; i <workflowPhrases.length;i++) {
                    String workflowPhrase = workflowPhrases[i] ;
                    //�����value�ĳ�����
                %>
                    <option value="<%=workflowPhrasesContent[i]%>"><%=workflowPhrase%></option>
                <%}%>
                </select>

          <%}%>
				<input type="hidden" id="remarkText10404" name="remarkText10404" temptitle="<%=SystemEnv.getHtmlLabelName(17614,userlanguage)%>" value="">
              <textarea class=Inputstyle name=remark id="remark" rows=4 cols=40 style="width=80%;display:none" class=Inputstyle temptitle="<%=SystemEnv.getHtmlLabelName(17614,userlanguage)%>"  <%if(isSignMustInput.equals("1")){%>onChange="checkinput('remark','remarkSpan')"<%}%>></textarea>
			   </td>
			   	  <!-- ��ͨģʽ���½� -->
				  <td style="text-align:left;">
					<span id="remarkSpan">
						<%
						if(isSignMustInput.equals("1")){
						%>
						<img src="/images/BacoError.gif" align=absmiddle>
						<%
						}
						%>
	             	</span>		
				  </td>
			
	  		   	<script defer>
	  		   	function funcremark_log(){		  		   	
	  		   	CkeditorExt.initEditor('frmmain','remark','<%=userlanguage%>',CkeditorExt.NO_IMAGE,200)
					//FCKEditorExt.initEditor("frmmain","remark",<%=userlanguage%>,FCKEditorExt.NO_IMAGE);
				<%if(isSignMustInput.equals("1")){%>
					CkeditorExt.checkText("remarkSpan","remark");
				<%}%>
					CkeditorExt.toolbarExpand(false,"remark");
				}
	  		 	if(ieVersion>=8) {
		  		 	//window.attachEvent("onload", funcremark_log());
		  		 	if (window.addEventListener){
					    window.addEventListener("load", funcremark_log(), false);
					}else if (window.attachEvent){
					    window.attachEvent("onload", funcremark_log());
					}else{
					    window.onload=funcremark_log();
					}
	  		 	} else {
		  		 	//window.attachEvent("onload", funcremark_log);
		  		 	if (window.addEventListener){
					    window.addEventListener("load", funcremark_log, false);
					}else if (window.attachEvent){
					    window.attachEvent("onload", funcremark_log);
					}else{
					    window.onload=funcremark_log;
					}
	  		 	}
				//funcremark_log();
				</script>
              
<%}%>
    </tr>
	 <tr style="height:1px;"><td class=Line2 colSpan=3></td></tr>
     <%
         if("1".equals(isSignDoc_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(857,userlanguage)%></td>
            <td class=field>
                <input type="hidden" id="signdocids" name="signdocids">
                <button type=button class=Browser onclick="onShowSignBrowser('/docs/docs/MutiDocBrowser.jsp','/docs/docs/DocDsp.jsp?isrequest=1&id=','signdocids','signdocspan',37)" title="<%=SystemEnv.getHtmlLabelName(857,userlanguage)%>"></button>
                <span id="signdocspan"></span>
            </td>
          </tr>
          <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         if("1".equals(isSignWorkflow_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(1044,userlanguage)%></td>
            <td class=field>
                <input type="hidden" id="signworkflowids" name="signworkflowids">
                <button type=button class=Browser onclick="onShowSignBrowser('/workflow/request/MultiRequestBrowser.jsp','/workflow/request/ViewRequest.jsp?isrequest=1&requestid=','signworkflowids','signworkflowspan',152)" title="<%=SystemEnv.getHtmlLabelName(1044,userlanguage)%>"></button>
                <span id="signworkflowspan"></span>
            </td>
          </tr>
          <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         String isannexupload_add=(String)session.getAttribute(userid+"_"+workflowid+"isannexupload");
         if("1".equals(isannexupload_add)){
            int annexmainId=0;
            int annexsubId=0;
            int annexsecId=0;
            String annexdocCategory_add=(String)session.getAttribute(userid+"_"+workflowid+"annexdocCategory");
             if("1".equals(isannexupload_add) && annexdocCategory_add!=null && !annexdocCategory_add.equals("")){
                annexmainId=Util.getIntValue(annexdocCategory_add.substring(0,annexdocCategory_add.indexOf(',')));
                annexsubId=Util.getIntValue(annexdocCategory_add.substring(annexdocCategory_add.indexOf(',')+1,annexdocCategory_add.lastIndexOf(',')));
                annexsecId=Util.getIntValue(annexdocCategory_add.substring(annexdocCategory_add.lastIndexOf(',')+1));
              }
             int annexmaxUploadImageSize=Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+annexsecId),5);
             if(annexmaxUploadImageSize<=0){
                annexmaxUploadImageSize = 5;
             }
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(22194,userlanguage)%></td>
            <td class=field>
            <%if(annexsecId<1){%>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(21418,userlanguage)+SystemEnv.getHtmlLabelName(15808,userlanguage)%>!</font>
           <%}else{%>
            <script>
          var oUploadannexupload;
          function fileuploadannexupload() {
        var settings = {
            flash_url : "/js/swfupload/swfupload.swf",
            upload_url: "/docs/docupload/MultiDocUploadByWorkflow.jsp",    // Relative to the SWF file
            post_params: {
                "mainId":"<%=annexmainId%>",
                "subId":"<%=annexsubId%>",
                "secId":"<%=annexsecId%>",
                "userid":"<%=userid%>",
                "logintype":"<%=logintype%>"
            },
            file_size_limit :"<%=annexmaxUploadImageSize%> MB",
            file_types : "*.*",
            file_types_description : "All Files",
            file_upload_limit : 100,
            file_queue_limit : 0,
            custom_settings : {
                progressTarget : "fsUploadProgressannexupload",
                cancelButtonId : "btnCancelannexupload",
                uploadfiedid:"field-annexupload"
            },
            debug: false,


            // Button settings

            button_image_url : "/js/swfupload/add.png",    // Relative to the SWF file
            button_placeholder_id : "spanButtonPlaceHolderannexupload",

            button_width: 100,
            button_height: 18,
            button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,userlanguage)%></span>',
            button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
            button_text_top_padding: 0,
            button_text_left_padding: 18,

            button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
            button_cursor: SWFUpload.CURSOR.HAND,

            // The event handler functions are defined in handlers.js
            file_queued_handler : fileQueued,
            file_queue_error_handler : fileQueueError,
            file_dialog_complete_handler : fileDialogComplete_2,
            upload_start_handler : uploadStart,
            upload_progress_handler : uploadProgress,
            upload_error_handler : uploadError,
            upload_success_handler : uploadSuccess_1,
            upload_complete_handler : uploadComplete_1,
            queue_complete_handler : queueComplete    // Queue plugin event
        };


        try {
            oUploadannexupload=new SWFUpload(settings);
        } catch(e) {
            alert(e)
        }
    }
        	//window.attachEvent("onload", fileuploadannexupload);
          	if (window.addEventListener){
			    window.addEventListener("load", fileuploadannexupload, false);
			}else if (window.attachEvent){
			    window.attachEvent("onload", fileuploadannexupload);
			}else{
			    window.onload=fileuploadannexupload;
			}
        </script>
      <TABLE class="ViewForm">
          <tr>
              <td colspan="2">
                  <div>
                      <span>
                      <span id="spanButtonPlaceHolderannexupload"></span><!--ѡȡ����ļ�-->
                      </span>
                      &nbsp;&nbsp;
								<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUploadannexupload.cancelQueue();" id="btnCancelannexupload">
									<span><img src="/js/swfupload/delete.gif" border="0"></span>
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,userlanguage)%></font><!--�������ѡ��--></span>
								</span><span>(<%=SystemEnv.getHtmlLabelName(18976,userlanguage)%><%=annexmaxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,userlanguage)%>)</span>
                  </div>
                  <input  class=InputStyle  type=hidden size=60 name="field-annexupload" >
              </td>
          </tr>
          <tr>
              <td colspan="2">
                  <div class="fieldset flash" id="fsUploadProgressannexupload">
                  </div>
                  <div id="divStatusannexupload"></div>
              </td>
          </tr>
      </TABLE>
              <input type=hidden name='annexmainId' value=<%=annexmainId%>>
              <input type=hidden name='annexsubId' value=<%=annexsubId%>>
              <input type=hidden name='annexsecId' value=<%=annexsecId%>>
          </td>
          </tr>
          <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
         <%}}%>
  </table>

<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="workflowtype" value="<%=workflowtype%>">   <!--����������-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="0">                     <!--��ǰ�ڵ�����-->
<input type=hidden name="src">                                    <!--�������� save��submit,reject,delete-->
<input type=hidden name="iscreate" value="1">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="topage" value="<%=topage%>">            <!--���������󷵻ص�ҳ��-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name ="method">                                <!--�½��ĵ�ʱ�� method Ϊdocnew-->


<input type=hidden name ="isMultiDoc" value=""><!--���ĵ��½�-->

<input type=hidden name ="requestid" value="-1">
<input type=hidden name="rand" value="<%=System.currentTimeMillis()%>">
<input type=hidden name="needoutprint" value="">
<iframe name="delzw" width=0 height=0 style="border:none"></iframe>

<script language=javascript>

//�����ı�-����
function ItemCount_Keydown(obj){
		obj.value=obj.value.replace(/[^\d]/g,"");
}
function ItemCount_Onpaste(obj){
	obj.value=obj.value.replace(/[^ -~]/g,"");
}
//�����ı�-����

	//2012-08-22 ypc ��Ӵ�js����������ת��
	
	//function clearNoNum(obj)
		//{
			//�Ȱѷ����ֵĶ��滻�����������ֺ�.
			//obj.value = obj.value.replace(/[^\d.]/g,"");
			//���뱣֤��һ��Ϊ���ֶ�����.
			//obj.value = obj.value.replace(/^\./g,"");
			//��ֻ֤�г���һ��.��û�ж��.
			//obj.value = obj.value.replace(/\.{2,}/g,".");
			//��֤.ֻ����һ�Σ������ܳ�����������
			//obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		//}
	//2012-08-22 ypc ��Ӵ�js����������ת��
//Ĭ�ϴ�С
var maxUploadImageSize = <%=maxUploadImageSize%>;
var uploaddocCategory="<%=docCategory%>";
//����maxUpload���������Ϊ0������Ϊʵʱ���
function accesoryChanage(obj,maxUpload)
{
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        File.FilePath=objValue;
        fileLenth= File.getFileSize();
    } catch (e){
        //alert('<%=SystemEnv.getHtmlLabelName(20253,userlanguage)%>');
		if(e.message=="Type mismatch"||e.message=="���Ͳ�ƥ��"){
			alert("<%=SystemEnv.getHtmlLabelName(21015,userlanguage)%> ");
		}else{
			alert("<%=SystemEnv.getHtmlLabelName(21090,userlanguage)%> ");
		}
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1);
    if(parseFloat(maxUpload)<=0)
    {
    	maxUpload = maxUploadImageSize;
    }
    if (fileLenthByM>maxUpload) {
        alert("<%=SystemEnv.getHtmlLabelName(20254,userlanguage)%>"+fileLenthByM+"M,<%=SystemEnv.getHtmlLabelName(20255,userlanguage)%>"+maxUpload+"M<%=SystemEnv.getHtmlLabelName(20256 ,userlanguage)%>");
        createAndRemoveObj(obj);
    }
}
//���ѡ��Ŀ¼�ĸ�����С��Ϣ
var selectValues = new Array();
var maxUploads = new Array();
var uploadCategorys=new Array();
function setMaxUploadInfo()
{
<%
if(secMaxUploads!=null&&secMaxUploads.size()>0)
{
	Set selectValues = secMaxUploads.keySet();

	for(Iterator i = selectValues.iterator();i.hasNext();)
	{
		String value = (String)i.next();
		String maxUpload = (String)secMaxUploads.get(value);
		String uplCategory=(String)secCategorys.get(value);
%>
		selectValues.push('<%=value%>');
		maxUploads.push('<%=maxUpload%>');
        uploadCategorys.push('<%=uplCategory%>');
<%
	}
}
%>
}
setMaxUploadInfo();
//Ŀ¼�����仯ʱ�����¼���ļ���С
function reAccesoryChanage()
{
    <%
    for(int i=0;i<uploadfieldids.size();i++){
    %>
    checkfilesize(oUpload<%=uploadfieldids.get(i)%>,maxUploadImageSize,uploaddocCategory);
    showmustinput(oUpload<%=uploadfieldids.get(i)%>);
    <%}%>
}
//ѡ��Ŀ¼ʱ���ı��Ӧ��Ϣ
function changeMaxUpload(fieldid)
{
	var efieldid = $GetEle(fieldid);
	if(efieldid)
	{
		var tselectValue = efieldid.value;
		for(var i = 0;i<selectValues.length;i++)
		{
			var value = selectValues[i];
			if(value == tselectValue)
			{
				maxUploadImageSize = parseFloat(maxUploads[i]);
                uploaddocCategory=uploadCategorys[i];
			}
		}
		if(tselectValue=="")
		{
			maxUploadImageSize = 5;
		}
		var euploadspans = document.getElementsByTagName("SPAN");
		if(euploadspans)
		{
			for(var j=0;j<euploadspans.length;j++)
			{
				var euploadid = euploadspans[j].id;
				if(euploadid&&euploadid=="uploadspan")
				{
					euploadspans[j].innerHTML = "(<%=SystemEnv.getHtmlLabelName(18976,userlanguage)%>"+maxUploadImageSize+"<%=SystemEnv.getHtmlLabelName(18977,userlanguage)%>)";
				}
			}
		}
	}
}
/*
function funcClsDateTime(){
	var onlstr = new clsDateTime();
}                
if (window.addEventListener){
    window.addEventListener("load", funcClsDateTime, false);
}else if (window.attachEvent){
    window.attachEvent("onload", funcClsDateTime);
}else{
    window.onload=funcClsDateTime;
}*/


function createDoc(fieldbodyid,docVlaue) //�����ĵ�
{
	var _isagent = "";
    var _beagenter = "";
	if($GetEle("_isagent")!=null) _isagent=$GetEle("_isagent").value;
    if($GetEle("_beagenter")!=null) _beagenter=$GetEle("_beagenter").value;
  	frmmain.action = "RequestOperation.jsp?isagent="+_isagent+"&beagenter="+_beagenter+"&docView=1&docValue="+docVlaue;
    frmmain.method.value = "crenew_"+fieldbodyid ;
    frmmain.target="delzw";
    parent.delsave();
	if(check_form(document.frmmain,'requestname')){
		if($G("needoutprint")) $G("needoutprint").value = "1";//��ʶ������
        document.frmmain.src.value='save';

//����ǩ������
<%if("1".equals(isFormSignature)){%>
	                    if(SaveSignature()){
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcompletBydoc();
                        }else{
							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,userlanguage)%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,userlanguage)%>");
								isDocEmpty=0;
							}else{
								alert("<%=SystemEnv.getHtmlLabelName(21442,userlanguage)%>");
							}
							
							return ;
						}
<%}else{%>
                        //�����ϴ�
                        StartUploadAll();
                        checkuploadcompletBydoc();
<%}%>
    }
}
function onNewDoc(fieldbodyid) {

    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldbodyid ;
    frmmain.isMultiDoc.value = fieldbodyid ;
    if(check_form(document.frmmain,'requestname')){
        //�����ϴ�
        StartUploadAll();
        document.frmmain.src.value='save';
        checkuploadcomplet();
    }
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


    function checktimeok(){         <!-- �������ڲ���С�ڿ�ʼ���� -->
        if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && document.frmmain.<%=newenddate%>.value != "")
        {
            YearFrom=document.frmmain.<%=newfromdate%>.value.substring(0,4);
            MonthFrom=document.frmmain.<%=newfromdate%>.value.substring(5,7);
            DayFrom=document.frmmain.<%=newfromdate%>.value.substring(8,10);
            YearTo=document.frmmain.<%=newenddate%>.value.substring(0,4);
            MonthTo=document.frmmain.<%=newenddate%>.value.substring(5,7);
            DayTo=document.frmmain.<%=newenddate%>.value.substring(8,10);
            if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
                window.alert("<%=SystemEnv.getHtmlLabelName(15273,userlanguage)%>");
                return false;
            }
        }
        return true;
    }
	function checkNodesNum()
	{
		var nodenum = 0;
		try
		{
		<%
		int checkdetailno = 0;
		//
		if(isbill.equals("1"))
		{
			if(formid==7||formid==156 || formid==157 || formid==158)
			{
				%>
			   	var rowneed = $G('rowneed').value;
			   	var nodesnum = $G('nodesnum').value;
			   	nodesnum = nodesnum*1;
			   	if(rowneed=="1")
			   	{
			   		if(nodesnum>0)
			   		{
			   			nodenum = 0;
			   		}
			   		else
			   		{
			   			nodenum = 1;
			   		}
			   	}
			   	else
			   	{
			   		nodenum = 0;
			   	}
			   	<%
			}
			else
			{
			    //����
			    rscount.execute("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
			    //System.out.println("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
			    while(rscount.next())
			    {
	   	%>
	   	var rowneed = $G('rowneed<%=checkdetailno%>').value;
	   	var nodesnum = $G('nodesnum<%=checkdetailno%>').value;
	   	nodesnum = nodesnum*1;
	   	if(rowneed=="1")
	   	{
	   		if(nodesnum>0)
	   		{
	   			nodenum = 0;
	   		}
	   		else
	   		{
	   			nodenum = '<%=checkdetailno+1%>';
	   		}
	   	}
	   	else
	   	{
	   		nodenum = 0;
	   	}
	   	if(nodenum>0)
	   	{
	   		return nodenum;
	   	}
	   	<%
	   				checkdetailno ++;
			    }
			}
		}
		else
		{
		 	int checkGroupId=0;
		 	rscount.execute("select distinct groupId from Workflow_formfield where formid="+formid+" and isdetail='1' order by groupid");
		    while (rscount.next())
		    {
		    	checkGroupId=rscount.getInt(1);
		    	System.out.println("checkGroupId : "+checkGroupId);
		    	%>
		       	var rowneed = $G('rowneed<%=checkGroupId%>').value;
		       	var nodesnum = $G('nodesnum<%=checkGroupId%>').value;
		       	nodesnum = nodesnum*1;
		       	if(rowneed=="1")
		       	{
		       		if(nodesnum>0)
		       		{
		       			nodenum = 0;
		       		}
		       		else
		       		{
		       			nodenum = <%=checkGroupId+1%>;
		       		}
		       	}
		       	else
		       	{
		       		nodenum = 0;
		       	}
		       	if(nodenum>0)
			   	{
			   		return nodenum;
			   	}
		       	<%
		    }
	    }
	    //����ϸѭ������
		%>
		}
		catch(e)
		{
			nodenum = 0;
		}
		return nodenum;
	}
    function doSave(){              <!-- ������水ť -->
    	var nodenum = checkNodesNum();
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,userlanguage)%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,userlanguage)%>!");
    		return false;
    	}
        var ischeckok="";

        try{
        if(check_form(document.frmmain,$GetEle("needcheck").value+$GetEle("inputcheck").value))
          ischeckok="true";
        }catch(e){
          ischeckok="false";
        }
        if(ischeckok=="false"){
            if(check_form(document.frmmain,'<%=needcheck%>'))
                ischeckok="true";
        }

<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>
        if(ischeckok=="true"){
			CkeditorExt.updateContent();
            if(checktimeok()) {
                    document.frmmain.src.value='save';
                    jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201

//����ǩ������
<%if("1".equals(isFormSignature)){%>
	                    if(SaveSignature()){
                            //TD4262 ������ʾ��Ϣ  ��ʼ
                            var content="<%=SystemEnv.getHtmlLabelName(18979,userlanguage)%>";
                            showPrompt(content);
                            //TD4262 ������ʾ��Ϣ  ����
                            //�����ϴ�
                            StartUploadAll();
                            checkuploadcomplet();
                        }else{

							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,userlanguage)%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,userlanguage)%>");
								isDocEmpty=0;
							}else{
							    alert("<%=SystemEnv.getHtmlLabelName(21442,userlanguage)%>");
							}
							return ;
						}
<%}else{%>
						//TD4262 ������ʾ��Ϣ  ��ʼ
						var content="<%=SystemEnv.getHtmlLabelName(18979,userlanguage)%>";
						showPrompt(content);
						//TD4262 ������ʾ��Ϣ  ����
						//�����ϴ�
						StartUploadAll();
						checkuploadcomplet();
<%}%>
                }
            }
    }

    function doSubmit(obj){            <!-- ����ύ -->
    	var nodenum = checkNodesNum();
    	if(nodenum>0)
    	{
    		alert("<%=SystemEnv.getHtmlLabelName(24827,userlanguage)%>"+nodenum+"<%=SystemEnv.getHtmlLabelName(24828,userlanguage)%>!");
    		return false;
    	}
      //modify by xhheng @20050328 for TD 1703
      //��ϸ������check��ͨ��try $GetEle("needcheck")�����,�����ԭ������ϸ���ݵ��޸�

        var ischeckok="";
        try{
            
        if(check_form(document.frmmain,$GetEle("needcheck").value+$GetEle("inputcheck").value))
          ischeckok="true";
        }catch(e){
          ischeckok="false";
        }
        if(ischeckok=="false"){
          if(check_form(document.frmmain,'<%=needcheck%>'))
            ischeckok="true";
        }

<%
	if(isSignMustInput.equals("1")){
	    if("1".equals(isFormSignature)){
		}else{
%>
            if(ischeckok=="true"){
			    if(!check_form(document.frmmain,'remarkText10404')){
				    ischeckok="false";
			    }
		    }
<%
		}
	}
%>

        if(ischeckok=="true"){
			CkeditorExt.updateContent();
            if(checktimeok()) {
                document.frmmain.src.value='submit';
                jQuery($GetEle("flowbody")).attr("onbeforeunload", "");//added by xwj for td3247 20051201

    	if("<%=formid%>"==201&&"<%=isbill%>"==1){//�ʲ����ϵ�����ϸ�е��ʲ������������ڿ�������������ύ��
            try{
	    	nodesnum = $GetEle("nodesnum").value;
	    	for(var tempindex1=0;tempindex1<nodesnum;tempindex1++){
	    		var capitalcount = $GetEle("node_"+tempindex1+"_capitalcount").value*1;
	    		var fetchingnumber=$GetEle("node_"+tempindex1+"_number").value*1;
	    		for(var tempindex2=0;tempindex2<nodesnum;tempindex2++){
	    			if(tempindex2!=tempindex1&&$GetEle("node_"+tempindex1+"_capitalid").value==$GetEle("node_"+tempindex2+"_capitalid").value){
	    				fetchingnumber = fetchingnumber*1 + $GetEle("node_"+tempindex2+"_number").value*1;
	    			}
	    		}
	    		if(fetchingnumber>capitalcount){
	    			alert("<%=SystemEnv.getHtmlLabelName(15313,userlanguage)%><%=SystemEnv.getHtmlLabelName(15508,userlanguage)%><%=SystemEnv.getHtmlLabelName(1446,userlanguage)%>");
	    			return;
	    		}
	    	}
            }catch(e){}
    	}

//����ǩ������
<%if("1".equals(isFormSignature)){%>
	                    if(SaveSignature()){
							//TD4262 ������ʾ��Ϣ  ��ʼ
							var content="<%=SystemEnv.getHtmlLabelName(18978,userlanguage)%>";
							showPrompt(content);
							//TD4262 ������ʾ��Ϣ  ����
							obj.disabled=true;
							//�����ϴ�
							StartUploadAll();
							checkuploadcomplet();
                        }else{
							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,userlanguage)%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,userlanguage)%>");
								isDocEmpty=0;
							}else{
								alert("<%=SystemEnv.getHtmlLabelName(21442,userlanguage)%>");
							}
							return ;
						}
<%}else{%>
						//TD4262 ������ʾ��Ϣ  ��ʼ
						var content="<%=SystemEnv.getHtmlLabelName(18978,userlanguage)%>";
						showPrompt(content);
						//TD4262 ������ʾ��Ϣ  ����
						obj.disabled=true;
						//�����ϴ�
						StartUploadAll();
						checkuploadcomplet();
<%}%>
            }
        }
    }
	function onAddPhrase(phrase){            <!-- ��ӳ��ö��� -->
    if(phrase!=null && phrase!=""){
			$G("remarkSpan").innerHTML = "";
			try{
				var remarkHtml = CkeditorExt.getHtml("remark");
				//var remarkText = CkeditorExt.getText("remark");
				CkeditorExt.setHtml(remarkHtml+"<p>"+phrase+"</p>","remark");
				
			}catch(e){alert(e)}
    }
    }
<%-----------xwj for td3131 20051115 begin -----%>
function numberToFormat(index){
    if($GetEle("field_lable"+index).value != ""){
		var floatNum = floatFormat($GetEle("field_lable"+index).value);
       	var val = numberChangeToChinese(floatNum)
       	if(val == ""){
       		alert("<%=SystemEnv.getHtmlLabelName(31181, userlanguage)%>");
            $GetEle("field"+index).value = "";
            $GetEle("field_lable"+index).value = "";
            $GetEle("field_chinglish"+index).value = "";
       	} else {
	        $GetEle("field"+index).value = floatNum;
	        $GetEle("field_lable"+index).value = milfloatFormat(floatNum);
       		$GetEle("field_chinglish"+index).value = val;
       	}
    }else{
    	$GetEle("field"+index).value = "";
    	$GetEle("field_chinglish"+index).value = "";
    }
}
function FormatToNumber(index){
    if($GetEle("field_lable"+index).value != ""){
    	$GetEle("field_lable"+index).value = $GetEle("field"+index).value;
    }else{
    	$GetEle("field"+index).value = "";
    	$GetEle("field_chinglish"+index).value = "";
    }
}
<%-----------xwj for td3131 20051115 end -----%>
function numberToChinese(index){
if($GetEle("field_lable"+index).value != ""){
	$GetEle("field_lable"+index).value = floatFormat($GetEle("field_lable"+index).value);
	$GetEle("field"+index).value = $GetEle("field_lable"+index).value;
	$GetEle("field_lable"+index).value = numberChangeToChinese($GetEle("field_lable"+index).value);
}
else{
	$GetEle("field"+index).value = "";
}
}
function ChineseToNumber(index){
if($GetEle("field_lable"+index).value != ""){
	$GetEle("field_lable"+index).value = chineseChangeToNumber($GetEle("field_lable"+index).value);
	$GetEle("field"+index).value = $GetEle("field_lable"+index).value;
}
else{
	$GetEle("field"+index).value = "";
}
}
  setTimeout("doTriggerInit()",1000);
  function doTriggerInit(){
      var tempS = "<%=trrigerfield%>";
      datainput(tempS);
      //var tempA = tempS.split(",");
      //var tempInitJS = "";
      //for(var i=0;i<tempA.length;i++){
          //datainput(tempA[i]);
          //tempInitJS += "setTimeout(\"datainput('"+tempA[i]+"')\","+(i+1)*500+");";
      //}
      //eval(tempInitJS)
  }
  function datainput(parfield){                <!--���ݵ���-->
      //var xmlhttp=XmlHttp.create();

      var tempParfieldArr = parfield.split(",");
      var StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=detailsum%>&trg="+parfield;
      
      for(var i=0;i<tempParfieldArr.length;i++){
      	var tempParfield = tempParfieldArr[i];
      <%
      if(!trrigerfield.trim().equals("")){
          ArrayList Linfieldname=ddi.GetInFieldName();
          ArrayList Lcondetionfieldname=ddi.GetConditionFieldName();
          for(int i=0;i<Linfieldname.size();i++){
              String temp=(String)Linfieldname.get(i);
      %>
          if($GetEle("<%=temp.substring(temp.indexOf("|")+1)%>")) StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
          for(int i=0;i<Lcondetionfieldname.size();i++){
              String temp=(String)Lcondetionfieldname.get(i);
      %>
          if($GetEle("<%=temp.substring(temp.indexOf("|")+1)%>")) StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
          }
      %>
      }
      //alert(StrData);
      $GetEle("datainputform").src="DataInputFrom.jsp?"+StrData;
      //xmlhttp.open("POST", "DataInputFrom.jsp", false);
      //xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
      //xmlhttp.send(StrData);
  }
  function addannexRow(accname,maxsize)
  {
  	//����������ӷ�ʽ
  	var uploadspan = "";
  	var checkMaxUpload = 0;
  	if(accname!="field-annexupload")
  	{
  		maxsize = maxUploadImageSize;
  		uploadspan = "uploadspan";
  	}
  	else
  	{
  		checkMaxUpload = maxsize;
  	}
  	$GetEle(accname+'_num').value=parseInt($GetEle(accname+'_num').value)+1;
    ncol = $GetEle(accname+'_tab').cols;
    oRow = $GetEle(accname+'_tab').insertRow(-1);
    for(j=0; j<ncol; j++) {
      oCell = oRow.insertCell(-1);
      oCell.style.height=24;
      switch(j) {
        case 1:
          var oDiv = document.createElement("div");
          var sHtml = "";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
        case 0:
          var oDiv = document.createElement("div");
          <%----- Modified by xwj for td3323 20051209  ------%>
          var sHtml = "<input class=InputStyle  type=file size=60 name='"+accname+"_"+$GetEle(accname+'_num').value+"' onchange='accesoryChanage(this,"+checkMaxUpload+")'><span id='"+uploadspan+"'>(<%=SystemEnv.getHtmlLabelName(18976,userlanguage)%>"+maxsize+"<%=SystemEnv.getHtmlLabelName(18977,userlanguage)%>)</span> ";
          oDiv.innerHTML = sHtml;
          oCell.appendChild(oDiv);
          break;
      }
    }
  }

//TD4262 ������ʾ��Ϣ  ��ʼ
//��ʾ����
function showPrompt(content)
{
     var showTableDiv  = $G('_xTable');
     var message_table_Div = document.createElement("div")
     message_table_Div.id="message_table_Div";
     message_table_Div.className="xTable_message";
     showTableDiv.appendChild(message_table_Div);
     var message_table_Div  = $G("message_table_Div");
     message_table_Div.style.display="inline";
     message_table_Div.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     jQuery(message_table_Div).css("position", "absolute");
	 jQuery(message_table_Div).css("top", pTop);
     jQuery(message_table_Div).css("left", pLeft);

     //message_table_Div.style.zIndex=1002;
     jQuery(message_table_Div).css("z-index", 1002);
     var oIframe = document.createElement('iframe');
     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     jQuery(oIframe).css("position", "absolute");
	 jQuery(oIframe).css("top", pTop);
     jQuery(oIframe).css("left", pLeft);
     jQuery(oIframe).css("z-index", parseInt(jQuery(message_table_Div).css("z-index")) - 1);
     
     oIframe.style.width = parseInt(message_table_Div.offsetWidth);
     oIframe.style.height = parseInt(message_table_Div.offsetHeight);
     oIframe.style.display = 'block';
}
//TD4262 ������ʾ��Ϣ  ����

function changeKeyword(){
<%
	if(titleFieldId>0&&keywordFieldId>0){
%>
	    var titleObj=$G("field<%=titleFieldId%>");
	    var keywordObj=$G("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $G("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value+"&docKeyword="+keywordObj.value;
	    }
<%
    }else if(titleFieldId==-3&&keywordFieldId>0){
%>
	    var titleObj=$G("requestname");
	    var keywordObj=$G("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $G("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value+"&docKeyword="+keywordObj.value;
	    }
<%
   }
%>
}

function updateKeywordData(strKeyword){
<%
	if(keywordFieldId>0){
%>
	var keywordObj=$G("field<%=keywordFieldId%>");

    var keywordismand=<%=keywordismand%>;
    var keywordisedit=<%=keywordisedit%>;

	if(keywordObj!=null){
		if(keywordisedit==1){
			keywordObj.value=strKeyword;
			if(keywordismand==1){
				checkinput('field<%=keywordFieldId%>','field<%=keywordFieldId%>span');
			}
		}else{
			keywordObj.value=strKeyword;
			field<%=keywordFieldId%>span.innerHTML=strKeyword;
		}

	}
<%
    }
%>
}

<%
    if(titleFieldId==-3&&keywordFieldId>0){
%>
	    changeKeyword();
<%
   }
%>



function onShowKeyword(isbodymand){
<%
	if(keywordFieldId>0){
%>
	var keywordObj=$G("field<%=keywordFieldId%>");
	if(keywordObj!=null){
		strKeyword=keywordObj.value;
        tempUrl=escape("/docs/sendDoc/WorkflowKeywordBrowserMulti.jsp?strKeyword="+strKeyword);
		tempUrl=tempUrl.replace(/%A0/g,'%20');
        returnKeyword=window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+tempUrl);

		if(typeof(returnKeyword)!="undefined"){
			keywordObj.value=returnKeyword;
			if(isbodymand==1){
				checkinput('field<%=keywordFieldId%>','field<%=keywordFieldId%>span');
			}
		}
	}
<%
    }
%>
}

function uescape(url){
    return escape(url);
}
function showfieldpop(){
<%if(fieldids.size()<1){%>
alert("<%=SystemEnv.getHtmlLabelName(22577,userlanguage)%>");
<%}%>
}
if (window.addEventListener)
window.addEventListener("load", showfieldpop, false);
else if (window.attachEvent)
window.attachEvent("onload", showfieldpop);
else
window.onload=showfieldpop;

function changeChildField(obj, fieldid, childfieldid){
    var paraStr = "fieldid="+fieldid+"&childfieldid="+childfieldid+"&isbill=<%=isbill%>&isdetail=0&selectvalue="+obj.value;
    $GetEle("selectChange").src = "SelectChange.jsp?"+paraStr;
    //alert($GetEle("selectChange").src);
}
function doInitChildSelect(fieldid,pFieldid,finalvalue){
	try{
		var pField = $GetEle("field"+pFieldid);
		if(pField != null){
			var pFieldValue = pField.value;
			if(pFieldValue==null || pFieldValue==""){
				return;
			}
			if(pFieldValue!=null && pFieldValue!=""){
				var field = $GetEle("field"+fieldid);
			    var paraStr = "fieldid="+pFieldid+"&childfieldid="+fieldid+"&isbill=<%=isbill%>&isdetail=0&selectvalue="+pFieldValue+"&childvalue="+finalvalue;
				var frm = document.createElement("iframe");
				frm.id = "iframe_"+pFieldid+"_"+fieldid+"_00";
				frm.style.display = "none";
			    document.body.appendChild(frm);
			    $GetEle("iframe_"+pFieldid+"_"+fieldid+"_00").src = "SelectChange.jsp?"+paraStr;
			}
		}
	}catch(e){}
}
<%=selectInitJsStr%>

</script>

<script type="text/javascript">
//<!--
function onShowBrowser3(id,url,linkurl,type1,ismand) {
	onShowBrowser2(id, url, linkurl, type1, ismand, 3);
}
function onShowBrowser2(id,url,linkurl,type1,ismand, funFlag) {
	var id1 = null;
    if (type1 == 9  && "<%=docFlags%>" == "1" ) {
        if (wuiUtil.isNotNull(funFlag) && funFlag == 3) {
        	url = "/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp"
        } else {
	    	url = "/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowserWord.jsp";
        }
	}
	
	if (type1 == 23) {
		url += "?billid=<%=formid%>";
	}
	if (type1 == 226||type1 == 227) {
		if(id.split("_")[1]){
			//zzl-ƴ���к�
			url += "_"+id.split("_")[1];
		}
	}
	
	if (type1 == 2 || type1 == 19 ) {
	    spanname = "field" + id + "span";
	    inputname = "field" + id;
	    
		if (type1 == 2) {
			onFlownoShowDate(spanname,inputname,ismand);
		} else {
			onWorkFlowShowTime(spanname, inputname, ismand);
		}
	} else {
	    if (type1 != 162 && type1 != 171 && type1 != 152 && type1 != 142 && type1 != 135 && type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=165 && type1!=166 && type1!=167 && type1!=168 && type1!=4 && type1!=167 && type1!=164 && type1!=169 && type1!=170) {
	    	if (wuiUtil.isNotNull(funFlag) && funFlag == 3) {
	    		id1 = window.showModalDialog(url, "", "dialogWidth=550px;dialogHeight=550px");
	    	} else {
			    if (type1 == 161) {
				    id1 = window.showModalDialog(url + "|" + id, window, "dialogWidth=550px;dialogHeight=550px");
				} else {
					id1 = window.showModalDialog(url, window, "dialogWidth=550px;dialogHeight=550px");
				}
	    	}
		} else {
	        if (type1 == 135) {
				tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?projectids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        //} else if (type1 == 4 || type1 == 167 || type1 == 164 || type1 == 169 || type1 == 170) { 
	        //type1 = 167 ��:��Ȩ������-�ֲ� ��Ӧ�ð����������� ypc 2012-09-06 �޸�
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

				if (wuiUtil.isNotNull(funFlag) && funFlag == 3) {
					url = url + "&beanids=" + tmpids;
					url = url.substring(0, url.indexOf("url=") + 4) + escape(url.substr(url.indexOf("url=") + 4));
					id1 = window.showModalDialog(url, "", "dialogWidth=550px;dialogHeight=550px");
				} else {
					url = url + "|" + id + "&beanids=" + tmpids;
					url = url.substring(0, url.indexOf("url=") + 4) + escape(url.substr(url.indexOf("url=") + 4));
					id1 = window.showModalDialog(url, window, "dialogWidth=550px;dialogHeight=550px");
				}
			} else if (type1 == 165 || type1 == 166 || type1 == 167 || type1 == 168 ) {
		        index = (id + "").indexOf("_");
		        if (index != -1) {
		        	tmpids=uescape("?isdetail=1&isbill=<%=isbill%>&fieldid=" + id.substring(0, index) + "&resourceids=" + $GetEle("field"+id).value+"&selectedids="+$GetEle("field"+id).value);
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
		        } else {
		        	tmpids = uescape("?fieldid=" + id + "&isbill=<%=isbill%>&resourceids=" + $GetEle("field" + id).value+"&selectedids="+$GetEle("field"+id).value);
		        	//�Ѵ��е�dialogWidth=550px; ��Ϊ600px
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=600px;dialogHeight=550px");
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
					
					var resourceIdArray = resourceids.split(",");
					var resourceNameArray = resourcename.split(",");
					for (var _i=0; _i<resourceIdArray.length; _i++) {
						var curid = resourceIdArray[_i];
						var curname = resourceNameArray[_i];
						if (linkurl == "/hrm/resource/HrmResource.jsp?id=") {
							sHtml += "<a href=javaScript:openhrm(" + curid + "); onclick='pointerXY(event);'>" + curname + "</a>&nbsp";
						} else {
							sHtml += "<a href=" + linkurl + curid + " target=_blank>" + curname + "</a>&nbsp";
						}
					}
					jQuery($GetEle("field"+id+"span")).html(sHtml);
					$GetEle("field" + id).value= resourceids;
				} else {
 					if (ismand == 0) {
 						jQuery($GetEle("field"+id+"span")).html("");
 					} else {
 						jQuery($GetEle("field"+id+"span")).html("<img src='/images/BacoError.gif' align=absmiddle>");
 					}
 					$GetEle("field"+id).value = "";
				}

			} else {
			   if (wuiUtil.getJsonValueByIndex(id1, 0) != "" && wuiUtil.getJsonValueByIndex(id1, 0) != "0" ) {
	               if (type1 == 162) {
				   		var ids = wuiUtil.getJsonValueByIndex(id1, 0);
						var names = wuiUtil.getJsonValueByIndex(id1, 1);
						var descs = wuiUtil.getJsonValueByIndex(id1, 2);
						sHtml = ""
						ids = ids.substr(1);
						$GetEle("field"+id).value= ids;
						
						names = names.substr(1);
						descs = descs.substr(1);
						var idArray = ids.split(",");
						var nameArray = names.split(",");
						var descArray = descs.split(",");
						for (var _i=0; _i<idArray.length; _i++) {
							var curid = idArray[_i];
							var curname = nameArray[_i];
							var curdesc = descArray[_i];
							sHtml += "<a title='" + curdesc + "' >" + curname + "</a>&nbsp";
						}
						
						jQuery($GetEle("field"+id+"span")).html(sHtml);
						return;
	               }
				   if (type1 == 161) {
					   	var ids = wuiUtil.getJsonValueByIndex(id1, 0);
					   	var names = wuiUtil.getJsonValueByIndex(id1, 1);
						var descs = wuiUtil.getJsonValueByIndex(id1, 2);
						$GetEle("field"+id).value = ids;
						sHtml = "<a title='" + descs + "'>" + names + "</a>&nbsp";
						jQuery($GetEle("field"+id+"span")).html(sHtml);
						return ;
				   }
	               if (type1 == 9 && "<%=docFlags%>" == "1" && (funFlag == undefined || funFlag != 3)) {
		                tempid = wuiUtil.getJsonValueByIndex(id1, 0);
				        $GetEle("field" + id + "span").innerHTML = "<a href='#' onclick=\"createDoc(" + id + ", " + tempid + ", 1)\">" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a><button type=\"button\"  type=\"button\" id=\"createdoc\" style=\"display:none\" class=\"AddDocFlow\" onclick=\"createDoc(" + id + ", " + tempid + ",1)\"></button>";
	               } else {
	            	    if (linkurl == "") {
				        	jQuery($GetEle("field" + id + "span")).html(wuiUtil.getJsonValueByIndex(id1, 1));
				        } else {
							if (linkurl == "/hrm/resource/HrmResource.jsp?id=") {
								jQuery($GetEle("field"+id+"span")).html("<a href=javaScript:openhrm("+ wuiUtil.getJsonValueByIndex(id1, 0) + "); onclick='pointerXY(event);'>" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a>&nbsp");
							} else {
								jQuery($GetEle("field"+id+"span")).html("<a href=" + linkurl + wuiUtil.getJsonValueByIndex(id1, 0) + " target='_new'>"+ wuiUtil.getJsonValueByIndex(id1, 1) + "</a>");
							}
				        }
	               }
	               $GetEle("field"+id).value = wuiUtil.getJsonValueByIndex(id1, 0);
	                if (type1 == 9 && "<%=docFlags%>" == "1" && (funFlag == undefined || funFlag != 3)) {
	                	var evt = getEvent();
	               		var targetElement = evt.srcElement ? evt.srcElement : evt.target;
	               		jQuery(targetElement).next("span[id=CreateNewDoc]").html("");
	                }
			   } else {
					if (ismand == 0) {
						jQuery($GetEle("field"+id+"span")).html("");
					} else {
						jQuery($GetEle("field"+id+"span")).html("<img src='/images/BacoError.gif' align=absmiddle>"); 
					}
					$GetEle("field"+id).value="";
					if (type1 == 9 && "<%=docFlags%>" == "1" && (funFlag == undefined || funFlag != 3)) {
						var evt = getEvent();
	               		var targetElement = evt.srcElement ? evt.srcElement : evt.target;
	               		jQuery(targetElement).next("span[id=CreateNewDoc]").html("<button type=button id='createdoc' class=AddDocFlow onclick=createDoc(" + id + ",'','1') title='<%=SystemEnv.getHtmlLabelName(82, userlanguage)%>'><%=SystemEnv.getHtmlLabelName(82, userlanguage)%></button>");
					}
			   }
			}
		}
	}
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

function onShowResourceConditionBrowser(id, url, linkurl, type1, ismand) {

	var tmpids = $GetEle("field" + id).value;
	var dialogId = window.showModalDialog(url + "?resourceCondition=" + tmpids);
	if ((dialogId)) {
		if (wuiUtil.getJsonValueByIndex(dialogId, 0) != "") {
			var shareTypeValues = wuiUtil.getJsonValueByIndex(dialogId, 0);
			var shareTypeTexts = wuiUtil.getJsonValueByIndex(dialogId, 1);
			var relatedShareIdses = wuiUtil.getJsonValueByIndex(dialogId, 2);
			var relatedShareNameses = wuiUtil.getJsonValueByIndex(dialogId, 3);
			var rolelevelValues = wuiUtil.getJsonValueByIndex(dialogId, 4);
			var rolelevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 5);
			var secLevelValues = wuiUtil.getJsonValueByIndex(dialogId, 6);
			var secLevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 7);

			var sHtml = "";
			var fileIdValue = "";
			








			var shareTypeValueArray = shareTypeValues.split("~");
			var shareTypeTextArray = shareTypeTexts.split("~");
			var relatedShareIdseArray = relatedShareIdses.split("~");
			var relatedShareNameseArray = relatedShareNameses.split("~");
			var rolelevelValueArray = rolelevelValues.split("~");
			var rolelevelTextArray = rolelevelTexts.split("~");
			var secLevelValueArray = secLevelValues.split("~");
			var secLevelTextArray = secLevelTexts.split("~");
			for ( var _i = 0; _i < shareTypeValueArray.length; _i++) {

				var shareTypeValue = shareTypeValueArray[_i];
				var shareTypeText = shareTypeTextArray[_i];
				var relatedShareIds = relatedShareIdseArray[_i];
				var relatedShareNames = relatedShareNameseArray[_i];
				var rolelevelValue = rolelevelValueArray[_i];
				var rolelevelText = rolelevelTextArray[_i];
				var secLevelValue = secLevelValueArray[_i];
				var secLevelText = secLevelTextArray[_i];
				if (shareTypeValue == "") {
					continue;
				}
				fileIdValue = fileIdValue + "~" + shareTypeValue + "_"
						+ relatedShareIds + "_" + rolelevelValue + "_"
						+ secLevelValue;
				
				if (shareTypeValue == "1") {
					sHtml = sHtml + "," + shareTypeText + "("
							+ relatedShareNames + ")";
				} else if (shareTypeValue == "2") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, userlanguage)%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18941, userlanguage)%>";
				} else if (shareTypeValue == "3") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, userlanguage)%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18942, userlanguage)%>";
				} else if (shareTypeValue == "4") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(3005, userlanguage)%>="
							+ rolelevelText
							+ "  <%=SystemEnv.getHtmlLabelName(683, userlanguage)%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18945, userlanguage)%>";
				} else {
					sHtml = sHtml
							+ ","
							+ "<%=SystemEnv.getHtmlLabelName(683, userlanguage)%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18943, userlanguage)%>";
				}

			}
			
			sHtml = sHtml.substr(1);
			fileIdValue = fileIdValue.substr(1);

			$GetEle("field" + id).value = fileIdValue;
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
//-->
</script>

<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<script type="text/javascript" src="/js/selectDateTime.js"></script>