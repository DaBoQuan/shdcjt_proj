<%@ include file="/page/element/settingCommon.jsp"%>
<%@page import="java.util.*" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="rs_Setting" class="weaver.conn.RecordSet" scope="page" />
<%
	String  blog_showNum="10";
    String 	blog_isCreatedate="1";
    String 	blog_isRelatedName="1";
	String sql="select name,value from hpelementsetting where eid='"+eid+"'";
	rs_Setting.execute(sql);
	while(rs_Setting.next()){
		String name=rs_Setting.getString("name");
		if(name.equals("blog_showNum"))
			blog_showNum=rs_Setting.getString("value");
		else if(name.equals("blog_isCreatedate"))
			blog_isCreatedate=rs_Setting.getString("value");
		else if(name.equals("blog_isRelatedName"))
			blog_isRelatedName=rs_Setting.getString("value");
	}
%>

	<tr>
		<td style="padding-left:6px;"><%=SystemEnv.getHtmlLabelName(19493,user.getLanguage())%></td>
		<td class="field"><input name="blog_showNum_<%=eid %>" class="inputStyle" style="width:120px" value='<%=blog_showNum %>'></input></td>
	</tr>
	<TR><TD class="LINE" colSpan="2"></TD></TR>
	<tr>
		<td valign="top" style="padding-left:6px;"><%=SystemEnv.getHtmlLabelName(19495,user.getLanguage())%></td> <!-- ��ʾ�ֶ� -->
		<td class="field">
		  <input name="blog_isRelatedName_<%=eid %>" type="checkbox" <%=blog_isRelatedName.equals("1")?"checked=checked":""%> value='1'></input>&nbsp;<%=SystemEnv.getHtmlLabelName(792,user.getLanguage())%><!-- �����Ա -->
		  <br>
		  <input name="blog_isCreatedate_<%=eid %>" type="checkbox" <%=blog_isCreatedate.equals("1")?"checked=checked":""%>  value='1'></input>&nbsp;<%=SystemEnv.getHtmlLabelName(784,user.getLanguage())%><!-- �������� -->
		</td>
	</tr>
	<TR><TD class="LINE" colSpan="2"></TD></TR>
</form>
