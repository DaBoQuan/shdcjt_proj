<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,
                 weaver.docs.docs.CustomFieldManager" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CustomFieldTreeManager" class="weaver.hrm.resource.CustomFieldTreeManager" scope="page" />
<jsp:useBean id="EducationLevelComInfo" class="weaver.hrm.job.EducationLevelComInfo" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="HrmListValidate" class="weaver.hrm.resource.HrmListValidate" scope="page" />
<html>
<%
 String id = request.getParameter("id");
 int hrmid = user.getUID();
 int isView = Util.getIntValue(request.getParameter("isView"));
 int departmentid = user.getUserDepartment();

 boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
 boolean ism = ResourceComInfo.isManager(hrmid,id);
 boolean iss = ResourceComInfo.isSysInfoView(hrmid,id);
 boolean isf = ResourceComInfo.isFinInfoView(hrmid,id);
 boolean isc = ResourceComInfo.isCapInfoView(hrmid,id);

// boolean iscre = ResourceComInfo.isCreaterOfResource(hrmid,id);
 boolean ishe = (hrmid == Util.getIntValue(id));

// boolean ishr = (HrmUserVarify.checkUserRight("HrmResourceEdit:Edit",user,departmentid));

String sqlstatus = "select status from HrmResource where id = "+id;
rs.executeSql(sqlstatus);
rs.next();
int status = rs.getInt("status");
%>
<head>
<%if(isfromtab) {%>
<base target='_blank'/>
<%} %>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(367,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(6087,user.getLanguage())+SystemEnv.getHtmlLabelName(87,user.getLanguage());
String needfav ="1";
String needhelp ="";

int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
int operatelevel=-1;
if(detachable==1){
    String deptid=ResourceComInfo.getDepartmentID(id);
    String subcompanyid=DepartmentComInfo.getSubcompanyid1(deptid)  ;
    operatelevel=CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(),"HrmResourceEdit:Edit",Util.getIntValue(subcompanyid));
}else{
    if(HrmUserVarify.checkUserRight("HrmResourceEdit:Edit", user))
        operatelevel=2;
}
boolean isSelf		=	false;
if (id.equals(""+user.getUID()) ){
		isSelf = true;
	}
if(!((isSelf||operatelevel>=0)&&HrmListValidate.isValidate(11))){
	 response.sendRedirect("/notice/noright.jsp") ;
}
%>
<body>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(status != 10&&operatelevel>0){
RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+",javascript:edit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
if(!isfromtab){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:viewBasicInfo(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%
}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr style="height:0px">
<td height="0" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<%if(!isfromtab){ %>
<TABLE class=Shadow>
<%}else {%>
<TABLE width='100%'>
<%} %>
<tr>
<td valign="top">

<FORM name=resourcepersonalinfo id=resource action="HrmResourceOperation.jsp" method=post enctype="multipart/form-data">

 <TABLE class=ViewForm>
 
	<TBODY>
    <TR>
      <TD vAlign=top>
      <TABLE width="100%">
          <COLGROUP> <COL width=20%> <COL width=80%>
	      <TBODY>
          <TR class=Title>
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(15687,user.getLanguage())%></TH>
          </TR>
          <TR class=Spacing style="height:2px">
            <TD class=Line1 colSpan=2></TD>
          </TR>
 <%
  String sql = "";
  sql = "select * from HrmResource where id = "+id;
  rs.executeSql(sql);
  while(rs.next()){
    String birthday = Util.null2String(rs.getString("birthday"));
    String folk = Util.null2String(rs.getString("folk"));
    String nativeplace = Util.null2String(rs.getString("nativeplace"));
    String regresidentplace = Util.null2String(rs.getString("regresidentplace"));
    String certificatenum = Util.null2String(rs.getString("certificatenum"));
    String maritalstatus = Util.null2String(rs.getString("maritalstatus"));
    String policy = Util.null2String(rs.getString("policy"));
    String bememberdate = Util.null2String(rs.getString("bememberdate"));
    String bepartydate = Util.null2String(rs.getString("bepartydate"));
    String islabouunion = Util.null2String(rs.getString("islabouunion"));
    String educationlevel = Util.null2String(rs.getString("educationlevel"));
    String degree = Util.null2String(rs.getString("degree"));
    String healthinfo = Util.null2String(rs.getString("healthinfo"));
    String height = Util.null2String(rs.getString("height"));
    String weight = Util.null2String(rs.getString("weight"));
    String residentplace = Util.null2String(rs.getString("residentplace"));
    String homeaddress = Util.null2String(rs.getString("homeaddress"));
    String tempresidentnumber = Util.null2String(rs.getString("tempresidentnumber"));
%>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(464,user.getLanguage())%></TD>
            <TD class=Field>
              <%=birthday%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1886,user.getLanguage())%></TD>
            <TD class=Field>
              <%=folk%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1840,user.getLanguage())%></TD>
            <TD class=Field>
              <%=nativeplace%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(15683,user.getLanguage())%></TD>
            <TD class=Field>
              <%=regresidentplace%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1887,user.getLanguage())%></TD>
            <TD class=Field>
              <%=certificatenum%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(469,user.getLanguage())%></TD>
            <TD class=Field>
                <%if(maritalstatus.equals("0")){%><%=SystemEnv.getHtmlLabelName(470,user.getLanguage())%> <%}%>
                <%if(maritalstatus.equals("1")){%><%=SystemEnv.getHtmlLabelName(471,user.getLanguage())%> <%}%>
                <%if(maritalstatus.equals("2")){%><%=SystemEnv.getHtmlLabelName(472,user.getLanguage())%> <%}%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1837,user.getLanguage())%></TD>
            <TD class=Field>
              <%=policy%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1834,user.getLanguage())%></TD>
            <TD class=Field>
              <%=bememberdate%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1835,user.getLanguage())%></TD>
            <TD class=Field>
              <%=bepartydate%>
            </TD>
          </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(15684,user.getLanguage())%></TD>
            <TD class=Field>
              <%if(islabouunion.equals("1")){%><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%><%}%>
              <%if(islabouunion.equals("0")){%><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%><%}%>
            </TD>
          </TR>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(818,user.getLanguage())%></TD>
            <TD class=Field>
<!--
              <%if(educationlevel.equals("0")){%><%=SystemEnv.getHtmlLabelName(811,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("1")){%><%=SystemEnv.getHtmlLabelName(819,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("2")){%><%=SystemEnv.getHtmlLabelName(764,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("12")){%><%=SystemEnv.getHtmlLabelName(2122,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("13")){%><%=SystemEnv.getHtmlLabelName(2123,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("3")){%><%=SystemEnv.getHtmlLabelName(820,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("4")){%><%=SystemEnv.getHtmlLabelName(765,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("5")){%><%=SystemEnv.getHtmlLabelName(766,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("6")){%><%=SystemEnv.getHtmlLabelName(767,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("7")){%><%=SystemEnv.getHtmlLabelName(768,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("8")){%><%=SystemEnv.getHtmlLabelName(769,user.getLanguage())%><%}%>
              <%if(educationlevel.equals("9")){%>MBA<%}%>
              <%if(educationlevel.equals("10")){%>EMBA<%}%>
              <%if(educationlevel.equals("11")){%><%=SystemEnv.getHtmlLabelName(2119,user.getLanguage())%><%}%>
-->
              <%=EducationLevelComInfo.getEducationLevelname(educationlevel)%>
            </TD>
          </TR>
                  <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1833,user.getLanguage())%></TD>
            <TD class=Field>
              <%=degree%>
            </TD>
          </TR>
       <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1827,user.getLanguage())%></TD>
            <TD class=Field>
              <%if(healthinfo.equals("0")){%><%=SystemEnv.getHtmlLabelName(824,user.getLanguage())%><%}%>
              <%if(healthinfo.equals("1")){%><%=SystemEnv.getHtmlLabelName(821,user.getLanguage())%><%}%>
              <%if(healthinfo.equals("2")){%><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%><%}%>
              <%if(healthinfo.equals("3")){%><%=SystemEnv.getHtmlLabelName(825,user.getLanguage())%><%}%>
            </TD>
          </TR>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1826,user.getLanguage())%></TD>
            <TD class=Field>
              <%=height%>
            </TD>
          </TR>
      <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
       	  <TR>
            <TD><%=SystemEnv.getHtmlLabelName(15674,user.getLanguage())%></TD>
            <TD class=Field>
              <%=weight%>
            </TD>
          </TR>
        <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(1829,user.getLanguage())%></TD>
            <TD class=Field>
              <%=residentplace%>
            </TD>
          </TR>
      <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(16018,user.getLanguage())%></TD>
            <TD class=Field>
              <%=homeaddress%>
            </TD>
          </TR>
  <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
	      <TR>
            <TD><%=SystemEnv.getHtmlLabelName(15685,user.getLanguage())%></TD>
            <TD class=Field>
              <%=tempresidentnumber%>
            </TD>
          </TR>
     <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
<%
  }
%>

<%
    int scopeId = 1;
    CustomFieldManager cfm = new CustomFieldManager("HrmCustomFieldByInfoType",scopeId);
    cfm.getCustomFields();
    cfm.getCustomData(Util.getIntValue(id,0));
    while(cfm.next()){
        String fieldvalue = cfm.getData("field"+cfm.getId());
%>
    <tr>
      <td <%if(cfm.getHtmlType().equals("2")){%> valign=top <%}%>> <%=cfm.getLable()%> </td>
      <td class=field >
      <%
        if(cfm.getHtmlType().equals("1")||cfm.getHtmlType().equals("2")){
      %>
      <%=fieldvalue%>
      <%
        }else if(cfm.getHtmlType().equals("3")){

            String fieldtype = String.valueOf(cfm.getType());
		    String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
		    String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
		    String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
		    String showid = "";                                     // �½�ʱ��Ĭ��ֵ


            if(fieldtype.equals("2") ||fieldtype.equals("19")){
                showname=fieldvalue; // ����ʱ��
            }else if(!fieldvalue.equals("")) {
                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                sql = "";

                HashMap temRes = new HashMap();
				//System.out.println(fieldtype+"================>");
                if(fieldtype.equals("152") || fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")||fieldtype.equals("168")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                }
				//System.out.println(sql);
                RecordSet.executeSql(sql);
                while(RecordSet.next()){
                    showid = Util.null2String(RecordSet.getString(1)) ;
                    String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                    if(!linkurl.equals(""))
                        //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                        temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
                    else{
                        //showname += tempshowname ;
                        temRes.put(String.valueOf(showid),tempshowname);
                    }
                }
                StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                String temstkvalue = "";
                while(temstk.hasMoreTokens()){
                    temstkvalue = temstk.nextToken();

                    if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                        showname += temRes.get(temstkvalue);
                    }
                }

            }


      %>
        <span id="customfield<%=cfm.getId()%>span"><%=Util.toScreen(showname,user.getLanguage())%></span>
       <%
        }else if(cfm.getHtmlType().equals("4")){
       %>
        <input type=checkbox value=1 name="customfield<%=cfm.getId()%>" <%=fieldvalue.equals("1")?"checked":""%> disabled >
       <%
        }else if(cfm.getHtmlType().equals("5")){
            cfm.getSelectItem(cfm.getId());
       %>
       <%
            while(cfm.nextSelect()){
                if(cfm.getSelectValue().equals(fieldvalue)){
       %>
            <%=cfm.getSelectName()%>
       <%
                    break;
                }
            }
       %>
       <%
        }
       %>
            </td>
        </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD>
  </TR>
       <%
    }
       %>
 	      </tbody>
       </table>
   </tr>

<%
  sql = "select * from HrmFamilyInfo where resourceid = "+id;
  rs.executeSql(sql);
%>
	<TR>
      <TD vAlign=top>
        <TABLE width="100%" class=ListStyle cellspacing=1 >
          <COLGROUP>
		    <COL width=15%>
			<COL width=10%>
			<COL width=30%>
			<COL width=15%>
			<COL width=30%>
	      <TBODY>
          <TR class=header>
            <TH colSpan=5><%=SystemEnv.getHtmlLabelName(814,user.getLanguage())%></TH>
          </TR>
           <tr class=header>
		    <td><%=SystemEnv.getHtmlLabelName(431,user.getLanguage())%>	</td>
			<td><%=SystemEnv.getHtmlLabelName(1944,user.getLanguage())%>	</td>
			<td><%=SystemEnv.getHtmlLabelName(1914,user.getLanguage())%></td>
			<td><%=SystemEnv.getHtmlLabelName(1915,user.getLanguage())%></td>
			<td><%=SystemEnv.getHtmlLabelName(110,user.getLanguage())%>	</td>
		  </tr>


<%
  while(rs.next()){
    String member = Util.null2String(rs.getString("member"));
	String title = Util.null2String(rs.getString("title"));
	String company = Util.null2String(rs.getString("company"));
	String jobtitle = Util.null2String(rs.getString("jobtitle"));
	String address = Util.null2String(rs.getString("address"));
%>
	      <tr>
	        <TD class=Field>
              <%=member%>
            </TD>
	        <TD class=Field>
              <%=title%>
            </TD>
	        <TD class=Field>
              <%=company%>
            </TD>
	        <TD class=Field>
              <%=jobtitle%>
            </TD>
	        <TD class=Field>
              <%=address%>
            </TD>
	      </tr>
<%
  }
%>
      </tbody>
       </table>

<br>

<%----------------------------�Զ�����ϸ�ֶ� begin--------------------------------------------%>

	 <%

         RecordSet.executeSql("select id, formlabel from cus_treeform where parentid="+scopeId+" order by scopeorder");
         //System.out.println("select id from cus_treeform where parentid="+scopeId);
         int recorderindex = 0 ;
         while(RecordSet.next()){
             recorderindex = 0 ;
             int subId = RecordSet.getInt("id");
             CustomFieldManager cfm2 = new CustomFieldManager("HrmCustomFieldByInfoType",subId);
             cfm2.getCustomFields();
             CustomFieldTreeManager.getMutiCustomData("HrmCustomFieldByInfoType", subId, Util.getIntValue(id,0));
             int colcount1 = cfm2.getSize() ;
             int colwidth1 = 0 ;

             if( colcount1 != 0 ) {
                 colwidth1 = 100/colcount1 ;

     %>
	 <table Class=ListStyle  cellspacing="0" cellpadding="0">
        <tr class=header>

            <td align="left" >
            <b><%=RecordSet.getString("formlabel")%></b>
            </td>
            <td align="right">
            </td>
        </tr>
        <TR style="height:1px"><TD class=Line colSpan=2></TD>
        <tr>
            <td colspan=2>
            <table Class=ListStyle id="oTable_<%=subId%>"  cellspacing="1" cellpadding="0">
            <COLGROUP>
            <tr class=header>
   <%

       while(cfm2.next()){
		  String fieldlable =String.valueOf(cfm2.getLable());

   %>
		 <td width="<%=colwidth1%>%" nowrap><%=fieldlable%></td>
           <%
	   }
       cfm2.beforeFirst();
%>
</tr>
<%

    boolean isttLight = false;
    while(CustomFieldTreeManager.nextMutiData()){
            isttLight = !isttLight ;
%>
            <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
        <%
        while(cfm2.next()){
            String fieldid=String.valueOf(cfm2.getId());  //�ֶ�id
            String ismand=String.valueOf(cfm2.isMand());   //�ֶ��Ƿ��������
            String fieldhtmltype = String.valueOf(cfm2.getHtmlType());
            String fieldtype=String.valueOf(cfm2.getType());
            String fieldvalue =  Util.null2String(CustomFieldTreeManager.getMutiData("field"+fieldid)) ;

%>
            <td class=field style="TEXT-VALIGN: center;table-layout:fixed; word-break: break-all; overflow:hidden;">
<%
            if(fieldhtmltype.equals("1")||fieldhtmltype.equals("2")){                          // �����ı���
%>
                <%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>
<%
            }else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
                String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
                String showid = "";                                     // �½�ʱ��Ĭ��ֵ

                String newdocid = Util.null2String(request.getParameter("docid"));

                if( fieldtype.equals("37") && !newdocid.equals("")) {
                    if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                    fieldvalue += newdocid ;
                }

                if(fieldtype.equals("2") ||fieldtype.equals("19")){
                    showname=fieldvalue; // ����ʱ��
                }else if(!fieldvalue.equals("")) {
                    String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                    String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                    String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                    sql = "";

                    HashMap temRes = new HashMap();

                    if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }

                    rs.executeSql(sql);
                    if(isfromtab){}
                   while(rs.next()){
                        showid = Util.null2String(rs.getString(1)) ;
                        String tempshowname= Util.toScreen(rs.getString(2),user.getLanguage()) ;
                        if(!linkurl.equals(""))
                        //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                        	
                            temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
                        else{
                            //showname += tempshowname ;
                            temRes.put(String.valueOf(showid),tempshowname);
                        }
                    } 
                    StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                    String temstkvalue = "";
                    while(temstk.hasMoreTokens()){
                        temstkvalue = temstk.nextToken();

                        if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                            showname += temRes.get(temstkvalue);
                        }
                    }

                }
%>
                    <%=showname%>
<%
            }else if(fieldhtmltype.equals("4")) {                    // check��
%>
                <input type=checkbox disabled value=1 name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" <%if(fieldvalue.equals("1")){%> checked <%}%> >
<%
            }else if(cfm2.getHtmlType().equals("5")){
                cfm2.getSelectItem(cfm2.getId());
                while(cfm2.nextSelect()){
                    if(cfm2.getSelectValue().equals(fieldvalue)){
%>
            <%=cfm2.getSelectName()%>
<%
                        break;
                    }
                }
            }
%>
            </td>
<%
        }
        cfm2.beforeFirst();
        recorderindex ++ ;
    }

%>
</tr>

        </table>
        </td>
        </tr>
</table>

<%
             }
%>
<br>
<%
         }
%>

<%----------------------------�Զ�����ϸ�ֶ� end  --------------------------------------------%>


   </tr>

   </tbody>
</table>
</form>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
</table>

 <script language=javascript>
  function edit(){
    location = "/hrm/resource/HrmResourcePersonalEdit.jsp?isfromtab=<%=isfromtab%>&id=<%=id%>&isView=<%=isView%>";
  }
  function viewBasicInfo(){
    if(<%=isView%> == 0){
      //location = "/hrm/resource/HrmResourceBasicInfo.jsp?id=<%=id%>";
      location = "/hrm/employee/EmployeeManage.jsp?hrmid=<%=id%>";
    }else{
      location = "/hrm/resource/HrmResource.jsp?id=<%=id%>";
    }
  }
  function viewWorkInfo(){
    location = "/hrm/resource/HrmResourceWorkView.jsp?id=<%=id%>&isView=<%=isView%>";
  }
  function viewFinanceInfo(){
    location = "/hrm/resource/HrmResourceFinanceView.jsp?id=<%=id%>&isView=<%=isView%>";
  }
  function viewSystemInfo(){
    location = "/hrm/resource/HrmResourceSystemView.jsp?id=<%=id%>&isView=<%=isView%>";
  }
  function viewCapitalInfo(){
    location = "/cpt/search/CptMyCapital.jsp?id=<%=id%>";
  }
</script>
</body>
</html>