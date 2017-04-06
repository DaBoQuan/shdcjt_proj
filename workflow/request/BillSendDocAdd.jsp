<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowAddRequestTitle.jsp" %>

<form name="frmmain" method="post" action="BillSendDocOperation.jsp">
<input type="hidden" name="needwfback" id="needwfback" value="1" />
<!--����ı��⿪ʼ -->
<DIV align="center">
<font style="font-size:14pt;FONT-WEIGHT: bold"><%=Util.toScreen(workflowname,user.getLanguage())%></font>
</DIV>
<!--����ı������ -->

<TABLE class="ViewForm" >
  <COLGROUP>
  <COL width="20%">
  <COL width="80%">

  <!--�½��ĵ�һ�У�����˵������Ҫ�� -->

  <TR><TD class=Line1 colSpan=2></TD></TR>
  <TR>
    <TD><%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%></TD>
    <TD class=field>
      <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=40 maxlength=100  <%if(!workflowid.equals("146")){%> value = "<%=Util.toScreenToEdit( workflowname+"-"+username+"-"+currentdate,user.getLanguage() )%>" <%}%> >
      <span id=requestnamespan><%if(workflowid.equals("146")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <input type=hidden value="0" name="requestlevel" >
    </TD>
  </TR>
<TR><TD class=Line colSpan=2></TD></TR>
  <!--��һ�н��� -->

<%
String isSignDoc_add="";
String isSignWorkflow_add="";
RecordSet.execute("select titleFieldId,keywordFieldId,isSignDoc,isSignWorkflow from workflow_base where id="+workflowid);
if(RecordSet.next()){
    isSignDoc_add=Util.null2String(RecordSet.getString("isSignDoc"));
    isSignWorkflow_add=Util.null2String(RecordSet.getString("isSignWorkflow"));
}
//��ѯ�����ߵ��ݵ��ֶ�,�ֶε����ƣ��ֶε�HTML���ͺ��ֶε����ͣ�����HTML���͵�һ����չ��

ArrayList fieldids=new ArrayList();             //�ֶζ���
ArrayList fieldorders = new ArrayList();        //�ֶ���ʾ˳����� (�����ļ�����Ҫ)
ArrayList languageids=new ArrayList();          //�ֶ���ʾ������(�����ļ�����Ҫ)
ArrayList fieldlabels=new ArrayList();          //���ݵ��ֶε�label����
ArrayList fieldhtmltypes=new ArrayList();       //���ݵ��ֶε�html type����
ArrayList fieldtypes=new ArrayList();           //���ݵ��ֶε�type����
ArrayList fieldnames=new ArrayList();           //���ݵ��ֶεı��ֶ�������
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
    if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��

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

    if(fieldname.equals("manager")) {
	    String tmpmanagerid = ResourceComInfo.getManagerID(""+userid);
%>
	<input type=hidden name="field<%=fieldid%>" value="<%=tmpmanagerid%>"
<%
	    continue;
	}

	if(fieldname.equals("begindate")) newfromdate="field"+fieldid;      //��ʼ����,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�
	if(fieldname.equals("enddate")) newenddate="field"+fieldid;     //��������,��ҪΪ��ʼ���ڲ����ڽ������ڽ��бȽ�

    if(ismand.equals("1"))  needcheck+=",field"+fieldid;   //�����������,�����������ļ����

    // ���濪ʼ������ʾ�ֶ�
%>
    <tr>
      <td <%if(fieldhtmltype.equals("2")){%> valign=top <%}%>> <%=Util.toScreen(fieldlable,languageid)%> </td>
      <td class=field>
      <%
        if(fieldhtmltype.equals("1")){                          // �����ı���
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
      %>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=50 onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><img src="/images/BacoError.gif" align=absmiddle></span>
      <%

				    }else{%>
        <input type=text class=Inputstyle name="field<%=fieldid%>" value="" size=50>
      <%            }
			    }
		    }
		    else if(fieldtype.equals("2")){                     // �����ı����е�����
			    if(isedit.equals("1")){
				    if(ismand.equals("1")) {
      %>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10
		onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><img src="/images/BacoError.gif" align=absmiddle></span>
       <%

				    }else{%>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
       <%           }
			    }
		    }
		    else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
			    if(isedit.equals("1")){
				    if(ismand.equals("1")) {
       %>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10
		onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        <span id="field<%=fieldid%>span"><img src="/images/BacoError.gif" align=absmiddle></span>
       <%
    				}else{%>
        <input type=text class=Inputstyle name="field<%=fieldid%>" size=10 onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
       <%           }
			    }
		    }
	    }                                                       // �����ı�����������
	    else if(fieldhtmltype.equals("2")){                     // �����ı���
		    if(isedit.equals("1")){
			    if(ismand.equals("1")) {
       %>
        <textarea class=Inputstyle name="field<%=fieldid%>" onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')"
		rows="4" cols="40" style="width:80%" class=Inputstyle></textarea>
        <span id="field<%=fieldid%>span"><img src="/images/BacoError.gif" align=absmiddle></span>
       <%
			    }else{
       %>
        <textarea class=Inputstyle name="field<%=fieldid%>" rows="4" cols="40" style="width:80%"></textarea>
       <%       }
		    }
	    }                                                           // �����ı�����������
	    else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
		    String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
		    String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
		    String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
		    String showid = "";                                     // �½�ʱ��Ĭ��ֵ

            if(fieldtype.equals("8") && !prjid.equals("")){       //�����ťΪ��Ŀ,��ǰ��Ĳ����л����ĿĬ��ֵ
                showid = "" + Util.getIntValue(prjid,0);
            }else if((fieldtype.equals("9") || fieldtype.equals("37")) && !docid.equals("")){ //�����ťΪ�ĵ�,��ǰ��Ĳ����л���ĵ�Ĭ��ֵ
                showid = "" + Util.getIntValue(docid,0);
            }else if((fieldtype.equals("1") ||fieldtype.equals("17")) && !hrmid.equals("")){ //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(hrmid,0);
            }else if((fieldtype.equals("7") || fieldtype.equals("18")) && !crmid.equals("")){ //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
                showid = "" + Util.getIntValue(crmid,0);
            }else if(fieldtype.equals("4") && !hrmid.equals("")){ //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(hrmid),0);
            }else if(fieldtype.equals("24") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(hrmid),0);
            }else if(fieldtype.equals("32") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"),0);
            }

            if(showid.equals("0")) showid = "" ;

            if(! showid.equals("")){       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
                String tablename=BrowserComInfo.getBrowsertablename(fieldtype);
                String columname=BrowserComInfo.getBrowsercolumname(fieldtype);
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);
                String sql="select "+columname+" from "+tablename+" where "+keycolumname+"="+showid;

                RecordSet.executeSql(sql);
                if(RecordSet.next()) {
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
                        showname =RecordSet.getString(1) ;
                }
            }

            if(fieldtype.equals("2")){                              // �����ťΪ����
                showname = currentdate;
                showid = currentdate;
            }

		    if(isedit.equals("1")){
                if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
	   %>
        <button class=Browser onclick="onShowBrowser('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
       <%       } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
       %>
        <button class=AddDoc onclick="onShowBrowser('<%=fieldid%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" > <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp<button class=AddDoc onclick="onNewDoc(<%=fieldid%>)" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
       <%       }
            }
       %>
        <input type=hidden name="field<%=fieldid%>" value="<%=showid%>">
        <span id="field<%=fieldid%>span"><%=Util.toScreen(showname,user.getLanguage())%>
       <%   if(ismand.equals("1") && showname.equals("")) {
       %>
           <img src="/images/BacoError.gif" align=absmiddle>
       <%
            }
       %>
        </span>
       <%
	    }                                                       // �����ť��������
	    else if(fieldhtmltype.equals("4")) {                    // check��
	   %>
        <input type=checkbox value=1 name="field<%=fieldid%>" <%if(isedit.equals("0")){%> DISABLED <%}%> >
       <%
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
	   %>
        <select class=inputstyle  name="field<%=fieldid%>" <%if(isedit.equals("0")){%> DISABLED <%}%> class=Inputstyle>
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
            char flag= Util.getSeparator() ;
            rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
	   %>
	    <option value="<%=tmpselectvalue%>"><%=tmpselectname%></option>
	   <%
            }
       %>
	    </select>
       <%
        }                                          // ѡ����������� ���������ж�����
       %>
      </td>
    </tr>
	 <TR><TD class=Line colSpan=2></TD></TR>
<%
    }       // ѭ������
%>

    <tr class="Title">
      <td colspan=2 align="center" valign="middle"><font style="font-size:14pt;FONT-WEIGHT: bold"><%=SystemEnv.getHtmlLabelName(17614,user.getLanguage())%></font></td>
    </tr>
    <tr>
      <td><%=SystemEnv.getHtmlLabelName(504,user.getLanguage())%></td>
      <td class=field>
        <textarea class=Inputstyle name=remark id=remark  rows=4 cols=40 style="width=80%" class=Inputstyle></textarea>
       </td>
    </tr>
	 <TR><TD class=Line colSpan=2></TD></TR>
    <%
         if("1".equals(isSignDoc_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signdocids" name="signdocids">
                <button class=Browser onclick="onShowSignBrowser('/docs/docs/MutiDocBrowser.jsp','/docs/docs/DocDsp.jsp?isrequest=1&id=','signdocids','signdocspan',37)" title="<%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%>"></button>
                <span id="signdocspan"></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
     <%
         if("1".equals(isSignWorkflow_add)){
         %>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%></td>
            <td class=field>
                <input type="hidden" id="signworkflowids" name="signworkflowids">
                <button class=Browser onclick="onShowSignBrowser('/workflow/request/MultiRequestBrowser.jsp','/workflow/request/ViewRequest.jsp?isrequest=1&requestid=','signworkflowids','signworkflowspan',152)" title="<%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%>"></button>
                <span id="signworkflowspan"></span>
            </td>
          </tr>
          <tr><td class=Line2 colSpan=2></td></tr>
         <%}%>
  </table>


<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="workflowtype" value="<%=workflowtype%>">       <!--����������-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="0">                     <!--��ǰ�ڵ�����-->
<input type=hidden name="src">                                    <!--�������� save��submit,reject,delete-->
<input type=hidden name="iscreate" value="1">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="topage" value="<%=topage%>">            <!--���������󷵻ص�ҳ��-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name ="method">                                <!--�½��ĵ�ʱ�� method Ϊdocnew-->

<script language=javascript>

function onNewDoc(fieldid) {
    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldid ;
    if(check_form(document.frmmain,'requestname')){
        document.frmmain.src.value='save';
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

    function doSave(){              <!-- ������水ť -->
        if(check_form(document.frmmain,'<%=needcheck%>')){
            if(checktimeok()) {
                document.frmmain.src.value='save';
                //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
    }

    function doSubmit(){            <!-- ����ύ -->
        if(check_form(document.frmmain,'<%=needcheck%>')){
            if(checktimeok()) {
                document.frmmain.src.value='submit';
                document.all("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;
                //�����ϴ�
                        StartUploadAll();
                        checkuploadcomplet();
            }
        }
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
</form>