<%@ page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RequestManager" class="weaver.workflow.request.RequestManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSetInner" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page" />
<jsp:useBean id="CptShare" class="weaver.cpt.capital.CptShare" scope="page" />
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>
<jsp:useBean id="CodeBuild" class="weaver.system.code.CodeBuild" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%@ page import="weaver.file.FileUpload" %>
<%
FileUpload fu = new FileUpload(request);
String src = Util.null2String(fu.getParameter("src"));
String iscreate = Util.null2String(fu.getParameter("iscreate"));
int requestid = Util.getIntValue(fu.getParameter("requestid"),-1);
int workflowid = Util.getIntValue(fu.getParameter("workflowid"),-1);
String workflowtype = Util.null2String(fu.getParameter("workflowtype"));
int isremark = Util.getIntValue(fu.getParameter("isremark"),-1);
int formid = Util.getIntValue(fu.getParameter("formid"),-1);
int isbill = Util.getIntValue(fu.getParameter("isbill"),-1);
int billid = Util.getIntValue(fu.getParameter("billid"),-1);
int nodeid = Util.getIntValue(fu.getParameter("nodeid"),-1);
String nodetype = Util.null2String(fu.getParameter("nodetype"));
String requestname = Util.fromScreen(fu.getParameter("requestname"),user.getLanguage());
String requestlevel = Util.fromScreen(fu.getParameter("requestlevel"),user.getLanguage());
String messageType =  Util.fromScreen(fu.getParameter("messageType"),user.getLanguage());
String remark = Util.null2String(fu.getParameter("remark"));

if( src.equals("") || workflowid == -1 || formid == -1 || isbill == -1 || nodeid == -1 || nodetype.equals("") ) {
    //response.sendRedirect("/notice/RequestError.jsp");
    out.print("<script>wfforward('/notice/RequestError.jsp');</script>");
    return ;
}



RequestManager.setSrc(src) ;
RequestManager.setIscreate(iscreate) ;
RequestManager.setRequestid(requestid) ;
RequestManager.setWorkflowid(workflowid) ;
RequestManager.setWorkflowtype(workflowtype) ;
RequestManager.setIsremark(isremark) ;
RequestManager.setFormid(formid) ;
RequestManager.setIsbill(isbill) ;
RequestManager.setBillid(billid) ;
RequestManager.setNodeid(nodeid) ;
RequestManager.setNodetype(nodetype) ;
RequestManager.setRequestname(requestname) ;
RequestManager.setRequestlevel(requestlevel) ;
RequestManager.setRemark(remark) ;
RequestManager.setRequest(fu) ;
RequestManager.setUser(user) ;
//add by chengfeng.han 2011-7-28 td20647 
int isagentCreater = Util.getIntValue((String)session.getAttribute(workflowid+"isagent"+user.getUID()));
int beagenter = Util.getIntValue((String)session.getAttribute(workflowid+"beagenter"+user.getUID()),0);
RequestManager.setIsagentCreater(isagentCreater);
RequestManager.setBeAgenter(beagenter);
//end
//add by xhheng @ 2005/01/24 for ��Ϣ���� Request06
RequestManager.setMessageType(messageType) ;

boolean savestatus = RequestManager.saveRequestInfo() ;
requestid = RequestManager.getRequestid() ;
if( !savestatus ) {
    if( requestid != 0 ) {

        String message=RequestManager.getMessage();
        if(!"".equals(message)){
			out.print("<script>wfforward('/workflow/request/ViewRequest.jsp?requestid="+requestid+"&message="+message+"');</script>");
            return ;
        }
        //response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1");
        out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=1');</script>");
        return ;
    }
    else {
        //response.sendRedirect("/workflow/request/RequestView.jsp?message=1");
        out.print("<script>wfforward('/workflow/request/RequestView.jsp?message=1');</script>");
        return ;
    }
}

boolean flowstatus = RequestManager.flowNextNode() ;
if( !flowstatus ) {
	//response.sendRedirect("/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2");
	out.print("<script>wfforward('/workflow/request/ManageRequest.jsp?requestid="+requestid+"&message=2');</script>");
	return ;
}

String ismode="";
RecordSet.executeSql("select ismode,showdes,printdes from workflow_flownode where workflowid="+workflowid+" and nodeid="+nodeid);
if(RecordSet.next()){
    ismode=Util.null2String(RecordSet.getString("ismode"));
}

char flag = 2; 
String updateclause = "" ;
// add record into bill_CptApplyDetail
if( !ismode.equals("1")&&(src.equals("save") || src.equals("submit")) ) {      // �޸�ϸ���������Ϣ
	if( !iscreate.equals("1") ) RecordSet.executeSql("delete from bill_CptApplyDetail where cptapplyid =" + billid);
    else {
        requestid = RequestManager.getRequestid() ;
        billid = RequestManager.getBillid() ;
    }

	int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	if(ismode.equals("1")){//ͼ�λ�ģʽ�µ�ȡֵ��ֻ��һ����ϸ�飬ȡnodesnum0
	    rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum0")));
	}
	float totalamount =0;
	for(int i=0;i<rowsum;i++) {		
		int cpttypeid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_cpttypeid")),0);
		int cptid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_cptid")),0);
		int cptcapitalid = Util.getIntValue(Util.null2String(fu.getParameter("node_"+i+"_cptcapitalid")),0);
		float number = Util.getFloatValue(fu.getParameter("node_"+i+"_number"),-1);
		float unitprice = Util.getFloatValue(fu.getParameter("node_"+i+"_unitprice"),0);
		
		String needdate = Util.null2String(fu.getParameter("node_"+i+"_needdate"));
		String purpose = Util.null2String(fu.getParameter("node_"+i+"_purpose"));
		String cptdesc = Util.null2String(fu.getParameter("node_"+i+"_cptdesc"));
		
		if(ismode.equals("1")){//ͼ�λ�ģʽ�µ�ȡֵ
		    cpttypeid = Util.getIntValue(Util.null2String(fu.getParameter("field325_"+i)),0);//�ʲ�����
		    cptid = Util.getIntValue(Util.null2String(fu.getParameter("field159_"+i)),0);//�ʲ�����
		    cptcapitalid = Util.getIntValue(Util.null2String(fu.getParameter("field162_"+i)),0);//�ʲ�
		    number = Util.getFloatValue(fu.getParameter("field326_"+i),-1);//����
		    unitprice = Util.getFloatValue(fu.getParameter("field327_"+i),0);//����
		    needdate = Util.null2String(fu.getParameter("field329_"+i));//��������
		    purpose = Util.null2String(fu.getParameter("field160_"+i));//��;
		    cptdesc = Util.null2String(fu.getParameter("field161_"+i));//����
		}
		
		if(number <=0 ) continue ;
		float amount = number * unitprice;
		
		String para = ""+billid+flag+cpttypeid+flag+cptid+flag+number+flag+unitprice+flag + amount+flag+needdate+flag+purpose+flag+cptdesc+flag+cptcapitalid;
		RecordSet.executeProc("bill_CptApplyDetail_Insert",para);
		totalamount += amount;		
	}					
	updateclause = " set totalamount = "+totalamount+" ";
	updateclause="update bill_CptApplyMain "+updateclause+" where id = "+billid;
	RecordSet.executeSql(updateclause);

}

//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-��������� ==��ʼ==
//System.out.println("src=="+src);
//System.out.println("RequestManager.getNextNodetype()=="+RequestManager.getNextNodetype());
if(src.equals("submit")&&RequestManager.getNextNodetype().equals("3")){
	String BuyerID = Util.fromScreen(fu.getParameter("field154"),user.getLanguage());//�깺��id
	String CheckerID = Util.fromScreen(""+user.getUID(),user.getLanguage());//������id
	String StockInDate = "";//�������YYYY-MM-DD
	Calendar today = Calendar.getInstance();
	StockInDate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);
	String currenttime = Util.add0(today.getTime().getHours(), 2) +":"+
                     	 Util.add0(today.getTime().getMinutes(), 2) +":"+
                       Util.add0(today.getTime().getSeconds(), 2) ;
	char separator = Util.getSeparator() ;
	String para = "";
  para +=separator+BuyerID;
  para +=separator+"";
  para +=separator+CheckerID;
  para +=separator+StockInDate;
	para +=separator+"1";
  RecordSet.executeProc("CptStockInMain_Insert",para);
  
  RecordSet.next();
	String cptstockinid=""+RecordSet.getInt(1);
	
	int rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum")));
	if(ismode.equals("1")){//ͼ�λ�ģʽ�µ�ȡֵ��ֻ��һ����ϸ�飬ȡnodesnum0
	    rowsum = Util.getIntValue(Util.null2String(fu.getParameter("nodesnum0")));
	}
	for(int i=0;i<rowsum;i++) {
		
		String cpttype = Util.null2String(fu.getParameter("node_"+i+"_cptid"));//�ʲ�����
		String plannumber = Util.null2String(fu.getParameter("node_"+i+"_number"));//����
		String price = Util.null2String(fu.getParameter("node_"+i+"_unitprice"));//����
		String customerid_dtl = "";//��Ӧ��,������û�д��ֶ�
		String StockInDate_dtl = Util.null2String(fu.getParameter("node_"+i+"_needdate"));//��������
		String capitalspec = "";//����ͺ�,������û�д��ֶ�
		String location = "";//��ŵص�,������û�д��ֶ�
		String Invoice = "";//��Ʊ��,������û�д��ֶ�
		
		if(ismode.equals("1")){//ͼ�λ�ģʽ�µ�ȡֵ
		    cpttype = Util.null2String(fu.getParameter("field159_"+i));//�ʲ�����
		    plannumber = Util.null2String(fu.getParameter("field326_"+i));//����
		    price = Util.null2String(fu.getParameter("field327_"+i));//����
		    StockInDate_dtl = Util.null2String(fu.getParameter("field329_"+i));//��������
		}
		plannumber = (int)Util.getFloatValue(plannumber,0) + "";
		
		String sptcount1="";//sptcount1Ϊ1��ʾ��������
		RecordSet.executeProc("CptCapital_SelectByID",cpttype);
    if(RecordSet.next()){
    	sptcount1 = RecordSet.getString("sptcount");
    }
		if(sptcount1.equals("1")){
		  for (int j=0;j<Util.getIntValue(plannumber,0);j++){//�����������ʵ����������ÿ���ʲ�����Ϊһ����¼
				para = cptstockinid;
				para +=separator+cpttype;
				para +=separator+"1";//�ƻ��������
				para +=separator+"1";//ʵ���������
				para +=separator+price;
			  para +=separator+customerid_dtl;
			  para +=separator+StockInDate_dtl;
			  para +=separator+capitalspec;
			  para +=separator+location;
			  para +=separator+Invoice;
				RecordSet.executeProc("CptStockInDetail_Insert",para);
			}
		}else{
			para = cptstockinid;
			para +=separator+cpttype;
			para +=separator+plannumber;//�ƻ��������
			para +=separator+plannumber;//ʵ���������
			para +=separator+price;
		  para +=separator+customerid_dtl;
		  para +=separator+StockInDate_dtl;
		  para +=separator+capitalspec;
		  para +=separator+location;
		  para +=separator+Invoice;
			RecordSet.executeProc("CptStockInDetail_Insert",para);
		}
	}
  
  String departmentid = Util.fromScreen(fu.getParameter("field153"),user.getLanguage());  //��ⲿ��
	String temprequestid 	= "0";     //�ù���������ع�����	
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
	para = "";
	String sptcount = "";
	String rltid = "";
	String relatefee = "";//��ת��ؽ��
	String capitalgroupid = "";
	//String capitalspec = "";
	String selectdate ="";//��������
	String counttype = "";	
	ArrayList ids = new ArrayList();
	
	String customerid = "";
	String capitalspec = "";
	String location = "";
	String Invoice = "";	
	String stockindate = "";
	String capitaltypeid = "";//�ʲ�����
	String blongsubcompany = "";//�����ֲ�
	String blongdepartment = "";//��������
	
	RecordSet.executeProc("CptStockInDetail_SByStockid",cptstockinid);
	while(RecordSet.next()){
		tempid = RecordSet.getString("id");
		capitalid = RecordSet.getString("cpttype");
		num = RecordSet.getString("innumber");
    double innum = Util.getDoubleValue(num);
    double inprice = Util.getDoubleValue(RecordSet.getString("price"));
    customerid=RecordSet.getString("customerid");
    capitalspec=RecordSet.getString("capitalspec");
    location=RecordSet.getString("location");
    Invoice=RecordSet.getString("Invoice");
    stockindate=RecordSet.getString("selectDate");
		selectdate=RecordSet.getString("selectDate");
		relatefee = ""+(innum*inprice);
		
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
	
    if(inprice>=2000){   //����������ʲ�(���ʻ�ͺ�)
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
		para +=separator+CheckerID; //�����
		para +=separator+num; //��ת����
		para +=separator+location;
		para +=separator+temprequestid;
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
		para += separator+CheckerID;
		para += separator+StockInDate;
		para += separator+currenttime;
		
		String para1 = "";
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
		RecordSetInner.executeSql("update cptcapital set olddepartment = " + departmentid + ",blongsubcompany='"+ blongsubcompany +"', blongdepartment='"+ blongdepartment +"' where id = " + rltid);

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
            double oldprice = Util.getDoubleValue(RecordSetInner.getString("startprice"));
            double oldnum   = Util.getDoubleValue(RecordSetInner.getString("capitalnum"));
            inprice = (oldprice*oldnum+inprice*Util.getDoubleValue(num))/(oldnum+innum);

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
			RecordSetInner.executeSql("update cptcapital set olddepartment = " + departmentid + ",blongsubcompany='"+ blongsubcompany +"', blongdepartment='"+ blongdepartment +"' where id = " + rltid);

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
	}
	
	if(ids!=null&&ids.size()>0){//���ʲ��깺����Ӳ鿴Ȩ��
		for(int ii=0;ii<ids.size();ii++){
			RecordSet1.executeSql("INSERT INTO CptShareDetail ( cptid, userid , usertype, sharelevel )  VALUES ( "+ids.get(ii)+","+BuyerID+", 1, 1)");
		}
	}
	
  CapitalComInfo.addCapitalCache(ids);
  PoppupRemindInfoUtil.updatePoppupRemindInfo(user.getUID(),11,"0",Util.getIntValue(cptstockinid));
}
//����ͨ���󵽹鵵�ڵ㣬�����ʲ��������൱�ڣ��ʲ�����-���ʲ�����-��������� ==����==

boolean logstatus = RequestManager.saveRequestLog() ;

//response.sendRedirect("/workflow/request/RequestView.jsp");
out.print("<script>wfforward('/workflow/request/RequestView.jsp');</script>");
%>