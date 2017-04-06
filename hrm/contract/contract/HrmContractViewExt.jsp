<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,weaver.hrm.resource.ResourceComInfo" %>
 <%@ include file="/systeminfo/init.jsp" %>
  <%@ include file="/docs/docs/iWebOfficeConf.jsp" %>
<%@ page import="java.util.*" %>
<%@ include file="/docs/common.jsp" %>
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
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="Record" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ctci" class="weaver.hrm.contract.ContractTypeComInfo" scope="page" />

<%!
	/**
	*@param comInfo
	*@param user ��ǰ��½�û�
	*@resourceid ���鿴���˵�ID
	*/
	private boolean hasRightToViewContract(ResourceComInfo  comInfo,User user,String resourceid){
		boolean hasRight = false;
		int hrmid = user.getUID();
		boolean ism = comInfo.isManager(hrmid,resourceid); //�ϼ�
		boolean ishe = (hrmid == Util.getIntValue(resourceid)); //����
		boolean ishr = (HrmUserVarify.checkUserRight("HrmContractAdd:Add",user));//������Դ����Ա
		if(ism || ishe || ishr) hasRight = true;
		return hasRight;
	}
%>


<%
String temStr = request.getRequestURI();
temStr="/docs/docs/";

String mServerUrl=temStr+mServerName;
String mClientUrl="/docs/docs/"+mClientName;

  Calendar todaycal = Calendar.getInstance ();
  String today = Util.add0(todaycal.get(Calendar.YEAR), 4) +"-"+
                 Util.add0(todaycal.get(Calendar.MONTH) + 1, 2) +"-"+
                 Util.add0(todaycal.get(Calendar.DAY_OF_MONTH) , 2) ;

String id = Util.null2String(request.getParameter("id"));

String contractman = "";
String startdate = "";
String enddate = "";
String proenddate = "";
String typeid = "";
int docid = 0;
int versionId = Util.getIntValue(request.getParameter("versionId"),0);
String sql = "select * from HrmContract where id = "+id;
rs.executeSql(sql);

while(rs.next()){
  contractman = rs.getString("contractman");
  typeid = rs.getString("contracttypeid");
  startdate = rs.getString("contractstartdate");
  enddate = rs.getString("contractenddate");
  proenddate = rs.getString("proenddate");
  docid = Util.getIntValue(rs.getString("contractdocid"),0);
}
/*STAET	Add By Charoes Huang On May 28, 2004*/

boolean hasRight = hasRightToViewContract(ResourceComInfo,user,contractman);

if(!hasRight){
           
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
/*END*/

int aheaddate = ctci.getRemindAheadDate(typeid);

String ishrm = "";
sql = "select * from HrmContractType where id = "+typeid;

rs.executeSql(sql);
while(rs.next()){
  ishrm = rs.getString("ishirecontract");
}

String man = Util.null2String(request.getParameter("contractman"));
if(!man.equals("")){
  contractman = man;
}

sql = "select startdate,enddate,probationenddate from HrmResource where id = "+contractman;

rs.executeSql(sql);

while(rs.next()){
   if(ishrm.equals("1")){
     startdate = rs.getString("startdate");
     enddate  = rs.getString("enddate");
   }
   proenddate = rs.getString("probationenddate");
}
//ȡ���ĵ�����
 sql = "";
if(versionId==0){
    sql = "select * from DocImageFile where docid="+docid+" order by versionId desc";
}else{
    sql = "select * from DocImageFile where docid="+docid+" and versionId="+versionId;
}
//System.out.println("versionID sql:"+sql);
RecordSet.executeSql(sql) ;
RecordSet.next();
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
}else if(filetype.equals("10")){
    filetype=".et";
}else{
    filetype=".doc";
}


String  docEditType=Util.null2String(request.getParameter("docEditType"));
if(docEditType.equals("")){
    docEditType = "1";
}

String subid=Util.null2String(request.getParameter("subid"));
int SecId=Util.getIntValue(Util.null2String(request.getParameter("SecId")),0);

String needinputitems = "";
DocManager.resetParameter();
DocManager.setId(docid);
DocManager.getDocInfoById();
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
	
DocManager.closeStatement();
String docmain = "";

if(ownerid==0) ownerid=user.getUID() ;
String owneridname=ResourceComInfo.getResourcename(ownerid+"");
//��Ŀ¼��Ϣ
RecordSet.executeProc("Doc_SecCategory_SelectByID",seccategory+"");
RecordSet.next();
String categoryname=Util.toScreenToEdit(RecordSet.getString("categoryname"),user.getLanguage());
String subcategoryid=Util.null2String(""+RecordSet.getString("subcategoryid"));
String docmouldid=Util.null2String(""+RecordSet.getString("docmouldid"));
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
/*���ڰѸ�������Ӵ����ĵ�����Աȷ���ĳ������û��Զ���ķ�ʽ.*/
 String hasaccessory =Util.toScreen(RecordSet.getString("hasaccessory"),user.getLanguage());
 int accessorynum = Util.getIntValue(RecordSet.getString("accessorynum"),user.getLanguage());
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

//Ȩ�޼��
/************************************************************************************************/
//�����Ѿ�������ͬ��Ȩ�ޣ����ﲻ��Ҫ�ټ���ĵ���Ȩ��
/*
    boolean  canEdit = false;
	int sharelevel=0;
    String logintype = user.getLogintype() ;
    String userid = "" +user.getUID() ;

    if(logintype.equals("1")) {

        RecordSet.executeSql("select sourceid,sharelevel from "+tables+" a  where sourceid="+docid);

    }
    else {
        RecordSet.executeSql("select sourceid,sharelevel from "+tables+" a where sourceid="+docid);
    }

    if(RecordSet.next()) {
        sharelevel = Util.getIntValue(RecordSet.getString(1),0) ;
        if(sharelevel>1) canEdit = true ;
    }

    if(!canEdit)  {
        response.sendRedirect("/notice/noright.jsp") ;
	    return ;
    }
*/

temStr="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

temStr+=SystemEnv.getHtmlLabelName(401,user.getLanguage())+":"+doccreatedate+" "+doccreatetime+" "+SystemEnv.getHtmlLabelName(623,user.getLanguage())+":"+Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),user.getLanguage())+SystemEnv.getHtmlLabelName(103,user.getLanguage())+":"+doclastmoddate+" "+doclastmodtime+" "+SystemEnv.getHtmlLabelName(623,user.getLanguage())+":"+Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),user.getLanguage());




String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(89,user.getLanguage())+SystemEnv.getHtmlLabelName(614,user.getLanguage())+":"+Util.add0(docid,12)+"    "+temStr;
String needfav ="1";
String needhelp ="";

if(docstatus.equals("0")){
    docEditType = "1";
}else{
    docEditType = "2";
}
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script LANGUAGE="JavaScript" SRC="/js/checkinput.js"></script>
<SCRIPT language="javascript" src="/js/weaver.js"></script>

</head>
<script>
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

function WebSaveLocal(){
  try{
    weaver.WebOffice.WebSaveLocal();
    StatusMsg(weaver.WebOffice.Status);
  }catch(e){}
}

function WebOpenLocal(){
  try{
    weaver.WebOffice.WebOpenLocal();
    StatusMsg(weaver.WebOffice.Status);
  }catch(e){
  }
}
function Load(){
  try{
  weaver.WebOffice.WebUrl="<%=mServerUrl%>";
  weaver.WebOffice.RecordID="<%=(versionId==0?"":versionId+"")%>";
  weaver.WebOffice.Template="";
  weaver.WebOffice.FileName="<%=fileName%>";
  weaver.WebOffice.FileType="<%=filetype%>";
<%if(isIWebOffice2006 == true){%>
//iWebOffice2006 �������ݿ�ʼ
  weaver.WebOffice.EditType="0,0";
  weaver.WebOffice.ShowToolBar="0";      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
//iWebOffice2006 �������ݽ���
<%}else{%>
  weaver.WebOffice.EditType="0";
<%}%>
  weaver.WebOffice.UserName="<%=user.getUsername()%>";
  weaver.WebOffice.WebOpen();  	//�򿪸��ĵ�
<%if(isIWebOffice2006 == true){%>
//iWebOffice2006 �������ݿ�ʼ
  weaver.WebOffice.ShowType="1";  //�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
//iWebOffice2006 �������ݽ���
<%}%>
  StatusMsg(weaver.WebOffice.Status);
  weaver.WebOffice.UserName="<%=user.getUID()%>";
  clsDT = new clsDateTime();
  }catch(e){
      alert("error");
  }
}

function UnLoad(){
  try{
  if (!weaver.WebOffice.WebClose()){
     StatusMsg(weaver.WebOffice.Status);
  }else{
     StatusMsg("�ر��ĵ�...");
  }
  }catch(e){}
  return false;
}

function WebOpenSignature(){
  try{
    weaver.WebOffice.WebOpenSignature();
    StatusMsg(weaver.WebOffice.Status);
    return true;
  }catch(e){
      return false;
  }
}

function SaveDocument(){
  //weaver.WebOffice.FileName=weaver.docsubject.value+"<%=filetype%>";
  weaver.WebOffice.WebSetMsgByName("SAVETYPE","EDIT");
  if (!weaver.WebOffice.WebSave(<%=isNoComment%>)){
     StatusMsg(weaver.WebOffice.Status);
     alert("<%=SystemEnv.getHtmlLabelName(19007,user.getLanguage())%>");
     return false;
  }else{
     StatusMsg(weaver.WebOffice.Status);
     //alert(weaver.WebOffice.WebGetMsgByName("CREATEID"));
     //weaver.docId.value=weaver.WebOffice.WebGetMsgByName("CREATEID");
     //weaver.docType.value=weaver.WebOffice.WebGetMsgByName("DOCTYPE");
     //alert(weaver.docId.value);
     //alert(weaver.docType.value);

     return true;
  }
}

</script>

</head>
<BODY id="mybody" onload="Load()" onunload="UnLoad()">
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
/** Commented by Charoes Huang For View Page
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:onSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!docstatus.equals("3") && !docstatus.equals("4")) {
RCMenu += "{"+SystemEnv.getHtmlLabelName(220,user.getLanguage())+",javascript:onDraft(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(221,user.getLanguage())+",javascript:onPreview(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
 */
//RCMenu += "{"+SystemEnv.getHtmlLabelName(222,user.getLanguage())+",javascript:onHtml(this),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(224,user.getLanguage())+",javascript:showHeader(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(HrmUserVarify.checkUserRight("HrmContractEdit:Edit", user)){
RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+",javascript:onEdit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
if(Util.dayDiff(today,enddate)==aheaddate ||Util.dayDiff(today,proenddate)==aheaddate){
RCMenu += "{"+SystemEnv.getHtmlLabelName(15781,user.getLanguage())+",javascript:oninfo(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
/*
if(HrmUserVarify.checkUserRight("HrmContractEdit:Edit", user)){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/hrm/contract/contract/HrmContract.jsp,_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}*/
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<B><%=SystemEnv.getHtmlLabelName(401,user.getLanguage())%>:</B><%=doccreatedate%>&nbsp;<%=doccreatetime%>&nbsp<B>
  <%=SystemEnv.getHtmlLabelName(623,user.getLanguage())%>:</B><A href="/hrm/resource/HrmResource.jsp?id=<%=doccreaterid%>"><%=Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),user.getLanguage())%></A>
 <B><%=SystemEnv.getHtmlLabelName(103,user.getLanguage())%>:</B><%=doclastmoddate%>&nbsp;<%=doclastmodtime%>&nbsp<B>
  <%=SystemEnv.getHtmlLabelName(623,user.getLanguage())%>:</B><A href="/hrm/resource/HrmResource.jsp?id=<%=doclastmoduserid%>"><%=Util.toScreen(ResourceComInfo.getResourcename(""+doclastmoduserid),user.getLanguage())%></A>
</DIV>
<FORM id=weaver name=weaver action="/docs/docs/UploadDoc.jsp" method=post enctype="multipart/form-data">
<input class=inputstyle type=hidden name=docapprovable value="<%=needapprovecheck%>">
<input class=inputstyle type=hidden name=isreply value="<%=isreply%>">
<input class=inputstyle type=hidden name=replydocid value="<%=replydocid%>">

<input class=inputstyle type=hidden name=docreplyable value="<%=replyable%>">
<input class=inputstyle type=hidden name=docstatus value="0">
<input class=inputstyle type=hidden name=olddocstatus value="<%=docstatus%>">
<input class=inputstyle type=hidden name=doccreaterid value="<%=doccreaterid%>">
<input class=inputstyle type=hidden name=doccreatedate value="<%=doccreatedate%>">
<input class=inputstyle type=hidden name=doccreatetime value="<%=doccreatetime%>">
<input class=inputstyle type=hidden name=docapproveuserid value="<%=docapproveuserid%>">
<input class=inputstyle type=hidden name=docapprovedate value="<%=docapprovedate%>">
<input class=inputstyle type=hidden name=docapprovetime value="<%=docapprovetime%>">
<input class=inputstyle type=hidden name=docarchiveuserid value="<%=docarchiveuserid%>">
<input class=inputstyle type=hidden name=docarchivedate value="<%=docarchivedate%>">
<input class=inputstyle type=hidden name=docarchivetime value="<%=docarchivetime%>">
<input class=inputstyle type=hidden name=usertype value="<%=usertype%>">
<input class=inputstyle type=hidden name="ownerid" value="<%=ownerid%>">
<input class=inputstyle type=hidden name="oldownerid" value="<%=ownerid%>">
<input class=inputstyle type=hidden name="docdepartmentid" value="<%=docdepartmentid%>">
<input class=inputstyle type=hidden name=doclangurage value="<%=doclangurage%>">
<input class=inputstyle type=hidden name=urlfrom value=hr>
<input class=inputstyle type=hidden name=typeid value=<%=typeid%>>

<%
if(!publishable.trim().equals("") && !publishable.trim().equals("0")){
%>
<TABLE class=viewform>
<TBODY>
<tr>
<td width=15%><b><%=SystemEnv.getHtmlLabelName(114,user.getLanguage())%></b></td>
<td width=40%>
<%
String ischeck1="";
String ischeck2="";
String ischeck3="";
if(docpublishtype.equals("1")) ischeck1=" checked";

if(docpublishtype.equals("2")) {
	ischeck2=" checked";
	int tmppos = doccontent.indexOf("!@#$%^&*");
	if(tmppos!=-1){
		docmain = doccontent.substring(0,tmppos);
		doccontent = doccontent.substring(tmppos+8,doccontent.length());
	}
}

if(docpublishtype.equals("3")) ischeck3=" checked";
%>
<input class=inputstyle type=radio name="docpublishtype" value=1 <%=ischeck1%> onclick="onshowdocmain(0)"><font color=red><%=SystemEnv.getHtmlLabelName(1984,user.getLanguage())%></font>
<input class=inputstyle type=radio name="docpublishtype" value=2 <%=ischeck2%> onclick="onshowdocmain(1)"><font color=red><%=SystemEnv.getHtmlLabelName(227,user.getLanguage())%></font>
<input class=inputstyle type=radio name="docpublishtype" value=3 <%=ischeck3%> onclick="onshowdocmain(0)"><font color=red><%=SystemEnv.getHtmlLabelName(229,user.getLanguage())%></font>
</td>
</tbody>
</table>
<%}%>

<div id=oDiv style="display:''">
<TABLE class=viewform>
  <COLGROUP>
  <COL width="15%">
  <COL width=35%>
  <COL width="15%">
  <COL width=35%>
  <TBODY>
  <TR class=spacing>
    <TD class=line1 colspan=4>
    </TD>
  </TR>
  <tr>
    <td><%=SystemEnv.getHtmlLabelName(15776,user.getLanguage())%></td>
    <td class=field>
        <SPAN id=contractmanspan><%=ResourceComInfo.getResourcename(contractman)%>
      </SPAN>
      <input class=inputstyle type=hidden id=contractman name=contractman value="<%=contractman%>">
    </td>
  </tr>
  <TR><TD class=Line colSpan=2></TD></TR>
  <tr>
    <td><%=SystemEnv.getHtmlLabelName(15777,user.getLanguage())%></td>
    <td class=field>
      <SPAN id=contractstartdatespan ><%=startdate%></SPAN> -
      <SPAN id=contractenddatespan ><%=enddate%></SPAN>
      <input class=inputstyle type="hidden" name="contractstartdate" value="<%=startdate%>">
      <input class=inputstyle type="hidden" name="contractenddate" value="<%=enddate%>">
    </td>
  </tr>
  <TR><TD class=Line colSpan=2></TD></TR>
<%
  if(ishrm.equals("1")){
%>
  <tr>
    <td><%=SystemEnv.getHtmlLabelName(15778,user.getLanguage())%></td>
    <td class=field>
      <SPAN id=proenddatespan ><%=proenddate%></SPAN>
      <input class=inputstyle type="hidden" name="proenddate" value="<%=proenddate%>">
    </td>
  </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
<%
  }
%>
	<!--
	  <tr>
		<td><%=SystemEnv.getHtmlLabelName(66,user.getLanguage())%></td>
		<td class=field>
		  <%=MainCategoryComInfo.getMainCategoryname(""+maincategory)%>
		  <input class=inputstyle type=hidden name=maincategory value="<%=maincategory%>">
		</td>
	  </tr>
	  <TR><TD class=Line colSpan=2></TD></TR>
	  <tr>
		<td><%=SystemEnv.getHtmlLabelName(67,user.getLanguage())%></td>
		<td class=field>
		  <%=SubCategoryComInfo.getSubCategoryname(""+subcategory)%>
		  <input class=inputstyle type=hidden name=subcategory value="<%=subcategory%>">
		</td>
	  </tr>
	  <TR><TD class=Line colSpan=2></TD></TR>
	  <tr>
		<td><%=SystemEnv.getHtmlLabelName(68,user.getLanguage())%></td>
		<td class=field>
		  <%=SecCategoryComInfo.getSecCategoryname(""+seccategory)%>
		  <input class=inputstyle type=hidden name=seccategory value="<%=seccategory%>">
		</td>
	  </tr>
	-->
  </tbody>
  </table>
</div>

<div id=noDiv style="display:none">
<TABLE class=viewform>
<TBODY>
<TR class=spacing><TD class=line1 colspan=4></TD></TR>
<tr>
<%
int needtr=0;
if(!hashrmres.trim().equals("0")&&!hashrmres.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(179,user.getLanguage());
	if(!hrmreslabel.trim().equals("")) curlabel = hrmreslabel;
%>
<td width=15%><%=curlabel%></td>
<td width=35% class=field>
  <button class=Browser onClick="onShowHrmresID(<%=hashrmres%>)"></button>
  <span id=hrmresspan>
  <%if(hashrmres.equals("2"))
  	needinputitems += ",hrmresid";
  %>
  <A href="/hrm/resource/HrmResource.jsp?id=<%=hrmresid%>"><%=Util.toScreen(ResourceComInfo.getResourcename(""+hrmresid),user.getLanguage())%></A>
  </span>
    <input class=inputstyle type=hidden name=hrmresid value="<%=hrmresid%>">
</td>

  <%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>
<%
if(!hasasset.trim().equals("0")&&!hasasset.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(535,user.getLanguage());
	if(!assetlabel.trim().equals("")) curlabel = assetlabel;
%>
<td width=20%><%=curlabel%></td>
<td width=30% class=field>
  <button class=Browser onClick="onShowAssetId(<%=hasasset%>)"></button>
  <span id=assetidspan>
  <%if(hasasset.equals("2"))
  	needinputitems += ",assetid";
  %>
   <A href="/cpt/capital/CapitalBrowser.jsp?id=<%=assetid%>"><%=Util.toScreen(CapitalComInfo.getCapitalname(""+assetid),user.getLanguage())%></A>
  </span>
  <input class=inputstyle type=hidden name=assetid value="<%=assetid%>">
</td>

<%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>
<%
if(!hascrm.trim().equals("0")&&!hascrm.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(147,user.getLanguage());
	if(!crmlabel.trim().equals("")) curlabel = crmlabel;
%>
<td width=15%><%=curlabel%></td>
<td width=35% class=field>
  <button class=Browser onClick="onShowCrmID(<%=hascrm%>)"></button>
  <span id=crmidspan>
  <%if(hascrm.equals("2"))
  	needinputitems += ",crmid";
  %>
  <a href="/CRM/data/Viewcustomer.jsp?CustomerID=<%=crmid%>"><%=Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+crmid),user.getLanguage())%></a>
  </span>
  <input class=inputstyle type=hidden name=crmid value="<%=crmid%>">
</td>
<%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>
<%
if(!hasitems.trim().equals("0")&&!hasitems.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(145,user.getLanguage());
	if(!itemlabel.trim().equals("")) curlabel = itemlabel;
%>
<td width=15%><%=curlabel%></td>
<td width=35% class=field>
   <button class=Browser onClick="onShowItemID(<%=hasitems%>)"></button>
  <span id=itemspan>
  <%if(hasitems.equals("2")){
  	needinputitems += ",itemid";
  }
  %>
  <A href='/lgc/asset/LgcAsset.jsp?paraid=<%=itemid%>'><%=AssetComInfo.getAssetName(""+itemid)%></a>
  </span>
  <input class=inputstyle type=hidden name=itemid value="<%=itemid%>">
</td>
<%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>
<%if(!hasproject.trim().equals("0")&&!hasproject.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(101,user.getLanguage());
	if(!projectlabel.trim().equals("")) curlabel = projectlabel;
%>
<td width=15%><%=curlabel%></td>
<td width=35% class=field>
  <button class=Browser onClick="onShowProjectID(<%=hasproject%>)"></button>
  <span id=projectidspan>
  <%if(hasproject.equals("2"))
  	needinputitems += ",projectid";
  %>
  <A href="/proj/data/ViewProject.jsp?ProjID=<%=projectid%>"><%=Util.toScreen(ProjectInfoComInfo.getProjectInfoname(""+projectid),user.getLanguage())%></a>
  </span>
    <input class=inputstyle type=hidden name=projectid value="<%=projectid%>">
</td>
<%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>
<%
if(!hasfinance.trim().equals("0")&&!hasfinance.trim().equals("")){
	String curlabel = SystemEnv.getHtmlLabelName(189,user.getLanguage());
	if(!financelabel.trim().equals("")) curlabel = financelabel;
%>
<td width=15%><%=curlabel%></td>
<td width=35% class=field>
  <button class=Browser></button>
    <input class=inputstyle type=hidden name=financeid value="<%=financeid%>">
</td>
<%
if(needtr==1){ out.print("</tr><tr>");needtr=0;}
else needtr++;
}%>

<%
if(!hasaccessory.trim().equals("")){
	int i= 0;
	DocImageManager.resetParameter();
	DocImageManager.setDocid(docid);
	DocImageManager.selectDocImageInfo();
	while(DocImageManager.next()){
		String curimgid = DocImageManager.getImagefileid();
		String curimgname = DocImageManager.getImagefilename();
//	while(i<accessorynum){
		i++;
		String curlabel = SystemEnv.getHtmlLabelName(156,user.getLanguage())+i;
%>
<tr>
<td width=15%><%=curlabel%></td>
<td colspan=3 class=field>
<a href="/weaver/weaver.file.FileDownload?fileid=<%=curimgid%>"><%=curimgname%></a>&nbsp;

</td>
</tr>
<%
	}
	%>
	<input class=inputstyle type=hidden name=accessorynum value="<%=(accessorynum-i)%>">
	<%
	int j=0;
	while(j<(accessorynum-i)){
	j++;
	String curlabel = SystemEnv.getHtmlLabelName(156,user.getLanguage())+(i+j);
%>
<tr>
<td width=15%><%=curlabel%></td>
<td colspan=3 class=field>
<input class=inputstyle type=file size=60 name=accessory<%=j%>>
</td>
</tr>
<%
	}

}%>
</tbody>
</table>

</div>

<script language=javascript>
function showHeader(){
	if(oDiv.style.display=='')
		oDiv.style.display='none';
	else
		oDiv.style.display='';
}
</script>
<TABLE class=viewform>
<TBODY>
<TR class=spacing><TD class=line1 colspan=2></TD></TR>
<tr>
<td width=15%><%=SystemEnv.getHtmlLabelName(229,user.getLanguage())%></td>
<td width=85% class=field>
<%=docsubject%>
<SPAN id=docsubjectspan></SPAN>
<%needinputitems += ",docsubject";%>
</td>
</tr>
<tr id=otrtmp <%if(!docpublishtype.equals("2")){%>style="display:none"<%}%>>
<td width=20%><%=SystemEnv.getHtmlLabelName(341,user.getLanguage())%></td>
<td width=80% class=field>
<input class=inputstyle  size=70 name="docmain" value="<%=docmain%>" onChange="checkinput('docmain','docmainspan')" >
<SPAN id="docmainspan">
</SPAN>
<%
//needinputitems += ",docmain";
%>
</td>
</tr>
</tbody>
</table>

<TABLE class=viewform>
<TBODY>
<TR class=spacing>
<TD class=line1 colspan=2></TD></TR>



<div style="POSITION: relative;width:100%;height:660;OVERFLOW:hidden;">
    <OBJECT  id="WebOffice" style="POSITION: relative;top:-20" width="100%"  height="680"  value="" classid="<%=mClassId%>" codebase="<%=mClientUrl%>" >
    </OBJECT>
</div>

<tr><td colspan = 2>
    <span id=StatusBar>&nbsp;</span>
</td>
</TR>
</TBODY>
</TABLE>

<script language=vbs>
sub onShowLanguage()
	id = window.showModalDialog("/systeminfo/language/LanguageBrowser.jsp")
	language.innerHtml = id(1)
	weaver.doclangurage.value=id(0)
end sub
</script>
<input class=inputstyle type=hidden name=operation>
<input class=inputstyle type=hidden name=id value="<%=docid%>">
<input class=inputstyle type=hidden name=delimgid>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>

<script language=vbs>
sub onShowResource()

	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	    if id(0)<> "" then
			contractmanspan.innerHtml = "<a href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</a>"
			weaver.contractman.value=id(0)
			weaver.contractman.value=id(1)
			else
			contractmanspan.innerHtml = " <IMG src='/images/BacoError.gif' align=absMiddle>"
			weaver.contractman.value=""

		end if
		 mybody.onbeforeunload=null
		weaver.action="HrmContractEditExt.jsp?id=<%=id%>&contractman="&id(0)
		weaver.submit()
	end if

end sub
sub onShowHrmresID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
		if id(0)<> "" then
			hrmresspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
			weaver.hrmresid.value=id(0)
		else
			if objval="2" then
				hrmresspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				hrmresspan.innerHtml =""
			end if
			weaver.hrmresid.value=""
		end if
	end if
end sub

sub onShowAssetId(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpt/capital/CapitalBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	assetidspan.innerHtml = "<A href='/cpt/capital/CapitalBrowser.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaver.assetid.value=id(0)
	else
		if objval="2" then
				assetidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				assetidspan.innerHtml =""
			end if
	weaver.assetid.value="0"
	end if
	end if
end sub

sub onShowItemID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/asset/LgcAssetBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	itemspan.innerHtml = "<A href='/lgc/asset/LgcAsset.jsp?paraid="&id(0)&"'>"&id(1)&"</A>"
	weaver.itemid.value=id(0)
	else
		if objval="2" then
				itemspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				itemspan.innerHtml =""
			end if
	weaver.itemid.value="0"
	end if
	end if
end sub

sub onShowItemmaincategoryID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/maintenance/LgcAssortmentBrowserAll.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	itemmaincategorypan.innerHtml = id(1)
	weaver.itemmaincategoryid.value=id(0)
	else
		if objval="2" then
				itemmaincategorypan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				itemmaincategorypan.innerHtml =""
			end if
	weaver.itemmaincategoryid.value="0"
	end if
	end if
end sub


sub onShowCrmID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	crmidspan.innerHtml = "<A href='/CRM/data/ViewCustomer.jsp?CustomerID="&id(0)&"'>"&id(1)&"</A>"
	weaver.crmid.value=id(0)
	else
		if objval="2" then
				crmidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				crmidspan.innerHtml =""
			end if
	weaver.crmid.value="0"
	end if
	end if
end sub

sub onShowProjectID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	projectidspan.innerHtml = "<A href='/proj/data/ViewProject.jsp?ProjID="&id(0)&"'>"&id(1)&"</A>"
	weaver.projectid.value=id(0)
	else
	if objval="2" then
				projectidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				projectidspan.innerHtml =""
			end if
	weaver.projectid.value="0"
	end if
	end if
end sub
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<script language="javascript">
function onshowdocmain(vartmp){
	if(vartmp==1)
		otrtmp.style.display='';
	else
		otrtmp.style.display='none';
}
function openVersion(vid){
    docVersion(vid);
}

function onshowdocmain(vartmp){
	if(vartmp==1)
		otrtmp.style.display='';
	else
		otrtmp.style.display='none';
}

<%--Add by Charoes Huang ON May 21,2004--%>
function checkDateValidity(){
    var isValid = false;
    isValid = checkDateRange(weaver.contractstartdate,weaver.contractenddate,"<%=SystemEnv.getHtmlLabelName(16721,user.getLanguage())%>")<%if(ishrm.equals("1")){%>&&checkDateBetween(weaver.contractstartdate.value,weaver.proenddate.value,weaver.contractenddate.value,"<%=SystemEnv.getHtmlLabelName(17411,user.getLanguage())%>")<%}%>;
    return isValid;
}

function onSave(obj){
	if(check_form(document.weaver,'<%=needinputitems%>')&&checkDateValidity()){

        document.weaver.docstatus.value=1;
        document.weaver.operation.value='editsave';
        if(SaveDocument()){
            mybody.onbeforeunload=null;
            obj.disabled = true ;
            document.weaver.submit();
        }
    }
}

function onSaveNewVersion(obj){
    if(check_form(document.weaver,'<%=needinputitems%>')&&checkDateValidity()){
        document.weaver.docstatus.value=1;
        document.weaver.operation.value='editsave';
        if(SaveDocumentNewV()){
            mybody.onbeforeunload=null;
            obj.disabled = true ;
            document.weaver.submit();
        }
    }
}


function onDraft(obj){
	if(check_form(document.weaver,'<%=needinputitems%>')&&checkDateValidity()){
        document.weaver.docstatus.value=0;
        document.weaver.operation.value='editdraft';
        if(SaveDocument()){
            mybody.onbeforeunload=null;
            obj.disabled = true ;
            document.weaver.submit();
        }
	}
}

function onPreview(obj){
    if(check_form(document.weaver,'<%=needinputitems%>')&&checkDateValidity()){
        document.weaver.docstatus.value=0;
        document.weaver.operation.value='editpreview';
        if(SaveDocument()){
            mybody.onbeforeunload=null;
            obj.disabled = true ;
            document.weaver.submit();
        }
	}
}

function onDelpic(imgid){
	document.weaver.operation.value='delpic';
	document.weaver.delimgid.value=imgid;
	document.weaver.submit();
}

function onHtml(thiswin){
	if(document.weaver.doccontent.style.display==''){
		text = document.weaver.doccontent.value;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML=text;
		document.weaver.doccontent.style.display='none';
		divifrm.style.display='';
	}
	else{
		text = document.frames("dhtmlFrm").document.tbContentElement.DocumentHTML;
		text = text.replace("Microsoft DHTML Editing Control","Weaver DHTML Editing Control");
		document.weaver.doccontent.value=text;
		document.weaver.doccontent.style.display='';
		divifrm.style.display='none';
	}
}

accessorynum = 2 ;
function addannexRow()
{
	ncol = rewardTable.cols;
	oRow = rewardTable.insertRow();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell();
		oCell.style.height=24;
		switch(j) {
             case 0:
				var oDiv = document.createElement("div");
				var sHtml = "����";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
            case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input type=file size=70 name='accessory"+accessorynum+"'>";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;

		}
	}
	accessorynum = accessorynum*1 +1;
	document.weaver.accessorynum.value = accessorynum ;
}

function oninfo(){
  if(confirm("<%=SystemEnv.getHtmlLabelName(15782,user.getLanguage())%>")){
    location="HrmContractOperation.jsp?id=<%=id%>";
  }
}

function onEdit(){
    location = "HrmContractEditExt.jsp?id=<%=id%>";
}
</script>

</body>