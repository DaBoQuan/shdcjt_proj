package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

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
 * �б���
 * 
 * @author Administrator
 * 
 */
public class TenderResult  extends BaseCronJob
{
	private static final String REQUEST_ID = "requestid";
	private static final String BANFN = "BANFN";
	private BaseBean logBean = new BaseBean();
	private SAPConnPool SAPConn = new SAPConnPool();

	public void execute()
	{
		Client myConnection = SAPConn.getConnection();
		myConnection.connect();
		if (myConnection != null && myConnection.isAlive())
		{
			System.out.println("==========�б���=============");
			System.out.println("======connection success======");
			JCO.Repository myRepository = new JCO.Repository("Repository", myConnection); // �������
			IFunctionTemplate ft = myRepository.getFunctionTemplate("ZPO_RESULT_NEW"); // ��ȡ�б���ģ��
			JCO.Function function = ft.getFunction();

			// ��ú�����import�����б�
			JCO.ParameterList input = function.getImportParameterList();
			JCO.ParameterList inputtable = function.getTableParameterList();
			myConnection.execute(function);

			ParameterList outputTable = function.getTableParameterList(); // �����Ĵ���
			Table basicContract = outputTable.getTable("ET_PO"); // ���������Ϣ������

			// ��ϸ��������excel���˳��������tb1, tb2, tb3
			Table tb1Detail = outputTable.getTable("ET_VENDOR"); // ET_VENDOR��Ϣ����ϸ��
			Table tb2Detail = outputTable.getTable("ET_ZD"); // ET_ZD��Ϣ����ϸ��
			Table tb3Detail = outputTable.getTable("ET_ZCBPBJ"); // ET_ZCBPBJ��Ϣ����ϸ��
			Table tb4Detail = outputTable.getTable("ET_FILE"); // ET_FILE��Ϣ����ϸ��

			// IS_PO��Ϣ�������ֶ���ֵ
			List<Column> basicContractColLs = Arrays.asList(new Column[] { new Column(BANFN, ""),
					new Column("ZZBNAME", ""), new Column("POST1", ""), new Column("ZHBLX", ""),
					new Column("ZEMPLOYEE", ""), new Column("ZBZ", ""), new Column("ZCUSER", "") });

			// �˴�����Ϊ�˹���IS_PO�����ṹHashMap����Ӧ������table�ṹhash��key-�ֶ�����value-�ֶ�ʵ���൱������ĵ�����¼
			Map<String, Column> basicContractColMap = new HashMap<String, Column>();
			for (Column column : basicContractColLs)
			{
				if (!basicContractColMap.containsKey(column.getName()))
				{
					basicContractColMap.put(column.getName(), column);
				}
			}

			// ET_VENDOR��Ϣ����ϸ��
			List<Column> tb1DetailColLs = Arrays.asList(new Column[] { new Column(BANFN, ""), new Column("NAME1", ""),
					new Column("PLANCON", ""), new Column("PLANCON_DES", ""), new Column("CON_TAMT", ""),
					new Column("CON_LAMT", ""), new Column("ZZHBJ", ""), new Column("ZZBDATE", "") });

			// �˴�����Ϊ�˹���ET_VENDOR��Ϣ��ϸ��ṹHashMap����Ӧ������table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb1DetailColMap = new HashMap<String, Column>();
			for (Column column : tb1DetailColLs)
			{
				if (!tb1DetailColMap.containsKey(column.getName()))
				{
					tb1DetailColMap.put(column.getName(), column);
				}
			}

			logBean.writeLog("+++++++++" + tb1DetailColMap);
			// ET_ZD����ϸ��
			List<Column> tb2DetailColLs = Arrays
					.asList(new Column[] { new Column(BANFN, ""), new Column("ZZBNAME", ""), new Column("ZYDSP2", ""),
							new Column("ZYDSP3", ""), new Column("ZCGGCL", ""), new Column("ZJLDW", ""),
							new Column("ZHBLX", ""), new Column("ZBZ", "") });
			// �˴�����Ϊ�˹���ET_ZD�ṹHashMap����Ӧ����ϸ��table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb2DetailColMap = new HashMap<String, Column>();
			for (Column column : tb2DetailColLs)
			{
				if (!tb2DetailColMap.containsKey(column.getName()))
				{
					tb2DetailColMap.put(column.getName(), column);
				}
			}

			logBean.writeLog("+++++++++" + tb2DetailColMap);
			// ET_ZCBPBJ��Ϣ����ϸ��
			List<Column> tb3DetailColLs = Arrays.asList(new Column[] { new Column(BANFN, ""), new Column("ZYDSP2", ""),
					new Column("ZYDSP3", ""), new Column("ZCGGCL", ""), new Column("ZJLDW", ""),
					new Column("ZHBLX", ""), new Column("ZPPSP4", ""), new Column("ZBZ", "") });

			// �˴�����Ϊ��ET_ZCBPBJ��Ϣϸ��ṹHashMap����Ӧ����ϸ��table�ṹhash��key-�ֶ�����value-�ֶ�ʵ��
			Map<String, Column> tb3DetailColMap = new HashMap<String, Column>();
			for (Column column : tb3DetailColLs)
			{
				if (!tb3DetailColMap.containsKey(column.getName()))
				{
					tb3DetailColMap.put(column.getName(), column);
				}
			}
			logBean.writeLog("+++++++++" + tb3DetailColMap);

			// ET_FILE����ϸ��
			List<Column> tb4DetailColLs = Arrays.asList(new Column[] { new Column(BANFN, ""), new Column("ZWJMC", ""),
					new Column("ZWJNR", ""), new Column("UNAME", ""), new Column("DATUM", "") });

			Map<String, Column> tb4DetailColMap = new HashMap<String, Column>();
			for (Column column : tb4DetailColLs)
			{
				if (!tb4DetailColMap.containsKey(column.getName()))
				{
					tb4DetailColMap.put(column.getName(), column);
				}
			}

			System.out.println("=======0=======");
			String returnStr = "";
			int requestid = 0;
			String tablename = "";

			/*
			 * ��ʼ������sap table��ȡ������������ϸ�������ϵM-N MΪ�����ʵ��dbkey������dictinct dbkey
			 * count NΪ�����Ӧ��������ϸ�����飬��ϸ������������ÿ����ϸ�������ļ�¼�����ܲ�ͬ������BANFN������
			 * ���������ϢΪ�����绰��Ϊ��ϸ��1����ַ��Ϊ��ϸ��2 �������Ϣֻ���������һ��������һ��
			 * ��Ӧ�����������绰���¼Ϊ3������ַΪ2�� ��Ӧ�����������绰���¼Ϊ2������ַΪ����
			 */
			System.out.println("��ʼ������sap table��ȡ������������ϸ�������ϵN-N");

			// ���������Ϣ��key-DB_KEY��value�ǽ��������Ϣ��¼���ݣ�������̻��ж�����ͬ��DB_KEY
			Map<String, SAPRecord> mainTableMap = new HashMap<String, SAPRecord>();

			// ��ϸ�����飬��BANFNΪkey��Ӧ��ÿ����ϸ����
			Map<String, List<SAPRecord>> tb1SqlMap = null;
			Map<String, List<SAPRecord>> tb2SqlMap = null;
			Map<String, List<SAPRecord>> tb3SqlMap = null;
			Map<String, List<SAPRecord>> tb4SqlMap = null;

			System.out.println("=======1=======");
			if (basicContract.getNumRows() > 0)
			{
				// ����IS_PO��Ϣ��Ӧ�������еģ���¼BANFN�����ɵ�request_id��¼����
				for (int i = 0; i < basicContract.getNumRows(); i++)
				{
					String ZEMPLOYEE = "-1";
					basicContract.setRow(i); // ���õ�ǰ�м�¼��������ȡ��Ϊ��ǰ������һ����¼����

					// ѭ��map�����е�key,����¼����ת��ΪbasicContractColMap����
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : basicContractColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(basicContract.getString(kv.getKey())) ? "" : StringUtils
								.trim(basicContract.getString(kv.getKey()));
						if ("ZEMPLOYEE".equals(kv.getKey()))
						{
							ZEMPLOYEE = colValue;
						}
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}

					for (Entry<String, Column> kv : sapRecord.getColumnMap().entrySet())
					{
						logBean.writeLog("sapRecord.getColumnMap()==" + kv.getKey() + "||" + kv.getValue());
					}

					// returnStr = "-999,tablename";
					returnStr = createWorkflow(sapRecord.getColumnMap(), ZEMPLOYEE); // ����һ�����������Ϣ����
					String[] str = returnStr.split(",");
					requestid = Util.getIntValue(str[0], 0);
					tablename = str[1];
					logBean.writeLog("IS_PO new requestid =" + requestid + "||tablename=" + tablename);
					System.out.println("IS_PO new requestid =" + requestid + "||tablename=" + tablename);

					// ����IS_PO��Ϣ����
					if (!basicContractColMap.containsKey(BANFN))
					{
						throw new IllegalArgumentException("basicContractColMap������BANFN�ֶ�");
					}

					// ת��Ϊ�����Լ���SAP��¼����ʵ��ѽ��������Ϣ������requestidȫ����¼��
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, String.valueOf(requestid)));
					logBean.writeLog("sapRecord==" + sapRecord);
					Column dbkey = sapRecord.getColumnMap().get(BANFN);
					if (!mainTableMap.containsKey(dbkey))
					{
						mainTableMap.put(dbkey.getValue(), sapRecord);
					}
				}

			}

			// ET_VENDOR��Ϣ��ϸ��ѭ��
			logBean.writeLog("tb1Detail.getNumRows() =" + tb1Detail.getNumRows());
			if (tb1Detail.getNumRows() > 0)
			{
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb1Detail.getNumRows(); j++)
				{
					tb1Detail.setRow(j);
					String dbk = tb1Detail.getString(BANFN).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";
					logBean.writeLog("dbk & reqid = " + dbk + "||reqid=" + reqid);

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");
					// ��ȡ��ϸ��������Ϊhashmap�ṹ�帴�ƣ�Ȼ��ת��ΪSAPRecord
					logBean.writeLog("tb1DetailColMap.keySet() = " + tb1DetailColMap.keySet());
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : tb1DetailColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(tb1Detail.getString(kv.getKey())) ? "" : StringUtils
								.trim(tb1Detail.getString(kv.getKey()));

						logBean.writeLog("tb1DetailColMap colValue = " + colValue);
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, reqid));
					logBean.writeLog("ET_VENDOR�б�����Ϣ��ϸ��������� sapRecord = " + sapRecord.getColumnMap());
					String detialInfo = sb.toString();
					logBean.writeLog("ET_VENDOR�б�����Ϣ��ϸ��������� = " + detialInfo);

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
				logBean.writeLog("ET_VENDOR�б�����Ϣ��ϸ��������� = tb1SqlMap" + tb1SqlMap);
			} else if (tb1Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_VENDOR = " + detialInfo);
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			// ����Э����Ϣ��ϸ��ѭ��
			logBean.writeLog("tb2Detail.getNumRows() =" + tb2Detail.getNumRows());
			if (tb2Detail.getNumRows() > 0)
			{
				tb2SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb2Detail.getNumRows(); j++)
				{
					tb2Detail.setRow(j);
					String dbk = tb2Detail.getString(BANFN).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// ��ȡ��ϸ��������Ϊhashmap�ṹ�帴�ƣ�Ȼ��ת��ΪSAPRecord
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : tb2DetailColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(tb2Detail.getString(kv.getKey())) ? "" : StringUtils
								.trim(tb2Detail.getString(kv.getKey()));
						logBean.writeLog("tb2DetailColMap colValue = " + colValue);
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, reqid));
					logBean.writeLog("ET_ZD�б�����Ϣ��ϸ��������� sapRecord = " + sapRecord.getColumnMap());
					String detialInfo = sb.toString();
					logBean.writeLog("ET_ZD�б�����Ϣ��ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb2SqlMap.containsKey(dbk))
					{
						tb2SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb2SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb2SqlMap.get(dbk).add(sapRecord);
					}
					logBean.writeLog("ET_ZD�б��������Ϣ��ϸ��������� = tb2SqlMap" + tb2SqlMap);
				}
			} else if (tb2Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_ZD = " + detialInfo);
				tb2SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			// ��Ʊ��ʵ��Ӱ�췽��Ϣ��ϸ��ѭ��
			logBean.writeLog("tb3Detail.getNumRows() =" + tb3Detail.getNumRows());
			if (tb3Detail.getNumRows() > 0)
			{
				tb3SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb3Detail.getNumRows(); j++)
				{
					tb3Detail.setRow(j);
					String dbk = tb3Detail.getString(BANFN).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// ѭ��map�����е�key,�൱��ȥ����Щ�ֶθ��Ƶ��Ķ�Ӧ��columnʵ��
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : tb3DetailColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(tb3Detail.getString(kv.getKey())) ? "" : StringUtils
								.trim(tb3Detail.getString(kv.getKey()));
						logBean.writeLog("tb3DetailColMap colValue = " + colValue);
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, reqid));
					logBean.writeLog("ET_ZCBPBJ��Ʊ��ʵ��Ӱ�췽��Ϣ��ϸ��������� sapRecord = " + sapRecord.getColumnMap());
					String detialInfo = sb.toString();
					logBean.writeLog("ET_ZCBPBJ��Ʊ��ʵ��Ӱ�췽��Ϣ��ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb3SqlMap.containsKey(dbk))
					{
						tb3SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb3SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb3SqlMap.get(dbk).add(sapRecord);
					}
					logBean.writeLog("ET_ZCBPBJ��Ʊ��ʵ��Ӱ�췽��Ϣ��ϸ��������� = tb3SqlMap" + tb3SqlMap);
				}
			} else if (tb3Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_ZCBPBJ = " + detialInfo);
				tb3SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			// ��Ʊ�����η���Ϣѭ��
			logBean.writeLog("tb4Detail.getNumRows() =" + tb4Detail.getNumRows());
			if (tb4Detail.getNumRows() > 0)
			{
				tb4SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb4Detail.getNumRows(); j++)
				{
					tb4Detail.setRow(j);
					String dbk = tb4Detail.getString(BANFN).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// ѭ��map�����е�key,�൱��ȥ����Щ�ֶθ��Ƶ��Ķ�Ӧ��columnʵ��
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : tb4DetailColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(tb4Detail.getString(kv.getKey())) ? "" : StringUtils
								.trim(tb4Detail.getString(kv.getKey()));
						logBean.writeLog("tb4DetailColMap colValue = " + colValue);
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, reqid));
					logBean.writeLog("ET_FILES��Ʊ�����η���Ϣ��ϸ��������� sapRecord = " + sapRecord.getColumnMap());
					String detialInfo = sb.toString();
					logBean.writeLog("ET_FILES��Ʊ�����η���Ϣ��ϸ��������� = " + detialInfo);

					// ��ѭ������
					if (!tb4SqlMap.containsKey(dbk))
					{
						tb4SqlMap.put(dbk, new ArrayList<SAPRecord>());
						tb4SqlMap.get(dbk).add(sapRecord);
					} else
					{
						tb4SqlMap.get(dbk).add(sapRecord);
					}
					logBean.writeLog("ET_FILES��Ʊ�����η���Ϣ��ϸ��������� = tb3SqlMap" + tb3SqlMap);
				}
			} else if (tb4Detail.getNumRows() == 0)
			{
				String detialInfo = "";
				logBean.writeLog("ET_FILES = " + detialInfo);
				tb4SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			SAPConn.releaseC(myConnection);

			System.out.println("=======2=======");

			// ET_VENDOR��Ϣ��ϸ��
			String logtitleTb1 = "����OA�б���ET_VENDOR��ϸ��SQL=";
			RecordSet rsTb1 = new RecordSet();
			RecordSet rsTb1Add = new RecordSet();

			// ET_ZD��Ϣ��ϸ��
			String logtitleTb2 = "����OA�б���ET_ZD��ϸ��SQL=";
			RecordSet rsTb2 = new RecordSet();
			RecordSet rsTb2Add = new RecordSet();

			// ET_ZCBPBJ��Ϣ��ϸ��
			String logtitleTb3 = "����OA�б���ET_ZCBPBJ��ϸ��SQL=";
			RecordSet rsTb3 = new RecordSet();
			RecordSet rsTb3Add = new RecordSet();

			// ET_FILE��Ϣ��ϸ��
			String logtitleTb4 = "����OA�б���ET_FILE��ϸ��SQL=";
			RecordSet rsTb4 = new RecordSet();
			RecordSet rsTb4Add = new RecordSet();

			executeSQLforDetail(tablename, "_dt1", tb1SqlMap, rsTb1, rsTb1Add, logtitleTb1);
			executeSQLforDetail(tablename, "_dt2", tb2SqlMap, rsTb2, rsTb2Add, logtitleTb2);
			executeSQLforDetail(tablename, "_dt3", tb3SqlMap, rsTb3, rsTb3Add, logtitleTb3);
			executeSQLforDetail(tablename, "_dt4", tb4SqlMap, rsTb4, rsTb4Add, logtitleTb4);

			logBean.writeLog("===========�б�������=============");
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
					// ��ȡ���������Ϣid
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

		String workflowid = "3809";// �б�������workflowid
		String SQL = "select tablename from workflow_base wb,workflow_bill wbi where wb.formid = wbi.id and wb.id = '"
				+ workflowid + "'";
		rs1.executeSql(SQL);
		rs1.writeLog("gettablenamesql=" + SQL);
		while (rs1.next())
		{
			tablename = Util.null2String(rs1.getString("tablename"));
		}
		logBean.writeLog("�б������̵�workflowid=" + workflowid + "||resourceid=" + resourceid);

		RequestService requestService = new RequestService();
		RequestInfo requestInfo = new RequestInfo();
		requestInfo.setWorkflowid(workflowid);
		requestInfo.setCreatorid(resourceid);
		requestInfo.setDescription("�б�������-" + lastname + "-" + TODAY.replace("-", ""));
		requestInfo.setRequestlevel("1");
		requestInfo.setIsNextFlow("0");

		// �б�����Ϣ
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
