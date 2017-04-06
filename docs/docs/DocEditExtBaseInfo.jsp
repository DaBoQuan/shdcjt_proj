<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="java.net.*" %>
<%@ page import="weaver.docs.docs.CustomFieldManager" %>
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
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page" />
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="MouldManager" class="weaver.docs.mould.MouldManager" scope="page" />
<%
int userCategory = Util.getIntValue(request.getParameter("userCategory"));
int docid = Util.getIntValue(request.getParameter("docid"));
int imagefileId = Util.getIntValue(request.getParameter("imagefileId"),0);
int versionId = Util.getIntValue(request.getParameter("versionId"),0);
boolean isPersonalDoc = Util.null2String(request.getParameter("isPersonalDoc")).equals("true")?true:false;
String fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));

String needinputitems = "";

//ȡ���ĵ�����
String sql = "";
if(versionId==0){
    sql = "select * from DocImageFile where docid="+docid+" and (isextfile <> '1' or isextfile is null) order by versionId desc";
}else{
    sql = "select * from DocImageFile where docid="+docid+" and versionId="+versionId;
}
RecordSet.executeSql(sql) ;
RecordSet.next();
versionId = Util.getIntValue(RecordSet.getString("versionId"),0);
if(versionId==0){
	sql = "select * from DocImageFile where docid="+docid+" order by versionId desc";
	RecordSet.executeSql(sql) ;
	RecordSet.next();
}
versionId = Util.getIntValue(RecordSet.getString("versionId"),0);
String fileName=Util.null2String(""+RecordSet.getString("imagefilename"));
String filetype=Util.null2String(""+RecordSet.getString("docfiletype"));

if(filetype.equals("3")){
    filetype=".doc";
}else if(filetype.equals("4")){
    filetype=".xls";
}else if(filetype.equals("5")){
    filetype=".ppt";
}else if(filetype.equals("6")){
    filetype=".wps";
}else if(filetype.equals("7")){
    filetype=".docx";
}else if(filetype.equals("8")){
    filetype=".xlsx";
}else if(filetype.equals("9")){
    filetype=".pptx";
}else{
    filetype=".doc";
}

DocManager.resetParameter();
DocManager.setId(docid);
DocManager.getDocInfoById();
boolean isDefaultNoShowRevision=false;

String checkOutStatus=DocManager.getCheckOutStatus();
int checkOutUserId=DocManager.getCheckOutUserId();
String checkOutUserType=DocManager.getCheckOutUserType();

String checkOutUserName="";
if(checkOutUserType!=null&&checkOutUserType.equals("2")){
	checkOutUserName=CustomerInfoComInfo.getCustomerInfoname(""+checkOutUserId);
}else{
	checkOutUserName=ResourceComInfo.getResourcename(""+checkOutUserId);
}

String checkOutDate=DocManager.getCheckOutDate();
String checkOutTime=DocManager.getCheckOutTime();
String nodeType = "0";
//�ĵ���Ϣ
int maincategory=DocManager.getMaincategory();
int subcategory=DocManager.getSubcategory();
int seccategory=DocManager.getSeccategory();
int doclangurage=DocManager.getDoclangurage();
String docapprovable=DocManager.getDocapprovable();
String docreplyable=DocManager.getDocreplyable();
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
int assetid=DocManager.getAssetid();
int ownerid=DocManager.getOwnerid();
String keyword=DocManager.getKeyword();
int accessorycount=DocManager.getAccessorycount();
int replaydoccount=DocManager.getReplaydoccount();
String usertype=DocManager.getUsertype();
String canCopy=DocManager.getCanCopy();  //1:���ܿ��� ������������Կ���
//System.out.println("canCopyEdit = " + canCopy);

String docCode = DocManager.getDocCode();
int docedition = DocManager.getDocEdition();
int doceditionid = DocManager.getDocEditionId();

int selectedpubmouldid = DocManager.getSelectedPubMouldId();

String docCreaterType = DocManager.getDocCreaterType();//�ĵ����������ͣ�1:�ڲ��û�  2���ⲿ�û���
String ownerType = DocManager.getOwnerType();//�ĵ�ӵ�������ͣ�1:�ڲ��û�  2���ⲿ�û���

int maindoc = DocManager.getMainDoc();

int docreadoptercanprint = DocManager.getReadOpterCanPrint();

boolean isTemporaryDoc = false;
String invalidationdate = DocManager.getInvalidationDate();
String reqinvalidationdate = request.getParameter("invalidationdate");
if(reqinvalidationdate!=null)
    invalidationdate = reqinvalidationdate;
if(invalidationdate!=null&&!"".equals(invalidationdate))
    isTemporaryDoc = true;

String docstatusname = DocComInfo.getStatusView(docid,user);


//�Ƿ�ظ�����
String canRemind=DocManager.getCanRemind();
String hasUsedTemplet=DocManager.getHasUsedTemplet();//�Ƿ��Ѿ��׺�
int canPrintedNum=DocManager.getCanPrintedNum();//�ɴ�ӡ����

DocManager.closeStatement();
String docmain = "";

if(ownerid==0) ownerid=user.getUID() ;
String owneridname=ResourceComInfo.getResourcename(ownerid+"");
if (fromFlowDoc.equals("1")) {
	String tempdocsubject=Util.null2String((String)session.getAttribute("docsubject"+user.getUID()));
	session.removeAttribute("docsubject"+user.getUID());
	if(!tempdocsubject.equals("")){
		docsubject=tempdocsubject;
	}
}

//��Ŀ¼��Ϣ
RecordSet.executeProc("Doc_SecCategory_SelectByID",seccategory+"");
RecordSet.next();
String categoryname=Util.toScreenToEdit(RecordSet.getString("categoryname"),user.getLanguage());
String subcategoryid=Util.null2String(""+RecordSet.getString("subcategoryid"));
//String docmouldid=Util.null2String(""+RecordSet.getString("docmouldid"));
String publishable=Util.null2String(""+RecordSet.getString("publishable"));
String replyable=Util.null2String(""+RecordSet.getString("replyable"));
String shareable=Util.null2String(""+RecordSet.getString("shareable"));
String cusertype=Util.null2String(""+RecordSet.getString("cusertype"));
cusertype = cusertype.trim();
String cuserseclevel=Util.null2String(""+RecordSet.getString("cuserseclevel"));
if(cuserseclevel.equals("255")) cuserseclevel="0";
String cdepartmentid1=Util.null2String(""+RecordSet.getString("cdepartmentid1"));
String cdepseclevel1=Util.null2String(""+RecordSet.getString("cdepseclevel1"));
if(cdepseclevel1.equals("255")) cdepseclevel1="0";
String cdepartmentid2=Util.null2String(""+RecordSet.getString("cdepartmentid2"));
String cdepseclevel2=Util.null2String(""+RecordSet.getString("cdepseclevel2"));
if(cdepseclevel2.equals("255")) cdepseclevel2="0";
String croleid1=Util.null2String(""+RecordSet.getString("croleid1"));
String crolelevel1=Util.null2String(""+RecordSet.getString("crolelevel1"));
String croleid2=Util.null2String(""+RecordSet.getString("croleid2"));
String crolelevel2=Util.null2String(""+RecordSet.getString("crolelevel2"));
String croleid3=Util.null2String(""+RecordSet.getString("croleid3"));
String crolelevel3=Util.null2String(""+RecordSet.getString("crolelevel3"));
String approvewfid=RecordSet.getString("approveworkflowid");
String needapprovecheck="";
if(approvewfid.equals(""))  approvewfid="0";
if(approvewfid.equals("0"))
    needapprovecheck="0";
else
    needapprovecheck="1";

String readoptercanprint = Util.null2String(""+RecordSet.getString("readoptercanprint"));

/*���ڰѸ�������Ӵ����ĵ�����Աȷ���ĳ������û��Զ���ķ�ʽ.*/
// String hasaccessory =Util.toScreen(RecordSet.getString("hasaccessory"),user.getLanguage());
// int accessorynum = Util.getIntValue(RecordSet.getString("accessorynum"),user.getLanguage());
String hasasset=Util.toScreen(RecordSet.getString("hasasset"),user.getLanguage());
String assetlabel=Util.toScreen(RecordSet.getString("assetlabel"),user.getLanguage());
String hasitems =Util.toScreen(RecordSet.getString("hasitems"),user.getLanguage());
String itemlabel =Util.toScreenToEdit(RecordSet.getString("itemlabel"),user.getLanguage());
String hashrmres =Util.toScreen(RecordSet.getString("hashrmres"),user.getLanguage());
String hrmreslabel =Util.toScreenToEdit(RecordSet.getString("hrmreslabel"),user.getLanguage());
String hascrm =Util.toScreen(RecordSet.getString("hascrm"),user.getLanguage());
String crmlabel =Util.toScreenToEdit(RecordSet.getString("crmlabel"),user.getLanguage());
String hasproject =Util.toScreen(RecordSet.getString("hasproject"),user.getLanguage());
String projectlabel =Util.toScreenToEdit(RecordSet.getString("projectlabel"),user.getLanguage());
String hasfinance =Util.toScreen(RecordSet.getString("hasfinance"),user.getLanguage());
String financelabel =Util.toScreenToEdit(RecordSet.getString("financelabel"),user.getLanguage());
String approvercanedit=Util.toScreen(RecordSet.getString("approvercanedit"),user.getLanguage());

int maxOfficeDocFileSize = Util.getIntValue(RecordSet.getString("maxOfficeDocFileSize"),8);

boolean isEditionOpen = SecCategoryComInfo.isEditionOpen(seccategory);

int tmppos = doccontent.indexOf("!@#$%^&*");
if(tmppos!=-1){
	docmain = doccontent.substring(0,tmppos);
	doccontent = doccontent.substring(tmppos+8,doccontent.length());
}
%>
<table class=ViewForm id="docPropTable">
  <colgroup>
  <col width="15%">
  <col width="35%">
  <col width="15%">
  <col width="35%">
  </colgroup>
  <tbody>
	<%
	boolean canShowDocMain = false;

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
			label = SystemEnv.getHtmlLabelName(docPropLabelid,user.getLanguage());
			if(docPropType==10) label+="("+SystemEnv.getHtmlLabelName(89,user.getLanguage())+")";
		}
		
		if(docPropVisible==0) continue;
		
		if(docPropType==1||docPropType==11||docPropType==13||
				docPropType==14||docPropType==15||
				docPropType==16||docPropType==17||
				docPropType==18||docPropType==20
				)
			continue;
		
		if(docPropColumnWidth>1){
			if(j==2){
	%>
			</TR>
			<tr>
				<td class=Line colSpan=4></td>
			</tr>
	<%
			}
			j=3;
		}
	%>
			<% if(j==1||j==3){ %>
			<tr height="20">
			<% } %>
			
			<td><%=label%></td>
			<td class=field <%if(j==3){%>colspan="3"<%}%>>
			<%
				switch(docPropType){
					case 1:{//1 �ĵ�����
			%>
						
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
						//int tmppos = doccontent.indexOf("!@#$%^&*");
						//if(tmppos!=-1){
						//	docmain = doccontent.substring(0,tmppos);
						//	doccontent = doccontent.substring(tmppos+8,doccontent.length());
						//}
						
						if(!publishable.trim().equals("") && !publishable.trim().equals("0")){
							String ischeck1="";
							String ischeck2="";
							String ischeck3="";
							if(docpublishtype.equals("1")) ischeck1=" selected ";
							if(docpublishtype.equals("2")) {
								ischeck2=" selected ";
							}
							if(docpublishtype.equals("3")) ischeck3=" selected ";
							
							canShowDocMain = true;
							
							%>
							<select  name="docpublishtype" onchange="if(this.value==2) onshowdocmain(1) ; else onshowdocmain(0)">
								<option value=1  <%=ischeck1%>><font color=red><%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%></font></option>
								<option value=2  <%=ischeck2%>><font color=red><%=SystemEnv.getHtmlLabelName(227,user.getLanguage())%></font></option>
								<option value=3  <%=ischeck3%>><font color=red><%=SystemEnv.getHtmlLabelName(229,user.getLanguage())%></font></option>
							</select>
							<script type="text/javascript">
								function onshowdocmain(vartmp){
									if(vartmp==1){
										otrtmp.parentElement.style.display='';
										otrtmp.parentElement.parentElement.parentElement.rows(otrtmp.parentElement.rowIndex+1).style.display='';
									} else {
										otrtmp.parentElement.style.display='none';
										otrtmp.parentElement.parentElement.parentElement.rows(otrtmp.parentElement.rowIndex+1).style.display='none';
									}
								}
							</script>						
						<%
						} else {
						%>
						<%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%>
						<% } %>
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
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,user.getLanguage())+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
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
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,user.getLanguage())+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
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
						      out.println("��"+SystemEnv.getHtmlLabelName(17600,user.getLanguage())+"�ݡ�"+catalogNames+DocUserSelfUtil.getCatalogName(""+userCategory));
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
						<span id=docdepartmentidspan>
							<a href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=docdepartmentid%>" target="_blank"><%=Util.toScreen(DepartmentComInfo.getDepartmentname(""+docdepartmentid),user.getLanguage())%></a>
						</span>
			<%
						break;
					}
					case 10:{//10 ģ��
						if(!SecCategoryComInfo.needPubOperation(seccategory)){                                                                           			        
						    int tmpdocmouldid = 0;                                                                                                       
						    List selectMouldList = new ArrayList();                                                                                      
						    int selectMouldType = 0;                                                                                                     
						    int selectDefaultMould = 0;                                                                                                  
							if(filetype.equals(".doc")){                                                                                                                
								RecordSet.executeSql("select * from DocSecCategoryMould where secCategoryId = "+seccategory+" and mouldType=3 order by id ");
								while(RecordSet.next()){                                                                                                     
									String moduleid=RecordSet.getString("mouldId");                                                                            
									String mType = DocMouldComInfo.getDocMouldType(moduleid);                                                                  
									String modulebind = RecordSet.getString("mouldBind");                                                                      
									int isDefault = Util.getIntValue(RecordSet.getString("isDefault"),0);                                                      
	                                                                                                                                           
									if(isTemporaryDoc){
										if(Util.getIntValue(modulebind,1)==3){
										    selectMouldType = 3;
										    selectDefaultMould = Util.getIntValue(moduleid);
										    selectMouldList.add(moduleid);
									    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
									        if(selectMouldType==0){
										        selectMouldType = 1;
											    selectDefaultMould = Util.getIntValue(moduleid);
									        }
											selectMouldList.add(moduleid);
									    } else {
									        if(Util.getIntValue(modulebind,1)!=2)
												selectMouldList.add(moduleid);
									    }

									} else {
									
										if(Util.getIntValue(modulebind,1)==2){                                                                                     
										    selectMouldType = 2;                                                                                                   
										    selectDefaultMould = Util.getIntValue(moduleid);                                                                       
										    selectMouldList.add(moduleid);                                                                                         
									    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){                                                              
										    if(selectMouldType==0){
										        selectMouldType = 1;                                                                                                 
											    selectDefaultMould = Util.getIntValue(moduleid);
										    }
											selectMouldList.add(moduleid);                                                                                           
									    } else {                                                                                                                 
									        if(Util.getIntValue(modulebind,1)!=3)                                                                                
												selectMouldList.add(moduleid);                                                                                         
									    }                                                                                                                        
									}                                                                                                                            
								}                                                                                                                            
							    if(selectMouldType>0)
								    tmpdocmouldid = selectDefaultMould;
								%>                                                                                                                           
								<select class=InputStyle name=selectedpubmouldid <%if(selectMouldType==2||selectMouldType==3){%>disabled<%}%> style="width:200">                 
								<%if(selectMouldType<2){%>                                                                                                   
								<option value="-1"></option>                                                                                                 
								<%}%>                                                                                                                        
								<%                                                                                                                           
								for(int i=0;i<selectMouldList.size();i++){                                                                                   
								  	String moduleid = (String) selectMouldList.get(i);                                                                       
									String modulename = DocMouldComInfo.getDocMouldname(moduleid);                                                             
								    String mType = DocMouldComInfo.getDocMouldType(moduleid);                                                                
								    String mouldTypeName = "";                                                                                               
								    if(mType.equals("")||mType.equals("0")||mType.equals("1")) {                                                             
								        mouldTypeName="HTML";                                                                                                
								        continue;
								    } else if(mType.equals("2")) {                                                                                           
								        mouldTypeName="WORD";                                                                                                
								    } else if(mType.equals("3")){                                                                                            
								        mouldTypeName="EXCEL";                                                                                               
								        continue;                                                                                                            
								    } else {                                                                                                                 
								        continue;                                                                                                            
								    }                                                                                                                        
									String isselect ="" ;                                                                                                      
									if(tmpdocmouldid==Util.getIntValue(moduleid)) isselect = " selected";                                                      
									%>                                                                                                                         
							  		<option value="<%=moduleid%>" <%=isselect%> ><%=modulename%>(<%=mouldTypeName%>)</option>                                
									<%                                                                                                                         
								}                                                                                                                            
								%>                                                                                                                           
								</select>                                                                                                                    
								<%                                                                                                                           
							}                                                                                                                              
						} else {
						    %>
							<a href="/docs/mould/DocMouldDsp.jsp?id=<%=selectedpubmouldid%>">
							<%=DocMouldComInfo.getDocMouldname(selectedpubmouldid+"")%>
							</a>
						<%
						}
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
						<input class=InputStyle maxlength=250 size=26 name=keyword value="<%=keyword%>"
						<% if(docPropMustInput==1){ %>
						onChange="checkinput('keyword','keywordspan')" >
						<span id="keywordspan">
						<%if(keyword.equals("")){%>
						<img src="/images/BacoError.gif" align=absMiddle>
						<%}%>
						</span>
						<%
						needinputitems += ",keyword";
						%>
						<%} else {%>
						>
						<%}%>
			<%
						break;
					}
					case 13:{//13 ����
			%>
						<%if(usertype.equals("1")){%>
							<a href="javaScript:openhrm(<%=doccreaterid%>);" onclick='pointerXY(event);'>
							<%=Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),user.getLanguage())%>
							</a>
						<%}else{%>
							<a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=doccreaterid%>">
							<%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),user.getLanguage())%>
							</a>
						<%}%>
						&nbsp;<%=doccreatedate%>&nbsp;<%=doccreatetime%>
			<%
						break;
					}
					case 14:{//14 �޸�
			%>
						<%if(usertype.equals("1")){%>
							<a href="javaScript:openhrm(<%=doclastmoduserid%>);" onclick='pointerXY(event);'>
							<%=Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),user.getLanguage())%>
							</a>
						<%}else{%>
							<a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=doclastmoduserid%>">
							<%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doclastmoduserid),user.getLanguage())%>
							</a>
						<%}%>
						&nbsp;<%=doclastmoddate%>&nbsp;<%=doclastmodtime%>
			<%
						break;
					}
					case 15:{//15 ��׼
			%>
						<%if(docapproveuserid!=0){%>
							<a<%if(user.getType()==0){%> href="javaScript:openhrm(<%=docapproveuserid%>);" onclick='pointerXY(event);'<%}%>><%=Util.toScreen(ResourceComInfo.getResourcename(""+docapproveuserid),user.getLanguage())%></a>
							&nbsp;<%=docapprovedate%>&nbsp;<%=docapprovetime%>
						<%}%>
			<%
						break;
					}
					case 16:{//16 ʧЧ
			%>
			<%
						break;
					}
					case 17:{//17 �鵵
			%>
						<%if(docarchiveuserid!=0){%>
							<a<%if(user.getType()==0){%> href="javaScript:openhrm(<%=docarchiveuserid%><%}%>);" onclick='pointerXY(event);'><%=Util.toScreen(ResourceComInfo.getResourcename(""+docarchiveuserid),user.getLanguage())%></a>
							&nbsp;<%=docarchivedate%>&nbsp;<%=docarchivetime%>
						<%}%>
			<%
						break;
					}
					case 18:{//18 ����
			%>
			<%
						break;
					}
					case 19:{//19 ���ĵ�
			%>
						<button type="button" class=Browser onClick="onSelectMainDocument()" name=selectMainDocument></button>
						<span id=spanMainDocument name=spanMainDocument>
						<% if(maindoc==docid){ %>
						<%=SystemEnv.getHtmlLabelName(524,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(58,user.getLanguage())%>
						<% } else { %>
						<%=DocComInfo.getDocname(maindoc+"")%>
						<% } %>
						</span>
			<%
						break;
					}
					case 20:{//20 �������б�
			%>
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
						<button type="button" class=Calendar onClick="getInvalidationDate(<%=user.getLanguage()%>);
						<% if(docPropMustInput==1){ %>
						checkinput('invalidationdate','invalidationdatespan1');"></button> 
						<span id=invalidationdatespan><%=invalidationdate%></span> 
						<input type="hidden" name="invalidationdate" value="<%=invalidationdate%>">
						<span id="invalidationdatespan1">
						<%if(invalidationdate.equals("")){%>
						<img src="/images/BacoError.gif" align=absMiddle>
						<%}%>
						</span>
						<%
						needinputitems += ",invalidationdate";
						%>
						<%} else {%>
						"></BUTTON> 
						<span id=invalidationdatespan><%=invalidationdate%></span> 
						<input type="hidden" name="invalidationdate" value="<%=invalidationdate%>">
						<span id="invalidationdatespan1"></span>
						<%}%>
						<%
						break;
					}
					case 24:{//24 ����Ŀ¼
						String strSql="select catelogid from DocDummyDetail where docid="+docid;
						rsDummyDoc.executeSql(strSql);
						String dummyIds="";
						String dummyNames="";
						while(rsDummyDoc.next()){
							dummyIds+=Util.null2String(rsDummyDoc.getString(1))+",";
						}
						if(!"".equals(dummyIds)) {
							dummyIds=dummyIds.substring(0,dummyIds.length()-1);
							dummyNames=DocTreeDocFieldComInfo.getMultiTreeDocFieldNameOther(dummyIds);
						}
						%>
						
						<button type="button" class=Browser
						onClick="onShowMutiDummy(dummycata,spanDummycata);
						<% 
						if(docPropMustInput==1){
							%>
							checkinput('dummycata','spanDummycata1');"></button>
						
							<span id="spanDummycata1" name="spanDummycata1">
							<%
							if("".equals(dummyNames)){ %>
								&nbsp;<img src="/images/BacoError.gif" align=absMiddle>
							<%}%>
								
							</span>
							<%
							needinputitems += ",dummycata";
							%>
							<% 
						} else {
							%>
							"></BUTTON>							
					   <%}%>
					   <span id="spanDummycata" name="spanDummycata"><%=dummyNames%></span>
					   <input type="hidden" name="dummycata" id="dummycata" value="<%=dummyIds%>">
						<%
						break;
					}
					case 25:{//25 �ɴ�ӡ����
			%>
						<input class=InputStyle size=4 maxlength=4 name=canPrintedNum value="<%=canPrintedNum%>" onKeyPress="ItemCount_KeyPress()"
						<% if(docPropMustInput==1){ %>
						    onChange="checknumber('canPrintedNum');checkinput('canPrintedNum','canPrintedNumSpan')" 
						<%
						needinputitems += ",canPrintedNum";
						%>
						<%}else{%>
						    onChange="checknumber('canPrintedNum')" 
						<%}%>
						>						
						<span id="canPrintedNumSpan">
						</span>
			<%
						break;
					}
					case 0:{//0 �Զ����ֶ�
			%>
			
			
					<%-- �Զ����ֶ� start --%>
						<%
						CustomFieldManager cfm = new CustomFieldManager("DocCustomFieldBySecCategory",seccategory);
					    cfm.getCustomFields(docPropFieldid);
						cfm.getCustomData(docid);
					    if(cfm.next()){
							if(cfm.isMand()){
								needinputitems += ",customfield"+cfm.getId();
							}
							String fieldvalue = cfm.getData("field"+cfm.getId());
							 if(fieldvalue.startsWith(",")){
						        	fieldvalue = fieldvalue.substring(1);
						     }
						%>
							<%
							if(cfm.getHtmlType().equals("1")){
								if(cfm.getType()==1){
									if(cfm.isMand()){
							%>
										<input datatype="text" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=50 onChange="checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
										<span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
									<%
									}else{
									%>
										<input datatype="text" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" value="" size=50>
							<%
									}
								}else if(cfm.getType()==2){
									if(cfm.isMand()){
							%>
										<input datatype="int" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10
										onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
										<span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
									<%
									}else{
									%>
										<input  datatype="int" type=text  value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10 onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
								<%
									}
								}else if(cfm.getType()==3){
									if(cfm.isMand()){
								%>
										<input datatype="float" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10
										onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
										<span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
									<%
									}else{
									%>
										<input datatype="float" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10 onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
									<%
									}
								}
							}else if(cfm.getHtmlType().equals("2")){
								if(cfm.isMand()){
								%>
									<textarea class=Inputstyle name="customfield<%=cfm.getId()%>" onChange="checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')"
									rows="4" cols="40" style="width:80%" class=Inputstyle><%=fieldvalue%></textarea>
									<span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
								<%
								}else{
								%>
									<textarea class=Inputstyle name="customfield<%=cfm.getId()%>" rows="4" cols="40" style="width:80%"><%=fieldvalue%></textarea>
								<%
								}
							}else if(cfm.getHtmlType().equals("3")){
	
								String fieldtype = String.valueOf(cfm.getType());
								String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
								String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
								String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
								String showid = "";                                     // �½�ʱ��Ĭ��ֵ
								String fielddbtype=Util.null2String(cfm.getFieldDbType());
								if(fieldtype.equals("152") || fieldtype.equals("16")){
									linkurl = "/workflow/request/ViewRequest.jsp?requestid=";
								}
								String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
								String newdocid = Util.null2String(request.getParameter("docid"));
						
								if( fieldtype.equals("37") && !newdocid.equals("")) {
									if( ! fieldvalue.equals("") ) fieldvalue += "," ;
									fieldvalue += newdocid ;
								}
	
								if(fieldtype.equals("2") ||fieldtype.equals("19")){
									showname=fieldvalue; // ����ʱ��
								}else if(fieldtype.equals("141")){
									showname=ResourceConditionManager.getFormShowName(fieldvalue,user.getLanguage()); // ������Դ����
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
								}  else if(!fieldvalue.equals("")) {
									String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
									String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
									String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
									sql = "";
								
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
										showid = Util.null2String(RecordSet.getString(1)) ;
										String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
										if(!linkurl.equals(""))
											//showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
											temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
										else {
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
								if(fieldtype.equals("161")||fieldtype.equals("162")){
									url+="?type="+fielddbtype;
								}
								%>
								<button type="button" class=Browser 
								<%if(!fieldtype.equals("2") && !fieldtype.equals("19")){%>
								 onClick="onShowBrowser('<%=cfm.getId()%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=cfm.isMand()?"1":"0"%>')"
					            <%}else{if(fieldtype.equals("2")){%>
								 onClick ="onShowDocDate('<%=cfm.getId()%>','<%=fieldtype%>','<%=cfm.isMand()%>')"
								<%}else{%>
								  onClick ="onShowDocsTime(customfield<%=cfm.getId()%>span,customfield<%=cfm.getId()%>,'<%=cfm.isMand()%>')"
								<%}}%>
								 title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
								<input type=hidden name="customfield<%=cfm.getId()%>" value="<%=fieldvalue%>">
								<span id="customfield<%=cfm.getId()%>span"><%=Util.toScreen(showname,user.getLanguage())%>
								<%if(cfm.isMand() && fieldvalue.equals("")) {%><img src="/images/BacoError.gif" align=absmiddle><%}%>
								</span>
							<%
							}else if(cfm.getHtmlType().equals("4")){
							%>
								<input type=checkbox value=1 name="customfield<%=cfm.getId()%>" <%=fieldvalue.equals("1")?"checked":""%> >
							<%
							}else if(cfm.getHtmlType().equals("5")){
								cfm.getSelectItem(cfm.getId());
								boolean checkempty_tmp = true;
								%>
								<select name="customfield<%=cfm.getId()%>" viewtype="<%if(cfm.isMand()){out.print("1");}else{out.print("0");}%>" class="InputStyle" onChange="checkinput2('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span',this.getAttribute('viewtype'))">
									<option value=""></option>
								<%
								while(cfm.nextSelect()){
									if(cfm.getSelectValue().equals(fieldvalue)){
										checkempty_tmp = false;
									}
								%>
									<option value="<%=cfm.getSelectValue()%>" <%=cfm.getSelectValue().equals(fieldvalue)?"selected":""%>><%=cfm.getSelectName()%></option>
								<%
								}
								%>
								</select>
								<span id="customfield<%=cfm.getId()%>span">
					<%
								if(cfm.isMand() && checkempty_tmp) {
					%>
									<img src="/images/BacoError.gif" align=absmiddle>
					<%
								}
					%>
								</span>
							<%
							}
						}
						%>
						<%-- �Զ����ֶ� end--%>
			<%
					}
				}
			%>
			</td>
			<% if(j==2||j==3){ %>
			</tr>
			<tr>
				<td class=Line colSpan=4></td>
			</tr>
			<% } %>
	<%
		j++;
		if(j>2) j=1;
	}
	%>
	<% if(j==2){ %>
			</TR>
			<tr>
				<td class=Line colSpan=4></td>
			</tr>
	<% } %>	

	
	<%-- ժҪ start  --%>
	<% 
	if(canShowDocMain){
	%>
	<tr height="20" id=oDiv style="display:'<%=docpublishtype.equals("2")?"block":"none"%>'">
		<td id=otrtmp><%=SystemEnv.getHtmlLabelName(341,user.getLanguage())%></td>
		<td class=field colspan="3">
			<input class=InputStyle size=70 name="docmain" onChange="checkinput('docmain','docmainspan')" value="<%=docmain%>">
		    <span id="docmainspan">
		    <%if(docmain==null||"".equals(docmain)){%><img src="/images/BacoError.gif" align=absMiddle><%}%>
		    </span>
		</td>
	</tr>
	<tr class=Spacing id=oDiv style="display:''">
		<td class=Line colSpan=2></td>
	</tr>
	<%
	}
	%>
	<%-- ժҪ end --%>
	
	
	<tr height="20" style="display:none">
		<td colSpan=4>
			<textarea NAME="doccontent" ROWS="10" COLS="10" style="display:none"><%=Util.encodeAnd(doccontent)%></textarea>
			<div id=oDiv style="display:none">
				<input type=hidden name=accessorynum value="1">
				<script language=javascript>
					function showHeader(){
						if(oDiv.style.display=='')
						oDiv.style.display='none';
						else
						oDiv.style.display='';
					}
				</script>
			</div>
		</td>
	</tr>
	

	<%-- ���� start --%>
	<%
	String sepStr="<TR><TD class=Line colSpan=4></TD></TR>";
	int needtr=0;
	if(!hashrmres.trim().equals("0")&&!hashrmres.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(179,user.getLanguage());
		if(!hrmreslabel.trim().equals("")) curlabel = hrmreslabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td ><%=curlabel%></td>
			<td  class=field>
			<%if(!user.getLogintype().equals("2")){%>
				<button type="button" class=Browser onClick="onShowHrmresID(<%=hashrmres%>)"></button>
			<%}%>
			<span id=hrmresspan>
			<%if(hashrmres.equals("2"))
				needinputitems += ",hrmresid";
			%>
			<a href="javaScript:openhrm(<%=hrmresid%>);" onclick='pointerXY(event);'><%=Util.toScreen(ResourceComInfo.getResourcename(""+hrmresid),user.getLanguage())%></a>
			</span>
			<input type=hidden name=hrmresid value="<%=hrmresid%>">
			</td>

		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>


	<%
	if(!hasasset.trim().equals("0")&&!hasasset.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(535,user.getLanguage());
		if(!assetlabel.trim().equals("")) curlabel = assetlabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td ><%=curlabel%></td>
			<td class=field>
			<%if(!user.getLogintype().equals("2")){%>
				<button type="button" class=Browser onClick="onShowAssetId(<%=hasasset%>)"></button>
			<%}%>
			<span id=assetidspan>
			<%if(hasasset.equals("2"))
				needinputitems += ",assetid";
			%>
			<a href="/cpt/capital/CapitalBrowser.jsp?id=<%=assetid%>"><%=Util.toScreen(CapitalComInfo.getCapitalname(""+assetid),user.getLanguage())%></a>
			</span>
			<input type=hidden name=assetid value="<%=assetid%>">
		</td>
		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>
	
	
	<%
	if(!hascrm.trim().equals("0")&&!hascrm.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(147,user.getLanguage());
		if(!crmlabel.trim().equals("")) curlabel = crmlabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td ><%=curlabel%></td>
			<td class=field>
			<button type="button" class=Browser onClick="onShowCrmID(<%=hascrm%>)"></button>
			<span id=crmidspan>
			<%if(hascrm.equals("2"))
				needinputitems += ",crmid";
			%>
			<a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=crmid%>"><%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+crmid),user.getLanguage())%></a>
			</span>
			<input type=hidden name=crmid value="<%=crmid%>">
		</td>
		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>
	
	
	<%
	if(!hasitems.trim().equals("0")&&!hasitems.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(145,user.getLanguage());
		if(!itemlabel.trim().equals("")) curlabel = itemlabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td ><%=curlabel%></td>
			<td class=field>
			<button type="button" class=Browser onClick="onShowItemID(<%=hasitems%>)"></button>
			<span id=itemspan>
			<%if(hasitems.equals("2")){
				needinputitems += ",itemid";
			}
			%>
			<a href='/lgc/asset/LgcAsset.jsp?paraid=<%=itemid%>'><%=AssetComInfo.getAssetName(""+itemid)%></a>
			</span>
			<input type=hidden name=itemid value="<%=itemid%>">
		</td>
		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>
	
	
	<%
	if(!hasproject.trim().equals("0")&&!hasproject.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(101,user.getLanguage());
		if(!projectlabel.trim().equals("")) curlabel = projectlabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td><%=curlabel%></td>
			<td class=field>
			<button type="button" class=Browser onClick="onShowProjectID(<%=hasproject%>)"></button>
			<span id=projectidspan>
			<%if(hasproject.equals("2"))
			needinputitems += ",projectid";
			%>
			<a href="/proj/data/ViewProject.jsp?ProjID=<%=projectid%>"><%=Util.toScreen(ProjectInfoComInfo.getProjectInfoname(""+projectid),user.getLanguage())%></a>
			</span>
			<input type=hidden name=projectid value="<%=projectid%>">
			</td>
		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>
	
	
	
	<%
	if(!hasfinance.trim().equals("0")&&!hasfinance.trim().equals("")){
		String curlabel = SystemEnv.getHtmlLabelName(189,user.getLanguage());
		if(!financelabel.trim().equals("")) curlabel = financelabel;
		%>
		<% if(needtr==0){ out.println("<tr height=\"20\">");}%>
			<td ><%=curlabel%></td>
			<td class=field>
			<button type="button" class=Browser></button>
			<input type=hidden name=financeid value="<%=financeid%>">
			</td>
		<%
		if(needtr==1){ 
			out.print("</TR>"+sepStr);
			needtr=0;
		} else needtr++;
	}
	%>
	<%-- ���� end --%>


	<%-- �༭״̬ start --%>
	<tr height="20">
		<td>
			<%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%>
		</td>
		<td class=field colspan="3" noWrap>
			
<%


    if(checkOutStatus!=null&&(checkOutStatus.equals("1")||checkOutStatus.equals("2"))){
	    out.print(checkOutUserName+"  "+checkOutDate+"  "+checkOutTime+" "+SystemEnv.getHtmlLabelName(19692,user.getLanguage()));
    }else{ 
	    out.print(SystemEnv.getHtmlLabelName(19988,user.getLanguage()));
	}
%>		
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%if(replyable.equals("1")){%>
			<input type="checkbox" name="canremind" value="2" id="remindinput" <%=canRemind.equals("2")?"checked":""%>><label for="remindinput"><%=SystemEnv.getHtmlLabelName(18641,user.getLanguage())%></label>
			<%}%>
			<%if(readoptercanprint.equals("2")){%>
			<input type="checkbox" name="readoptercanprint" value="1" id="readoptercanprint" <%=docreadoptercanprint==1?"checked":"" %>><label for="readoptercanprint"><%=SystemEnv.getHtmlLabelName(19462,user.getLanguage())%></label>
			<%} else if(readoptercanprint.equals("1")){%>
			<input type="hidden" name="readoptercanprint" value="1" id="readoptercanprint">
			<%} else if(readoptercanprint.equals("0")){%>
			<input type="hidden" name="readoptercanprint" value="0" id="readoptercanprint">
			<%}%>
		</td>
	<tr>
		<td class=Line colSpan=4></td>
	</tr>
	<%-- �༭״̬ end --%>

	<tr height="20" style="display:none">
		<td colspan=4>
			<!--###@2007-08-27 modify by yeriwei!
			<iframe frameborder=0 style="width:100%;height:500px;display:none" name="dhtmlFrm" id="dhtmlFrm" src="/docs/docs/dhtml.jsp"></iframe>
			---->
			<script language=vbs>
			sub onShowLanguage()
				id = window.showModalDialog("/systeminfo/language/LanguageBrowser.jsp")
				language.innerHtml = id(1)
				weaver.doclangurage.value=id(0)
			end sub
			</script>
			
		</td>
	</tr>
	
	</TBODY>
	</table>
	
	<input type="hidden" name="needinputitems" value="<%=needinputitems%>">