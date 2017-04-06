<%@ page import="java.math.*" %>
<%@ page import="weaver.fna.budget.BudgetHandler"%>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="FnaBudgetChgApplyOperation.jsp" enctype="multipart/form-data">
    <%@ include file="/workflow/request/WorkflowViewRequestBody.jsp" %>
    <table class="viewform">

        <tr>
            <td>
            <%
             String uid=""+creater;
             String uname=ResourceComInfo.getLastname(uid);
             String udept=ResourceComInfo.getDepartmentID(uid);
             String udeptname= DepartmentComInfo.getDepartmentname(udept);
             String usubcom=DepartmentComInfo.getSubcompanyid1(udept);
             weaver.hrm.company.SubCompanyComInfo scci=new weaver.hrm.company.SubCompanyComInfo();
             String usubcomname=scci.getSubCompanyname(usubcom);

            int colcount = 0 ;
            int colwidth = 0 ;
            fieldids.clear() ;
            fieldlabels.clear() ;
            fieldhtmltypes.clear() ;
            fieldtypes.clear() ;
            fieldnames.clear() ;
            fieldviewtypes.clear() ;
            String temporganizationidisview="0";
            String temprogtypeisview="0";

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
                String thefieldname=(String)fieldnames.get(thefieldidindex);
                if(thefieldname.equals("organizationid")) temporganizationidisview=theisview;
                if(thefieldname.equals("organizationtype")) temprogtypeisview=theisview;
                if( theisview.equals("1") ) colcount ++ ;
                isfieldids.add(thefieldid);
                isviews.add(theisview);
            }
            if(temporganizationidisview.equals("1")&&temprogtypeisview.equals("0")) colcount++;
            if( colcount != 0 ) colwidth = 95/colcount ;


    %>
            <table class=liststyle cellspacing=1   id="oTable">
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

                String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
                String fieldlable = "" ;                        //�ֶ���ʾ��
                int languageid = 0 ;

                fieldname=(String)fieldnames.get(i);
                if(! isview.equals("1") &&fieldname.equals("organizationtype")) isview=temporganizationidisview;
                if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��
                languageid = user.getLanguage() ;
                fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(i),0),languageid );

                viewfieldnames.add(fieldname) ;
%>
                <td width="<%=colwidth%>%"><%=fieldlable%></td>
<%          }
%>
              </tr><tr class=line2><td ></td>
			   <%for(int i=0;i<fieldids.size();i++){ %>
			   <td></td><%}%>
			  </tr>
<%
            BigDecimal amountsum = new BigDecimal("0") ;
            double amount = 0 ;
            BigDecimal applyamountsum = new BigDecimal("0") ;
            double changeamountsum = 0 ;
            boolean isttLight = false;
            sql="select *  from Bill_FnaBudgetChgApplyDetail where id="+billid+" order by dsporder";
            RecordSet.executeSql(sql);
            while(RecordSet.next()) {
            	BigDecimal applyamount = new BigDecimal("0.000");//TD12002
                isttLight = !isttLight ;
				double oldamount = 0;
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

                    String fieldname = (String)fieldnames.get(i);   //�ֶ����ݿ���е��ֶ���
                    if(! isview.equals("1") &&fieldname.equals("organizationtype")) isview=temporganizationidisview;
                    if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��
                    String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;
                     int organizationtype = RecordSet.getInt("organizationtype");
                    int organizationid = RecordSet.getInt("organizationid");
                    String budgetperiod = RecordSet.getString("budgetperiod");
                    int subject = RecordSet.getInt("subject");
                    BudgetHandler bp = new BudgetHandler();
                    double oldbudget = bp.getBudgetByDate(budgetperiod, organizationtype, organizationid, subject);
					/**TD12002*/
            		BigDecimal dOldbudget = new BigDecimal(String.valueOf(oldbudget)) ;
                    if( fieldname.equals("organizationtype")){
                        String orgtype=Util.null2String(RecordSet.getString("organizationtype"));
                        if(orgtype.equals("3")){
                        fieldvalue=SystemEnv.getHtmlLabelName(6087,user.getLanguage());
                        }else if(orgtype.equals("2")){
                        fieldvalue=SystemEnv.getHtmlLabelName(124,user.getLanguage());
                        }else if(orgtype.equals("1")){
                        fieldvalue=SystemEnv.getHtmlLabelName(141,user.getLanguage());
                        }

                    }else if (fieldname.equals("organizationid")) {
                        String orgtype = Util.null2String(RecordSet.getString("organizationtype"));
                        String orgid = Util.null2String(RecordSet.getString("organizationid"));
                        if (orgtype.equals("3")) {
                            fieldvalue ="<A href='javaScript:openhrm(" + fieldvalue + ");' onclick='pointerXY(event);'>" + Util.toScreen(ResourceComInfo.getLastname(fieldvalue), user.getLanguage()) + "</A>";
                            if (!orgid.equals(uid))
                                fieldvalue = "<div style='background:#ff9999'>" + fieldvalue + "</div>";
                        } else if (orgtype.equals("2")) {
                            fieldvalue = "<A href='/hrm/company/HrmDepartmentDsp.jsp?id=" + fieldvalue + "'>" + Util.toScreen(DepartmentComInfo.getDepartmentname(fieldvalue), user.getLanguage()) + "</A>";
                            if (!orgid.equals(udept))
                                fieldvalue = "<div style='background:#ff9999'>" + fieldvalue + "</div>";
                        } else if (orgtype.equals("1")) {
                            fieldvalue = "<A href='/hrm/company/HrmSubCompanyDsp.jsp?id=" + fieldvalue + "'>" + Util.toScreen(SubCompanyComInfo.getSubCompanyname(fieldvalue), user.getLanguage()) + "</A>";
                            if (!orgid.equals(usubcom))
                                fieldvalue = "<div style='background:#ff9999'>" + fieldvalue + "</div>";
                        }

                    } else if (fieldname.equals("relatedprj"))
                        fieldvalue = "<A href='/proj/data/ViewProject.jsp?isrequest=1&ProjID=" + fieldvalue + "'>" + Util.toScreen(ProjectInfoComInfo.getProjectInfoname(fieldvalue), user.getLanguage()) + "</A>";
                    else if (fieldname.equals("relatedcrm"))
                        fieldvalue = "<A href='/CRM/data/ViewCustomer.jsp?isrequest=1&CustomerID=" + fieldvalue + "'>" + Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(fieldvalue), user.getLanguage()) + "</A>";
                    else if (fieldname.equals("subject"))
                        fieldvalue = Util.toScreen(BudgetfeeTypeComInfo.getBudgetfeeTypename(fieldvalue), user.getLanguage());
                    else if (fieldname.equals("oldamount")) {
                    	//TD12002
                        //fieldvalue = ""+oldbudget ;
                        //fieldvalue = ""+dOldbudget.toPlainString() ;
						oldamount = Util.getDoubleValue(fieldvalue);
                   } else if( fieldname.equals("amount")) {
                        amount=Util.getDoubleValue(fieldvalue,0)  ;
                        if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                        else
                            amountsum = amountsum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                    }else if( fieldname.equals("applyamount")) {
                    	applyamount=applyamount.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0)));//TD12002
                        if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                        else
                            applyamountsum = applyamountsum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                    }else if( fieldname.equals("changeamount")) {
                        //TD12002 ��ʹ�ÿ�ѧ��������ʾ
                        //fieldvalue = ""+(amount-oldbudget);
						BigDecimal changeamount = (new BigDecimal(oldamount)).negate();
                         if (amount > 0) {
                         	 changeamount = changeamount.add(new BigDecimal(amount));
                         } else {
                         	 changeamount = changeamount.add(applyamount);
                         }
                        changeamount = changeamount.divide ( new BigDecimal ( 1 ), 3, BigDecimal.ROUND_HALF_UP );
                        fieldvalue = ""+changeamount;
                    }



%>
                <td><%=fieldvalue%></td>
<%              }   %>
              </tr>
<%          }   %>

            </table>
            </td>
        </tr>
    </table>

    <br>
	<!--����ҳ������BUG-->
  <%--@ include file="WorkflowViewSign.jsp" --%>
  <jsp:include page="WorkflowViewSignAction.jsp" flush="true">
                <jsp:param name="workflowid" value="<%=workflowid%>" />
                <jsp:param name="languageid" value="<%=user.getLanguage()%>" />
                <jsp:param name="requestid" value="<%=requestid%>" />
                <jsp:param name="userid" value="<%=userid%>" />
                <jsp:param name="usertype" value="<%=usertype%>" />
                <jsp:param name="isprint" value="<%=isprint%>" />
                <jsp:param name="nodeid" value="<%=nodeid%>" />
               
                <jsp:param name="desrequestid" value="<%=desrequestid%>" />
                <jsp:param name="isurger" value="<%=isurger%>" />
                <jsp:param name="wfmonitor" value="<%=wfmonitor%>" />
            </jsp:include>
</form>

