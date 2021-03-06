package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

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
 * 合同请款
 * 
 * @author David.dai
 * 
 */
public class ContractPayment extends BaseCronJob
{
	private static final String REQUEST_ID = "requestid";
	private static final String DB_KEY = "DB_KEY";
	private BaseBean logBean = new BaseBean();
	private SAPConnPool SAPConn = new SAPConnPool();

	public void execute()
	{
		Client myConnection = SAPConn.getConnection();
		myConnection.connect();
		if (myConnection != null && myConnection.isAlive())
		{
			System.out.println("==========合同请款=============");
			System.out.println("======connection success======");
			JCO.Repository myRepository = new JCO.Repository("Repository", myConnection); // 活动的连接
			IFunctionTemplate ft = myRepository.getFunctionTemplate("ZDC_CO_POR"); // 获取合同请款模板
			JCO.Function function = ft.getFunction();

			// 获得函数的import参数列表
			JCO.ParameterList input = function.getImportParameterList();
			JCO.ParameterList inputtable = function.getTableParameterList();
			myConnection.execute(function);

			ParameterList outputTable = function.getTableParameterList(); // 输出表的处理
			Table basicContract = outputTable.getTable("ET_CO_POR"); // 合同请款（主表）

			// 明细表数据以excel表的顺序来决定tb1, tb2, tb3
			Table tb1Detail = outputTable.getTable("ET_CO_CON_FILE"); // 合同附件（明细表）

			// 合同请款（主表）字段与值
			List<Column> basicContractColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""),
					new Column("PAY_TYPE", ""), new Column("CONTRACTNO", ""), new Column("CONTRACTNO", ""),
					new Column("ACONTNO", ""), new Column("BUKRS", ""), new Column("BUTXT", ""),
					new Column("CONTRACTNAME", ""), new Column("LIFNR", ""), new Column("NAME1", ""),
					new Column("POST1", ""), new Column("BANK_ACC_NAM", ""), new Column("BANK_ACC", ""),
					new Column("CURR_REQ", ""), new Column("WAERS", ""), new Column("CONTTCURR", ""),
					new Column("AGGAMT", ""), new Column("LJJDK", ""), new Column("JSJE", ""),
					new Column("BCLJYF", ""), new Column("WAERS1", ""), new Column("LJHDCZ", ""),
					new Column("ACCU_SUM", ""), new Column("CURR_ACT", ""), new Column("USAGE", ""),
					new Column("ACCU_PAY", ""), new Column("CUNAME", ""), new Column("CDEPT_DESC", ""),
					new Column("CDIVISION_DESC", ""), new Column("CREA_DATE", ""), new Column("PURID", ""),
					new Column("STATUS", ""), new Column("APPSTATUS", ""), new Column("BUTXT1", ""),
					new Column("ACCU_INV", ""), new Column("ZEMPLOYEE", "") });

			// 此处都是为了构建主表表结构HashMap，对应的主表table结构hash，key-字段名，value-字段实体相当于主表的单条记录
			Map<String, Column> basicContractColMap = new HashMap<String, Column>();
			for (Column column : basicContractColLs)
			{
				if (!basicContractColMap.containsKey(column.getName()))
				{
					basicContractColMap.put(column.getName(), column);
				}
			}

			// 合同附件（明细表）
			List<Column> tb1DetailColLs = Arrays.asList(new Column[] { new Column(DB_KEY, ""),
					new Column("ZFILE_NO", ""), new Column("ZWJMC", ""), new Column("ZFILE_PATH", ""),
					new Column("UNAME", ""), new Column("DATUM", "") });

			// 此处都是为了构建合同附件细表结构HashMap，对应的明细表table结构hash，key-字段名，value-字段实体
			Map<String, Column> tb1DetailColMap = new HashMap<String, Column>();
			for (Column column : tb1DetailColLs)
			{
				if (!tb1DetailColMap.containsKey(column.getName()))
				{
					tb1DetailColMap.put(column.getName(), column);
				}
			}
			logBean.writeLog("+++++++++" + tb1DetailColMap);
			System.out.println("=======0=======");
			String returnStr = "";
			int requestid = 0;
			String tablename = "";

			/*
			 * 开始构建从sap table获取到的主表与明细表关联关系M-N M为主表的实际dbkey数量，dictinct dbkey
			 * count N为主表对应的所有明细表详情，明细表详情里面他每个明细表所含的记录数可能不同都是以dbkey做关联
			 * 例如个人信息为主表，电话表为明细表1，地址表为明细表2 则个人信息只会出现张三一条，李四一条
			 * 对应的张三所属电话表记录为3条，地址为2条 对应的李四所属电话表记录为2条，地址为起跳
			 */
			System.out.println("开始构建从sap table获取到的主表与明细表关联关系N-N");

			// 主表以key-DB_KEY，value是主表记录数据，多个流程会有多条不同的DB_KEY
			Map<String, SAPRecord> mainTableMap = new HashMap<String, SAPRecord>();

			// 明细表详情，以dbkey为key对应的每个明细表集合
			Map<String, List<SAPRecord>> tb1SqlMap = null;

			System.out.println("=======1=======");
			if (basicContract.getNumRows() > 0)
			{
				// 创建所有主表对应主流程中的，记录DB_KEY所生成的request_id记录下来
				for (int i = 0; i < basicContract.getNumRows(); i++)
				{
					String ZEMPLOYEE = "-1";
					basicContract.setRow(i); // 设置当前行记录索引，获取的为当前索引的一条记录数据

					// 循环map总所有的key,将记录数据转换为basicContractColMap数据
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
					returnStr = createWorkflow(sapRecord.getColumnMap(), ZEMPLOYEE); // 创建一个主表流程
					String[] str = returnStr.split(",");
					requestid = Util.getIntValue(str[0], 0);
					tablename = str[1];
					logBean.writeLog("ET_CO_POR new requestid =" + requestid + "||tablename=" + tablename);
					System.out.println("ET_CO_POR new requestid =" + requestid + "||tablename=" + tablename);

					// 插入主表数据
					if (!basicContractColMap.containsKey(DB_KEY))
					{
						throw new IllegalArgumentException("basicContractColMap不包含DB_KEY字段");
					}

					// 转换为我们自己的SAP记录数据实体把主表所生成requestid全部记录了
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, String.valueOf(requestid)));
					logBean.writeLog("sapRecord==" + sapRecord);
					Column dbkey = sapRecord.getColumnMap().get(DB_KEY);
					if (!mainTableMap.containsKey(dbkey))
					{
						mainTableMap.put(dbkey.getValue(), sapRecord);
					}
				}

			}

			// 合同附件明细表循环
			logBean.writeLog("tb1Detail.getNumRows() =" + tb1Detail.getNumRows());
			if (tb1Detail.getNumRows() > 0)
			{
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
				for (int j = 0; j < tb1Detail.getNumRows(); j++)
				{
					tb1Detail.setRow(j);
					String dbk = tb1Detail.getString(DB_KEY).trim();
					String reqid = mainTableMap.containsKey(dbk) ? mainTableMap.get(dbk).getValueByKey(REQUEST_ID) : "";

					StringBuilder sb = new StringBuilder();
					sb.append("requestid=" + reqid + ", ");

					// 循环map总所有的key,相当于去除这些字段复制到的对应的column实体
					SAPRecord sapRecord = new SAPRecord();
					for (Entry<String, Column> kv : tb1DetailColMap.entrySet())
					{
						String colValue = StringUtils.isBlank(tb1Detail.getString(kv.getKey())) ? "" : StringUtils
								.trim(tb1Detail.getString(kv.getKey()));
						logBean.writeLog("tb1DetailColMap colValue = " + colValue);
						sapRecord.putKeyValue(kv.getKey(), new Column(kv.getKey(), colValue));
					}
					sapRecord.putKeyValue(REQUEST_ID, new Column(REQUEST_ID, reqid));

					String detailInfo = sb.toString();
					logBean.writeLog("ET_CO_CON_FILE合同附件明细表插入数据 = " + detailInfo);

					// 在循环所有
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
				String detailInfo = "";
				logBean.writeLog("ET_CO_CON_FILE = " + detailInfo);
				tb1SqlMap = new HashMap<String, List<SAPRecord>>();
			}

			SAPConn.releaseC(myConnection);

			System.out.println("=======2=======");

			// 合同附件明细表
			String logtitleTb1 = "插入OA合同附件明细表SQL=";
			RecordSet rsTb1 = new RecordSet();
			RecordSet rsTb1Add = new RecordSet();

			executeSQLforDetail(tablename, "_dt1", tb1SqlMap, rsTb1, rsTb1Add, logtitleTb1);

			logBean.writeLog("===========合同请款结束=============");
		} else
		{
			logBean.writeLog("SAP connection fail");
		}
	}

	private void executeSQLforDetail(String tablename, String dtName, Map<String, List<SAPRecord>> rsMap,
			RecordSet mainRs, RecordSet insertRs, String logtitle)
	{
		// 循环不同dbkey下的明细数据
		for (String dbkey : rsMap.keySet())
		{
			for (SAPRecord sapRecord : rsMap.get(dbkey))
			{
				Map<String, Column> sqlMap = sapRecord.getColumnMap();
				if (sqlMap.size() > 0)
				{
					// 获取主表id
					String sql = "select id from " + tablename + " where requestid = '"
							+ sqlMap.get(REQUEST_ID).getValue() + "'";// dt表中没有requestid，只有mainid
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
								// 拼接sql最后一个不需要添加,号，此处因为没有工具类暂时先这么实现
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
								// 拼接sql最后一个不需要添加,号，此处因为没有工具类暂时先这么实现
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
									insertSqlSb.append("''"); // 字段值不存在插入空字符串，防止列不对应报错
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
		logBean.writeLog("ZEMPLOYEE=" + ZEMPLOYEE + ", ZEMPLOYEE == null?" + ZEMPLOYEE == null);
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

		String workflowid = "3812";// 合同请款流程workflowid
		String SQL = "select tablename from workflow_base wb,workflow_bill wbi where wb.formid = wbi.id and wb.id = '"
				+ workflowid + "'";
		rs1.executeSql(SQL);
		rs1.writeLog("gettablenamesql=" + SQL);
		while (rs1.next())
		{
			tablename = Util.null2String(rs1.getString("tablename"));
		}
		logBean.writeLog("合同请款流程的workflowid=" + workflowid + "||resourceid=" + resourceid);

		RequestService requestService = new RequestService();
		RequestInfo requestInfo = new RequestInfo();
		requestInfo.setWorkflowid(workflowid);
		requestInfo.setCreatorid(resourceid);
		requestInfo.setDescription("合同请款流程-" + lastname + "-" + TODAY.replace("-", ""));
		requestInfo.setRequestlevel("1");
		requestInfo.setIsNextFlow("0");

		// 主表信息
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
			logBean.writeLog("======创建流程时新生成的id=======" + newRequestid);
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			logBean.writeLog("流程创建失败！！！");
			e.printStackTrace();
		}
		return newRequestid + "," + tablename;
	}
}
