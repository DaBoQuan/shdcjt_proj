<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.docs.docs.CustomFieldManager,
                 java.net.*" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.sql.Timestamp" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ include file="iWebOfficeConf.jsp" %>
<%
	if("false".equals(isIE)){
		request.setAttribute("labelid","27969");
		request.getRequestDispatcher("/wui/common/page/sysRemind.jsp").forward(request,response);
		return;
	}
%>
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryManager" class="weaver.docs.category.SecCategoryManager" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page"/>
<jsp:useBean id="AssetAssortmentComInfo" class="weaver.lgc.maintenance.AssetAssortmentComInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="Record" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="DocUserSelfUtil" class="weaver.docs.docs.DocUserSelfUtil" scope="page"/>
<jsp:useBean id="SpopForDoc" class="weaver.splitepage.operate.SpopForDoc" scope="page"/>
<jsp:useBean id="DocUtil" class="weaver.docs.docs.DocUtil" scope="page" />
<jsp:useBean id="DocDsp" class="weaver.docs.docs.DocDsp" scope="page"/>
<jsp:useBean id="SecCategoryMouldComInfo" class="weaver.docs.category.SecCategoryMouldComInfo" scope="page"/>
<jsp:useBean id="SecCategoryDocPropertiesComInfo" class="weaver.docs.category.SecCategoryDocPropertiesComInfo" scope="page"/>
<jsp:useBean id="DocCoder" class="weaver.docs.docs.DocCoder" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mould.DocMouldComInfo" scope="page" />
<jsp:useBean id="DocTreeDocFieldComInfo" class="weaver.docs.category.DocTreeDocFieldComInfo" scope="page" />
<jsp:useBean id="DocMark" class="weaver.docs.docmark.DocMark" scope="page" />
<jsp:useBean id="rsDummyDoc" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="WFLinkInfo" class="weaver.workflow.request.WFLinkInfo" scope="page"/>
<jsp:useBean id="DocHandwrittenManager" class="weaver.docs.docs.DocHandwrittenManager" scope="page"/>
<jsp:useBean id="DocDetailLog" class="weaver.docs.DocDetailLog" scope="page"/>
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="WTRequestUtil" class="weaver.worktask.worktask.WTRequestUtil" scope="page" />
<jsp:useBean id="shareManager" class="weaver.share.ShareManager" scope="page" />
<%//�жϽ��ؼ��İ汾	 2003����2006

String canPostil = "";
if(isIWebOffice2006 == true){
	canPostil = ",1";
}
int languageId=user.getLanguage();

char flag=Util.getSeparator() ;

//user info
String userid=""+user.getUID();
String logintype = user.getLogintype();
String username=ResourceComInfo.getResourcename(""+userid);
String userSeclevel = user.getSeclevel();
String userType = ""+user.getType();
String userdepartment = ""+user.getUserDepartment();
String usersubcomany = ""+user.getUserSubCompany1();

String isrequest = Util.null2String(request.getParameter("isrequest"));
int requestid=Util.getIntValue(request.getParameter("requestid"),0);
int workflowid=0;
int nodeid=0;
int currentnodeid=0;
int lastnodeid = 0;
String nodeName="";
String ifVersion="0";
boolean hasRightOfViewHisVersion=HrmUserVarify.checkUserRight("DocExt:ViewHisVersion", user);

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

//�ж��½����ǲ��Ǹ����ĵ�
boolean isPersonalDoc = false ;
String from =  Util.null2String(request.getParameter("from"));
int userCategory= Util.getIntValue(request.getParameter("userCategory"),0);
if ("personalDoc".equals(from)){
    isPersonalDoc = true ;
}
boolean isFromAccessory="true".equals(request.getParameter("isFromAccessory"))?true:false;

String temStr = request.getRequestURI();
temStr=temStr.substring(0,temStr.lastIndexOf("/")+1);

String mServerUrl=temStr+mServerName;
String mClientUrl=temStr+mClientName;

int docid = Util.getIntValue(request.getParameter("id"),0);
int versionId = Util.getIntValue(request.getParameter("versionId"),0);
if(isrequest.equals("1")&&requestid>0){
	versionId=0;
	int maxId=0;
	RecordSet.executeSql("select max(a.id) as maxid from DocDetail a where a.doceditionid>0 and  exists(select 1 from DocDetail  where doceditionid=a.doceditionid and id="+docid+") ") ;
	if(RecordSet.next()){
		maxId = Util.getIntValue(RecordSet.getString("maxid"),0);
	}
	if(maxId>docid){
		docid=maxId;
	}
}
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


int imagefileId = Util.getIntValue(request.getParameter("imagefileId"),0);

/*�ж��Ƿ���PDF�ĵ�//�ĵ����ĵ��Ƿ�򿪸�������*/
String isOpenFirstAss = Util.null2String(request.getParameter("isOpenFirstAss"));
boolean isPDF = DocDsp.isPDF(docid,imagefileId,Util.getIntValue(isOpenFirstAss,1));
if(imagefileId==0&&Util.getIntValue(filetype,0) != 2) isPDF = false;
if(isPDF){
    //response.sendRedirect("DocDsp.jsp?id="+docid+"&imagefileId="+imagefileId+"&isFromAccessory=true&isrequest=1&requestid="+requestid);
%>
		    <script language=javascript>
					location="DocDsp.jsp?id=<%=docid%>&imagefileId=<%=imagefileId%>&isFromAccessory=true&isrequest=1&requestid=<%=requestid%>";
		    </script> 
<%
    return ;
}


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
}else if(filetype.equals("10")){
    filetype=".et";
}else{
    filetype=".doc";
}


String  docEditType=Util.null2String(request.getParameter("docEditType"));
if(docEditType.equals("")){
    docEditType = "1";
}
String topageFromOther=Util.null2String(request.getParameter("topage"));
String subid=Util.null2String(request.getParameter("subid"));
int SecId=Util.getIntValue(Util.null2String(request.getParameter("SecId")),0);
int maxUploadImageSize = DocUtil.getMaxUploadImageSize2(docid);
int bacthDownloadFlag = DocUtil.getBatchDownloadFlag(docid);
String fromFlowDoc=Util.null2String(request.getParameter("fromFlowDoc"));  //��Դ�����̽��ĵ�
String needinputitems = "";
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
docsubject=Util.StringReplace(docsubject,"\"", "&quot;");
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
	String tempdocsubject=Util.null2String((String)session.getAttribute(""+user.getUID()+"_"+requestid+"docsubject"));

	if(tempdocsubject.equals("")){
		tempdocsubject=Util.null2String((String)session.getAttribute("docsubject"+user.getUID()));
	}
	session.removeAttribute(""+user.getUID()+"_"+requestid+"docsubject");
	session.removeAttribute("docsubject"+user.getUID());
	if(!tempdocsubject.equals("")){
		docsubject=tempdocsubject;
	}
}

//��Ŀ¼��Ϣ
RecordSet.executeProc("Doc_SecCategory_SelectByID",seccategory+"");
RecordSet.next();
String categoryname=Util.toScreenToEdit(RecordSet.getString("categoryname"),languageId);
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
// String hasaccessory =Util.toScreen(RecordSet.getString("hasaccessory"),languageId);
// int accessorynum = Util.getIntValue(RecordSet.getString("accessorynum"),languageId);
String hasasset=Util.toScreen(RecordSet.getString("hasasset"),languageId);
String assetlabel=Util.toScreen(RecordSet.getString("assetlabel"),languageId);
String hasitems =Util.toScreen(RecordSet.getString("hasitems"),languageId);
String itemlabel =Util.toScreenToEdit(RecordSet.getString("itemlabel"),languageId);
String hashrmres =Util.toScreen(RecordSet.getString("hashrmres"),languageId);
String hrmreslabel =Util.toScreenToEdit(RecordSet.getString("hrmreslabel"),languageId);
String hascrm =Util.toScreen(RecordSet.getString("hascrm"),languageId);
String crmlabel =Util.toScreenToEdit(RecordSet.getString("crmlabel"),languageId);
String hasproject =Util.toScreen(RecordSet.getString("hasproject"),languageId);
String projectlabel =Util.toScreenToEdit(RecordSet.getString("projectlabel"),languageId);
String hasfinance =Util.toScreen(RecordSet.getString("hasfinance"),languageId);
String financelabel =Util.toScreenToEdit(RecordSet.getString("financelabel"),languageId);
String approvercanedit=Util.toScreen(RecordSet.getString("approvercanedit"),languageId);

int maxOfficeDocFileSize = Util.getIntValue(RecordSet.getString("maxOfficeDocFileSize"),8);

boolean isEditionOpen = SecCategoryComInfo.isEditionOpen(seccategory);

//��ӡ����
boolean canPrintApply=false;
String isagentOfprintApply="0";
String isPrintControl=Util.null2String(RecordSet.getString("isPrintControl"));
int printApplyWorkflowId = Util.getIntValue(RecordSet.getString("printApplyWorkflowId"),0);
		if(printApplyWorkflowId>0){

		    //�ж��Ƿ������̴���Ȩ��
			canPrintApply = shareManager.hasWfCreatePermission(user, printApplyWorkflowId);
		
            if(!canPrintApply){
				String begindate="";
				String begintime="";
				String enddate="";
				String endtime="";
				int beagenterid=0;
				RecordSet.executeSql("select distinct workflowid,beagenterid,begindate,begintime,enddate,endtime from workflow_agent where workflowid="+printApplyWorkflowId+" and agenttype>'0' and iscreateagenter=1 and agenterid="+userid);
				while(RecordSet.next()&&!canPrintApply){
					begindate=Util.null2String(RecordSet.getString("begindate"));
					begintime=Util.null2String(RecordSet.getString("begintime"));
					enddate=Util.null2String(RecordSet.getString("enddate"));
					endtime=Util.null2String(RecordSet.getString("endtime"));
					beagenterid=Util.getIntValue(RecordSet.getString("beagenterid"),0);

					if(!begindate.equals("")){
						if((begindate+" "+begintime).compareTo(CurrentDate+" "+CurrentTime)>0)
							continue;
					}
					if(!enddate.equals("")){
					    if((enddate+" "+endtime).compareTo(CurrentDate+" "+CurrentTime)<0)
					        continue;
					}
					
					canPrintApply = shareManager.hasWfCreatePermission(beagenterid, printApplyWorkflowId);
					
					if(canPrintApply){
						isagentOfprintApply="1";
					}
				}
			}
		}

boolean canDoPrintByApply=false;
boolean canDoPrintByDocDetail=false;
boolean hasPrintNode=false;
boolean isPrintNode=false;

String printNodes="";
if(isPrintControl.equals("1")){
	//�ж��Ƿ��Ѿ�������ɹ��Ĵ�ӡ����
	StringBuffer canDoPrintByApplySb=new StringBuffer();
	canDoPrintByApplySb.append(" select 1   ")
		               .append(" from workflow_requestbase a,Bill_DocPrintApply b ")
		               .append(" where a.requestId=b.requestid ")
		               .append("   and a.currentNodeType='3' ")
		               .append("   and b.resourceId=").append(userid)
		               .append("   and b.relatedDocId=").append(docid)
		               .append("   and printNum>hasPrintNum ")
    ;
	RecordSet.executeSql(canDoPrintByApplySb.toString());
	if(RecordSet.next()){
		canDoPrintByApply=true;
	}

	//�ж��Ƿ���Ĭ�ϵĴ�ӡ����
	RecordSet.executeSql("select 1 from DocDetail where id="+docid+" and canPrintedNum>hasPrintedNum");
	if(RecordSet.next()){
		canDoPrintByDocDetail=true;
	}
}

boolean isUseTempletNode=false;//���������̴����ĵ�ʱ,��ǰ�ڵ��Ƿ�Ϊ�׺�ڵ�
boolean isSignatureNodes=false;//���������̴����ĵ�ʱ,��ǰ�ڵ��Ƿ�Ϊǩ�½ڵ�
int useTempletNode=0;
String signatureNodes = "";//�Ƿ���ʾǩ��
String isCompellentMark = "0";//�Ƿ������ʾ�ۼ�
String isCancelCheck = "0";//�Ƿ�ȡ������
String isHideTheTraces="0";//�༭����ʱĬ�����غۼ�

if(fromFlowDoc.equals("1")){
	nodeid=WFLinkInfo.getCurrentNodeid(requestid,Util.getIntValue(userid,0),Util.getIntValue(logintype,1));               //�ڵ�id
	RecordSet.executeSql("select workflowId,currentNodeId, lastnodeid, currentnodetype from workflow_requestbase where requestid="+requestid);
	if(RecordSet.next()){
		workflowid=RecordSet.getInt("workflowid");
		//nodeid=RecordSet.getInt("currentnodeid");
        currentnodeid=RecordSet.getInt("currentnodeid");
		lastnodeid = RecordSet.getInt("lastnodeid");
		nodeType = Util.null2String(RecordSet.getString("currentnodetype"));
	}

	RecordSet.executeSql("select ifVersion from workflow_base where id="+workflowid);
	if(RecordSet.next()){
		ifVersion = Util.null2String(RecordSet.getString("ifVersion"));
	}
	RecordSet.executeSql("select nodeName from workflow_nodebase where id="+nodeid);
	if(RecordSet.next()){
		nodeName = Util.null2String(RecordSet.getString("nodeName"));
	}

	RecordSet.executeSql("select * from workflow_createdoc where workflowId="+workflowid);
	if(RecordSet.next()){
		useTempletNode=RecordSet.getInt("useTempletNode");
		printNodes=Util.null2String(RecordSet.getString("printNodes"));
		isCompellentMark = Util.null2String(RecordSet.getString("iscompellentmark"));
		isCancelCheck = Util.null2String(RecordSet.getString("iscancelcheck"));
		signatureNodes = Util.null2String(RecordSet.getString("signatureNodes"));
		isHideTheTraces = Util.null2String(RecordSet.getString("isHideTheTraces"));
	}
	if("".equals(isCompellentMark)){
		isCompellentMark = "0";
	}
	if("".equals(isCancelCheck)){
		isCancelCheck = "0";
	}

	if(nodeid==useTempletNode&&nodeid>0&&nodeid==currentnodeid){
		isUseTempletNode=true;
	}

	if(!printNodes.equals("")){
		hasPrintNode=true;
	}
	if((","+printNodes+",").indexOf(","+nodeid+",")>=0&&nodeid>0&&nodeid==currentnodeid){
		isPrintNode=true;
	}
	if((","+signatureNodes+",").indexOf(","+nodeid+",")>=0&&nodeid>0&&nodeid==currentnodeid){
		isSignatureNodes=true;
	}
}




/***************************Ȩ���ж�**************************************************/
boolean  canReader = false;
boolean  canEdit = false;
boolean  canViewLog = false;
boolean canDel = false;
boolean canShare = false ;
String sharelevel="";
//String logintype = user.getLogintype() ;
//String userid = "" +user.getUID() ;
//String userSeclevel = user.getSeclevel();
//String userType = ""+user.getType();
//String userdepartment = ""+user.getUserDepartment();
//String usersubcomany = ""+user.getUserSubCompany1();
if("2".equals(logintype)){
	userdepartment="0";
	usersubcomany="0";
	userSeclevel="0";
}
String userInfo=logintype+"_"+userid+"_"+userSeclevel+"_"+userType+"_"+userdepartment+"_"+usersubcomany;
ArrayList PdocList =  SpopForDoc.getDocOpratePopedom(""+docid,userInfo);

//0:�鿴 1:�༭ 2:ɾ�� 3:���� 4:��־
if (((String)PdocList.get(0)).equals("true")) canReader = true ;
if (((String)PdocList.get(1)).equals("true")) canEdit = true ;
if (((String)PdocList.get(2)).equals("true")) canDel = true ;
if (((String)PdocList.get(3)).equals("true")) canShare = true ;
if (((String)PdocList.get(4)).equals("true")) canViewLog = true ;    
   
if(!canEdit&&fromFlowDoc.equals("1")){
	if((userid.equals(""+doccreaterid)&&logintype.equals(docCreaterType))||(userid.equals(""+ownerid)&&logintype.equals(ownerType))){
		canEdit=true;
	}
}

//�鵵״̬���ĵ����ܱ��༭
if(canEdit && (docstatus.equals("5"))){
    canEdit = false;
}

boolean blnRealViewLog=false;
if((SecCategoryComInfo.getLogviewtype(seccategory)==1&&user.getLoginid().equalsIgnoreCase("sysadmin"))||(SecCategoryComInfo.getLogviewtype(seccategory)==0)){
	blnRealViewLog=canViewLog;
}


if(!canEdit)  {
    //response.sendRedirect("/notice/noright.jsp") ;
    //return ;
    if(!canReader&&(isrequest.equals("1") || requestid > 0)){
    	canReader=WFUrgerManager.OperHaveDocViewRight(requestid,user.getUID(),Util.getIntValue(logintype,1),""+docid);
	}
	//�Ӽƻ����񴦹���
	String fromworktask = Util.getFileidIn(Util.null2String(request.getParameter("fromworktask")));
	String operatorid = Util.getFileidIn(Util.null2String(request.getParameter("operatorid")));
	if(!canReader&&"1".equals(fromworktask)) {
		canReader=WTRequestUtil.UrgerHaveWorktaskDocViewRight(requestid,Util.getIntValue(userid), docid ,Util.getIntValue(operatorid,0));
	}
	if(canReader){
		response.sendRedirect("/docs/docs/DocDspExt.jsp?fromFlowDoc="+fromFlowDoc+"&id="+docid) ;
		return ;		
	}else{
		response.sendRedirect("/notice/noright.jsp") ;
		return ;
	}
}

temStr="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

temStr+=SystemEnv.getHtmlLabelName(401,languageId)+":"+doccreatedate+" "+doccreatetime+" "+SystemEnv.getHtmlLabelName(623,languageId)+":"+Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),languageId)+SystemEnv.getHtmlLabelName(103,languageId)+":"+doclastmoddate+" "+doclastmodtime+" "+SystemEnv.getHtmlLabelName(623,languageId)+":"+Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),languageId);
if(docstatus.equals("0")){
    docEditType = "1";
}else{
    docEditType = "2";
}

if(checkOutStatus!=null&&(checkOutStatus.equals("1")||checkOutStatus.equals("2"))&&!(checkOutUserId==user.getUID()&&checkOutUserType!=	null&&checkOutUserType.equals(user.getLogintype()))){

	String checkOutMessage=SystemEnv.getHtmlLabelName(19695,languageId)+SystemEnv.getHtmlLabelName(19690,languageId)+"��"+checkOutUserName;

    checkOutMessage=URLEncoder.encode(checkOutMessage);

    response.sendRedirect("DocDspExt.jsp?id="+docid+"&checkOutMessage="+checkOutMessage+"&fromFlowDoc="+fromFlowDoc);
    return ;
}else if(!"1".equals(checkOutStatus)&&!"2".equals(checkOutStatus)){
        Calendar today = Calendar.getInstance();
        String formatDate = Util.add0(today.get(Calendar.YEAR), 4) + "-"
                + Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-"
                + Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);
        String formatTime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":"
                + Util.add0(today.get(Calendar.MINUTE), 2) + ":" + Util.add0(today.get(Calendar.SECOND), 2);

        checkOutDate=formatDate;
        checkOutTime=formatTime;
        checkOutUserName=user.getUsername();
        checkOutStatus="1";

         RecordSet.executeSql("update  DocDetail set checkOutStatus='1',checkOutUserId="+user.getUID()+",checkOutUserType='"+user.getLogintype()+"',checkOutDate='"+formatDate+"',checkOutTime='"+formatTime+"' where id="+docid);

		 DocDetailLog.resetParameter();
		 DocDetailLog.setDocId(docid);
		 DocDetailLog.setDocSubject(docsubject);
		 DocDetailLog.setOperateType("18");
		 DocDetailLog.setOperateUserid(user.getUID());
		 DocDetailLog.setUsertype(user.getLogintype());
		 DocDetailLog.setClientAddress(request.getRemoteAddr());
		 DocDetailLog.setDocCreater(doccreaterid);
		 DocDetailLog.setCreatertype(docCreaterType);
		 DocDetailLog.setDocLogInfo();  
}

if(fromFlowDoc.equals("1")){
    if(!isFromAccessory){
	    if( !userid.equals(""+doccreaterid) || !logintype.equals(docCreaterType) ){
			rs.executeProc("docReadTag_AddByUser",""+docid+flag+userid+flag+logintype);  // ����
		}
	}
}

String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(58,user.getLanguage())+":"+Util.add0(docid,12)+"   "+temStr;;
String needfav ="1";
String needhelp ="";

boolean canPrint=true;
//���ô�ӡ���ƣ����ĵ��Ѿ�û�пɴ�ӡ����ʱ���ɴ�ӡ
if(isPrintControl.equals("1")&&(!canDoPrintByDocDetail)){
	canPrint = false;
}

//���ô�ӡ���ƻ����ô�ӡ���ƣ����̴����ĵ�ʱ��ǰ�ڵ�Ϊ��ӡ�ڵ�  ��ɴ�ӡ
if(fromFlowDoc.equals("1")&&isPrintNode){
	canPrint = true;
}

//���ô�ӡ���ƣ����̴����ĵ�ʱ��ǰ�ڵ㲿ί��ӡ�ڵ�  �򲻿ɴ�ӡ
if(isPrintControl.equals("1")&&fromFlowDoc.equals("1")&&hasPrintNode&&!isPrintNode){
	canPrint = false;
}

if(canDoPrintByApply){
    canPrint = true;
}
%>

<html>

<head>
<link href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script LANGUAGE="JavaScript" SRC="/js/checkinput.js"></script>
<script language="javascript" src="/js/weaver.js"></script>
<script src="/js/prototype.js" type="text/javascript"></script>


<%if(user.getLanguage()==7) {%>
	<script type='text/javascript' src='/js/weaver-lang-cn-gbk.js'></script>
<%} else if(user.getLanguage()==8) {%>
	<script type='text/javascript' src='/js/weaver-lang-en-gbk.js'></script>
<%} else if(user.getLanguage()==9) {%>
	<script type='text/javascript' src='/js/weaver-lang-tw-gbk.js'></script>
<%}%>

<script language="javascript">
	var menubar=[];
	var menubarForwf=[];
	var menuOtherBar=[];
	<%
	List menuBars = new ArrayList();
	List menuBarsForWf = new ArrayList();
	List menuOtherBar = new ArrayList();
	Map menuBarMap = new HashMap();
	Map[] menuBarToolsMap = new HashMap[]{};
	%>
	function webOfficeMenuClick(vIndex){
		if (vIndex==1)       <%if (!ifVersion.equals("1")) {%> onSave(); <%} else {%>onSaveNewVersion();<%}%>  //���浽������
		else if (vIndex==2)  <%if (!ifVersion.equals("1")) {%> onSave(); <%} else {%>onSaveNewVersion();<%}%> //���浽������
		else if (vIndex==3)  onDraft(); //����Ϊ�������ݸ�
		else if (vIndex==4)  onPreview(); //Ԥ��
		else if (vIndex==5)  onSaveNewVersion();  //��Ϊ�°汾
		else if (vIndex==6)  openVersion(<%=versionId%>) ;   //�򿪰汾
		else if (vIndex==7)  ShowRevision();   //��ʾ/���غۼ�
		else if (vIndex==8)  WebOpenLocal()     //�򿪱����ļ�
		else if (vIndex==9)  WebSaveLocal2();  //��Ϊ�����ļ�
		else if (vIndex==10) WebOpenSignature();  //ǩ��ӡ��
		else if (vIndex==11) shiftCanCopy();  //��������
		else if (vIndex==12) shiftCanCopy;  //�ָ�����
		else if (vIndex==13)  acceptAll();  //�����ĵ�
		else if (vIndex==15) onExpandOrCollapse();  //��ʾ/���� 
		else if (vIndex==16) location.reload();   //ˢ��  
		else if (vIndex==17) window.history.go(-1);  //����
		else if (vIndex==47) onPrintDoc();//��ӡ
		else if (vIndex==48) onPrintApply();//��ӡ����	
		else if (vIndex==49) onPrintLog();//��ӡ��־	
	}
</script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">   
	 webOfficeMenuClick(vIndex);
</script>

<%if(isIWebOffice2006 == true){%>
<script language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)>
//��Ӧ�������¼�
if (vIndex==-1){//�ؼ�Ĭ�ϵĹ���������INDEXֵΪ-1����ʱ������Ҫ��vCaption��ֵ�жϵ����ĸ���ť
  if(vCaption=="������ע"){//���µ���ִ�г�ʼ���ķ���
    onLoadAgain();
  }
}
</script>
<%}%>

<script language="javascript">

function StatusMsg(mString){
  StatusBar.innerText=mString;
}



function WebSaveLocal2(){

        try{
			var tempFileName=document.getElementById("WebOffice").FileName;

			tempFileName=tempFileName.replace(/\\/g,'��');
			tempFileName=tempFileName.replace(/\//g,'��');
			tempFileName=tempFileName.replace(/:/g,'��');
			tempFileName=tempFileName.replace(/\*/g,'��');
			tempFileName=tempFileName.replace(/\?/g,'��');
			tempFileName=tempFileName.replace(/\"/g,'��');
			tempFileName=tempFileName.replace(/</g,'��');
			tempFileName=tempFileName.replace(/>/g,'��');
			tempFileName=tempFileName.replace(/\|/g,'��');

			var tempfiletype = tempFileName.substring(tempFileName.lastIndexOf("."),tempFileName.length);
			if(tempfiletype!=null&&(tempfiletype==".doc"||tempfiletype==".xls"||tempfiletype==".ppt"||tempfiletype==".wps"||tempfiletype==".docx"||tempfiletype==".xlsx"||tempfiletype==".pptx"||tempfiletype==".et")){
				tempFileName=tempFileName.substring(0,tempFileName.lastIndexOf("."));
				tempFileName=tempFileName.replace(/\./g,'��');
				tempFileName=tempFileName+tempfiletype;
			} else 

			tempFileName=tempFileName.replace(/\./g,'��');
			document.getElementById("WebOffice").FileName=tempFileName;
		}catch(e){}
  try{
    document.getElementById("WebOffice").WebSaveLocal();
    StatusMsg(document.getElementById("WebOffice").Status);
  }catch(e){}
}

function WebOpenLocal(){
	try {
		var tempFileName=document.getElementById("WebOffice").FileName;

		tempFileName=tempFileName.replace(/\\/g,'��');
		tempFileName=tempFileName.replace(/\//g,'��');
		tempFileName=tempFileName.replace(/:/g,'��');
		tempFileName=tempFileName.replace(/\*/g,'��');
		tempFileName=tempFileName.replace(/\?/g,'��');
		tempFileName=tempFileName.replace(/\"/g,'��');
		tempFileName=tempFileName.replace(/</g,'��');
		tempFileName=tempFileName.replace(/>/g,'��');
		tempFileName=tempFileName.replace(/\|/g,'��');

		tempFileName=tempFileName.replace(/\./g,'��');

		document.getElementById("WebOffice").FileName=tempFileName;
	}
	catch(e) {}
  try{	
    document.getElementById("WebOffice").WebOpenLocal();
    StatusMsg(document.getElementById("WebOffice").Status);
  }catch(e){
  }
}

<%
if(isHideTheTraces.equals("1")){
	isDefaultNoShowRevision=true;
}
%>

var viewStatus=false;
<%if(isDefaultNoShowRevision){%>
viewStatus=true;
<%}%>

<%if("1".equals(isCompellentMark) && fromFlowDoc.equals("1")){%>//�Ƿ���뱣���ۼ�

	function ShowRevision(mObject){
		//var mFlag=mObject.value;
		//alert(document.getElementById("WebOffice").editType);
		if (viewStatus){
			//mObject.value="���غۼ�";
			//document.getElementById("WebOffice").WebShow(true);
			<%if("1".equals(isCancelCheck)){%>
			document.getElementById("WebOffice").editType="-1,0,1,1,0,0,1<%=canPostil%>";
			<%}else{%>
			document.getElementById("WebOffice").editType="-1,0,1,1,0,1,1<%=canPostil%>";
			<%}%>
			viewStatus=false;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19712,languageId)%>...");
		}else{
			//mObject.value="��ʾ�ۼ�";
			//document.getElementById("WebOffice").WebShow(false);
			<%if("1".equals(isCancelCheck)){%>
			document.getElementById("WebOffice").editType="-1,0,0,1,0,0,1<%=canPostil%>";
			<%}else{%>
			document.getElementById("WebOffice").editType="-1,0,0,1,0,1,1<%=canPostil%>";
			<%}%>
			viewStatus=true;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19713,languageId)%>...");
		}
	}
<%}else{%>
	function ShowRevision(mObject){

		if (viewStatus){
			weaver.WebOffice.WebShow(true);
			viewStatus=false;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19712,languageId)%>...");
		}else{
			weaver.WebOffice.WebShow(false);
			viewStatus=true;
			StatusMsg("<%=SystemEnv.getHtmlLabelName(19713,languageId)%>...");
		}
	}
<%}%>


function WebToolsVisible(ToolName,Visible){
  try{
    document.getElementById("WebOffice").WebToolsVisible(ToolName,Visible);
    StatusMsg(document.getElementById("WebOffice").Status);
  }catch(e){}
}

	function WebToolsVisibleISignatureFalse(){
	  try{
	    document.getElementById("WebOffice").WebToolsVisible("iSignature","false");
	  }catch(e){}
	  try{

	  }catch(e){}
	}

function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    document.getElementById("WebOffice").WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(document.getElementById("WebOffice").Status);
  }catch(e){}
}

function showMarkFunc(){
   ShowRevision();   
   //Ext.getCmp('hide_id').hide()
   document.getElementById('hide_id').style.display = "none";
   //Ext.getCmp('dispaly_id').show()
   document.getElementById('dispaly_id').style.display = "block";
}

function hideMarkFunc(){
   ShowRevision();   
   //Ext.getCmp('dispaly_id').hide()	
   document.getElementById('dispaly_id').style.display = "none";
   //Ext.getCmp('hide_id').show()
   document.getElementById('hide_id').style.display = "block";
}

function changeFileType(xFileType){
	if(xFileType==".docx"||xFileType==".dot"){
		xFileType=".doc";
	}else if(xFileType==".xlsx"||xFileType==".xlt"||xFileType==".xlw"||xFileType==".xla"){
		xFileType=".xls";
	}else if(xFileType==".pptx"){
		xFileType=".ppt";
	}
	return xFileType;
}

/*
Index:
wdPropertyAppName		:9
wdPropertyAuthor		:3
wdPropertyBytes			:22
wdPropertyCategory		:18
wdPropertyCharacters		:16
wdPropertyCharsWSpaces		:30
wdPropertyComments		:5
wdPropertyCompany		:21
wdPropertyFormat		:19
wdPropertyHiddenSlides		:27
wdPropertyHyperlinkBase		:29
wdPropertyKeywords		:4
wdPropertyLastAuthor		:7
wdPropertyLines			:23
wdPropertyManager		:20
wdPropertyMMClips 		:28
wdPropertyNotes			:26
wdPropertyPages			:14
wdPropertyParas			:24
wdPropertyRevision		:8
wdPropertySecurity		:17
wdPropertySlides		:25
wdPropertySubject		:2
wdPropertyTemplate		:6
wdPropertyTimeCreated		:11
wdPropertyTimeLastPrinted	:10
wdPropertyTimeLastSaved		:12
wdPropertyTitle			:1
wdPropertyVBATotalEdit		:13
wdPropertyWords			:15
*/
//��ȡ�������ĵ�ժҪ��Ϣ
function WebShowDocumentProperties(Index){
    var propertiesValue="";
    try{
	    var properties = document.getElementById("WebOffice").WebObject.BuiltInDocumentProperties;
	    propertiesValue=properties.Item(Index).Value;
    }catch(e){
    }
    return propertiesValue;
}

function getFileSize(){
	var fileSize=new String((1.0*WebShowDocumentProperties(22))/(1024*1024));

    var len = fileSize.length;

	var afterDotCount=0;
	var hasDot=false;
    var newIntValue="";
	var newDecValue="";

    for(i = 0; i < len; i++){
		if(fileSize.charAt(i) == "."){ 
			hasDot=true;
		}else{
			if(hasDot==false){
				newIntValue+=fileSize.charAt(i);
			}else{
				afterDotCount++;
				if(afterDotCount<=2){
					newDecValue+=fileSize.charAt(i);
				}
			}
		}		
    }

    var newValue="";
	if(newDecValue==""){
		newValue=newIntValue;
	}else{
		newValue=newIntValue+"."+newDecValue;
	}

	return newValue;
}

var hasAcceptAllRevisions="false";

function SaveDocument(){
    var fileSize=getFileSize();

	if(parseFloat(fileSize)>parseFloat(<%=maxOfficeDocFileSize%>)){
		alert("<%=SystemEnv.getHtmlLabelName(24028,languageId)%>"+fileSize+"M��<%=SystemEnv.getHtmlLabelName(24029,languageId)%><%=maxOfficeDocFileSize%>M��");
		return false;
	}
  //document.getElementById("WebOffice").FileName=weaver.docsubject.value+"<%=filetype%>";
  //document.getElementById("WebOffice").FileName=document.getElementById("docsubject").value;
  document.getElementById("WebOffice").WebSetMsgByName("SAVETYPE","EDIT");

  //������ʾ��Ϣ  ��ʼ
  showPrompt("<%=SystemEnv.getHtmlLabelName(18886,languageId)%>");
  //������ʾ��Ϣ  ����
  document.getElementById("WebOffice").WebSetMsgByName("HASUSEDTEMPLET", document.getElementById("hasUsedTemplet").value);


  document.getElementById("WebOffice").FileType=changeFileType(document.getElementById("WebOffice").FileType);

<%
	if(!isFromAccessory){
%>
    var tempFileName=document.getElementById("docsubject").value;
<%
	}else{
	    String imageFileNameNoPostfix=fileName;
		List postfixList=new ArrayList();
		postfixList.add(".doc");
		postfixList.add(".dot");
		postfixList.add(".docx");
		postfixList.add(".xls");	
		postfixList.add(".xlt");
		postfixList.add(".xlw");
		postfixList.add(".xla");
		postfixList.add(".xlsx");
		postfixList.add(".ppt");
		postfixList.add(".pptx");
		postfixList.add(".wps");
		postfixList.add(".pgf");
		postfixList.add(".et");			
		
		String tempPostfix=null;
		for(int i=0;i<postfixList.size();i++){
			tempPostfix=(String)postfixList.get(i)==null?"":(String)postfixList.get(i);			
		    if(imageFileNameNoPostfix.endsWith(tempPostfix)){
			    imageFileNameNoPostfix=imageFileNameNoPostfix.substring(0,imageFileNameNoPostfix.indexOf(tempPostfix));
	 	    }
		}
%>
    var tempFileName="<%=imageFileNameNoPostfix%>";
<% } %>
	tempFileName=tempFileName.replace(/\\/g,'��');
	tempFileName=tempFileName.replace(/\//g,'��');
	tempFileName=tempFileName.replace(/:/g,'��');
	tempFileName=tempFileName.replace(/\*/g,'��');
	tempFileName=tempFileName.replace(/\?/g,'��');
	tempFileName=tempFileName.replace(/\"/g,'��');
	tempFileName=tempFileName.replace(/</g,'��');
	tempFileName=tempFileName.replace(/>/g,'��');
	tempFileName=tempFileName.replace(/\|/g,'��');
	tempFileName=tempFileName.replace(/\./g,'��');

	tempFileName = tempFileName+document.getElementById("WebOffice").FileType;

    document.getElementById("WebOffice").FileName=tempFileName;
<%if(isIWebOffice2003&&filetype.equals(".doc")){%>
	try{
		var fileSize=0;
		document.getElementById("WebOffice").WebObject.SaveAs();
		fileSize=document.getElementById("WebOffice").WebObject.BuiltinDocumentProperties(22);
		document.getElementById("WebOffice").WebSetMsgByName("NEWFS",fileSize);
	}catch(e){
	}
<%}%>
  if (!document.getElementById("WebOffice").WebSave(<%=isNoComment%>)){
     StatusMsg(document.getElementById("WebOffice").Status);
     alert("<%=SystemEnv.getHtmlLabelName(19007,languageId)%>");
     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����

     return false;
  }else{
     StatusMsg(document.getElementById("WebOffice").Status);
     //alert(document.getElementById("WebOffice").WebGetMsgByName("CREATEID"));
     //weaver.docId.value=document.getElementById("WebOffice").WebGetMsgByName("CREATEID");
     //weaver.docType.value=document.getElementById("WebOffice").WebGetMsgByName("DOCTYPE");
     //alert(weaver.docId.value);
     //alert(weaver.docType.value);

     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����
     return true;
  }
}

function SaveDocumentNewV(){

    var fileSize=getFileSize();

	if(parseFloat(fileSize)>parseFloat(<%=maxOfficeDocFileSize%>)){
		alert("<%=SystemEnv.getHtmlLabelName(24028,languageId)%>"+fileSize+"M��<%=SystemEnv.getHtmlLabelName(24029,languageId)%><%=maxOfficeDocFileSize%>M��");
		return false;
	}

  //document.getElementById("WebOffice").FileName=weaver.docsubject.value+"<%=filetype%>";
  //document.getElementById("WebOffice").FileName=document.getElementById("docsubject").value;
  document.getElementById("WebOffice").WebSetMsgByName("SAVETYPE","NEWVERSION");
  document.getElementById("WebOffice").WebSetMsgByName("HASUSEDTEMPLET", document.getElementById("hasUsedTemplet").value);
<%
if (!ifVersion.equals("1")) {
%>
  var vDetail = prompt("<%=SystemEnv.getHtmlLabelName(19721,languageId)%>","");
  if(vDetail==null){
      return false;
  }
<%
}else{
%>
	var vDetail="<%=user.getUsername()%>"+"<%=TimeUtil.getCurrentDateString()%>"+" "+"<%=TimeUtil.getOnlyCurrentTimeString()%>"+"<%=SystemEnv.getHtmlLabelName(18805,languageId)%>��"+"<%=nodeName%>"+"��<%=SystemEnv.getHtmlLabelName(15586,languageId)%>"+"<%=SystemEnv.getHtmlLabelName(21706,languageId)%>";
<%
}
%>
  document.getElementById("WebOffice").WebSetMsgByName("VERSIONDETAIL", vDetail);

  //������ʾ��Ϣ  ��ʼ
  showPrompt("<%=SystemEnv.getHtmlLabelName(18886,languageId)%>");
  //������ʾ��Ϣ  ����

    document.getElementById("WebOffice").FileType=changeFileType(document.getElementById("WebOffice").FileType);

<%
	if(!isFromAccessory){
%>
    var tempFileName=document.getElementById("docsubject").value;
<%
	}else{
	    String imageFileNameNoPostfix=fileName;
		List postfixList=new ArrayList();
		postfixList.add(".doc");
		postfixList.add(".dot");
		postfixList.add(".docx");
		postfixList.add(".xls");	
		postfixList.add(".xlt");
		postfixList.add(".xlw");
		postfixList.add(".xla");
		postfixList.add(".xlsx");
		postfixList.add(".ppt");
		postfixList.add(".pptx");
		postfixList.add(".wps");
		postfixList.add(".pgf");
		postfixList.add(".et");			
		
		String tempPostfix=null;
		for(int i=0;i<postfixList.size();i++){
			tempPostfix=(String)postfixList.get(i)==null?"":(String)postfixList.get(i);			
		    if(imageFileNameNoPostfix.endsWith(tempPostfix)){
			    imageFileNameNoPostfix=imageFileNameNoPostfix.substring(0,imageFileNameNoPostfix.indexOf(tempPostfix));
	 	    }
		}
%>
    var tempFileName="<%=imageFileNameNoPostfix%>";
<%
	}
%>


	tempFileName=tempFileName.replace(/\\/g,'��');
	tempFileName=tempFileName.replace(/\//g,'��');
	tempFileName=tempFileName.replace(/:/g,'��');
	tempFileName=tempFileName.replace(/\*/g,'��');
	tempFileName=tempFileName.replace(/\?/g,'��');
	tempFileName=tempFileName.replace(/\"/g,'��');
	tempFileName=tempFileName.replace(/</g,'��');
	tempFileName=tempFileName.replace(/>/g,'��');
	tempFileName=tempFileName.replace(/\|/g,'��');
	tempFileName=tempFileName.replace(/\./g,'��');

	tempFileName = tempFileName+document.getElementById("WebOffice").FileType;

    document.getElementById("WebOffice").FileName=tempFileName;

<%if(isIWebOffice2003&&filetype.equals(".doc")){%>
	try{
		var fileSize=0;
		document.getElementById("WebOffice").WebObject.SaveAs();
		fileSize=document.getElementById("WebOffice").WebObject.BuiltinDocumentProperties(22);
		document.getElementById("WebOffice").WebSetMsgByName("NEWFS",fileSize);
	}catch(e){
	}
<%}%>

  if (!document.getElementById("WebOffice").WebSave(<%=isNoComment%>)){
     StatusMsg(document.getElementById("WebOffice").Status);
     alert("<%=SystemEnv.getHtmlLabelName(19007,languageId)%>");

     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����
     return false;
  }else{
     StatusMsg(document.getElementById("WebOffice").Status);
     //alert(document.getElementById("WebOffice").WebGetMsgByName("CREATEID"));
     //weaver.docId.value=document.getElementById("WebOffice").WebGetMsgByName("CREATEID");
     //weaver.docType.value=document.getElementById("WebOffice").WebGetMsgByName("DOCTYPE");
     //alert(weaver.docId.value);
     //alert(weaver.docType.value);

     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����

     return true;
  }
}

function onChanageShowMode(){
    if(DocInfoWindow.style.display == ""){
        DocInfoWindow.style.display = "none";

    }
    else{
        DocInfoWindow.style.display = "";
    }

}
function  initmenu(){
    document.getElementById("WebOffice").ShowMenu="1"; 
    <%
    if (isPersonalDoc){%>
        document.getElementById("WebOffice").AppendMenu("1","<%=SystemEnv.getHtmlLabelName(19718,languageId)%>(&S)");  //���浽������  onSave(this)   
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(19718,languageId)%>',iconCls:'btn_save',handler:function(){ webOfficeMenuClick(1)}}); 
		<%
		menuBarMap = new HashMap();
		menuBarMap.put("id", "btn_save");
		menuBarMap.put("text",SystemEnv.getHtmlLabelName(19718,user.getLanguage()));
		menuBarMap.put("iconCls","btn_save");
		menuBarMap.put("handler","webOfficeMenuClick(1);");
		menuBars.add(menuBarMap);
		%>
  <%} else {%>
        document.getElementById("WebOffice").AppendMenu("2","<%=SystemEnv.getHtmlLabelName(19718,languageId)%>(&S)");  //���浽������  onSave(this)
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(19718,languageId)%>',iconCls:'btn_save',handler:function(){ webOfficeMenuClick(2)}}); 
<%
		menuBarMap = new HashMap();
		menuBarMap.put("id", "btn_save");
		menuBarMap.put("text",SystemEnv.getHtmlLabelName(19718,user.getLanguage()));
		menuBarMap.put("iconCls","btn_save");
		menuBarMap.put("handler","webOfficeMenuClick(2);");
		menuBars.add(menuBarMap);
        if(!docstatus.equals("3") && !docstatus.equals("4")) {
%>
        document.getElementById("WebOffice").AppendMenu("3","<%=SystemEnv.getHtmlLabelName(19719,languageId)%>");  //����Ϊ�������ݸ�  onDraft(this)
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(19719,languageId)%>',iconCls:'btn_draft',handler:function(){ webOfficeMenuClick(3)}}); 
<%
			menuBarMap = new HashMap();
			menuBarMap.put("id", "btn_draft");
			menuBarMap.put("text",SystemEnv.getHtmlLabelName(19719,user.getLanguage()));
			menuBarMap.put("iconCls","btn_draft");
			menuBarMap.put("handler","webOfficeMenuClick(3);");
			menuBars.add(menuBarMap);
%>
        document.getElementById("WebOffice").AppendMenu("4","<%=SystemEnv.getHtmlLabelName(221,languageId)%>");  //Ԥ��  onPreview(this)
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(221,languageId)%>',iconCls:'btn_preview',handler:function(){ webOfficeMenuClick(4)}}); 
<%
			menuBarMap = new HashMap();
			menuBarMap.put("id", "btn_preview");
			menuBarMap.put("text",SystemEnv.getHtmlLabelName(221,user.getLanguage()));
			menuBarMap.put("iconCls","btn_preview");
			menuBarMap.put("handler","webOfficeMenuClick(4);");
			menuBars.add(menuBarMap);
		}
%>
        document.getElementById("WebOffice").AppendMenu("5","<%=SystemEnv.getHtmlLabelName(16386,languageId)%>");  //��Ϊ�°汾  onSaveNewVersion(this)
        //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16386,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(5)}}); 
        <%
    	menuBarMap = new HashMap();
    	menuBarMap.put("id", "btn_add");
    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16386,user.getLanguage()));
    	menuBarMap.put("iconCls","btn_add");
    	menuBarMap.put("handler","webOfficeMenuClick(5);");
    	menuOtherBar.add(menuBarMap);
        %>
		<%if(fromFlowDoc.equals("1") && isSignatureNodes){/*�Ƿ���ʾ����*/%>
		  //menubarForwf.push({text:'<%=SystemEnv.getHtmlLabelName(21650,languageId)%>',iconCls:'btn_signature',handler:function(){CreateSignature(0)}});
		  <%
	    	menuBarMap = new HashMap();
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(21650,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_signature");
	    	menuBarMap.put("handler","CreateSignature(0);");
	    	menuBarsForWf.add(menuBarMap);
		  %>
		  //menubarForwf.push({text:'<%=SystemEnv.getHtmlLabelName(21656,languageId)%>',iconCls:'btn_signature1',handler:function(){saveIsignatureFun()}});
		  <%
	    	menuBarMap = new HashMap();
	    	menuBarMap.put("id", "wfbtn_signature1");
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(21656,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_signature1");
	    	menuBarMap.put("handler","saveIsignatureFun();");
	    	menuBarsForWf.add(menuBarMap);
		  %>
        <%}else{%>
          //menubarForwf.push({text:'<%=SystemEnv.getHtmlLabelName(86,languageId)%>',iconCls:'btn_save',handler:function(){<%if (!ifVersion.equals("1")) {%> onSave()<%} else {%>onSaveNewVersion()<%}%>}});
          <%
	    	menuBarMap = new HashMap();
	    	menuBarMap.put("id", "wfbtn_save");
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(86,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_save");
	    	menuBarMap.put("handler",""+((!ifVersion.equals("1"))?"onSave()":"onSaveNewVersion()")+";");
	    	menuBarsForWf.add(menuBarMap);
          %>
        <%}%>  
        <%
        //if(((user.getUID()==ownerid)||(user.getUID()==doccreaterid))&&logintype.equals(usertype)&&canEdit){
        if(((user.getUID()==ownerid||user.getUID()==doccreaterid)&&logintype.equals(usertype)&&canEdit)||hasRightOfViewHisVersion){
		%>
            document.getElementById("WebOffice").AppendMenu("6","<%=SystemEnv.getHtmlLabelName(16384,languageId)%>");  //�򿪰汾 openVersion("+versionId+")      
            //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16384,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(6)}}); 
            <%
	     	menuBarMap = new HashMap();
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16384,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_add");
	    	menuBarMap.put("handler","webOfficeMenuClick(6);");
	    	menuOtherBar.add(menuBarMap);
            %>
         <%}%>
<%
				  if(!isSignatureNodes){
					  if(".doc".equals(filetype) || ".wps".equals(filetype)){
%>
            document.getElementById("WebOffice").AppendMenu("7","<%=SystemEnv.getHtmlLabelName(16385,languageId)%>");  //��ʾ/���غۼ� ShowRevision()   
            //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16385,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(7)}}); 
            <%
	     	menuBarMap = new HashMap();
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16385,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_add");
	    	menuBarMap.put("handler","webOfficeMenuClick(7);");
	    	menuOtherBar.add(menuBarMap);
            %>
			//menubarForwf.push({id:'hide_id',text:'<%=SystemEnv.getHtmlLabelName(19713,languageId)%>',iconCls:'btn_ShowOrHidden',handler:function(){showMarkFunc()}});
			<%
	    	menuBarMap = new HashMap();
	    	menuBarMap.put("id","hide_id");
	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(19713,user.getLanguage()));
	    	menuBarMap.put("iconCls","btn_ShowOrHidden");
	    	menuBarMap.put("handler","showMarkFunc();");
	    	menuBarsForWf.add(menuBarMap);
			%>
			//menubarForwf.push({id:'dispaly_id',text:'<%=SystemEnv.getHtmlLabelName(19712,languageId)%>',iconCls:'btn_displayh',handler:function(){hideMarkFunc()}});
<%
			menuBarMap = new HashMap();
			menuBarMap.put("id","dispaly_id");
			menuBarMap.put("text",SystemEnv.getHtmlLabelName(19712,user.getLanguage()));
			menuBarMap.put("iconCls","btn_displayh");
			menuBarMap.put("handler","hideMarkFunc();");
			menuBarsForWf.add(menuBarMap);
					  }
				  }
%>

			<%if(!fromFlowDoc.equals("1")){/*�������̵��ĵ�һ�ɲ��ɴ򿪱����ļ�*/%>
				document.getElementById("WebOffice").AppendMenu("8","<%=SystemEnv.getHtmlLabelName(16381,languageId)%>");  //�򿪱����ļ� WebOpenLocal() 
				//menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16381,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(8)}}); 
				<%
		     	menuBarMap = new HashMap();
		    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16381,user.getLanguage()));
		    	menuBarMap.put("iconCls","btn_add");
		    	menuBarMap.put("handler","webOfficeMenuClick(8);");
		    	menuOtherBar.add(menuBarMap);
				%>
			<%}%>    
            document.getElementById("WebOffice").AppendMenu("9","<%=SystemEnv.getHtmlLabelName(16382,languageId)%>");  //��Ϊ�����ļ� WebSaveLocal() 
            //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16382,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(9)}}); 
            <%
         	menuBarMap = new HashMap();
        	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16382,user.getLanguage()));
        	menuBarMap.put("iconCls","btn_add");
        	menuBarMap.put("handler","webOfficeMenuClick(9);");
        	menuOtherBar.add(menuBarMap);
            %>
            document.getElementById("WebOffice").AppendMenu("10","<%=SystemEnv.getHtmlLabelName(16383,languageId)%>");  //ǩ��ӡ�� WebOpenSignature() 
            //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(16383,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(10)}}); 
            <%
         	menuBarMap = new HashMap();
        	menuBarMap.put("text",SystemEnv.getHtmlLabelName(16383,user.getLanguage()));
        	menuBarMap.put("iconCls","btn_add");
        	menuBarMap.put("handler","webOfficeMenuClick(10);");
        	menuOtherBar.add(menuBarMap);
            %>
        <%if("1".equals(canCopy)){%>
            document.getElementById("WebOffice").AppendMenu("11","<%=SystemEnv.getHtmlLabelName(19722,languageId)%>");  //�������� shiftCanCopy(this) 
            //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19722,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(11)}}); 
            <%
         	menuBarMap = new HashMap();
        	menuBarMap.put("text",SystemEnv.getHtmlLabelName(19722,user.getLanguage()));
        	menuBarMap.put("iconCls","btn_add");
        	menuBarMap.put("handler","webOfficeMenuClick(11);");
        	menuOtherBar.add(menuBarMap);
            %>
        <%}else{%>
             document.getElementById("WebOffice").AppendMenu("12","<%=SystemEnv.getHtmlLabelName(19723,languageId)%>");  //�ָ����� shiftCanCopy(this) 
             //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19723,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(12)}}); 
             <%
          	menuBarMap = new HashMap();
         	menuBarMap.put("text",SystemEnv.getHtmlLabelName(19723,user.getLanguage()));
         	menuBarMap.put("iconCls","btn_add");
         	menuBarMap.put("handler","webOfficeMenuClick(12);");
         	menuOtherBar.add(menuBarMap);
             %>
        <%}%>
		<%if(!fromFlowDoc.equals("1") || "0".equals(isCompellentMark)){/*�������̵��ĵ����Һ�̨���ñ��뱣��ۼ����򲻿ɽ����ĵ�*/%>
          document.getElementById("WebOffice").AppendMenu("13","<%=SystemEnv.getHtmlLabelName(19724,languageId)%>");  //�����ĵ� acceptAll()
		  //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(19724,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(13)}}); 
		  <%
       	menuBarMap = new HashMap();
      	menuBarMap.put("text",SystemEnv.getHtmlLabelName(19724,user.getLanguage()));
      	menuBarMap.put("iconCls","btn_add");
      	menuBarMap.put("handler","webOfficeMenuClick(13);");
      	menuOtherBar.add(menuBarMap);
		  %>
		<%}%>
<%
		  if(canPrintApply){
%>
              document.getElementById("WebOffice").AppendMenu("48","<%=SystemEnv.getHtmlLabelName(21530,languageId)%>");  //��ӡ����    onPrintApply
              //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(21530,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(48)}}); 
<%
			menuBarMap = new HashMap();
			menuBarMap.put("text",SystemEnv.getHtmlLabelName(21530,user.getLanguage()));
			menuBarMap.put("iconCls","btn_add");
			menuBarMap.put("handler","webOfficeMenuClick(48);");
			menuOtherBar.add(menuBarMap);
		  }
		  if(canPrint){
%>
              document.getElementById("WebOffice").AppendMenu("47","<%=SystemEnv.getHtmlLabelName(257,languageId)%>");  //��ӡ    onPrintDoc
              //menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(257,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(47)}}); 
              <%
  	    	menuBarMap = new HashMap();
  	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(257,user.getLanguage()));
  	    	menuBarMap.put("iconCls","btn_add");
  	    	menuBarMap.put("handler","webOfficeMenuClick(47);");
  	    	menuOtherBar.add(menuBarMap);
              %>
			  //menubarForwf.push({text:'<%=SystemEnv.getHtmlLabelName(257,languageId)%>',iconCls:'btn_print',handler:function(){webOfficeMenuClick(47)}});
                <%
    	    	menuBarMap = new HashMap();
    	    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(257,user.getLanguage()));
    	    	menuBarMap.put("iconCls","btn_print");
    	    	menuBarMap.put("handler","webOfficeMenuClick(47);");
    	    	menuBarsForWf.add(menuBarMap);
		  }
		  if(isPrintControl.equals("1")){
%>
                	document.getElementById("WebOffice").AppendMenu("49","<%=SystemEnv.getHtmlLabelName(21533,languageId)%>");  //��ӡ    onPrintDoc
                	//menuOtherBar.push({text:'<%=SystemEnv.getHtmlLabelName(21533,languageId)%>',iconCls:'btn_add',handler:function(){ webOfficeMenuClick(49)}}); 
<%
				menuBarMap = new HashMap();
				menuBarMap.put("text",SystemEnv.getHtmlLabelName(21533,user.getLanguage()));
				menuBarMap.put("iconCls","btn_add");
				menuBarMap.put("handler","webOfficeMenuClick(49);");
				menuOtherBar.add(menuBarMap);
		  }
		  if(fromFlowDoc.equals("1")){
			  RecordSet.executeProc("DocImageFile_SelectByDocid", "" + docid);
			  if(RecordSet.next()){
%>
                  //menubarForwf.push({id:'flowDocAcc_id',text:'<%=SystemEnv.getHtmlLabelName(58,languageId)%><%=SystemEnv.getHtmlLabelName(156,languageId)%>(0)',iconCls:'btn_acc',handler:function(){doImgAcc()}});
<%
				menuBarMap = new HashMap();
				menuBarMap.put("text",SystemEnv.getHtmlLabelName(58,user.getLanguage())+SystemEnv.getHtmlLabelName(156,user.getLanguage())+"("+accessorycount+")");
				menuBarMap.put("id","flowDocAcc_id");
				menuBarMap.put("iconCls","btn_acc");
				menuBarMap.put("handler","doImgAcc();");
				menuBarsForWf.add(menuBarMap);
			  }
		  }
%>
    <%}%>
        document.getElementById("WebOffice").AppendMenu("14","-");  //---- 
        document.getElementById("WebOffice").AppendMenu("15","<%=SystemEnv.getHtmlLabelName(19652,languageId)%>");   //��ʾ/���� 
        document.getElementById("WebOffice").AppendMenu("16","<%=SystemEnv.getHtmlLabelName(354,languageId)%>");   //ˢ��        
        <%if(!fromFlowDoc.equals("1")){%>
        document.getElementById("WebOffice").AppendMenu("17","<%=SystemEnv.getHtmlLabelName(1290,languageId)%>");   //����  
        <%}%>
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(1290,languageId)%>',iconCls:'btn_back',handler:function(){ webOfficeMenuClick(17)}});
        <%
        if(!fromFlowDoc.equals("1")){
    	menuBarMap = new HashMap();
    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(1290,user.getLanguage()));
    	menuBarMap.put("iconCls","btn_back");
    	menuBarMap.put("handler","webOfficeMenuClick(17);");
    	menuBars.add(menuBarMap);
    	}
        %>
        //menubar.push({text:'<%=SystemEnv.getHtmlLabelName(354,languageId)%>',iconCls:'btn_refresh',handler:function(){ webOfficeMenuClick(16)}});   
        <%
    	menuBarMap = new HashMap();
    	menuBarMap.put("text",SystemEnv.getHtmlLabelName(354,user.getLanguage()));
    	menuBarMap.put("iconCls","btn_refresh");
    	menuBarMap.put("handler","webOfficeMenuClick(16);");
    	menuBars.add(menuBarMap);
        %>
        document.getElementById("WebOffice").AppendMenu("18","-");  //-------
		//menubar.push('-');
		<%
		menuBarMap = new HashMap();
		menuBars.add(menuBarMap);
		%>
		//menubar.push({text:'<%=SystemEnv.getHtmlLabelName(21739,user.getLanguage())%>',iconCls: 'btn_list',menu:menuOtherBar});				
		<%
		menuBarMap = new HashMap();
		menuBarMap.put("text",SystemEnv.getHtmlLabelName(21739,user.getLanguage()));
		menuBarMap.put("iconCls","btn_list");
		menuBarMap.put("id","menuTypeChanger");
		menuBarToolsMap = new HashMap[menuOtherBar.size()];
		for(int tmpindex=0;tmpindex<menuOtherBar.size();tmpindex++) menuBarToolsMap[tmpindex]=(Map)menuOtherBar.get(tmpindex);
		menuBarMap.put("menu",menuBarToolsMap);
		menuBars.add(menuBarMap);
		%>
		//menubar.push('-');
		<%
		menuBarMap = new HashMap();
		menuBars.add(menuBarMap);
		%>
		//menubar.push({text:'<span id=spanProp>"+SystemEnv.getHtmlLabelName(21689,user.getLanguage())+"</span>',iconCls:'btn_ShowOrHidden',handler:function(){ webOfficeMenuClick(15)}}); 
		<%
		menuBarMap = new HashMap();
		menuBarMap.put("text","<span id=spanProp>"+SystemEnv.getHtmlLabelName(21689,user.getLanguage())+"</span>");
		menuBarMap.put("iconCls","btn_ShowOrHidden");
		menuBarMap.put("id","btn_ShowOrHidden");
		menuBarMap.put("handler","webOfficeMenuClick(15);");
		menuBars.add(menuBarMap);
		
		if(("1").equals(fromFlowDoc)) menuBars = menuBarsForWf;
		%>
}


<%
String doctitlename=null;
String webOfficeFileName=null;

if (isFromAccessory){
    doctitlename=fileName;
    webOfficeFileName=fileName;
}else{
    doctitlename=docsubject;
    webOfficeFileName=docsubject+filetype;
}

doctitlename=Util.StringReplace(doctitlename,"\\","\\\\");
doctitlename=Util.StringReplace(doctitlename,"&lt;","<");
doctitlename=Util.StringReplace(doctitlename,"&gt;",">");
doctitlename=Util.StringReplace(doctitlename,"&quot;","\"");
doctitlename=Util.StringReplace(doctitlename,""+'\n',"\n");
doctitlename=Util.StringReplace(doctitlename,""+'\r',"\r");
doctitlename=Util.StringReplace(doctitlename,"\"","\\\"");
doctitlename=Util.StringReplace(doctitlename,"&#8226;","��");

webOfficeFileName=Util.StringReplace(webOfficeFileName,"\\","\\\\");
webOfficeFileName=Util.StringReplace(webOfficeFileName,"&lt;","<");
webOfficeFileName=Util.StringReplace(webOfficeFileName,"&gt;",">");
webOfficeFileName=Util.StringReplace(webOfficeFileName,"&quot;","\"");
webOfficeFileName=Util.StringReplace(webOfficeFileName,""+'\n',"\n");
webOfficeFileName=Util.StringReplace(webOfficeFileName,""+'\r',"\r");
webOfficeFileName=Util.StringReplace(webOfficeFileName,"\"","\\\"");
webOfficeFileName=Util.StringReplace(webOfficeFileName,"&#8226;","��");
%>


function onLoad(){

    //������ʾ��Ϣ  ��ʼ
    showPrompt("<%=SystemEnv.getHtmlLabelName(18974,languageId)%>");
    //������ʾ��Ϣ  ����

  try{
        document.body.scroll = "no";

        document.title="<%=doctitlename%>";
        document.getElementById("WebOffice").FileName="<%=webOfficeFileName%>";

        window.status="<%=SystemEnv.getHtmlLabelName(19725,languageId)%>";

        // ��Ӳ˵�
        initmenu();
      if ("<%=filetype%>"==".ppt"){
        document.getElementById("WebOffice").ProgName="powerpoint.show"; 
      } 
      document.getElementById("WebOffice").WebUrl="<%=mServerUrl%>";
      document.getElementById("WebOffice").RecordID="<%=(versionId==0?"":versionId+"")%>_<%=docid%>";
      document.getElementById("WebOffice").Template="";

      document.getElementById("WebOffice").FileType="<%=filetype%>";
	<%
		String 	EditType_C="1";//C  "1" �Ƿ���ʾ�ۼ�		 "0" ����ʾ�ۼ��� "1" ��ʾ�ۼ�
		if(isDefaultNoShowRevision){
			EditType_C="0";
		}
		String EditType_D="1";//C  "1" �Ƿ���ʾ�ۼ�		 "0" ����ʾ�ۼ��� "1" ��ʾ�ۼ�
		if("0".equals(isCompellentMark)&&isDefaultNoShowRevision){
			EditType_D="0";
		}
	%>
	  <%if(isSignatureNodes&& fromFlowDoc.equals("1")){%>//�Ƿ�ȡ������
      document.getElementById("WebOffice").EditType="-1,0,<%=EditType_C%>,<%=EditType_D%>,0,0,1<%=canPostil%>";
	  document.getElementById("WebOffice").DisableKey("CTRL+SHIFT+E");
	  <%}else if("1".equals(isCancelCheck) && "1".equals(isCompellentMark) && fromFlowDoc.equals("1")){%>//�Ƿ�ȡ������
      document.getElementById("WebOffice").EditType="-1,0,<%=EditType_C%>,<%=EditType_D%>,0,0,1<%=canPostil%>";
	  document.getElementById("WebOffice").DisableKey("CTRL+SHIFT+E");
	  <%}else if("1".equals(isCancelCheck) && "0".equals(isCompellentMark) && fromFlowDoc.equals("1")){%>
	  document.getElementById("WebOffice").EditType="-1,0,<%=EditType_C%>,<%=EditType_D%>,0,0,1<%=canPostil%>";
	  <%}else if("0".equals(isCancelCheck) && "0".equals(isCompellentMark) && fromFlowDoc.equals("1")){%>
	  document.getElementById("WebOffice").EditType="-1,0,<%=EditType_C%>,<%=EditType_D%>,0,1,1<%=canPostil%>";
	  <%}else{%>
	  document.getElementById("WebOffice").EditType="-1,0,<%=EditType_C%>,<%=EditType_D%>,0,1,1<%=canPostil%>";
	  <%}%>
//alert(document.getElementById("WebOffice").EditType);
<%if("1".equals(isCancelCheck)){%>
      try{
		  var mStatus = document.getElementById("WebOffice").Office2007Ribbon; //��õ�ǰOffice2007�ǹ�������״̬�����ȡ�ý��Ϊ-1����ʾû�а�װOffice2007
		  if(mStatus!=-1){
			  document.getElementById("WebOffice").RibbonUIXML = '<customUI xmlns="http://schemas.microsoft.com/office/2006/01/customui">' +
                                             '<ribbon startFromScratch="false">'+ //falseʱ��ʾѡ�
                                             ' <tabs>'+
                                             ' <tab idMso="TabReviewWord" visible="false">' + //�ر����Ĺ�����
                                             ' </tab>'+
                                             ' </tabs>' +
                                             '</ribbon>' +
                                             '</customUI>'; //����Ϊ���õ�XML������
		  }

	  }catch(e){
	  }
<%}%>
<%
        if(isIWebOffice2006 == true){
	        String penColor=DocHandwrittenManager.getPenColor(docid,doceditionid,user.getUsername());
%>
            document.getElementById("WebOffice").PenColor="<%=penColor%>";				//PenColor:Ĭ����ע��ɫ
<%
        }
%>

	  <%if(isIWebOffice2006 == true){%>
	      <%if((!isIWebOffice2009||"1".equals(isHandWriteForIWebOffice2009))&&!isSignatureNodes){%>
	            document.getElementById("WebOffice").ShowToolBar="1";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
		        document.getElementById("WebOffice").VisibleTools('�½��ļ�',false);
		        document.getElementById("WebOffice").VisibleTools('���ļ�',false);
		        document.getElementById("WebOffice").VisibleTools('�����ļ�',false);
		        document.getElementById("WebOffice").VisibleTools('ȫ��',false);
		        document.getElementById("WebOffice").VisibleTools('������ע',false);
          <%}else{%>
	        	document.getElementById("WebOffice").ShowToolBar="0";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
	      <%}%>
	  <%}%>
      document.getElementById("WebOffice").MaxFileSize = <%=maxOfficeDocFileSize%> * 1024; 
      document.getElementById("WebOffice").UserName="<%=user.getUsername()%>";
      document.getElementById("WebOffice").WebSetMsgByName("USERID","<%=user.getUID()%>");
      document.getElementById("WebOffice").WebOpen();  	//�򿪸��ĵ�
      //document.getElementById("WebOffice").WebShow(true);
      var signatureCount=0;
      try{
			SetActiveDocument();   //���û�ĵ�

          weaver.SignatureAPI.InitSignatureItems();  //��ǩ�����ݷ����仯ʱ��������ִ�и÷���
          signatureCount=weaver.SignatureAPI.SignatureCount;

	        if(signatureCount>=1){
	            document.getElementById("signatureCount").value=signatureCount;
	        }
      }catch(e){
      }
	  <%if(isIWebOffice2006 == true){%>
		//iWebOffice2006 �������ݿ�ʼ
		  document.getElementById("WebOffice").ShowType="1";  //�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
		//iWebOffice2006 �������ݽ���
		<%}%>  
      
//document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
//document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);

	     <%if(canPrint&&!"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,true);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%} else if(canPrint&&"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
	     <%} else {%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("��ӡ");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
		 <%}%>
	     <%if(canPrint&&!"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,true);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%} else if(canPrint&&"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
	     <%} else {%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("��ӡ");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
		 <%}%>

      StatusMsg(document.getElementById("WebOffice").Status);
  }catch(e){
      alert(e.description);
  }
     //������ʾ��Ϣ  ��ʼ
     hiddenPrompt();
     //������ʾ��Ϣ  ����
     
	//WebToolsEnable('Standard',109,true);StatusMsg('ok');
	
	try{
	onshowdocmain(<%=(docpublishtype.equals("2"))?1:0%>);
	}catch(e){}
	setWebObjectSaved();//���������onLoad�������һ��chujun TD10961
}


function onLoadEnd(){
	try{
<%
	if(fromFlowDoc.equals("1")){
%>//�Ƿ���ʾ����
		//document.getElementById("WebOffice").WebToolsVisible("iSignature",false);//���ظ��°�ť
		WebToolsVisibleISignatureFalse();
<%
	    if(isIWebOffice2006 == true&&!isSignatureNodes){
%>
		    if(document.getElementById("WebOffice").Pages >=1){
				if(window.confirm('<%=SystemEnv.getHtmlLabelName(21680,languageId)%>')){
				    document.getElementById("WebOffice").ShowType="2";
				}								 
		    }
<%
	    }
        if(isSignatureNodes){
%>
		    if(window.confirm('<%=SystemEnv.getHtmlLabelName(21658,languageId)%>')){
	            CreateSignature(0);
	         }
<%
        }
	}
%>
	try{
	<%if(isDefaultNoShowRevision){%>
		try{
			//Ext.getCmp('hide_id').hide();
			document.getElementById('hide_id').style.display = "none";
		}catch(e){}
		try{
			//Ext.getCmp('dispaly_id').show();
			document.getElementById('dispaly_id').style.display = "block";
		}catch(e){}
	<%}else{%>								  
		try{
			//Ext.getCmp('hide_id').show();
			document.getElementById('hide_id').style.display = "block";
		}catch(e){}
		try{
			//Ext.getCmp('dispaly_id').hide();
			document.getElementById('dispaly_id').style.display = "none";
		}catch(e){}
	<%}%>
	}catch(e){}
  }catch(e){
  }
}

function onLoadAgain(){

      //document.getElementById("WebOffice").WebObject.Saved=true;//added by cyril on 2008-06-10 �ĵ��޸��ж���
      setWebObjectSaved();

	  //document.getElementById("WebOffice").WebToolsVisible("iSignature",false);//���ظ��°�ť
	  WebToolsVisibleISignatureFalse();

      //document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
      //document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%if(canPrint&&!"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,true);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
	     <%} else if(canPrint&&"1".equals(isPrintControl)){%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
	     <%} else {%>
document.getElementById("WebOffice").WebToolsEnable('Standard',2521,false);
document.getElementById("WebOffice").DisableMenu("��ӡԤ��");
document.getElementById("WebOffice").DisableMenu("��ӡ");
document.getElementById("WebOffice").DisableMenu("�Ķ���ʽ");
document.getElementById("WebOffice").WebToolsEnable('Standard',109,false);
document.getElementById("WebOffice").WebToolsEnable('Standard',7226,false);
document.getElementById("WebOffice").WebToolsEnable('E-mail',2521,false);
WebToolsVisible('Reading Layout',false);
document.getElementById("WebOffice").DisableKey("F12,CTRL+P,CTRL+SHIFT+F12");
try{
    document.getElementById("WebOffice").Print="0"; 
}catch(e){
}
		 <%}%>
}

function onUnLoad(){
  try{
	  weaver.SignatureAPI.ReleaseActiveDocument();  //�˳���ʱ���ͷŻ�ĵ���һ��Ҫִ��
  }catch(e){
  }

  try{
	  docCheckIn(<%=docid%>);//ǩ���ǩ�����ĵ�
  }catch(e){
  }

  try{
      if (!document.getElementById("WebOffice").WebClose()){
         StatusMsg(document.getElementById("WebOffice").Status);
      }else{
         StatusMsg("<%=SystemEnv.getHtmlLabelName(19716,languageId)%>...");
      }
  }catch(e){}
  return false;
}

function WebOpenSignature(){
  try{
    document.getElementById("WebOffice").WebOpenSignature();
    StatusMsg(document.getElementById("WebOffice").Status);
    return true;
  }catch(e){
      return false;
  }
}

function protectDoc(){
	//modified by cyril on 2008-06-10 for TD:8828
	try {
		document.getElementById(tagFlag+'namerepeated').value = document.getElementById('namerepeated').value;//namerepeated�����
	}
	catch(e) {}
	var Modify = document.getElementById("WebOffice").WebObject.Saved;
	if(!Modify || !checkDataChange())
		event.returnValue="<%=SystemEnv.getHtmlLabelName(19006,languageId)%>";
}

   function wfchangetab(){
		try {
			document.getElementById(tagFlag+'namerepeated').value = document.getElementById('namerepeated').value;//namerepeated�����
		}
		catch(e) {}
		var Modify = document.getElementById("WebOffice").WebObject.Saved;
    	if(!Modify || !checkDataChange()) {
    	  return true;
    	}else{
    	  return false;
    	}
    }

function shiftCanCopy(){
	if(check_form(document.weaver,getneedinputitems())){
<%
if (fromFlowDoc.equals("1")&&(docstatus.equals("2")||docstatus.equals("5"))) {
%>
        document.weaver.docstatus.value="<%=docstatus%>";
<%
}else{
%>
        document.weaver.docstatus.value=1;
<%
}
%>
        document.weaver.operation.value='editsave';
        if(SaveDocument()){
            mybody.onbeforeunload=null;

            //������ʾ��Ϣ  ��ʼ
            showPrompt("<%=SystemEnv.getHtmlLabelName(18893,languageId)%>");
            //������ʾ��Ϣ  ����

            document.weaver.cancopy.value="<%="1".equals(canCopy)?"0":"1"%>";
            document.weaver.submit();
        }
    }
}
function acceptAll(){
    document.getElementById("WebOffice").WebObject.Application.ActiveDocument.AcceptAllRevisions();
}

    function onPrintDoc(){
	    //document.getElementById("WebOffice").WebOpenPrint();
<%if(isPrintControl.equals("1")){%>
    if(document.getElementById("WebOffice").FileType==".doc"||document.getElementById("WebOffice").FileType==".docx"){	
	    WebCopysCtrlPrint();
    }else if(document.getElementById("WebOffice").FileType==".xls"||document.getElementById("WebOffice").FileType==".xlsx"){
   	    WebCopysCtrlPrintExcel();   //����EXCEL����
    }else{
		document.getElementById("WebOffice").WebOpenPrint();
	}
<%}else{%>		
		document.getElementById("WebOffice").WebOpenPrint();
<%}%>
    }

//��ӡ��������
function WebCopysCtrlPrint(){
	var mCopies,objPrint;
    objPrint = document.getElementById("WebOffice").WebObject.Application.Dialogs(88);     //��ӡ���öԻ���
    if (objPrint.Display==-1){
        mCopies=objPrint.NumCopies;    //ȡ����Ҫ��ӡ����
        document.getElementById("WebOffice").WebSetMsgByName("COMMAND","COPIES");
        document.getElementById("WebOffice").WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //���ñ���OFFICEPRINTS��ֵ����WebSendMessage()ʱ��һ���ύ��OfficeServer��
        document.getElementById("WebOffice").WebSetMsgByName("DOCID","<%=docid%>");  
        document.getElementById("WebOffice").WebSetMsgByName("USERID","<%=userid%>");
        document.getElementById("WebOffice").WebSetMsgByName("CLIENTADDRESS","<%=request.getRemoteAddr()%>");		
        document.getElementById("WebOffice").WebSetMsgByName("HASPRINTNODE","<%=hasPrintNode%>");
        document.getElementById("WebOffice").WebSetMsgByName("ISPRINTNODE","<%=isPrintNode%>");			
        document.getElementById("WebOffice").WebSetMsgByName("CANPRINT","<%=canPrint%>");				
        document.getElementById("WebOffice").WebSendMessage();                               //����OfficeServer��OPTION="SENDMESSAGE"       
        if (document.getElementById("WebOffice").Status=="1") {
            objPrint.Execute;
        }else{
            var maxPrints=document.getElementById("WebOffice").WebGetMsgByName("MAXPRINTS");			
            alert("<%=SystemEnv.getHtmlLabelName(21534 ,languageId)%>��<%=SystemEnv.getHtmlLabelName(21535 ,languageId)%>��"+maxPrints);
            return false;
        }
    }
}

//��ӡ��������   EXCEL
function WebCopysCtrlPrintExcel(){

	document.getElementById("WebOffice").WebOpenPrint();

}
    function onPrintApply(){
		//location.href='/workflow/request/AddRequest.jsp?workflowid=<%=printApplyWorkflowId%>&isagent=<%=isagentOfprintApply%>&docid=<%=docid%>' ;
		openFullWindow("/workflow/request/AddRequest.jsp?workflowid=<%=printApplyWorkflowId%>&isagent=<%=isagentOfprintApply%>&docid=<%=docid%>");
    }

    function onPrintLog(){
		//location.href='/docs/docs/DocPrintLog.jsp?docid=<%=docid%>' ;
		openFullWindow("/docs/docs/DocPrintLog.jsp?docid=<%=docid%>");
    }

    function setWebObjectSaved(){
		try{
			document.getElementById("WebOffice").WebObject.Saved=true;
		}catch(e){}
	}

    /**added by cyril on 2008-07-02 for TD:8921**/
	function protectDoc_include() {
		try {
			document.getElementById(tagFlag+'namerepeated').value = document.getElementById('namerepeated').value;//namerepeated�����
		}
		catch(e) {}
		var Modify = document.getElementById("WebOffice").WebObject.Saved;
		if(!Modify || !checkDataChange()) {
			if(!confirm('<%=SystemEnv.getHtmlLabelName(19006,languageId)%>'))
				document.getElementById('onbeforeunload_protectDoc_return').value = 0;//��ⲻͨ��
			else 
				document.getElementById('onbeforeunload_protectDoc_return').value = 1;//���ͨ��
		}
	}
	/**end added by cyril on 2008-07-02 for TD:8921**/
</script>

</head>

<body class="ext-ie ext-ie8 x-border-layout-ct" id="mybody" scroll="no" onUnload="onUnLoad()" onbeforeunload="protectDoc()">

<form id=weaver name=weaver action="UploadDoc.jsp?fromFlowDoc=<%=fromFlowDoc%>&workflowid=<%=workflowid%>" method=post enctype="multipart/form-data">
<!--�ò���������ΪForm�ĵ�һ������,���Ҳ����������ط����ã����ڽ����IE6.0�����롤���������Ŵ��ڵ�����-->
<INPUT TYPE="hidden" id="docIdErrorError" NAME="docIdErrorError" value="">

<iframe id="DocCheckInOutUtilIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>

<%@ include file="/systeminfo/DocTopTitle.jsp"%>
<input type="hidden" name="onbeforeunload_protectDoc" onclick="protectDoc_include()"/>
<input type="hidden" name="onbeforeunload_protectDoc_return"/>

<%
int tmppos = doccontent.indexOf("!@#$%^&*");
if(tmppos!=-1){
	docmain = doccontent.substring(0,tmppos);
	doccontent = doccontent.substring(tmppos+8,doccontent.length());
}
%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<input type=hidden name=cancopy value="<%=canCopy%>">
<input type=hidden name=docapprovable value="<%=needapprovecheck%>">
<input type=hidden name=isreply value="<%=isreply%>">
<input type=hidden name=replydocid value="<%=replydocid%>">

<input type=hidden name=docreplyable value="<%=replyable%>">
<input type=hidden name=docstatus value="<%=docstatus%>">
<input type=hidden name=doccreaterid value="<%=doccreaterid%>">
<input type=hidden name=docCreaterType value="<%=docCreaterType%>">
<input type=hidden name=doccreatedate value="<%=doccreatedate%>">
<input type=hidden name=doccreatetime value="<%=doccreatetime%>">
<input type=hidden name=docapproveuserid value="<%=docapproveuserid%>">
<input type=hidden name=docapprovedate value="<%=docapprovedate%>">
<input type=hidden name=docapprovetime value="<%=docapprovetime%>">
<input type=hidden name=docarchiveuserid value="<%=docarchiveuserid%>">
<input type=hidden name=docarchivedate value="<%=docarchivedate%>">
<input type=hidden name=docarchivetime value="<%=docarchivetime%>">
<input type=hidden name=usertype value="<%=usertype%>">
<input type=hidden name="ownerid" value="<%=ownerid%>">
<input type=hidden name="oldownerid" value="<%=ownerid%>">
<input type=hidden name="ownerType" value="<%=ownerType%>">
<input type=hidden name="docdepartmentid" value="<%=docdepartmentid%>">
<input type=hidden name=doclangurage value="<%=doclangurage%>">
<input type=hidden name=replaydoccount value="<%=replaydoccount%>">

<input type=hidden name=from value="<%=from%>">
<input type=hidden name=userCategory  value="<%=userCategory%>">
<input type="hidden" name="userId" value="<%=user.getUID()%>">
<input type="hidden" name="userType" value="<%=user.getLogintype()%>">

<input type="hidden" name="doccode" value="<%=docCode%>">
<input type="hidden" name="docedition" value="<%=docedition%>">
<input type=hidden name=doceditionid value="<%=doceditionid%>">
<input type=hidden name=maincategory value="<%=(maincategory==-1?"":Integer.toString(maincategory))%>">
<input type=hidden name=subcategory value="<%=(subcategory==-1?"":Integer.toString(subcategory))%>">
<input type=hidden name=seccategory value="<%=(seccategory==-1?"":Integer.toString(seccategory))%>">

<input type=hidden name=maindoc value="<%=maindoc%>">

<input type=hidden name=topage value='<%=topageFromOther%>'>

<input type=hidden name="requestid" value=<%=requestid%>>
<input type=hidden name="workflowid" value=<%=workflowid%>>

<input type=hidden name=isFromAccessory value='<%=isFromAccessory?1:0%>'>
<input type=hidden name=operation>
<input type=hidden name=id value="<%=docid%>">
<input type=hidden name=versionId value="<%=versionId%>">
<input type=hidden name=delimgid>
<input type=hidden id="hasUsedTemplet" name=hasUsedTemplet value="<%=hasUsedTemplet%>">
<input type=hidden name=signatureCount value="0">

<input type="hidden" name="imageidsExt"  id="imageidsExt">
<input type="hidden" name="imagenamesExt"  id="imagenamesExt">

<input type=hidden name="deleteaccessory" value="">

<div style="position: absolute; left: 0; top: 0; width:100%;">

<div id="divContentTab" style="display:none;width:100%;">

	<%-- �ĵ����� start --%>
	<div id="divDocTile" style="width:100%;<% if(("1").equals(fromFlowDoc)){ %>display: none;<% } %>">
		<DIV style="WIDTH: 100%; MozUserSelect: none; KhtmlUserSelect: none" class="x-tab-panel-header x-unselectable" unselectable="on">
		<DIV class=x-tab-strip-wrap>
		<UL class="x-tab-strip x-tab-strip-top">
		<LI class=" x-tab-strip-active ">
		<A class=x-tab-strip-close></A>
		<A class=x-tab-right>
		<EM class=x-tab-left>
		<div class=x-tab-strip-inner><div class="x-tab-strip-text " style="padding-top:3px;">
			<table align="center" id="spanDocTitle">
				<tr>
					<td width="58"><b><%=SystemEnv.getHtmlLabelName(19541,user.getLanguage())%>:</b></td> 
					<td>
						<input type="hidden" name="namerepeated" value="0">
						<input  style="width:310px" id="docsubject" name="docsubject" value="<%=docsubject%>" maxlength=200 							 
						<%if(!isPersonalDoc){%>
							onChange="checkDocSubject(this);"
							onMouseDown="docSubjectMouseDown(this);"
							onBlur="checkDocSubject(this);"
						<%}else{%>
							onChange="checkinput('docsubject','docsubjectspan');"
						<%}%>
						>
					</td>
					<td>
						<span id="docsubjectspan">
							<%if(docsubject.equals("")){%>
								<img src="/images/BacoError.gif" align=absMiddle>
							<%} %>
						</span>
					</td>
				</tr>
			</table>
			<script type="text/javascript">
				var isChecking = false;
				var prevValue = "";
				var checkCnt = 0;

				function docSubjectMouseDown(obj){
					if(event.button==2){
						checkDocSubject(obj)
					}
				}
				function checkDocSubject(obj){
					if(obj!=null&&obj.value!=null&&obj.value!=""&&obj.value!=prevValue){
					  //$('docsubjectspan').innerHTML = "<font color=red><%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%></font>";
					  
					  $('namerepeated').value = 1;
					  isChecking = true;
					  
					  var subject = encodeURIComponent(obj.value);							  
					  var url = 'DocSubjectCheck.jsp';
					  var pars = 'subject='+subject+'&secid=<%=seccategory%>&docid=<%=docid%>';
					  var myAjax = new Ajax.Request(
						url,
						{method: 'post', parameters: pars, onComplete: doCheckDocSubject}
					  );
					}else{
						checkinput('docsubject','docsubjectspan');
					}
				}
				function doCheckDocSubject(req){						
					var num = req.responseXML.getElementsByTagName('num')[0].firstChild.data;
					if(num>0){
						//alert("<%=SystemEnv.getHtmlLabelName(20073,user.getLanguage())%>");
						$('docsubjectspan').innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"+
						" <div style='color:red;padding:8px 2px;width:310px;position:absolute;left:415px'><%=SystemEnv.getHtmlLabelName(20073,user.getLanguage())%></div>";
						$('namerepeated').value = 1;
					} else {
						$('namerepeated').value = 0;
						/** added by cyril on 2008-06-10 for TD:8828 ajax���ú��ټ������һ��У��ֵ **/
						if(checkCnt==0)
							createTags();
						checkCnt = 1;
						/** end by cyril on 2008-06-10 for TD:8828 **/
						checkinput('docsubject','docsubjectspan');
					}
					isChecking = false;
					prevValue = $('docsubject').value;
				}
				function checkSubjectRepeated(){
					if($F('namerepeated')==1){
						if(isChecking){
							alert("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");
						} else {
							alert("<%=SystemEnv.getHtmlLabelName(20073,user.getLanguage())%>");
						}
						return false;
					}
					else return true;
				}
				</script>
				<%
				needinputitems += ",docsubject";
				%>
			</div></div>
			</EM></A></LI>
			<LI class=x-tab-edge></LI>
			<DIV class=x-clear></DIV></UL></DIV>
			<DIV class=x-tab-strip-spacer></DIV>
			<DIV style="POSITION: absolute; TOP: 2px; RIGHT: 15px" id=divFavorite>
			</DIV></DIV>
	</div>
	<%-- �ĵ����� end --%>
	
	<input type="hidden" name="needinputitems" value="<%=needinputitems%>">

	<%-- iWebOffice�༭�ؼ� start --%>
	<div id="divContent" style="width:100%;overflow:hidden;">
		<table cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
			<tr><td bgcolor=menu>
			<div id="objectDiv">
				<div>
				<OBJECT id="WebOffice" classid="<%=mClassId%>" style="POSITION:absolute;width:0;height:0;top:-23;" codebase="<%=mClientUrl%>" >
				</OBJECT>
				</div>
				<span id=StatusBar style="display:none">&nbsp;</span>
			</div>
			<%if(isSignatureNodes){%>
			<OBJECT id=SignatureAPI classid="clsid:79F9A6F8-7DBE-4098-A040-E6E0C3CF2001"  codebase="iSignatureAPI.ocx#version=5,0,2,0"    width=0 height=0 align=center hspace=0 vspace=0></OBJECT>
			<%} %>
			</td></tr>
		</table>
	</div>
	<%-- iWebOffice�༭�ؼ� end --%>

	<%-- ������ start --%>
	<DIV id="divTools" style="width:100%;" class="<% if(("1").equals(fromFlowDoc)){ %>x-panel-footer<% } else { %>x-tab-panel-bbar<% } %>">
	<DIV id=toolbarmenudiv class="<% if(("1").equals(fromFlowDoc)){ %>x-panel-fbar x-panel-btns-center<% } else { %>x-toolbar<% } %> x-small-editor x-toolbar-layout-ct">
		<TABLE class="x-toolbar-ct" style="WIDTH: auto;<% if(("1").equals(fromFlowDoc)){ %>margin-top: 5px;<%} %>" cellSpacing=0>
			<TBODY>
				<TR>
				<td align="left" class="x-toolbar-left">
				<table cellspacing="0">
				<tbody>
				<tr class="x-toolbar-left-row">
				<% 
				for(Iterator mbit = menuBars.iterator();mbit.hasNext();){
					menuBarMap = (Map)mbit.next();
					if(menuBarMap.size()==0){
					%>
					<TD class=x-toolbar-cell><SPAN class=xtb-sep></SPAN></TD>
					<% } else {
						String tooltext = (String)menuBarMap.get("text");
						String tooliconCls = (String)menuBarMap.get("iconCls");
						String toolid = (String)menuBarMap.get("id");
						String toolhandler = (String)menuBarMap.get("handler");
						String toolmouseout = "";
						menuBarToolsMap = (Map[])menuBarMap.get("menu");
						if(menuBarToolsMap!=null&&(toolhandler==null||"".equals(toolhandler))) toolhandler = "showToolsMenu"+toolid+"();";
						if(menuBarToolsMap!=null) toolmouseout = "hideToolsMenu"+toolid+"();";
					%>
					<TD class="x-toolbar-cell">
					<TABLE id="<%=toolid%>" class="x-btn x-btn-text-icon" onmouseover=resetButtonClass(this,2); onmouseout=resetButtonClass(this,1); onclick="<%=toolhandler%>" cellSpacing=0>
						<TBODY class="x-btn-small x-btn-icon-small-left">
							<TR>
								<TD class=x-btn-tl><I>&nbsp;</I></TD>
								<TD class=x-btn-tc></TD>
								<TD class=x-btn-tr><I>&nbsp;</I></TD>
							</TR>
							<TR>
								<TD class=x-btn-ml><I>&nbsp;</I></TD>
								<td class="x-btn-mc"><EM class="<%if(menuBarToolsMap!=null&&menuBarToolsMap.length>0){%>x-btn-arrow<%}%>" unselectable="on">
								<BUTTON id="BUTTON<%=toolid%>" class="x-btn-text <%=tooliconCls%>" type="button"><%=tooltext%></BUTTON>
								</EM></td>
								<TD class=x-btn-mr><I>&nbsp;</I></TD>
							</TR>
							<TR>
								<TD class=x-btn-bl><I>&nbsp;</I></TD>
								<TD class=x-btn-bc></TD>
								<TD class=x-btn-br><I>&nbsp;</I></TD>
							</TR>
						</TBODY>
					</TABLE>
					</TD>
					<% } %>
				<% } %>
				</tr>
				</tbody>
				</table>
				</td>
				</TR>
			</TBODY>
		</TABLE>
		</DIV>
		<script type="text/javascript">
		function resetButtonClass(o,type) {
			var oclassname = o.className;
			if(oclassname) {
				oclassname = oclassname.replace(/(^\s*)|(\s*$)/g, "");
			}
			if(type==1) {
				if(oclassname.indexOf('x-btn-over')>-1)
				{
					o.className = oclassname.replace(/x-btn-over/g,'');
				}
			} else {
				if(oclassname.indexOf('x-btn-over')<0) {
					o.className=oclassname+" x-btn-over ";
				}
			}
		}
		</script>
	</div>
	<% 
	for(Iterator mbit = menuBars.iterator();mbit.hasNext();){
		menuBarMap = (Map)mbit.next();
		if(menuBarMap.size()>0) {
			String toolid = (String)menuBarMap.get("id");
			menuBarToolsMap = (Map[])menuBarMap.get("menu");
			String toolhandler = "";
			String toolmouseout="";
			
			if(menuBarToolsMap!=null&&(toolhandler==null||"".equals(toolhandler))) toolhandler = "showToolsMenu"+toolid+"();";
			if(menuBarToolsMap!=null) toolmouseout = "hideToolsMenu"+toolid+"();";

			if(menuBarToolsMap!=null&&menuBarToolsMap.length>0){
			%>
				<script type="text/javascript">
				function hideToolsMenu<%=toolid%>(){
					var bobj = document.getElementById("<%=toolid%>");
					if(bobj){
						bobj.unselectable = "on";
						resetButtonClass(bobj,1);
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.display="none";
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.display="none";
						document.getElementById("divToolsMenuContent<%=toolid%>").style.display="none";
					}
				}
				
				function showToolsMenu<%=toolid%>(){
					var bobj = document.getElementById("<%=toolid%>");
					if(bobj){
						bobj.unselectable = "off";
						resetButtonClass(bobj,2);
	
						var dleft = getX(bobj) - 2;
						var dtop = getY(bobj);

						if(document.getElementById("divPropTab")&&document.getElementById("divPropTab").style.display=="none")
							dtop = dtop - bobj.offsetHeight - <%=menuBarToolsMap.length*25-20%>;
						else
							dtop = dtop + bobj.offsetHeight - 5;
						
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.left=dleft;
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.top=dtop;
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.width="121px";
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.height="<%=menuBarToolsMap.length*25+2%>px";
						document.getElementById("divToolsMenuIFrame<%=toolid%>").style.display="block";
						
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.left=dleft;
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.top=dtop;
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.width="121px";
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.height="<%=menuBarToolsMap.length*25+2%>px";
						document.getElementById("divToolsMenuBorder<%=toolid%>").style.display="block";
						
						document.getElementById("divToolsMenuContent<%=toolid%>").style.left=dleft+3;
						document.getElementById("divToolsMenuContent<%=toolid%>").style.top=dtop+5;
						document.getElementById("divToolsMenuContent<%=toolid%>").style.width="120px";
						document.getElementById("divToolsMenuContent<%=toolid%>").style.height="<%=menuBarToolsMap.length*25+1%>px";
						document.getElementById("divToolsMenuContent<%=toolid%>").style.display="block";

						var ofunc = document.body.onclick;
						document.body.onclick = function () {
							if(ofunc) ofunc.call(this);
							var hidden = true;
							var obj = event.srcElement;
							while(obj){
								if( obj.id=="divToolsMenuIFrame<%=toolid%>" || obj.id=="divToolsMenuBorder<%=toolid%>" ||
									obj.id=="divToolsMenuContent<%=toolid%>" || obj.id=="divToolsMenuUL<%=toolid%>" ||
									obj.id=="divToolsMenuUL<%=toolid%>" || 
									obj.id=="<%=toolid%>"
								) {
									hidden = false;
									break;
								} else {
									obj = obj.parentElement;
								}
							}
							if(hidden) hideToolsMenu<%=toolid%>();
						};
					}
				}
				</script>
				<IFRAME id=divToolsMenuIFrame<%=toolid%> style="Z-INDEX: 14998; VISIBILITY: visible; display:none;" class=ext-shim frameBorder=0></IFRAME>	
				<DIV id=divToolsMenuBorder<%=toolid%> style="Z-INDEX: 14999; display:none; FILTER: progid:DXImageTransform.Microsoft.alpha(opacity=50) progid:DXImageTransform.Microsoft.Blur(pixelradius=4);" class=x-ie-shadow></DIV>
				<DIV id=divToolsMenuContent<%=toolid%> style="Z-INDEX: 15000; display:none; POSITION: absolute; VISIBILITY: visible;" class="x-menu x-menu-floating x-layer ">
				<UL id=divToolsMenuUL<%=toolid%> style="HEIGHT:100%" class=x-menu-list>
					<% for(int l=0;l<menuBarToolsMap.length;l++){ 
							String toolmenutext = (String)menuBarToolsMap[l].get("text");
							String toolmenuiconCls = (String)menuBarToolsMap[l].get("iconCls");
							String toolmenuhandler = (String)menuBarToolsMap[l].get("handler");
							%>
					<LI id=divToolsMenuLI<%=toolid%><%=l%> class="x-menu-list-item">
					<A id=divToolsMenuA<%=toolid%><%=l%> href="#" class=x-menu-item onclick="<%=toolmenuhandler%>;">
					<IMG id=divToolsMenuIMG<%=toolid%><%=l%> class="x-menu-item-icon <%=toolmenuiconCls%>" src="/js/extjs/resources/images/default/s.gif">
					<SPAN id=divToolsMenuSPAN<%=toolid%><%=l%> class=x-menu-item-text><%=toolmenutext%></SPAN>
					</A>
					</LI>
					<% } %>
				</UL>
				</DIV>
			<%
			}
		}
	}
	%>
	<%-- ������ end --%>

</div>

<div id="divPropTabCollapsed" style="display:none;width: 100%;overflow:hidden;">
<% if(("1").equals(fromFlowDoc)){ %>
	<DIV style="background-color: #eeeeee;width: 100%;height:5px; margin-top: 5px;">
		<div id=divPropTileIcon onclick="onExpandOrCollapse();" style="text-align:center;cursor: hand;"><img src="/js/extjs/resources/images/default/layout/mini-top.gif"></div>
	</DIV>
<% } else { %>
	<DIV style="background-color: #eeeeee;border: solid 1px #e0e0e0;width: 100%;height:26px; margin: 3px;text-align: right;">
	<TABLE style="margin-top: 3px;cursor:hand;"><TBODY><TR>
	<TD width=105><IMG align=absMiddle src="/images/docs/reply.png">&nbsp;<script type="text/javascript">document.write(wmsg.base.replycount);</script>:<FONT id=fontReply color=red><%=replaydoccount%></FONT></TD>
	<TD width=100><A onclick='onExpandOrCollapse(true);onActiveTab("divAcc");'><IMG align=absMiddle src="/images/docs/acc.png">&nbsp;<script type="text/javascript">document.write(wmsg.base.acccount);</script>:<FONT id=fontImgAcc color=red><%=accessorycount%></FONT></A></TD>
	<TD width=16><IMG align=absMiddle src="/images/docs/expand.png" onclick="onExpandOrCollapse();"></TD>
	</TR></TBODY></TABLE>
	</DIV>
<% } %>
</div>

<div id="divPropTab" style="display:none;width: 100%">
	
	<!-- ���Ա����� start -->
	<div id="divPropTile" style="width:100%;">
		<DIV style="MozUserSelect: none; KhtmlUserSelect: none" class="x-panel-header x-unselectable" unselectable="on">
			<DIV id=divPropTileIcon class="x-tool x-tool-toggle x-tool-collapse-south x-tool-collapse-south-over " onclick="onExpandOrCollapse();">&nbsp;</DIV>
			<SPAN id=divPropTileText class=x-panel-header-text><script type="text/javascript">document.write(wmsg.doc.prop);</script></SPAN>
		</DIV>
	</div>
	<!-- ���Ա����� end -->
	
	<!-- �ĵ������� start -->
	<div id="divProp" style="display:none;width:100%;">
		<DIV style="WIDTH: 100%; HEIGHT: 195px" class="x-tab-panel-body x-tab-panel-body-noheader x-tab-panel-body-noborder x-tab-panel-body-bottom">
		<DIV style="WIDTH: 100%" id=DocPropAdd class=" x-panel x-panel-noborder">
		<DIV class=x-panel-bwrap>
		<DIV style="WIDTH: 100%; HEIGHT: 195px; OVERFLOW: auto" class="x-panel-body x-panel-body-noheader x-panel-body-noborder">
			<jsp:include page="/docs/docs/DocEditExtBaseInfo.jsp">
				<jsp:param value="<%=userCategory%>" name="userCategory"/>
				<jsp:param value="<%=docid%>" name="docid"/>
				<jsp:param value="<%=imagefileId%>" name="imagefileId"/>
				<jsp:param value="<%=versionId%>" name="versionId"/>
				<jsp:param value="<%=isPersonalDoc%>" name="isPersonalDoc"/>
				<jsp:param value="<%=fromFlowDoc%>" name="fromFlowDoc"/>
			</jsp:include>
		</DIV></DIV></DIV></DIV>
	</div>
	<!-- �ĵ������� end -->
	
	<!-- �ĵ������� start -->
	<div id="divAcc" style="display:none;width:100%;">
		<DIV style="WIDTH: 100%; HEIGHT: 195px" class="x-tab-panel-body x-tab-panel-body-noheader x-tab-panel-body-noborder x-tab-panel-body-bottom">
		<jsp:include page="/docs/docs/DocComponents.jsp">
			<jsp:param value="edit" name="mode"/>
			<jsp:param value="docedit" name="pagename"/>
			<jsp:param value="false" name="isFromWf"/>
			<jsp:param value="<%=docid%>" name="docid"/>
			<jsp:param value="<%=maxUploadImageSize%>" name="maxUploadImageSize"/>
				<jsp:param value="<%=bacthDownloadFlag%>" name="bacthDownloadFlag"/>
			<jsp:param value="getDivAcc" name="operation"/>
		</jsp:include>
		</DIV>
	</div>
	<!-- �ĵ������� end -->

	<!-- �ĵ������� start -->
	<div id="divShare" style="display:none;width:100%;">
		<DIV style="WIDTH: 100%; HEIGHT: 195px" class="x-tab-panel-body x-tab-panel-body-noheader x-tab-panel-body-noborder x-tab-panel-body-bottom">
		<jsp:include page="/docs/docs/DocComponents.jsp">
			<jsp:param value="edit" name="mode"/>
			<jsp:param value="docedit" name="pagename"/>
			<jsp:param value="<%=docid%>" name="docid"/>
			<jsp:param value="<%=canShare%>" name="canShare"/>
			<jsp:param value="getDivShare" name="operation"/>
		</jsp:include>
		</DIV>
	</div>
	<!-- �ĵ������� end -->
	
	<% if(DocMark.isAllowMark(""+seccategory)){ %>
	<!-- �ĵ������ start -->
	<div id="divMark" style="display:none;width:100%;">
		<DIV style="WIDTH: 100%; HEIGHT: 195px" class="x-tab-panel-body x-tab-panel-body-noheader x-tab-panel-body-noborder x-tab-panel-body-bottom">
		<jsp:include page="/docs/docs/DocComponents.jsp">
			<jsp:param value="edit" name="mode"/>
			<jsp:param value="docedit" name="pagename"/>
			<jsp:param value="<%=docid%>" name="docid"/>
			<jsp:param value="<%=seccategory%>" name="secid"/>
			<jsp:param value="getDivMark" name="operation"/>
		</jsp:include>
		</DIV>
	</div>
	<!-- �ĵ������ end -->
	<% } %>

	<!-- �ײ�ѡ��� start -->
	<div id="divTab" style="width:100%;">

		<DIV style="WIDTH: 1278px" class="x-tab-panel-footer x-tab-panel-footer-noborder">
		<DIV class=x-tab-strip-spacer></DIV>
		<DIV class=x-tab-strip-wrap>
		<UL class="x-tab-strip x-tab-strip-bottom">
		
		<LI id=divPropATab class=" x-tab-strip-active" onclick="onActiveTab('divProp');">
		<A class=x-tab-strip-close onclick="return false;"></A>
		<A class=x-tab-right onclick="return false;" href="#">
		<EM class=x-tab-left>
		<SPAN class=x-tab-strip-inner><SPAN class="x-tab-strip-text "><script type="text/javascript">document.write(wmsg.doc.base);</script></SPAN></SPAN>
		</EM>
		</A>
		</LI>
		
		<LI id=divAccATab class=" "  onclick="onActiveTab('divAcc');">
		<A class=x-tab-strip-close onclick="return false;"></A>
		<A class=x-tab-right onclick="return false;" href="#">
		<EM class=x-tab-left>
		<SPAN class=x-tab-strip-inner><SPAN class="x-tab-strip-text " id="divAccATabTitle"><script type="text/javascript">document.write(wmsg.doc.acc + '(<%=accessorycount%>)');</script></SPAN></SPAN>
		</EM>
		</A>
		</LI>
		
		<LI id=divShareATab class=" "  onclick="onActiveTab('divShare');">
		<A class=x-tab-strip-close onclick="return false;"></A>
		<A class=x-tab-right onclick="return false;" href="#">
		<EM class=x-tab-left>
		<SPAN class=x-tab-strip-inner><SPAN class="x-tab-strip-text "><script type="text/javascript">document.write(wmsg.doc.share);</script></SPAN></SPAN>
		</EM>
		</A>
		</LI>

		<% if(DocMark.isAllowMark(""+seccategory)){ %>
		<LI id=divMarkATab class=" "  onclick="onActiveTab('divMark');">
		<A class=x-tab-strip-close onclick="return false;"></A>
		<A class=x-tab-right onclick="return false;" href="#">
		<EM class=x-tab-left>
		<SPAN class=x-tab-strip-inner><SPAN class="x-tab-strip-text "><script type="text/javascript">document.write(wmsg.doc.mark);</script></SPAN></SPAN>
		</EM>
		</A>
		</LI>
		<% } %>
		
		

		<LI class=x-tab-edge></LI>
		<DIV class=x-clear></DIV></UL></DIV></DIV>

	</div>
	<!-- �ײ�ѡ��� end -->
</div>

</div>

</form>

</body>

</html>

<jsp:include page="/docs/docs/DocComponents.jsp">
	<jsp:param value="<%=user.getLanguage()%>" name="language"/>
	<jsp:param value="getBase" name="operation"/>
</jsp:include>

<script language="javascript" type="text/javascript">
var isFromWf=<%=("1").equals(fromFlowDoc)%>;
var docid="<%=docid%>";
var seccategory="<%=seccategory%>"; 
var docTitle="<%=docsubject%>";
var isReply="<%=isreply.equals("1")%>";
var doceditionid="<%=doceditionid%>";

var showType="view";
var coworkid="0";
var meetingid="0";

var requestid="<%=requestid%>";
var canViewLog=<%=false%>;
var canShare=<%=canShare%>;
var canEdit=<%=canEdit%>;
var canDownload=<%=canEdit%>;
var canDocMark=<%=DocMark.isAllowMark(""+seccategory)%>;	

var maxUploadImageSize="<%=maxUploadImageSize%>";

var isEditionOpen=<%=isEditionOpen%>;

function adjustContentHeight(type){
	var lang=<%=(user.getLanguage()==8)?"true":"false"%>;
	try{
		var propTabHeight = 250;
		if(document.getElementById("divPropTab")&&document.getElementById("divPropTab").style.display=="none") propTabHeight = (isFromWf)?10:30;
		
		var pageHeight=document.body.clientHeight;
		var pageWidth=document.body.clientWidth;
		
		document.getElementById("divContentTab").style.height = pageHeight - propTabHeight;

		var divContentHeight=pageHeight-propTabHeight-65;
		if(isFromWf) divContentHeight += 25;

		var divContentWidth=pageWidth;
		if(divContentHeight!=null && divContentHeight>0){
			document.getElementById("divContent").style.height=divContentHeight;
			document.getElementById("divContent").style.width=divContentWidth;
			document.getElementById("WebOffice").style.height=divContentHeight + 23;
			document.getElementById("WebOffice").style.width=divContentWidth;
		}

		<% 
		for(Iterator mbit = menuBars.iterator();mbit.hasNext();){
			menuBarMap = (Map)mbit.next();
			if(menuBarMap.size()>0) {
				String toolid = (String)menuBarMap.get("id");
				menuBarToolsMap = (Map[])menuBarMap.get("menu");
				if(menuBarToolsMap!=null&&menuBarToolsMap.length>0){
				%>
				hideToolsMenu<%=toolid%>();
				<%
				}
			}
		}
		%>
		onResizeDiv();
	} catch(e){
	}
}

function onAccessory(){	
	onExpandOrCollapse(true);
	onActiveTab("divAcc");
}

function onExpandOrCollapse(show){
	
	var flag = false;
	if(document.getElementById("divPropTab")&&document.getElementById("divPropTab").style.display=="none"||show) flag = true;
	if(flag){
		document.getElementById("divPropTab").style.display = "block";
		document.getElementById("divPropTabCollapsed").style.display = "none";
		if(document.getElementById("BUTTONbtn_ShowOrHidden")) document.getElementById("BUTTONbtn_ShowOrHidden").value=wmsg.base.hiddenProp;
	}else{
		document.getElementById("divPropTab").style.display = "none";
		document.getElementById("divPropTabCollapsed").style.display = "block";
		if(document.getElementById("BUTTONbtn_ShowOrHidden")) document.getElementById("BUTTONbtn_ShowOrHidden").value=wmsg.base.showProp;
	}
	adjustContentHeight();
	try {
		loadExt();
	} catch(e){}
}

function onActiveTab(tab){
	document.getElementById("divProp").style.display='none';
	document.getElementById("divAcc").style.display='none';
	document.getElementById("divShare").style.display='none';
	<% if(DocMark.isAllowMark(""+seccategory)){ %>
	document.getElementById("divMark").style.display='none';
	<% } %>
	document.getElementById("divPropATab").className = "";
	document.getElementById("divAccATab").className = "";
	document.getElementById("divShareATab").className = "";
	<% if(DocMark.isAllowMark(""+seccategory)){ %>
	document.getElementById("divMarkATab").className="";
	<% } %>
	
	document.getElementById(tab).style.display='block';
	document.getElementById(tab+"ATab").className='x-tab-strip-active';

	try {
		loadExt();
		eval("doGet"+tab+"();");
		onResizeDiv();
	} catch(e){}
}

function onResizeDiv() {
	if(document.getElementById("divAcc").style.display!='none')
		resizedivAcc();
	else if(document.getElementById("divShare").style.display!='none')
		resizedivShare();
	<% if(DocMark.isAllowMark(""+seccategory)){ %>
	else if(document.getElementById("divMark").style.display!='none')
		resizedivMark();
	<% } %>
}

function getneedinputitems(){
	var allneedinputitems = document.getElementsByName("needinputitems");
	var needinputitemsstr = "";
	if(allneedinputitems&&allneedinputitems.length)
	for(var i=0;i<allneedinputitems.length;i++)
	if(allneedinputitems[i]&&allneedinputitems[i].value) needinputitemsstr += ","+allneedinputitems[i].value;
	return needinputitemsstr;
}

$(document).ready(
	function(){
		
		try{
			onLoad();
		} catch(e){}
		
		try{
			document.getElementById("divContentTab").style.display='block';
			document.getElementById("divPropTab").style.display = "none";
			document.getElementById("divPropTabCollapsed").style.display = "block";

			onActiveTab("divProp");
			
			document.getElementById('rightMenu').style.visibility="hidden";
			document.getElementById("divMenu").style.display='';	
		} catch(e){}

		adjustContentHeight("load");

		finalDo("edit");
		createTags();// by cyril on 2008-08-14 for td:9077

		try{	
			onLoadEnd();
		} catch(e){}

<%if(!docsubject.equals("")&&!isPersonalDoc){%>
		try{
			checkDocSubject($('docsubject'));
		} catch(e){}
<%}%>
	}   
);
</script>
<jsp:include page="/docs/docs/DocEditExtScript.jsp">
    <jsp:param name="docid" value="<%=docid%>" />
    <jsp:param name="fromFlowDoc" value="<%=fromFlowDoc%>" />
    <jsp:param name="isIWebOffice2006" value="<%=(isIWebOffice2006?1:0)%>" />
    <jsp:param name="requestid" value="<%=requestid%>" />
    <jsp:param name="docstatus" value="<%=docstatus%>" />
	<jsp:param name="ifVersion" value="<%=ifVersion%>" />
	<jsp:param name="isCompellentMark" value="<%=isCompellentMark%>" />
	<jsp:param name="canPostil" value="<%=canPostil%>" />
	<jsp:param name="nodeid" value="<%=nodeid%>" />
	<jsp:param name="isFromAccessory" value="<%=isFromAccessory%>" />
	<jsp:param name="topageFromOther" value="<%=topageFromOther%>" />
</jsp:include>

<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>