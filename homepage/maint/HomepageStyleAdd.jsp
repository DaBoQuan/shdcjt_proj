<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
  <head>
    <link href="/css/Weaver.css" type=text/css rel=stylesheet>
  </head>
  
<body>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(19434,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

	RCMenu += "{"+SystemEnv.getHtmlLabelName(309,user.getLanguage())+",javascript:onClose(),_self} " ;
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
			<TABLE  cellspacing="0" cellpadding="0" class="viewform">
			<colgroup>
			<col width="15%">
			<col width="33%">
			<col width="4%">
			<col width="15%">
			<col width="33%">
			<TR>
				<TD colspan=5><B><%=SystemEnv.getHtmlLabelName(18363,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(522,user.getLanguage())%></B></TD>				
			</TR>
			<TR><TD class=line1 colspan=5></TD></TR>
			<TR>
				<TD>��ʽ����</TD>
				<TD ><INPUT TYPE="text" NAME="txtInfoname" class=inputstyle></TD>
				<TD></TD>

				<TD rowspan=2>��ҳ����&nbsp;
				   <SELECT NAME="seleHpbg" onchange="seleChanage(this,this.parentNode.nextSibling,'txtHpbg')">
						<option value=1>ͼƬ</option>
						<option value=2>��ɫ</option>
					</SELECT>
				</TD>
				<TD rowspan=2>
					<span>
						<INPUT TYPE="file" NAME="txtHpbg" class=inputstyle onchange="fileChanage(this)">&nbsp;&nbsp;
					<span>
					<img style="display:none">
			    </TD>
				
			</TR>
			<TR><TD class=line colspan=5></TD></TR>
			<TR>
				<TD>��ʽ����</TD>
				<TD><INPUT TYPE="text" NAME="txtInfodesc" class=inputstyle width="80%"></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR><TD colspan=5 height=15px></TD></TR>

			<TR>
				<TD colspan=5><B><%=SystemEnv.getHtmlLabelName(19408,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(522,user.getLanguage())%></B></TD>				
			</TR>
			<TR><TD class=line1 colspan=5></TD></TR>

			<TR>
				<TD>Ԫ�ر���������</TD>
				<TD ></TD>
				<TD></TD>
				<TD>Ԫ�����ݱ���</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR>
				<TD>Ԫ�ر������ɫ</TD>
				<TD ></TD>
				<TD></TD>
				<TD>Ԫ��������ɫ</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR>
				<TD>Ԫ�ر߿���ɫ</TD>
				<TD ></TD>
				<TD></TD>
				<TD>ʱ����ʾ��ʽ</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR>
				<TD>������ť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>������ť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR>
				<TD>��������ť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>��������ť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>

			<TR>
				<TD>ˢ�°�ť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>ˢ�°�ť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>


			<TR>
				<TD>���ð�ť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>���ð�ť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>



			<TR>
				<TD>�رհ�ť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>�رհ�ť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>


			<TR>
				<TD>���ఴť1</TD>
				<TD ></TD>
				<TD></TD>
				<TD>���ఴť2</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>


			<TR>
				<TD>ÿ�зָ���</TD>
				<TD ></TD>
				<TD></TD>
				<TD>ÿ��ǰ��Сͼ��</TD>
				<TD ></TD>
			</TR>
			<TR><TD class=line colspan=5></TD></TR>
			</TABLE>


			<TABLE class="viewform"  cellspacing="0" cellpadding="0" >
			<TR><TD colspan=2 height=15px></TD></TR>
			<TR>
				<TD colspan=2><B>����˵��</B></TD>				
			</TR>
			<TR><TD class=line1 colspan=2></TD></TR>
			<TR>
				<TD></TD>	
				
				<TD></TD>
			</TR>
			<TR><TD class=line colspan=2></TD></TR>
			</TABLE>
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td height="10" colspan="3"></td>
	</tr>
	</table>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
function onSave(){
}

function onClose(){
}

function seleChanage(obj1,obj2,obj3Name){
	if(obj1.value==1) obj2.innerHTML="<input type=file class=inputstyle name="+obj3Name+">";
	else obj2.innerHTML="<input type=text class=inputstyle name="+obj3Name+">";
}
function fileChanage(obj){
	imgobj=obj.parentNode.nextSibling;
	alert(imgobj.tagName)
	if(obj.value='') imgobj.style.display='none';
	else {
		imgobj.src=obj.value;
		imgobj.style.display='';

	}
}
</SCRIPT>