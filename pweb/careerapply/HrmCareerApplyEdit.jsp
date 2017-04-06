<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CareerInviteComInfo" class="weaver.hrm.career.CareerInviteComInfo" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="CareerApplyComInfo" class="weaver.hrm.career.HrmCareerApplyComInfo" scope="page"/>
<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</HEAD>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
String applyid = Util.null2String(request.getParameter("applyid"));

rs.executeProc("HrmCareerApply_SelectById",applyid);
rs.next();

String inviteid = Util.null2String(rs.getString("careerinviteid"));
String jobtitle = Util.null2String(rs.getString("jobtitle"));

String ischeck = Util.null2String(rs.getString("ischeck"));
String ishire = Util.null2String(rs.getString("ishire"));
String firstname = Util.null2String(rs.getString("firstname")) ;			/*��*/
String lastname = Util.null2String(rs.getString("lastname")) ;			/*��*/
String titleid= Util.null2String(rs.getString("titleid")) ;				/*�ƺ�*/
String sex = Util.null2String(rs.getString("sex")) ;
String birthday = Util.null2String(rs.getString("birthday")) ;			/*����*/
String nationality = Util.null2String(rs.getString("nationality")) ;		/*����*/
String defaultlanguage = Util.null2String(rs.getString("defaultlanguage")) ;	/*��������*/
String maritalstatus = Util.null2String(rs.getString("maritalstatus")) ;
String marrydate = Util.null2String(rs.getString("marrydate")) ;			/*�������*/
String email = Util.null2String(rs.getString("email")) ;				/*����*/
String homeaddress = Util.null2String(rs.getString("homeaddress")) ;				/*��ͥ��ַ*/
String homepostcode = Util.null2String(rs.getString("homepostcode")) ;				/*��ͥ�ʱ�*/
String homephone = Util.null2String(rs.getString("homephone")) ;				/*��ͥ�绰*/
String certificatecategory = Util.null2String(rs.getString("certificatecategory")) ;/**/
String certificatenum = Util.null2String(rs.getString("certificatenum")) ;			/*֤������*/
String nativeplace = Util.null2String(rs.getString("nativeplace")) ;				/*����*/
String educationlevel = Util.null2String(rs.getString("educationlevel")) ;			/*ѧ��*/
String bememberdate = Util.null2String(rs.getString("bememberdate")) ;				/*��������*/
String bepartydate = Util.null2String(rs.getString("bepartydate")) ;				/*�뵳����*/
String bedemocracydate = Util.null2String(rs.getString("bedemocracydate")) ;		/*��������*/
String regresidentplace = Util.null2String(rs.getString("regresidentplace")) ;		/*�������ڵ�*/
String healthinfo = Util.null2String(rs.getString("healthinfo")) ;					/*����״��*/
String residentplace = Util.null2String(rs.getString("residentplace")) ;			/*�־�ס��*/
String policy = Util.null2String(rs.getString("policy")) ;							/*������ò*/
String degree = Util.null2String(rs.getString("degree")) ;							/*ѧλ*/
String height = Util.null2String(rs.getString("height")) ;							/*���*/
String homepage = Util.null2String(rs.getString("homepage")) ;						/*������ҳ*/
String train = Util.null2String(rs.getString("train")) ;							/*��ѵ������֤��*/
String numberid = Util.null2String(rs.getString("numberid")) ;							/*��ѵ������֤��*/

rs.executeProc("HrmCareerApplyOtherInfo_SByApp",applyid);
rs.next();

String contactor = Util.null2String(rs.getString("contactor")) ;							/*��ϵ��*/
String category = Util.null2String(rs.getString("category")) ;						/*ӦƸ�����*/
String major = Util.null2String(rs.getString("major")) ;						/*רҵ*/							
String salarynow = Util.null2String(rs.getString("salarynow")) ;				/*��ǰ��н*/
String worktime = Util.null2String(rs.getString("worktime")) ;				/*��������*/
String salaryneed = Util.null2String(rs.getString("salaryneed")) ;				/*��н����*/				
String reason = Util.null2String(rs.getString("reason")) ;							/**/
String otherrequest = Util.null2String(rs.getString("otherrequest")) ;		/**/
String selfcomment = Util.null2String(rs.getString("selfcomment")) ;		/*�Լ���*/
String currencyid = Util.null2String(rs.getString("currencyid")) ;				/*����*/

%>
<BODY>
<DIV class=HdrProps></DIV>
<FORM name=resource id=resource method=post>
	<input type=hidden name=operation>
	<input type=hidden name=applyid value="<%=applyid%>">

<DIV>
<BUTTON class=btn id=Edit accessKey=E onclick="location='HrmCareerApplyEditDo.jsp?applyid=<%=applyid%>'"><U>E</U>-�༭</BUTTON>
<BUTTON class=btn id=Delete accessKey=P onclick="location='HrmCareerApplyPerView.jsp?id=<%=applyid%>'"><U>P</U>-������Ϣ</BUTTON>
<BUTTON class=btn id=Delete accessKey=W onclick="location='HrmCareerApplyWorkView.jsp?id=<%=applyid%>'"><U>W</U>-������Ϣ</BUTTON>
</DIV>

<TABLE class=Form>
    <COLGROUP> <COL width="49%"> <COL width=10> <COL width="49%"> <TBODY> 
    <TR> 
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%><TBODY> 
          <TR class=Section> 
            <TH colSpan=2>������Ϣ</TH>
          </TR>
          <TR class=Separator> 
            <TD class=Sep1 colSpan=2></TD>
          </TR>
          <TR> 
            <TD>����</TD>
            <TD class=Field> 
              <%=lastname%>
            </TD>
          </TR>
          <TR> 
            <TD>�Ա�</TD>
            <TD class=Field> 
              <% if(sex.equals("0")) {%><%=SystemEnv.getHtmlLabelName(417,7)%><%}%>
              <% if(sex.equals("1")) {%><%=SystemEnv.getHtmlLabelName(418,7)%><%}%>
              <% if(sex.equals("2")) {%><%=SystemEnv.getHtmlLabelName(463,7)%><%}%>
            </TD>
          </TR>
          <tr> 
            <td>ӦƸ�����</td>
            <td class=Field> 
              <% if(category.equals("0")) {%><%=SystemEnv.getHtmlLabelName(134,7)%><%}%>
              <% if(category.equals("1")) {%><%=SystemEnv.getHtmlLabelName(1830,7)%><%}%>
              <% if(category.equals("2")) {%><%=SystemEnv.getHtmlLabelName(1831,7)%><%}%>
              <% if(category.equals("3")) {%><%=SystemEnv.getHtmlLabelName(1832,7)%><%}%>
            </td>
          </TR>     
          </TBODY> 
        </TABLE>      
    </TR>
    <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=Section> 
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=Separator> 
            <TD class=Sep3 colSpan=3></TD>
          </TR>
          <TR> 
            <TD>��Ƹ��Ϣ����ʱ��</TD>
            <TD class=Field>              
                <%=CareerInviteComInfo.getCareerInvitedate(inviteid)%>              
            </TD>
          </TR>
          <TR> 
            <TD>ӦƸ��λ</TD>
            <TD class=Field>                             
               <%=JobTitlesComInfo.getJobTitlesname(jobtitle)%>              
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
      </TD>
    </TR>	     

<TR class=Section> 
  <TD vAlign=top colspan=2 > 
  <table class=Form >
    <colgroup> 
      <col width="15%">
      <col width="35%"> 
      <col width="15%"> 
      <col width="35%">
    <tbody> 
    <TR class=Section> 
      <TH colspan=4> ��ְ����</TH>
    </TR>
    <TR class=Separator> 
      <TD class=sep2  colspan=4></TD>
    </TR>
    <tr> 
      <td> Ŀǰ��н</td>
      <td valign=top class=Field > 
        <%=salarynow%>
      </td>
      <td>��������
      </td>
      <td valign=top class=Field >   
        <%=worktime%>
      </td>
    </tr>
    <tr> 
      <td  > ��н����</td>
      <td valign=top class=Field > 
        <%=salaryneed%>
      </td>
      <td>����</td>
      <td class=Field>
	<%=Util.null2String(CurrencyComInfo.getCurrencyname(currencyid))%>
      </td>
    </tr>
    <tr> 
      <Td  > ��������</Td>
      <TD vAlign=top colspan="3" class=Field >  
        <%=reason%>
      </TD>
    </TR>
    <TR class=Section> 
      <Td  > ����Ҫ��</Td>
      <TD vAlign=top colspan="3" class=Field > 
        <%=otherrequest%>
      </TD>
    </TR>
    </tbody> 
  </table>
</td>
</tr>    

 
	   <TR> 
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=Section> 
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(569,7)%></TH>
          </TR>
          <TR class=Separator> 
            <TD class=Sep3 colSpan=2></TD>
          </TR>
        <tr> 
            <td><%=SystemEnv.getHtmlLabelName(572,7)%></td>
            <td class=Field>   <%=contactor%>
             </td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(479,7)%></td>
            <td class=Field> <%=homepostcode%>
              </td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(110,7)%></td>
            <td class=Field><%=homeaddress%> 
             </td>
          </tr>
          </TBODY> 
        </TABLE>
      <TD vAlign=top> 
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY> 
          <TR class=Section> 
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=Separator> 
            <TD class=Sep3 colSpan=3></TD>
          </TR>
          <TR>
            <td><%=SystemEnv.getHtmlLabelName(477,7)%></td>
            <td class=Field>
			 <%=email%>
              </td>
          </TR>
          <TR> 
            <td><%=SystemEnv.getHtmlLabelName(421,7)%></td>
            <td class=Field>
			<%=homephone%> 
               </td>
          </TR>
          <TR> 
            <td><%=SystemEnv.getHtmlLabelName(1848,7)%></td>
            <td class=Field> <%=homepage%>
             </td>
          </TR>

          </TBODY>
        </TABLE>
      </TD>
    </TR>
    <TR>
        <TD colspan="2"><%=SystemEnv.getHtmlLabelName(1849,7)%></TD>

      </TR>
      <TR><TD class=Line colSpan=6></TD></TR>
      <TR>
        <TD colspan = "4" class="Field"><%=selfcomment%></TD>
      </TR>
 </TABLE>
  </FORM>
  </BODY>
<SCRIPT language="javascript">
function OnPass(){
    location="HrmInterviewResult.jsp?id=<%=applyid%>&result=1";
}
function OnHire(){
    document.resource.action = "HrmCareerApplyToResource.jsp?id=<%=applyid%>";
 	document.resource.submit();
}
function onDelete(){
		location="HrmInterviewResult.jsp?id=<%=applyid%>&result=0";
}

function OnBack(){
    location="HrmInterviewResult.jsp?id=<%=applyid%>&result=2";
}

function OnInterview(){
    location="HrmInterviewPlan.jsp?id=<%=applyid%>";
}

function OnAssess(){
    location="HrmInterviewAssess.jsp?id=<%=applyid%>";
}
</script>
</HTML>
