<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.WorkPlan.WorkPlanLogMan" %>
<%@ page import="java.io.StringBufferInputStream"%>
<%@ page import="org.jdom.Document"%>
<%@ page import="org.jdom.Element"%>
<%@ page import="org.jdom.input.SAXBuilder"%>
<%@ page import="org.jdom.output.Format"%>
<%@ page import="org.jdom.output.XMLOutputter"%>
<%@ page import="org.jdom.xpath.XPath"%>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetM" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetT" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetDB" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsXML" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="PrjViewer" class="weaver.proj.PrjViewer" scope="page"/>
<jsp:useBean id="SysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WorkPlanViewer" class="weaver.WorkPlan.WorkPlanViewer" scope="page"/>
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>
<jsp:useBean id="ProjectInfo" class="weaver.proj.ProjectInfo" scope="page" />
<%
char flag = Util.getSeparator() ;
String ProcPara = "";
String strTemp = "";
String method = request.getParameter("method");
String taskrecordid = request.getParameter("taskrecordid");
String ProjID=Util.null2String(request.getParameter("ProjID"));
String parentid=Util.null2String(request.getParameter("parentid"));
String parentids=Util.null2String(request.getParameter("parentids"));
String parenthrmids=Util.null2String(request.getParameter("parenthrmids"));

//=========================================================================================================================
//TD4078
//added by hubo,2006-04-05
int taskIndex = 1;
String sqlTaskIndex = "SELECT MAX(taskindex) AS maxTaskIndex FROM Prj_TaskProcess WHERE prjid="+Util.getIntValue(ProjID)+"";
RecordSet.executeSql(sqlTaskIndex);
if(RecordSet.next()){
	taskIndex = RecordSet.getInt("maxTaskIndex") + 1;
}
//=========================================================================================================================

String hrmid=Util.null2String(request.getParameter("hrmid"));
String oldhrmid=Util.null2String(request.getParameter("oldhrmid"));

/*modified by hubo 050830*/
String finish=Util.null2String(request.getParameter("finish"));
if(finish.endsWith("%")){finish = finish.substring(0,finish.indexOf("%"));}
//TD4174 added by hubo,2006-04-17
if(Util.getIntValue(finish,0)>100){finish="100";}

String level=Util.null2String(request.getParameter("level"));
String subject=Util.null2String(request.getParameter("subject"));
String begindate=Util.null2String(request.getParameter("begindate"));
String enddate=Util.null2String(request.getParameter("enddate"));

//added by hubo 20050829
String actualbegindate = Util.null2String(request.getParameter("actualBeginDate"));
String actualenddate = Util.null2String(request.getParameter("actualEndDate"));

String workday=Util.null2String(request.getParameter("workday"));

String fixedcost=Util.null2String(request.getParameter("fixedcost"));
String islandmark=Util.null2String(request.getParameter("islandmark"));
String pretask=Util.null2String(request.getParameter("taskids02"));
String content=Util.null2String(request.getParameter("content"));
// added by lupeng 2004-07-21
String realManDays = Util.null2String(request.getParameter("realmandays"));
    // add by dongping for  if realManDays is null ("") under excute sql is error!
    //bengin
    if (realManDays.equals("")){
        realManDays="0";
    }
//end
String[] logParams;
WorkPlanLogMan logMan = new WorkPlanLogMan();
// end

//==========================================================
//TD4131
//modified by hubo,2006-04-13
//if(begindate.equals("")) begindate = "x" ;
//if(enddate.equals("")) enddate = "-" ;
//==========================================================
if(workday.equals("")) workday = "1" ;
if(Util.getDoubleValue(workday)<=0) workday = "1" ;
if(finish.equals("")) finish = "0" ;
if(islandmark.equals("")) islandmark="0";
if(fixedcost.equals("")) fixedcost = "0" ;
if(pretask.equals("")) pretask = "0" ;


String taskid = "0" ;
String wbscoding = "0" ;
String version = "0" ;


ArrayList arrayParentids = Util.TokenizerString(parentids,",");



String CurrentUser = ""+user.getUID();
String SubmiterType = ""+user.getLogintype();
String ClientIP = request.getRemoteAddr();

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
String TaskID="";

String SWFAccepter="";
String SWFTitle="";
String SWFRemark="";
String SWFSubmiter="";
String Subject="";
String CurrentUserName = ""+user.getUsername();

String sql_Smanager="select name,manager from Prj_ProjectInfo where id="+ProjID;
RecordSet2.executeSql(sql_Smanager);
RecordSet2.next();
String Prj_manager=RecordSet2.getString("manager");
String Prj_name=RecordSet2.getString("name");

String sql_tatus="select isactived from Prj_TaskProcess where prjid="+ProjID;
RecordSet.executeSql(sql_tatus);
RecordSet.next();
String isactived=RecordSet.getString("isactived");

/*################ADD BY HUANG YU ON April 21,2004 FOR �������� START*/
int[] status = {0, //����
				1, //����
				2, //�޸�
				3}; //ɾ��
int[] log_status = {0, //δ����
					1, //��׼
					2  //�ܾ�
					};
int[] log_operationtype = { 0, //������
							1, //����
                            2, //�޸�
							3  //ɾ��
							};

boolean isPM = false;
  if(CurrentUser.equals(Prj_manager)) isPM = true; /*�Ƿ��� ProjectManager*/

/*################ADD BY HUANG YU ON April 21,2004 FOR �������� END*/
if (method.equals("add"))
{

	ProcPara = ProjID ;
	ProcPara += flag + "" + taskid ;
	ProcPara += flag + "" + wbscoding ;
	ProcPara += flag + "" + subject ;
	ProcPara += flag + "" + version ;
	ProcPara += flag + "" + begindate ;
	ProcPara += flag + "" + enddate ;
	ProcPara += flag + "" + workday ;
	ProcPara += flag + "" + content ;
	ProcPara += flag + "" + fixedcost ;//��ĿԤ��
	ProcPara += flag + "" + parentid ;
	ProcPara += flag + "" + parentids ;
	ProcPara += flag + "" + parenthrmids ;
	ProcPara += flag + "" + level ;
	ProcPara += flag + "" + hrmid ;
    ProcPara += flag + "" + pretask ;
    ProcPara += flag + "" + realManDays ;
	//================================================
	//TD4078	��������ʱ��Ӧ�ñ�����������taskindex
	//added by hubo,2006-04-05
	ProcPara += flag + "" + taskIndex;
	//================================================
	RecordSet.executeProc("Prj_TaskProcess_Insert",ProcPara);

	RecordSet.executeProc("Prj_TaskProcess_SMAXID","");
    while(RecordSet.next()){
    TaskID = RecordSet.getString("maxid_1");
    }
	/*��������״̬Ϊ 1�����Ӵ�����������ͬʱ����һ����������ʷ��¼����*/
	/*############Added By Huang Yu START##################*/

	/*insert to the log table*/

	ProcPara = ProjID ;
	ProcPara += flag + "" + TaskID ;
	ProcPara += flag + "" + subject ;
	ProcPara += flag + "" + hrmid ;
	//ProcPara += flag + "" + begindate ;
	//ProcPara += flag + "" + enddate ;
	if(begindate.equals("")){
		ProcPara += flag + "" + "x" ;
	}else{
		ProcPara += flag + "" + begindate ;
	}
	if(enddate.equals("")){
		ProcPara += flag + "" + "-" ;
	}else{
		ProcPara += flag + "" + enddate ;
	}
	ProcPara += flag + "" + workday ;
	ProcPara += flag + "" + fixedcost ;
	ProcPara += flag + "" + finish /**/;
	ProcPara += flag + "" + parentid ;
	ProcPara += flag + "" + pretask ;  /**/
	ProcPara += flag + "" + islandmark ;
	ProcPara += flag + "" + CurrentDate ;
	ProcPara += flag + "" + CurrentTime ;
	ProcPara += flag + "" + CurrentUser ;
	ProcPara += flag + "" + (isPM?log_status[1]:log_status[0]) ; /*Status: �Ƿ�����Ŀ��������ǣ�ֱ�Ӹ���Ϊ���� 1*/
	ProcPara += flag + "" + log_operationtype[1] ; /*Operation Type*/
	ProcPara += flag + "" + ClientIP ;
    ProcPara += flag + "" + realManDays ;

	RecordSet.executeProc("Prj_TaskModifyLog_Insert",ProcPara);
    ProcPara = ProjID ;
    ProcPara += flag + "" + TaskID ;
    ProcPara += flag + "n"  ;
    ProcPara += flag + "" + CurrentDate ;
    ProcPara += flag + "" + CurrentTime ;
    ProcPara += flag + "" + CurrentUser ;
    ProcPara += flag + "" + ClientIP ;
    ProcPara += flag + "" + SubmiterType ;
    RecordSet.executeProc("Prj_TaskLog_Insert",ProcPara);

	for(int i=arrayParentids.size()-1;i>=0;i--){
		String tmpparentid = ""+arrayParentids.get(i);
		RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
		//out.print("::::"+tmpparentid+"::::");
   	}


    /*����������*/
	/*
    boolean isall=true;
    if(CurrentUser.equals(Prj_manager) && CurrentUser.equals(hrmid)) isall=false;
    if (isall){//�����������Լ���Ҳ�Ǿ���Ͳ�����
        if( CurrentUser.equals(Prj_manager) && ( !CurrentUser.equals(hrmid)) ){//�����Լ�,�����˲����Լ�
            SWFAccepter=hrmid;
        }
        if( (!CurrentUser.equals(Prj_manager) ) && ( !CurrentUser.equals(hrmid)) ){//���Ǿ���������Ҳ�����Լ�
            SWFAccepter=hrmid+","+Prj_manager;
        }
        if ( (!CurrentUser.equals(Prj_manager) ) && ( CurrentUser.equals(hrmid)) ){//���Ǿ������������Լ�
            SWFAccepter= Prj_manager;
        }
        //SWFAccepter=hrmid+","+Prj_manager;
        //SWFTitle=Util.toScreen("��Ŀ",user.getLanguage(),"0");
        //SWFTitle += ":"+Prj_name;
        SWFTitle +=SystemEnv.getHtmlLabelName(15283,user.getLanguage());
        SWFTitle += ":"+subject;
        SWFTitle += "-"+CurrentUserName;
        SWFTitle += "-"+CurrentDate;
        SWFRemark="";
        SWFSubmiter=CurrentUser;

        SysRemindWorkflow.setPrjSysRemind(SWFTitle,Util.getIntValue(ProjID),Util.getIntValue(SWFSubmiter),SWFAccepter,SWFRemark);
    }
	*/


	String tmpsql="";

	tmpsql="update Prj_taskprocess set childnum=childnum+1 where id="+parentid;
	RecordSet.executeSql(tmpsql);

	//Ȩ�޲���

	tmpsql="select * from PrjShareDetail where prjid="+ProjID+" and usertype=1 and userid="+hrmid;
	RecordSet.executeSql(tmpsql);
	if(RecordSet.next()){
		if(RecordSet.getString("sharelevel").equals("1")){
			tmpsql="update PrjShareDetail set sharelevel='5' where prjid="+ProjID+" and usertype=1 and userid="+hrmid;
			RecordSet.executeSql(tmpsql);
		}
	}else{
		ProcPara = ProjID ;
		ProcPara += flag + hrmid ;
		ProcPara += flag + "1" ;
		ProcPara += flag + "5" ;
        RecordSet.executeProc("PrjShareDetail_Insert",""+ProcPara);
	}

	//PrjViewer.setPrjShareByPrj(""+ProjID);


	tmpsql="select * from prj_taskinfo where prjid="+ProjID;
	RecordSet.executeSql(tmpsql);
	if(RecordSet.next()){
		tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
		RecordSet.executeSql(tmpsql);
	}

	//���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
	String begindate01 = "";
	String enddate01 = "";

	RecordSet.executeProc("Prj_TaskProcess_Sum",""+ProjID);
	if(RecordSet.next() && !RecordSet.getString("workday").equals("")){

		if(!RecordSet.getString("begindate").equals("x")) begindate01 = RecordSet.getString("begindate");
		if(!RecordSet.getString("enddate").equals("-")) enddate01 = RecordSet.getString("enddate");

	}
	if (!begindate01.equals("")){
		RecordSet.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and  projectid = '" + ProjID + "' and taskid = -1");
	}
	//���¹����ƻ��и���Ŀ�ľ����ʱ��End


/*���Ϊ��Ŀ�����������޸ģ�������������������Ŀ����״̬*/
    //����״̬

    if(!isPM){ /*������Ŀ��������״̬Ϊ��1��*/
		RecordSet.executeSql("Update Prj_TaskProcess Set Status = "+status[1]+" WHERE ID ="+TaskID);
    }
	else{  /*����Ŀ����Ļ���ֱ�Ӵ������������������������˵ļƻ�*/
         /*����������֪ͨ�������˻���*/
         boolean isall=true;
         if(CurrentUser.equals(Prj_manager) && CurrentUser.equals(hrmid)) isall=false;
         if (isall){//�����������Լ���Ҳ�Ǿ���Ͳ�����
            if( CurrentUser.equals(Prj_manager) && ( !CurrentUser.equals(hrmid)) ){//�����Լ�,�����˲����Լ�
                SWFAccepter=hrmid;
            }
            if( (!CurrentUser.equals(Prj_manager) ) && ( !CurrentUser.equals(hrmid)) ){//���Ǿ���������Ҳ�����Լ�
                SWFAccepter=hrmid+","+Prj_manager;
            }
            if ( (!CurrentUser.equals(Prj_manager) ) && ( CurrentUser.equals(hrmid)) ){//���Ǿ������������Լ�
                SWFAccepter= Prj_manager;
            }
            //SWFAccepter=hrmid+","+Prj_manager;
            //SWFTitle=Util.toScreen("��Ŀ",user.getLanguage(),"0");
            //SWFTitle += ":"+Prj_name;
            SWFTitle +=SystemEnv.getHtmlLabelName(15283,user.getLanguage());
            SWFTitle += ":"+subject;
            SWFTitle += "-"+CurrentUserName;
            SWFTitle += "-"+CurrentDate;
            SWFRemark="";
            SWFSubmiter=CurrentUser;

            SysRemindWorkflow.setPrjSysRemind(SWFTitle,Util.getIntValue(ProjID),Util.getIntValue(SWFSubmiter),SWFAccepter,SWFRemark);
        }

        	//��ӹ����ƻ�Begin
        if (isactived.equals("2")) 
        {
			//��ӹ����ƻ�
       		WorkPlan workPlan = new WorkPlan();
       		
       		workPlan.setCreaterId(Integer.parseInt(CurrentUser));

       	    workPlan.setWorkPlanType(Integer.parseInt(Constants.WorkPlan_Type_ProjectCalendar));        
       	    workPlan.setWorkPlanName(subject);    
       	    workPlan.setUrgentLevel(Constants.WorkPlan_Urgent_Normal);
       	    workPlan.setRemindType(Constants.WorkPlan_Remind_No);  
       	    workPlan.setResourceId(hrmid);           	    
       	    workPlan.setBeginDate(begindate);           	    
       	    workPlan.setBeginTime(Constants.WorkPlan_StartTime);  //��ʼʱ��	    
       	    workPlan.setEndDate(enddate);
       	    workPlan.setEndTime(Constants.WorkPlan_EndTime);  //����ʱ��
       	    workPlan.setDescription(Util.convertInput2DB(Util.null2String(request.getParameter("content"))));
       	    workPlan.setProject(ProjID);
       	    workPlan.setTask(TaskID);

       	    workPlanService.insertWorkPlan(workPlan);  //�����ճ�

			//������־
            logParams = new String[] {String.valueOf(workPlan.getWorkPlanID()), WorkPlanLogMan.TP_CREATE, CurrentUser, request.getRemoteAddr()};
            logMan.writeViewLog(logParams);

        }

        //��ӹ����ƻ�End

    }

	/*############Added By Huang Yu END##################*/


	//============================================================================
	//���ϵ������б�ҳ��������������Ҫ������Ŀ��XML�ֶ�
	//added by hubo,2006-04-05
	int parentTaskIndex = 0;
	if(Util.getIntValue(parentid)!=0){
		String sqlParentTaskIndex = "SELECT taskindex FROM Prj_TaskProcess WHERE id="+Util.getIntValue(parentid)+"";
		RecordSet.executeSql(sqlParentTaskIndex);
		RecordSet.next();
		parentTaskIndex = RecordSet.getInt("taskindex");

		String sqlPrjXML = "SELECT relationXML FROM Prj_projectinfo WHERE id="+Util.getIntValue(ProjID)+"";
		RecordSet.executeSql(sqlPrjXML);
		if(RecordSet.next()){
			try{
				SAXBuilder builder = new SAXBuilder();
				Document xmldoc = builder.build(new StringBufferInputStream(RecordSet.getString("relationXML")));
				Element currentNode = (Element)XPath.selectSingleNode(xmldoc,"//task[@id='"+parentTaskIndex+"']");
				currentNode.addContent(new Element("task").setAttribute("id",String.valueOf(taskIndex)));
				XMLOutputter xmlOutputter = new XMLOutputter();
				String strXMLDoc = xmlOutputter.outputString(xmldoc);
				ProjectInfo.setLinkXml(strXMLDoc);
    			ProjectInfo.setId(ProjID);
    			ProjectInfo.editLinkXml();
			}catch(Exception e){
				//TODO
			}
		}
	}else{//TD4078 Reopen1
		String sqlPrjXML = "SELECT relationXML FROM Prj_projectinfo WHERE id="+Util.getIntValue(ProjID)+"";
		RecordSet.executeSql(sqlPrjXML);
		if(RecordSet.next()){
			try{
				SAXBuilder builder = new SAXBuilder();
				Document xmldoc = builder.build(new StringBufferInputStream(RecordSet.getString("relationXML")));
				xmldoc.getRootElement().addContent(new Element("task").setAttribute("id",String.valueOf(taskIndex)));
				XMLOutputter xmlOutputter = new XMLOutputter();
				String strXMLDoc = xmlOutputter.outputString(xmldoc);
				ProjectInfo.setLinkXml(strXMLDoc);
    			ProjectInfo.setId(ProjID);
    			ProjectInfo.editLinkXml();
			}catch(Exception e){
				//TODO
			}
		}
	}
	//============================================================================

	response.sendRedirect("/proj/process/ViewProcess.jsp?ProjID="+ProjID);
}

else if (method.equals("del"))
{
	/**#################Add by Huang Yu On April 21,2004 START��������**/
	if(!taskrecordid.equals("")){


        ProjID=Util.null2String(request.getParameter("ProjID"));

        ProcPara = taskrecordid ;
		RecordSet.executeProc("Prj_TaskProcess_SelectByID",ProcPara);

		TaskID = taskrecordid;
		if(RecordSet.next()){
			subject = Util.null2String(RecordSet.getString("subject"));
			hrmid = Util.null2String(RecordSet.getString("hrmid"));
			begindate = Util.null2String(RecordSet.getString("begindate"));
			enddate = Util.null2String(RecordSet.getString("enddate"));
			workday = Util.null2String(RecordSet.getString("workday"));
			fixedcost = Util.null2String(RecordSet.getString("fixedcost"));
			finish = Util.null2String(RecordSet.getString("finish"));
			pretask = Util.null2String(RecordSet.getString("prefinish"));
			islandmark = Util.null2String(RecordSet.getString("islandmark"));
			parentid = Util.null2String(RecordSet.getString("parentid"));
		}


		if(begindate.equals("")) begindate = "x" ;
		if(enddate.equals("")) enddate = "-" ;
		if(workday.equals("")) workday = "1" ;
		if(Util.getDoubleValue(workday)<=0) workday = "1" ;
		if(finish.equals("")) finish = "0" ;
		if(islandmark.equals("")) islandmark="0";
		if(fixedcost.equals("")) fixedcost = "0" ;
		if(pretask.equals("")) pretask = "0" ;
		if(parentid.equals("")) parentid = "0";


		/*insert to the log table*/
		ProcPara = ProjID ;
		ProcPara += flag + "" + TaskID ;
		ProcPara += flag + "" + subject ;
		ProcPara += flag + "" + hrmid ;
		ProcPara += flag + "" + begindate ;
		ProcPara += flag + "" + enddate ;
		ProcPara += flag + "" + workday ;
		ProcPara += flag + "" + fixedcost ;
		ProcPara += flag + "" + finish /**/;
		ProcPara += flag + "" + parentid /**/;
		ProcPara += flag + "" + pretask ;  /**/
		ProcPara += flag + "" + islandmark ;
		ProcPara += flag + "" + CurrentDate ;
		ProcPara += flag + "" + CurrentTime ;
		ProcPara += flag + "" + CurrentUser ;
		ProcPara += flag + "" + (isPM?log_status[1]:log_status[0]) ; /*Status*/
		ProcPara += flag + "" + log_operationtype[3] ; /*Operation Type*/
		ProcPara += flag + "" + ClientIP ;
        ProcPara += flag + "" + realManDays ;



		RecordSet.executeProc("Prj_TaskModifyLog_Insert",ProcPara);

        /*insert into the task log */
        ProcPara = ProjID ;
                ProcPara += flag + "" + taskrecordid ;
                ProcPara += flag + "d"  ;
                ProcPara += flag + "" + CurrentDate ;
                ProcPara += flag + "" + CurrentTime ;
                ProcPara += flag + "" + CurrentUser ;
                ProcPara += flag + "" + ClientIP ;
                ProcPara += flag + "" + SubmiterType ;
                RecordSet.executeProc("Prj_TaskLog_Insert",ProcPara);

		if(!isPM){ /*�Ƿ���Project Manager*/
			String sqlstr = "Update Prj_TaskProcess SET status ="+status[3]+" WHERE ID ="+taskrecordid;
			RecordSet.executeSql(sqlstr);

		}else{//�������Ŀ����ֱ��ɾ��
			ProcPara = taskrecordid ;
			RecordSet.executeProc("Prj_TaskProcess_DeleteByID",ProcPara);
			//���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
			String begindate01 = "";
			String enddate01 = "";

			RecordSet.executeProc("Prj_TaskProcess_Sum",""+ProjID);
			if(RecordSet.next() && !RecordSet.getString("workday").equals("")){

				if(!RecordSet.getString("begindate").equals("x")) begindate01 = RecordSet.getString("begindate");
				if(!RecordSet.getString("enddate").equals("-")) enddate01 = RecordSet.getString("enddate");

			}
			if (!begindate01.equals("")){
				RecordSet.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
			}
			//���¹����ƻ��и���Ŀ�ľ����ʱ��End

			//ɾ�������ƻ�Begin
			if (isactived.equals("2")) {
				RecordSet.executeSql("delete from workplan where taskid = " + taskrecordid);
			}
			//ɾ�������ƻ�End


			int i=arrayParentids.size()-2;
			for( i=arrayParentids.size()-2;i>=0;i--){
				String tmpparentid = ""+arrayParentids.get(i);
				RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
			}


			String tmpsql="";
			if(i>=0){
			tmpsql="update Prj_taskprocess set childnum=childnum-1 where id="+arrayParentids.get(arrayParentids.size()-2);
			RecordSet.executeSql(tmpsql);
			}

			//PrjViewer.setPrjShareByPrj(""+ProjID);

			tmpsql="select * from prj_taskinfo where prjid="+ProjID;
			RecordSet.executeSql(tmpsql);
			if(RecordSet.next()){
				tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
				RecordSet.executeSql(tmpsql);
			}
		}


	}
	/**#################Add by Huang Yu On April 21,2004 END**/


	/*COMMENTED BY HUANG YU ON April 21,2004
	ProcPara = taskrecordid ;
	RecordSet.executeProc("Prj_TaskProcess_DeleteByID",ProcPara);

	//���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
	String begindate01 = "";
	String enddate01 = "";

	RecordSet.executeProc("Prj_TaskProcess_Sum",""+ProjID);
	if(RecordSet.next() && !RecordSet.getString("workday").equals("")){

		if(!RecordSet.getString("begindate").equals("x")) begindate01 = RecordSet.getString("begindate");
		if(!RecordSet.getString("enddate").equals("-")) enddate01 = RecordSet.getString("enddate");

	}
	if (!begindate01.equals("")){
		RecordSet.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
	}
	//���¹����ƻ��и���Ŀ�ľ����ʱ��End

	//ɾ�������ƻ�Begin
	if (isactived.equals("2")) {
		RecordSet.executeSql("delete from workplan where taskid = " + taskrecordid);
	}
	//ɾ�������ƻ�End

    ProcPara = ProjID ;
    ProcPara += flag + "" + taskrecordid ;
    ProcPara += flag + "d"  ;
    ProcPara += flag + "" + CurrentDate ;
    ProcPara += flag + "" + CurrentTime ;
    ProcPara += flag + "" + CurrentUser ;
    ProcPara += flag + "" + ClientIP ;
    ProcPara += flag + "" + SubmiterType ;
    RecordSet.executeProc("Prj_TaskLog_Insert",ProcPara);

    int i=arrayParentids.size()-2;
	for( i=arrayParentids.size()-2;i>=0;i--){
		String tmpparentid = ""+arrayParentids.get(i);
		RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
	}


    String tmpsql="";
    if(i>=0){
	tmpsql="update Prj_taskprocess set childnum=childnum-1 where id="+arrayParentids.get(arrayParentids.size()-2);
	RecordSet.executeSql(tmpsql);
    }

	//PrjViewer.setPrjShareByPrj(""+ProjID);

	tmpsql="select * from prj_taskinfo where prjid="+ProjID;
	RecordSet.executeSql(tmpsql);
	if(RecordSet.next()){
		tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
		RecordSet.executeSql(tmpsql);
	}
	*/

	response.sendRedirect("/proj/process/ViewProcess.jsp?ProjID="+ProjID);
}

else if (method.equals("edit"))
{

    String submittype = request.getParameter("submittype");
    boolean bNeedUpdate = false;


    ProcPara = taskrecordid ;
    RecordSetM.executeProc("Prj_TaskProcess_SelectByID",ProcPara);
    RecordSetM.next();


    /*�޸�����*/
    strTemp = RecordSetM.getString("subject");
    if(!subject.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "subject" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ subject+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1" ;
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }

	strTemp = RecordSetM.getString("realManDays");
    if(!subject.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "realManDays" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ subject+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1" ;
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }


    /*�޸ĸ�����*/
    strTemp = RecordSetM.getString("hrmid");//ԭ������
    if(!hrmid.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "hrmid" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ hrmid+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType+flag+"1" ;
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;

        //����������֪ͨԭ�������˺����������ˣ���������һ�����ֵ�½�ߣ���ô�Ͳ�����֪ͨ���ˡ�
        if(isPM){
            if(CurrentUser.equals(Prj_manager)){//�޸����Ǿ���
                if(CurrentUser.equals(strTemp)){//ͬʱԭ������Ҳ���Լ�,ֻҪ֪ͨ��ǰ������
                    SWFAccepter=hrmid;
                }
                else{
                    if(CurrentUser.equals(hrmid)){//ԭ�����˲����Լ����ָ��������Լ�,֪ͨԭ������
                        SWFAccepter = strTemp;
                    }
                    else{//ԭ�����˲����Լ����ָ�����Ҳ�����Լ�:֪ͨԭ�����˺��ָ�����
                        SWFAccepter = hrmid+","+strTemp;
                    }
                }
            }
            else{
                if(CurrentUser.equals(strTemp)){//���Ǿ���ͬʱԭ���������Լ���Ҫ֪ͨ�ָ����˺;���
                    SWFAccepter=hrmid+","+Prj_manager;
                }
                else{
                    if(CurrentUser.equals(hrmid)){//���Ǿ���ͬʱ�ָ��������Լ���֪ͨԭ�����˺;���
                        SWFAccepter=Prj_manager+","+strTemp;
                    }
                    else{//���Ǿ���Ҳ�����ָ����ˡ�֪ͨ������
                        SWFAccepter=hrmid+","+Prj_manager+","+strTemp;
                    }
                }
            }

            //out.print(SWFAccepter);
            String name=ResourceComInfo.getResourcename(hrmid);
            Subject=SystemEnv.getHtmlLabelName(15284,user.getLanguage());
            Subject+=":"+subject+"-";
            Subject+=SystemEnv.getHtmlLabelName(15285,user.getLanguage());
            Subject+=":"+name;

            //SWFTitle=SystemEnv.getHtmlLabelName(101,user.getLanguage());
            //SWFTitle += ":"+Prj_name;
            SWFTitle=SystemEnv.getHtmlLabelName(15284,user.getLanguage());
            SWFTitle += ":"+subject;
            SWFTitle += "-"+CurrentUserName;
            SWFTitle += "-"+CurrentDate;
            SWFRemark="<a href=/proj/process/ViewProcess.jsp?ProjID="+ProjID+">"+Util.fromScreen2(Subject,user.getLanguage())+"</a>";
            SWFSubmiter=CurrentUser;

            SysRemindWorkflow.setPrjSysRemind(SWFTitle,Util.getIntValue(ProjID),Util.getIntValue(SWFSubmiter),SWFAccepter,SWFRemark);
        }
    }

    strTemp = RecordSetM.getString("begindate");
    if(!begindate.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "begindate" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ begindate+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1";
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }

    strTemp = RecordSetM.getString("enddate");
    if(!enddate.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "enddate" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ enddate+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1";
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }


    strTemp = RecordSetM.getString("workday");
    if(!workday.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "workday" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ workday+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType+flag+"1" ;
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }


    strTemp = RecordSetM.getString("finish");
    if(!finish.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "finish" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ finish+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1";
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }

    strTemp = RecordSetM.getString("fixedcost");
    if(!fixedcost.equals(strTemp)){
        ProcPara =ProjID+flag + taskrecordid +flag + "fixedcost" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ fixedcost+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType +flag+"1";
        RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
        bNeedUpdate = true;
    }

    strTemp = Util.null2String(RecordSetM.getString("islandmark"));


    if((!islandmark.equals("")) || (!strTemp.equals(""))){
        if(!islandmark.equals(strTemp)){
            ProcPara =ProjID+flag + taskrecordid +flag + "islandmark" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ islandmark+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType+flag+"1" ;
            RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
            bNeedUpdate = true;
    }
    }

    strTemp = Util.null2String(RecordSetM.getString("content"));


    if((!content.equals("")) || (!strTemp.equals(""))){
        if(!content.equals(strTemp)){
            ProcPara =ProjID+flag + taskrecordid +flag + "content" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ content+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType+flag+"1" ;
            RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
            //bNeedUpdate = true; /*����¼Content�ֶεĸ���*/
    }
    }


    strTemp = Util.null2String(RecordSetM.getString("prefinish"));


    if((!pretask.equals("")) || (!strTemp.equals(""))){
        if(!pretask.equals(strTemp)){
            ProcPara =ProjID+flag + taskrecordid +flag + "pretask" + flag + CurrentDate + flag + CurrentTime + flag+ strTemp+flag+ pretask+ flag+CurrentUser +flag +ClientIP +flag +SubmiterType+flag+"1" ;
            RecordSetT.executeProc("Prj_TaskModify_Insert",ProcPara);
            bNeedUpdate = true;
		}
    }

	if(!hrmid.equals(oldhrmid)){
		//PrjViewer.setPrjShareByPrj(""+ProjID);
	}


	String tmpsql="select * from prj_taskinfo where prjid="+ProjID;
	RecordSet.executeSql(tmpsql);
	if(RecordSet.next()){
		tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
		RecordSet.executeSql(tmpsql);
	}

    if(bNeedUpdate){
        if(submittype.equals("0")){
			ProcPara = taskrecordid ;
			ProcPara += flag + "" + wbscoding ;
			ProcPara += flag + "" + subject ;
			ProcPara += flag + "" + begindate ;
			ProcPara += flag + "" + enddate ;
			ProcPara += flag + "" + actualbegindate ;
			ProcPara += flag + "" + actualenddate ;
			ProcPara += flag + "" + workday ;
			ProcPara += flag + "" + content ;
			ProcPara += flag + "" + fixedcost ;
			ProcPara += flag + "" + hrmid ;
			ProcPara += flag + "" + oldhrmid ;
			ProcPara += flag + "" + finish ;
			ProcPara += flag + "" + '0' ;
			ProcPara += flag + "" + islandmark ;
			ProcPara += flag + "" + pretask ;
            ProcPara += flag + "" + realManDays ;
        }
        else{
			ProcPara = taskrecordid ;
			ProcPara += flag + "" + wbscoding ;
			ProcPara += flag + "" + subject ;
			ProcPara += flag + "" + begindate ;
			ProcPara += flag + "" + enddate ;
			ProcPara += flag + "" + actualbegindate ;
			ProcPara += flag + "" + actualenddate ;
			ProcPara += flag + "" + workday ;
			ProcPara += flag + "" + content ;
			ProcPara += flag + "" + fixedcost ;
			ProcPara += flag + "" + hrmid ;
			ProcPara += flag + "" + oldhrmid ;
			ProcPara += flag + "" + finish ;
			ProcPara += flag + "" + '1' ;
			ProcPara += flag + "" + islandmark ;
			ProcPara += flag + "" + pretask ;
            ProcPara += flag + "" + realManDays ;
        }
        RecordSet.executeProc("Prj_TaskProcess_Update",ProcPara);
        //db2 trigger->procedure
        /*
        CREATE PROCEDURE Trigger_Proc_02 
        (
        in begindate char(10),
        in enddate char(10),
        in isdelete smallint ,
        in hrmid integer
        ) 
        */



        if (RecordSetDB.getDBType().equals("db2")){
            ProcPara = begindate ;
            ProcPara += flag + "" + enddate ;
            ProcPara += flag + "" + '0' ;
            ProcPara += flag + "" + hrmid ;
       //   RecordSet.executeProc("Trigger_Proc_02",ProcPara);
        }

    }
    ProcPara = ProjID ;
    ProcPara += flag + "" + taskrecordid ;
    ProcPara += flag + "m"  ;
    ProcPara += flag + "" + CurrentDate ;
    ProcPara += flag + "" + CurrentTime ;
    ProcPara += flag + "" + CurrentUser ;
    ProcPara += flag + "" + ClientIP ;
    ProcPara += flag + "" + SubmiterType ;
    RecordSet.executeProc("Prj_TaskLog_Insert",ProcPara);

    //���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
    String begindate01 = "";
    String enddate01 = "";

    RecordSet.executeProc("Prj_TaskProcess_Sum",""+ProjID);
    if(RecordSet.next() && !RecordSet.getString("workday").equals("")){

        if(!RecordSet.getString("begindate").equals("x")) begindate01 = RecordSet.getString("begindate");
        if(!RecordSet.getString("enddate").equals("-")) enddate01 = RecordSet.getString("enddate");

    }
    if (!begindate01.equals("")){
        RecordSet.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
    }
    //���¹����ƻ��и���Ŀ�ľ����ʱ��End

    //�༭�����ƻ�Begin
    if (isactived.equals("2")) {
        String para = "";
        String workid = "";
        RecordSet.executeSql("select id from workplan where taskid = " + taskrecordid);
        if (RecordSet.next()) {
            workid = RecordSet.getString("id");

            para = workid;
            para +=flag+"2"; //type_n
            para +=flag+subject;
            para +=flag+hrmid;
            para +=flag+begindate;
            para +=flag+""; //BeginTime
            para +=flag+enddate;
            para +=flag+""; //EndTime
            //para +=flag+"008DC8";
            para +=flag+content;
            para +=flag+"0";//requestid
            para +=flag+ProjID;//projectid
            para +=flag+"0";//crmid
            para +=flag+"0";//docid
            para +=flag+"0";//meetingid
            para +=flag+"1";//isremind;
            para +=flag+"0";//waketime;
            
            para +=flag+taskid;//taskid
            para +=flag+level;//urgentlevel
            
			//TD.6769
			para += flag + "1";  //remindType
			para += flag + "";  //remindBeforeStart
			para += flag + "";  //remindBeforeEnd
			para += flag + "0";  //remindTimesBeforeStart
			para += flag + "0";  //remindTimesBeforeEnd
			para += flag + "";  //remindDateBeforeStart
			para += flag + "";  //remindTimeBeforeStart
			para += flag + "";  //remindDateBeforeEnd
			para += flag + "";  //remindTimeBeforeEnd
			para += flag + "-1";  //hrmPerformanceCheckDetailID

            RecordSet.executeProc("WorkPlan_Update",para);
            WorkPlanViewer.setWorkPlanShareById(workid);
        }
    }
    //�༭�����ƻ�End

	//TD5181
	//modified by hubo, 2006-10-19
    for(int i=0; i<arrayParentids.size(); i++){
        String tmpparentid = ""+arrayParentids.get(i);
        tmpparentid =Util.StringReplace(tmpparentid,"\'", "");
		  if(tmpparentid.equals(taskrecordid)||tmpparentid.equals("")) continue;
        RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
        // out.print(RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid));
    }

    if(bNeedUpdate){
        /**ADD BY HUANG YU ON April 22,2004###########START##############**/

        TaskID = taskrecordid;
        subject = Util.null2String(RecordSetM.getString("subject"));
        hrmid = Util.null2String(RecordSetM.getString("hrmid"));
        begindate = Util.null2String(RecordSetM.getString("begindate"));
        enddate = Util.null2String(RecordSetM.getString("enddate"));
        workday = Util.null2String(RecordSetM.getString("workday"));
        fixedcost = Util.null2String(RecordSetM.getString("fixedcost"));
        finish = Util.null2String(RecordSetM.getString("finish"));
        pretask = Util.null2String(RecordSetM.getString("prefinish"));
        islandmark = Util.null2String(RecordSetM.getString("islandmark"));
        parentid = Util.null2String(RecordSetM.getString("parentid"));

        if(begindate.equals("")) begindate = "x" ;
        if(enddate.equals("")) enddate = "-" ;
        if(workday.equals("")) workday = "1" ;
        if(Util.getDoubleValue(workday)<=0) workday = "1" ;
        if(finish.equals("")) finish = "0" ;
        if(islandmark.equals("")) islandmark="0";
        if(fixedcost.equals("")) fixedcost = "0" ;
        if(pretask.equals("")) pretask = "0" ;
        if(parentid.equals("")) parentid = "0";

        if(!isPM){
            String sqlstr = "Update Prj_TaskProcess SET status ="+status[2]+" WHERE ID ="+taskrecordid;
            RecordSet.executeSql(sqlstr);
        }else{
            String sqlStr = "Update Prj_TaskModifyLog Set status = 2 WHERE status="+log_status[0]+" and OperationType="+log_operationtype[2]+" and  taskID ="+taskrecordid ;
            RecordSet.executeSql(sqlStr);

            String sqlstr = "Update Prj_TaskProcess SET status ="+status[0]+" WHERE ID ="+taskrecordid;
            RecordSet.executeSql(sqlstr);
        }

        /*insert to the log table*/
        ProcPara = ProjID ;
        ProcPara += flag + "" + TaskID ;
        ProcPara += flag + "" + subject ;
        ProcPara += flag + "" + hrmid ;
        ProcPara += flag + "" + begindate ;
        ProcPara += flag + "" + enddate ;
        ProcPara += flag + "" + workday ;
        ProcPara += flag + "" + fixedcost ;
        ProcPara += flag + "" + finish /**/;
        ProcPara += flag + "" + parentid /**/;
        ProcPara += flag + "" + pretask ;  /**/
        ProcPara += flag + "" + islandmark ;
        ProcPara += flag + "" + CurrentDate ;
        ProcPara += flag + "" + CurrentTime ;
        ProcPara += flag + "" + CurrentUser ;
        ProcPara += flag + "" + (isPM?log_status[1]:log_status[0]) ; /*Status*/
        ProcPara += flag + "" + log_operationtype[2] ; /*Operation Type*/
        ProcPara += flag + "" + ClientIP ;
        ProcPara += flag + "" + realManDays ;


        RecordSet.executeProc("Prj_TaskModifyLog_Insert",ProcPara);

        /**ADD BY HUANG YU ON April 22,2004###########END#############**/

    }
    response.sendRedirect("/proj/process/ViewTask.jsp?taskrecordid="+taskrecordid);
}

else if (method.equals("uporder")) {
    String para = taskrecordid + flag+ "1";
    RecordSet.executeProc("PrjTaskProcess_UOrder",para);
    response.sendRedirect("ViewProcess.jsp?ProjID="+ProjID);
}

else if (method.equals("downorder")) {
    String para = taskrecordid + flag+ "2";
    RecordSet.executeProc("PrjTaskProcess_UOrder",para);
    response.sendRedirect("ViewProcess.jsp?ProjID="+ProjID);
}

%>