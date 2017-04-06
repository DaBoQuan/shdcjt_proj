<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="weaver.general.Util" %>
<%--<%@ page import="weaver.cpt.capital.InsertWorker" %>--%>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="temprs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetInner" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page" />
<jsp:useBean id="CptShare" class="weaver.cpt.capital.CptShare" scope="page" />
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>
<jsp:useBean id="CodeBuild" class="weaver.system.code.CodeBuild" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>

<%

char separator = Util.getSeparator() ;

Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
Calendar now = Calendar.getInstance();
String currenttime = Util.add0(now.getTime().getHours(), 2) +":"+
                     Util.add0(now.getTime().getMinutes(), 2) +":"+
                     Util.add0(now.getTime().getSeconds(), 2) ;
String lastmoderid = ""+user.getUID();

//--------------
String Id = Util.fromScreen(request.getParameter("id"),user.getLanguage());
//String Invoice = Util.fromScreen(request.getParameter("Invoice"),user.getLanguage());
String BuyerID = Util.fromScreen(request.getParameter("BuyerID"),user.getLanguage());
String supplierid = Util.fromScreen(request.getParameter("customerid"),user.getLanguage());
String checkerid = Util.fromScreen(request.getParameter("CheckerID"),user.getLanguage());
String stockindate = Util.fromScreen(request.getParameter("StockInDate"),user.getLanguage());
int totaldetail = Util.getIntValue(request.getParameter("totaldetail"),0);

	String para1 = "";
	para1 =Id;
    para1 +=separator+stockindate;
    para1 +=separator+BuyerID;
    para1 +=separator+supplierid;
    para1 +=separator+checkerid;
    para1 +=separator+"";
	para1 +=separator+"1";
    RecordSet.executeProc("CptStockInMain_Update",para1);

	String detailid="";
	String cpttype="";
	String innumber="";
	String price="";
    String customerid="";
    String capitalspec="";
    String location="";
    String Invoice="";
	String sptcount1="";
	String contractno="";
	int i=0;
	int j=0;
	int v=0;

for (i=0;i<totaldetail;i++){
	detailid =request.getParameter("node_"+i+"_id");
	cpttype = request.getParameter("node_"+i+"_cptid");
	innumber = request.getParameter("node_"+i+"_innumber");
	price = request.getParameter("node_"+i+"_unitprice");
    customerid = request.getParameter("node_"+i+"_customerid");
    capitalspec = request.getParameter("node_"+i+"_capitalspec");
    location = request.getParameter("node_"+i+"_location");
    Invoice = request.getParameter("node_"+i+"_Invoice");
	contractno = request.getParameter("node_"+i+"_contractno");
    String tempselectdate=request.getParameter("node_"+i+"_stockindate");

	RecordSetInner.executeProc("CptCapital_SelectByID",cpttype);
    if(RecordSetInner.next()){
    	sptcount1 = RecordSetInner.getString("sptcount");
    }

	if(sptcount1.equals("1")){ //�����������ʵ����������ÿ���ʲ�����Ϊһ����¼����ɾ��ԭ���ļ�¼��
        para1 =detailid;
        RecordSet.executeProc("CptStockInDetail_Delete",para1);

        for (j=1,v=(int)Util.getFloatValue(innumber,0);j<=v;j++){
            para1 = Id;
            para1 +=separator+cpttype;
            para1 +=separator+"1";
            para1 +=separator+"1";
            para1 +=separator+price;
            para1 +=separator+customerid;
            para1 +=separator+tempselectdate;
            para1 +=separator+capitalspec;
            para1 +=separator+location;
            para1 +=separator+Invoice;

            RecordSet.executeProc("CptStockInDetail_Insert",para1);
			if(RecordSet.next()){
				String tempdetailid = Util.null2String(RecordSet.getString(1));
				if(!tempdetailid.equals("")&&!tempdetailid.equals("0")){
					RecordSet.executeSql("update CptStockInDetail set contractno = '" + contractno + "' where id = " + tempdetailid);
				}			
			}
        }
	}else{  //�ǵ����������ʵ����������ֱ�Ӹ���ʵ����������
        para1 = detailid;
        para1 +=separator+innumber;
    	RecordSet.executeProc("CptStockInDetail_Update",para1);
	}
}


String departmentid = "" + Util.getIntValue(request.getParameter("CptDept_to"),0);  //��ⲿ��
String requestid 	= "0";     //�ù���������ع�����

String resourceid = "0";		//�깺��
String stateid  = "1";

String capitalid = "";
String tempmark = "";
String isinner = "";
String startdate = "";
String enddate = "";
String deprestartdate = "";
String depreenddate = "";
String manudate = "";
//String location = "";
String num = "";
String tempid = "";
String tempstr = "";
String para = "";
String sptcount = "";
String rltid = "";
String relatefee = "";//��ת��ؽ��
String capitalgroupid = "";
//String capitalspec = "";
String selectdate ="";//��������
String counttype = "";
String capitaltypeid = "";//�ʲ�����
String blongsubcompany = "";//�����ֲ�
String blongdepartment = "";//��������


ArrayList ids = new ArrayList();

RecordSet.executeProc("CptStockInDetail_SByStockid",Id);
out.print("�����ʲ���⣬���Ժ�..."+"<BR>");
while(RecordSet.next()){
//�Ӵӱ��л��
	tempid = RecordSet.getString("id");
	capitalid = RecordSet.getString("cpttype");
	num = RecordSet.getString("innumber");
    double innum = Util.getDoubleValue(num);
    BigDecimal inprice = new BigDecimal(RecordSet.getString("price"));
    customerid=RecordSet.getString("customerid");
    capitalspec=RecordSet.getString("capitalspec");
    location=RecordSet.getString("location");
    Invoice=RecordSet.getString("Invoice");
    //stockindate=RecordSet.getString("selectDate");
	selectdate=RecordSet.getString("selectDate");
	contractno=RecordSet.getString("contractno");

	relatefee = inprice.multiply(new BigDecimal(num)).toString();
	
	RecordSetInner.executeProc("CptCapital_SelectByID",capitalid);
    if(RecordSetInner.next()){
    	tempmark = RecordSetInner.getString("mark");
    	sptcount = RecordSetInner.getString("sptcount");
    	//capitalspec = RecordSetInner.getString("capitalspec");
    	capitalgroupid = RecordSetInner.getString("capitalgroupid");
		capitaltypeid = RecordSetInner.getString("capitaltypeid");
    }

    //�ж��Ƿ���ʻ�ͺ�1:����2:�ͺ�
    String tempstr2 = "2,3,4,5,6,7,8,9";
    String rootgroupid = capitalgroupid;
    while(true){
		if((CapitalAssortmentComInfo.getSupAssortmentId(rootgroupid)).equals("0")){
			break;
		}
		rootgroupid = CapitalAssortmentComInfo.getSupAssortmentId(rootgroupid);
	}
	
    if(inprice.compareTo(new BigDecimal("2000"))==1){   //����������ʲ�(���ʻ�ͺ�)
        counttype = "1";
    }else{
        counttype = "2";
    }

	/**	
	//�Զ����ɱ��
	String	markstr = "";
	int markint = 0;
    int len=5;
    //��ˮ�ų���Ĭ��Ϊ5λ���������ֵ�Զ���չһλ.
    RecordSetInner.executeProc("CptCapital_SCountByDataType",capitalid);
    if(RecordSetInner.next()){
		markstr = Util.null2String(RecordSetInner.getString(1));
		if (!markstr.equals("")  && markstr.length()>tempmark.length()) {
            markstr = markstr.substring(tempmark.length());
            markint = Util.getIntValue(markstr,0);
		}
    }
    if(len<String.valueOf(markint+1).length()){
        len=String.valueOf(markint+1).length();
    }
    tempmark = tempmark+Util.add0(markint+1,len);
	**/

	blongsubcompany = DepartmentComInfo.getSubcompanyid1(departmentid);
	blongdepartment = departmentid;
	
	//����ʲ����
	if(sptcount.equals("1")){
		tempmark = CodeBuild.getCurrentCapitalCode(DepartmentComInfo.getSubcompanyid1(departmentid),departmentid,capitalgroupid,capitaltypeid,selectdate,stockindate,capitalid);
	}
	
	RecordSetInner.executeProc("CptCapital_SelectByDataType",capitalid+separator+departmentid);
    if(!sptcount.equals("1") && RecordSetInner.next()){
        tempmark = RecordSetInner.getString("mark");
    }else if(!sptcount.equals("1")){
    	tempmark = CodeBuild.getCurrentCapitalCode(DepartmentComInfo.getSubcompanyid1(departmentid),departmentid,capitalgroupid,capitaltypeid,selectdate,stockindate,capitalid);
    }
	
	//����Ƿǵ������㲢�Ҳ����д��ʲ���ô��Ų���

	para = stockindate;//�������
	para +=separator+"";//��ת������
	para +=separator+resourceid; //��ת����
	para +=separator+checkerid; //�����
	para +=separator+num; //��ת����
	para +=separator+location;
	para +=separator+requestid;
	para +=separator+"";//��ع�˾(�����)
	para +=separator+relatefee;//��ؽ��
	para +=separator+stateid;//��ת���״̬(ʹ�û���)
	para +=separator+"";//��תԭ��(�ݿ�)
	para +=separator+tempmark;//�Զ����ɵ��ʲ����
	para +=separator+capitalid;//datetype
	para +=separator+startdate;
	para +=separator+enddate;
	para +=separator+deprestartdate;
	para +=separator+depreenddate;
	para +=separator+manudate;
	para += separator+lastmoderid;
	para += separator+currentdate;
	para += separator+currenttime;

	//���ƿ�Ƭ
    if(sptcount.equals("1")){
        //��������
        //����һ��
        para1 =capitalid;
        para1 +=separator+customerid;
        para1 +=separator+""+inprice;
        para1 +=separator+capitalspec;
        para1 +=separator+location;
        para1 +=separator+Invoice;
        para1 +=separator+stockindate;//�������
        para1 +=separator+selectdate;//��������

        RecordSetInner.executeProc("CptCapital_Duplicate",para1);
        RecordSetInner.next();
        rltid =RecordSetInner.getString(1);

        para = rltid+separator+para;
        para += separator+""+inprice;
        para += separator+customerid;
        para += separator+counttype;
        para += separator+isinner;
        //������Ϣ,���������Ϣ
        RecordSetInner.executeProc("CptUseLogInStock_Insert",para);

        RecordSetInner.executeSql("update cptcapital set olddepartment = " + departmentid + ",blongsubcompany='"+ blongsubcompany +"', blongdepartment='"+ blongdepartment +"',contractno='"+contractno+"' where id = " + rltid);
		
		String sqlstr = "select * from cptcapitalparts where cptid = " + capitalid;
		//new BaseBean().writeLog(sqlstr);
		temprs.executeSql(sqlstr);
		while(temprs.next()){
		  sqlstr = "insert into cptcapitalparts (cptid,partsname,partsspec,partssum,partsweight,partssize) select " +rltid+",partsname,partsspec,partssum,partsweight,partssize from cptcapitalparts where id = " + temprs.getString("id");
		  rs.executeSql(sqlstr);
		  //new BaseBean().writeLog(sqlstr);
		}
		sqlstr = "select * from cptcapitalequipment where cptid = " + capitalid;
		temprs.executeSql(sqlstr);
		//new BaseBean().writeLog(sqlstr);
		while(temprs.next()){
		  sqlstr = "insert into cptcapitalequipment (cptid,equipmentname,equipmentspec,equipmentsum,equipmentpower,equipmentvoltage) select "+rltid+",equipmentname,equipmentspec,equipmentsum,equipmentpower,equipmentvoltage from cptcapitalequipment where id = " + temprs.getString("id");
		  rs.executeSql(sqlstr);
		  //new BaseBean().writeLog(sqlstr);
		}
		
		
        //���ʲ�����Ȩ��δ������
        String ProcPara ="";
        String sharetype="";
        String seclevel="";
        String rolelevel="";
        String sharelevel= "";
        String userid= "";
        String sharedepartmentid="";
        String roleid= "";
        String foralluser= "";

        //�ж��ʲ��ĸ���rootgroupid��Ȩ��
        RecordSetInner.executeSql("select * from CptAssortmentShare where assortmentid="+rootgroupid);
        while (RecordSetInner.next()){
            sharetype= RecordSetInner.getString("sharetype");
            seclevel= RecordSetInner.getString("seclevel");
            rolelevel= RecordSetInner.getString("rolelevel");
            sharelevel= RecordSetInner.getString("sharelevel");
            userid= RecordSetInner.getString("userid");
            sharedepartmentid= RecordSetInner.getString("departmentid");
            roleid= RecordSetInner.getString("roleid");
            foralluser= RecordSetInner.getString("foralluser");

            ProcPara = rltid;
            ProcPara += separator+sharetype;
            ProcPara += separator+seclevel;
            ProcPara += separator+rolelevel;
            ProcPara += separator+sharelevel;
            ProcPara += separator+userid;
            ProcPara += separator+sharedepartmentid;
            ProcPara += separator+roleid;
            ProcPara += separator+foralluser;

            RecordSet1.executeProc("CptCapitalShareInfo_Insert",ProcPara);//���ʲ����뵽CptCapitalShareInfo����
        }
        CptShare.setCptShareByCpt(rltid);//����detail��

        ids.add(rltid);
    }else{
        //�ǵ�������
        RecordSetInner.executeProc("CptCapital_SelectByDataType",capitalid+separator+departmentid);
        if(RecordSetInner.next()){
            //�ò������и��ʲ�
            //����ƽ��
            rltid = RecordSetInner.getString("id");
            BigDecimal oldprice = new BigDecimal(RecordSetInner.getString("startprice"));
            BigDecimal oldnum   = new BigDecimal(RecordSetInner.getString("capitalnum"));
            inprice = inprice.multiply(new BigDecimal(num));
            inprice = inprice.add(oldprice.multiply(oldnum));
            inprice = inprice.divide(oldnum.add(new BigDecimal(num)),2,BigDecimal.ROUND_UP);
            //inprice = (oldprice*oldnum+inprice*Util.getDoubleValue(num))/(oldnum+innum);

            para = rltid+separator+para;
            para += separator+""+inprice;
            para += separator+customerid;
            para += separator+counttype;
            para += separator+isinner;

            //������Ϣ,���������Ϣ
            RecordSetInner.executeProc("CptUseLogInStock_Insert",para);

            //�޸��ʲ���Ƭ�Ĳο��۸�Ϊ���۸�
            para1 =rltid;
            para1 +=separator+""+inprice;
            para1 +=separator+capitalspec;
            para1 +=separator+customerid;
            para1 +=separator+location;
            para1 +=separator+Invoice;
            para1 +=separator+stockindate;
            RecordSetInner.executeProc("CptCapital_UpdatePrice",para1);  
        }else{
            //�ò���û�и��ʲ�
            //����һ��
            para1 =capitalid;
            para1 +=separator+customerid;
            para1 +=separator+""+inprice;
            para1 +=separator+capitalspec;
            para1 +=separator+location;
            para1 +=separator+Invoice;
            para1 +=separator+stockindate;//�������
            para1 +=separator+selectdate;//��������

            RecordSetInner.executeProc("CptCapital_Duplicate",para1);
            RecordSetInner.next();
            rltid =RecordSetInner.getString(1);

            para = rltid+separator+para;
            para += separator+""+inprice;
            para += separator+customerid;
            para += separator+counttype;
            para += separator+isinner;

            //������Ϣ,���������Ϣ
            RecordSetInner.executeProc("CptUseLogInStock_Insert",para);

            RecordSetInner.executeSql("update cptcapital set olddepartment = " + departmentid + ",blongsubcompany='"+ blongsubcompany +"', blongdepartment='"+ blongdepartment +"',contractno='"+contractno+"' ,capitalnum='"+innum+"'  where id = " + rltid);

			String sqlstr = "select * from cptcapitalparts where cptid = " + capitalid;
			//new BaseBean().writeLog(sqlstr);
			temprs.executeSql(sqlstr);
			while(temprs.next()){
			  sqlstr = "insert into cptcapitalparts (cptid,partsname,partsspec,partssum,partsweight,partssize) select " +rltid+",partsname,partsspec,partssum,partsweight,partssize from cptcapitalparts where id = " + temprs.getString("id");
			  rs.executeSql(sqlstr);
			  //new BaseBean().writeLog(sqlstr);
			}
			sqlstr = "select * from cptcapitalequipment where cptid = " + capitalid;
			temprs.executeSql(sqlstr);
			//new BaseBean().writeLog(sqlstr);
			while(temprs.next()){
			  sqlstr = "insert into cptcapitalequipment (cptid,equipmentname,equipmentspec,equipmentsum,equipmentpower,equipmentvoltage) select "+rltid+",equipmentname,equipmentspec,equipmentsum,equipmentpower,equipmentvoltage from cptcapitalequipment where id = " + temprs.getString("id");
			  rs.executeSql(sqlstr);
			  //new BaseBean().writeLog(sqlstr);
			}

            //���ʲ�����Ȩ��δ������
            String ProcPara ="";
            String sharetype="";
            String seclevel="";
            String rolelevel="";
            String sharelevel= "";
            String userid= "";
            String sharedepartmentid="";
            String roleid= "";
            String foralluser= "";
            //�ж��ʲ��ĸ���rootgroupid��Ȩ��
            RecordSetInner.executeSql("select * from CptAssortmentShare where assortmentid="+rootgroupid);
            while (RecordSetInner.next()){
                sharetype= RecordSetInner.getString("sharetype");
                seclevel= RecordSetInner.getString("seclevel");
                rolelevel= RecordSetInner.getString("rolelevel");
                sharelevel= RecordSetInner.getString("sharelevel");
                userid= RecordSetInner.getString("userid");
                sharedepartmentid= RecordSetInner.getString("departmentid");
                roleid= RecordSetInner.getString("roleid");
                foralluser= RecordSetInner.getString("foralluser");

                ProcPara = rltid;
                ProcPara += separator+sharetype;
                ProcPara += separator+seclevel;
                ProcPara += separator+rolelevel;
                ProcPara += separator+sharelevel;
                ProcPara += separator+userid;
                ProcPara += separator+sharedepartmentid;
                ProcPara += separator+roleid;
                ProcPara += separator+foralluser;

                RecordSet1.executeProc("CptCapitalShareInfo_Insert",ProcPara);//���ʲ����뵽CptCapitalShareInfo����                
            }
            CptShare.setCptShareByCpt(rltid);//����detail��

            ids.add(rltid);
        }
    }

}//end while

CapitalComInfo.addCapitalCache(ids);

//update by fanggsh 20060511 TD4308 begin
PoppupRemindInfoUtil.updatePoppupRemindInfo(user.getUID(),11,"0",Util.getIntValue(Id));
//update by fanggsh 20060511 TD4308 end

response.sendRedirect("/cpt/search/CptInstockSearch.jsp");

%>
 <input type="button" name="Submit2" value="<%=SystemEnv.getHtmlLabelName(236,user.getLanguage())%>" onClick="javascript:history.go(-1)">