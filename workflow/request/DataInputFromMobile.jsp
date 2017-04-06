<%@ page language="java" contentType="text/html; charset=GBK" %>
<%-- ��ҳ��ר����Mobile����ֶ����� --%>
<%@ page import="weaver.workflow.datainput.DynamicDataInput" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Hashtable" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.workflow.workflow.WorkflowComInfo" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsObj" class="weaver.conn.RecordSet" scope="page" />
<%
String workflowId = request.getParameter("id");
String strTrgFieldNames = request.getParameter("trg");
WorkflowComInfo wfComInfo = new WorkflowComInfo();
String fformid = wfComInfo.getFormId(workflowId);
String isbill = wfComInfo.getIsBill(workflowId);
String nodeid = request.getParameter("node");

//��ȡ��ǰ�ڵ����пɼ��ֶε�������Ϣ��
Map<String, String[]> mapFieldInfos = DynamicDataInput.getFieldInfos(workflowId, nodeid, isbill);
//������ֵ���ֶ�(�ֶ�id�� �ֶ�ֵ)�б�
List lstValues = new ArrayList();
//��������ǰ����ʾ��(�����ť)�ֶ�(�ֶ�id�� �ֶ�ֵ)�б�
List lstDisplays = new ArrayList();

ArrayList arrTrgFieldNames = Util.TokenizerString(strTrgFieldNames, ",");
for(int temp=0; temp<arrTrgFieldNames.size(); temp++){
	String trgFieldName = Util.null2String((String)arrTrgFieldNames.get(temp));
	if(trgFieldName != null && !trgFieldName.trim().equals("") ){
		DynamicDataInput DDI = new DynamicDataInput(workflowId,trgFieldName,isbill);

		//��ѯ����ǰ�ֶ���Ϊȡֵ����������������Ϣ
		String sql="select id from Workflow_DataInput_entry where WorkFlowID="+workflowId+" and TriggerFieldName='"+trgFieldName+"'";
		rs.executeSql(sql);
		String entryid = "";
		String datainputid = "";
		Hashtable outdatahash = new Hashtable();
		while(rs.next()){
			entryid = rs.getString("id");
			rsObj.executeSql("select id,IsCycle,WhereClause from Workflow_DataInput_main where entryID="+entryid+" order by orderid");

			ArrayList outdatasList=new ArrayList();
			ArrayList outfieldnamelist=new ArrayList();
			while(rsObj.next()){
				datainputid = rsObj.getString("id");
				
				//��ȡ������Ϣ�е� ����ȡֵ�ֶ����� �� ȡֵ�ֶ�ֵ��
				ArrayList infieldnamelist = DDI.GetInFieldName(datainputid);
				for(int i=0;i<infieldnamelist.size();i++){
					DDI.SetInFields((String)infieldnamelist.get(i),Util.null2String(request.getParameter(datainputid+"|"+(String)infieldnamelist.get(i))));
				}
				//��ȡ������Ϣ�е� ���������ֶ����� �� �����ֶ�ֵ��
				ArrayList conditionfieldnameList = DDI.GetConditionFieldName(datainputid);
				for(int j=0;j<conditionfieldnameList.size();j++){
					DDI.SetConditonFields((String)conditionfieldnameList.get(j),Util.null2String(request.getParameter(datainputid+"|"+(String)conditionfieldnameList.get(j))));
				}
		        DDI.GetOutData(datainputid);
		        outfieldnamelist = DDI.GetOutFieldNameList();
		        outdatasList = DDI.GetOutDataList();
		        
		      	//��ֵ�ֶ�Ϊ�����ֶεĸ���
				if(DDI.GetIsCycle().equals("1")){
					//����ֵ�ֶ�Ϊ�����ֶ�ʱ�� outdatasList������һ��Ԫ�ء�
				 	for(int i=0;i<outdatasList.size();i++){
				 		outdatahash = (Hashtable)outdatasList.get(i);
				 		
				 		List tempObj = new ArrayList();
				 		//�Ը�ֵ�ֶν���ѭ����
				 		for(int j=0; j<outfieldnamelist.size(); j++){
				 			String fieldName = (String)outfieldnamelist.get(j);
				 		    String fieldValue = (String)outdatahash.get(fieldName);
				 		   	fieldValue = Util.toExcelData(fieldValue);
				 		   	
				 		   	//�жϵ�ǰ�ֶ��Ƿ�֧�ֱ༭
				 		   	String[] fieldType = DynamicDataInput.getFieldType(fieldName, mapFieldInfos);
				 		   	if(fieldType != null){
					 		   	Map map = new HashMap();
					 		   	map.put("fieldId", fieldName);
					 		   	map.put("fieldValue", fieldValue);
					 		   	tempObj.add(map);
				 		   	}
				 		}
				 		lstValues.add(tempObj);
	       			}
					
					//��ȡ�˴�ȡֵ����Ҫ����ǰ��ֵ���б�
					List tempObj = DynamicDataInput.getBrowserButtonValue(outfieldnamelist, outdatasList, mapFieldInfos);
					if(tempObj != null){
						lstDisplays.add(tempObj);
					}
		       	} 
			}
		}
	}
}

String[] inputChecks = DynamicDataInput.getIsMandatoryField(workflowId, nodeid);
Map mapResult = new HashMap();
mapResult.put("values",lstValues);
mapResult.put("mandField",inputChecks);
mapResult.put("displays", lstDisplays);

JSONObject jsonObj = JSONObject.fromObject(mapResult);
String strResult = jsonObj.toString();
out.println(strResult);
%>