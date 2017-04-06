<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetCT" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetCL" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="CRMSearchComInfo" class="weaver.crm.search.SearchComInfo" scope="session" />
<jsp:useBean id="CustomerSizeComInfo" class="weaver.crm.Maint.CustomerSizeComInfo" scope="page" />
<jsp:useBean id="CustomerDescComInfo" class="weaver.crm.Maint.CustomerDescComInfo" scope="page" />
<jsp:useBean id="CustomerStatusComInfo" class="weaver.crm.Maint.CustomerStatusComInfo" scope="page" />
<jsp:useBean id="SectorInfoComInfo" class="weaver.crm.Maint.SectorInfoComInfo" scope="page" />

<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="VerifyPowerToCustomers" class="weaver.crm.VerifyPowerToCustomers" scope="session" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<% /*ȡ��ҳ���ϵ�ѡ���ĸ�Ԫ�ص�ֵ*/
String types="";  //�����͡�Sql�ĳ�ʼ��
String CustomerTypes[]=request.getParameterValues("CustomerTypes");//Types��һ������
CRMSearchComInfo.resetSearchInfo();//��CRMSearchComInfo.set~()��ʼ��
if(CustomerTypes != null)
{
	for(int i=0;i<CustomerTypes.length;i++)
	{
		CRMSearchComInfo.addCustomerType(CustomerTypes[i]);//�ѡ����͡�ֵ���뵽CRMSearchComInfo
		if(!types.equals(""))
		types=types+","+CustomerTypes[i];
		else types+=CustomerTypes[i];
	}
}
String sector=Util.null2String(request.getParameter("CustomerSector"));
String desc=Util.null2String(request.getParameter("CustomerDesc"));
String status=Util.null2String(request.getParameter("CustomerStatus"));
String size=Util.null2String(request.getParameter("CustomerSize"));
//��ֵ���뵽CRMSearchComInfo
CRMSearchComInfo.setCustomerSector(sector);
CRMSearchComInfo.setCustomerDesc(desc);
CRMSearchComInfo.setCustomerStatus(status);
CRMSearchComInfo.setCustomerSize(size);


/*���β�ѯ,��һ�εó���id,Ϊ�˵þ�γ��;�ڶ��β�ÿһ���������ѯ�����µ����ͼ�����*/
String sqlwhere = "";//��һ��sql��where��������ʼ��
String sqlResult="";//;�ڶ���sql��where��������ʼ��

int ishead = 0;//ishead = 0��ʾǰ��������ishead = 1��ǰ��������
if(!sector.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.sector = "+ sector + " ";
		sqlResult+= " where t1.sector = "+ sector + " ";
	}else{
		sqlwhere += " and t1.sector = "+ sector + " ";
		sqlResult+= " and t1.sector = "+ sector + " ";
		}
}
if(!desc.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.description = "+ desc + " ";
		sqlResult+= " where t1.description = "+ desc + " ";
	}else{
		sqlwhere += " and t1.description = "+ desc + " ";
		sqlResult+= " and t1.description = "+ desc + " ";
		}
}
if(!status.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.status = "+ status + " ";
		sqlResult += " where t1.status = "+ status + " ";
	}else{
		sqlwhere += " and t1.status = "+ status + " ";
		sqlResult += " and t1.status = "+ status + " ";
		}

}
if(!size.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.size_n = "+ size + " ";
		sqlResult += " where t1.size_n = "+ size + " ";
	}else{
		sqlwhere += " and t1.size_n = "+ size + " ";
		sqlResult += " and t1.size_n = "+ size + " ";
		}

}
if(!types.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.type in ("+ types + ") ";// �����͡�ֵ��Ϊ���������in( )
		sqlResult= " where (t1.type<>'' and t1.type is not null) ";//��������Ϊ�����͡���Ϊ��ʱ����ishead = 1,��Ϊ�����and ǰ����һ��where�ַ�,���Լ���where type<>''.(�����͡�ֵ�����ڶ��β����ص�һ��)
	}
	else
		sqlwhere += " and t1.type in ("+ types + ") ";
}

if(ishead==0){
	//ע��˴���Ҫishead=1
		sqlwhere += " where t1.city <>0 ";//�ų�cityֵΪ0�����
	}
	else
		sqlwhere += " and t1.city <>0 ";

String TableName = VerifyPowerToCustomers.getTableName(request,response);

/*�ó�ȫ��Sql,ִ�У��ó�һ����������������city����Sql���*/
String sqlstr = "select t1.city,t1.type,count(t1.id) as toutalcount from CRM_CustomerInfo  t1,"+TableName+"  t2  "+ sqlwhere +" and  t1.id=t2.id  and t1.deleted = 0 group by t1.city,t1.type order by t1.city";
RecordSet.executeSql(sqlstr);
ArrayList cityids = new ArrayList();
ArrayList dspstrings = new ArrayList();
int lastcity = 0;
int curcity = 0;
String strTemp = "";
while(RecordSet.next())
{
	if((curcity=Util.getIntValue(RecordSet.getString(1),0))==0)
		continue;
	if(curcity==lastcity)
	{
		strTemp += CustomerTypeComInfo.getCustomerTypename(RecordSet.getString(2))+":"+RecordSet.getString(3)+" ";
	}
	else
	{
		if(lastcity!=0)
		{
			cityids.add(""+lastcity);
			dspstrings.add(strTemp);
		}
		lastcity=curcity;
		strTemp = CustomerTypeComInfo.getCustomerTypename(RecordSet.getString(2))+":"+RecordSet.getString(3)+" ";
	}
}
if(lastcity!=0)
{
		cityids.add(""+lastcity);
		dspstrings.add(strTemp);
}

int nCount = cityids.size();
for(int i=0;i<nCount;i++)
{
	out.println(cityids.get(i)+"("+dspstrings.get(i)+")");
}

%></BODY>
</HTML>


