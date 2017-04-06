<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*,weaver.general.GCONST" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="UrlComInfo" class="weaver.workflow.field.UrlComInfo" scope="page" />
<jsp:useBean id="bb" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="GetShowCondition" class="weaver.formmode.interfaces.GetShowCondition" scope="page" />
<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<link rel="stylesheet" type="text/css" href="/css/xpSpin.css">
<SCRIPT type="text/javascript" src="/js/jquery/plugins/spin/jquery.spin.js"></script>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</HEAD>
<%
int conid = Util.getIntValue(request.getParameter("id"),0);
String isbill = Util.null2String(request.getParameter("isbill"));
String haspost = Util.null2String(request.getParameter("haspost"));
String isclear = Util.null2String(request.getParameter("isclear"));
int formid = Util.getIntValue(request.getParameter("formid"),0);
int fromBillManagement = Util.getIntValue(request.getParameter("fromBillManagement"),1);
int fromself = Util.getIntValue(request.getParameter("fromself"),0);
int linkid = Util.getIntValue(request.getParameter("id"),0);
String[] checkcons = request.getParameterValues("check_con");
conid = linkid;//��ֵ
ArrayList ids = new ArrayList();
ArrayList colnames = new ArrayList();
ArrayList opts = new ArrayList();
ArrayList values = new ArrayList();
ArrayList names = new ArrayList();
ArrayList opt1s = new ArrayList();
ArrayList value1s = new ArrayList();
ArrayList seclevel_opts = new ArrayList();
ArrayList seclevel_values = new ArrayList();
ArrayList seclevel_opt1s = new ArrayList();
ArrayList seclevel_value1s = new ArrayList();
ids.clear();
colnames.clear();
opt1s.clear();
names.clear();
value1s.clear();
opts.clear();
values.clear();
seclevel_opts.clear();
seclevel_values.clear();
seclevel_opt1s.clear();
seclevel_value1s.clear();
String sqlwherePara = Util.null2String(request.getParameter("sqlwhere"));
String sqlwherecnPara = Util.null2String(request.getParameter("sqlwherecn"));
String sqlwhere ="";
String sqlwherecn="";
GetShowCondition.setSqlWhere(request,user);
sqlwhere = GetShowCondition.getsqlwhere();
sqlwherecn = GetShowCondition.getsqlwherecn();
ids = GetShowCondition.getids();
colnames = GetShowCondition.getcolnames();
opts = GetShowCondition.getopts();
values = GetShowCondition.getvalues();
names = GetShowCondition.getnames();
opt1s = GetShowCondition.getopt1s();
value1s = GetShowCondition.getvalue1s();
seclevel_opts = GetShowCondition.getseclevel_opts();
seclevel_values = GetShowCondition.getseclevel_values();
seclevel_opt1s = GetShowCondition.getseclevel_opt1s();
seclevel_value1s = GetShowCondition.getseclevel_value1s();

if(Util.null2String(request.getParameter("comefrom")).equals("1")){
	if(!sqlwhere.equals("")){
		sqlwhere = sqlwhere.substring(3);
	}
	if(!sqlwherecn.equals("")){
		sqlwherecn = sqlwherecn.substring(3);
	}
}else{
	if(fromBillManagement==1){
		//�����ֶκ��µĶ�ȡ��ʽ��ʼ
		String strSql = "select showcondition, showconditioncn from mode_pageexpand where id="+linkid;
		weaver.conn.ConnStatement statement=new weaver.conn.ConnStatement();
		statement.setStatementSql(strSql, false);
		statement.executeQuery();
		if(statement.next()){
			if(rs.getDBType().equals("oracle")){
				oracle.sql.CLOB theclob = statement.getClob("showcondition"); 
				
				if(null!=theclob)
				{
			  		String readline = "";
			        StringBuffer clobStrBuff = new StringBuffer("");
			        java.io.BufferedReader clobin = new java.io.BufferedReader(theclob.getCharacterStream());
			        while ((readline = clobin.readLine()) != null) clobStrBuff = clobStrBuff.append(readline);
			        clobin.close() ;
			        sqlwhere = clobStrBuff.toString();
		        }
		        oracle.sql.CLOB theclob2 = statement.getClob("showconditioncn"); 
		        if(null!=theclob2)
				{
			  		String readline2 = "";
			        StringBuffer clobStrBuff2 = new StringBuffer("");
			        java.io.BufferedReader clobin2 = new java.io.BufferedReader(theclob2.getCharacterStream());
			        while ((readline2 = clobin2.readLine()) != null) clobStrBuff2 = clobStrBuff2.append(readline2);
			        clobin2.close() ;
			        sqlwherecn = clobStrBuff2.toString();
		        }
			}else{
				sqlwhere=statement.getString("showcondition");
				sqlwherecn=statement.getString("showconditioncn");
			}
		}
		//�����ֶκ��µĶ�ȡ��ʽ����
	}else{
		sqlwhere = Util.null2String((String)request.getSession(true).getAttribute("por"+conid+"_con"));
		sqlwherecn = Util.null2String((String)request.getSession(true).getAttribute("por"+conid+"_con_cn"));
	}
}

String operatortype = Util.null2String(request.getParameter("operatortype"));
if(!sqlwhere.equals("")){
    if(!sqlwherePara.equals("")){
        if(operatortype.equals("and")){
            sqlwhere = "("+sqlwherePara+") and ("+sqlwhere+")";
            sqlwherecn = "("+sqlwherecnPara+") "+SystemEnv.getHtmlLabelName(18760,user.getLanguage())+" ("+sqlwherecn+")";
        }else{
            sqlwhere = "(("+sqlwherePara+") or ("+sqlwhere+"))";
            sqlwherecn = "(("+sqlwherecnPara+") "+SystemEnv.getHtmlLabelName(21695,user.getLanguage())+" ("+sqlwherecn+"))";
        }
    }
}else{
    sqlwhere = sqlwherePara;
    sqlwherecn = sqlwherecnPara;
}

if(haspost.equals("1")){
	request.getSession(true).setAttribute("por"+conid+"_con",sqlwhere);
	request.getSession(true).setAttribute("por"+conid+"_con_cn",sqlwherecn);
    boolean isOracle = rs.getDBType().equals("oracle");
	if(fromBillManagement==1||fromself==1){
		String savenode = "update mode_pageexpand set showcondition=?,showconditioncn=? where id=?";
		if(isOracle){
		    savenode = "update mode_pageexpand set showcondition=empty_clob(),showconditioncn=empty_clob() where id=?";
		}
		ConnStatement statement = new ConnStatement();
		try{
			if(!isOracle){
				statement.setStatementSql(savenode);
			  	statement.setString(1 , sqlwhere);
			  	statement.setString(2 , sqlwherecn);
			  	statement.setInt(3 , linkid);
			}else{
			  	statement.setStatementSql(savenode);
			  	statement.setInt(1 , linkid);
			}
			statement.executeUpdate();
			if(isOracle){
				String sql = "select showcondition,showconditioncn from mode_pageexpand where id = " +linkid;
                statement.setStatementSql(sql, false);
                statement.executeQuery();
                if(statement.next())
                {
	                oracle.sql.CLOB theclob = statement.getClob(1);
	                oracle.sql.CLOB theclob2 = statement.getClob(2);
					if(null!=theclob)
					{
		                char[] contentchar = sqlwhere.toCharArray();
		                java.io.Writer contentwrite = theclob.getCharacterOutputStream();
		                contentwrite.write(contentchar);
		                contentwrite.flush();
		                contentwrite.close();
	                }
	                if(null!=theclob2)
					{
		                char[] contentchar2 = sqlwherecn.toCharArray();
		                java.io.Writer contentwrite2 = theclob2.getCharacterOutputStream();
		                contentwrite2.write(contentchar2);
		                contentwrite2.flush();
		                contentwrite2.close();
	                }
                }
			}
		}catch(Exception e) {
			throw e ;
		}
		finally {
			try {
				statement.close();
			}catch(Exception ex) {}
		}
	}
}

if(isclear.equals("1")){
	request.getSession(true).setAttribute("por"+conid+"_con","");
	request.getSession(true).setAttribute("por"+conid+"_con_cn","");
	if(fromBillManagement==1){
		String sql = "update mode_pageexpand  set showcondition ='', showconditioncn ='' where id="+linkid;
		if(rs.getDBType().equals("oracle")){
            sql = "update mode_pageexpand set showcondition=empty_clob() , showconditioncn=empty_clob() where id="+linkid;
		}
		rs.executeSql(sql);
	}
}
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(24541,user.getLanguage())+",javascript:submitData1(this),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(24542,user.getLanguage())+",javascript:submitData2(this),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(309,user.getLanguage())+",javascript:close(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(15504,user.getLanguage())+",javascript:submitClear(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM NAME=SearchForm STYLE="margin-bottom:0" action="showcondition.jsp" method="post">
<input type="hidden" value="0" name="fromself">
<input type="hidden" value="<%=conid%>" name="id">
<input type="hidden" value="<%=formid%>" name="formid">
<input type=hidden name=isbill value="<%=isbill%>">
<input type=hidden name=haspost value="1">
<input type=hidden name=isclear value="">
<input type=hidden name=comefrom value="1">
<input type=hidden name=fromBillManagement value="<%=fromBillManagement%>">
<input type=hidden name=linkid value="<%=linkid%>">
<input type=hidden name=sqlwhere value="<%=sqlwhere%>">
<input type=hidden name=sqlwherecn value="<%=sqlwherecn%>">
<input type=hidden name=operatortype value="and">

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
</colgroup>
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<table width=100% class="viewform">
<COLGROUP>
   <COL width="4%">
   <COL width="20%">
   <COL width="20%">
   <COL width="18%">
   <COL width="20%">
   <COL width="18%">
</COLGROUP>

<TR class="title">
	<TH colSpan=6><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(68,user.getLanguage())%></TH>
</TR>
<TR class="Spacing" style="height:1px;"><TD class="Line1" colspan=6></TD></TR>
<TR class=header>
<td></td>
<td><%=SystemEnv.getHtmlLabelName(261,user.getLanguage())%></td>
<td colspan=4><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%></td>
</tr>
<tr  style="height:1px;">
<TD class="Line1" colspan=6></TD></TR>
<input type='checkbox' name='check_con' style="display:none">

<%
int linecolor=0;
String sql="";
if(isbill.equals("0")){
	sql = "select workflow_formfield.fieldid as id,fieldname as name,workflow_fieldlable.fieldlable as label,workflow_formdict.fieldhtmltype as htmltype,workflow_formdict.type as type,workflow_formdict.fielddbtype as dbtype from workflow_formfield,workflow_formdict,workflow_fieldlable where workflow_fieldlable.formid = workflow_formfield.formid and workflow_fieldlable.isdefault = '1' and workflow_formdict.fieldhtmltype!=6 and workflow_fieldlable.fieldid =workflow_formfield.fieldid and workflow_formdict.id = workflow_formfield.fieldid and (workflow_formfield.isdetail<>'1' or workflow_formfield.isdetail is null) and workflow_formfield.formid="+formid+" order by workflow_formfield.isdetail,workflow_formfield.groupid,workflow_formfield.fieldorder";
}else if(isbill.equals("1")){
	sql = "select id as id,fieldname as name,fieldlabel as label,fieldhtmltype as htmltype,type as type, fielddbtype as dbtype from workflow_billfield where (viewtype is null or viewtype!=1) and billid = "+formid + " and fieldhtmltype!=6 order by viewtype,detailtable,dsporder ";
}
RecordSet.executeSql(sql);
int tmpcount = 0;
while(RecordSet.next()){
String id = RecordSet.getString("id");
String htmltype = RecordSet.getString("htmltype");
String type = RecordSet.getString("type");
String dbtype = RecordSet.getString("dbtype");
if(htmltype.equals("3")&&(UrlComInfo.getUrlbrowserurl(type).equals("")||type.equals("141"))) continue;
if(htmltype.equals("7")||(htmltype.equals("2")&&type.equals("2"))) continue;
tmpcount += 1;
%>
<tr class="Header">
<td><input type='checkbox' name='check_con'  value="<%=id%>" <%if(ids.indexOf(""+id)!=-1){%> checked <%}%>></td>
<td> <input type=hidden name="con<%=id%>_id" value="<%=id%>">
<%
String name = RecordSet.getString("name");
String label = RecordSet.getString("label");
if(isbill.equals("1"))
	label = SystemEnv.getHtmlLabelName(Util.getIntValue(label),user.getLanguage());
%>
<%=Util.toScreen(label,user.getLanguage())%>
<input type=hidden name="con<%=id%>_colname" value="<%=name%>">
<input type=hidden name="con<%=id%>_colname_cn" value="<%=label%>">
</td>
<input type=hidden name="con<%=id%>_htmltype" value="<%=htmltype%>">
<input type=hidden name="con<%=id%>_type" value="<%=type%>">
<%
if((htmltype.equals("1")&& type.equals("1"))||htmltype.equals("2")){
%>
<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >

<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<input type=text class=InputStyle size=12 name="con<%=id%>_value"  onfocus="changelevel('<%=tmpcount%>')"  <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
</td>
<%}
else if(htmltype.equals("1")&& !type.equals("1")){
%>
<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
</td>
<td >
<input type=text class=InputStyle size=12 name="con<%=id%>_value"  onfocus="changelevel('<%=tmpcount%>')" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
</td>
<td>
<select class=inputstyle  name="con<%=id%>_opt1" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
</td>
<td>
<input type=text class=InputStyle size=12 name="con<%=id%>_value1"  onfocus="changelevel('<%=tmpcount%>')"  <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)value1s.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
</td>
<%
}
else if(htmltype.equals("4")){
%>
<td colspan=4>
<input type=checkbox value="1" name="con<%=id%>_value"  onfocus="changelevel('<%=tmpcount%>')" <%if((ids.indexOf(""+id)!=-1)&&((String)values.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> checked <%}%>>
</td>
<%}
else if(htmltype.equals("5")){
%>

<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
</td><td colspan=3>
<select class=inputstyle  name="con<%=id%>_value"  style="width:100%;"  onfocus="changelevel('<%=tmpcount%>')" onchange="setSelectTitle(this);">
<option></option>
<%
char flag=2;
rs.executeProc("workflow_SelectItemSelectByid",""+id+flag+isbill);
while(rs.next()){
	int tmpselectvalue = rs.getInt("selectvalue");
	String tmpselectname = rs.getString("selectname");
%>
<option value="<%=tmpselectvalue%>" title="<%=Util.toScreen(tmpselectname,user.getLanguage())%>" <%if((ids.indexOf(""+id)!=-1)&&((String)values.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals(""+tmpselectvalue)){%> selected <%}%>><%=Util.toScreen(tmpselectname,user.getLanguage())%></option>
<%}%>
</select>
</td>
<%} else if(htmltype.equals("3") && !type.equals("152") && !type.equals("37") && !type.equals("9") && !type.equals("135") && !type.equals("8") && !type.equals("16") && !type.equals("169") && !type.equals("7") && !type.equals("1")&& !type.equals("2")&& !type.equals("18")&& !type.equals("19")&& !type.equals("17")&& !type.equals("24")&&!type.equals("160")&& !type.equals("4")&& !type.equals("57") && !type.equals("164")&&!type.equals("166")&&!type.equals("168")&&!type.equals("170")&&!type.equals("142")&&!type.equals("165")&&!type.equals("169")&&!type.equals("65")&&!type.equals("146")&&!type.equals("167")&&!type.equals("117")){
%>
<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<!-- TD15999 -->
<%if(type.equals("162")) {%>
	<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
	<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
<%} else {%>
	<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(353,user.getLanguage())%></option>
	<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(21473,user.getLanguage())%></option>
<%}%>
</select>
</td>
<td colspan=3>
<%if(type.equals("161")) {%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser2('<%=id%>','<%=type%>','<%=UrlComInfo.getUrlbrowserurl("162")%>?type=<%=dbtype%>')"></button>
<%} else if(type.equals("162")) {%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser2('<%=id%>','<%=type%>','<%=UrlComInfo.getUrlbrowserurl("161")%>?type=<%=dbtype%>')"></button>
<%} else {%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl(type)%>')"></button>
<%}%>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && ( type.equals("9") || type.equals("8") || type.equals("16") || type.equals("7") || type.equals("1") || type.equals("165") || type.equals("169") || type.equals("4") || type.equals("164")|| type.equals("146")|| type.equals("167") )){//�����ţ����ֲ�
//System.out.println("htmltype = " + htmltype + " type = " + type + " name = " + name);
%>
<td colspan=4>
<select class=inputstyle  name="con<%=id%>_opt" style="width:26%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(353,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(21473,user.getLanguage())%></option>
</select>
<%
if(type.equals("4")||type.equals("167")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("57")%>')"></button>
<%
	//System.out.println(UrlComInfo.getUrlbrowserurl("57"));
}else if(type.equals("164")||type.equals("169")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/hrm/company/MutiSubcompanyBrowser.jsp')"></button>
<%
}else if(type.equals("1")||type.equals("165")||type.equals("146")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("17")%>')"></button>
<%
}else if(type.equals("7")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("18")%>')"></button>
<%
}else if(type.equals("16")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("152")%>')"></button>
<%
}else if(type.equals("8")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("135")%>')"></button>
<%
}else if(type.equals("9")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("37")%>')"></button>
<%
}else if(type.equals("117")){
%>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("41")%>')"></button>
<%
}
%>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
<%if(type.equals("1")){%>
<br>
<select class=inputstyle  name="seclevel_con<%=id%>_opt" style="width:26%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
<input type=text class=InputStyle size=12 name="seclevel_con<%=id%>_value"  onfocus="changelevel('<%=tmpcount%>')" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)seclevel_values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<select class=inputstyle  name="seclevel_con<%=id%>_opt1" style="width:26%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)seclevel_opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
<input type=text class=InputStyle size=12 name="seclevel_con<%=id%>_value1"  onfocus="changelevel('<%=tmpcount%>')"  <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)seclevel_value1s.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<%}%>
</td>
<%
}else if(htmltype.equals("3") && (type.equals("57")||type.equals("168"))){//�ಿ��
%>
<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("4")%>')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>

<%
}else if(htmltype.equals("3") && (type.equals("142"))){//���շ��Ĳ���
	%>
	<td>
	<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
	<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
	<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
	</select>
	</td>
	<td colspan=3>
	<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/DocReceiveUnitBrowserSingle.jsp')"></button>
	<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
	<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
	<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
	</td>

	<%
	}else if(htmltype.equals("3") && type.equals("24")){//ְλ�İ�ȫ����
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(353,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(21473,user.getLanguage())%></option>
</select>
</td>
<td>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/hrm/jobtitles/MutiJobTitlesBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>

<%}//ְλ��ȫ����end

else if(htmltype.equals("3") &&( type.equals("2") || type.equals("19"))){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
</td>
<td>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')"  
<%if(type.equals("2")){%>
 onclick="onSearchWFDate(con<%=id%>_valuespan,con<%=id%>_value)"
<%}else{%>
 onclick ="onSearchWFTime(con<%=id%>_valuespan,con<%=id%>_value)"
<%}%>
 ></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<td >
<select class=inputstyle  name="con<%=id%>_opt1" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15508,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></option>
<option value="3" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15509,user.getLanguage())%></option>
<option value="4" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("4")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></option>
<option value="5" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("5")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(327,user.getLanguage())%></option>
<option value="6" <%if((ids.indexOf(""+id)!=-1)&&((String)opt1s.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("6")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15506,user.getLanguage())%></option>
</select>
</td>
<td >
<button type="button" type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')"  
<%if(type.equals("2")){%>
 onclick="onSearchWFDate(con<%=id%>_value1span,con<%=id%>_value1)"
<%}else{%>
 onclick ="onSearchWFTime(con<%=id%>_value1span,con<%=id%>_value1)"
<%}%>
 ></button>
<input type=hidden name="con<%=id%>_value1" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)value1s.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_value1span" id="con<%=id%>_value1span"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)value1s.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("17")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("18")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("135")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("8")%>')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("37")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("9")%>')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("152")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','<%=UrlComInfo.getUrlbrowserurl("16")%>')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%} else if(htmltype.equals("3") && type.equals("65")){
%>
<td>
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/hrm/roles/HrmRolesBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%}
else if(htmltype.equals("3") && (type.equals("160")||type.equals("166"))){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%}
else if(htmltype.equals("3") && type.equals("170")){
%>
<td >
<select class=inputstyle  name="con<%=id%>_opt" style="width:100%" onfocus="changelevel('<%=tmpcount%>')" >
<option value="1" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(346,user.getLanguage())%></option>
<option value="2" <%if((ids.indexOf(""+id)!=-1)&&((String)opts.get(Util.getIntValue(""+ids.indexOf(""+id)))).equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(15507,user.getLanguage())%></option>
</select>
</td>
<td colspan=3>
<button type="button" class=Browser  onfocus="changelevel('<%=tmpcount%>')" onclick="onShowBrowser('<%=id%>','/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp')"></button>
<input type=hidden name="con<%=id%>_value" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)values.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<input type=hidden name="con<%=id%>_name" <%if(ids.indexOf(""+id)!=-1){%> value="<%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%>"<%}%>>
<span name="con<%=id%>_valuespan" id="con<%=id%>_valuespan"> <%if(ids.indexOf(""+id)!=-1){%><%=((String)names.get(Util.getIntValue(""+ids.indexOf(""+id))))%><%}%></span>
</td>
<%}%>
</tr>
<TR style="height:1px;"><TD class=Line colSpan=6></TD></TR>
<%
 if(linecolor==0) linecolor=1;
          else linecolor=0;}%>
          <TR class="Title">
    	  <TH colSpan=6><%=SystemEnv.getHtmlLabelName(15364,user.getLanguage())%></TH></TR>
<TR class="Spacing"  style="height:1px;"><TD class="Line1" colspan=6></TD></TR>
<tr class=header>
<td   colspan=6>
<%=sqlwherecn%>
</td>
</table>
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

</FORM></BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>
<script language="javaScript">
function doReturnSpanHtml(obj){
	var t_x = obj.substring(0, 1);
	if(t_x == ','){
		t_x = obj.substring(1, obj.length);
	}else{
		t_x = obj;
	}
	return t_x;
}

function btnok_onclick(){
	 $G("haspost").value = "1";
	 document.SearchForm.submit();
}

function btnclear_onclick(){
	 $G("isclear").value = "1";
	 document.SearchForm.submit();
}

function onShowBrowser(id,url){
	url= url+"?selectedids="+$("input[name=con"+id+"_value]").val()
	datas = window.showModalDialog(url);
	if(datas){
	     if(datas.id!=""){
	    	 spanNameHtml=doReturnSpanHtml(datas.name);
			$("#con"+id+"_valuespan").html(spanNameHtml);
			$("input[name=con"+id+"_value]").val(datas.id);
			$("input[name=con"+id+"_name]").val(spanNameHtml);
	    }else{
	    	$("#con"+id+"_valuespan").html("");
			$("input[name=con"+id+"_value]").val("");
			$("input[name=con"+id+"_name]").val("");
		}
	}
}

function changelevel(tmpindex){
	document.SearchForm.check_con[tmpindex*1].checked = true;
}

function submitData1(obj)
{
    SearchForm.operatortype.value="and";
	SearchForm.fromself.value="1";
    obj.disabled = true;
	btnok_onclick();
}
function submitData2(obj)
{
    SearchForm.operatortype.value="or";
	SearchForm.fromself.value="1";
    obj.disabled = true;
	btnok_onclick();
}

function submitClear()
{
	btnclear_onclick();
}

function setSelectTitle(obj)
{
	var options = obj.options;
	for(var i = 0;i<options.length;i++)
	{
		var option = options[i];
		if(option.selected)
		{
			obj.title=option.title;
		}
	}
}

function close(){
    <%if(sqlwhere.equals("")){%>
		window.parent.parent.returnValue = "";
	<%}else{%>
		//window.parent.parent.returnValue = "<%=sqlwhere+";"+sqlwherecn%>";
		window.parent.parent.returnValue = "<%=sqlwherecn%>";
	<%}%>
	window.parent.parent.close();
}

if ("<%=haspost%>" == "1"){
    <%if(sqlwhere.equals("")){%>
   		window.parent.parent.returnValue = "";
    <%}else{%>
    	//window.parent.parent.returnValue = "<%=sqlwhere+";"+sqlwherecn%>";
		window.parent.parent.returnValue = "<%=sqlwherecn%>";
	<%}%>
	window.parent.parent.close();
}
if ("<%=isclear%>" == "1"){
	window.parent.returnValue = "";
	window.parent.parent.close();
}

jQuery(document).ready(function(){
   jQuery(".spin").each(function(){
      var $this=jQuery(this);
      var min=$this.attr("min");
      var max=$this.attr("max");
      $this.spin({max:max,min:min});
      $this.blur(function(){
          var value=$this.val();
          if(isNaN(value))
            $this.val(59);
          else{
            value =parseInt(value); 
            if(value>59)
               $this.val(59);
            else if(value<0)
               $this.val(0);
            else
               $this.val(value); 
               
           if($this.val()=='NaN')
               $this.val(0);          
          }  
      });
   });
});

function onShowBrowser2(id,type1,url){
	id1 = window.showModalDialog(url);
	if(id1){
		if(wuiUtil.getJsonValueByIndex(id1,0)!= ""){
       		ids = doReturnSpanHtml(wuiUtil.getJsonValueByIndex(id1,0));
       		names =wuiUtil.getJsonValueByIndex(id1,1);
       		//descs =wuiUtil.getJsonValueByIndex(id1,2);
	   		if(type1 == 161){
		   		if(names.indexOf(",")==0){
	     			names=names.substr(1);
		   		}
				$G("con"+id+"_valuespan").innerHTML = "<a title='"+ids+"'>"+names+"</a>&nbsp;";
				$G("con"+id+"_value").value=ids;
				$G("con"+id+"_name").value=names;
      		}
			if(type1 == 162){
	       		sHtml = "";
	       		var idsArray=ids.split(",");
	       		var namesArray=names.split(",");
	       		//var descArray=descs.split(",");
	       		for(var i=0;i<idsArray.length;i++){
	         		if(idsArray[i]!="")
	            		sHtml = sHtml+"<a title='"+ids[i]+"' >"+namesArray[i]+"</a>&nbsp;";
	       		}
				$G("con"+id+"_valuespan").innerHTML = sHtml;
	       		$G("con"+id+"_value").value=doReturnSpanHtml(wuiUtil.getJsonValueByIndex(id1,0));
	       		$G("con"+id+"_name").value=wuiUtil.getJsonValueByIndex(id1,1);
			}
		}else{
			$G("con"+id+"_valuespan").innerHTML ="";
		    $G("con"+id+"_value").value="";
		    $G("con"+id+"_name").value="";
		}
  	}
}
</script>