<%@ page import="weaver.workflow.request.RequestConstants" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>

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

  <%//xwj for td1834 on 2005-05-22
    String isEdit_ = "-1";
    RecordSet.executeSql("select isedit from workflow_nodeform where nodeid = " + String.valueOf(nodeid) + " and fieldid = -1");
    if(RecordSet.next()){
   isEdit_ = "-1";
    }
     
  %>

<!--�½��ĵ�һ�У�����˵������Ҫ�� -->
  
  <TR>
<td colspan=2 ><b><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></b>
		</td><td colspan=<%=colsnum-2%> class=field >
		
		   <%if(!"1".equals(isEdit_)){//xwj for td1834 on 2005-05-22%>
       <%=Util.toScreenToEdit(requestname,user.getLanguage())%>
       <input type=hidden name=requestname value="<%=Util.toScreenToEdit(requestname,user.getLanguage())%>">
       <%}
       else{%>
        <input type=text class=Inputstyle  name=requestname onChange="checkinput('requestname','requestnamespan')" size=<%=RequestConstants.RequestName_Size%> maxlength=<%=RequestConstants.RequestName_MaxLength%>  value = "<%=Util.toScreenToEdit(requestname,user.getLanguage())%>" >
        <span id=requestnamespan><%if("".equals(Util.toScreenToEdit(requestname,user.getLanguage()))){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
       <%}%>
		
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if(requestlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%>
      <%} else if(requestlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%>
      <%} else if(requestlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%> <%}%>
        
   
	    </td></tr>
   	<TR >
    <TD class="Line1" colSpan=<%=colsnum%>></TD>
  </TR>
  <!--��һ�н��� -->
   
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
ArrayList fieldvalues=new ArrayList();          //�ֶε�ֵ
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

// ��ѯÿһ���ֶε�ֵ
 RecordSet.executeProc("workflow_FieldValue_Select",requestid+"");       // ��workflow_form���в�
    RecordSet.next();
    for(int i=0;i<fieldids.size();i++){
        String fieldname=FieldComInfo.getFieldname((String)fieldids.get(i));
        fieldvalues.add(Util.null2String(RecordSet.getString(fieldname)));
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

            String autoGetDataId1 = "" ;
            int[] autoGetIndex1 = new int[0];
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
		for(int i=0;i<((pty-_pty0)/30);i++){
			out.print("</tr><tr><td colspan=\""+(colsnum-_eRowindexStepLast)+"\"></td>");
			
			colindex ++;
		}
		
		colindex ++;
		rowindex=colsnum;
		out.print("</tr><tr height='24'><td colspan='"+colsnum+"'>");	
		
		%>
	


<!--###########��ϸ�� Start##########-->

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
                while(rs.next()) {

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
               

            for(int i=0; i<autoGetIndex1.length; i++){
                autoGetDataId1 += "-"+fieldids1.get(autoGetIndex1[i]);
            }
            if(!autoGetDataId1.trim().equals("")){
                autoGetDataId1 = autoGetDataId1.substring(1);
            }

               

				//System.out.println("colcount1 = "+colcount1);
                if (colcount1 != 0) {

					colwidth1 = 95 / colcount1;


    %>
  <table class=form>
        <tr>
            <td>

            <table Class=ListStyle id="oTable" cellSpacing=1 >
              <COLGROUP>
              <tr class=header >
              <td width="5%">&nbsp;</td>
   <%
            ArrayList viewfieldnames = new ArrayList() ;

            // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
            int detailfieldcount = -1 ;

            for(int i=0;i<fieldids1.size();i++){         // ѭ����ʼ

			  String fieldid=(String)fieldids1.get(i);  //�ֶ�id
			  String isview=(String)isviews1.get(i);     //�ֶ��Ƿ���ʾ
			  String fieldlable =(String)fieldlabels1.get(i);
			  String fieldname = (String)fieldnames1.get(i);
			  String fieldhtmltype = (String) fieldhtmltypes1.get(i);
			 if( ! isview.equals("1") ) continue;  //����ʾ��������һ��ѭ��

				viewfieldnames.add(fieldname);
   %>
                <td width="<%=colwidth1%>%" nowrap><%=fieldlable%></td>
           <%
       }

%>
              </tr>
<%
            int countaccessory = 0 ;
            boolean isttLight = false;
            int recorderindex = 0;
            RecordSet.executeSql(" select * from Workflow_formdetail where requestid ="+requestid );

			//System.out.println(" select * from Workflow_formdetail where requestid ="+requestid );
            while(RecordSet.next()) {

                isttLight = !isttLight ;
%>
              <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
                 <td width="5%" >&nbsp;</td>
<%
                for(int i=0;i<fieldids1.size();i++){         // ѭ����ʼ

                    String fieldid=(String)fieldids1.get(i);  //�ֶ�id
                    String isview=(String)isviews1.get(i);     //�ֶ��Ƿ���ʾ


                    String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
                    String fieldhtmltype = "" ;                     //�ֶε�ҳ������
                    String fieldtype = "" ;                         //�ֶε�����
                    String fieldlable = "" ;                        //�ֶ���ʾ��
                    int languageid = 0 ;

                    languageid = user.getLanguage() ;
                    fieldname=(String)fieldnames1.get(i);
                    fieldhtmltype=(String)fieldhtmltypes1.get(i);
                    fieldtype=(String)fieldtypes1.get(i);

                    String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;

                    if( ! isview.equals("1") ) continue ;
                    else {
%>
                      <td class=field nowrap style="TEXT-VALIGN: center" <%=(((fieldhtmltype.equals("1"))&&(fieldtype.equals("3")||fieldtype.equals("2")))?" accessKey=\"Number\"":"")%>>
                      <%
                        //add by dongping 
                        //����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
                        if (fieldtype.equals("118")) { %>     
                          <!-- modify by xhheng @20050304 for TD 1691 -->
                          <%if(isprint==false){%>                        
                            <a href="/meeting/report/MeetingRoomPlan.jsp" target=blank>�鿴������ʹ�����</a>		
                          <%}%>
                        <% }

                        if(fieldhtmltype.equals("1") || fieldhtmltype.equals("2")){                          // �����ı��� , �����ı���
                      %>
                      <span id="field<%=fieldid%>_<%=recorderindex%>"><%=Util.toScreen(fieldvalue,user.getLanguage())%></span>
                      <%
                        }                                                   // �����ı�������ı�����������
                        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                            String linkurl =BrowserComInfo.getLinkurl(fieldtype);   // ���ֵ�����ʱ�����ӵ�url
                            String showname = "";                                                   // ֵ��ʾ������
                            String showid = "";                                                     // ֵ

                            //add by wang jinyong
                            HashMap temRes = new HashMap();


                            if(fieldtype.equals("2") ||fieldtype.equals("19")  )    showname=fieldvalue; // ����ʱ��
                            else if(!fieldvalue.equals("")) {
                                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�

                                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57") || fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                                }
                                else {
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                                }

                                RecordSet rs3 = new RecordSet() ;
                                rs3.executeSql(sql);
                                while(rs3.next()){
                                    showid = Util.null2String(rs3.getString(1)) ;
                                    String tempshowname= Util.toScreen(rs3.getString(2),user.getLanguage()) ;
                                    if(!linkurl.equals("")){
                                        //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                                        //modify by xhheng @20050304 for TD 1691
                                        if(isprint==false){
                                        	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                          	{
                                        		temRes.put(String.valueOf(showid),"<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + tempshowname + "</a>&nbsp");
                                          	}
                                        	else
                                          		temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
                                        }else{
                                          temRes.put(String.valueOf(showid),tempshowname);
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
                       %>
                        <%=showname%>
                       <%
                        }                                                       // �����ť��������
                        else if(fieldhtmltype.equals("4")) {                    // check��
                       %>
                        <input type=checkbox value=1 name="field<%=fieldid%>" DISABLED <%if(fieldvalue.equals("1")){%> checked <%}%>>
                       <%
                        }                                                       // check����������
                        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
                       %>
                        <select name="field<%=fieldid%>"  DISABLED >
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
                        }                                          // ѡ����������� ���������ж�����
                       %>
                      </td>

<%
                    }
                }

                recorderindex++;
%>
              </tr>
<%          }   %>

              <TFOOT>
              <TR class=header>
                <TD >�ϼ�</TD>
<%
    for (int i = 0; i < fieldids1.size(); i++) {
        if (!isviews1.get(i).equals("1")) {
%>
                <td width="<%=colwidth1%>%" id="sum<%=fieldids1.get(i)%>" style="display:none"></td>
            <%
        } else {
%>
                <td width="<%=colwidth1%>%" id="sum<%=fieldids1.get(i)%>" ></td>
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
	//out.println(rowCalItemStr);

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

%>

<%--<iframe name=productInfo style="width:100%;height:300;display:none"></iframe>--%>
<script language="javascript">
rowindex = <%=recorderindex%> ;
curindex = <%=recorderindex%> ;

function calSumPrice(){
    var temv1;
    //alert(rowindex);
<%
    String temStr = "";
    for(int i=0; i<rowCalAry.size(); i++){
        temStr = "";
		String calExp = (String)rowCalAry.get(i);

%>
    for( i=0; i<rowindex; i++){
        try{
        <%
           for(int j=0;j<fieldids.size();j++){
				temStr = (String)fieldids.get(j);
				calExp = Util.StringReplace(calExp,"detailfield_"+temStr,"document.getElementById(\"field"+temStr+"_\"+i).value");
			}
            out.println(calExp);
        %>

       }catch(e){}
   }
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
			document.getElementById("field<%=str3%>").value=sum ;

	<%
	}
	%>

}
function calSum(){
    //calSumPrice();
	//calMainField();
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
            temStr=document.getElementById("field<%=str%>_"+i).innerHTML;
            if(temStr+""!=""){
                sum+=temStr*1;
            }
        }catch(e){;}
    }
    document.getElementById("sum<%=str%>").innerHTML=toPrecision(sum,3)+"&nbsp;" <!--xwj for td2026 20050826-->

<%
    }
%>
}


calSum();
<!--added by xwj for td2026 20050826 begin-->
function toPrecision(aNumber,precision){
	var temp1 = Math.pow(10,precision);
	var temp2 = new Number(aNumber);

	return isNaN(Math.round(temp1*temp2) /temp1)?0:Math.round(temp1*temp2) /temp1 ;
}
<!--added by xwj for td2026 20050826 end-->
</script>

<!--###########��ϸ�� END########### -->

  <%}//(colcount1 != 0)  end%>

</td>		
		
		<%
		hasshowdetail = 1;
			
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
	String fieldvalue = "" ;                        //�ֶ���ʾ��
	int languageid = 0 ;
	
	if(!fieldid.equals("")){
		int isfieldidindex = isfieldids.indexOf(fieldid) ;
		if( isfieldidindex != -1 ) {
		isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
		    isedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
		    ismand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
		}
	
		int tmpindex = fieldids.indexOf(fieldid);
		languageid= Util.getIntValue( (String)languageids.get(tmpindex), 0 ) ;    //��Ҫ����
		fieldhtmltype=FieldComInfo.getFieldhtmltype(fieldid);
		fieldtype=FieldComInfo.getFieldType(fieldid);
		fieldlable=(String)fieldlabels.get(tmpindex);
		fieldname=FieldComInfo.getFieldname(fieldid);
	   	fieldvalue=(String)fieldvalues.get(tmpindex);
	   	
	   	if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��

		
		
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
			
		out.print("<td colspan='"+_widthcols+"'  class=field rowspan='"+height/30+"'  style='"+_fontsize+"border-bottom :1 groove black;border-right :1 groove black;border-top :1 groove black;'>");
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
			} %>
		<span style='color:<%=_color%>;<%=_fontsize%>;<%=_isbold%>'><%=Util.toHtml(RecordSet.getString("defvalue"))%></span>					
		<%
	}else if(objtype == 2){
		String _src = Util.null2String(RecordSet.getString("defvalue"));
		if(!_src.equals("")){%>
			<img src="<%=_src%>" border="<%=Util.getIntValue(RecordSet.getString("attribute1"),0)%>"  >	
		<%}
	}else if(objtype == 3){
	
		String _defvalue = fieldvalue;
      %>
        <%=Util.toScreen(fieldvalue,user.getLanguage())%>
       
      <%			
	}else if(objtype == 4){
		
		String _defvalue = fieldvalue;
		
      %>
        <%=Util.toScreen(fieldvalue,user.getLanguage())%>
      <%			
											
	}else if(objtype == 5){	
		%>
        <select name="field<%=fieldid%>" DISABLED >
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
	}else if(objtype == 6){	
		%>
        <input type=checkbox value=1 name="field<%=fieldid%>" DISABLED <%if(fieldvalue.equals("1")){%> checked <%}%>>
       <%									
	}else if(objtype == 7){%>
		<img src="/images/line.gif" border="0" width=100% height=24>
		<%								
	}else if(objtype == 9){
		if(fieldtype.equals("2") || fieldtype.equals("19")){    // ���ں�ʱ��
      %>
        <%=fieldvalue%>
      <%
            } else if(!fieldvalue.equals("")) {
                String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                String showname = "";                                                   // ֵ��ʾ������
                String showid = "";                                                     // ֵ

                //add by wang jinyong
                HashMap temRes = new HashMap();

                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57") || fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                }

                rs.executeSql(sql);
                while(rs.next()){
                    showid= Util.null2String(rs.getString(1)) ;
                    showname= Util.toScreen(rs.getString(2),user.getLanguage()) ;
                    if(!linkurl.equals("")){
                        //showname = "<a href='"+linkurl+showid+"'>"+showname+"</a> " ;
                        //modify by xhheng @20050304 for TD 1691
                        if(isprint==false){
                        	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                          	{
                        		temRes.put(String.valueOf(showid),"<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + tempshowname + "</a>&nbsp");
                          	}
                        	else
                          		temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+showname+"</a> " );
                        }else{
                          temRes.put(String.valueOf(showid),showname);
                        }
                    }

                }    // end of while

                StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                String temstkvalue = "";
                while(temstk.hasMoreTokens()){
                    temstkvalue = temstk.nextToken();
                    
                    if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){

      %>
        <%=temRes.get(temstkvalue)%>
      <%
                    }
                }
            }					
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


<input type=hidden name="requestid" value="<%=requestid%>">           <!--����id-->
<input type=hidden name="workflowid" value="<%=workflowid%>">       <!--������id-->
<input type=hidden name="nodeid" value="<%=nodeid%>">               <!--��ǰ�ڵ�id-->
<input type=hidden name="nodetype" value="<%=nodetype%>">           <!--��ǰ�ڵ�����-->
<input type=hidden name="src" value="active">                       <!--�������� save��submit,reject,delete,active-->
<input type=hidden name="iscreate" value="0">                     <!--�Ƿ�Ϊ�����ڵ� ��:1 �� 0 -->
<input type=hidden name="formid" value="<%=formid%>">               <!--����id-->
<input type=hidden name ="isbill" value="<%=isbill%>">            <!--�Ƿ񵥾� 0:�� 1:��-->
<input type=hidden name="billid" value="<%=billid%>">             <!--����id-->
