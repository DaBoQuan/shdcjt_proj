<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="weaver.hrm.User" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RequestLogIdUpdate" class="weaver.workflow.request.RequestLogIdUpdate" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;

int workflowRequestLogId = Util.getIntValue(request.getParameter("workflowRequestLogId"),0);
String isSignMustInput= Util.null2String(request.getParameter("isSignMustInput"));
int formSignatureWidth = Util.getIntValue(request.getParameter("formSignatureWidth"),0);
int formSignatureHeight = Util.getIntValue(request.getParameter("formSignatureHeight"),0);
String isFromWorkFlowSignUP= Util.null2String(request.getParameter("isFromWorkFlowSignUP"));
String opener="";
if(isFromWorkFlowSignUP.equals("1")){
	opener="opener.";
}

// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());

   		boolean isSuccess  = RecordSet.executeProc("sysPhrase_selectByHrmId",""+userid); 
   		String workflowPhrases[] = new String[RecordSet.getCounts()];
   		int x = 0 ;
   		if (isSuccess) {
   			while (RecordSet.next()){
   				workflowPhrases[x] = Util.null2String(RecordSet.getString("phraseShort"));
   				x ++ ;
   			}
   		}


			if(workflowRequestLogId<=0){
				int intRecordId=RequestLogIdUpdate.getRequestLogNewId();
            	boolean bSuccess=false;
            	if("oracle".equalsIgnoreCase(RecordSet.getDBType())){
            		bSuccess=RecordSet.executeSql("insert into Workflow_FormSignRemark(requestLogId,remark) values("+intRecordId+",empty_clob())");
            	}else{
            		bSuccess=RecordSet.executeSql("insert into Workflow_FormSignRemark(requestLogId,remark) values("+intRecordId+",'')");
            	}
				if(bSuccess){
					workflowRequestLogId=intRecordId;
				}
			}
%>
		   <script  language="javascript">
		   <%=opener%>document.frmmain.workflowRequestLogId.value=<%=workflowRequestLogId%>;	
			</script>

<%@ include file="/workflow/request/iWebRevisionConf.jsp" %>
<%
    String temStr = request.getRequestURI();
    temStr=temStr.substring(0,temStr.lastIndexOf("/")+1);

	String revisionServerUrl=request.getScheme()+"://"+Util.getRequestHost(request)+temStr+revisionServerName;;
	String revisionClientUrl=request.getScheme()+"://"+Util.getRequestHost(request)+temStr+revisionClientName;

	int RecordID=workflowRequestLogId;
	String UserName=username;
	String Consult_Enabled="1";

    String strInputList="";
	if(workflowPhrases.length>0){
		for (int i= 0 ; i <workflowPhrases.length;i++) {
			String workflowPhrase = workflowPhrases[i] ;
			if(workflowPhrase!=null&&!workflowPhrase.trim().equals("")){
				strInputList+=workflowPhrase+"\\r\\n";
			}
		}
		strInputList = Util.toScreenForJs(strInputList);
	}

%>

<script language=javascript>

//��ʼ������ΪConsult�Ŀؼ�����
function initializtion(){

  document.frmmain.Consult.WebUrl = "<%=revisionServerUrl%>";           //WebUrl:ϵͳ������·������������������������ǩ����Ϣ
  document.frmmain.Consult.RecordID = "<%=RecordID%>";           //RecordID:���ĵ���¼���
  document.frmmain.Consult.FieldName = "Consult";                //FieldName:ǩ�´�����Ը���ʵ����������ӣ�ֻ��Ҫ�޸Ŀؼ����� FieldName ��ֵ�Ϳ���
  document.frmmain.Consult.UserName = "<%=UserName%>";           //UserName:ǩ���û�����
  document.frmmain.Consult.WebSetMsgByName("USERID","<%=user.getUID()%>");          //USERID:ǩ���û�id
  document.frmmain.Consult.Enabled = "<%=Consult_Enabled%>";     //Enabled:�Ƿ������޸ģ�0:������ 1:����  Ĭ��ֵ:1 
  document.frmmain.Consult.PenColor = "#FF0000";                	//PenColor:�ʵ���ɫ��������ҳɫ��ֵ  Ĭ��ֵ:#000000 
  document.frmmain.Consult.BorderStyle = "0";                    //BorderStyle:�߿�0:�ޱ߿� 1:�б߿�  Ĭ��ֵ:1 
  document.frmmain.Consult.EditType = "0";                       //EditType:Ĭ��ǩ�����ͣ�0:ǩ�� 1:����  Ĭ��ֵ:0 
  document.frmmain.Consult.ShowPage = "0";                       //ShowPage:����Ĭ����ʾҳ�棬0:����ӡ��,1:��ҳǩ��,2:������ע  Ĭ��ֵ:0 
  document.frmmain.Consult.InputText = "";                       //InputText:����������Ϣ��  Ϊ���ַ�����Ĭ����Ϣ[�û���+ʱ��]���� 
  document.frmmain.Consult.PenWidth = "1";                      	//PenWidth:�ʵĿ�ȣ�ֵ:1 2 3 4 5   Ĭ��ֵ:2 
  document.frmmain.Consult.FontSize = "14";                      //FontSize:���ִ�С��Ĭ��ֵ:11
  document.frmmain.Consult.ShowMenu = "0";
  document.frmmain.Consult.SignatureType = "<%=SignatureType%>";                  //SignatureType:ǩ����Դ���ͣ�0��ʾ�ӷ��������ݿ��ж�ȡǩ�£�1��ʾ��Ӳ����Կ���ж�ȡǩ�£�2��ʾ�ӱ��ض�ȡǩ�£�����ImageName(����ǩ��·��)��������ʹ��  Ĭ��ֵ:0}
  document.frmmain.Consult.InputList = "<%=strInputList%>"; //InputList:����������ע��Ϣ�б� 
  document.frmmain.Consult.ShowUserListMenu = "true";			//ǩ���û��б��Ƿ���ʾ��"true"Ϊ��ʾ
  document.frmmain.Consult.CASignType = "<%=CASignType%>";//Ĭ��Ϊ����������ǩ��
  document.frmmain.Consult.SetFieldByName("DocEmptyJuggle",<%=DocEmptyJuggle%>);
}

function LoadSignature(){

	enableAllmenu();

    initializtion();                                              //js��ʽ���ÿؼ�����
    document.frmmain.Consult.LoadSignature();                              //����ǩ��������Ϣ
    document.frmmain.Consult.ImgWidth="<%=formSignatureWidth%>";
    document.frmmain.Consult.ImgHeight="<%=formSignatureHeight%>";

	displayAllmenu();

	return true;
}

if (window.addEventListener){
    window.addEventListener("load", LoadSignature, false);
}else if (window.attachEvent){
    window.attachEvent("onload", LoadSignature);
}else{
    window.onload=LoadSignature;
}

//���ã��л���ȡǩ�µ���Դ��ʽ  ���ǩ�´���Consult
function chgReadSignatureType(){
  if (document.frmmain.Consult.SignatureType=="1"){
    document.frmmain.Consult.SignatureType="0";
    alert("<%=SystemEnv.getHtmlLabelName(21436,user.getLanguage())%>");
  }else{
    document.frmmain.Consult.SignatureType="1";
    alert("<%=SystemEnv.getHtmlLabelName(21437,user.getLanguage())%>");
  }
}

var isDocEmpty=0;

//���ã�����ǩ��������Ϣ  
//�������̣��ȱ���ǩ��������Ϣ���ɹ������ύ��DocumentSave�������������Ϣ
function SaveSignature(){

<%if(isSignMustInput.equals("1")){%>
    if(document.frmmain.Consult.DocEmpty){//�ж�ǩ�������Ƿ�Ϊ������
        isDocEmpty=1;
        return false;
    }
<%}%>

  if (document.frmmain.Consult.Modify){                    //�ж�ǩ��������Ϣ�Ƿ��иĶ�
//    if(document.frmmain.Consult.SaveAsJpgEx('iWebRevision_abcd.jpg','All', 'Remote')){
//	  <%=opener%>document.frmmain.workflowRequestLogId.value=document.frmmain.Consult.WebGetMsgByName("RECORDID");
//	  document.frmmain.Consult.RecordID=document.frmmain.Consult.WebGetMsgByName("RECORDID");
      if (!document.frmmain.Consult.SaveSignature()){        //����ǩ��������Ϣ
          return false;
      }
//	}else {
//		return false;
//	}

  }
  <%=opener%>document.frmmain.workflowRequestLogId.value=document.frmmain.Consult.WebGetMsgByName("RECORDID");
  document.frmmain.Consult.RecordID=document.frmmain.Consult.WebGetMsgByName("RECORDID");
  return true;
}

</script>
<%
String isIE = (String)session.getAttribute("browser_isie");
if ("true".equals(isIE)) {
%>
          <table border=0 width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tbody >
          <tr  height='100%'>
            <td>
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' title="" onClick="if (!Consult.OpenSignature()){alert(Consult.Status);}">[<%=SystemEnv.getHtmlLabelName(21431,user.getLanguage())%>]</a>&nbsp;
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' onclick="if (Consult.EditType==0){Consult.EditType=1;}else{Consult.EditType=0;};">[<%=SystemEnv.getHtmlLabelName(21441,user.getLanguage())%>]</a>&nbsp;
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' title="" onClick="Consult.ShowSignature();">[<%=SystemEnv.getHtmlLabelName(21432,user.getLanguage())%>]</a>&nbsp;
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' onclick="Consult.Clear();">[<%=SystemEnv.getHtmlLabelName(21433,user.getLanguage())%>]</a>&nbsp;
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' onclick="Consult.ClearAll();">[<%=SystemEnv.getHtmlLabelName(21434,user.getLanguage())%>]</a>&nbsp;
			  <a style='FONT-SIZE: 9pt;COLOR: #ff0000; FONT-FAMILY: "����";cursor:hand;TEXT-DECORATION: none' onclick="chgReadSignatureType();">[<%=SystemEnv.getHtmlLabelName(21435,user.getLanguage())%>]</a>&nbsp;
            </td>
          </tr>
          </tbody>
          </table>

          <table border=1 width="<%=formSignatureWidth%>" height="<%=formSignatureHeight%>"  cellspacing="0" cellpadding="0" align="left">
          <tbody >
          <tr height='100%'>
            <td id="formSignatureTd" >
<script>
var str = '';
str += '<div id="DivID">';
str += '<OBJECT id="Consult" width="100%" height="100%" classid="<%=revisionClassId%>" codebase="<%=revisionClientUrl%>" >';
str += '</object>';
str += '</div>';
document.write(str);
</script>
            </td>
          </tr>
          </tbody>
          </table>
<%
} else {
%>

<table border=1 width="<%=formSignatureWidth%>" height="<%=formSignatureHeight%>"  cellspacing="0" cellpadding="0" align="left">
    <tr  height='100%'>
    	<td height="100%" width="100%" align="center" style="color:red;font-size:14px;">
			����ǰʹ�õ��������֧�֡���дǩ�¡�������ʹ�øù��ܣ���ʹ��IE�������
        </td>
    </tr>
</table>

<%
}
%>
              <span id="remarkSpan">
<%
	if(isSignMustInput.equals("1")){
%>
			  <img src="/images/BacoError.gif" align=absmiddle>
<%
	}
%>
              </span>
          <input type=hidden name="remark" value="">
