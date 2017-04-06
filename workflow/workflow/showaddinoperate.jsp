<%@page import="com.weaver.integration.util.IntegratedSapUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.interfaces.workflow.action.Action" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="UrlComInfo" class="weaver.workflow.field.UrlComInfo" scope="page" />
<jsp:useBean id="bci" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<jsp:useBean id="ResourceConditionManager" class="weaver.workflow.request.ResourceConditionManager" scope="page"/>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<jsp:useBean id="DMLActionBase" class="weaver.workflow.dmlaction.commands.bases.DMLActionBase" scope="page" />
<jsp:useBean id="wsActionManager" class="weaver.workflow.action.WSActionManager" scope="page" />
<jsp:useBean id="sapActionManager" class="weaver.workflow.action.SapActionManager" scope="page" />
<jsp:useBean id="baseAction" class="weaver.workflow.action.BaseAction" scope="page" />
<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<STYLE TYPE="text/css">
.btn_actionList
{
	BORDER-RIGHT: #7b9ebd 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7b9ebd 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde); BORDER-LEFT: #7b9ebd 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7b9ebd 1px solid 
} 
</STYLE>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</HEAD>
<SCRIPT LANGUAGE="JavaScript">
	var fieldurl;
	var fieldtempurl = "";
</SCRIPT>
<%
int design = Util.getIntValue(request.getParameter("design"),0);
int wfid = Util.getIntValue(request.getParameter("wfid"),0);
int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);
int linkid = Util.getIntValue(request.getParameter("linkid"),0);
int formid=Util.getIntValue(request.getParameter("formid"),0);
String isbill =""+Util.getIntValue(request.getParameter("isbill"),0);
int istemplate = Util.getIntValue(request.getParameter("istemplate"),0);
boolean hascon = false;
//�������ļ�������û�����ѡ���Action�б�
boolean isDmlAction = GCONST.isDMLAction();
boolean isWsAction = GCONST.isWsAction();
boolean isSapAction = GCONST.isSapAction();
boolean isnodeafter = false;//�ǽڵ�����ã��������ֳ�������
if(nodeid>0 && linkid <=0){
	isnodeafter = true;
}

//td37970 start
if(design==1) {
%>
<body  id="addInOperateBody" onbeforeunload="designOnClose()">
<%
}
else {
%>
<body  id="addInOperateBody" onbeforeunload="onClose()">
<%
}
//td37970 end

String rejectBackFlg = Util.null2String(request.getParameter("rejectBackFlg"));

String sql="";
if(formid==0){
	sql = " select * from workflow_base where id = "+wfid;
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		formid = RecordSet.getInt("formid");
		isbill = RecordSet.getString("isbill");
		istemplate = RecordSet.getInt("istemplate");
	}
}
ArrayList fieldids = new ArrayList();
fieldids.clear();
ArrayList fieldnames = new ArrayList();
fieldnames.clear();
ArrayList fieldlabels = new ArrayList();
fieldlabels.clear();
ArrayList fieldhtmltypes = new ArrayList();
fieldhtmltypes.clear();
ArrayList fieldtypes = new ArrayList();
fieldtypes.clear();
ArrayList fielddbtypes = new ArrayList();
fielddbtypes.clear();

String allOptions = "";
String op1Options = "";
String op2Options = "";
String objOptions = "";
String operOptions = "";

op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15618,user.getLanguage()) +"','0');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15619,user.getLanguage()) +"','0');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15620,user.getLanguage()) +"','0');";
operOptions += "operList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(104,user.getLanguage()) +"','0');";
operOptions += "operList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15621,user.getLanguage()) +"(+)','1');";
operOptions += "operList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15622,user.getLanguage())+"(-)','2');";
operOptions += "operList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15623,user.getLanguage())+"(*)','3');";
operOptions += "operList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15624,user.getLanguage())+"(/)','4');";

Hashtable billDetailTable_hs = new Hashtable();
int groupCount_bill = 0;
if(isbill.equals("0")){
	sql = "select workflow_formdict.fielddbtype as fielddbtype,workflow_formfield.isdetail,workflow_formfield.fieldid as id,fieldname as name,workflow_fieldlable.fieldlable as label,workflow_formdict.fieldhtmltype as htmltype,workflow_formdict.type as type, -1 as groupid, '' as detailtable from workflow_formfield,workflow_formdict,workflow_fieldlable where workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.isdefault = '1' and workflow_fieldlable.fieldid =workflow_formfield.fieldid and workflow_formdict.id = workflow_formfield.fieldid and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formdict.fieldhtmltype<>7 and workflow_formfield.formid="+formid;
	//��ϸ�ֶ�Ҳ�������ڵ�󸽼Ӳ��� modify by myq 2008.1.2 start
	sql += " union select workflow_formdictdetail.fielddbtype as fielddbtype,workflow_formfield.isdetail,workflow_formfield.fieldid as id,fieldname as name,workflow_fieldlable.fieldlable as label,workflow_formdictdetail.fieldhtmltype as htmltype,workflow_formdictdetail.type as type, workflow_formfield.groupid as groupid, '' as detailtable from workflow_formfield,workflow_formdictdetail,workflow_fieldlable where workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.isdefault = '1' and workflow_fieldlable.fieldid =workflow_formfield.fieldid and workflow_formdictdetail.id = workflow_formfield.fieldid and workflow_formfield.isdetail='1' and workflow_formfield.formid="+formid;
	//��ϸ�ֶ�Ҳ�������ڵ�󸽼Ӳ��� modify by myq 2008.1.2 end
	String dbType = RecordSet.getDBType();
	if(dbType.equals("oracle")) sql += " order by isdetail desc";
	else sql += " order by isdetail asc";
}
else if(isbill.equals("1"))
	sql = "select fielddbtype as fielddbtype,viewtype as isdetail,id as id,fieldname as name,fieldlabel as label,fieldhtmltype as htmltype,type as type, 0 as groupid, detailtable from workflow_billfield where fieldhtmltype<>7 and billid = "+formid + " order by viewtype,detailtable,dsporder ";
    //System.out.println("sql = " + sql);
RecordSet.executeSql(sql);
while(RecordSet.next()){
	String tmphtmltype = Util.null2String(RecordSet.getString("htmltype"));
	String tmptype = Util.null2String(RecordSet.getString("type"));
	String tmpid = Util.null2String(RecordSet.getString("id"));
	String tmplabel ="";

	int fieldlen=-1;
	String tmpfielddbtype = Util.null2String(RecordSet.getString("fielddbtype"));
	if ((tmpfielddbtype.toLowerCase()).indexOf("varchar")>-1){
		fieldlen = Util.getIntValue(tmpfielddbtype.substring(tmpfielddbtype.indexOf("(")+1,tmpfielddbtype.length()-1));
	}
    //add by wjy ע�͹��ǲ��������������Ĵ�����
	//if(tmphtmltype.equals("4")||tmphtmltype.equals("5"))
	//	continue;
	//if(tmphtmltype.equals("3") && !tmptype.equals("2") && !tmptype.equals("19") )
	//	continue;
	fieldids.add(tmpid);
	fieldnames.add(Util.null2String(RecordSet.getString("name")));
	//�ҿ� 2008.05.06 ʹ��ϸ�ֶ����б��л��������ϸ�� Start
	String isdetail = ""+Util.getIntValue(RecordSet.getString("isdetail"), 0);//td9956 ʹisdetail��Ϊ""��ֻȡ0��1
	//System.out.println("isdetail = " + isdetail);
	String groupid = "";
	if("1".equals(isdetail)){
		if(isbill.equals("1")){
			String detailtable_tmp = Util.null2String(RecordSet.getString("detailtable"));
			if(!"".equals(detailtable_tmp)){
				String groupid_tmp = Util.null2String((String)billDetailTable_hs.get(detailtable_tmp));
				if(!"".equals(groupid_tmp)){
					groupid = ""+Util.getIntValue(groupid_tmp, -1);
				}else{
					groupCount_bill++;
					groupid = ""+groupCount_bill;
					billDetailTable_hs.put(detailtable_tmp, ""+groupCount_bill);
				}
			}else{
				groupid = "";
			}
		}else{
			groupid = ""+Util.getIntValue(RecordSet.getString("groupid"), -1);
		}
	}
	if("-1".equals(groupid)){
		groupid = "";
	}
	if(isbill.equals("1")){
		tmplabel = ""+SystemEnv.getHtmlLabelName(Util.getIntValue(RecordSet.getString("label")),user.getLanguage());
		if("1".equals(isdetail)){
			tmplabel = tmplabel + "(" + SystemEnv.getHtmlLabelName(17463,user.getLanguage()) + ")";
		}
		//System.out.println("tmplabel = " + tmplabel);
		fieldlabels.add(tmplabel);
	}else{
		tmplabel = Util.null2String(RecordSet.getString("label"));
		if("1".equals(isdetail)){
			tmplabel = tmplabel + "(" + SystemEnv.getHtmlLabelName(17463,user.getLanguage()) + ")";
		}
		//System.out.println("tmplabel = " + tmplabel);
		
		fieldlabels.add(tmplabel);
	}
	//�ҿ� 2008.05.06 ʹ��ϸ�ֶ����б��л��������ϸ�� End
	fieldhtmltypes.add(tmphtmltype);
	fieldtypes.add(tmptype);
	fielddbtypes.add(tmpfielddbtype);

	allOptions +="<option value='"+isdetail+"_"+groupid+"_"+tmpid+"_"+tmphtmltype+"_"+tmptype+"'>"+tmplabel+"</option>";
	op1Options += "op1List.options[i++] = new Option('"+tmplabel+"','"+isdetail+"_"+groupid+"_"+tmpid+"_"+tmphtmltype+"_"+tmptype+"');";
	op2Options += "op2List.options[i++] = new Option('"+tmplabel+"','"+isdetail+"_"+groupid+"_"+tmpid+"_"+tmphtmltype+"_"+tmptype+"');";
	objOptions += "objList.options[i++] = new Option('"+tmplabel+"','"+isdetail+"_"+groupid+"_"+tmpid+"_"+tmphtmltype+"_"+tmptype+"_"+fieldlen+"');";
	%>
	<SCRIPT LANGUAGE="JavaScript">
		fieldtempurl = fieldtempurl + "<%="_"+isdetail+"_"+groupid+"_"+tmpid+"_"+tmphtmltype+"_"+tmptype%>" + ":" + "'" + "<%=tmpfielddbtype%>" + "',";
	</SCRIPT>
	<%
}


op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15625,user.getLanguage()) +"','0__-1_3_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15626,user.getLanguage()) +"','0__-2_3_19');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage()) +"1','0__-10_3_19');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage()) +"2','0__-11_3_19');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3','0__-12_3_19');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1','0__-13_3_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2','0__-14_3_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3','0__-15_3_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1','0__-16_1_1');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2','0__-17_1_1');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3','0__-18_1_1');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1','0__-19_1_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2','0__-20_1_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3','0__-21_1_2');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1','0__-22_1_3')";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2','0__-23_1_3');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3','0__-24_1_3');";
op1Options += "op1List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15632,user.getLanguage()) +"','customervalue');";

op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"1','0__-10_3_19');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"2','0__-11_3_19');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3','0__-12_3_19');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1','0__-13_3_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2','0__-14_3_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3','0__-15_3_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1','0__-16_1_1');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2','0__-17_1_1');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3','0__-18_1_1');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1','0__-19_1_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2','0__-20_1_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3','0__-21_1_2');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1','0__-22_1_3');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2','0__-23_1_3');";
op2Options += "op2List.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3','0__-24_1_3');";

objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"1','0__-10_3_19_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"2','0__-11_3_19_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3','0__-12_3_19_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1','0__-13_3_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2','0__-14_3_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3','0__-15_3_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1','0__-16_1_1_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2','0__-17_1_1_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3','0__-18_1_1_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1','0__-19_1_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2','0__-20_1_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3','0__-21_1_2_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1','0__-22_1_3_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2','0__-23_1_3_-1');";
objOptions += "objList.options[i++] = new Option('"+ SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3','0__-24_1_3_-1');";


String tmpfieldop1id = Util.null2String(request.getParameter("fieldop1id"));
String fieldid = Util.null2String(request.getParameter("fieldid"));
//modify by xhheng @20050517 for TD 1833
String htmltype1="";
String type1="";
String fieldop2id = Util.null2String(request.getParameter("fieldop2id"));

String fieldop1id = "0";
if(!tmpfieldop1id.equals("customervalue") && !tmpfieldop1id.equals("otherproperty") && !tmpfieldop1id.equals("0") && !tmpfieldop1id.equals("")){
    tmpfieldop1id = tmpfieldop1id.substring(tmpfieldop1id.indexOf("_",tmpfieldop1id.indexOf("_")+1)+1);
    fieldop1id = tmpfieldop1id.substring(0,tmpfieldop1id.indexOf("_"));
}
char flag =2;


if(!fieldid.equals("0") && !fieldid.equals("")){
  //htmltype1=fieldid.substring(fieldid.indexOf("_")+1,fieldid.lastIndexOf("_"));
  //type1=fieldid.substring(fieldid.lastIndexOf("_")+1);
    fieldid = fieldid.substring(fieldid.indexOf("_", fieldid.indexOf("_")+1)+1);
    int indexFirst=fieldid.indexOf("_");
    int indexSecond=fieldid.indexOf("_",indexFirst+1);
	int indexThird=fieldid.indexOf("_",indexSecond+1);
    
	htmltype1=fieldid.substring(indexFirst+1,indexSecond);
	type1=fieldid.substring(indexSecond+1,indexThird);

	fieldid = fieldid.substring(0,fieldid.indexOf("_"));
}
if(!fieldop2id.equals("0") && !fieldop2id.equals("")){
    fieldop2id = fieldop2id.substring(fieldop2id.indexOf("_", fieldop2id.indexOf("_")+1)+1);
    fieldop2id = fieldop2id.substring(0,fieldop2id.indexOf("_"));
}

String customervalue = Util.null2String(request.getParameter("fieldop1idvalue"));
String operation = Util.null2String(request.getParameter("operation"));
String skipweekend = Util.null2String(request.getParameter("skipweekend"));
String skippubholiday = Util.null2String(request.getParameter("skippubholiday"));
String src = Util.null2String(request.getParameter("src"));

int rules =0;
if(skipweekend.equals("1")){
	rules = rules | 1;
}
if(skippubholiday.equals("1")){
	rules = rules | 2;
}

//ֻ��'�����ϴ�'��'���ĵ�'��'���ĵ�'���������������ã�'�����ϴ�'����������ֻ��'�ĵ���������'����ͨ��htmltypeֱ���жϳ�addin����
if(htmltype1.equals("6")){
  //addin����Ϊ1�������Ǹ����ϴ�,���ĵ������ĵ����ĵ���������
  htmltype1="1";
  customervalue = Util.null2String(request.getParameter("otherProperty6"));
}else if(htmltype1.equals("3")&&(type1.equals("9")||type1.equals("37"))){
  //addin����Ϊ1�������Ǹ����ϴ�,���ĵ������ĵ����ĵ���������
  htmltype1="1";
  customervalue = Util.null2String(request.getParameter("otherProperty6"));
}

else{
  //addin����Ϊ0����������ͨ�ĸ��Ӳ�������
  htmltype1="0";
}

//�������ݿ�
//����dml�ӿ�����
if(src.equals("deletedmlaction")&&istemplate!=1&&(isDmlAction || isWsAction || isSapAction))
{
	String[] checkdmlids = request.getParameterValues("dmlid");
	//zzl
	String[] dmlidnewsaps = request.getParameterValues("dmlidnewsap");
	
	if(null!=dmlidnewsaps)
	{
		for(int j=0;j<dmlidnewsaps.length;j++)
		{
			RecordSet.executeSql("delete int_BrowserbaseInfo where id='"+dmlidnewsaps[j]+"'");
			//������ִ��ɾ��
			sapActionManager.setActionid(Util.getIntValue(dmlidnewsaps[j]));
			sapActionManager.doDeleteSapAction();
		}
		//���¼��һ��
		hascon = baseAction.checkActionOnNodeOrLink(wfid,nodeid,linkid,0);
	}
	
	if(null!=checkdmlids)
	{
		for(int i = 0;i<checkdmlids.length;i++)
		{
			int dmlid = Util.getIntValue(checkdmlids[i],0);
			if(dmlid>0)
			{
				//DMLActionBase.deleteDmlActionFieldMapByActionid(dmlid);
				//DMLActionBase.deleteDmlActionSqlSetByActionid(dmlid);
				//DMLActionBase.deleteDmlActionSetByid(dmlid);
				
				int actiontype_t = Util.getIntValue(request.getParameter("actiontype"+dmlid), -1);
				if(actiontype_t == 0){
					DMLActionBase.deleteDmlActionFieldMapByActionid(dmlid);
					DMLActionBase.deleteDmlActionSqlSetByActionid(dmlid);
					DMLActionBase.deleteDmlActionSetByid(dmlid);
				}else if(actiontype_t == 1){
					wsActionManager.setActionid(dmlid);
					wsActionManager.doDeleteWsAction();
				}else if(actiontype_t == 2){
					sapActionManager.setActionid(dmlid);
					sapActionManager.doDeleteSapAction();
				}
			}
		}
		//hascon = DMLActionBase.checkDMLActionOnNodeOrLink(wfid,nodeid,linkid,0);
		hascon = baseAction.checkActionOnNodeOrLink(wfid,nodeid,linkid,0);
	}
}
//����Ƿ����DMLaction����
if(!hascon&&istemplate!=1&&(isDmlAction || isWsAction || isSapAction))
{
	hascon = DMLActionBase.checkAddinoperateOnNodeOrLink(wfid,nodeid,linkid,0);
}
if(src.equals("delete")){
	String[] checkids = request.getParameterValues("check_node");
	if(checkids!=null){
		for(int i=0;i<checkids.length;i++){
			RecordSet.executeProc("workflow_addinoperate_Delete",""+checkids[i]);
		}

	}
}
if(src.equals("add")){
	if(nodeid!=0)
        RecordSet.executeProc("workflow_addinoperate_Insert",""+nodeid+flag+"1"+flag+wfid+flag+fieldid+flag+fieldop1id+flag+fieldop2id+flag+operation+flag+customervalue+flag+rules+flag+htmltype1+flag+"0");//xwj for td3130 20051122
	else if(linkid!=0)
		RecordSet.executeProc("workflow_addinoperate_Insert",""+linkid+flag+"0"+flag+wfid+flag+fieldid+flag+fieldop1id+flag+fieldop2id+flag+operation+flag+customervalue+flag+rules+flag+htmltype1+flag+"0");//xwj for td3130 20051122

}
    String customeraction="";
    if(src.equals("addInterface")){
	    customeraction = Util.null2String(request.getParameter("interface"));
        if(nodeid!=0){
			RecordSet.executeSql("delete from workflow_addinoperate where objid="+nodeid+" and isnode=1 and type=2 and ispreadd=0");
            RecordSet.executeSql("insert into workflow_addinoperate (objid,workflowid,isnode,type,ispreadd,customervalue) values ("+nodeid+","+wfid+",1,2,0,'"+customeraction+"')");
            hascon = true; //������ýӿڶ�������ѡʱ����"ȷ��"����ɫ��ʶ����ʾ����ˢ��,TD21374
        }
        else if(linkid!=0){
			RecordSet.executeSql("delete from workflow_addinoperate where objid="+linkid+" and isnode=0 and type=2 and ispreadd=0");
            RecordSet.executeSql("insert into workflow_addinoperate (objid,workflowid,isnode,type,ispreadd,customervalue) values ("+linkid+","+wfid+",0,2,0,'"+customeraction+"')");
            hascon = true; //������ýӿڶ�������ѡʱ����"ȷ��"����ɫ��ʶ����ʾ����ˢ��,TD21374
        }

    }
     if(src.equals("delInterface")){
        if(nodeid!=0)
            RecordSet.executeSql("delete from workflow_addinoperate where objid="+nodeid+" and isnode=1 and type=2 and ispreadd=0");
        else if(linkid!=0)
            RecordSet.executeSql("delete from workflow_addinoperate where objid="+linkid+" and isnode=0 and type=2 and ispreadd=0");

    }

	if(src.equals("RejectBackFlg")){
		RecordSet.executeSql("update workflow_flownode set rejectbackflag="+rejectBackFlg+" where workflowid="+wfid+" and nodeid="+nodeid);
	}
	String onRejectBackFlg = "0";
	RecordSet.executeSql("select rejectbackflag from workflow_flownode where workflowid="+wfid+" and nodeid="+nodeid);
	if(RecordSet.next()){
		onRejectBackFlg = Util.null2String(RecordSet.getString("rejectbackflag"));
	}
	
	//������ýӿڶ�������ѡʱ����"ȷ��"����ɫ��ʶ����ʾ����ˢ��,TD21374 start
    String objidsql="";
    if(nodeid!=0)
	    objidsql = "select id from workflow_addinoperate where objid="+nodeid+" and workflowid="+wfid+" and isnode=1 and type=2 and ispreadd=0";
    else if(linkid!=0)
	    objidsql = "select id from workflow_addinoperate where objid="+linkid+" and workflowid="+wfid+" and isnode=0 and type=2 and ispreadd=0";

    if(!"".equals(objidsql)){
	    RecordSet2.executeSql(objidsql);
		if(RecordSet2.next()) {
		   hascon = true; 
		}
    }
	//������ýӿڶ�������ѡʱ����"ȷ��"����ɫ��ʶ����ʾ����ˢ��,TD21374 end
	//zzl
	if(src.equals("refush")){
		//ʲô������,�������İ취����ˢ�»��Զ��ر�ҳ��
	}
%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+",javascript:onSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:submitClear(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%
if(design==1) {
	RCMenu += "{"+SystemEnv.getHtmlLabelName(309,user.getLanguage())+",javascript:designOnClose(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
else {
RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:onClose(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM NAME=SearchForm STYLE="margin-bottom:0" action="showaddinoperate.jsp" method="post">
<input type="hidden" value="<%=wfid%>" id="wfid" name="wfid">
<input type="hidden" value="" id="src" name="src">
<input type="hidden" value="<%=formid%>" id="formid" name="formid">
<input type="hidden" value="<%=nodeid%>" id="nodeid" name="nodeid">
<input type="hidden" value="<%=linkid%>" id="linkid" name="linkid">
<input type="hidden" value="<%=isbill%>" id="isbill" name="isbill">
<input type="hidden" value="<%=design%>" id="design" name="design">
<input type="hidden" value="<%=istemplate%>" id="istemplate" name="istemplate">

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

<table width=100% class="viewform">
<COLGROUP>

   <COL width="20%">
   <COL width="5%">
   <COL width="32%">
   <COL width="11%">
   <COL width="32%">
<TR class="Title">
    	  <TH colSpan=5><%=SystemEnv.getHtmlLabelName(68,user.getLanguage())%></TH></TR>
<TR class="Spacing" style="height: 1px;"><TD class="Line1" colspan=5 style="padding: 0px;"></TD></TR>

<tr>

<td>
<select class=inputstyle  style="width:100%" name=fieldid id=fieldid title="<%=SystemEnv.getHtmlLabelName(15620,user.getLanguage())%>" onchange="changefieldid(this.value);changeTitle('fieldid', this.value);">
<option value=0 ><%=SystemEnv.getHtmlLabelName(15620,user.getLanguage())%></option>
</select>
</td>
<td align=center>
<img src="/images/ArrowEqual.gif" border=0>
</td>
<td>
<select class=inputstyle  style="width:100%"  name=fieldop1id id=fieldop1id title="<%=SystemEnv.getHtmlLabelName(15618,user.getLanguage())%>" onchange="changefieldop1id(this.value);changeTitle('fieldop1id', this.value);">
<option value=0 ><%=SystemEnv.getHtmlLabelName(15618,user.getLanguage())%></option>
<%=allOptions%>
<option value="0__-1_3_2"><%=SystemEnv.getHtmlLabelName(15625,user.getLanguage())%></option>
<option value="0__-2_3_19"><%=SystemEnv.getHtmlLabelName(15626,user.getLanguage())%></option>
<option value="0__-10_3_19"><%=SystemEnv.getHtmlLabelName(15627,user.getLanguage())%>1</option>
<option value="0__-11_3_19"><%=SystemEnv.getHtmlLabelName(15627,user.getLanguage())%>2</option>
<option value="0__-12_3_19"><%=SystemEnv.getHtmlLabelName(15627,user.getLanguage())%>3</option>
<option value="0__-13_3_2"><%=SystemEnv.getHtmlLabelName(15628,user.getLanguage())%>1</option>
<option value="0__-14_3_2"><%=SystemEnv.getHtmlLabelName(15628,user.getLanguage())%>2</option>
<option value="0__-15_3_2"><%=SystemEnv.getHtmlLabelName(15628,user.getLanguage())%>3</option>
<option value="0__-16_1_1"><%=SystemEnv.getHtmlLabelName(15629,user.getLanguage())%>1</option>
<option value="0__-17_1_1"><%=SystemEnv.getHtmlLabelName(15629,user.getLanguage())%>2</option>
<option value="0__-18_1_1"><%=SystemEnv.getHtmlLabelName(15629,user.getLanguage())%>3</option>
<option value="0__-19_1_2"><%=SystemEnv.getHtmlLabelName(15630,user.getLanguage())%>1</option>
<option value="0__-20_1_2"><%=SystemEnv.getHtmlLabelName(15630,user.getLanguage())%>2</option>
<option value="0__-21_1_2"><%=SystemEnv.getHtmlLabelName(15630,user.getLanguage())%>3</option>
<option value="0__-22_1_3"><%=SystemEnv.getHtmlLabelName(15631,user.getLanguage())%>1</option>
<option value="0__-23_1_3"><%=SystemEnv.getHtmlLabelName(15631,user.getLanguage())%>2</option>
<option value="0__-24_1_3"><%=SystemEnv.getHtmlLabelName(15631,user.getLanguage())%>3</option>
<option value=customervalue><%=SystemEnv.getHtmlLabelName(15632,user.getLanguage())%></option>
<option value=otherproperty><%=SystemEnv.getHtmlLabelName(375,user.getLanguage())%>
<%=SystemEnv.getHtmlLabelName(713,user.getLanguage())%></option>
</select>

</td>
<td>
<select class=inputstyle  name=operation id=operation onchange="changeoperation(this.value)">
<option value="0"><%=SystemEnv.getHtmlLabelName(104,user.getLanguage())%></option>
</select>
<input class=Inputstyle type=text name=fieldop1idvalue id = fieldop1idvalue size=8 style="display:none">
<span name=otherPropertyName id=otherPropertyName style="display:none"></span>

</td>
<td>
<select class=inputstyle  style="width:100%" name=fieldop2id id=fieldop2id title="<%=SystemEnv.getHtmlLabelName(15619,user.getLanguage())%>" onchange="changefieldop2id(this.value);changeTitle('fieldop2id', this.value);">
<option value=0><%=SystemEnv.getHtmlLabelName(15619,user.getLanguage())%></option>
</select>
<%
String setAsLabel=SystemEnv.getHtmlLabelName(19561,user.getLanguage());
String statusLabel=SystemEnv.getHtmlLabelName(602,user.getLanguage());
%>
<span name=otherProperty6Value id=otherProperty6Value style="display:none">
  <select class=inputstyle name=otherProperty6 id=otherProperty6>
    <option value=0><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(220,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=2><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(19563,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=3><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(359,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=5><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=6><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(19564,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=7><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(15750,user.getLanguage())%>&quot;<%=statusLabel%></option>
    <option value=8><%=setAsLabel%>&quot;<%=SystemEnv.getHtmlLabelName(15358,user.getLanguage())%>&quot;<%=statusLabel%></option>

  </select>
</span>

</td>

</tr>
<tr>
<td colspan=5>
<BUTTON type='button' class=Browser onclick="showPreDBrowser(urls[curIndex],curIndex)" id = fieldBrowser style="display:none"></BUTTON>
<span id="unitspan"></span>
</td>
</tr>

<TR id=oHeightTenTr  style="display:none">
    <TD height="10" colspan="5"></TD>
</TR>
<TR class="Title"  id=oDescriptionTr style="display:none">
    	  <TH colSpan=5><%=SystemEnv.getHtmlLabelName(15610,user.getLanguage())%></TH></TR>
<TR class="Spacing" id=oLine1Tr style="display:none;height: 1px;"><TD class="Line1" colspan=5></TD></TR>
<Tr id = oDateRuleTr style="display:none">
<td colspan=3>
<input type=checkbox name="skipweekend" value=1><%=SystemEnv.getHtmlLabelName(15633,user.getLanguage())%>
</td><td colspan=2>
<input type=checkbox name="skippubholiday" value=1><%=SystemEnv.getHtmlLabelName(15634,user.getLanguage())%>
</td>
</tr>
</table>
<%if(isnodeafter){%>
<TABLE width=100% class=liststyle cellspacing=1>
<tr>
	<td width="40%"><%=SystemEnv.getHtmlLabelName(22602,user.getLanguage())%>:</td>
	<td width="30%"><input type=radio id="rejectBackFlg" name="rejectBackFlg" value=0 <%if(!onRejectBackFlg.equals("1")){%>checked<%}%> onclick="onRejectBackFlg()"><%=SystemEnv.getHtmlLabelName(21988,user.getLanguage())%></td>
	<td width="30%"><input type=radio id="rejectBackFlg" name="rejectBackFlg" value=1 <%if(onRejectBackFlg.equals("1")){%>checked<%}%> onclick="onRejectBackFlg()"><%=SystemEnv.getHtmlLabelName(21989,user.getLanguage())%></td>
</tr>
</TABLE>
<%}%>
<br>
<table width=100% class=liststyle cellspacing=1  >
<COLGROUP>
   <COL width="5%">
   <COL width="65%">
   <COL width="30%">
<TR class="Header">
    	  <TH colSpan=3><%=SystemEnv.getHtmlLabelName(15635,user.getLanguage())%></TH></TR>
 <TR class=header>
    	  <TH></TH>
    	  <TH><%=SystemEnv.getHtmlLabelName(15636,user.getLanguage())%></TH>
    	  <TH><%=SystemEnv.getHtmlLabelName(15610,user.getLanguage())%></TH>
 </TR>
 <tr class="Line"><th colspan="3"></th></tr>
<%

/*    if(isbill.equals("0"))
        sql = "select workflow_formfield.fieldid as id,fieldname as name,workflow_fieldlable.fieldlable as label,workflow_formdict.fieldhtmltype as htmltype,workflow_formdict.type as type from workflow_formfield,workflow_formdict,workflow_fieldlable where workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.isdefault = 1 and workflow_fieldlable.fieldid =workflow_formfield.fieldid and workflow_formdict.id = workflow_formfield.fieldid and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid;
    else if(isbill.equals("1"))
        sql = "select id as id,fieldname as name,fieldlabel as label,fieldhtmltype as htmltype,type as type from workflow_billfield where billid = "+formid + " order by dsporder ";
    //System.out.println("sql = " + sql);

    String operateSel = "select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,b.fieldhtmltype,b.type,c.tablename,c.columname,c.keycolumname from workflow_addinoperate a ,workflow_formdict b,workflow_browserurl c where a.fieldid=b.id and b.type=c.id and b.";

//if(nodeid!=0)
//	RecordSet.executeProc("workflow_addinoperate_select",""+nodeid+flag+"1");
//else if(linkid!=0)
//	RecordSet.executeProc("workflow_addinoperate_select",""+linkid+flag+"0");*/

String operateSel="";

if(isbill.equals("0")){
    operateSel = "select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,c.tablename,c.columname,c.keycolumname from workflow_addinoperate a ,workflow_formdict b,workflow_browserurl c where a.fieldid=b.id and b.type=c.id and b.fieldhtmltype=3 and a.ispreadd='0' and a.workflowid="+wfid;//xwj for td3130 20051122
    if(nodeid!=0)
			operateSel= operateSel+" and a.objid="+nodeid+" and isnode =1 ";
		else if(linkid!=0)
			operateSel = operateSel+" and a.objid="+linkid+" and isnode =0 ";
    operateSel = operateSel+" union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,c.tablename,c.columname,c.keycolumname from workflow_addinoperate a ,workflow_formdictdetail b,workflow_browserurl c where a.fieldid=b.id and b.type=c.id and b.fieldhtmltype=3 and a.ispreadd='0' and a.workflowid="+wfid;
}else if(isbill.equals("1")){
    operateSel = "select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,c.tablename,c.columname,c.keycolumname from workflow_addinoperate a ,workflow_billfield b,workflow_browserurl c where a.fieldid=b.id and b.type=c.id and b.fieldhtmltype=3 and a.ispreadd='0'";//xwj for td3130 20051122
}

if(nodeid!=0)
	operateSel= operateSel+" and a.objid="+nodeid+" and isnode =1 ";
else if(linkid!=0)
	operateSel = operateSel+" and a.objid="+linkid+" and isnode =0 ";

//add by xhheng @20050311 for TD 1708,��ϲ�ѯ����֤workflow_formdict fieldhtmltype<>3ʱ�����ݷ�������
if(isbill.equals("0")){
    operateSel = operateSel+" union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,'','','' from workflow_addinoperate a ,workflow_formdict b where a.fieldid=b.id and b.fieldhtmltype<>3 and a.ispreadd='0' and a.workflowid="+wfid;//xwj for td3130 20051122
    if(nodeid!=0)
			operateSel= operateSel+" and a.objid="+nodeid+" and isnode =1 ";
		else if(linkid!=0)
			operateSel = operateSel+" and a.objid="+linkid+" and isnode =0 ";
    operateSel = operateSel+" union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,'','','' from workflow_addinoperate a ,workflow_formdictdetail b where a.fieldid=b.id and b.fieldhtmltype<>3 and a.ispreadd='0' and a.workflowid="+wfid;
}else if(isbill.equals("1")){
    operateSel = operateSel+"union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,b.fieldhtmltype,b.type,'','','' from workflow_addinoperate a ,workflow_billfield b where a.fieldid=b.id and b.fieldhtmltype<>3 and a.ispreadd='0'";//xwj for td3130 20051122
}

if(nodeid!=0)
	operateSel= operateSel+" and a.objid="+nodeid+" and isnode =1 ";
else if(linkid!=0)
	operateSel = operateSel+" and a.objid="+linkid+" and isnode =0 ";

//add by xhheng @20050206 for TD 1535,������������ѯ��Ϊunion��ѯ�������ʱ�������ֲ�ѯ
if(isbill.equals("0")){
    operateSel = operateSel + " union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,'0',0,'','','' from workflow_addinoperate a ";
}else if(isbill.equals("1")){
    operateSel = operateSel + " union select a.id,a.fieldid,a.fieldop1id,a.fieldop2id,a.operation,a.customervalue,a.rules,a.type as addintype,'0',0,'','','' from workflow_addinoperate a ";
}

if(nodeid!=0)
	RecordSet.executeSql(operateSel+" where a.objid="+nodeid+" and a.fieldid<0 and isnode =1 and a.ispreadd='0'");//xwj for td3130 20051122
else if(linkid!=0)
	RecordSet.executeSql(operateSel+" where a.objid="+linkid+" and a.fieldid<0 and isnode =0 and a.ispreadd='0'");//xwj for td3130 20051122

int linecolor=0;
while(RecordSet.next()){
    hascon = true;
	int tmpid = RecordSet.getInt("id");
	int tmpfieldid = RecordSet.getInt("fieldid");
	int tmpfield1id = RecordSet.getInt("fieldop1id");
	int tmpfield2id = RecordSet.getInt("fieldop2id");
	int tmpoperation = RecordSet.getInt("operation");
	String tmpcustomervalue = RecordSet.getString("customervalue");
	int tmprules = RecordSet.getInt("rules");
  int addintype= RecordSet.getInt("addintype");

    int htmltype = RecordSet.getInt("fieldhtmltype");
    int type = RecordSet.getInt("type");

    String tablename = RecordSet.getString("tablename");
    String columname = RecordSet.getString("columname");
    String keycolumname = RecordSet.getString("keycolumname");

	String expression="";
	String addrules = "";

	//�����ݿ��е�����ת���ɱ��ʽ
	if(!tmpcustomervalue.equals("")){
    //��ͨ�Ľڵ㡢���ڸ��Ӳ���
    if(addintype==0){
        if(htmltype==3&&type!=19 && type!=2&&type!=162&&type!=161&&type!=141){
        	String[] tempArray = Util.TokenizerString2(tmpcustomervalue,",");
        	for(int i=0;i<tempArray.length;i++){
            String bsql = "select "+columname+" from "+tablename+" where "+keycolumname+" = '"+tempArray[i]+"'";
            //System.out.println("bsql = " + bsql);
            RecordSet2.executeSql(bsql);
            while(RecordSet2.next()){
//                expression += ","+RecordSet2.getString(columname);
                expression += ","+RecordSet2.getString(1);//update by fanggsh 20060804 for  ���������Ϊ����ʱ����

            }
          }
		
            if(!expression.equals("")){
                expression = expression.substring(1);
            }
        }else if(htmltype==3&&type==161){
        	String tempdbtype = (String)fielddbtypes.get(fieldids.indexOf(""+tmpfieldid));
			try{
	            Browser browser=(Browser)StaticObj.getServiceByFullname(tempdbtype, Browser.class);
	            BrowserBean bb=browser.searchById(tmpcustomervalue);
				String desc=Util.null2String(bb.getDescription());
				String name=Util.null2String(bb.getName());
				expression=name;
			}catch(Exception e){
			}			
		}else if(htmltype==3&&type==162){
        	String tempdbtype = (String)fielddbtypes.get(fieldids.indexOf(""+tmpfieldid));
        	try{
	            Browser browser=(Browser)StaticObj.getServiceByFullname(tempdbtype, Browser.class);
				List l=Util.TokenizerString(tmpcustomervalue,",");
	            for(int j=0;j<l.size();j++){
				    String curid=(String)l.get(j);
		            BrowserBean bb=browser.searchById(curid);
					String desc=Util.null2String(bb.getDescription());
					String name=Util.null2String(bb.getName());
				    expression+=name+"&nbsp";
				}
			}catch(Exception e){
			}        		
        }else if(htmltype==3&&type==141){
            expression =  ResourceConditionManager.getFormShowName(tmpcustomervalue,user.getLanguage());
        }else{
            expression =  tmpcustomervalue ;
        }
    }
    //�����ϴ������ĵ������ĵ�  �ĵ�����
    if(addintype==1){

//      expression = "�������ԣ��ĵ�״̬";
//      if(tmpcustomervalue.equals("0"))
//        expression += " ("+SystemEnv.getHtmlLabelName(220,user.getLanguage())+")";
//      if(tmpcustomervalue.equals("2"))
//        expression += " ("+SystemEnv.getHtmlLabelName(225,user.getLanguage())+")";
//      if(tmpcustomervalue.equals("3"))
//        expression += " ("+SystemEnv.getHtmlLabelName(360,user.getLanguage())+")";
//      if(tmpcustomervalue.equals("4"))
//        expression += " ("+SystemEnv.getHtmlLabelName(236,user.getLanguage())+")";
//      if(tmpcustomervalue.equals("5"))
//        expression += " ("+SystemEnv.getHtmlLabelName(251,user.getLanguage())+")";

      if(tmpcustomervalue.equals("0"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(220,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("2"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(19563,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("3"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(359,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("5"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(251,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("6"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(19564,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("7"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(15750,user.getLanguage())+"��"+statusLabel;
      if(tmpcustomervalue.equals("8"))
        expression += setAsLabel+"��"+SystemEnv.getHtmlLabelName(15358,user.getLanguage())+"��"+statusLabel;


	}

  }
	else {
    //��ʽ ��һ����ֵ
		if(tmpfield1id == -1){
			expression = SystemEnv.getHtmlLabelName(15625,user.getLanguage()) ;
		}else if(tmpfield1id == -2){
			expression =  SystemEnv.getHtmlLabelName(15626,user.getLanguage()) ;
		}else if(tmpfield1id == -10){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"1" ;
		}else if(tmpfield1id == -11){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"2" ;
		}else if(tmpfield1id == -12){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3" ;
		}else if(tmpfield1id == -13){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1" ;
		}else if(tmpfield1id == -14){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2" ;
		}else if(tmpfield1id == -15){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3" ;
		}else if(tmpfield1id == -16){
			expression =  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1" ;
		}else if(tmpfield1id == -17){
			expression =  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2" ;
		}else if(tmpfield1id == -18){
			expression =  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3" ;
		}else if(tmpfield1id == -19){
			expression =  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1" ;
		}else if(tmpfield1id == -20){
			expression =  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2" ;
		}else if(tmpfield1id == -21){
			expression =  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3" ;
		}else if(tmpfield1id == -22){
			expression =  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1" ;
		}else if(tmpfield1id == -23){
			expression =  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2" ;
		}else if(tmpfield1id == -24){
			expression =  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3" ;
		}else{
			if(tmpfield1id == 0){//xwj for td3308 on 20051212
			expression = "" ;
		  }
		  else{
		  expression = ""+fieldlabels.get(fieldids.indexOf(""+tmpfield1id));
		  }
		}
    //��ʽ ������
		if(tmpoperation!=0){
			if(tmpoperation==1){
				expression += " + ";
			}else if(tmpoperation==2){
				expression += " - ";
			}else if(tmpoperation==3){
				expression += " * ";
			}else if(tmpoperation==4){
				expression += " / ";
			}
      //��ʽ �ڶ�������
			if(tmpfield2id == -10){
				expression +=  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"1" ;
			}else if(tmpfield2id == -11){
				expression +=  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"2" ;
			}else if(tmpfield2id == -12){
				expression +=  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3" ;
			}else if(tmpfield2id == -13){
				expression +=  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1" ;
			}else if(tmpfield2id == -14){
				expression +=  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2" ;
			}else if(tmpfield2id == -15){
				expression +=  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3" ;
			}else if(tmpfield2id == -16){
				expression +=  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1" ;
			}else if(tmpfield2id == -17){
				expression +=  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2" ;
			}else if(tmpfield2id == -18){
				expression +=  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3" ;
			}else if(tmpfield2id == -19){
				expression +=  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1" ;
			}else if(tmpfield2id == -20){
				expression +=  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2" ;
			}else if(tmpfield2id == -21){
				expression +=  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3" ;
			}else if(tmpfield2id == -22){
				expression +=  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1" ;
			}else if(tmpfield2id == -23){
				expression +=  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2" ;
			}else if(tmpfield2id == -24){
				expression +=  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3" ;
			}else{
				expression += ""+fieldlabels.get(fieldids.indexOf(""+tmpfield2id));
			}
		}
	}


  //��ʽ Ŀ��ֵ
	if(!expression.equals("") || (expression.equals("") && tmpfield1id == 0)){//xwj for td3308 on 20051212
		if(tmpfieldid == -10){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"1 = "+expression;
		}else if(tmpfieldid == -11){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"2 = "+expression;
		}else if(tmpfieldid == -12){
			expression =  SystemEnv.getHtmlLabelName(15627,user.getLanguage())+"3 = "+expression;
		}else if(tmpfieldid == -13){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"1 = "+expression;
		}else if(tmpfieldid == -14){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"2 = "+expression;
		}else if(tmpfieldid == -15){
			expression =  SystemEnv.getHtmlLabelName(15628,user.getLanguage())+"3 = "+expression;
		}else if(tmpfieldid == -16){
			expression =  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"1 = "+expression;
		}else if(tmpfieldid == -17){
			expression =  SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"2 = "+expression;
		}else if(tmpfieldid == -18){
			expression = SystemEnv.getHtmlLabelName(15629,user.getLanguage())+"3 = "+expression;
		}else if(tmpfieldid == -19){
			expression =  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"1 = "+expression;
		}else if(tmpfieldid == -20){
			expression = SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"2 = "+expression;
		}else if(tmpfieldid == -21){
			expression =  SystemEnv.getHtmlLabelName(15630,user.getLanguage())+"3 = "+expression;
		}else if(tmpfieldid == -22){
			expression = SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"1 = "+expression;
		}else if(tmpfieldid == -23){
			expression = SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"2 = "+expression;
		}else if(tmpfieldid == -24){
			expression =  SystemEnv.getHtmlLabelName(15631,user.getLanguage())+"3 = "+expression;
		}else{
			expression =""+fieldlabels.get(fieldids.indexOf(""+tmpfieldid))+" = "+expression;
		}
	}


	if((tmprules & 1) ==1)
		addrules += SystemEnv.getHtmlLabelName(15638,user.getLanguage()) ;
	if((tmprules & 2) ==2)
		addrules += SystemEnv.getHtmlLabelName(15639,user.getLanguage()) ;


%>
 <tr <%if(linecolor==0){%> class=datalight <%} else {%> class=datadark <%}%> >
<td><input type='checkbox' name='check_node' value="<%=tmpid%>" ></td>
<td><%=expression%></td>
<td>
<%=addrules%>
</td>

</tr>
<%
if(linecolor==0) linecolor=1;
          else linecolor=0;
}
    if(nodeid!=0){
		RecordSet.executeSql("select * from workflow_addinoperate where objid="+nodeid+" and isnode=1 and type=2 and ispreadd=0");
    }else if(linkid!=0){
		RecordSet.executeSql("select * from workflow_addinoperate where objid="+linkid+" and isnode=0 and type=2 and ispreadd=0");
	}
    if(RecordSet.next()){
		customeraction=RecordSet.getString("customervalue");
	}

    List l=StaticObj.getServiceIds(Action.class);
	if(!customeraction.equals("")||l.size()>0){
%>
<TR class="Title">
    	  <TH colSpan=5><%=SystemEnv.getHtmlLabelName(20977,user.getLanguage())%></TH></TR>
<TR class="Spacing" style="height: 1px;"><TD class="Line1" colspan=5 style="padding:0px;"></TD></TR>
<tr>
<td nowrap>
<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%>��
</td>
<td colspan="4">
<select name="interface" onchange="onSelectInterface();">
<%

    //System.out.println(l.size());
	if(!customeraction.equals("")){%>

	<option value='<%=customeraction%>' selected><%=customeraction%></option>
	<%}
	for(int i=0;i<l.size();i++){
      if(l.get(i).equals(customeraction)) continue;
%>
<option value='<%=l.get(i)%>'><%=l.get(i)%></option>
<%}%>
</select>
<input type=checkbox name=enableInterface  onclick="checkInterface()" <%if(!customeraction.equals("")){%>checked<%}%>>

</td>
</tr>
<%}%>
<%
String type=IntegratedSapUtil.getIsOpenEcology70Sap();
		if(istemplate!=1&&(isDmlAction || isWsAction || isSapAction)){ %>
		<tr><td colspan="3">
		<table width="100%" class="liststyle" cellspacing="1"  >
			<COLGROUP>
			<COL width="5%">
			<COL width="35%">
			<COL width="35%">
			<COL width="25%">
			<TR class="Spacing" style="height: 1px;"><TD class="Line1" colspan=5 style="padding: 0px;"></TD></TR>
			<TR>
			<td colSpan="3" width="65%">
				<%=SystemEnv.getHtmlLabelName(375,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%>��
				<select id="actionlist" name="actionlist">
					<%if(isDmlAction){%>
					<option value="1">DML<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%></option>
					<%}%>
					<%if(isWsAction){%>
					<option value="2">WebService<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%></option>
					<%}%>
					<%if(isSapAction){%>
					<option value="3">SAP<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%></option>
					<%}%>
				</select>
			</td>
			<TD align="right" width="35%">
			
				<DIV align=right>
				<BUTTON type='button' class=btn_actionList onclick=addRow();><SPAN id=addrowspan><%=SystemEnv.getHtmlLabelName(456,user.getLanguage())%></SPAN></BUTTON><!-- ���� -->
					&nbsp;&nbsp;
				<BUTTON type='button' class=btn_actionList onclick=delRow();><SPAN id=delrowspan><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></SPAN></BUTTON><!-- ɾ�� -->
				</DIV>
			</TD>
		</TR>
		<TR class="Spacing" style="height: 1px;"><TD class="Line1" colspan=5 style="padding: 0px;"></TD></TR>
		<%
		List actionList = DMLActionBase.getDMLActionByNodeOrLinkId(wfid,nodeid,linkid,"0");
		boolean islight = false;
		for(int i =0;i<actionList.size();i++)
		{
			List dmlList = (List)actionList.get(i);
			if(dmlList==null||dmlList.size()<3)
			{
				continue;
			}
			String dmlid = (String)dmlList.get(0);
			String dmlactionname = (String)dmlList.get(1);
			String dmltype = (String)dmlList.get(2);
		%>
		<tr class="<%if(islight){ %>datalight<%}else{%>datadark<%} %>">
			<td>
				<input type="checkbox" id="dmlid" name="dmlid" value="<%=dmlid%>">
				<input type="hidden" id="actiontype<%=dmlid%>" name="actiontype<%=dmlid%>" value="0">
			</td>
			<td nowrap>
				<a href="#" onclick="editAction('<%=dmlid %>', 0);"><%=dmlactionname %></a>
			</td>
			<td nowrap>
				DML<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%>
			</td>
			<td>
				<%=dmltype %><%=SystemEnv.getHtmlLabelName(104, user.getLanguage())%>
			</td>
		</tr>
		<%
			islight = islight?false:true;
		}
		//webservice action �б�
		wsActionManager.setActionid(0);
		ArrayList wsActionList = wsActionManager.doSelectWsAction(wfid,nodeid,linkid,0);
		for(int i =0;i<wsActionList.size();i++){
			ArrayList wsAction = (ArrayList)wsActionList.get(i);
			int actionid_t = Util.getIntValue((String)wsAction.get(0));
			String actionname_t = Util.null2String((String)wsAction.get(1));
		%>
		<tr class="<%if(islight){ %>datalight<%}else{%>datadark<%} %>">
			<td>
				<input type="checkbox" id="dmlid" name="dmlid" value="<%=actionid_t%>">
				<input type="hidden" id="actiontype<%=actionid_t%>" name="actiontype<%=actionid_t%>" value="1">
			</td>
			<td nowrap>
				<a href="#" onclick="editAction('<%=actionid_t%>', 1);"><%=actionname_t%></a>
			</td>
			<td colspan="2" nowrap>
				WebService<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%>
			</td>
		</tr>
		<%
			islight = islight?false:true;
		}
		//sap action �б�
		ArrayList sapActionList = sapActionManager.getSapActionSetList(wfid,nodeid,linkid,0);
		for(int i =0;i<sapActionList.size();i++){
			ArrayList sapAction = (ArrayList)sapActionList.get(i);
			int actionid_t = Util.getIntValue((String)sapAction.get(0));
			String actionname_t = Util.null2String((String)sapAction.get(1));
		%>
		
		<tr class="<%if(islight){ %>datalight<%}else{%>datadark<%} %>">
			<td>
				<input type="checkbox" id="dmlid" name="dmlid" value="<%=actionid_t%>">
				<input type="hidden" id="actiontype<%=actionid_t%>" name="actiontype<%=actionid_t%>" value="2">
			</td>
			<td nowrap>
				<a href="#" onclick="editAction('<%=actionid_t%>', 2);"><%=actionname_t%></a>
			</td>
			<td colspan="2" nowrap>
				Sap<%=SystemEnv.getHtmlLabelName(20978,user.getLanguage())%>
			</td>
		</tr>
		<%
			islight = islight?false:true;
		}
		%>
		
		
		
		
		<%
				//zzl
				RecordSet rs = new RecordSet();
				sql = "select * from int_BrowserbaseInfo where ";
				if(nodeid > 0){
					sql = sql + " w_fid="+wfid+" and w_nodeid="+nodeid+" and ispreoperator=0 order by id";
				}else{
					sql = sql + " w_fid="+wfid+" and nodelinkid="+linkid+" order by id";
				}
				rs.execute(sql);
				while(rs.next()){
					
					String baseid=rs.getString("id");
					String mark=rs.getString("mark");
					String brodesc=rs.getString("brodesc");
					String w_enable=Util.getIntValue(rs.getString("w_enable"),0)+"";
		%>
				<tr class="<%if(islight){ %>datalight<%}else{%>datadark<%} %>">
					<td>
						<input type="checkbox" id="dmlidnewsap" name="dmlidnewsap" value="<%=baseid%>">
					</td>
					<td><span onclick=seeRowEcology7('<%=mark%>') style="cursor: pointer;"><%=mark%></span></td>
					<td><%=brodesc%></td>
					<td style="text-align: center;">
					<%
						if("1".equals(w_enable))
						{
							out.println("����");
							if(!hascon)//����true������±��true,������true������²��ٱ�
							{
								hascon = true; //��ʾ�����̹�
							}
						}else
						{
							out.println("������");
						} 
					%>
					
					</td>
				</tr>
		<%
				islight = islight?false:true;
				}
				
		%>
	
		
		
		
		
		</table></td></tr>
		
<%
}
%>
</table>

</form>
<script language=javascript>
var urls = new Array();
var isCustomer = false;
var isOtherProperty = false;
var curIndex = 0;
var curfieldid=0;
var curisdetail=0;
<%
    String browserSql = "select * from workflow_browserurl order by id desc";
    String idStr = "";
    String urlStr = "";
    RecordSet.executeSql(browserSql);
    while(RecordSet.next()){
%>
        urls[<%=Util.getIntValue(RecordSet.getString("id"),0)%>] = "<%=RecordSet.getString("browserurl")%>";
<%
    }
%>






operList = window.document.forms[0].operation;
op2List = window.document.forms[0].fieldop2id;
op1List = window.document.forms[0].fieldop1id;
objList = window.document.forms[0].fieldid;
var tempbrowsertype = "";

function changefieldid(objvalue){

	var _objvalue = objvalue.substring(0,objvalue.lastIndexOf("_"));
	try{
		tempbrowsertype = eval("urlvalue._"+_objvalue);
	}catch(e){
		tempbrowsertype = "";
	}
	document.all("otherProperty6Value").style.display='none';//td9956 ����ֻҪ���ָı�����״̬��������������޸ġ�Ŀ���ֶΡ��󣬸���������ʧ������
    curisdetail=objvalue.substring(0,objvalue.indexOf("_"));
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);//td9956
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);
    curfieldid=objvalue.substring(0,objvalue.indexOf("_"));
    document.all("fieldop1idvalue").value=""
    document.all("unitspan").innerHTML="";
	if(document.all("fieldop1id").value==0){
		alert("<%=SystemEnv.getHtmlLabelName(15640,user.getLanguage())%>!");
		document.all("fieldid").value=0;
	}
    if(isCustomer){
        operList.style.display='none';
		    op2List.style.display='none';
        if((objvalue!="0") && objvalue.indexOf("_3_")!=-1 && objvalue.indexOf("_3_19")==-1 && objvalue.indexOf("_1_3")==-1){
            //alert(objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length));
            temp = objvalue.substring(0,objvalue.lastIndexOf("_"));
            curIndex = (temp.substring(temp.lastIndexOf("_")+1,temp.length))*1;
            document.all("fieldBrowser").style.display='';
            document.all("fieldop1idvalue").style.display='none';
            //document.all("fieldop1id").style.width='100%';

        }else{
            //operList.style.display='';
            //op2List.style.display='';
            document.all("fieldBrowser").style.display='none';
            document.all("fieldop1idvalue").style.display='';
            //document.all("fieldop1id").style.width='50%';
        }
    }
  objvalue = document.all("fieldid").value;
	var field_isdetail = objvalue.substring(0, objvalue.indexOf("_"));//td9956
	objvalue = objvalue.substring(objvalue.indexOf("_")+1);
	var field_groupid = objvalue.substring(0, objvalue.indexOf("_"));

    objvalue=objvalue.substring(objvalue.indexOf("_")+1);
    //htmltype = objvalue.substring(objvalue.indexOf("_")+1,objvalue.lastIndexOf("_"));
	//type = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);

    indexFirst=objvalue.indexOf("_");
    indexSecond=objvalue.indexOf("_",indexFirst+1);
	indexThird=objvalue.indexOf("_",indexSecond+1);
    
	htmltype=objvalue.substring(indexFirst+1,indexSecond);
	type=objvalue.substring(indexSecond+1,indexThird);

  if(isOtherProperty && htmltype=="6" && field_isdetail!="1") {
    document.all("otherPropertyName").style.display='';
    document.all("otherProperty6Value").style.display='';
  }

  if(isOtherProperty && htmltype=="3"&&(type=="9"||type=="37") && field_isdetail!="1") {
    document.all("otherPropertyName").style.display='';
    document.all("otherProperty6Value").style.display='';
  }

}
function changefieldop1id(objvalue){
    document.all("fieldop1idvalue").value=""
	document.all("fieldop1idvalue").style.display='none';
	document.all("fieldBrowser").style.display='none';
	document.all("fieldop1id").style.width='100%';

	oHeightTenTr.style.display='none';
	oDescriptionTr.style.display='none';
	oLine1Tr.style.display='none';
	oDateRuleTr.style.display='none';



	if(objvalue==0)
		return;


	var i=0;
	for(i = operList.length-1; i >= 0; i--) {
		if (operList.options[i] != null){
			operList.options[i] = null;
		}
	}

	for(i = op2List.length-1; i >= 0; i--) {
		if (op2List.options[i] != null){
			op2List.options[i] = null;
		}
	}

	for(i = objList.length-1; i >= 0; i--) {
		if (objList.options[i] != null){
			objList.options[i] = null;
		}
	}
	i=0;
	<%=objOptions%>

	if(objvalue=="customervalue"){
        isCustomer = true;
        isOtherProperty=false;
        operList.style.display='none';
		op2List.style.display='none';
    document.all("otherPropertyName").style.display='none';
    document.all("otherProperty6Value").style.display='none';
		document.all("fieldop1idvalue").style.display='';
		//document.all("fieldop1id").style.width='40%';
		operList.options[0] = new Option('<%=SystemEnv.getHtmlLabelName(104,user.getLanguage())%>','0');
		op2List.options[0] = new Option('<%=SystemEnv.getHtmlLabelName(15619,user.getLanguage())%>','0');

		return;
	}else{
        isCustomer = false;
        operList.style.display='';
		op2List.style.display='';
    document.all("otherPropertyName").style.display='none';
    document.all("otherProperty6Value").style.display='none';
        document.all("fieldBrowser").style.display='none';
        document.all("unitspan").innerHTML="";

    }
  if(objvalue=="otherproperty"){
    isOtherProperty=true;
    operList.style.display='none';
    op2List.style.display='none';
  }else{
    isOtherProperty=false;
  }

	var obj_isdetail = objvalue.substring(0, objvalue.indexOf("_"));//td9956
	objvalue = objvalue.substring(objvalue.indexOf("_")+1);
	var obj_groupid = objvalue.substring(0, objvalue.indexOf("_"));

    objvalue=objvalue.substring(objvalue.indexOf("_")+1);
    id = objvalue.substring(0,objvalue.indexOf("_"));
	//htmltype = objvalue.substring(objvalue.indexOf("_")+1,objvalue.lastIndexOf("_"));
	//type = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);
    indexFirst=objvalue.indexOf("_");
    indexSecond=objvalue.indexOf("_",indexFirst+1);
	indexThird=objvalue.indexOf("_",indexSecond+1);
    
	var valuearray = objvalue.split("_");
	htmltype = valuearray[1];
	type = valuearray[2];


	i=0;
	<%=operOptions%>

	i=0;
	<%=op2Options%>

	if(obj_isdetail == "1"){//���ж��Ƿ���ϸ�ֶΣ�����ǣ�objList�����������ֶ�
		var cx = 0;
		for(cx=objList.length-1; cx>=0; cx--) {
			if (objList.options[cx] != null){
				tmpvalue = objList.options[cx].value;
				if(tmpvalue.indexOf("_")>-1){
					var tmpisdetail = tmpvalue.substring(0, tmpvalue.indexOf("_"));
					if(objList.options[cx].value!="0" && tmpisdetail!="1"){
						objList.options[cx] = null;
					}else{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						var tmpgroupid1 = tmpvalue.substring(0, tmpvalue.indexOf("_"));
						if(objList.options[cx].value!="0" && tmpisdetail=="1" && tmpgroupid1!=obj_groupid){
							objList.options[cx] = null;
						}
					}
				}
			}
		}
		if(obj_groupid!="" && obj_groupid!="-1"){
			for(cx=op2List.length-1; cx >= 0; cx--) {//ȥ�����������ϸ�ֶ�
				if (op2List.options[cx] != null){
					tmpvalue = op2List.options[cx].value;
					if(tmpvalue.indexOf("_")>-1){
						var tmpisdetail2 = tmpvalue.substring(0, tmpvalue.indexOf("_"));
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						var tmpgroupid2 = tmpvalue.substring(0, tmpvalue.indexOf("_"));
						if(op2List.options[cx].value!="0" && tmpisdetail2=="1" && tmpgroupid2!=obj_groupid){
							op2List.options[cx] = null;
						}
					}
				}
			}
		}
	}

	if((htmltype=="1" && type=="1") || htmltype=="2"){
	//	alert("�ı�");
		for(var i = operList.length-1; i >= 0; i--) {
			if (operList.options[i] != null){
				tmpvalue = operList.options[i].value;
				if((tmpvalue!="1")&& (tmpvalue!="0")){
					operList.options[i] = null;
				}
			}
		}
		for(var i = op2List.length-1; i >= 0 ; i--) {
			if (op2List.options[i] != null){
				tmpvalue = op2List.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_1")==-1 && tmpvalue.indexOf("_2_0")==-1){
					op2List.options[i] = null;
				}
			}
		}
		for(var i = objList.length-1; i >= 0 ; i--) {
			if (objList.options[i] != null){
				tmpvalue = objList.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_1")==-1 && tmpvalue.indexOf("_2_0")==-1){
					objList.options[i] = null;
				}
			}
		}

	}else if((htmltype=="1" && type=="2") || (htmltype=="1" && type=="3") ){
	//	alert("����");
	//	alert("������");
		for(var i = op2List.length-1; i >= 0 ; i--) {
			if (op2List.options[i] != null){
				tmpvalue = op2List.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_1_3")==-1){
					op2List.options[i] = null;
				}
			}
		}
		for(var i = objList.length-1; i >= 0 ; i--) {
			if (objList.options[i] != null){
				tmpvalue = objList.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_1_3")==-1){
					objList.options[i] = null;
				}
			}
		}

	}else if(htmltype=="3" && type=="2"){
	//	alert("����");
		oHeightTenTr.style.display='';
		oDescriptionTr.style.display='';
		oLine1Tr.style.display='';
		oDateRuleTr.style.display='';


		for(var i = operList.length-1; i >= 0; i--) {
			if (operList.options[i] != null){
				tmpvalue = operList.options[i].value;
				if((tmpvalue!="1")&& (tmpvalue!="0")&& (tmpvalue!="2")){
					operList.options[i] = null;
				}
			}
		}
		for(var i = op2List.length-1; i >= 0 ; i--) {
			if (op2List.options[i] != null){
				tmpvalue = op2List.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_3_2")==-1 && tmpvalue.indexOf("_1_3")==-1){
					op2List.options[i] = null;
				}
			}
		}
		for(var i = objList.length-1; i >= 0 ; i--) {
			if (objList.options[i] != null){
				tmpvalue = objList.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_3_2")==-1 && tmpvalue.indexOf("_1_3")==-1){
					objList.options[i] = null;
				}
			}
		}

	}else if(htmltype=="3" && type=="19"){
	//	alert("ʱ��");
		for(var i = operList.length-1; i >= 0; i--) {
			if (operList.options[i] != null){
				tmpvalue = operList.options[i].value;
				if((tmpvalue!="1")&& (tmpvalue!="0")&& (tmpvalue!="2")){
					operList.options[i] = null;
				}
			}
		}
		for(var i = op2List.length-1; i >= 0 ; i--) {
			if (op2List.options[i] != null){
				tmpvalue = op2List.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_3")==-1 && tmpvalue.indexOf("_3_19")==-1){
					op2List.options[i] = null;
				}
			}
		}
		for(var i = objList.length-1; i >= 0 ; i--) {
			if (objList.options[i] != null){
				tmpvalue = objList.options[i].value;
				try{
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
					tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
				}catch(e){}
				if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_3")==-1 && tmpvalue.indexOf("_3_19")==-1){
					objList.options[i] = null;
				}
			}
		}
	}else if(htmltype=="6" ){
  }
}

function changeoperation(objval){
	objvalue = op1List.value;
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);
	id = objvalue.substring(0,objvalue.indexOf("_"));
	//htmltype = objvalue.substring(objvalue.indexOf("_")+1,objvalue.lastIndexOf("_"));
	//type = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);
    indexFirst=objvalue.indexOf("_");
    indexSecond=objvalue.indexOf("_",indexFirst+1);
	indexThird=objvalue.indexOf("_",indexSecond+1);
    
	htmltype=objvalue.substring(indexFirst+1,indexSecond);
	type=objvalue.substring(indexSecond+1,indexThird);

	if((htmltype=="3" && type=="2") || (htmltype=="3" && type=="19")){
		var i=0;

		for(i = op2List.length-1; i >= 0; i--) {
			if (op2List.options[i] != null){
				op2List.options[i] = null;
			}
		}

		for(i = objList.length-1; i >= 0; i--) {
			if (objList.options[i] != null){
				objList.options[i] = null;
			}
		}
		i=0;
		<%=objOptions%>
		i=0;
		<%=op2Options%>
	}

	if(htmltype=="3" && type=="2"){
	//	alert("����");

		if(objval=="1"){
			for(var i = op2List.length-1; i >= 0 ; i--) {
				if (op2List.options[i] != null){
					tmpvalue = op2List.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1){
						op2List.options[i] = null;
					}
				}
			}
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_3_2")==-1){
						objList.options[i] = null;
					}
				}
			}
		}else{
			for(var i = op2List.length-1; i >= 0 ; i--) {
				if (op2List.options[i] != null){
					tmpvalue = op2List.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_3_2")==-1){
						op2List.options[i] = null;
					}
				}
			}
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_3_2")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
	}else if(htmltype=="3" && type=="19"){
	//	alert("ʱ��");
		if(objval=="1"){
			for(var i = op2List.length-1; i >= 0 ; i--) {
				if (op2List.options[i] != null){
					tmpvalue = op2List.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((op2List.options[i].value!="0") && tmpvalue.indexOf("_1_3")==-1){
						op2List.options[i] = null;
					}
				}
			}
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_3_19")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
	}
	changefieldop2id(document.all("fieldop2id").value);
}

function changefieldop2id(objval){
	if(document.all("operation").value==0){
		alert("<%=SystemEnv.getHtmlLabelName(15641,user.getLanguage())%>!");
		document.all("fieldid").value=0;
		return;
	}
	objvalue = op1List.value;
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);//9956
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);//9956
	id = objvalue.substring(0,objvalue.indexOf("_"));
	//htmltype = objvalue.substring(objvalue.indexOf("_")+1,objvalue.lastIndexOf("_"));
	//type = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);
    indexFirst=objvalue.indexOf("_");
    indexSecond=objvalue.indexOf("_",indexFirst+1);
	indexThird=objvalue.indexOf("_",indexSecond+1);
    
	htmltype=objvalue.substring(indexFirst+1,indexSecond);
	type=objvalue.substring(indexSecond+1,indexThird);

	var op2_isdetail = objval.substring(0, objval.indexOf("_"));//td9956
	objval = objval.substring(objval.indexOf("_")+1);
	var op2_groupid = objval.substring(0, objval.indexOf("_"));

	objval = objval.substring(objval.indexOf("_")+1);
	indexFirst=objval.indexOf("_");
    indexSecond=objval.indexOf("_",indexFirst+1);
	indexThird=objval.indexOf("_",indexSecond+1);
	id2 = objval.substring(indexFirst+1,indexSecond);
	htmltype2 = objval.substring(indexSecond+1,indexThird);
	type2 = objval.substring(indexThird+1,objval.length);
	if(op2_isdetail == "1"){//���ж��Ƿ���ϸ�ֶΣ�����ǣ�objList�����������ֶ�
		var cx = 0;
		for(cx=objList.length-1; cx>=0; cx--) {
			if (objList.options[cx] != null){
				tmpvalue = objList.options[cx].value;
				if(tmpvalue.indexOf("_")>-1){
					var tmpisdetail = tmpvalue.substring(0, tmpvalue.indexOf("_"));
					if(tmpisdetail!="1"){
						objList.options[cx] = null;
					}else{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						var tmpgroupid1 = tmpvalue.substring(0, tmpvalue.indexOf("_"));
						if(objList.options[cx].value!="0" && tmpisdetail=="1" && tmpgroupid1!=op2_groupid){
							objList.options[cx] = null;
						}
					}
				}
			}
		}
	}
	if((htmltype=="3" && type=="2") || (htmltype=="3" && type=="19")){
		var i=0;
		for(i = objList.length-1; i >= 0; i--) {
			if (objList.options[i] != null){
				objList.options[i] = null;
			}
		}
		i=0;
		<%=objOptions%>
	}

	if(htmltype=="3" && type=="2"){
		if(htmltype2=="3" && type2=="2"){
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
		else if(htmltype2=="1" && type2=="2"){
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_3_2")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
		else {
			if(operList.value=="1"){
				for(var i = objList.length-1; i >= 0 ; i--) {
					if (objList.options[i] != null){
						tmpvalue = objList.options[i].value;
						try{
							tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
							tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
						}catch(e){}
						if((objList.options[i].value!="0") && tmpvalue.indexOf("_3_2")==-1){
							objList.options[i] = null;
						}
					}
				}
			}else{
				for(var i = objList.length-1; i >= 0 ; i--) {
					if (objList.options[i] != null){
						tmpvalue = objList.options[i].value;
						try{
							tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
							tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
						}catch(e){}
						if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_2")==-1 && tmpvalue.indexOf("_3_2")==-1){
							objList.options[i] = null;
						}
					}
				}
			}
		}
	}else if(htmltype=="3" && type=="19"){
	//	alert("ʱ��");
		if(htmltype2=="3" && type2=="19"){
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_1_3")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
		else if(htmltype2=="1" && type2=="3"){
			for(var i = objList.length-1; i >= 0 ; i--) {
				if (objList.options[i] != null){
					tmpvalue = objList.options[i].value;
					try{
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1);
						tmpvalue = tmpvalue.substring(tmpvalue.indexOf("_")+1)+"_";
					}catch(e){}
					if((objList.options[i].value!="0") && tmpvalue.indexOf("_3_19")==-1){
						objList.options[i] = null;
					}
				}
			}
		}
	}
}
function onSave(){
	if(objList.value=="0"){
    alert("<%=SystemEnv.getHtmlLabelName(15642,user.getLanguage())%>!");
    return;
	}else if(isCustomer&&document.all("fieldop1idvalue").value==""){
    //alert("�Զ���ֵ����Ϊ��"); //xwj for td3308 on 20051212
    //return;
  }

  //�ų�'�ĵ��ϴ�'��������ֶα���'��������'
  objvalue = document.all("fieldid").value;
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);//9956
    objvalue=objvalue.substring(objvalue.indexOf("_")+1);
    //
	//type = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);
    indexFirst=objvalue.indexOf("_");
    indexSecond=objvalue.indexOf("_",indexFirst+1);
	indexThird=objvalue.indexOf("_",indexSecond+1);
    
	htmltype=objvalue.substring(indexFirst+1,indexSecond);
	type=objvalue.substring(indexSecond+1,indexThird);

  if(isOtherProperty && htmltype!="6"&&(htmltype!="3"||(type!="9"&&type!="37"))){
    alert("<%=SystemEnv.getHtmlLabelName(19562,user.getLanguage())%>");
    return;
  }

	if(op1List.value=="customervalue"){
		tmpvalue = document.all("fieldop1idvalue").value;

		objvalue = objList.value;
		objvalue = objvalue.substring(objvalue.indexOf("_")+1);
		objvalue = objvalue.substring(objvalue.indexOf("_")+1);
		id = objvalue.substring(0,objvalue.indexOf("_"));
		temp = objvalue.substring(objvalue.indexOf("_")+1,objvalue.lastIndexOf("_"));
		htmltype = temp.substring(0,temp.indexOf("_"));
		type = temp.substring(temp.lastIndexOf("_")+1,temp.length);
		
		lens = objvalue.substring(objvalue.lastIndexOf("_")+1,objvalue.length);

		if(htmltype ==1 && type==1 && lens != -1){
			len1 = realLength(tmpvalue);
			if(lens<len1){
				alert("<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>"+lens+"(<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>)");
				return;
			}
		}else if((htmltype ==1 && type==2)){
			if(checkInt(tmpvalue)){
				alert("<%=SystemEnv.getHtmlLabelName(15643,user.getLanguage())%>!");
				return;
			}
		}else if((htmltype ==1 && type==3)){
			if(checkFloat(tmpvalue)) {
				alert("<%=SystemEnv.getHtmlLabelName(15644,user.getLanguage())%>!");
				return;
			}
		}else if((htmltype ==3 && type==2)){
			if(checkDate(tmpvalue)) {
				alert("<%=SystemEnv.getHtmlLabelName(15645,user.getLanguage())%>!");
				return;
			}
		}else if((htmltype ==1 && type==5)){
			if(checkFloat(tmpvalue)) {
				alert("<%=SystemEnv.getHtmlLabelName(15644,user.getLanguage())%>!");
				return;
			}
			changeToThousands("fieldop1idvalue");
		}else if((htmltype ==3 && type==19)){
			if(checkTime(tmpvalue)) {
				alert("<%=SystemEnv.getHtmlLabelName(15646,user.getLanguage())%>!");
				return;
			}
		}
	}
	$G("src").value="add";
	document.SearchForm.submit();
}
function checkInt(objval)
{
	valuechar = objval.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)) isnumber = true ;}
	return isnumber;
}
function checkFloat(objval)
{
	valuechar = objval.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=".") isnumber = true ;}
	return isnumber;
}
function checkTime(objval)
{
	valuechar = objval.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!=":") isnumber = true ;}
	return isnumber;
}
function checkDate(objval)
{
	valuechar = objval.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!="-") isnumber = true ;}
	return isnumber;
}
function onDelete(){
	$G("src").value="delete";
	document.SearchForm.submit();
}
function onClose(){
	if($G("src").value!=""){
		return;
	}
    <%if(hascon){%>
    	//1��ʾ��ʾ�̹�
        window.parent.returnValue = "1";
    <%}else{%>
    	//0��ʾ����ʾ�̹�
        window.parent.returnValue = "0";
    <%}%>
	window.parent.close();

}
//������ͼ�λ�ȷ��
function designOnClose() {
	if($G("src").value!=""){
		return;
	}
	<%if(hascon){%>
        window.parent.returnValue = "1"
    <%}else{%>
        window.parent.returnValue = "0"
    <%}%>
	window.parent.design_callback('showaddinoperate_<%if(linkid>0) {out.print("link");}else{out.print("node");}%>','<%=hascon%>');
}
function uescape(url){
    return escape(url);
}
</script>

   <script language="javascript">
function submitData()
{
	if (confirmdel())
		form2.submit();
}

function submitClear()
{
	//TD24113:�������ó��ڸ��ӹ���ʱδѡ�����ݵ��ɾ��ʱ��ʾ��Ϣ��������� ADD BY QB START
	var isChecked = false;
	for(var i=0;i<document.getElementsByName("check_node").length;i++){
		if (document.getElementsByName("check_node")[i].checked) {
			isChecked = true;
			break;
		}
	}

	if (isChecked) {
		if (isdel()){
			onDelete();
		}
	} else {
			alert("<%=SystemEnv.getHtmlLabelName(15445,user.getLanguage())%>");
		}	
	
	//if (isdel()){
	//		onDelete();
	//	}
	//TD24113:�������ó��ڸ��ӹ���ʱδѡ�����ݵ��ɾ��ʱ��ʾ��Ϣ��������� ADD BY QB END
}
function checkInterface(){
	if(document.all("enableInterface").checked){
     $G("src").value="addInterface";
	  document.SearchForm.submit();
	}else{
     $G("src").value="delInterface";
	  document.SearchForm.submit();
	}

}
function onSelectInterface(){

    if(document.all("interface").value=="none"){
     document.all("enableInterface").style.display="none";

	}else{

     document.all("enableInterface").style.display="";
	}

}
function showPreDBrowser(url,objtype){
   if(objtype == 2 || objtype == 19){
    WdatePicker({el:'unitspan',onpicked:function(dp){
			$dp.$('fieldop1idvalue').value = dp.cal.getDateStr()},oncleared:function(dp){$dp.$('fieldop1idvalue').value = ''}});
   }else{
     if(objtype=="161"||objtype=="162")
		url = url + "?type="+tempbrowsertype;
	 if(objtype=="141"){
	 	onShowResourceConditionBrowser();
	 }else{
     	onShowBrowser(url,objtype);
	 }
   }
}

function onShowBrowser(url, objtype) {
    if (objtype != "161" && objtype != "162") {
        url = url + "?selectedids=" + $G("fieldop1idvalue").value;
    }
    if (objtype == 165 || objtype == 166 || objtype == 167 || objtype == 168) {
        temp = uescape("&fieldid=" + curfieldid + "&isdetail=" + curisdetail);
        myid = window.showModalDialog(url + temp);
        if (myid) {
        	var rid = wuiUtil.getJsonValueByIndex(myid, 0);
        	var rname = wuiUtil.getJsonValueByIndex(myid, 1);
            if (rid != "") {
                unitspan.innerHTML = rname;
                if (rid.indexOf(",") == 0) {
                	$G("fieldop1idvalue").value = rid.substr(1);
                    unitspan.innerHTML = rname.substr(1);
                } else {
                	$G("fieldop1idvalue").value = rid;
                    unitspan.innerHTML = rname;
                }
            } else {
                unitspan.innerHTML = "";
                $G("fieldop1idvalue").value = "";
            }
        }
    } else {
        myid = window.showModalDialog(url);
        if (myid) {
        	var rid = wuiUtil.getJsonValueByIndex(myid, 0);
        	var rname = wuiUtil.getJsonValueByIndex(myid, 1);
            if (rid != "") {
            
            	unitspan.innerHTML = rname;
                if (rid.indexOf(",") == 0) {
                	$G("fieldop1idvalue").value = rid.substr(1);
                    unitspan.innerHTML = rname.substr(1);
                } else {
                	$G("fieldop1idvalue").value = rid;
                    unitspan.innerHTML = rname;
                }
            } else {
                unitspan.innerHTML = "";
                $G("fieldop1idvalue").value = "";
            }
        }
    }
}


function onShowResourceConditionBrowser() {
	var tempIds = $G("fieldop1idvalue").value;
	var dialogId = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceConditionBrowser.jsp?resourceCondition=" + tempIds);
	if (dialogId) {
		if (wuiUtil.getJsonValueByIndex(dialogId, 0) != "") {
			var shareTypeValues = wuiUtil.getJsonValueByIndex(dialogId, 0);
			var shareTypeTexts = wuiUtil.getJsonValueByIndex(dialogId, 1);
			var relatedShareIdses = wuiUtil.getJsonValueByIndex(dialogId, 2);
			var relatedShareNameses = wuiUtil.getJsonValueByIndex(dialogId, 3);
			var rolelevelValues = wuiUtil.getJsonValueByIndex(dialogId, 4);
			var rolelevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 5);
			var secLevelValues = wuiUtil.getJsonValueByIndex(dialogId, 6);
			var secLevelTexts = wuiUtil.getJsonValueByIndex(dialogId, 7);

			var sHtml = "";
			var fileIdValue = "";
			shareTypeValues = shareTypeValues.substr(1);
			shareTypeTexts = shareTypeTexts.substr(1);
			relatedShareIdses = relatedShareIdses.substr(1);
			relatedShareNameses = relatedShareNameses.substr(1);
			rolelevelValues = rolelevelValues.substr(1);
			rolelevelTexts = rolelevelTexts.substr(1);
			secLevelValues = secLevelValues.substr(1);
			secLevelTexts = secLevelTexts.substr(1);

			var shareTypeValueArray = shareTypeValues.split("~");
			var shareTypeTextArray = shareTypeTexts.split("~");
			var relatedShareIdseArray = relatedShareIdses.split("~");
			var relatedShareNameseArray = relatedShareNameses.split("~");
			var rolelevelValueArray = rolelevelValues.split("~");
			var rolelevelTextArray = rolelevelTexts.split("~");
			var secLevelValueArray = secLevelValues.split("~");
			var secLevelTextArray = secLevelTexts.split("~");
			for ( var _i = 0; _i < shareTypeValueArray.length; _i++) {

				var shareTypeValue = shareTypeValueArray[_i];
				var shareTypeText = shareTypeTextArray[_i];
				var relatedShareIds = relatedShareIdseArray[_i];
				var relatedShareNames = relatedShareNameseArray[_i];
				var rolelevelValue = rolelevelValueArray[_i];
				var rolelevelText = rolelevelTextArray[_i];
				var secLevelValue = secLevelValueArray[_i];
				var secLevelText = secLevelTextArray[_i];

				fileIdValue = fileIdValue + "~" + shareTypeValue + "_"
						+ relatedShareIds + "_" + rolelevelValue + "_"
						+ secLevelValue;

				if (shareTypeValue == "1") {
					sHtml = sHtml + "," + shareTypeText + "("
							+ relatedShareNames + ")";
				} else if (shareTypeValue == "2") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18941, user.getLanguage())%>";
				} else if (shareTypeValue == "3") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18942, user.getLanguage())%>";
				} else if (shareTypeValue == "4") {
					sHtml = sHtml
							+ ","
							+ shareTypeText
							+ "("
							+ relatedShareNames
							+ ")"
							+ "<%=SystemEnv.getHtmlLabelName(3005, user.getLanguage())%>="
							+ rolelevelText
							+ "  <%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18945, user.getLanguage())%>";
				} else {
					sHtml = sHtml
							+ ","
							+ "<%=SystemEnv.getHtmlLabelName(683, user.getLanguage())%>>="
							+ secLevelValue
							+ "<%=SystemEnv.getHtmlLabelName(18943, user.getLanguage())%>";
				}

			}

			sHtml = sHtml.substr(1);
			fileIdValue = fileIdValue.substr(1);
			unitspan.innerHTML = sHtml;
			$G("fieldop1idvalue").value = fileIdValue;
		}else {
			unitspan.innerHTML = "";
			document.all("fieldop1idvalue").value = "";
		}
	} 
}
</script>
<!-- 
<script language="vbscript">
sub onShowBrowser(url,objtype)
	if objtype<>"161" and objtype<>"162" then
		url= url&"?selectedids="&document.all("fieldop1idvalue").value
	end if
	if objtype=165 or objtype=166 or objtype=167 or objtype=168 then
        temp=uescape("&fieldid="&curfieldid&"&isdetail="&curisdetail)
        myid = window.showModalDialog(url&temp)
        if (Not IsEmpty(myid)) then
            if myid(0)<> "" then
                unitspan.innerHtml = myid(1)
                'msgbox Left(myid(0),1)=","
                if Left(myid(0),1)="," then
                    document.all("fieldop1idvalue").value = Mid(myid(0),2,len(myid(0)))
                    unitspan.innerHtml = Mid(myid(1),2,len(myid(1)))
                else
                    document.all("fieldop1idvalue").value = myid(0)
                    unitspan.innerHtml = myid(1)
                end if
            else
                unitspan.innerHtml = ""
                document.all("fieldop1idvalue").value = ""
            end if
        end if
    else
        myid = window.showModalDialog(url)
        if (Not IsEmpty(myid)) then
            if myid(0)<> "" then
                unitspan.innerHtml = myid(1)
                'msgbox Left(myid(0),1)=","
                if Left(myid(0),1)="," then
                    document.all("fieldop1idvalue").value = Mid(myid(0),2,len(myid(0)))
                    unitspan.innerHtml = Mid(myid(1),2,len(myid(1)))
                else
                    document.all("fieldop1idvalue").value = myid(0)
                    unitspan.innerHtml = myid(1)
                end if
            else
                unitspan.innerHtml = ""
                document.all("fieldop1idvalue").value = ""
            end if
        end if
    end if
end sub

sub onShowResourceConditionBrowser()

	dialogId = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceConditionBrowser.jsp")
	if (Not IsEmpty(dialogId)) then
	if dialogId(0)<> "" then
	    shareTypeValues = dialogId(0)
		shareTypeTexts = dialogId(1)
		relatedShareIdses = dialogId(2)
		relatedShareNameses = dialogId(3)
		rolelevelValues = dialogId(4)
		rolelevelTexts = dialogId(5)
		secLevelValues = dialogId(6)
		secLevelTexts = dialogId(7)

		sHtml = ""
		fileIdValue=""
		shareTypeValues = Mid(shareTypeValues,2,len(shareTypeValues))
		shareTypeTexts = Mid(shareTypeTexts,2,len(shareTypeTexts))
		relatedShareIdses = Mid(relatedShareIdses,2,len(relatedShareIdses))
		relatedShareNameses = Mid(relatedShareNameses,2,len(relatedShareNameses))
		rolelevelValues = Mid(rolelevelValues,2,len(rolelevelValues))
		rolelevelTexts = Mid(rolelevelTexts,2,len(rolelevelTexts))
		secLevelValues = Mid(secLevelValues,2,len(secLevelValues))
		secLevelTexts = Mid(secLevelTexts,2,len(secLevelTexts))


		while InStr(shareTypeValues,"~") <> 0

			shareTypeValue = Mid(shareTypeValues,1,InStr(shareTypeValues,"~")-1)
			shareTypeText = Mid(shareTypeTexts,1,InStr(shareTypeTexts,"~")-1)
			relatedShareIds = Mid(relatedShareIdses,1,InStr(relatedShareIdses,"~")-1)
			relatedShareNames = Mid(relatedShareNameses,1,InStr(relatedShareNameses,"~")-1)
			rolelevelValue = Mid(rolelevelValues,1,InStr(rolelevelValues,"~")-1)
			rolelevelText = Mid(rolelevelTexts,1,InStr(rolelevelTexts,"~")-1)
			secLevelValue = Mid(secLevelValues,1,InStr(secLevelValues,"~")-1)
			secLevelText = Mid(secLevelTexts,1,InStr(secLevelTexts,"~")-1)

			shareTypeValues = Mid(shareTypeValues,InStr(shareTypeValues,"~")+1,Len(shareTypeValues))
			shareTypeTexts = Mid(shareTypeTexts,InStr(shareTypeTexts,"~")+1,Len(shareTypeTexts))
			relatedShareIdses = Mid(relatedShareIdses,InStr(relatedShareIdses,"~")+1,Len(relatedShareIdses))
			relatedShareNameses = Mid(relatedShareNameses,InStr(relatedShareNameses,"~")+1,Len(relatedShareNameses))
			rolelevelValues = Mid(rolelevelValues,InStr(rolelevelValues,"~")+1,Len(rolelevelValues))
			rolelevelTexts = Mid(rolelevelTexts,InStr(rolelevelTexts,"~")+1,Len(rolelevelTexts))
			secLevelValues = Mid(secLevelValues,InStr(secLevelValues,"~")+1,Len(secLevelValues))
			secLevelTexts = Mid(secLevelTexts,InStr(secLevelTexts,"~")+1,Len(secLevelTexts))

            fileIdValue=fileIdValue&"~"&shareTypeValue&"_"&relatedShareIds&"_"&rolelevelValue&"_"&secLevelValue

	        if shareTypeValue= "1" then
			    sHtml = sHtml&","&shareTypeText&"("&relatedShareNames&")"
	        else	if  shareTypeValue= "2" then
			             sHtml = sHtml&","&shareTypeText&"("&relatedShareNames&")"&"��ȫ����>="&secLevelValue&"�ķֲ���Ա"
			        else   if shareTypeValue= "3" then
			                   sHtml = sHtml&","&shareTypeText&"("&relatedShareNames&")"&"��ȫ����>="&secLevelValue&"�Ĳ��ų�Ա"
					       else  if shareTypeValue= "4" then
			                         sHtml = sHtml&","&shareTypeText&"("&relatedShareNames&")"&"������="&rolelevelText&"  ��ȫ����>="&secLevelValue&"�Ľ�ɫ��Ա"
						         else
			                         sHtml = sHtml&","&"��ȫ����>="&secLevelValue&"��������"
								 end if
						   end if
					end if
	        end if
		wend

            fileIdValue=fileIdValue&"~"&shareTypeValues&"_"&relatedShareIdses&"_"&rolelevelValues&"_"&secLevelValues


	        if shareTypeValues= "1" then
			    sHtml = sHtml&","&shareTypeTexts&"("&relatedShareNameses&")"
	        else	if  shareTypeValues= "2" then
			             sHtml = sHtml&","&shareTypeTexts&"("&relatedShareNameses&")"&"��ȫ����>="&secLevelValues&"�ķֲ���Ա"
			        else   if shareTypeValues= "3" then
			                   sHtml = sHtml&","&shareTypeTexts&"("&relatedShareNameses&")"&"��ȫ����>="&secLevelValues&"�Ĳ��ų�Ա"
					       else  if shareTypeValues= "4" then
			                         sHtml = sHtml&","&shareTypeTexts&"("&relatedShareNameses&")"&"������="&rolelevelTexts&"  ��ȫ����>="&secLevelValues&"�Ľ�ɫ��Ա"
						         else
			                         sHtml = sHtml&","&"��ȫ����>="&secLevelValues&"��������"
								 end if
						   end if
					end if
	        end if

		sHtml = Mid(sHtml,2,len(sHtml))
		fileIdValue=Mid(fileIdValue,2,len(fileIdValue))

        unitspan.innerHtml = sHtml
		document.all("fieldop1idvalue").value = fileIdValue
	else
        unitspan.innerHtml = empty
		document.all("fieldop1idvalue").value = ""
	end if
	end if

end sub
</script>

 -->
<!--
TD8698
�ҿ�	2008.05.09
���̽ڵ㼰������Ϣ���Ӳ�������ҳ�潨���������ֶκ���ϸ�ֶ�
ʵ����select�Բ���ʾ��ѡ�е�option
-->
<script Language="JavaScript">
//***********Ĭ�����ö���.*********************
var tPopWait=50;//ͣ��tWait�������ʾ��ʾ��
var tPopShow=5000;//��ʾtShow�����ر���ʾ
var showPopStep=20;
var popOpacity=99;
//***************�ڲ���������*****************
var sPop=null;
var curShow=null;
var tFadeOut=null;
var tFadeIn=null;
var tFadeWaiting=null;
document.write("<style   type='text/css'id='defaultPopStyle'>");
document.write(".cPopText   { background-color: #F8F8F5;color:#000000; border:1px #000000 solid;font-color: font-size:12px;   padding-right:   4px;   padding-left:   4px;   height:   20px;   padding-top:   2px;   padding-bottom:   2px;   filter:   Alpha(Opacity=0)}");
document.write("</style>");
document.write("<div   id='dypopLayer' style='position:absolute;z-index:1000;display:none' class='cPopText'></div>");

function showPopupText(){
	var o=event.srcElement;

	MouseX=event.x;
	MouseY=event.y;
	if(o.alt!=null && o.alt!=""){
		o.dypop=o.alt;
		o.alt="";
	}
	if(o.title!=null && o.title!=""){
		o.dypop=o.title;
		o.title="";
	}
	if(o.dypop!=sPop){
		sPop=o.dypop;
		clearTimeout(curShow);
		clearTimeout(tFadeOut);
		clearTimeout(tFadeIn);
		clearTimeout(tFadeWaiting);
		if(sPop==null || sPop==""){
			dypopLayer.innerHTML="";
			dypopLayer.style.filter="Alpha()";
			dypopLayer.filters.Alpha.opacity=0;
		}else{
			if(o.dyclass!=null){
				popStyle=o.dyclass;
			}else{
				popStyle="cPopText";
			}
			curShow=setTimeout("showIt()",tPopWait);
		}
	}
}

function showIt(){
	dypopLayer.className=popStyle;
	dypopLayer.innerHTML=sPop;
	popWidth=dypopLayer.clientWidth;
	popHeight=dypopLayer.clientHeight;
	if(MouseX+12+popWidth>document.body.clientWidth){
		popLeftAdjust=-popWidth-24;
	}else{
		popLeftAdjust=0;
	}
	if(MouseY+12+popHeight>document.body.clientHeight){
		popTopAdjust=-popHeight-24;
	}else{
		popTopAdjust=0;
	}
	dypopLayer.style.left=MouseX+12+document.body.scrollLeft+popLeftAdjust;
	dypopLayer.style.top=MouseY+12+document.body.scrollTop+popTopAdjust;
	dypopLayer.style.filter="Alpha(Opacity=0)";
	fadeOut();
}

function fadeOut(){
	if(dypopLayer.filters.Alpha.opacity<popOpacity){
	dypopLayer.filters.Alpha.opacity+=showPopStep;
	tFadeOut=setTimeout("fadeOut()",1);
	}else{
		dypopLayer.filters.Alpha.opacity=popOpacity;
		tFadeWaiting=setTimeout("fadeIn()",tPopShow);
	}
}

function fadeIn(){
	if(dypopLayer.filters.Alpha.opacity>0){
		dypopLayer.filters.Alpha.opacity-=1;
		tFadeIn=setTimeout("fadeIn()",1);
	}
}
document.onmouseover=showPopupText;
function changeTitle(id, title){
	var s = document.getElementById(id);
	//alert(title);
	var isStr = s.options[s.selectedIndex].innerText;
//	for(var i=0;i<s.options.length;i++){
//		if(title == s.options[i].value){
//			isStr = s.options[i].innerText;
//		}
//	}
	s.title = isStr;
	//alert(s.title);
}

if(fieldtempurl.length>0) fieldtempurl = fieldtempurl.substring(0,fieldtempurl.length-1);
fieldurl = " var urlvalue = {"+fieldtempurl+"}";
eval(fieldurl);

function onRejectBackFlg(){
	$G("src").value="RejectBackFlg";
	document.SearchForm.submit();
}
function editAction(actionid, actiontype_){
	var addurl = "";
	if(actiontype_ == 0){
		addurl = "/systeminfo/BrowserMain.jsp?url=/workflow/dmlaction/DMLActionSettingEdit.jsp?actionid="+actionid+"&workflowId=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0";
	}else if(actiontype_ == 1){
		addurl = "/systeminfo/BrowserMain.jsp?url="+escape("/workflow/action/WsActionEditSet.jsp?actionid="+actionid+"&operate=editws&workflowid=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0");
	}else if(actiontype_ == 2){
		addurl = "/systeminfo/BrowserMain.jsp?url="+escape("/workflow/action/SapActionEditSet.jsp?actionid="+actionid+"&operate=editsap&workflowid=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0");
	}
	var id_t = window.showModalDialog(addurl,window,"dialogWidth:1000px;dialogHeight:800px;scroll:yes;resizable:yes;")
}
//zzl
function addRowEcology7()
{
	var args="?workflowId=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0&workflowid=<%=wfid%>&w_type=1";
	var addurl="/integration/browse/integrationBrowerMain.jsp"+args;
	var id_t = window.showModalDialog(addurl,"","dialogWidth:1000px;dialogHeight:800px;scroll:yes;resizable:yes;")
	$G("src").value="refush";
	document.SearchForm.submit();//�½���ʱ��ˢ�½ڵ�󱣴����
}
function seeRowEcology7(mark)
{
	
	var args="?workflowId=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0&workflowid=<%=wfid%>&w_type=1&mark="+mark+"";
	var addurl="/integration/browse/integrationBrowerMain.jsp"+args;
	var id_t = window.showModalDialog(addurl,window,"dialogWidth:1000px;dialogHeight:800px;scroll:yes;resizable:yes;")
}


function addRow(){
	var addurl = "";
	var actionlist_t = document.getElementById("actionlist").value;
	if(actionlist_t == 1){
		addurl = "/systeminfo/BrowserMain.jsp?url=/workflow/dmlaction/DMLActionSettingAdd.jsp?workflowId=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0";
	}else if(actionlist_t == 2){
		addurl = "/systeminfo/BrowserMain.jsp?url="+escape("/workflow/action/WsActionEditSet.jsp?operate=addws&workflowid=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0");
	}else if(actionlist_t == 3){
		 <%
	    if(type.equals("0")){
	    		//�ϰ汾��sap����
	    %>
	    		addurl = "/systeminfo/BrowserMain.jsp?url="+escape("/workflow/action/SapActionEditSet.jsp?operate=adsap&workflowid=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0");
	  <%
	    	}else{
	    		//�°汾��sap����
	    %>
	    		//zzl
				var args="?workflowId=<%=wfid%>&nodeid=<%=nodeid%>&nodelinkid=<%=linkid%>&ispreoperator=0&workflowid=<%=wfid%>&w_type=1";
				addurl="/integration/browse/integrationBrowerMain.jsp"+args;
		  <%
	    	}
	    %>
	}
	var id_t = window.showModalDialog(addurl,window,"dialogWidth:1000px;dialogHeight:800px;scroll:yes;resizable:yes;")
}
function delRow()
{
	var hasselected = false;
	var dmlids = document.getElementsByName("dmlid");
	//zzl
	var dmlidnewsaps = document.getElementsByName("dmlidnewsap");
	
	if(dmlids&&dmlids.length>0)
	{
		for(var i = 0;i<dmlids.length;i++)
		{
			var dmlid = dmlids[i];
			if(dmlid.checked)
			{
				hasselected = true;
				break;
			}
		}
	}
	
	//zzl
	if(dmlidnewsaps&&dmlidnewsaps.length>0)
	{
		for(var i = 0;i<dmlidnewsaps.length;i++)
		{
			var dmlidnewsap = dmlidnewsaps[i];
			if(dmlidnewsap.checked)
			{
				hasselected = true;
				break;
			}
		}
	}
	
	if(!hasselected)
	{
		//����ѡ����Ҫɾ��������
		alert("<%=SystemEnv.getHtmlLabelName(24244,user.getLanguage())%>!");
		return;
	}
	if (isdel())
	{
		$G("src").value="deletedmlaction";
	    document.SearchForm.submit();
	}
}
function reloadDMLAtion()
{
	document.getElementById("src").value = "savebaseaction";
	document.SearchForm.submit();
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>
