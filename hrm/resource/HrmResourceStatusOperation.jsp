<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.finance.SalaryManager" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.RecordSetTrans" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="SysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="dci" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="LN" class="ln.LN" scope="page" />
<jsp:useBean id="OrganisationCom" class="weaver.rtx.OrganisationCom" scope="page" />
<jsp:useBean id="poppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>

<%
String tempresourceid = Util.null2String(request.getParameter("resourceid"));
String resourceids[] = null ;
if(!tempresourceid.equals("")) resourceids = Util.TokenizerString2(tempresourceid,",") ;

String changedate = Util.fromScreen(request.getParameter("changedate"),user.getLanguage());
String changeenddate = Util.fromScreen(request.getParameter("changeenddate"),user.getLanguage());
String changereason= Util.fromScreenVoting(request.getParameter("changereason"),user.getLanguage());
String changecontractid = Util.fromScreen(request.getParameter("changecontractid"),user.getLanguage());
String oldjobtitleid = Util.fromScreen(request.getParameter("oldjobtitle"),user.getLanguage());
String oldjoblevel = Util.fromScreen(request.getParameter("oldjoblevel"),user.getLanguage());
String newjobtitleid = Util.fromScreen(request.getParameter("newjobtitle"),user.getLanguage());
String newjoblevel = Util.fromScreen(request.getParameter("newjoblevel"),user.getLanguage());
String infoman = Util.fromScreen(request.getParameter("infoman"),user.getLanguage());
String ischangesalary = Util.fromScreen(request.getParameter("ischangesalary"),user.getLanguage());
String status = Util.fromScreen(request.getParameter("status"),user.getLanguage());
String managerid = Util.fromScreen(request.getParameter("managerid"),user.getLanguage());
String type = "0";

String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());
String para = "";
char separator = Util.getSeparator() ;

String CurrentUser = ""+user.getUID();
String CurrentUserName = ""+user.getUsername();
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);

String accepter="";
String title="";
String remark="";
String submiter="";
String subject="";
String backurl = "" ;

if( resourceids != null ) {

    if(operation.equalsIgnoreCase("fire")){  //��Ƹ
        type = "1";
        backurl = "HrmResourceFire.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changereason+separator+changecontractid+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            boolean flag=rs.executeProc("HrmResource_Fire",para);
            //delete by chengfeng.han 2011-7-18 27152 ɾ��Ȩ�޺��ֻ��û���Ӧ����������Ӧ���ڶ�ʱ�����д���
            //if(flag){
            //    rs.executeSql("delete from hrmrolemembers where resourceid="+id);
                //ɾ���ֻ��������õĵ�¼��Ա
            //    rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
            //}
            //end
            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16119,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title = SystemEnv.getHtmlLabelName(16119,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
            	//add by chengfeng.han 2011-7-18 27152 �����ְ���ں͵�ǰ���ڱȽ�С�ڵ���1�죬������ִ����ְ����ش���
                rs.executeSql("delete from hrmrolemembers where resourceid="+id);
	                //ɾ���ֻ��������õĵ�¼��Ա
	            rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
	            //end
                String sql = "update HrmResource set status = 4 , loginid='',password='',account='' where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }

            OrganisationCom.checkUser(Integer.parseInt(id));
            OrganisationCom.deleteUser2(ResourceComInfo.getLoginID(id));//��Ա��ְ��RTX��ɾ������Ա
            
        }
    }
    else if(operation.equalsIgnoreCase("hire")){
        type =  "2";
        backurl = "HrmResourceHire.jsp" ;

        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changereason+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            rs.executeProc("HrmResource_Hire",para);

            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16120,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16120,user.getLanguage());
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
                String sql = "update HrmResource set status = 1 where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }
            OrganisationCom.checkUser(Integer.parseInt(id));
            
        }
    }

    else if(operation.equalsIgnoreCase("extend")){
        type=  "3";
        backurl = "HrmResourceExtend.jsp" ;

        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);
            //check user num
            boolean canSave = false;
            if(LN.CkHrmnum()<0){
                    canSave = true;
            }
            String sqluser = "select status from HrmResource where id = "+id;
            rs.executeSql(sqluser);
            rs.next();
            int userstatus = rs.getInt(1);
            if(userstatus==0||userstatus==1||userstatus==2||userstatus==3){
                canSave = true;
            }
            if(ResourceComInfo.getLoginID(id).equals("")){
                canSave = true;
            }

            if(!canSave){
               response.sendRedirect("/hrm/resource/HrmResourceExtend.jsp?errmsg=1");
               return;
            }

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changeenddate+separator+
                   changereason+separator+changecontractid+separator+infoman+separator+oldjobtitleid+separator+type+separator+status+separator+user.getUID();
            rs.executeProc("HrmResource_Extend",para);
			String contracttypeid = "";
			String idType = "";
			String contracttypeidsql = "select * from HrmContract where ContractMan ="+id;
			rs.executeSql(contracttypeidsql);
			while(rs.next()){
				contracttypeid = rs.getString("contracttypeid");
				String ishirecontractsql = "select * from HrmContracttype where ishirecontract = 1 and id ="+contracttypeid;
				rs2.executeSql(ishirecontractsql);
				while(rs2.next()){
					  idType = rs2.getString("id");
					  //System.out.println("idType:"+idType);
					  String sqloo = "";
					  if(!"".equals(changecontractid)) {
						  sqloo = "UPDATE HrmContract SET contractenddate = '"+changeenddate+"' WHERE id = "+changecontractid+"and contractman = "+id+" and contracttypeid = "+idType+"";
					  } else {
						  sqloo = "UPDATE HrmContract SET contractenddate = '"+changeenddate+"' WHERE contractman = "+id+" and contracttypeid = "+idType+"";
					  }
					  rs.executeSql(sqloo);	
			    
				}
				
		}
		
            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16121,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16121,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
				//TD8237
				if(!status.equals("0")){
                String sql = "update HrmResource set status ="+status+" where id = "+id;
				//System.out.println("sql----"+sql);
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
				}else{
					String sql = "update HrmResource set status =2 where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
				}
            }
            OrganisationCom.checkUser(Integer.parseInt(id));
        }
    }

    else if(operation.equalsIgnoreCase("redeploy")){
        type =  "4";
        int depid = Util.getIntValue(Util.null2String(request.getParameter("departmentid")),0);
        backurl = "HrmResourceRedeploy.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);
			String olddepartmentid = "";
			String oldmanagerid = "";
			String oldseclevel = "";
			String oldmanagerstr = "";
			rs.executeSql("select departmentid, managerid, seclevel, managerstr  from HrmResource where id=" + Util.getIntValue(id));
			while(rs.next()){
				olddepartmentid = rs.getString("departmentid");
				oldmanagerid = rs.getString("managerid");
				oldseclevel = rs.getString("seclevel");
				oldmanagerstr = rs.getString("managerstr");
			}
			String oldsubcompanyid1 = "-1";
			rs.executeSql("select subcompanyid1 from HrmDepartment where id=" + Util.getIntValue(olddepartmentid));
			while(rs.next()){
				oldsubcompanyid1 = rs.getString("subcompanyid1");
			}
			String subcmpanyid1 = "-1";;
			rs.executeSql("select subcompanyid1 from HrmDepartment where id=" + depid);
			while(rs.next()){
				subcmpanyid1 = rs.getString("subcompanyid1");
			}
			
			String tempmanagerid=managerid;
			if("".equals(managerid)){
				managerid = oldmanagerid;
			}
            para = ""+id+separator+changedate+separator+changereason+separator+oldjobtitleid+separator+oldjoblevel+
                   separator+newjobtitleid+separator+newjoblevel+separator+ infoman+separator+type+separator+ischangesalary
                   +separator+oldmanagerid+separator+managerid+separator+olddepartmentid+separator+depid+separator+oldsubcompanyid1+separator+subcmpanyid1+separator+user.getUID();

            rs.executeProc("HrmResource_Redeploy",para);

            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16122,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16122,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

           if(Util.dayDiff(CurrentDate,changedate)<=1){

                depid = Util.getIntValue(JobTitlesComInfo.getDepartmentid(newjobtitleid),0);
                String sql = "" ;
               /* String sql = "select id from HrmCostcenter where departmentid = "+depid+" order by id";
                rs.executeSql(sql);
                rs.next();
                int  costcenterid = Util.getIntValue(rs.getString("id"),0);*/
                int  costcenterid = 0;
				RecordSetTrans rst=new RecordSetTrans();
				rst.setAutoCommit(false);
				String managerstr = "";
				try{
					para = ""+id+separator+""+depid+separator+""+newjoblevel+separator+""+costcenterid+separator+""+newjobtitleid+separator+""+managerid;
					rst.executeProc("HrmResource_DepUpdate",para);
					subcmpanyid1 = dci.getSubcompanyid1(""+depid);
					para = ""+id+separator+subcmpanyid1;
					rst.executeProc("HrmResource_UpdateSubCom",para);
					
					if(!"".equals(tempmanagerid)){
						/*����managerstr*/
						if(!id.equals(tempmanagerid)){
							rs.executeSql("select managerstr from HrmResource where id = "+Util.getIntValue(managerid));
					        while(rs.next()){
					          managerstr = rs.getString("managerstr");
						      managerstr =","+managerid+managerstr; 
						      managerstr =managerstr.endsWith(",")?managerstr:(managerstr+",");
					        }
						}else{
				        	managerstr =","+managerid+",";
				        }
				        para = ""+id+separator+ managerstr;
				        rst.executeProc("HrmResource_UpdateManagerStr",para);
					}else
						managerstr=oldmanagerstr;

					String p_para = id + separator + depid + separator + subcmpanyid1 + separator + managerid + separator + oldseclevel + separator + managerstr + separator + olddepartmentid + separator + oldsubcompanyid1 + separator + oldmanagerid + separator + oldseclevel + separator + oldmanagerstr + separator + "1";

					//System.out.println(p_para);
					rst.executeProc("HrmResourceShare", p_para);
					  
					sql = "select max(id) from HrmStatusHistory";
					rst.executeSql(sql);
					rst.next();
					sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
					rst.executeSql(sql);

					rst.commit();
					
					boolean checkrtxuser = OrganisationCom.checkUser(Integer.parseInt(id));//����û��Ƿ����
					if(checkrtxuser){   //���ھͱ༭�������ھ�����
						OrganisationCom.editUser(Integer.parseInt(id));//�༭
					} else {
						OrganisationCom.addUser(Integer.parseInt(id));//����
					}
				}catch(Exception e){
					rst.rollback();
					e.printStackTrace();
				}

				/*����ֱ���¼��ͼ���¼� managerstr�ֶ� ��ʼ*/
				if(!"".equals(tempmanagerid)){
					String temOldmanagerstr=","+id +oldmanagerstr;
					temOldmanagerstr=temOldmanagerstr.endsWith(",")?temOldmanagerstr:(temOldmanagerstr+",");

			        sql = "select id,departmentid,subcompanyid1,managerid,seclevel,managerstr from HrmResource where managerstr like '%"+temOldmanagerstr+ "'";
			        rs.executeSql(sql);
			        
			        while(rs.next()){
						String nowmanagerstr = Util.null2String(rs.getString("managerstr"));
						String resourceid = rs.getString("id");
						//ָ���ϼ�Ϊ���������������������ϼ�
						if(id.equals(resourceid))
							continue;
						//String nowmanagerstr2 = Util.StringReplaceOnce(nowmanagerstr,oldmanagerstr ,managerstr);
						String nowmanagerstr2="";
						int index=nowmanagerstr.lastIndexOf(oldmanagerstr);
						if(index!=-1){
							if(!"".equals(managerstr)){
							   nowmanagerstr2=nowmanagerstr.substring(0,index)+("".equals(oldmanagerstr)?managerstr.substring(1):managerstr);
							}   
							else{
							   nowmanagerstr2=nowmanagerstr.substring(0,index)+("".equals(oldmanagerstr)?"":",");
							} 
							
						}
						String nowdepartmentid = rs.getString("departmentid");
						String nowsubcompanyid1 = rs.getString("subcompanyid1");
						String nowmanagerid = rs.getString("managerid");
						String nowseclevel = rs.getString("seclevel");
						rst=new RecordSetTrans();
						rst.setAutoCommit(false);
						try{
							para = resourceid + separator + nowmanagerstr2;
							rst.executeProc("HrmResource_UpdateManagerStr",para);

							para = resourceid + separator + nowdepartmentid + separator + nowsubcompanyid1 + separator + nowmanagerid + separator + nowseclevel + separator + nowmanagerstr2 + separator + nowdepartmentid + separator + nowsubcompanyid1 + separator + nowmanagerid + separator + nowseclevel + separator + nowmanagerstr + separator + "1";

							//System.out.println(p_para);
							rst.executeProc("HrmResourceShare", para);
							rst.commit();
						}catch(Exception e){
							rst.rollback();
							e.printStackTrace();
						}
			        }
				}
				/*����ֱ���¼��ͼ���¼� managerstr�ֶ� ����*/

                // �Ƿ���Ҫ���ʱ䶯���ж�  ����Ų������
            }
        }
    }
    else if(operation.equalsIgnoreCase("dismiss")){
        type =  "5";
        backurl = "HrmResourceDismiss.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changereason+separator+changecontractid+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            boolean flag=rs.executeProc("HrmResource_Dismiss",para);
            //delete by chengfeng.han 2011-7-18 27152 ɾ��Ȩ�޺��ֻ��û���Ӧ����������Ӧ���ڶ�ʱ�����д���
            //if(flag){
            //    rs.executeSql("delete from hrmrolemembers where resourceid="+id);
                //ɾ���ֻ��������õĵ�¼��Ա
            //    rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
            //}
            //end
            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16123,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16123,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }
            if(Util.dayDiff(CurrentDate,changedate)<=1){
                //add by chengfeng.han 2011-7-18 27152 �����ְ���ں͵�ǰ���ڱȽ�С�ڵ���1�죬������ִ����ְ����ش���
                rs.executeSql("delete from hrmrolemembers where resourceid="+id);
	                //ɾ���ֻ��������õĵ�¼��Ա
	            rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
	            //end
                String sql = "update HrmResource set status =5, loginid='',password='' ,account='' where id = "+id;
                rs.executeSql(sql);
                sql="delete hrmgroupmembers where userid="+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }
            OrganisationCom.checkUser(Integer.parseInt(id));
            OrganisationCom.deleteUser2(ResourceComInfo.getLoginID(id));//��Ա��ְ��RTX��ɾ������Ա
            
            //��ְʱ��ְ�߲��������Э��ȫ�����Ϊ�Ѷ� myq �޸� 2008.2.18 ��ʼ
            rs.executeSql("select id,readers from cowork_items where coworkers like '%"+id+"%' and readers not like '"+id+"%'");
          	while(rs.next()){
          		String cowork_id = Util.null2String(rs.getString(1));
          		String readers = Util.null2String(rs.getString(2));
          		if(!readers.equals("")){ readers = readers + id + ",";}
          		else{ readers = "," + id + ",";}
          		rs2.executeSql("update cowork_items set readers='"+readers+"' where id="+cowork_id);
            }
            //��ְʱ��ְ�߲��������Э��ȫ�����Ϊ�Ѷ� myq �޸� 2008.2.20 ����
        }
    }

    else if(operation.equalsIgnoreCase("retire")){
        type =  "6";
        backurl = "HrmResourceRetire.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changereason+separator+changecontractid+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            boolean flag=rs.executeProc("HrmResource_Retire",para);
            //delete by chengfeng.han 2011-7-18 27152 ɾ��Ȩ�޺��ֻ��û���Ӧ����������Ӧ���ڶ�ʱ�����д���
            //if(flag){
            //    rs.executeSql("delete from hrmrolemembers where resourceid="+id);
                //ɾ���ֻ��������õĵ�¼��Ա
            //    rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
            //}
            //end
            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16124,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16124,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
            	//add by chengfeng.han 2011-7-18 27152 �����ְ���ں͵�ǰ���ڱȽ�С�ڵ���1�죬������ִ����ְ����ش���
                rs.executeSql("delete from hrmrolemembers where resourceid="+id);
                //ɾ���ֻ��������õĵ�¼��Ա
            	rs.executeSql("delete from PluginLicenseUser where plugintype='mobile' and sharetype='0' and sharevalue='"+id+"'");
           		//end
                String sql = "update HrmResource set status =6, loginid='',password='',account='' where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }

            OrganisationCom.checkUser(Integer.parseInt(id));
            OrganisationCom.deleteUser2(ResourceComInfo.getLoginID(id));//��Ա��ְ��RTX��ɾ������Ա
        }
    }
    else if(operation.equalsIgnoreCase("rehire")){
        type =  "7";
        backurl = "HrmResourceRehire.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

          //check user num
            boolean canSave = false;
            if(LN.CkHrmnum()<0){
                    canSave = true;
            }
            String sqluser = "select status from HrmResource where id = "+id;
            rs.executeSql(sqluser);
            rs.next();
            int userstatus = rs.getInt(1);
            if(userstatus==0||userstatus==1||userstatus==2||userstatus==3){
                canSave = true;
            }
            if(ResourceComInfo.getLoginID(id).equals("")){
                canSave = true;
            }

            if(!canSave){
               response.sendRedirect("/hrm/resource/HrmResourceRehire.jsp?errmsg=1");
               return;
            }

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changeenddate+separator+
                   changereason+separator+changecontractid+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            rs.executeProc("HrmResource_Rehire",para);

            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(16125,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(16125,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
                String sql = "update HrmResource set status =1 where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }
            OrganisationCom.checkUser(Integer.parseInt(id));
        }
    }
    else if(operation.equalsIgnoreCase("try")){
        type =  "8";
        backurl = "HrmResourceTry.jsp" ;
        for(int i=0 ; i<resourceids.length; i++) {
            String id = Util.null2String(resourceids[i]) ;
            String name = ResourceComInfo.getResourcename(id);

          //check user num
            boolean canSave = false;
            if(LN.CkHrmnum()<0){
                canSave = true;
            }
            String sqluser = "select status from HrmResource where id = "+id;
            rs.executeSql(sqluser);
            rs.next();
            int userstatus = rs.getInt(1);
            if(userstatus != 2){
               response.sendRedirect("/hrm/resource/HrmResourceTry.jsp?errmsg=1");
               return;
            }

            oldjobtitleid = ResourceComInfo.getJobTitle(id);
            para = ""+id+separator+changedate+separator+changereason+separator+infoman+separator+oldjobtitleid+separator+type+separator+user.getUID();
            rs.executeProc("HrmResource_Try",para);

            if( !infoman.equals("")) {
                subject= SystemEnv.getHtmlLabelName(17514,user.getLanguage()) ;
                subject+=":"+name;
                  accepter = infoman;
                  title =  SystemEnv.getHtmlLabelName(17514,user.getLanguage()) ;
                  title += ":"+name;
                  title += "-"+CurrentUserName;
                  title += "-"+CurrentDate;
                  remark="<a href=/hrm/resource/HrmResource.jsp?id="+id+">"+Util.fromScreen2(subject,user.getLanguage())+"</a><br>"+SystemEnv.getHtmlLabelName(454,user.getLanguage())+":"+changereason;
                  submiter=CurrentUser;
                  SysRemindWorkflow.setPrjSysRemind(title,0,Util.getIntValue(submiter),accepter,remark);
            }

            if(Util.dayDiff(CurrentDate,changedate)<=1){
                String sql = "update HrmResource set status =0 where id = "+id;
                rs.executeSql(sql);
                sql = "select max(id) from HrmStatusHistory";
                rs.executeSql(sql);
                rs.next();
                sql = "update HrmStatusHistory set isdispose = 1 where id="+rs.getInt(1);
                rs.executeSql(sql);
            }
        }
    }

    for(int i=0 ; i<resourceids.length; i++) {
        String id = Util.null2String(resourceids[i]) ;
        ResourceComInfo.updateResourceInfoCache(id);

        // �Ƿ���Ҫ���ʱ䶯���ж�  ����Ų������
        if(ischangesalary.equals("1")){
            SalaryManager sm = new SalaryManager();
            sm.initResourceSalary(id);
        }
    }
}
//update popup message table
    int userid=user.getUID();                   //��ǰ�û�id
String logintype = user.getLogintype();     //��ǰ�û�����  1: ����û�  2:�ⲿ�û�
int usertype = 0;
if(logintype.equals("1")) usertype = 0;
if(logintype.equals("2")) usertype = 1;
if(resourceids!=null){
    for (int i = 0; i < resourceids.length; i++) {
        rs.executeSql("SELECT id FROM HrmRemindMsg where remindtype<5 and resourceid=" + resourceids[i]);
        while (rs.next()) {
            String id = rs.getString("id");
            poppupRemindInfoUtil.updatePoppupRemindInfo(userid, 7, (logintype).equals("1") ? "0" : "1", Util.getIntValue(id, 0));
        }
    }
}
response.sendRedirect(backurl);

%>