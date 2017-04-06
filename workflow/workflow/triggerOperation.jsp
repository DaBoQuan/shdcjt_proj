<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
<%
	if(!HrmUserVarify.checkUserRight("WorkflowManage:All", user)){
		response.sendRedirect("/notice/noright.jsp");
  	return;
	}
%>
<%	
	int wfid = Util.getIntValue(Util.null2String(request.getParameter("wfid")),0);//����id
	int wokflowformid = 0;
	rs1.executeSql("select formid from workflow_base where id="+wfid);
	if(rs1.next()) wokflowformid = Util.getIntValue(rs1.getString("formid"),0);
	
	if(wfid!=0){
		RecordSetTrans.setAutoCommit(false);
		try{
			//��ɾ��
			RecordSetTrans.executeSql("select id from Workflow_DataInput_entry where WorkFlowID="+wfid);
			String entryIDs = ",";
			while(RecordSetTrans.next()){
				entryIDs += RecordSetTrans.getInt("id")+",";
			}
			RecordSetTrans.executeSql("delete from Workflow_DataInput_entry where WorkFlowID="+wfid);
			
			ArrayList entryIDsArr = Util.TokenizerString(entryIDs,",");
			String DataInputIDs = ",";
			for(int i=0;i<entryIDsArr.size();i++){
				String entryID = (String)entryIDsArr.get(i);
				RecordSetTrans.executeSql("select id from Workflow_DataInput_main where entryID="+entryID);
				while(RecordSetTrans.next()){
					DataInputIDs += RecordSetTrans.getInt("id")+",";
				}
				RecordSetTrans.executeSql("delete from Workflow_DataInput_main where entryID="+entryID);
			}
			
			ArrayList DataInputIDsArr = Util.TokenizerString(DataInputIDs,",");
			for(int i=0;i<DataInputIDsArr.size();i++){
				String DataInputID = (String)DataInputIDsArr.get(i);
				RecordSetTrans.executeSql("delete from Workflow_DataInput_table where DataInputID="+DataInputID);
				RecordSetTrans.executeSql("delete from Workflow_DataInput_field where DataInputID="+DataInputID);
			}
			
			//�����
			String txtUserUse = Util.null2String(request.getParameter("txtUserUse"));//�����ֶ�����
			if(txtUserUse.equals("1")){
				int triggerNum = Util.getIntValue(Util.null2String(request.getParameter("triggerNum")),0);
				for(int i=0;i<triggerNum;i++){
					String triggerField = Util.null2String(request.getParameter("triggerField"+i));//�����ֶ�
					if(triggerField.equals("")) continue;
					String triggerFieldType = Util.null2String(request.getParameter("triggerFieldType"+i));//�����ֶ�����
					RecordSetTrans.executeSql("insert into Workflow_DataInput_entry(workflowid,triggerfieldname,type) values("+wfid+",'field"+triggerField+"'"+",'"+triggerFieldType+"'"+")");
					
					int entryId = 0;
					RecordSetTrans.executeSql("select max(id) as entryId from Workflow_DataInput_entry");
					if(RecordSetTrans.next()) entryId = RecordSetTrans.getInt("entryId");
					int triggerSettingRows = Util.getIntValue(Util.null2String(request.getParameter("triggerSettingRows_"+i)),0);
					for(int j=0;j<triggerSettingRows;j++){
						String tabletype = Util.null2String(request.getParameter("tabletype"+i+j));//�����ֶ�����������
						String tableralations = Util.null2String(request.getParameter("tableralations"+i+j));//��֮���������
						String datasourcename = Util.null2String(request.getParameter("datasource"+i+j));//����Դ
						RecordSetTrans.executeSql("insert into Workflow_DataInput_main(entryID,WhereClause,IsCycle,OrderID,datasourcename) values("+entryId+",'"+tableralations+"'"+",1,"+(i+1)+",'"+datasourcename+"')");
						
						int DataInputID = 0;
						RecordSetTrans.executeSql("select max(id) as DataInputID from Workflow_DataInput_main");	
						if(RecordSetTrans.next()) DataInputID = RecordSetTrans.getInt("DataInputID");
						
						int tableTableRows = Util.getIntValue(Util.null2String(request.getParameter("tableTableRowsNum_"+i+"_"+j)),0);
						for(int m=1;m<=tableTableRows;m++){
							String tableTableName = Util.null2String(request.getParameter("tablename"+i+j+m));//�������ݿ����
							String tableTableByName = Util.null2String(request.getParameter("tablebyname"+i+j+m));//����
							String formid = Util.null2String(request.getParameter("formid"+i+j+m));//��id
							if(!tableTableName.equals("")||!tableTableByName.equals(""))
							    RecordSetTrans.executeSql("insert into Workflow_DataInput_table(DataInputID,TableName,Alias,FormId) values("+DataInputID+",'"+tableTableName+"'"+",'"+tableTableByName+"','"+formid+"')");
						}
						
						int parameterTableRows = Util.getIntValue(Util.null2String(request.getParameter("parameterTableRowsNum_"+i+"_"+j)),0);
						for(int m=1;m<parameterTableRows;m++){
							String parafieldname = Util.null2String(request.getParameter("parafieldname"+i+j+m));//ȡֵ����-�������ֶ�
							String parawfField = Util.null2String(request.getParameter("parawfField"+i+j+m));//ȡֵ����-�������ֶ�
							if(parafieldname.equals("")||parawfField.equals("")) continue;
							String parafieldtablename = Util.null2String(request.getParameter("parafieldtablename"+i+j+m));//�ֶ���������
							int TableID = 0;
							RecordSetTrans.executeSql("select id from Workflow_DataInput_table where DataInputID="+DataInputID+" and TableName='"+parafieldtablename+"'");
							if(RecordSetTrans.next()) TableID = RecordSetTrans.getInt("id");
							RecordSetTrans.executeSql("insert into Workflow_DataInput_field(DataInputID,TableID,Type,DBFieldName,PageFieldName) values("+DataInputID+","+TableID+",1,"+"'"+parafieldname+"'"+",'field"+parawfField+"'"+")");
						}
						
						String evaluatewfFields = "";
						int evaluateTableRows = Util.getIntValue(Util.null2String(request.getParameter("evaluateTableRowsNum_"+i+"_"+j)),0);
						for(int m=1;m<evaluateTableRows;m++){
							String evaluatefieldname = Util.null2String(request.getParameter("evaluatefieldname"+i+j+m));//ȡֵ����-�������ֶ�
							String evaluatewfField = Util.null2String(request.getParameter("evaluatewfField"+i+j+m));//ȡֵ����-�������ֶ�
							if(evaluatefieldname.equals("")||evaluatewfField.equals("")) continue;
							evaluatewfFields += evaluatewfField + ",";
							String evaluatefieldtablename = Util.null2String(request.getParameter("evaluatefieldtablename"+i+j+m));//�ֶ���������
							int TableID = 0;
							RecordSetTrans.executeSql("select id from Workflow_DataInput_table where DataInputID="+DataInputID+" and TableName='"+evaluatefieldtablename+"'");
							if(RecordSetTrans.next()) TableID = RecordSetTrans.getInt("id");
							RecordSetTrans.executeSql("insert into Workflow_DataInput_field(DataInputID,TableID,Type,DBFieldName,PageFieldName) values("+DataInputID+","+TableID+",2,"+"'"+evaluatefieldname+"'"+",'field"+evaluatewfField+"'"+")");
						}
						if(!evaluatewfFields.equals("")){//�ж���һ�����������У������ֶκͱ������ֶ��Ƿ�����ͬ�飨ͬΪ���ֶλ�Ϊͬһ��ϸ��
						    evaluatewfFields += triggerField;
						    RecordSetTrans.executeSql("select distinct groupId from workflow_formfield where formid="+wokflowformid+" and fieldid in ("+evaluatewfFields+")");
						    if(RecordSetTrans.getCounts()>1){//�ֶβ�����ͬһ��
						        RecordSetTrans.rollback();
						        response.sendRedirect("fieldTrigger.jsp?ajax=1&wfid="+wfid+"&message=reset");
						        return;
						    }
						}
						
					}
				}
			}
			RecordSetTrans.commit();
		}catch(Exception exception){
			RecordSetTrans.rollback();
		}
	}
	response.sendRedirect("fieldTrigger.jsp?ajax=1&wfid="+wfid);
%>


