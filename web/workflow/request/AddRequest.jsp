<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>

<%	
User user = new User() ;
user = HrmUserVarify.checkUser(request , response) ;
int userid = 0;
int language = 7;
String logintype = "2";
String userName = "";
if (user==null)
{
user = new User() ;
user.setUid(0);
user.setLanguage(7);
user.setLogintype("2");
}
else
{
 userid = user.getUID();
 logintype = user.getLogintype();
 language = user.getLanguage() ;
 userName =  user.getUsername() ;
}

//��ù������Ļ�����Ϣ
String workflowid = Util.null2String(request.getParameter("workflowid"));
String workflowname = WorkflowComInfo.getWorkflowname(workflowid);
String workflowtype = WorkflowComInfo.getWorkflowtype(workflowid);   //����������
String nodeid= "" ;
String formid= "" ;
String isbill="0";
int helpdocid = 0;

//��õ�ǰ�û���id�����ͺ����ơ��������Ϊ1����ʾΪ�ڲ��û���������Դ����2Ϊ�ⲿ�û���CRM��

if(logintype.equals("1"))
	userName = Util.toScreen(ResourceComInfo.getResourcename(""+userid),language) ;
if(logintype.equals("2"))
	userName = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),language);


//��ѯ�ù������ı�id���Ƿ��ǵ��ݣ�0��1�ǣ��������ĵ�id
RecordSet.executeProc("workflow_Workflowbase_SByID",workflowid);
if(RecordSet.next()){
	formid = Util.null2String(RecordSet.getString("formid"));
	isbill = ""+Util.getIntValue(RecordSet.getString("isbill"),0);
	helpdocid = Util.getIntValue(RecordSet.getString("helpdocid"),0);
}

//��ѯ�ù������ĵ�ǰ�ڵ�id �����Ĺ������Ĵ����ڵ� ��
RecordSet.executeProc("workflow_CreateNode_Select",workflowid);
if(RecordSet.next())  nodeid = Util.null2String(RecordSet.getString(1)) ;


/*����û��Ƿ��д���Ȩ��
RequestCheckUser.setUserid(userid);
RequestCheckUser.setWorkflowid(Util.getIntValue(workflowid,0));
RequestCheckUser.setLogintype(logintype);
RequestCheckUser.checkUser();
int  hasright=RequestCheckUser.getHasright();

if(hasright==0){
	response.sendRedirect("/notice/noright.jsp");
    return;
}*/


//�Բ�ͬ��ģ����˵,���Զ����Լ���ص����ݣ���Ϊ����Ĭ��ֵ�����罫 docid ��ֵ����Ϊ�������Ĭ���ĵ�
//Ĭ�ϵ�ֵ���Ը�������м��ö��Ÿ�

String prjid = Util.null2String(request.getParameter("prjid"));
String docid = Util.null2String(request.getParameter("docid"));
String crmid = Util.null2String(request.getParameter("crmid"));
String hrmid = Util.null2String(request.getParameter("hrmid"));
if(hrmid.equals("") && logintype.equals("1")) hrmid = "" + userid ;
if(crmid.equals("") && logintype.equals("2")) crmid = "" + userid ;

//������������ɺ󽫷��ص�ҳ��
String topage = Util.null2String(request.getParameter("topage"));




//��õ�ǰ�����ں�ʱ��
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String currenttime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                     Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                     Util.add0(today.get(Calendar.SECOND), 2) ;
        
//�����ύ��ʱ����Ҫ��������ֶ���������������ö��Ÿ񿪣�requestnameΪ�½������е�һ�е�����˵������ÿһ�����󶼱����е�
String needcheck="requestname";


//��ʼ���ںͽ������ڱȽ���
String newfromdate="a";
String newenddate="b";

//TopTitle.jsp ҳ�����
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(648,language)+":"
	+SystemEnv.getHtmlLabelName(125,language)+" - "+Util.toScreen(workflowname,language);
String needfav ="1";
String needhelp ="";

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</head>

<BODY>

<%
String createpage = "" ;
String operationpage = "" ;
if(isbill.equals("1")) {
    RecordSet.executeProc("bill_includepages_SelectByID",formid+"");
    if(RecordSet.next())  {
        createpage = Util.null2String(RecordSet.getString("createpage"));
        operationpage = Util.null2String(RecordSet.getString("operationpage"));
    }
}

if( ! createpage.equals("") ) {
%>
    <jsp:include page="<%=createpage%>" flush="true">
    <jsp:param name="workflowid" value="<%=workflowid%>" />
    <jsp:param name="workflowtype" value="<%=workflowtype%>" />
    <jsp:param name="nodeid" value="<%=nodeid%>" />
    <jsp:param name="formid" value="<%=formid%>" />
    <jsp:param name="prjid" value="<%=prjid%>" />
    <jsp:param name="docid" value="<%=docid%>" />
    <jsp:param name="hrmid" value="<%=hrmid%>" />
    <jsp:param name="crmid" value="<%=crmid%>" />
    <jsp:param name="topage" value="<%=topage%>" />
    <jsp:param name="currentdate" value="<%=currentdate%>" />
    <jsp:param name="currenttime" value="<%=currenttime%>" />
    <jsp:param name="topage" value="<%=topage%>" />
    </jsp:include>
<%
} else{ 
    if( operationpage.equals("") ) operationpage = "RequestOperation.jsp" ;
%>
    <form name="frmmain" method="post" action="<%=operationpage%>">
        <%@ include file="WorkflowAddRequestBody.jsp" %>
    </form>
<%}%>


<SCRIPT LANGUAGE=VBS>
sub onShowBrowser(id,url,linkurl,type1,ismand)
	if type1= 2 or type1 = 19 then
		id1 = window.showModalDialog(url,,"dialogHeight:320px;dialogwidth:275px")
		document.all("field"+id+"span").innerHtml = id1
		document.all("field"+id).value=id1
	else
		if type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>45 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
			id1 = window.showModalDialog(url)
		elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
		else
			tmpids = document.all("field"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
		end if
		if NOT isempty(id1) then
			if type1 = 17 or type1 = 18 or type1=27 or type1=37 or type1=45 then
				if id1(0)<> ""  and id1(0)<> "0" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all("field"+id).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("field"+id+"span").innerHtml = sHtml
					
				else
					if ismand=0 then
						document.all("field"+id+"span").innerHtml = empty
					else
						document.all("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("field"+id).value=""
				end if
				
			else	
			   if  id1(0)<>""   and id1(0)<> "0"  then
			        if linkurl = "" then 
						document.all("field"+id+"span").innerHtml = id1(1)
					else 
						document.all("field"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
					end if
					document.all("field"+id).value=id1(0)
				else
					if ismand=0 then
						document.all("field"+id+"span").innerHtml = empty
					else
						document.all("field"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("field"+id).value=""
				end if
			end if
		end if
	end if
end sub


sub getDate(i)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	document.all("datespan"&i).innerHtml= returndate
	document.all("dff0"&i).value=returndate
end sub

</script>
<script language=javascript>
function check_form(thiswins,items)
{
	thiswin = thiswins
	items = items + ",";
	
	for(i=1;i<=thiswin.length;i++)
	{
	tmpname = thiswin.elements[i-1].name;
	tmpvalue = thiswin.elements[i-1].value;
	while(tmpvalue.indexOf(" ") == 0)
		tmpvalue = tmpvalue.substring(1,tmpvalue.length);
	
	if(tmpname!="" &&items.indexOf(tmpname+",")!=-1 && tmpvalue == ""){
		 alert("<%=SystemEnv.getHtmlNoteName(14,language)%>");
		 return false;
		}

	}
	return true;
}

function isdel(){
   if(!confirm("ȷ��Ҫɾ����")){
       return false;
   }
       return true;
   } 


function issubmit(){
   if(!confirm("ȷ��Ҫ�ύ��")){
       return false;
   }
       return true;
   } 
</script>
</body>
</html>



