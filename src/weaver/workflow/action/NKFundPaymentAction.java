package weaver.workflow.action;

import nk.webservice.pay.PayServiceProxy;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestManager;

/**
 * NKϵͳ����-�ʽ�֧������--�鵵�ύAction
 * @author Administrator
 *
 */
public class NKFundPaymentAction extends BaseBean implements Action {
	private RequestManager requestManager;
	private String WebServiceURL = getPropValue("NKFundpayment", "webServiceURL");
	private String HTBHFieldName = getPropValue("NKFundpayment", "HTBHFieldName");

	public String execute(RequestInfo request) {
		PayServiceProxy payService = new PayServiceProxy(WebServiceURL);
		int cid = 0;//��ͬ��� htbh
		
		RecordSet rs= new RecordSet();
		this.requestManager = request.getRequestManager();
		String requestid = Util.null2String(request.getRequestid());
		rs.writeLog("��ǰ����NKFundPaymentAction�ı�ID = " + requestManager.getFormid() + "||RequestId = " + requestid);
		//��ȡ�������
		String sql="select tablename from workflow_bill where id ='" + requestManager.getFormid() + "'";
		writeLog("��ȡ�������==" + sql);
		String tablename="";
		rs.executeSql(sql);
		if(rs.next()){
			tablename = Util.null2String(rs.getString("tablename"));
		}
		
		try{
			sql="select " + HTBHFieldName + " from " + tablename + " where requestid = '" + requestid + "' ";
			writeLog("��ȡ�����е���������==" + sql);
			rs.executeSql(sql);
			if(rs.next()){
				cid = Util.getIntValue(rs.getString(HTBHFieldName),cid);
				writeLog("��ȡ�ĺ�ͬ���=" + cid + "||����ID=" + requestid);
			}
			if(cid > 0) {
				//��NK����ȷ�ϲ��账����ýӿں�ķ���ֵ
				payService.getResultFromOA(cid+"", true);
			} else {
				writeLog("�ʽ�֧��-���񼯳����������鵵��дNKϵͳʧ�ܣ���ͬ��Ż�ȡʧ��");
				request.getRequestManager().setMessageid("10001002");
				request.getRequestManager().setMessagecontent("�ʽ�֧��-���񼯳����������鵵��дNKϵͳʧ�ܣ���ͬ��Ż�ȡʧ�ܣ�����ϵ����Ա��");
			}
		} catch(Exception e) {
			e.printStackTrace();
			writeLog("�ʽ�֧��-���񼯳����������鵵��дNKϵͳʧ�ܣ����뼶�쳣");
			request.getRequestManager().setMessageid("10001001");
			request.getRequestManager().setMessagecontent("�ʽ�֧��-���񼯳����������鵵��дNKϵͳʧ�ܣ�����ϵ����Ա��");
		}
		return Action.SUCCESS;
	}
}
