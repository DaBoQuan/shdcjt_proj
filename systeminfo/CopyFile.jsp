<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>



<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdSystem.gif";
String titlename = "�ļ��ƶ�����" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<DIV class=HdrProps>
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>�ļ�����</TH>
    </TR>
    </TBODY> 
  </TABLE>
</DIV>


<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="CopyFileOperation.jsp">
<div>
<BUTTON class=btn id=btnCopy accessKey=C name=btnSave type=submit onSubmit="return check_form(this,'Needmovefilelist,NEWFILEPATH,SYSFILEPATH')"><U>C</U>-����</BUTTON> 
<BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-����</BUTTON> 
</div>    <br>
   
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>�����ļ��б�</td>
      <td class=Field> 
        <input name=Needmovefilelist  size=80 value="" type='file'  onchange='checkinput("Needmovefilelist","Needmovefilelistimage")'>
        <SPAN id=Needmovefilelistimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
      </td>
    </tr>
    <tr> 
      <td>Դ�ļ���Ŀ¼</td>
      <td class=Field> 
        <input name=NEWFILEPATH  size=80 value="" type='file' onchange='checkinput("NEWFILEPATH","NEWFILEPATHimage")'>
        <SPAN id=NEWFILEPATHimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
      </td>
    </tr>
    <tr> 
      <td>Ŀ���ļ���Ŀ¼</td>
      <td class=Field> 
        <input name=SYSFILEPATH  size=80 value="" type='file' onchange='checkinput("SYSFILEPATH","SYSFILEPATHimage")'>
        <SPAN id=SYSFILEPATHimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
      </td>
    </tr>
</BODY>
</HTML>
