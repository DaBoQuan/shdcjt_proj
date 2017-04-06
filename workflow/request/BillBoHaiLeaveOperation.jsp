<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="weaver.file.FileUpload" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="HrmScheduleDiffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page"/>
<jsp:useBean id="HrmAnnualManagement" class="weaver.hrm.schedule.HrmAnnualManagement" scope="page"/>
<jsp:useBean id="HrmPaidSickManagement" class="weaver.hrm.schedule.HrmPaidSickManagement" scope="page"/>
<%@ include file="/systeminfo/init.jsp" %>

<%
FileUpload fu = new FileUpload(request);
String src = Util.null2String(fu.getParameter("src"));
String iscreate = Util.null2String(fu.getParameter("iscreate"));
int requestid = Util.getIntValue(fu.getParameter("requestid"),-1);
int workflowid = Util.getIntValue(fu.getParameter("workflowid"),-1);
String workflowtype = Util.null2String(fu.getParameter("workflowtype"));
int isremark = Util.getIntValue(fu.getParameter("isremark"),-1);
int formid = Util.getIntValue(fu.getParameter("formid"),-1);
int isbill = Util.getIntValue(fu.getParameter("isbill"),-1);
int billid = Util.getIntValue(fu.getParameter("billid"),-1);
int nodeid = Util.getIntValue(fu.getParameter("nodeid"),-1);
String nodetype = Util.null2String(fu.getParameter("nodetype"));
String requestname = Util.fromScreen3(fu.getParameter("requestname"),user.getLanguage());
String requestlevel = Util.fromScreen(fu.getParameter("requestlevel"),user.getLanguage());
String messageType =  Util.fromScreen(fu.getParameter("messageType"),user.getLanguage());
String remark = Util.null2String(fu.getParameter("remark"));
String method = Util.fromScreen(fu.getParameter("method"),user.getLanguage()); // ��Ϊ�½��ĵ�ʱ��Ĳ�������
String topage=URLDecoder.decode(Util.null2String(fu.getParameter("topage")));  //���ص�ҳ��
String sql = "";
int urger=Util.getIntValue((String)session.getAttribute(user.getUID()+"_"+requestid+"urger"),0);
HrmScheduleDiffUtil.setUser(user);

if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    //response.sendRedirect("/notice/RequestError.jsp");
    out.print("<script>wfforward('/notice/RequestError.jsp');</script>");
    return ;
}


RequestManager.setSrc(src) ;
RequestManager.setIscreate(iscreate) ;
RequestManager.setRequestid(requestid) ;
RequestManager.setWorkflowid(workflowid) ;
RequestManager.setWorkflowtype(workflowtype) ;
RequestManager.setIsremark(isremark) ;
RequestManager.setFormid(formid) ;
RequestManager.setIsbill(isbill) ;
RequestManager.setBillid(billid) ;
RequestManager.setNodeid(nodeid) ;
RequestManager.setNodetype(nodetype) ;
RequestManager.setRequestname(requestname) ;
RequestManager.setRequestlevel(requestlevel) ;
RequestManager.setRemark(remark) ;
RequestManager.setRequest(fu) ;
//add by xhheng @ 2005/01/24 for ��Ϣ���� Request06
RequestManager.setMessageType(messageType) ;
//System.out.println("messageType===="+messageType);
RequestManager.setUser(user) ;
//add by chengfeng.han 2011-7-28 td20647 
int isagentCreater = Util.getIntValue((String)session.getAttribute(workflowid+"isagent"+user.getUID()));
int beagenter = Util.getIntValue((String)session.getAttribute(workflowid+"beagenter"+user.getUID()),0);
RequestManager.setIsagentCreater(isagentCreater);
RequestManager.setBeAgenter(beagenter);
//end

boolean savestatus = RequestManager.saveRequestInfo() ;
requestid = RequestManager.getRequestid() ;

if( !savestatus ) {
    if( requestid != 0 ) {

        String message=RequestManager.getMessage();
        if(!"".equals(message)){
			out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message="+message+"');</script>");
            return ;
        }

        //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
        out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1');</script>");
        return ;
    }
    else {
        //response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
        out.print("<script>wfforward('/workflow/request/RequestView.jsp?message=1');</script>");
        return ;
    }
}

    sql = "select resourceid from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String workflowcreater = RecordSet.getString("resourceid");    

    sql = "select * from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    if("submit".equalsIgnoreCase(src) && RequestManager.getIsremark()==0){
		//TD15253 ���ƽ������ڣ�ʱ�䣩�����ڿ�ʼ���ڣ�ʱ��֮ǰ�� Start
	    String fromDateAll = Util.null2String(RecordSet.getString("fromDate")).trim();
	    String fromTimeAll = Util.null2String(RecordSet.getString("fromTime")).trim();
	    String toDateAll = Util.null2String(RecordSet.getString("toDate")).trim();
	    String toTimeAll = Util.null2String(RecordSet.getString("toTime")).trim();
	    if(!"".equals(fromDateAll) && !"".equals(toDateAll)){//��ʼ���������ڶ�����Ϊ�գ������ж�
	    	if("".equals(fromTimeAll)){
	    		fromTimeAll = "00:00:00";
	    	}else if(fromTimeAll.length() == 5){
	    		fromTimeAll = fromTimeAll + ":00";
	    	}
	    	if("".equals(toTimeAll)){
	    		toTimeAll = "23:59:59";
	    	}else if(toTimeAll.length() == 5){
	    		toTimeAll = toTimeAll + ":00";
	    	}
	    	long leaveTimesAll = TimeUtil.timeInterval(fromDateAll+" "+fromTimeAll, toDateAll+" "+toTimeAll);
	    	if(leaveTimesAll <= 0){//�������ڣ�ʱ�䣩�ڿ�ʼ֮ǰ
	    		out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message=24569');</script>");
	    		return;
	    	}
	    }
    }
	//TD15253 ���ƽ������ڣ�ʱ�䣩�����ڿ�ʼ���ڣ�ʱ��֮ǰ�� End

    String leaveType = RecordSet.getString("leaveType");
    String otherLeaveType = RecordSet.getString("otherLeaveType");
    ArrayList annualsql = new ArrayList();//������ٵ�sql���
    float leavedaysAll = 0;//��ű���������������ڸ���Bill_BoHaiLeave
//����û��������Ϊ��٣����飬���ʱ���Ƿ���ڿ������ʱ�䣬��������������ύ
if(src.equals("submit")&&!nodetype.equals("3")&&leaveType.equals("4")&&otherLeaveType.equals("2")) {
    
    sql = "select * from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String fromDate = RecordSet.getString("fromDate");
    String fromTime = RecordSet.getString("fromTime");
    String toDate = RecordSet.getString("toDate");
    String toTime = RecordSet.getString("toTime"); 
    
    sql = "select resourceid from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String creater = RecordSet.getString("resourceid");
    
	int subcompanyid1=user.getUserSubCompany1();
    RecordSet.executeSql("select b.subcompanyid1 from hrmresource a,hrmdepartment b where a.departmentid=b.id and a.id="+creater);
    if(RecordSet.next()){
		subcompanyid1=Util.getIntValue(RecordSet.getString("subcompanyid1"),-1);
		if(subcompanyid1<=0){
			subcompanyid1=user.getUserSubCompany1();
		}
	}

    //�������ʱ��
    String leavetime = HrmScheduleDiffUtil.getTotalWorkingDays(fromDate,fromTime,toDate,toTime,subcompanyid1);
    
    Calendar today = Calendar.getInstance() ; 
    String currentdate = Util.add0(today.get(Calendar.YEAR),4) + "-" + Util.add0(today.get(Calendar.MONTH)+1,2) + "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
    String thisyear = Util.add0(today.get(Calendar.YEAR),4);
    String lastyear = Util.add0(today.get(Calendar.YEAR)-1,4);
    //���������ʱ��
    String allannualtime = "";
    //��һ��ʣ���������
    String lastyearannualtime = "";
    //����ʣ���������
    String thisyearannualtime = "";
    
    try{
        String tempvalue = HrmAnnualManagement.getUserAannualInfo(workflowcreater,currentdate);
        thisyearannualtime = Util.TokenizerString2(tempvalue,"#")[0];
        lastyearannualtime = Util.TokenizerString2(tempvalue,"#")[1];
        allannualtime = Util.TokenizerString2(tempvalue,"#")[2];    
    }catch(Exception e){
        
    }
    
    float leavedays = Util.getFloatValue(leavetime,0);//�������ʱ��
    leavedaysAll = leavedays;
    float allannualdays = Util.getFloatValue(allannualtime,0);//�û�ʣ�����ʱ��
    float lastyearannualdays = Util.getFloatValue(lastyearannualtime,0);
    float thisyearannualdays = Util.getFloatValue(thisyearannualtime,0);
    DecimalFormat   df   =   new   DecimalFormat("0.##");
       
    if(allannualdays<leavedays){
       //response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message=182");
       out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message=182');</script>");
       return ;
    }else{
       //����sql��������һ����٣����뵱ǰ�����
       if(leavedays<lastyearannualdays){
         sql = "update hrmannualmanagement set annualdays = (annualdays - " + leavedays + ") where annualyear = " + lastyear + " and resourceid = " + creater;     
         annualsql.add(sql);
       }else{
         sql = "update hrmannualmanagement set annualdays = 0 where annualyear = " + lastyear + " and resourceid = " + creater;
         annualsql.add(sql);
         sql = "update hrmannualmanagement set annualdays = (annualdays - " + Util.getFloatValue(df.format(leavedays - lastyearannualdays),0) + ") where annualyear = " + thisyear + " and resourceid = " + creater;
         annualsql.add(sql);
       }                   
    }
}else if(src.equals("submit")&&!nodetype.equals("3")&&leaveType.equals("4")&&otherLeaveType.equals("11")) {//��н����
    
    sql = "select * from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String fromDate = RecordSet.getString("fromDate");
    String fromTime = RecordSet.getString("fromTime");
    String toDate = RecordSet.getString("toDate");
    String toTime = RecordSet.getString("toTime"); 
    
    sql = "select resourceid from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String creater = RecordSet.getString("resourceid");

	int subcompanyid1=user.getUserSubCompany1();
    RecordSet.executeSql("select b.subcompanyid1 from hrmresource a,hrmdepartment b where a.departmentid=b.id and a.id="+creater);
    if(RecordSet.next()){
		subcompanyid1=Util.getIntValue(RecordSet.getString("subcompanyid1"),-1);
		if(subcompanyid1<=0){
			subcompanyid1=user.getUserSubCompany1();
		}
	}	
    //�������ʱ��
    String leavetime = HrmScheduleDiffUtil.getTotalWorkingDays(fromDate,fromTime,toDate,toTime,subcompanyid1);
    
    Calendar today = Calendar.getInstance() ; 
    String currentdate = Util.add0(today.get(Calendar.YEAR),4) + "-" + Util.add0(today.get(Calendar.MONTH)+1,2) + "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
    String thisyear = Util.add0(today.get(Calendar.YEAR),4);
    String lastyear = Util.add0(today.get(Calendar.YEAR)-1,4);
  //�����н������ʱ��
    String allpsltime = "";
    //��һ��ʣ���н��������
    String lastyearpsltime = "";
    //����ʣ���н��������
    String thisyearpsltime = "";
    
    try{
        String tempvalue = HrmPaidSickManagement.getUserPaidSickInfo(workflowcreater,currentdate);
        thisyearpsltime = Util.TokenizerString2(tempvalue,"#")[0];
        lastyearpsltime = Util.TokenizerString2(tempvalue,"#")[1];
        allpsltime = Util.TokenizerString2(tempvalue,"#")[2];    
    }catch(Exception e){
        
    }
    
    float leavedays = Util.getFloatValue(leavetime,0);//�������ʱ��
    leavedaysAll = leavedays;
    float allpsldays = Util.getFloatValue(allpsltime,0);//�û�ʣ���н����ʱ��
    float lastyearpsldays = Util.getFloatValue(lastyearpsltime,0);
    float thisyearpsldays = Util.getFloatValue(thisyearpsltime,0);
    DecimalFormat   df   =   new   DecimalFormat("0.##");
       
    if(allpsldays<leavedays){
       //response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message=182");
       out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message=183');</script>");
       return ;
    }else{
        //����sql��������һ���н���٣����뵱ǰ���н����
        if(leavedays<lastyearpsldays){
          sql = "update HrmPSLManagement set psldays = (psldays - " + leavedays + ") where pslyear = " + lastyear + " and resourceid = " + creater;
          annualsql.add(sql);
        }else{
          sql = "update HrmPSLManagement set psldays = 0 where pslyear = " + lastyear + " and resourceid = " + creater;
          annualsql.add(sql);
          sql = "update HrmPSLManagement set psldays = (psldays - " + Util.getFloatValue(df.format(leavedays - lastyearpsldays),0) + ") where pslyear = " + thisyear + " and resourceid = " + creater;
          annualsql.add(sql);
        }                   
    }
}else{//�����������
	sql = "select * from Bill_BoHaiLeave where requestid = " + requestid;
	RecordSet.executeSql(sql);
	RecordSet.next();
	String fromDate = RecordSet.getString("fromDate");
	String fromTime = RecordSet.getString("fromTime");
	String toDate = RecordSet.getString("toDate");
	String toTime = RecordSet.getString("toTime");
    
	String resourceId = RecordSet.getString("resourceid");
    String sqlHrmResource = "select locationid from HrmResource where id ="+resourceId;
	RecordSet.executeSql(sqlHrmResource);
	String locationid = "";
	if (RecordSet.next()){
	   locationid=RecordSet.getString("locationid");
	}
	String sqlHrmLocations = "select countryid from HrmLocations where id="+locationid;
	RecordSet.executeSql(sqlHrmLocations);
	String countryId = "";
	if (RecordSet.next()){
	   countryId =  RecordSet.getString("countryid");
	}
	user.setCountryid(countryId);
	HrmScheduleDiffUtil.setUser(user);

	int subcompanyid1=user.getUserSubCompany1();
    RecordSet.executeSql("select b.subcompanyid1 from hrmresource a,hrmdepartment b where a.departmentid=b.id and a.id="+resourceId);
    if(RecordSet.next()){
		subcompanyid1=Util.getIntValue(RecordSet.getString("subcompanyid1"),-1);
		if(subcompanyid1<=0){
			subcompanyid1=user.getUserSubCompany1();
		}
	}
	//�������ʱ��
	String leavetime = HrmScheduleDiffUtil.getTotalWorkingDays(fromDate,fromTime,toDate,toTime,subcompanyid1);
	float leavedays = Util.getFloatValue(leavetime,0);//�������ʱ��
    leavedaysAll = leavedays;
}
if(("submit".equalsIgnoreCase(src)||"save".equalsIgnoreCase(src)) && RequestManager.getIsremark()==0){
	sql = "update Bill_BoHaiLeave set leaveDays="+leavedaysAll+" where requestid="+requestid;
	RecordSet.executeSql(sql);
}
boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
    //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
    out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
    return ;
}

//������̹鵵�ˣ���ʹ�����Ч�����û�������ټ�ȥ��ǰ����������
sql = "select currentnodetype from workflow_requestbase where requestid = " + requestid;
RecordSet.executeSql(sql);
RecordSet.next();
String currentnodetype = RecordSet.getString("currentnodetype");

if(src.equals("submit")&&!nodetype.equals("3")&&currentnodetype.equals("3")) {
    
    sql = "select * from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String fromDate = RecordSet.getString("fromDate");
    String fromTime = RecordSet.getString("fromTime");
    String toDate = RecordSet.getString("toDate");
    String toTime = RecordSet.getString("toTime"); 
    
    sql = "select resourceid from Bill_BoHaiLeave where requestid = " + requestid;
    RecordSet.executeSql(sql);
    RecordSet.next();
    String creater = RecordSet.getString("resourceid");

	int subcompanyid1=user.getUserSubCompany1();
    RecordSet.executeSql("select b.subcompanyid1 from hrmresource a,hrmdepartment b where a.departmentid=b.id and a.id="+creater);
    if(RecordSet.next()){
		subcompanyid1=Util.getIntValue(RecordSet.getString("subcompanyid1"),-1);
		if(subcompanyid1<=0){
			subcompanyid1=user.getUserSubCompany1();
		}
	}	
    //�������ʱ��
    String leavetime = HrmScheduleDiffUtil.getTotalWorkingDays(fromDate,fromTime,toDate,toTime,subcompanyid1);
    
    Calendar today = Calendar.getInstance() ; 
    String currentdate = Util.add0(today.get(Calendar.YEAR),4) + "-" + Util.add0(today.get(Calendar.MONTH)+1,2) + "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
    String thisyear = Util.add0(today.get(Calendar.YEAR),4);
    String lastyear = Util.add0(today.get(Calendar.YEAR)-1,4);
    
    float leavedays = Util.getFloatValue(leavetime,0);//�������ʱ��
    DecimalFormat   df   =   new   DecimalFormat("0.##");
    
    sql = "delete from HrmAnnualLeaveInfo where requestid = " + requestid;
    RecordSet.executeSql(sql);
    sql = "insert into HrmAnnualLeaveInfo (requestid,resourceid,startdate,starttime,enddate,endtime,leavetime,occurdate,leavetype,otherleavetype,status) values ("+requestid+","+creater+",'"+fromDate+"','"+fromTime+"','"+toDate+"','"+toTime+"','"+leavedays+"','"+currentdate+"','"+leaveType+"','"+otherLeaveType+"',1)";
    RecordSet.executeSql(sql);
    
    if(leaveType.equals("4")&&otherLeaveType.equals("2")){
        //���������ʱ��
        String allannualtime = "";
        //��һ��ʣ���������
        String lastyearannualtime = "";
        //����ʣ���������
        String thisyearannualtime = "";
        
        try{
            String tempvalue = HrmAnnualManagement.getUserAannualInfo(workflowcreater,currentdate);
            thisyearannualtime = Util.TokenizerString2(tempvalue,"#")[0];
            lastyearannualtime = Util.TokenizerString2(tempvalue,"#")[1];
            allannualtime = Util.TokenizerString2(tempvalue,"#")[2];    
        }catch(Exception e){
            
        }
        float allannualdays = Util.getFloatValue(allannualtime,0);//�û�ʣ�����ʱ��
        float lastyearannualdays = Util.getFloatValue(lastyearannualtime,0);
        float thisyearannualdays = Util.getFloatValue(thisyearannualtime,0);
      //����sql��������һ����٣�������ǰ�����
      if(leavedays<lastyearannualdays){
         sql = "update hrmannualmanagement set annualdays = (annualdays - " + leavedays + ") where annualyear = " + lastyear + " and resourceid = " + creater;     
         RecordSet.executeSql(sql);
      }else{
         sql = "update hrmannualmanagement set annualdays = 0 where annualyear = " + lastyear + " and resourceid = " + creater;
         RecordSet.executeSql(sql);
         sql = "update hrmannualmanagement set annualdays = (annualdays - " + Util.getFloatValue(df.format(leavedays - lastyearannualdays),0) + ") where annualyear = " + thisyear + " and resourceid = " + creater;
         RecordSet.executeSql(sql);
      }
    }else if(leaveType.equals("4")&&otherLeaveType.equals("11")){//��н����
        //�����н������ʱ��
        String allannualtime = "";
        //��һ��ʣ���н��������
        String lastyearannualtime = "";
        //����ʣ���н��������
        String thisyearannualtime = "";
        
        try{
            String tempvalue = HrmPaidSickManagement.getUserPaidSickInfo(workflowcreater,currentdate);
            thisyearannualtime = Util.TokenizerString2(tempvalue,"#")[0];
            lastyearannualtime = Util.TokenizerString2(tempvalue,"#")[1];
            allannualtime = Util.TokenizerString2(tempvalue,"#")[2];    
        }catch(Exception e){
            
        }
        float allannualdays = Util.getFloatValue(allannualtime,0);//�û�ʣ���н����ʱ��
        float lastyearannualdays = Util.getFloatValue(lastyearannualtime,0);
        float thisyearannualdays = Util.getFloatValue(thisyearannualtime,0);
        //����sql��������һ����٣�������ǰ����٣�������С��0��������ڱ������������
        if(leavedays<0){
     	     sql = "update HrmPSLManagement set psldays = (psldays - " + leavedays + ") where pslyear = " + thisyear + " and resourceid = " + creater;     
              RecordSet.executeSql(sql);  
     	  }else if(leavedays<lastyearannualdays){
              sql = "update HrmPSLManagement set psldays = (psldays - " + leavedays + ") where pslyear = " + lastyear + " and resourceid = " + creater;     
              RecordSet.executeSql(sql);
           }else{
              sql = "update HrmPSLManagement set psldays = 0 where pslyear = " + lastyear + " and resourceid = " + creater;
              RecordSet.executeSql(sql);
              sql = "update HrmPSLManagement set psldays = (psldays - " + Util.getFloatValue(df.format(leavedays - lastyearannualdays),0) + ") where pslyear = " + thisyear + " and resourceid = " + creater;
              RecordSet.executeSql(sql);
        }
      }
}

boolean logstatus = RequestManager.saveRequestLog() ;



if( method.equals("") ) 
	if(!topage.equals("")){
        	if(topage.indexOf("?")!=-1)
        	{
        		//response.sendRedirect(topage+"&requestid="+requestid);
        		out.print("<script>wfforward('"+topage+"&requestid="+requestid+"');</script>");
        		return;
        	}
        	else
        	{
				//response.sendRedirect(topage+"?requestid="+requestid);
				out.print("<script>wfforward('"+topage+"?requestid="+requestid+"');</script>");
        		return;
        	}
		}
    else {
        if(iscreate.equals("1")||src.equals("save")){
            //response.sendRedirect("/workflow/request/RequestView.jsp");
        	out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
        }
        else{
        	System.out.println("delete".equals(src) && savestatus && flowstatus);
            if("delete".equals(src) && savestatus && flowstatus){%>
                <SCRIPT LANGUAGE="JavaScript">
	                alert("<%=SystemEnv.getHtmlLabelName(20461,user.getLanguage())%>");
	                //window.close();
			    	try{
			    	    window.close();
			    	    window.opener._table.reLoad();
			    	}catch(e){}
			    	try{
			    	    parent.window.close();
			    	    parent.window.opener._table.reLoad();
			    	}catch(e){}
			        window.history.go(-2);
			   		try{	
			   			parent.window.opener.btnWfCenterReload.onclick();
			   		}catch(e){}
			   		try{
			   			parent.window.opener.reLoad();
			   		}catch(e){}
       			</SCRIPT>
                <%
                	return;
            }
            else{
	            //response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&fromoperation=1&updatePoppupFlag=1"+"&urger="+urger);//td3450 xwj 20060207
	            out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&fromoperation=1&updatePoppupFlag=1"+"&urger="+urger+"');</script>"); 	
	            return;
            }
        }
    }

else {
    String adddocfieldid = method.substring(7) ;
    topage = URLEncoder.encode("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&docfileid="+adddocfieldid+"&topage="+topage);
    //response.sendRedirect("/docs/docs/DocList.jsp?topage="+topage);
    out.print("<script>wfforward('/docs/docs/DocList.jsp?topage="+topage+"');</script>");
//  showsubmit Ϊ0��ʱ���½��ĵ�������ʾ�ύ��ť  response.sendRedirect("/docs/docs/DocList.jsp?topage="+topage+"&showsubmit=0");
}

%>