<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<jsp:useBean id="CoworkDAO" class="weaver.cowork.CoworkDAO" scope="page"/>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="weaver.general.AttachFileUtil" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.workflow.request.RequestConstants" %>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="SecCategoryComInfo1" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="ProjectInfoComInfo1" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="DocComInfo1" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo1" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo1" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<jsp:useBean id="DocReceiveUnitComInfo" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="docReceiveUnitComInfo_vba" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<jsp:useBean id="WFNodeFieldMainManager" class="weaver.workflow.workflow.WFNodeFieldMainManager" scope="page" />
<jsp:useBean id="workflowJspBean" class="weaver.workflow.request.WorkflowJspBean" scope="page"/>
<%
HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
int userid=Util.getIntValue(request.getParameter("userid"),0);
int workflowid = Util.getIntValue(request.getParameter("workflowid"));
int requestid=Util.getIntValue(request.getParameter("requestid"),0);
//String workflowname = Util.null2String(request.getParameter("workflowname"));//update by fanggsh 20060509 TD4294
String workflowname = Util.null2String((String)session.getAttribute(userid+"_"+requestid+"workflowname"));//update by fanggsh 20060509 TD4294
String  fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //�Ƿ�����̴����ĵ�����
int languageidfromrequest = Util.getIntValue(request.getParameter("languageid"));

boolean canactive = Util.null2String(request.getParameter("canactive")).equalsIgnoreCase("true") ;  
int deleted = Util.getIntValue(request.getParameter("deleted"),0) ;  //�����Ƿ�ɾ��  1:�� 0�������� ��
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0) ;  

String docFlags=Util.null2String((String)session.getAttribute("requestAdd"+requestid));
//String requestname = Util.null2String(request.getParameter("requestname"));//update by fanggsh 20060509 TD4294
String requestname = Util.null2String((String)session.getAttribute(userid+"_"+requestid+"requestname"));//update by fanggsh 20060509 TD4294
String requestlevel = Util.null2String(request.getParameter("requestlevel"));

String isbill = Util.null2String(request.getParameter("isbill"));
int billid=Util.getIntValue(request.getParameter("billid"),0);

int formid=Util.getIntValue(request.getParameter("formid"),0);

boolean isprint = Util.null2String(request.getParameter("isprint")).equalsIgnoreCase("true") ;  
boolean isurger = Util.null2String(request.getParameter("isurger")).equalsIgnoreCase("true") ;
boolean wfmonitor = Util.null2String(request.getParameter("wfmonitor")).equalsIgnoreCase("true") ;
String isrequest = Util.null2String(request.getParameter("isrequest"));
int intervenorright=Util.getIntValue(request.getParameter("intervenorright"),0);
int desrequestid = Util.getIntValue(request.getParameter("desrequestid"),0);//������ID
String sql = "" ;
ArrayList htmlfckfield_body=new ArrayList();

String logintype = Util.null2String(request.getParameter("logintype"));

char flag = Util.getSeparator() ;

String nodetype = Util.null2String(request.getParameter("nodetype"));
%>

<DIV>
<%if(canactive&&deleted==1){%>
<button type=button  class=btnFlow accessKey=A type=submit><U>A</U>-<%=SystemEnv.getHtmlLabelName(737,languageidfromrequest)%></button>
<%}%>
</DIV>
<%if(!isprint){%>
<BR>
<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,languageidfromrequest)%></font>
</DIV>
<!--����ı������ -->
<title><%=Util.toScreen(workflowname,languageidfromrequest)%></title>
<%}%>
<%if (isprint) {%>
<BR>
<!--��ӡ��ʱ����ʾ����ı���  ��ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,languageidfromrequest)%></font>
</DIV>
<!--��ӡ��ʱ����ʾ����ı���  ���� -->
<%}%>
<BR>
<TABLE class="ViewForm">
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">
  <%//xwj for td1834 on 2005-05-22
    String isEdit_ = "-1";
    RecordSet.executeSql("select isedit from workflow_nodeform where nodeid = " + String.valueOf(nodeid) + " and fieldid = -1");
    if(RecordSet.next()){
    isEdit_ = "-1";
    }
   
  %>

  <!--�½��ĵ�һ�У�����˵������Ҫ�� -->
  <TR class=spacing style="height:1px;">
    <TD class=line1 colSpan=2></TD>
  </TR>
  <TR>
    <TD>
     <%=SystemEnv.getHtmlLabelName(21192,languageidfromrequest)%>
    </TD>
    <TD class=field>
       
         <%if(!"1".equals(isEdit_)){//xwj for td1834 on 2005-05-22%>
       <%=Util.toScreenToEdit(requestname,languageidfromrequest)%>
       <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,languageidfromrequest)%>">
       <%}
       else{%>
        <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit(requestname,languageidfromrequest)%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,languageidfromrequest))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%}%>
    
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,languageidfromrequest)%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,languageidfromrequest)%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,languageidfromrequest)%> <%}%>
     
     
    </TD>
  </TR>
    <TR style="height:1px;"><TD class=Line2 colSpan=2></TD></TR>
    	<%
    	int rqMessageType=-1;
    	int wfMessageType=-1;
			String sqlWfMessage = "select a.messagetype,b.docCategory,b.messagetype as wfMessageType from workflow_requestbase a,workflow_base b where a.workflowid=b.id and a.requestid="+requestid ;
			RecordSet.executeSql(sqlWfMessage);
			if (RecordSet.next()) {
				wfMessageType=RecordSet.getInt("wfMessageType");
				rqMessageType=RecordSet.getInt("messagetype");
			}
    
			//WFNodeFieldMainManager.resetParameter();
			//WFNodeFieldMainManager.setNodeid(nodeid);
			//WFNodeFieldMainManager.setFieldid(-3);//"�Ƿ��������"�ֶ���workflow_nodeform�е�fieldid ��Ϊ "-3"
			//WFNodeFieldMainManager.selectWfNodeField();
			//if(WFNodeFieldMainManager.getIsview().equals("1")){
			if(wfMessageType==1){
			%>
			<TR>
				<TD > <%=SystemEnv.getHtmlLabelName(17586,languageidfromrequest)%></TD>
				<td class=field>
					<%if(rqMessageType==0){%><%=SystemEnv.getHtmlLabelName(17583,languageidfromrequest)%><%}%>
		    	<%if(rqMessageType==1){%><%=SystemEnv.getHtmlLabelName(17584,languageidfromrequest)%><%}%>
		    	<%if(rqMessageType==2){%><%=SystemEnv.getHtmlLabelName(17585,languageidfromrequest)%><%}%>
		    </td>
	    </TR>
    	<TR style="height:1px;"><TD class=Line2 colSpan=2></TD></TR>
     	<%}
     	//}%>
  <!--��һ�н��� -->

<%

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
ArrayList fielddbtypes=new ArrayList();       //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)
ArrayList fieldimgwidths=new ArrayList();
ArrayList fieldimgheights=new ArrayList();
ArrayList fieldimgnums=new ArrayList();

String forbidAttDownload="";
RecordSet.execute("select forbidAttDownload from workflow_base where id="+workflowid);
if(RecordSet.next()){
   forbidAttDownload = Util.null2String(RecordSet.getString("forbidAttDownload"));
}

if(isbill.equals("0")) {
    RecordSet.executeSql("select t2.fieldid,t2.fieldorder,t1.fieldlable,t1.langurageid from workflow_fieldlable t1,workflow_formfield t2 where t1.formid=t2.formid and t1.fieldid=t2.fieldid and (t2.isdetail<>'1' or t2.isdetail is null) and   t1.langurageid="+languageidfromrequest+"   and t2.formid="+formid+" order by t2.fieldorder");

    while(RecordSet.next()){
        fieldids.add(Util.null2String(RecordSet.getString("fieldid")));
        fieldorders.add(Util.null2String(RecordSet.getString("fieldorder")));
        fieldlabels.add(Util.null2String(RecordSet.getString("fieldlable")));
        languageids.add(Util.null2String(RecordSet.getString("langurageid")));
    }
    /*
    RecordSet.executeProc("workflow_FieldID_Select",formid+"");

    while(RecordSet.next()){
        fieldids.add(Util.null2String(RecordSet.getString(1)));
        fieldorders.add(Util.null2String(RecordSet.getString(2)));
    }

    RecordSet.executeProc("workflow_FieldLabel_Select",formid+"");
    while(RecordSet.next()){
        fieldlabels.add(Util.null2String(RecordSet.getString("fieldlable")));
        languageids.add(Util.null2String(RecordSet.getString("languageid")));
    }
    */
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
		fielddbtypes.add(Util.null2String(RecordSet.getString("fielddbtype")));
        fieldimgwidths.add(Util.null2String(RecordSet.getString("imgwidth")));
        fieldimgheights.add(Util.null2String(RecordSet.getString("imgheight")));
        fieldimgnums.add(Util.null2String(RecordSet.getString("textheight")));
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


// ȷ���ֶ��Ƿ���ʾ
ArrayList isfieldids=new ArrayList();              //�ֶζ���
ArrayList isviews=new ArrayList();              //�ֶ��Ƿ���ʾ����

RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");

while(RecordSet.next()){
    isfieldids.add(Util.null2String(RecordSet.getString("fieldid")));
    isviews.add(RecordSet.getString("isview"));
}


// �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
if(intervenorright!=1){
for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ
    int tmpindex = i ;
    if(isbill.equals("0")) tmpindex = fieldorders.indexOf(""+i);     // ����Ǳ�, �õ���˳���Ӧ�� i

    String fieldid=(String)fieldids.get(tmpindex);  //�ֶ�id

    if( isbill.equals("1")) {
        String viewtype = (String)fieldviewtypes.get(tmpindex) ;   // ����ǵ��ݵĴӱ��ֶ�,����ʾ
        if( viewtype.equals("1") ) continue ;
    }

    String isview="0" ;    //�ֶ��Ƿ���ʾ
    int isfieldidindex = isfieldids.indexOf(fieldid) ;
    if( isfieldidindex != -1 ) isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
    if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��

    String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
    String fieldhtmltype = "" ;                     //�ֶε�ҳ������
    String fieldtype = "" ;                         //�ֶε�����
    String fieldlable = "" ;                        //�ֶ���ʾ��
	String fielddbtype = "";
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
        languageid = languageidfromrequest ;
        fieldname=(String)fieldnames.get(tmpindex);
        fieldhtmltype=(String)fieldhtmltypes.get(tmpindex);
        fieldtype=(String)fieldtypes.get(tmpindex);
        fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(tmpindex),0),languageid );
		fielddbtype=(String)fielddbtypes.get(tmpindex);
		fieldimgwidth=Util.getIntValue((String)fieldimgwidths.get(tmpindex),0);
		fieldimgheight=Util.getIntValue((String)fieldimgheights.get(tmpindex),0);
		fieldimgnum=Util.getIntValue((String)fieldimgnums.get(tmpindex),0);
    }

    String fieldvalue=(String)fieldvalues.get(tmpindex);

    // ���濪ʼ������ʾ�ֶ�
%>
    <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%> </td>
      <td class=field style="word-wrap:break-word;word-break:break-all;">
		
      <%
	 //add by dongping 
		//����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
		if (fieldtype.equals("118")) { %>           
    <!-- modify by xhheng @20050304 for TD 1691 -->
    <%if(isprint==false){%>
			<a href="/meeting/report/MeetingRoomPlan.jsp" target=blank><%=SystemEnv.getHtmlLabelName(2193,languageidfromrequest)%></a>		
    <%}%>
		<% }
        if(fieldhtmltype.equals("1") || fieldhtmltype.equals("2") ){  // ����,�����ı���
      /*------xwj for td3131 20051116 begin--------*/
      if(fieldhtmltype.equals("1") && fieldtype.equals("4")){
      %>
            <TABLE cols=2 id="field<%=fieldid%>_tab">
                <tr><td>
                    <script language="javascript">
                     window.document.write(milfloatFormat(floatFormat(<%=fieldvalue%>)));
                    </script>
                </td></tr>
                <tr><td>
                    <script language="javascript">
                     window.document.write(numberChangeToChinese(<%=fieldvalue%>));
                    </script>
                </td></tr>
            </table>
      <%}else{%>
<%
	          if(fieldhtmltype.equals("2") && fieldtype.equals("2")){
	        	if(isprint == true){
%>
       		  		<span style="word-wrap:break-word"><%=fieldvalue%></span>
<%
       		  	}else{
                  session.setAttribute("FCKEDDesc_"+requestid+"_"+userid+"_"+fieldid+"_-1",fieldvalue);
                  htmlfckfield_body.add("FCKiframe"+fieldid);
%>
<input type="hidden" id="FCKiframefieldid" value="FCKiframe<%=fieldid%>"/>
      <iframe id="FCKiframe<%=fieldid%>" name="FCKiframe<%=fieldid%>" src="/workflow/request/ShowFckEditorDesc.jsp?requestid=<%=requestid%>&userid=<%=userid%>&fieldid=<%=fieldid%>&rowno=-1"  width="100%" height="100%" marginheight="0" marginwidth="0" allowTransparency="true" frameborder="0"></iframe>
<%
       		  	}
	          }else{
	          	String toPvalue = "";
							if(fieldtype.equals("5")){
								if(fieldvalue.matches("-*\\d+\\.?\\d*")){
									NumberFormat formatter = new DecimalFormat("###,###");   
									toPvalue = formatter.format(Double.parseDouble(fieldvalue))+""; 
								}else{
									toPvalue = fieldvalue;
								}
								fieldvalue = toPvalue;
							}
%>
        <span id="field<%=fieldid%>span" style="word-break:break-all;word-wrap:break-word"><%=fieldvalue%></span>
<script>			
	var fieldfieldidspan = document.getElementById('field<%=fieldid%>span');
	var afieldFieldHtml = fieldfieldidspan.getElementsByTagName('a');
	for(var i=0;i<afieldFieldHtml.length;i++){
		afieldFieldHtml[i].target='_blank';
	}
</script>
<%
	          }
%>					
      <%}
      /*------xwj for td3131 20051116 end--------*/
        }                                                           // ����,�����ı�����������
        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
            String showname = "";                                                   // ֵ��ʾ������
            String showid = "";                                                     // ֵ
            String tablename=""; //������Ӧ�ı�,����������Դ��
             String columname=""; //������Ӧ�ı������ֶ�
             String keycolumname="";   //������Ӧ�ı�ֵ�ֶ�
            if(fieldtype.equals("2") || fieldtype.equals("19")){    // ���ں�ʱ��
      %>
        <%=fieldvalue%>
      <%
            } else if(!fieldvalue.equals("")) {
                ArrayList tempshowidlist=Util.TokenizerString(fieldvalue,",");
                if(fieldtype.equals("8") || fieldtype.equals("135")){
                    //��Ŀ������Ŀ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"' target='_new'>"+ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=ProjectInfoComInfo1.getProjectInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("17") && !isprint){//��ӡ��ʱ���ǰ���������ʾ
                	showname=workflowJspBean.getMultiResourceShowName(fieldvalue,linkurl,fieldid,languageidfromrequest);
                }else if(fieldtype.equals("1") ||fieldtype.equals("17")||fieldtype.equals("160")||fieldtype.equals("165")||fieldtype.equals("166")){
                    //��Ա������Ա
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
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
				else if(fieldtype.equals("161") || fieldtype.equals("162")){
                                                //�Զ��嵥ѡ������Զ����ѡ�����
												Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
                                                for(int k=0;k<tempshowidlist.size();k++){
													try{
                                                        BrowserBean bb=browser.searchById((String)tempshowidlist.get(k));
			                                            String desc=Util.null2String(bb.getDescription());
			                                            String name=Util.null2String(bb.getName());							
			                                            String href=Util.null2String(bb.getHref());
			                                            if(href.equals("")){
			                                            	showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
			                                            }else{
			                                            	showname+="<a title='"+desc+"' href='"+href+"' target='_blank'>"+name+"</a>&nbsp";
			                                            }
													}catch (Exception e){
													}
                                                }
                }else if(fieldtype.equals("142")){
                    //�շ��ĵ�λ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+docReceiveUnitComInfo_vba.getReceiveUnitName((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=docReceiveUnitComInfo_vba.getReceiveUnitName((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }
				else if(fieldtype.equals("7") || fieldtype.equals("18")){
                    //�ͻ�����ͻ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"' target='_new'>"+CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CustomerInfoComInfo.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("4") || fieldtype.equals("57")|| fieldtype.equals("167")|| fieldtype.equals("168")){
                    //���ţ��ಿ��
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
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
                       showname+="<a href='javascript:createDoc("+fieldid+","+tempDoc+")' >"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp<button type=button  id='createdoc' style='display:none' class=AddDocFlow onclick=createDoc("+fieldid+","+tempDoc+")></button>";
                       
                        }
                        else
                        {
                        if(!linkurl.equals("") && !isprint){
                            //showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"&desrequestid="+desrequestid+"' target='_blank'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";

                        }else{
                        showname+=DocComInfo1.getDocname((String)tempshowidlist.get(k))+" ";
                        }
                        }
                    }
                }else if(fieldtype.equals("23")){
                    //�ʲ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"' target='_new'>"+CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CapitalComInfo1.getCapitalname((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("16") || fieldtype.equals("152") || fieldtype.equals("171")){
                    //�������
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                            int tempnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
                            tempnum++;
                            session.setAttribute("resrequestid"+tempnum,""+tempshowidlist.get(k));
                            session.setAttribute("slinkwfnum",""+tempnum);
                            session.setAttribute("haslinkworkflow","1");
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
						 if(!linkurl.equals("") && !isprint){
							 showname += "<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DocReceiveUnitComInfo.getReceiveUnitName(""+tempshowidlist.get(k))+"</a>&nbsp";
	                        }else{
	                            showname += DocReceiveUnitComInfo.getReceiveUnitName(""+tempshowidlist.get(k))+" ";
	                        }
					 }
				}
                //end by alan for td:10814
				else if(fieldtype.equals("226") || fieldtype.equals("227")){
						//zzl
						showname+="<a title='"+fieldvalue+"'>"+fieldvalue+"</a>&nbsp";
				}else{
                    tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                    columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
					 /*��ΪӦƸ����(HrmCareerApply)����Ա��firstname������ʱ��Ϊ�գ��˴�����ֱ��ȡ����������(lastname+firstname)
					 �ᵼ�������ύ��ӦƸ�˲���ʾ�����Դ˴��������⴦��ֻȡӦƸ�˵�lastname	�ο�TD24866*/
					if(columname.equals("(lastname+firstname)"))
						columname = "lastname";
                    keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                    if(fieldvalue.indexOf(",")!=-1){
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }
                    RecordSet.executeSql(sql);
                    while(RecordSet.next()){
                        if(!linkurl.equals("") && !isprint){
                            showname += "<a href='"+linkurl+RecordSet.getString(1)+"' target='_new'>"+Util.toScreen(RecordSet.getString(2),languageidfromrequest)+"</a>&nbsp";
                        }else{
                            showname +=Util.toScreen(RecordSet.getString(2),languageidfromrequest)+" ";
                        }
                    }    // end of while
                }
            %>
                    <%=showname%>
          <%
            }
        }                                                       // �����ť��������
        else if(fieldhtmltype.equals("4")) {                    // check��
       %>
        <input type=checkbox value=1 name="field<%=fieldid%>" DISABLED <%if(fieldvalue.equals("1")){%> checked <%}%>>
       <%
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
       %>
         <select name="field<%=fieldid%>" DISABLED ><%
		   //����Ǳ༭״̬�ͳ���һ���հ�ѡ��.���Ǳ༭״̬�����Ѱ�,����ҳ��,����ʾ�հ�...
		if("1".equals(isEdit_)){%>
		<option value=""></option> <!--added by xwj for td3297 20051130 --> 
       <%}  else{ 
			//������Ǳ༭״̬,ͬʱֵ���ǿյ�,Ҳ��ʾһ���հ�ѡ��.
			if("".equals(fieldvalue)){%>
			<option value=""></option><%
		}
		}
           if("1".equals(isEdit_))
            rs.executeProc("workflow_selectitembyid_new",""+fieldid+flag+isbill); 
			else
			 rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);  
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),languageidfromrequest);
       %>
        <option value="<%=tmpselectvalue%>"  <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
       <%
            }
       %>
        </select>
       <%
        //add by xhheng @20050318 for �����ϴ�
        }else if(fieldhtmltype.equals("6")){
        %>
          <%
          if(!fieldvalue.equals("")) {
          //modify by xhheng @20050512 for 1803
          %>
          <TABLE cols=3 id="field<%=fieldid%>_tab">
            <TBODY >
            <COL width="50%" >
            <COL width="25%" >
            <COL width="25%">
            <%
			  if("-2".equals(fieldvalue)){%>
			<tr>
				<td colSpan=3><font color="red">
				<%=SystemEnv.getHtmlLabelName(21710,languageidfromrequest)%></font>
				</td>
			</tr>
			  <%}else{
            sql="select id,docsubject,accessorycount,SecCategory from docdetail where id in("+fieldvalue+") order by id asc";
            int linknum=-1;
            boolean isfrist=false;
            int imgnum=fieldimgnum;
            RecordSet.executeSql(sql);
            int AttachmentCounts=RecordSet.getCounts();
            while(RecordSet.next()){
              isfrist=false;
              linknum++;
              String showid = Util.null2String(RecordSet.getString(1)) ;
              String tempshowname= Util.toScreen(RecordSet.getString(2),languageidfromrequest) ;
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
              boolean nodownload=SecCategoryComInfo1.getNoDownload(SecCategory).equals("1")?true:false;
              String imgSrc=AttachFileUtil.getImgStrbyExtendName(fileExtendName,20);
              if(fieldtype.equals("2")){
              if(linknum==0){
                  isfrist=true;
              %>
          <% 
           if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0 && !isprint && !isurger && !wfmonitor){
          %>
            <tr> 
              <td colSpan=3><nobr>
                  <button type=button class=btnFlowd accessKey=1  onclick="top.location='/weaver/weaver.file.FileDownload?fieldvalue=<%=fieldvalue%>&download=1&downloadBatch=1&requestid=<%=requestid%>'">
                    <%="&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(74,languageidfromrequest)+SystemEnv.getHtmlLabelName(332,languageidfromrequest)+SystemEnv.getHtmlLabelName(258,languageidfromrequest)%>
                  </button>
              </td>
            </tr>
           <%}%> 
            <tr>
                <td colSpan=3>
                    <table cellpadding="0" cellspacing="0">
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
                          <td align="center"><img src="/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&requestid=<%=requestid%>" style="cursor:hand" alt="<%=docImagefilename%>" <%if(fieldimgwidth>0){%>width="<%=fieldimgwidth%>"<%}%> <%if(fieldimgheight>0){%>height="<%=fieldimgheight%>"<%}%> onclick="addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>')">
                          </td>
                      </tr>
                      <tr>
                              <%
                                  if (!nodownload && !isprint && !isurger && !wfmonitor) {
                              %>
                              <td align="center"><nobr><a href="#" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');top.location='/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&download=1&requestid=<%=requestid%>&desrequestid=<%=desrequestid%>';return false;" style="text-decoration:underline">[<span  style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,languageidfromrequest)%></span>]</a></td>
                              <%}%>
                      </tr>
                        </table>
                    </td>
              <%}else{
              %>
              <tr>
              <td>
              <%=imgSrc%>
              <%if(isprint){%>
              <%=tempshowname%>
              <%}else{ 
	              if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){
	            	// isAppendTypeField������ʶ  ��ǰ�ֶ������Ǹ����ϴ����ͣ����۸ø��������ĵ������Ƿ�Ϊ�ա����ߴ������°汾���ڸ����Ӵ�ҳ����Զ�򿪸ø������ݡ�����ʾ�ø��������ĵ����ݡ�
	              %>
	                <a href="javascript:addDocReadTag('<%=showid%>');openFullWindowHaveBar('/docs/docs/DocDspExt.jsp?id=<%=showid%>&versionId=<%=versionId%>&imagefileId=<%=docImagefileid%>&isFromAccessory=true&requestid=<%=requestid%>&desrequestid=<%=desrequestid%>&isAppendTypeField=1')"><%=docImagefilename%></a>&nbsp
	              <%}else{%>
	                <a href="javascript:addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>')"><%=docImagefilename%></a>&nbsp
	              <%}
              }%>
              </td>
              <%if(((!Util.isExt(fileExtendName))||!nodownload) && !isprint && !isurger && !wfmonitor){%>
              <td >
                <span id = "selectDownload">
                <!-- �ٴμ�һ��nobr ��ǩ �Ϳ��� 2012-08-27 ypc �޸� һ�в��û��е�Ԫ�ػ��� ʹ�ô˱�ǩ -->
                <nobr>
	                  <button type=button  class=btnFlowd accessKey=1  onclick="addDocReadTag('<%=showid%>');top.location='/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&download=1&requestid=<%=requestid%>&desrequestid=<%=desrequestid%>'">
	                    <U><%=linknum%></U>-<%=SystemEnv.getHtmlLabelName(258,languageidfromrequest)%>	(<%=docImagefileSize/1000%>K)
	                  </button>
	                   <% 
	                    //if(isDownloadAll && AttachmentCounts>1 && (linknum+1)==AttachmentCounts){
	                    if(!"1".equals(forbidAttDownload) && !nodownload && AttachmentCounts>1 && linknum==0){
	                  %>
	                  &nbsp;&nbsp;&nbsp;&nbsp;
	                  <button type=button class=btnFlowd accessKey=1  onclick="top.location='/weaver/weaver.file.FileDownload?fieldvalue=<%=fieldvalue%>&download=1&downloadBatch=1&requestid=<%=requestid%>'">
	                    <%="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+SystemEnv.getHtmlLabelName(332,languageidfromrequest)+SystemEnv.getHtmlLabelName(258,languageidfromrequest)%>
	                  </button>
	                  <%}%>
                </nobr>
                </span>
              </td>
              <%}%>
              <td>&nbsp;</td>
              </tr>
              <%}}
            if(fieldtype.equals("2")&&linknum>-1){%>
            </tr></table></td></tr>
            <%}}%>
              </tbody>
              </table>
              <%
            }
        }     // ѡ����������� ���������ж�����
       else if(fieldhtmltype.equals("7")){//�����ֶ�
           if(isbill.equals("0")) out.println(Util.null2String((String)specialfield.get(fieldid+"_0")));
           else out.println(Util.null2String((String)specialfield.get(fieldid+"_1")));
       }       
       %>
      </td>
    </tr>
    <TR style="height:1px;"><TD class=Line2 colSpan=2></TD></TR>
<%
}       // ѭ������
}
%>

</TABLE>

<%
//add by mackjoe at 2006-06-07 td4491 ����ϸʱ�ż���
boolean  hasdetailb=false;
if(!(isbill.equals("1")&&(formid==7||formid==156||formid==157||formid==158||formid==159))){
if(isbill.equals("0")) {
    RecordSet.executeSql("select count(*) from workflow_formfield  where isdetail='1' and formid="+formid);
}else{
    RecordSet.executeSql("select count(*) from workflow_billfield  where viewtype=1 and billid="+formid);
}
if(RecordSet.next()){
    if(RecordSet.getInt(1)>0) hasdetailb=true;
}
}
if(hasdetailb){
%>
<!--###########��ϸ�� Start##########-->
<%@ include file="/workflow/request/WorkflowViewRequestDetailBodyAction.jsp" %>
<!--###########��ϸ�� END########### -->
<%}%>
<script>
function createDoc(fieldbodyid,docVlaue)
{
	
   /*
   for(i=0;i<=1;i++){
  		parent.document.all("oTDtype_"+i).background="/images/tab2.png";
  		parent.document.all("oTDtype_"+i).className="cycleTD";
  	}
  	parent.document.all("oTDtype_1").background="/images/tab.active2.png";
  	parent.document.all("oTDtype_1").className="cycleTDCurrent";
  	*/
  	$GetEle("frmmain").action = "RequestDocView.jsp?requestid=<%=requestid%>&docValue="+docVlaue;
  	$GetEle("frmmain").method.value = "crenew_"+fieldbodyid ;
  	$GetEle("frmmain").target="delzw";
    parent.delsave();
	if(check_form($GetEle("frmmain"),'requestname')){
      	if($GetEle("needoutprint")) $GetEle("needoutprint").value = "1";//��ʶ������
      	$GetEle("frmmain").src.value='save';
        //�����ϴ�
        StartUploadAll();
        checkuploadcomplet();
		parent.clicktext();//�л���ǰtabҳ������ҳ��   
		if(document.getElementById("needoutprint")) document.getElementById("needoutprint").value = "";//��ʶ������
    }


}


function openAccessory(fileId){ 
	openFullWindowHaveBar("/weaver/weaver.file.FileDownload?fileid="+fileId+"&requestid=<%=requestid%>&desrequestid=<%=desrequestid%>");
}
//** iframe�Զ���Ӧҳ�� **//

function dyniframesize()
{
var dyniframe;
<%for (int i=0; i<htmlfckfield_body.size(); i++)
{%>
if (document.getElementById)
{
    //�Զ�����iframe�߶�
    dyniframe = document.getElementById("<%=htmlfckfield_body.get(i)%>");
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
alert("<%=SystemEnv.getHtmlLabelName(22577,languageidfromrequest)%>");
<%}%>    
}
if (window.addEventListener)
window.addEventListener("load", dyniframesize, false);
else if (window.attachEvent)
window.attachEvent("onload", dyniframesize);
else
window.onload=dyniframesize;
</script>
<input type=hidden name="desrequestid" value="<%=desrequestid%>">           <!--������id-->
<input type=hidden name="requestid" value="<%=requestid%>">           <!--����id-->
<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="<%=nodetype%>">           <!--��ǰ�ڵ�����-->
<input type=hidden name="src" value="active">                       <!--�������� save��submit,reject,delete,active-->
<input type=hidden name="iscreate" value="0">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name="billid" value="<%=billid%>">             <!--����id-->

<input type=hidden name="rand" value="<%=System.currentTimeMillis()%>">
<input type=hidden name="needoutprint" value="">
<iframe name="delzw" width=0 height=0 style="border:none"></iframe>
