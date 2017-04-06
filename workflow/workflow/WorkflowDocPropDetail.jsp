<%@ page language="java" contentType="text/html; charset=GBK" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="checkSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="SecCategoryDocPropertiesComInfo" class="weaver.docs.category.SecCategoryDocPropertiesComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />

<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>

<HTML>
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = SystemEnv.getHtmlLabelName(19332,user.getLanguage()) + "��" + SystemEnv.getHtmlLabelName(21569,user.getLanguage()) ;
    String needfav = "";
    String needhelp = "";
%>
    <HEAD>
        <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
        <SCRIPT language="javascript" src="/js/weaver.js"></script>
    </HEAD>
<BODY>

<%

    String ajax=Util.null2String(request.getParameter("ajax"));

        int objId=Util.getIntValue(request.getParameter("objId"),-1);
        String objType=Util.null2String(request.getParameter("objType"));
	    if(objType.equals("")){
		    objType="0";
	    }
%>

<%if(objId==-1){%>

<%@ include file="/systeminfo/TopTitle.jsp" %>

<%}%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:saveDocPropDetail(this),_self}";
    RCMenuHeight += RCMenuHeightStep;      
    
    RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:cancelDocPropDetail(this),_self}";
    RCMenuHeight += RCMenuHeightStep;  
%>

<%if(!ajax.equals("1")){%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%}else{%>
<%@ include file="/systeminfo/RightClickMenu1.jsp" %>
<%}%>

<%

    int detachable = Util.getIntValue(String.valueOf(session.getAttribute("detachable")), 0);
    int subCompanyID = -1;
    int operateLevel = 0;

    if(1 == detachable)
    {  
        if(null == request.getParameter("subCompanyID"))
        {
            subCompanyID=Util.getIntValue(String.valueOf(session.getAttribute("managefield_subCompanyId")), -1);
        }
        else
        {
            subCompanyID=Util.getIntValue(request.getParameter("subCompanyID"),-1);
        }
        if(-1 == subCompanyID)
        {
            subCompanyID = user.getUserSubCompany1();
        }
        
        session.setAttribute("managefield_subCompanyId", String.valueOf(subCompanyID));
        
        operateLevel= checkSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(), "WorkflowManage:All", subCompanyID);
    }
    else
    {
        if(HrmUserVarify.checkUserRight("WorkflowManage:All", user))
        {
            operateLevel=2;
        }
    }

    if(operateLevel > 0){
       
        int docPropId=Util.getIntValue(request.getParameter("docPropId"),-1);
        int workflowId=Util.getIntValue(request.getParameter("workflowId"),-1);
        int selectItemId=Util.getIntValue(request.getParameter("selectItemId"),-1);
        String pathCategory = Util.null2String(request.getParameter("pathCategory"));
        int secCategoryId=Util.getIntValue(request.getParameter("secCategoryId"),-1);

        String formID = request.getParameter("formID");
		if(formID==null||formID.trim().equals("")){
			formID=WorkflowComInfo.getFormId(""+workflowId);
		}

        String isbill = WorkflowComInfo.getIsBill(""+workflowId);
		if(formID==null||formID.trim().equals("")||isbill==null||isbill.trim().equals("")){
			RecordSet.executeSql("select formid,isbill from workflow_base where id="+workflowId);
			if(RecordSet.next()){
				formID = Util.null2String(RecordSet.getString("formid"));
				isbill = Util.null2String(RecordSet.getString("isbill"));
			}
		}

		if(!"1".equals(isbill)){
			isbill="0";
		}

		if(pathCategory.equals("")){
			String innerSecCategory = String.valueOf(secCategoryId);
			String innerSubCategory = SecCategoryComInfo.getSubCategoryid(innerSecCategory);
			String innerMainCategory = SubCategoryComInfo.getMainCategoryid(innerSubCategory);


		     pathCategory = "/" + MainCategoryComInfo.getMainCategoryname(innerMainCategory) + "/" + SubCategoryComInfo.getSubCategoryname(innerSubCategory) + "/" + SecCategoryComInfo.getSecCategoryname(innerSecCategory);     
		}

        if(docPropId<=0){
		    RecordSet.executeSql("select id from  Workflow_DocProp where workflowId="+workflowId+" and selectItemId="+selectItemId+" and secCategoryid="+secCategoryId+" and objId="+objId+" and objType="+objType);
		    if(RecordSet.next()){
			    docPropId=Util.getIntValue(RecordSet.getString("id"),0);
		    }
		}
        /*================ ��������Ϣ ================*/
        List formDictIDList = new ArrayList();
        List formDictLabelList = new ArrayList();
		String SQL = null;
		if("1".equals(isbill)){
			SQL = "select formField.id,fieldLable.labelName as fieldLable "
                    + "from HtmlLabelInfo  fieldLable ,workflow_billfield  formField "
                    + "where fieldLable.indexId=formField.fieldLabel "
                    + "  and formField.billId= " + formID
                    + "  and formField.viewType=0 "
                    + "  and fieldLable.languageid =" + user.getLanguage()
                    + "  order by formField.dspOrder  asc ";
		}else{			
			SQL = "select formDict.ID, fieldLable.fieldLable "
                    + "from workflow_fieldLable fieldLable, workflow_formField formField, workflow_formdict formDict "
                    + "where fieldLable.formid = formField.formid and fieldLable.fieldid = formField.fieldid and formField.fieldid = formDict.ID and (formField.isdetail<>'1' or formField.isdetail is null) "
                    + "and formField.formid = " + formID
                    + "and fieldLable.langurageid = " + user.getLanguage()
                    + " order by formField.fieldorder";
		}                      
        RecordSet.executeSql(SQL);
        
        while(RecordSet.next()){
            formDictIDList.add(RecordSet.getString("ID"));
            formDictLabelList.add(RecordSet.getString("fieldLable"));
        }        
%>

<FORM name="docPropDetailForm" method="post" action="WorkflowDocPropDetailOperation.jsp" >

    <TABLE width=100% height=100% border="0" cellspacing="0" cellpadding="0">
        <COLGROUP>
            <COL width="10">
            <COL width="">
            <COL width="10">
        <TR>
            <TD height="10" colspan="3"></TD>
        </TR>
        <TR>
            <TD ></TD>
            <TD valign="top">
                <TABLE class=Shadow>
                    <TR>
                        <TD valign="top">                            
                            
                            <!--================== �ĵ�����ҳ���� ==================-->
                            <TABLE class="viewform">                           
                                <TR class="Title">
                                    <TH><%=SystemEnv.getHtmlLabelName(21569,user.getLanguage())%></TH>
                                </TR>
                                <TR class="Spacing">
                                    <TD class="Line1" colspan="2"></TD>
                                </TR>
                                <TR >
                                    <TD><%=SystemEnv.getHtmlLabelName(19368,user.getLanguage())%></TD>
                                    <TD class=Field><%= pathCategory %></TD>
                                </TR>
                                <TR class="Spacing">
                                    <TD class="Line" colSpan=2></TD>
                                </TR>
                            </TABLE>
                            <TABLE class="liststyle">
                                <COLGROUP>
                                   <COL width="30%">
                                   <COL width="*">    
                                <TR class="header">
                                    <TD><%=SystemEnv.getHtmlLabelName(21570,user.getLanguage())%></TD>
                                    <TD><%=SystemEnv.getHtmlLabelName(19372,user.getLanguage())%></TD>
                                </TR>
                            <%
								List docPropertyTypeExceptList=new ArrayList();//ĳЩ�ĵ����Բ���ͨ���������Ի�á�
							    docPropertyTypeExceptList.add("6");  //6 ��Ŀ¼
							    docPropertyTypeExceptList.add("7");  //7 ��Ŀ¼
							    docPropertyTypeExceptList.add("8");  //8 ��Ŀ¼
							    docPropertyTypeExceptList.add("10"); //10 ģ��
							    docPropertyTypeExceptList.add("11"); //11 ����
							    docPropertyTypeExceptList.add("13"); //13 ����
							    docPropertyTypeExceptList.add("14"); //14 �޸�
							    docPropertyTypeExceptList.add("15"); //15 ��׼
							    docPropertyTypeExceptList.add("16"); //16 ʧЧ
							    docPropertyTypeExceptList.add("17"); //17 �鵵
							    docPropertyTypeExceptList.add("18"); //18 ����
							    docPropertyTypeExceptList.add("20"); //20 �������б�
							    docPropertyTypeExceptList.add("24"); //24 ����Ŀ¼

								int docPropDetailId=-1;
							    int docPropFieldId=-1;
								int workflowFieldId=-1;

								int labelId = 0;
								String customName = null;
								int isCustom = 0;
								String docPropertyType=null;
								String docPropFieldName = null;

                                SecCategoryDocPropertiesComInfo.addDefaultDocProperties(secCategoryId);
                                int i = 0;
								StringBuffer sb=new StringBuffer();
								sb.append(" select a.id as docPropFieldId,a.labelId,a.customName,a.isCustom,a.type as docPropertyType,b.id as docPropDetailId,b.workflowFieldId ")
								  .append("   from DocSecCategoryDocProperty a left join (select * from Workflow_DocPropDetail where docPropId=").append(docPropId).append(")b on a.id=b.docPropFieldId ")
								  .append("  where a.secCategoryId =").append(secCategoryId)
								  .append("  order by a.viewindex asc ")
								;
                                RecordSet.executeSql(sb.toString());

                                while(RecordSet.next()){
                                    docPropDetailId = Util.getIntValue(RecordSet.getString("docPropDetailId"),-1);
                                    docPropFieldId = Util.getIntValue(RecordSet.getString("docPropFieldId"),-1);
                                    workflowFieldId = Util.getIntValue(RecordSet.getString("workflowFieldId"),-1);

                                    labelId = RecordSet.getInt("labelid");
                                    customName = Util.null2String(RecordSet.getString("customname"));
                                    isCustom = RecordSet.getInt("isCustom");
                                    if(isCustom==1){
                                    	docPropFieldName = customName;
                                    }else{
                                    	if(customName!=null&&!"".equals(customName)){
                                    		docPropFieldName = customName;
                                    	}else{
                                    		docPropFieldName = SystemEnv.getHtmlLabelName(labelId, user.getLanguage());
										}
									}
                                    docPropertyType = Util.null2String(RecordSet.getString("docPropertyType"));
									if(docPropertyTypeExceptList.indexOf(docPropertyType)>=0){
										continue;
									}

                            %>
								    <INPUT TYPE="hidden" NAME="docPropDetailId_<%= i %>" VALUE="<%= docPropDetailId %>">
								    <INPUT TYPE="hidden" NAME="docPropFieldId_<%= i %>" VALUE="<%= docPropFieldId %>">
                                    <TR class=<% if(0 == i % 2) {%> DataDark <% } else { %> DataLight <% } %>>
                                        <TD><%=docPropFieldName%></TD>
                                        <TD>
                                            <SELECT class=inputstyle name="workflowFieldId_<%= i %>">
                                                <OPTION value=-1></OPTION>
											    <option value=-3  <%if ("-3".equals(""+workflowFieldId)) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1334,user.getLanguage())%></option>

                            <%
                                            for(int j = 0; j < formDictIDList.size(); j++){
                            %>                   
                                                <OPTION value=<%= (String)formDictIDList.get(j) %>  <% if(((String)formDictIDList.get(j)).equals(""+workflowFieldId)) { %> selected <% } %>   ><%= (String)formDictLabelList.get(j) %></OPTION>
                            <%
                                            }
                            %>                         
                                            </SELECT>
                                        </TD>
                                    </TR>
                            <%
                                    i++;
                                }
                            %>
                                <TR>
                                    <TD height="10" colspan="3"></TD>
                                </TR>
                            </TABLE>                                                            
                        </TD>
                        <TD></TD>
                    </TR>
                    <TR>
                        <TD height="10" colspan="3"></TD>
                    </TR>
                </TABLE>
            </TD>
        </TR>
    </TABLE>

    <INPUT TYPE="hidden" NAME="docPropId" VALUE="<%= docPropId %>">    
    <INPUT TYPE="hidden" NAME="workflowId" VALUE="<%= workflowId %>">
    <INPUT TYPE="hidden" NAME="selectItemId" VALUE="<%= selectItemId %>">
    <INPUT TYPE="hidden" NAME="secCategoryId" VALUE="<%= secCategoryId %>">

    <INPUT TYPE="hidden" NAME="objId" VALUE="<%= objId %>">
    <INPUT TYPE="hidden" NAME="objType" VALUE="<%= objType %>">

    <INPUT TYPE="hidden" NAME="ajax" VALUE="<%= ajax %>">

    <INPUT TYPE="hidden" NAME="rowNum" VALUE="<%= i %>">

            
</FORM>
<%
    }
    else
    {
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
%>
</BODY>
</HTML>

<%if(!ajax.equals("1")){%>

<script language=javascript>

function saveDocPropDetail(){
	
	document.docPropDetailForm.submit();
}

function cancelDocPropDetail(){
	
	window.close();
}

</script>
<%}%>