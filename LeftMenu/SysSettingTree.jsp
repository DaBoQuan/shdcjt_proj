<?xml version="1.0" encoding="gbk"?><%@ page language="java" contentType="text/xml; charset=GBK" %><%@ page import="java.util.ArrayList,java.lang.reflect.Method" %><%@page import="com.weaver.integration.util.IntegratedSapUtil"%><%@ page import="weaver.hrm.*,weaver.general.*,weaver.systeminfo.*,weaver.systeminfo.menuconfig.*" %><jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/><jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page"/><%User user = HrmUserVarify.getUser(request,response);%><tree><%

if(user == null)  return ;
String s = "", sql="", parentid="", visibility="";
parentid=Util.null2String(request.getParameter("parentid"));

//System.out.println("parentid:"+parentid);
MenuUtil mu=new MenuUtil("top", 3,user.getUID(),user.getLanguage()) ;
//===============================================
//TD4425 �����ظ�ִ�нű���ɲ˵��ظ�
//added by hubo,2006-07-03
ArrayList menuIds = new ArrayList();
//===============================================

//
//if(parentid.equals("")){
	//sql = "SELECT a.* FROM MainMenuInfo a,SystemModule c WHERE c.moduleReleased='1' AND c.id=a.relatedModuleId  AND  defaultParentId IS NULL ORDER BY defaultIndex";
//}else{
	//sql = "SELECT a.* FROM MainMenuInfo a,SystemModule c WHERE c.moduleReleased='1' AND c.id=a.relatedModuleId  AND   defaultParentId="+Integer.parseInt(request.getParameter("parentid"))+" ORDER BY defaultIndex";
//}
//rs.executeSql(sql);
rs=mu.getMenuRs(Util.getIntValue(parentid,0));
while(rs.next()){
	boolean hasSubMenu = false;
	int infoid=rs.getInt("infoid");
	
	if(infoid==1 || infoid==10  || infoid==26 ||  infoid==27 ||  infoid==19) continue;
 
	//TD4425=========================================
	if(menuIds.contains(String.valueOf(infoid))) continue;
	menuIds.add(String.valueOf(infoid));
	//===============================================
	
	int labelId = rs.getInt("labelId");
	
	//�ҵı���ϵͳ���á��������� ģ������
	if("".equals(parentid)||"10".equals(parentid)||"11".equals(parentid)){
	   String module = Util.null2String(rs.getString("module"));
	   if(!"".equals(module)){
			MouldStatusCominfo msc=new MouldStatusCominfo();
			String status=Util.null2String(msc.getStatus(module));
			if("0".equals(status)) 		continue;
		}
	}
	//1163text=SAP������Ȩ����
	//1164text=����SAP�����ť
	//1189text=����SAP����
	String IsOpetype=IntegratedSapUtil.getIsOpenEcology70Sap();
	if("1".equals(IsOpetype)){
	   	if(infoid==1163||infoid==1164||infoid==1189){
	   		continue;
	   	}
	}
	//1227=���ɹ���
	 if("0".equals(IsOpetype)&&infoid==1227){
			continue;
	 }
	
	boolean useCustomName = rs.getInt("useCustomName") == 1 ? true: false;
	String customName = rs.getString("customName");
	String customName_e = rs.getString("customName_e");
	String customName_t = rs.getString("customName_t");
	
	boolean infoUseCustomName = rs.getInt("infoUseCustomName") == 1 ? true	: false;
	String infoCustomName = rs.getString("infoCustomName");
	String infoCustomName_e = rs.getString("infoCustomName_e");
	String infoCustomName_t = rs.getString("infoCustomName_t");
	String baseTarget = rs.getString("baseTarget");
	if("".equals(baseTarget)) baseTarget="mainFrame";
	
	String text = mu.getMenuText(labelId, useCustomName, customName, customName_e, customName_t, infoUseCustomName, infoCustomName, infoCustomName_e,infoCustomName_t,user.getLanguage());			 
	
	sql = "SELECT id FROM MainMenuInfo WHERE parentid="+infoid;
	rs2.executeSql(sql);
	if(rs2.next()) hasSubMenu=true;
	
	boolean _needRightToVisible = rs.getString("needRightToVisible").equals("1") ? true : false;
	boolean _needSwitchToVisible = rs.getString("needSwitchToVisible").equals("1") ? true : false;
	String _rightDetailToVisible = rs.getString("rightDetailToVisible");
	String _switchMethodNameToVisible = rs.getString("switchMethodNameToVisible");
	int _relatedModuleId = rs.getInt("relatedModuleId");
	String linkAddress=Util.replace(rs.getString("linkAddress"), "&", "&#38;", 0);

	visibility = isDisplay(_needRightToVisible,_needSwitchToVisible,_rightDetailToVisible,_switchMethodNameToVisible,_relatedModuleId,user);
	
	if("hidden".equals(visibility)){
		continue;
	}else if("noright".equals(visibility)){
		if(hasSubMenu){
			s += "<tree text='"+text+"' target='"+baseTarget+"' icon='"+rs.getString("iconUrl")+"' src='SysSettingTree.jsp?parentid="+infoid+"' action='javascript:void(0);'>";
		}else{
			s += "<tree text='"+text+"'  target='"+baseTarget+"' icon='"+rs.getString("iconUrl")+"' action='noright'>";
		}
	}else{
		if(hasSubMenu){
			s += "<tree text='"+text+"'  target='"+baseTarget+"' icon='"+rs.getString("iconUrl")+"' src='SysSettingTree.jsp?parentid="+infoid+"' action='"+linkAddress+"'>";
		}else{
			s += "<tree text='"+text+"'  target='"+baseTarget+"' icon='"+rs.getString("iconUrl")+"' action='"+linkAddress+"'>";
		}
	}
	s += "</tree>";
}

out.print(s+"</tree>");
%>

<%!
//visibility: visible,noright,hidden
String visibility = "";

String isDisplay(boolean needRightToVisible,boolean needSwitchToVisible,String rightDetailToVisible,String switchMethodNameToVisible,int relatedModuleId,User user){
	visibility = "visible";
	//ͨ�����ؿ��ƿɼ�
	if(needSwitchToVisible){
		 try {
			  Class cls = Class.forName("weaver.systeminfo.menuconfig.MenuSwitch");
			  //some error here, modify by xiaofeng
			  Method meth = cls.getMethod(switchMethodNameToVisible,new Class[]{User.class });

			  MenuSwitch methobj = new MenuSwitch();
			  Object retobj = meth.invoke(methobj,new Object[]{user});
			  Boolean retval = (Boolean) retobj;
			  boolean switchToVisible = retval.booleanValue();
			  //visible = visible&&switchToVisible;
			  if(!switchToVisible)
				visibility = "hidden";
		 } catch (Throwable e) {
			  System.err.println(e);
		 }
	}
	//ͨ��Ȩ�޿��Ʋ˵��ɼ�
	if(needRightToVisible){
		 ArrayList rightDetails = Util.TokenizerString(rightDetailToVisible,"&&");
		 for(int a=0;a<rightDetails.size();a++){
			  String rightDetail = (String)rightDetails.get(a);
			  //visible = visible&&HrmUserVarify.checkUserRight(rightDetail,user);
			  if(!HrmUserVarify.checkUserRight(rightDetail,user)){
				  break;
			  }
		 }
		 visibility = "noright";
	}
	return visibility;
}
%>

