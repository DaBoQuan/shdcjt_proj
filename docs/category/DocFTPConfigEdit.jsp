<%@ page language="java" contentType="text/html; charset=GBK" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>

<%
	boolean canEdit = false;
    if(!HrmUserVarify.checkUserRight("DocFTPConfigEdit:Edit", user)){
		response.sendRedirect("/notice/noright.jsp");
		return;
    }else{
		canEdit = true;
	}
%>
<html><head>
<link href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver.js"></script>

</head>

<%
    int id = Util.getIntValue(request.getParameter("id"),0);
    String FTPConfigName="";
    String FTPConfigDesc="";
    String serverIP="";
    String serverPort="";
    String userName="";
    String userPassword="";
    String defaultRootDir="";
    int maxConnCount=0;
    float showOrder=0;
	
	RecordSet.executeSql("select * from DocFTPConfig where id=" + id);
	if(RecordSet.next()){
		FTPConfigName = Util.null2String(RecordSet.getString("FTPConfigName"));
		FTPConfigDesc = Util.null2String(RecordSet.getString("FTPConfigDesc"));
		serverIP = Util.null2String(RecordSet.getString("serverIP"));
		serverPort = Util.null2String(RecordSet.getString("serverPort"));
		userName = Util.null2String(RecordSet.getString("userName"));
		userPassword = Util.null2String(RecordSet.getString("userPassword"));
		defaultRootDir = Util.null2String(RecordSet.getString("defaultRootDir"));
		maxConnCount = Util.getIntValue(RecordSet.getString("maxConnCount"),0);
		showOrder = Util.getFloatValue(RecordSet.getString("showOrder"),0);
	}

String imagefilename = "/images/hdMaintenance.gif";
String titlename =SystemEnv.getHtmlLabelName(20518,user.getLanguage())+"��"+FTPConfigName;
String needfav ="1";
String needhelp ="";
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:history.go(-1),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
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
		<table class=Shadow>
		<tr>
		<td valign="top">

<form id=weaver name=weaver action="UploadDocFTPConfig.jsp" method=post enctype="multipart/form-data">

<br>

      <TABLE class=ViewForm>
        <TBODY>
	    <COLGROUP>
	    <COL width="20%">
	    <COL width="80%">
        <TR class=Title>
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(20518,user.getLanguage())%></TH>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=50 size=60 class=InputStyle name="FTPConfigName" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%>" value="<%=FTPConfigName%>" onChange="checkinput('FTPConfigName','FTPConfigNamespan')"><%}else{%><%=FTPConfigName%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcFTPConfigName" value="<%=FTPConfigName%>"><%}%>
          <SPAN id=FTPConfigNamespan><%if(FTPConfigName.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
        </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=100 size=60 class=InputStyle name="FTPConfigDesc" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%>" value="<%=FTPConfigDesc%>" ><%}else{%><%=FTPConfigDesc%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcFTPConfigDesc" value="<%=FTPConfigDesc%>"><%}%>
          </TD>
        </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(110,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=100 size=60 class=InputStyle name="serverIP" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(110,user.getLanguage())%>" value="<%=serverIP%>" onChange="checkinput('serverIP','serverIPspan')"><%}else{%><%=serverIP%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcserverIP" value="<%=serverIP%>"><%}%>
          <SPAN id=serverIPspan><%if(serverIP.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
        </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18782,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=5 size=60 class=InputStyle name="serverPort" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18782,user.getLanguage())%>" value="<%=serverPort%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("serverPort");checkinput("serverPort","serverPortSpan")' onChange="checkinput('serverPort','serverPortspan')" ><%}else{%><%=serverPort%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcserverPort" value="<%=serverPort%>"><%}%>
          <SPAN id=serverPortspan><%if(serverPort.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
         </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(2072,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=50 size=60 class=InputStyle name="userName" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(2072,user.getLanguage())%>" value="<%=userName%>" onChange="checkinput('userName','userNamespan')"><%}else{%><%=userName%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcuserName" value="<%=userName%>"><%}%>
          <SPAN id=userNamespan><%if(userName.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
         </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(409,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=100 size=60 type="PASSWORD"  name="userPassword" class=InputStyle  temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(409,user.getLanguage())%>" value="<%=userPassword%>" onChange="checkinput('userPassword','userPasswordspan')"><%}else{%><%=userPassword%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcuserPassword" value="<%=userPassword%>"><%}%>
          <SPAN id=userPasswordspan><%if(userPassword.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
         </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18476,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=100 size=60 class=InputStyle name="defaultRootDir" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(18476,user.getLanguage())%>" value="<%=defaultRootDir%>" onChange="checkinput('defaultRootDir','defaultRootDirspan')"><%}else{%><%=defaultRootDir%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcdefaultRootDir" value="<%=defaultRootDir%>"><%}%>
          <SPAN id=defaultRootDirspan><%if(defaultRootDir.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle>
          <%}%></SPAN></TD>
         </TR>
		<TR><TD class=Line colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20522,user.getLanguage())%></TD>
          <TD class=Field><%if(canEdit){%><INPUT maxLength=5 size=60 class=InputStyle name="maxConnCount" temptitle="<%=SystemEnv.getHtmlLabelName(20519,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(20522,user.getLanguage())%>" value="<%=maxConnCount%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("maxConnCount");checkinput("maxConnCount","maxConnCountSpan")' onchange='checkinput("maxConnCount","maxConnCountSpan")'  ><%}else{%><%=maxConnCount%><%}%>
         <%if(canEdit){%><INPUT type="hidden" size=60 class=InputStyle name="srcmaxConnCount" value="<%=maxConnCount%>"><%}%>
          <SPAN id=maxConnCountSpan></SPAN></TD>
         </TR>
		<TR><TD class=Line colSpan=2></TD></TR>

          <TR>
            <TD><%=SystemEnv.getHtmlLabelName(88,user.getLanguage())%></TD>
            <TD class=Field>
              <INPUT class=InputStyle name=showOrder temptitle="<%=SystemEnv.getHtmlLabelName(88,user.getLanguage())%>" size=7 maxlength=7 value="<%=showOrder%>"   onKeyPress='ItemDecimal_KeyPress("showOrder",6,2)'  onBlur='checknumber("showOrder");checkDigit("showOrder",6,2);checkinput("showOrder","showOrderImage")' onchange='checkinput("showOrder","showOrderImage")'>
              <SPAN id=showOrderImage></SPAN>
            </TD>
          </TR>
         <TR><TD class=Line colSpan=2></TD></TR>		


        </TBODY></TABLE>




<input type=hidden name=operation>
<input type=hidden name=id value="<%=id%>">
</form>

		</td>
		</tr>
		</table>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
</body>

<script>
function onSave(){
	if(check_form(document.weaver,'FTPConfigName,serverIP,serverPort,userName,userPassword,defaultRootDir,maxConnCount,showOrder')){

		document.weaver.operation.value='edit';
		document.weaver.submit();
	}
}


/*
p�����ȣ�
ָ��С������ߺ��ұ߿��Դ洢��ʮ�������ֵ������������ȱ����Ǵ� 1 ����󾫶�֮���ֵ����󾫶�Ϊ 38��

s��С��λ����
ָ��С�����ұ߿��Դ洢��ʮ�������ֵ���������С��λ�������Ǵ� 0 �� p ֮���ֵ��Ĭ��С��λ���� 0����� 0 <= s <= p�����洢��С���ھ��ȶ��仯��
*/
function checkDigit(elementName,p,s){
	tmpvalue = document.all(elementName).value;

    var len = -1;
    if(elementName){
		len = tmpvalue.length;
    }

	var integerCount=0;
	var afterDotCount=0;
	var hasDot=false;

    var newIntValue="";
	var newDecValue="";
    for(i = 0; i < len; i++){
		if(tmpvalue.charAt(i) == "."){ 
			hasDot=true;
		}else{
			if(hasDot==false){
				integerCount++;
				if(integerCount<=p-s){
					newIntValue+=tmpvalue.charAt(i);
				}
			}else{
				afterDotCount++;
				if(afterDotCount<=s){
					newDecValue+=tmpvalue.charAt(i);
				}
			}
		}		
    }

    var newValue="";
	if(newDecValue==""){
		newValue=newIntValue;
	}else{
		newValue=newIntValue+"."+newDecValue;
	}
    document.all(elementName).value=newValue;
}
</script>
