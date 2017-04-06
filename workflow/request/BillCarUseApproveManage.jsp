<%@ page import="weaver.workflow.request.RequestConstants" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>

<form name="frmmain" method="post" action="RequestOperation.jsp" enctype="multipart/form-data">
<input type="hidden" name="needwfback" id="needwfback" value="1" />
<input type="hidden" name="lastOperator"  id="lastOperator" value="<%=lastOperator%>"/>
<input type="hidden" name="lastOperateDate"  id="lastOperateDate" value="<%=lastOperateDate%>"/>
<input type="hidden" name="lastOperateTime"  id="lastOperateTime" value="<%=lastOperateTime%>"/>

<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for @td2977 20051111-->
<jsp:useBean id="rsaddop" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DocUtil" class="weaver.docs.docs.DocUtil" scope="page" /><%----- xwj for td3323 20051209  ------%>
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="scci" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page"/>
<jsp:useBean id="WfLinkageInfo" class="weaver.workflow.workflow.WfLinkageInfo" scope="page"/>
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="ProjectInfoComInfo1" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="DocComInfo1" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo1" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo1" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo1" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DocReceiveUnitComInfo" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<jsp:useBean id="docReceiveUnitComInfo_mba" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</DIV>
<!--����ı������ -->
<iframe id="datainputform" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<BR>
<%----- xwj for td3323 20051209 begin ------%>
<%
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
%>
<script language=javascript>
function accesoryChanage(obj){
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        var oFile=document.getElementById("oFile");
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
  <TR class="Spacing">
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
        <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=60  maxlength=100  value = "<%=Util.toScreenToEdit(requestname,user.getLanguage())%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,user.getLanguage()))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%}%>
     
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
     
     
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
          <tr><td class=Line2 colSpan=2></td></tr>
        <%}%>
      </TD>
  </TR>  	   	<TR >
    <TD class="Line1" colSpan=2></TD>
  </TR>
  <!--��һ�н��� -->
  <%
  if(formid==163){%>
  <TR>
  	<TD><%=SystemEnv.getHtmlLabelName(19018,user.getLanguage())%></TD>
  	<TD class=field><a href="/car/CarUseInfo.jsp" target="_blank"><%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%></a></TD>
  </TR>
  <TR><TD class=Line2 colSpan=2></TD></TR>
  <%}%>
<%
String docFlags=Util.null2String((String)session.getAttribute("requestAdd"+requestid));
if (docFlags.equals("")) docFlags=Util.null2String((String)session.getAttribute("requestAdd"+user.getUID()));

HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
ArrayList selfieldsadd=WfLinkageInfo.getSelectField(workflowid,nodeid,0);
ArrayList changefieldsadd=WfLinkageInfo.getChangeField(workflowid,nodeid,0);

//��ѯ�����ߵ��ݵ��ֶ�,�ֶε����ƣ��ֶε�HTML���ͺ��ֶε����ͣ�����HTML���͵�һ����չ��

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
ArrayList fieldrealtype=new ArrayList();
String fielddbtype="";                              //�ֶ���������

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
        fieldrealtype.add(Util.null2String(RecordSet.getString("fielddbtype")));
        
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
        fieldvalues.add(Util.null2String(RecordSet.getString(fieldname)));
    }
}

// ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
ArrayList isfieldids=new ArrayList();              //�ֶζ���
ArrayList isviews=new ArrayList();              //�ֶ��Ƿ���ʾ����
ArrayList isedits=new ArrayList();              //�ֶ��Ƿ���Ա༭����
ArrayList ismands=new ArrayList();              //�ֶ��Ƿ�����������

String newfromtime="";
String newendtime="";

RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
while(RecordSet.next()){
    isfieldids.add(Util.null2String(RecordSet.getString("fieldid")));
    isviews.add(Util.null2String(RecordSet.getString("isview")));
    isedits.add(Util.null2String(RecordSet.getString("isedit")));
    ismands.add(Util.null2String(RecordSet.getString("ismandatory")));
}

String beagenter=""+userid;
//��ñ�������
RecordSet.executeSql("select agentorbyagentid from workflow_currentoperator where usertype=0 and isremark='0' and requestid="+requestid+" and userid="+userid+" and nodeid="+nodeid+" order by id desc");
if(RecordSet.next()){
  int tembeagenter=RecordSet.getInt(1);
  if(tembeagenter>0) beagenter=""+tembeagenter;
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
		fielddbtype=FieldComInfo.getFielddbtype(fieldid);
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
		fielddbtype=(String)fieldrealtype.get(tmpindex);
    }

    String fieldvalue=(String)fieldvalues.get(tmpindex);

    if(fieldname.equals("manager")) {
	    String tmpmanagerid = ResourceComInfo.getManagerID(""+beagenter);
%>
	<input type=hidden name="field<%=fieldid%>" value="<%=tmpmanagerid%>">
<%
        if(isview.equals("1")){
%> <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%> </td>
      <td class=field><%=ResourceComInfo.getLastname(tmpmanagerid)%></td>
   </tr><tr><td class=Line2 colSpan=2></td></tr>
<%
        }
	    continue;
	}
	if(fieldname.equalsIgnoreCase("startDate")) newfromdate="field"+fieldid; //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if(fieldname.equalsIgnoreCase("endDate")) newenddate="field"+fieldid;   //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
    if(fieldname.equalsIgnoreCase("startTime")) newfromtime="field"+fieldid; //��ʼʱ��
	if(fieldname.equalsIgnoreCase("endTime")) newendtime="field"+fieldid;	//����ʱ��
	
	if(fieldhtmltype.equals("3") && fieldvalue.equals("0")) fieldvalue = "" ;
    if(fieldhtmltype.equals("1") && (fieldtype.equals("2") || fieldtype.equals("3")) && Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue = "" ;

    if(ismand.equals("1"))  needcheck+=",field"+fieldid;   //�����������,�����������ļ����

    // ���濪ʼ������ʾ�ֶ�

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
        <input datatype="text" viewtype="<%=ismand%>" type=text class=Inputstyle name="field<%=fieldid%>" size=50 value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%

				    }else{%>
        <input datatype="text" viewtype="<%=ismand%>" type=text class=Inputstyle name="field<%=fieldid%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}else{%> onchange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}%> value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" size=50>
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
        <input datatype="int" type=text viewtype="<%=ismand%>" class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" 
		onKeyPress="ItemCount_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span');datainput('field<%=fieldid%>')" <%}else{%> onBlur="checkcount1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%

				    }else{%>
        <input datatype="int" type=text viewtype="<%=ismand%>" class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checkcount1(this);datainput('field<%=fieldid%>');checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}else{%> onBlur="checkcount1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}%>>
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
        <input datatype="float" type=text class=Inputstyle viewtype="<%=ismand%>" name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>"	
       onKeyPress="ItemNum_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span');datainput('field<%=fieldid%>')" <%}else{%> onBlur="checknumber1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')" <%}%>>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
    				}else{%>
        <input datatype="float" type=text viewtype="<%=ismand%>" class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemNum_KeyPress()" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>  onBlur="checknumber1(this);datainput('field<%=fieldid%>');checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}else{%> onBlur="checknumber1(this);checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}%>>
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
                                checkinput('field_lable<%=fieldid%>','field_lable<%=fieldid%>span');
                                datainput('field_lable<%=fieldid%>')" 
                            <%}else{%>
                                onBlur="numberToFormat('<%=fieldid%>');
                                checkinput('field_lable<%=fieldid%>','field_lable<%=fieldid%>span')" 
                            <%}%>
                        >
                    <span id="field_lable<%=fieldid%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                    <%}else{%>
                        <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>" size=60  
                            onKeyPress="ItemNum_KeyPress('field_lable<%=fieldid%>')" 
                            onfocus="FormatToNumber('<%=fieldid%>')" 
                            <%if(trrigerfield.indexOf("field"+fieldid)>=0){%>
                                onBlur="numberToFormat('<%=fieldid%>');
                                datainput('field_lable<%=fieldid%>')" 
                            <%}else{%> 
                                onBlur="numberToFormat('<%=fieldid%>')" 
                            <%}%> 
                        >
                    <%}%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
                <%}else{%>
                    <span id="field<%=fieldid%>span"></span>
                    <input datatype="float" type=text class=Inputstyle name="field_lable<%=fieldid%>"  disabled="true" size=60>
                    <input datatype="float" type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
                <%}%>
                </td></tr>
                <tr><td>
                    <input type=text class=Inputstyle size=60 name="field_chinglish<%=fieldid%>" readOnly="true">
                </td></tr>
                <script language="javascript">
                    document.all("field_lable"+<%=fieldid%>).value  = milfloatFormat(floatFormat(<%=fieldvalue%>));
                    document.all("field_chinglish"+<%=fieldid%>).value = numberChangeToChinese(<%=fieldvalue%>);
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
			    if(ismand.equals("1")) {
       %>
        <textarea class=Inputstyle viewtype="<%=ismand%>" name="field<%=fieldid%>"  <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');" <%}%> onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')"
		rows="<%=textheight%>" cols="40" style="width:80%" ><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
			    }else{
       %>
        <textarea class=Inputstyle viewtype="<%=ismand%>" name="field<%=fieldid%>" rows="<%=textheight%>" cols="40" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onBlur="datainput('field<%=fieldid%>');checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}else{%> onchange="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));" <%}%> style="width:80%"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea><!--xwj for @td2977 20051111-->
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
            String hiddenlinkvalue=""; 
            
             String tablename=""; //������Ӧ�ı�,����������Դ��
             String columname=""; //������Ӧ�ı������ֶ�
             String keycolumname="";   //������Ӧ�ı�ֵ�ֶ�
            // ����Ƕ��ĵ�, ��Ҫ�ж��Ƿ����¼�����ĵ�,�����,��Ҫ����ԭ���ĺ���
            if( (fieldtype.equals("37")||(fieldtype.equals("9")&&docFlags.equals("1"))) && fieldid.equals(docfileid) && !newdocid.equals("")) {
                if( ! fieldvalue.equals("") ) fieldvalue += "," ;
               if (fieldtype.equals("9")&&docFlags.equals("1"))
               fieldvalue=newdocid ;
               else
               fieldvalue += newdocid ;
            }
            
           

            if(fieldtype.equals("2") ||fieldtype.equals("19")  )	showname=fieldvalue; // ����ʱ��
            else if(!fieldvalue.equals("")) {
                ArrayList tempshowidlist=Util.TokenizerString(fieldvalue,",");
                if(fieldtype.equals("8") || fieldtype.equals("135")){
                    //��Ŀ������Ŀ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("1") ||fieldtype.equals("17")||fieldtype.equals("165")||fieldtype.equals("166")){
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
                }
				else if(fieldtype.equals("160")){
                    //��ɫ��Ա
                    for(int k=0;k<tempshowidlist.size();k++){
                       if(!linkurl.equals(""))
                       {
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
                }else if(fieldtype.equals("142")){
                    //�շ��ĵ�λ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+docReceiveUnitComInfo_mba.getReceiveUnitName((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=docReceiveUnitComInfo_mba.getReceiveUnitName((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }
				else if(fieldtype.equals("7") || fieldtype.equals("18")){
                    //�ͻ�����ͻ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("4") || fieldtype.equals("57")|| fieldtype.equals("167")|| fieldtype.equals("168")){
                    //���ţ��ಿ��
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DepartmentComInfo1.getDepartmentname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=DepartmentComInfo1.getDepartmentname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("9") || fieldtype.equals("37")){
                    //�ĵ������ĵ�
                    for(int k=0;k<tempshowidlist.size();k++){

                          if (fieldtype.equals("9")&&docFlags.equals("1"))
                        {
                        //linkurl="WorkflowEditDoc.jsp?docId=";//????
                       String tempDoc=""+tempshowidlist.get(k);
                       String tempDocView="0";
					   if(isedit.equals("1")){
						   tempDocView="1";
					   }
                       showname+="<a href='javascript:createDoc("+fieldid+","+tempDoc+","+tempDocView+")' >"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp<button id='createdoc' style='display:none' class=AddDocFlow onclick=createDoc("+fieldid+","+tempDoc+","+tempDocView+")></button>";

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
                }else if(fieldtype.equals("23")){
                    //�ʲ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+" ";
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
                }
//add by fanggsh for TD4528   20060621 begin
                else if(fieldtype.equals("141")){
                    //������Դ����
					showname+=ResourceConditionManager.getFormShowName(fieldvalue,languageid);
                }
//add by fanggsh for TD4528   20060621 end
				//added by alan for td:10814
				else if(fieldtype.equals("142")) {
					//�շ��ĵ�λ
					 for(int k=0;k<tempshowidlist.size();k++){
						 if(!linkurl.equals("")){
							 showname += "<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DocReceiveUnitComInfo.getReceiveUnitName(""+tempshowidlist.get(k))+"</a>&nbsp";
	                        }else{
	                            showname += DocReceiveUnitComInfo.getReceiveUnitName(""+tempshowidlist.get(k))+" ";
	                        }
					 }
				}
                //end by alan for td:10814
                else if(fieldtype.equals("161")){//�Զ��嵥ѡ
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
                } else{
	                tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
	                columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
	                keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                    if(fieldvalue.indexOf(",")!=-1){
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }

                    RecordSet.executeSql(sql);
                    while(RecordSet.next()){
                        showid = Util.null2String(RecordSet.getString(1)) ;
                        String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                        if(!linkurl.equals("")){
                             showname += "<a href='"+linkurl+showid+"' target='_new'>"+tempshowname+"</a>&nbsp";
                        }else{
                            showname +=tempshowname+" ";
                        }
                    }
                }
            }
            //add by dongping
            //����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
            if (fieldtype.equals("118")) {
            	showname ="<a href=/meeting/report/MeetingRoomPlan.jsp target=blank>"+SystemEnv.getHtmlLabelName(2193,user.getLanguage())+"</a>" ;
             }
            if(isedit.equals("1") && isremark==0 ){
                if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
				String roleid="";
				if (fieldtype.equals("160")){
					rsaddop.execute("select a.level_n, a.level2_n from workflow_groupdetail a ,workflow_nodegroup b where a.groupid=b.id and a.type=50 and a.objid="+fieldid+" and b.nodeid in (select nodeid from workflow_flownode where workflowid="+workflowid+" ) ");
	  				int rolelevel_tmp = 0;
	  				if (rsaddop.next())
	  				{
	  				roleid=rsaddop.getString(1);
	  				rolelevel_tmp=Util.getIntValue(rsaddop.getString(2), 0);
	  				roleid += "a"+rolelevel_tmp;
	  				}
					url = url + roleid + "_" + fieldvalue;
				}
	   %>
        <button class=Browser viewtype="<%=ismand%>" <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',this.getAttribute('viewtype'));"<%}else{%> onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>',field<%=fieldid%>.getAttribute('viewtype'));"<%}%> title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
       <%       } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button class=AddDoc onclick="onShowBrowser2('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp;<button class=AddDoc onclick="onNewDoc(<%=fieldid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
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
        </span> <input type=hidden viewtype="<%=ismand%>" name="field<%=fieldid%>" value="<%=fieldvalue%>">
       <%
       if(changefieldsadd.indexOf(fieldid)>=0){
%>
    <input type=hidden name="oldfieldview<%=fieldid%>" value="<%=Util.getIntValue(isview,0)+Util.getIntValue(isedit,0)+Util.getIntValue(ismand,0)%>" />
<%
    }
	    }                                                       // �����ť��������
	    else if(fieldhtmltype.equals("4")) {                    // check��
	   %>
        <input type=checkbox value=1 name="field<%=fieldid%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0){%> onChange="datainput('field<%=fieldid%>');" <%}%> <%if(fieldvalue.equals("1")){%> checked <%}%> >
        <%if(isedit.equals("0") || isremark==1 ){%>
        <input type=hidden class=Inputstyle name="field<%=fieldid%>" value="<%=fieldvalue%>" >
        <%}%>       
       <%
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
	   %>
        <script>
        	function funcField<%=fieldid%>(){
        	    changeshowattr('<%=fieldid%>_0',document.getElementById('field<%=fieldid%>').value,-1,'<%=workflowid%>','<%=nodeid%>');
        	}
        	window.attachEvent("onload", funcField<%=fieldid%>);
        </script>
        <select class=inputstyle viewtype="<%=ismand%>" name="field<%=fieldid%>" <%if(isedit.equals("1")){%>onBlur="checkinput2('field<%=fieldid%>','field<%=fieldid%>span',this.getAttribute('viewtype'));"<%}%> <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> <%if(trrigerfield.indexOf("field"+fieldid)>=0&&selfieldsadd.indexOf(fieldid)>=0){%> onChange="datainput('field<%=fieldid%>');changeshowattr('<%=fieldid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);" <%}else if(selfieldsadd.indexOf(fieldid)>=0){%> onchange="changeshowattr('<%=fieldid%>_0',this.value,-1,<%=workflowid%>,<%=nodeid%>);" <%}else if(trrigerfield.indexOf("field"+fieldid)>=0){%> onchange="datainput('field<%=fieldid%>');" <%}%>><!--added by xwj for td3313 20051206 -->
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
              linknum++;
                isfrist=false;
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
              boolean isLocked=scci.isDefaultLockedDoc(Integer.parseInt(showid));
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
                              <%
                                  if (!isLocked) {
                              %>
                              <td align="center"><nobr>
                                  <a href="#" style="text-decoration:underline" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');downloads('<%=docImagefileid%>');return false;">[<span style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></span>]</a>
                              </td>
                              <%}%>
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
                <BUTTON class=btn accessKey=1  onclick='onChangeSharetype("span<%=fieldid%>_id_<%=linknum%>","field<%=fieldid%>_del_<%=linknum%>","<%=ismand%>",oUpload<%=fieldid%>)'><U><%=linknum%></U>-ɾ��
                  <span id="span<%=fieldid%>_id_<%=linknum%>" name="span<%=fieldid%>_id_<%=linknum%>" style="visibility:hidden">
                    <B><FONT COLOR="#FF0033">��</FONT></B>
                  <span>
                </BUTTON>
            </td>
            <%if(accessoryCount==1){%>
            <td >
              <span id = "selectDownload">
                <%
                  if(!isLocked){
                %>
                  <BUTTON class=btn accessKey=1  onclick="downloads('<%=docImagefileid%>')">
                    <U><%=linknum%></U>-����	  (<%=docImagefileSize/1000%>K)
                  </BUTTON>
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
        	window.attachEvent("onload", fileupload<%=fieldid%>);
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
                  <BUTTON class=btn accessKey=1  onclick="downloads('<%=docImagefileid%>')">
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
        }else if(fieldhtmltype.equals("7")){
     	   out.println(Util.null2String((String)specialfield.get(fieldid+"_1")));
        }     // ѡ����������� ���������ж�����
       %>
      </td>
    </tr><TR><TD class=Line2 colSpan=2></TD></TR>

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
<input type=hidden name ="method">                                <!--�½��ĵ�ʱ�� method Ϊdocnew-->
<input type=hidden name ="topage" value="<%=topage%>">				<!--���ص�ҳ��-->
<input type=hidden name ="needcheck" value="<%=needcheck%>">
<input type=hidden name ="inputcheck" value="">

<script language="javascript">

function onNewDoc(fieldid) {
    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldid ;
    document.frmmain.src.value='save';
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
    if ("<%=newenddate%>"!="b" && "<%=newfromdate%>"!="a" && document.frmmain.<%=newenddate%>.value != "")
    {
        YearFrom=document.frmmain.<%=newfromdate%>.value.substring(0,4);
        MonthFrom=document.frmmain.<%=newfromdate%>.value.substring(5,7);
        DayFrom=document.frmmain.<%=newfromdate%>.value.substring(8,10);
        YearTo=document.frmmain.<%=newenddate%>.value.substring(0,4);
        MonthTo=document.frmmain.<%=newenddate%>.value.substring(5,7);
        DayTo=document.frmmain.<%=newenddate%>.value.substring(8,10);
        if (!DateCompare(YearFrom, MonthFrom, DayFrom,YearTo, MonthTo,DayTo )){
            window.alert("<%=SystemEnv.getHtmlLabelName(15273,user.getLanguage())%>");
            return false;
        }else{
                if(document.frmmain.<%=newenddate%>.value==document.frmmain.<%=newfromdate%>.value && document.frmmain.<%=newendtime%>.value<document.frmmain.<%=newfromtime%>.value){
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
          StrData+="&<%=temp%>="+document.all("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
          for(int i=0;i<Lcondetionfieldname.size();i++){
              String temp=(String)Lcondetionfieldname.get(i);
      %>
          StrData+="&<%=temp%>="+document.all("<%=temp.substring(temp.indexOf("|")+1)%>").value;
      <%
          }
      %>
      //alert(StrData);
      document.all("datainputform").src="DataInputFrom.jsp?"+StrData;
      //xmlhttp.open("POST", "DataInputFrom.jsp", false); 
      //xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
      //xmlhttp.send(StrData);
  }
  function addannexRow(accname)
  {
    document.all(accname+'_num').value=parseInt(document.all(accname+'_num').value)+1;
    ncol = document.all(accname+'_tab').cols;
    oRow = document.all(accname+'_tab').insertRow(-1);
    for(j=0; j<ncol; j++) {
      oCell = oRow.insertCell(-1); 

      switch(j) {
        case 0:
          var oDiv = document.createElement("div");
          <%----- Modified by xwj for td3323 20051209  ------%>
          var sHtml = "<input class=InputStyle  type=file size=50 name='"+accname+"_"+document.all(accname+'_num').value+"' onchange='accesoryChanage(this)'> (��Ŀ¼�����ֻ���ϴ�<%=maxUploadImageSize%>M/���ĸ���) ";
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

	<%@ include file="/workflow/request/WorkflowManageSign.jsp" %>
</form>