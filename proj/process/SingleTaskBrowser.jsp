<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RecordSetHrm" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>

<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>

<%
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
				 Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
				 Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;


String sqlwhere="";
String ProjID = Util.null2String(request.getParameter("ProjID"));
String taskrecordid = Util.null2String(request.getParameter("taskrecordid"));

String check_per = ","+Util.null2String(request.getParameter("taskids"))+",";
String taskids ="";
String tasknames ="";

//TD3732
//modified by hubo,2006-03-14
String strtmp = "select id,subject,taskindex from Prj_TaskProcess WHERE prjid="+Util.getIntValue(ProjID)+"";
RecordSet.executeSql(strtmp);
int ownerindex = 0;
int tempindex = 0;
while(RecordSet.next()){
	tempindex++;
	if(RecordSet.getString("id").equals(taskrecordid)) ownerindex = tempindex;
	if(check_per.indexOf(","+RecordSet.getString("taskindex")+",")!=-1){
		 	
		 	taskids +="," + RecordSet.getString("taskindex");
		 	tasknames += ","+RecordSet.getString("subject");
	}
}
String temptaskids = taskids;
String temptasknames = tasknames;


int k;
String log = Util.null2String(request.getParameter("log"));
String level = Util.null2String(request.getParameter("level"));
String subject= Util.fromScreen2(request.getParameter("subject"),user.getLanguage());
String begindate01= Util.null2String(request.getParameter("begindate01"));
String begindate02= Util.null2String(request.getParameter("begindate02"));
String enddate01= Util.null2String(request.getParameter("enddate01"));
String enddate02= Util.null2String(request.getParameter("enddate02"));
String hrmid = Util.null2String(request.getParameter("hrmid"));
if(level.equals("")){
	level = "10" ;
}





RecordSet.executeProc("Prj_ProjectInfo_SelectByID",ProjID);
if(RecordSet.getCounts()<=0)
	response.sendRedirect("/base/error/DBError.jsp?type=FindData");
RecordSet.first();

sqlwhere=" where prjid = "+ProjID+" and  level_n <= 10 and isdelete<>'1' ";
if(!level.equals("")){
	sqlwhere =" where prjid = "+ProjID+" and  level_n <= "+level +"  and isdelete<>'1' ";
}
if(!subject.equals("")){
	sqlwhere+=" and subject like '%"+subject+"%' ";
}
if(!begindate01.equals("")){
	sqlwhere+=" and begindate>='"+begindate01+"'";
}
if(!begindate02.equals("")){
	sqlwhere+=" and begindate<='"+begindate02+"'";
}
if(!enddate01.equals("")){
	sqlwhere+=" and enddate>='"+enddate01+"'";
}
if(!enddate02.equals("")){
	sqlwhere+=" and enddate<='"+enddate02+"'";
}
if(!hrmid.equals("")){
	sqlwhere+=" and hrmid='"+hrmid+"'";
}

String sqlstr = "select * from Prj_TaskProcess"+sqlwhere+ "order by parentids" ;
if(!taskrecordid.equals("")){
    sqlstr = "select * from Prj_TaskProcess"+sqlwhere+" and id<>"+taskrecordid +"order by parentids";
}
char flag = 2;
String ProcPara = "";
ProcPara = ProjID + flag + "" ;
RecordSetHrm.executeProc("Prj_Member_SumProcess",ProcPara);
%>

</HEAD>

<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:btnok_onclick(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<FORM NAME=SearchForm STYLE="margin-bottom:0" action="SingleTaskBrowser.jsp" method=post>


<DIV align=left>
 <input type=hidden  name=ProjID value="<%=ProjID%>">
 <input type=hidden  name=taskrecordid value="<%=taskrecordid%>">


</DIV>

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
			<table width=100% class=viewform>
			  <tr>
				 <td width="30%"><%=SystemEnv.getHtmlLabelName(2099,user.getLanguage())%></td>
				 <td class=field>&nbsp
					<select  name=level size=1 class=inputstyle >
					 <%for(k=1;k<=10;k++){%>
						 <option value="<%=k%>" <%if(level.equals(""+k)){%>selected<%}%>><%=k%></option>
						
					 <%}%>
					 </select>	
					  <input type=hidden name=level value="<%=k%>">
				 </td>
				 <td width="24%" align=right><%=SystemEnv.getHtmlLabelName(1352,user.getLanguage())%></td>
				 <td class=field>&nbsp
					<input name=subject size=8 value="<%=Util.toScreenToEdit(request.getParameter("subject"),user.getLanguage())%>" class=inputstyle>
					 <input type=hidden name=subject value="<%=Util.toScreenToEdit(request.getParameter("subject"),user.getLanguage())%>" class=inputstyle>
				 </td>
				 <td width="18%" align=right><%=SystemEnv.getHtmlLabelName(2097,user.getLanguage())%></td>
				 <td class=field width="18%">&nbsp
					<select   name=hrmid size=1 class=inputstyle  >
						 <option value="" <%if(hrmid.equals("")){%>selected<%}%>></option>
					 <%while(RecordSetHrm.next()){%>
						 <option value="<%=RecordSetHrm.getString("hrmid")%>" <%if(RecordSetHrm.getString("hrmid").equals(""+hrmid)){%>selected<%}%>><%=ResourceComInfo.getResourcename(RecordSetHrm.getString("hrmid"))%></option>
					 <%}%>
					 </select>	 
					  <input type=hidden  name=hrmid value="<%=RecordSetHrm.getString("hrmid")%>">
				  </td>
			 </tr>
			 <tr style="height:1px;"><td colspan="6" class="Line"></td></tr>
		   <tr>  
			 <TD  width="60"><%=SystemEnv.getHtmlLabelName(1322,user.getLanguage())%></TD>
			 <TD class=Field colspan="2">&nbsp;
					  <button type="button" class=calendar id=SelectDate onclick=getDate('begindate01span','begindate01')></BUTTON>&nbsp;
					  <SPAN id=begindate01span ><%=begindate01%></SPAN>
					  <input type="hidden" name="begindate01" value="<%=begindate01%>">- &nbsp;<button type="button" class=calendar id=SelectDate onclick=getDate('begindate02span','begindate02')></BUTTON>&nbsp;
					  <SPAN id=begindate02span ><%=begindate02%></SPAN>
					  <input type="hidden" name="begindate02" value="<%=begindate02%>">
				  
			</TD>

			 <TD width="60"><%=SystemEnv.getHtmlLabelName(1323,user.getLanguage())%></TD>
			 <TD class=Field colspan="2">&nbsp;
					  <button type="button" class=calendar id=SelectDate onclick=getDate('enddate01span','enddate01')></BUTTON>&nbsp;
					  <SPAN id=enddate01span ><%=enddate01%></SPAN>
					  <input type="hidden" name="enddate01" value="<%=enddate01%>">- &nbsp;<button type="button" class=calendar id=SelectDate onclick=getDate('enddate02span','enddate02')></BUTTON>&nbsp;
					  <SPAN id=enddate02span ><%=enddate02%></SPAN>
					  <input type="hidden" name="enddate02" value="<%=enddate02%>">
				  
			</TD>
			</tr> 
	
			<!--<TR class=spacing><TD class=line colspan=6></TD></TR>
		   <tr>
			<td colspan="6" height="19"> 
			  <input type="checkbox" name="checkall0" onClick="CheckAll(checkall0.checked)" value="ON">
			  <%=SystemEnv.getHtmlLabelName(2241,user.getLanguage())%></td>
		  </tr>--> 
		</table>
		<TABLE ID=BrowseTable class="BroswerStyle"  cellspacing="1" style="width:100%">
		<TR class=DataHeader>
			  <TH width=0% style="display:none"><%=SystemEnv.getHtmlLabelName(84,user.getLanguage())%></TH>      
			 <TH width=5%></TH>  
			 <TH width=35%><%=SystemEnv.getHtmlLabelName(1332,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TH>      
			  <TH width=8%><%=SystemEnv.getHtmlLabelName(2097,user.getLanguage())%></TH>
			  <TH width=13%><%=SystemEnv.getHtmlLabelName(1322,user.getLanguage())%></TH>
			  <TH width=13%><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></TH></tr>
			  <TR class=Line style="height:1px;"><Th colspan="6" ></Th></TR> 
		<%
		int sn = 0;
		RecordSet.executeSql(sqlstr);
		while(RecordSet.next()){
			sn++;
			int i=0;
			String ids = RecordSet.getString("taskindex");
			subject = Util.toScreen(RecordSet.getString("subject"),user.getLanguage());
			hrmid = Util.toScreen(RecordSet.getString("hrmid"),user.getLanguage());
			String workday = RecordSet.getString("workday");
			String childnum =RecordSet.getString("childnum");
			String level_n =RecordSet.getString("level_n");

			if(i==0){
				i=1;
		%>
		<TR class=DataLight>
		<%
			}else{
				i=0;
		%>
		<TR class=DataDark>
		<%
		}
		%>
			<TD style="display:none"><A HREF=#><%=sn%></A></TD>
			
			 <%
			 String ischecked = "";
			 if(check_per.indexOf(","+ids+",")!=-1){
				ischecked = " checked ";
			 }%>
			<TD><input type="radio" name="check_per" value="<%=ids%>" <%=ischecked%>></TD>
				   
			<TD>
			 <%for(int j=1; j<RecordSet.getInt("level_n"); j++){%>&nbsp&nbsp&nbsp&nbsp<%}%>
			<img
			<%if(RecordSet.getInt("level_n")==10 && RecordSet.getInt("childnum")>0){%>    src="/images/project_rank2.gif"
			<%}else{%>
			src="/images/project_rank1.gif"
			<%}%>
			class="project_rank"  >
			 <%=RecordSet.getString("subject")%>
				</TD>
			<TD><%=ResourceComInfo.getResourcename(RecordSet.getString("hrmid"))%></TD>
			 <td nowrap><%if(!RecordSet.getString("begindate").equals("x")){%><%=RecordSet.getString("begindate")%><%}%></td>
			<td nowrap><%if(!RecordSet.getString("enddate").equals("-")){%><%=RecordSet.getString("enddate")%><%}%></td>
		</TR>
		<%}
		%>

		</TABLE>
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


  <input type="hidden" name="sqlwhere" value='<%=Util.null2String(request.getParameter("sqlwhere"))%>'>
  <input type="hidden" name="taskids" value="">
</FORM>


<script type="text/javascript">
var taskids = "<%=taskids%>"
var	tasknames = "<%=tasknames%>"
$("#BrowseTable").bind("mouseover",function(e){
	e=e||event;
   var target=e.srcElement||e.target;
   if("TD"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }else if("A"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }
});
$("#BrowseTable").bind("mouseout",function(e){
	var e=e||event;
   var target=e.srcElement||e.target;
   var p;
	if(target.nodeName == "TD" || target.nodeName == "A" ){
      p=jQuery(target).parents("tr")[0];
      if( p.rowIndex % 2 ==0){
         p.className = "DataDark"
      }else{
         p.className = "DataLight"
      }
   }
});

$("#BrowseTable").bind("click",function(e){
	var  e = $.event.fix(e).target;
	if(e.nodeName=="TD"||e.nodeName=="A")	{
		var obj=$(e).parents("tr").find("input[name=check_per]");
		if( obj[0].checked){
			obj[0].checked = false;
			taskids = "";
			tasknames = "";
		}else{
			obj[0].checked = true;
			taskids = $.trim($($(e).parents("tr")[0].cells[0]).text());
			tasknames = ","+$.trim($($(e).parents("tr")[0].cells[2]).text());
		}
	}else if(e.nodeName){
		var obj=$(e).parents("tr").find("input[name=check_per]");
		if( obj[0].checked){
			taskids = "";
			tasknames = "";
		}else{
			taskids = $.trim($($(e).parents("tr")[0].cells[0]).text());
			tasknames =","+ $.trim($($(e).parents("tr")[0].cells[2]).text());
		}
	}
});

function btnclear_onclick(){
	window.parent.parent.returnValue = Array("","")
	window.parent.parent.close
}

function btnok_onclick(){
	if(taskids>=<%=ownerindex%>){
		taskids = parseInt(taskids)+1;
	}
	taskids = ","+taskids;
	window.parent.parent.returnValue = {id:taskids,name:tasknames};
	window.parent.parent.close();
}

function btnsub_onclick(){
	$("input[name=taskids]").val(taskids);
	document.SearchForm.submit();
}
</script>

<script language="javascript">
function CheckAll(checked) {
//	alert(taskids);
//	taskids = "";
//	tasknames = "";
	if(checked == true){
		len = document.SearchForm.elements.length;
		var i=0;
		for( i=0; i<len; i++) {	
			if (document.SearchForm.elements[i].name=='check_per') {
				if(!document.SearchForm.elements[i].checked) {
					if(taskids.indexOf(document.SearchForm.elements[i].parentElement.parentElement.cells(0).innerText) < 0){
						taskids = taskids + "," + document.SearchForm.elements[i].parentElement.parentElement.cells(0).innerText;
			   		tasknames = tasknames + "," + document.SearchForm.elements[i].parentElement.parentElement.cells(2).innerText;
			   	}
			  }
			   	document.SearchForm.elements[i].checked=(checked==true?true:false);			
			}
	 	} 
	}else{
		taskids = "";
		tasknames = "";
		len = document.SearchForm.elements.length;
		var i=0;
		for( i=0; i<len; i++) {	
			if (document.SearchForm.elements[i].name=='check_per') {
			 document.SearchForm.elements[i].checked=false;		
			}	
		}
	}
 //	alert(taskids);
}
function CheckItOut(checked,value) {
	//alert(taskids);
	//alert(tasknames);
	len = document.SearchForm.elements.length;
	if(checked!=true){
		if(taskids.indexOf(value) > 0){
			taskids = taskids.replace(","+value, "");
			for( var i=0; i<len; i++) {
				if (document.SearchForm.elements[i].name=='check_per') {
					if(document.SearchForm.elements[i].parentElement.parentElement.cells(0).innerText == value){
						tasknames = tasknames.replace(","+document.SearchForm.elements[i].parentElement.parentElement.cells(2).innerText, "");
					}
				}
			}
		}
	}
	//alert(taskids);
	//alert(tasknames);
}
</script>

<script language="javascript">
function submitData()
{
	if (check_form(SearchForm,''))
		SearchForm.submit();
}

function submitClear()
{
	btnclear_onclick();
}

function reset(){
	document.all("begindate01span").innerHTML = "";
	document.all("begindate02span").innerHTML = "";
	document.all("enddate01span").innerHTML = "";
	document.all("enddate02span").innerHTML = "";
	SearchForm.reset();
	taskids = "<%=temptaskids%>";
	tasknames = "<%=temptasknames%>";
}


</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>