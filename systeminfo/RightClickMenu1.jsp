<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%
/**
 * ��ȡ��ǰ���⼰��ӦƤ����init.jsp��setting��
 */
String tmpCurTheme = (String)session.getAttribute("SESSION_TEMP_CURRENT_THEME");
String tmpCurskin = (String)session.getAttribute("SESSION_CURRENT_SKIN");



int imgIndex=0;

//add by zhouquan for support copy,paste,stop,selectAll method

//String theuri = request.getRequestURI();
//RCMenu += "{"+SystemEnv.getHtmlLabelName(16685,user.getLanguage())+",javascript:viewSource(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{view URL,javascript:viewProperty(\""+theuri+"\"),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
RCMenu += systemAdminMenu;
RCMenu=RCMenu.trim();
String iframeShtml = "" ;
if (!RCMenu.equals("")) {

				//��ԭ����apXPDropDown.classתΪֱ����Button��2003-11-18�������
				if(userightmenu == 0&&RCFromPage.equals("mailOption")) //�ʼ�����ҳ�������
					iframeShtml += "<div id='menuTable' name='menuTable' class='topmenuTable'  style='BACKGROUND-COLOR: #ECECEC;left:0px;top:0px;margin-top:0px;posTop:0px;' >";
				else
				    iframeShtml += "<div id='cmroot' style='width: 160px;' unselectable='on' class='b-m-mpanel'>";
				ArrayList RCMENUArray = Util.TokenizerString(RCMenu,"}") ;
				int itemNumTemp =0 ;
				String btnNameTemp = "";
				String urlTemp = "";
				String targetTemp = "";
				for (int itemNum=0;itemNum<RCMENUArray.size();itemNum++)
				{
					String RCMENUTemp = (String)RCMENUArray.get(itemNum);
					RCMENUTemp=RCMENUTemp.trim();
					if (!RCMENUTemp.equals("")){
						RCMENUTemp += "}" ;
						if (RCMENUTemp.indexOf("{-}")==-1)//�����ԭ���ǲ���ĵĸ��߼��ַ�����{-}�Ͳ���������
						{
							itemNumTemp++;
							RCMENUTemp = RCMENUTemp.substring(1,RCMENUTemp.length()-1); //ȥ�����ҵ�{}
							RCMENUTemp = RCMENUTemp.trim();
							//ArrayList RCMenuItemArray = Util.TokenizerString(RCMENUTemp,",") ;//��ÿһ����Ĳ����ֽ����
							//2004-04-22�����������ÿ���˵���ķֽⷽʽ����Util.TokenizerString��ʽ����substring�������̶ܹ�Ϊ3��˵�������ַ��Ŀ�꣬ʹ��javascript�����ܹ�ʹ�ö������
							btnNameTemp = RCMENUTemp.substring(0,RCMENUTemp.indexOf(","));
							//(String)RCMenuItemArray.get(0);//����
							btnNameTemp=btnNameTemp.trim();
							urlTemp = RCMENUTemp.substring((RCMENUTemp.indexOf(",")+1),RCMENUTemp.lastIndexOf(","));	//(String)RCMenuItemArray.get(1);//��ַ��javascript function
							urlTemp=urlTemp.trim();
							targetTemp = RCMENUTemp.substring((RCMENUTemp.lastIndexOf(",")+1),RCMENUTemp.length());	//(String)RCMenuItemArray.get(2);//target
							targetTemp=targetTemp.trim();
							if (urlTemp.indexOf("javascript:")==-1)//���ֱ�Ӹ�urlʱ����
								{
									if (targetTemp.equals("_blank"))
										urlTemp ="javascript:window.open('"+urlTemp+"','')";
									else if (targetTemp.equals("_parent"))
										urlTemp ="javascript:parent.parent.location.href=\""+urlTemp+"\"";
									else if ((targetTemp.equals("_self"))||(targetTemp.equals("_top")))
										urlTemp ="javascript:parent.location.href=\""+urlTemp+"\"";
									else
										urlTemp ="javascript:parent."+targetTemp+".location.href=\""+urlTemp+"\"";
								}
							else
								{
									if (urlTemp.indexOf("javascript:location=")!=-1)
										urlTemp = "javascript:parent.location.href=\"" + urlTemp.substring(21,urlTemp.length()-1)+"\"";
									else if (urlTemp.indexOf("javascript:location.href=")!=-1)
										urlTemp = "javascript:parent.location.href=\"" + urlTemp.substring(26,urlTemp.length()-1)+"\"";
									else
										urlTemp = "javascript:parent." + urlTemp.substring(11);
								}
							String imgPath=RightClickMenu.getIconPath(itemNumTemp,btnNameTemp);
							if("".equals(imgPath)){
								imgIndex++;
								if(imgIndex>9) imgIndex=0;
							}
							if(userightmenu == 0&&RCFromPage.equals("mailOption")){ //�ʼ�����ҳ�������
								iframeShtml += "<button class='topClickMenuOut' onmouseover='this.className=\"topClickMenuOver\"' onmouseout='this.className=\"topClickMenuOut\"' onclick='"+urlTemp+"'   style='width:"+RCMenuWidth+";height:"+RCMenuHeightStep+"'><img src='/wui/theme/" + tmpCurTheme + "/skins/" + tmpCurskin + "/contextmenu/"+("".equals(imgPath)?("default/"+imgIndex+".png"):("CM_"+imgPath+".gif"))+"' border=0 align='absmiddle'> <font face=Arial >"+btnNameTemp+"</font></button>" ; 
							}else{
								/**
								iframeShtml += "<tr><td width='" + RCMenuWidth + "' height='" + RCMenuHeightStep + "' onmousemove='showTDTitle(this);'>" ;
								iframeShtml += "<button class='rightClickMenuOut' onmouseover='this.className=\"rightClickMenuOver\"' onmouseout='this.className=\"rightClickMenuOut\"' onclick='"+urlTemp+"'   style='width:"+RCMenuWidth+";height:"+RCMenuHeightStep+"'><img src='/wui/theme/" + tmpCurTheme + "/skins/" + tmpCurskin + "/contextmenu/CM_"+itemNumTemp+".gif' border=0 align='absmiddle'> <font face=Arial >"+btnNameTemp+"</font></button>" ;
								iframeShtml +="</td></tr>";
								
								iframeShtml+="<div    unselectable='on' class='b-m-item'  onmouseover=\"this.className=\'"+"b-m-ifocus"+"\'\" onmouseout=\"this.className=\'"+"b-m-item"+"\'\"  onclick='"+urlTemp+"' ><div class='b-m-ibody' unselectable='on'><nobr unselectable='on'><img width=16 src='/wui/theme/" + tmpCurTheme + "/skins/" + tmpCurskin + "/contextmenu/CM_"+RightClickMenu.getIconPath(itemNumTemp,btnNameTemp)+".gif' align='absmiddle'><label unselectable='on' >"+btnNameTemp+"</label></nobr></div></div>";*/


								iframeShtml+="<div    unselectable='on' class='b-m-item'  onmouseover=\"this.className=\'"+"b-m-ifocus"+"\'\" onmouseout=\"this.className=\'"+"b-m-item"+"\'\"   ><div class='b-m-ibody' unselectable='on'><nobr unselectable='on'>";
									
										iframeShtml+="<img width=16 src='/wui/theme/" + tmpCurTheme + "/skins/" + tmpCurskin + "/contextmenu/"+("".equals(imgPath)?("default/"+imgIndex+".png"):("CM_"+imgPath+".gif"))+"' align='absmiddle'>";
									
									iframeShtml+="<button  onclick='"+urlTemp+"'   style='width:"+(RCMenuWidth-40)+"px;'>"+btnNameTemp+"</button>";
									iframeShtml+="</nobr></div></div>";
							}
								  
			  			}
					}
				}
			 %>
<%
if(userightmenu == 0&&RCFromPage.equals("mailOption")) //�ʼ�����ҳ�������
	iframeShtml +="</div>";
else
	iframeShtml +="</div>";
}
String ajaxid="ajax"+String.valueOf(System.currentTimeMillis());
iframeShtml="<script type='text/javascript'>function showTDTitle(o){	o.title = o.innerText;}</script>"+iframeShtml;
iframeShtml="<link rel='stylesheet' href='/wui/theme/" + tmpCurTheme + "/skins/" + tmpCurskin + "/contextmenu/contextmenu.css' /><link rel='stylesheet' href='/css/Weaver.css'>"+iframeShtml;

%>


<div style="display:none;" id=<%=ajaxid%>><%=iframeShtml%></div>
<%if(userightmenu == 0&&RCFromPage.equals("mailOption")) {//�ʼ�����ҳ������� %>
   <iframe  src="javascript:document.innerHTML=parent.document.getElementById('<%=ajaxid%>').innerHTML" id="rightMenuIframe" onload="topMenu(this)"
            frameborder=0 marginheight=0 marginwidth=0 width="100%" height="<%=RCMenuHeightStep%>" hspace=0 vspace=0 scrolling=no width="<%=RCMenuWidth%>"
            height="<%=RCMenuHeight+20%>" >
    </iframe>
<%}else{ %>
<div id="rightMenu" name="rightMenu" style="position:absolute;z-index:2;visibility:hidden">
    <iframe  src="javascript:document.innerHTML=parent.document.getElementById('<%=ajaxid%>').innerHTML"
            frameborder=0 marginheight=0 marginwidth=0 hspace=0 vspace=0 scrolling=no width="<%=RCMenuWidth+2%>"
            height="<%=RCMenuHeight+6%>" >
    </iframe>
</div>
<%} %>



