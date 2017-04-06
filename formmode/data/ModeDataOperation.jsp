<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util,java.net.*"%>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.formmode.setup.CodeBuild"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ModeDataManager" class="weaver.formmode.data.ModeDataManager" scope="page"/>
<jsp:useBean id="ModeRightInfo" class="weaver.formmode.setup.ModeRightInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ModeViewLog" class="weaver.formmode.view.ModeViewLog" scope="page"/>


<%
FileUpload fu = new FileUpload(request);
String src = Util.null2String(fu.getParameter("src"));
String iscreate = Util.null2String(fu.getParameter("iscreate"));
int formmodeid = Util.getIntValue(fu.getParameter("formmodeid"),-1);
int formid = Util.getIntValue(fu.getParameter("formid"),-1);
int isbill = 1;
int billid = Util.getIntValue(fu.getParameter("billid"),-1);
if( src.equals("") || formid == -1 || isbill == -1 || formmodeid == -1) {
	out.print("<script>wfforward('/notice/noright.jsp');</script>");
    return ;
}
//�Ƿ����Ե�����ϸ����
int fromImportDetail = Util.getIntValue(fu.getParameter("fromImportDetail"),0);
int pageexpandid = Util.getIntValue(fu.getParameter("pageexpandid"),0);

String viewfrom = Util.null2String(request.getParameter("viewfrom"));
int opentype = Util.getIntValue(request.getParameter("opentype"),0);
int customid = Util.getIntValue(request.getParameter("customid"),0);

ModeDataManager.setSrc(src);
ModeDataManager.setIscreate(iscreate);
ModeDataManager.setFormid(formid);
ModeDataManager.setIsbill(isbill);
ModeDataManager.setBillid(billid);
ModeDataManager.setFormmodeid(formmodeid);
ModeDataManager.setPageexpandid(pageexpandid);
ModeDataManager.setRequest(fu);
ModeDataManager.setUser(user);
boolean savestatus = ModeDataManager.saveModeData();
billid = ModeDataManager.getBillid();

int isfromTab = Util.getIntValue(fu.getParameter("isfromTab"),0);

if(billid > 0 && iscreate.equals("1")){
	CodeBuild cbuild = new CodeBuild(formmodeid);
	String codeStr = cbuild.getModeCodeStr(formid,billid);//���ɱ��
	//System.out.println("codeStr="+codeStr);
	ModeRightInfo.editModeDataShare(user.getUID(),formmodeid,billid);//�½���ʱ����ӹ���
}else if(billid > 0){
	//�༭��ʱ���޸Ľ�ģ���ֶ�Ȩ��
	ModeRightInfo.editModeDataShareForModeField(user.getUID(),formmodeid,billid);//�½���ʱ����ӹ���
}

//���ݱ���ɹ���ִ�нӿ�
if(savestatus&&!src.equals("del")){
	ModeDataManager.doInterface(pageexpandid);
}

//���������־
String operatetype = "2";//���������ͣ� 1���½� 2���޸� 3��ɾ�� 4���鿴
String clientaddress = request.getRemoteAddr();
String operatedesc = "�޸�";
int operateuserid = user.getUID();
int relatedid = billid;
String relatedname = "";
if(billid > 0 && iscreate.equals("1")){
	operatetype = "1";
	operatedesc = "�½�";
}
if(src.equals("del")){
	operatetype = "3";
	operatedesc = "ɾ��";
}

ModeViewLog.resetParameter();
ModeViewLog.setClientaddress(clientaddress);
ModeViewLog.setModeid(formmodeid);
ModeViewLog.setOperatedesc(operatedesc);
ModeViewLog.setOperatetype(operatetype);
ModeViewLog.setOperateuserid(operateuserid);
ModeViewLog.setRelatedid(relatedid);
ModeViewLog.setRelatedname(relatedname);
ModeViewLog.setSysLogInfo();

String messageid = ModeDataManager.getMessageid();//�������Ĵ�����Ϣid
String messagecontent = ModeDataManager.getMessagecontent();//�������Ĵ�����Ϣ����
session.setAttribute(formmodeid+"_"+billid+"_"+messageid,messagecontent);
//���ص�ģ��ҳ�棬���ص��鿴ҳ������б�ҳ�棬���߼����½������߱༭ҳ�棬���߹ر�
if(fromImportDetail == 1){//�Ƿ����Ե�����ϸ����
	response.sendRedirect("/formmode/view/AddFormMode.jsp?isfromTab="+isfromTab+"&modeId="+formmodeid+"&formId="+formid+"&type=2&billid="+billid+"&fromSave=1");
}else if(src.equals("del")){
%>
<script language="javascript">
	if("<%=viewfrom%>"=="fromsearchlist"&"<%=opentype%>"=="1"){
		window.parent.location = "/formmode/search/CustomSearchBySimple.jsp?customid=<%=customid%>";
	}else{
		try{
			parent.window.opener._table.reLoad();	
		}catch(e){
			
		}
		window.parent.close();
	}
</script>
<%
}else{
	%>
	<script language="javascript">
		//var url = escape("/formmode/view/ModeShare.jsp?ajax=1&modeId=<%=formmodeid%>&billid=<%=billid%>");
		//window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
		try{
			parent.window.opener._table.reLoad();	
		}catch(e){
			
		}
		
		window.location.href="/formmode/view/AddFormMode.jsp?isfromTab=<%=isfromTab%>&modeId=<%=formmodeid%>&formId=<%=formid%>&type=0&billid=<%=billid%>&iscreate=<%=iscreate%>&messageid=<%=messageid%>&viewfrom=<%=viewfrom%>&opentype=<%=opentype%>&customid=<%=customid%>";
		
	</script>
	<%
	//response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId="+formmodeid+"&formId="+formid+"&type=0&billid="+billid+"&fromSave=1");
}

%>