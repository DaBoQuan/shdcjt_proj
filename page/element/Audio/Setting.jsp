<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/element/settingCommon.jsp"%>
<%@ include file ="common.jsp" %>
<%@page import="java.util.ArrayList;"%>


			
			<TR vAlign="top">
				<TD>&nbsp;<%=SystemEnv.getHtmlLabelName(89,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(19653,user.getLanguage())%></TD>
				<!--��ʾ����-->
				<TD class="field" style='padding-left:3px'> <!--  <%=SystemEnv.getHtmlLabelName(203,user.getLanguage())%>: --><INPUT style='display:none'
					class="inputstyle" title="<%=SystemEnv.getHtmlLabelName(203,user.getLanguage())%>" style="WIDTH: 24px"
					name="width_<%=eid%>"  value="<%=valueList.get(nameList.indexOf("width")) %>"/> 
				<%=SystemEnv.getHtmlLabelName(207,user.getLanguage())%>:<INPUT class="inputstyle" title="<%=SystemEnv.getHtmlLabelName(207,user.getLanguage())%>"
					style="WIDTH: 24px" name="height_<%=eid %>" value="<%=valueList.get(nameList.indexOf("height")) %>" onkeypress="ItemCount_KeyPress(event)"/>&nbsp; 
				<INPUT type="checkbox" <% if(valueList.get(nameList.indexOf("autoPlay")).equals("on")) out.print("checked"); else out.print(""); %> name="autoPlay_<%=eid%>" />
				<%=SystemEnv.getHtmlLabelName(22840,user.getLanguage())%> <BR />
				</TD>
			</TR>
			<TR vAlign="top">
				<TD class="line" colSpan="2"></TD>
			</TR>
			<TR vAlign="top">
				<TD>&nbsp;<%=SystemEnv.getHtmlLabelName(23786,user.getLanguage())%></TD>
				<!--��Ƶ��Դ-->
				<TD class="field" style='padding:0px'>
				<TABLE class="viewform" width="100%">
						<col width="80"/>
						<col width="*"/>
					<TBODY>
						<TR>
							<TD width='80px'>
							<INPUT id="audioSrcType_<%=eid%>" type="radio"
								<%if(valueList.get(nameList.indexOf("audioSrcType")).equals("1")) out.print("checked");%> name="audioSrcType_<%=eid%>" selecttype="1" value='1' />
							<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18493,user.getLanguage())%>
							</TD>
							<TD width='*'>
							<input width="60%" name="audioSrc_<%=eid%>" id="audioSrc_<%=eid%>"  class="filetree" type="text" value="<%if(valueList.get(nameList.indexOf("audioSrcType")).equals("1")) out.print(valueList.get(nameList.indexOf("audioSrc")));%>"/>
							</td>
						</TR>
						<TR>
								<TD width='80px'><INPUT id="audioSrcType_<%=eid%>" type="radio"
								<%if(valueList.get(nameList.indexOf("audioSrcType")).equals("2")) out.print("checked");%> name="audioSrcType_<%=eid%>" selecttype="2" value="2" /> URL<%=SystemEnv.getHtmlLabelName(18499,user.getLanguage())%>&nbsp;&nbsp;
								</TD>
								<TD width='*'>
								<input name = "audioUrl_<%=eid%>" value="<%if(valueList.get(nameList.indexOf("audioSrcType")).equals("2")) out.print(valueList.get(nameList.indexOf("audioSrc"))); %>" class="inputStyle" style='width:90%' onKeyPress= "CheckNum()">
								</TD>
						</TR>
					</TBODY>
				</TABLE>
				</TD>
			</TR>
			<TR>
				<TD class="LINE" colSpan="2"></TD>
			</TR>
		</TBODY>
	</TABLE>
</form>
	<SCRIPT LANGUAGE="JavaScript">
		$("#audioSrc_<%=eid%>").filetree();
		//�������뵥����
		function   CheckNum() 
		{ 
			if (Window.event.keyCode==39) 
				{ 
    			window.event.keyCode=0; 
				} 
		} 
  	</SCRIPT>
	