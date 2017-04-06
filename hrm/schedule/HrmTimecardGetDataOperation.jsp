<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ page import="java.util.* , java.io.* , weaver.general.Util,weaver.file.*" %>
<%@ page import="weaver.general.SendMail" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="RecordSet" class = "weaver.conn.RecordSet" scope = "page"/>
<jsp:useBean id="SendMail" class="weaver.general.SendMail" scope="page" />
<jsp:useBean id="HrmKqSystemComInfo" class="weaver.hrm.schedule.HrmKqSystemComInfo" scope="page" />
<jsp:useBean id="SystemComInfo" class="weaver.system.SystemComInfo" scope="page" />

<%
User user = HrmUserVarify.getUser (request , response);
if(user == null)  return ;
String result = Util.null2String(request.getParameter("cardData")) ; //�򿨻�����
String errMsg = Util.null2String(request.getParameter("cardError")) ; //��򿨻���صĴ������
String subject = "" ; //�ʼ������⣨����ISO8859�����ʽ��

String countindex = Util.null2String(request.getParameter("countindex")) ;

String defmailserver = Util.null2String(SystemComInfo.getDefmailserver()) ;
String defmailfrom = Util.null2String(SystemComInfo.getDefmailfrom()) ;
String defneedauth = Util.null2String(SystemComInfo.getDefneedauth()) ;
String defmailuser = Util.null2String(SystemComInfo.getDefmailuser()) ;
String defmailpassword = Util.null2String(SystemComInfo.getDefmailpassword()) ;
String tosomeone = Util.null2String(HrmKqSystemComInfo.getTosomeone()) ;



if(!errMsg.equals("")) { //�򿨻��Ĵ���
    //��errMsg����Ӧ�Ĵ��󸳸�subject
    if(errMsg.equals("-1")){
        subject = "ָ���Ĵ��ڲ�����" ; 
    }else if(errMsg.equals("-2")){
        subject = "ָ���Ĵ����Ѿ��������豸��" ; 
    }else if(errMsg.equals("-3")){ 
        subject = "�������ӳ�ʱ" ; 
    }else if(errMsg.equals("-4")){ 
        subject = "����û�д�" ; 
    }else if(errMsg.equals("-5")){ 
        subject = "510�˵İ汾����3.00��" ; 
    }else if(errMsg.equals("-6")){ 
        subject = "�ļ���ʧ��" ; 
    }else if(errMsg.equals("-7")){ 
        subject = "�޷��ﵽָ��IP" ; 
    }else if(errMsg.equals("-8")){ 
        subject = "Socket��ʼ������" ; 
    } else if(errMsg.equals("-9")){ 
        subject = "Socket�������� " ; 
    } else if(errMsg.equals("-10")) { 
        subject = "�޷�����Զ���ն˵�����" ; 
    }else if(errMsg.equals("-11")){ 
        subject = "Socket���ó���" ; 
    }else if(errMsg.equals("-12")){ 
        subject = "Socket����ʱ��ʱ" ; 
    }else if(errMsg.equals("-13")){ 
        subject = "�����ϵͳ����.�������ֲ���510֧��" ; 
    }else if(errMsg.equals("-14")){ 
        subject = "ָ��̨�Ų�����" ; 
    }else if(errMsg.equals("-15")){
        subject = "��¼������" ; 
    }else if(errMsg.equals("-16")){
        subject = "����ʧ��" ; 
    }else if(errMsg.equals("-17")){
        subject = "CRCУ�����" ; 
    }

    SendMail.setMailServer(defmailserver) ;
    if( defneedauth.equals("1") ) {
        SendMail.setNeedauthsend(true) ;
        SendMail.setUsername(defmailuser) ;
        SendMail.setPassword(defmailpassword) ;
    }
    else SendMail.setNeedauthsend(false) ;

    if( !tosomeone.equals("") ) {
        String to = tosomeone ; //�ʼ����ռ��� 
        String cc = "" ; //�ʼ��ĳ�����

        String bcc = "" ; //�ʼ��İ�����
        String body = "������Ϣ��" + subject ; //�ʼ������ģ�����ISO8859�����ʽ��
        String priority = "4" ; // �ʼ�����Ҫ�Բ��� 3����ͨ 2����Ҫ 4������
        SendMail.send(defmailfrom , to , cc , bcc , subject , body , priority) ; 

        response.sendRedirect("HrmDataCollect.jsp?MSG=ERR&countindex="+countindex) ; 
        return ;
    }

} else {
    // �ҳ���Ӧ�û��б���뻺��
    ArrayList resourceids = new ArrayList() ;
    ArrayList usercodes = new ArrayList() ;

    RecordSet.executeSql("select * from HrmTimecardUser ") ;
    while ( RecordSet.next() ) {
        String resourceid = Util.null2String(RecordSet.getString("resourceid")) ;
        String usercode = Util.null2String(RecordSet.getString("usercode")) ;
        resourceids.add( resourceid ) ;
        usercodes.add( usercode ) ;
    }

    StringTokenizer st = new StringTokenizer(result , ",") ; 
    String s = "" ; 
    boolean issuccess = true ; 
    while(st.hasMoreTokens()){
        s = (st.nextToken()).trim() ;      
        if( s.length() < 28 ) continue ;

        char separator = Util.getSeparator() ; 

        String workshift = s.substring(16 , 17) ; //����
        String stationid = s.substring(1 , 3) ; //���ӵ�̨��
        String Cardid = s.substring(23 , 28) ; //����

/*        String Cardid = s.substring(24 , 28) ; //����
        Cardid = "" + Integer.parseInt( Cardid ,16) ;  // ��16����ת��Ϊ10����  */
        String tempdate = s.substring(3 , 11) ; 
        String temptime = s.substring(11 , 15) ; 

        String carddate = tempdate.substring(0 , 4) + "-" + 
                          tempdate.substring(4 , 6) + "-" +
                          tempdate.substring(6 , 8) ;      //�����ڣ���ʽ��yyyy-mm-dd
       
        String cardtime = temptime.substring(0 , 2) + ":" + 
                          temptime.substring(2 , 4) ;      //��ʱ�䣬��ʽ��hh:nn
        String procedurepara = stationid + separator + carddate + separator + cardtime + separator + workshift + separator + Cardid  ; 

        issuccess = RecordSet.executeProc("HrmCardInfo_Insert" , procedurepara) ; //�жϴ洢�����Ƿ���ȷִ��
        
        int usercodeindex = usercodes.indexOf(Cardid) ;
        if( usercodeindex == -1 ) {
            RecordSet.executeProc("HrmValidateCardInfo_Insert" , procedurepara) ; 
        }
        else {
            
            String resourceid = (String) resourceids.get( usercodeindex ) ;
            procedurepara = resourceid +separator+ carddate +separator+ cardtime +separator + "0" ;
            RecordSet.executeProc("HrmRightCardInfo_Insert",procedurepara);

            /*      
            String resourceid = (String) resourceids.get( usercodeindex ) ;
            procedurepara = resourceid +separator+ carddate +separator+ cardtime +separator+ cardtime ;
            RecordSet.executeProc("HrmTimecardInfo_Update",procedurepara);
            */
        }
    } 

    if(issuccess==true) { 
        response.sendRedirect("HrmDataCollect.jsp?MSG=OK&countindex="+countindex) ; 
        return ;
    } else { //�洢���̴��� 
      
        SendMail.setMailServer(defmailserver) ;
        if( defneedauth.equals("1") ) {
            SendMail.setNeedauthsend(true) ;
            SendMail.setUsername(defmailuser) ;
            SendMail.setPassword(defmailpassword) ;
        }
        else SendMail.setNeedauthsend(false) ;

        if( !tosomeone.equals("") ) {
            subject = "���ݿ�洢����ִ�д���" ; //�ʼ������⣨����ISO8859�����ʽ��
            String to = tosomeone ; //�ʼ����ռ��� 
            String cc = "" ; //�ʼ��ĳ�����

            String bcc = "" ; //�ʼ��İ�����
            String body = "������Ϣ��" + subject ; //�ʼ������ģ�����ISO8859�����ʽ��
            String priority = "4" ; // �ʼ�����Ҫ�Բ��� 3����ͨ 2����Ҫ 4������
            SendMail.send(defmailfrom , to , cc , bcc , subject , body , priority) ; 

            response.sendRedirect("HrmDataCollect.jsp?MSG=ERR&countindex="+countindex) ;
            return ;
        }
    } 
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>���ݲɼ�</TITLE>
</HEAD>
<BODY>
<script language=javascript>
    alert("������Ϣ�� <%=subject%> ") ;
    location.href="HrmDataCollect.jsp?MSG=ERR&countindex=<%=countindex%>" ;
</script>
</body>
</html>
