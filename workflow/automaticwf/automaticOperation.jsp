<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%
if(!HrmUserVarify.checkUserRight("OutDataInterface:Setting",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}

String operate = Util.null2String(request.getParameter("operate"));

if(operate.equals("add")){
    String setname = Util.null2String(request.getParameter("setname"));//����
    String workFlowId = Util.null2String(request.getParameter("workFlowId"));//����id
    String datasourceid = Util.null2String(request.getParameter("datasourceid"));//����Դ
    String outermaintable = Util.null2String(request.getParameter("outermaintable"));//�ⲿ����
    String outermainwhere = Util.null2String(request.getParameter("outermainwhere"));//�ⲿ��������
    String successback = Util.null2String(request.getParameter("successback"));//���̴����ɹ�ʱ��д����
    String failback = Util.null2String(request.getParameter("failback"));//���̴���ʧ��ʱ��д����
    int detailcount = Util.getIntValue(Util.null2String(request.getParameter("detailcount")),0);//��ϸ����
    String outerdetailtables = "";//�ⲿ��ϸ����
    String outerdetailwheres = "";//�ⲿ��ϸ����������
    for(int i=0;i<detailcount;i++){
        String tempouterdetailname = Util.null2String(request.getParameter("outerdetailname"+i));
        String tempouterdetailwhere = Util.null2String(request.getParameter("outerdetailwhere"+i));
        if(tempouterdetailname.equals("")) tempouterdetailname = "-";
        if(tempouterdetailwhere.equals("")) tempouterdetailwhere = "-";
        if(i<(detailcount-1)){
            outerdetailtables += tempouterdetailname + ",";
            outerdetailwheres += tempouterdetailwhere + ",";
        }else{
            outerdetailtables += tempouterdetailname;
            outerdetailwheres += tempouterdetailwhere;
        }
    }
    setname = Util.replace(setname,"'","''",0);
    outermaintable = Util.replace(outermaintable,"'","''",0);
    outermainwhere = Util.replace(outermainwhere,"'","''",0);
    successback = Util.replace(successback,"'","''",0);
    failback = Util.replace(failback,"'","''",0);
    outerdetailtables = Util.replace(outerdetailtables,"'","''",0);
    outerdetailwheres = Util.replace(outerdetailwheres,"'","''",0);
    String insertSql = "insert into outerdatawfset("+
                       "setname,"+
                       "workflowid,"+
                       "outermaintable,"+
                       "outermainwhere,"+
                       "successback,"+
                       "failback,"+
                       "outerdetailtables,"+
                       "outerdetailwheres,"+
                       "datasourceid) values("+
                       "'"+setname+"',"+
                       ""+workFlowId+","+
                       "'"+outermaintable+"',"+
                       "'"+outermainwhere+"',"+
                       "'"+successback+"',"+
                       "'"+failback+"',"+
                       "'"+outerdetailtables+"',"+
                       "'"+outerdetailwheres+"',"+
                       "'"+datasourceid+"'"+
                       ")";
    //System.out.println("insertSql=="+insertSql);
    RecordSet.executeSql(insertSql);
    String viewid = "";
    RecordSet.executeSql("select max(id) from outerdatawfset");
    if(RecordSet.next()) viewid = RecordSet.getString(1);
    response.sendRedirect("automaticsettingView.jsp?viewid="+viewid);
}else if(operate.equals("edit")){
    String viewid = Util.null2String(request.getParameter("viewid"));//keyid
    
    String setname = Util.null2String(request.getParameter("setname"));//����
    String workflowid = Util.null2String(request.getParameter("workFlowId"));//����id
    String datasourceid = Util.null2String(request.getParameter("datasourceid"));//����Դ
    String outermaintable = Util.null2String(request.getParameter("outermaintable"));//�ⲿ����
    String outermainwhere = Util.null2String(request.getParameter("outermainwhere"));//�ⲿ��������
    String successback = Util.null2String(request.getParameter("successback"));//���̴����ɹ�ʱ��д����
    String failback = Util.null2String(request.getParameter("failback"));//���̴���ʧ��ʱ��д����
    int detailcount = Util.getIntValue(Util.null2String(request.getParameter("detailcount")),0);//��ϸ����
    String outerdetailtables = "";//�ⲿ��ϸ����
    String outerdetailwheres = "";//�ⲿ��ϸ����������
    for(int i=0;i<detailcount;i++){
        String tempouterdetailname = Util.null2String(request.getParameter("outerdetailname"+i));
        String tempouterdetailwhere = Util.null2String(request.getParameter("outerdetailwhere"+i));
        if(tempouterdetailname.equals("")) tempouterdetailname = "-";
        if(tempouterdetailwhere.equals("")) tempouterdetailwhere = "-";
        if(i<(detailcount-1)){
            outerdetailtables += tempouterdetailname + ",";
            outerdetailwheres += tempouterdetailwhere + ",";
        }else{
            outerdetailtables += tempouterdetailname;
            outerdetailwheres += tempouterdetailwhere;
        }
    }
    
    String oldworkflowid = "";
    RecordSet.executeSql("select workflowid from outerdatawfset where id="+viewid);
    if(RecordSet.next()){
        oldworkflowid = RecordSet.getString("workflowid");
        if(!oldworkflowid.equals(workflowid)){
             //�����ѱ����ɾ����ϸ�������ݡ�
             RecordSet.executeSql("delete from outerdatawfsetdetail where mainid="+viewid);
        }
    }
    
    setname = Util.replace(setname,"'","''",0);
    outermaintable = Util.replace(outermaintable,"'","''",0);
    outermainwhere = Util.replace(outermainwhere,"'","''",0);
    successback = Util.replace(successback,"'","''",0);
    failback = Util.replace(failback,"'","''",0);
    outerdetailtables = Util.replace(outerdetailtables,"'","''",0);
    outerdetailwheres = Util.replace(outerdetailwheres,"'","''",0);
    String updateSql = "update outerdatawfset set "+
                       "setname='"+setname+"',"+
                       "workflowid='"+workflowid+"',"+
                       "outermaintable='"+outermaintable+"',"+
                       "outermainwhere='"+outermainwhere+"',"+
                       "successback='"+successback+"',"+
                       "failback='"+failback+"',"+
                       "outerdetailtables='"+outerdetailtables+"',"+
                       "outerdetailwheres='"+outerdetailwheres+"',"+
                       "datasourceid='"+datasourceid+"' "+
                       "where id="+viewid;
    //System.out.println("updateSql=="+updateSql);
    RecordSet.executeSql(updateSql);                  
    response.sendRedirect("automaticsettingView.jsp?viewid="+viewid);
}else if(operate.equals("adddetail")){
    String viewid = Util.null2String(request.getParameter("viewid"));//keyid 
    int fieldscount = Util.getIntValue(Util.null2String(request.getParameter("fieldscount")),0);//�ֶ�����
    
    RecordSet.executeSql("delete from outerdatawfsetdetail where mainid="+viewid);//��ɾ��
    for(int i=1;i<=fieldscount;i++){
        int wffieldid = Util.getIntValue(Util.null2String(request.getParameter("fieldid_index_"+i)),-1);
        String wffieldname = Util.null2String(request.getParameter("fieldname_index_"+i));
        int wffieldhtmltype = Util.getIntValue(Util.null2String(request.getParameter("fieldhtmltype_index_"+i)),-1);
        int wffieldtype = Util.getIntValue(Util.null2String(request.getParameter("fieldtype_index_"+i)),-1);
        String wffielddbtype = Util.null2String(request.getParameter("fielddbtype_index_"+i));
        String outerfieldname = Util.null2String(request.getParameter("outerfieldname_index_"+i));
        int iswriteback = Util.getIntValue(Util.null2String(request.getParameter("iswriteback_"+i)),0);
        
        int changetype = 0;
        if( wffieldhtmltype==3&&(wffieldtype==1||wffieldtype==4||wffieldtype==164) ){
            //��������Դ����򣬵���������򣬵��ֲ���������ת������
            changetype = Util.getIntValue(Util.null2String(request.getParameter("rulesopt_"+i)),0);
            if(changetype==5){//ѡ���˹̶��Ĵ�����
                outerfieldname = Util.null2String(request.getParameter("hrmid"));
            }
        }
        String insertSql = "insert into outerdatawfsetdetail("+
                           "mainid,"+
                           "wffieldid,"+
                           "wffieldname,"+
                           "wffieldhtmltype,"+
                           "wffieldtype,"+
                           "wffielddbtype,"+
                           "outerfieldname,"+
                           "changetype,"+
                           "iswriteback) values("+
                           viewid+","+
                           wffieldid+","+
                           "'"+wffieldname+"',"+
                           wffieldhtmltype+","+
                           wffieldtype+","+
                           "'"+wffielddbtype+"',"+
                           "'"+outerfieldname+"',"+
                           changetype+","+
                           iswriteback+")";
                           
         RecordSet.executeSql(insertSql);
    }
    
    response.sendRedirect("automaticsettingView.jsp?viewid="+viewid);
}

%>