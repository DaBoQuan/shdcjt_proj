<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*,java.util.regex.*" %>
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="FormManager" class="weaver.workflow.form.FormManager" scope="session"/>
<jsp:useBean id="FormComInfo" class="weaver.workflow.form.FormComInfo" scope="page" />
<jsp:useBean id="FormFieldMainManager" class="weaver.workflow.form.FormFieldMainManager" scope="page" />
<jsp:useBean id="FormFieldlabelMainManager" class="weaver.workflow.form.FormFieldlabelMainManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="fieldCommon" class="weaver.workflow.field.FieldCommon" scope="page" /><!--added by xwj for td3325 20051205-->
<jsp:useBean id="LabelComInfo" class="weaver.systeminfo.label.LabelComInfo" scope="page" />	
<jsp:useBean id="BillComInfo" class="weaver.workflow.workflow.BillComInfo" scope="page" />	
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<jsp:useBean id="WorkflowSubwfFieldManager" class="weaver.workflow.field.WorkflowSubwfFieldManager" scope="page" />

<%FormFieldlabelMainManager.resetParameter();%>

<%
  boolean isoracle = (RecordSet.getDBType()).equals("oracle") ;
  boolean isdb2 = (RecordSet.getDBType()).equals("db2") ;
  boolean issqlserver = (RecordSet.getDBType()).equals("sqlserver") ;

  String ajax=Util.null2String(request.getParameter("ajax"));
  String src = Util.null2String(request.getParameter("src"));
  //System.out.println("src:"+src);
  int groupId=Util.getIntValue(Util.null2String(request.getParameter("groupId")),0);
////�õ������Ϣ
  if(src.equalsIgnoreCase("addform")){
    //int isformadd = Util.getIntValue(request.getParameter("isformadd"));
    //System.out.println("isformadd:"+isformadd);
    //FormManager.reset();
  	//FormManager.setAction("addform");
  	//FormManager.setFormname(Util.null2String(request.getParameter("formname")));
  	//FormManager.setFormdes(Util.null2String(request.getParameter("formdes")));
  	//FormManager.setSubCompanyId2(Util.getIntValue(request.getParameter("subcompanyid"),-1) );
  	//FormManager.setFormInfo();
  	//FormComInfo.removeFormCache();
    //RecordSet.executeSql("select max(id) as id from workflow_formbase");
    //int formid=0;
    //if(RecordSet.next()){
  	//	formid = Util.getIntValue(Util.null2String(RecordSet.getString("id")),0);
  	//}
  	
  	//�½��������뵥����ͬ��ģʽ TD8730 MYQ�޸�
  	int formid = -1;
  	//System.out.println("formid=="+formid);
  	String from = Util.null2String(request.getParameter("from"));
  	String formname = Util.null2String(request.getParameter("formname"));
  	formname = formname.replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
  	formname = Util.toHtmlForSplitPage(formname);
  	//ͬ����֤ ��ʼ TD10194
  	boolean issamename = false;
  	RecordSet.executeSql("select namelabel from workflow_bill");
  	int isFromMode = Util.getIntValue(request.getParameter("isFromMode"),0);
    while(RecordSet.next()){//�±����͵�����
  	    int namelabel = Util.getIntValue(Util.null2String(RecordSet.getString("namelabel")),0);
  	    if(namelabel!=0)
  	    {
  	        if(formname.equals(SystemEnv.getHtmlLabelName(namelabel,user.getLanguage())))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	RecordSet.executeSql("select formname from workflow_formbase");
    while(RecordSet.next()){//�ɱ���
  	    String tempformname = Util.null2String(RecordSet.getString("formname"));
  	    if(!tempformname.equals(""))
  	    {
  	        if(formname.equals(tempformname))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	if(issamename){
  	    if(from.equals("addDefineForm")){
  	        response.sendRedirect("/workflow/form/addDefineForm.jsp?message=issamename&isFromMode="+isFromMode+"&ajax="+ajax);//gzt update TD27194
  	        return;
  	    }else{
  	        response.sendRedirect("/workflow/form/editform.jsp?message=issamename&ajax="+ajax);//gzt update TD27194
  	        return;
  	    }
  	}
  	//ͬ����֤ ���� TD10194
  	String formdes = Util.null2String(request.getParameter("formdes"));
  	formdes = formdes.replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
  	formdes = Util.toHtmlForSplitPage(formdes);
  	int subcompanyid = Util.getIntValue(request.getParameter("subcompanyid"),-1);
  	formid = FormManager.getNewFormId();
  	if(formid<-1){
  		boolean success = false;
  		String formtable_main = "formtable_main_"+formid*(-1);//������
  		formname = formname.replaceAll("<","��").replaceAll(">","��");
  		//String formtable_detail = "formtable_detail_"+formid;//��ϸ����
  		RecordSetTrans.setAutoCommit(false);
  		try{
		  	int namelabelid = -1;
		  	if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+formname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+formname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	if(RecordSetTrans.next()) namelabelid = RecordSetTrans.getInt("indexid");//����������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		  	else{
		  		namelabelid = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			  	if(namelabelid!=-1){//���±�ǩ��
			  		RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+namelabelid);
			  		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+namelabelid);
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+namelabelid+",'"+formname+"')");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',7)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',8)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',9)");
			  	}
			  }
		  	if(subcompanyid==-1){//��Ȩ�ֲ���ȡ�á����ҳ��û�У������ȴӷ�Ȩ���õ�Ĭ�ϻ���ȡ�ã����Ĭ�ϻ���û��������ȡ���зֲ���id��С���Ǹ��ֲ���
		  		RecordSetTrans.executeSql("select dftsubcomid from SystemSet");
		  		if(RecordSetTrans.next()) subcompanyid = Util.getIntValue(RecordSetTrans.getString("dftsubcomid"),-1);
		  		if(subcompanyid==-1){
		  			RecordSetTrans.executeSql("select min(id) as id from HrmSubCompany");
		  			if(RecordSetTrans.next()) subcompanyid = RecordSetTrans.getInt("id");
		  		}
		  	}
  			RecordSetTrans.executeSql("insert into workflow_bill(id,namelabel,tablename,detailkeyfield,formdes,subcompanyid) values("+formid+","+namelabelid+",'"+formtable_main+"','mainid','"+formdes+"',"+subcompanyid+")");
  			String dbType = RecordSet.getDBType();
  			if("oracle".equals(dbType)){//������������ϸ��Ĵ������½��ֶε�ʱ���������ϸ�ֶ��򴴽���ϸ��
	  			RecordSetTrans.executeSql("create table " + formtable_main + "(id integer primary key not null, requestId integer)");
	  			//RecordSetTrans.executeSql("create sequence "+formtable_main+"_Id start with 1 increment by 1 nomaxvalue nocycle");
	  			//RecordSetTrans.executeSql("CREATE OR REPLACE TRIGGER "+formtable_main+"_Id_Trigger before insert on "+formtable_main+" for each row begin select "+formtable_main+"_Id.nextval into :new.id from dual; end;");
	  		}else{
	  			RecordSetTrans.executeSql("create table " + formtable_main + "(id int IDENTITY(1,1) primary key CLUSTERED, requestId integer)");
	  		}
  			RecordSetTrans.commit();
  			if("oracle".equals(dbType)){//����id������
	  			RecordSet.executeSql("create sequence "+formtable_main+"_Id start with 1 increment by 1 nomaxvalue nocycle");
	  			RecordSet.setChecksql(false);
	  			RecordSet.executeSql("CREATE OR REPLACE TRIGGER "+formtable_main+"_Id_Trigger before insert on "+formtable_main+" for each row begin select "+formtable_main+"_Id.nextval into :new.id from dual; end;");
	  		}
			  LabelComInfo.addLabeInfoCache(""+namelabelid);//����������ӱ����Ƶı�ǩ
			  BillComInfo.addBillCache(""+formid);
			  if(from.equals("addDefineForm"))
  				response.sendRedirect("/workflow/form/addDefineForm.jsp?formid="+formid+"&isFromMode="+isFromMode+"&ajax="+ajax);
  			else 
  				response.sendRedirect("/workflow/form/editform.jsp?formid="+formid+"&ajax="+ajax);
			  success = true;
  		}catch(Exception exception){
			success = false;
			  RecordSetTrans.rollback();
		  }
  		//TD10835 �������б��½�������Ҫ��ԭ������Ϣ���ƹ��� chujun
  		if(success == true){//�������ʧ���ˣ��Ͳ�Ҫ����Ĳ�����
	  		int oldformid = Util.getIntValue(request.getParameter("oldformid"), 0);
	  		if(oldformid != 0){
	  			int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
	  			FormManager.setFormInfoByTemplate(formid, oldformid);
	  		}
  		}
  		if(issqlserver){//��Ϊ��sql����detailtable��Ĭ��ֵNULL����ʾ�����ʱ����detailtable���򣬵�detailtable�п�ֵ��nullʱ���������
  			RecordSet.executeSql("update workflow_billfield set detailtable = '' where detailtable is null");
  		}
  	}
  	//�½��������뵥����ͬ��ģʽ TD8730 MYQ�޸�
    //response.sendRedirect("/workflow/form/editform.jsp?src=editform&formid="+formid+"&ajax="+ajax+"&isformadd="+isformadd);

  }
  else if(src.equalsIgnoreCase("editform")){
  	int formid=Util.getIntValue(Util.null2String(request.getParameter("formid")),0);
	String formname = request.getParameter("formname").replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
	boolean issamename = false;
  	RecordSet.executeSql("select namelabel from workflow_bill where id !="+formid);
    while(RecordSet.next()){//�±����͵�����
  	    int namelabel = Util.getIntValue(Util.null2String(RecordSet.getString("namelabel")),0);
  	    if(namelabel!=0)
  	    {
  	        if(formname.equals(SystemEnv.getHtmlLabelName(namelabel,user.getLanguage())))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	RecordSet.executeSql("select formname from workflow_formbase where id !="+formid);
    while(RecordSet.next()){//�ɱ���
  	    String tempformname = Util.null2String(RecordSet.getString("formname"));
  	    if(!tempformname.equals(""))
  	    {
  	        if(formname.equals(tempformname))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	if(issamename){
  		response.sendRedirect("/workflow/form/addform.jsp?src=editform&formid="+formid+"&ajax="+ajax+"&message=issamename");
	    return;
  	}
	FormManager.reset();
  	FormManager.setAction("editform");
  	FormManager.setFormid(formid);
  	FormManager.setFormname(Util.null2String(formname));
  	String formdes = request.getParameter("formdes").replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
  	FormManager.setFormdes( Util.null2String(formdes));
    FormManager.setSubCompanyId2(Util.getIntValue(request.getParameter("subcompanyid"),-1) );
  	FormManager.setFormInfo();
  	FormComInfo.removeFormCache();
    response.sendRedirect("/workflow/form/addform.jsp?src=editform&formid="+formid+"&ajax="+ajax);

  }
  else if(src.equalsIgnoreCase("formfield")){
 
  	int formid=Util.getIntValue(Util.null2String(request.getParameter("formid")),0);
	FormFieldMainManager.resetParameter();
    FormFieldMainManager.setGroupId(groupId);
	FormFieldMainManager.setFormid(formid);
	
	  String[] mulId;  
	  String ids=Util.null2String(request.getParameter("formfields"));//added by xwj for td3325 20051205
	  String ids2=Util.null2String(request.getParameter("formfields2"));//added by xwj for td3325 20051205
	  String mulIds=""; 
	   //��������ϸ by ben 2006-04-27
	  int rownum=Util.getIntValue(request.getParameter("rownum"),0);
	 
	for(int i = 0; i < rownum; i++)
	{
	    mulId = request.getParameterValues("destListMul" + i);
	      
	    if (mulId != null)
	    {
	    	for (int j = 0; j < mulId.length; j++)
	    	{ 
	    		mulIds += mulId[j];
	    		mulIds += ",";
	    	}
	    }
	}
	
	if(FormFieldMainManager.checkByRef(Util.null2String(request.getParameter("formfields")),mulIds+Util.null2String(request.getParameter("formfields2")))){
	        response.sendRedirect("/workflow/form/addformfield.jsp?formid="+formid+"&errorcode=1&ajax="+ajax);
	        return;
	    }

	if(WorkflowSubwfFieldManager.hasSubWfSettingForForm(","+Util.null2String(request.getParameter("formfields"))+","+mulIds+Util.null2String(request.getParameter("formfields2")),formid,0)){
		response.sendRedirect("/workflow/form/addformfield.jsp?formid="+formid+"&errorcode=2&ajax="+ajax);
	    return;
	}

    //fieldCommon.initNewFieldIsView(""+formid,Util.TokenizerString2(ids,","),Util.TokenizerString2(ids2,","));//added by xwj for td3325 20051205
    
	FormFieldMainManager.deleteFormfield();
	//delete by  by xwj for td3325 20051205
	FormFieldMainManager.saveFormfield(Util.TokenizerString2(ids,","));
    //begin ������ add
    
    FormFieldMainManager.deleteDetailFormfield();
   //delete by  xwj for td3325 20051205
    FormFieldMainManager.setGroupId(0);
	FormFieldMainManager.saveDetailFormfield(Util.TokenizerString2(ids2,","));
    //end
    
    //��������ϸ by ben 2006-04-27
    //int rownum=Util.getIntValue(request.getParameter("rownum"),0);
    for(int i = 0; i < rownum; i++)
    { 
    	mulId = request.getParameterValues("destListMul" + i);
    
    	if (mulId != null)
    	{
    		String[] temp;
    		temp=request.getParameterValues("null");
    		//fieldCommon.initNewFieldIsView("" + formid, temp, mulId);
    		FormFieldMainManager.setGroupId(i + 1);
			FormFieldMainManager.saveDetailFormfield(mulId);
		}
    }
    
    fieldCommon.initNewFieldIsView("" + formid, Util.TokenizerString2(ids, ","), Util.TokenizerString2(ids2 + mulIds, ","));
    
    //�����ɾ���ֶεĽڵ��ֶ���Ϣ
    FormFieldMainManager.deleteNodefield();
	response.sendRedirect("/workflow/form/addformfield.jsp?formid="+formid+"&ajax="+ajax);
  }
  else if(src.equalsIgnoreCase("formfieldlabel")){
  	int formid=Util.getIntValue(Util.null2String(request.getParameter("formid")),0);
  	ArrayList fields = new ArrayList();
  	ArrayList idarray = new ArrayList();

	FormFieldlabelMainManager.resetParameter();
	FormFieldlabelMainManager.setFormid(formid);
	FormFieldlabelMainManager.deleteFormfield();
	String ids=Util.null2String(request.getParameter("formfieldlabels"));
	if(!ids.equals("")){  //add by king for formfieldlabels is null
		int defaultlang=Util.getIntValue(Util.null2String(request.getParameter("isdefault")));
		idarray = Util.TokenizerString(ids,",");

		if(defaultlang==-1) defaultlang = user.getLanguage();//TD14315

		FormFieldMainManager.setFormid(formid);
		FormFieldMainManager.selectAllFormField();
		while(FormFieldMainManager.next()){
			int curid=FormFieldMainManager.getFieldid();
			fields.add(""+curid);
		}
		for(int i=0;i<idarray.size();i++) {
			int languageid = Util.getIntValue((String)idarray.get(i),0);
			String isdef = "0";
			if( languageid < 1)
				break;
			if(languageid == defaultlang)
				isdef = "1";
			for(int j=0; j< fields.size();j++) {
				String tfieldid=(String)fields.get(j);
				int fieldid = Util.getIntValue(tfieldid,0);
				FormFieldlabelMainManager.resetParameter();
				FormFieldlabelMainManager.setFormid(formid);
				FormFieldlabelMainManager.setFieldid(fieldid);
				FormFieldlabelMainManager.setLanguageid(languageid);
				String label = request.getParameter("label_"+languageid+"_"+fieldid);
				if(label == null){
					break;
                }
				label = Util.StringReplace(label, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
				label = Util.StringReplace(label, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
				FormFieldlabelMainManager.setFieldlabel(label);
				FormFieldlabelMainManager.setIsdefault(isdef);
				FormFieldlabelMainManager.saveFormfieldlabel();
			}
		}
	}

	response.sendRedirect("/workflow/form/addformfieldlabel.jsp?formid="+formid+"&ajax="+ajax);
  }
  else if (src.equalsIgnoreCase("formfielddetail"))
  {
    int formid=Util.getIntValue(Util.null2String(request.getParameter("formid")),0);

	String ids2=Util.null2String(request.getParameter("formfields2"));
	groupId=Util.getIntValue(Util.null2String(request.getParameter("groupId")),1);
	FormFieldMainManager.resetParameter();
    FormFieldMainManager.setGroupId(groupId);
	FormFieldMainManager.setFormid(formid);
	 FormFieldMainManager.deleteDetailFormfield();
   //delete by  xwj for td3325 20051205
	FormFieldMainManager.saveDetailFormfield(Util.TokenizerString2(ids2,","));
	response.sendRedirect("/workflow/form/addformfield.jsp?formid="+formid+"&ajax="+ajax);
    return;
}else if(src.equals("eidtform")){
	String formname = Util.null2String(request.getParameter("formname"));
	String formid = Util.null2String(request.getParameter("formid"));
  	formname = formname.replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
	formname = Util.toHtmlForSplitPage(formname);
  		boolean issamename = false;
  	RecordSet.executeSql("select namelabel from workflow_bill where id !="+formid);
    while(RecordSet.next()){//�±����͵�����
  	    int namelabel = Util.getIntValue(Util.null2String(RecordSet.getString("namelabel")),0);
  	    if(namelabel!=0)
  	    {
  	        if(formname.equals(SystemEnv.getHtmlLabelName(namelabel,user.getLanguage())))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	RecordSet.executeSql("select formname from workflow_formbase where id !="+formid);
    while(RecordSet.next()){//�ɱ���
  	    String tempformname = Util.null2String(RecordSet.getString("formname"));
  	    if(!tempformname.equals(""))
  	    {
  	        if(formname.equals(tempformname))
  	        {
  	            issamename = true;
  	            break;
  	        }
  	    }
  	}
  	if(issamename){
  		response.sendRedirect("/workflow/form/editform.jsp?ajax=1&formid="+formid+"&message=issamename");
	    return;
  	}
  	int namelabelid = -1;
  	if(issqlserver) RecordSet.executeSql("select indexid from HtmlLabelInfo where labelname='"+formname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		else RecordSet.executeSql("select indexid from HtmlLabelInfo where labelname='"+formname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		if(RecordSet.next()) namelabelid = RecordSet.getInt("indexid");//����������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		else{
			namelabelid = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			if(namelabelid!=-1){//���±�ǩ��
				RecordSet.executeSql("delete from HtmlLabelIndex where id="+namelabelid);
				RecordSet.executeSql("delete from HtmlLabelInfo where indexid="+namelabelid);
				RecordSet.executeSql("INSERT INTO HtmlLabelIndex values("+namelabelid+",'"+formname+"')");
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',7)");
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',8)");
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+namelabelid+",'"+formname+"',9)");
			}
		}
		LabelComInfo.addLabeInfoCache(""+namelabelid);//����������ӱ����Ƶı�ǩ
			  
  	String formdes = Util.null2String(request.getParameter("formdes"));
  	formdes = formdes.replaceAll("<","��").replaceAll(">","��").replaceAll("'","''");
  	formdes = Util.toHtmlForSplitPage(formdes);
  	int subcompanyid = Util.getIntValue(request.getParameter("subcompanyid"),-1);
  	if(subcompanyid==-1){//��Ȩ�ֲ���ȡ�á����ҳ��û�У������ȴӷ�Ȩ���õ�Ĭ�ϻ���ȡ�ã����Ĭ�ϻ���û��������ȡ���зֲ���id��С���Ǹ��ֲ���
			RecordSet.executeSql("select dftsubcomid from SystemSet");
			if(RecordSetTrans.next()) subcompanyid = Util.getIntValue(RecordSet.getString("dftsubcomid"),-1);
			if(subcompanyid==-1){
		  	RecordSet.executeSql("select min(id) as id from HrmSubCompany");
		  	if(RecordSet.next()) subcompanyid = RecordSet.getInt("id");
			}
		}	
  	RecordSet.executeSql("update workflow_bill set subcompanyid="+subcompanyid+", namelabel="+namelabelid+",formdes='"+formdes+"' where id="+formid);
  	response.sendRedirect("/workflow/form/editform.jsp?ajax=1&formid="+formid);
}else if(src.equals("addfieldbatch")){//��������ֶ�
  	char flag=2;
  	RecordSetTrans.setAutoCommit(false);
  	
  	try{
  	int formid = Util.getIntValue((request.getParameter("formid")),0);//��id
  	String maintablename = "formtable_main_"+formid*(-1);//������
  	int recordNum = Util.getIntValue(Util.null2String(request.getParameter("recordNum")),0);//�ֶ�����
  	String delids = Util.null2String(request.getParameter("delids"));//ɾ����id��
  	String changeRowIndexs = Util.null2String(request.getParameter("changeRowIndexs"));//�иı����id��
  	String labelidsCache = ",";//���»�����
  	
  	//���ֶ� ��ʼ
  	ArrayList delidsArray = Util.TokenizerString(delids,",");
  	for(int i=0;i<delidsArray.size();i++){//ɾ��ָ�����ֶ�
  		String fieldnameForDel = "";
  		String delFieldId = (String)delidsArray.get(i);

			//������ֶα��й������ã����˳���
			RecordSetTrans.executeSql("select * from workflow_formdetailinfo where maincalstr like '%_"+delFieldId+"[^0-9]%' or maincalstr like '%_"+delFieldId+"'");
			if(RecordSetTrans.next()){
			    RecordSetTrans.rollback();
			    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodelete");
			    return;
			}

           if(WorkflowSubwfFieldManager.hasSubWfSetting(RecordSetTrans,Util.getIntValue(delFieldId,0),1)){
			    RecordSetTrans.rollback();
			    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodeleteForSubWf");
			    return;
			}


  		RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+delFieldId);
  		if(RecordSetTrans.next()) fieldnameForDel = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
  		RecordSetTrans.executeSql("alter table "+maintablename+" drop column "+fieldnameForDel);//�޸ı�ṹ
  		RecordSetTrans.executeSql("delete from workflow_billfield where id="+delFieldId);//ɾ���ֶ�
  		RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+delFieldId);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
  		RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid="+delFieldId);//ɾ����workflow_specialfield�и��ֶζ�Ӧ����
  		
			//ɾ������ֶ���صĳ�������
			Pattern mpattern = null;
			Matcher mmatcher = null;
			String partStr = "\\b"+fieldnameForDel+"\\b";
			mpattern = Pattern.compile(partStr);
			ArrayList nodelinkidList = new ArrayList();
			ArrayList conditionList = new ArrayList();
			
			//RecordSetTrans.execute("select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")");
			//while(RecordSetTrans.next()){
			//    int nlid = Util.getIntValue(RecordSetTrans.getString("id"));
			//    String condition = Util.null2String(RecordSetTrans.getString("condition"));
			//    nodelinkidList.add(""+nlid);
			//    conditionList.add(""+condition);
			//}
			//�����ֶκ��µĶ�ȡ��ʽ��ʼ
			 String strSql = "select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")";
			 weaver.conn.ConnStatement statement=new weaver.conn.ConnStatement();
	    	 weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			 String docContent = "";
	    	 statement.setStatementSql(strSql, false);
	    	 statement.executeQuery();
	  		if(statement.next()){
			  	 if(statement.getDBType().equals("oracle"))
			  	 {
			  			oracle.sql.CLOB theclob = statement.getClob("condition"); 
				  		String readline = "";
				        StringBuffer clobStrBuff = new StringBuffer("");
				        java.io.BufferedReader clobin = new java.io.BufferedReader(theclob.getCharacterStream());
				        while ((readline = clobin.readLine()) != null) clobStrBuff = clobStrBuff.append(readline);
				        clobin.close() ;
				        docContent = clobStrBuff.toString();
			  	  }else{
					  		docContent=statement.getString("condition");
			  }
		  	 
		  	 int nlid = Util.getIntValue(statement.getString("id"));
		  	 nodelinkidList.add(""+nlid);
		     conditionList.add(""+docContent);
	  		}
		  	 //�����ֶκ��µĶ�ȡ��ʽ����
			
			for(int cx=0; cx<nodelinkidList.size(); cx++){
			    String nlid = Util.null2String((String)nodelinkidList.get(cx));
			    String condition = Util.null2String((String)conditionList.get(cx));
			    mmatcher = mpattern.matcher(condition);
			    boolean find = mmatcher.find();
			    if(find==true){
			        //RecordSetTrans.execute("update workflow_nodelink set condition='' , conditioncn='' where id="+nlid);
			        String sql = "update workflow_nodelink set condition='' , conditioncn='' where id="+nlid;
			        if(statement.getDBType().equals("oracle"))
			            sql = "update workflow_nodelink set condition=empty_clob() , conditioncn=empty_clob() where id="+nlid;
	                statement.setStatementSql(sql);
	                statement.executeUpdate();
			    }
			}
			//ɾ������ֶ���صĳ�������
			
			//ɾ���ڵ㸽�Ӳ���
			RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + delFieldId + " or fieldop1id = " + delFieldId + " or fieldop2id = " + delFieldId + ")" );
			//ɾ�����ڸ��Ӳ���
			RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + delFieldId + " or fieldop1id = " + delFieldId + " or fieldop2id = " + delFieldId + ")");
			//ɾ�����Զ����ֶβ����Ĳ����ˣ���Ҫ��������������
			RecordSetTrans.executeSql("delete from  workflow_groupdetail where type in(5,6,31,32,7,38,42,43,8,33,9,10,47,34,11,12,13,35,14,15,44,45,46,16) and groupid in(select id from workflow_nodegroup where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ")) and objid=" + delFieldId);
			//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
			RecordSetTrans.executeSql("delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and fieldid= " + delFieldId);
			//ɾ�������ֶε���Ϣ
			RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid =" + delFieldId);

			  		
  	}
  	
  	ArrayList changeRowIndexsArray = Util.TokenizerString(changeRowIndexs,",");
  	for(int i=0;i<changeRowIndexsArray.size();i++){//�޸��иı����(���������кͱ༭��)
  		String index = (String)changeRowIndexsArray.get(i);
  		String new_OR_modify = Util.null2String(request.getParameter("modifyflag_"+index));
  		if(!new_OR_modify.equals("")){//��Ϊ�ձ�ʾ�Ǳ༭�ֶΣ�Ϊ�ձ�ʾ������ֶΡ�
  			//�Ա༭�ֶ���ɾ���������
  			
  			//�ֶα༭ʱ�������޸��ֶ����ݿ���������Ҫ��������id���������������ݶ�ʧ��TD10290
  			//String fieldnameForDrop = "";
  			//RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+new_OR_modify);
  			//if(RecordSetTrans.next()) fieldnameForDrop = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
  			//RecordSetTrans.executeSql("alter table "+maintablename+" drop column "+fieldnameForDrop);//�޸ı�ṹ
  			//RecordSetTrans.executeSql("delete from workflow_billfield where id="+new_OR_modify);//ɾ���ֶ�
  			//�ֶα༭ʱ�������޸��ֶ����ݿ���������Ҫ��������id���������������ݶ�ʧ��TD10290
  			
			  RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+new_OR_modify);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
	  		RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid="+new_OR_modify);//ɾ����workflow_specialfield�и��ֶζ�Ӧ����	
  		}
  			String fieldname = "";//���ݿ��ֶ�����
  			int fieldlabel = 0;//�ֶ���ʾ����ǩid
  			String fielddbtype = "";//�ֶ����ݿ�����
			String _fielddbtype = "";//�ֶ����ݿ�����
  			String fieldhtmltype = "";//�ֶ�ҳ������
  			String type = "";//�ֶ���ϸ����
  			String dsporder = "";//��ʾ˳��
  			String viewtype = "0";//viewtype="0"��ʾ�����ֶ�,viewtype="1"��ʾ��ϸ���ֶ�
  			String detailtable = "";//��ϸ����
  			int textheight = 0;//�����ı���ĸ߶�
  			
  			fieldname = Util.null2String(request.getParameter("itemDspName_"+index));
  			if(fieldname.equals("")) continue;//����Ӻ�ɾ����
  			int imgwidth = Util.getIntValue(request.getParameter("imgwidth_"+index),0);
            int imgheight = Util.getIntValue(request.getParameter("imgheight_"+index),0);
  			String fieldlabelname = Util.null2String(request.getParameter("itemFieldName_"+index));
  			fieldlabelname = Util.StringReplace(fieldlabelname, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
  			fieldlabelname = Util.StringReplace(fieldlabelname, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
  			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	if(RecordSetTrans.next()) fieldlabel = RecordSetTrans.getInt("indexid");//����ֶ������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		  	else{
		  		fieldlabel = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			  	if(fieldlabel!=-1){//���±�ǩ��
			  		labelidsCache+=fieldlabel+",";
			  		RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+fieldlabel);
			  		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+fieldlabel);
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+fieldlabel+",'"+fieldlabelname+"')");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',7)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',8)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',9)");
			  	}
			  }
			  
			  fieldhtmltype = Util.null2String(request.getParameter("itemFieldType_"+index));
			  if(fieldhtmltype.equals("1")){
				  int decimaldigits = Util.getIntValue(request.getParameter("decimaldigits_"+index),2);
			  	type = Util.null2String(request.getParameter("documentType_"+index));	
				  if(type.equals("1")){
				  	String strlength = Util.null2String(request.getParameter("itemFieldScale1_"+index));
				  	if(Util.getIntValue(strlength,1)<=1) strlength = "1";
			    	if(isoracle) fielddbtype="varchar2("+strlength+")";
			    	else fielddbtype="varchar("+strlength+")";
			    	
			    	if(!new_OR_modify.equals("")){
			    	    String oldfielddbtype = "";
			    	    RecordSetTrans.executeSql("select fielddbtype from workflow_billfield where id="+new_OR_modify);
			    	    if(RecordSetTrans.next()) oldfielddbtype = RecordSetTrans.getString("fielddbtype");
			    	    
			    	    if(!fielddbtype.equals(oldfielddbtype)){
			    	        if(isoracle) RecordSetTrans.executeSql("ALTER TABLE "+maintablename+" MODIFY "+fieldname+" "+fielddbtype);
			    	        else RecordSetTrans.executeSql("ALTER TABLE "+maintablename+" ALTER COLUMN "+fieldname+" "+fielddbtype);
			    	    }
			    	}
			   	}
				 	if(type.equals("2")){
			   		if(isoracle) fielddbtype="integer";
			   		else fielddbtype="int";
			   	}
				 	if(type.equals("3")){
			   		if(isoracle) fielddbtype="number(15,"+decimaldigits+")";
			   		else fielddbtype="decimal(15,"+decimaldigits+")";
			 	 	}
			   	if(type.equals("4")){
			   		if(isoracle) fielddbtype="number(15,2)";
			   		else fielddbtype="decimal(15,2)";
					}
			   	if(type.equals("5")){
			   		if(isoracle) fielddbtype="varchar2(30)";
			   		else fielddbtype="varchar(30)";
					}
			  }
			  if(fieldhtmltype.equals("2")){
			  	String htmledit = Util.null2String(request.getParameter("htmledit_"+index));
			  	if(htmledit.equals("")) type="1";
			  	else type=htmledit;
					if(isoracle) fielddbtype="varchar2(4000)";
					else if(isdb2) fielddbtype="varchar(2000)";
					else fielddbtype="text";
					textheight = Util.getIntValue(Util.null2String(request.getParameter("textheight_"+index)),4);
			  }
			  if(fieldhtmltype.equals("3")){
			  	int temptype = Util.getIntValue(Util.null2String(request.getParameter("broswerType_"+index)),0);
			  	type = ""+temptype;
			  	if(temptype>0)
			  		fielddbtype=BrowserComInfo.getBrowserdbtype(type+"");
				  	if(temptype==118){
				  		if(isoracle) fielddbtype="varchar2(200)";
			              else fielddbtype="varchar(200)";
				  	}
					if(temptype==161||temptype==162){
						fielddbtype=Util.null2String(request.getParameter("definebroswerType_"+index));
						if(temptype==161){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
					}
					if(temptype==224||temptype==225){
						fielddbtype=Util.null2String(request.getParameter("sapbrowser_"+index));
						if(temptype==224){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
					}
					
					if(temptype==226||temptype==227){
						fielddbtype=Util.null2String(request.getParameter("showvalue_"+index));
						if(temptype==226){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
					}
					
					
				  if(temptype==165||temptype==166||temptype==167||temptype==168) 
				  	textheight=Util.getIntValue(Util.null2String(request.getParameter("decentralizationbroswerType_"+index)),0); 
			  }
			  if(fieldhtmltype.equals("4")){
			  	type = "1";
			  	fielddbtype="char(1)";
			  }
			  if(fieldhtmltype.equals("5"))	{
			  	type = "1";
			  	if(isoracle) fielddbtype="integer";
			  	else fielddbtype="int";
			  }
			  if(fieldhtmltype.equals("6"))	{
			  	type = "" + Util.getIntValue(Util.null2String(request.getParameter("uploadtype_"+index)), 1);
			    if(isoracle) fielddbtype="varchar2(4000)";
				  else if(isdb2) fielddbtype="varchar(2000)";
			    else fielddbtype="text";
                textheight = Util.getIntValue(Util.null2String(request.getParameter("strlength_"+index)), 0);  
			  }
			  if(fieldhtmltype.equals("7"))	{
			  	type = Util.null2String(request.getParameter("specialfield_"+index));
			    if(isoracle) fielddbtype="varchar2(4000)";
				  else if(isdb2) fielddbtype="varchar(2000)";
			    else fielddbtype="text";
			  }			  
			  dsporder = Util.null2String(request.getParameter("itemDspOrder_"+index));
			  //if(dsporder.equals("")) dsporder="0";
			  dsporder = ""+Util.getFloatValue(dsporder,0);
			  int childfieldid_tmp = Util.getIntValue(request.getParameter("childfieldid_"+index), 0);
			  if(!new_OR_modify.equals("")){//��Ϊ�ձ�ʾ�Ǳ༭�ֶΣ�Ϊ�ձ�ʾ������ֶΡ�
			  	String oldfieldname = "";
			  	String oldfielddbtype = "";
			  	RecordSetTrans.executeSql("select fieldname,fielddbtype from workflow_billfield where id="+new_OR_modify);
			  	if(RecordSetTrans.next()){
			  	    oldfieldname = RecordSetTrans.getString("fieldname");
			  	    oldfielddbtype = RecordSetTrans.getString("fielddbtype");
			  	}
			  	RecordSetTrans.executeSql("update workflow_billfield set billid="+formid+",fieldname='"+fieldname+"',fieldlabel="+fieldlabel+",fielddbtype='"+fielddbtype+"',fieldhtmltype="+fieldhtmltype+",type="+type+",dsporder="+dsporder+",viewtype="+viewtype+",detailtable='"+detailtable+"',textheight="+textheight+",childfieldid="+childfieldid_tmp+",imgwidth="+imgwidth+",imgheight="+imgheight+" where id="+new_OR_modify);
			  	if(!fieldname.equals(oldfieldname)||(!fielddbtype.equals(oldfielddbtype) && !"1".equals(fieldhtmltype) && !"".equals(type))){//�޸������ݿ��ֶ����ƻ�����
			  	    RecordSetTrans.executeSql("select "+oldfieldname+" from "+maintablename);
			  	    if(!RecordSetTrans.next()){
			  	    	RecordSetTrans.executeSql("alter table "+maintablename+" drop column "+oldfieldname);
			  	    	if(fieldhtmltype.equals("3")&&(type.equals("161")||type.equals("162"))){
			  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	    }else if(fieldhtmltype.equals("3")&&(type.equals("224")||type.equals("225"))){
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	    }else if(fieldhtmltype.equals("3")&&(type.equals("226")||type.equals("227"))){
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	    }
				  	    else{
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+fielddbtype);
				  	    }
			  	    } 
			  	}
				}else{
				  //�����ֶ���Ϣ
				  RecordSetTrans.executeSql("INSERT INTO workflow_billfield(billid,fieldname,fieldlabel,fielddbtype,fieldhtmltype,type,dsporder,viewtype,detailtable,textheight,childfieldid,imgwidth,imgheight) "+
				  " VALUES ("+formid+",'"+fieldname+"',"+fieldlabel+",'"+fielddbtype+"',"+fieldhtmltype+","+type+","+dsporder+","+viewtype+",'"+detailtable+"',"+textheight+","+childfieldid_tmp+","+imgwidth+","+imgheight+")");
			  }
			  if(new_OR_modify.equals("")){//������ֶ�
			  //��������ṹ
			  if(fieldhtmltype.equals("3")&&(type.equals("161")||type.equals("162"))){
			  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
			  }else if(fieldhtmltype.equals("3")&&(type.equals("224")||type.equals("225"))){
			  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
			  }else if(fieldhtmltype.equals("3")&&(type.equals("226")||type.equals("227"))){
			  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
			  }
			  else{
			  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+fielddbtype);
			  }
			  }
			  
			  //�����ѡ��򣬸��±�workflow_SelectItem
			  String curfieldid = "";
			  if(new_OR_modify.equals("")){
			      RecordSetTrans.executeSql("select max(id) as id from workflow_billfield");
			      if(RecordSetTrans.next()) curfieldid = RecordSetTrans.getString("id");
			  }else{
			      curfieldid = new_OR_modify;
			  }
			  if(fieldhtmltype.equals("5")){
			  	int rowsum = Util.getIntValue(Util.null2String(request.getParameter("choiceRows_"+index)));
                int curvalue=0;
			  	for(int temprow=1;temprow<=rowsum;temprow++){
			  		String curname = Util.null2String(request.getParameter("field_"+index+"_"+temprow+"_name"));
			  		if(curname.equals("")) continue;
			  		String curorder = Util.null2String(request.getParameter("field_count_"+index+"_"+temprow+"_name"));
			  		String isdefault = "n";
			  		String checkValue = Util.null2String(request.getParameter("field_checked_"+index+"_"+temprow+"_name"));
			  		String cancel = Util.null2String(request.getParameter("cancel_"+index+"_"+temprow+"_name")); 
			  		if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
						cancel = "1";
					}else{
						cancel = "0";
					}
					if(checkValue.equals("1")) isdefault="y";
			  			int isAccordToSubCom_tmp = Util.getIntValue(request.getParameter("isAccordToSubCom"+index+"_"+temprow), 0);
						String doccatalog = Util.null2String(request.getParameter("maincategory_"+index+"_"+temprow));
						String docPath = Util.null2String(request.getParameter("pathcategory_"+index+"_"+temprow));
						String childItem_tmp = Util.null2String(request.getParameter("childItem_"+index+"_"+temprow));
						String para=curfieldid+flag+"1"+flag+""+curvalue+flag+curname+flag+curorder+flag+isdefault+flag+cancel; 
						RecordSetTrans.executeProc("workflow_selectitem_insert_new",para);//���±�workflow_SelectItem
						RecordSetTrans.executeSql("update workflow_SelectItem set docpath='"+docPath+"', docCategory='"+doccatalog+"',childitemid='"+childItem_tmp+"',isAccordToSubCom='"+isAccordToSubCom_tmp+"' where fieldid="+curfieldid+" and selectvalue="+curvalue);
                        curvalue++;
			  	}
			  }
			  if(fieldhtmltype.equals("7")){              
	               String displayname = Util.null2String(request.getParameter("displayname_"+index));//��ʾ��
	               String linkaddress = Util.null2String(request.getParameter("linkaddress_"+index));//���ӵ�ַ
	               String descriptivetext = Util.null2String(request.getParameter("descriptivetext_"+index));//����������
	               descriptivetext = Util.spacetoHtml(descriptivetext);	
		  	       String specialfield = Util.null2String(request.getParameter("specialfield_"+index));//����
		  	       //String sql = "select max(id) from workflow_billfield";
			       //RecordSetTrans.executeSql(sql);
			       //RecordSetTrans.next();
			       //String curfieldid=RecordSetTrans.getString(1);
			       //if(!new_OR_modify.equals("")) curfieldid = new_OR_modify;
		           String sql = "";
		           if(specialfield.equals("1")){
		              sql = "insert into workflow_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+curfieldid+",'"+displayname+"','"+linkaddress+"',0,1)";    
		           }else{
		              sql = "insert into workflow_specialfield(fieldid,descriptivetext,isform,isbill) values("+curfieldid+",'"+descriptivetext+"',0,1)";    
		           }
			       RecordSetTrans.executeSql(sql);
			  }
			  
			  if(new_OR_modify.equals("")){//�½��ֶβ��뵽�ڵ�
				String insertFieldId = curfieldid;
			  	RecordSetTrans.execute("select count(nodeid) as wfnfc from workflow_nodeform where fieldid="+insertFieldId);
			  	int wf_nf_count = 0;
			  	if(RecordSetTrans.next()){
			  		wf_nf_count = Util.getIntValue(RecordSetTrans.getString(1), 0);
			  	}
			  	if(wf_nf_count<1){
					ArrayList arrNodeId = new ArrayList();
					RecordSetTrans.executeSql("select nodeid from workflow_flownode where workflowid in (select id from workflow_base where formid="+formid+" and isbill=1)");
					while(RecordSetTrans.next()){
						arrNodeId.add(RecordSetTrans.getString("nodeid"));
					}
					for(int h=0; h < arrNodeId.size(); h++){
						RecordSetTrans.executeSql("insert into workflow_nodeform(nodeid,fieldid,isview,isedit,ismandatory) values("+(String)arrNodeId.get(h)+","+insertFieldId+",'0','0','0')");
					}
			  	}//if(wf_nf_count<1){
			  }
			  
  	}
  	//���ֶ� ����
  	
  	//��ϸ�ֶ� ��ʼ
  	int detailtables = Util.getIntValue((request.getParameter("detailtables")),0);//��ϸ����
  	String detailtableIndexs = Util.null2String(request.getParameter("detailtableIndexs"));//��ϸ����ż�
  	ArrayList detailtableIndexsArray = Util.TokenizerString(detailtableIndexs,",");
  	for(int tempi=0;tempi<detailtables;tempi++){
  		int i = Util.getIntValue((String)detailtableIndexsArray.get(tempi),0);
  		boolean isexist = false;
			String detailtable = maintablename+"_dt"+i;//��ϸ������
			RecordSetTrans.executeSql("select * from Workflow_billdetailtable where billid="+formid+" and tablename='"+detailtable+"'");
			if(RecordSetTrans.next()) isexist=true;//��ϸ���Ѵ���
			
			String dbtype = RecordSet.getDBType();
			String sql = "";
			if (dbtype.equalsIgnoreCase("oracle")) {
			    sql = "select 1 from user_tables where TABLE_NAME = upper('" + detailtable + "')";
			} else if (dbtype.toLowerCase().indexOf("sqlserver")>-1||dbtype.equalsIgnoreCase("sybase")) {
			    sql = "select 1 from sysobjects where name = '" + detailtable + "' ";
			} else if (dbtype.equalsIgnoreCase("informix")) {
			    sql = "select 1 from systables where lower(tabname) = lower('" + detailtable + "') ";
			} else if (dbtype.equalsIgnoreCase("mysql")) {
			    sql = "select 1 from information_schema.Tables where LOWER(Table_Name)=LOWER('" + detailtable + "') ";
			} else if (dbtype.equalsIgnoreCase("db2")) {
			    sql = "select 1 from SYSIBM.SYSTABLES where lower(name)= lower('" + detailtable + "') ";
			}else{
			    sql="select 1 from "+detailtable;
			}
			RecordSetTrans.executeSql(sql);
			if(RecordSetTrans.next()) isexist=true;//��ϸ���Ѵ���
			
			if(!isexist){//��ϸ�����ڣ����½���ϸ��
	  		if(isoracle){
		  		RecordSetTrans.executeSql("create table " + detailtable + "(id integer primary key not null,mainid integer)");
		  	}else{
		  		RecordSetTrans.executeSql("create table " + detailtable + "(id int IDENTITY(1,1) primary key CLUSTERED,mainid int)");
		 		}
		 		//�������ϸ����Ϣworkflow_billdetailtable
		 		RecordSetTrans.executeSql("INSERT INTO workflow_billdetailtable(billid,tablename,orderid) values("+formid+",'"+detailtable+"',"+i+")");
	 		}
			  
	  	String detaildelids = Util.null2String(request.getParameter("detaildelids_"+i));//ɾ����id��
	  	String detailChangeRowIndexs = Util.null2String(request.getParameter("detailChangeRowIndexs_"+i));//�иı����id��
	  	
	  	ArrayList detaildelidsArray = Util.TokenizerString(detaildelids,",");
	  	for(int j=0;j<detaildelidsArray.size();j++){//ɾ��ָ�����ֶ�
	  		String fieldnameForDel = "";
	  		String delFieldId = (String)detaildelidsArray.get(j);

				//����ֶα����й������ã����˳���
				RecordSetTrans.executeSql("select * from workflow_formdetailinfo where rowcalstr like '%_"+delFieldId+"[^0-9]%' or rowcalstr like '%_"+delFieldId+"' or colcalstr like '%_"+delFieldId+"[^0-9]%' or colcalstr like '%_"+delFieldId+"' or maincalstr like '%_"+delFieldId+"[^0-9]%' or maincalstr like '%_"+delFieldId+"'");
				if(RecordSetTrans.next()){
				    RecordSetTrans.rollback();
				    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodelete");
				    return;
				}

               if(WorkflowSubwfFieldManager.hasSubWfSetting(RecordSetTrans,Util.getIntValue(delFieldId,0),1)){
			        RecordSetTrans.rollback();
			        response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodeleteForSubWf");
			        return;
			    }

	  		RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+delFieldId);
	  		if(RecordSetTrans.next()) fieldnameForDel = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
	  		RecordSetTrans.executeSql("alter table "+detailtable+" drop column "+fieldnameForDel);//�޸ı�ṹ
	  		RecordSetTrans.executeSql("delete from workflow_billfield where id="+delFieldId);//ɾ���ֶ�
	  		RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+delFieldId);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
	  		
				//ɾ���ڵ㸽�Ӳ���
				RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + delFieldId + " or fieldop1id = " + delFieldId + " or fieldop2id = " + delFieldId + ")" );
				//ɾ�����ڸ��Ӳ���
				RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + delFieldId + " or fieldop1id = " + delFieldId + " or fieldop2id = " + delFieldId + ")");
				//ɾ�����Զ����ֶβ����Ĳ����ˣ���Ҫ��������������
				RecordSetTrans.executeSql("delete from  workflow_groupdetail where type in(5,6,31,32,7,38,42,43,8,33,9,10,47,34,11,12,13,35,14,15,44,45,46,16) and groupid in(select id from workflow_nodegroup where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ")) and objid=" + delFieldId);
				//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
				RecordSetTrans.executeSql("delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and fieldid= " + delFieldId);
				//ɾ�������ֶε���Ϣ
				RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid =" + delFieldId);

					  		
	  	}
	  	
	  	ArrayList detailChangeRowIndexsArray = Util.TokenizerString(detailChangeRowIndexs,",");
	  	for(int j=0;j<detailChangeRowIndexsArray.size();j++){//�޸��иı����(���������кͱ༭��)
	  		String temprowindex = (String)detailChangeRowIndexsArray.get(j);

	  		String new_OR_modify = Util.null2String(request.getParameter("modifyflag_"+i+"_"+temprowindex));
	  		if(!new_OR_modify.equals("")){//��Ϊ�ձ�ʾ�Ǳ༭�ֶΣ�Ϊ�ձ�ʾ������ֶΡ�
	  			//�Ա༭�ֶ���ɾ���������
	  			
	  			//�ֶα༭ʱ�������޸��ֶ����ݿ���������Ҫ��������id���������������ݶ�ʧ��TD10290
	  			//String fieldnameForDrop = "";
	  			//RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+new_OR_modify);
	  			//if(RecordSetTrans.next()) fieldnameForDrop = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
	  			//RecordSetTrans.executeSql("alter table "+detailtable+" drop column "+fieldnameForDrop);//�޸ı�ṹ
	  			//RecordSetTrans.executeSql("delete from workflow_billfield where id="+new_OR_modify);//ɾ���ֶ�
	  			//�ֶα༭ʱ�������޸��ֶ����ݿ���������Ҫ��������id���������������ݶ�ʧ��TD10290
	  			
				  RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+new_OR_modify);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
	  		}
	  		
	  		String detailfieldname = "";//���ݿ��ֶ�����
  			int detailfieldlabel = 0;//�ֶ���ʾ����ǩid
  			String detailfielddbtype = "";//�ֶ����ݿ�����
  			String _detailfielddbtype = "";//�ֶ����ݿ�����
  			String detailfieldhtmltype = "";//�ֶ�ҳ������
  			String detailtype = "";//�ֶ���ϸ����
  			String detaildsporder = "";//��ʾ˳��
  			String viewtype = "1";//viewtype="0"��ʾ�����ֶ�,viewtype="1"��ʾ��ϸ���ֶ�
  			//String detailtable = "";//��ϸ����
  			int detailtextheight = 0;//�����ı���ĸ߶�
  			
  			detailfieldname = Util.null2String(request.getParameter("itemDspName_detail"+i+"_"+temprowindex));
  			detailfieldname = Util.StringReplace(detailfieldname, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
  			detailfieldname = Util.StringReplace(detailfieldname, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
  			if(detailfieldname.equals("")) continue;//����Ӻ�ɾ����

  			String detailfieldlabelname = Util.null2String(request.getParameter("itemFieldName_detail"+i+"_"+temprowindex));
  			detailfieldlabelname = Util.StringReplace(detailfieldlabelname, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
  			detailfieldlabelname = Util.StringReplace(detailfieldlabelname, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
  			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+detailfieldlabelname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+detailfieldlabelname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  	if(RecordSetTrans.next()) detailfieldlabel = RecordSetTrans.getInt("indexid");//����ֶ������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		  	else{
		  		detailfieldlabel = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			  	if(detailfieldlabel!=-1){//���±�ǩ��
			  		labelidsCache+=detailfieldlabel+",";
			  		RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+detailfieldlabel);
			  		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+detailfieldlabel);
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+detailfieldlabel+",'"+detailfieldlabelname+"')");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+detailfieldlabel+",'"+detailfieldlabelname+"',7)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+detailfieldlabel+",'"+detailfieldlabelname+"',8)");
			  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+detailfieldlabel+",'"+detailfieldlabelname+"',9)");
			  	}
			  }
  			
			  detailfieldhtmltype = Util.null2String(request.getParameter("itemFieldType_"+i+"_"+temprowindex));
			  if(detailfieldhtmltype.equals("1")){
			  	detailtype = Util.null2String(request.getParameter("documentType_"+i+"_"+temprowindex));
			  	int decimaldigits = Util.getIntValue(request.getParameter("decimaldigits_"+i+"_"+temprowindex),2);
				  if(detailtype.equals("1")){
				  	String strlength = Util.null2String(request.getParameter("itemFieldScale1_"+i+"_"+temprowindex));
				  	if(Util.getIntValue(strlength,1)<=1) strlength = "1";
			    	if(isoracle) detailfielddbtype="varchar2("+strlength+")";
			    	else detailfielddbtype="varchar("+strlength+")";
			    	
			    	if(!new_OR_modify.equals("")){
			    	    String olddetailfielddbtype = "";
			    	    RecordSetTrans.executeSql("select fielddbtype from workflow_billfield where id="+new_OR_modify);
			    	    if(RecordSetTrans.next()) olddetailfielddbtype = RecordSetTrans.getString("fielddbtype");
			    	    
			    	    if(!detailfielddbtype.equals(olddetailfielddbtype)){
			    	        if(isoracle) RecordSetTrans.executeSql("ALTER TABLE "+detailtable+" MODIFY "+detailfieldname+" "+detailfielddbtype);
			    	        else RecordSetTrans.executeSql("ALTER TABLE "+detailtable+" ALTER COLUMN "+detailfieldname+" "+detailfielddbtype);
			    	    }
			    	}
			   	}
				 	if(detailtype.equals("2")){
			   		if(isoracle) detailfielddbtype="integer";
			   		else detailfielddbtype="int";
			   	}
				 	if(detailtype.equals("3")){
			   		if(isoracle) detailfielddbtype="number(15,"+decimaldigits+")";
			   		else detailfielddbtype="decimal(15,"+decimaldigits+")";
			 	 	}
			   	if(detailtype.equals("4")){
			   		if(isoracle) detailfielddbtype="number(15,2)";
			   		else detailfielddbtype="decimal(15,2)";
					}
			   	if(detailtype.equals("5")){
			   		if(isoracle) detailfielddbtype="varchar2(30)";
			   		else detailfielddbtype="varchar(30)";
					}
			  }
			  if(detailfieldhtmltype.equals("2")){
			  	detailtype = "1";
			  	String htmledit = Util.null2String(request.getParameter("htmledit_"+i+"_"+temprowindex));
					if(isoracle) detailfielddbtype="varchar2(4000)";
					else if(isdb2) detailfielddbtype="varchar(2000)";
					else detailfielddbtype="text";
					if(!htmledit.equals("")) detailtype=htmledit;
					detailtextheight = Util.getIntValue(Util.null2String(request.getParameter("textheight_"+i+"_"+temprowindex)),0);
			  }
			  if(detailfieldhtmltype.equals("3")){
			  	int temptype = Util.getIntValue(Util.null2String(request.getParameter("broswerType_"+i+"_"+temprowindex)),0);
			  	detailtype = ""+temptype;
			  	
			  	if(temptype>0)
			  		detailfielddbtype=BrowserComInfo.getBrowserdbtype(detailtype+"");
				  	if(temptype==118){
				  		if(isoracle) detailfielddbtype="varchar2(200)";
			              else detailfielddbtype="varchar(200)";
				  	}
					if(temptype==161||temptype==162){
						detailfielddbtype=Util.null2String(request.getParameter("definebroswerType_"+i+"_"+temprowindex));
						if(temptype==161){
							if(isoracle) _detailfielddbtype="varchar2(1000)";
							else if(isdb2) _detailfielddbtype="varchar(1000)";
							else _detailfielddbtype="varchar(1000)";
						}else{
							if(isoracle) _detailfielddbtype="varchar2(4000)";
							else if(isdb2) _detailfielddbtype="varchar(2000)";
							else _detailfielddbtype="text";
						}
					}	
					if(temptype==224||temptype==225){
						detailfielddbtype=Util.null2String(request.getParameter("sapbrowser_"+i+"_"+temprowindex));
						if(temptype==224){
							if(isoracle) _detailfielddbtype="varchar2(1000)";
							else if(isdb2) _detailfielddbtype="varchar(1000)";
							else _detailfielddbtype="varchar(1000)";
						}else{
							if(isoracle) _detailfielddbtype="varchar2(4000)";
							else if(isdb2) _detailfielddbtype="varchar(2000)";
							else _detailfielddbtype="text";
						}
					}
					
					if(temptype==226||temptype==227){
						detailfielddbtype=Util.null2String(request.getParameter("showvalue_"+i+"_"+temprowindex));
						if(temptype==226){
							if(isoracle) _detailfielddbtype="varchar2(1000)";
							else if(isdb2) _detailfielddbtype="varchar(1000)";
							else _detailfielddbtype="varchar(1000)";
						}else{
							if(isoracle) _detailfielddbtype="varchar2(4000)";
							else if(isdb2) _detailfielddbtype="varchar(2000)";
							else _detailfielddbtype="text";
						}
					}
				  if(temptype==165||temptype==166||temptype==167||temptype==168) 
				  	detailtextheight=Util.getIntValue(Util.null2String(request.getParameter("decentralizationbroswerType_"+i+"_"+temprowindex)),0); 
			  }
			  if(detailfieldhtmltype.equals("4")){
			  	detailtype = "1";
			  	detailfielddbtype="char(1)";
			  }
			  if(detailfieldhtmltype.equals("5"))	{
			  	detailtype = "1";
			  	if(isoracle) detailfielddbtype="integer";
			  	else detailfielddbtype="int";
			  }
			  if(detailfieldhtmltype.equals("6"))	{
			  	detailtype = "1";
			    if(isoracle) detailfielddbtype="varchar2(4000)";
				  else if(isdb2) detailfielddbtype="varchar(2000)";
			    else detailfielddbtype="text";
			  }
  			
			  detaildsporder = Util.null2String(request.getParameter("itemDspOrder_detail"+i+"_"+temprowindex));
			  detaildsporder = ""+Util.getFloatValue(detaildsporder,0);
			  int childfieldid_tmp = Util.getIntValue(request.getParameter("childfieldid_detail"+i+"_"+temprowindex), 0);
			  if(!new_OR_modify.equals("")){//��Ϊ�ձ�ʾ�Ǳ༭�ֶΣ�Ϊ�ձ�ʾ������ֶΡ�
			  	String olddetailfieldname = "";
			  	String olddetailfielddbtype = "";
			  	RecordSetTrans.executeSql("select fieldname,fielddbtype from workflow_billfield where id="+new_OR_modify);
			  	if(RecordSetTrans.next()){
			  	    olddetailfieldname = RecordSetTrans.getString("fieldname");
			  	    olddetailfielddbtype = RecordSetTrans.getString("fielddbtype");
			  	}
			  	RecordSetTrans.executeSql("update workflow_billfield set billid="+formid+",fieldname='"+detailfieldname+"',fieldlabel="+detailfieldlabel+",fielddbtype='"+detailfielddbtype+"',fieldhtmltype="+detailfieldhtmltype+",type="+detailtype+",dsporder="+detaildsporder+",viewtype="+viewtype+",detailtable='"+detailtable+"',textheight="+detailtextheight+",childfieldid="+childfieldid_tmp+" where id="+new_OR_modify);
			  	if(!detailfieldname.equals(olddetailfieldname) || (!detailfielddbtype.equals(olddetailfielddbtype) && !"1".equals(detailfieldhtmltype) && !"".equals(detailtype))){//�޸������ݿ��ֶ����ƻ�����
			  	    RecordSetTrans.executeSql("select "+olddetailfieldname+" from "+detailtable);
			  	    if(!RecordSetTrans.next()){
				  	    RecordSetTrans.executeSql("alter table "+detailtable+" drop column "+olddetailfieldname);
				  	    if(detailfieldhtmltype.equals("3")&&(detailtype.equals("161")||detailtype.equals("162"))){
				  	        RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
				  	    }else if(detailfieldhtmltype.equals("3")&&(detailtype.equals("224")||detailtype.equals("225"))){
				  	        RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
				  	    }else if(detailfieldhtmltype.equals("3")&&(detailtype.equals("226")||detailtype.equals("227"))){
				  	        RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
				  	    }
				  	    else{
				  	        RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+detailfielddbtype);
				  	    }
			  	    }
			  	}
				}else{
			  	//�����ֶ���Ϣ
			  	RecordSetTrans.executeSql("INSERT INTO workflow_billfield(billid,fieldname,fieldlabel,fielddbtype,fieldhtmltype,type,dsporder,viewtype,detailtable,textheight,childfieldid) "+
			  	" VALUES ("+formid+",'"+detailfieldname+"',"+detailfieldlabel+",'"+detailfielddbtype+"',"+detailfieldhtmltype+","+detailtype+","+detaildsporder+","+viewtype+",'"+detailtable+"',"+detailtextheight+","+childfieldid_tmp+")");
			  }
			  if(new_OR_modify.equals("")){//������ֶ�
			  //������ϸ��ṹ
			  if(detailfieldhtmltype.equals("3")&&(detailtype.equals("161")||detailtype.equals("162"))){
			  	  RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
			  }else if(detailfieldhtmltype.equals("3")&&(detailtype.equals("224")||detailtype.equals("225"))){
			  	  RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
			  }else if(detailfieldhtmltype.equals("3")&&(detailtype.equals("226")||detailtype.equals("227"))){
			  	  RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+_detailfielddbtype);
			  }
			  else{
			  	  RecordSetTrans.executeSql("alter table "+detailtable+" add "+detailfieldname+" "+detailfielddbtype);
			  } 
			  }
			  
			  //�����ѡ��򣬸��±�workflow_SelectItem
			  String curfieldid = "";
			  if(new_OR_modify.equals("")){
			      RecordSetTrans.executeSql("select max(id) as id from workflow_billfield");
			      if(RecordSetTrans.next()) curfieldid = RecordSetTrans.getString("id");
			  }else{
			      curfieldid = new_OR_modify;
			  }
			  if(detailfieldhtmltype.equals("5")){
			  	int rowsum = Util.getIntValue(Util.null2String(request.getParameter("choiceRows_"+i+"_"+temprowindex)));
                int curvalue=0;
			  	for(int temprow=1;temprow<=rowsum;temprow++){
			  		String curname = Util.null2String(request.getParameter("field_"+i+"_"+temprowindex+"_"+temprow+"_name"));
			  		if(curname.equals("")) continue;
			  		String curorder = Util.null2String(request.getParameter("field_count_"+i+"_"+temprowindex+"_"+temprow+"_name"));
			  		String isdefault = "n";
			  		String checkValue = Util.null2String(request.getParameter("field_checked_"+i+"_"+temprowindex+"_"+temprow+"_name"));
			  		String cancel = Util.null2String(request.getParameter("cancel_"+i+"_"+temprowindex+"_"+temprow+"_name"));
			  		if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
						cancel = "1";
					}else{
						cancel = "0";
					}
					if(checkValue.equals("1")) isdefault="y";
			  		int isAccordToSubCom_tmp = Util.getIntValue(request.getParameter("isAccordToSubCom"+i+"_"+temprowindex+"_"+temprow), 0);
						String doccatalog = Util.null2String(request.getParameter("maincategory_"+i+"_"+temprowindex+"_"+temprow));
						String docPath = Util.null2String(request.getParameter("pathcategory_"+i+"_"+temprowindex+"_"+temprow));
						String childItem_tmp = Util.null2String(request.getParameter("childItem_"+i+"_"+temprowindex+"_"+temprow));
						String para=curfieldid+flag+"1"+flag+""+curvalue+flag+curname+flag+curorder+flag+isdefault+flag+cancel;
						//System.out.println("para....."+para);
						RecordSetTrans.executeProc("workflow_selectitem_insert_new",para);//���±�workflow_SelectItem
						RecordSetTrans.executeSql("update workflow_SelectItem set docpath='"+docPath+"', docCategory='"+doccatalog+"',childitemid='"+childItem_tmp+"',isAccordToSubCom='"+isAccordToSubCom_tmp+"' where fieldid="+curfieldid+" and selectvalue="+curvalue);
                        curvalue++;
			  	}
			  }
			  
			  if(new_OR_modify.equals("")){//�½��ֶβ��뵽�ڵ�
			  String insertFieldId = curfieldid;
			  RecordSetTrans.execute("select count(nodeid) as wfnfc from workflow_nodeform where fieldid="+insertFieldId);
			  	int wf_nf_count = 0;
			  	if(RecordSetTrans.next()){
			  		wf_nf_count = Util.getIntValue(RecordSetTrans.getString(1), 0);
			  	}
			  	if(wf_nf_count<1){
					ArrayList arrNodeId = new ArrayList();
					RecordSetTrans.executeSql("select nodeid from workflow_flownode where workflowid in (select id from workflow_base where formid="+formid+" and isbill=1)");
					while(RecordSetTrans.next()){
						arrNodeId.add(RecordSetTrans.getString("nodeid"));
					}
					for(int h=0; h < arrNodeId.size(); h++){
						RecordSetTrans.executeSql("insert into workflow_nodeform(nodeid,fieldid,isview,isedit,ismandatory) values("+(String)arrNodeId.get(h)+","+insertFieldId+",'0','0','0')");
					}
			  	}
			  }
	  	}
	  	
	  	//û���ֶ���ɾ����
	  	RecordSetTrans.executeSql("select * from workflow_billfield where billid="+formid+" and detailtable='"+detailtable+"'");
	  	if(!RecordSetTrans.next()){
	  		RecordSetTrans.executeSql("drop table "+detailtable);
	  		RecordSetTrans.executeSql("delete from Workflow_billdetailtable where billid="+formid+" and tablename='"+detailtable+"'");
	  	}
  	}
  	//��ϸ�ֶ� ����
  	
		RecordSetTrans.commit();
		if(isoracle){
				RecordSet.executeSql("select tablename from Workflow_billdetailtable where billid="+formid);
				while(RecordSet.next()){
						String tempdetailtablename = RecordSet.getString("tablename");
						rs1.executeSql("select * from user_triggers where upper(trigger_name)=upper('"+tempdetailtablename+"_Id_Tr')");
						if(!rs1.next()){//��ϸ��id������
								int maxid_tmp = 0;
								rs2.execute("select max(id) from "+tempdetailtablename+"");
								if(rs2.next()){
									maxid_tmp = Util.getIntValue(rs2.getString(1), 0);
								}
								maxid_tmp++;
								try{
									//rs2.executeSql("drop sequence "+tempdetailtablename+"_Id");
									rs2.executeSql("select  1 from user_sequences where upper(sequence_name)=upper('"+tempdetailtablename+"_Id')");
									if(rs2.next()){
										rs2.executeSql("drop sequence "+tempdetailtablename+"_Id");
									}
								}catch(Exception e){}
								rs2.executeSql("create sequence "+tempdetailtablename+"_Id start with "+maxid_tmp+" increment by 1 nomaxvalue nocycle");
								rs2.setChecksql(false);
								rs2.executeSql("CREATE OR REPLACE TRIGGER "+tempdetailtablename+"_Id_Tr before insert on "+tempdetailtablename+" for each row begin select "+tempdetailtablename+"_Id.nextval into :new.id from dual; end;");
						}
				}
		}
		ArrayList labelidsArray = Util.TokenizerString(labelidsCache,",");
		for(int i=0;i<labelidsArray.size();i++){//��ӱ�ǩid������
			LabelComInfo.addLabeInfoCache((String)labelidsArray.get(i));
		}
  		if(issqlserver){//��Ϊ��sql����detailtable��Ĭ��ֵNULL����ʾ�����ʱ����detailtable���򣬵�detailtable�п�ֵ��nullʱ���������
  			RecordSet.executeSql("update workflow_billfield set detailtable = '' where detailtable is null");
  		}
		response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
  }catch(Exception e){
		RecordSetTrans.rollback();
	}
}else if(src.equals("deleteField")){
	RecordSetTrans.setAutoCommit(false);
	try{
		String formid = Util.null2String(request.getParameter("formid"));
		int fieldid = Util.getIntValue(Util.null2String(request.getParameter("fieldid")),0);
		String viewtype = Util.null2String(request.getParameter("viewtype"));
		String tablename = "";
		if(viewtype.equals("0")) tablename = Util.null2String(request.getParameter("maintable"));
		if(viewtype.equals("1")) tablename = Util.null2String(request.getParameter("detailtable"));
		
		//����ֶα����й������ã����˳���
		RecordSetTrans.executeSql("select * from workflow_formdetailinfo where rowcalstr like '%_"+fieldid+"[^0-9]%' or rowcalstr like '%_"+fieldid+"' or colcalstr like '%_"+fieldid+"[^0-9]%' or colcalstr like '%_"+fieldid+"' or maincalstr like '%_"+fieldid+"[^0-9]%' or maincalstr like '%_"+fieldid+"'");
		if(RecordSetTrans.next()){
		    RecordSetTrans.rollback();
		    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodelete");
		    return;
		}

		if(WorkflowSubwfFieldManager.hasSubWfSetting(RecordSetTrans,fieldid,1)){
			RecordSetTrans.rollback();
			response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodeleteForSubWf");
			return;
		}

		String fieldnameForDel="";
		RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+fieldid);
		if(RecordSetTrans.next()) fieldnameForDel = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
		RecordSetTrans.executeSql("alter table "+tablename+" drop column "+fieldnameForDel);//�޸ı�ṹ
		RecordSetTrans.executeSql("delete from workflow_billfield where id="+fieldid);//ɾ���ֶ�
		RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+fieldid);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
		RecordSetTrans.execute("update workflow_billfield set childfieldid=0 where childfieldid="+fieldid);//�����ɾ���ֶ������ֶΣ�����Ҫ�޸�
		
		//ɾ������ֶ���صĳ�������
		if(viewtype.equals("0")){
		Pattern mpattern = null;
		Matcher mmatcher = null;
		String partStr = "\\b"+fieldnameForDel+"\\b";
		mpattern = Pattern.compile(partStr);
		ArrayList nodelinkidList = new ArrayList();
		ArrayList conditionList = new ArrayList();
		
		//RecordSetTrans.execute("select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")");
		//while(RecordSetTrans.next()){
		//		int nlid = Util.getIntValue(RecordSetTrans.getString("id"));
		//		String condition = Util.null2String(RecordSetTrans.getString("condition"));
		//		nodelinkidList.add(""+nlid);
		//		conditionList.add(""+condition);
		//}
		
		//�����ֶκ��µĶ�ȡ��ʽ��ʼ
		 String strSql = "select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")";
		 weaver.conn.ConnStatement statement=new weaver.conn.ConnStatement();
   	 	 weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
		 String docContent = "";
	   	 statement.setStatementSql(strSql, false);
	   	 statement.executeQuery();
 		 if(statement.next()){
		  	 if(statement.getDBType().equals("oracle"))
		  	 {
		  			oracle.sql.CLOB theclob = statement.getClob("condition"); 
			  		String readline = "";
			        StringBuffer clobStrBuff = new StringBuffer("");
			        java.io.BufferedReader clobin = new java.io.BufferedReader(theclob.getCharacterStream());
			        while ((readline = clobin.readLine()) != null) clobStrBuff = clobStrBuff.append(readline);
			        clobin.close() ;
			        docContent = clobStrBuff.toString();
		  	  }else{
				  		docContent=statement.getString("condition");
		  }
	  	 
	  	 int nlid = Util.getIntValue(statement.getString("id"));
	  	 nodelinkidList.add(""+nlid);
		 conditionList.add(""+docContent);
 		}
	  	 //�����ֶκ��µĶ�ȡ��ʽ����
		
		for(int cx=0; cx<nodelinkidList.size(); cx++){
				String nlid = Util.null2String((String)nodelinkidList.get(cx));
				String condition = Util.null2String((String)conditionList.get(cx));
				mmatcher = mpattern.matcher(condition);
				boolean find = mmatcher.find();
				if(find==true){
						//RecordSetTrans.execute("update workflow_nodelink set condition='' , conditioncn='' where id="+nlid);
						String sql = "update workflow_nodelink set condition='' , conditioncn='' where id="+nlid;
				        if(statement.getDBType().equals("oracle"))
				            sql = "update workflow_nodelink set condition=empty_clob() , conditioncn=empty_clob() where id="+nlid;
		                statement.setStatementSql(sql);
		                statement.executeUpdate();
				}
		}
		}
		//ɾ������ֶ���صĳ�������

		//ɾ���ڵ㸽�Ӳ���
		RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + fieldid + " or fieldop1id = " + fieldid + " or fieldop2id = " + fieldid + ")" );
		//ɾ�����ڸ��Ӳ���
		RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + fieldid + " or fieldop1id = " + fieldid + " or fieldop2id = " + fieldid + ")");
		//ɾ�����Զ����ֶβ����Ĳ����ˣ���Ҫ��������������
		RecordSetTrans.executeSql("delete from  workflow_groupdetail where type in(5,6,31,32,7,38,42,43,8,33,9,10,47,34,11,12,13,35,14,15,44,45,46,16) and groupid in(select id from workflow_nodegroup where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ")) and objid=" + fieldid);
		//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
		RecordSetTrans.executeSql("delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and fieldid= " + fieldid);
		//ɾ�������ֶε���Ϣ
		RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid =" + fieldid);

		
		//���ɾ��������ϸ�����һ���ֶΣ��򽫸ñ�ͬʱɾ��
		if(viewtype.equals("1")){
		  RecordSetTrans.executeSql("select * from workflow_billfield where billid="+formid+" and detailtable='"+tablename+"'");
		  if(!RecordSetTrans.next()){
		  	RecordSetTrans.executeSql("drop table "+tablename);
		  	RecordSetTrans.executeSql("delete from Workflow_billdetailtable where billid="+formid+" and tablename='"+tablename+"'");
		  }
	  }
		
		RecordSetTrans.commit();
		response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
	}catch(Exception e){
		RecordSetTrans.rollback();
	}
}else if(src.equals("editField")){
	char flag=2;
	String hasChanged = Util.null2String(request.getParameter("hasChanged"));
	String canChange = Util.null2String(request.getParameter("canChange"));
    int imgwidth = Util.getIntValue(request.getParameter("imgwidth"),0);
    int imgheight = Util.getIntValue(request.getParameter("imgheight"),0);
	String formid = Util.null2String(request.getParameter("formid"));
	if(hasChanged.equals("true")){
		RecordSetTrans.setAutoCommit(false);
		try{
			int fieldid = Util.getIntValue(Util.null2String(request.getParameter("fieldid")),0);
			String viewtype = "0";
			String tablename = Util.null2String(request.getParameter("updateTableName"));
			String detailtable = "";
			if(tablename.indexOf("_dt")>0){
			    viewtype = "1";
			    detailtable = tablename;
			}
			
			String fieldname = Util.null2String(request.getParameter("fieldname"));
			String fieldlabelname = Util.null2String(request.getParameter("fieldlabelname"));
			fieldlabelname = Util.StringReplace(fieldlabelname, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
			fieldlabelname = Util.StringReplace(fieldlabelname, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
			int lableid = 0;
			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
			else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  if(RecordSetTrans.next()) lableid = RecordSetTrans.getInt("indexid");//����ֶ������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		 	else{
				lableid = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			 	if(lableid!=-1){//���±�ǩ��
			  	RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+lableid);
			 		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+lableid);
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+lableid+",'"+fieldlabelname+"')");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',7)");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',8)");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',9)");
			 	}
			}
			
			String fieldHtmlType = Util.null2String(request.getParameter("FieldHtmlType"));
			String documentType = Util.null2String(request.getParameter("DocumentType"));
			String textheight = Util.null2String(request.getParameter("textheight"));
			String fielddbtype = Util.null2String(request.getParameter("fielddbtype"));
			String _fielddbtype = "";//�ֶ����ݿ�����
			String dsporder = Util.null2String(request.getParameter("itemDspOrder"));
			dsporder = ""+Util.getFloatValue(dsporder,0);
			int childfieldid = Util.getIntValue(request.getParameter("childfieldid"), 0);
			//if(dsporder.equals("")) dsporder = "0";
			
			if(fieldHtmlType.equals("1")&&documentType.equals("1")){//�����ı��򡪡��ı��������������ݿ�����
				String oldfielddbtype = "";
				RecordSetTrans.executeSql("select fielddbtype from workflow_billfield where id="+fieldid);
				if(RecordSetTrans.next()) oldfielddbtype = RecordSetTrans.getString("fielddbtype");
				
				String strlength = Util.null2String(request.getParameter("itemFieldScale1"));
				if(Util.getIntValue(strlength,1)<=1) strlength = "1";
				if(isoracle) fielddbtype="varchar2("+strlength+")";
				else fielddbtype="varchar("+strlength+")";
				
				if(!fielddbtype.equals(oldfielddbtype)){
				    if(isoracle) RecordSetTrans.executeSql("ALTER TABLE "+tablename+" MODIFY "+fieldname+" "+fielddbtype);
				    else RecordSetTrans.executeSql("ALTER TABLE "+tablename+" ALTER COLUMN "+fieldname+" "+fielddbtype);
				}
			} 
			if(canChange.equals("true")){
			    String type = Util.null2String(request.getParameter("DocumentType"));
			    int decimaldigits = Util.getIntValue(request.getParameter("decimaldigits"),2);
			    if(fieldHtmlType.equals("1")){
			        if(type.equals("1")){
			            String strlength = Util.null2String(request.getParameter("itemFieldScale1"));
			            if(Util.getIntValue(strlength,1)<=1) strlength = "1";
			            if(isoracle) fielddbtype="varchar2("+strlength+")";
			            else fielddbtype="varchar("+strlength+")";
			        }
			        if(type.equals("2")){
			            if(isoracle) fielddbtype="integer";
			            else fielddbtype="int";
			        }
			        if(type.equals("3")){
			            if(isoracle) fielddbtype="number(15,"+decimaldigits+")";
			            else fielddbtype="decimal(15,"+decimaldigits+")";
			        }
			        if(type.equals("4")){
			            if(isoracle) fielddbtype="number(15,2)";
			            else fielddbtype="decimal(15,2)";
			        }
			        if(type.equals("5")){
			            if(isoracle) fielddbtype="varchar2(30)";
			            else fielddbtype="varchar(30)";
			        }
			    }
			    if(fieldHtmlType.equals("2")){
			        String htmledit = Util.null2String(request.getParameter("htmledit"));
			        if(htmledit.equals("")) documentType="1";
			        else documentType=htmledit;
			        if(isoracle) fielddbtype="varchar2(4000)";
			        else if(isdb2) fielddbtype="varchar(2000)";
			        else fielddbtype="text";
			        textheight = ""+Util.getIntValue(Util.null2String(request.getParameter("textheight")),4);
			    }
			    if(fieldHtmlType.equals("3")){
			        int temptype = Util.getIntValue(Util.null2String(request.getParameter("browsertype")),0);
			        documentType = ""+temptype;
			        if(temptype>0)
			            fielddbtype=BrowserComInfo.getBrowserdbtype(type+"");
			        if(temptype==118){
				  		if(isoracle) fielddbtype="varchar2(200)";
			              else fielddbtype="varchar(200)";
				  	}
			        if(temptype==161||temptype==162){
			            fielddbtype=Util.null2String(request.getParameter("definebroswerType"));
			            if(temptype==161){
			                if(isoracle) _fielddbtype="varchar2(1000)";
			                else if(isdb2) _fielddbtype="varchar(1000)";
			                else _fielddbtype="varchar(1000)";
			            }else{
			                if(isoracle) _fielddbtype="varchar2(4000)";
			                else if(isdb2) _fielddbtype="varchar(2000)";
			                else _fielddbtype="text";
			            }
			        }
			        if(temptype==224||temptype==225){
			            fielddbtype=Util.null2String(request.getParameter("sapbrowser"));
			            if(temptype==224){
			                if(isoracle) _fielddbtype="varchar2(1000)";
			                else if(isdb2) _fielddbtype="varchar(1000)";
			                else _fielddbtype="varchar(1000)";
			            }else{
			                if(isoracle) _fielddbtype="varchar2(4000)";
			                else if(isdb2) _fielddbtype="varchar(2000)";
			                else _fielddbtype="text";
			            }
			        }
			        
			        	//zzl-start
				  	if(temptype==226||temptype==227){
						fielddbtype=Util.null2String(request.getParameter("showvalue"));
				  		if(temptype==226){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
				  	}
				  	//zzl-end
				  	
			        if(temptype==165||temptype==166||temptype==167||temptype==168) 
			            textheight=""+Util.getIntValue(Util.null2String(request.getParameter("decentralizationbroswerType")),0); 
			    }
			    if(fieldHtmlType.equals("4")){
			        documentType = "1";
			        fielddbtype="char(1)";
			    }
			    if(fieldHtmlType.equals("5"))	{
			        documentType = "1";
			        if(isoracle) fielddbtype="integer";
			        else fielddbtype="int";
			    }
			    if(fieldHtmlType.equals("6"))	{
			        if(isoracle) fielddbtype="varchar2(4000)";
			        else if(isdb2) fielddbtype="varchar(2000)";
			        else fielddbtype="text";
			    }
			    if(fieldHtmlType.equals("7"))	{
			        documentType = Util.null2String(request.getParameter("specialfield"));//����
			        if(isoracle) fielddbtype="varchar2(4000)";
			        else if(isdb2) fielddbtype="varchar(2000)";
			        else fielddbtype="text";
			    }
			}
            if (fieldHtmlType.equals("6")) {
                documentType = "" + Util.getIntValue(Util.null2String(request.getParameter("uploadtype")), 1);
                textheight = "" + Util.getIntValue(Util.null2String(request.getParameter("strlength")), 0);
            }

			if(canChange.equals("true")){
			    //��ɾ���ֶ������Ϣ�ٲ���  
			    String fieldnameForDel="";
			    RecordSetTrans.executeSql("select fieldname from workflow_billfield where id="+fieldid);
			    if(RecordSetTrans.next()) fieldnameForDel = RecordSetTrans.getString("fieldname");//ȡ���ֶ���
			    String oldtablename = Util.null2String(request.getParameter("oldtablename"));
			    if(!fieldname.equals(fieldnameForDel)||!oldtablename.equals(tablename)){//TD10207 chujun
			        RecordSetTrans.executeSql("alter table "+oldtablename+" drop column "+fieldnameForDel);//�޸ı�ṹ
			        int temptype = Util.getIntValue(Util.null2String(request.getParameter("browsertype")),0);
			        if(!"".equals(_fielddbtype)){
			        	RecordSetTrans.executeSql("alter table "+tablename+" add "+fieldname+" "+_fielddbtype);//���±�ṹ
			        }else{
			        	RecordSetTrans.executeSql("alter table "+tablename+" add "+fieldname+" "+fielddbtype);//���±�ṹ
			        }
			    }
			    RecordSetTrans.executeSql("delete from workflow_billfield where id="+fieldid);//ɾ���ֶ�
			
			    //RecordSetTrans.executeSql("delete from workflow_SelectItem where fieldid="+fieldid);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����

			    //�����ֶ���Ϣ
			    RecordSetTrans.executeSql("INSERT INTO workflow_billfield(billid,fieldname,fieldlabel,fielddbtype,fieldhtmltype,type,dsporder,viewtype,detailtable,textheight,imgwidth,imgheight) "+
			    " VALUES ("+formid+",'"+fieldname+"',"+lableid+",'"+fielddbtype+"',"+fieldHtmlType+","+documentType+","+dsporder+","+viewtype+",'"+detailtable+"',"+textheight+","+imgwidth+","+imgheight+")");
			}else{
                RecordSetTrans.executeSql("update workflow_billfield set billid="+formid+",fieldname='"+fieldname+"',fieldlabel="+lableid+",fielddbtype='"+fielddbtype+"',fieldhtmltype="+fieldHtmlType+",type="+documentType+",dsporder="+dsporder+",viewtype="+viewtype+",detailtable='"+detailtable+"',textheight="+textheight+",childfieldid="+childfieldid+",imgwidth="+imgwidth+",imgheight="+imgheight+" where id="+fieldid);
			}
			
			String curfieldid = "";
			if(canChange.equals("true")){
			    RecordSetTrans.executeSql("select max(id) as id from workflow_billfield where billid="+formid);
			    if(RecordSetTrans.next()) curfieldid = RecordSetTrans.getString("id");
			    RecordSetTrans.executeSql("update  Workflow_SelectitemObj set fieldid="+curfieldid+" where fieldid="+fieldid+" and isbill=1");
			}else{
			    curfieldid = ""+fieldid;
			}  
			fieldid = Util.getIntValue(curfieldid,0);		
			//�����ѡ��򣬸��±�workflow_SelectItem
			if(fieldHtmlType.equals("5")){
			  RecordSetTrans.executeSql("update workflow_billfield set childfieldid="+childfieldid +" where id="+curfieldid);
			  RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+fieldid);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����
			  int rowsum = Util.getIntValue(Util.null2String(request.getParameter("choiceRows_rows")));
              int curvalue=0;
			  for(int temprow=1;temprow<=rowsum;temprow++){
			  	String curname = Util.null2String(request.getParameter("field_name_"+temprow));
			  	if(curname.equals("")) continue;
			  	String curorder = Util.null2String(request.getParameter("field_count_name_"+temprow));
			  	String isdefault = "n";
			  	String checkValue = Util.null2String(request.getParameter("field_checked_name_"+temprow));
			  	String cancel = Util.null2String(request.getParameter("cancel_"+temprow+"_name")); 
			  	if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
						cancel = "1";
					}else{
						cancel = "0";
					}
			  	if(checkValue.equals("1")) isdefault="y";
			  	int isAccordToSubCom_tmp = Util.getIntValue(request.getParameter("isAccordToSubCom"+temprow), 0);
					String doccatalog = Util.null2String(request.getParameter("maincategory_"+temprow));
					String docPath = Util.null2String(request.getParameter("pathcategory_"+temprow));
					String childItem = Util.null2String(request.getParameter("childItem"+temprow));
					String para=curfieldid+flag+"1"+flag+""+curvalue+flag+curname+flag+curorder+flag+isdefault+flag+cancel;
					//System.out.println("para....."+para);
					RecordSetTrans.executeProc("workflow_selectitem_insert_new",para);//���±�workflow_SelectItem
					RecordSetTrans.executeSql("update workflow_SelectItem set docpath='"+docPath+"', docCategory='"+doccatalog+"',childitemid='"+childItem+"',isAccordToSubCom='"+isAccordToSubCom_tmp+"' where fieldid="+curfieldid+" and selectvalue="+curvalue);
                    curvalue++;
				}
			}

	        if(fieldHtmlType.equals("7")){
               String displayname = Util.null2String(request.getParameter("displayname"));//��ʾ��
               String linkaddress = Util.null2String(request.getParameter("linkaddress"));//���ӵ�ַ
               String descriptivetext = Util.null2String(request.getParameter("descriptivetext"));//����������
               descriptivetext = Util.spacetoHtml(descriptivetext);	
	  	       String specialfield = Util.null2String(request.getParameter("specialfield"));//����
               String sql = "delete from workflow_specialfield where isbill = 1 and fieldid = " + fieldid;
	           RecordSetTrans.executeSql(sql);
	           if(specialfield.equals("1")){
	              sql = "insert into workflow_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+fieldid+",'"+displayname+"','"+linkaddress+"',0,1)";    
	           }else{
	              sql = "insert into workflow_specialfield(fieldid,descriptivetext,isform,isbill) values("+fieldid+",'"+descriptivetext+"',0,1)";    
	           }
		       RecordSetTrans.executeSql(sql);	
	        }

			RecordSetTrans.commit();
			LabelComInfo.addLabeInfoCache(""+lableid);
	  		if(issqlserver){//��Ϊ��sql����detailtable��Ĭ��ֵNULL����ʾ�����ʱ����detailtable���򣬵�detailtable�п�ֵ��nullʱ���������
	  			RecordSet.executeSql("update workflow_billfield set detailtable = '' where detailtable is null");
	  		}
			response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
		}catch(Exception e){
			RecordSetTrans.rollback();
		}
	}else{
		response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
	}
}else if(src.equals("addFieldSingle")){
	char flag=2;
	
	RecordSetTrans.setAutoCommit(false);
	try{
			String formid = Util.null2String(request.getParameter("formid"));
			String updateTableName = Util.null2String(request.getParameter("updateTableName"));//��Ҫ���µı�
	
			String fieldname = Util.null2String(request.getParameter("fieldname"));
			String fieldlabelname = Util.null2String(request.getParameter("fieldlabelname"));
			fieldlabelname = Util.StringReplace(fieldlabelname, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
			fieldlabelname = Util.StringReplace(fieldlabelname, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
			int lableid = 0;
			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
			else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
		  if(RecordSetTrans.next()) lableid = RecordSetTrans.getInt("indexid");//����ֶ������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid
		 	else{
				lableid = FormManager.getNewIndexId(RecordSetTrans);//�����µı�ǩid
			 	if(lableid!=-1){//���±�ǩ��
			  	RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+lableid);
			 		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+lableid);
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+lableid+",'"+fieldlabelname+"')");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',7)");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',8)");
			 		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldlabelname+"',9)");
			 	}
			}
			
			String fieldHtmlType = Util.null2String(request.getParameter("FieldHtmlType"));
			String type = "";
			String fielddbtype = "";
			String _fielddbtype = "";
			String dsporder = Util.null2String(request.getParameter("itemDspOrder"));
			dsporder = ""+Util.getFloatValue(dsporder,0);
			int childfieldid = Util.getIntValue(request.getParameter("childfieldid"),0);
			//if(dsporder.equals("")) dsporder="0";
			String viewtype = "0";
			String detailtable = "";
			RecordSetTrans.executeSql("select * from Workflow_billdetailtable where billid="+formid+" and tablename='"+updateTableName+"'");
			if(RecordSetTrans.next()){
				viewtype = "1";
				detailtable = updateTableName;
			}
			int textheight = 0;
            int imgwidth = Util.getIntValue(request.getParameter("imgwidth"),0);
            int imgheight = Util.getIntValue(request.getParameter("imgheight"),0);

			if(fieldHtmlType.equals("1")){
				int decimaldigits = Util.getIntValue(request.getParameter("decimaldigits"),2);
			  	type = Util.null2String(request.getParameter("DocumentType"));	
				  if(type.equals("1")){
				  	String strlength = Util.null2String(request.getParameter("itemFieldScale1"));
				  	if(Util.getIntValue(strlength,1)<=1) strlength = "1";
			    	if(isoracle) fielddbtype="varchar2("+strlength+")";
			    	else fielddbtype="varchar("+strlength+")";
			   	}
				 	if(type.equals("2")){
			   		if(isoracle) fielddbtype="integer";
			   		else fielddbtype="int";
			   	}
				 	if(type.equals("3")){
			   		if(isoracle) fielddbtype="number(15,"+decimaldigits+")";
			   		else fielddbtype="decimal(15,"+decimaldigits+")";
			 	 	}
			   	if(type.equals("4")){
			   		if(isoracle) fielddbtype="number(15,2)";
			   		else fielddbtype="decimal(15,2)";
					}
					if(type.equals("5")){
              if(isoracle) fielddbtype="varchar2(30)";
              else fielddbtype="varchar(30)";
          }
			  }
			  if(fieldHtmlType.equals("2")){
			  	String htmledit = Util.null2String(request.getParameter("htmledit"));
			  	if(htmledit.equals("")) type="1";
			  	else type=htmledit;
					if(isoracle) fielddbtype="varchar2(4000)";
					else if(isdb2) fielddbtype="varchar(2000)";
					else fielddbtype="text";
					textheight = Util.getIntValue(Util.null2String(request.getParameter("textheight")),4);
			  }
			  if(fieldHtmlType.equals("3")){
			  	int temptype = Util.getIntValue(Util.null2String(request.getParameter("browsertype")),0);
			  	type = ""+temptype;
			  	if(temptype>0)
			  		fielddbtype=BrowserComInfo.getBrowserdbtype(type+"");
			  	if(temptype==118){
			  		if(isoracle) fielddbtype="varchar2(200)";
		              else fielddbtype="varchar(200)";
			  	}
					if(temptype==161||temptype==162){
						fielddbtype=Util.null2String(request.getParameter("definebroswerType"));
				  		if(temptype==161){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
				  	}
					if(temptype==224||temptype==225){
						fielddbtype=Util.null2String(request.getParameter("sapbrowser"));
				  		if(temptype==224){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
				  	}
				  	//zzl-start
				  	if(temptype==226||temptype==227){
						fielddbtype=Util.null2String(request.getParameter("showvalue"));
				  		if(temptype==226){
							if(isoracle) _fielddbtype="varchar2(1000)";
							else if(isdb2) _fielddbtype="varchar(1000)";
							else _fielddbtype="varchar(1000)";
						}else{
							if(isoracle) _fielddbtype="varchar2(4000)";
							else if(isdb2) _fielddbtype="varchar(2000)";
							else _fielddbtype="text";
						}
				  	}
				  	//zzl-end
				  	
				  if(temptype==165||temptype==166||temptype==167||temptype==168) 
				  	textheight=Util.getIntValue(Util.null2String(request.getParameter("decentralizationbroswerType")),0); 
			  }
			  if(fieldHtmlType.equals("4")){
			  	type = "1";
			  	fielddbtype="char(1)";
			  }
			  if(fieldHtmlType.equals("5"))	{
			  	type = "1";
			  	if(isoracle) fielddbtype="integer";
			  	else fielddbtype="int";
			  }
			  if(fieldHtmlType.equals("6"))	{
			  	type = ""+Util.getIntValue(Util.null2String(request.getParameter("uploadtype")),1);
			    if(isoracle) fielddbtype="varchar2(4000)";
				  else if(isdb2) fielddbtype="varchar(2000)";
			    else fielddbtype="text";
                  textheight=Util.getIntValue(Util.null2String(request.getParameter("strlength")),0);
			  }
			  if(fieldHtmlType.equals("7"))	{
			  	type = Util.null2String(request.getParameter("specialfield"));//����
			    if(isoracle) fielddbtype="varchar2(4000)";
				  else if(isdb2) fielddbtype="varchar(2000)";
			    else fielddbtype="text";
			  }
			
			//�����ֶ���Ϣ
			RecordSetTrans.executeSql("INSERT INTO workflow_billfield(billid,fieldname,fieldlabel,fielddbtype,fieldhtmltype,type,dsporder,viewtype,detailtable,textheight,childfieldid,imgwidth,imgheight) "+
			" VALUES ("+formid+",'"+fieldname+"',"+lableid+",'"+fielddbtype+"',"+fieldHtmlType+","+type+","+dsporder+","+viewtype+",'"+detailtable+"',"+textheight+","+childfieldid+","+imgwidth+","+imgheight+")");
			  
			//������ϸ��ṹ
			if(fieldHtmlType.equals("3")&&(type.equals("161")||type.equals("162"))){
				RecordSetTrans.executeSql("alter table "+updateTableName+" add "+fieldname+" "+_fielddbtype);
			}else if(fieldHtmlType.equals("3")&&(type.equals("224")||type.equals("225"))){
				RecordSetTrans.executeSql("alter table "+updateTableName+" add "+fieldname+" "+_fielddbtype);
			}else if(fieldHtmlType.equals("3")&&(type.equals("226")||type.equals("227"))){
				RecordSetTrans.executeSql("alter table "+updateTableName+" add "+fieldname+" "+_fielddbtype);
			}
			else{
				RecordSetTrans.executeSql("alter table "+updateTableName+" add "+fieldname+" "+fielddbtype);
			}
			String curfieldid = "";
			RecordSetTrans.executeSql("select max(id) as id from workflow_billfield");
			if(RecordSetTrans.next()) curfieldid = RecordSetTrans.getString("id");
			//�����ѡ��򣬸��±�workflow_SelectItem
			if(fieldHtmlType.equals("5")){
				
			  int rowsum = Util.getIntValue(Util.null2String(request.getParameter("choiceRows_rows")));
              int curvalue=0;
			  for(int temprow=1;temprow<=rowsum;temprow++){
			  	String curname = Util.null2String(request.getParameter("field_name_"+temprow));
			  	if(curname.equals("")) continue;
			  	String curorder = Util.null2String(request.getParameter("field_count_name_"+temprow));
			  	String isdefault = "n";
			  	String checkValue = Util.null2String(request.getParameter("field_checked_name_"+temprow));
				String childItem = Util.null2String(request.getParameter("childItem"+temprow));
			  	if(checkValue.equals("1")) isdefault="y";
			  	int isAccordToSubCom_tmp = Util.getIntValue(request.getParameter("isAccordToSubCom"+temprow), 0);
					String doccatalog = Util.null2String(request.getParameter("maincategory_"+temprow));
					String docPath = Util.null2String(request.getParameter("pathcategory_"+temprow));

					String para=curfieldid+flag+"1"+flag+""+curvalue+flag+curname+flag+curorder+flag+isdefault;
					//System.out.println("para....."+para);
					RecordSetTrans.executeProc("workflow_SelectItem_Insert",para);//���±�workflow_SelectItem
					RecordSetTrans.executeSql("update workflow_SelectItem set docpath='"+docPath+"', docCategory='"+doccatalog+"', childitemid='"+childItem+"',isAccordToSubCom='"+isAccordToSubCom_tmp+"' where fieldid="+curfieldid+" and selectvalue="+curvalue);
                    curvalue++;
				}
			}
		
	        if(fieldHtmlType.equals("7")){
               String displayname = Util.null2String(request.getParameter("displayname"));//��ʾ��
               String linkaddress = Util.null2String(request.getParameter("linkaddress"));//���ӵ�ַ
               String descriptivetext = Util.null2String(request.getParameter("descriptivetext"));//����������
               descriptivetext = Util.spacetoHtml(descriptivetext);	
	  	       String specialfield = Util.null2String(request.getParameter("specialfield"));//����
	  	       String sql = "";
	           if(specialfield.equals("1")){
	              sql = "insert into workflow_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+curfieldid+",'"+displayname+"','"+linkaddress+"',0,1)";    
	           }else{
	              sql = "insert into workflow_specialfield(fieldid,descriptivetext,isform,isbill) values("+curfieldid+",'"+descriptivetext+"',0,1)";    
	           }
		       RecordSetTrans.executeSql(sql);	
	        }
	    
	    
	        String insertFieldId = curfieldid;
		  	RecordSetTrans.execute("select count(nodeid) as wfnfc from workflow_nodeform where fieldid="+insertFieldId);
		  	int wf_nf_count = 0;
		  	if(RecordSetTrans.next()){
		  		wf_nf_count = Util.getIntValue(RecordSetTrans.getString(1), 0);
		  	}
		  	if(wf_nf_count<1){
				ArrayList arrNodeId = new ArrayList();
				RecordSetTrans.executeSql("select nodeid from workflow_flownode where workflowid in (select id from workflow_base where formid="+formid+" and isbill=1)");
				while(RecordSetTrans.next()){
					arrNodeId.add(RecordSetTrans.getString("nodeid"));
				}
				for(int h=0; h < arrNodeId.size(); h++){
					RecordSetTrans.executeSql("insert into workflow_nodeform(nodeid,fieldid,isview,isedit,ismandatory) values("+(String)arrNodeId.get(h)+","+insertFieldId+",'0','0','0')");
				}    
		  	}
			RecordSetTrans.commit();
	  		if(issqlserver){//��Ϊ��sql����detailtable��Ĭ��ֵNULL����ʾ�����ʱ����detailtable���򣬵�detailtable�п�ֵ��nullʱ���������
	  			RecordSet.executeSql("update workflow_billfield set detailtable = '' where detailtable is null");
	  		}
			LabelComInfo.addLabeInfoCache(""+lableid);
			response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
		}catch(Exception e){
			RecordSetTrans.rollback();
		}
}else if(src.equals("listDelete")){
	
	try{
		RecordSetTrans.setAutoCommit(false);
		
		String deleteids = Util.null2String(request.getParameter("deleteids"));
		int formid = Util.getIntValue(Util.null2String(request.getParameter("formid")),0);
		ArrayList deleteidsArray = Util.TokenizerString(deleteids,",");
		for(int i=0;i<deleteidsArray.size();i++){
			String fieldid = (String)deleteidsArray.get(i);
			String tablename = "";
			String viewtype = "";
			
			String fieldnameForDel="";
			RecordSetTrans.executeSql("select * from workflow_billfield where id="+fieldid);
			if(RecordSetTrans.next()){
				fieldnameForDel = RecordSetTrans.getString("fieldname");//ȡ��ɾ���ֶε��ֶ���
				viewtype = RecordSetTrans.getString("viewtype");//ȡ��ɾ���ֶε��ֶ�����
				if(viewtype.equals("1")){
					tablename = RecordSetTrans.getString("detailtable");//ȡ����ϸ�ֶ����ڱ���
				}else if(viewtype.equals("0")){
					RecordSetTrans.executeSql("select tablename from workflow_bill where id="+formid);
					if(RecordSetTrans.next()){
						tablename = RecordSetTrans.getString("tablename");//ȡ�����ֶ����ڱ���
					}
				}
			}

			//����ֶα����й������ã����˳���
			RecordSetTrans.executeSql("select * from workflow_formdetailinfo where rowcalstr like '%_"+fieldid+"[^0-9]%' or rowcalstr like '%_"+fieldid+"' or colcalstr like '%_"+fieldid+"[^0-9]%' or colcalstr like '%_"+fieldid+"' or maincalstr like '%_"+fieldid+"[^0-9]%' or maincalstr like '%_"+fieldid+"'");
			if(RecordSetTrans.next()){
			    RecordSetTrans.rollback();
			    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodelete");
			    return;
			}			

            if(WorkflowSubwfFieldManager.hasSubWfSetting(RecordSetTrans,Util.getIntValue(fieldid,0),1)){
			    RecordSetTrans.rollback();
			    response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0&message=nodeleteForSubWf");
			    return;
			}

			RecordSetTrans.executeSql("alter table "+tablename+" drop column "+fieldnameForDel);//�޸ı�ṹ
			RecordSetTrans.executeSql("delete from workflow_billfield where id="+fieldid);//ɾ���ֶ�
			RecordSetTrans.executeSql("delete from workflow_SelectItem where isbill=1 and fieldid="+fieldid);//ɾ����workflow_SelectItem�и��ֶζ�Ӧ����

	    //ɾ������ֶ���صĳ�������
	    if(viewtype.equals("0")){
			Pattern mpattern = null;
			Matcher mmatcher = null;
			String partStr = "\\b"+fieldnameForDel+"\\b";
			mpattern = Pattern.compile(partStr);
			ArrayList nodelinkidList = new ArrayList();
			ArrayList conditionList = new ArrayList();
			/*
			RecordSetTrans.execute("select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")");
			while(RecordSetTrans.next()){
			    int nlid = Util.getIntValue(RecordSetTrans.getString("id"));
			    String condition = Util.null2String(RecordSetTrans.getString("condition"));
			    nodelinkidList.add(""+nlid);
			    conditionList.add(""+condition);
			}
			*/
			
			//�����ֶκ��µĶ�ȡ��ʽ��ʼ
			 String strSql = "select * from workflow_nodelink where condition like '%"+fieldnameForDel+"%' and workflowid in (select id from workflow_base where formid="+formid+")";
			 weaver.conn.ConnStatement statement=new weaver.conn.ConnStatement();
	    	 weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			 String docContent = "";
	    	 statement.setStatementSql(strSql, false);
	    	 statement.executeQuery();
	  		if(statement.next()){
			  	 if(statement.getDBType().equals("oracle"))
			  	 {
			  			oracle.sql.CLOB theclob = statement.getClob("condition"); 
				  		String readline = "";
				        StringBuffer clobStrBuff = new StringBuffer("");
				        java.io.BufferedReader clobin = new java.io.BufferedReader(theclob.getCharacterStream());
				        while ((readline = clobin.readLine()) != null) clobStrBuff = clobStrBuff.append(readline);
				        clobin.close() ;
				        docContent = clobStrBuff.toString();
			  	  }else{
					  		docContent=statement.getString("condition");
			  }
		  	 
		  	 int nlid = Util.getIntValue(statement.getString("id"));
		  	 nodelinkidList.add(""+nlid);
		     conditionList.add(""+docContent);
	  		}
		  	 //�����ֶκ��µĶ�ȡ��ʽ����
			
			for(int cx=0; cx<nodelinkidList.size(); cx++){
			    String nlid = Util.null2String((String)nodelinkidList.get(cx));
			    String condition = Util.null2String((String)conditionList.get(cx));
			    mmatcher = mpattern.matcher(condition);
			    boolean find = mmatcher.find();
			    if(find==true){
			        RecordSetTrans.execute("update workflow_nodelink set condition='' , conditioncn='' where id="+nlid);
			        String sql = "update workflow_nodelink set condition='' , conditioncn='' where id="+nlid;
			        if(statement.getDBType().equals("oracle"))
			            sql = "update workflow_nodelink set condition=empty_clob() , conditioncn=empty_clob() where id="+nlid;
	                statement.setStatementSql(sql);
	                statement.executeUpdate();
			    }
			}
			}
			//ɾ������ֶ���صĳ�������
		
			//ɾ���ڵ㸽�Ӳ���
			RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=1 and objid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + fieldid + " or fieldop1id = " + fieldid + " or fieldop2id = " + fieldid + ")" );
			//ɾ�����ڸ��Ӳ���
			RecordSetTrans.executeSql("delete from  workflow_addinoperate where isnode=0 and objid in (select t1.id from  workflow_nodelink t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and (fieldid =" + fieldid + " or fieldop1id = " + fieldid + " or fieldop2id = " + fieldid + ")");
			//ɾ�����Զ����ֶβ����Ĳ����ˣ���Ҫ��������������
			RecordSetTrans.executeSql("delete from  workflow_groupdetail where type in(5,6,31,32,7,38,42,43,8,33,9,10,47,34,11,12,13,35,14,15,44,45,46,16) and groupid in(select id from workflow_nodegroup where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ")) and objid=" + fieldid);
			//ɾ���ڵ�����Щ�ֶο��ӡ��ɱ༭���������Ϣ
			RecordSetTrans.executeSql("delete from  workflow_nodeform where nodeid in (select t1.nodeid from  workflow_flownode t1, workflow_base t2 where t1.workflowid=t2.id and t2.isbill='1' and t2.formid=" + formid + ") and fieldid= " + fieldid);
			//ɾ�������ֶε���Ϣ
			RecordSetTrans.executeSql("delete from workflow_specialfield where isbill=1 and fieldid =" + fieldid);
			RecordSetTrans.execute("update workflow_billfield set childfieldid=0 where childfieldid="+fieldid);//�����ɾ���ֶ������ֶΣ�����Ҫ�޸�

						
			//���ɾ��������ϸ�����һ���ֶΣ��򽫸ñ�ͬʱɾ��
			if(viewtype.equals("1")){
			  RecordSetTrans.executeSql("select * from workflow_billfield where billid="+formid+" and detailtable='"+tablename+"'");
			  if(!RecordSetTrans.next()){
			  	RecordSetTrans.executeSql("drop table "+tablename);
			  	RecordSetTrans.executeSql("delete from Workflow_billdetailtable where billid="+formid+" and tablename='"+tablename+"'");
			  }
		  }	
		}
		RecordSetTrans.commit();
		response.sendRedirect("/workflow/form/editformfield.jsp?formid="+formid+"&ajax=0");
	}catch(Exception e){
		RecordSetTrans.rollback();
	}
	
}else if(src.equals("editfieldlabel")){
	String formid = Util.null2String(request.getParameter("formid"));
	String changefieldids = Util.null2String(request.getParameter("changefieldids"));
	RecordSetTrans.setAutoCommit(false);
	try{
		ArrayList changefieldidsArray = Util.TokenizerString(changefieldids,",");
		for(int i=0;i<changefieldidsArray.size();i++){
			String fieldid = (String)changefieldidsArray.get(i);
			String fieldnameCN = Util.null2String(request.getParameter("field_"+fieldid+"_CN"));
			String fieldnameEn = Util.null2String(request.getParameter("field_"+fieldid+"_En"));
			String fieldnameTW = Util.null2String(request.getParameter("field_"+fieldid+"_TW"));
			fieldnameCN = Util.StringReplace(fieldnameCN, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
			fieldnameCN = Util.StringReplace(fieldnameCN, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
			fieldnameEn = Util.StringReplace(fieldnameEn, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
			fieldnameEn = Util.StringReplace(fieldnameEn, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
			fieldnameTW = Util.StringReplace(fieldnameTW, "\"", "");//TD10108 ���ֶ���ʾ�������Ժ��а��˫���š�"��
			fieldnameTW = Util.StringReplace(fieldnameTW, "'", "");//TD31514 ���ֶ���ʾ�������Ժ��а�ǵ����š�'��
			int lableid = 0;
			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldnameCN+"' collate Chinese_PRC_CS_AI and languageid=7");
			else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldnameCN+"' and languageid=7");
		  if(RecordSet.next()) lableid = RecordSet.getInt("indexid");//����ֶ������ڱ�ǩ���д��ڣ�ȡ�ñ�ǩid,������Ϊ׼��
			else{//�������������µı�ǩid
				lableid = FormManager.getNewIndexId(RecordSetTrans);
			}
			if(lableid!=-1){//���±�ǩ��
				RecordSet.executeSql("delete from HtmlLabelIndex where id="+lableid);
				RecordSet.executeSql("delete from HtmlLabelInfo where indexid="+lableid);
				RecordSet.executeSql("INSERT INTO HtmlLabelIndex values("+lableid+",'"+fieldnameCN+"')");
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameCN+"',7)");//����
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameEn+"',8)");//Ӣ��
				RecordSet.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameTW+"',9)");//����
			}
			
			RecordSet.executeSql("update workflow_billfield set fieldlabel="+lableid+" where id="+fieldid);
			
			LabelComInfo.addLabeInfoCache(""+lableid);//���»���
			
		}
		RecordSetTrans.commit();
	}catch(Exception exception){
		RecordSetTrans.rollback();
	}
	response.sendRedirect("/workflow/form/addformfieldlabel0.jsp?formid="+formid+"&ajax=1");
}
%>