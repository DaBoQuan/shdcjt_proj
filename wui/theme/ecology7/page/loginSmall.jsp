<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ page import="weaver.general.Util,weaver.general.MathUtil,weaver.general.GCONST,weaver.general.StaticObj,
                 weaver.hrm.settings.RemindSettings"%>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="java.net.*" %>

<%@ page import="weaver.hrm.settings.BirthdayReminder" %>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="suc" class="weaver.system.SysUpgradeCominfo" scope="page" />
<%
String dlflg = request.getParameter("dlflg");
String usernamep = request.getParameter("username");
String templateId = Util.null2String(request.getParameter("templateId"));
String templateType = "";
String imageId = "";
String imageId2 = "";
String loginTemplateTitle="";
String backgroundColor = "";
int extendloginid=0;


%>

<%
String formmethod = "post";
if(!"".equals(Util.null2String(BaseBean.getPropValue("ldap", "domain")))){
    formmethod = "get";
}
String host = Util.getRequestHost(request);
GCONST.setHost(host);
String acceptlanguage = request.getHeader("Accept-Language");
if(!"".equals(acceptlanguage))
    acceptlanguage = acceptlanguage.toLowerCase();
String hostaddr = "";
String mainControlIp ="";
try
{
 InetAddress ia = InetAddress.getLocalHost();
 hostaddr = ia.getHostAddress();
}
catch(Exception e)
{   
}




int upgreadeStatus= suc.getUpgreadStatus();
//���������нű�ִ�г���
if (upgreadeStatus==1) {
    out.println("<style>.updating{margin:50px 0 0 50px;font-family:MS Shell Dlg,Arial;font-size:14px;font-weight:bold}</style>");
    out.println("<script>document.write('<div class=updating><img src=\"/images/icon_inprogress.gif\"><br/>�������ɹ��������ű����󣬴�����־λ��"+suc.getUpgreadLogPath()+"��������ϵ��Ӧ�̣�</div>');</script>");
    return;
}
//�����������쳣��ֹ
if (upgreadeStatus==2) {
    out.println("<style>.updating{margin:50px 0 0 50px;font-family:MS Shell Dlg,Arial;font-size:14px;font-weight:bold}</style>");
    out.println("<script>document.write('<div class=updating><img src=\"/images/icon_inprogress.gif\"><br/>�������ɹ������������з������쳣��ֹ����������Resin��������ϵ��Ӧ�̣�</div>');</script>");
    return;
}
//��������ִ���쳣
if (upgreadeStatus==3) {
    out.println("<style>.updating{margin:50px 0 0 50px;font-family:MS Shell Dlg,Arial;font-size:14px;font-weight:bold}</style>");
    out.println("<script>document.write('<div class=updating><img src=\"/images/icon_inprogress.gif\"><br/>�������ɹ������������������ϵ��Ӧ�̣�</div>');</script>");
    return;
}

//String templateId="",templateType="",imageId="",loginTemplateTitle="";
//int extendloginid=0;

String sqlLoginTemplate = "SELECT * FROM SystemLoginTemplate WHERE isCurrent='1'";  

rs.executeSql(sqlLoginTemplate);
if(rs.next()){
    templateId=rs.getString("loginTemplateId");
    templateType = rs.getString("templateType");
    imageId = rs.getString("imageId");
    loginTemplateTitle = rs.getString("loginTemplateTitle");
    extendloginid = rs.getInt("extendloginid");
    out.println("<script language='javascript'>document.title='"+loginTemplateTitle+"';</script>");
}

//modify by mackjoe at 2005-11-28 td3282 �ʼ����ѵ�½��ֱ�ӵ�ָ������
String gopage=Util.null2String(request.getParameter("gopage"));
// add by dongping for TD1340 in 2004.11.05
// add a cookie in our system
Cookie ckTest = new Cookie("testBanCookie","test");
ckTest.setMaxAge(-1);
ckTest.setPath("/");
response.addCookie(ckTest);

//xiaofeng, usbӲ������ 

RemindSettings settings=(RemindSettings)application.getAttribute("hrmsettings");
if(settings==null){
    BirthdayReminder birth_reminder = new BirthdayReminder();
    settings=birth_reminder.getRemindSettings();
    if(settings==null){
        out.println("Cann't create connetion to database,please check your database.");
        return;
    }
    application.setAttribute("hrmsettings",settings);
}
String needusb=settings.getNeedusb();
String usbType = settings.getUsbType();
String firmcode=settings.getFirmcode();
String usercode=settings.getUsercode();
String OpenPasswordLock = settings.getOpenPasswordLock();

String needdactylogram = settings.getNeedDactylogram(); 
//String canmodifydactylogram = settings.getCanModifyDactylogram();
String loginid=Util.null2String((String)session.getAttribute("tmploginid1"));
String message0 = Util.null2String(request.getParameter("message")) ;
//��������̬�����   ˢ��ҳ�� �����·��͵�����  20931
if((message0.equals("57") || message0.equals("101")) && loginid.equals("")){
     loginid = "";
     message0 = "";
     }
String message=message0;
if(message0.equals("nomatch")) message = "";
if(!message.equals("")) message = SystemEnv.getErrorMsgName(Util.getIntValue(message0),7) ;
if("16".equals(message0)){
    if("1".equals(OpenPasswordLock)){
        loginid=Util.null2String((String)session.getAttribute("tmploginid1"));
        String sql = "select sumpasswordwrong from hrmresource where loginid='"+loginid+"'";
        rs1.executeSql(sql);
        rs1.next();
        int sumpasswordwrong = Util.getIntValue(rs1.getString(1));
        int sumPasswordLock = Util.getIntValue(settings.getSumPasswordLock(),3);
        int leftChance = sumPasswordLock-sumpasswordwrong;
        if(leftChance==0){
            sql = "update HrmResource set passwordlock=1,sumpasswordwrong=0 where loginid='"+loginid+"'";
            rs1.executeSql(sql);
            message0 = "110";
        }else{
            message = SystemEnv.getHtmlLabelName(24466,7)+leftChance+SystemEnv.getHtmlLabelName(24467,7);
        }
    }
}
session.removeAttribute("tmploginid1");
if(message0.equals("16")) {
    loginid = "";
} 
if(message0.equals("101")) {
    //loginid=Util.null2String((String)session.getAttribute("tmploginid"));
    //session.removeAttribute("tmploginid");
    message=SystemEnv.getHtmlLabelName(20289,7);
}
if(message0.equals("110")) 
{
    loginid = "";
    int sumPasswordLock = Util.getIntValue(settings.getSumPasswordLock(),3);
    message=SystemEnv.getHtmlLabelName(24593,7)+sumPasswordLock+SystemEnv.getHtmlLabelName(18083,7)+"��"+SystemEnv.getHtmlLabelName(24594,7);
}
if((message0.equals("101")||message0.equals("57"))&&loginid.equals("")){
    message="";
}
String logintype = Util.null2String(request.getParameter("logintype")) ;
if(logintype.equals("")) logintype="1";

//IE �Ƿ�����ʹ��Cookie
String noAllowIe = Util.null2String(request.getParameter("noAllowIe")) ;
if (noAllowIe.equals("yes")) {
    message = "IE��ֹCookie";
}

//�û�������������ʾ��Ϣ
if (message0.equals("26")) { 
    message = SystemEnv.getHtmlLabelName(23656,7);
}

//add by sean.yang 2006-02-09 for TD3609
int needvalidate=settings.getNeedvalidate();//0: ��,1: ��
int validatetype=settings.getValidatetype();//��֤�����ͣ�0�����֣�1����ĸ��2������
int islanguid = 0;//7: ����,9: ��������,8:Ӣ��
Cookie[] systemlanid= request.getCookies();
for(int i=0; (systemlanid!=null && i<systemlanid.length); i++){
    //System.out.println("ck:"+systemlanid[i].getName()+":"+systemlanid[i].getValue());
    if(systemlanid[i].getName().equals("Systemlanguid")){
        islanguid = Util.getIntValue(systemlanid[i].getValue(), 0);
        break;
    }
}
boolean ismuitlaguage = false;
StaticObj staticobj = null;
staticobj = StaticObj.getInstance();
String multilanguage = (String)staticobj.getObject("multilanguage") ;
if(multilanguage == null) {
    VerifyLogin.checkLicenseInfo();
    multilanguage = (String)staticobj.getObject("multilanguage") ;
}
if(multilanguage.equals("y")){
    ismuitlaguage = true;
}
%>

<%
if(message0.equals("46")){
%>
<script language="JavaScript">
flag=confirm('�����ܻ�û��Ϊusb���ư�װ�������򣬰�װ�밴ȷ��')
if(flag){
    <%if("1".equals(usbType)){%>
        window.open("/weaverplugin/WkRt.exe")
    <%}else{%>
        window.open("/weaverplugin/HaiKeyRuntime.exe")
    <%}%>
}
</script>
<%}%>
<%@page import="weaver.login.VerifyLogin"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title><%=loginTemplateTitle %></title>
<SCRIPT type=text/javascript src="/wui/common/jquery/jquery.js"></SCRIPT>


<SCRIPT language=javascript1.1>
var flag_now = true;//��־�Ƿ�ǰ�û���true���ǡ�false����
// ��֤�û���¼
function checkall()
{ 
    var dactylogram = "";
    if(document.all("dactylogram")) dactylogram = document.all("dactylogram").value;
    if(dactylogram == ""){
		var i=0;
		var j=0;
		var errMessage="";
		if (form1_login.loginid.value=="") {errMessage=errMessage+"�������û���:";i=i+1;}
		if (form1_login.userpassword.value=="") {errMessage=errMessage+"����������\n";j=j+1;}
		if (i>0){
			$("#msg_show").html(errMessage);form1_login.loginid.focus(); return false ;
		}else if(j>0){
			$("#msg_show").html(errMessage);form1_login.userpassword.focus(); return false ;
		}
		form1_login.username.value = "<%=usernamep%>";
		//��֤��¼���Ƿ���ͬһ���˺�
        if(form1_login.username.value != ""  &&  form1_login.loginid.value !=       form1_login.username.value){
		   
		   if(window.confirm("����,�����ǵ�ǰ��¼�û�;\r����¼��,��ǰ�û���Ϣ�ᶪʧ,�Ƿ����?")){
			    $("#msg_show").html("������֤,���Ժ�...");
				<%if(needusb!=null&&needusb.equals("1")){%>
				  checkusb();
				<%}%>
               flag_now = false;
				//ajax��֤�û���¼
				var ctxpath ='<%=request.getContextPath()%>';
				//��ȡ�����е���Ϣ
				var queryString = jQuery("#form1_login").serialize();
				$.post(ctxpath+'/login/VerifyLoginSmall.jsp',queryString,checkall_callback);
			}else{
			    return false;
			}
		}else{
		    <%if(needusb!=null&&needusb.equals("1")){%>
				checkusb();
			<%}%>
		    flag_now = true;
			//ajax��֤�û���¼
			var ctxpath ='<%=request.getContextPath()%>';
			//��ȡ�����е���Ϣ
			var queryString = jQuery("#form1_login").serialize();
			$("#msg_show").html("������֤,���Ե�...");
			$.post(ctxpath+'/login/VerifyLoginSmall.jsp',queryString,checkall_callback);
		}

	}
}

function diag_qx_click(){
	parent.window.location.reload();
}

//ȥ���ַ���ǰ��Ŀո�
function String.prototype.trim(){   
    return this.toString().replace(/(^\s*)|(\s*$)/g, "");   
} 


//ajax��֤�û���¼�ص�����
function checkall_callback(databack){
   var message = databack.trim();//��̨���ص���Ϣ
   if(message == "success"){//��ʾ��¼�ɹ�
      if(flag_now){		
		  //����˺ź�����
		  $("#msg_show").html("������֤,���Ժ�...");
		  form1_login.get_focus.focus();
		   parentDialog.close();
	  }else{
	      parent.window.location.reload();
	  }
   }else if(message == "45"){//��ʾ��Ҫ����USBKEY
      //alert("�����USBKEY,лл");
	  $("#msg_show").html("�����USBKEY,лл");
   }else if(message == "19"){//��ʾLicense����
      //alert("����֤license�Ƿ����,лл");
	  $("#msg_show").html("����֤license�Ƿ����,лл");
   }else if(message == "dactylogram_n"){//��ʾ��Ҫָ�Ƶ�¼
      //alert("�������ȡָ��,лл");
	 $("#msg_show").html("�������ȡָ��,лл");
   }else{//��ʾ�û��������벻��ȷ
      //alert("�˺Ż����벻��ȷ!");
	 $("#msg_show").html("�˺Ż����벻��ȷ��");
   }
}




var dactylogramStr = "";
var intervalID = 0;
//--------------------------------------------------------------//
// �ɼ�ָ������
//--------------------------------------------------------------//
function FingerSample(){
    init();
    if(dactylogramStr==""){
        OpenDevice();
        if(openStatus==1){
            iRet = dtm.GetExtractMBSimple();
            if(iRet != 0){
                      if(intervalID!=0) window.clearInterval(intervalID);
                intervalID = setTimeout("FingerSample()", 2000);
            }else{
                if(intervalID!=0) window.clearInterval(intervalID);
                if(intervalID2!=0) window.clearInterval(intervalID2);
                dactylogramStr = dtm.strInfo;
                document.all("dactylogram").value=dactylogramStr;
                form1_login.submit();
            }
            CloseDevice();
        }
    }
    if(intervalID!=0) window.clearInterval(intervalID);
    intervalID = setTimeout("FingerSample()", 2000);    
}

var openStatus = 0;
function OpenDevice()
{
    openStatus = 0;
    dtm.DataType = 0;
    iRet = dtm.EnumerateDevicesSimple();
    if(iRet == 0){
        devInfo = dtm.strInfo;
        devNum = devInfo.split(",")[1];
        iRet = dtm.OpenDevice(devNum);
        if(iRet == 0){
            openStatus = 1;
        }
    }
}
function CloseDevice()
{
    iRet = dtm.CloseDevice();
}
function init(){
    try{
        OpenDevice();
        if(openStatus != 1){
            document.all("dactylogramLoginImgId").src="/images/loginmode/3.gif";
            if(intervalID2!=0) window.clearInterval(intervalID2);
            intervalID2=setTimeout("init()", 100);
        }else{
            if("<%=message0%>"=="nomatch") document.all("dactylogramLoginImgId").src="/images/loginmode/2.gif";
            else document.all("dactylogramLoginImgId").src="/images/loginmode/1.gif";
            if(intervalID2!=0) window.clearInterval(intervalID2);
            if(document.getElementById("onDactylogramOrPassword").value==0){
                if(intervalID!=0) window.clearInterval(intervalID);
                intervalID=setTimeout("FingerSample()", 2000);
            }
        }
        CloseDevice();
    }catch(e){}
}
if("<%=needdactylogram%>"=="1"||"<%=message0%>"=="nomatch"){
    if(intervalID!=0) window.clearInterval(intervalID);
    if(intervalID2!=0) window.clearInterval(intervalID2);
        intervalID2=setTimeout("init()", 100);
    intervalID=setTimeout("FingerSample()", 2000);
}
var intervalID2=0;
if(<%=GCONST.getONDACTYLOGRAM()%>&&"<%=needdactylogram%>"=="1") intervalID2=setTimeout("init()", 100);
function changeLoginMode(modeid){
    if(modeid==0){
        document.all("dactylogramLogin").style.display = "";
        document.all("passwordLogin").style.display = "none";
        document.all("loginModeTable").style.margin = "100px 0 0 475px";
        if(intervalID2!=0) window.clearInterval(intervalID2);
        init();
        if(openStatus==1) intervalID=setTimeout("FingerSample()", 2000);
    }
    if(modeid==1){
        document.all("dactylogramLogin").style.display = "none";
        document.all("passwordLogin").style.display = "";
        if("<%=message0%>"=="nomatch"){
            document.all("loginModeTable").style.margin = "150px 0 0 475px";
            document.all("loginPasswordTable").style.margin = "0 0 0 570px";
        }else{
            document.all("loginModeTable").style.margin = "0 0 35px 475px";
        }
        if(intervalID!=0) window.clearInterval(intervalID);
        if(intervalID2!=0) window.clearInterval(intervalID2);
    }
}
function VchangeLoginMode(modeid){
    if(modeid==0){
        document.all("dactylogramLoginV").style.display = "";
        document.all("passwordLoginV").style.display = "none";
        setTimeout("FingerSample()", 500);
    }
    if(modeid==1){
        document.all("dactylogramLoginV").style.display = "none";
        document.all("passwordLoginV").style.display = "";
        if(intervalID!=0) window.clearInterval(intervalID);
    }
}
function changeLoginMethod(methodtype){
    document.getElementById("loginid").disabled = true;
}

//add by sean.yang 2006-02-09 for TD3609
function changeMsg(msg)
{
    if(msg==0){
        if(document.all.validatecode.value=='������������֤��') 
            document.all.validatecode.value='';
    }else if(msg==1){
        if(document.all.validatecode.value=='') 
            document.all.validatecode.value='������������֤��';
    }
}
// -->
</SCRIPT>



<%if(needusb!=null&&needusb.equals("1")){%>
    <%if("1".equals(usbType)){%>
    <script language="JavaScript">
        function checkusb(){ 
          try{
            rnd=Math.round(Math.random()*1000000000);
            form1_login.rnd.value=rnd;
            wk = new ActiveXObject("WIBUKEY.WIBUKEY");
            MyAuthLib=new ActiveXObject("WkAuthLib.WkAuth");
            wk.FirmCode = <%=firmcode%>;
            wk.UserCode = <%=usercode%>;
            wk.UsedSubsystems = 1;
            wk.AccessSubSystem() ;
            if(wk.LastErrorCode==17){      
              form1_login.serial.value='0';
              return;      
            }      
           if(wk.LastErrorCode>0){
              throw new Error(wk.LastErrorCode);
              }    
            wk.UsedWibuBox.MoveFirst();
            MyAuthLib.Data=wk.UsedWibuBox.SerialText;     
            MyAuthLib.FirmCode = <%=firmcode%>;
            MyAuthLib.UserCode = <%=usercode%>;
            MyAuthLib.SelectionCode= rnd;
            MyAuthLib.EncryptWk();
            form1_login.serial.value= MyAuthLib.Data;   
            }catch(err){
              form1_login.serial.value= '1';      
              return;      
            }        
         }
         </script>
    <%}else{%>
        <script language="JavaScript">
            function checkusb(){
                try{
                    rnd = Math.round(Math.random()*1000000000);
                    form1_login.rnd.value=rnd;
                    var returnstr = getUserPIN();
                    if(returnstr != undefined){
                        form1_login.username.value= returnstr;
                        var randomKey = getRandomKey(rnd);
                        form1_login.serial.value= randomKey;
                    }else{
                        form1_login.serial.value= '0';
                    }
                }catch(err){
                    form1_login.serial.value= '0';
                    form1_login.username.value= '';
                    return;
                }
            }
        </script>
        <OBJECT id="htactx" name="htactx" 
classid=clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E codebase="HTActX.cab#version=1,0,0,1" style="HEIGHT: 0px; WIDTH: 0px"></OBJECT>
        <script language=VBScript>
            function getUserPIN()
                Dim vbsserial
                dim hCard
                hCard = 0
                on   error   resume   next
                hCard = htactx.OpenDevice(1)'���豸
                If Err.number<>0 or hCard = 0 then
                    'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����")
                    Exit function
                End if
                dim UserName
                on   error   resume   next
                UserName = htactx.GetUserName(hCard)'��ȡ�û���
                If Err.number<>0 Then
                    'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����2")
                    htactx.CloseDevice hCard
                    Exit function
                End if

                vbsserial = UserName
                htactx.CloseDevice hCard
                getUserPIN = vbsserial
            End function

            function getRandomKey(randnum)
                dim hCard
                hCard = 0   
                hCard = htactx.OpenDevice(1)'���豸
                If Err.number<>0 or hCard = 0 then
                    'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����4")
                    Exit function
                End if
                dim Digest
                Digest = 0
                on error resume next
                    Digest = htactx.HTSHA1(randnum, len(randnum))
                if err.number<>0 then
                        htactx.CloseDevice hCard
                        Exit function
                end if

                on error resume next
                    Digest = Digest&"04040404"'��SHA1���ݽ��в���
                if err.number<>0 then
                        htactx.CloseDevice hCard
                        Exit function
                end if

                htactx.VerifyUserPin hCard, CStr(form1_login.userpassword.value) 'У�����
                'alert HRESULT
                If Err.number<>0 Then
                    'alert("HashToken compute")
                    htactx.CloseDevice hCard
                    Exit function
                End if
                dim EnData
                EnData = 0
                EnData = htactx.HTCrypt(hCard, 0, 0, Digest, len(Digest))'DES3����SHA1�������
                If Err.number<>0 Then 
                    'alert("HashToken compute")
                    htactx.CloseDevice hCard
                    Exit function
                End if
                htactx.CloseDevice hCard
                getRandomKey = EnData
                'alert "EnData = "&EnData
            End function

        </script>
    <%}%>
 <%}%>
</script>



<script type="text/javascript">




function ieVersionDetection() {
    if(navigator.userAgent.indexOf("MSIE")>0){ //�Ƿ���IE����� 
        if(navigator.userAgent.indexOf("MSIE 6.0") > 0){ //6.0
            $("#ieverTips").show();
            return;
        } 
    }
    $("#ieverTips").hide();
}



//---------------------------------------------
// System font detection.  START
//---------------------------------------------
/**
 * detection system font exists.
 * @param fontName font name
 * @return true  :Exist.
 *         false :Does not Exist
 */
function isExistOTF(fontName) {
    if (fontName == undefined 
            || fontName == null 
            || fontName.trim() == '') {
        return false;
    }
    
    if (sysfonts.indexOf(";" + fontName + ";") != -1) {
        return true;
    }
    return false;
};

/**
 * getting to the system font string.
 * @param objectId object's id
 * @return system font string.
 */
function getSFOfStr(objectId) {
    var sysFontsArray = new Array();
    sysFontsArray = getSystemFonts(objectId);
    for(var i=0; i<sysFontsArray.length; i++) {
        sysfonts += sysFontsArray[i];
        sysfonts += ';'
    }
}
//-------------------------------------------
// Save the system font string, 
// used for multiple testing.
//-------------------------------------------
var sysfonts = ';';

/**
 * getting to the system font list
 *
 * @param objectId The id of components of the system font.
 * @return fonts list
 */
function getSystemFonts(objectId) {
    var a = document.all(objectId).fonts.count;
    var fArray = new Array();
    for (var i = 1; i <= document.all(objectId).fonts.count; i++) {
        fArray[i] = document.all(objectId).fonts(i)
    }
    return fArray
}

/**
 * Returns a string, with leading and trailing whitespace
 * omitted.
 * @return  A this string with leading and trailing white
 *          space removed, or this string if it has no leading or
 *          trailing white space.
 */
String.prototype.trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

//---------------------------------------------
// System font detection.  END
//---------------------------------------------

</script>


<STYLE TYPE="text/css">

.title{font-family: '΢���ź�', tahoma, sans-serif;FONT-SIZE: 11px;}
.grey{FONT-SIZE: 13px;color:#666666;font-family: '΢���ź�', tahoma, sans-serif;}
input{
    background: #FFFFFF;
    border: 1px solid #CCCCCC;
    color: #000000;
    font-family: verdana, tahoma, sans-serif;
    font-size: 0.95em;}
.username{
    background-image:url(/wui/theme/ecology7/skins/default/rightbox/userlog_username.gif);
 background-position: 1px 1px;
 background-repeat:no-repeat;
 padding-left:20px;
 height:20px;
 FONT-SIZE: 12px;}
.password{
    background-image:url(/wui/theme/ecology7/skins/default/rightbox/userlog_password.gif);
 background-position: 1px 1px;
 background-repeat:no-repeat;
 padding-left:20px;
 height:20px;
 FONT-SIZE: 12px;}

</STYLE>

</head>



<body >

<form name="form1_login" id="form1_login"  >
    <INPUT type="hidden" value="/wui/theme/ecology7/page/login.jsp?logintype=1" name="loginfile">
    <INPUT type="hidden" name="logintype" value="1">
    <input type="hidden" name="fontName" value="΢���ź�">
    <input type=hidden name="message" value="<%=message0 %>">
	<INPUT type=hidden name="rnd" >
	<INPUT type=hidden name="serial"> 
	<INPUT type=hidden name="username">
<table height="140px"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr >
    <td class="grey"><img src="/wui/theme/ecology7/skins/default/rightbox/userlog_warning.gif" width="16" height="16" align="absmiddle"> <span id="msg_show">�������¼���û���������<span></td>
  </tr>
  <tr >
    <td class="title">�û���:</td>
  </tr>
  <tr >
    <td><input name="loginid" type="text" class="username" size="30"></td>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr >
    <td class="title">��&nbsp;&nbsp;&nbsp;��:</td>
  </tr>
  <tr >
    <td><input name="userpassword"  id="tipLogPwd" type="password" class="password" size="30"
	onkeydown="if(event.keyCode == 13){checkall();}">
    <!--
	<span onclick="password1=form1_login.userpassword;form1_login.userpassword.value='';showkeyboard();Calc.password.value=''">
	 <img title="�����" style="border:none;cursor:hand" alt="" src="/wui/theme/ecology7/page/images/softkeyboard.gif" border="0"/>
	 </span>
	 -->
  </td>
  </tr>
 
  
  <tr >
    <td ><input type="button" name="button" id="get_focus" style="height:22px;width:50px;font-family: '΢���ź�', tahoma, sans-serif;FONT-SIZE: 12px;"  value="ȷ&nbsp;&nbsp;��" onclick="checkall()">
	 &nbsp;&nbsp;&nbsp;&nbsp; <input type="button" name="button" style="height:22px;width:50px;font-family: '΢���ź�', tahoma, sans-serif;FONT-SIZE: 12px;"  value="ȡ&nbsp;&nbsp;��" onclick="diag_qx_click()">
	</td>
  </tr>
</table>

</form>

</body>
</html>



