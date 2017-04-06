<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.homepage.HomepageBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.systeminfo.*,weaver.hrm.settings.RemindSettings,weaver.general.GCONST,weaver.general.StaticObj" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pu" class="weaver.page.PageUtil" scope="page" />
<%
RemindSettings settings=(RemindSettings)application.getAttribute("hrmsettings");
String message0 = Util.null2String(request.getParameter("message")) ;
String message=message0;
String loginid="";
String OpenPasswordLock = settings.getOpenPasswordLock();
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
	multilanguage = (String)staticobj.getObject("multilanguage") ;
}
if("y".equals(multilanguage)){
	ismuitlaguage = true;
}
%>

<%
if(message0.equals("46")){
	String usbType = settings.getUsbType();
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
<%
	//Get Parameter
	String hpid = Util.null2String(request.getParameter("hpid"));
	int isfromportal = Util.getIntValue(request.getParameter("isfromportal"), 0);
	int subCompanyId = Util.getIntValue(request.getParameter("subCompanyId"), -1);
	boolean isSetting = "true".equalsIgnoreCase(Util.null2String(request.getParameter("isSetting")));

	//�����ҳIDΪ0������ʾҳ��
	if ("0".equals(hpid)){
		out.println(SystemEnv.getHtmlLabelName(20276, 7));
		return;
	}	
	
	//�������ҳ������
	HomepageBean hpb = pu.getHpb(hpid);
	String layoutid = hpb.getLayoutid();
	String styleid = hpb.getStyleid();
%>
<html>
	<head>
		<!-- ����CSS -->
	<STYLE TYPE="text/css">
  	<%=pu.getHpCss(hpid,-1,0)%>
  	</STYLE>  
		<!-- ����JavaScript -->
		<%=pu.getPageJsImportStr(hpid)%>
		<%=pu.getPageCssImportStr(hpid)%>
		<script type="text/javascript">
			function initGauges(id,xml){
				try{
					setTimeout('bindows.loadGaugeIntoDiv("' + xml + '", "' +id+ '")', 1000);
				}catch(e){
					
				}
			}
			
		</script>
	</head>
	<body>
		<textarea id="txtDebug"	style="width: 100%; height: 200px; display: none"></textarea>
		<%=pu.getBaseLoginHpStr(hpid, layoutid, styleid, "hp", subCompanyId, isSetting)%>
	</body>
</html>


<SCRIPT LANGUAGE="JavaScript">
$(document).ready(function(){

});
/*�޸���ӦԪ��λ�� ������Ӧ��Ԫ����ȥ*/
function fixedPosition(eid){	
	//alert(1)
	//$('#item_'+eid).nextAll('.item').find('.header').trigger("focus"); 
	//window.setTimeout("$('#item_"+eid+"').nextAll('.item').find('.header').click();",500);
	//$('#item_'+eid).nextAll('.item').find('.header').css('position','static');	
	//window.setTimeout("$('#item_"+eid+"').nextAll('.item').find('.header').css('position','relative');",500);
	
	if(<%=isfromportal==1%>){ //���Ż�����������Ҫˢ��ҳ����				
		try{				
			var oFrm=parent.document.getElementById("mainFrame");					
			if(parseInt(oFrm.style.height)<parseInt(document.body.scrollHeight)) {
				oFrm.style.height=document.body.scrollHeight+"px";
			} else {
				oFrm.style.height=document.body.scrollHeight+"px";
			}
		} catch(e){
			log(e)
		}
	}
	
}
function stockGopage(type,url){
	 if(type==0)
	 	openFullWindowForXtable(url);
	 else
		 this.location = url;
	}
	
//����Ԫ����ʽ�༭ʱû������ͼ��ͼƬ����ֲ�ͼ����
$(".iconEsymbol").bind('error',function(){
	if($(this).attr("src")==''){
		$(this).hide();
	}
})


$(".toolbar").find("img").bind('error',function(){
	if($(this).attr("src")==''){
		$(this).hide();
	}
})


  $(".downarrowclass").bind('error',function(){
				if($(this).attr("src")==''){
					$(this).hide();
				}
  })		  

  
  $(".rightarrowclass").bind('error',function(){
		if($(this).attr("src")==''){
			$(this).hide();
		}
  })	

var message ="<%=message%>";
</SCRIPT>
<script type='text/javascript' src='/js/weaver-lang-cn-gbk.js'></script>
<%@ include file="/js/homepage/LoginHomepage_js.jsp"%>