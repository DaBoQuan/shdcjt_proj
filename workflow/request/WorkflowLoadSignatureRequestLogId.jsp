<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="weaver.hrm.User" %>

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;

int tempRequestLogId = Util.getIntValue(request.getParameter("tempRequestLogId"),0);
int tempRequestLogIdInit=tempRequestLogId;
String utilRandom=Util.getRandom();
tempRequestLogId=tempRequestLogId+(Util.getIntValue(utilRandom,0)%100000);

// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String username = "";

if(logintype.equals("1"))
	username = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	username = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());



%>


<%@ include file="/workflow/request/iWebRevisionConf.jsp" %>

<%
    String temStr = request.getRequestURI();
    temStr=temStr.substring(0,temStr.lastIndexOf("/")+1);

	String revisionServerUrl=request.getScheme()+"://"+Util.getRequestHost(request)+temStr+revisionServerName;;
	String revisionClientUrl=request.getScheme()+"://"+Util.getRequestHost(request)+temStr+revisionClientName;

	String UserName=username;

%>
          <table border=0  cellspacing="0" cellpadding="0" align="left" >
          <tbody >
          <tr height='100%'>
            <td>
	            <div id="DivID">
		            <OBJECT id="Consult<%=tempRequestLogId%>" width="100%" height="100%" classid="<%=revisionClassId%>" codebase="<%=revisionClientUrl%>" ></object>
	            </div>

<script language=javascript>
//��ʼ������ΪConsult�Ŀؼ�����
function initializtion<%=tempRequestLogId%>(){

  document.getElementById("Consult<%=tempRequestLogId%>").WebUrl = "<%=revisionServerUrl%>";           //WebUrl:ϵͳ������·������������������������ǩ����Ϣ
  document.getElementById("Consult<%=tempRequestLogId%>").RecordID = "<%=tempRequestLogIdInit%>";           //RecordID:���ĵ���¼���
  document.getElementById("Consult<%=tempRequestLogId%>").FieldName = "Consult<%=tempRequestLogId%>";                //FieldName:ǩ�´�����Ը���ʵ����������ӣ�ֻ��Ҫ�޸Ŀؼ����� FieldName ��ֵ�Ϳ���
  document.getElementById("Consult<%=tempRequestLogId%>").UserName = "<%=UserName%>";           //UserName:ǩ���û�����
  document.getElementById("Consult<%=tempRequestLogId%>").WebSetMsgByName("USERID","<%=user.getUID()%>");          //USERID:ǩ���û�id
  document.getElementById("Consult<%=tempRequestLogId%>").Enabled = "0";     //Enabled:�Ƿ������޸ģ�0:������ 1:����  Ĭ��ֵ:1
  document.getElementById("Consult<%=tempRequestLogId%>").PenColor = "#FF0000";                	//PenColor:�ʵ���ɫ��������ҳɫ��ֵ  Ĭ��ֵ:#000000
  document.getElementById("Consult<%=tempRequestLogId%>").BorderStyle = "0";                    //BorderStyle:�߿�0:�ޱ߿� 1:�б߿�  Ĭ��ֵ:1
  document.getElementById("Consult<%=tempRequestLogId%>").EditType = "0";                       //EditType:Ĭ��ǩ�����ͣ�0:ǩ�� 1:����  Ĭ��ֵ:0
  document.getElementById("Consult<%=tempRequestLogId%>").ShowPage = "0";                       //ShowPage:����Ĭ����ʾҳ�棬0:����ӡ��,1:��ҳǩ��,2:������ע  Ĭ��ֵ:0
  document.getElementById("Consult<%=tempRequestLogId%>").InputText = "";                       //InputText:����������Ϣ��  Ϊ���ַ�����Ĭ����Ϣ[�û���+ʱ��]����
  document.getElementById("Consult<%=tempRequestLogId%>").PenWidth = "1";                      	//PenWidth:�ʵĿ�ȣ�ֵ:1 2 3 4 5   Ĭ��ֵ:2
  document.getElementById("Consult<%=tempRequestLogId%>").FontSize = "14";                      //FontSize:���ִ�С��Ĭ��ֵ:11
  document.getElementById("Consult<%=tempRequestLogId%>").ShowMenu = "0";
  document.getElementById("Consult<%=tempRequestLogId%>").SignatureType = "0";                  //SignatureType:ǩ����Դ���ͣ�0��ʾ�ӷ��������ݿ��ж�ȡǩ�£�1��ʾ��Ӳ����Կ���ж�ȡǩ�£�2��ʾ�ӱ��ض�ȡǩ�£�����ImageName(����ǩ��·��)��������ʹ��  Ĭ��ֵ:0}
  document.getElementById("Consult<%=tempRequestLogId%>").InputList = ""; //InputList:����������ע��Ϣ�б�
  document.getElementById("Consult<%=tempRequestLogId%>").ShowUserListMenu = "true";			//ǩ���û��б��Ƿ���ʾ��"true"Ϊ��ʾ

}

 function LoadSignature<%=tempRequestLogId%>(){
    initializtion<%=tempRequestLogId%>();                                              //js��ʽ���ÿؼ�����
    document.getElementById("Consult<%=tempRequestLogId%>").LoadSignature();                              //����ǩ��������Ϣ
    document.getElementById("Consult<%=tempRequestLogId%>").style.width=document.getElementById("Consult<%=tempRequestLogId%>").ImgWidth;
    document.getElementById("Consult<%=tempRequestLogId%>").style.height=document.getElementById("Consult<%=tempRequestLogId%>").ImgHeight;
	return true;
}
LoadSignature<%=tempRequestLogId%>();
</script>
            </td>
          </tr>
          </tbody>
          </table>