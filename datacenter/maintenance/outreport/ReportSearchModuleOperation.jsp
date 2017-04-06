<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ConditionComInfo" class="weaver.datacenter.ConditionComInfo" scope="page" />

<%


String operation = Util.null2String(request.getParameter("operation"));
String modileid = Util.null2String(request.getParameter("modileid"));
String outrepid = Util.null2String(request.getParameter("outrepid"));
String systemset = Util.null2String(request.getParameter("systemset"));
String modulename = Util.fromScreen(request.getParameter("modulename"),user.getLanguage());
String moduleenname = Util.null2String(request.getParameter("moduleenname"));
String moduledesc = Util.fromScreen(request.getParameter("moduledesc"),user.getLanguage());
String isuserdefines[] = request.getParameterValues("isuserdefine");

ArrayList isuserdefinearr = new ArrayList() ;
if( isuserdefines != null ) {
    for( int i=0 ; i<isuserdefines.length ; i++ ) isuserdefinearr.add(Util.null2String(isuserdefines[i])) ;
}

//��ѯ��, ��, �� ��condition id , ֻҪ����,����,��������һ��Ϊ�û�ѡ��, �����е�Ϊ�û�ѡ��,ͬ����,����,����
ArrayList datefromconditions = new ArrayList() ;
ArrayList datetoconditions = new ArrayList() ;
boolean datefromisuserdefine =  false ;
boolean datetoisuserdefine =  false ;

RecordSet.executeProc("T_OutRC_SelectByOutrepid",""+outrepid);
while(RecordSet.next()) {
    String tempconditionid = Util.null2String(RecordSet.getString("conditionid")) ;
    String tempfieldname = ConditionComInfo.getConditionitemfieldnames(tempconditionid) ;
    
    if( tempfieldname.equals("yearf") || tempfieldname.equals("monthf") || tempfieldname.equals("dayf") ) {
        datefromconditions.add(tempconditionid) ;
        if( isuserdefinearr.indexOf( tempconditionid ) != -1 ) datefromisuserdefine = true ;
    }
    else if( tempfieldname.equals("yeart") || tempfieldname.equals("montht") || tempfieldname.equals("dayt") ) {
        datetoconditions.add(tempconditionid) ;
        if( isuserdefinearr.indexOf( tempconditionid ) != -1 ) datetoisuserdefine = true ;
    }
}

if( datefromisuserdefine ) {
    for( int i=0 ; i< datefromconditions.size() ; i++ ) {
        isuserdefinearr.add((String)datefromconditions.get(i) ) ;
    }
}

if( datetoisuserdefine ) {
    for( int i=0 ; i< datetoconditions.size() ; i++ ) {
        isuserdefinearr.add((String)datetoconditions.get(i) ) ;
    }
}

//  ��ѯ��, ��, �� ��condition id �жϽ���

        

// ���systemset Ϊ1 ��Ϊϵͳ����Ա���õ�ģ�壬 ����Ϊ�û��Զ����ģ��
String userid = "0" ;
String usertype = "0" ;

if( !systemset.equals("1") ) {
    userid = "" + user.getUID();
    usertype = user.getLogintype() ;
}

char separator = Util.getSeparator() ;
String para = "" ;


if(operation.equals("add")){
    
    // �½�ģ����Ϣ
    para = outrepid + separator + modulename + separator + moduledesc + separator + userid + separator + usertype + separator + moduleenname;

    RecordSet.executeProc("T_outrepmodule_Insert",para);
    if( RecordSet.next() ) modileid = ""+ Util.getIntValue(RecordSet.getString(1),0) ;
    
    // �½�ģ������
    RecordSet.executeProc("T_OutRC_SelectByOutrepid",""+outrepid);

    while(RecordSet.next()) {
        String tempconditionid = Util.null2String(RecordSet.getString("conditionid")) ;
        String tempfieldname = ConditionComInfo.getConditionitemfieldnames(tempconditionid) ;
        String issystemdef = Util.null2String(ConditionComInfo.getIssystemdef(tempconditionid)) ;

        if( isuserdefinearr.indexOf(tempconditionid) != -1 ) {  // ��Ҫ�û���д
            para = modileid + separator + tempconditionid + separator + tempfieldname + separator + "1" + separator + "" ;  
            
            RecordSet.executeProc("T_modulecondition_Insert",para);
        }


        else {         // �õ�ģ���ֵ�������� 
            String tempfiledvalue = ""; 
            String tempfileddspname = "" ;
            String tempfileddspenname = "" ;
            String tempfiledcrmname = "" ;
            String tempfiledcrmenname = "" ;

            if(!issystemdef.equals("1") && (tempfieldname.toUpperCase()).indexOf("CRM")==0) { // �Զ����crm��
                ArrayList tempfileddspnames = new ArrayList() ;
                ArrayList tempfileddspennames = new ArrayList() ;
                ArrayList tempfileddspvalues = new ArrayList() ;
                ArrayList tempfiledcrmnames = new ArrayList() ;
                ArrayList tempfiledcrmennames = new ArrayList() ;

                RecordSet1.executeSql("select * from T_ConditionDetail where conditionid = " + tempconditionid ) ;
                while(RecordSet1.next()) {
                    String conditiondsp = Util.null2String(RecordSet1.getString("conditiondsp")) ;
                    String conditionendsp = Util.null2String(RecordSet1.getString("conditionendsp")) ;
                    String conditionvalue = Util.null2String(RecordSet1.getString("conditionvalue")) ;

                    tempfileddspnames.add(conditiondsp) ;
                    tempfileddspennames.add(conditionendsp) ;
                    tempfileddspvalues.add(conditionvalue) ;

                    String tempcrmnames = "" ;
                    String tempcrmennames = "" ;
                    String tempcrmsql = "select name , engname from CRM_CustomerInfo where crmcode like '" + conditionvalue + "' " ;
                    
                    rs1.executeSql(tempcrmsql) ;
                    while(rs1.next()) {
                        if(tempcrmnames.equals("")) tempcrmnames = Util.null2String(rs1.getString(1)) ;
                        else tempcrmnames += "��" +Util.null2String(rs1.getString(1)) ;

                        if(tempfiledcrmenname.equals("")) tempcrmennames = Util.null2String(rs1.getString(2)) ;
                        else tempcrmennames += "��" +Util.null2String(rs1.getString(2)) ;
                    }
                    tempfiledcrmnames.add(tempcrmnames) ;
                    tempfiledcrmennames.add(tempcrmennames) ;
                }

                String tempfiledvalues[] = request.getParameterValues(tempfieldname) ;
                if(tempfiledvalues!=null) {
                    for(int i=0 ; i<tempfiledvalues.length; i++) {
                        String thefiledvalue = tempfiledvalues[i] ;
                        int filedvalueindex = tempfileddspvalues.indexOf(thefiledvalue) ;
                        if( filedvalueindex == -1 ) continue ;
                        else {
                            if(tempfileddspname.equals("")) {
                                tempfileddspname = (String)tempfileddspnames.get(filedvalueindex) ;
                            }
                            else {
                                tempfileddspname += ","+(String)tempfileddspnames.get(filedvalueindex) ;
                            }

                            if(tempfileddspenname.equals("")) {
                                tempfileddspenname = (String)tempfileddspennames.get(filedvalueindex) ;
                            }
                            else {
                                tempfileddspenname += ","+(String)tempfileddspennames.get(filedvalueindex) ;
                            }

                            if(tempfiledcrmname.equals("")) {
                                tempfiledcrmname = (String)tempfiledcrmnames.get(filedvalueindex) ;
                            }
                            else {
                                tempfiledcrmname += ","+(String)tempfiledcrmnames.get(filedvalueindex) ;
                            }

                            if(tempfiledcrmenname.equals("")) {
                                tempfiledcrmenname = (String)tempfiledcrmennames.get(filedvalueindex) ;
                            }
                            else {
                                tempfiledcrmenname += ","+(String)tempfiledcrmennames.get(filedvalueindex) ;
                            }
                        }

                        if(tempfiledvalue.equals("")) tempfiledvalue = tempfiledvalues[i] ;
                        else tempfiledvalue += ","+tempfiledvalues[i] ;
                    }
                }
            }
            else tempfiledvalue = Util.fromScreen(request.getParameter(tempfieldname),user.getLanguage());

            para = modileid + separator + tempconditionid + separator + tempfieldname + separator + "0" + separator + tempfiledvalue ;  
            
            RecordSet.executeProc("T_modulecondition_Insert",para);

            if((tempfieldname.toUpperCase()).indexOf("CRM") >= 0) {  // ����ǿͻ���ģ�壬 Ӧ�ò�������ֵ
                if( !issystemdef.equals("1") ) {
                    tempfiledvalue = "7_"+tempfileddspname ;
                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    if(!tempfileddspenname.equals("")) tempfiledvalue = "8_"+tempfileddspenname ;
                    else tempfiledvalue = "8_"+tempfileddspname ;

                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    tempfiledvalue = "7_"+tempfiledcrmname ;
                    para = modileid + separator + tempconditionid + separator + "namecrm_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    if(!tempfiledcrmenname.equals("")) tempfiledvalue = "8_"+tempfiledcrmenname ;
                    else tempfiledvalue = "8_"+tempfiledcrmname ;

                    para = modileid + separator + tempconditionid + separator + "namecrm_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                }
                else {
                    tempfiledvalue = Util.fromScreen(request.getParameter("name_"+tempfieldname),user.getLanguage());

                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);
                }
            }
        }
    }

    response.sendRedirect("ReportSearchModule.jsp?outrepid="+outrepid+"&systemset="+systemset);
}

else if(operation.equals("edit")){
    
    // �༭ģ����Ϣ
    para = modileid + separator + modulename + separator + moduledesc  + separator + moduleenname;

    RecordSet.executeProc("T_outrepmodule_Update",para);
    
    // ɾ��ģ������
    RecordSet.executeProc("T_modulecondition_Delete",modileid);

    // �½�ģ������
    RecordSet.executeProc("T_OutRC_SelectByOutrepid",""+outrepid);

    while(RecordSet.next()) {
        String tempconditionid = Util.null2String(RecordSet.getString("conditionid")) ;
        String tempfieldname = ConditionComInfo.getConditionitemfieldnames(tempconditionid) ;
        String issystemdef = Util.null2String(ConditionComInfo.getIssystemdef(tempconditionid)) ;

        if( isuserdefinearr.indexOf(tempconditionid) != -1 ) {  // ��Ҫ�û���д
            para = modileid + separator + tempconditionid + separator + tempfieldname + separator + "1" + separator + "" ;  
            
            RecordSet.executeProc("T_modulecondition_Insert",para);
        }


        else {         // �õ�ģ���ֵ�������� 
            String tempfiledvalue = ""; 
            String tempfileddspname = "" ;
            String tempfileddspenname = "" ;
            String tempfiledcrmname = "" ;
            String tempfiledcrmenname = "" ;
            
            if(!issystemdef.equals("1") && (tempfieldname.toUpperCase()).indexOf("CRM")==0) { // �Զ����crm��
                ArrayList tempfileddspnames = new ArrayList() ;
                ArrayList tempfileddspvalues = new ArrayList() ;
                ArrayList tempfileddspennames = new ArrayList() ;
                ArrayList tempfiledcrmnames = new ArrayList() ;
                ArrayList tempfiledcrmennames = new ArrayList() ;


                RecordSet1.executeSql("select * from T_ConditionDetail where conditionid = " + tempconditionid ) ;
                while(RecordSet1.next()) {
                    String conditiondsp = Util.null2String(RecordSet1.getString("conditiondsp")) ;
                    String conditionendsp = Util.null2String(RecordSet1.getString("conditionendsp")) ;
                    String conditionvalue = Util.null2String(RecordSet1.getString("conditionvalue")) ;

                    tempfileddspnames.add(conditiondsp) ;
                    tempfileddspennames.add(conditionendsp) ;
                    tempfileddspvalues.add(conditionvalue) ;

                    String tempcrmnames = "" ;
                    String tempcrmennames = "" ;
                    String tempcrmsql = "select name , engname from CRM_CustomerInfo where crmcode like '" + conditionvalue + "' " ;
                    
                    rs1.executeSql(tempcrmsql) ;
                    while(rs1.next()) {
                        if(tempcrmnames.equals("")) tempcrmnames = Util.null2String(rs1.getString(1)) ;
                        else tempcrmnames += "��" +Util.null2String(rs1.getString(1)) ;

                        if(tempcrmennames.equals("")) tempcrmennames = Util.null2String(rs1.getString(2)) ;
                        else tempcrmennames += "��" +Util.null2String(rs1.getString(2)) ;
                    }
                    tempfiledcrmnames.add(tempcrmnames) ;
                    tempfiledcrmennames.add(tempcrmennames) ;
                }

                String tempfiledvalues[] = request.getParameterValues(tempfieldname) ;
                if(tempfiledvalues!=null) {
                    for(int i=0 ; i<tempfiledvalues.length; i++) {
                        String thefiledvalue = tempfiledvalues[i] ;
                        int filedvalueindex = tempfileddspvalues.indexOf(thefiledvalue) ;
                        if( filedvalueindex == -1 ) continue ;
                        else {
                            if(tempfileddspname.equals("")) {
                                tempfileddspname = (String)tempfileddspnames.get(filedvalueindex) ;
                            }
                            else {
                                tempfileddspname += ","+(String)tempfileddspnames.get(filedvalueindex) ;
                            }
                            
                            if(tempfileddspenname.equals("")) {
                                tempfileddspenname = (String)tempfileddspennames.get(filedvalueindex) ;
                            }
                            else {
                                tempfileddspenname += ","+(String)tempfileddspennames.get(filedvalueindex) ;
                            }

                            if(tempfiledcrmname.equals("")) {
                                tempfiledcrmname = (String)tempfiledcrmnames.get(filedvalueindex) ;
                            }
                            else {
                                tempfiledcrmname += ","+(String)tempfiledcrmnames.get(filedvalueindex) ;
                            }

                            if(tempfiledcrmenname.equals("")) {
                                tempfiledcrmenname = (String)tempfiledcrmennames.get(filedvalueindex) ;
                            }
                            else {
                                tempfiledcrmenname += ","+(String)tempfiledcrmennames.get(filedvalueindex) ;
                            }
                        }

                        if(tempfiledvalue.equals("")) tempfiledvalue = tempfiledvalues[i] ;
                        else tempfiledvalue += ","+tempfiledvalues[i] ;
                    }
                }
            }
            else tempfiledvalue = Util.fromScreen(request.getParameter(tempfieldname),user.getLanguage());

            para = modileid + separator + tempconditionid + separator + tempfieldname + separator + "0" + separator + tempfiledvalue ;  
            
            RecordSet.executeProc("T_modulecondition_Insert",para);

            if((tempfieldname.toUpperCase()).indexOf("CRM") >= 0) {  // ����ǿͻ���ģ�壬 Ӧ�ò�������ֵ
                if( !issystemdef.equals("1") ) {
                    tempfiledvalue = "7_"+tempfileddspname ;
                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    if(!tempfileddspenname.equals("")) tempfiledvalue = "8_"+tempfileddspenname ;
                    else tempfiledvalue = "8_"+tempfileddspname ;

                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    tempfiledvalue = "7_"+tempfiledcrmname ;
                    para = modileid + separator + tempconditionid + separator + "namecrm_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);

                    if(!tempfiledcrmenname.equals("")) tempfiledvalue = "8_"+tempfiledcrmenname ;
                    else tempfiledvalue = "8_"+tempfiledcrmname ;

                    para = modileid + separator + tempconditionid + separator + "namecrm_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);
                }
                else {
                    tempfiledvalue = Util.fromScreen(request.getParameter("name_"+tempfieldname),user.getLanguage());

                    para = modileid + separator + tempconditionid + separator + "name_"+tempfieldname + separator + "0" + separator + tempfiledvalue ;  
                    
                    RecordSet.executeProc("T_modulecondition_Insert",para);
                }
            }
        }
    }

    response.sendRedirect("ReportSearchModule.jsp?outrepid="+outrepid+"&systemset="+systemset);
}

else if(operation.equals("delete")){
    
    // ɾ��ģ����Ϣ
    RecordSet.executeProc("T_outrepmodule_Delete",modileid);

    // ɾ��ģ������
    RecordSet.executeProc("T_modulecondition_Delete",modileid);

    response.sendRedirect("ReportSearchModule.jsp?outrepid="+outrepid+"&systemset="+systemset);
}



%>
