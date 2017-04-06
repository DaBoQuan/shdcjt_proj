<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WfForceDrawBack" class="weaver.workflow.workflow.WfForceDrawBack" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<%
String operation = Util.null2String(request.getParameter("operation"));

String confirmid = Util.null2String(request.getParameter("confirmid"));
String thetable = Util.null2String(request.getParameter("thetable"));
String inputid = Util.null2String(request.getParameter("inputid"));
String inputmodid = Util.null2String(request.getParameter("inputmodid"));
String inprepid = Util.null2String(request.getParameter("inprepid"));
String thedate = Util.null2String(request.getParameter("thedate"));
String inprepbudget = Util.null2String(request.getParameter("inprepbudget"));
String inprepname=Util.null2String(request.getParameter("inprepname"));
String dspdate=Util.null2String(request.getParameter("dspdate"));
if(operation.equals("edit")){

    Hashtable ht = new Hashtable() ;
    Hashtable ht_mod = new Hashtable() ;            // �����е�����

    Enumeration eu = request.getParameterNames() ;
    while(eu.hasMoreElements() ) {
        String keyname = (String)eu.nextElement() ;
        String keyvalue = Util.null2String(request.getParameter(keyname)) ;

        double keyvaluedouble = Util.getDoubleValue(keyvalue , 0) ;
        if(keyname.indexOf("_mod") < 0) ht.put(keyname , ""+keyvaluedouble) ; // �������е�����
        else ht_mod.put(keyname.substring(0,keyname.length()-4) , ""+keyvaluedouble) ; // �����е�����
    }

    
    String sql = "" ; 
    String sqlmod = "" ;
    
    RecordSet.executeProc("T_IRItem_SelectByInprepid",inprepid);


    while (RecordSet.next()) {
        String itemfieldname = Util.null2String(RecordSet.getString("itemfieldname")) ;
        String itemfieldtype = Util.null2String(RecordSet.getString("itemfieldtype")) ;
        String itemgongsi = Util.null2String(RecordSet.getString("itemgongsi")) ;
        String inputablefact = Util.null2String(RecordSet.getString("inputablefact")) ; // ʵ���Ƿ������
        String inputablebudg = Util.null2String(RecordSet.getString("inputablebudg")) ; // Ԥ���Ƿ������
        String inputablefore = Util.null2String(RecordSet.getString("inputablefore")) ; // Ԥ���Ƿ������
        String inputable = inputablefact ;
        if(inprepbudget.equals("1")) inputable = inputablebudg ;
        else if(inprepbudget.equals("2")) inputable = inputablefore ;
        
        if(sql.equals("")) {
            sql = " update " + thetable + " set "+ itemfieldname +" = " ;
        }
        else {
            sql += ","+itemfieldname+"=" ;
        }

        String itemvalue = "" ;
        
        if(itemfieldtype.equals("2")) itemvalue = "" + Util.getIntValue(request.getParameter(itemfieldname),0);
        else if(itemfieldtype.equals("3") || (itemfieldtype.equals("5") && inputable.equals("1")) ) itemvalue = "" + Util.getDoubleValue(request.getParameter(itemfieldname),0);
        else if(itemfieldtype.equals("5") && !inputable.equals("1")) {
            String thesql = Util.fillValuesToString(itemgongsi, ht) ;
            rs2.executeSql(" select " + thesql +" as result ") ;
            if(rs2.next())
                itemvalue = ""+Util.getDoubleValue(rs2.getString(1),0) ;
            else 
                itemvalue = "0" ;
        }
        else itemvalue = Util.null2String(request.getParameter(itemfieldname));

        if(itemfieldtype.equals("2") || itemfieldtype.equals("3") || itemfieldtype.equals("5") ) {
            sql += itemvalue ;
        }
        else  {
            sql += "'" + Util.fromScreen2(itemvalue,user.getLanguage()) + "'" ;
        }
        
        if(itemfieldtype.equals("2") || itemfieldtype.equals("3") || itemfieldtype.equals("5")) {
            if(sqlmod.equals("")) {
                sqlmod = " update " + thetable + " set "+ itemfieldname +" = " ;
            }
            else {
                sqlmod += ","+itemfieldname+"=" ;
            }

            itemvalue = Util.null2String(request.getParameter(itemfieldname+"_mod"));
            if(itemfieldtype.equals("2")) {
                sqlmod += Util.getIntValue(itemvalue,0) ;
            }
            else if(itemfieldtype.equals("3") || (itemfieldtype.equals("5") && inputable.equals("1")) ) {
                sqlmod += Util.getDoubleValue(itemvalue,0) ;
            }
            else if(itemfieldtype.equals("5") && !inputable.equals("1") ) {
                String thesql = Util.fillValuesToString(itemgongsi, ht_mod) ;
                rs2.executeSql(" select " + thesql +" as result ") ;
                if(rs2.next()) itemvalue = ""+Util.getDoubleValue(rs2.getString(1),0) ;
                sqlmod += Util.getDoubleValue(itemvalue,0) ;
            }
        }

    }

    sql += " where inputid = " + inputid ;
    sqlmod += " where inputid = " + inputmodid ;

        
    RecordSet.executeSql(sql);
//    out.print("sql 2 is " + sql) ;
    RecordSet.executeSql(sqlmod);
//    out.print("sql 3 is " + sqlmod) ;

    
    if(confirmid.equals("0"))
        response.sendRedirect("ReportConfirmDetail.jsp?thetable="+thetable+"&inputid="+inputid+"&inprepid="+inprepid+"&inprepbudget="+inprepbudget);
    else 
        response.sendRedirect("ReportConfirmDetail.jsp?confirmid="+confirmid);  
}

else if(operation.equals("confirm")){

    String sql = " update " + thetable + " set inputstatus='1' where inputid = " + inputid ;

    RecordSet.executeSql(sql);

    sql = " update " + thetable + " set inputstatus='1' where inputid = " + inputmodid ;

    RecordSet.executeSql(sql);

    RecordSet.executeProc("T_InputReportConfirm_Delete", confirmid );

    response.sendRedirect("ReportConfirm.jsp");
}

else if(operation.equals("check")){
    
    String sql = " update " + thetable + " set inputstatus='2' where reportdate = '" + thedate + "' ";

    RecordSet.executeSql(sql);

    response.sendRedirect("ReportDetailStatus.jsp?inprepid="+inprepid);
}
else if(operation.equals("reject")){
	String sql ="select requestid,crmid from "+thetable+" where inputid="+inputid;
	String crmid="";
	RecordSet.executeSql(sql);
	if(RecordSet.next()){		
		ArrayList requestids=new ArrayList();
		requestids.add(RecordSet.getString(1));
		crmid=RecordSet.getString(2);
		WfForceDrawBack.ForceDrawBackToCreater(requestids,request,response,user.getUID(),(user.getLogintype().equals("1")) ? 0 : 1);
	}
    sql = " update " + thetable + " set inputstatus='9' where inputid = " + inputid ;
    RecordSet.executeSql(sql);
	SysMaintenanceLog.resetParameter();
	SysMaintenanceLog.setRelatedId(Util.getIntValue(inprepid));
	SysMaintenanceLog.setRelatedName(inprepname+":"+CustomerInfoComInfo.getCustomerInfoname(crmid)+" "+dspdate);
	SysMaintenanceLog.setOperateType("9");
	SysMaintenanceLog.setOperateDesc("");
	SysMaintenanceLog.setOperateItem("98");
	SysMaintenanceLog.setOperateUserid(user.getUID());
	SysMaintenanceLog.setClientAddress(request.getRemoteAddr());
	SysMaintenanceLog.setSysLogInfo();
    response.sendRedirect("ReportDetailStatus.jsp?inprepid="+inprepid);
}
%>

