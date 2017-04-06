<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="FnaBudgetInfoComInfo" class="weaver.fna.maintenance.FnaBudgetInfoComInfo" scope="page"/>
<jsp:useBean id="BudgetApproveWFHandler" class="weaver.fna.budget.BudgetApproveWFHandler" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<%
    String operation = Util.null2String(request.getParameter("operation"));
    String fnabudgetinfoid = Util.null2String(request.getParameter("fnabudgetinfoid"));//ID
    String oldfnabudgetinfoid = fnabudgetinfoid;
    String organizationid = Util.null2String(request.getParameter("organizationid"));//��֯ID
    String organizationtype = Util.null2String(request.getParameter("organizationtype"));//��֯����
    String budgetperiods = Util.null2String(request.getParameter("budgetperiods"));//�ڼ�ID

    String budgetyears = "";//�ڼ���
    String revision = "";//�汾
    String status = "";//״̬
    String budgetstatus = "";//����״̬

    String sqlstr = "";
    String para = "";
    char separator = Util.getSeparator();
    Calendar today = Calendar.getInstance();
    String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
            Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
            Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) + " " +
            Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
            Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
            Util.add0(today.get(Calendar.SECOND), 2);
    //ȡ����
    sqlstr = " select budgetperiods,budgetorganizationid,organizationtype,revision,status,budgetstatus from FnaBudgetInfo where id = " + fnabudgetinfoid;
    RecordSet.executeSql(sqlstr);
    if (RecordSet.next()) {
        budgetperiods = RecordSet.getString("budgetperiods");
        organizationid = RecordSet.getString("budgetorganizationid");
        organizationtype = RecordSet.getString("organizationtype");
        revision = RecordSet.getString("revision");
        status = RecordSet.getString("status");
        budgetstatus = RecordSet.getString("budgetstatus");
    } else {
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
    //ȡ��ǰ�ڼ�����
    if ("".equals(budgetyears)) {
        sqlstr = " select fnayear from FnaYearsPeriods where id = " + budgetperiods;
        RecordSet.executeSql(sqlstr);
        if (RecordSet.next()) {
            budgetyears = RecordSet.getString("fnayear");
        }
    }

    boolean canEdit = true;
//���Ȩ��
    int right = -1;//-1����ֹ��0��ֻ����1���༭��2����ȫ����
    if ("0".equals(organizationtype)) {
        if (HrmUserVarify.checkUserRight("HeadBudget:Maint", user)) right = Util.getIntValue(HrmUserVarify.getRightLevel("HeadBudget:Maint", user),0);
    } else {
        if (Util.getIntValue(String.valueOf(session.getAttribute("detachable")), 0) == 1) {//�����Ȩ
            int subCompanyId = 0;
            if("1".equals(organizationtype))
                subCompanyId = (new Integer(organizationid)).intValue();
            else if("2".equals(organizationtype))
                subCompanyId = (new Integer(DepartmentComInfo.getSubcompanyid1(organizationid))).intValue();
            else if("3".equals(organizationtype))
                 subCompanyId = (new Integer(DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(organizationid)))).intValue();
            right = CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(), "SubBudget:Maint",subCompanyId);
        } else {
            if (HrmUserVarify.checkUserRight("SubBudget:Maint", user))
                right = Util.getIntValue(HrmUserVarify.getRightLevel("SubBudget:Maint", user),0);
        }
    }
    if (right < 1) canEdit = false;//���ɱ༭

    if(!canEdit) {
        response.sendRedirect("/notice/noright.jsp") ;
        return ;
    }

    String[] BUDGET_CALCULETE_TYPE = new String[]{"canusedbudget", "allottedbudget", "originalbudget", "newbudget", "addedbudget"};
    String[] BUDGET_CALCULETE_TIME_TYPE = new String[]{"month", "quarter", "halfyear", "year"};

    int topage = Util.getIntValue(Util.null2String(request.getParameter("topage")),1);
    int opage = Util.getIntValue(Util.null2String(request.getParameter("page")),1);
    int showtab = Util.getIntValue(Util.null2String(request.getParameter("showtab")),1);
    String wrapshow = Util.null2String(request.getParameter("wrapshow"));
    
    //����ĳ�汾Ϊ�ݸ�
    if (operation.equals("savetodraft")) {
        status = "0";
        budgetstatus = "0";
        revision = "0";
        //������вݸ壬�����ɾ��
        RecordSet.executeSql(
                " select id from FnaBudgetInfo where "
                        + " budgetorganizationid = " + organizationid
                        + " and organizationtype = " + organizationtype
                        + " and budgetperiods = " + budgetperiods
                        + " and status = 0 ");
        while(RecordSet.next()) {
            String existfnabudgetinfoid = RecordSet.getString(1);
            RecordSet2.executeSql("delete from FnaBudgetInfoDetail where budgetinfoid = " + existfnabudgetinfoid);
            RecordSet2.executeSql("delete from FnaBudgetInfo where id = " + existfnabudgetinfoid);
        }
    	
        para = budgetperiods + separator//budgetperiods
        	 + organizationid + separator//budgetorganizationid
        	 + organizationtype + separator//organizationtype
        	 + budgetstatus + separator//budgetstatus
        	 + user.getUID() + separator//createrid
        	 + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
        	 + revision + separator//revision
        	 + status;//status
		RecordSet2.executeProc("FnaBudgetInfo_Insert", para);
		if (RecordSet2.next()) fnabudgetinfoid = RecordSet2.getString(1);

		String usedfnabudgetinfoid = oldfnabudgetinfoid;
		RecordSet2.executeSql(
            		"insert into FnaBudgetInfoDetail(budgetinfoid,budgetperiods,budgettypeid,budgetaccount,budgetperiodslist)"
                    + " select " + fnabudgetinfoid + ",budgetperiods,budgettypeid,budgetaccount,budgetperiodslist"
                    + " from FnaBudgetInfoDetail "
                    + " where budgetinfoid = " + usedfnabudgetinfoid
    	);
        response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&showtab="+showtab+"&page="+opage+"&wrapshow="+wrapshow);
    }
    
    
    if (operation.equals("savepage")) {
        int check = FnaBudgetInfoComInfo.checkBudget(request,1);

        if (check != 0) {
            response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&showtab="+showtab+"&page="+opage+"&wrapshow="+wrapshow+"&msgid=" + check);
            return;
        }

        //����޸ĵ�����Ч�汾���������Ч�汾�½��ݸ�
        if (!"0".equals(status)) {
            status = "0";
            budgetstatus = "0";
            revision = "0";
            //������вݸ壬�����ɾ��
            RecordSet.executeSql(
                    " select id from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods
                            + " and status = 0 ");
            while(RecordSet.next()) {
                String existfnabudgetinfoid = RecordSet.getString(1);
                RecordSet2.executeSql("delete from FnaBudgetInfoDetail where budgetinfoid = " + existfnabudgetinfoid);
                RecordSet2.executeSql("delete from FnaBudgetInfo where id = " + existfnabudgetinfoid);

                //System.out.println("delete existed draft");
            }
            para = budgetperiods + separator//budgetperiods
                    + organizationid + separator//budgetorganizationid
                    + organizationtype + separator//organizationtype
                    + budgetstatus + separator//budgetstatus
                    + user.getUID() + separator//createrid
                    + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                    + revision + separator//revision
                    + status;//status
            RecordSet.executeProc("FnaBudgetInfo_Insert", para);
            if (RecordSet.next()){
            	fnabudgetinfoid = RecordSet.getString(1);
                RecordSet2.executeSql("insert into FnaBudgetInfoDetail(budgetinfoid,budgetperiods,budgettypeid,budgetresourceid,budgetcrmid,budgetprojectid,budgetaccount,budgetremark,budgetperiodslist) (select "+fnabudgetinfoid+",budgetperiods,budgettypeid,budgetresourceid,budgetcrmid,budgetprojectid,budgetaccount,budgetremark,budgetperiodslist from FnaBudgetInfoDetail where budgetinfoid = " + oldfnabudgetinfoid + ")");
            }
        }

        String[] budgetids = request.getParameterValues("FnaBudgetfeeTypeIDs");
        String[] budgetvaluenum = request.getParameterValues("FnaBudgetfeeTypeSaveValueNum");

        for (int i = 0; budgetids != null && budgetvaluenum != null && i < budgetids.length; i++) {
            String getstr = "";
            String flag = "_";
            if (budgetvaluenum[i].equals("12")) getstr += BUDGET_CALCULETE_TIME_TYPE[0];
            else if (budgetvaluenum[i].equals("4")) getstr += BUDGET_CALCULETE_TIME_TYPE[1];
            else if (budgetvaluenum[i].equals("2")) getstr += BUDGET_CALCULETE_TIME_TYPE[2];
            else if (budgetvaluenum[i].equals("1")) getstr += BUDGET_CALCULETE_TIME_TYPE[3];
            getstr += flag;
            getstr += budgetids[i];
            getstr += flag;
            getstr += BUDGET_CALCULETE_TYPE[3];
            getstr += flag;

            for (int j = 1; j <= (new Integer(budgetvaluenum[i])).intValue(); j++) {
                String getstr1 = getstr;
                if ("1".equals(budgetvaluenum[i])) getstr1 += "sum";
                else getstr1 += j;

                String account = Util.null2String(request.getParameter(getstr1));
				if (account==null||"".equals(account)) account="0";
                para = fnabudgetinfoid + separator
                        + budgetperiods + separator
                        + j + separator
                        + budgetids[i] + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + account + separator
                        + "";

                if (account!=null&&!"".equals(account)&&Util.getDoubleValue(account) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }
        //״̬����Ϊ�ݸ�
        para = fnabudgetinfoid + separator
                + status + separator
                + revision + separator
                + budgetstatus;

        RecordSet.executeProc("FnaBudgetInfo_UpdateStatus", para);

        response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&showtab="+showtab+"&page="+topage+"&wrapshow="+wrapshow);
    }

    //����
    if (operation.equals("editbudget")) {
        int check = FnaBudgetInfoComInfo.checkBudget(request,1);

        if (check != 0) {
            response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&msgid=" + check);
            return;
        }

        //����޸ĵ�����Ч�汾���������Ч�汾�½��ݸ�
        if (!"0".equals(status)) {
            status = "0";
            budgetstatus = "0";
            revision = "0";
            //������вݸ壬�����ɾ��
            RecordSet.executeSql(
                    " select id from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods
                            + " and status = 0 ");
            while(RecordSet.next()) {
                String existfnabudgetinfoid = RecordSet.getString(1);
                RecordSet2.executeSql("delete from FnaBudgetInfoDetail where budgetinfoid = " + existfnabudgetinfoid);
                RecordSet2.executeSql("delete from FnaBudgetInfo where id = " + existfnabudgetinfoid);

                //System.out.println("delete existed draft");
            }
            para = budgetperiods + separator//budgetperiods
                    + organizationid + separator//budgetorganizationid
                    + organizationtype + separator//organizationtype
                    + budgetstatus + separator//budgetstatus
                    + user.getUID() + separator//createrid
                    + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                    + revision + separator//revision
                    + status;//status
            RecordSet.executeProc("FnaBudgetInfo_Insert", para);
            if (RecordSet.next()){
            	fnabudgetinfoid = RecordSet.getString(1);
                RecordSet2.executeSql("insert into FnaBudgetInfoDetail(budgetinfoid,budgetperiods,budgettypeid,budgetresourceid,budgetcrmid,budgetprojectid,budgetaccount,budgetremark,budgetperiodslist) (select "+fnabudgetinfoid+",budgetperiods,budgettypeid,budgetresourceid,budgetcrmid,budgetprojectid,budgetaccount,budgetremark,budgetperiodslist from FnaBudgetInfoDetail where budgetinfoid = " + oldfnabudgetinfoid + ")");
            }
        }

        String[] budgetids = request.getParameterValues("FnaBudgetfeeTypeIDs");
        String[] budgetvaluenum = request.getParameterValues("FnaBudgetfeeTypeSaveValueNum");

        for (int i = 0; budgetids != null && budgetvaluenum != null && i < budgetids.length; i++) {
            String getstr = "";
            String flag = "_";
            if (budgetvaluenum[i].equals("12")) getstr += BUDGET_CALCULETE_TIME_TYPE[0];
            else if (budgetvaluenum[i].equals("4")) getstr += BUDGET_CALCULETE_TIME_TYPE[1];
            else if (budgetvaluenum[i].equals("2")) getstr += BUDGET_CALCULETE_TIME_TYPE[2];
            else if (budgetvaluenum[i].equals("1")) getstr += BUDGET_CALCULETE_TIME_TYPE[3];
            getstr += flag;
            getstr += budgetids[i];
            getstr += flag;
            getstr += BUDGET_CALCULETE_TYPE[3];
            getstr += flag;

            for (int j = 1; j <= (new Integer(budgetvaluenum[i])).intValue(); j++) {
                String getstr1 = getstr;
                if ("1".equals(budgetvaluenum[i])) getstr1 += "sum";
                else getstr1 += j;

                String account = Util.null2String(request.getParameter(getstr1));
				if (account==null||"".equals(account)) account="0";
                para = fnabudgetinfoid + separator
                        + budgetperiods + separator
                        + j + separator
                        + budgetids[i] + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + account + separator
                        + "";

                //if (account!=null&&!"".equals(account)&&Util.getDoubleValue(account) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }
        //״̬����Ϊ�ݸ�
        para = fnabudgetinfoid + separator
                + status + separator
                + revision + separator
                + budgetstatus;

        RecordSet.executeProc("FnaBudgetInfo_UpdateStatus", para);

        response.sendRedirect("FnaBudgetView.jsp?fnabudgetinfoid=" + fnabudgetinfoid);
    }

    //�ύ����
    if (operation.equals("processfnabudget")) {
        int check = FnaBudgetInfoComInfo.checkBudget(request,2);

        if (check != 0) {
            response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&msgid=" + check);
            return;
        }

        //����ԭ����Ч�汾,��ԭ������Ч�汾���Ϊ��ʷ
        String inusefnabudgetinfoid = "";
        String inusestatus = "";
        String inuserevision = "";
        String inusebudgetstatus = "";
        RecordSet.executeSql(
                " select id,revision,budgetstatus,status from FnaBudgetInfo where "
                        + " budgetorganizationid = " + organizationid
                        + " and organizationtype = " + organizationtype
                        + " and budgetperiods = " + budgetperiods
                        + " and status = 1 ");
        if (RecordSet.next()) {
            inusefnabudgetinfoid = Util.null2String(RecordSet.getString(1));
            inuserevision = Util.null2String(RecordSet.getString(2));
            inusebudgetstatus = Util.null2String(RecordSet.getString(3));
            inusestatus = Util.null2String(RecordSet.getString(4));
            //��Ϊ��ʷ״̬
            inusestatus = "2";
            para = inusefnabudgetinfoid + separator
                    + inusestatus + separator
                    + inuserevision + separator
                    + inusebudgetstatus;
            RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
        }

        //����ǲݸ�,���ݸ���Ϊ�°汾
        if ("0".equals(status)) {
            status = "3";
            budgetstatus = "0";
            RecordSet.executeSql(
                    " select max(revision)+1 from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods);
            if (RecordSet.next()) {
                revision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
            }
            para = fnabudgetinfoid + separator
                    + status + separator
                    + revision + separator
                    + budgetstatus;
            RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
        } else {
            //�����°汾
            status = "3";
            budgetstatus = "0";
            RecordSet.executeSql(
                    " select max(revision)+1 from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods);
            if (RecordSet.next()) {
                revision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
            }
            para = budgetperiods + separator//budgetperiods
                    + organizationid + separator//budgetorganizationid
                    + organizationtype + separator//organizationtype
                    + budgetstatus + separator//budgetstatus
                    + user.getUID() + separator//createrid
                    + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                    + revision + separator//revision
                    + status;//status
            RecordSet.executeProc("FnaBudgetInfo_Insert", para);
            RecordSet.next();
            fnabudgetinfoid = RecordSet.getString(1);
        }

        String[] budgetids = request.getParameterValues("FnaBudgetfeeTypeIDs");
        String[] budgetvaluenum = request.getParameterValues("FnaBudgetfeeTypeSaveValueNum");

        for (int i = 0; budgetids != null && budgetvaluenum != null && i < budgetids.length; i++) {
            String getstr = "";
            String flag = "_";
            if (budgetvaluenum[i].equals("12")) getstr += BUDGET_CALCULETE_TIME_TYPE[0];
            else if (budgetvaluenum[i].equals("4")) getstr += BUDGET_CALCULETE_TIME_TYPE[1];
            else if (budgetvaluenum[i].equals("2")) getstr += BUDGET_CALCULETE_TIME_TYPE[2];
            else if (budgetvaluenum[i].equals("1")) getstr += BUDGET_CALCULETE_TIME_TYPE[3];
            getstr += flag;
            getstr += budgetids[i];
            getstr += flag;
            getstr += BUDGET_CALCULETE_TYPE[3];
            getstr += flag;

            for (int j = 1; j <= (new Integer(budgetvaluenum[i])).intValue(); j++) {
                String getstr1 = getstr;
                if ("1".equals(budgetvaluenum[i])) getstr1 += "sum";
                else getstr1 += j;

                String account = Util.null2String(request.getParameter(getstr1));
				if (account==null||"".equals(account)) account="0";
                para = fnabudgetinfoid + separator
                        + budgetperiods + separator
                        + j + separator
                        + budgetids[i] + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + account + separator
                        + "";

                //if (account!=null&&!"".equals(account)&&Util.getDoubleValue(account) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }

        // Todo �ύ����
        String subcomid = "0";//�ֲ�ID
        if ("1".equals(organizationtype))
            subcomid = organizationid;
        else if ("2".equals(organizationtype))
            subcomid = DepartmentComInfo.getSubcompanyid1(organizationid);
        else if ("3".equals(organizationtype))
            subcomid = DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(organizationid));
        //ȡ����ֲ���Ŀ�����Ĺ�����ID
        int workflowid = BudgetApproveWFHandler.getApproveWFId((new Integer(subcomid)).intValue());
        
        RecordSet.executeSql(" update FnaBudgetInfo set remark = '" + SystemEnv.getHtmlLabelName(367, user.getLanguage()) + "' where id = " + fnabudgetinfoid);
        
        //�ύ����
        BudgetApproveWFHandler.SetWorkFlowID(workflowid);
        BudgetApproveWFHandler.SetCreater(user);
        BudgetApproveWFHandler.SetRequestName(SystemEnv.getHtmlLabelName(386, user.getLanguage()) + SystemEnv.getHtmlLabelName(359, user.getLanguage()));
        BudgetApproveWFHandler.SetBudgetId((new Integer(fnabudgetinfoid).intValue()));
        int message = BudgetApproveWFHandler.NewFlow();
		if(message==-1){//���̴���ʧ�ܣ���ô����������Ϊ�ݸ�״̬
			RecordSet.executeSql("update fnabudgetinfo set status = 0,revision=0 where id = " + fnabudgetinfoid);
		}
        response.sendRedirect("FnaBudgetView.jsp?fnabudgetinfoid=" + fnabudgetinfoid);
    }

    //��׼��Ч
    if (operation.equals("approvefnabudget")) {
        int check = FnaBudgetInfoComInfo.checkBudget(request,3);

        if (check != 0) {
            response.sendRedirect("FnaBudgetEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&msgid=" + check);
            return;
        }

        //����ԭ����Ч�汾,��ԭ������Ч�汾���Ϊ��ʷ
        String inusefnabudgetinfoid = "";
        String inusestatus = "";
        String inuserevision = "";
        String inusebudgetstatus = "";
        RecordSet.executeSql(
                " select id,revision,budgetstatus,status from FnaBudgetInfo where "
                        + " budgetorganizationid = " + organizationid
                        + " and organizationtype = " + organizationtype
                        + " and budgetperiods = " + budgetperiods
                        + " and status = 1 ");
        if (RecordSet.next()) {
            inusefnabudgetinfoid = Util.null2String(RecordSet.getString(1));
            inuserevision = Util.null2String(RecordSet.getString(2));
            inusebudgetstatus = Util.null2String(RecordSet.getString(3));
            inusestatus = Util.null2String(RecordSet.getString(4));
            //��Ϊ��ʷ״̬
            inusestatus = "2";
            para = inusefnabudgetinfoid + separator
                    + inusestatus + separator
                    + inuserevision + separator
                    + inusebudgetstatus;
            RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
        }

        //����ǲݸ�,���ݸ���Ϊ�°汾
        if ("0".equals(status)) {
            status = "1";
            budgetstatus = "0";
            RecordSet.executeSql(
                    " select max(revision)+1 from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods);
            if (RecordSet.next()) {
                revision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
            }
            para = fnabudgetinfoid + separator
                    + status + separator
                    + revision + separator
                    + budgetstatus;
            RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
        } else {
            //�����°汾
            status = "1";
            budgetstatus = "0";
            RecordSet.executeSql(
                    " select max(revision)+1 from FnaBudgetInfo where "
                            + " budgetorganizationid = " + organizationid
                            + " and organizationtype = " + organizationtype
                            + " and budgetperiods = " + budgetperiods);
            if (RecordSet.next()) {
                revision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
            }
            para = budgetperiods + separator//budgetperiods
                    + organizationid + separator//budgetorganizationid
                    + organizationtype + separator//organizationtype
                    + budgetstatus + separator//budgetstatus
                    + user.getUID() + separator//createrid
                    + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                    + revision + separator//revision
                    + status;//status
            RecordSet.executeProc("FnaBudgetInfo_Insert", para);
            RecordSet.next();
            fnabudgetinfoid = RecordSet.getString(1);
        }

        String[] budgetids = request.getParameterValues("FnaBudgetfeeTypeIDs");
        String[] budgetvaluenum = request.getParameterValues("FnaBudgetfeeTypeSaveValueNum");

        for (int i = 0; budgetids != null && budgetvaluenum != null && i < budgetids.length; i++) {
            String getstr = "";
            String flag = "_";
            if (budgetvaluenum[i].equals("12")) getstr += BUDGET_CALCULETE_TIME_TYPE[0];
            else if (budgetvaluenum[i].equals("4")) getstr += BUDGET_CALCULETE_TIME_TYPE[1];
            else if (budgetvaluenum[i].equals("2")) getstr += BUDGET_CALCULETE_TIME_TYPE[2];
            else if (budgetvaluenum[i].equals("1")) getstr += BUDGET_CALCULETE_TIME_TYPE[3];
            getstr += flag;
            getstr += budgetids[i];
            getstr += flag;
            getstr += BUDGET_CALCULETE_TYPE[3];
            getstr += flag;

            for (int j = 1; j <= (new Integer(budgetvaluenum[i])).intValue(); j++) {
                String getstr1 = getstr;
                if ("1".equals(budgetvaluenum[i])) getstr1 += "sum";
                else getstr1 += j;

                String account = Util.null2String(request.getParameter(getstr1));
				if (account==null||"".equals(account)) account="0";
                para = fnabudgetinfoid + separator
                        + budgetperiods + separator
                        + j + separator
                        + budgetids[i] + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + account + separator
                        + "";

                //if (account!=null&&!"".equals(account)&&Util.getDoubleValue(account) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }

        response.sendRedirect("FnaBudgetView.jsp?fnabudgetinfoid=" + fnabudgetinfoid);
    }

    //����ݸ�
    if (operation.equals("edittypebudget")) {
        String[] FnaOrgIDs = request.getParameterValues("FnaOrgIDs");
        String[] FnaOrgTypes = request.getParameterValues("FnaOrgTypes");
        String tmpfnabudgettypeid = Util.null2String(request.getParameter("fnabudgettypeid"));//��ĿID

        for (int i = 0; FnaOrgIDs!=null && i < FnaOrgIDs.length; i++) {

            String tmporganizationid = FnaOrgIDs[i];
            String tmporganizationtype = FnaOrgTypes[i];
            String tmpbudgetperiods = budgetperiods;
            String tmpfnabudgetinfoid = "";
            String tmpbudgetstatus = "0";
            String tmprevision = "0";
            String tmpstatus = "0";
            String tmpaccount = "";

            if (status.equals("1")) {//�����ǰ��������Ч�汾���������з���������Ч�汾�����½��ݸ壬�����µ�ǰ��Ŀ
                RecordSet.executeSql(
                        " select id from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods
                                + " and status = 0 ");
                if (RecordSet.next()) {
                    String existfnabudgetinfoid = RecordSet.getString(1);
                    RecordSet2.executeSql("delete from FnaBudgetInfoDetail where budgetinfoid = " + existfnabudgetinfoid);
                    RecordSet2.executeSql("delete from FnaBudgetInfo where id = " + existfnabudgetinfoid);

                    //System.out.println("delete existed draft");
                }

                para = tmpbudgetperiods + separator//budgetperiods
                        + tmporganizationid + separator//budgetorganizationid
                        + tmporganizationtype + separator//organizationtype
                        + tmpbudgetstatus + separator//budgetstatus
                        + user.getUID() + separator//createrid
                        + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                        + tmprevision + separator//revision
                        + tmpstatus;//status
                RecordSet2.executeProc("FnaBudgetInfo_Insert", para);
                if (RecordSet2.next()) tmpfnabudgetinfoid = RecordSet2.getString(1);

                RecordSet.executeSql(
                        " select id from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods
                                + " and status = 1 ");
                if (RecordSet.next()) {
                    String usedfnabudgetinfoid = RecordSet.getString(1);
                    RecordSet2.executeSql(
                            "insert into FnaBudgetInfoDetail(budgetinfoid,budgetperiods,budgettypeid,budgetaccount,budgetperiodslist)"
                                    + " select " + tmpfnabudgetinfoid + ",budgetperiods,budgettypeid,budgetaccount,budgetperiodslist"
                                    + " from FnaBudgetInfoDetail "
                                    + " where budgetinfoid = " + usedfnabudgetinfoid
                    );

                    //System.out.println("copy existed used");
                }
            } else {//�����ǰ�����ǲݸ�汾�����������з������ݸ�ĵ�ǰ��Ŀ
                RecordSet.executeSql(
                        " select id from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods
                                + " and status = 0");
                if (RecordSet.next()) {
                    tmpfnabudgetinfoid = RecordSet.getString(1);
                } else {
                    para = tmpbudgetperiods + separator//budgetperiods
                            + tmporganizationid + separator//budgetorganizationid
                            + tmporganizationtype + separator//organizationtype
                            + tmpbudgetstatus + separator//budgetstatus
                            + user.getUID() + separator//createrid
                            + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                            + tmprevision + separator//revision
                            + tmpstatus;//status
                    RecordSet2.executeProc("FnaBudgetInfo_Insert", para);
                    if (RecordSet2.next()) tmpfnabudgetinfoid = RecordSet2.getString(1);
                }
            }

            String[] Fna_Budgets = request.getParameterValues("Fna_" + tmporganizationid + "_" + FnaOrgTypes[i] + "_Budgets");//Ԥ��ֵ

            for (int j = 0; Fna_Budgets!=null && j < Fna_Budgets.length; j++) {

                tmpaccount = Util.null2String(Fna_Budgets[j]);

                //System.out.println(tmpaccount);
				if (tmpaccount==null||"".equals(tmpaccount)) tmpaccount="0";
                para = tmpfnabudgetinfoid + separator
                        + tmpbudgetperiods + separator
                        + (j + 1) + separator
                        + tmpfnabudgettypeid + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + tmpaccount + separator
                        + "";
                //if (tmpaccount!=null&&!"".equals(tmpaccount)&&Util.getDoubleValue(tmpaccount) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }
        response.sendRedirect("FnaBudgetTypeView.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&fnabudgettypeid=" + tmpfnabudgettypeid);
    }

    //��׼��Ч
    if (operation.equals("approvetypefnabudget")) {
        int check = FnaBudgetInfoComInfo.checkTypeBudget(request);

        if (check != 0) {
            response.sendRedirect("FnaBudgetTypeEdit.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&msgid=" + check);
            return;
        }

        String[] FnaOrgIDs = request.getParameterValues("FnaOrgIDs");
        String[] FnaOrgTypes = request.getParameterValues("FnaOrgTypes");
        String tmpfnabudgettypeid = Util.null2String(request.getParameter("fnabudgettypeid"));//��ĿID

        for (int i = 0; FnaOrgIDs!=null && i < FnaOrgIDs.length; i++) {

            String tmporganizationid = FnaOrgIDs[i];
            String tmporganizationtype = FnaOrgTypes[i];
            String tmpbudgetperiods = budgetperiods;
            String tmpfnabudgetinfoid = "";
            String tmpbudgetstatus = "0";
            String tmprevision = "0";
            String tmpstatus = "0";
            String tmpaccount = "";

            //����ԭ����Ч�汾,��ԭ������Ч�汾���Ϊ��ʷ
            String inusefnabudgetinfoid = "";
            String inusestatus = "";
            String inuserevision = "";
            String inusebudgetstatus = "";
            RecordSet.executeSql(
                    " select id,revision,budgetstatus,status from FnaBudgetInfo where "
                            + " budgetorganizationid = " + tmporganizationid
                            + " and organizationtype = " + tmporganizationtype
                            + " and budgetperiods = " + tmpbudgetperiods
                            + " and status = 1 ");
            if (RecordSet.next()) {
                inusefnabudgetinfoid = Util.null2String(RecordSet.getString(1));
                inuserevision = Util.null2String(RecordSet.getString(2));
                inusebudgetstatus = Util.null2String(RecordSet.getString(3));
                inusestatus = Util.null2String(RecordSet.getString(4));
                //��Ϊ��ʷ״̬
                inusestatus = "2";
                para = inusefnabudgetinfoid + separator
                        + inusestatus + separator
                        + inuserevision + separator
                        + inusebudgetstatus;
                RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
            }

            //�����ǰ��������Ч�汾����ԭ��Ч�汾�����°汾��Ч
            if (status.equals("1")) {

                RecordSet.executeSql(
                        " select max(revision)+1 from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods);
                if (RecordSet.next()) {
                    tmprevision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
                    tmpstatus = "1";
                    tmpbudgetstatus = "0";
                }
                //��ԭ��Ч�汾�½��°汾
                para = tmpbudgetperiods + separator//budgetperiods
                        + tmporganizationid + separator//budgetorganizationid
                        + tmporganizationtype + separator//organizationtype
                        + tmpbudgetstatus + separator//budgetstatus
                        + user.getUID() + separator//createrid
                        + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                        + tmprevision + separator//revision
                        + tmpstatus;//status
                RecordSet2.executeProc("FnaBudgetInfo_Insert", para);
                if (RecordSet2.next()) tmpfnabudgetinfoid = RecordSet2.getString(1);
                RecordSet.executeSql(
                        "insert into FnaBudgetInfoDetail(budgetinfoid,budgetperiods,budgettypeid,budgetaccount,budgetperiodslist)"
                                + " select " + tmpfnabudgetinfoid + ",budgetperiods,budgettypeid,budgetaccount,budgetperiodslist"
                                + " from FnaBudgetInfoDetail "
                                + " where budgetinfoid = " + inusefnabudgetinfoid
                );
            } else {
                //�����ǰ�����ǲݸ�汾�����ݸ�汾��Ϊ�°汾��Ч�����¿�Ŀ
                //�ҵ��ݸ壬û�ҵ��½�
                RecordSet.executeSql(
                        " select id from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods
                                + " and status = 0 ");
                if (RecordSet.next()) {
                    tmpfnabudgetinfoid = RecordSet.getString(1);
                } else {
                    para = budgetperiods + separator//budgetperiods
                            + tmporganizationid + separator//budgetorganizationid
                            + tmporganizationtype + separator//organizationtype
                            + tmpbudgetstatus + separator//budgetstatus
                            + user.getUID() + separator//createrid
                            + Util.fromScreen(currentdate, user.getLanguage()) + separator//createdate
                            + tmprevision + separator//revision
                            + tmpstatus;//status
                    RecordSet2.executeProc("FnaBudgetInfo_Insert", para);
                    if (RecordSet2.next()) tmpfnabudgetinfoid = RecordSet2.getString(1);
                }
                //����Ϊ�°汾����Ч
                tmpstatus = "1";
                tmpbudgetstatus = "0";
                RecordSet.executeSql(
                        " select max(revision)+1 from FnaBudgetInfo where "
                                + " budgetorganizationid = " + tmporganizationid
                                + " and organizationtype = " + tmporganizationtype
                                + " and budgetperiods = " + tmpbudgetperiods);
                if (RecordSet.next()) {
                    tmprevision = ""+Util.getIntValue(Util.null2String(RecordSet.getString(1)),1);
                }
                para = tmpfnabudgetinfoid + separator
                        + tmpstatus + separator
                        + tmprevision + separator
                        + tmpbudgetstatus;
                RecordSet2.executeProc("FnaBudgetInfo_UpdateStatus", para);
            }

            String[] Fna_Budgets = request.getParameterValues("Fna_" + tmporganizationid + "_" + FnaOrgTypes[i] + "_Budgets");//Ԥ��ֵ

            for (int j = 0; Fna_Budgets!=null && j < Fna_Budgets.length; j++) {

                tmpaccount = Fna_Budgets[j];
				if (tmpaccount==null||"".equals(tmpaccount)) tmpaccount="0";
                para = tmpfnabudgetinfoid + separator
                        + tmpbudgetperiods + separator
                        + (j + 1) + separator
                        + tmpfnabudgettypeid + separator
                        + "" + separator
                        + "" + separator
                        + "" + separator
                        + tmpaccount + separator
                        + "";
                //if (tmpaccount!=null&&!"".equals(tmpaccount)&&Util.getDoubleValue(tmpaccount) > 0d)
                    RecordSet.executeProc("FnaBudgetInfoDetail_Insert", para);
            }
        }

        response.sendRedirect("FnaBudgetTypeView.jsp?fnabudgetinfoid=" + fnabudgetinfoid + "&fnabudgettypeid=" + tmpfnabudgettypeid);
    }
%>

