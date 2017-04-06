<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="tempRecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="requestCheckAddinRules" class="weaver.workflow.request.RequestCheckAddinRules" scope="page" />

<%


String approveType = Util.null2String(request.getParameter("approveType"));
String srcInit = Util.null2String(request.getParameter("src"));

// �������û���Ϣ
int userid=user.getUID();                   //��ǰ�û�id
int usertype = 0;                           //�û��ڹ��������е����� 0: �ڲ� 1: �ⲿ
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
String userName = "";

if(logintype.equals("1"))
	userName = Util.toScreen(ResourceComInfo.getResourcename(""+userid),user.getLanguage()) ;
if(logintype.equals("2"))
	userName = Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+userid),user.getLanguage());


Calendar today = Calendar.getInstance();
String currentDate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String currentTime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                     Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                     Util.add0(today.get(Calendar.SECOND), 2) ;

String src = srcInit;
String iscreate = "0";
int isremark = 0;
String remark = "\n"+userName+" "+currentDate+" "+currentTime;
String workflowtype = "";
int formid = -1;
int isbill = -1;
int billid = -1;
String messageType = "";
int nodeid = -1;
String nodetype = "";
String requestname = "";
String requestlevel = "";

String docIds="";
String crmIds="";
String hrmIds="";
String prjIds="";
String cptIds="";

String approveid= "" ;
String approvetype= "" ;

String Procpara = "" ;
char flag = 2 ;


String multiRequestId=Util.null2String(request.getParameter("multiRequestId"));
String [] requestids=Util.TokenizerString2(multiRequestId,",");

for (int i=0; i<requestids.length; i++){
    
    int requestid = Util.getIntValue(requestids[i],-1) ;
     /*----------xwj for td3098 20051202 begin -----*/
    src = srcInit;
    isremark = 0;
    RecordSet.executeSql("select min(isremark) from workflow_currentoperator where requestid = " + requestid + " and userid = "+user.getUID());
    if(RecordSet.next()){
		int isremarkCheck = RecordSet.getInt(1);
        if(isremarkCheck==1&&src.equals("submit")){
			src = "save";
			isremark = 1;
		}
	}
    
    /*----------xwj for td3098 20051202 end -----*/
    
    int workflowid=-1;

    if(requestid!=-1 ){

    RecordSet.executeSql("select billId from workflow_form where requestid="+requestid);
    if(RecordSet.next()){
		billid = RecordSet.getInt("billId");
    }

    //RecordSet.executeSql("select currentnodeid,currentnodetype,requestname,requestlevel,workflowid from workflow_requestbase where requestid="+requestid);
    RecordSet.executeSql("select currentnodeid,currentnodetype,requestname,requestlevel,workflowid,docIds,crmIds,hrmIds,prjIds,cptIds from workflow_requestbase where requestid="+requestid);
    if(RecordSet.next()){
      nodeid = RecordSet.getInt("currentnodeid");
      nodetype = RecordSet.getString("currentnodetype");
      requestname = RecordSet.getString("requestname");
      requestlevel = RecordSet.getString("requestlevel");
      workflowid = RecordSet.getInt("workflowid");
	  docIds = Util.null2String(RecordSet.getString("docIds"));
	  crmIds = Util.null2String(RecordSet.getString("crmIds"));
	  hrmIds = Util.null2String(RecordSet.getString("hrmIds"));
	  prjIds = Util.null2String(RecordSet.getString("prjIds"));
	  cptIds = Util.null2String(RecordSet.getString("cptIds"));
    }

    RecordSet.executeSql("select workflowtype,formid,isbill,messageType from workflow_base where id="+workflowid);
    if(RecordSet.next()){
      workflowtype = RecordSet.getString("workflowtype");
      formid = RecordSet.getInt("formid");
      isbill = RecordSet.getInt("isbill");
      //billid = RecordSet.getInt("formid");
      messageType = RecordSet.getString("messageType");
    }


    if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
        response.sendRedirect("/notice/RequestError.jsp");
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
    RequestManager.setRequest(request) ;
    RequestManager.setMessageType(messageType) ;
    RequestManager.setUser(user) ;

    //���Ϊ��׼������
    if(approveType.equals("")){
		RecordSet.executeProc("Bill_Approve_SelectByID",billid+"");
		if (RecordSet.next()) {
			approveid=RecordSet.getString("approveid");
			approvetype=RecordSet.getString("approvetype");
		}
		if (approvetype.equals("9"))    //�ĵ� 
			RequestManager.setDocids(approveid);
		if (approvetype.equals("10"))    //�ͻ�
			RequestManager.setCrmids(approveid);
		if (approvetype.equals("11"))    //��Ŀ
			RequestManager.setPrjids(approveid);
	}

    if("1".equals(approveType)||"2".equals(approveType)){

			RequestManager.setDocids(docIds);
			RequestManager.setCrmids(crmIds);
			RequestManager.setHrmids(hrmIds);
			RequestManager.setPrjids(prjIds);
			RequestManager.setCptids(cptIds);
	}

//###################�ĵ������ڵ㸽�Ӳ��� td29590 start// #############################################################
		// ��ʼ�ڵ��Զ���ֵ����(���ڴ���ڵ�ǰ���ڵ��ȵĸ�ֵ����)
        String rejectbackflag = "";//�˻�ʱ����ǰ�ڵ�Ľڵ�󸽼Ӳ����Ƿ񴥷���rejectbackflag=1����ʾ������
        //RecordSet tempRecordSet = new RecordSet(); 
        tempRecordSet.executeSql("select rejectbackflag from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
        if(tempRecordSet.next()){
        	rejectbackflag = Util.null2String(tempRecordSet.getString("rejectbackflag"));
        }

		if(!src.equals("save")&&(!src.equals("reject")||(src.equals("reject")&&!rejectbackflag.equals("1")))){//�����޸ģ�����Ҳ��ִ�нڵ�󸽼Ӳ���
//		rs.executeSql("select * from workflow_addinoperate  where workflowid="+workflowid+" and type=2 and customervalue='action.WorkflowToDoc' ");
//		tempRecordSet.executeSql("select * from workflow_addinoperate  where workflowid="+workflowid+" and isnode=1 and objid="+nodeid+" and ispreadd='0' and type=2 and customervalue='action.WorkflowToDoc' ");						
//		if(tempRecordSet.next())
//		 {
//			   isWorkFlowToDoc=true;
//		 }
		try {
			 //����objtypeΪ"1: �ڵ��Զ���ֵ",��Ϊ"0 :�����Զ���ֵ"�����øı��״̬����ĵ������Ϣ���ʿɲ��ø�user��clienIp��src��ֵ  fanggsh TD5121			
			//RequestCheckAddinRules requestCheckAddinRules = new RequestCheckAddinRules();
			requestCheckAddinRules.resetParameter();
			//add by cyril on 2008-07-28 for td:8835 �����޷�������ѯ,ֻ�ܴ���
		    boolean isStart = true;	//�����Ƿ��ѿ�ʼ��ת by cyril
	        boolean isTrack = true; //���ܿ���,�Ƿ��¼�޸���־ by cyril
            requestCheckAddinRules.setTrack(isTrack);
            requestCheckAddinRules.setStart(isStart);
            requestCheckAddinRules.setNodeid(nodeid);
            //end by cyril on 2008-07-28 for td:8835
			requestCheckAddinRules.setRequestid(requestid);
			requestCheckAddinRules.setWorkflowid(workflowid);
			requestCheckAddinRules.setObjid(nodeid);
			requestCheckAddinRules.setObjtype(1);               // 1: �ڵ��Զ���ֵ 0 :�����Զ���ֵ
			requestCheckAddinRules.setIsbill(isbill);
			requestCheckAddinRules.setFormid(formid);
			requestCheckAddinRules.setIspreadd("0");//xwj for td3130 20051123
			//requestCheckAddinRules.setRequestManager(this);
			requestCheckAddinRules.setRequestManager(RequestManager);
			requestCheckAddinRules.setUser(user);			
			requestCheckAddinRules.checkAddinRules();
		} catch (Exception erca) {
			////writeLog(erca);
			//RequestManager.saveRequestLog("1");
			RequestManager.saveRequestLog2();
			

            if(erca.getMessage().indexOf("workflow interface action error")>-1){
               RequestManager.writeLog(erca);
            }
		}
		}
//###################�ĵ������ڵ㸽�Ӳ��� td29590 end// #############################################################


    boolean flowstatus = RequestManager.flowNextNode() ;


    if( !flowstatus ) {
		System.out.println("flowstatus="+flowstatus+"##requestid="+requestid);     
    }
    PoppupRemindInfoUtil.updatePoppupRemindInfo(userid,0,(logintype).equals("1") ? "0" : "1",requestid); 
    boolean logstatus = RequestManager.saveRequestLog() ;

    //��������Ϊ�ĵ���Ч�������ĵ�ʧЧ����ʱ�������ĵ�������������(DocApproveWf)�����ݡ�Ϊ��׼������ʱ�����ġ�
	if(approveType.equals("1")||approveType.equals("2")){
		RecordSet.executeSql("update DocApproveWf set status='1'  where requestId="+requestid);
	}else{//������Ϊ��׼������
        //����request��ѡ�񱣴�logtype=1
		if(src.equals("save")&&isremark==1){
			//��¼ǩ�����
			//дDocApproveRemark��
            Procpara=approveid+flag+remark+flag+""+userid+flag+currentDate+flag+currentTime+flag+"2";
            RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
		}

		if(src.equals("submit")){//����request��ѡ���ύlogtype=2
		    //дDocApproveRemark��
		    if(nodetype.equals("0")) { // ��Ϊ����ע

                Procpara=approveid+flag+remark+flag+""+userid+flag+currentDate+flag+currentTime+flag+"2";
		    }else{
				Procpara=approveid+flag+remark+flag+""+userid+flag+currentDate+flag+currentTime+flag+"1";
			}
			RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
			//DocManager.approveDocFromWF("approve",approveid,currentDate,currentTime,userid+""); 
			if(nodetype.equals("0")){
				RecordSet.executeSql("update DocDetail set docStatus='3'  where id="+approveid);
			}else{
				DocManager.approveDocFromWF("approve",approveid,currentDate,currentTime,userid+""); 
			}

		    if( RequestManager.getNextNodetype().equals("3") )    {
				RecordSet.executeProc("bill_Approve_UpdateStatus",""+billid+flag+"1");
		    }
		}

		if(src.equals("reject")){//����request��ѡ���˻�logtype=3
		    //дDocApproveRemark��
			Procpara=approveid+flag+remark+flag+""+userid+flag+currentDate+flag+currentTime+flag+"0";
			RecordSet.executeProc("DocApproveRemark_Insert",Procpara);
			DocManager.approveDocFromWF("reject",approveid,currentDate,currentTime,userid+"");
		}

	}

  }
}

response.sendRedirect("/docs/docs/ApproveDocList.jsp?approveType="+approveType);

%>