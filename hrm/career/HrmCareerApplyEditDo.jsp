<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
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
if(!HrmUserVarify.checkUserRight("HrmCareerApplyEdit:Edit",user)) {
    response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
String applyid = Util.null2String(request.getParameter("applyid"));

rs.executeProc("HrmCareerApply_SelectById",applyid);
rs.next();

String inviteid = Util.null2String(rs.getString("careerinviteid"));
String jobtitle = Util.null2String(rs.getString("jobtitle"));
String ischeck = Util.null2String(rs.getString("ischeck"));
String ishire = Util.null2String(rs.getString("ishire"));
int picture = rs.getInt("picture");
String pictureshowname = "";
if(picture>0){
    rs1.executeSql("select imagefilename from ImageFile where imagefileid="+picture);
    if(rs1.next()){
        pictureshowname=rs1.getString("imagefilename");
    }
}

String firstname = Util.toScreen(rs.getString("firstname"),user.getLanguage()) ;			/*��*/
String lastname = Util.toScreen(rs.getString("lastname"),user.getLanguage()) ;			/*��*/
String titleid= Util.toScreen(rs.getString("titleid"),user.getLanguage()) ;				/*�ƺ�*/
String sex = Util.toScreen(rs.getString("sex"),user.getLanguage()) ;

String birthday = Util.toScreen(rs.getString("birthday"),user.getLanguage()) ;			/*����*/
String nationality = Util.toScreen(rs.getString("nationality"),user.getLanguage()) ;		/*����*/
String defaultlanguage = Util.toScreen(rs.getString("defaultlanguage"),user.getLanguage()) ;	/*��������*/
String maritalstatus = Util.toScreen(rs.getString("maritalstatus"),user.getLanguage()) ;

String marrydate = Util.toScreen(rs.getString("marrydate"),user.getLanguage()) ;			/*�������*/
String email = Util.toScreen(rs.getString("email"),user.getLanguage()) ;				/*����*/
String homeaddress = Util.toScreen(rs.getString("homeaddress"),user.getLanguage()) ;				/*��ͥ��ַ*/
String homepostcode = Util.toScreen(rs.getString("homepostcode"),user.getLanguage()) ;/*��ͥ�ʱ�*/

String homephone = Util.toScreen(rs.getString("homephone"),user.getLanguage()) ;				/*��ͥ�绰*/
String certificatecategory = Util.toScreen(rs.getString("certificatecategory"),user.getLanguage()) ;/**/
String certificatenum = Util.toScreen(rs.getString("certificatenum"),user.getLanguage()) ;			/*֤������*/
String nativeplace = Util.toScreen(rs.getString("nativeplace"),user.getLanguage()) ;
/*����*/
String educationlevel = Util.toScreen(rs.getString("educationlevel"),user.getLanguage()) ;			/*ѧ��*/
String bememberdate = Util.toScreen(rs.getString("bememberdate"),user.getLanguage()) ;				/*��������*/
String bepartydate = Util.toScreen(rs.getString("bepartydate"),user.getLanguage()) ;				/*�뵳����*/
String bedemocracydate = Util.toScreen(rs.getString("bedemocracydate"),user.getLanguage()) ;		/*��������*/
String regresidentplace = Util.toScreen(rs.getString("regresidentplace"),user.getLanguage()) ;		/*�������ڵ�*/
String healthinfo = Util.toScreen(rs.getString("healthinfo"),user.getLanguage()) ;					/*����״��*/
String residentplace = Util.toScreen(rs.getString("residentplace"),user.getLanguage()) ;			/*�־�ס��*/
String policy = Util.toScreen(rs.getString("policy"),user.getLanguage()) ;							/*������ò*/
String degree = Util.toScreen(rs.getString("degree"),user.getLanguage()) ;							/*ѧλ*/
String height = Util.toScreen(rs.getString("height"),user.getLanguage()) ;							/*���*/
String homepage = Util.toScreen(rs.getString("homepage"),user.getLanguage()) ;						/*������ҳ*/
String train = Util.toScreen(rs.getString("train"),user.getLanguage()) ;							/*��ѵ������֤��*/
String numberid = Util.toScreen(rs.getString("numberid"),user.getLanguage()) ;							/*��ѵ������֤��*/

rs.executeProc("HrmCareerApplyOtherInfo_SByApp",applyid);
rs.next();

String contactor = Util.toScreen(rs.getString("contactor"),user.getLanguage()) ;							/*��ϵ��*/
String category = Util.toScreen(rs.getString("category"),user.getLanguage()) ;						/*ӦƸ�����*/
String major = Util.toScreen(rs.getString("major"),user.getLanguage()) ;						/*רҵ*/
String salarynow = Util.toScreen(rs.getString("salarynow"),user.getLanguage()) ;				/*��ǰ��н*/
String worktime = Util.toScreen(rs.getString("worktime"),user.getLanguage()) ;				/*��������*/
String salaryneed = Util.toScreen(rs.getString("salaryneed"),user.getLanguage()) ;				/*��н����*/
String reason = Util.toScreen(rs.getString("reason"),user.getLanguage()) ;							/**/
String otherrequest = Util.toScreen(rs.getString("otherrequest"),user.getLanguage()) ;		/**/
String selfcomment = Util.toScreen(rs.getString("selfcomment"),user.getLanguage()) ;		/*�Լ���*/
String currencyid = Util.toScreen(rs.getString("currencyid"),user.getLanguage()) ;				/*����*/

String informman = "" ;
String principalid = "" ;
String planid = "" ;
if( !inviteid.equals("")) {
    rs.executeSql("select a.* from HrmCareerPlan a , HrmCareerInvite b where a.id = b.careerplanid and b.id = "+inviteid);
    while(rs.next()){
      principalid = Util.null2String(rs.getString("principalid"));
      informman = Util.null2String(rs.getString("informmanid"));
      planid = Util.null2String(rs.getString("id"));
    }
}

boolean isInformer = (Util.getIntValue(informman)==user.getUID());
boolean isPrincipal = (Util.getIntValue(principalid)==user.getUID());
boolean isAssessor = CareerApplyComInfo.isAssessor(applyid,user.getUID());
boolean isTester = CareerApplyComInfo.isTester(applyid,user.getUID());

String imagefilename = "/images/hdMaintenance.gif";
String titlename =SystemEnv.getHtmlLabelName(93,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(773,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(HrmUserVarify.checkUserRight("HrmCareerApplyEdit:Edit",user)) {
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}

RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doCancel(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="0" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM name=resource id=resource method=post action="HrmCareerApplyOperation.jsp" enctype="multipart/form-data">
	<input class=inputstyle type=hidden name=operation value="saveApply">
	<input class=inputstyle type=hidden name=applyid value="<%=applyid%>">
  <TABLE class=ViewForm>
    <COLGROUP>
    <COL width="49%">
    <COL width="49%">
    <TBODY>
    <TR>
      <TD vAlign=top>
        <TABLE width="100%">
          <COLGROUP>
          <COL width=30%>
          <COL width=70%>
          <TBODY>
          <TR class=Title>
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
          </TR>
          <TR class=spacing style="height:2px">
            <TD class=Line1 colSpan=2></TD>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <TR>
            <TD><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></TD>
            <TD class=Field>
              <INPUT class=inputstyle maxLength=30 size=30 name="lastname" onchange='checkinput("lastname","lastnamespan")' value="<%=lastname%>">
              <SPAN id=lastnamespan>
                <%if(lastname.equals("")){%>
                <IMG src="/images/BacoError.gif" align=absMiddle>
                <%}%>
              </SPAN>
            </TD>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <TR>
            <TD><%=SystemEnv.getHtmlLabelName(416,user.getLanguage())%></TD>
            <TD class=Field>
              <select class=inputstyle id=sex name=sex>
                <option value=0 <%if(sex.equals("0") ){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(417,user.getLanguage())%></option>
                <option value=1 <%if(sex.equals("1") ){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(418,user.getLanguage())%></option>
              </select>
            </TD>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(15675,user.getLanguage())%></td>
            <td class=Field>
              <select class=inputstyle id=category name=category>
                <option value=""></option>
                <option value="0" <%if(category.equals("0") ){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(134,user.getLanguage())%></option>
                <option value="1" <%if(category.equals("1") ){%>selected<%}%> ><%=SystemEnv.getHtmlLabelName(1830,user.getLanguage())%></option>
                <option value="2" <%if(category.equals("2") ){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1831,user.getLanguage())%></option>
                <option value="3" <%if(category.equals("3") ){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(1832,user.getLanguage())%></option>
              </select>
            </td>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
<!--
          <TR>
            <TD>��Ƭ</TD>
            <TD class=Field>
              <input type="file" name="photoid">
            </TD>
          </TR>
-->
          </TBODY>
        </TABLE>
    </TR>
    <TD vAlign=top>
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY>
          <TR class=Title>
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=spacing style="height:2px">
            <TD class=Line1 colSpan=3></TD>
          </TR>
<!--
          <TR>
            <TD>�����Ƹ��Ϣ����ʱ��</TD>
            <TD class=Field>
-->

          <TR>
            <TD><%=SystemEnv.getHtmlLabelName(15671,user.getLanguage())%></TD>
            <TD class=Field>
					<%
						String careername = "" ;
						careername = jobtitle ;
						if( Util.getIntValue(careername) != -1 ) careername = JobTitlesComInfo.getJobTitlesname(jobtitle) ;
					%>
							<BUTTON class=Browser type="button" id=Selectcareerinvite onClick="onShowCareerInvite()"></BUTTON>
							<SPAN id=jobtitlespan><%=careername%><%if(jobtitle.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN>

              <input class=inputstyle id=jobtitle type=hidden name=jobtitle value="<%=jobtitle%>" onchange='checkinput("jobtitle","jobtitlespan")'>
              <input class=inputstyle id=careerinvite type=hidden name=careerinvite value="<%=inviteid%>" onchange='checkinput("careerinvite","careerinvitespan")'>
            </TD>
          </TR>
       <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
       <TR>
          <TD>��Ƭ</TD>
          <%if(picture>0){%>
          <TD class=Field>
          <a href="/weaver/weaver.file.FileDownload?fileid=<%=picture%>&download=1"><%=pictureshowname%></a>
          <BUTTON class=btnDelete  onClick="delpic()"><%=SystemEnv.getHtmlLabelName(16075,user.getLanguage())%></BUTTON>
          <input class=inputstyle type=hidden size=30 name="pictureold" value="<%=picture%>">
          </TD>
          <%}else{%>
          <TD class=Field>
          <input class=inputstyle type=file name="picture">
          </TD>
          <%}%>
       </TR>
       <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
    <TR class=Title>
       <TD vAlign=top colspan=2 >
       <table class=ViewForm >
	 <colgroup>
	   <col width="15%">
	   <col width=35��>
	   <col width="15��">
       <col width="35��">
         <tbody>
	 <TR class=Title>
           <TH colspan=4> <%=SystemEnv.getHtmlLabelName(1842,user.getLanguage())%></TH>
         </TR>
         <TR class=Spacing style="height:2px">
            <TD class=Line1  colspan=4></TD>
         </TR>
	  <tr>
            <td  > <%=SystemEnv.getHtmlLabelName(1843,user.getLanguage())%></td>
            <td valign=top class=Field >
              <input class=inputstyle maxlength=30  size=30 name=salarynow  onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("salarynow")' value="<%=salarynow%>">
	    </td>
            <td><%=SystemEnv.getHtmlLabelName(1844,user.getLanguage())%></td>
            <td valign=top class=Field >
               <input class=inputstyle maxlength=3  size=30 name=worktime  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("worktime");checkinput("worktime","worktimeimage")' value="<%=worktime%>" >
            <SPAN id=worktimeimage>
                <%if(worktime.equals("")){%>
                <IMG src="/images/BacoError.gif" align=absMiddle>
                <%}%>
            </SPAN>
	    </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=6></TD></TR>
          <tr>
            <td  > <%=SystemEnv.getHtmlLabelName(1845,user.getLanguage())%></td>
            <td valign=top class=Field >
              <input class=inputstyle maxlength=30  size=30 name=salaryneed  onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("salaryneed");checkinput("salaryneed","salaryneedimage")' value="<%=salaryneed%>">
	      <SPAN id=salaryneedimage>
             <%if(salaryneed.equals("")){%>
                <IMG src="/images/BacoError.gif" align=absMiddle>
                <%}%>
          </SPAN>
	    </td>
            <td><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%></td>
            <td class=Field>

	       <input class="wuiBrowser" id=currencyid type=hidden name=currencyid value="<%=currencyid%>"
		   _url="/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp"
		   _displayTemplate="<%=Util.toScreen(CurrencyComInfo.getCurrencyname(currencyid),user.getLanguage())%>">
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=6></TD></TR>
          <tr>
            <Td  > <%=SystemEnv.getHtmlLabelName(1846,user.getLanguage())%></Td>
            <TD vAlign=top colspan="3" class=Field >
              <TEXTAREA class=inputstyle style="WIDTH: 100%" name=reason rows=3><%=Util.fromHtmlToEdit(reason)%></TEXTAREA>
            </TD>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <TR class=Section>
            <Td  > <%=SystemEnv.getHtmlLabelName(1847,user.getLanguage())%></Td>
            <TD vAlign=top colspan="3" class=Field >
              <TEXTAREA class=inputstyle style="WIDTH: 100%" name=otherrequest rows=3><%=Util.fromHtmlToEdit(otherrequest)%></TEXTAREA>
            </TD>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
        </tbody>
      </table>
    </td>
  </tr>
  <TR>
    <TD vAlign=top>
      <TABLE width="100%">
        <COLGROUP>
          <COL width=30%>
          <COL width=70%>
        <TBODY>
          <TR class=Title>
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(569,user.getLanguage())%></TH>
          </TR>
          <TR class=Spacing style="height:2px">
            <TD class=Line1 colSpan=2></TD>
          </TR>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(572,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=30 size=30 name=contactor onchange='checkinput("contactor","contactorimage")'  value="<%=contactor%>">
	          <SPAN id=contactorimage>
              <%if(contactor.equals("")){%>
              <IMG src='/images/BacoError.gif' align=absMiddle>
              <%}%>
              </SPAN>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=6></TD></TR>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(479,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=8 size=30 name=homepostcode onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("homepostcode");' value="<%=homepostcode%>">
              </SPAN>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=6></TD></TR>
          <tr>
            <td><%=SystemEnv.getHtmlLabelName(110,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=100 size=30 name=homeaddress value="<%=homeaddress%>">
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          </TBODY>
        </TABLE>
      <TD vAlign=top>
        <TABLE width="100%">
          <COLGROUP> <COL width=30%> <COL width=70%> <TBODY>
          <TR class=Title>
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=Spacing style="height:2px">
            <TD class=Line1 colSpan=3></TD>
          </TR>
          <TR>
            <td><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=128 size=30  onchange='checkinput_email("email","emailimage")'  name=email value="<%=email%>">
	      <SPAN id=emailimage>
              <%if(email.equals("")){%>
              <IMG src='/images/BacoError.gif' align=absMiddle>
              <%}%>
          </SPAN>
            </td>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <TR>
            <td><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=15 size=30  onchange='checkinput("homephone","homephoneimage")'  name=homephone value="<%=homephone%>">
	          <SPAN id=homephoneimage>
               <%if(homephone.equals("")){%>
              <IMG src='/images/BacoError.gif' align=absMiddle>
              <%}%>
              </SPAN>
            </td>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          <TR>
            <td><%=SystemEnv.getHtmlLabelName(1848,user.getLanguage())%></td>
            <td class=Field>
              <input class=inputstyle maxlength=100 size=30 name=homepage value="<%=homepage%>">
            </td>
          </TR>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
    <TR class=Spacing valign="top">
      <TD  colspan=2>
        <table width="100%">
          <colgroup>
            <col width=15%>
            <col width=85%>
          <tbody>
          <tr>
	    <td ><%=SystemEnv.getHtmlLabelName(1849,user.getLanguage())%></td>
            <td  class=Field >
              <textarea class=inputstyle style="WIDTH: 100%" name=selfcomment rows=6><%=Util.fromHtmlToEdit(selfcomment)%></textarea>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
        </tbody>
      </table>
    </td>
  </tr>
 </FORM>
</td>
</tr>
</TABLE>



</td>
</tr>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="0" colspan="3"></td>
</tr>
</table>
<script language=vbs>
sub onShowCurrencyID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	currencyidspan.innerHtml = id(1)
	resource.currencyid.value=id(0)
	else
	currencyidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.currencyid.value=""
	end if
	end if
end sub
</script>
<SCRIPT language="javascript">
function onShowCareerInvite(){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/career/CareerInviteBrowser.jsp?")
	if (data!=null){
	if (data.id!=0){
	//careerinvitespan.innerHtml = id(3)
	jQuery("#careerinvite").val(data.id);
	jQuery("#jobtitlespan").html(data.name);
	jQuery("#jobtitle").val(data.id);
	}else{
	//careerinvitespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	jQuery("#careerinvite").val("");
	jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
	jQuery("#jobtitle").val("");
	}
	}
}

function OnPass(){
    location="HrmInterviewResult.jsp?id=<%=applyid%>&result=1&planid=<%=planid%>";
}
function OnHire(){
    document.resource.action = "HrmCareerApplyToResource.jsp?id=<%=applyid%>&planid=<%=planid%>";
 	document.resource.submit();
}
function onDelete(){
		location="HrmInterviewResult.jsp?id=<%=applyid%>&result=0&planid=<%=planid%>";
}

function OnBack(){
    location="HrmInterviewResult.jsp?id=<%=applyid%>&result=2&planid=<%=planid%>";
}

function OnInterview(){
    location="HrmInterviewPlan.jsp?id=<%=applyid%>&planid=<%=planid%>";
}

function OnAssess(){
    location="HrmInterviewAssess.jsp?id=<%=applyid%>&planid=<%=planid%>";
}

function doCancel(){
    location="HrmCareerApplyEdit.jsp?applyid=<%=applyid%>";
}
function delpic(){
	if(confirm("ȷ��Ҫɾ������Ƭ��")){
		document.resource.operation.value = "delpic";
		document.resource.submit() ;
	}
}
function doSave(obj) {
   if(check_form(document.resource,'lastname,jobtitle,careerinvite,worktime,salaryneed,contactor,email,homephone')){
        obj.disabled = true;
        document.resource.submit() ;
    }
  }

</script>
</BODY>
</HTML>