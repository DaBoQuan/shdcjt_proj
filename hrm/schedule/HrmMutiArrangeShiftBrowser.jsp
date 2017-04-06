<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<%
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
				 Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
				 Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;

String check_per = ","+Util.null2String(request.getParameter("shiftids"))+",";

String shiftids = "" ;
String shiftnames ="";
String strtmp = "select id,shiftname from HrmArrangeShift where ishistory = '0' ";
RecordSet.executeSql(strtmp);
while(RecordSet.next()){
	if(check_per.indexOf(","+RecordSet.getString("id")+",")!=-1){
        shiftids +="," + RecordSet.getString("id");
        shiftnames += ","+RecordSet.getString("shiftname");
	}
}

String sqlstr = "select * from HrmArrangeShift where ishistory = '0' " ;

%>

</HEAD>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
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
<FORM NAME=SearchForm STYLE="margin-bottom:0;height:100%" action="HrmMutiArrangeShiftBrowser.jsp" method=post>
<input class=inputstyle type="hidden" name="shiftids" value="">

<DIV align=right style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:document.SearchForm.btnok.click(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button" class=btn accessKey=O id=btnok onclick="btnok_onclick()" ><U>O</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:document.SearchForm.btnclear.click(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button" class=btn accessKey=2 id=btnclear onclick="btnclear_onclick()"><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
</DIV>

<TABLE ID=BrowseTable class="BroswerStyle"  cellspacing="1" STYLE="margin-top:0;width:100%;">
<TR class=DataHeader>
      <TH width=0% style="display:none"></TH>
	 <TH width=5%></TH>
     <TH width=20%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TH>
      <TH width=20%><%=SystemEnv.getHtmlLabelName(742,user.getLanguage())%></TH>
      <TH width=25%><%=SystemEnv.getHtmlLabelName(743,user.getLanguage())%></TH>
      </tr><TR class=Line><TH colspan="8" ></TH></TR>
<%
int i=0;
RecordSet.executeSql(sqlstr);
while(RecordSet.next()){
	String shiftid = Util.null2String( RecordSet.getString("id") ) ; 
	String shiftname = Util.toScreen(RecordSet.getString("shiftname"),user.getLanguage());
	String shiftbegintime = Util.null2String( RecordSet.getString("shiftbegintime") ) ; 
	String shiftendtime = Util.null2String( RecordSet.getString("shiftendtime") ) ; 
	
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
<TD style="display:none"><A HREF=#><%=shiftid%></A></TD>
<%
	 String ischecked = "";
	 if(check_per.indexOf(","+shiftid+",")!=-1){
         ischecked = " checked ";
	 }%>
	<TD><input class=inputstyle type=checkbox name="check_per" value="<%=shiftid%>" <%=ischecked%>></TD>
	<TD><%=shiftname%></TD>
	<TD><%=shiftbegintime%></TD>	
    <TD><%=shiftendtime%></TD>
</TR>
<%}
%>
</TABLE>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<script language="javascript">

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
	         p.className = "DataDark";
	      }else{
	         p.className = "DataLight";
	      }
	   }
});
$("#BrowseTable").bind("click",function(e){
	var target =  e.srcElement||e.target ;
	try{
		if(target.nodeName == "TD" || target.nodeName == "A"){
			var checkfield=$(target).parents("tr").find("input[type=checkbox]")[0];
			
			if(checkfield.checked){
				checkfield.checked=false;
			}else{
				checkfield.checked=true;
			}
		}
	}catch (en) {
		alert(en.message);
	}
});


function btnok_onclick(){
	var shiftidArray=new Array();
	var shiftNameArray=new Array();
	$("#BrowseTable tr input[type=checkbox]").each(function(){
		if(this.checked){
			curLine=$(this).parents("tr")[0];
			shiftidArray.push($(curLine.cells[0]).text());
			shiftNameArray.push($(curLine.cells[2]).text());
		}
	});
    window.parent.returnValue = {id:shiftidArray.toString(),name:shiftNameArray.toString()};
    window.parent.close();
}

function btnclear_onclick(){
    window.parent.returnValue = {id:"",name:""};
    window.parent.close();
}

function btnsub_onclick(){
    document.all("shiftids").value = shiftids
    document.SearchForm.submit();
}
</script>
</BODY>
</HTML>