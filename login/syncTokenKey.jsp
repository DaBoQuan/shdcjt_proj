<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.login.TokenJSCX"%>
<%@page import="weaver.hrm.settings.RemindSettings"%>
<%@page import="weaver.hrm.settings.BirthdayReminder"%>
<%@page import="weaver.general.GCONST"%>
<%@page import="weaver.file.Prop"%>
<%
 String tokenKey=Util.null2String(request.getParameter("tokenKey"));
 String tokenKeyCode1=Util.null2String(request.getParameter("tokenKeyCode1"));
 String tokenKeyCode2=Util.null2String(request.getParameter("tokenKeyCode2"));
 
 String flag="";
 String message="";
 if(!tokenKey.equals("")&&!tokenKeyCode1.equals("")&&!tokenKeyCode2.equals("")){
	 TokenJSCX tokenJSCX=new TokenJSCX();
	 flag=tokenJSCX.syncTokenKey(tokenKey,tokenKeyCode1,tokenKeyCode2);
 }
 
 if(flag.equals("1"))
	 message="�������кŲ����ڻ�û�а�"; 
 else if(flag.equals("2"))
	 message="��̬����ͬ��ʧ�ܣ����ٴ�ͬ����ȷ�����������������ģ�<br>������ʧ�����ƿ�������ʧЧ�����ʧЧ����ϵϵͳ����Ա";
%>
<html>
  <head>
    <title>����ͬ��</title>
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
	       var tokenKey=jQuery("#tokenKey");
	       var tokenKeyCode1=jQuery("#tokenKeyCode1");
	       var tokenKeyCode2=jQuery("#tokenKeyCode2");
	       
           if(tokenKey.val()==""){
              alert("�������������кţ�");
              tokenKey.focus();
              return ;
           }else if(!isdigit(tokenKey.val())||tokenKey.val().length!=10){
              alert("�������кű���Ϊ10λ���֣�");
              tokenKey.focus();
              return ;
           }	
           
           var tokenType="";
           var startNumber=tokenKey.val().substr(0,1);
           if(startNumber=="1"){      //����1��
               tokenType="5";
           }else{
               alert("�������кŲ���ȷ����ȷ�Ϻ�����");
               tokenKey.focus();
               return ;
           }
           
           if(tokenKeyCode1.val()==""){
              alert("�����붯̬����1��");
              tokenKeyCode1.focus();
              return ;
           }else if(tokenKeyCode1.val().length!=6||!isdigit(tokenKeyCode1.val())){
               alert("��̬����1����Ϊ6λ����");   
               tokenKeyCode1.focus();
               return ;
           } 
           
           if(tokenKeyCode2.val()==""){
              alert("�����붯̬����2��");
              tokenKeyCode2.focus();
              return ;
           }else if(tokenKeyCode2.val().length!=6||!isdigit(tokenKeyCode2.val())){
              alert("��̬����2����Ϊ6λ����");   
              tokenKeyCode2.focus();
              return ;
           }
           
           if(tokenKeyCode1.val()==tokenKeyCode2.val()){
              alert("��̬����1�붯̬����2������ͬ");
              return ;
           }
           jQuery("#weaver").submit();
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
<form name="weaver" id="weaver" action="syncTokenKey.jsp" method="post">
<div style="width: 100%;position:absolute;" align="center" id="messageArea">
    <div style="width: 582px;height:309px;font-size:12px;background:url(/wui/common/page/images/error.png) no-repeat;text-align:left;position: relative;" align="center">
	    <div style="height:45px;clear: both;">
	         <div style="padding-left: 15px;padding-top:25px;font-size:16px;"><span style="font-weight: bold;">��̬����ͬ��</span>
	         <span style="font-size: 12px;color: red">(��ʾ���������ƿ��������������1������䶯�������2��)</span></div>
	    </div>
    <div>
    <div style="float:left; ">
    	<div style=" height:128px; width:123px;background: url(/wui/common/page/images/error_left.png); margin-top:20px;margin-left:40px!important; margin-left:20px"></div>
    </div>
	<div style=" height:120px; border-left:solid 1px #e3e3e3; margin:20px; float:left; margin-left:40px;margin-top:20px"></div>
		<div style="height:260px; width:320px; float:left;margin-top:10px; line-height:25px;">
		   <%if(flag.equals("")||flag.equals("1")||flag.equals("2")){%>
		   <table style="margin-top: 15px;width: 100%;font-size:12px;">
		       <tr>
		           <td width="75px">�������к�</td>
		           <td><input type="text" name="tokenKey" id="tokenKey" style="width: 150px;" maxlength="10">&nbsp;����10λ����</td>
		       </tr>
		       <tr>
		           <td>��̬����1</td>
		           <td><input type="text" name="tokenKeyCode1" id="tokenKeyCode1" style="width: 150px;" maxlength="6">&nbsp;����6λ����</td>
		       </tr>
		       <tr>
		           <td>��̬����2</td>
		           <td><input type="text" name="tokenKeyCode2" id="tokenKeyCode2" style="width: 150px;" maxlength="6">&nbsp;����6λ����</td>
		       </tr>
		       <tr>
			       <td colspan="2">
			          <span style="color: red;"><%=message%></span>
			       </td>
			   </tr>
		       <tr>
			       <td colspan="2" align="center" style="padding-top: 5px;">
			         <input type="button" value="ͬ��" onclick="dosave(this)">&nbsp;
			         <input type="reset" value="����">
			      </td>
			   </tr>
		   </table>
		   <%}else{%>
		       <div style="margin-top: 45px;font-size: 15px;">
		         <span style="color: red;">����ͬ���ɹ���</span><br>
		          �������ƿ���仯��&nbsp;<a href="/login/Login.jsp" style="font-weight: bold;font-size: 14px;">��¼</a>ϵͳ������ʹ�ñ�����֤����
		      </div>
		   <%}%>
	    </div>
	    </div>
    </div>
    
</div>
</form>
</body>
</html>    
  
