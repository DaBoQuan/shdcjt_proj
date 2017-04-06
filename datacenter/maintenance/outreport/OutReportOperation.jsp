<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%

String operation = Util.null2String(request.getParameter("operation"));
String outrepid = Util.null2String(request.getParameter("outrepid"));
String outrepname = Util.fromScreen(request.getParameter("outrepname"),user.getLanguage());
String outrepenname = Util.toScreenToEdit(request.getParameter("outrepenname"),user.getLanguage()) ;
String outreprow = Util.null2String(request.getParameter("outreprow"));
String outrepcolumn = Util.null2String(request.getParameter("outrepcolumn"));
String modulefilename = Util.null2String(request.getParameter("modulefilename")); //ģ���ļ�����
String enmodulefilename = Util.null2String(request.getParameter("enmodulefilename")); //ģ���ļ�����
// ���� 2004 ��10��23 ������ģ���ļ�����Ӧ�иߺ��п�
String autocolumn = Util.null2String(request.getParameter("autocolumn")); //�п�
String autorow = Util.null2String(request.getParameter("autorow")); //�и�

String outreptype = Util.null2String(request.getParameter("outreptype")); //��������
String outrepcategory = Util.null2String(request.getParameter("outrepcategory")); /*�������� 0:�̶����� 1����ϸ���� 2:���򱨱�*/
String outrepdesc = Util.fromScreen(request.getParameter("outrepdesc"),user.getLanguage());
String outrependesc = Util.null2String(request.getParameter("outrependesc"));
String userid = Util.null2String(request.getParameter("userid"));
String usertype = Util.null2String(request.getParameter("usertype"));
String outrepshareid = Util.null2String(request.getParameter("outrepshareid"));
String changetype = Util.null2String(request.getParameter("changetype"));
String rowtype = Util.null2String(request.getParameter("rowtype"));
String columntype = Util.null2String(request.getParameter("columntype"));
int addrownum = Util.getIntValue(request.getParameter("addrownum"));
int addcolumnnum = Util.getIntValue(request.getParameter("addcolumnnum"));
int delrownum = Util.getIntValue(request.getParameter("delrownum"));
int delcolumnnum = Util.getIntValue(request.getParameter("delcolumnnum"));

// ͳ�������
int totaldetail1 = Util.getIntValue(request.getParameter("totaldetail1"));
int totaldetail2 = Util.getIntValue(request.getParameter("totaldetail2"));
String outrepitemid = Util.null2String(request.getParameter("outrepitemid"));
String statitemid = Util.null2String(request.getParameter("statitemid"));


if(operation.equals("add")){
	
    char separator = Util.getSeparator() ;

  	
	String para = outrepname + separator + outreprow 
		+ separator + outrepcolumn + separator + outrepdesc + separator + modulefilename  + separator + outreptype + separator + outrepcategory + separator + enmodulefilename + separator + outrepenname + separator + outrependesc + separator + autocolumn + separator + autorow;
	RecordSet.executeProc("T_OutReport_Insert",para);
	
    
 	response.sendRedirect("OutReport.jsp");
 }
 
else if(operation.equals("edit")){
    char separator = Util.getSeparator() ;

    String para = ""+outrepid + separator + outrepname  + separator + outrepdesc + separator + modulefilename  + separator + outreptype + separator + outrepcategory  + separator + enmodulefilename + separator + outrepenname + separator + outrependesc + separator + autocolumn + separator + autorow ;
	RecordSet.executeProc("T_OutReport_Update",para);



    // ����ɾ������Ԥ��������ֵ
    RecordSet.executeSql(" delete T_OutReportCondition where outrepid = " + outrepid);

    for(int i=0 ; i< totaldetail2 ; i++) {
        String conditionid = Util.null2String(request.getParameter("conditionid"+i));
        String conditioncnname = Util.fromScreen(request.getParameter("conditioncnname"+i),user.getLanguage());
        String conditionenname = Util.fromScreen(request.getParameter("conditionenname"+i),user.getLanguage());

        if(!conditionid.equals("")) {
            para = ""+outrepid + separator + conditionid + separator + conditioncnname + separator + conditionenname  ;
	        RecordSet.executeProc("T_OutReportCondition_Insert",para);
        }
    }
    

    // ����ɾ����ϸ����Ԥ����ӱ������ֵ
    if(outrepcategory.equals("1")) {
        RecordSet.executeSql(" update T_OutReport set outreprow = " + outreprow + " where outrepid = " + outrepid );
        RecordSet.executeSql(" delete T_ReportStatSqlValue where outrepid = " + outrepid);
        
        if ( totaldetail1 != 0 ) {
            RecordSet.executeProc("T_ReportStatitemTable_Delete",""+outrepid);

            for(int i=0 ; i< totaldetail1 ; i++) {
                String itemtable = Util.null2String(request.getParameter("itemtable"+i));
                String itemtablealter = Util.null2String(request.getParameter("itemtablealter"+i));
                
                if(!itemtable.equals("") && !itemtablealter.equals("")) {
                    para = ""+outrepid + separator + itemtable + separator + itemtablealter ;
                    RecordSet.executeProc("T_ReportStatitemTable_Insert",para);
                }
            }
        }
    }


    // ���ӱ������Ƿ�������ش�ӡ�Ŀ���
        
    RecordSet.executeSql(" update T_OutReportShare set sharelevel = 0 where outrepid = " + outrepid );
    
    String sharelevels[] = request.getParameterValues("sharelevels") ;

    if(sharelevels != null) {
        String sharelevelstr = "" ;

        for(int i=0 ; i<sharelevels.length ; i++) {
            if(i==0) sharelevelstr = sharelevels[i] ;
            else sharelevelstr += "," + sharelevels[i] ;
        }

        RecordSet.executeSql(" update T_OutReportShare set sharelevel = 1 where outrepshareid in ( " + sharelevelstr + " ) " );
    }

 	response.sendRedirect("OutReport.jsp");
 }

 else if(operation.equals("delete")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepid;
	RecordSet.executeProc("T_OutReport_Delete",para);

 	response.sendRedirect("OutReport.jsp");
 }

 else if(operation.equals("adduser")){
    char separator = Util.getSeparator() ;
    String para = "" ;
    if(!usertype.equals("3") ) {
        para = ""+outrepid + separator + userid  + separator + usertype ;
        RecordSet.executeProc("T_OutReportShare_Insert",para);
    }
    else {
        RecordSet.executeSql(" select resourceid from HrmRoleMembers where roleid="+userid + " and resourceid != 1 " );
        while(RecordSet.next()){
            String tmpresourceid = RecordSet.getString("resourceid");
            para = ""+outrepid + separator + tmpresourceid  + separator + "1" ;
            RecordSet.executeProc("T_OutReportShare_Insert",para);
        }
    }
    
    if ( totaldetail2 != 0 ) {
        // ����ɾ������Ԥ��������ֵ
        RecordSet.executeSql(" delete T_OutReportCondition where outrepid = " + outrepid);

        for(int i=0 ; i< totaldetail2 ; i++) {
            String conditionid = Util.null2String(request.getParameter("conditionid"+i));
            String conditioncnname = Util.fromScreen(request.getParameter("conditioncnname"+i),user.getLanguage());
            String conditionenname = Util.fromScreen(request.getParameter("conditionenname"+i),user.getLanguage());

            if(!conditionid.equals("")) {
                para = ""+outrepid + separator + conditionid + separator + conditioncnname + separator + conditionenname  ;
                RecordSet.executeProc("T_OutReportCondition_Insert",para);
            }
        }
    }

    if ( outrepcategory.equals("1") ) {
        RecordSet.executeSql(" delete T_ReportStatSqlValue where outrepid = " + outrepid);
        if ( totaldetail1 != 0 ) {
            RecordSet.executeProc("T_ReportStatitemTable_Delete",""+outrepid);
            for(int i=0 ; i< totaldetail1 ; i++) {
                String itemtable = Util.null2String(request.getParameter("itemtable"+i));
                String itemtablealter = Util.null2String(request.getParameter("itemtablealter"+i));
                
                if(!itemtable.equals("") && !itemtablealter.equals("")) {
                    para = ""+outrepid + separator + itemtable + separator + itemtablealter ;
                    RecordSet.executeProc("T_ReportStatitemTable_Insert",para);
                }
            }
        }
    }

 	response.sendRedirect("OutReportEdit.jsp?outrepid="+outrepid);
 }

 else if(operation.equals("deleteuser")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepshareid;
	RecordSet.executeProc("T_OutReportShare_Delete",para);
    
    if ( outrepcategory.equals("1") ) {
        RecordSet.executeSql(" delete T_ReportStatSqlValue where outrepid = " + outrepid);
        if ( totaldetail1 != 0 ) {
            RecordSet.executeProc("T_ReportStatitemTable_Delete",""+outrepid);
            for(int i=0 ; i< totaldetail1 ; i++) {
                String itemtable = Util.null2String(request.getParameter("itemtable"+i));
                String itemtablealter = Util.null2String(request.getParameter("itemtablealter"+i));
                
                if(!itemtable.equals("") && !itemtablealter.equals("")) {
                    para = ""+outrepid + separator + itemtable + separator + itemtablealter ;
                    RecordSet.executeProc("T_ReportStatitemTable_Insert",para);
                }
            }
        }
    }

    if ( totaldetail2 != 0 ) {
        // ����ɾ������Ԥ��������ֵ
        RecordSet.executeSql(" delete T_OutReportCondition where outrepid = " + outrepid);

        for(int i=0 ; i< totaldetail2 ; i++) {
            String conditionid = Util.null2String(request.getParameter("conditionid"+i));
            String conditioncnname = Util.fromScreen(request.getParameter("conditioncnname"+i),user.getLanguage());
            String conditionenname = Util.fromScreen(request.getParameter("conditionenname"+i),user.getLanguage());

            if(!conditionid.equals("")) {
                para = ""+outrepid + separator + conditionid + separator + conditioncnname + separator + conditionenname  ;
                RecordSet.executeProc("T_OutReportCondition_Insert",para);
            }
        }
    }
 	response.sendRedirect("OutReportEdit.jsp?outrepid="+outrepid);
 }
 else if(operation.equals("addstatitem")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepid + separator + statitemid  ;
	RecordSet.executeProc("T_OutReportStatitem_Insert",para);

 	response.sendRedirect("OutReportStatitem.jsp?outrepid="+outrepid);
 }
 else if(operation.equals("savestatitem")){
    RecordSet.executeSql("update T_OutReportStatitem set needthismonth = '' , needthisyear = '' , needlastmonth = '' , needlastyear = '' where outrepid = " + outrepid );

    String[] alloutrepitemids = request.getParameterValues("outrepitemids") ;
    if( alloutrepitemids != null ) {
        String theoutrepitemid = "" ;
        String needthismonth = "" ;
        String needthisyear = "" ;
        String needlastmonth = "" ;
        String needlastyear = "" ;

        for(int i=0 ; i<alloutrepitemids.length ; i++) {
            theoutrepitemid = alloutrepitemids[i] ;
            needthismonth = Util.null2String(request.getParameter("needthismonth_"+theoutrepitemid));
            needthisyear = Util.null2String(request.getParameter("needthisyear_"+theoutrepitemid));
            needlastmonth = Util.null2String(request.getParameter("needlastmonth_"+theoutrepitemid));
            needlastyear = Util.null2String(request.getParameter("needlastyear_"+theoutrepitemid));

            RecordSet.executeSql("update T_OutReportStatitem set needthismonth = '"+needthismonth+"' , needthisyear = '"+needthisyear+"' , needlastmonth = '"+needlastmonth+"' , needlastyear = '"+needlastyear+"' where outrepitemid = " + theoutrepitemid );
        }
    }
 	response.sendRedirect("OutReportStatitem.jsp?outrepid="+outrepid);
 }

 else if(operation.equals("deletestatitem")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepitemid;
	RecordSet.executeProc("T_OutReportStatitem_Delete",para);

 	response.sendRedirect("OutReportStatitem.jsp?outrepid="+outrepid);
 }

 else if(operation.equals("uporder")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepitemid + separator + "1"  ; // 1 �������ϵ���
	RecordSet.executeProc("T_OutReportStatitem_Uorder",para);

 	response.sendRedirect("OutReportStatitem.jsp?outrepid="+outrepid);
 }

 else if(operation.equals("downorder")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepitemid + separator + "2"  ; // 2 �������µ���
	RecordSet.executeProc("T_OutReportStatitem_Uorder",para);

 	response.sendRedirect("OutReportStatitem.jsp?outrepid="+outrepid);
 }

 else if(operation.equals("copy")){
    char separator = Util.getSeparator() ;
	String para = ""+outrepid;
	RecordSet.executeProc("T_OutReport_Copy",para);

 	response.sendRedirect("OutReport.jsp");
 }

 else if(operation.equals("change")){
    String sql = "" ;
    int changenum = 0 ;
    char separator = Util.getSeparator() ;
    String para = "" ;

    switch(Util.getIntValue(changetype)) {
        case 1:
            sql = " update T_OutReport set outreprow = outreprow+1 where outrepid = " + outrepid ;
            RecordSet.executeSql(sql);
            
            if(rowtype.equals("1")) changenum = 1 ;
            else changenum = addrownum +1 ;

            sql = " update T_OutReportItem set itemrow = itemrow+1 where itemrow >= " + changenum +" and outrepid = " + outrepid ;
            RecordSet.executeSql(sql);
            break ;
        
        case 2:
            sql = " update T_OutReport set outrepcolumn = outrepcolumn+1 where outrepid = " + outrepid ;
            RecordSet.executeSql(sql);

            if(columntype.equals("1")) changenum = 1 ;
            else changenum = addcolumnnum +1 ;

            sql = " update T_OutReportItem set itemcolumn = itemcolumn+1 where itemcolumn >= " + changenum +" and outrepid = " + outrepid ;
            RecordSet.executeSql(sql);
            break ;

        case 3:
            sql = " update T_OutReport set outreprow = outreprow-1 where outrepid = " + outrepid ;
            RecordSet.executeSql(sql);

            para = ""+outrepid + separator + ""+delrownum  ;
            RecordSet.executeProc("T_OutReportItem_DeleteByRow",para);

            sql = " update T_OutReportItem set itemrow = itemrow-1 where itemrow > " + delrownum +" and outrepid = " + outrepid ;
            RecordSet.executeSql(sql);

			//Guosheng 2005-2-3 Modify ɾ����ʱ�����ָ���Ŀͻ���Ҳɾ�������������᲻��ȷ
			sql = " delete T_OutReportItemRowGroup where outrepid= " + outrepid +" and itemrow  = " + delrownum ;
            RecordSet.executeSql(sql);

            break ;

        case 4:
            sql = " update T_OutReport set outrepcolumn = outrepcolumn-1 where outrepid = " + outrepid ;
            RecordSet.executeSql(sql);
            
            para = ""+outrepid  + separator + ""+delcolumnnum ;
            RecordSet.executeProc("T_OutReportItem_DeleteByCol",para);

            sql = " update T_OutReportItem set itemcolumn = itemcolumn-1 where itemcolumn > " + delcolumnnum +" and outrepid = " + outrepid ;
            RecordSet.executeSql(sql);
            break ;
    }

 	response.sendRedirect("OutReportChange.jsp?outrepid="+outrepid+"&msg=1&outrepcategory="+outrepcategory);
 }

%>
