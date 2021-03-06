 <%@ page import="java.math.*" %>
 <%@ page import="weaver.fna.budget.BudgetHandler"%>
 <jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
 <jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
 <jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
 <jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
 <%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowManageRequestTitle.jsp" %>
 <jsp:useBean id="WFNodeDtlFieldManager" class="weaver.workflow.workflow.WFNodeDtlFieldManager" scope="page" />
<%
ArrayList fieldids = (ArrayList) session.getAttribute(requestid+"_fieldids");             //字段队列
ArrayList fieldorders = (ArrayList) session.getAttribute(requestid+"_fieldorders");        //字段显示顺序队列 (单据文件不需要)
ArrayList languageids = (ArrayList) session.getAttribute(requestid+"_languageids");          //字段显示的语言(单据文件不需要)
ArrayList fieldlabels = (ArrayList) session.getAttribute(requestid+"_fieldlabels");          //单据的字段的label队列
ArrayList fieldhtmltypes = (ArrayList) session.getAttribute(requestid+"_fieldhtmltypes");       //单据的字段的html type队列
ArrayList fieldtypes = (ArrayList) session.getAttribute(requestid+"_fieldtypes");           //单据的字段的type队列
ArrayList fieldnames = (ArrayList) session.getAttribute(requestid+"_fieldnames");           //单据的字段的表字段名队列
ArrayList fieldvalues = (ArrayList) session.getAttribute(requestid+"_fieldvalues");          //字段的值
ArrayList fieldviewtypes = (ArrayList) session.getAttribute(requestid+"_fieldviewtypes");       //单据是否是detail表的字段1:是 0:否(如果是,将不显示)
ArrayList isfieldids = (ArrayList) session.getAttribute(requestid+"_isfieldids");              //字段队列
ArrayList isviews = (ArrayList) session.getAttribute(requestid+"_isviews");              //字段是否显示队列
ArrayList isedits = (ArrayList) session.getAttribute(requestid+"_isedits");              //字段是否可以编辑队列
ArrayList ismands = (ArrayList) session.getAttribute(requestid+"_ismands");              //字段是否必须输入队列
//获取明细表设置
                WFNodeDtlFieldManager.resetParameter();
                WFNodeDtlFieldManager.setNodeid(Util.getIntValue(""+nodeid));
                WFNodeDtlFieldManager.setGroupid(0);
                WFNodeDtlFieldManager.selectWfNodeDtlField();
                String dtladd = WFNodeDtlFieldManager.getIsadd();
                String dtledit = WFNodeDtlFieldManager.getIsedit();
                String dtldelete = WFNodeDtlFieldManager.getIsdelete();
                String dtldefault = WFNodeDtlFieldManager.getIsdefault();
                String dtlneed = WFNodeDtlFieldManager.getIsneed();
%>
     <script language=javascript>
         fieldorders = new Array() ;
         isedits = new Array() ;
         ismands = new Array() ;
         var organizationidismand=0;
         var organizationidisedit=0;
     </script>
     <script type='text/javascript' src='/dwr/interface/BudgetHandler.js'></script>
     <script type='text/javascript' src='/dwr/engine.js'></script>
     <script type='text/javascript' src='/dwr/util.js'></script>
     <table class="viewform">
         <tr>
             <td>
             <%if(dtladd.equals("1")){%>
             <button type=button  Class=BtnFlow type=button accessKey=A onclick="addRow()"><U>A</U>-<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></BUTTON>
             <%}
            if(dtladd.equals("1") || dtldelete.equals("1")){%>
             <button type=button  Class=BtnFlow type=button accessKey=E onclick="deleteRow1();"><U>E</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
             <%}%>
             </td>
         </tr>
         <TR class="Spacing" style="height:1px;">
             <TD class="Line1"></TD>
         </TR>
         <tr>
             <td>
            <%
                String uid=""+creater;

                String uname = ResourceComInfo.getLastname(uid);
                String udept = ResourceComInfo.getDepartmentID(uid);
                String udeptname = DepartmentComInfo.getDepartmentname(udept);
                String usubcom = DepartmentComInfo.getSubcompanyid1(udept);
                weaver.hrm.company.SubCompanyComInfo scci = new weaver.hrm.company.SubCompanyComInfo();
                String usubcomname = scci.getSubCompanyname(usubcom);

             int colcount = 0 ;
             int colwidth = 0 ;
             fieldids.clear() ;
             fieldlabels.clear() ;
             fieldhtmltypes.clear() ;
             fieldtypes.clear() ;
             fieldnames.clear() ;
             fieldviewtypes.clear() ;
                String temporganizationidisview="0";
                String temporganizationidisedit="0";
                String temporganizationidismandatory="0";
                String temprogtypeisview="0";

             RecordSet.executeProc("workflow_billfield_Select",formid+"");
             while(RecordSet.next()){
                 String theviewtype = Util.null2String(RecordSet.getString("viewtype")) ;
                 if( !theviewtype.equals("1") ) continue ;   // 如果是单据的主表字段,不显示

                 fieldids.add(Util.null2String(RecordSet.getString("id")));
                 fieldlabels.add(Util.null2String(RecordSet.getString("fieldlabel")));
                 fieldhtmltypes.add(Util.null2String(RecordSet.getString("fieldhtmltype")));
                 fieldtypes.add(Util.null2String(RecordSet.getString("type")));
                 fieldnames.add(Util.null2String(RecordSet.getString("fieldname")));
                 fieldviewtypes.add(theviewtype);
             }

             // 确定字段是否显示，是否可以编辑，是否必须输入
             isfieldids.clear() ;              //字段队列
             isviews.clear() ;              //字段是否显示队列
             isedits.clear() ;              //字段是否可以编辑队列
             ismands.clear() ;              //字段是否必须输入队列

             RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
             while(RecordSet.next()){
                 String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
                 int thefieldidindex = fieldids.indexOf( thefieldid ) ;
                 if( thefieldidindex == -1 ) continue ;
                 String theisview = Util.null2String(RecordSet.getString("isview")) ;
                 String theisedit = Util.null2String(RecordSet.getString("isedit"));
                 String theismandatory = Util.null2String(RecordSet.getString("ismandatory"));
                 String thefieldname=(String)fieldnames.get(thefieldidindex);
//                 if(nodetype.equals("0")){
//                     if(thefieldname.equals("organizationtype")||thefieldname.equals("organizationid")||thefieldname.equals("budgetperiod")||thefieldname.equals("subject")){
//                        theisview="1";
//                        theisedit="1";
//                        theismandatory="1";
//                    }
//                 }
                 if(thefieldname.equals("organizationid")){
                     temporganizationidisview=theisview;
                     temporganizationidisedit=theisedit;
                     temporganizationidismandatory=theismandatory;
                 }
                 if(thefieldname.equals("organizationtype")) temprogtypeisview=theisview;
                 if( theisview.equals("1") ) colcount ++ ;
                 isfieldids.add(thefieldid);
                 isviews.add(theisview);
                 isedits.add(theisedit);
                 ismands.add(theismandatory);
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

             // 得到每个字段的信息并在页面显示
             int detailfieldcount = -1 ;
             String needcheckdtl="";
             for(int i=0;i<fieldids.size();i++){         // 循环开始

                 String fieldid=(String)fieldids.get(i);  //字段id
                 String isview="0" ;    //字段是否显示
                 String isedit="0" ;    //字段是否可以编辑
                 String ismand="0" ;    //字段是否必须输入

                 int isfieldidindex = isfieldids.indexOf(fieldid) ;
                 if( isfieldidindex != -1 ) {
                     isview=(String)isviews.get(isfieldidindex);    //字段是否显示
                     isedit=(String)isedits.get(isfieldidindex);    //字段是否可以编辑
                     ismand=(String)ismands.get(isfieldidindex);    //字段是否必须输入
                 }
                 String fieldname = "" ;                         //字段数据库表中的字段名
                 String fieldlable = "" ;                        //字段显示名
                 int languageid = 0 ;

                 fieldname=(String)fieldnames.get(i);
                 if(! isview.equals("1") &&fieldname.equals("organizationtype")){
                    isview=temporganizationidisview;
                    isedit=temporganizationidisedit;
                    ismand=temporganizationidismandatory;
                 }
                 if( ! isview.equals("1") ) continue ;           //不显示即进行下一步循环


                 languageid = user.getLanguage() ;
                 fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(i),0),languageid );

                 viewfieldnames.add(fieldname) ;
%>
                 <td width="<%=colwidth%>%"><%=fieldlable%></td>
                 <script language=javascript>
                    <% if (fieldname.equals("organizationid")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",organizationid_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 1 ;
                     organizationidismand=<%=ismand%>;
                     organizationidisedit=<%=isedit%>;
                    <% } else if (fieldname.equals("subject")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",subject_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 2 ;
                    <% } else if (fieldname.equals("budgetperiod")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",budgetperiod_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 3 ;
                    <% } else if (fieldname.equals("hrmremain")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",hrmremain_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 4 ;
                    <% } else if (fieldname.equals("deptremain")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",deptremain_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 5 ;
                    <% } else if (fieldname.equals("subcomremain")) { detailfieldcount++ ;
                       if(ismand.equals("1")) needcheckdtl += ",subcomremain_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 6 ;
                    <% } else if (fieldname.equals("relatedprj")) { detailfieldcount++ ;
                     if(ismand.equals("1")) needcheckdtl += ",relatedprj_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 7 ;
                    <% } else if (fieldname.equals("relatedcrm")) { detailfieldcount++ ;
                      if(ismand.equals("1")) needcheckdtl += ",relatedcrm_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 8 ;
                    <% } else if (fieldname.equals("description")) { detailfieldcount++ ;
                      if(ismand.equals("1")) needcheckdtl += ",description_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 9 ;
                    <% } else if (fieldname.equals("applyamount")) { detailfieldcount++ ;
                      if(ismand.equals("1")) needcheckdtl += ",applyamount_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 10 ;
                    <% } else if (fieldname.equals("amount")) { detailfieldcount++ ;
                      if(ismand.equals("1")) needcheckdtl += ",amount_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 11 ;
                    <% } else if (fieldname.equals("organizationtype")) { detailfieldcount++ ;
                      if(ismand.equals("1")) needcheckdtl += ",organizationtype_\"+insertindex+\"";
                    %>
                     fieldorders[<%=detailfieldcount%>] = 12 ;
                    <% } %>
                     isedits[<%=detailfieldcount%>] = <%=isedit%> ;
                     ismands[<%=detailfieldcount%>] = <%=ismand%> ;
                 </script>
<%          }
%>
               </tr>
<%
             BigDecimal amountsum = new BigDecimal("0") ;
             BigDecimal applyamountsum = new BigDecimal("0") ;
             boolean isttLight = false;
             int recorderindex = 0 ;
             sql="select *  from Bill_FnaPayApplyDetail where id="+billid+" order by dsporder";
             RecordSet.executeSql(sql);
             while(RecordSet.next()) {
                    int organizationtype = RecordSet.getInt("organizationtype");
                    int organizationid = RecordSet.getInt("organizationid");
                    String budgetperiod = RecordSet.getString("budgetperiod");
                    int subject = RecordSet.getInt("subject");
                    double tempappamount=Util.getDoubleValue(RecordSet.getString("applyamount"),0);
                    BudgetHandler bp = new BudgetHandler();
                    String kpi = bp.getBudgetKPI(budgetperiod, organizationtype, organizationid, subject);
                    String kpi1=kpi.substring(0,kpi.indexOf("|"));
                    String kpi11=kpi1.substring(0,kpi1.indexOf(","));
                    String kpi12=kpi1.substring(kpi1.indexOf(",")+1,kpi1.lastIndexOf(","));
                    String kpi13=kpi1.substring(kpi1.lastIndexOf(",")+1) ;
                     String span1 = "<span><span style='white-space :nowrap'>" + SystemEnv.getHtmlLabelName(18768, user.getLanguage()) + ":" + kpi11 + "</span><br><span style='white-space :nowrap;color:red'>" + SystemEnv.getHtmlLabelName(18503, user.getLanguage()) + ":" + kpi12 + "</span><br><span style='white-space :nowrap;color:green'> " + SystemEnv.getHtmlLabelName(18769, user.getLanguage()) + ":" + kpi13 + "</span></span>";

                     String kpi2 = kpi.substring(kpi.indexOf("|") + 1, kpi.lastIndexOf("|"));
                     String kpi21 = kpi2.substring(0, kpi2.indexOf(","));
                     String kpi22 = kpi2.substring(kpi2.indexOf(",") + 1, kpi2.lastIndexOf(","));
                     String kpi23 = kpi2.substring(kpi2.lastIndexOf(",") + 1);
                     String span2 = "<span><span style='white-space :nowrap'>" + SystemEnv.getHtmlLabelName(18768, user.getLanguage()) + ":" + kpi21 + "</span><br><span style='white-space :nowrap;color:red'>" + SystemEnv.getHtmlLabelName(18503, user.getLanguage()) + ":" + kpi22 + "</span><br><span style='white-space :nowrap;color:green'>" + SystemEnv.getHtmlLabelName(18769, user.getLanguage()) + ":" + kpi23 + "</span></span>";

                     String kpi3 = kpi.substring(kpi.lastIndexOf("|") + 1);
                     String kpi31 = kpi3.substring(0, kpi3.indexOf(","));
                     String kpi32 = kpi3.substring(kpi3.indexOf(",") + 1, kpi3.lastIndexOf(","));
                     String kpi33 = kpi3.substring(kpi3.lastIndexOf(",") + 1);
                     String span3 = "<span><span style='white-space :nowrap'>" + SystemEnv.getHtmlLabelName(18768, user.getLanguage()) + ":" + kpi31 + "</span><br><span style='white-space :nowrap;color:red'>" + SystemEnv.getHtmlLabelName(18503, user.getLanguage()) + ":" + kpi32 + "</span><br><span style='white-space :nowrap;color:green'>" + SystemEnv.getHtmlLabelName(18769, user.getLanguage()) + ":" + kpi33 + "</span></span>";

                 isttLight = !isttLight ;
%>
               <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
                 <td width="5%"><input type='checkbox' name='check_node' value='<%=recorderindex%>' <%if(!dtldelete.equals("1")){%>disabled<%}%>></td>
<%
                 for(int i=0;i<fieldids.size();i++){         // 循环开始

                     String fieldid=(String)fieldids.get(i);  //字段id
                     String isview="0" ;    //字段是否显示
                     String isedit="0" ;    //字段是否可以编辑
                     String ismand="0" ;    //字段是否必须输入

                     int isfieldidindex = isfieldids.indexOf(fieldid) ;
                     if( isfieldidindex != -1 ) {
                         isview=(String)isviews.get(isfieldidindex);    //字段是否显示
                         isedit=(String)isedits.get(isfieldidindex);    //字段是否可以编辑
                         ismand=(String)ismands.get(isfieldidindex);    //字段是否必须输入
                     }
                     if(!"1".equals(dtledit)){
                        isedit="0";
				    }
                     String fieldname = (String)fieldnames.get(i);   //字段数据库表中的字段名
                     String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;
					 String fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(i),0),user.getLanguage() );
                     if(! isview.equals("1") &&fieldname.equals("organizationtype")){
                        isview=temporganizationidisview;
                        isedit=temporganizationidisedit;
                        ismand=temporganizationidismandatory;
                     }
                     if( ! isview.equals("1") ) {
%>
                     <input type=hidden name="<%=fieldname%>_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
                     }
                     else {
                         if(ismand.equals("1"))  needcheck+= ","+fieldname+"_"+recorderindex;
                         //如果必须输入,加入必须输入的检查中
%>                  <td>
<%
                         String showname = "" ;
                         if( fieldname.equals("organizationtype"))  {
                             String orgtype= RecordSet.getString("organizationtype");
                             if(orgtype.equals("3")){
                            showname = SystemEnv.getHtmlLabelName(6087,user.getLanguage());
                            }else if(orgtype.equals("2")){
                            showname = SystemEnv.getHtmlLabelName(124,user.getLanguage());
                            }else if(orgtype.equals("1")){
                            showname = SystemEnv.getHtmlLabelName(141,user.getLanguage());
                            }
                             if(isedit.equals("1") && isremark==0 ){
%>
                     <select id="organizationtype_<%=recorderindex%>" name="organizationtype_<%=recorderindex%>" onchange="clearSpan(<%=recorderindex%>)"><option value=3 <%if(orgtype.equals("3")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(6087,user.getLanguage())%></option><option value=2  <%if(orgtype.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option><option value=1 <%if(orgtype.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></option></select>
<%
                             }else{
%>
                     <input type=hidden id="organizationtype_<%=recorderindex%>" name="organizationtype_<%=recorderindex%>"  value="<%=orgtype%>"><%=showname%>
<%}%>
                     <%
                         }else if( fieldname.equals("organizationid"))  {
                             String orgtype= RecordSet.getString("organizationtype");
                            out.write("<div ");
                            if(orgtype.equals("3")){
                            showname = "<A href='javaScript:openhrm("+fieldvalue+");' onclick='pointerXY(event);'>"+Util.toScreen(ResourceComInfo.getLastname(fieldvalue),user.getLanguage()) +"</A>";
                            if(!fieldvalue.equals(uid)&&!fieldvalue.equals("0")) out.write("style='background:#ff9999'");
                            }else if(orgtype.equals("2")){
                            showname = "<A href='/hrm/company/HrmDepartmentDsp.jsp?id="+fieldvalue+"'>"+Util.toScreen(DepartmentComInfo.getDepartmentname(fieldvalue),user.getLanguage()) +"</A>";
                            if(!fieldvalue.equals(udept)&&!fieldvalue.equals("0")) out.write("style='background:#ff9999'");
                            }else if(orgtype.equals("1")){
                            showname = "<A href='/hrm/company/HrmSubCompanyDsp.jsp?id="+fieldvalue+"'>"+Util.toScreen(SubCompanyComInfo.getSubCompanyname(fieldvalue),user.getLanguage())+"</A>";
                            if(!fieldvalue.equals(usubcom)&&!fieldvalue.equals("0")) out.write("style='background:#ff9999'");
                            }
                            out.write("><div>");
                             if( fieldvalue.equals("0") ) fieldvalue = "" ;
                             if(isedit.equals("1") && isremark==0 ){
%>
                     <button type=button  class=Browser onclick="onShowOrganization('organizationspan_<%=recorderindex%>', 'organizationid_<%=recorderindex%>',<%=ismand%>,<%=recorderindex%>)"></button>
<%
                             }
%>
                     <span id="organizationspan_<%=recorderindex%>"><%=showname%>
<%
                             if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                     <img src="/images/BacoError.gif" align=absmiddle>
<%
                             }
%>
                     </span> <input type=hidden id="organizationid_<%=recorderindex%>" name="organizationid_<%=recorderindex%>"  value="<%=fieldvalue%>">
                     <% out.write("</div></div>");
                         }
                         else if( fieldname.equals("subject")) {
                                                     showname = Util.toScreen(BudgetfeeTypeComInfo.getBudgetfeeTypename(fieldvalue),user.getLanguage()) ;
                                                     if( fieldvalue.equals("0") ) fieldvalue = "" ;
                                                     if(isedit.equals("1") && isremark==0 ){
%>
                                             <button type=button  class=Browser onclick="onShowSubject(subjectspan_<%=recorderindex%>,subject_<%=recorderindex%>,<%=ismand%>,<%=recorderindex%>)"></button>
<%
                                                     }
%>
                                             <span id="subjectspan_<%=recorderindex%>"><%=showname%>
<%
                                                     if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                                             <img src="/images/BacoError.gif" align=absmiddle>
<%
                                                     }
%>
                                             </span> <input type=hidden id="subject_<%=recorderindex%>" name="subject_<%=recorderindex%>"  value="<%=fieldvalue%>">
<%
                                                 }
                         else if( fieldname.equals("budgetperiod")) {

                                                     if(isedit.equals("1") && isremark==0 ){
%>
                                             <button type=button  class=Browser onclick="onShowFWDate(budgetperiodspan_<%=recorderindex%>,budgetperiod_<%=recorderindex%>,<%=ismand%>,<%=recorderindex%>)"></button>
<%
                                                     }
%>
                                             <span id="budgetperiodspan_<%=recorderindex%>"><%=fieldvalue%>
<%
                                                     if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                                             <img src="/images/BacoError.gif" align=absmiddle>
<%
                                                     }
%>
                                             </span> <input type=hidden id="budgetperiod_<%=recorderindex%>" name="budgetperiod_<%=recorderindex%>"  value="<%=fieldvalue%>">
<%
                                                 }
                         else if( fieldname.equals("hrmremain"))  {

%>
                     <span id='hrmremainspan_<%=recorderindex%>'><%=span1%></span>

<%

                         }


                         else if( fieldname.equals("deptremain")) {

%>

                     <span id='deptremainspan_<%=recorderindex%>'><%=span2%></span>

<%

                         }



                else if( fieldname.equals("subcomremain"))  {

%>


                     <span id='subcomremainspan_<%=recorderindex%>'><%=span3%></span>
<%

                         }
                         else if( fieldname.equals("relatedprj"))  {
                             showname = "<A href='/proj/data/ViewProject.jsp?isrequest=1&ProjID="+fieldvalue+"'>"+Util.toScreen(ProjectInfoComInfo.getProjectInfoname(fieldvalue),user.getLanguage()) +"</A>";
                             if( fieldvalue.equals("0") ) fieldvalue = "" ;
                             if(isedit.equals("1") && isremark==0 ){
%>
                     <button type=button  class=Browser onclick="onShowPrj(relatedprjspan_<%=recorderindex%>,relatedprj_<%=recorderindex%>,<%=ismand%>,<%=recorderindex%>)"></button>
<%
                             }
%>
                     <span id="relatedprjspan_<%=recorderindex%>"><%=showname%>
<%
                             if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                     <img src="/images/BacoError.gif" align=absmiddle>
<%
                             }
%>
                     </span> <input type=hidden id="relatedprj_<%=recorderindex%>" name="relatedprj_<%=recorderindex%>"  value="<%=fieldvalue%>">
<%
                         }

                         else if( fieldname.equals("relatedcrm")) {
                             showname = "<A href='/CRM/data/ViewCustomer.jsp?isrequest=1&CustomerID="+fieldvalue+"'>"+Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(fieldvalue),user.getLanguage()) +"</A>";
                             if( fieldvalue.equals("0") ) fieldvalue = "" ;
                             if(isedit.equals("1") && isremark==0 ){
%>
                     <button type=button  class=Browser onclick="onShowCrm(relatedcrmspan_<%=recorderindex%>,relatedcrm_<%=recorderindex%>,<%=ismand%>,<%=recorderindex%>)"></button>
<%
                             }
%>
                     <span id="relatedcrmspan_<%=recorderindex%>"><%=showname%>
<%
                             if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                     <img src="/images/BacoError.gif" align=absmiddle>
<%
                             }
%>
                     </span> <input type=hidden id="relatedcrm_<%=recorderindex%>" name="relatedcrm_<%=recorderindex%>"  value="<%=fieldvalue%>">
<%
                         }                                          // customerid 按钮条件结束


                    else if( fieldname.equals("description")) {
                             if(isedit.equals("1") && isremark==0 ){
                                 if(ismand.equals("1")) {
%>
                     <input type=text class=inputstyle  name="description_<%=recorderindex%>" style="width:85%" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" onChange="checkLength('description_<%=recorderindex%>','100','<%=fieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>');checkinput('description_<%=recorderindex%>','descriptionspan_<%=recorderindex%>')">
                     <span id="descriptionspan_<%=recorderindex%>"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%

                                 }else{%>
                     <input type=text class=inputstyle  name="description_<%=recorderindex%>" onBlur="checkLength('description_<%=recorderindex%>','100','<%=fieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" style="width:85%">
<%                              }
                             }
                             else {
%>
                    <%=Util.toScreen(fieldvalue,user.getLanguage())%>
                     <input type=hidden name="description_<%=recorderindex%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>">
<%
                             }
                         }
                             else if( fieldname.equals("applyamount")) {
                                                         if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                                                         else
                                                             applyamountsum = applyamountsum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                                                         if(isedit.equals("1") && isremark==0 ){
                                                             if(ismand.equals("1")) {
%>
                                                 <input type=text class=inputstyle  name="applyamount_<%=recorderindex%>" style="width:85%" value="<%=fieldvalue%>" maxlength="10" onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('applyamount_<%=recorderindex%>','applyamountspan_<%=recorderindex%>');changeapplynumber();">
                                                 <span id="applyamountspan_<%=recorderindex%>"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                                                             }else{
%>
                                                 <input type=text class=inputstyle  name="applyamount_<%=recorderindex%>" style="width:85%" value="<%=fieldvalue%>" maxlength="10" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this);changeapplynumber();'>
<%                               }
                                                         }
                                                         else {
%>
                    <%=fieldvalue%><input type=hidden name="applyamount_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
                                                         }
                                                     }
                             else if( fieldname.equals("amount")) {
                                                         if( Util.getDoubleValue(fieldvalue,0) == 0 ) fieldvalue="" ;
                                                         else
                                                             amountsum = amountsum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                                                         if(isedit.equals("1") && isremark==0 ){
                                                             if( Util.getDoubleValue(fieldvalue,0) == 0 ){
                                                             //TD12002
                                                             //fieldvalue=""+tempappamount ;
                                                             fieldvalue=""+new BigDecimal(tempappamount).divide (new BigDecimal(1), 3, BigDecimal.ROUND_HALF_UP ).toString() ;
                                                             amountsum = amountsum.add(new BigDecimal(Util.getDoubleValue(fieldvalue,0))) ;
                                                             }
                                                             if(ismand.equals("1")) {
%>
                                                 <input type=text class=inputstyle  name="amount_<%=recorderindex%>" style="width:85%" value="<%=fieldvalue%>" maxlength="10" onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('amount_<%=recorderindex%>','amountspan_<%=recorderindex%>');changenumber();">
                                                 <span id="amountspan_<%=recorderindex%>"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                                                             }else{
%>
                                                 <input type=text class=inputstyle  name="amount_<%=recorderindex%>" style="width:85%" value="<%=fieldvalue%>" maxlength="10" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this);changenumber();'>
<%                               }
                                                         }
                                                         else {
%>
                    <%=fieldvalue%><input type=hidden name="amount_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
                                                         }
                                                     }

%>
                     </td>
<%
                     }
                 }
                 recorderindex ++ ;
%>
               </tr>
<%          }   %>
               <tr class=TOTAL style="FONT-WEIGHT: bold; COLOR: red">
                 <td><%=SystemEnv.getHtmlLabelName(358,user.getLanguage())%></td>
<%          for(int i=0;i<viewfieldnames.size();i++){
                 String thefieldname = (String)viewfieldnames.get(i) ;
%>
                 <td <% if(thefieldname.equals("amount")) {%> id=amountsum
                    <% } %>
                     <% if(thefieldname.equals("applyamount")) {%> id=applyamountsum
                    <% } %>
                         >
                    <% if(thefieldname.equals("amount")) {
                         amountsum = amountsum.divide ( new BigDecimal ( 1 ), 3, BigDecimal.ROUND_HALF_UP ) ;
                         String amountsumstr = "&nbsp;" ;
                         if( amountsum.doubleValue() != 0 ) amountsumstr = ""+amountsum.doubleValue() ;
                    %><%=amountsum%>
                    <% } %>
                    <% if(thefieldname.equals("applyamount")) {
                         applyamountsum = applyamountsum.divide ( new BigDecimal ( 1 ), 3, BigDecimal.ROUND_HALF_UP ) ;
                         String applyamountsumstr = "&nbsp;" ;
                         if( applyamountsum.doubleValue() != 0 ) applyamountsumstr = ""+applyamountsum.doubleValue() ;
                    %><%=applyamountsum%>
                    <% } %>
                 </td>
<%          }
%>
               </tr>
             </table>
             </td>
         </tr>
     </table>
     <br>
     <input type='hidden' id=nodesnum name=nodesnum value="<%=recorderindex%>">
     <input type='hidden' id="indexnum" name="indexnum" value="<%=recorderindex%>">
     <input type='hidden' id=rowneed name=rowneed value="<%=dtlneed %>">
     

     <%@ include file="/workflow/request/WorkflowManageSign.jsp" %>
 </form>



 <script language=javascript>
  $GetEle("needcheck").value+=",<%=needcheck%>";
 rowindex = <%=recorderindex%> ;
 insertindex=<%=recorderindex%>;
 deleteindex=0;
 deletearray = new Array() ;
 thedeletelength=0;

 function addRow()
 {
     oRow = oTable.insertRow(rowindex+1);
     curindex=parseInt( $GetEle('nodesnum').value);

     for(j=0; j < fieldorders.length+1; j++) {
         oCell = oRow.insertCell(-1);
         oCell.style.height=24;
         oCell.style.background= "#D2D1F1";
         if( j == 0 ) {
             var oDiv = document.createElement("div");
             var sHtml = "<input type='checkbox' name='check_node' value='"+insertindex+"'>";
             oDiv.innerHTML = sHtml;
             oCell.appendChild(oDiv);
         } else {
             dsporder = fieldorders[j-1] ;
             isedit = isedits[j-1] ;
             ismand = ismands[j-1] ;

             if( isedit != 1 ) {
                 switch (dsporder) {
                     case 1 :
                         var oDiv = document.createElement("div");
                        var sHtml = "<span id='organizationspan_"+insertindex+"'>" ;
                         sHtml += "<a href='/hrm/company/HrmDepartmentDsp.jsp?id=<%=udept%>'><%=udeptname%></a>"; sHtml += "</span><input type=hidden id='organizationid_"+insertindex+"' name='organizationid_"+insertindex+"' value='<%=udept%>'>" ;
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                     case 4 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='hrmremainspan_" + insertindex + "'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break;
                     case 5 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='deptremainspan_" + insertindex + "'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break;
                     case 6 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='subcomremainspan_" + insertindex + "'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break;
                    case 12 :
                         var oDiv = document.createElement("div");
                        var sHtml = "<input type=hidden id='organizationtype_"+insertindex+"' name='organizationtype_"+insertindex+"' value=3><%=SystemEnv.getHtmlLabelName(6087,user.getLanguage())%>" ;
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                     default:
                         var oDiv = document.createElement("div");
                         var sHtml = "&nbsp;";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                 }
             } else {
                 switch (dsporder)  {
                     case 1 :
                         var oDiv = document.createElement("div");
                        var sHtml = "<button type=button  class=Browser onclick='onShowOrganization(\"organizationspan_"+insertindex+"\", \"organizationid_"+insertindex+"\","+ismand+","+insertindex+")'></button>"+"<span id='organizationspan_"+insertindex+"'>" ;
                        sHtml += "<a href='/hrm/company/HrmDepartmentDsp.jsp?id=<%=udept%>'><%=udeptname%></a>"; sHtml += "</span><input type=hidden id='organizationid_"+insertindex+"' name='organizationid_"+insertindex+"' value='<%=udept%>'>" ;
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                     case 2 :
                         var oDiv = document.createElement("div");
                         var sHtml = "<button type=button  class=Browser onclick='onShowSubject(subjectspan_"+insertindex+",subject_"+insertindex+","+ismand+","+insertindex+")'></button>"+"<span id='subjectspan_"+insertindex+"'>" ;
                         if(ismand == 1) sHtml += "<img src='/images/BacoError.gif' align=absmiddle>"; sHtml += "</span><input type=hidden id='subject_"+insertindex+"' name='subject_"+insertindex+"'>" ;
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 3 :
                        var oDiv = document.createElement("div");
                        var sHtml = "<button type=button  class=Browser onclick='onShowFWDate(budgetperiodspan_"+insertindex+",budgetperiod_"+insertindex+","+ismand+","+insertindex+")'></button>"+"<span id='budgetperiodspan_"+insertindex+"'>" ;
                        if(ismand == 1) sHtml += "<img src='/images/BacoError.gif' align=absmiddle>"; sHtml += "</span><input type=hidden id='budgetperiod_"+insertindex+"' name='budgetperiod_"+insertindex+"'>" ;
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                     case 4 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='hrmremainspan_"+insertindex+"'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 5 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='deptremainspan_"+insertindex+"'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 6 :
                         var oDiv = document.createElement("div");
                         sHtml = "<span id='subcomremainspan_"+insertindex+"'></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 7 :
                         var oDiv = document.createElement("div");
                         var sHtml = "<button type=button  class=Browser onclick='onShowPrj(relatedprjspan_"+insertindex+",relatedprj_"+insertindex+","+ismand+","+insertindex+")'></button>"+"<span id='relatedprjspan_"+insertindex+"'>" ;
                         if(ismand == 1) sHtml += "<img src='/images/BacoError.gif' align=absmiddle>"; sHtml += "</span><input type=hidden id='relatedprj_"+insertindex+"' name='relatedprj_"+insertindex+"'>" ;
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 8 :
                         var oDiv = document.createElement("div");
                         var sHtml = "<button type=button  class=Browser onclick='onShowCrm(relatedcrmspan_"+insertindex+",relatedcrm_"+insertindex+","+ismand+","+insertindex+")'></button>"+"<span id='relatedcrmspan_"+insertindex+"'>" ;
                         if(ismand == 1) sHtml += "<img src='/images/BacoError.gif' align=absmiddle>"; sHtml += "</span><input type=hidden id='relatedcrm_"+insertindex+"' name='relatedcrm_"+insertindex+"'>" ;
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 9 :
                         var oDiv = document.createElement("div");
						 var sfield="<%=user.getLanguage()%>";
                         var sHtml = "<nobr><input type='text' class=inputstyle style=width:85%  id='description_"+insertindex+"' title='说明'  name='description_"+insertindex+"'  onBlur='" ;
						 sHtml+="checkLength1(description_"+insertindex+",100,this.title,"+sfield+");";
                         if(ismand == 1)
                             sHtml += "checkinput1(description_"+ insertindex+",descriptionspan_"+insertindex+");" ;
                         sHtml += "'>" ;
                         if(ismand == 1)
                             sHtml += "<span id='descriptionspan_"+insertindex+"'><img src='/images/BacoError.gif' align=absmiddle></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                     case 10 :
                        var oDiv = document.createElement("div");
                        var sHtml = "<nobr><input type='text' class=inputstyle style=width:85%  id='applyamount_"+insertindex+"' name='applyamount_"+insertindex+"' maxlength='10' onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);" ;
                        if(ismand == 1)
                            sHtml += "checkinput1(applyamount_"+ insertindex+",applyamountspan_"+insertindex+");" ;
                        sHtml += "changeapplynumber();'>" ;
                        if(ismand == 1)
                            sHtml += "<span id='applyamountspan_"+insertindex+"'><img src='/images/BacoError.gif' align=absmiddle></span>";
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                     case 11 :
                         var oDiv = document.createElement("div");
                         var sHtml = "<nobr><input type='text' class=inputstyle style=width:85%  id='amount_"+insertindex+"' name='amount_"+insertindex+"' maxlength='10' onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);" ;
                         if(ismand == 1)
                             sHtml += "checkinput1(amount_"+ insertindex+",amountspan_"+insertindex+");" ;
                         sHtml += "changenumber();'>" ;
                         if(ismand == 1)
                             sHtml += "<span id='amountspan_"+insertindex+"'><img src='/images/BacoError.gif' align=absmiddle></span>";
                         oDiv.innerHTML = sHtml;
                         oCell.appendChild(oDiv);
                         break ;
                    case 12 :
                         var oDiv = document.createElement("div");
                        var sHtml = "<select id='organizationtype_"+insertindex+"' name='organizationtype_"+insertindex+"' onchange='clearSpan("+insertindex+")'><option value=2 default><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option><option value=1><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></option><option value=3><%=SystemEnv.getHtmlLabelName(6087,user.getLanguage())%></option></select>" ; 
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        break ;
                 }
             }
         }
     }
     if ("<%=needcheckdtl%>" != ""){
         $GetEle("needcheck").value += "<%=needcheckdtl%>";
    }
     insertindex = insertindex*1 +1;
     rowindex = curindex*1 +1;
     $GetEle("nodesnum").value = rowindex;
     $GetEle("indexnum").value = insertindex;

 }
<%
if(dtldefault.equals("1")&&recorderindex<1)
{
%>
addRow();
<%	
}
%>
<%
    String totallabel="";
    String periodlabel="";
    RecordSet.executeProc("workflow_billfield_Select",formid+"");
     while(RecordSet.next()){
         if(Util.null2String(RecordSet.getString("fieldname")).equals("total"))
           totallabel=Util.null2String(RecordSet.getString("id"));
         if(Util.null2String(RecordSet.getString("fieldname")).equals("budgetperiod"))
         periodlabel=Util.null2String(RecordSet.getString("id"));
     }

 %>
 function changenumber(){

     count = 0 ;
     try{
     for(j=0;j<insertindex;j++) {
         hasdelete = false ;
         for(k=0;k<deletearray.length;k++){
             if(j==deletearray[k])
             hasdelete=true;
         }
         if(hasdelete) continue ;
         count+= eval(toFloat( $GetEle("amount_"+j).value,0)) ;
     }
     var hasedit=false;
     amountsum.innerHTML = count.toFixed(3);
     if( $GetEle("field<%=totallabel%>")!=null){
          $GetEle("field<%=totallabel%>").value =  count.toFixed(3);
         if( $GetEle("field<%=totallabel%>").type!="hidden") hasedit=true;
     }
     if(!hasedit&& $GetEle("field<%=totallabel%>span")!=null)
      $GetEle("field<%=totallabel%>span").innerHTML =  count.toFixed(3);
    }catch(e){}
 }

function changeapplynumber(){

    count = 0 ;
    try{
    for(j=0;j<insertindex;j++) {
        hasdelete = false ;
        for(k=0;k<deletearray.length;k++){
            if(j==deletearray[k])
            hasdelete=true;
        }
        if(hasdelete) continue ;
        count+= eval(toFloat( $GetEle("applyamount_"+j).value,0)) ;
    }
    var hasedit=false;
    applyamountsum.innerHTML = count.toFixed(3);
    if( $GetEle("field<%=totallabel%>")!=null){
         $GetEle("field<%=totallabel%>").value =  count.toFixed(3);
        if( $GetEle("field<%=totallabel%>").type!="hidden") hasedit=true;
    }
    if(!hasedit&& $GetEle("field<%=totallabel%>span")!=null)
     $GetEle("field<%=totallabel%>span").innerHTML =  count.toFixed(3);
    }catch(e){}
}

 function toFloat(str , def) {
     if(isNaN(parseFloat(str))) return def ;
     else return str ;
 }

 function toInt(str , def) {
     if(isNaN(parseInt(str))) return def ;
     else return str ;
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
             var therowindex = 0 ;
             var rowsum1 = 0;
             rowindex=parseInt( $GetEle("nodesnum").value);
             for(i=len-1; i >= 0;i--) {
                 if (document.forms[0].elements[i].name=='check_node')
                     rowsum1 += 1;
             }
             for(i=len-1; i >= 0;i--) {
                 if (document.forms[0].elements[i].name=='check_node'){
                     if(document.forms[0].elements[i].checked==true) {
                         therowindex = document.forms[0].elements[i].value ;
                         deletearray[thedeletelength] = therowindex ;
                         thedeletelength ++ ;
                         oTable.deleteRow(rowsum1);
                         rowindex--;
                     }
                     rowsum1 -=1;
                 }
             }
             changeapplynumber() ;
             changenumber() ;
             $GetEle("nodesnum").value = rowindex ;
        }
    }else{
        alert('<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>');
		return;
    }
 }
function clearSpan(index) {
    if( $GetEle("organizationspan_"+index)!=null&&organizationidisedit==1){
    if(organizationidismand==1){
         $GetEle("organizationspan_"+index).innerHTML = "<img src='/images/BacoError.gif' align=absmiddle>";
    }else{
         $GetEle("organizationspan_"+index).innerHTML = "";
    }
     jQuery($GetEle("organizationspan_"+index)).parent().parent()[0].style.background= jQuery($GetEle("organizationtype_"+index)).parent().parent()[0].style.background;
    if ( $GetEle("organizationid_" + index) != null)  $GetEle("organizationid_"+index).value = "";
    if ( $GetEle("hrmremainspan_" + index) != null) {
       $GetEle("hrmremainspan_" + index).innerHTML = "";
    }
    if ( $GetEle("deptremainspan_" + index) != null) {
       $GetEle("deptremainspan_" + index).innerHTML = "";
    }
    if ( $GetEle("subcomremainspan_" + index) != null) {
       $GetEle("subcomremainspan_" + index).innerHTML = "";
    }
    }
}
 function onShowOrganization(spanname, inputname, ismand, index) {
     if ( $GetEle("organizationtype_" + index).value == "3")
         return onShowHR($GetEle(spanname), $GetEle(inputname), ismand, index);
     else if ( $GetEle("organizationtype_" + index).value == "2")
         return onShowDept($GetEle(spanname), $GetEle(inputname), ismand, index);
     else if ( $GetEle("organizationtype_" + index).value == "1")
         return onShowSubcom($GetEle(spanname), $GetEle(inputname), ismand, index);
     else
         return null;
 }
 function onShowHR(spanname, inputname, ismand, index) {
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;", "", "dialogWidth:550px;dialogHeight:550px;");
    try {
	     if(id){
	        var jsid = new Array();
	        jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
	        jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
	     }
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0"&&jsid[0] != "") {
            spanname.innerHTML = "<A href='javaScript:openhrm("+jsid[0]+");' onclick='pointerXY(event);'>"+jsid[1]+"</A>";
            inputname.value = jsid[0];
            if(jsid[0]!=<%=uid%>)
            jQuery(spanname).parent().parent()[0].style.background='#ff9999';
            else
            if( $GetEle("organizationtype_"+index))
            jQuery(spanname).parent().parent()[0].style.background= jQuery($GetEle("organizationtype_"+index)).parent().parent()[0].style.background;
            else
            jQuery(spanname).parent().parent()[0].style.background="";
            if( $GetEle("subject_" + index)!=null&& $GetEle("subject_" + index).value != "")
            getBudgetKpi(index,3, jsid[0], $GetEle("subject_" + index).value);
        } else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            inputname.value = "";
        }
    }
}

function onShowDept(spanname, inputname, ismand, index) {
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="+inputname.value, "", "dialogWidth:550px;dialogHeight:550px;", "", "dialogWidth:550px;dialogHeight:550px;");
    try {
     if(id){
        var jsid = new Array();
        jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
        jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
     }
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0") {
            spanname.innerHTML = "<A href='/hrm/company/HrmDepartmentDsp.jsp?id="+jsid[0]+"'>"+jsid[1]+"</A>";
            inputname.value = jsid[0];
            if(jsid[0]!=<%=udept%>)
            jQuery(spanname).parent().parent()[0].style.background='#ff9999';
            else
            if( $GetEle("organizationtype_"+index))
            jQuery(spanname).parent().parent()[0].style.background= jQuery($GetEle("organizationtype_"+index)).parent().parent()[0].style.background;
            else
            jQuery(spanname).parent().parent()[0].style.background="";
            if( $GetEle("subject_" + index)!=null&& $GetEle("subject_" + index).value != "")
            getBudgetKpi(index,2, jsid[0], $GetEle("subject_" + index).value);
        }else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            inputname.value = "";
        }
    }

}
function onShowSubcom(spanname, inputname, ismand, index) {
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;", "", "dialogWidth:550px;dialogHeight:550px;");
    try {
     if(id){
        var jsid = new Array();
        jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
        jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
     }
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0") {
            spanname.innerHTML = "<A href='/hrm/company/HrmSubCompanyDsp.jsp?id="+jsid[0]+"'>"+jsid[1]+"</A>";
            inputname.value = jsid[0];
            if(jsid[0]!=<%=usubcom%>)
            jQuery(spanname).parent().parent()[0].style.background='#ff9999';
            else
            if( $GetEle("organizationtype_"+index))
            jQuery(spanname).parent().parent()[0].style.background= jQuery($GetEle("organizationtype_"+index)).parent().parent()[0].style.background;
            else
            jQuery(spanname).parent().parent()[0].style.background="";
            if( $GetEle("subject_" + index)!=null&& $GetEle("subject_" + index).value != "")
            getBudgetKpi(index,1, jsid[0], $GetEle("subject_" + index).value);
        }else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            inputname.value = "";
        }
    }
}
 function onShowSubject(spanname, inputname, ismand, index) {
     id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;");
     try {
      if(id){
         var jsid = new Array();
         jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
         jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
       }
     } catch(e) {
         return;
     }
     if (jsid != null) {
         if (jsid[0] != "0"  && jsid[0] != ""){
             spanname.innerHTML = jsid[1];
             inputname.value = jsid[0];
             changeSubject(index,jsid[0]);
         }else {
             if (ismand == 1)
                 spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
             else
                 spanname.innerHTML = "";
             inputname.value = "";
         }
     }
 }
 function onShowPrj(spanname, inputname, ismand, index) {
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;");
    try {
     if(id){
        var jsid = new Array();
        jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
        jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
     }
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0" && jsid[0] != ""){
            spanname.innerHTML = "<A href='/proj/data/ViewProject.jsp?isrequest=1&ProjID="+jsid[0]+"'>"+jsid[1]+"</A>";
            inputname.value = jsid[0];
        }else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            inputname.value = "";
        }
    }
}
function onShowCrm(spanname, inputname, ismand, index) {
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;", "", "dialogWidth:550px;dialogHeight:550px;");
    try {
     if(id){
        var jsid = new Array();
        jsid[0] = wuiUtil.getJsonValueByIndex(id, 0); 
        jsid[1] = wuiUtil.getJsonValueByIndex(id, 1);
     }
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0" && jsid[0] != ""){
            spanname.innerHTML = "<A href='/CRM/data/ViewCustomer.jsp?isrequest=1&CustomerID="+jsid[0]+"'>"+jsid[1]+"</A>";
            inputname.value = jsid[0];
        }else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            inputname.value = "";
        }
    }
}
function onShowFWDate(spanname, inputname, ismand, index) {
    var oncleaingFun = function(){
          if (ismand == 1)
             spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
          else
             spanname.innerHTML = "";
        inputname.value="";
	}
	WdatePicker({el:spanname,onpicked:function(dp){
		var returndate = dp.cal.getDateStr();
		if (returndate != null) {
        if (returndate != ""){
            $dp.$(inputname).value = returndate;
            if( $GetEle("subject_" + index)!=null&& $GetEle("subject_" + index).value != "")
            changePeriod(index);
        }else {
            if (ismand == 1)
                spanname.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            else
                spanname.innerHTML = "";
            $dp.$(inputname).value = "";
        }
      }
	},oncleared:oncleaingFun});

	if(ismand == 1){
	 var hidename = $(inputname).value;
	 if(hidename != ""){
		$(inputname).value = hidename; 
		$(spanname).innerHTML = hidename;
	 }else{
	  $(spanname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	 }
    }
}
 function changeSubject(index, subjid) {
     if( $GetEle("organizationtype_" + index)!=null){
     organizationtypeval =  $GetEle("organizationtype_" + index).value;
     organizationidval =  $GetEle("organizationid_" + index).value;
     getBudgetKpi(index, organizationtypeval, organizationidval, subjid);
     }
 }
 function changePeriod(index) {
             if( $GetEle("subject_" + index)!=null&& $GetEle("subject_" + index).value != "")
               changeSubject(index, $GetEle("subject_" + index).value)
 }

function callback(o, index) {
    val = o.split("|");
    if ( $GetEle("hrmremainspan_" + index) != null) {
        if (val[0] != "") {
            v = val[0].split(",");
             $GetEle("hrmremainspan_" + index).innerHTML = "<span ><span style='white-space :nowrap'><%=SystemEnv.getHtmlLabelName(18768,user.getLanguage())%>:" + v[0] + "</span><br><span style='white-space :nowrap;color:red' ><%=SystemEnv.getHtmlLabelName(18503,user.getLanguage())%>:" + v[1] + "</span><br><span style='white-space :nowrap;color:green' ><%=SystemEnv.getHtmlLabelName(18769,user.getLanguage())%>:" + v[2] + "</span></span>"
        }
    }
    if ( $GetEle("deptremainspan_" + index) != null) {
        if (val[1] != "") {
            v = val[1].split(",");
             $GetEle("deptremainspan_" + index).innerHTML = "<span ><span style='white-space :nowrap'><%=SystemEnv.getHtmlLabelName(18768,user.getLanguage())%>:" + v[0] + "</span><br><span style='white-space :nowrap;color:red' ><%=SystemEnv.getHtmlLabelName(18503,user.getLanguage())%>:" + v[1] + "</span><br><span style='white-space :nowrap;color:green' ><%=SystemEnv.getHtmlLabelName(18769,user.getLanguage())%>:" + v[2] + "</span></span>"
        }
    }
    if ( $GetEle("subcomremainspan_" + index) != null) {
        if (val[2] != "") {
            v = val[2].split(",");
             $GetEle("subcomremainspan_" + index).innerHTML = "<span ><span style='white-space :nowrap'><%=SystemEnv.getHtmlLabelName(18768,user.getLanguage())%>:" + v[0] + "</span><br><span style='white-space :nowrap;color:red' ><%=SystemEnv.getHtmlLabelName(18503,user.getLanguage())%>:" + v[1] + "</span><br><span style='white-space :nowrap;color:green' ><%=SystemEnv.getHtmlLabelName(18769,user.getLanguage())%>:" + v[2] + "</span></span>"
        }
    }
}
 function getBudgetKpi(index, organizationtype, organizationid, subjid) {
     var callbackProxy = function(o) {
         callback(o, index);
     };
     var callMetaData = { callback:callbackProxy };

     if ( $GetEle("budgetperiod_"+index)!= null&& $GetEle("budgetperiod_"+index).value!= ""&& $GetEle("organizationid_"+index)!= null&& $GetEle("organizationid_"+index).value!= ""&& $GetEle("subject_"+index)!= null&& $GetEle("subject_"+index).value!= "")
         BudgetHandler.getBudgetKPI( $GetEle("budgetperiod_"+index).value, organizationtype, organizationid, subjid, callMetaData);
 }
function checknumber1(objectname)
{
	valuechar = objectname.value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=".") isnumber = true ;}
	if(isnumber) objectname.value = "" ;
}

 </script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
