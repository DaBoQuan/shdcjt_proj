<%@ page import="weaver.workflow.request.RequestConstants" %>
<jsp:useBean id="WorkflowPhrase" class="weaver.workflow.sysPhrase.WorkflowPhrase" scope="page"/>
<%
int colsnum = 25;
int widthper = 4;
%>
<TABLE class="ViewForm" cellPadding=0 cellSpacing=0 >
<COLGROUP>
<% 
	for(int i=0;i<colsnum;i++){
%>
  		<td width="<%=widthper%>%"></td>
<%
	}
%>
<!--�½��ĵ�һ�У�����˵������Ҫ�� -->
 
  <TR>
  
    <TD colspan=2> <%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></TD>
  <td colspan=<%=colsnum-2%> class=field>
    <%if(defaultName==1){%>
      <!--modify by xhheng @20050318 for TD1689-->
      <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" style="width:60%" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit( workflowname+"-"+username+"-"+currentdate,user.getLanguage() )%>" >
      <span id=requestnamespan></span>
    <%}else{%>
      <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" style="width:60%" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "" >
      <span id=requestnamespan><img src="/images/BacoError.gif" align=absmiddle></span>
    <%}%>
	      <input type=radio value="0" name="requestlevel" checked><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
	      <input type=radio value="1" name="requestlevel"><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
	      <input type=radio value="2" name="requestlevel"><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%>
	    </td>
  
   
  </TR>  	   	<TR >
    <TD class="Line1" colSpan=<%=colsnum%>></TD>
  </TR>
  <TR >
    <TD  colSpan=<%=colsnum%>>&nbsp;</TD>
  </TR>
  <!--��һ�н��� -->
  <!--add by xhheng @ 2005/01/24 for ��Ϣ���� Request06�����������п�ʼ -->
  <%
    if(messageType == 1){
  %>
  <TR>
    <TD colspan=2> <%=SystemEnv.getHtmlLabelName(17586,user.getLanguage())%></TD>
    <td colspan=<%=colsnum-2%> class=field>
	      <span id=messageTypeSpan></span>
	      <input type=radio value="0" name="messageType" checked><%=SystemEnv.getHtmlLabelName(17583,user.getLanguage())%>
	      <input type=radio value="1" name="messageType"><%=SystemEnv.getHtmlLabelName(17584,user.getLanguage())%>
	      <input type=radio value="2" name="messageType"><%=SystemEnv.getHtmlLabelName(17585,user.getLanguage())%>
	    </td>
  </TR>  	   	
  <TR><TD class=Line colSpan=2></TD></TR>
  <%}%>
  <!--���������н��� -->  
</table>
<br>
<TABLE class="ViewForm" cellPadding=0 cellSpacing=0 style="border-bottom :3 groove black;border-left :3 groove black;border-right :3 groove black;border-top :3 groove black;">
<colgroup>
<td width=1%></td>
<td width=100%></td>
<td width=1%></td>


<tr>
<td>&nbsp;</td>
<td>


<TABLE class="ViewForm" cellPadding=0 cellSpacing=1>
<COLGROUP>
<% 
	for(int i=0;i<colsnum;i++){
%>
  		<td width="<%=widthper%>%"></td>
<%
	}
%>


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

RecordSet.executeProc("workflow_FieldID_Select",formid+"");
while(RecordSet.next()){
fieldids.add(Util.null2String(RecordSet.getString(1)));
fieldorders.add(Util.null2String(RecordSet.getString(2)));
}

RecordSet.executeProc("workflow_FieldLabel_Select",formid+"");
while(RecordSet.next()){
fieldlabels.add(Util.null2String(RecordSet.getString("fieldlable")));
languageids.add(Util.null2String(RecordSet.getString("languageid")));
	//out.println("<b>LANGUAGE:"+Util.null2String(RecordSet.getString("languageid"))+"</b>");
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



String rowCalItemStr1,colCalItemStr1,mainCalStr1;
				rowCalItemStr1 = new String("");
				colCalItemStr1 = new String("");
			
				mainCalStr1 = new String("");

				rs.executeProc("Workflow_formdetailinfo_Sel",formid+"");
				while(rs.next()){
					rowCalItemStr1 = Util.null2String(rs.getString("rowCalStr"));
					colCalItemStr1 = Util.null2String(rs.getString("colCalStr"));
					mainCalStr1 = Util.null2String(rs.getString("mainCalStr"));
                    //System.out.println("rowCalItemStr1 = " + rowCalItemStr1);
				}

                // Ҫ�����ƶ���ȡ���ֶ�

                //autoGetIndex[0] = 1;
                //autoGetIndex[1] = 2;
                //autoGetIndex[2] = 3;
                //autoGetIndex[3] = 5;
				//Clone the ArrayList Objects
				ArrayList fieldids1 =new ArrayList(); 
				ArrayList fieldlabels1=new ArrayList();
				ArrayList fieldhtmltypes1=new ArrayList();
				ArrayList fieldtypes1=new ArrayList();
				ArrayList fieldnames1=new ArrayList();
				ArrayList fieldviewtypes1=new ArrayList();
				ArrayList isfieldids1=new ArrayList();
				ArrayList isviews1=new ArrayList();
				ArrayList isedits1=new ArrayList();
				ArrayList ismands1=new ArrayList();

			//	fieldids1 = (ArrayList)fieldids.clone();
			//	fieldlabels1=(ArrayList)fieldlabels.clone();
			//	fieldhtmltypes1=(ArrayList)fieldhtmltypes.clone();
			//	fieldtypes1=(ArrayList)fieldtypes.clone();
			//	fieldnames1=(ArrayList)fieldnames.clone();
			//	fieldviewtypes1=(ArrayList)fieldviewtypes.clone();
			//	isfieldids1=(ArrayList)isfieldids.clone();
			//	isviews1=(ArrayList)isviews.clone();
			//	isedits1=(ArrayList)isedits.clone();
			//	ismands1 =(ArrayList)ismands.clone();
				
                int colcount1 = 0;
                int colwidth1 = 0;
            //    fieldids.clear();
            //    fieldlabels.clear();
            //    fieldhtmltypes.clear();
             //   fieldtypes.clear();
             //   fieldnames.clear();
            //    fieldviewtypes.clear();


				  // ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
            //    isfieldids.clear();              //�ֶζ���
            //    isviews.clear();              //�ֶ��Ƿ���ʾ����
            //    isedits.clear();              //�ֶ��Ƿ���Ա༭����
            //    ismands.clear();              //�ֶ��Ƿ�����������

				Integer language_id = new Integer(user.getLanguage());
				//System.out.println(formid+Util.getSeparator()+nodeid);
				
				
int colindex = 0;
int rowindex = 0;
int lastpty = 0;
int lastformid = 0;
String formscripts = "";
	
int thisformcols = 1;

int hasshowdetail = 0;
int showrequestname = 0;

ArrayList ptxs = new ArrayList();
ArrayList ptys = new ArrayList();
ArrayList widths = new ArrayList();
ArrayList heights = new ArrayList();

//modify by xhheng @20050302 for TD 1695
boolean isoracle = (rs.getDBType()).equals("oracle");
String sqlFormprop = "";
if (isoracle) {
  sqlFormprop = "select objtype,isdetail,objid,fieldid,attribute2,attribute1,defvalue,trunc(Round((trunc(ptx)-30)/30.0,0)*30) as ptx1,trunc(Round((trunc(pty)-30)/30.0,0)*30) as pty1,trunc(Round(trunc(width)/30.0,0)*30) as width1,trunc(Round(trunc(height)/30.0,0)*30) as height1 from workflow_formprop where formid="+formid+"order by trunc(pty),trunc(ptx)";
}else{
  sqlFormprop = "select convert(int,Round((convert(int,ptx)-30)/30.0,0)*30) as ptx1,convert(int,Round((convert(int,pty)-30)/30.0,0)*30) as pty1,convert(int,Round(convert(int,width)/30.0,0)*30) as width1,convert(int,Round(convert(int,height)/30.0,0)*30) as height1,* from workflow_formprop where formid="+formid+" order by convert(int,pty),convert(int,ptx)";
}

RecordSet.executeSql(sqlFormprop);
while(RecordSet.next()){
	if(RecordSet.getInt("objtype")==0)
		continue;
	int thisformid = Util.getIntValue(RecordSet.getString("isdetail"),0);
	
	if(thisformid!=0 && hasshowdetail != 0) {		
		continue;
	}
	
	int ptx = RecordSet.getInt("ptx1");
	int pty = RecordSet.getInt("pty1");
	int width = RecordSet.getInt("width1");
	int height = RecordSet.getInt("height1");
		
	int _bRowindexStep = 0;	
	int _eRowindexStep = 0;	
	int _eRowindexStepLast = 0;
	int _ptx0 = 0;
	int _pty0 = 0;
	int _width0 = 0;
	int _height0 = 0;
	int _arraysize = ptxs.size();	
	if(_arraysize>1){
		_ptx0 = Util.getIntValue(""+ptxs.get(_arraysize-1),0);
		_pty0= Util.getIntValue(""+ptys.get(_arraysize-1),0);
		_width0 = Util.getIntValue(""+widths.get(_arraysize-1),0);
		_height0 = Util.getIntValue(""+heights.get(_arraysize-1),0);
	}
	
	for(int i=0;i<_arraysize;i++){
		int _ptx = Util.getIntValue(""+ptxs.get(i),0);
		int _pty = Util.getIntValue(""+ptys.get(i),0);
		int _width = Util.getIntValue(""+widths.get(i),0);
		int _height = Util.getIntValue(""+heights.get(i),0);
		
		if((_pty+_height)>_pty0){
			if(_ptx>_ptx0)	_eRowindexStepLast += _width/30;	
		}
		
		if((_pty+_height)>pty){
			if(_ptx<ptx)	_bRowindexStep += _width/30;
			else		_eRowindexStep += _width/30;	
		}	
	}
	
	if(thisformid!=0 && hasshowdetail == 0){
	
		for(;rowindex<(colsnum-_eRowindexStepLast);rowindex++){
			out.print("<td></td>");
		}		
		rowindex=colsnum;
		out.print("</tr><tr height='24'><td colspan='"+colsnum+"'>");	
		
		%>
		
  <!--##############����ϸ��ʼ-#############-->
    <%
				//�õ����㹫ʽ���ַ���

		ArrayList formdetailwidths = new ArrayList();
		String sqlSelformdetailfield = "SELECT convert(int,Round(formprop.width/30.0,0)*30) as width,formfield.fieldid,formfield.fieldorder, fieldlable.fieldlable,fieldlable.langurageid, nodeform.isview,nodeform.isedit,nodeform.ismandatory, dictdetail.fieldname,dictdetail.fielddbtype,dictdetail.fieldhtmltype,dictdetail.type ";
		
		sqlSelformdetailfield += " FROM  Workflow_formfield formfield, Workflow_nodeform nodeform, Workflow_fieldlable fieldlable, Workflow_formdictdetail dictdetail ,Workflow_formprop formprop ";
		sqlSelformdetailfield += " where formfield.formid = "+formid+" and nodeform.nodeid =   "+nodeid;
		sqlSelformdetailfield += " and formfield.fieldid = nodeform.fieldid  ";
		sqlSelformdetailfield += " and formfield.fieldid = fieldlable.fieldid  ";
		sqlSelformdetailfield += " and formfield.formid = fieldlable.formid  ";
		sqlSelformdetailfield += " and formfield.fieldid = dictdetail.id  ";
		sqlSelformdetailfield += " and formfield.isdetail = '1'   ";
		sqlSelformdetailfield += " and formprop.formid = formfield.formid ";
		sqlSelformdetailfield += " and formprop.fieldid = formfield.fieldid  ";
		sqlSelformdetailfield += "  Order by formprop.ptx   ";
	
		rs.executeSql(sqlSelformdetailfield);
             //   rs.executeProc("Workflow_formdetailfield_Sel",""+formid+Util.getSeparator()+nodeid);
                while (rs.next()) {

					 if(language_id.toString().equals(Util.null2String(rs.getString("langurageid"))))
						{
						fieldids1.add(Util.null2String(rs.getString("fieldid")));
						fieldlabels1.add(Util.null2String(rs.getString("fieldlable")));
						fieldhtmltypes1.add(Util.null2String(rs.getString("fieldhtmltype")));
						fieldtypes1.add(Util.null2String(rs.getString("type")));
						isviews1.add(Util.null2String(rs.getString("isview")));
						isedits1.add(Util.null2String(rs.getString("isedit")));
						ismands1.add(Util.null2String(rs.getString("ismandatory")));
						fieldnames1.add(Util.null2String(rs.getString("fieldname")));
						formdetailwidths.add(Util.null2String(rs.getString("width")));
						colcount1 ++ ;
						}
                }
				//	out.println("size:"+fieldids.size());
                //for (int i = 0; i < autoGetIndex.length; i++) {
                //    autoGetDataId += "-" + fieldids.get(autoGetIndex[i]);
                //}
               

				//System.out.println("colcount1 = "+colcount1);
                if (colcount1 != 0) {

					colwidth1 = 95 / colcount1;
            %>
 <table class=form>
        <tr><td height=15></td></tr>
        <tr>
            <td>
            <BUTTON Class=Btn type=button accessKey=A onclick="addRow()"><U>A</U>-���</BUTTON>
            <BUTTON Class=Btn type=button accessKey=E onclick="if(isdel()){deleteRow1();}"><U>E</U>-ɾ��</BUTTON>

            </td>
        </tr>
        <tr>
            <td>

            <table Class=ListStyle id="oTable" >
              <COLGROUP>
              <TBODY>
              <tr class=header>
                <td width="5%">&nbsp;</td>
   <%
       ArrayList viewfieldnames = new ArrayList();

       // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ

       int detailfieldcount = -1;

       for (int i = 0; i < fieldids1.size(); i++) {         // ѭ����ʼ

          String fieldid=(String)fieldids1.get(i);  //�ֶ�id
		  String isview=(String)isviews1.get(i);     //�ֶ��Ƿ���ʾ
		  String isedit=(String)isedits1.get(i);   //�ֶ��Ƿ���Ա༭
		  String ismand=(String)ismands1.get(i);   //�ֶ��Ƿ��������
		  String fieldlable =(String)fieldlabels1.get(i);
		  String fieldname = (String)fieldnames1.get(i);
		  String fieldhtmltype = (String) fieldhtmltypes1.get(i);
		  if( ! isview.equals("1") ) continue;  //����ʾ��������һ��ѭ��

		int _widthdetail = Util.getIntValue((String)formdetailwidths.get(i),0);
		colwidth1 = (_widthdetail*10)/75;
           viewfieldnames.add(fieldname);
   %>
                <td width="<%=colwidth1%>%" nowrap><%=fieldlable%></td>
           <%
       }
%>
              </tr>
              </TBODY>
              <TFOOT>
              <TR class=header>
                <TD >�ϼ�</TD>
<%
    for (int i = 0; i < fieldids1.size(); i++) {
    	int _widthdetail = Util.getIntValue((String)formdetailwidths.get(i),0);
		colwidth1 = (_widthdetail*10)/75;
        if (!isviews1.get(i).equals("1")) {
%>
                <td width="<%=colwidth1%>%" id="sum<%=fieldids1.get(i)%>" style="display:none"></td>
                <input type="hidden" name="sumvalue<%=fieldids1.get(i)%>" >
            <%
        } else {
            %>
                <td width="<%=colwidth1%>%" id="sum<%=fieldids1.get(i)%>" ></td>
                <input type="hidden" name="sumvalue<%=fieldids1.get(i)%>" >
                    <%
        }
    }
                    %>
              </TR>
              </TFOOT>
            </table>
            </td>
        </tr>

</table>
<input type='hidden' name=colcalnames value="<%=colCalItemStr1%>">
<input type='hidden' id=nodesnum name=nodesnum>

<!-- modify by xhheng @20050323 for TD 1703-->
<INPUT type="hidden" name="needcheck" value="<%=needcheck%>">		<!--the need check html object name-->

<script language=javascript>
function addRow()
{

    oRow = oTable.insertRow(-1);
    oCell = oRow.insertCell(-1);
    oCell.style.height=24;
    oCell.style.background= "#E7E7E7";
    //oCell.style.word-wrap= "normal";

    var oDiv = document.createElement("div");
    var sHtml = "<input type='checkbox' name='check_node' value='"+rowindex+"'>";
    oDiv.innerHTML = sHtml;
    oCell.appendChild(oDiv);

<%
    needcheck="";
    for (int i = 0; i < fieldids1.size(); i++) {         // ѭ����ʼ

        String fieldhtml = "";
        String fieldid = (String) fieldids1.get(i);  //�ֶ�id


	    String isview=(String)isviews1.get(i);     //�ֶ��Ƿ���ʾ
	    String isedit=(String)isedits1.get(i);   //�ֶ��Ƿ���Ա༭
	    String ismand=(String)ismands1.get(i);   //�ֶ��Ƿ��������


        if (!isview.equals("1")) continue;           //����ʾ��������һ��ѭ��

        String fieldname = "";                         //�ֶ����ݿ���е��ֶ���
        String fieldhtmltype = "";                     //�ֶε�ҳ������
        String fieldtype = "";                         //�ֶε�����
        String fieldlable = "";                        //�ֶ���ʾ��
        int languageid = user.getLanguage();
        fieldname = (String) fieldnames1.get(i);
        fieldhtmltype = (String) fieldhtmltypes1.get(i);
        fieldtype = (String) fieldtypes1.get(i);
	
        if (ismand.equals("1")) 
          needcheck += ",field" + fieldid + "_\"+rowindex+\"";   //�����������,�����������ļ����

        // ���濪ʼ������ʾ�ֶ�

        if (fieldhtmltype.equals("1")) {                          // �����ı���
            if (fieldtype.equals("1")) {                          // �����ı����е��ı�
                if (isedit.equals("1")) {
                    if (ismand.equals("1")) {
                        fieldhtml = "<input datatype='text' type=text name='field" + fieldid + "_\"+rowindex+\"' size=7 onChange='checkinput1(field" + fieldid + "_\"+rowindex+\",field" + fieldid + "_\"+rowindex+\"span)'><span id='field" + fieldid + "_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>";
                    } else {
                        fieldhtml = "<input datatype='text' type=text name='field" + fieldid + "_\"+rowindex+\"' value='' size=7>";
                    }
                } else {
                    fieldhtml = "<span id='fieldspan" + fieldid + "_\"+rowindex+\"'> </span>";
                    fieldhtml += "<input type=hidden name='field" + fieldid + "_\"+rowindex+\"'>";
                }
            } else if (fieldtype.equals("2")) {              // �����ı����е�����
                if (isedit.equals("1")) {
                    if (ismand.equals("1")) {

                        fieldhtml = "<input datatype='int' type=text name='field" + fieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this);checkinput1(field" + fieldid + "_\"+rowindex+\",field" + fieldid + "_\"+rowindex+\"span);calSum()'><span id='field" + fieldid + "_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>";
                    } else {

                        fieldhtml = "<input datatype='int' datatype='float' type=text name='field" + fieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this);calSum()'>";
                    }
                } else {
                    fieldhtml = "<span id='fieldspan" + fieldid + "_\"+rowindex+\"'> </span>";
                    fieldhtml += "<input type=hidden name='field" + fieldid + "_\"+rowindex+\"'>";
                }
            } else if (fieldtype.equals("3")) {                     // �����ı����еĸ�����
                if (isedit.equals("1")) {
                    if (ismand.equals("1")) {
                        fieldhtml = "<input datetype='float' type=text name='field" + fieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);checkinput1(field" + fieldid + "_\"+rowindex+\",field" + fieldid + "_\"+rowindex+\"span);calSum()'><span id='field" + fieldid + "_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>";
                    } else {
                        fieldhtml = "<input datetype='float' type=text name='field" + fieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);calSum()'>";
                    }
                } else {
                    fieldhtml = "<span id='fieldspan" + fieldid + "_\"+rowindex+\"'> </span>";
                    fieldhtml += "<input type=hidden name='field" + fieldid + "_\"+rowindex+\"'>";
                }
            }
        }                                                       // �����ı�����������
        else if (fieldhtmltype.equals("2")) {                     // �����ı���
            if (isedit.equals("1")) {
                if (ismand.equals("1")) {
                    fieldhtml = "<textarea name='field" + fieldid + "_\"+rowindex+\"' onChange='checkinput1(field" + fieldid + "_\"+rowindex+\",field" + fieldid + "_\"+rowindex+\"span)' rows='4' cols='40' style='width:80%'></textarea><span id='field" + fieldid + "_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>";
                } else {
                    fieldhtml = "<textarea name='field" + fieldid + "_\"+rowindex+\"' rows='4' cols='40' style='width:80%'></textarea>";
                }
            } else {
                fieldhtml = "<span id='fieldspan" + fieldid + "_\"+rowindex+\"'> </span>";
                fieldhtml += "<input type=hidden name='field" + fieldid + "_\"+rowindex+\"'>";
            }
        }                                                           // �����ı�����������
        else if (fieldhtmltype.equals("3")) {                         // �����ť (�漰workflow_broswerurl��)
            String url = BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl = BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
            String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
            String showid = "";                                     // �½�ʱ��Ĭ��ֵ

            if (fieldtype.equals("8") && !prjid.equals("")) {       //�����ťΪ��Ŀ,��ǰ��Ĳ����л����ĿĬ��ֵ
                showid = "" + Util.getIntValue(prjid, 0);
            } else if ((fieldtype.equals("9") || fieldtype.equals("37")) && !docid.equals("")) { //�����ťΪ�ĵ�,��ǰ��Ĳ����л���ĵ�Ĭ��ֵ
                showid = "" + Util.getIntValue(docid, 0);
            } else if ((fieldtype.equals("1") || fieldtype.equals("17")) && !hrmid.equals("")) { //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(hrmid, 0);
            } else if ((fieldtype.equals("7") || fieldtype.equals("18")) && !crmid.equals("")) { //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
                showid = "" + Util.getIntValue(crmid, 0);
            }else if((fieldbodytype.equals("16") || fieldbodytype.equals("152")) && !reqid.equals("")){ //�����ťΪREQ,��ǰ��Ĳ����л��REQĬ��ֵ
                showid = "" + Util.getIntValue(reqid,0);
            } else if (fieldtype.equals("4") && !hrmid.equals("")) { //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(hrmid), 0);
            } else if (fieldtype.equals("24") && !hrmid.equals("")) { //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(hrmid), 0);
            } else if (fieldtype.equals("32") && !hrmid.equals("")) { //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"), 0);
            }

            if (showid.equals("0")) showid = "";

            if (!showid.equals("")) {       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
                String tablename = BrowserComInfo.getBrowsertablename(fieldtype);
                String columname = BrowserComInfo.getBrowsercolumname(fieldtype);
                String keycolumname = BrowserComInfo.getBrowserkeycolumname(fieldtype);
                String sql = "select " + columname + " from " + tablename + " where " + keycolumname + "=" + showid;

                rs.executeSql(sql);
                if (rs.next()) {
                    if (!linkurl.equals(""))
                    {
        				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                    	{
                    		showname = "<a href='javaScript:openhrm(" + tmpid + ");' onclick='pointerXY(event);'>" + RecordSet.getString(1) + "</a>&nbsp";
                    	}
        				else
        					showname = "<a href='"+linkurl+tmpid+"'>"+RecordSet.getString(1)+"</a>&nbsp";
        			}
                    else
                        showname = rs.getString(1);
                }
            }

            if (fieldtype.equals("2")) {                              // �����ťΪ����
                showname = currentdate;
                showid = currentdate;
            }

            if (isedit.equals("1")) {
                //System.out.println("url = " + url);
                if (!fieldtype.equals("37")) {    //  ���ĵ����⴦��
                    fieldhtml = "<button class=Browser onclick=\\\"onShowBrowser2('" + fieldid + "_\"+rowindex+\"','" + url + "','" + linkurl + "','" + fieldtype + "','" + ismand + "')\\\" title='" + SystemEnv.getHtmlLabelName(172, user.getLanguage()) + "'></button>";
                } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                    fieldhtml = "<button class=AddDoc onclick=\\\"onShowBrowser2('" + fieldid + "_\"+rowindex+\"','" + url + "','" + linkurl + "','" + fieldtype + "','" + ismand + "')\\\">" + SystemEnv.getHtmlLabelName(611, user.getLanguage()) + "</button>&nbsp;&nbsp<button class=AddDoc onclick=\\\"onNewDoc('" + fieldid + "_\"+rowindex+\"')\\\" title='" + SystemEnv.getHtmlLabelName(82, user.getLanguage()) + "'>" + SystemEnv.getHtmlLabelName(82, user.getLanguage()) + "</button>";
                }
            }
            fieldhtml += "<input type=hidden name='field" + fieldid + "_\"+rowindex+\"' value='" + showid + "'><span id='field" + fieldid + "_\"+rowindex+\"span'>" + Util.toScreen(showname, user.getLanguage());

            if (ismand.equals("1") && showname.equals("")) {
                fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
            }
            fieldhtml += "</span>";
        }                                                       // �����ť��������
        else if (fieldhtmltype.equals("4")) {                    // check��
            fieldhtml += "<input type=checkbox value=1 name='field" + fieldid + "_\"+rowindex+\"' ";

            if (isedit.equals("0")) fieldhtml += "DISABLED";

            fieldhtml += ">";
        }                                                       // check����������
        else if (fieldhtmltype.equals("5")) {                     // ѡ���   select
            fieldhtml += "<select name='field" + fieldid + "_\"+rowindex+\"' ";
            if (isedit.equals("0")) fieldhtml += "DISABLED";
            fieldhtml += ">";

            // ��ѯѡ�������п���ѡ���ֵ
            char flag = Util.getSeparator();
            rs.executeProc("workflow_SelectItemSelectByid", "" + fieldid + flag + isbill);
            while (rs.next()) {
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"), user.getLanguage());
                fieldhtml += "<option value='" + tmpselectvalue + "'>" + tmpselectname + "</option>";
            }
            fieldhtml += "</select>";
        }                                          // ѡ����������� ���������ж�����
%>


        oCell = oRow.insertCell(-1);
        oCell.style.height=24;
        oCell.style.background= "#E7E7E7";

        var oDiv = document.createElement("div");
        var sHtml = "<%=fieldhtml%>" ;
        //alert(sHtml);
        oDiv.innerHTML = sHtml;
        oCell.appendChild(oDiv);
        <%
			//System.out.println("field type:"+fieldtype);
    }       // ѭ������
%>
    if ("<%=needcheck%>" != ""){
        document.getElementById("needcheck").value += "<%=needcheck%>";
    }

    rowindex = rowindex*1 +1;
    curindex = curindex*1 +1;
    document.frmmain.nodesnum.value = rowindex ;


}


function deleteRow1()
{

    len = document.forms[0].elements.length;
    var i=0;
    var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
        if (document.forms[0].elements[i].name=='check_node')
            rowsum1 += 1;
    }
    for(i=len-1; i >= 0;i--) {
        if (document.forms[0].elements[i].name=='check_node'){
            if(document.forms[0].elements[i].checked==true) {
                oTable.deleteRow(rowsum1);
                curindex--;
            }
            rowsum1 -=1;

        }
    }
}
</script>
<SCRIPT LANGUAGE="VBS">
sub onShowBrowser2(id,url,linkurl,type1,ismand)
    if type1= 2 or type1 = 19 then
        id1 = window.showModalDialog(url,,"dialogHeight:320px;dialogwidth:275px")
        document.getElementById("field"+id+"span").innerHtml = id1
        document.getElementById("field"+id).value=id1
    else
        if type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
            id1 = window.showModalDialog(url)
		elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.getElementById("field"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
        else
            tmpids = document.getElementById("field"+id).value
            id1 = window.showModalDialog(url&"?resourceids="&tmpids)
        end if
        if NOT isempty(id1) then
            if type1 = 17 or type1 = 18 or type1=27 or type1=37 then
                if id1(0)<> ""  and id1(0)<> "0" then
                    resourceids = id1(0)
                    resourcename = id1(1)
                    sHtml = ""
                    resourceids = Mid(resourceids,2,len(resourceids))
                    document.getElementById("field"+id).value= resourceids
                    resourcename = Mid(resourcename,2,len(resourcename))
                    while InStr(resourceids,",") <> 0
                        curid = Mid(resourceids,1,InStr(resourceids,",")-1)
                        curname = Mid(resourcename,1,InStr(resourcename,",")-1)
                        resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
                        resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
                        if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
							sHtml = sHtml&"<a href=javaScript:openhrm("&curid&"); onclick='pointerXY(event);'>"&curname&"</a>&nbsp"
						else
							sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					end if
                    wend
					if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
						sHtml = sHtml&"<a href=javaScript:openhrm("&resourceids&"); onclick='pointerXY(event);'>"&resourcename&"</a>&nbsp"
					else
						sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					end if
                    document.getElementById("field"+id+"span").innerHtml = sHtml

                else
                    if ismand=0 then
                        document.getElementById("field"+id+"span").innerHtml = empty
                    else
                        document.getElementById("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
                    end if
                    document.getElementById("field"+id).value=""
                end if

            else
               if  id1(0)<>""   and id1(0)<> "0"  then
                  
                    if linkurl = "" then
                        document.getElementById("field"+id+"span").innerHtml = id1(1)
                    else
						if linkurl = "/hrm/resource/HrmResource.jsp?id=" then
							document.getElementById("field"+id+"span").innerHtml = "<a href=javaScript:openhrm("&id1(0)&"); onclick='pointerXY(event);'>"&id1(1)&"</a>&nbsp"
						else
							document.getElementById("field"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
						end if
                        
                    end if
                    document.getElementById("field"+id).value=id1(0)
                else
                    if ismand=0 then
                        document.getElementById("field"+id+"span").innerHtml = empty
                    else
                        document.getElementById("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
                    end if
                    document.getElementById("field"+id).value=""
                end if
            end if
        end if
    end if
end sub

</script>

<%
    ArrayList rowCalAry = new ArrayList();
    ArrayList rowCalSignAry = new ArrayList();
    ArrayList colCalAry = new ArrayList();
	ArrayList mainCalAry = new ArrayList();
    ArrayList tmpAry = null;


    StringTokenizer stk = new StringTokenizer(colCalItemStr1,";");
    while(stk.hasMoreTokens()){
        colCalAry.add(stk.nextToken());
    }
	StringTokenizer stk2 = new StringTokenizer(rowCalItemStr1,";");
	//out.println(rowCalItemStr1);

	ArrayList newRowCalArray = new ArrayList();

	while(stk2.hasMoreTokens()){
		//out.println(stk2.nextToken(";"));
		rowCalAry.add(stk2.nextToken(";"));
	}
	stk2 = new StringTokenizer(mainCalStr1,";");
	while(stk2.hasMoreTokens()){
		//out.println(stk2.nextToken(";"));
		mainCalAry.add(stk2.nextToken(";"));
	}
	//out.println(mainCalStr1);

%>

<%--<iframe name=productInfo style="width:100%;height:300;display:none"></iframe>--%>
<script language="javascript">
rowindex = 0 ;
curindex = 0 ;

<%--added by Charoes Huang FOR Bug 625--%>
function parse_Float(i){
	try{
	    i =parseFloat(i);
		if(i+""=="NaN")
			return 0;
		else
			return i;
	}catch(e){
		return 0;
	}
}

function calSumPrice(){

    var temv1;
    var evt = getEvent();
    //alert(rowindex);
<%
    String temStr = "";
    for(int i=0; i<rowCalAry.size(); i++){
        temStr = "";
		String calExp = (String)rowCalAry.get(i);

%>
    //for( i=0; i<rowindex; i++){
        try{
			
			var i = jQuery((evt.srcElement ? evt.srcElement : evt.target)).parent().parent().parent()[0].rowIndex - 1;//ֻ���㵱ǰ�е�ֵ
			//alert(window.event.srcElement.name);
        <%
           for(int j=0;j<fieldids1.size();j++){
				temStr = (String)fieldids1.get(j);
				int idx1 = calExp.indexOf("=");
				int idx2 = calExp.indexOf("detailfield_"+temStr);
				if(idx2<idx1){
					calExp = Util.StringReplace(calExp,"detailfield_"+temStr,"document.getElementById(\"field"+temStr+"_\"+i).value ");
				}else{
					calExp = Util.StringReplace(calExp,"detailfield_"+temStr,"parse_Float(document.getElementById(\"field"+temStr+"_\"+i).value) ");
				}
			
			}
			String targetStr =calExp.substring(0,calExp.indexOf("value")-1);
			//targetStr = targetStr.substring(0,targetStr.indexOf("_"));
			out.println("var tempObjName = getObjectName("+targetStr+",\"_\")");

			out.println("if(window.event.srcElement.name.toString().indexOf(tempObjName)==-1){");
            out.println(calExp+"; ") ;
			out.println("if("+calExp.substring(0,calExp.indexOf("value")-1)+".datatype=='int') "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("="))+",0);else "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("="))+",3);}");
	        %>

       }catch(e){}
   //}
<%
    }
%>
}

function setProductInfo(fieldId,rowIndex,pValue){
    //alert(fieldId+"  "+pValue);
    document.getElementById("field"+fieldId+"_"+rowIndex).value=pValue;
    if(document.getElementById("fieldspan"+fieldId+"_"+rowIndex)){
        document.getElementById("fieldspan"+fieldId+"_"+rowIndex).innerHTML=pValue;
    }

}

function calMainField(){
	<%
		for(int i=0;i<mainCalAry.size();i++){
			temStr = "";
			String str2 =  mainCalAry.get(i).toString();
		    int idx = str2.indexOf("=");
			String str3 = str2.substring(0,idx);
			str3 = str3.substring(str3.indexOf("_")+1);
			String str4 = str2.substring(idx);
			str4 = str4.substring(str4.indexOf("_")+1);

	%>
		   var sum=0;
		   var temStr;
			for(i=0; i<rowindex; i++){

				try{
					temStr=document.getElementById("field<%=str4%>_"+i).value;
					if(temStr+""!=""){
						sum+=temStr*1;
					}
				}catch(e){;}
			}
		
			  if(document.getElementById("field<%=str3%>").datatype+''=="int")
				 document.getElementById("field<%=str3%>").value=toPrecision(sum,0);
			  else
				 document.getElementById("field<%=str3%>").value=toPrecision(sum,3);

		

	<%
	}
	%>

}
function calSum(){

    calSumPrice();

    var sum=0;
    var temStr;
<%
    for(int i=0; i<colCalAry.size(); i++){
        temStr = "";
		String str = colCalAry.get(i).toString();
		str = str.substring(str.indexOf("_")+1);
%>
    sum=0;
    for(i=0; i<rowindex; i++){

        try{
            temStr=document.getElementById("field<%=str%>_"+i).value;
            if(temStr+""!=""){
                sum+=temStr*1;
            }
        }catch(e){;}
    }
    document.getElementById("sum<%=str%>").innerHTML=toPrecision(sum,3)+"&nbsp;"
    document.getElementById("sumvalue<%=str%>").value=toPrecision(sum,3)
<%
    }
%>
	calMainField();
}

/**
return a number with a specified precision.
*/
function toPrecision(aNumber,precision){
	var temp1 = Math.pow(10,precision);
	var temp2 = new Number(aNumber);

	return isNaN(Math.round(temp1*temp2) /temp1)?0:Math.round(temp1*temp2) /temp1 ;
}
/**

��"field142_0" �õ���field142
*/

function getObjectName(obj,indexChar){
	var tempStr = obj.name.toString();
	return tempStr.substring(0,tempStr.indexOf(indexChar)>=0?tempStr.indexOf(indexChar):tempStr.length);
}
</script>
  <!--##############����ϸ�����-#############-->

  <%}//(colcount1 != 0)  end%>

</td>		
		
		<%
		hasshowdetail = 1;
		colindex ++;
		continue;
	}	
	
	int objtype = RecordSet.getInt("objtype");
	String objid=RecordSet.getString("objid");
	String fieldid = Util.null2String(RecordSet.getString("fieldid"));
	
	
	if(lastpty != pty){
		for(;rowindex<(colsnum-_eRowindexStepLast);rowindex++){
			out.print("<td></td>");
		}
		rowindex = 0;
		colindex ++;		
		out.print("</tr>");
	}	
	for(;colindex<(pty/30);colindex++){
		out.print("<tr height='24'>");
		for(int i=0;i<(colsnum-_bRowindexStep-_eRowindexStep);i++)
			out.print("<td></td>");
		out.print("</tr>");					
	}
	
	
	if(rowindex ==0){			
		out.print("<tr height='24' >");	
		rowindex += _bRowindexStep;
	}
	for(;rowindex<(ptx/30);rowindex++){
		out.print("<td></td>");
	}
	int _widthcols = width/30;
	rowindex += _widthcols;
	
	//print Items...
	
	String isview="0" ;    //�ֶ��Ƿ���ʾ
	String isedit="0" ;    //�ֶ��Ƿ���Ա༭
	String ismand="0" ;    //�ֶ��Ƿ��������
	
	String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
	String fieldhtmltype = "" ;                     //�ֶε�ҳ������
	String fieldtype = "" ;                         //�ֶε�����
	String fieldlable = "" ;                        //�ֶ���ʾ��
	int languageid = 0 ;
	
	if(!fieldid.equals("")){
		int isfieldidindex = isfieldids.indexOf(fieldid) ;
		if( isfieldidindex != -1 ) {
		isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
		    isedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
		    ismand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
		}
	
		if( !isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��
	
	
		int tmpindex = fieldids.indexOf(fieldid);
		languageid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
		fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
		fieldtype=FieldComInfo.getFieldType(fieldid);
		fieldlable=(String)fieldlabels.get(tmpindex);
		fieldname=FieldComInfo.getFieldname(fieldid);
	
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
		
		int _tmpcols = 1;
		if(_widthcols > 4) 
			_tmpcols = 2;
		
		out.print("<td colspan='"+_tmpcols+"' rowspan='"+height/30+"'  style='border-bottom :1 groove black;border-left :1 groove black;border-top :1 groove black;'><b>"+Util.toScreen(fieldlable,languageid)+"</b></td>");		
		
		_widthcols = _widthcols-_tmpcols;
		if(_widthcols<1)
			_widthcols = 1;
			
		String _fontsize = Util.null2String(RecordSet.getString("attribute2"));
			if(!_fontsize.equals(""))				
				_fontsize = " background-color:"+_fontsize+";";	
			
				
		out.print("<td colspan='"+_widthcols+"'  class=field rowspan='"+height/30+"' style='"+_fontsize+"border-bottom :1 groove black;border-right :1 groove black;border-top :1 groove black;'>");
	}else
		out.print("<td colspan='"+_widthcols+"' rowspan='"+height/30+"'>");
	
	
	
	
	if(objtype == 1){ 
		String _fontsize = Util.null2String(RecordSet.getString("attribute1"));
			if(!_fontsize.equals(""))
				_fontsize = " font-size:"+_fontsize;
		String _colorbold = Util.null2String(RecordSet.getString("attribute2"));
			String _color="black";
			String _isbold = " font-weight:bold ";
			
			int tmppos = _colorbold.indexOf(":");
			if(tmppos != -1){
				_color=_colorbold.substring(0,tmppos);
				
				String _tmpstr = _colorbold.substring(tmppos);
				if(!_tmpstr.equals(":1") || _tmpstr.equals(""))
					_isbold = " font-weight:normal ";
			}
			
			
		%>
		<span style='color:<%=_color%>;<%=_fontsize%>;<%=_isbold%>'><%=Util.toHtml(RecordSet.getString("defvalue"))%></span>					
		<%
	}else if(objtype == 2){
		String _src = Util.null2String(RecordSet.getString("defvalue"));
		if(!_src.equals("")){%>
			<img src="<%=_src%>" border="<%=Util.getIntValue(RecordSet.getString("attribute1"),0)%>"  >	
		<%}
	}else if(objtype == 3){
	
		String _defvalue = RecordSet.getString("defvalue");
		if(!isedit.equals("1")){ 
			out.print("<span>"+_defvalue+"</span>");			
		}else if(ismand.equals("1")) {
			if(fieldtype.equals("1")){ 
		%>
			<input datatype="text" type=text class=Inputstyle name="field<%=fieldid%>" value="<%=_defvalue%>" style="width:90%" onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
        		<span id="field<%=fieldid%>span"><%if(_defvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
     		<%	}else if(fieldtype.equals("2")){ 	%>
			<input  datatype="int" type=text class=Inputstyle name="field<%=fieldid%>" value="<%=_defvalue%>"  style="width:90%"
			onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
			<span id="field<%=fieldid%>span"><%if(_defvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
		<%	}else if(fieldtype.equals("3")){ 	%>
			<input datatype="float" type=text class=Inputstyle name="field<%=fieldid%>"  value="<%=_defvalue%>"  style="width:90%"
			onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('field<%=fieldid%>','field<%=fieldid%>span')">
			<span id="field<%=fieldid%>span"><%if(_defvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
		<%	} 	%>
		<%}else{
			if(fieldtype.equals("1")){ 
		%>
     			<input datatype="text" type=text class=Inputstyle name="field<%=fieldid%>"  value="<%=_defvalue%>"   style="width:90%">
     		<%	}else if(fieldtype.equals("2")){ 	%>
     		        <input  datatype="int" type=text class=Inputstyle name="field<%=fieldid%>"  value="<%=_defvalue%>"   style="width:90%" onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
		<%	}else if(fieldtype.equals("3")){ 	%>
        		<input datatype="float" type=text class=Inputstyle name="field<%=fieldid%>"  value="<%=_defvalue%>"  style="width:90%" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
		<%	}	%>			  
      		<%}				
	}else if(objtype == 4){
		
		String _defvalue = RecordSet.getString("defvalue");
		if(!isedit.equals("1")){ 
			out.print("<span>"+_defvalue+"</span>");			
		}else if(ismand.equals("1")) {
		%>
			<textarea class=Inputstyle name="field<%=fieldid%>" onChange="checkinput('field<%=fieldid%>','field<%=fieldid%>span')"
			rows="4" cols="40" style="width:90%" class=Inputstyle><%=_defvalue%></textarea>
			<span id="field<%=fieldid%>span"><%if(_defvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
		<%}else{
		%>
     			<textarea class=Inputstyle name="field<%=fieldid%>" rows="4" cols="40" style="width:90%"><%=_defvalue%></textarea>		  
      		<%}										
	}else if(objtype == 5){		
		String _defvalue = RecordSet.getString("defvalue");
		%>		
		<select class=inputstyle  style="width:90%"  name="field<%=fieldid%>" <%if(isedit.equals("0")){%> DISABLED <%}%> class=Inputstyle>
		<%
		// ��ѯѡ�������п���ѡ���ֵ
		char flag= Util.getSeparator() ;
		rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);
		while(rs.next()){
			String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
			String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
			%>
			<option value="<%=tmpselectvalue%>" <%if(_defvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
			<%
		}
		%>
		</select>
       		<%										
	}else if(objtype == 6){	
		String _defvalue = RecordSet.getString("defvalue");
		%>		 
			<input type=checkbox value=1 name="field<%=fieldid%>" <%if(_defvalue.equals("1")){%> checked <%}%>  <%if(isedit.equals("0")){%> DISABLED <%}%>  >
       		<%										
	}else if(objtype == 7){%>
		<img src="/images/line.gif" border="0" width=100% height=24>
		<%								
	}else if(objtype == 9){
		String _defvalue = RecordSet.getString("defvalue");
		
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
        }else if((fieldbodytype.equals("16") || fieldbodytype.equals("152")) && !reqid.equals("")){ //�����ťΪREQ,��ǰ��Ĳ����л��REQĬ��ֵ
                showid = "" + Util.getIntValue(reqid,0);
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
			
			rs.executeSql(sql);
			if(rs.next()) {
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
					showname =rs.getString(1) ;
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
	}
	%></td><%
		lastpty = pty;	
		ptxs.add(""+ptx);
		ptys.add(""+pty);
		widths.add(""+width);
		heights.add(""+height);
	}
	for(;rowindex<colsnum;rowindex++){
		out.print("<td></td>");
	}
%>
</tr>
 </table>
</td>
<td>&nbsp;</td>
</tr></table>

<br>

<TABLE class="ViewForm" cellPadding=0 cellSpacing=0>
<COLGROUP>
<% 
	for(int i=0;i<colsnum;i++){
%>
  		<td width="<%=widthper%>%"></td>
<%
	}
%>
    <tr class="Title">
      <th colspan=<%=colsnum%>> </th>
    </tr>
    <tr>
      <td colspan=2 ><b><%=SystemEnv.getHtmlLabelName(1007,user.getLanguage())%></b></td>
      <td class=field colspan=<%=colsnum-2%> >
      <!-- modify by xhheng @20050308 for TD 1692 -->
         <%
         //String workflowPhrases[] = WorkflowPhrase.getUserWorkflowPhrase(""+userid);
       //add by cyril on 2008-09-30 for td:9014
  		boolean isSuccess  = RecordSet.executeProc("sysPhrase_selectByHrmId",""+userid); 
  		String workflowPhrases[] = new String[RecordSet.getCounts()];
  		String workflowPhrasesContent[] = new String[RecordSet.getCounts()];
  		int m = 0 ;
  		if (isSuccess) {
  			while (RecordSet.next()){
  				workflowPhrases[m] = Util.null2String(RecordSet.getString("phraseShort"));
  				workflowPhrasesContent[m] = Util.toHtml(Util.null2String(RecordSet.getString("phrasedesc")));
  				m ++ ;
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
				<input type="hidden" id="remarkText10404" name="remarkText" value="">
              <textarea class=Inputstyle name=remark id=remark rows=4 cols=40 style="width=80%;display:none" class=Inputstyle></textarea>
	  		   	<script type="text/javascript">
	  		   	function funcremark_log(){
					FCKEditorExt.initEditor("frmmain","remark",<%=user.getLanguage()%>,FCKEditorExt.NO_IMAGE);
					FCKEditorExt.toolbarExpand(false,"remark");
				}
				//if(ieVersion>=8) window.attachEvent("onload", funcremark_log());
				//else window.attachEvent("onload", funcremark_log);
				if (window.addEventListener){
	  			    window.addEventListener("load", funcremark_log, false);
	  			}else if (window.attachEvent){
	  			    if(ieVersion>=8) window.attachEvent("onload", funcremark_log());
	  		  		else window.attachEvent("onload", funcremark_log);
	  			}else{
	  			    window.onload=funcremark_log;
	  			}	
				</script>

       </td>
    </tr>
	 <TR><TD class=Line colSpan=2></TD></TR>
  </table>

<%
	fieldids = fieldids1;
	fieldlabels=fieldlabels1;
	fieldhtmltypes=fieldhtmltypes1;
	fieldtypes=fieldtypes1;
	fieldnames=fieldnames1;
	fieldviewtypes=fieldviewtypes1;
	isfieldids=isfieldids1;
	isviews=isviews1;
	isedits=isedits1;
	ismands =ismands1;

%>

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

<script language=javascript>

function onNewDoc(fieldid) {
    frmmain.action = "RequestOperation.jsp" ;
    frmmain.method.value = "docnew_"+fieldid ;
    if(check_form(document.frmmain,'requestname')){
        document.frmmain.src.value='save';
        document.frmmain.submit();
		enableAllmenu();
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
                document.frmmain.submit();
				enableAllmenu();
            }
        }
    }

    function doSubmit(obj){            <!-- ����ύ -->
      //modify by xhheng @20050328 for TD 1703
      //��ϸ������check��ͨ��try document.getElementById("needcheck")�����,�����ԭ������ϸ���ݵ��޸�
        var ischeckok="";
        try{
        if(check_form(document.frmmain,document.getElementById("needcheck").value))
          ischeckok="true";
        }catch(e){
          ischeckok="false";
        }
        if(ischeckok=="false"){
          if(check_form(document.frmmain,'<%=needcheck%>'))
            ischeckok="true";
        }
        if(ischeckok=="true"){
            if(checktimeok()) {
                document.frmmain.src.value='submit';
                   <%--added by xwj for td2104 on 2005-08-01--%>
                <%--document.getElementById("remark").value += "\n<%=username%> <%=currentdate%> <%=currenttime%>" ;--%>
                document.frmmain.submit();
				enableAllmenu();
                //obj.disabled=true;
            }
        }
    }
	function onAddPhrase(phrase){            <!-- ��ӳ��ö��� -->
    if(phrase!=null && phrase!=""){
		try{
			document.getElementById("remarkSpan").innerHTML = "";
		}catch(e){}
		try{
			var remarkHtml = FCKEditorExt.getHtml("remark");
			var remarkText = FCKEditorExt.getText("remark");
			if(remarkText==null || remarkText==""){
				FCKEditorExt.setHtml(phrase);
			}else{
				FCKEditorExt.setHtml(remarkHtml+"<p>"+phrase+"</p>");
			}
		}catch(e){}
    }
    }
</script>