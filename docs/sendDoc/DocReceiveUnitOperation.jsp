<%@ page language="java" contentType="text/html; charset=GBK" %>



<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.docs.senddoc.DocReceiveUnitConstant" %>

<jsp:useBean id="DocReceiveUnitComInfo" class="weaver.docs.senddoc.DocReceiveUnitComInfo" scope="page" />
<jsp:useBean id="DocReceiveUnitManager" class="weaver.docs.senddoc.DocReceiveUnitManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<%

String method=Util.null2String(request.getParameter("method"));

String receiveUnitId=Util.null2String(request.getParameter("id"));
//String receiveUnitName=Util.null2String(request.getParameter("receiveUnitName"));
String receiveUnitName = Util.fromScreen(request.getParameter("receiveUnitName"),user.getLanguage());
String superiorUnitId=Util.null2String(request.getParameter("superiorUnitId"));
String receiverIds=Util.null2String(request.getParameter("receiverIds"));
String showOrder=Util.null2String(request.getParameter("showOrder"));
int subcompanyid = Util.getIntValue(request.getParameter("subcompanyid"), 0);
String canStartChildRequest=Util.null2String(request.getParameter("canStartChildRequest"));
if(!"0".equals(canStartChildRequest)){
	canStartChildRequest="1";
}
String changeDir=Util.null2String(request.getParameter("changeDir"));
String companyType=Util.null2String(request.getParameter("companyType"));
String isMain=Util.null2String(request.getParameter("isMain"));
boolean ischeckdir = false;
if(companyType.equals("0")) {
	changeDir = "";
}
else {
	//receiverIds = "";
	ischeckdir = true;//DocReceiveUnitComInfo.checkChangeDir(changeDir);//ҳ������DWR���
	if(!ischeckdir) {
%>
<script>alert('<%=SystemEnv.getHtmlLabelName(22943,user.getLanguage())%>!');history.go(-1);</script>
<%
		return;
	}
}

String allSuperiorUnitId="";
String level="0";

if(superiorUnitId.equals("")||superiorUnitId.equals(DocReceiveUnitConstant.RECEIVE_UNIT_ROOT_ID)){
	superiorUnitId=DocReceiveUnitConstant.RECEIVE_UNIT_ROOT_ID;
    allSuperiorUnitId=superiorUnitId;
	level="1";
}else{
    allSuperiorUnitId=DocReceiveUnitComInfo.getAllSuperiorUnitId(superiorUnitId)+","+superiorUnitId;
	level=String.valueOf(Integer.parseInt(DocReceiveUnitComInfo.getLevel(superiorUnitId))+1);
}

if(receiveUnitName!=null){
	receiveUnitName=receiveUnitName.trim();
}

if(method.equals("AddSave")){


	//RecordSet.executeSql("insert into DocReceiveUnit(receiveUnitName,superiorUnitId,receiverIds,allSuperiorUnitId,level,showOrder) values('"+receiveUnitName+"',"+superiorUnitId+",'"+receiverIds+"','"+allSuperiorUnitId+"',"+level+","+showOrder+")");
	//RecordSet.executeSql("insert into DocReceiveUnit(receiveUnitName,superiorUnitId,receiverIds,allSuperiorUnitId,unitLevel,showOrder,subcompanyid) values('"+receiveUnitName+"',"+superiorUnitId+",'"+receiverIds+"','"+allSuperiorUnitId+"',"+level+","+showOrder+","+subcompanyid+")");
	RecordSet.executeSql("insert into DocReceiveUnit(receiveUnitName,superiorUnitId,receiverIds,allSuperiorUnitId,unitLevel,showOrder,subcompanyid,canStartChildRequest,changeDir,companyType,isMain) values('"+receiveUnitName+"',"+superiorUnitId+",'"+receiverIds+"','"+allSuperiorUnitId+"',"+level+","+showOrder+","+subcompanyid+",'"+canStartChildRequest+"','"+changeDir+"','"+companyType+"','"+isMain+"')");


	RecordSet.executeSql(" select max(id) from DocReceiveUnit ");

	if(RecordSet.next()){
		receiveUnitId=Util.null2String(RecordSet.getString(1));
	}


    DocReceiveUnitComInfo.removeDocReceiveUnitCache();
    response.sendRedirect("DocReceiveUnitFrame.jsp?receiveUnitId="+receiveUnitId);
	return;
 }
 else if(method.equals("EditSave")){

    //�ڼ���ı�������,���������¼��ġ����𡱺͡������ϼ����ֶε�ֵ
    if(!superiorUnitId.equals(DocReceiveUnitComInfo.getSuperiorUnitId(receiveUnitId))){
		DocReceiveUnitManager.updateDataOfAllSubReceiveUnit(receiveUnitId,allSuperiorUnitId,level);
	}
    //�޸��˷ֲ�
    if(subcompanyid != Util.getIntValue(DocReceiveUnitComInfo.getSubcompanyid(receiveUnitId))){
		//���������¼��������ֲ�
		boolean isoracle = RecordSet.getDBType().equals("oracle");
		String sql=null;
		if(isoracle){
			sql = "update DocReceiveUnit set subCompanyId="+subcompanyid+"  where ','||allSuperiorUnitId||',' like '%,"+receiveUnitId+",%'";
		}else{
			sql = "update DocReceiveUnit set subCompanyId="+subcompanyid+"  where ','+allSuperiorUnitId+',' like '%,"+receiveUnitId+",%'";
		}
	    RecordSet.executeSql(sql);
    }
    //update by fanggsh 20060919 for TD4529  level�ֶθ�ΪunitLevel  begin
	//RecordSet.executeSql("update DocReceiveUnit set receiveUnitName='"+receiveUnitName+"',superiorUnitId="+superiorUnitId+",receiverIds='"+receiverIds+"',allSuperiorUnitId='"+allSuperiorUnitId+"',level="+level+",showOrder="+showOrder+"   where id="+receiveUnitId);
	//RecordSet.executeSql("update DocReceiveUnit set receiveUnitName='"+receiveUnitName+"',superiorUnitId="+superiorUnitId+",receiverIds='"+receiverIds+"',allSuperiorUnitId='"+allSuperiorUnitId+"',unitLevel="+level+",showOrder="+showOrder+", subcompanyid="+subcompanyid+"  where id="+receiveUnitId);
	RecordSet.executeSql("update DocReceiveUnit set receiveUnitName='"+receiveUnitName+"',superiorUnitId="+superiorUnitId+",receiverIds='"+receiverIds+"',allSuperiorUnitId='"+allSuperiorUnitId+"',unitLevel="+level+",showOrder="+showOrder+", subcompanyid="+subcompanyid+",canStartChildRequest='"+canStartChildRequest+"',changeDir='"+changeDir+"',companyType='"+companyType+"',isMain='"+isMain+"'  where id="+receiveUnitId);
    //update by fanggsh 20060919 for TD4529  level�ֶθ�ΪunitLevel  end

    DocReceiveUnitComInfo.removeDocReceiveUnitCache();
    response.sendRedirect("DocReceiveUnitFrame.jsp?receiveUnitId="+receiveUnitId);
	return;
 }
 else if(method.equals("Delete")){

	RecordSet.executeSql("delete from DocReceiveUnit where id="+receiveUnitId);
	
    superiorUnitId=DocReceiveUnitComInfo.getSuperiorUnitId(""+receiveUnitId);

    DocReceiveUnitComInfo.deleteDocReceiveUnitInfoCache(receiveUnitId);
    response.sendRedirect("DocReceiveUnitFrame.jsp?receiveUnitId="+superiorUnitId);
	return;
 }
%>
