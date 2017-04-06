<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String needfav ="1";
String needhelp ="";


String questionid= Util.fromScreen(request.getParameter("questionid"),user.getLanguage());

String userid = user.getUID()+"";

String votingid ="";
String subject ="";
String desc ="";
String ismulti = "" ;
String isother = "" ;
String votingname ="";
String ismultino = "";
String showorder = "";

RecordSet.executeProc("VotingQuestion_SelectByID",questionid);
if(RecordSet.next()){
    votingid = RecordSet.getString("votingid");
    subject = RecordSet.getString("subject");
    desc = RecordSet.getString("description");
    ismulti=RecordSet.getString("ismulti");
    isother = RecordSet.getString("isother");
    ismultino = RecordSet.getString("ismultino");
    showorder = RecordSet.getString("showorder");
    if("0".equals(ismultino)){
      ismultino = "";
    }
}

RecordSet.executeProc("Voting_SelectByID",votingid);
if(RecordSet.next()){
    votingname = RecordSet.getString("subject");
}
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 
    RCMenu += "{����,javascript:onFrmSubmit(),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;

    RCMenu += "{ɾ��,javascript:doDelete(),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;

    RCMenu += "{�ر�,javascript:window.close(),_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<FORM id=frmmain name=frmmain action="VotingQuestionOperation.jsp" method=post onsubmit="return check_form(this,'subject')">
<input type="hidden" name="method" value="edit">
<input type="hidden" name="questionid" value="<%=questionid%>">
<input type="hidden" name="votingid" value="<%=votingid%>">
<TABLE width=100% height=100% border="0" cellspacing="0">
      <colgroup>
        <col width="5">
          <col width="">
            <col width="5">
              <tr>
                <td height="5" colspan="3"></td>
              </tr>
              <tr>
                <td></td>
                <td valign="top">  
                <form name="frmSubscribleHistory" method="post" action="">
                  <TABLE class=Shadow>
                    <tr>
                      <td valign="top">
<table class=viewForm>  
  <TR><TH colSpan=2><div align="left">���ϵ���:<%=votingname%></div></TH></TR>
  <TR style="height: 1px!important;"><TD class=Line1 colSpan=2></TD></TR>
  <tr>
	<td>����</td>
	<td class=field>
	    <input type="input" class="inputStyle" name="subject" onchange="checkinput('subject','subjectspan');checkLength('subject','350','<%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')"  value="<%=Util.toScreenToEdit(subject,user.getLanguage())%>">
	    <span id="subjectspan"></span>
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  <tr>	
	<td>˵��</td>
	<td class=field>
	    <input type="input"  class="inputStyle" name="desc" style="width:80%" value="<%=Util.toScreenToEdit(desc,user.getLanguage())%>">
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  <tr>	
	<td>��ѡ</td>
	<td class=field>
	    <input type="checkbox"   class="inputStyle" name="ismulti" value="1" <%if(ismulti.equals("1")){%> checked <%}%>>
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  <tr>	
	<td><%=SystemEnv.getHtmlLabelName(21725,user.getLanguage())%></td>
	<td class=field>
	    <input type="input" class="inputStyle" name="ismultino" style="width:20%" value="<%=Util.toScreenToEdit(ismultino,user.getLanguage())%>">
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  <tr>	
	<td>��������</td>
	<td class=field>
	    <input type="checkbox"  class="inputStyle" name="isother" value="1" <%if(isother.equals("1")){%> checked <%}%>>
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
  <tr>	
	<td><%=SystemEnv.getHtmlLabelName(88,user.getLanguage())%></td>
	<td class=field>
	    <input type="input" class=inputStyle name="showorder" value="<%=showorder%>" style="width=20%">
	</td>
  </tr>
  <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>
</table>  

                     </td>
                    </tr>
                  </TABLE>  
                  </form>
                </td>
                <td></td>
              </tr>
              <tr>
                <td height="5" colspan="3"></td>
              </tr>
            </table>
</body>


<script language=javascript>
 function doDelete(){
	if(confirm("�Ƿ�ɾ�������⣿�������µ�ѡ��Ҳ��ͬʱ��ɾ����")) {
		document.frmmain.method.value="delete";
		document.frmmain.submit();
	}
}
function onFrmSubmit(){
	    if(check_form(document.frmmain,"subject")){
			document.frmmain.submit();
		}
}
</script>
</html>