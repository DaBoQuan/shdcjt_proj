<%@ page import="weaver.general.Util,weaver.general.TimeUtil
                 java.util.Map,
                 java.util.HashMap,weaver.general.StaticObj,
                 weaver.hrm.settings.RemindSettings,
                 weaver.general.GCONST" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.OnLineMonitor"%>
<%@ page import="java.net.*,java.io.*,java.io.File" %>
<%@ page import="weaver.systeminfo.template.UserTemplate"%>
<jsp:useBean id="rsExtend" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocCheckInOutUtil" class="weaver.docs.docs.DocCheckInOutUtil" scope="page"/>
	
<jsp:useBean id="dactylogramCompare" class="weaver.login.dactylogramCompare" scope="page" /> 
<jsp:useBean id="VerifyLogin" class="weaver.login.VerifyLogin" scope="page" /> 
<jsp:useBean id="VerifyPasswdCheck" class="weaver.login.VerifyPasswdCheck" scope="page" />
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%
String message = "";
//message˵����
//name_psw_n����ʾ�û��������벻��ȷ
//success ����ʾ�ɹ�
//19����ʾLicense����
//dactylogram_n����ʾָ�Ƶ�¼����
//45: ��ʾ��Ҫ����USBKEY
String loginfile = Util.null2String(request.getParameter("loginfile")) ;
String logintype = Util.null2String(request.getParameter("logintype")) ;
String loginid = Util.null2String(request.getParameter("loginid")) ;
String forwardpage = Util.null2String(request.getParameter("forwardpage")) ;
String userpassword = Util.null2String(request.getParameter("userpassword"));
//String message = Util.null2String(request.getParameter("message"));

//xiaofeng
int  islanguid = 7;//ϵͳʹ������,δʹ�ö����Ե��û�Ĭ��Ϊ���ġ�
String languid= "7";
boolean ismutilangua = false;
StaticObj staticobj = null;
staticobj = StaticObj.getInstance();
String multilanguage = (String)staticobj.getObject("multilanguage") ;
if(multilanguage == null) {
	VerifyLogin.checkLicenseInfo();
	multilanguage = (String)staticobj.getObject("multilanguage") ;
}
if(multilanguage.equals("y")){
	ismutilangua = true;
}
boolean isSyadmin=true;
//�жϷ�Ȩ����Ա
String Sysmanager = "select loginid from hrmresourcemanager where loginid = '"+loginid+"'";
RecordSet1.executeSql(Sysmanager);
if(RecordSet1.next()){
	isSyadmin = false;
}
if(loginid.equalsIgnoreCase("sysadmin")){
	isSyadmin = false;
}
if(isSyadmin){
	if(ismutilangua){
			islanguid = Util.getIntValue(request.getParameter("islanguid"),0);
				if(islanguid == 0){//���δѡ����Ĭ��ϵͳʹ������Ϊ��������
					islanguid = 7;
				}
		languid = String.valueOf(islanguid); 
		Cookie syslanid = new Cookie("Systemlanguid",languid);
		syslanid.setMaxAge(-1);
		syslanid.setPath("/");
		response.addCookie(syslanid);
	}
}/*else{
	Cookie syslanid = new Cookie("Systemlanguid",languid);
	syslanid.setMaxAge(-1);
	syslanid.setPath("/");
	response.addCookie(syslanid);
}*/
String serial=Util.null2String(request.getParameter("serial"));
String username = Util.null2String(request.getParameter("username"));
String rnd=Util.null2String(request.getParameter("rnd"));
String loginPDA=Util.null2String(request.getParameter("loginPDA"));
session.setAttribute("loginPAD",loginPDA);
//String RedirectFile ="/main.jsp";
String RedirectFile="/wui/page/main.jsp";


//add by sean.yang 2006-02-09 for TD3609
String validatecode=Util.null2String(request.getParameter("validatecode"));

//modify by mackjoe at 2005-11-28 td3282 �ʼ����ѵ�½��ֱ�ӵ�ָ������
String gopage=Util.null2String(request.getParameter("gopage"));
if(gopage.length()>0){
    RedirectFile = "/main.jsp?gopage="+gopage ;
}
if (loginfile.equals("")) loginfile="/login/Login.jsp?logintype="+logintype+"&gopage="+gopage;
//end by mackjoe
// modify by dongping for TD1340 in 2004.11.05
// �û���½ʱҪ��cookies�Ƿ񿪷����жϣ����û�У���������ʾ!
String testcookie = "";

String dactylogram = Util.null2String(request.getParameter("dactylogram"));//ָ������
boolean compareFlag = false;
if(!dactylogram.equals("")){
  compareFlag = dactylogramCompare.executeCompare(dactylogram);
	if(compareFlag){
		loginid = dactylogramCompare.getLoginId();
		userpassword = dactylogramCompare.getPassword();
		logintype = "1";
	}else{
		//response.sendRedirect("/login/Login.jsp?&message=nomatch") ;//2011/5/19
		message = "dactylogram_n";//2011/5/19
		
	}
}

if (logintype.equals("2")){
	if(!gopage.equals("")){
 		RedirectFile = "/portal/main.jsp?gopage="+gopage ;
	}else{
		RedirectFile = "/portal/main.jsp" ;
	}
}

String tourl = "";
if(loginid.equals("") || userpassword.equals("") ){ 
	//response.sendRedirect(loginfile + "&message=18") ;//2011/5/19
	message = "18";//2011/5/19
	
}else  { RemindSettings settings=(RemindSettings)application.getAttribute("hrmsettings");
    String needusb=settings.getNeedusb();
	String usercheck ;
	if(compareFlag){
		usercheck= VerifyLogin.getUserCheckByDactylogram(request,response,loginid,userpassword,logintype,loginfile,validatecode,message,languid,ismutilangua);
	}else{
		boolean canpass = VerifyPasswdCheck.getUserCheck(loginid,"",1);
		if(!canpass){
			if(needusb!=null&&needusb.equals("1")){
				usercheck= VerifyLogin.getUserCheck(request,response,loginid,userpassword,serial,username,rnd,logintype,loginfile,validatecode,message,languid,ismutilangua);
				//System.out.println(loginid+"=="+userpassword+"=="+serial+"=="+username+"=="+rnd+"=="+logintype+"=="+loginfile+"=="+validatecode+"=="+message+"=="+languid+"=="+ismutilangua);
			}else{
				usercheck= VerifyLogin.getUserCheck(request,response,loginid,userpassword,logintype,loginfile,validatecode,message,languid,ismutilangua);
			}
		}else{
			usercheck = "110";
		}
	}
	VerifyPasswdCheck.getUserCheck(loginid,usercheck,2);
	if(usercheck.equals("15")|| usercheck.equals("57") || usercheck.equals("17")|| usercheck.equals("45")|| usercheck.equals("46")|| usercheck.equals("47")|| usercheck.equals("52")|| usercheck.equals("55"))
    {
        String tmploginid=(String)session.getAttribute("tmploginid");
        if(tmploginid!=null&&loginid.equals(tmploginid))
           session.setAttribute("tmploginid1",loginid);
        else
           session.removeAttribute("tmploginid");
        //response.sendRedirect(loginfile + "&message="+usercheck) ;2011/5/19
		   message = usercheck ; //2011/5/19
		   
	}else if(usercheck.equals("16")){
		session.setAttribute("tmploginid1",loginid);
		//response.sendRedirect(loginfile + "&message="+usercheck) ;
		message = usercheck ; //2011/5/19
	}else if(usercheck.equals("19")){
		//response.sendRedirect("/system/InLicense.jsp") ;2011/5/19 inlicense ����
		message = usercheck ; //2011/5/19
		
	} else if (usercheck.equals("26")) {
		if (!loginPDA.equals("1")) {
			//response.sendRedirect("/login/Login.jsp?logintype=1&message="+usercheck);
			message = usercheck ; //2011/5/19
			
		} 
	}else if(usercheck.equals("101")){
        session.setAttribute("tmploginid",loginid);
        session.setAttribute("tmploginid1",loginid);
        if (!loginPDA.equals("1")) {
          //response.sendRedirect("/login/Login.jsp?logintype=1&message="+usercheck) ;
		  message = usercheck ; //2011/5/19
		  
		}
		else
		{
		  //response.sendRedirect("/login/LoginPDA.jsp?logintype=1&message="+usercheck) ;
		  message = usercheck ; //2011/5/19
		  
		}
    }
    else if(usercheck.equals("110"))
	{
		if (!loginPDA.equals("1"))
		{
			//response.sendRedirect("/login/Login.jsp?logintype=1&message=" + usercheck);
			message = usercheck ; //2011/5/19
		}
		else
		{
			//response.sendRedirect("/login/LoginPDA.jsp?logintype=1&message=" + usercheck);
			message = usercheck ; //2011/5/19
			
		}
	}
	else {
            User user = HrmUserVarify.getUser (request , response) ;
            if(user == null) { 
				//response.sendRedirect(loginfile ) ; 
				message = "name_psw_n" ; //2011/5/19//��ʾ�û��������벻��ȷ
			}

            session.setAttribute("password",userpassword);
            if("1".equals(logintype)){
            session.setAttribute("moniter", new OnLineMonitor("" + user.getUID(),user.getLoginip(),application));
            }
            Map logmessages=(Map)application.getAttribute("logmessages");
                if(logmessages==null){
                logmessages=new HashMap();
                logmessages.put(""+user.getUID(),"");
                application.setAttribute("logmessages",logmessages);
                }
	        session.setAttribute("logmessage",usercheck);
	        session.setAttribute("fromlogin","yes");
            session.removeAttribute("tmploginid");

            //DocCheckInOutUtil.docCheckInWhenVerifyLogin(user,request);

		//С���ڵ�¼ (TD 2227)
		//hubo,050707
		if(request.getSession(true).getAttribute("layoutStyle")!=null &&         request.getSession(true).getAttribute("layoutStyle").equals("1")){
			session.setAttribute("istimeout","no");
		}else{
			
			if("2".equals(logintype)){
				//response.sendRedirect(RedirectFile) ;
				message = "" ; //2011/5/19
				
			} else {
				message = "success";//��ʾ��¼�ɹ�!
			}
		}
	}
}
   out.print(Util.null2String(message));
%>