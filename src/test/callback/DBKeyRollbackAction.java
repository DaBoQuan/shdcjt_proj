package test.callback;

import java.util.Calendar;

import weaver.conn.RecordSet;
import weaver.createWorkflow.SAP.conn.SAPConnPool;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestManager;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;
import com.sap.mw.jco.JCO.Client;

/**
 * @Title: BiddingApplyAction.java
 * @Package weaver.createWorkflow.SAP.action
 * @Description: �б����������˻�״̬��дSAP����Action
 * @author JYY
 * @date 2016-8-1
 */

public class DBKeyRollbackAction implements Action
{
	private RequestManager requestManager;
	private BaseBean logBean = new BaseBean();
	private String requestName;

	public String getRequestName()
	{
		return requestName;
	}

	public void setRequestName(String requestName)
	{
		this.requestName = requestName;
	}

	Calendar today = Calendar.getInstance();
	String currentDate = Util.add0(today.get(Calendar.YEAR), 4) + "-" + Util.add0(today.get(Calendar.MONTH) + 1, 2)
			+ "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);

	@Override
	public String execute(RequestInfo request)
	{
		return exeuteDBKey(requestManager, requestManager, request);
	}

	private String exeuteDBKey(RequestManager requestManager, BaseBean logBean, RequestInfo request)
	{
		RecordSet res = new RecordSet();
		this.requestManager = request.getRequestManager();

		String requestid = Util.null2String(request.getRequestid());
		logBean.writeLog("����" + requestName + "��formid = " + requestManager.getFormid() + "||RequestId = " + requestid);
		String sql = "select tablename from workflow_bill where id ='" + requestManager.getFormid() + "'";
		logBean.writeLog("==================ȡ�������===========" + sql);
		String tablename = "";
		res.executeSql(sql);
		if (res.next())
		{
			tablename = Util.null2String(res.getString("tablename"));
		}

		String errorMessage = "";
		// �����SAP����
		String DBKey = "";
		String IV_APPSTATUS = "";

		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String getRemarkSQL = "select DB_KEY from " + tablename + "  where requestid = '" + requestid + "'";
		rs.executeSql(getRemarkSQL);
		logBean.writeLog("getRemarkSQL=" + getRemarkSQL);
		if (rs.next())
		{
			DBKey = Util.null2String(rs.getString("DB_KEY"));
			System.out.println("DB_KEY=" + DBKey);
		}

		// ��ȡSAP����
		SAPConnPool SAPConn = new SAPConnPool();
		Client myConnection = SAPConn.getConnection();
		myConnection.connect();
		if (myConnection != null && myConnection.isAlive())
		{
			logBean.writeLog("====== SAP connection success======");
			JCO.Repository myRepository = new JCO.Repository("Repository", myConnection); // �������
			IFunctionTemplate ft = myRepository.getFunctionTemplate(requestName);// �ӡ��ֿ⡱�л��һ��ָ���������ĺ���ģ��
			JCO.Function function = ft.getFunction();
			// ��ú�����import�����б�
			JCO.ParameterList input = function.getImportParameterList();// ��������ͽṹ����(δʹ��)
			JCO.ParameterList inputtable = function.getTableParameterList();// �����Ĵ���
			IV_APPSTATUS = "03";
			System.out.println("IV_APPSTATUS=" + IV_APPSTATUS);
			logBean.writeLog("IV_APPSTATUS=" + IV_APPSTATUS);
			input.setValue(DBKey, "IV_DB_KEY");
			input.setValue(IV_APPSTATUS, "IV_APPSTATUS");
			myConnection.execute(function);// ִ�к���

		} else
		{
			logBean.writeLog("======SAP connection fail======");
			errorMessage = "OA��SAP���Ӵ�������ϵϵͳ����Ա";
		}

		if (!"".equals(errorMessage))
		{
			request.getRequestManager().setMessageid("10008011");
			request.getRequestManager().setMessagecontent(errorMessage);
		}

		SAPConn.releaseC(myConnection);
		return Action.SUCCESS;
	}

}
