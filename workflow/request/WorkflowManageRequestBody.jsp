<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<jsp:useBean id="rs_item" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for @td2977 20051111-->
<jsp:useBean id="DocUtil" class="weaver.docs.docs.DocUtil" scope="page" />
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsaddop" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="ProjectInfoComInfo1" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="DocComInfo1" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo1" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo1" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="WfLinkageInfo" class="weaver.workflow.workflow.WfLinkageInfo" scope="page"/>
<jsp:useBean id="WorkflowJspBean" class="weaver.workflow.request.WorkflowJspBean" scope="page"/>
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page"/>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="/FCKEditor/FCKEditorExt.js"></script>

<%
int languagebodyid = user.getLanguage() ;
String selectInitJsStr = "";
String initIframeStr = "";
HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
ArrayList flowDocs=flowDoc.getDocFiled(""+workflowid); //�õ����̽��ĵ��ķ��ĺ��ֶ�
String codeField="";
if (flowDocs!=null&&flowDocs.size()>0)
{
codeField=""+flowDocs.get(0);
}
String docFlags=Util.null2String((String)session.getAttribute("requestAdd"+requestid));
String newTNflag=Util.null2String((String)session.getAttribute("requestAddNewNodes"+user.getUID()));
String flowDocField=Util.null2String((String)session.getAttribute("requestFlowDocField"+user.getUID()));
String bodychangattrstr="";
ArrayList managefckfields_billbody=new ArrayList();    
if (docFlags.equals("")) docFlags=Util.null2String((String)session.getAttribute("requestAdd"+user.getUID()));
Map secMaxUploads = new HashMap();//��װѡ��Ŀ¼����Ϣ
Map secCategorys = new HashMap();
ArrayList uploadfieldids=new ArrayList();
%>
<!--����ı��⿪ʼ -->
<div align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</div>
<title><%=Util.toScreen(workflowname,user.getLanguage())%></title>

<!--����ı������ -->
<iframe id="selectChange" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<iframe id="workflowKeywordIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<br>

<%
String isaffirmancebody=Util.null2String((String)session.getAttribute(user.getUID()+"_"+requestid+"isaffirmance"));//�Ƿ���Ҫ�ύȷ��
String reEditbody=Util.null2String((String)session.getAttribute(user.getUID()+"_"+requestid+"reEdit"));//�Ƿ���Ҫ�ύȷ��
int rqMessageType=-1;
int wfMessageType=-1;
String docCategory= "";
//String sqlWfMessage = "select a.messagetype,b.docCategory from workflow_requestbase a,workflow_base b where a.workflowid=b.id and a.requestid="+requestid ;
String sqlWfMessage = "select a.messagetype,b.docCategory,b.messagetype as wfMessageType from workflow_requestbase a,workflow_base b where a.workflowid=b.id and a.requestid="+requestid ;
RecordSet.executeSql(sqlWfMessage);
if (RecordSet.next()) {
    rqMessageType=RecordSet.getInt("messagetype");
    wfMessageType=RecordSet.getInt("wfMessageType");
	docCategory= RecordSet.getString("docCategory");
}
 int secid = Util.getIntValue(docCategory.substring(docCategory.lastIndexOf(",")+1),-1);
 int maxUploadImageSize = Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+secid),5); //�ӻ�����ȡ
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
 boolean isCanuse = RequestManager.hasUsedType(workflowid);
 if(selectedfieldid.equals("") || selectedfieldid.equals("0")){
 	isCanuse = false;
 }

 String keywordismand="0";
String keywordisedit="0";
int titleFieldId=0;
int keywordFieldId=0;
String canDelAcc="";
String forbidAttDownload="";
RecordSet.execute("select titleFieldId,keywordFieldId,candelacc,forbidAttDownload from workflow_base where id="+workflowid);
if(RecordSet.next()){
	titleFieldId=Util.getIntValue(RecordSet.getString("titleFieldId"),0);
	keywordFieldId=Util.getIntValue(RecordSet.getString("keywordFieldId"),0);
	canDelAcc = Util.null2String(RecordSet.getString("candelacc"));
	forbidAttDownload = Util.null2String(RecordSet.getString("forbidAttDownload"));
}
ArrayList selfieldsadd=WfLinkageInfo.getSelectField(workflowid,nodeid,0);
ArrayList changefieldsadd=WfLinkageInfo.getChangeField(workflowid,nodeid,0);    
%>

<table class="ViewForm">
  <colgroup>
  <col width="20%">
  <col width="80%">

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
  <tr class="Spacing" style="height:1px;">
    <td class="Line1" colSpan=2></td>
  </tr>
  <!--ҳ�����-->
<jsp:include page="WorkflowManageFirstRow.jsp" flush="true">
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="isremark" value="<%=isremark%>" />
    <jsp:param name="nodetype" value="<%=nodetype%>" />
    <jsp:param name="isaffirmancebody" value="<%=isaffirmancebody%>" />
    <jsp:param name="reEditbody" value="<%=reEditbody%>" />
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="requestlevel" value="<%=requestlevel%>" />
    <jsp:param name="rqMessageType" value="<%=rqMessageType%>" />
    <jsp:param name="wfMessageType" value="<%=wfMessageType%>" />
    <jsp:param name="isEdit_" value="<%=isEdit_%>" />
</jsp:include>
<input type="hidden" name="htmlfieldids">
<%

//��ѯ�����ߵ��ݵ��ֶ�,�ֶε����ƣ��ֶε�HTML���ͺ��ֶε����ͣ�����HTML���͵�һ����չ��
newdocid =Util.null2String((String)session.getAttribute(userid+"_"+requestid+"newdocid"));
WorkflowJspBean.setBillid(billid);
WorkflowJspBean.setFormid(formid);
WorkflowJspBean.setIsbill(isbill);
WorkflowJspBean.setNodeid(nodeid);
WorkflowJspBean.setRequestid(requestid);
WorkflowJspBean.setUser(user);
WorkflowJspBean.setWorkflowid(workflowid);
WorkflowJspBean.getWorkflowFieldInfo();
ArrayList fieldids=WorkflowJspBean.getFieldids();             //�ֶζ���
ArrayList fieldorders = WorkflowJspBean.getFieldorders();        //�ֶ���ʾ˳����� (�����ļ�����Ҫ)
ArrayList languageids=WorkflowJspBean.getLanguageids();          //�ֶ���ʾ������(�����ļ�����Ҫ)
ArrayList fieldlabels=WorkflowJspBean.getFieldlabels();          //���ݵ��ֶε�label����
ArrayList fieldhtmltypes=WorkflowJspBean.getFieldhtmltypes();       //���ݵ��ֶε�html type����
ArrayList fieldtypes=WorkflowJspBean.getFieldtypes();           //���ݵ��ֶε�type����
ArrayList fieldnames=WorkflowJspBean.getFieldnames();           //���ݵ��ֶεı��ֶ�������
ArrayList fieldvalues=WorkflowJspBean.getFieldvalues();          //�ֶε�ֵ
ArrayList fieldviewtypes=WorkflowJspBean.getFieldviewtypes();       //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)
ArrayList fieldimgwidths=WorkflowJspBean.getImgwidths();
ArrayList fieldimgheights=WorkflowJspBean.getImgheights();
ArrayList fieldimgnums=WorkflowJspBean.getImgnumprerows();
int fieldlen=0;  //�ֶ����ͳ���
ArrayList fieldrealtype=WorkflowJspBean.getFieldrealtype();
String fielddbtype="";                              //�ֶ���������
String textheight = "4";//xwj for @td2977 20051111
WorkflowJspBean.getWorkflowFieldViewAttr();


// ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
ArrayList isfieldids=WorkflowJspBean.getIsfieldids();              //�ֶζ���
ArrayList isviews=WorkflowJspBean.getIsviews();              //�ֶ��Ƿ���ʾ����
ArrayList isedits=WorkflowJspBean.getIsedits();              //�ֶ��Ƿ���Ա༭����
ArrayList ismands=WorkflowJspBean.getIsmands();              //�ֶ��Ƿ�����������


String beagenter=""+userid;
//��ñ�������
RecordSet.executeSql("select agentorbyagentid from workflow_currentoperator where usertype=0 and isremark='0' and requestid="+requestid+" and userid="+userid+" and nodeid="+nodeid+" order by id desc");
if(RecordSet.next()){
  int tembeagenter=RecordSet.getInt(1);
  if(tembeagenter>0) beagenter=""+tembeagenter;
}
session.removeAttribute("beagenter_"+user.getUID());
session.setAttribute("beagenter_"+user.getUID(), beagenter);
boolean editbodyflag=false;
boolean IsCanModify_wfmrb = "true".equals(session.getAttribute(user.getUID()+"_"+requestid+"IsCanModify"))?true:false;//���ⲿ�����ⵥ��ҳ����ø�ҳ��ʱIsCanModifyδ���������
if((isremark==0||IsCanModify_wfmrb) && (!isaffirmancebody.equals("1") || !nodetype.equals("0") || reEditbody.equals("1"))) editbodyflag=true;
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
if(isremark==5 || isremark==9){
    isedit = "0";//����(���ύ)���ɱ༭
    ismand="0";
}
    String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
    String fieldhtmltype = "" ;                     //�ֶε�ҳ������
    String fieldtype = "" ;                         //�ֶε�����
    String fieldlable = "" ;                        //�ֶ���ʾ��
    int fieldimgwidth=0;                            //ͼƬ�ֶο��
    int fieldimgheight=0;                           //ͼƬ�ֶθ߶�
    int fieldimgnum=0;                              //ÿ����ʾͼƬ����
    int languageid = 0 ;

    if(isbill.equals("0")) {
        languageid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
        fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
        fieldtype=FieldComInfo.getFieldType(fieldid);
        fieldlable=(String)fieldlabels.get(tmpindex);
        fieldname=FieldComInfo.getFieldname(fieldid);
		fielddbtype=FieldComInfo.getFielddbtype(fieldid);
		fieldimgwidth=FieldComInfo.getImgWidth(fieldid);
		fieldimgheight=FieldComInfo.getImgHeight(fieldid);
		fieldimgnum=FieldComInfo.getImgNumPreRow(fieldid);
    }
    else {
        languageid = user.getLanguage() ;
        fieldname=(String)fieldnames.get(tmpindex);
        fieldhtmltype=(String)fieldhtmltypes.get(tmpindex);
        fieldtype=(String)fieldtypes.get(tmpindex);
		fielddbtype=(String)fieldrealtype.get(tmpindex);
        fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(tmpindex),0),languageid );
        fieldimgwidth=Util.getIntValue((String)fieldimgwidths.get(tmpindex),0);
		fieldimgheight=Util.getIntValue((String)fieldimgheights.get(tmpindex),0);
		fieldimgnum=Util.getIntValue((String)fieldimgnums.get(tmpindex),0);
    }

    String fieldvalue=(String)fieldvalues.get(tmpindex);

	 fieldlen=0;
	if ((fielddbtype.toLowerCase()).indexOf("varchar")>-1)
	{
	   fieldlen=Util.getIntValue(fielddbtype.substring(fielddbtype.indexOf("(")+1,fielddbtype.length()-1));

	}
    if(fieldname.equals("manager")) {
	    String tmpmanagerid = ResourceComInfo.getManagerID(beagenter);
%>
	<input type=hidden name="field<%=fieldid%>" value="<%=tmpmanagerid%>">
<%
    if(isview.equals("1")){
%> <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%></td>
      <td class=field style="TEXT-VALIGN: center"><%=ResourceComInfo.getLastname(tmpmanagerid)%></td>
   </tr><tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>
<%
    }
	    continue;
	}

	if(fieldname.equals("begindate")) newfromdate="field"+fieldid;      //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if(fieldname.equals("enddate")) newenddate="field"+fieldid;     //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
    if(fieldhtmltype.equals("3") && fieldvalue.equals("0")) fieldvalue = "" ;
	if((""+keywordFieldId).equals(fieldid)) keywordismand=ismand;
	if((""+keywordFieldId).equals(fieldid)) keywordisedit=isedit;     

    if(ismand.equals("1")&&!fieldid.equals(codeField))  needcheck+=",field"+fieldid;   //�����������,�����������ļ����

    // ���濪ʼ������ʾ�ֶ�

    if(isview.equals("1")){         // �ֶ���Ҫ��ʾ
%>
    <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%></td>
      <td class=field style="word-wrap:break-word;word-break:break-all;TEXT-VALIGN: center">
      <%
        if(fieldhtmltype.equals("1")){                          // �����ı���
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(isedit.equals("1") &&!fieldid.equals(codeField) && editbodyflag){
					if(keywordFieldId>0&&(""+keywordFieldId).equals(fieldid)){
%>
<button type=button  class=Browser  onclick="onShowKeyword(field<%=fieldid%>.getAttribute('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(21517,user.getLanguage())%>"></button>
<%
					}
                    if(ismand.equals("1")) {
      %>
        <input datatype="text" viewtype="<%=ismand%>" type=text class=Inputstyle name="field<%=fieldid%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" size=50 value="<%=Util.toScreenForWorkflow(fieldvalue)%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));checkLength('field<%=fieldid%>','<%=fieldlen%>','<%=Util.toScreen(fieldlable,languageid)%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldid)){%>;changeKeyword()<%}%>">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%

				    }else{%>
        <input datatype="text" viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));checkLength('field<%=fieldid%>','<%=fieldlen%>','<%=Util.toScreen(fieldlable,languageid)%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')<%if(titleFieldId>0&&keywordFieldId>0&&(""+titleFieldId).equals(fieldid)){%>;changeKeyword()<%}%>" type=text class=Inputstyle name="field<%=fieldid%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> value="<%=Util.toScreenForWorkflow(fieldvalue)%>" size=50>
        <span id="field<%=fieldid%>span"></span>
      <%            }
			    }
                else {
      %>
        <span id="field<%=fieldid%>span"><%=Util.toScreenForWorkflow(fieldvalue)%></span>
         <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=Util.toScreenForWorkflow(fieldvalue)%>" >
      <%
                }
                if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
            }
		    else if(fieldtype.equals("2")){                     // �����ı����е�����
			    if(isedit.equals("1") && editbodyflag){
				    if(ismand.equals("1")) {
      %>
        <input datatype="int" viewtype="<%=ismand%>" type=text class=Inputstyle name="field<%=fieldid%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" size=10 value="<%=fieldvalue%>"
		onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'))" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%

				    }else{%>
        <input datatype="int" viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" type=text class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>')" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}%>>
        <span id="field<%=fieldid%>span"></span>
       <%           }
        if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
			    }
                else {
      %>
        <span id="field<%=fieldid%>span"><%=fieldvalue%></span>
         <input datatype="int" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
      <%
                }
		    }
		    else if(fieldtype.equals("3")||fieldtype.equals("5")){                     // �����ı����еĸ�����
		    	int decimaldigits_t = 2;
		    	if(fieldtype.equals("3")){
		    		int digitsIndex = fielddbtype.indexOf(",");
		        	if(digitsIndex > -1){
		        		decimaldigits_t = Util.getIntValue(fielddbtype.substring(digitsIndex+1, fielddbtype.length()-1), 2);
		        	}else{
		        		decimaldigits_t = 2;
		        	}
		    	}
			    if(isedit.equals("1") && editbodyflag){
				    if(ismand.equals("1")) {
       %>
        <input datatype="float" viewtype="<%=ismand%>" type=text class=Inputstyle name="field<%=fieldid%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" size=20 value="<%=fieldvalue%>"
       onKeyPress="ItemDecimal_KeyPress('field<%=fieldid%>',15,<%=decimaldigits_t%>)" <%if(fieldtype.equals("5")){%>onfocus="changeToNormalFormat('field<%=fieldid%>')"<%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>');<%if(fieldtype.equals("5")){%>changeToThousands('field<%=fieldid%>')<%}%>" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));<%if(fieldtype.equals("5")){%>changeToThousands('field<%=fieldid%>')<%}%>" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
    				}else{%>
        <input datatype="float" viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" type=text class=Inputstyle name="field<%=fieldid%>" size=20 value="<%=fieldvalue%>" onKeyPress="ItemDecimal_KeyPress('field<%=fieldid%>',15,<%=decimaldigits_t%>)" <%if(fieldtype.equals("5")){%>onfocus="changeToNormalFormat('field<%=fieldid%>')"<%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));datainput('field<%=fieldid%>');<%if(fieldtype.equals("5")){%>changeToThousands('field<%=fieldid%>')<%}%>" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));<%if(fieldtype.equals("5")){%>changeToThousands('field<%=fieldid%>')<%}%>" <%}%>>
        <span id="field<%=fieldid%>span"></span>
       <%           }
       if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
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
            <table cols=2 id="field<%=fieldid%>_tab">
                <tr><td>
                <%
                    if(isedit.equals("1") && editbodyflag){
                    if(ismand.equals("1")) {%>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" size=60
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
                                onBlur="numberToFormat('<%=fieldid%>');checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'));datainput('field_lable<%=fieldid%>')"
                            <%}else{%>
                                onBlur="numberToFormat('<%=fieldid%>');checkinput2('field_lable<%=fieldid%>','field_lable<%=fieldid%>span',field<%=fieldid%>.getAttribute('viewtype'))"
                            <%}%>
                        >
                    <%}%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
                <%
                  if(changefieldsadd.indexOf(fieldid)>=0){
                %>
                    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
                <%
                    }
                }else{%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>"  disabled="true" size=60>
                    <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
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

		  }                                                       // �����ı�����������
	    else if(fieldhtmltype.equals("2")){                     // �����ı���
	    /*-----xwj for @td2977 20051111 begin-----*/
	    if(isbill.equals("0")){
			 rscount.executeSql("select textheight from workflow_formdict where id = " + fieldid);
			 if(rscount.next()){
			 textheight = rscount.getString("textheight");
			 }
			 }else{
					rscount.executeSql("select * from workflow_billfield where viewtype=0 and id = " + fieldid+" and billid="+formid);
					if(rscount.next()){
						textheight = ""+Util.getIntValue(rscount.getString("textheight"), 4);
					}
				}
			    /*-----xwj for @td2977 20051111 begin-----*/
		    if(isedit.equals("1") && editbodyflag){
			    if(ismand.equals("1")) {
       %>
        <textarea class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%>  onChange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=fieldid%>','<%=fieldlen%>','<%=Util.toScreen(fieldlable,languageid)%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')"
		rows="<%=textheight%>" cols="40" style="width:80%;word-break:break-all;word-wrap:break-word" ><%=fieldtype.equals("2")?Util.toHtmltextarea(Util.encodeAnd(fieldvalue)):Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
			    }else{
       %>
      <textarea class=Inputstyle viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" name="field<%=fieldid%>" rows="<%=textheight%>" onchange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=fieldid%>','<%=fieldlen%>','<%=Util.toScreen(fieldlable,languageid)%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')" cols="40" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> style="width:80%;word-break:break-all;word-wrap:break-word"><%=fieldtype.equals("2")?Util.toHtmltextarea(Util.encodeAnd(fieldvalue)):Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
      <span id="field<%=fieldid%>span"></span>
	   <%       }%>
	   <script>$GetEle("htmlfieldids").value += "field<%=fieldid%>;<%=Util.toScreen(fieldlable,languagebodyid)%>,";</script>
       <%  if (fieldtype.equals("2")) {%>
		    <script>
			   function funcField<%=fieldid%>(){
			   	FCKEditorExt.initEditor('frmmain','field<%=fieldid%>',<%=user.getLanguage()%>,FCKEditorExt.NO_IMAGE);
				<%if(isedit.equals("1"))
					out.println("FCKEditorExt.checkText('field"+fieldid+"span','field"+fieldid+"');");%>
				    FCKEditorExt.toolbarExpand(false,"field<%=fieldid%>");
			   }
			   	if (window.addEventListener){
				    window.addEventListener("load", funcField<%=fieldid%>, false);
				}else if (window.attachEvent){
				    window.attachEvent("onload", funcField<%=fieldid%>);
				}else{
				    window.onload=funcField<%=fieldid%>;
				}
			</script>
			<%}
            if(changefieldsadd.indexOf(fieldid)>=0){
            %>
                <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
            <%
                }
            }else {if(fieldtype.equals("2")){
                session.setAttribute("FCKEDDesc_"+requestid+"_"+userid+"_"+fieldid+"_-1",fieldvalue);
                managefckfields_billbody.add("FCKiframe"+fieldid);
            %>
            <input type="hidden" id="FCKiframefieldid" value="FCKiframe<%=fieldid%>"/>
         <iframe id="FCKiframe<%=fieldid%>" name="FCKiframe<%=fieldid%>" src="/workflow/request/ShowFckEditorDesc.jsp?requestid=<%=requestid%>&userid=<%=userid%>&fieldid=<%=fieldid%>&rowno=-1"  width="100%" height="100%" marginheight="0" marginwidth="0" allowTransparency="true" frameborder="0"></iframe>
         <textarea name="field<%=fieldid%>" style="display:none"><%=Util.toHtmltextarea(Util.encodeAnd(fieldvalue))%></textarea>
<%
				}else{
%>
        <span id="field<%=fieldid%>span" style="word-break:break-all;word-wrap:break-word"><%=fieldvalue%></span>
         <textarea name="field<%=fieldid%>" style="display:none"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
<%
				}
      %>

      <%
            }
	    }                                                           // �����ı�����������
	    else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl =BrowserComInfo.getLinkurl(fieldtype);   // ���ֵ�����ʱ�����ӵ�url
            String showname = "";                                                   // ֵ��ʾ������
            String showid = "";                                                     // ֵ
            String hiddenlinkvalue="";    

            // ����Ƕ��ĵ�, ��Ҫ�ж��Ƿ����¼�����ĵ�,�����,��Ҫ����ԭ���ĺ���
            if( (fieldtype.equals("37")||(fieldtype.equals("9")&&docFlags.equals("1"))) && fieldid.equals(docfileid) && !newdocid.equals("")) {
                if( ! fieldvalue.equals("") ) fieldvalue += "," ;
               if (fieldtype.equals("9")&&docFlags.equals("1"))
               fieldvalue=newdocid ;
               else
               fieldvalue += newdocid ;
            }

            if(!fieldvalue.equals("")) {
                ArrayList tempshowidlist=Util.TokenizerString(fieldvalue,",");
                if(fieldtype.equals("9") || fieldtype.equals("37")){
                    //�ĵ������ĵ�
                    for(int k=0;k<tempshowidlist.size();k++){

                          if (fieldtype.equals("9")&&docFlags.equals("1"))
                        {
                        //linkurl="WorkflowEditDoc.jsp?docId=";//????
                       String tempDoc=""+tempshowidlist.get(k);
                       String tempDocView="0";
					   if(isedit.equals("1") && editbodyflag){
						   tempDocView="1";
					   }
                       showname+="<a href='javascript:createDoc("+fieldid+","+tempDoc+","+tempDocView+")' >"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp<button type=button  id='createdoc' style='display:none' class=AddDocFlow onclick=createDoc("+fieldid+","+tempDoc+","+tempDocView+")></button>";

                        }
                        else
                        {
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"' target='_blank'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=DocComInfo1.getDocname((String)tempshowidlist.get(k))+" ";
                        }
                        }
                    }
                }else if(fieldtype.equals("16") || fieldtype.equals("152") || fieldtype.equals("171")){
                    //�������
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            int tempnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
                            tempnum++;
                            session.setAttribute("resrequestid"+tempnum,""+tempshowidlist.get(k));
                            session.setAttribute("slinkwfnum",""+tempnum);
                            session.setAttribute("haslinkworkflow","1");
                            hiddenlinkvalue+="<input type=hidden name='slink"+fieldid+"_rq"+tempshowidlist.get(k)+"' value="+tempnum+">";
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&wflinkno="+tempnum+"' target='_new'>"+WorkflowRequestComInfo1.getRequestName((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=WorkflowRequestComInfo1.getRequestName((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("161")){//�Զ��嵥ѡ
                    showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
					String showdesc="";
				    showid =fieldvalue;                                     // �½�ʱ��Ĭ��ֵ
					try{
			            Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
			            BrowserBean bb=browser.searchById(showid);
						String desc=Util.null2String(bb.getDescription());
						String name=Util.null2String(bb.getName());
                        String href=Util.null2String(bb.getHref());
                        if(href.equals("")){
                        	showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
                        }else{
                        	showname+="<a title='"+desc+"' href='"+href+"' target='_blank'>"+name+"</a>&nbsp";
                        }
					}catch(Exception e){
					}
                }
                else if(fieldtype.equals("162")){//�Զ����ѡ
		            showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
				    showid =fieldvalue;                                     // �½�ʱ��Ĭ��ֵ
					try{
			            Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
						List l=Util.TokenizerString(showid,",");
			            for(int j=0;j<l.size();j++){
						    String curid=(String)l.get(j);
				            BrowserBean bb=browser.searchById(curid);
							String name=Util.null2String(bb.getName());
							//System.out.println("showname:"+showname);
							String desc=Util.null2String(bb.getDescription());
                            String href=Util.null2String(bb.getHref());
                            if(href.equals("")){
                            	showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
                            }else{
                            	showname+="<a title='"+desc+"' href='"+href+"' target='_blank'>"+name+"</a>&nbsp";
                            }
						}
					}catch(Exception e){
					}
                }if(fieldtype.equals("17")){//��������Դ��������
                	showname=WorkflowJspBean.getMultiResourceShowName(fieldvalue,linkurl,fieldid, user.getLanguage());
                }else{
                    showname=WorkflowJspBean.getWorkflowBrowserShowName(fieldvalue,fieldtype,linkurl,showid,fielddbtype);
                }
            }
            
            if(isedit.equals("1") && editbodyflag){
//add by fanggsh 20060621 for TD4528 begin
               if(fieldtype.equals("160")){
                   rsaddop.execute("select a.level_n, a.level2_n from workflow_groupdetail a ,workflow_nodegroup b where a.groupid=b.id and a.type=50 and a.objid="+fieldid+" and b.nodeid in (select nodeid from workflow_flownode where workflowid="+workflowid+") ");
   				String roleid="";
   				int rolelevel_tmp = 0;
   				if (rsaddop.next())
   				{
   				roleid=rsaddop.getString(1);
   				rolelevel_tmp=Util.getIntValue(rsaddop.getString(2), 0);
   				roleid += "a"+rolelevel_tmp+"b"+beagenter;
   				}
%>
        <button type=button  class=Browser  onclick="onShowResourceRole('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'),'<%=roleid%>')" title="<%=SystemEnv.getHtmlLabelName(20570,user.getLanguage())%>"></button>
<%
			  }
            else if(fieldtype.equals("161")||fieldtype.equals("162")){
             url+="?type="+fielddbtype;
		    %>
		    <button type=button  class=Browser  onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'));<%if(trrigerfield.indexOf("field"+fieldid)>=0){%>datainput('field<%=fieldid%>');<%}%>" ></button>
		    <%
            }
              else if(fieldtype.equals("141")){
%>
        <button type=button  class=Browser  onclick="onShowResourceConditionBrowser('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
<%
			  } else {
//add by fanggsh 20060621 for TD4528 end
                if( !fieldtype.equals("37") && !fieldtype.equals("9")) {    //  ���ĵ����⴦��
	   %>
        <button type=button  class=Browser 
		<%if(trrigerfield.indexOf("field"+fieldid)>=0){%>      onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'));datainput('field<%=fieldid%>');"		
		<%}else{%>
		onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))"
		<%}%> 
		title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
		</button>
			   
       <%} else if(fieldtype.equals("37")){                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button type=button  class=AddDocFlow onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp;<button type=button  class=AddDocFlow onclick="onNewDoc(<%=fieldid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
       <% }else if(fieldtype.equals("9")&&fieldid.equals(flowDocField)){
		     if(!"1".equals(newTNflag)){
	   %>
		<button type=button  class=Browser 
		<%if(trrigerfield.indexOf("field"+fieldid)>=0){%>      onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'));datainput('field<%=fieldid%>');"	
		<%}else{%>
		onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'))"
		<%}%> 
		title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
		</button>
	   <%}
	   }else{%>
	    <button type=button  class=Browser <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>
	      onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>');datainput('field<%=fieldid%>','<%=ismand%>');"
	   <%}else{%>
		  onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')"
	   <%}%> 
		  title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>">
	    </button>
		<%}
	    if (fieldtype.equals("9") && fieldid.equals(flowDocField)){%>
	    <span id="CreateNewDoc">
			 <%if(docFlags.equals("1")&&fieldvalue.equals(""))  ///????????s
           {%>
           <button type=button  id="createdoc" class=AddDocFlow onclick="createDoc('<%=fieldid%>','','1')" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
           <%}
            }%></span><%
            }
            }
       %>
        
        <%if(fieldtype.equals("87")){%>
        <A href="/meeting/report/MeetingRoomPlan.jsp" target="blank"><%=SystemEnv.getHtmlLabelName(2193,user.getLanguage())%></A>
        <%}%>
        <span id="field<%=fieldid%>span"><%=showname%>
       <%
            if( ismand.equals("1") && fieldvalue.equals("")){
       %>
        <img src="/images/BacoError.gif" align=absmiddle>
       <%
            }
       %>
        </span>
		   <%if (fieldtype.equals("9")||fieldtype.equals("161")||fieldtype.equals("162"))  {%>
		    <input type=hidden viewtype="<%=ismand%>" name="field<%=fieldid%>" value="<%=fieldvalue%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" >
		   <%} else {%>
		   <input type=hidden viewtype="<%=ismand%>" name="field<%=fieldid%>" value="<%=fieldvalue%>"  temptitle="<%=Util.toScreen(fieldlable,languageid)%>" onpropertychange="checkLengthbrow('field<%=fieldid%>','field<%=fieldid%>span','<%=fieldlen%>','<%=Util.toScreen(fieldlable,languageid)%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>',field<%=fieldid%>.getAttribute('viewtype'));<%if(trrigerfield.indexOf("field"+fieldid)>=0){%>datainput('field<%=fieldid%>')<%}%>">
			 <%}%>
           <%=hiddenlinkvalue%>
       <%
           if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
	    }                                                       // �����ť��������
	    else if(fieldhtmltype.equals("4")) {                    // check��
	   %>
        <input type=checkbox value=1 viewtype="<%=ismand%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" <%if(isedit.equals("0") || !editbodyflag){%> DISABLED <%}else{%> name="field<%=fieldid%>" <%}if(trrigerfield.indexOf("field"+fieldid)>=0){%> onChange="datainput('field<%=fieldid%>');" <%}%> <%if(fieldvalue.equals("1")){%> checked <%}%> >
        <%if(isedit.equals("0") || !editbodyflag){%>
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
            //����¼���Ϣ
        	String uploadMax = "";
        	if(fieldid.equals(selectedfieldid)&&uploadType==1)
        	{
        		uploadMax = "changeMaxUpload('field"+fieldid+"');reAccesoryChanage();"; 
        	}
        	//����select�ֶ�����
         	String onchangeAddStr = "";
        	int childfieldid_tmp = 0;
        	if("0".equals(isbill)){
        		rs_item.execute("select childfieldid from workflow_formdict where id="+fieldid);
        	}else{
        		rs_item.execute("select childfieldid from workflow_billfield where id="+fieldid);
        	}
        	if(rs_item.next()){
	       		childfieldid_tmp = Util.getIntValue(rs_item.getString("childfieldid"), 0);
        	}
        	int firstPfieldid_tmp = 0;
        	boolean hasPfield = false;
        	if("0".equals(isbill)){
        		rs_item.execute("select id from workflow_formdict where childfieldid="+fieldid);
        	}else{
        		rs_item.execute("select id from workflow_billfield where childfieldid="+fieldid);
        	}
        	while(rs_item.next()){
        		firstPfieldid_tmp = Util.getIntValue(rs_item.getString("id"), 0);
        		if(fieldids.contains(""+firstPfieldid_tmp)){
        			hasPfield = true;
        			break;
        		}
        	}
        	if(childfieldid_tmp != 0){//����ȳ������ֶΣ���Ҫ�����ֶ�����ѡ�����
				onchangeAddStr = "changeChildField(this, "+fieldid+", "+childfieldid_tmp+")";
			}
	   %>
        <script>
        	function funcField<%=fieldid%>(){
        	    changeshowattr('<%=fieldid%>_0',$GetEle('field<%=fieldid%>').value,-1,'<%=workflowid%>','<%=nodeid%>');
        	}
        	if (window.addEventListener){
			    window.addEventListener("load", funcField<%=fieldid%>, false);
			}else if (window.attachEvent){
			    window.attachEvent("onload", funcField<%=fieldid%>);
			}else{
			    window.onload=funcField<%=fieldid%>;
			}
        </script>
        <select class=inputstyle viewtype="<%=ismand%>"  temptitle="<%=Util.toScreen(fieldlable,languageid)%>" onBlur="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%if(isedit.equals("0") || !editbodyflag){%> name="disfield<%=fieldid%>" DISABLED <%}else{%> name="field<%=fieldid%>" <%}%> onChange="<%=uploadMax%><%if(trrigerfield.indexOf("field"+fieldid)>=0){%>datainput('field<%=fieldid%>');<%}if(selfieldsadd.indexOf(fieldid)>=0){%>changeshowattr('<%=fieldid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);<%}if((isbill+"").equals("1")&&(formid+"").equals("158")){%>balancestyleShow();<%}%><%=onchangeAddStr%>" >
	    <option value=""></option><!--added by xwj for td3297 20051130 -->
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
             boolean checkempty = true;//xwj for td3313 20051206
			 String finalvalue = "";//xwj for td3313 20051206
				if(hasPfield == false || isedit.equals("0") || (isaffirmancebody.equals("1") && !reEditbody.equals("1")) || isremark!=0 || nodetype.equals("3")){
		          rs.executeProc("workflow_selectitembyid_new",""+fieldid+flag+isbill);
	              while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                //��ȡѡ��Ŀ¼�ĸ�����С��Ϣ
                String tdocCategory = Util.toScreen(rs.getString("docCategory"),user.getLanguage());
                String tMaxUploadFileSize = "";
                if(!"".equals(tdocCategory)&&fieldid.equals(selectedfieldid)&&uploadType==1)
                {
                	int tsecid = Util.getIntValue(tdocCategory.substring(tdocCategory.lastIndexOf(",")+1),-1);
                	tMaxUploadFileSize = ""+Util.getIntValue(SecCategoryComInfo1.getMaxUploadFileSize(""+tsecid),5);
                	secMaxUploads.put(tmpselectvalue,tMaxUploadFileSize);
                    secCategorys.put(tmpselectvalue,tdocCategory);
                }      
                 /* -------- xwj for td3313 20051206 begin -*/
                 if(tmpselectvalue.equals(fieldvalue)){
				          checkempty = false;
				          finalvalue = tmpselectvalue;
                          if(!"".equals(tdocCategory)&&fieldid.equals(selectedfieldid)&&uploadType==1)
                            {
                            maxUploadImageSize = Util.getIntValue(tMaxUploadFileSize,5);
                            docCategory=tdocCategory;
                            }
				         }
				         /* -------- xwj for td3313 20051206 end -*/
	   %>
	    <option value="<%=tmpselectvalue%>" <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
	   <%
            }
		}else{
            rs.executeProc("workflow_selectitembyid_new",""+fieldid+flag+isbill);
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                if(tmpselectvalue.equals(fieldvalue)){
			          checkempty = false;
			          finalvalue = tmpselectvalue;
			    }
			%>
			<option value="<%=tmpselectvalue%>" <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
			<%
            }
        	selectInitJsStr += "doInitChildSelect("+fieldid+","+firstPfieldid_tmp+",\""+finalvalue+"\");\n";
        	initIframeStr += "<iframe id=\"iframe_"+firstPfieldid_tmp+"_"+fieldid+"_00\" frameborder=0 scrolling=no src=\"\"  style=\"display:none\"></iframe>";
		}
           if(selfieldsadd.indexOf(fieldid)>=0) bodychangattrstr+="changeshowattr('"+fieldid+"_0','"+finalvalue+"',-1,"+workflowid+","+nodeid+");";
       %>
	    </select>

	    <!--xwj for td3313 20051206 begin-->
	    <span id="field<%=fieldid%>span">
	    <%
	     if(ismand.equals("1") && checkempty){
	    %>
       <img src='/images/BacoError.gif' align=absMiddle>
      <%
            }
       %>
	     </span>
	    <!--xwj for td3313 20051206 end-->

        <%if(isedit.equals("0") || !editbodyflag){%>
        <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=finalvalue%>" temptitle="<%=Util.toScreen(fieldlable,languageid)%>" >
        <%}%>
       <%
            if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
        //add by xhheng @20050310 for �����ϴ�
        }else if(fieldhtmltype.equals("6")){
        %>
          <%if( isedit.equals("1") && editbodyflag){%>
          <!--modify by xhheng @20050511 for 1803-->
          <table cols=3 id="field<%=fieldid%>_tab">
            <tbody >
            <col width="50%" >
            <col width="25%" >
            <col width="25%">
          <%
			if("-2".equals(fieldvalue)){%>
			<tr>
				<td colSpan=3><font color="red">
				<%=SystemEnv.getHtmlLabelName(21710,user.getLanguage())%></font>
				</td>
			</tr>
			  <%}else{
          if(!fieldvalue.equals("")) {
            sql="select id,docsubject,accessorycount,SecCategory from docdetail where id in("+fieldvalue+") order by id asc";
            RecordSet.executeSql(sql);
            int AttachmentCounts=RecordSet.getCounts();
            int linknum=-1;
            boolean isfrist=false;
            int imgnum=fieldimgnum;
            while(RecordSet.next()){
              isfrist=false;
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              
              if (isedit.equals("1")) {
                  session.setAttribute(user.getUID() + "_FORWARD_" + showid, "1");
              } else {
            	  session.removeAttribute(user.getUID() + "_FORWARD_" + showid);
              }
              
              String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
              int accessoryCount=RecordSet.getInt(3);
              String SecCategory=Util.null2String(RecordSet.getString(4));
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
              boolean nodownload=SecCategoryComInfo1.getNoDownload(SecCategory).equals("1")?true:false;
              String imgSrc=AttachFileUtil.getImgStrbyExtendName(fileExtendName,20);
              if(fieldtype.equals("2")){
              if(linknum==0){
              isfrist=true;
              %>
              
			<% 
             if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0){
            %>           
            <tr> 
              <td colSpan=3><nobr>
                  <button type=button class=btnFlowd accessKey=1  onclick="downloadsBatch('<%=fieldvalue%>','<%=requestid%>')">
                    <%="&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(74,user.getLanguage())+SystemEnv.getHtmlLabelName(332,user.getLanguage())+SystemEnv.getHtmlLabelName(258,user.getLanguage())%>
                  </button>            
              </td>
            </tr> 
            <%}%> 
              
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
                              <%
                                  //�����ڵ㣬���Ҹ�������������ɾ����������Ȩ��ɾ��������
                                  if (!canDelAcc.equals("1") || (canDelAcc.equals("1") && nodetype.equals("0"))) {
                              %>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick='onChangeSharetype("span<%=fieldid%>_id_<%=linknum%>","field<%=fieldid%>_del_<%=linknum%>","<%=ismand%>",oUpload<%=fieldid%>);return false;'>[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></span>]</a>
                                    <span id="span<%=fieldid%>_id_<%=linknum%>" name="span<%=fieldid%>_id_<%=linknum%>" style="visibility:hidden"><b><font COLOR="#FF0033">��</font></b><span></td>
                              <%}
                                  if (!nodownload) {
                              %>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>');return false;">[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></span>]</a>
                              </td>
                              <%}%>
                      </tr>
                        </table>
                    </td>
              <%}else{
              %>
              <tr>
            <input type=hidden name="field<%=fieldid%>_del_<%=linknum%>" value="0" >
            <td >
              <%=imgSrc%>

              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a  style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openDocExt('<%=showid%>','<%=versionId%>','<%=docImagefileid%>',1)"><%=docImagefilename%></a>&nbsp
              <%}else{%>
                <a style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>')"><%=docImagefilename%></a>&nbsp

              <%}%>
              <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>>
            </td>
            <%
            //�����ڵ㣬���Ҹ�������������ɾ����������Ȩ��ɾ��������
            if(!canDelAcc.equals("1")||(canDelAcc.equals("1")&&nodetype.equals("0"))){
            %>
            <td >
                <button type=button  class=btnFlow accessKey=1  onclick='onChangeSharetype("span<%=fieldid%>_id_<%=linknum%>","field<%=fieldid%>_del_<%=linknum%>","<%=ismand%>",oUpload<%=fieldid%>)'><u><%=linknum%></u>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%>
                </button><span id="span<%=fieldid%>_id_<%=linknum%>" name="span<%=fieldid%>_id_<%=linknum%>" style="visibility:hidden">
                    <b><font COLOR="#FF0033">��</font></b>
                  <span>
            </td>
            <%}%>
            <%if(accessoryCount==1){%>
            <td >
              <span id = "selectDownload">
                <%
                  if((!fileExtendName.equalsIgnoreCase("xls")&&!fileExtendName.equalsIgnoreCase("doc")&&!fileExtendName.equalsIgnoreCase("xlsx")&&!fileExtendName.equalsIgnoreCase("docx"))||!nodownload){
                %>
                  <button type=button  class=btnFlowd accessKey=1  onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>')">
                    <u><%=linknum%></u>-<%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%>	  (<%=docImagefileSize/1000%>K)
                  </button>
                  
                 <% 
                    //if(isDownloadAll && AttachmentCounts>1 && (linknum+1)==AttachmentCounts){
                    if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0){
                  %>
                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <button type=button class=btnFlowd accessKey=1  onclick="downloadsBatch('<%=fieldvalue%>','<%=requestid%>')">
                    <%="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(332,user.getLanguage())+SystemEnv.getHtmlLabelName(258,user.getLanguage())%>
                  </button>
                  <%}%> 
                  
                <%}%>
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
          <%}
		}%>
          <tr>
            <td colspan=3>
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
               uploadfieldids.add(fieldid);
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
          	if (window.addEventListener){
			    window.addEventListener("load", fileupload<%=fieldid%>, false);
			}else if (window.attachEvent){
			    window.attachEvent("onload", fileupload<%=fieldid%>);
			}else{
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
          <table cols=3 id="field<%=fieldid%>_tab">
            <tbody >
            <col width="50%" >
            <col width="25%" >
            <col width="25%">
            <%
            sql="select id,docsubject,accessorycount,SecCategory from docdetail where id in("+fieldvalue+") order by id asc";
            int linknum=-1;
            RecordSet.executeSql(sql);
            int AttachmentCounts=RecordSet.getCounts();
            boolean isfrist=false;
            int imgnum=fieldimgnum;
            while(RecordSet.next()){
              isfrist=false;
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
              int accessoryCount=RecordSet.getInt(3);
              String SecCategory=Util.null2String(RecordSet.getString(4));
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
              boolean nodownload=SecCategoryComInfo1.getNoDownload(SecCategory).equals("1")?true:false;
              if(fieldtype.equals("2")){
              if(linknum==0){
              isfrist=true;
              %>
              
			<% 
             if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0){
            %>
            <tr> 
              <td colSpan=3><nobr>
                  <button type=button class=btnFlowd accessKey=1  onclick="downloadsBatch('<%=fieldvalue%>','<%=requestid%>')">
                    <%="&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(74,user.getLanguage())+SystemEnv.getHtmlLabelName(332,user.getLanguage())+SystemEnv.getHtmlLabelName(258,user.getLanguage())%>
                  </button>            
              </td>
            </tr>
            <%}%>      
              
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
                              <%
                                  if (!nodownload) {
                              %>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>');return false;">[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></span>]</a>
                              </td>
                              <%}%>
                      </tr>
                        </table>
                    </td>
              <%}else{
              %>
              <tr>
                <input type=hidden name="field<%=fieldid%>_del_<%=linknum%>" value="0">
                <td colspan=3>
              <%=imgSrc%>
              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openDocExt('<%=showid%>','<%=versionId%>','<%=docImagefileid%>',0)"><%=docImagefilename%></a>&nbsp

              <%}else{%>
                <a style="cursor:hand" onclick="addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>')"><%=docImagefilename%></a>&nbsp
              <%}%>
              <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>> <!--xwj for td2893 20051017-->
              <%if((!fileExtendName.equalsIgnoreCase("xls")&&!fileExtendName.equalsIgnoreCase("doc")&&!fileExtendName.equalsIgnoreCase("xlsx")&&!fileExtendName.equalsIgnoreCase("docx"))||!nodownload){%>
                <span id = "selectDownload">
                  <button type=button  class=btnFlowd accessKey=1  onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>')">
                    <u><%=linknum%></u>-<%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%>	(<%=docImagefileSize/1000%>K)
                  </button>
					<% 
                    //if(isDownloadAll && AttachmentCounts>1 && (linknum+1)==AttachmentCounts){
                    if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0){
                  %>
                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <button type=button class=btnFlowd accessKey=1  onclick="downloadsBatch('<%=fieldvalue%>','<%=requestid%>')">
                    <%="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(332,user.getLanguage())+SystemEnv.getHtmlLabelName(258,user.getLanguage())%>
                  </button>
                  <%}%> 
                </span>
              <%}%>
              </td>
          </tr>
            <%}}
            if(fieldtype.equals("2")&&linknum>-1){%>
            </tr></table></td></tr>
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
           if(isbill.equals("0")) out.println(Util.null2String((String)specialfield.get(fieldid+"_0")));
           else out.println(Util.null2String((String)specialfield.get(fieldid+"_1")));
       }        
       %>
      </td>
    </tr><tr style="height:1px;"><td class=Line2 colSpan=2></td></tr>

<%
    }else {                              // ����ʾ����Ϊ hidden ������Ϣ
        if (fieldhtmltype.equals("6"))
        {   if (!fieldvalue.equals(""))
            {
            ArrayList fieldvalueas=Util.TokenizerString(fieldvalue,",");
            int linknum=-1;
            for(int j=0;j<fieldvalueas.size();j++){
              linknum++;
              String showid = Util.null2String(""+fieldvalueas.get(j)) ;
              %>
            <input type=hidden name="field<%=fieldid%>_id_<%=linknum%>" value=<%=showid%>>

          <%}%><input type=hidden name="field<%=fieldid%>_idnum" value=<%=linknum+1%>>
          <%
          }
          }

	if (fieldhtmltype.equals("2")&&fieldtype.equals("2")) {%>
	<textarea name="field<%=fieldid%>" style="display:none"><%=fieldvalue%></textarea>
	<%} else {%>
    <input type=hidden name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" >
<%
	}} %>
<%
}       // ѭ������
%>

</table>
<%=initIframeStr%>
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

<input type=hidden name ="method">                                <!--�½��ĵ�ʱ�� method Ϊdocnew-->
<input type=hidden name ="topage" value="<%=topage%>">				<!--���ص�ҳ��-->
<input type=hidden name ="needcheck" value="<%=needcheck%>">
<input type=hidden name ="inputcheck" value="">

<input type=hidden name ="isMultiDoc" value=""><!--���ĵ��½�-->

<input type=hidden name="rand" value="<%=System.currentTimeMillis()%>">
<input type=hidden name="needoutprint" value="">
<iframe name="delzw" width=0 height=0 style="border:none"></iframe>

<script language="javascript">
var maxUploadImageSize = <%=maxUploadImageSize%>;
var uploadImageMaxSize = <%=maxUploadImageSize%>;
var uploaddocCategory="<%=docCategory%>";
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
					euploadspans[j].innerHTML = "(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage())%>"+maxUploadImageSize+"<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage())%>)";
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
<%=bodychangattrstr%>

<%
String isFormSignature=null;
RecordSet.executeSql("select isFormSignature from workflow_flownode where workflowId="+workflowid+" and nodeId="+nodeid);
if(RecordSet.next()){
	isFormSignature = Util.null2String(RecordSet.getString("isFormSignature"));
}
%>
function createDoc(fieldbodyid,docVlaue,isedit)
{
	
	/*
   for(i=0;i<=1;i++){
  		parent.$GetEle("oTDtype_"+i).background="/images/tab2.png";
  		parent.$GetEle("oTDtype_"+i).className="cycleTD";
  	}
  	parent.$GetEle("oTDtype_1").background="/images/tab.active2.png";
  	parent.$GetEle("oTDtype_1").className="cycleTDCurrent";
	*/
  	if("<%=isremark%>"==9||"<%=isremark%>"==5||<%=!editbodyflag%>){
  		$GetEle("frmmain").action = "RequestDocView.jsp?requestid=<%=requestid%>&docValue="+docVlaue;
  	}else{
  	$GetEle("frmmain").action = "RequestOperation.jsp?docView="+isedit+"&docValue="+docVlaue+"&isFromEditDocument=true";
  	}
    $GetEle("frmmain").method.value = "crenew_"+fieldbodyid ;
    $GetEle("frmmain").target="delzw";
    parent.delsave();
	if(check_form($GetEle("frmmain"),'requestname')){
		if($GetEle("needoutprint")) $GetEle("needoutprint").value = "1";//��ʶ������
		$GetEle("src").value='save';
		$GetEle("isremark").value='0';;
//����ǩ������
<%if("1".equals(isFormSignature)){%>
	                    if(SaveSignature()){
                            //�����ϴ�
        StartUploadAll();
        checkuploadcompletBydoc();
                        }else{
							if(isDocEmpty==1){
								alert("\""+"<%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%>"+"\""+"<%=SystemEnv.getHtmlLabelName(21423,user.getLanguage())%>");
								isDocEmpty=0;
							}else{
								alert("<%=SystemEnv.getHtmlLabelName(21442,user.getLanguage())%>");
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

function openDocExt(showid,versionid,docImagefileid,isedit){
	jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
    
	if(isedit==1){
		openFullWindowHaveBar("/docs/docs/DocEditExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>");
	}else{
		openFullWindowHaveBar("/docs/docs/DocDspExt.jsp?id="+showid+"&imagefileId="+docImagefileid+"&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>");
	}
}

function openAccessory(fileId){ 
	jQuery($GetEle("flowbody")).attr("onbeforeunload", "");
	openFullWindowHaveBar("/weaver/weaver.file.FileDownload?fileid="+fileId+"&requestid=<%=requestid%>");
}

function onNewDoc(fieldid) {
    $GetEle("frmmain").action = "RequestOperation.jsp" ;
    $GetEle("frmmain").method.value = "docnew_"+fieldid ;
    $GetEle("isMultiDoc").value = fieldid ;
    $GetEle("src").value='save';
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


function checktimeok(){         <!-- �������ڲ���С�ڿ�ʼ���� -->
    if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && $GetEle("<%=newenddate%>").value != "")
    {
        YearFrom=$GetEle("<%=newfromdate%>").value.substring(0,4);
        MonthFrom=$GetEle("<%=newfromdate%>").value.substring(5,7);
        DayFrom=$GetEle("<%=newfromdate%>").value.substring(8,10);
        YearTo=$GetEle("<%=newenddate%>").value.substring(0,4);
        MonthTo=$GetEle("<%=newenddate%>").value.substring(5,7);
        DayTo=$GetEle("<%=newenddate%>").value.substring(8,10);
        if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
            window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
            return false;
        }
    }
    return true;
}
 
function datainput(parfield){                <!--���ݵ���-->
      //var xmlhttp=XmlHttp.create();
      var detailsum="0";
      try{
          detailsum=$GetEle("detailsum").value;
      }catch(e){ detailsum="0";}
      var StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum="+detailsum+"&trg="+parfield;
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
      $GetEle("datainputform").src="DataInputFrom.jsp?"+StrData;
  }
function getWFLinknum(wffiledname){
    if($GetEle(wffiledname) != null){
        return $GetEle(wffiledname).value;
    }else{
        return 0;
    }
}

function changeKeyword(){
<%
	if(titleFieldId>0&&keywordFieldId>0){
%>
	    var titleObj=$GetEle("field<%=titleFieldId%>");
	    var keywordObj=$GetEle("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $GetEle("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value+"&docKeyword="+keywordObj.value;
	    }
<%
    }else if(titleFieldId==-3&&keywordFieldId>0){
%>
	    var titleObj=$GetEle("requestname");
	    var keywordObj=$GetEle("field<%=keywordFieldId%>");

        if(titleObj!=null&&keywordObj!=null){

		    $GetEle("workflowKeywordIframe").src="/docs/sendDoc/WorkflowKeywordIframe.jsp?operation=UpdateKeywordData&docTitle="+titleObj.value+"&docKeyword="+keywordObj.value;
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
//** iframe�Զ���Ӧҳ�� **//

    function dyniframesize()
    {
    var dyniframe;
    <%
    for (int i=0; i<managefckfields_billbody.size(); i++)
    {%>
    if (document.getElementById)
    {
        //�Զ�����iframe�߶�
        dyniframe = $GetEle("<%=managefckfields_billbody.get(i)%>");
        if (dyniframe && !window.opera)
        {
            if (dyniframe.contentDocument && dyniframe.contentDocument.body.offsetHeight){ //����û����������NetScape
                dyniframe.height = dyniframe.contentDocument.body.offsetHeight+20;
            }else if (dyniframe.Document && dyniframe.Document.body.scrollHeight){ //����û����������IE
                //alert(dyniframe.name+"|"+dyniframe.Document.body.scrollHeight);
                dyniframe.Document.body.bgColor="transparent";
                dyniframe.height = dyniframe.Document.body.scrollHeight+20;
            }
        }
    }
    <%}%>
    <%if(fieldids.size()<1){%>
    alert("<%=SystemEnv.getHtmlLabelName(22577,user.getLanguage())%>");
    <%}%>    
    }
    if (window.addEventListener)
    window.addEventListener("load", dyniframesize, false);
    else if (window.attachEvent)
    window.attachEvent("onload", dyniframesize);
    else
    window.onload=dyniframesize;

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
    				$GetEle("iframe_"+pFieldid+"_"+fieldid+"_00").src = "SelectChange.jsp?"+paraStr;
    			}
    		}
    	}catch(e){}
    }
    <%=selectInitJsStr%>
</script>

<script type="text/javascript">
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
		        	tmpids=uescape("?isdetail=1&isbill=<%=isbill%>&fieldid="& Mid(id,1,index-1)&"&resourceids="&$GetEle("field"+id).value+"&selectedids="+$GetEle("field"+id).value);
		        	id1 = window.showModalDialog(url + tmpids, "", "dialogWidth=550px;dialogHeight=550px");
		        } else {
		        	tmpids = uescape("?fieldid=" + id + "&isbill=<%=isbill%>&resourceids=" + $GetEle("field" + id).value+"&selectedids="+$GetEle("field"+id).value);
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

						if (type1 == 171 || type1 == 152) {
	                        linkno = getWFLinknum("slink" + id + "_rq" + curid);
	                        if (linkno>0) {
	                        	curid = curid + "&wflinkno=" + linkno;
							} else {
	                        	tlinkurl = linkurl.substring(0, linkurl.indexOf("?") + 1) + "requestid="
							}
						}
						
						if (tlinkurl == "/hrm/resource/HrmResource.jsp?id=") {
							sHtml += "<a href=javaScript:openhrm(" + curid + "); onclick='pointerXY(event);'>" + curname + "</a>&nbsp";
						} else {
							sHtml += "<a href=" + tlinkurl + curid + " target=_new>" + curname + "</a>&nbsp";
						}
					}
					
					$GetEle("field"+id+"span").innerHTML = sHtml;
					$GetEle("field"+id).value= resourceids;
				} else {
 					if (ismand == 0) {
 						if(type1 == 17 || type1 == 165 || type1 == 166) {
							$GetEle("field" + id + "span").value = "";
							$GetEle("field" + id + "name").value = "";
 						} else {
 							$GetEle("field"+id+"span").innerHTML = "";
 						}
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
						var href = wuiUtil.getJsonValueByIndex(id1, 3);
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
							//sHtml += "<a title='" + curdesc + "' >" + curname + "</a>&nbsp";
							if(href==''){
								sHtml += "<a title='" + curdesc + "' >" + curname + "</a>&nbsp";
							}else{
								sHtml += "<a title='" + curdesc + "' href='" + href + curid + "' target='_blank'>" + curname + "</a>&nbsp";
							}
						}
						
						$GetEle("field" + id + "span").innerHTML = sHtml;
						return;
	               }
				   if (type1 == 161) {
					   	var ids = wuiUtil.getJsonValueByIndex(id1, 0);
					   	var names = wuiUtil.getJsonValueByIndex(id1, 1);
						var descs = wuiUtil.getJsonValueByIndex(id1, 2);
						var href = wuiUtil.getJsonValueByIndex(id1, 3);
						$GetEle("field"+id).value = ids;
						//sHtml = "<a title='" + descs + "'>" + names + "</a>&nbsp";
						if(href==''){
							sHtml = "<a title='" + descs + "'>" + names + "</a>&nbsp";
						}else{
							sHtml = "<a title='" + descs + "' href='" + href + ids + "' target='_blank'>" + names + "</a>&nbsp";
						}
						$GetEle("field" + id + "span").innerHTML = sHtml;
						return ;
				   }

				   if (type1 == 16) {
					   curid = wuiUtil.getJsonValueByIndex(id1, 0);
                   	   linkno = getWFLinknum("slink" + id + "_rq" + curid);
	                   if (linkno>0) {
	                       curid = curid + "&wflinkno=" + linkno;
	                   } else {
	                       linkurl = linkurl.substring(0, linkurl.indexOf("?") + 1) + "requestid=";
	                   }
	                   $GetEle("field"+id).value = wuiUtil.getJsonValueByIndex(id1, 0);
					   if (linkurl == "/hrm/resource/HrmResource.jsp?id=") {
						   $GetEle("field"+id+"span").innerHTML = "<a href=javaScript:openhrm(" + curid + "); onclick='pointerXY(e);'>" + wuiUtil.getJsonValueByIndex(id1, 1)+ "</a>&nbsp";
					   } else {
	                       $GetEle("field"+id+"span").innerHTML = "<a href=" + linkurl + curid + " target='_new'>" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a>";
					   }
	                   return;
				   }
				   
	               if (type1 == 9 && "<%=docFlags%>" == "1" && "<%=flowDocField%>" == inputname) {
		                tempid = wuiUtil.getJsonValueByIndex(id1, 0);
		                $GetEle("field" + id + "span").innerHTML = "<a href='#' onclick=\"createDoc(" + id + ", " + tempid + ", 1)\">" + wuiUtil.getJsonValueByIndex(id1, 1) + "</a><button type=\"button\" id=\"createdoc\" style=\"display:none\" class=\"AddDocFlow\" onclick=\"createDoc(" + id + ", " + tempid + ",1)\"></button>";
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
	                if (type1 == 9 && "<%=docFlags%>" == "1" && "<%=flowDocField%>" == inputname) {
	                	//$GetEle("CreateNewDoc").innerHTML="";
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
					if (type1 == 9 && "<%=docFlags%>" == "1" && "<%=flowDocField%>" == inputname) {
						var evt = getEvent();
	               		var targetElement = evt.srcElement ? evt.srcElement : evt.target;
	               		jQuery(targetElement).next("span[id=CreateNewDoc]").html("<button type=button id='createdoc' class=AddDocFlow onclick=createDoc(" + id + ",'','1') title='<%=SystemEnv.getHtmlLabelName(82, user.getLanguage())%>'><%=SystemEnv.getHtmlLabelName(82, user.getLanguage())%></button>");
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
</script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<script type="text/javascript" src="/js/selectDateTime.js"></script>