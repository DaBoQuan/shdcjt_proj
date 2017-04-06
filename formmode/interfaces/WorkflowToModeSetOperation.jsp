<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<%
if(!HrmUserVarify.checkUserRight("ModeSetting:All", user)){
	response.sendRedirect("/notice/noright.jsp");
	return;
}

String operation = Util.null2String(request.getParameter("operation"));
char separator = Util.getSeparator() ;
String sql = "";

int workflowid = Util.getIntValue(request.getParameter("workflowid"),0);
int modeid = Util.getIntValue(request.getParameter("modeid"),0);
int id = Util.getIntValue(request.getParameter("id"),0);
int modecreater = Util.getIntValue(request.getParameter("modecreater"),0);
int modecreaterfieldid = Util.getIntValue(request.getParameter("modecreaterfieldid"),0);
int detailno = Util.getIntValue(request.getParameter("detailno"),0);
int triggerNodeId = Util.getIntValue(request.getParameter("triggerNodeId"),0);
int triggerType = Util.getIntValue(request.getParameter("triggerType"),0);
int isenable = Util.getIntValue(request.getParameter("isenable"),0);
int tempid = id;
String isnode = "1";
String type = "2";

int initworkflowid = Util.getIntValue(request.getParameter("initworkflowid"),0);
int initmodeid = Util.getIntValue(request.getParameter("initmodeid"),0);

//��ɾ�����������±���
if (operation.equals("save")) {
	String customervalue = "action.WorkflowToMode";//ͨ��action��ʹ���̵�����תΪ��Ƭ����
	if(modecreater!=3){
		modecreaterfieldid = 0;
	}
	
	if(id>0){//�༭
		
		//ɾ���ϵ�action
		int oldworkflowid = 0;
		int oldtriggerNodeId = 0;
		int oldtriggerType = 0;
		int oldisenable = 0;
		
		sql = "select * from mode_workflowtomodeset where id = " + id;
		rs.executeSql(sql);
		while(rs.next()){
			oldworkflowid = rs.getInt("workflowid");
			oldtriggerNodeId  = rs.getInt("triggerNodeId");
			oldtriggerType  = rs.getInt("triggerType");
			oldisenable  = rs.getInt("isenable");
		}
		
		if(oldisenable==1){//�Ƿ�����
			sql = "select id,wftomodesetid from workflow_addinoperate where objid = "+oldtriggerNodeId+" and ispreadd = '"+oldtriggerType+"' and isnode = "+isnode+" and workflowid = "+oldworkflowid+" and type = "+type;
			rs.executeSql(sql);
			//new weaver.general.BaseBean().writeLog(sql);
			while(rs.next()){
				int _id = rs.getInt("id");//
				String _wftomodesetid = Util.null2String(rs.getString("wftomodesetid"));//
				_wftomodesetid = ","+_wftomodesetid+",";
				_wftomodesetid = _wftomodesetid.replace(","+id+",","");
				if(_wftomodesetid.replace(",","").equals("")){
					sql = "delete from workflow_addinoperate where id = " + _id;
				}else{
					if(_wftomodesetid.startsWith(",")){
						_wftomodesetid = _wftomodesetid.substring(1);
					}
					if(_wftomodesetid.endsWith(",")){
						_wftomodesetid = _wftomodesetid.substring(0,_wftomodesetid.length()-1);
					}
					sql = "update workflow_addinoperate set wftomodesetid = '"+_wftomodesetid+"' where id = " + _id;
				}
				RecordSet.executeSql(sql);
			}
		}
				
		//�޸�����
		sql = "update mode_workflowtomodeset set isenable = "+isenable+",modeid = "+modeid+",workflowid = "+workflowid+",modecreater = "+modecreater+",modecreaterfieldid = "+modecreaterfieldid+",triggerNodeId = "+triggerNodeId+",triggerType = "+triggerType+" where id = " + id;
		rs.executeSql(sql);
		
		//ɾ���Ѿ����úõ���ϸ����
		sql = "delete from mode_workflowtomodesetdetail where mainid = " + id;
		rs.executeSql(sql);
		
        for(int i=0;i<=detailno;i++){
        	String wffieldidvalues[] = request.getParameterValues("wffieldid"+i);
        	String modefieldidvalues[] = request.getParameterValues("modefieldid"+i);
        	
        	if(wffieldidvalues!=null && modefieldidvalues!=null){
        		for(int j=0;j<wffieldidvalues.length;j++){
        			int wffieldidvalue = Util.getIntValue((String)wffieldidvalues[j],0);
        			int modefieldidvalue = Util.getIntValue((String)modefieldidvalues[j],0);
        			
        			sql = "insert into mode_workflowtomodesetdetail (mainid,modefieldid,wffieldid) values ("+id+","+modefieldidvalue+","+wffieldidvalue+")";
        			rs.executeSql(sql);
        		}
        	}
        }
        
        //������ã������µ�����
		if(isenable==1){//�Ƿ�����
			sql = "select id,wftomodesetid from workflow_addinoperate where objid = "+triggerNodeId+" and ispreadd = '"+triggerType+"' and isnode = "+isnode+" and workflowid = "+workflowid+" and type = "+type;
			rs.executeSql(sql);
			if(rs.getCounts()>0){
				while(rs.next()){
					int _id = rs.getInt("id");//
					String _wftomodesetid = Util.null2String(rs.getString("wftomodesetid"));//
					_wftomodesetid = _wftomodesetid+","+id;
					sql = "update workflow_addinoperate set wftomodesetid = '"+_wftomodesetid+"' where id = " + _id;
					RecordSet.executeSql(sql);
				}
			}else{
				sql = "insert into workflow_addinoperate (objid,isnode,workflowid,customervalue,type,ispreadd,wftomodesetid) values ("+triggerNodeId+","+isnode+","+workflowid+",'"+customervalue+"',"+type+","+triggerType+","+id+")";
				RecordSet.executeSql(sql);
			}
		}
		
	} else {//�½�
    	//������������
        sql = "insert into mode_workflowtomodeset(modeid,workflowid,modecreater,modecreaterfieldid,triggerNodeId,triggerType,isenable) values ("+modeid+","+workflowid+","+modecreater+","+modecreaterfieldid+","+triggerNodeId+","+triggerType+","+isenable+")";
        rs.executeSql(sql);

        //��ѯid
        sql = "select max(id) id from mode_workflowtomodeset where modeid = " + modeid + " and workflowid = " + workflowid + " and modecreater = " + modecreater + " and modecreaterfieldid = " +modecreaterfieldid;
        rs.executeSql(sql);
        while(rs.next()){
        	id = rs.getInt("id");	
        }
        
		//�½���ʱ�������ϸ�������õ�Ϊͬһ���������ʼ���ֶεĶ�Ӧ��ϵ
       	int modeformid = 0;
       	int wfformid = 0;
       	wfformid = Util.getIntValue(WorkflowComInfo.getFormId(String.valueOf(workflowid)));
   		sql = "select modename,formid from modeinfo where id = " + modeid;
   		rs.executeSql(sql);
   		while(rs.next()){
   			modeformid = rs.getInt("formid");
   		}
   		if(wfformid==modeformid&&wfformid!=0){
         	sql = "insert into mode_workflowtomodesetdetail (mainid,modefieldid,wffieldid) select " + id + ",id,id from workflow_billfield where billid = " + wfformid;
			rs.executeSql(sql);
   		}
    }
	response.sendRedirect("/formmode/interfaces/WorkflowToModeSet.jsp?initworkflowid="+initworkflowid+"&initmodeid="+initmodeid+"&id="+id);
}else if (operation.equals("del")) {
	//ɾ���Ѿ����õ�action
	int oldworkflowid = 0;
	int oldtriggerNodeId = 0;
	int oldtriggerType = 0;
	int oldisenable = 0;
	
	sql = "select * from mode_workflowtomodeset where id = " + id;
	rs.executeSql(sql);
	while(rs.next()){
		oldworkflowid = rs.getInt("workflowid");
		oldtriggerNodeId  = rs.getInt("triggerNodeId");
		oldtriggerType  = rs.getInt("triggerType");
		oldisenable  = rs.getInt("isenable");
	}
	
	if(oldisenable==1){//�Ƿ�����
		sql = "select id,wftomodesetid from workflow_addinoperate where objid = "+oldtriggerNodeId+" and ispreadd = '"+oldtriggerType+"' and isnode = "+isnode+" and workflowid = "+oldworkflowid+" and type = "+type;
		rs.executeSql(sql);
		while(rs.next()){
			int _id = rs.getInt("id");//
			String _wftomodesetid = Util.null2String(rs.getString("wftomodesetid"));//
			_wftomodesetid = ","+_wftomodesetid+",";
			_wftomodesetid = _wftomodesetid.replace(","+id+",","");
			if(_wftomodesetid.replace(",","").equals("")){
				sql = "delete from workflow_addinoperate where id = " + _id;
			}else{
				if(_wftomodesetid.startsWith(",")){
					_wftomodesetid = _wftomodesetid.substring(1);
				}
				if(_wftomodesetid.endsWith(",")){
					_wftomodesetid = _wftomodesetid.substring(0,_wftomodesetid.length()-1);
				}
				sql = "update workflow_addinoperate set wftomodesetid = '"+_wftomodesetid+"' where id = " + _id;
			}
			RecordSet.executeSql(sql);
		}
	}
	
	
    //ɾ����������
	sql = "delete from mode_workflowtomodeset where id = " + id;
	rs.executeSql(sql);

	//ɾ����ϸ������
	sql = "delete from mode_workflowtomodesetdetail where mainid = " + id;
	rs.executeSql(sql);
	
	response.sendRedirect("/formmode/interfaces/WorkflowToModeList.jsp?workflowid="+initworkflowid+"&modeid="+initmodeid);
}

%>