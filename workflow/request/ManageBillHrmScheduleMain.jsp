<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="java.math.*,weaver.conn.*" %>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>

<%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>
<form name="frmmain" method="post" action="BillHrmScheduleMainOperation.jsp" enctype="multipart/form-data">
<input type="hidden" name="needwfback" id="needwfback" value="1" />
    <%@ include file="/workflow/request/WorkflowManageRequestBody.jsp" %>
    <br>
    <table class=viewform>
        <% if( nodetype.equals("0") ) { %>
        <tr>
            <td>
            <BUTTON Class=BtnFlow type=button accessKey=A onclick="addRow()"><U>A</U>-<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></BUTTON>
            <BUTTON Class=BtnFlow type=button accessKey=E onclick="deleteRow1();"><U>E</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
            </td>
        </tr>
        <%  } %>
        <TR class=Spacing><TD class=Line1></TD></TR>
        </TR>
        <tr>
            <td>
            <%
            int colcount = 0 ;
            int colwidth = 0 ;
            fieldids.clear() ;
            fieldlabels.clear() ;
            fieldhtmltypes.clear() ;
            fieldtypes.clear() ;
            fieldnames.clear() ;
            fieldviewtypes.clear() ;
            

            RecordSet.executeProc("workflow_billfield_Select",formid+"");
            while(RecordSet.next()){
                String theviewtype = Util.null2String(RecordSet.getString("viewtype")) ;
                if( !theviewtype.equals("1") ) continue ;   // ����ǵ��ݵ������ֶ�,����ʾ

                fieldids.add(Util.null2String(RecordSet.getString("id")));
                fieldlabels.add(Util.null2String(RecordSet.getString("fieldlabel")));
                fieldhtmltypes.add(Util.null2String(RecordSet.getString("fieldhtmltype")));
                fieldtypes.add(Util.null2String(RecordSet.getString("type")));
                fieldnames.add(Util.null2String(RecordSet.getString("fieldname")));
                fieldviewtypes.add(theviewtype);
            }

            // ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
            isfieldids.clear() ;              //�ֶζ���
            isviews.clear() ;              //�ֶ��Ƿ���ʾ����
            isedits.clear() ;              //�ֶ��Ƿ���Ա༭����
            ismands.clear() ;              //�ֶ��Ƿ�����������

            RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
            while(RecordSet.next()){
                String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
                int thefieldidindex = fieldids.indexOf( thefieldid ) ;
                if( thefieldidindex == -1 ) continue ;
                String theisview = Util.null2String(RecordSet.getString("isview")) ;
                if( theisview.equals("1") ) colcount ++ ;
                isfieldids.add(thefieldid);
                isviews.add(theisview);
                isedits.add(Util.null2String(RecordSet.getString("isedit")));
                ismands.add(Util.null2String(RecordSet.getString("ismandatory")));
            }

            if( colcount != 0 ) colwidth = 95/colcount ;


    %>
            <table class=liststyle cellspacing=1 id="oTable">
              <COLGROUP> 
              <tr class=header> 
              <td width="5%">&nbsp;</td>
   <%
            ArrayList viewfieldnames = new ArrayList() ;
            
            // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
            int detailfieldcount = -1 ;

            for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                String fieldid=(String)fieldids.get(i);  //�ֶ�id
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
                String fieldlable = "" ;                        //�ֶ���ʾ��
                int languageid = 0 ;                                                   
                
                fieldname=(String)fieldnames.get(i);
                languageid = user.getLanguage() ;
                fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(i),0),languageid );

                viewfieldnames.add(fieldname) ;
%>
                <td width="<%=colwidth%>%"><%=fieldlable%></td>
<%          }
%>
              </tr>
<%          
            BigDecimal countexpense = new BigDecimal("0") ;
            BigDecimal countrealfeefum = new BigDecimal("0") ;
            int countaccessory = 0 ;
            boolean isttLight = false;
            int recorderindex = 0 ;

            RecordSet.executeSql(" select * from Bill_HrmScheduleDetail where scheduleid ="+billid );
            while(RecordSet.next()) {
                isttLight = !isttLight ;
%>
              <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'> 
                <td width="5%"><% if( nodetype.equals("0") ) { %><input type='checkbox' name='check_node' value='<%=recorderindex%>'><% } else { %>&nbsp;<% } %></td>
<%
                for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                    String fieldid=(String)fieldids.get(i);  //�ֶ�id
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

                    languageid = user.getLanguage() ;
                    languageid = user.getLanguage() ;
                    fieldname=(String)fieldnames.get(i);
                    fieldhtmltype=(String)fieldhtmltypes.get(i);
                    fieldtype=(String)fieldtypes.get(i);

                    String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;
                    
                    if( ! isview.equals("1") ) {
%>
                    <input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
                    }
                    else {
                        if(ismand.equals("1"))  needcheck+= ",field"+fieldid+"_"+recorderindex; 
                        //�����������,�����������ļ����
%>                  
                      <td class=field style="TEXT-VALIGN: center"> 
                      <%
                        if(fieldhtmltype.equals("1")){                          // �����ı���
                            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                                if(isedit.equals("1") && isremark==0 ){
                                    if(ismand.equals("1")) {
                      %>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" size=50 value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" onChange="checkinput('field<%=fieldid%>_<%=recorderindex%>','field<%=fieldid%>_<%=recorderindex%>span')">
                        <span id="field<%=fieldid%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span> 
                      <%
                                        
                                    }else{%>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" size=50>
                      <%            }
                                }
                                else {
                      %>
                        <%=Util.toScreen(fieldvalue,user.getLanguage())%> 
                        <input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>">
                      <%
                                }
                            }
                            else if(fieldtype.equals("2")){                     // �����ı����е�����
                                if(isedit.equals("1") && isremark==0 ){
                                    if(ismand.equals("1")) {
                      %>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>"
                        onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('field<%=fieldid%>_<%=recorderindex%>','field<%=fieldid%>_<%=recorderindex%>span')">
                        <span id="field<%=fieldid%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span> 
                       <%
                                    
                                    }else{%>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
                       <%           }
                                }
                                else {
                      %>
                        <%=fieldvalue%><input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=fieldvalue%>">
                      <%
                                }
                            }
                            else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                                if(isedit.equals("1") && isremark==0 ){
                                    if(ismand.equals("1")) {
                       %>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>"
                        onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('field<%=fieldid%>_<%=recorderindex%>','field<%=fieldid%>_<%=recorderindex%>span')">
                        <span id="field<%=fieldid%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span> 
                       <%
                                    }else{%>
                        <input type=text name="field<%=fieldid%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
                       <%           }
                                }
                                else {
                      %>
                        <%=fieldvalue%><input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=fieldvalue%>">
                      <%
                                }
                            }
                        }                                                       // �����ı�����������
                        else if(fieldhtmltype.equals("2")){                     // �����ı���
                            if(isedit.equals("1") && isremark==0 ){
                                if(ismand.equals("1")) {
                       %>
                        <textarea name="field<%=fieldid%>_<%=recorderindex%>"  onChange="checkinput('field<%=fieldid%>_<%=recorderindex%>','field<%=fieldid%>_<%=recorderindex%>span')"
                        rows="4" cols="40" style="width:80%" ><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
                        <span id="field<%=fieldid%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span> 
                       <%
                                }else{
                       %>
                        <textarea name="field<%=fieldid%>_<%=recorderindex%>" rows="4" cols="40" style="width:80%"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
                       <%       }
                            }
                            else {
                      %>
                        <%=Util.toScreen(fieldvalue,user.getLanguage())%> 
                        <input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>">
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
                                
                                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")) {    // ��������Դ,��ͻ�,����飬���ĵ�
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
                                    if(!linkurl.equals(""))
                                    	
                                    {
                        				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                    	{
                                    		showname = "<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + tempshowname + "</a>&nbsp";
                                    	}
                        				else
                        					showname += "<a href='"+linkurl+showid+"&requestid="+requestid+"'>"+tempshowname+"</a> " ;
                        			} 
                                    else 
                                        showname += tempshowname ;
                                }
                            }
                            if(isedit.equals("1") && isremark==0 ){ 
                                if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
                       %>
                        <button class=Browser onclick="onShowBrowser('<%=fieldid%>_<%=recorderindex%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" title="ѡ��"></button> 
                       <%       } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                       %>
                        <button class=AddDocFlow onclick="onShowBrowser('<%=fieldid%>_<%=recorderindex%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" > ���</button>&nbsp;&nbsp;<button class=AddDocFlow onclick="onNewDoc(<%=fieldid%>_<%=recorderindex%>)" title="�½�">�½�</button>
                       <%       }
                            }
                       %>
                        <span id="field<%=fieldid%>_<%=recorderindex%>span"><%=showname%>
                       <%
                            if( ismand.equals("1") && fieldvalue.equals("") ){
                       %>
                        <img src="/images/BacoError.gif" align=absmiddle>
                       <%
                            }
                       %>
                        </span> <input type=hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=fieldvalue%>">
                       <%
                        }                                                       // �����ť��������                       
                        else if(fieldhtmltype.equals("4")) {                    // check��   
                       %>
                        <input type=checkbox value=1 name="field<%=fieldid%>_<%=recorderindex%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%>  <%if(fieldvalue.equals("1")){%> checked <%}%> >
                       <%   
                            if( isedit.equals("0") || isremark==1 ){
                       %>
                        <input type= hidden name="field<%=fieldid%>_<%=recorderindex%>" value="<%=fieldvalue%>">
                       <%
                            }
                        }                                                       // check����������
                        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
                       %>
                        <select name="field<%=fieldid%>_<%=recorderindex%>" <%if(isedit.equals("0") || isremark==1 ){%> DISABLED <%}%> >
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
                        <input type= hidden name="field<%=fieldid%>_<%=recorderindex%>" value=<%=fieldvalue%>>
                       <%
                            }
                        }                                          // ѡ����������� ���������ж�����
                       %>
                      </td>
<%
                    }
                }
                recorderindex ++ ;
%>
              </tr>
<%          }   %>
            </table>
            </td>
        </tr>
    </table>
    <br>
    <input type='hidden' id=nodesnum name=nodesnum value="<%=recorderindex%>">

    <%@ include file="/workflow/request/WorkflowManageSign.jsp" %>
</form>

<script language=javascript>
rowindex = <%=recorderindex%> ;
deleteindex=0;

function addRow()
{
	oRow = oTable.insertRow(-1);

    oCell = oRow.insertCell(-1);  
    oCell.style.height=24;
    oCell.style.background= "#D2D1F1";
	    
    var oDiv = document.createElement("div");
    var sHtml = "<input type='checkbox' name='check_node' value='"+rowindex+"'>"; 
    oDiv.innerHTML = sHtml;
    oCell.appendChild(oDiv);
    
<%
    for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

        String fieldhtml = "" ;
        String fieldid=(String)fieldids.get(i);  //�ֶ�id
        
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
        int languageid = user.getLanguage() ;
        fieldname=(String)fieldnames.get(i);
        fieldhtmltype=(String)fieldhtmltypes.get(i);
        fieldtype=(String)fieldtypes.get(i);
        
        if(ismand.equals("1"))  needcheck+=",field"+fieldid + "_" + i ;   //�����������,�����������ļ����

        // ���濪ʼ������ʾ�ֶ�
        
        if(fieldhtmltype.equals("1")){                          // �����ı���
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=50 onChange='checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' value='' size=50>";
                    }
                }
            }
            else if(fieldtype.equals("2")){                     // �����ı����е�����
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this);checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ; 
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this)'>" ;
                    }
                }
            }
            else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this)'>" ;
                    }
                }
            }
        }                                                       // �����ı�����������
        else if(fieldhtmltype.equals("2")){                     // �����ı���
            if(isedit.equals("1")){
                if(ismand.equals("1")) {
                    fieldhtml = "<textarea name='field"+fieldid+"_\"+rowindex+\"' onChange='checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)' rows='4' cols='40' style='width:80%'></textarea><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ; 
                }else{
                    fieldhtml = "<textarea name='field"+fieldid+"_\"+rowindex+\"' rows='4' cols='40' style='width:80%'></textarea>" ;
                }
            }
        }                                                           // �����ı�����������
        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url

            if(isedit.equals("1")){ 
                if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
                    fieldhtml = "<button class=Browser onclick=onShowBrowser('"+fieldid+"_\"+rowindex+\"','"+url+"','"+linkurl+"','"+fieldtype+"','"+ismand+"') title='"+SystemEnv.getHtmlLabelName( 172 ,user.getLanguage() )+"'></button>" ; 
                } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                    fieldhtml = "<button class=AddDocFlow onclick=onShowBrowser('"+fieldid+"_\"+rowindex+\"','"+url+"','"+linkurl+"','"+fieldtype+"','"+ismand+"')>"+SystemEnv.getHtmlLabelName( 611 ,user.getLanguage() )+"</button>&nbsp;&nbsp<button class=AddDocFlow onclick='onNewDoc("+fieldid+"_\"+rowindex+\")' title='"+SystemEnv.getHtmlLabelName( 82 ,user.getLanguage() )+"'>"+SystemEnv.getHtmlLabelName( 82 ,user.getLanguage() )+"</button>" ;
                 }
            }
            fieldhtml += "<input type=hidden name='field"+fieldid+"_\"+rowindex+\"' value=''><span id='field"+fieldid+"_\"+rowindex+\"span'>" ;
            
            if(ismand.equals("1")) {
               fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>" ; 
            }
            fieldhtml += "</span>" ; 
        }                                                       // �����ť��������                       
        else if(fieldhtmltype.equals("4")) {                    // check��   
            fieldhtml += "<input type=checkbox value=1 name='field"+fieldid+"_\"+rowindex+\"' " ; 
            
            if(isedit.equals("0"))  fieldhtml += "DISABLED" ;  
            
            fieldhtml += ">" ;
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
            fieldhtml += "<select name='field"+fieldid+"_\"+rowindex+\"' " ;
            if(isedit.equals("0")) fieldhtml += "DISABLED" ;
            fieldhtml += ">" ;
           
            // ��ѯѡ�������п���ѡ���ֵ
            flag= Util.getSeparator() ;
            rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);  
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                fieldhtml += "<option value='"+tmpselectvalue+"'>"+tmpselectname+"</option>" ;
            }
            fieldhtml += "</select>" ;
        }                                          // ѡ����������� ���������ж�����
%>
        
        oCell = oRow.insertCell(-1);  
		oCell.style.height=24;
		oCell.style.background= "#D2D1F1";
	    
        var oDiv = document.createElement("div");
        var sHtml = "<%=fieldhtml%>" ; 
        oDiv.innerHTML = sHtml;
        oCell.appendChild(oDiv);
<%
    }       // ѭ������
%>
	rowindex = rowindex*1 +1;
    document.frmmain.nodesnum.value = rowindex ;
	
}


function deleteRow1()
{
    var flag = false;
	var ids = document.getElementsByName('check_node');
	for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
	}
    if(flag) {
		if(isdel()){
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
                    }
                    rowsum1 -=1;
                }
            }
        }
    }else{
        alert('<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>');
		return;
    }
}	

</script> 


<script language=vbs>
sub onShowDate(spanname,inputname,ismand)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	if returndate<>"" then
	    spanname.innerHtml= returndate
        inputname.value=returndate
	else
	    if ismand = 1 then
	        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        else 
            spanname.innerHtml = ""
        end if
        inputname.value= ""
	end if
end sub

sub onShowFeeType(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype='1'")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else 
    if ismand = 1 then
	    spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
	inputname.value=""
	end if
	end if
end sub

sub onShowCustomer(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else 
	if ismand = 1 then
	    spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
	inputname.value=""
	end if
	end if
end sub

sub onShowProject(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if NOT isempty(id) then
    if id(0)<> "" then
    spanname.innerHtml = id(1)
    inputname.value=id(0)
    else
    if ismand = 1 then
        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
    inputname.value=""
    end if
	end if
end sub
</script>
