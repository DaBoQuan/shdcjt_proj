<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*,HT.HTSrvAPI,java.math.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.file.Prop" %>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.systeminfo.template.UserTemplate"%>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.file.Prop" %>
<%@ page import="weaver.systeminfo.setting.*" %>
<jsp:useBean id="PluginUserCheck" class="weaver.license.PluginUserCheck" scope="page" />


<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="HrmScheduleDiffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page" />
<%@ include file="/systeminfo/init.jsp" %>


<%
/**
 * ϵͳ���⡢Ƥ��
 */
String pslSkinfolder = "";
curTheme = request.getParameter("theme");//getCurrWuiConfig(session, user, "theme");
pslSkinfolder = request.getParameter("skin");//getCurrWuiConfig(session, user, "skin");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
        <title></title>
		<!--For Base-->
		<link rel="stylesheet" type="text/css" href="/wui/common/css/base.css" />
		<script type="text/javascript" src="/wui/common/jquery/jquery.js"></script>
		<link type='text/css' rel='stylesheet'  href='/wui/theme/<%=curTheme %>/skins/<%=pslSkinfolder %>/wui.css'/>
        <STYLE TYPE="text/css">
            
            body{
                 margin: 0px; 
                /*���Ա���̬���ĵ�ֵ*/
                /*background:url('images/body-bg.png') repeat-y;*/
                font-size: 9pt;font-family: verdana;
                
            }
            TABLE {
			    FONT-SIZE: 9pt; FONT-FAMILY: Verdana
			}
            .xTable_message{
			    border:1px solid #8888AA;
			    background:white;
			    position:absolute;
			    padding:5px;
			    z-index:100;
			    display:none;
			    FONT-SIZE: 9pt; 
			    MARGIN: 0px; 
			    FONT-FAMILY: Verdana; 
			    LIST-STYLE-TYPE: circle; 
            }   
            
            table td{
                padding:0px;
            }
            #container{
                width:100%;height:100%;    border-collapse:collapse;
            }
            #head{
                WIDTH:100%;height:70px;
                background:url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/head-bg.jpg') no-repeat;
                /*background:url('images/head-bg.png') no-repeat;*/
                border-collapse:collapse;
            }
            


            #contentContainer{
                WIDTH:100%;height:100%;
                border-collapse:collapse;
            }
            #contentContainer #content{
                WIDTH:100%;height:100%;
                border-collapse:collapse;
            }

            #leftmenucontainer{
                height:100%;
            }
            #footer{

            }

            #shadown-corner{
                background:url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/shadown-coner.png') no-repeat; width:10px;height:10px;
            }
            #shadown-x{
                background:url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/shadown-x.png') repeat-x; height:10px;
            }
            #shadown-y{
                background:url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/shadown-y.png') repeat-y; width:10px;
            }
            #shadown-content{background:#fff;}
            
            
            /*�ɸ�������  ���˵�*/
            /*���˵���*/
            #leftmenucontainer{}
            /*���˵���*/
            #leftmenucontainer-top{
                height:10px;
            }

            #leftmenu-top{
                height:86px;
            } 
            #leftmenu-bottom{
                
                height:250px;                
            }
            #leftmenu-bottom-bottom{
                height:7px;
            }
			#leftmenu-bottom {
				position:absolute;
				width:128;
				height:0px;
				z-index:0;
			}
			
			
			#leftBlockTd {
				background:none;
			}
			.leftBlockTopBgLeft {
				overflow:hidden;width:10px;position:absolute;left:0;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockTopBgLeft.jpg) no-repeat;height:10px;
			}
			#leftBlockTopBgCenter {
				overflow:hidden;position:absolute;left:10px;right:2px;top:0;height:10px;
			}
			.leftBlockTopBgRight {
				overflow:hidden;position:absolute;right:-2;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockTopBgRight.jpg) no-repeat;height:10px;width:2px;
			}
			
			#leftmenu-top {
				position:absolute;width:128;height:87px;
			}
			
			.leftBlockHrmInfoLeft {
				width:60px;position:absolute;left:0;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockHrmInfoBgLeft.png) no-repeat;height:87px;
			}
			
			.leftBlockHrmInfoCenter {
				position:absolute;left:60px;right:6px;top:0;height:87px;width:60px;
			}
			
			.leftBlockHrmInfoRight {
				position:absolute;right:0;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockHrmInfoBgRight.png) no-repeat;height:87px;width:6px;
			}
			#leftBlock_HrmDiv {
				position:relative;top:0px;height:86px;
			}
			
			#leftmenu-bottom-bottom {
				width:128px;position:relative;top:0px;
			}
			.leftMenuBottomLeft {
				width:5px;position:absolute;left:0;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftMenuBottomLeft.png) no-repeat;height:7px;
			}
			#leftMenuBottomCenter {
				position:absolute;left:5px;right:6px;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftMenuBottomCenter.png) repeat-x;height:7px;
			}
			
			.leftMenuBottomRight {
				position:absolute;right:0;top:0;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftMenuBottomRight.png) no-repeat;height:7px;width:6px;
			}
			
			#topBlockHiddenContr {
				width:502px;height:20px;position:relative;margin-bottom:-12px;cursor:pointer;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/topBlockContraction.png) no-repeat;background-position:0 25;
			}
			#leftBlockHiddenContr {
				height:502px;width:12px;position:relative;margin-right:-12px;cursor:pointer;background:url(/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/main/leftBlockContraction.png) no-repeat;overflow:hidden;background-position:25 0;
			}
			.versiontype { 
				position:absolute;left:150;top:40;
				/*background:url(/wui/theme/ecology7/page/images/versiontype.png) no-repeat;height:10px;width:33px;display:block;overflow:hidden;*/
			}
			#mainFrame {
				height:100%!important;
			}
			/*IE6 fixed*/
			

        </STYLE>
		
		
    </head>
        
    
<!-- �������������CSS2011/5/19 -->

    <body id="mainBody" scroll="no"  style="">
                                        <!--�������˵���-->
                                        <div  id="leftmenucontainer"  style="width:100%;overflow:hidden;"> 
                                            <div id="leftmenucontainer-top" style="position:relative;left:-1;">
                                            	<div class="leftBlockTopBgLeft"></div>
                                   				<div id="leftBlockTopBgCenter"></div>
                                   				<div class="leftBlockTopBgRight"></div>
                                            </div>
                                            <div style="padding-left:10px;margin-top:5px;">
                                                <table width="100%"  cellpadding="0px" cellspacing="0px">
                                                    <tr><td>
                                                    	<table width="100%"  cellpadding="0px" cellspacing="0px">
                                                    		<tr>
                                                    			<td style="position:relative;">
                                                    				<div id="leftmenu-top" style="">
                                                    					<div class="leftBlockHrmInfoLeft"></div>
                                                        				<div id="leftBlockHrmInfoCenter" class="leftBlockHrmInfoCenter"></div>
                                                        				<div class="leftBlockHrmInfoRight"></div>
                                                    				</div>
                                                    				<div id="leftBlock_HrmDiv">
	                                                    				<!--���ü�ʱͨѶ��صĶ���-->
	                                                        			<jsp:include page="/wui/theme/ecology7/page/skinSetting/hrmInfo.jsp"></jsp:include>
                                                        			</div>
                                                    			</td>
                                                    		</tr>
                                                    	</table>
                                                        
                                                    </td></tr>
                                                    <tr><td style="position:relative;">
                                                    	<div id="leftmenu-bottom"></div>
                                                        <!--�������˵���-->
                                                        <div style="position:relative;top:0px;">
                                                        	<jsp:include page="/wui/theme/ecology7/page/skinSetting/left.jsp">
                                                        		<jsp:param name="skin" value="<%=pslSkinfolder %>"/>
                                                        	</jsp:include> 
                                                        </div>
                                                        <div id="leftmenu-bottom-bottom">
                                                        	<div class="leftMenuBottomLeft"></div>
                                                        	<div id="leftMenuBottomCenter"></div>
                                                        	<div class="leftMenuBottomRight"></div>
                                                        </div>
                                                    </td></tr>
                                                </table>
                                            </div>
                                        </div>            
    </body>
</html>

<script languange="javascript">
//��������ȣ����ݷֱ����Զ�������
var LeftBlock_Max_Width = 0;
/**
 * ��ʼ��������������ô�С
 * �Զ�ִ��
 */
function leftBlockSizeInit() {
	var clientScreenHeight = 512;//window.screen.height;
	var clientScreenWidth = 1280;//window.screen.width;
	if (clientScreenWidth < 1280) {
		clientScreenWidth = 1280;
	}
    var tpLeftMenuMaxHeight = Math.round(clientScreenHeight / 2.8);
    var tpLeftMenuMaxWidth = Math.round(clientScreenWidth / 8);
    setLeftBlockSize(tpLeftMenuMaxWidth, tpLeftMenuMaxHeight);
    //alert(tpLeftMenuMaxHeight);
    LeftBlock_Max_Width = tpLeftMenuMaxWidth;
}

/**
 * ����������������ô�С
 */
function setLeftBlockSize(tpLeftMenuMaxWidth, tpLeftMenuMaxHeight) {
	//jQuery("#leftBlockTd").css("width", tpLeftMenuMaxWidth + 3);
	jQuery("#leftBlockTd").css("width", tpLeftMenuMaxWidth + 25);
	jQuery("#leftmenucontainer").css("width", tpLeftMenuMaxWidth + 25);
	jQuery("#leftBlockTopBgCenter").css("width", tpLeftMenuMaxWidth + 14);
	jQuery("#leftBlockTopBgCenter").css("background", "url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockTopBgCenter.jpg')");
	
	//td 126px
	jQuery("#leftmenu-top").css("width", tpLeftMenuMaxWidth + 3);
	jQuery("#leftmenu-top").css("height", 86);
	
	jQuery("#leftBlockHrmInfoCenter").css("width", tpLeftMenuMaxWidth - 63);
	jQuery("#leftBlockHrmInfoCenter").css("background", "url('/wui/theme/ecology7/skins/<%=pslSkinfolder %>/page/left/leftBlockHrmInfoBgCenter.png')");
	jQuery("#leftBlockHrmInfoCenter").css("background-repeat", "repeat-x");	
	
	//jQuery("#leftmenu-bottom").css("height", tpLeftMenuMaxHeight + 124 - 61);
	setMainElementHeight(27);
	
	if(jQuery.client.browser=="Explorer"){
		jQuery("#leftmenu-bottom").css("width", tpLeftMenuMaxWidth + 3);
	}else{
		jQuery("#leftmenu-bottom").css("width", tpLeftMenuMaxWidth + 1);
	}
	jQuery("#leftBlock_HrmDiv").css("height", 86);
	jQuery("#leftmenu-bottom-bottom").css("width", tpLeftMenuMaxWidth + 3);
	
	jQuery("#leftMenuBottomCenter").css("width", tpLeftMenuMaxWidth - 8);
	
	
	
	setHrmInfoDep(tpLeftMenuMaxWidth - 62);
}
/**
 * �Զ�����
 */
leftBlockSizeInit();


function  setMainElementHeight(height) {
	if(jQuery.client.browser=="Explorer"){
		jQuery("#leftmenu-bottom").css("height", height + jQuery("#drillcrumb").height() + 71);
	}else{
		jQuery("#leftmenu-bottom").css("height", height + jQuery("#drillcrumb").height() + 71);
	}
} 

/**
 * �������������hrmInfo�Ĵ�С
 */
function setHrmInfoDep(tpLeftMenuMaxWidth) {
	jQuery("#leftBlockHrmDep").css("width", tpLeftMenuMaxWidth);
	jQuery("#tdMessageState").css("left", tpLeftMenuMaxWidth - 60);
}

jQuery("#leftBlockHiddenContr").css("background", "");
jQuery("#topBlockHiddenContr").css("background", "");


jQuery(document).ready(function () {
	
});
</script>
