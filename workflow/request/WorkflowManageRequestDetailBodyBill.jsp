<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.workflow.datainput.DynamicDataInput"%>
<%@ page import="weaver.conn.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="requestPreAddM" class="weaver.workflow.request.RequestPreAddinoperateManager" scope="page" />
<jsp:useBean id="ResourceComInfo2" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo2" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="BrowserComInfo2" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rscount" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectInfoComInfo2" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo2" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="DocComInfo2" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="rs_item" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CapitalComInfo2" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo2" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<jsp:useBean id="rs_count" class="weaver.conn.RecordSet" scope="page"/> <!--xwj for @td2977 20051111-->
<jsp:useBean id="WfLinkageInfo" class="weaver.workflow.workflow.WfLinkageInfo" scope="page"/>
<jsp:useBean id="WFNodeDtlFieldManager" class="weaver.workflow.workflow.WFNodeDtlFieldManager" scope="page" />
<jsp:useBean id="docReceiveUnitComInfo_mdbb" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page"/>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
 <iframe id="datainputformdetail" frameborder=0 scrolling=no src=""  style="display:none" ></iframe>
<iframe id="selectChangeDetail" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
<%
String selectDetailInitJsStr = "";
String initDetailIframeStr = "";
String selectDetailInitJsStrAdd = "";
String initDetailIframeStrAdd = "";
    String isaffirmance=Util.null2String(request.getParameter("isaffirmance"));//�Ƿ���Ҫ�ύȷ��
    String reEdit=Util.null2String(request.getParameter("reEdit"));//�Ƿ�Ϊ�༭
    String requestid=Util.null2String(request.getParameter("requestid"));

    int creater = Util.getIntValue(request.getParameter("creater"),0);              //����Ĵ�����
    int creatertype = Util.getIntValue(request.getParameter("creatertype"),0);        //���������� 0: �ڲ��û� 1: �ⲿ�û�

    String needcheck="";
    String dlbodychangattrstr="";
    String formid=Util.null2String(request.getParameter("formid"));
    String nodeid=Util.null2String(request.getParameter("nodeid"));
	String workflowid=Util.null2String(request.getParameter("workflowid"));
    //String isbill=Util.null2String(request.getParameter("isbill"));
	String isbill="1";
    String currentdate=Util.null2String(request.getParameter("currentdate"));
	String currenttime=Util.null2String(request.getParameter("currenttime"));
    int isremark=Util.getIntValue(request.getParameter("isremark"),0);
    String nodetype=Util.null2String(request.getParameter("nodetype"));
    String docfileid=Util.null2String(request.getParameter("docfileid"));
    String newdocid=Util.null2String(request.getParameter("newdocid"));
    ArrayList seldefieldsdemanage=WfLinkageInfo.getSelectField(Util.getIntValue(workflowid),Util.getIntValue(nodeid),1);
    ArrayList changedefieldsdemanage=WfLinkageInfo.getChangeField(Util.getIntValue(workflowid),Util.getIntValue(nodeid),1);
    boolean IsCanModify="true".equals(session.getAttribute(user.getUID()+"_"+requestid+"IsCanModify"))?true:false;
    boolean editdetailbodyflag=false;
    if((isremark==0||IsCanModify) && (!isaffirmance.equals("1") || !nodetype.equals("0") || reEdit.equals("1"))) editdetailbodyflag=true;
    ArrayList defieldids=new ArrayList();             //�ֶζ���
    ArrayList defieldorders = new ArrayList();        //�ֶ���ʾ˳����� (�����ļ�����Ҫ)
    ArrayList delanguageids=new ArrayList();          //�ֶ���ʾ������(�����ļ�����Ҫ)
    ArrayList defieldlabels=new ArrayList();          //���ݵ��ֶε�label����
    ArrayList defieldhtmltypes=new ArrayList();       //���ݵ��ֶε�html type����
    ArrayList defieldtypes=new ArrayList();           //���ݵ��ֶε�type����
    ArrayList defieldnames=new ArrayList();           //���ݵ��ֶεı��ֶ�������
    ArrayList defieldviewtypes=new ArrayList();       //�����Ƿ���detail����ֶ�1:�� 0:��(�����,������ʾ)
    // ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
    ArrayList isdefieldids=new ArrayList();              //�ֶζ���
    ArrayList isdeviews=new ArrayList();              //�ֶ��Ƿ���ʾ����
    ArrayList isdeedits=new ArrayList();              //�ֶ��Ƿ���Ա༭����
    ArrayList isdemands=new ArrayList();              //�ֶ��Ƿ�����������
	ArrayList colCalAry = new ArrayList();
	boolean defshowsum=false;
	ArrayList childfieldids = new ArrayList();			//���ֶ�id����

	ArrayList inoperatefields = new ArrayList();
    ArrayList inoperatevalues = new ArrayList();
    int fieldop1id=0;
    requestPreAddM.setCreater(user.getUID());
    requestPreAddM.setOptor(user.getUID());
    requestPreAddM.setWorkflowid(Util.getIntValue(workflowid));
    requestPreAddM.setNodeid(Util.getIntValue(nodeid));
    Hashtable getPreAddRule_hs = requestPreAddM.getPreAddRule();
    inoperatefields = (ArrayList)getPreAddRule_hs.get("inoperatefields");
    inoperatevalues = (ArrayList)getPreAddRule_hs.get("inoperatevalues");

	ArrayList fieldrealtype=new ArrayList(); 
	int fieldlen=0;  //�ֶ����ͳ���
	String fielddbtype="";                              //�ֶ���������
    String isdeview="0" ;    //�ֶ��Ƿ���ʾ
    String isdeedit="0" ;    //�ֶ��Ƿ���Ա༭
    String isdemand="0" ;    //�ֶ��Ƿ��������
    String defieldid="";
    String defieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
    String defieldhtmltype = "" ;                     //�ֶε�ҳ������
    String defieldtype = "" ;                         //�ֶε�����
    String defieldlable = "" ;                        //�ֶ���ʾ��
    String defieldvalue="";
    String textheight1 = "4";//xwj for @td2977 20051111
    int delanguageid = 0 ;
    int colcount1 = 0;
    int colwidth1 = 0;
    String rowCalItemStr1,colCalItemStr1,mainCalStr1;
	rowCalItemStr1 = new String("");
	colCalItemStr1 = new String("");
    mainCalStr1 = new String("");
   
    int detailno=0;
    int detailsum=0;
    String sql = "" ;
    char flag = Util.getSeparator() ;
    int derecorderindex = 0 ;
	 //��ô����ֶ���
	DynamicDataInput ddidetail=new DynamicDataInput(workflowid+"");
	String trrigerdetailfield=ddidetail.GetEntryTriggerDetailFieldName();
    //�Բ�ͬ��ģ����˵,���Զ����Լ���ص����ݣ���Ϊ����Ĭ��ֵ�����罫 docid ��ֵ����Ϊ�������Ĭ���ĵ�
    //Ĭ�ϵ�ֵ���Ը�������м��ö��Ÿ�
    
    String prjid = Util.null2String(request.getParameter("prjid"));
    String docid = Util.null2String(request.getParameter("docid"));
    String crmid = Util.null2String(request.getParameter("crmid"));
    String hrmid = Util.null2String(request.getParameter("hrmid"));
    if(hrmid.equals("") && user.getLogintype().equals("1")) hrmid = "" + user.getUID() ;
    if(crmid.equals("") && user.getLogintype().equals("2")) crmid = "" + user.getUID() ;
    RecordSet billrs=new RecordSet();


              RecordSet.execute("select * from workflow_formdetailinfo where formid="+formid);
				while(RecordSet.next()){
					rowCalItemStr1 = Util.null2String(RecordSet.getString("rowCalStr"));
					colCalItemStr1 = Util.null2String(RecordSet.getString("colCalStr"));
					mainCalStr1 = Util.null2String(RecordSet.getString("mainCalStr"));
                    //System.out.println("colCalItemStr1 = " + colCalItemStr1);
				}
              StringTokenizer stk = new StringTokenizer(colCalItemStr1,";");
              while(stk.hasMoreTokens()){
                colCalAry.add(stk.nextToken());
              }
			  billrs.execute("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
              //System.out.println("select tablename,title from Workflow_billdetailtable where billid="+formid+" order by orderid");
              while(billrs.next()){
                String tablename=billrs.getString("tablename");
                String tabletitle=billrs.getString("title");
                boolean deshowaddbutton=false;
                defieldids.clear() ;
                defieldlabels.clear() ;
                defieldhtmltypes.clear() ;
                defieldtypes.clear() ;
                defieldnames.clear() ;
                defieldviewtypes.clear() ;
				fieldrealtype.clear() ;
				childfieldids.clear();
				defshowsum=false;
				colcount1 = 0;

                rs.execute("select * from workflow_billfield where viewtype='1' and billid="+formid+" and detailtable='"+tablename+"' ORDER BY dsporder");
                //System.out.println("select * from workflow_billfield where viewtype='1' and billid="+formid+" and detailtable='"+tablename+"'");
                while(rs.next()){
                    //String theviewtype = Util.null2String(rs.getString("viewtype")) ;
                    //if( !theviewtype.equals("1") ) continue ;   // ����ǵ��ݵ������ֶ�,����ʾ
                    defieldids.add(Util.null2String(rs.getString("id")));
                    defieldlabels.add(SystemEnv.getHtmlLabelName(Util.getIntValue(rs.getString("fieldlabel")),user.getLanguage()));
                    defieldhtmltypes.add(Util.null2String(rs.getString("fieldhtmltype")));
                    defieldtypes.add(Util.null2String(rs.getString("type")));
                    defieldnames.add(Util.null2String(rs.getString("fieldname")));
					fieldrealtype.add(Util.null2String(rs.getString("fielddbtype")));
					childfieldids.add(""+Util.getIntValue(rs.getString("childfieldid"), 0));
                    //defieldviewtypes.add(theviewtype);
                }

                // ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
                isdefieldids.clear() ;              //�ֶζ���
                isdeviews.clear() ;              //�ֶ��Ƿ���ʾ����
                isdeedits.clear() ;              //�ֶ��Ƿ���Ա༭����
                isdemands.clear() ;              //�ֶ��Ƿ�����������

                //RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
                rs.execute("SELECT DISTINCT a.*, b.dsporder FROM workflow_nodeform a ,workflow_billfield b where a.fieldid = b.id and b.viewtype='1' and b.billid ="+formid+" and a.nodeid="+nodeid+" and b.detailtable='"+tablename+"' ORDER BY b.dsporder");
                //System.out.println("SELECT DISTINCT a.*, b.dsporder FROM workflow_nodeform a ,workflow_billfield b where a.fieldid = b.id and b.viewtype='1' and b.billid ="+formid+" and a.nodeid="+nodeid+" and b.detailtable='"+tablename+"' ORDER BY b.dsporder");
                
                while(rs.next())
                {
                    String thedefieldid = Util.null2String(rs.getString("fieldid")) ;
                    //System.out.println("thedefieldid:"+thedefieldid);
                    int thefieldidindex = defieldids.indexOf( thedefieldid ) ;
                    if( thefieldidindex == -1 )
                    {
                        continue ;
                    }
                    String theisdeview = Util.null2String(rs.getString("isview")) ;
                    if( theisdeview.equals("1") ) 
                    {
						colcount1 ++ ;
						if(!defshowsum)
						{
	                        if(colCalAry.indexOf("detailfield_"+thedefieldid)>-1)
	                        {
	                            defshowsum=true;
	                        }
                        }
					}
                    String theisedit = Util.null2String(rs.getString("isedit")) ;
                    if(theisedit.equals("1"))
                    {
                    	if(!deshowaddbutton) deshowaddbutton=true;
                    }
                    isdefieldids.add(thedefieldid);
                    isdeviews.add(theisdeview);
                    isdeedits.add(theisedit);
                    isdemands.add(Util.null2String(rs.getString("ismandatory")));
                }                                

								//��ȡ��ϸ������
                WFNodeDtlFieldManager.setNodeid(Integer.parseInt(nodeid));
                WFNodeDtlFieldManager.setGroupid(detailno);
                WFNodeDtlFieldManager.selectWfNodeDtlField();
                String dtladd = WFNodeDtlFieldManager.getIsadd();
                String dtledit = WFNodeDtlFieldManager.getIsedit();
                String dtldelete = WFNodeDtlFieldManager.getIsdelete();
                String dtldefault = WFNodeDtlFieldManager.getIsdefault();
                String dtlneed = WFNodeDtlFieldManager.getIsneed();

                if(colcount1>0){    //if start
                    colwidth1=97/colcount1;
					detailsum++;
%>
                <table class=form style="LEFT: 0px; WIDTH: 100%;WORD-WRAP: break-word">

                        <tr><td height=15 colspan=2></td></tr>
                        <tr>
                            <td align="left"><font style="font-size:10pt;"><b><%=tabletitle%></b></font></td>
                            <td align="right">
                            <%if(!editdetailbodyflag||isremark==5||isremark==9||nodetype.equals("3")){%>
                            &nbsp;
                            <%}else{%>
                            	<%if(dtladd.equals("1")){%>
                            <BUTTON type=button  Class=BtnFlow type=button accessKey=A onclick="addRow<%=detailno%>(<%=detailno%>)"><U>A</U>-<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></BUTTON>
                            	<%}%>
                            	<%if(dtladd.equals("1")||dtldelete.equals("1")){%>
                            <BUTTON type=button  Class=BtnFlow type=button accessKey=E onclick="deleteRow1(<%=detailno%>);"><U>E</U>-<%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></BUTTON>
                            	<%}%>
                            <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan=2>
<div id="workflowDetailArea">
                            <table Class=ListStyle id="oTable<%=detailno%>" >
                              <COLGROUP>
                              <TBODY>
                              <tr class=header>
                                <td width="3%">��</td>
								<td width="3%"><%=SystemEnv.getHtmlLabelName(15486,user.getLanguage())%></td>
                   <%     }
                       ArrayList viewfieldnames = new ArrayList();

                       // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
					   int isfieldidindex = -1;
                       for (int i = 0; i < defieldids.size(); i++) {         // headerѭ����ʼ

                           defieldid=(String)defieldids.get(i);  //�ֶ�id
                           isfieldidindex = isdefieldids.indexOf(defieldid) ;
                           if( isfieldidindex != -1 ) {
                        	   isdeview=(String)isdeviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                        	   isdeedit=(String)isdeedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
                        	   isdemand=(String)isdemands.get(isfieldidindex);    //�ֶ��Ƿ��������
                           }
                		   defieldlable =(String)defieldlabels.get(i);
                		   defieldname = (String)defieldnames.get(i);
                		   defieldhtmltype = (String) defieldhtmltypes.get(i);

                		  if( ! isdeview.equals("1") ) continue;  //����ʾ��������һ��ѭ��

                           viewfieldnames.add(defieldname);
                           if(colcount1!=0){
                   %>
                                <td width="<%=colwidth1%>%" nowrap align="center"><%=defieldlable%></td>
                           <%   }
                       }     //header ѭ������
                               if(colcount1!=0){
                    %>
                              </tr>
                        <%      }
                        boolean isttLight = false;
                        String maintable="";
                        derecorderindex = 0 ;
                        String submitdtlid="";
                        rs.executeSql(" select tablename from Workflow_bill where id="+formid);
                        if(rs.next()){
                            maintable=rs.getString("tablename");
                            RecordSet rs3=new RecordSet();
                            //System.out.println("select b.* from "+maintable+" a,"+tablename+" b where a.id=b.mainid and a.requestid ="+requestid);
                            if(maintable.indexOf("formtable_main_")==0&&tablename.indexOf("formtable_main_")==0){//�±�
                                rs3.executeSql("select b.* from "+maintable+" a,"+tablename+" b where a.id=b.mainid and a.requestid ="+requestid+" order by b.id");
                            }else if(Util.getIntValue(formid)<0){     //��������ģ�鴴������ϸ����
                                rs3.executeSql("select b.* from "+maintable+" a,"+tablename+" b where a.id=b.mainid and a.requestid ="+requestid+" order by b.inputid");
                            }else{
                                rs3.executeSql("select b.* from "+maintable+" a,"+tablename+" b where a.id=b.mainid and a.requestid ="+requestid);
                            }
                            while(rs3.next()){
                                String maincolvalue=rs3.getString(1);
                                String[] colnames = rs3.getColumnName();
                                if (colnames != null) {
                                    for (int m = 0; m < colnames.length; m++) {
                                        if (colnames[m].toUpperCase().equals("ID")) {
                                            maincolvalue = rs3.getString("id");
                                            break;
                                        } else if (colnames[m].toUpperCase().equals("INPUTID")) {
                                            maincolvalue = rs3.getString("inputid");
                                            break;
                                        }
                                    }
                                }
                                isttLight = !isttLight ;
                                if(colcount1!=0){
                        %>
                        <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
                        <td width="3%" style="background:#E7E7E7">
                        <input type='checkbox' name='check_node<%=detailno%>' value="<%=derecorderindex%>" <%if(!dtldelete.equals("1")||!editdetailbodyflag||isremark==5||nodetype.equals("3")){%>disabled<%}%>>
                        <input type='hidden' name='dtl_id_<%=detailno%>_<%=derecorderindex%>' value="<%=maincolvalue%>">
                        </td>
                        <td class="field"><%=derecorderindex+1%></td>
                        <%         }
                                for(int i=0;i<defieldids.size();i++){         // ��ϸ��¼ѭ����ʼ
                                    defieldid=(String)defieldids.get(i);  //�ֶ�id
                                    defieldname = (String)defieldnames.get(i);  //�ֶ���
                                    //System.out.println("defieldname:"+defieldname);
                                    defieldtype = (String)defieldtypes.get(i);
                                    String trrigerdetailStr = "";
									if (trrigerdetailfield.indexOf("field"+defieldid)>=0){
										trrigerdetailStr = "datainputd(field" + defieldid + "_"+derecorderindex+")";
									}

                                    isfieldidindex = isdefieldids.indexOf(defieldid) ;
                                    if( isfieldidindex != -1 ) {
                                 	   isdeview=(String)isdeviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                                 	   isdeedit=(String)isdeedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
                                 	   isdemand=(String)isdemands.get(isfieldidindex);    //�ֶ��Ƿ��������
                                    }
                                    defieldhtmltype = (String) defieldhtmltypes.get(i);
									defieldlable =(String)defieldlabels.get(i);
									 fielddbtype=(String)fieldrealtype.get(i);
									 fieldlen=0;
									if ((fielddbtype.toLowerCase()).indexOf("varchar")>-1)
									{
									   fieldlen=Util.getIntValue(fielddbtype.substring(fielddbtype.indexOf("(")+1,fielddbtype.length()-1));
									
									}
									if(!"1".equals(dtledit)){
										isdeedit="0";
										isdemand="0";
									}
                                    if(isremark==5 || isremark==9){
                                        isdeedit = "0";//����(���ύ)���ɱ༭
                                        isdemand="0";
                                    }
                                    //if( ! isdeview.equals("1") ) continue;  //����ʾ��������һ��ѭ��
                                    defieldvalue=Util.null2String(rs3.getString(defieldname)) ;
                                    //System.out.println("defieldvalue:"+defieldvalue);
                                    if (isdemand.equals("1"))   //�����������,�����������ļ����
                                      needcheck += ",field" + defieldid + "_"+derecorderindex;
                                    if(colcount1!=0){
                        
                       if(  isdeview.equals("1") ) {%> <td class=field <%if(defieldhtmltype.equals("1") && !isdeedit.equals("1") && (defieldtype.equals("2") || defieldtype.equals("3"))){%> align="right" style="TEXT-VALIGN: right" <%}else{%> style="LEFT: 0px; WIDTH: <%=colwidth1%>%; word-wrap:break-word;word-break:break-all;TEXT-VALIGN: center"<%}%>>
                        <%    }        }
                                     if(defieldhtmltype.equals("1")){                          // �����ı���
                                        if(defieldtype.equals("1")){                          // �����ı����е��ı�
                                            if(isdeedit.equals("1") && colcount1!=0 && editdetailbodyflag){
                                                if(isdemand.equals("1")) {
                                          %>
                                          <input datatype="text" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle id="field<%=defieldid%>_<%=derecorderindex%>"  name="field<%=defieldid%>_<%=derecorderindex%>" size=15 value="<%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%>" onChange="checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));checkLength('field<%=defieldid%>_<%=derecorderindex%>','<%=fieldlen%>','<%=defieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>');<%=trrigerdetailStr%>">
                                          <span id="field<%=defieldid%>_<%=derecorderindex%>span"><% if(defieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                                          <%

                                                }else{%>
                                                <input datatype="text" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle  onchange="checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));checkLength('field<%=defieldid%>_<%=derecorderindex%>','<%=fieldlen%>','<%=defieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>');<%=trrigerdetailStr%>" id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%>" size=15>
                                                <span id="field<%=defieldid%>_<%=derecorderindex%>span"></span>
                                          <%            }
                                          if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                            }
                                            else {if(isdeview.equals("1") && colcount1!=0){
                                          %>
                                            <span id="field<%=defieldid%>_<%=derecorderindex%>span"><%=Util.toScreen(defieldvalue,user.getLanguage())%></span>
                                          <%
                                          }
                                          %>
                                            <input type=hidden class=Inputstyle id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%>">
                                          <%
                                            }
                                        }
                                        else if(defieldtype.equals("2")){                     // �����ı����е�����
                                            if(isdeedit.equals("1") && colcount1!=0 && editdetailbodyflag){
                                                if(isdemand.equals("1")) {
                                          %>
                                          <input datatype="int" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle id="field<%=defieldid%>_<%=derecorderindex%>"  name="field<%=defieldid%>_<%=derecorderindex%>" size=5 value="<%=defieldvalue%>"
                                          onKeyPress="ItemCount_KeyPress()" onChange="checkcount1(this);checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));calSum(<%=detailno%>);<%=trrigerdetailStr%>">
                                          <span id="field<%=defieldid%>_<%=derecorderindex%>span"><% if(defieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                                           <%

                                                }else{%>
                                                <input datatype="int" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle id="field<%=defieldid%>_<%=derecorderindex%>"  name="field<%=defieldid%>_<%=derecorderindex%>" size=5 value="<%=defieldvalue%>" onKeyPress="ItemCount_KeyPress()" onChange="checkcount1(this);checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));calSum(<%=detailno%>);<%=trrigerdetailStr%>">
                                                <span id="field<%=defieldid%>_<%=derecorderindex%>span"></span>
                                           <%           }
                                           if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                            }
                                            else {if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                            <span id="field<%=defieldid%>_<%=derecorderindex%>span"><%=defieldvalue%></span>
                                           <%
                                          }
                                          %>
                                            <input datatype="int" type=hidden class=Inputstyle id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>">
                                          <%
                                            }
                                        }
                                        else if(defieldtype.equals("3")||defieldtype.equals("5")){                     // �����ı����еĸ�����
                                        	int decimaldigits_t = 2;
                            		    	if(defieldtype.equals("3")){
                            		    		int digitsIndex = fielddbtype.indexOf(",");
                            		        	if(digitsIndex > -1){
                            		        		decimaldigits_t = Util.getIntValue(fielddbtype.substring(digitsIndex+1, fielddbtype.length()-1), 2);
                            		        	}else{
                            		        		decimaldigits_t = 2;
                            		        	}
                            		    	}
                                            if(isdeedit.equals("1") && colcount1!=0 && editdetailbodyflag){
                                                if(isdemand.equals("1")) {
                                          %>
                                          <input datatype="float" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle id="field<%=defieldid%>_<%=derecorderindex%>"  name="field<%=defieldid%>_<%=derecorderindex%>" size=10 value="<%=defieldvalue%>"
                                          onKeyPress="ItemDecimal_KeyPress(this.name,15,<%=decimaldigits_t%>)" <%if(defieldtype.equals("5")){%>onfocus="changeToNormalFormat(this.name)" onblur="changeToThousands(this.name)"<%}%> onChange="checknumber1(this);checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));calSum(<%=detailno%>);<%=trrigerdetailStr%>">
                                          <span id="field<%=defieldid%>_<%=derecorderindex%>span"><% if(defieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                                           <%
                                                }else{%>
                                                <input  datatype="float" viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' type=text class=inputstyle id="field<%=defieldid%>_<%=derecorderindex%>"  name="field<%=defieldid%>_<%=derecorderindex%>" size=10 value="<%=defieldvalue%>" onKeyPress="ItemDecimal_KeyPress(this.name,15,<%=decimaldigits_t%>)" <%if(defieldtype.equals("5")){%>onfocus="changeToNormalFormat(this.name)" onblur="changeToThousands(this.name)"<%}%> onChange="checknumber1(this);checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));calSum(<%=detailno%>);<%=trrigerdetailStr%>">
                                                <span id="field<%=defieldid%>_<%=derecorderindex%>span"></span>
                                           <%           }
                                           if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                            }
                                            else {if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                            <span id="field<%=defieldid%>_<%=derecorderindex%>span"><%=defieldvalue%></span>
                                           <%
                                          }
                                          %>
                                            <input datatype="float" type=hidden class=Inputstyle id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>">
                                          <%
                                            }
                                        }else if(defieldtype.equals("4")){                     //  �����ı����еĽ��ת��
                                            if(isdeedit.equals("1") &&  colcount1!=0 && editdetailbodyflag){
                                                if(isdemand.equals("1")) {
                                          %>
                                          
                                          <input class=inputstyle datatype="float" temptitle="<%=defieldlable%>" type=text id="field_lable<%=defieldid%>_<%=derecorderindex%>" name="field_lable<%=defieldid%>_<%=derecorderindex%>" size=30  onfocus="getNumber('<%=defieldid%>_<%=derecorderindex%>')"
                                          onKeyPress="ItemNum_KeyPress('field_lable<%=defieldid%>_<%=derecorderindex%>')" onBlur="numberToChinese('<%=defieldid%>_<%=derecorderindex%>');checkinput2('field_lable<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',field<%=defieldid%>_<%=derecorderindex%>.getAttribute('viewtype'));calSum('<%=detailno%>');<%=trrigerdetailStr%>">
                                           <%
                                                }else{%>
                                                <input class=inputstyle datatype="float" type=text id="field_lable<%=defieldid%>_<%=derecorderindex%>" name="field_lable<%=defieldid%>_<%=derecorderindex%>" size=30  onKeyPress="ItemNum_KeyPress('field_lable<%=defieldid%>_<%=derecorderindex%>')" onfocus="getNumber('<%=defieldid%>_<%=derecorderindex%>')" onBlur="numberToChinese('<%=defieldid%>_<%=derecorderindex%>');checkinput2('field_lable<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',field<%=defieldid%>_<%=derecorderindex%>.getAttribute('viewtype'));calSum('<%=detailno%>');<%=trrigerdetailStr%>" >
                                           <%           }
                                           
                                                %>
                                                  <span id="field<%=defieldid%>_<%=derecorderindex%>span">
                                                  <% if(isdemand.equals("1")&&defieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%>
                                                  </span>
                                                  <input datatype="float" viewtype='<%=isdemand%>' type=hidden class=Inputstyle temptitle="<%=defieldlable%>" id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>">
                                                <%
                                            if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                            %>
                                                <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                            <%
                                                }
                                            }
                                            else {if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                            <span id="field<%=defieldid%>_<%=derecorderindex%>span"></span>
                                             <input datatype="float" type=text class=Inputstyle id="field_lable<%=defieldid%>_<%=derecorderindex%>" name="field_lable<%=defieldid%>_<%=derecorderindex%>"  disabled="true" size=30>
                                           <%
                                          }
                                          %>
                                            <input datatype="float" type=hidden class=Inputstyle id="field<%=defieldid%>_<%=derecorderindex%>" name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>">
                                          <%
                                            }
                                            %>
                                              <script language="javascript">
                                              	try{
                                                    window.$GetEle("field_lable"+<%=defieldid%>+"_"+<%=derecorderindex%>).value  = numberChangeToChinese(<%=defieldvalue%>);
                                                  }catch(e){}
                                              </script>
                                              
                                              
                                              
                                            <%
                                        }
                                    }                                                       // �����ı�����������
                                    else if(defieldhtmltype.equals("2")){                     // �����ı���
                                    	if(isbill.equals("0")){
			                                rs_count.executeSql("select * from workflow_formdictdetail where id = " + defieldid);
			                                if(rs_count.next()){
			                                 textheight1 = rs_count.getString("textheight");//td3421 xwj 2005-12-31
			                                }
			                                }else{
			                                	rs_count.executeSql("select * from workflow_billfield where viewtype=1 and id = " + defieldid+" and billid="+formid);
			                        			if(rs_count.next()){
			                        				textheight1 = ""+Util.getIntValue(rs_count.getString("textheight"), 4);
			                        			}
			                        		}
                                        if(isdeedit.equals("1") && colcount1!=0 && editdetailbodyflag){
                                            if(isdemand.equals("1")) {
                                          %>
                                          <textarea class=inputstyle  viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' name="field<%=defieldid%>_<%=derecorderindex%>"  onChange="checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=defieldid%>_<%=derecorderindex%>','<%=fieldlen%>','<%=defieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')"
                                          rows="<%=textheight1%>" cols="40" style="width:80%" ><%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%></textarea>
                                          <span id="field<%=defieldid%>_<%=derecorderindex%>span"><% if(defieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
                                           <%
                                            }else{
                                           %>
                                           <textarea class=inputstyle viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' onchange="checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));checkLengthfortext('field<%=defieldid%>_<%=derecorderindex%>','<%=fieldlen%>','<%=defieldlable%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')" name="field<%=defieldid%>_<%=derecorderindex%>" rows="<%=textheight1%>" cols="40" style="width:80%"><%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%></textarea>
                                           <span id="field<%=defieldid%>_<%=derecorderindex%>span"></span>
                                           <%       }
                                           if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                        }
                                        else {if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                            <span id="field<%=defieldid%>_<%=derecorderindex%>span"><%=Util.toScreen(defieldvalue,user.getLanguage())%></span>
                                         <%
                                          }
                                          %>
                                            <input type=hidden class=Inputstyle name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.toScreenToEdit(defieldvalue,user.getLanguage())%>">
                                          <%
                                        }
                                    }                                                           // �����ı�����������
                                    else if(defieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                                        String url=BrowserComInfo2.getBrowserurl(defieldtype);     // �����ť����ҳ���url
                                        String linkurl =BrowserComInfo2.getLinkurl(defieldtype);   // ���ֵ�����ʱ�����ӵ�url
                                        String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
                                        String showid = "";                                     // �½�ʱ��Ĭ��ֵ
                                        String hiddenlinkvalue="";

                                        // ����Ƕ��ĵ�, ��Ҫ�ж��Ƿ����¼�����ĵ�,�����,��Ҫ����ԭ���ĺ���
                                        if( defieldtype.equals("37") && ((defieldid+"_"+derecorderindex).equals(docfileid)) && !newdocid.equals("")) {

                                            if( ! defieldvalue.equals("") ) defieldvalue += "," ;
                                            defieldvalue += newdocid ;

                                        }
                                        if(defieldtype.equals("161") || defieldtype.equals("162")){
											url+="?type="+fielddbtype;
                                        }

                                        if(defieldtype.equals("2") ||defieldtype.equals("19")  )	showname=defieldvalue; // ����ʱ��
                                        else if(!defieldvalue.equals("")) {
                                            ArrayList tempshowidlist=Util.TokenizerString(defieldvalue,",");
                                            if(defieldtype.equals("8") || defieldtype.equals("135")){
                                                //��Ŀ������Ŀ
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ProjectInfoComInfo2.getProjectInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=ProjectInfoComInfo2.getProjectInfoname((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("1") ||defieldtype.equals("17")||defieldtype.equals("165")||defieldtype.equals("166")){
                                                //��Ա������Ա
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                    	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                                      	{
                                                    		showname+="<a href='javaScript:openhrm("+tempshowidlist.get(k)+");' onclick='pointerXY(event);'>"+ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                      	}
                                                    	else
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("142")){
												//�շ��ĵ�λ
												for(int k=0;k<tempshowidlist.size();k++){
													if(!linkurl.equals("")){
														showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+docReceiveUnitComInfo_mdbb.getReceiveUnitName((String)tempshowidlist.get(k))+"</a>&nbsp";
													}else{
													showname+=docReceiveUnitComInfo_mdbb.getReceiveUnitName((String)tempshowidlist.get(k))+" ";
													}
												}
                                            }else if(defieldtype.equals("7") || defieldtype.equals("18")){
                                                //�ͻ�����ͻ�
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CustomerInfoComInfo2.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=CustomerInfoComInfo2.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("4") || defieldtype.equals("57")){
                                                //���ţ��ಿ��
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+DepartmentComInfo2.getDepartmentname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=DepartmentComInfo2.getDepartmentname((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("9") || defieldtype.equals("37")){
                                                //�ĵ������ĵ�
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_blank'>"+DocComInfo2.getDocname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=DocComInfo2.getDocname((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("23")){
                                                //�ʲ�
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"' target='_new'>"+CapitalComInfo2.getCapitalname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=CapitalComInfo2.getCapitalname((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("16") || defieldtype.equals("152") || defieldtype.equals("171")){
                                                //�������
                                                for(int k=0;k<tempshowidlist.size();k++){
                                                    if(!linkurl.equals("")){
                                                        int tempnum=Util.getIntValue(String.valueOf(session.getAttribute("slinkwfnum")));
                                                        tempnum++;
                                                        session.setAttribute("resrequestid"+tempnum,""+tempshowidlist.get(k));
                                                        session.setAttribute("slinkwfnum",""+tempnum);
                                                        session.setAttribute("haslinkworkflow","1");
                                                        hiddenlinkvalue+="<input type=hidden name='slink"+defieldid+"_"+derecorderindex+"_rq"+tempshowidlist.get(k)+"' value="+tempnum+">";
                                                        showname+="<a href='"+linkurl+tempshowidlist.get(k)+"&wflinkno="+tempnum+"' target='_new'>"+WorkflowRequestComInfo2.getRequestName((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                    }else{
                                                    showname+=WorkflowRequestComInfo2.getRequestName((String)tempshowidlist.get(k))+" ";
                                                    }
                                                }
                                            }else if(defieldtype.equals("161")){//�Զ��嵥ѡ
							                    showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
												try{
										            Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
										            BrowserBean bb=browser.searchById(defieldvalue);
													String desc=Util.null2String(bb.getDescription());
													String name=Util.null2String(bb.getName());
						                            String href=Util.null2String(bb.getHref());
						                            if(href.equals("")){
						                            	showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
						                            }else{
						                            	showname+="<a title='"+desc+"' href='"+href+"' target='_blank'>"+name+"</a>&nbsp";
						                            }
												}catch(Exception e){
												}
                                            }else if(defieldtype.equals("162")){//�Զ����ѡ
									            showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
												try{
										            Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
													List l=Util.TokenizerString(defieldvalue,",");
										            for(int j=0;j<l.size();j++){
													    String curid=(String)l.get(j);
											            BrowserBean bb=browser.searchById(curid);
														String name=Util.null2String(bb.getName());
														String desc=Util.null2String(bb.getDescription());
							                            String href=Util.null2String(bb.getHref());
							                            if(href.equals("")){
							                            	showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
							                            }else{
							                            	showname+="<a title='"+desc+"' href='"+href+"' target='_blank'>"+name+"</a>&nbsp";
							                            }
													}
												}catch(Exception e){
												}    
                                            }else if(defieldtype.equals("226") || defieldtype.equals("227")){
												//System.out.println("�������޸�ҳ�����ϸ");
												//���������ť
												//zzl,�±�����ͨģʽ�������ť������ButtonElement.java
												if("NULL".equals(defieldvalue)){
														defieldvalue="";
												}
												showname+="<a title='"+defieldvalue+"'>"+defieldvalue+"</a>&nbsp";
												url+="?type="+fielddbtype+"|"+defieldid;	
											}
											else{
                                                String tablename1=BrowserComInfo2.getBrowsertablename(defieldtype); //������Ӧ�ı�,����������Դ��
                                                String columname=BrowserComInfo2.getBrowsercolumname(defieldtype); //������Ӧ�ı������ֶ�
                                                String keycolumname=BrowserComInfo2.getBrowserkeycolumname(defieldtype);   //������Ӧ�ı�ֵ�ֶ�


                                                //add by wang jinyong
                                                HashMap temRes = new HashMap();

                                                if(defieldvalue.indexOf(",")!=-1){
                                                    sql= "select "+keycolumname+","+columname+" from "+tablename1+" where "+keycolumname+" in( "+defieldvalue+")";
                                                }
                                                else {
                                                    sql= "select "+keycolumname+","+columname+" from "+tablename1+" where "+keycolumname+"="+defieldvalue;
                                                }

                                                RecordSet.executeSql(sql);
                                                while(RecordSet.next()){
                                                    showid = Util.null2String(RecordSet.getString(1)) ;
                                                    String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                                                    if(!linkurl.equals("")){
                                                    	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                                      	{
                                                    		showname+="<a href='javaScript:openhrm("+showid+");' onclick='pointerXY(event);'>"+tempshowname+"</a>&nbsp";
                                                      	}
                                                    	else  
                                                             showname += "<a href='"+linkurl+showid+"' target='_new'>"+tempshowname+"</a>&nbsp";
                                                    }else{
                                                        showname +=tempshowname+" ";
                                                    }
                                                }
                                            }
                                        }else if(defieldvalue.equals("")){
                                        				 if(defieldtype.equals("226") || defieldtype.equals("227")){
															//System.out.println("�������޸�ҳ�����ϸ");
															//���������ť
															//zzl,�±�����ͨģʽ�������ť������ButtonElement.java
															if("NULL".equals(defieldvalue)){
																	defieldvalue="";
															}
															showname+="<a title='"+defieldvalue+"'>"+defieldvalue+"</a>&nbsp";
															url+="?type="+fielddbtype+"|"+defieldid;	

														}
                                        }
                                        //add by dongping
                                        //����Ҫ����������������������ӻ����ұ������ӣ���������´�����ʾ�����ұ���
                                        if (defieldtype.equals("118")) {
                                            showname ="<a href=/meeting/report/MeetingRoomPlan.jsp target=blank>�鿴������ʹ�����</a>" ;
                                            //showid = "<a href=/meeting/report/MeetingRoomPlan.jsp target=blank>�鿴������ʹ�����</a>";
                                         }
                                        if(isdeedit.equals("1") && colcount1!=0 && editdetailbodyflag){
                                            if( !defieldtype.equals("37") ) {    //  ���ĵ����⴦��
                                   %>
                                    <BUTTON type=button  class=Browser <%if (trrigerdetailfield.indexOf("field"+defieldid)>=0){%>onclick="onShowBrowser2('<%=defieldid%>_<%=derecorderindex%>','<%=url%>','<%=linkurl%>','<%=defieldtype%>',field<%=defieldid%>_<%=derecorderindex%>.getAttribute('viewtype'));datainputd('field<%=defieldid%>_<%=derecorderindex%>')" <%} else {%> onclick="onShowBrowser2('<%=defieldid%>_<%=derecorderindex%>','<%=url%>','<%=linkurl%>','<%=defieldtype%>',field<%=defieldid%>_<%=derecorderindex%>.getAttribute('viewtype'))" <%}%> title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
                                   <%       } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                                   %>
                                    <BUTTON type=button  class=AddDoc  onclick="onShowBrowser2('<%=defieldid%>_<%=derecorderindex%>','<%=url%>','<%=linkurl%>','<%=defieldtype%>',field<%=defieldid%>_<%=derecorderindex%>.getAttribute('viewtype'))" title="<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%>"> <%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>&nbsp;&nbsp;<BUTTON type=button  class=AddDocFlow onclick="onNewDoc('<%=defieldid%>_<%=derecorderindex%>')" title="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%>"><%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></button>
                                   <%       }
                                        }
                                       if(isdeview.equals("1") && colcount1!=0){
                                   %>
                                    <span id="field<%=defieldid%>_<%=derecorderindex%>span"><%=showname%>
                                   <%
                                        if( isdemand.equals("1") && defieldvalue.equals("") ){
                                   %>
                                    <img src="/images/BacoError.gif" align=absmiddle>
                                   <%
                                        }

                                   %>
                                    </span>
                                    <%if(defieldtype.equals("87")){%>
                                    <A href="/meeting/report/MeetingRoomPlan.jsp" target="blank"><%=SystemEnv.getHtmlLabelName(2193,user.getLanguage())%></A>
                                    <%}%>
                                    <%}%>
                                    <input type=hidden viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>" <%if(trrigerdetailfield.indexOf("field"+defieldid)>=0){%>onpropertychange="datainputd('field<%=defieldid%>_<%=derecorderindex%>');"<%}%>>
                                    <%=hiddenlinkvalue%>
                                   <%
                                        if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                    }                                                        // �����ť��������
                                    else if(defieldhtmltype.equals("4")) {                    // check��
                                        if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                           <input type=checkbox class=inputstyle viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' value=1 <%if(isdeedit.equals("0") || !editdetailbodyflag){%> DISABLED <%}else{%>  name="field<%=defieldid%>_<%=derecorderindex%>" <%}if(defieldvalue.equals("1")){%> checked <%}%> >
                                           <%
                                               if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }
                                               }
                                        if( isdeedit.equals("0") || !editdetailbodyflag || !isdeview.equals("1") || colcount1==0){
                                           %>
                                           <input type= hidden name="field<%=defieldid%>_<%=derecorderindex%>" value="<%=defieldvalue%>">
                                           <%
                                        }
                                    }                                                       // check����������
                                    else if(defieldhtmltype.equals("5")){                     // ѡ���   select
                                     	String onchangeAddStr = "";
                                    	int childfieldid_tmp = Util.getIntValue((String)childfieldids.get(i), 0);
                                    	if(childfieldid_tmp != 0){
                                    		onchangeAddStr = "changeChildFieldDetail(this,"+defieldid+","+childfieldid_tmp+","+derecorderindex+")";
                                    	}
                                    	boolean hasPfield = false;
                                    	int firstPfieldid_tmp = 0;
                                    	if(childfieldids.contains(defieldid)){
                                    		firstPfieldid_tmp = Util.getIntValue((String)defieldids.get(childfieldids.indexOf(defieldid)), 0);
                                    		hasPfield = true;
                                    	}
                                            if(isdeview.equals("1") && colcount1!=0){
                                           %>
                                           <script>
                                               function funcField<%=defieldid%>(){
                                                    changeshowattr('<%=defieldid%>_1',$G('field<%=defieldid%>_<%=derecorderindex%>').value,'<%=derecorderindex%>','<%=workflowid%>','<%=nodeid%>')
                                               }
                                               //window.attachEvent("onload", funcField<%=defieldid%>);
                                                if (window.addEventListener){
	                                           	    window.addEventListener("load", funcField<%=defieldid%>, false);
	                                           	}else if (window.attachEvent){
	                                           	    window.attachEvent("onload", funcField<%=defieldid%>);
	                                           	}else{
	                                           	    window.onload=funcField<%=defieldid%>;
	                                           	}	
                                           </script>
                                           <select class=inputstyle viewtype='<%=isdemand%>' temptitle='<%=defieldlable%>' onBlur="checkinput2('field<%=defieldid%>_<%=derecorderindex%>','field<%=defieldid%>_<%=derecorderindex%>span',this.getAttribute('viewtype'));" <%if(seldefieldsdemanage.indexOf(defieldid)>=0){%>onchange="changeshowattr('<%=defieldid%>_1',this.value,<%=derecorderindex%>,<%=workflowid%>,<%=nodeid%>);<%if (trrigerdetailStr.indexOf("field" + defieldid +"_"+derecorderindex) >= 0) {%>datainputd('field<%=defieldid%>_<%=derecorderindex%>');<%}%><%=onchangeAddStr%>"<%}else{%>onchange="<%if (trrigerdetailStr.indexOf("field" + defieldid +"_"+derecorderindex) >= 0) {%>datainputd('field<%=defieldid%>_<%=derecorderindex%>');<%}%><%=onchangeAddStr%>"<%}%> <%if(isdeedit.equals("0") || !editdetailbodyflag){%> name="disfield<%=defieldid%>_<%=derecorderindex%>" DISABLED <%}else{%> name="field<%=defieldid%>_<%=derecorderindex%>" <%}%>>
                                           <option value=""></option>
                                           <%
                                        // ��ѯѡ�������п���ѡ���ֵ
                                        RecordSet selrs=new RecordSet();
										selrs.executeProc("workflow_selectitembyid_new",""+defieldid+flag+isbill);
                                        if(hasPfield==false || isdeedit.equals("0") || (isaffirmance.equals("1") && !reEdit.equals("1")) || isremark!=0 || nodetype.equals("3")){
                                          while(selrs.next()){
                                            String tmpselectvalue = Util.null2String(selrs.getString("selectvalue"));
                                            String tmpselectname = Util.toScreen(selrs.getString("selectname"),user.getLanguage());
                                           %>
                                           <option value="<%=tmpselectvalue%>" <%if(defieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
                                           <%
                                          }
                                        }else{
											while(selrs.next()){
												String tmpselectvalue = Util.null2String(selrs.getString("selectvalue"));
												String tmpselectname = Util.toScreen(selrs.getString("selectname"),user.getLanguage());
                                           %>
                                           <option value="<%=tmpselectvalue%>" <%if(defieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
                                           <%
											}
			                	        	selectDetailInitJsStr += "doInitDetailchildSelect("+defieldid+","+firstPfieldid_tmp+","+derecorderindex+",\""+defieldvalue+"\");\n";
			                	        	initDetailIframeStr += "<iframe id=\"iframe_"+firstPfieldid_tmp+"_"+defieldid+"_"+derecorderindex+"\" frameborder=0 scrolling=no src=\"\"  style=\"display:none\"></iframe>";
                                        }
                                               if(seldefieldsdemanage.indexOf(defieldid)>=0) dlbodychangattrstr+="changeshowattr('"+defieldid+"_1','"+defieldvalue+"',"+derecorderindex+","+workflowid+","+nodeid+");";
                                           %>
                                           </select>
                                           <span id="field<%=defieldid%>_<%=derecorderindex%>span">
                                           <%
                                                if( isdemand.equals("1") && defieldvalue.equals("") ){
                                           %>
                                            <img src="/images/BacoError.gif" align=absmiddle>
                                           <%
                                                }

                                           %>
                                            </span>
                                           <%
                                           if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        %>
                                            <input type=hidden name="oldfieldview<%=defieldid%>_<%=derecorderindex%>" value="<%=Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0)%>" />
                                        <%
                                            }    
                                               }
                                        if( isdeedit.equals("0") || !isdeview.equals("1") || colcount1==0 || !editdetailbodyflag) {
                                           %>
                                           <input type= hidden name="field<%=defieldid%>_<%=derecorderindex%>" value=<%=defieldvalue%>>
                                           <%
                                        }
                                    }                                          // ѡ����������� ���������ж�����


                            if(colcount1!=0){
                        %>
                        <%if(  isdeview.equals("1") ) {%> </td>
                        <%}
                                }
                                }   // ��ϸ��¼ѭ������
                            if(colcount1!=0){
                        %>
                        </tr>
                        <%       if(submitdtlid.equals("")){
                                    submitdtlid=""+derecorderindex;
                                }else{
                                    submitdtlid+=","+derecorderindex;
                                }
                                    }
                                derecorderindex++;
                            }       //while��ϸ��¼����
                        }       //if����
                            if(colcount1!=0){
                        %>
                              </TBODY>
							  <%if(defshowsum){%>
                              <TFOOT>
                              <TR class=header>
                                <td></td>
								<TD ><%=SystemEnv.getHtmlLabelName(358,user.getLanguage())%></TD>
                <%
                    for (int i = 0; i < defieldids.size(); i++) {
                        if (!isdeviews.get(i).equals("1")) {
                %>
                                <td width="<%=colwidth1%>%" id="sum<%=defieldids.get(i)%>" style="display:none"></td>
                                <input type="hidden" name="sumvalue<%=defieldids.get(i)%>" >
                            <%
                        } else {
                            %>
                                <td align="right" width="<%=colwidth1%>%" id="sum<%=defieldids.get(i)%>"  style="color:red"></td>
                                <input type="hidden" name="sumvalue<%=defieldids.get(i)%>" >
                                    <%
                        }
                    }
                                    %>
                              </TR>
                              </TFOOT>
							  <%}%>
                            </table>
                            
</div>
                            </td>
                        </tr>

                </table>
            <%}%>
                <input type='hidden' id="nodesnum<%=detailno%>" name="nodesnum<%=detailno%>" value="<%=derecorderindex%>">
                <input type='hidden' id="indexnum<%=detailno%>" name="indexnum<%=detailno%>" value="<%=derecorderindex%>">
                <input type='hidden' id='rowneed<%=detailno%>' name='rowneed<%=detailno%>' value="<%=dtlneed %>">
                <input type=hidden name ="detailsum" value="<%=detailsum%>">
                <input type='hidden' id="deldtlid<%=detailno%>" name="deldtlid<%=detailno%>" value="">
                <input type='hidden' id="submitdtlid<%=detailno%>" name="submitdtlid<%=detailno%>" value="<%=submitdtlid%>">
                <input type='hidden' name=colcalnames value="<%=colCalItemStr1%>">
                <input type=hidden name ="detailsum" value="<%=detailsum%>">
                <script language=javascript>
                function addRow<%=detailno%>(obj)
                {
                        var oTable=$GetEle('oTable'+obj);
                        var initDetailfields="";
                        curindex=parseInt($GetEle('nodesnum'+obj).value);
                        rowindex=parseInt($GetEle('indexnum'+obj).value);
                        if($GetEle('submitdtlid'+obj).value==''){
                            $GetEle('submitdtlid'+obj).value=rowindex;
                        }else{
                            $GetEle('submitdtlid'+obj).value+=","+rowindex;
                        }
                        //alert(curindex+"|"+rowindex);
                        oRow = oTable.insertRow(curindex+1);
                        oCell = oRow.insertCell(-1);
                        oCell.style.height=24;
                        oCell.style.background= "#E7E7E7";
                        //oCell.style.word-wrap= "normal";
						oCell.style.wordWrap= "break-word";
						oCell.style.wordBreak= "break-all";

                        var oDiv = document.createElement("div");
                        var sHtml = "<input type='checkbox' name='check_node"+obj+"' value='"+rowindex+"'>";
                        sHtml += "<input type='hidden' name='dtl_id_"+obj+"' value=''>";
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);

						oCell = oRow.insertCell(-1);
						oCell.style.height=24;
						oCell.style.background= "#E7E7E7";
										//oCell.style.word-wrap= "normal";
						oCell.style.wordWrap= "break-word";
						oCell.style.wordBreak= "break-all";

						var oDivxh = document.createElement("div");
									 
										//var sHtmlxh = curindex+1;
									   

						oDivxh.innerHTML = curindex+1;
						oCell.appendChild(oDivxh);
                        

                <%
                    
                try{
                    for (int i = 0; i < defieldids.size(); i++) {         // ѭ����ʼ
                    		
								        String preAdditionalValue = "";
												boolean isSetFlag = false;

                        String fieldhtml = "";
                         defieldid = (String) defieldids.get(i);  //�ֶ�id
                         //System.out.println("fieldid:"+defieldid);

                         isfieldidindex = isdefieldids.indexOf(defieldid) ;
                         if( isfieldidindex != -1 ) {
                      	   isdeview=(String)isdeviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                      	   isdeedit=(String)isdeedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
                      	   isdemand=(String)isdemands.get(isfieldidindex);    //�ֶ��Ƿ��������
                         }

 						String trrigerdetailStr = "";
						if (trrigerdetailfield.indexOf("field"+defieldid)>=0){
							trrigerdetailStr = "datainputd(field" + defieldid + "_\"+rowindex+\")";
						}

                        if (!isdeview.equals("1")) continue;           //����ʾ��������һ��ѭ��
                        
								        //��ϸ�ֶ�����нڵ�ǰ���Ӳ�����ȡ��ʼֵ myq 2008.12.9 start
												int inoperateindex=inoperatefields.indexOf(defieldid);
												if(inoperateindex>-1){
													isSetFlag = true;
													preAdditionalValue = (String)inoperatevalues.get(inoperateindex);
												}
												//��ϸ�ֶ�����нڵ�ǰ���Ӳ�����ȡ��ʼֵ myq 2008.12.9 end

                         defieldname = "";                         //�ֶ����ݿ���е��ֶ���
                         defieldhtmltype = "";                     //�ֶε�ҳ������
                        defieldtype = "";                         //�ֶε�����
                         defieldlable = "";                        //�ֶ���ʾ��
                        delanguageid = user.getLanguage();
                        defieldname = (String) defieldnames.get(i);
                        defieldhtmltype = (String) defieldhtmltypes.get(i);
                        defieldtype = (String) defieldtypes.get(i);
						defieldlable =(String)defieldlabels.get(i);
						fielddbtype=(String)fieldrealtype.get(i);
						fieldlen=0;
						if ((fielddbtype.toLowerCase()).indexOf("varchar")>-1)
						{
						fieldlen=Util.getIntValue(fielddbtype.substring(fielddbtype.indexOf("(")+1,fielddbtype.length()-1));
									
						}
                        if (isdemand.equals("1"))
                          needcheck += ",field" + defieldid + "_\"+rowindex+\"";   //�����������,�����������ļ����
					
                        // ���濪ʼ������ʾ�ֶ�

                        if (defieldhtmltype.equals("1")) {                          // �����ı���
                            if (defieldtype.equals("1")) {                          // �����ı����е��ı�
                                if (isdeedit.equals("1")) {
                                    if (isdemand.equals("1")) {
                                        fieldhtml = "<input datatype='text' class=inputstyle value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' type=text name='field" + defieldid + "_\"+rowindex+\"' size=15 onChange=\\\"checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);checkLength('field" + defieldid + "_\"+rowindex+\"','"+fieldlen+"','"+defieldlable+"','"+SystemEnv.getHtmlLabelName(20246,user.getLanguage())+"','"+SystemEnv.getHtmlLabelName(20247,user.getLanguage())+"');"+trrigerdetailStr+"\\\"><span id='field" + defieldid + "_\"+rowindex+\"span'>";
                                        if("".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                        fieldhtml += "</span>";
                                    } else {
                                        fieldhtml = "<input datatype='text' class=inputstyle value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' onchange=\\\"checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);checkLength('field" + defieldid + "_\"+rowindex+\"','"+fieldlen+"','"+defieldlable+"','"+SystemEnv.getHtmlLabelName(20246,user.getLanguage())+"','"+SystemEnv.getHtmlLabelName(20247,user.getLanguage())+"');"+trrigerdetailStr+"\\\" type=text name='field" + defieldid + "_\"+rowindex+\"' value='' size=15><span id='field" + defieldid + "_\"+rowindex+\"span'></span>";
                                    }
                                    if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                                } else {
                                    fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'>"+preAdditionalValue+"</span><input class=inputstyle datatype='text' type=hidden value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                                }
                            } else if (defieldtype.equals("2")) {              // �����ı����е�����
                                if (isdeedit.equals("1")) {
                                    if (isdemand.equals("1")) {

                                        fieldhtml = "<input datatype='int' value='"+preAdditionalValue+"' class=inputstyle viewtype='"+isdemand+"' temptitle='"+defieldlable+"' type=text name='field" + defieldid + "_\"+rowindex+\"' size=5 onKeyPress='ItemCount_KeyPress()' onChange='checkcount1(this);checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);calSum("+detailno+");"+trrigerdetailStr+"'><span id='field" + defieldid + "_\"+rowindex+\"span'>";
                                        if("".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                        fieldhtml += "</span>";
                                    } else {

                                        fieldhtml = "<input datatype='int' class=inputstyle value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' type=text name='field" + defieldid + "_\"+rowindex+\"' size=5 onKeyPress='ItemCount_KeyPress()' onChange='checkcount1(this);checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);calSum("+detailno+");"+trrigerdetailStr+"'><span id='field" + defieldid + "_\"+rowindex+\"span'></span>";
                                    }
                                    if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                                } else {
                                    fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'>"+preAdditionalValue+"</span><input class=inputstyle datatype='int' type=hidden value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                                }
                            } else if (defieldtype.equals("3")||defieldtype.equals("5")) {                     // �����ı����еĸ�����
                            	int decimaldigits_t = 2;
                		    	if(defieldtype.equals("3")){
                		    		int digitsIndex = fielddbtype.indexOf(",");
                		        	if(digitsIndex > -1){
                		        		decimaldigits_t = Util.getIntValue(fielddbtype.substring(digitsIndex+1, fielddbtype.length()-1), 2);
                		        	}else{
                		        		decimaldigits_t = 2;
                		        	}
                		    	}
                                if (isdeedit.equals("1")) {
                                    if (isdemand.equals("1")) {
                                        fieldhtml = "<input class=inputstyle datetype='float' value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' type=text name='field" + defieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemDecimal_KeyPress(this.name,15,"+decimaldigits_t+")' ";
                                        if(defieldtype.equals("5")) fieldhtml += " onfocus='changeToNormalFormat(this.name)' onblur='changeToThousands(this.name)' ";
                                        fieldhtml += " onChange='checknumber1(this);checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);calSum("+detailno+");"+trrigerdetailStr+"'><span id='field" + defieldid + "_\"+rowindex+\"span'>";
                                        if("".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                        fieldhtml += "</span>";
                                    } else {
                                        fieldhtml = "<input class=inputstyle datetype='float' value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' type=text name='field" + defieldid + "_\"+rowindex+\"' size=10 onKeyPress='ItemDecimal_KeyPress(this.name,15,"+decimaldigits_t+")' ";
                                        if(defieldtype.equals("5")) fieldhtml += " onfocus='changeToNormalFormat(this.name)' onblur='changeToThousands(this.name)' ";
                                        fieldhtml += " onChange='checknumber1(this);checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);calSum("+detailno+");"+trrigerdetailStr+"'><span id='field" + defieldid + "_\"+rowindex+\"span'></span>";
                                    }
                                    if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                                } else {
                                    fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'>"+preAdditionalValue+"</span><input class=inputstyle datatype='float' type=hidden value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                                }
                            }else if (defieldtype.equals("4")) {                     // �����ı����еĽ��ת��
                                if (isdeedit.equals("1")) {
                                    
                                    if (isdemand.equals("1")) {//xwj for td3313 20051207 ��������ʱvalue�������ϸ�̾�ŵ���ʾ
                                        fieldhtml = "<input class=inputstyle temptitle='"+defieldlable+"' value='"+preAdditionalValue+"' datetype='float' type=text name='field_lable" + defieldid + "_\"+rowindex+\"' size=30 onKeyPress=\\\"ItemNum_KeyPress('field_lable" + defieldid + "_\"+rowindex+\"')\\\"  onfocus=\\\"getNumber('" + defieldid + "_\"+rowindex+\"')\\\" onBlur=\\\"numberToChinese('"+defieldid+"_\"+rowindex+\"');checkinput3(field_lable" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,field" + defieldid + "_\"+rowindex+\".getAttribute('viewtype'));calSum("+detailno+");"+trrigerdetailStr+"\\\">";
                                        //if("".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                        //fieldhtml += "</span>";
                                        
                                    } else {
                                        fieldhtml = "<input class=inputstyle value='"+preAdditionalValue+"' datetype='float' type=text name='field_lable" + defieldid + "_\"+rowindex+\"' size=30 onKeyPress=\\\"ItemNum_KeyPress('field_lable" + defieldid + "_\"+rowindex+\"')\\\"  onBlur=\\\"numberToChinese('"+defieldid+"_\"+rowindex+\"');checkinput3(field_lable" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,field" + defieldid + "_\"+rowindex+\".getAttribute('viewtype'));calSum("+detailno+");"+trrigerdetailStr+"\\\" onfocus=\\\"getNumber('" + defieldid + "_\"+rowindex+\"')\\\" onBlur=\\\"numberToChinese('" + defieldid + "_\"+rowindex+\"')\\\">";
                                    }
                                    fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'>";
                                    if(isdemand.equals("1")&&"".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                    fieldhtml += "</span><input class=inputstyle datetype='float' type=hidden viewtype='"+isdemand+"' temptitle='"+defieldlable+"' value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                                    if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                                } else {
                                    fieldhtml += "<input class=inputstyle size=30 value='"+preAdditionalValue+"' datetype='float' type=text  disabled='true' name='field_lable" + defieldid + "_\"+rowindex+\"'>";
                                    fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'></span><input class=inputstyle datetype='float' type=hidden value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                                }
                            }
                        }                                                       // �����ı�����������
                        else if (defieldhtmltype.equals("2")) {                     // �����ı���
                        	if(isbill.equals("0")){
                                rs_count.executeSql("select * from workflow_formdictdetail where id = " + defieldid);
                                if(rs_count.next()){
                                 textheight1 = rs_count.getString("textheight");//td3421 xwj 2005-12-31
                                }
                                }else{
                                	rs_count.executeSql("select * from workflow_billfield where viewtype=1 and id = " + defieldid+" and billid="+formid);
                        			if(rs_count.next()){
                        				textheight1 = ""+Util.getIntValue(rs_count.getString("textheight"), 4);
                        			}
                        		}
                            if (isdeedit.equals("1")) {
                                if (isdemand.equals("1")) {
                                    fieldhtml = "<textarea class=inputstyle value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' name='field" + defieldid + "_\"+rowindex+\"' onChange=\\\"checkinput3(field" +defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);checkLengthfortext('field" + defieldid + "_\"+rowindex+\"','"+fieldlen+"','"+defieldlable+"','"+SystemEnv.getHtmlLabelName(20246,user.getLanguage())+"','"+SystemEnv.getHtmlLabelName(20247,user.getLanguage())+"')\\\" rows='"+textheight1+"' cols='150' style='width:80%'></textarea><span id='field" + defieldid + "_\"+rowindex+\"span'>";
                                    if("".equals(preAdditionalValue)) fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                                    fieldhtml += "</span>";
                                } else {
                                    fieldhtml = "<textarea class=inputstyle value='"+preAdditionalValue+"' viewtype='"+isdemand+"' temptitle='"+defieldlable+"' onchange=\\\"checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);checkLengthfortext('field" + defieldid + "_\"+rowindex+\"','"+fieldlen+"','"+defieldlable+"','"+SystemEnv.getHtmlLabelName(20246,user.getLanguage())+"','"+SystemEnv.getHtmlLabelName(20247,user.getLanguage())+"')\\\" name='field" + defieldid + "_\"+rowindex+\"' rows='"+textheight1+"' cols='150' style='width:80%'></textarea><span id='field" + defieldid + "_\"+rowindex+\"span'></span>";
                                }
                                if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                            } else {
                                fieldhtml += "<span id='field" + defieldid + "_\"+rowindex+\"span'>"+preAdditionalValue+"</span><input class=inputstyle type=hidden value='"+preAdditionalValue+"' name='field" + defieldid + "_\"+rowindex+\"'>";
                            }
                        }                                                           // �����ı�����������
                        else if (defieldhtmltype.equals("3")) {                         // �����ť (�漰workflow_broswerurl��)
                            String url = BrowserComInfo2.getBrowserurl(defieldtype);     // �����ť����ҳ���url
                            String linkurl = BrowserComInfo2.getLinkurl(defieldtype);    //
                            String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
                            String showid = "";                                     // �½�ʱ��Ĭ��ֵ


									if ((defieldtype.equals("8") || defieldtype.equals("135")) && !prjid.equals("")) {       //�����ťΪ��Ŀ,��ǰ��Ĳ����л����ĿĬ��ֵ
													showid = "" + Util.getIntValue(prjid, 0);
												} else if ((defieldtype.equals("9") || defieldtype.equals("37")) && !docid.equals("")) { //�����ťΪ�ĵ�,��ǰ��Ĳ����л���ĵ�Ĭ��ֵ
													showid = "" + Util.getIntValue(docid, 0);
												} else if ((defieldtype.equals("1") || defieldtype.equals("17") || defieldtype.equals("165") || defieldtype.equals("166")) && !hrmid.equals("")) { //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
													showid = "" + Util.getIntValue(hrmid, 0);
												} else if ((defieldtype.equals("7") || defieldtype.equals("18")) && !crmid.equals("")) { //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
													showid = "" + Util.getIntValue(crmid, 0);
												} else if ((defieldtype.equals("4") || defieldtype.equals("57") || defieldtype.equals("167") || defieldtype.equals("168")) && !hrmid.equals("")) { //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)
													showid = "" + Util.getIntValue(ResourceComInfo2.getDepartmentID(hrmid), 0);
												} else if (defieldtype.equals("24") && !hrmid.equals("")) { //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
													showid = "" + Util.getIntValue(ResourceComInfo2.getJobTitle(hrmid), 0);
												} else if (defieldtype.equals("32") && !hrmid.equals("")) { //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
													showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"), 0);
												} else if((defieldtype.equals("164") || defieldtype.equals("169") || defieldtype.equals("170")) && !hrmid.equals("")){ //�����ťΪ�ֲ�,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�ķֲ��õ��ֲ�Ĭ��ֵ)
													showid = "" + Util.getIntValue(ResourceComInfo2.getSubCompanyID(hrmid),0);
												}

												if (showid.equals("0")) showid = "";
						            if(isSetFlag){
	                          showid = preAdditionalValue;
	                      }

												if (!showid.equals("")) {       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
												    ArrayList tempshowidlist=Util.TokenizerString(showid,",");
                                                    if(defieldtype.equals("1") ||defieldtype.equals("17")||defieldtype.equals("165")||defieldtype.equals("166")){
                                                        //��Ա������Ա
                                                        for(int k=0;k<tempshowidlist.size();k++){
                                                            if(!linkurl.equals("")){
                                                            	if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                                              	{
                                                            		showname+="<a href='javaScript:openhrm("+tempshowidlist.get(k)+");' onclick='pointerXY(event);'>"+ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                              	}
                                                            	else
                                                                showname+="<a href='"+linkurl+tempshowidlist.get(k)+"'>"+ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                            }else{
                                                            showname+=ResourceComInfo2.getResourcename((String)tempshowidlist.get(k))+" ";
                                                            }
                                                        }
                                                    }else if(defieldtype.equals("7") || defieldtype.equals("18")){
                                                        //�ͻ�����ͻ�
                                                        for(int k=0;k<tempshowidlist.size();k++){
                                                            if(!linkurl.equals("")){
                                                                showname+="<a href='"+linkurl+tempshowidlist.get(k)+"'>"+CustomerInfoComInfo2.getCustomerInfoname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                            }else{
                                                            showname+=CustomerInfoComInfo2.getCustomerInfoname((String)tempshowidlist.get(k))+" ";
                                                            }
                                                        }
                                                    }else if(defieldtype.equals("4") || defieldtype.equals("57")){
                                                        //���ţ��ಿ��
                                                        for(int k=0;k<tempshowidlist.size();k++){
                                                            if(!linkurl.equals("")){
                                                                showname+="<a href='"+linkurl+tempshowidlist.get(k)+"'>"+DepartmentComInfo2.getDepartmentname((String)tempshowidlist.get(k))+"</a>&nbsp";
                                                            }else{
                                                            showname+=DepartmentComInfo2.getDepartmentname((String)tempshowidlist.get(k))+" ";
                                                            }
                                                        }
                                                    }else if(defieldtype.equals("226") || defieldtype.equals("227")){
                                                       //zzl����Ĭ��ֵ
                                                      	showname=preAdditionalValue;
                                                    }
                                                    else{
                                                        String tablename2 =  Util.null2String(BrowserComInfo2.getBrowsertablename(defieldtype));
                                                        String columname =  Util.null2String(BrowserComInfo2.getBrowsercolumname(defieldtype));
                                                        String keycolumname =  Util.null2String(BrowserComInfo2.getBrowserkeycolumname(defieldtype));
                                                         //sql = "select " + columname + " from " + tablename2 + " where " + keycolumname + "=" + showid;
                                                        if(!tablename2.equals("")&&!columname.equals("")&&!keycolumname.equals("")){
                                                            sql = "select " + columname + " from " + tablename2 + " where " + keycolumname + "=" + showid;

                                                        RecordSet.executeSql(sql);
                                                        if (RecordSet.next()) {
                                                            if (!linkurl.equals(""))
                                                                showname = "<a href='" + linkurl + showid + "'>" + RecordSet.getString(1) + "</a>&nbsp";
                                                            else
                                                                showname = RecordSet.getString(1);
                                                        }
                                                        }
                                                     }
												}
											if (defieldtype.equals("2")) {                              // �����ťΪ����
													//showname = currentdate;
													//showid = currentdate;
					                if(!isSetFlag){
					                    showname = currentdate;
					                    showid = currentdate;
					                }else{
					                    showname=preAdditionalValue;
					                    showid=preAdditionalValue;
					                }
												}
											if (defieldtype.equals("19")) {                              // �����ťΪʱ��
												if(!isSetFlag){
													showname = currenttime.substring(0,5);
													showid = currenttime.substring(0,5);
												}else{
													showname=preAdditionalValue;
													showid=preAdditionalValue;
												}
												}
			            	if (defieldtype.equals("161")||defieldtype.equals("162")) {                              //�Զ��������
			                                url+="?type="+fielddbtype;
			                }
							
							if (defieldtype.equals("226")||defieldtype.equals("227")) {                            
									  //zzl
		                              url+="?type="+fielddbtype+"|"+defieldid;	
								
			                }
							
							
                            if (isdeedit.equals("1")) {
                                //System.out.println("url = " + url);
                                if (!defieldtype.equals("37")) {    //  ���ĵ����⴦��
                                     if (trrigerdetailfield.indexOf("field"+defieldid)>=0)
					                  {
                                    fieldhtml = "<BUTTON type=button  class=Browser onclick=\\\"onShowBrowser2('" + defieldid + "_\"+rowindex+\"','" + url + "','" + linkurl + "','" +defieldtype + "',field" + defieldid + "_\"+rowindex+\".getAttribute('viewtype'));datainputd('field" + defieldid + "_\"+rowindex+\"')\\\" title='" + SystemEnv.getHtmlLabelName(172, user.getLanguage()) + "'></button>";
									  }
									  else
									{
									  fieldhtml = "<BUTTON type=button  class=Browser onclick=\\\"onShowBrowser2('" + defieldid + "_\"+rowindex+\"','" + url + "','" + linkurl + "','" +defieldtype + "',field" + defieldid + "_\"+rowindex+\".getAttribute('viewtype'))\\\" title='" + SystemEnv.getHtmlLabelName(172, user.getLanguage()) + "'></button>";
									  }
                                } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                                    fieldhtml = "<BUTTON type=button  class=AddDocFlow onclick=\\\"onShowBrowser2('" + defieldid + "_\"+rowindex+\"','" + url + "','" + linkurl + "','" + defieldtype + "',field" + defieldid + "_\"+rowindex+\".getAttribute('viewtype'))\\\">" + SystemEnv.getHtmlLabelName(611, user.getLanguage()) + "</button>&nbsp;&nbsp<BUTTON type=button  class=AddDocFlow onclick=\\\"onNewDoc('" + defieldid + "_\"+rowindex+\"')\\\" title='" + SystemEnv.getHtmlLabelName(82, user.getLanguage()) + "'>" + SystemEnv.getHtmlLabelName(82, user.getLanguage()) + "</button>";
                                }
                            }
                            fieldhtml += "<input type=hidden viewtype='"+isdemand+"' temptitle='"+defieldlable+"' name='field" + defieldid + "_\"+rowindex+\"' value='" + showid + "'";
                            if(trrigerdetailfield.indexOf("field"+defieldid)>=0){
                            	fieldhtml += " onpropertychange=\\\"datainputd('field" + defieldid + "_\"+rowindex+\"');\\\" ";
                            }
                            fieldhtml += "><span id='field" + defieldid + "_\"+rowindex+\"span'>" + Util.toScreen(showname, user.getLanguage());

                            if (isdemand.equals("1") && showname.equals("")) {
                                fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>";
                            }
                            fieldhtml += "</span>";
                            if(defieldtype.equals("87")){
                                fieldhtml += "&nbsp;&nbsp;<A href='/meeting/report/MeetingRoomPlan.jsp' target='blank'>"+SystemEnv.getHtmlLabelName(2193,user.getLanguage())+"</A>";
                            }
                            if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                        }                                                       // �����ť��������
                        else if (defieldhtmltype.equals("4")) {                    // check��
                            fieldhtml += "<input class=inputstyle viewtype='"+isdemand+"' type=checkbox value=1 ";

								            if("1".equals(preAdditionalValue)) fieldhtml += " checked ";

                            if (isdeedit.equals("0")){
                                fieldhtml += " DISABLED ><input type=hidden name='field" + defieldid + "_\"+rowindex+\"'";
                                if("1".equals(preAdditionalValue)){
                                    fieldhtml +=" value=1>";
                                }else{
                                    fieldhtml +=" value=0>";
                                }
                            }else{
                                fieldhtml += " name='field" + defieldid + "_\"+rowindex+\"'>";
                            }
                            if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                        }                                                       // check����������
                        else if (defieldhtmltype.equals("5")) {                     // ѡ���   select
                        	//����select�ֶ�����
                         	String onchangeAddStr = "";
                        	int childfieldid_tmp = Util.getIntValue((String)childfieldids.get(i), 0);
                        	if(childfieldid_tmp != 0){
                        		onchangeAddStr = ";changeChildFieldDetail(this,"+defieldid+","+childfieldid_tmp+",\"+rowindex+\")";
                        	}
                        	boolean hasPfield = false;
                        	int firstPfieldid_tmp = 0;
                        	if(childfieldids.contains(defieldid)){
                        		firstPfieldid_tmp = Util.getIntValue((String)defieldids.get(childfieldids.indexOf(defieldid)), 0);
                        		hasPfield = true;
                        	}
                            fieldhtml = "<select class=inputstyle viewtype='"+isdemand+"' temptitle='"+defieldlable+"' ";
                            if(seldefieldsdemanage.indexOf(defieldid)>=0){
                             fieldhtml += " onChange=checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);changeshowattr('"+defieldid+"_1',this.value,\"+rowindex+\","+workflowid+","+nodeid+");" + trrigerdetailStr+onchangeAddStr+" ";
                            }else{
                            fieldhtml += " onChange=checkinput3(field" + defieldid + "_\"+rowindex+\",field" + defieldid + "_\"+rowindex+\"span,this.viewtype);" + trrigerdetailStr+onchangeAddStr+" ";
                            }
                            if (isdeedit.equals("0")){
                                fieldhtml += " name='field" + defieldid + "_\"+rowindex+\"' DISABLED " ;
                            }else{
                                fieldhtml += " name='field" + defieldid + "_\"+rowindex+\"'" ;
                            }
                            fieldhtml += ">";
                            fieldhtml += "<option value=''></option>";
                            // ��ѯѡ�������п���ѡ���ֵ
                            RecordSet selrs=new RecordSet();
                            boolean checkemptydetail1 = true;
                            if(hasPfield==false || isdeedit.equals("0")){
                            	selrs.executeProc("workflow_selectitembyid_new", "" + defieldid + flag + isbill);
                            	while (selrs.next()) {
								                String tmpselectvalue = Util.null2String(selrs.getString("selectvalue"));
								                String tmpselectname = Util.toScreen(selrs.getString("selectname"), user.getLanguage());
								                 /* -------- xwj for td2977 20051107 begin ----*/
								                String isdefault = Util.toScreen(selrs.getString("isdefault"),user.getLanguage());
								                if("".equals(preAdditionalValue)){
									                if("y".equals(isdefault)){
										                checkemptydetail1 = false;
										                fieldhtml += "<option value='" + tmpselectvalue + "' selected>" + tmpselectname + "</option>";
										              }else{
										              	 fieldhtml += "<option value='" + tmpselectvalue + "'>" + tmpselectname + "</option>";
										              }
								                }
								                else{
								                	checkemptydetail1 = false;
										              fieldhtml += "<option value='" + tmpselectvalue + "'";
								                	if(tmpselectvalue.equals(preAdditionalValue)) fieldhtml += "selected";
								                	fieldhtml += ">" + tmpselectname + "</option>";
								                }
								                /* -------- xwj for td2977 20051107 end ----*/
								            }
                            }else{
                            	selectDetailInitJsStrAdd += "doInitDetailchildSelectAdd("+defieldid+","+firstPfieldid_tmp+",rowindex,\"\");";
                            	initDetailIframeStrAdd += "<iframe id=\"iframe_"+firstPfieldid_tmp+"_"+defieldid+"\" frameborder=0 scrolling=no src=\"\"  style=\"display:none\"></iframe>";
                            }
                            fieldhtml += "</select><span id='field" + defieldid + "_\"+rowindex+\"span'>";
								            if("1".equals(isdemand) && checkemptydetail1){
								            fieldhtml +="<img src='/images/BacoError.gif' align=absmiddle>";
								            }
								            fieldhtml += "</span>";
								            if (isdeedit.equals("0")){
								            fieldhtml += "<input type=hidden name='field" + defieldid + "_\"+rowindex+\"' value='" + preAdditionalValue + "'>";
								            }
                            if(changedefieldsdemanage.indexOf(defieldid)>=0){
                                        fieldhtml += "<input type=hidden name=oldfieldview" + defieldid + "_\"+rowindex+\" value="+(Util.getIntValue(isdeview,0)+Util.getIntValue(isdeedit,0)+Util.getIntValue(isdemand,0))+" />";
                                    }
                        }                                          // ѡ����������� ���������ж�����
                %>


                        oCell = oRow.insertCell(-1);
                        oCell.style.height=24;
                        oCell.style.background= "#E7E7E7";
						oCell.style.wordWrap= "break-word";
						oCell.style.wordBreak= "break-all";

                        var oDiv = document.createElement("div");
                        var sHtml = "<%=fieldhtml%>" ;
                       
                        oDiv.innerHTML = sHtml;
                        oCell.appendChild(oDiv);
                        <%
                        if (trrigerdetailfield.indexOf("field"+defieldid)>=0){
                        %>
                        //datainputd("field<%=defieldid%>_"+rowindex);
                        initDetailfields += "field<%=defieldid%>_"+rowindex+",";
                        <%
                        }
                        if(seldefieldsdemanage.indexOf(defieldid)>=0){
                        %>
                        changeshowattr('<%=defieldid%>_1',$G('field<%=defieldid%>_'+rowindex).value,rowindex,'<%=workflowid%>','<%=nodeid%>');
                        <%
                        }
                			//System.out.println("field type:"+defieldtype);
                    }       // ѭ������
                    }catch(Exception e){
						}
                %>
                	try
                	{
	                    if ("<%=needcheck%>" != ""){
	                        $GetEle("needcheck").value += ",<%=needcheck%>";
	                    }
	                    datainputd(initDetailfields);
						<%=selectDetailInitJsStrAdd%>
					}
					catch(e)
					{
					}
                    rowindex = rowindex*1 +1;
                    curindex = curindex*1 +1;
                    $GetEle("nodesnum"+obj).value = curindex ;
                    $GetEle('indexnum'+obj).value = rowindex;
                    calSum(obj);
                }
                <%
				if(dtldefault.equals("1")&&derecorderindex<1)
				{
				%>
				jQuery(document).ready(function () {
					addRow<%=detailno%>(<%=detailno%>);
				});
				<%	
				}
				%>
              </script>
<%
                  detailno++;
                //}//if end
              }     //����ϸѭ������

 
%>
<script language=javascript>
function deleteRow1(obj)
{
    var flag = false;
	var ids = document.getElementsByName('check_node'+obj);
	for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
	}
    if(flag) {
		if(isdel()){
            var oTable=$G('oTable'+obj);
            curindex=parseInt($G("nodesnum"+obj).value);
            len = document.forms[0].elements.length;
            var i=0;
            var rowsum1 = 0;
            for(i=len-1; i >= 0;i--) {
                if (document.forms[0].elements[i].name=='check_node'+obj)
                    rowsum1 += 1;
            }
            for(i=len-1; i >= 0;i--) {
                if (document.forms[0].elements[i].name=='check_node'+obj){
                    if(document.forms[0].elements[i].checked==true) {
                         //��¼��ɾ���ľɼ�¼ id��
                        if(jQuery(oTable.rows[rowsum1].cells[0]).children().length > 1){
                            if($G("deldtlid"+obj).value!=''){
                                //����ϸ
                                $G("deldtlid"+obj).value+="," + jQuery(oTable.rows[rowsum1].cells[0]).children()[1].value;
                            }else{
                                //����ϸ
                                $G("deldtlid"+obj).value = jQuery(oTable.rows[rowsum1].cells[0]).children()[1].value;
                            }
                        }

                        //ɾ����
                        oTable.deleteRow(rowsum1);
                        curindex--;
                    }
                    rowsum1 -=1;

                }
            }
            
            var submitDtlIds = "";
            var chkObj = document.getElementsByName('check_node'+obj);
            for(var m = 0; m<chkObj.length; m++){
            	if(chkObj[m] != null && chkObj[m] != undefined){
            		submitDtlIds += "," + chkObj[m].value;
            	}
            }
            $GetEle("submitdtlid"+obj).value = submitDtlIds.substring(1);

            var rows = oTable.rows.length ;
            for(k=1; k < rows;k++){
                if(oTable.rows[k].cells[1].innerText!="<%=SystemEnv.getHtmlLabelName(358,user.getLanguage())%>"){
                    oTable.rows[k].cells[1].innerText=k;
                }
            }
            $GetEle("nodesnum"+obj).value=curindex;
            calSum(obj);
        }
    }else{
        alert('<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>');
		return;
    }
}

</script>

<%
    ArrayList rowCalAry = new ArrayList();
    ArrayList rowCalSignAry = new ArrayList();
	ArrayList mainCalAry = new ArrayList();
    ArrayList tmpAry = null;

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
<%=initDetailIframeStrAdd%>
<%=initDetailIframeStr%>
<script language="javascript">
rowindex = <%=derecorderindex%>;
curindex = <%=derecorderindex%> ;

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
        ArrayList calExpList=DynamicDataInput.FormatString(calExp);
        //System.out.println("calExp:"+calExp);
%>
    //for( i=0; i<rowindex; i++){
        try{
            var nowobj=(evt.srcElement ? evt.srcElement : evt.target).name.toString();
            var i;
            if(nowobj.indexOf('_')>-1){
                i=nowobj.substr(nowobj.indexOf('_')+1);
                if(i.indexOf('_')>-1)
                    i=i.substr(i.indexOf('_')+1);
            }
			//var i = window.event.srcElement.parentElement.parentElement.parentElement.rowIndex - 1;//ֻ���㵱ǰ�е�ֵ

        <%
            for(int j=0;j<calExpList.size();j++){
                calExp=(String)calExpList.get(j);
                String targetStr="";
                %>
                try {
                <%
                if(calExp.indexOf("innerHTML")>0){
                targetStr=calExp.substring(0,calExp.indexOf("innerHTML")-1);
                //System.out.println("targetStr:"+targetStr);
                //targetStr = targetStr.substring(0,targetStr.indexOf("_"));
                //out.println("var tempObjName = getObjectName("+targetStr+",\"_\")");
                out.println("if("+targetStr+"){");
                if (calExp.indexOf("=") != calExp.length()-1) {
            		out.println(calExp+"; ") ;
            	}
                out.println("if("+calExp.substring(0,calExp.indexOf("innerHTML")-9)+").datatype=='int') "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("innerHTML")-9)+").value,0);else "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("innerHTML")-9)+").value,2);}");
                }else{
                if(calExp.indexOf("value")>0){  
                targetStr =calExp.substring(0,calExp.indexOf("value")-1);
                //System.out.println("targetStr:"+targetStr);
                //targetStr = targetStr.substring(0,targetStr.indexOf("_"));
                //out.println("var tempObjName = getObjectName("+targetStr+",\"_\")");
                //out.println("if(window.event.srcElement.name.toString().indexOf(tempObjName)==-1){");
                out.println("if("+targetStr+"){");
                if (calExp.indexOf("=") != calExp.length()-1) {
            		out.println(calExp+"; ") ;
            	}
                out.println("if("+calExp.substring(0,calExp.indexOf("value")-1)+".datatype=='int') "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("="))+",0);else "+calExp.substring(0,calExp.indexOf("="))+"=toPrecision("+calExp.substring(0,calExp.indexOf("="))+",2);}");
                }
                }
                %>
	            }catch(e){}
	            <%
            }
	        %>

       }catch(e){}
   //}
<%
    }
%>
}
function calMainField(obj){
    var rows=0;
    <%for(int i=0;i<detailno;i++){%>
    var temprow=0;
    if($GetEle('indexnum<%=i%>')) temprow=parseInt($GetEle('indexnum<%=i%>').value);
    if(temprow>rows) rows=temprow;
    <%}%>
    if(rowindex<rows)
        rowindex=rows;
	<%
		for(int i=0;i<mainCalAry.size();i++){
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
                        temStr=$GetEle("field<%=str4%>_"+i).value;
                        temStr = temStr.replace(/,/g,"");
                        if(temStr+""!=""){
                            sum+=temStr*1;
                        }
                    }catch(e){;}
                }
                if($GetEle("field<%=str3%>")){
                  if($GetEle("field<%=str3%>").getAttribute("datatype")=="int")
                     $GetEle("field<%=str3%>").value=toPrecision(sum,0);
                  else
                     $GetEle("field<%=str3%>").value=toPrecision(sum,3);
                }
                if($GetEle("field<%=str3%>span")){
					if($GetEle("field<%=str3%>")&&$GetEle("field<%=str3%>").type=="text"){
						$GetEle("field<%=str3%>span").innerHTML="";
					}else{
						if($GetEle("field<%=str3%>")&&$GetEle("field<%=str3%>").type=="text"){
							$GetEle("field<%=str3%>span").innerHTML="";
						}else{
							if($GetEle("field<%=str3%>").getAttribute("datatype") == "int"){
								$GetEle("field<%=str3%>span").innerHTML=toPrecision(sum,0);
							}else if($GetEle("field<%=str3%>").getAttribute("datatype")=="float" && $GetEle("field<%=str3%>").getAttribute("datavaluetype")== "5"){
								$GetEle("field<%=str3%>span").innerHTML=changeToThousandsVal(toPrecision(sum,2));
							}else{
								$GetEle("field<%=str3%>span").innerHTML=toPrecision(sum,2);
							}
						}
					}
                }


	<%
	}
	%>

}
function calSum(obj, isload){
    calSumPrice();
    var rows=0;
    <%for(int i=0;i<detailno;i++){%>
    var temprow=0;
    if($GetEle('indexnum<%=i%>')) temprow=parseInt($GetEle('indexnum<%=i%>').value);
    if(temprow>rows) rows=temprow;
    <%}%>
    if(rowindex<rows)
        rowindex=rows;
    var sum=0;
    var temStr;
<%
    for(int i=0; i<colCalAry.size(); i++){
		String str = colCalAry.get(i).toString();
		str = str.substring(str.indexOf("_")+1);
%>
            sum=0;
            for(i=0; i<rowindex; i++){

                try{
                    temStr=$GetEle("field<%=str%>_"+i).value;
                    temStr = temStr.replace(/,/g,"");
                    if(temStr+""!=""){
                        sum+=temStr*1;
                    }
                }catch(e){;}
            }
            
        var decimalNumber = 3;
        try {
			var targetElement_dt = jQuery($G("field<%=str%>_" + obj)).attr("onkeypress");
			if (targetElement_dt) {
				targetElement_dt = targetElement_dt.toString();
				var decimalNumberstr = targetElement_dt.substring(targetElement_dt.indexOf("ItemDecimal_KeyPress(") + 21,targetElement_dt.length - 3);
				var decimalNumberstrary = decimalNumberstr.split(",");
				decimalNumber = parseInt(decimalNumberstrary[decimalNumberstrary.length - 1]);
			}
		} catch (e) {}
		if (isNaN(decimalNumber)) {
			decimalNumber = 3;
		}
            if($GetEle("sum<%=str%>")!=null)
            	$GetEle("sum<%=str%>").innerHTML=toPrecision(sum,decimalNumber)+"&nbsp;"
            if($GetEle("sumvalue<%=str%>")!=null)            
            	$GetEle("sumvalue<%=str%>").value=toPrecision(sum,decimalNumber)
<%
    }
%>
	if(!isload) calMainField(obj);
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
<%
for(int i=0;i<detailno;i++){
%>
jQuery(document).ready(function(){
	calSum(<%=i%>, true);
});
<%
}%>
if ("<%=needcheck%>" != ""){
   $GetEle("needcheck").value += "<%=needcheck%>";
}
<%
needcheck="";
%>
<%=dlbodychangattrstr%>
function datainputd(parfield){                <!--���ݵ���-->
	 
      //var xmlhttp=XmlHttp.create();
	  
      var tempParfieldArr;
	  var StrData;
	  try{
		  try{
			tempParfieldArr = parfield.split(",");
			StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=detailsum%>&trg="+parfield;
			}catch(e){
			tempParfieldArr = parfield.getAttribute("name").split(",")
			StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=detailsum%>&trg="+parfield.getAttribute("name");
		}
		}catch(e){	
		  tempParfieldArr = $(parfield).attr("id").toString().split(",");
		  StrData="id=<%=workflowid%>&formid=<%=formid%>&bill=<%=isbill%>&node=<%=nodeid%>&detailsum=<%=detailsum%>&trg="+$(parfield).attr("id");
		}
	  
      for(var i=0;i<tempParfieldArr.length;i++){
      	var tempParfield = tempParfieldArr[i];
      	var indexid=tempParfield.substr(tempParfield.indexOf("_")+1);
	  
      <%
      if(!trrigerdetailfield.trim().equals("")){
          ArrayList Linfieldname=ddidetail.GetInFieldName();
          ArrayList Lcondetionfieldname=ddidetail.GetConditionFieldName();
          for(int i=0;i<Linfieldname.size();i++){
              String temp=(String)Linfieldname.get(i);
			
      %>
          if($GetEle("<%=temp.substring(temp.indexOf("|")+1)%>_"+indexid)) StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>_"+indexid).value;
	      
      <%
          }
          for(int i=0;i<Lcondetionfieldname.size();i++){
              String temp=(String)Lcondetionfieldname.get(i);
      %>
          if($GetEle("<%=temp.substring(temp.indexOf("|")+1)%>_"+indexid)) StrData+="&<%=temp%>="+$GetEle("<%=temp.substring(temp.indexOf("|")+1)%>_"+indexid).value;
      <%
          }
          }
      %>
      }
    
      $GetEle("datainputformdetail").src="DataInputFromDetail.jsp?"+StrData;
      //xmlhttp.open("POST", "DataInputFrom.jsp", false); 
      //xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
      //xmlhttp.send(StrData);
  }
function changeChildFieldDetail(obj, fieldid, childfieldid, rownum){
    var paraStr = "fieldid="+fieldid+"&childfieldid="+childfieldid+"&isbill=<%=isbill%>&selectvalue="+obj.value+"&isdetail=1&&rowindex="+rownum;
    $GetEle("selectChangeDetail").src = "SelectChange.jsp?"+paraStr;
    //alert($GetEle("selectChange").src);
}
function doInitDetailchildSelect(fieldid,pFieldid,rownum,childvalue, cnt){
	try{
		var pField = $GetEle("field"+pFieldid+"_"+rownum);
		if(pField != null){
			var pFieldValue = pField.value;
			if(pFieldValue==null || pFieldValue==""){
				if (cnt == null || cnt == "") {
					cnt = 0;
				}
				var _callbackfc = function() {
			        doInitDetailchildSelect(fieldid,pFieldid,rownum,childvalue, cnt + 1);
			    };
			    if (cnt < 10) {
					window.setTimeout(_callbackfc , 500);
				}
				return;
			}
			if(pFieldValue!=null && pFieldValue!=""){
				var field = $GetEle("field"+fieldid+"_"+rownum);
			    var paraStr = "fieldid="+pFieldid+"&childfieldid="+fieldid+"&isbill=<%=isbill%>&selectvalue="+pFieldValue+"&isdetail=1&&rowindex="+rownum+"&childvalue="+childvalue;
				$GetEle("iframe_"+pFieldid+"_"+fieldid+"_"+rownum).src = "SelectChange.jsp?"+paraStr;
			}
		}
	}catch(e){}
}
<%=selectDetailInitJsStr%>
function doInitDetailchildSelectAdd(fieldid,pFieldid,rownum,childvalue){
	try{
		var pField = $GetEle("field"+pFieldid+"_"+rownum);
		if(pField != null){
			var pFieldValue = pField.value;
			if(pFieldValue==null || pFieldValue==""){
				return;
			}
			if(pFieldValue!=null && pFieldValue!=""){
				var field = $GetEle("field"+fieldid+"_"+rownum);
			    var paraStr = "fieldid="+pFieldid+"&childfieldid="+fieldid+"&isbill=<%=isbill%>&selectvalue="+pFieldValue+"&isdetail=1&&rowindex="+rownum+"&childvalue="+childvalue;
				$GetEle("iframe_"+pFieldid+"_"+fieldid).src = "SelectChange.jsp?"+paraStr;
			}
		}
	}catch(e){}
}
function getNumber(index){
  	$GetEle("field_lable"+index).value = $GetEle("field"+index).value;
  }
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>