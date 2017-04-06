<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%
String pieceRateNotmp = Util.null2String(request.getParameter("pieceRateNo"));
String pieceRateNametmp = Util.null2String(request.getParameter("pieceRateName"));
String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));

String sql = " (pieceRateNo is not null and pieceRateNo <> ' ')" +sqlwhere;
if(!"".equals(pieceRateNotmp)) {
    sql += " and pieceRateNo like '%"+pieceRateNotmp+"%'";
}
if(!"".equals(pieceRateNametmp)) {
    sql += " and pieceRateName like '%"+pieceRateNametmp+"%'";
}
%>
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
<FORM NAME=SearchForm STYLE="margin-bottom:0" action="PieceRateNoBrowser.jsp" method=post>
<input type=hidden name=sqlwhere value="<%=sqlwhere%>">
<DIV align=right style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:SearchForm.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btn accessKey=1 onclick="window.parent.close()"><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:SearchForm.btnclear.click(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<BUTTON class=btn accessKey=2 id=btnclear><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
</DIV>
<table width=100% class=ViewForm>
	<tr>
     <td width=15%><%=SystemEnv.getHtmlLabelName(19383,user.getLanguage())%></td>
	 <td width=35% class=field><input type='text' class=inputstyle id='workcode' name='pieceRateNo' value="<%=pieceRateNotmp%>"></td>
	 <td width=15%><%=SystemEnv.getHtmlLabelName(19384,user.getLanguage())%></td>
	 <td width=35% class=field><input type='text' class=inputstyle id='pieceRateName' name='pieceRateName' value="<%=pieceRateNametmp%>"></td></td>
  </tr>
</table>
<TABLE ID=BrowseTable class="BroswerStyle"  cellspacing="1" STYLE="margin-top:0;width:100%;">
<TR class=DataHeader>
<TH width=0% style="display:none"></TH>
<TH width=50%><%=SystemEnv.getHtmlLabelName(19383,user.getLanguage())%></TH>
<TH width=50%><%=SystemEnv.getHtmlLabelName(19384,user.getLanguage())%></TH>
 </tr><TR class=Line><TH colspan="3" ></TH></TR>
<%
int i=0;
sql = " select * from HRM_PieceRateSetting where "+sql;
rs.execute(sql);
while(rs.next()) {
    String pieceRateNo = Util.toScreen(rs.getString("PieceRateNo"),user.getLanguage()) ;
    String pieceRateName = Util.toScreen(rs.getString("PieceRateName"),user.getLanguage()) ;

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
	<TD width=0% style="display:none"><A HREF=#><%=pieceRateNo%></A></TD>
	<TD><%=pieceRateNo%></TD>
    <TD><%=pieceRateName%></TD
</TR>
<%}%>
</TABLE></FORM>
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
</BODY>
</HTML>

<script	language="javascript">
function replaceToHtml(str){
	var re = str;
	var re1 = "<";
	var re2 = ">";
	do{
		re = re.replace(re1,"&lt;");
		re = re.replace(re2,"&gt;");
        re = re.replace(",","��");
	}while(re.indexOf("<")!=-1 || re.indexOf(">")!=-1);
	return re;
}

function BrowseTable_onmouseover(e){
	e=e||event;
   var target=e.srcElement||e.target;
   if("TD"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }else if("A"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }
}
function BrowseTable_onmouseout(e){
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
}

function BrowseTable_onclick(e){
	var e=e||event;
	var target=e.srcElement||e.target;
	if( target.nodeName =="TD"||target.nodeName =="A"  ){
		var curTr=jQuery(target).parents("tr")[0];
		window.parent.parent.returnValue = {id:jQuery(curTr.cells[0]).text(),name:replaceToHtml(jQuery(curTr.cells[1]).text())};
		window.parent.parent.close();
	}
}

function btnclear_onclick(){
	window.parent.parent.returnValue = {id:"",name:""};
	window.parent.parent.close();
}

$(function(){
	$("#BrowseTable").mouseover(BrowseTable_onmouseover);
	$("#BrowseTable").mouseout(BrowseTable_onmouseout);
	$("#BrowseTable").click(BrowseTable_onclick);
	$("#btnclear").click(btnclear_onclick);
});
</script>