<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetX" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%
String sqlwhere1 = Util.null2String(request.getParameter("sqlwhere"));
String fullname = Util.null2String(request.getParameter("fullname"));
String description = Util.null2String(request.getParameter("description"));
int parentid = Util.getIntValue(request.getParameter("parentid"),0);
int parentParentid = 0;
String sql = "select parentid from CRM_SectorInfo where id="+parentid;
RecordSet.executeSql(sql);
while(RecordSet.next()){
	parentParentid = RecordSet.getInt("parentid");
}

String listname = Util.null2String(request.getParameter("listname"));
String sqlwhere = " ";
int ishead = 0;
if(!sqlwhere1.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += sqlwhere1;
	}
}
if(ishead==0){
	ishead=1;
	sqlwhere += " where parentid=";
	sqlwhere += parentid;
}
else{
	sqlwhere += " and parentid=";
	sqlwhere += parentid;
}
if(!fullname.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where fullname like '%";
		sqlwhere += Util.fromScreen2(fullname,user.getLanguage());
		sqlwhere += "%'";
	}
	else{
		sqlwhere += " and fullname like '%";
		sqlwhere += Util.fromScreen2(fullname,user.getLanguage());
		sqlwhere += "%'";
	}
}
if(!description.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where description like '%";
		sqlwhere += Util.fromScreen2(description,user.getLanguage());
		sqlwhere += "%'";
	}
	else{
		sqlwhere += " and description like '%";
		sqlwhere += Util.fromScreen2(description,user.getLanguage());
		sqlwhere += "%'";
	}
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
<FORM NAME=SearchForm STYLE="margin-bottom:0" action="SectorInfoBrowser.jsp" method=post>
<input type=hidden name=sqlwhere value="<%=sqlwhere1%>">
<input type=hidden name=parentid>
<input type=hidden name=listname value="<%=listname%>">
<DIV align=right style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.SearchForm.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button"class=btnSearch accessKey=S type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button"class=btnReset accessKey=T type=reset><U>T</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button"class=btn accessKey=1 onclick="window.parent.close()"><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:document.SearchForm.btnclear.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<button type="button"class=btn accessKey=2 id=btnclear onclick="btnclear_onclick();"><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
<%
if(parentid!=0){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/CRM/Maint/SectorInfoBrowser.jsp?parentid="+parentParentid+",_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
</DIV>
<table width=100% class=ViewForm>
<TR class=Spacing><TD class=Line1 colspan=4></TD></TR>
<TR>
<TD width=15%><%=SystemEnv.getHtmlLabelName(399,user.getLanguage())%></TD>
<TD width=35% class=field><input class=InputStyle  name=fullname value="<%=fullname%>"></TD>
<TD width=15%><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TD>
<TD width=35% class=field><input class=InputStyle  name=description value="<%=description%>"></TD>
</TR><tr style="height:1px;"><td class=Line colspan=4></td></tr>
<TR class=Spacing><TD class=Line1 colspan=4></TD></TR>
</table>
<TABLE ID=BrowseTable class=BroswerStyle cellspacing=1  width="100%">
<TR class=DataHeader>
<TH width=25%><%=SystemEnv.getHtmlLabelName(84,user.getLanguage())%></TH>
<TH width=25%><%=SystemEnv.getHtmlLabelName(399,user.getLanguage())%></TH>
<TH width=25%><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></TH>
<TH width=25%><%=SystemEnv.getHtmlLabelName(605,user.getLanguage())%></TH>
</tr><TR class=Line style="height:1px;"><TH colSpan=4></TH></TR>
<%
int i=0;
sqlwhere = "select * from CRM_SectorInfo "+sqlwhere+" order by id asc";
RecordSet.execute(sqlwhere);
while(RecordSet.next()){
	boolean result = false;//�����жϴ�ʱ�Ƿ�������ҵ
	String sql2 = "select id from CRM_SectorInfo where parentid="+RecordSet.getInt(1);
	RecordSetX.execute(sql2);
	while(RecordSetX.next()){
		result = true;
	}
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
	<TD><A HREF=#><%=RecordSet.getString(1)%></A></TD>
	<TD><%=RecordSet.getString(2)%></TD>
	<TD><%=RecordSet.getString(3)%></TD>
	<Td><%if(result){%><div onclick="onview('<%=RecordSet.getString(1)%>','<%=RecordSet.getString(2)%>');"><%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%></div><%}%></Td>
	
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
</BODY></HTML>
<script language=javascript>
function onview(objval1,objval2){
	SearchForm.listname.value=SearchForm.listname.value + objval2 + "->";
	SearchForm.parentid.value=objval1;
	SearchForm.submit();
}
</script>

<script type="text/javascript">
<!--


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
    window.parent.parent.returnValue = {id:jQuery(jQuery(target).parents("tr")[0].cells[0]).text(),name:jQuery(jQuery(target).parents("tr")[0].cells[1]).text()};
	 window.parent.parent.close();
	}
}


jQuery(document).ready(function(){
	jQuery("#BrowseTable").bind("mouseover",BrowseTable_onmouseover);
	jQuery("#BrowseTable").bind("mouseout",BrowseTable_onmouseout);
	jQuery("#BrowseTable").bind("click",BrowseTable_onclick);
	
})


function btnclear_onclick(){
    window.parent.returnValue = {id:"",name:""};
    window.parent.close();
}
//-->
</script>