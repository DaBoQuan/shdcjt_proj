
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>

<form name="frmmain" method="post" action="BillInnerSendDocOperation.jsp">




<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</DIV>
<!--����ı������ -->

<BR>
<TABLE class="ViewForm">
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">

  <!--�½��ĵ�һ�У�����˵������Ҫ�� -->
  <TR class="Spacing">
    <TD class="Line1" colSpan=2></TD>
  </TR>
  <TR>
    <TD><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></TD>
    <TD class=field>
      <%=Util.toScreen(requestname,user.getLanguage())%>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
      <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,user.getLanguage())%>">
    </TD>
  </TR>  	   	<TR >
    <TD class="Line1" colSpan=2></TD>
  </TR>
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

        if(isbill.equals("0")) {
            languageid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
            fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
            fieldtype=FieldComInfo.getFieldType(fieldid);
            fieldlable=(String)fieldlabels.get(tmpindex);
            fieldname=FieldComInfo.getFieldname(fieldid);
        }
        else {
            languageid = user.getLanguage() ;
            fieldname=(String)fieldnames.get(tmpindex);
            fieldhtmltype=(String)fieldhtmltypes.get(tmpindex);
            fieldtype=(String)fieldtypes.get(tmpindex);
            fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(tmpindex),0),languageid );
        }

        String fieldvalue=(String)fieldvalues.get(tmpindex);

        if(fieldname.equals("manager")) {
            String tmpmanagerid = ResourceComInfo.getManagerID(""+userid);
%>
	<input type=hidden name="field<%=fieldid%>" value="<%=tmpmanagerid%>"
<%
            continue;
        }

        if(fieldname.equals("begindate")) newfromdate="field"+fieldid;      //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
        if(fieldname.equals("enddate")) newenddate="field"+fieldid;     //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
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
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=50 value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%

                        }else{%>
        <input  type=text class=Inputstyle name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" size=50>
      <%            }
                    }
                    else {
      %>
        <%=Util.toScreen(fieldvalue,user.getLanguage())%>
        <input type=hidden name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>">
      <%
                    }
                }
                else if(fieldtype.equals("2")){                     // �����ı����е�����
                    if(isedit.equals("1") && isremark==0 ){
                        if(ismand.equals("1")) {
      %>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>"
		onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%

                        }else{%>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
       <%           }
                    }
                    else {
      %>
        <%=fieldvalue%><input type=hidden name="field<%=fieldid%>" value="<%=fieldvalue%>">
      <%
                    }
                }
                else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                    if(isedit.equals("1") && isremark==0 ){
                        if(ismand.equals("1")) {
       %>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>"
		onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
                        }else{%>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
       <%           }
                    }
                    else {
      %>
        <%=fieldvalue%><input type=hidden name="field<%=fieldid%>" value="<%=fieldvalue%>">
      <%
                    }
                }
            }                                                       // �����ı�����������
            else if(fieldhtmltype.equals("2")){                     // �����ı���
                if(isedit.equals("1") && isremark==0 ){
                    if(ismand.equals("1")) {
       %>
        <textarea class=Inputstyle name="field<%=fieldid%>"  onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')"
		rows="4" cols="40" style="width:80%" ><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
        <span id="field<%=fieldid%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%
                    }else{
       %>
        <textarea class=Inputstyle name="field<%=fieldid%>" rows="4" cols="40" style="width:80%"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
       <%       }
                }
                else {
      %>
        <%=Util.toScreen(fieldvalue,user.getLanguage())%>
        <input type=hidden name="field<%=fieldid%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>">
      <%
                }
            }                                                           // �����ı�����������
            else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                String linkurl =BrowserComInfo.getLinkurl(fieldtype);   // ���ֵ�����ʱ�����ӵ�url
                String showname = "";                                                   // ֵ��ʾ������
                String showid = "";                                                     // ֵ

                // ����Ƕ��ĵ�, ��Ҫ�ж��Ƿ����¼�����ĵ�,�����,��Ҫ����ԭ���ĺ���
                if( fieldtype.equals("37") && fieldid.equals(docfileid) && !newdocid.equals("")) {
                    if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                    fieldvalue += newdocid ;
                }

                if(fieldtype.equals("2") ||fieldtype.equals("19")  )	showname=fieldvalue; // ����ʱ��
                else if(!fieldvalue.equals("")) {
                    String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                    String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                    String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                    if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }

                    RecordSet.executeSql(sql);
                    while(RecordSet.next()){
                        showid = Util.null2String(RecordSet.getString(1)) ;
                        String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                        if(!linkurl.equals(""))
                            if(fieldtype.equals("9")|| fieldtype.equals("37"))
                                {
                    				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                	{
                                		showname = "<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + tempshowname + "</a>&nbsp";
                                	}
                    				else
                    					showname += "<a href='"+linkurl+showid+"&requestid="+requestid+"'>"+tempshowname+"</a> " ;
                    			}
                            else
                                showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                        else
                            showname += tempshowname ;
                    }
                }
                if(isedit.equals("1") && isremark==0 ){
                    if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
	   %>
        <button class=Browser onclick="onShowBrowser('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
       <%       } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button class=AddDoc onclick="onShowBrowser('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp;<button class=AddDoc onclick="onNewDoc(<%=fieldid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
       <%       }
                }
       %>
        <span id="field<%=fieldid%>span"><%=showname%>
       <%
                if( ismand.equals("1") && fieldvalue.equals("") ){
       %>
        <img src="/images/BacoError.gif" align=absmiddle>
       <%
                }
       %>
        </span> <input type=hidden name="field<%=fieldid%>" value="<%=fieldvalue%>">
       <%
            }                                                       // �����ť��������
            else if(fieldhtmltype.equals("4")) {                    // check��
	   %>
        <input type=checkbox value=1 name="field<%=fieldid%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%>  <%if(fieldvalue.equals("1")){%> checked <%}%> >
       <%
                if( isedit.equals("0") || isremark==1 ){
       %>
        <input type= hidden name="field<%=fieldid%>" value="<%=fieldvalue%>">
       <%
                }
            }                                                       // check����������
            else if(fieldhtmltype.equals("5")){                     // ѡ���   select
	   %>
        <select class=inputstyle  name="field<%=fieldid%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> >
	   <%
                // ��ѯѡ�������п���ѡ���ֵ
                rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);
                while(rs.next()){
                    String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                    String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
	   %>
	    <option value="<%=tmpselectvalue%>" <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
	   <%
                }
       %>
	    </select>
       <%
                if( isedit.equals("0") || isremark==1 ) {
       %>
        <input type= hidden name="field<%=fieldid%>" value=<%=fieldvalue%>>
       <%
                }
            }                                          // ѡ����������� ���������ж�����
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
        }
    }
    return true;
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