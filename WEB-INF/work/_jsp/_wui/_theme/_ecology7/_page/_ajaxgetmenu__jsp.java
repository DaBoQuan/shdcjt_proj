/*
 * JSP generated by Resin-3.1.8 (built Mon, 17 Nov 2008 12:15:21 PST)
 */

package _jsp._wui._theme._ecology7._page;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import weaver.general.Util;
import java.sql.Timestamp;
import java.util.*;
import weaver.systeminfo.menuconfig.LeftMenuConfigHandler;
import weaver.systeminfo.menuconfig.LeftMenuInfo;
import weaver.systeminfo.menuconfig.LeftMenuConfig;
import weaver.systeminfo.menuconfig.MenuMaint;
import weaver.hrm.HrmUserVarify;
import weaver.hrm.User;
import weaver.conn.RecordSet;
import java.util.ArrayList;
import java.lang.reflect.Method;
import weaver.hrm.*;
import weaver.general.*;
import weaver.systeminfo.menuconfig.*;
import weaver.systeminfo.*;

public class _ajaxgetmenu__jsp extends com.caucho.jsp.JavaPage
{
  private static final java.util.HashMap<String,java.lang.reflect.Method> _jsp_functionMap = new java.util.HashMap<String,java.lang.reflect.Method>();
  private boolean _caucho_isDead;

  
  private String getSettingMenu(User user, String parentid) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
    //---------------------------
      // \u83dc\u5355\u9879\u80cc\u666f\u56fe\u7247\u968f\u673a\u663e\u793a
      // bgcnt   : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u4e2a\u6570
      // bgindex : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u968f\u673a\u7528\u4e0b\u6807
      // abgs    : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u6570\u7ec4
      //---------------------------
      int bgcnt = 4;
      int bgindex = 4;
    
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      String sql="";
      String visibility="";
      //parentid=Util.null2String(request.getParameter("parentid"));
      
      MenuUtil mu=new MenuUtil("top", 3,user.getUID(),user.getLanguage()) ;
      //===============================================
      //TD4425 \u907f\u514d\u91cd\u590d\u6267\u884c\u811a\u672c\u9020\u6210\u83dc\u5355\u91cd\u590d
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
      RecordSet rs=mu.getMenuRs(Util.getIntValue(parentid,0));
      while(rs.next()){
          boolean hasSubMenu = false;
          int infoid=rs.getInt("infoid");
          
          if(infoid==1 || infoid==10  || infoid==26 ||  infoid==27 ||  infoid==19) continue;
       
          //TD4425=========================================
          if(menuIds.contains(String.valueOf(infoid))) continue;
          menuIds.add(String.valueOf(infoid));
          //===============================================
          
          int labelId = rs.getInt("labelId");
          
          //\u6211\u7684\u62a5\u8868\u3001\u7cfb\u7edf\u8bbe\u7f6e\u3001\u8bbe\u7f6e\u4e2d\u5fc3 \u6a21\u5757\u5c4f\u853d
          if("".equals(parentid)||"10".equals(parentid)||"11".equals(parentid)){
             String module = Util.null2String(rs.getString("module"));
             if(!"".equals(module)){
                  MouldStatusCominfo msc=new MouldStatusCominfo();
                  String status=Util.null2String(msc.getStatus(module));
                  if("0".equals(status))      continue;
              }
          }
          
          boolean useCustomName = rs.getInt("useCustomName") == 1 ? true: false;
          String customName = rs.getString("customName");
          String customName_e = rs.getString("customName_e");
          String customName_t = rs.getString("customName_t");
          
          boolean infoUseCustomName = rs.getInt("infoUseCustomName") == 1 ? true  : false;
          String infoCustomName = rs.getString("infoCustomName");
          String infoCustomName_e = rs.getString("infoCustomName_e");
          String infoCustomName_t = rs.getString("infoCustomName_t");
          String baseTarget = rs.getString("baseTarget");
          if("".equals(baseTarget)) baseTarget="mainFrame";
          
          String text = mu.getMenuText(labelId, useCustomName, customName, customName_e, customName_t, infoUseCustomName, infoCustomName, infoCustomName_e,infoCustomName_t,user.getLanguage());           
          RecordSet rs2 = new RecordSet();
          sql = "SELECT id FROM MainMenuInfo WHERE parentid="+infoid;
          rs2.executeSql(sql);
          if(rs2.next()) hasSubMenu=true;
          
          boolean _needRightToVisible = rs.getString("needRightToVisible").equals("1") ? true : false;
          boolean _needSwitchToVisible = rs.getString("needSwitchToVisible").equals("1") ? true : false;
          String _rightDetailToVisible = rs.getString("rightDetailToVisible");
          String _switchMethodNameToVisible = rs.getString("switchMethodNameToVisible");
          int _relatedModuleId = rs.getInt("relatedModuleId");
          String linkAddress = "";
          try {
              linkAddress = Util.replace(rs.getString("linkAddress"), "&", "&#38;", 0);
          } catch (Exception e) {
              
          }
          
      
          visibility = isDisplay(_needRightToVisible,_needSwitchToVisible,_rightDetailToVisible,_switchMethodNameToVisible,_relatedModuleId,user);
          
          if("hidden".equals(visibility)){
              continue;
          }else if("noright".equals(visibility)){
              bgindex++;
              if(hasSubMenu){
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                   sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append("javascript:void(0);");
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  sfcm.append(" action='javascript:void(0);'");
                  sfcm.append(" target=\"" + baseTarget + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				sfcm.append(text);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
                 sfcm.append("<div style='width:4px;'></div></a>");
                  String tempStr = getSettingMenu(user, String.valueOf(infoid));
                  sfcm.append("<ul></ul>".equals(tempStr) ? "" : tempStr);
                  sfcm.append("</li>");
                  s += sfcm.toString();
              }else{
                  StringBuffer sfcm = new StringBuffer();
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  //sfcm.append(" action='noright'");
                  sfcm.append(" target=\"" + baseTarget + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				    sfcm.append(text);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
              
                  sfcm.append("<div style='width:4px;'></div></a>");
                  sfcm.append("</li>");
                  s += sfcm.toString();
              }
          }else{
              bgindex++;
              if(hasSubMenu){
                  StringBuffer sfcm = new StringBuffer();
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append((linkAddress == null || "".equals(linkAddress)) ? "javascript:void(0);" : linkAddress);
                  //sfcm.append("javascript:void(0);");
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  //sfcm.append(" action='"+linkAddress+"'");
                  sfcm.append(" target=\"" + baseTarget + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				 sfcm.append(text);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
              
                  sfcm.append("<div style='width:4px;'></div></a>");
                  String tempStr = getSettingMenu(user, String.valueOf(infoid));
                  sfcm.append("<ul></ul>".equals(tempStr) ? "" : tempStr);
                  sfcm.append("</li>");
                  s += sfcm.toString();
              }else{
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append(linkAddress);
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  //sfcm.append(" action='"+linkAddress+"'");
                  sfcm.append(" target=\"" + baseTarget + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				 sfcm.append(text);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
                  
                  sfcm.append("<div style='width:4px;'></div></a>");
                  sfcm.append("</li>");
                  s += sfcm.toString();
              }
          }
      }
      s += "</ul>";
      return s;
  }


  
  //visibility: visible,noright,hidden
  String visibility = "";
  
  private String isDisplay(boolean needRightToVisible,boolean needSwitchToVisible,String rightDetailToVisible,String switchMethodNameToVisible,int relatedModuleId,User user){
      visibility = "visible";
      //\u901a\u8fc7\u5f00\u5173\u63a7\u5236\u53ef\u89c1
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
      //\u901a\u8fc7\u6743\u9650\u63a7\u5236\u83dc\u5355\u53ef\u89c1
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


  
  private String getInfoCenterMenu(User user) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
    //---------------------------
      // \u83dc\u5355\u9879\u80cc\u666f\u56fe\u7247\u968f\u673a\u663e\u793a
      // bgcnt   : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u4e2a\u6570
      // bgindex : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u968f\u673a\u7528\u4e0b\u6807
      // abgs    : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u6570\u7ec4
      //---------------------------
      int bgcnt = 4;
      int bgindex = 4;
    
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      LeftMenuConfigHandler leftMenuConfigHandler = new LeftMenuConfigHandler();
      HashMap leftMenuConfigMapping = leftMenuConfigHandler.getLeftMenuConfig(user.getUID());
      ArrayList visibleSubLevelLeftMenus = (ArrayList)leftMenuConfigMapping.get(new Integer(111));
  
      if(visibleSubLevelLeftMenus!=null){
          for(int j=0; j<visibleSubLevelLeftMenus.size(); j++){
              LeftMenuConfig subConfig = (LeftMenuConfig)visibleSubLevelLeftMenus.get(j);
              LeftMenuInfo subInfo = subConfig.getLeftMenuInfo();
              int subLevelId = subInfo.getId();
              int subLabelId = subInfo.getLabelId();
              String subName = subInfo.getName(user.getLanguage());
              String iconUrl = subInfo.getIconUrl();
              String linkAddress = subInfo.getLinkAddress();
              if(linkAddress.indexOf("<")!=-1){
                  linkAddress = Util.replaceRange(linkAddress,"<",">",String.valueOf(user.getUID()),false);
              }
              bgindex++;
              if(subLevelId==118){    //\u65b0\u95fb\u516c\u544a
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append(linkAddress);
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  //sfcm.append(" action='javascript:void(0);'");
                  sfcm.append(" target=\"" + "mainFrame" + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				 sfcm.append(subName);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
                  sfcm.append("<div style='width:4px;'></div></a>");
                  String result = getTypesMenu(user);
                  sfcm.append("<ul></ul>".equals(result) ? "" : result);
                  sfcm.append("</li>");
                  s += sfcm.toString();
                  
                  //s += "<tree text=\""+subName+"\" action=\""+linkAddress+"\" icon=\""+iconUrl+"\" src=\"/LeftMenu/InfoCenterTreeTypes.jsp\" />";
              }else if(subLevelId==119){  //\u7f51\u4e0a\u8c03\u67e5
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append(linkAddress);
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  //sfcm.append(" action='javascript:void(0);'");
                  sfcm.append(" target=\"" + "mainFrame" + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				sfcm.append(subName);
  				sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
              
                  sfcm.append("<div style='width:4px;'></div></a>");
                  String result = getVotingMenu(user);
                  sfcm.append("<ul></ul>".equals(result) ? "" : result);
                  sfcm.append("</li>");
                  s += sfcm.toString();
                  //s += "<tree text=\""+subName+"\" action=\""+linkAddress+"\" icon=\""+iconUrl+"\" src=\"/LeftMenu/InfoCenterTreeVoting.jsp\" />";
              }else if(subLevelId==115){ //\u63d0\u9192\u4fe1\u606f(for xwj)
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append(linkAddress);
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  sfcm.append(" target=\"" + "mainFrame" + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				sfcm.append(subName);
                  sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
              
                  sfcm.append("<div style='width:4px;'></div></a>");
                  String result = getRemindMenu(user);
                  sfcm.append("<ul></ul>".equals(result) ? "" : result);
                  sfcm.append("</li>");
                  s += sfcm.toString();
                  //s += "<tree text=\""+subName+"\" action=\""+linkAddress+"\" icon=\""+iconUrl+"\" src=\"/LeftMenu/InfoCenterTreeRemind.jsp\" />";
              }else{
                  s += "<tree text=\""+subName+"\" action=\""+linkAddress+"\" icon=\""+iconUrl+"\" />";
                  StringBuffer sfcm = new StringBuffer();
                  
                  sfcm.append("<li>");
                  sfcm.append("<a class='lfMenuItem' href='");
                  sfcm.append(linkAddress);
                  //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
                  sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
                  sfcm.append(" target=\"" + "mainFrame" + "\" >");
                  sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
                  sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  				sfcm.append(subName);
  				sfcm.append("</div>");
                  sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
                  sfcm.append("<div style='width:4px;'></div></a>");
                  sfcm.append("</li>");
                  s += sfcm.toString();
              }
          }
      }
      
      s += "</ul>";
      return s;
  }


  
  private String getRemindMenu(User user) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
  
      int bgcnt = 4;
      int bgindex = 4;
  
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      RecordSet rs = new RecordSet();
      
      String sql="";
      int userid=user.getUID();
      int usertype= Util.getIntValue(user.getLogintype(),1)-1;   
      //Remind
      //sql = "select a.type, sum(a.counts) as count, (select statistic from SysPoppupinfo where type=a.type) as statistic, (select typedescription from SysPoppupinfo where type=a.type) as typedescription, (select link from SysPoppupinfo where type=a.type) as link from SysPoppupRemindInfoNew a where  a.userid="+userid+" group by a.type";
      if(rs.getDBType().equals("oracle")){
          sql = "select a.type, sum(a.counts) as count, (select statistic from SysPoppupinfo where type=a.type) as statistic, (select typedescription from SysPoppupinfo where type=a.type) as typedescription, (select link from SysPoppupinfo where type=a.type) as link from SysPoppupRemindInfoNew a where  a.userid="+userid+" and a.usertype='"+usertype+"'  and ( (a.type=0 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and isremark in ('0','1','8','9','7') ) )   or (a.type=1 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and exists (select 1 from workflow_requestbase where workflow_requestbase.requestid=workflow_currentoperator.requestid and currentnodetype=3) ) ) or (a.type=14 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and exists (select 1 from workflow_requestbase where workflow_requestbase.requestid=workflow_currentoperator.requestid) ) ) or (type=10 and requestid in (select requestid from workflow_currentoperator where ((isremark='0' and (isprocessed='2' or isprocessed='3' or isprocessed is null))  or isremark='5') and islasttimes=1)) or (a.type=9 and a.requestid in (select id from cowork_items t1 where t1.status=1  and (dbms_lob.instr(t1.coworkers,',"+userid+",',1,1)>0 or t1.creater="+userid+") and dbms_lob.instr(t1.isnew,',"+userid+",',1,1)<=0))   or type in (2,3,4,6,7,8,11,12,13)) group by a.type";
      } else {
          sql = "select a.type, sum(a.counts) as count, (select statistic from SysPoppupinfo where type=a.type) as statistic, (select typedescription from SysPoppupinfo where type=a.type) as typedescription, (select link from SysPoppupinfo where type=a.type) as link from SysPoppupRemindInfoNew a where  a.userid="+userid+" and a.usertype='"+usertype+"'  and ( (a.type=0 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and isremark in ('0','1','8','9','7') ) )   or (a.type=1 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and exists (select 1 from workflow_requestbase where workflow_requestbase.requestid=workflow_currentoperator.requestid and currentnodetype=3) ) ) or (a.type=14 and a.requestid in (select requestid from workflow_currentoperator where userid="+userid+" and usertype='"+usertype+"' and islasttimes=1 and exists (select 1 from workflow_requestbase where workflow_requestbase.requestid=workflow_currentoperator.requestid) ) ) or (type=10 and requestid in (select requestid from workflow_currentoperator where ((isremark='0' and (isprocessed='2' or isprocessed='3' or isprocessed is null))  or isremark='5') and islasttimes=1)) or (a.type=9 and a.requestid in (select id from cowork_items t1 where  t1.status=1 and (t1.coworkers like '%,"+userid+",%' or t1.creater="+userid+") and t1.isnew not like '%,"+userid+",%'))   or type in (2,3,4,6,7,8,11,12,13)) group by a.type";
      }
      rs.executeSql(sql);
      
      while(rs.next()){
      	bgindex++;
          if(rs.getString("statistic").equals("y")) {   
             int count=rs.getInt("count");
             StringBuffer sfcm = new StringBuffer();
             sfcm.append("<li>");
             sfcm.append("<a class='lfMenuItem' href='");
             sfcm.append(rs.getString("link"));
             //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\"");
             sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
             sfcm.append(" target=\"" + "mainFrame" + "\" >");
             sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
             sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  		   sfcm.append(SystemEnv.getHtmlLabelName(rs.getInt("typedescription"),user.getLanguage())+"("+count+")");
  		   sfcm.append("</div>");
             sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
             sfcm.append("<div style='width:4px;'></div></a>");
             sfcm.append("</li>");
             s += sfcm.toString();
          } else {
              StringBuffer sfcm = new StringBuffer();
              sfcm.append("<li>");
              sfcm.append("<a class='lfMenuItem' href='");
              sfcm.append(rs.getString("link"));
              //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\"");
              sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
              sfcm.append(" target=\"" + "mainFrame" + "\" >");
              sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
              sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  			sfcm.append(SystemEnv.getHtmlLabelName(rs.getInt("typedescription"),user.getLanguage()));
  			 sfcm.append("</div>");
              sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
              sfcm.append("<div style='width:4px;'></div></a>");
              sfcm.append("</li>");
              s += sfcm.toString();
              //s += "<tree text=\""+SystemEnv.getHtmlLabelName(rs.getInt("typedescription"),user.getLanguage())+"\" icon=\"/images_face/ecologyFace_2/LeftMenuIcon/level3.gif\" action=\""+rs.getString("link")+"\" />";
          }
      }
      s +="</ul>";
      return s;
  }


  
  private String getVotingMenu(User user) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
  
      int bgcnt = 4;
      int bgindex = 4;
  
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      RecordSet rs = new RecordSet();
      Date newdate = new Date() ;
      long datetime = newdate.getTime() ;
      Timestamp timestamp = new Timestamp(datetime) ;
      String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
      String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16);
      
      String sql="";
      //Voting
      sql = "SELECT DISTINCT t1.id,t1.subject FROM voting t1,VotingShareDetail t2 WHERE t1.id=t2.votingid AND t2.resourceid="+user.getUID()+" AND t1.status=1 AND t1.id NOT IN (SELECT DISTINCT votingid FROM votingresource WHERE resourceid="+user.getUID()+")"+" and t1.beginDate<='"+CurrentDate+"' and (t1.beginTime is null or t1.beginTime='' or t1.beginTime<='"+CurrentTime+"') ";
      rs.executeSql(sql);
      
      while(rs.next()){
      	bgindex++;
          StringBuffer sfcm = new StringBuffer();
          String menuname=rs.getString("subject");
          if(menuname.length()>9){
          	menuname =menuname.substring(0,9)+"...";
          }
          sfcm.append("<li>");
          sfcm.append("<a class='lfMenuItem' href=\"");
          sfcm.append("javascript:window.open('/voting/VotingPoll.jsp?votingid="+rs.getInt("id")+"', '','toolbar,resizable,scrollbars,dependent,height=600,width=800,top=0,left=100');void(0);");
          //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\"");
          sfcm.append("\" _bgPosition='" + sbgPostions[bgindex%4] + "'");
          sfcm.append(">");
          sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
          sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  		 sfcm.append(menuname);
  		 sfcm.append("</div>");
          sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
          sfcm.append("<div style='width:4px;'></div></a>");
          sfcm.append("</li>");
          s += sfcm.toString();
      }
      s += "</ul>";
      return s;
  }


  
  private String getTypesMenu(User user) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
  
      int bgcnt = 4;
      int bgindex = 4;
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      StringBuffer sfcm = null;
      RecordSet rs = new RecordSet();
      rs.executeSql("select * from newstype order by dspnum,id");
      while (rs.next()){
      	bgindex++;
          //sf.append("<tree text=\""+rs.getString("typename")+"\" action=\"javascript:void(0)\" src=\"/LeftMenu/InfoCenterTreeNews1.jsp?typeid="+rs.getString("id")+"\"></tree>");
          sfcm = new StringBuffer();
          sfcm.append("<li>");
          sfcm.append("<a class='lfMenuItem' href='");
          sfcm.append("javascript:void(0);");
          //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
          sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
          //sfcm.append(" action='javascript:void(0);'");
          sfcm.append(" target=\"" + "mainFrame" + "\" >");
          sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
          sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
          sfcm.append(rs.getString("typename"));
  		 sfcm.append("</div>");
          sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
          sfcm.append("<div style='width:4px;'></div></a>");
          sfcm.append(getNews1Menu(user, Integer.parseInt(rs.getString("id"))));
          sfcm.append("</li>");
          s += sfcm.toString();
          
      }
      bgindex++;
      //sf.append("<tree text=\""+SystemEnv.getHtmlLabelName(811,7)+"\" action=\"javascript:void(0)\" src=\"/LeftMenu/InfoCenterTreeNews1.jsp?typeid=0\"></tree>");
      sfcm = new StringBuffer();
      sfcm.append("<li>");
      sfcm.append("<a class='lfMenuItem' href='");
      sfcm.append("javascript:void(0);");
      //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
      sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
      //sfcm.append(" action='javascript:void(0);'");
      sfcm.append(" target=\"" + "mainFrame" + "\" >");
      sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
      sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  	sfcm.append(SystemEnv.getHtmlLabelName(811,7));
  	sfcm.append("</div>");
      sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
   
      sfcm.append("<div style='width:4px;'></div></a>");
      sfcm.append(getNews1Menu(user, 0));
      sfcm.append("</li>");
      s += sfcm.toString();
  
      s += "</ul>";
      
      return s;
  }
  
  private String getNews1Menu(User user, int typeid) {
      if(user == null) {
          return null;
      }
      String s = "<ul>";
    //---------------------------
      // \u83dc\u5355\u9879\u80cc\u666f\u56fe\u7247\u968f\u673a\u663e\u793a
      // bgcnt   : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u4e2a\u6570
      // bgindex : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u968f\u673a\u7528\u4e0b\u6807
      // abgs    : \u5de6\u4fa7\u83dc\u5355\u80cc\u666f\u56fe\u7247\u6570\u7ec4
      //---------------------------
      int bgcnt = 4;
      int bgindex = 4;
      
      String[] sbgPostions = new String[]{"0 -28", "0 -84", "0 0", "0 -56"};
      
      RecordSet rs = new RecordSet();
      String strSql="";
      if(typeid==0) {
          strSql="select id,frontpagename from DocFrontpage where isactive='1' and publishtype=1 and (newstypeid=0 or newstypeid is null) order by typeordernum,id";
      } else {
          strSql="select  id,frontpagename from DocFrontpage where isactive='1' and publishtype=1 and newstypeid="+typeid+" order by typeordernum,id";
      }
      
      rs.executeSql(strSql);
      while (rs.next()){
      	bgindex++;
          StringBuffer sfcm = new StringBuffer();
          sfcm.append("<li>");
          sfcm.append("<a class='lfMenuItem' href='");
          sfcm.append("/docs/news/NewsDsp.jsp?id="+rs.getString("id"));
          //sfcm.append("' style=\"background:url('").append(abgs[bgindex%4]).append("') no-repeat;\" ");
          sfcm.append("' _bgPosition='" + sbgPostions[bgindex%4] + "'");
          sfcm.append(" target=\"" + "mainFrame" + "\" >");
          sfcm.append("<div class=\"leftMenuItemLeft\" style=\"background-position: " + sbgPostions[bgindex%4] + ";\"></div>");
          sfcm.append("<div class=\"leftMenuItemCenter\"; style=\"\">");
  		sfcm.append(rs.getString("frontpagename"));
  		sfcm.append("</div>");
          sfcm.append("<div class=\"leftMenuItemRight\" style=\"\"></div>");
     
          sfcm.append("<div style='width:4px;'></div></a>");
          sfcm.append("</li>");
          s += sfcm.toString();
      }
      s += "</ul>";
      return s;
  }

  
  public void
  _jspService(javax.servlet.http.HttpServletRequest request,
              javax.servlet.http.HttpServletResponse response)
    throws java.io.IOException, javax.servlet.ServletException
  {
    javax.servlet.http.HttpSession session = request.getSession(true);
    com.caucho.server.webapp.WebApp _jsp_application = _caucho_getApplication();
    javax.servlet.ServletContext application = _jsp_application;
    com.caucho.jsp.PageContextImpl pageContext = _jsp_application.getJspApplicationContext().allocatePageContext(this, _jsp_application, request, response, null, session, 8192, true, false);
    javax.servlet.jsp.PageContext _jsp_parentContext = pageContext;
    javax.servlet.jsp.JspWriter out = pageContext.getOut();
    final javax.el.ELContext _jsp_env = pageContext.getELContext();
    javax.servlet.ServletConfig config = getServletConfig();
    javax.servlet.Servlet page = this;
    response.setContentType("text/html; charset=GBK");
    request.setCharacterEncoding("GBK");
    try {
      out.write(_jsp_string0, 0, _jsp_string0.length);
      


String result = "";

String parentid = Util.null2String(request.getParameter("parentid"));
String typeid = Util.null2String(request.getParameter("typeid"));

User user = HrmUserVarify.getUser (request , response) ;



if ("111".equals(typeid)) {
    result = getInfoCenterMenu(user);
} else {
    result = getSettingMenu(user, parentid);
}
 

out.print(result);

      out.write(_jsp_string1, 0, _jsp_string1.length);
    } catch (java.lang.Throwable _jsp_e) {
      pageContext.handlePageException(_jsp_e);
    } finally {
      _jsp_application.getJspApplicationContext().freePageContext(pageContext);
    }
  }

  private java.util.ArrayList _caucho_depends = new java.util.ArrayList();

  public java.util.ArrayList _caucho_getDependList()
  {
    return _caucho_depends;
  }

  public void _caucho_addDepend(com.caucho.vfs.PersistentDependency depend)
  {
    super._caucho_addDepend(depend);
    com.caucho.jsp.JavaPage.addDepend(_caucho_depends, depend);
  }

  public boolean _caucho_isModified()
  {
    if (_caucho_isDead)
      return true;
    if (com.caucho.server.util.CauchoSystem.getVersionId() != 1886798272571451039L)
      return true;
    for (int i = _caucho_depends.size() - 1; i >= 0; i--) {
      com.caucho.vfs.Dependency depend;
      depend = (com.caucho.vfs.Dependency) _caucho_depends.get(i);
      if (depend.isModified())
        return true;
    }
    return false;
  }

  public long _caucho_lastModified()
  {
    return 0;
  }

  public java.util.HashMap<String,java.lang.reflect.Method> _caucho_getFunctionMap()
  {
    return _jsp_functionMap;
  }

  public void init(ServletConfig config)
    throws ServletException
  {
    com.caucho.server.webapp.WebApp webApp
      = (com.caucho.server.webapp.WebApp) config.getServletContext();
    super.init(config);
    com.caucho.jsp.TaglibManager manager = webApp.getJspApplicationContext().getTaglibManager();
    com.caucho.jsp.PageContextImpl pageContext = new com.caucho.jsp.PageContextImpl(webApp, this);
  }

  public void destroy()
  {
      _caucho_isDead = true;
      super.destroy();
  }

  public void init(com.caucho.vfs.Path appDir)
    throws javax.servlet.ServletException
  {
    com.caucho.vfs.Path resinHome = com.caucho.server.util.CauchoSystem.getResinHome();
    com.caucho.vfs.MergePath mergePath = new com.caucho.vfs.MergePath();
    mergePath.addMergePath(appDir);
    mergePath.addMergePath(resinHome);
    com.caucho.loader.DynamicClassLoader loader;
    loader = (com.caucho.loader.DynamicClassLoader) getClass().getClassLoader();
    String resourcePath = loader.getResourcePathSpecificFirst();
    mergePath.addClassPath(resourcePath);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(appDir.lookup("wui/theme/ecology7/page/ajaxGetMenu.jsp"), 5455905175877923347L, false);
    com.caucho.jsp.JavaPage.addDepend(_caucho_depends, depend);
  }

  private final static char []_jsp_string1;
  private final static char []_jsp_string0;
  static {
    _jsp_string1 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n".toCharArray();
    _jsp_string0 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n".toCharArray();
  }
}
