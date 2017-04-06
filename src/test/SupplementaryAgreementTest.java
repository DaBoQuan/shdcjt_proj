package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import test.unit_test.SAPRecord;
import weaver.conn.RecordSet;
import weaver.createWorkflow.SAP.conn.SAPConnPool;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.schedule.BaseCronJob;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.RequestService;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;
import com.sap.mw.jco.JCO.Client;
import com.sap.mw.jco.JCO.ParameterList;
import com.sap.mw.jco.JCO.Table;

/**
 * ����Э��
 * 
 * @author David.dai
 * 
 */
public class SupplementaryAgreementTest  extends BaseCronJob
{
	private static final String REQUEST_ID = "requestid";
	private static final String DB_KEY = "DB_KEY";
	private BaseBean logBean = new BaseBean();
	private SAPConnPool SAPConn = new SAPConnPool();

	public static void main(String[] args)
	{
		SupplementaryAgreementTest obj = new SupplementaryAgreementTest();
		obj.execute();
	}

	public void testconn()
	{
		Client myConnection = SAPConn.getConnection();
		myConnection.connect();
		if (myConnection != null && myConnection.isAlive())
		{
			logBean.writeLog("==========����Э��=============");
			logBean.writeLog("======connection success======");
			JCO.Repository myRepository = new JCO.Repository("Repository", myConnection); // �������
			IFunctionTemplate ft = myRepository.getFunctionTemplate("ZDC_CO_SIDAG"); // ��ȡ����Э��ģ��
			JCO.Function function = ft.getFunction();

			// ��ú�����import�����б�
			JCO.ParameterList input = function.getImportParameterList();
			JCO.ParameterList inputtable = function.getTableParameterList();
			myConnection.execute(function);

			ParameterList outputTable = function.getTableParameterList(); // �����Ĵ���
			Table basicContract = outputTable.getTable("ET_CO_CONT"); // ��ͬ������Ϣ������
			Table contractChangeDetail = outputTable.getTable("ET_CO_CON_CHG"); // ��ͬ�������ϸ��
			Table divideAmoutDetail = outputTable.getTable("ET_CO_CON_QZ"); // �ֳ�ǩ֤����ϸ��
			Table contractFileDetail = outputTable.getTable("ET_CO_CON_FILE"); // ��ͬ��������ϸ��
		}
	}

	public void execute()
	{
		Client myConnection = SAPConn.getConnection();
		myConnection.connect();
		if (myConnection != null && myConnection.isAlive())
		{
			logBean.writeLog("==========����Э��=============");
			logBean.writeLog("======connection success======");
			JCO.Repository myRepository = new JCO.Repository("Repository", myConnection); // �������
			IFunctionTemplate ft = myRepository.getFunctionTemplate("ZDC_CO_SIDAG"); // ��ȡ����Э��ģ��
			JCO.Function function = ft.getFunction();

			// ��ú�����import�����б�
			JCO.ParameterList input = function.getImportParameterList();
			JCO.ParameterList inputtable = function.getTableParameterList();
			myConnection.execute(function);

			ParameterList outputTable = function.getTableParameterList(); // �����Ĵ���
			Table basicContract = outputTable.getTable("ET_CO_CONT"); // ��ͬ������Ϣ������

			// ��ϸ��������excel���˳��������tb1, tb2, tb3
			Table tb1Detail = outputTable.getTable("ET_CO_CON_CHG"); // ��ͬ�������ϸ��
			Table tb2Detail = outputTable.getTable("ET_CO_CON_QZ"); // �ֳ�ǩ֤����ϸ��
			Table tb3Detail = outputTable.getTable("ET_CO_CON_FILE"); // ��ͬ��������ϸ��
			

			logBean.writeLog("*****************"+tb1Detail.getNumRows());
			// ��ͬ������Ϣ�������ֶ���ֵ
			List<Column> basicContractColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""),
					new Column("CONTRACTNO", ""), new Column("CONTCATE", ""), new Column("CONTFCLASS", ""),
					new Column("CONTSCLASS", ""), new Column("REFCONTRACTNO", ""), new Column("RECONAMT", ""),
					new Column("RECONTNO", ""), new Column("RECONNAM", ""), new Column("ACONTNO", ""),
					new Column("CONTRACTNAME", ""), new Column("CONTTCURR", ""), new Column("FORECASTAMT", ""),
					new Column("AGGAMT", ""), new Column("PSPID", ""), new Column("PSNAM", ""),
					new Column("BUKRS", ""), new Column("BUTXT", ""), new Column("LIFNR", ""),
					new Column("VENDNAME", ""), new Column("LIFNR_B", ""), new Column("VENDNAME_B", ""),
					new Column("BANK_ACC", ""), new Column("BANK_ACC_NAM", ""), new Column("LIFNR_3RD", ""),
					new Column("VENDNAME_3RD", ""), new Column("CONSTATUS", ""), new Column("APPSTATUS", ""),
					new Column("DELFLAG", ""), new Column("CUNAME", ""), new Column("CDEPT_DESC", ""),
					new Column("CDIVISION_DESC", ""), new Column("CREA_DATE", ""), new Column("CREA_TIME", ""),
					new Column("BCYY", ""), new Column("ZEMPLOYEE", "") });

			// �˴�����Ϊ�˹��������ṹHashMap����Ӧ������table�ṹhash��key-�ֶ�����value-�ֶ�ʵ���൱������ĵ�����¼
			Map<String, Column> basicContractColMap = new HashMap<String, Column>();
			for (Column column : basicContractColLs)
			{
				if (!basicContractColMap.containsKey(column.getName()))
				{
					basicContractColMap.put(column.getName(), column);
				}
			}
			logBean.writeLog("+++1111++++++"+basicContractColMap);

			// ��ͬ�������ϸ��
			List<Column> tb1DetailColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""),
					new Column("REVISIONNO", ""), new Column("EXREVINNO", ""), new Column("ESTICURR", "") });

			// �˴�����Ϊ�˹�����ͬ�����ϸ��ṹHashMap����Ӧ������table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb1DetailColMap = new HashMap<String, Column>();
			for (Column column : tb1DetailColLs)
			{
				if (!tb1DetailColMap.containsKey(column.getName()))
				{
					tb1DetailColMap.put(column.getName(), column);
				}
			}

			logBean.writeLog("+++++++++"+tb1DetailColMap);
			// �ֳ�ǩ֤����ϸ��
			List<Column> tb2DetailColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""), new Column("OSVID", ""),
					new Column("OSVNO", ""), new Column("AUDITCURR", "") });

			// �˴�����Ϊ�˹����ֳ�ǩ֤��ϸ��ṹHashMap����Ӧ����ϸ��table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb2DetailColMap = new HashMap<String, Column>();
			for (Column column : tb2DetailColLs)
			{
				if (!tb2DetailColMap.containsKey(column.getName()))
				{
					tb2DetailColMap.put(column.getName(), column);
				}
			}

			logBean.writeLog("+++++++++"+tb2DetailColMap);
			// ��ͬ��������ϸ��
			List<Column> tb3DetailColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""),
					new Column("ZFILE_NO", ""), new Column("ZWJMC", ""), new Column("ZFILE_PATH", ""),
					new Column("UNAME", ""), new Column("DATUM", "") });

			// �˴�����Ϊ�˹�����ͬ����ϸ��ṹHashMap����Ӧ����ϸ��table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb3DetailColMap = new HashMap<String, Column>();
			for (Column column : tb3DetailColLs)
			{
				if (!tb3DetailColMap.containsKey(column.getName()))
				{
					tb3DetailColMap.put(column.getName(), column);
				}
			}
			logBean.writeLog("+++++++++"+tb2DetailColMap);
			logBean.writeLog("=======0=======");
			String returnStr = "";
			int requestid = 0;
			String tablename = "";

			/*
			 * ��ʼ������sap table��ȡ������������ϸ�������ϵM-N MΪ�����ʵ��dbkey������dictinct dbkey
			 * count NΪ�����Ӧ��������ϸ�����飬��ϸ������������ÿ����ϸ�������ļ�¼�����ܲ�ͬ������dbkey������
			 * ���������ϢΪ�����绰��Ϊ��ϸ��1����ַ��Ϊ��ϸ��2 �������Ϣֻ���������һ��������һ��
			 * ��Ӧ�����������绰���¼Ϊ3������ַΪ2�� ��Ӧ�����������绰���¼Ϊ2������ַΪ����
			 */
			logBean.writeLog("��ʼ������sap table��ȡ������������ϸ�������ϵN-N");

			// ������key-DB_KEY��value�������¼���ݣ�������̻��ж�����ͬ��DB_KEY
			Map<String, SAPRecord> mainTableMap = new HashMap<String, SAPRecord>();

			// ��ϸ�����飬��dbkey+detailTbNameList�ṹ�е�ֵ���key
			Map<String, List<SAPRecord>> tb1SqlMap = null;
			Map<String, List<SAPRecord>> tb2SqlMap = null;
			Map<String, List<SAPRecord>> tb3SqlMap = null;

			logBean.writeLog("=======1======="+basicContract.getNumRows());
			if (basicContract.getNumRows() > 0)
			{
				// �������������Ӧ�������еģ���¼DB_KEY�����ɵ�request_id��¼����
				for (int i = 0; i < basicContract.getNumRows(); i++)
				{
					String ZEMPLOYEE = "-1";
					basicContract.setRow(i); // ���õ�ǰ�м�¼��������ȡ��Ϊ��ǰ������һ����¼����

					// ѭ��map�����е�key,����¼����ת��ΪbasicContractColMap����
					for (Entry<String, Column> kv : basicContractColMap.entrySet())
					{
						String colValue = basicContract.getString(kv.getKey()).trim();
						if ("ZEMPLOYEE".equals(kv.getKey()))
						{
							ZEMPLOYEE = colValue;
						}
						kv.getValue().setValue(colValue);
					}

					for (Entry<String, Column> kv : basicContractColMap.entrySet())
					{
						logBean.writeLog("basicContractColMap==" + kv.getKey() + "||" + kv.getValue());
					}

					// returnStr = "-999,tablename";
					returnStr = createWorkflow(basicContractColMap, ZEMPLOYEE); // ����һ����������
					String[] str = returnStr.split(",");
					requestid = Util.getIntValue(str[0], 0);
					tablename = str[1];
					logBean.writeLog("ET_CO_CONT new requestid =" + requestid + "||tablename=" + tablename);
					logBean.writeLog("ET_CO_CONT new requestid =" + requestid + "||tablename=" + tablename);

					// ������������
					if (!basicContractColMap.containsKey(DB_KEY))
					{
						throw new IllegalArgumentException("basicContractColMap������DB_KEY�ֶ�");
					}

					// ת��Ϊ�����Լ���SAP��¼����ʵ�������������requestidȫ����¼��
					basicContractColMap.put(REQUEST_ID, new Column(REQUEST_ID, String.valueOf(requestid)));
					SAPRecord sapRecord = new SAPRecord(basicContractColMap);
					logBean.writeLog("sapRecord==" + sapRecord);
					Column dbkey = basicContractColMap.get(DB_KEY);
					if (!mainTableMap.containsKey(dbkey))
					{
						mainTableMap.put(dbkey.getValue(), sapRecord);
					}
					
				}

			}
			logBean.writeLog("1233333 =");
			//logBean.writeLog("mainTableMap =" + mainTableMap);
			// ��ͬ�����ϸ��ѭ��
			//logBean.writeLog("tb1Detail.getNumRows() ��ͬ�����ϸ��ѭ�� =" + tb1Detail.getNumRows());
			/*if (tb1Detail.getNumRows() > 0)
			{
				logBean.writeLog("&&&&&&&&&&&&&&&&&&&&&&&&&&");
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb1Detail.getNumRows(); j++)
				{
					tb1Detail.setRow(j);
					String dbk = tb1Detail.getString(DB_KEY).trim();
					logBean.writeLog("&&&&&&&&&&&&&&&&&&&&&&&&&&dbk******"+dbk);
					//String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					//sb.append("requestid=" + reqid + ", ");
					// ��ȡ��ϸ��������Ϊhashmap�ṹ�帴�ƣ�Ȼ��ת��ΪSAPRecord
					//tb1DetailColMap.put(REQUEST_ID, new Column(REQUEST_ID, reqid));
					for (Entry<String, Column> kv : tb1DetailColMap.entrySet())
					{
						String colValue = tb1Detail.getString(kv.getKey()).trim();
						logBean.writeLog("colValue==" + colValue);
						kv.getValue().setValue(colValue);
					}
					for (Entry<String, Column> kv : tb1DetailColMap.entrySet())
					{
						logBean.writeLog("test==" + kv.getKey() + "||" + kv.getValue());
					}
					SAPRecord sapRecord = new SAPRecord(tb1DetailColMap);
					String detialInfo = sb.toString();
					logBean.writeLog("ET_CO_CON_CHG��ͬ�����ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb1SqlMap.containsKey(dbk))
					{
						tb1SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb1SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb1SqlMap.get(dbk).add(sapRecord);
					}
				}
			} else if (tb1Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_CO_POITEM = " + detialInfo);
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			// �ֳ�ǩ֤��ϸ��ѭ��
			logBean.writeLog("tb2Detail.getNumRows() =" + tb2Detail.getNumRows());
			if (tb2Detail.getNumRows() > 0)
			{
				tb2SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb2Detail.getNumRows(); j++)
				{
					tb2Detail.setRow(j);
					String dbk = tb2Detail.getString(DB_KEY).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// ��ȡ��ϸ��������Ϊhashmap�ṹ�帴�ƣ�Ȼ��ת��ΪSAPRecord
					tb2DetailColMap.put(REQUEST_ID, new Column(REQUEST_ID, reqid));
					for (Entry<String, Column> kv : tb2DetailColMap.entrySet())
					{
						String colValue = tb2Detail.getString(kv.getKey()).trim();
						kv.getValue().setValue(colValue);
					}
					SAPRecord sapRecord = new SAPRecord(tb2DetailColMap);
					String detialInfo = sb.toString();
					logBean.writeLog("ET_CO_CON_QZ�ֳ�ǩ֤��ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb2SqlMap.containsKey(dbk))
					{
						tb2SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb2SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb2SqlMap.get(dbk).add(sapRecord);
					}

				}
			} else if (tb2Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_CO_CON_SPLIT = " + detialInfo);
				tb2SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			// ��ͬ������ϸ��ѭ��
			logBean.writeLog("tb3Detail.getNumRows() =" + tb3Detail.getNumRows());
			if (tb3Detail.getNumRows() > 0)
			{
				tb3SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb3Detail.getNumRows(); j++)
				{
					tb3Detail.setRow(j);
					String dbk = tb3Detail.getString(DB_KEY).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// ѭ��map�����е�key,�൱��ȥ����Щ�ֶθ��Ƶ��Ķ�Ӧ��columnʵ��
					tb3DetailColMap.put(REQUEST_ID, new Column(REQUEST_ID, reqid));
					for (Entry<String, Column> kv : tb3DetailColMap.entrySet())
					{
						String colValue = tb3Detail.getString(kv.getKey()).trim();
						kv.getValue().setValue(colValue);
					}
					SAPRecord sapRecord = new SAPRecord(tb3DetailColMap);
					String detialInfo = sb.toString();
					logBean.writeLog("ET_CO_CON_FILE��ͬ������ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb3SqlMap.containsKey(dbk))
					{
						tb3SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb3SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb3SqlMap.get(dbk).add(sapRecord);
					}
				}
			} else if (tb3Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_CO_CON_FILE = " + detialInfo);
				tb3SqlMap = new HashMap<String, List<SAPRecord>>();
			}*/

			SAPConn.releaseC(myConnection);

			/*logBean.writeLog("=======2=======");

			// ��ͬ�����ϸ��
			String logtitleTb1 = "����OA��ͬ�����ϸ��SQL=";
			RecordSet rsTb1 = new RecordSet();
			RecordSet rsTb1Add = new RecordSet();

			// �ֳ�ǩ֤��ϸ��
			String logtitleTb2 = "����OA�ֳ�ǩ֤��ϸ��SQL=";
			RecordSet rsTb2 = new RecordSet();
			RecordSet rsTb2Add = new RecordSet();

			// ��ͬ������ϸ��
			String logtitleTb3 = "����OA��ͬ������ϸ��SQL=";
			RecordSet rsTb3 = new RecordSet();
			RecordSet rsTb3Add = new RecordSet();

			executeSQLforDetail(tablename, "_dt1", tb1SqlMap, rsTb1, rsTb1Add, logtitleTb1);
			//executeSQLforDetail(tablename, "_dt2", tb2SqlMap, rsTb2, rsTb2Add, logtitleTb2);
			//executeSQLforDetail(tablename, "_dt3", tb3SqlMap, rsTb3, rsTb3Add, logtitleTb3);
			
			logBean.writeLog("===========����Э�����=============");*/
		} else
		{
			logBean.writeLog("SAP connection fail");
		}
	}

	private void executeSQLforDetail(String tablename, String dtName, Map<String, List<SAPRecord>> rsMap,
			RecordSet mainRs, RecordSet insertRs, String logtitle)
	{
		// ѭ����ͬdbkey�µ���ϸ����
		for (String dbkey : rsMap.keySet())
		{
			for (SAPRecord sapRecord : rsMap.get(dbkey))
			{
				Map<String, Column> sqlMap = sapRecord.getColumnMap();
				if (sqlMap.size() > 0)
				{
					// ��ȡ����id
					String sql = "select id from " + tablename + " where requestid = '"
							+ sqlMap.get(REQUEST_ID).getValue() + "'";// dt����û��requestid��ֻ��mainid
					logBean.writeLog(sql);
					mainRs.executeSql(sql);
					while (mainRs.next())
					{
						String mainid = Util.null2String(mainRs.getString("id"));
						logBean.writeLog("mainid = " + mainid);

						StringBuilder insertSqlSb = new StringBuilder();
						insertSqlSb.append("insert into ");
						insertSqlSb.append(tablename + dtName + "(mainid,");
						int ci = 0;
						int csize = sqlMap.size();
						Set<String> colNames = sqlMap.keySet();
						for (String colname : colNames)
						{
							if (!REQUEST_ID.equals(colname))
							{
								// ƴ��sql���һ������Ҫ���,�ţ��˴���Ϊû�й�������ʱ����ôʵ��
								if (ci == csize - 2)
								{
									insertSqlSb.append(colname);
								} else
								{
									insertSqlSb.append(colname + ",");
								}
								ci++;
							}
						}
						insertSqlSb.append(") values ('" + mainid + "',");
						int vi = 0;
						int vsize = sqlMap.size();
						for (String colname : colNames)
						{
							if (!REQUEST_ID.equals(colname))
							{
								// ƴ��sql���һ������Ҫ���,�ţ��˴���Ϊû�й�������ʱ����ôʵ��
								if (sqlMap.containsKey(colname))
								{
									if (vi == vsize - 2)
									{
										insertSqlSb.append("'" + sqlMap.get(colname).getValue() + "'");
									} else
									{
										insertSqlSb.append("'" + sqlMap.get(colname).getValue() + "',");
									}
								} else
								{
									insertSqlSb.append("''"); // �ֶ�ֵ�����ڲ�����ַ�������ֹ�в���Ӧ����
								}
								vi++;
							}
						}
						insertSqlSb.append(")");
						String insertSQL = insertSqlSb.toString();
						logBean.writeLog(logtitle + insertSQL);
						insertRs.executeSql(insertSQL);
					}
				}
			}
		}

	}

	private String createWorkflow(Map<String, Column> mainTableMap, String ZEMPLOYEE)
	{
		String newRequestid = "-1000";
		String resourceid = ZEMPLOYEE;

		String TODAY = TimeUtil.getCurrentDateString();
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();

		String tablename = "";
		String lastname = "";
		rs.executeSql("select lastname,subcompanyid1 from hrmresource where id = '" + ZEMPLOYEE + "'");
		rs.writeLog("select lastname,subcompanyid1 from hrmresource where id = '" + ZEMPLOYEE + "'");
		while (rs.next())
		{
			lastname = Util.null2String(rs.getString("lastname"));
		}

		String workflowid = "3814";// ����Э������workflowid
		String SQL = "select tablename from workflow_base wb,workflow_bill wbi where wb.formid = wbi.id and wb.id = '"
				+ workflowid + "'";
		rs1.executeSql(SQL);
		rs1.writeLog("gettablenamesql=" + SQL);
		while (rs1.next())
		{
			tablename = Util.null2String(rs1.getString("tablename"));
		}
		logBean.writeLog("����Э�����̵�workflowid=" + workflowid + "||resourceid=" + resourceid);

		RequestService requestService = new RequestService();
		RequestInfo requestInfo = new RequestInfo();
		requestInfo.setWorkflowid(workflowid);
		requestInfo.setCreatorid(resourceid);
		requestInfo.setDescription("����Э������-" + lastname + "-" + TODAY.replace("-", ""));
		requestInfo.setRequestlevel("1");
		requestInfo.setIsNextFlow("0");

		// ������Ϣ
		MainTableInfo mainTableInfo = new MainTableInfo();
		List<Property> fields = new ArrayList<Property>();
		Property field = null;

		for (Entry<String, Column> kv : mainTableMap.entrySet())
		{
			field = new Property();
			field.setName(kv.getKey());
			field.setValue(kv.getValue().getValue());
			fields.add(field);
		}

		Property[] fieldarray = (Property[]) fields.toArray(new Property[fields.size()]);
		mainTableInfo.setProperty(fieldarray);
		requestInfo.setMainTableInfo(mainTableInfo);

		try
		{
			newRequestid = requestService.createRequest(requestInfo);
			logBean.writeLog("======��������ʱ�����ɵ�id=======" + newRequestid);
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			logBean.writeLog("���̴���ʧ�ܣ�����");
			e.printStackTrace();
		}
		return newRequestid + "," + tablename;
	}
}
