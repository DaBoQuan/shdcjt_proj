<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CareerPlanComInfo" class="weaver.hrm.career.CareerPlanComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="UseKindComInfo" class="weaver.hrm.job.UseKindComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
int isplan = Util.getIntValue(request.getParameter("isplan"),0);
char separator = Util.getSeparator() ;

String careerpeople = Util.null2String(request.getParameter("careerpeople"));
String careerage = Util.null2String(request.getParameter("careerage"));
String careersex = Util.null2String(request.getParameter("careersex"));
String careeredu = Util.null2String(request.getParameter("careeredu"));

String careermode = Util.null2String(request.getParameter("careermode"));
String careername = Util.toScreenToEdit(request.getParameter("careername"),user.getLanguage());
String careeraddr = Util.toScreenToEdit(request.getParameter("careeraddr"),user.getLanguage());
String careerclass = Util.toScreenToEdit(request.getParameter("careerclass"),user.getLanguage());

String careerdesc = Util.toScreenToEdit(request.getParameter("careerdesc"),user.getLanguage());
String careerrequest = Util.toScreenToEdit(request.getParameter("careerrequest"),user.getLanguage());
String careerremark = Util.toScreenToEdit(request.getParameter("careerremark"),user.getLanguage());
String planid = Util.null2String(request.getParameter("plan"));

String isweb = Util.null2String(request.getParameter("isweb"));
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(366,user.getLanguage())+" : "+SystemEnv.getHtmlLabelName(82,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(HrmUserVarify.checkUserRight("HrmCareerInviteAdd:Add", user) || isplan == 2 || isplan == 1 ){
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:OnSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doback(),_self} " ;
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
<%
if(msgid!=-1){
%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
</font>
</DIV>
<%}%>
<FORM name=frmain action=HrmCareerInviteOperation.jsp? method=post>
<input class=inputstyle type="hidden" name="operation" value="addcareerinvite">
  <table class=ViewForm>
    <colgroup> 
    <col width="49%"> 
    <col width="49%"> 
    <tbody> 
    <tr> 
      <td valign=top> 
        <table width="100%">
          <colgroup> <col width=15%> <col width=85%><tbody> 
          <tr class=Title> 
            <th colspan=2 >
              <div align="left"><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%></div>
            </th>
          </tr>
          <tr class= Spacing style="height:2px"> 
            <td class=Line1 colspan=2></td>
          </tr>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr>
          <td><%=SystemEnv.getHtmlLabelName(6132,user.getLanguage())%></td>
          <td class=Field>
		  <!--
          <BUTTON class=Browser id=SelectPlan onclick="onShowCareerPlan()"></BUTTON> 
		  -->
          <SPAN id=planspan>
            <%=CareerPlanComInfo.getCareerPlantopic(planid)%> 
           </SPAN> 
           <input class=inputstyle id=plan type=hidden name=plan value="<%=planid%>">
           </td>
          </tr> 
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td ><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%></td>
            <td class=Field > 

               <input class="wuiBrowser" id=careername type=hidden name=careername value="<%=careername%>" onChange='checkinput("careername","careernameimage")' _required="yes"
			   _url="/systeminfo/BrowserMain.jsp?url=/hrm/jobtitles/JobTitlesBrowser.jsp"
			   _displayText="<%=JobTitlesComInfo.getJobTitlesname(careername)%>">                          		
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1864,user.getLanguage())%></td>
            <td class=Field> 
              <input class=inputstyle maxlength=4 size=15 name="careerpeople" value='<%=careerpeople%>' onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("careerpeople")'>			
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
<!--          
          <tr> 
            <td>ְ������</td>
            <td class=Field><input class=inputstyle maxlength=60 size=15 name="careerclass" value='<%=careerclass%>'>
            </td>
          </tr>
-->          
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(804,user.getLanguage())%></td>
            <td class=Field>

             <input class="wuiBrowser" type=hidden name=careermode value="<%=careermode%>"
			 _url="/systeminfo/BrowserMain.jsp?url=/hrm/usekind/UseKindBrowser.jsp"
			 _displayText="<%=UseKindComInfo.getUseKindname(careermode)%>">                         
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(419,user.getLanguage())%></td>
            <td class=Field> 
              <input class=inputstyle maxlength=100 size=45 name="careeraddr" value='<%=careeraddr%>'>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
         </tbody> 
        </table>
      </td>
      <td valign=top> 
        <table width="100%">
          <colgroup> <col width=15%> <col width=85%> <tbody> 
          <tr class=Title> 
            <th colspan=2>
              <div align="left"><%=SystemEnv.getHtmlLabelName(1867,user.getLanguage())%></div>
            </th>
          </tr>
          <tr class= Spacing style="height:2px"> 
            <td class=Line1 colspan=2></td>
          </tr>
          <tr> 
            <td width><%=SystemEnv.getHtmlLabelName(416,user.getLanguage())%></td>
      <TD width=35% class=field>
        <select class=inputstyle id=careersex name=careersex>
          <option value="0" <%if (careersex.equals("0")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(417,user.getLanguage())%></option>
          <option value="1" <%if (careersex.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(418,user.getLanguage())%></option>
          <option value="2" <%if (careersex.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(763,user.getLanguage())%></option>
        </select>
      </TD>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(671,user.getLanguage())%></td>
            <td class=Field> 
              <input class=inputstyle maxlength=20  size=15 name=careerage value='<%=careerage%>'>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td><%=SystemEnv.getHtmlLabelName(1860,user.getLanguage())%></td>
      <TD width=40% class=field>
        <select class=inputstyle id=careeredu name=careeredu>
          <option value="0" <%if (careeredu.equals("0")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(764,user.getLanguage())%></option>
          <option value="1" <%if (careeredu.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(765,user.getLanguage())%></option>
          <option value="2" <%if (careeredu.equals("2")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(766,user.getLanguage())%></option>
          <option value="3" <%if (careeredu.equals("3")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(767,user.getLanguage())%></option>
          <option value="4" <%if (careeredu.equals("4")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(768,user.getLanguage())%></option>
          <option value="5" <%if (careeredu.equals("5")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(769,user.getLanguage())%></option>
          <option value="6" <%if (careeredu.equals("6")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(763,user.getLanguage())%></option>
        </select>
      </TD>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          <tr> 
            <td width><%=SystemEnv.getHtmlLabelName(15719,user.getLanguage())%></td>
      <TD width=35% class=field>
        <select class=inputstyle id=careersex name=isweb value="<%=isweb%>">
          <option value="0" <%if (isweb.equals("0")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></option>
          <option value="1" <%if (isweb.equals("1")){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></option>          
      </TD>
            </td>
          </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD></TR> 
          </tbody> 
        </table>
      </td>
    </tr>
    <tr> 
      <td  colspan="2"> 
<TABLE class=ViewForm>
          <TBODY> 
          <TR class=Title> 
            <TH><%=SystemEnv.getHtmlLabelName(1858,user.getLanguage())%></TH>
          </TR>
          <tr class= Spacing style="height:2px"> 
            <td class=Line1 colspan=2></td>
          </tr>
          <TR> 
            <TD vAlign=top class="Field"> 
              <TEXTAREA class=inputstyle style="WIDTH: 100%" name=careerdesc rows=6 value="<%=careerdesc%>"><%=careerdesc%></TEXTAREA>
            </TD>
          </TR>
		  <TR style="height:1px"><TD class=Line ></TD></TR> 
          </TBODY> 
        </TABLE>
       <TABLE class=ViewForm>
          <TBODY> 
          <TR class=Title> 
            <TH>
              <p><%=SystemEnv.getHtmlLabelName(1868,user.getLanguage())%></p>
              </TH>
          </TR>
          <tr class= Spacing style="height:2px"> 
            <td class=Line1 colspan=2></td>
          </tr>
          <TR> 
            <TD vAlign=top class="Field"> 
              <TEXTAREA class=inputstyle style="WIDTH: 100%" name=careerrequest rows=6 value="<%=careerrequest%>"><%=careerrequest%></TEXTAREA>
            </TD>
          </TR>
		  <TR style="height:1px"><TD class=Line ></TD></TR> 
          </TBODY> 
        </TABLE>
		<TABLE class=ViewForm>
          <TBODY> 
          <TR class=Title> 
            <TH><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></TH>
          </TR>
           <tr class= Spacing style="height:2px"> 
            <td class=Line1 colspan=2></td>
          </tr>
          <TR> 
            <TD vAlign=top class="Field"> 
              <TEXTAREA class=inputstyle style="WIDTH: 100%" name=careerremark rows=6 value="<%=careerremark%>"><%=careerremark%></TEXTAREA>
            </TD>
          </TR>
		  <TR style="height:1px"><TD class=Line ></TD></TR> 
          </TBODY> 
        </TABLE>
      </td>
    </tr>
    </tbody> 
  </table>
  
      <TABLE width="100%"  class=ListStyle cellspacing=1  cols=5 id="oTable">
          
	   <TBODY> 
          <TR class=Header> 
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(15720,user.getLanguage())%></TH>
	    <Td align=right colspan=3>
	 	<BUTTON class=btnNew type="button" accessKey=A onClick="addRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON>
		<BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:confirmDel();"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>	
 	    </Td>
          </TR>
           <tr class=header>
        <td ></td>
	    <td ><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
	    <td ><%=SystemEnv.getHtmlLabelName(15722,user.getLanguage())%></td>
	    <td ><%=SystemEnv.getHtmlLabelName(15723,user.getLanguage())%></td>
		<td ><%=SystemEnv.getHtmlLabelName(15721,user.getLanguage())%></td>	    

        </tr> 


<%
  int rowindex = 0;
  String sql = "select * from HrmCareerPlanStep where planid = "+planid + " order by id " ;  
  RecordSet.executeSql(sql);
  while(RecordSet.next()){
        String stepstartdate = Util.null2String(RecordSet.getString("stepstartdate"));
	String stependdate = Util.null2String(RecordSet.getString("stependdate"));
	String stepname = Util.null2String(RecordSet.getString("stepname"));
	String assessor = Util.null2String(RecordSet.getString("assessor"));
	String assessstartdate = Util.null2String(RecordSet.getString("assessstartdate"));
	String assessenddate = Util.null2String(RecordSet.getString("assessenddate"));
	String informdate = Util.null2String(RecordSet.getString("informdate"));
%>
	  <tr>
            <TD class=Field width=10>
                <div>
              	<input class=inputstyle type='checkbox' name='check_node' value='0'>
                </div>
            </td>
	    <TD class=Field>
                <div>
              	<input class=inputstyle type=text style='width:100%' name="stepname_<%=rowindex%>" value="<%=stepname%>">
                </div>
            </TD>
	    <TD class=Field width=100>
                <div>
             	<BUTTON class=Calendar type="button" id=selectstepdate  onclick='getDate(stepstartdatespan_<%=rowindex%> , stepstartdate_<%=rowindex%>)' > </BUTTON>
             	<SPAN id='stepstartdatespan_<%=rowindex%>'><%=stepstartdate%></SPAN> 
             	<input class=inputstyle type=hidden id='stepstartdate_<%=rowindex%>' name='stepstartdate_<%=rowindex%>' value="<%=stepstartdate%>">
                 </div>
            </TD>
	    <TD class=Field width=100>
                <div>
             	<BUTTON class=Calendar type="button" id=selectstepdate   onclick='getDate(stependdatespan_<%=rowindex%> , stependdate_<%=rowindex%>)' > </BUTTON>
             	<SPAN id='stependdatespan_<%=rowindex%>'><%=stependdate%></SPAN> 
             	<input class=inputstyle type=hidden id='stependdate_<%=rowindex%>' name='stependdate_<%=rowindex%>' value="<%=stependdate%>">
                 </div>
            </TD>
            <TD class=Field width=130>
                <div>

	          <input class="wuiBrowser" type=hidden name=assessor_<%=rowindex%> value="<%=assessor%>"
			  _url="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
			  _displayText="<%=ResourceComInfo.getResourcename(assessor)%>">
               </div>
            </TD>

	  </tr>
<%
	rowindex++;
  }
 
%>        
</tbody>
</table>
<input class=inputstyle type=hidden name=rownum>
<input class=inputstyle type=hidden name=isplan value="<%=isplan%>">
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
<SCRIPT language="vbs">
sub onShowUsekind()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/usekind/UseKindBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	usekindspan.innerHtml = id(1)
	frmain.careermode.value=id(0)
	else
	usekindspan.innerHtml = ""
	frmain.careermode.value=""
	end if
	end if
end sub
sub onShowCareerPlan()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/career/careerplan/CareerPlanBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	planspan.innerHtml = id(1)
	frmain.plan.value=id(0)
	else
	planspan.innerHtml = ""
	frmain.plan.value=""
	end if
	end if
	frmain.action="HrmCareerInviteAdd.jsp"
	frmain.submit()
end sub
sub onShowJobtitle()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/jobtitles/JobTitlesBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	careernameimage.innerHtml = id(1)
	frmain.careername.value=id(0)
	else
	careernameimage.innerHtml = "<img src='/images/BacoError.gif' align=absMiddle>"
	frmain.careername.value=""
	end if
	end if
end sub
sub onShowResource(inputspan,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	inputspan.innerHtml = id(1)
	inputname.value=id(0)
	else
	inputspan.innerHtml = ""
	inputname.value=""
	end if
	end if
end sub
</SCRIPT>
<script language="JavaScript" src="/js/addRowBg.js" >
</script>
<SCRIPT language="javascript">
function OnSubmit(){
    if(check_form(document.frmain,"careername")) {
		if(checkDateValidity()){
	    document.frmain.rownum.value=rowindex;
		document.frmain.submit();
		}
	}
}
function onDelete(){
		if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
			document.frmain.operation.value="deletecareerinvite";
			document.frmain.submit();
		}
}
rowindex = <%=rowindex%>;
var rowColor="" ;
function addRow()
{
	ncol = jQuery(oTable).find("tr:nth-child(2)").find("td").length;
	oRow = oTable.insertRow(-1);
	rowColor = getRowBg();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		switch(j) {
                   	 case 0:
                 		oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  style='width:100%' name='check_node' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='stepname_"+rowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
                		oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectstepstartdate onclick='getDate(stepstartdatespan_"+rowindex+" , stepstartdate_"+rowindex+")' > </BUTTON><SPAN id='stepstartdatespan_"+rowindex+"'></SPAN> <input class=inputstyle type=hidden id='stepstartdate_"+rowindex+"' name='stepstartdate_"+rowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
                		oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectstependdate onclick='getDate(stependdatespan_"+rowindex+" , stependdate_"+rowindex+")' > </BUTTON><SPAN id='stependdatespan_"+rowindex+"'></SPAN> <input class=inputstyle type=hidden id='stependdate_"+rowindex+"' name='stependdate_"+rowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
			case 4: 
			        oCell.style.width=130
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class='wuiBrowser' type=hidden name='assessor_"+rowindex+"' _url='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				jQuery(oDiv).find(".wuiBrowser").modalDialog();
				break;
			case 5: 
                		oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar  id=selectassessstartdate onclick='getDate(assessstartdatespan_"+rowindex+" , assessstartdate_"+rowindex+")' > </BUTTON><SPAN id='assessstartdatespan_"+rowindex+"'></SPAN> <input class=inputstyle type=hidden id='assessstartdate_"+rowindex+"' name='assessstartdate_"+rowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 6: 
                		oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar  id=selectassessenddate onclick='getDate(assessenddatespan_"+rowindex+" , assessenddate_"+rowindex+")' > </BUTTON><SPAN id='assessenddatespan_"+rowindex+"'></SPAN> <input class=inputstyle type=hidden id='assessenddate_"+rowindex+"' name='assessenddate_"+rowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
			case 7: 
                		oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar  id=selectinformdate onclick='getDate(informdatespan_"+rowindex+" , informdate_"+rowindex+")' > </BUTTON><SPAN id='informdatespan_"+rowindex+"'></SPAN> <input class=inputstyle type=hidden id='informdate_"+rowindex+"' name='informdate_"+rowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			           
		}
	}
	rowindex = rowindex*1 +1;		
}
function isCheckedOne(){
	len = document.forms[0].elements.length;
	var flag = false;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
			if(document.forms[0].elements[i].checked==true) {
				flag = true;
				break;
			}
		}
	}
	return flag;
}
function confirmDel(){
	if(isCheckedOne()){
		if(isdel()){
			deleteRow1();
		}
	}else{
		alert("<%=SystemEnv.getHtmlLabelName(15445,user.getLanguage())%>");
	}
}
function deleteRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
					rowsum1 += 1;			
		}
	} 
	
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
			if(document.forms[0].elements[i].checked==true) {
				oTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}	
	}	
}
function doback(){
    if(<%=isplan%>==1){
       location='/hrm/career/careerplan/HrmCareerPlanEdit.jsp?id=<%=planid%>' 
    }else{
        if(<%=isplan%>==2){
            location='/hrm/career/careerplan/HrmCareerPlanEditDo.jsp?id=<%=planid%>'
        }else{
            location='/hrm/career/HrmCareerInvite.jsp'
        }
    }
}

/**
 *Author: Charoes Huang
 *compare two date string ,the date format is: yyyy-mm-dd hh:mm
 *return 0 if date1==date2
 *       1 if date1>date2
 *       -1 if date1<date2
*/
function compareDate(date1,date2){
	//format the date format to "mm-dd-yyyy hh:mm"
	var ss1 = date1.split("-",3);
	var ss2 = date2.split("-",3);

	date1 = ss1[1]+"-"+ss1[2]+"-"+ss1[0];
	date2 = ss2[1]+"-"+ss2[2]+"-"+ss2[0];

	var t1,t2;
	t1 = Date.parse(date1);
	t2 = Date.parse(date2);
	if(t1==t2) return 0;
	if(t1>t2) return 1;
	if(t1<t2) return -1;

    return 0;
}

/**
 *Added By Huang Yu On April 28,2004
 *Description : ������ڵ�������
 *              ��Ƹ����� ��ʼʱ�� >= ��Ƹ�ƻ��� ��Ƹʱ��
 *              ��Ƹ����� ��ʼʱ�� <= ����ʱ��
 *              ��Ƹ����� ǰһ���Ŀ�ʼʱ�� <=��һ���� ��ʼʱ��
 *
*/
function checkDateValidity() {


    //alert(startDate);
    var stepStartDate = new Array();
    var stepEndDate = new Array();
    var stepName = new Array();
    for(var i=3;i<oTable.rows.length;i++){
        var rowObj = oTable.rows.item(i);
        stepName[i-3] = rowObj.cells.item(1).children(0).children(0).value; //��������
        stepStartDate[i-3] = rowObj.cells.item(2).innerText;    //���迪ʼ����
        stepEndDate[i-3] = rowObj.cells.item(3).innerText;      //�����������
    }
    for(var i=0;i<stepName.length;i++){

        if(compareDate(stepStartDate[i],stepEndDate[i]) == 1) {
            alert("���� '"+stepName[i]+"' �Ŀ�ʼ���ڱ��������������֮ǰ����ڽ������ڣ�")
            return false;
            break;
        }

        //��첽��֮��Ŀ�ʼʱ���Ƿ���Ч
        for(var j=i+1;j<stepName.length;j++){
               if(compareDate(stepStartDate[i],stepStartDate[j]) == 1){
                 alert("����'"+stepName[i]+"'�Ŀ�ʼ���ڱ���С�ڻ���� ����'"+stepName[j]+"'�Ŀ�ʼ���ڣ�");
                 return false;
                 break;
               }
        }
    }


     return true;
}

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>