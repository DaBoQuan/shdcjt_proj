    <%@ page language="java" contentType="text/html; charset=GBK" %>
    <%@ page import="java.security.*,weaver.general.Util" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="weaver.general.SessionOper" %>
    <%@ include file="/systeminfo/init.jsp" %>
    <%@ include file="/hrm/performance/common.jsp" %>
    <jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsf" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsk" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rse" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="rsd" class="weaver.conn.RecordSet" scope="page" />
    <jsp:useBean id="check" class="weaver.hrm.performance.targetcheck.CheckInfo" scope="page" />
    <jsp:useBean id="delalert" class="weaver.hrm.performance.DelAlertInfo" scope="page" />
    <jsp:useBean id="report" class="weaver.hrm.performance.targetreport.ReportInfo" scope="page" />
    <jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
    <jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
    <jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
    <%
    
  
    String operationType=Util.null2String(request.getParameter("operationType"));

    //��������
    
    if (operationType.equals("check")){
    String groupId="";
    String[] status=request.getParameterValues("status");
    String[] pers=request.getParameterValues("percent_n");
    String[] pointSelf=request.getParameterValues("pointSelf");
    String[] planIds=request.getParameterValues("planIds");
    String planDate=Util.null2String(request.getParameter("planDate"));
    String type=Util.null2String(request.getParameter("type"));
    String rName=Util.fromScreen(request.getParameter("rName"),user.getLanguage());
    String pName=Util.fromScreen(request.getParameter("pName"),user.getLanguage());
    String objId=""+SessionOper.getAttribute(session,"hrm.objId");
    String type_d=""+SessionOper.getAttribute(session,"hrm.type_d");//��������������
    String logs=Util.null2String(request.getParameter("reportLog"));
    String docids=Util.null2String(request.getParameter("docid"));
    String id="";
    String postId=ResourceComInfo.getJobTitle(objId);//�õ���λid
    if (type.equals("3")||check.getCheckType(type_d,objId,type,postId,user,"0","0")||check.getCheckType(type_d,objId,type,postId,user,"0","1")||check.getCheckType(type_d,objId,type,postId,user,"1","0")||check.getCheckType(type_d,objId,type,postId,user,"2","0"))
    {
    rse.execute("select * from HrmPerformanceReportLog where cycle='"+type+"' and reportDate='"+planDate+"' and reportType='"+type_d+"' and objId="+objId);

    if (rse.next())
    {
    groupId=rse.getString("id");
    rs.execute("update HrmPerformanceReportLog set reportLog='"+logs+"' where id="+groupId);
    }
    else
    {
    groupId=report.getMaxID("reportlogid");
    rs.execute("insert into HrmPerformanceReportLog (id,reportName,reportLog,reportType,reportDate,cycle,objId) values("+groupId+",'"+pName+"','"+logs+"','"+type_d+"','"+planDate+"','"+type+"',"+objId+")");
    //ɾ��������Ϣ
    if (type_d.equals("3"))
    delalert.delAlert(Util.getIntValue(objId),type,planDate,2,"3");
    }
    if (planIds!=null)
    {
    for (int i=0;i<planIds.length;i++)
    {
    
    String planId=planIds[i];
  
    id=report.getMaxID("reportid");
    rs.execute("delete  from HrmPerformanceReport where planId="+planId);
    rs.execute("insert into HrmPerformanceReport(id,reportGroupId,planId,objId,cycle,allShare,reportDate,reportType,status,percent_n,pointSelf,reportTypep) values("+id+","+groupId+","+planId+","+objId+",'"+type+"','1','"+planDate+"','"+type_d+"','"+status[i]+"','"+Util.null2o(pers[i])+"','"+pointSelf[i]+"','0')" );
    }
    
    }
    if (!docids.equals(""))
    {
    rse.execute("select * from HrmPerformanceReport where cycle='"+type+"' and reportDate='"+planDate+"' and reportType='"+type_d+"' and objId="+objId+" and reportTypep='1' ");
    //out.print("select * from HrmPerformanceReport where cycle='"+type+"' and reportDate='"+planDate+"' and reportType='"+type_d+"' and objId="+objId+" and reportTypep='1' ");
    if (rse.next())
    {
    String gId=rse.getString("id");
    rs.execute("update HrmPerformanceReport set docId='"+docids+"' where id="+gId);
    }
    else
    {
    id=report.getMaxID("reportid");
    rs.execute("insert into HrmPerformanceReport (id,reportGroupId,objId,cycle,allShare,reportDate,reportType,reportTypep,docId) values("+id+","+groupId+","+objId+",'"+type+"','1','"+planDate+"','"+type_d+"','1','"+docids+"')");
    //out.print("insert into HrmPerformanceReport (id,reportGroupId,objId,cycle,allShare,reportDate,reportType,reportTypep) values("+id+","+groupId+","+objId+",'"+type+"','1','"+planDate+"','"+type_d+"','1')");
    }
    }
    
    //�Զ����ɿ�������
    //���ݿ��˷������ɶ����������
    

    //int flowId=0;
    //String requestName="";
    int requestId=0;
    
    
  
    if (!type.equals("3"))  //�ܱ��治�ÿ���
    { 
    try{
    check.getCheck(type_d,objId,type,postId,user,rName,"0","0",planDate);
    check.getCheck(type_d,objId,type,postId,user,rName,"0","1",planDate);
    check.getCheck(type_d,objId,type,postId,user,rName,"1","0",planDate);
    if (type_d.equals("3"))
    check.getCheck(type_d,objId,type,postId,user,rName,"2","0",planDate);
    
    }catch(Exception e){
            rs.execute("delete  from HrmPerformanceReportLog where cycle='"+type+"' and reportDate='"+planDate+"' and reportType='"+type_d+"' and objId="+objId);
            rs.execute("delete  from HrmPerformanceReport where cycle='"+type+"' and reportDate='"+planDate+"' and reportType='"+type_d+"' and objId="+objId);
			out.println("<div style='color:red;font-size:12px'>"+SystemEnv.getHtmlLabelName(16333,user.getLanguage())+"!</div>");
			return;
		}
    }
    out.print("<script>history.back(-1);</script>");
    }
    else
    {
    out.print("<script>alert('"+SystemEnv.getHtmlLabelName(18268,user.getLanguage())+"');history.back(-1);</script>");
    }
    }
    
     
    //���δ��
    
     if (operationType.equals("checkDown")){
       String[] planIds=request.getParameterValues("planIdDown");
       String[] points=request.getParameterValues("pointDown");
       for (int i=0;i<planIds.length;i++)
       {
       rs.execute("select * from HrmPerformanceBeforePoint where planId="+planIds[i]);
       if (!rs.next())
       {
       rse.execute("insert into HrmPerformanceBeforePoint values("+planIds[i]+",'"+points[i]+"')");
       }
       else
       {float point=Util.getFloatValue(rs.getString("point1"),0);
        point=point/2+Util.getFloatValue(points[i])/2;
        rse.execute("update  HrmPerformanceBeforePoint set point1='"+point+"' where planId="+planIds[i]);
       }
       
       }
       out.print("<script>history.back(-1);</script>");
    }
    
    %>
 