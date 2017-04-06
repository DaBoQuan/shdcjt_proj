package weaver.createWorkflow.SAP.conn;

import weaver.general.BaseBean;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

/**
 * SAP���ӳ�
 * @author Administrator
 *
 */
public class SAPConnPool extends BaseBean {
	private BaseBean logBean = new BaseBean();
	
	final static String POOL_NAME = "SAPPoolJYY";
	private static String sapclient = "";
	private static String userid = "";
	private static String password = "";
	private static String hostname = "";
	private static String systemnumber = "";
	private static String Language = "";
	private JCO.Pool pool = null;
	/*
	 * ��ʼ������
	 */
	private void init() {
		try {
			sapclient = getPropValue("SAPConnPool", "sapclient");
			userid = getPropValue("SAPConnPool", "userid");
			password = getPropValue("SAPConnPool", "password");
			hostname = getPropValue("SAPConnPool", "hostname");
			systemnumber = getPropValue("SAPConnPool", "systemnumber");
			Language = getPropValue("SAPConnPool", "Language");
			pool = JCO.getClientPoolManager().getPool(POOL_NAME);
			logBean.writeLog("SAP���ӳ���Ϣ = "+sapclient+"||"+userid+"||"+password+"||"+hostname);
			if (pool == null) {
				JCO.addClientPool(POOL_NAME, 20,sapclient, userid, password, Language, hostname,systemnumber);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*
	 * �ͷ�����
	 */
	public void releaseC(JCO.Client Client) {
		if (Client != null){
			JCO.releaseClient(Client);
		}
	}
	/*
	 * ��ȡ����
	 */
	public JCO.Client getConnection() {
		//�ж����ӳ��Ƿ�ΪNULL
		if(pool==null){
			init();
		}
		JCO.Client Client = null; 
		try{ 
			Client = JCO.getClient(POOL_NAME);
		}catch(Exception e){
			e.printStackTrace();
		}
		return Client;
	}

	/*
	*ִ��Bapi
	*/
	public JCO.Function excuteBapi(String s) {
		SAPConnPool SAPConn = new SAPConnPool();
		JCO.Client sapconnection = SAPConn.getConnection();
		JCO.Repository mRepository;
		JCO.Function jcoFunction = null;
		if(sapconnection==null){
			return jcoFunction;
		}
		try {
			mRepository = new JCO.Repository("Repository", sapconnection);
			IFunctionTemplate ft = mRepository.getFunctionTemplate(s);
			jcoFunction = new JCO.Function(ft);
			SAPConn.releaseC(sapconnection);
			return jcoFunction;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			SAPConn.releaseC(sapconnection);
		}
	}
}
