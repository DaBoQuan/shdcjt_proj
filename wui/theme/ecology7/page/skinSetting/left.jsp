<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="weaver.general.Util,java.sql.Timestamp"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuConfigHandler"%>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo"%>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuConfig"%>
<%@ page import="weaver.systeminfo.menuconfig.MenuMaint"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="java.util.ArrayList,java.lang.reflect.Method"%>
<%@ page import="weaver.hrm.*"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.systeminfo.menuconfig.*"%>
<%@ page import="weaver.systeminfo.*"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="weaver.systeminfo.setting.*" %>

<script type="text/javascript">

function Map() {    
    var struct = function(key, value) {    
        this.key = key;    
        this.value = value;    
    }    
     
    var put = function(key, value){    
        for (var i = 0; i < this.arr.length; i++) {    
            if ( this.arr[i].key === key ) {    
                this.arr[i].value = value;    
                return;    
            }    
        }    
        this.arr[this.arr.length] = new struct(key, value);    
    }    
         
    var get = function(key) {    
        for (var i = 0; i < this.arr.length; i++) {    
            if ( this.arr[i].key === key ) {    
                return this.arr[i].value;    
            }    
        }    
        return null;    
    }    
         
    var remove = function(key) {    
        var v;    
        for (var i = 0; i < this.arr.length; i++) {    
            v = this.arr.pop();    
            if ( v.key === key ) {    
                continue;    
            }    
            this.arr.unshift(v);    
        }    
    }    
         
    var size = function() {    
        return this.arr.length;    
    }    
         
    var isEmpty = function() {    
        return this.arr.length <= 0;    
    }    
       
    this.arr = new Array();    
    this.get = get;    
    this.put = put;    
    this.remove = remove;    
    this.size = size;    
    this.isEmpty = isEmpty;    
}

</script>

<%
	User user = HrmUserVarify.getUser(request, response);
	//Ƥ��ȡ��
	String lskin = request.getParameter("skin");//(String)request.getAttribute("REQUEST_SKIN_FOLDER");
//lskin="default";
	MenuMaint mm = new MenuMaint("left", 3, user.getUID(), user
			.getLanguage());

	List homeMenus = new ArrayList();

	//��˵�
	homeMenus = getPortalMenus(user);

	List topMenus = mm.getAllMenus(user, 0);

	out.write("<script type=\"text/javascript\">");
	out.write("var menuMap = new Map();");

	out.write("menuMap.put('-9999', \""
			//+ grtlftMenu(homeMenus, user, true)
			+ grtlftMenu(homeMenus, user)
					.replaceAll("\"", "####") + "\");");

	for (int i = 0; i < topMenus.size(); i++) {
		Map mky = (Map) topMenus.get(i);

		String levelId = (String) mky.get("levelid");
		List childMenus = (List) mky.get("child");
		String strmhtms = "";

		if (mky.get("extra") == null) {

			int level = Integer.parseInt(levelId);
			String linkName = "";
			String linkAddr = "";
			/*
			switch (level) {
			//����
			case 1:
				linkName = SystemEnv.getHtmlLabelName(26264,user.getLanguage());
				linkAddr = "/homepage/Homepage.jsp?hpid=62&subCompanyId=64&isfromportal=0";
				break;
			//�ҵ�֪ʶ
			case 2:
				linkName = SystemEnv.getHtmlLabelName(2115,user.getLanguage());
				linkAddr = "/homepage/Homepage.jsp?hpid=61&subCompanyId=64&isfromportal=0";
				break;
			//�ҵĿͻ�
			case 3:
				linkName = SystemEnv.getHtmlLabelName(2113,user.getLanguage());
				linkAddr = "/homepage/Homepage.jsp?hpid=65&subCompanyId=64&isfromportal=0";
				break;
			//�ҵ���Ŀ
			case 4:
				linkName = SystemEnv.getHtmlLabelName(2114,user.getLanguage());
				linkAddr = "/homepage/Homepage.jsp?hpid=64&subCompanyId=64&isfromportal=0";
				break;
			//����
			case 5:
				linkName = SystemEnv.getHtmlLabelName(15882,user.getLanguage());
				linkAddr = "/homepage/Homepage.jsp?hpid=63&subCompanyId=64&isfromportal=0";
				break;
			}
			*/
			strmhtms = grtlftMenu(childMenus, user);
			if (!"".equals(linkName) && !"".equals(linkAddr)) {
				String tmpLi = "<li>";
				tmpLi += "<a class='lfMenuItem' href='";
				tmpLi += linkAddr;
				tmpLi += "' _bgPosition='0 -28'";
				tmpLi += " target=\"mainFrame\" >";
				tmpLi += "<div class=\"leftMenuItemLeft\" style=\"background-position:0 -28;\"></div>";
				tmpLi += "<div class=\"leftMenuItemCenter\"; style=\"\">";
				tmpLi += linkName;
				tmpLi += "</div>";
				tmpLi += "<div class=\"leftMenuItemRight\" style=\"\"></div>";
				
				tmpLi += "<div style='width:4px;'></div></a>";
				tmpLi += "</li>";

				strmhtms = strmhtms.substring(0, 4) + tmpLi
						+ strmhtms.substring(4);
			}
		}

		out.write("menuMap.put('" + levelId + "', \""
				+ strmhtms.replaceAll("\"", "####") + "\");");
	}

	out.write("</script>");
%>

<%!public String grtlftMenu(List elements, User user, boolean isPotal) {
		String rsult = grtlftMenu(elements, user);
		String tmpLi = "<li>";
		tmpLi += "<a class='lfMenuItem' href='";
		tmpLi += "/homepage/Homepage.jsp?hpid=66&subCompanyId=64&isfromportal=1&isfromhp=0";
		//tmpLi += "' style=\"background:url('/wui/theme/ecology7/page/images/leftmenu/menuitem-blue.png') no-repeat;\" ";
		tmpLi += "' _bgPosition='0 -28' ";
		tmpLi += " target=\"mainFrame\" >";
		tmpLi += "<div class=\"leftMenuItemLeft\" style=\"background-position:0 -28;\"></div>";
		tmpLi += "<div class=\"leftMenuItemCenter\"; style=\"\">";
		tmpLi += SystemEnv.getHtmlLabelName(26265, user.getLanguage());
		tmpLi += "</div>";
		tmpLi += "<div class=\"leftMenuItemRight\" style=\"\"></div>";
		tmpLi += "<div style='width:4px;'></div></a>";
		tmpLi += "</li>";
		rsult = rsult.substring(0, 4) + tmpLi + rsult.substring(4);
		return rsult;
	}

	public String grtlftMenu(List elements, User user) {

		if (elements == null) {
			return "<ul></ul>";
		}

		//���˵�HTML
		StringBuffer sfcm = new StringBuffer();
		//---------------------------
		// �˵����ͼƬ�����ʾ
		// bgcnt   : ���˵�����ͼƬ����
		// bgindex : ���˵�����ͼƬ������±�
		// abgs    : ���˵�����ͼƬ����
		//---------------------------
		int bgcnt = 4;
		int bgindex = 4;

		String[] sbgPostions = new String[] { "0 -28", "0 -84", "0 0", "0 -56" };

		sfcm.append("<ul>");
		for (int licnter = 0; licnter < elements.size(); licnter++) {
			Map map = (Map) elements.get(licnter);

			bgindex++;

			sfcm.append(getChildMenu(map, sbgPostions[bgindex % 4]));

			String extra = Util.null2String((String) map.get("extra"));

			if (extra != null && !"".equals(extra)) {

			} else {
				List chilList = (List) map.get("child");

				if (chilList != null && !chilList.isEmpty()) {
					String shtm = grtlftMenu(chilList, user);
					sfcm.append(shtm);
				}
			}

			sfcm.append("</li>");
		}
		sfcm.append("</ul>");

		return sfcm.toString();

	}

	public String getChildMenu(Object obj, String sbgPosition) {
		StringBuffer sfcm = new StringBuffer();
		
		if (!(obj instanceof Map)) {
			return sfcm.toString();	
		}
		
		Map map = (Map) obj;

		sfcm.append("<li>");
		sfcm.append("<a class='lfMenuItem' href='");
		if (map.get("url") == null || map.get("url").toString().equals("")
				|| map.get("url").toString().equals("#")) {
			sfcm.append("javascript:void(0);");
		} else {
			sfcm.append(((String) map.get("url")).replaceAll("&#38;", "&"));
		}
        String menuname=map.get("name").toString();
        
		//sfcm.append("' style='background:url(").append(abg).append(") no-repeat;' ");
		sfcm.append("' _bgPosition='" + sbgPosition + "'");
		sfcm.append(" target='" + map.get("target") + "' title='" + menuname + "'>");
		sfcm.append("<div class='leftMenuItemLeft' style='background-position:" + sbgPosition + ";'></div>");
		sfcm.append("<div class='leftMenuItemCenter' style=''>");
		sfcm.append(menuname);
		sfcm.append("</div>");
		sfcm.append("<div class='leftMenuItemRight' style=''></div><div style='width:4px;'></div></a>");


		return sfcm.toString();
	}

	public List getPortalMenus(User user) throws Exception {
		List result = new ArrayList();

		RecordSet rs = new RecordSet();

		String sql = "select id,infoname,subcompanyid from hpinfo h where showtype=1 and isuse=1 and id in (select distinct hpid  from  shareinnerhp where (type=1 and content="
				+ user.getUID()
				+ " ) or (type=2 and content="
				+ user.getUserSubCompany1()
				+ " ) or (type=3 and content="
				+ user.getUserDepartment()
				+ " ) or (type=5 and   content=1 )) order by cast(ordernum as float),id";
		if (user.getUID() == 1) {
			sql = "select id,infoname,subcompanyid from hpinfo h where showtype=1 and isuse=1 order by cast(ordernum as float),id";
		}

		rs.executeSql(sql);
		while (rs.next()) {
			Map map = new HashMap();
			String tempHpid = Util.null2String(rs.getString("id"));
			String tempHpName = Util.null2String(rs.getString("infoname"));
			String tempHpSubcompanyid = Util.null2String(rs
					.getString("subcompanyid"));

			map
					.put("url", "/homepage/Homepage.jsp?hpid=" + tempHpid
							+ "&subCompanyId=" + tempHpSubcompanyid
							+ "&isfromportal=1&isfromhp=0");
			map.put("target", "mainFrame");
			map.put("levelid", tempHpid);
			map.put("icon", "");
			map.put("name", tempHpName);
			map.put("child", getPortalSubMenu(tempHpid, user));
			result.add(map);
		}

		return result;
	}

	public List getPortalSubMenu(String parenthpid, User user) {
		List result = new ArrayList();

		String subMenu = "";
		String sql = "select id,infoname,subcompanyid from hpinfo h where showtype=2 and parenthpid="
				+ parenthpid
				+ " "
				+ "and isuse=1 and id in (select distinct hpid  from  shareinnerhp where (type=1 and content="
				+ user.getUID()
				+ " ) "
				+ "or (type=2 and content="
				+ user.getUserSubCompany1()
				+ " ) or (type=3 and content="
				+ user.getUserDepartment()
				+ " ) or (type=5 and   content=1 )) order by ordernum,id";
		if (user.getUID() == 1) {
			sql = "select id,infoname,subcompanyid from hpinfo h where showtype=2 and parenthpid="
					+ parenthpid + " and isuse=1 order by ordernum,id";
		}

		RecordSet rs = new RecordSet();
		rs.executeSql(sql);

		while (rs.next()) {
			Map map = new HashMap();
			String tempHpid = Util.null2String(rs.getString("id"));
			String tempHpName = Util.null2String(rs.getString("infoname"));
			String tempHpSubcompanyid = Util.null2String(rs
					.getString("subcompanyid"));
			map
					.put("url", "/homepage/Homepage.jsp?hpid=" + tempHpid
							+ "&subCompanyId=" + tempHpSubcompanyid
							+ "&isfromportal=1&isfromhp=0");
			map.put("target", "mainFrame");
			map.put("levelid", tempHpid);
			map.put("icon", "");
			map.put("name", tempHpName);
			result.add(map);
		}
		return result;
	}%>






<script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
<script type="text/javascript" src="/wui/theme/ecology7/jquery/plugin/drilldownmenu.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.scrollTo.js"></script>


<STYLE TYPE="text/css">
.drillmenu { /* main DIV container of menu */
	/*border: 2px solid black;*/
	margin-left: 1px;
	width: 175px; /*width of menu*/
	height:0px; /*Height of DIV for those with JavaScript disabled*/
	overflow-y: hidden;
	/*Scrollable DIV for those with JavaScript disabled*/
}

.drillmenu ul { /*menu ULs*/
	font: normal 12px;
	margin: 0;
	padding: 0;
	list-style-type: none;
	/*background: lightyellow; background of menu*/
}

.drillmenu li {
}

.drillmenu li .lfMenuItem { /*menu links*/
	position: relative;
	display: block;
	text-decoration: none;
	color: #006269!important;
	margin-bottom: 1px;
	font-size: 11px;
	height: 27px;
	line-height:28px;
	cursor:pointer;
	font-family: "΢���ź�", "verdana";
	z-index: 1;
	text-overflow:ellipsis;
	white-space:nowrap;
	overflow:hidden;
	width:100%;
}

#drillcrumb li a {
	text-decoration: none;
	color: #333!important;
}

* html .drillmenu li { /*IE6 CSS hack*/
	display: inline-block;
	height: 27px;
}

li.backcontroltitle { /*style of top level menu title*/
	background: black;
	color: white;
	padding: 4px;
}

li.backcontrol {
	/*style of back button control that gets added to the top of each sub UL*/
	background: #011054;
	color: white;
	padding: 4px;
	cursor: pointer;
}
.leftMenuTopNavDiv {
	min-height: 30px;
	*height: 30px;
	margin-bottom:10px;
	margin-top:10px;
}
#drillcrumb {
	/*custom, user defined DIV that contains breadcrumb trail*/
	font-size: 12px;
	color: #fff;
	width: 170px;
	min-height: 30px;
	*height: 30px;
	font-family: '΢���ź�', 'verdana';
	padding-left: 10px;
	padding-top:4px;
}

#drillcrumb a{
	color:#fff!important;
}

.navclass {
	width: 180px;
	margin-bottom: 5px;
	margin-top: 10px;
	height: 27px;
}

#divFloatLeftmenu {
	font-size: 12px;
	padding: 0px 0px 4px 35px;
	cursor: pointer;
}

.leftMenuItemLeft {
float:left;
	height: 27px;
	width: 11px;
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuItemLeft.png) no-repeat;
}

.leftMenuItemCenter {
	float:left;
	height: 27px;
	line-height:27px;
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuItemCenter.png) repeat-x;
	text-indent:18px;
	text-overflow:ellipsis;white-space:nowrap;overflow:hidden;
}

.leftMenuItemRight {
	float:left;
	width: 5px;
	height: 27px;
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuItemRight.png) 0 0 no-repeat;

}

.leftMenuItemNavLeft {
	position: absolute;
	left: 0;
	top: 0;
	height: 27px;
	width: 11px;
	background:url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuItemNavLeft.png) no-repeat;
	background-position:0 -28;
	z-index:-1;
}

.leftMenuItemNavCenter {
	position: absolute;
	left: 11px;
	top: 0;
	height: 27px;
	line-height:27px;
	text-indent:18px;
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuItemNavCenter.png) repeat-x;
	background-position:0 -28;
	z-index:-1;
	text-overflow:ellipsis;white-space:nowrap;overflow:hidden;
}

.leftMenuItemNavRight {
	position: absolute;
	left: 0;
	top: 0;
	height: 27px;
	width: 10px;
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuNavRight.png) no-repeat;
	background-position:0 -28;
	z-index:-1;
}

.leftMenuItemNavCenter a {
	display:inline-block;
	text-overflow:ellipsis;
	white-space:nowrap;
	overflow:hidden;
	width:100%;
	color:#fff;
}

#LeftmenuPrev img,#LeftmenuNext img {
	border: 0 none;
}
.drillcrumbUrlLeft {
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuUrlLeft.png) no-repeat;
}
.drillcrumbUrlCenter {
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuUrlCenter.png) repeat-x;
}
.drillcrumbUrlRight {
	background: url(/wui/theme/ecology7/skins/<%=lskin%>/page/left/leftMenuUrlRight.png) no-repeat;
}
</STYLE>

<div class="leftMenuTopNavDiv">
	<div id="drillcrumb">
	</div>
</div>
<div id="leftMenu" style="height:27px;overflow: hidden;z-index:20px;position:relative;">
	<div style="width:186px;height:27px;position:absolute;z-index:1000;font-size:11px;font-family:'΢���ź�', 'verdana';filter: alpha(opacity=0);" id="divFloatLeftmenu">
		<div class="leftMenuItemNavLeft"></div>
		<div class="leftMenuItemNavCenter"></div>
		<div class="leftMenuItemNavRight"></div>
	</div>
	<div id="drillmenu" class="drillmenu">
		<%=grtlftMenu(homeMenus, user)%>
	</div>
</div>


<div class="navclass leftMenuBottomNavDiv">
	<table align="center" height="27px" cellpadding="0px" cellspacing="0px" width="100%" class="leftMenuBottomNavTbl">
		<tr>
			<td align="center" id="navTd">
			<td>
		</tr>
	</table>
</div>


<script type="text/javascript">

/**
 * ���˵������ʾ�˵�����Ŀ
 */
var leftMenuMaxItem = 7;
/**
 * �˵������ٶ�
 */
var leftMenuScrollSpeed = 200;

/**
 * �˵�ÿҳ��ʾ�ĸ߶�
 */
var leftMenuScrollHeight = leftMenuMaxItem * 28;
//---------------------------------------------------------------
//���˵������ʾ�˵��߶�,��ϵͳ�Զ����
var LEFT_MENU_MAX_HEIGHT = leftMenuMaxItem * 28;
//���˵���ʾ�Ĳ˵���ڶ�
var LEFT_MENU_ITEM_HEIGHT = 28;
//�˵����
var leftMenuItemWidth = 175;
//---------------------------------------------------------------

function setLeftMenuItemFontLt() {
	jQuery(".drillmenu li a").css("padding", "5px 5px 4px 20px");
	jQuery("#divFloatLeftmenuContext").css("padding", "5px 5px 4px 20px");
	
}

function setLeftMenuHeight(size) {
	jQuery(".drillmenu").css("width", size + "px");//    175

	if ("<%=(String)session.getAttribute("browser_isie") %>" != "true") {
		jQuery("#drillcrumb").css("width", size - 9 + "px"); // 170
	} else {
		jQuery("#drillcrumb").css("width", size + 3 + "px"); // 170
	}	
	
	jQuery(".leftMenuTopNavDiv").css("width", size + 3 + "px"); // 170
	jQuery(".navclass").css("width",  size + 3 + "px");   //180
	jQuery("#drillcrumbTbl").css("width", size + 16 + "px"); //191
	jQuery("#divFloatLeftmenu").css("width", size + 16  + "px");  //186
	jQuery("#divFloatLeftmenuContext").css("width", size + 3  + "px");  //186
	
	if (size < 150) {
		setLeftMenuItemFontLt();
	}
}

//-------------------------------------
// 20110526 ����Ӧ��� start
//-------------------------------------
function setLeftMenuItemANavHeight(size) {
	jQuery(".leftMenuItemRight").css("left", size -  5 + "px");
	jQuery(".leftMenuItemCenter").css("width", size - 16 + "px");
	
	jQuery(".leftMenuItemNavRight").css("left", size + 1 + "px");
	jQuery(".leftMenuItemNavCenter").css("width", size - 10 + "px");
}

function leftMenuInit() {
	
	var clientScreenHeight = 512;//window.screen.height;
	var clientScreenWidth = 1280;//window.screen.width;
	if (clientScreenWidth < 1280) {
		clientScreenWidth = 1280;
	}
    var tpLeftMenuMaxHeight = Math.round(clientScreenHeight / 2.8);
    var tpLeftMenuMaxWidth = Math.round(clientScreenWidth / 8); //8
    
    
    leftMenuMaxItem = Math.round(tpLeftMenuMaxHeight/28);
    //alert(tpLeftMenuMaxWidth);
    leftMenuItemWidth = tpLeftMenuMaxWidth;
	
	setLeftMenuHeight(leftMenuItemWidth);
	setLeftMenuItemANavHeight(leftMenuItemWidth);
	
    
    leftMenuScrollSpeed = 200;
    leftMenuScrollHeight = leftMenuMaxItem * 28;
    LEFT_MENU_MAX_HEIGHT = leftMenuMaxItem * 28;
}

leftMenuInit();

var shiftKeyFlag = false;
jQuery(document).ready(function(event) {
	jQuery("#divFloatLeftmenu").css("filter", "");
	jQuery("#divFloatLeftmenu").hide();
 	//�������˵��߶�
    jQuery("#leftMenu").height(LEFT_MENU_MAX_HEIGHT);
    //���˵�����
    var myLftMenu = new drilldownmenu(
        {menuid: 'drillmenu',menuheight: 'auto',breadcrumbid: 'drillcrumb',persist: {enable: false, overrideselectedul: false},speed:0,homeDir:'<%=SystemEnv.getHtmlLabelName(582,user.getLanguage())%>'}
    );
	 jQuery(".arrowclass").css("position","").css("position","absolute"); 
    //--------------------------------------------------------
    // ���¼�
    //--------------------------------------------------------
    jQuery(".drillmenu ul li a").bind("click", function() {
        currMObj = this;
        //�ƶ�����������ǰ��ѡ�˵�
        navMoveIfrmClk(this)
        if(!selFlg) {
            selFlg = true;
            jQuery("#leftMenu").scrollTo( {top:'0px',left:+'0px'}, 0 );
        } else {
            jQuery("#divFloatLeftmenu").show();
        }
        lMOpenUrl(jQuery(this));
        if(!isJSOpen(jQuery(this)))
           return false;
    });
    //-------------------------------------------------------
    lMNavBindClick();
    syncLMHeight();
    //��ǰ�������ڲ˵����Ӳ˵�ʱ�����������������˵�����click�¼�
    jQuery("#divFloatLeftmenu").bind("click", function(event) {
        if (currMObj != null && currMObj != undefined) {
            if (jQuery(currMObj).children('ul')) {
            	if (event.shiftKey) {
            		shiftKeyFlag = true;
           		}
                //jQuery(currMObj).click();
                currMObj.click();
            }
            
        } else {
            var first = jQuery("#drillmenu ul li a").get(0);
            if (first != null && first != undefined) {
           		if (event.shiftKey) {
            		shiftKeyFlag = true;
           		}
                jQuery(first).click();
            }
        }
    });
    if(jQuery("#mainFrame").attr("src")==""){
    	lMnavToFirstNav();
    }
    //
});

//---------------------------------------------------------------
// ���±���Ϊ�˵����������
// currSubMParent      :  ��ǰ�Ӳ˵��������˵�
// selFlg              :  Ŀǰ��λ�ã��Ƿ��ڸ��˵��Ƿ��ڸ�������
// parentMCntLinked    :  ����㼶�˵��Ӳ˵��ĸ��������ڼ���˵��߶�.
// parentMObjLinked    :  ����㼶�˵�,ȷ�����url����ʱ,����ȷ�Ķ���
// parentMLinkedIndex  :  ����㼶�˵���ǰλ��
// currMObj            :  ��ǰ����˵���
var currSubMParent;
var selFlg = true;
var parentMCntLinked = new Array();
var parentMObjLinked = new Array();
var parentMLinkedIndex = 0;
var currMObj = null;
// END
//---------------------------------------------------------------

//---------------------------------------------------------------
// �˵�����ʱ������������Ĳ˵�
//---------------------------------------------------------------
var recentlyClickTopMenuObj = null;
var lyClickTopmenuStatictics = 0;
/**
 * ��̬�ı����˵���
 * ��������˵�ʱ�����ô˺���
 * @param ele ��ǰ�����һ��(����)�˵�
 */
function dymlftenu(ele, isOpenFirstMenu) {
	recentlyClickTopMenuObj = ele;
	lyClickTopmenuStatictics++;
    var paramValue = "";
    var levelid = jQuery(ele).attr("levelid");
    
    if(levelid != undefined && levelid != null && levelid != "") {
        paramValue = levelid;
    } else {
        paramValue = "-9999";
    }
    
    var reg=new RegExp("####","g"); 
    if (menuMap.get(paramValue) != undefined && menuMap.get(paramValue) != null && menuMap.get(paramValue) != "" && paramValue != "111") {
        //��չ���������
        jQuery("#navTd").html("");
        currMObj = null;
        var leftMenuHtml = menuMap.get(paramValue).replace(reg, "\"");
        jQuery(leftMenuHtml).hide();
        jQuery("#drillmenu").html(leftMenuHtml);
        //-------------------------------------
        // 20110526 ����Ӧ��� start
        //-------------------------------------
        jQuery(".leftMenuItemRight").css("left", leftMenuItemWidth -  5); 
		jQuery(".leftMenuItemCenter").css("width", leftMenuItemWidth - 11 - 5);
		if (leftMenuItemWidth < 150) {
			setLeftMenuItemFontLt();
		}
        //-------------------------------------
        // 20110526 ����Ӧ��� end
        //-------------------------------------
        
        jQuery("#leftMenu").scrollTo( {top:'0px',left:+'0px'}, 0 );
        
        //��һ���˵���
        var lfirst = jQuery("#drillmenu ul li a").get(0);
        var isPortal = false;
        if (paramValue == "-9999") {
            isPortal = true;
        }
        //���°󶨲˵���onclick�¼�
        lMNavEventRebind(jQuery(ele).children(".slideItemText").html(), isPortal);
        //ͬ���˵��߶�
        syncLMHeight();
        //���˵�onclick�¼�
        lMNavBindClick();
        jQuery(leftMenuHtml).show();
        //ѡ�е�һ���˵���
        lMnavToFirstNav(isOpenFirstMenu);
        
        
    } else if (paramValue == "110" || paramValue == "114" || paramValue == "111") {
        //��չ���������
        jQuery("#navTd").html("");
        currMObj = null;
        //���ص���
        jQuery("#divFloatLeftmenu").hide();
        //loadding...
        jQuery("#drillmenu").html("<span style=\"align:center;padding-top:50px;padding-left:50px;\"><img src=\"/wui/theme/ecology7/page/images/leftmenu/loader.gif\"></span>");
        
        jQuery("#drillcrumb").html(paramValue == "114" ? "<%=SystemEnv.getHtmlLabelName(68,user.getLanguage())%>" : (paramValue == "110" ? "<%=SystemEnv.getHtmlLabelName(15101,user.getLanguage())%>" : "<%=SystemEnv.getHtmlLabelName(87,user.getLanguage())%>"));
        jQuery.ajax({
            url: "/wui/theme/ecology7/page/ajaxGetMenu.jsp?typeid=" + paramValue + "&parentid=" + (paramValue == "114" ? "" : "10") + "&lftmn" + new Date().getTime() + "=",
            dataType: "text", 
            contentType : "charset=gbk", 
            error:function(ajaxrequest){alert("error");}, 
            success:function(content){
                jQuery(content).hide();
                jQuery("#drillmenu").html(content);
                
                //-------------------------------------
		        // 20110526 ����Ӧ��� start
		        //-------------------------------------
		        jQuery(".leftMenuItemRight").css("left", leftMenuItemWidth -  5); 
				jQuery(".leftMenuItemCenter").css("width", leftMenuItemWidth - 11 - 5);
				if (leftMenuItemWidth < 150) {
					setLeftMenuItemFontLt();
				}
		        //-------------------------------------
		        // 20110526 ����Ӧ��� end
		        //-------------------------------------
				if (paramValue != "111") {
                	menuMap.put(paramValue, content);
                }
                jQuery("#leftMenu").scrollTo( {top:'0px',left:+'0px'}, 0 );
                //���°󶨲˵���onclick�¼�
                lMNavEventRebind(jQuery(ele).children(".slideItemText").html());
                //ͬ���˵��߶�
                syncLMHeight();
                lMNavBindClick();
                jQuery(content).show();
                //ѡ�е�һ���˵���
                lMnavToFirstNav(isOpenFirstMenu);
            }  
        });
    }
} 

/**
 * �����Ӳ˵����߻ص����˵�ʱ�Ĵ���
 * @param dz �ص����˵�ʱ:show
 *           �����Ӳ˵�ʱ:hide
 * @param parent �����Ӳ˵�ǰ��ѡ�еĲ˵���
 * @param liparent ��ǰ����Ĳ˵���
 * @return null
 */ 
function callback(dz, parent, liparent) {
    //��չ���������
    jQuery("#navTd").html("");
    //�����Ӳ˵�
    if (dz == "hide") {
         jQuery(".arrowclass").css("position","").css("position","absolute"); 
        var lfurlHtml = jQuery("#drillcrumb").html();
        if (lfurlHtml != null && lfurlHtml != undefined && lfurlHtml != "") {
            if (jQuery(liparent).children('a') != undefined 
                && jQuery(liparent).children('a').attr("href") != undefined
                && jQuery(liparent).children('a').attr("href") != ""
                && jQuery(liparent).children('a').attr("href") != "#"
                && jQuery(liparent).children('a').attr("href") != "javascript:void(0)"
                && jQuery(liparent).children('a').attr("href") != "javascript:void(0);") {
                    var lfurlnhtml = lfurlHtml.substring(0, lfurlHtml.lastIndexOf(">") + 1)  
                                        +  "<a href='" + jQuery(liparent).children('a').attr("href") + "'  onclick=\"javascript:window.open(this.href,'mainFrame');return false;\">" 
                                        + lfurlHtml.substr(lfurlHtml.lastIndexOf(">") + 1) 
                                        + "</a>";
                    jQuery("#drillcrumb").html(lfurlnhtml);
                }
        }

        //���ص���
        jQuery("#divFloatLeftmenu").hide();
        
        //����λ��״̬
        selFlg = false;
        //���浱ǰ�˵����Ӳ˵�����
        parentMCntLinked[parentMLinkedIndex] = jQuery(liparent).parent().children("li").length;
        //���浱ǰ�˵����γɲ˵���
        parentMObjLinked[parentMLinkedIndex] = parent;
        //���ֵ�ǰѡ�и��˵�
        currSubMParent = parent;
        
        parentMLinkedIndex++;
        var currChildCnt = jQuery(liparent).children("ul").children("li").length;
        //ʹ���������ڶ���λ��
        jQuery("#leftMenu").scrollTo( {top:'0px',left:+'0px'}, 0 );
        if (currChildCnt  <= leftMenuMaxItem) {
            jQuery("#drillmenu").height(currChildCnt * LEFT_MENU_ITEM_HEIGHT);
            jQuery("#leftMenu").height(currChildCnt * LEFT_MENU_ITEM_HEIGHT);
            //jQuery("#leftMenu").parent().height(currChildCnt * LEFT_MENU_ITEM_HEIGHT);
            setMainElementHeight(currChildCnt * LEFT_MENU_ITEM_HEIGHT);
            //jQuery(".navclass").hide();
        } else {
            jQuery("#drillmenu").height(currChildCnt * LEFT_MENU_ITEM_HEIGHT);
            jQuery("#leftMenu").height(LEFT_MENU_MAX_HEIGHT);
          //  jQuery("#leftMenu").parent().height(LEFT_MENU_MAX_HEIGHT);
            setMainElementHeight(LEFT_MENU_MAX_HEIGHT);
            //jQuery(".navclass").show();
        }  
        lMNavBindClick();
    //�ص����˵�
    } else {
        //��ǰ�㼶�����㼶�Ĳ
        var lessUrl = 1;
        //����״̬
        selFlg = true;
        //��õ�ǰ�����url�˵��Ĳ㼶
        var urlCnt = jQuery("#drillcrumb").children("a").length;
        //ȡ�øò㼶���Ӳ˵��ĸ���
        var plicnt = parentMCntLinked[urlCnt];
        //ȡ�øò㼶����
        currSubMParent = parentMObjLinked[urlCnt];
        
        lessUrl = parentMLinkedIndex - urlCnt;
        //���µ�ǰ�˵��㼶index
        parentMLinkedIndex = urlCnt;
        //���µ�ǰ�������ڲ˵�object
        currMObj = currSubMParent;
        

        if (plicnt <= leftMenuMaxItem) {
            jQuery("#drillmenu").height(plicnt * LEFT_MENU_ITEM_HEIGHT);
            jQuery("#leftMenu").height(plicnt * LEFT_MENU_ITEM_HEIGHT);
            //jQuery("#leftMenu").parent().height(plicnt * LEFT_MENU_ITEM_HEIGHT);
            //jQuery(".navclass").hide();
            setMainElementHeight(plicnt * LEFT_MENU_ITEM_HEIGHT);
            jQuery("#lprev").hide();
            jQuery("#rprev").hide();
        } else {
            jQuery("#drillmenu").height(plicnt * LEFT_MENU_ITEM_HEIGHT);
            jQuery("#leftMenu").height(LEFT_MENU_MAX_HEIGHT);
            //jQuery("#leftMenu").parent().height(LEFT_MENU_MAX_HEIGHT);
            //jQuery(".navclass").show();
            setMainElementHeight(LEFT_MENU_MAX_HEIGHT);
            jQuery("#lprev").hide();
            jQuery("#rprev").hide();
        }  
        
        
        //�����ص��ϴε���ĸ��˵���
        jQuery("#divFloatLeftmenu").each(function(){
        jQuery.dequeue(this, "fx");}).animate({
            top : jQuery(currSubMParent).offset().top - jQuery("#leftMenu").offset().top + jQuery("#leftMenu").scrollTop(),
            left: 0
        },0, 'backout');
        //ȡ�ñ���ͼƬposition
        var abg = jQuery(jQuery(currSubMParent)[0]).attr("_bgPosition");
        //ȡ�ò˵���Ķ༶��־����ͷͼƬ��
        var htmImg = jQuery(jQuery(currSubMParent)[0]).html().substring(0, jQuery(jQuery(currSubMParent)[0]).html().toUpperCase().indexOf("<DIV"));
        //ȡ�ò˵����text
		var htmText = jQuery(jQuery(currSubMParent)[0]).find(".leftMenuItemCenter").text();
		//ȡ�ò˵�����������ʾ��div
		var htmDivContext = jQuery("#divFloatLeftmenu").html().substring(0, jQuery("#divFloatLeftmenu").html().toUpperCase().lastIndexOf("</DIV>") + 6);
		//���ݲ˵���ı���ͼƬ��ɫ�����õ�������ɫ
		jQuery(".leftMenuItemNavLeft").css("background-position", abg);
		jQuery(".leftMenuItemNavRight").css("background-position", abg);
		jQuery(".leftMenuItemNavCenter").css("background-position", abg).html("<span title='" + htmText + "' >" + htmText + "</span>");
		jQuery("#divFloatLeftmenu .arrowclass").remove();
		jQuery(htmImg).insertBefore(".leftMenuItemNavCenter");
		//jQuery("#divFloatLeftmenuContext").html(htmImg + htmText);

        //��ʾ����
        jQuery("#divFloatLeftmenu").show();
        
        //ʹѡ�еĲ˵���ڿ���λ��
        var navNumber = 0;
        var currScrollTop = jQuery(currSubMParent).offset().top - jQuery("#leftMenu").offset().top;
        var flag = (currScrollTop/leftMenuScrollHeight + "").indexOf("."); 
        if (flag != -1 ) {
            navNumber = currScrollTop/leftMenuScrollHeight < 1 ? 0 : (parseInt(currScrollTop/leftMenuScrollHeight));
        } else {
            navNumber = currScrollTop/leftMenuScrollHeight < 1 ? 0 : currScrollTop/leftMenuScrollHeight;
        }
        
        jQuery("#leftMenu").scrollTo( {top: navNumber * leftMenuScrollHeight + 'px',left:+'0px'}, leftMenuScrollSpeed );
        
        if(jQuery(currSubMParent).offset().top - jQuery("#leftMenu").offset().top + jQuery("#leftMenu").height() < jQuery("#drillmenu")[0].scrollHeight) {
            jQuery("#rprev").show();
        } 
        if (jQuery(currSubMParent).offset().top - jQuery("#leftMenu").offset().top > 0) {
            jQuery("#lprev").show();
        }
        lMNavBindClick();
        
        jQuery("#navTd").children('span').css("background", "url(/wui/theme/ecology7/page/images/leftmenu/lm_nav.png) no-repeat");
		jQuery("#navTd").children('span').css("background-position", "center center");
        jQuery("#navTd").children('span').each(function() {
            var navIndex = jQuery(this).attr("navIndex");
            if (navIndex == navNumber) {
                currentNav = navIndex;
                jQuery(this).css("background", "url(/wui/theme/ecology7/page/images/leftmenu/" + (parseInt(navNumber) + 1) + ".png) no-repeat center center");
            }
        });
        
    }
    
}

function dymLMNav() {
    var navCnt = 0;
    var flag = (jQuery("#leftMenu")[0].scrollHeight/leftMenuScrollHeight + "").indexOf("."); 
    if (flag != -1 ) {
        navCnt = parseInt(jQuery("#leftMenu")[0].scrollHeight/leftMenuScrollHeight);
    } else {
        navCnt = parseInt(jQuery("#leftMenu")[0].scrollHeight/leftMenuScrollHeight) - 1;
    }
    
    var navSpan = "";
    if (navCnt > 0) {
        navSpan = "<span navIndex=\"0\" style=\"display:inline-block;margin-left:3px;margin-right:3px;margin-top:1px;height:25px;width:25px;cursor:pointer;background:url(/wui/theme/ecology7/page/images/leftmenu/1.png);background-repeat: no-repeat;background-position: center center;\">&nbsp;</span>";
    }
    
    for (var i=1; i<=navCnt; i++) {
        navSpan += "<span navIndex=\"" + i + "\" style=\"display:inline-block;margin-left:3px;margin-right:3px;margin-top:1px;height:25px;width:25px;cursor:pointer;background:url(/wui/theme/ecology7/page/images/leftmenu/lm_nav.png);background-repeat: no-repeat;background-position: center center;\">&nbsp;</span>";                
    }
    
    jQuery("#navTd").html(navSpan)
}


var currentNav = 0;
function lMNavBindClick() {
    dymLMNav();
    jQuery("#navTd span").bind("click", function() {lMNavClick(jQuery(this));});
    
    jQuery("#navTd span").hover(function(){
        $this = jQuery(this);
        var navIndex = $this.attr("navIndex");
        if (currentNav != navIndex) {
            $this.css("background", "url(/wui/theme/ecology7/page/images/leftmenu/" + (parseInt(navIndex) + 1) + ".png) no-repeat ");
			$this.css("background-position","center center")
        }
        
    }, function() {
        $this = jQuery(this);
        var navIndex = $this.attr("navIndex");
        if (currentNav != navIndex) {
            $this.css("background", "url(/wui/theme/ecology7/page/images/leftmenu/lm_nav.png) no-repeat");
			$this.css("background-position","center center")
        }
        
    });
}

function lMNavClick($this) {
    var navIndex = $this.attr("navIndex");
    currentNav = navIndex;
    $this.parent().children('span').css("background", "url(/wui/theme/ecology7/page/images/leftmenu/lm_nav.png) no-repeat");
	$this.parent().children('span').css("background-position","center center")
    
    $this.css("background", "url(/wui/theme/ecology7/page/images/leftmenu/" + (parseInt(navIndex) + 1) + ".png) no-repeat");
    $this.css("background-position","center center")
    jQuery("#leftMenu").scrollTo( {top: navIndex * leftMenuScrollHeight + 'px',left:+'0px'}, leftMenuScrollSpeed );
}

function lMnavToFirstNav(isOpenFirstMenu) {
    var first = jQuery("#drillmenu ul li a").get(0);
    var openFlag = jQuery(jQuery("#drillmenu ul li")[0]).children(".drillmenu").length;
    //alert(openFlag);
    var hphf = jQuery(first).attr("href");
    if((hphf != undefined && hphf != null && hphf != "" && hphf.indexOf("Homepage.jsp") != -1) || openFlag == 0 ) {
       if (first != undefined && first != null && first != "") {
            navMoveFstIfrmClk(first);
            jQuery("#divFloatLeftmenu").show();
            //jQuery("#divFloatLeftmenu").hide();
            if (isOpenFirstMenu != false) {
            	jQuery("#mainFrame").attr("src", jQuery(first).attr("href"));
            }
        } else {
            jQuery("#divFloatLeftmenu").hide();
        }
    } else {
        //���ص���
        jQuery("#divFloatLeftmenu").hide();
    }
}

function lMNavEventRebind(fnavUrlName, isPortal) {
    //ȡ���¼���
    jQuery(".drillmenu ul li a").unbind("click");
    //���°��¼�
    jQuery(".drillmenu ul li a").bind("click", function() {
        currMObj = this;
        
        if ((jQuery(this) != undefined 
                && jQuery(this).attr("href") != undefined
                && jQuery(this).attr("href") != ""
                && jQuery(this).attr("href") != "#"
                && jQuery(this).attr("href") != "javascript:void(0)"
                && jQuery(this).attr("href") != "javascript:void(0);")
                || isPortal == true) {
			lMOpenUrl(jQuery(this));
			navMoveIfrmClk(this);
        	jQuery("#divFloatLeftmenu").show();
			if(!isJSOpen(jQuery(this)))
               return false;
        }
    });
    
    jQuery("#drillmenu").unbind();
    jQuery("#drillcrumb").unbind();

	try{
		if(fnavUrlName == undefined || fnavUrlName == null || fnavUrlName== ""){
			fnavUrlName="<%=SystemEnv.getHtmlLabelName(582,user.getLanguage())%>";
		}
	}catch(e){
	}
		
    var myLftMenu = new drilldownmenu({
        menuid: 'drillmenu',
        menuheight: 'auto',
        breadcrumbid: 'drillcrumb',
        persist: {enable: false, overrideselectedul: false},
        homeDir: fnavUrlName,
        speed:0
    });
	 jQuery(".arrowclass").css("position","").css("position","absolute"); 
}

/**
 * �ƶ�����λ��
 */
function navMoveIfrmClk(_this) {
    jQuery("#divFloatLeftmenu").each(function(){
        jQuery.dequeue(this, "fx");}).animate({
            top : jQuery(_this).offset().top - jQuery("#leftMenu").offset().top + jQuery("#leftMenu").scrollTop(), 
            left: jQuery(_this).offset().left- jQuery("#leftMenu").offset().left
        },0, 'backout');
        
        //var abg =  _this.style.backgroundImage;
        var abg = jQuery(_this).attr("_bgPosition");        
		var htmText = jQuery(_this).find(".leftMenuItemCenter").text();;
		var htmImg = jQuery(jQuery(_this)[0]).html().substring(0, jQuery(jQuery(_this)[0]).html().toUpperCase().indexOf("<DIV"));
		jQuery(".leftMenuItemNavLeft").css("background-position", abg);
		jQuery(".leftMenuItemNavRight").css("background-position", abg);
		jQuery(".leftMenuItemNavCenter").css("background-position", abg).html("<span title='" + htmText + "' >" + htmText + "</span>");
		jQuery("#divFloatLeftmenu .arrowclass").remove();
		jQuery(htmImg).insertBefore(".leftMenuItemNavCenter");
	
		//jQuery("#divFloatLeftmenuContext").html(htmText);
		//jQuery("#divFloatLeftmenu").html(jQuery("#divFloatLeftmenu").html().substring(0, jQuery("#divFloatLeftmenu").html().lastIndexOf("</DIV>") + 6) + htmText);
        jQuery("#divFloatLeftmenu").click(function(){
            //alert(jQuery(_this).attr("href"));
            //window.open(jQuery(_this).attr("href"),jQuery(_this).attr("target"));
        });
}

function syncLMHeight() {
     //ͬ���˵��߶�
       jQuery("#drillmenu").height(jQuery("#drillmenu ul").height());
        if (jQuery("#drillmenu ul").height() < LEFT_MENU_MAX_HEIGHT) {
            jQuery("#leftMenu").height(jQuery("#drillmenu").height());
           // jQuery("#leftMenu").parent().height(jQuery("#leftMenu").height());
            setMainElementHeight(jQuery("#drillmenu").height());
            //jQuery(".navclass").hide();
        } else {
            jQuery("#leftMenu").height(LEFT_MENU_MAX_HEIGHT);
            //jQuery("#leftMenu").parent().height(LEFT_MENU_MAX_HEIGHT);
            //jQuery(".navclass").show();
            setMainElementHeight(LEFT_MENU_MAX_HEIGHT);
        }
}

function lMOpenUrl($this) {
	var _target = $this.attr("target");
	
	if (getEvent().shiftKey || shiftKeyFlag) {
		_target = "_blank";
		shiftKeyFlag = false;
	}
	
	var linksrc = $this.attr("href");
	if(linksrc.indexOf("javascript")==-1){
		if (linksrc.indexOf("?") != -1) {
			linksrc += "&";
		} else {
			linksrc += "?";
		}
		
		linksrc += "e7" + new Date().getTime() + "=";
		try{
		window.open(linksrc, _target);
		}catch(e){}
	}
} 

function isJSOpen($this){
   var linksrc = $this.attr("href");
   if(linksrc.indexOf("javascript")==-1)
      return false;
   else 
      return true;   
}

function randomChar(l) {
    var x="123456789poiuytrewqasdfghjklmnbvcxzQWERTYUIPLKJHGFDSAZXCVBNM";
    var tmp="";
    for(var i=0; i< l; i++) {
        tmp += x.charAt(Math.ceil(Math.random()*100000000)%x.length);
    }
  return tmp;
}


/**
 * �ƶ���һ���˵��ĵ���λ��
 */
function navMoveFstIfrmClk(_this) {
    jQuery("#divFloatLeftmenu").each(function(){
        jQuery.dequeue(this, "fx");}).animate({
            top : jQuery(_this).offset().top - jQuery("#leftMenu").offset().top + jQuery("#leftMenu").scrollTop(), 
            left: jQuery(_this).offset().left- jQuery("#leftMenu").offset().left
        },0, 'backout');
        
        //var abg =  _this.style.backgroundImage;
        var abg = jQuery(_this).attr("_bgPosition");        
		var htmText = jQuery(_this).find(".leftMenuItemCenter").text();
		//ȡ�ò˵���Ķ༶��־����ͷͼƬ��
        var htmImg = jQuery(jQuery(_this)[0]).html().substring(0, jQuery(jQuery(_this)[0]).html().toUpperCase().indexOf("<DIV"));
		jQuery(".leftMenuItemNavLeft").css("background-position", abg);
		jQuery(".leftMenuItemNavRight").css("background-position", abg);
		jQuery(".leftMenuItemNavCenter").css("background-position", abg).html("<span title='" + htmText + "' >" + htmText + "</span>");
		jQuery("#divFloatLeftmenu .arrowclass").remove();
		jQuery(htmImg).insertBefore(".leftMenuItemNavCenter");
		
		//jQuery("#divFloatLeftmenuContext").html(htmImg + htmText);
		//jQuery("#divFloatLeftmenu").html(jQuery("#divFloatLeftmenu").html().substring(0, jQuery("#divFloatLeftmenu").html().lastIndexOf("</DIV>") + 6) + htmText);
        jQuery("#divFloatLeftmenu").click(function(){
            //alert(jQuery(_this).attr("href"));
            //window.open(jQuery(_this).attr("href"),jQuery(_this).attr("target"));
        });
}


function getEvent() {
	if (window.ActiveXObject) {
		return window.event;// �����ie
	}
	func = getEvent.caller;
	while (func != null) {
		var arg0 = func.arguments[0];
		if (arg0) {
			if ((arg0.constructor == Event || arg0.constructor == MouseEvent)
					|| (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
				return arg0;
			}
		}
		func = func.caller;
	}
	return null;
}
</script>



<script languange="javascript">
if(navigator.userAgent.indexOf("MSIE")>0 && navigator.userAgent.indexOf("MSIE 6.0") > 0){  
	//DD_belatedPNG.fix('#toolbarMore .tbItm');
	DD_belatedPNG.fix('.leftMenuItemNavRight,background');
}
</script> 

