<%@ page import="java.math.*" %>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>

<%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="BillExpenseOperation.jsp">
    <%@ include file="/workflow/request/WorkflowViewRequestBody.jsp" %>
    <table class=form>
        <TR class=separator>
            <TD class=Sep1></TD>
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

            RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
            while(RecordSet.next()){
                String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
                int thefieldidindex = fieldids.indexOf( thefieldid ) ;
                if( thefieldidindex == -1 ) continue ;
                String theisview = Util.null2String(RecordSet.getString("isview")) ;
                if( theisview.equals("1") ) colcount ++ ;
                isfieldids.add(thefieldid);
                isviews.add(theisview);
            }

            if( colcount != 0 ) colwidth = 95/colcount ;


    %>
            <table Class=ListShort id="oTable">
              <COLGROUP> 
              <tr class=header> 
              <td width="5%">&nbsp;</td>
   <%
            ArrayList viewfieldnames = new ArrayList() ;
            
            // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ

            for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                String fieldid=(String)fieldids.get(i);  //�ֶ�id
                String isview="0" ;    //�ֶ��Ƿ���ʾ

                int isfieldidindex = isfieldids.indexOf(fieldid) ;
                if( isfieldidindex != -1 ) {
                    isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
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

            RecordSet.executeProc("Bill_ExpenseDetali_SelectByID",billid+"");
            while(RecordSet.next()) {
                isttLight = !isttLight ;
%>
              <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'> 
                <td width="5%">&nbsp;</td>
<%
                for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                    String fieldid=(String)fieldids.get(i);  //�ֶ�id
                    String isview="0" ;    //�ֶ��Ƿ���ʾ

                    int isfieldidindex = isfieldids.indexOf(fieldid) ;
                    if( isfieldidindex != -1 ) {
                        isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                    }
                    if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��
                    
                    String fieldname = (String)fieldnames.get(i);   //�ֶ����ݿ���е��ֶ���
                    String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;
                    
                    
                    if( fieldname.equals("feetypeid"))
                        fieldvalue = Util.toScreen(BudgetfeeTypeComInfo.getBudgetfeeTypename(fieldvalue),user.getLanguage()) ;
                    else if( fieldname.equals("relatedcrm"))
                        fieldvalue = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(fieldvalue),user.getLanguage()) ;
                    else if( fieldname.equals("relatedproject"))
                        fieldvalue =  Util.toScreen(ProjectInfoComInfo.getProjectInfoname(fieldvalue),user.getLanguage()) ;   
                    else if( fieldname.equals("detailremark"))
                        fieldvalue=Util.toScreen(fieldvalue,user.getLanguage()) ;
                    else if( fieldname.equals("feesum")) {
                        if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                        else
                            countexpense = countexpense.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                    }
                    else if( fieldname.equals("realfeesum")) {
                        if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                        else 
                            countrealfeefum = countrealfeefum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                    }
                    else if( fieldname.equals("accessory")) {
                        if( Util.getIntValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                        else countaccessory += Util.getIntValue(fieldvalue,0) ;
                    }
                    else if( fieldname.equals("invoicenum"))
                        fieldvalue=Util.toScreen(fieldvalue,user.getLanguage()) ;
%>
                <td><%=fieldvalue%></td>
<%              }   %>
              </tr>
<%          }   %>
              <tr class=TOTAL style="FONT-WEIGHT: bold; COLOR: red"> 
                <td>�ϼ�</td>
<%          for(int i=0;i<viewfieldnames.size();i++){
                String thefieldname = (String)viewfieldnames.get(i) ;
%>
                <td><% if(thefieldname.equals("accessory")) {
                        String countaccessorystr = "" ;
                        if( countaccessory != 0 ) countaccessorystr = ""+ countaccessory ;
                    %><%=countaccessorystr%>
                    <% } else if(thefieldname.equals("feesum")) {
                        countexpense = countexpense.divide ( new BigDecimal ( 1 ), 3, BigDecimal.ROUND_HALF_UP ) ;
                        String countexpensestr = "" ;
                        if( countexpense.doubleValue() != 0 ) countexpensestr = ""+countexpense.doubleValue() ;
                    %><%=countexpensestr%>
                    <% } else if(thefieldname.equals("realfeesum")) {
                        countrealfeefum = countrealfeefum.divide ( new BigDecimal ( 1 ), 3, BigDecimal.ROUND_HALF_UP ) ;
                        String countrealfeefumstr = "" ;
                        if( countrealfeefum.doubleValue() != 0 ) countrealfeefumstr = ""+countrealfeefum.doubleValue() ;
                    %><%=countrealfeefumstr%>
                    <% } else { %>&nbsp;<%}%>
                </td>
<%          }
%>                
              </tr>
            </table>
            </td>
        </tr>
    </table>
    <br>
    <%@ include file="/workflow/request/BillBudgetExpenseDetail.jsp" %>
    <br>
    <%@ include file="/workflow/request/WorkflowViewSign.jsp" %>
</form>
