<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="LabelComInfo" class="weaver.systeminfo.label.LabelComInfo" scope="page" />
<jsp:useBean id="WorkflowSubwfFieldManager" class="weaver.workflow.field.WorkflowSubwfFieldManager" scope="page" />

<%
	if(!HrmUserVarify.checkUserRight("WorkflowManage:All", user)){
		response.sendRedirect("/notice/noright.jsp");
    		return;
	}

    String displayname = Util.null2String(request.getParameter("displayname"));//��ʾ��
    String linkaddress = Util.null2String(request.getParameter("linkaddress"));//���ӵ�ַ
    String descriptivetext = Util.null2String(request.getParameter("descriptivetext"));//����������
    descriptivetext = Util.spacetoHtml(descriptivetext);
	String actionType = Util.null2String(request.getParameter("actionType")) ;
	String fieldIds = Util.null2String(request.getParameter("fieldIds")) ;
	int billId = Util.getIntValue(request.getParameter("billId"),0) ;
	int childfieldid = Util.getIntValue(request.getParameter("childfieldid"),0);
    int textheight=Util.getIntValue(request.getParameter("textheight"),0);//xwj for @td2977 20051107
    int imgwidth = Util.getIntValue(request.getParameter("imgwidth"),0);
    int imgheight = Util.getIntValue(request.getParameter("imgheight"),0);
	String sql = "" ;
	String tableName = "" ;
	String fieldName = "" ;
	int fieldId = 0;
	boolean isSqlServer=false;
	boolean isOracle=false;
	boolean isDB2=false;
	if("sqlserver".equals(RecordSet.getDBType()))
		 isSqlServer=true;
	else if("oracle".equals(RecordSet.getDBType()))
		 	isOracle=true;
		 else if("db2".equals(RecordSet.getDBType()))
		 	isDB2=true;
	
	//��ñ���
	sql = "select tablename from  workflow_bill where id = " + billId ;	
	RecordSet.execute(sql) ;
	if(RecordSet.next()){
		tableName = RecordSet.getString("tablename" ) ;		
	}
	
	if(actionType.equals("add")){		
		int htmltype=Util.getIntValue(request.getParameter("htmltype"),0);
	    int strlength=Util.getIntValue(request.getParameter("strlength"),0);
	    String fieldhtmltype=Util.null2String(request.getParameter("fieldhtmltype"));
	    String fieldViewName=Util.null2String(request.getParameter("fieldname"));
		int htmledit=Util.getIntValue(request.getParameter("htmledit"),0);
	    fieldViewName=fieldViewName.trim();
	    float orderNum=Util.getFloatValue(request.getParameter("orderNum"),0);
	    int fieldLabelId = 0;
	    boolean addSuccess = true ; 
	    String fieldDBType = "" ;
	    String fieldDBType1 = "";
	    fieldViewName = Util.StringReplace(fieldViewName, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
	    fieldViewName = Util.StringReplace(fieldViewName, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
	    //��ȡ�ֶ���ʾ���ı�ǩid
	    if(isSqlServer) RecordSet.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldViewName+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  else RecordSet.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldViewName+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
	    //sql="select id from HtmlLabelInfo where indexdesc='"+fieldViewName+"'";
	    //RecordSet.execute(sql);
	    if(RecordSet.next()){
		    fieldLabelId = Util.getIntValue(RecordSet.getString("indexid"),0);
	    }else{
	    	sql="select min(id) id from HtmlLabelIndex";
		    RecordSet.execute(sql);
		    if(RecordSet.next())
		    	fieldLabelId = Util.getIntValue(RecordSet.getString("id"),0);	
		    if(fieldLabelId>0) 
		    	fieldLabelId = -1;	
		    fieldLabelId-=1;		    	
		    sql="INSERT INTO HtmlLabelIndex values("+fieldLabelId+",'"+fieldViewName+"')"; 
		    RecordSet.execute(sql);
			sql="INSERT INTO HtmlLabelInfo VALUES("+fieldLabelId+",'"+fieldViewName+"',7)";
			RecordSet.execute(sql);		
			LabelComInfo.addLabeInfoCache(String.valueOf(fieldLabelId));
		}
	    
	    //��������ֶ���
	    fieldName = "field_" + Util.getRandom();
	    
	    //�����ֶ�
	    
    	switch (Integer.parseInt(fieldhtmltype)){
        case 1:  //�����ı���
        	switch (htmltype){
        	case 1:  //�ı�
            	if(isSqlServer) fieldDBType = "varchar("+strlength+")";
            	if(isOracle) fieldDBType = "varchar2("+strlength+")";
            	if(isDB2) fieldDBType = "varchar("+strlength+")";
            	break;  
            case 2:  //����
            	if(isSqlServer) fieldDBType = "int";
            	if(isOracle) fieldDBType = "integer";
            	if(isDB2) fieldDBType = "integer";
            	break;  
            case 3:  //������
            	if(isSqlServer) fieldDBType= "decimal(15,3)";
            	if(isOracle) fieldDBType = "number(15,3)";
            	if(isDB2) fieldDBType= "decimal(15,3)";
            	break;  
            case 5:  //���ǧ��λ
            	if(isSqlServer) fieldDBType= "varchar(30)";
            	if(isOracle) fieldDBType = "varchar2(30)";
            	if(isDB2) fieldDBType= "varchar(30)";
            	break;
            default:    
            	break;   
            }
            break;  
        case 2:  //�����ı���
            if(isSqlServer) fieldDBType = "text"; 
            if(isOracle) fieldDBType = "varchar2(3000)";
            if(isDB2) fieldDBType = "varchar(3000)";
            if(textheight<1) textheight=4;
			if (htmledit!=0) htmltype=htmledit;
            break; 
        case 3:  //�����ť
        	sql = " select fielddbtype from workflow_browserurl where id = " + htmltype ;
        	RecordSet.execute(sql);
        	if(RecordSet.next()){
	            fieldDBType = RecordSet.getString("fielddbtype"); 
	            fieldDBType = fieldDBType.trim() ;
	            fieldDBType = fieldDBType.toLowerCase();
		        if(isOracle) {
		        	if(fieldDBType.indexOf("int")!=-1) fieldDBType = "integer";
		        	if(fieldDBType.indexOf("text")!=-1) fieldDBType = "varchar2(3000)";
		        	if(fieldDBType.indexOf("varchar")!=-1) fieldDBType = "varchar2" + fieldDBType.substring(fieldDBType.indexOf("("));
		        	if("".equals(fieldDBType)) fieldDBType = "varchar2(200)";
		        }
		        if(isDB2) {
		        	if(fieldDBType.indexOf("int")!=-1) fieldDBType = "integer";
		        	if(fieldDBType.indexOf("text")!=-1) fieldDBType = "varchar(3000)";
		        	if("".equals(fieldDBType)) fieldDBType = "varchar(200)";
		        }
		        if(htmltype==165 || htmltype==166 || htmltype==167 || htmltype==168){
			    	textheight = Util.getIntValue(request.getParameter("decentralizationbroswerType"), 0);
			    }

		        if(isSqlServer&&"".equals(fieldDBType)) fieldDBType = "varchar(200)";
	        }
	        //TD15999
	        String cusb = Util.null2String(request.getParameter("cusb"));
			if(htmltype==161 || htmltype==162) {
				fieldDBType1=cusb;
	            if(isSqlServer) fieldDBType = "text"; 
	            if(isOracle) fieldDBType = "varchar2(3000)";
	            if(isDB2) fieldDBType = "varchar(3000)";
			}
            break; 
        case 4:  //Check��
            fieldDBType = "char(1)";
            break; 
        case 5:  //ѡ���
            if(isSqlServer) fieldDBType = "int";
            if(isOracle) fieldDBType = "integer";
            if(isDB2) fieldDBType = "integer";
            break; 
        case 6:  //�����ϴ�
            if(isSqlServer) fieldDBType = "text"; 
            if(isOracle) fieldDBType = "varchar2(3000)";
            if(isDB2) fieldDBType = "varchar(3000)";
            break; 
        case 7:  //�����ϴ�
            if(isSqlServer) fieldDBType = "text"; 
            if(isOracle) fieldDBType = "varchar2(3000)";
            if(isDB2) fieldDBType = "varchar(3000)";

            break;
        default:    
            break;   
        } 
        if("".equals(fieldDBType)) 
        	addSuccess=false;
		else {
			sql = "alter table " + tableName + " ADD " + fieldName + " " + fieldDBType;
			addSuccess=RecordSet.execute(sql);
		}
		//td15999
	    if(!"".equals(fieldDBType1)) fieldDBType = fieldDBType1;
	    
	    if(addSuccess){
			sql="INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,fromUser,textheight,childfieldid,imgwidth,imgheight) VALUES ("+billId+",'"+fieldName+"',"+fieldLabelId+",'"+fieldDBType+"',"+fieldhtmltype+","+htmltype+","+orderNum+",0,'0',"+textheight+","+childfieldid+","+imgwidth+","+imgheight+")";
			addSuccess=RecordSet.execute(sql);				
		}
		
		String wfid = "-1";//xwj for td3399 20060303
		ArrayList arr = new ArrayList();
		if(addSuccess){
			sql="select id from workflow_billfield where billid = " + billId + " and fieldname='" + fieldName + "'" ;
			RecordSet.execute(sql);	
			if(RecordSet.next()){//xwj for td3399 20060303
				fieldId = Util.getIntValue(RecordSet.getString("id"),0);
					RecordSet1.executeSql("select id from workflow_base where formid = " + billId + " and isbill = 1");
					while(RecordSet1.next()){
					  wfid = wfid + "," + Util.null2String(RecordSet1.getString("id"));
					}
					if(!wfid.equals("")){
					RecordSet1.executeSql("select nodeid from workflow_flownode where workflowid in (" + wfid + ")");
					while(RecordSet1.next()){
					   arr.add(RecordSet1.getString("nodeid"));
					}
					for(int h=0; h < arr.size(); h++){
					RecordSet1.executeSql("insert into workflow_nodeform(nodeid,fieldid,isview,isedit,ismandatory) values("+(String)arr.get(h)+","+fieldId+",'1','1','0')");
				  }
					}
				
				}
		}
		//����workflow_selectitem��
		if(fieldhtmltype.equals("5")){
			int i=0;
			int curvalue=0;
			int rowsum = Util.getIntValue(Util.null2String(request.getParameter("selectsnum")));
			char flag=2;
			String curname="";
			for(i=0;i<rowsum;i++){	
				curname=Util.fromScreen(request.getParameter("field_"+i+"_name"),user.getLanguage());				
					String	cancel=Util.fromScreen(request.getParameter("cancel_"+i),user.getLanguage());
				if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
					cancel = "1";
				}else{
					cancel = "0";
				}
				if(!curname.equals("")){
						String para=""+fieldId+flag+"1"+flag+""+curvalue+flag+curname+flag+0+flag+"n"+flag+cancel;//xwj for td3399 20060303
					RecordSet.executeProc("workflow_selectitem_insert_new",para);
				String childItem = Util.null2String(request.getParameter("childItem"+i));
						rs.execute("update workflow_selectitem set childitemid='"+childItem+"',cancel='"+cancel+"' where fieldid="+fieldId+" and isbill=1 and selectvalue="+curvalue); 
					curvalue++;
				}
			}
	    }
		//����workflow_specialfield��
		if(fieldhtmltype.equals("7")){
	      if(htmltype==1){
	         sql = "insert into workflow_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+fieldId+",'"+displayname+"','"+linkaddress+"',0,1)";    
	      }else{
	         sql = "insert into workflow_specialfield(fieldid,descriptivetext,isform,isbill) values("+fieldId+",'"+descriptivetext+"',0,1)";    
	      }
		  RecordSet.executeSql(sql);
	    }
		//�öδ��벻��ִ�У������� TD9786
	    //if(addSuccess){%>	    
	    	<script language="javascript">
	    		//alert("�ֶ���ӳɹ�!");
	    	</script>
	    <%//}else{%>
		    <script language="javascript">
		    	//alert("�ֶ����ʧ��!");
		    </script>
	    <%//}

	    response.sendRedirect("/workflow/workflow/BillManagementDetail.jsp?billId=" + billId) ;
		return;	  
	}else if(actionType.equals("edit")){//TD 9786 chujun
		fieldId = Util.getIntValue(request.getParameter("fieldid"), 0);
		int htmltype=Util.getIntValue(request.getParameter("htmltype"),0);
	    int strlength=Util.getIntValue(request.getParameter("strlength"),0);
	    String fieldhtmltype=Util.null2String(request.getParameter("fieldhtmltype"));
	    String fieldViewName=Util.null2String(request.getParameter("fieldname"));
		int htmledit=Util.getIntValue(request.getParameter("htmledit"),0);
	    fieldViewName=fieldViewName.trim();
	    float orderNum = Util.getFloatValue(request.getParameter("orderNum"),0);
	    int fieldLabelId = 0;
	    boolean addSuccess = true ; 
	    String fieldDBType = "" ;
	    fieldViewName = Util.StringReplace(fieldViewName, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
	    fieldViewName = Util.StringReplace(fieldViewName, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
	    //��ȡ�ֶ���ʾ���ı�ǩid
	    sql="select id from HtmlLabelIndex where indexdesc='"+fieldViewName+"'";
	    RecordSet.execute(sql);
	    if(RecordSet.next()){
		    fieldLabelId = Util.getIntValue(RecordSet.getString("id"),0);
	    }else{
	    	sql="select min(id) id from HtmlLabelIndex";
		    RecordSet.execute(sql);
		    if(RecordSet.next())
		    	fieldLabelId = Util.getIntValue(RecordSet.getString("id"),0);	
		    if(fieldLabelId>0) 
		    	fieldLabelId = -1;	
		    fieldLabelId-=1;		    	
		    sql="INSERT INTO HtmlLabelIndex values("+fieldLabelId+",'"+fieldViewName+"')"; 
		    RecordSet.execute(sql);
			sql="INSERT INTO HtmlLabelInfo VALUES("+fieldLabelId+",'"+fieldViewName+"',7)";
			RecordSet.execute(sql);		
			LabelComInfo.addLabeInfoCache(String.valueOf(fieldLabelId));
		}
        if(fieldhtmltype.equals("2")){
            if(textheight<1) textheight=4;
        }
        if("3".equals(fieldhtmltype) && (htmltype==165 || htmltype==166 || htmltype==167 || htmltype==168)){
        	textheight = Util.getIntValue(request.getParameter("decentralizationbroswerType"), 0);
        }
	    //�޸���ʾ���ƺ�˳��
	    if(addSuccess){
			sql="update workflow_billfield set fieldlabel="+fieldLabelId+", dsporder="+orderNum+",childfieldid="+childfieldid+",textheight="+textheight+",imgwidth="+imgwidth+",imgheight="+imgheight+" where id="+fieldId;
			addSuccess = RecordSet.execute(sql);				
		}
		
		//����workflow_selectitem��
		if(fieldhtmltype.equals("5")){
			sql = "delete from workflow_SelectItem where fieldid="+fieldId;
			RecordSet.execute(sql);
			int i=0;
			int curvalue=0;
			int rowsum = Util.getIntValue(Util.null2String(request.getParameter("selectsnum")));
			char flag=2;
			String curname="";
			for(i=0;i<rowsum;i++){	
				curname=Util.fromScreen(request.getParameter("field_"+i+"_name"),user.getLanguage());				
				if(!curname.equals("")){
						String	cancel=Util.fromScreen(request.getParameter("cancel_"+i),user.getLanguage());
					if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
						cancel = "1";
					}else{
						cancel = "0";
					}
					String para=""+fieldId+flag+"1"+flag+""+curvalue+flag+curname+flag+0+flag+"n"+flag+cancel;//xwj for td3399 20060303
					RecordSet.executeProc("workflow_selectitem_insert_new",para);
					String childItem = Util.null2String(request.getParameter("childItem"+i));
					rs.execute("update workflow_selectitem set childitemid='"+childItem+"',cancel='"+cancel+"' where fieldid="+fieldId+" and isbill=1 and selectvalue="+curvalue);
					curvalue++;
				}
			}
	    }
		//����workflow_specialfield��
		if(fieldhtmltype.equals("7")){
			if(htmltype==1){
				//sql = "insert into workflow_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+fieldId+",'"+displayname+"','"+linkaddress+"',0,1)";
				sql = "update workflow_specialfield set displayname='"+displayname+"', linkaddress='"+linkaddress+"', isform=0, isbill=1, descriptivetext='' where fieldid="+fieldId;
			}else{
				//sql = "insert into workflow_specialfield(fieldid,descriptivetext,isform,isbill) values("+fieldId+",'"+descriptivetext+"',0,1)";
				sql = "update workflow_specialfield set displayname='', linkaddress='', isform=0, isbill=1, descriptivetext='"+descriptivetext+"' where fieldid="+fieldId;
			}
			RecordSet.executeSql(sql);
	    }
	    response.sendRedirect("/workflow/workflow/BillManagementDetail.jsp?billId=" + billId) ;
		return;	  
	}
	else if(actionType.equals("delete")){
		
		ArrayList idS = Util.TokenizerString(fieldIds,",");			
		boolean delSuccess = true ; 	
		int fieldHtmlType = 0 ;
		String nodeLinkIdS = "";
		//�����������
		for(int i=0;i<idS.size();i++){
			fieldId = Integer.parseInt((String)idS.get(i));			
			//����ֶ���
			sql = "select fieldname from  workflow_billfield where id = " + fieldId ;	
			RecordSet.execute(sql) ;
			if(RecordSet.next()){
				fieldName = RecordSet.getString("fieldname") ;	
			}
			sql="select t1.id from workflow_nodelink t1, workflow_base t2 where t1.wfrequestid is null and t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + " and t1.condition like '%"+fieldName+"%'";
			RecordSet.execute(sql);
			while(RecordSet.next()){
				nodeLinkIdS += RecordSet.getString("id") + "," ;
			}
		}
		if(!nodeLinkIdS.equals("")){
			nodeLinkIdS = nodeLinkIdS.substring(0,nodeLinkIdS.lastIndexOf(","));
			response.sendRedirect("/workflow/workflow/BillManagementFieldDelCheck.jsp?actionType="+actionType+"&billId=" + billId+"&fieldIds="+fieldIds) ;
			return;		
		}else{

			//�����������ͨ����ʼɾ��
			for(int i=0;i<idS.size();i++){
				fieldId = Integer.parseInt((String)idS.get(i));

		        if(WorkflowSubwfFieldManager.hasSubWfSettingForBill(fieldId,1)){
					response.sendRedirect("/workflow/workflow/BillManagementDetail.jsp?billId="+ billId+"&errorcode=2") ;
		            return;
		        }				

				//����ֶ���
				sql = "select fieldname , fieldhtmltype from  workflow_billfield where id = " + fieldId ;	
				RecordSet.execute(sql) ;
				if(RecordSet.next()){
					fieldName = RecordSet.getString("fieldname") ;	
					fieldHtmlType = Util.getIntValue(RecordSet.getString("fieldhtmltype"),0) ;	
				}
				
				
				//ɾ���ڵ㸽�Ӳ���
				
				if(delSuccess){
					sql = "delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and (fieldid =" + fieldId + " or fieldop1id = " + fieldId + " or fieldop2id = " + fieldId + ")" ;
					delSuccess = RecordSet.execute(sql) ;
				}
				
				//ɾ�����ڸ��Ӳ���
				
				if(delSuccess){
					sql = "delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and (fieldid =" + fieldId + " or fieldop1id = " + fieldId + " or fieldop2id = " + fieldId + ")" ;
					delSuccess = RecordSet.execute(sql) ;
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
					delSuccess = RecordSet.execute(sql) ;	
				}
				
				//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
				if(delSuccess){
					sql = "delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + billId + ") and fieldid= " + fieldId ;	
					delSuccess = RecordSet.execute(sql) ;	
				}
				
				//ɾ���ֶ�����Ϊѡ��������ѡ������Ϣ
				if(delSuccess && (fieldHtmlType==5)){
					sql = "delete from  workflow_selectitem where isbill=1 and fieldid =" + fieldId ;
					delSuccess = RecordSet.execute(sql) ;
					//���������ֶΣ�ɾ����Ϊ���ֶ���Ϣ
					sql = "update workflow_billfield set childfieldid=0 where childfieldid="+fieldId;
					rs.execute(sql);
				}

				//ɾ�������ֶε���Ϣ
				if(delSuccess && (fieldHtmlType==7)){
					sql = "delete from workflow_specialfield where isbill=1 and fieldid =" + fieldId ;
					delSuccess = RecordSet.execute(sql) ;
				}
				
				//ɾ����¼�����ֶ���Ϣ
				if(delSuccess){
					sql = "delete from  workflow_billfield where id = " + fieldId ;		
					delSuccess = RecordSet.execute(sql) ;
				}
				
				//����ɾ�����ֶ�
				if(delSuccess&&!isDB2){
					sql = "ALTER TABLE " + tableName + " DROP COLUMN " + fieldName ;
					delSuccess = RecordSet.execute(sql);
				}
			}
		}
		if(delSuccess){%>	    
	    	<script language="javascript">
	    		alert("�ֶ�ɾ���ɹ�!");
	    	</script>
	    <%}else{%>
		    <script language="javascript">
		    	alert("�ֶ�ɾ��ʧ��!");
		    </script>
	    <%}	
		response.sendRedirect("/workflow/workflow/BillManagementDetail.jsp?billId=" + billId) ;
		return;		
	}


%>


	
