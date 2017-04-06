package weaver.hrm.webservices;

import java.util.Calendar;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.company.DepartmentComInfo;
import weaver.hrm.company.SubCompanyComInfo;
import weaver.hrm.job.JobTitlesComInfo;
 

public class HrmSyncServiceImpl extends BaseBean implements HrmSyncService {
	private BaseBean log = new BaseBean();
 
	public String userSync(String appID){
		String returnStr = "";
		String type="";
		String subComInfo = SynSubCompany(); //ͬ���ֲ�
		String deptInfo = SynDept();       //ͬ������
		String jobTitleInfo = SynJobTitles();  //ͬ����λ
		String hrmInfo = synHrmResource(appID);//ͬ����Ա
		if(subComInfo.indexOf("ʧ��")>0||deptInfo.indexOf("ʧ��")>0||jobTitleInfo.indexOf("ʧ��")>0||hrmInfo.indexOf("ʧ��")>0){
			type="1";
		}else{
			type="0";
		}
		returnStr = "{\""+type+"\",\""+subComInfo+","+deptInfo+","+jobTitleInfo+","+hrmInfo+"\"}";
		return returnStr;
	}
	
	public String SynSubCompany() {
		String returnStr = "";
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			RecordSet synrs = new RecordSet();
			RecordSetDataSource hrrs = new RecordSetDataSource("hr");
			String synts = "";
			synrs.executeSql("select * from hrm_ncsynts where id=1");
	        if (synrs.next()) {
	            synts = Util.null2String(synrs.getString("synts"));
	            if (synts.length() <= 0) {
	                  synts = "2000-01-01 00:00:00";
	            }
	        }
			String sql = "select id,companyid,subcompanyname,subcompanydesc,status,modifydate from HrmSubCompany where modifydate >= to_date('" + synts + "','yyyy-mm-dd HH24:mi:ss') order by modifydate desc";
			hrrs.executeSql(sql); 
		    while(hrrs.next()){
		    	
		    	String code = Util.null2String(hrrs.getString("id"));
				String shortname = Util.null2String(hrrs.getString("subcompanyname"));
				String fullname = Util.null2String(hrrs.getString("subcompanydesc"));
				try {
				String parent_code = Util.null2String(hrrs.getString("companyid"));
				String supsubcomid = "0";				
				rs.executeSql("select id from HrmSubCompany where hrpkcode = '"+code+"'");
				if(!rs.next()) {  //�����ھ�����
                     //��ȡ�ϼ��ֲ�ID
					rs1.executeSql("select id from HrmSubCompany where hrpkcode = '"+parent_code+"'");
					if(rs1.next()) {
						supsubcomid = Util.null2String(rs1.getString("id"));
					}
					
					//����ֲ�								
					sql = "insert into hrmsubcompany(subcompanyname,subcompanydesc,companyid,supsubcomid,hrpkcode) " +
	    			"values ('"+shortname+"','"+fullname+"',1,"+supsubcomid+",'"+code+"')";				
					rs1.executeSql(sql);
					
					//�������˵������˵�
					int id=0;
					rs1.executeSql("select id from HrmSubCompany where hrpkcode = '"+code+"'");
					if(rs1.next()) {
						id = rs1.getInt(1);					
						rs1.executeSql("insert into leftmenuconfig (userid,infoid,visible,viewindex,resourceid,resourcetype,locked,lockedbyid,usecustomname,customname,customname_e)  select  distinct  userid,infoid,visible,viewindex," + id + ",2,locked,lockedbyid,usecustomname,customname,customname_e from leftmenuconfig where resourcetype=1  and resourceid=1");
						rs1.executeSql("insert into mainmenuconfig (userid,infoid,visible,viewindex,resourceid,resourcetype,locked,lockedbyid,usecustomname,customname,customname_e)  select  distinct  userid,infoid,visible,viewindex," + id + ",2,locked,lockedbyid,usecustomname,customname,customname_e from mainmenuconfig where resourcetype=1  and resourceid=1");
				    }
					log.writeLog("�����ֲ��ɹ�,"+sql);
				}			
				} catch(Exception e) {
					log.writeLog("ͬ���ֲ�ʧ��,"+e);
					returnStr += "�����ֲ�"+code+shortname+"ʧ��";
				}	
			}	
		    
		    //������֯�ڵ�����¼���ϵ
            hrrs.beforFirst();
            while (hrrs.next()) {
            	String code = Util.null2String(hrrs.getString("id"));
				String shortname = Util.null2String(hrrs.getString("subcompanyname"));
				String fullname = Util.null2String(hrrs.getString("subcompanydesc"));
				String parent_code = Util.null2String(hrrs.getString("companyid"));
				synts = Util.null2String(hrrs.getString("modifydate"));
				int canceled = Util.getIntValue(hrrs.getString("status"), 0);
				int supsubcomid = 0;
				if(canceled==0) {   //���
					delSubCompany(code,shortname);
				} else {
					//��ȡ�ϼ��ֲ�ID
					rs.executeSql("select id from HrmSubCompany where hrpkcode = '"+parent_code+"'");
					if(rs.next()) {
						supsubcomid = rs.getInt("id");
					}						
					//���·ֲ���Ϣ
					sql = "update HrmSubCompany set subcompanyname='"+shortname+"',subcompanydesc='"+fullname+"',supsubcomid='"+supsubcomid+"',canceled='0' where hrpkcode='" + code + "'";
					rs.executeSql(sql);					
					log.writeLog("�༭�ֲ��ɹ�,"+sql);
				}
            }
            
            if (hrrs.getCounts() > 0) {
 				try {
 					SubCompanyComInfo scci = new SubCompanyComInfo();
 					scci.removeCompanyCache();
 				} catch (Exception e) {
 					e.printStackTrace();
 				}
 				synrs.executeSql("update hrm_ncsynts set synts='" + synts + "' where id=1");
 			}  
            if("".equals(returnStr)){
            	returnStr = "ͬ���ֲ��ɹ�";
            }
		return returnStr;
	}
	
	/**
	 * ������ֲ�
	 * @param orgXmlBean
	 * @return
	 */
	public void delSubCompany(String code,String shortname) {
		try {
			RecordSet rs = new RecordSet();
			String sql = "";		
			sql = "select count(id) from hrmdepartment where EXISTS (select 1 from hrmsubcompany b where hrmdepartment.subcompanyid1=b.id and b.hrpkcode='" + code + "') and (canceled='0' or canceled is null)";
            rs.executeSql(sql);
            int rows = 0;
            while (rs.next()) {
                rows += Util.getIntValue(rs.getString(1), 0);
            }
            if (rows > 0) {
            	log.writeLog("���ֲ�ʧ�ܣ��÷ֲ����������Ĳ��ţ��ֲ����ƣ�"+shortname);
            } else {
                sql = "update HrmSubCompany set canceled='1' where hrpkcode='"+code+"'";
                rs.executeSql(sql);          
                log.writeLog("���ֲ��ɹ�,"+sql);
            }				
		} catch (Exception e) {
			log.writeLog("���ֲ�ʧ��,"+e);
		}
	}
	
	public String SynDept() {
		String returnStr = "";
		
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			RecordSet synrs = new RecordSet();
			RecordSetDataSource hrrs = new RecordSetDataSource("hr");
			String synts = "";
			synrs.executeSql("select * from hrm_ncsynts where id=2");
	        if (synrs.next()) {
	            synts = Util.null2String(synrs.getString("synts"));
	            if (synts.length() <= 0) {
	                  synts = "2000-01-01 00:00:00";
	            }
	        }
			String sql = "select id,supdepid,subcompanyid1,departmentname,status,modifydate from HrmDepartment where modifydate >= to_date('" + synts + "','yyyy-mm-dd HH24:mi:ss') order by modifydate desc";
			hrrs.executeSql(sql); 
		    while(hrrs.next()){
		    	String code = Util.null2String(hrrs.getString("id"));
				String shortname = Util.null2String(hrrs.getString("departmentname"));
				String fullname = Util.null2String(hrrs.getString("departmentname"));
				String parent_code = Util.null2String(hrrs.getString("supdepid"));
				String org_code = Util.null2String(hrrs.getString("subcompanyid1"));
				try {
				int subcomid = 0;
				int supdeptid = 0;				
				rs.executeSql("select id from hrmdepartment where hrpkcode = '"+code+"'");
				if(!rs.next()) {  //�����ھ�����
					//��ȡ�ֲ�ID
					rs1.executeSql("select id from HrmSubCompany where hrpkcode = '"+org_code+"'");
					if(rs1.next()) {
						subcomid = Util.getIntValue(rs1.getString("id"),0);
					}
					
					//��ȡ�ϼ�����ID
					rs1.executeSql("select id from hrmdepartment where hrpkcode = '"+parent_code+"'");
					if(rs1.next()) {
						supdeptid = Util.getIntValue(rs1.getString("id"),0);
					}
					
					//���벿��
					sql = "insert into hrmdepartment(departmentname,departmentmark,subcompanyid1,supdepid,hrpkcode) " +
	    			"values ('"+shortname+"','"+fullname+"',"+subcomid+","+supdeptid+",'"+code+"')";				
					rs1.executeSql(sql);
						
					log.writeLog("�������ųɹ�,"+sql);
				} 
				} catch (Exception e) {
					log.writeLog("ͬ������ʧ��,"+e);
					returnStr += "ͬ������"+code+shortname+"ʧ��";
				}
			}
		    
		  //������֯�ڵ�����¼���ϵ
            hrrs.beforFirst();
            while (hrrs.next()) {
            	String code = Util.null2String(hrrs.getString("id"));
				String shortname = Util.null2String(hrrs.getString("departmentname"));
				String fullname = Util.null2String(hrrs.getString("departmentname"));
				String parent_code = Util.null2String(hrrs.getString("supdepid"));
				String org_code = Util.null2String(hrrs.getString("subcompanyid1"));
				String canceled = Util.null2String(hrrs.getString("status"));
				synts = Util.null2String(hrrs.getString("modifydate"));
				int subcomid = 0;
				int supdeptid = 0;	
				if("0".equals(canceled)) {   //���
					delDepartment(code,shortname);
				} else {
					//��ȡ�ֲ�ID
					rs1.executeSql("select id from HrmSubCompany where hrpkcode = '"+org_code+"'");
					if(rs1.next()) {
						subcomid = Util.getIntValue(rs1.getString("id"),0);
					}
					
					//��ȡ�ϼ�����ID
					rs1.executeSql("select id from hrmdepartment where hrpkcode = '"+parent_code+"'");
					if(rs1.next()) {
						supdeptid = Util.getIntValue(rs1.getString("id"),0);
					}
					
					log.writeLog("subcomid:"+subcomid+",pkcode:"+code+",supdepid:"+supdeptid);				 
					sql = "update hrmdepartment set subcompanyid1="+subcomid+", departmentname='"+shortname+"',departmentmark='"+fullname+"',supdepid=" + supdeptid + ",canceled='0' where hrpkcode='" + code + "'";
					rs1.executeSql(sql);
					log.writeLog("����OA���ŵ�sql:"+sql);
				}
            }
            
            if (hrrs.getCounts() > 0) {
                try {
                    DepartmentComInfo dci = new DepartmentComInfo();
                    dci.removeCompanyCache();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rs.executeSql("update hrm_ncsynts set synts='" + synts + "' where id=2");
            }
            if("".equals(returnStr)){
            	returnStr = "ͬ�����ųɹ�";
            }
		return returnStr;
	}
	
	/**
	 * ��沿��
	 * @param ipaddress
	 * @param orgXmlBean
	 * @return
	 */
	public void delDepartment(String code,String shortname) {
		try {
			RecordSet rs = new RecordSet();
			String sql = "";
			int id = 0;
			rs.executeSql("select id from hrmdepartment where hrpkcode='"+code+"'");
			if(rs.next()) id = Util.getIntValue(rs.getString(1), 0);			
			sql = "select id from hrmresource where status in (0,1,2,3) and EXISTS (select 1 from hrmdepartment b where hrmresource.departmentid=b.id and b.id = "+id+ ") union select id from hrmdepartment where (canceled = '0' or canceled is null) and id in (select id from hrmdepartment where supdepid ="+id+")";
            rs.executeSql(sql);
            int rows = 0;
            while (rs.next()) {
                rows += Util.getIntValue(rs.getString(1), 0);
            }
            if (rows > 0) {
            	log.writeLog("��沿��ʧ�ܣ��ò���������������Ա���������ƣ�"+shortname);
            } else {
                sql = "update hrmdepartment set canceled='1' where hrpkcode='"+code+"'";
                rs.executeSql(sql);              
                log.writeLog("��沿�ųɹ�!"+sql);
            }					
		} catch (Exception e) {
			log.writeLog("��沿��ʧ��,"+e);
		}
	}
	
	 /**
     * ͬ����λ
     * ����:ͬ����Ϣ,���а���:NCPK,PK,Memo,Success(1:����,2:����,0:ʧ��)
     * @param SynMsg
     * @return HashMap ͬ����Ϣ
     */
     public String  SynJobTitles() {
    	 String returnStr = "";

	        RecordSet rs=new RecordSet();
	        String lastts="";
	        String sql="select Synts from hrm_ncsynts where id=3";
	        rs.executeSql(sql);
	        if(rs.next()){
	            lastts= Util.null2String(rs.getString("Synts"));
	        }
	        if (lastts.length() <= 0) return returnStr;
	        RecordSetDataSource hrrs = new RecordSetDataSource("hr");          
	        sql="select \"id\",\"NAME\",departmentid,modifydate,status from HRMJOBTITLES where modifydate >= to_date('" + lastts + "','yyyy-mm-dd HH24:mi:ss') order by modifydate desc";
	        hrrs.executeSql(sql);
	        while(hrrs.next()) {
	            String pk_om_job = Util.null2String(hrrs.getString("id"));
	            String jobname = Util.null2String(hrrs.getString("Name"));
	            String jobremarkname =Util.null2String(hrrs.getString("Name"));
	            String pk_deptdoc = Util.null2String(hrrs.getString("departmentid"));
	            String canceled = Util.null2String(hrrs.getString("status"));
	       	 try {
	            lastts = Util.null2String(hrrs.getString("modifydate"));
	            if(pk_om_job.length()>0) {            	
	                sql="select id from hrmdepartment where hrpkcode='"+pk_deptdoc+"'";
	                rs.executeSql(sql);
	                if(rs.next()) {                   
	                	int deptid = rs.getInt("id");
		                sql="select max(id) id from hrmJobActivities";
		                rs.executeSql(sql);
		                int Activityid=0;
		                if(rs.next()){
		                    Activityid=rs.getInt("id");
		                }
	                    
	                    sql="select id from hrmjobtitles where hrpkcode='"+pk_om_job+"'";
	                    rs.executeSql(sql);
	                    if(rs.next()) {
	                    	if("0".equals(canceled)) {   //���
	                    		delJobTitle(pk_om_job,jobname);
	        				}
	                        sql="update hrmjobtitles set jobtitlename='"+jobname+"',jobtitlemark='"+jobremarkname+"',jobdepartmentid="+deptid+" where hrpkcode='"+pk_om_job+"'";
	                        log.writeLog("���¸�λsql��"+sql);
	                    } else {
	                        sql="insert into hrmjobtitles(hrpkcode,jobtitlename,jobtitlemark,jobdepartmentid,jobactivityid) values ('"+pk_om_job+"','"+jobname+"','"+jobremarkname+"',"+deptid+","+Activityid+")";
	                        log.writeLog("������λsql��"+sql);
	                    }
	                    rs.executeSql(sql);
	                } 
	            }
	    	 } catch(Exception e) {
	   			log.writeLog("ͬ����λʧ��,"+e);
				returnStr += "ͬ����λ"+pk_om_job+jobname+"ʧ��";
	   		 }	
	        }
	        //����ͬ��TS
	        if(hrrs.getCounts()>0){
		        try {
		            JobTitlesComInfo jtci=new JobTitlesComInfo();
		            jtci.removeJobTitlesCache();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        sql="update hrm_ncsynts set Synts='"+lastts+"' where id=3";
		        rs.executeSql(sql);      
	        }
            if("".equals(returnStr)){
            	returnStr = "ͬ����λ�ɹ�";
            }
    	 return returnStr;
    }
     
     /**
 	 * ɾ����λ
 	 * @param 
 	 * @return
 	 */
 	public void delJobTitle(String jobtitlecode,String jobtitlename) {
 		try {
 			RecordSet rs=new RecordSet();
 			int id = 0;
            rs.executeSql("select id from hrmjobtitles where hrpkcode='"+jobtitlecode+"'");
            if(rs.next()) id = Util.getIntValue(rs.getString("id"), 0);  
            if(id > 0) {
             	rs.executeSql("select count(id) from HrmResource where jobtitle="+id);
             	if(rs.getInt(1) > 0){
             		log.writeLog("�˸�λ�Ѿ���ʹ��,����ɾ��!"); 
             	} else {
             		rs.executeSql("delete from hrmjobtitles where hrpkcode='"+jobtitlecode+"'");                  
                    log.writeLog("ɾ����λ�ɹ�!");
             	}
             } else {
               log.writeLog(jobtitlename + "��λ������!");
             }
 		} catch(Exception e) {
 			log.writeLog("ɾ����λʧ��,"+e);
 		}		
 	}
 	
 	/**
     * ���ͬ���Ĳ���id
     *
     * @param ncpkcode
     * @return
     */
    public String getSynDeptId(String hrpkcode) {
        RecordSet rs = new RecordSet();
        String Syndeptid = "";
        rs.executeSql("select id from hrmdepartment where hrpkcode='" + hrpkcode + "'");
        if (rs.next()) {
            Syndeptid = rs.getString("id");
        }
        return Syndeptid;
    }
 	
 	public String synHrmResource(String appID) {
 		String returnStr = "";
 		RecordSet rs = new RecordSet();
        RecordSet rs1 = new RecordSet();
        RecordSetDataSource hrrs = new RecordSetDataSource("hr");
        char separator = Util.getSeparator();
        Calendar todaycal = Calendar.getInstance();
        String today = Util.add0(todaycal.get(Calendar.YEAR), 4) + "-" +
                Util.add0(todaycal.get(Calendar.MONTH) + 1, 2) + "-" +
                Util.add0(todaycal.get(Calendar.DAY_OF_MONTH), 2);
        String userpara = "" + 1 + separator + today;
        String lastts = "";
        DepartmentComInfo dci = null;
        try {
            dci = new DepartmentComInfo();
        } catch (Exception e) {
        }
        String sql = "select Synts from Hrm_NCSynTS where id=4";
        rs.executeSql(sql);
        if (rs.next()) {
            lastts = Util.null2String(rs.getString("Synts"));
            if (lastts.length() <= 0) lastts = "2000-01-01 00:00:00";
        }
        //ͬ����Ա
        sql = "select id,loginid,password,lastname,certificatenum,mobile,email,departmentid,jobtitle,modifydate,status,ismain,mhid,belongto,seclevel from HrmResource where appName='"+appID+"' and modifydate >= to_date('" + lastts + "','yyyy-mm-dd HH24:mi:ss') order by modifydate desc,ismain asc ";			 
        hrrs.executeSql(sql);
        while (hrrs.next()) {
        	String pk_psndoc = Util.null2String(hrrs.getString("id"));
            String psnname = Util.null2String(hrrs.getString("lastname"));
            try{
            String pk_deptdoc = Util.null2String(hrrs.getString("departmentid"));
            String pk_om_job = Util.null2String(hrrs.getString("jobtitle"));
			String mobile = Util.null2String(hrrs.getString("mobile"));
			String email = Util.null2String(hrrs.getString("email"));				 
			String certificatenum = Util.null2String(hrrs.getString("certificatenum"));
			String loginid = Util.null2String(hrrs.getString("loginid"));
            lastts = Util.null2String(hrrs.getString("modifydate")); 
			int status =  Util.getIntValue(hrrs.getString("status"),0);
			String password = Util.null2String(hrrs.getString("password"));
			int seclevel = Util.getIntValue(hrrs.getString("seclevel"),0);
			
			String ismain = Util.null2String(hrrs.getString("ismain"));
			String belongto = Util.null2String(hrrs.getString("belongto"));
			//oa �� accounttype Null��0:���˺� 1�����˺�        belongto   ���������˺�Hrmreource��id
			//nk �� Ismain 0�������ʺ�  ����0�������˺�      belongto ��Ӧid
			
			int accounttype = 0;
			int oabelongto = -1;
			if("0".equals(ismain)){
				accounttype = 0;
				oabelongto = -1;
			}else{
				accounttype = 1;
				RecordSet rsTemp = new RecordSet();
				rsTemp.executeSql("select id from hrmresource where hrpkcode='"+belongto+"'");
				if(rsTemp.next()){
					oabelongto = rsTemp.getInt("id");
				}
			}
			if(status == 0) status = 5;
			
			String subcompanyid = "";  
            String deptid = "";
            String jobtitlesid = "-1";
            String Errermsg = "";                 
			if (pk_psndoc.length() > 0  && pk_deptdoc.length() > 0) {
				 if(!"".equals(pk_om_job)){
					 sql = "select id from hrmjobtitles where hrpkcode='" + pk_om_job + "'";
					 rs1.executeSql(sql);
					 if (rs1.next()) {
						 jobtitlesid = rs1.getString("id");
					 } else {
						 //ͬ����λ
						 SynJobTitles();
						 sql = "select id from hrmjobtitles where hrpkcode='" + pk_om_job + "'";
						 rs1.executeSql(sql);
						 if (rs1.next()) {
							jobtitlesid = rs1.getString("id");
						 }
					}
				 } else {
					jobtitlesid = "0";
				 }
				 sql = "select id,subcompanyid1 from hrmdepartment where hrpkcode='" + pk_deptdoc + "'";
				 rs1.executeSql(sql);
				 if (rs1.next()) {
					 deptid = rs1.getString("id");
					 subcompanyid = rs1.getString("subcompanyid1");
				 } else {
					 //ͬ������
					 SynDept();
					 deptid = getSynDeptId(pk_deptdoc);
					 if (!deptid.equals("")) subcompanyid = dci.getSubcompanyid1(deptid);
				 }
				 if (subcompanyid.equals("")) {
					 Errermsg = "��Ա�����ֲ�����ȷ!";
				 } else if (deptid.equals("")) {
					 Errermsg = "��Ա�������Ų���ȷ!";
				 }
				 log.writeLog("deptid:"+deptid+",subcompanyid:"+subcompanyid+",pk_psndoc:"+pk_psndoc+",Errermsg:"+Errermsg);
                 if ((!deptid.equals("") && !subcompanyid.equals(""))) {
                    sql = "select id from hrmresource where hrpkcode='" + pk_psndoc + "'";
                    rs1.executeSql(sql);
                    if (rs1.next()) { 
                        int maxid = rs1.getInt("id");
                        if (maxid > 0) {                                
                            sql = "update hrmresource set loginid='"+loginid+"',password='"+ password+"',lastname='"+psnname+"',email='"+email+"',departmentid="+deptid+",subcompanyid1="+subcompanyid+",jobtitle="+jobtitlesid+"," +
                            		"workcode='"+pk_psndoc+"',status="+status+",certificatenum='"+certificatenum+"',mobile='" +mobile +"',seclevel="+seclevel+" "+
                            	    " where id=" + maxid;
                            rs1.executeSql(sql);
                            log.writeLog("������Ա��sql:"+sql);
                            
                            String p_para = "" + maxid + separator + deptid + separator + subcompanyid + separator + -1 + separator + "10" + separator + "" + separator + "0" + separator + "0" + separator + "0" + separator + "0" + separator + "0" + separator + "0";
                            rs1.executeProc("HrmResourceShare", p_para);
						 }
                    } else {                       	 
                        rs1.executeProc("HrmResourceMaxId_Get", "");
                        rs1.next();
                        int maxid = rs1.getInt(1); 
                        if (maxid > 0) {
                            sql = "insert into hrmresource(id,hrpkcode,loginid,password,lastname,email,departmentid,subcompanyid1,jobtitle," +
                                    "systemlanguage,mobile,status,certificatenum,accounttype,belongto,seclevel) values (" +
                                    maxid + ",'"+pk_psndoc+ "','"+loginid+"','"+ password+"','"+psnname+"','"+email+"',"+deptid+","+subcompanyid+","+jobtitlesid+",7,'"+mobile+"',"+status+",'"+certificatenum+"',"+
                                    accounttype+","+oabelongto+","+seclevel+")";
							 rs1.executeSql(sql);  
							 log.writeLog("������Ա��sql:"+sql);
							 
							 String p_para = "" + maxid + separator + deptid + separator + subcompanyid + separator + -1 + separator + "10" + separator + "" + separator + "0" + separator + "0" + separator + "0" + separator + "0" + separator + "0" + separator + "0";
	                         rs1.executeProc("HrmResourceShare", p_para);
	                         rs1.executeProc("HrmResource_CreateInfo", "" + maxid + separator + userpara + separator + userpara);
	                         String para = "" + maxid + separator + "-1" + separator + deptid + separator + subcompanyid + separator + "10" + separator + "";
	                         rs1.executeProc("HrmResource_Trigger_Insert", para);
	                         String sql_1 = "insert into HrmInfoStatus (itemid,hrmid,status) values(1," + maxid + ",1)";
	                         rs1.executeSql(sql_1);
	                         String sql_2 = "insert into HrmInfoStatus (itemid,hrmid) values (2," + maxid + ")";
	                         rs1.executeSql(sql_2);
	                         String sql_3 = "insert into HrmInfoStatus (itemid,hrmid) values (3," + maxid + ")";
	                         rs1.executeSql(sql_3);
	                         String sql_10 = "insert into HrmInfoStatus (itemid,hrmid) values(10," + maxid + ")";
	                         rs1.executeSql(sql_10);
                        }
                    }                      
                }
            }
			} catch(Exception e) {
				log.writeLog("ͬ����Աʧ��,"+e);
				returnStr += "ͬ����Ա"+pk_psndoc+psnname+"ʧ��";
			}	
        }
        if("".equals(returnStr)){
        	returnStr = "ͬ����Ա�ɹ�";
        }
        return returnStr;
 	}
}
