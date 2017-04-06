<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.proj.Maint.*" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>
<%@ page import="weaver.WorkPlan.WorkPlanViewer" %>

<jsp:useBean id="SysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page" />
<jsp:useBean id="WorkPlanViewer" class="weaver.WorkPlan.WorkPlanViewer" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>

<%
    String hrmid="" ;
    int status = 0;
    String subject="";
    String begindate="";
    String enddate="";
    String content="";
    String ProjID ="";
    String parentids ="";


    char flag = Util.getSeparator();

    Date newdate = new Date() ;
    long datetime = newdate.getTime() ;
    Timestamp timestamp = new Timestamp(datetime) ;
    String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
    String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);


    String CurrentUser = ""+user.getUID();
    String CurrentUserName = ""+user.getUsername();
    String SWFAccepter="";
    String SWFTitle="";
    String SWFRemark="";
    String SWFSubmiter="";

    int manager =0;
    int taskID = Util.getIntValue(request.getParameter("TaskID"));
    String sqlStr ="";
    /*Test if the current user is the project manager*/
    if(taskID>0){
     sqlStr =" Select distinct t1.ID,t1.manager,t2.parentids,t2.hrmid,t2.subject,t2.begindate,t2.enddate,t2.content,t2.status from Prj_ProjectInfo t1,Prj_TaskProcess t2 where t1.ID = t2.PrjID and t2.ID = "+taskID;
        RecordSet rs = new RecordSet();
        rs.executeSql(sqlStr);
        if(rs.next()){
            manager = rs.getInt("manager");
            hrmid = rs.getString("hrmid");
            subject = rs.getString("subject");
            begindate = rs.getString("begindate");
            enddate = rs.getString("enddate");
            content = rs.getString("content");
            status = rs.getInt("status") ;
            ProjID = rs.getString("ID");
            parentids = rs.getString("parentids");

        }
    }

    String Prj_manager = ""+manager;
    ArrayList arrayParentids = Util.TokenizerString(parentids,",");

    if(user.getUID() != manager){
        response.sendRedirect("/notice/noright.jsp") ;
        return;
    }

    /*If the task has been approved,then redirect to the task log page*/
    if(status == ProjectTask.APPROVED){
        response.sendRedirect("ProjectTaskApprovalDetail.jsp?TaskID="+taskID) ;
        return;
    }
    String method = Util.null2String (request.getParameter("method"));
    if(method.equals("approve") && method.equals("refuse")){
        response.sendRedirect("/notice/noright.jsp") ;
        return;
    }

    RecordSet rs = new RecordSet();


//================================================================================
//TD2521
//added by hubo,2006-03-19
int taskModifyLogMaxId = 0;
sqlStr = "Select MAX(id) AS maxid FROM Prj_TaskModifyLog WHERE TaskID="+taskID+"";
rs.executeSql(sqlStr);
if(rs.next()){
	taskModifyLogMaxId = rs.getInt("maxid");
}
//================================================================================



       /*approve operation*/
    if(method.equals("approve")){
         if(status == ProjectTask.DELETE_UNAPPROVED){
                String ProcPara ="";
           ProcPara = ""+taskID ;
			rs.executeProc("Prj_TaskProcess_DeleteByID",ProcPara);
			//���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
			String begindate01 = "";
			String enddate01 = "";

			rs.executeProc("Prj_TaskProcess_Sum",""+ProjID);
			if(rs.next() && !rs.getString("workday").equals("")){

				if(!rs.getString("begindate").equals("x")) begindate01 = rs.getString("begindate");
				if(!rs.getString("enddate").equals("-")) enddate01 = rs.getString("enddate");

			}
			if (!begindate01.equals("")){
				rs.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
			}
			//���¹����ƻ��и���Ŀ�ľ����ʱ��End

			//ɾ�������ƻ�Begin

			rs.executeSql("delete from workplan where taskid = " + taskID);

			//ɾ�������ƻ�End

			int i=arrayParentids.size()-2;
			for( i=arrayParentids.size()-2;i>=0;i--){
				String tmpparentid = ""+arrayParentids.get(i);
				rs.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
			}


			String tmpsql="";
			if(i>=0){
			tmpsql="update Prj_taskprocess set childnum=childnum-1 where id="+arrayParentids.get(arrayParentids.size()-2);
			rs.executeSql(tmpsql);
			}

			//PrjViewer.setPrjShareByPrj(""+ProjID);
			tmpsql="select * from prj_taskinfo where prjid="+ProjID;
			rs.executeSql(tmpsql);
			if(rs.next()){
				tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
				rs.executeSql(tmpsql);
			}


        }else if(status == ProjectTask.ADD_UNAPPROVED){
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
           	    
           	 	String workPlanDescription = Util.null2String(content);
     	    	workPlanDescription = Util.replace(workPlanDescription, "\n", "", 0);
     	    	workPlanDescription = Util.replace(workPlanDescription, "\r", "", 0);
           	    workPlan.setDescription(workPlanDescription);           	    
           	    
           	    workPlan.setProject(ProjID);
           	    workPlan.setTask(""+taskID);

           	    workPlanService.insertWorkPlan(workPlan);  //�����ճ�
                


        }else if(status == ProjectTask.MODIFY_UNAPPROVED){
            sqlStr = "Select  * From Prj_TaskModifyLog WHERE status=0 and OperationType = "+ProjectTask.MODIFY_UNAPPROVED+"  and TaskID="+taskID+" Order by ID ";
            rs.executeSql(sqlStr);
            String strTemp = hrmid ;
            String Subject = "";
            if(hrmid.equals(rs.getString("HrmID"))){
                //����������֪ͨԭ�������˺����������ˣ���������һ�����ֵ�½�ߣ���ô�Ͳ�����֪ͨ���ˡ�
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

        /*Update the task status first*/

        sqlStr ="Update Prj_TaskProcess Set status=0 Where ID="+taskID;
        rs.executeSql(sqlStr);
        /*Then Update the Log Status */
		  //TD2521
		  //modified by hubo,2006-03-19
        sqlStr ="Update Prj_TaskModifyLog Set status = 1 WHERE id="+taskModifyLogMaxId;
        rs.executeSql(sqlStr);

        response.sendRedirect("ProjectTaskApprovalDetail.jsp?TaskID="+taskID) ;
        return;
    }
        /*refuse operation*/
    if(method.equals("refuse")){

        if(status == ProjectTask.DELETE_UNAPPROVED){
                sqlStr ="Update Prj_TaskProcess Set status=0 Where ID="+taskID;
                rs.executeSql(sqlStr);

        }else if(status == ProjectTask.ADD_UNAPPROVED){
             sqlStr = "Update Prj_TaskProcess Set status=0 WHERE ID="+taskID;
             rs.executeSql(sqlStr);
            String ProcPara ="";
           ProcPara = ""+taskID ;
			rs.executeProc("Prj_TaskProcess_DeleteByID",ProcPara);
			//���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
			String begindate01 = "";
			String enddate01 = "";

			rs.executeProc("Prj_TaskProcess_Sum",""+ProjID);
			if(rs.next() && !rs.getString("workday").equals("")){

				if(!rs.getString("begindate").equals("x")) begindate01 = rs.getString("begindate");
				if(!rs.getString("enddate").equals("-")) enddate01 = rs.getString("enddate");

			}
			if (!begindate01.equals("")){
				rs.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
			}
			//���¹����ƻ��и���Ŀ�ľ����ʱ��End

			//ɾ�������ƻ�Begin

			rs.executeSql("delete from workplan where taskid = " + taskID);

			//ɾ�������ƻ�End

			int i=arrayParentids.size()-2;
			for( i=arrayParentids.size()-2;i>=0;i--){
				String tmpparentid = ""+arrayParentids.get(i);
				rs.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
			}


			String tmpsql="";
			if(i>=0){
			tmpsql="update Prj_taskprocess set childnum=childnum-1 where id="+arrayParentids.get(arrayParentids.size()-2);
			rs.executeSql(tmpsql);
			}

			//PrjViewer.setPrjShareByPrj(""+ProjID);
			tmpsql="select * from prj_taskinfo where prjid="+ProjID;
			rs.executeSql(tmpsql);
			if(rs.next()){
				tmpsql="update prj_taskprocess set isactived=2 where prjid="+ProjID;
				rs.executeSql(tmpsql);
			}
        }else if(status == ProjectTask.MODIFY_UNAPPROVED){
             /*restore the task info*/
            sqlStr = "Select  * From Prj_TaskModifyLog WHERE status=0 and OperationType = "+ProjectTask.MODIFY_UNAPPROVED+"  and TaskID="+taskID+" Order by ID ";
            rs.executeSql(sqlStr);
            if(rs.next()) {
                sqlStr = "Update Prj_TaskProcess Set" +
                        " Subject='" +rs.getString("Subject")+   "'"+
                        ",HrmID=" + rs.getString("HrmID")+
                        ",BeginDate='" +  rs.getString("BeginDate")+ "'"+
                        ",EndDate='" +rs.getString("EndDate")+ "'"+
                        ",WorkDay=" + rs.getString("WorkDay")+
                        ",FixedCost=" + rs.getString("FixedCost")+
                        ",Finish=" +  rs.getString("Finish")+
                        ",Prefinish='" + rs.getString("Prefinish")+   "'"+
                        ",isLandMark='" +   rs.getString("isLandMark")+  "'"+
                        ",status=0 " +
                        " Where ID="+taskID;

                 rs.executeSql(sqlStr);

                manager = rs.getInt("manager");
              hrmid = rs.getString("hrmid");
              subject = rs.getString("subject");
              begindate = rs.getString("begindate");
              enddate = rs.getString("enddate");
              content = rs.getString("content");
              status = rs.getInt("status") ;
              ProjID = rs.getString("ID");
              parentids = rs.getString("parentids");

                //�༭�����ƻ�Begin

                   String para = "";
                   String workid = "";
                   rs.executeSql("select id from workplan where taskid = " + taskID);

                   if (rs.next()) {
                       workid = rs.getString("id");

                       para = workid;
                       para +=flag+"2"; //type_n
                       para +=flag+subject;
                       para +=flag+hrmid;
                       para +=flag+begindate;
                       para +=flag+""; //BeginTime
                       para +=flag+enddate;
                       para +=flag+""; //EndTime
                       para +=flag+"008DC8";
                       para +=flag+content;
                       para +=flag+"0";//requestid
                       para +=flag+ProjID;//projectid
                       para +=flag+"0";//crmid
                       para +=flag+"0";//docid
                       para +=flag+"0";//meetingid
                       para +=flag+"1";//isremind;
                       para +=flag+"0";//waketime;

                       rs.executeProc("WorkPlan_Update",para);
                       WorkPlanViewer.setWorkPlanShareById(workid);
                   }

               //�༭�����ƻ�End
            }
            //���¹����ƻ��и���Ŀ�ľ����ʱ��Begin
               String begindate01 = "";
               String enddate01 = "";

               rs.executeProc("Prj_TaskProcess_Sum",""+ProjID);
               if(rs.next() && !rs.getString("workday").equals("")){

                   if(!rs.getString("begindate").equals("x")) begindate01 = rs.getString("begindate");
                   if(!rs.getString("enddate").equals("-")) enddate01 = rs.getString("enddate");

               }
               if (!begindate01.equals("")){
                   rs.executeSql("update workplan set begindate = '" + begindate01 + "',enddate = '" + enddate01 + "' where type_n = '2' and projectid = '" + ProjID + "' and taskid = -1");
               }
               //���¹����ƻ��и���Ŀ�ľ����ʱ��End



               for(int i=arrayParentids.size()-2;i>=0;i--){
                   String tmpparentid = ""+arrayParentids.get(i);
                   rs.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid);
                   // out.print(RecordSet.executeProc("Prj_TaskProcess_UpdateParent",tmpparentid));
               }

        }

        /*Then Update the Log Status */
		  //TD2521
		  //modified by hubo,2006-03-19
        sqlStr ="Update Prj_TaskModifyLog Set status = 2 WHERE id="+taskModifyLogMaxId;
        rs.executeSql(sqlStr);
        response.sendRedirect("ProjectTaskApprovalDetail.jsp?TaskID="+taskID) ;
        return;
    }
%>