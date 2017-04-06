<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>

<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String id = Util.null2String(request.getParameter("id"));

RecordSet.executeProc("HrmResource_SelectByID",id);
RecordSet.next();
String lastname = Util.toScreenToEdit(RecordSet.getString("lastname"),user.getLanguage()) ;			/*��*/
String sex = Util.toScreenToEdit(RecordSet.getString("sex"),user.getLanguage()) ;
/*
�Ա�:
0:����
1:Ů��
2:δ֪
*/
String birthday = Util.toScreenToEdit(RecordSet.getString("birthday"),user.getLanguage()) ;			/*����*/
String birthplace = Util.toScreenToEdit(RecordSet.getString("birthplace"),user.getLanguage()) ;		/*������*/
String maritalstatus = Util.toScreenToEdit(RecordSet.getString("maritalstatus"),user.getLanguage()) ;
/*
����״��:
0:δ��
1:�ѻ�
2:����
3:ͬ��
*/
String homeaddress = Util.toScreenToEdit(RecordSet.getString("homeaddress"),user.getLanguage()) ;				/*��ͥ��ַ*/
String homepostcode = Util.toScreenToEdit(RecordSet.getString("homepostcode"),user.getLanguage()) ;				/*��ͥ�ʱ�*/
String homephone = Util.toScreenToEdit(RecordSet.getString("homephone"),user.getLanguage()) ;				/*��ͥ�绰*/
String residentplace = Util.toScreenToEdit(RecordSet.getString("residentplace"),user.getLanguage()) ;		/*���ڵ�ַ*/
String residentpostcode = Util.toScreenToEdit(RecordSet.getString("residentpostcode"),user.getLanguage()) ;	/*�����ʱ�*/
String residentphone = Util.toScreenToEdit(RecordSet.getString("residentphone"),user.getLanguage()) ;		/*���ڵ绰*/
String certificatenum = Util.toScreenToEdit(RecordSet.getString("certificatenum"),user.getLanguage()) ;			/*֤������*/
String folk = Util.toScreenToEdit(RecordSet.getString("folk"),user.getLanguage()) ;				/*����*/
String policy = Util.toScreenToEdit(RecordSet.getString("policy"),user.getLanguage()) ;							/*������ò*/
/*�Զ����ֶ�*/
String textfield[] = new String[5] ;
for(int k=1 ; k<6;k++) textfield[k-1] = RecordSet.getString("textfield"+k) ;

String imagefilename = "/images/hdMaintenance.gif";
String titlename = lastname;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<DIV class=HdrProps></DIV>

<FORM name=resource id=resource action=HrmResourceOperation.jsp method=post enctype="multipart/form-data">
	<input type=hidden name=operation value="editresource">
	<input type=hidden name=id value="<%=id%>">
 
  <DIV><BUTTON class=btnSave accessKey=S  onclick="doSave()"><U>S</U>-<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></BUTTON> </DIV>
  
  <table class=Form>
    <tbody> 
    <tr> 
      <td valign=top> 
        <table width="100%">
          <colgroup> <col width=10%> <col width=30%> <col width=10%> <col width=16%> 
          <col width=10%> <col width=24%><tbody> 
          <tr class=Section> 
            <th colspan=6><%=SystemEnv.getHtmlLabelName(411,user.getLanguage())%></th>
          </tr>
          <tr class=Separator> 
            <td class=Sep1 colspan=6></td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=30 name="lastname" size=28 value="<%=lastname%>">
             </td>
            <td><%=SystemEnv.getHtmlLabelName(416,user.getLanguage())%></td>
            <TD class=Field> 
              <select class=saveHistory id=sex 
              name=sex>
                <option value=0 <% if(sex.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(417,user.getLanguage())%></option>
                <option value=1 <% if(sex.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(418,user.getLanguage())%></option>
                <option value=2 <% if(sex.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(463,user.getLanguage())%></option>
              </select>
            </TD>
            <td><%=SystemEnv.getHtmlLabelName(1884,user.getLanguage())%></td>
            <td class=Field><button class=Calendar id=selectbirthday onClick="getbirthdayDate()"></button> 
              <span id=birthdayspan ><%=birthday%></span> 
              <input type="hidden" name="birthday" value="<%=birthday%>">
            </td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1885,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=60 size=28 
            name=birthplace value="<%=birthplace%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(1886,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=30 size=15 
            name=folk value="<%=folk%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(469,user.getLanguage())%></td>
             <TD class=Field> 
              <SELECT class=saveHistory id=maritalstatus name=maritalstatus>
                <OPTION value=""> 
                <OPTION value=0 <% if(maritalstatus.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(470,user.getLanguage())%></OPTION>
                <OPTION value=1 <% if(maritalstatus.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(471,user.getLanguage())%></OPTION>
                <OPTION value=2 <% if(maritalstatus.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(472,user.getLanguage())%></OPTION>
                <OPTION value=3 <% if(maritalstatus.equals("3")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(473,user.getLanguage())%></OPTION>
              </SELECT>
            </TD>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1887,user.getLanguage())%></td>
              <td class=Field colspan=3> 
              <input class=saveHistory maxlength=60 size=62 
            name=certificatenum value="<%=certificatenum%>">
             </td>
            <td><%=SystemEnv.getHtmlLabelName(1901,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=30 size=15 
            name=policy value="<%=policy%>">
            </td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1829,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=60 size=28 
            name=residentplace value="<%=residentplace%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=15 size=15 
            name=residentphone value="<%=residentphone%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(1899,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=8 size=15
            name=residentpostcode onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("residentpostcode")'  value="<%=residentpostcode%>">
            </td>
          </tr>
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1900,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=60 size=28 
            name=homeaddress   value="<%=homeaddress%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=15 size=15
            name=homephone value="<%=homephone%>">
            </td>
            <td><%=SystemEnv.getHtmlLabelName(1899,user.getLanguage())%></td>
            <td class=Field> 
              <input class=saveHistory maxlength=8 size=15
            name=homepostcode onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("homepostcode")' value="<%=homepostcode%>">
            </td>
          </tr>
		  <%
boolean hasFF = true;
RecordSet.executeProc("Base_FreeField_Select","hr");
if(RecordSet.getCounts()<=0)
	hasFF = false;
else
	RecordSet.first();
	
if(hasFF)
{
    %>
	<TR>
    <%
	int i =1;
	if(RecordSet.getString(i*2+21).equals("1")) {
		 %>
       
          <TD><%=Util.toScreen(RecordSet.getString(i*2+20),user.getLanguage())%></TD>
          <TD class=Field  colspan=3>
		  <INPUT class=saveHistory maxLength=100 size=62 name="tff0<%=i%>" value="<%=Util.toScreen(textfield[i-1],user.getLanguage())%>">
		  </TD>
        
		<%}
	i=2;
	if(RecordSet.getString(i*2+21).equals("1")) {
		 %>
       
          <TD><%=Util.toScreen(RecordSet.getString(i*2+20),user.getLanguage())%></TD>
          <TD class=Field>
		  <INPUT class=saveHistory maxLength=100 size=15 name="tff0<%=i%>" value="<%=Util.toScreen(textfield[i-1],user.getLanguage())%>">
		  </TD>
        
		<%}
	
    %>
	</TR>
    <%
}
%>
          </tbody> 
        </table>
      </td>
    </tr>
    </tbody> 
  </table>
</FORM>
<Script language="javascript">

function doSave() {
    document.resource.submit();
}

</script>

</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
