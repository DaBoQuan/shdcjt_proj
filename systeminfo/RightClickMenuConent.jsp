<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>

<%	
int isSysadmin=0;
RecordSet rssysadminmenu=new RecordSet();
rssysadminmenu.executeSql("select count(*) from hrmresourcemanager where id="+user.getUID());
if(rssysadminmenu.next()){
 isSysadmin=rssysadminmenu.getInt(1);
}
int RCMenuWidth = 160 ;
int RCMenuHeightStep = 24 ;
int RCMenuHeight = 0 ;
String RCMenu="" ;
String systemAdminMenu = ""; 
int hiddenmenu=1;

String RCFromPage="";    //��Ҫ�����Ҽ���ҳ�����ƣ�����ʹ��RightClickMenu1.jsp��Ҫ�����Ҽ���ҳ��
int loadTopMenu = 1;    //�ر��Ҽ��˵����Ƿ����ͷ��������ť��1-���أ�0-�����أ��������ڶಿ��ѡ���
int defaultMenuCount = 0;

/**
	���ϵͳ���ã��鿴�Ƿ�ʹ���Ҽ��˵������ʹ���Ҽ��˵����Ƿ���ʾ���ƺ�����İ�ť
*/
BaseBean baseBeanRigthMenu = new BaseBean();
int userightmenu = 1;
int showCopyAndPaste=0;
try{
	userightmenu = Util.getIntValue(baseBeanRigthMenu.getPropValue("systemmenu", "userightmenu"), 1);
    showCopyAndPaste = Util.getIntValue(baseBeanRigthMenu.getPropValue("systemmenucopy", "showCopyAndPaste"), 0);
}catch(Exception e){
	
}
String isIEBrowser = (String)session.getAttribute("browser_isie"); //�Ƿ�ΪIE�����
if(userightmenu == 1){
    if(showCopyAndPaste==1&&"true".equals(isIEBrowser)){ //��IE�ݲ�֧��ճ������
	    RCMenu += "{"+SystemEnv.getHtmlLabelName(77,user.getLanguage())+",javascript:onRCMenu_copy(),_self} " ;
	    RCMenuHeight += RCMenuHeightStep ;
	    RCMenu += "{"+SystemEnv.getHtmlLabelName(16180,user.getLanguage())+",javascript:onRCMenu_plaster(),_self} " ;
	    RCMenuHeight += RCMenuHeightStep ;
	    defaultMenuCount=defaultMenuCount+2;
    }
}

if(isSysadmin>0) {  //��ϵͳ����Աsysadmin��½ϵͳ�ɲ鿴ҳ���ַ
	systemAdminMenu	 += "{"+SystemEnv.getHtmlLabelName(21682,user.getLanguage())+",javascript:viewSourceUrl(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	defaultMenuCount++;
}

%>
