<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="weaver.systeminfo.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/web/css/style.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<SCRIPT language="javascript" src="/js/chechinput.js"></script>
</HEAD>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);

String careerid = Util.null2String(request.getParameter("careerid"));
String sql = "select * from HrmCareerInvite where id = "+careerid;
rs.executeSql(sql);
String opendate = "";
String jobtitle = "";
while(rs.next()){
 opendate = Util.null2String(rs.getString("createdate"));
 jobtitle = Util.null2String(rs.getString("careername"));
}

String inviteid = Util.null2String(request.getParameter("careerinvite"));

boolean hasFF = true;
RecordSet.executeProc("Base_FreeField_Select","hr");
if(RecordSet.getCounts()<=0)
	hasFF = false;
else
	RecordSet.first();
	
%>
<BODY>
<FORM name=resource id=resource action="/web/careerapply/HrmCareerApplyOperation.jsp" method=post>
	
	<input type=hidden name=operation value="add">
<%
  sql = "select max(id) from HrmResource";
  rs.executeSql(sql);
  rs.next();
  int id = rs.getInt(1);
  sql = "select max(id) from HrmCareerApply";
  rs.executeSql(sql);
  rs.next();
  if(id<rs.getInt(1)){
    id = rs.getInt(1); 
  }
    id +=1; 
    
%>
        <input type=hidden name=id value="<%=id%>">   

<DIV><BUTTON class=btnSave accessKey=S type=button onClick="doSave()"><U>S</U>-��һ��</BUTTON> </DIV>
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
            <TD height="1" background="/web/images/bg_hdotline.gif" colSpan=2></TD>
          </TR>
          <TR> 
            <TD>����</TD>
            <TD bgcolor="F6F6F6"> 
              <INPUT class=stedit maxLength=30 size=20 name="lastname" onchange='checkinput("lastname","lastnamespan")'>
              <SPAN id=lastnamespan>
               <IMG src="/images/BacoError.gif" align=absMiddle>
              </SPAN> 
            </TD>
          </TR>
          <TR> 
            <TD>�Ա�</TD>
            <TD bgcolor="F6F6F6"> 
              <select class=stedit id=sex name=sex>
                <option value=0 selected><%=SystemEnv.getHtmlLabelName(417,7)%></option>
                <option value=1><%=SystemEnv.getHtmlLabelName(418,7)%></option>
              </select>
            </TD>
          </TR>
          <tr> 
            <td>ӦƸ�����</td>
            <td bgcolor="F6F6F6"> 
              <select class=stedit id=category name=category>
                <option value=""></option>
                <option value="0" ><%=SystemEnv.getHtmlLabelName(134,7)%></option>
                <option value="1"  ><%=SystemEnv.getHtmlLabelName(1830,7)%></option>
                <option value="2" ><%=SystemEnv.getHtmlLabelName(1831,7)%></option>
                <option value="3" ><%=SystemEnv.getHtmlLabelName(1832,7)%></option>
              </select>
            </td>
          </TR>
<!--          
          <TR> 
            <TD>��Ƭ</TD>
            <TD bgcolor="F6F6F6"> 
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
          <TR class=Section> 
            <TH colSpan=4>&nbsp;</TH>
          </TR>
          <TR class=Separator> 
            <TD height="1" background="/web/images/bg_hdotline.gif" colSpan=3></TD>
          </TR>
<!--          
          <TR> 
            <TD>�����Ƹ��Ϣ����ʱ��</TD>
            <TD bgcolor="F6F6F6">
-->            
<%if(careerid.equals("")){%>            
<!--              <BUTTON class=Browser id=Selectcareerinvite onclick="onShowCareerInvite()"></BUTTON>
              <SPAN id=careerinvitespan>  
               <IMG src="/images/BacoError.gif" align=absMiddle>
              </SPAN> 
 -->              
<%}else{
%>
<!--               <%=opendate%>-->
<%}%>              
<!--              <INPUT id=careerinvite type=hidden name=careerinvite value="<%=careerid%>" onchange='checkinput("careerinvite","careerinvitespan")'>
            </TD>
          </TR>
-->          
          <TR> 
            <TD>ӦƸ��λ</TD>
            <TD bgcolor="F6F6F6">
<%if(careerid.equals("")){%>                        
<!--              <BUTTON class=Browser id=SelectJobTitle></BUTTON> -->
	      <BUTTON class=Browser id=Selectcareerinvite onclick="onShowCareerInvite()"></BUTTON> 
              <SPAN id=jobtitlespan>
                <%=JobTitlesComInfo.getJobTitlesname(jobtitle)%>
               <IMG src="/images/BacoError.gif" align=absMiddle>
              </SPAN> 
<%}else{
%>
               <%=JobTitlesComInfo.getJobTitlesname(jobtitle)%>
<%}%>                            
              <INPUT id=jobtitle type=hidden name=jobtitle value="<%=jobtitle%>"onchange='checkinput("jobtitle","jobtitlespan")'>
              <INPUT id=careerinvite type=hidden name=careerinvite value="<%=careerid%>" onchange='checkinput("careerinvite","careerinvitespan")'>              
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
	   <col width=35��> 
	   <col width="15��"> 
           <col width="35��">
         <tbody> 
	 <TR class=Section> 
           <TH colspan=4> ��ְ����</TH>
         </TR>
         <TR class=Separator> 
            <TD height="1" background="/web/images/bg_hdotline.gif"  colspan=4></TD>
         </TR>
	  <tr> 
            <td  > Ŀǰ��н</td>
            <td valign=top bgcolor="F6F6F6" > 
              <input class=stedit maxlength=30  size=20 name=salarynow  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("salarynow")'>
	    </td>
            <td>��������</td>
            <td valign=top bgcolor="F6F6F6" > 
               <input class=stedit maxlength=30  size=20 name=worktime  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("worktime");checkinput("worktime","worktimeimage")' >
		<SPAN id=worktimeimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
	    </td>
          </tr>
          <tr> 
            <td  > ��н����</td>
            <td valign=top bgcolor="F6F6F6" > 
              <input class=stedit maxlength=30  size=20 name=salaryneed  onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("salaryneed");checkinput("salaryneed","salaryneedimage")'>
	      <SPAN id=salaryneedimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
	    </td>
            <td>����</td>
            <td bgcolor="F6F6F6">
	       <BUTTON class=Browser id=SelectCurrencyID onClick="onShowCurrencyID()"></BUTTON> 
	       <SPAN class=stedit id=currencyidspan></SPAN> 
	       <INPUT id=currencyid type=hidden name=currencyid >
            </td>
          </tr>
          <tr> 
            <Td  > ��������</Td>
            <TD vAlign=top colspan="3" bgcolor="F6F6F6" > 
              <TEXTAREA class=stedit style="WIDTH: 100%" name=reason rows=6></TEXTAREA>
            </TD>
          </TR>
          <TR class=Section> 
            <Td  > ����Ҫ��</Td>
            <TD vAlign=top colspan="3" bgcolor="F6F6F6" > 
              <TEXTAREA class=stedit style="WIDTH: 100%" name=otherrequest rows=6></TEXTAREA>
            </TD>
          </TR>
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
          <TR class=Section> 
            <TH colSpan=2>��ϵ����</TH>
          </TR>
          <TR class=Separator> 
            <TD height="1" background="/web/images/bg_hdotline.gif" colSpan=2></TD>
          </TR>
          <tr> 
            <td>��ϵ��</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=30 size=20 name=contactor onchange='checkinput("contactor","contactorimage")'  >
	      <SPAN id=contactorimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
            </td>
          </tr>
          <tr> 
            <td>��������</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=8 size=20 name=homepostcode onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("homepostcode");checkinput("homepostcode","homepostcodeimage")' >
	      <SPAN id=homepostcodeimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
            </td>
          </tr>
          <tr> 
            <td>��ַ</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=100 size=20  onchange='checkinput("homeaddress","homeaddressimage")' name=homeaddress >
	      <SPAN id=homeaddressimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
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
            <TD height="1" background="/web/images/bg_hdotline.gif" colSpan=3></TD>
          </TR>
          <TR>
            <td>�����ʼ�</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=128 size=20  onchange='checkinput("email","emailimage")'  name=email >
	      <SPAN id=emailimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
            </td>
          </TR>
          <TR> 
            <td>�绰</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=15 size=20  onchange='checkinput("homephone","homephoneimage")'  name=homephone >
	      <SPAN id=homephoneimage><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
            </td>
          </TR>
          <TR> 
            <td>������ҳ</td>
            <td bgcolor="F6F6F6"> 
              <input class=stedit maxlength=100 size=20 name=homepage >
            </td>
          </TR>
          </TBODY> 
        </TABLE>
      </TD>
    </TR>	   
    <TR class=Separator valign="top"> 
      <TD  colspan=2> 
        <table width="100%">
          <colgroup>
            <col width=15%> 
            <col width=85%>
          <tbody> 
          <tr> 
	    <td >�Լ���</td>
            <td  bgcolor="F6F6F6" > 
              <textarea class=stedit style="WIDTH: 100%" name=selfcomment rows=6></textarea>
            </td>
          </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  
  
  </FORM>
<script language=vbs>

sub onShowCareerInvite()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/career/CareerInviteBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	//careerinvitespan.innerHtml = id(3)
	resource.careerinvite.value=id(0)
	jobtitlespan.innerHtml = id(1)
	resource.jobtitle.value= id(2)
	else 
	//careerinvitespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.careerinvite.value=""
	jobtitlespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.jobtitle.value=""
	end if
	end if	
end sub
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

<script language=javascript>
function doSave() {           
    if(check_form(document.resource,'lastname,jobtitle,careerinvite,worktime,salaryneed,contactor,homepostcode,homeaddress,email,homephone')){      
      document.resource.submit() ;	
    }
  }
function check_form(thiswins,items)
{
	thiswin = thiswins
	items = items + ",";
	
	for(i=1;i<=thiswin.length;i++)
	{
	tmpname = thiswin.elements[i-1].name;
	tmpvalue = thiswin.elements[i-1].value;
	while(tmpvalue.indexOf(" ") == 0)
		tmpvalue = tmpvalue.substring(1,tmpvalue.length);
	
	if(tmpname!="" &&items.indexOf(tmpname+",")!=-1 && tmpvalue == ""){
		 alert("<%=SystemEnv.getHtmlNoteName(14,7)%>");
		 return false;
		}

	}
	return true;
}
  
</script>

</BODY>
</HTML>
