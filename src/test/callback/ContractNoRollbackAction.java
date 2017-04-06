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

public class ContractNoRollbackAction implements Action
{
	private RequestManager requestManager;
	private BaseBean logBean = new BaseBean();
	private String requestName;

	public ContractNoRollbackAction(String requestName)
	{
		super();
		this.requestName = requestName;
	}

	public ContractNoRollbackAction()
	{
		super();
		// TODO Auto-generated constructor stub
	}

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
		System.out.println("===========requestName========" + requestName);
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
		String CONTRACTNO = "";
		String IV_APPSTATUS = "";

		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String getRemarkSQL = "select CONTRACTNO from " + tablename + "  where requestid = '" + requestid + "'";
		rs.executeSql(getRemarkSQL);
		logBean.writeLog("getRemarkSQL=" + getRemarkSQL);
		if (rs.next())
		{
			CONTRACTNO = Util.null2String(rs.getString("CONTRACTNO"));
			System.out.println("CONTRACTNO=" + CONTRACTNO);
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
			input.setValue(CONTRACTNO, "CONTRACTNO");
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
