<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
User user = HrmUserVarify.getUser(request,response);
if(user == null)  return ;
%>
<%
    RecordSet.executeSql("select filerealpath from imagefile where mouldtype = 2 or  mouldtype = 3");
    if (RecordSet.next()) out.println("<br>�ļ���ǰȫ��·��Ϊ��"+Util.null2String(RecordSet.getString(1)));
    RecordSet.executeSql("select mouldpath from DocMouldFile where id = "+1);
    if (RecordSet.next()) out.println("<br>ģ�嵱ǰȫ��·��Ϊ��"+Util.null2String(RecordSet.getString(1)));
    out.println("<br>���Ͻ����ο���");
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>

<BODY>
<DIV class=HdrProps>
  <TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Section> 
      <TH colSpan=2>���ݿ��ļ�·������</TH>
    </TR>
    </TBODY> 
  </TABLE>
</DIV>
<FORM style="MARGIN-TOP: 0px" id=frmMain name=frmMain method=post action="SystemFilePathChangeOperation.jsp">
<div>
<BUTTON class=btn id=btnSave accessKey=S name=btnSave type=button  onClick="onSubmit(this)"><U>S</U>-�ύ</BUTTON> 
<BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-����</BUTTON> 
</div>    <br>
<TABLE class=Form>
    <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY> 
    <TR class=Separator> 
      <TD class=sep1 colSpan=2></TD>
    </TR>   
    <div>
       &nbsp;&nbsp;&nbsp; <font color="red">��ע��: Դ·���еĴ�Сд���������ݿ������һ��!����ִ����Ч</font>
    </div><br>
    <tr> 
      <td>Դ·��(��: D:\fileSystem\)</td>
      <td class=Field> 
        <input accesskey=Z name="srcPath"  maxlength="30">
      </td>
    </tr>
    <tr> 
      <td>Ŀ��·��(��: f:\xyzfileSystem\)</td>
      <td class=Field> 
        <input name="targetPath"  maxlength="30">
      </td>
    </tr>
    </TBODY> 
  </TABLE>
 </FORM>
</BODY>
</HTML>
<script language="javaScript">
    function onSubmit(obj){        
        if (document.frmMain.srcPath.value !='' || document.frmMain.targetPath.value != '') {  
              obj.disabled = true ;
              frmMain.submit();
        } else {
              alert("����д��Դ·����Ŀ��·�������ύ!")  ;
        }
    }
</script>