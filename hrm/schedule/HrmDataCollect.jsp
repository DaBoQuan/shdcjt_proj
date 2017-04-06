<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ page import="java.util.* , java.io.*, weaver.general.Util"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="HrmKqSystemComInfo" class="weaver.hrm.schedule.HrmKqSystemComInfo" scope="page" />
<jsp:useBean id="RecordSet" class = "weaver.conn.RecordSet" scope = "page"/>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
</HEAD>
<BODY onload="doChoose()" onbeforeload="protectDoc()">
<%

String choice = Util.null2String(request.getParameter("MSG")) ; 
String timeinterval = "" + (Util.getIntValue(HrmKqSystemComInfo.getTimeinterval(),60)*60000) ;
String getdatatype = "" + Util.getIntValue(HrmKqSystemComInfo.getDatatype(),1);
String getdatavalue = Util.null2String(HrmKqSystemComInfo.getDatavalue()) ;

// ���ϴ����ֶ�ν�������
int countindex = Util.getIntValue(request.getParameter("countindex"),0) ;

ArrayList getdatavalues = new ArrayList() ;

int counttype = 0 ;

if( getdatatype.equals("1") && !getdatatype.equals("") ) {
    counttype = 1 ;
    getdatavalues.add(getdatavalue) ;
}
else {
    getdatavalues = Util.TokenizerString(getdatavalue, "," ) ;
    counttype = getdatavalues.size() ;
}


String temStr = request.getRequestURI();
temStr=temStr.substring(0,temStr.lastIndexOf("/")+1);
String mClientName="CipheData.ocx";
String mClientUrl ="http://"+Util.getRequestHost(request)+temStr+mClientName;

int countvalidatecard = 0 ;
RecordSet.executeSql("select count(*) from HrmValidateCardInfo ") ;
if( RecordSet.next() ) countvalidatecard = Util.getIntValue( RecordSet.getString(1) , 0) ;

%>

<FORM METHOD=POST ACTION="HrmTimecardGetDataOperation.jsp" name=dataform >
<INPUT TYPE="hidden" name="cardData" value="">
<INPUT TYPE="hidden" name="cardError" value="">
<INPUT TYPE="hidden" name="countindex" value="<%=countindex%>">
</FORM>


<SCRIPT LANGUAGE="JavaScript">
<!--
var issuccess = "<%=choice%>" ;

function protectDoc(){
    window.event.returnValue="<%=SystemEnv.getHtmlLabelName(16742,user.getLanguage())%>";    
}

function doChoose() {
    if(issuccess == "ERR") {
        doBackup() ;
    } else { 
        doReceive() ; 
    }
}
function doBackup(){
    // window.setTimeout("Backup()","<%=timeinterval%>") ; //Ĭ��ʮ����
    Backup() ;  // ���������ݹ���
}
//doBackup() ; 

function Backup () { 
    dataform.cardError.value = "" ;
    dataform.cardData.value = parent.Frame2.databackup.store.value ; 
    dataform.submit() ;
}

function doReceive () { 
    <%if(countindex >= counttype) {
        countindex = 0 ;
    %>
        window.setTimeout("Receive()","<%=timeinterval%>") ; //Ĭ��ʮ����
    <%} else { %>
        Receive() ;
    <%} %>
}

function Receive(){

    var result = "" ;
    var countindex = <%=countindex%> ;
    dataform.cardError.value = "" ;

 
    <% 
        if( getdatatype.equals("1")) { //�������510�Ļ�������5���������������
    %>
            CipheData1.ConnectType = 1 
            CipheData1.ConnectString = "9600" 
            CipheData1.Port = <%=getdatavalues.get(countindex)%> 
            CipheData1.ShowMsg = false 
            CipheData1.Connect();	
    <%  }
        else if( getdatatype.equals("2")) {   //�������350�Ļ�������5���������������
    %>
            CipheData1.ConnectType = 3 
            CipheData1.ConnectString = "<%=getdatavalues.get(countindex)%>"  
            CipheData1.Port = 2 
            CipheData1.ShowMsg = false 
            CipheData1.Connect();
    <%  } %>

    number = CipheData1.GetDataCount() ; //��ȡˢ�����ϵ����ݱ���
    if(number < 0) { 
        errMSG = CipheData1.GetLastErr() ; 
        if(errMSG != 1) {
            dataform.cardError.value = errMSG ; 
        }
    } else { 
        alert("��<%=getdatavalues.get(countindex)%>�ϻ��"+number+"��������") ;
        for(i = 0 ; i <= number ; i ++ ) { 
            field = CipheData1.ReadOneRec() ; //�Ӵ򿨻���ȡһ�����ݣ������ȡ�ɹ����510��ɾ����������
            if(field == "") { 
                errMSG = CipheData1.GetLastErr() ; //��ȡ��������Ľ������,�������ֵΪ1����û�д������������д�����
                /* if(errMSG != 1) {
                    dataform.cardError.value = errMSG ; 
                    break ;
                } */
            } 
            else if(field.indexOf("OVER")>=0) { //"OVER",510�������Ѿ��ɼ����
                break ; 
            }
            else {
                result = result + field ; 
                result = result + "," ; 
            }
        }
     }

     countindex ++ ;   // ��ǰ����1 
     dataform.countindex.value = countindex ; 
     dataform.cardData.value = result ; 
     parent.Frame2.databackup.store.value = result ;  
     dataform.submit() ; 
}
//-->
</SCRIPT>
<P>
<div align=center>

  <table border="0" cellspacing="0" cellpadding="3">
    <tr>
      <td><img src="/images/getcardinfo.gif" width="402" height="124"> </td>
  </tr>
</table>
</div>

<OBJECT id=CipheData1 classid=clsid:A10009EC-93E0-11D6-9A05-00D0099D6D84 codebase="<%=mClientUrl%>">
	<PARAM NAME="_Version" VALUE="65536">
	<PARAM NAME="_ExtentX" VALUE="1058">
	<PARAM NAME="_ExtentY" VALUE="1058">
	<PARAM NAME="_StockProps" VALUE="0">
	<PARAM NAME="ConnectString" VALUE="9600">
	<PARAM NAME="ConnectType" VALUE="1">
	<PARAM NAME="ShowMsg" VALUE="0">
	<PARAM NAME="Port" VALUE="1">
</OBJECT>
</P>

<% if( countvalidatecard > 0 ) {%>
<table border="0" cellspacing="0" cellpadding="3" align=center>
    <tr>
      <td align=center><font color=red>��ǰ�� <%=countvalidatecard%> ����Ч�Ĵ����� </font></td>
  </tr>
</table>
<% } %>


</BODY>
</HTML>