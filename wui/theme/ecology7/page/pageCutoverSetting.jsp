<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.systeminfo.setting.HrmUserSettingHandler" %>
<%@ page import="weaver.systeminfo.setting.HrmUserSetting" %>
<%@ include file="/systeminfo/init.jsp" %>

<%

String imagefilename = "/images/hdMaintenance.gif";

String needhelp = "";
//������
String titlename = SystemEnv.getHtmlLabelName(68,user.getLanguage()) + " - ҳ���л�Ч������";


int userid = user.getUID();

cutoverWay = "";
transitionTime = "";
transitionWay = "";

String self = request.getParameter("self");

if (self != null && self.equals("1")) {
	cutoverWay = request.getParameter("cutoverWay");
	transitionTime = request.getParameter("TransitionTime");
	transitionWay = request.getParameter("TransitionWay");
	
	weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
	weaver.conn.RecordSet rs2 = new weaver.conn.RecordSet();


	rs.executeSql("select * from SysSkinSetting where userid=" + userid);
	String sql = "";
	if(rs.next()){
		sql = "update SysSkinSetting set cutoverWay='" + cutoverWay + "', transitionTime='" + transitionTime + "', transitionWay='" + transitionWay + "' where userid=" + userid;
	} else {
	    sql = "insert into SysSkinSetting(userid, cutoverWay, TransitionTime, TransitionWay) values ('" + userid + "', '" + cutoverWay + "', '" + transitionTime + "', '" + transitionWay + "')";
	}	
	rs2.executeSql(sql);
}

weaver.conn.RecordSet recordSet = new weaver.conn.RecordSet();

recordSet.executeSql("select cutoverWay, TransitionTime, TransitionWay from SysSkinSetting where userid=" + userid);

if(recordSet.next()){
	cutoverWay = Util.null2String(recordSet.getString("cutoverWay"));
	transitionTime = Util.null2String(recordSet.getString("TransitionTime"));
	transitionWay = Util.null2String(recordSet.getString("TransitionWay"));
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link href="/css/Weaver.css" type=text/css rel=stylesheet>
    
<script type="text/javascript">
    function submit() {
        document.all.form1.submit();
    }
</script>
  </head>
  
  <body>
  <%@ include file="/systeminfo/TopTitle.jsp" %>
  <%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
  
  <%
  RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submit(),_self} " ;
  RCMenuHeight += RCMenuHeightStep ;
  %>
  
  <%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form action="/wui/theme/ecology7/page/pageCutoverSetting.jsp" name="form1" method="POST">
    <input type="hidden" name="self" value="1">
	<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
		<colgroup>
		<col width="10">
		<col width="">
		<col width="10">
	
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
		<tr>
			<td ></td>
			<td valign="top">
			
			<TABLE class="Shadow">
			<tr>
			<td valign="top">
			
    <TABLE class=ViewForm>
		<COLGROUP>
		<COL width="30%">
		<COL width="70%">
		
			<TR class=Title>
				<TH colSpan=2>ҳ���л�Ч������</TH>
			</TR>
			
			<TR class=Spacing>
			<TD class=Line1 colSpan=2></TD>
			</TR>
		
			<tr>
              <td>�л���ʽ</td>
              <td class=Field>
                <select name="cutoverWay" value="<%=cutoverWay %>">
                    <option value="Page-Enter" <%="Page-Enter".equals(cutoverWay) ? "selected" : "" %>>����ҳ��</option>
                    <option value="Page-Exit"  <%="Page-Exit".equals(cutoverWay) ?  "selected" : "" %>>�뿪ҳ��</option>
                </select>
              </td>
            </tr>

            <TR>
                <TD class=Line colspan=2></TD>
            </TR>
            
            
            <tr>
              <td>����ʱ�䣨�룩</td>
              <td class=Field>
                <input type="text" name="TransitionTime" onkeypress="ItemNum_KeyPress()" value="<%=transitionTime %>">�������û�������0��ر�Ч����
              </td>
            </tr>

            <TR>
                <TD class=Line colspan=2></TD>
            </TR>
            
            <tr>
              <td>���ɷ�ʽ</td>
              <td class=Field>
	               <select name="TransitionWay" value="<%=transitionWay %>">
	                    <option value="0" <%="0".equals(transitionWay) ? "selected" : "" %>>��״����</option>
						<option value="1" <%="1".equals(transitionWay) ? "selected" : "" %>>��״����</option>
						<option value="2" <%="2".equals(transitionWay) ? "selected" : "" %>>Բ������</option>
						<option value="3" <%="3".equals(transitionWay) ? "selected" : "" %>>Բ�η���</option>
						<option value="4" <%="4".equals(transitionWay) ? "selected" : "" %>>��������</option>
						<option value="5" <%="5".equals(transitionWay) ? "selected" : "" %>>��������</option>
						<option value="6" <%="6".equals(transitionWay) ? "selected" : "" %>>��������</option>
						<option value="7" <%="7".equals(transitionWay) ? "selected" : "" %>>��������</option>
						<option value="8" <%="8".equals(transitionWay) ? "selected" : "" %>>��ֱ��Ҷ��</option>
						<option value="9" <%="9".equals(transitionWay) ? "selected" : "" %>>ˮƽ��Ҷ��</option>
						<option value="10" <%="10".equals(transitionWay) ? "selected" : "" %>>ˮƽ��״��Ҷ��</option>
						<option value="11" <%="11".equals(transitionWay) ? "selected" : "" %>>��ֱ��״��Ҷ��</option>
						<option value="12" <%="12".equals(transitionWay) ? "selected" : "" %>>�ܽ�</option>
						<option value="13" <%="13".equals(transitionWay) ? "selected" : "" %>>�������������м�չ��</option>
						<option value="14" <%="14".equals(transitionWay) ? "selected" : "" %>>���м�����������չ��</option>
						<option value="15" <%="15".equals(transitionWay) ? "selected" : "" %>>�������������м�չ��</option>
						<option value="16" <%="16".equals(transitionWay) ? "selected" : "" %>>���м�����������չ��</option>
						<option value="17" <%="17".equals(transitionWay) ? "selected" : "" %>>�����Ͻ������½�չ��</option>
						<option value="18" <%="18".equals(transitionWay) ? "selected" : "" %>>�����½������Ͻ�չ��</option>
						<option value="19" <%="19".equals(transitionWay) ? "selected" : "" %>>�����Ͻ������½�չ��</option>
						<option value="20" <%="20".equals(transitionWay) ? "selected" : "" %>>�����½������Ͻ�չ��</option>
						<option value="21" <%="21".equals(transitionWay) ? "selected" : "" %>>ˮƽ��״չ��</option>
						<option value="22" <%="22".equals(transitionWay) ? "selected" : "" %>>��ֱ��״չ��</option>
						<option value="23" <%="23".equals(transitionWay) ? "selected" : "" %>>�������һ�ֹ��ɷ�ʽ</option>
	                </select>
              </td>
            </tr>

            <TR>
                <TD class=Line colspan=2></TD>
            </TR>
		
		</TBODY>
	</TABLE>

			
			</td>
			</tr>
			</TABLE>
			
			</td>
			<td></td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
</form>   


  </body>
</html>
