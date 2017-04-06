	<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.docs.docs.CustomFieldManager,
                 java.net.*" %>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="SecCategoryDocPropertiesComInfo" class="weaver.docs.category.SecCategoryDocPropertiesComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="DocUserSelfUtil" class="weaver.docs.docs.DocUserSelfUtil" scope="page"/>
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="rsDummyDoc" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mould.DocMouldComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DocTreeDocFieldComInfo" class="weaver.docs.category.DocTreeDocFieldComInfo" scope="page" />
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
	<script language="JavaScript">
		function insertToCustomer(id, value){
			var customerTD = document.getElementById("customerTD");
			customerTD.innerHTML += "<input type='hidden' name='customfield"+id+"' value='"+value+"' /> ";
		}
	</script>
	<%
	int languageId = Util.getIntValue(request.getParameter("languageId"));
	int userCategory = Util.getIntValue(request.getParameter("userCategory"));
	int docid = Util.getIntValue(request.getParameter("docid"));
	int wordmouldid = Util.getIntValue(request.getParameter("wordmouldid"));
	int selectMouldType = Util.getIntValue(request.getParameter("selectMouldType"));
	boolean isPersonalDoc = Util.null2String(request.getParameter("isPersonalDoc")).equals("true")?true:false;
	boolean canPublish = Util.null2String(request.getParameter("canPublish")).equals("true")?true:false;
	String publishable = Util.null2String(request.getParameter("publishable"));
	String tmppublishtype = "";
	
	String docstatusname = DocComInfo.getStatusView(docid,user);
	String filetype = Util.null2String(request.getParameter("filetype"));
	String fromFlowDoc = Util.null2String(request.getParameter("fromFlowDoc"));
	String dummyIds = Util.null2String(request.getParameter("dummyIds"));
	DocManager.resetParameter();
	DocManager.setId(docid);
	DocManager.getDocInfoById();
	//�ĵ���Ϣ
	int maincategory=DocManager.getMaincategory();
	int subcategory=DocManager.getSubcategory();
	int seccategory=DocManager.getSeccategory();
	int doclangurage=DocManager.getDoclangurage();
	String docapprovable=DocManager.getDocapprovable();
	String docreplyable=SecCategoryComInfo.getSecReplyAbles(""+seccategory);
	String isreply=DocManager.getIsreply();
	int replydocid=DocManager.getReplydocid();
	String docsubject=DocManager.getDocsubject();
	String doccontent=DocManager.getDoccontent();
	String docpublishtype=DocManager.getDocpublishtype();
	int itemid=DocManager.getItemid();
	int itemmaincategoryid=DocManager.getItemmaincategoryid();
	int hrmresid=DocManager.getHrmresid();
	int crmid=DocManager.getCrmid();
	int projectid=DocManager.getProjectid();
	int financeid=DocManager.getFinanceid();
	int doccreaterid=DocManager.getDoccreaterid();
	int docdepartmentid=DocManager.getDocdepartmentid();
	String doccreatedate=DocManager.getDoccreatedate();
	String doccreatetime=DocManager.getDoccreatetime();
	int doclastmoduserid=DocManager.getDoclastmoduserid();
	String doclastmoddate=DocManager.getDoclastmoddate();
	String doclastmodtime=DocManager.getDoclastmodtime();
	int docapproveuserid=DocManager.getDocapproveuserid();
	String docapprovedate=DocManager.getDocapprovedate();
	String docapprovetime=DocManager.getDocapprovetime();
	int docarchiveuserid=DocManager.getDocarchiveuserid();
	String docarchivedate=DocManager.getDocarchivedate();
	String docarchivetime=DocManager.getDocarchivetime();
	String docstatus=DocManager.getDocstatus();
	String parentids=DocManager.getParentids();
	int assetid=DocManager.getAssetid();
	int ownerid=DocManager.getOwnerid();
	String keyword=DocManager.getKeyword();
	int accessorycount=DocManager.getAccessorycount();
	int replaydoccount=DocManager.getReplaydoccount();
	String usertype=DocManager.getUsertype();
	String canCopy=DocManager.getCanCopy();
	String docno = DocManager.getDocno();
	int replyid = 0 ;

	int docvaliduserid = DocManager.getDocValidUserId();
	String docvaliddate = DocManager.getDocValidDate();
	String docvalidtime = DocManager.getDocValidTime();
	int docpubuserid = DocManager.getDocPubUserId();
	String docpubdate = DocManager.getDocPubDate();
	String docpubtime = DocManager.getDocPubTime();
	int docreopenuserid = DocManager.getDocReOpenUserId();
	String docreopendate = DocManager.getDocReOpenDate();
	String docreopentime = DocManager.getDocReOpenTime();
	int docinvaluserid = DocManager.getDocInvalUserId();
	String docinvaldate = DocManager.getDocInvalDate();
	String docinvaltime = DocManager.getDocInvalTime();
	int doccanceluserid = DocManager.getDocCancelUserId();
	String doccanceldate = DocManager.getDocCancelDate();
	String doccanceltime = DocManager.getDocCancelTime();

	String docCode = DocManager.getDocCode();
	int docedition = DocManager.getDocEdition();
	int doceditionid = DocManager.getDocEditionId();
	int ishistory = DocManager.getIsHistory();
	int selectedpubmouldid = DocManager.getSelectedPubMouldId();

	int maindoc = DocManager.getMainDoc();
	int docreadoptercanprint = DocManager.getReadOpterCanPrint();

	boolean isTemporaryDoc = false;
	String invalidationdate = DocManager.getInvalidationDate();
	if(invalidationdate!=null&&!"".equals(invalidationdate))
		isTemporaryDoc = true;

	//�Ƿ�ظ�����
	String canRemind=DocManager.getCanRemind();

	String checkOutStatus=DocManager.getCheckOutStatus();
	int checkOutUserId=DocManager.getCheckOutUserId();
	String checkOutUserType=DocManager.getCheckOutUserType();

	String docCreaterType = DocManager.getDocCreaterType();//�ĵ����������ͣ�1:�ڲ��û�  2���ⲿ�û���
	String docLastModUserType = DocManager.getDocLastModUserType();//�ĵ�����޸������ͣ�1:�ڲ��û�  2���ⲿ�û���
	String docApproveUserType = DocManager.getDocApproveUserType();//�ĵ����������ͣ�1:�ڲ��û�  2���ⲿ�û���
	String docInvalUserType = DocManager.getDocInvalUserType();//ʧЧ���������ͣ�1:�ڲ��û�  2���ⲿ�û���
	String docArchiveUserType = DocManager.getDocArchiveUserType();//�ĵ��鵵�����ͣ�1:�ڲ��û�  2���ⲿ�û���
	String docCancelUserType = DocManager.getDocCancelUserType();//���ϲ��������ͣ�1:�ڲ��û�  2���ⲿ�û���
	String ownerType = DocManager.getOwnerType();//�ĵ�ӵ�������ͣ�1:�ڲ��û�  2���ⲿ�û���

if(docpublishtype.equals("2")) tmppublishtype=SystemEnv.getHtmlLabelName(227,user.getLanguage());
		else if(docpublishtype.equals("3")) tmppublishtype=SystemEnv.getHtmlLabelName(229,user.getLanguage());
		else tmppublishtype=SystemEnv.getHtmlLabelName(58,user.getLanguage());
	String hasUsedTemplet=DocManager.getHasUsedTemplet();//�Ƿ��Ѿ��׺�
	int canPrintedNum=DocManager.getCanPrintedNum();//�ɴ�ӡ����

	List selectMouldList = new ArrayList();
if(SecCategoryDocPropertiesComInfo.getDocProperties(""+seccategory,"10")&&SecCategoryDocPropertiesComInfo.getVisible().equals("1")&&(!"1".equals(hasUsedTemplet))&&(!fromFlowDoc.equals("1"))){
	
	if(filetype.equals(".doc")){
		RecordSet.executeSql("select * from DocSecCategoryMould where secCategoryId = "+seccategory+" and mouldType=3 order by id ");
		while(RecordSet.next()){
			String moduleid=RecordSet.getString("mouldId");
			String mType = DocMouldComInfo.getDocMouldType(moduleid);
			String modulebind = RecordSet.getString("mouldBind");
			int isDefault = Util.getIntValue(RecordSet.getString("isDefault"),0);

			if(isTemporaryDoc){
				if(Util.getIntValue(modulebind,1)==3){
				    selectMouldList.add(moduleid);
			    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
					selectMouldList.add(moduleid);
			    } else {
			        if(Util.getIntValue(modulebind,1)!=2)
						selectMouldList.add(moduleid);
			    }
			} else {
				if(Util.getIntValue(modulebind,1)==2){
				    selectMouldList.add(moduleid);
			    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
					selectMouldList.add(moduleid);
			    } else {
			        if(Util.getIntValue(modulebind,1)!=3)
						selectMouldList.add(moduleid);
			    }
			}
		}

	}
}


	int j = 1;
	SecCategoryDocPropertiesComInfo.addDefaultDocProperties(seccategory);
	SecCategoryDocPropertiesComInfo.setTofirstRow();
	while(SecCategoryDocPropertiesComInfo.next()){
		int docPropId = Util.getIntValue(SecCategoryDocPropertiesComInfo.getId());
		int docPropSecCategoryId = Util.getIntValue(SecCategoryDocPropertiesComInfo.getSecCategoryId());
		int docPropViewindex = Util.getIntValue(SecCategoryDocPropertiesComInfo.getViewindex());
		int docPropType = Util.getIntValue(SecCategoryDocPropertiesComInfo.getType());
		int docPropLabelid = Util.getIntValue(SecCategoryDocPropertiesComInfo.getLabelId());
		int docPropVisible = Util.getIntValue(SecCategoryDocPropertiesComInfo.getVisible());
		String docPropCustomName = SecCategoryDocPropertiesComInfo.getCustomName();
		int docPropColumnWidth = Util.getIntValue(SecCategoryDocPropertiesComInfo.getColumnWidth());
		int docPropMustInput = Util.getIntValue(SecCategoryDocPropertiesComInfo.getMustInput());
		int docPropIsCustom = Util.getIntValue(SecCategoryDocPropertiesComInfo.getIsCustom());
		String docPropScope = SecCategoryDocPropertiesComInfo.getScope();
		int docPropScopeId = Util.getIntValue(SecCategoryDocPropertiesComInfo.getScopeId());
		int docPropFieldid = Util.getIntValue(SecCategoryDocPropertiesComInfo.getFieldId());

		if(docPropSecCategoryId!=seccategory) continue;

		String tagName = "";
		String tagValue = "";

		String label = "";
		if(!docPropCustomName.equals("")) {
			label = docPropCustomName;
		} else if(docPropIsCustom!=1) {
			label = SystemEnv.getHtmlLabelName(docPropLabelid,languageId);
		}

		if(docPropVisible==0) continue;

		if(docPropType==1)
			continue;

		if(docPropColumnWidth>1){
			if(j==2){
	%>
			</TR>
			<TR>
				<TD class=Line colSpan=4></TD>
			</TR>
	<%
			}
			j=3;
		}
	%>
			<% if(j==1||j==3){ %>
			<TR height="18">
			<% } %>

			<td><%=label%></td>
			<td class=field <%if(j==3){%>colspan="3"<%}%>>
			<%
				switch(docPropType){
					case 1:{//1 �ĵ�����
			%>
						<%=docsubject%>
			<%		
						break;
					}
					case 2:{//2 �ĵ����
			%>
						<%=docCode%>
			<%
						break;
					}
					case 3:{//3 ����
						if(!publishable.trim().equals("")){
			%>
							<%=tmppublishtype%>
						<%}%>
			<%		
						break;
					}
					case 4:{//4 �ĵ��汾
			%>
						<%=DocComInfo.getEditionView(docid)%>
			<%
						break;
					}
					case 5:{//5 �ĵ�״̬
			%>
						<%=docstatusname%>
			<%
						break;
					}
					case 6:{//6 ��Ŀ¼
			%>
						  <%if (isPersonalDoc){
						      String catalogIds=DocUserSelfUtil.getParentids(""+userCategory);
						      String catalogNames=DocUserSelfUtil.getCatalogNames(catalogIds) ;
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,languageId)+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
						   } else {
						  %>
						      <%=MainCategoryComInfo.getMainCategoryname(""+maincategory)%>
						  <%}%>
			<%
						break;
					}
					case 7:{//7 ��Ŀ¼
			%>
						  <%if (isPersonalDoc){
						      String catalogIds=DocUserSelfUtil.getParentids(""+userCategory);
						      String catalogNames=DocUserSelfUtil.getCatalogNames(catalogIds) ;
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,languageId)+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
						   } else {
						  %>
						      <%=SubCategoryComInfo.getSubCategoryname(""+subcategory)%>
						  <%}%>
			<%
						break;
					}
					case 8:{//8 ��Ŀ¼
			%>
						  <%if (isPersonalDoc){
						      String catalogIds=DocUserSelfUtil.getParentids(""+userCategory);
						      String catalogNames=DocUserSelfUtil.getCatalogNames(catalogIds) ;
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,languageId)+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
						   } else {
						  %>
						      <%--<BUTTON class=Browser onClick="onSelectCategory()" name=selectCategory></BUTTON>--%>
						      <span id=path name=path><%=SecCategoryComInfo.getSecCategoryname(""+seccategory).equals("")?"<IMG src='/images/BacoError.gif' align=absMiddle>":SecCategoryComInfo.getSecCategoryname(""+seccategory)%></span>
						  <%}%>
			<%
						break;
					}
					case 9:{//9 ����
			%>
						<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=docdepartmentid%>" target="_blank"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(""+docdepartmentid),languageId)%></a>
			<%
						break;
					}
					case 10:{//10 ģ��
					%>
						<%
						if(canPublish && docstatus.equals("6")){
						%>
							<select class=InputStyle name=selectedpubmould <%if(selectMouldType==2||(isTemporaryDoc&&selectMouldType==3)){%>disabled<%}%> style="width:200" onchange="onChangeDocModule(this.value)">
								<%if(selectMouldType<2){%>
								<option value="-1"></option>
								<%}%>
								<%
								int tmpcount = 0;
								int tmpMouldId = 0;
								
								for(int i=0;i<selectMouldList.size();i++){
								  	String moduleid = (String) selectMouldList.get(i);
									String modulename = DocMouldComInfo.getDocMouldname(moduleid);
								    String mType = DocMouldComInfo.getDocMouldType(moduleid);
								    String mouldTypeName = "";
								    if(mType.equals("")||mType.equals("0")||mType.equals("1")){
								        mouldTypeName="HTML";
								        continue;
								    }else if(mType.equals("2")){
								        mouldTypeName="WORD";
								        tmpMouldId = Util.getIntValue(moduleid);
								    }else if(mType.equals("3")){
								        mouldTypeName="EXCEL";
								        continue;
								    }
									String isselect ="" ;
									if(wordmouldid==Util.getIntValue(moduleid)) isselect = " selected";
									%>
									<option value="<%=moduleid%>" <%=isselect%> ><%=modulename%>(<%=mouldTypeName%>)</option>
									<%
									tmpcount++;
								}
								%>
							</select>
							<script language=javascript>
							function onChangeDocModule(thisvalue1){
							    window.onbeforeunload=null;
								location='DocDspExt.jsp?id=<%=docid%>&selectedpubmould='+thisvalue1;
							}
							</script>
						<% } else { %>
							<a href="/docs/mould/DocMouldDsp.jsp?id=<%=wordmouldid%>">
							<%=DocMouldComInfo.getDocMouldname(wordmouldid+"")%>
							</a>
						<% } %>
			<%
						break;
					}
					case 11:{//11 ����
			%>
						<%=LanguageComInfo.getLanguagename(""+doclangurage)%>
			<%
						break;
					}
					case 12:{//12 �ؼ���
			%>
						<a href="/docs/search/DocSearchTemp.jsp?keyword=<%=keyword%>"><%=keyword%><a>
			<%
						break;
					}
					case 13:{//13 ����
						    if("2".equals(docCreaterType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=doccreaterid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=doccreaterid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=doccreatedate%>&nbsp;<%=doccreatetime%>
						<%
						break;
					}
					case 14:{//14 �޸�
						    if("2".equals(docLastModUserType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=doclastmoduserid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doclastmoduserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doclastmoduserid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=doclastmoduserid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=doclastmoddate%>&nbsp;<%=doclastmodtime%>
						<%
						break;
					}
					case 15:{//15 ��׼
						if(docapproveuserid!=0){
						    if("2".equals(docApproveUserType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=docapproveuserid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docapproveuserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docapproveuserid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=docapproveuserid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+docapproveuserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+docapproveuserid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=docapprovedate%>&nbsp;<%=docapprovetime%>
						<%
						}
						break;
					}
					case 16:{//16 ʧЧ
						if(docinvaluserid!=0){
						    if("2".equals(docInvalUserType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=docinvaluserid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docinvaluserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docinvaluserid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=docinvaluserid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+docinvaluserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+docinvaluserid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=docinvaldate%>&nbsp;<%=docinvaltime%>
						<%
						}
						break;
					}
					case 17:{//17 �鵵
						if(docarchiveuserid!=0){
						    if("2".equals(docArchiveUserType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=docarchiveuserid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docarchiveuserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+docarchiveuserid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=docarchiveuserid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+docarchiveuserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+docarchiveuserid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=docarchivedate%>&nbsp;<%=docarchivetime%>
						<%
						}
						break;
					}
					case 18:{//18 ����
						if(doccanceluserid!=0){
							
						    if("2".equals(docCancelUserType)){
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=doccanceluserid%>"  target='_new'>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccanceluserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccanceluserid),user.getLanguage())%>
						<% 
							    }
						    } else { 
							    if("1".equals(user.getLogintype())){
						%>
							    <a href="javaScript:openhrm(<%=doccanceluserid%>);" onclick='pointerXY(event);'  >
								    <%=Util.toScreen(ResourceComInfo.getResourcename(""+doccanceluserid),user.getLanguage())%>
							    </a>
						<%
							    }else{
						%>
							        <%=Util.toScreen(ResourceComInfo.getResourcename(""+doccanceluserid),user.getLanguage())%>
						<% 
							    }
						    }
						%>
							&nbsp;<%=doccanceldate%>&nbsp;<%=doccanceltime%>
						<%
						}
						break;
					}
					case 19:{//19 ���ĵ�
			%>
						<% if(maindoc==docid){ %>
						<%=SystemEnv.getHtmlLabelName(524,languageId)%><%=SystemEnv.getHtmlLabelName(58,languageId)%>
						<% } else { %>
						<a href="/docs/docs/DocDsp.jsp?id=<%=maindoc%>"><%=DocComInfo.getDocname(maindoc+"")%></a>
						<% } %>
			<%
						break;
					}
					case 20:{//20 �������б�
			%>
						<%
						int newDocId = -1;
						String docSubject = "";
						if(doceditionid>-1){
							RecordSet.executeSql(" select id,docSubject from DocDetail where doceditionid = " + doceditionid + " and doceditionid > 0 and (isHistory<>'1' or isHistory is null or isHistory='') order by docedition desc ");
				            RecordSet.next();
				            newDocId = Util.getIntValue(RecordSet.getString("id"));
				            docSubject = Util.null2String(RecordSet.getString("docSubject"));
						} else {
							newDocId = docid;
							docSubject = docsubject;
						}
			            if(newDocId>0){
						%>
							<img src="/images/replyDoc/openfld.gif"/> <a href="/docs/docs/DocDsp.jsp?id=<%=newDocId%>"  target="_blank"><%=docSubject%></a>&nbsp;
							<%
					        int childDocId=-1;
							String childDocSubject = "";
							RecordSet.executeSql(" select id,docSubject from DocDetail where id <> " + newDocId + " and mainDoc = " + newDocId + " and (isHistory<>'1' or isHistory is null or isHistory='') order by id asc ");
							while(RecordSet.next()){
								childDocId = Util.getIntValue(RecordSet.getString("id"));;
								childDocSubject = Util.null2String(RecordSet.getString("docSubject"));
								if(childDocId>0){
				    			%>
					    		<img src="/images/replyDoc/news_general.gif"> <a href="/docs/docs/DocDsp.jsp?id=<%=childDocId%>"  target="_blank"><%=childDocSubject%></a>&nbsp;
					    		<% } %>
					    	<% } %>
					    <% } %>
			<%
						break;
					}
					case 21:{//21 �ĵ�������
						if("2".equals(ownerType)){
							if("1".equals(user.getLogintype())){
						%>
							<a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=ownerid%>"  target='_new'>
							    <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+ownerid),user.getLanguage())%>
							</a>
						<%
							}else{
						%>
							    <%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+ownerid),user.getLanguage())%>
						<% 
							}
						} else { 
							if("1".equals(user.getLogintype())){
						%>
							<a href="javaScript:openhrm(<%=ownerid%>);" onclick='pointerXY(event);'  >
								<%=Util.toScreen(ResourceComInfo.getResourcename(""+ownerid),user.getLanguage())%>
							</a>
						<%
							}else{
						%>
							    <%=Util.toScreen(ResourceComInfo.getResourcename(""+ownerid),user.getLanguage())%>
						<% 
							}
						}
						break;
					}
					case 22:{//22 ʧЧʱ��
						%>
						<%if(!"".equals(invalidationdate)){%>
						<%=invalidationdate%>
						<%}%>
						<%
						break;
					}
					case 24:{//24 ����Ŀ¼
						if(!"".equals(dummyIds)) {
							dummyIds=dummyIds.substring(0,dummyIds.length()-1);
							out.println(DocTreeDocFieldComInfo.getMultiTreeDocFieldNameOther(dummyIds));
						}
						break;
					}
					case 25:{//�ɴ�ӡ����
						%>
						<%=canPrintedNum%>
						<%
						break;
					}
					case 0:{//0 �Զ����ֶ�
			%>
						<%
						CustomFieldManager cfm = new CustomFieldManager("DocCustomFieldBySecCategory",seccategory);
					    cfm.getCustomFields(docPropFieldid);
						cfm.getCustomData(docid);
					    if(cfm.next()){
					        String fieldvalue = cfm.getData("field"+cfm.getId());
					        if(fieldvalue.startsWith(",")){
					        	fieldvalue = fieldvalue.substring(1);
					        }
					        String fieldvaluetmp = Util.StringReplace(fieldvalue,"\n","<br>");
					        fieldvaluetmp = Util.StringReplace(fieldvaluetmp,"\r","");
					  %>
						<script >
							insertToCustomer('<%=cfm.getId()%>', '<%=fieldvalue%>');
						</script>
					  <%
							if(cfm.getHtmlType().equals("1")||cfm.getHtmlType().equals("2")){
							%>
								<%=fieldvalue%>
							<%
							}else if(cfm.getHtmlType().equals("3")){
								String fieldtype = String.valueOf(cfm.getType());
								String url=BrowserComInfo.getBrowserurl(fieldtype); // �����ť����ҳ���url
								String linkurl=BrowserComInfo.getLinkurl(fieldtype);// ���ֵ�����ʱ�����ӵ�url
								String showname = "";                               // �½�ʱ��Ĭ��ֵ��ʾ������
								String showid = "";                                 // �½�ʱ��Ĭ��ֵ
								String fielddbtype=Util.null2String(cfm.getFieldDbType());
								if(fieldtype.equals("152") || fieldtype.equals("16")){
									linkurl = "/workflow/request/ViewRequest.jsp?requestid=";
								}
								if(fieldtype.equals("2") ||fieldtype.equals("19")){
									showname=fieldvalue; // ����ʱ��
								}else if(fieldtype.equals("141")) {
									showname=ResourceConditionManager.getFormShowName(fieldvalue,user.getLanguage());
								}else if(fieldtype.equals("4")) {
									showname="<a href='#' onclick=\"openFullWindowHaveBar('"+linkurl+fieldvalue+"');\">"+DepartmentComInfo.getDepartmentname(fieldvalue)+"</a>";
								}else if(fieldtype.equals("161")){//�Զ��嵥ѡ
								    showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
								    String showdesc="";
								    showid =fieldvalue;                                     // �½�ʱ��Ĭ��ֵ
								    try{
										Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
										BrowserBean bb=browser.searchById(showid);
										String desc=Util.null2String(bb.getDescription());
										String name=Util.null2String(bb.getName());
										showname="<a title='"+desc+"'>"+name+"</a>&nbsp";
								    }catch(Exception e){
								    }
								}else if(fieldtype.equals("162")){//�Զ����ѡ
								    showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
								    showid =fieldvalue;                                     // �½�ʱ��Ĭ��ֵ
								    try{
										Browser browser=(Browser)StaticObj.getServiceByFullname(fielddbtype, Browser.class);
										List l=Util.TokenizerString(showid,",");
										for(int jindex=0;jindex<l.size();jindex++){
											String curid=(String)l.get(jindex);
											BrowserBean bb=browser.searchById(curid);
											String name=Util.null2String(bb.getName());
											String desc=Util.null2String(bb.getDescription());
											showname+="<a title='"+desc+"'>"+name+"</a>&nbsp";
										}
								    }catch(Exception e){
								    }
								} else if(!fieldvalue.equals("")) {
									String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
									String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
									String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
									String sql = "";
									HashMap temRes = new HashMap();
									if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")||fieldtype.equals("142")||fieldtype.equals("152")||fieldtype.equals("168")||fieldtype.equals("171")||fieldtype.equals("166")) {    // ��������Դ,��ͻ�,����飬���ĵ���������
										sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
									} else if(fieldtype.equals("143")){
										//��״�ĵ��ֶ�
										String tempFieldValue="0";
										int beginIndex=0;
										int endIndex=0;
										if(fieldvalue.startsWith(",")){
											beginIndex=1;
										}else{
											beginIndex=0;
										}
										if(fieldvalue.endsWith(",")){
											endIndex=fieldvalue.length()-1;
										}else{
											endIndex=fieldvalue.length();
										}
										if(fieldvalue.equals(",")){
											tempFieldValue="0";			
										}else{
											tempFieldValue=fieldvalue.substring(beginIndex,endIndex);			
										}
										sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+tempFieldValue+")";

									} else {
										sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
									}
									RecordSet.executeSql(sql);
									while(RecordSet.next()){
										showid = Util.null2String(RecordSet.getString(1));
										String tempshowname= Util.toScreen(RecordSet.getString(2),languageId);
										if(!linkurl.equals("")) {
											temRes.put(String.valueOf(showid),"<a href='#' onclick=\"openFullWindowHaveBar('"+linkurl+showid+"');\">"+tempshowname+"</a> ");
										} else {
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
								<span id="customfield<%=cfm.getId()%>span"><%=Util.toScreen(showname,languageId)%></span>
							<%
							} else if(cfm.getHtmlType().equals("4")) {
							%>
								<input type=checkbox value=1 name="customfield<%=cfm.getId()%>" <%=fieldvalue.equals("1")?"checked":""%> disabled >
							<%
							} else if(cfm.getHtmlType().equals("5")) {
								cfm.getSelectItem(cfm.getId());
								while(cfm.nextSelect()){
									if(cfm.getSelectValue().equals(fieldvalue)){
									%>
										<%=cfm.getSelectName()%>
										<%
										break;
									}
								}
							}
						}
						%>
			<%
					}
				}
			%>
			</td>
			<% if(j==2||j==3){ %>
			</TR>
			<TR>
				<TD class=Line colSpan=4></TD>
			</TR>
			<% } %>
	<%
		j++;
		if(j>2) j=1;
	}
	%>
	<% if(j==2){ %>
			</TR>
			<TR>
				<TD class=Line colSpan=4></TD>
			</TR>
	<% } %>	
	<%-- �ĵ����� end --%>
