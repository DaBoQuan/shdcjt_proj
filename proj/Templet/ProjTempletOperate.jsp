<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjTempletUtil" class="weaver.proj.Templet.ProjTempletUtil" scope="page" />
<jsp:useBean id="PriTemplate" class="weaver.proj.PriTemplate" scope="page" />
<%
    //�����Դ
    String URLFrom = URLDecoder.decode(Util.null2String(request.getParameter("URLFrom")));
        
    String method = Util.null2String(request.getParameter("method"));
    String templetId = Util.null2String(request.getParameter("templetId"));
    //---------��Ŀ����
    int projectType = Util.getIntValue(request.getParameter("txtPrjType"));  //��Ŀ����
    int workType = Util.getIntValue(request.getParameter("txtWorkType"));     //��������
    String hrmId = Util.null2String(request.getParameter("hrmids02"));        //��Ŀ��Ա
    int parentId = Util.getIntValue(request.getParameter("txtParentId"));     //�ϼ���Ŀ
    int envDoc = Util.getIntValue(request.getParameter("txtEnvDoc"));       //������
    int conDoc = Util.getIntValue(request.getParameter("txtConDoc"));       //ȷ����
    int adviceDoc = Util.getIntValue(request.getParameter("txtAdviceDoc"));    //������
    int prjManager = Util.getIntValue(request.getParameter("txtPrjManager"));   //����
    String isCrmShow = Util.null2String(request.getParameter("isCrmShow"));       //�ͻ��ɼ�
    String isMemberShow = Util.null2String(request.getParameter("isMemberShow"));    //��Ա�ɼ�
    String aboutMCrm = Util.null2String(request.getParameter("areaAboutMCrm"));    //��ؿͻ�
    String templetName = Util.null2String(request.getParameter("txtTempletName"));    //ģ������
    String templetDesc = Util.null2String(request.getParameter("txtTempletDesc"));    //ģ������
   
    //---------��Ŀ�Զ����ֶ�
    String dff01=Util.null2String(request.getParameter("dff01"));
    String dff02=Util.null2String(request.getParameter("dff02"));
    String dff03=Util.null2String(request.getParameter("dff03"));
    String dff04=Util.null2String(request.getParameter("dff04"));
    String dff05=Util.null2String(request.getParameter("dff05"));

    String nff01=Util.null2String(request.getParameter("nff01"));
    if(nff01.equals("")) nff01="0.0";
    String nff02=Util.null2String(request.getParameter("nff02"));
    if(nff02.equals("")) nff02="0.0";
    String nff03=Util.null2String(request.getParameter("nff03"));
    if(nff03.equals("")) nff03="0.0";
    String nff04=Util.null2String(request.getParameter("nff04"));
    if(nff04.equals("")) nff04="0.0";
    String nff05=Util.null2String(request.getParameter("nff05"));
    if(nff05.equals("")) nff05="0.0";

    String tff01=Util.fromScreen(request.getParameter("tff01"),user.getLanguage());
    String tff02=Util.fromScreen(request.getParameter("tff02"),user.getLanguage());
    String tff03=Util.fromScreen(request.getParameter("tff03"),user.getLanguage());
    String tff04=Util.fromScreen(request.getParameter("tff04"),user.getLanguage());
    String tff05=Util.fromScreen(request.getParameter("tff05"),user.getLanguage());

    String bff01=Util.null2String(request.getParameter("bff01"));
    if(bff01.equals("")) bff01="0";
    String bff02=Util.null2String(request.getParameter("bff02"));
    if(bff02.equals("")) bff02="0";
    String bff03=Util.null2String(request.getParameter("bff03"));
    if(bff03.equals("")) bff03="0";
    String bff04=Util.null2String(request.getParameter("bff04"));
    if(bff04.equals("")) bff04="0";
    String bff05=Util.null2String(request.getParameter("bff05"));
    if(bff05.equals("")) bff05="0";

    //---------�����Զ����ֶ�
    String[] taskids = request.getParameterValues("templetTaskId");   //����ID
    String[] rowIndexs = request.getParameterValues("txtRowIndex");   //��������
    String[] taskNames = request.getParameterValues("txtTaskName");   //��������
    String[] workLongs = request.getParameterValues("txtWorkLong");   //����
    String[] beginDates = request.getParameterValues("txtBeginDate");  //��ʼʱ��
    String[] endDates = request.getParameterValues("txtEndDate");     //����ʱ��
    String[] beforeTasks = request.getParameterValues("seleBeforeTask"); //ǰ������
    String[] budgets = request.getParameterValues("txtBudget");         //Ԥ��
    String[] managers = request.getParameterValues("txtManager");       //������
    String linkXml=Util.null2String(request.getParameter("areaLinkXml"));  //���¼���ϵ���ַ���
 PriTemplate.setTempletName(templetName);
 PriTemplate.setTempletDesc(templetDesc);
 PriTemplate.setProjectType(projectType);
 PriTemplate.setWorkType(workType);
 PriTemplate.setHrmId(hrmId);
 PriTemplate.setIsMemberShow(isMemberShow);
 PriTemplate.setAboutMCrm(aboutMCrm);
 PriTemplate.setIsCrmShow(isCrmShow);
 PriTemplate.setParentId(parentId);
 PriTemplate.setEnvDoc(envDoc);
 PriTemplate.setConDoc(conDoc);
 PriTemplate.setAdviceDoc(adviceDoc);
 PriTemplate.setPrjManager(prjManager);
 PriTemplate.setLinkXml(linkXml);
 PriTemplate.setDff01(dff01);
 PriTemplate.setDff02(dff02);
 PriTemplate.setDff03(dff03);
 PriTemplate.setDff04(dff04);
 PriTemplate.setDff05(dff05);
 PriTemplate.setNff01(nff01);
 PriTemplate.setNff02(nff02);
 PriTemplate.setNff03(nff03);
 PriTemplate.setNff04(nff04);
 PriTemplate.setNff05(nff05);
 PriTemplate.setTff01(tff01);
 PriTemplate.setTff02(tff02);
 PriTemplate.setTff03(tff03);
 PriTemplate.setTff04(tff04);
 PriTemplate.setTff05(tff05);
 PriTemplate.setBff01(bff01);
 PriTemplate.setBff02(bff02);
 PriTemplate.setBff03(bff03);
 PriTemplate.setBff04(bff04);
 PriTemplate.setBff05(bff05);
 PriTemplate.setTempletId(templetId);

    /*
    ��Ŀģ���Ƿ���Ҫ����
    modified by hubo,2006-04-21
    */
    String defaultStatus = "1";
	String sqlApprove = "SELECT isNeedAppr,wfid FROM ProjTemplateMaint";
	rs.executeSql(sqlApprove);
	if(rs.next()){
		if(rs.getString("isNeedAppr").equals("1")){
			defaultStatus = "0";
		}
	}

    if ("add".equals(method)){    
        try {
            //------��Ŀ��������Ŀ�Զ����ֶε����ݵĲ���
           PriTemplate.AddPrjTemplateInfo();
            //System.out.println(strInsertSql);
            rs.executeSql("select max(id) from Prj_Template");
            int newProjId = 0;
            if (rs.next()){
                newProjId = Util.getIntValue(rs.getString(1));
            }
            //System.out.println(linkXml);
            //------��Ŀ�����Զ����ֶε�ֵ�Ĳ���
            ProjTempletUtil.addProjTypeCData(request,newProjId);
        
            //------��������ݵĲ���
   
            for (int i=0 ;i<taskNames.length;i++){
                int rowIndex = Util.getIntValue(rowIndexs[i]);
                String taskName = taskNames[i];
                float workLong = Util.getFloatValue(workLongs[i],0);
                String beginDate = beginDates[i];
                String endDate = endDates[i];
                int beforeTask = Util.getIntValue(beforeTasks[i],0);
                float budget = Util.getFloatValue(budgets[i],0);
                int manager =Util.getIntValue(managers[i],0);

                String parentTaskId = ProjTempletUtil.getParentTaskId(linkXml,rowIndex);                  
                //System.out.println("rowIndex :"+rowIndex+" parentTaskId : "+parentTaskId);
                String strsqlForTask = "insert into Prj_TemplateTask (templetId,templetTaskId,taskName,taskManager,begindate,enddate,workday,budget,parentTaskId,befTaskId) values("+newProjId+","+(i+1)+",'"+taskName+"',"+manager+",'"+beginDate+"','"+endDate+"',"+workLong+","+budget+","+parentTaskId+","+beforeTask+")";                
                rs.executeSql(strsqlForTask);          
             }
             
             //ǰ����������
             //������δʵ�ʲ������ݿ�ǰ������id��ȷ������ʱǰ�����񱣴��idΪ������кţ�������������ݿ����Ҫ����ʵ��ǰ������id
             rs.executeSql("select id,befTaskId from Prj_TemplateTask where befTaskId!=0 and templetId="+newProjId);
             while(rs.next()){
                 String id = rs.getString("id");
                 String befTaskId = rs.getString("befTaskId");
                 String realBefTaskId = befTaskId;
                 rs1.executeSql("select id from Prj_TemplateTask where templetTaskId="+befTaskId+" and templetId="+newProjId);
                 if(rs1.next()) realBefTaskId = rs1.getString("id");
                 rs1.executeSql("update Prj_TemplateTask set befTaskId="+realBefTaskId+" where id="+id);
             }
             //ǰ����������
        } catch (Exception ex) {
            System.out.println(ex);
        }
        if (!"".equals(URLFrom)){
            response.sendRedirect(URLFrom);
        } else {
            response.sendRedirect("ProjTempletList.jsp");        
        }
        return ;
    } else if("edit".equals(method)) {
        try {
            //------��Ŀ��������Ŀ�Զ����ֶε����ݵĲ���
            PriTemplate.EditPriTemplateInfo();
           
            //------��Ŀ�����Զ����ֶε�ֵ�ı༭
            ProjTempletUtil.editProjTypeCData(request,Util.getIntValue(templetId));
           
            //------��������ݵı༭
            //ѡɾ��������ص�����,�����ȫ����������         

            for (int i=0 ;i<rowIndexs.length;i++){
                int rowIndex = Util.getIntValue(rowIndexs[i]);
                String taskName = taskNames[i];
                float workLong = Util.getFloatValue(workLongs[i],0);
                String beginDate = beginDates[i];
                String endDate = endDates[i];
                int beforeTask = 0;
                int bfindex = Util.getIntValue(beforeTasks[i],0);
                if(bfindex>0) {
                	//ǰ������
                	beforeTask = Util.getIntValue(rowIndexs[bfindex-1]);
                }
                float budget = Util.getFloatValue(budgets[i],0);
                int manager =Util.getIntValue(managers[i],0);
                String parentTaskId = ProjTempletUtil.getParentTaskId(linkXml,rowIndex);
                int taskid = Util.getIntValue(taskids[i],-1);

                //System.out.println("rowIndex :"+rowIndex+" parentTaskId : "+parentTaskId);
                String strsqlForTask = "";
                if (taskid!=-1){
                    strsqlForTask="update Prj_TemplateTask set taskName='"+taskName+"',taskManager="+manager+",begindate='"+beginDate+"',enddate='"+endDate+"',workday="+workLong+",budget="+budget+",parentTaskId="+parentTaskId+",befTaskId="+beforeTask+" where templetid="+templetId+" and id="+taskid;
                } else {
                    strsqlForTask = "insert into Prj_TemplateTask (templetId,templetTaskId,taskName,taskManager,begindate,enddate,workday,budget,parentTaskId,befTaskId) values("+templetId+","+rowIndex+",'"+taskName+"',"+manager+",'"+beginDate+"','"+endDate+"',"+workLong+","+budget+","+parentTaskId+","+beforeTask+")"; 
                }
                rs.executeSql(strsqlForTask); 
             }
             //ɾ����ص����� 
             
             
             //ǰ����������
             //������δʵ�ʲ������ݿ�ǰ������id��ȷ������ʱǰ�����񱣴��idΪ������кţ�������������ݿ����Ҫ����ʵ��ǰ������id
             rs.executeSql("select id,befTaskId from Prj_TemplateTask where befTaskId!=0 and templetId="+templetId);
             while(rs.next()){
                 String id = rs.getString("id");
                 String befTaskId = rs.getString("befTaskId");
                 String realBefTaskId = befTaskId;
                 rs1.executeSql("select id from Prj_TemplateTask where templetTaskId="+befTaskId+" and templetId="+templetId);
                 if(rs1.next()) realBefTaskId = rs1.getString("id");
                 rs1.executeSql("update Prj_TemplateTask set befTaskId="+realBefTaskId+" where id="+id);
             }
             //ǰ����������
        } catch (Exception ex) {
        	System.out.println(ex);
        }

        ArrayList rowIndexList = Util.arrayToArrayList(rowIndexs);
        rs.executeSql("select id,templetTaskId from Prj_TemplateTask where templetId="+templetId);
        while (rs.next()){
            String taskId = Util.null2String(rs.getString("id"));
            String templetTaskId = Util.null2String(rs.getString("templetTaskId"));           
            //����ӿͻ��˴������������в����ڴ������ID����ɾ��������
            if (rowIndexList.indexOf(templetTaskId)==-1){    
                rs1.executeSql("delete Prj_TemplateTask where id = "+taskId);
            }
        }
        response.sendRedirect("ProjTempletView.jsp?templetId="+templetId);        
        return ;
    } else if("delete".equals(method)) {
       if (!"".equals(templetId)) {
             //ɾ��ģ�屾�е�����
             String strDelTemplet = "delete Prj_Template where id="+templetId;
             rs.executeSql(strDelTemplet);
            //ɾ����������е�����
             String strDelTask = "delete Prj_TemplateTask where templetId="+templetId;
             rs.executeSql(strDelTask);
            //ɾ���Զ�����е�����
             String strDelCdTemplet = "delete cus_fielddata where scope='ProjCustomField'  and id = "+templetId;
             rs.executeSql(strDelCdTemplet);

             //System.out.println(strDelTemplet);
             //System.out.println(strDelTask);
             //System.out.println(strDelCdTemplet);
       }
       if (!"".equals(URLFrom)){
            response.sendRedirect(URLFrom);            
        } else {
            response.sendRedirect("ProjTempletList.jsp"); 
        }
    }
%>
