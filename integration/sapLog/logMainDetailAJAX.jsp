<%@page import="com.weaver.integration.log.LogInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util, com.weaver.integration.datesource.*,com.weaver.integration.log.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<link href="/css/Weaver.css" type=text/css rel=stylesheet>
<style>

	


/* ----------------------------------- ��� ----------------------------------- */
div.tabledata table {
	margin-top:10px;
	border-collapse:collapse;
	border:1px solid #888;
	}

div.tabledata th {
	padding:5px 0 5px 0;
	background-color:#ccc;
	border:1px solid #888;
	}

div.tabledata td {
	vertical-align:text-top;
	padding-top:4px;
	background-color:#efefef;
	border:1px solid #aaa;
	}

div.tabledata ul, div.tabledata li {
	list-style-type:none;
	margin:0;
	padding:0;
	}

div.tabledata td em{
	color:#ff0000;
	font-weight:normal;
	}



table.dataintable {
	font-family:Arial, Helvetica, sans-serif;
	margin-top:10px;
	margin-left:20px;
	margin-right:20px;
	margin-bottom:20px;
	border-collapse:collapse;
	border:1px solid #888;
	width:(100%-40px);
	}

table.dataintable pre {
	width:auto;
	margin:0;
	padding:0;
	border:0;
	background-color:transparent;
	}

table.dataintable th {
	vertical-align:baseline;
	padding:5px 15px 5px 5px;
	background-color:#ccc;
	border:1px solid #888;
	text-align:left;
	}

table.dataintable td {
	vertical-align:text-top;
	padding:5px 15px 5px 5px;
	background-color:#efefef;
	border:1px solid #aaa;
	}


table.dataintable p {margin:0 0 2px 0;}

div#maincontent table.dataintable ul, div#maincontent table.dataintable li {
	list-style-type:none;
	margin:0;
	padding:0;
	}

table.dataintable td em{
	color:#0000ff;
	font-weight:normal;
	}
	
table.dataintable .table_value {color:#0F93D2;}

.no_wrap {white-space:nowrap;}

div#maincontent table.dataintable ul.listintable {
	margin:20px;
	padding:0;
	}

div#maincontent table.dataintable ul.listintable  li{
	list-style-type:disc;
	}
.html5_new_note span {
	color:blue;
	font-weight:bold;
	}

tr.notsupported {
	color:#999999;
	}
</style>
<%
	String logid = Util.null2String(request.getParameter("logid"));
	//������־��id,ȥ����־���������
	LogInfo log=new LogInfo();
	out.println(log.PrintHTMLLogInfo(logid).toString());

	//out.println(log.PrintLogInfo(logid).toString());
	String titlename ="";
	String needhelp="";
	String imagefilename="";
%>

