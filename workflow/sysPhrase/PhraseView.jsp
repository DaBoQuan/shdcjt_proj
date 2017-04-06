<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />


<HTML>
<HEAD>
	<LINK href = "/css/Weaver.css" type = "text/css" rel="STYLESHEET">
	<SCRIPT language = "javascript" src = "/js/weaver.js"></script>
</HEAD>
<%  
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = SystemEnv.getHtmlLabelName(17561,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(367,user.getLanguage());
	String needfav ="1";
	String needhelp ="";

	String phraseId = Util.null2String(request.getParameter("phraseId"));	
	rs.executeSql("select * from sysPhrase where hrmid="+user.getUID()+" and id="+phraseId) ;
	String phraseShort = "" ;
	String phraseDesc = "" ;
	if (rs.next()) {
		phraseShort = Util.null2String(rs.getString("phraseShort"));
		phraseDesc = Util.null2String(rs.getString("phraseDesc"));
	}else{
        response.sendRedirect("/notice/noright.jsp");
        return ;
    }

%>
	<BODY>
	<%@ include file="/systeminfo/TopTitle.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
	<%

	   RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+",javascript:onEdit()',_self} " ;
			RCMenuHeight += RCMenuHeightStep;

		RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDelete()',_self} " ;
					RCMenuHeight += RCMenuHeightStep;
       //TD25798
	   //	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",javascript:location='PhraseAdd.jsp',_self} " ;
	  //	RCMenuHeight += RCMenuHeightStep;


		//RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.go(-1),_self} " ;
		RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/workflow/sysPhrase/PhraseList.jsp?log=n&phraseId="+ phraseId +",_self} " ;
	 //TD25798		
		RCMenuHeight += RCMenuHeightStep;
     %>

	<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<FORM  NAME ="frmView" method="post">
		<INPUT type="hidden" name="operation">	
		<INPUT type="hidden" name="phraseId" value="<%=phraseId%>">	
    <TABLE class=ViewForm  width="100%">
	<br>
	 <colgroup>
		<col width="15%">
		<col width="85%">
		<TR>
			<TD><%=SystemEnv.getHtmlLabelName(18774,user.getLanguage())%></TD>
			<TD class="field"><%=phraseShort%></TD>
			
		<!-- �˴�Ҫ�� ��tr����߶� 2012-0-08-20 ypc �޸� -->
		<TR style="height:4%">
			<TD class=Line colspan=2></TD>
		</TR>
		<TR>		
			<TD><%=SystemEnv.getHtmlLabelName(18775,user.getLanguage())%></TD>
			<TD class="field"><%=phraseDesc%></TD>		
		<TR>		
    </TABLE>
	</FORM>
	</BODY>	
	<script language=javascript>
		//2012-08-20 ypc �޸� ����ע�͵� ������
		function onEdit() {
			//window.frmView.action="PhraseEdit.jsp" ;
			//window.frmView.submit();
			document.all("frmView").action="PhraseEdit.jsp";
			document.all("frmView").submit();
		}
		function onDelete() {
			//window.frmView.action="PhraseOperate.jsp" ;
			//window.frmView.operation.value="delete" ;
			//window.frmView.submit();
			document.all("frmView").action="PhraseOperate.jsp";
			document.all("frmView").operation.value="delete";
			document.all("frmView").submit();
		}
	</script>
</HTML>
