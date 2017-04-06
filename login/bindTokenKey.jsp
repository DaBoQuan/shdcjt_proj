<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.login.TokenJSCX"%>
<%@page import="weaver.hrm.settings.RemindSettings"%>
<%@page import="weaver.hrm.settings.BirthdayReminder"%>
<%@page import="weaver.general.GCONST"%>
<%@page import="weaver.file.Prop"%>
<%
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
 
 String needusb=settings.getNeedusb();    //�Ƿ�����usb��֤
 String usbType = settings.getUsbType();  //����usb��֤����
 
 String userid=Util.null2String(request.getParameter("userid"));   //�������û�id
 String loginid=Util.null2String(request.getParameter("loginid")); 
 String userpassword=Util.null2String(request.getParameter("userpassword"));
 String tokenKey1=Util.null2String(request.getParameter("tokenKey1"));
 String tokenKey2=Util.null2String(request.getParameter("tokenKey2"));
 String tokenKeyCode=Util.null2String(request.getParameter("tokenKeyCode"));
 String isBind=Util.null2String(request.getParameter("isBind"));
 String requestFrom=Util.null2String(request.getParameter("requestFrom"));//����������ҳ�棬systemΪ����ϵͳ���ð�����
 int logintype=Util.getIntValue(request.getParameter("logintype"),0);     //�˺���֤����  
 if(logintype==0){
	 String mode = Prop.getPropValue(GCONST.getConfigFile(), "authentic");
	 if(mode != null && mode.equals("ldap"))
		 logintype=2;
	 else
		 logintype=3;
 }
 
 String message="";
 String flag="0";

 if(!needusb.equals("1")){
	 response.sendRedirect("/login/Login.jsp");
}
 
 TokenJSCX token=new TokenJSCX();
 
 if(tokenKey1.startsWith("1"))       //����1��
	 flag=token.bindDLTokenKeyBySN(loginid,userpassword,tokenKey1,tokenKeyCode,isBind,logintype,requestFrom,userid);
 else if(tokenKey1.startsWith("2"))  //����2��
	 flag=token.bindDLTokenKey(loginid,userpassword,tokenKey1,tokenKeyCode,isBind,logintype);
 else if(tokenKey1.startsWith("3"))  //��ʯ1��
	 flag=token.bindTokenKey(loginid,userpassword,tokenKey1,tokenKeyCode,isBind,logintype);
 

 if(flag.equals("-1"))
	 message="�û��������������";
 else if(flag.equals("2"))
	 message="�������кŻ��߿������";

 
%>
<html>
  <head>
    <title>���ư�</title>
    <script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
    <link type='text/css' rel='stylesheet'  href='/css/weaver.css'/>
    <link type='text/css' rel='stylesheet'  href='/wui/theme/ecology7/skins/default/wui.css'/>
    <script type="text/javascript">
	    $(document).ready(function () {
	    	var pTop= document.body.offsetHeight/2 + document.body.scrollTop - 154;
	        var pLeft= document.body.offsetWidth/2 - 50;
	        $("#messageArea").css("top", pTop);
	    });
	    function dosave(obj){
	       var usbType="<%=usbType%>";
	       var loginid=jQuery("#loginid");
	       var userpassword=jQuery("#userpassword");
	       var tokenKey1=jQuery("#tokenKey1");
	       var tokenKey2=jQuery("#tokenKey2");
	       var tokenKeyCode=jQuery("#tokenKeyCode");
	       
	       <%if(requestFrom.equals("system")){%>
           if(loginid.val()==""){
              alert("�������û�����");
              loginid.focus();
              return ;
           }
           if(userpassword.val()==""){
              alert("���������룡");
              userpassword.focus();
              return ;
           } 
           <%}%>
           if(tokenKey1.val()==""){
              alert("�������������кţ�");
              tokenKey1.focus();
              return ;
           }else if(!isdigit(tokenKey1.val())||tokenKey1.val().length!=10){
              alert("�������кű���Ϊ10λ���֣�");
              tokenKey1.focus();
              return ;
           }	
           
           if(tokenKey1.val()!=tokenKey2.val()){
              alert("���������������кŲ�һ�£�");
              tokenKey2.focus();
              return ;
           }
           
           var tokenType="";
           var startNumber=tokenKey1.val().substr(0,1);
           if(startNumber=="1")      //����1��
               tokenType="5";
           //else if(startNumber=="2") //����2��
           //    tokenType="4";    
           //else if(startNumber=="3") //��ʯ1��
           //    tokenType="3"; 
           else{
               alert("�������кŲ���ȷ����ȷ�Ϻ�����");
               tokenKey1.focus();
               return ;
           }
           
           if(tokenType=="3"||tokenType=="5"){
              var flag=true;
              if(tokenKeyCode.val()==""){
	              alert("�����붯̬���ƿ��");
	              flag=false;
              }else if(!isdigit(tokenKeyCode.val())){
                  alert("�������Ϊ����");
                  flag=false;
              }else if(tokenKeyCode.val().length!=6){
                  alert("�������Ϊ6λ����");   
                  flag=false; 
              } 
              if(!flag)   
                 return false;
           }
           
           jQuery.post("/login/LoginOperation.jsp?method=checkIsBind&requestFrom=<%=requestFrom%>&userid=<%=userid%>&loginid="+loginid.val()+"&tokenKey="+tokenKey1.val(),{},function(data){
                var isBind=jQuery.trim(data);
                jQuery("#isBind").val(isBind);
                if(isBind=="1"){
                   alert("����������������к��Ѿ��󶨸������û�������ϵ����Ա!");
                   return ;
                }else if(isBind=="0"){
                   alert("����������������к�������ǰ�����ƴ���һ��!");
                   return ;
                }else if(isBind=="6"){
                   alert("������Ҫ�����ƣ�����ϵ����Ա!");
                   return ;
                }
                <%if(!requestFrom.equals("system")){%>
	                if(isBind=="4"||isBind=="5"){
	                   alert("���Ѿ��󶨹����ƣ������Ҫ������������ϵϵͳ����Ա��");
	                   return ;
	                }
                <%}%> 
                jQuery("#weaver").submit();
           });
	    }
	    
	    function isdigit(s){
			var r,re;
			re = /\d*/i; //\d��ʾ����,*��ʾƥ��������
			r = s.match(re);
			return (r==s)?true:false;
		}
    </script>
    <style>
      body{font-size:12px;}
    </style>
  </head>
<body style="margin:0px;padding:0px;background-color: rgb(241, 241, 241);">
<form name="weaver" id="weaver" action="bindTokenKey.jsp" method="post">
<input type="hidden" value="<%=requestFrom%>" id="requestFrom" name="requestFrom">
<input type="hidden" value="<%=userid%>" id="userid" name="userid">
<input type="hidden" value="<%=logintype%>" id="logintype" name="logintype">
<input type="hidden" value="0" id="isBind" name="isBind">
<div style="width: 100%;position:absolute;" align="center" id="messageArea">
    <div style="width: 582px;font-size:12px;height:309px;background:url(/wui/common/page/images/error.png) no-repeat;text-align:left;position: relative;" align="center">
	    <div style="height:45px;clear: both;font-size:16px;">
	         <div style="padding-left: 15px;padding-top:25px"><span style="font-weight: bold;">��̬�������ư�</span><span style="font-size: 12px;color: red">(��ʾ����֤�ɹ�����ֻ��ʹ��һ��)</span></div>
	    </div>
    <div>
    <div style="float:left; ">
    	<div style=" height:128px; width:123px;background: url(/wui/common/page/images/error_left.png); margin-top:20px;margin-left:40px!important; margin-left:20px"></div>
    </div>
	<div style=" height:120px; border-left:solid 1px #e3e3e3; margin:20px; float:left; margin-left:40px;margin-top:20px"></div>
		<div style="height:260px; width:320px; float:left;margin-top:10px; line-height:25px;">
		<%if(flag.equals("0")||flag.equals("-1")||flag.equals("2")){%>
			<table style="margin-top: 10px;font-size:12px;">
			   <%if(!requestFrom.equals("system")){%>
			   <tr>
			       <td>��¼��</td>
			       <td><input type="text" name="loginid" id="loginid" style="width: 150px;" value="<%=loginid%>"></td>
			   </tr>
			   <tr>
			       <td>����</td>
			       <td><input type="password" name="userpassword" id="userpassword" style="width: 150px;"></td>
			   </tr>
			   <%} %>
			   <tr>
			       <td>�������к�</td>
			       <td><input type="text" name="tokenKey1" id="tokenKey1" style="width: 150px;" maxlength="10">&nbsp;����10λ����</td>
			   </tr>
			   <tr>
			       <td>ȷ�����к�</td>
			       <td><input type="text" name="tokenKey2" id="tokenKey2" style="width: 150px;" maxlength="10">&nbsp;����10λ����</td>
			   </tr>
			   <tr id="tokenKeyCodeTr" style="display:<%=usbType.equals("4")?"none":""%>">
			       <td>��̬���ƿ���</td>
			       <td><input type="text" name="tokenKeyCode" id="tokenKeyCode" style="width: 150px;" maxlength="6">&nbsp;����6λ����</td>
			   </tr>
			   <tr>
			       <td colspan="2">
			          <span style="color: red;"><%=message%></span>
			       </td>
			   </tr>
			   <tr>
			       <td colspan="2" align="center" style="padding-top: 5px;">
			         <input type="button" value="��" onclick="dosave(this)">&nbsp;
			         <input type="reset" value="����">
			      </td>
			   </tr>
			   
			</table>
		 <%}else if(flag.equals("1")){ %>	
		    <div style="margin-top: 45px;font-size: 15px;">
		      <span style="color: red;">���ư󶨳ɹ���</span><br>
		       <%if(requestFrom.equals("system")) {%>
		           <script type="text/javascript">
		               window.returnValue={tokenKey:"<%=tokenKey1%>"}
		           </script>
		       <%}else{ %>
		           �������ƿ���仯��&nbsp;<a href="/login/Login.jsp" style="font-weight: bold;font-size: 14px;">��¼</a>ϵͳ������ʹ�ñ�����֤����
		       <%} %>
		    </div> 
		 <%}else if(usbType.equals("4")&&!flag.equals("1")){ %>
		     <div style="margin-top: 45px;font-size: 15px;">
		      <span style="color: red;">���ư󶨳ɹ���</span><br>
		       �����뼤����<span style="color: red;font-weight: bold;font-size: 16px;"><%=flag%></span>���������е�����
		       <%if(requestFrom.equals("system")) {%>
		          <script type="text/javascript">
		              window.returnValue={tokenKey:"<%=tokenKey1%>"}
		          </script>
		       <%}else{ %>
		          ����ɹ�������&nbsp;<a href="/login/login.jsp" style="font-weight: bold;font-size: 14px;">��½</a>
		       <%} %>
		    </div> 
		 <%} %>
	    </div>
	    </div>
    </div>
    
</div>
</form>
</body>
</html>    
  
