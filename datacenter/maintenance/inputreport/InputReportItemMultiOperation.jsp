<%@ page language="java" contentType="text/html; charset=GBK" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
<jsp:useBean id="LabelComInfo" class="weaver.systeminfo.label.LabelComInfo" scope="page" />

<%@ include file="/systeminfo/init.jsp" %>

<%
String operation = Util.null2String(request.getParameter("operation"));
String inprepid = Util.null2String(request.getParameter("inprepid"));

String inprepTableName="";
String isInputMultiLine="";
int billId=0;

RecordSet.executeProc("T_InputReport_SelectByInprepid",""+inprepid);
if(RecordSet.next()){
	inprepTableName = Util.null2String(RecordSet.getString("inpreptablename")) ;
	isInputMultiLine = Util.null2String(RecordSet.getString("isInputMultiLine")) ;
	billId = Util.getIntValue(RecordSet.getString("billId"),0) ;
}

try{

if(operation.equals("edit")){

    int recordNum = Util.getIntValue(request.getParameter("recordNum"),0);

    int itemId=0;
	int fieldId=0;
	int newItemId=0;
	int newFieldId=0;
    String itemDspName=null;
    String itemFieldName=null;
    String itemFieldType=null;
    int itemFieldScale=0;
    String itemGongSi=null;
    String itemFieldUnit=null;
	String itemExcelSheet=null;
	int itemExcelRow=0;
	int itemExcelColumn=0;
	int itemTypeId=0;
	//int itemDspOrder=0;
	double itemDspOrder=0;
    String itemSelectDsp=null;

	boolean hasItem=false;
	String hisItemFieldNames="";
    RecordSet.executeSql("select itemFieldName from T_InputReportItem  where inprepId="+inprepid);
	while(RecordSet.next()) {
        hisItemFieldNames += ","+Util.null2String(RecordSet.getString("itemFieldName")) ;
    }
	if(!hisItemFieldNames.equals("")){ 
		hisItemFieldNames += "," ;
	}
    String tempItemId=null;
	String tempFieldId=null;
    Map itemIdFieldIdMap=new HashMap();
    RecordSet.executeSql("select t1.itemId,t4.id as fieldId  from T_inputReportItem t1,T_inputReport t3,workflow_billfield t4 where t1.inprepId=t3.inprepId   and t3.billId=t4.billId    and t1.itemFieldName=t4.fieldName   and t3.inprepId="+inprepid);
	while(RecordSet.next()) {
        tempItemId = Util.null2String(RecordSet.getString("itemId")) ;
        tempFieldId = Util.null2String(RecordSet.getString("fieldId")) ;
		if((!tempItemId.equals(""))&&(!tempFieldId.equals(""))){
			itemIdFieldIdMap.put(tempItemId,tempFieldId);
		}
    }

    RecordSetTrans.setAutoCommit(false);

	String changeRowIndexs = Util.null2String(request.getParameter("changeRowIndexs"));

    ArrayList changeRowIndexList=Util.TokenizerString(changeRowIndexs,",");
    //for(int i=0;i<recordNum;i++){
	for(int k=0;k<changeRowIndexList.size();k++){
		int i=Util.getIntValue((String)changeRowIndexList.get(k),-1);

		if(i<0){
			continue;
		}
  try{	

		itemId=Util.getIntValue(request.getParameter("itemId_"+i),0);
		//fieldId=Util.getIntValue(request.getParameter("fieldId_"+i),0);
		tempFieldId=(String)itemIdFieldIdMap.get(String.valueOf(itemId));
		fieldId=Util.getIntValue(tempFieldId,0);
		itemDspName = Util.null2String(request.getParameter("itemDspName_"+i));
		if(itemDspName.equals("")){
			continue;
		}
		//itemFieldName = Util.null2String(request.getParameter("itemFieldName_"+i));
		itemFieldName = Util.null2String(request.getParameter("itemFieldName_"+i)).trim();
		itemFieldType = Util.null2String(request.getParameter("itemFieldType_"+i));
		itemFieldScale=Util.getIntValue(request.getParameter("itemFieldScale_"+i),0);
		itemGongSi = Util.null2String(request.getParameter("itemGongSi_"+i));
		itemFieldUnit = Util.null2String(request.getParameter("itemFieldUnit_"+i));
		itemExcelSheet = Util.null2String(request.getParameter("itemExcelSheet_"+i));
		itemExcelRow=Util.getIntValue(request.getParameter("itemExcelRow_"+i),0);
		itemExcelColumn=Util.getIntValue(request.getParameter("itemExcelColumn_"+i),0);
		itemTypeId=Util.getIntValue(request.getParameter("itemTypeId_"+i),0);
		//itemDspOrder=Util.getIntValue(request.getParameter("itemDspOrder_"+i),0);
		itemDspOrder=Util.getDoubleValue(request.getParameter("itemDspOrder_"+i),0);
		itemSelectDsp = Util.null2String(request.getParameter("itemSelectDsp_"+i));
        hasItem=false;
		if(hisItemFieldNames.indexOf(","+itemFieldName+",")!=-1){
			hasItem=true;
		}

	    int fieldLabel=0; 

        if(itemFieldScale<=0 && itemFieldType.equals("1")){ 
			itemFieldScale = 60 ;
		}
        if(itemFieldScale<=0 && (itemFieldType.equals("3")||itemFieldType.equals("5"))){ 
			itemFieldScale = 2 ;
		}
		if(fieldId<=0){
            String fieldName=itemFieldName;
            //int fieldLabel=0; 
		    String fieldDbType=""; 
            String fieldHtmlType=""; 
            int type=0; 
            //int dspOrder=itemDspOrder;
            int dspOrder=Util.getIntValue(Util.getIntValues(String.valueOf(itemDspOrder)),0);		
            int viewType=0;
            String detailTable="";
            String fromUser="1";
            if("oracle".equals(RecordSet.getDBType())){
			    switch (Util.getIntValue(itemFieldType)) {
					case 1 :
						fieldDbType="varchar2("+itemFieldScale+")";
						fieldHtmlType="1";
						type=1;
						break ;
					case 2 :
						fieldDbType="integer";
						fieldHtmlType="1";
						type=2;
						break ;
					case 3 :
						fieldDbType="number(15,"+itemFieldScale+")";
						fieldHtmlType="1";
						type=3;
						break ;
					case 4 :
						fieldDbType="varchar2(100)";
						fieldHtmlType="5";
						type=0;
						break ;
					case 5 :
						fieldDbType="number(15,"+itemFieldScale+") ";
						fieldHtmlType="1";
						type=3;
						break ;
					case 6 :
						fieldDbType="varchar2(4000)";
						fieldHtmlType="2";
						type=0;
						break ;
					case 7 :
						fieldDbType="integer";
						fieldHtmlType="1";
						type=itemFieldScale;
						break ;
				}
			}else{
				switch (Util.getIntValue(itemFieldType)) {
					case 1 :
						fieldDbType="varchar("+itemFieldScale+")";
						fieldHtmlType="1";
						type=1;
						break ;
					case 2 :
						fieldDbType="int";
						fieldHtmlType="1";
						type=2;
						break ;
					case 3 :
						fieldDbType="decimal(15,"+itemFieldScale+")";
						fieldHtmlType="1";
						type=3;
						break ;
					case 4 :
						fieldDbType="varchar(100)";
						fieldHtmlType="5";
						type=0;
						break ;
					case 5 :
						fieldDbType="decimal(15,"+itemFieldScale+") ";
						fieldHtmlType="1";
						type=3;
						break ;
					case 6 :
						fieldDbType="text";
						fieldHtmlType="2";
						type=0;
						break ;
					case 7 :
						fieldDbType="int";
						fieldHtmlType="1";
						type=itemFieldScale;
						break ;
				}
			}
            String sql="select id from HtmlLabelIndex where indexdesc='"+itemDspName+"'";
            RecordSetTrans.executeSql(sql);
            if(RecordSetTrans.next()){
			    fieldLabel = Util.getIntValue(RecordSetTrans.getString("id"),0);
            }else{
			    sql="select min(id) as id from HtmlLabelIndex";
			    RecordSetTrans.executeSql(sql);
			    if(RecordSetTrans.next()){
			        fieldLabel = Util.getIntValue(RecordSetTrans.getString("id"),0);
			    }
			    if(fieldLabel>0){
			        fieldLabel = -1;
			    }
			    fieldLabel-=1;		    	
			    sql="INSERT INTO HtmlLabelIndex values("+fieldLabel+",'"+itemDspName+"')"; 
			    RecordSetTrans.executeSql(sql);
			    sql="INSERT INTO HtmlLabelInfo VALUES("+fieldLabel+",'"+itemDspName+"',7)";
			    RecordSetTrans.executeSql(sql);		
			    //LabelComInfo.addLabeInfoCache(String.valueOf(fieldLabel));
            }
		
		    if(isInputMultiLine.equals("1")){
			    viewType=1;
			    detailTable=inprepTableName;
		    }else{
			    viewType=0;
			    detailTable="";
		    }



            RecordSetTrans.executeSql("INSERT INTO workflow_billfield ( billId, fieldName, fieldLabel, fieldDbType, fieldHtmlType, type, dspOrder, viewType,detailTable,fromUser) VALUES ("+billId+",'"+fieldName+"',"+fieldLabel+",'"+fieldDbType+"',"+fieldHtmlType+","+type+","+dspOrder+","+viewType+",'"+detailTable+"','"+fromUser+"')");

		}else{
			String hisItemFieldName="";
			String hisItemFieldType="";
			int hisItemFieldScale=0;
			RecordSetTrans.executeSql("select itemFieldName,itemFieldType,itemFieldScale from T_InputReportItem  where itemId="+itemId);
			if(RecordSetTrans.next()){
				hisItemFieldName = Util.null2String(RecordSetTrans.getString("itemFieldName")) ;
				hisItemFieldType = Util.null2String(RecordSetTrans.getString("itemFieldType")) ;
				hisItemFieldScale = Util.getIntValue(RecordSetTrans.getString("itemFieldScale"),0) ;
			}
            //int fieldId=0;
	        String fieldName=itemFieldName;
	        //int fieldLabel=0; 
	        String fieldDbType=""; 
	        String fieldHtmlType=""; 
	        int type=0; 
	        //int dspOrder=itemDspOrder; 
            int dspOrder=Util.getIntValue(Util.getIntValues(String.valueOf(itemDspOrder)),0);	

	        RecordSetTrans.executeSql("select id,fieldDbType,fieldHtmlType,type from workflow_billfield where billId="+billId+" and fieldName='"+hisItemFieldName+"'");
	        if(RecordSetTrans.next()){
		        fieldId=Util.getIntValue(RecordSetTrans.getString("id"),0);
		        fieldDbType=Util.null2String(RecordSetTrans.getString("fieldDbType"));
		        fieldHtmlType=Util.null2String(RecordSetTrans.getString("fieldHtmlType"));
		        type=Util.getIntValue(RecordSetTrans.getString("type"),0);
	        }

			if(!hisItemFieldType.equals( itemFieldType ) ||  hisItemFieldScale!= itemFieldScale ) {
                if("oracle".equals(RecordSet.getDBType())){
				    switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							fieldDbType="varchar2("+itemFieldScale+")";
							fieldHtmlType="1";
							type=1;
							break ;
						case 2 :
							fieldDbType="integer";
							fieldHtmlType="1";
							type=2;
							break ;
						case 3 :
							fieldDbType="number(15,"+itemFieldScale+")";
							fieldHtmlType="1";
							type=3;
							break ;
						case 4 :
							fieldDbType="varchar2(100)";
							fieldHtmlType="5";
							type=0;
							break ;
						case 5 :
							fieldDbType="number(15,"+itemFieldScale+") ";
							fieldHtmlType="1";
							type=3;
							break ;
						case 6 :
							fieldDbType="varchar2(4000)";
							fieldHtmlType="2";
							type=0;
							break ;
						case 7 :
							fieldDbType="integer";
							fieldHtmlType="1";
							type=itemFieldScale;
							break ;
					}
				}else{
					switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							fieldDbType="varchar("+itemFieldScale+")";
							fieldHtmlType="1";
							type=1;
							break ;
						case 2 :
							fieldDbType="int";
							fieldHtmlType="1";
							type=2;
							break ;
						case 3 :
							fieldDbType="decimal(15,"+itemFieldScale+")";
							fieldHtmlType="1";
							type=3;
							break ;
						case 4 :
							fieldDbType="varchar(100)";
							fieldHtmlType="5";
							type=0;
							break ;
						case 5 :
							fieldDbType="decimal(15,"+itemFieldScale+") ";
							fieldHtmlType="1";
							type=3;
							break ;
						case 6 :
							fieldDbType="text";
							fieldHtmlType="2";
							type=0;
							break ;
						case 7 :
							fieldDbType="int";
							fieldHtmlType="1";
							type=itemFieldScale;
							break ;
					}
				}
			}
			String sql="select id from HtmlLabelIndex where indexdesc='"+itemDspName+"'";
            RecordSetTrans.executeSql(sql);
            if(RecordSetTrans.next()){
			    fieldLabel = Util.getIntValue(RecordSetTrans.getString("id"),0);
            }else{
			    sql="select min(id) as id from HtmlLabelIndex";
			    RecordSetTrans.executeSql(sql);
			    if(RecordSetTrans.next()){
			        fieldLabel = Util.getIntValue(RecordSetTrans.getString("id"),0);
			    }
			    if(fieldLabel>0){
			        fieldLabel = -1;
			    }
			    fieldLabel-=1;		    	
			    sql="INSERT INTO HtmlLabelIndex values("+fieldLabel+",'"+itemDspName+"')"; 
			    RecordSetTrans.executeSql(sql);
			    sql="INSERT INTO HtmlLabelInfo VALUES("+fieldLabel+",'"+itemDspName+"',7)";
			    RecordSetTrans.executeSql(sql);		
			    //LabelComInfo.addLabeInfoCache(String.valueOf(fieldLabel));
            }		
            RecordSetTrans.executeSql("update workflow_billfield set fieldName='"+fieldName+"',fieldLabel="+fieldLabel+",fieldDbType='"+fieldDbType+"',fieldHtmlType='"+fieldHtmlType+"',type="+type+",dspOrder="+dspOrder+" where id="+fieldId);
		}

		if(itemId<=0){
			char separator = Util.getSeparator() ;

			String para = inprepid + separator + itemDspName
		                + separator + itemFieldName + separator + itemFieldType + separator + itemFieldScale 
		                + separator + itemTypeId + separator + itemExcelSheet + separator + itemExcelRow 
		                + separator + itemExcelColumn + separator + itemFieldUnit  + separator + itemDspOrder + separator + itemGongSi + separator + "1" + separator + "0" + separator + "0" ;

			RecordSetTrans.executeProc("T_InputReportItem_Insert",para);
            
            if(!hasItem){
                String altertable = " alter table " + inprepTableName + " add " + itemFieldName ;
                if("oracle".equals(RecordSet.getDBType())){
					switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							altertable += " varchar2("+itemFieldScale+") " ;
							break ;
						case 2 :
							altertable += " integer " ;
							break ;
						case 3 :
							altertable += " number(15,"+itemFieldScale+") " ;
							break ;
						case 4 :
							altertable += " varchar(100) " ;
							break ;
						case 5 :
							altertable += " number(15,"+itemFieldScale+") " ;
							break ;
						case 6 :
							altertable += " varchar(4000) " ;
							break ;
						case 7 :
							altertable += " integer " ;
							break ;
					}

				}else{
					switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							altertable += " varchar("+itemFieldScale+") " ;
							break ;
						case 2 :
							altertable += " int " ;
							break ;
						case 3 :
							altertable += " decimal(15,"+itemFieldScale+") " ;
							break ;
						case 4 :
							altertable += " varchar(100) " ;
							break ;
						case 5 :
							altertable += " decimal(15,"+itemFieldScale+") " ;
							break ;
						case 6 :
							altertable += " text " ;
							break ;
						case 7 :
							altertable += " int " ;
							break ;
					}
				}
        
                RecordSetTrans.executeSql(altertable);
			}
		}else{
			String hisItemFieldName="";
			String hisItemFieldType="";
			int hisItemFieldScale=0;
			RecordSetTrans.executeSql("select itemFieldName,itemFieldType,itemFieldScale from T_InputReportItem  where itemId="+itemId);
			if(RecordSetTrans.next()){
				hisItemFieldName = Util.null2String(RecordSetTrans.getString("itemFieldName")) ;
				hisItemFieldType = Util.null2String(RecordSetTrans.getString("itemFieldType")) ;
				hisItemFieldScale = Util.getIntValue(RecordSetTrans.getString("itemFieldScale"),0) ;
			}
            char separator = Util.getSeparator() ;
            String para = ""+itemId + separator + itemDspName
		                + separator + itemFieldName + separator + itemFieldType + separator + itemFieldScale 
                        + separator + itemTypeId + separator + itemExcelSheet + separator + itemExcelRow 
                        + separator + itemExcelColumn + separator + itemFieldUnit   + separator + itemDspOrder + separator + itemGongSi + separator + "1" + separator + "0" + separator + "0" ;

	        RecordSetTrans.executeProc("T_InputReportItem_Update",para);

			if(!hisItemFieldType.equals( itemFieldType ) ||  hisItemFieldScale!= itemFieldScale ) {
                String altertable = "";
				if("oracle".equals(RecordSet.getDBType())){
				    altertable = " alter table " + inprepTableName + " modify  " + itemFieldName;
					switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							altertable += " varchar2("+itemFieldScale+") " ;
							break ;
						case 2 :
							altertable += " integer " ;
							break ;
						case 3 :
							altertable += " number(15,"+itemFieldScale+") " ;
							break ;
						case 4 :
							altertable += " varchar(100) " ;
							break ;
						case 5 :
							altertable += " number(15,"+itemFieldScale+") " ;
							break ;
						case 6 :
							altertable += " varchar2(4000) " ;
							break ;
						case 7 :
							altertable += " integer " ;
							break ;
					}
				}else{
					altertable = " alter table " + inprepTableName + " alter column  " + itemFieldName ;
					switch (Util.getIntValue(itemFieldType)) {
						case 1 :
							altertable += " varchar("+itemFieldScale+") " ;
							break ;
						case 2 :
							altertable += " int " ;
							break ;
						case 3 :
							altertable += " decimal(15,"+itemFieldScale+") " ;
							break ;
						case 4 :
							altertable += " varchar(100) " ;
							break ;
						case 5 :
							altertable += " decimal(15,"+itemFieldScale+") " ;
							break ;
						case 6 :
							altertable += " text " ;
							break ;
						case 7 :
							altertable += " int " ;
							break ;
					}
				}
                RecordSetTrans.executeSql(altertable);
			}
			if( !hisItemFieldName.equals(itemFieldName) )  {
				if("oracle".equals(RecordSet.getDBType())){
				    RecordSetTrans.executeSql("alter table "+inprepTableName+" rename column "+hisItemFieldName+" to "+itemFieldName); 
				}else{
					RecordSetTrans.executeSql("exec sp_rename '"+inprepTableName+"."+hisItemFieldName+"', '"+itemFieldName+"', 'column' "); 
				}
			}
		}
		if(fieldId<=0&&itemId<=0){
			char separator = Util.getSeparator() ;
			String para="";
			RecordSetTrans.executeSql(" select id from workflow_billfield where billId="+billId+" and fieldName='"+itemFieldName+"' ");
			if(RecordSetTrans.next()){
				newFieldId=Util.getIntValue(RecordSetTrans.getString("id"),0);
			}
			RecordSetTrans.executeSql(" select itemId from T_InputReportItem where inprepId="+inprepid+" and itemFieldName='"+itemFieldName+"' ");
			if(RecordSetTrans.next()){
				newItemId=Util.getIntValue(RecordSetTrans.getString("itemId"),0);
			}
			if(newFieldId>0&&newItemId>0){
				ArrayList itemSelectDspList=Util.TokenizerString(itemSelectDsp,",");
				for(int j=0;j<itemSelectDspList.size();j++){
					String itemdsp = Util.null2String((String)itemSelectDspList.get(j)); 
					int itemvalue=-1;
					if(!itemdsp.equals("")){
						if(itemvalue<0){
							RecordSetTrans.executeSql("select max(itemValue) as maxItemValue from T_InputReportItemDetail where itemId="+newItemId);
							if(RecordSetTrans.next()){
								itemvalue=Util.getIntValue(RecordSetTrans.getString("maxItemValue"),-1);
							}
							itemvalue++;
						}
						para = ""+newItemId + separator + itemdsp + separator + itemvalue ;
						RecordSetTrans.executeProc("T_InputReportItemDetail_Insert",para);
						para =""+newFieldId+separator+"1"+separator+""+itemvalue+separator+itemdsp+separator+j+separator+"n";
						RecordSetTrans.executeProc("workflow_SelectItem_Insert",para);
					}
				}
			}

		}
	  RecordSetTrans.commitOnly();
      LabelComInfo.addLabeInfoCache(String.valueOf(fieldLabel));

      }catch(Exception exception){
	      RecordSetTrans.rollbackOnly();
      }
      

	}

  try{
	  
    String delids = Util.null2String(request.getParameter("delids"));
    ArrayList delidList=Util.TokenizerString(delids,",");
   for(int i=0;i<delidList.size();i++){
    itemId=Util.getIntValue((String)delidList.get(i),0);
	if(itemId<=0){
		continue;
	}
	String tempItemFieldName="";
	RecordSetTrans.executeSql("select itemFieldName from T_InputReportItem  where itemId="+itemId);
	if(RecordSetTrans.next()){
		tempItemFieldName=Util.null2String(RecordSetTrans.getString("itemFieldName"));
	}

	RecordSetTrans.executeSql("select id from workflow_billfield where billId="+billId+" and fieldName='"+tempItemFieldName+"'");
	if(RecordSetTrans.next()){
		fieldId=Util.getIntValue(RecordSetTrans.getString("id"),0);
	}

	if(fieldId>0){
		    String nodeLinkIdS="";
			String sql="select t1.id from workflow_nodelink t1, workflow_base t2 where EXISTS(select 1 from workflow_nodebase b where t1.nodeid=b.id and (b.IsFreeNode is null or b.IsFreeNode !='1')) and EXISTS(select 1 from workflow_nodebase b where t1.destnodeid=b.id and (b.IsFreeNode is null or b.IsFreeNode !='1')) and t1.wfrequestid is null and t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + " and t1.condition like '%"+tempItemFieldName+"%'";
			RecordSetTrans.execute(sql);
			while(RecordSetTrans.next()){
				nodeLinkIdS += RecordSetTrans.getString("id") + "," ;
			}
		    if(!nodeLinkIdS.equals("")){
			    nodeLinkIdS = nodeLinkIdS.substring(0,nodeLinkIdS.lastIndexOf(","));
			    response.sendRedirect("/workflow/workflow/BillManagementFieldDelCheck.jsp?actionType=delete&billId=" + billId+"&fieldIds="+fieldId) ;
			    return;		
		    }else{
				
				String fieldName="";
				String fieldHtmlType="";
				//����ֶ���
				sql = "select fieldname , fieldhtmltype from  workflow_billfield where id = " + fieldId ;	
				RecordSetTrans.execute(sql) ;
				if(RecordSetTrans.next()){
					fieldName = RecordSetTrans.getString("fieldname") ;	
					fieldHtmlType = Util.null2String(RecordSetTrans.getString("fieldhtmltype")) ;	
				}
				
				
				//ɾ���ڵ㸽�Ӳ���
				boolean delSuccess=true;
				if(delSuccess){
					sql = "delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and (fieldid =" + fieldId + " or fieldop1id = " + fieldId + " or fieldop2id = " + fieldId + ")" ;
					delSuccess = RecordSetTrans.execute(sql) ;
				}
				
				//ɾ�����ڸ��Ӳ���
				
				if(delSuccess){
					sql = "delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and (fieldid =" + fieldId + " or fieldop1id = " + fieldId + " or fieldop2id = " + fieldId + ")" ;
					delSuccess = RecordSetTrans.execute(sql) ;
				}
						
	
				
				//ɾ�����Զ����ֶβ����Ĳ����ˣ���Ҫ��������������
				/*
				*5��������Դ�ֶα���
				*6��������Դ�ֶξ��� 
				*31��������Դ�ֶ����� 
				*32��������Դ�ֶα��ֲ�+ ��ȫ����
				*7��������Դ�ֶα����� + ��ȫ����
				*38��������Դ�ֶ��ϼ�����+ ��ȫ����	
				*42������
				*43����ɫ
				*8���ĵ��ֶ������ߣ�ѡ����ĵ��ֶζ�Ӧֵ��������ĵ���������
				*33���ĵ��ֶηֲ�+ ��ȫ����
				*9���ĵ��ֶβ���+ ��ȫ����
				*10����Ŀ�ֶξ���ѡ�����Ŀ�ֶζ�Ӧֵ���������Ŀ�ľ���
				*47����Ŀ�ֶξ���ľ���
				*34����Ŀ�ֶηֲ�+ ��ȫ����
				*11����Ŀ�ֶβ���+ ��ȫ����
				*12����Ŀ�ֶγ�Ա+ ��ȫ����
				*13���ʲ��ֶι���Ա
				*35���ʲ��ֶηֲ�+ ��ȫ����
				*14���ʲ��ֶβ���+ ��ȫ����
				*15���ͻ��ֶξ��� ��ѡ��Ŀͻ��ֶζ�Ӧֵ������Ŀͻ��ľ���
				*44���ͻ��ֶξ���ľ���
				*45���ͻ��ֶηֲ�
				*46���ͻ��ֶβ���
				*16���ͻ��ֶ���ϵ�˾��� 	
				*/
				if(delSuccess){
					sql = "delete from  workflow_groupdetail where type in(5,6,31,32,7,38,42,43,8,33,9,10,47,34,11,12,13,35,14,15,44,45,46,16) and groupid in(select id from workflow_nodegroup where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ")) and objid=" + fieldId;
					delSuccess = RecordSetTrans.execute(sql) ;	
				}
				
				//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
				if(delSuccess){
					sql = "delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and fieldid= " + fieldId ;	
					delSuccess = RecordSetTrans.execute(sql) ;	
				}
				
				//ɾ���ֶ�����Ϊѡ��������ѡ������Ϣ
				if(delSuccess && (fieldHtmlType.equals("5"))){
					sql = "delete from  workflow_selectitem where isbill=1 and fieldid =" + fieldId ;
					delSuccess = RecordSetTrans.execute(sql) ;
				}
				
				//ɾ����¼�����ֶ���Ϣ
				if(delSuccess){
					sql = "delete from  workflow_billfield where id = " + fieldId ;		
					delSuccess = RecordSetTrans.execute(sql) ;
				}				
		    }
	}


    char separator = Util.getSeparator() ;
	String para = ""+itemId;
	RecordSetTrans.executeProc("T_InputReportItem_Delete",para);
    RecordSetTrans.executeProc("T_InputReportItemDetail_Delete",para);

    RecordSetTrans.executeSql ( "ALTER TABLE "+ inprepTableName +" DROP COLUMN " + tempItemFieldName );
	RecordSetTrans.commitOnly();
   }
  }catch(Exception exception){
	  RecordSetTrans.rollbackOnly();
  }

    response.sendRedirect("InputReportEdit.jsp?inprepid=" + inprepid);
}

}finally{
            try
            {
                RecordSetTrans.givebackConnectionOnly(null);
            }
            catch(Exception exception2) { }
}
%>
