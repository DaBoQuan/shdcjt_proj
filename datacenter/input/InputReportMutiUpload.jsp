<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ page import="java.io.File" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
/********* @2007-08-08 Add by yeriwei! **********************/
private weaver.conn.RecordSet rs1=null;
private HttpServletRequest req=null;

private String[] getReportDates(String inprepfrequence,int lang){
	String currentdate = Util.null2String(req.getParameter("currentdate"));
	String year = Util.null2String(req.getParameter("year"));
	String month = Util.null2String(req.getParameter("month"));
	String day = Util.null2String(req.getParameter("day"));
	String date = Util.null2String(req.getParameter("date"));
	String thedate = currentdate;
	String dspdate = currentdate ;
	switch(Util.getIntValue(inprepfrequence)) {
		case 1:
			thedate = year + "-01-15" ;
			dspdate = year ;
			break ;
		case 2:
			thedate = year + "-"+month+"-15" ;
			dspdate = year + "-"+month ;
			break ;
		case 3:
			thedate = year + "-"+month+"-"+day ;
			dspdate = year + "-"+month ;
			if(day.equals("05")) dspdate += " ��Ѯ" ;
			if(day.equals("15")) dspdate += " ��Ѯ" ;
			if(day.equals("25")) dspdate += " ��Ѯ" ;
			break ;
        case 4:
            thedate = date;
            Calendar today = Calendar.getInstance();
            today.set(Calendar.YEAR,Util.getIntValue(date.substring(0,4)));
            today.set(Calendar.MONTH,Util.getIntValue(date.substring(5,7))-1);
            today.set(Calendar.DAY_OF_MONTH,Util.getIntValue(date.substring(8)));
            dspdate = Util.add0(today.get(Calendar.YEAR), 4) + " ��" + Util.add0(today.get(Calendar.WEEK_OF_YEAR), 2) + "��";
            break;
		case 5:
			thedate = date ;
			dspdate = date ;
			break ;
        case 6:
            thedate = year + "-"+month+"-15" ;
            dspdate = year;
            if(month.equals("01")) dspdate += " �ϰ���" ;
			if(month.equals("07")) dspdate += " �°���" ;
            break;
		case 7:
			thedate = year + "-"+month+"-15" ;
            dspdate = year;
            if(month.equals("01")) dspdate += " һ����" ;
			if(month.equals("04")) dspdate += " ������" ;
            if(month.equals("07")) dspdate += " ������" ;
            if(month.equals("10")) dspdate += " �ļ���" ;
            break;
    }
	return new String[]{thedate,dspdate};
}

/**
 * ����ֵ��String[0]-0 ������1 �Ѵ������ݣ�2 �����ѵ��룬���ڲݸ�״̬
 *  String[1-2] �Ǳ���getReportDates�������������ݷ���
 * @return int 
 **/
private String[] checkReportData(String sTableName,int userId,int lang){
	String inpRepFrequence=Util.null2String(req.getParameter("inprepfrequence"));
	String crmid = Util.null2String(req.getParameter("crmid"));
	String date = Util.null2String(req.getParameter("date"));
	String[] reportDates=new String[]{date,date};//��ʾĬ��Ϊ�������������ƣ�ֱ��Ϊ�û�ѡ�����ڡ�
	//boolean isFrequence=!inpRepFrequence.equalsIgnoreCase("0");//true��ʾ�б�������
	reportDates=this.getReportDates(inpRepFrequence,lang);

	String sql=null;
	int ret=0;
	if(!inpRepFrequence.equalsIgnoreCase("0"))
		sql="SELECT inputid,inputstatus FROM "+sTableName+" WHERE inprepdspdate='"+reportDates[1]+"' AND crmid="+crmid+" AND reportuserid="+userId;
	else//�����������޶�
		sql="SELECT inputid,inputstatus FROM "+sTableName+" WHERE crmid="+crmid+" AND reportuserid="+userId;
		
	rs1.executeSql(sql);
	if(rs1.next()){
		String status=Util.null2String(rs1.getString("inputstatus"));
		ret=status.equalsIgnoreCase("9")?2:1;//status==9,��ʾ�ѵ������ݣ������ڲݸ�״̬�С�
	}//�����ڼ�¼����ʾĬ�ϱ����в��������ݡ�
	return new String[]{String.valueOf(ret),reportDates[0],reportDates[1]};
}
/******************************/

/** ��ȡҳ�洫�ݹ��������в������� */
	private String getRequestParmHtmlString(){
		StringBuffer str=new StringBuffer();
		Enumeration e0=req.getParameterNames();
		String keyName=null;
		while(e0.hasMoreElements()){
			keyName=e0.nextElement().toString();
			str.append("<input type=\"hidden\" ");
			str.append(" name=\""+keyName+"\"");
			str.append(" value=\""+req.getParameter(keyName)+"\"");
			str.append(">\n");
		}
		return str.toString();
	}
	
	private String checkCustomeTemplate(String inpreptablename,String reportHrmId){
		inpreptablename="User_"+inpreptablename;
		String fname=inpreptablename+reportHrmId+".xls";
		String savePath = GCONST.getRootPath()+"datacenter" + File.separatorChar + "inputexcellfile" + File.separatorChar;
		File f=new File(savePath + fname);
		if(!f.exists()){
			fname=inpreptablename+"0.xls";
			f=new File(savePath+fname);
			if(!f.exists())fname=null;
		}
		return fname;	
	}
	
	
private int langFlag=7;
private String getLabel(int labelId){//��ȡ���Ա�ǩ
	return SystemEnv.getHtmlLabelName(labelId,this.langFlag);
}
%>
<html><head>
<link href="/css/Weaver.css" type="text/css" rel="stylesheet">
<script language="javascript" src="/js/weaver.js"></script>
</head>
<%
this.langFlag=user.getLanguage();
String inprepid = Util.null2String(request.getParameter("inprepid"));
String crmid = Util.null2String(request.getParameter("crmid"));
String reportHrmId=Util.null2String(request.getParameter("reportHrmId"));
String fromcheck = Util.null2String(request.getParameter("fromcheck"));
String inprepfrequence=Util.null2String(request.getParameter("inprepfrequence"));

rs.executeProc("T_InputReport_SelectByInprepid",""+inprepid);
rs.next() ;

String inprepname = Util.toScreenToEdit(rs.getString("inprepname"),user.getLanguage()) ;
String inpreptablename = Util.null2String(rs.getString("inpreptablename")) ;
/********* @2007-08-08 Add by yeriwei! **********************/
String multiLine = Util.null2String(rs.getString("isInputMultiLine")) ;
boolean isMultiLine=multiLine.equalsIgnoreCase("1");
this.rs1=rs;
this.req=request;
String[] chkResult=this.checkReportData(inpreptablename,user.getUID(),user.getLanguage());
int chkRet=Integer.parseInt(chkResult[0]);

String strMsg="";//��Ҫ�ڿͻ��˽ű�����ʾ����Ϣ
int msgFlag=0;//0 ����ʾ��1����ʾ��Ϣȷ�Ͽ���ת��2 ��ʾ��Ϣȷ�Ͽ�����Hidden��3 ��ʾ�Ի���ֱ��ת�������Ѵ���
if(chkRet==1){//�ѵ���������ʾ
	strMsg=chkResult[2]+" "+this.getLabel(20775);//���������Ѵ���;
	msgFlag=3;
}if(chkRet==2){//���ݴ��ڲݸ�״̬
	if(isMultiLine){//�Ƿ������������ݡ�
		strMsg=chkResult[2]+" "+this.getLabel(20776);//���������ڴ��ڲݸ�״̬������������(Y/N)";
		msgFlag=1;
	}else{
		strMsg=this.getLabel(20777);//"��ǰ����Ϊ�������ݣ��������ݴ��ڲݸ�״̬,�Ƿ��븲��(Y/N)";
		msgFlag=2;
	}
}

String reportDates=chkResult[1]+"|"+chkResult[2];//�洢���������reportDate|dspDate
/********************************************************/

String modulefilename = "" ;
if(fromcheck.equals("1") || fromcheck.equals("2")) modulefilename = inpreptablename + "2" ;
else modulefilename = inpreptablename + "1" ;

String imagefilename = "/images/hdHRMCard.gif";
String titlename = Util.toScreen(SystemEnv.getHtmlLabelName(15184,user.getLanguage()),user.getLanguage(),"0") + ":" + inprepname;
String needfav ="1";
String needhelp ="";
%>
<body>

<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:dosubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep;

RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onReturn(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form id=frmMain name=frmMain action="InputReportMutiUploadOperation.jsp" method=post enctype="multipart/form-data">
<input type="hidden" name="inprepfrequence" value="<%=inprepfrequence%>">
<input type="hidden" name="isOverWriter" id="isOverWriter" value="false"><!--Ĭ��Ϊ�����ڣ����������ݣ�����Ϊɾ��ԭ�ȵ�-->
<input type="hidden" name="reportDates" value="<%=reportDates%>">
<input type="hidden" name="reprotHrmId" value="<%=reportHrmId%>">
<input type="hidden" name="inprepid" value="<%=inprepid%>">
<input type="hidden" name="inprepname" value="<%=inprepname%>">
<input type="hidden" name="fromcheck" value="<%=fromcheck%>">
<input type="hidden" name="crmid" value="<%=crmid%>">
<input type="hidden" name="redirectFormString" id="redirectFormString" value="">
<input type="hidden" name="returnUrl" id="returnUrl" value="">
<!-- ��������ִ�гɹ���ת�������ַ��� -->


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
		<table class=Shadow>
		<tr>
		<td valign="top">

  <table class="viewform" width="100%">
    <tr > 
      <td colspan="2"><nobr><b><%=inprepname%></b></td>
      </tr>
   <tr><td class=Line1 colSpan=2></td></tr> 
   <tr> 
      <td><%=this.getLabel(18493)+this.getLabel(63)%><!--�ļ�����--></td>
      <td width="88%" class=Field>
	  <label for="txtFile"><input type="radio" name="filetype" id="txtFile" value="1"><%=this.getLabel(19110)%><!--�ı�����-->(*.txt)</label>&nbsp;&nbsp;&nbsp;
	  <label for="sysExcelFile"><input name="filetype" type="radio" id="sysExcelFile" value="2" checked>
	  <%=this.getLabel(468)%>Excel<%=this.getLabel(64)%>(*.xls)<!--ϵͳExcelģ�� --></label>&nbsp;&nbsp;&nbsp;
<%
String userExcelTemplate=this.checkCustomeTemplate(inpreptablename,reportHrmId);
if(userExcelTemplate!=null){
%><label for="customExcelFile"><input type="radio" name="filetype" id="customExcelFile" value="3"><%=this.getLabel(73)%>Excel<%=this.getLabel(64)%><!--�Զ���ģ��-->(*.xls)</label>
<%}%></td>
    </tr> <tr><td class=Line colSpan=2></td></tr>
    <tr> 
      <td><%=this.getLabel(18493)%><!--�ļ�--></td>
      <td class=Field><input type="file" id="file1" name="file1" class=inputstyle size=60 onChange="dochange(this)">
        <span id="filespan" name="filespan"><img src='/images/BacoError.gif' align='absMiddle'></span ></td>
    </tr>
	<tr><td class="Line" colSpan="3"></td></tr>
</tbody> 
  </table>
<br>
  <table class="viewform" width="100%">
    <tr > 
      <td colspan=2><nobr><b><%=this.getLabel(20774)%><!--����ģ�弰�ע������--></b></td>
    </tr>
   <tr><td class=Line1 colSpan=2></td></tr> 
   <tr> 
      <td width="12%"><%=this.getLabel(258)+this.getLabel(64)%><!--����ģ��--></td>
      <td width="88%" class=Field><a href='/datacenter/inputexcellfile/<%=inpreptablename+reportHrmId%>.txt' target="_blank"><%=this.getLabel(19110)+this.getLabel(64)%><!--�ı�����ģ��--></a>&nbsp;
	  <a href='/datacenter/inputexcellfile/<%=inpreptablename+reportHrmId%>.xls' target="_blank"><%=this.getLabel(468)%>Excel<%=this.getLabel(64)%><!--ϵͳExcel�ļ�ģ��--></a>&nbsp;
	  <%//TD7493
		if(userExcelTemplate!=null){%>
			<a href="/datacenter/inputexcellfile/<%=userExcelTemplate%>" target="_blank"><%=this.getLabel(73)+this.getLabel(64)%></a>
		<%}%>
	  </td>
    </tr> 
    <tr><td class=Line colSpan=2></td></tr>
    <tr> 
      <td width="12%"><%=this.getLabel(15736)%><!--ע������--></td>
      <td width="88%" class=Field>
        <ol>
		<li><%=SystemEnv.getHtmlLabelName(23253,user.getLanguage()) %></li>
		<li><%=SystemEnv.getHtmlLabelName(23254,user.getLanguage()) %></li>
        <li><%=SystemEnv.getHtmlLabelName(23255,user.getLanguage()) %></li>
        </ol></td>
    </tr> 
    <tr><td class=Line1 colSpan=2></td></tr> 
    </tbody> 
  </table>
  
		</td>
		</tr>
		</table>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

</form>
<!-- ����ҳ��ת�򴫵������õı� -->
<form name="redirectForm" id="redirectForm" action="" method="post">
<%=this.getRequestParmHtmlString()%>
</form>
<script language=javascript>
String.prototype.endsWith=function(suffix){
	return this.substring(this.length-suffix.length).toLowerCase()==suffix.toLowerCase();
}

function onReturn(){
	window.history.back(-1);
}

function dochange(obj){
    if(obj.value==""){
        document.getElementById("filespan").innerHTML="<img src='/images/BacoError.gif' align='absMiddle'>";
    }else{
        document.getElementById("filespan").innerHTML="";
    }
}

function dosubmit() {
    if(check_form(document.frmMain,'file1')) {
		var fname=document.getElementById("file1").value;
		var filetype=2;
		if(document.getElementById("txtFile").checked) filetype=1;
		if((filetype==1 && !fname.endsWith(".txt")) || (filetype==2 && !fname.endsWith(".xls"))){
			alert("<%=SystemEnv.getHtmlLabelName(23256,user.getLanguage()) %>");
			return;
		}
		var frm=document.getElementById("redirectForm");
		document.getElementById("redirectFormString").value=frm.innerHTML;
		document.getElementById("returnUrl").value=sUrl;
        document.frmMain.submit() ;
    }
}

var isMutilLine=<%=isMultiLine?"true":"false"%>;
var sUrl=isMutilLine?"InputReportMtiData.jsp":"InputReportData.jsp";
function confirmMsg(){
	//0 ����ʾ��1����ʾ��Ϣȷ�Ͽ���ת��2 ��ʾ��Ϣȷ�Ͽ�����Hidden��3 ��ʾ�Ի���ֱ��ת�������Ѵ���
	var str="<%=strMsg%>";
	var msgFlag=<%=msgFlag%>;
	var frm=document.getElementById("redirectForm");
	frm.action=sUrl;
	switch(msgFlag){
		case 1:
			if(!confirm(str))
				frm.submit();
		break;
		case 2:
			if(confirm(str))
				document.getElementById("isOverWriter").value="true";
			else 
				frm.submit();
		break;
		case 3:
			alert(str);
			frm.submit();
		break;
		default:
		
	}//End switch.
}

confirmMsg();
</script>
</body></html>
