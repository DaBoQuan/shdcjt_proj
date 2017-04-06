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
<jsp:useBean id="CityComInfo" class="weaver.hrm.city.CityComInfo" scope="page" />

<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page" />

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


String sqlwhere = "";
String sqlResult="";

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



/*�ó�ȫ��Sql,ִ�У��ó�һ����������������city����Sql���*/
String leftjointable = CrmShareBase.getTempTable(""+user.getUID());
String sqlstr = "";
if(user.getLogintype().equals("1")){
	 sqlstr = "select t1.city,t1.type,count(distinct t1.id) as toutalcount from CRM_CustomerInfo  t1,"+leftjointable+"  t2 "+ sqlwhere +"  and t1.id = t2.relateditemid and t1.deleted = 0 group by t1.city,t1.type order by t1.city";
}else{
	 sqlstr = "select t1.city,t1.type,count(t1.id) as toutalcount from CRM_CustomerInfo  t1 "+ sqlwhere +" and t1.agent="+user.getUID() + "  and t1.deleted = 0 group by t1.city,t1.type order by t1.city";
}

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


//ҳ�����ض���
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(352,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(110,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:weaver.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM id=weaver action="/CRM/report/AddressRpSum.jsp" method=post>


  <TABLE class=ViewForm>
    <COLGROUP> <COL width="10%"> <COL width="40%"> <COL width=5> <COL width="10%"> <COL width="40%"> <TBODY> 
    <TR class=Spacing>
    <TD class=Line1 colSpan=5></TD></TR>
  <TR>
  
  <TR>
	<TD colSpan=5>
	<table>
	  <COLGROUP>
	  <COL width="20%">
	  <COL width="80%">
	  <TBODY>
		<tr>
			<td><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></td>
			<td>
<%//��ʾ�������͵ļ����ֵ
	RecordSetCT.executeProc("CRM_CustomerType_SelectAll","");
	int nCount = 0;
	while(RecordSetCT.next())
	{
		nCount++;
if(CRMSearchComInfo.isCustomerTypeSel(nCount)){%>			
				<INPUT name="CustomerTypes" type="checkbox" value="<%=nCount%>" checked><%=Util.toScreen(RecordSetCT.getString("fullname"),user.getLanguage())%>
<%}else{%>			
				<INPUT name="CustomerTypes" type="checkbox" value="<%=nCount%>"><%=Util.toScreen(RecordSetCT.getString("fullname"),user.getLanguage())%>
<%}
}%>			
			</td>
		</TR><tr style="height:2px"><td class=Line colspan=5></td></tr>
	  </TBODY>
	</table>
	</TD>
  </TR>
       
	   <TR>
          
      <TD><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%></TD>
          
      <TD class=Field>
        <INPUT class=wuiBrowser type=hidden name="CustomerStatus" value="<%=CRMSearchComInfo.getCustomerStatus()%>"
         _url="/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerStatusBrowser.jsp"
          _displayText="<%=CustomerStatusComInfo.getCustomerStatusname(CRMSearchComInfo.getCustomerStatus())%>"
        ></TD> 
		
      <TD>&nbsp</TD>
      <TD><%=SystemEnv.getHtmlLabelName(576,user.getLanguage())%></TD>
          
      <TD class=Field>
        <INPUT class=wuiBrowser  type=hidden name="CustomerSize" value="<%=CRMSearchComInfo.getCustomerSize()%>"
        _url="/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerSizeBrowser.jsp"
        _displayText="<%=CustomerSizeComInfo.getCustomerSizedesc(CRMSearchComInfo.getCustomerSize())%>"
        ></TD>
        </TR><tr style="height:2px"><td class=Line colspan=5></td></tr>
        <TR>
          
      <TD><%=SystemEnv.getHtmlLabelName(575,user.getLanguage())%></TD>
          
      <TD class=Field>
        <INPUT class=wuiBrowser  type=hidden name="CustomerSector" value="<%=CRMSearchComInfo.getCustomerSector()%>"
        _url="/systeminfo/BrowserMain.jsp?url=/CRM/Maint/SectorInfoBrowser.jsp"
         _displayText="<%=SectorInfoComInfo.getSectorInfoname(CRMSearchComInfo.getCustomerSector())%>"
        ></TD>
          
      <TD>&nbsp</TD>
      <TD><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
          
      <TD class=Field>
        <INPUT class=wuiBrowser type=hidden name="CustomerDesc" value="<%=CRMSearchComInfo.getCustomerDesc()%>"
        _url="/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerDescBrowser.jsp"\
        _displayText="<%=CustomerDescComInfo.getCustomerDescname(CRMSearchComInfo.getCustomerDesc())%>"
        ></TD>
        </TR><tr style="height:2px" ><td class=Line colspan=5></td></tr> 
  </TBODY>
</TABLE>

<DIV style="POSITION: relative"><IMG src="/images/chinamap.gif" width =745 height=427 style="filter: Alpha(Opacity=70)" >
<%
for(int i=0;i<cityids.size();i++)
{

	 String cityname=CityComInfo.getCityname(cityids.get(i).toString());
     float citylongitude=Util.getFloatValue(CityComInfo.getCitylongitude(cityids.get(i).toString()));//�þ���
	 float citylatitude=Util.getFloatValue(CityComInfo.getCitylatitude(cityids.get(i).toString()));//��γ��
	 String cityid=cityids.get(i).toString();
	 String strData=dspstrings.get(i).toString();

%>
<TABLE bgColor=lime border=1 cellPadding=1 cellSpacing=1 height=5 id=txt 
style="BORDER-BOTTOM-COLOR: black; BORDER-LEFT-COLOR: black; BORDER-RIGHT-COLOR: black; BORDER-TOP-COLOR: black; CURSOR: hand; LEFT: <%=(citylongitude-72.5)*745/63.0%>; POSITION: absolute; TOP:<%=(53.3-citylatitude)*427/35.3%>;" title="<%=cityname%>:(<%=strData%>)" width=5
onclick="window.location='/CRM/search/SearchOperation.jsp?settype=customercity&customercity=<%=cityid%>'">		<TBODY>  <TR>    <TD></TD></TR><tr><td class=Line colspan=4></td></tr></TBODY>
</TABLE>

<%}%>

</div>


</FORM>
		</td>
		</TR><tr style="height:2px" ><td class=Line colspan=2></td></tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
<script language=vbs>
sub onShowSizeID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerSizeBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Sizespan.innerHtml = id(1)
	weaver.CustomerSize.value=id(0)
	else 
	Sizespan.innerHtml = ""
	weaver.CustomerSize.value=""
	end if
	end if
end sub

sub onShowSectorID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/SectorInfoBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Sectorspan.innerHtml = id(1)
	weaver.CustomerSector.value=id(0)
	else 
	Sectorspan.innerHtml = ""
	weaver.CustomerSector.value=""
	end if
	end if
end sub

sub onShowStatusID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerStatusBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Statusspan.innerHtml = id(1)
	weaver.CustomerStatus.value=id(0)
	else 
	Statusspan.innerHtml = ""
	weaver.CustomerStatus.value=""
	end if
	end if
end sub
sub onShowDescriptionID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerDescBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Descriptionspan.innerHtml = id(1)
	weaver.CustomerDesc.value=id(0)
	else 
	Descriptionspan.innerHtml = ""
	weaver.CustomerDesc.value=""
	end if
	end if
end sub
</script>
</BODY>
</HTML>


