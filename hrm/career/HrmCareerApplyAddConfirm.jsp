<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>

<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String applyid=Util.null2String(request.getParameter("applyid"));


String careerid = "";
String firstname = "";			/*��*/
String lastname = "";			/*��*/
String aliasname= "";				/*����*/
String titleid= "";				/*�ƺ�*/

String sex = "";
/*
�Ա�:
0:����
1:Ů��
2:δ֪
*/
String birthday = "";			/*����*/
String nationality = "" ;		/*����*/
String defaultlanguage = "" ;	/*��������*/
String maritalstatus = "" ;
/*
����״��:
0:δ��
1:�ѻ�
2:����
3:ͬ��
*/
String marrydate = "";			/*�������*/
String email ="";				/*����*/
String homeaddress = "";				/*��ͥ��ַ*/
String homepostcode ="" ;				/*��ͥ�ʱ�*/
String homephone = "";				/*��ͥ�绰*/

String certificatecategory = "";/**/
String certificatenum ="";			/*֤������*/
String nativeplace ="";				/*����*/
String educationlevel = "";			/*ѧ��*/
/*
ѧ��:
0:����
1:����
2:�м�
3:��ר
4:��ר
5:����
6:˶ʿ
7:��ʿ
8:����
*/
String bememberdate ="";				/*��������*/
String bepartydate ="";				/*�뵳����*/
String bedemocracydate ="" ;		/*��������*/
String regresidentplace = "";		/*�������ڵ�*/
String healthinfo = "" ;					/*����״��*/
/*
����״��:
0:����
1:����
2:һ��
3:�ϲ�
*/
String residentplace = "";			/*�־�ס��*/
String policy = "";							/*������ò*/
String degree ="" ;							/*ѧλ*/
String height = "";							/*���*/
String homepage = "" ;						/*������ҳ*/
String train = "";							/*��ѵ������֤��*/
String numberid ="";
String contactor ="" ;							/*��ϵ��*/
String category = "" ;						/*ӦƸ�����*/
String major ="";						/*רҵ*/							
String salarynow = "";				/*��ǰ��н*/
String worktime = "" ;				/*��������*/
String salaryneed = "" ;				/*��н����*/				
String reason = "" ;							/**/
String otherrequest = "" ;		/**/
String selfcomment ="" ;		/*�Լ���*/
String currencyid = "";				/*����*/

RecordSet.executeProc("HrmCareerApply_SelectById",applyid);
while(RecordSet.next()){
careerid = RecordSet.getString("careerid");
firstname =  RecordSet.getString("firstname") ;			/*��*/
lastname = RecordSet.getString("lastname") ;			/*��*/
aliasname= RecordSet.getString("aliasname") ;				/*����*/
titleid= RecordSet.getString("titleid") ;				/*�ƺ�*/
sex = RecordSet.getString("sex") ;
/*
�Ա�:
0:����
1:Ů��
2:δ֪
*/
birthday = RecordSet.getString("birthday");			/*����*/
nationality = RecordSet.getString("nationality");		/*����*/
defaultlanguage =  RecordSet.getString("defaultlanguage");	/*��������*/
maritalstatus =  RecordSet.getString("maritalstatus");
/*
����״��:
0:δ��
1:�ѻ�
2:����
3:ͬ��
*/
marrydate =RecordSet.getString("marrydate") ;			/*�������*/
email =RecordSet.getString("email");				/*����*/
homeaddress =RecordSet.getString("homeaddress");				/*��ͥ��ַ*/
homepostcode =RecordSet.getString("homepostcode");				/*��ͥ�ʱ�*/
homephone =RecordSet.getString("homephone") ;				/*��ͥ�绰*/
certificatecategory = RecordSet.getString("certificatecategory") ;/**/
certificatenum = RecordSet.getString("certificatenum");			/*֤������*/
nativeplace = RecordSet.getString("nativeplace") ;				/*����*/
educationlevel = RecordSet.getString("educationlevel");			/*ѧ��*/

bememberdate = RecordSet.getString("bememberdate") ;				/*��������*/
bepartydate = RecordSet.getString("bepartydate");				/*�뵳����*/
bedemocracydate = RecordSet.getString("bedemocracydate");		/*��������*/
regresidentplace = RecordSet.getString("regresidentplace") ;		/*�������ڵ�*/
healthinfo = RecordSet.getString("healthinfo");					/*����״��*/

residentplace = RecordSet.getString("residentplace");			/*�־�ס��*/
policy = RecordSet.getString("policy");							/*������ò*/
degree = RecordSet.getString("degree");							/*ѧλ*/
height = RecordSet.getString("height");							/*���*/
homepage =RecordSet.getString("homepage");						/*������ҳ*/
train = RecordSet.getString("train");							/*��ѵ������֤��*/
numberid = Util.toScreen(RecordSet.getString("numberid"),user.getLanguage()) ;							
}

RecordSet.executeProc("HrmCareerApplyOtherInfo_SByApp",applyid);
if (RecordSet.next()){

contactor = Util.toScreen(RecordSet.getString("contactor"),user.getLanguage()) ;							/*��ϵ��*/
category = Util.toScreen(RecordSet.getString("category"),user.getLanguage()) ;						/*ӦƸ�����*/
major = Util.toScreen(RecordSet.getString("major"),user.getLanguage()) ;						/*רҵ*/		
salarynow = Util.toScreen(RecordSet.getString("salarynow"),user.getLanguage()) ;				/*��ǰ��н*/
worktime = Util.toScreen(RecordSet.getString("worktime"),user.getLanguage()) ;				/*��������*/
 salaryneed = Util.toScreen(RecordSet.getString("salaryneed"),user.getLanguage()) ;				/*��н����*/				
reason = Util.toScreen(RecordSet.getString("reason"),user.getLanguage()) ;							/**/
otherrequest = Util.toScreen(RecordSet.getString("otherrequest"),user.getLanguage()) ;		/**/
selfcomment = Util.toScreen(RecordSet.getString("selfcomment"),user.getLanguage()) ;		/*�Լ���*/
currencyid = Util.toScreen(RecordSet.getString("currencyid"),user.getLanguage()) ;				/*����*/
}
String imagefilename = "/images/hdMaintenance.gif";
String titlename =SystemEnv.getHtmlLabelName(773,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(365,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(1402,user.getLanguage())+",javascript:OnSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(103,user.getLanguage())+",javascript:OnBack(),_self} " ;
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
<FORM name=resource id=resource method=post>
<input class=inputstyle type=hidden name=careerid value="<%=careerid%>">
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="50%"> <COL width="50%"> <TBODY> 
    <TR> 
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=Title> 
            <TH colSpan=2 ><%=SystemEnv.getHtmlLabelName(411,user.getLanguage())%></TH>
          </TR>
          <TR class=spacing> 
            <TD class=line1 colSpan=2></TD>
          </TR>
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(460,user.getLanguage())%></TD>
            <TD class=Field> <%=firstname%>
              <input class=inputstyle type=hidden  name="firstname" value="<%=firstname%>">
			</TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(461,user.getLanguage())%></TD>
            <TD class=Field> <%=lastname%>
              <input class=inputstyle type=hidden  name="lastname"  value="<%=lastname%>">
              </TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(462,user.getLanguage())%></TD>
            <TD class=Field> <%=Util.toScreen(ContacterTitleComInfo.getContacterTitlename(titleid),user.getLanguage())%> 
              <input class=inputstyle type=hidden name=titleid value="<%=titleid%>">
            </TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(416,user.getLanguage())%></TD>
            <TD class=Field> 
                <% if(sex.equals("0")) {%><%=SystemEnv.getHtmlLabelName(417,user.getLanguage())%><%}%>
                 <% if(sex.equals("1")) {%><%=SystemEnv.getHtmlLabelName(418,user.getLanguage())%><%}%>
                <% if(sex.equals("2")) {%><%=SystemEnv.getHtmlLabelName(463,user.getLanguage())%><%}%>
				  <input class=inputstyle type=hidden  name="sex" value="<%=sex%>">
            </TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(464,user.getLanguage())%></TD>
            <TD class=Field><%=birthday%>
              <input class=inputstyle type="hidden" name="birthday" value="<%=birthday%>">
            </TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1826,user.getLanguage())%></td>
            <td class=Field><%=height%>
			  <input class=inputstyle type=hidden  name="height" value="<%=height%>"> 
             </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1827,user.getLanguage())%></td>
            <td class=Field> 
                <% if(healthinfo.equals("0")) {%><%=SystemEnv.getHtmlLabelName(824,user.getLanguage())%><%}%>
                 <% if(healthinfo.equals("1")) {%><%=SystemEnv.getHtmlLabelName(821,user.getLanguage())%><%}%>
                <% if(healthinfo.equals("2")) {%><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%><%}%>
                <% if(healthinfo.equals("3")) {%><%=SystemEnv.getHtmlLabelName(825,user.getLanguage())%><%}%>
 			<input class=inputstyle type=hidden  name="healthinfo" value="<%=healthinfo%>"> 
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(465,user.getLanguage())%></TD>
            <TD class=Field><%=Util.toScreen(CountryComInfo.getCountrydesc(nationality),user.getLanguage())%>
              <INPUT class=inputStyle id=nationality type=hidden name=nationality value="<%=nationality%>">
            </TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
           <td><%=SystemEnv.getHtmlLabelName(231,user.getLanguage())%>-<%=SystemEnv.getHtmlLabelName(467,user.getLanguage())%></td>
            <td class=Field><%=Util.toScreen(LanguageComInfo.getLanguagename(defaultlanguage),user.getLanguage())%>
              <input class=inputStyle id=defaultlanguage type=hidden name=defaultlanguage value="<%=defaultlanguage%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(469,user.getLanguage())%></TD>
            <TD class=Field> 
                <% if(maritalstatus.equals("0")) {%><%=SystemEnv.getHtmlLabelName(470,user.getLanguage())%><%}%>
                 <% if(maritalstatus.equals("1")) {%><%=SystemEnv.getHtmlLabelName(471,user.getLanguage())%><%}%>
                <% if(maritalstatus.equals("2")) {%><%=SystemEnv.getHtmlLabelName(472,user.getLanguage())%><%}%>
                <% if(maritalstatus.equals("3")) {%><%=SystemEnv.getHtmlLabelName(473,user.getLanguage())%><%}%>
                 <input class=inputstyle type="hidden" name="maritalstatus" value="<%=maritalstatus%>">
			</TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(474,user.getLanguage())%></td>
            <td class=Field><%=marrydate%>
              <input class=inputstyle type="hidden" name="marrydate" value="<%=marrydate%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1828,user.getLanguage())%></td>
            <td class=Field><%=regresidentplace%>
              <input class=inputstyle type=hidden name=regresidentplace value="<%=regresidentplace%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1829,user.getLanguage())%></td>
            <td class=Field><%=residentplace%>
              <input class=inputstyle type=hidden name=residentplace value="<%=residentplace%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>
      </TD>
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=Title> 
            <TH colSpan=2>&nbsp;</TH>
          </TR>
          <TR class=spacing> 
            <TD class=Sep1 colSpan=2></TD>
            <TR> 
            <td><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></td>
            <TD class=Field><%=numberid%></TD>
           <input class=inputstyle type=hidden name=numberid value="<%=numberid%>">
            </tr>
            <TR><TD class=Line colSpan=2></TD></TR> 
       <TR> 
            <td><%=SystemEnv.getHtmlLabelName(178,user.getLanguage())%></td>
            <td class=Field> 
                <% if(category.equals("0")) {%><%=SystemEnv.getHtmlLabelName(134,user.getLanguage())%><%}%>
                 <% if(category.equals("1")) {%><%=SystemEnv.getHtmlLabelName(1830,user.getLanguage())%><%}%>
                <% if(category.equals("2")) {%><%=SystemEnv.getHtmlLabelName(1831,user.getLanguage())%><%}%>
                 <% if(category.equals("3")) {%><%=SystemEnv.getHtmlLabelName(1832,user.getLanguage())%><%}%>
	     <INPUT class=inputStyle id=category type=hidden name=category value="<%=category%>">			 
             </td>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
		  	<TR>
      <TD><%=SystemEnv.getHtmlLabelName(803,user.getLanguage())%></TD>
       <TD class=Field>
	   <%=major%>
       <INPUT class=inputStyle id=major type=hidden name=major value="<%=major%>">
       </TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <td><%=SystemEnv.getHtmlLabelName(818,user.getLanguage())%></td>
            <td class=Field> 
            <% if(educationlevel.equals("0")) {%>
            <%=SystemEnv.getHtmlLabelName(811,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("1")) {%>
            <%=SystemEnv.getHtmlLabelName(819,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("2")) {%>
            <%=SystemEnv.getHtmlLabelName(764,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("12")) {%>
            <%=SystemEnv.getHtmlLabelName(2122,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("13")) {%>
            <%=SystemEnv.getHtmlLabelName(2123,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("3")) {%>
            <%=SystemEnv.getHtmlLabelName(820,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("4")) {%>
            <%=SystemEnv.getHtmlLabelName(765,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("5")) {%>
            <%=SystemEnv.getHtmlLabelName(766,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("6")) {%>
            <%=SystemEnv.getHtmlLabelName(767,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("7")) {%>
            <%=SystemEnv.getHtmlLabelName(768,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("8")) {%>
            <%=SystemEnv.getHtmlLabelName(769,user.getLanguage())%> 
            <%}%>
            <% if(educationlevel.equals("9")) {%>
            MBA 
            <%}%>
            <% if(educationlevel.equals("10")) {%>
            EMBA 
            <%}%>
            <% if(educationlevel.equals("11")) {%>
             <%=SystemEnv.getHtmlLabelName(2119,user.getLanguage())%>  
            <%}%>
			<input class=inputstyle type="hidden" name="educationlevel" value="<%=educationlevel%>">
            </td>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1833,user.getLanguage())%></td>
            <td class=Field><%=degree%> 
			<input class=inputstyle type="hidden" name="degree" value="<%=degree%>">
           </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1834,user.getLanguage())%></td>
            <td class=Field><%=bememberdate%>
              <input class=inputstyle type="hidden" name="bememberdate" value="<%=bememberdate%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1835,user.getLanguage())%></td>
            <td class=Field><%=bepartydate%>
              <input class=inputstyle type="hidden" name="bepartydate" value="<%=bepartydate%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1836,user.getLanguage())%></td>
            <td class=Field><%=bedemocracydate%>
              <input class=inputstyle type="hidden" name="bedemocracydate" value="<%=bedemocracydate%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td height="29"><%=SystemEnv.getHtmlLabelName(1837,user.getLanguage())%></td>
            <td class=Field > <%=policy%>
			<input class=inputstyle type="hidden" name="policy" value="<%=policy%>">
              </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1838,user.getLanguage())%> </td>
            <td class=Field> <%=certificatecategory%>
			<input class=inputstyle type="hidden" name="certificatecategory" value="<%=certificatecategory%>">
            </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1839,user.getLanguage())%></td>
            <td class=Field> <%=certificatenum%>
			<input class=inputstyle type="hidden" name="certificatenum" value="<%=certificatenum%>">
             </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1840,user.getLanguage())%></td>
            <td class=Field> <%=nativeplace%>
			<input class=inputstyle type="hidden" name="nativeplace" value="<%=nativeplace%>">
           </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>
      </TD>
    </TR>
	 <TR class=spacing valign="top"> 
      <TD  colspan=2 > 
        <table width="100%">
          <colgroup> <col width=15%> <col width=85%> <tbody> 
           <tr> 
		  <td ><%=SystemEnv.getHtmlLabelName(1841,user.getLanguage())%></td>
            <td  class=Field > 
              <%=train%>
			  <input class=inputstyle type="hidden" name="train" value="<%=train%>">
            </td>
            </tr>
           <TR><TD class=Line colSpan=2></TD></TR>
          </tbody> 
        </table>
		 </td>
       </tr>
       <TR class=title> 
	 <TD vAlign=top colspan=2 > 
	<table class=viewForm >
		 <colgroup> 
         <col width="15%"> 
         <col width=35��> 
         <col width="15��"> 
         <col width="35��"> 
         <tbody> 
	  <TR class=title> 
        <TH colspan=4> <%=SystemEnv.getHtmlLabelName(1842,user.getLanguage())%></TH>
        </TR>
       <TR class=spacing> 
            <TD class=line1 colspan=4></TD>
     </TR>
	  <tr> 
       <td > <%=SystemEnv.getHtmlLabelName(1843,user.getLanguage())%></td>
                  <td valign=top class=Field > <%=salarynow%>
				    <input class=inputstyle type="hidden" name="salarynow" value="<%=salarynow%>">
                     </td>
                   <td><%=SystemEnv.getHtmlLabelName(1844,user.getLanguage())%></td>
            <td valign=top class=Field >   <%=worktime%>
			<input class=inputstyle type="hidden" name="worktime" value="<%=worktime%>">
                 </td>
                </tr>
                <TR><TD class=Line colSpan=6></TD></TR> 
                <tr> 
          <td  > <%=SystemEnv.getHtmlLabelName(1845,user.getLanguage())%></td>
                  <td valign=top class=Field > <%=salaryneed%>
				  <input class=inputstyle type="hidden" name="salaryneed" value="<%=salaryneed%>">
                    </td>
                   <td><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></td>
            <td class=Field>
			<%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyid),user.getLanguage())%>
			  <input class=inputstyle id=currencyid type=hidden name=currencyid value="<%=currencyid%>">
            </td>
                </tr>
                <TR><TD class=Line colSpan=6></TD></TR> 
                <tr> 
                  <Td  > <%=SystemEnv.getHtmlLabelName(1846,user.getLanguage())%></Td>
                  <TD vAlign=top colspan="3" class=Field >  <%=reason%>
				  <input class=inputstyle id=reason type=hidden name=reason value="<%=reason%>">
                  </TD>
                </TR>
                <TR><TD class=Line colSpan=2></TD></TR> 
                <TR class=title> 
                  <Td  > <%=SystemEnv.getHtmlLabelName(1847,user.getLanguage())%></Td>
                  <TD vAlign=top colspan="3" class=Field > <%=otherrequest%>
				  <input class=inputstyle  type=hidden name=otherrequest value="<%=otherrequest%>">
                  </TD>
                </TR>
                </tbody> 
              </table>
             </td>
            </tr>
	      <TR><TD class=Line colSpan=2></TD></TR> 
	   <TR> 
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=title> 
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(569,user.getLanguage())%></TH>
          </TR>
          <TR class=spacing> 
            <TD class=line1 colSpan=2></TD>
          </TR>
        <tr> 
            <td><%=SystemEnv.getHtmlLabelName(572,user.getLanguage())%></td>
            <td class=Field>   <%=contactor%>
			<input class=inputstyle  type=hidden name=contactor value="<%=contactor%>">
             </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(479,user.getLanguage())%></td>
            <td class=Field> <%=homepostcode%>
			<input class=inputstyle  type=hidden name=homepostcode value="<%=homepostcode%>">
              </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(110,user.getLanguage())%></td>
            <td class=Field><%=homeaddress%> 
			<input class=inputstyle  type=hidden name=homeaddress value="<%=homeaddress%>">
             </td>
          </tr>
          <TR><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=title> 
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=spacing> 
            <TD class=Sep3 colSpan=3></TD>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR>
            <td><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%></td>
            <td class=Field>
			 <%=email%>
			<input class=inputstyle  type=hidden name=email value="<%=email%>">
              </td>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <td><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></td>
            <td class=Field>
			<%=homephone%> 
			<input class=inputstyle  type=hidden name=homephone value="<%=homephone%>">
               </td>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          <TR> 
            <td><%=SystemEnv.getHtmlLabelName(1848,user.getLanguage())%></td>
            <td class=Field> <%=homepage%>
			<input class=inputstyle  type=hidden name=homepage value="<%=homepage%>">
             </td>
          </TR>
          <TR><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>
      </TD>
	  </TR>
	  
	   
	<TR class=spacing valign="top"> 
      <TD  colspan=2> 
        <table width="100%">
          <colgroup> 
          <col width=15%> 
          <col width=85%> 
          <tbody> 
           <tr> 
		    <td ><%=SystemEnv.getHtmlLabelName(1849,user.getLanguage())%></td>
            <td  class=Field > <%=selfcomment%>
			<input class=inputstyle  type=hidden name=selfcomment value="<%=selfcomment%>">
            </td>
            </tr>
           <TR><TD class=Line colSpan=2></TD></TR>
          </tbody> 
        </table>
		 </td>
       </tr>
       
   	<input class=inputstyle type=hidden name=applyid value="<%=applyid%>">

      <!-- ---------------------------------------------------------------------------->
    </TBODY> 
  </table>
  </FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>

</BODY>
<SCRIPT language="javascript">
function OnSubmit(){
    document.resource.action="HrmCareerApplyAdd2.jsp";
    document.resource.submit();   
}
function OnBack(){
    document.resource.action = "HrmCareerApplyAdd.jsp";
 	document.resource.submit();
}
</script>
</HTML>