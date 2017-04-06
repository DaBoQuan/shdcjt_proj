<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/initNoCache.jsp"%>  

<jsp:useBean id="rs_common" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsIn_common" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="hpec" class="weaver.homepage.cominfo.HomepageElementCominfo" scope="page"/>
<jsp:useBean id="ebc" class="weaver.page.element.ElementBaseCominfo" scope="page"/>
<jsp:useBean id="pu" class="weaver.page.PageUtil" scope="page" />
<jsp:useBean id="pc" class="weaver.page.PageCominfo" scope="page"/>

<%
	/*
	������Ϣ
	eib
	ebaseid	
	esharelevel
	strsqlwhere
	*/
%>
<%
	boolean isSystemer=false;
	if(HrmUserVarify.checkUserRight("homepage:Maint", user)) isSystemer=true;
	
	String eid=Util.null2String(request.getParameter("eid"));		
	String ebaseid=Util.null2String(request.getParameter("ebaseid"));		
	String hpid=Util.null2String(request.getParameter("hpid"));
	int subCompanyId = Util.getIntValue(request.getParameter("subCompanyId"),-1);

	int userid = 1;
	int usertype=0;
	userid=pu.getHpUserId(hpid,""+subCompanyId,user);
	usertype=pu.getHpUserType(hpid,""+subCompanyId,user);

	String etitle=hpec.getTitle(eid);
	String eperpage="";
	String elinkmode="";
	String eshowfield="";
	String strsqlwhere=hpec.getStrsqlwhere(eid);
	String esharelevel="";


	String  strSql="select perpage,linkmode,showfield,sharelevel from hpElementSettingDetail where eid="+eid+" and userid="+userid+" and usertype="+usertype;	

	rs_common.executeSql(strSql);
	if(!rs_common.next()){
		int _sharelevel = 1;
		if(isSystemer){
				_sharelevel = 2;
		}
		String insertSql = "insert into hpElementSettingDetail (userid,usertype,eid,linkmode,perpage,showfield,sharelevel,hpid) select "+userid+", "+usertype+", "+eid+", linkmode,perpage,showfield,"+_sharelevel+","+hpid+" from hpElementSettingDetail where eid="+eid+" and userid=1";
		rs_common.executeSql(insertSql);
	
		rs_common.executeSql(strSql);
	}else{

		rs_common.beforFirst();
	}
	
	if(rs_common.next()){
		eperpage=Util.null2String(rs_common.getString("perpage"));
		elinkmode=Util.null2String(rs_common.getString("linkmode"));
		eshowfield=Util.null2String(rs_common.getString("showfield"));
		esharelevel=Util.null2String(rs_common.getString("sharelevel"));  //1:Ϊ�鿴 2:Ϊ�༭
	}
	
	String isFixationRowHeight="";
	String background="";
	strSql="select isFixationRowHeight,background  from hpelement where id="+eid;	
	rs_common.executeSql(strSql);
	if(rs_common.next()){
		isFixationRowHeight=Util.null2String(rs_common.getString("isFixationRowHeight"));
		background=Util.null2String(rs_common.getString("background"));
	}	
%>
<form id="setting_form_<%=eid%>">
<table class="viewform" width="100%">
<colgroup>
	<col width="40%"/>
	<col width="60%"/>
</colgroup>
<input type="hidden" name="_esharelevel_<%=eid%>" value="<%=esharelevel%>">	
<%if(!ebc.getTitle(ebaseid).equals("-1")){%>
	<%if("2".equals(esharelevel)){%>
		<TR valign='top'>
			<TD width="20%">&nbsp;<%=SystemEnv.getHtmlLabelName(19491,user.getLanguage())%></TD><!--Ԫ�ر���-->
			<TD width="80%" class=field>
				<INPUT style="width:98%" TYPE="text" maxlength=50 alt="<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>50" id="_eTitel_<%=eid%>" value="<%=etitle%>" class="inputStyle" defautvalue="<%=etitle%>" onblur="checkMaxLength(this)">
			</TD>
		</TR>
		<TR valign='top'><TD colspan=2 class=line></TD></TR>
	<%}%>
<%}%>

<%if(!ebc.getPerpage(ebaseid).equals("-1")){%>
	<TR valign='top'>
		<TD>&nbsp;<%=SystemEnv.getHtmlLabelName(19493,user.getLanguage())%></TD><!--��ʾ����-->
		<TD  class=field><INPUT TYPE="text"  id="_ePerpage_<%=eid%>" value="<%=eperpage%>" maxlength=3 class="inputStyle" style="width:98%" onkeypress="ItemCount_KeyPress()" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled"></TD>
	</TR>
	<TR valign='top'><TD colspan=2 class=line></TD></TR>
<%}%> 
<%if(!ebc.getLinkMode(ebaseid).equals("-1")&&(ebc.getLinkMode(ebaseid).equals("1")||ebc.getLinkMode(ebaseid).equals("2"))){%>
	<TR valign='top'>
		<TD>&nbsp;<%=SystemEnv.getHtmlLabelName(19494,user.getLanguage())%></TD><!--���ӷ�ʽ-->
		<TD  class=field>
			<SELECT id="_eLinkmode_<%=eid%>" >
				<option value="1" <%if("1".equals(elinkmode)) out.println("selected");%>><%=SystemEnv.getHtmlLabelName(19497,user.getLanguage())%></option><!--��ǰҳ-->

				<option value="2"  <%if("2".equals(elinkmode)) out.println("selected");%>>
				<%=SystemEnv.getHtmlLabelName(19498,user.getLanguage())%></option><!--����ҳ-->
			</SELECT>
		</TD>
	</TR>	
	<TR valign='top'><TD colspan=2 class=line></TD></TR>
<%}%>


<%
	rs_common.executeSql("select count(*) from hpFieldElement where elementid='"+ebaseid+"'");
	rs_common.next();
	if(rs_common.getInt(1)>0){
	
%>
		<TR valign='top'>
			<TD>&nbsp;<%=SystemEnv.getHtmlLabelName(19495,user.getLanguage())%></TD><!--��ʾ�ֶ�-->
			<TD  class=field>
				<%
					ArrayList selectedFieldList=Util.TokenizerString(eshowfield,",");
					rs_common.executeSql("select * from hpFieldElement where elementid="+ebaseid+" order by ordernum");
					
					while(rs_common.next()){
						String fieldId=Util.null2String(rs_common.getString("id"));
						String isLimitLength=Util.null2String(rs_common.getString("isLimitLength"));
						int fieldname=Util.getIntValue(rs_common.getString("fieldname"));
						String fieldcolumn=Util.null2String(rs_common.getString("fieldcolumn"));
						String fieldwidth = Util.null2String(rs_common.getString("fieldwidth"));
						
						String strChecked="";
						if(selectedFieldList.contains(fieldId)) strChecked=" checked ";
						out.println("&nbsp;<INPUT TYPE=checkbox NAME='_chkField_"+eid+"' value="+fieldId+" "+strChecked+">");
						out.println(SystemEnv.getHtmlLabelName(fieldname,user.getLanguage()));
						
						String display="none";
						if("2".equals(esharelevel)){
							display="";
						}
							if(fieldcolumn.toLowerCase().equals("img")){
								String imgSize ="";
								String imgWidth ="";
								String imgHeight ="";
								
								boolean autoAdjust = false;
								String autoAdjustCheckStr = "";
								rsIn_common.executeSql("select imgsize from hpFieldLength where eid="+eid+" and efieldid="+fieldId+" and userid="+userid+" and usertype="+usertype);
								if(rsIn_common.next()) imgSize=Util.null2String(rsIn_common.getString("imgsize"));
								if(!imgSize.equals("")){
									ArrayList sizeAry = Util.TokenizerString(imgSize,"*");
									imgWidth = (String)sizeAry.get(0);
									if(sizeAry.size()>1){
										imgHeight = (String)sizeAry.get(1);
									}
									if(imgHeight.equals("0")||imgHeight.equals("")){
										autoAdjust = true;
										autoAdjustCheckStr = "checked";
									}
								}else {
									imgWidth = "120";
									imgHeight = "108";
								}
								if("2".equals(esharelevel)){
									out.println("&nbsp;"+SystemEnv.getHtmlLabelName(203,user.getLanguage())+":<INPUT TYPE = text name='_imgWidth"+eid+"' value='"+imgWidth+"' basefield="+fieldId+" class='inputStyle'  style='display:"+display+";width:35px' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\">");
								}else{
									out.println("&nbsp;<INPUT TYPE = text name='_imgWidth"+eid+"' value='"+imgWidth+"' basefield="+fieldId+" class='inputStyle'  style='display:"+display+";width:35px' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\">");
								}
								if(!autoAdjust){
									out.println("<span id='_imgHeightDiv"+eid+"' style='display:"+display+";width:70px'>&nbsp;"+SystemEnv.getHtmlLabelName(207,user.getLanguage())+":<INPUT TYPE = text name='_imgHeight"+eid+"' value='"+imgHeight+"' basefield="+fieldId+" class='inputStyle'  style='width:35px' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\" ></span>");
								}else{
									out.println("<span id='_imgHeightDiv"+eid+"' style='width:70px;display:none' >&nbsp;"+SystemEnv.getHtmlLabelName(207,user.getLanguage())+":<INPUT TYPE = text name='_imgHeight"+eid+"' value='"+imgHeight+"' basefield="+fieldId+" class='inputStyle'  style='width:35px;' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\" ></span>");
								}
								if("2".equals(esharelevel)){
									out.println("<INPUT style='' TYPE = checkbox name='_imgAutoAdjust"+eid+"' "+autoAdjustCheckStr+" onclick='if(event.srcElement.checked){document.getElementById(\"_imgHeightDiv"+eid+"\").style.display=\"none\";document.getElementById(\"_imgHeight"+eid+"\").value=0}else{document.getElementById(\"_imgHeightDiv"+eid+"\").style.display=\"\"}'>&nbsp;"+SystemEnv.getHtmlLabelName(22494,user.getLanguage())+"");
									
								}else{
									out.println("<INPUT style='display:"+display+"' TYPE = checkbox name='_imgAutoAdjust"+eid+"' "+autoAdjustCheckStr+" onclick='if(event.srcElement.checked){document.getElementById(\"_imgHeightDiv"+eid+"\").style.display=\"none\";document.getElementById(\"_imgHeight"+eid+"\").value=0}else{document.getElementById(\"_imgHeightDiv"+eid+"\").style.display=\"\"}'>");									
								}	
						}
						
						int wordLength=8;
						if("1".equals(isLimitLength)) {
							rsIn_common.executeSql("select charnum from hpFieldLength where eid="+eid+" and efieldid="+fieldId+" and userid="+userid+" and usertype="+usertype);
							if(rsIn_common.next()) wordLength=Util.getIntValue(rsIn_common.getString("charnum"));
							if("2".equals(esharelevel)){
								out.println("&nbsp;"+SystemEnv.getHtmlLabelName(19524,user.getLanguage())+":<input name=_wordcount_"+eid+" basefield="+fieldId+" type='text' style='width:24px' class=inputstyle title="+SystemEnv.getHtmlLabelName(19524,user.getLanguage())+" value='"+wordLength+"' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\" >&nbsp;");
							}else{
								out.println("&nbsp;<input name=_wordcount_"+eid+" basefield="+fieldId+" type='text' style='width:24px' class=inputstyle title="+SystemEnv.getHtmlLabelName(19524,user.getLanguage())+" value='"+wordLength+"' onkeypress=\"ItemCount_KeyPress()\" onpaste=\"return !clipboardData.getData('text').match(/\\D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\">&nbsp;");
							}
						}
						out.println("<br>");
					}
				%>
			
			</TD>
		</TR>	
		<TR valign='top'><TD colspan=2 class=line></TD></TR>

<%
}
	if(!"2".equals(esharelevel)){
		return;
	}
%>	
