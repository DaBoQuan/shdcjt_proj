package nk.webservice;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;

public class PlatformUtil extends BaseBean {
	
	/**
	 * ����Ͽ���webserveice url��ַ
	 * @return
	 */
	public String getWebserviceUrl(){
		String url = "";
		String fname = "nkwebservice";
		String key = "webservicesurl";
		url = this.getPropValue(fname, key);
		return url;
	}
	
	/**
	 * ����oa��hrid��ö�Ӧ���Ͽ���userid
	 * @return
	 */
	public String getUseridByOaId(String hrmid){
		String userId = "0";
		RecordSet rs = new RecordSet();
		rs.executeSql("select userid from oa_hrm where oaid="+hrmid);
		if(rs.next()){
			userId = rs.getString("userid");
		}
		return userId;
	}
	
    /**
     * ����oa�Ĳ���id��ö�Ӧ���Ͽ��Ĳ���id
     * @return
     */
    public String getOrgidByOaDeptId(String deptId){
		String orgId = "0";
		RecordSet rs = new RecordSet();
		rs.executeSql("select orgid from oa_dept where oaid="+deptId);
		if(rs.next()){
			orgId = rs.getString("orgid");
		}
		return orgId;
    }
    
	/**
	 * ��ú�ͬ���
	 * @return
	 */
	public String getHtbh(String wfId){
		String returnVal = "";
		String fname = "docWfConfig";
		String key = wfId+"_htbh";
		returnVal = this.getPropValue(fname, key);
		return returnVal;
	}
	/**
	 * ��ýڵ㴦����
	 * @return
	 */
	public String getJdclr(String wfId){
		String returnVal = "";
		String fname = "docWfConfig";
		String key = wfId+"_jdclr";
		returnVal = this.getPropValue(fname, key);
		return returnVal;
	}
	/**
	 * ��ü����쵼�����Ľڵ�id
	 * @return
	 */
	public String getNodeid(String wfId){
		String returnVal = "";
		String fname = "docWfConfig";
		String key = wfId+"_nodeid";
		returnVal = this.getPropValue(fname, key);
		return returnVal;
	}
 
	/**
	 * ��÷�������
	 * @return
	 */
	public String getFwzw(String wfId){
		String returnVal = "";
		String fname = "docWfConfig";
		String key = wfId+"_fwzw";
		returnVal = this.getPropValue(fname, key);
		return returnVal;
	}
}
