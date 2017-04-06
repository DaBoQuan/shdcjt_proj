<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="RequestOperation.jsp" enctype="multipart/form-data">
<jsp:useBean id="SpecialField" class="weaver.workflow.field.SpecialFieldInfo" scope="page" />
<jsp:useBean id="RecordSet_nf1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet_nf2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectInfoComInfo1" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo1" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="DocComInfo1" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo1" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo1" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo1" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo1" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="docReceiveUnitComInfo_vb" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<DIV>
<%if(canactive&&deleted==1){%>
<BUTTON class=btn accessKey=A type=submit><U>A</U>-<%=SystemEnv.getHtmlLabelName(737,user.getLanguage())%></button>
<%}%>
</DIV>
<BR>
<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</DIV>
<!--����ı������ -->

<BR>
<TABLE class="ViewForm" >
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
  <TR class=spacing>
    <TD class=line1 colSpan=2></TD>
  </TR>
  <TR>
    <TD>
     <b><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></b>
    </TD>
    <TD class=field>
       
         <%if(!"1".equals(isEdit_)){//xwj for td1834 on 2005-05-22%>
       <%=Util.toScreenToEdit(requestname,user.getLanguage())%>
       <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,user.getLanguage())%>">
       <%}
       else{%>
        <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=60  maxlength=100  value = "<%=Util.toScreenToEdit(requestname,user.getLanguage())%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,user.getLanguage()))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%}%>
    
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
     
     
    </TD>
  </TR>
    <TR><TD class=Line2 colSpan=2></TD></TR>
      	<%
    	int rqMessageType=-1;
    	int wfMessageType=-1;
			String sqlWfMessage = "select a.messagetype,b.docCategory,b.messagetype as wfMessageType from workflow_requestbase a,workflow_base b where a.workflowid=b.id and a.requestid="+requestid ;
			RecordSet.executeSql(sqlWfMessage);
			if (RecordSet.next()) {
				wfMessageType=RecordSet.getInt("wfMessageType");
				rqMessageType=RecordSet.getInt("messagetype");
			}
			if(wfMessageType==1){
			%>
			<TR>
				<TD > <%=SystemEnv.getHtmlLabelName(17586,user.getLanguage())%></TD>
				<td class=field>
					<%if(rqMessageType==0){%><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%><%}%>
		    	<%if(rqMessageType==1){%><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%><%}%>
		    	<%if(rqMessageType==2){%><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%><%}%>
		    </td>
	    </TR>
    	<TR><TD class=Line2 colSpan=2></TD></TR>
     	<%}%>
  
  <%
  System.out.println("formid:"+formid);
  if(formid==163){%>
  <TR>
  	<TD><%=SystemEnv.getHtmlLabelName(19018,user.getLanguage())%></TD>
  	<TD class=field><a href="/car/CarUseInfo.jsp" target="_blank"><%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%></a></TD>
  </TR>
  <TR><TD class=Line2 colSpan=2></TD></TR>
  <%}%>
  <!--��һ�н��� -->

<%
String docFlags=(String)session.getAttribute("requestAdd"+requestid);
HashMap specialfield = SpecialField.getFormSpecialField();//�����ֶε��ֶ���Ϣ
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

if(isbill.equals("0")) {
    RecordSet.executeSql("select t2.fieldid,t2.fieldorder,t1.fieldlable,t1.langurageid from workflow_fieldlable t1,workflow_formfield t2 where t1.formid=t2.formid and t1.fieldid=t2.fieldid and (t2.isdetail<>'1' or t2.isdetail is null)  and t2.formid="+formid+"  and t1.langurageid="+user.getLanguage()+" order by t2.fieldorder");

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
    }*/
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
    System.out.println("select * from " + tablename + " where id = " + billid);
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

    // ���濪ʼ������ʾ�ֶ�
%>
    <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%> </td>
      <td class=field>
		
      <%
	 //add by dongping 
		//����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
		if (fieldtype.equals("118")) { %>           
    <!-- modify by xhheng @20050304 for TD 1691 -->
    <%if(isprint==false){%>
			<a href="/meeting/report/MeetingRoomPlan.jsp" target=blank>�鿴������ʹ�����</a>		
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
        <%=fieldvalue%>
      <%}
      /*------xwj for td3131 20051116 end--------*/
        }                                                           // ����,�����ı�����������
        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            if(fieldtype.equals("2") || fieldtype.equals("19")){    // ���ں�ʱ��
      %>
        <%=fieldvalue%>
      <%
            } else if(!fieldvalue.equals("")) {
                String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
                String showname = "";                                                   // ֵ��ʾ������
                String showid = "";                                                     // ֵ
                
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
                }else if(fieldtype.equals("1") ||fieldtype.equals("17")||fieldtype.equals("160")||fieldtype.equals("165")||fieldtype.equals("166")){
                    //��Ա������Ա
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                        	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                          	{
                        		showname+="<a href='javaScript:openhrm("+tempshowidlist.get(k)+");' onclick='pointerXY(event);'>"+ResourceComInfo1.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                          	}
                        	else
                            	showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ResourceComInfo1.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=ResourceComInfo1.getResourcename((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }else if(fieldtype.equals("142")){
                    //�շ��ĵ�λ
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("")){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+docReceiveUnitComInfo_vb.getReceiveUnitName((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=docReceiveUnitComInfo_vb.getReceiveUnitName((String)tempshowidlist.get(k))+" ";
                        }
                    }
                }
				else if(fieldtype.equals("7") || fieldtype.equals("18")){
                    //�ͻ�����ͻ�
                    for(int k=0;k<tempshowidlist.size();k++){
                        if(!linkurl.equals("") && !isprint){
                            showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&requestid="+requestid+"' target='_new'>"+CustomerInfoComInfo1.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                        }else{
                        showname+=CustomerInfoComInfo1.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
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
                       showname+="<a href='javascript:createDoc("+fieldid+","+tempDoc+")'>"+DocComInfo1.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp<button id='createdoc' style='display:none' class=AddDocFlow onclick=createDoc("+fieldid+","+tempDoc+")></button>";
                       
                        }
                        else
                        {
                        if(!linkurl.equals("") && !isprint){
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
                }else if(fieldtype.equals("16") || fieldtype.equals("152")){
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
                }else{
	                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
	                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
	                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                    if(fieldvalue.indexOf(",")!=-1){
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }

	                RecordSet.executeSql(sql);
					while(RecordSet.next()){
                        if(!linkurl.equals("") && !isprint){
                            showname += "<a href='"+linkurl+RecordSet.getString(1)+"' target='_new'>"+Util.toScreen(RecordSet.getString(2),user.getLanguage())+"</a>&nbsp";
                        }else{
                            showname +=Util.toScreen(RecordSet.getString(2),user.getLanguage())+" ";
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
        <select name="field<%=fieldid%>" DISABLED >
        <option value=""></option><!--added by xwj for td3297 20051130 -->
       <%
            // ��ѯѡ�������п���ѡ���ֵ
            rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
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
            sql="select id,docsubject,accessorycount from docdetail where id in("+fieldvalue+") order by id asc";
            int linknum=-1;
            int imgnum=fieldimgnum;
            boolean isfrist=false;
            RecordSet.executeSql(sql);
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
                          <td align="center"><img src="/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&requestid=<%=requestid%>" style="cursor:hand" alt="<%=docImagefilename%>" <%if(fieldimgwidth>0){%>width="<%=fieldimgwidth%>"<%}%> <%if(fieldimgheight>0){%>height="<%=fieldimgheight%>"<%}%> onclick="addDocReadTag('<%=showid%>');openAccessory('<%=docImagefileid%>');return false;">
                          </td>
                      </tr>
                      <tr>
                              <%
                                  if (!isprint) {
                              %>
                              <td align="center"><nobr><a href="#" onmouseover="this.style.color='blue'" onclick="addDocReadTag('<%=showid%>');top.location='/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&download=1&requestid=<%=requestid%>&desrequestid=<%=desrequestid%>';return false;" style="text-decoration:underline">[<span  style="cursor:hand;color:black;"><%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%></span>]</a></td>
                              <%}%>
                      </tr>
                        </table>
                    </td>
              <%}else{%>
              <tr>
              <td>
              <%=imgSrc%>
              <%if(accessoryCount==1 && (Util.isExt(fileExtendName)||fileExtendName.equalsIgnoreCase("pdf"))){%>
                <a href="javascript:openFullWindowHaveBar('/docs/docs/DocDspExt.jsp?id=<%=showid%>&versionId=<%=versionId%>&imagefileId=<%=docImagefileid%>&isFromAccessory=true')"><%=docImagefilename%></a>&nbsp
              <%}else{%>
                <a href="javascript:openFullWindowHaveBar('/docs/docs/DocDsp.jsp?id=<%=showid%>')"><%=tempshowname%></a>&nbsp
              <%}%>
              </td>
              <%if(accessoryCount==1){%>
              <td >
                <span id = "selectDownload">
                  <BUTTON class=btn accessKey=1  onclick="top.location='/weaver/weaver.file.FileDownload?fileid=<%=docImagefileid%>&download=1'">
                    <U><%=linknum%></U>-<%=SystemEnv.getHtmlLabelName(258,user.getLanguage())%>(<%=docImagefileSize/1000%>K)
                  </BUTTON>
                </span>
              </td>
              <%}%>
              <td>&nbsp;</td>
              </tr>
              <%}}
            if(fieldtype.equals("2")&&linknum>-1){%>
            </tr></table></td></tr>
            <%}%>
              </tbody>
              </table>
              <%
            }
        }else if(fieldhtmltype.equals("7")){
     	   out.println(Util.null2String((String)specialfield.get(fieldid+"_1")));
        }     // ѡ����������� ���������ж�����
       %>
      </td>
    </tr>
    <TR><TD class=Line2 colSpan=2></TD></TR>
<%
}       // ѭ������
%>

</TABLE>


<!--###########��ϸ�� Start##########-->
<%@ include file="/workflow/request/WorkflowViewRequestDetailBody.jsp" %>
<!--###########��ϸ�� END########### -->


<input type=hidden name="requestid" value="<%=requestid%>">           <!--����id-->
<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="<%=nodetype%>">           <!--��ǰ�ڵ�����-->
<input type=hidden name="src" value="active">                       <!--�������� save��submit,reject,delete,active-->
<input type=hidden name="iscreate" value="0">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name="billid" value="<%=billid%>">             <!--����id-->
	<%@ include file="/workflow/request/WorkflowViewSign.jsp" %>
</form>
<script type="text/javascript">
function openAccessory(fileId){
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
</body>
</html>
