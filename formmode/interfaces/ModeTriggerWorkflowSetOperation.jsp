<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="InterfaceTransmethod" class="weaver.formmode.interfaces.InterfaceTransmethod" scope="page" />
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
int wfcreater = Util.getIntValue(request.getParameter("wfcreater"),0);
int wfcreaterfieldid = Util.getIntValue(request.getParameter("wfcreaterfieldid"),0);
int detailno = Util.getIntValue(request.getParameter("detailno"),0);
int tempid = id;
String successwriteback = InterfaceTransmethod.toHtmlForMode(request.getParameter("successwriteback"));
String failwriteback = InterfaceTransmethod.toHtmlForMode(request.getParameter("failwriteback"));

//��ɾ�����������±���
if (operation.equals("save")) {
    //ɾ����������
	sql = "delete from mode_triggerworkflowset where modeid = " + modeid;
	rs.executeSql(sql);

	//ɾ����ϸ������
	sql = "delete from mode_triggerworkflowsetdetail where mainid = " + id;
	rs.executeSql(sql);
    
    //������ϸ����
    if(modeid>0&&workflowid>0){
    	if(wfcreater!=3){
    		wfcreaterfieldid = 0;
    	}
    	//������������
        sql = "insert into mode_triggerworkflowset(modeid,workflowid,wfcreater,wfcreaterfieldid,successwriteback,failwriteback) values ("+modeid+","+workflowid+","+wfcreater+","+wfcreaterfieldid+",'"+successwriteback+"','"+failwriteback+"')";
        rs.executeSql(sql);

        //��ѯid
        sql = "select max(id) id from mode_triggerworkflowset where modeid = " + modeid + " and workflowid = " + workflowid + " and wfcreater = " + wfcreater + " and wfcreaterfieldid = " +wfcreaterfieldid;
        rs.executeSql(sql);
        while(rs.next()){
        	id = rs.getInt("id");	
        }
        
		//�½���ʱ�������ϸ�������õ�Ϊͬһ���������ʼ���ֶεĶ�Ӧ��ϵ
        if(tempid<=0){
        	int modeformid = 0;
        	int wfformid = 0;
        	wfformid = Util.getIntValue(WorkflowComInfo.getFormId(String.valueOf(workflowid)));
       		sql = "select modename,formid from modeinfo where id = " + modeid;
       		rs.executeSql(sql);
       		while(rs.next()){
       			modeformid = rs.getInt("formid");
       		}
       		System.out.println(wfformid+"	"+modeformid);
       		if(wfformid==modeformid&&wfformid!=0){
            	sql = "insert into mode_triggerworkflowsetdetail (mainid,modefieldid,wffieldid) select " + id + ",id,id from workflow_billfield where billid = " + wfformid;
				rs.executeSql(sql);
       		}
        }else{
	        for(int i=0;i<=detailno;i++){
	        	String wffieldidvalues[] = request.getParameterValues("wffieldid"+i);
	        	String modefieldidvalues[] = request.getParameterValues("modefieldid"+i);
	        	
	        	if(wffieldidvalues!=null && modefieldidvalues!=null){
	        		for(int j=0;j<wffieldidvalues.length;j++){
	        			int wffieldidvalue = Util.getIntValue((String)wffieldidvalues[j],0);
	        			int modefieldidvalue = Util.getIntValue((String)modefieldidvalues[j],0);
	        			
	        			sql = "insert into mode_triggerworkflowsetdetail (mainid,modefieldid,wffieldid) values ("+id+","+modefieldidvalue+","+wffieldidvalue+")";
	        			rs.executeSql(sql);
	        		}
	        	}
	        }
        }
    }
    
	response.sendRedirect("/formmode/interfaces/ModeTriggerWorkflowSet.jsp?modeid="+modeid);
}else{
	if (operation.equals("del")) {
	    //ɾ����������
		sql = "delete from mode_triggerworkflowset where modeid = " + modeid;
		rs.executeSql(sql);

		//ɾ����ϸ������
		sql = "delete from mode_triggerworkflowsetdetail where mainid = " + id;
		rs.executeSql(sql);
	}
	response.sendRedirect("/formmode/interfaces/ModeTriggerWorkflowSet.jsp?modeid="+modeid);
}

%>