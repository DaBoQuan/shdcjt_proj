<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="weaver.hrm.schedule.HrmAnnualManagement" %>
<%@ page import="weaver.hrm.schedule.HrmPaidSickManagement" %>
<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<%@ page import="weaver.system.code.*" %>
<%@ page import="weaver.workflow.request.RequestConstants" %>
<jsp:useBean id="WorkflowPhrase" class="weaver.workflow.sysPhrase.WorkflowPhrase" scope="page"/>
<jsp:useBean id="requestPreAddM" class="weaver.workflow.request.RequestPreAddinoperateManager" scope="page" />
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

<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rsaddop" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page"/>

<script type="text/javascript" language="javascript" src="/wui/common/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" language="javascript" src="/wui/common/js/ckeditor/ckeditorext.js"></script>

<%@ include file="/workflow/request/WorkflowAddRequestTitle.jsp" %>

<%
ArrayList uploadfieldids=new ArrayList();    
HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
CodeBuild cbuild = new CodeBuild(Util.getIntValue(formid));
String  codeFields=Util.null2String(cbuild.haveCode());
ArrayList flowDocs=flowDoc.getDocFiled(""+workflowid); //�õ����̽��ĵ��ķ��ĺ��ֶ�
String codeField="";
if (flowDocs!=null&&flowDocs.size()>0)
{
codeField=""+flowDocs.get(0);
}

 int secid = Util.getIntValue(docCategory.substring(docCategory.lastIndexOf(",")+1),-1);
 int maxUploadImageSize = Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+secid),5);
 if(maxUploadImageSize<=0){
 maxUploadImageSize = 5;
 }
 int wfid = Util.getIntValue(workflowid, 0);
 int uploadType = 0;
 String selectedfieldid = "";
 String result = RequestManager.getUpLoadTypeForSelect(wfid);
 if(!result.equals("")){
 selectedfieldid = result.substring(0,result.indexOf(","));
 uploadType = Integer.valueOf(result.substring(result.indexOf(",")+1)).intValue();
 }
 boolean isCanuse = RequestManager.hasUsedType(wfid);
 if(selectedfieldid.equals("") || selectedfieldid.equals("0")){
 	isCanuse = false;
 }
 String docFlags=(String)session.getAttribute("requestAdd"+user.getUID());
String newTNflag=(String)session.getAttribute("requestAddNewNodes"+user.getUID());
String flowDocField=(String)session.getAttribute("requestFlowDocField"+user.getUID());

ArrayList inoperatefields = new ArrayList();
ArrayList inoperatevalues = new ArrayList();
int fieldop1id=0;
requestPreAddM.setCreater(userid);
requestPreAddM.setOptor(userid);
requestPreAddM.setWorkflowid(wfid);
requestPreAddM.setNodeid(Util.getIntValue(nodeid));
Hashtable getPreAddRule_hs = requestPreAddM.getPreAddRule();
inoperatefields = (ArrayList)getPreAddRule_hs.get("inoperatefields");
inoperatevalues = (ArrayList)getPreAddRule_hs.get("inoperatevalues");

%>
<script language=javascript>

function accesoryChanage(obj){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        File.FilePath=objValue;
        fileLenth= File.getFileSize();
    } catch (e){
		if(e.message=="Type mismatch"||e.message=="���Ͳ�ƥ��"){
			alert("<%=SystemEnv.getHtmlLabelName(21015,user.getLanguage())%> ");
		}else{
			alert("<%=SystemEnv.getHtmlLabelName(21090,user.getLanguage())%> ");
		}
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1)
    if (fileLenthByM><%=maxUploadImageSize%>) {
        alert("<%=SystemEnv.getHtmlLabelName(20254,user.getLanguage())%>"+fileLenthByM+"M,<%=SystemEnv.getHtmlLabelName(20255,user.getLanguage())%><%=maxUploadImageSize%>M<%=SystemEnv.getHtmlLabelName(20256 ,user.getLanguage())%>");
        createAndRemoveObj(obj);
    }
}

function createAndRemoveObj(obj){
    objName = obj.name;
    tempObjonchange=obj.onchange;
    outerHTML="<input name="+objName+" class=InputStyle type=file size=60 >";  
    $GetEle(objName).outerHTML=outerHTML;       
    $GetEle(objName).onchange=tempObjonchange;
}
</script>

<!--TD4262 ������ʾ��Ϣ  ��ʼ-->
<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<!--TD4262 ������ʾ��Ϣ  ����-->

<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="workflowKeywordIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>

<form name="frmmain" method="post" action="BillBoHaiLeaveOperation.jsp" enctype="multipart/form-data" >
<input type="hidden" name="needwfback" id="needwfback" value="1" />
<input type=hidden name="workflowid" value=<%=workflowid%>>
<input type=hidden name="nodeid" value=<%=nodeid%>>
<input type=hidden name="nodetype" value="0">
<input type=hidden name="src">
<input type=hidden name="iscreate" value="1">
<input type=hidden name="formid" value=<%=formid%>>
<input type=hidden name ="isbill" value="<%=isbill%>">
<input type=hidden name ="topage" value="<%=topage%>">
<input type="hidden" name="htmlfieldids">
  <div align="center"><br>
    <font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font> <br>
    <br>
  </div>

  <table class="viewform">
    <colgroup> <col width="20%"> <col width="80%"> 
    <tr class="Spacing" style="height:1px;"> 
      <td class="Line1" colspan=2></td>
    </tr>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(85,user.getLanguage())%></td>
      <td class=field> 
      <%if(defaultName==1){%>
       <%--xwj for td1806 on 2005-05-09--%>
        <input type=text class=Inputstyle  temptitle="<%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%>" name=requestname onChange="checkinput('requestname','requestnamespan');changeKeyword()" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit( workflowname+"-"+username+"-"+currentdate,user.getLanguage() )%>" >
        <span id=requestnamespan></span>
      <%}else{%>
        <input type=text class=Inputstyle  temptitle="<%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%>" name=requestname onChange="checkinput('requestname','requestnamespan');changeKeyword()" size=60  maxlength=100  value = "" >
        <span id=requestnamespan><img src="/images/BacoError.gif" align=absmiddle></span>
      <%}%>
        <input type=radio value="0" name="requestlevel" checked><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
        <input type=radio value="1" name="requestlevel"><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
        <input type=radio value="2" name="requestlevel"><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%>
      </td>
    </tr>
    <tr class="Spacing" style="height:1px;">
      <td class="Line2" colspan=2></td>
    </tr>

  <!--���������п�ʼ -->
  <%
    if(messageType == 1){
  %>
  <tr>
    <td > <%=SystemEnv.getHtmlLabelName(17586,user.getLanguage())%></td>
    <td class=field>
	      <span id=messageTypeSpan></span>
	      <input type=radio value="0" name="messageType" checked><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%>
	      <input type=radio value="1" name="messageType"><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%>
	      <input type=radio value="2" name="messageType"><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%>
	    </td>
  </tr>
  <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>

  <%}%>
  <!--���������н��� -->
<%
  String userannualinfo = HrmAnnualManagement.getUserAannualInfo(userid+"",currentdate);
  String thisyearannual = Util.TokenizerString2(userannualinfo,"#")[0];
  String lastyearannual = Util.TokenizerString2(userannualinfo,"#")[1];
  String allannual = Util.TokenizerString2(userannualinfo,"#")[2];
  String userpslinfo = HrmPaidSickManagement.getUserPaidSickInfo(""+userid, currentdate);
  String thisyearpsldays = ""+Util.getFloatValue(Util.TokenizerString2(userpslinfo,"#")[0], 0);
  String lastyearpsldays = ""+Util.getFloatValue(Util.TokenizerString2(userpslinfo,"#")[1], 0);
  String allpsldays = ""+Util.getFloatValue(Util.TokenizerString2(userpslinfo,"#")[2], 0);

String keywordismand="0";
String keywordisedit="0";
int titleFieldId=0;
int keywordFieldId=0;
String isSignMustInput="0";
String needcheck10404 = "";
String isSignDoc_add="";
String isSignWorkflow_add="";
RecordSet.execute("select titleFieldId,keywordFieldId,isSignDoc,isSignWorkflow from workflow_base where id="+workflowid);
if(RecordSet.next()){
    titleFieldId=Util.getIntValue(RecordSet.getString("titleFieldId"),0);
	keywordFieldId=Util.getIntValue(RecordSet.getString("keywordFieldId"),0);
    isSignDoc_add=Util.null2String(RecordSet.getString("isSignDoc"));
    isSignWorkflow_add=Util.null2String(RecordSet.getString("isSignWorkflow"));
}
RecordSet.execute("select issignmustinput from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSet.next()){
	isSignMustInput = ""+Util.getIntValue(RecordSet.getString("issignmustinput"), 0);
	if("1".equals(isSignMustInput)){
		needcheck10404 = ",remarkText10404";
	}
}

List fieldids=new ArrayList();
List fieldlabels=new ArrayList();
List fieldhtmltypes=new ArrayList();
List fieldtypes=new ArrayList();
List fieldnames=new ArrayList();
ArrayList fieldrealtype=new ArrayList();

RecordSet.executeProc("workflow_billfield_Select",formid+"");
while(RecordSet.next()){
	fieldids.add(RecordSet.getString("id"));
	fieldlabels.add(RecordSet.getString("fieldlabel"));
	fieldhtmltypes.add(RecordSet.getString("fieldhtmltype"));
	fieldtypes.add(RecordSet.getString("type"));
	fieldnames.add(RecordSet.getString("fieldname"));
	fieldrealtype.add(Util.null2String(RecordSet.getString("fielddbtype")));
}

List isfieldids=new ArrayList();              //�ֶζ���
List isviews=new ArrayList();
List isedits=new ArrayList();
List ismands=new ArrayList();
RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
while(RecordSet.next()){
    isfieldids.add(Util.null2String(RecordSet.getString("fieldid")));
    isviews.add(Util.null2String(RecordSet.getString("isview")));
    isedits.add(Util.null2String(RecordSet.getString("isedit")));
    ismands.add(Util.null2String(RecordSet.getString("ismandatory")));
}


String fieldbodyname="";
String fieldbodyid="";
int isfieldidindex=-1;
String isbodyview="";
String isbodyedit="";
String isbodymand="";
String fieldbodyhtmltype="";
String fieldbodytype="";
String fieldbodylable="";

String fielddbtype="";                              //�ֶ���������
int languagebodyid = user.getLanguage() ;

String textheight = "4";//xwj for @td2977 20051111
int fieldlen=0;  //�ֶ����ͳ���

//��ô����ֶ���
DynamicDataInput ddi=new DynamicDataInput(workflowid+"");
String trrigerfield=ddi.GetEntryTriggerFieldName();
ArrayList selfieldsadd=WfLinkageInfo.getSelectField(Util.getIntValue(workflowid),Util.getIntValue(nodeid),0);
ArrayList changefieldsadd=WfLinkageInfo.getChangeField(Util.getIntValue(workflowid),Util.getIntValue(nodeid),0);

String selectNameLeaveType="";
String selectNameOtherLeaveType="";
String inputNameResourceId="";
String inputNameFromDate="";
String inputNameFromTime="";
String inputNameToDate="";
String inputNameToTime="";
String inputNameLeaveDays="";
boolean canEditForLeaveDays=true;

String lastyearannualdayslabel="";
String thisyearannualdayslabel="";
String allannualdayslabel="";
String lastyearpsldayslabel = "";
String thisyearpsldayslabel = "";
String allpsldayslabel = "";

int checkOtherLeaveType = -1;
for(int i=0;i<fieldids.size();i++){


    isbodyview="0";
	fieldbodyname=(String)fieldnames.get(i);
	fieldbodyid=(String)fieldids.get(i);

    isfieldidindex = isfieldids.indexOf(fieldbodyid) ;
    if( isfieldidindex != -1 ) {
        isbodyview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
	    isbodyedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
	    isbodymand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
    }
//    if( ! isbodyview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��

	if("1".equals(isbodymand))
    {
		if(!"otherLeaveType".equals(fieldbodyname))
    		needcheck+=",field"+fieldbodyid;
		else
			checkOtherLeaveType = 1;
    }

    fieldbodyhtmltype=(String)fieldhtmltypes.get(i);
    fieldbodytype=(String)fieldtypes.get(i);
    fieldbodylable=SystemEnv.getHtmlLabelName(Util.getIntValue((String)fieldlabels.get(i),0),user.getLanguage());
    
	fielddbtype=(String)fieldrealtype.get(i);
    if ((fielddbtype.toLowerCase()).indexOf("varchar")>-1)
	{
		fieldlen=Util.getIntValue(fielddbtype.substring(fielddbtype.indexOf("(")+1,fielddbtype.length()-1));
	}else if((fielddbtype.toLowerCase()).indexOf("text")>-1){
		fieldlen = 4000;
	}

    /*---hww for td9248 20081009 begin ---*/
  	String preAdditionalValue = "";
  	boolean isSetFlag = false;
  //RecordSet.executeSql("select customervalue from workflow_addinoperate where workflowid=" + workflowid + " and ispreadd='1' and isnode = 1 and objid = "+nodeid+" and fieldid = " + fieldbodyid);
  	//if(RecordSet.next()){
  		//isSetFlag = true;
  		//preAdditionalValue = RecordSet.getString("customervalue");
  	//}
	int inoperateindex=inoperatefields.indexOf(fieldbodyid);
		if(inoperateindex>-1){
			isSetFlag = true;
			preAdditionalValue = (String)inoperatevalues.get(inoperateindex);
		}
    /*---hww for td9248 20081009 end ---*/

    if(("resourceId").equals(fieldbodyname)){
		inputNameResourceId="field"+fieldbodyid;
    }
    if(("fromDate").equals(fieldbodyname)){
		inputNameFromDate="field"+fieldbodyid;
    }
    if(("fromTime").equals(fieldbodyname)){
		inputNameFromTime="field"+fieldbodyid;
    }
    if(("toDate").equals(fieldbodyname)){
		inputNameToDate="field"+fieldbodyid;
    }
    if(("toTime").equals(fieldbodyname)){
		inputNameToTime="field"+fieldbodyid;
    }
    if(("leaveDays").equals(fieldbodyname)){
		inputNameLeaveDays="field"+fieldbodyid;
    }
    if(("leaveType").equals(fieldbodyname)){
		selectNameLeaveType="field"+fieldbodyid;
    }
    if(("otherLeaveType").equals(fieldbodyname)){
		selectNameOtherLeaveType="field"+fieldbodyid;	
    }
    if(("lastyearannualdays").equals(fieldbodyname)){
        lastyearannualdayslabel="field"+fieldbodyid;
    }
    if(("thisyearannualdays").equals(fieldbodyname)){
        thisyearannualdayslabel="field"+fieldbodyid;
    }
    if(("allannualdays").equals(fieldbodyname)){
        allannualdayslabel="field"+fieldbodyid;
    }
	if("lastyearpsldays".equals(fieldbodyname)){
		lastyearpsldayslabel = "field"+fieldbodyid;
	}
	if("thisyearpsldays".equals(fieldbodyname)){
		thisyearpsldayslabel = "field"+fieldbodyid;
	}
	if("allpsldays".equals(fieldbodyname)){
		allpsldayslabel = "field"+fieldbodyid;
	}

   if(fieldbodyname.equals("manager")&&isbodyview.equals("0")) {
   %>
       <input type=hidden name="field<%=fieldbodyid%>" value="<%=ResourceComInfo.getManagerID(""+user.getUID())%>" />
   <%
       continue;
   }
   if(isbodyview.equals("1")){
%>



<%if(fieldbodyhtmltype.equals("5")&&("otherLeaveType").equals(fieldbodyname)){
%>
    <tr id=oTrOtherLeaveType style="display:none">
<%}else if(fieldbodyname.equals("lastyearannualdays")||fieldbodyname.equals("thisyearannualdays")||fieldbodyname.equals("allannualdays")||fieldbodyname.equals("lastyearpsldays")||fieldbodyname.equals("thisyearpsldays")||fieldbodyname.equals("allpsldays")){%>
    <tr id="field<%=fieldbodyid%>tr"  style="display:none"> 
<%}else {%>
    <tr>
<%}%>
      <%if(fieldbodyhtmltype.equals("2")){%>
      <td valign=top><%=Util.toScreen(fieldbodylable,user.getLanguage())%></td>
      <%}else{%>
      <td><%=Util.toScreen(fieldbodylable,user.getLanguage())%></td>
      <%}%>
      <td class=field> 
        <%
        if(fieldbodyhtmltype.equals("1")){                          // �����ı���
            if(fieldbodytype.equals("1")){                          // �����ı����е��ı�
                if(isbodyview.equals("1")){

                if(isbodyedit.equals("1")&&!fieldbodyid.equals(codeField)&&!fieldbodyid.equals(codeFields)){
					if(keywordFieldId>0&&(""+keywordFieldId).equals(fieldbodyid)){
%>
<button type=button  class=Browser  onclick="onShowKeyword(field<%=fieldbodyid%>.getAttribute('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(21517,user.getLanguage())%>"></button>
<%
					}
                    if(isbodymand.equals("1")) {
      %>
        <input datatype="text" viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" size=50 onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));checkLength('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldbodyid)){%>;changeKeyword()<%}%>"<%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>');" <%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
      <%

				    }else{%>
        <input datatype="text" viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" size=50 onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));checkLength('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldbodyid)){%>;changeKeyword()<%}%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>')" <%}%> value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <span id="field<%=fieldbodyid%>span"></span>
      <%            }
		    }else{ %>
        <!--input  type=text class=Inputstyle name="field<%=fieldbodyid%>"  size=50 readonly-->
            <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
            <input  type=hidden class=Inputstyle name="field<%=fieldbodyid%>"  size=50 value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
      <%          }
            }
            }
		    else if(fieldbodytype.equals("2")){                     // �����ı����е�����
                if(isbodyview.equals("1")){
			    if(isbodyedit.equals("1")){
				    if(isbodymand.equals("1")) {
      %>
        <input  datatype="int" viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" size=20
		onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checkcount1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldbodyid%>')" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));" <%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
       <%

				    }else{%>
        <input  datatype="int" viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" size=20 onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checkcount1(this);datainput('field<%=fieldbodyid%>');checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));" <%}%> value="<%=preAdditionalValue%>"> <!--modified by xwj for td3130 20051124-->
        <span id="field<%=fieldbodyid%>span"></span>
       <%           }
			    }else{  %>
         <!--input datatype="int" type=text class=Inputstyle name="field<%=fieldbodyid%>" size=20 readonly-->
         <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
         <input datatype="int" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <%        }
            }
            }
		    else if(fieldbodytype.equals("3")){                     // �����ı����еĸ�����
                if(isbodyview.equals("1")){
			    if(isbodyedit.equals("1")&&!fieldbodyname.equals("lastyearannualdays")&&!fieldbodyname.equals("thisyearannualdays")&&!fieldbodyname.equals("allannualdays")&&!fieldbodyname.equals("lastyearpsldays")&&!fieldbodyname.equals("thisyearpsldays")&&!fieldbodyname.equals("allpsldays")){
				    if(isbodymand.equals("1")) {
       %>
        <input datatype="float" viewtype="<%=isbodymand%>" type=text class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" size=20
		onKeyPress="ItemNum_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checknumber1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldbodyid%>')" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));"<%}%> value="<%=preAdditionalValue%>">
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
       <%
    				}else{%>
        <input datatype="float" viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" type=text class=Inputstyle name="field<%=fieldbodyid%>" size=20 onKeyPress="ItemNum_KeyPress()"  <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>onBlur="checknumber1(this);datainput('field<%=fieldbodyid%>');checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));"<%}%> value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <span id="field<%=fieldbodyid%>span"></span>
       <%           }
               }else{
                if(("leaveDays").equals(fieldbodyname)){
		            canEditForLeaveDays=false;
        %>
                <input type=hidden name="field<%=fieldbodyid%>" value="" >
                <span id="leaveDaysSpan"></span>
        <%
                }else if(fieldbodyname.equals("lastyearannualdays")||fieldbodyname.equals("thisyearannualdays")||fieldbodyname.equals("allannualdays")||fieldbodyname.equals("lastyearpsldays")||fieldbodyname.equals("thisyearpsldays")||fieldbodyname.equals("allpsldays")){
         %>
                <span id="field<%=fieldbodyid%>span"></span>
                <input type=hidden name="field<%=fieldbodyid%>" value="0" >
         <%         
                }else{				   
				   %>
         <!--input datatype="float" type=text class=Inputstyle name="field<%=fieldbodyid%>"  size=20 readonly-->
         <span id="field<%=fieldbodyid%>span"><%=preAdditionalValue%></span>
         <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" value="<%=preAdditionalValue%>"><!--modified by xwj for td3130 20051124-->
        <%
                }
               }
		    }
	    }
	     /*-----------xwj for td3131 20051115 begin ----------*/
	    else if(fieldbodytype.equals("4")){%>
            <table cols=2 id="field<%=fieldbodyid%>_tab">
            <tr><td>
                <%if(isbodyview.equals("1")){
                    if(isbodyedit.equals("1")){%>
                        <input datatype="float" viewtype="<%=isbodymand%>" type=text class=Inputstyle name="field_lable<%=fieldbodyid%>" size=60
                            onfocus="FormatToNumber('<%=fieldbodyid%>')"
                            onKeyPress="ItemNum_KeyPress('field_lable<%=fieldbodyid%>')"
                            <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
                                onBlur="numberToFormat('<%=fieldbodyid%>');datainput('field_lable<%=fieldbodyid%>');checkinput2('field_lable<%=fieldbodyid%>','field_lable<%=fieldbodyid%>span',field<%=fieldbodyid%>.getAttribute('viewtype'))"
                            <%}else{%>
                                onBlur="numberToFormat('<%=fieldbodyid%>');checkinput2('field_lable<%=fieldbodyid%>','field_lable<%=fieldbodyid%>span',field<%=fieldbodyid%>.getAttribute('viewtype'))"
                            <%}%>
                        >
                        <span id="field_lable<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)&&isbodymand.equals("1")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->
                        <span id="field<%=fieldbodyid%>span"></span>
                        <input datatype="float" viewtype="<%=isbodymand%>" type=hidden class=Inputstyle temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" value="">
                    <%}else{%>
                        <span id="field<%=fieldbodyid%>span"></span>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldbodyid%>" disabled="true">
                        <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldbodyid%>" value="">
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
			 }
			    /*-----xwj for @td2977 20051111 begin-----*/
            if(isbodyview.equals("1")){
		    if(isbodyedit.equals("1")){
			    if(isbodymand.equals("1")) {
       %>
        <textarea class=Inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>');" <%}%> onChange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')"
		rows="<%=textheight%>" cols="40" style="width:80%" class=Inputstyle ><%=preAdditionalValue%></textarea><!--xwj for @td2977 20051111-->
        <span id="field<%=fieldbodyid%>span"><%if("".equals(preAdditionalValue)){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span><!--modified by xwj for td3130 20051124-->

       <%
			    }else{
       %>
        <textarea class=Inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" onchange="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=fieldbodyid%>','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')" name="field<%=fieldbodyid%>" id="field<%=fieldbodyid%>" <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onBlur="datainput('field<%=fieldbodyid%>');" <%}%> rows="<%=textheight%>" cols="40" style="width:80%"><%=Util.encodeAnd(preAdditionalValue)%></textarea><!--xwj for @td2977 20051111--><!--modified by xwj for td3130 20051124-->
        <span id="field<%=fieldbodyid%>span"></span>
       <%       }%>
	   <script>$GetEle("htmlfieldids").value += "field<%=fieldbodyid%>;<%=Util.toScreen(fieldbodylable,languagebodyid)%>,";</script>
       <%  if (fieldbodytype.equals("2")) {%>
		   	<script>function funcField<%=fieldbodyid%>(){
				CkeditorExt.initEditor('frmmain','field<%=fieldbodyid%>',<%=user.getLanguage()%>,CkeditorExt.NO_IMAGE,200);
				<%if(isbodymand.equals("1"))out.println("CkeditorExt.checkText('field"+fieldbodyid+"span');");%>
				CkeditorExt.toolbarExpand(false);
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
                <input type=hidden class=Inputstyle name="field<%=fieldbodyid%>" value='<%=preAdditionalValue%>'><!--modified by xwj for td3130 20051124-->
         <!--textarea  class=Inputstyle name="field<%=fieldbodyid%>" rows="4" cols="40" style="width:80%"  readonly></textarea-->
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
            }else if((fieldbodytype.equals("1") ||fieldbodytype.equals("17")) && !hrmid.equals("")){ //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(hrmid,0);
            }else if((fieldbodytype.equals("7") || fieldbodytype.equals("18")) && !crmid.equals("")){ //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
                showid = "" + Util.getIntValue(crmid,0);
            }else if((fieldbodytype.equals("16") || fieldbodytype.equals("152") || fieldbodytype.equals("171")) && !reqid.equals("")){ //�����ťΪREQ,��ǰ��Ĳ����л��REQĬ��ֵ
                showid = "" + Util.getIntValue(reqid,0);
			}else if(fieldbodytype.equals("4") && !hrmid.equals("")){ //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(hrmid),0);
            }else if(fieldbodytype.equals("24") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(hrmid),0);
            }else if(fieldbodytype.equals("32") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"),0);
            }else if(fieldbodytype.equals("164") && !hrmid.equals("")){ //�����ťΪ�ֲ�,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�ķֲ��õ��ֲ�Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getSubCompanyID(hrmid),0);
            }
            
            if(fieldbodyname.equals("manager")){
                showid = ResourceComInfo.getManagerID(""+user.getUID());
                isbodyview = "1";
                isbodyedit = "0";
                isbodymand = "0";
                linkurl = "";
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

            if(fieldbodytype.equals("2") || fieldbodytype.equals("19")  )	showname=showid; // ����ʱ��
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
                }else{
                    String tablename=BrowserComInfo.getBrowsertablename(fieldbodytype);
                    String columname=BrowserComInfo.getBrowsercolumname(fieldbodytype);
                    String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldbodytype);
                    if(!tablename.equals("") && !columname.equals("") && !keycolumname.equals("")){
	                    String sql="";
	                    if(showid.indexOf(",")==-1){
	                        sql="select "+columname+" from "+tablename+" where "+keycolumname+"="+showid;
	                    }else{
	                        sql="select "+columname+" from "+tablename+" where "+keycolumname+" in("+showid+")";
	                    }

	                    RecordSet.executeSql(sql);
	                    while(RecordSet.next()) {
	                        if(!linkurl.equals(""))
	                            showname += "<a href='"+linkurl+showid+"' target='_new'>"+RecordSet.getString(1)+"</a>&nbsp";
	                        else
	                            showname +=RecordSet.getString(1) ;
	                    }
                    }
                }
            }

           //deleted by xwj for td3130 20051124

		    if(isbodyedit.equals("1")){
//add  by ben delweath rolepersone
	            if(("fromDate").equals(fieldbodyname)||("fromTime").equals(fieldbodyname)||("toDate").equals(fieldbodyname)||("toTime").equals(fieldbodyname)){%>
		<button type=button  class=Browser  onclick="onShowLeaveTime('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>','<%=isbodymand%>')" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
<%
				}else if(fieldbodytype.equals("160")){
                rsaddop.execute("select a.level_n from workflow_groupdetail a ,workflow_nodegroup b where a.groupid=b.id and a.type=50 and a.objid="+fieldbodyid+" and b.nodeid in (select nodeid from workflow_flownode where workflowid="+workflowid+" ) ");
				String roleid="";
				if (rsaddop.next())

				{
				roleid=rsaddop.getString(1);
				}
%>
        <button type=button  class=Browser  onclick="onShowResourceRole('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'),'<%=roleid%>')" title="<%=SystemEnv.getHtmlLabelName(20570,user.getLanguage())%>"></button>
<%
			  }
              else if(fieldbodytype.equals("161")||fieldbodytype.equals("162")){
              url+="?type="+fielddbtype;
%>
        <button type=button  class=Browser  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'))"></button>
<%
			  }
              else if(fieldbodytype.equals("141")){
%>
        <button type=button  class=Browser  onclick="onShowResourceConditionBrowser('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
<%
			  } else
//add by fanggsh 20060621 for TD4528 end
                if(!fieldbodytype.equals("37")&&!fieldbodytype.equals("9")) {
					session.setAttribute("relaterequest","new");
					//  ���ĵ����⴦��
	   %>
       <button type=button  class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'));datainput('field<%=fieldbodyid%>',field<%=fieldbodyid%>.getAttribute('viewtype'));"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'))"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
	   </button>
	   
        <%}else if(fieldbodytype.equals("37")){                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button type=button  class=AddDocFlow onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'))" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp<button type=button  class=AddDocFlow onclick="onNewDoc(<%=fieldbodyid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
       <%}else if(fieldbodytype.equals("9") && fieldbodyid.equals(flowDocField)){       // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
	        if(!"1".equals(newTNflag)){
	   %>
       <button type=button  class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'));datainput('field<%=fieldbodyid%>',field<%=fieldbodyid%>.getAttribute('viewtype'));"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>',field<%=fieldbodyid%>.getAttribute('viewtype'))"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
	   </button>
       <%}
        }else{%>
	    <button type=button  class=Browser <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>','<%=isbodymand%>');datainput('field<%=fieldbodyid%>','<%=isbodymand%>');"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldbodyid%>','<%=url%>','<%=linkurl%>','<%=fieldbodytype%>','<%=isbodymand%>')"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
	    </button>
	   <%}
           if(fieldbodytype.equals("9")&&docFlags.equals("1") && fieldbodyid.equals(flowDocField))  ///�Ƿ������̽��ĵ�s
           {%>
           <span id="CreateNewDoc"><button type=button  id="createdoc" class=AddDocFlow onclick="createDoc('<%=fieldbodyid%>','')" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
           </span>
           <%}
        }
	   if(fieldbodytype.equals("161")||fieldbodytype.equals("162")){%>
	   <input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" value="<%=showid%>" >
       <%}
       else if (fieldbodytype.equals("9")&&docFlags.equals("1")) {%>
		<input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" value="<%=showid%>"  <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onChange="datainput('field<%=fieldbodyid%>');" <%}%>>
      <%} else {%>
        <input type=hidden viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" value="<%=showid%>" onpropertychange="checkLengthbrow('field<%=fieldbodyid%>','field<%=fieldbodyid%>span','<%=fieldlen%>','<%=Util.toScreen(fieldbodylable,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>',field<%=fieldbodyid%>.getAttribute('viewtype'))"  <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onChange="datainput('field<%=fieldbodyid%>');" <%}%>>
		<%}%>
		
        <span id="field<%=fieldbodyid%>span"><%=Util.toScreen(showname,user.getLanguage())%>
       <%   if(isbodymand.equals("1") && showname.equals("")) {
       %>
           <img src="/images/BacoError.gif" align=absmiddle>
       <%
            }
       %>
        </span>
        &nbsp;&nbsp;
        <%if(fieldbodytype.equals("87")){%>
        <A href="/meeting/report/MeetingRoomPlan.jsp" target="blank"><%=SystemEnv.getHtmlLabelName(2193,user.getLanguage())%></A>
        <%}%>
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
        }
    }   
	else if(fieldbodyhtmltype.equals("4")){
	%>
        <input type=checkbox viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" value=1<%if(preAdditionalValue.equals("1")){%> checked<%}%>  name="field<%=fieldbodyid%>" <%if(isbodyedit.equals("0")){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldbodyid)>=0){%> onChange="datainput('field<%=fieldbodyid%>');" <%}%>><!--modified by xwj for td3130 20051124-->
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
        }
	}
	else if(fieldbodyhtmltype.equals("5")){                     // ѡ���   select

        String onChangeString="";

		if(trrigerfield.indexOf("field"+fieldbodyid)>=0){
			onChangeString+=";datainput('field"+fieldbodyid+"')";
		}

		if(selfieldsadd.indexOf(fieldbodyid)>=0){
			onChangeString+=";changeshowattr('"+fieldbodyid+"_0',this.value,-1,"+workflowid+","+nodeid+")";
		}

		if(("leaveType").equals(fieldbodyname)){
			onChangeString+=";changeDisplay(this.value)";  
		}

		if(("otherLeaveType").equals(fieldbodyname)){
			onChangeString+=";dispalyannualinfo(this)";
		}

		if(!onChangeString.equals("")){
			onChangeString=onChangeString.substring(1);
		}

	   %>
        <select class=inputstyle viewtype="<%=isbodymand%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>" name="field<%=fieldbodyid%>" <%if(isbodyedit.equals("0")){%> DISABLED <%}%> onBlur="checkinput2('field<%=fieldbodyid%>','field<%=fieldbodyid%>span',this.getAttribute('viewtype'));" 
<%if(("otherLeaveType").equals(fieldbodyname)){
%>
		  id=selectOtherLeaveType 
<%}%>
		<%if(!onChangeString.equals("")){%> onChange="<%=onChangeString%>" <%}%>	
		><!--added by xwj for td3313 20051206 -->
        <option value=""></option>    
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
            char flag= Util.getSeparator() ;
            rs.executeProc("workflow_selectitembyid_new",""+fieldbodyid+flag+isbill);
            //rs.executeProc("workflow_SelectItemSelectByid",""+fieldbodyid+flag+isbill);
			      boolean checkempty = true;//xwj for td3313 20051206
			      String finalvalue = "";//xwj for td3313 20051206
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                String isdefault = Util.toScreen(rs.getString("isdefault"),user.getLanguage());//xwj for td2977 20051107
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
        <input type=hidden class=Inputstyle name="field<%=fieldbodyid%>" value="<%=finalvalue%>" >
      <%}%>
	    <!--xwj for td3313 20051206 end-->
       <%
        if(changefieldsadd.indexOf(fieldbodyid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldbodyid%>" value="<%=Util.getIntValue(isbodyview,0)+Util.getIntValue(isbodyedit,0)+Util.getIntValue(isbodymand,0)%>" />
<%
        }
    }
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
          if(isbodyedit.equals("1")){
                boolean canupload=true;
                if(uploadType == 0){if("".equals(mainId) && "".equals(subId) && "".equals(secId)){
                    canupload=false;
            %>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(17616,user.getLanguage())+SystemEnv.getHtmlLabelName(92,user.getLanguage())+SystemEnv.getHtmlLabelName(15808,user.getLanguage())%>!</font>
           <%}}else if(!isCanuse){
               canupload=false;
           %>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(17616,user.getLanguage())+SystemEnv.getHtmlLabelName(92,user.getLanguage())+SystemEnv.getHtmlLabelName(15808,user.getLanguage())%>!</font>
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
                progressTarget : "fsUploadProgress<%=fieldbodyid%>",
                cancelButtonId : "btnCancel<%=fieldbodyid%>",
                uploadspan : "field<%=fieldbodyid%>span",
                uploadfiedid : "field<%=fieldbodyid%>"
            },
            debug: false,
            button_image_url : "/js/swfupload/add.png",
            button_placeholder_id : "spanButtonPlaceHolder<%=fieldbodyid%>",
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
            oUpload<%=fieldbodyid%>=new SWFUpload(settings);
        } catch(e) {
            alert(e)
        }
    }
        	//window.attachEvent("onload", fileupload<%=fieldbodyid%>);
        	if (window.addEventListener) {
			   	window.addEventListener("load", fileupload<%=fieldbodyid%>, false);
			} else if (window.attachEvent) {
			   	window.attachEvent("onload", fileupload<%=fieldbodyid%>);
			} else {
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
								<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload<%=fieldbodyid%>.cancelQueue();showmustinput(oUpload<%=fieldbodyid%>);" id="btnCancel<%=fieldbodyid%>">
									<span><img src="/js/swfupload/delete.gif" border="0"></span>
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--�������ѡ��--></span>
								</span><span id="uploadspan">(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%><%=maxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>)</span>
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
                  <input  class=InputStyle  type=hidden size=60 name="field<%=fieldbodyid%>" temptitle="<%=Util.toScreen(fieldbodylable,user.getLanguage())%>"  viewtype="<%=isbodymand%>">
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

    <%if(fieldbodyhtmltype.equals("5")&&("otherLeaveType").equals(fieldbodyname)){
    %>
    <tr class="Spacing"  id=oTrOtherLeaveTypeLine2 style="height:1px;" style="display:none">
      <td class="Line2" colspan=2></td>
    </tr>
    <%}else if(fieldbodyname.equals("lastyearannualdays")||fieldbodyname.equals("thisyearannualdays")||fieldbodyname.equals("allannualdays")){%>
    <tr class="Spacing" id="field<%=fieldbodyid%>line" style="height:1px;"  style="display:none">
      <td class="Line2" colspan=2></td>
    </tr>
	<%}else if(fieldbodyname.equals("lastyearpsldays")||fieldbodyname.equals("thisyearpsldays")||fieldbodyname.equals("allpsldays")){%>
    <tr class="Spacing" id="field<%=fieldbodyid%>line"  style="height:1px;" style="display:none">
      <td class="Line2" colspan=2></td>
    </tr>
    <%}else{%>
    <tr class="Spacing" style="height:1px;">
      <td class="Line2" colspan=2></td>
    </tr>
    <%}%>
    <%
   }else{// ����ʾ����Ϊ hidden ������Ϣ
%>
    <input type=hidden name="field<%=fieldbodyid%>" value="" >
<%
   }

}
%>    	  
    <tr class="Title">
      <td colspan=2 align="center" valign="middle"><font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></font></td>
    </tr>
    <tr>
      <td><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></td>
      <td class=field>

         <%
         //String workflowPhrases[] = WorkflowPhrase.getUserWorkflowPhrase(""+userid);
         //add by cyril on 2008-09-30 for td:9014
         boolean isSuccess  = RecordSet.executeProc("sysPhrase_selectByHrmId",""+userid); 
         String workflowPhrases[] = new String[RecordSet.getCounts()];
         String workflowPhrasesContent[] = new String[RecordSet.getCounts()];
         int x = 0 ;
         if (isSuccess) {
         	while (RecordSet.next()){
         		workflowPhrases[x] = Util.null2String(RecordSet.getString("phraseShort"));
         		workflowPhrasesContent[x] = Util.toHtml(Util.null2String(RecordSet.getString("phrasedesc")));
         		x ++ ;
         	}
         }
         //end by cyril on 2008-09-30 for td:9014
         if(workflowPhrases.length>0){
         %>

                <select class=inputstyle  id="phraseselect" name=phraseselect style="width:80%" onChange='onAddPhrase(this.value)'>
                <option value="">����<%=SystemEnv.getHtmlLabelName(22409,user.getLanguage())%>����</option>
                <%
                  for (int i= 0 ; i <workflowPhrases.length;i++) {
                    String workflowPhrase = workflowPhrases[i] ;  %>
                    <option value="<%=workflowPhrasesContent[i]%>"><%=workflowPhrase%></option>
                <%}%>
                </select>

          <%}%>
			<input type="hidden" id="remarkText10404" name="remarkText10404" value="" temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>">
              <textarea class=Inputstyle name=remark id="remark" rows=4 cols=40 style="width=80%;display:none" class=Inputstyle temptitle="<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"  <%if(isSignMustInput.equals("1")){%>onChange="checkinput('remark','remarkSpan')"<%}%>  ></textarea>
<script defer>
function funcremark_log(){
	CkeditorExt.initEditor("frmmain","remark",<%=user.getLanguage()%>,CkeditorExt.NO_IMAGE,200);
	<%if(isSignMustInput.equals("1")){%>
	CkeditorExt.checkText("remarkSpan","remark");
	<%}%>
	CkeditorExt.toolbarExpand(false,"remark");
}
//window.attachEvent("onload", funcremark_log);
			if (window.addEventListener) {
			   	window.addEventListener("load", funcremark_log, false);
			} else if (window.attachEvent) {
			   	window.attachEvent("onload", funcremark_log);
			} else {
			   	window.onload=funcremark_log;
			}
</script>
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
    </tr>
    <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
    <%
         if("1".equals(isSignDoc_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signdocids" name="signdocids">
                <button type=button  class=Browser onclick="onShowSignBrowser('/docs/docs/MutiDocBrowser.jsp','/docs/docs/DocDsp.jsp?isrequest=1&id=','signdocids','signdocspan',37)" title="<%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%>"></button>
                <span id="signdocspan"></span>
            </td>
          </tr>
          <tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         if("1".equals(isSignWorkflow_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signworkflowids" name="signworkflowids">
                <button type=button  class=Browser onclick="onShowSignBrowser('/workflow/request/MultiRequestBrowser.jsp','/workflow/request/ViewRequest.jsp?isrequest=1&requestid=','signworkflowids','signworkflowspan',152)" title="<%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%>"></button>
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
            <td><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></td>
            <td class=field>
            <%if(annexsecId<1){%>
           <font color="red"> <%=SystemEnv.getHtmlLabelName(21418,user.getLanguage())+SystemEnv.getHtmlLabelName(15808,user.getLanguage())%>!</font>
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
                "userid":"<%=user.getUID()%>",
                "logintype":"<%=user.getLogintype()%>"
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
            button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
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
        	if (window.addEventListener) {
			   	window.addEventListener("load", fileuploadannexupload, false);
			} else if (window.attachEvent) {
			   	window.attachEvent("onload", fileuploadannexupload);
			} else {
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
									<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--�������ѡ��--></span>
								</span><span>(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%><%=annexmaxUploadImageSize%><%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>)</span>
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

<input type=hidden name ="needcheck" value="<%=needcheck%>">
<input type=hidden name ="inputcheck" value="">

</form>
 
<script language=javascript>
function onNewDoc(fieldbodyid) {

    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldbodyid ;
    frmmain.isMultiDoc.value = fieldbodyid ;
    if(check_form($GetEle("frmmain"),'requestname')){

        $GetEle("frmmain").src.value='save';
        //�����ϴ�
                        StartUploadAll();
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
        if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && $GetEle("frmmain").<%=newenddate%>.value != "")
        {
            YearFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(0,4);
            MonthFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(5,7);
            DayFrom=$GetEle("frmmain").<%=newfromdate%>.value.substring(8,10);
            YearTo=$GetEle("frmmain").<%=newenddate%>.value.substring(0,4);
            MonthTo=$GetEle("frmmain").<%=newenddate%>.value.substring(5,7);
            DayTo=$GetEle("frmmain").<%=newenddate%>.value.substring(8,10);
            if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
                window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
                return false;
            }
        }
        return true;
    }

function doSave(){
	parastr = $GetEle("needcheck").value+$GetEle("inputcheck").value+"<%=needcheck10404%>" ;
	if(check_form($GetEle("frmmain"),parastr)&&checkOtherLeaveType2()){
		checkleavedays(null,"save");
		//checkOtherLeaveType(null,"save");
			//$GetEle("frmmain").src.value='save';
			//jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
			//$GetEle("frmmain").submit();
		
    }
}
function doSubmit(obj){

	parastr = $GetEle("needcheck").value+$GetEle("inputcheck").value+"<%=needcheck10404%>";
	if(check_form($GetEle("frmmain"),parastr)&&checkOtherLeaveType2()){
		checkleavedays(obj,"submit");
		//checkOtherLeaveType(obj,"submit");
		//$GetEle("frmmain").src.value='submit';
		//jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
		//$GetEle("frmmain").submit();
		//obj.disabled=true;
    }
}   
function checkOtherLeaveType2()
{
	<%if(checkOtherLeaveType==1){%>
	if("<%=selectNameLeaveType%>"==""||"<%=selectNameOtherLeaveType%>"==""||"<%=inputNameResourceId%>"==""||"<%=inputNameFromDate%>"==""){
		return true;
	}
	if($GetEle("<%=selectNameLeaveType%>").value=='4')
	{
		var v = $GetEle("<%=selectNameOtherLeaveType%>").value;
		if(v=="")
		{
			alert("\""+$GetEle("<%=selectNameOtherLeaveType%>").getAttribute("temptitle")+"\""+"<%=SystemEnv.getHtmlLabelName(21423,user.getLanguage())%>");
			return false;
		}
	}
	<%}%>
	return true;
}
function checkleavedays(obj,src){

	//��ȫ���
	if("<%=selectNameLeaveType%>"=="" || "<%=selectNameOtherLeaveType%>" == "" || "<%=inputNameResourceId%>"=="" || "<%=inputNameFromDate%>" == ""){
		return true;
	}

	//ֻ���������Ϊ 4:������н��   �����������Ϊ 2:���  ʱ�����жϣ����������Ϊ0ʱ�����������
	if($GetEle("<%=selectNameLeaveType%>").value=='4'&& $GetEle("<%=selectNameOtherLeaveType%>").value=='2'){
	    if("<%=allannual%>">0){

		   if($GetEle("<%=inputNameLeaveDays%>")!=null && parseFloat($GetEle("<%=inputNameLeaveDays%>").value) >parseFloat("<%=allannual%>")){
		     alert("<%=SystemEnv.getHtmlLabelName(21721,user.getLanguage())%>");
		   }else{
		   	$GetEle("frmmain").src.value=src;
			jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
			if(obj!=null) obj.disabled=true;
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
			return true;
	       }
		  }else if($GetEle("<%=selectNameLeaveType%>").value=='4'&& $GetEle("<%=selectNameOtherLeaveType%>").value=='11'){
			    if(<%=allpsldays%>>0){

				   if($GetEle("<%=inputNameLeaveDays%>")!=null && parseFloat($GetEle("<%=inputNameLeaveDays%>").value) >parseFloat("<%=allpsldays%>")){
				     alert("<%=SystemEnv.getHtmlLabelName(24045,user.getLanguage())%>");
				   }else{
				   	$GetEle("frmmain").src.value=src;
					jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
					if(obj!=null) obj.disabled=true;
                    //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
					return true;	    
			       }
			    }else{
			        alert("<%=SystemEnv.getHtmlLabelName(24044,user.getLanguage())%>");
			        return false;
			    } 	     
	    }else{
	        alert("<%=SystemEnv.getHtmlLabelName(21720,user.getLanguage())%>");
	        return false;
	    } 	     
	  }else{
	  		//setEmptyLeaveType();
			$GetEle("frmmain").src.value=src;
			jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
			if(obj!=null) obj.disabled=true;
            //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
			return true;
	}

}
function setEmptyLeaveType()
{
	if($GetEle("<%=selectNameLeaveType%>").value=='')
  	{
  		var selectNameLeaveType = $GetEle("<%=selectNameLeaveType%>");
  		if(selectNameLeaveType.options)
  		{
  			var op = selectNameLeaveType.options[0];
  			if(op)
  			{
  				op.value = "-1";
  				op.selected = true;
  			}
  		}
  		else
  		{
  			selectNameLeaveType.value = "-1";
  		}
  	}
  	if($GetEle("<%=selectNameOtherLeaveType%>").value=='')
  	{
  		var selectNameOtherLeaveType = $GetEle("<%=selectNameOtherLeaveType%>");
  		if(selectNameOtherLeaveType.options)
  		{
  			var op = selectNameOtherLeaveType.options[0];
  			if(op)
  			{
  				op.value = "-1";
  				op.selected = true;
  			}
  		}
  		else
  		{
  			selectNameOtherLeaveType.value = "-1";
  		}
  	}
}
function onAddPhrase(phrase){            <!-- ��ӳ��ö��� -->
    if(phrase!=null && phrase!=""){
      $GetEle("remarkSpan").innerHTML = "";
		try{
			var remarkHtml = CkeditorExt.getHtml("remark");
			var remarkText = CkeditorExt.getText("remark");
			if(remarkText==null || remarkText==""){
				CkeditorExt.setHtml(phrase,"remark");
			}else{
				CkeditorExt.setHtml(remarkHtml+"<p>"+phrase+"</p>","remark");
			}
		}catch(e){}
    }
}

function changeDisplay(objval){

    //���������Ϣ
     if($GetEle("<%=lastyearannualdayslabel%>tr")!=null){
        $GetEle("<%=lastyearannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=thisyearannualdayslabel%>tr")!=null){
        $GetEle("<%=thisyearannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=allannualdayslabel%>tr")!=null){
        $GetEle("<%=allannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=lastyearannualdayslabel%>line")!=null){
        $GetEle("<%=lastyearannualdayslabel%>line").style.display='none';
     }
     if($GetEle("<%=thisyearannualdayslabel%>line")!=null){
        $GetEle("<%=thisyearannualdayslabel%>line").style.display='none';
     }
     if($GetEle("<%=allannualdayslabel%>line")!=null){
        $GetEle("<%=allannualdayslabel%>line").style.display='none';
     }
     if($GetEle("<%=lastyearpsldayslabel%>tr")!=null){
         $GetEle("<%=lastyearpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=thisyearpsldayslabel%>tr")!=null){
         $GetEle("<%=thisyearpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=allpsldayslabel%>tr")!=null){
         $GetEle("<%=allpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=lastyearpsldayslabel%>line")!=null){
         $GetEle("<%=lastyearpsldayslabel%>line").style.display='none';
      }
      if($GetEle("<%=thisyearpsldayslabel%>line")!=null){
         $GetEle("<%=thisyearpsldayslabel%>line").style.display='none';
      }
      if($GetEle("<%=allpsldayslabel%>line")!=null){
         $GetEle("<%=allpsldayslabel%>line").style.display='none';
      }

//	if(objval==3||objval==4){
	if(objval==4){
		oTrOtherLeaveType.style.display="";
		oTrOtherLeaveTypeLine2.style.display="";		
		$GetEle("selectOtherLeaveType").style.display="";
        if($GetEle("selectOtherLeaveType").value==2){
           //��ʾ�����Ϣ
           if($GetEle("<%=lastyearannualdayslabel%>tr")!=null){
              $GetEle("<%=lastyearannualdayslabel%>tr").style.display='';
           }
           if($GetEle("<%=thisyearannualdayslabel%>tr")!=null){
              $GetEle("<%=thisyearannualdayslabel%>tr").style.display='';
           }
           if($GetEle("<%=allannualdayslabel%>tr")!=null){
              $GetEle("<%=allannualdayslabel%>tr").style.display='';
           }
           if($GetEle("<%=lastyearannualdayslabel%>line")!=null){
              $GetEle("<%=lastyearannualdayslabel%>line").style.display='';
           }
           if($GetEle("<%=thisyearannualdayslabel%>line")!=null){
              $GetEle("<%=thisyearannualdayslabel%>line").style.display='';
           }
           if($GetEle("<%=allannualdayslabel%>line")!=null){
              $GetEle("<%=allannualdayslabel%>line").style.display='';
           }           
        }else if($GetEle("selectOtherLeaveType").value=="11"){
            //��ʾ�����Ϣ
            if($GetEle("<%=lastyearpsldayslabel%>tr")!=null){
               $GetEle("<%=lastyearpsldayslabel%>tr").style.display='';
            }
            if($GetEle("<%=thisyearpsldayslabel%>tr")!=null){
               $GetEle("<%=thisyearpsldayslabel%>tr").style.display='';
            }
            if($GetEle("<%=allpsldayslabel%>tr")!=null){
               $GetEle("<%=allpsldayslabel%>tr").style.display='';
            }
            if($GetEle("<%=lastyearpsldayslabel%>line")!=null){
               $GetEle("<%=lastyearpsldayslabel%>line").style.display='';
            }
            if($GetEle("<%=thisyearpsldayslabel%>line")!=null){
               $GetEle("<%=thisyearpsldayslabel%>line").style.display='';
            }
            if($GetEle("<%=allpsldayslabel%>line")!=null){
               $GetEle("<%=allpsldayslabel%>line").style.display='';
            }
        }
	}else{

		oTrOtherLeaveType.style.display="none";
		oTrOtherLeaveTypeLine2.style.display="none";	
		$GetEle("selectOtherLeaveType").style.display="none";		
	} 
}

function ajaxInit(){
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

function checkOtherLeaveType(obj,src){

	//��ȫ���
	if("<%=selectNameLeaveType%>"==""||"<%=selectNameOtherLeaveType%>"==""||"<%=inputNameResourceId%>"==""||"<%=inputNameFromDate%>"==""){
		return true;
	}


	//ֻ���������Ϊ 4:������н��   �����������Ϊ 1:̽�׼�  2:���  ʱ�����ж�
	if($GetEle("<%=selectNameLeaveType%>").value=='4'
	 &&($GetEle("<%=selectNameOtherLeaveType%>").value=='1'||$GetEle("<%=selectNameOtherLeaveType%>").value=='2'&&$GetEle("<%=inputNameResourceId%>").value!='')
	  ){
		var ajax=ajaxInit();
        ajax.open("POST", "/workflow/request/BillBoHaiLeaveXMLHTTP.jsp", true);
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("operation=checkOtherLeaveType&leaveType="+$GetEle("<%=selectNameLeaveType%>").value+"&otherLeaveType="+$GetEle("<%=selectNameOtherLeaveType%>").value+"&resourceId="+$GetEle("<%=inputNameResourceId%>").value+"&fromDate="+$GetEle("<%=inputNameFromDate%>").value);
        //��ȡִ��״̬
        ajax.onreadystatechange = function() {
            //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
            if (ajax.readyState == 4 && ajax.status == 200) {
                try{
					var canSubmitOrSave=trim(ajax.responseText);
					if(canSubmitOrSave.indexOf("true")>-1){
						$GetEle("frmmain").src.value=src;
						jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
						//�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
						return true;
					}else{
			            alert("<%=SystemEnv.getHtmlLabelName(20072,user.getLanguage())%>");
						return false;
					}
                }catch(e){
			
			    }

            }
        }
	}else{
						$GetEle("frmmain").src.value=src;
						jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
						//�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
						return true;
	}
}


function getLeaveDays(){

	//��ȫ���
	if("<%=inputNameFromDate%>"==""||"<%=inputNameFromTime%>"==""||"<%=inputNameToDate%>"==""||"<%=inputNameToTime%>"==""||"<%=inputNameLeaveDays%>"==""||"<%=inputNameResourceId%>"==""){
		if("<%=inputNameLeaveDays%>"!=""){
					if("<%=canEditForLeaveDays%>"=="false"){
						$GetEle("<%=inputNameLeaveDays%>").value="0.00";
						leaveDaysSpan.innerHTML=leaveDays;
					}else{
						$GetEle("<%=inputNameLeaveDays%>").value="0.00";
					}
		}
		return ;
	}

	//�����ʼ���ڡ��������ں���������Ϊ�յĴ�������
	if($GetEle("<%=inputNameFromDate%>").value != '' && $GetEle("<%=inputNameToDate%>").value!='' && $GetEle("<%=inputNameResourceId%>").value!=''){
		var ajax=ajaxInit();
        ajax.open("POST", "/workflow/request/BillBoHaiLeaveXMLHTTP.jsp", true);
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("operation=getLeaveDays&fromDate="+$GetEle("<%=inputNameFromDate%>").value+"&fromTime="+$GetEle("<%=inputNameFromTime%>").value+"&toDate="+$GetEle("<%=inputNameToDate%>").value+"&toTime="+$GetEle("<%=inputNameToTime%>").value+"&resourceId="+$GetEle("<%=inputNameResourceId%>").value);
        //��ȡִ��״̬
        ajax.onreadystatechange = function() {
            //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���ĵط�
            if (ajax.readyState == 4 && ajax.status == 200) {
                try{
					var leaveDays=trim(ajax.responseText);
					if("<%=canEditForLeaveDays%>"=="false"){
						$GetEle("<%=inputNameLeaveDays%>").value=leaveDays;
						leaveDaysSpan.innerHTML=leaveDays;
					}else{
						$GetEle("<%=inputNameLeaveDays%>").value=leaveDays;
					}
                }catch(e){
					if("<%=canEditForLeaveDays%>"=="false"){
						$GetEle("<%=inputNameLeaveDays%>").value="0.00";
						leaveDaysSpan.innerHTML=leaveDays;
					}else{
						$GetEle("<%=inputNameLeaveDays%>").value="0.00";
					}
			    }

            }
        }
	}
}

function dispalyannualinfo(obj){
  if(obj.value==2){
     if($GetEle("<%=lastyearannualdayslabel%>tr")!=null){
        $GetEle("<%=lastyearannualdayslabel%>tr").style.display='';
     }
     if($GetEle("<%=lastyearannualdayslabel%>span")!=null){
        $GetEle("<%=lastyearannualdayslabel%>span").innerHTML = "<%=lastyearannual%>";
     }
     if($GetEle("<%=thisyearannualdayslabel%>tr")!=null){
        $GetEle("<%=thisyearannualdayslabel%>tr").style.display='';
     }
     if($GetEle("<%=thisyearannualdayslabel%>span")!=null){
        $GetEle("<%=thisyearannualdayslabel%>span").innerHTML = "<%=thisyearannual%>";
     }
     if($GetEle("<%=allannualdayslabel%>tr")!=null){
        $GetEle("<%=allannualdayslabel%>tr").style.display='';
     }
     if($GetEle("<%=allannualdayslabel%>span")!=null){
        $GetEle("<%=allannualdayslabel%>span").innerHTML = "<%=allannual%>";
     }
     if($GetEle("<%=lastyearannualdayslabel%>line")!=null){
        $GetEle("<%=lastyearannualdayslabel%>line").style.display='';
     }
     if($GetEle("<%=thisyearannualdayslabel%>line")!=null){
        $GetEle("<%=thisyearannualdayslabel%>line").style.display='';
     }
     if($GetEle("<%=allannualdayslabel%>line")!=null){
        $GetEle("<%=allannualdayslabel%>line").style.display='';
     }         
	 if($GetEle("<%=lastyearpsldayslabel%>tr")!=null){
	    $GetEle("<%=lastyearpsldayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=thisyearpsldayslabel%>tr")!=null){
        $GetEle("<%=thisyearpsldayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=allpsldayslabel%>tr")!=null){
        $GetEle("<%=allpsldayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=lastyearpsldayslabel%>line")!=null){
        $GetEle("<%=lastyearpsldayslabel%>line").style.display='none';
     }
     if($GetEle("<%=thisyearpsldayslabel%>line")!=null){
        $GetEle("<%=thisyearpsldayslabel%>line").style.display='none';
     }
     if($GetEle("<%=allpsldayslabel%>line")!=null){
        $GetEle("<%=allpsldayslabel%>line").style.display='none';
     }
  }else if(obj.value=="11"){
	     if($GetEle("<%=lastyearpsldayslabel%>tr")!=null){
	        $GetEle("<%=lastyearpsldayslabel%>tr").style.display='';
	     }
	     if($GetEle("<%=lastyearpsldayslabel%>span")!=null){
	        $GetEle("<%=lastyearpsldayslabel%>span").innerHTML = "<%=lastyearpsldays%>";
	     }
	     if($GetEle("<%=thisyearpsldayslabel%>tr")!=null){
	        $GetEle("<%=thisyearpsldayslabel%>tr").style.display='';
	     }
	     if($GetEle("<%=thisyearpsldayslabel%>span")!=null){
	        $GetEle("<%=thisyearpsldayslabel%>span").innerHTML = "<%=thisyearpsldays%>";
	     }
	     if($GetEle("<%=allpsldayslabel%>tr")!=null){
	        $GetEle("<%=allpsldayslabel%>tr").style.display='';
	     }
	     if($GetEle("<%=allpsldayslabel%>span")!=null){
	        $GetEle("<%=allpsldayslabel%>span").innerHTML = "<%=allpsldays%>";
	     }
	     if($GetEle("<%=lastyearpsldayslabel%>line")!=null){
	        $GetEle("<%=lastyearpsldayslabel%>line").style.display='';
	     }
	     if($GetEle("<%=thisyearpsldayslabel%>line")!=null){
	        $GetEle("<%=thisyearpsldayslabel%>line").style.display='';
	     }
	     if($GetEle("<%=allpsldayslabel%>line")!=null){
	        $GetEle("<%=allpsldayslabel%>line").style.display='';
	     }
		 if($GetEle("<%=lastyearannualdayslabel%>tr")!=null){
	        $GetEle("<%=lastyearannualdayslabel%>tr").style.display='none';
	     }
	     if($GetEle("<%=thisyearannualdayslabel%>tr")!=null){
	        $GetEle("<%=thisyearannualdayslabel%>tr").style.display='none';
	     }
	     if($GetEle("<%=allannualdayslabel%>tr")!=null){
	        $GetEle("<%=allannualdayslabel%>tr").style.display='none';
	     }
	     if($GetEle("<%=lastyearannualdayslabel%>line")!=null){
	        $GetEle("<%=lastyearannualdayslabel%>line").style.display='none';
	     }
	     if($GetEle("<%=thisyearannualdayslabel%>line")!=null){
	        $GetEle("<%=thisyearannualdayslabel%>line").style.display='none';
	     }
	     if($GetEle("<%=allannualdayslabel%>line")!=null){
	        $GetEle("<%=allannualdayslabel%>line").style.display='none';
	     }
  }else{
     if($GetEle("<%=lastyearannualdayslabel%>tr")!=null){
        $GetEle("<%=lastyearannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=thisyearannualdayslabel%>tr")!=null){
        $GetEle("<%=thisyearannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=allannualdayslabel%>tr")!=null){
        $GetEle("<%=allannualdayslabel%>tr").style.display='none';
     }
     if($GetEle("<%=lastyearannualdayslabel%>line")!=null){
        $GetEle("<%=lastyearannualdayslabel%>line").style.display='none';
     }
     if($GetEle("<%=thisyearannualdayslabel%>line")!=null){
        $GetEle("<%=thisyearannualdayslabel%>line").style.display='none';
     }
     if($GetEle("<%=allannualdayslabel%>line")!=null){
        $GetEle("<%=allannualdayslabel%>line").style.display='none';
     }        
     if($GetEle("<%=lastyearpsldayslabel%>tr")!=null){
         $GetEle("<%=lastyearpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=thisyearpsldayslabel%>tr")!=null){
         $GetEle("<%=thisyearpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=allpsldayslabel%>tr")!=null){
         $GetEle("<%=allpsldayslabel%>tr").style.display='none';
      }
      if($GetEle("<%=lastyearpsldayslabel%>line")!=null){
         $GetEle("<%=lastyearpsldayslabel%>line").style.display='none';
      }
      if($GetEle("<%=thisyearpsldayslabel%>line")!=null){
         $GetEle("<%=thisyearpsldayslabel%>line").style.display='none';
      }
      if($GetEle("<%=allpsldayslabel%>line")!=null){
         $GetEle("<%=allpsldayslabel%>line").style.display='none';
      }
  }
}
function onShowLeaveTime(fieldbodyid,url,linkurl,fieldbodytype,isbodymand){   
   spanname = "field"+fieldbodyid+"span"
   inputname = "field"+fieldbodyid	      
   var returnvalue;	  
   if(fieldbodytype==2){
     onBoHaiShowDate(spanname,inputname,isbodymand);
  }else{
     bohai = 1;
     onWorkFlowShowTime(spanname,inputname,isbodymand);
  }
}

  function addannexRow(accname,maxsize)
  {
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
          var sHtml = "<input class=InputStyle  type=file size=60 name='"+accname+"_"+$GetEle(accname+'_num').value+"' onchange='accesoryChanage(this)'> (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxsize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>) ";
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
//TD4262 ������ʾ��Ϣ  ����

function changeKeyword(){
<%
	if(titleFieldId>0&&keywordFieldId>0){
%>
	    var titleObj=$GetEle("field<%=titleFieldId%>");
	    var keywordObj=$GetEle("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $GetEle("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value;
	    }
<%
    }else if(titleFieldId==-3&&keywordFieldId>0){
%>
	    var titleObj=$GetEle("requestname");
	    var keywordObj=$GetEle("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $GetEle("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value;
	    }
<%
   }
%>
}

function updateKeywordData(strKeyword){
<%
	if(keywordFieldId>0){
%>
	var keywordObj=$GetEle("field<%=keywordFieldId%>");

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
	var keywordObj=$GetEle("field<%=keywordFieldId%>");
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

  setTimeout("doTriggerInit()",1000);
  function doTriggerInit(){
      var tempS = "<%=trrigerfield%>";
      datainput(tempS);
  }
  function datainput(parfield){                <!--���ݵ���-->
      //var xmlhttp=XmlHttp.create();
      var tempParfieldArr = parfield.split(",");
      var StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=0%>&trg="+parfield;
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
</script> 


<script type="text/javascript">
//<!--
function onShowBrowser2(id,url,linkurl,type1,ismand, funFlag) {
	var id1 = null;
	
    if (type1 == 9  && "<%=docFlags%>" == "1" ) {
        if (wuiUtil.isNotNull(funFlag) && funFlag == 3) {
        	url = "/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp"
        } else {
	    	url = "/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowserWord.jsp";
        }
	}
	
	if (type1 == 2 || type1 == 19 ) {
	    spanname = "field" + id + "span";
	    inputname = "field" + id;
	    
		if (type1 == 2) {
			onWorkFlowShowDate(spanname,inputname,ismand);
		} else {
			onWorkFlowShowTime(spanname, inputname, ismand);
		}
	} else {
	    if (type1 != 171 && type1 != 152 && type1 != 142 && type1 != 135 && type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=165 && type1!=166 && type1!=167 && type1!=168) {
				id1 = window.showModalDialog(url, window, "dialogWidth=550px;dialogHeight=550px");
		} else {
	        if (type1 == 135) {
				tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?projectids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        } else if (type1 == 37) {
		        tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?documentids=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
	        } else if (type1 == 142 ) {
		        tmpids = $GetEle("field"+id).value;
				id1 = window.showModalDialog(url + "?receiveUnitIds=" + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
			} else if (type1 == 165 || type1 == 166 || type1 == 167 || type1 == 168 ) {
		        index = (id + "").indexOf("_");
		        if (index != -1) {
		        	tmpids=uescape("?isdetail=1&fieldid="& Mid(id,1,index-1)&"&resourceids="&$GetEle("field"+id).value);
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
		        } else {
		        	tmpids = uescape("?fieldid=" + id + "&resourceids=" + $GetEle("field" + id).value);
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
						
						$GetEle("field" + id + "span").innerHTML = sHtml;
						return;
	               }
				   if (type1 == 161) {
					   	var ids = wuiUtil.getJsonValueByIndex(id1, 0);
					   	var names = wuiUtil.getJsonValueByIndex(id1, 1);
						var descs = wuiUtil.getJsonValueByIndex(id1, 2);
						$GetEle("field"+id).value = ids;
						sHtml = "<a title='" + descs + "'>" + names + "</a>&nbsp";
						$GetEle("field" + id + "span").innerHTML = sHtml
						return ;
				   }
	               if (type1 == 9 && "<%=docFlags%>" == "1") {
		                tempid = wuiUtil.getJsonValueByIndex(id1, 0);
		                $GetEle("field" + id + "span").innerHTML = "<a href='#' onclick=\"createDoc(" + id + ", " + tempid + ", 1)\">" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a><button type=\"button\"  type=\"button\" id=\"createdoc\" style=\"display:none\" class=\"AddDocFlow\" onclick=\"createDoc(" + id + ", " + tempid + ",1)\"></button>";
	               } else {
	            	    if (linkurl == "") {
				        	$GetEle("field" + id + "span").innerHTML = wuiUtil.getJsonValueByIndex(id1, 1);
				        } else {
							if (linkurl == "/hrm/resource/HrmResource.jsp?id=") {
								$GetEle("field"+id+"span").innerHTML = "<a href=javaScript:openhrm("+ wuiUtil.getJsonValueByIndex(id1, 0) + "); onclick='pointerXY(event);'>" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a>&nbsp";
							} else {
								$GetEle("field"+id+"span").innerHTML = "<a href=" + linkurl + wuiUtil.getJsonValueByIndex(id1, 0) + " target='_new'>"+ wuiUtil.getJsonValueByIndex(id1, 1) + "</a>";
							}
				        }
	               }
	               $GetEle("field"+id).value = wuiUtil.getJsonValueByIndex(id1, 0);
	                if (type1 == 9 && "<%=docFlags%>" == "1") {
	                	var evt = getEvent();
	               		var targetElement = evt.srcElement ? evt.srcElement : evt.target;
	               		jQuery(targetElement).next("span[id=CreateNewDoc]").html("");
	                }
			   } else {
					if (ismand == 0) {
						$GetEle("field"+id+"span").innerHTML = "";
					} else {
						$GetEle("field"+id+"span").innerHTML ="<img src='/images/BacoError.gif' align=absmiddle>"
					}
					$GetEle("field"+id).value="";
					if (type1 == 9 && "<%=docFlags%>" == "1"){
						var evt = getEvent();
	               		var targetElement = evt.srcElement ? evt.srcElement : evt.target;
	               		jQuery(targetElement).next("span[id=CreateNewDoc]").html("<button type=button  type=button id='createdoc' class=AddDocFlow onclick=createDoc(" + id + ",'','1') title='<%=SystemEnv.getHtmlLabelName(82, user.getLanguage())%>'><%=SystemEnv.getHtmlLabelName(82, user.getLanguage())%></button>");
					}
			   }
			}
		}
	}
}


function onShowResourceConditionBrowser(id, url, linkurl, type1, ismand) {

	var tmpids = $GetEle("field" + id).value;
	var dialogId = window.showModalDialog(url + "?resourceCondition=" + tmpids);
	if (dialogId) {
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
			shareTypeValues = shareTypeValues.substr(1);
			shareTypeTexts = shareTypeTexts.substr(1);
			relatedShareIdses = relatedShareIdses.substr(1);
			relatedShareNameses = relatedShareNameses.substr(1);
			rolelevelValues = rolelevelValues.substr(1);
			rolelevelTexts = rolelevelTexts.substr(1);
			secLevelValues = secLevelValues.substr(1);
			secLevelTexts = secLevelTexts.substr(1);

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
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18941, user.getLanguage())%>";
				} else if (shareTypeValue == "3") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18942, user.getLanguage())%>";
				} else if (shareTypeValue == "4") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(3005, user.getLanguage())%>="
							+ rolelevelText
							+ "  <%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18945, user.getLanguage())%>";
				} else {
					sHtml = sHtml
							+ ","
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18943, user.getLanguage())%>";
				}

			}

			sHtml = sHtml.substr(1);
			fileIdValue = fileIdValue.substr(1);

			$GetEle("field" + id).value = fileIdValue;
			$GetEle("field" + id + "span").innerHTML = sHtml;
		}
	} else {
		if (ismand == 0) {
			$GetEle("field" + id + "span").innerHtml = "";
		} else {
			$GetEle("field" + id + "span").innerHtml = "<img src='/images/BacoError.gif' align=absmiddle>";
		}
		$GetEle("field" + id).value = "";
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
//-->
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<script type="text/javascript" src="/js/selectDateTime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
