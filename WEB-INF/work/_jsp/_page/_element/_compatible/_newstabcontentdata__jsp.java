/*
 * JSP generated by Resin-3.1.8 (built Mon, 17 Nov 2008 12:15:21 PST)
 */

package _jsp._page._element._compatible;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import weaver.general.*;
import weaver.homepage.style.HomepageStyleBean;
import java.util.*;
import weaver.hrm.*;
import weaver.systeminfo.*;
import weaver.general.StaticObj;
import weaver.general.Util;
import weaver.hrm.settings.RemindSettings;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class _newstabcontentdata__jsp extends com.caucho.jsp.JavaPage
{
  private static final java.util.HashMap<String,java.lang.reflect.Method> _jsp_functionMap = new java.util.HashMap<String,java.lang.reflect.Method>();
  private boolean _caucho_isDead;
  
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
      weaver.homepage.cominfo.HomepageCominfo hpc;
      hpc = (weaver.homepage.cominfo.HomepageCominfo) pageContext.getAttribute("hpc");
      if (hpc == null) {
        hpc = new weaver.homepage.cominfo.HomepageCominfo();
        pageContext.setAttribute("hpc", hpc);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.homepage.HomepageUtil hpu;
      hpu = (weaver.homepage.HomepageUtil) pageContext.getAttribute("hpu");
      if (hpu == null) {
        hpu = new weaver.homepage.HomepageUtil();
        pageContext.setAttribute("hpu", hpu);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.homepage.cominfo.HomepageElementCominfo hpec;
      hpec = (weaver.homepage.cominfo.HomepageElementCominfo) pageContext.getAttribute("hpec");
      if (hpec == null) {
        hpec = new weaver.homepage.cominfo.HomepageElementCominfo();
        pageContext.setAttribute("hpec", hpec);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.homepage.cominfo.HomepageElementFieldCominfo hpefc;
      hpefc = (weaver.homepage.cominfo.HomepageElementFieldCominfo) pageContext.getAttribute("hpefc");
      if (hpefc == null) {
        hpefc = new weaver.homepage.cominfo.HomepageElementFieldCominfo();
        pageContext.setAttribute("hpefc", hpefc);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.homepage.HomepageExtShow hpes;
      hpes = (weaver.homepage.HomepageExtShow) pageContext.getAttribute("hpes");
      if (hpes == null) {
        hpes = new weaver.homepage.HomepageExtShow();
        pageContext.setAttribute("hpes", hpes);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.homepage.style.HomepageStyleUtil hpsu;
      hpsu = (weaver.homepage.style.HomepageStyleUtil) pageContext.getAttribute("hpsu");
      if (hpsu == null) {
        hpsu = new weaver.homepage.style.HomepageStyleUtil();
        pageContext.setAttribute("hpsu", hpsu);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.page.PageCominfo pc;
      pc = (weaver.page.PageCominfo) pageContext.getAttribute("pc");
      if (pc == null) {
        pc = new weaver.page.PageCominfo();
        pageContext.setAttribute("pc", pc);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.page.style.ElementStyleCominfo esc;
      esc = (weaver.page.style.ElementStyleCominfo) pageContext.getAttribute("esc");
      if (esc == null) {
        esc = new weaver.page.style.ElementStyleCominfo();
        pageContext.setAttribute("esc", esc);
      }
      out.write(_jsp_string2, 0, _jsp_string2.length);
      weaver.conn.RecordSet rsCommon;
      rsCommon = (weaver.conn.RecordSet) pageContext.getAttribute("rsCommon");
      if (rsCommon == null) {
        rsCommon = new weaver.conn.RecordSet();
        pageContext.setAttribute("rsCommon", rsCommon);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.page.element.ElementUtil ec;
      ec = (weaver.page.element.ElementUtil) pageContext.getAttribute("ec");
      if (ec == null) {
        ec = new weaver.page.element.ElementUtil();
        pageContext.setAttribute("ec", ec);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.page.PageUtil pu;
      pu = (weaver.page.PageUtil) pageContext.getAttribute("pu");
      if (pu == null) {
        pu = new weaver.page.PageUtil();
        pageContext.setAttribute("pu", pu);
      }
      out.write(_jsp_string3, 0, _jsp_string3.length);
      
	
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
	

	User user = HrmUserVarify.getUser (request , response) ;
	if(user == null)  return ;
	Log logger= LogFactory.getLog(this.getClass());

      out.write(_jsp_string1, 0, _jsp_string1.length);
      
	 /*
	 \u57fa\u672c\u4fe1\u606f
	 --------------------------------------
	 hpid:\u8868\u9996\u9875ID
	 subCompanyId:\u9996\u9875\u6240\u5c5e\u5206\u90e8\u7684\u5206\u90e8ID
	 eid:\u5143\u7d20ID
	 ebaseid:\u57fa\u672c\u5143\u7d20ID
	 styleid:\u6837\u5f0fID
	 
	 \u6761\u4ef6\u4fe1\u606f
	 --------------------------------------
	 String strsqlwhere \u683c\u5f0f\u4e3a \u6761\u4ef61^,^\u6761\u4ef62...
	 int perpage  \u663e\u793a\u9875\u6570
	 String linkmode \u67e5\u770b\u65b9\u5f0f  1:\u5f53\u524d\u9875 2:\u5f39\u51fa\u9875

	 
	 \u5b57\u6bb5\u4fe1\u606f
	 --------------------------------------
	 fieldIdList
	 fieldColumnList
	 fieldIsDate
	 fieldTransMethodList
	 fieldWidthList
	 linkurlList
	 valuecolumnList
	 isLimitLengthList

	 \u6837\u5f0f\u4fe1\u606f
	 ----------------------------------------
	 String hpsb.getEsymbol() \u5217\u9996\u56fe\u6807
	 String hpsb.getEsparatorimg()   \u884c\u5206\u9694\u7ebf 
	 */

      out.write(_jsp_string1, 0, _jsp_string1.length);
      
	String hpid = Util.null2String(request.getParameter("hpid"));
	int subCompanyId = Util.getIntValue(request
			.getParameter("subCompanyId"), -1);
	String eid = Util.null2String(request.getParameter("eid"));
	String ebaseid = Util.null2String(request.getParameter("ebaseid"));
	String styleid = Util.null2String(request.getParameter("styleid"));
	int perpage = 0;
	int userid = pu.getHpUserId(hpid, "" + subCompanyId, user);
	int usertype = pu.getHpUserType(hpid, "" + subCompanyId, user);
	//\u5224\u65ad\u5f53\u524d\u7528\u6237\u662f\u5426\u6709\u6743\u9650\u67e5\u770b\u8be5\u5143\u7d20
	
	boolean hasRight =true;
	User loginuser = (User)request.getSession(true).getAttribute("weaver_user@bean") ;
	// \u5148\u53d6\u6d88\u6743\u9650\u5224\u65ad
	if(loginuser != null)  {
		hasRight =  ec.isHasRight(eid,loginuser.getUID()+"");
	}
	if(!hasRight){
		response.sendRedirect("/page/element/noright.jsp");
	}
	//HomepageStyleBean hpsb = hpsu.getHpsb(styleid);

	//\u5f97\u5230\u9700\u8981\u663e\u793a\u7684\u5b57\u6bb5
	ArrayList fieldIdList = new ArrayList();
	ArrayList fieldColumnList = new ArrayList();
	ArrayList fieldIsDate = new ArrayList();
	ArrayList fieldTransMethodList = new ArrayList();
	ArrayList fieldWidthList = new ArrayList();
	ArrayList linkurlList = new ArrayList();
	ArrayList valuecolumnList = new ArrayList();
	ArrayList isLimitLengthList = new ArrayList();

	
	rsCommon.executeSql("select 1 from hpinfo where id="+hpid+" and isLocked=1");
	if (rsCommon.next()) {
		rsCommon.executeSql("select creatorid,creatortype from hpinfo where id="+hpid);
		if(rsCommon.next())
		{
			userid =Util.getIntValue(rsCommon.getString("creatorid"));
			usertype = Util.getIntValue(rsCommon.getString("creatortype"));
		}
	}

	String fields = "";
	String linkmode = "";
	String currenttab="";

	String strsqlwhere = hpec.getStrsqlwhere(eid);

	String strSql = "select perpage,linkmode,showfield from hpElementSettingDetail where eid="
			+ eid
			+ " and userid="
			+ userid
			+ " and usertype="
			+ usertype;
	rsCommon.executeSql(strSql);
	if (rsCommon.next()) {
		fields = Util.null2String(rsCommon.getString("showfield"));
		perpage = Util.getIntValue(rsCommon.getString("perpage"));
		linkmode = Util.null2String(rsCommon.getString("linkmode"));
	}
	rsCommon.execute("select currenttab from hpcurrenttab where eid="+eid
			+ " and userid="
			+ user.getUID()
			+ " and usertype="
			+ user.getType());
	if(rsCommon.next()){
		currenttab = Util.null2String(rsCommon.getString("currenttab"));
	}else{
		rsCommon.execute("insert into hpcurrenttab (currenttab,eid,userid,usertype) values ( null,"+eid+","+user.getUID()+","+user.getType()+")");
	}
	if (!"".equals(fields)) {
		ArrayList tempFieldList = Util.TokenizerString(fields, ",");
		for (int i = 0; i < tempFieldList.size(); i++) {
			String tempId = (String) tempFieldList.get(i);
			fieldIdList.add(tempId);
			fieldColumnList.add(hpefc.getFieldcolumn(tempId));
			fieldIsDate.add(hpefc.getIsdate(tempId));
			fieldTransMethodList.add(hpefc.getTransmethod(tempId));
			fieldWidthList.add(hpefc.getFieldWidth(tempId));
			linkurlList.add(hpefc.getLinkurl(tempId));
			valuecolumnList.add(hpefc.getValuecolumn(tempId));
			isLimitLengthList.add(hpefc.getIsLimitLength(tempId));
		}
	}
	String isFixationRowHeight="0";
	String background="";
	strSql = "select isFixationRowHeight,background from hpelement where id="+ eid;
	rsCommon.executeSql(strSql);
	if (rsCommon.next()) {
		isFixationRowHeight = Util.null2String(rsCommon.getString("isFixationRowHeight"));
		background = Util.null2String(rsCommon.getString("background"));
	}
	
	String eStyleid=hpec.getStyleid(eid);

      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.conn.RecordSet rs;
      rs = (weaver.conn.RecordSet) pageContext.getAttribute("rs");
      if (rs == null) {
        rs = new weaver.conn.RecordSet();
        pageContext.setAttribute("rs", rs);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.docs.news.DocNewsManager dnm;
      dnm = (weaver.docs.news.DocNewsManager) pageContext.getAttribute("dnm");
      if (dnm == null) {
        dnm = new weaver.docs.news.DocNewsManager();
        pageContext.setAttribute("dnm", dnm);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.docs.docs.DocManager dm;
      dm = (weaver.docs.docs.DocManager) pageContext.getAttribute("dm");
      if (dm == null) {
        dm = new weaver.docs.docs.DocManager();
        pageContext.setAttribute("dm", dm);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      weaver.docs.docs.DocComInfo dc;
      dc = (weaver.docs.docs.DocComInfo) pageContext.getAttribute("dc");
      if (dc == null) {
        dc = new weaver.docs.docs.DocComInfo();
        pageContext.setAttribute("dc", dc);
      }
      out.write(_jsp_string1, 0, _jsp_string1.length);
      
		/*
		\u57fa\u672c\u4fe1\u606f
		--------------------------------------
		hpid:\u8868\u9996\u9875ID
		subCompanyId:\u9996\u9875\u6240\u5c5e\u5206\u90e8\u7684\u5206\u90e8ID
		eid:\u5143\u7d20ID
		ebaseid:\u57fa\u672c\u5143\u7d20ID
		styleid:\u6837\u5f0fID
		
		\u6761\u4ef6\u4fe1\u606f
		--------------------------------------
		String strsqlwhere \u683c\u5f0f\u4e3a \u6761\u4ef61^,^\u6761\u4ef62...
		int perpage  \u663e\u793a\u9875\u6570
		String linkmode \u67e5\u770b\u65b9\u5f0f  1:\u5f53\u524d\u9875 2:\u5f39\u51fa\u9875

		
		\u5b57\u6bb5\u4fe1\u606f
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		valuecolumnList
		isLimitLengthList

		\u6837\u5f0f\u4fe1\u606f
		----------------------------------------
		String esc.getIconEsymbol(pc.getStyleid(eid)) \u5217\u9996\u56fe\u6807
		class='sparator' \u884c\u5206\u9694\u7ebf 
	*/

      out.write(_jsp_string2, 0, _jsp_string2.length);
      
String returnStr = "";

//\u66f4\u65b0\u5f53\u524dtab\u4fe1\u606f
String tabid = Util.null2String(request.getParameter("tabId"));
String updateSql = "update  hpcurrenttab set currenttab ='"+tabid+"' where eid="
	+ eid
	+ " and userid="
	+ user.getUID()
	+ " and usertype="
	+ user.getType();
rs.execute(updateSql);

//\u56fe\u7247\u5927\u5c0f
int imgWidth=120;
int imgHeight = 108;
String topDocIds="";//\u7f6e\u9876\u6587\u6863ID
int topDocCount = 0;//\u7f6e\u9876\u6587\u6863\u6570\u76ee
strsqlwhere = Util.null2String(request.getParameter("tabWhere"));
if(strsqlwhere.indexOf("^topdoc^")!=-1){
	strsqlwhere = Util.StringReplace(strsqlwhere, "^topdoc^","#");
	String[] temp = Util.TokenizerString2(strsqlwhere, "#");
	strsqlwhere = Util.null2String(temp[0]);
	if(temp.length>1){
		topDocIds = Util.null2String(temp[1]);
	}
}

// \u5f97\u5230\u65b0\u95fb\u9875ID\u4ee5\u53ca\u76f8\u5173\u7684\u5c55\u73b0\u65b9\u5f0f
if(strsqlwhere.length()<3) return;
if("^,^".equals(strsqlwhere.substring(0,3)))  return ;
try {
	strsqlwhere = Util.StringReplace(strsqlwhere, "^,^","&");
} catch (Exception e) {			
	e.printStackTrace();
}
String srcOpenFirstAccess="0" ;
String[] strsqlwheres = Util.TokenizerString2(strsqlwhere, "&");
String newsId = Util.null2String(strsqlwheres[0]);
int showModeId = Util.getIntValue(strsqlwheres[1]);
if (strsqlwheres.length>3) srcOpenFirstAccess=strsqlwheres[3];
//System.out.println("strsqlwhere:"+strsqlwhere);
//System.out.println("newsId:"+newsId);
String srcType="0";
String srcContent="0";
String srcReply="0";

String newstemplateid="";
String newstemplatetype="";
String imgType="";
String imgSrc="";

rs.execute("select newstemplate,imgtype,imgsrc from hpFieldLength where eid="+eid+" and usertype=3 order by id desc");
if(rs.next()){
	//newstemplateid = Util.null2String(rs.getString("newstemplate"));
	imgType = rs.getString("imgtype");
	imgSrc = rs.getString("imgsrc");
}
rs.execute("select newstemplate from hpElement where id="+eid);
if(rs.next()){
	newstemplateid = Util.null2String(rs.getString("newstemplate"));
}

if(!"".equals(newstemplateid)){
	rs.execute("select templatetype from pagenewstemplate where id="+newstemplateid);
	if(rs.next()){
		newstemplatetype = rs.getString("templatetype"); 
	}
}

ArrayList docSrcList=Util.TokenizerString(""+newsId, "|");
if (docSrcList.size()>0) srcType=(String)docSrcList.get(0);
if (docSrcList.size()>1) srcContent=(String)docSrcList.get(1);
if (docSrcList.size()>2) srcReply=(String)docSrcList.get(2);


if("0".equals(srcContent)) return ;
String strAccess="";
if("1".equals(srcOpenFirstAccess)) strAccess="&isOpenFirstAss=1";
else strAccess="&isOpenFirstAss=0";
		
String rollDirection="";
if(strsqlwheres.length<=2)  rollDirection="None";
else  rollDirection=strsqlwheres[2];

      out.write(_jsp_string4, 0, _jsp_string4.length);
      
String  userid1=""+user.getUID();
String ownerid=userid1;
String strImg="";
ArrayList docIdList=new ArrayList();
ArrayList docsubjectList=new ArrayList();
ArrayList doclastmoddateList=new ArrayList();
ArrayList doclastmodtimeList=new ArrayList();
ArrayList docContentList=new ArrayList();
ArrayList doccreateridList = new ArrayList();
ArrayList readCountList = new ArrayList();
String andSql="";
//String invalidStr = " or docstatus = 7 and  (sharelevel>1" + ((userid1!=null&&!"".equals(userid1))?" or (doccreaterid=" + userid1 + ((ownerid!=null&&!"".equals(ownerid))?" or ownerid=" + ownerid:"") + ")":"") + ") ";
//String strStatus=" and (docstatus='1' or docstatus='2' or docstatus='5' "+invalidStr+")";
String invalidStr = " or (docstatus = 7 and  (sharelevel>1" + ((userid1!=null&&!"".equals(userid1))?" or (doccreaterid=" + userid1 + ((ownerid!=null&&!"".equals(ownerid))?" or ownerid=" + ownerid:"") + ")":"") + ")) ";
String strStatus=" and (((docstatus='1' or docstatus='2' or docstatus='5') and sharelevel>0) "+invalidStr+")";

/**\u6587\u6863\u7f6e\u9876*/
if(!topDocIds.equals("")){
	ArrayList docids=Util.TokenizerString(topDocIds,",");
	String newDocids="";
    for(int i=0;i<docids.size();i++)	newDocids+=","+dm.getNewDocid((String)docids.get(i));
	if(newDocids.length()>0) newDocids=newDocids.substring(1);
	
	andSql=" and id in("+newDocids+") "+strStatus;
	dm.selectNewsDocInfo(andSql, user,perpage, 1);
	while (dm.next()) {
		docIdList.add(""+dm.getDocid());
		docsubjectList.add(""+dm.getDocsubject()) ;
		doclastmoddateList.add(""+dm.getDoclastmoddate()) ;
		doclastmodtimeList.add(""+dm.getDoclastmodtime()) ;
		docContentList.add(dm.getDoccontent());
		doccreateridList.add(""+dm.getDoccreaterid());
		readCountList.add(""+dm.getReadCount());
	}
	//topDocCount = docids.size();
	//perpage = perpage-docids.size();
	topDocCount = dm.getCount();
	perpage = perpage-topDocCount;
	if(perpage<0){
		perpage = 0;
	}
}


if("1".equals(srcType)){
	String newsclause = "";

	dnm.resetParameter();
	dnm.setId(Util.getIntValue(srcContent));
	dnm.getDocNewsInfoById();
	newsclause = dnm.getNewsclause();
	dnm.closeStatement();

	String newslistclause = newsclause.trim();
	if (!newslistclause.equals("")) 	newslistclause = " and (" + newslistclause+") ";
	andSql = newslistclause	+ "  and (ishistory is null or ishistory = 0)  and docpublishtype in('2','3') "+strStatus;
	dm.selectNewsDocInfo(andSql, user,perpage, 1);
} else if("2".equals(srcType)){  //\u5206\u76ee\u5f55
	if(",".equals(srcContent.substring(0,1))) srcContent=srcContent.substring(1);
	andSql="  and (ishistory is null or ishistory = 0)  and exists (select id from docseccategory where id = seccategory and id in ("+srcContent+")) "+strStatus;
    if (!"1".equals(srcReply))	andSql+=" and (isreply!=1 or  isreply is null) ";
	dm.selectNewsDocInfo(andSql, user,perpage, 1);
		
} else if("3".equals(srcType)){  //\u865a\u62df\u76ee\u5f55	
	andSql=" and (ishistory is null or ishistory = 0)  "+strStatus;
	if (!"1".equals(srcReply))	andSql+=" and (isreply!=1 or  isreply is null)";
	//dm.selectNewsDocInfo(andSql, user,perpage, 1,srcContent);
	dm.selectNewsDocInfoForHp(andSql, user,perpage, 1,srcContent);

} else if("4".equals(srcType)){ //\u6307\u5b9a\u6587\u6863
	ArrayList docids=Util.TokenizerString(srcContent,",");
	String newDocids="";
    for(int i=0;i<docids.size();i++)	newDocids+=","+dm.getNewDocid((String)docids.get(i));
	if(newDocids.length()>0) newDocids=newDocids.substring(1);
	
	andSql=" and id in("+newDocids+") "+strStatus;
	dm.selectNewsDocInfo(andSql, user,perpage, 1);

}else if("5".equals(srcType)){ //\u641c\u7d22\u6a21\u677f

}else if("6".equals(srcType)){ //\u641c\u7d22\u6761\u4ef6
//\u9884\u7559
}

while (dm.next()) {
	docIdList.add(""+dm.getDocid());
	docsubjectList.add(""+dm.getDocsubject()) ;
	doclastmoddateList.add(""+dm.getDoclastmoddate()) ;
	doclastmodtimeList.add(""+dm.getDoclastmodtime()) ;
	docContentList.add(dm.getDoccontent());
	doccreateridList.add(""+dm.getDoccreaterid());
	readCountList.add(""+dm.getReadCount());
}

int index = fieldColumnList.indexOf("img");

if(index!=-1){
	String imgfieldId = (String)fieldIdList.get(index);
	String sql = "";
	
	if(hpc.getIsLocked(hpid).equals("1")) {
		sql="select imgsize from hpFieldLength where eid="+ eid + " and efieldid=" + imgfieldId+"" +" and userid="+hpc.getCreatorid(hpid)+" and usertype="+hpc.getCreatortype(hpid);
	}else{
    	sql="select imgsize from hpFieldLength where eid="+ eid + " and efieldid=" + imgfieldId+"" +" and userid="+hpu.getHpUserId(hpid,""+subCompanyId,user)+" and usertype="+hpu.getHpUserType(hpid,""+subCompanyId,user);
	}

    rs.execute(sql);
    if (rs.next()){
	String imgSize = Util.null2String(rs.getString("imgsize"));
	
	if(!"".equals(imgSize)){
		ArrayList imgSizeAry = Util.TokenizerString(imgSize,"*");
		imgWidth = Util.getIntValue((String)imgSizeAry.get(0),imgWidth);
		imgHeight = Util.getIntValue((String)imgSizeAry.get(1),imgHeight);
	}
    }
    
}

if(showModeId == 4){
	strImg="";
	if(imgType.equals("0")||imgType.equals("")){
		if (fieldColumnList.contains("img")) {
	strImg = hpes.getImgPlay(request,docIdList,docContentList,imgWidth,imgHeight,hpec.getStyleid(eid),eid);
		}
	}else{
		strImg = "<img src="+imgSrc+" height = "+imgHeight+" width="+imgWidth+" />";
	}
	returnStr +="<table width=\"100%\"  cellPadding='0' cellSpacing='0'><tr><td valign=\"top\"><table cellPadding='0' cellSpacing='0'><tr><TD  height=\"112\" valign=\"top\">"+strImg+"</TD></tr></table></td>\n";
	returnStr +="<td width=1px>&nbsp;</td><td width=\"100%\" valign=\"top\">" ;
}
returnStr += "<TABLE  width=\"100%\"";
//System.out.println("showModeId:"+showModeId);
if (showModeId == 3 || showModeId == 2 ){ //\u5de6\u56fe\u5f0f or \u4e0a\u56fe\u5f0f or \u591a\u56fe\u5f0f
	returnStr += " cellPadding='0' cellSpacing='0' >\n";
} else {
	returnStr += " >\n";
}
int rowcount=0;
String imgSymbol="";
if (!"".equals(esc.getIconEsymbol(hpec.getStyleid(eid)))) imgSymbol="<img name='esymbol' src='"+esc.getIconEsymbol(hpec.getStyleid(eid))+"'>";

String docshowlink = "";//\u6587\u6863\u6253\u5f00\u65b9\u5f0f
if("".equals(newstemplateid)){//\u9ed8\u8ba4\u6587\u6863\u663e\u793a\u9875\u9762
	docshowlink= "/docs/docs/DocDsp.jsp?id=";
}else{//\u6587\u6863\u663e\u793a\u6a21\u7248
	docshowlink = "/page/maint/template/news/newstemplate.jsp?templatetype="+newstemplatetype+"&templateid="+newstemplateid+"&docid=";
}


      out.write(_jsp_string5, 0, _jsp_string5.length);
      
int height = docIdList.size()*23;

if("Up".equals(rollDirection)||"Down".equals(rollDirection)) {
	out.println("<MARQUEE DIRECTION="+rollDirection+"  id=\"webjx_"+eid+"\" onmouseover=\"webjx_"+eid+".stop()\" onmouseout=\"webjx_"+eid+".start()\"  SCROLLDELAY=200 height="+height+">");
}else if("Left".equals(rollDirection)||"Right".equals(rollDirection)) {
	out.println("<MARQUEE DIRECTION="+rollDirection+"  id=\"webjx_"+eid+"\" onmouseover=\"webjx_"+eid+".stop()\" onmouseout=\"webjx_"+eid+".start()\"  SCROLLDELAY=200>");
}

      out.write(_jsp_string6, 0, _jsp_string6.length);
      out.print((eid));
      out.write(_jsp_string7, 0, _jsp_string7.length);
      
	
	 
for (int i=0;i<docIdList.size();i++) {
	int docid = Util.getIntValue((String)docIdList.get(i));
	String docId=(String)docIdList.get(i);
	String docsubject = (String)docsubjectList.get(i);
	String doccontent = (String)docContentList.get(i);
	String doclastmoddate =  (String)doclastmoddateList.get(i);
	String doclastmodtime =  (String)doclastmodtimeList.get(i);
	String doccreaterid = (String)doccreateridList.get(i);
	int readCount = Util.getIntValue((String)readCountList.get(i),0);

	//
	
	
	if(showModeId==5){
		if(i%2==0){
	returnStr+="<tr>";
	
		}
		returnStr += "	<TD width=\"8\">"+imgSymbol+"</TD>\n";
		//returnStr+=""
	}else{
		returnStr += "<TR height=18px>\n";
	}

	if(showModeId == 1||showModeId == 4){
		
		returnStr += "	<TD width=\"8\">"+imgSymbol+"</TD>\n";
	}
	int size = fieldIdList.size();
	 boolean isOnlyImg = false;
	for (int j = 0; j < size; j++) {
		String fieldId = (String) fieldIdList.get(j);
		String columnName = (String) fieldColumnList.get(j);
		String strIsDate = (String) fieldIsDate.get(j);
		String fieldwidth = (String) fieldWidthList.get(j);
		String isLimitLength = (String) isLimitLengthList.get(j);

		String cloumnValue = docsubject;
		String titleValue = cloumnValue;
		
		if (showModeId == 1 || showModeId == 4||showModeId==5) {// \u5217\u8868\u5f0f
	
			//todo
	 if ("docdocsubject".equals(columnName)) {
		int wordLength = 8;
		if ("1".equals(isLimitLength))
			cloumnValue = hpu.getLimitStr(eid, fieldId,cloumnValue,user,hpid,subCompanyId);

			String imgNew="<IMG src='/images/BDNew.gif' border=0 align='absbottom'>";
			if(i<topDocCount){
		imgNew="<IMG src='/images/BDTop.gif' border=0 align='absbottom'>";
			}else if(!dc.getIsNewDoc(docId, user.getLogintype(), ""+user.getUID(),doccreaterid,readCount)){ 
		imgNew="";
			}

		String showValue = "";
		
		if ("1".equals(linkmode)) {
			showValue = "<a href='"+docshowlink
			+ docid+strAccess
			+ "' target='_self'>"
			+ "<font class=font>"+cloumnValue+"</font>" + "</a>\n";
		} else {
			showValue = "<a href=\"javascript:openFullWindowForXtable('"+docshowlink
			+ docid+strAccess
			+ "')\">"
			+ "<font class=font>"+cloumnValue+"</font>"
			+ "</a>\n";
		}
		
		returnStr += "<td width='" + fieldwidth
		+ "' title='" + titleValue + "'>"
		+ showValue +imgNew+ "</td>\n";
	}else if("summary".equals(columnName)){
		String newTitle = hpu.getLimitStr(eid, fieldId,
				cloumnValue,user,hpid,subCompanyId);
		String strmemo = "";
		int tmppos = doccontent.indexOf("!@#$%^&*");
		if (tmppos != -1) strmemo = doccontent.substring(0, tmppos);
		
		if (!fieldColumnList.contains("docdocsubject")){
			newTitle = "";
		} else {
			int tempPos=fieldColumnList.indexOf("docdocsubject");
			String tempFiledId=(String)fieldIdList.get(tempPos);
			newTitle = hpu.getLimitStr(eid, tempFiledId,newTitle,user,hpid,subCompanyId);

			String imgNew="<IMG src='/images/BDNew.gif' border=0 align='absbottom'>";
			if(i<topDocCount){
				imgNew="<IMG src='/images/BDTop.gif' border=0 align='absbottom'>";
			}else if(!dc.getIsNewDoc(docId, user.getLogintype(), ""+user.getUID(),doccreaterid,readCount)){ 
				imgNew="";
			}
			
			if ("1".equals(linkmode)) {
				newTitle = "<a href='"+docshowlink+ docid+strAccess+ "' target='_self'>"+"<font class=font>"+newTitle+"</font>" +imgNew+ "</a>\n";
			} else {
				newTitle = "<a href=\"javascript:openFullWindowForXtable('"+docshowlink+ docid+strAccess+ "')\">"+ "<font class=font>"+newTitle+"</font>" +imgNew+ "</a>\n";
			}
		}
		if (!fieldColumnList.contains("doclastmoddate"))
			doclastmoddate = "";
		if (!fieldColumnList.contains("doclastmodtime"))
			doclastmodtime = "";
		if (!fieldColumnList.contains("summary")){
			strmemo = "";
		} else {			
			int tempPos=fieldColumnList.indexOf("summary");
			String tempFiledId=(String)fieldIdList.get(tempPos);			
			
			strmemo = hpu.getLimitStr(eid, tempFiledId,strmemo,user,hpid,subCompanyId);
			if ("1".equals(linkmode)) {
				strmemo = "<a href='"+docshowlink+ docid+ strAccess+"' target='_self'><font class=font>"+ strmemo + "</font></a>\n";
			} else {
				strmemo = "<a href=\"javascript:openFullWindowForXtable('"+docshowlink+docid+strAccess+ "')\"><font class=font> "+ strmemo+ "</font></a>\n";
			}
		}
		returnStr += "<td  width='" + fieldwidth + "'>"
		+ "<font class=font>"+strmemo+"</font>" + "</td>\n";
		
	} else if ("doclastmoddate".equals(columnName)) {
		returnStr += "<td  width='" + fieldwidth + "'>"
		+ "<font class=font>"+doclastmoddate+"</font>" + "</td>\n";
	} else if ("doclastmodtime".equals(columnName)) {
		returnStr += "<td  width='" + fieldwidth + "'>"
		+ "<font class=font>"+doclastmodtime+"</font>" + "</td>\n";
	}
		 	
		} else {

	String newTitle = hpu.getLimitStr(eid, fieldId,
			cloumnValue,user,hpid,subCompanyId);
	String strmemo = "";
	int tmppos = doccontent.indexOf("!@#$%^&*");
	if (tmppos != -1) strmemo = doccontent.substring(0, tmppos);
	
	if (!fieldColumnList.contains("docdocsubject")){
		newTitle = "";
	} else {
		int tempPos=fieldColumnList.indexOf("docdocsubject");
		String tempFiledId=(String)fieldIdList.get(tempPos);
		newTitle = hpu.getLimitStr(eid, tempFiledId,newTitle,user,hpid,subCompanyId);

		String imgNew="<IMG src='/images/BDNew.gif' border=0 align='absbottom'>";
		if(i<topDocCount){
			imgNew="<IMG src='/images/BDTop.gif' border=0 align='absbottom'>";
		}else if(!dc.getIsNewDoc(docId, user.getLogintype(), ""+user.getUID(),doccreaterid,readCount)){ 
			imgNew="";
		}
		
		if ("1".equals(linkmode)) {
			newTitle = "<a href='"+docshowlink+ docid+strAccess+ "' target='_self'>"+"<font class=font>"+newTitle+"</font>" +imgNew+ "</a>\n";
		} else {
			newTitle = "<a href=\"javascript:openFullWindowForXtable('"+docshowlink+ docid+strAccess+ "')\">"+ "<font class=font>"+newTitle+"</font>" +imgNew+ "</a>\n";
		}
	}
	if (!fieldColumnList.contains("doclastmoddate"))
		doclastmoddate = "";
	if (!fieldColumnList.contains("doclastmodtime"))
		doclastmodtime = "";
	if (!fieldColumnList.contains("summary")){
		strmemo = "";
	} else {			
		int tempPos=fieldColumnList.indexOf("summary");
		String tempFiledId=(String)fieldIdList.get(tempPos);			
		
		strmemo = hpu.getLimitStr(eid, tempFiledId,strmemo,user,hpid,subCompanyId);
		if ("1".equals(linkmode)) {
			strmemo = "<a href='"+docshowlink+ docid+ strAccess+"' target='_self'><font class=font>"+ strmemo + "</font></a>\n";
		} else {
			strmemo = "<a href=\"javascript:openFullWindowForXtable('"+docshowlink+docid+strAccess+ "')\"><font class=font> "+ strmemo+ "</font></a>\n";
		}
	}

	if(perpage!=1) size=size - 1;
	if (showModeId == 2) { // \u4e0a\u56fe\u5f0f
		 //\u5f97\u5230\u56fe\u7247\u64ad\u653e
		
		if(imgType.equals("0")||imgType.equals("")){
			if (fieldColumnList.contains("img")) {
		strImg = hpes.getImgPlay(request,docId,doccontent,imgWidth,imgHeight,hpec.getStyleid(eid),eid);
			}
		}else{
			strImg = "<img src="+imgSrc+" height = "+imgHeight+" width="+imgWidth+" />";
		}
		if("".equals(newTitle )) imgSymbol="";
		returnStr += "<TD colspan=" + size+ " valign=top align=center>"+
				"<TABLE valign=top align=center cellPadding='0' cellSpacing='0'>" +
				"	<TR><TD  valign=top align=center>" + strImg+ "</TD></TR>" +
				"	<TR><TD  align=center>"+imgSymbol+ newTitle+ "</TD></TR>" +
				"	<TR><TD valign=top  align=center>" + strmemo+"</TD></TR>";
		if(!"".equals(doclastmoddate)||!"".equals(doclastmodtime))			
			returnStr+= "<TR><TD valign=top  align=center>" + "<font class=font>"+doclastmoddate + "&nbsp;"+ doclastmodtime+"</font>"+"</TD></TR>";
		returnStr+= "</TABLE></TD>";
		break;
	} else if (showModeId == 3){ // \u5de6\u56fe\u5f0f
		  //\u5f97\u5230\u56fe\u7247\u64ad\u653e
		strImg="";
	
		if(imgType.equals("0")||imgType.equals("")){
			if (fieldColumnList.contains("img")) {
		strImg = hpes.getImgPlay(request,docId,doccontent,imgWidth,imgHeight,hpec.getStyleid(eid),eid);
			}
		}else{
			strImg = "<img src="+imgSrc+" height = "+imgHeight+" width="+imgWidth+" />";
		}
		
		if("".equals(newTitle )) imgSymbol="";
		returnStr += "<TD colspan=" + size+ ">"+
			   "<TABLE   width='100%'>" + 
			   "<TR>" + 
			   "	<TD  rowspan=4 align=left valign=top>"+ strImg + "</TD>" +
			   "	<TD  width='100%'  valign=top>"+
				"		<table width='100%'   valign=top>"+
			   "		<tr>"+
				"	<td>"+imgSymbol+ newTitle+ "</td>"+
			   "		</tr>"+
			   "		<tr height=1px class='sparator' style='height:1px'>"+
				"	<td style='padding:0px'></td>"+
			   "		</tr>"+
			   "		<tr>"+
				"	<td>"+ strmemo+"</td>"+
			   "		</tr>";
			   
	    if(!"".equals(doclastmoddate)||!"".equals(doclastmodtime))	
			returnStr += "<tr><td>"+ "<font class=font>"+doclastmoddate+ "&nbsp;" + doclastmodtime+"</font>"+"</td></tr>" ;
		returnStr += "</table></TD></TR></TABLE></TD>";
		break;
	}
	
		}
		
	}
	if(showModeId==5){
		
		if(i==docIdList.size()-1){
	returnStr+="</tr>";
		}else{
	if(i%2==1){
		returnStr+="</tr>";
		returnStr += "<TR class='sparator' style='height:1px' height=1px><td style='padding:0px' colspan=" + (size + 1)*2
		+ "></td></TR>\n";	
	}else{
		//returnStr+="</tr>";
	}
		}
	}else{
		returnStr += "</TR>\n";
		rowcount++;
		if(perpage!=1&&rowcount<perpage+topDocCount)
	returnStr += "<TR class='sparator' style='height:1px' height=1px><td style='padding:0px' colspan=" + (size + 1)
		+ "></td></TR>\n";	
	}
	//returnStr += "</TR>\n";
		
}
returnStr += "</TABLE>\n";
if(showModeId == 4) {
		  returnStr +="     </td></tr></table>\n";
}
if(showModeId == 4) {
	if(fieldColumnList.size()==1&&fieldColumnList.indexOf("img")!=-1){
		returnStr = strImg;
	}
}
out.println(returnStr);

      out.write(_jsp_string8, 0, _jsp_string8.length);
      
if("Left".equals(rollDirection)||"Right".equals(rollDirection)||"Up".equals(rollDirection)||"Down".equals(rollDirection)) out.println("</MARQUEE>");

      out.write(_jsp_string2, 0, _jsp_string2.length);
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
    depend = new com.caucho.vfs.Depend(appDir.lookup("page/element/compatible/NewsTabContentData.jsp"), 8193315192608630796L, false);
    com.caucho.jsp.JavaPage.addDepend(_caucho_depends, depend);
    depend = new com.caucho.vfs.Depend(appDir.lookup("homepage/element/content/Common.jsp"), 4837643155851355277L, false);
    com.caucho.jsp.JavaPage.addDepend(_caucho_depends, depend);
    depend = new com.caucho.vfs.Depend(appDir.lookup("page/maint/common/initNoCache.jsp"), 2082238920609843656L, false);
    com.caucho.jsp.JavaPage.addDepend(_caucho_depends, depend);
  }

  private final static char []_jsp_string5;
  private final static char []_jsp_string7;
  private final static char []_jsp_string8;
  private final static char []_jsp_string4;
  private final static char []_jsp_string6;
  private final static char []_jsp_string3;
  private final static char []_jsp_string0;
  private final static char []_jsp_string1;
  private final static char []_jsp_string2;
  static {
    _jsp_string5 = "\r\n\r\n	\r\n	".toCharArray();
    _jsp_string7 = "\" class=Econtent  width=100%>\r\n   <TR>\r\n	 <TD width=1px></TD>\r\n	 <TD width='*' valign=\"top\">\r\n	 \r\n	 ".toCharArray();
    _jsp_string8 = "\r\n	</table>\r\n	</TD>    \r\n	<TD width=1px></TD>\r\n  </TR>\r\n</TABLE>\r\n".toCharArray();
    _jsp_string4 = "\r\n\r\n\r\n".toCharArray();
    _jsp_string6 = "\r\n<TABLE  id=\"_contenttable_".toCharArray();
    _jsp_string3 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n".toCharArray();
    _jsp_string0 = "\r\n\r\n\r\n\r\n\r\n".toCharArray();
    _jsp_string1 = "\r\n".toCharArray();
    _jsp_string2 = "\r\n\r\n".toCharArray();
  }
}