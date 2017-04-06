<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.file.FileManage"%>
<%@ page import="weaver.conn.ConnStatement"%>
<%@ page import="java.math.BigDecimal"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CompensationTargetMaint" class="weaver.hrm.finance.compensation.CompensationTargetMaint" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<%
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");

FileUpload fu = new FileUpload(request,false);
FileManage fm = new FileManage();
String msg3="";
String msg4="";
String option=Util.null2String(fu.getParameter("option"));
int detachable=Util.getIntValue((String)session.getAttribute("detachable"));
int subcompanyid=Util.getIntValue(fu.getParameter("subcompanyid"));
int departmentid=Util.getIntValue(fu.getParameter("departmentid"));
String CompensationYear=fu.getParameter("CompensationYear");
String CompensationMonth=fu.getParameter("CompensationMonth");
int targetsize = Util.getIntValue(fu.getParameter("targetsize")) ;
ArrayList targetidlist=new ArrayList();
for(int j=0;j<targetsize;j++){
String targetidstr="targetid"+j;
int Targetid=Util.getIntValue(fu.getParameter(targetidstr)) ;
targetidlist.add(Targetid+"");
}
//System.out.println(subcompanyid+"|"+departmentid+"|"+CompensationYear+"|"+CompensationMonth);
String Excelfilepath="";

int fileid = 0 ;
if(option.equals("loadfile")) {
try {
    fileid = Util.getIntValue(fu.uploadFiles("targetfile"),0);

    String filename = fu.getFileName();


    String sql = "select filerealpath from imagefile where imagefileid = "+fileid;
    RecordSet.executeSql(sql);
    String uploadfilepath="";
    if(RecordSet.next()) uploadfilepath =  RecordSet.getString("filerealpath");


 if(!uploadfilepath.equals("")){

        Excelfilepath = GCONST.getRootPath()+"hrm/finance/compensation/ExcelToDB"+File.separatorChar+filename ;
        fm.copy(uploadfilepath,Excelfilepath);
    }


String msg="";
String msg1="";
String msg2="";
int    msgsize=0;

CompensationTargetMaint.ExcelToDB(Excelfilepath,subcompanyid,departmentid,Util.getIntValue(CompensationYear),Util.getIntValue(CompensationMonth),targetidlist,user.getLanguage(),user.getUID());
msgsize=CompensationTargetMaint.getMsg1().size();
if(msgsize==0){
    msg="success";
    response.sendRedirect("CompensationTargetMaintEdit.jsp?isedit=1&subCompanyId="+subcompanyid+"&departmentid="+departmentid+"&CompensationYear="+CompensationYear+"&CompensationMonth="+CompensationMonth+"&msg="+msg);
}else{
    for (int i = 0; i <msgsize; i++){
    msg1=msg1+(String)CompensationTargetMaint.getMsg1().elementAt(i)+",";
    msg2=msg2+(String)CompensationTargetMaint.getMsg2().elementAt(i)+",";
    }
    fm.DeleteFile(Excelfilepath);
    response.sendRedirect("CompensationTargetMaintEdit.jsp?isedit=1&subCompanyId="+subcompanyid+"&departmentid="+departmentid+"&CompensationYear="+CompensationYear+"&CompensationMonth="+CompensationMonth+"&msg="+msg+"&msg1="+msg1+"&msg2="+msg2+"&msgsize="+msgsize);
}
}
catch(Exception e) {
}
}
if(option.equals("add")) {
    int rownum = Util.getIntValue(fu.getParameter("rownum")) ;

    ConnStatement statement=new ConnStatement();
    try{
        for(int i=0;i<rownum;i++){
            String Userid=Util.fromScreen3(fu.getParameter("Userid_"+i),user.getLanguage());
            String memo=Util.fromScreen3(fu.getParameter("memo_"+i),user.getLanguage());
            if(!Userid.trim().equals("")){
                //ɾ���е�����
                String sql="delete from HRM_CompensationTargetDetail where exists(select 1 from HRM_CompensationTargetInfo where HRM_CompensationTargetDetail.CompensationTargetid=id and CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth)+" and Userid="+Util.getIntValue(Userid)+")";
                statement.setStatementSql(sql);
                statement.executeUpdate();
                sql="delete from HRM_CompensationTargetInfo where Userid="+Userid+" and CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth);
                statement.setStatementSql(sql);
                statement.executeUpdate();
                //�������ݿ�
                sql="INSERT INTO HRM_CompensationTargetInfo(subcompanyid,departmentid,CompensationYear,CompensationMonth,Userid,memo) values(?,?,?,?,?,?)";
                statement.setStatementSql(sql);
                statement.setInt(1,Util.getIntValue(DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(Userid))));
                statement.setInt(2,Util.getIntValue(ResourceComInfo.getDepartmentID(Userid)));
                statement.setInt(3,Util.getIntValue(CompensationYear));
                statement.setInt(4,Util.getIntValue(CompensationMonth));
                statement.setInt(5,Util.getIntValue(Userid));
                statement.setString(6,memo);
                statement.executeUpdate();
                sql="select id from HRM_CompensationTargetInfo where CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth)+" and Userid="+Util.getIntValue(Userid);
                statement.setStatementSql(sql);
                statement.executeQuery();
                if(statement.next()){
                    int id=statement.getInt(1);
                    for(int j=0;j<targetsize;j++){
                        String targetstr="target"+j+"_"+i;
                        String Target=Util.null2String(fu.getParameter(targetstr)) ;
                        if(Target.equals("")) Target="0";
                        int Targetid=Util.getIntValue((String)targetidlist.get(j)) ;
                        sql="INSERT INTO HRM_CompensationTargetDetail(CompensationTargetid,Targetid,Target) values(?,?,?)";
                        statement.setStatementSql(sql);
                        statement.setInt(1,id);
                        statement.setInt(2,Targetid);
                        statement.setString(3,Target);
                        statement.executeUpdate();
                    }
                }
            }
        }
    }catch(Exception e){
        e.printStackTrace();
    }finally{
        statement.close();
    }
    response.sendRedirect("CompensationTargetMaintEdit.jsp?isedit=1&subCompanyId="+subcompanyid+"&departmentid="+departmentid+"&CompensationYear="+CompensationYear+"&CompensationMonth="+CompensationMonth+"&msg3="+msg3+"&msg4="+msg4);
}
if(option.equals("edit")) {
    int rownum = Util.getIntValue(fu.getParameter("rownum")) ;

    ConnStatement statement=new ConnStatement();
    try{
        //ɾ��ԭ��ָ������
        String sql="";
        /*sql="delete from HRM_CompensationTargetDetail where CompensationTargetid in(select id from HRM_CompensationTargetInfo where subcompanyid="+subcompanyid+" and departmentid="+departmentid+" and CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth)+")";
        statement.setStatementSql(sql);
        statement.executeUpdate();
        sql="delete from HRM_CompensationTargetInfo where subcompanyid="+subcompanyid+" and departmentid="+departmentid+" and CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth);
        statement.setStatementSql(sql);
        statement.executeUpdate();
        */
        for(int i=0;i<rownum;i++){
            String Userid=Util.fromScreen3(fu.getParameter("Userid_"+i),user.getLanguage());
            String memo=Util.fromScreen3(fu.getParameter("memo_"+i),user.getLanguage());
            if(!Userid.trim().equals("")){
                //��ѯ���ݿ��Ƿ����и��û�
                sql="select id from HRM_CompensationTargetInfo where CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth)+" and Userid="+Util.getIntValue(Userid);
                statement.setStatementSql(sql);
                statement.executeQuery();
                if(statement.next()){
                    //����
                    int id=statement.getInt(1);
                    sql="update HRM_CompensationTargetInfo set subcompanyid=?,departmentid=?,memo=? where CompensationYear=? and CompensationMonth=? and Userid=?";
                    statement.setStatementSql(sql);
                    statement.setInt(1,Util.getIntValue(DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(Userid))));
                    statement.setInt(2,Util.getIntValue(ResourceComInfo.getDepartmentID(Userid)));
                    statement.setString(3,memo);
                    statement.setInt(4,Util.getIntValue(CompensationYear));
                    statement.setInt(5,Util.getIntValue(CompensationMonth));
                    statement.setInt(6,Util.getIntValue(Userid));
                    statement.executeUpdate();
                    for(int j=0;j<targetsize;j++){
                        String targetstr="target"+j+"_"+i;
                        String Target=Util.null2String(fu.getParameter(targetstr)) ;
                        if(Target.equals("")) Target="0";
                        int Targetid=Util.getIntValue((String)targetidlist.get(j)) ;
                        sql="select CompensationTargetid from HRM_CompensationTargetDetail where CompensationTargetid=? and Targetid=?";
                        statement.setStatementSql(sql);
                        statement.setInt(1,id);
                        statement.setInt(2,Targetid);
                        statement.executeQuery();
                        if(statement.next()){
                            sql="update HRM_CompensationTargetDetail set Target=? where CompensationTargetid=? and Targetid=?";
                            statement.setStatementSql(sql);
                            statement.setString(1,Target);
                            statement.setInt(2,id);
                            statement.setInt(3,Targetid);
                            statement.executeUpdate();
                        }else{
                            sql="INSERT INTO HRM_CompensationTargetDetail(CompensationTargetid,Targetid,Target) values(?,?,?)";
                            statement.setStatementSql(sql);
                            statement.setInt(1,id);
                            statement.setInt(2,Targetid);
                            statement.setString(3,Target);
                            statement.executeUpdate();
                        }
                    }
                }else{
                    //�������ݿ�
                    sql="INSERT INTO HRM_CompensationTargetInfo(subcompanyid,departmentid,CompensationYear,CompensationMonth,Userid,memo) values(?,?,?,?,?,?)";
                    statement.setStatementSql(sql);
                    statement.setInt(1,Util.getIntValue(DepartmentComInfo.getSubcompanyid1(ResourceComInfo.getDepartmentID(Userid))));
                    statement.setInt(2,Util.getIntValue(ResourceComInfo.getDepartmentID(Userid)));
                    statement.setInt(3,Util.getIntValue(CompensationYear));
                    statement.setInt(4,Util.getIntValue(CompensationMonth));
                    statement.setInt(5,Util.getIntValue(Userid));
                    statement.setString(6,memo);
                    statement.executeUpdate();
                    sql="select id from HRM_CompensationTargetInfo where CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth)+" and Userid="+Util.getIntValue(Userid);
                    statement.setStatementSql(sql);
                    statement.executeQuery();
                    if(statement.next()){
                        int id=statement.getInt(1);
                        for(int j=0;j<targetsize;j++){
                            String targetstr="target"+j+"_"+i;
                            String Target=Util.null2String(fu.getParameter(targetstr)) ;
                            if(Target.equals("")) Target="0";
                            int Targetid=Util.getIntValue((String)targetidlist.get(j)) ;
                            sql="select CompensationTargetid from HRM_CompensationTargetDetail where CompensationTargetid=? and Targetid=?";
                            statement.setStatementSql(sql);
                            statement.setInt(1,id);
                            statement.setInt(2,Targetid);
                            statement.executeQuery();
                            if(statement.next()){
                                sql="update HRM_CompensationTargetDetail set Target=? where CompensationTargetid=? and Targetid=?";
                                statement.setStatementSql(sql);
                                statement.setString(1,Target);
                                statement.setInt(2,id);
                                statement.setInt(3,Targetid);
                                statement.executeUpdate();
                            }else{
                                sql="INSERT INTO HRM_CompensationTargetDetail(CompensationTargetid,Targetid,Target) values(?,?,?)";
                                statement.setStatementSql(sql);
                                statement.setInt(1,id);
                                statement.setInt(2,Targetid);
                                statement.setString(3,Target);
                                statement.executeUpdate();
                            }
                        }
                    }
                }
            }
        }
    }catch(Exception e){
        e.printStackTrace();
    }finally{
        statement.close();
    }
    response.sendRedirect("CompensationTargetMaintEdit.jsp?isedit=1&subCompanyId="+subcompanyid+"&departmentid="+departmentid+"&CompensationYear="+CompensationYear+"&CompensationMonth="+CompensationMonth+"&msg3="+msg3+"&msg4="+msg4);
}
if(option.equals("delete")) {
    ConnStatement statement=new ConnStatement();
    try{
        String subcomidstr="";
        String sql="delete from HRM_CompensationTargetDetail where CompensationTargetid in(select id from HRM_CompensationTargetInfo where CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth);
        String sql1="delete from HRM_CompensationTargetInfo where CompensationYear="+Util.getIntValue(CompensationYear)+" and CompensationMonth="+Util.getIntValue(CompensationMonth);
        if(subcompanyid>0){
            String allrightcompany = SubCompanyComInfo.getRightSubCompany(user.getUID(), "Compensation:Maintenance", 0);
            ArrayList allrightcompanyid = Util.TokenizerString(allrightcompany, ",");
            subcomidstr = SubCompanyComInfo.getRightSubCompanyStr1("" + subcompanyid, allrightcompanyid);
        }
        if(departmentid>0){
            sql+=" and departmentid="+departmentid+")";
            sql1+=" and departmentid="+departmentid;
        }else{
            sql+=" and subcompanyid in("+subcomidstr+"))";
            sql1+=" and subcompanyid in("+subcomidstr+")";
        }
        statement.setStatementSql(sql);
        statement.executeUpdate();
        statement.setStatementSql(sql1);
        statement.executeUpdate();
    }catch(Exception e){
        e.printStackTrace();
    }finally{
        statement.close();
    }
    response.sendRedirect("CompensationTargetMaint.jsp?subCompanyId="+subcompanyid+"&departmentid="+departmentid);
}
%>
